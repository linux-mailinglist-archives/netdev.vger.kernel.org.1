Return-Path: <netdev+bounces-169388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E31E7A43A8F
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193BF18950B3
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1728B262806;
	Tue, 25 Feb 2025 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KBIvFAJf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B41264F9D
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477549; cv=fail; b=Yp0VOebfxZzayKhfgkSGpJGn5DSQav51TKq0lbN7FwdciXJFhQbBiVxx4K12pwnzCe8uGD4JYq0pnyGJrQoN/jYaYoUrudA9Rf+np41YvSP35c6tL5zvoOhYzNOC838HCHelDBXr42Cj7Nc4UDtfyZHeTNBXRvIb88P8TqKjU30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477549; c=relaxed/simple;
	bh=YqwuOxgsMu61AbfM9+HYOdw4oeFCGXM7GjsxnevazeI=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=nPEDYIAEPksFpDLBz0vGjXekmF4K9vB4PKx+lDqWh32ds9vhkHhodvojuxbL+nsPgcmzFa7F444Ot90Sb3M5qM1pKLQ5QzGVO3ULQVkzxwSnffTw7g302uudSJeQDX+ngCgXkYq+xClWKEAGD7xc1uoALYU5zXtkiOr48xq3bqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KBIvFAJf; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCllmZBqf29hidFeh49qR1bFrqokcTOPu79XlDS+nL74sip7iSlnq6KwlILc2NoNL4uEzq6/tC/35KppKq+LO22hrdqOKgn6FBHWaLZm/A4KSBFg27c8o1pTU78W1vCgOmkHJjd7PJsnOtK88R9nq+3cFTKsJUJnJQJxI+VT72M75j7xrJ49uPJCXhenm3XNbt/uR0WClGZymgT3ipLYHRaC8uXvra5U2HByMSdJzfRmsprvYmsRfBTAHNIDKmozfWFh1SAwkSZZSyVLre09DE5/iaeP3KTr/HuBaAXeRBM23HUWHizWoo4jRR9folnu0kYsEydnWErZ2nNnlTMvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8yPg2L0G058lNAea+p7Yt/000W55se/Df1OI0VQTh0=;
 b=j3EftTOE2PzRdca4EENxKez/JYr0YPwoL+d8t7UUDv9WEIMH3zL49gt+NiGYG3QGC9nh6Fg9pgAdtOvvv/c8Y3h/5eHdnUAhAMlSMoETt5WGang1r+s5gUbjnrShLFOIDZd6OKFne08jwn3TE/NL6AP50rm/8i0fFqt8XJf5HT9KEdOVdHB7+yb2ecfhYLdBsF7Tq9G/C/7XwyKVq7pw8us9gyo9wF9t2tjY6kJiYjvS0Hnp/qTrXJfxTCIBMc8DBzggljVxKteI+Xyh6PCtryROUV4HxkNwSHQ88YXbaN9AXZyi0axra5sjBLeak34YrpoggYj1rDiZZRaDD2oJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8yPg2L0G058lNAea+p7Yt/000W55se/Df1OI0VQTh0=;
 b=KBIvFAJf1U4hzCd+U7Zd2f3SMmQtGp+2MVb3dJ8BWoQHGRZcddOOLa3GVSlSQ/zkNcv1lY0k2fT4pXoiHAWpxRHTqf54tcwuKQ7VR6n3Tg6Se+TSZfzh2JJ0XTwVWI0sCoa/N2LuXp17lrFl4PClJUiPg2Dn70lqAkIDknDpD1RGsULj7Rohc+YGWe/yuyBZnF9HC0Y+eEVr/6y4a5+6aDNOkRUFyds2tP5uOaBV2mJSE99pcBW2s/M9FPqsKXsbDgdNWIReHKQnQLp5nNAPtqH62P1uE2Zp9tqyHaAcGClMEuRMf6Nvb43VykOb2EgWj43fj6bGp+Qj0SWEaVgJ3g==
Received: from CH0PR13CA0026.namprd13.prod.outlook.com (2603:10b6:610:b1::31)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 09:59:02 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::f) by CH0PR13CA0026.outlook.office365.com
 (2603:10b6:610:b1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.18 via Frontend Transport; Tue,
 25 Feb 2025 09:59:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 09:59:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 01:58:50 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 01:58:46 -0800
References: <20250225090917.499376-1-idosch@nvidia.com>
 <20250225090917.499376-5-idosch@nvidia.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: <netdev@vger.kernel.org>, <stephen@networkplumber.org>,
	<dsahern@gmail.com>, <gnault@redhat.com>, <petrm@nvidia.com>
Subject: Re: [PATCH iproute2-next v2 4/5] iprule: Add port mask support
Date: Tue, 25 Feb 2025 10:58:28 +0100
In-Reply-To: <20250225090917.499376-5-idosch@nvidia.com>
Message-ID: <878qpuibvw.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: beab6cbe-2faa-4ad4-2a87-08dd55830849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FK4rnW8FKRCB2bUHoJRzRtBCkt0YDpo5V24O0HfcSHE9BqdLHH5vy1qEhNLa?=
 =?us-ascii?Q?iaaeOwKbxwKZPyaijp87Zh09cHledeav/XdxXeVzL/jQP2sAa36qZ67XExdb?=
 =?us-ascii?Q?RPRDRWSJukQGf5cAONe+GS7WJlZ1eJXXhlq1S1wNb2IL4Dm7Up/nhLb4u2t3?=
 =?us-ascii?Q?1J6YYCjVkPLnMa+tmJlR45Q8OoUszafiJHp53qGMam5DJaT1ZTYQaXuJNc9W?=
 =?us-ascii?Q?VRy466r6QbM+gkxeDzp1rBar4XZT1DzHFgVzqEHfV/dE4ftXPoAGFpuuNJws?=
 =?us-ascii?Q?yBp0uZ1gF6Fma1RnoGudogMp5SLcOf3Ij3W+2KVXK+F4Rur8G851JAPhK7uU?=
 =?us-ascii?Q?NLZX4YC4bbfxH0BbMeMTfz+hHUMcDm4X/4qytexjf2tN7Tvs+r3F7PwmO8Im?=
 =?us-ascii?Q?k0l8PbxnSb9IMefs2tlh5bqYapIn3cZqAzQmOkh/Hth1LSP469UIJvFuB78Z?=
 =?us-ascii?Q?g+2eDPU/JbX7sewQ7B6HlV4uIAljUEG5hN0XMZT8R4D1xpgIP1CP1cXlUVJo?=
 =?us-ascii?Q?NLCK+jMpqeZECcMIcLAQpIcBKtL0v2NYQPVE6a44KwCXW9FcTpp94xIl3TKH?=
 =?us-ascii?Q?7HiiyWtohdRLK9u4y7uGHt6n+ersx5nbSVQ7T37xSwRy8jzamlv1oUaT3OUu?=
 =?us-ascii?Q?ZMsRE/0S3YiVtjPIC8AphK28ulJ3Xd1gfWlTjC2WZ/dnJ+iZHredEG5L54Ej?=
 =?us-ascii?Q?RH0oZmZEXmHBqrMC4M1YbuG2zTGyIhElZnt4oWcrIOrYQp2xI4rEXLl0cuaz?=
 =?us-ascii?Q?vxxq8cpElNbK2nNgB8iJ/1EoDnb3+7WjKuimacXCWEjCHh20DZxZZYE+ebxx?=
 =?us-ascii?Q?IboTePe6kZwPIQuF+91nXwJ5QkD2Pe5ysp463SoLZ2BVnGcaiVjhA4A6zXui?=
 =?us-ascii?Q?GtN2XN+774H4qYnPuQnxGUkGlap+RzMUWNZEuI70aiW9BUnnsfAIRN7uTfXY?=
 =?us-ascii?Q?LjlAAfwxMinHqKeuNSrMQsU2B8oDnegv0fIHMDQ0Hiu0ClxHOkaGEpPSWIbb?=
 =?us-ascii?Q?BkfqUyWVO/A43q3Q3NbH4L5tLY8lrDI/J0ty1fDNferecn3gUl0z4gLL76Og?=
 =?us-ascii?Q?/zW6gFpgcTUG9uxRjVNyyGYP76FyA109vvHlOLpJJ3HH3iBY+ckOG1p3GdGn?=
 =?us-ascii?Q?54x1MKGhSySAVTBvMFlpQm93ybOwSmrTlgHSR69yGkYOKYsglCtO7/Zh68Pa?=
 =?us-ascii?Q?xzjp3B2etmthWhuAYVCh03fgw4U4bsCq2F5qUirSbLlnQvHFBWQJwpZSossS?=
 =?us-ascii?Q?fbEIhuC9I69SE0vJ3LpfEoLO3tNGKda2nBF4bUqQDqe7tkOcu3GtqxJT+KEK?=
 =?us-ascii?Q?cwT769rJyVAGVVODGULseaMXGPdtd3E3s7KIBgh8NLBcMcttdleZioBtJLJk?=
 =?us-ascii?Q?ZAx2b/GrBQxI7Gr7w7XaVK3pqfRFqi7fC1bZdUU2+CePQW9mGX5c0LUjdSpP?=
 =?us-ascii?Q?W+z0G681w9Nrm1fefeJeREziSFG72XsADMIf2sExr0hg0lrChjDrwhOoPzbP?=
 =?us-ascii?Q?40aWaUbFdQqSspQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 09:59:02.3005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beab6cbe-2faa-4ad4-2a87-08dd55830849
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685


Ido Schimmel <idosch@nvidia.com> writes:

> Add port mask support, allowing users to specify a source or destination
> port with an optional mask. Example:
>
>  # ip rule add sport 80 table 100
>  # ip rule add sport 90/0xffff table 200
>  # ip rule add dport 1000-2000 table 300
>  # ip rule add sport 0x123/0xfff table 400
>  # ip rule add dport 0x4/0xff table 500
>  # ip rule add dport 0x8/0xf table 600
>  # ip rule del dport 0x8/0xf table 600
>
> In non-JSON output, the mask is not printed in case of exact match:
>
>  $ ip rule show
>  0:      from all lookup local
>  32761:  from all dport 0x4/0xff lookup 500
>  32762:  from all sport 0x123/0xfff lookup 400
>  32763:  from all dport 1000-2000 lookup 300
>  32764:  from all sport 90 lookup 200
>  32765:  from all sport 80 lookup 100
>  32766:  from all lookup main
>  32767:  from all lookup default
>
> Dump can be filtered by port value and mask:
>
>  $ ip rule show sport 80
>  32765:  from all sport 80 lookup 100
>  $ ip rule show sport 90
>  32764:  from all sport 90 lookup 200
>  $ ip rule show sport 0x123/0x0fff
>  32762:  from all sport 0x123/0xfff lookup 400
>  $ ip rule show dport 4/0xff
>  32761:  from all dport 0x4/0xff lookup 500
>
> In JSON output, the port mask is printed as an hexadecimal string to be
> consistent with other masks. The port value is printed as an integer in
> order not to break existing scripts:
>
>  $ ip -j -p rule show sport 0x123/0xfff table 400
>  [ {
>          "priority": 32762,
>          "src": "all",
>          "sport": 291,
>          "sport_mask": "0xfff",
>          "table": "400"
>      } ]
>
> The mask attribute is only sent to the kernel in case of inexact match
> so that iproute2 will continue working with kernels that do not support
> the attribute.
>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

