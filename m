Return-Path: <netdev+bounces-252581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF4gH/rNcmlgpgAAu9opvQ
	(envelope-from <netdev+bounces-252581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:25:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA1B6F0B2
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 219743027946
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B9336D50D;
	Fri, 23 Jan 2026 01:19:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-26.us.a.mail.aliyun.com (out198-26.us.a.mail.aliyun.com [47.90.198.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFDD311C33;
	Fri, 23 Jan 2026 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131165; cv=none; b=MzyCa5yTDiOjc/rYQgy6E9Cf3xn7V392K/W8REdLjVeyyjkMPaddhHUKs9iN3KV/8tA5kcPK5ISFn3W3ke/foH8EbP0rBOaahM9Joa0znVVRRw4470eOepZ3fEYDRCKh5Fl9Tt5FUT2NAwCNmzqIYsuImTgUAMYgsnQ9SLo/IeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131165; c=relaxed/simple;
	bh=rtpFo10SrvOtzPVkgAWcewNBBjox5/s8oWBk7o7qZn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtzSXtzn3pdxuBhIH8igH29UCj6HsnOhFAvqnH/ciA292hMB/8ItYS6xp1NDTRBJy7LkiL8Ahv94lDHR+as/+2eApTBTPsqL0DMH1+ZjrF0VfnPjdYzyE1QHYrvCjBWQ2NCyeRADIR9ZEIHTvE38mlmVN5cTiy/d92WB2KEM8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gDSYW7O_1769131128 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 09:18:49 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	hawk@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 net-next 09/15] net/nebula-matrix: add txrx resource interfaces and tx func
Date: Fri, 23 Jan 2026 09:17:46 +0800
Message-ID: <20260123011804.31263-10-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252581-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,illusion.wang:url,nebula-matrix.com:mid,nebula-matrix.com:email,pp_params.dev:url]
X-Rspamd-Queue-Id: 9BA1B6F0B2
X-Rspamd-Action: no action

primarily tx function and ring management
1.Ring Management for Transmit and Receive:
Alloc tx rings (nbl_alloc_tx_rings) and rx rings (nbl_alloc_rx_rings).
Free tx rings (nbl_free_tx_rings) and rx rings (nbl_free_rx_rings).
Start tx rings (nbl_res_txrx_start_tx_ring) and rx rings
(nbl_res_txrx_start_rx_ring).
Stop tx rings (nbl_res_txrx_stop_tx_ring) and rx rings
(nbl_res_txrx_stop_rx_ring).
2.Packet Handling:
Implement packet transmission (nbl_res_txrx_start_xmit), including
handling TSO (TCP Segmentation Offload) and checksum offloading.
Manage transmit buffers (nbl_unmap_and_free_tx_resource) and
receive buffers (nbl_put_rx_frag).
Support multi-queue transmission and reception.
3.Interrupt and NAPI Management:
Provide an interface to get the NAPI structure
(nbl_res_txrx_get_vector_napi).
Set interrupt information (nbl_res_txrx_set_vector_info).
Trigger receive rings (nbl_res_txrx_kick_rx_ring).

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |    1 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   14 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |   22 +-
 .../nbl_hw_leonis/nbl_resource_leonis.c       |   12 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |    4 +
 .../nebula-matrix/nbl/nbl_hw/nbl_txrx.c       | 1613 +++++++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_txrx.h       |  184 ++
 .../nbl/nbl_include/nbl_def_hw.h              |    3 +
 .../nbl/nbl_include/nbl_def_resource.h        |   22 +
 .../nbl/nbl_include/nbl_include.h             |   15 +
 10 files changed, 1889 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_txrx.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_txrx.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index f2a68245944a..a7254873f02e 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -12,6 +12,7 @@ nbl_core-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
 				nbl_hw/nbl_resource.o \
 				nbl_hw/nbl_interrupt.o \
+				nbl_hw/nbl_txrx.o \
 				nbl_hw/nbl_queue.o \
 				nbl_hw/nbl_vsi.o \
 				nbl_core/nbl_dispatch.o \
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index 6d4b890a4d84..e39319cee159 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -38,6 +38,11 @@
 #define NBL_ADAPTER_TO_RES_PT_OPS(adapter) \
 	(&(NBL_ADAP_TO_SERV_OPS_TBL(adapter)->pt_ops))
 
+#define NBL_NETDEV_PRIV_TO_ADAPTER(priv)	((priv)->adapter)
+
+#define NBL_NETDEV_TO_ADAPTER(netdev) \
+	(NBL_NETDEV_PRIV_TO_ADAPTER(  \
+		(struct nbl_netdev_priv *)netdev_priv(netdev)))
 #define NBL_CAP_TEST_BIT(val, loc) (((val) >> (loc)) & 0x1)
 
 #define NBL_CAP_IS_CTRL(val) NBL_CAP_TEST_BIT(val, NBL_CAP_HAS_CTRL_BIT)
@@ -81,6 +86,15 @@ struct nbl_adapter {
 	struct nbl_init_param init_param;
 };
 
+struct nbl_netdev_priv {
+	struct nbl_adapter *adapter;
+	struct net_device *netdev;
+	u16 tx_queue_num;
+	u16 rx_queue_num;
+	u16 queue_size;
+	u16 data_vsi;
+};
+
 struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
 				  struct nbl_init_param *param);
 void nbl_core_remove(struct nbl_adapter *adapter);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 43bb9d4af67a..7c51f4ee8715 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -1581,6 +1581,23 @@ static void nbl_hw_cfg_mailbox_qinfo(void *priv, u16 func_id, u16 bus,
 		       (u8 *)&mb_qinfo_map, sizeof(mb_qinfo_map));
 }
 
+static void nbl_hw_update_tail_ptr(void *priv, struct nbl_notify_param *param)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	u8 __iomem *notify_addr = hw_mgt->hw_addr;
+	u32 local_qid = param->notify_qid;
+	u32 tail_ptr = param->tail_ptr;
+
+	writel((((u32)tail_ptr << 16) | (u32)local_qid), notify_addr);
+}
+
+static u8 __iomem *nbl_hw_get_tail_ptr(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	return hw_mgt->hw_addr;
+}
+
 static void nbl_hw_set_promisc_mode(void *priv, u16 vsi_id, u16 eth_id,
 				    u16 mode)
 {
@@ -1668,6 +1685,7 @@ static struct nbl_hw_ops hw_ops = {
 	.save_uvn_ctx = nbl_hw_save_uvn_ctx,
 	.setup_queue_switch = nbl_hw_setup_queue_switch,
 	.init_pfc = nbl_hw_init_pfc,
+
 	.configure_msix_map = nbl_hw_configure_msix_map,
 	.configure_msix_info = nbl_hw_configure_msix_info,
 
@@ -1687,11 +1705,13 @@ static struct nbl_hw_ops hw_ops = {
 	.enable_msix_irq = nbl_hw_enable_msix_irq,
 	.get_msix_irq_enable_info = nbl_hw_get_msix_irq_enable_info,
 
+	.update_tail_ptr = nbl_hw_update_tail_ptr,
+	.get_tail_ptr = nbl_hw_get_tail_ptr,
+
 	.get_fw_eth_num = nbl_hw_get_fw_eth_num,
 	.get_fw_eth_map = nbl_hw_get_fw_eth_map,
 	.get_board_info = nbl_hw_get_board_info,
 	.get_quirks = nbl_hw_get_quirks,
-
 };
 
 /* Structure starts here, adding an op should not modify anything below */
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index 83f8bb280b93..67cd140b12ca 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -236,6 +236,11 @@ static int nbl_res_setup_ops(struct device *dev,
 		ret = nbl_queue_setup_ops_leonis(&res_ops);
 		if (ret)
 			goto setup_fail;
+
+		ret = nbl_txrx_setup_ops(&res_ops);
+		if (ret)
+			goto setup_fail;
+
 		ret = nbl_intr_setup_ops(&res_ops);
 		if (ret)
 			goto setup_fail;
@@ -442,6 +447,7 @@ static void nbl_res_stop(struct nbl_resource_mgt_leonis *res_mgt_leonis)
 	struct nbl_resource_mgt *res_mgt = &res_mgt_leonis->res_mgt;
 
 	nbl_queue_mgt_stop(res_mgt);
+	nbl_txrx_mgt_stop(res_mgt);
 	nbl_intr_mgt_stop(res_mgt);
 
 	nbl_vsi_mgt_stop(res_mgt);
@@ -497,6 +503,12 @@ static int nbl_res_start(struct nbl_resource_mgt_leonis *res_mgt_leonis,
 		if (ret)
 			goto start_fail;
 	}
+
+	if (caps.has_net) {
+		ret = nbl_txrx_mgt_start(res_mgt);
+		if (ret)
+			goto start_fail;
+	}
 	return 0;
 
 start_fail:
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
index 27a9900ff009..c508468d6de8 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -426,6 +426,10 @@ int nbl_intr_setup_ops(struct nbl_resource_ops *resource_ops);
 int nbl_queue_mgt_start(struct nbl_resource_mgt *res_mgt);
 void nbl_queue_mgt_stop(struct nbl_resource_mgt *res_mgt);
 
+int nbl_txrx_mgt_start(struct nbl_resource_mgt *res_mgt);
+void nbl_txrx_mgt_stop(struct nbl_resource_mgt *res_mgt);
+int nbl_txrx_setup_ops(struct nbl_resource_ops *resource_ops);
+
 int nbl_vsi_mgt_start(struct nbl_resource_mgt *res_mgt);
 void nbl_vsi_mgt_stop(struct nbl_resource_mgt *res_mgt);
 int nbl_vsi_setup_ops(struct nbl_resource_ops *resource_ops);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_txrx.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_txrx.c
new file mode 100644
index 000000000000..939166a074e2
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_txrx.c
@@ -0,0 +1,1613 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+#include <linux/etherdevice.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <net/ipv6.h>
+#include <linux/sctp.h>
+#include <linux/if_vlan.h>
+#include <net/page_pool/helpers.h>
+
+#include "nbl_txrx.h"
+
+static bool nbl_txrx_within_vsi(struct nbl_txrx_vsi_info *vsi_info,
+				u16 ring_index)
+{
+	return ring_index >= vsi_info->ring_offset &&
+	       ring_index < vsi_info->ring_offset + vsi_info->ring_num;
+}
+
+static struct netdev_queue *txring_txq(const struct nbl_res_tx_ring *ring)
+{
+	return netdev_get_tx_queue(ring->netdev, ring->queue_index);
+}
+
+static struct nbl_res_tx_ring *
+nbl_alloc_tx_ring(struct nbl_resource_mgt *res_mgt, struct net_device *netdev,
+		  u16 ring_index, u16 desc_num)
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_txrx_mgt *txrx_mgt = res_mgt->txrx_mgt;
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	struct nbl_res_tx_ring *ring;
+
+	ring = devm_kzalloc(dev, sizeof(struct nbl_res_tx_ring), GFP_KERNEL);
+	if (!ring)
+		return NULL;
+
+	ring->vsi_info = txrx_mgt->vsi_info;
+	ring->dma_dev = common->dma_dev;
+	ring->product_type = common->product_type;
+	ring->eth_id = common->eth_id;
+	ring->queue_index = ring_index;
+	ring->notify_addr = (u8 __iomem *)
+		hw_ops->get_tail_ptr(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+	ring->notify_qid = NBL_RES_NOFITY_QID(res_mgt, ring_index * 2 + 1);
+	ring->netdev = netdev;
+	ring->desc_num = desc_num;
+	ring->used_wrap_counter = 1;
+	ring->avail_used_flags |= BIT(NBL_PACKED_DESC_F_AVAIL);
+
+	return ring;
+}
+
+static int nbl_alloc_tx_rings(struct nbl_resource_mgt *res_mgt,
+			      struct net_device *netdev, u16 tx_num,
+			      u16 desc_num)
+{
+	struct nbl_txrx_mgt *txrx_mgt = res_mgt->txrx_mgt;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	struct nbl_res_tx_ring *ring;
+	u32 ring_index;
+
+	if (txrx_mgt->tx_rings) {
+		netif_err(common, drv, netdev,
+			  "Try to allocate tx_rings which already exists\n");
+		return -EINVAL;
+	}
+
+	txrx_mgt->tx_ring_num = tx_num;
+
+	txrx_mgt->tx_rings = devm_kcalloc(dev, tx_num,
+					  sizeof(struct nbl_res_tx_ring *),
+					  GFP_KERNEL);
+	if (!txrx_mgt->tx_rings)
+		return -ENOMEM;
+
+	for (ring_index = 0; ring_index < tx_num; ring_index++) {
+		ring = txrx_mgt->tx_rings[ring_index];
+		WARN_ON(ring);
+		ring = nbl_alloc_tx_ring(res_mgt, netdev, ring_index, desc_num);
+		if (!ring)
+			goto alloc_tx_ring_failed;
+
+		WRITE_ONCE(txrx_mgt->tx_rings[ring_index], ring);
+	}
+
+	return 0;
+
+alloc_tx_ring_failed:
+	while (ring_index--)
+		devm_kfree(dev, txrx_mgt->tx_rings[ring_index]);
+	devm_kfree(dev, txrx_mgt->tx_rings);
+	txrx_mgt->tx_rings = NULL;
+	return -ENOMEM;
+}
+
+static void nbl_free_tx_rings(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_txrx_mgt *txrx_mgt = res_mgt->txrx_mgt;
+	struct nbl_res_tx_ring *ring;
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	u16 ring_count;
+	u16 ring_index;
+
+	ring_count = txrx_mgt->tx_ring_num;
+	for (ring_index = 0; ring_index < ring_count; ring_index++) {
+		ring = txrx_mgt->tx_rings[ring_index];
+		devm_kfree(dev, ring);
+	}
+	devm_kfree(dev, txrx_mgt->tx_rings);
+	txrx_mgt->tx_rings = NULL;
+}
+
+static int nbl_alloc_rx_rings(struct nbl_resource_mgt *res_mgt,
+			      struct net_device *netdev, u16 rx_num,
+			      u16 desc_num)
+{
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_txrx_mgt *txrx_mgt = res_mgt->txrx_mgt;
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	struct nbl_res_rx_ring *ring;
+	u32 ring_index;
+
+	if (txrx_mgt->rx_rings) {
+		netif_err(common, drv, netdev,
+			  "Try to allocate rx_rings which already exists\n");
+		return -EINVAL;
+	}
+
+	txrx_mgt->rx_ring_num = rx_num;
+
+	txrx_mgt->rx_rings = devm_kcalloc(dev, rx_num,
+					  sizeof(struct nbl_res_rx_ring *),
+					  GFP_KERNEL);
+	if (!txrx_mgt->rx_rings)
+		return -ENOMEM;
+
+	for (ring_index = 0; ring_index < rx_num; ring_index++) {
+		ring = txrx_mgt->rx_rings[ring_index];
+		WARN_ON(ring);
+		ring = devm_kzalloc(dev, sizeof(struct nbl_res_rx_ring),
+				    GFP_KERNEL);
+		if (!ring)
+			goto alloc_rx_ring_failed;
+
+		ring->common = common;
+		ring->txrx_mgt = txrx_mgt;
+		ring->dma_dev = common->dma_dev;
+		ring->queue_index = ring_index;
+		ring->notify_qid = NBL_RES_NOFITY_QID(res_mgt, ring_index * 2);
+		ring->netdev = netdev;
+		ring->desc_num = desc_num;
+		/* RX buffer length is determined by mtu,
+		 * when netdev up we will set buf_len according to its mtu
+		 */
+		ring->buf_len = PAGE_SIZE / 2 - NBL_RX_PAD;
+
+		ring->used_wrap_counter = 1;
+		ring->avail_used_flags |= BIT(NBL_PACKED_DESC_F_AVAIL);
+		WRITE_ONCE(txrx_mgt->rx_rings[ring_index], ring);
+	}
+
+	return 0;
+
+alloc_rx_ring_failed:
+	while (ring_index--)
+		devm_kfree(dev, txrx_mgt->rx_rings[ring_index]);
+	devm_kfree(dev, txrx_mgt->rx_rings);
+	txrx_mgt->rx_rings = NULL;
+	return -ENOMEM;
+}
+
+static void nbl_free_rx_rings(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_txrx_mgt *txrx_mgt = res_mgt->txrx_mgt;
+	struct nbl_res_rx_ring *ring;
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	u16 ring_count;
+	u16 ring_index;
+
+	ring_count = txrx_mgt->rx_ring_num;
+	for (ring_index = 0; ring_index < ring_count; ring_index++) {
+		ring = txrx_mgt->rx_rings[ring_index];
+		devm_kfree(dev, ring);
+	}
+	devm_kfree(dev, txrx_mgt->rx_rings);
+	txrx_mgt->rx_rings = NULL;
+}
+
+static int nbl_alloc_vectors(struct nbl_resource_mgt *res_mgt, u16 num)
+{
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_txrx_mgt *txrx_mgt = res_mgt->txrx_mgt;
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	struct nbl_res_vector *vector;
+	u32 index;
+
+	if (txrx_mgt->vectors) {
+		nbl_err(common,
+			"Try to allocate vectors which already exists\n");
+		return -EINVAL;
+	}
+
+	txrx_mgt->vectors = devm_kcalloc(dev, num,
+					 sizeof(struct nbl_res_vector *),
+					 GFP_KERNEL);
+	if (!txrx_mgt->vectors)
+		return -ENOMEM;
+
+	for (index = 0; index < num; index++) {
+		vector = txrx_mgt->vectors[index];
+		WARN_ON(vector);
+		vector = devm_kzalloc(dev, sizeof(struct nbl_res_vector),
+				      GFP_KERNEL);
+		if (!vector)
+			goto alloc_vector_failed;
+
+		vector->rx_ring = txrx_mgt->rx_rings[index];
+		vector->tx_ring = txrx_mgt->tx_rings[index];
+		WRITE_ONCE(txrx_mgt->vectors[index], vector);
+	}
+	return 0;
+
+alloc_vector_failed:
+	while (index--)
+		devm_kfree(dev, txrx_mgt->vectors[index]);
+	devm_kfree(dev, txrx_mgt->vectors);
+	txrx_mgt->vectors = NULL;
+	return -ENOMEM;
+}
+
+static void nbl_free_vectors(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_txrx_mgt *txrx_mgt = res_mgt->txrx_mgt;
+	struct nbl_res_vector *vector;
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	u16 count, index;
+
+	count = txrx_mgt->rx_ring_num;
+	for (index = 0; index < count; index++) {
+		vector = txrx_mgt->vectors[index];
+		devm_kfree(dev, vector);
+	}
+	devm_kfree(dev, txrx_mgt->vectors);
+	txrx_mgt->vectors = NULL;
+}
+
+static int nbl_res_txrx_alloc_rings(void *priv, struct net_device *netdev,
+				    struct nbl_ring_param *param)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	int err = 0;
+
+	err = nbl_alloc_tx_rings(res_mgt, netdev, param->tx_ring_num,
+				 param->queue_size);
+	if (err)
+		return err;
+
+	err = nbl_alloc_rx_rings(res_mgt, netdev, param->rx_ring_num,
+				 param->queue_size);
+	if (err)
+		goto alloc_rx_rings_err;
+
+	err = nbl_alloc_vectors(res_mgt, param->rx_ring_num);
+	if (err)
+		goto alloc_vectors_err;
+
+	nbl_info(res_mgt->common, "Alloc rings for %d tx, %d rx, %d desc\n",
+		 param->tx_ring_num, param->rx_ring_num, param->queue_size);
+	return 0;
+
+alloc_vectors_err:
+	nbl_free_rx_rings(res_mgt);
+alloc_rx_rings_err:
+	nbl_free_tx_rings(res_mgt);
+	return err;
+}
+
+static void nbl_res_txrx_remove_rings(void *priv)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+
+	nbl_free_vectors(res_mgt);
+	nbl_free_tx_rings(res_mgt);
+	nbl_free_rx_rings(res_mgt);
+	nbl_debug(res_mgt->common, "Remove rings");
+}
+
+static dma_addr_t nbl_res_txrx_start_tx_ring(void *priv, u8 ring_index)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	struct device *dma_dev = NBL_RES_MGT_TO_DMA_DEV(res_mgt);
+	struct nbl_res_tx_ring *tx_ring =
+		NBL_RES_MGT_TO_TX_RING(res_mgt, ring_index);
+
+	if (tx_ring->tx_bufs) {
+		nbl_err(res_mgt->common,
+			"Try to setup a TX ring with buffer management array already allocated\n");
+		return (dma_addr_t)NULL;
+	}
+
+	tx_ring->tx_bufs = devm_kcalloc(dev, tx_ring->desc_num,
+					sizeof(*tx_ring->tx_bufs), GFP_KERNEL);
+	if (!tx_ring->tx_bufs)
+		return (dma_addr_t)NULL;
+
+	/* Alloc twice memory, and second half is used to back up the desc
+	 *for desc checking
+	 */
+	tx_ring->size = ALIGN(tx_ring->desc_num * sizeof(struct nbl_ring_desc),
+			      PAGE_SIZE);
+	tx_ring->desc = dmam_alloc_coherent(dma_dev, tx_ring->size,
+					    &tx_ring->dma,
+					    GFP_KERNEL | __GFP_ZERO);
+	if (!tx_ring->desc)
+		goto alloc_dma_err;
+
+	tx_ring->next_to_use = 0;
+	tx_ring->next_to_clean = 0;
+	tx_ring->tail_ptr = 0;
+
+	tx_ring->valid = true;
+	nbl_debug(res_mgt->common, "Start tx ring %d", ring_index);
+	return tx_ring->dma;
+
+alloc_dma_err:
+	devm_kfree(dev, tx_ring->tx_bufs);
+	tx_ring->tx_bufs = NULL;
+	tx_ring->size = 0;
+	return (dma_addr_t)NULL;
+}
+
+static __always_inline bool nbl_rx_cache_get(struct nbl_res_rx_ring *rx_ring,
+					     struct nbl_dma_info *dma_info)
+{
+	struct nbl_page_cache *cache = &rx_ring->page_cache;
+	struct nbl_rx_queue_stats *stats = &rx_ring->rx_stats;
+
+	if (unlikely(cache->head == cache->tail)) {
+		stats->rx_cache_empty++;
+		return false;
+	}
+
+	if (page_ref_count(cache->page_cache[cache->head].page) != 1) {
+		stats->rx_cache_busy++;
+		return false;
+	}
+
+	*dma_info = cache->page_cache[cache->head];
+	cache->head = (cache->head + 1) & (NBL_MAX_CACHE_SIZE - 1);
+	stats->rx_cache_reuse++;
+
+	dma_sync_single_for_device(rx_ring->dma_dev, dma_info->addr,
+				   dma_info->size, DMA_FROM_DEVICE);
+	return true;
+}
+
+static __always_inline int nbl_page_alloc_pool(struct nbl_res_rx_ring *rx_ring,
+					       struct nbl_dma_info *dma_info)
+{
+	if (nbl_rx_cache_get(rx_ring, dma_info))
+		return 0;
+
+	dma_info->page = page_pool_dev_alloc_pages(rx_ring->page_pool);
+	if (unlikely(!dma_info->page))
+		return -ENOMEM;
+
+	dma_info->addr = dma_map_page_attrs(rx_ring->dma_dev, dma_info->page, 0,
+					    dma_info->size, DMA_FROM_DEVICE,
+					    NBL_RX_DMA_ATTR);
+
+	if (unlikely(dma_mapping_error(rx_ring->dma_dev, dma_info->addr))) {
+		page_pool_recycle_direct(rx_ring->page_pool, dma_info->page);
+		dma_info->page = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static __always_inline int nbl_get_rx_frag(struct nbl_res_rx_ring *rx_ring,
+					   struct nbl_rx_buffer *buffer)
+{
+	int err = 0;
+
+	/* first buffer alloc page */
+	if (buffer->first_in_page)
+		err = nbl_page_alloc_pool(rx_ring, buffer->di);
+
+	return err;
+}
+
+static __always_inline bool nbl_alloc_rx_bufs(struct nbl_res_rx_ring *rx_ring,
+					      u16 count)
+{
+	u32 buf_len;
+	u16 next_to_use, head;
+	__le16 head_flags = 0;
+	struct nbl_ring_desc *rx_desc, *head_desc;
+	struct nbl_rx_buffer *rx_buf;
+	int i;
+
+	if (unlikely(!rx_ring || !count)) {
+		nbl_warn(NBL_RING_TO_COMMON(rx_ring),
+			 "invalid input parameters, rx_ring is %p, count is %d.\n",
+			 rx_ring, count);
+		return -EINVAL;
+	}
+
+	buf_len = rx_ring->buf_len;
+	next_to_use = rx_ring->next_to_use;
+
+	head = next_to_use;
+	head_desc = NBL_RX_DESC(rx_ring, next_to_use);
+	rx_desc = NBL_RX_DESC(rx_ring, next_to_use);
+	rx_buf = NBL_RX_BUF(rx_ring, next_to_use);
+
+	if (unlikely(!rx_desc || !rx_buf)) {
+		nbl_warn(NBL_RING_TO_COMMON(rx_ring),
+			 "invalid input parameters, next_to_use:%d, rx_desc is %p, rx_buf is %p.\n",
+			 next_to_use, rx_desc, rx_buf);
+		return -EINVAL;
+	}
+
+	do {
+		if (nbl_get_rx_frag(rx_ring, rx_buf))
+			break;
+
+		for (i = 0; i < rx_ring->frags_num_per_page;
+		     i++, rx_desc++, rx_buf++) {
+			rx_desc->addr =
+				cpu_to_le64(rx_buf->di->addr + rx_buf->offset);
+			rx_desc->len = cpu_to_le32(buf_len);
+			rx_desc->id = cpu_to_le16(next_to_use);
+
+			if (likely(head != next_to_use || i))
+				rx_desc->flags =
+					cpu_to_le16(rx_ring->avail_used_flags |
+						    NBL_PACKED_DESC_F_WRITE);
+			else
+				head_flags =
+					cpu_to_le16(rx_ring->avail_used_flags |
+						    NBL_PACKED_DESC_F_WRITE);
+		}
+
+		next_to_use += rx_ring->frags_num_per_page;
+		rx_ring->tail_ptr += rx_ring->frags_num_per_page;
+		count -= rx_ring->frags_num_per_page;
+		if (next_to_use == rx_ring->desc_num) {
+			next_to_use = 0;
+			rx_desc = NBL_RX_DESC(rx_ring, next_to_use);
+			rx_buf = NBL_RX_BUF(rx_ring, next_to_use);
+			rx_ring->avail_used_flags ^=
+				BIT(NBL_PACKED_DESC_F_AVAIL) |
+				BIT(NBL_PACKED_DESC_F_USED);
+		}
+	} while (count);
+
+	if (next_to_use != head) {
+		/* wmb */
+		wmb();
+		head_desc->flags = head_flags;
+		rx_ring->next_to_use = next_to_use;
+	}
+
+	return !!count;
+}
+
+static void nbl_unmap_and_free_tx_resource(struct nbl_res_tx_ring *ring,
+					   struct nbl_tx_buffer *tx_buffer,
+					   bool free, bool in_napi)
+{
+	struct device *dma_dev = NBL_RING_TO_DMA_DEV(ring);
+
+	if (tx_buffer->skb) {
+		if (likely(free)) {
+			if (in_napi)
+				napi_consume_skb(tx_buffer->skb,
+						 NBL_TX_POLL_WEIGHT);
+			else
+				dev_kfree_skb_any(tx_buffer->skb);
+		}
+
+		if (dma_unmap_len(tx_buffer, len))
+			dma_unmap_single(dma_dev,
+					 dma_unmap_addr(tx_buffer, dma),
+					 dma_unmap_len(tx_buffer, len),
+					 DMA_TO_DEVICE);
+	} else if (tx_buffer->page && dma_unmap_len(tx_buffer, len)) {
+		dma_unmap_page(dma_dev, dma_unmap_addr(tx_buffer, dma),
+			       dma_unmap_len(tx_buffer, len), DMA_TO_DEVICE);
+	} else if (dma_unmap_len(tx_buffer, len)) {
+		dma_unmap_single(dma_dev, dma_unmap_addr(tx_buffer, dma),
+				 dma_unmap_len(tx_buffer, len), DMA_TO_DEVICE);
+	}
+
+	tx_buffer->next_to_watch = NULL;
+	tx_buffer->skb = NULL;
+	tx_buffer->page = 0;
+	tx_buffer->bytecount = 0;
+	tx_buffer->gso_segs = 0;
+	dma_unmap_len_set(tx_buffer, len, 0);
+}
+
+static void nbl_free_tx_ring_bufs(struct nbl_res_tx_ring *tx_ring)
+{
+	struct nbl_tx_buffer *tx_buffer;
+	u16 i;
+
+	i = tx_ring->next_to_clean;
+	tx_buffer = NBL_TX_BUF(tx_ring, i);
+	while (i != tx_ring->next_to_use) {
+		nbl_unmap_and_free_tx_resource(tx_ring, tx_buffer, true, false);
+		i++;
+		tx_buffer++;
+		if (i == tx_ring->desc_num) {
+			i = 0;
+			tx_buffer = NBL_TX_BUF(tx_ring, i);
+		}
+	}
+
+	tx_ring->next_to_clean = 0;
+	tx_ring->next_to_use = 0;
+	tx_ring->tail_ptr = 0;
+
+	tx_ring->used_wrap_counter = 1;
+	tx_ring->avail_used_flags = BIT(NBL_PACKED_DESC_F_AVAIL);
+	memset(tx_ring->desc, 0, tx_ring->size);
+}
+
+static void nbl_res_txrx_stop_tx_ring(void *priv, u8 ring_index)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	struct device *dma_dev = NBL_RES_MGT_TO_DMA_DEV(res_mgt);
+	struct nbl_res_tx_ring *tx_ring =
+		NBL_RES_MGT_TO_TX_RING(res_mgt, ring_index);
+	struct nbl_res_vector *vector =
+		NBL_RES_MGT_TO_VECTOR(res_mgt, ring_index);
+
+	vector->started = false;
+	/* Flush napi task, to ensue the sched napi finish. So napi will no to
+	 * access the ring memory(wild point), bacause the vector->started has
+	 * set false.
+	 */
+	napi_synchronize(&vector->nbl_napi.napi);
+	tx_ring->valid = false;
+
+	nbl_free_tx_ring_bufs(tx_ring);
+	WRITE_ONCE(NBL_RES_MGT_TO_TX_RING(res_mgt, ring_index), tx_ring);
+
+	devm_kfree(dev, tx_ring->tx_bufs);
+	tx_ring->tx_bufs = NULL;
+
+	dmam_free_coherent(dma_dev, tx_ring->size, tx_ring->desc, tx_ring->dma);
+	tx_ring->desc = NULL;
+	tx_ring->dma = (dma_addr_t)NULL;
+	tx_ring->size = 0;
+
+	if (nbl_txrx_within_vsi(&tx_ring->vsi_info[NBL_VSI_DATA],
+				tx_ring->queue_index))
+		netdev_tx_reset_queue(txring_txq(tx_ring));
+
+	nbl_debug(res_mgt->common, "Stop tx ring %d", ring_index);
+}
+
+static __always_inline bool nbl_dev_page_is_reusable(struct page *page, u8 nid)
+{
+	return likely(page_to_nid(page) == nid && !page_is_pfmemalloc(page));
+}
+
+static __always_inline int nbl_rx_cache_put(struct nbl_res_rx_ring *rx_ring,
+					    struct nbl_dma_info *dma_info)
+{
+	struct nbl_page_cache *cache = &rx_ring->page_cache;
+	u32 tail_next = (cache->tail + 1) & (NBL_MAX_CACHE_SIZE - 1);
+	struct nbl_rx_queue_stats *stats = &rx_ring->rx_stats;
+
+	if (tail_next == cache->head) {
+		stats->rx_cache_full++;
+		return 0;
+	}
+
+	if (!nbl_dev_page_is_reusable(dma_info->page, rx_ring->nid)) {
+		stats->rx_cache_waive++;
+		return 1;
+	}
+
+	cache->page_cache[cache->tail] = *dma_info;
+	cache->tail = tail_next;
+
+	return 2;
+}
+
+static __always_inline void
+nbl_page_release_dynamic(struct nbl_res_rx_ring *rx_ring,
+			 struct nbl_dma_info *dma_info, bool recycle)
+{
+	u32 ret;
+
+	if (likely(recycle)) {
+		ret = nbl_rx_cache_put(rx_ring, dma_info);
+		if (ret == 2)
+			return;
+		if (ret == 1)
+			goto free_page;
+		dma_unmap_page_attrs(rx_ring->dma_dev, dma_info->addr,
+				     dma_info->size, DMA_FROM_DEVICE,
+				     NBL_RX_DMA_ATTR);
+		page_pool_recycle_direct(rx_ring->page_pool, dma_info->page);
+
+		return;
+	}
+free_page:
+	dma_unmap_page_attrs(rx_ring->dma_dev, dma_info->addr, dma_info->size,
+			     DMA_FROM_DEVICE, NBL_RX_DMA_ATTR);
+	page_pool_put_page(rx_ring->page_pool, dma_info->page, dma_info->size,
+			   true);
+}
+
+static __always_inline void nbl_put_rx_frag(struct nbl_res_rx_ring *rx_ring,
+					    struct nbl_rx_buffer *buffer,
+					    bool recycle)
+{
+	if (buffer->last_in_page)
+		nbl_page_release_dynamic(rx_ring, buffer->di, recycle);
+}
+
+static void nbl_free_rx_ring_bufs(struct nbl_res_rx_ring *rx_ring)
+{
+	struct nbl_rx_buffer *rx_buf;
+	u16 i;
+
+	i = rx_ring->next_to_clean;
+	rx_buf = NBL_RX_BUF(rx_ring, i);
+	while (i != rx_ring->next_to_use) {
+		nbl_put_rx_frag(rx_ring, rx_buf, false);
+		i++;
+		rx_buf++;
+		if (i == rx_ring->desc_num) {
+			i = 0;
+			rx_buf = NBL_RX_BUF(rx_ring, i);
+		}
+	}
+
+	for (i = rx_ring->page_cache.head; i != rx_ring->page_cache.tail;
+	     i = (i + 1) & (NBL_MAX_CACHE_SIZE - 1)) {
+		struct nbl_dma_info *dma_info =
+			&rx_ring->page_cache.page_cache[i];
+
+		nbl_page_release_dynamic(rx_ring, dma_info, false);
+	}
+
+	rx_ring->next_to_clean = 0;
+	rx_ring->next_to_use = 0;
+	rx_ring->tail_ptr = 0;
+	rx_ring->page_cache.head = 0;
+	rx_ring->page_cache.tail = 0;
+
+	rx_ring->used_wrap_counter = 1;
+	rx_ring->avail_used_flags = BIT(NBL_PACKED_DESC_F_AVAIL);
+	memset(rx_ring->desc, 0, rx_ring->size);
+}
+
+static dma_addr_t nbl_res_txrx_start_rx_ring(void *priv, u8 ring_index,
+					     bool use_napi)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	struct device *dma_dev = NBL_RES_MGT_TO_DMA_DEV(res_mgt);
+	struct nbl_res_rx_ring *rx_ring =
+		NBL_RES_MGT_TO_RX_RING(res_mgt, ring_index);
+	struct nbl_res_vector *vector =
+		NBL_RES_MGT_TO_VECTOR(res_mgt, ring_index);
+	struct page_pool_params pp_params = { 0 };
+	int pkt_len, hw_mtu, max_linear_len;
+	int buf_size;
+	int order = 0;
+	int i, j;
+	u16 rx_pad, tailroom;
+	size_t size;
+
+	if (rx_ring->rx_bufs) {
+		netif_err(common, drv, rx_ring->netdev,
+			  "Try to setup a RX ring with buffer management array already allocated\n");
+		return (dma_addr_t)NULL;
+	}
+	hw_mtu = rx_ring->netdev->mtu + NBL_PKT_HDR_PAD + NBL_BUFFER_HDR_LEN;
+	tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	rx_pad = NBL_RX_PAD;
+	max_linear_len = NBL_RX_BUFSZ;
+	pkt_len = SKB_DATA_ALIGN(hw_mtu + rx_pad) + tailroom;
+	rx_ring->linear_skb = true;
+	if (pkt_len > max_linear_len) {
+		rx_ring->linear_skb = false;
+		rx_pad = 0;
+		tailroom = 0;
+		pkt_len = SKB_DATA_ALIGN(hw_mtu);
+	}
+	buf_size = NBL_RX_BUFSZ;
+	WARN_ON(buf_size > PAGE_SIZE);
+	rx_ring->frags_num_per_page = (PAGE_SIZE * (1 << order)) / buf_size;
+	WARN_ON(rx_ring->frags_num_per_page > NBL_MAX_BATCH_DESC);
+	rx_ring->buf_len = buf_size - rx_pad - tailroom;
+
+	pp_params.order = order;
+	pp_params.flags = 0;
+	pp_params.pool_size = rx_ring->desc_num;
+	pp_params.nid = dev_to_node(dev);
+	pp_params.dev = dev;
+	pp_params.dma_dir = DMA_FROM_DEVICE;
+
+	if (dev_to_node(dev) == NUMA_NO_NODE)
+		rx_ring->nid = 0;
+	else
+		rx_ring->nid = dev_to_node(dev);
+
+	rx_ring->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(rx_ring->page_pool)) {
+		netif_err(common, drv, rx_ring->netdev,
+			  "Page_pool Allocate %u Failed failed\n",
+			  rx_ring->queue_index);
+		return (dma_addr_t)NULL;
+	}
+	size = array_size(rx_ring->desc_num / rx_ring->frags_num_per_page,
+			  sizeof(struct nbl_dma_info));
+	rx_ring->di = kvzalloc_node(size, GFP_KERNEL, dev_to_node(dev));
+	if (!rx_ring->di) {
+		netif_err(common, drv, rx_ring->netdev,
+			  "Dma info Allocate %u Failed failed\n",
+			  rx_ring->queue_index);
+		goto alloc_di_err;
+	}
+
+	rx_ring->rx_bufs = devm_kcalloc(dev, rx_ring->desc_num,
+					sizeof(*rx_ring->rx_bufs), GFP_KERNEL);
+	if (!rx_ring->rx_bufs)
+		goto alloc_buffers_err;
+
+	/* Alloc twice memory, and second half is used to back up the desc
+	 * for desc checking
+	 */
+	rx_ring->size = ALIGN(rx_ring->desc_num * sizeof(struct nbl_ring_desc),
+			      PAGE_SIZE);
+	rx_ring->desc = dmam_alloc_coherent(dma_dev, rx_ring->size,
+					    &rx_ring->dma,
+					    GFP_KERNEL | __GFP_ZERO);
+	if (!rx_ring->desc) {
+		netif_err(common, drv, rx_ring->netdev,
+			  "Allocate %u bytes descriptor DMA memory for RX queue %u failed\n",
+			   rx_ring->size, rx_ring->queue_index);
+		goto alloc_dma_err;
+	}
+
+	rx_ring->next_to_use = 0;
+	rx_ring->next_to_clean = 0;
+	rx_ring->tail_ptr = 0;
+
+	j = 0;
+	for (i = 0; i < rx_ring->desc_num / rx_ring->frags_num_per_page; i++) {
+		struct nbl_dma_info *di = &rx_ring->di[i];
+		struct nbl_rx_buffer *buffer = &rx_ring->rx_bufs[j];
+		int f;
+
+		di->size = (PAGE_SIZE * (1 << order));
+		for (f = 0; f < rx_ring->frags_num_per_page; f++, j++) {
+			buffer = &rx_ring->rx_bufs[j];
+			buffer->di = di;
+			buffer->size = buf_size;
+			buffer->offset = rx_pad + f * buf_size;
+			buffer->rx_pad = rx_pad;
+			buffer->first_in_page = (f == 0);
+			buffer->last_in_page =
+				(f == rx_ring->frags_num_per_page - 1);
+		}
+	}
+
+	if (nbl_alloc_rx_bufs(rx_ring, rx_ring->desc_num - NBL_MAX_BATCH_DESC))
+		goto alloc_rx_bufs_err;
+
+	rx_ring->valid = true;
+	if (use_napi && vector)
+		vector->started = true;
+
+	netif_dbg(common, drv, rx_ring->netdev, "Start rx ring %d", ring_index);
+	return rx_ring->dma;
+
+alloc_rx_bufs_err:
+	nbl_free_rx_ring_bufs(rx_ring);
+	dmam_free_coherent(dma_dev, rx_ring->size, rx_ring->desc, rx_ring->dma);
+	rx_ring->desc = NULL;
+	rx_ring->dma = (dma_addr_t)NULL;
+alloc_dma_err:
+	devm_kfree(dev, rx_ring->rx_bufs);
+	rx_ring->rx_bufs = NULL;
+alloc_buffers_err:
+	kvfree(rx_ring->di);
+alloc_di_err:
+	page_pool_destroy(rx_ring->page_pool);
+	rx_ring->size = 0;
+	return (dma_addr_t)NULL;
+}
+
+static void nbl_res_txrx_stop_rx_ring(void *priv, u8 ring_index)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct device *dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	struct device *dma_dev = NBL_RES_MGT_TO_DMA_DEV(res_mgt);
+	struct nbl_res_rx_ring *rx_ring =
+		NBL_RES_MGT_TO_RX_RING(res_mgt, ring_index);
+
+	rx_ring->valid = false;
+
+	nbl_free_rx_ring_bufs(rx_ring);
+	WRITE_ONCE(NBL_RES_MGT_TO_RX_RING(res_mgt, ring_index), rx_ring);
+
+	devm_kfree(dev, rx_ring->rx_bufs);
+	kvfree(rx_ring->di);
+	rx_ring->rx_bufs = NULL;
+
+	dmam_free_coherent(dma_dev, rx_ring->size, rx_ring->desc, rx_ring->dma);
+	rx_ring->desc = NULL;
+	rx_ring->dma = (dma_addr_t)NULL;
+	rx_ring->size = 0;
+
+	page_pool_destroy(rx_ring->page_pool);
+
+	nbl_debug(res_mgt->common, "Stop rx ring %d", ring_index);
+}
+
+static void nbl_txrx_register_vsi_ring(void *priv, u16 vsi_index,
+				       u16 ring_offset, u16 ring_num)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_txrx_mgt *txrx_mgt = NBL_RES_MGT_TO_TXRX_MGT(res_mgt);
+
+	txrx_mgt->vsi_info[vsi_index].ring_offset = ring_offset;
+	txrx_mgt->vsi_info[vsi_index].ring_num = ring_num;
+}
+
+static __always_inline int nbl_maybe_stop_tx(struct nbl_res_tx_ring *tx_ring,
+					     unsigned int size)
+{
+	if (likely(nbl_unused_tx_desc_count(tx_ring) >= size))
+		return 0;
+
+	if (!nbl_txrx_within_vsi(&tx_ring->vsi_info[NBL_VSI_DATA],
+				 tx_ring->queue_index))
+		return -EBUSY;
+
+	dev_dbg(NBL_RING_TO_DEV(tx_ring),
+		"unused_desc_count:%u, size:%u, stop queue %u\n",
+		nbl_unused_tx_desc_count(tx_ring), size, tx_ring->queue_index);
+	netif_stop_subqueue(tx_ring->netdev, tx_ring->queue_index);
+
+	/* smp_mb */
+	smp_mb();
+
+	if (likely(nbl_unused_tx_desc_count(tx_ring) < size))
+		return -EBUSY;
+
+	dev_dbg(NBL_RING_TO_DEV(tx_ring),
+		"unused_desc_count:%u, size:%u, start queue %u\n",
+		nbl_unused_tx_desc_count(tx_ring), size, tx_ring->queue_index);
+	netif_start_subqueue(tx_ring->netdev, tx_ring->queue_index);
+
+	return 0;
+}
+
+static unsigned int nbl_xmit_desc_count(struct sk_buff *skb)
+{
+	unsigned int nr_frags = skb_shinfo(skb)->nr_frags;
+
+	return nr_frags + 1;
+}
+
+/* set up TSO(TCP Segmentation Offload) */
+static int nbl_tx_tso(struct nbl_tx_buffer *first,
+		      struct nbl_tx_hdr_param *hdr_param)
+{
+	struct sk_buff *skb = first->skb;
+	union {
+		struct iphdr *v4;
+		struct ipv6hdr *v6;
+		unsigned char *hdr;
+	} ip;
+	union {
+		struct tcphdr *tcp;
+		struct udphdr *udp;
+		unsigned char *hdr;
+	} l4;
+	u8 l4_start;
+	u32 payload_len;
+	u8 header_len = 0;
+	int err;
+
+	if (skb->ip_summed != CHECKSUM_PARTIAL)
+		return 1;
+
+	if (!skb_is_gso(skb))
+		return 1;
+
+	err = skb_cow_head(skb, 0);
+	if (err < 0)
+		return err;
+
+	ip.hdr = skb_network_header(skb);
+	l4.hdr = skb_transport_header(skb);
+
+	/* initialize IP header fields*/
+	if (ip.v4->version == IP_VERSION_V4) {
+		ip.v4->tot_len = 0;
+		ip.v4->check = 0;
+	} else {
+		ip.v6->payload_len = 0;
+	}
+
+	/* length of (MAC + IP) header */
+	l4_start = (u8)(l4.hdr - skb->data);
+
+	/* l4 packet length */
+	payload_len = skb->len - l4_start;
+
+	/* remove l4 packet length from L4 pseudo-header checksum */
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
+		csum_replace_by_diff(&l4.udp->check,
+				     (__force __wsum)htonl(payload_len));
+		/* compute length of UDP segmentation header */
+		header_len = (u8)sizeof(l4.udp) + l4_start;
+	} else {
+		csum_replace_by_diff(&l4.tcp->check,
+				     (__force __wsum)htonl(payload_len));
+		/* compute length of TCP segmentation header */
+		header_len = (u8)(l4.tcp->doff * 4 + l4_start);
+	}
+
+	hdr_param->tso = 1;
+	hdr_param->mss = skb_shinfo(skb)->gso_size;
+	hdr_param->total_hlen = header_len;
+
+	first->gso_segs = skb_shinfo(skb)->gso_segs;
+	first->bytecount += (first->gso_segs - 1) * header_len;
+	first->tx_flags = NBL_TX_FLAGS_TSO;
+
+	return first->gso_segs;
+}
+
+/* set up Tx checksum offload */
+static int nbl_tx_csum(struct nbl_tx_buffer *first,
+		       struct nbl_tx_hdr_param *hdr_param)
+{
+	struct sk_buff *skb = first->skb;
+	union {
+		struct iphdr *v4;
+		struct ipv6hdr *v6;
+		unsigned char *hdr;
+	} ip;
+	union {
+		struct tcphdr *tcp;
+		struct udphdr *udp;
+		unsigned char *hdr;
+	} l4;
+	__be16 frag_off, protocol;
+	u8 inner_ip_type = 0, l4_type = 0, l4_csum = 0, l4_proto = 0;
+	u32 l2_len = 0, l3_len = 0, l4_len = 0;
+	unsigned char *exthdr;
+	int ret;
+
+	if (skb->ip_summed != CHECKSUM_PARTIAL)
+		return 0;
+
+	ip.hdr = skb_network_header(skb);
+	l4.hdr = skb_transport_header(skb);
+
+	/* compute outer L2 header size */
+	l2_len = ip.hdr - skb->data;
+
+	protocol = vlan_get_protocol(skb);
+
+	if (protocol == htons(ETH_P_IP)) {
+		inner_ip_type = NBL_TX_IIPT_IPV4;
+		l4_proto = ip.v4->protocol;
+	} else if (protocol == htons(ETH_P_IPV6)) {
+		inner_ip_type = NBL_TX_IIPT_IPV6;
+		exthdr = ip.hdr + sizeof(*ip.v6);
+		l4_proto = ip.v6->nexthdr;
+
+		if (l4.hdr != exthdr) {
+			ret = ipv6_skip_exthdr(skb, exthdr - skb->data,
+					       &l4_proto, &frag_off);
+			if (ret < 0)
+				return -1;
+		}
+	} else {
+		return -1;
+	}
+
+	l3_len = l4.hdr - ip.hdr;
+
+	switch (l4_proto) {
+	case IPPROTO_TCP:
+		l4_type = NBL_TX_L4T_TCP;
+		l4_len = l4.tcp->doff;
+		l4_csum = 1;
+		break;
+	case IPPROTO_UDP:
+		l4_type = NBL_TX_L4T_UDP;
+		l4_len = (sizeof(struct udphdr) >> 2);
+		l4_csum = 1;
+		break;
+	case IPPROTO_SCTP:
+		if (first->tx_flags & NBL_TX_FLAGS_TSO)
+			return -1;
+		l4_type = NBL_TX_L4T_RSV;
+		l4_len = (sizeof(struct sctphdr) >> 2);
+		l4_csum = 1;
+		break;
+	default:
+		if (first->tx_flags & NBL_TX_FLAGS_TSO)
+			return -2;
+
+		/* unsopported L4 protocol, device cannot offload L4 checksum,
+		 * so software compute L4 checskum
+		 */
+		skb_checksum_help(skb);
+		return 0;
+	}
+
+	hdr_param->mac_len = l2_len >> 1;
+	hdr_param->ip_len = l3_len >> 2;
+	hdr_param->l4_len = l4_len;
+	hdr_param->l4_type = l4_type;
+	hdr_param->inner_ip_type = inner_ip_type;
+	hdr_param->l3_csum_en = 0;
+	hdr_param->l4_csum_en = l4_csum;
+
+	return 1;
+}
+
+static __always_inline int nbl_tx_fill_desc(struct nbl_res_tx_ring *tx_ring,
+					    u64 dma, u32 size, u16 index,
+					    bool first, bool page)
+{
+	struct nbl_tx_buffer *tx_buffer = NBL_TX_BUF(tx_ring, index);
+	struct nbl_ring_desc *tx_desc = NBL_TX_DESC(tx_ring, index);
+
+	tx_buffer->dma = dma;
+	tx_buffer->len = size;
+	tx_buffer->page = page;
+	tx_desc->addr = cpu_to_le64(dma);
+	tx_desc->len = cpu_to_le32(size);
+	if (!first)
+		tx_desc->flags = cpu_to_le16(tx_ring->avail_used_flags |
+					     NBL_PACKED_DESC_F_NEXT);
+
+	index++;
+	if (index == tx_ring->desc_num) {
+		index = 0;
+		tx_ring->avail_used_flags ^= 1 << NBL_PACKED_DESC_F_AVAIL |
+					     1 << NBL_PACKED_DESC_F_USED;
+	}
+
+	return index;
+}
+
+static int nbl_map_skb(struct nbl_res_tx_ring *tx_ring, struct sk_buff *skb,
+		       u16 first, u16 *desc_index)
+{
+	u16 index = *desc_index;
+	const skb_frag_t *frag;
+	unsigned int frag_num = skb_shinfo(skb)->nr_frags;
+	struct device *dma_dev = NBL_RING_TO_DMA_DEV(tx_ring);
+	unsigned int i;
+	unsigned int size;
+	dma_addr_t dma;
+
+	size = skb_headlen(skb);
+	dma = dma_map_single(dma_dev, skb->data, size, DMA_TO_DEVICE);
+	if (dma_mapping_error(dma_dev, dma))
+		return -1;
+
+	index = nbl_tx_fill_desc(tx_ring, dma, size, index, first, 0);
+
+	if (!frag_num) {
+		*desc_index = index;
+		return 0;
+	}
+
+	frag = &skb_shinfo(skb)->frags[0];
+	for (i = 0; i < frag_num; i++) {
+		size = skb_frag_size(frag);
+		dma = skb_frag_dma_map(dma_dev, frag, 0, size, DMA_TO_DEVICE);
+		if (dma_mapping_error(dma_dev, dma)) {
+			*desc_index = index;
+			return -1;
+		}
+
+		index = nbl_tx_fill_desc(tx_ring, dma, size, index, 0, 1);
+		frag++;
+	}
+
+	*desc_index = index;
+	return 0;
+}
+
+static __always_inline void
+nbl_tx_fill_tx_extend_header_leonis(union nbl_tx_extend_head *pkthdr,
+				    struct nbl_tx_hdr_param *param)
+{
+	pkthdr->mac_len = param->mac_len;
+	pkthdr->ip_len = param->ip_len;
+	pkthdr->l4_len = param->l4_len;
+	pkthdr->l4_type = param->l4_type;
+	pkthdr->inner_ip_type = param->inner_ip_type;
+
+	pkthdr->l4s_sid = param->l4s_sid;
+	pkthdr->l4s_sync_ind = param->l4s_sync_ind;
+	pkthdr->l4s_hdl_ind = param->l4s_hdl_ind;
+	pkthdr->l4s_pbrac_mode = param->l4s_pbrac_mode;
+
+	pkthdr->mss = param->mss;
+	pkthdr->tso = param->tso;
+
+	pkthdr->fwd = param->fwd;
+	pkthdr->rss_lag_en = param->rss_lag_en;
+	pkthdr->dport = param->dport;
+	pkthdr->dport_id = param->dport_id;
+
+	pkthdr->l3_csum_en = param->l3_csum_en;
+	pkthdr->l4_csum_en = param->l4_csum_en;
+}
+
+static bool nbl_skb_is_lacp_or_lldp(struct sk_buff *skb)
+{
+	__be16 protocol;
+
+	protocol = vlan_get_protocol(skb);
+	if (protocol == htons(ETH_P_SLOW) || protocol == htons(ETH_P_LLDP))
+		return true;
+
+	return false;
+}
+
+static int nbl_tx_map(struct nbl_res_tx_ring *tx_ring, struct sk_buff *skb,
+		      struct nbl_tx_hdr_param *hdr_param)
+{
+	struct device *dma_dev = NBL_RING_TO_DMA_DEV(tx_ring);
+	struct nbl_tx_buffer *first;
+	struct nbl_ring_desc *first_desc;
+	struct nbl_ring_desc *tx_desc;
+	union nbl_tx_extend_head *pkthdr;
+	dma_addr_t hdrdma;
+	int tso, csum;
+	u16 desc_index = tx_ring->next_to_use;
+	u16 tmp;
+	u16 head = desc_index;
+	u16 avail_used_flags = tx_ring->avail_used_flags;
+	u32 pkthdr_len, len;
+	bool can_push;
+	bool doorbell = true;
+
+	first_desc = NBL_TX_DESC(tx_ring, desc_index);
+	first = NBL_TX_BUF(tx_ring, desc_index);
+	first->gso_segs = 1;
+	first->bytecount = skb->len;
+	first->tx_flags = 0;
+	first->skb = skb;
+	skb_tx_timestamp(skb);
+
+	can_push = !skb_header_cloned(skb) &&
+		   skb_headroom(skb) >= sizeof(*pkthdr);
+
+	if (can_push)
+		pkthdr = (union nbl_tx_extend_head *)(skb->data -
+						      sizeof(*pkthdr));
+	else
+		pkthdr = (union nbl_tx_extend_head *)(skb->cb);
+
+	tso = nbl_tx_tso(first, hdr_param);
+	if (tso < 0) {
+		netdev_err(tx_ring->netdev, "tso ret:%d\n", tso);
+		goto out_drop;
+	}
+
+	csum = nbl_tx_csum(first, hdr_param);
+	if (csum < 0) {
+		netdev_err(tx_ring->netdev, "csum ret:%d\n", csum);
+		goto out_drop;
+	}
+
+	memset(pkthdr, 0, sizeof(*pkthdr));
+	switch (tx_ring->product_type) {
+	case NBL_LEONIS_TYPE:
+		nbl_tx_fill_tx_extend_header_leonis(pkthdr, hdr_param);
+		break;
+	default:
+		netdev_err(tx_ring->netdev,
+			   "fill tx extend header failed, product type: %d, eth: %u.\n",
+			   tx_ring->product_type, hdr_param->dport_id);
+		goto out_drop;
+	}
+
+	pkthdr_len = sizeof(union nbl_tx_extend_head);
+
+	if (can_push) {
+		__skb_push(skb, pkthdr_len);
+		if (nbl_map_skb(tx_ring, skb, 1, &desc_index))
+			goto dma_map_error;
+		__skb_pull(skb, pkthdr_len);
+	} else {
+		hdrdma = dma_map_single(dma_dev, pkthdr, pkthdr_len,
+					DMA_TO_DEVICE);
+		if (dma_mapping_error(dma_dev, hdrdma)) {
+			tx_ring->tx_stats.tx_dma_busy++;
+			return NETDEV_TX_BUSY;
+		}
+
+		first_desc->addr = cpu_to_le64(hdrdma);
+		first_desc->len = cpu_to_le32(pkthdr_len);
+
+		first->dma = hdrdma;
+		first->len = pkthdr_len;
+
+		desc_index++;
+		if (desc_index == tx_ring->desc_num) {
+			desc_index = 0;
+			tx_ring->avail_used_flags ^=
+				1 << NBL_PACKED_DESC_F_AVAIL |
+				1 << NBL_PACKED_DESC_F_USED;
+		}
+		if (nbl_map_skb(tx_ring, skb, 0, &desc_index))
+			goto dma_map_error;
+	}
+
+	/* stats */
+	if (is_multicast_ether_addr(skb->data))
+		tx_ring->tx_stats.tx_multicast_packets += tso;
+	else
+		tx_ring->tx_stats.tx_unicast_packets += tso;
+
+	if (tso > 1) {
+		tx_ring->tx_stats.tso_packets++;
+		tx_ring->tx_stats.tso_bytes += skb->len;
+	}
+	tx_ring->tx_stats.tx_csum_packets += csum;
+	tmp = (desc_index == 0 ? tx_ring->desc_num : desc_index) - 1;
+	tx_desc = NBL_TX_DESC(tx_ring, tmp);
+	tx_desc->flags &= cpu_to_le16(~NBL_PACKED_DESC_F_NEXT);
+	len = le32_to_cpu(first_desc->len);
+	len += (hdr_param->total_hlen << NBL_TX_TOTAL_HEADERLEN_SHIFT);
+	first_desc->len = cpu_to_le32(len);
+	first_desc->id = cpu_to_le16(skb_shinfo(skb)->gso_size);
+
+	tx_ring->next_to_use = desc_index;
+	nbl_maybe_stop_tx(tx_ring, DESC_NEEDED);
+	if (nbl_txrx_within_vsi(&tx_ring->vsi_info[NBL_VSI_DATA],
+				tx_ring->queue_index))
+		doorbell = __netdev_tx_sent_queue(txring_txq(tx_ring),
+						  first->bytecount,
+						  netdev_xmit_more());
+	/* wmb */
+	wmb();
+
+	first->next_to_watch = tx_desc;
+	/* first desc last set flag */
+	if (first_desc == tx_desc)
+		first_desc->flags = cpu_to_le16(avail_used_flags);
+	else
+		first_desc->flags =
+			cpu_to_le16(avail_used_flags | NBL_PACKED_DESC_F_NEXT);
+
+	/* kick doorbell passthrough for performace */
+	if (doorbell)
+		writel(tx_ring->notify_qid, tx_ring->notify_addr);
+
+	return NETDEV_TX_OK;
+
+dma_map_error:
+	while (desc_index != head) {
+		if (unlikely(!desc_index))
+			desc_index = tx_ring->desc_num;
+		desc_index--;
+		nbl_unmap_and_free_tx_resource(tx_ring,
+					       NBL_TX_BUF(tx_ring, desc_index),
+					       false, false);
+	}
+
+	tx_ring->avail_used_flags = avail_used_flags;
+	tx_ring->tx_stats.tx_dma_busy++;
+	return NETDEV_TX_BUSY;
+
+out_drop:
+	netdev_err(tx_ring->netdev, "tx_map, free_skb\n");
+	tx_ring->tx_stats.tx_skb_free++;
+	dev_kfree_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+static netdev_tx_t nbl_res_txrx_start_xmit(struct sk_buff *skb,
+					   struct net_device *netdev)
+{
+	struct nbl_resource_mgt *res_mgt =
+		NBL_ADAP_TO_RES_MGT(NBL_NETDEV_TO_ADAPTER(netdev));
+	struct nbl_txrx_mgt *txrx_mgt = NBL_RES_MGT_TO_TXRX_MGT(res_mgt);
+	struct nbl_res_tx_ring *tx_ring =
+		txrx_mgt->tx_rings[skb_get_queue_mapping(skb)];
+	struct nbl_tx_hdr_param hdr_param = {
+		.mac_len = 14 >> 1,
+		.ip_len = 20 >> 2,
+		.l4_len = 20 >> 2,
+		.mss = 256,
+	};
+	u16 vlan_tci;
+	__be16 vlan_proto;
+	unsigned int count;
+	int ret = 0;
+
+	count = nbl_xmit_desc_count(skb);
+	/* we can not tranmit a packet with more than 32 descriptors */
+	WARN_ON(count > MAX_DESC_NUM_PER_PKT);
+	if (unlikely(nbl_maybe_stop_tx(tx_ring, count))) {
+		if (net_ratelimit())
+			dev_dbg(NBL_RING_TO_DEV(tx_ring),
+				"no desc to tx pkt in queue %u\n",
+				tx_ring->queue_index);
+		tx_ring->tx_stats.tx_busy++;
+		return NETDEV_TX_BUSY;
+	}
+
+	if (tx_ring->vlan_proto || skb_vlan_tag_present(skb)) {
+		if (tx_ring->vlan_proto) {
+			vlan_proto = htons(tx_ring->vlan_proto);
+			vlan_tci = tx_ring->vlan_tci;
+		}
+
+		if (skb_vlan_tag_present(skb)) {
+			vlan_proto = skb->vlan_proto;
+			vlan_tci = skb_vlan_tag_get(skb);
+		}
+
+		skb = vlan_insert_tag_set_proto(skb, vlan_proto, vlan_tci);
+		if (!skb)
+			return NETDEV_TX_OK;
+	}
+	/* for dstore and eth, min packet len is 60 */
+	if (unlikely(eth_skb_pad(skb)))
+		return NETDEV_TX_OK;
+
+	hdr_param.dport_id = tx_ring->eth_id;
+	hdr_param.fwd = 1;
+	hdr_param.rss_lag_en = 0;
+
+	if (nbl_skb_is_lacp_or_lldp(skb)) {
+		hdr_param.fwd = NBL_TX_FWD_TYPE_CPU_ASSIGNED;
+		hdr_param.dport = NBL_TX_DPORT_ETH;
+	}
+
+	/* for unicast packet tx_map all */
+	ret = nbl_tx_map(tx_ring, skb, &hdr_param);
+	return ret;
+}
+
+static void nbl_res_txrx_kick_rx_ring(void *priv, u16 index)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_notify_param notify_param = { 0 };
+	struct nbl_res_rx_ring *rx_ring =
+		NBL_RES_MGT_TO_RX_RING(res_mgt, index);
+
+	notify_param.notify_qid = rx_ring->notify_qid;
+	notify_param.tail_ptr = rx_ring->tail_ptr;
+	hw_ops->update_tail_ptr(NBL_RES_MGT_TO_HW_PRIV(res_mgt), &notify_param);
+}
+
+static struct nbl_napi_struct *nbl_res_txrx_get_vector_napi(void *priv,
+							    u16 index)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_txrx_mgt *txrx_mgt = res_mgt->txrx_mgt;
+
+	if (!txrx_mgt->vectors || index >= txrx_mgt->rx_ring_num) {
+		nbl_err(common, "vectors not allocated\n");
+		return NULL;
+	}
+
+	return &txrx_mgt->vectors[index]->nbl_napi;
+}
+
+static void nbl_res_txrx_set_vector_info(void *priv,
+					 u8 __iomem *irq_enable_base,
+					 u32 irq_data, u16 index, bool mask_en)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_common_info *common = NBL_RES_MGT_TO_COMMON(res_mgt);
+	struct nbl_txrx_mgt *txrx_mgt = res_mgt->txrx_mgt;
+
+	if (!txrx_mgt->vectors || index >= txrx_mgt->rx_ring_num) {
+		nbl_err(common, "vectors not allocated\n");
+		return;
+	}
+
+	txrx_mgt->vectors[index]->irq_enable_base = irq_enable_base;
+	txrx_mgt->vectors[index]->irq_data = irq_data;
+	txrx_mgt->vectors[index]->net_msix_mask_en = mask_en;
+}
+
+static void nbl_res_get_pt_ops(void *priv, struct nbl_resource_pt_ops *pt_ops)
+{
+	pt_ops->start_xmit = nbl_res_txrx_start_xmit;
+}
+
+static u32 nbl_res_txrx_get_tx_headroom(void *priv)
+{
+	return sizeof(union nbl_tx_extend_head);
+}
+
+static void nbl_res_txrx_get_net_stats(void *priv, struct nbl_stats *net_stats)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_txrx_mgt *txrx_mgt = NBL_RES_MGT_TO_TXRX_MGT(res_mgt);
+	struct nbl_res_rx_ring *rx_ring;
+	struct nbl_res_tx_ring *tx_ring;
+	int i;
+	u64 bytes = 0, packets = 0;
+	u64 tso_packets = 0, tso_bytes = 0;
+	u64 tx_csum_packets = 0;
+	u64 rx_csum_packets = 0, rx_csum_errors = 0;
+	u64 tx_multicast_packets = 0, tx_unicast_packets = 0;
+	u64 rx_multicast_packets = 0, rx_unicast_packets = 0;
+	u64 tx_busy = 0, tx_dma_busy = 0;
+	u64 tx_desc_addr_err_cnt = 0;
+	u64 tx_desc_len_err_cnt = 0;
+	u64 rx_desc_addr_err_cnt = 0;
+	u64 rx_alloc_buf_err_cnt = 0;
+	u64 rx_cache_reuse = 0;
+	u64 rx_cache_full = 0;
+	u64 rx_cache_empty = 0;
+	u64 rx_cache_busy = 0;
+	u64 rx_cache_waive = 0;
+	u64 tx_skb_free = 0;
+	unsigned int start;
+
+	rcu_read_lock();
+	for (i = 0; i < txrx_mgt->rx_ring_num; i++) {
+		rx_ring = NBL_RES_MGT_TO_RX_RING(res_mgt, i);
+		do {
+			start = u64_stats_fetch_begin(&rx_ring->syncp);
+			bytes += rx_ring->stats.bytes;
+			packets += rx_ring->stats.packets;
+			rx_csum_packets += rx_ring->rx_stats.rx_csum_packets;
+			rx_csum_errors += rx_ring->rx_stats.rx_csum_errors;
+			rx_multicast_packets +=
+				rx_ring->rx_stats.rx_multicast_packets;
+			rx_unicast_packets +=
+				rx_ring->rx_stats.rx_unicast_packets;
+			rx_desc_addr_err_cnt +=
+				rx_ring->rx_stats.rx_desc_addr_err_cnt;
+			rx_alloc_buf_err_cnt +=
+				rx_ring->rx_stats.rx_alloc_buf_err_cnt;
+			rx_cache_reuse += rx_ring->rx_stats.rx_cache_reuse;
+			rx_cache_full += rx_ring->rx_stats.rx_cache_full;
+			rx_cache_empty += rx_ring->rx_stats.rx_cache_empty;
+			rx_cache_busy += rx_ring->rx_stats.rx_cache_busy;
+			rx_cache_waive += rx_ring->rx_stats.rx_cache_waive;
+		} while (u64_stats_fetch_retry(&rx_ring->syncp, start));
+	}
+
+	net_stats->rx_packets = packets;
+	net_stats->rx_bytes = bytes;
+
+	net_stats->rx_csum_packets = rx_csum_packets;
+	net_stats->rx_csum_errors = rx_csum_errors;
+	net_stats->rx_multicast_packets = rx_multicast_packets;
+	net_stats->rx_unicast_packets = rx_unicast_packets;
+
+	bytes = 0;
+	packets = 0;
+
+	for (i = 0; i < txrx_mgt->tx_ring_num; i++) {
+		tx_ring = NBL_RES_MGT_TO_TX_RING(res_mgt, i);
+		do {
+			start = u64_stats_fetch_begin(&tx_ring->syncp);
+			bytes += tx_ring->stats.bytes;
+			packets += tx_ring->stats.packets;
+			tso_packets += tx_ring->tx_stats.tso_packets;
+			tso_bytes += tx_ring->tx_stats.tso_bytes;
+			tx_csum_packets += tx_ring->tx_stats.tx_csum_packets;
+			tx_busy += tx_ring->tx_stats.tx_busy;
+			tx_dma_busy += tx_ring->tx_stats.tx_dma_busy;
+			tx_multicast_packets +=
+				tx_ring->tx_stats.tx_multicast_packets;
+			tx_unicast_packets +=
+				tx_ring->tx_stats.tx_unicast_packets;
+			tx_skb_free += tx_ring->tx_stats.tx_skb_free;
+			tx_desc_addr_err_cnt +=
+				tx_ring->tx_stats.tx_desc_addr_err_cnt;
+			tx_desc_len_err_cnt +=
+				tx_ring->tx_stats.tx_desc_len_err_cnt;
+		} while (u64_stats_fetch_retry(&tx_ring->syncp, start));
+	}
+
+	rcu_read_unlock();
+
+	net_stats->tx_bytes = bytes;
+	net_stats->tx_packets = packets;
+	net_stats->tso_packets = tso_packets;
+	net_stats->tso_bytes = tso_bytes;
+	net_stats->tx_csum_packets = tx_csum_packets;
+	net_stats->tx_busy = tx_busy;
+	net_stats->tx_dma_busy = tx_dma_busy;
+	net_stats->tx_multicast_packets = tx_multicast_packets;
+	net_stats->tx_unicast_packets = tx_unicast_packets;
+	net_stats->tx_skb_free = tx_skb_free;
+	net_stats->tx_desc_addr_err_cnt = tx_desc_addr_err_cnt;
+	net_stats->tx_desc_len_err_cnt = tx_desc_len_err_cnt;
+	net_stats->rx_desc_addr_err_cnt = rx_desc_addr_err_cnt;
+	net_stats->rx_alloc_buf_err_cnt = rx_alloc_buf_err_cnt;
+	net_stats->rx_cache_reuse = rx_cache_reuse;
+	net_stats->rx_cache_full = rx_cache_full;
+	net_stats->rx_cache_empty = rx_cache_empty;
+	net_stats->rx_cache_busy = rx_cache_busy;
+	net_stats->rx_cache_waive = rx_cache_waive;
+}
+
+/* NBL_TXRX_SET_OPS(ops_name, func)
+ *
+ * Use X Macros to reduce setup and remove codes.
+ */
+#define NBL_TXRX_OPS_TBL						\
+do {									\
+	NBL_TXRX_SET_OPS(get_resource_pt_ops, nbl_res_get_pt_ops);	\
+	NBL_TXRX_SET_OPS(alloc_rings, nbl_res_txrx_alloc_rings);	\
+	NBL_TXRX_SET_OPS(remove_rings, nbl_res_txrx_remove_rings);	\
+	NBL_TXRX_SET_OPS(start_tx_ring, nbl_res_txrx_start_tx_ring);	\
+	NBL_TXRX_SET_OPS(stop_tx_ring, nbl_res_txrx_stop_tx_ring);	\
+	NBL_TXRX_SET_OPS(start_rx_ring, nbl_res_txrx_start_rx_ring);	\
+	NBL_TXRX_SET_OPS(stop_rx_ring, nbl_res_txrx_stop_rx_ring);	\
+	NBL_TXRX_SET_OPS(kick_rx_ring, nbl_res_txrx_kick_rx_ring);	\
+	NBL_TXRX_SET_OPS(get_vector_napi,				\
+			 nbl_res_txrx_get_vector_napi);			\
+	NBL_TXRX_SET_OPS(set_vector_info,				\
+			 nbl_res_txrx_set_vector_info);			\
+	NBL_TXRX_SET_OPS(get_tx_headroom,				\
+			 nbl_res_txrx_get_tx_headroom);			\
+	NBL_TXRX_SET_OPS(get_net_stats, nbl_res_txrx_get_net_stats);	\
+	NBL_TXRX_SET_OPS(register_vsi_ring,				\
+			 nbl_txrx_register_vsi_ring);			\
+} while (0)
+
+/* Structure starts here, adding an op should not modify anything below */
+static int nbl_txrx_setup_mgt(struct device *dev,
+			      struct nbl_txrx_mgt **txrx_mgt)
+{
+	*txrx_mgt = devm_kzalloc(dev, sizeof(struct nbl_txrx_mgt), GFP_KERNEL);
+	if (!*txrx_mgt)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void nbl_txrx_remove_mgt(struct device *dev,
+				struct nbl_txrx_mgt **txrx_mgt)
+{
+	devm_kfree(dev, *txrx_mgt);
+	*txrx_mgt = NULL;
+}
+
+int nbl_txrx_mgt_start(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev;
+	struct nbl_txrx_mgt **txrx_mgt;
+
+	dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	txrx_mgt = &NBL_RES_MGT_TO_TXRX_MGT(res_mgt);
+
+	return nbl_txrx_setup_mgt(dev, txrx_mgt);
+}
+
+void nbl_txrx_mgt_stop(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev;
+	struct nbl_txrx_mgt **txrx_mgt;
+
+	dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	txrx_mgt = &NBL_RES_MGT_TO_TXRX_MGT(res_mgt);
+
+	if (!(*txrx_mgt))
+		return;
+
+	nbl_txrx_remove_mgt(dev, txrx_mgt);
+}
+
+int nbl_txrx_setup_ops(struct nbl_resource_ops *res_ops)
+{
+#define NBL_TXRX_SET_OPS(name, func)		\
+	do {					\
+		res_ops->NBL_NAME(name) = func;	\
+		;				\
+	} while (0)
+	NBL_TXRX_OPS_TBL;
+#undef NBL_TXRX_SET_OPS
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_txrx.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_txrx.h
new file mode 100644
index 000000000000..de11f30a8210
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_txrx.h
@@ -0,0 +1,184 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_TXRX_H_
+#define _NBL_TXRX_H_
+
+#include "nbl_resource.h"
+
+#define NBL_RING_TO_COMMON(ring)	((ring)->common)
+#define NBL_RING_TO_DEV(ring)		((ring)->dma_dev)
+#define NBL_RING_TO_DMA_DEV(ring)	((ring)->dma_dev)
+
+#define NBL_MIN_DESC_NUM			128
+#define NBL_MAX_DESC_NUM			32768
+
+#define NBL_PACKED_DESC_F_NEXT			1
+#define NBL_PACKED_DESC_F_WRITE			2
+#define NBL_PACKED_DESC_F_AVAIL			7
+#define NBL_PACKED_DESC_F_USED			15
+
+#define NBL_TX_DESC(tx_ring, i)			(&(((tx_ring)->desc)[i]))
+#define NBL_RX_DESC(rx_ring, i)			(&(((rx_ring)->desc)[i]))
+#define NBL_TX_BUF(tx_ring, i)			(&(((tx_ring)->tx_bufs)[i]))
+#define NBL_RX_BUF(rx_ring, i)			(&(((rx_ring)->rx_bufs)[i]))
+
+#define NBL_RX_BUF_256		256
+#define NBL_RX_HDR_SIZE		NBL_RX_BUF_256
+#define NBL_BUFFER_HDR_LEN	(sizeof(struct nbl_rx_extend_head))
+#define NBL_RX_PAD		(NET_IP_ALIGN + NET_SKB_PAD)
+#define NBL_RX_BUFSZ		2048
+#define NBL_RX_DMA_ATTR	(DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
+
+#define NBL_TX_TOTAL_HEADERLEN_SHIFT		24
+#define DESC_NEEDED				(MAX_SKB_FRAGS + 4)
+#define NBL_TX_POLL_WEIGHT			256
+#define NBL_TXD_DATALEN_BITS			16
+#define NBL_TXD_DATALEN_MAX			BIT(NBL_TXD_DATALEN_BITS)
+#define MAX_DESC_NUM_PER_PKT			(32)
+
+#define IP_VERSION_V4				(4)
+#define NBL_TX_FLAGS_TSO			BIT(0)
+
+/* TX inner IP header type */
+enum nbl_tx_iipt {
+	NBL_TX_IIPT_NONE = 0x0,
+	NBL_TX_IIPT_IPV6 = 0x1,
+	NBL_TX_IIPT_IPV4 = 0x2,
+	NBL_TX_IIPT_RSV  = 0x3
+};
+
+/* TX L4 packet type */
+enum nbl_tx_l4t {
+	NBL_TX_L4T_NONE = 0x0,
+	NBL_TX_L4T_TCP  = 0x1,
+	NBL_TX_L4T_UDP  = 0x2,
+	NBL_TX_L4T_RSV  = 0x3
+};
+
+struct nbl_tx_hdr_param {
+	u8 l4s_pbrac_mode;
+	u8 l4s_hdl_ind;
+	u8 l4s_sync_ind;
+	u8 tso;
+	u16 l4s_sid;
+	u16 mss;
+	u8 mac_len;
+	u8 ip_len;
+	u8 l4_len;
+	u8 l4_type;
+	u8 inner_ip_type;
+	u8 l3_csum_en;
+	u8 l4_csum_en;
+	u16 total_hlen;
+	u16 dport_id:10;
+	u16 fwd:2;
+	u16 dport:3;
+	u16 rss_lag_en:1;
+};
+
+union nbl_tx_extend_head {
+	struct {
+		/* DW0 */
+		u32 mac_len :5;
+		u32 ip_len :5;
+		u32 l4_len :4;
+		u32 l4_type :2;
+		u32 inner_ip_type :2;
+		u32 external_ip_type :2;
+		u32 external_ip_len :5;
+		u32 l4_tunnel_type :2;
+		u32 l4_tunnel_len :5;
+		/* DW1 */
+		u32 l4s_sid :10;
+		u32 l4s_sync_ind :1;
+		u32 l4s_redun_ind :1;
+		u32 l4s_redun_head_ind :1;
+		u32 l4s_hdl_ind :1;
+		u32 l4s_pbrac_mode :1;
+		u32 rsv0 :2;
+		u32 mss :14;
+		u32 tso :1;
+		/* DW2 */
+		/* if dport = NBL_TX_DPORT_ETH; dport_info = 0
+		 * if dport = NBL_TX_DPORT_HOST; dport_info = host queue id
+		 * if dport = NBL_TX_DPORT_ECPU; dport_info = ecpu queue_id
+		 */
+		u32 dport_info :11;
+		/* if dport = NBL_TX_DPORT_ETH; dport_id[3:0] = eth port id,
+		 * dport_id[9:4] = lag id
+		 * if dport = NBL_TX_DPORT_HOST; dport_id[9:0] = host vsi_id
+		 * if dport = NBL_TX_DPORT_ECPU; dport_id[9:0] = ecpu vsi_id
+		 */
+		u32 dport_id :10;
+#define NBL_TX_DPORT_ID_LAG_OFFSET	(4)
+		u32 dport :3;
+#define NBL_TX_DPORT_ETH		(0)
+#define NBL_TX_DPORT_HOST		(1)
+#define NBL_TX_DPORT_ECPU		(2)
+#define NBL_TX_DPORT_EMP		(3)
+#define NBL_TX_DPORT_BMC		(4)
+		u32 fwd :2;
+#define NBL_TX_FWD_TYPE_DROP		(0)
+#define NBL_TX_FWD_TYPE_NORMAL		(1)
+#define NBL_TX_FWD_TYPE_RSV		(2)
+#define NBL_TX_FWD_TYPE_CPU_ASSIGNED	(3)
+		u32 rss_lag_en :1;
+		u32 l4_csum_en :1;
+		u32 l3_csum_en :1;
+		u32 rsv1 :3;
+	};
+	u32 dw[3];
+};
+
+struct nbl_rx_extend_head {
+	/* DW0 */
+	/* 0x0:eth, 0x1:host, 0x2:ecpu, 0x3:emp, 0x4:bcm */
+	uint32_t sport :3;
+	uint32_t dport_info :11;
+	/* sport = 0, sport_id[3:0] = eth id,
+	 * sport = 1, sport_id[9:0] = host vsi_id,
+	 * sport = 2, sport_id[9:0] = ecpu vsi_id,
+	 */
+	uint32_t sport_id :10;
+	/* 0x0:drop, 0x1:normal, 0x2:cpu upcall */
+	uint32_t fwd :2;
+	uint32_t rsv0 :6;
+	/* DW1 */
+	uint32_t error_code :6;
+	uint32_t ptype :10;
+	uint32_t profile_id :4;
+	uint32_t checksum_status :1;
+	uint32_t rsv1 :1;
+	uint32_t l4s_sid :10;
+	/* DW2 */
+	uint32_t rsv3 :2;
+	uint32_t l4s_hdl_ind :1;
+	uint32_t l4s_tcp_offset :14;
+	uint32_t l4s_resync_ind :1;
+	uint32_t l4s_check_ind :1;
+	uint32_t l4s_dec_ind :1;
+	uint32_t rsv2 :4;
+	uint32_t num_buffers :8;
+} __packed;
+
+static inline u16 nbl_unused_rx_desc_count(struct nbl_res_rx_ring *ring)
+{
+	u16 ntc = ring->next_to_clean;
+	u16 ntu = ring->next_to_use;
+
+	return ((ntc > ntu) ? 0 : ring->desc_num) + ntc - ntu - 1;
+}
+
+static inline u16 nbl_unused_tx_desc_count(struct nbl_res_tx_ring *ring)
+{
+	u16 ntc = ring->next_to_clean;
+	u16 ntu = ring->next_to_use;
+
+	return ((ntc > ntu) ? 0 : ring->desc_num) + ntc - ntu - 1;
+}
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index 0252082c55dc..176cce5e08d6 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -85,6 +85,9 @@ struct nbl_hw_ops {
 	void (*enable_msix_irq)(void *priv, u16 global_vec_id);
 	u8 __iomem *(*get_msix_irq_enable_info)(void *priv, u16 global_vec_id,
 						u32 *irq_data);
+	void (*update_tail_ptr)(void *priv, struct nbl_notify_param *param);
+	u8 __iomem *(*get_tail_ptr)(void *priv);
+
 	u32 (*get_fw_eth_num)(void *priv);
 	u32 (*get_fw_eth_map)(void *priv);
 	void (*get_board_info)(void *priv, struct nbl_board_port_info *board);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
index 1379567fb847..92abf384ef70 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
@@ -18,7 +18,10 @@ struct nbl_resource_pt_ops {
 struct nbl_resource_ops {
 	int (*init_chip_module)(void *priv);
 	void (*deinit_chip_module)(void *priv);
+	void (*get_resource_pt_ops)(void *priv,
+				    struct nbl_resource_pt_ops *pt_ops);
 	int (*queue_init)(void *priv);
+
 	int (*configure_msix_map)(void *priv, u16 func_id, u16 num_net_msix,
 				  u16 num_others_msix, bool net_msix_mask_en);
 	int (*destroy_msix_map)(void *priv, u16 func_id);
@@ -26,6 +29,21 @@ struct nbl_resource_ops {
 				  bool enable_msix);
 	u16 (*get_global_vector)(void *priv, u16 vsi_id, u16 local_vec_id);
 	u16 (*get_msix_entry_id)(void *priv, u16 vsi_id, u16 local_vec_id);
+
+	int (*alloc_rings)(void *priv, struct net_device *netdev,
+			   struct nbl_ring_param *param);
+	void (*remove_rings)(void *priv);
+	dma_addr_t (*start_tx_ring)(void *priv, u8 ring_index);
+	void (*stop_tx_ring)(void *priv, u8 ring_index);
+	dma_addr_t (*start_rx_ring)(void *priv, u8 ring_index, bool use_napi);
+	void (*stop_rx_ring)(void *priv, u8 ring_index);
+	void (*update_rx_ring)(void *priv, u16 index);
+	void (*kick_rx_ring)(void *priv, u16 index);
+	struct nbl_napi_struct *(*get_vector_napi)(void *priv, u16 index);
+	void (*set_vector_info)(void *priv, u8 __iomem *irq_enable_base,
+				u32 irq_data, u16 index, bool mask_en);
+	void (*register_vsi_ring)(void *priv, u16 vsi_index, u16 ring_offset,
+				  u16 ring_num);
 	int (*register_net)(void *priv, u16 func_id,
 			    struct nbl_register_net_param *register_param,
 			    struct nbl_register_net_result *register_result);
@@ -51,10 +69,14 @@ struct nbl_resource_ops {
 
 	u8 __iomem *(*get_msix_irq_enable_info)(void *priv, u16 global_vec_id,
 						u32 *irq_data);
+
 	u16 (*get_vsi_id)(void *priv, u16 func_id, u16 type);
 	void (*get_eth_id)(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id,
 			   u8 *logic_eth_id);
 	int (*set_promisc_mode)(void *priv, u16 vsi_id, u16 mode);
+	u32 (*get_tx_headroom)(void *priv);
+
+	void (*get_net_stats)(void *priv, struct nbl_stats *queue_stats);
 	void (*get_rxfh_indir_size)(void *priv, u16 vsi_id,
 				    u32 *rxfh_indir_size);
 	int (*set_rxfh_indir)(void *priv, u16 vsi_id, const u32 *indir,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index d4e18f2a2931..6d57391f85f9 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -42,6 +42,11 @@ enum {
 	NBL_VSI_MAX,
 };
 
+enum {
+	NBL_TX = 0,
+	NBL_RX,
+};
+
 struct nbl_func_caps {
 	u32 has_ctrl:1;
 	u32 has_net:1;
@@ -120,6 +125,11 @@ struct nbl_queue_cfg_param {
 	u16 half_offload_en;
 };
 
+struct nbl_msix_info_param {
+	u16 msix_num;
+	struct msix_entry *msix_entries;
+};
+
 struct nbl_queue_stats {
 	u64 packets;
 	u64 bytes;
@@ -182,6 +192,11 @@ struct nbl_stats {
 	u64 rx_bytes;
 };
 
+struct nbl_notify_param {
+	u16 notify_qid;
+	u16 tail_ptr;
+};
+
 enum nbl_fw_port_speed {
 	NBL_FW_PORT_SPEED_10G,
 	NBL_FW_PORT_SPEED_25G,
-- 
2.47.3


