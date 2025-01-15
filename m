Return-Path: <netdev+bounces-158468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8041AA11F3C
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E961F188F05A
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BAC23F271;
	Wed, 15 Jan 2025 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="DQuf8912"
X-Original-To: netdev@vger.kernel.org
Received: from lf-1-33.ptr.blmpb.com (lf-1-33.ptr.blmpb.com [103.149.242.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7D91EEA42
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.149.242.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736936674; cv=none; b=rPdB+uGgbPmijGrMRJXpP2e3oXYKGo6kHH8BF8w6/lhJ1Y5bIo0ebPl1eKEudZinJoY+HjM9Rle8PSoP//gbZ6oEO5jLjHysycZmwMUzOCmP0iC3Zdu1jDvmMqqaT1B0H59kqlA+B2NHrZr40iFKxXEttOsLwyVkaa9txlBsM34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736936674; c=relaxed/simple;
	bh=nTbQmL9ztGrt8NCC+2P4ntTgLx0rRlwiGTjKg7bGQ/s=;
	h=In-Reply-To:References:From:Subject:Date:Message-Id:Cc:
	 Mime-Version:Content-Type:To; b=oaBx27yX9f8YJ3dWAtz/WMhOOB+YRzsmU8wapSPqzT6YBoGsef9m2HdYS6iQwRorxTCrjLSnYBLSBANSRzICIgu5xWqcB+e0lrtlYtSeriRD6piPqARUuQslFZ9yCW/u4XGTWhpqznFiA6LoBiyT2zn6khZv0IsawlTpkcMXONQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=DQuf8912; arc=none smtp.client-ip=103.149.242.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1736936593; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=HAJnhN+IOjYMpK0F6EK0sTwVgHe61PCUDEekEieksfU=;
 b=DQuf89122VbDa1FufamA26lKcPEKEXfl5TFtLdr4CTmZCN5i7aXLUt83bbI+/l3Uz4zzSl
 q5FkIV6V6PDYYWJoa6tm/8dTWxqpHUl10v6TqWVqiYQyttb0UHm2LI/lThSnR6A1TFuC6p
 dS9+/5UlCfJRuNzhaDb1VEYVj9s65lGXYunSYZKG3z+SyeL2GvAjL24Cu6YVTvTHSZ5Fzr
 e5vjG1pfI891Sr6clDoTTxccuCtuwQYq7nRYSx9zBr8nkYF22V+TaMIuIscFK2BzW7nrA9
 X6mN7Ubxfc8MyXvEMJP7DCo0nR51ZyMfeVo7XE6l+q5LvzzUvEDL0DbYF5W5AA==
X-Original-From: Xin Tian <tianx@yunsilicon.com>
In-Reply-To: <20250115102242.3541496-1-tianx@yunsilicon.com>
References: <20250115102242.3541496-1-tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
From: "Xin Tian" <tianx@yunsilicon.com>
Subject: [PATCH v3 12/14] net-next/yunsilicon: Add ndo_start_xmit
Date: Wed, 15 Jan 2025 18:23:10 +0800
Message-Id: <20250115102309.3541496-13-tianx@yunsilicon.com>
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Wed, 15 Jan 2025 18:23:10 +0800
X-Lms-Return-Path: <lba+267878c8f+83b2d1+vger.kernel.org+tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>

Add ndo_start_xmit

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../net/ethernet/yunsilicon/xsc/net/Makefile  |   2 +-
 .../net/ethernet/yunsilicon/xsc/net/main.c    |   1 +
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |   1 +
 .../yunsilicon/xsc/net/xsc_eth_common.h       |   8 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_tx.c  | 290 ++++++++++++++++++
 .../yunsilicon/xsc/net/xsc_eth_txrx.h         |  36 +++
 .../ethernet/yunsilicon/xsc/net/xsc_queue.h   |   7 +
 7 files changed, 344 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c

diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
index 104ef5330..7cfc2aaa2 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
@@ -6,4 +6,4 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc_eth.o
 
-xsc_eth-y := main.o xsc_eth_wq.o xsc_eth_txrx.o xsc_eth_rx.o
+xsc_eth-y := main.o xsc_eth_wq.o xsc_eth_txrx.o xsc_eth_tx.o xsc_eth_rx.o
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
index 163fc2f55..b52f0db29 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -1642,6 +1642,7 @@ static int xsc_eth_set_hw_mtu(struct xsc_core_device *xdev, u16 mtu, u16 rx_buf_
 static const struct net_device_ops xsc_netdev_ops = {
 	.ndo_open		= xsc_eth_open,
 	.ndo_stop		= xsc_eth_close,
+	.ndo_start_xmit		= xsc_eth_xmit_start,
 };
 
 static void xsc_eth_build_nic_netdev(struct xsc_adapter *adapter)
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
index 09af22d92..87e2a72d3 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
@@ -6,6 +6,7 @@
 #ifndef __XSC_ETH_H
 #define __XSC_ETH_H
 
+#include <linux/udp.h>
 #include "common/xsc_device.h"
 #include "xsc_eth_common.h"
 
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
index a402f8ff7..5fc81a3f6 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
@@ -200,4 +200,12 @@ struct xsc_eth_channels {
 	u32 rqn_base;
 };
 
+union xsc_send_doorbell {
+	struct{
+		s32  next_pid : 16;
+		u32 qp_num : 15;
+	};
+	u32 send_data;
+};
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c
new file mode 100644
index 000000000..bd9c4e1c0
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <linux/tcp.h>
+#include "xsc_eth.h"
+#include "xsc_eth_txrx.h"
+
+#define XSC_OPCODE_RAW 7
+
+static void xsc_dma_push(struct xsc_sq *sq, dma_addr_t addr, u32 size,
+			 enum xsc_dma_map_type map_type)
+{
+	struct xsc_sq_dma *dma = xsc_dma_get(sq, sq->dma_fifo_pc++);
+
+	dma->addr = addr;
+	dma->size = size;
+	dma->type = map_type;
+}
+
+static void xsc_dma_unmap_wqe_err(struct xsc_sq *sq, u8 num_dma)
+{
+	struct xsc_adapter *adapter = sq->channel->adapter;
+	struct device *dev  = adapter->dev;
+
+	int i;
+
+	for (i = 0; i < num_dma; i++) {
+		struct xsc_sq_dma *last_pushed_dma = xsc_dma_get(sq, --sq->dma_fifo_pc);
+
+		xsc_tx_dma_unmap(dev, last_pushed_dma);
+	}
+}
+
+static void *xsc_sq_fetch_wqe(struct xsc_sq *sq, size_t size, u16 *pi)
+{
+	struct xsc_wq_cyc *wq = &sq->wq;
+	void *wqe;
+
+	/*caution, sp->pc is default to be zero*/
+	*pi  = xsc_wq_cyc_ctr2ix(wq, sq->pc);
+	wqe = xsc_wq_cyc_get_wqe(wq, *pi);
+	memset(wqe, 0, size);
+
+	return wqe;
+}
+
+static u16 xsc_tx_get_gso_ihs(struct xsc_sq *sq, struct sk_buff *skb)
+{
+	u16 ihs;
+
+	if (skb->encapsulation) {
+		ihs = skb_inner_transport_offset(skb) + inner_tcp_hdrlen(skb);
+	} else {
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+			ihs = skb_transport_offset(skb) + sizeof(struct udphdr);
+		else
+			ihs = skb_transport_offset(skb) + tcp_hdrlen(skb);
+	}
+
+	return ihs;
+}
+
+static void xsc_txwqe_build_cseg_csum(struct xsc_sq *sq,
+				      struct sk_buff *skb,
+				      struct xsc_send_wqe_ctrl_seg *cseg)
+{
+	if (likely(skb->ip_summed == CHECKSUM_PARTIAL)) {
+		if (skb->encapsulation)
+			cseg->csum_en = XSC_ETH_WQE_INNER_AND_OUTER_CSUM;
+		else
+			cseg->csum_en = XSC_ETH_WQE_OUTER_CSUM;
+	} else {
+		cseg->csum_en = XSC_ETH_WQE_NONE_CSUM;
+	}
+}
+
+static void xsc_txwqe_build_csegs(struct xsc_sq *sq, struct sk_buff *skb,
+				  u16 mss, u16 ihs, u16 headlen,
+				  u8 opcode, u16 ds_cnt, u32 num_bytes,
+				  struct xsc_send_wqe_ctrl_seg *cseg)
+{
+	struct xsc_core_device *xdev = sq->cq.xdev;
+	int send_wqe_ds_num_log = ilog2(xdev->caps.send_ds_num);
+
+	xsc_txwqe_build_cseg_csum(sq, skb, cseg);
+
+	if (mss != 0) {
+		cseg->has_pph = 0;
+		cseg->so_type = 1;
+		cseg->so_hdr_len = ihs;
+		cseg->so_data_size = cpu_to_le16(mss);
+	}
+
+	cseg->msg_opcode =  opcode;
+	cseg->wqe_id = cpu_to_le16(sq->pc << send_wqe_ds_num_log);
+	cseg->ds_data_num = ds_cnt - XSC_SEND_WQEBB_CTRL_NUM_DS;
+	cseg->msg_len = cpu_to_le32(num_bytes);
+
+	cseg->ce = 1;
+}
+
+static int xsc_txwqe_build_dsegs(struct xsc_sq *sq, struct sk_buff *skb,
+				 u16 ihs, u16 headlen,
+				 struct xsc_wqe_data_seg *dseg)
+{
+	dma_addr_t dma_addr = 0;
+	u8 num_dma = 0;
+	int i;
+	struct xsc_adapter *adapter = sq->channel->adapter;
+	struct device *dev  = adapter->dev;
+
+	if (headlen) {
+		dma_addr = dma_map_single(dev, skb->data, headlen, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(dev, dma_addr)))
+			goto dma_unmap_wqe_err;
+
+		dseg->va = cpu_to_le64(dma_addr);
+		dseg->mkey  = cpu_to_le32(sq->mkey_be);
+		dseg->seg_len = cpu_to_le32(headlen);
+
+		xsc_dma_push(sq, dma_addr, headlen, XSC_DMA_MAP_SINGLE);
+		num_dma++;
+		dseg++;
+	}
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		int fsz = skb_frag_size(frag);
+
+		dma_addr = skb_frag_dma_map(dev, frag, 0, fsz, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(dev, dma_addr)))
+			goto dma_unmap_wqe_err;
+
+		dseg->va = cpu_to_le64(dma_addr);
+		dseg->mkey = cpu_to_le32(sq->mkey_be);
+		dseg->seg_len = cpu_to_le32(fsz);
+
+		xsc_dma_push(sq, dma_addr, fsz, XSC_DMA_MAP_PAGE);
+		num_dma++;
+		dseg++;
+	}
+
+	return num_dma;
+
+dma_unmap_wqe_err:
+	xsc_dma_unmap_wqe_err(sq, num_dma);
+	return -ENOMEM;
+}
+
+static void xsc_sq_notify_hw(struct xsc_wq_cyc *wq, u16 pc,
+			     struct xsc_sq *sq)
+{
+	struct xsc_adapter *adapter = sq->channel->adapter;
+	struct xsc_core_device *xdev  = adapter->xdev;
+	union xsc_send_doorbell doorbell_value;
+	int send_ds_num_log = ilog2(xdev->caps.send_ds_num);
+
+	/*reverse wqe index to ds index*/
+	doorbell_value.next_pid = pc << send_ds_num_log;
+	doorbell_value.qp_num = sq->sqn;
+
+	/* Make sure that descriptors are written before
+	 * updating doorbell record and ringing the doorbell
+	 */
+	wmb();
+	writel(doorbell_value.send_data, REG_ADDR(xdev, xdev->regs.tx_db));
+}
+
+static void xsc_txwqe_complete(struct xsc_sq *sq, struct sk_buff *skb,
+			       u8 opcode, u16 ds_cnt, u8 num_wqebbs, u32 num_bytes, u8 num_dma,
+			       struct xsc_tx_wqe_info *wi)
+{
+	struct xsc_wq_cyc *wq = &sq->wq;
+
+	wi->num_bytes = num_bytes;
+	wi->num_dma = num_dma;
+	wi->num_wqebbs = num_wqebbs;
+	wi->skb = skb;
+
+	netdev_tx_sent_queue(sq->txq, num_bytes);
+
+	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
+		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+
+	sq->pc += wi->num_wqebbs;
+
+	if (unlikely(!xsc_wqc_has_room_for(wq, sq->cc, sq->pc, sq->stop_room)))
+		netif_tx_stop_queue(sq->txq);
+
+	if (!netdev_xmit_more() || netif_xmit_stopped(sq->txq))
+		xsc_sq_notify_hw(wq, sq->pc, sq);
+}
+
+static uint32_t xsc_eth_xmit_frame(struct sk_buff *skb,
+				   struct xsc_sq *sq,
+				   struct xsc_tx_wqe *wqe,
+				   u16 pi)
+{
+	struct xsc_send_wqe_ctrl_seg *cseg;
+	struct xsc_wqe_data_seg *dseg;
+	struct xsc_tx_wqe_info *wi;
+	struct xsc_core_device *xdev = sq->cq.xdev;
+	u16 ds_cnt;
+	u16 mss, ihs, headlen;
+	u8 opcode;
+	u32 num_bytes, num_dma;
+	u8 num_wqebbs;
+
+retry_send:
+	/* Calc ihs and ds cnt, no writes to wqe yet */
+	/*ctrl-ds, it would be reduce in ds_data_num*/
+	ds_cnt = XSC_SEND_WQEBB_CTRL_NUM_DS;
+
+	/*in andes inline is bonding with gso*/
+	if (skb_is_gso(skb)) {
+		opcode    = XSC_OPCODE_RAW;
+		mss       = skb_shinfo(skb)->gso_size;
+		ihs       = xsc_tx_get_gso_ihs(sq, skb);
+		num_bytes = skb->len;
+	} else {
+		opcode    = XSC_OPCODE_RAW;
+		mss       = 0;
+		ihs       = 0;
+		num_bytes = skb->len;
+	}
+
+	/*linear data in skb*/
+	headlen = skb->len - skb->data_len;
+	ds_cnt += !!headlen;
+	ds_cnt += skb_shinfo(skb)->nr_frags;
+
+	/* Check packet size. */
+	if (unlikely(mss == 0 && num_bytes > sq->hw_mtu))
+		goto err_drop;
+
+	num_wqebbs = DIV_ROUND_UP(ds_cnt, xdev->caps.send_ds_num);
+	/*if ds_cnt exceed one wqe, drop it*/
+	if (num_wqebbs != 1) {
+		if (skb_linearize(skb))
+			goto err_drop;
+		goto retry_send;
+	}
+
+	/* fill wqe */
+	wi   = (struct xsc_tx_wqe_info *)&sq->db.wqe_info[pi];
+	cseg = &wqe->ctrl;
+	dseg = &wqe->data[0];
+
+	if (unlikely(num_bytes == 0))
+		goto err_drop;
+
+	xsc_txwqe_build_csegs(sq, skb, mss, ihs, headlen,
+			      opcode, ds_cnt, num_bytes, cseg);
+
+	/*inline header is also use dma to transport*/
+	num_dma = xsc_txwqe_build_dsegs(sq, skb, ihs, headlen, dseg);
+	if (unlikely(num_dma < 0))
+		goto err_drop;
+
+	xsc_txwqe_complete(sq, skb, opcode, ds_cnt, num_wqebbs, num_bytes,
+			   num_dma, wi);
+
+	return NETDEV_TX_OK;
+
+err_drop:
+	dev_kfree_skb_any(skb);
+
+	return NETDEV_TX_OK;
+}
+
+netdev_tx_t xsc_eth_xmit_start(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct xsc_adapter *adapter = netdev_priv(netdev);
+	struct xsc_tx_wqe *wqe;
+	struct xsc_sq *sq;
+	u16 pi;
+
+	if (!adapter || !adapter->xdev || adapter->status != XSCALE_ETH_DRIVER_OK)
+		return NETDEV_TX_BUSY;
+
+	sq = adapter->txq2sq[skb_get_queue_mapping(skb)];
+	if (unlikely(!sq))
+		return NETDEV_TX_BUSY;
+
+	wqe = xsc_sq_fetch_wqe(sq, adapter->xdev->caps.send_ds_num * XSC_SEND_WQE_DS, &pi);
+
+	return xsc_eth_xmit_frame(skb, sq, wqe, pi);
+}
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
index 116019a9a..f14ff7abf 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
@@ -6,8 +6,17 @@
 #ifndef __XSC_RXTX_H
 #define __XSC_RXTX_H
 
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
 #include "xsc_eth.h"
 
+enum {
+	XSC_ETH_WQE_NONE_CSUM,
+	XSC_ETH_WQE_INNER_CSUM,
+	XSC_ETH_WQE_OUTER_CSUM,
+	XSC_ETH_WQE_INNER_AND_OUTER_CSUM,
+};
+
 void xsc_cq_notify_hw_rearm(struct xsc_cq *cq);
 void xsc_cq_notify_hw(struct xsc_cq *cq);
 int xsc_eth_napi_poll(struct napi_struct *napi, int budget);
@@ -23,4 +32,31 @@ struct sk_buff *xsc_skb_from_cqe_nonlinear(struct xsc_rq *rq,
 					   u32 cqe_bcnt, u8 has_pph);
 int xsc_poll_rx_cq(struct xsc_cq *cq, int budget);
 
+netdev_tx_t xsc_eth_xmit_start(struct sk_buff *skb, struct net_device *netdev);
+
+static inline void xsc_tx_dma_unmap(struct device *dev, struct xsc_sq_dma *dma)
+{
+	switch (dma->type) {
+	case XSC_DMA_MAP_SINGLE:
+		dma_unmap_single(dev, dma->addr, dma->size, DMA_TO_DEVICE);
+		break;
+	case XSC_DMA_MAP_PAGE:
+		dma_unmap_page(dev, dma->addr, dma->size, DMA_TO_DEVICE);
+		break;
+	default:
+		break;
+	}
+}
+
+static inline struct xsc_sq_dma *xsc_dma_get(struct xsc_sq *sq, u32 i)
+{
+	return &sq->db.dma_fifo[i & sq->dma_fifo_mask];
+}
+
+static inline bool xsc_wqc_has_room_for(struct xsc_wq_cyc *wq,
+					u16 cc, u16 pc, u16 n)
+{
+	return (xsc_wq_cyc_ctr2ix(wq, cc - pc) >= n) || (cc == pc);
+}
+
 #endif /* XSC_RXTX_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
index 8f63b9e0b..967d46e7e 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
@@ -35,6 +35,8 @@ enum {
 #define XSC_RECV_WQEBB_NUM_DS	        (XSC_RECV_WQE_BB / XSC_RECV_WQE_DS)
 #define XSC_LOG_RECV_WQEBB_NUM_DS	ilog2(XSC_RECV_WQEBB_NUM_DS)
 
+#define XSC_SEND_WQEBB_CTRL_NUM_DS	1
+
 /* each ds holds one fragment in skb */
 #define XSC_MAX_RX_FRAGS        4
 #define XSC_RX_FRAG_SZ_ORDER    0
@@ -155,6 +157,11 @@ struct xsc_tx_wqe_info {
 	u8  num_dma;
 };
 
+struct xsc_tx_wqe {
+	struct xsc_send_wqe_ctrl_seg ctrl;
+	struct xsc_wqe_data_seg data[];
+};
+
 struct xsc_sq {
 	struct xsc_core_qp		cqp;
 	/* dirtied @completion */
-- 
2.43.0

