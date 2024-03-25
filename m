Return-Path: <netdev+bounces-81671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDB388B3EC
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 23:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 634ACB27AAF
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 17:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01DD152521;
	Mon, 25 Mar 2024 15:56:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F78C145B09
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382217; cv=none; b=JGVD0jvsvoo2gEIqRRW4JcnuMckNO9c/PBygbfI7H211Mg6n5KCamRgDAoidNVqTU27aWALpcw95zlN9yt7LJmkjDLiPMXug++vfHDSfcWqfrYta78rIgLux4iS7P5itgfGIHCjSmRd7wr1RAWio6zlo7o89oZeTyShJJS+er+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382217; c=relaxed/simple;
	bh=3fCgQs9DfcQFGyyTd6LAph020I9gclJLp8GepZJLblU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Skt3LRfNzrGmPzoZKGL7QqVPbFx0wrcbCu5V8YNYUlwIyW7VuVuzP/32IkmeEOrJP7YxRpeoEex4zlv3Y89wSLuYf2VUy9BfPLRO7zTAkjsYKLtM86sDyOvSaGZ1hj/5lD4kyJjysqfOGhYWlMLbMHrAWFRdZZ1sgmwxhetpDfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8EA8D20010;
	Mon, 25 Mar 2024 15:56:52 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Vakul Garg <vakul.garg@nxp.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 1/4] tls: recv: process_rx_list shouldn't use an offset with kvec
Date: Mon, 25 Mar 2024 16:56:45 +0100
Message-ID: <e5487514f828e0347d2b92ca40002c62b58af73d.1711120964.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711120964.git.sd@queasysnail.net>
References: <cover.1711120964.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: sd@queasysnail.net

Only MSG_PEEK needs to copy from an offset during the final
process_rx_list call, because the bytes we copied at the beginning of
tls_sw_recvmsg were left on the rx_list. In the KVEC case, we removed
data from the rx_list as we were copying it, so there's no need to use
an offset, just like in the normal case.

Fixes: 692d7b5d1f91 ("tls: Fix recvmsg() to be able to peek across multiple records")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 211f57164cb6..3cdc6bc9fba6 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2152,7 +2152,7 @@ int tls_sw_recvmsg(struct sock *sk,
 		}
 
 		/* Drain records from the rx_list & copy if required */
-		if (is_peek || is_kvec)
+		if (is_peek)
 			err = process_rx_list(ctx, msg, &control, copied + peeked,
 					      decrypted - peeked, is_peek, NULL);
 		else
-- 
2.43.0


