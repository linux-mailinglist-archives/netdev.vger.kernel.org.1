Return-Path: <netdev+bounces-209251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14290B0ECAB
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0640C567DC8
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D916D2797AD;
	Wed, 23 Jul 2025 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YWz1RfaZ"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF871279795;
	Wed, 23 Jul 2025 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257857; cv=none; b=ge51aatmMX5v9X2WHx2BVpQtpCIVOI3zQQUWCfO26VZPZxEIiaz0kYTg4UVc6vqTWmEHmt4jysqLyNpHKQZFXn79KFchWnohzKSVrQmWSIsiY37OrNqLEVPKy2R2GfzyyqgILaCczlFGlCE/c8BubVB6OnayJ42M1CweYb+eq3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257857; c=relaxed/simple;
	bh=Rq8CWf3AxoYslKrBl8R2+0dVi1ZfoIP+gkHNSZ+MeKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTo402KVuDvq4GQBYzUhOlSTF/JtgTXfZ/I/mIvrxJxolqV8MINMLdlOgp5EhyeBC5BzJaOnXRYkSF3G5pA/bOB+RBVjKORf//vVqUD1Hs/0JymAXbyMyaOekgzPqH02wfitTKoKX1wUSTL/1a+40YrMrgKPQMj8+hIdPrbbK8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YWz1RfaZ; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56N83ej81223420;
	Wed, 23 Jul 2025 03:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753257820;
	bh=exLzVkguk6cycSbD88736Px3AndF6YoZ9kK3pIxDvEY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YWz1RfaZ6hic28j0p0ng4q1xYW01IvB+9VtkBqQGoCrsuehNm8jFuMBKysFlhNeV3
	 5u0yDufKNwOzWvb9vezThO1LGXYQ/hnbYtF/K5ijn27S/3DXgpGbPgkDCAca12r+s+
	 f2LN3UmF0Gl7YJH8raZOgHPLqxG+xOkZfWNdsFTk=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56N83e9N2219311
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 23 Jul 2025 03:03:40 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 23
 Jul 2025 03:03:39 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 23 Jul 2025 03:03:39 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56N83dgO2366059;
	Wed, 23 Jul 2025 03:03:39 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 56N83cwT016007;
	Wed, 23 Jul 2025 03:03:38 -0500
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
Subject: [PATCH net-next 5/5] net: rpmsg-eth: Add support for multicast filtering
Date: Wed, 23 Jul 2025 13:33:22 +0530
Message-ID: <20250723080322.3047826-6-danishanwar@ti.com>
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

Add support for multicast filtering for ICVE driver. Implement the
ndo_set_rx_mode callback as icve_set_rx_mode() API. rx_mode_workqueue is
initialized in icve_rpmsg_probe() and queued in icve_set_rx_mode().

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/rpmsg_eth.c | 63 ++++++++++++++++++++++++++++++++
 drivers/net/ethernet/rpmsg_eth.h | 12 ++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/net/ethernet/rpmsg_eth.c b/drivers/net/ethernet/rpmsg_eth.c
index 4efa9b634f8b..a77fc4f3f769 100644
--- a/drivers/net/ethernet/rpmsg_eth.c
+++ b/drivers/net/ethernet/rpmsg_eth.c
@@ -148,6 +148,11 @@ static int create_request(struct rpmsg_eth_common *common,
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
@@ -199,6 +204,22 @@ static int rpmsg_eth_create_send_request(struct rpmsg_eth_common *common,
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
@@ -282,6 +303,10 @@ static int rpmsg_eth_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
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
@@ -470,10 +495,15 @@ static int rpmsg_eth_ndo_stop(struct net_device *ndev)
 
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
 
@@ -533,10 +563,35 @@ static int rpmsg_eth_set_mac_address(struct net_device *ndev, void *addr)
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
 
@@ -640,6 +695,13 @@ static int rpmsg_eth_probe(struct rpmsg_device *rpdev)
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
@@ -658,6 +720,7 @@ static void rpmsg_eth_rpmsg_remove(struct rpmsg_device *rpdev)
 
 	netif_napi_del(&port->rx_napi);
 	timer_delete_sync(&port->rx_timer);
+	destroy_workqueue(common->cmd_wq);
 }
 
 static struct rpmsg_device_id rpmsg_eth_rpmsg_id_table[] = {
diff --git a/drivers/net/ethernet/rpmsg_eth.h b/drivers/net/ethernet/rpmsg_eth.h
index d7e4d53c8de4..5ff1a0e57c37 100644
--- a/drivers/net/ethernet/rpmsg_eth.h
+++ b/drivers/net/ethernet/rpmsg_eth.h
@@ -50,10 +50,14 @@ enum rpmsg_eth_rpmsg_type {
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
@@ -232,6 +236,10 @@ enum rpmsg_eth_state {
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
@@ -248,6 +256,10 @@ struct rpmsg_eth_common {
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


