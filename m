Return-Path: <netdev+bounces-150797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4469EB956
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 19:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795D12828B3
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1395199935;
	Tue, 10 Dec 2024 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vaDyaky1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C509670820
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855468; cv=fail; b=elmm7xrz/G+GogKriB7+XhTe26xi7H8LLf2a49v+UdNk+ipkVrijJCJZXkF6tRYZnDB/aJpslq0D4/s05MWqXC3/6EmyEnTs+znBSVNX9rHLZ4OfxHqVhZRnX1J/nBj79N6/5jmlZDGxK9SqRZL8pzS8qBuj5elVsBKUREFZtS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855468; c=relaxed/simple;
	bh=qIefAa8tuVJq9BTpOfeaPK9BnJAIwb45nxOXxsEFm7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+cnySy2GtGEEPTQlRZ/yl6WlByVG9HXzlDHUTxrGmsm1FBgFM/2nqMKoyO2sGZGtuFUrf6PAJoSxQRMZ7BEf543vNFUp3irALwAx2OHZRq0WWVdhSbVHsWMnIdREgKUCEHbxZylyNWAk/Siz0KbyW/9H6uykv4DOauHKoFvfsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vaDyaky1; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgjTRL2t8CbUjB2zO7K4fjQXEmcvXxP76W6iW6g47Wza/Fn+68E8qTTVjVbh/0vXPZCzXEoZ/NB0PRa2kE8V9uoHxeZU0X9fU1QZrdrBZL+xHx3RkY99mKSsicsryPR55Tfgul94X7GhKNMPff3mxcPHBxQ0p7QqMi3/usLidQ8c5BbX7dgjjoaxOG550BJLeuFqnAqJsrqMdv53CeweIUa6u0liUhG0/0ByjYCzLNdY9uh30S0v5dLfp6Oega1bIe4T990srk2rnUG6c0KVOYsU9To5rKmnJWE5Rup4HedSsFKSIjZhpX6gbo8RANlY+iLITj5NpUbBkq9fam4uOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uLzyG7oNCUGJNQWrZJejeKlJVKqLQl69yIWKkZ5hhU=;
 b=RiqpNATnH8YnEDPdiuN0joUDn+r5Ts8A0TItLKjJgR+XMzxje4yvSjEMlL058rY+/h/GDlT0Cqlfztg/eI9zIfyqkQ8bwoxexz3Q/1Xh4nWgvF6dq8lEE2oi6CqARyEi2HUbukETAyUMXFh40i1wziBhlP3wDvWyqWWdAaswSagbhMoyyoiaOvOtv0iQ+B8pDtammfjKdvcOZW/w7XafkrdRKIuMswm8vLXS9y7mFId82KzhZE956FyT+2/Xxj5Td4d+L2s7f479JmI7nm/uR69a8jHg5l8dMWuNORsPLABvIym+tpVbfJ6hmns5Q50VkLoMH3sPyje2JjA4A7j8Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uLzyG7oNCUGJNQWrZJejeKlJVKqLQl69yIWKkZ5hhU=;
 b=vaDyaky1Cohv2oP31X4bVJg3TDvd0U4649CurTOpQ1DzTJcYUZ+3mALMwtjWyI07D+qMeMWsmlp0wB7BONyuU7ahrGhBwfVXOrdREy616NW+QBe19M8QKpWQtgXpFxwYPcCIUqB6cCghkQQOctvfg8S9pwiYGGotHipMyT2zvaM=
Received: from DS0PR17CA0005.namprd17.prod.outlook.com (2603:10b6:8:191::6) by
 MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 18:31:02 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::9) by DS0PR17CA0005.outlook.office365.com
 (2603:10b6:8:191::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Tue,
 10 Dec 2024 18:31:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 18:31:02 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 12:31:01 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<jacob.e.keller@intel.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 1/5] ionic: add asic codes to firmware interface file
Date: Tue, 10 Dec 2024 10:30:41 -0800
Message-ID: <20241210183045.67878-2-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 596c7e97-c0e4-4822-528e-08dd1948cd1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E13U8+pqRKGsdmLqznUI26Dr1jIZgzZc6ag0yAaDBjgaT0YMBRIOR7s4PnH/?=
 =?us-ascii?Q?aJq6T2zrhIyl0bLhARTK98h2j5dJn2CJggDfYgIMKUAbEmZfTyc3jd1w3czd?=
 =?us-ascii?Q?7liEs4YAk1OKaGgDu032LTFxUK7rh0EO0o8bU19PKivYSrx1zNlIi2ZB+exM?=
 =?us-ascii?Q?3NyWKdVynz4kphDbqLgddlPSeqI4WWDCqGYpJ8uKAtsWINJtwpoVLK1yl45i?=
 =?us-ascii?Q?di/FWdotSmD7YrVlUTZNaFCXW7LkGj8qMk61krqrn8lL+Gfl5eUub4QWqNt/?=
 =?us-ascii?Q?rtPvzm/imWbXXWw7DLjzDqpk/3/nyo6sdjBhcp1DoJYwYU4I9mLa2/uRmrKK?=
 =?us-ascii?Q?DhGhubcSdYFbyJmzTv9Gi9XBVm5Pvz7Vo33Op+ahlI190y7K/mGYCSapEvsl?=
 =?us-ascii?Q?D5ZWvtLodmbYIZ1jaR1FYKt9OxtayOUJLbV7I9/nztPOD1MXfuCruCgc+/11?=
 =?us-ascii?Q?Xk8I4kyO+YCnqNAbPMNJ2qkOUNC+IwzbTkdO5SJnIqLAen4BJVZ37o/JjN+U?=
 =?us-ascii?Q?hbbwpj2BX2+Zg65nfmEOMBjFI0nk7r8J5nxmU3BxaQHZS7zgCQZW1lIF+gRF?=
 =?us-ascii?Q?Dgzhzchh2FQj1/lVsw+ZrCdGFbsKQeblv5xYsfyiLATMapN6ehI1iVCxoxUk?=
 =?us-ascii?Q?O8lNrf7bghFZuTBCUGUvYfXxsU+QpGrxGtgroRcDHmFIU6MlKYxNraIH8zkz?=
 =?us-ascii?Q?5z9v/nVSpGHkE10z/Kf7HgCrmMkRaQlUMvcPwsx7zC2ruTJhLpXq4j8sKxwF?=
 =?us-ascii?Q?Yn9yfCbMHjI5m0M3EcY/LtKwcxH5SMLn0ALkWwCqtGfm2OEw8rrG+FYTskVB?=
 =?us-ascii?Q?YGmMfROBbNMaUy+BQYU/YqsaOmNIrZGQWh2erLCah6YCMu1xVk7Cc9PlqlsO?=
 =?us-ascii?Q?6lJLSJ7sVdy4FcFZ4aMKq5EmeKytmkLQJKTD76rod+YkC4uyHJFP9qGfOrk8?=
 =?us-ascii?Q?7lA+Exq5l6nput74wYK4zqCMHD5ZkCP3EW4ql3cWgl+JZgM/PEAPwKzbT8mu?=
 =?us-ascii?Q?RpTUQ96dQ+Qxr/SgwhNe1wQYN5Ow+DelvtmGKI5+tfdxZQJnWdV5vGhrUyCW?=
 =?us-ascii?Q?tqS2WGAseT8Y9UMwqZCRbTNjZi6Ir02Sbtc9VLbF8ONpyNYubKa9AMprzLFY?=
 =?us-ascii?Q?PP4bKUq/EmRLNbVfy+3qYpPeJO1JkEbFGA3CPHyc8Pgv9O1nT0rjKcyya3QB?=
 =?us-ascii?Q?QkDlAhsp92nk/w8g9CftXkPbt+M18E8oUnhKohRmCXif44BaZL/VSkCHdhvk?=
 =?us-ascii?Q?2qdaXDA39Im6+5Yr6CTKGe4md10vaP/U1TOTm9FjC+X8k1DxrUSPKf5rlmel?=
 =?us-ascii?Q?9eNJDSAVK4/MUIsypdM9MjBWvDwPVa1br6I5ULm7KOviYbDKo1gtjDVskh7/?=
 =?us-ascii?Q?l4iWQCi03ZZ0R6DkRo0Ie+rPQrVy3ZutByreb9OymOwChbdG2XIbfiyd+7+6?=
 =?us-ascii?Q?Xykaf2x/IXneu81lSi3EyVsoRHOkMnCI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 18:31:02.5040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 596c7e97-c0e4-4822-528e-08dd1948cd1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003

Now that the firmware has learned how to properly report
the asic type id, add the values to our interface file.

The sharp-eyed reviewers will catch that the CAPRI value
changed here from 0 to 1.  This comes with the FW actually
defining it correctly.  This is safe for us to change as
nothing actually uses that value yet.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic.h    | 2 --
 drivers/net/ethernet/pensando/ionic/ionic_if.h | 6 +++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
index 1c61390677f7..0639bf56bd3a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic.h
@@ -18,8 +18,6 @@ struct ionic_lif;
 #define PCI_DEVICE_ID_PENSANDO_IONIC_ETH_PF	0x1002
 #define PCI_DEVICE_ID_PENSANDO_IONIC_ETH_VF	0x1003
 
-#define IONIC_ASIC_TYPE_ELBA	2
-
 #define DEVCMD_TIMEOUT			5
 #define IONIC_ADMINQ_TIME_SLICE		msecs_to_jiffies(100)
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index 9c85c0706c6e..6ea190f1a706 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -3209,7 +3209,11 @@ union ionic_adminq_comp {
 #define IONIC_BAR0_INTR_CTRL_OFFSET		0x2000
 #define IONIC_DEV_CMD_DONE			0x00000001
 
-#define IONIC_ASIC_TYPE_CAPRI			0
+#define IONIC_ASIC_TYPE_NONE			0
+#define IONIC_ASIC_TYPE_CAPRI			1
+#define IONIC_ASIC_TYPE_ELBA			2
+#define IONIC_ASIC_TYPE_GIGLIO			3
+#define IONIC_ASIC_TYPE_SALINA			4
 
 /**
  * struct ionic_doorbell - Doorbell register layout
-- 
2.17.1


