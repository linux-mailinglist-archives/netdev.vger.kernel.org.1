Return-Path: <netdev+bounces-140896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1486D9B8905
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 03:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73448B2114C
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5DF3B7A8;
	Fri,  1 Nov 2024 02:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sxV0RYgm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2CE17C91
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 02:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730426653; cv=fail; b=LI7I2SnTPNcTsrv+sRU3eazDcq+SXASV+Eiv7R1xxZM5bZxtAkSa4RMt/bsmyW6pWzZ2wf2r49G8FRSgOJ9PeOCZaaJHYpPZOn/Mmgduzq3h8yqQKKXu11naiEZBKdqWUyIJpHlIKTdKxJqdKk4ejoO3fDEFIRi89Ra7rRtpZ8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730426653; c=relaxed/simple;
	bh=7WUVgCKqFu80bQ8doFL0j7Di+Ay7ZdtD5oPCZdozZCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jiboUn6W2f9G5xtsdtHc8c7mCAbXw8L/xRyMxjEyWThMlqSc/acKoujYeQm2zfuk/AjXzPF5HPd4xBdFyInyTnRcgiiqlSw5S/ZyzZblKTp3kWqXr1TOIrhrUw+HtkW7LpITYvvJ4DqY4kawsdvQlhyE/Sb50xNRKguvROqmL9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sxV0RYgm; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGOHF7LbnYO2MNyve7ELHJpBIxz05vaaHc6xIbUZwby+gRi7T7bPaQnHoSpxReThy16PtIoPpH2YTUVqWiQ4Mz7C5cACDg7cti3g4RazrcD4v4sOhsxKXuvuSZvxE1EwKb7Y+uFH0nnyNSruxzjDrrO/yFsASiuf0AzWDw4Lg+5AjD9GTooHXRUt2+Qbe2L/STQw5789W1suDov4EORCNGCh9YC9pJwlqOLsRS4qqUms/MEQabjfDJdXUPCOrPOQx5Kswn5M2ouNR1Rtwm1s5p1FGT7tkddt/Q/lSA6zGa4ank3XR6uQ7NIaFtvvdUmLO+TCzXFgLwMjGjJTY9gvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ay8YkYPlCoSyIotxUQUkzM6GbkOg1Na7GbbkcqBHtYY=;
 b=PgyWh7HaBkfH0mT9q8j5jGgTi3BURbOAsAJpWt0oEvMEjV0RT25PzQaLZ410BPAoM2GMs3AwfwzfH2r9tEFYiYOe82dpjs++IsrWU+FOW614wnvoCCNtIoKREBqZZ/KGenLstP5a6c7HAQNzs0Yta8vUzXx2QQnPyxszt4RXYWnK9wlp9wf4rgBMYRkP5vqbnjaosk9w9Rwz0a55eLO1wox441CsYeLFfLF3ev6Ex2Q+BFIGLiKsca1OX63prNbgnwu3k2oGg9QuBFDdBKW+sgCWm3ow06BRHlrNZge+GoZNu4dF0BuizP7IDdL7y4bPe2n80tqX7VNCfzDSWNZJjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ay8YkYPlCoSyIotxUQUkzM6GbkOg1Na7GbbkcqBHtYY=;
 b=sxV0RYgm+usyJz3oGFSS2PgsOiCRsclSAtueTNcH2m1sVpYveXOb5NTxocyVxIcRqcHSagmlCkjcp5IVk2SQIqkQQ4HCx6vbOC7ovTbN21n1xP4buy7kl6LqWSUXi14kiL5Ez4o4jVHBjsz7v7mXzvt+28vn2ed+gIZ8VQpO7GO1PEpcGT8CvorjBMaFZmCwbcJAP55bGWyFJfSPWbda6Q2dP6tRiWRif/xasuFTbAdbtAf/OhAaDJ1IMvi0O/yTLe+Xko5RSt9nZ2P59lNmdZrnVHLLRwK1NRAupk0qk4YCUddpKSHPkFMnzJgbigNIsG7IcqjxtJMm7JDOXMPWiQ==
Received: from BN9PR03CA0720.namprd03.prod.outlook.com (2603:10b6:408:ef::35)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Fri, 1 Nov
 2024 02:04:04 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::ee) by BN9PR03CA0720.outlook.office365.com
 (2603:10b6:408:ef::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Fri, 1 Nov 2024 02:04:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 02:04:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 31 Oct
 2024 19:03:55 -0700
Received: from [10.19.163.58] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 31 Oct
 2024 19:03:51 -0700
Message-ID: <45cab833-4bf8-404b-8ffb-252671f1d65c@nvidia.com>
Date: Fri, 1 Nov 2024 10:03:50 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bonding: add ESP offload features when slaves
 support
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>,
	<netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Boris Pismenny
	<borisp@nvidia.com>
References: <20241024163112.298865-1-tariqt@nvidia.com>
 <20241031174844.06a5b110@kernel.org>
Content-Language: en-US
From: Jianbo Liu <jianbol@nvidia.com>
In-Reply-To: <20241031174844.06a5b110@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: 9add1ec9-db69-4fd2-a5d8-08dcfa197653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDZWUGYvQVY5d2Y5OUJ6SzQ4NzFmZ0xEeU12Q1FGT3hYV1Z6OGJ6WkRQMFB5?=
 =?utf-8?B?dDlONWNnQW9GcVpuY1dpMXNGUTdsTFJycEdxVjN4eEJDd01rZWpoTkZabFBK?=
 =?utf-8?B?K0RmQ0RWRzIrUnA5WGtYOWYxQit6MTU0WjdJeEN0SGdLd1MrSWU5RVRRV2Na?=
 =?utf-8?B?UFowNlBFTjdQOEhPT25OTUlSYVVOa1pSdUJJVVVFa2UvMFJhRTd2ajFpa2hJ?=
 =?utf-8?B?UStQWGkrdmZMckM5T3FoVXBkRWFiR3RUNjRScFFrSVYwRzd1SjI3WFRpMmI1?=
 =?utf-8?B?RGdtOURnWTF3N0pkeVlDbWQxeEUxY2RCY3VoMllFeWNiOEo2T2xYVkRCTzRl?=
 =?utf-8?B?OEFYbmtLRVkrSEdnTjIzdVdhdzRFSDZ2dmp4OVhHNjc5cTllakRsTW9GMDdv?=
 =?utf-8?B?YUZENEhqYVNhODZDMERJVXBRdnFzYTZHUGhJNWtkWEdMZjZRckpIeGRmS2tl?=
 =?utf-8?B?alRUMXNrNXFzcUs3TUJGRE5QMkVHQlVCUDljQk5Nb0V3Y2UzWDRqa1hwSllG?=
 =?utf-8?B?NjRjelpsNzc1R1hGY05EblFqS3FyK2hLVnBKVEtKb1R0eUk5VHdtNDRDZ2p1?=
 =?utf-8?B?VzBseGtPdEJITHI4dWdDU2RubzhzbFpMR3kyeWNhWTdPMGdMZWI3RWxLcEtE?=
 =?utf-8?B?K3NZajFpb1ZYWXhEYjZGRHRnWnpsMEpkT0NBTXk4Rzl5SENRSktPVUZKZVFT?=
 =?utf-8?B?WnBNQkYvSU1iWWVndTFNM1ZCOVl1WkFkOWY2ZVNhZDJhYSt4cC9qOU5QSXhN?=
 =?utf-8?B?WnlPUDlPeDRmVm9aMVB6QmhIVkdlRk54UWU2QmhmNGFyK2tVa3NqaTFoY21Q?=
 =?utf-8?B?cVpwaEhzOVcrdllUSWRnR3d1WnlpMEtsVGhoVEhOSUNIa2loc2lQUHFhaXhV?=
 =?utf-8?B?SXpjV2d4L293anBHWDdsLzVWTy9mMDRHSER5bEx5SHZoMHF3OWZNaE9SNUFL?=
 =?utf-8?B?VTBjT3YySnkrRERRUGJyMGFvRXdxdWtLdTNoVENtNG9yQ2oxWkpqRUwxUkpY?=
 =?utf-8?B?b1hTVks3M0xScWFVcUxGYzJtWlBBN2pKMXNMdkpwSXFyRlJFZjFKMVJLR0da?=
 =?utf-8?B?WTRkYjRyUm96S0xmTks2YTFLS2tUOTViVm0yQitKT2xQQWttMnNnMERvclpC?=
 =?utf-8?B?aUVzUW8wL3R2cDUyQ1k1cWIyWWJGNDU5Mk00WUdmMllQUDBuREdseTEyNnlm?=
 =?utf-8?B?UXVEVExON0hyc1ZqODRIbnY3UkZzUThRSUdqSVU4blJrUjd4LzUyQW1MaVAw?=
 =?utf-8?B?NEI1d1NaQUg0YzJYaXZwT1RZSFlpUVA3RXFwUHVCbUZNRXlmZklYejJHRTNL?=
 =?utf-8?B?ZUZKM2NRQ3dhQjVDNVFFaWVnN2RpN3drWGFNY2Q1eFc3TURSb2RvdEFRUDZB?=
 =?utf-8?B?KzhTOUhQblhXYmNHcmEvU2t3MC9mMUMrVk14aVhVdkJxSk5kc0lWUlBWdFY1?=
 =?utf-8?B?ejcvNUp4NmpLQ3NBQ3RORUk2SzZKMzljNE5CTGxjNUwvUHI4SVFFVmVINEls?=
 =?utf-8?B?TDg3SzM0aHhGeElvUmNwRTAvQmlacXF4NmtYZFZ0MlRHVUprS1l5eGRmMVhV?=
 =?utf-8?B?NWdhMXh2VjMyaStuMmpQeEdIWW1TMVRzeHZEWVFleThuQyt1bzFnSy9xeVVL?=
 =?utf-8?B?ZlF5RUZxellmM3EzTDFjS2ZkNmNLaVZyaUlDT3F2eUxIbTF0a2dLNzVxY0to?=
 =?utf-8?B?M0FSbko0SlhZUi9Wd1FxZnczektXVnpDVGY0N1B1NUtyR01rMFQxTTJ4NmVk?=
 =?utf-8?B?clhPMDltMHl4K3lsREFDaXh6T1p4YkpRMUNCWEdKMHZmL2VVL3lmSS9ObDBp?=
 =?utf-8?B?NzlYSEtMY1pHWmxydTYzK1p4V1g2Mm1kaG9zTjJFbm1KMGlic1ozNzNKODZB?=
 =?utf-8?B?L0pXNFJIYmc0SkNJR2pVaXprWlloTXB1WDh5dDVmTDBlVlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 02:04:04.4056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9add1ec9-db69-4fd2-a5d8-08dcfa197653
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353



On 11/1/2024 8:48 AM, Jakub Kicinski wrote:
> On Thu, 24 Oct 2024 19:31:12 +0300 Tariq Toukan wrote:
>> +#ifdef CONFIG_XFRM_OFFLOAD
>> +	if (gso_partial_features & NETIF_F_GSO_ESP)
>> +		bond_dev->gso_partial_features |= NETIF_F_GSO_ESP;
>> +	else
>> +		bond_dev->gso_partial_features &= ~NETIF_F_GSO_ESP;
>> +#endif /* CONFIG_XFRM_OFFLOAD */
> 
> Hiding the block under ifdef is unnecessary.

OK.

> If you worry about the no-lower devs case - add IS_ENABLED()

It will jump to done and bond_dev->gso_partial_features is not changed. 
Seems no need to take care of such case, right?

> to the if condition. The local variable doesn't have to be under
> ifdef either (making it more rev xmas tree compatible)

Sure, I will change in V2.

Thanks!
Jianbo


