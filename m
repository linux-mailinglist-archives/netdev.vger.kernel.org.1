Return-Path: <netdev+bounces-222100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6828DB530F3
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45EB5855D2
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 11:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45D1322C81;
	Thu, 11 Sep 2025 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Mb6br4lb"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228C032143C;
	Thu, 11 Sep 2025 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590632; cv=none; b=Ad4ucOWhq2yQR0+PNWsSve+jK1eSk1ms0wDCepHOrbrj5j4hCkVnwY/cYb2KRB6dvmq17RUSe/0stxhOcGP6wMoDDQntWx2yaTB0OFX5Lc6TfsW4o03jlsaiWdU6CH0U8GvDAdm1QkJ20dp2i1010ZlmQDZvJRgICkGn3JYqpEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590632; c=relaxed/simple;
	bh=a3f2zeOJzYbHwQToT1Zuhyx4X92Aem1weoPQccIKi78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5GhmYdcat18bXrjRP+IjSWCsAOgiBTIxqMSQgmuZw+vkRJYjj62SCKw2PoFh9j1krwT8YdzNWWpgcBJ57IrAczyYOATIBgT6Yll+qHJP1A3lGPE8aRwKTlQmD6Bfld0ZfYprDfq8pPsVYRUcPaT5YGHalCAbKeaudUd7myVGb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Mb6br4lb; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BBaOwo793646;
	Thu, 11 Sep 2025 06:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757590584;
	bh=PNo4lWUuO2P45UXHR+xPsllMY5/OiVnXKiKAYC2w5AQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Mb6br4lbBOkHghOAofy/gnRZFpqbsBxXWsy0fXEdMBgPgtTilVurQAwTVtnIQqX63
	 yILcSB9WTGtKmRsudHICPi2Y+adVaSxYLxlsBwSCgyxH7931v5AN1xQffBNwpv/u+c
	 FOeS0MOcxbxWEJiZ4trFpsY0u/l2AWHSf8YRZDKI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BBaO8V464598
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 11 Sep 2025 06:36:24 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 06:36:24 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 06:36:24 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BBaNLt1068560;
	Thu, 11 Sep 2025 06:36:23 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 58BBaMQn007156;
	Thu, 11 Sep 2025 06:36:23 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet
	<corbet@lwn.net>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        MD Danish Anwar
	<danishanwar@ti.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        Lei Wei
	<quic_leiwei@quicinc.com>, Xin Guo <guoxin09@huawei.com>,
        Michael Ellerman
	<mpe@ellerman.id.au>, Fan Gong <gongfan1@huawei.com>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>,
        Lukas Bulwahn
	<lukas.bulwahn@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH net-next v4 3/7] net: rpmsg-eth: Register device as netdev
Date: Thu, 11 Sep 2025 17:06:08 +0530
Message-ID: <20250911113612.2598643-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911113612.2598643-1-danishanwar@ti.com>
References: <20250911113612.2598643-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Register the rpmsg-eth device as a netdev and enhance the rpmsg callback
function to handle shared memory for tx and rx buffers. Introduce
structures for shared memory layout, including head, buffer, and tail
indices. Add initialization for the netdev, including setting up MAC
address, MTU, and netdev operations. Allocate memory for tx and rx
buffers and map shared memory regions. Update the probe function to
initialize the netdev and set the device state. Add necessary headers,
constants, and enums for shared memory and state management. Define
shared memory layout and buffer structures for efficient data handling.
Implement helper macros for accessing private data and shared memory
buffers. Ensure proper error handling during memory allocation and
device registration.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/rpmsg_eth.c | 132 ++++++++++++++++++++-
 drivers/net/ethernet/rpmsg_eth.h | 195 +++++++++++++++++++++++++++++++
 2 files changed, 325 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/rpmsg_eth.c b/drivers/net/ethernet/rpmsg_eth.c
index 7224fbc89646..f599318633ea 100644
--- a/drivers/net/ethernet/rpmsg_eth.c
+++ b/drivers/net/ethernet/rpmsg_eth.c
@@ -11,20 +11,101 @@
 
 #include "rpmsg_eth.h"
 
+/**
+ * rpmsg_eth_validate_handshake - Validate handshake parameters from remote
+ * @port: Pointer to rpmsg_eth_port structure
+ * @shm_info: Pointer to shared memory info received from remote
+ *
+ * Checks buffer size, magic numbers, and TX/RX offsets in the handshake
+ * response to ensure they match expected values and are within valid ranges.
+ *
+ * Return: 0 on success, -EINVAL on validation failure.
+ */
+static int rpmsg_eth_validate_handshake(struct rpmsg_eth_port *port,
+					struct rpmsg_eth_shm *shm_info)
+{
+	u32 tx_head_magic_num, tx_tail_magic_num;
+	u32 rx_head_magic_num, rx_tail_magic_num;
+
+	if (shm_info->buff_slot_size != RPMSG_ETH_BUFFER_SIZE) {
+		dev_err(port->common->dev, "Buffer configuration mismatch in handshake: expected_buf_size=%zu, received_buf_size=%d\n",
+			RPMSG_ETH_BUFFER_SIZE,
+			shm_info->buff_slot_size);
+		return -EINVAL;
+	}
+
+	if (shm_info->tx_offset >= port->buf_size ||
+	    shm_info->rx_offset >= port->buf_size) {
+		dev_err(port->common->dev, "TX/RX offset out of range in handshake: tx_offset=0x%x, rx_offset=0x%x, size=0x%llx\n",
+			shm_info->tx_offset,
+			shm_info->rx_offset,
+			port->buf_size);
+		return -EINVAL;
+	}
+
+	tx_head_magic_num = readl(port->shm + shm_info->tx_offset +
+				  HEAD_MAGIC_NUM_OFFSET);
+	rx_head_magic_num = readl(port->shm + shm_info->rx_offset +
+				  HEAD_MAGIC_NUM_OFFSET);
+	tx_tail_magic_num = readl(port->shm + shm_info->tx_offset +
+				  TAIL_MAGIC_NUM_OFFSET(shm_info->num_pkt_bufs));
+	rx_tail_magic_num = readl(port->shm + shm_info->rx_offset +
+				  TAIL_MAGIC_NUM_OFFSET(shm_info->num_pkt_bufs));
+
+	if (tx_head_magic_num != RPMSG_ETH_SHM_MAGIC_NUM ||
+	    rx_head_magic_num != RPMSG_ETH_SHM_MAGIC_NUM ||
+	    tx_tail_magic_num != RPMSG_ETH_SHM_MAGIC_NUM ||
+	    rx_tail_magic_num != RPMSG_ETH_SHM_MAGIC_NUM) {
+		dev_err(port->common->dev, "Magic number mismatch in handshake at head/tail\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int rpmsg_eth_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
 			      void *priv, u32 src)
 {
 	struct rpmsg_eth_common *common = dev_get_drvdata(&rpdev->dev);
 	struct message *msg = (struct message *)data;
+	struct rpmsg_eth_port *port = common->port;
 	u32 msg_type = msg->msg_hdr.msg_type;
+	u32 rpmsg_type;
 	int ret = 0;
 
 	switch (msg_type) {
 	case RPMSG_ETH_REQUEST_MSG:
+		rpmsg_type = msg->req_msg.type;
+		dev_dbg(common->dev, "Msg type = %d, RPMsg type = %d, Src Id = %d, Msg Id = %d\n",
+			msg_type, rpmsg_type, msg->msg_hdr.src_id, msg->req_msg.id);
+		break;
 	case RPMSG_ETH_RESPONSE_MSG:
+		rpmsg_type = msg->resp_msg.type;
+		dev_dbg(common->dev, "Msg type = %d, RPMsg type = %d, Src Id = %d, Msg Id = %d\n",
+			msg_type, rpmsg_type, msg->msg_hdr.src_id, msg->resp_msg.id);
+		switch (rpmsg_type) {
+		case RPMSG_ETH_RESP_SHM_INFO:
+			/* Handshake validation */
+			ret = rpmsg_eth_validate_handshake(port, &msg->resp_msg.shm_info);
+			if (ret) {
+				dev_err(common->dev, "RPMSG handshake failed %d\n", ret);
+				return ret;
+			}
+
+			/* Retrieve Tx and Rx shared memory info from msg */
+			port->tx_offset = msg->resp_msg.shm_info.tx_offset;
+			port->rx_offset = msg->resp_msg.shm_info.rx_offset;
+			port->tx_max_buffers =
+				msg->resp_msg.shm_info.num_pkt_bufs;
+			port->rx_max_buffers =
+				msg->resp_msg.shm_info.num_pkt_bufs;
+			break;
+		}
+		break;
 	case RPMSG_ETH_NOTIFY_MSG:
-		dev_dbg(common->dev, "Msg type = %d, Src Id = %d\n",
-			msg_type, msg->msg_hdr.src_id);
+		rpmsg_type = msg->notify_msg.type;
+		dev_dbg(common->dev, "Msg type = %d, RPMsg type = %d, Src Id = %d, Msg Id = %d\n",
+			msg_type, rpmsg_type, msg->msg_hdr.src_id, msg->notify_msg.id);
 		break;
 	default:
 		dev_err(common->dev, "Invalid msg type\n");
@@ -91,6 +172,47 @@ static int rpmsg_eth_get_shm_info(struct rpmsg_eth_common *common)
 	return 0;
 }
 
+static int rpmsg_eth_init_ndev(struct rpmsg_eth_common *common)
+{
+	struct device *dev = &common->rpdev->dev;
+	struct rpmsg_eth_ndev_priv *ndev_priv;
+	struct rpmsg_eth_port *port;
+	static u32 port_id;
+	int err = 0;
+
+	port = common->port;
+	port->common = common;
+	port->port_id = port_id++;
+
+	port->ndev = devm_alloc_etherdev_mqs(common->dev, sizeof(*ndev_priv),
+					     RPMSG_ETH_MAX_TX_QUEUES,
+					     RPMSG_ETH_MAX_RX_QUEUES);
+
+	if (!port->ndev) {
+		dev_err(dev, "error allocating net_device\n");
+		return -ENOMEM;
+	}
+
+	ndev_priv = netdev_priv(port->ndev);
+	ndev_priv->port = port;
+	SET_NETDEV_DEV(port->ndev, dev);
+
+	port->ndev->min_mtu = RPMSG_ETH_MIN_PACKET_SIZE;
+	port->ndev->max_mtu = RPMSG_ETH_MAX_MTU;
+
+	if (!is_valid_ether_addr(port->ndev->dev_addr)) {
+		eth_hw_addr_random(port->ndev);
+		dev_dbg(dev, "Using random MAC address %pM\n", port->ndev->dev_addr);
+	}
+
+	netif_carrier_off(port->ndev);
+	err = register_netdev(port->ndev);
+	if (err)
+		dev_err(dev, "error registering rpmsg_eth net device %d\n", err);
+
+	return err;
+}
+
 static int rpmsg_eth_probe(struct rpmsg_device *rpdev)
 {
 	struct device *dev = &rpdev->dev;
@@ -107,11 +229,17 @@ static int rpmsg_eth_probe(struct rpmsg_device *rpdev)
 	common->dev = dev;
 	common->rpdev = rpdev;
 	common->data = *(const struct rpmsg_eth_data *)rpdev->id.driver_data;
+	common->state = RPMSG_ETH_STATE_PROBE;
 
 	ret = rpmsg_eth_get_shm_info(common);
 	if (ret)
 		return ret;
 
+	/* Register the network device */
+	ret = rpmsg_eth_init_ndev(common);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/rpmsg_eth.h b/drivers/net/ethernet/rpmsg_eth.h
index 0d6f96f755eb..0a0695e857df 100644
--- a/drivers/net/ethernet/rpmsg_eth.h
+++ b/drivers/net/ethernet/rpmsg_eth.h
@@ -18,6 +18,35 @@
 #include <linux/rpmsg.h>
 
 #define RPMSG_ETH_SHM_MAGIC_NUM 0xABCDABCD
+#define RPMSG_ETH_MIN_PACKET_SIZE ETH_ZLEN
+#define RPMSG_ETH_PACKET_BUFFER_SIZE   1540
+#define RPMSG_ETH_MAX_MTU \
+	(RPMSG_ETH_PACKET_BUFFER_SIZE - (ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN))
+
+#define RPMSG_ETH_MAX_TX_QUEUES 1
+#define RPMSG_ETH_MAX_RX_QUEUES 1
+#define PKT_LEN_SIZE_TYPE sizeof(u32)
+#define MAGIC_NUM_SIZE_TYPE sizeof(u32)
+
+/* 4 bytes to hold packet length and RPMSG_ETH_PACKET_BUFFER_SIZE to hold packet */
+#define RPMSG_ETH_BUFFER_SIZE \
+	(RPMSG_ETH_PACKET_BUFFER_SIZE + PKT_LEN_SIZE_TYPE + MAGIC_NUM_SIZE_TYPE)
+
+#define RX_POLL_TIMEOUT_JIFFIES usecs_to_jiffies(1000)
+#define RX_POLL_JIFFIES (jiffies + RX_POLL_TIMEOUT_JIFFIES)
+#define STATE_MACHINE_TIME_JIFFIES msecs_to_jiffies(100)
+#define RPMSG_ETH_REQ_TIMEOUT_JIFFIES msecs_to_jiffies(100)
+
+#define HEAD_MAGIC_NUM_OFFSET 0x0
+#define HEAD_IDX_OFFSET (HEAD_MAGIC_NUM_OFFSET + MAGIC_NUM_SIZE_TYPE)
+#define PKT_START_OFFSET(n) \
+	((HEAD_IDX_OFFSET + MAGIC_NUM_SIZE_TYPE) + ((n) * RPMSG_ETH_BUFFER_SIZE))
+#define TAIL_MAGIC_NUM_OFFSET(n) PKT_START_OFFSET((n))
+#define TAIL_IDX_OFFSET(n) (TAIL_MAGIC_NUM_OFFSET((n)) + MAGIC_NUM_SIZE_TYPE)
+
+#define rpmsg_eth_ndev_to_priv(ndev) ((struct rpmsg_eth_ndev_priv *)netdev_priv(ndev))
+#define rpmsg_eth_ndev_to_port(ndev) (rpmsg_eth_ndev_to_priv(ndev)->port)
+#define rpmsg_eth_ndev_to_common(ndev) (rpmsg_eth_ndev_to_port(ndev)->common)
 
 enum rpmsg_eth_msg_type {
 	RPMSG_ETH_REQUEST_MSG = 0,
@@ -25,6 +54,87 @@ enum rpmsg_eth_msg_type {
 	RPMSG_ETH_NOTIFY_MSG,
 };
 
+enum rpmsg_eth_rpmsg_type {
+	/* Request types */
+	RPMSG_ETH_REQ_SHM_INFO = 0,
+	RPMSG_ETH_REQ_SET_MAC_ADDR,
+
+	/* Response types */
+	RPMSG_ETH_RESP_SHM_INFO,
+	RPMSG_ETH_RESP_SET_MAC_ADDR,
+
+	/* Notification types */
+	RPMSG_ETH_NOTIFY_PORT_UP,
+	RPMSG_ETH_NOTIFY_PORT_DOWN,
+	RPMSG_ETH_NOTIFY_PORT_READY,
+	RPMSG_ETH_NOTIFY_REMOTE_READY,
+};
+
+/**
+ * struct rpmsg_eth_shm - Shared memory layout for RPMsg Ethernet
+ * @num_pkt_bufs: Number of packet buffers available in the shared memory
+ * @buff_slot_size: Size of each buffer slot in bytes
+ * @tx_offset: Offset for the transmit buffer region within the shared memory
+ * @rx_offset: Offset for the receive buffer region within the shared memory
+ *
+ * This structure defines the layout of the shared memory used for
+ * communication between the host and the remote processor in an RPMsg
+ * Ethernet driver. It specifies the configuration and memory offsets
+ * required for transmitting and receiving Ethernet packets.
+ */
+struct rpmsg_eth_shm {
+	u32 num_pkt_bufs;
+	u32 buff_slot_size;
+	u32 tx_offset;
+	u32 rx_offset;
+} __packed;
+
+/**
+ * struct rpmsg_eth_mac_addr - MAC address information for RPMSG Ethernet
+ * @addr: MAC address
+ */
+struct rpmsg_eth_mac_addr {
+	char addr[ETH_ALEN];
+} __packed;
+
+/**
+ * struct request_message - request message structure for RPMSG Ethernet
+ * @type: Request Type
+ * @id: Request ID
+ * @mac_addr: MAC address (if request type is MAC address related)
+ */
+struct request_message {
+	u32 type;
+	u32 id;
+	union {
+		struct rpmsg_eth_mac_addr mac_addr;
+	};
+} __packed;
+
+/**
+ * struct response_message - response message structure for RPMSG Ethernet
+ * @type: Response Type
+ * @id: Response ID
+ * @shm_info: rpmsg shared memory info
+ */
+struct response_message {
+	u32 type;
+	u32 id;
+	union {
+		struct rpmsg_eth_shm shm_info;
+	};
+} __packed;
+
+/**
+ * struct notify_message - notification message structure for RPMSG Ethernet
+ * @type: Notify Type
+ * @id: Notify ID
+ */
+struct notify_message {
+	u32 type;
+	u32 id;
+} __packed;
+
 /**
  * struct message_header - message header structure for RPMSG Ethernet
  * @src_id: Source endpoint ID
@@ -40,12 +150,20 @@ struct message_header {
  *
  * @msg_hdr: Message header contains source and destination endpoint and
  *          the type of message
+ * @req_msg: Request message structure contains the request type and ID
+ * @resp_msg: Response message structure contains the response type and ID
+ * @notify_msg: Notification message structure contains the notify type and ID
  *
  * This structure is used to send and receive messages between the RPMSG
  * Ethernet ports.
  */
 struct message {
 	struct message_header msg_hdr;
+	union {
+		struct request_message req_msg;
+		struct response_message resp_msg;
+		struct notify_message notify_msg;
+	};
 } __packed;
 
 /**
@@ -56,30 +174,107 @@ struct rpmsg_eth_data {
 	u8 shm_region_index;
 };
 
+/*      Shared Memory Layout
+ *
+ *	---------------------------	*****************
+ *	|        MAGIC_NUM        |	 rpmsg_eth_shm_head
+ *	|        HEAD_IDX         |
+ *	---------------------------	*****************
+ *	|        MAGIC_NUM        |
+ *	|        PKT_1_LEN        |
+ *	|          PKT_1          |
+ *	---------------------------
+ *	|        MAGIC_NUM        |
+ *	|        PKT_2_LEN        |	 rpmsg_eth_shm_buf
+ *	|          PKT_2          |
+ *	---------------------------
+ *	|           .             |
+ *	|           .             |
+ *	---------------------------
+ *	|        MAGIC_NUM        |
+ *	|        PKT_N_LEN        |
+ *	|          PKT_N          |
+ *	---------------------------	****************
+ *	|        MAGIC_NUM        |      rpmsg_eth_shm_tail
+ *	|        TAIL_IDX         |
+ *	---------------------------	****************
+ */
+
+enum rpmsg_eth_state {
+	RPMSG_ETH_STATE_PROBE,
+	RPMSG_ETH_STATE_OPEN,
+	RPMSG_ETH_STATE_CLOSE,
+	RPMSG_ETH_STATE_READY,
+	RPMSG_ETH_STATE_RUNNING,
+
+};
+
 /**
  * struct rpmsg_eth_common - common structure for RPMSG Ethernet
  * @rpdev: RPMSG device
+ * @send_msg: Send message
+ * @recv_msg: Receive message
  * @port: Ethernet port
  * @dev: Device
  * @data: Vendor specific data
+ * @state: Interface state
+ * @state_work: Delayed work for state machine
  */
 struct rpmsg_eth_common {
 	struct rpmsg_device *rpdev;
+	/** @send_msg_lock: Lock for sending RPMSG */
+	spinlock_t send_msg_lock;
+	/** @recv_msg_lock: Lock for receiving RPMSG */
+	spinlock_t recv_msg_lock;
+	struct message send_msg;
+	struct message recv_msg;
 	struct rpmsg_eth_port *port;
 	struct device *dev;
 	struct rpmsg_eth_data data;
+	enum rpmsg_eth_state state;
+	/** @state_lock: Lock for changing interface state */
+	struct mutex state_lock;
+	struct delayed_work state_work;
+};
+
+/**
+ * struct rpmsg_eth_ndev_priv - private structure for RPMSG Ethernet net device
+ * @port: Ethernet port
+ * @dev: Device
+ */
+struct rpmsg_eth_ndev_priv {
+	struct rpmsg_eth_port *port;
+	struct device *dev;
 };
 
 /**
  * struct rpmsg_eth_port - Ethernet port structure for RPMSG Ethernet
  * @common: Pointer to the common RPMSG Ethernet structure
  * @shm: Shared memory region mapping
+ * @tx_offset: Offset for TX region in shared memory
+ * @rx_offset: Offset for RX region in shared memory
  * @buf_size: Size (in bytes) of the shared memory buffer for this port
+ * @rx_timer: Timer for rx polling
+ * @rx_napi: NAPI structure for rx polling
+ * @local_mac_addr: Local MAC address
+ * @ndev: Network device
+ * @tx_max_buffers: Maximum number of tx buffers
+ * @rx_max_buffers: Maximum number of rx buffers
+ * @port_id: Port ID
  */
 struct rpmsg_eth_port {
 	struct rpmsg_eth_common *common;
 	void __iomem *shm;
+	u32 tx_offset;
+	u32 rx_offset;
 	phys_addr_t buf_size;
+	struct timer_list rx_timer;
+	struct napi_struct rx_napi;
+	u8 local_mac_addr[ETH_ALEN];
+	struct net_device *ndev;
+	u32 tx_max_buffers;
+	u32 rx_max_buffers;
+	u32 port_id;
 };
 
 #endif /* __RPMSG_ETH_H__ */
-- 
2.34.1


