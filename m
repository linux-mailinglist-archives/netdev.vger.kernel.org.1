Return-Path: <netdev+bounces-156234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C5AA05AD3
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F703A6E5C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 11:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D1F1FA830;
	Wed,  8 Jan 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KSR35UVI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC86E1FA25F
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337386; cv=fail; b=OjHh8yMlPqLzGEoJ9J/+yvCi5xv9uYAV/lu7RRQW35w3515bJky3M+CVKc2TcgFX4iPXCG6N0IzPoVzB0l8Lbzpng3cm9pNl7U/g/l8lsv7KRJdus8qddh2My3T0OJoUnmdFlx08+O18qzI1a5wz/rsDSDME5x7TqEoWhw4UfQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337386; c=relaxed/simple;
	bh=ie4jdXOMhLwTA1s9bBY7nVB+NS6HDsc8gelSFDhiHOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ixj/GjITbrMSWQ1HXXtfOonoUM76alja/7fJcsvtAeRPTKFVic7Y0NEoA3Yo5N0xqLOl3Z9RchEJ22Ft7qWqvfXettyBf5HDOjRIUf2i2Ou7c4HwA1flpbDLaWfHRzyMHF/Th8qV8ilTNN61MyQ6TmuUsBhW5Y45SYIFjdT+Jv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KSR35UVI; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYk48fRINg/z68415qc1JBlptz2VFH48NkpRKtXPz8kPM8R+iNjTAeju9gDQQPrUM/EyYkWvHPCZE3niZQw3dx8G5VSBAfApbBrYV4njWY+u86+vY7NfmDcGmyXl7KPjWlF/2DE8AzFig/1v1X4N/urtLRu+MCF7x3CiEBHRW0ouwqe/QLPvaN2i+Wh1kYltVaZhHTxfAOIuld68lTwvZmhwYMGwwv/sWA44SJUVqMXMwzV1xB6fcD7an61RIT9mIjIAmy+YFPzH1dzfNizmDUL+/UKXWOWyGKLKEB8FqyDPaR+KP4bEzEZ+8Q7X8+ZFULQs7rCyih2w84K6j6dPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2h56gka5P8WKNyMHMKTqR9XSPzqGs4/tZ7AJsA9Dvk=;
 b=CuE8kqfcfTSgMpo/g6ohdN0rpMUT3RQ2wkZ9pmLSuCVsa43aFQYNrgWfjGVAOFfDYcihbgqwirQnG9w/dTnwKLHXGvA7yzcMF4zSxEuUs2RNWFG8egB6FQmP/cyjvkgtDmJ6Q7fg+Iq5pazz9v8H0eCTaANGXVF1iJ9O4f2kKBq0qMVL+SFy8BtaQoLvc2n1GBekLc+4lV1KrTj0PG9I9P4fuL7jXnnwofWeD/sfH6uUkf3nfBVZw5DsDZMTqARisb2HpFMcYASSSKluFSREPPDGffBKdUUuX8uBup9CtBGv8o2YOJIPmLEA3MifFkIoW7Ksm8hChHXkZBJlyfh8bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2h56gka5P8WKNyMHMKTqR9XSPzqGs4/tZ7AJsA9Dvk=;
 b=KSR35UVIgAmjapc/z4PAfsnqazL1yo4yS1Hsy8JWHR+M+J6JZGbMU/QAQrPEjCGJqF5eC3RPO7j6IMAB3CmZ+KdfO/a6X2asiwonCVEhYsxM1qM74/tLqh4KMFzBPc+COjABy243TeDIJ/WPyYiJjeYf0a6fzNv/APidEreXw4AgwJ1/TVUQ/Urf7thXqm3tFLlJIhd2EYtDfwMLNQkxdHmxh+w0BwZbhibdFqQBmZEUbineDpiXzh/mOARD+sOyawkHlMfpIkho9MIMc4UnFRbp7swuJsHSEzi+XSrxutMUP5wZ8rwWPm5uGNUjq36PzHk1tQENnt8kO6GRbTDmPg==
Received: from BN9PR03CA0466.namprd03.prod.outlook.com (2603:10b6:408:139::21)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 11:56:16 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::3a) by BN9PR03CA0466.outlook.office365.com
 (2603:10b6:408:139::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Wed,
 8 Jan 2025 11:56:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 11:56:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 Jan 2025
 03:56:00 -0800
Received: from [172.27.19.172] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 Jan 2025
 03:55:56 -0800
Message-ID: <49e12978-c00b-4937-bc89-424ec1ed4960@nvidia.com>
Date: Wed, 8 Jan 2025 13:55:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/13] net/mlx5: fs, add HWS actions pool
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Tariq Toukan
	<tariqt@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>
References: <20250107060708.1610882-1-tariqt@nvidia.com>
 <20250107060708.1610882-5-tariqt@nvidia.com>
 <a3960405-b6a1-42a5-8904-b7f13cbfcf98@intel.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <a3960405-b6a1-42a5-8904-b7f13cbfcf98@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 7add6e84-b5eb-4235-6c23-08dd2fdb7547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVIzVTNpeURIUkRMVFlESmhXNTJSRW9LNmxFZER4NWRVellLT2ViUGJyckdt?=
 =?utf-8?B?bFJ2dGg0eHhiK1MxR3dJeHRydldwTHIrSUdQeHlkZldDZHhrajY3VG9Sa2xu?=
 =?utf-8?B?LzBpSlB3R01mSE96RXY5WXNxZnMzSGRjMlNrekJYQ2ZpN3hDeTBYOFE2RmpL?=
 =?utf-8?B?R1lkV2J3RXViYWF6eGZ1ZldWaWFpZE16dVBEVytsbjhsVllPL3Z2SEYrTHZ6?=
 =?utf-8?B?RW1LS3gxcFNMKy95WEVHaTV0VjlxVFNGdHpjRW1nYjdDanNFTnlyQjkyeDN3?=
 =?utf-8?B?a3ZUVE42MEsyZlNXems2YW1JbS9OQ1pEbW4zMG56ejdJN2NkQ2crRDFxQmtW?=
 =?utf-8?B?L1A2VTJyNy9qb1ZBTFpiQ1A2OVpnR2E5OGxBK1ZBQkhROUF2U25lMUdmV0tZ?=
 =?utf-8?B?SjlTU3FvL3lJV3RKMnY5VzFIbndSMWV5eU1HWUdFdXVNMDFxOUpscG9mWEho?=
 =?utf-8?B?Tm9JTXY0bVV5aHVuSGRDOHI5RVR1V1VQR1h3T1N2eHJ3aWJTNWRQeHNRcVYz?=
 =?utf-8?B?RWRxS1dYV0NXbCttK21oYjFJeDM5dUZXeXhnRllZb1d5T0dGV3BIQmxXT1Nm?=
 =?utf-8?B?WXU1OEVZTW5IbHpWSkhwVnBya3JWNlp6STNod2tBRmtlU1BmTllrdHFrNmRS?=
 =?utf-8?B?cVVCYUtCdmRkNjQxaDJNcUk0Rkl2WVBhTS9LQ3RkVmNoNE9BZzBFQUR6amRa?=
 =?utf-8?B?YnY2UGw2SUgrZldkOHRJNE03WU9neTU0WmVPVDhHa3JIb01JVmlQczRFRkdk?=
 =?utf-8?B?bnpmQndQOTc5WVBBK0I4S0tUY1IvcGtidDJaSmNTWElSUHdzNEdycm4rMlRZ?=
 =?utf-8?B?WXR1by9tRFZhbmMvSVhlQUoyU1ZXaXFCeGgwSS9JaEQ1blVjMTBDRFYyYjVj?=
 =?utf-8?B?aHhKbnpFZjBWTnhxeXZSSVR5THExOWMvaUp5bFFBZGYzN1Y1cjZMOHR3Y0Nr?=
 =?utf-8?B?aVoxRWpXMW9QZ2VEVDVJL3JHNERiNkJHeVNNTmZnMm1lTGtvU3czdDZDSzB1?=
 =?utf-8?B?K2JLOCtveGcyeTczVHRuMVBEMlIzK1oxUUZZTmlQQkIxVERENWhudTl1MkRY?=
 =?utf-8?B?amRiZzd2OFNrNGREMmZUYXoyb0VHYmFzMFpsbDQ3MnMwWE1IVUJaVWVpN3pa?=
 =?utf-8?B?TFlMTEdrY1pKMkwvYXBIZWgva2xYaUVieHVSMFY0WVNndU4wTmc4bWhiaWl6?=
 =?utf-8?B?Sm5QdzJRalI0d3U3ZzZ6MzMzR2Rma3dpSDlFS0Jac3IrMDJBOUZKZEdybGt4?=
 =?utf-8?B?eG85c2hGQThaZS9Ya2tmalphYVhNSk1YYjNGVWREVkhQSnJjaGtRZ0t6UTU4?=
 =?utf-8?B?UlF0Um5ZM0o0eS9vNy9yRnhWSy9RQUxyVzJucHVhQkpNUWlTTXNzQUxpeHZL?=
 =?utf-8?B?UjJ5OUsxT2t1MDgvZFlod2pTOHpYVVlrUEN6UFdvTWR5YjFhUFE1Y0ZCeXFi?=
 =?utf-8?B?S2NjV1VqMUZ6K2JYNDNFcldSYlBYeGZnZWxsaXp5SXhaZW83NVk3L0RCWE5r?=
 =?utf-8?B?eFg2SktUQVk1aU0yTUlrVnkxaGc0QUh1UEcrOU1PQnNTaFhpdkNIa3h2cVdI?=
 =?utf-8?B?djJodFd0aENSR0Vtck5WRzFUSmVyVUZvZHUxaFo1SnZuODk4eGM2Y20yVm9S?=
 =?utf-8?B?L3lGTEtmVmJlOUpuUFkxV25ocHpGOEFXRUEycXpmZ1JDRWtTYi83dlBxdmV1?=
 =?utf-8?B?WnFCSG5hVWMvWlpHOXpOaFpLWGRkdFlzSGg0YkZLdmcrRVNnUkhLd05xSXhQ?=
 =?utf-8?B?cGhpTWordnlyTVdVTkxkWkpVSmI2a1l5UG1Wb1RMYlZIMFZOQzNoZzRxNkF1?=
 =?utf-8?B?S1c1OXZKajJRVWViWlo3L0ZwM2xLZkpIYmxLWWNsWHlIRkdnVi82bnVKSXBX?=
 =?utf-8?B?QnN5a1hlMFkzRjZBZTYybWhoS1JJV0lXU1dSUHl2OFhzZkZybTRZVjJkU1NQ?=
 =?utf-8?B?T1Z6N1g1OEdaQ1Y3Q0JIZWhPcXdXVFIwZ3J6WFhtWjUwRm5WSjNtSHBtdjd2?=
 =?utf-8?Q?iy1IC6aN5wbqe3r4D+G2/fh+pTbKuQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:56:16.6405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7add6e84-b5eb-4235-6c23-08dd2fdb7547
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567



On 1/7/2025 1:36 PM, Przemek Kitszel wrote:
> 
> On 1/7/25 07:06, Tariq Toukan wrote:
>> From: Moshe Shemesh <moshe@nvidia.com>
>>
>> The HW Steering actions pool will help utilize the option in HW Steering
>> to share steering actions among different rules.
>>
>> Create pool on root namespace creation and add few HW Steering actions
>> that don't depend on the steering rule itself and thus can be shared
>> between rules, created on same namespace: tag, pop_vlan, push_vlan,
>> drop, decap l2.
>>
>> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
>> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
>> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>   .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 58 +++++++++++++++++++
>>   .../mellanox/mlx5/core/steering/hws/fs_hws.h  |  9 +++
>>   2 files changed, 67 insertions(+)
>>
>> diff --git 
>> a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c 
>> b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
>> index c8064bc8a86c..eeaf4a84aafc 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
>> @@ -9,9 +9,60 @@
>>   #define MLX5HWS_CTX_MAX_NUM_OF_QUEUES 16
>>   #define MLX5HWS_CTX_QUEUE_SIZE 256
>>
>> +static int init_hws_actions_pool(struct mlx5_fs_hws_context *fs_ctx)
>> +{
>> +     u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | 
>> MLX5HWS_ACTION_FLAG_SHARED;
>> +     struct mlx5_fs_hws_actions_pool *hws_pool = &fs_ctx->hws_pool;
>> +     struct mlx5hws_action_reformat_header reformat_hdr = {};
>> +     struct mlx5hws_context *ctx = fs_ctx->hws_ctx;
>> +     enum mlx5hws_action_type action_type;
>> +
>> +     hws_pool->tag_action = mlx5hws_action_create_tag(ctx, flags);
>> +     if (!hws_pool->tag_action)
>> +             return -ENOMEM;
>> +     hws_pool->pop_vlan_action = mlx5hws_action_create_pop_vlan(ctx, 
>> flags);
>> +     if (!hws_pool->pop_vlan_action)
>> +             goto destroy_tag;
>> +     hws_pool->push_vlan_action = 
>> mlx5hws_action_create_push_vlan(ctx, flags);
>> +     if (!hws_pool->push_vlan_action)
>> +             goto destroy_pop_vlan;
>> +     hws_pool->drop_action = mlx5hws_action_create_dest_drop(ctx, 
>> flags);
>> +     if (!hws_pool->drop_action)
>> +             goto destroy_push_vlan;
>> +     action_type = MLX5HWS_ACTION_TYP_REFORMAT_TNL_L2_TO_L2;
>> +     hws_pool->decapl2_action =
>> +             mlx5hws_action_create_reformat(ctx, action_type, 1,
>> +                                            &reformat_hdr, 0, flags);
>> +     if (!hws_pool->decapl2_action)
>> +             goto destroy_drop;
>> +     return 0;
>> +
>> +destroy_drop:
>> +     mlx5hws_action_destroy(hws_pool->drop_action);
>> +destroy_push_vlan:
>> +     mlx5hws_action_destroy(hws_pool->push_vlan_action);
>> +destroy_pop_vlan:
>> +     mlx5hws_action_destroy(hws_pool->pop_vlan_action);
>> +destroy_tag:
>> +     mlx5hws_action_destroy(hws_pool->tag_action);
>> +     return -ENOMEM;
> 
> I would expect to get -ENOMEM only on k*alloc() family failures, but
> your set of helpers does much more than just attempt to allocate memory.
> -ENOSPC?

OK

