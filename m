Return-Path: <netdev+bounces-152289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC7F9F3584
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1746116AB7F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474B0192B70;
	Mon, 16 Dec 2024 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="49B2IteP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3304204563;
	Mon, 16 Dec 2024 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365477; cv=fail; b=eSpp50jbAb9zNEK3fd+TVvDEsP5vr632U5qa3gMOUI3N08mfjc4HQDK2urBWVUqXP81C2TS5BeEvrwdecQgFNETa9S7qsEI8FkYWP8qynnntZt28osUXAhTxF5t/m2J2/zr+HlDOBS5X4/+DecLoqXoeV3oPwh0Cgj2OmCL4cy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365477; c=relaxed/simple;
	bh=u1Ewl7QEqNFH8wnSUlElyprFNWu3AIDflgkPwzgAFFE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7MOQMUqQ3wWpJs4AYOsFPKqEz9OtqvwX+04HMBPPiFP1VXCCF35l2GKY4fibyV1L7/36mQ3N8uJL4bN6rVFqxULqgh70Zhg3qXjXFlbQgOGzJnw+UWf+U4lfOpbBIkjmwuVpgfBC7Mt+4pHxnIZENhttOoxLeT5AJHe5oBT32c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=49B2IteP; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0nHbGuAJT2OydOwinUlr2JBSsa0ARGOMXVuMeDvylgfs3+iMzx5nJd9lEdLxESmmXougLHIZstpskvt0IXzTqWiotSbHMFI3EeuBiWlfNUep2FAlYrWl+oEDEBvUTD20dhAX9yYCRzH9JEk/x502E0Nz8th1UYb77FIv7Ch1KM9vrkWrPKB06ykBYrDEVBZwrIPgVyicodHWRyzQNl1cjAxjJZn3ZGxGyJmRgVKJDvmn1oJXg7DJpJvuxMuo4mT8ygcEIQXgvfIcfjesC87rxnjPe1mmBtldHqSK+MylxZ9TRLQBhjW3q2zj2Lc2RP+aUJ1ntMU4aoazSVz4HlpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEIo+pH31bg0nj3NSe/xLQgDwEPb5a37cSbMBxkLRME=;
 b=iENetDMqQShBucvROSxqiDuV45CC2k+yaQYPOpvT0VZTszAjDG4r7axR5oDqNNwQg9BRMwy2xf+3eHqEQnnijuEhPOOGcbhCwfyCT+rgczEW93NBan5yXMhHgOxY25g1uY+58sOWSbwTax10d5SeYL5uSwzV35y/0AOuI4LImORe1FFrtjTs0zKbQ3np9MT5h914Bt64Lw1JouEG9d11u73d+TzFbRqKJrB2Gjmd8rHn9CnGqliHIBX4NxAubI78/ZurR3nvGZMnvx9gYSNgeInlmE0RWq2YibCe7npW783XzbnU6RSAxh0O5HCu4Ta+6L3LqLA8/iMz9iIDIrp7bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEIo+pH31bg0nj3NSe/xLQgDwEPb5a37cSbMBxkLRME=;
 b=49B2ItePOAUji2SRt7a3sJ5rB4qYIgvsTM8Mp5A+zgESsYhI080UoMpy3fzgtQ+C2nqbWD0Agan1w1aUjwioafv6r26s7KoMPWS3kUXmNpoifflx3WTx7MLOPOX+4601stbB9Rg8F3p4xkl75FFUUauSvNEAQZhaJ4zddWpLHUg=
Received: from MW4PR04CA0361.namprd04.prod.outlook.com (2603:10b6:303:81::6)
 by CH3PR12MB7689.namprd12.prod.outlook.com (2603:10b6:610:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 16:11:13 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:81:cafe::27) by MW4PR04CA0361.outlook.office365.com
 (2603:10b6:303:81::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 16:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:11:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:09 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:11:09 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:11:08 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 12/27] sfc: set cxl media ready
Date: Mon, 16 Dec 2024 16:10:27 +0000
Message-ID: <20241216161042.42108-13-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|CH3PR12MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: ad13620d-0d83-4118-b41c-08dd1dec42f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ct6ftN09yKnUyIwzh9zaarqlXfHNGG0hCkSwomc8lp/+XGWVRMfUH0SMqWgC?=
 =?us-ascii?Q?2/a+wrhEM5CX1QQmeMPq4rOjrmlrGMip3tAfA66XVDpyjEDpFSzlerLT6D2x?=
 =?us-ascii?Q?vKL4u5nfdexvdNevoTvnhaONrS2eoOMMYf9h+tSMxjyucCWZJJYiogMtiGIz?=
 =?us-ascii?Q?lj1w4oOL5Yq01vklyx+B7Pdy9kBcYf/MACm0aFtuYtUdwxQnyg7dW59SC/Nb?=
 =?us-ascii?Q?Np8kUvaIMZtY8ATbm+VIUTmzVlrRtz3yglFdiPy/7jjjLnwvp9RdQ9qES4ly?=
 =?us-ascii?Q?OqauxzRCtJrsH9lWJkVfvhDmAvtWbs0M90zTJcNB40RWFhTo9WS855aOM1iq?=
 =?us-ascii?Q?XTIc5KXy7Fztlj+NsZimFOPJRqSQqVRLjYOBVf5cgQauKBLuP1SLh2RJnDDu?=
 =?us-ascii?Q?H4QKFuf67qWg2LI1/NVsIqOubTSLG802QcuEbEkPE6Crr2frk1kH0a0wr69u?=
 =?us-ascii?Q?5LRHAVGt9zkkyRIm1G6auXH+7pw+SuS3mTGhJPiMhEDfIof6oS4E4/7BRb4I?=
 =?us-ascii?Q?v3odM9BcWomYjyREeja/6q2hywSzeR5vb53D0SuXBHUAPh8Nz/Zvh/fCcITx?=
 =?us-ascii?Q?UHTiJx4crLffemdj0gV6Ontd0+oEu32x7vyej3F74WpLjKdT+4Q55xtqHFR3?=
 =?us-ascii?Q?D0gu3G/hUSIUEYTmi2nId88ToqhyO+1BBFPh4FJbMbs86UnNeJWisoAAsb++?=
 =?us-ascii?Q?x7hT8AtT9lvKG0F+zoTzvQH0HGpAMC0n3D3gPgdLuzUKtM88wao48sDC1S8z?=
 =?us-ascii?Q?M5tU7ABRGq9W3YzltUuhlqdh3Rwnqey7EOWeRR7OLfJ94wX52O/efnDUbVZj?=
 =?us-ascii?Q?pFmw/r+enEoqEMIA1ke3ah0cknD7ph8Tkx5xECHvBRvnpDn8R0JSnW93P7lI?=
 =?us-ascii?Q?rf0MHk1bt+yKHEGxsR+GiEp7Oc0/uEnyZfJlbpfx7H95lmSqii4GfRgGKFFa?=
 =?us-ascii?Q?1DNdkiiJzvIVG4IAeg2OWedZvo6LJ/MgP2K3+tvitjwuCKjTOVJsGyL/CsvU?=
 =?us-ascii?Q?EONq4IFBuKxcekz3nq49Tjm/wqFdXMIaYRerZD9YD/JlHOVz+WjxyZzl4M3M?=
 =?us-ascii?Q?DPDWcXAt6CRHXeqXHQgOaA7aA5tVzTmg4EX9neLROS/CiPaV/hO3hVcajiFn?=
 =?us-ascii?Q?Gpaa+tPrdTjqt0AwvrnObUxsAVsAhVPcIe1y4on9/UoJ0Ng5NokfMcD4Hz/G?=
 =?us-ascii?Q?cK6V9+RbXGooR2GU2DvBA4Dy5AibBhJB30aAVjJ7VqSP71B7/obLJqtO/Qsp?=
 =?us-ascii?Q?MpYHsBRnW3Rufbhdyf/JizAeGPYredCYVZb27sBqXfTUDe04Ne5fo04/EGX+?=
 =?us-ascii?Q?aYvBBSQycMALzUuf5yl5uxnucJS0TahL8t3K6deIkg771aE6xID9D8sh7Btd?=
 =?us-ascii?Q?QpTDnTulp8bWTTKAP7D1TbNr5vdZ9VAeq3mUulvYYcAr1cS3fztVtT6uA9pe?=
 =?us-ascii?Q?4rxKiGBd6yTcFVyAfFD/OTUCn568TA517M5jQpAaxV0JfAwRk5opOJB5t+fT?=
 =?us-ascii?Q?ykVSPGycCv3jbb+fLFjU/8aUkBdsHv3qiOmZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:11:12.8064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad13620d-0d83-4118-b41c-08dd1dec42f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7689

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
index eaa46ddb50e3..c982a4cc1119 100644
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


