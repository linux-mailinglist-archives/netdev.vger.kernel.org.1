Return-Path: <netdev+bounces-179883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A22D7A7ECE6
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3E9420ADF
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FAB254865;
	Mon,  7 Apr 2025 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="KDfXqTAF"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBFB254851;
	Mon,  7 Apr 2025 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052550; cv=none; b=rZ49V1jcVeSM/yyUDXk9bMbhapUVDqd1b3PQDbTnbvzP/FScJTlgdqQXyAxJa7aGmURh3a1VoKhgVllOqa53b8zgOWoxDgJ8njF3v51o2a5bN+yjT2NuJHZYPTPrs6Wws/SU97R3oRJrqOwt8cCfUZ0rqzZ4T8hX0U/2wrUCV2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052550; c=relaxed/simple;
	bh=yC6QZ/8jVM9KGam6L49RetYOUxCetakx6TQbeX39JKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VNMReDrugZb030ydyausKPYeNsCPWRRRQHX3q5rJMj9sEBKOLFFaCovQN1yiYsy3zff8tMEo96ugX62aeylFQ4qDV4NEFeHIyPO0q85JFWe7LJVqURPGWwYuP6oISQVHW2c+sVZtvs4yui4tgyIXxuBwsXZ7p8HOz7fyMJbc8tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=KDfXqTAF; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u1rjh-00Cluc-P9; Mon, 07 Apr 2025 21:02:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From;
	bh=KVp3ZQyloTuaLdQygQMAf/QKWBZdcAiGhMuu41ke8zs=; b=KDfXqTAFYtd1CycSD/yrGuxMFd
	6keGPaUtFoWvl1mnGl64rwW2xmdVb7Jjvilc4nYtxokgHygmeNSsPOTcmRdTf0Q3+4ZvG0zOWixBt
	4+bPlFYCbLfJiC7cKpQzmxVgaf4Ga0DBvwGTRb0zltTq14WNLfjYlxWGhTjCDs9LYFyC0ncsUSwiz
	M4OoB89KuKrIpIxQrQKMut4BklWnSAEAhl1RHHIm8GZpikTon2f3hc1PtMcfZlZivfCxIOyqNUG9x
	sRnGtJPf53QrRA44sjiKqF8jRKXhvRU9W5uJ0XGJldRL+doLZdtkLsPKHdTwEKrQgG2ged0FR8JWH
	61quWWHw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u1rjg-0001CO-MP; Mon, 07 Apr 2025 21:02:20 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u1rjN-009Ivh-O1; Mon, 07 Apr 2025 21:02:01 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 07 Apr 2025 21:01:02 +0200
Subject: [PATCH net-next] net: Drop unused @sk of
 __skb_try_recv_from_queue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-cleanup-drop-param-sk-v1-1-cd076979afac@rbox.co>
X-B4-Tracking: v=1; b=H4sIAO0g9GcC/x3MQQqDMBBA0avIrDuQhkTQq5QuQjLq0DqGiZaAe
 PcGl2/x/wmFlKnA2J2g9OPCmzQ8Hx3EJchMyKkZrLHeONNj/FKQI2PSLWMOGlYsHxyi9a53yQ/
 RQ2uz0sT1/r5AaEehusP7uv69hwFQcQAAAA==
X-Change-ID: 20250406-cleanup-drop-param-sk-9c25464d59c5
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

__skb_try_recv_from_queue() deals with a queue, @sk is never used.
Remove sk from function parameters, adapt callers.

No functional change intended.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 include/linux/skbuff.h | 3 +--
 net/core/datagram.c    | 5 ++---
 net/ipv4/udp.c         | 8 ++++----
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b974a277975a8a7b6f40c362542e9e8522539009..f1381aff0f896220b2b6bc706aaca17b8f28fd8b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4105,8 +4105,7 @@ static inline void skb_frag_list_init(struct sk_buff *skb)
 int __skb_wait_for_more_packets(struct sock *sk, struct sk_buff_head *queue,
 				int *err, long *timeo_p,
 				const struct sk_buff *skb);
-struct sk_buff *__skb_try_recv_from_queue(struct sock *sk,
-					  struct sk_buff_head *queue,
+struct sk_buff *__skb_try_recv_from_queue(struct sk_buff_head *queue,
 					  unsigned int flags,
 					  int *off, int *err,
 					  struct sk_buff **last);
diff --git a/net/core/datagram.c b/net/core/datagram.c
index f0693707aece46bb5ffd2143a0773d54c234999c..f0634f0cb8346d69923f65183dbdf000b6993cf9 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -163,8 +163,7 @@ static struct sk_buff *skb_set_peeked(struct sk_buff *skb)
 	return skb;
 }
 
-struct sk_buff *__skb_try_recv_from_queue(struct sock *sk,
-					  struct sk_buff_head *queue,
+struct sk_buff *__skb_try_recv_from_queue(struct sk_buff_head *queue,
 					  unsigned int flags,
 					  int *off, int *err,
 					  struct sk_buff **last)
@@ -261,7 +260,7 @@ struct sk_buff *__skb_try_recv_datagram(struct sock *sk,
 		 * However, this function was correct in any case. 8)
 		 */
 		spin_lock_irqsave(&queue->lock, cpu_flags);
-		skb = __skb_try_recv_from_queue(sk, queue, flags, off, &error,
+		skb = __skb_try_recv_from_queue(queue, flags, off, &error,
 						last);
 		spin_unlock_irqrestore(&queue->lock, cpu_flags);
 		if (error)
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 2742cc7602bb58535e8ef217d9ffc3fea7ff9297..1696cc5a2dcdc4f9c40c65b4d61c722a1cd9ca9a 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1942,8 +1942,8 @@ struct sk_buff *__skb_recv_udp(struct sock *sk, unsigned int flags,
 		error = -EAGAIN;
 		do {
 			spin_lock_bh(&queue->lock);
-			skb = __skb_try_recv_from_queue(sk, queue, flags, off,
-							err, &last);
+			skb = __skb_try_recv_from_queue(queue, flags, off, err,
+							&last);
 			if (skb) {
 				if (!(flags & MSG_PEEK))
 					udp_skb_destructor(sk, skb);
@@ -1964,8 +1964,8 @@ struct sk_buff *__skb_recv_udp(struct sock *sk, unsigned int flags,
 			spin_lock(&sk_queue->lock);
 			skb_queue_splice_tail_init(sk_queue, queue);
 
-			skb = __skb_try_recv_from_queue(sk, queue, flags, off,
-							err, &last);
+			skb = __skb_try_recv_from_queue(queue, flags, off, err,
+							&last);
 			if (skb && !(flags & MSG_PEEK))
 				udp_skb_dtor_locked(sk, skb);
 			spin_unlock(&sk_queue->lock);

---
base-commit: 61f96e684edd28ca40555ec49ea1555df31ba619
change-id: 20250406-cleanup-drop-param-sk-9c25464d59c5

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


