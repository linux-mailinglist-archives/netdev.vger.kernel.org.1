Return-Path: <netdev+bounces-52533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FA17FF104
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 14:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3BA8B20CE8
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 13:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EA8482F9;
	Thu, 30 Nov 2023 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="26fsg9UC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DA4198
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 05:58:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlV0OkXcMSHLuDLbfoj4BGdONwQeWPa6Ol05BiGfCNoNs4irGyLJl2mjDfamGq2YPtgP+fJFNJcoGowoL4Hy2xJGXI5rCPqIgbYkDPjTEG3omV43HHt6SGRo94kclNQCMOLgYZnwwg8G/ARZX1AapNnIEP9OmDnbRTrPyHThXtL/zoXHr0/41i+9hU6IRFjtVRd6rbpnTLfiA4TEn0kw+KD7exsY7P/gmv6XGarVFlcy/Eo+olLAEo5VGKSBGEErgX+5ic19QumCON4SH5yYSG224jngPN11fIzJcEsefgrVYbCKEQE6JybbP87ZtYCAjed9514AOIHdnzVMvnov1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPwRBAULcl4DVSz0qbKh3KEkDFlygRvw59AjN17f97I=;
 b=RajoegXyDmENJmRYkuV4NPTAeqHx7MTUpe9mD2+g+TuWSFb2ystHcK5/Uu2YmceE+0lbc2D1671rB80Bx+bDcn/X9204XB0x1vJuT4NWyB2kezccdOF6xiZdhmu1uS1RsUcmoUmIuwcNzRVOetU/LL5rEx0mrXRvQA55QHj2j5HSytz+0YT/JYcTMftLHzTxkYgPrBwV2ENJmdLi5H1M6Xaqepnn4MOeIeFBdUfxd2RICbLBxRippbACIhSkXER5bTSEiRttg0lvMcCdvwel4Nvh/BfZi3Oc8CCjC7SA6b/gsu18CuLKjdOZZySyT9fBhi9SsN1gSuDqiSSy+pIVLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPwRBAULcl4DVSz0qbKh3KEkDFlygRvw59AjN17f97I=;
 b=26fsg9UCT+JBZiqOGJr2LC9sAIg96jLKgeqp7gZsM9NlSJAPzx9bhsoEjyMq7C/9bHZ7sTrJ1Wz/kKPYyJ29CGRPIgbjDSVZkU4KwUlIYy4Cuf16eruPgFT7FH/bqEu8I8OR+j8b0V8YFZw05Z52im9odTVzAvx/yTc6w0XrkxQ=
Received: from MN2PR15CA0017.namprd15.prod.outlook.com (2603:10b6:208:1b4::30)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.24; Thu, 30 Nov 2023 13:58:49 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::bd) by MN2PR15CA0017.outlook.office365.com
 (2603:10b6:208:1b4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27 via Frontend
 Transport; Thu, 30 Nov 2023 13:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 13:58:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 07:58:49 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 07:58:42 -0600
Received: from xcbalexaust40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 07:58:41 -0600
From: Alex Austin <alex.austin@amd.com>
To: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
CC: <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <lorenzo@kernel.org>,
	<alex.austin@amd.com>, <memxor@gmail.com>, <alardam@gmail.com>,
	<bhelgaas@google.com>
Subject: [PATCH net-next 2/2] sfc-siena: Implement ndo_hwtstamp_(get|set)
Date: Thu, 30 Nov 2023 13:58:26 +0000
Message-ID: <20231130135826.19018-3-alex.austin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231130135826.19018-1-alex.austin@amd.com>
References: <20231130135826.19018-1-alex.austin@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf7bc34-9de6-40c8-bb0a-08dbf1ac7aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W/kkiMtm6YJpjmnJVOiJkWkwXgCJmmuWkgkudCf5Bh0sapkP94bQ/qiBe8inw68dG17xyC+bVIOCOD86SVaTKvrdWzm9vYiTwKZNKClhR+MdNaIPwcLNQhYQMzNv3xJJkwMkAJeb6i8iwLKidBMgGn/QasZxDHpQgRb1XPhBeBKGfwDNlNi4p9Ja2egyTKzGHtygVbizp4dVCka+sWohYkn0vBnJiauAPNgSVwo43CzHqS2D5q9wcF1Yzq7kg85OJ74XJwf0RNsaiR9JFUd80sQSacJs3Q5W5HXN2QprlVzd/Lff0ASgImtDXCA8nHliw5eCTEikNLucyqaquDDgZd+f6thZemqtVN+729ZVNJfoWS6FsiUz+ZamodDx/MB8g6wTpdJPSglRXvXMonfwENrhSOX7k0s4NAxxmzQTq1MeTOTNirn5UfRDQGFgEVIy5MKMkvX8mjaT51/ein8pz1ERrbKRamch2/DmKRpgJ4vys4H4omeJUVexMwuyzYp6Dc6DYjRMGaEL7dng0Lj/Rhw6WCP84+Gs1OEVd/lVhSgEsCimdf+14P0xD6D3g2AZaVg3jgrExxhD6vFQTRFXttzVNFGPKy76eaQMMkTal/hJzJiuj4PaBgCD3XRck/e99tuUpkTpun8YmlJ1TSLm5Iix6P9uSLefOWiNHyAr/gqWb5dcjCcciMTmzpFUdbKIBnfXwx6Oryocnq2Ye/6VBg2cMximhdK2WfkVu+uCjfIcwkJMCZdYG3u0D3Y5upIYcw1nfzrI0td2DbBak9jQhg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(86362001)(40460700003)(1076003)(26005)(336012)(83380400001)(426003)(6666004)(2616005)(47076005)(36860700001)(44832011)(5660300002)(4326008)(8676002)(8936002)(41300700001)(7416002)(2906002)(478600001)(316002)(110136005)(6636002)(54906003)(70586007)(70206006)(36756003)(81166007)(82740400003)(356005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 13:58:49.6611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf7bc34-9de6-40c8-bb0a-08dbf1ac7aa0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392

Update efx->ptp_data to use kernel_hwtstamp_config and implement
ndo_hwtstamp_(get|set). Remove SIOCGHWTSTAMP and SIOCSHWTSTAMP from
efx_ioctl.

Signed-off-by: Alex Austin <alex.austin@amd.com>
Acked-by: Martin Habets <habetsm.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/siena/efx.c        | 24 +++++++++++++----
 drivers/net/ethernet/sfc/siena/net_driver.h |  2 +-
 drivers/net/ethernet/sfc/siena/ptp.c        | 30 +++++++++------------
 drivers/net/ethernet/sfc/siena/ptp.h        |  7 +++--
 drivers/net/ethernet/sfc/siena/siena.c      |  2 +-
 5 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/sfc/siena/efx.c b/drivers/net/ethernet/sfc/siena/efx.c
index 8c557f6a183c..59d3a6043379 100644
--- a/drivers/net/ethernet/sfc/siena/efx.c
+++ b/drivers/net/ethernet/sfc/siena/efx.c
@@ -495,11 +495,6 @@ static int efx_ioctl(struct net_device *net_dev, struct ifreq *ifr, int cmd)
 	struct efx_nic *efx = netdev_priv(net_dev);
 	struct mii_ioctl_data *data = if_mii(ifr);
 
-	if (cmd == SIOCSHWTSTAMP)
-		return efx_siena_ptp_set_ts_config(efx, ifr);
-	if (cmd == SIOCGHWTSTAMP)
-		return efx_siena_ptp_get_ts_config(efx, ifr);
-
 	/* Convert phy_id from older PRTAD/DEVAD format */
 	if ((cmd == SIOCGMIIREG || cmd == SIOCSMIIREG) &&
 	    (data->phy_id & 0xfc00) == 0x0400)
@@ -579,6 +574,23 @@ static int efx_vlan_rx_kill_vid(struct net_device *net_dev, __be16 proto, u16 vi
 		return -EOPNOTSUPP;
 }
 
+static int efx_siena_hwtstamp_set(struct net_device *net_dev,
+				  struct kernel_hwtstamp_config *config,
+				  struct netlink_ext_ack *extack)
+{
+	struct efx_nic *efx = netdev_priv(net_dev);
+
+	return efx_siena_ptp_set_ts_config(efx, config, extack);
+}
+
+static int efx_siena_hwtstamp_get(struct net_device *net_dev,
+				  struct kernel_hwtstamp_config *config)
+{
+	struct efx_nic *efx = netdev_priv(net_dev);
+
+	return efx_siena_ptp_get_ts_config(efx, config);
+}
+
 static const struct net_device_ops efx_netdev_ops = {
 	.ndo_open		= efx_net_open,
 	.ndo_stop		= efx_net_stop,
@@ -594,6 +606,8 @@ static const struct net_device_ops efx_netdev_ops = {
 	.ndo_features_check	= efx_siena_features_check,
 	.ndo_vlan_rx_add_vid	= efx_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= efx_vlan_rx_kill_vid,
+	.ndo_hwtstamp_set	= efx_siena_hwtstamp_set,
+	.ndo_hwtstamp_get	= efx_siena_hwtstamp_get,
 #ifdef CONFIG_SFC_SIENA_SRIOV
 	.ndo_set_vf_mac		= efx_sriov_set_vf_mac,
 	.ndo_set_vf_vlan	= efx_sriov_set_vf_vlan,
diff --git a/drivers/net/ethernet/sfc/siena/net_driver.h b/drivers/net/ethernet/sfc/siena/net_driver.h
index ff7bbc325952..94152f595acd 100644
--- a/drivers/net/ethernet/sfc/siena/net_driver.h
+++ b/drivers/net/ethernet/sfc/siena/net_driver.h
@@ -1424,7 +1424,7 @@ struct efx_nic_type {
 	void (*ptp_write_host_time)(struct efx_nic *efx, u32 host_time);
 	int (*ptp_set_ts_sync_events)(struct efx_nic *efx, bool en, bool temp);
 	int (*ptp_set_ts_config)(struct efx_nic *efx,
-				 struct hwtstamp_config *init);
+				 struct kernel_hwtstamp_config *init);
 	int (*sriov_configure)(struct efx_nic *efx, int num_vfs);
 	int (*vlan_rx_add_vid)(struct efx_nic *efx, __be16 proto, u16 vid);
 	int (*vlan_rx_kill_vid)(struct efx_nic *efx, __be16 proto, u16 vid);
diff --git a/drivers/net/ethernet/sfc/siena/ptp.c b/drivers/net/ethernet/sfc/siena/ptp.c
index 38e666561bcd..4b5e2f0ba350 100644
--- a/drivers/net/ethernet/sfc/siena/ptp.c
+++ b/drivers/net/ethernet/sfc/siena/ptp.c
@@ -297,7 +297,7 @@ struct efx_ptp_data {
 	u32 rxfilter_event;
 	u32 rxfilter_general;
 	bool rxfilter_installed;
-	struct hwtstamp_config config;
+	struct kernel_hwtstamp_config config;
 	bool enabled;
 	unsigned int mode;
 	void (*ns_to_nic_time)(s64 ns, u32 *nic_major, u32 *nic_minor);
@@ -1762,7 +1762,8 @@ int efx_siena_ptp_change_mode(struct efx_nic *efx, bool enable_wanted,
 	return 0;
 }
 
-static int efx_ptp_ts_init(struct efx_nic *efx, struct hwtstamp_config *init)
+static int efx_ptp_ts_init(struct efx_nic *efx,
+			   struct kernel_hwtstamp_config *init)
 {
 	int rc;
 
@@ -1799,33 +1800,26 @@ void efx_siena_ptp_get_ts_info(struct efx_nic *efx,
 	ts_info->rx_filters = ptp->efx->type->hwtstamp_filters;
 }
 
-int efx_siena_ptp_set_ts_config(struct efx_nic *efx, struct ifreq *ifr)
+int efx_siena_ptp_set_ts_config(struct efx_nic *efx,
+				struct kernel_hwtstamp_config *config,
+				struct netlink_ext_ack __always_unused *extack)
 {
-	struct hwtstamp_config config;
-	int rc;
-
 	/* Not a PTP enabled port */
 	if (!efx->ptp_data)
 		return -EOPNOTSUPP;
 
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	rc = efx_ptp_ts_init(efx, &config);
-	if (rc != 0)
-		return rc;
-
-	return copy_to_user(ifr->ifr_data, &config, sizeof(config))
-		? -EFAULT : 0;
+	return efx_ptp_ts_init(efx, config);
 }
 
-int efx_siena_ptp_get_ts_config(struct efx_nic *efx, struct ifreq *ifr)
+int efx_siena_ptp_get_ts_config(struct efx_nic *efx,
+				struct kernel_hwtstamp_config *config)
 {
+	/* Not a PTP enabled port */
 	if (!efx->ptp_data)
 		return -EOPNOTSUPP;
 
-	return copy_to_user(ifr->ifr_data, &efx->ptp_data->config,
-			    sizeof(efx->ptp_data->config)) ? -EFAULT : 0;
+	*config = efx->ptp_data->config;
+	return 0;
 }
 
 static void ptp_event_failure(struct efx_nic *efx, int expected_frag_len)
diff --git a/drivers/net/ethernet/sfc/siena/ptp.h b/drivers/net/ethernet/sfc/siena/ptp.h
index 4172f90e9f6f..6352f84424f6 100644
--- a/drivers/net/ethernet/sfc/siena/ptp.h
+++ b/drivers/net/ethernet/sfc/siena/ptp.h
@@ -15,8 +15,11 @@
 struct ethtool_ts_info;
 void efx_siena_ptp_defer_probe_with_channel(struct efx_nic *efx);
 struct efx_channel *efx_siena_ptp_channel(struct efx_nic *efx);
-int efx_siena_ptp_set_ts_config(struct efx_nic *efx, struct ifreq *ifr);
-int efx_siena_ptp_get_ts_config(struct efx_nic *efx, struct ifreq *ifr);
+int efx_siena_ptp_set_ts_config(struct efx_nic *efx,
+				struct kernel_hwtstamp_config *config,
+				struct netlink_ext_ack *extack);
+int efx_siena_ptp_get_ts_config(struct efx_nic *efx,
+				struct kernel_hwtstamp_config *config);
 void efx_siena_ptp_get_ts_info(struct efx_nic *efx,
 			       struct ethtool_ts_info *ts_info);
 bool efx_siena_ptp_is_ptp_tx(struct efx_nic *efx, struct sk_buff *skb);
diff --git a/drivers/net/ethernet/sfc/siena/siena.c b/drivers/net/ethernet/sfc/siena/siena.c
index a44c8fa25748..ca33dc08e555 100644
--- a/drivers/net/ethernet/sfc/siena/siena.c
+++ b/drivers/net/ethernet/sfc/siena/siena.c
@@ -136,7 +136,7 @@ static void siena_ptp_write_host_time(struct efx_nic *efx, u32 host_time)
 }
 
 static int siena_ptp_set_ts_config(struct efx_nic *efx,
-				   struct hwtstamp_config *init)
+				   struct kernel_hwtstamp_config *init)
 {
 	int rc;
 
-- 
2.39.3


