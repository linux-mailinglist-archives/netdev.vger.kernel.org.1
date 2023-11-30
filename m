Return-Path: <netdev+bounces-52532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EC27FF103
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 14:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A901C20F8B
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 13:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AEF48780;
	Thu, 30 Nov 2023 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BcT6SkgX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C62B9
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 05:58:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPszfX09AFAt3kVRI1kRiUhceymroPzOl0sNiRI+gX9HbdZed652Kur+ItDkyfYF5L0I/6zJwvQ6/jOnhHeSUD0jpGVAfh6ECiCPYp2bs/Q1sMkmGpOtWKP8Mfzp9NkwmGn4pifDa4zLRtZkNQo8mB46E4iDxVXOD5MJNhsGpyyBclDj28ekDGeUugCKjvyfzlymQ83ltja9upC6En4B14fNSq/NhrPulUN3iOvj6gNQ6R9Sal/1XByAw1luzqqE8j82FueGC8Zzdjdkw9U/zUVDwNI+u4BxOSThT3jHIjzatr6MIfIxpLTarCTMcH6n+9jENLABRNFUyy/7nte/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IVnTqWklgrwSAEajnnGP7Fjk58qsnBGfbmVdSguqpw=;
 b=gaZrVU4/N+EpqPCQH5AFdFhyGgItRxH7kpYak1IQ+kr0RbJrLbVWc+Auct6MweHe2S+nRPNuTeun6TRFa2spJbTczV+oONETJphuxd656nMkjUOqL+baNOyMpde+p5TvwxB9Epuj6wJF0LZUOzOL8LQAwQk2Azlnp3FKmBiR8dYphu3D9eKOz9xygWLT2S+xqwiJlwd/54tXiq8HXEt8axZMgApR4+cwnD8ezd4zs0eZho5tLUPdJ8RcKwDZklC+OrPn9b2m/dHA3nbX0rs4TVFCIewX3AWECN6MAmxp5cs3duKBHbdIKx161T0/x/fnYXxrHFq1Y/kfRn9xNkgJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IVnTqWklgrwSAEajnnGP7Fjk58qsnBGfbmVdSguqpw=;
 b=BcT6SkgXMJdThEBdqtEGmS0CNb4B1W1Z/mqDU22gvFL/qLRLXdIDF4qiSiCEPVoPywwl2Wr6XwC5RPdKdsZ+Y1a2S3Y3HkOli568ZkODsu1USx/N0yr8yH/fAih6uauMyythzCSWjBWNkAYRaHIIUQ4JNnKOHwAzOVYve9DbJBI=
Received: from MN2PR15CA0020.namprd15.prod.outlook.com (2603:10b6:208:1b4::33)
 by CY8PR12MB7123.namprd12.prod.outlook.com (2603:10b6:930:60::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 13:58:40 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::ce) by MN2PR15CA0020.outlook.office365.com
 (2603:10b6:208:1b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20 via Frontend
 Transport; Thu, 30 Nov 2023 13:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 13:58:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 07:58:38 -0600
Received: from xcbalexaust40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 07:58:37 -0600
From: Alex Austin <alex.austin@amd.com>
To: <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
CC: <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <lorenzo@kernel.org>,
	<alex.austin@amd.com>, <memxor@gmail.com>, <alardam@gmail.com>,
	<bhelgaas@google.com>
Subject: [PATCH net-next 1/2] sfc: Implement ndo_hwtstamp_(get|set)
Date: Thu, 30 Nov 2023 13:58:25 +0000
Message-ID: <20231130135826.19018-2-alex.austin@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|CY8PR12MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a952216-a8ad-4e26-5418-08dbf1ac7482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IOy1iG1BIzzTSKUmpYd3Fco++PJFI5slcYXTuxytAOWHNscm7ZYFjNVEtLJXuFESCyyuHq6lG4dZmm+gxHPXHfAesjKJnJbrAvOOUcGWbvEn8SpZceHhbUVU9RKfU/dUYSfXnBi8SGNAvg0f5cdPzEyFG8cURgqdulVo9KuLkFxg99WF9iRMbWVu6S1ArjouCy8jWzwh/ce5AkpT9ZWCxni9KGE9evMYMqVeUliW1YJbY02D2wQ2V6EL2Yj290iTCdlUP3YsQng2Sskrw1BRjyA+Q6G05doAAxIAITUnzQNHlxCON07bwdE4lgeVsZFvfwjM1PoZGsNL+E20YaHQ9onDTBLLw7h2GtH7PH9z0/v9whGO9YxyOHWBvjhS9oC7Ts8cq9kWSVYOlmgaqGs/ldizaikpNiUtyIS1ijuWbB8/uhHWPp7vXELy1Wn4dTKPh6jDRqVvNo8It5vuY2uz+qXXilsTV0iELN84rUOuI3SQLmAjWGgFHle94suGeYQRLP2pFBZfOF/3nraI7P9493vO+Hnw5lxJkfyhuciZfe+uaYI99O4ssjaaDP7uWUbtIs8SA8zxePnDb3h3xC7FyZ6ZmIQpd6NN/l6/BbaSz2FfraAphSJyouELL45LLCyK8sbo4s9JM1mLFl1VuK5y+pUfoG6L1ts7E+gaCtfCY8XJVrTEdJvP/cqGQHknB9iEeund45YIcdTcsamvOVK6p7Uxrctwg/WofzvZsP4FfQoXuO8LVYh2zqVBK2+0xGAl4OfACK0S8TwrmUjfC4Tfvg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(40470700004)(36840700001)(46966006)(8676002)(8936002)(4326008)(36756003)(6636002)(316002)(70206006)(70586007)(54906003)(110136005)(2906002)(41300700001)(44832011)(40460700003)(86362001)(5660300002)(7416002)(81166007)(47076005)(356005)(26005)(40480700001)(426003)(83380400001)(82740400003)(336012)(1076003)(36860700001)(478600001)(2616005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 13:58:39.3955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a952216-a8ad-4e26-5418-08dbf1ac7482
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7123

Update efx->ptp_data to use kernel_hwtstamp_config and implement
ndo_hwtstamp_(get|set). Remove SIOCGHWTSTAMP and SIOCSHWTSTAMP from
efx_ioctl.

Signed-off-by: Alex Austin <alex.austin@amd.com>
Acked-by: Martin Habets <habetsm.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ef10.c       |  4 ++--
 drivers/net/ethernet/sfc/efx.c        | 24 ++++++++++++++++-----
 drivers/net/ethernet/sfc/net_driver.h |  2 +-
 drivers/net/ethernet/sfc/ptp.c        | 30 ++++++++++-----------------
 drivers/net/ethernet/sfc/ptp.h        |  7 +++++--
 5 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 6dfa062feebc..8fa6c0e9195b 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -3706,13 +3706,13 @@ static int efx_ef10_ptp_set_ts_sync_events(struct efx_nic *efx, bool en,
 }
 
 static int efx_ef10_ptp_set_ts_config_vf(struct efx_nic *efx,
-					 struct hwtstamp_config *init)
+					 struct kernel_hwtstamp_config *init)
 {
 	return -EOPNOTSUPP;
 }
 
 static int efx_ef10_ptp_set_ts_config(struct efx_nic *efx,
-				      struct hwtstamp_config *init)
+				      struct kernel_hwtstamp_config *init)
 {
 	int rc;
 
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 19f4b4d0b851..e9d9de8e648a 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -495,11 +495,6 @@ static int efx_ioctl(struct net_device *net_dev, struct ifreq *ifr, int cmd)
 	struct efx_nic *efx = efx_netdev_priv(net_dev);
 	struct mii_ioctl_data *data = if_mii(ifr);
 
-	if (cmd == SIOCSHWTSTAMP)
-		return efx_ptp_set_ts_config(efx, ifr);
-	if (cmd == SIOCGHWTSTAMP)
-		return efx_ptp_get_ts_config(efx, ifr);
-
 	/* Convert phy_id from older PRTAD/DEVAD format */
 	if ((cmd == SIOCGMIIREG || cmd == SIOCSMIIREG) &&
 	    (data->phy_id & 0xfc00) == 0x0400)
@@ -581,6 +576,23 @@ static int efx_vlan_rx_kill_vid(struct net_device *net_dev, __be16 proto, u16 vi
 		return -EOPNOTSUPP;
 }
 
+static int efx_hwtstamp_set(struct net_device *net_dev,
+			    struct kernel_hwtstamp_config *config,
+			    struct netlink_ext_ack *extack)
+{
+	struct efx_nic *efx = efx_netdev_priv(net_dev);
+
+	return efx_ptp_set_ts_config(efx, config, extack);
+}
+
+static int efx_hwtstamp_get(struct net_device *net_dev,
+			    struct kernel_hwtstamp_config *config)
+{
+	struct efx_nic *efx = efx_netdev_priv(net_dev);
+
+	return efx_ptp_get_ts_config(efx, config);
+}
+
 static const struct net_device_ops efx_netdev_ops = {
 	.ndo_open		= efx_net_open,
 	.ndo_stop		= efx_net_stop,
@@ -596,6 +608,8 @@ static const struct net_device_ops efx_netdev_ops = {
 	.ndo_features_check	= efx_features_check,
 	.ndo_vlan_rx_add_vid	= efx_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= efx_vlan_rx_kill_vid,
+	.ndo_hwtstamp_set	= efx_hwtstamp_set,
+	.ndo_hwtstamp_get	= efx_hwtstamp_get,
 #ifdef CONFIG_SFC_SRIOV
 	.ndo_set_vf_mac		= efx_sriov_set_vf_mac,
 	.ndo_set_vf_vlan	= efx_sriov_set_vf_vlan,
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index 27d86e90a3bb..f2dd7feb0e0c 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1473,7 +1473,7 @@ struct efx_nic_type {
 	void (*ptp_write_host_time)(struct efx_nic *efx, u32 host_time);
 	int (*ptp_set_ts_sync_events)(struct efx_nic *efx, bool en, bool temp);
 	int (*ptp_set_ts_config)(struct efx_nic *efx,
-				 struct hwtstamp_config *init);
+				 struct kernel_hwtstamp_config *init);
 	int (*sriov_configure)(struct efx_nic *efx, int num_vfs);
 	int (*vlan_rx_add_vid)(struct efx_nic *efx, __be16 proto, u16 vid);
 	int (*vlan_rx_kill_vid)(struct efx_nic *efx, __be16 proto, u16 vid);
diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index b04fdbb8aece..c3bffbf0ba2b 100644
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -301,7 +301,7 @@ struct efx_ptp_data {
 	bool reset_required;
 	struct list_head rxfilters_mcast;
 	struct list_head rxfilters_ucast;
-	struct hwtstamp_config config;
+	struct kernel_hwtstamp_config config;
 	bool enabled;
 	unsigned int mode;
 	void (*ns_to_nic_time)(s64 ns, u32 *nic_major, u32 *nic_minor);
@@ -1848,7 +1848,7 @@ int efx_ptp_change_mode(struct efx_nic *efx, bool enable_wanted,
 	return 0;
 }
 
-static int efx_ptp_ts_init(struct efx_nic *efx, struct hwtstamp_config *init)
+static int efx_ptp_ts_init(struct efx_nic *efx, struct kernel_hwtstamp_config *init)
 {
 	int rc;
 
@@ -1895,33 +1895,25 @@ void efx_ptp_get_ts_info(struct efx_nic *efx, struct ethtool_ts_info *ts_info)
 	ts_info->rx_filters = ptp->efx->type->hwtstamp_filters;
 }
 
-int efx_ptp_set_ts_config(struct efx_nic *efx, struct ifreq *ifr)
+int efx_ptp_set_ts_config(struct efx_nic *efx,
+			  struct kernel_hwtstamp_config *config,
+			  struct netlink_ext_ack __always_unused *extack)
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
 
-int efx_ptp_get_ts_config(struct efx_nic *efx, struct ifreq *ifr)
+int efx_ptp_get_ts_config(struct efx_nic *efx,
+			  struct kernel_hwtstamp_config *config)
 {
+	/* Not a PTP enabled port */
 	if (!efx->ptp_data)
 		return -EOPNOTSUPP;
-
-	return copy_to_user(ifr->ifr_data, &efx->ptp_data->config,
-			    sizeof(efx->ptp_data->config)) ? -EFAULT : 0;
+	*config = efx->ptp_data->config;
+	return 0;
 }
 
 static void ptp_event_failure(struct efx_nic *efx, int expected_frag_len)
diff --git a/drivers/net/ethernet/sfc/ptp.h b/drivers/net/ethernet/sfc/ptp.h
index 7b1ef7002b3f..2f30dbb490d2 100644
--- a/drivers/net/ethernet/sfc/ptp.h
+++ b/drivers/net/ethernet/sfc/ptp.h
@@ -18,8 +18,11 @@ void efx_ptp_defer_probe_with_channel(struct efx_nic *efx);
 struct efx_channel *efx_ptp_channel(struct efx_nic *efx);
 void efx_ptp_update_channel(struct efx_nic *efx, struct efx_channel *channel);
 void efx_ptp_remove(struct efx_nic *efx);
-int efx_ptp_set_ts_config(struct efx_nic *efx, struct ifreq *ifr);
-int efx_ptp_get_ts_config(struct efx_nic *efx, struct ifreq *ifr);
+int efx_ptp_set_ts_config(struct efx_nic *efx,
+			  struct kernel_hwtstamp_config *config,
+			  struct netlink_ext_ack *extack);
+int efx_ptp_get_ts_config(struct efx_nic *efx,
+			  struct kernel_hwtstamp_config *config);
 void efx_ptp_get_ts_info(struct efx_nic *efx, struct ethtool_ts_info *ts_info);
 bool efx_ptp_is_ptp_tx(struct efx_nic *efx, struct sk_buff *skb);
 int efx_ptp_get_mode(struct efx_nic *efx);
-- 
2.39.3


