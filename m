Return-Path: <netdev+bounces-156370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48691A062B4
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E3D3A720B
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634F11FF7AA;
	Wed,  8 Jan 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ulxOULlw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30901FF1D5
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355288; cv=fail; b=j08nsrjNvxnyhf2Rn1azvlC/Ts7lNERrwYKAcbZBmN0+aecKodAcj3MJAvc+mOzveRLpZ+LnZ5zTnsikLeQK0K2yoUqMSdD5w7Khs7dh09pHx2Q64jvibjh55t+t62slnqNzIE9O4ucHJwZQ2ciClSvF1YphYABXadXe5QlhQMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355288; c=relaxed/simple;
	bh=LiLOioEz7DxqH2abctP1pZp/BrxPPJhf+V0oQZcOoNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=af69UB2hiTdXZ3l/xSkZCWFiT81g6QbRwXjAYmC+N+sZKhEqFmms/KoDcPizH7EMugDpeo8RJs/KiqmPIT+/JwkBq47BRrfHee2lqTL0uEs/D1qxqOVnGxjhyhgo7ibo2I8B1DVsFj2zv3W6k00pnApixgZxS4N62UG32Ys4spg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ulxOULlw; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djY/fY+haChP2fJ+1bO5pHSWvtYaRWR3UeYuq6lxqvfNzJCAlxT5IvL4hvXSstI8LXnTedE9S44AT6beJ50eulbVjm73AqL31F3EZ8MZplo1O/i1lO3l7oyqWqLEbYXMJsy4hZBQUxFGXBOh8AcDUaZbfMVgT3KaOukEyubf89n3AspBFOV+yECmTuEMN26Zr/+a4DlSgMxM6Ea37k7UusbuJtWyIFTC69WExD7eNbew2wd6pzS0CGx1SzCJ6ePeDtubORsAFwUZrDZTGfI6xnPHqHJtDbiLJeaf7mTl7R0VZefjSXZI7ck5VNGk94mpfzTIs2STn5ZBxEuHE9OZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rY5/PfTtnqkxRccRpYCJVUhuf+Q7UIybbtQ9xoXXXVA=;
 b=PwWUuquUBIvYTD9j7rLYgI+NG/gTZ4vzEazd1Ts2zbDjWIebpW9b9wzHKBxCyHBGnArfpo4v9ZuEBrvf7s8Hw2tJ4HOz3hoCLRPP7GMCPb3CmtUlsD+y1ECWVzTx3GEW3RFuDZWsMOZX8KvVw2j/jaqyhjg+C3kquGElZ4rrfjfkUkQLRCT4wTfjBU+Iy41/wzyhz4O+SrEMbkVAmJ0+0L5jFWUsE1gnChdCedWCNmHu2PHamxEslk0EIEMStlsM74YQp1AaVO2Oq/u3IqxKgGODQFyzZSCb812vwL7yYNNf0OMMc3zhqUNTNNqo2vxYU6dum4f/Mspx08nnX7vsaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rY5/PfTtnqkxRccRpYCJVUhuf+Q7UIybbtQ9xoXXXVA=;
 b=ulxOULlwCYOea8f9KRjSvJYZlydtxDYX3l/ZjgMoA5/DKxF5nguda+o6uln5VPkyhktqKEj6McOdo5+jqM9pd2VzhPGXfPElj0zB3uQG+PulzhBZvm43ZgdnINv15gqYgzUJptdm4W9q1fKXPxqwIh/OkDk/5ZnXdevvqcRkZ4uAiTV6/RnO0cnBI5I3vnXKAubjoj2yT6Ub6dlIG441AOHCl7xflI4AhZzHpGKM6242aND4ijRBn4cLco5aYvehUCFB4k1kYMkobRoJfz8u13p9vrftOfRkQaJWdRLhNlQjR8gIaxOiWdpoYD0WXpEHSlQdVxv2Hgq5enMuy0uJJA==
Received: from CH0PR13CA0001.namprd13.prod.outlook.com (2603:10b6:610:b1::6)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 16:54:38 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::4f) by CH0PR13CA0001.outlook.office365.com
 (2603:10b6:610:b1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Wed,
 8 Jan 2025 16:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 16:54:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 Jan 2025
 08:54:25 -0800
Received: from [172.27.19.172] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 Jan 2025
 08:54:21 -0800
Message-ID: <03c22e72-5cfe-4261-8572-b9951a92d224@nvidia.com>
Date: Wed, 8 Jan 2025 18:54:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/13] net/mlx5: fs, add HWS modify header API
 function
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <20250107060708.1610882-1-tariqt@nvidia.com>
 <20250107060708.1610882-7-tariqt@nvidia.com>
 <0a115ea8-7be5-47db-9fa5-b248bccbcd38@intel.com>
 <adbf7344-2d1e-45ff-86da-e2a7299f8c13@nvidia.com>
 <9a961e7c-1702-400b-89ed-4dcb2d1ef81e@intel.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <9a961e7c-1702-400b-89ed-4dcb2d1ef81e@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fdb1a5b-573f-41bb-6858-08dd300522dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDlmVWJtMlgzemNTcWNmRFd1YTdLemcyd3ljRUtpTGtaM1E4bzdSTHVlL2tS?=
 =?utf-8?B?d0JBZGphWDFJNVNMY1lJSmozbmRHSVBRNmQzSHhjTFZjSmlOaGpqNlNWbDdv?=
 =?utf-8?B?d2c4cGUxR0twSEFYbnNQNC96Y3R0d2hPMlpGVXlEbW56bm13SW1oSDNicXZt?=
 =?utf-8?B?bzBsM0JqYTJndkhiSlVrdXMzQmw1Z1l5OTQveUIzZjB1d3IvT0xuRzhLNmQ2?=
 =?utf-8?B?dDdYNWpkWkpEd1BXeWJJeGhUNTZLZVBueDdXNzhpdk5jUHQ4aVlJNnlna0tT?=
 =?utf-8?B?dytvR1RUSUNERGR2d0xWY0tKb2tzSHF1QmVFRVRnYk5SUytEZ0FHbGtPcDNq?=
 =?utf-8?B?TDh0S1d4S0pjaDU2UDhPbktIYjlqb0dML3JCOWs2MGxkenV2MUxqVzc5SnBK?=
 =?utf-8?B?bmtCYk83MHZZb2hRLzVGS20yOEoxRWM0YUpVUFJ2SUJNZ2xYTCtlcWIxRkdR?=
 =?utf-8?B?aC9qMGw2U3gzOGRhRXljL0JMZHNWdk5qNUZQcFp3Yk1BcWEyYlJiSHVTd29v?=
 =?utf-8?B?UkVZQ2V3Y0taM3dXYktvdGpkeVZiNFZzL2JrNTh4WUJPTFBmaUttSWNRZFZy?=
 =?utf-8?B?OTdueDhkSDN0am9Qc0hqYXloVURrV0prQytKdGJiZjlzNC9VODJIV1AzZ3N2?=
 =?utf-8?B?UDhqTUxxYzdZMnNRYThnaTlNNDliYWlXSzhWZU9xaTBUbW1uWGowK2RseGZ0?=
 =?utf-8?B?TlJKRi9NVFFaTC82TjBPZG9yUmFvek1CQkEwY3l0S2E1ODNOUkJrSUR5SDlT?=
 =?utf-8?B?cXRvVG95ZlZtMjExSW5GRDRISG9mcXhaTHA1a0RmQkxTalVjbVVreG9NbWxi?=
 =?utf-8?B?bXV3UTY5RnIrNm9qTlR6dWxOVUpVczYvQXZjd1diZ0RsUm8vQTJsUFlLVkNy?=
 =?utf-8?B?WkgrUjFHcHZrZDVNVUZaWU5FREsvcGdNWGlaNHFsclh3OExITVdsaStQUml6?=
 =?utf-8?B?MXNNUW1DWGF6NEMyZnhYdVgzOHYyMlFtTGRBdHllUWhycTFLMllXTnE0ZVVp?=
 =?utf-8?B?cFdpU2Z2V2kycG96T2hmL3FTWVl6aVA4c21hNHBESzg5VHROTkZpeVN5L0lj?=
 =?utf-8?B?RUt0cDdNVTlDdnc5bjBxTktlSXVMRDF2MHYvcElBRC9lV0pGcGpON2o1aFh1?=
 =?utf-8?B?OVFlMi9oUVhncTZFL3RoaWVKa0I0aDFBZ3pBYVZhekFBbEwyRzVGV2FlQXRt?=
 =?utf-8?B?ZkZHN0d1QUgxZVJIRVEvdHhkNUFGVmYzaG9mQmxCWW1UVFk3M2FTSU5jRWU3?=
 =?utf-8?B?K2c3KzVSVklQZzVERmRkSHRwM1lNd2FpWTBBNVJEQVpCTkhzN1pVMWUxSUZ1?=
 =?utf-8?B?c2c1MDVNR2NyZCt3Uk9ieXZoRWV2NE1vM0JYRVAxZnJGaHVWemdRbWthNmE5?=
 =?utf-8?B?eXhHdTl1VVRZN1BoT2xhTTA1OXhlZ20xU09OMno1eFhRb1RpTm9KblpGN0Ny?=
 =?utf-8?B?OU1kcGpHSGIyZUVFSm5kRzcwR3VGSFFNZ1l3YVB0RnlJeDhqeHFhY3R0N1By?=
 =?utf-8?B?Wjk4K3ZNZjVZdWlkaHlFaWxFaHZaZ3FpU25ic3dCZUNBdXFOdG9VeERUc0lq?=
 =?utf-8?B?ZlZ6QzRlc3QwemhmLzZJbmFzbUsrUnFId0creXdBdW5mSHJ4VWlhWjJYYWov?=
 =?utf-8?B?OTJFdUpXTTJrQ1lvQXNrR0k5TVRmZlZrZEFLRVJhNEhkbE5wQzVXVkF2SmMr?=
 =?utf-8?B?aW5WZSt6YTdWcVRqcHB2ek5zaVlkcHFlNDEweER5UWNFMDlQY3M0TG5tMjAx?=
 =?utf-8?B?YUREeS9wTUZWU1I3c2hnRFFraFN5MVc2bnRJMEY4UmxCY0E1TFJ3cFZmUmJR?=
 =?utf-8?B?NjN2NjFFaG5mT3VDamgxditPNXNpYklSWGJzaERQeFU0RXB1NndaSFRHNyto?=
 =?utf-8?B?RTg3OGdQTXRQOGJvOFhmRmFNTmFWaHNWNFY3ejlCdVZlT2Nhdng0Ujd6cUtr?=
 =?utf-8?B?N2JXRDBiV2NaTEF0ZmdDek8vYis1dkVnZ1JZckFNTFFJR1VFLzYrMVB4MENo?=
 =?utf-8?Q?fwQE0atOhA5PhReLPtoOUY+L71jOqM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 16:54:37.2821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdb1a5b-573f-41bb-6858-08dd300522dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840



On 1/8/2025 4:58 PM, Przemek Kitszel wrote:
> 
> On 1/8/25 13:04, Moshe Shemesh wrote:
> 
>>>> +static int mlx5_cmd_hws_modify_header_alloc(struct
>>>> mlx5_flow_root_namespace *ns,
>>>> +                                         u8 namespace, u8 num_actions,
>>>> +                                         void *modify_actions,
>>>> +                                         struct mlx5_modify_hdr
>>>> *modify_hdr)
>>>> +{
>>>> +     struct mlx5_fs_hws_actions_pool *hws_pool = &ns-
>>>> >fs_hws_context.hws_pool;
>>>> +     struct mlx5hws_action_mh_pattern pattern = {};
>>>> +     struct mlx5_fs_hws_mh *mh_data = NULL;
>>>> +     struct mlx5hws_action *hws_action;
>>>> +     struct mlx5_fs_pool *pool;
>>>> +     unsigned long i, cnt = 0;
>>>> +     bool known_pattern;
>>>> +     int err;
>>>> +
>>>> +     pattern.sz = MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto) *
>>>> num_actions;
>>>> +     pattern.data = modify_actions;
>>>> +
>>>> +     known_pattern = false;
>>>> +     xa_for_each(&hws_pool->mh_pools, i, pool) {
>>>> +             if (mlx5_fs_hws_mh_pool_match(pool, &pattern)) {
>>>> +                     known_pattern = true;
>>>> +                     break;
>>>> +             }
>>>> +             cnt++;
>>>> +     }
>>>> +
>>>> +     if (!known_pattern) {
>>>> +             pool = create_mh_pool(ns->dev, &pattern, &hws_pool-
>>>> >mh_pools, cnt);
>>>> +             if (IS_ERR(pool))
>>>> +                     return PTR_ERR(pool);
>>>> +     }
>>>
>>> if, by any chance, .mh_pools was empty, next line has @pool
>>> uninitialized
>>
>> If .mh_pools was empty then known_pattern is false and create_mh_pool()
>> is called which returns valid pool or error.
>>
> oh yeah, sorry for the confusion!
> 
> BTW, if you don't need the index in the array for other purposes, then
> "allocating xarray" would manage it for you

Yes, I see what you are saying, it can work here.
But in this case I need the loop to look for the pattern anyway, so once 
loop ended without finding the pattern I know what is the next index 
instead of having xa_alloc() to find next index.


