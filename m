Return-Path: <netdev+bounces-223276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22915B588DE
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 02:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00EE81B210F3
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 00:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF7D14885D;
	Tue, 16 Sep 2025 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwFymW/z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5C3129E6E
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 00:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981171; cv=none; b=dy1SSkxsRcQ0ia9uIremFb4ST62ViU8uG2/sm/eKpjldlA+KdbIycguyOKSSuyXsdZwkN7gEEPEy4RN9Zkbx6an4RknzrCYg5wlwr/Y42CamJyAYLcmijsr7iBp6KFsBsay50w/udm9m8dDs1gqbl6ldFxyny8L7C3YLDrCHxVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981171; c=relaxed/simple;
	bh=48KlWY+KPKhwoA7yUGfqOky/wnkiQxDoo2MwVcQM1HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOGj5gfVBNafO29/ejjd02KT9MQ2W4MJsvanJ2dPldNco0by/3WYsSy6Wqce/8/9z1PHAvWQmTkTUml3VSxSE0vgTkhSfOLrEaxNZE3GGr5/H7sV31M6e7xCqXAITgtpYSAlQCdqVRB+pStYXgPExqOEFK5ckzb1CTxFHda9++Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwFymW/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D3AC4CEF9;
	Tue, 16 Sep 2025 00:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981170;
	bh=48KlWY+KPKhwoA7yUGfqOky/wnkiQxDoo2MwVcQM1HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YwFymW/zH4lZlq0qSeTYsEOeZGzUMERIyMpuODkHrIkhLOVWqfz+UD4snrIm7z5q9
	 K1Noq41Mh1N2xjArSliYkH+/i3yQEFQa3Kak6vqSP97NDqp8oJrUVddgXPntlg0O8w
	 4iC4nEdQKm4NqxyxpxN07LP2M57seqz2g7DMObLuBeL++WoFACv4jSNTxxWBNFxh3n
	 JdRFbOXpPs9ARlQYGQGKcrCmoNgnqbUVBPNmumx2DXByVF1U9MPJgPc7o8kQwUKuWN
	 Z7TIH0yuZDN4jkIB9HBOqWr9jj+MYQwE9/2QRtbE/lk5ZiDVAur1dqDldsOco3+S2/
	 3wDfyIVsOjtDQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v12 06/19] net: move sk_validate_xmit_skb() to net/core/dev.c
Date: Mon, 15 Sep 2025 17:05:46 -0700
Message-ID: <20250916000559.1320151-7-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916000559.1320151-1-kuba@kernel.org>
References: <20250916000559.1320151-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Zahka <daniel.zahka@gmail.com>

Move definition of sk_validate_xmit_skb() from net/core/sock.c to
net/core/dev.c.

This change is in preparation of the next patch, where
sk_validate_xmit_skb() will need to cast sk to a tcp_timewait_sock *,
and access member fields. Including linux/tcp.h from linux/sock.h
creates a circular dependency, and dev.c is the only current call site
of this function.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Notes:
    v2:
    - patch introduced in v2
---
 include/net/sock.h | 22 ----------------------
 net/core/dev.c     | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index d1d3d36e39ae..bf92029a88d6 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2960,28 +2960,6 @@ sk_requests_wifi_status(struct sock *sk)
 	return sk && sk_fullsock(sk) && sock_flag(sk, SOCK_WIFI_STATUS);
 }
 
-/* Checks if this SKB belongs to an HW offloaded socket
- * and whether any SW fallbacks are required based on dev.
- * Check decrypted mark in case skb_orphan() cleared socket.
- */
-static inline struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
-						   struct net_device *dev)
-{
-#ifdef CONFIG_SOCK_VALIDATE_XMIT
-	struct sock *sk = skb->sk;
-
-	if (sk && sk_fullsock(sk) && sk->sk_validate_xmit_skb) {
-		skb = sk->sk_validate_xmit_skb(sk, dev, skb);
-	} else if (unlikely(skb_is_decrypted(skb))) {
-		pr_warn_ratelimited("unencrypted skb with no associated socket - dropping\n");
-		kfree_skb(skb);
-		skb = NULL;
-	}
-#endif
-
-	return skb;
-}
-
 /* This helper checks if a socket is a LISTEN or NEW_SYN_RECV
  * SYNACK messages can be attached to either ones (depending on SYNCOOKIE)
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index 2522d9d8f0e4..384e59d7e715 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3907,6 +3907,28 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 }
 EXPORT_SYMBOL(skb_csum_hwoffload_help);
 
+/* Checks if this SKB belongs to an HW offloaded socket
+ * and whether any SW fallbacks are required based on dev.
+ * Check decrypted mark in case skb_orphan() cleared socket.
+ */
+static struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
+					    struct net_device *dev)
+{
+#ifdef CONFIG_SOCK_VALIDATE_XMIT
+	struct sock *sk = skb->sk;
+
+	if (sk && sk_fullsock(sk) && sk->sk_validate_xmit_skb) {
+		skb = sk->sk_validate_xmit_skb(sk, dev, skb);
+	} else if (unlikely(skb_is_decrypted(skb))) {
+		pr_warn_ratelimited("unencrypted skb with no associated socket - dropping\n");
+		kfree_skb(skb);
+		skb = NULL;
+	}
+#endif
+
+	return skb;
+}
+
 static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 						    struct net_device *dev)
 {
-- 
2.51.0


