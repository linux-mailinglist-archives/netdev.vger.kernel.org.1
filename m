Return-Path: <netdev+bounces-200556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06993AE6189
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F75A1692E5
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D283E27C863;
	Tue, 24 Jun 2025 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="xt71S8gt"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6472827BF85
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750758867; cv=none; b=oXGoY2AzfdOG/maxSmp/FqaQY0Tvcn6JFGAqwxGvrvZ9RQfXynII+frMYKQvT8cY2tErfP0333IDC3EjCrgxlWP2kXD+0PfL5vpg7XFchw1W+M+DhW2+gyQUdJKPOTp6vi0FSArLWvAA/XkYlfq4idaQlM61HN1Ry9HOSoug7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750758867; c=relaxed/simple;
	bh=YkSJAchSnplblmjmNW1QuIBtZ+gkx1rwgG4dfph7N8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nAwWM8yRsITpFgISKWYtvYpe0WFb9z9rfr2kvt5KXss83UMw92ssYscUwqqOx++5LVpjYIRytnfwGxkXtfSHlZnmqaT5tbQlwlmvdSVgzPWl/Pl95jNJ7Y2wNFQ7YeeEQqZdSu9lUVg7RgJXV1K54rsKmMCExCaH2fkCOnrPtuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=xt71S8gt; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uU0M4-00AXZs-NI; Tue, 24 Jun 2025 11:54:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=CtUXrOvQS+uOEQrz+hc+DMhDAzJ1ls9rbIP6D6uIV+8=; b=xt71S8gtFAvwQRksx9PcG5dgJE
	45E49OWXJSEhzCGNwd+RCsFBu8qp7oYshEmLbtvPxsSAaP6L5QAz0d+10sRVIUboEvxzj1kJV/h7z
	eL/Ao2hQcDgEfhJ2dq+nuDAhXQeNbqzWZHf1asBjrHFOpMO+zmDOVDklJd8HW1MBVU0yWiFq1k5KQ
	zXKeJJ2ghqX4LzQwfQPsrcvq6BTYYXrJuUJq60M8p2kbuKTZOAXhN8jFcWQ3caFTtNCdtbh3p2A5a
	pmCY/Mg2hstHAguDM7us07xXWU9VF2gm8qTPuX36FcnZerjFR6sE/rT2azJUEf6R2hmy8Brvi9K1w
	bESxyKMw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uU0M4-0005uX-CI; Tue, 24 Jun 2025 11:54:16 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uU0Ll-00FYQf-W3; Tue, 24 Jun 2025 11:53:58 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 24 Jun 2025 11:53:52 +0200
Subject: [PATCH net-next 5/7] net: splice: Drop unused @gfp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-splice-drop-unused-v1-5-cf641a676d04@rbox.co>
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

Since its introduction in commit 2e910b95329c ("net: Add a function to
splice pages into an skbuff for MSG_SPLICE_PAGES"), skb_splice_from_iter()
never used the @gfp argument. Remove it and adapt callers.

No functional change intended.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c | 3 +--
 include/linux/skbuff.h                                      | 2 +-
 net/core/skbuff.c                                           | 3 +--
 net/ipv4/ip_output.c                                        | 3 +--
 net/ipv4/tcp.c                                              | 3 +--
 net/ipv6/ip6_output.c                                       | 3 +--
 net/kcm/kcmsock.c                                           | 3 +--
 net/unix/af_unix.c                                          | 3 +--
 8 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
index d567e42e176011d42b9549d0cc6292a06126d61d..465fa807796439b90c949f54e203a798f06acf1f 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
@@ -1096,8 +1096,7 @@ int chtls_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			copy = size;
 
 		if (msg->msg_flags & MSG_SPLICE_PAGES) {
-			err = skb_splice_from_iter(skb, &msg->msg_iter, copy,
-						   sk->sk_allocation);
+			err = skb_splice_from_iter(skb, &msg->msg_iter, copy);
 			if (err < 0) {
 				if (err == -EMSGSIZE)
 					goto new_buf;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 5b6f460c69b277124e788cfa0599486522e62c9c..4952a6991c720a5001477a77d252567aa2c15ac2 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5264,7 +5264,7 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
 }
 
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
-			     ssize_t maxsize, gfp_t gfp);
+			     ssize_t maxsize);
 
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_SKBUFF_H */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 02ead44a82bb71d30d294a6931943d07cf7c7177..c381a097aa6e087d1b5934f2d193a896a255bf83 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7229,7 +7229,6 @@ static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
  * @skb: The buffer to add pages to
  * @iter: Iterator representing the pages to be added
  * @maxsize: Maximum amount of pages to be added
- * @gfp: Allocation flags
  *
  * This is a common helper function for supporting MSG_SPLICE_PAGES.  It
  * extracts pages from an iterator and adds them to the socket buffer if
@@ -7240,7 +7239,7 @@ static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
  * insufficient space in the buffer to transfer anything.
  */
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
-			     ssize_t maxsize, gfp_t gfp)
+			     ssize_t maxsize)
 {
 	size_t frag_limit = READ_ONCE(net_hotdata.sysctl_max_skb_frags);
 	struct page *pages[8], **ppages = pages;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a2705d454fd645b442b2901833afa51b26512512..5d75d60efcf361ed9c3b34eaa982f6c667c716f6 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1222,8 +1222,7 @@ static int __ip_append_data(struct sock *sk,
 			if (WARN_ON_ONCE(copy > msg->msg_iter.count))
 				goto error;
 
-			err = skb_splice_from_iter(skb, &msg->msg_iter, copy,
-						   sk->sk_allocation);
+			err = skb_splice_from_iter(skb, &msg->msg_iter, copy);
 			if (err < 0)
 				goto error;
 			copy = err;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b6285fb1369d32541b9f7d660ca33389b7e4da61..9d41113e3a68455f3cc7e067d72f3aa2485a21f2 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1295,8 +1295,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			if (!copy)
 				goto wait_for_space;
 
-			err = skb_splice_from_iter(skb, &msg->msg_iter, copy,
-						   sk->sk_allocation);
+			err = skb_splice_from_iter(skb, &msg->msg_iter, copy);
 			if (err < 0) {
 				if (err == -EMSGSIZE) {
 					tcp_mark_push(tp, skb);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7bd29a9ff0db8d74c79f50afa5c693231e0f82d5..618ed7d72b28f43ab6d7a02e5f8f53a4d22de87a 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1760,8 +1760,7 @@ static int __ip6_append_data(struct sock *sk,
 			if (WARN_ON_ONCE(copy > msg->msg_iter.count))
 				goto error;
 
-			err = skb_splice_from_iter(skb, &msg->msg_iter, copy,
-						   sk->sk_allocation);
+			err = skb_splice_from_iter(skb, &msg->msg_iter, copy);
 			if (err < 0)
 				goto error;
 			copy = err;
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 8140c9c9cc2cb7aa71eaceab8a019d882bc454aa..71fedf9cfac85b7cbcd8fd3dbacd74440fa556f4 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -835,8 +835,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 			if (!sk_wmem_schedule(sk, copy))
 				goto wait_for_memory;
 
-			err = skb_splice_from_iter(skb, &msg->msg_iter, copy,
-						   sk->sk_allocation);
+			err = skb_splice_from_iter(skb, &msg->msg_iter, copy);
 			if (err < 0) {
 				if (err == -EMSGSIZE)
 					goto wait_for_memory;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 1e3a4db1a96a57c84c199e30c164f66409b04be4..c2d1a547b14650b53d16c18f239aeb7c5f50cc96 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2377,8 +2377,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 		if (unlikely(msg->msg_flags & MSG_SPLICE_PAGES)) {
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
-			err = skb_splice_from_iter(skb, &msg->msg_iter, size,
-						   sk->sk_allocation);
+			err = skb_splice_from_iter(skb, &msg->msg_iter, size);
 			if (err < 0)
 				goto out_free;
 

-- 
2.49.0


