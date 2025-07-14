Return-Path: <netdev+bounces-206552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7564DB03703
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 08:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBEA03A28D2
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 06:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB1D21858E;
	Mon, 14 Jul 2025 06:25:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F891C84AB;
	Mon, 14 Jul 2025 06:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752474356; cv=none; b=e3PjNgsEjhgv+Y2GktDgx3+JOfxKtlpYLDyYO9hc4D7HQM6eq2Sw8Z1GxuAOpELPWra9GQp9pmVlWMR76gwJK/i+7koLVU9LviW7wzMit5faFicB1et/PcHiVcFURekhqFS5aLzve/RhK822iSfKN2jXLNTlXzd/jOohi+E+eTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752474356; c=relaxed/simple;
	bh=7fpgvIb3/yB+NIgIEr1c+qTfONw8X6Xi1PcrpcB7zco=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VQ0yb6EjNKPBHl8mbGRAmGXmjTaRyjIx5svcYWuvuhan2o+Efek0Hh5gbRZF/fscRiDrpsZfUvDLJaqo5Hrv8prw0zzSA/GX5rf07QR5Je9FB84OyoyfhWd0kgq9V9QbK2p5RB/DfCEXD88HkMbdIVb4ESgeY7S3jxxC9/6haL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 14 Jul
 2025 14:25:44 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 14 Jul 2025 14:25:44 +0800
From: aspeedyh <yh_chung@aspeedtech.com>
To: <jk@codeconstruct.com.au>, <matt@codeconstruct.com.au>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <bmc-sw@aspeedtech.com>
Subject: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
Date: Mon, 14 Jul 2025 14:25:44 +0800
Message-ID: <20250714062544.2612693-1-yh_chung@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add an implementation for DMTF DSP0238 MCTP PCIe VDM transport spec.

Introduce struct mctp_pcie_vdm_dev to represent each PCIe VDM
interface and its send/receive operations.  Register a
net_device with the MCTP core so packets traverse the standard
networking socket API.

Because there is no generic PCIe VDM bus framework in-tree, this
driver provides a transport interface for lower layers to
implement vendor-specific read/write callbacks.

TX path uses a dedicated kernel thread and ptr_ring: skbs queued by the
MCTP stack are enqueued on the ring and processed in-thread context.

RX path employs a workqueue; the lower layer notifies availability, and
the work handler drains packets until the receive callback returns an
ERR_PTR, avoiding per-packet notifications.

Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
---
 drivers/net/mctp/Kconfig         |  10 +
 drivers/net/mctp/Makefile        |   1 +
 drivers/net/mctp/mctp-pcie-vdm.c | 673 +++++++++++++++++++++++++++++++
 include/linux/mctp-pcie-vdm.h    |  42 ++
 4 files changed, 726 insertions(+)
 create mode 100644 drivers/net/mctp/mctp-pcie-vdm.c
 create mode 100644 include/linux/mctp-pcie-vdm.h

diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index cf325ab0b1ef..3355613bb04b 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -57,6 +57,16 @@ config MCTP_TRANSPORT_USB
 	  MCTP-over-USB interfaces are peer-to-peer, so each interface
 	  represents a physical connection to one remote MCTP endpoint.
 
+config MCTP_TRANSPORT_PCIE_VDM
+	tristate "MCTP PCIe VDM transport"
+	depends on PCI
+	select MCTP_FLOWS
+	help
+	  Provides a driver to access MCTP devices over PCIe VDM transport,
+	  from DMTF specification DSP0238.
+	  A MCTP protocol network device is created for each PCIe VDM device
+	  that registers to this driver.
+
 endmenu
 
 endif
diff --git a/drivers/net/mctp/Makefile b/drivers/net/mctp/Makefile
index c36006849a1e..4acd04d7eb32 100644
--- a/drivers/net/mctp/Makefile
+++ b/drivers/net/mctp/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_MCTP_SERIAL) += mctp-serial.o
 obj-$(CONFIG_MCTP_TRANSPORT_I2C) += mctp-i2c.o
 obj-$(CONFIG_MCTP_TRANSPORT_I3C) += mctp-i3c.o
 obj-$(CONFIG_MCTP_TRANSPORT_USB) += mctp-usb.o
+obj-$(CONFIG_MCTP_TRANSPORT_PCIE_VDM) += mctp-pcie-vdm.o
diff --git a/drivers/net/mctp/mctp-pcie-vdm.c b/drivers/net/mctp/mctp-pcie-vdm.c
new file mode 100644
index 000000000000..7ac4d3f55992
--- /dev/null
+++ b/drivers/net/mctp/mctp-pcie-vdm.c
@@ -0,0 +1,673 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-pcie-vdm.c - MCTP-over-PCIe-VDM (DMTF DSP0238) transport binding driver.
+ *
+ * DSP0238 is available at:
+ * https://www.dmtf.org/sites/default/files/standards/documents/DSP0238_1.2.0.pdf
+ *
+ */
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/byteorder/generic.h>
+#include <linux/dynamic_debug.h>
+#include <linux/fs.h>
+#include <linux/hashtable.h>
+#include <linux/if_arp.h>
+#include <linux/if_ether.h>
+#include <linux/kthread.h>
+#include <linux/list.h>
+#include <linux/mctp-pcie-vdm.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/netdevice.h>
+#include <linux/notifier.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/ptr_ring.h>
+#include <linux/skbuff.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+
+#define MCTP_PCIE_VDM_MIN_MTU 64
+#define MCTP_PCIE_VDM_MAX_MTU 512
+/* 16byte */
+#define MCTP_PCIE_VDM_HDR_SIZE 16
+#define MCTP_PAYLOAD_IC_TYPE_SIZE 1
+#define MCTP_RECEIVE_PKT_TIMEOUT_MS 5
+
+#define MCTP_PCIE_VDM_NET_DEV_TX_QUEUE_LEN 1100
+#define MCTP_PCIE_VDM_DEV_TX_QUEUE_SIZE 64
+
+#define MCTP_PCIE_VDM_FMT_4DW 0x3
+#define MCTP_PCIE_VDM_TYPE_MSG 0x10
+#define MCTP_PCIE_VDM_CODE 0x0
+/* PCIe VDM message code */
+#define MCTP_PCIE_VDM_MSG_CODE 0x7F
+#define MCTP_PCIE_VDM_VENDOR_ID 0x1AB4
+/* MCTP message type */
+#define MCTP_MSG_TYPE_MASK GENMASK(6, 0)
+#define MCTP_PCIE_VDM_MSG_TYPE 0x7E
+#define MCTP_CONTROL_MSG_TYPE 0x00
+
+#define MCTP_CTRL_MSG_RQDI_REQ 0x80
+#define MCTP_CTRL_MSG_RQDI_RSP 0x00
+
+#define MCTP_CTRL_MSG_RQDI_REQ_DATA_OFFSET 3
+#define MCTP_CTRL_MSG_RQDI_RSP_DATA_OFFSET 4
+
+#define MCTP_PCIE_SWAP_NET_ENDIAN(arr, len)       \
+	do {                                      \
+		u32 *p = (u32 *)(arr);            \
+		for (int i = 0; i < (len); i++) { \
+			p[i] = htonl(p[i]);       \
+		}                                 \
+	} while (0)
+
+#define MCTP_PCIE_SWAP_LITTLE_ENDIAN(arr, len)      \
+	do {                                      \
+		u32 *p = (u32 *)(arr);            \
+		for (int i = 0; i < (len); i++) { \
+			p[i] = ntohl(p[i]);       \
+			p[i] = cpu_to_le32(p[i]); \
+		}                                 \
+	} while (0)
+
+enum mctp_pcie_vdm_route_type {
+	MCTP_PCIE_VDM_ROUTE_TO_RC = 0,
+	MCTP_PCIE_VDM_ROUTE_BY_ID = 2,
+	MCTP_PCIE_VDM_BROADCAST_FROM_RC = 3,
+};
+
+enum mctp_ctrl_command_code {
+	MCTP_CTRL_CMD_SET_ENDPOINT_ID = 0x01,
+	MCTP_CTRL_CMD_GET_ENDPOINT_ID = 0x02,
+	MCTP_CTRL_CMD_PREPARE_ENDPOINT_DISCOVERY = 0x0B,
+	MCTP_CTRL_CMD_ENDPOINT_DISCOVERY = 0x0C,
+	MCTP_CTRL_CMD_DISCOVERY_NOTIFY = 0x0D
+};
+
+struct mctp_ctrl_msg_hdr {
+	u8 ctrl_msg_class;
+	u8 command_code;
+};
+
+struct mctp_pcie_vdm_hdr {
+	u32 length : 10, rsvd0 : 2, attr : 2, ep : 1, td : 1, rsvd1 : 4, tc : 3,
+		rsvd2 : 1, route_type : 5, fmt : 2, rsvd3 : 1;
+	u8 msg_code;
+	u8 tag_vdm_code : 4, tag_pad_len : 2, tag_rsvd : 2;
+	u16 pci_req_id;
+	u16 pci_vendor_id;
+	u16 pci_target_id;
+};
+
+struct mctp_pcie_vdm_route_info {
+	u8 eid;
+	u8 dirty;
+	u16 bdf_addr;
+	struct hlist_node hnode;
+};
+
+struct mctp_pcie_vdm_dev {
+	struct device *dev;
+	struct net_device *ndev;
+	struct task_struct *tx_thread;
+	wait_queue_head_t tx_wait;
+	struct work_struct rx_work;
+	struct ptr_ring tx_queue;
+	struct list_head list;
+	/* each network may have at most 256 EIDs */
+	DECLARE_HASHTABLE(route_table, 8);
+	const struct mctp_pcie_vdm_ops *callback_ops;
+};
+
+/* mutex for vdm_devs add/delete */
+DEFINE_MUTEX(mctp_pcie_vdm_dev_mutex);
+LIST_HEAD(mctp_pcie_vdm_devs);
+struct workqueue_struct *mctp_pcie_vdm_wq;
+
+static const struct mctp_pcie_vdm_hdr mctp_pcie_vdm_hdr_template = {
+	.fmt = MCTP_PCIE_VDM_FMT_4DW,
+	.route_type = MCTP_PCIE_VDM_TYPE_MSG | MCTP_PCIE_VDM_ROUTE_BY_ID,
+	.tag_vdm_code = MCTP_PCIE_VDM_CODE,
+	.msg_code = MCTP_PCIE_VDM_MSG_CODE,
+	.pci_vendor_id = MCTP_PCIE_VDM_VENDOR_ID,
+	.attr = 0,
+};
+
+static void mctp_pcie_vdm_display_skb_buff_data(struct sk_buff *skb)
+{
+	int i = 0;
+
+	while ((i + 4) < skb->len) {
+		pr_debug("%02x %02x %02x %02x\n", skb->data[i],
+			 skb->data[i + 1], skb->data[i + 2], skb->data[i + 3]);
+		i += 4;
+	}
+
+	char buf[16] = { 0 };
+	char *p = buf;
+
+	while (i < skb->len) {
+		p += snprintf(p, sizeof(buf) - (p - buf), "%02x ",
+			      skb->data[i]);
+		i++;
+	}
+	pr_debug("%s\n", buf);
+}
+
+static void mctp_pcie_vdm_update_route_table(struct mctp_pcie_vdm_dev *vdm_dev,
+					     u8 eid, u16 bdf)
+{
+	if (eid == 0x00 || eid == 0xFF)
+		return;
+
+	bool exist = false;
+	struct mctp_pcie_vdm_route_info *route;
+
+	hash_for_each_possible(vdm_dev->route_table, route, hnode, eid) {
+		pr_debug("%s: route table eid %d maps to %d", __func__,
+			 route->eid, route->bdf_addr);
+		if (route->eid == eid) {
+			exist = true;
+			route->bdf_addr = bdf;
+			break;
+		}
+	}
+
+	if (!exist) {
+		route = kmalloc(sizeof(*route), GFP_KERNEL);
+		route->bdf_addr = bdf;
+		route->eid = eid;
+		route->dirty = 0;
+
+		hash_add(vdm_dev->route_table, &route->hnode, route->eid);
+		pr_debug("%s: not found, add map eid %d to bdf 0x%x", __func__,
+			 eid, bdf);
+	}
+}
+
+static void mctp_pcie_vdm_ctrl_msg_handler(struct mctp_pcie_vdm_dev *vdm_dev,
+					   u8 *packet)
+{
+	u8 message_type =
+		FIELD_GET(MCTP_MSG_TYPE_MASK, packet[MCTP_PCIE_VDM_HDR_SIZE]);
+
+	if (message_type != MCTP_CONTROL_MSG_TYPE)
+		return;
+
+	struct mctp_ctrl_msg_hdr *ctrl_hdr =
+		(struct mctp_ctrl_msg_hdr *)(&packet[MCTP_PCIE_VDM_HDR_SIZE + 1]);
+
+	/* host endian expected */
+	struct mctp_pcie_vdm_hdr *hdr = (struct mctp_pcie_vdm_hdr *)packet;
+
+	switch (ctrl_hdr->command_code) {
+	case MCTP_CTRL_CMD_SET_ENDPOINT_ID:
+		if (ctrl_hdr->ctrl_msg_class == MCTP_CTRL_MSG_RQDI_REQ) {
+			/* EID placed at byte2 of SET EID REQ DATA */
+			u8 dst_eid =
+				packet[MCTP_PCIE_VDM_HDR_SIZE +
+				       MCTP_CTRL_MSG_RQDI_REQ_DATA_OFFSET + 1];
+			u16 dst_bdf = hdr->pci_target_id;
+
+			mctp_pcie_vdm_update_route_table(vdm_dev, dst_eid,
+							 dst_bdf);
+		}
+		break;
+	case MCTP_CTRL_CMD_GET_ENDPOINT_ID:
+		if (ctrl_hdr->ctrl_msg_class == MCTP_CTRL_MSG_RQDI_RSP) {
+			/* EID placed at byte2 of GET EID RSP DATA */
+			u8 target_eid =
+				packet[MCTP_PCIE_VDM_HDR_SIZE +
+				       MCTP_CTRL_MSG_RQDI_RSP_DATA_OFFSET + 1];
+			u16 src_bdf = hdr->pci_req_id;
+
+			mctp_pcie_vdm_update_route_table(vdm_dev, target_eid,
+							 src_bdf);
+		}
+		break;
+	case MCTP_CTRL_CMD_DISCOVERY_NOTIFY:
+		hdr->pci_target_id = 0x0000;
+		/* default use MCTP_PCIE_VDM_ROUTE_BY_ID, so no need to handle RSP class */
+		if (ctrl_hdr->ctrl_msg_class == MCTP_CTRL_MSG_RQDI_REQ) {
+			hdr->route_type = MCTP_PCIE_VDM_TYPE_MSG |
+					  MCTP_PCIE_VDM_ROUTE_TO_RC;
+		}
+		break;
+	case MCTP_CTRL_CMD_PREPARE_ENDPOINT_DISCOVERY:
+	case MCTP_CTRL_CMD_ENDPOINT_DISCOVERY:
+		if (ctrl_hdr->ctrl_msg_class == MCTP_CTRL_MSG_RQDI_REQ) {
+			hdr->route_type = MCTP_PCIE_VDM_TYPE_MSG |
+					  MCTP_PCIE_VDM_BROADCAST_FROM_RC;
+			hdr->pci_target_id = 0xFFFF;
+		} else if (ctrl_hdr->ctrl_msg_class == MCTP_CTRL_MSG_RQDI_RSP) {
+			hdr->route_type = MCTP_PCIE_VDM_TYPE_MSG |
+					  MCTP_PCIE_VDM_ROUTE_TO_RC;
+		}
+		break;
+	default:
+		/* Unknown command code or not supported currently */
+		break;
+	}
+}
+
+static netdev_tx_t mctp_pcie_vdm_start_xmit(struct sk_buff *skb,
+					    struct net_device *ndev)
+{
+	struct mctp_pcie_vdm_dev *vdm_dev = netdev_priv(ndev);
+
+	pr_debug("%s: skb len %u\n", __func__, skb->len);
+
+	netdev_tx_t ret;
+
+	if (ptr_ring_full(&vdm_dev->tx_queue)) {
+		pr_debug("%s: failed to send packet, buffer full\n", __func__);
+		netif_stop_queue(ndev);
+
+		ret = NETDEV_TX_BUSY;
+	} else {
+		int reason = ptr_ring_produce_bh(&vdm_dev->tx_queue, skb);
+
+		if (reason) {
+			pr_err("%s: failed to produce skb to tx queue, reason %d\n",
+			       __func__, reason);
+			ret = NETDEV_TX_BUSY;
+		} else {
+			ret = NETDEV_TX_OK;
+		}
+	}
+
+	wake_up(&vdm_dev->tx_wait);
+
+	return ret;
+}
+
+static void mctp_pcie_vdm_xmit(struct mctp_pcie_vdm_dev *vdm_dev,
+			       struct sk_buff *skb)
+{
+	struct net_device_stats *stats;
+	struct mctp_pcie_vdm_hdr *hdr;
+	u8 *hdr_byte;
+	u8 message_type;
+	u16 payload_len_dw;
+	u16 payload_len_byte;
+	int rc;
+
+	stats = &vdm_dev->ndev->stats;
+	hdr = (struct mctp_pcie_vdm_hdr *)skb->data;
+	hdr_byte = skb->data;
+	payload_len_dw = (ALIGN(skb->len, sizeof(u32)) - MCTP_PCIE_VDM_HDR_SIZE) / sizeof(u32);
+	payload_len_byte = skb->len - MCTP_PCIE_VDM_HDR_SIZE;
+	message_type = FIELD_GET(MCTP_MSG_TYPE_MASK, hdr_byte[MCTP_PCIE_VDM_HDR_SIZE]);
+
+	if (message_type == MCTP_CONTROL_MSG_TYPE) {
+		mctp_pcie_vdm_ctrl_msg_handler(vdm_dev, hdr_byte);
+	} else {
+		if (hdr->route_type ==
+		    (MCTP_PCIE_VDM_TYPE_MSG | MCTP_PCIE_VDM_ROUTE_BY_ID)) {
+			struct mctp_pcie_vdm_route_info *route;
+			bool exist = false;
+			u16 bdf = 0x00;
+			u8 dst_eid =
+				FIELD_GET(GENMASK(15, 8),
+					  *((u32 *)skb->data +
+					    sizeof(struct mctp_pcie_vdm_hdr) /
+						    sizeof(u32)));
+
+			hash_for_each_possible(vdm_dev->route_table, route,
+					       hnode, dst_eid) {
+				if (route->eid == dst_eid) {
+					exist = true;
+					bdf = route->bdf_addr;
+					hdr->pci_target_id = bdf;
+					break;
+				}
+			}
+			if (exist)
+				pr_debug("%s fill bdf 0x%x to eid %d", __func__,
+					 bdf, dst_eid);
+		}
+	}
+
+	hdr->length = payload_len_dw;
+	hdr->tag_pad_len =
+		ALIGN(payload_len_byte, sizeof(u32)) - payload_len_byte;
+	pr_debug("%s: skb len %d pad len %d\n", __func__, skb->len,
+		 hdr->tag_pad_len);
+	MCTP_PCIE_SWAP_NET_ENDIAN((u32 *)hdr,
+				  sizeof(struct mctp_pcie_vdm_hdr) / sizeof(u32));
+
+	mctp_pcie_vdm_display_skb_buff_data(skb);
+	rc = vdm_dev->callback_ops->send_packet(vdm_dev->dev, skb->data,
+								payload_len_dw * sizeof(u32));
+
+	if (rc) {
+		pr_err("%s: failed to send packet, rc %d\n", __func__, rc);
+		stats->tx_errors++;
+		return;
+	}
+	stats->tx_packets++;
+	stats->tx_bytes += (skb->len - sizeof(struct mctp_pcie_vdm_hdr));
+}
+
+static int mctp_pcie_vdm_tx_thread(void *data)
+{
+	struct mctp_pcie_vdm_dev *vdm_dev = data;
+
+	for (;;) {
+		wait_event_idle(vdm_dev->tx_wait,
+				__ptr_ring_peek(&vdm_dev->tx_queue) ||
+					kthread_should_stop());
+
+		if (kthread_should_stop())
+			break;
+
+		while (__ptr_ring_peek(&vdm_dev->tx_queue)) {
+			struct sk_buff *skb;
+
+			skb = ptr_ring_consume(&vdm_dev->tx_queue);
+
+			if (skb) {
+				mctp_pcie_vdm_xmit(vdm_dev, skb);
+				kfree_skb(skb);
+			}
+		}
+		if (netif_queue_stopped(vdm_dev->ndev))
+			netif_wake_queue(vdm_dev->ndev);
+	}
+
+	pr_debug("%s stopping\n", __func__);
+	return 0;
+}
+
+static void mctp_pcie_vdm_rx_work_handler(struct work_struct *work)
+{
+	struct mctp_pcie_vdm_dev *vdm_dev;
+	u8 *packet;
+
+	vdm_dev = container_of(work, struct mctp_pcie_vdm_dev, rx_work);
+	packet = vdm_dev->callback_ops->recv_packet(vdm_dev->dev);
+
+	while (!IS_ERR(packet)) {
+		MCTP_PCIE_SWAP_LITTLE_ENDIAN((u32 *)packet,
+					     sizeof(struct mctp_pcie_vdm_hdr) / sizeof(u32));
+		struct mctp_pcie_vdm_hdr *vdm_hdr = (struct mctp_pcie_vdm_hdr *)packet;
+		struct mctp_skb_cb *cb;
+		struct net_device_stats *stats;
+		struct sk_buff *skb;
+		u16 len;
+		int net_status;
+
+		stats = &vdm_dev->ndev->stats;
+		len = vdm_hdr->length * sizeof(u32) -
+				vdm_hdr->tag_pad_len;
+		len += MCTP_PCIE_VDM_HDR_SIZE;
+		skb = netdev_alloc_skb(vdm_dev->ndev, len);
+		pr_debug("%s: received packet size: %d\n", __func__,
+			 len);
+
+		if (!skb) {
+			stats->rx_errors++;
+			pr_err("%s: failed to alloc skb\n", __func__);
+			continue;
+		}
+
+		skb->protocol = htons(ETH_P_MCTP);
+		/* put data into tail sk buff */
+		skb_put_data(skb, packet, len);
+		/* remove first 12bytes PCIe VDM header */
+		skb_pull(skb, sizeof(struct mctp_pcie_vdm_hdr));
+		mctp_pcie_vdm_display_skb_buff_data(skb);
+
+		cb = __mctp_cb(skb);
+		cb->halen = 2; // BDF size is 2 bytes
+		memcpy(cb->haddr, &vdm_hdr->pci_req_id, cb->halen);
+
+		net_status = netif_rx(skb);
+		if (net_status == NET_RX_SUCCESS) {
+			stats->rx_packets++;
+			stats->rx_bytes += skb->len;
+		} else {
+			stats->rx_dropped++;
+		}
+
+		mctp_pcie_vdm_ctrl_msg_handler(vdm_dev, packet);
+
+		if (vdm_hdr->route_type ==
+			(MCTP_PCIE_VDM_TYPE_MSG |
+				MCTP_PCIE_VDM_ROUTE_BY_ID)) {
+			u32 mctp_hdr;
+			u16 bdf;
+			u8 src_eid;
+
+			bdf = vdm_hdr->pci_req_id;
+			mctp_hdr = *((u32 *)packet +
+				     sizeof(struct mctp_pcie_vdm_hdr) /
+					     sizeof(u32));
+			MCTP_PCIE_SWAP_LITTLE_ENDIAN(&mctp_hdr, 1);
+			src_eid = FIELD_GET(GENMASK(15, 8), mctp_hdr);
+
+			mctp_pcie_vdm_update_route_table(vdm_dev,
+							 src_eid, bdf);
+		}
+
+		vdm_dev->callback_ops->free_packet(packet);
+		packet = vdm_dev->callback_ops->recv_packet(vdm_dev->dev);
+	}
+}
+
+static int mctp_pcie_vdm_add_mctp_dev(struct mctp_pcie_vdm_dev *vdm_dev)
+{
+	hash_init(vdm_dev->route_table);
+	INIT_LIST_HEAD(&vdm_dev->list);
+	init_waitqueue_head(&vdm_dev->tx_wait);
+	ptr_ring_init(&vdm_dev->tx_queue, MCTP_PCIE_VDM_DEV_TX_QUEUE_SIZE,
+		      GFP_KERNEL);
+	vdm_dev->tx_thread = kthread_run(mctp_pcie_vdm_tx_thread, vdm_dev,
+					 "mctp_pcie_vdm_tx_thread");
+	INIT_WORK(&vdm_dev->rx_work, mctp_pcie_vdm_rx_work_handler);
+
+	mutex_lock(&mctp_pcie_vdm_dev_mutex);
+	list_add_tail(&vdm_dev->list, &mctp_pcie_vdm_devs);
+	mutex_unlock(&mctp_pcie_vdm_dev_mutex);
+	return 0;
+}
+
+static void mctp_pcie_vdm_uninit(struct net_device *ndev)
+{
+	struct mctp_pcie_vdm_dev *vdm_dev;
+
+	struct mctp_pcie_vdm_route_info *route;
+	struct hlist_node *tmp;
+	int bkt;
+
+	pr_debug("%s: uninitializing vdm_dev %s\n", __func__,
+		 vdm_dev->ndev->name);
+
+	vdm_dev = netdev_priv(ndev);
+	vdm_dev->callback_ops->uninit(vdm_dev->dev);
+
+	hash_for_each_safe(vdm_dev->route_table, bkt, tmp, route, hnode) {
+		hash_del(&route->hnode);
+		kfree(route);
+	}
+
+	if (vdm_dev->tx_thread) {
+		kthread_stop(vdm_dev->tx_thread);
+		vdm_dev->tx_thread = NULL;
+	}
+
+	if (mctp_pcie_vdm_wq) {
+		cancel_work_sync(&vdm_dev->rx_work);
+		flush_workqueue(mctp_pcie_vdm_wq);
+		destroy_workqueue(mctp_pcie_vdm_wq);
+		mctp_pcie_vdm_wq = NULL;
+	}
+
+	while (__ptr_ring_peek(&vdm_dev->tx_queue)) {
+		struct sk_buff *skb;
+
+		skb = ptr_ring_consume(&vdm_dev->tx_queue);
+
+		if (skb)
+			kfree_skb(skb);
+	}
+
+	mutex_lock(&mctp_pcie_vdm_dev_mutex);
+	list_del(&vdm_dev->list);
+	mutex_unlock(&mctp_pcie_vdm_dev_mutex);
+}
+
+static int mctp_pcie_vdm_hdr_create(struct sk_buff *skb,
+				    struct net_device *ndev,
+				    unsigned short type, const void *daddr,
+				    const void *saddr, unsigned int len)
+{
+	struct mctp_pcie_vdm_hdr *hdr =
+		(struct mctp_pcie_vdm_hdr *)skb_push(skb, sizeof(*hdr));
+
+	pr_debug("%s type %d len %d\n", __func__, type, len);
+	memcpy(hdr, &mctp_pcie_vdm_hdr_template, sizeof(*hdr));
+	if (daddr) {
+		pr_debug("%s dst addr %d\n", __func__, *(u16 *)daddr);
+		hdr->pci_target_id = *(u16 *)daddr;
+	}
+
+	if (saddr) {
+		pr_debug("%s src addr %d\n", __func__, *(u16 *)saddr);
+		hdr->pci_req_id = *(u16 *)saddr;
+	}
+
+	return 0;
+}
+
+static const struct net_device_ops mctp_pcie_vdm_net_ops = {
+	.ndo_start_xmit = mctp_pcie_vdm_start_xmit,
+	.ndo_uninit = mctp_pcie_vdm_uninit,
+};
+
+static const struct header_ops mctp_pcie_vdm_net_hdr_ops = {
+	.create = mctp_pcie_vdm_hdr_create,
+};
+
+static void mctp_pcie_vdm_net_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+
+	ndev->mtu = MCTP_PCIE_VDM_MIN_MTU;
+	ndev->min_mtu = MCTP_PCIE_VDM_MIN_MTU;
+	ndev->max_mtu = MCTP_PCIE_VDM_MAX_MTU;
+	ndev->tx_queue_len = MCTP_PCIE_VDM_NET_DEV_TX_QUEUE_LEN;
+	ndev->addr_len = 2; //PCIe bdf is 2 bytes
+	ndev->hard_header_len = sizeof(struct mctp_pcie_vdm_hdr);
+
+	ndev->netdev_ops = &mctp_pcie_vdm_net_ops;
+	ndev->header_ops = &mctp_pcie_vdm_net_hdr_ops;
+}
+
+static int mctp_pcie_vdm_add_net_dev(struct net_device **dev)
+{
+	struct net_device *ndev = alloc_netdev(sizeof(struct mctp_pcie_vdm_dev),
+					       "mctppci%d", NET_NAME_UNKNOWN,
+					       mctp_pcie_vdm_net_setup);
+
+	if (!ndev) {
+		pr_err("%s: failed to allocate net device\n", __func__);
+		return -ENOMEM;
+	}
+	dev_net_set(ndev, current->nsproxy->net_ns);
+
+	*dev = ndev;
+	int rc;
+
+	rc = mctp_register_netdev(ndev, NULL, MCTP_PHYS_BINDING_PCIE_VDM);
+	if (rc) {
+		pr_err("%s: failed to register net device\n", __func__);
+		free_netdev(ndev);
+		return rc;
+	}
+	return rc;
+}
+
+struct mctp_pcie_vdm_dev *mctp_pcie_vdm_add_dev(struct device *dev,
+						const struct mctp_pcie_vdm_ops *ops)
+{
+	struct net_device *ndev;
+	int rc;
+
+	rc = mctp_pcie_vdm_add_net_dev(&ndev);
+	if (rc) {
+		pr_err("%s: failed to add net device\n", __func__);
+		return ERR_PTR(rc);
+	}
+
+	struct mctp_pcie_vdm_dev *vdm_dev;
+
+	vdm_dev = netdev_priv(ndev);
+	vdm_dev->ndev = ndev;
+	vdm_dev->dev = dev;
+	vdm_dev->callback_ops = ops;
+
+	rc = mctp_pcie_vdm_add_mctp_dev(vdm_dev);
+	if (rc) {
+		pr_err("%s: failed to add mctp device\n", __func__);
+		unregister_netdev(ndev);
+		free_netdev(ndev);
+		return ERR_PTR(rc);
+	}
+	return vdm_dev;
+}
+EXPORT_SYMBOL_GPL(mctp_pcie_vdm_add_dev);
+
+void mctp_pcie_vdm_remove_dev(struct mctp_pcie_vdm_dev *vdm_dev)
+{
+	pr_debug("%s: removing vdm_dev %s\n", __func__, vdm_dev->ndev->name);
+	struct net_device *ndev = vdm_dev->ndev;
+
+	if (ndev) {
+		// objects in vdm_dev will be released in net_dev uninit operator
+		mctp_unregister_netdev(ndev);
+		free_netdev(ndev);
+	}
+}
+EXPORT_SYMBOL_GPL(mctp_pcie_vdm_remove_dev);
+
+void mctp_pcie_vdm_notify_rx(struct mctp_pcie_vdm_dev *vdm_dev)
+{
+	queue_work(mctp_pcie_vdm_wq, &vdm_dev->rx_work);
+}
+EXPORT_SYMBOL_GPL(mctp_pcie_vdm_notify_rx);
+
+static __init int mctp_pcie_vdm_mod_init(void)
+{
+	mctp_pcie_vdm_wq = alloc_workqueue("mctp_pcie_vdm_wq", WQ_UNBOUND, 1);
+	if (!mctp_pcie_vdm_wq) {
+		pr_err("Failed to create mctp pcie vdm workqueue\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static __exit void mctp_pcie_vdm_mod_exit(void)
+{
+	struct mctp_pcie_vdm_dev *vdm_dev;
+	struct mctp_pcie_vdm_dev *tmp;
+
+	list_for_each_entry_safe(vdm_dev, tmp, &mctp_pcie_vdm_devs, list) {
+		mctp_pcie_vdm_remove_dev(vdm_dev);
+	}
+}
+
+module_init(mctp_pcie_vdm_mod_init);
+module_exit(mctp_pcie_vdm_mod_exit);
+
+MODULE_DESCRIPTION("MCTP PCIe VDM transport");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("YH <yh_chung@aspeedtech.com>");
diff --git a/include/linux/mctp-pcie-vdm.h b/include/linux/mctp-pcie-vdm.h
new file mode 100644
index 000000000000..da3fad7929b2
--- /dev/null
+++ b/include/linux/mctp-pcie-vdm.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mctp-pcie-vdm.h - MCTP-over-PCIe-VDM (DMTF DSP0238) transport binding Interface
+ * for PCIe VDM devices to register and implement.
+ *
+ */
+
+#ifndef __LINUX_MCTP_PCIE_VDM_H
+#define __LINUX_MCTP_PCIE_VDM_H
+
+#include <linux/device.h>
+#include <linux/notifier.h>
+
+struct mctp_pcie_vdm_dev;
+
+/**
+ * @send_packet: referenced to send packets with PCIe VDM header packed.
+ * @recv_packet: referenced multiple times until no RX packet to be handled.
+ *               received pointer shall start from the PCIe VDM header.
+ * @free_packet: referenced when the packet is processed and okay to be freed.
+ * @uninit: uninitialize the device.
+ */
+struct mctp_pcie_vdm_ops {
+	int (*send_packet)(struct device *dev, u8 *data, size_t len);
+	u8 *(*recv_packet)(struct device *dev);
+	void (*free_packet)(void *packet);
+	void (*uninit)(struct device *dev);
+};
+
+struct mctp_pcie_vdm_dev *mctp_pcie_vdm_add_dev(struct device *dev,
+						const struct mctp_pcie_vdm_ops *ops);
+void mctp_pcie_vdm_remove_dev(struct mctp_pcie_vdm_dev *vdm_dev);
+
+/**
+ * Notify mctp-pcie-vdm that packets are received and ready to be processed.
+ * After notified, mctp-pcie-vdm will call recv_packet() multiple times
+ * until no more packets to be processed. The lower layer driver can keep receiving
+ * packets while the upper layer is processing the received packets.
+ */
+void mctp_pcie_vdm_notify_rx(struct mctp_pcie_vdm_dev *vdm_dev);
+
+#endif	 /* __LINUX_MCTP_PCIE_VDM_H */
-- 
2.34.1


