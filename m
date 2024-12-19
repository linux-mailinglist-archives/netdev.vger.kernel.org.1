Return-Path: <netdev+bounces-153331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ECD9F7AF0
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD19166947
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECD1223705;
	Thu, 19 Dec 2024 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c5igZX9C"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292E5221DAE
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734610034; cv=fail; b=kh1nYRMDW8Fv0CXVPvvdCU5n78vdqnOjluElyLcGtjOTzI4U35LwsVdKioklK39uq96TNalv+mrv7qV+v+QiWhZUNsjGfDRms/748FyJueJ6/9q+hyWk+9KLOPMC19Hpp6ilOBLD9NneD+fBCkbVz9FBShORgzJZV60ZKRsZo0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734610034; c=relaxed/simple;
	bh=SDpU7X1zKXA+ifJvUtOO8CRzAJLt3ZdHzddftjApZMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gr5i2mInKjnAJogXyZjs4SrTDoT/CDWtle93YUyPTcn48/gGERsigLCF5oHiaoc/AzYSliiYFRDiNhpojhXrfNbHgg42oVUr4yNjTmMgyFeiD5LUiglvKMQA6no8X825ErXsRw+uYmS2xl+lWYWrn0tmVwaPY/sYzn3RXnQljmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c5igZX9C; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArganzJNzkuTJUBG3PJzK+e6fxPEc2/sjfJvup/5xHPZfN0LT7LsuIcFh0PT3dpnapmExECDXKHQDkX4yz26vOVXlNS1qnid54teSmsxG7Rj4UCdZCY/ZKvufOR6crTW4a2icYkFdwsE/qfAwNbH35eIMDFPGxDt5foliaRRRXrIpHCYvnq7DKuucZ8kFXNjdfs+IBVxPCfyN81kv7XzZMkfb8sQM7S4uOLFvtRkf6+6h+7cANhvKtuUPx8ZB8A96pi70PVtdEQMFeoLXKkAXhfJ1Phm5u431yYe/gloJRTpk/jDq8aJA/ry+cT1aeEFVBxoOZWpzl7HaSr2NGK/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwfThx0Vd4sOrGCcPQr02+9xUo+K0Y/3+M592IrCctU=;
 b=UBjwwyrKmFqJd3EbUxHY6G309PSApbWhWMI1/YsvznlovmMbypvPuNR9ilgCNU9rH5cS7CK70U/mHEvpM4zI0l2Cr/4GZTSHkn3P5pZV/LgpDTzLsEkEB9gCjH6Xqla6xBm9pvyddJfjzG7mKN+RdDJBy4+mFPoNTHB7UvxMt1MJ1DFr4t+7V7xVvImPV571tRZcjNP6ppfwWn7Dp0ymlssGKiPp4kgPM6hTKDW6IF6JA5TBIxPseEt4IPbWL69xoCDKS3ji/nHKu+c/1Mtrg2OjlJ1bQ+y+dVvL/PK6WWFHrN74XYvg67HKq8dKEcrkVKNFH/0K3vky3mW8YsuUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwfThx0Vd4sOrGCcPQr02+9xUo+K0Y/3+M592IrCctU=;
 b=c5igZX9C4IlKHAhPF4oLD5wX8cPCuaE+jmYhws+KJNtYgxUNRHV3X49U7YrrA604lF4dPdKRXoDAAZUkTNpS6U7Zda8Wyo0k1nhMUyvxlgyM8UWFkPKflDbBYBZjUTXbKVqstQs0s2kVtyJdN0blahQjeYdKYkse+56kHPgN8hpAJt91gTuT22mNMyYqdclscFujWviDW6wGHTCWHT0CCsUZwCqn7CoVCmkT6XoEYaCMmrIFwuG0lznwS/XWVHC06kWtOyY8yEJujewCDdXNKohYi+uZdUBDmmHsTtxZcIb5b5YP28IZ7YH54FL4xs/HEMNgB8lsh7qK/OrgLbufYQ==
Received: from CH5P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::22)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Thu, 19 Dec
 2024 12:07:06 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::5f) by CH5P222CA0002.outlook.office365.com
 (2603:10b6:610:1ee::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.24 via Frontend Transport; Thu,
 19 Dec 2024 12:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 12:07:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 04:06:54 -0800
Received: from [172.27.61.22] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 04:06:50 -0800
Message-ID: <8fd507a8-c0bd-42fc-96b7-ea49e1faf63b@nvidia.com>
Date: Thu, 19 Dec 2024 14:06:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 03/11] net/mlx5: fs, add counter object to
 flow destination
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Tariq Toukan
	<tariqt@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>
References: <20241218150949.1037752-1-tariqt@nvidia.com>
 <20241218150949.1037752-4-tariqt@nvidia.com>
 <015ad3e1-9526-4d40-af4e-ff852d9dd117@intel.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <015ad3e1-9526-4d40-af4e-ff852d9dd117@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 483f43cf-f9f4-4521-bd7c-08dd2025a7d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2FnbEozdllMekZjUHNuUGZ4bEQ1d2VaNUlUbklwNXVuM01SQmNxZUJaYmRM?=
 =?utf-8?B?S1kwaXFKYzJ3bDVvbXhGYWFKUjFuenh6UEpzTGlUYlZpTHU2RVV0WFJCbElO?=
 =?utf-8?B?MG8vdFd1bEZic3V4YzJlRGR4RW03QURUZXhZNFlzQWJIVzFodXFwUndSY2lV?=
 =?utf-8?B?a3VNTnZpTHlRRmgxZUIvdFZaU25EY3JPK3daT09FM3NyRWRhZDVraUJsV0h5?=
 =?utf-8?B?bGpRRFNlcDgvRUJ3azBQWGlJMW13SkhtVWYveTNVU090MkRSSVc5eERMa1Az?=
 =?utf-8?B?WGllcWsrbjdObFd3b0lSbjhCdEE0Z1RLSDdZejIxUEJHMmx2NHl1dHlhbk1F?=
 =?utf-8?B?bEVkS3MwMTQ4YXpvcTl5RzJTMGFOanZkYkQ0T3AzMkZ0elptYmtiS3JyZEZC?=
 =?utf-8?B?aE1rWGF0cHVhRndlelR6MGJjaWtzb1NzK0Y1L2dJOFRRQkNSUzg5U0dEZlBZ?=
 =?utf-8?B?OS9OVkZ4ck9sbXlsZ0FkQVBUeTBiVG1WNHlkQUNEYkVTM3FsYTRHOGtSUDZm?=
 =?utf-8?B?eXJPc1NnWHZkY1I4MEtZTm1rR1d6YWxQSU5UbmpaOXM2UExpQi9IM1g0d2tO?=
 =?utf-8?B?Y2lETS9PTHpCVlFVRHNJdFJJKytYb0NWTHB6Nld3RFVOQTQ2Q0txOWhCNy9O?=
 =?utf-8?B?WGgvNSsveFNxeWt4UVJjUjRZUzltWVFxb05vUlJsUy9RTEZHL2hqeWFVS3hL?=
 =?utf-8?B?SkIzMXc3cVY1Q0VFVTlyYkc3dkVjOFVkVnhMQUhtVExKN2JOWVpjZTMrWllw?=
 =?utf-8?B?cWNaUzZtWUlSS3lZVWY5ZUgyOUorNVdJTm9zNm5MeUJmVTJnY3lGTmlJWFd3?=
 =?utf-8?B?cGJnUG9yUUdQajVQYXdrM0doY3NQdng3azFvdC8xYVZFVys3VUZOUmF4SytQ?=
 =?utf-8?B?K3k1eUNCcFB4TWRRb2RqaHM4YXdLSEdDbDJsc1VydlFLMUo3cG0rU0hmNm9H?=
 =?utf-8?B?cTBhdk5oVzhkR2ZlTk1HSmNMamViQUlCeXlWeExrUVNISTlkU3VwUWV5VUV0?=
 =?utf-8?B?Nml3RzBWZXorYUlQWFlhcjQ5TmFlQWZaRzhPd1lXTzRkY0lXOGtJTWZwbEx4?=
 =?utf-8?B?cDdKdC83N2JoVlp4eE1uNEY4cGdBRnFTZVJXYldJWUZ0NGlLZERPMGhFREI5?=
 =?utf-8?B?SGdocDV5OXZpcGlWUm9YRmJvdXM3UitSRVg4eHFjbGlycEtuR2pBeFZXNE1y?=
 =?utf-8?B?ZUhxeUE3bERFa2FBMklrckNlNk5Wdmt1TWlPNlJxb2p0OEhKSitJWUdlMGx2?=
 =?utf-8?B?bTdBNVdlN0JMbkpLYWpLbi9xcXlNZ3JZWUkwQ2xFK0JMaVFrUEF4RnBkYnBV?=
 =?utf-8?B?cG1Ka2dtTk5TVzNRVS84MTJDMGlLbHRHYVRtcUVoMzNLMWdmb3hGaUdvQVVL?=
 =?utf-8?B?TWRWcktEbXVrb09WV1pLTzhOK2hjVVNORjE4NWhVdGVXSVRlTnBNRUkwVVVo?=
 =?utf-8?B?eUJJZkI2VVVkRVlZamdRTGc4NGtsVzZVbmdVMEtoek9Ja3UwUTV2dFhTcVg4?=
 =?utf-8?B?dWc5RDBOVTJlcjdLOXFvM1M3U1U0UzBSZjZlZjVMNWxzTTJrdUJyTGViSDBP?=
 =?utf-8?B?ZDU3UHVobGljKzJ6bko1Ymk3QTZKdENLNnV0KzM5TjZLZmtuemdPVnVTT0pu?=
 =?utf-8?B?dFFjZ2diYkdDcjVtNk80ZWdGenFLZU1LclRqcCt3T0haMHlwWG00NzY5Z0Ri?=
 =?utf-8?B?c3BhaDBOOWhnZGkydk5tTkIxODUzZlpzVEZZNGxVOUhWM0tualpCOWRkdGFl?=
 =?utf-8?B?Y2ZvNHBQdHNQTWsyVll5ZFBXUlpZelkzRTRNRmo2bXUyaVBNMTA2bVpwMEh5?=
 =?utf-8?B?UlBLZ3VlVXE5RXFSaTl6VEdpNFVsaXNmT2VzNVR4WHp6NmJra1kzZFlFTHRS?=
 =?utf-8?B?VVZlaUxiT3NGSzZGaEptTWpVL2d3eTQvT2hwU3EzbEw4RG1TMFh1R3I2NC94?=
 =?utf-8?B?cGJBOG0rNmpPVVRWaS9nV205QXI5c3psaWhJRFNaS3ZJdXJ3UExJenhGQzVm?=
 =?utf-8?Q?mvt8ueZr+C8XrxWokTzbJVh2MO35Lo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 12:07:05.6244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 483f43cf-f9f4-4521-bd7c-08dd2025a7d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233



On 12/19/2024 11:00 AM, Przemek Kitszel wrote:
> 
> On 12/18/24 16:09, Tariq Toukan wrote:
>> From: Moshe Shemesh <moshe@nvidia.com>
>>
>> Currently mlx5_flow_destination includes counter_id which is assigned in
>> case we use flow counter on the flow steering rule. However, counter_id
>> is not enough data in case of using HW Steering. Thus, have mlx5_fc
>> object as part of mlx5_flow_destination instead of counter_id and assign
>> it where needed.
>>
>> In case counter_id is received from user space, create a local counter
>> object to represent it.
>>
>> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
>> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
>> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>   drivers/infiniband/hw/mlx5/fs.c               | 37 +++++++++----
>>   .../mellanox/mlx5/core/diag/fs_tracepoint.h   |  2 +-
>>   .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 20 +++----
>>   .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  2 +-
>>   .../mellanox/mlx5/core/esw/acl/egress_lgcy.c  |  2 +-
>>   .../mellanox/mlx5/core/esw/acl/ingress_lgcy.c |  2 +-
>>   .../ethernet/mellanox/mlx5/core/esw/bridge.c  | 20 +++----
>>   .../mellanox/mlx5/core/eswitch_offloads.c     |  2 +-
>>   .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |  2 +-
>>   .../net/ethernet/mellanox/mlx5/core/fs_core.c |  1 +
>>   .../ethernet/mellanox/mlx5/core/fs_counters.c | 52 +++++++++++++++++++
>>   .../mellanox/mlx5/core/lib/macsec_fs.c        |  8 +--
>>   .../mellanox/mlx5/core/steering/sws/fs_dr.c   |  2 +-
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c             |  4 +-
>>   include/linux/mlx5/fs.h                       |  4 +-
>>   15 files changed, 116 insertions(+), 44 deletions(-)
> 
> 
> 
>> +/**
>> + * mlx5_fc_local_create - Allocate mlx5_fc struct for a counter which
>> + * was already acquired using its counter id and bulk data.
>> + *
>> + * @counter_id: counter acquired counter id
>> + * @offset: counter offset from bulk base
>> + * @bulk_size: counter's bulk size as was allocated
>> + *
>> + * Return: Pointer to mlx5_fc on success, ERR_PTR otherwise.
>> + */
>> +struct mlx5_fc *
>> +mlx5_fc_local_create(u32 counter_id, u32 offset, u32 bulk_size)
>> +{
>> +     struct mlx5_fc_bulk *bulk;
>> +     struct mlx5_fc *counter;
>> +
>> +     counter = kzalloc(sizeof(*counter), GFP_KERNEL);
>> +     if (!counter)
>> +             return ERR_PTR(-ENOMEM);
>> +     bulk = kzalloc(sizeof(*bulk), GFP_KERNEL);
>> +     if (!bulk) {
>> +             kfree(counter);
>> +             return ERR_PTR(-ENOMEM);
>> +     }
>> +
> 
> I would expect to have following line added here:
> 
>         counter->bulk = bulk;
> 
> otherwise that is memleak?

right, will fix.
> 
>> +     counter->type = MLX5_FC_TYPE_LOCAL;
>> +     counter->id = counter_id;
>> +     bulk->base_id = counter_id - offset;
>> +     bulk->bulk_len = bulk_size;
>> +     return counter;
>> +}
>> +EXPORT_SYMBOL(mlx5_fc_local_create);
>> +
>> +void mlx5_fc_local_destroy(struct mlx5_fc *counter)
>> +{
>> +     if (!counter || counter->type != MLX5_FC_TYPE_LOCAL)
>> +             return;
>> +
>> +     kfree(counter->bulk);
> 
> in the whole patch there is no "->bulk ="
> you didn't catched that as it's fine to kfree(NULL) of course

right, thanks!

> 
>> +     kfree(counter);
>> +}
>> +EXPORT_SYMBOL(mlx5_fc_local_destroy);

