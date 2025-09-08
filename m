Return-Path: <netdev+bounces-220759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73059B487F3
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 11:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9301776F4
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4AD2FB988;
	Mon,  8 Sep 2025 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bSD+fSDq"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF172FB0A6;
	Mon,  8 Sep 2025 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322532; cv=none; b=TNOCBp1aZPUk/v37Wxct13btakrErH75ljx8kUXaRIxc6s6xP06IzRyYFcjE9nn4/8VG/F4RnFOqggfholORr5sT4ajmVdvzV8oNXUMzohW6vPzK1pZHDDtc2Atszt3AUWVqeyvAY00w3y+WeKRWxPfAibeQlcTl+GXJbdae9PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322532; c=relaxed/simple;
	bh=f268JepUj79CSvfyvL3vf0I0fZ9d/I2BmfWjbBQM3RU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VmatzwFrOXHFWuCWFMVnfdeGpQKHfPJLZTubxiVWNbXjA5/u0xmeIWQFufD38IZOA5Lm7Omi6euvWj2vMUJ+6aVtjaIUcHmf8rNKCBEyhoas1FEVx/h1GgEhvvRtdx9jdtn7TXroYr5ZMFiyk52QDiEQSXZp0C7DeBd8VENiLzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bSD+fSDq; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588980pi3834399;
	Mon, 8 Sep 2025 04:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757322480;
	bh=NkAf9VmrM84S/iiWeg1yFOSkop+ObLDvLnj0H7RvAxk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bSD+fSDqXOHgh+MsbY/2uDk0e/0w6QtWDjOgZag5vXsfaENxLjfzBj8y8ekTPgVhp
	 WTgWPomAKlpklHukY2ZiQtsK/NzJjs3JaBP2ZSYaXCQmBPNYcby+GCdZP3O8AiohOc
	 3vFvhUzl3uIE+6sQomY4JJKQG46WuqojDZUdmGrc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588980tN3666478
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 04:08:00 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 04:07:59 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 04:07:59 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58897xmc2298629;
	Mon, 8 Sep 2025 04:07:59 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 58897w4F023036;
	Mon, 8 Sep 2025 04:07:59 -0500
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
Subject: [PATCH net-next v3 4/7] net: rpmsg-eth: Add netdev ops
Date: Mon, 8 Sep 2025 14:37:43 +0530
Message-ID: <20250908090746.862407-5-danishanwar@ti.com>
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
 drivers/net/ethernet/rpmsg_eth.c | 318 +++++++++++++++++++++++++++++++
 drivers/net/ethernet/rpmsg_eth.h |   2 +
 2 files changed, 320 insertions(+)

diff --git a/drivers/net/ethernet/rpmsg_eth.c b/drivers/net/ethernet/rpmsg_eth.c
index bcbcfca37379..211d1499f3d7 100644
--- a/drivers/net/ethernet/rpmsg_eth.c
+++ b/drivers/net/ethernet/rpmsg_eth.c
@@ -50,6 +50,109 @@ static int rpmsg_eth_validate_handshake(struct rpmsg_eth_port *port,
 	return 0;
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
@@ -86,6 +189,17 @@ static int rpmsg_eth_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
 				dev_err(common->dev, "RPMSG handshake failed %d\n", ret);
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
@@ -93,6 +207,20 @@ static int rpmsg_eth_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
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
@@ -157,6 +285,181 @@ static int rpmsg_eth_get_shm_info(struct rpmsg_eth_common *common)
 	return 0;
 }
 
+static void rpmsg_eth_rx_timer(struct timer_list *timer)
+{
+	struct rpmsg_eth_port *port = timer_container_of(port, timer, rx_timer);
+	struct napi_struct *napi;
+	int num_pkts = 0;
+	u32 head, tail;
+
+	head = readl(port->shm + port->rx_offset + HEAD_IDX_OFFSET);
+	tail = readl(port->shm + port->rx_offset +
+		     TAIL_IDX_OFFSET(port->rx_max_buffers));
+
+	num_pkts = tail - head;
+	num_pkts = num_pkts >= 0 ? num_pkts :
+				   (num_pkts + port->rx_max_buffers);
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
+	head = readl(port->shm + port->rx_offset + HEAD_IDX_OFFSET);
+	tail = readl(port->shm + port->rx_offset +
+		     TAIL_IDX_OFFSET(port->rx_max_buffers));
+
+	num_pkts = head - tail;
+
+	num_pkts = num_pkts >= 0 ? num_pkts :
+				   (num_pkts + port->rx_max_buffers);
+	process_pkts = min(num_pkts, budget);
+	count = 0;
+	while (count < process_pkts) {
+		memcpy_fromio((void *)&pkt_len,
+			      port->shm + port->rx_offset + MAGIC_NUM_SIZE_TYPE +
+			      PKT_START_OFFSET((tail + count) % port->rx_max_buffers),
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
+			      port->shm + port->rx_offset + PKT_LEN_SIZE_TYPE +
+			      MAGIC_NUM_SIZE_TYPE +
+			      PKT_START_OFFSET((tail + count) % port->rx_max_buffers),
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
+		writel((tail + count) % port->rx_max_buffers,
+		       port->shm + port->rx_offset +
+		       TAIL_IDX_OFFSET(port->rx_max_buffers));
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
+	head = readl(port->shm + port->tx_offset + HEAD_IDX_OFFSET);
+	tail = readl(port->shm + port->tx_offset +
+		     TAIL_IDX_OFFSET(port->tx_max_buffers));
+
+	/* If the buffer queue is full, then drop packet */
+	num_pkts = head - tail;
+	num_pkts = num_pkts >= 0 ? num_pkts :
+				   (num_pkts + port->tx_max_buffers);
+
+	if ((num_pkts + 1) == port->tx_max_buffers) {
+		netdev_warn(ndev, "Tx buffer full %d\n", num_pkts);
+		goto ring_full;
+	}
+	/* Copy length */
+	memcpy_toio(port->shm + port->tx_offset + PKT_START_OFFSET(head) + MAGIC_NUM_SIZE_TYPE,
+		    (void *)&len, PKT_LEN_SIZE_TYPE);
+	/* Copy data to shared mem */
+	memcpy_toio(port->shm + port->tx_offset + PKT_START_OFFSET(head) + MAGIC_NUM_SIZE_TYPE +
+		    PKT_LEN_SIZE_TYPE, (void *)skb->data, len);
+	writel((head + 1) % port->tx_max_buffers,
+	       port->shm + port->tx_offset + HEAD_IDX_OFFSET);
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
@@ -180,6 +483,7 @@ static int rpmsg_eth_init_ndev(struct rpmsg_eth_common *common)
 
 	ndev_priv = netdev_priv(port->ndev);
 	ndev_priv->port = port;
+	port->ndev->netdev_ops = &rpmsg_eth_netdev_ops;
 	SET_NETDEV_DEV(port->ndev, dev);
 
 	port->ndev->min_mtu = RPMSG_ETH_MIN_PACKET_SIZE;
@@ -191,6 +495,8 @@ static int rpmsg_eth_init_ndev(struct rpmsg_eth_common *common)
 	}
 
 	netif_carrier_off(port->ndev);
+	netif_napi_add(port->ndev, &port->rx_napi, rpmsg_eth_rx_packets);
+	timer_setup(&port->rx_timer, rpmsg_eth_rx_timer, 0);
 	err = register_netdev(port->ndev);
 	if (err)
 		dev_err(dev, "error registering rpmsg_eth net device %d\n", err);
@@ -221,6 +527,12 @@ static int rpmsg_eth_probe(struct rpmsg_device *rpdev)
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
@@ -231,6 +543,12 @@ static int rpmsg_eth_probe(struct rpmsg_device *rpdev)
 
 static void rpmsg_eth_remove(struct rpmsg_device *rpdev)
 {
+	struct rpmsg_eth_common *common = dev_get_drvdata(&rpdev->dev);
+	struct rpmsg_eth_port *port = common->port;
+
+	netif_napi_del(&port->rx_napi);
+	timer_delete_sync(&port->rx_timer);
+
 	dev_dbg(&rpdev->dev, "rpmsg-eth client driver is removed\n");
 }
 
diff --git a/drivers/net/ethernet/rpmsg_eth.h b/drivers/net/ethernet/rpmsg_eth.h
index 3925a9ef1e3c..b741407b216b 100644
--- a/drivers/net/ethernet/rpmsg_eth.h
+++ b/drivers/net/ethernet/rpmsg_eth.h
@@ -218,6 +218,7 @@ enum rpmsg_eth_state {
  * @data: Vendor specific data
  * @state: Interface state
  * @state_work: Delayed work for state machine
+ * @sync_msg: Completion for synchronous message
  */
 struct rpmsg_eth_common {
 	struct rpmsg_device *rpdev;
@@ -234,6 +235,7 @@ struct rpmsg_eth_common {
 	/** @state_lock: Lock for changing interface state */
 	struct mutex state_lock;
 	struct delayed_work state_work;
+	struct completion sync_msg;
 };
 
 /**
-- 
2.34.1


