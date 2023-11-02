Return-Path: <netdev+bounces-45664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B467DECE9
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 07:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB4E281AE1
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 06:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFCA53B5;
	Thu,  2 Nov 2023 06:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE545250
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 06:37:03 +0000 (UTC)
Received: from njjs-sys-mailin01.njjs.baidu.com (mx314.baidu.com [180.101.52.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08A241A3
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 23:36:53 -0700 (PDT)
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 286017F0003D
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 14:28:36 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: netdev@vger.kernel.org
Subject: [PATCH 1/2][net-next] skbuff: move netlink_large_alloc_large_skb() to skbuff.c
Date: Thu,  2 Nov 2023 14:28:35 +0800
Message-Id: <20231102062836.19074-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
X-Spam-Level: *
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

move netlink_alloc_large_skb and netlink_skb_destructor to skbuff.c
and rename them more generic, so they can be used elsewhere large
non-contiguous physical memory is needed

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 include/linux/skbuff.h   |  3 +++
 net/core/skbuff.c        | 40 ++++++++++++++++++++++++++++++++++++++++
 net/netlink/af_netlink.c | 41 ++---------------------------------------
 3 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4174c4b..774a401 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5063,5 +5063,8 @@ static inline void skb_mark_for_recycle(struct sk_buff *skb)
 ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 			     ssize_t maxsize, gfp_t gfp);
 
+
+void large_skb_destructor(struct sk_buff *skb);
+struct sk_buff *alloc_large_skb(unsigned int size, int broadcast);
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_SKBUFF_H */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4570705..20ffcd5 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6917,3 +6917,43 @@ ssize_t skb_splice_from_iter(struct sk_buff *skb, struct iov_iter *iter,
 	return spliced ?: ret;
 }
 EXPORT_SYMBOL(skb_splice_from_iter);
+
+void large_skb_destructor(struct sk_buff *skb)
+{
+	if (is_vmalloc_addr(skb->head)) {
+		if (!skb->cloned ||
+		    !atomic_dec_return(&(skb_shinfo(skb)->dataref)))
+			vfree(skb->head);
+
+		skb->head = NULL;
+	}
+	if (skb->sk)
+		sock_rfree(skb);
+}
+EXPORT_SYMBOL(large_skb_destructor);
+
+struct sk_buff *alloc_large_skb(unsigned int size,
+					       int broadcast)
+{
+	struct sk_buff *skb;
+	void *data;
+
+	if (size <= NLMSG_GOODSIZE || broadcast)
+		return alloc_skb(size, GFP_KERNEL);
+
+	size = SKB_DATA_ALIGN(size) +
+	       SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+
+	data = vmalloc(size);
+	if (!data)
+		return NULL;
+
+	skb = __build_skb(data, size);
+	if (!skb)
+		vfree(data);
+	else
+		skb->destructor = large_skb_destructor;
+
+	return skb;
+}
+EXPORT_SYMBOL(alloc_large_skb);
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 642b9d3..1d50b68 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -369,24 +369,11 @@ static void netlink_rcv_wake(struct sock *sk)
 		wake_up_interruptible(&nlk->wait);
 }
 
-static void netlink_skb_destructor(struct sk_buff *skb)
-{
-	if (is_vmalloc_addr(skb->head)) {
-		if (!skb->cloned ||
-		    !atomic_dec_return(&(skb_shinfo(skb)->dataref)))
-			vfree(skb->head);
-
-		skb->head = NULL;
-	}
-	if (skb->sk != NULL)
-		sock_rfree(skb);
-}
-
 static void netlink_skb_set_owner_r(struct sk_buff *skb, struct sock *sk)
 {
 	WARN_ON(skb->sk != NULL);
 	skb->sk = sk;
-	skb->destructor = netlink_skb_destructor;
+	skb->destructor = large_skb_destructor;
 	atomic_add(skb->truesize, &sk->sk_rmem_alloc);
 	sk_mem_charge(sk, skb->truesize);
 }
@@ -1204,30 +1191,6 @@ struct sock *netlink_getsockbyfilp(struct file *filp)
 	return sock;
 }
 
-static struct sk_buff *netlink_alloc_large_skb(unsigned int size,
-					       int broadcast)
-{
-	struct sk_buff *skb;
-	void *data;
-
-	if (size <= NLMSG_GOODSIZE || broadcast)
-		return alloc_skb(size, GFP_KERNEL);
-
-	size = SKB_DATA_ALIGN(size) +
-	       SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-
-	data = vmalloc(size);
-	if (data == NULL)
-		return NULL;
-
-	skb = __build_skb(data, size);
-	if (skb == NULL)
-		vfree(data);
-	else
-		skb->destructor = netlink_skb_destructor;
-
-	return skb;
-}
 
 /*
  * Attach a skb to a netlink socket.
@@ -1882,7 +1845,7 @@ static int netlink_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	if (len > sk->sk_sndbuf - 32)
 		goto out;
 	err = -ENOBUFS;
-	skb = netlink_alloc_large_skb(len, dst_group);
+	skb = alloc_large_skb(len, dst_group);
 	if (skb == NULL)
 		goto out;
 
-- 
2.9.4


