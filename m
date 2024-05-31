Return-Path: <netdev+bounces-99654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DF48D5A9B
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A145CB2248B
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 06:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2E280BF8;
	Fri, 31 May 2024 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oGf30QZf"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E727FBDA;
	Fri, 31 May 2024 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717137638; cv=none; b=AqCa8uZYmRemA+OJqrQKKKSl1E2uoifdWqB14LXdWN6VmnNkvomnTGoN/E71CcECiooX9ELmc766ejbT4rLFK3rfC956B36SaEQuWfq+nSDJrq8aHAmgsc1YOO3OCijh0sSjuVKt8JIC2UzuoZVUuAoat0C1vyN1HHrocd/0b+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717137638; c=relaxed/simple;
	bh=h+TmwJdb0au4o4PcmhmUMCB7xgKtC9q9x+NtgL8BqPg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kh6sMzTqJ95ab7bfc7Fwptibp4N49dDuGu62uoANHM1c6RC3BzLhfPvK0SK+DN2QOuTHaXt30EJAJtYUevFq6nb4Kjb3aPqwhT/VrbgAqjcJm5VUB6zAekUnBUESuhTW6KKKr3FD22Ghd97Ux7LzHu5GZGUDc7KvNJCzxOkt7+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oGf30QZf; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44V6eCFg014191;
	Fri, 31 May 2024 01:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717137612;
	bh=9BTR6DzLiXvh2kynrdXzcD7GtcON45T7V8zeKgdBDUw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=oGf30QZfoE/jc+1sIBvb9OYmiD2Gp3Hz/R5XjeD5sa2p7P58ggO2zNVleVTG9bW4T
	 yFvQpWhe0JMpWXFSirmStVIItjJiGiGiG7+lv1pX6jYUo3BexdO8xLN8nBqeev2Jj2
	 ROtIqa3Sd1SeopiSX02jHzYE+XiuX37gvDsBEess=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44V6eCt8065464
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 May 2024 01:40:12 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 01:40:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 01:40:12 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44V6eCft086120;
	Fri, 31 May 2024 01:40:12 -0500
Received: from localhost (linux-team-01.dhcp.ti.com [172.24.227.57])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44V6eB0U010391;
	Fri, 31 May 2024 01:40:12 -0500
From: Yojana Mallik <y-mallik@ti.com>
To: <y-mallik@ti.com>, <schnelle@linux.ibm.com>,
        <wsa+renesas@sang-engineering.com>, <diogo.ivo@siemens.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>, <vigneshr@ti.com>,
        <rogerq@ti.com>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        <rogerq@kernel.org>
Subject: [PATCH net-next v2 2/3] net: ethernet: ti: Register the RPMsg driver as network device
Date: Fri, 31 May 2024 12:10:05 +0530
Message-ID: <20240531064006.1223417-3-y-mallik@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240531064006.1223417-1-y-mallik@ti.com>
References: <20240531064006.1223417-1-y-mallik@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Register the RPMsg driver as network device and add support for
basic ethernet functionality by using the shared memory for data
plane.

The shared memory layout is as below, with the region between
PKT_1_LEN to PKT_N modelled as circular buffer.

-------------------------
|          HEAD         |
-------------------------
|          TAIL         |
-------------------------
|       PKT_1_LEN       |
|         PKT_1         |
-------------------------
|       PKT_2_LEN       |
|         PKT_2         |
-------------------------
|           .           |
|           .           |
-------------------------
|       PKT_N_LEN       |
|         PKT_N         |
-------------------------

The offset between the HEAD and TAIL is polled to process the Rx packets.

Signed-off-by: Yojana Mallik <y-mallik@ti.com>
---
 drivers/net/ethernet/ti/icve_rpmsg_common.h   |  86 ++++
 drivers/net/ethernet/ti/inter_core_virt_eth.c | 453 +++++++++++++++++-
 drivers/net/ethernet/ti/inter_core_virt_eth.h |  35 +-
 3 files changed, 570 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/icve_rpmsg_common.h b/drivers/net/ethernet/ti/icve_rpmsg_common.h
index 7cd157479d4d..2e3833de14bd 100644
--- a/drivers/net/ethernet/ti/icve_rpmsg_common.h
+++ b/drivers/net/ethernet/ti/icve_rpmsg_common.h
@@ -15,14 +15,58 @@ enum icve_msg_type {
 	ICVE_NOTIFY_MSG,
 };
 
+enum icve_rpmsg_type {
+	/* Request types */
+	ICVE_REQ_SHM_INFO = 0,
+	ICVE_REQ_SET_MAC_ADDR,
+
+	/* Response types */
+	ICVE_RESP_SHM_INFO,
+	ICVE_RESP_SET_MAC_ADDR,
+
+	/* Notification types */
+	ICVE_NOTIFY_PORT_UP,
+	ICVE_NOTIFY_PORT_DOWN,
+	ICVE_NOTIFY_PORT_READY,
+	ICVE_NOTIFY_REMOTE_READY,
+};
+
+struct icve_shm_info {
+	/* Total shared memory size */
+	u32 total_shm_size;
+	/* Total number of buffers */
+	u32 num_pkt_bufs;
+	/* Per buff slot size i.e MTU Size + 4 bytes for magic number + 4 bytes
+	 * for Pkt len
+	 */
+	u32 buff_slot_size;
+	/* Base Address for Tx or Rx shared memory */
+	u32 base_addr;
+} __packed;
+
+struct icve_shm {
+	struct icve_shm_info shm_info_tx;
+	struct icve_shm_info shm_info_rx;
+} __packed;
+
+struct icve_mac_addr {
+	char addr[ETH_ALEN];
+} __packed;
+
 struct request_message {
 	u32 type; /* Request Type */
 	u32 id;	  /* Request ID */
+	union {
+		struct icve_mac_addr mac_addr;
+	};
 } __packed;
 
 struct response_message {
 	u32 type;	/* Response Type */
 	u32 id;		/* Response ID */
+	union {
+		struct icve_shm shm_info;
+	};
 } __packed;
 
 struct notify_message {
@@ -44,4 +88,46 @@ struct message {
 	};
 } __packed;
 
+/*      Shared Memory Layout
+ *
+ *	---------------------------	*****************
+ *	|        MAGIC_NUM        |	 icve_shm_head
+ *	|          HEAD           |
+ *	---------------------------	*****************
+ *	|        MAGIC_NUM        |
+ *	|        PKT_1_LEN        |
+ *	|          PKT_1          |
+ *	---------------------------
+ *	|        MAGIC_NUM        |
+ *	|        PKT_2_LEN        |	 icve_shm_buf
+ *	|          PKT_2          |
+ *	---------------------------
+ *	|           .             |
+ *	|           .             |
+ *	---------------------------
+ *	|        MAGIC_NUM        |
+ *	|        PKT_N_LEN        |
+ *	|          PKT_N          |
+ *	---------------------------	****************
+ *	|        MAGIC_NUM        |      icve_shm_tail
+ *	|          TAIL           |
+ *	---------------------------	****************
+ */
+
+struct icve_shm_index {
+	u32 magic_num;
+	u32 index;
+}  __packed;
+
+struct icve_shm_buf {
+	char __iomem *base_addr;	/* start addr of first buffer */
+	u32 magic_num;
+} __packed;
+
+struct icve_shared_mem {
+	struct icve_shm_index __iomem *head;
+	struct icve_shm_buf __iomem *buf;
+	struct icve_shm_index __iomem *tail;
+} __packed;
+
 #endif /* __ICVE_RPMSG_COMMON_H__ */
diff --git a/drivers/net/ethernet/ti/inter_core_virt_eth.c b/drivers/net/ethernet/ti/inter_core_virt_eth.c
index bea822d2373a..d96547d317fe 100644
--- a/drivers/net/ethernet/ti/inter_core_virt_eth.c
+++ b/drivers/net/ethernet/ti/inter_core_virt_eth.c
@@ -6,11 +6,145 @@
 
 #include "inter_core_virt_eth.h"
 
+#define ICVE_MIN_PACKET_SIZE ETH_ZLEN
+#define ICVE_MAX_PACKET_SIZE 1540 //(ETH_FRAME_LEN + ETH_FCS_LEN)
+#define ICVE_MAX_TX_QUEUES 1
+#define ICVE_MAX_RX_QUEUES 1
+
+#define PKT_LEN_SIZE_TYPE sizeof(u32)
+#define MAGIC_NUM_SIZE_TYPE sizeof(u32)
+
+/* 4 bytes to hold packet length and ICVE_MAX_PACKET_SIZE to hold packet */
+#define ICVE_BUFFER_SIZE \
+	(ICVE_MAX_PACKET_SIZE + PKT_LEN_SIZE_TYPE + MAGIC_NUM_SIZE_TYPE)
+
+#define RX_POLL_TIMEOUT 1000 /* 1000usec */
+#define RX_POLL_JIFFIES (jiffies + usecs_to_jiffies(RX_POLL_TIMEOUT))
+
+#define STATE_MACHINE_TIME msecs_to_jiffies(100)
+#define ICVE_REQ_TIMEOUT msecs_to_jiffies(100)
+
+#define icve_ndev_to_priv(ndev) ((struct icve_ndev_priv *)netdev_priv(ndev))
+#define icve_ndev_to_port(ndev) (icve_ndev_to_priv(ndev)->port)
+#define icve_ndev_to_common(ndev) (icve_ndev_to_port(ndev)->common)
+
+static int create_request(struct icve_common *common,
+			  enum icve_rpmsg_type rpmsg_type)
+{
+	struct message *msg = &common->send_msg;
+	int ret = 0;
+
+	msg->msg_hdr.src_id = common->port->port_id;
+	msg->req_msg.type = rpmsg_type;
+
+	switch (rpmsg_type) {
+	case ICVE_REQ_SHM_INFO:
+		msg->msg_hdr.msg_type = ICVE_REQUEST_MSG;
+		break;
+	case ICVE_REQ_SET_MAC_ADDR:
+		msg->msg_hdr.msg_type = ICVE_REQUEST_MSG;
+		ether_addr_copy(msg->req_msg.mac_addr.addr,
+				common->port->ndev->dev_addr);
+		break;
+	case ICVE_NOTIFY_PORT_UP:
+	case ICVE_NOTIFY_PORT_DOWN:
+		msg->msg_hdr.msg_type = ICVE_NOTIFY_MSG;
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(common->dev, "Invalid RPMSG request\n");
+	};
+	return ret;
+}
+
+static int icve_create_send_request(struct icve_common *common,
+				    enum icve_rpmsg_type rpmsg_type,
+				    bool wait)
+{
+	unsigned long flags;
+	int ret;
+
+	if (wait)
+		reinit_completion(&common->sync_msg);
+
+	spin_lock_irqsave(&common->send_msg_lock, flags);
+	create_request(common, rpmsg_type);
+	rpmsg_send(common->rpdev->ept, (void *)(&common->send_msg),
+		   sizeof(common->send_msg));
+	spin_unlock_irqrestore(&common->send_msg_lock, flags);
+
+	if (wait) {
+		ret = wait_for_completion_timeout(&common->sync_msg,
+						  ICVE_REQ_TIMEOUT);
+
+		if (!ret) {
+			dev_err(common->dev, "Failed to receive response within %ld jiffies\n",
+				ICVE_REQ_TIMEOUT);
+			ret = -ETIMEDOUT;
+			return ret;
+		}
+	}
+	return ret;
+}
+
+static void icve_state_machine(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct icve_common *common;
+	struct icve_port *port;
+
+	common = container_of(dwork, struct icve_common, state_work);
+	port = common->port;
+
+	mutex_lock(&common->state_lock);
+
+	switch (common->state) {
+	case ICVE_STATE_PROBE:
+		break;
+	case ICVE_STATE_OPEN:
+		icve_create_send_request(common, ICVE_REQ_SHM_INFO, false);
+		break;
+	case ICVE_STATE_CLOSE:
+		break;
+	case ICVE_STATE_READY:
+		icve_create_send_request(common, ICVE_REQ_SET_MAC_ADDR, false);
+		napi_enable(&port->rx_napi);
+		netif_carrier_on(port->ndev);
+		mod_timer(&port->rx_timer, RX_POLL_TIMEOUT);
+		break;
+	case ICVE_STATE_RUNNING:
+		break;
+	}
+	mutex_unlock(&common->state_lock);
+}
+
+static void icve_rx_timer(struct timer_list *timer)
+{
+	struct icve_port *port = from_timer(port, timer, rx_timer);
+	struct napi_struct *napi;
+	int num_pkts = 0;
+	u32 head, tail;
+
+	head = port->rx_buffer->head->index;
+	tail = port->rx_buffer->tail->index;
+
+	num_pkts = tail - head;
+	num_pkts = num_pkts >= 0 ? num_pkts :
+				   (num_pkts + port->icve_rx_max_buffers);
+
+	napi = &port->rx_napi;
+	if (num_pkts && likely(napi_schedule_prep(napi)))
+		__napi_schedule(napi);
+	else
+		mod_timer(&port->rx_timer, RX_POLL_JIFFIES);
+}
+
 static int icve_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
 			 void *priv, u32 src)
 {
 	struct icve_common *common = dev_get_drvdata(&rpdev->dev);
 	struct message *msg = (struct message *)data;
+	struct icve_port *port = common->port;
 	u32 msg_type = msg->msg_hdr.msg_type;
 	u32 rpmsg_type;
 
@@ -24,11 +158,79 @@ static int icve_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
 		rpmsg_type = msg->resp_msg.type;
 		dev_dbg(common->dev, "Msg type = %d; RPMsg type = %d\n",
 			msg_type, rpmsg_type);
+		switch (rpmsg_type) {
+		case ICVE_RESP_SHM_INFO:
+			/* Retrieve Tx and Rx shared memory info from msg */
+			port->tx_buffer->head =
+				ioremap(msg->resp_msg.shm_info.shm_info_tx.base_addr,
+					sizeof(*port->tx_buffer->head));
+
+			port->tx_buffer->buf->base_addr =
+				ioremap((msg->resp_msg.shm_info.shm_info_tx.base_addr +
+					sizeof(*port->tx_buffer->head)),
+					(msg->resp_msg.shm_info.shm_info_tx.num_pkt_bufs *
+					 msg->resp_msg.shm_info.shm_info_tx.buff_slot_size));
+
+			port->tx_buffer->tail =
+				ioremap(msg->resp_msg.shm_info.shm_info_tx.base_addr +
+					sizeof(*port->tx_buffer->head) +
+					(msg->resp_msg.shm_info.shm_info_tx.num_pkt_bufs *
+					msg->resp_msg.shm_info.shm_info_tx.buff_slot_size),
+					sizeof(*port->tx_buffer->tail));
+
+			port->icve_tx_max_buffers = msg->resp_msg.shm_info.shm_info_tx.num_pkt_bufs;
+
+			port->rx_buffer->head =
+				ioremap(msg->resp_msg.shm_info.shm_info_rx.base_addr,
+					sizeof(*port->rx_buffer->head));
+
+			port->rx_buffer->buf->base_addr =
+				ioremap(msg->resp_msg.shm_info.shm_info_rx.base_addr +
+					sizeof(*port->rx_buffer->head),
+					(msg->resp_msg.shm_info.shm_info_rx.num_pkt_bufs *
+					 msg->resp_msg.shm_info.shm_info_rx.buff_slot_size));
+
+			port->rx_buffer->tail =
+				ioremap(msg->resp_msg.shm_info.shm_info_rx.base_addr +
+					sizeof(*port->rx_buffer->head) +
+					(msg->resp_msg.shm_info.shm_info_rx.num_pkt_bufs *
+					msg->resp_msg.shm_info.shm_info_rx.buff_slot_size),
+					sizeof(*port->rx_buffer->tail));
+
+			port->icve_rx_max_buffers =
+				msg->resp_msg.shm_info.shm_info_rx.num_pkt_bufs;
+
+			mutex_lock(&common->state_lock);
+			common->state = ICVE_STATE_READY;
+			mutex_unlock(&common->state_lock);
+
+			mod_delayed_work(system_wq,
+					 &common->state_work,
+					 STATE_MACHINE_TIME);
+
+			break;
+		case ICVE_RESP_SET_MAC_ADDR:
+			break;
+		}
+
 		break;
+
 	case ICVE_NOTIFY_MSG:
 		rpmsg_type = msg->notify_msg.type;
-		dev_dbg(common->dev, "Msg type = %d; RPMsg type = %d\n",
-			msg_type, rpmsg_type);
+		switch (rpmsg_type) {
+		case ICVE_NOTIFY_REMOTE_READY:
+			mutex_lock(&common->state_lock);
+			common->state = ICVE_STATE_RUNNING;
+			mutex_unlock(&common->state_lock);
+
+			mod_delayed_work(system_wq,
+					 &common->state_work,
+					 STATE_MACHINE_TIME);
+			break;
+		case ICVE_NOTIFY_PORT_UP:
+		case ICVE_NOTIFY_PORT_DOWN:
+			break;
+		}
 		break;
 	default:
 		dev_err(common->dev, "Invalid msg type\n");
@@ -37,10 +239,242 @@ static int icve_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
 	return 0;
 }
 
+static int icve_rx_packets(struct napi_struct *napi, int budget)
+{
+	struct icve_port *port = container_of(napi, struct icve_port, rx_napi);
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
+				   (num_pkts + port->icve_rx_max_buffers);
+	process_pkts = min(num_pkts, budget);
+	count = 0;
+	while (count < process_pkts) {
+		memcpy_fromio((void *)&pkt_len,
+			      (void *)(port->rx_buffer->buf->base_addr +
+			      MAGIC_NUM_SIZE_TYPE +
+			      (((tail + count) % port->icve_rx_max_buffers) *
+			      ICVE_BUFFER_SIZE)),
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
+			      (void *)(port->rx_buffer->buf->base_addr +
+			      PKT_LEN_SIZE_TYPE + MAGIC_NUM_SIZE_TYPE +
+			      (((tail + count) % port->icve_rx_max_buffers) *
+			      ICVE_BUFFER_SIZE)),
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
+			port->icve_rx_max_buffers;
+
+		if (num_pkts < budget && napi_complete_done(napi, count))
+			mod_timer(&port->rx_timer, RX_POLL_TIMEOUT);
+	}
+
+	return count;
+}
+
+static int icve_ndo_open(struct net_device *ndev)
+{
+	struct icve_common *common = icve_ndev_to_common(ndev);
+
+	mutex_lock(&common->state_lock);
+	common->state = ICVE_STATE_OPEN;
+	mutex_unlock(&common->state_lock);
+	mod_delayed_work(system_wq, &common->state_work, msecs_to_jiffies(100));
+
+	return 0;
+}
+
+static int icve_ndo_stop(struct net_device *ndev)
+{
+	struct icve_common *common = icve_ndev_to_common(ndev);
+	struct icve_port *port = icve_ndev_to_port(ndev);
+
+	mutex_lock(&common->state_lock);
+	common->state = ICVE_STATE_CLOSE;
+	mutex_unlock(&common->state_lock);
+
+	netif_carrier_off(port->ndev);
+
+	__dev_mc_unsync(ndev, icve_del_mc_addr);
+	__hw_addr_init(&common->mc_list);
+
+	cancel_delayed_work_sync(&common->state_work);
+	del_timer_sync(&port->rx_timer);
+	napi_disable(&port->rx_napi);
+
+	cancel_work_sync(&common->rx_mode_work);
+
+	return 0;
+}
+
+static netdev_tx_t icve_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct icve_port *port = icve_ndev_to_port(ndev);
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
+				   (num_pkts + port->icve_tx_max_buffers);
+
+	if ((num_pkts + 1) == port->icve_tx_max_buffers) {
+		netdev_warn(ndev, "Tx buffer full %d\n", num_pkts);
+		goto ring_full;
+	}
+	/* Copy length */
+	memcpy_toio((void *)port->tx_buffer->buf->base_addr +
+			    MAGIC_NUM_SIZE_TYPE +
+			    (port->tx_buffer->head->index * ICVE_BUFFER_SIZE),
+		    (void *)&len, PKT_LEN_SIZE_TYPE);
+	/* Copy data to shared mem */
+	memcpy_toio((void *)(port->tx_buffer->buf->base_addr +
+			     MAGIC_NUM_SIZE_TYPE + PKT_LEN_SIZE_TYPE +
+			     (port->tx_buffer->head->index * ICVE_BUFFER_SIZE)),
+		    (void *)skb->data, len);
+	port->tx_buffer->head->index =
+		(port->tx_buffer->head->index + 1) % port->icve_tx_max_buffers;
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
+static int icve_set_mac_address(struct net_device *ndev, void *addr)
+{
+	struct icve_common *common = icve_ndev_to_common(ndev);
+	int ret;
+
+	ret = eth_mac_addr(ndev, addr);
+
+	if (ret < 0)
+		return ret;
+	icve_create_send_request(common, ICVE_REQ_SET_MAC_ADDR, false);
+	return ret;
+}
+
+static const struct net_device_ops icve_netdev_ops = {
+	.ndo_open = icve_ndo_open,
+	.ndo_stop = icve_ndo_stop,
+	.ndo_start_xmit = icve_start_xmit,
+	.ndo_set_mac_address = icve_set_mac_address,
+};
+
+static int icve_init_ndev(struct icve_common *common)
+{
+	struct device *dev = &common->rpdev->dev;
+	struct icve_ndev_priv *ndev_priv;
+	struct icve_port *port;
+	static u32 port_id;
+	int err;
+
+	port = common->port;
+	port->common = common;
+	port->port_id = port_id++;
+
+	port->ndev = devm_alloc_etherdev_mqs(common->dev, sizeof(*ndev_priv),
+					     ICVE_MAX_TX_QUEUES,
+					     ICVE_MAX_RX_QUEUES);
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
+	port->ndev->min_mtu = ICVE_MIN_PACKET_SIZE;
+	port->ndev->max_mtu = ICVE_MAX_PACKET_SIZE;
+	port->ndev->netdev_ops = &icve_netdev_ops;
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
+	};
+	netif_carrier_off(port->ndev);
+
+	netif_napi_add(port->ndev, &port->rx_napi, icve_rx_packets);
+	timer_setup(&port->rx_timer, icve_rx_timer, 0);
+	err = register_netdev(port->ndev);
+
+	if (err)
+		dev_err(dev, "error registering icve net device %d\n", err);
+	return 0;
+}
+
 static int icve_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *dev = &rpdev->dev;
 	struct icve_common *common;
+	int ret = 0;
 
 	common = devm_kzalloc(&rpdev->dev, sizeof(*common), GFP_KERNEL);
 	if (!common)
@@ -51,12 +485,27 @@ static int icve_rpmsg_probe(struct rpmsg_device *rpdev)
 	common->port = devm_kzalloc(dev, sizeof(*common->port), GFP_KERNEL);
 	common->dev = dev;
 	common->rpdev = rpdev;
+	common->state = ICVE_STATE_PROBE;
+	spin_lock_init(&common->send_msg_lock);
+	spin_lock_init(&common->recv_msg_lock);
+	mutex_init(&common->state_lock);
+	INIT_DELAYED_WORK(&common->state_work, icve_state_machine);
+	init_completion(&common->sync_msg);
 
+	/* Register the network device */
+	ret = icve_init_ndev(common);
+	if (ret)
+		return ret;
 	return 0;
 }
 
 static void icve_rpmsg_remove(struct rpmsg_device *rpdev)
 {
+	struct icve_common *common = dev_get_drvdata(&rpdev->dev);
+	struct icve_port *port = common->port;
+
+	netif_napi_del(&port->rx_napi);
+	del_timer_sync(&port->rx_timer);
 	dev_info(&rpdev->dev, "icve rpmsg client driver is removed\n");
 }
 
diff --git a/drivers/net/ethernet/ti/inter_core_virt_eth.h b/drivers/net/ethernet/ti/inter_core_virt_eth.h
index 91a3aba96996..4fc420cb9eab 100644
--- a/drivers/net/ethernet/ti/inter_core_virt_eth.h
+++ b/drivers/net/ethernet/ti/inter_core_virt_eth.h
@@ -14,14 +14,45 @@
 #include <linux/rpmsg.h>
 #include "icve_rpmsg_common.h"
 
+enum icve_state {
+	ICVE_STATE_PROBE,
+	ICVE_STATE_OPEN,
+	ICVE_STATE_CLOSE,
+	ICVE_STATE_READY,
+	ICVE_STATE_RUNNING,
+
+};
+
 struct icve_port {
+	struct icve_shared_mem *tx_buffer; /* Write buffer for data to be consumed remote side */
+	struct icve_shared_mem *rx_buffer; /* Read buffer for data to be consumed by this driver */
+	struct timer_list rx_timer;
 	struct icve_common *common;
-} __packed;
+	struct napi_struct rx_napi;
+	u8 local_mac_addr[ETH_ALEN];
+	struct net_device *ndev;
+	u32 icve_tx_max_buffers;
+	u32 icve_rx_max_buffers;
+	u32 port_id;
+};
 
 struct icve_common {
 	struct rpmsg_device *rpdev;
+	spinlock_t send_msg_lock; /* Acquire this lock while sending RPMsg */
+	spinlock_t recv_msg_lock; /* Acquire this lock while processing received RPMsg */
+	struct message send_msg;
+	struct message recv_msg;
 	struct icve_port *port;
 	struct device *dev;
-} __packed;
+	enum icve_state	state;
+	struct mutex state_lock; /* Lock to be used while changing the interface state */
+	struct delayed_work state_work;
+	struct completion sync_msg;
+};
+
+struct icve_ndev_priv {
+	struct icve_port *port;
+};
+
 
 #endif /* __INTER_CORE_VIRT_ETH_H__ */
-- 
2.40.1


