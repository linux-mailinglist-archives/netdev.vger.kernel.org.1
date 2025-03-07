Return-Path: <netdev+bounces-172848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9B6A564AC
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C03176326
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED47F2116EC;
	Fri,  7 Mar 2025 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="OSeBdJyB"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-33.ptr.blmpb.com (va-2-33.ptr.blmpb.com [209.127.231.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A58820DD52
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342151; cv=none; b=kyfrumkSBDUXbkTPBUh0n8MmHdy7j3idKS9mtpVNIi6a97yzR6i/bJRWSwtbcBiPR3Qu8jWXsNQByZ9oujcpoJqiqQkzzNlFJigCLypTx5wp6tf56vLaPJcs96QAHr5SsQZJ6OKFKEuy74X8Su0LSyG7YUmzV50nurGSVF1bS7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342151; c=relaxed/simple;
	bh=vCGEVJErN/0CNpmvg9piqp8LNtv8vLFRDqNYw5ecqy4=;
	h=Content-Type:To:Subject:References:From:Mime-Version:Cc:
	 Message-Id:Date:In-Reply-To; b=da1wd7U2Q6U9xszZtd2p7o1sD2TQnEAcLeXNEXpDuqubyFH+JXqz3EhpSz0vOKzrlhLal5fYi9RRSf9yCADVImo2vmoFw1pWQ/tpH2i6qXi4RKWb2OzB46+nYda/I84+a3DL5xhEG4vuL2nsfiJVC7LWA4b/2Cw+OhWavy8l/4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=OSeBdJyB; arc=none smtp.client-ip=209.127.231.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1741342139; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=gd/sFwTNGS6Oob9wv2U/pq8WRz9PAyzvn6/oreuvU08=;
 b=OSeBdJyBtfb1MaJjSQpAd5u3cYTB4N/WbKHUXey5kqfmnlJpXI385ct2rbAS1jOsMIhZXl
 DkpvZkZnDRpZZ2C3D/dILkjwHHfbJb2yZCCTSWCtVyPEadpUhq1ShQFDpdet3xdKZz5ogb
 NHZ1wWhPbncE1AcW5tXAYMZ7CubLP9uEZNTmBzZqoZd6w3JD89WcgP89mWF0VJOQlWN3Df
 ya1z8VmhDmN4aFN6AoFJcTCIyMfyX8tUhn3g53vhoVdfmeULc6Uqmfd+xenu/CJ6rk2D4u
 C74P10cStRCKNcz2gy3hjgkyS2+FRQ61XzmuNsvbN+2Bc60MPhXKbakgeaO6dw==
Content-Type: text/plain; charset=UTF-8
To: <netdev@vger.kernel.org>
Subject: [PATCH net-next v8 13/14] xsc: Add eth reception data path
References: <20250307100824.555320-1-tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Fri, 07 Mar 2025 18:08:57 +0800
X-Original-From: Xin Tian <tianx@yunsilicon.com>
From: "Xin Tian" <tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>
Message-Id: <20250307100855.555320-14-tianx@yunsilicon.com>
Date: Fri, 07 Mar 2025 18:08:57 +0800
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307100824.555320-1-tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267cac5b9+1c92e0+vger.kernel.org+tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit

rx data path:
1. The hardware writes incoming packets into the RQ ring buffer and
generates a event queue entry
2. The event handler function(xsc_eth_completion_event in
xsc_eth_events.c) is triggered, invokes napi_schedule() to schedule
a softirq.
3. The kernel triggers the softirq handler net_rx_action, which calls
the driver's NAPI poll function (xsc_eth_napi_poll in xsc_eth_txrx.c).
The driver retrieves CQEs from the Completion Queue (CQ) via
xsc_poll_rx_cq.
4. xsc_eth_build_rx_skb constructs an sk_buff structure, and submits the
SKB to the kernel network stack via napi_gro_receive
5. The driver recycles the RX buffer and notifies the NIC via
xsc_eth_post_rx_wqes to prepare for new packets.

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |   5 +
 .../yunsilicon/xsc/net/xsc_eth_common.h       |  28 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_rx.c  | 569 +++++++++++++++++-
 .../yunsilicon/xsc/net/xsc_eth_txrx.c         |  92 ++-
 .../yunsilicon/xsc/net/xsc_eth_txrx.h         |  28 +
 5 files changed, 710 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index 6bab80f90..17b631642 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -492,4 +492,9 @@ static inline u8 xsc_get_user_mode(struct xsc_core_device *xdev)
 	return xdev->user_mode;
 }
 
+static inline u8 get_cqe_opcode(struct xsc_cqe *cqe)
+{
+	return FIELD_GET(XSC_CQE_MSG_OPCD_MASK, le32_to_cpu(cqe->data0));
+}
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
index dea9280d1..161b0505c 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
@@ -22,6 +22,8 @@
 #define XSC_SW2HW_RX_PKT_LEN(mtu)	\
 	((mtu) + ETH_HLEN + XSC_ETH_RX_MAX_HEAD_ROOM)
 
+#define XSC_RX_MAX_HEAD			(256)
+
 #define XSC_QPN_SQN_STUB		1025
 #define XSC_QPN_RQN_STUB		1024
 
@@ -145,6 +147,24 @@ enum channel_flags {
 	XSC_CHANNEL_NAPI_SCHED = 1,
 };
 
+enum xsc_eth_priv_flag {
+	XSC_PFLAG_RX_NO_CSUM_COMPLETE,
+	XSC_PFLAG_SNIFFER,
+	XSC_PFLAG_DROPLESS_RQ,
+	XSC_PFLAG_RX_COPY_BREAK,
+	XSC_NUM_PFLAGS, /* Keep last */
+};
+
+#define XSC_SET_PFLAG(params, pflag, enable)			\
+	do {							\
+		if (enable)					\
+			(params)->pflags |= BIT(pflag);		\
+		else						\
+			(params)->pflags &= ~(BIT(pflag));	\
+	} while (0)
+
+#define XSC_GET_PFLAG(params, pflag) (!!((params)->pflags & (BIT(pflag))))
+
 struct xsc_eth_params {
 	u16	num_channels;
 	u16	max_num_ch;
@@ -208,4 +228,12 @@ union xsc_send_doorbell {
 	u32 send_data;
 };
 
+union xsc_recv_doorbell {
+	struct{
+		s32  next_pid : 13;
+		u32 qp_num : 15;
+	};
+	u32 recv_data;
+};
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
index e8a22f322..e957c60a2 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
@@ -5,44 +5,593 @@
  * Copyright (c) 2015-2016, Mellanox Technologies. All rights reserved.
  */
 
+#include <linux/net_tstamp.h>
+#include <linux/device.h>
+
+#include "common/xsc_pp.h"
+#include "xsc_eth.h"
 #include "xsc_eth_txrx.h"
+#include "xsc_eth_common.h"
+#include "xsc_pph.h"
+
+#define PAGE_REF_ELEV  (U16_MAX)
+/* Upper bound on number of packets that share a single page */
+#define PAGE_REF_THRSD (PAGE_SIZE / 64)
+
+static void xsc_rq_notify_hw(struct xsc_rq *rq)
+{
+	struct xsc_core_device *xdev = rq->cq.xdev;
+	union xsc_recv_doorbell doorbell_value;
+	struct xsc_wq_cyc *wq = &rq->wqe.wq;
+	u64 rqwqe_id;
+
+	rqwqe_id = wq->wqe_ctr << (ilog2(xdev->caps.recv_ds_num));
+	/*reverse wqe index to ds index*/
+	doorbell_value.next_pid = rqwqe_id;
+	doorbell_value.qp_num = rq->rqn;
+
+	/* Make sure that descriptors are written before
+	 * updating doorbell record and ringing the doorbell
+	 */
+	wmb();
+	writel(doorbell_value.recv_data, XSC_REG_ADDR(xdev, xdev->regs.rx_db));
+}
+
+static void xsc_skb_set_hash(struct xsc_adapter *adapter,
+			     struct xsc_cqe *cqe,
+			     struct sk_buff *skb)
+{
+	struct xsc_rss_params *rss = &adapter->rss_param;
+	bool l3_hash = false;
+	bool l4_hash = false;
+	u32 hash_field;
+	int ht = 0;
+
+	if (adapter->netdev->features & NETIF_F_RXHASH) {
+		if (skb->protocol == htons(ETH_P_IP)) {
+			hash_field = rss->rx_hash_fields[XSC_TT_IPV4_TCP];
+			if (hash_field & XSC_HASH_FIELD_SEL_SRC_IP ||
+			    hash_field & XSC_HASH_FIELD_SEL_DST_IP)
+				l3_hash = true;
+
+			if (hash_field & XSC_HASH_FIELD_SEL_SPORT ||
+			    hash_field & XSC_HASH_FIELD_SEL_DPORT)
+				l4_hash = true;
+		} else if (skb->protocol == htons(ETH_P_IPV6)) {
+			hash_field = rss->rx_hash_fields[XSC_TT_IPV6_TCP];
+			if (hash_field & XSC_HASH_FIELD_SEL_SRC_IPV6 ||
+			    hash_field & XSC_HASH_FIELD_SEL_DST_IPV6)
+				l3_hash = true;
+
+			if (hash_field & XSC_HASH_FIELD_SEL_SPORT_V6 ||
+			    hash_field & XSC_HASH_FIELD_SEL_DPORT_V6)
+				l4_hash = true;
+		}
+
+		if (l3_hash && l4_hash)
+			ht = PKT_HASH_TYPE_L4;
+		else if (l3_hash)
+			ht = PKT_HASH_TYPE_L3;
+		if (ht)
+			skb_set_hash(skb, le32_to_cpu(cqe->vni), ht);
+	}
+}
+
+static void xsc_handle_csum(struct xsc_cqe *cqe, struct xsc_rq *rq,
+			    struct sk_buff *skb, struct xsc_wqe_frag_info *wi)
+{
+	struct xsc_dma_info *dma_info;
+	struct net_device *netdev;
+	struct epp_pph *hw_pph;
+	struct xsc_channel *c;
+	int offset_from;
+
+	c = rq->cq.channel;
+	netdev = c->adapter->netdev;
+	dma_info = wi->di;
+	offset_from = wi->offset;
+	hw_pph = page_address(dma_info->page) + offset_from;
+
+	if (unlikely((netdev->features & NETIF_F_RXCSUM) == 0))
+		goto csum_none;
+
+	if (unlikely(XSC_GET_EPP2SOC_PPH_ERROR_BITMAP(hw_pph) & PACKET_UNKNOWN))
+		goto csum_none;
+
+	if (XSC_GET_EPP2SOC_PPH_EXT_TUNNEL_TYPE(hw_pph) &&
+	    (!(FIELD_GET(XSC_CQE_CSUM_ERR_MASK, le32_to_cpu(cqe->data0)) &
+	       OUTER_AND_INNER))) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		skb->csum_level = 1;
+		skb->encapsulation = 1;
+	} else if (XSC_GET_EPP2SOC_PPH_EXT_TUNNEL_TYPE(hw_pph) &&
+		   (!(FIELD_GET(XSC_CQE_CSUM_ERR_MASK,
+				le32_to_cpu(cqe->data0)) &
+		      OUTER_BIT) &&
+		    (FIELD_GET(XSC_CQE_CSUM_ERR_MASK,
+			       le32_to_cpu(cqe->data0)) &
+		     INNER_BIT))) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		skb->csum_level = 0;
+		skb->encapsulation = 1;
+	} else if (!XSC_GET_EPP2SOC_PPH_EXT_TUNNEL_TYPE(hw_pph) &&
+		   (!(FIELD_GET(XSC_CQE_CSUM_ERR_MASK,
+				le32_to_cpu(cqe->data0)) &
+		      OUTER_BIT))) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+	}
+
+	goto out;
+
+csum_none:
+	skb->csum = 0;
+	skb->ip_summed = CHECKSUM_NONE;
+out:
+	return;
+}
+
+static void xsc_build_rx_skb(struct xsc_cqe *cqe,
+			     u32 cqe_bcnt,
+			     struct xsc_rq *rq,
+			     struct sk_buff *skb,
+			     struct xsc_wqe_frag_info *wi)
+{
+	struct xsc_adapter *adapter;
+	struct net_device *netdev;
+	struct xsc_channel *c;
+
+	c = rq->cq.channel;
+	adapter = c->adapter;
+	netdev = c->netdev;
+
+	skb->mac_len = ETH_HLEN;
+
+	skb_record_rx_queue(skb, rq->ix);
+	xsc_handle_csum(cqe, rq, skb, wi);
+
+	skb->protocol = eth_type_trans(skb, netdev);
+	xsc_skb_set_hash(adapter, cqe, skb);
+}
+
+static void xsc_complete_rx_cqe(struct xsc_rq *rq,
+				struct xsc_cqe *cqe,
+				u32 cqe_bcnt,
+				struct sk_buff *skb,
+				struct xsc_wqe_frag_info *wi)
+{
+	xsc_build_rx_skb(cqe, cqe_bcnt, rq, skb, wi);
+}
+
+static void xsc_add_skb_frag(struct xsc_rq *rq,
+			     struct sk_buff *skb,
+			     struct xsc_dma_info *di,
+			     u32 frag_offset, u32 len,
+			     unsigned int truesize)
+{
+	struct xsc_channel *c = rq->cq.channel;
+	struct device *dev = c->adapter->dev;
+
+	dma_sync_single_for_cpu(dev, di->addr + frag_offset,
+				len, DMA_FROM_DEVICE);
+	page_ref_inc(di->page);
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+			di->page, frag_offset, len, truesize);
+}
+
+static void xsc_copy_skb_header(struct device *dev,
+				struct sk_buff *skb,
+				struct xsc_dma_info *dma_info,
+				int offset_from, u32 headlen)
+{
+	void *from = page_address(dma_info->page) + offset_from;
+	/* Aligning len to sizeof(long) optimizes memcpy performance */
+	unsigned int len = ALIGN(headlen, sizeof(long));
+
+	dma_sync_single_for_cpu(dev, dma_info->addr + offset_from, len,
+				DMA_FROM_DEVICE);
+	skb_copy_to_linear_data(skb, from, len);
+}
+
+static struct sk_buff *xsc_build_linear_skb(struct xsc_rq *rq, void *va,
+					    u32 frag_size, u16 headroom,
+					    u32 cqe_bcnt)
+{
+	struct sk_buff *skb = build_skb(va, frag_size);
+
+	if (unlikely(!skb))
+		return NULL;
+
+	skb_reserve(skb, headroom);
+	skb_put(skb, cqe_bcnt);
+
+	return skb;
+}
 
 struct sk_buff *xsc_skb_from_cqe_linear(struct xsc_rq *rq,
 					struct xsc_wqe_frag_info *wi,
 					u32 cqe_bcnt, u8 has_pph)
 {
-	/* TBD */
-	return NULL;
+	int pph_len = has_pph ? XSC_PPH_HEAD_LEN : 0;
+	u16 rx_headroom = rq->buff.headroom;
+	struct xsc_dma_info *di = wi->di;
+	struct sk_buff *skb;
+	void *va, *data;
+	u32 frag_size;
+
+	va = page_address(di->page) + wi->offset;
+	data = va + rx_headroom + pph_len;
+	frag_size = XSC_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
+
+	dma_sync_single_range_for_cpu(rq->cq.xdev->device, di->addr, wi->offset,
+				      frag_size, DMA_FROM_DEVICE);
+	net_prefetchw(va); /* xdp_frame data area */
+	net_prefetch(data);
+
+	skb = xsc_build_linear_skb(rq, va, frag_size, (rx_headroom + pph_len),
+				   (cqe_bcnt - pph_len));
+	if (unlikely(!skb))
+		return NULL;
+
+	/* queue up for recycling/reuse */
+	page_ref_inc(di->page);
+
+	return skb;
 }
 
 struct sk_buff *xsc_skb_from_cqe_nonlinear(struct xsc_rq *rq,
 					   struct xsc_wqe_frag_info *wi,
 					   u32 cqe_bcnt, u8 has_pph)
 {
-	/* TBD */
-	return NULL;
+	struct xsc_rq_frag_info *frag_info = &rq->wqe.info.arr[0];
+	u16 headlen  = min_t(u32, XSC_RX_MAX_HEAD, cqe_bcnt);
+	struct xsc_wqe_frag_info *head_wi = wi;
+	struct xsc_wqe_frag_info *rx_wi = wi;
+	u16 head_offset = head_wi->offset;
+	u16 byte_cnt = cqe_bcnt - headlen;
+	u16 frag_consumed_bytes = 0;
+	u16 frag_headlen = headlen;
+	struct net_device *netdev;
+	struct xsc_channel *c;
+	struct sk_buff *skb;
+	struct device *dev;
+	u8 fragcnt = 0;
+	int i = 0;
+
+	c = rq->cq.channel;
+	dev = c->adapter->dev;
+	netdev = c->adapter->netdev;
+
+	skb = napi_alloc_skb(rq->cq.napi, ALIGN(XSC_RX_MAX_HEAD, sizeof(long)));
+	if (unlikely(!skb))
+		return NULL;
+
+	net_prefetchw(skb->data);
+
+	if (likely(has_pph)) {
+		headlen = min_t(u32, XSC_RX_MAX_HEAD,
+				(cqe_bcnt - XSC_PPH_HEAD_LEN));
+		frag_headlen = headlen + XSC_PPH_HEAD_LEN;
+		byte_cnt = cqe_bcnt - headlen - XSC_PPH_HEAD_LEN;
+		head_offset += XSC_PPH_HEAD_LEN;
+	}
+
+	if (byte_cnt == 0 &&
+	    (XSC_GET_PFLAG(&c->adapter->nic_param, XSC_PFLAG_RX_COPY_BREAK))) {
+		for (i = 0; i < rq->wqe.info.num_frags; i++, wi++)
+			wi->is_available = 1;
+		goto out;
+	}
+
+	for (i = 0; i < rq->wqe.info.num_frags; i++, rx_wi++)
+		rx_wi->is_available = 0;
+
+	while (byte_cnt) {
+		/*figure out whether the first fragment can be a page ?*/
+		frag_consumed_bytes =
+			min_t(u16, frag_info->frag_size - frag_headlen,
+			      byte_cnt);
+
+		xsc_add_skb_frag(rq, skb, wi->di, wi->offset + frag_headlen,
+				 frag_consumed_bytes, frag_info->frag_stride);
+		byte_cnt -= frag_consumed_bytes;
+
+		/*to protect extend wqe read, drop exceed bytes*/
+		frag_headlen = 0;
+		fragcnt++;
+		if (fragcnt == rq->wqe.info.num_frags) {
+			if (byte_cnt) {
+				netdev_warn(netdev,
+					    "large packet reach the maximum rev-wqe num.\n");
+				netdev_warn(netdev,
+					    "%u bytes dropped: frag_num=%d, headlen=%d, cqe_cnt=%d, frag0_bytes=%d, frag_size=%d\n",
+					    byte_cnt, fragcnt,
+					    headlen, cqe_bcnt,
+					    frag_consumed_bytes,
+					    frag_info->frag_size);
+			}
+			break;
+		}
+
+		frag_info++;
+		wi++;
+	}
+
+out:
+	/* copy header */
+	xsc_copy_skb_header(dev, skb, head_wi->di, head_offset, headlen);
+
+	/* skb linear part was allocated with headlen and aligned to long */
+	skb->tail += headlen;
+	skb->len += headlen;
+
+	return skb;
+}
+
+static void xsc_page_dma_unmap(struct xsc_rq *rq, struct xsc_dma_info *dma_info)
+{
+	struct xsc_channel *c = rq->cq.channel;
+	struct device *dev = c->adapter->dev;
+
+	dma_unmap_page(dev, dma_info->addr, XSC_RX_FRAG_SZ, rq->buff.map_dir);
+}
+
+static void xsc_page_release_dynamic(struct xsc_rq *rq,
+				     struct xsc_dma_info *dma_info,
+				     bool recycle)
+{
+	xsc_page_dma_unmap(rq, dma_info);
+	page_pool_recycle_direct(rq->page_pool, dma_info->page);
+}
+
+static void xsc_put_rx_frag(struct xsc_rq *rq,
+			    struct xsc_wqe_frag_info *frag, bool recycle)
+{
+	if (frag->last_in_page)
+		xsc_page_release_dynamic(rq, frag->di, recycle);
+}
+
+static struct xsc_wqe_frag_info *get_frag(struct xsc_rq *rq, u16 ix)
+{
+	return &rq->wqe.frags[ix << rq->wqe.info.log_num_frags];
+}
+
+static void xsc_free_rx_wqe(struct xsc_rq *rq,
+			    struct xsc_wqe_frag_info *wi, bool recycle)
+{
+	int i;
+
+	for (i = 0; i < rq->wqe.info.num_frags; i++, wi++) {
+		if (wi->is_available && recycle)
+			continue;
+		xsc_put_rx_frag(rq, wi, recycle);
+	}
+}
+
+static void xsc_dump_error_rqcqe(struct xsc_rq *rq,
+				 struct xsc_cqe *cqe)
+{
+	struct net_device *netdev;
+	struct xsc_channel *c;
+	u32 ci;
+
+	c = rq->cq.channel;
+	netdev  = c->adapter->netdev;
+	ci = xsc_cqwq_get_ci(&rq->cq.wq);
+
+	net_err_ratelimited("Error cqe on dev=%s, cqn=%d, ci=%d, rqn=%d, qpn=%ld, error_code=0x%x\n",
+			    netdev->name, rq->cq.xcq.cqn, ci,
+			    rq->rqn,
+			    FIELD_GET(XSC_CQE_QP_ID_MASK,
+				      le32_to_cpu(cqe->data0)),
+			    get_cqe_opcode(cqe));
 }
 
 void xsc_eth_handle_rx_cqe(struct xsc_cqwq *cqwq,
 			   struct xsc_rq *rq, struct xsc_cqe *cqe)
 {
-	/* TBD */
+	struct xsc_channel *c = rq->cq.channel;
+	struct xsc_wq_cyc *wq = &rq->wqe.wq;
+	u8 cqe_opcode = get_cqe_opcode(cqe);
+	struct xsc_wqe_frag_info *wi;
+	struct sk_buff *skb;
+	u32 cqe_bcnt;
+	u16 ci;
+
+	ci = xsc_wq_cyc_ctr2ix(wq, cqwq->cc);
+	wi = get_frag(rq, ci);
+	if (unlikely(cqe_opcode & BIT(7))) {
+		xsc_dump_error_rqcqe(rq, cqe);
+		goto free_wqe;
+	}
+
+	cqe_bcnt = le32_to_cpu(cqe->msg_len);
+	if ((le32_to_cpu(cqe->data0) & XSC_CQE_HAS_PPH) &&
+	    cqe_bcnt <= XSC_PPH_HEAD_LEN)
+		goto free_wqe;
+
+	if (unlikely(cqe_bcnt > rq->frags_sz)) {
+		if (!XSC_GET_PFLAG(&c->adapter->nic_param,
+				   XSC_PFLAG_DROPLESS_RQ))
+			goto free_wqe;
+	}
+
+	cqe_bcnt = min_t(u32, cqe_bcnt, rq->frags_sz);
+	skb = rq->wqe.skb_from_cqe(rq, wi, cqe_bcnt,
+				   !!(le32_to_cpu(cqe->data0) &
+				      XSC_CQE_HAS_PPH));
+	if (!skb)
+		goto free_wqe;
+
+	xsc_complete_rx_cqe(rq, cqe,
+			    (le32_to_cpu(cqe->data0) & XSC_CQE_HAS_PPH) ?
+			    cqe_bcnt - XSC_PPH_HEAD_LEN : cqe_bcnt,
+			    skb, wi);
+
+	napi_gro_receive(rq->cq.napi, skb);
+
+free_wqe:
+	xsc_free_rx_wqe(rq, wi, true);
+	xsc_wq_cyc_pop(wq);
 }
 
 int xsc_poll_rx_cq(struct xsc_cq *cq, int budget)
 {
-	/* TBD */
+	struct xsc_rq *rq = container_of(cq, struct xsc_rq, cq);
+	struct xsc_cqwq *cqwq = &cq->wq;
+	struct xsc_cqe *cqe;
+	int work_done = 0;
+
+	if (!test_bit(XSC_ETH_RQ_STATE_ENABLED, &rq->state))
+		return 0;
+
+	while ((work_done < budget) && (cqe = xsc_cqwq_get_cqe(cqwq))) {
+		rq->handle_rx_cqe(cqwq, rq, cqe);
+		++work_done;
+
+		xsc_cqwq_pop(cqwq);
+	}
+
+	if (!work_done)
+		goto out;
+
+	xsc_cq_notify_hw(cq);
+	/* ensure cq space is freed before enabling more cqes */
+	wmb();
+
+out:
+	return work_done;
+}
+
+static int xsc_page_alloc_mapped(struct xsc_rq *rq,
+				 struct xsc_dma_info *dma_info)
+{
+	struct xsc_channel *c = rq->cq.channel;
+	struct device *dev = c->adapter->dev;
+
+	dma_info->page = page_pool_dev_alloc_pages(rq->page_pool);
+	if (unlikely(!dma_info->page))
+		return -ENOMEM;
+
+	dma_info->addr = dma_map_page(dev, dma_info->page, 0,
+				      XSC_RX_FRAG_SZ, rq->buff.map_dir);
+	if (unlikely(dma_mapping_error(dev, dma_info->addr))) {
+		page_pool_recycle_direct(rq->page_pool, dma_info->page);
+		dma_info->page = NULL;
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 
+static int xsc_get_rx_frag(struct xsc_rq *rq,
+			   struct xsc_wqe_frag_info *frag)
+{
+	int err = 0;
+
+	if (!frag->offset && !frag->is_available)
+		/* On first frag (offset == 0), replenish page (dma_info
+		 * actually). Other frags that point to the same dma_info
+		 * (with a different offset) should just use the new one
+		 * without replenishing again by themselves.
+		 */
+		err = xsc_page_alloc_mapped(rq, frag->di);
+
+	return err;
+}
+
+static int xsc_alloc_rx_wqe(struct xsc_rq *rq,
+			    struct xsc_eth_rx_wqe_cyc *wqe,
+			    u16 ix)
+{
+	struct xsc_wqe_frag_info *frag = get_frag(rq, ix);
+	u64 addr;
+	int err;
+	int i;
+
+	for (i = 0; i < rq->wqe.info.num_frags; i++, frag++) {
+		err = xsc_get_rx_frag(rq, frag);
+		if (unlikely(err))
+			goto err_free_frags;
+
+		addr = frag->di->addr + frag->offset + rq->buff.headroom;
+		wqe->data[i].va = cpu_to_le64(addr);
+	}
+
+	return 0;
+
+err_free_frags:
+	while (--i >= 0)
+		xsc_put_rx_frag(rq, --frag, true);
+
+	return err;
+}
+
 void xsc_eth_dealloc_rx_wqe(struct xsc_rq *rq, u16 ix)
 {
-	/* TBD */
+	struct xsc_wqe_frag_info *wi = get_frag(rq, ix);
+
+	xsc_free_rx_wqe(rq, wi, false);
 }
 
-bool xsc_eth_post_rx_wqes(struct xsc_rq *rq)
+static int xsc_alloc_rx_wqes(struct xsc_rq *rq, u16 ix, u8 wqe_bulk)
 {
-	/* TBD */
-	return true;
+	struct xsc_wq_cyc *wq = &rq->wqe.wq;
+	struct xsc_eth_rx_wqe_cyc *wqe;
+	int err;
+	int idx;
+	int i;
+
+	for (i = 0; i < wqe_bulk; i++) {
+		idx = xsc_wq_cyc_ctr2ix(wq, (ix + i));
+		wqe = xsc_wq_cyc_get_wqe(wq, idx);
+
+		err = xsc_alloc_rx_wqe(rq, wqe, idx);
+		if (unlikely(err))
+			goto err_free_wqes;
+	}
+
+	return 0;
+
+err_free_wqes:
+	while (--i >= 0)
+		xsc_eth_dealloc_rx_wqe(rq, ix + i);
+
+	return err;
 }
 
+bool xsc_eth_post_rx_wqes(struct xsc_rq *rq)
+{
+	struct xsc_wq_cyc *wq = &rq->wqe.wq;
+	u8 wqe_bulk, wqe_bulk_min;
+	int alloc;
+	u16 head;
+	int err;
+
+	wqe_bulk = rq->wqe.info.wqe_bulk;
+	wqe_bulk_min = rq->wqe.info.wqe_bulk_min;
+	if (xsc_wq_cyc_missing(wq) < wqe_bulk)
+		return false;
+
+	do {
+		head = xsc_wq_cyc_get_head(wq);
+
+		alloc = min_t(int, wqe_bulk, xsc_wq_cyc_missing(wq));
+		if (alloc < wqe_bulk && alloc >= wqe_bulk_min)
+			alloc = alloc & 0xfffffffe;
+
+		if (alloc > 0) {
+			err = xsc_alloc_rx_wqes(rq, head, alloc);
+			if (unlikely(err))
+				break;
+
+			xsc_wq_cyc_push_n(wq, alloc);
+		}
+	} while (xsc_wq_cyc_missing(wq) >= wqe_bulk_min);
+
+	dma_wmb();
+
+	/* ensure wqes are visible to device before updating doorbell record */
+	xsc_rq_notify_hw(rq);
+
+	return !!err;
+}
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
index 5d1fcb669..8140b66bb 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
@@ -42,10 +42,98 @@ static bool xsc_channel_no_affinity_change(struct xsc_channel *c)
 	return cpumask_test_cpu(current_cpu, c->aff_mask);
 }
 
+static void xsc_dump_error_sqcqe(struct xsc_sq *sq,
+				 struct xsc_cqe *cqe)
+{
+	struct net_device *netdev = sq->channel->netdev;
+	u32 ci = xsc_cqwq_get_ci(&sq->cq.wq);
+
+	net_err_ratelimited("Err cqe on dev %s cqn=0x%x ci=0x%x sqn=0x%x err_code=0x%x qpid=0x%lx\n",
+			    netdev->name, sq->cq.xcq.cqn, ci,
+			    sq->sqn, get_cqe_opcode(cqe),
+			    FIELD_GET(XSC_CQE_QP_ID_MASK,
+				      le32_to_cpu(cqe->data0)));
+}
+
 static bool xsc_poll_tx_cq(struct xsc_cq *cq, int napi_budget)
 {
-	/* TBD */
-	return true;
+	struct xsc_adapter *adapter;
+	struct xsc_cqe *cqe;
+	struct device *dev;
+	struct xsc_sq *sq;
+	u32 dma_fifo_cc;
+	u32 nbytes = 0;
+	u16 npkts = 0;
+	int i = 0;
+	u16 sqcc;
+
+	sq = container_of(cq, struct xsc_sq, cq);
+	if (!test_bit(XSC_ETH_SQ_STATE_ENABLED, &sq->state))
+		return false;
+
+	adapter = sq->channel->adapter;
+	dev = adapter->dev;
+
+	cqe = xsc_cqwq_get_cqe(&cq->wq);
+	if (!cqe)
+		goto out;
+
+	if (unlikely(get_cqe_opcode(cqe) & BIT(7))) {
+		xsc_dump_error_sqcqe(sq, cqe);
+		return false;
+	}
+
+	sqcc = sq->cc;
+
+	/* avoid dirtying sq cache line every cqe */
+	dma_fifo_cc = sq->dma_fifo_cc;
+	i = 0;
+	do {
+		struct xsc_tx_wqe_info *wi;
+		struct sk_buff *skb;
+		int j;
+		u16 ci;
+
+		xsc_cqwq_pop(&cq->wq);
+
+		ci = xsc_wq_cyc_ctr2ix(&sq->wq, sqcc);
+		wi = &sq->db.wqe_info[ci];
+		skb = wi->skb;
+
+		/*cqe may be overstanding in real test, not by nop in other*/
+		if (unlikely(!skb))
+			continue;
+
+		for (j = 0; j < wi->num_dma; j++) {
+			struct xsc_sq_dma *dma = xsc_dma_get(sq, dma_fifo_cc++);
+
+			xsc_tx_dma_unmap(dev, dma);
+		}
+
+		npkts++;
+		nbytes += wi->num_bytes;
+		sqcc += wi->num_wqebbs;
+		napi_consume_skb(skb, 0);
+
+	} while ((++i <= napi_budget) && (cqe = xsc_cqwq_get_cqe(&cq->wq)));
+
+	xsc_cq_notify_hw(cq);
+
+	/* ensure cq space is freed before enabling more cqes */
+	wmb();
+
+	sq->dma_fifo_cc = dma_fifo_cc;
+	sq->cc = sqcc;
+
+	netdev_tx_completed_queue(sq->txq, npkts, nbytes);
+
+	if (netif_tx_queue_stopped(sq->txq) &&
+	    xsc_wqc_has_room_for(&sq->wq, sq->cc, sq->pc, sq->stop_room)) {
+		netif_tx_wake_queue(sq->txq);
+	}
+
+out:
+	return (i == napi_budget);
 }
 
 int xsc_eth_napi_poll(struct napi_struct *napi, int budget)
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
index 68f3347e4..d0d303efa 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
@@ -60,4 +60,32 @@ static inline bool xsc_wqc_has_room_for(struct xsc_wq_cyc *wq,
 	return (xsc_wq_cyc_ctr2ix(wq, cc - pc) >= n) || (cc == pc);
 }
 
+static inline struct xsc_cqe *xsc_cqwq_get_cqe_buff(struct xsc_cqwq *wq, u32 ix)
+{
+	struct xsc_cqe *cqe = xsc_frag_buf_get_wqe(&wq->fbc, ix);
+
+	return cqe;
+}
+
+static inline struct xsc_cqe *xsc_cqwq_get_cqe(struct xsc_cqwq *wq)
+{
+	u32 ci = xsc_cqwq_get_ci(wq);
+	u8 cqe_ownership_bit;
+	struct xsc_cqe *cqe;
+	u8 sw_ownership_val;
+
+	cqe = xsc_cqwq_get_cqe_buff(wq, ci);
+
+	cqe_ownership_bit = !!(le32_to_cpu(cqe->data1) & XSC_CQE_OWNER);
+	sw_ownership_val = xsc_cqwq_get_wrap_cnt(wq) & 1;
+
+	if (cqe_ownership_bit != sw_ownership_val)
+		return NULL;
+
+	/* ensure cqe content is read after cqe ownership bit */
+	dma_rmb();
+
+	return cqe;
+}
+
 #endif /* XSC_RXTX_H */
-- 
2.43.0

