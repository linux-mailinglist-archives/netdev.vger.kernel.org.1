Return-Path: <netdev+bounces-153345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D650D9F7B7E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 128947A6152
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2834D2248AD;
	Thu, 19 Dec 2024 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lrug2SxF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD24E1FA8DD
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611480; cv=fail; b=r9WENivF7CDhMbto26jHmfJV7TWjXXn3mzS7Fu8BmRFgHXBpg8dk32zHkRfoaZIHGYmtv0KVZzq4qjAVHl5S8UmolGaeAv4zYFPbKxQOXDEdAhN1WhLCJmOpWQ0ryIE+UrY63cq7nFAd2761OGKcSZB6xYVP0Ba0XSZRzVPcy9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611480; c=relaxed/simple;
	bh=ecGVM/oKFLHf1cfpaP6a/YfaTiamQVMzhUvbNZrjrqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S/ub8di4h4W+DuDCb1n65hWIkADuNFEmzzdtw91S/Kv0TBAO23ukh+WFhbEwo2VdlCQ3AjlhlzXcEl9a5o0QdIUP/hlzJjcfEl2m9bltfrD/0S/ZRYXvG6DoNgucXm8YYWaSKSkqi67dlJ968yr3plDV2LgfkeIzU81eEOaEcOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lrug2SxF; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNRYe2891XVg4oI85oOJiF13BNHEOchdTZdUOgfe545pq02Y5AOZmwWTsGflCpJbgQY5b/BHrFVLuXqbgx60vKoydRQ85AxmP+XKpZijG6fJNGET3vdyavnYBSFh4bJspmT0dsV4rMbrOOFF7hLqAHFTzso4Vk27+Tgs3iAUTfow1cO+eYTpHS1TvavgGioHSX0cAi27h4Rnqsltnw8yMp9AYeVOkW1QCxk5z9VKIlR/6x2TKZL4pcbFCDkiXtcxAkRHf23yLFncbMq4+6ZAOjouxNrT2VLJW5OFS8yFXF38O3EY4ceGOGgWtH8aGeeVAQpBa1Pnm7EAU4zcY546Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GH0MZVEx3ymOXBKwngfDctGPX5wdmxAGH2PkX4EJfYY=;
 b=N3KJCL5tHm7izbffBTcdq96YdkPSYMcP8vUFWSymN7Rbp/qds4OYnMmUmtSZVyPafGSklg7NIASs8yGsJYwpeS0wxD7EFqXpTp2aIsNeAbroyn1Kz1P545QsCWYGoQp0ESqW117h6AfIudERYkPHCnwORpLSgOOuxtRXr5LkH0SCfVmw0vhvUdSt+ybpQNmjmg5fcespQssD0gW+WrsXGjfEvcxnJWS/omfGxAS8ipBh7sus/+t5Oz+IvNzgw7U+9sur/prp7eHnC8JfjCVdBLVPzoa2miQjaE+nkOKF26qxiAWq/yQPc3TeYVxeAiB6q4oH72elEtf8JnpguU6RKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GH0MZVEx3ymOXBKwngfDctGPX5wdmxAGH2PkX4EJfYY=;
 b=Lrug2SxFdFWGdWjBkqHHjhEadKRcI9iORo/6YTNmUDzbzO4FoAF0Wj99hEmtaS/RBJv+qqSqP1C9YIjRKspxY8rS864tV7KzE9DK/34MztdGyZWEGFGY6KOAJokpMqW5D564dLLtD7IXCM9IQtM1mkStvnl4WgZ5PYtrtVg0zAIh7G7+NtMBHoL0l2IiPbdvkWUUbX5KllDMK0vZsIFOkCiPGPG+FJDv3KjdGl0WzgWWYfC9plxhObNZMU2VxtnTwb9jaM0zOvfSARYwdGQ8Vhsuh3qEmux3n2nlUrKh0xbPnyEhKTvKMjT3HoBkVPjkLGoeyAE0OAN4pf0NqfB2rg==
Received: from SA1P222CA0112.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::25)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 12:31:11 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:3c5:cafe::19) by SA1P222CA0112.outlook.office365.com
 (2603:10b6:806:3c5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Thu,
 19 Dec 2024 12:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 12:31:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 04:30:53 -0800
Received: from [172.27.61.22] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 04:30:49 -0800
Message-ID: <d8788869-51d6-45c8-9009-e72453cc381c@nvidia.com>
Date: Thu, 19 Dec 2024 14:30:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 04/11] net/mlx5: fs, add mlx5_fs_pool API
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Tariq Toukan
	<tariqt@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>
References: <20241218150949.1037752-1-tariqt@nvidia.com>
 <20241218150949.1037752-5-tariqt@nvidia.com>
 <0c6d6368-85ab-4112-a423-828a51b703e1@intel.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <0c6d6368-85ab-4112-a423-828a51b703e1@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5804be-eb8d-4f95-277c-08dd20290549
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDkvcmZJS1ZQelZIOTRBMzZ5WHlvcVByQXhvUVZGQUlDWUQralpvOWFuak9i?=
 =?utf-8?B?MkwrZUVaUkZzaTltMlRzMkw3L2VLSjBWUkRjQXlXT1FxUzNRY0JvUG40b29s?=
 =?utf-8?B?Q084Y1BmdkU0WkhkYUJodGQrQjBiRzIvK3BRaW1FZkVaeE45WHBhRXZmTUhF?=
 =?utf-8?B?V05zVy9yaXhHRmFtcjRCbDlJWFRuU0RySHhmRkl2aUxPdWNjekdWTmZEdXJx?=
 =?utf-8?B?NVhKcDJXcU5QbllxT2VTenBrVHpXOGhEbXZGK1ZYNndoS2QyZVhBZHA1ODBC?=
 =?utf-8?B?WUhWUEs4OGczYlVBK0hrUlNzd0Fscm1KMzRFalNpdWRGSjgwTk82UkEvcnhI?=
 =?utf-8?B?dzByemZPbmpnZGxmUzREY1picGxuV3FxV0NBU2FsZkxYU3Q0RlQrVHVlak1m?=
 =?utf-8?B?Y2ZPN1lBZk9YcWd0cU5DdG1mOUJtU3pDQ1Zjd2JmT1lnKzlaUUxCR0JRaUox?=
 =?utf-8?B?dXlHSjFOTjVBVytGSlQ5L3VVTDl3dDh5aUhvTHZjVWtjV0RGakUySVduejRW?=
 =?utf-8?B?ZWJnVDIwejhDbENzOHVoVjhCMkZiQ1M4K1Vva0k2QTJBeWZ2bWFGbDZ5K2tm?=
 =?utf-8?B?dFhNTm1DemxGeTV6TzlEVVNyWnE5RHVkbzRoUGNrOEdtcC9hdEYvQmt1RHU3?=
 =?utf-8?B?OTNnbXpyZTR3aFBtSW1SbXltSmphRDdkb3djaTB1Mkg2TEJRR0RZWkt1a2l2?=
 =?utf-8?B?NWQ4ZjZyaVVZeExPSG8vMkFLQ0FjRUpLc2wzOGxiVjEwNys2Y0hrWUpqRVlq?=
 =?utf-8?B?Nk1BVnFlUTF3am1ZNEdOdEJJRnlTTnBySlpuYmZNcVVkbi90KzVMWmI0NTRD?=
 =?utf-8?B?SXp0V0lpZGdCL0xpMXhUMFlGQXJRWEs0RzJMZzMwOC9YUndDQ1F2VGYxOTV4?=
 =?utf-8?B?Z2hyTHY4YVJqUzJEYVpVaGpiUjdIOERKdEg5SU1qY1RWdkNvZmx0WnBFTmV5?=
 =?utf-8?B?RlhoWnBiNTdMZy9GbmsvcXNlRHhmQ1hqM0V4ZDJiTTJ0aE5TUzVkNm1vQmtW?=
 =?utf-8?B?SUtLZVZ4MHBweVlURTVmWW9WVTdtQW9wMjhTU0tmQWgwVVY2d3ZKL1VxTUp4?=
 =?utf-8?B?U3ZyZTVjRm42anQ3VXlFQmt3RnlmV0JGSFlQc3ozZndaMTcrS0Rmb0hwSHFz?=
 =?utf-8?B?WFZRaWxweS9aZkoxMVFxaTJNNmJ1NytLRDNURHBzQWdDQ0hPdWhwTU5BWmlh?=
 =?utf-8?B?UGxYMWE3V09SMVFGdEsvUllnNngvM2NOYUppYUlkbjZsQml0cVEvaldDVG9W?=
 =?utf-8?B?YUtlU2RVTGRuWWdlTXloMEkwUU9UdThDbEV0OTVNcDUyTU01TVdZRFE1QW9l?=
 =?utf-8?B?dloyNXBEekIyQ1hWK01xMmJMOTN4WllyZElUaVU5M1p3d3p4SFZkNWRwSEhO?=
 =?utf-8?B?ajBiTlE2c1BCS1d2VHpIeFdkemUzMHZYMG8yWW9iTnBHRUdSMVVPcmdrS05t?=
 =?utf-8?B?TGczYWRQaUZCQUl0SXlHSGlDTkVFU2pyeklickFUYStJSm43STFyK2tqOHg2?=
 =?utf-8?B?NVltWmxDdjU2ZVBXL1VXOWNnc2E5YmcyTGl1VlppYi9tL0diUEdhTjJYS29K?=
 =?utf-8?B?dmlOMmxPSGtCY0JOTEVyTUdjdTQ1SUlJVVVCTFg2S3hkU0NVYnZ5d2lGMGhW?=
 =?utf-8?B?aWpUNytxK0ZqN3dMUDdJT1RlK1hHd0tRdm1TTHQvSFFSVWJFTHUwY24rNG83?=
 =?utf-8?B?aFBpVVBJNkZwUTBYNGg5VXFlWjk5VVFZdUtHWnBVNXBOTDRBa3ZMZENidVRS?=
 =?utf-8?B?WndGUjFBZHZnTDhqOHBCOXplQ3NUUXEyRCsvK254Q3gvd3J3emRuMkpuUjBk?=
 =?utf-8?B?dm9TNHptQ3RSNWtvSW0rRjBWWTM3Z0JHcDgxLzZRQnYzcXNmYkRYWEZpSDRZ?=
 =?utf-8?B?NWFqQm1TSXFzWG9jY1BzWDhWRkJRQnpvVEZpdkkyQ095MGF6MTVaelVlcGdY?=
 =?utf-8?B?dlhYdWJTRXBQdldiUy9nM3pEVVBZTTJ6NHVnbzVZdkVoeE5Sb1E1c0tSbStV?=
 =?utf-8?Q?8EPh43QChdAJH6KX4FTU8K5+Cp6UPE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 12:31:10.9500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5804be-eb8d-4f95-277c-08dd20290549
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079



On 12/19/2024 11:17 AM, Przemek Kitszel wrote:
> 
> On 12/18/24 16:09, Tariq Toukan wrote:
>> From: Moshe Shemesh <moshe@nvidia.com>
>>
>> Refactor fc_pool API to create generic fs_pool API, as HW steering has
>> more flow steering elements which can take advantage of the same pool of
>> bulks API. Change fs_counters code to use the fs_pool API.
>>
>> Note, removed __counted_by from struct mlx5_fc_bulk as bulk_len is now
>> inner struct member. It will be added back once __counted_by can support
>> inner struct members.
>>
>> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
>> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
>> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>   .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
>>   .../ethernet/mellanox/mlx5/core/fs_counters.c | 294 +++++-------------
>>   .../net/ethernet/mellanox/mlx5/core/fs_pool.c | 194 ++++++++++++
>>   .../net/ethernet/mellanox/mlx5/core/fs_pool.h |  54 ++++
>>   4 files changed, 331 insertions(+), 213 deletions(-)
>>   create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c
>>   create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h
>>
> 
> [...]
> 
>> +static struct mlx5_fs_bulk *mlx5_fc_bulk_create(struct mlx5_core_dev 
>> *dev)
>>   {
>>       enum mlx5_fc_bulk_alloc_bitmask alloc_bitmask;
>> -     struct mlx5_fc_bulk *bulk;
>> -     int err = -ENOMEM;
>> +     struct mlx5_fc_bulk *fc_bulk;
>>       int bulk_len;
>>       u32 base_id;
>>       int i;
>> @@ -478,71 +460,97 @@ static struct mlx5_fc_bulk 
>> *mlx5_fc_bulk_create(struct mlx5_core_dev *dev)
>>       alloc_bitmask = MLX5_CAP_GEN(dev, flow_counter_bulk_alloc);
>>       bulk_len = alloc_bitmask > 0 ? 
>> MLX5_FC_BULK_NUM_FCS(alloc_bitmask) : 1;
>>
>> -     bulk = kvzalloc(struct_size(bulk, fcs, bulk_len), GFP_KERNEL);
>> -     if (!bulk)
>> -             goto err_alloc_bulk;
>> +     fc_bulk = kvzalloc(struct_size(fc_bulk, fcs, bulk_len), 
>> GFP_KERNEL);
>> +     if (!fc_bulk)
>> +             return NULL;
>>
>> -     bulk->bitmask = kvcalloc(BITS_TO_LONGS(bulk_len), 
>> sizeof(unsigned long),
>> -                              GFP_KERNEL);
>> -     if (!bulk->bitmask)
>> -             goto err_alloc_bitmask;
>> +     if (mlx5_fs_bulk_init(dev, &fc_bulk->fs_bulk, bulk_len))
>> +             goto err_fs_bulk_init;
> 
> Locally (say two lines above) your label name is obvious.
> But please imagine it in the context of whole function, it is much
> better to name labels after what they jump to (instead of what they
> jump from). It is not only easier to reason about, but also more
> future proof. I think Simon would agree.
> I'm fine with keeping existing code as-is, but for new code, it's
> always better to write it up to the best practices known.
> 

I tend to name labels according to what they jump from. Though if I see 
on same function labels are used the other way I try to be consistent 
with current code.
I think there are pros and cons for both ways and both ways are used.
I can change here, but is that kernel or netdev consensus ?

>>
>> -     err = mlx5_cmd_fc_bulk_alloc(dev, alloc_bitmask, &base_id);
>> -     if (err)
>> -             goto err_mlx5_cmd_bulk_alloc;
>> +     if (mlx5_cmd_fc_bulk_alloc(dev, alloc_bitmask, &base_id))
>> +             goto err_cmd_bulk_alloc;
>> +     fc_bulk->base_id = base_id;
>> +     for (i = 0; i < bulk_len; i++)
>> +             mlx5_fc_init(&fc_bulk->fcs[i], fc_bulk, base_id + i);
>>
>> -     bulk->base_id = base_id;
>> -     bulk->bulk_len = bulk_len;
>> -     for (i = 0; i < bulk_len; i++) {
>> -             mlx5_fc_init(&bulk->fcs[i], bulk, base_id + i);
>> -             set_bit(i, bulk->bitmask);
>> -     }
>> +     return &fc_bulk->fs_bulk;
>>
>> -     return bulk;
>> -
>> -err_mlx5_cmd_bulk_alloc:
>> -     kvfree(bulk->bitmask);
>> -err_alloc_bitmask:
>> -     kvfree(bulk);
>> -err_alloc_bulk:
>> -     return ERR_PTR(err);
>> +err_cmd_bulk_alloc:
> 
> fs_bulk_cleanup:
> 
>> +     mlx5_fs_bulk_cleanup(&fc_bulk->fs_bulk);
>> +err_fs_bulk_init:
> 
> fs_bulk_free:
> 
>> +     kvfree(fc_bulk);
>> +     return NULL;
>>   }
> 
> [...]
> 
>> @@ -558,22 +566,22 @@ static int mlx5_fc_bulk_release_fc(struct 
>> mlx5_fc_bulk *bulk, struct mlx5_fc *fc
>>   struct mlx5_fc *
>>   mlx5_fc_local_create(u32 counter_id, u32 offset, u32 bulk_size)
>>   {
>> -     struct mlx5_fc_bulk *bulk;
>> +     struct mlx5_fc_bulk *fc_bulk;
> 
> there is really no need to rename this variable in this patch
> either drop the rename or name it like that in prev patch

Agree, will fix
> 
> #avoid-trashing
> 
>>       struct mlx5_fc *counter;
>>
>>       counter = kzalloc(sizeof(*counter), GFP_KERNEL);
>>       if (!counter)
>>               return ERR_PTR(-ENOMEM);
>> -     bulk = kzalloc(sizeof(*bulk), GFP_KERNEL);
>> -     if (!bulk) {
>> +     fc_bulk = kzalloc(sizeof(*fc_bulk), GFP_KERNEL);
>> +     if (!fc_bulk) {
>>               kfree(counter);
>>               return ERR_PTR(-ENOMEM);
>>       }
>>
>>       counter->type = MLX5_FC_TYPE_LOCAL;
>>       counter->id = counter_id;
>> -     bulk->base_id = counter_id - offset;
>> -     bulk->bulk_len = bulk_size;
>> +     fc_bulk->base_id = counter_id - offset;
>> +     fc_bulk->fs_bulk.bulk_len = bulk_size;
>>       return counter;
>>   }
>>   EXPORT_SYMBOL(mlx5_fc_local_create);
> 

