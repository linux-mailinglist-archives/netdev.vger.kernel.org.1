Return-Path: <netdev+bounces-210802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 094AAB14E11
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 15:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB417A2AA5
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 13:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B11C1474B8;
	Tue, 29 Jul 2025 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Eu+CNTAt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00381758B
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753794389; cv=fail; b=fipgt6tN5+rJfvT9xaAFFPvpLhsptvbtzCYLH5d3rH/HE6U8Ywq1kt3xkSmpyZsezmiyYdfTF7pNNINnz0g4iFzV7UaWKJe50RHMjApCww4Xmxwq2fhuLQe0RfyXnl+/b+3rPhymG69FiO2BuK/6Vlywli8Ep8vr3vf1G/3cfJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753794389; c=relaxed/simple;
	bh=GuQtSlxNPY/N5i7ox8bHolh0eXx4AsS38dX324WVBWE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1/5qwcjEzUuQ/Bb9YlleQsk/9ePrZw0fYNON+GznMID1PZl7u4MgRx0KtlquPsIkP8zw5T5OpLpB7eP10ilSp0+62qOGMAbbnGLMVEULJp1HjCKNLi1e3WRYkK5op9J8bJ1B5W20b4o0N5zuo32WVWL4Or3C3WveebCMCLLLBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Eu+CNTAt; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOPWvbY/2eBMHsW8BH63pT31QUaN2GjUIH3pX7oJr1tj7hOIXsHrHD992JC+QAQ3KFz9Pb8YE8JvApJDANNixjw+/ZlDsy7XDLm7xYjraTROkqT50ciqhzrZz1f59fQ9vjEI+2yaXGjxraHCLQ6hqmmJ4qN6GIWrwCSQry7OyPk0UDonOYJWhHbVJlo6EuG1d8NDR26RTTbH7n2sRqh+ried4QVVaWcNzlrE+qJcehTd1bb5aah2vx8VGCR2vQNjOmNJ8HoRTOwqfbQorVQWjUfi0gSM187HTmC4YxRRYU/QF7Ggmb3JS1K12oitqFYPdYu5wLjnx3QHsTT83hhlsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaF7Z5AWzCBEOhAlcj2aV5/XIg0oMFh8JZfWf7A8BBs=;
 b=Sfzf+ppS2u4PWs3jNU0ULe70GmtVTDgT51oqhaxZe8mIe9UvDLstn2t7tekYngNxZNjmdPSJYJmvpMuPxM7sh/SP8KjRBRtHM5kxkOLCtrKdX3rxcsyAhVfIfQABtsdmAqeSnQNvqmcSCKOB00Vb92iX94dAjMPMBN+KP/gCPTF0rc4ag+m9yZHR0I1UbjBSdIAunzJjQwJqY79ynQZZv9dogP5Nr8X7JBFpUHKf7TRMY5q9Tb+KntnTVz37YEcSP/y63yVufYEjztB74LomXo8v2ohpWWG511pTZ/u4kNPX0Orjinew4ZZ6YShYjxhmynxYujxn5Bu4EODCFoHxZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=queasysnail.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaF7Z5AWzCBEOhAlcj2aV5/XIg0oMFh8JZfWf7A8BBs=;
 b=Eu+CNTAtYiIa5CZmvnB+IqdkVCn191GNI2qvetInEqXYg0kQXKAYflZtY7EafpMbBZ7f01QIb4xUoqQdixnwebTiKqKPUDF4JUx0m0ZpgP2+XkskEqY46EOPb4XgdMZiQ4paPo14QOTGFTAFoTEBcZY0xMbAzaySMs97iZ7kuZLC1jW4LmhZruF5At2wWi49lA+I/SniulABHmRyYC0XvSfH5xWOX/rc5FXwJ/XTwXejlWwgqbx7C/6OAYAoAjMM5moC0Cpbmkf1I+rAY2gWGHAboQB/YpQUsbaieSXkGy/6gNVN78wQWtMWnQAgLqYiegQA97Si2lFc8/XNbkpxMQ==
Received: from BL1PR13CA0167.namprd13.prod.outlook.com (2603:10b6:208:2bd::22)
 by DS0PR12MB7947.namprd12.prod.outlook.com (2603:10b6:8:150::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Tue, 29 Jul
 2025 13:06:22 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::db) by BL1PR13CA0167.outlook.office365.com
 (2603:10b6:208:2bd::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Tue,
 29 Jul 2025 13:06:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 13:06:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 29 Jul
 2025 06:05:54 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 29 Jul
 2025 06:05:53 -0700
Date: Tue, 29 Jul 2025 16:05:49 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>, "Steffen
 Klassert" <steffen.klassert@secunet.com>
Subject: Re: [PATCH ipsec 1/3] xfrm: restore GSO for SW crypto
Message-ID: <20250729130549.GM402218@unreal>
References: <cover.1753631391.git.sd@queasysnail.net>
 <b5c3f4e2623d940ed51df2b79a2af4cc55b40a55.1753631391.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b5c3f4e2623d940ed51df2b79a2af4cc55b40a55.1753631391.git.sd@queasysnail.net>
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|DS0PR12MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 9014c538-ed2e-480a-b420-08ddcea0b726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SfQPflfPOBk8ePUfwU/RshG7H7Dsvli71cpH5KdinYh3fHYn4hnsUe/jbRWP?=
 =?us-ascii?Q?z7lS6feY78k1BTJAc3Q2YjoVW79B9vTZUn49OYnKlVPPeoBUsujId26QDVnE?=
 =?us-ascii?Q?iWxdpWsZiqDDRs2388uOisCVVe4f4gBqtXOKCZeAGK/cjboXklTgz6yCNEcG?=
 =?us-ascii?Q?oQ1NUdQUhfofJIoxzFSsi3EecgtcZVygkm+w6EiLMuxm+5PfxHyrgpxl63rw?=
 =?us-ascii?Q?Mo9pBuR8GNmSa8CuGvVhKlyGBV1cIBPe7MlrUA8XcfBfE2qggKGW8lRffVpl?=
 =?us-ascii?Q?v5mCNJ22jJf7wDHklk1vM2gb0NXB5Qsof+pI/mnExoQYIlB53dEJ6p6/WMUC?=
 =?us-ascii?Q?06AbBJRbUZAGV140ddze181P+dAFCuO1LXeoqlgu+1h94F9SEWkUK02zSool?=
 =?us-ascii?Q?7yDior51f729w+VBjIi9NZyVUQ1u0Z9Y2k4vKBAJx+6ynaCmRK7zbBYLUcUU?=
 =?us-ascii?Q?g1E/2zmV/L+Kbx5PAFjBMFqA/slmGQ5QoNV8rGrtNhyYIHcPL52speIyDiXr?=
 =?us-ascii?Q?1o/d73zhaqNErn9ced757en7icRlAjaxJzoAxmbxIJxygzLAa+9jnq11dBlE?=
 =?us-ascii?Q?vY8/qYRzPCsftx/jxludzfyN887mqJZQPR9sSUQEOHX8GEqg2AJdTcmndGwX?=
 =?us-ascii?Q?5/QN+bDGtY+N78D2Zv3e/2u3BcRlhAjRYbZYbR4re2f9d0uFOKec033IB2kA?=
 =?us-ascii?Q?PCffNzv73LO0J7jrcpgJYZGZjXuaolaVWfrCTdlMaVYjVCvUVMXBZwuLcu5S?=
 =?us-ascii?Q?9G2KISAVV4WbHdflRq/QwRGYty4maipJ0Njjk9KYrgr22Kl+N6KMJZ6qExNt?=
 =?us-ascii?Q?JaFB7Oz1Y1ozZvWq2hAfLXy9ryhkuw9XfBDEHNpoZWmYfG2ZkNb6dmZrJi2Q?=
 =?us-ascii?Q?YtHbkqZl7/cY9zWnWEXG7kL8WPwFzJRoWZpXe2za6QGfMez2Mbx2+9xJA28K?=
 =?us-ascii?Q?crkRvnsjUbGAQpfHzayW0n+x80oD4efABPBGFfLFVGa61xDN9Je6WMs5aUeP?=
 =?us-ascii?Q?LoP0SBivqPuHYCD6JkbJfIxcrLxzlag/OXs6EgS0il0PGOMsCECe5Q0D6v5W?=
 =?us-ascii?Q?Jk+ew3yjDcvoqZpgYSk1PZ5S2fZfsjtSN+dWyW2fM0/lN8/FykYdvklun8g/?=
 =?us-ascii?Q?Wwp+hjLpk0ALgAa7TQC0PYqRlSMGSxPlp6wr/g9XPnSvNFcRDO+LmAemsHSZ?=
 =?us-ascii?Q?CsALGZwLY/qrzQsFLtkAiEN8nnhy9ZqY8aRQL+bArZwiGxRy+RDK7Fo0UN/N?=
 =?us-ascii?Q?JdDY+LM9SEhEibJJJCfYJslM857IPXKlf6OpKozY0A8yTD2Dzke+l2QunoT1?=
 =?us-ascii?Q?clQmx37U0lqP4VP+UjaPQs3mzaUCV9SQs/VF1k5WxRCIHl4zRdfFHrtbjKkO?=
 =?us-ascii?Q?R8gvsN73XcYAYG3mOOPo1yWGEBnVwsGn1fGMrvX66yObT1BsQdi7zaqavfTp?=
 =?us-ascii?Q?QNMGhb1wsni+5+Uuo8B86RfbUnlwr7GnfUCb1B5nEm6xBLt0dhFeCo79CscJ?=
 =?us-ascii?Q?qu7Gm6GNamkhrCzWdX4EOBcsi+veOxfHTxGH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 13:06:21.7373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9014c538-ed2e-480a-b420-08ddcea0b726
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7947

On Mon, Jul 28, 2025 at 05:17:18PM +0200, Sabrina Dubroca wrote:
> Commit 49431af6c4ef incorrectly assumes that the GSO path is only used
> by HW offload, but it's also useful for SW crypto.
> 
> This patch re-enables GSO for SW crypto. It's not an exact revert to
> preserve the other changes made to xfrm_dev_offload_ok afterwards, but
> it reverts all of its effects.
> 
> Fixes: 49431af6c4ef ("xfrm: rely on XFRM offload")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
>  net/xfrm/xfrm_device.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

