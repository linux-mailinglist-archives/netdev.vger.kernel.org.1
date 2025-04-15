Return-Path: <netdev+bounces-183052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C786A8AC1B
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 01:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A652E3AAEE4
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 23:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEF52D92C9;
	Tue, 15 Apr 2025 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="msKHurw4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77842918F5;
	Tue, 15 Apr 2025 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759808; cv=fail; b=ReeAhcE6pP+AaFss6MzUFjlhVZdgQ07tdBOs24sDixcQG8M5wog4pAazmwcxLmhSCEKLfVm5f3Ct2PoPPO44ODoaowz9PCfYe391xa09pJP0sFooEEhTDAuTD3owTxBJcsddlrRM4gBltWaOmSZguh4+bJrI9HPRT1e77ZqryE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759808; c=relaxed/simple;
	bh=eGzmJB4g5nECEEF6KArKV5x/OFxuEw9FG0qhVtqYK8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8FNNeW8XMsrPmEwbtBo71GWpwZHwV3XwSpcUsjVVNXvHkUNz33wpGZWqc0wXbGCRGhcuF58Pel/xoCJhqIB/KxrXu0qL5D7AASlFetKw2uSLP0X4+e9Q4pyxl26TErJ3vrQg0CUEX4obcpBFzMANMFHHyXG2j4hghiF8UiUoJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=msKHurw4; arc=fail smtp.client-ip=40.107.100.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/57KGmYZSqFn33ROoaH8PIMR5gFB/SBG+XjBUzKAPXeU1cR3zsWG7/DMwGdUFYnJ9g/e/VQZ2vbMSt8BJJZRv8YK4uNUXVPkKg/4fs1w7untFz7mNFcxg7MEDEUp5swC+zT5uf+908Oj5+GMSrU55lTy+5MMlogVwpVOiH+FMKVV26MGqEFdfV9VbpOX3BYY/DLDAJeF8kFGrXMxOGb/M79nO4ddkPKju9aJB0Fc7igGn3vrZzUQOW0NUCwvskwrMajE0v23nbfSg09jOMj6WJnZWF4MJSkqJ21tsdbZnlYJsrB3AM5cQdzZHjFxjnXU0gjdb99PLQStWSonWCyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGxwFUZ634Dmp2Dk5tj3RZGSC+63BKGDM954huSvkRs=;
 b=gVlbpJ4gDQ/dFuQPXi1O29dNYvuxCM0G+tvcv5sIDPMHBNP/SpN0TNVuPaHFCdsDhyCol+bGWgvpFJyn1atctSCKSTKFz2f8WrOccJvD+bE429+pdzroGE3NOX565FgNaFnpsFaUaPJmEAo5ml+SPSliTWYkbDeibNmoXa3V5F8k4GX7u8kVzY0IrjjvE2nHRuTPdNMdO5mquIhGvzdYqriGDwen1kS7ZbRmEg7+N1OpPXDbIgy5vOdhj2tuehwuqmz31o0ulcSD/HWwNbWXANXYjvGkBC0sBqB0YuJY+HJBgHKtXCyeTPYZdyiuO1RN67h2X7+ZwSMG+PvwhmxvIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGxwFUZ634Dmp2Dk5tj3RZGSC+63BKGDM954huSvkRs=;
 b=msKHurw4LvoyUGpFhZwxu7hyC5zdG+QeEiPcrUsA8jOHUSl60Pb8EUlS75jpxcWzDbh8zXk/r9DG0XtOKcTbaNsgmv//MlOHsPo4odMmPbfSdEtd6rZyqyYgnGWXOAOBkUcSSxQ8NducS6Z+m01rVeuDIQNC2FOz6BM3RluLuYw=
Received: from SJ0PR05CA0075.namprd05.prod.outlook.com (2603:10b6:a03:332::20)
 by CY8PR12MB7612.namprd12.prod.outlook.com (2603:10b6:930:9c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 23:30:01 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::85) by SJ0PR05CA0075.outlook.office365.com
 (2603:10b6:a03:332::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Tue,
 15 Apr 2025 23:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 23:30:00 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 18:29:58 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v3 net 3/4] pds_core: Remove unnecessary check in pds_client_adminq_cmd()
Date: Tue, 15 Apr 2025 16:29:30 -0700
Message-ID: <20250415232931.59693-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250415232931.59693-1-shannon.nelson@amd.com>
References: <20250415232931.59693-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|CY8PR12MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf5f112-d6fc-464c-37d3-08dd7c75712d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h4Tch5O0njlOHLV/+VLSptd8hFwlji+rz2T9hqvBSVRLYpH17gEBOzxZqZNj?=
 =?us-ascii?Q?wwpqRQXrWcfQRMTDgpzv194rKvexS75TcnJESCbaxxNCOAgTUSuAM7ADloCR?=
 =?us-ascii?Q?his3sfahcKMH0y8KNTwXUrWFvFpRBXPoxqTRmWJz1FZEQv5UYzgKh3F/C9qu?=
 =?us-ascii?Q?LAafmFrdHmyoQi77kHjEQZL+fPdl/UFxAkkeEwDAshH67+1ns4//LmMBsm+t?=
 =?us-ascii?Q?yRDLS7Er0rioSn2T3orvUXGEvkDtWT+jXZrkW5u561Wf7lpbxjIxYO72quNN?=
 =?us-ascii?Q?EvAUI3HzeYMRiCmWkCNhKA/niyPy9C/wUYSpvvEoIK/z4ABYRBpObqLX+DDe?=
 =?us-ascii?Q?ohXDgk2aGG6hje4KnP0yivygQG+h8X4uMQriesXSgshXx2k2ExTH45y5Wd45?=
 =?us-ascii?Q?hWWMbvW0NsettCR4D0AFnuDRznMAGsPDx7mFYiwFbDn/bkVB75C6S9rHsXSt?=
 =?us-ascii?Q?+JThS5ns1k5sFlfasmvK8dUsHVCM9kA6Zt9M2tAn9iTn23P8JbohYkPTLYyv?=
 =?us-ascii?Q?9nbOVY42OfBD3vINbq3zRsWGAUa7rpEx7HDciXtuJLxuI+FKA2iHzozgdPZ8?=
 =?us-ascii?Q?wIICFCnJkz/EiM44BeJPip55p1H25Lqv9MC+38lKUKaJRnlwMaFNbulBqC11?=
 =?us-ascii?Q?DYGjupJxC6YlGxuwec/gTaV35Og4wgzoZ1wD0CqF0T1tttgA2FGr3+r60ZHi?=
 =?us-ascii?Q?7NeJFUvE0B/u71ZuRD0d1CQKTH9ZQHfAMBCzauAZAqfcb86bi6uabjbNouNZ?=
 =?us-ascii?Q?sJ6Fx7JYmPCMrFoZjbUbY1ro76Jr86XMybURhV52WnG3gMMKp+jYrmCIKXuZ?=
 =?us-ascii?Q?7mP8GrV1hpdnbs/9YJvD96ygEt3KjJ9L09zhiR6tni0v9r1PvohTLPtzcD5M?=
 =?us-ascii?Q?zTVAX/AjQbD/PQ9yMda1no8BzXqORoG8o3e1n15NL1Pu+9Sz8fkRPnMtGs36?=
 =?us-ascii?Q?0jkQpbKUTR/wGd1VJUptqqOdJHI6hBJc9/9mLNhb9EpVTAWIkKWpWQnS35Dj?=
 =?us-ascii?Q?7TlISd6Sj74M668xpr7MmjTbaBKokqoCanmWLhZnctYf6HM7O8WnarMjKig/?=
 =?us-ascii?Q?mryfAoD89MP9iUBFETMoPDBQGzRiQRbOWoMvCn5oWI7pXvK5XH1hWCWlyqOJ?=
 =?us-ascii?Q?X5IkwUwBQ4OrUq1b813zxgCfMhAPGXfE+422ykhwblyQIHtmEXKfaGIjT74N?=
 =?us-ascii?Q?czBmXOLWTr4ukfaTpu529SCDXhvV2RI6o0LAFg3yw3UGO3oIMVSUw685N4MJ?=
 =?us-ascii?Q?52z3BO9hLR+EdTWkqgJ9S1MGmQUlngKpxGD8nVpG9ZkMBTojL3YAgFoeikUC?=
 =?us-ascii?Q?qEu5cr7Dg12RmUFxScM0u0I3ql90/vjnvcQaVDfEx1Ocoy7a4eVFxPS0uDIG?=
 =?us-ascii?Q?nzLqwLPL33ylfh+oDlxMRQUI6BuOyhjRvp+NGW4jC8NnFYnFEQr7HeQfHxXV?=
 =?us-ascii?Q?KQPV0aG9wa/O75DCXGRUTpD4toLHzntR7Z6v5sp21lvfkT/haZNYPd0jKQWY?=
 =?us-ascii?Q?EfSRYDGh9hblhVhrpLrXEtsIhPsvCY09TVCgyEPYRhWndzZzIiQxhAFcHw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 23:30:00.7503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf5f112-d6fc-464c-37d3-08dd7c75712d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7612

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


