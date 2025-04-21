Return-Path: <netdev+bounces-184423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D64A9557A
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 19:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28EA188F474
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE791E9B2B;
	Mon, 21 Apr 2025 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r+W07o/u"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A4C1E5732;
	Mon, 21 Apr 2025 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257607; cv=fail; b=QtM524XSR/FUd8WPJY3l/KkB0cyPxlCAE1C3gkxKMJyjwttnM/osXt619xnRVULhORNKvpXDpDIrrqaZuwVJxf8Dixnp9g4qqWI10hQvDrk5Bnn74Pp+yySuom/4+T1piws0FKozbT9Xhce5/Kw/U5DUyGhww8di9SBxsz9Y/oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257607; c=relaxed/simple;
	bh=HGb5tQ3XN8BWou/bI2U2/LtPYoeSoX+TFBaiLGIyDHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5nXf1jBITbeKko1l3w7wRtt1KJ/pQ+8heCTcNcSzpQGIG1+RvD0LyZgSdALSmfnH/FeUizFGho8o7z8JFxBONLGxwIwZ0ymCUYG98O6Drs0Ks3TSN+joDIFAflDS30mdvBGPV6s8tmmSB5TAksxPBILHLInR9DQLXbJvlYn0nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r+W07o/u; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/hwy9x4flAnocSK1b4Gigf7zhl9iJcwR8LJgsNrSJYr2zrzRknyVOVxe0rYgdqZj6TBKytRtF+KW+QFlEV0SZiyODsEXsAqybfADycHn7C01XHD31e5KWlg1qCoHAzqryHp91YlG7oSy8DzGsAPyGNw9O52jex/ui0Mb0ivevWOcT5tZfS2lPQNPxGyXwZ39ySTapaatr5XIWw56/YK1gGQYlf47MCVnqKOH9YK9fW73yC9PNILi+WOAE5SK6TC6vqVHpDU7Vmfwp+eiAcq8ug8sckkFY2YGWlMWRtCF1jN7Oa6vZMU0IffQ+WbfB1+n0CCwgpZx8y+0URRhwHZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csXqUu8Goa2RO5A1a4O/7TRpWKVTfs83nqQ60wBA/VA=;
 b=XIUTIcciogDGu08DYlibivr7DlHM3+Ewbs+AniwRRguoKIWlwj+ZiVrGgcHm7V0q0+EAkGnkriOpvYhRYXYOkt62dFNWpA74soZ2/bj9SburtrxxQaQvoWRmmZwNNVD9vz1EeDziVArKDO/V6EtXJW7O4vwsjoYkUsOehfEPTJMc+XcwXeBcQQZBRTLyeaGmEb4Qjgt9G8Q0aH2hMdncmMZGh4Sd50xL6ewzvTlJmvfqCUQm4m2p0EzomT8bokGLAqn1Fd/MVHu5rvu7D2g5s4QmhH0zYrIOFlYaqQ+93851z7H9AFFpOmFkxi5QePhvxvK3H+YnTV9Xo9nKsOJMOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csXqUu8Goa2RO5A1a4O/7TRpWKVTfs83nqQ60wBA/VA=;
 b=r+W07o/ul1302P9eO1fF5fs2jYuu7sU4Kzk3IQXlJZXEWS/sAnBCqWa8hc9oHGBMi7PrwwJ2GcSTvXdwNpCfLMiyUpm9DNoKXcnrtXheKZIUTiu6NgdG6E94j84Fk7qEpJ1uCmybBelF1ZDp1XHQRW3K/Mii+jevZGJmX/v29ww=
Received: from BYAPR08CA0042.namprd08.prod.outlook.com (2603:10b6:a03:117::19)
 by SA1PR12MB8945.namprd12.prod.outlook.com (2603:10b6:806:375::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 17:46:42 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::4b) by BYAPR08CA0042.outlook.office365.com
 (2603:10b6:a03:117::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.33 via Frontend Transport; Mon,
 21 Apr 2025 17:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 17:46:41 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Apr
 2025 12:46:40 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v4 net 3/4] pds_core: Remove unnecessary check in pds_client_adminq_cmd()
Date: Mon, 21 Apr 2025 10:46:05 -0700
Message-ID: <20250421174606.3892-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250421174606.3892-1-shannon.nelson@amd.com>
References: <20250421174606.3892-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|SA1PR12MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4d6b42-3223-4eb4-bd45-08dd80fc79a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SreLPKwr1atRfZtzLfqCtNSJQaALcyVAylrSBGAOw0d3yRasYBvndMGdxaoi?=
 =?us-ascii?Q?yveW0yPoAX7pBH5p1OSIkq5ZL8L9j9GdE9DIqxgfrP+lh9FOtKCmdgr5UADg?=
 =?us-ascii?Q?fQ4gGUhhNTVESGeAGoZKrh19rKL6tLCD4gv1NUpHmngwS/IPemCalhXmsHPw?=
 =?us-ascii?Q?lY4xITASrkTXVNRWddJKGM8skMEugry9lioRVwH1x7gTjWts/BM49ieNcGSa?=
 =?us-ascii?Q?VgVrpkMO4PQhso8Y/8qrUavV42vkkbM7knRJmpSlVWypHXw75EJ79VcV9fsr?=
 =?us-ascii?Q?DpK3PxbWOsjavwLCtMt6CqW/UA2MG9DfwjJIe7PGhZSG+IAOuNWRBHiSSBQ6?=
 =?us-ascii?Q?XvpgqPWTzjdR/2f13HrrxoS//IR4OfTCkeNt8AvtrkFDx+61PptFctdkWian?=
 =?us-ascii?Q?Pt7dYa2/NcH8HrByVdrRticOu8V4ZD3VIoUf2hGVG7NpmzU9+7GEPgvEjXnU?=
 =?us-ascii?Q?juVla/QiQjYbE7mDPzouFz5NkvVahbHGXmXSkdVWaT0yGHFu+75Cd524hQhI?=
 =?us-ascii?Q?G6V1aTizvM38j0v3zgoQCjUN0BpI6PgHxPk/tidHQSvFQn+gFRCyHxYzkOC0?=
 =?us-ascii?Q?t0izYY9c5DjlzMMSdYOCCC/nqwvILb9I9z4nb4pM1t8OF3dIBVsoJNG9NIhv?=
 =?us-ascii?Q?cc+yrLdyEQ2uxIJ1PhMIj4WV2N77DjE1t2h5O/TJ76qGH1Cyrgeltx38mWkO?=
 =?us-ascii?Q?/zpWrJQXI3Z1Gj2Mh2j5QNsKqjHDs93JjVjeuRImWlZj5CBJR174avy7G1G2?=
 =?us-ascii?Q?ew+R19E9eG3TGD7B1RZnGUPZSIL2MbNBTTgGXbNvLFLKnXM8hYo6iktiujGa?=
 =?us-ascii?Q?+m3sUIGA74uVb2J2C9NWYRIjYuwH8kI6lS1+Jl6TzDZ4MxGX0sVvPnBxUqnJ?=
 =?us-ascii?Q?c6MQIG+WtY0QtFRdBZYzZjjB+39DY/hRUjulGEW/sTQ/YACSpvckL0zD1vG0?=
 =?us-ascii?Q?ZMJWUNUkkFEcgK24p1dtPRZAwCU6Cxqd0WFD3z/PfUnWGLLH+azqXppks9lP?=
 =?us-ascii?Q?UGhLpjvdzkwgFa66cA1hF4ZDZvnFI4DLejJ53QpnV1Oexjw42lSZViYkamaN?=
 =?us-ascii?Q?1ODhbMiT+ZbF6AOQCfOPr7WAHu4ugFxDdbc9tcvNSQxips+JzgyWkFtnB3a9?=
 =?us-ascii?Q?4BdNVgh/ajwcHUqTcC7g1MOr6M27NNj1dSJKkOg6PH48+buSvVjvMIR+x846?=
 =?us-ascii?Q?UNUW91vuLzsP4nCiypW3C33FOQnCEEwCKjNeXq9VqBj9bWwHsERA4Bezf3Ti?=
 =?us-ascii?Q?aaC2PUeCRjrtWZ0g8JBHN93YNdItonG9/AVj7f6rqu18NhvCwnMjL3koBBQI?=
 =?us-ascii?Q?b9g3yZ1921rYTUlcGbw20mJckxpbyBA6vJ+9CSG5L45tSW7f7e/rqG9TYlwa?=
 =?us-ascii?Q?RIIXhap3GUoN/tYWRVtTz2GSCCBcpppkx1DBkClbJ4M3dz7h3odfg1EDwwPa?=
 =?us-ascii?Q?QDvgSCJnKT78H3KaQGXtyVr7iW3tAZC6XuU44ru7s7G9fOUR2iHvqNyXkTEZ?=
 =?us-ascii?Q?364T3Q1+YyWgrolSZhTuyBUXO+iKssZ096GNirjs8mvFhx7xPDBTaVjkVA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 17:46:41.6222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4d6b42-3223-4eb4-bd45-08dd80fc79a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8945

From: Brett Creeley <brett.creeley@amd.com>

When the pds_core driver was first created there were some race
conditions around using the adminq, especially for client drivers.
To reduce the possibility of a race condition there's a check
against pf->state in pds_client_adminq_cmd(). This is problematic
for a couple of reasons:

1. The PDSC_S_INITING_DRIVER bit is set during probe, but not
   cleared until after everything in probe is complete, which
   includes creating the auxiliary devices. For pds_fwctl this
   means it can't make any adminq commands until after pds_core's
   probe is complete even though the adminq is fully up by the
   time pds_fwctl's auxiliary device is created.

2. The race conditions around using the adminq have been fixed
   and this path is already protected against client drivers
   calling pds_client_adminq_cmd() if the adminq isn't ready,
   i.e. see pdsc_adminq_post() -> pdsc_adminq_inc_if_up().

Fix this by removing the pf->state check in pds_client_adminq_cmd()
because invalid accesses to pds_core's adminq is already handled by
pdsc_adminq_post()->pdsc_adminq_inc_if_up().

Fixes: 10659034c622 ("pds_core: add the aux client API")
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index eeb72b1809ea..c9aac27883a3 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -107,9 +107,6 @@ int pds_client_adminq_cmd(struct pds_auxiliary_dev *padev,
 	dev_dbg(pf->dev, "%s: %s opcode %d\n",
 		__func__, dev_name(&padev->aux_dev.dev), req->opcode);
 
-	if (pf->state)
-		return -ENXIO;
-
 	/* Wrap the client's request */
 	cmd.client_request.opcode = PDS_AQ_CMD_CLIENT_CMD;
 	cmd.client_request.client_id = cpu_to_le16(padev->client_id);
-- 
2.17.1


