Return-Path: <netdev+bounces-200562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4807BAE6195
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3531648A7
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4532228BA9A;
	Tue, 24 Jun 2025 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="bYS8kWIn"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE1F27BF99;
	Tue, 24 Jun 2025 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750758876; cv=none; b=LWcXK/TJqV6jp+zxJExf1nSjEcVQujleoyTsHc+U1vTcKMeUHAe7AhSr8zjnMBl9/qv9FghkBH03gBJmUm/LRcouFrQaaCU4IHhtUEAFI2mWBciehpabjKB8/xHmKOjldcUBf4v5wbMAjDFOMtu7ssYq7zT9AmFaTZvEX1sy0qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750758876; c=relaxed/simple;
	bh=NtVtPSnfmcqyvPXKHdJgJTnAm+CocfkvUDIpNBmxqGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FK+w9rbsQO5m1JBO0AfWpb4WuKk+4Ho3eja7Uw0JfxlMrkna4b9YM0vlFZTD31Ibqil5bNQsaTe/0NoeEJfZMFobemmtiUH20+Xd9RpyOGhmYf7H8RQiWZlX4uQroF0AaOU12obS0bKTJvTk8ueltJ5VdPrTkImaFrUZj4SOZ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=bYS8kWIn; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uU0MC-00AvZZ-2L; Tue, 24 Jun 2025 11:54:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=e7/5TI5d9YvE+jrVsgk09V5daUExdC5vGTySPclMLNo=; b=bYS8kWInn7m4YCIfocC0CAWHFt
	izIIDT8HmJWIx3R9fkh2r7OTEUReBtTK2HHn9OrOvyxHZYK5TmpNWacR3GHFRoC5Wig8dwdqc58ZF
	CoP6/5rwYRonL4Mdl9H5k8gur8ut+SqzARpC/LDaYrzn/R7fx90qH9zYAeL9ptGCgI0JH3RNRLJus
	ZYcOXuGweAIGk7f3Lp+1P8mKwqhoBupIWA7V8Vy8nYr8rp6fZE62gTxcdm96AQ8TR9OqKlLxliGws
	Jiut3lvSIY4crRwfVMJAGq6QxYwXgcCxp9ve9slwdROm+dg/9UYOzirOfAPnM4yWjKYvR812V5vMc
	fcrG0ObQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uU0MB-0002ZL-Kd; Tue, 24 Jun 2025 11:54:23 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uU0Lk-00FYQf-0J; Tue, 24 Jun 2025 11:53:56 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 24 Jun 2025 11:53:49 +0200
Subject: [PATCH net-next 2/7] net: splice: Drop unused @flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-splice-drop-unused-v1-2-cf641a676d04@rbox.co>
References: <20250624-splice-drop-unused-v1-0-cf641a676d04@rbox.co>
In-Reply-To: <20250624-splice-drop-unused-v1-0-cf641a676d04@rbox.co>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Since commit 79fddc4efd5d ("new helper: add_to_pipe()") which removed
`spd->flags` check in splice_to_pipe(), skb_splice_bits() does not use the
@flags argument.

Remove it and adapt callers. No functional change intended.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 include/linux/skbuff.h | 3 +--
 net/core/skbuff.c      | 3 +--
 net/ipv4/tcp.c         | 2 +-
 net/kcm/kcmsock.c      | 2 +-
 net/tls/tls_sw.c       | 2 +-
 net/unix/af_unix.c     | 2 +-
 6 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4f6dcb37bae8ada524a1e8f8de44c259cfac695b..5b6f460c69b277124e788cfa0599486522e62c9c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4157,8 +4157,7 @@ int skb_store_bits(struct sk_buff *skb, int offset, const void *from, int len);
 __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset, u8 *to,
 			      int len);
 int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
-		    struct pipe_inode_info *pipe, unsigned int len,
-		    unsigned int flags);
+		    struct pipe_inode_info *pipe, unsigned int len);
 int skb_send_sock_locked(struct sock *sk, struct sk_buff *skb, int offset,
 			 int len);
 int skb_send_sock_locked_with_flags(struct sock *sk, struct sk_buff *skb,
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ae0f1aae3c91d914020c64e0703732b9c6cd8511..02ead44a82bb71d30d294a6931943d07cf7c7177 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3181,8 +3181,7 @@ static bool __skb_splice_bits(struct sk_buff *skb, struct pipe_inode_info *pipe,
  * the fragments, and the frag list.
  */
 int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
-		    struct pipe_inode_info *pipe, unsigned int tlen,
-		    unsigned int flags)
+		    struct pipe_inode_info *pipe, unsigned int tlen)
 {
 	struct partial_page partial[MAX_SKB_FRAGS];
 	struct page *pages[MAX_SKB_FRAGS];
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8a3c99246d2ed32ba45849b56830bf128e265763..46997793d87ab40dcd1e1dd041e4641e287e1b7e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -766,7 +766,7 @@ static int tcp_splice_data_recv(read_descriptor_t *rd_desc, struct sk_buff *skb,
 	int ret;
 
 	ret = skb_splice_bits(skb, skb->sk, offset, tss->pipe,
-			      min(rd_desc->count, len), tss->flags);
+			      min(rd_desc->count, len));
 	if (ret > 0)
 		rd_desc->count -= ret;
 	return ret;
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 24aec295a51cf737912f1aefe81556bd9f23331e..8140c9c9cc2cb7aa71eaceab8a019d882bc454aa 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1043,7 +1043,7 @@ static ssize_t kcm_splice_read(struct socket *sock, loff_t *ppos,
 	if (len > stm->full_len)
 		len = stm->full_len;
 
-	copied = skb_splice_bits(skb, sk, stm->offset, pipe, len, flags);
+	copied = skb_splice_bits(skb, sk, stm->offset, pipe, len);
 	if (copied < 0) {
 		err = copied;
 		goto err_out;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index fc88e34b7f33fefed8aa3c26e1f6eed07cd20853..5bca6cfce749aa9fd64da764b2a0d6a4c936efac 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2266,7 +2266,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	}
 
 	chunk = min_t(unsigned int, rxm->full_len, len);
-	copied = skb_splice_bits(skb, sk, rxm->offset, pipe, chunk, flags);
+	copied = skb_splice_bits(skb, sk, rxm->offset, pipe, chunk);
 	if (copied < 0)
 		goto splice_requeue;
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 1e320f89168d1cd4b5e8fa56565cce9f008ab857..235319a045a1238cf27791dfefa9e61b4a593551 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3070,7 +3070,7 @@ static int unix_stream_splice_actor(struct sk_buff *skb,
 {
 	return skb_splice_bits(skb, state->socket->sk,
 			       UNIXCB(skb).consumed + skip,
-			       state->pipe, chunk, state->splice_flags);
+			       state->pipe, chunk);
 }
 
 static ssize_t unix_stream_splice_read(struct socket *sock,  loff_t *ppos,

-- 
2.49.0


