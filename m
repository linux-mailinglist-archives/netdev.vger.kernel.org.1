Return-Path: <netdev+bounces-138499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7B79ADEFF
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2D11C21F37
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 08:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013EC1CBA03;
	Thu, 24 Oct 2024 08:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pPoBHCD+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7D31CBA11
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757863; cv=fail; b=uxGvw2RINgn9o+5Aa+e8qr54zsqN6sN3q60ktjaqTfOYyUKOodeayVa108W7uRbRXKlHTOv9+Jl+744cwmV96XPDxAhnUVVfMBj7xtjtDw3OY0nne0N0SG9+PCrs9ZYgbeIechWqN6Rfet8SRnT1lPkRCemjMbakev4bSQxVIOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757863; c=relaxed/simple;
	bh=TjJV/SIh9C0xKyIfWyuVNcycdiLo0+zcbIybzIlLu1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nVIdBgj8GBjRThXISWwMdH5ysMEPQ1l5Nfseq6f2chcTK6lEsgqiW7V3dZSrkEL9vjD9Q//b0gqB0eAoxWgMpMJjzgqvRKbX26uIJoo2hJfmtdswSD/U4Yc0O+exUBIBTjOIo8PDK7VIVWe/FbzWQ6OcMI1QHvebyDRkACW5u5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pPoBHCD+; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/txNPOffitKmNF/FGklhj1i131FsV7rfDdu/Ff3mTQ98TlCNaQIilX9mEWLuhHYQiV0zeax/neEqoQIwf0HSNQorogRPJ3ryI30ATvAonjih2pq7iaenFtRr2VjhPWKWtXGABxCzfLzX9wYQrI/bTElO49mN8xzkqROpGxcu++lwCs1ies87AtL1dQ/65iYeyYvONbLh7brK/meLvs2zaSWve70AHTf87TLkgqiW0ffawapYId4+1CvH7NuQBMqdiYDwE8uEQvF5Ri0uyGSi6Ek0y9PTp9hNkxwK8j4no9wwF+mjeFBR3rZ94uYhHU6z+cM0ELsZ01h66THkrcaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbDlagB50875inCQdgRKlUchuRtgFnFhzPLTMNgF9Sc=;
 b=dprUl+6dUlmMGzfjJ1sWfj1HI8tg/5M6vdzSDQLVBrd50U3oeY773YXKL64a4yL1+GQZB43rjCu0tArlfWJCArHSxTHVHkCmJpl9w8ulKbeGMC7HmcCuwUh4ySp6wlcYQaT65CeMdpqJhZCZkcxjjYutEywAWeYynz4YrD14ZlDQxNijzg5wUpoGFyy29ohpVawzi9/2skpi1MJWT60DAGw0Kjd60jQcMJM8toqI3cyHjiBHNMAb8upHineLncSM6V/7dIJQ5PYxsPs2drOSHeMjFVTE+nDhsclAV2dfLlLN2da9zPhY9iCtEiPDBaUpEsAHPG1XA0mTv7DRJ5kx3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=canonical.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbDlagB50875inCQdgRKlUchuRtgFnFhzPLTMNgF9Sc=;
 b=pPoBHCD+KqyNulLLk6jrmH4w8VH28cVj85jI2t9dAbTuVUQayp+6D76LXMZ3RuKMYFMg8RHOznNbrshT7gnzZIsYwbCc/GxrCIA3BehzslwYYkB0yf0JV0ALUSZIXqn7aGswU9IoLlfBiqx589KKaITIN6SOZ6gN8UL9SHrw3sZUJdilGChrxfDkRpolpGnoB0eVJdsZGYQSVGsFnyf9oxc7+pItwZytq79o8JpbA1U9n87dlTz8QOzlLTRNXIqmH3Bcoumgb0ATsUNG4OY80y5/0I5Xw4VU6micQs60mbFyEjksgy9VNWWIsn20IpSkJPHjf6b7ZwUHdxBxO+M/jA==
Received: from PH8PR02CA0007.namprd02.prod.outlook.com (2603:10b6:510:2d0::18)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 08:17:38 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::b8) by PH8PR02CA0007.outlook.office365.com
 (2603:10b6:510:2d0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Thu, 24 Oct 2024 08:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 08:17:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 01:17:23 -0700
Received: from [10.19.160.77] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 01:17:20 -0700
Message-ID: <660b6c9f-137d-4ba4-94b9-4bcccc300f8d@nvidia.com>
Date: Thu, 24 Oct 2024 16:17:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net 09/10] net/mlx5e: Don't offload internal port if filter
 device is out device
To: Frode Nordahl <frode.nordahl@canonical.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Ariel Levkovich <lariel@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed
	<saeed@kernel.org>
References: <20231012195127.129585-1-saeed@kernel.org>
 <20231012195127.129585-10-saeed@kernel.org>
 <CAKpbOAT=i2_j7uSXNwbcES04aDm64YEJa=6YD4Bdzneww4Epag@mail.gmail.com>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <CAKpbOAT=i2_j7uSXNwbcES04aDm64YEJa=6YD4Bdzneww4Epag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4b6c69-5b5f-402a-11aa-08dcf404524a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmNUKy9JWS85WWtwalQ0SHpxZWlyQ3ArT0xNVjVxcmdtSTVNQlpMT1VvM0tH?=
 =?utf-8?B?eTJnbjJZUzZsVU9Gb3NLdlgyTDltWTIzZ2ZEVTBUUHIyQ096VUp3YkszQVd0?=
 =?utf-8?B?anpQL0dXRVovdEVSVXJNN2pIVWFBZ1J5d1Z4eVY5THhtTXFBK2dLVDNEdlkx?=
 =?utf-8?B?dTdLZ2l6VGNtenIwQlkwdGpSSFhYZS8zVVRFbjh4WEFrMCtPeDNBd3Jld1ZB?=
 =?utf-8?B?RGxUdDExN251SGw3eHZ2NStwWDg1c21XRytpZk5KTERWSmFGWFhGbzN1YVJF?=
 =?utf-8?B?WXYwenEyR2I4UThqaVR1Y1lqSC94Z3grRTlDSWRiRmpxWitRdFhwYVJhQ01t?=
 =?utf-8?B?QWNZZktQSGtNOUFVWmJ0clQ0TVBncmJoTmUrbGpjc1Y2OWExZjBoSDU1VWZ1?=
 =?utf-8?B?clNqUEdETHp0ZFdSRmUzRFFPK3BrUzJWa0xvVTNvbEVTalVvVWt6MDJJUjQv?=
 =?utf-8?B?S2VaTTd0RldNZU0xbWphUHRDeVhPTmhkeTZ1Y0w1bzFtL20zYUhCbGpkVktH?=
 =?utf-8?B?TVpJbDk2dUtINXh6TUdueGhmdXhnaVBKbk04RU1Nakp4Tzh0ajI5SjJSYmNT?=
 =?utf-8?B?OC9oUVpkaVk3bDlJak1WU1MzeXZkUDZjNkpNdzcyWHgvSi9VVXZ2SWRFQUFE?=
 =?utf-8?B?TFpjMkhZVW5FQVVXUmg1amQxbWIvbzFkblJ2VTYzeExmb09zL3hudXZKcmh1?=
 =?utf-8?B?ZWFxcFNPVlExbVZlSmJDSzZTZmM1c25oUkhLTmpqbGxndTVtS2xKRXdkWURT?=
 =?utf-8?B?YVNzRzh2WWF3ZmZJNCtFMlVUeVdITVBPWXdGdTRkVUpPamY4WFlzUEpUcGFP?=
 =?utf-8?B?b2xGbmhMOHFhMG1POUFkaXFDOVVpSkdIMmJOSno5akNVQlkxNis5cEhqdlNO?=
 =?utf-8?B?M2hnRUdGU3ZENFlYVnZmeGtrME1wdmFyZk83b2Q1ZmN2cjYxazJnTzFlUS9R?=
 =?utf-8?B?V2E1ZUcxaUpRRUZwR0xCY3orRHFjMWJxckMyOTh3aGFOdEU4NGo2ZUJ5Y3hY?=
 =?utf-8?B?RHJZdStFeGJJRHBjWTRwWDBHcng2ZEErSFZFQks0THduN0EzSDlzd2NXUkVO?=
 =?utf-8?B?Qm1qVnNGVDJmNDROSE82QkRQYUhlbzRqaXI1OTgrZUJOamJhcjZGMHlaTFQ2?=
 =?utf-8?B?YXBYUDhIb0phWjNNZC9pd3k1eS81RzRvbUVRWDV3cWtLS253Q1RrdUhjd2pH?=
 =?utf-8?B?SW0wRmdTMHhSNWgzMUsyYlBQSTQ4Vk12VjdKR2ExclVKN3pKZ29NQnVUcE5X?=
 =?utf-8?B?Q0JKNk9FM1l1a1RkcmVNWSs5c0N1ZWRYVlBKemVCZ1BhVmNUV0sxOEtNZkc5?=
 =?utf-8?B?ZXQxMFBRQXgyWUljdXhmaHk2ZkhnVW5ldEMyUFVEQlJyRHMvQStLbFdubzN2?=
 =?utf-8?B?L2ROR0lKdFYxK1h4cUNXemFGQTJiSFkyQ2tkUEZKbUZLOHhlQWZqNThrUzlo?=
 =?utf-8?B?a2pvNGNlbmlZaU5TWWZlb2tSUXVYOElHQkNaUTJkOWh0Tnh0dFgrZ29la3oz?=
 =?utf-8?B?RFhWenBvcm9iMUV3YmxBcEZpSUxsNTJ0Q1JydWxFckQwc0EwVUhOU2I0VWxC?=
 =?utf-8?B?NGFPZTdMRC9Ub3kzaFNNdzBzeEZiLzBHYkh2REJHRWlKb2t3VWdBZzRhNGpk?=
 =?utf-8?B?djRvNXU0dzF0czR0NEptbHFvR0haZG1EVitGM1ZxSk1vSVFiQzFWWldWdUNS?=
 =?utf-8?B?TVhEZmtyaHhiRG5IS29MZ0IzMVF0UFRqMWIyMHhoc2hCcnJZY2FmMisvK1Rt?=
 =?utf-8?B?VXQvSzR0Y0ZTbkVaclFXR3BsTGpjLzFFbDRGcE5JNDgrdFoyTStkYVpRRmZ1?=
 =?utf-8?B?M3JxTEV3OXZIbldiQVRBanA1WjVNT3FlcnJXdkZvbVA3Z0lUSC9oQ2hDcHpv?=
 =?utf-8?B?Nm5oR2JtUGUvVTVTTTB1Vk84T1d1UmRzTGNYaVlubEZ1U0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 08:17:37.6306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4b6c69-5b5f-402a-11aa-08dcf404524a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774



On 10/23/2024 5:32 PM, Frode Nordahl wrote:
> On Thu, Oct 12, 2023 at 9:53 PM Saeed Mahameed <saeed@kernel.org> wrote:
>>
>> From: Jianbo Liu <jianbol@nvidia.com>
>>
>> In the cited commit, if the routing device is ovs internal port, the
>> out device is set to uplink, and packets go out after encapsulation.
>>
>> If filter device is uplink, it can trigger the following syndrome:
>> mlx5_core 0000:08:00.0: mlx5_cmd_out_err:803:(pid 3966): SET_FLOW_TABLE_ENTRY(0x936) op_mod(0x0) failed, status bad parameter(0x3), syndrome (0xcdb051), err(-22)
>>
>> Fix this issue by not offloading internal port if filter device is out
>> device. In this case, packets are not forwarded to the root table to
>> be processed, the termination table is used instead to forward them
>> from uplink to uplink.
> 
> This patch breaks forwarding for in production use cases with hardware
> offload enabled. In said environments, we do not see the above
> mentioned syndrome, so it appears the logic change in this patch hits
> too wide.
> 

Thank you for the report. We'll send fix or maybe revert later.

Jianbo

> I do not know the details and inner workings of the constructs
> outlined above, can you explain how this is intended to work to help
> our understanding of how to approach a fix to this?
> 
> Flow steering dumps from a system showing broken and working behavior
> (same kernel with this patch reverted) have been attached to
> https://launchpad.net/bugs/2085018.
> 

