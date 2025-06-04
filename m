Return-Path: <netdev+bounces-195076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5FBACDC9B
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 13:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E1D3A5942
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 11:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B25528D8D3;
	Wed,  4 Jun 2025 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uqWvcA6E"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078E228E594
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749036825; cv=fail; b=HQlM08+jRngKc7cvqmnwJPY6wn4EWlmTJ8+wr9cS+7d2PyjE6OBPI8ri+6y+60cL4grw/vUD+KMldNTepkRdEefwzbA1ZCNrDhAWSWt31OlVoMlr0aH3CVoSYqWtg/TICaY752lZeVRmuKvt1usJgrs3s5/y8FOCghSB8K7moHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749036825; c=relaxed/simple;
	bh=cR8Pqgv0k2Ma0ilCi4jJWaiIH1NJPrniNUwEIE39EAE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q+q8uA2lXSE+qnjW7NHW3vdJ4AYChpI8kV2WN4qU3ttjSaVVmLSe/mf/5EcQb1eZVX/ciucyLCuk/b36CpCSwE/fOq5OF2C7VDXQ1GCEbzjUxudbxS9lvTvyta8LzMeZ6ahMzkD9FYTYfOLXNwPcTNgakXVTFbxNUjj3UNxb/fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uqWvcA6E; arc=fail smtp.client-ip=40.107.220.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oO8OlZgWyrZxD/MQxWuPxe9jYptQVTZR8NqaF3dRpmMqSzChUCajsCCM6/xYLtdWZHR9G09zAZzcunrXz7N49Ex1YYhW3A3hIM3uqhxKxz0OEO1j0yz0/Nri9I37WYttKIAF0wpZsJE1RX7xpMjBT8vJ1Vf3RXKH2T+bd1Gz36IY3fbU3SScTJDwCZl3xWeKWbDdcp1baIWALkoWLCHz6AqhUwD6a+G9n0V/NIPw36hujs6TaMsxQ3GAu0asK9+ghxIjh+VYq1Cjaag/duXjiIP568+PjaWRR//XGIfak//dHdRAc0NJcvHgBenBSkUKcgwf1X/N0XjnlR2TcD7Pww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z54+7EoQPTfyml2OqSDZoF5VK+3g4Olln39FB7PThGU=;
 b=ukZEtr8WYd96hwsjVrB+4leYpb8nROE5qpEXe2hyn1NO+sx66pVjZTodEj2JiUknOar5ncSjcZ6X+wIW7jsSTxDIJk8U/aC62OJwIk8LZAyvLlweJw5wwp69F91r5LzI/7NQLIOvuTOqdprsZFFf47SbKACcNXl0ThWr4Q2iDfM2lUUBWbk8ERjVGovKS0omKAeOdLxy+lGRX4UXAcW5kp76vercVJOwdJsX+iUbXwTXrwOA2UT/l8//cQ3M8D4+sGWiY8j5ZTLpj0yv1yEE6MD6Tl6W5NvxS/Ms592MpMyrPfwbD0/675skSJNJhLGr1Ep2zrz6Lv8SiWsFiwrcqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z54+7EoQPTfyml2OqSDZoF5VK+3g4Olln39FB7PThGU=;
 b=uqWvcA6EL9mVaCdWFnxTF261PeSafYe6DU7ey99qoBxDD9wGdvNcWY5D67IFRtldQ3EEPGPwk/sy7XT+T3SaPA0c0aJHEigqMztZA1yh4mHMBmuvqRByHndya53yN+TTOYYjeiNtu4V/cY3G265OUUAXxiWMeU4SFYPqTZhPlXOVeaz2SfzmJFPoep20LJ4YyeASSEdkpt9AOZSRGvTVBhAN/fwrPqIGGtwFwzK3B3b3v2PuAeQnD6Xn51Oe1RQLbi9GQ0kBwU7vyDib/qXNvBdYdIHSQw3gpVUtqzHOKkNbdyQf8GRGmfGnC3+OWyYoza4KpZ9FVxzSlUGxZ3AP0g==
Received: from BN9PR03CA0390.namprd03.prod.outlook.com (2603:10b6:408:f7::35)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 11:33:40 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::b7) by BN9PR03CA0390.outlook.office365.com
 (2603:10b6:408:f7::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 4 Jun 2025 11:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 11:33:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Jun 2025
 04:33:23 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 4 Jun
 2025 04:33:20 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrea.mayer@uniroma2.it>, <dsahern@kernel.org>,
	<horms@kernel.org>, <david.lebrun@uclouvain.be>, <petrm@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net] seg6: Fix validation of nexthop addresses
Date: Wed, 4 Jun 2025 14:32:52 +0300
Message-ID: <20250604113252.371528-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bdf332b-3962-48dd-38a7-08dda35ba7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YdBcHsiUTqlwl5Qn394me70PrQpMm00mh5mhA72JqKEYuDaRRm1lyVena70d?=
 =?us-ascii?Q?4bHoKCLSBT5twixCmk39URgJrii4Maoutz1pmo+JcDXQCrC29ou6pbVx9iR4?=
 =?us-ascii?Q?8GB5UqHW6Eflsz2IimEpkvse3cI1XBJPJDYv/nmeyYNRSZqMUaY4YB5lXfhS?=
 =?us-ascii?Q?bGwh1ELRUD1p0yLtIVvQDJUPvbXGs8DqXxyedePoYq6jzCmoJjg/XvZkOLPT?=
 =?us-ascii?Q?FSLHBa5fZ7pP7cIdgAiR4jyv5RxpRQ3Bqs14dwClkr/L94/gY4iA2YHsB4rD?=
 =?us-ascii?Q?tBRDsD9hUbS8IBvDVUkViKgqZqDQ03A53Hmlbx6jmLmqIPH1wQ0r23ApYGgz?=
 =?us-ascii?Q?qEUWgv2UdA2F2XEFnaEF8RQVHrS6/47cUy6+8hVyScGIZZvVIThSAHKQZatJ?=
 =?us-ascii?Q?t96LOUI4dk8j4vkde+QPCmInAC3Di2cBlcoC8Am6ctJi7fEAa9fnjjy4in7X?=
 =?us-ascii?Q?pLxJDyLMC5SBNfmAkvv8b2y8Gg93UuQx0zy0YmIxeWzHmfWw5RuQhIQCsl3f?=
 =?us-ascii?Q?o+kqryi/MDY8sGhcfOi59kgVnuHQ8iVbfj91oGIQ+S0rze4V8UA93B2HBryA?=
 =?us-ascii?Q?lbHWNkenxMG+4tVrERDHVsTZWek/YciSASikT49FdbzlU8yA0v+0mh6QGS+U?=
 =?us-ascii?Q?fAVS2Khdod1cCAq8MCtnM/QPSz3QxChPOhLCJQvI36C7ibGvK6DXIJZ/v4l5?=
 =?us-ascii?Q?Ukj6aFFGJI/1sUPXNHEtsw3E/Z/sDQx0Wdnv+mJzSgkpnaGcjy5wqbfzSj5H?=
 =?us-ascii?Q?TZAR722aKpvFy7653ctB2EFDTnPRHo7Ee8+7ynRhYFAXZVHzdk/ORhg7HlaR?=
 =?us-ascii?Q?kPowNd6fI9qumNCPkSqrqt6qG74dpMi/kvvFxgJyqB+81hdJS1/DnSPStwxL?=
 =?us-ascii?Q?1cEHlw0bGe1UWOU8GAnmqBGVtvVxStCfO2hy1iOn1ZXWjVcD8oZAzKYBVXzB?=
 =?us-ascii?Q?qeUJKoaif5xxC0NCpaxJJ3xLMW4sReoZE98gZr1DZbfWSmHIzVZDe4gn5SdW?=
 =?us-ascii?Q?pYjtXhM0rF32xchnwaxjHoUWev+nF9TSwcgXdpTiXHv6CxyTMcHwVTkVVpzu?=
 =?us-ascii?Q?A/havj6EhkLMDwPS9fMJ/0OoIu2mRJqFd1torOWBljInt6aWtNwgr2NwrXp5?=
 =?us-ascii?Q?bcqMiWhNaHtVj7YaanRpH6K2pyv94BqrPsBwxeFfHI04xTThr8UIgn5Q9ruh?=
 =?us-ascii?Q?oTBe0O0vLyjCm6sO37q6Rf/RV3WS8XT6rd9Qdm85dV2hwGFmVq96pH41lAM3?=
 =?us-ascii?Q?djX2P4CxJ60S0NnYr7UQ5jn/MHuSuDg5xF6klmYDQqJHGOUEvGJuQIkrOTzV?=
 =?us-ascii?Q?SL+GEE1cvu73o/+2Aio4c44VZA3xlrxRMQKJtwyqC6I/jHZ0OohX02HEIG4G?=
 =?us-ascii?Q?4KYBHYT/RDYdAuPSLQiHoZkOzt9Vx3OOpHK9XaUsih8JppTQ4UEil/kFYlaR?=
 =?us-ascii?Q?G6UfCWzzAQ8xfqQ0UVD5RmpuHg8iiGqPr/Ck+WbvdLHx3nUI41BG3jLM7Ex+?=
 =?us-ascii?Q?4BRy8HHNmCsBundJgs02WS9NOjH5qw6VbRws?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 11:33:40.5339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdf332b-3962-48dd-38a7-08dda35ba7b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550

The kernel currently validates that the length of the provided nexthop
address does not exceed the specified length. This can lead to the
kernel reading uninitialized memory if user space provided a shorter
length than the specified one.

Fix by validating that the provided length exactly matches the specified
one.

Fixes: d1df6fd8a1d2 ("ipv6: sr: define core operations for seg6local lightweight tunnel")
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
Noticed this while extending End.X behavior with oif support.
---
 net/ipv6/seg6_local.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index ac1dbd492c22..a11a02b4ba95 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1644,10 +1644,8 @@ static const struct nla_policy seg6_local_policy[SEG6_LOCAL_MAX + 1] = {
 	[SEG6_LOCAL_SRH]	= { .type = NLA_BINARY },
 	[SEG6_LOCAL_TABLE]	= { .type = NLA_U32 },
 	[SEG6_LOCAL_VRFTABLE]	= { .type = NLA_U32 },
-	[SEG6_LOCAL_NH4]	= { .type = NLA_BINARY,
-				    .len = sizeof(struct in_addr) },
-	[SEG6_LOCAL_NH6]	= { .type = NLA_BINARY,
-				    .len = sizeof(struct in6_addr) },
+	[SEG6_LOCAL_NH4]	= NLA_POLICY_EXACT_LEN(sizeof(struct in_addr)),
+	[SEG6_LOCAL_NH6]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 	[SEG6_LOCAL_IIF]	= { .type = NLA_U32 },
 	[SEG6_LOCAL_OIF]	= { .type = NLA_U32 },
 	[SEG6_LOCAL_BPF]	= { .type = NLA_NESTED },
-- 
2.49.0


