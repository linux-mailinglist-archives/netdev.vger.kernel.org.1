Return-Path: <netdev+bounces-154581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C625D9FEB1E
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39963161F3B
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C7019C540;
	Mon, 30 Dec 2024 21:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Vy3gPmY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCF41ACEAE;
	Mon, 30 Dec 2024 21:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595121; cv=fail; b=qGy03oD1jTDp9NhJwc9F172pO9XnlC1KFE22/e5OLT4bN1BsyRplp7oPyrHe8BVU1dnk7mJoGbslkCZ+tcc91wKfIfpMd4KIJX0/m2TVcSoEENx9pPIJcCC0VFQvAmS50h+hiudrchuRBNVuGvN4zkIGqnWJ+yzgiPK4H011z2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595121; c=relaxed/simple;
	bh=CUBEzcOzMLhV3ZI+XalsXA2O2Xi7n5EykrHhXd5mrUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElXY0JbIHyZSlpzTRMb47KZXAqumVesgk/b3u6vOZ5x4g9OjWPoeBTkZiMVxyK/9o3MlDsHJe5NuH5fG73IwEeDy9tny2VEhWCgO7jyndQxKGc6xt9rXcthx34yz/r1SZqGvFor9pQcyhuFmfTbypMQR2sOLM0uXpC4FwKtK/Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Vy3gPmY; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeGZAozbSclXVZyxbCbIfQpBedz5nZyQeuz7gj7ToAwxuh/8Jhj6TO/5zqZO6rQj7YiZvFvZ0m/jBAlrbQ4u1F5mWQ6XTXqHO7IW4+jA3Fa/WPHPNE6JInMOeY6YzoTN9mXkK4DpQgRJ7HnHdmEyl6woRE5VSMaEZMYLQ5jFYGVLmkDxMiVbqF5yOXv7nHLqaJoFPkFA5oAP/RmThgeHUa/lloYjd5E6C0NOMUNKA7A1Beo7HHXYM4zHxMEssxoy3/Z+lVOZ8Qz/ozO8TIClMXbkF42Rwjpll1VpRUM1fbxoX9eh2LKzd3apjR0vjZmKRXdrlseWjAisSFlPKYgp+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TtPd8rcGNMTzxmhJ7x7LnCtEhD2PdCVmzZM1cX0rWw=;
 b=qCZbuGQDuxwY6WxWTfwluvlsRBgSOmJddVGuvCa74O2Z7KxcEejQ36uatI700Bb4jm8R0Y6lAJ1YkSETTyvNFy5iwVfQNU0+NWYLWSpkptRvoqD4RvN6FVPMBS6Dt5kwXcezvDvQLvnn20KnmLVg+K+/t0oPepyRx3haiDGOtJasbW9mZT/r7RuIJhN0QoEKm7gCXz2zixulrFSqCbYAgUHtLBsTVzLXERbWSi2QTZG4BXpPu0gtKZ2p9Lg/eP7eDPkaKj5tcbX728zVK8RoS3xnSrO1/NKK/nkEp16FAqTMXulqdFE673X7Rx7sMF0e/57416zMj34kTDvC9etmrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TtPd8rcGNMTzxmhJ7x7LnCtEhD2PdCVmzZM1cX0rWw=;
 b=4Vy3gPmYGtqlf+JmSNLyZm3QB3uEyYn2JhcPk056+6SeBLAITBAroKCjbHRWNkJDxskukmovcTvj6u6Mtgb2+rReDH936+FV8R2S5++rFwlzBQ1JCIQVmw908ZRbNIbF+eakfKaqdDIpl/rtk29+Elh3XhjzOPBmVGjbZLef2kE=
Received: from SA0PR11CA0118.namprd11.prod.outlook.com (2603:10b6:806:d1::33)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 21:45:11 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:d1:cafe::ab) by SA0PR11CA0118.outlook.office365.com
 (2603:10b6:806:d1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.20 via Frontend Transport; Mon,
 30 Dec 2024 21:45:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:11 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:11 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:09 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 12/27] sfc: set cxl media ready
Date: Mon, 30 Dec 2024 21:44:30 +0000
Message-ID: <20241230214445.27602-13-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4a9648-d728-48fe-2dac-08dd291b3ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WgHvtRVVUwIw03VrFvXuYYOytVsHzGF1BtekavusuLBOd/5z/k+jnKj/zZUo?=
 =?us-ascii?Q?50xSjcxINhGAoDAvpNf93jeM2AJRdu4Uh2c41Wy8BsiF+HT9b3qs2+Y60o4r?=
 =?us-ascii?Q?0oFSzQimASBynCaIye4+yLVaqnyol+9H2I3vxHdXDhj2MJgO6PvNlhe425OH?=
 =?us-ascii?Q?pveStPqEOJ/l5iiegYv/R1bOaN1FaVlrIGqtzf9MHQmrdBb/Zjnx+4+AWGtC?=
 =?us-ascii?Q?NO3GFpaYlJBrGYCFkO5tVfYNUEHfvV1FV3mby0ioArDRO1dBa2fwaxrmDCMP?=
 =?us-ascii?Q?HDS+sdYoRJYFoly4FVzsiy+54neaIiCDfdONN6OwXiqq3n3C4GtQxr722ola?=
 =?us-ascii?Q?YLYoVIcmwTGXtpe1zHqRi9QZYvLEjnvUtIe59VO+K9G3fnOqfEALKCj2d1sR?=
 =?us-ascii?Q?lU7eI9l9FehktuRc6loEmHC79FJzv/dfp0M0cLZsbkZN6pfi2ZWRmQ14P5k3?=
 =?us-ascii?Q?JwKod+Io7Q1tChmyzbfwhrI/0m/vJEtm3SIbDHqbhOR1N4XxmB6lKm7s1Xtj?=
 =?us-ascii?Q?PKOX7nUlcj2ZAGqzzQd7Vji9RM0qNq5ksCO81JiEMFGaEuzp3UPk3ZPJxdCL?=
 =?us-ascii?Q?+rquwjoveX27uwwkuS3FOI6Ur0Buecwd8Tq1Lojj1rBpbD5FncCdeNPzbOIR?=
 =?us-ascii?Q?FN0nWXdEe4i5R0eQSW5O67gSGh/kEUntqpQ62GJDmFAVWW0usVGqEEyEuBlg?=
 =?us-ascii?Q?Uq/hgvNp8PlT5UvpZSkN8CFvp9WhuoxRXt3lOp5ob8kHrVO+ws/Hknh+8u4g?=
 =?us-ascii?Q?T9hn6L6bp2pH/1jfXSUrhISgwj7d/ROU7So/PxlNtZtUyo46fqRCvdcRfNv1?=
 =?us-ascii?Q?jydVEmb+gM1JmWsuYqw6Qczb8kZFHg9EEATb0d7QkHZpCq7lEPqBHLk/PdNm?=
 =?us-ascii?Q?IWm+IGCEqZowxJap0C4UHb/W/qs7JW+lDkdWKWBSFY8Rq6YwWPRYnM6kwEj1?=
 =?us-ascii?Q?JwPndyqaO40TmOxnYlkYyTKRd3Ho6VbK8Z+F5WfEtV152zKcgXMrrA9l5xs5?=
 =?us-ascii?Q?ks1E/l3RA70oUzv+3BLRTBy2jmb1SBzkDZwChbUmSIT1P+tZlJ2RLvpw8jqD?=
 =?us-ascii?Q?1hHyK/jbFGDxaQE9j3h+hWZ3THCUZ2r6OmUpM7Is+hlmQ0QZJZRkc8oiCx7b?=
 =?us-ascii?Q?1grBSJK5ouS99zyIjJB3aeZInUrGM1pkGsxQKHDQqXT8P+5SBQMnCNECSaC8?=
 =?us-ascii?Q?hewNcNwleBVxhLwatxBWsXP0S6ZYgfD6RtYB5Tf3s5R2q6nu5I9cIGBphkON?=
 =?us-ascii?Q?Q86Zqx29glM8l/SForJzApL/Tdhew6y4vb1jz++/DqYpO71F6C8IVP+PE6/T?=
 =?us-ascii?Q?rz3Dp9egD93S5fY1iPXTdIJ37L14sc2R/6zzWLQR5Fe80vPouqSV8w8VPJXo?=
 =?us-ascii?Q?RTigCt0PqlQKiQTiqJFf7VyYW2YPXagj+jTLLnhr4vtoJXIN7heQ4cRHvq1j?=
 =?us-ascii?Q?3Ah22QQtY3GRMgBX7t1pbbf7KRrx7ETERwoJ2YiQzP74kFzF0zSR7tMElP01?=
 =?us-ascii?Q?9gUS7ahAg8qwGYM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:11.6657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4a9648-d728-48fe-2dac-08dd291b3ccb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api accessor for explicitly set media ready as hardware design
implies it is ready and there is no device register for stating so.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 2031f08ee689..911f29b91bd3 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -91,6 +91,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		goto err_resource_set;
 	}
 
+	/* We do not have the register about media status. Hardware design
+	 * implies it is ready.
+	 */
+	cxl_set_media_ready(cxl->cxlds);
+
 	probe_data->cxl = cxl;
 
 	return 0;
-- 
2.17.1


