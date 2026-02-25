Return-Path: <netdev+bounces-260767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMxtGIp/nmmxVgQAu9opvQ
	(envelope-from <netdev+bounces-260767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 05:50:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AC8191A94
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 05:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FCB03085BBF
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 04:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07472C234B;
	Wed, 25 Feb 2026 04:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="vZRdccDg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709BE2D0C82;
	Wed, 25 Feb 2026 04:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771994996; cv=none; b=YxK6umuWRbBxfU5C43Rlffwt5+aUCiNw8DYe6pl0izxML75rDTLRvJ824WEEIoZjZcsvhtTleDaz/NvrwLbDP/4st6QK9yKCbIUSaKeTRI0v6fI25prpqLHfaWQRx6/4RVC2X4fKB8lgcvUEX6Mu8LMSR7IHJb86AvNxhCCpeOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771994996; c=relaxed/simple;
	bh=yUU7AQ/xCHgKirUcQHpiXiCx3I7MVVxpBCkmALqmavs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ge38JGs6S65R3fJj1MGMrWVnHrp8Ius/mGLrC0kO0IVNP0g9+BKBB/sISHLtZZeWyFEahGf3W7ZONpdOosBypEXXpH3lTCbaCj3jEr9xoEbdcAaujgueIzVYf8Ay2JYramNVcR+LjCt9V4QSjIaLf6MDTSIb2pE617Yq8pbhuek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=vZRdccDg; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 61P09GIs996452;
	Tue, 24 Feb 2026 20:49:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=fAmVTsiY3BxvMkSQvJ
	6lU+qnadN1Sgj2rDTxiNANOuM=; b=vZRdccDg2+eKdlIcSIceG+PgthVJ1gDt+w
	hEhzONE1iu3cyNJOmVqsnVS+Wz1VMfnQGhtbmyntjlQXsgrTX+/px2BBcRe77RCb
	vXaIjmwPFHhTUZ3DUGA8KZWQeuv6BteVoSo9eB670Dn9jQgopobL+pqHUjzRTMGU
	dMp0st+5XUzTgKB/tQbU/D/gwqybQwXLhzmZ0DAXiTMwKZeb8oKTTHaeJ31xDJQl
	RaaM5wZer91DM1x5rfvX/M/Rt0foYT8iGWB9qFw3ugxAqhrCKc7GhA5gcap47S4q
	N9yoUxaJiag67gc4sJ0KljFMbI7EpOq6+9FXFpLE1DJ0I+FM6tLQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4chhkt4ms8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 24 Feb 2026 20:49:32 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::8e35) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.35; Wed, 25 Feb
 2026 04:49:19 +0000
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
        Matteo Croce <technoboy85@gmail.com>,
        Ilias Apalodimas
	<ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v7 RESEND net-next] virtio_net: add page_pool support for buffer allocation
Date: Tue, 24 Feb 2026 20:49:10 -0800
Message-ID: <20260225044910.1328791-1-vishs@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA0NCBTYWx0ZWRfX1YGmgtSyyUsB
 xxML/xRlB/Fpf+jKII5J66fMVcs4kUtI4ZKuhq00gd/qQ8I8S1rITPuFfoh0HUCpsLb6BrBIC9h
 aganDTAmxSBfsk0D868NohHgzoBIWznE8t3WyZdIftbfo0NoipGcDEFKpMR+v8AHHqIOdnYz8Ni
 Po/tvwZO2eRsX47quhWJRPS7zYWJpKCHaLTQtFFTOOsoWtAHsW6h9oESHgpEs9ujUD69FpiK373
 NpZM9Kki5C6X4tIHcOij/+cikpeCdsm1Dt7bjdqnH1RWrTEIVNKXRYmWQDC4xT8mXrjlqo5+mL0
 80BT4zaJcPJOoD/C8F8AXxud61BMAyULjeWxEDXqBiMoM7IzQG5/fd4xDzGw2DgTqI1trd5PqKK
 Hg1LQA0oAkkGcZdaxSz9rvaTLNxyeecjN3EP+xIWczuLf8Cw0PZzNjErSDOY93YkrODyFv6bQ0z
 0LtMOwhjHtOrgQ0HE0g==
X-Proofpoint-ORIG-GUID: SyBi_ktm-DrKOwMFf7nP0_50rCJQm8C6
X-Proofpoint-GUID: SyBi_ktm-DrKOwMFf7nP0_50rCJQm8C6
X-Authority-Analysis: v=2.4 cv=H+jWAuYi c=1 sm=1 tr=0 ts=699e7f5c cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=YKODAeZf0HZpgJc5_y8A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260767-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.946];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pp_params.dev:url,meta.com:mid,meta.com:dkim,meta.com:email]
X-Rspamd-Queue-Id: E2AC8191A94
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

Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
---
Resend for net-next window (no changes from v7).
- v7:
  https://lore.kernel.org/virtualization/20260210014305.3236342-1-vishs@meta.com/ 

Changes in v7:
- Replace virtnet_put_page() helper with direct page_pool_put_page()
  calls (Xuan Zhuo)
- Add virtnet_no_page_pool() helper to consolidate big_packets mode check
  (Michael S. Tsirkin)
- Add DMA sync_for_cpu for subsequent buffers in xdp_linearize_page() when
  use_page_pool_dma is set (Michael S. Tsirkin)
- Remove unused pp_params.dev assignment in non-DMA path
- Add page pool recreation in virtnet_restore_up() for freeze/restore support (Chris Mason's 
Review Prompt)
- v6:
  https://lore.kernel.org/virtualization/20260208175410.1910001-1-vishs@meta.com/ 

Changes in v6:
- Drop page_pool_frag_offset_add() helper and switch to page_pool_alloc_va();
  page_pool_alloc_netmem() already handles internal fragmentation internally
  (Jakub Kicinski)
- v5:
  https://lore.kernel.org/virtualization/20260206002715.1885869-1-vishs@meta.com/

Benchmark results:

Configuration: pktgen TX -> tap -> vhost-net | virtio-net RX -> XDP_DROP

Small packets (64 bytes, mrg_rxbuf=off):
  1Q:  853,493 -> 868,923 pps  (+1.8%)
  2Q: 1,655,793 -> 1,696,707 pps (+2.5%)
  4Q: 3,143,375 -> 3,302,511 pps (+5.1%)
  8Q: 6,082,590 -> 6,156,894 pps (+1.2%)

Mergeable RX (64 bytes):
  1Q:   766,168 ->   814,493 pps  (+6.3%)
  2Q: 1,384,871 -> 1,670,639 pps (+20.6%)
  4Q: 2,773,081 -> 3,080,574 pps (+11.1%)
  8Q: 5,600,615 -> 6,043,891 pps  (+7.9%)

Mergeable RX (1500 bytes):
  1Q:   741,579 ->   785,442 pps  (+5.9%)
  2Q: 1,310,043 -> 1,534,554 pps (+17.1%)
  4Q: 2,748,700 -> 2,890,582 pps  (+5.2%)
  8Q: 5,348,589 -> 5,618,664 pps  (+5.0%)

 drivers/net/Kconfig      |   1 +
 drivers/net/virtio_net.c | 467 ++++++++++++++++++++-------------------
 2 files changed, 243 insertions(+), 225 deletions(-)

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
index db88dcaefb20..32aede2b1ed5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -26,6 +26,7 @@
 #include <net/netdev_rx_queue.h>
 #include <net/netdev_queues.h>
 #include <net/xdp_sock_drv.h>
+#include <net/page_pool/helpers.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -290,14 +291,6 @@ struct virtnet_interrupt_coalesce {
 	u32 max_usecs;
 };
 
-/* The dma information of pages allocated at a time. */
-struct virtnet_rq_dma {
-	dma_addr_t addr;
-	u32 ref;
-	u16 len;
-	u16 need_sync;
-};
-
 /* Internal representation of a send virtqueue */
 struct send_queue {
 	/* Virtqueue associated with this send _queue */
@@ -356,8 +349,10 @@ struct receive_queue {
 	/* Average packet length for mergeable receive buffers. */
 	struct ewma_pkt_len mrg_avg_pkt_len;
 
-	/* Page frag for packet buffer allocation. */
-	struct page_frag alloc_frag;
+	struct page_pool *page_pool;
+
+	/* True if page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
+	bool use_page_pool_dma;
 
 	/* RX: fragments + linear part + virtio header */
 	struct scatterlist sg[MAX_SKB_FRAGS + 2];
@@ -370,9 +365,6 @@ struct receive_queue {
 
 	struct xdp_rxq_info xdp_rxq;
 
-	/* Record the last dma info to free after new pages is allocated. */
-	struct virtnet_rq_dma *last_dma;
-
 	struct xsk_buff_pool *xsk_pool;
 
 	/* xdp rxq used by xsk */
@@ -521,11 +513,14 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
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
+static void virtnet_del_vqs(struct virtnet_info *vi);
 
 enum virtnet_xmit_type {
 	VIRTNET_XMIT_TYPE_SKB,
@@ -706,15 +701,18 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
 	return p;
 }
 
+static bool virtnet_no_page_pool(struct virtnet_info *vi)
+{
+	return vi->big_packets && !vi->mergeable_rx_bufs;
+}
+
 static void virtnet_rq_free_buf(struct virtnet_info *vi,
 				struct receive_queue *rq, void *buf)
 {
-	if (vi->mergeable_rx_bufs)
-		put_page(virt_to_head_page(buf));
-	else if (vi->big_packets)
+	if (virtnet_no_page_pool(vi))
 		give_pages(rq, buf);
 	else
-		put_page(virt_to_head_page(buf));
+		page_pool_put_page(rq->page_pool, virt_to_head_page(buf), -1, false);
 }
 
 static void enable_rx_mode_work(struct virtnet_info *vi)
@@ -876,10 +874,16 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 		skb = virtnet_build_skb(buf, truesize, p - buf, len);
 		if (unlikely(!skb))
 			return NULL;
+		/* Big packets mode chains pages via page->private, which is
+		 * incompatible with the way page_pool uses page->private.
+		 * Currently, big packets mode doesn't use page pools.
+		 */
+		if (virtnet_no_page_pool(vi)) {
+			page = (struct page *)page->private;
+			if (page)
+				give_pages(rq, page);
+		}
 
-		page = (struct page *)page->private;
-		if (page)
-			give_pages(rq, page);
 		goto ok;
 	}
 
@@ -925,133 +929,18 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	hdr = skb_vnet_common_hdr(skb);
 	memcpy(hdr, hdr_p, hdr_len);
 	if (page_to_free)
-		put_page(page_to_free);
+		page_pool_put_page(rq->page_pool, page_to_free, -1, true);
 
 	return skb;
 }
 
-static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
-{
-	struct virtnet_info *vi = rq->vq->vdev->priv;
-	struct page *page = virt_to_head_page(buf);
-	struct virtnet_rq_dma *dma;
-	void *head;
-	int offset;
-
-	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
-
-	head = page_address(page);
-
-	dma = head;
-
-	--dma->ref;
-
-	if (dma->need_sync && len) {
-		offset = buf - (head + sizeof(*dma));
-
-		virtqueue_map_sync_single_range_for_cpu(rq->vq, dma->addr,
-							offset, len,
-							DMA_FROM_DEVICE);
-	}
-
-	if (dma->ref)
-		return;
-
-	virtqueue_unmap_single_attrs(rq->vq, dma->addr, dma->len,
-				     DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
-	put_page(page);
-}
-
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
-
-	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
-
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
 
-	buf = head + alloc_frag->offset;
+	BUG_ON(virtnet_no_page_pool(vi));
 
-	get_page(alloc_frag->page);
-	alloc_frag->offset += size;
-
-	return buf;
+	return virtqueue_get_buf_ctx(rq->vq, len, ctx);
 }
 
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
@@ -1067,9 +956,6 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
 		return;
 	}
 
-	if (!vi->big_packets || vi->mergeable_rx_bufs)
-		virtnet_rq_unmap(rq, buf, 0);
-
 	virtnet_rq_free_buf(vi, rq, buf);
 }
 
@@ -1335,7 +1221,7 @@ static int xsk_append_merge_buffer(struct virtnet_info *vi,
 
 		truesize = len;
 
-		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
+		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
 						    buf, len, truesize);
 		if (!curr_skb) {
 			put_page(page);
@@ -1771,7 +1657,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	return ret;
 }
 
-static void put_xdp_frags(struct xdp_buff *xdp)
+static void put_xdp_frags(struct receive_queue *rq, struct xdp_buff *xdp)
 {
 	struct skb_shared_info *shinfo;
 	struct page *xdp_page;
@@ -1781,7 +1667,7 @@ static void put_xdp_frags(struct xdp_buff *xdp)
 		shinfo = xdp_get_shared_info_from_buff(xdp);
 		for (i = 0; i < shinfo->nr_frags; i++) {
 			xdp_page = skb_frag_page(&shinfo->frags[i]);
-			put_page(xdp_page);
+			page_pool_put_page(rq->page_pool, xdp_page, -1, true);
 		}
 	}
 }
@@ -1873,7 +1759,7 @@ static struct page *xdp_linearize_page(struct net_device *dev,
 	if (page_off + *len + tailroom > PAGE_SIZE)
 		return NULL;
 
-	page = alloc_page(GFP_ATOMIC);
+	page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
 	if (!page)
 		return NULL;
 
@@ -1896,8 +1782,12 @@ static struct page *xdp_linearize_page(struct net_device *dev,
 		p = virt_to_head_page(buf);
 		off = buf - page_address(p);
 
+		if (rq->use_page_pool_dma)
+			page_pool_dma_sync_for_cpu(rq->page_pool, p,
+						   off, buflen);
+
 		if (check_mergeable_len(dev, ctx, buflen)) {
-			put_page(p);
+			page_pool_put_page(rq->page_pool, p, -1, true);
 			goto err_buf;
 		}
 
@@ -1905,21 +1795,21 @@ static struct page *xdp_linearize_page(struct net_device *dev,
 		 * is sending packet larger than the MTU.
 		 */
 		if ((page_off + buflen + tailroom) > PAGE_SIZE) {
-			put_page(p);
+			page_pool_put_page(rq->page_pool, p, -1, true);
 			goto err_buf;
 		}
 
 		memcpy(page_address(page) + page_off,
 		       page_address(p) + off, buflen);
 		page_off += buflen;
-		put_page(p);
+		page_pool_put_page(rq->page_pool, p, -1, true);
 	}
 
 	/* Headroom does not contribute to packet length */
 	*len = page_off - XDP_PACKET_HEADROOM;
 	return page;
 err_buf:
-	__free_pages(page, 0);
+	page_pool_put_page(rq->page_pool, page, -1, true);
 	return NULL;
 }
 
@@ -1996,7 +1886,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 			goto err_xdp;
 
 		buf = page_address(xdp_page);
-		put_page(page);
+		page_pool_put_page(rq->page_pool, page, -1, true);
 		page = xdp_page;
 	}
 
@@ -2028,13 +1918,15 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	if (metasize)
 		skb_metadata_set(skb, metasize);
 
+	skb_mark_for_recycle(skb);
+
 	return skb;
 
 err_xdp:
 	u64_stats_inc(&stats->xdp_drops);
 err:
 	u64_stats_inc(&stats->drops);
-	put_page(page);
+	page_pool_put_page(rq->page_pool, page, -1, true);
 xdp_xmit:
 	return NULL;
 }
@@ -2056,6 +1948,13 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	 */
 	buf -= VIRTNET_RX_PAD + xdp_headroom;
 
+	if (rq->use_page_pool_dma) {
+		int offset = buf - page_address(page) +
+			     VIRTNET_RX_PAD + xdp_headroom;
+
+		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
+	}
+
 	len -= vi->hdr_len;
 	u64_stats_add(&stats->bytes, len);
 
@@ -2082,12 +1981,14 @@ static struct sk_buff *receive_small(struct net_device *dev,
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
+	page_pool_put_page(rq->page_pool, page, -1, true);
 	return NULL;
 }
 
@@ -2142,7 +2043,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
 		}
 		u64_stats_add(&stats->bytes, len);
 		page = virt_to_head_page(buf);
-		put_page(page);
+		page_pool_put_page(rq->page_pool, page, -1, true);
 	}
 }
 
@@ -2252,8 +2153,12 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 		page = virt_to_head_page(buf);
 		offset = buf - page_address(page);
 
+		if (rq->use_page_pool_dma)
+			page_pool_dma_sync_for_cpu(rq->page_pool, page,
+						   offset, len);
+
 		if (check_mergeable_len(dev, ctx, len)) {
-			put_page(page);
+			page_pool_put_page(rq->page_pool, page, -1, true);
 			goto err;
 		}
 
@@ -2272,7 +2177,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 	return 0;
 
 err:
-	put_xdp_frags(xdp);
+	put_xdp_frags(rq, xdp);
 	return -EINVAL;
 }
 
@@ -2337,7 +2242,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
 		if (*len + xdp_room > PAGE_SIZE)
 			return NULL;
 
-		xdp_page = alloc_page(GFP_ATOMIC);
+		xdp_page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
 		if (!xdp_page)
 			return NULL;
 
@@ -2347,7 +2252,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
 
 	*frame_sz = PAGE_SIZE;
 
-	put_page(*page);
+	page_pool_put_page(rq->page_pool, *page, -1, true);
 
 	*page = xdp_page;
 
@@ -2393,6 +2298,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 		head_skb = build_skb_from_xdp_buff(dev, vi, &xdp, xdp_frags_truesz);
 		if (unlikely(!head_skb))
 			break;
+
+		skb_mark_for_recycle(head_skb);
 		return head_skb;
 
 	case XDP_TX:
@@ -2403,10 +2310,10 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 		break;
 	}
 
-	put_xdp_frags(&xdp);
+	put_xdp_frags(rq, &xdp);
 
 err_xdp:
-	put_page(page);
+	page_pool_put_page(rq->page_pool, page, -1, true);
 	mergeable_buf_free(rq, num_buf, dev, stats);
 
 	u64_stats_inc(&stats->xdp_drops);
@@ -2414,7 +2321,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	return NULL;
 }
 
-static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
+static struct sk_buff *virtnet_skb_append_frag(struct receive_queue *rq,
+					       struct sk_buff *head_skb,
 					       struct sk_buff *curr_skb,
 					       struct page *page, void *buf,
 					       int len, int truesize)
@@ -2446,7 +2354,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
 
 	offset = buf - page_address(page);
 	if (skb_can_coalesce(curr_skb, num_skb_frags, page, offset)) {
-		put_page(page);
+		page_pool_put_page(rq->page_pool, page, -1, true);
 		skb_coalesce_rx_frag(curr_skb, num_skb_frags - 1,
 				     len, truesize);
 	} else {
@@ -2475,6 +2383,10 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	unsigned int headroom = mergeable_ctx_to_headroom(ctx);
 
 	head_skb = NULL;
+
+	if (rq->use_page_pool_dma)
+		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
+
 	u64_stats_add(&stats->bytes, len - vi->hdr_len);
 
 	if (check_mergeable_len(dev, ctx, len))
@@ -2499,6 +2411,8 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 
 	if (unlikely(!curr_skb))
 		goto err_skb;
+
+	skb_mark_for_recycle(head_skb);
 	while (--num_buf) {
 		buf = virtnet_rq_get_buf(rq, &len, &ctx);
 		if (unlikely(!buf)) {
@@ -2513,11 +2427,17 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		u64_stats_add(&stats->bytes, len);
 		page = virt_to_head_page(buf);
 
+		if (rq->use_page_pool_dma) {
+			offset = buf - page_address(page);
+			page_pool_dma_sync_for_cpu(rq->page_pool, page,
+						   offset, len);
+		}
+
 		if (check_mergeable_len(dev, ctx, len))
 			goto err_skb;
 
 		truesize = mergeable_ctx_to_truesize(ctx);
-		curr_skb  = virtnet_skb_append_frag(head_skb, curr_skb, page,
+		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
 						    buf, len, truesize);
 		if (!curr_skb)
 			goto err_skb;
@@ -2527,7 +2447,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	return head_skb;
 
 err_skb:
-	put_page(page);
+	page_pool_put_page(rq->page_pool, page, -1, true);
 	mergeable_buf_free(rq, num_buf, dev, stats);
 
 err_buf:
@@ -2666,32 +2586,40 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 			     gfp_t gfp)
 {
-	char *buf;
 	unsigned int xdp_headroom = virtnet_get_headroom(vi);
 	void *ctx = (void *)(unsigned long)xdp_headroom;
-	int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
+	unsigned int len = vi->hdr_len + VIRTNET_RX_PAD + GOOD_PACKET_LEN + xdp_headroom;
+	struct page *page;
+	dma_addr_t addr;
+	char *buf;
 	int err;
 
 	len = SKB_DATA_ALIGN(len) +
 	      SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
-		return -ENOMEM;
-
-	buf = virtnet_rq_alloc(rq, len, gfp);
+	buf = page_pool_alloc_va(rq->page_pool, &len, gfp);
 	if (unlikely(!buf))
 		return -ENOMEM;
 
 	buf += VIRTNET_RX_PAD + xdp_headroom;
 
-	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
+	if (rq->use_page_pool_dma) {
+		page = virt_to_head_page(buf);
+		addr = page_pool_get_dma_addr(page) +
+		       (buf - (char *)page_address(page));
 
-	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
-	if (err < 0) {
-		virtnet_rq_unmap(rq, buf, 0);
-		put_page(virt_to_head_page(buf));
+		sg_init_table(rq->sg, 1);
+		sg_fill_dma(rq->sg, addr, vi->hdr_len + GOOD_PACKET_LEN);
+		err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1,
+						    buf, ctx, gfp);
+	} else {
+		sg_init_one(rq->sg, buf, vi->hdr_len + GOOD_PACKET_LEN);
+		err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1,
+					      buf, ctx, gfp);
 	}
 
+	if (err < 0)
+		page_pool_put_page(rq->page_pool, virt_to_head_page(buf), -1, false);
 	return err;
 }
 
@@ -2764,13 +2692,14 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
 static int add_recvbuf_mergeable(struct virtnet_info *vi,
 				 struct receive_queue *rq, gfp_t gfp)
 {
-	struct page_frag *alloc_frag = &rq->alloc_frag;
 	unsigned int headroom = virtnet_get_headroom(vi);
 	unsigned int tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
 	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
-	unsigned int len, hole;
-	void *ctx;
+	unsigned int len, alloc_len;
+	struct page *page;
+	dma_addr_t addr;
 	char *buf;
+	void *ctx;
 	int err;
 
 	/* Extra tailroom is needed to satisfy XDP's assumption. This
@@ -2779,39 +2708,35 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
 	 */
 	len = get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
 
-	if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
-		return -ENOMEM;
-
-	if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_dma) > alloc_frag->size)
-		len -= sizeof(struct virtnet_rq_dma);
-
-	buf = virtnet_rq_alloc(rq, len + room, gfp);
+	alloc_len = len + room;
+	buf = page_pool_alloc_va(rq->page_pool, &alloc_len, gfp);
 	if (unlikely(!buf))
 		return -ENOMEM;
 
 	buf += headroom; /* advance address leaving hole at front of pkt */
-	hole = alloc_frag->size - alloc_frag->offset;
-	if (hole < len + room) {
-		/* To avoid internal fragmentation, if there is very likely not
-		 * enough space for another buffer, add the remaining space to
-		 * the current buffer.
-		 * XDP core assumes that frame_size of xdp_buff and the length
-		 * of the frag are PAGE_SIZE, so we disable the hole mechanism.
-		 */
-		if (!headroom)
-			len += hole;
-		alloc_frag->offset += hole;
-	}
 
-	virtnet_rq_init_one_sg(rq, buf, len);
+	if (!headroom)
+		len = alloc_len - room;
 
 	ctx = mergeable_len_to_ctx(len + room, headroom);
-	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
-	if (err < 0) {
-		virtnet_rq_unmap(rq, buf, 0);
-		put_page(virt_to_head_page(buf));
+
+	if (rq->use_page_pool_dma) {
+		page = virt_to_head_page(buf);
+		addr = page_pool_get_dma_addr(page) +
+		       (buf - (char *)page_address(page));
+
+		sg_init_table(rq->sg, 1);
+		sg_fill_dma(rq->sg, addr, len);
+		err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1,
+						    buf, ctx, gfp);
+	} else {
+		sg_init_one(rq->sg, buf, len);
+		err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1,
+					      buf, ctx, gfp);
 	}
 
+	if (err < 0)
+		page_pool_put_page(rq->page_pool, virt_to_head_page(buf), -1, false);
 	return err;
 }
 
@@ -2963,7 +2888,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
 	int packets = 0;
 	void *buf;
 
-	if (!vi->big_packets || vi->mergeable_rx_bufs) {
+	if (!virtnet_no_page_pool(vi)) {
 		void *ctx;
 		while (packets < budget &&
 		       (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
@@ -3128,7 +3053,10 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
 		return err;
 
 	err = xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
-					 MEM_TYPE_PAGE_SHARED, NULL);
+					 vi->rq[qp_index].page_pool ?
+						MEM_TYPE_PAGE_POOL :
+						MEM_TYPE_PAGE_SHARED,
+					 vi->rq[qp_index].page_pool);
 	if (err < 0)
 		goto err_xdp_reg_mem_model;
 
@@ -3168,6 +3096,82 @@ static void virtnet_update_settings(struct virtnet_info *vi)
 		vi->duplex = duplex;
 }
 
+static int virtnet_create_page_pools(struct virtnet_info *vi)
+{
+	int i, err;
+
+	if (virtnet_no_page_pool(vi))
+		return 0;
+
+	for (i = 0; i < vi->max_queue_pairs; i++) {
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
+		pp_params.order = 0;
+		pp_params.pool_size = virtqueue_get_vring_size(rq->vq);
+		pp_params.nid = dev_to_node(vi->vdev->dev.parent);
+		pp_params.netdev = vi->dev;
+		pp_params.napi = &rq->napi;
+
+		/* Use page_pool DMA mapping if backend supports DMA API.
+		 * DMA_SYNC_DEV is needed for non-coherent archs on recycle.
+		 */
+		dma_dev = virtqueue_dma_dev(rq->vq);
+		if (dma_dev) {
+			pp_params.dev = dma_dev;
+			pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+			pp_params.dma_dir = DMA_FROM_DEVICE;
+			pp_params.max_len = PAGE_SIZE;
+			pp_params.offset = 0;
+			rq->use_page_pool_dma = true;
+		} else {
+			/* No DMA API (e.g., VDUSE): page_pool for allocation only. */
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
@@ -5715,6 +5719,10 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 	if (err)
 		return err;
 
+	err = virtnet_create_page_pools(vi);
+	if (err)
+		goto err_del_vqs;
+
 	virtio_device_ready(vdev);
 
 	enable_rx_mode_work(vi);
@@ -5724,12 +5732,24 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 		err = virtnet_open(vi->dev);
 		rtnl_unlock();
 		if (err)
-			return err;
+			goto err_destroy_pools;
 	}
 
 	netif_tx_lock_bh(vi->dev);
 	netif_device_attach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
+	return 0;
+
+err_destroy_pools:
+	virtio_reset_device(vdev);
+	free_unused_bufs(vi);
+	virtnet_destroy_page_pools(vi);
+	virtnet_del_vqs(vi);
+	return err;
+
+err_del_vqs:
+	virtio_reset_device(vdev);
+	virtnet_del_vqs(vi);
 	return err;
 }
 
@@ -5857,7 +5877,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	/* In big_packets mode, xdp cannot work, so there is no need to
 	 * initialize xsk of rq.
 	 */
-	if (vi->big_packets && !vi->mergeable_rx_bufs)
+	if (virtnet_no_page_pool(vi))
 		return -ENOENT;
 
 	if (qid >= vi->curr_queue_pairs)
@@ -6287,17 +6307,6 @@ static void free_receive_bufs(struct virtnet_info *vi)
 	rtnl_unlock();
 }
 
-static void free_receive_page_frags(struct virtnet_info *vi)
-{
-	int i;
-	for (i = 0; i < vi->max_queue_pairs; i++)
-		if (vi->rq[i].alloc_frag.page) {
-			if (vi->rq[i].last_dma)
-				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
-			put_page(vi->rq[i].alloc_frag.page);
-		}
-}
-
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
@@ -6401,7 +6410,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 	vqs_info = kcalloc(total_vqs, sizeof(*vqs_info), GFP_KERNEL);
 	if (!vqs_info)
 		goto err_vqs_info;
-	if (!vi->big_packets || vi->mergeable_rx_bufs) {
+	if (!virtnet_no_page_pool(vi)) {
 		ctx = kcalloc(total_vqs, sizeof(*ctx), GFP_KERNEL);
 		if (!ctx)
 			goto err_ctx;
@@ -6441,10 +6450,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 		vi->rq[i].min_buf_len = mergeable_min_buf_len(vi, vi->rq[i].vq);
 		vi->sq[i].vq = vqs[txq2vq(i)];
 	}
-
 	/* run here: ret == 0. */
 
-
 err_find:
 	kfree(ctx);
 err_ctx:
@@ -6945,6 +6952,14 @@ static int virtnet_probe(struct virtio_device *vdev)
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
@@ -6958,7 +6973,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 		vi->failover = net_failover_create(vi->dev);
 		if (IS_ERR(vi->failover)) {
 			err = PTR_ERR(vi->failover);
-			goto free_vqs;
+			goto free_page_pools;
 		}
 	}
 
@@ -7075,9 +7090,11 @@ static int virtnet_probe(struct virtio_device *vdev)
 	unregister_netdev(dev);
 free_failover:
 	net_failover_destroy(vi->failover);
-free_vqs:
+free_page_pools:
+	virtnet_destroy_page_pools(vi);
+free_irq_moder:
+	virtnet_free_irq_moder(vi);
 	virtio_reset_device(vdev);
-	free_receive_page_frags(vi);
 	virtnet_del_vqs(vi);
 free:
 	free_netdev(dev);
@@ -7102,7 +7119,7 @@ static void remove_vq_common(struct virtnet_info *vi)
 
 	free_receive_bufs(vi);
 
-	free_receive_page_frags(vi);
+	virtnet_destroy_page_pools(vi);
 
 	virtnet_del_vqs(vi);
 }
-- 
2.47.3


