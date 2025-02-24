Return-Path: <netdev+bounces-169046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C251A424BA
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 16:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6034219C7D08
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E2825A332;
	Mon, 24 Feb 2025 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ebzpg8i+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71748156F44
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408481; cv=fail; b=c5zBfAViSEY4t9iBlGTFwb94lT/r7CsbFrb38ZBH234YXCIXa+Ht+nrZfQ4SF5s/adNuTuF8ATZv8SQCNwuoTxCFzkduPojFu+Em1nlwf0+3g1RGPeB9OsMK/e2iKl8VJT+K+I17CJj30n9E1Or9QgMBTyuFxBdUyoUQcpALrr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408481; c=relaxed/simple;
	bh=MrUW1qjJA02ZdAGKdIldoHD2EIHCciQayNoG/1TbbWA=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qeRUcKT6t3+jsiRspmp+eMgHPFhLhehHzBn0kdCJvFVOG1RoHJP2nUBSDnBRD3mHSCOvM2mRs49zP0QIQmh0Q2XeHeqp/OTfqSRVKS0P6TahI3HVUQdRTZ3XwJ/JN7KNpMiXLNjLCoVabYPiAuJrSyiE9/2nYrG4lSmn3xK5/fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ebzpg8i+; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9ZNkW8SRBaIQ4VWpHmsLzI9CV/hglpdHdVm+af6N4R6X4FovS1SE573nocFWPq6BDsa4TwoRF/oMqLEVd7t7hw876x8H9kkVUAKYtDByQLA8ASQiqO90GVtVargyycL7hEw9MkmYEJvxdN23Fn4Bbf25nC2YMKu1x2UcnzjgislwX2mlocioePk/nVwfKqYJ9a1vEEvo/I6t7Fn9y3MRFNm5nhPzlTZD8SNkCO2Jm0QoRiysKHvk5/A6l6hC+D+O6Ew6E+KSg9+AuBEjfYFyiwUExSYPES7XuTiOAn8hQ0qF1vEaJpyCg3ZRv4WPOF04PlYBOU5MKrLkjHnr2Q6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqeiWVoAAlU4pWJHz4cT8lXlRMUmwMwbuzcviTTBwyY=;
 b=b+n7YZH6v6HtUxiYpAgv5U5XcWh6pj2OIbD4TMD3SgRsyFgVSQApu4dfbITL6ZfezNfzSgd2UGnfudjPjtZdVzj1yWn3uSfimkSi6J5+pwGuZw2Q7q6i007mDT6ux4n0sfJ6M6hEjc+T6XRPWQ8UqrDiu5y0TKhjr8Gax+eXkysneq1GqzVcJ5I67vpvi8sxhZ/+U9Wt8mita0L9tVRWT+R26QXO3FzZHqq0epSYf2+PeUMDkYS7KT8M62HcZ5Fd6i3ZQb0HX94+R5BWOVsqk6dmaGroQ72UO1toKgFvyyJnuVtP/S38JTz1zhSULxMgcYVIVuC4gJD0wNvywTX0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqeiWVoAAlU4pWJHz4cT8lXlRMUmwMwbuzcviTTBwyY=;
 b=ebzpg8i+oShvQ1lPRGU9f70PKQ0hF30uZ3qRh71NH4RBaFcZzgBrbrBUMXl6jfhWRZ0N7+JBbGP9C58bVJfwCz0wBY2R15Gf9xCM9txOlj9uBbeKp9saEOik1piwpa+F9g3Fzo9YP2K4Rb9v5/6gY8NhYcBvgbtwGMagJyX2cacWuGV8N6aXr14A2iLLz9pQCLBmMI22ZOrjgYeTVnT9HqUMeq5cAUUwJ9R6NgCX0AAJcK9fsyBEsK4a/xIPVlvYgmicFLkpmome9WQ2+TXW+tlarNpCh/j6mFYXs9U+6oMzYdMEgko7F3u42GgAbPerMsVXkgk0VEamcF4wjuoKQQ==
Received: from BYAPR08CA0061.namprd08.prod.outlook.com (2603:10b6:a03:117::38)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Mon, 24 Feb
 2025 14:47:53 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::78) by BYAPR08CA0061.outlook.office365.com
 (2603:10b6:a03:117::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Mon,
 24 Feb 2025 14:47:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 14:47:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 06:47:40 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 06:47:36 -0800
References: <20250224065241.236141-1-idosch@nvidia.com>
 <20250224065241.236141-6-idosch@nvidia.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: <netdev@vger.kernel.org>, <stephen@networkplumber.org>,
	<dsahern@gmail.com>, <gnault@redhat.com>, <petrm@nvidia.com>
Subject: Re: [PATCH iproute2-next 5/5] iprule: Add DSCP mask support
Date: Mon, 24 Feb 2025 15:35:51 +0100
In-Reply-To: <20250224065241.236141-6-idosch@nvidia.com>
Message-ID: <87jz9fjt6o.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|PH7PR12MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 313b7c97-36b5-491d-ad8b-08dd54e237c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jsaoN3qgl8pe0cjYuHUy2/UeGNe+cCHDvSVL6ipQD50zemRiQ0rr6XkyJkjf?=
 =?us-ascii?Q?tSWTa4hYMG5s9o5KTuQvcpLT0am1uKDYXCHjWneBsX0gQc41LSFzPW0QOf4a?=
 =?us-ascii?Q?UUxn7Af1ckLOcV/8QeQVgVrCh0a4kAIqFH2k0utjB2iH1RgiHyUooEHul462?=
 =?us-ascii?Q?LKMxJZjGp0htlzj2JefAAEU6Xo33JUHE+2eUjb6sYRN+YSh7tJoVjAgeWup8?=
 =?us-ascii?Q?d3IrlOR8FyJz8SjFl9MpmIhfmTPekpBSZk6/Kdu91upGKOTCaB4SFkQs3OUa?=
 =?us-ascii?Q?W0b7obdomS1lf4mZiVrr+oWbN73bl62fmDJlkr46fFzXhskgwky/8TK0kBaY?=
 =?us-ascii?Q?erYD5uJwhlYF+Fv/clbGr1LIe/2JhOii7TxasCPdID1V0/juKdXMtnkVP/FU?=
 =?us-ascii?Q?fjBcAJEpqnBzcBE6uV2USNbObTl+TRuTYRkUKq6PhpurKgATcPryvbGKZ26T?=
 =?us-ascii?Q?9KOKpu5y8aKk3EeE4p9/pLAsFsSSkHODkbdjwouucPEI7UeKzfunoDyZMLYj?=
 =?us-ascii?Q?+hwf5yFPHr0teZAq6h1AekK/Rq6MwBtBJhkomIbF5SDz9ewpREB1u9+0Euub?=
 =?us-ascii?Q?LJapV5e9Pve2FP54JHgTq6u8AN+vejNSBaS+iXWxAXLZ4u2xkeFBxtZa4I7r?=
 =?us-ascii?Q?YKjTnELB1R7iFMs5QaXJxsJWVOWa6tW3IGSCdaRZ3b4ultRdMe0j7MbQTA40?=
 =?us-ascii?Q?uqn1q2/lZCMrLe1ITma15dANIP2w9TKMKFn2TLB4V9cadU9vPALDPPlbYIcz?=
 =?us-ascii?Q?1tKfpbrmJ1o5uXI0l6Ck++VcdLbyoo2mM1qeACoaEPBjafPzn8DAN4U7Lh7g?=
 =?us-ascii?Q?2MXyjqMA12Nz4wqXO1rxjTxVjmSJbqz9A+eXyp4R2MqKHDbLFZtxpA0jgUt8?=
 =?us-ascii?Q?EVt3V47xJfvhryZLKkCSbQd2O8Tpr32lKYRX0Ama1WcJZqmZ8Gnb2zGcyhp8?=
 =?us-ascii?Q?7QGIu0oyWzVk6Zt1Ec1YqTZ0gQoxOmSCDfPc7YnSZmP7SvcAo9/dlqzhSuJg?=
 =?us-ascii?Q?1xWUW8fAuHn+kQVCuC/f6DUnorOWgBIpPLy9SFYMiEr7vEDgtshLfCUNgrkN?=
 =?us-ascii?Q?9nTDo/3F9y30mb2K/SplWmLJtgmm2ihUdSEKxua/u/qd/fI8WrFsG1brJd7f?=
 =?us-ascii?Q?H2AxzyS84z7PrF/ggFVg03lmS2OuH1erKxMjTC1kGsWtrZnO8bry1pahdBFA?=
 =?us-ascii?Q?JHw1uMi90zjxOQxc2oJvjqTrIp+EomaDtcgLAtGbugJrXpPJ4lqMn7Blh0yB?=
 =?us-ascii?Q?a4Bs/kfxg0V6CRc70NTtDvu7bVFtuA9/Ufe47KBBEZcExUFxOrtytTq9XY2j?=
 =?us-ascii?Q?iYtp1cIpAdiZUn4uXVt8SGif78BbxcpBQjpUz+IF0RW6xFMkoHKcwbRrjzsW?=
 =?us-ascii?Q?ghNYzL7o8RW1Qg4rxaeuFpnlFG48aWGSwaA0O3YuhefLVFsMZnnWDGAM3Zs7?=
 =?us-ascii?Q?S1mVBWawcdyJArhMrA8XlaQMOaDvDgxOdtM9fXIfg9E9L1wLE79Gnw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 14:47:53.0791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 313b7c97-36b5-491d-ad8b-08dd54e237c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654


Ido Schimmel <idosch@nvidia.com> writes:

> Add DSCP mask support, allowing users to specify a DSCP value with an
> optional mask. Example:
>
>  # ip rule add dscp 1 table 100
>  # ip rule add dscp 0x02/0x3f table 200
>  # ip rule add dscp AF42/0x3f table 300
>  # ip rule add dscp 0x10/0x30 table 400
>
> In non-JSON output, the DSCP mask is not printed in case of exact match
> and the DSCP value is printed in hexadecimal format in case of inexact
> match:
>
>  $ ip rule show
>  0:      from all lookup local
>  32762:  from all lookup 400 dscp 0x10/0x30
>  32763:  from all lookup 300 dscp AF42
>  32764:  from all lookup 200 dscp 2
>  32765:  from all lookup 100 dscp 1
>  32766:  from all lookup main
>  32767:  from all lookup default
>
> Dump can be filtered by DSCP value and mask:
>
>  $ ip rule show dscp 1
>  32765:  from all lookup 100 dscp 1
>  $ ip rule show dscp AF42
>  32763:  from all lookup 300 dscp AF42
>  $ ip rule show dscp 0x10/0x30
>  32762:  from all lookup 400 dscp 0x10/0x30
>
> In JSON output, the DSCP mask is printed as an hexadecimal string to be
> consistent with other masks. The DSCP value is printed as an integer in
> order not to break existing scripts:
>
>  $ ip -j -p -N rule show dscp 0x10/0x30
>  [ {
>          "priority": 32762,
>          "src": "all",
>          "table": "400",
>          "dscp": "16",
>          "dscp_mask": "0x30"
>      } ]
>
> The mask attribute is only sent to the kernel in case of inexact match
> so that iproute2 will continue working with kernels that do not support
> the attribute.
>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

> @@ -552,8 +560,24 @@ int print_rule(struct nlmsghdr *n, void *arg)
>  	if (tb[FRA_DSCP]) {
>  		__u8 dscp = rta_getattr_u8(tb[FRA_DSCP]);
>  
> -		print_string(PRINT_ANY, "dscp", " dscp %s",
> -			     rtnl_dscp_n2a(dscp, b1, sizeof(b1)));

Hm, this should have been an integer under -N. Too late for that :-/

> +		if (tb[FRA_DSCP_MASK]) {
> +			__u8 mask = rta_getattr_u8(tb[FRA_DSCP_MASK]);
> +
> +			print_string(PRINT_JSON, "dscp", NULL,
> +				     rtnl_dscp_n2a(dscp, b1, sizeof(b1)));
> +			print_0xhex(PRINT_JSON, "dscp_mask", NULL, mask);
> +			if (mask == DSCP_MAX_MASK) {
> +				print_string(PRINT_FP, NULL, " dscp %s",
> +					     rtnl_dscp_n2a(dscp, b1,
> +							   sizeof(b1)));
> +			} else {
> +				print_0xhex(PRINT_FP, NULL, " dscp %#x", dscp);
> +				print_0xhex(PRINT_FP, NULL, "/%#x", mask);
> +			}
> +		} else {
> +			print_string(PRINT_ANY, "dscp", " dscp %s",
> +				     rtnl_dscp_n2a(dscp, b1, sizeof(b1)));
> +		}
>  	}
>  
>  	/* The kernel will either provide both attributes, or none */

