Return-Path: <netdev+bounces-156236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4A3A05AFD
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5268188858A
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD071F8AF6;
	Wed,  8 Jan 2025 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gSF2scZh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E561F8671
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337884; cv=fail; b=rt4Bfi0p8aGAMMP8GIIFnutbnu7D24QSnqwiDt6U7K93EBJK0mkN+5pobaocf3p1DBlBjLLeBvaP1ZAvr8qJGtzVsQl5uqcPhXDkaVh9ZfpdQr7mYNpNN0ZhWe0kX5SsdnDTXXYRUAopgzvqPy28qBjEiw1w2QNhQPF7lADMVM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337884; c=relaxed/simple;
	bh=tIpsN7eZyfYnBrGQnd0CPxxZCIJuF8PG/aoqt7UJtx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZJDxsNm+wTa0VHpqAwOPITqcDPXA4myyS0SFj8cK1qw3Lc0zuTMTl1fth2kI39f1ZlV5iOlmbAlNv2vbdz5DjCkg/e3s88oeMXA9LrnvP+jvgE41wSmws/V8GE3rcaSOHIZNhcZr4bIXAt2tonieankAI5BQfTZvnobvu6FzFRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gSF2scZh; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9mEqh7QyirwjYtxSWib2IEhFtskODxtF0NQJSYuAWkwJ+3GNjCyIiexC5hZZvVhCjdmCgO9cni6+lUDdWYnGls0sV/OWj/BHXkBDvLkDaeNn82edr0Sobfd49YVnGuTx3quPIg/91uC6cw7IF5VKlxq9L1196wamaXblxivnu0giIeNUVle8ALbSSb6/usPdcW41qk11CgvmWgABNLQLll0L/1PovEVCnTLckhfuMaA9QmxcQVG0+H8w4lrAcjCCsAHeEINwn3wvHvFnBN0n7ycxmjdgx0qZWe9qztkByXnmwSDTCqgb4hjGh0SaW4vE3Q/ob4sIxL/hmuH2tuhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ub3HiIzC0vguuJJGs7C6J/QZy22eTa3VJ+xOC9vH+eo=;
 b=NXuuO/LlUll7u0gYIHxE64h5Ec6IaaVaQ9adnE/al/fktQODisdmqG04RB/JWn2DJlRTNhu+B4spGNcl3iJkz805yY8DUd0q1TfnxCkzMFWuNM/W+lG9l1kW4rObkvayI04iepJFib8XvmrJ84jHzcLDtyXfxH7PaE8j+YXEm5x9vEBcbUJKBn52D4yzQiM3Okp9Mum8rP2F0zPSCcptbAa+JbqrgIDcsnAyGTGrQJi29egZfKNoSXZzGWyCduT2d0LfBOKiok8nSEzQlmlxXX+wreb7I1v2EN7ZWeby2KCQkVQvY0uQUetj0lN+QkTnAwdDoM0YNGD5hK5GHIqEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ub3HiIzC0vguuJJGs7C6J/QZy22eTa3VJ+xOC9vH+eo=;
 b=gSF2scZhMBwgnzE7DJEHGijx22hvv2BXo4xuT8KCID9d87N9B6RvSCoXOr34ajvNAT0kooG38svQCuNNt6goYNprpwfsN2nlkvgj4CUErJeQWSgDNS4VKmFfBaC68HGzNvpQRcoqzVaw+maLCh2TpPVRZkwxHgSkt7DESF+w6+KgU/IgSSQ0g5MGL1wa+f6EX9Kf+i+A7LYQxfcxVyKkykSz8wtrEbhcoMrp7PB+4VtJg4DJLgBbRzqsQ2Ji4+EJ8yy4uLpIdDxFWU4THWmrkRPR3d1o/GHLN6qcAYBmNb71fQg4Nk76JTROdezyeaMFUB9XJ5XNWJgf37+Bq0CWvQ==
Received: from MW2PR16CA0029.namprd16.prod.outlook.com (2603:10b6:907::42) by
 SN7PR12MB7022.namprd12.prod.outlook.com (2603:10b6:806:261::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.17; Wed, 8 Jan 2025 12:04:32 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::f6) by MW2PR16CA0029.outlook.office365.com
 (2603:10b6:907::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Wed,
 8 Jan 2025 12:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 12:04:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 Jan 2025
 04:04:15 -0800
Received: from [172.27.19.172] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 Jan 2025
 04:04:11 -0800
Message-ID: <adbf7344-2d1e-45ff-86da-e2a7299f8c13@nvidia.com>
Date: Wed, 8 Jan 2025 14:04:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/13] net/mlx5: fs, add HWS modify header API
 function
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Tariq Toukan
	<tariqt@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>
References: <20250107060708.1610882-1-tariqt@nvidia.com>
 <20250107060708.1610882-7-tariqt@nvidia.com>
 <0a115ea8-7be5-47db-9fa5-b248bccbcd38@intel.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <0a115ea8-7be5-47db-9fa5-b248bccbcd38@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|SN7PR12MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e683de9-db18-47a6-9227-08dd2fdc9c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjRpNE1qR1dGS0MyeXB2Vkl4TDBnSUtDOTE3aXBobWRNT0pIbzdEWUNYTjVZ?=
 =?utf-8?B?aVNlL3VRWVBxVzRFZEp4S05mbS9XRFdUaGQybXNQZ09EWDBxZVN1ZkRyQ0J5?=
 =?utf-8?B?eE9OSXJ4RC9LWVZFNWpaaUNTZjNKOUZXY1ZyTVEwRkFXejVXYXNieDU3TE1K?=
 =?utf-8?B?U3BiOXo4UUhkSkhvVTlQVkFVYndaejYrTmZzN3dUdG10R01ZZXpaUS9VdVVI?=
 =?utf-8?B?ZGVadFhjckpOZjRWMDVuTEkwTmRyemNXcHgrQWFUMlN3NFhsdjRRVmlSazEv?=
 =?utf-8?B?bjRyai9udzY0OUloVU4zdllyZUVQWUs0Z282T1dZMVVFM2ExWDdmZE9LWnZx?=
 =?utf-8?B?NElDZHFNRG1uUVJPVTdZYW85MlRaNGV4cS9YT3hFd2k1WXgrdDRkdVZuSFJ0?=
 =?utf-8?B?VDhpcHFMR1J2bWJMdVZZdFpJS280bVNST0tIdE5TeXE4cGNKY3o3cnNpUFFL?=
 =?utf-8?B?MXpXUlN6KzRhellXRWpHdW5nZDZyQzYvSUF3a1Qvd05LKzlBRTZFSHRzWjJR?=
 =?utf-8?B?Z3d4Q0xCZzV4a2ZMb0Q0aXJGQTh2RU1ldlh1OVVUa29wcnJ1OGlaNWwwQTR0?=
 =?utf-8?B?aU5lbEpPWVhpV2VSSU04UEdxMjlkMVE0SC9BN3BBVU11cWQ2YkhpdlR2a3pS?=
 =?utf-8?B?Vk9VZ0EyaUZuUWFxSTRPMVhid2VzY2xqS0JlcmthS2VUaldqSFd6bEpRSmhX?=
 =?utf-8?B?LzJweXQzOVJPVG9odlFVcEVoK0dLK0p4S0tmamdCZ1NMK0tVcnR1YzlqNDhP?=
 =?utf-8?B?eVoxcXZvRndnU29zN1pSU0RwR2xnTkJQa3FXcnljTWVwU0VScy9yb1FJTEtm?=
 =?utf-8?B?Z2R5L2JTckkyTHNDOHp2SkhQOFJJM29TTjZQSUNmOSs2QzB5Vzg5dUVIV3Bk?=
 =?utf-8?B?Wml6OHNHblAyR1RTN3RuU0dpSVRoa0RPWSs4NkpLT2FLaEN3d0xVNVdqaDhB?=
 =?utf-8?B?aE9XdndCOVo0OG5INzErdzJhT21lUUYxSElCOEJYMkErcW1wSTRoaXpOcDkv?=
 =?utf-8?B?UGUxU3J2NGdyZTdTTldEREFuY3I0MWNrSCtUMC9CSmthVVFWZnRhZnlLb2xV?=
 =?utf-8?B?MmxkRFVMZ3pFcmg5azhRemw2aGZuOStiTWk1ME56UDFnWEx3UzJyNzg0TnhL?=
 =?utf-8?B?NXNNN2ZjZEsxYmRxWDNCR1l5d2tOZGZTV0hMcUU3NzBHbGI5MnJsbk9LWTMr?=
 =?utf-8?B?dXdEMWd1OUN0Z1R4eWFNd2o5Z2VSaDlaTFRBQkt0Qnc3c1ZkcVZGRlJjalFG?=
 =?utf-8?B?ak1jeGJFcXhrdk1WZU5RTlVVZi9hUWwxUHVwMEF6bi9WclpaNndGNDJKRGp3?=
 =?utf-8?B?TzFqb296V3hya09nTmtmRHFXb1FnUERCekZhS0NCZ24rMGhkQWlUZE5XSkU3?=
 =?utf-8?B?aDl6K1VWdGFHSko2alp0WEVXdzBpM2llYjRYZ3MrdzFpQTJ0Qm42d2QrL0t6?=
 =?utf-8?B?SHdpckd3UkRwcjNUOExVdUZUakVGUlJWSDR0NFNWN3lVeW9ROXFoM0RpQWkv?=
 =?utf-8?B?TFFReElSU2dPcUZ2M2pXNjRDMmdWQzg5Sm1vbitvaStKNzJzQUhKMmxXempi?=
 =?utf-8?B?U05idnA1TmFZaXZsMkdhZXM0VWxFejBseFJLdDN3a2Jtcm1leVBmTFJZZlVk?=
 =?utf-8?B?ZGZjY0ZHYmNoV3pWTDZGTHViblV6YThZaHQzZVNNcStOcDBGZjF1OVhKeXYr?=
 =?utf-8?B?M1E1b2hHLy9GdW5YNWVuOC8xbysvbE10SFdXUXljNm5MajF5Y2I3NEpjcld4?=
 =?utf-8?B?TmZTR2hOd3dENEJhMHJNZFduanExakRrb1hJZjJJOWZ0ZmNBYnNSc3FGK3dq?=
 =?utf-8?B?bDVOM3NXc2dKNHNoM2VPVGowTENyYkpleWI0V010ODFXNnA1Tm00dGh3UnBy?=
 =?utf-8?B?aWsvczZwUVlCKzIxT0hnZVhxLytpdGUvbDQ3REJESTROVzhlYTk1dk55b0Vm?=
 =?utf-8?B?Zy8vZ0w3TFpGNUpZV2tBU1FmSXY1Umc0SmdqSGp2OWZmekVNdXNtYUkyQnNS?=
 =?utf-8?Q?wNsinqrEiW+DuVwtgPUru7pU6t2EBo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(30052699003)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 12:04:31.4720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e683de9-db18-47a6-9227-08dd2fdc9c31
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7022



On 1/7/2025 2:09 PM, Przemek Kitszel wrote:
> 
> On 1/7/25 07:07, Tariq Toukan wrote:
>> From: Moshe Shemesh <moshe@nvidia.com>
>>
>> Add modify header alloc and dealloc API functions to provide modify
>> header actions for steering rules. Use fs hws pools to get actions from
>> shared bulks of modify header actions.
>>
>> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
>> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
>> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>   .../net/ethernet/mellanox/mlx5/core/fs_core.h |   1 +
>>   .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 117 +++++++++++++
>>   .../mellanox/mlx5/core/steering/hws/fs_hws.h  |   2 +
>>   .../mlx5/core/steering/hws/fs_hws_pools.c     | 164 ++++++++++++++++++
>>   .../mlx5/core/steering/hws/fs_hws_pools.h     |  22 +++
>>   5 files changed, 306 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h 
>> b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
>> index 9b0575a61362..06ec48f51b6d 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
>> @@ -65,6 +65,7 @@ struct mlx5_modify_hdr {
>>       enum mlx5_flow_resource_owner owner;
>>       union {
>>               struct mlx5_fs_dr_action fs_dr_action;
>> +             struct mlx5_fs_hws_action fs_hws_action;
>>               u32 id;
>>       };
>>   };
>> diff --git 
>> a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c 
>> b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
>> index 723865140b2e..a75e5ce168c7 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
>> @@ -14,6 +14,8 @@ static struct mlx5hws_action *
>>   create_action_remove_header_vlan(struct mlx5hws_context *ctx);
>>   static void destroy_pr_pool(struct mlx5_fs_pool *pool, struct xarray 
>> *pr_pools,
>>                           unsigned long index);
>> +static void destroy_mh_pool(struct mlx5_fs_pool *pool, struct xarray 
>> *mh_pools,
>> +                         unsigned long index);
> 
> usual "please add your suffix" complain

OK

> 
> sorry for mostly nitpicks, I will take deeper look later
> 
>>
>>   static int init_hws_actions_pool(struct mlx5_core_dev *dev,
>>                                struct mlx5_fs_hws_context *fs_ctx)
>> @@ -56,6 +58,7 @@ static int init_hws_actions_pool(struct 
>> mlx5_core_dev *dev,
>>               goto cleanup_insert_hdr;
>>       xa_init(&hws_pool->el2tol3tnl_pools);
>>       xa_init(&hws_pool->el2tol2tnl_pools);
>> +     xa_init(&hws_pool->mh_pools);
>>       return 0;
>>
>>   cleanup_insert_hdr:
>> @@ -81,6 +84,9 @@ static void cleanup_hws_actions_pool(struct 
>> mlx5_fs_hws_context *fs_ctx)
>>       struct mlx5_fs_pool *pool;
>>       unsigned long i;
>>
>> +     xa_for_each(&hws_pool->mh_pools, i, pool)
>> +             destroy_mh_pool(pool, &hws_pool->mh_pools, i);
>> +     xa_destroy(&hws_pool->mh_pools);
>>       xa_for_each(&hws_pool->el2tol2tnl_pools, i, pool)
>>               destroy_pr_pool(pool, &hws_pool->el2tol2tnl_pools, i);
>>       xa_destroy(&hws_pool->el2tol2tnl_pools);
>> @@ -528,6 +534,115 @@ static void 
>> mlx5_cmd_hws_packet_reformat_dealloc(struct mlx5_flow_root_namespace
>>       pkt_reformat->fs_hws_action.pr_data = NULL;
>>   }
>>
>> +static struct mlx5_fs_pool *
>> +create_mh_pool(struct mlx5_core_dev *dev,
> 
> ditto prefix

OK
> 
> [...]
> 
>> +static int mlx5_cmd_hws_modify_header_alloc(struct 
>> mlx5_flow_root_namespace *ns,
>> +                                         u8 namespace, u8 num_actions,
>> +                                         void *modify_actions,
>> +                                         struct mlx5_modify_hdr 
>> *modify_hdr)
>> +{
>> +     struct mlx5_fs_hws_actions_pool *hws_pool = 
>> &ns->fs_hws_context.hws_pool;
>> +     struct mlx5hws_action_mh_pattern pattern = {};
>> +     struct mlx5_fs_hws_mh *mh_data = NULL;
>> +     struct mlx5hws_action *hws_action;
>> +     struct mlx5_fs_pool *pool;
>> +     unsigned long i, cnt = 0;
>> +     bool known_pattern;
>> +     int err;
>> +
>> +     pattern.sz = MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto) * 
>> num_actions;
>> +     pattern.data = modify_actions;
>> +
>> +     known_pattern = false;
>> +     xa_for_each(&hws_pool->mh_pools, i, pool) {
>> +             if (mlx5_fs_hws_mh_pool_match(pool, &pattern)) {
>> +                     known_pattern = true;
>> +                     break;
>> +             }
>> +             cnt++;
>> +     }
>> +
>> +     if (!known_pattern) {
>> +             pool = create_mh_pool(ns->dev, &pattern, 
>> &hws_pool->mh_pools, cnt);
>> +             if (IS_ERR(pool))
>> +                     return PTR_ERR(pool);
>> +     }
> 
> if, by any chance, .mh_pools was empty, next line has @pool
> uninitialized

If .mh_pools was empty then known_pattern is false and create_mh_pool() 
is called which returns valid pool or error.

> 
>> +     mh_data = mlx5_fs_hws_mh_pool_acquire_mh(pool);
>> +     if (IS_ERR(mh_data)) {
>> +             err = PTR_ERR(mh_data);
>> +             goto destroy_pool;
>> +     }
>> +     hws_action = mh_data->bulk->hws_action;
>> +     mh_data->data = kmemdup(pattern.data, pattern.sz, GFP_KERNEL);
>> +     if (!mh_data->data) {
>> +             err = -ENOMEM;
>> +             goto release_mh;
>> +     }
>> +     modify_hdr->fs_hws_action.mh_data = mh_data;
>> +     modify_hdr->fs_hws_action.fs_pool = pool;
>> +     modify_hdr->owner = MLX5_FLOW_RESOURCE_OWNER_SW;
>> +     modify_hdr->fs_hws_action.hws_action = hws_action;
>> +
>> +     return 0;
>> +
>> +release_mh:
>> +     mlx5_fs_hws_mh_pool_release_mh(pool, mh_data);
>> +destroy_pool:
>> +     if (!known_pattern)
>> +             destroy_mh_pool(pool, &hws_pool->mh_pools, cnt);
>> +     return err;
>> +}
> 
> [...]
> 
>> +static struct mlx5_fs_bulk *
>> +mlx5_fs_hws_mh_bulk_create(struct mlx5_core_dev *dev, void *pool_ctx)
>> +{
>> +     struct mlx5hws_action_mh_pattern *pattern;
>> +     struct mlx5_flow_root_namespace *root_ns;
>> +     struct mlx5_fs_hws_mh_bulk *mh_bulk;
>> +     struct mlx5hws_context *ctx;
>> +     int bulk_len;
>> +     int i;
> 
> meld @i to prev line, or better declare within the for loop

OK
> 
>> +
>> +     root_ns = mlx5_get_root_namespace(dev, MLX5_FLOW_NAMESPACE_FDB);
>> +     if (!root_ns || root_ns->mode != MLX5_FLOW_STEERING_MODE_HMFS)
>> +             return NULL;
>> +
>> +     ctx = root_ns->fs_hws_context.hws_ctx;
>> +     if (!ctx)
>> +             return NULL;
>> +
>> +     if (!pool_ctx)
>> +             return NULL;
> 
> you could combine the two checks above
> 
> [...]
> 
>> +bool mlx5_fs_hws_mh_pool_match(struct mlx5_fs_pool *mh_pool,
>> +                            struct mlx5hws_action_mh_pattern *pattern)
>> +{
>> +     struct mlx5hws_action_mh_pattern *pool_pattern;
>> +     int num_actions, i;
>> +
>> +     pool_pattern = mh_pool->pool_ctx;
>> +     if (WARN_ON_ONCE(!pool_pattern))
>> +             return false;
>> +
>> +     if (pattern->sz != pool_pattern->sz)
>> +             return false;
>> +     num_actions = pattern->sz / 
>> MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto);
>> +     for (i = 0; i < num_actions; i++)
> 
> missing braces

Ack
> 
>> +             if ((__force __be32)pattern->data[i] !=
>> +                 (__force __be32)pool_pattern->data[i])
>> +                     return false;
>> +     return true;
>> +}
> 

