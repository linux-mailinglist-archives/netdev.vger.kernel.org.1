Return-Path: <netdev+bounces-254468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI+nBOl9emld7AEAu9opvQ
	(envelope-from <netdev+bounces-254468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:21:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6823FA913D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 688EE3062971
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970DC37473E;
	Wed, 28 Jan 2026 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lKKzl88b"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACFD329C77;
	Wed, 28 Jan 2026 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635252; cv=none; b=i7UhDvj0w8F2bRa1evSAJxF19By6fwA+540B8gSfq/RtuJ8RCsimWbKAI0uGS7Z4LkISevje5k30FuXELv1NbLdmTgDMQxozB/VgUrNARVaEKAmOUo6sdMhRqa54t6sV+5OR+epSqiOA9m3Iu9k3kMzLWABE9FDkoaQWel1hdOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635252; c=relaxed/simple;
	bh=H3fe62pUNN5v8Oo+G9YDBi8c7N2G0F3xcGoVZjFAbCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbFeiimOk9LWlCCZeaoBnJl7klSw7jPf3v/Y+rZ7C3nrjo7SOXDfmGmNSqAsbq8Og3n1aiRJTlA9zyCHjX0VCdEs9xqxRtRV0iVJ+T4Q6NOlyI/yaBQyOfwYlAVQFND3aeqKjkx264JEYNsFcDrraRPF1UaNo9oVZ/esG9TnYTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lKKzl88b; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SJF2Ak1031660;
	Wed, 28 Jan 2026 13:20:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=BrypVgdXu1/csxRGbZN/8in2uevCLGMnxEnNqJ3Ozm4=; b=lKKzl88bD6FG
	H1+RYtS9ZDW2qookALsiv1CsvpwNF2qwp7g9iIrXCAUJyVoKDgy9z7dCobbQPngL
	wzUzKSPpms7RbeJqp1YNsbYBrTkeKJFKBWwYUC2KWq0UHwxG7b6tCcRfWolePzXK
	wL4YMV4qzZT2WCJ7x6HT/aATMCRU659SeH2U8qEejiXr833O0aJJyK5nOnYf/OHJ
	0T4QflNa3eu9VBWTAb92YqGzOUKLjeaiARbHzhB5XVgfKkCRpCW3yYcltYh72smF
	EdOf2F+Y0o4xj4H+ekGbn9AHnbInVMytVjbfha5LZU3/c4UP6WR+7PoCgDDxUVqX
	b334PWl5Hw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4byn3749qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 28 Jan 2026 13:20:33 -0800 (PST)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.35; Wed, 28 Jan
 2026 21:20:33 +0000
From: Vishwanath Seshagiri <vishs@meta.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S .
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei
	<dw@davidwei.uk>,
        <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net-next 1/2] virtio_net: add page_pool support for buffer allocation
Date: Wed, 28 Jan 2026 13:20:30 -0800
Message-ID: <20260128212031.1431746-2-vishs@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128212031.1431746-1-vishs@meta.com>
References: <20260128212031.1431746-1-vishs@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2sHltFrixzbasFlrAnNIXvf1lzuS4_dx
X-Proofpoint-ORIG-GUID: 2sHltFrixzbasFlrAnNIXvf1lzuS4_dx
X-Authority-Analysis: v=2.4 cv=LbwxKzfi c=1 sm=1 tr=0 ts=697a7da1 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8
 a=06VoeBElz_K0mJyKuYQA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE3NiBTYWx0ZWRfX7VEY81Gc5eN4
 px1qefbCPBRFznD0opGw11cFnbdDvI4y2mPDWzfR0vViKzddIK055rvI9D/hXjJ0X/Tu2q9B/Rj
 T5YgECfVS32qyczgGr7a2b+GdCToC+v3B5iKAdacJ8N4SuM0ayPjMtm3A2HnM3rj3VZEllJuUvu
 dHfhmkUk2Epa9LkC66V8r5Bp6EjEzq90eLGOX5SHmyUV8q2fylYMHuD7dLAkRhFfGJfkbUEnsPG
 pTMS+vAh0fU28TRljVjvEBkKYAhaUEpAiMHPZwbSynf6vS+QtAQXihZ3I3OpPAIvwvHcdxJi4g0
 cD+LngGTK69Ayh4mPS4yQIeeBrrG5YDkYLFPHXtlF5fKqHNLj7hhYaT8/tad6vHaSXsWj3ROs/Y
 Ck7D+fingoZ3IhCqdv+qlgsoTd0qM4jQh7RCjQpD+wRLVxV/kTtzY0hNFyFkubG8tHG08ZFxCDK
 rTPnws+Lhou8BYzS9cA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254468-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,meta.com:dkim,meta.com:mid,pp_params.dev:url]
X-Rspamd-Queue-Id: 6823FA913D
X-Rspamd-Action: no action

Use page_pool for RX buffer allocation in mergeable and small buffer
modes to enable page recycling and avoid repeated page allocator calls.
skb_mark_for_recycle() enables page reuse in the network stack.

Big packets mode is unchanged because it uses page->private for linked
list chaining of multiple pages per buffer, which conflicts with
page_pool's internal use of page->private.

Implement conditional DMA premapping using virtqueue_dma_dev():
- When non-NULL (vhost, virtio-pci): use PP_FLAG_DMA_MAP with page_pool
  handling DMA mapping, submit via virtqueue_add_inbuf_premapped()
- When NULL (VDUSE, direct physical): page_pool handles allocation only,
  submit via virtqueue_add_inbuf_ctx()

This preserves the DMA premapping optimization from commit 31f3cd4e5756b
("virtio-net: rq submits premapped per-buffer") while adding page_pool
support as a prerequisite for future zero-copy features (devmem TCP,
io_uring ZCRX).

Page pools are created in probe and destroyed in remove (not open/close),
following existing driver behavior where RX buffers remain in virtqueues
across interface state changes.

The rx_mode_work_enabled flag prevents virtnet_rx_mode_work() from
sending control virtqueue commands while ndo_close is tearing down
device state, avoiding virtqueue corruption during concurrent operations.

Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
---
 drivers/net/Kconfig      |   1 +
 drivers/net/virtio_net.c | 353 ++++++++++++++++++++++-----------------
 2 files changed, 203 insertions(+), 151 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index ac12eaf11755..f1e6b6b0a86f 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -450,6 +450,7 @@ config VIRTIO_NET
 	depends on VIRTIO
 	select NET_FAILOVER
 	select DIMLIB
+	select PAGE_POOL
 	help
 	  This is the virtual network driver for virtio.  It can be used with
 	  QEMU based VMMs (like KVM or Xen).  Say Y or M.
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index db88dcaefb20..df2a5fc5187e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -26,6 +26,7 @@
 #include <net/netdev_rx_queue.h>
 #include <net/netdev_queues.h>
 #include <net/xdp_sock_drv.h>
+#include <net/page_pool/helpers.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -359,6 +360,11 @@ struct receive_queue {
 	/* Page frag for packet buffer allocation. */
 	struct page_frag alloc_frag;
 
+	struct page_pool *page_pool;
+
+	/* True if page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
+	bool use_page_pool_dma;
+
 	/* RX: fragments + linear part + virtio header */
 	struct scatterlist sg[MAX_SKB_FRAGS + 2];
 
@@ -521,11 +527,13 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			       struct virtnet_rq_stats *stats);
 static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *rq,
 				 struct sk_buff *skb, u8 flags);
-static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
+static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
+					       struct sk_buff *head_skb,
 					       struct sk_buff *curr_skb,
 					       struct page *page, void *buf,
 					       int len, int truesize);
 static void virtnet_xsk_completed(struct send_queue *sq, int num);
+static void free_unused_bufs(struct virtnet_info *vi);
 
 enum virtnet_xmit_type {
 	VIRTNET_XMIT_TYPE_SKB,
@@ -706,15 +714,21 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
 	return p;
 }
 
+static void virtnet_put_page(struct receive_queue *rq, struct page *page,
+			     bool allow_direct)
+{
+	page_pool_put_page(rq->page_pool, page, -1, allow_direct);
+}
+
 static void virtnet_rq_free_buf(struct virtnet_info *vi,
 				struct receive_queue *rq, void *buf)
 {
 	if (vi->mergeable_rx_bufs)
-		put_page(virt_to_head_page(buf));
+		virtnet_put_page(rq, virt_to_head_page(buf), false);
 	else if (vi->big_packets)
 		give_pages(rq, buf);
 	else
-		put_page(virt_to_head_page(buf));
+		virtnet_put_page(rq, virt_to_head_page(buf), false);
 }
 
 static void enable_rx_mode_work(struct virtnet_info *vi)
@@ -877,9 +891,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		if (unlikely(!skb))
 			return NULL;
 
-		page = (struct page *)page->private;
-		if (page)
-			give_pages(rq, page);
 		goto ok;
 	}
 
@@ -914,18 +925,14 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
 				frag_size, truesize);
 		len -= frag_size;
-		page = (struct page *)page->private;
 		offset = 0;
 	}
 
-	if (page)
-		give_pages(rq, page);
-
 ok:
 	hdr = skb_vnet_common_hdr(skb);
 	memcpy(hdr, hdr_p, hdr_len);
 	if (page_to_free)
-		put_page(page_to_free);
+		virtnet_put_page(rq, page_to_free, true);
 
 	return skb;
 }
@@ -965,93 +972,10 @@ static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
 static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
-	void *buf;
-
-	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
-
-	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
-	if (buf)
-		virtnet_rq_unmap(rq, buf, *len);
-
-	return buf;
-}
-
-static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
-{
-	struct virtnet_info *vi = rq->vq->vdev->priv;
-	struct virtnet_rq_dma *dma;
-	dma_addr_t addr;
-	u32 offset;
-	void *head;
-
-	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
-
-	head = page_address(rq->alloc_frag.page);
-
-	offset = buf - head;
-
-	dma = head;
-
-	addr = dma->addr - sizeof(*dma) + offset;
-
-	sg_init_table(rq->sg, 1);
-	sg_fill_dma(rq->sg, addr, len);
-}
-
-static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
-{
-	struct page_frag *alloc_frag = &rq->alloc_frag;
-	struct virtnet_info *vi = rq->vq->vdev->priv;
-	struct virtnet_rq_dma *dma;
-	void *buf, *head;
-	dma_addr_t addr;
 
 	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
 
-	head = page_address(alloc_frag->page);
-
-	dma = head;
-
-	/* new pages */
-	if (!alloc_frag->offset) {
-		if (rq->last_dma) {
-			/* Now, the new page is allocated, the last dma
-			 * will not be used. So the dma can be unmapped
-			 * if the ref is 0.
-			 */
-			virtnet_rq_unmap(rq, rq->last_dma, 0);
-			rq->last_dma = NULL;
-		}
-
-		dma->len = alloc_frag->size - sizeof(*dma);
-
-		addr = virtqueue_map_single_attrs(rq->vq, dma + 1,
-						  dma->len, DMA_FROM_DEVICE, 0);
-		if (virtqueue_map_mapping_error(rq->vq, addr))
-			return NULL;
-
-		dma->addr = addr;
-		dma->need_sync = virtqueue_map_need_sync(rq->vq, addr);
-
-		/* Add a reference to dma to prevent the entire dma from
-		 * being released during error handling. This reference
-		 * will be freed after the pages are no longer used.
-		 */
-		get_page(alloc_frag->page);
-		dma->ref = 1;
-		alloc_frag->offset = sizeof(*dma);
-
-		rq->last_dma = dma;
-	}
-
-	++dma->ref;
-
-	buf = head + alloc_frag->offset;
-
-	get_page(alloc_frag->page);
-	alloc_frag->offset += size;
-
-	return buf;
+	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
 }
 
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
@@ -1067,9 +991,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 		return;
 	}
 
-	if (!vi->big_packets || vi->mergeable_rx_bufs)
-		virtnet_rq_unmap(rq, buf, 0);
-
 	virtnet_rq_free_buf(vi, rq, buf);
 }
 
@@ -1335,7 +1256,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
 
 		truesize = len;
 
-		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
+		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
 						    buf, len, truesize);
 		if (!curr_skb) {
 			put_page(page);
@@ -1771,7 +1692,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	return ret;
 }
 
-static void put_xdp_frags(struct xdp_buff *xdp)
+static void put_xdp_frags(struct xdp_buff *xdp, struct receive_queue *rq)
 {
 	struct skb_shared_info *shinfo;
 	struct page *xdp_page;
@@ -1781,7 +1702,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
 		shinfo = xdp_get_shared_info_from_buff(xdp);
 		for (i = 0; i < shinfo->nr_frags; i++) {
 			xdp_page = skb_frag_page(&shinfo->frags[i]);
-			put_page(xdp_page);
+			virtnet_put_page(rq, xdp_page, true);
 		}
 	}
 }
@@ -1897,7 +1818,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
 		off = buf - page_address(p);
 
 		if (check_mergeable_len(dev, ctx, buflen)) {
-			put_page(p);
+			virtnet_put_page(rq, p, true);
 			goto err_buf;
 		}
 
@@ -1905,14 +1826,14 @@ static struct page *xdp_linearize_page(struct net_device *dev,
 		 * is sending packet larger than the MTU.
 		 */
 		if ((page_off + buflen + tailroom) > PAGE_SIZE) {
-			put_page(p);
+			virtnet_put_page(rq, p, true);
 			goto err_buf;
 		}
 
 		memcpy(page_address(page) + page_off,
 		       page_address(p) + off, buflen);
 		page_off += buflen;
-		put_page(p);
+		virtnet_put_page(rq, p, true);
 	}
 
 	/* Headroom does not contribute to packet length */
@@ -1962,7 +1883,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	unsigned int headroom = vi->hdr_len + header_offset;
 	struct virtio_net_hdr_mrg_rxbuf *hdr = buf + header_offset;
 	struct page *page = virt_to_head_page(buf);
-	struct page *xdp_page;
+	struct page *xdp_page = NULL;
 	unsigned int buflen;
 	struct xdp_buff xdp;
 	struct sk_buff *skb;
@@ -1996,7 +1917,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 			goto err_xdp;
 
 		buf = page_address(xdp_page);
-		put_page(page);
+		virtnet_put_page(rq, page, true);
 		page = xdp_page;
 	}
 
@@ -2028,13 +1949,19 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	if (metasize)
 		skb_metadata_set(skb, metasize);
 
+	if (!xdp_page)
+		skb_mark_for_recycle(skb);
+
 	return skb;
 
 err_xdp:
 	u64_stats_inc(&stats->xdp_drops);
 err:
 	u64_stats_inc(&stats->drops);
-	put_page(page);
+	if (xdp_page)
+		put_page(page);
+	else
+		virtnet_put_page(rq, page, true);
 xdp_xmit:
 	return NULL;
 }
@@ -2082,12 +2009,14 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	}
 
 	skb = receive_small_build_skb(vi, xdp_headroom, buf, len);
-	if (likely(skb))
+	if (likely(skb)) {
+		skb_mark_for_recycle(skb);
 		return skb;
+	}
 
 err:
 	u64_stats_inc(&stats->drops);
-	put_page(page);
+	virtnet_put_page(rq, page, true);
 	return NULL;
 }
 
@@ -2142,7 +2071,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
 		}
 		u64_stats_add(&stats->bytes, len);
 		page = virt_to_head_page(buf);
-		put_page(page);
+		virtnet_put_page(rq, page, true);
 	}
 }
 
@@ -2253,7 +2182,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 		offset = buf - page_address(page);
 
 		if (check_mergeable_len(dev, ctx, len)) {
-			put_page(page);
+			virtnet_put_page(rq, page, true);
 			goto err;
 		}
 
@@ -2272,7 +2201,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 	return 0;
 
 err:
-	put_xdp_frags(xdp);
+	put_xdp_frags(xdp, rq);
 	return -EINVAL;
 }
 
@@ -2347,7 +2276,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
 
 	*frame_sz = PAGE_SIZE;
 
-	put_page(*page);
+	virtnet_put_page(rq, *page, true);
 
 	*page = xdp_page;
 
@@ -2369,6 +2298,7 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	struct page *page = virt_to_head_page(buf);
 	int offset = buf - page_address(page);
 	unsigned int xdp_frags_truesz = 0;
+	struct page *org_page = page;
 	struct sk_buff *head_skb;
 	unsigned int frame_sz;
 	struct xdp_buff xdp;
@@ -2393,6 +2323,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
 		if (unlikely(!head_skb))
 			break;
+		if (page == org_page)
+			skb_mark_for_recycle(head_skb);
 		return head_skb;
 
 	case XDP_TX:
@@ -2403,10 +2335,13 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 		break;
 	}
 
-	put_xdp_frags(&xdp);
+	put_xdp_frags(&xdp, rq);
 
 err_xdp:
-	put_page(page);
+	if (page != org_page)
+		put_page(page);
+	else
+		virtnet_put_page(rq, page, true);
 	mergeable_buf_free(rq, num_buf, dev, stats);
 
 	u64_stats_inc(&stats->xdp_drops);
@@ -2414,7 +2349,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	return NULL;
 }
 
-static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
+static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
+					       struct sk_buff *head_skb,
 					       struct sk_buff *curr_skb,
 					       struct page *page, void *buf,
 					       int len, int truesize)
@@ -2446,7 +2382,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
 
 	offset = buf - page_address(page);
 	if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
-		put_page(page);
+		virtnet_put_page(rq, page, true);
 		skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
 				     len, truesize);
 	} else {
@@ -2495,10 +2431,12 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	}
 
 	head_skb = page_to_skb(vi, rq, page, offset, len, truesize, headroom);
+	if (unlikely(!head_skb))
+		goto err_skb;
+
 	curr_skb = head_skb;
 
-	if (unlikely(!curr_skb))
-		goto err_skb;
+	skb_mark_for_recycle(head_skb);
 	while (--num_buf) {
 		buf = virtnet_rq_get_buf(rq, &len, &ctx);
 		if (unlikely(!buf)) {
@@ -2517,7 +2455,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			goto err_skb;
 
 		truesize = mergeable_ctx_to_truesize(ctx);
-		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
+		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
 						    buf, len, truesize);
 		if (!curr_skb)
 			goto err_skb;
@@ -2527,7 +2465,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	return head_skb;
 
 err_skb:
-	put_page(page);
+	virtnet_put_page(rq, page, true);
 	mergeable_buf_free(rq, num_buf, dev, stats);
 
 err_buf:
@@ -2666,6 +2604,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 			     gfp_t gfp)
 {
+	unsigned int offset;
+	struct page *page;
 	char *buf;
 	unsigned int xdp_headroom = virtnet_get_headroom(vi);
 	void *ctx = (void *)(unsigned long)xdp_headroom;
@@ -2675,23 +2615,30 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 	len = SKB_DATA_ALIGN(len) +
 	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
-		return -ENOMEM;
-
-	buf = virtnet_rq_alloc(rq, len, gfp);
-	if (unlikely(!buf))
+	page = page_pool_alloc_frag(rq->page_pool, &offset, len, gfp);
+	if (unlikely(!page))
 		return -ENOMEM;
 
+	buf = page_address(page) + offset;
 	buf += VIRTNET_RX_PAD + xdp_headroom;
 
-	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
+	sg_init_table(rq->sg, 1);
 
-	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
-	if (err < 0) {
-		virtnet_rq_unmap(rq, buf, 0);
-		put_page(virt_to_head_page(buf));
+	if (rq->use_page_pool_dma) {
+		dma_addr_t addr = page_pool_get_dma_addr(page) + offset;
+
+		addr += VIRTNET_RX_PAD + xdp_headroom;
+		sg_fill_dma(rq->sg, addr, vi->hdr_len + GOOD_PACKET_LEN);
+		err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf,
+						    ctx, gfp);
+	} else {
+		sg_set_buf(&rq->sg[0], buf, vi->hdr_len + GOOD_PACKET_LEN);
+		err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	}
 
+	if (err < 0)
+		page_pool_put_page(rq->page_pool, virt_to_head_page(buf),
+				   -1, false);
 	return err;
 }
 
@@ -2764,11 +2711,12 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
 static int add_recvbuf_mergeable(struct virtnet_info *vi,
 				 struct receive_queue *rq, gfp_t gfp)
 {
-	struct page_frag *alloc_frag = &rq->alloc_frag;
 	unsigned int headroom = virtnet_get_headroom(vi);
 	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
 	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
 	unsigned int len, hole;
+	unsigned int offset;
+	struct page *page;
 	void *ctx;
 	char *buf;
 	int err;
@@ -2779,18 +2727,14 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	 */
 	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
 
-	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
-		return -ENOMEM;
-
-	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
-		len -= sizeof(struct virtnet_rq_dma);
-
-	buf = virtnet_rq_alloc(rq, len + room, gfp);
-	if (unlikely(!buf))
+	page = page_pool_alloc_frag(rq->page_pool, &offset, len + room, gfp);
+	if (unlikely(!page))
 		return -ENOMEM;
 
+	buf = page_address(page) + offset;
 	buf += headroom; /* advance address leaving hole at front of pkt */
-	hole = alloc_frag->size - alloc_frag->offset;
+
+	hole = PAGE_SIZE - (offset + len + room);
 	if (hole < len + room) {
 		/* To avoid internal fragmentation, if there is very likely not
 		 * enough space for another buffer, add the remaining space to
@@ -2800,18 +2744,27 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 		 */
 		if (!headroom)
 			len += hole;
-		alloc_frag->offset += hole;
 	}
 
-	virtnet_rq_init_one_sg(rq, buf, len);
-
 	ctx = mergeable_len_to_ctx(len + room, headroom);
-	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
-	if (err < 0) {
-		virtnet_rq_unmap(rq, buf, 0);
-		put_page(virt_to_head_page(buf));
+
+	sg_init_table(rq->sg, 1);
+
+	if (rq->use_page_pool_dma) {
+		dma_addr_t addr = page_pool_get_dma_addr(page) + offset;
+
+		addr += headroom;
+		sg_fill_dma(rq->sg, addr, len);
+		err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf,
+						    ctx, gfp);
+	} else {
+		sg_set_buf(&rq->sg[0], buf, len);
+		err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	}
 
+	if (err < 0)
+		page_pool_put_page(rq->page_pool, virt_to_head_page(buf),
+				   -1, false);
 	return err;
 }
 
@@ -3128,7 +3081,10 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 		return err;
 
 	err = xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
-					 MEM_TYPE_PAGE_SHARED, NULL);
+					 vi->rq[qp_index].page_pool ?
+						MEM_TYPE_PAGE_POOL :
+						MEM_TYPE_PAGE_SHARED,
+					 vi->rq[qp_index].page_pool);
 	if (err < 0)
 		goto err_xdp_reg_mem_model;
 
@@ -3168,6 +3124,81 @@ static void virtnet_update_settings(struct virtnet_info *vi)
 		vi->duplex = duplex;
 }
 
+static int virtnet_create_page_pools(struct virtnet_info *vi)
+{
+	int i, err;
+
+	for (i = 0; i < vi->curr_queue_pairs; i++) {
+		struct receive_queue *rq = &vi->rq[i];
+		struct page_pool_params pp_params = { 0 };
+		struct device *dma_dev;
+
+		if (rq->page_pool)
+			continue;
+
+		if (rq->xsk_pool)
+			continue;
+
+		if (!vi->mergeable_rx_bufs && vi->big_packets)
+			continue;
+
+		pp_params.order = 0;
+		pp_params.pool_size = virtqueue_get_vring_size(rq->vq);
+		pp_params.nid = dev_to_node(vi->vdev->dev.parent);
+		pp_params.netdev = vi->dev;
+		pp_params.napi = &rq->napi;
+
+		/* Check if backend supports DMA API (e.g., vhost, virtio-pci).
+		 * If so, use page_pool's DMA mapping for premapped buffers.
+		 * Otherwise (e.g., VDUSE), page_pool only handles allocation.
+		 */
+		dma_dev = virtqueue_dma_dev(rq->vq);
+		if (dma_dev) {
+			pp_params.dev = dma_dev;
+			pp_params.flags = PP_FLAG_DMA_MAP;
+			pp_params.dma_dir = DMA_FROM_DEVICE;
+			rq->use_page_pool_dma = true;
+		} else {
+			pp_params.dev = vi->vdev->dev.parent;
+			pp_params.flags = 0;
+			rq->use_page_pool_dma = false;
+		}
+
+		rq->page_pool = page_pool_create(&pp_params);
+		if (IS_ERR(rq->page_pool)) {
+			err = PTR_ERR(rq->page_pool);
+			rq->page_pool = NULL;
+			goto err_cleanup;
+		}
+	}
+	return 0;
+
+err_cleanup:
+	while (--i >= 0) {
+		struct receive_queue *rq = &vi->rq[i];
+
+		if (rq->page_pool) {
+			page_pool_destroy(rq->page_pool);
+			rq->page_pool = NULL;
+		}
+	}
+	return err;
+}
+
+static void virtnet_destroy_page_pools(struct virtnet_info *vi)
+{
+	int i;
+
+	for (i = 0; i < vi->max_queue_pairs; i++) {
+		struct receive_queue *rq = &vi->rq[i];
+
+		if (rq->page_pool) {
+			page_pool_destroy(rq->page_pool);
+			rq->page_pool = NULL;
+		}
+	}
+}
+
 static int virtnet_open(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
@@ -3771,6 +3802,8 @@ static int virtnet_close(struct net_device *dev)
 	 */
 	cancel_work_sync(&vi->config_work);
 
+	vi->rx_mode_work_enabled = false;
+
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		virtnet_disable_queue_pair(vi, i);
 		virtnet_cancel_dim(vi, &vi->rq[i].dim);
@@ -3807,6 +3840,11 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 
 	rtnl_lock();
 
+	if (!vi->rx_mode_work_enabled) {
+		rtnl_unlock();
+		return;
+	}
+
 	*promisc_allmulti = !!(dev->flags & IFF_PROMISC);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
@@ -6945,6 +6983,14 @@ static int virtnet_probe(struct virtio_device *vdev)
 			goto free;
 	}
 
+	/* Create page pools for receive queues.
+	 * Page pools are created at probe time so they can be used
+	 * with premapped DMA addresses throughout the device lifetime.
+	 */
+	err = virtnet_create_page_pools(vi);
+	if (err)
+		goto free_irq_moder;
+
 #ifdef CONFIG_SYSFS
 	if (vi->mergeable_rx_bufs)
 		dev->sysfs_rx_queue_group = &virtio_net_mrg_rx_group;
@@ -6958,7 +7004,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 		vi->failover = net_failover_create(vi->dev);
 		if (IS_ERR(vi->failover)) {
 			err = PTR_ERR(vi->failover);
-			goto free_vqs;
+			goto free_page_pools;
 		}
 	}
 
@@ -7075,7 +7121,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 	unregister_netdev(dev);
 free_failover:
 	net_failover_destroy(vi->failover);
-free_vqs:
+free_page_pools:
+	virtnet_destroy_page_pools(vi);
+free_irq_moder:
+	virtnet_free_irq_moder(vi);
 	virtio_reset_device(vdev);
 	free_receive_page_frags(vi);
 	virtnet_del_vqs(vi);
@@ -7104,6 +7153,8 @@ static void remove_vq_common(struct virtnet_info *vi)
 
 	free_receive_page_frags(vi);
 
+	virtnet_destroy_page_pools(vi);
+
 	virtnet_del_vqs(vi);
 }
 
-- 
2.47.3


