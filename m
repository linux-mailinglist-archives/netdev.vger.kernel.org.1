Return-Path: <netdev+bounces-220758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6844AB487F2
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 11:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5E3188D980
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B672FB618;
	Mon,  8 Sep 2025 09:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DDfViRZh"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADED2F8BC0;
	Mon,  8 Sep 2025 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322530; cv=none; b=bXdZ27FyGvudks7+EIbC1NrqUX8ltQi2xoSEJQqJ5It2HPVJbkbLaTtC30HxzL1cmH+ezzqCh0jLqSv3XW5BWTJneEMLcq/jWDNcDsx1kPwKu8nK7u3Zg0U1NusXD/hECL9NUsJJH0O9OzT9phq0zjmySugPalOzan672Gxx7mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322530; c=relaxed/simple;
	bh=Zbxb2SuxRpiwpH3Oy5oym1OKC3VvBEzXCRwfZ/WS0pY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQSDIzGc2QrW+KfG78MEK5d+y95MX7dzEUTpnjXF1mi8E89XV7Vjhkf6iAmsLXVw9d4vKw+QTxkn94YP0o2OI3y9N6A1k0zRij280HJLsNjC70MSrHaxSZh37MyuxCYvOzZdzD8Ko9n4P6ikyvn2jG03wkpjNbTFDY9Wk0E5+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DDfViRZh; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58897wN2022076;
	Mon, 8 Sep 2025 04:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757322478;
	bh=MpJiXHeLEsI9U0KrvmKCel58313ArNNNDn7871tCQgo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DDfViRZhjwu3hJSTRDdRRxmQ9+CzVw5OgQEcBYTTweESpoho+u2dFKA94LqUFGBJy
	 vPxlzvojhrKRFE7XGhPvKTQhiTZFurcRqKmaLg7gqCQhyfniiH8mtNlGRtcsJdpWWH
	 pepq3lKOvPJB4pc8V4Ey5igT2V4PUn1/yprMoAmk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58897w332303061
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 04:07:58 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 04:07:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 04:07:57 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58897v3O642722;
	Mon, 8 Sep 2025 04:07:57 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 58897upb023030;
	Mon, 8 Sep 2025 04:07:57 -0500
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
        Luo Jie
	<quic_luoj@quicinc.com>, Fan Gong <gongfan1@huawei.com>,
        Lei Wei
	<quic_leiwei@quicinc.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Lee Trager
	<lee@trager.us>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Lukas Bulwahn <lukas.bulwahn@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH net-next v3 3/7] net: rpmsg-eth: Register device as netdev
Date: Mon, 8 Sep 2025 14:37:42 +0530
Message-ID: <20250908090746.862407-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908090746.862407-1-danishanwar@ti.com>
References: <20250908090746.862407-1-danishanwar@ti.com>
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
 drivers/net/ethernet/rpmsg_eth.c | 120 ++++++++++++++++++-
 drivers/net/ethernet/rpmsg_eth.h | 194 +++++++++++++++++++++++++++++++
 2 files changed, 312 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/rpmsg_eth.c b/drivers/net/ethernet/rpmsg_eth.c
index b375dfd9cf1c..bcbcfca37379 100644
--- a/drivers/net/ethernet/rpmsg_eth.c
+++ b/drivers/net/ethernet/rpmsg_eth.c
@@ -10,20 +10,89 @@
 #include <linux/remoteproc.h>
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
+	if (shm_info->buff_slot_size != RPMSG_ETH_BUFFER_SIZE) {
+		dev_err(port->common->dev, "Buffer configuration mismatch in handshake: expected_buf_size=%zu, received_buf_size=%d\n",
+			RPMSG_ETH_BUFFER_SIZE,
+			shm_info->buff_slot_size);
+		return -EINVAL;
+	}
+
+	if (readl(port->shm + port->tx_offset + HEAD_MAGIC_NUM_OFFSET) != RPMSG_ETH_SHM_MAGIC_NUM ||
+	    readl(port->shm + port->rx_offset + HEAD_MAGIC_NUM_OFFSET) != RPMSG_ETH_SHM_MAGIC_NUM ||
+	    readl(port->shm + port->tx_offset + TAIL_MAGIC_NUM_OFFSET(port->tx_max_buffers)) != RPMSG_ETH_SHM_MAGIC_NUM ||
+	    readl(port->shm + port->rx_offset + TAIL_MAGIC_NUM_OFFSET(port->rx_max_buffers)) != RPMSG_ETH_SHM_MAGIC_NUM) {
+		dev_err(port->common->dev, "Magic number mismatch in handshake at head/tail\n");
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
+			/* Retrieve Tx and Rx shared memory info from msg */
+			port->tx_offset = msg->resp_msg.shm_info.tx_offset;
+			port->rx_offset = msg->resp_msg.shm_info.rx_offset;
+			port->tx_max_buffers =
+				msg->resp_msg.shm_info.num_pkt_bufs;
+			port->rx_max_buffers =
+				msg->resp_msg.shm_info.num_pkt_bufs;
+
+			/* Handshake validation */
+			ret = rpmsg_eth_validate_handshake(port, &msg->resp_msg.shm_info);
+			if (ret) {
+				dev_err(common->dev, "RPMSG handshake failed %d\n", ret);
+				return ret;
+			}
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
@@ -88,6 +157,47 @@ static int rpmsg_eth_get_shm_info(struct rpmsg_eth_common *common)
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
+	port->ndev->max_mtu = MAX_MTU;
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
@@ -105,11 +215,17 @@ static int rpmsg_eth_probe(struct rpmsg_device *rpdev)
 	common->rpdev = rpdev;
 	common->data = *(const struct rpmsg_eth_data *)rpdev->id.driver_data;
 	dev_err(dev, "shm_index = %d\n", common->data.shm_region_index);
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
index 7c8ae57fcf07..3925a9ef1e3c 100644
--- a/drivers/net/ethernet/rpmsg_eth.h
+++ b/drivers/net/ethernet/rpmsg_eth.h
@@ -18,6 +18,34 @@
 #include <linux/rpmsg.h>
 
 #define RPMSG_ETH_SHM_MAGIC_NUM 0xABCDABCD
+#define RPMSG_ETH_MIN_PACKET_SIZE ETH_ZLEN
+#define RPMSG_ETH_PACKET_BUFFER_SIZE   1540
+#define MAX_MTU   (RPMSG_ETH_PACKET_BUFFER_SIZE - (ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN))
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
@@ -25,6 +53,87 @@ enum rpmsg_eth_msg_type {
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
@@ -40,12 +149,20 @@ struct message_header {
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
@@ -56,30 +173,107 @@ struct rpmsg_eth_data {
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


