Return-Path: <netdev+bounces-150799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AE69EB958
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 19:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627FA167A2C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A57D1DE2B4;
	Tue, 10 Dec 2024 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0ZMxkllQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B206D70820
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855472; cv=fail; b=Wb1ln2Um5XJtf0X8s/E01sVZzNinWvJa4eiTAUcYD00U/j7ky8O3iqXBVw28VcwyK9zLn5Mfqh9F5cD0YYr3OGKJEzCpx64wUkOdgMry5ScwLC24VsZX5lhl1y3PXtK7tYuUpOsQpesfQStQDAAf9Xugk0YKni75x1qIe5//17g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855472; c=relaxed/simple;
	bh=XI+3bXRz+koYDK5KtOODE/HaSCQvq8tJ8ITXsz//oi0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oV2tAE82Tr/Woku5cL2Z8NwSXJ7xMo9gnPQTaMweqjZzoEcC/YX3/EHngRu6G00BiPH0/3f2YECG4qgCKI4LDLfxG3wzQcky9Z/knAs5NFklsZAXzh16q3tVW6w6kOeCYWAMI1XWhgko1ASADWQVBwqHdAj8CldNSVErVe8XUsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0ZMxkllQ; arc=fail smtp.client-ip=40.107.102.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drmZvaVDsSru9xZhRIVXTRtXDEQUU8Ze2/8yWk11/FLofJpZnitj7KahcoDDnjxyPYl2yTX/u0Hqc4rc834kINoRGHGhwSZF0a2nqWTor3oBj2mfrXs+RZS3oyyMm5DcS3LS7hN/MiU65LzCXrbbcER+9Xy4paUmTulNalKLw34ATQj71SvVh4f7sKfUe7GLdhOLOQXHvprwpaN53G6uecOVFUiN8hiBMWEYtqN52mLjYVInPAOHX/2zruORb8rsznj9AmFdm+iYLdOB0tgqL4bVOaDyfZo9KZczHeF2hrEqyIzdiRKVkSAwdOUJG8HL0/f210csRi+9eeVl+QuBCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJMO8uqS4TfZoIr40Z0kSGKYEyXGnt3SXHPpZgQGQio=;
 b=Wu+9K4mhEuMLYkiXC3CwhEOhQhhFXeWZqBULzunIWvJe4K/qp15yFMpXcVcgBbIydUKwHMYnhpXz5+zp4wVs2V5fuIu3haweNLaWzVQu30Wrrh68BVogqPltnEKdOJLkkoGxk0re8I9clscP0Z0y4CA5c/whZUPi8vF0FqjUNHzNAU4tYVSAZMSt77Nbby5686C8YB+fQkJA1Chf4MzhQQ4E+BhF8aI2kD7m2UZNilC6HVagsZiPDlXQnCLcYAgh0wOoXhjfm3Cdf96i0Tx7x0NiU2rBaBmmHS7SGCdDG6xeLysvqizk7tqt+vm7pRqiwrRBBOcgqMM8JERrXCQpHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJMO8uqS4TfZoIr40Z0kSGKYEyXGnt3SXHPpZgQGQio=;
 b=0ZMxkllQAKVrSt49HIb+4vzZ6qq58Oy8MOHCD72MDLz/+eMsJmr7zUI2Uu9daWLBRxxAYQ+rVrw6o+jsZhmDlro1E3jDwo2wcLvGc42OruiXQJlWS1Keh2sXJcoXPPdKUtqb0UGi4fJJOs3fRIjaMlrAuAnN7GK3B7yc7V2JzXQ=
Received: from DM6PR13CA0009.namprd13.prod.outlook.com (2603:10b6:5:bc::22) by
 IA1PR12MB6188.namprd12.prod.outlook.com (2603:10b6:208:3e4::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Tue, 10 Dec 2024 18:31:05 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:bc:cafe::79) by DM6PR13CA0009.outlook.office365.com
 (2603:10b6:5:bc::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.9 via Frontend Transport; Tue,
 10 Dec 2024 18:31:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Tue, 10 Dec 2024 18:31:05 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 12:31:03 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<jacob.e.keller@intel.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 4/5] ionic: add speed defines for 200G and 400G
Date: Tue, 10 Dec 2024 10:30:44 -0800
Message-ID: <20241210183045.67878-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241210183045.67878-1-shannon.nelson@amd.com>
References: <20241210183045.67878-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|IA1PR12MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a44c8b-0e1e-4599-94f9-08dd1948ceca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xhZw9akhEgQb7R3hZhDvRyPrDYhNL3pbkfyr3d9QQJLidvjkgdDmbj8L/k25?=
 =?us-ascii?Q?nLNxWaPOOywf/Zbj44p3iSqlEfdhlHYNqYRJ8FdgtJa4KidjSiaFXOZ1xywE?=
 =?us-ascii?Q?Vc/lFYP7KSSu3BitkaJWK0kQkGntoOGsX/3Ab0XWdGG8MCQsQ7l0kqJ2TI08?=
 =?us-ascii?Q?PRCsM7CMn/xi42Sgn5FSvhbWZeKksSTdyxUPNmPz8YDgjEilygGw/VnoWF9V?=
 =?us-ascii?Q?id0tRg7cuDSu8gYZFPPK7zQVxmCtVCCr819rmx/1caQiISz1m0lsOF3/LeE/?=
 =?us-ascii?Q?4yHYTPib5+Ne/w8hCb1ot+DBUjyZ3HEmh4x3otAKARZ6fJmxXo4Wb8BEc4np?=
 =?us-ascii?Q?PjMHFQQS3cM1tqhScRiZD25D+gbwUU3HaDiMBSWOXvRy2MPrNSC1ipIVbDxL?=
 =?us-ascii?Q?lFysrSSQ8byzUW3YvARHxPJILYaBUtdJMnA5GkG4fLyy11ejEypwm/9d9+o2?=
 =?us-ascii?Q?X/Oem6f6OI6vT4akx5+8Cog1qyewuV2DIKaZLkbOpr2570dlmTA2vskhP2gi?=
 =?us-ascii?Q?Ouelb2i1Uag4EHSSZFGFC1NqrP2qjnhUxM3TV/3euHOnh0uOZRJ8CBvePkA5?=
 =?us-ascii?Q?w8pas3z5GNxQgu3jcFLXHvPWplK0mTjB2b+UlwXfbGDxAlNct42XMpXfid7N?=
 =?us-ascii?Q?a3Vp2qdzfv2ZbgaJtNlogUlpSs+vxb3Y9crFyUMcQKc2l/ddrnhhW7hLNNM5?=
 =?us-ascii?Q?gVebDgJH6qaJUgYboJw+uHFyzocGe2UQ7zEUzfNTqsEhQeR1tDSlxE+H9CrK?=
 =?us-ascii?Q?1tAqouW/qDj2CckB2oc6f1uV7gmmFEKiczxpYmMKCVpvepFnxtCTCj78o+z6?=
 =?us-ascii?Q?524JR1r0eZcX/J6C7MO0uvkIQym2cl708+vaiC4HQyI+677QPZTjlSfeFBLN?=
 =?us-ascii?Q?lHzV2ExUrcRE7a9/oqhM1uusSfEpsD1UMKyzpq+9wV7j2g4McBw2r2aWivry?=
 =?us-ascii?Q?SG6pqkh7fQ1q2FibgZ1+9rGMHWZsZpnS9HPLYTa5jestWlxiiqRDvnArHDxy?=
 =?us-ascii?Q?1nJw13A5m4RsIn/d9qlBXxD7qAziszxmvZydeLm+tz82iEwTHI5pHVGGySwy?=
 =?us-ascii?Q?/UXLgBqvnwSfNWl7WSBf1VJTGnZn/3n8SD7b0j5rWUKVztiJifCpaaXd0PyX?=
 =?us-ascii?Q?xUtcjqyMeXOCOkJTLnXADmI3tvwMZvQrRI9oXoN4aN734OxkctJ7LKv+XHVl?=
 =?us-ascii?Q?I8DLZogi84d/1/Pcf8uoF5ogvwPzbAK/V3MdWD1GZKDXM4iIkIpfZmizIeRk?=
 =?us-ascii?Q?+663xKus9LHmTd+C/HToMm+Eim9f4vYpV8e4Uv68O2mSvDYUCSiJPWzoI19F?=
 =?us-ascii?Q?zdoATrkRWBlrZpJ7eaE5UHE1ipfUo8TEywTzWET6l2rLv8M0pcO3mVvRQzI9?=
 =?us-ascii?Q?B01ycFok5ys6tpeTiQN5RJGGmoeJYZaXerMpuoo55ROU3t9tRxcskAI4Qtll?=
 =?us-ascii?Q?/STS9Dp9z+gJZ7VGBDk5Z8lpR/U+ygD9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 18:31:05.3107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a44c8b-0e1e-4599-94f9-08dd1948ceca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6188

Add higher speed defines to the ionic_if.h API and decode them
in the ethtool get_link_ksettings callback.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../ethernet/pensando/ionic/ionic_ethtool.c   | 39 +++++++++++++++++++
 .../net/ethernet/pensando/ionic/ionic_if.h    | 16 +++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index dda22fa4448c..272317048cb9 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -158,6 +158,20 @@ static int ionic_get_link_ksettings(struct net_device *netdev,
 						     25000baseCR_Full);
 		copper_seen++;
 		break;
+	case IONIC_XCVR_PID_QSFP_50G_CR2_FC:
+	case IONIC_XCVR_PID_QSFP_50G_CR2:
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     50000baseCR2_Full);
+		copper_seen++;
+		break;
+	case IONIC_XCVR_PID_QSFP_200G_CR4:
+		ethtool_link_ksettings_add_link_mode(ks, supported, 200000baseCR4_Full);
+		copper_seen++;
+		break;
+	case IONIC_XCVR_PID_QSFP_400G_CR4:
+		ethtool_link_ksettings_add_link_mode(ks, supported, 400000baseCR4_Full);
+		copper_seen++;
+		break;
 	case IONIC_XCVR_PID_SFP_10GBASE_AOC:
 	case IONIC_XCVR_PID_SFP_10GBASE_CU:
 		ethtool_link_ksettings_add_link_mode(ks, supported,
@@ -196,6 +210,31 @@ static int ionic_get_link_ksettings(struct net_device *netdev,
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     25000baseSR_Full);
 		break;
+	case IONIC_XCVR_PID_QSFP_200G_AOC:
+	case IONIC_XCVR_PID_QSFP_200G_SR4:
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     200000baseSR4_Full);
+		break;
+	case IONIC_XCVR_PID_QSFP_200G_FR4:
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     200000baseLR4_ER4_FR4_Full);
+		break;
+	case IONIC_XCVR_PID_QSFP_200G_DR4:
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     200000baseDR4_Full);
+		break;
+	case IONIC_XCVR_PID_QSFP_400G_FR4:
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     400000baseLR4_ER4_FR4_Full);
+		break;
+	case IONIC_XCVR_PID_QSFP_400G_DR4:
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     400000baseDR4_Full);
+		break;
+	case IONIC_XCVR_PID_QSFP_400G_SR4:
+		ethtool_link_ksettings_add_link_mode(ks, supported,
+						     400000baseSR4_Full);
+		break;
 	case IONIC_XCVR_PID_SFP_10GBASE_SR:
 		ethtool_link_ksettings_add_link_mode(ks, supported,
 						     10000baseSR_Full);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index 6ea190f1a706..830c8adbfbee 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -1277,7 +1277,10 @@ enum ionic_xcvr_pid {
 	IONIC_XCVR_PID_SFP_25GBASE_CR_S  = 3,
 	IONIC_XCVR_PID_SFP_25GBASE_CR_L  = 4,
 	IONIC_XCVR_PID_SFP_25GBASE_CR_N  = 5,
-
+	IONIC_XCVR_PID_QSFP_50G_CR2_FC   = 6,
+	IONIC_XCVR_PID_QSFP_50G_CR2      = 7,
+	IONIC_XCVR_PID_QSFP_200G_CR4     = 8,
+	IONIC_XCVR_PID_QSFP_400G_CR4     = 9,
 	/* Fiber */
 	IONIC_XCVR_PID_QSFP_100G_AOC    = 50,
 	IONIC_XCVR_PID_QSFP_100G_ACC    = 51,
@@ -1303,6 +1306,15 @@ enum ionic_xcvr_pid {
 	IONIC_XCVR_PID_SFP_25GBASE_ACC  = 71,
 	IONIC_XCVR_PID_SFP_10GBASE_T    = 72,
 	IONIC_XCVR_PID_SFP_1000BASE_T   = 73,
+	IONIC_XCVR_PID_QSFP_200G_AOC    = 74,
+	IONIC_XCVR_PID_QSFP_200G_FR4    = 75,
+	IONIC_XCVR_PID_QSFP_200G_DR4    = 76,
+	IONIC_XCVR_PID_QSFP_200G_SR4    = 77,
+	IONIC_XCVR_PID_QSFP_200G_ACC    = 78,
+	IONIC_XCVR_PID_QSFP_400G_FR4    = 79,
+	IONIC_XCVR_PID_QSFP_400G_DR4    = 80,
+	IONIC_XCVR_PID_QSFP_400G_SR4    = 81,
+	IONIC_XCVR_PID_QSFP_400G_VR4    = 82,
 };
 
 /**
@@ -1404,6 +1416,8 @@ struct ionic_xcvr_status {
  */
 union ionic_port_config {
 	struct {
+#define IONIC_SPEED_400G	400000	/* 400G in Mbps */
+#define IONIC_SPEED_200G	200000	/* 200G in Mbps */
 #define IONIC_SPEED_100G	100000	/* 100G in Mbps */
 #define IONIC_SPEED_50G		50000	/* 50G in Mbps */
 #define IONIC_SPEED_40G		40000	/* 40G in Mbps */
-- 
2.17.1


