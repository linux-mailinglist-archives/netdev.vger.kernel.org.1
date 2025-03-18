Return-Path: <netdev+bounces-175797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7EEA677CA
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5D63B7F61
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B0A17A30D;
	Tue, 18 Mar 2025 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="KFYPTujA"
X-Original-To: netdev@vger.kernel.org
Received: from lf-2-47.ptr.blmpb.com (lf-2-47.ptr.blmpb.com [101.36.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5B720DD66
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311816; cv=none; b=c4GgfnhJzHHkY7ptMpoe2/E9fbfXeAnEQSsPR0pqru4FjW568SvDA+1uDz/hmCaGXkYXtsZViafgESY6m3pegG9cI1MuBaQI60c40ytMTXrj50lj46EodFFTlynXZ4zqsCEwq9vZ9Qy26/oHn9In6wsdhjsKpJAQIkkQDr5GPao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311816; c=relaxed/simple;
	bh=MbExUi0h6iFXcz0n9LUC8aNcvFMqlK8SDEIm+0DLSeU=;
	h=To:Mime-Version:Subject:References:Cc:Message-Id:In-Reply-To:From:
	 Date:Content-Type; b=WsHZPFITVEI2/B5efqzT/AzwcnDLune6qmEYECMqhif6UcpPnzMoH6ukcTHaJrW9j3UD9sM1Vm47SsawUclTgYDH/WRWpKhDyL/ve8KXJ7hmgePgyjJGaXRmnyKiQO/sMH1RMMK7yKw0HpYHLj0Hi3gWeaQaRv1kwE8AXY8RD+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=KFYPTujA; arc=none smtp.client-ip=101.36.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1742310919; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=q71nZgLbjBwgXGDuEmvtcPJaju2yW2tB96/zDcxjhTo=;
 b=KFYPTujA8fi8vieJVNmDssVnkdDD3fL04KJOGBYbEYQ4fZ9+uNKw/+celHj+YXOepk7tUG
 5ZVAzV9tpBfM7K/1dVWks9gpsPGFRWv8gOuYgOdWDINL16MQmLtNF48RTyOro4SdqrirRX
 Z9QSoZcco5ccfoKrQ8XXTel44eXxrTB+SfNrtO1BaGsB2IeissH5YwGpe2K1D9DtVnYPnI
 wt7QaWTOQJK2t4hGYu65fAwi3FIgzQvP/c/iyr7YSLd1CjK6psAt6e2EQ6iI0eylXnQ+3s
 GUmdAOPdYOoCFmULlqaB/lNZ2tb/MidY+J7G31mTpg+tazhEZ0QMcTI0ZCxGAA==
To: <netdev@vger.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH net-next v9 11/14] xsc: ndo_open and ndo_stop
X-Mailer: git-send-email 2.25.1
References: <20250318151449.1376756-1-tianx@yunsilicon.com>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>, <pabeni@redhat.com>, <geert@linux-m68k.org>
Message-Id: <20250318151515.1376756-12-tianx@yunsilicon.com>
In-Reply-To: <20250318151449.1376756-1-tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Tue, 18 Mar 2025 23:15:16 +0800
From: "Xin Tian" <tianx@yunsilicon.com>
Date: Tue, 18 Mar 2025 23:15:16 +0800
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+267d98e05+f17e9e+vger.kernel.org+tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit

This patch implements ndo_open and ndo_close. The main task is to
initialize the channel resources.

A channel is a data transmission path. Each CPU is bound to a
channel, and each channel is associated with an interrupt.

A channel consists of one RX queue and multiple TX queues, with
the number of TX queues corresponding to the number of traffic
classes. Each TX queue and RX queue is a separate queue pair (QP).
The TX queue is used only for transmission, while the RX queue
is used only for reception. Each queue pair is bound to a
completion queue (CQ).

Each channel also has its own NAPI context.

The patch also add event handling functionality. Added a
workqueue and event handler to process asynchronous events from
the hardware.

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |   44 +
 .../yunsilicon/xsc/common/xsc_device.h        |   35 +
 .../net/ethernet/yunsilicon/xsc/net/Makefile  |    2 +-
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 1534 ++++++++++++++++-
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |    6 +
 .../yunsilicon/xsc/net/xsc_eth_common.h       |  142 ++
 .../ethernet/yunsilicon/xsc/net/xsc_eth_rx.c  |   48 +
 .../yunsilicon/xsc/net/xsc_eth_txrx.c         |  100 ++
 .../yunsilicon/xsc/net/xsc_eth_txrx.h         |   26 +
 .../ethernet/yunsilicon/xsc/net/xsc_queue.h   |  148 ++
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |    2 +-
 .../net/ethernet/yunsilicon/xsc/pci/vport.c   |   32 +
 12 files changed, 2115 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/vport.c

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index f9534993f..0b54b2d8a 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -150,6 +150,34 @@ enum xsc_event {
 	XSC_EVENT_TYPE_WQ_ACCESS_ERROR		= 0x11,
 };
 
+struct xsc_cqe {
+	__le32		data0;
+#define XSC_CQE_MSG_OPCD_MASK		GENMASK(7, 0)
+#define XSC_CQE_ERR_CODE_MASK		GENMASK(6, 0)
+#define XSC_CQE_IS_ERR			BIT(7)
+#define XSC_CQE_QP_ID_MASK		GENMASK(22, 8)
+#define XSC_CQE_SE			BIT(24)
+#define XSC_CQE_HAS_PPH			BIT(25)
+#define XSC_CQE_TYPE			BIT(26)
+#define XSC_CQE_WITH_IMM		BIT(27)
+#define XSC_CQE_CSUM_ERR_MASK		GENMASK(31, 28)
+
+	__le32		imm_data;
+	__le32		msg_len;
+	__le32		vni;
+	__le32		ts_l;
+	__le16		ts_h;
+	__le16		wqe_id;
+	__le32		rsv;
+	__le32		data1;
+#define XSC_CQE_OWNER			BIT(31)
+};
+
+/* cq doorbell bitfields */
+#define XSC_CQ_DB_NEXT_CID_MASK		GENMASK(15, 0)
+#define XSC_CQ_DB_CQ_ID_MASK		GENMASK(30, 16)
+#define XSC_CQ_DB_ARM			BIT(31)
+
 struct xsc_core_cq {
 	u32			cqn;
 	u32			cqe_sz;
@@ -372,6 +400,8 @@ struct xsc_core_device {
 	int			bar_num;
 
 	u8			mac_port;
+	u8			pcie_no;
+	u8			pf_id;
 	u16			glb_func_id;
 
 	u16			msix_vec_base;
@@ -395,6 +425,8 @@ struct xsc_core_device {
 	u32			fw_version_tweak;
 	u8			fw_version_extra_flag;
 	cpumask_var_t		xps_cpumask;
+
+	u8			user_mode;
 };
 
 int xsc_core_create_resource_common(struct xsc_core_device *xdev,
@@ -432,6 +464,8 @@ int xsc_core_frag_buf_alloc_node(struct xsc_core_device *xdev,
 void xsc_core_frag_buf_free(struct xsc_core_device *xdev,
 			    struct xsc_frag_buf *buf);
 
+u8 xsc_core_query_vport_state(struct xsc_core_device *xdev, u16 vport);
+
 static inline void *xsc_buf_offset(struct xsc_buf *buf, unsigned long offset)
 {
 	if (likely(buf->nbufs == 1))
@@ -446,4 +480,14 @@ static inline bool xsc_fw_is_available(struct xsc_core_device *xdev)
 	return xdev->cmd.cmd_status == XSC_CMD_STATUS_NORMAL;
 }
 
+static inline void xsc_set_user_mode(struct xsc_core_device *xdev, u8 mode)
+{
+	xdev->user_mode = mode;
+}
+
+static inline u8 xsc_get_user_mode(struct xsc_core_device *xdev)
+{
+	return xdev->user_mode;
+}
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h
index 45ea8d2a0..154a4e027 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h
@@ -6,6 +6,22 @@
 #ifndef __XSC_DEVICE_H
 #define __XSC_DEVICE_H
 
+#include <linux/types.h>
+#include <linux/ethtool.h>
+
+/* QP type */
+enum {
+	XSC_QUEUE_TYPE_RDMA_RC		= 0,
+	XSC_QUEUE_TYPE_RDMA_MAD		= 1,
+	XSC_QUEUE_TYPE_RAW		= 2,
+	XSC_QUEUE_TYPE_VIRTIO_NET	= 3,
+	XSC_QUEUE_TYPE_VIRTIO_BLK	= 4,
+	XSC_QUEUE_TYPE_RAW_TPE		= 5,
+	XSC_QUEUE_TYPE_RAW_TSO		= 6,
+	XSC_QUEUE_TYPE_RAW_TX		= 7,
+	XSC_QUEUE_TYPE_INVALID		= 0xFF,
+};
+
 enum xsc_traffic_types {
 	XSC_TT_IPV4,
 	XSC_TT_IPV4_TCP,
@@ -39,4 +55,23 @@ struct xsc_tirc_config {
 	u32 rx_hash_fields;
 };
 
+enum {
+	XSC_HASH_FUNC_XOR		= 0,
+	XSC_HASH_FUNC_TOP		= 1,
+	XSC_HASH_FUNC_TOP_SYM	= 2,
+	XSC_HASH_FUNC_RSV		= 3,
+};
+
+static inline u8 xsc_hash_func_type(u8 hash_func)
+{
+	switch (hash_func) {
+	case ETH_RSS_HASH_TOP:
+		return XSC_HASH_FUNC_TOP;
+	case ETH_RSS_HASH_XOR:
+		return XSC_HASH_FUNC_XOR;
+	default:
+		return XSC_HASH_FUNC_TOP;
+	}
+}
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
index ccbc5a26d..104ef5330 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
@@ -6,4 +6,4 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc_eth.o
 
-xsc_eth-y := main.o xsc_eth_wq.o
+xsc_eth-y := main.o xsc_eth_wq.o xsc_eth_txrx.o xsc_eth_rx.o
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
index cc40628f9..67e68a6f6 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -7,6 +7,7 @@
 #include <linux/etherdevice.h>
 #include <linux/auxiliary_bus.h>
 #include <linux/ethtool.h>
+#include <linux/irq.h>
 
 #include "common/xsc_core.h"
 #include "common/xsc_driver.h"
@@ -14,6 +15,7 @@
 #include "common/xsc_pp.h"
 #include "xsc_eth_common.h"
 #include "xsc_eth.h"
+#include "xsc_eth_txrx.h"
 
 static const struct xsc_tirc_config tirc_default_config[XSC_NUM_INDIR_TIRS] = {
 	[XSC_TT_IPV4] = {
@@ -114,6 +116,8 @@ static int xsc_eth_netdev_init(struct xsc_adapter *adapter)
 	if (!adapter->txq2sq)
 		goto err_out;
 
+	mutex_init(&adapter->status_lock);
+
 	adapter->workq = create_singlethread_workqueue("xsc_eth");
 	if (!adapter->workq)
 		goto err_free_priv;
@@ -128,11 +132,1536 @@ static int xsc_eth_netdev_init(struct xsc_adapter *adapter)
 	return -ENOMEM;
 }
 
-static int xsc_eth_close(struct net_device *netdev)
+static void xsc_eth_build_queue_param(struct xsc_adapter *adapter,
+				      struct xsc_queue_attr *attr, u8 type)
+{
+	struct xsc_core_device *xdev = adapter->xdev;
+
+	if (adapter->nic_param.sq_size == 0)
+		adapter->nic_param.sq_size = BIT(xdev->caps.log_max_qp_depth);
+	if (adapter->nic_param.rq_size == 0)
+		adapter->nic_param.rq_size = BIT(xdev->caps.log_max_qp_depth);
+
+	if (type == XSC_QUEUE_TYPE_EQ) {
+		attr->q_type = XSC_QUEUE_TYPE_EQ;
+		attr->ele_num = XSC_EQ_ELE_NUM;
+		attr->ele_size = XSC_EQ_ELE_SZ;
+		attr->ele_log_size = order_base_2(XSC_EQ_ELE_SZ);
+		attr->q_log_size = order_base_2(XSC_EQ_ELE_NUM);
+	} else if (type == XSC_QUEUE_TYPE_RQCQ) {
+		attr->q_type = XSC_QUEUE_TYPE_RQCQ;
+		attr->ele_num = min_t(int, XSC_RQCQ_ELE_NUM,
+				      xdev->caps.max_cqes);
+		attr->ele_size = XSC_RQCQ_ELE_SZ;
+		attr->ele_log_size = order_base_2(XSC_RQCQ_ELE_SZ);
+		attr->q_log_size = order_base_2(attr->ele_num);
+	} else if (type == XSC_QUEUE_TYPE_SQCQ) {
+		attr->q_type = XSC_QUEUE_TYPE_SQCQ;
+		attr->ele_num = min_t(int, XSC_SQCQ_ELE_NUM,
+				      xdev->caps.max_cqes);
+		attr->ele_size = XSC_SQCQ_ELE_SZ;
+		attr->ele_log_size = order_base_2(XSC_SQCQ_ELE_SZ);
+		attr->q_log_size = order_base_2(attr->ele_num);
+	} else if (type == XSC_QUEUE_TYPE_RQ) {
+		attr->q_type = XSC_QUEUE_TYPE_RQ;
+		attr->ele_num = adapter->nic_param.rq_size;
+		attr->ele_size = xdev->caps.recv_ds_num * XSC_RECV_WQE_DS;
+		attr->ele_log_size = order_base_2(attr->ele_size);
+		attr->q_log_size = order_base_2(attr->ele_num);
+	} else if (type == XSC_QUEUE_TYPE_SQ) {
+		attr->q_type = XSC_QUEUE_TYPE_SQ;
+		attr->ele_num = adapter->nic_param.sq_size;
+		attr->ele_size = xdev->caps.send_ds_num * XSC_SEND_WQE_DS;
+		attr->ele_log_size = order_base_2(attr->ele_size);
+		attr->q_log_size = order_base_2(attr->ele_num);
+	}
+}
+
+static u32 xsc_rx_get_linear_frag_sz(u32 mtu)
+{
+	u32 byte_count = XSC_SW2HW_FRAG_SIZE(mtu);
+
+	return XSC_SKB_FRAG_SZ(byte_count);
+}
+
+static bool xsc_rx_is_linear_skb(u32 mtu)
+{
+	u32 linear_frag_sz = xsc_rx_get_linear_frag_sz(mtu);
+
+	return linear_frag_sz <= PAGE_SIZE;
+}
+
+static u32 xsc_get_rq_frag_info(struct xsc_rq_frags_info *frags_info, u32 mtu)
+{
+	u32 byte_count = XSC_SW2HW_FRAG_SIZE(mtu);
+	int frag_stride;
+	int i = 0;
+
+	if (xsc_rx_is_linear_skb(mtu)) {
+		frag_stride = xsc_rx_get_linear_frag_sz(mtu);
+		frag_stride = roundup_pow_of_two(frag_stride);
+
+		frags_info->arr[0].frag_size = byte_count;
+		frags_info->arr[0].frag_stride = frag_stride;
+		frags_info->num_frags = 1;
+		frags_info->wqe_bulk = PAGE_SIZE / frag_stride;
+		frags_info->wqe_bulk_min = frags_info->wqe_bulk;
+		goto out;
+	}
+
+	if (byte_count <= DEFAULT_FRAG_SIZE) {
+		frags_info->arr[0].frag_size = DEFAULT_FRAG_SIZE;
+		frags_info->arr[0].frag_stride = DEFAULT_FRAG_SIZE;
+		frags_info->num_frags = 1;
+	} else if (byte_count <= PAGE_SIZE_4K) {
+		frags_info->arr[0].frag_size = PAGE_SIZE_4K;
+		frags_info->arr[0].frag_stride = PAGE_SIZE_4K;
+		frags_info->num_frags = 1;
+	} else if (byte_count <= (PAGE_SIZE_4K + DEFAULT_FRAG_SIZE)) {
+		if (PAGE_SIZE < 2 * PAGE_SIZE_4K) {
+			frags_info->arr[0].frag_size = PAGE_SIZE_4K;
+			frags_info->arr[0].frag_stride = PAGE_SIZE_4K;
+			frags_info->arr[1].frag_size = PAGE_SIZE_4K;
+			frags_info->arr[1].frag_stride = PAGE_SIZE_4K;
+			frags_info->num_frags = 2;
+		} else {
+			frags_info->arr[0].frag_size = 2 * PAGE_SIZE_4K;
+			frags_info->arr[0].frag_stride = 2 * PAGE_SIZE_4K;
+			frags_info->num_frags = 1;
+		}
+	} else if (byte_count <= 2 * PAGE_SIZE_4K) {
+		if (PAGE_SIZE < 2 * PAGE_SIZE_4K) {
+			frags_info->arr[0].frag_size = PAGE_SIZE_4K;
+			frags_info->arr[0].frag_stride = PAGE_SIZE_4K;
+			frags_info->arr[1].frag_size = PAGE_SIZE_4K;
+			frags_info->arr[1].frag_stride = PAGE_SIZE_4K;
+			frags_info->num_frags = 2;
+		} else {
+			frags_info->arr[0].frag_size = 2 * PAGE_SIZE_4K;
+			frags_info->arr[0].frag_stride = 2 * PAGE_SIZE_4K;
+			frags_info->num_frags = 1;
+		}
+	} else {
+		if (PAGE_SIZE < 4 * PAGE_SIZE_4K) {
+			frags_info->num_frags =
+				roundup(byte_count,
+					PAGE_SIZE_4K) / PAGE_SIZE_4K;
+			for (i = 0; i < frags_info->num_frags; i++) {
+				frags_info->arr[i].frag_size = PAGE_SIZE_4K;
+				frags_info->arr[i].frag_stride = PAGE_SIZE_4K;
+			}
+		} else {
+			frags_info->arr[0].frag_size = 4 * PAGE_SIZE_4K;
+			frags_info->arr[0].frag_stride = 4 * PAGE_SIZE_4K;
+			frags_info->num_frags = 1;
+		}
+	}
+
+	if (PAGE_SIZE <= PAGE_SIZE_4K) {
+		frags_info->wqe_bulk_min = 4;
+		frags_info->wqe_bulk = max_t(u8, frags_info->wqe_bulk_min, 8);
+	} else if (PAGE_SIZE <= 2 * PAGE_SIZE_4K) {
+		frags_info->wqe_bulk = 2;
+		frags_info->wqe_bulk_min = frags_info->wqe_bulk;
+	} else {
+		frags_info->wqe_bulk =
+			PAGE_SIZE /
+			(frags_info->num_frags * frags_info->arr[0].frag_size);
+		frags_info->wqe_bulk_min = frags_info->wqe_bulk;
+	}
+
+out:
+	frags_info->log_num_frags = order_base_2(frags_info->num_frags);
+
+	return frags_info->num_frags * frags_info->arr[0].frag_size;
+}
+
+static void xsc_build_rq_frags_info(struct xsc_queue_attr *attr,
+				    struct xsc_rq_frags_info *frags_info,
+				    struct xsc_eth_params *params)
+{
+	params->rq_frags_size = xsc_get_rq_frag_info(frags_info, params->mtu);
+	frags_info->frags_max_num = attr->ele_size / XSC_RECV_WQE_DS;
+}
+
+static void xsc_eth_build_channel_param(struct xsc_adapter *adapter,
+					struct xsc_channel_param *chl_param)
+{
+	xsc_eth_build_queue_param(adapter, &chl_param->rqcq_param.cq_attr,
+				  XSC_QUEUE_TYPE_RQCQ);
+	chl_param->rqcq_param.wq.buf_numa_node = dev_to_node(adapter->dev);
+
+	xsc_eth_build_queue_param(adapter, &chl_param->sqcq_param.cq_attr,
+				  XSC_QUEUE_TYPE_SQCQ);
+	chl_param->sqcq_param.wq.buf_numa_node = dev_to_node(adapter->dev);
+
+	xsc_eth_build_queue_param(adapter, &chl_param->sq_param.sq_attr,
+				  XSC_QUEUE_TYPE_SQ);
+	chl_param->sq_param.wq.buf_numa_node = dev_to_node(adapter->dev);
+
+	xsc_eth_build_queue_param(adapter, &chl_param->rq_param.rq_attr,
+				  XSC_QUEUE_TYPE_RQ);
+	chl_param->rq_param.wq.buf_numa_node = dev_to_node(adapter->dev);
+
+	xsc_build_rq_frags_info(&chl_param->rq_param.rq_attr,
+				&chl_param->rq_param.frags_info,
+				&adapter->nic_param);
+}
+
+static void xsc_eth_cq_error_event(struct xsc_core_cq *xcq,
+				   enum xsc_event event)
+{
+	struct xsc_cq *xsc_cq = container_of(xcq, struct xsc_cq, xcq);
+	struct xsc_core_device *xdev = xsc_cq->xdev;
+
+	if (event != XSC_EVENT_TYPE_CQ_ERROR) {
+		netdev_err(((struct xsc_adapter *)xdev->eth_priv)->netdev,
+			   "Unexpected event type %d on CQ %06x\n",
+			   event, xcq->cqn);
+		return;
+	}
+
+	netdev_err(((struct xsc_adapter *)xdev->eth_priv)->netdev,
+		   "Eth catch CQ ERROR: %x, cqn: %d\n", event, xcq->cqn);
+}
+
+static void xsc_eth_completion_event(struct xsc_core_cq *xcq)
+{
+	struct xsc_cq *cq = container_of(xcq, struct xsc_cq, xcq);
+	struct xsc_core_device *xdev = cq->xdev;
+	struct xsc_rq *rq = NULL;
+
+	if (unlikely(!cq->channel)) {
+		netdev_err(((struct xsc_adapter *)xdev->eth_priv)->netdev,
+			   "cq%d->channel is null\n", xcq->cqn);
+		return;
+	}
+
+	rq = &cq->channel->qp.rq[0];
+
+	set_bit(XSC_CHANNEL_NAPI_SCHED, &cq->channel->flags);
+
+	if (!test_bit(XSC_ETH_RQ_STATE_ENABLED, &rq->state))
+		netdev_err(((struct xsc_adapter *)xdev->eth_priv)->netdev,
+			   "ch%d_cq%d, napi_flag=0x%lx\n",
+			   cq->channel->chl_idx, xcq->cqn,
+			   cq->napi->state);
+
+	napi_schedule(cq->napi);
+	cq->event_ctr++;
+}
+
+static int xsc_eth_alloc_cq(struct xsc_channel *c, struct xsc_cq *pcq,
+			    struct xsc_cq_param *pcq_param)
+{
+	u8 ele_log_size = pcq_param->cq_attr.ele_log_size;
+	struct xsc_core_device *xdev = c->adapter->xdev;
+	u8 q_log_size = pcq_param->cq_attr.q_log_size;
+	struct xsc_core_cq *core_cq = &pcq->xcq;
+	int ret;
+	u32 i;
+
+	pcq_param->wq.db_numa_node = cpu_to_node(c->cpu);
+	pcq_param->wq.buf_numa_node = cpu_to_node(c->cpu);
+
+	ret = xsc_eth_cqwq_create(xdev, &pcq_param->wq,
+				  q_log_size, ele_log_size, &pcq->wq,
+				  &pcq->wq_ctrl);
+	if (ret)
+		return ret;
+
+	core_cq->cqe_sz = pcq_param->cq_attr.ele_num;
+	core_cq->comp = xsc_eth_completion_event;
+	core_cq->event = xsc_eth_cq_error_event;
+	core_cq->vector = c->chl_idx;
+
+	for (i = 0; i < xsc_cqwq_get_size(&pcq->wq); i++) {
+		struct xsc_cqe *cqe = xsc_cqwq_get_wqe(&pcq->wq, i);
+
+		cqe->data1 |= cpu_to_le32(XSC_CQE_OWNER);
+	}
+	pcq->xdev = xdev;
+
+	return ret;
+}
+
+static int xsc_eth_set_cq(struct xsc_channel *c,
+			  struct xsc_cq *pcq,
+			  struct xsc_cq_param *pcq_param)
+{
+	struct xsc_core_device *xdev = c->adapter->xdev;
+	struct xsc_create_cq_mbox_in *in;
+	unsigned int hw_npages;
+	unsigned int irqn;
+	int inlen;
+	u32 eqn;
+	int ret;
+
+	hw_npages = DIV_ROUND_UP(pcq->wq_ctrl.buf.size, PAGE_SIZE_4K);
+	/*mbox size + pas size*/
+	inlen = sizeof(struct xsc_create_cq_mbox_in) +
+		sizeof(__be64) * hw_npages;
+
+	in = kvzalloc(inlen, GFP_KERNEL);
+	if (!in)
+		return -ENOMEM;
+
+	/*construct param of in struct*/
+	ret = xsc_core_vector2eqn(xdev, c->chl_idx, &eqn, &irqn);
+	if (ret)
+		goto err_free;
+
+	in->ctx.eqn = cpu_to_be16(eqn);
+	in->ctx.log_cq_sz = pcq_param->cq_attr.q_log_size;
+	in->ctx.pa_num = cpu_to_be16(hw_npages);
+	in->ctx.glb_func_id = cpu_to_be16(xdev->glb_func_id);
+
+	xsc_core_fill_page_frag_array(&pcq->wq_ctrl.buf,
+				      &in->pas[0],
+				      hw_npages);
+
+	ret = xsc_core_eth_create_cq(c->adapter->xdev, &pcq->xcq, in, inlen);
+	if (ret)
+		goto err_free;
+	pcq->xcq.irqn = irqn;
+	pcq->xcq.eq = xsc_core_eq_get(xdev, pcq->xcq.vector);
+	return 0;
+
+err_free:
+	kvfree(in);
+	return ret;
+}
+
+static void xsc_eth_free_cq(struct xsc_cq *cq)
+{
+	xsc_eth_wq_destroy(&cq->wq_ctrl);
+}
+
+static int xsc_eth_open_cq(struct xsc_channel *c,
+			   struct xsc_cq *pcq,
+			   struct xsc_cq_param *pcq_param)
+{
+	int ret;
+
+	ret = xsc_eth_alloc_cq(c, pcq, pcq_param);
+	if (ret)
+		return ret;
+
+	ret = xsc_eth_set_cq(c, pcq, pcq_param);
+	if (ret)
+		goto err_free_cq;
+
+	xsc_cq_notify_hw_rearm(pcq);
+
+	pcq->napi = &c->napi;
+	pcq->channel = c;
+	pcq->rx = (pcq_param->cq_attr.q_type == XSC_QUEUE_TYPE_RQCQ) ? 1 : 0;
+
+	return 0;
+
+err_free_cq:
+	xsc_eth_free_cq(pcq);
+	return ret;
+}
+
+static int xsc_eth_close_cq(struct xsc_channel *c, struct xsc_cq *pcq)
+{
+	struct xsc_core_device *xdev = c->adapter->xdev;
+	int ret;
+
+	ret = xsc_core_eth_destroy_cq(xdev, &pcq->xcq);
+	if (ret) {
+		netdev_err(((struct xsc_adapter *)xdev->eth_priv)->netdev, "failed to close ch%d cq%d, ret=%d\n",
+			   c->chl_idx, pcq->xcq.cqn, ret);
+		return ret;
+	}
+
+	xsc_eth_free_cq(pcq);
+
+	return 0;
+}
+
+static void xsc_free_qp_sq_db(struct xsc_sq *sq)
+{
+	kvfree(sq->db.wqe_info);
+	kvfree(sq->db.dma_fifo);
+}
+
+static void xsc_free_qp_sq(struct xsc_sq *sq)
+{
+	xsc_free_qp_sq_db(sq);
+	xsc_eth_wq_destroy(&sq->wq_ctrl);
+}
+
+static int xsc_eth_alloc_qp_sq_db(struct xsc_sq *sq, int numa)
+{
+	struct xsc_core_device *xdev = sq->cq.xdev;
+	int wq_sz;
+	int df_sz;
+
+	wq_sz = xsc_wq_cyc_get_size(&sq->wq);
+	df_sz = wq_sz * xdev->caps.send_ds_num;
+	sq->db.dma_fifo = kvzalloc_node(array_size(df_sz,
+						   sizeof(*sq->db.dma_fifo)),
+					GFP_KERNEL,
+					numa);
+	sq->db.wqe_info = kvzalloc_node(array_size(wq_sz,
+						   sizeof(*sq->db.wqe_info)),
+					GFP_KERNEL,
+					numa);
+
+	if (!sq->db.dma_fifo || !sq->db.wqe_info) {
+		xsc_free_qp_sq_db(sq);
+		return -ENOMEM;
+	}
+
+	sq->dma_fifo_mask = df_sz - 1;
+
+	return 0;
+}
+
+static void xsc_eth_qp_event(struct xsc_core_qp *qp, int type)
+{
+	struct xsc_core_device *xdev;
+	struct xsc_rq *rq;
+	struct xsc_sq *sq;
+
+	if (qp->eth_queue_type == XSC_RES_RQ) {
+		rq = container_of(qp, struct xsc_rq, cqp);
+		xdev = rq->cq.xdev;
+	} else if (qp->eth_queue_type == XSC_RES_SQ) {
+		sq = container_of(qp, struct xsc_sq, cqp);
+		xdev = sq->cq.xdev;
+	} else {
+		pr_err("%s:Unknown eth qp type %d\n", __func__, type);
+		return;
+	}
+
+	switch (type) {
+	case XSC_EVENT_TYPE_WQ_CATAS_ERROR:
+	case XSC_EVENT_TYPE_WQ_INVAL_REQ_ERROR:
+	case XSC_EVENT_TYPE_WQ_ACCESS_ERROR:
+		netdev_err(((struct xsc_adapter *)xdev->eth_priv)->netdev,
+			   "%s:Async event %x on QP %d\n",
+			   __func__, type, qp->qpn);
+		break;
+	default:
+		netdev_err(((struct xsc_adapter *)xdev->eth_priv)->netdev,
+			   "%s: Unexpected event type %d on QP %d\n",
+			   __func__, type, qp->qpn);
+		return;
+	}
+}
+
+static int xsc_eth_open_qp_sq(struct xsc_channel *c,
+			      struct xsc_sq *psq,
+			      struct xsc_sq_param *psq_param,
+			      u32 sq_idx)
+{
+	u8 ele_log_size = psq_param->sq_attr.ele_log_size;
+	u8 q_log_size = psq_param->sq_attr.q_log_size;
+	struct xsc_modify_raw_qp_mbox_in *modify_in;
+	struct xsc_create_qp_mbox_in *in;
+	struct xsc_core_device *xdev;
+	struct xsc_adapter *adapter;
+	unsigned int hw_npages;
+	int inlen;
+	int ret;
+
+	adapter = c->adapter;
+	xdev  = adapter->xdev;
+	psq_param->wq.db_numa_node = cpu_to_node(c->cpu);
+
+	ret = xsc_eth_wq_cyc_create(xdev, &psq_param->wq,
+				    q_log_size, ele_log_size, &psq->wq,
+				    &psq->wq_ctrl);
+	if (ret)
+		return ret;
+
+	hw_npages = DIV_ROUND_UP(psq->wq_ctrl.buf.size, PAGE_SIZE_4K);
+	inlen = sizeof(struct xsc_create_qp_mbox_in) +
+		sizeof(__be64) * hw_npages;
+
+	in = kvzalloc(inlen, GFP_KERNEL);
+	if (!in) {
+		ret = -ENOMEM;
+		goto err_sq_wq_destroy;
+	}
+	in->req.input_qpn = cpu_to_be16(XSC_QPN_SQN_STUB); /*no use for eth*/
+	in->req.qp_type = XSC_QUEUE_TYPE_RAW_TSO; /*default sq is tso qp*/
+	in->req.log_sq_sz = ilog2(xdev->caps.send_ds_num) + q_log_size;
+	in->req.pa_num = cpu_to_be16(hw_npages);
+	in->req.cqn_send = cpu_to_be16(psq->cq.xcq.cqn);
+	in->req.cqn_recv = in->req.cqn_send;
+	in->req.glb_funcid = cpu_to_be16(xdev->glb_func_id);
+
+	xsc_core_fill_page_frag_array(&psq->wq_ctrl.buf,
+				      &in->req.pas[0], hw_npages);
+
+	ret = xsc_core_eth_create_qp(xdev, in, inlen, &psq->sqn);
+	if (ret)
+		goto err_sq_in_destroy;
+
+	psq->cqp.qpn = psq->sqn;
+	psq->cqp.event = xsc_eth_qp_event;
+	psq->cqp.eth_queue_type = XSC_RES_SQ;
+
+	ret = xsc_core_create_resource_common(xdev, &psq->cqp);
+	if (ret) {
+		netdev_err(adapter->netdev, "%s:error qp:%d errno:%d\n",
+			   __func__, psq->sqn, ret);
+		goto err_sq_destroy;
+	}
+
+	psq->channel = c;
+	psq->ch_ix = c->chl_idx;
+	psq->txq_ix = psq->ch_ix + sq_idx * adapter->channels.num_chl;
+
+	/*need to querify from hardware*/
+	psq->hw_mtu = XSC_ETH_HW_MTU_SEND;
+	psq->stop_room = 1;
+
+	ret = xsc_eth_alloc_qp_sq_db(psq, psq_param->wq.db_numa_node);
+	if (ret)
+		goto err_sq_common_destroy;
+
+	inlen = sizeof(struct xsc_modify_raw_qp_mbox_in);
+	modify_in = kvzalloc(inlen, GFP_KERNEL);
+	if (!modify_in) {
+		ret = -ENOMEM;
+		goto err_sq_common_destroy;
+	}
+
+	modify_in->req.qp_out_port = xdev->pf_id;
+	modify_in->pcie_no = xdev->pcie_no;
+	modify_in->req.qpn = cpu_to_be16((u16)(psq->sqn));
+	modify_in->req.func_id = cpu_to_be16(xdev->glb_func_id);
+	modify_in->req.dma_direct = XSC_DMA_DIR_TO_MAC;
+	modify_in->req.prio = sq_idx;
+	ret = xsc_core_eth_modify_raw_qp(xdev, modify_in);
+	if (ret)
+		goto err_sq_modify_in_destroy;
+
+	kvfree(modify_in);
+	kvfree(in);
+
+	return 0;
+
+err_sq_modify_in_destroy:
+	kvfree(modify_in);
+
+err_sq_common_destroy:
+	xsc_core_destroy_resource_common(xdev, &psq->cqp);
+
+err_sq_destroy:
+	xsc_core_eth_destroy_qp(xdev, psq->cqp.qpn);
+
+err_sq_in_destroy:
+	kvfree(in);
+
+err_sq_wq_destroy:
+	xsc_eth_wq_destroy(&psq->wq_ctrl);
+	return ret;
+}
+
+static int xsc_eth_close_qp_sq(struct xsc_channel *c, struct xsc_sq *psq)
+{
+	struct xsc_core_device *xdev = c->adapter->xdev;
+	int ret;
+
+	xsc_core_destroy_resource_common(xdev, &psq->cqp);
+
+	ret = xsc_core_eth_destroy_qp(xdev, psq->cqp.qpn);
+	if (ret)
+		return ret;
+
+	xsc_free_qp_sq(psq);
+
+	return 0;
+}
+
+static int xsc_eth_open_channel(struct xsc_adapter *adapter,
+				int idx,
+				struct xsc_channel *c,
+				struct xsc_channel_param *chl_param)
+{
+	struct xsc_core_device *xdev = adapter->xdev;
+	struct net_device *netdev = adapter->netdev;
+	const struct cpumask *aff;
+	unsigned int irqn;
+	int i, j;
+	u32 eqn;
+	int ret;
+
+	c->adapter = adapter;
+	c->netdev = adapter->netdev;
+	c->chl_idx = idx;
+	c->num_tc = adapter->nic_param.num_tc;
+
+	/*1rq per channel, and may have multi sqs per channel*/
+	c->qp.rq_num = 1;
+	c->qp.sq_num = c->num_tc;
+
+	if (xdev->caps.msix_enable) {
+		ret = xsc_core_vector2eqn(xdev, c->chl_idx, &eqn, &irqn);
+		if (ret)
+			goto err_out;
+		aff = irq_get_affinity_mask(irqn);
+		c->aff_mask = aff;
+		c->cpu = cpumask_first(aff);
+	}
+
+	if (c->qp.sq_num > XSC_MAX_NUM_TC || c->qp.rq_num > XSC_MAX_NUM_TC) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	for (i = 0; i < c->qp.rq_num; i++) {
+		ret = xsc_eth_open_cq(c, &c->qp.rq[i].cq,
+				      &chl_param->rqcq_param);
+		if (ret) {
+			j = i - 1;
+			goto err_close_rq_cq;
+		}
+	}
+
+	for (i = 0; i < c->qp.sq_num; i++) {
+		ret = xsc_eth_open_cq(c, &c->qp.sq[i].cq,
+				      &chl_param->sqcq_param);
+		if (ret) {
+			j = i - 1;
+			goto err_close_sq_cq;
+		}
+	}
+
+	for (i = 0; i < c->qp.sq_num; i++) {
+		ret = xsc_eth_open_qp_sq(c, &c->qp.sq[i],
+					 &chl_param->sq_param, i);
+		if (ret) {
+			j = i - 1;
+			goto err_close_sq;
+		}
+	}
+	netif_napi_add(netdev, &c->napi, xsc_eth_napi_poll);
+
+	netdev_dbg(adapter->netdev, "open channel%d ok\n", idx);
+	return 0;
+
+err_close_sq:
+	for (; j >= 0; j--)
+		xsc_eth_close_qp_sq(c, &c->qp.sq[j]);
+	j = (c->qp.rq_num - 1);
+err_close_sq_cq:
+	for (; j >= 0; j--)
+		xsc_eth_close_cq(c, &c->qp.sq[j].cq);
+	j = (c->qp.rq_num - 1);
+err_close_rq_cq:
+	for (; j >= 0; j--)
+		xsc_eth_close_cq(c, &c->qp.rq[j].cq);
+err_out:
+	netdev_err(adapter->netdev,
+		   "failed to open channel: ch%d, sq_num=%d, rq_num=%d, err=%d\n",
+		   idx, c->qp.sq_num, c->qp.rq_num, ret);
+	return ret;
+}
+
+static int xsc_eth_modify_qps_channel(struct xsc_adapter *adapter,
+				      struct xsc_channel *c)
+{
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < c->qp.rq_num; i++) {
+		c->qp.rq[i].post_wqes(&c->qp.rq[i]);
+		ret = xsc_core_eth_modify_qp_status(adapter->xdev,
+						    c->qp.rq[i].rqn,
+						    XSC_CMD_OP_RTR2RTS_QP);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < c->qp.sq_num; i++) {
+		ret = xsc_core_eth_modify_qp_status(adapter->xdev,
+						    c->qp.sq[i].sqn,
+						    XSC_CMD_OP_RTR2RTS_QP);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int xsc_eth_modify_qps(struct xsc_adapter *adapter,
+			      struct xsc_eth_channels *chls)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < chls->num_chl; i++) {
+		struct xsc_channel *c = &chls->c[i];
+
+		ret = xsc_eth_modify_qps_channel(adapter, c);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void xsc_eth_init_frags_partition(struct xsc_rq *rq)
+{
+	struct xsc_wqe_frag_info next_frag = {};
+	struct xsc_wqe_frag_info *prev;
+	int i;
+
+	next_frag.di = &rq->wqe.di[0];
+	next_frag.offset = 0;
+	prev = NULL;
+
+	for (i = 0; i < xsc_wq_cyc_get_size(&rq->wqe.wq); i++) {
+		struct xsc_rq_frag_info *frag_info = &rq->wqe.info.arr[0];
+		struct xsc_wqe_frag_info *frag =
+			&rq->wqe.frags[i << rq->wqe.info.log_num_frags];
+		int f;
+
+		for (f = 0; f < rq->wqe.info.num_frags; f++, frag++) {
+			if (next_frag.offset + frag_info[f].frag_stride >
+				XSC_RX_FRAG_SZ) {
+				next_frag.di++;
+				next_frag.offset = 0;
+				if (prev)
+					prev->last_in_page = 1;
+			}
+			*frag = next_frag;
+
+			/* prepare next */
+			next_frag.offset += frag_info[f].frag_stride;
+			prev = frag;
+		}
+	}
+
+	if (prev)
+		prev->last_in_page = 1;
+}
+
+static int xsc_eth_init_di_list(struct xsc_rq *rq, u32 wq_sz, int cpu)
+{
+	int len = wq_sz << rq->wqe.info.log_num_frags;
+
+	rq->wqe.di = kvzalloc_node(array_size(len, sizeof(*rq->wqe.di)),
+				   GFP_KERNEL, cpu_to_node(cpu));
+	if (!rq->wqe.di)
+		return -ENOMEM;
+
+	xsc_eth_init_frags_partition(rq);
+
+	return 0;
+}
+
+static void xsc_eth_free_di_list(struct xsc_rq *rq)
+{
+	kvfree(rq->wqe.di);
+}
+
+static int xsc_eth_alloc_rq(struct xsc_channel *c,
+			    struct xsc_rq *prq,
+			    struct xsc_rq_param *prq_param)
+{
+	u8 ele_log_size = prq_param->rq_attr.ele_log_size;
+	u8 q_log_size = prq_param->rq_attr.q_log_size;
+	struct page_pool_params pagepool_params = {0};
+	struct xsc_adapter *adapter = c->adapter;
+	u32 pool_size = 1 << q_log_size;
+	int ret = 0;
+	u32 wq_sz;
+	int i, f;
+
+	prq_param->wq.db_numa_node = cpu_to_node(c->cpu);
+
+	ret = xsc_eth_wq_cyc_create(c->adapter->xdev, &prq_param->wq,
+				    q_log_size, ele_log_size, &prq->wqe.wq,
+				    &prq->wq_ctrl);
+	if (ret)
+		return ret;
+
+	wq_sz = xsc_wq_cyc_get_size(&prq->wqe.wq);
+
+	prq->wqe.info = prq_param->frags_info;
+	prq->wqe.frags =
+		kvzalloc_node(array_size((wq_sz << prq->wqe.info.log_num_frags),
+					 sizeof(*prq->wqe.frags)),
+			      GFP_KERNEL,
+			      cpu_to_node(c->cpu));
+	if (!prq->wqe.frags) {
+		ret = -ENOMEM;
+		goto err_destroy_wq;
+	}
+
+	ret = xsc_eth_init_di_list(prq, wq_sz, c->cpu);
+	if (ret)
+		goto err_free_frags;
+
+	prq->buff.map_dir = DMA_FROM_DEVICE;
+
+	/* Create a page_pool and register it with rxq */
+	pool_size =  wq_sz << prq->wqe.info.log_num_frags;
+	pagepool_params.order		= XSC_RX_FRAG_SZ_ORDER;
+	/* No-internal DMA mapping in page_pool */
+	pagepool_params.flags		= 0;
+	pagepool_params.pool_size	= pool_size;
+	pagepool_params.nid		= cpu_to_node(c->cpu);
+	pagepool_params.dev		= c->adapter->dev;
+	pagepool_params.dma_dir	= prq->buff.map_dir;
+
+	prq->page_pool = page_pool_create(&pagepool_params);
+	if (IS_ERR(prq->page_pool)) {
+		ret = PTR_ERR(prq->page_pool);
+		prq->page_pool = NULL;
+		goto err_free_di_list;
+	}
+
+	if (c->chl_idx == 0)
+		netdev_dbg(adapter->netdev,
+			   "page pool: size=%d, cpu=%d, pool_numa=%d, mtu=%d, wqe_numa=%d\n",
+			   pool_size, c->cpu, pagepool_params.nid,
+			   adapter->nic_param.mtu,
+			   prq_param->wq.buf_numa_node);
+
+	for (i = 0; i < wq_sz; i++) {
+		struct xsc_eth_rx_wqe_cyc *wqe =
+			xsc_wq_cyc_get_wqe(&prq->wqe.wq, i);
+
+		for (f = 0; f < prq->wqe.info.num_frags; f++) {
+			u32 frag_size = prq->wqe.info.arr[f].frag_size;
+			u32 val = 0;
+
+			val |= FIELD_PREP(XSC_WQE_DATA_SEG_SEG_LEN_MASK,
+					  frag_size);
+			wqe->data[f].data0 = cpu_to_le32(val);
+			wqe->data[f].mkey = cpu_to_le32(XSC_INVALID_LKEY);
+		}
+
+		for (; f < prq->wqe.info.frags_max_num; f++) {
+			wqe->data[f].data0 = 0;
+			wqe->data[f].mkey = cpu_to_le32(XSC_INVALID_LKEY);
+			wqe->data[f].va = 0;
+		}
+	}
+
+	prq->post_wqes = xsc_eth_post_rx_wqes;
+	prq->handle_rx_cqe = xsc_eth_handle_rx_cqe;
+	prq->dealloc_wqe = xsc_eth_dealloc_rx_wqe;
+	prq->wqe.skb_from_cqe = xsc_rx_is_linear_skb(adapter->nic_param.mtu) ?
+					xsc_skb_from_cqe_linear :
+					xsc_skb_from_cqe_nonlinear;
+	prq->ix = c->chl_idx;
+	prq->frags_sz = adapter->nic_param.rq_frags_size;
+
+	return 0;
+
+err_free_di_list:
+	xsc_eth_free_di_list(prq);
+err_free_frags:
+	kvfree(prq->wqe.frags);
+err_destroy_wq:
+	xsc_eth_wq_destroy(&prq->wq_ctrl);
+	return ret;
+}
+
+static void xsc_free_qp_rq(struct xsc_rq *rq)
+{
+	kvfree(rq->wqe.frags);
+	kvfree(rq->wqe.di);
+
+	if (rq->page_pool)
+		page_pool_destroy(rq->page_pool);
+
+	xsc_eth_wq_destroy(&rq->wq_ctrl);
+}
+
+static int xsc_eth_open_rss_qp_rqs(struct xsc_adapter *adapter,
+				   struct xsc_rq_param *prq_param,
+				   struct xsc_eth_channels *chls,
+				   unsigned int num_chl)
+{
+	u8 q_log_size = prq_param->rq_attr.q_log_size;
+	struct xsc_create_multiqp_mbox_in *in;
+	struct xsc_create_qp_request *req;
+	unsigned int hw_npages;
+	struct xsc_channel *c;
+	int ret = 0, err = 0;
+	struct xsc_rq *prq;
+	int paslen = 0;
+	int entry_len;
+	u32 rqn_base;
+	int i, j, n;
+	int inlen;
+
+	for (i = 0; i < num_chl; i++) {
+		c = &chls->c[i];
+
+		for (j = 0; j < c->qp.rq_num; j++) {
+			prq = &c->qp.rq[j];
+			ret = xsc_eth_alloc_rq(c, prq, prq_param);
+			if (ret)
+				goto err_alloc_rqs;
+
+			hw_npages = DIV_ROUND_UP(prq->wq_ctrl.buf.size,
+						 PAGE_SIZE_4K);
+			/*support different npages number smoothly*/
+			entry_len = sizeof(struct xsc_create_qp_request) +
+				sizeof(__be64) * hw_npages;
+
+			paslen += entry_len;
+		}
+	}
+
+	inlen = sizeof(struct xsc_create_multiqp_mbox_in) + paslen;
+	in = kvzalloc(inlen, GFP_KERNEL);
+	if (!in) {
+		ret = -ENOMEM;
+		goto err_create_rss_rqs;
+	}
+
+	in->qp_num = cpu_to_be16(num_chl);
+	in->qp_type = XSC_QUEUE_TYPE_RAW;
+	in->req_len = cpu_to_be32(inlen);
+
+	req = (struct xsc_create_qp_request *)&in->data[0];
+	n = 0;
+	for (i = 0; i < num_chl; i++) {
+		c = &chls->c[i];
+		for (j = 0; j < c->qp.rq_num; j++) {
+			prq = &c->qp.rq[j];
+
+			hw_npages = DIV_ROUND_UP(prq->wq_ctrl.buf.size,
+						 PAGE_SIZE_4K);
+			/* no use for eth */
+			req->input_qpn = cpu_to_be16(0);
+			req->qp_type = XSC_QUEUE_TYPE_RAW;
+			req->log_rq_sz = ilog2(adapter->xdev->caps.recv_ds_num)
+						+ q_log_size;
+			req->pa_num = cpu_to_be16(hw_npages);
+			req->cqn_recv = cpu_to_be16(prq->cq.xcq.cqn);
+			req->cqn_send = req->cqn_recv;
+			req->glb_funcid =
+				cpu_to_be16(adapter->xdev->glb_func_id);
+
+			xsc_core_fill_page_frag_array(&prq->wq_ctrl.buf,
+						      &req->pas[0],
+						      hw_npages);
+			n++;
+			req = (struct xsc_create_qp_request *)
+				(&in->data[0] + entry_len * n);
+		}
+	}
+
+	ret = xsc_core_eth_create_rss_qp_rqs(adapter->xdev, in, inlen,
+					     &rqn_base);
+	kvfree(in);
+	if (ret)
+		goto err_create_rss_rqs;
+
+	n = 0;
+	for (i = 0; i < num_chl; i++) {
+		c = &chls->c[i];
+		for (j = 0; j < c->qp.rq_num; j++) {
+			prq = &c->qp.rq[j];
+			prq->rqn = rqn_base + n;
+			prq->cqp.qpn = prq->rqn;
+			prq->cqp.event = xsc_eth_qp_event;
+			prq->cqp.eth_queue_type = XSC_RES_RQ;
+			ret = xsc_core_create_resource_common(adapter->xdev,
+							      &prq->cqp);
+			if (ret) {
+				err = ret;
+				netdev_err(adapter->netdev,
+					   "create resource common error qp:%d errno:%d\n",
+					   prq->rqn, ret);
+				continue;
+			}
+
+			n++;
+		}
+	}
+	if (err)
+		return err;
+
+	adapter->channels.rqn_base = rqn_base;
+	return 0;
+
+err_create_rss_rqs:
+	i = num_chl;
+err_alloc_rqs:
+	for (--i; i >= 0; i--) {
+		c = &chls->c[i];
+		for (j = 0; j < c->qp.rq_num; j++) {
+			prq = &c->qp.rq[j];
+			xsc_free_qp_rq(prq);
+		}
+	}
+	return ret;
+}
+
+static void xsc_eth_free_rx_wqe(struct xsc_rq *rq)
+{
+	struct xsc_wq_cyc *wq = &rq->wqe.wq;
+	u16 wqe_ix;
+
+	while (!xsc_wq_cyc_is_empty(wq)) {
+		wqe_ix = xsc_wq_cyc_get_tail(wq);
+		rq->dealloc_wqe(rq, wqe_ix);
+		xsc_wq_cyc_pop(wq);
+	}
+}
+
+static int xsc_eth_close_qp_rq(struct xsc_channel *c, struct xsc_rq *prq)
+{
+	struct xsc_core_device *xdev = c->adapter->xdev;
+	int ret;
+
+	xsc_core_destroy_resource_common(xdev, &prq->cqp);
+
+	ret = xsc_core_eth_destroy_qp(xdev, prq->cqp.qpn);
+	if (ret)
+		return ret;
+
+	xsc_eth_free_rx_wqe(prq);
+	xsc_free_qp_rq(prq);
+
+	return 0;
+}
+
+static void xsc_eth_close_channel(struct xsc_channel *c, bool free_rq)
+{
+	int i;
+
+	for (i = 0; i < c->qp.rq_num; i++) {
+		if (free_rq)
+			xsc_eth_close_qp_rq(c, &c->qp.rq[i]);
+		xsc_eth_close_cq(c, &c->qp.rq[i].cq);
+		memset(&c->qp.rq[i], 0, sizeof(struct xsc_rq));
+	}
+
+	for (i = 0; i < c->qp.sq_num; i++) {
+		xsc_eth_close_qp_sq(c, &c->qp.sq[i]);
+		xsc_eth_close_cq(c, &c->qp.sq[i].cq);
+	}
+
+	netif_napi_del(&c->napi);
+}
+
+static int xsc_eth_open_channels(struct xsc_adapter *adapter)
+{
+	struct xsc_eth_channels *chls = &adapter->channels;
+	struct xsc_core_device *xdev = adapter->xdev;
+	struct xsc_channel_param *chl_param;
+	bool free_rq = false;
+	int ret = 0;
+	int i;
+
+	chls->num_chl = adapter->nic_param.num_channels;
+	chls->c = kcalloc_node(chls->num_chl, sizeof(struct xsc_channel),
+			       GFP_KERNEL, xdev->numa_node);
+	if (!chls->c) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	chl_param = kvzalloc(sizeof(*chl_param), GFP_KERNEL);
+	if (!chl_param) {
+		ret = -ENOMEM;
+		goto err_free_ch;
+	}
+
+	xsc_eth_build_channel_param(adapter, chl_param);
+
+	for (i = 0; i < chls->num_chl; i++) {
+		ret = xsc_eth_open_channel(adapter, i, &chls->c[i], chl_param);
+		if (ret)
+			goto err_close_channel;
+	}
+
+	ret = xsc_eth_open_rss_qp_rqs(adapter,
+				      &chl_param->rq_param,
+				      chls,
+				      chls->num_chl);
+	if (ret)
+		goto err_close_channel;
+	free_rq = true;
+
+	for (i = 0; i < chls->num_chl; i++)
+		napi_enable(&chls->c[i].napi);
+
+	/* flush cache to memory before interrupt and napi_poll running */
+	smp_wmb();
+
+	ret = xsc_eth_modify_qps(adapter, chls);
+	if (ret)
+		goto err_close_channel;
+
+	kvfree(chl_param);
+	return 0;
+
+err_close_channel:
+	for (--i; i >= 0; i--)
+		xsc_eth_close_channel(&chls->c[i], free_rq);
+
+	kvfree(chl_param);
+err_free_ch:
+	kfree(chls->c);
+err_out:
+	chls->num_chl = 0;
+	netdev_err(adapter->netdev, "failed to open %d channels, err=%d\n",
+		   chls->num_chl, ret);
+	return ret;
+}
+
+static void xsc_eth_close_channels(struct xsc_adapter *adapter)
+{
+	struct xsc_channel *c;
+	int i;
+
+	for (i = 0; i < adapter->channels.num_chl; i++) {
+		c = &adapter->channels.c[i];
+
+		xsc_eth_close_channel(c, true);
+	}
+
+	kfree(adapter->channels.c);
+	adapter->channels.num_chl = 0;
+}
+
+static void xsc_netdev_set_tcs(struct xsc_adapter *priv, u16 nch, u8 ntc)
+{
+	int tc;
+
+	netdev_reset_tc(priv->netdev);
+
+	if (ntc == 1)
+		return;
+
+	netdev_set_num_tc(priv->netdev, ntc);
+
+	/* Map netdev TCs to offset 0
+	 * We have our own UP to TXQ mapping for QoS
+	 */
+	for (tc = 0; tc < ntc; tc++)
+		netdev_set_tc_queue(priv->netdev, tc, nch, 0);
+}
+
+static void xsc_eth_build_tx2sq_maps(struct xsc_adapter *adapter)
+{
+	struct xsc_channel *c;
+	struct xsc_sq *psq;
+	int i, tc;
+
+	for (i = 0; i < adapter->channels.num_chl; i++) {
+		c = &adapter->channels.c[i];
+		for (tc = 0; tc < c->num_tc; tc++) {
+			psq = &c->qp.sq[tc];
+			adapter->txq2sq[psq->txq_ix] = psq;
+		}
+	}
+}
+
+static void xsc_eth_activate_txqsq(struct xsc_channel *c)
+{
+	int tc = c->num_tc;
+	struct xsc_sq *psq;
+
+	for (tc = 0; tc < c->num_tc; tc++) {
+		psq = &c->qp.sq[tc];
+		psq->txq = netdev_get_tx_queue(psq->channel->netdev,
+					       psq->txq_ix);
+		set_bit(XSC_ETH_SQ_STATE_ENABLED, &psq->state);
+		netdev_tx_reset_queue(psq->txq);
+		netif_tx_start_queue(psq->txq);
+	}
+}
+
+static void xsc_eth_deactivate_txqsq(struct xsc_channel *c)
+{
+	int tc = c->num_tc;
+	struct xsc_sq *psq;
+
+	for (tc = 0; tc < c->num_tc; tc++) {
+		psq = &c->qp.sq[tc];
+		clear_bit(XSC_ETH_SQ_STATE_ENABLED, &psq->state);
+	}
+}
+
+static void xsc_activate_rq(struct xsc_channel *c)
+{
+	int i;
+
+	for (i = 0; i < c->qp.rq_num; i++)
+		set_bit(XSC_ETH_RQ_STATE_ENABLED, &c->qp.rq[i].state);
+}
+
+static void xsc_deactivate_rq(struct xsc_channel *c)
+{
+	int i;
+
+	for (i = 0; i < c->qp.rq_num; i++)
+		clear_bit(XSC_ETH_RQ_STATE_ENABLED, &c->qp.rq[i].state);
+}
+
+static void xsc_eth_activate_channel(struct xsc_channel *c)
+{
+	xsc_eth_activate_txqsq(c);
+	xsc_activate_rq(c);
+}
+
+static void xsc_eth_deactivate_channel(struct xsc_channel *c)
+{
+	xsc_deactivate_rq(c);
+	xsc_eth_deactivate_txqsq(c);
+}
+
+static void xsc_eth_activate_channels(struct xsc_eth_channels *chs)
+{
+	int i;
+
+	for (i = 0; i < chs->num_chl; i++)
+		xsc_eth_activate_channel(&chs->c[i]);
+}
+
+static void xsc_eth_deactivate_channels(struct xsc_eth_channels *chs)
+{
+	int i;
+
+	for (i = 0; i < chs->num_chl; i++)
+		xsc_eth_deactivate_channel(&chs->c[i]);
+
+	/* Sync with all NAPIs to wait until they stop using queues. */
+	synchronize_net();
+
+	for (i = 0; i < chs->num_chl; i++)
+		/* last doorbell out */
+		napi_disable(&chs->c[i].napi);
+}
+
+static void xsc_eth_activate_priv_channels(struct xsc_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	int num_txqs;
+
+	num_txqs = adapter->channels.num_chl * adapter->nic_param.num_tc;
+	xsc_netdev_set_tcs(adapter,
+			   adapter->channels.num_chl,
+			   adapter->nic_param.num_tc);
+	netif_set_real_num_tx_queues(netdev, num_txqs);
+	netif_set_real_num_rx_queues(netdev, adapter->channels.num_chl);
+
+	xsc_eth_build_tx2sq_maps(adapter);
+	xsc_eth_activate_channels(&adapter->channels);
+	netif_tx_start_all_queues(adapter->netdev);
+}
+
+static void xsc_eth_deactivate_priv_channels(struct xsc_adapter *adapter)
+{
+	netif_tx_disable(adapter->netdev);
+	xsc_eth_deactivate_channels(&adapter->channels);
+}
+
+static int xsc_eth_sw_init(struct xsc_adapter *adapter)
+{
+	int ret;
+
+	ret = xsc_eth_open_channels(adapter);
+	if (ret)
+		return ret;
+
+	xsc_eth_activate_priv_channels(adapter);
+
+	return 0;
+}
+
+static void xsc_eth_sw_deinit(struct xsc_adapter *adapter)
+{
+	xsc_eth_deactivate_priv_channels(adapter);
+
+	return xsc_eth_close_channels(adapter);
+}
+
+static bool xsc_eth_get_link_status(struct xsc_adapter *adapter)
+{
+	struct xsc_core_device *xdev = adapter->xdev;
+	u16 vport = 0;
+	bool link_up;
+
+	link_up = xsc_core_query_vport_state(xdev, vport);
+
+	return link_up ? true : false;
+}
+
+static int xsc_eth_change_link_status(struct xsc_adapter *adapter)
+{
+	bool link_up;
+
+	link_up = xsc_eth_get_link_status(adapter);
+
+	if (link_up && !netif_carrier_ok(adapter->netdev)) {
+		netdev_info(adapter->netdev, "Link up\n");
+		netif_carrier_on(adapter->netdev);
+	} else if (!link_up && netif_carrier_ok(adapter->netdev)) {
+		netdev_info(adapter->netdev, "Link down\n");
+		netif_carrier_off(adapter->netdev);
+	}
+
+	return 0;
+}
+
+static void xsc_eth_event_work(struct work_struct *work)
+{
+	struct xsc_adapter *adapter = container_of(work,
+						   struct xsc_adapter,
+						   event_work);
+	struct xsc_event_query_type_mbox_out out;
+	struct xsc_event_query_type_mbox_in in;
+	int err;
+
+	if (adapter->status != XSCALE_ETH_DRIVER_OK)
+		return;
+
+	/*query cmd_type cmd*/
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_QUERY_EVENT_TYPE);
+
+	err = xsc_cmd_exec(adapter->xdev, &in, sizeof(in), &out, sizeof(out));
+	if (err || out.hdr.status) {
+		netdev_err(adapter->netdev, "failed to query event type, err=%d, status=%d\n",
+			   err, out.hdr.status);
+		goto err_out;
+	}
+
+	switch (out.ctx.resp_cmd_type) {
+	case XSC_CMD_EVENT_RESP_CHANGE_LINK:
+		err = xsc_eth_change_link_status(adapter);
+		if (err) {
+			netdev_err(adapter->netdev, "failed to change linkstatus, err=%d\n",
+				   err);
+			goto err_out;
+		}
+		break;
+	case XSC_CMD_EVENT_RESP_TEMP_WARN:
+		netdev_err(adapter->netdev, "[Minor]nic chip temperature high warning\n");
+		break;
+	case XSC_CMD_EVENT_RESP_OVER_TEMP_PROTECTION:
+		netdev_err(adapter->netdev, "[Critical]nic chip was over-temperature\n");
+		break;
+	default:
+		break;
+	}
+
+err_out:
+	return;
+}
+
+static void xsc_eth_event_handler(void *arg)
+{
+	struct xsc_adapter *adapter = (struct xsc_adapter *)arg;
+
+	queue_work(adapter->workq, &adapter->event_work);
+}
+
+static bool xsc_get_pct_drop_config(struct xsc_core_device *xdev)
+{
+	return (xdev->pdev->device == XSC_MC_PF_DEV_ID) ||
+		(xdev->pdev->device == XSC_MF_SOC_PF_DEV_ID) ||
+		(xdev->pdev->device == XSC_MS_PF_DEV_ID) ||
+		(xdev->pdev->device == XSC_MV_SOC_PF_DEV_ID);
+}
+
+static int xsc_eth_enable_nic_hca(struct xsc_adapter *adapter)
+{
+	struct xsc_cmd_enable_nic_hca_mbox_out out = {};
+	struct xsc_cmd_enable_nic_hca_mbox_in in = {};
+	struct xsc_core_device *xdev = adapter->xdev;
+	struct net_device *netdev = adapter->netdev;
+	u16 caps_mask = 0;
+	u16 caps = 0;
+	int err;
+
+	if (xsc_get_user_mode(xdev))
+		return 0;
+
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_ENABLE_NIC_HCA);
+
+	in.rss.rss_en = 1;
+	in.rss.rqn_base = cpu_to_be16(adapter->channels.rqn_base -
+				xdev->caps.raweth_rss_qp_id_base);
+	in.rss.rqn_num = cpu_to_be16(adapter->channels.num_chl);
+	in.rss.hash_tmpl = cpu_to_be32(adapter->rss_param.rss_hash_tmpl);
+	in.rss.hfunc = xsc_hash_func_type(adapter->rss_param.hfunc);
+	caps_mask |= BIT(XSC_TBM_CAP_RSS);
+
+	if (netdev->features & NETIF_F_RXCSUM)
+		caps |= BIT(XSC_TBM_CAP_HASH_PPH);
+	caps_mask |= BIT(XSC_TBM_CAP_HASH_PPH);
+
+	if (xsc_get_pct_drop_config(xdev) && !(netdev->flags & IFF_SLAVE))
+		caps |= BIT(XSC_TBM_CAP_PCT_DROP_CONFIG);
+	caps_mask |= BIT(XSC_TBM_CAP_PCT_DROP_CONFIG);
+
+	memcpy(in.nic.mac_addr, netdev->dev_addr, ETH_ALEN);
+
+	in.nic.caps = cpu_to_be16(caps);
+	in.nic.caps_mask = cpu_to_be16(caps_mask);
+
+	err = xsc_cmd_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (err || out.hdr.status) {
+		netdev_err(netdev, "failed!! err=%d, status=%d\n",
+			   err, out.hdr.status);
+		return -ENOEXEC;
+	}
+
+	return 0;
+}
+
+static int xsc_eth_disable_nic_hca(struct xsc_adapter *adapter)
 {
+	struct xsc_cmd_disable_nic_hca_mbox_out out = {};
+	struct xsc_cmd_disable_nic_hca_mbox_in in = {};
+	struct xsc_core_device *xdev = adapter->xdev;
+	struct net_device *netdev = adapter->netdev;
+	u16 caps = 0;
+	int err;
+
+	if (xsc_get_user_mode(xdev))
+		return 0;
+
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_DISABLE_NIC_HCA);
+
+	if (xsc_get_pct_drop_config(xdev) &&
+	    !(netdev->priv_flags & IFF_BONDING))
+		caps |= BIT(XSC_TBM_CAP_PCT_DROP_CONFIG);
+
+	in.nic.caps = cpu_to_be16(caps);
+	err = xsc_cmd_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (err || out.hdr.status) {
+		netdev_err(netdev, "failed!! err=%d, status=%d\n",
+			   err, out.hdr.status);
+		return -ENOEXEC;
+	}
+
 	return 0;
 }
 
+static void xsc_set_default_xps_cpumasks(struct xsc_adapter *priv,
+					 struct xsc_eth_params *params)
+{
+	struct xsc_core_device *xdev = priv->xdev;
+	int num_comp_vectors, irq;
+
+	num_comp_vectors = priv->nic_param.comp_vectors;
+	cpumask_clear(xdev->xps_cpumask);
+
+	for (irq = 0; irq < num_comp_vectors; irq++) {
+		cpumask_set_cpu(cpumask_local_spread(irq, xdev->numa_node),
+				xdev->xps_cpumask);
+		netif_set_xps_queue(priv->netdev, xdev->xps_cpumask, irq);
+	}
+}
+
+static int xsc_set_port_admin_status(struct xsc_adapter *adapter,
+				     enum xsc_port_status status)
+{
+	struct xsc_event_set_port_admin_status_mbox_out out;
+	struct xsc_event_set_port_admin_status_mbox_in in;
+	int ret = 0;
+
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_SET_PORT_ADMIN_STATUS);
+	in.status = cpu_to_be16(status);
+
+	ret = xsc_cmd_exec(adapter->xdev, &in, sizeof(in), &out, sizeof(out));
+	if (ret || out.hdr.status) {
+		netdev_err(adapter->netdev, "failed to set port admin status, err=%d, status=%d\n",
+			   ret, out.hdr.status);
+		return -ENOEXEC;
+	}
+
+	return ret;
+}
+
+static int xsc_eth_open(struct net_device *netdev)
+{
+	struct xsc_adapter *adapter = netdev_priv(netdev);
+	struct xsc_core_device *xdev = adapter->xdev;
+	int ret = 0;
+
+	mutex_lock(&adapter->status_lock);
+	if (adapter->status == XSCALE_ETH_DRIVER_OK) {
+		netdev_err(adapter->netdev, "unnormal ndo_open when status=%d\n",
+			   adapter->status);
+		goto out;
+	}
+
+	ret = xsc_eth_sw_init(adapter);
+	if (ret)
+		goto out;
+
+	ret = xsc_eth_enable_nic_hca(adapter);
+	if (ret)
+		goto err_sw_deinit;
+
+	/*INIT_WORK*/
+	INIT_WORK(&adapter->event_work, xsc_eth_event_work);
+	xdev->event_handler = xsc_eth_event_handler;
+
+	if (xsc_eth_get_link_status(adapter))	{
+		netdev_info(netdev, "Link up\n");
+		netif_carrier_on(adapter->netdev);
+	} else {
+		netdev_info(netdev, "Link down\n");
+	}
+
+	adapter->status = XSCALE_ETH_DRIVER_OK;
+
+	xsc_set_default_xps_cpumasks(adapter, &adapter->nic_param);
+
+	xsc_set_port_admin_status(adapter, XSC_PORT_UP);
+
+err_sw_deinit:
+	xsc_eth_sw_deinit(adapter);
+out:
+	mutex_unlock(&adapter->status_lock);
+	return ret;
+}
+
+static int xsc_eth_close(struct net_device *netdev)
+{
+	struct xsc_adapter *adapter = netdev_priv(netdev);
+	int ret = 0;
+
+	mutex_lock(&adapter->status_lock);
+
+	if (!netif_device_present(netdev)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (adapter->status != XSCALE_ETH_DRIVER_OK)
+		goto out;
+
+	adapter->status = XSCALE_ETH_DRIVER_CLOSE;
+
+	netif_carrier_off(adapter->netdev);
+
+	xsc_eth_sw_deinit(adapter);
+
+	ret = xsc_eth_disable_nic_hca(adapter);
+	if (ret)
+		netdev_err(adapter->netdev, "failed to disable nic hca, err=%d\n",
+			   ret);
+
+	xsc_set_port_admin_status(adapter, XSC_PORT_DOWN);
+
+out:
+	mutex_unlock(&adapter->status_lock);
+
+	return ret;
+}
+
 static int xsc_eth_set_hw_mtu(struct xsc_core_device *xdev,
 			      u16 mtu, u16 rx_buf_sz)
 {
@@ -161,7 +1690,8 @@ static int xsc_eth_set_hw_mtu(struct xsc_core_device *xdev,
 }
 
 static const struct net_device_ops xsc_netdev_ops = {
-	/* TBD */
+	.ndo_open		= xsc_eth_open,
+	.ndo_stop		= xsc_eth_close,
 };
 
 static void xsc_eth_build_nic_netdev(struct xsc_adapter *adapter)
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
index f5c1e3ead..d9316615b 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
@@ -9,6 +9,10 @@
 #include "common/xsc_device.h"
 #include "xsc_eth_common.h"
 
+#define XSC_INVALID_LKEY	0x100
+
+#define XSCALE_DRIVER_NAME "xsc_eth"
+
 enum {
 	XSCALE_ETH_DRIVER_INIT,
 	XSCALE_ETH_DRIVER_OK,
@@ -34,7 +38,9 @@ struct xsc_adapter {
 	struct xsc_rss_params	rss_param;
 
 	struct workqueue_struct	*workq;
+	struct work_struct	event_work;
 
+	struct xsc_eth_channels	channels;
 	struct xsc_sq		**txq2sq;
 
 	u32			status;
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
index da17c16ad..e6204d0fa 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
@@ -6,6 +6,7 @@
 #ifndef __XSC_ETH_COMMON_H
 #define __XSC_ETH_COMMON_H
 
+#include "xsc_queue.h"
 #include "xsc_pph.h"
 
 #define SW_MIN_MTU		ETH_MIN_MTU
@@ -21,12 +22,129 @@
 #define XSC_SW2HW_RX_PKT_LEN(mtu)	\
 	((mtu) + ETH_HLEN + XSC_ETH_RX_MAX_HEAD_ROOM)
 
+#define XSC_QPN_SQN_STUB		1025
+#define XSC_QPN_RQN_STUB		1024
+
 #define XSC_LOG_INDIR_RQT_SIZE		0x8
 
 #define XSC_INDIR_RQT_SIZE		BIT(XSC_LOG_INDIR_RQT_SIZE)
 #define XSC_ETH_MIN_NUM_CHANNELS	2
 #define XSC_ETH_MAX_NUM_CHANNELS	XSC_INDIR_RQT_SIZE
 
+#define XSC_TX_NUM_TC			1
+#define XSC_MAX_NUM_TC			8
+#define XSC_ETH_MAX_TC_TOTAL	\
+	(XSC_ETH_MAX_NUM_CHANNELS * XSC_MAX_NUM_TC)
+#define XSC_ETH_MAX_QP_NUM_PER_CH	(XSC_MAX_NUM_TC + 1)
+
+#define XSC_SKB_FRAG_SZ(len)	(SKB_DATA_ALIGN(len) +	\
+				SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+
+#define XSC_RQCQ_ELE_SZ		32
+#define XSC_SQCQ_ELE_SZ		32
+#define XSC_RQ_ELE_SZ		XSC_RECV_WQE_BB
+#define XSC_SQ_ELE_SZ		XSC_SEND_WQE_BB
+#define XSC_EQ_ELE_SZ		8
+
+#define XSC_SKB_FRAG_SZ(len)	(SKB_DATA_ALIGN(len) +	\
+				SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+#define XSC_MIN_SKB_FRAG_SZ	(XSC_SKB_FRAG_SZ(XSC_RX_HEADROOM))
+#define XSC_LOG_MAX_RX_WQE_BULK	\
+	(ilog2(PAGE_SIZE / roundup_pow_of_two(XSC_MIN_SKB_FRAG_SZ)))
+
+#define XSC_MIN_LOG_RQ_SZ		(1 + XSC_LOG_MAX_RX_WQE_BULK)
+#define XSC_DEF_LOG_RQ_SZ		0xa
+#define XSC_MAX_LOG_RQ_SZ		0xd
+
+#define XSC_MIN_LOG_SQ_SZ		0x6
+#define XSC_DEF_LOG_SQ_SZ		0xa
+#define XSC_MAX_LOG_SQ_SZ		0xd
+
+/* DS num */
+#define XSC_SQ_ELE_NUM_DEF	BIT(XSC_DEF_LOG_SQ_SZ)
+#define XSC_RQ_ELE_NUM_DEF	BIT(XSC_DEF_LOG_RQ_SZ)
+
+#define XSC_LOG_RQCQ_SZ		0xb
+#define XSC_LOG_SQCQ_SZ		0xa
+
+#define XSC_RQCQ_ELE_NUM	BIT(XSC_LOG_RQCQ_SZ)
+#define XSC_SQCQ_ELE_NUM	BIT(XSC_LOG_SQCQ_SZ)
+#define XSC_RQ_ELE_NUM		XSC_RQ_ELE_NUM_DEF
+#define XSC_SQ_ELE_NUM		XSC_SQ_ELE_NUM_DEF
+#define XSC_EQ_ELE_NUM		XSC_SQ_ELE_NUM_DEF
+
+enum xsc_port_status {
+	XSC_PORT_DOWN      = 0,
+	XSC_PORT_UP        = 1,
+};
+
+enum xsc_queue_type {
+	XSC_QUEUE_TYPE_EQ = 0,
+	XSC_QUEUE_TYPE_RQCQ,
+	XSC_QUEUE_TYPE_SQCQ,
+	XSC_QUEUE_TYPE_RQ,
+	XSC_QUEUE_TYPE_SQ,
+	XSC_QUEUE_TYPE_MAX,
+};
+
+struct xsc_queue_attr {
+	u8  q_type;
+	u32 ele_num;
+	u32 ele_size;
+	u8  ele_log_size;
+	u8  q_log_size;
+};
+
+struct xsc_eth_rx_wqe_cyc {
+	DECLARE_FLEX_ARRAY(struct xsc_wqe_data_seg, data);
+};
+
+struct xsc_eq_param {
+	struct xsc_queue_attr eq_attr;
+};
+
+struct xsc_cq_param {
+	struct xsc_wq_param wq;
+	struct cq_cmd {
+		u8 abc[16];
+	} cqc;
+	struct xsc_queue_attr cq_attr;
+};
+
+struct xsc_rq_param {
+	struct xsc_wq_param wq;
+	struct xsc_queue_attr rq_attr;
+	struct xsc_rq_frags_info frags_info;
+};
+
+struct xsc_sq_param {
+	struct xsc_wq_param wq;
+	struct xsc_queue_attr sq_attr;
+};
+
+struct xsc_qp_param {
+	struct xsc_queue_attr qp_attr;
+};
+
+struct xsc_channel_param {
+	struct xsc_cq_param rqcq_param;
+	struct xsc_cq_param sqcq_param;
+	struct xsc_rq_param rq_param;
+	struct xsc_sq_param sq_param;
+	struct xsc_qp_param qp_param;
+};
+
+struct xsc_eth_qp {
+	u16 rq_num;
+	u16 sq_num;
+	struct xsc_rq rq[XSC_MAX_NUM_TC]; /*may be use one only*/
+	struct xsc_sq sq[XSC_MAX_NUM_TC]; /*reserved to tc*/
+};
+
+enum channel_flags {
+	XSC_CHANNEL_NAPI_SCHED = 1,
+};
+
 struct xsc_eth_params {
 	u16	num_channels;
 	u16	max_num_ch;
@@ -43,4 +161,28 @@ struct xsc_eth_params {
 	u32	pflags;
 };
 
+struct xsc_channel {
+	/* data path */
+	struct xsc_eth_qp	qp;
+	struct napi_struct	napi;
+	u8			num_tc;
+	int			chl_idx;
+
+	/*relationship*/
+	struct xsc_adapter	*adapter;
+	struct net_device	*netdev;
+	int			cpu;
+	unsigned long		flags;
+
+	/* data path - accessed per napi poll */
+	const struct cpumask	*aff_mask;
+	struct irq_desc		*irq_desc;
+} ____cacheline_aligned_in_smp;
+
+struct xsc_eth_channels {
+	struct xsc_channel	*c;
+	unsigned int		num_chl;
+	u32			rqn_base;
+};
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
new file mode 100644
index 000000000..e8a22f322
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd. All
+ * rights reserved.
+ * Copyright (c) 2015-2016, Mellanox Technologies. All rights reserved.
+ */
+
+#include "xsc_eth_txrx.h"
+
+struct sk_buff *xsc_skb_from_cqe_linear(struct xsc_rq *rq,
+					struct xsc_wqe_frag_info *wi,
+					u32 cqe_bcnt, u8 has_pph)
+{
+	/* TBD */
+	return NULL;
+}
+
+struct sk_buff *xsc_skb_from_cqe_nonlinear(struct xsc_rq *rq,
+					   struct xsc_wqe_frag_info *wi,
+					   u32 cqe_bcnt, u8 has_pph)
+{
+	/* TBD */
+	return NULL;
+}
+
+void xsc_eth_handle_rx_cqe(struct xsc_cqwq *cqwq,
+			   struct xsc_rq *rq, struct xsc_cqe *cqe)
+{
+	/* TBD */
+}
+
+int xsc_poll_rx_cq(struct xsc_cq *cq, int budget)
+{
+	/* TBD */
+	return 0;
+}
+
+void xsc_eth_dealloc_rx_wqe(struct xsc_rq *rq, u16 ix)
+{
+	/* TBD */
+}
+
+bool xsc_eth_post_rx_wqes(struct xsc_rq *rq)
+{
+	/* TBD */
+	return true;
+}
+
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
new file mode 100644
index 000000000..5d1fcb669
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include "xsc_eth_common.h"
+#include "xsc_eth_txrx.h"
+
+void xsc_cq_notify_hw_rearm(struct xsc_cq *cq)
+{
+	u32 db_val = 0;
+
+	db_val |= FIELD_PREP(XSC_CQ_DB_NEXT_CID_MASK, cq->wq.cc) |
+		  FIELD_PREP(XSC_CQ_DB_CQ_ID_MASK, cq->xcq.cqn);
+
+	/* ensure doorbell record is visible to device
+	 * before ringing the doorbell
+	 */
+	wmb();
+	writel(db_val, XSC_REG_ADDR(cq->xdev, cq->xdev->regs.complete_db));
+}
+
+void xsc_cq_notify_hw(struct xsc_cq *cq)
+{
+	struct xsc_core_device *xdev  = cq->xdev;
+	u32 db_val = 0;
+
+	db_val |= FIELD_PREP(XSC_CQ_DB_NEXT_CID_MASK, cq->wq.cc) |
+		  FIELD_PREP(XSC_CQ_DB_CQ_ID_MASK, cq->xcq.cqn);
+
+	/* ensure doorbell record is visible to device
+	 * before ringing the doorbell
+	 */
+	wmb();
+	writel(db_val, XSC_REG_ADDR(xdev, xdev->regs.complete_reg));
+}
+
+static bool xsc_channel_no_affinity_change(struct xsc_channel *c)
+{
+	int current_cpu = smp_processor_id();
+
+	return cpumask_test_cpu(current_cpu, c->aff_mask);
+}
+
+static bool xsc_poll_tx_cq(struct xsc_cq *cq, int napi_budget)
+{
+	/* TBD */
+	return true;
+}
+
+int xsc_eth_napi_poll(struct napi_struct *napi, int budget)
+{
+	struct xsc_channel *c = container_of(napi, struct xsc_channel, napi);
+	struct xsc_eth_params *params = &c->adapter->nic_param;
+	struct xsc_rq *rq = &c->qp.rq[0];
+	struct xsc_sq *sq = NULL;
+	bool busy = false;
+	int work_done = 0;
+	int tx_budget = 0;
+	int i;
+
+	rcu_read_lock();
+
+	clear_bit(XSC_CHANNEL_NAPI_SCHED, &c->flags);
+
+	tx_budget = params->sq_size >> 2;
+	for (i = 0; i < c->num_tc; i++)
+		busy |= xsc_poll_tx_cq(&c->qp.sq[i].cq, tx_budget);
+
+	/* budget=0 means: don't poll rx rings */
+	if (likely(budget)) {
+		work_done = xsc_poll_rx_cq(&rq->cq, budget);
+		busy |= work_done == budget;
+	}
+
+	busy |= rq->post_wqes(rq);
+
+	if (busy) {
+		if (likely(xsc_channel_no_affinity_change(c))) {
+			rcu_read_unlock();
+			return budget;
+		}
+		if (budget && work_done == budget)
+			work_done--;
+	}
+
+	if (unlikely(!napi_complete_done(napi, work_done)))
+		goto err_out;
+
+	for (i = 0; i < c->num_tc; i++) {
+		sq = &c->qp.sq[i];
+		xsc_cq_notify_hw_rearm(&sq->cq);
+	}
+
+	xsc_cq_notify_hw_rearm(&rq->cq);
+err_out:
+	rcu_read_unlock();
+	return work_done;
+}
+
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
new file mode 100644
index 000000000..116019a9a
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __XSC_RXTX_H
+#define __XSC_RXTX_H
+
+#include "xsc_eth.h"
+
+void xsc_cq_notify_hw_rearm(struct xsc_cq *cq);
+void xsc_cq_notify_hw(struct xsc_cq *cq);
+int xsc_eth_napi_poll(struct napi_struct *napi, int budget);
+bool xsc_eth_post_rx_wqes(struct xsc_rq *rq);
+void xsc_eth_handle_rx_cqe(struct xsc_cqwq *cqwq,
+			   struct xsc_rq *rq, struct xsc_cqe *cqe);
+void xsc_eth_dealloc_rx_wqe(struct xsc_rq *rq, u16 ix);
+struct sk_buff *xsc_skb_from_cqe_linear(struct xsc_rq *rq,
+					struct xsc_wqe_frag_info *wi,
+					u32 cqe_bcnt, u8 has_pph);
+struct sk_buff *xsc_skb_from_cqe_nonlinear(struct xsc_rq *rq,
+					   struct xsc_wqe_frag_info *wi,
+					   u32 cqe_bcnt, u8 has_pph);
+int xsc_poll_rx_cq(struct xsc_cq *cq, int budget);
+
+#endif /* XSC_RXTX_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
index 223d4873d..643b2c759 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
@@ -8,7 +8,155 @@
 #ifndef __XSC_QUEUE_H
 #define __XSC_QUEUE_H
 
+#include <net/page_pool/types.h>
+#include <net/page_pool/helpers.h>
+
 #include "common/xsc_core.h"
+#include "xsc_eth_wq.h"
+
+enum {
+	XSC_SEND_WQE_DS	= 16,
+	XSC_SEND_WQE_BB	= 64,
+};
+
+enum {
+	XSC_RECV_WQE_DS	= 16,
+	XSC_RECV_WQE_BB	= 16,
+};
+
+enum {
+	XSC_ETH_RQ_STATE_ENABLED,
+	XSC_ETH_RQ_STATE_AM,
+	XSC_ETH_RQ_STATE_CACHE_REDUCE_PENDING,
+};
+
+#define XSC_SEND_WQEBB_NUM_DS	        (XSC_SEND_WQE_BB / XSC_SEND_WQE_DS)
+#define XSC_LOG_SEND_WQEBB_NUM_DS	ilog2(XSC_SEND_WQEBB_NUM_DS)
+
+#define XSC_RECV_WQEBB_NUM_DS	        (XSC_RECV_WQE_BB / XSC_RECV_WQE_DS)
+#define XSC_LOG_RECV_WQEBB_NUM_DS	ilog2(XSC_RECV_WQEBB_NUM_DS)
+
+/* each ds holds one fragment in skb */
+#define XSC_MAX_RX_FRAGS        4
+#define XSC_RX_FRAG_SZ_ORDER    0
+#define XSC_RX_FRAG_SZ          (PAGE_SIZE << XSC_RX_FRAG_SZ_ORDER)
+#define DEFAULT_FRAG_SIZE       (2048)
+
+enum {
+	XSC_ETH_SQ_STATE_ENABLED,
+	XSC_ETH_SQ_STATE_AM,
+};
+
+struct xsc_dma_info {
+	struct page	*page;
+	dma_addr_t	addr;
+};
+
+struct xsc_page_cache {
+	struct xsc_dma_info	*page_cache;
+	u32	head;
+	u32	tail;
+	u32	sz;
+	u32	resv;
+};
+
+struct xsc_cq {
+	/* data path - accessed per cqe */
+	struct xsc_cqwq	wq;
+
+	/* data path - accessed per napi poll */
+	u16			event_ctr;
+	struct napi_struct	*napi;
+	struct xsc_core_cq	xcq;
+	struct xsc_channel	*channel;
+
+	/* control */
+	struct xsc_core_device	*xdev;
+	struct xsc_wq_ctrl	wq_ctrl;
+	u8			rx;
+} ____cacheline_aligned_in_smp;
+
+struct xsc_wqe_frag_info {
+	struct xsc_dma_info *di;
+	u32 offset;
+	u8 last_in_page;
+	u8 is_available;
+};
+
+struct xsc_rq_frag_info {
+	int frag_size;
+	int frag_stride;
+};
+
+struct xsc_rq_frags_info {
+	struct xsc_rq_frag_info arr[XSC_MAX_RX_FRAGS];
+	u8 num_frags;
+	u8 log_num_frags;
+	u8 wqe_bulk;
+	u8 wqe_bulk_min;
+	u8 frags_max_num;
+};
+
+struct xsc_rq;
+typedef void (*xsc_fp_handle_rx_cqe)(struct xsc_cqwq *cqwq, struct xsc_rq *rq,
+				     struct xsc_cqe *cqe);
+typedef bool (*xsc_fp_post_rx_wqes)(struct xsc_rq *rq);
+typedef void (*xsc_fp_dealloc_wqe)(struct xsc_rq *rq, u16 ix);
+typedef struct sk_buff * (*xsc_fp_skb_from_cqe)(struct xsc_rq *rq,
+						struct xsc_wqe_frag_info *wi,
+						u32 cqe_bcnt,
+						u8 has_pph);
+
+struct xsc_rq {
+	struct xsc_core_qp		cqp;
+	struct {
+		struct xsc_wq_cyc	wq;
+		struct xsc_wqe_frag_info	*frags;
+		struct xsc_dma_info	*di;
+		struct xsc_rq_frags_info	info;
+		xsc_fp_skb_from_cqe	skb_from_cqe;
+	} wqe;
+
+	struct {
+		u16	headroom;
+		u8	map_dir;	/* dma map direction */
+	} buff;
+
+	struct page_pool	*page_pool;
+	struct xsc_wq_ctrl	wq_ctrl;
+	struct xsc_cq		cq;
+	u32	rqn;
+	int	ix;
+
+	unsigned long	state;
+	struct work_struct  recover_work;
+
+	u32 hw_mtu;
+	u32 frags_sz;
+
+	xsc_fp_handle_rx_cqe	handle_rx_cqe;
+	xsc_fp_post_rx_wqes	post_wqes;
+	xsc_fp_dealloc_wqe	dealloc_wqe;
+	struct xsc_page_cache	page_cache;
+} ____cacheline_aligned_in_smp;
+
+enum xsc_dma_map_type {
+	XSC_DMA_MAP_SINGLE,
+	XSC_DMA_MAP_PAGE
+};
+
+struct xsc_sq_dma {
+	dma_addr_t	addr;
+	u32		size;
+	enum xsc_dma_map_type	type;
+};
+
+struct xsc_tx_wqe_info {
+	struct sk_buff *skb;
+	u32 num_bytes;
+	u8  num_wqebbs;
+	u8  num_dma;
+};
 
 struct xsc_sq {
 	struct xsc_core_qp		cqp;
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
index ad0ecc122..e8c13c6fd 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
@@ -6,5 +6,5 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
 
-xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o pci_irq.o adev.o
+xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o pci_irq.o adev.o vport.o
 
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/vport.c b/drivers/net/ethernet/yunsilicon/xsc/pci/vport.c
new file mode 100644
index 000000000..edac8a6bd
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/vport.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021 - 2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include "common/xsc_core.h"
+#include "common/xsc_driver.h"
+
+u8 xsc_core_query_vport_state(struct xsc_core_device *xdev, u16 vport)
+{
+	struct xsc_query_vport_state_out out;
+	struct xsc_query_vport_state_in in;
+	u32 val = 0;
+	int err;
+
+	memset(&in, 0, sizeof(in));
+	memset(&out, 0, sizeof(out));
+
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_QUERY_VPORT_STATE);
+	val |= FIELD_PREP(XSC_QUERY_VPORT_VPORT_NUM_MASK, vport);
+	if (vport)
+		val |= XSC_QUERY_VPORT_OTHER_VPORT;
+	in.data0 = cpu_to_be32(val);
+
+	err = xsc_cmd_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (err || out.hdr.status)
+		pci_err(xdev->pdev, "failed to query vport state, err=%d, status=%d\n",
+			err, out.hdr.status);
+
+	return out.state;
+}
+EXPORT_SYMBOL(xsc_core_query_vport_state);
-- 
2.43.0

