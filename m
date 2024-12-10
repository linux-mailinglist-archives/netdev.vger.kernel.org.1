Return-Path: <netdev+bounces-150779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6710E9EB89D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18626162F9D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AE61A9B31;
	Tue, 10 Dec 2024 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XidT/eW/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EED878F26
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852931; cv=fail; b=EuRmc0e3SLKtTNFzwuZ//7QSwS0oLW0y4dnsY/iBOQ2gM3rW7h+xv+3UXMfJz8LsOpn8B7fN96gh21caFtVBIyTgd4uPC3/RVX7GIoDGUqxvn+XLa2PkFdx+hbE9Fy4qBZWwJX5S0TYRuJdMbibijRkYSQ/4tWqj9OeKXHUG0r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852931; c=relaxed/simple;
	bh=QjyKvDEjOTdz8yTHYMQoAMpz4rK6ffPI4rCPTjeRQ8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LejMLY9G7sLtBvN+U4dJvjhq1if9qHDWuLcUYkhm0GLwj5TI8eN8Iu48/HFBA2fWsYp6tnAN4hI+J2PAMBP2MCGOGKld7p95Gj0snQpjFUFolUYZndp0HMQ8havWbvlnu2aJy8t4rsHsIpkifW3j3zWlpVvtbaV2wcomlTWM0xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XidT/eW/; arc=fail smtp.client-ip=40.107.95.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWz9rvWAlhPLmLEUmo7TSkh3USS/M+gBvk9P4cN1ESMecd/nTkvpbQAs1EsXPvFiWZR/sPvXd9iy0bavb3m9mbEpH3tWgdASP5KViojPMaIZ6Jak2YhTeqi8OXmwxxw+WJfUau9OC3mdVc1PDURmbl8ev5htmKiM3YXCJYaJGbyQkE+KE31hct3YsSvtidoWHNXbl9jOBVhtmHShDUWYFKz84Bafbqh003JjFpU4GDCZfvn8ftCvG9pv+YB5mul8iaH2ZtcwU7llBNzArUBzVRQ0a8muDgGU5oQBQhE+8B6WWAmhpt7DM2DlkLyh8JND/3Z+KXKA+5L/XfdbWpZOZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JR1M/sOL4VO0YCKpi4wzFqX9239MxQnd6XtIsHRjz40=;
 b=YWuepzifHxzaf5utYoDEZTu5UgJnJVV8uQJAHnMXnfkOId45e81Kf3ou7f72KlRHC+sPXFswds4DGQXEyxe0/Tu4S4G4aChMTbqK+OvCdamWR9VCKKGi5bn7kXLM6OQXqj+H804BAy6X7PFT0A5i6Ie9iZlgjd0tfz8Q+ZwOHaNRiHO4rPTjeZEafDLi9fJOvI//bOzgIj9bAGYs1fddZW5rzPK2rrByVIJRFWf37Wimn0nygp6iG/CD0brjlFx8WEoHDytCCnBuvCLL5pY42JKN/Epepo+4KD8a7lUnbWbtt/9QCsrCW3+lmJQV+8dbQctDt7QJb6/STCKiwdmP9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR1M/sOL4VO0YCKpi4wzFqX9239MxQnd6XtIsHRjz40=;
 b=XidT/eW/IHju3zPs2JLFHLjMxnFhHi1hpv0+w17oPXuPQS/lhcnNNxBiZzTwWxsNV5ETQAsRl550gSkbXv45xf0/Es21ekhnzmfO/vkYxna5sL1lkfePkE7pQcXfSHm7VbhsUnEkoltzP1y9pkQ7+BDDVvCPaHo56bCpIpI1uHY=
Received: from BN9PR03CA0345.namprd03.prod.outlook.com (2603:10b6:408:f6::20)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Tue, 10 Dec
 2024 17:48:46 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::b) by BN9PR03CA0345.outlook.office365.com
 (2603:10b6:408:f6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.21 via Frontend Transport; Tue,
 10 Dec 2024 17:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 17:48:45 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 11:48:44 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<jacob.e.keller@intel.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net 1/3] ionic: Fix netdev notifier unregister on failure
Date: Tue, 10 Dec 2024 09:48:26 -0800
Message-ID: <20241210174828.69525-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241210174828.69525-1-shannon.nelson@amd.com>
References: <20241210174828.69525-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 102a81f4-92df-4c70-b138-08dd1942e53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K5t1E9/mdCBnuQoOeICxrrfywifjLnusXTW1zf37gBmXbsxTYPqYtPLjZ9KO?=
 =?us-ascii?Q?d5zLJAzzamZS9Do7ynGpklLo3qpp/TkYnxmTqbeBUKlIsqGXUe0jwK9PrQLT?=
 =?us-ascii?Q?LnpgeaUwdnSgr+j5aTV7wP3+girr0UKJ1I6t4uL0La72lg+kzm3VqrLRwHau?=
 =?us-ascii?Q?PqSpRXZImi32820erR+E5mhB/Urvt7kr+pbGfm/7wzAecg9irGEb+Tp5CS0Q?=
 =?us-ascii?Q?gu52vFPgydTfKC4KT+98eNSKrouKNLYdiZ26V40Jh2sClePIqk7YnwD/6k86?=
 =?us-ascii?Q?O4qrcwQ5NaxlcmrFUU3tBNcnkcaVb1BZjTpPXxGmM6G1XdyDis35lOKATVL9?=
 =?us-ascii?Q?kSeTx4wOfl3nj0RN+p2CTtByh4MT5sPUswqLbXYE5UWeV6fcHH9swgoLMLDx?=
 =?us-ascii?Q?B8D98IjJYuSIX7rszVmMdoBsR3Ojh8EqhnOR3fB0v9RVDLDqqKuQZddhVJXc?=
 =?us-ascii?Q?FA+M4tI6+Y3671783a+5v3SgCTYoW5dZybwdkJ3QA69b2TDfWgJ/6SrXHB8q?=
 =?us-ascii?Q?R3+kRt3Lorbyj8Xhi2vReyKt3te3SM0aqe0RATAXjg+aTlqgIYcxYkOm5dZt?=
 =?us-ascii?Q?bIFen6ZKtKCYL5ge/JIDQDUh01NW4WIq6Gu5EiWo8x5njf8o13o7lllh7MEO?=
 =?us-ascii?Q?AzaDvioX1zfwT+0hqUw6VUnCv1ywZjMS2ECM71kPIdF9osTUn+cU5od17X5q?=
 =?us-ascii?Q?3I6/NAaI0GNDXLksC1H0V7bNBfwJY+qNSbkYhe2DmNAY68rCPfSaPeL9jdt9?=
 =?us-ascii?Q?FSn0Z9SFtgQ6uqYP/ffHc8pAA88qIBleTQdrzz/v2jAIaBE2XAKsUOknkF9i?=
 =?us-ascii?Q?JquroCg0L2J5MxAlzxOToDMEOIqhVvd4NErJ3iF+BX74J+LuGWSBq7Hv6hnY?=
 =?us-ascii?Q?g/PikVbD338matGlkypGaP/uwLQGGanSjRDaC41F0lhR5esCtx0N1D/ohZNC?=
 =?us-ascii?Q?g5emWtym8bkM9Ajf1Wdocy8B0wCkaeRB4lqZ9zjht+BDq/PRwC9Hdu2jv8R+?=
 =?us-ascii?Q?KZNgeXzqbpgZnZwUt5eBL4ls7FAkujSWUH4BKf64BSLHLRdNCKs488sOGq2D?=
 =?us-ascii?Q?hREjPHtSH48I3UmpoCia+c9qLDEz+qxhIvIbdTQNPRJuKzkiYfBF/vyFmDzc?=
 =?us-ascii?Q?vbqtjTPzQvNMpc7QhPYtZPS4o4b0kb6ahy70WXnY1Bfm9HXfve7dvK8XRnqc?=
 =?us-ascii?Q?ikWj6IuSBGHEe3VMMQhH0VSiuQHFUbHrt28fr8QxbSYfAEB3lZImaTeI9uqb?=
 =?us-ascii?Q?VIx5is+9n5YA+wnvAhrHs885w78SI6Zwv/PVwQvT4q5A0cSK8p0BqGsoOBz+?=
 =?us-ascii?Q?/dmfx+cgCD0l4kpeCLgj4nAEQ+ahSLKUbGQy2Vlidk3RJExK9tt8ad3DVJw9?=
 =?us-ascii?Q?ZGXJOYwtUAHgDVvAY6tfNk8zHgaQQW93gyYf6on6jEqpLIlrDpsba0mItltw?=
 =?us-ascii?Q?wNBbdhRa+SjATsfm6VWo+ga7QZNTMeqD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 17:48:45.9749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 102a81f4-92df-4c70-b138-08dd1942e53a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144

From: Brett Creeley <brett.creeley@amd.com>

If register_netdev() fails, then the driver leaks the netdev notifier.
Fix this by calling ionic_lif_unregister() on register_netdev()
failure. This will also call ionic_lif_unregister_phc() if it has
already been registered.

While at it, remove the empty and unused nb_work and associated
ionic_lif_notify_work() function.

Fixes: 30b87ab4c0b3 ("ionic: remove lif list concept")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic.h     |  1 -
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 11 ++---------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
index 1c61390677f7..faaf96af506d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic.h
@@ -59,7 +59,6 @@ struct ionic {
 	DECLARE_BITMAP(intrs, IONIC_INTR_CTRL_REGS_MAX);
 	cpumask_var_t *affinity_masks;
 	struct delayed_work doorbell_check_dwork;
-	struct work_struct nb_work;
 	struct notifier_block nb;
 	struct rw_semaphore vf_op_lock;	/* lock for VF operations */
 	struct ionic_vf *vfs;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 40496587b2b3..bfa24c659d84 100644
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
@@ -3869,8 +3863,8 @@ int ionic_lif_register(struct ionic_lif *lif)
 	/* only register LIF0 for now */
 	err = register_netdev(lif->netdev);
 	if (err) {
-		dev_err(lif->ionic->dev, "Cannot register net device, aborting\n");
-		ionic_lif_unregister_phc(lif);
+		dev_err(lif->ionic->dev, "Cannot register net device: %d, aborting\n", err);
+		ionic_lif_unregister(lif);
 		return err;
 	}
 
@@ -3885,7 +3879,6 @@ void ionic_lif_unregister(struct ionic_lif *lif)
 {
 	if (lif->ionic->nb.notifier_call) {
 		unregister_netdevice_notifier(&lif->ionic->nb);
-		cancel_work_sync(&lif->ionic->nb_work);
 		lif->ionic->nb.notifier_call = NULL;
 	}
 
-- 
2.17.1


