Return-Path: <netdev+bounces-219070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78180B3F9D1
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 11:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C84E1A851BF
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 09:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC1A2EBB9D;
	Tue,  2 Sep 2025 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NAEcpFBJ"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF232EB5B0;
	Tue,  2 Sep 2025 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804128; cv=none; b=hDob0ajDJPCbi2F5gX793A21fgKhPX15YidGbW+9MPjXTQHeDf/FG1064qrvLFV1y+l6VlJ2vQC0Bhm0IjviYbddiQchdE9S20ZcALX46BlyxY7l41DZoHwyDryhVV4stRicuRxBeRq5difrthaxeMSSyG/F2Z68RTBQ71kQ/Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804128; c=relaxed/simple;
	bh=kmPV9HoVOzjeNit6yYZy08NC9QAHrl3yOYDtZrnatSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aq7DU8EDC1r55st5qFcsE9ODuqXLTz6pUV/DgpK2DUpIFknerVVzP5N6+sXBuJG5s5zvfEVhJRfOQYcPkO+GKWLnQkBD2mQxROEVG6bINnpBppyAMasBj9nuxbITn0dY2HSpzoAHd0m4Spcf/oNjHHvTGAwSsjIDp2k3swPOfZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NAEcpFBJ; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5829824C2552651;
	Tue, 2 Sep 2025 04:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756804082;
	bh=J26dE8m6qp0+fOoFDeGDJ48Pxrnrm2blSCxxGEf+4pA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NAEcpFBJ8TDVNk0Gjx+1aNG69skauljXvKZFfaDs+e4ARQVPbeBMeR19Jf4ZbOPB0
	 mLDaHzJxkIfg+T7TjdtWQ1DsOeXp2PVJcVHaHU+x68vfCEp+e4v1Q0iJ0XB/PzDp4d
	 yGpgaKY8xymfXWP/gtwFhgBwHHvJozQ1n0/6aaKQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 582982mp2729602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 2 Sep 2025 04:08:02 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 04:08:01 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 04:08:01 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 582981xh1061672;
	Tue, 2 Sep 2025 04:08:01 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 5829808m020872;
	Tue, 2 Sep 2025 04:08:01 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu
 Poirier <mathieu.poirier@linaro.org>,
        Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        MD
 Danish Anwar <danishanwar@ti.com>, Xin Guo <guoxin09@huawei.com>,
        Lei Wei
	<quic_leiwei@quicinc.com>, Lee Trager <lee@trager.us>,
        Michael Ellerman
	<mpe@ellerman.id.au>, Fan Gong <gongfan1@huawei.com>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lukas
 Bulwahn <lukas.bulwahn@redhat.com>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>,
        Suman Anna <s-anna@ti.com>
CC: Tero Kristo <kristo@kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
Subject: [PATCH net-next v2 5/8] net: rpmsg-eth: Register device as netdev
Date: Tue, 2 Sep 2025 14:37:43 +0530
Message-ID: <20250902090746.3221225-6-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902090746.3221225-1-danishanwar@ti.com>
References: <20250902090746.3221225-1-danishanwar@ti.com>
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
index 4cfd9ff2f142..b6fe5628933d 100644
--- a/drivers/net/ethernet/rpmsg_eth.c
+++ b/drivers/net/ethernet/rpmsg_eth.c
@@ -9,20 +9,89 @@
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
+		dev_err(port->common->dev, "Buffer configuration mismatch in handshake: expected_buf_size=%lu, received_buf_size=%d\n",
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
@@ -94,6 +163,47 @@ static int rpmsg_eth_get_shm_info(struct rpmsg_eth_common *common)
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
@@ -109,11 +219,17 @@ static int rpmsg_eth_probe(struct rpmsg_device *rpdev)
 	common->port = devm_kzalloc(dev, sizeof(*common->port), GFP_KERNEL);
 	common->dev = dev;
 	common->rpdev = rpdev;
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
index 12be1c35eff8..0c2ae89fbfbf 100644
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
@@ -40,22 +149,89 @@ struct message_header {
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
+	struct rpmsg_eth_port *port;
+	struct device *dev;
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
 	struct rpmsg_eth_port *port;
 	struct device *dev;
 };
@@ -64,12 +240,30 @@ struct rpmsg_eth_common {
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


