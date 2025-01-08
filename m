Return-Path: <netdev+bounces-156233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AB1A05AA1
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F6F3A60AB
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 11:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F2F1FCFD8;
	Wed,  8 Jan 2025 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RWytE1am"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D2D1FCCF6
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337220; cv=fail; b=reRajHrg9MNgNRrTFlw8n3iNrmJgdN8oVv/OoXHRnIE8E8XK+78Xc3+vLe/c/k000l3pboIfxtVG5w4t8BH/8oXXjm/HNwRWsJlTgDqdYmdml/7Yv1uvWnbFEywSTvK9ky4G3HATWuWZ9o4YreJpZqSYTkHB9Cmt0fC2Jlaf5Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337220; c=relaxed/simple;
	bh=YIMTAkZK28YzrJLNQFtKPJ/4ue+JWDNffjtYaXvCSwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PyFckdFpHQsxipRTC48akFRq7IhCw7pcQVs4bamEs053Iu0EiL7gW6d3yArmtAKtMazh54lnweAEZLaYY7NvbiiVpEFY0ZnF9afeebodHpP6xl3LCOBQifeTPTGmZpuEIbfAuHK1eEdDhac3TcSqtK6j77wbOetngFxvg3uf/jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RWytE1am; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jl0Uj+guWsWyQncJHapVAW3u6IGxerxqcabhKbA+6VLeFSJhSC6COlpfhAgU3kIybHfRkhS1+WRmekDDAokPJOv/Q+BznVpEmVhy79EYSm0OS7pGDpZ4vZnxRUWaZvB4szcem22sT67F+MSe7KgV0d6LTO1khvYQURJun2sQr0wbIHfjNoJu3yYPb3RrcdpQxb3vVvJPGaD0zM7hW2TsrNP+mmPzX0b78dFXhfvxZOGH8TmbYnUoibqT4V3cVIvcfE8TuD8Ss6pjNy2DHdUkqijMEydhrtlJXZJG16kX96Do/FLcIftoAwFxUG/r1oX2AqYNVyspUzV4TEYPnnNe6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=od6H91ArMAqlU722gtX7bPt2XGKC45ls170EV/HnIUY=;
 b=NvNhJ80IHBmCN5dtSnL3NYL5SrKQf5a35OJe2+nGosdn5ZrtRcqKi9/immtTSEb18cIVCk1nOLWksC6106RgvBO5FPtho3OPnn3orujBGLTy4FLI90UnCNGlTHScR3eEBb+3JNWm0nohmzqZPmlWBVMwkiQxYzKbQm4eKJaVoTv7Jczy8CTHAW5680myYr+DOY/4dpesEOcg80EwxoWE45cx/aTnIfgVtZwMVXyFf/jO3XHI6L7vvQ87aT6Q5TBwMA3v73SUU3y1c+nXh5WBr9Pe19vn4uACrYHkmkemtsYCykKPLOF12WRFAuRmVbkqcGZJUro8cYIrfoO1iwLU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od6H91ArMAqlU722gtX7bPt2XGKC45ls170EV/HnIUY=;
 b=RWytE1ams4LF5yofpthDnKyp2sniUNW5kSN8Jg5GPZpK8QFh6v/C+8xGDQ7Bof/rYdti41a3M/8B3nqsPwDpYZ5AVd28Ip6fm/kWsRHvTdmxpUj7EMaZeFqCS2cvFtbJ0Df9BudLls1Kbe9ezRX19sNvoVniPB5UxtEJ8utEckC+2NRqPF8WX/UbO9S4cAfy2S9oSNFbL3BKHH2aV3+FecxlWXUclZIsSRuObapmEHg1kH9298McQjjcJyEfkuRnXntWewLipnfPv8x21vtFoNc8Jn0sg2VOOt+NkXHyh3r/1oKKEvsmHafgAa8X3XvPj3jjWLyqY+3l+Rf+7ofHKA==
Received: from MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::14)
 by DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 11:53:35 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::78) by MW4P221CA0009.outlook.office365.com
 (2603:10b6:303:8b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Wed,
 8 Jan 2025 11:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 11:53:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 Jan 2025
 03:53:19 -0800
Received: from [172.27.19.172] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 Jan 2025
 03:53:15 -0800
Message-ID: <8b1452fe-1781-4547-bbda-fd6d1a7ef7c8@nvidia.com>
Date: Wed, 8 Jan 2025 13:53:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/13] net/mlx5: fs, add HWS root namespace
 functions
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Tariq Toukan
	<tariqt@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>
References: <20250107060708.1610882-1-tariqt@nvidia.com>
 <20250107060708.1610882-2-tariqt@nvidia.com>
 <301091f2-97f4-4781-92dd-d9cfb33eedcf@intel.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <301091f2-97f4-4781-92dd-d9cfb33eedcf@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|DS7PR12MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb75cf9-fe5a-43b5-89c7-08dd2fdb14a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGh3OUdJd3dCc2VybUxlNktxNG5raFJoeGJ4c2ZUY3dZS21lOG1TeUJLbFAw?=
 =?utf-8?B?ckNVTUFaYmp2UlV2VkVGcjlBT2I5OFhBSTA1VlZUSGpNQXpCZHQxK2FXQzJ0?=
 =?utf-8?B?UDJNb2pRcy8yYWdQN3NTUS9LY2ZoVmRhSndqb0xFNkFGSGdUNU1xWFhPV3Bj?=
 =?utf-8?B?VzU3RDRnOGhhZWtJSE1kVFptcG1xSzZJbzNoZTFTb2NNaXRHRHZIQWJkNTZU?=
 =?utf-8?B?Sk8rSUMwSzVCdkhOS0p4Y3grMDhRTmNyZVFVZ2s5K3RWRHNUNTFRaDY5QkhF?=
 =?utf-8?B?VWJwOW5oMzBIZUFhQ1YvSjNLMjZqK3ZPOXBlVUxBN0FnL092aVkvUDUwTGgz?=
 =?utf-8?B?SERET1VxRTY5cGtuSDl3VXpna3hmVEZJTHZPSUN4QlVXUFpPcVV3QVFHOW1O?=
 =?utf-8?B?bVRSbHB5YjIrNGZxcTh6cmhRUzNkOURvb1pGUWNLUjJaS1R3cG5XRmdlL2ZN?=
 =?utf-8?B?a3ZtaTFiK2ZObllUNSs2ZENzTkMzSDZBYklCV1hjRGlBZDdZcklYR2c2enRm?=
 =?utf-8?B?R0dUZExwaHllU0hlQ3dtSlExL241ZXorekV1clpJS1dndW5OaWd6bG5wZHow?=
 =?utf-8?B?MG9LTTBYSDVWem95cmFralphclptUHg3RGRWVmZjL1dpYUNueG9EenY3ZUw4?=
 =?utf-8?B?bEhBd25iVHhQdDlzRVZqMGdSY2lud0pjcVRUL1RBY2JLdDF6ZE5rajN5bTM1?=
 =?utf-8?B?b3VxaWdEUU5ERld5cnJHU3BWY3BPMFhEUTA1UlJOTDhSR0wyWGptRDhEakFB?=
 =?utf-8?B?cDE1eWlObUYwU2JDQ0tvTlFkdTRaODI1eWYzaFI4UUY2RWlSbURJYnhYb2tr?=
 =?utf-8?B?T1o0ZmNYRUtQc2NvbjRkcG1HWWw1VnBiTGxPOHVRcnlNRDVtb2FtZS9oYkdo?=
 =?utf-8?B?THErMnVHcEZabEl2VHVnbjVkT0RnMklieFEyWWVGOVgrWi9rdW5tSnRDTG1B?=
 =?utf-8?B?SUF6VklOT3lVdDN1a28rTDNxZEQ0TnBkYllzUWRUVHhtWWpVNGxHbndQUjlr?=
 =?utf-8?B?SlJBMndGR2NjTDdZM2VBdUVMcDFxV1p3SHJiMkhybEE5QzUzRkhyMEhkNzRY?=
 =?utf-8?B?SDlCOXdDblFrbERPd3l5Y28xbEM5YjZMWTVmQXlPVk55OTJYRlliZUhyY0R0?=
 =?utf-8?B?dGUwNUxLVkpIWTZLaHp0dStZK3UyNVB3Q04rRFozL1VqbldiZmJTd0ZLRWl2?=
 =?utf-8?B?RGV1S0VldndqU09xamRCWUk2ejZOTGJxYU91Ykk5NXBkaG0yUHVlMXhUand2?=
 =?utf-8?B?UkdEc2VSTjRwVm5TVk1RRjlwUnVIVUQ0bm1JU3RFVTB1blBNMWpnY28zbnNz?=
 =?utf-8?B?dmw0RFpyRTVQNG5ZdEl3b2xLSm5UcWRHVzMzcFU4WWM0TUFDaUEvRUJ1bHdU?=
 =?utf-8?B?ZVFWSmRrMWdVZmpKbGEzNTJDVk5lbmtiWmNPL0EwOEdGNTlxWnd5eVYzc3U3?=
 =?utf-8?B?MDROVEFSdkNRRmtSTWEwbkVnQ0xzUjI2K0tGOVU0YWN6Y3liS0d5ZndaOTdW?=
 =?utf-8?B?ZGMzenh6VENLQllqVDNtcFFST0U0Y2Q4alEzUWlxUXZncmhPZDBVcVM5UHdl?=
 =?utf-8?B?ODdwd1BkNlhCYVVJaEQ2WW9LTjFJdWI0em5wcStPK0NTOEtLZmY5SkFLQnBw?=
 =?utf-8?B?bU55RjFtL2UrUnlXRHVUNkU3aGV6VWl3QkxCUkx2cVVtYXR0VmtCTUhLQ3Zw?=
 =?utf-8?B?a2V0b3RtbHkrRmo5citFa1M2aEVDQTlnWHlKZm9PTmpwQTZXNVFKSk1yT1FN?=
 =?utf-8?B?WUN6TTB0SDdhK0t3d013TkJHTkRid0lvRnMySFA1L1hpa2VZNUhSL2Y0dDlO?=
 =?utf-8?B?VmhZaTkxay9sYm95aG1Pb0UwOSttalUzWWttelpSZEhHMzVQUlF2N2FhRHJK?=
 =?utf-8?B?bEllcjcvOVA2bWZUQStKaFhpcnVTT213UUlrVVNkN0lMZUM2RU9XWHYrMTJt?=
 =?utf-8?B?dHBZNXVTSGlvSDduYU1VSlNsaHRXVUpyaHorUlgrQWF0REVjelN6K3EvdzRR?=
 =?utf-8?B?SExjajR3RktnPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:34.5521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb75cf9-fe5a-43b5-89c7-08dd2fdb14a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9475



On 1/7/2025 1:27 PM, Przemek Kitszel wrote:
> 
> On 1/7/25 07:06, Tariq Toukan wrote:
>> From: Moshe Shemesh <moshe@nvidia.com>
>>
>> Add flow steering commands structure for HW steering. Implement create,
>> destroy and set peer HW steering root namespace functions.
>>
>> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
>> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
>> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>   .../net/ethernet/mellanox/mlx5/core/Makefile  |  4 +-
>>   .../net/ethernet/mellanox/mlx5/core/fs_core.h |  9 ++-
>>   .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 56 +++++++++++++++++++
>>   .../mellanox/mlx5/core/steering/hws/fs_hws.h  | 25 +++++++++
>>   4 files changed, 90 insertions(+), 4 deletions(-)
>>   create mode 100644 
>> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
>>   create mode 100644 
>> drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile 
>> b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>> index 10a763e668ed..0008b22417c8 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>> @@ -151,8 +151,8 @@ mlx5_core-$(CONFIG_MLX5_HW_STEERING) += 
>> steering/hws/cmd.o \
>>                                       steering/hws/bwc.o \
>>                                       steering/hws/debug.o \
>>                                       steering/hws/vport.o \
>> -                                     steering/hws/bwc_complex.o
>> -
>> +                                     steering/hws/bwc_complex.o \
>> +                                     steering/hws/fs_hws.o
>>
>>   #
>>   # SF device
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h 
>> b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
>> index bad2df0715ec..545fdfce7b52 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
>> @@ -38,6 +38,7 @@
>>   #include <linux/rhashtable.h>
>>   #include <linux/llist.h>
>>   #include <steering/sws/fs_dr.h>
>> +#include <steering/hws/fs_hws.h>
>>
>>   #define FDB_TC_MAX_CHAIN 3
>>   #define FDB_FT_CHAIN (FDB_TC_MAX_CHAIN + 1)
>> @@ -126,7 +127,8 @@ enum fs_fte_status {
>>
>>   enum mlx5_flow_steering_mode {
>>       MLX5_FLOW_STEERING_MODE_DMFS,
>> -     MLX5_FLOW_STEERING_MODE_SMFS
>> +     MLX5_FLOW_STEERING_MODE_SMFS,
>> +     MLX5_FLOW_STEERING_MODE_HMFS
> 
> add comma here, to avoid git-blame churn when the next mode will be
> added

OK
> 
>>   };
>>
>>   enum mlx5_flow_steering_capabilty {
>> @@ -293,7 +295,10 @@ struct mlx5_flow_group {
>>   struct mlx5_flow_root_namespace {
>>       struct mlx5_flow_namespace      ns;
>>       enum   mlx5_flow_steering_mode  mode;
>> -     struct mlx5_fs_dr_domain        fs_dr_domain;
>> +     union {
>> +             struct mlx5_fs_dr_domain        fs_dr_domain;
>> +             struct mlx5_fs_hws_context      fs_hws_context;
>> +     };
>>       enum   fs_flow_table_type       table_type;
>>       struct mlx5_core_dev            *dev;
>>       struct mlx5_flow_table          *root_ft;
>> diff --git 
>> a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c 
>> b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
>> new file mode 100644
>> index 000000000000..7a3c84b18d1e
>> --- /dev/null
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
>> @@ -0,0 +1,56 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>> +/* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
> 
> you have submited it on 2025 ;)

Yes, I did write it in 2024. I will fix.

> 
>> +
>> +#include <mlx5_core.h>
>> +#include <fs_core.h>
>> +#include <fs_cmd.h>
>> +#include "mlx5hws.h"
>> +
>> +#define MLX5HWS_CTX_MAX_NUM_OF_QUEUES 16
>> +#define MLX5HWS_CTX_QUEUE_SIZE 256
>> +
>> +static int mlx5_cmd_hws_create_ns(struct mlx5_flow_root_namespace *ns)
>> +{
>> +     struct mlx5hws_context_attr hws_ctx_attr = {};
>> +
>> +     hws_ctx_attr.queues = min_t(int, num_online_cpus(),
>> +                                 MLX5HWS_CTX_MAX_NUM_OF_QUEUES);
>> +     hws_ctx_attr.queue_size = MLX5HWS_CTX_QUEUE_SIZE;
>> +
>> +     ns->fs_hws_context.hws_ctx =
>> +             mlx5hws_context_open(ns->dev, &hws_ctx_attr);
>> +     if (!ns->fs_hws_context.hws_ctx) {
>> +             mlx5_core_err(ns->dev, "Failed to create hws flow 
>> namespace\n");
>> +             return -EOPNOTSUPP;
> 
> I would expect -EOPNOTSUPP to be returned only when there was no action
> attempted

Yes, I will return -EINVAL there is also a print here
> 
>> +     }
>> +     return 0;
>> +}
> 

