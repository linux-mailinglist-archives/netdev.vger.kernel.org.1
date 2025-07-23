Return-Path: <netdev+bounces-209249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5452EB0ECA7
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6703C3B93D1
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5504F27AC3A;
	Wed, 23 Jul 2025 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vTzo1LiX"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4E927A12C;
	Wed, 23 Jul 2025 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257856; cv=none; b=Ho8WUZPIlyk2QQtFo9WoWVemRK5bQ+SphJszijtFdX6szLS5WY4Zoj8mi/22qjya1jMcJAYe87Z4ksawaiM0uaDKxsDFALSwjf5bh0UHcOD6cXWhjQoaNClLTVEw4ZDXK5J5ng/MqrvAMP78Av5Rgjyysoh+E1Lr4hwb2xm0Th0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257856; c=relaxed/simple;
	bh=Byab61WjMDYnAwBBhTk8h7ZIULStJN65B+0eQwvduFA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NupgAFVwiejGiYDSLFYMMcvokhYh8w8r+LEvk4SXzji2wLYq2+1hyBBNxX15kCVEhaOqp1r9DwIWDvO8QEaz6sVg5WgX2ZgCNRdcjons5pc3EUrAf3oWotfhVmifLiccIus1Y5jBzKMc5eKSmLRzfr51jCSCBe2Gts1EB/55RuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vTzo1LiX; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56N83b4f1223412;
	Wed, 23 Jul 2025 03:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753257817;
	bh=NanDPG3eGNw9XC4l/hPEFH2QVadmc7khxeTagmYKGvg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=vTzo1LiX04NauhzWdJVl8cWqeDByuGbQxw5DuELtvToKTW5UhbZlLow7/5f6pjU6b
	 ZaiNS5DUhG2tiCMtJWjtZUR+iVk47z6Rr2+2u9EKPvtz1lKNMqOqcKPlN0bIvnKkks
	 ueDzwGGHrlzQ2t41toock1ex14RjB//QSswcw5eA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56N83bws553849
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 23 Jul 2025 03:03:37 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 23
 Jul 2025 03:03:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 23 Jul 2025 03:03:37 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56N83bVd2366006;
	Wed, 23 Jul 2025 03:03:37 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 56N83ZRo015995;
	Wed, 23 Jul 2025 03:03:36 -0500
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
Subject: [PATCH net-next 4/5] net: rpmsg-eth: Add netdev ops
Date: Wed, 23 Jul 2025 13:33:21 +0530
Message-ID: <20250723080322.3047826-5-danishanwar@ti.com>
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

Add netdev ops for rpmsg-eth driver. This patch introduces the netdev
operations for the rpmsg-eth driver, enabling the driver to interact
with the Linux networking stack. The following functionalities are
implemented:

1. `ndo_open` and `ndo_stop`:
	- Handles the initialization and cleanup of the network device
	  during open and stop operations.
	- Manages the state transitions of the rpmsg-eth driver.

2. `ndo_start_xmit`:
	- Implements the transmit functionality by copying data from the
	  skb to the shared memory buffer and updating the head index.

3. `ndo_set_mac_address`:
	- Allows setting the MAC address of the network device and sends
	  the updated MAC address to the remote processor.

4. RX Path:
	- Adds a timer-based mechanism to poll for received packets in
	  shared memory.
	- Implements NAPI-based packet processing to handle received
	  packets efficiently.

5. State Machine:
	- Introduces a state machine to manage the driver's state
	  transitions, such as PROBE, OPEN, READY, and RUNNING.

6. Initialization:
	- Adds necessary initialization for locks, timers, and work
	  structures.
	- Registers the network device and sets up NAPI and RX timer.

7. Cleanup:
	- Ensures proper cleanup of resources during driver removal,
	  including NAPI and timers.

This patch enhances the rpmsg-eth driver to function as a fully
operational network device in the Linux kernel.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/rpmsg_eth.c | 319 +++++++++++++++++++++++++++++++
 drivers/net/ethernet/rpmsg_eth.h |   2 +
 2 files changed, 321 insertions(+)

diff --git a/drivers/net/ethernet/rpmsg_eth.c b/drivers/net/ethernet/rpmsg_eth.c
index 26f9eee6aeec..4efa9b634f8b 100644
--- a/drivers/net/ethernet/rpmsg_eth.c
+++ b/drivers/net/ethernet/rpmsg_eth.c
@@ -130,6 +130,109 @@ static void rpmsg_eth_unmap_buffers(struct rpmsg_eth_port *port)
 	}
 }
 
+static int create_request(struct rpmsg_eth_common *common,
+			  enum rpmsg_eth_rpmsg_type rpmsg_type)
+{
+	struct message *msg = &common->send_msg;
+	int ret = 0;
+
+	msg->msg_hdr.src_id = common->port->port_id;
+	msg->req_msg.type = rpmsg_type;
+
+	switch (rpmsg_type) {
+	case RPMSG_ETH_REQ_SHM_INFO:
+		msg->msg_hdr.msg_type = RPMSG_ETH_REQUEST_MSG;
+		break;
+	case RPMSG_ETH_REQ_SET_MAC_ADDR:
+		msg->msg_hdr.msg_type = RPMSG_ETH_REQUEST_MSG;
+		ether_addr_copy(msg->req_msg.mac_addr.addr,
+				common->port->ndev->dev_addr);
+		break;
+	case RPMSG_ETH_NOTIFY_PORT_UP:
+	case RPMSG_ETH_NOTIFY_PORT_DOWN:
+		msg->msg_hdr.msg_type = RPMSG_ETH_NOTIFY_MSG;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(common->dev, "Invalid RPMSG request\n");
+	}
+	return ret;
+}
+
+static int rpmsg_eth_create_send_request(struct rpmsg_eth_common *common,
+					 enum rpmsg_eth_rpmsg_type rpmsg_type,
+					 bool wait)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	if (wait)
+		reinit_completion(&common->sync_msg);
+
+	spin_lock_irqsave(&common->send_msg_lock, flags);
+	ret = create_request(common, rpmsg_type);
+	if (ret)
+		goto release_lock;
+
+	ret = rpmsg_send(common->rpdev->ept, (void *)(&common->send_msg),
+			 sizeof(common->send_msg));
+	if (ret) {
+		dev_err(common->dev, "Failed to send RPMSG message\n");
+		goto release_lock;
+	}
+
+	spin_unlock_irqrestore(&common->send_msg_lock, flags);
+	if (wait) {
+		ret = wait_for_completion_timeout(&common->sync_msg,
+						  RPMSG_ETH_REQ_TIMEOUT_JIFFIES);
+
+		if (!ret) {
+			dev_err(common->dev, "Failed to receive response within %ld jiffies\n",
+				RPMSG_ETH_REQ_TIMEOUT_JIFFIES);
+			return -ETIMEDOUT;
+		}
+		ret = 0;
+	}
+	return ret;
+release_lock:
+	spin_unlock_irqrestore(&common->send_msg_lock, flags);
+	return ret;
+}
+
+static void rpmsg_eth_state_machine(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct rpmsg_eth_common *common;
+	struct rpmsg_eth_port *port;
+	int ret;
+
+	common = container_of(dwork, struct rpmsg_eth_common, state_work);
+	port = common->port;
+
+	mutex_lock(&common->state_lock);
+
+	switch (common->state) {
+	case RPMSG_ETH_STATE_PROBE:
+		break;
+	case RPMSG_ETH_STATE_OPEN:
+		rpmsg_eth_create_send_request(common, RPMSG_ETH_REQ_SHM_INFO, false);
+		break;
+	case RPMSG_ETH_STATE_CLOSE:
+		break;
+	case RPMSG_ETH_STATE_READY:
+		ret = rpmsg_eth_create_send_request(common, RPMSG_ETH_REQ_SET_MAC_ADDR, false);
+		if (!ret) {
+			napi_enable(&port->rx_napi);
+			netif_carrier_on(port->ndev);
+			mod_timer(&port->rx_timer, RX_POLL_TIMEOUT_JIFFIES);
+		}
+		break;
+	case RPMSG_ETH_STATE_RUNNING:
+		break;
+	}
+	mutex_unlock(&common->state_lock);
+}
+
 static int rpmsg_eth_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
 			      void *priv, u32 src)
 {
@@ -167,6 +270,17 @@ static int rpmsg_eth_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
 				rpmsg_eth_unmap_buffers(port);
 				return ret;
 			}
+
+			mutex_lock(&common->state_lock);
+			common->state = RPMSG_ETH_STATE_READY;
+			mutex_unlock(&common->state_lock);
+
+			mod_delayed_work(system_wq,
+					 &common->state_work,
+					 STATE_MACHINE_TIME_JIFFIES);
+
+			break;
+		case RPMSG_ETH_RESP_SET_MAC_ADDR:
 			break;
 		}
 		break;
@@ -174,6 +288,20 @@ static int rpmsg_eth_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
 		rpmsg_type = msg->notify_msg.type;
 		dev_dbg(common->dev, "Msg type = %d, RPMsg type = %d, Src Id = %d, Msg Id = %d\n",
 			msg_type, rpmsg_type, msg->msg_hdr.src_id, msg->notify_msg.id);
+		switch (rpmsg_type) {
+		case RPMSG_ETH_NOTIFY_REMOTE_READY:
+			mutex_lock(&common->state_lock);
+			common->state = RPMSG_ETH_STATE_RUNNING;
+			mutex_unlock(&common->state_lock);
+
+			mod_delayed_work(system_wq,
+					 &common->state_work,
+					 STATE_MACHINE_TIME_JIFFIES);
+			break;
+		case RPMSG_ETH_NOTIFY_PORT_UP:
+		case RPMSG_ETH_NOTIFY_PORT_DOWN:
+			break;
+		}
 		break;
 	default:
 		dev_err(common->dev, "Invalid msg type\n");
@@ -233,6 +361,185 @@ static int rpmsg_eth_get_shm_info(struct rpmsg_eth_common *common)
 	return 0;
 }
 
+static void rpmsg_eth_rx_timer(struct timer_list *timer)
+{
+	struct rpmsg_eth_port *port = timer_container_of(port, timer, rx_timer);
+	struct napi_struct *napi;
+	int num_pkts = 0;
+	u32 head, tail;
+
+	head = port->rx_buffer->head->index;
+	tail = port->rx_buffer->tail->index;
+
+	num_pkts = tail - head;
+	num_pkts = num_pkts >= 0 ? num_pkts :
+				   (num_pkts + port->rpmsg_eth_rx_max_buffers);
+
+	napi = &port->rx_napi;
+	if (num_pkts && likely(napi_schedule_prep(napi)))
+		__napi_schedule(napi);
+	else
+		mod_timer(&port->rx_timer, RX_POLL_JIFFIES);
+}
+
+static int rpmsg_eth_rx_packets(struct napi_struct *napi, int budget)
+{
+	struct rpmsg_eth_port *port = container_of(napi, struct rpmsg_eth_port, rx_napi);
+	u32 count, process_pkts;
+	struct sk_buff *skb;
+	u32 head, tail;
+	int num_pkts;
+	u32 pkt_len;
+
+	head = port->rx_buffer->head->index;
+	tail = port->rx_buffer->tail->index;
+
+	num_pkts = head - tail;
+
+	num_pkts = num_pkts >= 0 ? num_pkts :
+				   (num_pkts + port->rpmsg_eth_rx_max_buffers);
+	process_pkts = min(num_pkts, budget);
+	count = 0;
+	while (count < process_pkts) {
+		memcpy_fromio((void *)&pkt_len,
+			      (void __iomem *)(port->rx_buffer->buf->base_addr +
+			      MAGIC_NUM_SIZE_TYPE +
+			      (((tail + count) % port->rpmsg_eth_rx_max_buffers) *
+			      RPMSG_ETH_BUFFER_SIZE)),
+			      PKT_LEN_SIZE_TYPE);
+		/* Start building the skb */
+		skb = napi_alloc_skb(napi, pkt_len);
+		if (!skb) {
+			port->ndev->stats.rx_dropped++;
+			goto rx_dropped;
+		}
+
+		skb->dev = port->ndev;
+		skb_put(skb, pkt_len);
+		memcpy_fromio((void *)skb->data,
+			      (void __iomem *)(port->rx_buffer->buf->base_addr +
+			      PKT_LEN_SIZE_TYPE + MAGIC_NUM_SIZE_TYPE +
+			      (((tail + count) % port->rpmsg_eth_rx_max_buffers) *
+			      RPMSG_ETH_BUFFER_SIZE)),
+			      pkt_len);
+
+		skb->protocol = eth_type_trans(skb, port->ndev);
+
+		/* Push skb into network stack */
+		napi_gro_receive(napi, skb);
+
+		count++;
+		port->ndev->stats.rx_packets++;
+		port->ndev->stats.rx_bytes += skb->len;
+	}
+
+rx_dropped:
+
+	if (num_pkts) {
+		port->rx_buffer->tail->index =
+			(port->rx_buffer->tail->index + count) %
+			port->rpmsg_eth_rx_max_buffers;
+
+		if (num_pkts < budget && napi_complete_done(napi, count))
+			mod_timer(&port->rx_timer, RX_POLL_TIMEOUT_JIFFIES);
+	}
+
+	return count;
+}
+
+static int rpmsg_eth_ndo_open(struct net_device *ndev)
+{
+	struct rpmsg_eth_common *common = rpmsg_eth_ndev_to_common(ndev);
+
+	mutex_lock(&common->state_lock);
+	common->state = RPMSG_ETH_STATE_OPEN;
+	mutex_unlock(&common->state_lock);
+	mod_delayed_work(system_wq, &common->state_work, msecs_to_jiffies(100));
+
+	return 0;
+}
+
+static int rpmsg_eth_ndo_stop(struct net_device *ndev)
+{
+	struct rpmsg_eth_common *common = rpmsg_eth_ndev_to_common(ndev);
+	struct rpmsg_eth_port *port = rpmsg_eth_ndev_to_port(ndev);
+
+	mutex_lock(&common->state_lock);
+	common->state = RPMSG_ETH_STATE_CLOSE;
+	mutex_unlock(&common->state_lock);
+
+	netif_carrier_off(port->ndev);
+
+	cancel_delayed_work_sync(&common->state_work);
+	timer_delete_sync(&port->rx_timer);
+	napi_disable(&port->rx_napi);
+
+	return 0;
+}
+
+static netdev_tx_t rpmsg_eth_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct rpmsg_eth_port *port = rpmsg_eth_ndev_to_port(ndev);
+	u32 head, tail;
+	int num_pkts;
+	u32 len;
+
+	len = skb_headlen(skb);
+	head = port->tx_buffer->head->index;
+	tail = port->tx_buffer->tail->index;
+
+	/* If the buffer queue is full, then drop packet */
+	num_pkts = head - tail;
+	num_pkts = num_pkts >= 0 ? num_pkts :
+				   (num_pkts + port->rpmsg_eth_tx_max_buffers);
+
+	if ((num_pkts + 1) == port->rpmsg_eth_tx_max_buffers) {
+		netdev_warn(ndev, "Tx buffer full %d\n", num_pkts);
+		goto ring_full;
+	}
+	/* Copy length */
+	memcpy_toio((void __iomem *)port->tx_buffer->buf->base_addr +
+			    MAGIC_NUM_SIZE_TYPE +
+			    (port->tx_buffer->head->index * RPMSG_ETH_BUFFER_SIZE),
+		    (void *)&len, PKT_LEN_SIZE_TYPE);
+	/* Copy data to shared mem */
+	memcpy_toio((void __iomem *)(port->tx_buffer->buf->base_addr +
+			     MAGIC_NUM_SIZE_TYPE + PKT_LEN_SIZE_TYPE +
+			     (port->tx_buffer->head->index * RPMSG_ETH_BUFFER_SIZE)),
+		    (void *)skb->data, len);
+	port->tx_buffer->head->index =
+		(port->tx_buffer->head->index + 1) % port->rpmsg_eth_tx_max_buffers;
+
+	ndev->stats.tx_packets++;
+	ndev->stats.tx_bytes += skb->len;
+
+	dev_consume_skb_any(skb);
+	return NETDEV_TX_OK;
+
+ring_full:
+	return NETDEV_TX_BUSY;
+}
+
+static int rpmsg_eth_set_mac_address(struct net_device *ndev, void *addr)
+{
+	struct rpmsg_eth_common *common = rpmsg_eth_ndev_to_common(ndev);
+	int ret;
+
+	ret = eth_mac_addr(ndev, addr);
+
+	if (ret < 0)
+		return ret;
+	ret = rpmsg_eth_create_send_request(common, RPMSG_ETH_REQ_SET_MAC_ADDR, false);
+	return ret;
+}
+
+static const struct net_device_ops rpmsg_eth_netdev_ops = {
+	.ndo_open = rpmsg_eth_ndo_open,
+	.ndo_stop = rpmsg_eth_ndo_stop,
+	.ndo_start_xmit = rpmsg_eth_start_xmit,
+	.ndo_set_mac_address = rpmsg_eth_set_mac_address,
+};
+
 static int rpmsg_eth_init_ndev(struct rpmsg_eth_common *common)
 {
 	struct device *dev = &common->rpdev->dev;
@@ -256,6 +563,7 @@ static int rpmsg_eth_init_ndev(struct rpmsg_eth_common *common)
 
 	ndev_priv = netdev_priv(port->ndev);
 	ndev_priv->port = port;
+	port->ndev->netdev_ops = &rpmsg_eth_netdev_ops;
 	SET_NETDEV_DEV(port->ndev, dev);
 
 	port->ndev->min_mtu = RPMSG_ETH_MIN_PACKET_SIZE;
@@ -296,6 +604,8 @@ static int rpmsg_eth_init_ndev(struct rpmsg_eth_common *common)
 	}
 	netif_carrier_off(port->ndev);
 
+	netif_napi_add(port->ndev, &port->rx_napi, rpmsg_eth_rx_packets);
+	timer_setup(&port->rx_timer, rpmsg_eth_rx_timer, 0);
 	err = register_netdev(port->ndev);
 
 	if (err)
@@ -324,6 +634,12 @@ static int rpmsg_eth_probe(struct rpmsg_device *rpdev)
 	if (ret)
 		return ret;
 
+	spin_lock_init(&common->send_msg_lock);
+	spin_lock_init(&common->recv_msg_lock);
+	mutex_init(&common->state_lock);
+	INIT_DELAYED_WORK(&common->state_work, rpmsg_eth_state_machine);
+	init_completion(&common->sync_msg);
+
 	/* Register the network device */
 	ret = rpmsg_eth_init_ndev(common);
 	if (ret)
@@ -339,6 +655,9 @@ static void rpmsg_eth_rpmsg_remove(struct rpmsg_device *rpdev)
 
 	/* Unmap ioremap'd regions */
 	rpmsg_eth_unmap_buffers(port);
+
+	netif_napi_del(&port->rx_napi);
+	timer_delete_sync(&port->rx_timer);
 }
 
 static struct rpmsg_device_id rpmsg_eth_rpmsg_id_table[] = {
diff --git a/drivers/net/ethernet/rpmsg_eth.h b/drivers/net/ethernet/rpmsg_eth.h
index aa43030f3d72..d7e4d53c8de4 100644
--- a/drivers/net/ethernet/rpmsg_eth.h
+++ b/drivers/net/ethernet/rpmsg_eth.h
@@ -231,6 +231,7 @@ enum rpmsg_eth_state {
  * @dev: Device
  * @state: Interface state
  * @state_work: Delayed work for state machine
+ * @sync_msg: Completion for synchronous message
  */
 struct rpmsg_eth_common {
 	struct rpmsg_device *rpdev;
@@ -246,6 +247,7 @@ struct rpmsg_eth_common {
 	/** @state_lock: Lock for changing interface state */
 	struct mutex state_lock;
 	struct delayed_work state_work;
+	struct completion sync_msg;
 };
 
 /**
-- 
2.34.1


