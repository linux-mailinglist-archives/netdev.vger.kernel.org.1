Return-Path: <netdev+bounces-142239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9319BDF6A
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 08:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8213F1C21CEA
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 07:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03331CC14B;
	Wed,  6 Nov 2024 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vg6SJW+Y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490B9192580
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878127; cv=fail; b=uxRauuQbAKPR4/PMj+ZXWnIevENOoGODUqivHlGqksRJhyf7CWvULDFFOeKjKiBfwU13Yt85xSWm+kTZ/vAwXIZPpsv8tmr5iEVqR/b+M3gxJKEC1aUyHjeHz9gOEXPdGf/Ou/C1RgD0oxwvei2s7mYGqjdqXGFZz4Ewmzhi6A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878127; c=relaxed/simple;
	bh=AIFeoi6cd26NIVjZXy4Xn5Qq+E4f1O1UpDkAEVcLA+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pqvFPiyRkanstLxeQJPIVtkNPh3jHoevtbsm4V+s1nogPtXXgUy8nN3RMbbe9XM/+10GnDIOusWll+z32TVSndJxiIpgsJcxV08KtHmxAbt9mIMntDszjdPCCAPQPelBiz1yJvGLIuUPCCfR0oPLt8LIdmVgy8+mcagmmOE6rTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vg6SJW+Y; arc=fail smtp.client-ip=40.107.95.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9OOIUE8eoYeX8/YFZ7ZCbOihZzvd3FwsAfMUACDzOno4uJfYx+ywyEg8pzbV3h+kNjKCPbpXsuxqq9Hi+iMsuI4C2zWpv2p7g/hEtZIgX65sj1Nu8KjuG1FR0mJrbLROq+1jVldGZrDvGXSHyYJ1E8d7KBwEyTuOjVy9bYL30cNV2ey5EshOJ1RElt97xLh3gXXd41bkOYk8umlDYnIa1BVhBvbKfG4X5T9MmWa0sV0uIW4AfXNDeZofy480xgASxFIEoCgCdiENSF9k/+3kmwZgqunvuxrhs7SgdiehMPmpeMKuq8JdFmAQBLfBorHWMQouLOsH5WCxlqAsRmyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvAvVTPXskcUIOkggQAiabJ3tynfZzJl38BYgTnYqXY=;
 b=Lavmw1pipHQPAdj1YTjqmPgUg5ZEa20VqC7gSVQ8upNMRcFD0lRjQB3PQ8eQ98qZEnuWrybGu0NBPZGjDSDs6OwWFCh3QoWlE8SozEWUQmIpGFHpmb400vrIS8969arcWrueCkoXyBw0Bnk+hmqAouJufw9EF7fM09XO8ETJUEmBtbOOLCL85FWqyFpEDg4IhtpEda+Lo0hvH/IyeWEyVJkMloOSPyYCoBjANFTavuXOtrKKx71uok3Rbqg8i7xRn6Sitvf5CRe5VmBMYLiRfsrlPAmV9RwsMMJmPx6W7M+Z4BwC5H7VhZhPIcQEGCH2sFK1+4q5+VkoSmAM2RBzjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=canonical.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvAvVTPXskcUIOkggQAiabJ3tynfZzJl38BYgTnYqXY=;
 b=Vg6SJW+YZxP0wJRoPWqT0/Lk7pgcqdF62panaJorn+t+Tnq4IHOyYZI3pNzeWAzzVMAfaJ+mTROSMYUsg7QQrFZWLtLBqMP3W2PpucP394ZYgV9FZRaRMKz39ENFdJRDLOy9Y1up0RDTqAjzOJfERzoOMNPaBIKBRP+0z07Eh0l4S9g6QDUOiw29ZSjduADWCDXIk3mJ8MKhIAvikVa208JWfsw5001lxJg2N78AtIDIR2qFeIMVjlSutXWk4iSOE5dT1RCftUPjNauo8fHx81sR3cxhoszblu6GJyMfJBfe71TEfFU0jLGVCLyvrMlN9odMn5J+w4eoTu4m52lPww==
Received: from MW4PR03CA0136.namprd03.prod.outlook.com (2603:10b6:303:8c::21)
 by CH3PR12MB9123.namprd12.prod.outlook.com (2603:10b6:610:1a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 07:28:43 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::76) by MW4PR03CA0136.outlook.office365.com
 (2603:10b6:303:8c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Wed, 6 Nov 2024 07:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 07:28:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 23:28:26 -0800
Received: from [10.19.161.132] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 5 Nov 2024
 23:28:22 -0800
Message-ID: <2b64b3d5-3cce-46b3-81e8-f914a1f18d2c@nvidia.com>
Date: Wed, 6 Nov 2024 15:28:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net 09/10] net/mlx5e: Don't offload internal port if filter
 device is out device
To: Gerald Yang <gerald.yang@canonical.com>, Frode Nordahl
	<frode.nordahl@canonical.com>, Saeed Mahameed <saeedm@nvidia.com>, "Ariel
 Levkovich" <lariel@nvidia.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Saeed Mahameed <saeed@kernel.org>, Jay Vosburgh
	<jay.vosburgh@canonical.com>
References: <660b6c9f-137d-4ba4-94b9-4bcccc300f8d@nvidia.com>
 <20241106071727.466252-1-gerald.yang@canonical.com>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <20241106071727.466252-1-gerald.yang@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|CH3PR12MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb45717-e234-4e0b-60b5-08dcfe34a460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTZYd213UHE3bmdzbWlJR1JYdnpHV00rSmVSUW5GMTV2WjVYcjk1SW9TeXpE?=
 =?utf-8?B?cGdnT2EydzlOMkRlamQ3YkViRnRSOGQ1dmxIS2dpbEFpZzdzZEpDMFYyTHU5?=
 =?utf-8?B?M2xMR2VaTXhoUllKeDFWSVVzL2xDc2loMGlXTFp2U2RrRmtIVEcxRUwvRGQ5?=
 =?utf-8?B?MnRhSTlBNXdqUGJoTXBpMndhNVRXQXZDRzBaQVN3dnNEWGhjc1hNZFJUdktl?=
 =?utf-8?B?TGV4d1MwV0p0WEdBbEZDT2VhTWF1K0gvU1dJZ0pReUdGZWluVWFmakJoNjRr?=
 =?utf-8?B?ZmJLMHVFQTJyWFVIQ3F0Wk44cTN3anh6cjg3cDJkRHJWM2paeWpIbmsxa0VI?=
 =?utf-8?B?OTlUelhFZmc3YUltWGR0bFl3U0ZpRkJZUEZVWkYvaGRmRUFLSDhXOG54OWYw?=
 =?utf-8?B?Nlo0RHNodTFtMFRGTnpPT2lqY0FEdUFtbkFXZ1RDdFpwMWk1MktFSW1wTVFh?=
 =?utf-8?B?VTRUYWR0b21RZGsyTEUrU3pjdTA3WkttS0JxL2FlSEZaTEM3dDN4SlE5bFB6?=
 =?utf-8?B?dU9wdndHQVo3YytYWVAzOE12cnZUeWtNQmpLM3lwSEkrRjRRUG5iTHNGM2FY?=
 =?utf-8?B?MENnMy94MnJYbDdZUDRGOEVhRnIyNGlFNDh4Y3kwOFBwUnljN1doUWVJTjBJ?=
 =?utf-8?B?VFcvTUNjeXdGaGNzZDl5alhxNEZVcnJlSFdBc3FSbXNiN2IrcDlmM3M0WFF4?=
 =?utf-8?B?TEpnc1NXOHV4eHBkZ3lYU0NiYzg1Wlo2dllvY05YZC9TMXRNMkFpMFpTUmdx?=
 =?utf-8?B?cUpxZGhodHJKOEd6WWlEVWg0eWNzTFZVRGlNWjhKYmhyZDU2R05rUmRLL1lq?=
 =?utf-8?B?WDZyMitYblhXSFhzOEVmMzNzdHRRcHlhUDRZNjVvbXZNQkhhQkw1Qk1CSVRo?=
 =?utf-8?B?T0t3K1Q3N1ViMm9KVFBRYzFtSm04cURRTThzYmFBTE5kV2JEaHFOVit6TG1h?=
 =?utf-8?B?RUI5SmxJVmwyMktLWHVsOXRML0hRQklTNnczZE0vc3lYMVJYUkpZNHFCd05K?=
 =?utf-8?B?TnlNbkZZb0ZTeGpIYWpiRlBKZ1drcmRzaDhmaHJLY1pncktJMWJRckRzY2NE?=
 =?utf-8?B?VDgyT3Z4a2pwUEZwdkNtd2hOeGYxbzlQaTRoVWkxY0xVN0ZsMHljdUNZVnNk?=
 =?utf-8?B?SVY5OXc5QzY4Q2pCRGpkU0doZFdEQ3gyRUZUNnR2WFZsYXlWVFYrdzE3a1VO?=
 =?utf-8?B?bkVRVXZuTjFYakE3aWZqbm8rQUxUSWNMSGczb0xYcUdFVE55c2N4VlZEeXh0?=
 =?utf-8?B?ZmVIaU5xQ2tBcHlaTkROcStzVEhYcVd3WmtWQ0dyWjZYb2s5TEdyZkNJMjVm?=
 =?utf-8?B?a21rSFd5Um9paSt4eERxbEdGeWs4LzhaaFIzZEVTYnd4Rkp2Q1NFbnhWazUv?=
 =?utf-8?B?M2FIL3h0QkpLVGEzeXNhc0RtM1pxYWxrNFZLaFNxODdCcTBNZnlDSkRSYzFT?=
 =?utf-8?B?dFhjcVJrZVR4VTQ5TW1abG9tY1VRN3F3SlVUK3R5YTRsQ3UwRGRPcUtlR3pX?=
 =?utf-8?B?SFlMRmJPWkk5ZHJWVTU2WVRzWll2L1VhV0s3WHNWUHNCQ0lsbm1FRGJIYklS?=
 =?utf-8?B?YnZmU3Y4aWF0NzRYUytwdk53UHRVV01xRGNNUGl4Y25ZWDluTFRmNEpxNUFi?=
 =?utf-8?B?cFE4QXlYV2lyRmRkMnBWbFVLWEZnV2JPbFhEQkVRa3ptL0h3Nmp0SUwydEJx?=
 =?utf-8?B?M3J3UHBYZkVIZXdhd1dlRHY0QzBNamQ3VThJK1k4dGFsY0dDc293RDdodzZk?=
 =?utf-8?B?OUFETmtScVZnOHVFZkdCWk1zY2RzcEtvaVVidTA2TXFmcjc4ZTRYUmx0c08w?=
 =?utf-8?B?cUU5amg4aER0VkJkdzdVZ0pEbHVzMk5YMlZ5M2toTkliRHJaUlVoRHE1RVlT?=
 =?utf-8?B?U0ZEVitNekRObXlRT252KzBEMkNmcFZJcnpLc3NBOUN0dXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 07:28:42.7895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb45717-e234-4e0b-60b5-08dcfe34a460
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9123



On 11/6/2024 3:17 PM, Gerald Yang wrote:
>>>> From: Jianbo Liu <jianbol@nvidia.com>
>>>>
>>>> In the cited commit, if the routing device is ovs internal port, the
>>>> out device is set to uplink, and packets go out after encapsulation.
>>>>
>>>> If filter device is uplink, it can trigger the following syndrome:
>>>> mlx5_core 0000:08:00.0: mlx5_cmd_out_err:803:(pid 3966): SET_FLOW_TABLE_ENTRY(0x936) op_mod(0x0) failed, status bad parameter(0x3), syndrome (0xcdb051), err(-22)
>>>>
>>>> Fix this issue by not offloading internal port if filter device is out
>>>> device. In this case, packets are not forwarded to the root table to
>>>> be processed, the termination table is used instead to forward them
>>>> from uplink to uplink.
>>>
>>> This patch breaks forwarding for in production use cases with hardware
>>> offload enabled. In said environments, we do not see the above
>>> mentioned syndrome, so it appears the logic change in this patch hits
>>> too wide.
>>>
>>
>> Thank you for the report. We'll send fix or maybe revert later.
>>
>> Jianbo
> 
> Hi Jianbo,
> 
> Thanks for checking this, since this issue affects our production environment,
> is it possible to revert this commit first, if it would take some time to fix it?
> 

Hi Gerald,

I already sent the fix to Frode last week. Have you tested it?
Better to use the fix instead of reverting it, right?

Thanks!
Jianbo

> Thanks,
> Gerald
> 


