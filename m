Return-Path: <netdev+bounces-181747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3FFA86567
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBBF1B81A96
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74E025A32D;
	Fri, 11 Apr 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oirkpbgt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0640D259CA0;
	Fri, 11 Apr 2025 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744395727; cv=fail; b=a9A6bUCpEXO7lvfKa6GxUuWQoZf5Z69nmARO/uMK76BExOQjq7CKO0hn/cDYQ4KOcqr7PYeSNc85pOHo5x9/KgLYH266F2sJtUAYPjrCJTBw6qdwrpjIfFUHSwIbDLVJBFS4/8sdrTnjGoiuTj5NYy/LrXOSc0ZtB1wFXF2UBDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744395727; c=relaxed/simple;
	bh=+mtYAFoFxXbknTXyRPVTehQeOkgvKc4xV1f0wXhtjZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mutu3vgQwLVMKe/uFrhrFqfZitEDyZ9NRRPwo1SQvm0IEIYMH/yYNSrvvUnT1mWUsyl7X/dTtqtt91dayvx2bxXHUCgBn/E9pgEFGGahJE+jldUuKLzKyDEnaWu549OZSY/sCYs1BSeQxFycmOXRjZaeT6Sz0mukvc+8S7WPdf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oirkpbgt; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHmsxDAlkAyv7T3j3ppKAXmhp1W/7MgVlmrRwVLQRs0DRzwCnuMrsRShWb5rPa7fU0LkJB43gdzSMKMEWgFeHWtBC82jGmmWJHvDfAkLn/0fTl/T6Ce7dl47ActI2PlKVFQn66Fv5SQYKV08RcWVWYi27n583P2uMH47ex7NxSsOU9+igIQ4V+Uw8/7dhMRgtXpEl7vG151kDaKr0mT4P9mNsk0bZrYAmmzIdCDcRtQuAR25GHkNwLFsn5/d/r/3pIkq58HuY2E665tUwSS3TAs1UNlYUJg/GsKWO+gHtWybnY2pk1qoMSbxZ6/BtpwLNuaiRGhBmSuuq9Ak8fefKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbR77VT5YzN4grR0CaqqrvISNy55Idi/z8Cf80mi9XU=;
 b=jB5C+mTso9g1vIWbt2zqCNkQSJ+3lUs5o/1rKIjFzP/gQJNS4a0j6we9hkAIfPxRjqPkkQ5fETsYuxZFPypGotk8TERy6JB8lCrR27sGeBCuKJUEqRiAWcmxMNQqNge+W3OZFymbeUDuaEFycpl+ZIXC9b3NWY/Zak+USkD2wFI/OKB2mSmLlvvjFM+uy7lCEsXfCETYxqxJ4Wms5JaTSbm+8aDolSVkbQAEylS2L08kwQIRCpVQHbRe/7dJ7n5Q7BDS7DQ0ssO84nvCNKsWSdsooe0Jo0Ik8X6mBKQbnyX/I7lIbVSDhGb0QKAooEpx6104KpWieVQYg1fT8ht9qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbR77VT5YzN4grR0CaqqrvISNy55Idi/z8Cf80mi9XU=;
 b=OirkpbgtkCrwkT5vvw0jL4qehiscMR0skgJenlrO1LQCDM31HT3ryhLHH5XdX4FHF9xCvEXdNYpYTseHT7azen0O870qDmSlwxSkXrAvyl8DGgzx1HgtUXk21640u6mbVn5nsyypzTeMn5k/GFGk8Bk1wC5uLGy1ajf4ZZaxUAA=
Received: from DS7P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::34) by
 SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.27; Fri, 11 Apr 2025 18:22:01 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::1a) by DS7P222CA0014.outlook.office365.com
 (2603:10b6:8:2e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 18:22:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 18:22:01 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 13:21:59 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 2/3] ionic: support ethtool get_module_eeprom_by_page
Date: Fri, 11 Apr 2025 11:21:39 -0700
Message-ID: <20250411182140.63158-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250411182140.63158-1-shannon.nelson@amd.com>
References: <20250411182140.63158-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|SJ1PR12MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa06ec4-286f-4b3c-5f56-08dd7925c102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ISljVVmWBlR6WUq2wKMaxk1rY8m1B4tOeMqGYz36rcED11LRSYUpIJPXIHlm?=
 =?us-ascii?Q?wnjlGminxNZHjhfy6H3Yzuwo+MpWNoyiixi4ZrKh4oQf+OgnYT0VSTxntN/X?=
 =?us-ascii?Q?J09nNJX74UR00/P5xmiXsLY8JCzAGLCvLfIaGbUS/H25aqBw5f7sZgj3NFy7?=
 =?us-ascii?Q?j+90c7rVY9wfeLFRWeZTaPif3zQ7CDHpop4fMKZD34GHR0GYlvmGffoDaHIa?=
 =?us-ascii?Q?bmmrpI4VYq3FAoheAUYuV0tKoBNU2r6QfdP6ugKW9oByqmUaD8y9VQ1GwTeL?=
 =?us-ascii?Q?U5BmFAVqumxBO5V8pSi2cTpmVJdHYt9RUp40acuHWD/nkrZhx7lvaj0Ob6js?=
 =?us-ascii?Q?T35mlzpHw2jHf+LQMoxNDvkqDmZ4XJdzaMxfx48bU7vMAJHqybmQzTJvDfe6?=
 =?us-ascii?Q?TS/4BIrhbTjSmuh4sYwwPuxgboB3p3i3HTJxrqdSPrsClIRVRO2znhhwwHEd?=
 =?us-ascii?Q?OAidRB7hVazC8PkZiOwcI2mp+xc8rf1O6PsW9ozetzlkyzd1If0w22pidCu1?=
 =?us-ascii?Q?2QohByWg9mzXuC5hkbomj5eV8i1wHx4O2rdrKnBhIrjnSOwM345tUgK+r3Gn?=
 =?us-ascii?Q?CKUNtdMzrKwIMXdiiSmH7HXDTg0tkD6XcDHX1OxL6bdygByrWhrFvTkWdwcQ?=
 =?us-ascii?Q?D9ZC8LYxEOtrBjxKnBjn/vYLWjP/Uo4+e7PA+/rmH3Dbeyz8EVWaFTS2hPgo?=
 =?us-ascii?Q?hWu7En7Mzx+8cGjkyCKn2OWNmO00tQ5HSCgF90QsKTmIeQ3+YP/tht8ObmFs?=
 =?us-ascii?Q?JlCvDNYV6ZknmuRCOAyTSrNwp9eLC1Ry3axB3eUetDe6iQ6MMRXAiTcrcRFR?=
 =?us-ascii?Q?hNJZL42QW5eg5Zm+0P1BdHcMQFm9XwbsbRC4hme18MDAE49JLDc/BtfFuLbV?=
 =?us-ascii?Q?kRyQcNJ5/cBzhL+GY9xmBrg+4pQjBauVdx7xxbAHNSj4eZYD74p6i0cABe9W?=
 =?us-ascii?Q?XT1iw2GmNrQ1TaN6uvAIOTbZIlSxY6KUF8WZ1KKcXYtic8zQDKUc6dL3Wgzv?=
 =?us-ascii?Q?WeI834TWYXp4t9bTWxVKjlbzWnYXbZO6pIOcCNiM0mqFsK8uAvVDjylvB02E?=
 =?us-ascii?Q?kJNnF5jizXlFUPessef55+jZ7Muzsg514HJSApORY8WX+s1254Vz7jg2UCT/?=
 =?us-ascii?Q?epybWcxNnZgKFMdjfwOm+z302pMWxXAqG8ZkZ+AtOHfeYPhfzWskoT5/Am/X?=
 =?us-ascii?Q?mYhmtcgMH/svUrqbMwOO3z2ndrggYNCR8Edcrn6qemN0a4EHoRCVW1RAY+Ck?=
 =?us-ascii?Q?+0tNvQtRJp0DdN01DH/fZNmAVELi8yaHVhhSdGwWxv+HOXawuuBjoqSkbNGJ?=
 =?us-ascii?Q?PrdvJRSbhAH7fQBpDPQVh3dg2HFZBV0ExpcsX38MscPrmOmzA8lx7zcQ3rCx?=
 =?us-ascii?Q?B3vBaoxTzgRvF57TcWl5FhZAPH/a1+xczJ5WBwvqla4bCutGlv1LL+cCknG0?=
 =?us-ascii?Q?appNXRwc005Yx/zhD1Ywp6kYAjxDciNdieBJ5OQUOUksgobAvbQ+5xqyYcSY?=
 =?us-ascii?Q?7qChXjWKs/8Zph/Tm349JfIKDMXcF0p9mBE5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:22:01.4449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa06ec4-286f-4b3c-5f56-08dd7925c102
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027

Add support for the newer get_module_eeprom_by_page interface.
Only the upper half of the 256 byte page is available for
reading, and the firmware puts the two sections into the
extended sprom buffer, so a union is used over the extended
sprom buffer to make clear which page is to be accessed.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../ethernet/pensando/ionic/ionic_ethtool.c   | 50 +++++++++++++++++++
 .../net/ethernet/pensando/ionic/ionic_if.h    | 12 ++++-
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 66f172e28f8b..25dca4b36bcf 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -1052,6 +1052,55 @@ static int ionic_get_module_eeprom(struct net_device *netdev,
 	return err;
 }
 
+static int ionic_get_module_eeprom_by_page(struct net_device *netdev,
+					   const struct ethtool_module_eeprom *page_data,
+					   struct netlink_ext_ack *extack)
+{
+	struct ionic_lif *lif = netdev_priv(netdev);
+	struct ionic_dev *idev = &lif->ionic->idev;
+	u32 err = -EINVAL;
+	u8 *src;
+
+	if (!page_data->length)
+		return -EINVAL;
+
+	if (page_data->bank != 0) {
+		NL_SET_ERR_MSG_MOD(extack, "Only bank 0 is supported");
+		return -EINVAL;
+	}
+
+	if (page_data->offset < 128 && page_data->page != 0) {
+		NL_SET_ERR_MSG_MOD(extack, "High side only for pages other than 0");
+		return -EINVAL;
+	}
+
+	if ((page_data->length + page_data->offset) > 256) {
+		NL_SET_ERR_MSG_MOD(extack, "Read past the end of the page");
+		return -EINVAL;
+	}
+
+	switch (page_data->page) {
+	case 0:
+		src = &idev->port_info->status.xcvr.sprom[page_data->offset];
+		break;
+	case 1:
+		src = &idev->port_info->sprom_page1[page_data->offset - 128];
+		break;
+	case 2:
+		src = &idev->port_info->sprom_page2[page_data->offset - 128];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	memset(page_data->data, 0, page_data->length);
+	err = ionic_do_module_copy(page_data->data, src, page_data->length);
+	if (err)
+		return err;
+
+	return page_data->length;
+}
+
 static int ionic_get_ts_info(struct net_device *netdev,
 			     struct kernel_ethtool_ts_info *info)
 {
@@ -1199,6 +1248,7 @@ static const struct ethtool_ops ionic_ethtool_ops = {
 	.set_tunable		= ionic_set_tunable,
 	.get_module_info	= ionic_get_module_info,
 	.get_module_eeprom	= ionic_get_module_eeprom,
+	.get_module_eeprom_by_page	= ionic_get_module_eeprom_by_page,
 	.get_pauseparam		= ionic_get_pauseparam,
 	.set_pauseparam		= ionic_set_pauseparam,
 	.get_fecparam		= ionic_get_fecparam,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index 4943ebb27ab3..23218208b711 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -2839,7 +2839,9 @@ union ionic_port_identity {
  * @status:          Port status data
  * @stats:           Port statistics data
  * @mgmt_stats:      Port management statistics data
- * @sprom_epage:     Extended Transceiver sprom, high page 1 and 2
+ * @sprom_epage:     Extended Transceiver sprom
+ * @sprom_page1:     Extended Transceiver sprom, page 1
+ * @sprom_page2:     Extended Transceiver sprom, page 2
  * @rsvd:            reserved byte(s)
  * @pb_stats:        uplink pb drop stats
  */
@@ -2850,7 +2852,13 @@ struct ionic_port_info {
 		struct ionic_port_stats      stats;
 		struct ionic_mgmt_port_stats mgmt_stats;
 	};
-	u8     sprom_epage[256];
+	union {
+		u8     sprom_epage[256];
+		struct {
+			u8 sprom_page1[128];
+			u8 sprom_page2[128];
+		};
+	};
 	u8     rsvd[504];
 
 	/* pb_stats must start at 2k offset */
-- 
2.17.1


