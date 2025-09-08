Return-Path: <netdev+bounces-220756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BA3B487E2
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 11:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17801B226DF
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9857D2F617A;
	Mon,  8 Sep 2025 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Jw3khlMQ"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA52EFD86;
	Mon,  8 Sep 2025 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757322526; cv=none; b=eYsBQ5ucTubCee0T7ZFxtkwPHqX6ep9f29nuDMTVL1bQiyr8Nwen3G0hCpQOg83E8/hdehGD3es6bWJC5C3hdINdRLp5GDb33M0yNscqc/oXpGP2VhsbA/9OnqEf0tAkbtue0BZnZwafcEGltv7nMJWN4Svi71cCH0dsKzyg0Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757322526; c=relaxed/simple;
	bh=ytBbUnaDkglyk2NDImzK3GXjIWhFr7lNsSUjkaAjKDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDUYp8fSR5uP1V2dCHscd13VCTAX9C0dO3McRii0Gz3dbSvUb6+tIozes8IWNl/xxCd5phhQ87FBeZXrxQrmN2qpUNOsxcwWvuE1HxNIJXMwAKnSJtR2Mo9Mo7NaYJwAzlPZOMA8xBJcn1GWWXgVIhjXXtws/36SiZNNbAZcGWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Jw3khlMQ; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588983II022084;
	Mon, 8 Sep 2025 04:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757322483;
	bh=V4uev4C+g/5gO4Z/wqqE75ia4mxFhVAjpWTE6A0mn/c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Jw3khlMQAdWYHM/adfiiEHwW3doYdEl8t7w+vVcr9U1lNFwvdqBGM9YxYhecN50px
	 /Ur5lZYmohKbvw51fIg2qPkK6NZI7wKMmV+DJMqd3qhCcDHv/Fs7339OBw0SbjQQrH
	 xlQO7dep9EcXqbMOcXmWYpflz1M3YingeS5mtRYw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588982mA3666559
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 04:08:02 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 04:08:01 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 04:08:01 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588981dg2355846;
	Mon, 8 Sep 2025 04:08:01 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 588980A6023041;
	Mon, 8 Sep 2025 04:08:01 -0500
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
Subject: [PATCH net-next v3 5/7] net: rpmsg-eth: Add support for multicast filtering
Date: Mon, 8 Sep 2025 14:37:44 +0530
Message-ID: <20250908090746.862407-6-danishanwar@ti.com>
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

Add support for multicast filtering for RPMSG ETH driver. Implement the
ndo_set_rx_mode callback as icve_set_rx_mode() API. rx_mode_workqueue is
initialized in rpmsg_eth_probe() and queued in rpmsg_eth_set_rx_mode().

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/rpmsg_eth.c | 63 ++++++++++++++++++++++++++++++++
 drivers/net/ethernet/rpmsg_eth.h | 12 ++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/net/ethernet/rpmsg_eth.c b/drivers/net/ethernet/rpmsg_eth.c
index 211d1499f3d7..d491e28ce421 100644
--- a/drivers/net/ethernet/rpmsg_eth.c
+++ b/drivers/net/ethernet/rpmsg_eth.c
@@ -68,6 +68,11 @@ static int create_request(struct rpmsg_eth_common *common,
 		ether_addr_copy(msg->req_msg.mac_addr.addr,
 				common->port->ndev->dev_addr);
 		break;
+	case RPMSG_ETH_REQ_ADD_MC_ADDR:
+	case RPMSG_ETH_REQ_DEL_MC_ADDR:
+		ether_addr_copy(msg->req_msg.mac_addr.addr,
+				common->mcast_addr);
+		break;
 	case RPMSG_ETH_NOTIFY_PORT_UP:
 	case RPMSG_ETH_NOTIFY_PORT_DOWN:
 		msg->msg_hdr.msg_type = RPMSG_ETH_NOTIFY_MSG;
@@ -119,6 +124,22 @@ static int rpmsg_eth_create_send_request(struct rpmsg_eth_common *common,
 	return ret;
 }
 
+static int rpmsg_eth_add_mc_addr(struct net_device *ndev, const u8 *addr)
+{
+	struct rpmsg_eth_common *common = rpmsg_eth_ndev_to_common(ndev);
+
+	ether_addr_copy(common->mcast_addr, addr);
+	return rpmsg_eth_create_send_request(common, RPMSG_ETH_REQ_ADD_MC_ADDR, true);
+}
+
+static int rpmsg_eth_del_mc_addr(struct net_device *ndev, const u8 *addr)
+{
+	struct rpmsg_eth_common *common = rpmsg_eth_ndev_to_common(ndev);
+
+	ether_addr_copy(common->mcast_addr, addr);
+	return rpmsg_eth_create_send_request(common, RPMSG_ETH_REQ_DEL_MC_ADDR, true);
+}
+
 static void rpmsg_eth_state_machine(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
@@ -201,6 +222,10 @@ static int rpmsg_eth_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
 			break;
 		case RPMSG_ETH_RESP_SET_MAC_ADDR:
 			break;
+		case RPMSG_ETH_RESP_ADD_MC_ADDR:
+		case RPMSG_ETH_RESP_DEL_MC_ADDR:
+			complete(&common->sync_msg);
+			break;
 		}
 		break;
 	case RPMSG_ETH_NOTIFY_MSG:
@@ -393,10 +418,15 @@ static int rpmsg_eth_ndo_stop(struct net_device *ndev)
 
 	netif_carrier_off(port->ndev);
 
+	__dev_mc_unsync(ndev, rpmsg_eth_del_mc_addr);
+	__hw_addr_init(&common->mc_list);
+
 	cancel_delayed_work_sync(&common->state_work);
 	timer_delete_sync(&port->rx_timer);
 	napi_disable(&port->rx_napi);
 
+	cancel_work_sync(&common->rx_mode_work);
+
 	return 0;
 }
 
@@ -453,10 +483,35 @@ static int rpmsg_eth_set_mac_address(struct net_device *ndev, void *addr)
 	return ret;
 }
 
+static void rpmsg_eth_ndo_set_rx_mode_work(struct work_struct *work)
+{
+	struct rpmsg_eth_common *common;
+	struct net_device *ndev;
+
+	common = container_of(work, struct rpmsg_eth_common, rx_mode_work);
+	ndev = common->port->ndev;
+
+	/* make a mc list copy */
+	netif_addr_lock_bh(ndev);
+	__hw_addr_sync(&common->mc_list, &ndev->mc, ndev->addr_len);
+	netif_addr_unlock_bh(ndev);
+
+	__hw_addr_sync_dev(&common->mc_list, ndev, rpmsg_eth_add_mc_addr,
+			   rpmsg_eth_del_mc_addr);
+}
+
+static void rpmsg_eth_set_rx_mode(struct net_device *ndev)
+{
+	struct rpmsg_eth_common *common = rpmsg_eth_ndev_to_common(ndev);
+
+	queue_work(common->cmd_wq, &common->rx_mode_work);
+}
+
 static const struct net_device_ops rpmsg_eth_netdev_ops = {
 	.ndo_open = rpmsg_eth_ndo_open,
 	.ndo_stop = rpmsg_eth_ndo_stop,
 	.ndo_start_xmit = rpmsg_eth_start_xmit,
+	.ndo_set_rx_mode = rpmsg_eth_set_rx_mode,
 	.ndo_set_mac_address = rpmsg_eth_set_mac_address,
 };
 
@@ -533,6 +588,13 @@ static int rpmsg_eth_probe(struct rpmsg_device *rpdev)
 	INIT_DELAYED_WORK(&common->state_work, rpmsg_eth_state_machine);
 	init_completion(&common->sync_msg);
 
+	__hw_addr_init(&common->mc_list);
+	INIT_WORK(&common->rx_mode_work, rpmsg_eth_ndo_set_rx_mode_work);
+	common->cmd_wq = create_singlethread_workqueue("rpmsg_eth_rx_work");
+	if (!common->cmd_wq) {
+		dev_err(dev, "Failure requesting workqueue\n");
+		return -ENOMEM;
+	}
 	/* Register the network device */
 	ret = rpmsg_eth_init_ndev(common);
 	if (ret)
@@ -548,6 +610,7 @@ static void rpmsg_eth_remove(struct rpmsg_device *rpdev)
 
 	netif_napi_del(&port->rx_napi);
 	timer_delete_sync(&port->rx_timer);
+	destroy_workqueue(common->cmd_wq);
 
 	dev_dbg(&rpdev->dev, "rpmsg-eth client driver is removed\n");
 }
diff --git a/drivers/net/ethernet/rpmsg_eth.h b/drivers/net/ethernet/rpmsg_eth.h
index b741407b216b..09fc6528daa5 100644
--- a/drivers/net/ethernet/rpmsg_eth.h
+++ b/drivers/net/ethernet/rpmsg_eth.h
@@ -57,10 +57,14 @@ enum rpmsg_eth_rpmsg_type {
 	/* Request types */
 	RPMSG_ETH_REQ_SHM_INFO = 0,
 	RPMSG_ETH_REQ_SET_MAC_ADDR,
+	RPMSG_ETH_REQ_ADD_MC_ADDR,
+	RPMSG_ETH_REQ_DEL_MC_ADDR,
 
 	/* Response types */
 	RPMSG_ETH_RESP_SHM_INFO,
 	RPMSG_ETH_RESP_SET_MAC_ADDR,
+	RPMSG_ETH_RESP_ADD_MC_ADDR,
+	RPMSG_ETH_RESP_DEL_MC_ADDR,
 
 	/* Notification types */
 	RPMSG_ETH_NOTIFY_PORT_UP,
@@ -219,6 +223,10 @@ enum rpmsg_eth_state {
  * @state: Interface state
  * @state_work: Delayed work for state machine
  * @sync_msg: Completion for synchronous message
+ * @rx_mode_work: Work structure for rx mode
+ * @cmd_wq: Workqueue for commands
+ * @mc_list: List of multicast addresses
+ * @mcast_addr: Multicast address filter
  */
 struct rpmsg_eth_common {
 	struct rpmsg_device *rpdev;
@@ -236,6 +244,10 @@ struct rpmsg_eth_common {
 	struct mutex state_lock;
 	struct delayed_work state_work;
 	struct completion sync_msg;
+	struct work_struct rx_mode_work;
+	struct workqueue_struct *cmd_wq;
+	struct netdev_hw_addr_list mc_list;
+	u8 mcast_addr[ETH_ALEN];
 };
 
 /**
-- 
2.34.1


