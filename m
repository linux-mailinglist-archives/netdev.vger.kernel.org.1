Return-Path: <netdev+bounces-169047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6B1A4249A
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 15:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1737F4214E7
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8402561B4;
	Mon, 24 Feb 2025 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a5+3zmQl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F50619C54F
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408498; cv=fail; b=h9HMH0EEG/v6rNCVKTH6XkIq3Bzr6VD10hkloQ6vEvxbom74DeZ9NWSTIdz3c0r7ZsepcysrTMryObdojoPkUr11/AMnOPElwIJ2BN3rw5Y1owTaJ6LVTNnDcHccwtZvYe5IZrqYeh/PpZ7h9UOqOVtowVSyVvR01zKU+b2KbE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408498; c=relaxed/simple;
	bh=qFQRz92gIiDmRskxjVwxDWuZNhnXqVwb0keNl5pd+kQ=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Y4720+e/1uL8wsFXwqP9GrVixXKLjPmbUq/3xbYWaEelXkOtsGo673g95BxYbu9VdXF+FkyxPmDu1tdnaP7p4QoEichJWG0nz65IagUHJp/SFVEna5EfJIrC8KKAQyWrWW+34zJnqiWdmLnlll27X0/Xj6ZVZ/Ayill6ubRrY1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a5+3zmQl; arc=fail smtp.client-ip=40.107.102.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUlpnsjE1gsCpZmDZGMNOXQHI+YqR3eLYDovJna2R6pAgNn2IjTFeFJSbIEXEHB6Enyjw2ffPBIGZWmsvVh4+Ryrk+WL3AziYgOv2jL5QzUJW0ecZiA3SsMajg0ze+9xlFyo34NVCmf9r4/MWPXG/SCvJ7xwmWRx7uzpidW1VsboDh26U4LmbJNN07SKXNE6CnVa39+m5CmNuSy7x1anfh2JPK+JFLpZGNIQEf2VEJCf1yGQo1pxteaIQIjZGUo8VEEd0wOxGp3/r5GLdt9yhpujbEdivLOLSoGvxAsqwkonrWqF41+/PL2uxZ1Dos1hHNXnFf7W3jA8RPtu9FGBlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBmWsP/qj0Sk84DgmKEy+czUnqIHcNG8+qmPZmBFkAs=;
 b=hERsxLMIV5Iv3qm/xlY5KprFZyenuPGEbJPWfjx+mFAxIRxlGTab0sWjDgpu9ZDKJbl+FItw9tirfg0xhnREspvIOh9d/Kz6lnYvjMZa8vzd4IYuuockz5+dT4ue6NT27Cx2u6DtSlWP5KXcGjzbCcwA9A5py7MZiuv0Dbw0eAXCU5mFHBWaq9gDkVDX6Y3VRgFbzvc1pU3LruzcxNH6keMr7PIo3TfhEPbEtM4N6zJopMyBAO9GaOKiEXoJ+NEeNtqUmVg4X2flPTkx2k5P5PhNYG7v61zoi3a3o6wPeEQzs0BEwJlVh+bxzoUzPGHjmXpiTiSLBZ2y4Z+MwXRs2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBmWsP/qj0Sk84DgmKEy+czUnqIHcNG8+qmPZmBFkAs=;
 b=a5+3zmQlOkWJTN0Kp4njV+WU2C1X5ZH2fn1NckKe5l0DN/KR9S91DWbrkj+lMSouVNhZnaYAfiQAKml01bHnr1oJ/qxrSDhAP4qCA1YnDGK+3+KTO639Bl4EmUfk7EXCuQaa9OYdUSacUp3xkAUSm0rchz1fERZMYIy+o5lGLSnXSHvf/ihcUxXE3QHWSiHwWU3DS2rOuWjz58TRNrXJrMuQI8HDoqAocdwjThFYig8akmCdORYas5FA1icfoFTD06XFoayBATd981XSs2w7cVO7G69JNN79lYo3V3r8gILC45cnJwcTc4feD/iNWmBirSwmFBt2whDlNNQKyTd1EA==
Received: from BYAPR07CA0022.namprd07.prod.outlook.com (2603:10b6:a02:bc::35)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 14:48:10 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:a02:bc:cafe::ed) by BYAPR07CA0022.outlook.office365.com
 (2603:10b6:a02:bc::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 14:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Mon, 24 Feb 2025 14:48:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Feb
 2025 06:47:54 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Feb
 2025 06:47:51 -0800
References: <20250224065241.236141-1-idosch@nvidia.com>
 <20250224065241.236141-4-idosch@nvidia.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
CC: <netdev@vger.kernel.org>, <stephen@networkplumber.org>,
	<dsahern@gmail.com>, <gnault@redhat.com>, <petrm@nvidia.com>
Subject: Re: [PATCH iproute2-next 3/5] iprule: Allow specifying ports in
 hexadecimal notation
Date: Mon, 24 Feb 2025 15:47:43 +0100
In-Reply-To: <20250224065241.236141-4-idosch@nvidia.com>
Message-ID: <87frk3jt64.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: aef21cbd-b0cf-49a0-3658-08dd54e241a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q5PPe8sVQ/nuhmBdtWaE+yDAvhnReYnJkVJN4oJzLt9N0ooQaMHtfVooEtao?=
 =?us-ascii?Q?0dzpRJVAKD8g0ETeRq6sWdDuYlhH5oD3l7JgeSxOb/HqABlxRcvGI5s7Jkgw?=
 =?us-ascii?Q?Uz5jdubwZdV+pvrScTLw3TxAWcWmwWltktZDvCGjJgyNnoeaYPFDb+vGENzk?=
 =?us-ascii?Q?NeguQzNJHkFCFcjxOjFqoRSA3wa5msdsCoD6z79u7XlvQHzqALokmVD8xvEP?=
 =?us-ascii?Q?i4nwLzzoiC1YvoARVdggjtYnLgw0rmzHloOIE62p08F6LZgOYS9mnEDwDhK9?=
 =?us-ascii?Q?uRvdIqKT+dxo46A1qEr6wdhr8ZUpiuEi0H91t9GPu3YAPsAps4+/c/ulbgU2?=
 =?us-ascii?Q?ZdOLYf9xgU+1fEmrTzUx5eLa+8iZLqqgpOd7KbVAAznqpYyyFQogh61mjuzL?=
 =?us-ascii?Q?em2aXRK0THSzZv4YglSnMkren6u2PnmpitPuvVs2ePq8RgvdjycJxUZxEhHq?=
 =?us-ascii?Q?Hn/7td2ITFGnVyYc8/qRJWRgOrBvPO2D9ODpTvKOfdH7GcvzU13uDRPFzpew?=
 =?us-ascii?Q?798JkkI/g80UZ727edtArAz2+jVs5zUoFfbIBvC7YoE27EkmkRCweTGb/Eem?=
 =?us-ascii?Q?yLMZdQDyb/wzE6zhgCo/xI+5SQvGic7k/jjyldhgkGjn4QD1FnxmDZW+62uv?=
 =?us-ascii?Q?SsRbLrFPRN7dT9bXRN5aRZXar4HgRgS69Uo5zUBURgownEfg40PxV2oNtLJp?=
 =?us-ascii?Q?ZZlhjp8Gw3RC2RIz/KehWgRiUjckHWQsWxx8W+hTyxAqwh6chPyzfmK6F3zj?=
 =?us-ascii?Q?rvZRN1rmX2PCPefJZ4hDLc8F29qYkX1fhzPnrlb4o3eHgfOLpnE8nBdSsgU4?=
 =?us-ascii?Q?KIsJMyOzex/qyZ870ZoIv3Ne4GwHK4soo3uQCFUAEpfaeObT0Fv1yoCugjpJ?=
 =?us-ascii?Q?1Hnn8nT1PDy6bbo7QSoxktkrE/Mo5DNoKdSRoe4SKLV8lJ4wuHCEPxR7vx+R?=
 =?us-ascii?Q?IT5dkKThIpNmOak0ngHtknSMOVNd43QF54ANRZvz/8shCHwGXJc6tMKCYOHK?=
 =?us-ascii?Q?0gRcu6RQ21/LY5xlOB8HWoMaUVcqdFuzwsyOX5ttgwJJp3mDs0/slvw7n2cU?=
 =?us-ascii?Q?R4d2vFdLwV50FiyJB1cadg5Cddee32bz+Nfu2lhbhhXB8brNGGvnOxUBZIb7?=
 =?us-ascii?Q?vicJq3+nlYS1BO5hnqYbhawzKzVZKQHMWpS3vFLtNnYguLaShtnCdg49IgmF?=
 =?us-ascii?Q?JJdyBTdL2beMtvELoE61BZ3CKsJ/0nHH3nnkHrcZ1OeX27lRL0+tH6yyUfyA?=
 =?us-ascii?Q?joTTHX7tNGX08laUQ/6c0+7ZqxHR06aPDlrcJCYG7VhSm76FNxBbXjqe38Ub?=
 =?us-ascii?Q?dfey0g2Tq8qToZvLWwReHenaExMGjL/RpDCT91fNznDZa+oNUFCmTrYgAvsB?=
 =?us-ascii?Q?NkX3N8dgZQU0pVK2XoBTdJWq5AYeqqJFvQSFyl4yiwGqayF9hHJkQ1xM4Ngx?=
 =?us-ascii?Q?JFOtaySJ2lWHD4QNoZtgzOm/iVexgFjGoJzsz83Dcrc9SniFJQI0Wf3T7gsi?=
 =?us-ascii?Q?ObeT9Q6sGmteOF4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 14:48:09.5670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aef21cbd-b0cf-49a0-3658-08dd54e241a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473


Ido Schimmel <idosch@nvidia.com> writes:

> This will be useful when enabling port masks in the next patch.
>
> Before:
>
>  # ip rule add sport 0x1 table 100
>  Invalid "sport"
>
> After:
>
>  # ip rule add sport 0x1 table 100
>  $ ip rule show sport 0x1
>  32765:  from all sport 1 lookup 100
>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

