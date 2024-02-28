Return-Path: <netdev+bounces-75919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 096C886BADB
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 23:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB831C21560
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 22:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEE07291A;
	Wed, 28 Feb 2024 22:44:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41D571EAA
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160261; cv=none; b=U3dF0WMnJqhfKxUuwZOEqdFkdJdTuzyBea1etwiEPeHuErdPWD6pW+NeCHrxy7fQUJg4AapR/il9qdHK7WowdD7bs6HX92dtog5X01Eb5GhzYpxg8pgZObjHfiqx+brHKUvsC5+KyP5vvFeoxqkNRzp8cYkqO7PgMdG98C2sHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160261; c=relaxed/simple;
	bh=ZsxQLJQrZ8uDB93uv1ZDKmBLdOCzLKwtRoRXtVRcgP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PY0ONi+cuAoxtiH1BylN2G/gjAganKrD9zQ4xkevrw/srRkFejAO3GUZK4q7PnGVVH5n5Qp3SgMOlLnnMLg3O4nudc9thdx+2zyYPr3qzAE9wmFsT/NoIl+TQti8wfPc2zllxGRDzIY6OfQv3PHoHzJl6nayzWKhEOAa4aRR+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F6F920005;
	Wed, 28 Feb 2024 22:44:10 +0000 (UTC)
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
Subject: [PATCH net 1/4] tls: decrement decrypt_pending if no async completion will be called
Date: Wed, 28 Feb 2024 23:43:57 +0100
Message-ID: <c56d5fc35543891d5319f834f25622360e1bfbec.1709132643.git.sd@queasysnail.net>
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

With mixed sync/async decryption, or failures of crypto_aead_decrypt,
we increment decrypt_pending but we never do the corresponding
decrement since tls_decrypt_done will not be called. In this case, we
should decrement decrypt_pending immediately to avoid getting stuck.

For example, the prequeue prequeue test gets stuck with mixed
modes (one async decrypt + one sync decrypt).

Fixes: 94524d8fc965 ("net/tls: Add support for async decryption of tls records")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index de96959336c4..9f23ba321efe 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -289,6 +289,8 @@ static int tls_do_decryption(struct sock *sk,
 			return 0;
 
 		ret = crypto_wait_req(ret, &ctx->async_wait);
+	} else if (darg->async) {
+		atomic_dec(&ctx->decrypt_pending);
 	}
 	darg->async = false;
 
-- 
2.43.0


