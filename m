Return-Path: <netdev+bounces-75922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FE086BADE
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 23:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9074A28A1AF
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 22:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1A71361D0;
	Wed, 28 Feb 2024 22:44:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CFA72901
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709160264; cv=none; b=mPD0GqfSRAIGQWWp4jgzMqSyMqdKhe0p5qh50BHXi+z9YNNcUhZHQKLoYLPaxZdjNpx6tTpr/gvX7MYOa5DgplpGU3l59ONb2xP9ytLkYGYbp6cKS0o34kktSgrTMJtXQ9v4g9cNZOSoN+8FOlSAGaOMtwFDSp9kOKjJXpEA4pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709160264; c=relaxed/simple;
	bh=9ANgazVXWP2XssNvo+LtG4lvng3Sqtk5tBbhNztdISU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dz7r6uWGdSJu6LcQdDHWPcopLerczqCF4mmnBiVn1BiomFtfJzN74If/5G3/fDMNdOQQoBSuC5jHReNtoTalAJeSfF6quHGPIVcIaIPfMEUlY4IS5aDF1z+zmWJnvOnw+8MD9L/f0ywut5tCZGNW2xm17NcJFSSF4pzOMgBqMFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA9A220003;
	Wed, 28 Feb 2024 22:44:13 +0000 (UTC)
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
Subject: [PATCH net 4/4] tls: fix use-after-free on failed backlog decryption
Date: Wed, 28 Feb 2024 23:44:00 +0100
Message-ID: <4755dd8d9bebdefaa19ce1439b833d6199d4364c.1709132643.git.sd@queasysnail.net>
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

When the decrypt request goes to the backlog and crypto_aead_decrypt
returns -EBUSY, tls_do_decryption will wait until all async
decryptions have completed. If one of them fails, tls_do_decryption
will return -EBADMSG and tls_decrypt_sg jumps to the error path,
releasing all the pages. But the pages have been passed to the async
callback, and have already been released by tls_decrypt_done.

The only true async case is when crypto_aead_decrypt returns
 -EINPROGRESS. With -EBUSY, we already waited so we can tell
tls_sw_recvmsg that the data is available for immediate copy, but we
need to notify tls_decrypt_sg (via the new ->async_done flag) that the
memory has already been released.

Fixes: 859054147318 ("net: tls: handle backlogging of crypto requests")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 1fd37fe13ffd..211f57164cb6 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -52,6 +52,7 @@ struct tls_decrypt_arg {
 	struct_group(inargs,
 	bool zc;
 	bool async;
+	bool async_done;
 	u8 tail;
 	);
 
@@ -286,15 +287,18 @@ static int tls_do_decryption(struct sock *sk,
 	}
 
 	ret = crypto_aead_decrypt(aead_req);
+	if (ret == -EINPROGRESS)
+		return 0;
+
 	if (ret == -EBUSY) {
 		ret = tls_decrypt_async_wait(ctx);
-		ret = ret ?: -EINPROGRESS;
-	}
-	if (ret == -EINPROGRESS) {
-		return 0;
-	} else if (darg->async) {
-		atomic_dec(&ctx->decrypt_pending);
+		darg->async_done = true;
+		/* all completions have run, we're not doing async anymore */
+		darg->async = false;
+		return ret;
 	}
+
+	atomic_dec(&ctx->decrypt_pending);
 	darg->async = false;
 
 	return ret;
@@ -1593,8 +1597,11 @@ static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
 	/* Prepare and submit AEAD request */
 	err = tls_do_decryption(sk, sgin, sgout, dctx->iv,
 				data_len + prot->tail_size, aead_req, darg);
-	if (err)
+	if (err) {
+		if (darg->async_done)
+			goto exit_free_skb;
 		goto exit_free_pages;
+	}
 
 	darg->skb = clear_skb ?: tls_strp_msg(ctx);
 	clear_skb = NULL;
@@ -1606,6 +1613,9 @@ static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
 		return err;
 	}
 
+	if (unlikely(darg->async_done))
+		return 0;
+
 	if (prot->tail_size)
 		darg->tail = dctx->tail;
 
-- 
2.43.0


