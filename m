Return-Path: <netdev+bounces-150798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD49B9EB957
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 19:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D303167CDC
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BDB1D5CD6;
	Tue, 10 Dec 2024 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y0nbIt1I"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B747586354
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855472; cv=fail; b=ARr16FHM64NvNX9h864fPwKnglsd7TiW81QqlKCkeWQP850tVskK1QaOFiWaPo6G7sOLHEnbn2VfvyzsjV+IUzlFpTeEUaUMqIVSZB9Ra1nuS7SAkr5GKazXlCmPytUXgFTIbHgeML/w/AksaslK0qaAcuEoKCvHt6uHnxruKcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855472; c=relaxed/simple;
	bh=bP1HJqd/0Z4Vmr5/MPZ1k2CGOS7iNEZIU9n4BTq00pk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WN6LHYz6JyC5jgyv0MIP6rETntHI0tZ6Y/3DIIkCjWlonwO32RSJrQKl1D5ICZ/XB+kwnvwte7TgLyXEB96mpTnV+44LM+mBbOkiHAJYMwJOAe9mEL2KN2SfMIfIDRkC0Tp+6MYpTsKYhdNa4gWUDlPf1bYWXy4dFbE516l7ddg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y0nbIt1I; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQVqZ7TiIrwhly/9SD4Tu1rnL+/rbfTmh7yi8S2amJY8+RmAiwIFt6c3xE+ni7X62aW8DNJX1oEVVbdHQkn5dHjmXioHbpUeByWGrnAEv0JOZEeUhwPNL9eeSfQVryIDGBpXbRhGpJ/TPAn7hGL1S5m1vt839p/W3mYPt8GJxy6m+DwMGJaL+hBcgUVYX0iwaXft4NVlOf994Bl5LUc878sAzg2ouGt2YmhzaHzCf5KfUMaR6lL1qdK4PKCqzhr2dwD5EjxRpJE307PWBgdQYC88733eKwrjXwV/80bGiqV3HVsY+s+T/WJd+BRDkEZgw+OYJSjqlbzcD7WC6CHpaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r60gz4Sjo+GwdRHQKehKrydEO2AdJFS6L4cadcIezmc=;
 b=PwaYTp4YKWxo1fvbkNTUaaoiuKU3Jdnm7jQ/DoSTzamrWrcLP7Mx3mojdjr2ITsV+CrAgDLXNBEutUD3l0zHc+wHp+EdxeilCZoNBglu4oHrzRrwmzeGWeLl5C0s+swrNy4e/fyv3vJf5ZWLpYvj0RYyOIHZO/FLP2RpVaHnqlS4odj2u3jx5Dg9qs8E/h00rYEiOiS1REFyZGCmGyCsM5p9B8sFUL4hyKUYnigLIZITzjZL7qdAh/4mluROIZ5kf+Hf2reOgqxjqiIDVaA60mW/CxeimfQ7VMZcQYDt0tjG0fqenGqBZtaTY97qYFEGx6pxl1zhoiRon9lbOgWq4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r60gz4Sjo+GwdRHQKehKrydEO2AdJFS6L4cadcIezmc=;
 b=y0nbIt1Iny1vtWQmR0Ju+7k2jry7n0kK/XkkCokIOuRbnJiUGO4IB+7i4rAcGOJCHpAfvgaE4gySi0DHMvs8RIjv0Zl1mqjA+Qogpg8+mjuh8AKT2QzVpj1fi55+cpLXnfO0No2Tnvy3qp/zQTUwEEJRt4LPyUsOnOJ8FVLfL6Y=
Received: from DS0PR17CA0005.namprd17.prod.outlook.com (2603:10b6:8:191::6) by
 SA1PR12MB9470.namprd12.prod.outlook.com (2603:10b6:806:459::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 18:31:03 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::cc) by DS0PR17CA0005.outlook.office365.com
 (2603:10b6:8:191::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Tue,
 10 Dec 2024 18:31:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 18:31:03 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 12:31:02 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<jacob.e.keller@intel.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 2/5] ionic: Use VLAN_ETH_HLEN when possible
Date: Tue, 10 Dec 2024 10:30:42 -0800
Message-ID: <20241210183045.67878-3-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SA1PR12MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: cebc94ee-643a-4114-79a2-08dd1948cd82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X+MqSGgKqhzGv76gbtKTDaiQBdHlXusmBYKjmZ+99Vj58sYRFDFumA7yrOOG?=
 =?us-ascii?Q?zEG54koT7zAUu1Cr7HqGhJSUV3Iv4rwJ1DA5ww/CvP/O+ivFuLrhrjH1QraE?=
 =?us-ascii?Q?O+PhSc5Jq9pgTeRA8e8Qt8Zdd55qoTPkpXrDcF1DJ6V31EV3trGhygwhYgoR?=
 =?us-ascii?Q?ugkNgzMlOtvTUeGYX4v6ip2yivk6g30qXmGLXlQDben/ASbhbIEu5u/+S6Xy?=
 =?us-ascii?Q?xjxdw+i/GXRhVyyu0TP4vx1EQWqhllWkLzUCjbe5U+51Ik25jrAn5QrqQrFt?=
 =?us-ascii?Q?dCWjp5Jn91HqSL/+/IEKCAlxSmeAWUey5+N3LoQ7wSXX5a9JFGtqhuxpGLZX?=
 =?us-ascii?Q?dthylW8qPN5R2CX10OjiDU1z1Ra68tUIgpSFAAKJkt74eQ/cP7kvU5TU5es1?=
 =?us-ascii?Q?AEPunUzC4LBk4QpNvxGkKr/WFpEhmVHFtzsi7Z4NoZ5RxuAJSpOzbvGqiCq/?=
 =?us-ascii?Q?a+Kf6yyUhayG/1nuvNhRRkompteYqCfLcAvFsqSQ+cD0Om16ngSspcabQThD?=
 =?us-ascii?Q?D8NcCFc/KlF4wZZ5wBv2BfrCOEceyVjGm84djWbP9CDmwCazFEl6iNxLybx1?=
 =?us-ascii?Q?Qdif3xRDAyz7fav8Xb4HVurjfUa7LgHSrz8W182oJ3nmYAO4b9sUeSft3e7a?=
 =?us-ascii?Q?1RF9/amdk4bUw8KO1bvbKMZbxgR4187BwyesRer3t6fDtWMBL1Lg03AxJVO/?=
 =?us-ascii?Q?2D3rEDqOYAlhWywdVAaEONQ4MwmmMVzsIJ8zXv1GPtx6jwvRv+Ak6a45F/c+?=
 =?us-ascii?Q?At5SdUMudUzQ1O282KBpADVyViaexjnEppKEHvNSxGyh7pS++skvKEDwYfc4?=
 =?us-ascii?Q?cpUtR4s+oEg9IlVdxywZ8VSUDPRGrAOlP4TlzdCwI4zBERIL8mjmQHHU8+fh?=
 =?us-ascii?Q?MfY7K7NbDwyMYVpeDXtBGqGY1uMbXCoQX7ilm94//tV0Uak2UkAlOpP8iWW2?=
 =?us-ascii?Q?Cnkhw6dq8bA3BHkqQvH0z/zBqdTgWA7jcJjEAhhIlRJwEsZ/LEqCNeYCRq3H?=
 =?us-ascii?Q?0UrbDCbLL0hLxhO+ynjd73yGRlvYN5VTMJvzUrLKCA4zeDse7hhzL7taeWqw?=
 =?us-ascii?Q?K1/Ow1HZ1i7yHv3tRSUx9hl8DhflJUWNUw15v9hrLNCA3PnQgFHXbwGS5quU?=
 =?us-ascii?Q?hzjV83xG5LU4kXejOAWrqTZ0GLtaO7QYI/5P2lHaXF2DEbDEvD105AgE4g88?=
 =?us-ascii?Q?jM7G052KTHk3lBqtBq9mBksPQuDtn4sDYOb+1urPCL10ZThWuDCC++K+W4hs?=
 =?us-ascii?Q?siewvuaRk2TeuRTQie9uvW2UX4sk9ePQmKyJgzgxZtSAj4ju1t5CUOO9whzg?=
 =?us-ascii?Q?zPdqcHPkFqUT52P8C0CwryRTiskyL9R2ZphPR0jFGKZXdca8UfmKMavnXtvM?=
 =?us-ascii?Q?9C86VPBBVM2ZWpAB6Y+FRI51BEJU55JWBgAWm/cuqpVEJ1JzjervPwo0nW+O?=
 =?us-ascii?Q?YJi0ikDs9eJwj7kR9YNcWxt95VYaNQWY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 18:31:03.1603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cebc94ee-643a-4114-79a2-08dd1948cd82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9470

From: Brett Creeley <brett.creeley@amd.com>

Replace when ETH_HLEN and VLAN_HLEN are used together with
VLAN_ETH_HLEN since it's the same value and uses 1 define
instead of 2.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 40496587b2b3..052c767a2c75 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3265,7 +3265,7 @@ int ionic_lif_alloc(struct ionic *ionic)
 	lif->netdev->min_mtu = max_t(unsigned int, ETH_MIN_MTU,
 				     le32_to_cpu(lif->identity->eth.min_frame_size));
 	lif->netdev->max_mtu =
-		le32_to_cpu(lif->identity->eth.max_frame_size) - ETH_HLEN - VLAN_HLEN;
+		le32_to_cpu(lif->identity->eth.max_frame_size) - VLAN_ETH_HLEN;
 
 	lif->neqs = ionic->neqs_per_lif;
 	lif->nxqs = ionic->ntxqs_per_lif;
-- 
2.17.1


