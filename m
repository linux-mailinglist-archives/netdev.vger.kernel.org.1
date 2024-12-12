Return-Path: <netdev+bounces-151518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0817B9EFE4C
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B061885551
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 21:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD0D1C07E2;
	Thu, 12 Dec 2024 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FtRSmA1/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB521D9353
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039146; cv=fail; b=AixgNEY2Sm7usow+PypzXpVkF6OVjVf4ZBtPXG05qL9JMI7D4oCNcvQkTVeCdsfaLcrcuiuc8b+xK6CFx73q9vVulH1bdKBnthGgm3aNHZy6QqJh9W7l5QTKGtuq0px+YrIILqy6VMLnTQvxWpyIhZajMMhqrrc39M82pBLUlEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039146; c=relaxed/simple;
	bh=HpsaH56UpRcwfr3bFuJYIS3pxwzpiUPyb8ag9tfLJ54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBxGHwWzFR4ZTy3S/cdsT+hLkzi9DZ2whqODh1bw0LEDZW6NmWWKya6OjNskqIiEdqOYWlZMIxoQqSWca9NYyk0GJPeu0TcQUCNgPAcZ2pP5XTgiMnd/2wmwP4he/pZTZtWMGzPgE/uZhZ3m47X5qefimmZjU9eQXFssJicQYIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FtRSmA1/; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9LA2rJ23MATedjpjHmGeWkWicH0mQZKQsI8rvdKJCByOKqLXBBaAAStLMJhXus7c/AZVH/rSYszuOCgZADulF6bdmN2LpUJfI+8dIxQwCArd+jvszfnL1KLIYCQy/G7AWDNq4jO4Pxab8rlpUx+q/ENtmQh/CZ/fbZ1JB2DESqSG/AaoucDWxkV4FcM/BRJx4ybWpQBmb6wIqlSskTaZqmETqtsNbwhGMr8IW5SSw6ipJjMnwIMJ6HS8Qxzm5oXzizTtXrn0dm5+n7YrChYVRUjsdzSVDsdyUjF+6QKxuhUUhEMu7hOpuYZSyMOUNuqZSOCHO2w/sPTVXqeRiA8CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPMctx9mD0dB93bQg7HckZBnzyMCw4UeqoPD7OHyfWA=;
 b=gEqkb6VQSkDAyelAPZNwHA0fby7sj2NwDkJ/lfy6TD65KcKFInpKvvBTdleQRaU9G8UVwtV017/uMKK62q7RSjBJLf64jdQFcUT5BiZoch1f30VtZsWwHC8oWqbylgPs6mRfOBpYX/QcuxYaXkCWBwN2mQpPQI1abv9D/6wWQuj5a4329T+of0Ogy8p+qD2oQ9pB85fp39EhHoNknVqAl5iPrVtskTs7bxGo65WhOlsOVU2UYJO9ehwyVuvEZWdlLzOxdY7XHx+gq3FAH2iIugnNDvx5LXWKsJGRMbvoCDVKaTKuHowD8jk4BTG0P3E6Al4s4KPyhXa2m7pl29e4aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPMctx9mD0dB93bQg7HckZBnzyMCw4UeqoPD7OHyfWA=;
 b=FtRSmA1/EP6RiVhvVxStbAs73bl77IIrl++3+GSTn0gBcF3Fb7Pu02Cu01MLzHCAEbZKBZv7AXBAG2Obocdon3ffUQMqRQYxLYCIc0kj1k73NqutJWplVr/wh90YMXW13W8HDCxt5nJsPKOX76a/2luxeS2dNvd75WMPIxZqyu4=
Received: from MW2PR2101CA0001.namprd21.prod.outlook.com (2603:10b6:302:1::14)
 by IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 21:32:20 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:302:1:cafe::82) by MW2PR2101CA0001.outlook.office365.com
 (2603:10b6:302:1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.7 via Frontend Transport; Thu,
 12 Dec 2024 21:32:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 21:32:19 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 15:32:18 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<jacob.e.keller@intel.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 net 1/3] ionic: Fix netdev notifier unregister on failure
Date: Thu, 12 Dec 2024 13:31:55 -0800
Message-ID: <20241212213157.12212-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241212213157.12212-1-shannon.nelson@amd.com>
References: <20241212213157.12212-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 790e418f-d0f3-4276-8bea-08dd1af47523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gOemyGkhu1/79+ofVgaLvyLhxHQQacIN8ZGwVFz2S2Jq3XwmEQq7HHe4wWMF?=
 =?us-ascii?Q?5B/u7qdd0wF5/qG8Kgy5+yIDwL63H49/XlK7rRIjciX1KP+cYjssJ7lrAZ1j?=
 =?us-ascii?Q?2MDMXwWeCKakdnXSh2okm4sY9vpq5ldp/K5ihcREm843DO4+x+hQLPxWLnJZ?=
 =?us-ascii?Q?6+W5glmn9fqiV0627IWiNwag6clECAZE19Cu7vQR1HAnYmEsThMWWNHZzU/J?=
 =?us-ascii?Q?NvUHk5Ub0zvg1Ln1ZyA9EtQTjG+VYm94/VWcmxM8bHoduepki/0SPxY12W4g?=
 =?us-ascii?Q?Vh9eFOs+KRfiLRoqTSO+t6AcdNFNJAORAskfLLwLR94be1zJNqtE2kZG9TxR?=
 =?us-ascii?Q?qyf2hYUKjkUZZTmZSihsmCK6f5vOvTL4PoPx16ZghZJoCbf12M+URAcyDl2J?=
 =?us-ascii?Q?0oaoL0GGYIPUlA07XVSRsnaM7wck9q4KVj/UvU2Y3qqyNooZ3yT9kIzRmVBT?=
 =?us-ascii?Q?i/dHz9PRrLiM+Ydc7JJsdTTKXOUln1PqqyE5qAZxMhH9d1vY+IcijAhVz0EP?=
 =?us-ascii?Q?Wo4mtUkAHdVS7JybMsfQq3iP3iWwKMX/IdiOY8PpwL401lfb9VuN8rBCLI2j?=
 =?us-ascii?Q?LCEJMK7GMlnTCPblo6sl8RIS7ErI+81aZiDTk57OaaqioqxcmxjJYcZtJKNr?=
 =?us-ascii?Q?BAqkPAjF1tSSWmwtMWt9Cnz39u0i1ZSplgn/sFSm1uGIm9JTNkZ4vJloe45N?=
 =?us-ascii?Q?tVKJ2ithNPu+UFt2RtUo7bZqI0wHLqA8ZJO7Ogti8eoKR/7yphlNH3Ba//0U?=
 =?us-ascii?Q?hR+PHLUW42ttr/Z1eAIyelBGrZKJAAJzkcm+VuVZUFJ30RCpbSl9a/+kRKrv?=
 =?us-ascii?Q?ZWgIvoKsOE1P8fmLvyxUm5hnMH0A1/L7te09GFXpOws0l3aFnWTtnz4Kdwar?=
 =?us-ascii?Q?FCUmhxd7H1k/m9gVCTcgmEXqrfN43ebHvyXQU2fWt88n5oLq0kz2slp3PyyN?=
 =?us-ascii?Q?9/ayJpQVku9nZTKts1RaDr804yUXNRjOLkvOTaRCDAfl93yZ84wziw0NTR8G?=
 =?us-ascii?Q?usiJhbZ8pIqnKRUwyNxThRoffQH4UqpfKFZh9M4huebeKbiyZOd+5a/gT7b3?=
 =?us-ascii?Q?UgchnucvvJa129wc3441YMT5OTDMmI6YFvM9U4FMnOgvDQUDm+eif3oWdH/2?=
 =?us-ascii?Q?QKEFIC+KVmelZqVVjXvgDcD6NsQ/wjQpwtdogD88GwSlVPoVPW9VQCKGL4a7?=
 =?us-ascii?Q?PGcElj9w2cr47C6Ocn+MVCjK3GIVIMQetZi99m7We3Vlav3xdfCfy5StLLoT?=
 =?us-ascii?Q?gT1Jgp9hDGc1+hxgNBvhYxaBn5AkmmeD1C2WroDNzoa66ngJnIF7jG36q1b3?=
 =?us-ascii?Q?lIE6yphWlcyglXSm/Kvnllg7/uQe2dRJm0cL85T4SgEx2WS1hejDU65jHhuA?=
 =?us-ascii?Q?A8zg4YGsp9vLZ6iH65Hzs0G8hGO/S9IaaAud4zQazqf6ozMEeY7JzeLdIM7g?=
 =?us-ascii?Q?tIUSVHLKav9MRF9XQWvVYzoHiA0yhjyk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:32:19.4365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 790e418f-d0f3-4276-8bea-08dd1af47523
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358

From: Brett Creeley <brett.creeley@amd.com>

If register_netdev() fails, then the driver leaks the netdev notifier.
Fix this by calling ionic_lif_unregister() on register_netdev()
failure. This will also call ionic_lif_unregister_phc() if it has
already been registered.

Fixes: 30b87ab4c0b3 ("ionic: remove lif list concept")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 40496587b2b3..3d3f936779f7 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3869,8 +3869,8 @@ int ionic_lif_register(struct ionic_lif *lif)
 	/* only register LIF0 for now */
 	err = register_netdev(lif->netdev);
 	if (err) {
-		dev_err(lif->ionic->dev, "Cannot register net device, aborting\n");
-		ionic_lif_unregister_phc(lif);
+		dev_err(lif->ionic->dev, "Cannot register net device: %d, aborting\n", err);
+		ionic_lif_unregister(lif);
 		return err;
 	}
 
-- 
2.17.1


