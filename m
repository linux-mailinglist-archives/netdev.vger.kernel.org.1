Return-Path: <netdev+bounces-209250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B5BB0ECA9
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E2F16D6E9
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D487C27CCEE;
	Wed, 23 Jul 2025 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jNmNN4aJ"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A55727A135;
	Wed, 23 Jul 2025 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257856; cv=none; b=OnE/1zJS7vY30Nu/kLK0CQflFz1TpJS4fZXUB7uuuAU8oiehDF6znUpDpZzDbTj00C1/RNOItCs8BjrcGefcfdyrupdwVFUUPfA0PmXK6g0GaCtfgYGhY+FZVhyLx4UDbHDkTVeotd0M7ZAR3DJwvYVVtBL/JEql64+hBY/FIYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257856; c=relaxed/simple;
	bh=mu9vJrbVW6pLW0y6TlYod3MetdqgGWeuGGWBxEjrAzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhcG7noYZcSX8xLTueACyHdk8udTVOAX4rz2jZKYwHzVSyShkMH47PglgwNDWgtVePWxB4KVOovKN4etkqkvaODrchf+m7E3E7yDQX6S4mT/StiIqbJVOB1I7i4zufH8PFMODlIg4uS/ZINIb1LNeJ8ZZ1xCeH1WucmI2rKU86M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jNmNN4aJ; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56N83Znu1676451;
	Wed, 23 Jul 2025 03:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753257815;
	bh=J7Pw2c7pQUrc6QTEN0gXmSfzT3FzaWnjufqPB8NQJlA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jNmNN4aJQ297TJ5n3CaM2RGk0QEpBzKCmfkES3RxJ8tUO1xpoMwcDABsDwEIx9Iv2
	 zsos9QA0bo63VM4c05sohC7rSeZIXuUAf01ewZmZ21uaUhZZZlmo2ZY8hQ30eZhDrr
	 +fhWUu2BikAXcffj5BARhvrcNedYOATjcEQAAB8U=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56N83ZTn1619141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 23 Jul 2025 03:03:35 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 23
 Jul 2025 03:03:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 23 Jul 2025 03:03:34 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56N83YPv2365941;
	Wed, 23 Jul 2025 03:03:34 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 56N83XNa015985;
	Wed, 23 Jul 2025 03:03:34 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet
	<corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
        Mengyuan Lou
	<mengyuanlou@net-swift.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Michael
 Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Fan
 Gong <gongfan1@huawei.com>, Lee Trager <lee@trager.us>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lukas
 Bulwahn <lukas.bulwahn@redhat.com>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 3/5] net: rpmsg-eth: Register device as netdev
Date: Wed, 23 Jul 2025 13:33:20 +0530
Message-ID: <20250723080322.3047826-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723080322.3047826-1-danishanwar@ti.com>
References: <20250723080322.3047826-1-danishanwar@ti.com>
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
 drivers/net/ethernet/rpmsg_eth.c | 239 ++++++++++++++++++++++++++++++-
 drivers/net/ethernet/rpmsg_eth.h | 216 ++++++++++++++++++++++++++++
 2 files changed, 452 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/rpmsg_eth.c b/drivers/net/ethernet/rpmsg_eth.c
index 9a51619f9313..26f9eee6aeec 100644
--- a/drivers/net/ethernet/rpmsg_eth.c
+++ b/drivers/net/ethernet/rpmsg_eth.c
@@ -7,20 +7,173 @@
 #include <linux/of.h>
 #include "rpmsg_eth.h"
 
+/**
+ * rpmsg_eth_validate_handshake - Validate handshake parameters from remote
+ * @port: Pointer to rpmsg_eth_port structure
+ * @shm_info: Pointer to shared memory info received from remote
+ *
+ * Checks the magic numbers, base address, and TX/RX offsets in the handshake
+ * response to ensure they match expected values and are within valid ranges.
+ *
+ * Return: 0 on success, -EINVAL on validation failure.
+ */
+static int rpmsg_eth_validate_handshake(struct rpmsg_eth_port *port,
+					struct rpmsg_eth_shm *shm_info)
+{
+	if (port->tx_buffer->head->magic_num != RPMSG_ETH_SHM_MAGIC_NUM ||
+	    port->tx_buffer->tail->magic_num != RPMSG_ETH_SHM_MAGIC_NUM ||
+	    port->rx_buffer->head->magic_num != RPMSG_ETH_SHM_MAGIC_NUM ||
+	    port->rx_buffer->tail->magic_num != RPMSG_ETH_SHM_MAGIC_NUM) {
+		dev_err(port->common->dev, "Magic number mismatch in handshake: tx_head=0x%x, tx_tail=0x%x, rx_head=0x%x, rx_tail=0x%x\n",
+			port->tx_buffer->head->magic_num,
+			port->tx_buffer->tail->magic_num,
+			port->rx_buffer->head->magic_num,
+			port->rx_buffer->tail->magic_num);
+		return -EINVAL;
+	}
+
+	if (shm_info->base_addr != port->buf_start_addr) {
+		dev_err(port->common->dev, "Base address mismatch in handshake: expected=0x%x, received=0x%x\n",
+			port->buf_start_addr,
+			shm_info->base_addr);
+		return -EINVAL;
+	}
+
+	if (shm_info->tx_offset >= port->buf_size ||
+	    shm_info->rx_offset >= port->buf_size) {
+		dev_err(port->common->dev, "TX/RX offset out of range in handshake: tx_offset=0x%x, rx_offset=0x%x, size=0x%x\n",
+			shm_info->tx_offset,
+			shm_info->rx_offset,
+			port->buf_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void rpmsg_eth_map_buffers(struct rpmsg_eth_port *port,
+				  struct message *msg)
+{
+	port->tx_buffer->head =
+		(struct rpmsg_eth_shm_index __force *)
+		 (ioremap(msg->resp_msg.shm_info.base_addr +
+			  msg->resp_msg.shm_info.tx_offset,
+			  sizeof(*port->tx_buffer->head)));
+
+	port->tx_buffer->buf->base_addr =
+		ioremap((msg->resp_msg.shm_info.base_addr +
+			 msg->resp_msg.shm_info.tx_offset +
+			 sizeof(*port->tx_buffer->head)),
+			 (msg->resp_msg.shm_info.num_pkt_bufs *
+			  msg->resp_msg.shm_info.buff_slot_size));
+
+	port->tx_buffer->tail =
+		(struct rpmsg_eth_shm_index __force *)
+		 (ioremap(msg->resp_msg.shm_info.base_addr +
+			  msg->resp_msg.shm_info.tx_offset +
+			  sizeof(*port->tx_buffer->head) +
+			  (msg->resp_msg.shm_info.num_pkt_bufs *
+			   msg->resp_msg.shm_info.buff_slot_size),
+			  sizeof(*port->tx_buffer->tail)));
+
+	port->rx_buffer->head =
+		(struct rpmsg_eth_shm_index __force *)
+		 (ioremap(msg->resp_msg.shm_info.base_addr +
+			  msg->resp_msg.shm_info.rx_offset,
+			  sizeof(*port->rx_buffer->head)));
+
+	port->rx_buffer->buf->base_addr =
+		ioremap(msg->resp_msg.shm_info.base_addr +
+			msg->resp_msg.shm_info.rx_offset +
+			sizeof(*port->rx_buffer->head),
+			(msg->resp_msg.shm_info.num_pkt_bufs *
+			 msg->resp_msg.shm_info.buff_slot_size));
+
+	port->rx_buffer->tail =
+		(struct rpmsg_eth_shm_index __force *)
+		 (ioremap(msg->resp_msg.shm_info.base_addr +
+			  msg->resp_msg.shm_info.rx_offset +
+			  sizeof(*port->rx_buffer->head) +
+			  (msg->resp_msg.shm_info.num_pkt_bufs *
+			   msg->resp_msg.shm_info.buff_slot_size),
+			  sizeof(*port->rx_buffer->tail)));
+}
+
+static void rpmsg_eth_unmap_buffers(struct rpmsg_eth_port *port)
+{
+	if (port->tx_buffer && port->tx_buffer->head) {
+		iounmap((void __iomem *)port->tx_buffer->head);
+		port->tx_buffer->head = NULL;
+	}
+	if (port->tx_buffer && port->tx_buffer->buf &&
+	    port->tx_buffer->buf->base_addr) {
+		iounmap((void __iomem *)port->tx_buffer->buf->base_addr);
+		port->tx_buffer->buf->base_addr = NULL;
+	}
+	if (port->tx_buffer && port->tx_buffer->tail) {
+		iounmap((void __iomem *)port->tx_buffer->tail);
+		port->tx_buffer->tail = NULL;
+	}
+
+	if (port->rx_buffer && port->rx_buffer->head) {
+		iounmap((void __iomem *)port->rx_buffer->head);
+		port->rx_buffer->head = NULL;
+	}
+	if (port->rx_buffer && port->rx_buffer->buf &&
+	    port->rx_buffer->buf->base_addr) {
+		iounmap((void __iomem *)port->rx_buffer->buf->base_addr);
+		port->rx_buffer->buf->base_addr = NULL;
+	}
+	if (port->rx_buffer && port->rx_buffer->tail) {
+		iounmap((void __iomem *)port->rx_buffer->tail);
+		port->rx_buffer->tail = NULL;
+	}
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
+			rpmsg_eth_map_buffers(port, msg);
+
+			port->rpmsg_eth_tx_max_buffers =
+				msg->resp_msg.shm_info.num_pkt_bufs;
+			port->rpmsg_eth_rx_max_buffers =
+				msg->resp_msg.shm_info.num_pkt_bufs;
+
+			/* Handshake validation */
+			ret = rpmsg_eth_validate_handshake(port, &msg->resp_msg.shm_info);
+			if (ret) {
+				dev_err(common->dev, "RPMSG handshake failed %d\n", ret);
+				rpmsg_eth_unmap_buffers(port);
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
@@ -80,6 +233,76 @@ static int rpmsg_eth_get_shm_info(struct rpmsg_eth_common *common)
 	return 0;
 }
 
+static int rpmsg_eth_init_ndev(struct rpmsg_eth_common *common)
+{
+	struct device *dev = &common->rpdev->dev;
+	struct rpmsg_eth_ndev_priv *ndev_priv;
+	struct rpmsg_eth_port *port;
+	static u32 port_id;
+	int err;
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
+	/* Allocate memory to test without actual RPMsg handshaking */
+	port->tx_buffer =
+		devm_kzalloc(dev, sizeof(*port->tx_buffer), GFP_KERNEL);
+	if (!port->tx_buffer) {
+		dev_err(dev, "Memory not available\n");
+		return -ENOMEM;
+	}
+
+	port->tx_buffer->buf =
+		devm_kzalloc(dev, sizeof(*port->tx_buffer->buf), GFP_KERNEL);
+	if (!port->tx_buffer->buf) {
+		dev_err(dev, "Memory not available\n");
+		return -ENOMEM;
+	}
+
+	port->rx_buffer =
+		devm_kzalloc(dev, sizeof(*port->rx_buffer), GFP_KERNEL);
+	if (!port->rx_buffer) {
+		dev_err(dev, "Memory not available\n");
+		return -ENOMEM;
+	}
+
+	port->rx_buffer->buf =
+		devm_kzalloc(dev, sizeof(*port->rx_buffer->buf), GFP_KERNEL);
+	if (!port->rx_buffer->buf) {
+		dev_err(dev, "Memory not available\n");
+		return -ENOMEM;
+	}
+	netif_carrier_off(port->ndev);
+
+	err = register_netdev(port->ndev);
+
+	if (err)
+		dev_err(dev, "error registering rpmsg_eth net device %d\n", err);
+	return 0;
+}
+
 static int rpmsg_eth_probe(struct rpmsg_device *rpdev)
 {
 	struct device *dev = &rpdev->dev;
@@ -95,17 +318,27 @@ static int rpmsg_eth_probe(struct rpmsg_device *rpdev)
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
 
 static void rpmsg_eth_rpmsg_remove(struct rpmsg_device *rpdev)
 {
-	dev_dbg(&rpdev->dev, "rpmsg-eth client driver is removed\n");
+	struct rpmsg_eth_common *common = dev_get_drvdata(&rpdev->dev);
+	struct rpmsg_eth_port *port = common->port;
+
+	/* Unmap ioremap'd regions */
+	rpmsg_eth_unmap_buffers(port);
 }
 
 static struct rpmsg_device_id rpmsg_eth_rpmsg_id_table[] = {
diff --git a/drivers/net/ethernet/rpmsg_eth.h b/drivers/net/ethernet/rpmsg_eth.h
index 56dabd139643..aa43030f3d72 100644
--- a/drivers/net/ethernet/rpmsg_eth.h
+++ b/drivers/net/ethernet/rpmsg_eth.h
@@ -18,6 +18,27 @@
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
+#define rpmsg_eth_ndev_to_priv(ndev) ((struct rpmsg_eth_ndev_priv *)netdev_priv(ndev))
+#define rpmsg_eth_ndev_to_port(ndev) (rpmsg_eth_ndev_to_priv(ndev)->port)
+#define rpmsg_eth_ndev_to_common(ndev) (rpmsg_eth_ndev_to_port(ndev)->common)
 
 enum rpmsg_eth_msg_type {
 	RPMSG_ETH_REQUEST_MSG = 0,
@@ -25,6 +46,89 @@ enum rpmsg_eth_msg_type {
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
+ * @base_addr: Base address of the shared memory region
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
+	u32 base_addr;
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
@@ -40,22 +144,116 @@ struct message_header {
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
+} __packed;
+
+/*      Shared Memory Layout
+ *
+ *	---------------------------	*****************
+ *	|        MAGIC_NUM        |	 rpmsg_eth_shm_head
+ *	|          HEAD           |
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
+ *	|          TAIL           |
+ *	---------------------------	****************
+ */
+
+struct rpmsg_eth_shm_index {
+	u32 magic_num;
+	u32 index;
+}  __packed;
+
+/**
+ * struct rpmsg_eth_shm_buf - shared memory buffer structure for RPMSG Ethernet
+ * @base_addr: Base address of the buffer
+ * @magic_num: Magic number for buffer validation
+ */
+struct rpmsg_eth_shm_buf {
+	void __iomem *base_addr;
+	u32 magic_num;
+} __packed;
+
+/**
+ * struct rpmsg_eth_shared_mem - shared memory structure for RPMSG Ethernet
+ * @head: Head of the shared memory
+ * @buf: Buffer of the shared memory
+ * @tail: Tail of the shared memory
+ */
+struct rpmsg_eth_shared_mem {
+	struct rpmsg_eth_shm_index *head;
+	struct rpmsg_eth_shm_buf *buf;
+	struct rpmsg_eth_shm_index *tail;
 } __packed;
 
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
@@ -65,11 +263,29 @@ struct rpmsg_eth_common {
  * @common: Pointer to the common RPMSG Ethernet structure
  * @buf_start_addr: Start address of the shared memory buffer for this port
  * @buf_size: Size (in bytes) of the shared memory buffer for this port
+ * @tx_buffer: Write buffer for data to be consumed by remote side
+ * @rx_buffer: Read buffer for data to be consumed by this driver
+ * @rx_timer: Timer for rx polling
+ * @rx_napi: NAPI structure for rx polling
+ * @local_mac_addr: Local MAC address
+ * @ndev: Network device
+ * @rpmsg_eth_tx_max_buffers: Maximum number of tx buffers
+ * @rpmsg_eth_rx_max_buffers: Maximum number of rx buffers
+ * @port_id: Port ID
  */
 struct rpmsg_eth_port {
 	struct rpmsg_eth_common *common;
 	u32 buf_start_addr;
 	u32 buf_size;
+	struct rpmsg_eth_shared_mem *tx_buffer;
+	struct rpmsg_eth_shared_mem *rx_buffer;
+	struct timer_list rx_timer;
+	struct napi_struct rx_napi;
+	u8 local_mac_addr[ETH_ALEN];
+	struct net_device *ndev;
+	u32 rpmsg_eth_tx_max_buffers;
+	u32 rpmsg_eth_rx_max_buffers;
+	u32 port_id;
 };
 
 #endif /* __RPMSG_ETH_H__ */
-- 
2.34.1


