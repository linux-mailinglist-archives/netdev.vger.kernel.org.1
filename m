Return-Path: <netdev+bounces-212770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88397B21C53
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 06:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF403ACF40
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 04:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D222D8375;
	Tue, 12 Aug 2025 04:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fOnAaO7L"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2045C1E47AD;
	Tue, 12 Aug 2025 04:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974274; cv=fail; b=OvdWGn8bTJOlTc5N5eGnYCKbiL1xNelvrz6EuIg7EoPrlLUDVhWK8vIoOT4od/Fh0imgg7R3bbiBa6iCX5zvQodkU0X2x8x8IleWKUeABkwiU6oRl+2EzdQhJwW2NlRUhDIbnHpD4qBEkpoObUDgrTfTfbeRlKQyQBrP02wKm/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974274; c=relaxed/simple;
	bh=YytZt8IoAzHWLPH/+HxpSFiOpY5vYNuxCqflYXscHss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cp8CB/LzYBX+riaBxQa1io5c2XxGpwsQ//j3KyjEgKTlnxUVyU9uWMwQ20r0JwsR+7DF1Nu3JBa6Kf6wm+Mvi2psld7teOigpBlda+uh+iOM/A0bOpQUSBtEYMGFiRKXLjcScxTemHMY99Pvgvk4736vcVFRappcuTXx1sVaQGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fOnAaO7L; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Go9zOU2qtwXqAY0tIddYQMD8MqnOUEHrZZ6GDQZDzrh4WbgFUiUqyTC98kVi31qqHcLcg8AAGaGvuzKNuk7vk3Y3z7hjB/ENehkuchoEZuBw5UAziZsX0BjME1pFl5UVTjr7vUlrvAf7htvtC9wpzxCgYJKusMEZ+o5GVnsYIbZQxZIptH+wDf1mAHg/q8tg7GNBEIgKDA6CJaABYsHC9xq52xhVuoUx0ztjo4IeAwelp6ta0DYnjKeqdeAzEzm86qI9O0pzYIGSJZ8RuWlcdwMVtURF+495aMTGH5v+uxnxEmKyQg5Ep3tetZ2s+9s14zHFytX9IBB/Kuowu/u17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHEeQqSC4jlgMfu96eMuP+VLvYYaCRIEbt88wY9p+gQ=;
 b=kGXv405w9NwKM7SuTql7C34YQJAxnZlAVcIx7lFYeCB4vVQLJvkdlqn5rNUc6eUCsjjn3jDiDN/UFb7rplvO8P3MO/KVF4YjpILLvAcjJJsJ+FC9FpO7DVZ6Y5wSreQEZ+bzvdjLiQhBH63zPXf8KaOTVqBycLJHcwKvWDNHe5aIjFmQKfPbfMkawujrjMea2bbHyjn1hAngqQN5rVobYJnqSS5GH3LQqBLOdHIKQ6U2/DP4+NU0iLdYPfhdiS1gi0yUO68L9H1a37VAWkvmi5ndbF5sacJTw/qe4pjq+ZIdP15ap6eID+gTyYQrc98jnUN2Ou+8MjaGrLd49lNRDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHEeQqSC4jlgMfu96eMuP+VLvYYaCRIEbt88wY9p+gQ=;
 b=fOnAaO7LOHvEWqC9A0daxMhhV6JZ/km9HR4bDFBAkwboLyqtMMAbfvNNib6ixoCmvpk0ooNaYR8NIlYjUY7gyBPyrBtRv493kQRmQwwjfe8knE4pi5DCtzuNIb4jNAX8DXJHS89pzVh/1B9WbhdWfpY+SJoDC3UfXatK3JNOVpQ=
Received: from BN9PR03CA0279.namprd03.prod.outlook.com (2603:10b6:408:f5::14)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 04:51:07 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::e6) by BN9PR03CA0279.outlook.office365.com
 (2603:10b6:408:f5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.18 via Frontend Transport; Tue,
 12 Aug 2025 04:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 04:51:07 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 23:51:02 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Vishal Badole <Vishal.Badole@amd.com>
Subject: [PATCH v2 net-next] amd-xgbe: Configure and retrieve 'tx-usecs' for Tx coalescing
Date: Tue, 12 Aug 2025 10:20:35 +0530
Message-ID: <20250812045035.3376179-1-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 837176fc-0fa1-4625-8105-08ddd95bd9c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TFSoz5S10UhFtIKhBBFC8LWCJ/hk3CPLyo83T9h7O7xme5OcxC1b9RB2PUBG?=
 =?us-ascii?Q?N6WaB1bbvqBhr3OhILBD4lPmfhLMrsaRxQAYalNV43WqzA5koCRbNgt9nLeh?=
 =?us-ascii?Q?LEc21AOt9kPUwzkvusA22AfMPjh6/exK9pWQR440wKQSuk96Lr55zqsKbbBh?=
 =?us-ascii?Q?XkrWXBGgaNpHhEyn5EKNr0t8/+e5a2q/zlf471nIsmxQ5v0AEuPfY/eyiLXI?=
 =?us-ascii?Q?cOtccr5IHW0z3vTpNeAs9XC42lKW/0l7vpR3H7rwRyEMI4eUG8kd77cd27C0?=
 =?us-ascii?Q?u2sB/VAxhEgDPxbO8k1T8fQXV/X/l2wFuIYZuLgZODzu+b1w2r5XNWAxiz55?=
 =?us-ascii?Q?mJZomvG9QvlN/rCHVbVTiqeMi8sVCzcd7lN1jUFTDIT6n5w92JyNHL0vMqQF?=
 =?us-ascii?Q?Og6F58pMZjzYsbnYLnriz66bD+xFzwyGAekv5iPMUtnZtK1gCZodayuufCts?=
 =?us-ascii?Q?csIhfSs+zdM3hUZvFjc6S6A82w5buDgJq1UGgAr3ljiR+jsn84FVxB10saSj?=
 =?us-ascii?Q?E+8wXwOd3rh/kfQ5W8gmjw8pUx5U9QXCXEONKExbulB0A+PJdHUlTau9DySf?=
 =?us-ascii?Q?vks4Pcv+2wbpgRBdpFuPMroUZYq9avm299Uf3Kql3lZC6W7wYn/wwAKOx2vD?=
 =?us-ascii?Q?MCDr+Ntw8c0s8q7++QZNSspKeyD4sUmrw2LyYFtOMe5GTvHnYD5Y7glehTt1?=
 =?us-ascii?Q?dndNttHYpAY/YjxAcHpWDlRWFg1t9w6710ic2NArNcRfmGWC0fo6i+SDCq7e?=
 =?us-ascii?Q?uIOXKOwLUC4mB5eeshTIQhao/jk2swvEXwz83yet86+HShP0Uy6ToX+85uxo?=
 =?us-ascii?Q?mQfdrKy3C7d8a2JZYK0CmPNesf+SrNzgef0pZvkETEQbEzairBnsqQpOGLw3?=
 =?us-ascii?Q?RKKBdGszL3iTKxDNd6DNEwTAttIuDUGWp/rwW0VAU+5AG5ygofODkfGAKcTo?=
 =?us-ascii?Q?w1/CFl+bEp8tT3Hpw/q5/F61xjlCA7NDls/RQUoReL9k7QIcTmaDkxyiD8cc?=
 =?us-ascii?Q?hmWsRwmC3Swb9L5K7gS/uAdf9NH9zzKUzCe5nESSxPNIgK4fY42BMr0Tug77?=
 =?us-ascii?Q?WUSjsZZwJJUbfZla3XgDdVHdS0v1N7yfr1Mrwzj4TxW4G+cr9XYQwS2WiJOf?=
 =?us-ascii?Q?t2yso8JsDqWPildlOavQWQELcRPBsk09h2Pe+ez6TdvUF1h/uhVUyk4p0zmV?=
 =?us-ascii?Q?XLbWTf162VVpuX+KaxEkHkmOipWPNXvXCzI1+XpP81TQOriCuHqh42+JOOgU?=
 =?us-ascii?Q?ftxBW2LAjz8mqZXFmoMHyDqiOp3PTHb/N+7/vyJOd8DBFu9O8t2GR0ydMBcg?=
 =?us-ascii?Q?sdKcPNEJUKUgFp0DGHn66/tXcoX97hsHFLzHKe/imSPQRi2ghT3JtxtBobgy?=
 =?us-ascii?Q?5Qy0DNy2bfLu81l6BshhOJQbVvOvtoSjSLM9bsvaN613d5n3B9tcGihUSW7m?=
 =?us-ascii?Q?kzSBFTcR0r1tv54XsVS4F5g2X7MLDyLDGj48uGTSAqdUfOPbfsSpg3L2ZnGC?=
 =?us-ascii?Q?/nxQjCxJA49J55zCZIMjwZfc9g870h+OaI6e?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 04:51:07.4710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 837176fc-0fa1-4625-8105-08ddd95bd9c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979

Ethtool has advanced with additional configurable options, but the
current driver does not support tx-usecs configuration.

Add support to configure and retrieve 'tx-usecs' using ethtool, which
specifies the wait time before servicing an interrupt for Tx coalescing.

Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

---
v1 -> v2:
    * Replace netdev_err() with extack interface for user error reporting.
---
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 19 +++++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe.h         |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index 12395428ffe1..19cb1e2b7d92 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -450,6 +450,7 @@ static int xgbe_get_coalesce(struct net_device *netdev,
 	ec->rx_coalesce_usecs = pdata->rx_usecs;
 	ec->rx_max_coalesced_frames = pdata->rx_frames;
 
+	ec->tx_coalesce_usecs = pdata->tx_usecs;
 	ec->tx_max_coalesced_frames = pdata->tx_frames;
 
 	return 0;
@@ -463,7 +464,7 @@ static int xgbe_set_coalesce(struct net_device *netdev,
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 	struct xgbe_hw_if *hw_if = &pdata->hw_if;
 	unsigned int rx_frames, rx_riwt, rx_usecs;
-	unsigned int tx_frames;
+	unsigned int tx_frames, tx_usecs;
 
 	rx_riwt = hw_if->usec_to_riwt(pdata, ec->rx_coalesce_usecs);
 	rx_usecs = ec->rx_coalesce_usecs;
@@ -485,9 +486,22 @@ static int xgbe_set_coalesce(struct net_device *netdev,
 		return -EINVAL;
 	}
 
+	tx_usecs = ec->tx_coalesce_usecs;
 	tx_frames = ec->tx_max_coalesced_frames;
 
+	/* Check if both tx_usecs and tx_frames are set to 0 simultaneously */
+	if (!tx_usecs && !tx_frames) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "tx_usecs and tx_frames must not be 0 together");
+		return -EINVAL;
+	}
+
 	/* Check the bounds of values for Tx */
+	if (tx_usecs > XGMAC_MAX_COAL_TX_TICK) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "tx-usecs is limited to %d usec",
+				       XGMAC_MAX_COAL_TX_TICK);
+		return -EINVAL;
+	}
 	if (tx_frames > pdata->tx_desc_count) {
 		netdev_err(netdev, "tx-frames is limited to %d frames\n",
 			   pdata->tx_desc_count);
@@ -499,6 +513,7 @@ static int xgbe_set_coalesce(struct net_device *netdev,
 	pdata->rx_frames = rx_frames;
 	hw_if->config_rx_coalesce(pdata);
 
+	pdata->tx_usecs = tx_usecs;
 	pdata->tx_frames = tx_frames;
 	hw_if->config_tx_coalesce(pdata);
 
@@ -830,7 +845,7 @@ static int xgbe_set_channels(struct net_device *netdev,
 }
 
 static const struct ethtool_ops xgbe_ethtool_ops = {
-	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS |
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
 	.get_drvinfo = xgbe_get_drvinfo,
 	.get_msglevel = xgbe_get_msglevel,
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 42fa4f84ff01..e330ae9ea685 100755
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -272,6 +272,7 @@
 /* Default coalescing parameters */
 #define XGMAC_INIT_DMA_TX_USECS		1000
 #define XGMAC_INIT_DMA_TX_FRAMES	25
+#define XGMAC_MAX_COAL_TX_TICK		100000
 
 #define XGMAC_MAX_DMA_RIWT		0xff
 #define XGMAC_INIT_DMA_RX_USECS		30
-- 
2.34.1


