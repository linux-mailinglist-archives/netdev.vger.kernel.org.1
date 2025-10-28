Return-Path: <netdev+bounces-233391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F769C12AA1
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C0040179C
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3469325A322;
	Tue, 28 Oct 2025 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pj3k3a3l"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD86316F265
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 02:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761618642; cv=fail; b=TrEt9vaCuqqm9NR9u/WDKGGILGjKc6K2wxQ0K6sEiPYBvXbenKrLNT6DKt4BhbdRr6DvedWbsAkzE7CFs472Bxgm0V1qNkocy9hbT0mL+jD8C+PcjYGMIqFlMNcgFaE6suf5pWSHIBuJu8XjPM4VGO9vSP2RT3vfq/lTsAN5/t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761618642; c=relaxed/simple;
	bh=oAenVAkH2CAgcZ1Vb9xOcEVFYC1EekwBRXVEK3szIkA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HBPCtM4hLS0k8nUQxVFZPNxAstwo2scDSbOjDDr0IGdeth6eG0V5v0DSHB/eP1wXHoD6zJXiFyutFtJrD722aSj/f32qjtJk+eDcAsHnT2LJ1AO50bIku84MV2mFoI93Giprz6tsn5RikaYWtJ3jW2w4kGhR+8KgjH9ryc2g0fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pj3k3a3l; arc=fail smtp.client-ip=40.93.195.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+bSdAyPrHVzgjoZTg/4KRmPr5WabM4jWSkER5D9HiLydqlDQXpxq6xnqGbG1oGF0KbKKi40gMBJUEseDrxbbGcelxSfcRX0owk4GH/bBiuzBAq5xR6tqwD2/AVLPu6sibd8YsftHzATQ3PFv0Tp+7Wwa7NLTT+btZQg00eU0ThN1MEoSVJT+bZyzD6XXhXZqqsQZiyz5TAllWVPz6tBCFqpbZkDBVHDrUdxCzfU+zzTkn3/3lAPl6+qhl7BWbm08t7OAegY7Ho3w0DJeDWqD+BhssnunlMssbRXcTBg4zGN8uCnQsycf8rskR9yMkbDdBGIkAQ/U5hWr2pz6cXzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCu7IERhXT7JyWiZlKE/B/sW6mD97OkBka/hh3Jgxkw=;
 b=aRAHOAjPTY75HrQ2+yUhClYEzYvP4zCnEbZhuiFbEr6KAHwRJJIkm4aX4TBay0TRaVHT/v4RrKxba+BApQ28J2ChqU+xPB+YCEniNzVQLLTN2alSyRAiyu/4is/jo0fWMhhVwZia9nIz/UnGnSV9JWRDooZ16N9zZvF+69RETIJcpfoTH56AekkPojUk87JAlI3bMH3Fa00TigF7ta4cHGERYMK7BP1IBMbCtfQIX39aiqcDB8wLTsRxe5rYNdfIgsqLXqRVrDdwo5Jadr3qLlBZVVtAHZBTQp8SsfCyFafv2ycHzBMymJ8otNpNqN+w62QiO4EHGhrh8n4lHh0t1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCu7IERhXT7JyWiZlKE/B/sW6mD97OkBka/hh3Jgxkw=;
 b=Pj3k3a3lXHNF9+/N7KtIW4zuKx+JBexYIEGg1GqF1GzLbaozZTdJmYSBv1rkbapweMFlcY3OGbM3r/NjC/lcw9YmetuRJo+WlvjLWt+q61UeLN0rOAOTfTrBGf624bVKFKxNjJ4ulVnULNs8dOrIORPQcbDk9CCPQVOI4r7VWz0GPpjKs+OofA+wUi9yXEfreKi/vTaTtbjNQFX+wNEdFMhfg130EGSDp2qql8kBcklPd/lizBM9K88AW3+YpHHaQFeHFrc4RNiNJAeBdcTeinbhvhWmIkwFLRrxJPvDczmR5DnqobFmk+AbnOwRnJ99p5b7LIrBIcsZQR9+qnhOfw==
Received: from MW4PR04CA0214.namprd04.prod.outlook.com (2603:10b6:303:87::9)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 02:30:35 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::28) by MW4PR04CA0214.outlook.office365.com
 (2603:10b6:303:87::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.15 via Frontend Transport; Tue,
 28 Oct 2025 02:30:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 02:30:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 19:30:20 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Oct 2025 19:30:19 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 19:30:18 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>, <sd@queasysnail.net>
CC: Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH ipsec v3 0/2] xfrm: Correct inner packet family determination
Date: Tue, 28 Oct 2025 04:22:46 +0200
Message-ID: <20251028023013.9836-1-jianbol@nvidia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|CH3PR12MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: 069a38c3-0612-4307-c4cd-08de15c9f934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lJ+dXFGqVnAW/ciHyZgjDe0mNtN/9AJoyiVpyW6GEyl6OiAT8ZamwH8e7okK?=
 =?us-ascii?Q?tNhAi6S5d1UZP34dEdPMz5pMCNa7fKR1OwHUnsFAN14c8O2qiEMUztJs3ObV?=
 =?us-ascii?Q?xYk5K4ojKNKvBpFKlhf30u+J3YyeVgABYHJtK47p5oBeLl7U8EE/MRlUIBVY?=
 =?us-ascii?Q?t7gr6oIKveybhepDSwNeDGeaTk7way0Kh4kbe6EYrETiytIvUadla521uxg+?=
 =?us-ascii?Q?qsxF74C5nUdqVbeXPKmKr8gF1O1Y/LtxVnCRV+6Ajv35Zwx7ufim9nKcgyo6?=
 =?us-ascii?Q?8Ng1YW64gL9iy66Vh3p14osjQD8L0xncnTzS2JuCeWgKjYA+pCB1eNcGN6M+?=
 =?us-ascii?Q?G/nRq9GG1Ce7kFSO+bshqcG3XEg50KyykwJVILS2ieIhlxCmWkGrgXsGur85?=
 =?us-ascii?Q?JJAyNdyppqe3BPoIA0STWmeXWW7q9gK/R9diOqtFwbrKTuTAvmsaO+pgt+LE?=
 =?us-ascii?Q?bnElxlNpsqyPP9AJ5U+4R74/b4rkGLqEFWOKaF+Rkkby5da0NajglywEbXNR?=
 =?us-ascii?Q?TOlg4KLBllmPui3ylYu+LnUKn7+z4RjonVfw7hUSvHjIbMpVA0QB0BZV+z5j?=
 =?us-ascii?Q?A/lKZ5G+SALD2jrCPtt4moVHhxeaItmWFr7Dby6Hu/VuEdDk3aY+jEgJn1PF?=
 =?us-ascii?Q?puHAdI83lST6Vnmvm/HfFe9IOpbkacCbZWwYbxdP41/QBAQ2IHYswaUKmivJ?=
 =?us-ascii?Q?8soJ5wT72ksLxX6d/xSt80n4ngcZOvkkI0wKvqvEQpgAlaRRccpF/A3Y7Ru9?=
 =?us-ascii?Q?xvnlgWyWdtoQwokyTVAMs2OqtPK1ZpOL4/r/tGziXWga2n/Gml9SUhRbCD2U?=
 =?us-ascii?Q?rXEfSwhiBaSQ92GF8xoR8U6aBrh2kxN/L5QnbyPrT9+2cqoBdGg1SoCyPTm3?=
 =?us-ascii?Q?IKYTzN1KpZEXkE60yU5JYyUtYY+BdNyvnDm7RxGnzI3wBU6fNTDc2e+asRBc?=
 =?us-ascii?Q?LIwmJsjdmOPXUt8meJVZp1EK2Uy3C8sTGa75nRmbAvdyL56wh/+GO8WqAVtg?=
 =?us-ascii?Q?G2Ubmga8HixXpzfejyb8os2YXefKf+fuTgmK0MyZqnS62Ovf611+M4aWbQK1?=
 =?us-ascii?Q?I2ov+AysrJvU5cwx+cVRqWSdXKBRMmadLW6R+8BTR/SYa4GhbBV0GBGjEwOT?=
 =?us-ascii?Q?c8mbzl0HrssUQ7r4JP6jShGYcScF+nfkdpIiAtxtaNi8WXICtVpm0+bzVMYi?=
 =?us-ascii?Q?JOS0uLIKX2wzfc7WhwG6UVkQsh6WunZM0WjerIF+mVYpzYyBLp6c98JAocFq?=
 =?us-ascii?Q?NhWP2ygiR9T/w6YRiugQwA8l2FntNdIN4QXmrH0fI4tpw5gPnF3Uv37Epl2e?=
 =?us-ascii?Q?6XflfHXbz82LKbevmYK0mI2K0BU3C+w9rUnY1tMSIL483Z5sgTe0WtJRpuCN?=
 =?us-ascii?Q?1kVsuGniUNnlWdAzgRgtyFjKW9rUvkekm305yaAn/1ZR1BcZQsHx9JG4e5a3?=
 =?us-ascii?Q?oa3kv95QBsWH2DhpBUi02oCHpiZQqI8cbI7HO6WBBkpwGEk6oToK4KyJLSK+?=
 =?us-ascii?Q?fKGeBf14jW2bD3sy2+pKvdXDUPL93cDuQ5kq/4t5oSCiVHUOMrJitZ61e9tV?=
 =?us-ascii?Q?AqrrqYul6cyXfVzc7D0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:30:34.6021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 069a38c3-0612-4307-c4cd-08de15c9f934
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548

This series contains two patches addressing issues in the XFRM
subsystem where the code incorrectly relied on static family fields
from the xfrm_state instead of determining the family from the actual
packet being processed.

This was particularly problematic in tunnel mode scenarios when using
states that could handle different inner families.

V3:
 - Change xfrm_ip2inner_mode for the sel family specified

V2:
 - The original first patch was sent separately to "ipsec-next"

Jianbo Liu (2):
  xfrm: Check inner packet family directly from skb_dst
  xfrm: Determine inner GSO type from packet inner protocol

 include/net/xfrm.h      | 3 ++-
 net/ipv4/esp4_offload.c | 6 ++++--
 net/ipv6/esp6_offload.c | 6 ++++--
 net/xfrm/xfrm_device.c  | 2 +-
 net/xfrm/xfrm_output.c  | 2 +-
 5 files changed, 12 insertions(+), 7 deletions(-)

-- 
2.49.0


