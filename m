Return-Path: <netdev+bounces-151515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7E49EFE1E
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476F7168C68
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 21:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02DB1CCEF7;
	Thu, 12 Dec 2024 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m/7gSEHZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36AE1D54FA
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734038468; cv=fail; b=ObkosT1SUJnhUv1UBGpjbnEws1l7Z3d3BzqCFVDCU/R/1bbMHvT5lR5RDOcNtUMrV+FFyGfsdvT8n5w3LtYjiW19ftppabkOz529PfO5/HcxfEUeEnZB5tqlZEauFH2EyVnh8mCAmly9pngtDs4ezbCuFNU9TIbBOO0lWA+ASmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734038468; c=relaxed/simple;
	bh=YyfskWuswKkIpytVCgIcKrg49nolw/MeK5D5i7P2XHQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HozfJ8mvggghDeu7Wb8/WcPKCJLUOlNp9E5Tokublro4wKWkjwPPammxsjXnSIW1E3S+5u+BFBNkZKM3M2GAGx7cfDjGUa5ECDcKmu8ZNpqv0rdem0o5kbJBtN06zmZ5FprJgZc09quWMCATuXir6GjoveFGBYDyEHV7dnhaY5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m/7gSEHZ; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrMmRP5rL+ZhuXdrbUnyRWtea3LTMbEvmV7YDYyrtL12WeY576Wd4Vv8y3h01QKaAZROUukDAMWuGb22j22nd6utCEwNqOIAJOJgnofvQq8FHlxwNNKsEY+FkdUqmdWKBwnaUhRm1CulC5u5295omSj2kNpMOV81Isally5PNX1xD3S1pEyeV62udqrYG0YXxV9TSjj3/6Gmf1abmWOayLPGgEj3Ui2F2k5hQ78QMCIYo9fpR3F29bp/1yCGnDgW/1lLvMNg/gQ9fV1By/mqBMIGegf0KyNCY3bDI/GZPLVeL9/kH1Tkcl6a6qu6Dlzmo5G+5OyWMRAHwgNw4YJMpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gQkPRX8g9OywP39Q+rvc3/CdO1Zm2ko/OLdaVP+R30=;
 b=nvVG+xJ3z3pAFWJLJwcYNJniAUET6z7Gfm/SswFtkUiyoWZ7ABnLfwsUCoZ8uSOCsMuD+u7HwWjdOXNOt74cWKimjAWvSBr6cavlYHXUT/yGMhSZZs6aP1jXfhE7e9DzgHNAQWxjbUpTjxYtW1Bud69MOo/gN1ycD7h9LWU7DQl9ut4rkuACszMDHSb8/L1IcNrQEW8r30tjH0kdFjXw0dUEV1j0/atnD9dP7URkb/+jkNFVqHxip2F2crJymSlV3UTSz4GxnSYIMva6hLY3aCW79+Mt5H9dnlnfzLY1A5Te91Ws7QuMLFnnNjej2eIRvv0RZfFkpNx0FzkOK1ghbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gQkPRX8g9OywP39Q+rvc3/CdO1Zm2ko/OLdaVP+R30=;
 b=m/7gSEHZ83h3ftFS2r5lIioyU6CUT17gfek+iZ58C8D4B8Sz7r8kUC+f2vDWJGMkK9YQ1M2uo2Tts+YIX3IL3GyPH964roN6z7itQdeF6MFhb0QWaCMFlwNWR5bUOlFQG7LFNGuAEM2tdUAhtAKufHwFJPUCn1Uhqp+AiNiDzHI=
Received: from MW4PR03CA0100.namprd03.prod.outlook.com (2603:10b6:303:b7::15)
 by PH7PR12MB6954.namprd12.prod.outlook.com (2603:10b6:510:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 21:21:00 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::eb) by MW4PR03CA0100.outlook.office365.com
 (2603:10b6:303:b7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 21:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 21:21:00 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 15:20:58 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<jacob.e.keller@intel.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 net-next] ionic: remove the unused nb_work
Date: Thu, 12 Dec 2024 13:20:42 -0800
Message-ID: <20241212212042.9348-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|PH7PR12MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 62cb74ef-94bb-48c4-3782-08dd1af2e069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oqvHeyO6lWYsP2xWfawCwVAI5W+ZWkaArjx7UeaeU6o1o+yrY29ijCyqfC2S?=
 =?us-ascii?Q?PgGf/Y35HOXU76AoLDWAVYxYCvMrLdhe/uuBXSsueWqozVQVFYCBwlH00dpz?=
 =?us-ascii?Q?9z29Tjbd8VejvkWxEMnDvK+oP1EW8mU6qdkX3BlN2C2Yv5GuT8QV9vBndQyA?=
 =?us-ascii?Q?iRCkqxdNtCu5MPIGz9tIOWwG9IJD9oj+lQ3qPaSAlP/x8m8IphIGdk+Bxbln?=
 =?us-ascii?Q?mafKfPWhjMPlQC/+yRFl99f1oKy6u6mgwCYyhdcZF+15MX64QNQfRRzXr57D?=
 =?us-ascii?Q?YNuW3FBljan7Z3/e34IUwZ9oSiwUE4T2/xfRjZ4WZCrkm/iWVVVhHu4ct6YL?=
 =?us-ascii?Q?sdpBshUydz5ZDlqnw3mID91QsFb/s1xGGidV70lLE6i0c1o0BPu/0+dClFQy?=
 =?us-ascii?Q?ekrvga0wXf1Q8tdCdUZJBNfcvpcZc/kYu2UZztBdhGl2CJ8DFrjEHv5NQaby?=
 =?us-ascii?Q?K7Gxo0RA7c9jGxxdzKUm9wsd51QpDBAz0zKY4nFxDxUUIvH2ASAv2wod9K9e?=
 =?us-ascii?Q?Cyrh30biGK2z1YyUWA+LZ5TwC0mFOWEjGVUKNNpBoz8J7w1jT+f/sM5uCeaV?=
 =?us-ascii?Q?H8OeDOGnNgsbXYhBPcAce+N7DMFrzmBccLFBOUJJBsGzy49DyMfaKdycmGle?=
 =?us-ascii?Q?Zx7e+/A+gR1ByWGjiS4yfVs0F8nRxW3V/ZQBduN6JCRv14qnbLAq3VFBDVCs?=
 =?us-ascii?Q?OKhV5X9AFbRDKvBY1KDEvtfM7midhFs6I9fD1lPVhVRcd5OkJJP2mvXl6qsI?=
 =?us-ascii?Q?uTgVzmN+RYNMkKpxK0lcAtIEIm5/zoavTMkHh2s4twoQsiZ8Pz+7H1hp23P4?=
 =?us-ascii?Q?+BaW0ba/OPY60UrgEmEEZveK2tW37rNKwDyHejI9qwp2gbVoKJQq+yDIA+P9?=
 =?us-ascii?Q?TIEnWtro1JjpaCXFare0Q+bXJF22cgJqtO7vE7/6QwF4vd7s1or9jztM3mQq?=
 =?us-ascii?Q?pqICeLpbwfkBbhsNLtbRNvAr/ZX+8fsA/W/ZIqUeFEF+lJujVGJmomDRBNqh?=
 =?us-ascii?Q?/baJiuw9hqb8RAXxdyTE+DpyPjBABwaAg+VwrCZeCjXwGlhFet37aFBIG09x?=
 =?us-ascii?Q?K+pwBw6wRh/tGM+xumIEHJf1frssP/cpO8xXUGyHY2GJWlNNiXIP8dSf5BIk?=
 =?us-ascii?Q?no3xzpLursGfdZViiNAnkZ5XCN0pzpKxsKzKiUgXnqxMi6mKHrYM6dN1ZkWb?=
 =?us-ascii?Q?AFSKFBtQkHCbTSxNZfE73KBROYMWpGBocwh2rQiQuKzxNeOnw06d8wX8EW6Z?=
 =?us-ascii?Q?h2FswK2I3LcNeE9y8jtA9rTpyVBvYCR2fXXKecXBEE+Y5lnDsGvFUOSCpSwe?=
 =?us-ascii?Q?a8xkUdwIwloSpSPUmt83RU35o9Cpm6obDxehCuctQLPZBVgL1i5gXGgwA+lM?=
 =?us-ascii?Q?85bY3u9e8DemwXaTpNNup6N/+BGFnihScoNFc99lvlepGQW882AR00TozTHS?=
 =?us-ascii?Q?KAuCpWAPfkwmrB8lajPF0oJHn8wfE5s4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:21:00.4315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62cb74ef-94bb-48c4-3782-08dd1af2e069
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6954

From: Brett Creeley <brett.creeley@amd.com>

Remove the empty and unused nb_work and associated
ionic_lif_notify_work() function.

v2: separated from previous net patch

Link: https://lore.kernel.org/netdev/20241210174828.69525-2-shannon.nelson@amd.com/
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic.h     | 1 -
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
index 0639bf56bd3a..04f00ea94230 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic.h
@@ -57,7 +57,6 @@ struct ionic {
 	DECLARE_BITMAP(intrs, IONIC_INTR_CTRL_REGS_MAX);
 	cpumask_var_t *affinity_masks;
 	struct delayed_work doorbell_check_dwork;
-	struct work_struct nb_work;
 	struct notifier_block nb;
 	struct rw_semaphore vf_op_lock;	/* lock for VF operations */
 	struct ionic_vf *vfs;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 052c767a2c75..05fb46effe0d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3804,10 +3804,6 @@ int ionic_lif_init(struct ionic_lif *lif)
 	return err;
 }
 
-static void ionic_lif_notify_work(struct work_struct *ws)
-{
-}
-
 static void ionic_lif_set_netdev_info(struct ionic_lif *lif)
 {
 	struct ionic_admin_ctx ctx = {
@@ -3858,8 +3854,6 @@ int ionic_lif_register(struct ionic_lif *lif)
 
 	ionic_lif_register_phc(lif);
 
-	INIT_WORK(&lif->ionic->nb_work, ionic_lif_notify_work);
-
 	lif->ionic->nb.notifier_call = ionic_lif_notify;
 
 	err = register_netdevice_notifier(&lif->ionic->nb);
@@ -3885,7 +3879,6 @@ void ionic_lif_unregister(struct ionic_lif *lif)
 {
 	if (lif->ionic->nb.notifier_call) {
 		unregister_netdevice_notifier(&lif->ionic->nb);
-		cancel_work_sync(&lif->ionic->nb_work);
 		lif->ionic->nb.notifier_call = NULL;
 	}
 
-- 
2.17.1


