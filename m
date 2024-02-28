Return-Path: <netdev+bounces-75921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A8A86BADD
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 23:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095C61C20CD5
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 22:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EF572938;
	Wed, 28 Feb 2024 22:44:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A021772912
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160262; cv=none; b=DGHQlk+GwzIz9ofzr6fSiTAppH2rOB2yF2ZhgG+FY48BADIgLrqgJCi23rIuPyCsDuIMUDJcbsNd12b0PFLNIb2J72cIb/gtBL1osgsYDVrhxZGkguGLA/sdXaOzBfS5oVU8/+OdhuJasEM5r/asSnfpjJQyRTtiuYNYYSgjRq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160262; c=relaxed/simple;
	bh=Ivv/VMkheM85qHuo7+Ni2+JWwSFOptDdbD1BWvadJrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aruxK8rLLSYG6o2TmfR+XWLPgOs+ktc2xAZuCpuvAfNT+b1zCFBOHrkeFipHvsLXTnY8KikG8w5bHGwF0Js85u94z3fF/tXw3xqejxznHcKeIwB55EqjSRsTatULfgGboMZ4BDNfnbphJLkDdMzhXevTzXrp+kplM3DCewppV38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F18B20008;
	Wed, 28 Feb 2024 22:44:12 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Vakul Garg <vakul.garg@nxp.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 3/4] tls: separate no-async decryption request handling from async
Date: Wed, 28 Feb 2024 23:43:59 +0100
Message-ID: <47bde5f649707610eaef9f0d679519966fc31061.1709132643.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709132643.git.sd@queasysnail.net>
References: <cover.1709132643.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: sd@queasysnail.net

If we're not doing async, the handling is much simpler. There's no
reference counting, we just need to wait for the completion to wake us
up and return its result.

We should preferably also use a separate crypto_wait. I'm not seeing a
UAF as I did in the past, I think aec7961916f3 ("tls: fix race between
async notify and socket close") took care of it.

This will make the next fix easier.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 1394fc44f378..1fd37fe13ffd 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -274,9 +274,15 @@ static int tls_do_decryption(struct sock *sk,
 		DEBUG_NET_WARN_ON_ONCE(atomic_read(&ctx->decrypt_pending) < 1);
 		atomic_inc(&ctx->decrypt_pending);
 	} else {
+		DECLARE_CRYPTO_WAIT(wait);
+
 		aead_request_set_callback(aead_req,
 					  CRYPTO_TFM_REQ_MAY_BACKLOG,
-					  crypto_req_done, &ctx->async_wait);
+					  crypto_req_done, &wait);
+		ret = crypto_aead_decrypt(aead_req);
+		if (ret == -EINPROGRESS || ret == -EBUSY)
+			ret = crypto_wait_req(ret, &wait);
+		return ret;
 	}
 
 	ret = crypto_aead_decrypt(aead_req);
@@ -285,10 +291,7 @@ static int tls_do_decryption(struct sock *sk,
 		ret = ret ?: -EINPROGRESS;
 	}
 	if (ret == -EINPROGRESS) {
-		if (darg->async)
-			return 0;
-
-		ret = crypto_wait_req(ret, &ctx->async_wait);
+		return 0;
 	} else if (darg->async) {
 		atomic_dec(&ctx->decrypt_pending);
 	}
-- 
2.43.0


