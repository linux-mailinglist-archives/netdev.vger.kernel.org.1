Return-Path: <netdev+bounces-299667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uvOwHAKOMGqNUQUAu9opvQ
	(envelope-from <netdev+bounces-299667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:42:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B339468AA26
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:42:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=tFhhczvl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299667-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299667-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35D0230221E1
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66FD34889F;
	Mon, 15 Jun 2026 23:42:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DF33451BA
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 23:42:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566950; cv=none; b=nXBYRnGMgCsnLZ5EHwarTLKLFFA3fBhX1VSUprIFd7b0VATz4gfLc0uOXj2hejMqaV1inov7eZll49dSGdV4RnI/xyaAxcJjF28ZcNO2q96pmfrRQ+M6bGOMjR48ukwpa/f2MJJX7zquF7cLB4SY4KuI+7eSkdIjrkMj399goB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566950; c=relaxed/simple;
	bh=W7Vh64GDqFnzEK3udiN2XQORk2qHAs9o1FPb59xnyaU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MSYeKXzOG8uZBWpcfIpS6qBSYWgLSWmF4oyYHM3p1BNcbYdvVwZQF1smqqNs0/zzWDzOgCUogksCxw8ilQkQNF+ufEmH2BwoMwsQzR7PPxAr+KNWjLB2VLXGwi3IQ9FeuCOr+mK5e+8XM3SITSCOF5aQSrsaHurcmrlijqV0bTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tFhhczvl; arc=none smtp.client-ip=209.85.218.73
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-bf523a51c24so309284666b.2
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 16:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781566947; x=1782171747; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UIyD+EBnBYaEJjyCAxmlqMmI4vbevecXit4PB+btx24=;
        b=tFhhczvlGtMitvX0vDfonButQvGm5W46xVR0L5I9VrTyP+q4xVEc0+OXhwUyR7Bd1y
         vidiGr8zE/ShAI4dpJxfNftQ0szRIIme9dHU22tBKdBn13PsOni9WXQ+hYITibd/lR6U
         /415IQJ/r/iHYPh0Hz+cDRKN6BniqYU/eiTh2cyc18ep8d0qbaWv+PvqHgJdx77tdkVJ
         wBuItTItidcitWhpc9Dy2vUu3DUgLpJGv+wmlyRaUgs51fJd0sIYIjgMTQq5kZqcIZRQ
         7DgUiI0L8QDswqeemsXQTqYPg/RCvKJ2WgfeAO2nxR0a7hXe30keudyGr9nFVsIZNP2g
         LhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781566947; x=1782171747;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UIyD+EBnBYaEJjyCAxmlqMmI4vbevecXit4PB+btx24=;
        b=QefXwj1zohAlzUs8IIuJ2hGqT5hlhuqOtELvHiyBzQL/HoCh/AmUmgEhM6yMVVU3NU
         i/tdIYq0lhuKBJ99R+CJtWb4gqJ/Bp59QoDfVMz21/vVFY6GaA6p+ZaBUW0rqSGcaToh
         /l5Bx/FQxt6H/Lp3JpKko2dtsd9QrPDdvFox6eSGfpXThgic2SbT6YhHx70V6FUzY4m0
         hn+cEBDt5JwqBtEtEkBTYWkRQXo0UJg4khGklCTh7YNg/MPqRf1KrQVu8rCIJbzT3of1
         rC54NQwrDGdhtfx1NE0vAvSPCaFysFOBEU7I9e59L5DQDxpp6uiK41n+Pt4fj6qg8i0U
         DLRw==
X-Forwarded-Encrypted: i=1; AFNElJ/gpS0N7W4kWCycbOaAmVyOPYalf6OEwKjRzXnO9c5w141wtmJrlON6YKMump0Upmlf4gl+tmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFTjRD9bcbHEW0LtrTKivAoUNsCj99m8KX3uX+HJEu2xpmsnoR
	BF9ri/CIt6UFV/fEtUzTgD6avqp1lApyEtc8H4jI7r85oADKol/OSI3t/30BQYd3l+FJDrisubp
	DdAvaMQ==
X-Received: from ejbby24.prod.google.com ([2002:a17:906:a2d8:b0:bed:1df2:75d1])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:724c:b0:bab:e742:aba
 with SMTP id a640c23a62f3a-bff4c6fdcc5mr597170666b.42.1781566946074; Mon, 15
 Jun 2026 16:42:26 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:42:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615234220.3946885-1-lrizzo@google.com>
Subject: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
From: Luigi Rizzo <lrizzo@google.com>
To: rizzo.unipi@gmail.com, lrizzo@google.com, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, willemb@google.com, kuniyu@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, akpm@linux-foundation.org, 
	david@kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
	iommu@lists.linux.dev, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299667-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lrizzo@google.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,google.com,samsung.com,arm.com,davemloft.net,kernel.org,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:rizzo.unipi@gmail.com,m:lrizzo@google.com,m:m.szyprowski@samsung.com,m:robin.murphy@arm.com,m:willemb@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:netdev@vger.kernel.org,m:linux-mm@kvack.org,m:iommu@lists.linux.dev,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:rizzounipi@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lrizzo@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lru.next:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B339468AA26

The use of swiotlb causes an extra data copy on I/O.  For tx sockets,
especially with greedy senders, this has a high chance of happening in
the softirq handler for tx network interrupts, creating a significant
performance bottleneck.

Allow tx sockets to allocate socket buffers directly from the bounce
buffers. This avoids the second copy and removes the above bottleneck.
The fraction of swiotlb buffers allowed for this feature is set with
   /sys/module/swiotlb/parameters/zerocopy_tx_percent
(0 means disabled, 90 is the maximum, to avoid persistent I/O failures).

Implementation:
- define a new page type to unambiguously identify bounce buffers used
  as backing storage for socket buffers
- modify skb_page_frag_refill to perform the modified allocation
- modify the destructors __free_frozen_pages(), free_unref_folio() to
  handle those pages and return them to the pool.

The savings are especially visible with fewer queues. In synthetic
benchmarks, senders with 1-2 queues would cap around 50Gbps with
conventional swiotlb, and reach over 170Gbps with the feature enabled.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/base/core.c        |   1 +
 include/linux/netdevice.h  |  22 ++++
 include/linux/page-flags.h |   4 +
 include/linux/skbuff.h     |   7 +-
 include/linux/swiotlb.h    |  74 ++++++++++++
 include/net/sock.h         |  29 +++++
 kernel/dma/swiotlb.c       | 227 +++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c            |  32 ++++++
 net/core/sock.c            |  98 ++++++++++++++--
 9 files changed, 485 insertions(+), 9 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index bd2ddf2aab505..e1257dea37ba0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3855,6 +3855,7 @@ void device_del(struct device *dev)
 	unsigned int noio_flag;
 
 	device_lock(dev);
+	swiotlb_device_deleted();
 	kill_device(dev);
 	device_unlock(dev);
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0e1e581efc5ac..d7e5929e73c92 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5368,13 +5368,35 @@ static inline netdev_tx_t __netdev_start_xmit(const struct net_device_ops *ops,
 	return ops->ndo_start_xmit(skb, dev);
 }
 
+struct sock;
+
+#ifdef CONFIG_SWIOTLB
+/* Per-CPU pointer to the socket currently performing transmission.
+ * Used to bridge the networking and DMA layers, allowing the dma_map_page()
+ * path to identify the socket originating the packet and apply SWIOTLB optimizations.
+ */
+DECLARE_PER_CPU(struct sock *, current_tx_socket);
+static inline struct sock *__set_current_tx_socket(struct sock *sk)
+{
+	struct sock *old_sk = this_cpu_read(current_tx_socket);
+
+	this_cpu_write(current_tx_socket, sk);
+	return old_sk;
+}
+#else
+static inline struct sock *__set_current_tx_socket(struct sock *sk) { return NULL; }
+#endif
+
 static inline netdev_tx_t netdev_start_xmit(struct sk_buff *skb, struct net_device *dev,
 					    struct netdev_queue *txq, bool more)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
+	struct sock *old_sk;
 	netdev_tx_t rc;
 
+	old_sk = __set_current_tx_socket(skb->sk);
 	rc = __netdev_start_xmit(ops, skb, dev, more);
+	__set_current_tx_socket(old_sk);
 	if (rc == NETDEV_TX_OK)
 		txq_trans_update(dev, txq);
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 7223f6f4e2b40..0ecbb404038a0 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -923,6 +923,7 @@ enum pagetype {
 	PGTY_zsmalloc		= 0xf6,
 	PGTY_unaccepted		= 0xf7,
 	PGTY_large_kmalloc	= 0xf8,
+	PGTY_zcswiotlb		= 0xf9,
 
 	PGTY_mapcount_underflow = 0xff
 };
@@ -1055,6 +1056,9 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
 PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
 PAGE_TYPE_OPS(LargeKmalloc, large_kmalloc, large_kmalloc)
 
+/* Pages in socket buffers from the swiotlb pool. */
+PAGE_TYPE_OPS(ZCSwiotlb, zcswiotlb, zcswiotlb)
+
 /**
  * PageHuge - Determine if the page belongs to hugetlbfs
  * @page: The page to test.
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 3f06254ab1b72..62340909409e5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3787,7 +3787,12 @@ static inline void skb_frag_page_copy(skb_frag_t *fragto,
 	fragto->netmem = fragfrom->netmem;
 }
 
-bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio);
+/* zerocopy swiotlb uses an additional non-null struct sock pointer. */
+bool __skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio, struct sock *sk);
+static inline bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio)
+{
+	return __skb_page_frag_refill(sz, pfrag, prio, NULL);
+}
 
 /**
  * __skb_frag_dma_map - maps a paged fragment via the DMA API
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 3dae0f592063e..bd2d0e160a9d8 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -7,8 +7,10 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/limits.h>
+#include <linux/percpu.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
+#include <linux/atomic.h>
 
 struct device;
 struct page;
@@ -122,6 +124,9 @@ struct io_tlb_mem {
 	atomic_long_t total_used;
 	atomic_long_t used_hiwater;
 	atomic_long_t transient_nslabs;
+#else
+	unsigned long last_used_slots;
+	unsigned long last_used_jiffies;
 #endif
 };
 
@@ -185,6 +190,69 @@ bool is_swiotlb_active(struct device *dev);
 void __init swiotlb_adjust_size(unsigned long size);
 phys_addr_t default_swiotlb_base(void);
 phys_addr_t default_swiotlb_limit(void);
+
+/* Helpers for zerocopy swiotlb. */
+/* Control allocation fraction. */
+extern unsigned int swiotlb_zc_tx_percent;
+
+/* Track freshness of the leaf device info. */
+extern atomic_t global_device_serial;
+
+static inline u32 swiotlb_get_device_serial(void)
+{
+	return atomic_read(&global_device_serial);
+}
+
+static inline void swiotlb_device_deleted(void)
+{
+	atomic_inc(&global_device_serial);
+}
+
+struct page *swiotlb_alloc_pages(struct device *dev, unsigned int order);
+bool swiotlb_free_pages(struct page *page, bool where_debug_only);
+void swiotlb_safe_put_device(struct device *dev);
+
+static inline void swiotlb_set_page_dev(struct page *page, struct device *dev)
+{
+	page->private = (unsigned long)dev;
+}
+
+static inline struct device *swiotlb_page_to_dev(struct page *page)
+{
+	return (struct device *)compound_head(page)->private;
+}
+
+static inline bool is_zerocopy_swiotlb_folio(struct page *page)
+{
+	struct folio *folio = page_folio(page);
+
+	return folio_test_zcswiotlb(folio) && folio->private != 0;
+}
+
+/* These two are in mm/page_alloc.c */
+void swiotlb_prep_compound_page(struct page *page, unsigned int order);
+void swiotlb_destroy_compound_page(struct page *page, unsigned int order);
+
+#if defined(CONFIG_NET)
+/*
+ * Track the socket for the currently transmitted packet, so the dma mapping
+ * function can record there the leaf device if it needs bounce buffers.
+ */
+struct sock;
+DECLARE_PER_CPU(struct sock *, current_tx_socket);
+void sk_set_bounce_device(struct sock *sk, struct device *dev);
+static inline void dma_learn_bounce_device(struct device *dev)
+{
+	struct sock *sk = this_cpu_read(current_tx_socket);
+
+	if (sk)
+		sk_set_bounce_device(sk, dev);
+}
+#else
+static inline void dma_learn_bounce_device(struct device *dev) {}
+#endif
+/* End helpers for zerocopy swiotlb. */
+
 #else
 static inline void swiotlb_init(bool addressing_limited, unsigned int flags)
 {
@@ -234,6 +302,12 @@ static inline phys_addr_t default_swiotlb_limit(void)
 {
 	return 0;
 }
+
+/* zerocopy swiotlb stubs */
+static inline bool swiotlb_free_pages(struct page *page, int reason) { return false; }
+static inline u32 swiotlb_get_device_serial(void) { return 0; }
+static inline void swiotlb_device_deleted(void) {}
+
 #endif /* CONFIG_SWIOTLB */
 
 phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
diff --git a/include/net/sock.h b/include/net/sock.h
index dccd3738c3687..1e6caf4bd1366 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -47,6 +47,7 @@
 #include <linux/skbuff.h>	/* struct sk_buff */
 #include <linux/mm.h>
 #include <linux/security.h>
+#include <linux/swiotlb.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/page_counter.h>
@@ -70,6 +71,14 @@
 #include <net/l3mdev.h>
 #include <uapi/linux/socket.h>
 
+#ifdef CONFIG_SWIOTLB
+struct sk_swiotlb_info {
+	struct device		*dev;
+	u32			serial;
+	unsigned long		jiffies;
+};
+#endif
+
 /*
  * This structure really needs to be cleaned up.
  * Most of it is for TCP, and not used by any of
@@ -602,8 +611,28 @@ struct sock {
 #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
 	struct module		*sk_owner;
 #endif
+#ifdef CONFIG_SWIOTLB
+	struct sk_swiotlb_info	sk_swiotlb;
+#endif
 };
 
+#ifdef CONFIG_SWIOTLB
+static inline void sk_init_bounce_device(struct sock *sk)
+{
+	sk->sk_swiotlb.dev = NULL;
+}
+static inline void sk_cleanup_bounce_device(struct sock *sk)
+{
+	if (sk->sk_swiotlb.dev) {
+		swiotlb_safe_put_device(sk->sk_swiotlb.dev);
+		sk->sk_swiotlb.dev = NULL;
+	}
+}
+#else
+static inline void sk_init_bounce_device(struct sock *sk) {}
+static inline void sk_cleanup_bounce_device(struct sock *sk) {}
+#endif
+
 struct sock_bh_locked {
 	struct sock *sock;
 	local_lock_t bh_lock;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 1abd3e6146f45..e27f23d03c482 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -37,12 +37,16 @@
 #include <linux/mm.h>
 #include <linux/pfn.h>
 #include <linux/rculist.h>
+#include <linux/refcount.h>
 #include <linux/scatterlist.h>
 #include <linux/set_memory.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/swiotlb.h>
+#include <linux/moduleparam.h>
+#include <linux/percpu.h>
 #include <linux/types.h>
+#include <linux/atomic.h>
 #ifdef CONFIG_DMA_RESTRICTED_POOL
 #include <linux/of.h>
 #include <linux/of_fdt.h>
@@ -81,6 +85,17 @@ struct io_tlb_slot {
 static bool swiotlb_force_bounce;
 static bool swiotlb_force_disable;
 
+/**
+ * global_device_serial - Global sequence number for device deletions
+ *
+ * Incremented every time a device is unregistered (in device_del()).
+ * Used by subsystems (like SWIOTLB zero-copy sockets) as a fast, lockless
+ * O(1) cache invalidation serial to detect when a cached device pointer
+ * might have been deleted and needs to be expired to prevent Use-After-Free.
+ */
+atomic_t global_device_serial = ATOMIC_INIT(0);
+EXPORT_SYMBOL(global_device_serial);
+
 #ifdef CONFIG_SWIOTLB_DYNAMIC
 
 static void swiotlb_dyn_alloc(struct work_struct *work);
@@ -1442,6 +1457,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	offset &= (IO_TLB_SIZE - 1);
 	index += pad_slots;
 	pool->slots[index].pad_slots = pad_slots;
+	/* Fix an upstream bug with alloc_align_mask = 0xffff */
+	pool->slots[index].alloc_size = mapping_size;
 	for (i = 0; i < (nr_slots(size) - pad_slots); i++)
 		pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
 	tlb_addr = slot_addr(pool->start, index) + offset;
@@ -1554,6 +1571,13 @@ void __swiotlb_tbl_unmap_single(struct device *dev, phys_addr_t tlb_addr,
 		size_t mapping_size, enum dma_data_direction dir,
 		unsigned long attrs, struct io_tlb_pool *pool)
 {
+	/*
+	 * Recognize and avoid unmapping pages allocated for Zero-Copy SWIOTLB Page Bypass.
+	 * They will be eventually released when the page reference count drops to 0.
+	 */
+	if (is_zerocopy_swiotlb_folio(pfn_to_page(PHYS_PFN(tlb_addr))))
+		return;
+
 	/*
 	 * First, sync the memory before unmapping the entry
 	 */
@@ -1597,6 +1621,21 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 	phys_addr_t swiotlb_addr;
 	dma_addr_t dma_addr;
 
+	dma_learn_bounce_device(dev);
+
+	/*
+	 * If the page was allocated via Zero-Copy SWIOTLB Page Bypass, it is likely
+	 * already good for DMA so we can return its dma address.
+	 */
+	if (is_zerocopy_swiotlb_folio(pfn_to_page(PHYS_PFN(paddr)))) {
+		dma_addr = phys_to_dma_unencrypted(dev, paddr);
+		if (likely(dma_capable(dev, dma_addr, size, true))) {
+			if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+				arch_sync_dma_for_device(paddr, size, dir);
+			return dma_addr;
+		}
+	}
+
 	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size);
 
 	swiotlb_addr = swiotlb_tbl_map_single(dev, paddr, size, 0, dir, attrs);
@@ -1899,3 +1938,191 @@ static const struct reserved_mem_ops rmem_swiotlb_ops = {
 
 RESERVEDMEM_OF_DECLARE(dma, "restricted-dma-pool", &rmem_swiotlb_ops);
 #endif /* CONFIG_DMA_RESTRICTED_POOL */
+
+/*
+ * Asynchronous/Deferred Device Release.
+ * put_device() can trigger the final release path of a device which may sleep.
+ * Since SWIOTLB pages can be freed in atomic or interrupt context (e.g. TX completion),
+ * we must defer the put_device() call to task context using a workqueue.
+ */
+struct swiotlb_deferred_put {
+	struct work_struct work;
+	struct device *dev;
+};
+
+static void swiotlb_deferred_put_work(struct work_struct *work)
+{
+	struct swiotlb_deferred_put *dp = container_of(work, struct swiotlb_deferred_put, work);
+
+	put_device(dp->dev);
+	kfree(dp);
+}
+
+/**
+ * swiotlb_safe_put_device() - Safely release device reference from atomic/interrupt context
+ * @dev: The device structure to release.
+ *
+ * Enqueues a deferred put_device() call on a workqueue using GFP_ATOMIC.
+ * If memory allocation fails, the reference is leaked to avoid an immediate crash.
+ */
+void swiotlb_safe_put_device(struct device *dev)
+{
+	struct swiotlb_deferred_put *dp;
+
+	if (!dev)
+		return;
+
+	/*
+	 * FAST PATH (O(1) lockless): If this is not the last reference,
+	 * we can decrement it atomically and safely in any context
+	 * without allocating memory or scheduling work!
+	 */
+	if (refcount_dec_not_one(&dev->kobj.kref.refcount))
+		return;
+
+	/*
+	 * SLOW PATH: It is the last reference (refcount == 1). We must
+	 * defer the final put_device() to task context because it will
+	 * trigger device_release() which can sleep.
+	 */
+	dp = kmalloc_obj(*dp, GFP_ATOMIC);
+	if (dp) {
+		INIT_WORK(&dp->work, swiotlb_deferred_put_work);
+		dp->dev = dev;
+		schedule_work(&dp->work);
+	} else {
+		pr_warn_ratelimited("swiotlb: failed to allocate deferred put, leaking device ref\n");
+	}
+}
+EXPORT_SYMBOL_GPL(swiotlb_safe_put_device);
+
+unsigned int swiotlb_zc_tx_percent;
+module_param_named(zerocopy_tx_percent, swiotlb_zc_tx_percent, uint, 0644);
+
+static unsigned long fast_mem_used(struct io_tlb_mem *mem)
+{
+#ifdef CONFIG_DEBUG_FS
+	return mem_used(mem);
+#else
+	unsigned long last_j = READ_ONCE(mem->last_used_jiffies);
+	unsigned long now = jiffies;
+
+	if (time_after(now, last_j + HZ / 100) &&
+	    try_cmpxchg(&mem->last_used_jiffies, &last_j, now)) {
+		WRITE_ONCE(mem->last_used_slots, mem_used(mem));
+	}
+	return READ_ONCE(mem->last_used_slots);
+#endif
+}
+
+/**
+ * swiotlb_alloc_pages() - Allocate long-lived contiguous pages from SWIOTLB pool
+ * @dev: Device which requires the SWIOTLB bounce buffers.
+ * @order: Allocation order (log2 of number of pages).
+ */
+struct page *swiotlb_alloc_pages(struct device *dev, unsigned int order)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_pool *pool;
+	int npages = 1 << order;
+	unsigned int max_pct;
+	phys_addr_t tlb_addr;
+	struct page *page;
+	int index;
+
+	if (!mem || !mem->nslabs)
+		return NULL;
+
+	max_pct = clamp(READ_ONCE(swiotlb_zc_tx_percent), 0u, 90u);
+	if (max_pct == 0 || max_pct * mem->nslabs <= fast_mem_used(mem) * 100)
+		return NULL;
+
+	/*
+	 * Enforce natural alignment for compound pages. The mask-based
+	 * compound_head() optimization (used when HVO is enabled and struct page
+	 * size is a power of 2) assumes that compound pages are naturally aligned
+	 * to their size. Without this, compound_head() on tail pages can return
+	 * a wrong head page pointer, leading to refcount corruption.
+	 */
+	index = swiotlb_find_slots(dev, 0, PAGE_SIZE * npages, ~(PAGE_MASK << order), &pool);
+	if (index == -1)
+		return NULL;
+
+	tlb_addr = slot_addr(pool->start, index);
+
+	pool->slots[index].pad_slots = 0;
+	pool->slots[index].alloc_size = PAGE_SIZE * npages;
+
+	page = pfn_to_page(PHYS_PFN(tlb_addr));
+
+	set_page_count(page, 1);
+
+	/* Strictly tag page[0] to prevent clobbering folio tail overlays */
+	__SetPageZCSwiotlb(page);
+
+	swiotlb_set_page_dev(page, dev);
+	get_device(dev);
+	swiotlb_prep_compound_page(page, order);
+	return page;
+}
+EXPORT_SYMBOL_GPL(swiotlb_alloc_pages);
+
+/*
+ * Debugging to track how swiotlb_free_pages() was called.
+ * b2: 0 from __free_frozen_pages(), 1 from free_unref_folios()
+ * b1: pool found b0: dev present,
+ */
+static unsigned long zc_debug[8];
+static int ctrs_num = 8;
+module_param_array(zc_debug, ulong, &ctrs_num, 0644);
+static void __zc_debug_stats(bool where, bool has_dev, bool has_pool)
+{
+	zc_debug[has_dev + has_pool * 2 + where * 4]++;
+}
+
+/**
+ * swiotlb_free_pages() - Free pages allocated via swiotlb_alloc_pages()
+ * @page: The starting struct page to release.
+ */
+bool swiotlb_free_pages(struct page *page, bool where_debug_only)
+{
+	struct page *head = compound_head(page);
+	struct device *dev = swiotlb_page_to_dev(head);
+	phys_addr_t head_tlb_addr = page_to_phys(head);
+	struct io_tlb_pool *pool;
+	int index, npages, i;
+
+	if (!folio_test_zcswiotlb(page_folio(head)))
+		return false;
+
+	pool = dev ? swiotlb_find_pool(dev, head_tlb_addr) : NULL;
+	__zc_debug_stats(where_debug_only, !!dev, !!pool);
+
+	/* Check for any false positives. */
+	if (!pool)
+		return false;
+
+	/* Read alloc_size first, it is reset by swiotlb_release_slots(). */
+	index = (head_tlb_addr - pool->start) >> IO_TLB_SHIFT;
+	npages = pool->slots[index].alloc_size >> PAGE_SHIFT;
+
+	WARN_ON_ONCE(!is_power_of_2(npages));
+
+	/* Step 1: Sever compound links (clobbers compound_info / lru.next) */
+	swiotlb_destroy_compound_page(head, ilog2(npages));
+
+	/* Step 2: Re-init LRU, drop refcounts, and strip flag across all constituent pages */
+	for (i = 0; i < npages; i++) {
+		INIT_LIST_HEAD(&head[i].lru);
+		set_page_count(&head[i], 0);
+		head[i].private = 0;
+		__ClearPageZCSwiotlb(&head[i]);
+	}
+
+	/* Step 3: Safely release slots back to the pool */
+	swiotlb_release_slots(dev, head_tlb_addr, pool);
+	swiotlb_del_transient(dev, head_tlb_addr, pool);
+	swiotlb_safe_put_device(dev);
+	return true;
+}
+EXPORT_SYMBOL_GPL(swiotlb_free_pages);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d49c254174da7..eaba683b5b2a8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -16,6 +16,7 @@
 
 #include <linux/stddef.h>
 #include <linux/mm.h>
+#include <linux/swiotlb.h>
 #include <linux/highmem.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
@@ -705,6 +706,31 @@ void prep_compound_page(struct page *page, unsigned int order)
 	prep_compound_head(page, order);
 }
 
+#ifdef CONFIG_SWIOTLB
+void swiotlb_prep_compound_page(struct page *page, unsigned int order)
+{
+	if (order > 0)
+		prep_compound_page(page, order);
+}
+
+void swiotlb_destroy_compound_page(struct page *page, unsigned int order)
+{
+	if (order > 0) {
+		struct folio *folio = (struct folio *)page;
+
+		__ClearPageHead(page);
+		page[1].flags.f &= ~PAGE_FLAGS_SECOND;
+#ifdef NR_PAGES_IN_LARGE_FOLIO
+		folio->_nr_pages = 0;
+#endif
+		for (int i = 1; i < (1 << order); i++) {
+			page[i].mapping = NULL;
+			clear_compound_head(&page[i]);
+		}
+	}
+}
+#endif /* CONFIG_SWIOTLB */
+
 static inline void set_buddy_order(struct page *page, unsigned int order)
 {
 	set_page_private(page, order);
@@ -2930,6 +2956,9 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 	unsigned long pfn = page_to_pfn(page);
 	int migratetype;
 
+	if (unlikely(swiotlb_free_pages(page, false)))
+		return;
+
 	if (!pcp_allowed_order(order)) {
 		__free_pages_ok(page, order, fpi_flags);
 		return;
@@ -2996,6 +3025,9 @@ void free_unref_folios(struct folio_batch *folios)
 		unsigned long pfn = folio_pfn(folio);
 		unsigned int order = folio_order(folio);
 
+		if (unlikely(swiotlb_free_pages(&folio->page, true)))
+			continue;
+
 		if (!__free_pages_prepare(&folio->page, order, FPI_NONE))
 			continue;
 		/*
diff --git a/net/core/sock.c b/net/core/sock.c
index d097025c116a8..c6fbb469f9ce5 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -103,6 +103,9 @@
 #include <linux/sockios.h>
 #include <linux/net.h>
 #include <linux/mm.h>
+#include <linux/swiotlb.h>
+#include <linux/device.h>
+#include <linux/moduleparam.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/poll.h>
@@ -152,6 +155,83 @@
 
 #include "dev.h"
 
+#ifdef CONFIG_SWIOTLB
+
+DEFINE_PER_CPU(struct sock *, current_tx_socket);
+EXPORT_PER_CPU_SYMBOL(current_tx_socket);
+
+void sk_set_bounce_device(struct sock *sk, struct device *dev)
+{
+	struct device *old_dev;
+
+	if (in_hardirq() || !sk_fullsock(sk) || sock_flag(sk, SOCK_ZEROCOPY))
+		return;
+
+	old_dev = READ_ONCE(sk->sk_swiotlb.dev);
+
+	if (dev != old_dev) {
+		/* Rate-limit updates to once per second to prevent bonding thrashing */
+		if (old_dev && time_before(jiffies, sk->sk_swiotlb.jiffies + HZ))
+			return;
+
+		get_device(dev);
+
+		/* Atomically swap in the new device and get the actual old one */
+		old_dev = xchg(&sk->sk_swiotlb.dev, dev);
+
+		WRITE_ONCE(sk->sk_swiotlb.serial, swiotlb_get_device_serial());
+		sk->sk_swiotlb.jiffies = jiffies;
+
+		/* Only drop the reference to the device we actually replaced */
+		if (old_dev)
+			swiotlb_safe_put_device(old_dev);
+	}
+}
+EXPORT_SYMBOL(sk_set_bounce_device);
+
+/*
+ * Wrap alloc_pages in __skb_page_frag_refill(). If the socket's dma_device requires
+ * SWIOTLB bounce buffering, divert allocation to the SWIOTLB slot allocator.
+ * This ensures the packet payload is written directly to a bounce buffer from the start,
+ * enabling zero-copy during driver DMA mapping.
+ */
+static inline struct page *alloc_any_pg(gfp_t gfp, unsigned int order, struct sock *sk)
+{
+	if (sk && READ_ONCE(swiotlb_zc_tx_percent) && !sock_flag(sk, SOCK_ZEROCOPY)) {
+		u32 serial = READ_ONCE(sk->sk_swiotlb.serial);
+		struct device *dev;
+
+		/* Force serial read BEFORE device pointer read. */
+		smp_rmb();
+
+		dev = READ_ONCE(sk->sk_swiotlb.dev);
+
+		if (dev) {
+			/*
+			 * The serial check is just for cache invalidation, UAF is
+			 * protected by the reference held in the sk.
+			 */
+			if (swiotlb_get_device_serial() != serial) {
+				if (cmpxchg(&sk->sk_swiotlb.dev, dev, NULL) == dev)
+					swiotlb_safe_put_device(dev);
+			} else {
+				struct page *page = swiotlb_alloc_pages(dev, order);
+
+				if (page)
+					return page;
+				/* On failure, fallback to alloc_pages(). */
+			}
+		}
+	}
+	return alloc_pages(gfp, order);
+}
+#else
+static inline struct page *alloc_any_pg(gfp_t gfp, unsigned int order, struct sock *sk)
+{
+	return alloc_pages(gfp, order);
+}
+#endif
+
 static DEFINE_MUTEX(proto_list_mutex);
 static LIST_HEAD(proto_list);
 
@@ -2383,6 +2463,7 @@ static void __sk_destruct(struct rcu_head *head)
 		__netns_tracker_free(net, &sk->ns_tracker, false);
 		net_passive_dec(net);
 	}
+	sk_cleanup_bounce_device(sk);
 	sk_prot_free(sk->sk_prot_creator, sk);
 }
 
@@ -2485,6 +2566,7 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
 		goto out;
 
 	sock_copy(newsk, sk);
+	sk_init_bounce_device(newsk);
 
 	newsk->sk_prot_creator = prot;
 
@@ -3134,7 +3216,7 @@ DEFINE_STATIC_KEY_FALSE(net_high_order_alloc_disable_key);
  * no guarantee that allocations succeed. Therefore, @sz MUST be
  * less or equal than PAGE_SIZE.
  */
-bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
+bool __skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp, struct sock *sk)
 {
 	if (pfrag->page) {
 		if (page_ref_count(pfrag->page) == 1) {
@@ -3150,27 +3232,27 @@ bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
 	if (SKB_FRAG_PAGE_ORDER &&
 	    !static_branch_unlikely(&net_high_order_alloc_disable_key)) {
 		/* Avoid direct reclaim but allow kswapd to wake */
-		pfrag->page = alloc_pages((gfp & ~__GFP_DIRECT_RECLAIM) |
-					  __GFP_COMP | __GFP_NOWARN |
-					  __GFP_NORETRY,
-					  SKB_FRAG_PAGE_ORDER);
+		pfrag->page = alloc_any_pg((gfp & ~__GFP_DIRECT_RECLAIM) |
+					   __GFP_COMP | __GFP_NOWARN |
+					   __GFP_NORETRY,
+					   SKB_FRAG_PAGE_ORDER, sk);
 		if (likely(pfrag->page)) {
 			pfrag->size = PAGE_SIZE << SKB_FRAG_PAGE_ORDER;
 			return true;
 		}
 	}
-	pfrag->page = alloc_page(gfp);
+	pfrag->page = alloc_any_pg(gfp, 0, sk);
 	if (likely(pfrag->page)) {
 		pfrag->size = PAGE_SIZE;
 		return true;
 	}
 	return false;
 }
-EXPORT_SYMBOL(skb_page_frag_refill);
+EXPORT_SYMBOL(__skb_page_frag_refill);
 
 bool sk_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
 {
-	if (likely(skb_page_frag_refill(32U, pfrag, sk->sk_allocation)))
+	if (likely(__skb_page_frag_refill(32U, pfrag, sk->sk_allocation, sk)))
 		return true;
 
 	if (!sk->sk_bypass_prot_mem)
-- 
2.54.0.1136.gdb2ca164c4-goog


