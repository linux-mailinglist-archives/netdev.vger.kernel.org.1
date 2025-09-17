Return-Path: <netdev+bounces-223822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBACB7CB80
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC557ACA24
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 00:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5641C3BFC;
	Wed, 17 Sep 2025 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvfaQz+I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989AE4690
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758068906; cv=none; b=qcFSi6aNMBLvaFRcaDZQETuyflI2WAz3ljTIYtOz/6Y3Ns1Eb0WVJ3w4ovjK6Xf51t42niA6MuMtz55tLGVpFn+oCFFSCLW19EmSgX4CVfiiwRIbMFehGUSHiAzZfpXMbB5TfSdSVOGJkW6M6p6F7p43u26hxck5uzGbVtH4j20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758068906; c=relaxed/simple;
	bh=T1PIszi+YTHqO7etmgQ6qJ4lrOnKjYFy0ISsZ/7AyeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oP6BD/1KqRtyhSpPmUXDfuhTOG+wT8atGssd289eD5Cke3JeN5FQbYkU+69A9BZa24fmb+b3k5Xy2zSt670JyfP3tfCK5iv6xAKYrJIdYBJGIcDocc9eyS9tf11ewqqjwqFEfD0vlLpIab5G3OFzJIzKC+Hc7McnK1kZqqZnXjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvfaQz+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF68C4CEEB;
	Wed, 17 Sep 2025 00:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758068906;
	bh=T1PIszi+YTHqO7etmgQ6qJ4lrOnKjYFy0ISsZ/7AyeU=;
	h=From:To:Cc:Subject:Date:From;
	b=uvfaQz+IAtrpDEQmLVXkpJA3O5LiYB1o3xorEA2iDS6zSZ2rmzuX8ITtdQy3u/tW1
	 zP+w4IRc9Bzt1teCBy2VQSqABYHuBOtJmmPk/PBTreccR5Vc5U4Zunpg4n57Aj1ZSa
	 ly97Aye9AnHgacpH07Y2JZzPTw6Y6cRsDW+SPMIas6yZHu2QVUmzPPAj2s/bfrRdab
	 qrGtrkPic2DiriOgewcEZMvDvzDeBFV6SjIwwKn9tBHIPIQ/KgNaNcYXbTopClJ2Op
	 zCQZbMcgkQxlpwBtQuC+VdZMdhzjI8S2xIB3Cm6y3DsdFNTMtU9BGQTpNYC97F8eDW
	 L0vcPPa681FnQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net 1/2] tls: make sure to abort the stream if headers are bogus
Date: Tue, 16 Sep 2025 17:28:13 -0700
Message-ID: <20250917002814.1743558-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Normally we wait for the socket to buffer up the whole record
before we service it. If the socket has a tiny buffer, however,
we read out the data sooner, to prevent connection stalls.
Make sure that we abort the connection when we find out late
that the record is actually invalid. Retrying the parsing is
fine in itself but since we copy some more data each time
before we parse we can overflow the allocated skb space.

Constructing a scenario in which we're under pressure without
enough data in the socket to parse the length upfront is quite
hard. syzbot figured out a way to do this by serving us the header
in small OOB sends, and then filling in the recvbuf with a large
normal send.

Make sure that tls_rx_msg_size() aborts strp, if we reach
an invalid record there's really no way to recover.

Reported-by: Lee Jones <lee@kernel.org>
Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/tls/tls.h      |  1 +
 net/tls/tls_strp.c | 14 +++++++++-----
 net/tls/tls_sw.c   |  3 +--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 4e077068e6d9..e4c42731ce39 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -141,6 +141,7 @@ void update_sk_prot(struct sock *sk, struct tls_context *ctx);
 
 int wait_on_pending_writer(struct sock *sk, long *timeo);
 void tls_err_abort(struct sock *sk, int err);
+void tls_strp_abort_strp(struct tls_strparser *strp, int err);
 
 int init_prot_info(struct tls_prot_info *prot,
 		   const struct tls_crypto_info *crypto_info,
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index d71643b494a1..98e12f0ff57e 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -13,7 +13,7 @@
 
 static struct workqueue_struct *tls_strp_wq;
 
-static void tls_strp_abort_strp(struct tls_strparser *strp, int err)
+void tls_strp_abort_strp(struct tls_strparser *strp, int err)
 {
 	if (strp->stopped)
 		return;
@@ -211,11 +211,17 @@ static int tls_strp_copyin_frag(struct tls_strparser *strp, struct sk_buff *skb,
 				struct sk_buff *in_skb, unsigned int offset,
 				size_t in_len)
 {
+	unsigned int nfrag = skb->len / PAGE_SIZE;
 	size_t len, chunk;
 	skb_frag_t *frag;
 	int sz;
 
-	frag = &skb_shinfo(skb)->frags[skb->len / PAGE_SIZE];
+	if (unlikely(nfrag >= skb_shinfo(skb)->nr_frags)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EMSGSIZE;
+	}
+
+	frag = &skb_shinfo(skb)->frags[nfrag];
 
 	len = in_len;
 	/* First make sure we got the header */
@@ -520,10 +526,8 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 	tls_strp_load_anchor_with_queue(strp, inq);
 	if (!strp->stm.full_len) {
 		sz = tls_rx_msg_size(strp, strp->anchor);
-		if (sz < 0) {
-			tls_strp_abort_strp(strp, sz);
+		if (sz < 0)
 			return sz;
-		}
 
 		strp->stm.full_len = sz;
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index bac65d0d4e3e..daac9fd4be7e 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2474,8 +2474,7 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 	return data_len + TLS_HEADER_SIZE;
 
 read_failure:
-	tls_err_abort(strp->sk, ret);
-
+	tls_strp_abort_strp(strp, ret);
 	return ret;
 }
 
-- 
2.51.0


