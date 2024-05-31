Return-Path: <netdev+bounces-99655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59BF8D5A9E
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8CF51C21560
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 06:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7524D80046;
	Fri, 31 May 2024 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tT1Cfucn"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA93381AB1;
	Fri, 31 May 2024 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717137647; cv=none; b=J/TOmKqeds8+pmAr5t1z5g2IjGPiruDpzeem+cIMkiYrJHf2jB7xjOAQzyy1LCtd+iZ2V69l5uMQQv3Qyj3R3H4EzrvVJO5h5uxI2JOGvUH4ajkljMGT8m0AL0+OA4QJOQE0iNJssRpNFrMCB1dtfdO0xKbp01ZHrP7XCtEpNC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717137647; c=relaxed/simple;
	bh=BDZ/2pu/Wld29GlvisviBxejydCCeYCwVZ9eZWychX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDtdOaBGniJgoeDdu49hdc3CxEj79c4HtY5uL8ngOWJeEnM/xVnBci1izCoy2lbdAXaMWKaOPYAoWsAROiXq3WE2MJqS2+tcYmzQFR5DrSe6Dm25c5Y1/qgJRX7ytoZrLSGeT5/UR8dnFK1f1801xnbC3QHHCx0chVAUR/U/3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tT1Cfucn; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44V6eEZR121219;
	Fri, 31 May 2024 01:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717137614;
	bh=VMk29xvgHcoMkTC1JSC7HJ1lS34whDEDzI6Xz/EqtPg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tT1Cfucn0nGv8Mj2f7o58udB3wvuIffIYwndujWpq+6OKQCZkiO4aMhawV/kqX7Ub
	 0+dNOB203GYksjnOgx1Jkg7drOge+l4T8aYe3j5VJ6ormN/p7LOcg+Xnq1mVTgw6pL
	 ZR8eDbdbv6Y5Tf0LnjM4nX84JA8WM1oDWDQVL3Mw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44V6eEYZ108428
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 May 2024 01:40:14 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 01:40:14 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 01:40:14 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44V6eEZN121499;
	Fri, 31 May 2024 01:40:14 -0500
Received: from localhost (linux-team-01.dhcp.ti.com [172.24.227.57])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44V6eDvX010395;
	Fri, 31 May 2024 01:40:14 -0500
From: Yojana Mallik <y-mallik@ti.com>
To: <y-mallik@ti.com>, <schnelle@linux.ibm.com>,
        <wsa+renesas@sang-engineering.com>, <diogo.ivo@siemens.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>, <vigneshr@ti.com>,
        <rogerq@ti.com>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        <rogerq@kernel.org>
Subject: [PATCH net-next v2 3/3] net: ethernet: ti: icve: Add support for multicast filtering
Date: Fri, 31 May 2024 12:10:06 +0530
Message-ID: <20240531064006.1223417-4-y-mallik@ti.com>
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

Add support for multicast filtering for ICVE driver. Implement the
ndo_set_rx_mode callback as icve_set_rx_mode() API. rx_mode_workqueue is
initialized in icve_rpmsg_probe() and queued in icve_set_rx_mode().

Signed-off-by: Yojana Mallik <y-mallik@ti.com>
---
 drivers/net/ethernet/ti/icve_rpmsg_common.h   |  4 ++
 drivers/net/ethernet/ti/inter_core_virt_eth.c | 63 ++++++++++++++++++-
 drivers/net/ethernet/ti/inter_core_virt_eth.h |  4 ++
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icve_rpmsg_common.h b/drivers/net/ethernet/ti/icve_rpmsg_common.h
index 2e3833de14bd..793baa93e135 100644
--- a/drivers/net/ethernet/ti/icve_rpmsg_common.h
+++ b/drivers/net/ethernet/ti/icve_rpmsg_common.h
@@ -19,10 +19,14 @@ enum icve_rpmsg_type {
 	/* Request types */
 	ICVE_REQ_SHM_INFO = 0,
 	ICVE_REQ_SET_MAC_ADDR,
+	ICVE_REQ_ADD_MC_ADDR,
+	ICVE_REQ_DEL_MC_ADDR,
 
 	/* Response types */
 	ICVE_RESP_SHM_INFO,
 	ICVE_RESP_SET_MAC_ADDR,
+	ICVE_RESP_ADD_MC_ADDR,
+	ICVE_RESP_DEL_MC_ADDR,
 
 	/* Notification types */
 	ICVE_NOTIFY_PORT_UP,
diff --git a/drivers/net/ethernet/ti/inter_core_virt_eth.c b/drivers/net/ethernet/ti/inter_core_virt_eth.c
index d96547d317fe..908425af0014 100644
--- a/drivers/net/ethernet/ti/inter_core_virt_eth.c
+++ b/drivers/net/ethernet/ti/inter_core_virt_eth.c
@@ -46,6 +46,11 @@ static int create_request(struct icve_common *common,
 		ether_addr_copy(msg->req_msg.mac_addr.addr,
 				common->port->ndev->dev_addr);
 		break;
+	case ICVE_REQ_ADD_MC_ADDR:
+	case ICVE_REQ_DEL_MC_ADDR:
+		ether_addr_copy(msg->req_msg.mac_addr.addr,
+				common->mcast_addr);
+		break;
 	case ICVE_NOTIFY_PORT_UP:
 	case ICVE_NOTIFY_PORT_DOWN:
 		msg->msg_hdr.msg_type = ICVE_NOTIFY_MSG;
@@ -87,6 +92,26 @@ static int icve_create_send_request(struct icve_common *common,
 	return ret;
 }
 
+static int icve_add_mc_addr(struct net_device *ndev, const u8 *addr)
+{
+	struct icve_common *common = icve_ndev_to_common(ndev);
+	int ret = 0;
+
+	ether_addr_copy(common->mcast_addr, addr);
+	icve_create_send_request(common, ICVE_REQ_ADD_MC_ADDR, true);
+	return ret;
+}
+
+static int icve_del_mc_addr(struct net_device *ndev, const u8 *addr)
+{
+	struct icve_common *common = icve_ndev_to_common(ndev);
+	int ret = 0;
+
+	ether_addr_copy(common->mcast_addr, addr);
+	icve_create_send_request(common, ICVE_REQ_DEL_MC_ADDR, true);
+	return ret;
+}
+
 static void icve_state_machine(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
@@ -211,6 +236,10 @@ static int icve_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
 			break;
 		case ICVE_RESP_SET_MAC_ADDR:
 			break;
+		case ICVE_RESP_ADD_MC_ADDR:
+		case ICVE_RESP_DEL_MC_ADDR:
+			complete(&common->sync_msg);
+			break;
 		}
 
 		break;
@@ -395,10 +424,35 @@ static int icve_set_mac_address(struct net_device *ndev, void *addr)
 	return ret;
 }
 
+static void icve_ndo_set_rx_mode_work(struct work_struct *work)
+{
+	struct icve_common *common;
+	struct net_device *ndev;
+
+	common = container_of(work, struct icve_common, rx_mode_work);
+	ndev = common->port->ndev;
+
+	/* make a mc list copy */
+	netif_addr_lock_bh(ndev);
+	__hw_addr_sync(&common->mc_list, &ndev->mc, ndev->addr_len);
+	netif_addr_unlock_bh(ndev);
+
+	__hw_addr_sync_dev(&common->mc_list, ndev, icve_add_mc_addr,
+			   icve_del_mc_addr);
+}
+
+static void icve_set_rx_mode(struct net_device *ndev)
+{
+	struct icve_common *common = icve_ndev_to_common(ndev);
+
+	queue_work(common->cmd_wq, &common->rx_mode_work);
+}
+
 static const struct net_device_ops icve_netdev_ops = {
 	.ndo_open = icve_ndo_open,
 	.ndo_stop = icve_ndo_stop,
 	.ndo_start_xmit = icve_start_xmit,
+	.ndo_set_rx_mode = icve_set_rx_mode,
 	.ndo_set_mac_address = icve_set_mac_address,
 };
 
@@ -491,7 +545,13 @@ static int icve_rpmsg_probe(struct rpmsg_device *rpdev)
 	mutex_init(&common->state_lock);
 	INIT_DELAYED_WORK(&common->state_work, icve_state_machine);
 	init_completion(&common->sync_msg);
-
+	__hw_addr_init(&common->mc_list);
+	INIT_WORK(&common->rx_mode_work, icve_ndo_set_rx_mode_work);
+	common->cmd_wq = create_singlethread_workqueue("icve_rx_work");
+	if (!common->cmd_wq) {
+		dev_err(dev, "Failure requesting workqueue\n");
+		return -ENOMEM;
+	}
 	/* Register the network device */
 	ret = icve_init_ndev(common);
 	if (ret)
@@ -506,6 +566,7 @@ static void icve_rpmsg_remove(struct rpmsg_device *rpdev)
 
 	netif_napi_del(&port->rx_napi);
 	del_timer_sync(&port->rx_timer);
+	destroy_workqueue(common->cmd_wq);
 	dev_info(&rpdev->dev, "icve rpmsg client driver is removed\n");
 }
 
diff --git a/drivers/net/ethernet/ti/inter_core_virt_eth.h b/drivers/net/ethernet/ti/inter_core_virt_eth.h
index 4fc420cb9eab..02c4d23395f5 100644
--- a/drivers/net/ethernet/ti/inter_core_virt_eth.h
+++ b/drivers/net/ethernet/ti/inter_core_virt_eth.h
@@ -47,7 +47,11 @@ struct icve_common {
 	enum icve_state	state;
 	struct mutex state_lock; /* Lock to be used while changing the interface state */
 	struct delayed_work state_work;
+	struct work_struct rx_mode_work;
+	struct workqueue_struct *cmd_wq;
+	struct netdev_hw_addr_list mc_list;
 	struct completion sync_msg;
+	u8 mcast_addr[ETH_ALEN];
 };
 
 struct icve_ndev_priv {
-- 
2.40.1


