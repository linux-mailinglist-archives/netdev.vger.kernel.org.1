Return-Path: <netdev+bounces-189305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ACFAB1906
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5D41C44B66
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF7422F767;
	Fri,  9 May 2025 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vDbV1Jt0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3E322B8C6;
	Fri,  9 May 2025 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805283; cv=fail; b=bKtHzUL+/lND2Ayhqr8L4EDth5doGYRSfBYoNQx0K+Z1rYg/bqgmG1tq0UKCVbn246sWu7FcQ0MzyyB+MNQXCkGvU+NYIeuNjjjYR0BZnys0zwh/TuITQll4xeWWo4rNyShgeln1EBV/mXvN4WqbjOE7x7ivStwrJpYQFv3fLUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805283; c=relaxed/simple;
	bh=AZBq6Z2Xe0vo4wZK0hsUuN7FVbsYXuUGdzo/xVgT4us=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=isnnDaBzXDgnLK4d2ril3Z7eJE4h67Qcvp23YArxkA3CrL39eAPJoZbFvX5cvC7O8If600IEVJM8TZZ+CTbz6znev7o+3a+by+iOwc0/LR+iMs+3TpOps2iHY2hrAWxnhwsLOq5R86ls1V1tAjE4LP0goPkxScG/tHi0BUTSc7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vDbV1Jt0; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+aLmbqE8mNRGlwP35v3wnLixGR+7R+R2qBwqf7E+pCyHCz3U3NX4EyEv0MQJiTQVaraJ09o8C1hBiecUOmB/rQ9Mpp2AvEDglkByYCHORP4p+rDn7Vli6dq+rOSNTMuqUKFZO0qhfW9ww7YVW/c6eaW6bR+DUC0mbGb9HRK0dnka6GVfKO5PF1M/nkGCnP13rJKGmk4Ff0Vq2pxu15P4HPgZLlsBBa6mGXwfuyzpDtMnnmGkBUsZKRGAyGFI8uL2wFFRfx5kMaRuIiUs2WDVxLHZP7OVixlSdyQkAfS54urhD6N7Wc+OtST05fIJuDxeMpPb+p4K/0XTJLHOzrf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3C9PdRAbnryFz5NlwHgd2WJTIXSY8oOlPMQpleKW3Ns=;
 b=PdsgDBV7mucMpydmjFYn89+WxNTD5RazTXp0udlaKLQdeECqk+xAaT0kUMe665Rt/wROuLe94tUKTKqvRO3+aAfE/bVmiSHCYKds+yanI/KQlHmGggbcPYnIY5h99VrPvNG8XF36+w8moXO/dIoDkv7PjZamWREg37Th/VDztqvGxiEhG9xUSrFX53XLyJOJcNoxKmYtn8jUuODRWEQl8+ZiZWoK+IkCyzKPKlTiKFq/5Wgh/HAAcCQnyUEZnM3b27+oE2qgoyHtvPYMNfiWyUmC6SEJ3A+iyM2GW4FR7+zrkUUS9RtiWuRSP2m6wKhXOI563rtRnj1ocE1TQNfvUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3C9PdRAbnryFz5NlwHgd2WJTIXSY8oOlPMQpleKW3Ns=;
 b=vDbV1Jt03Xz1JMTySOa2m6KPLiD7CCplMar1vUi67znEh7hawOz59m4hOUfSzB1qvIH4Zc5s7OoOEwU3A44QCPMyUwHE1Pn/Za4kSo5qlBk0mP81ySGghW+NbM8AOpc2l8p92vihdixgeBplYheNHlel/tsmsS3+qLMG4KkvBlI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by SA3PR12MB9160.namprd12.prod.outlook.com (2603:10b6:806:399::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Fri, 9 May
 2025 15:41:15 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%4]) with mapi id 15.20.8722.024; Fri, 9 May 2025
 15:41:15 +0000
Message-ID: <65c5d5a3-ccfe-4a39-89ec-b0430fed2709@amd.com>
Date: Fri, 9 May 2025 21:11:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] amd-xgbe: add support for new XPCS
 routines
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shyam-sundar.S-k@amd.com,
 Sudheesh Mavila <sudheesh.mavila@amd.com>
References: <20250428150235.2938110-1-Raju.Rangoju@amd.com>
 <20250428150235.2938110-4-Raju.Rangoju@amd.com>
 <20250429193732.GQ3339421@horms.kernel.org>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <20250429193732.GQ3339421@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0241.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::12) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|SA3PR12MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc6d6e4-cb64-49cf-3d7d-08dd8f0feef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cU5TNTFUbUY1bHJocjg1YWNuQkZzeVhWMlZUbWl6cWlTM2NIb2E5Y1Z1TW9w?=
 =?utf-8?B?bnlJcy90WVljd1FvOVdMejJsTTZwUHZTNVRnaFhPemUxYWFZbWx3T0VuVGdC?=
 =?utf-8?B?cEV3Q3ZYRXZiMjc4V0JZY0VxcGZVMmQ2WWFJOXdoRkNkTW9KVjRXT3BLd3ZY?=
 =?utf-8?B?a2tjWEx6bDR3dlJFWitCTmRuZEpXUitld0p5K29yQ284eVZ5aWVmc1BMRzZv?=
 =?utf-8?B?RXVDVG5RM0Z1K2ovN3pNY0VkVXNtRmp3V1FLR1VzaU1vTEhkb0xncjBPZTYy?=
 =?utf-8?B?amFINFhXeGtBOXpRWU9zY3BNeDN4MFdsUGJWMU12aFd2M3I3Kzd4a09ON3NJ?=
 =?utf-8?B?aENTRDV3UmZ1YTRJa0dJWG9ERlMzS2JQc0lON2JpQUt3eDJsZnVUTkszQVF6?=
 =?utf-8?B?U3hDbk5QTzBvSlZmcmdHSDdhZTVqWVEySUREZVpiSWFZZ2hGZnl2Nml0SkVG?=
 =?utf-8?B?cXVqUVo3d2E4aGhHaS8yb2Q5Skh5YnVod3ZYQUdUZUhQYTBZeTMvakQySm91?=
 =?utf-8?B?dVc3eGw2dWVTYkVSMVN6Q2FYUUE1dVJ1a1hZNVZhODlDTGxvRkFtZGhVTExm?=
 =?utf-8?B?OHRCRjNZN1BzOGxEZnJaRDQ4VXVEcVl0WVJFdmNQeHhDakFkR0QxQ09uZURN?=
 =?utf-8?B?ZGZ0RmsxN3gxSkYycGE0ZlNNcEVLcnYvRHFhbHpUeGlWZFVnRkxINWtGTW04?=
 =?utf-8?B?VWhPTU1UUXBmbFY0RzFvNy9vVFpMZzhuaXBCNFV1NThRR3BOVFFSWU1HRU5Q?=
 =?utf-8?B?bm90UmVNM2FiSC9oUy95YW0rM1UwYzdQakx4RXpsRmtRVi8ybU1VSktmaWo1?=
 =?utf-8?B?VWJLc3VSdk13K3Jzdy93U214bWJNMzc3K01VM2UrYWwzL2FKWlF5NnlTSEdP?=
 =?utf-8?B?MnBWWm16UEx0aitYaDlYVnlRK2UrVUJNTlowRDlDeGxpRTBBWDBvMXo0ZnNC?=
 =?utf-8?B?UjhqWGxsNVlmbkE5bUJFUVZHOFRxWUxOandtaGxvTm80WHRQc2g1V2lWMXll?=
 =?utf-8?B?aVNmVTJheTVMR2tiV250UnpaakFLdmxtV05SRUFYVmpkdm42TS93UWkxRFZh?=
 =?utf-8?B?eVQzbW9NRkgxaUFvejdGMk5vUERRVS9ZbW5way9vS0cyYVV6ZnJLNmlZZllK?=
 =?utf-8?B?WWdCM21sa3FYN3lSaFZZZGhQeFM3TkpuZ2kxTHJ3ejhOa3BqZU5Kak9PbGVv?=
 =?utf-8?B?ZVRtT0NNM3NMeTBVRS9scVozZ0pNN0VpOTVYQWMyaDNBQjRRaGwvSjJ0MmFv?=
 =?utf-8?B?WTVrcG0xREJYZjZTK2xrdTd4bmUwcEpkd2JmSnhWbmMrc01Ja1FibVdnRnBh?=
 =?utf-8?B?QTdHbzZrM0VwM21pSHZyclZOazNSc2FzNWZCSitWUzV2VktOQzB2MkN0OXpt?=
 =?utf-8?B?VkNwamVKbDdBOVRqeHVhOHhvZXgvN3czZTVxMmFiWGJVVHlCM0xVZmM2SWc5?=
 =?utf-8?B?T2twbjhFUXpScUdxZy9RR2M3NS9acDFXb2p3eE4wbGZ3cEF0OS9nQ2dIaUNi?=
 =?utf-8?B?QndMVnN5RDZ0MUw5cFc5Ty9FRS9NSHlMMlRoQWVMV3NhdTVaQVJnY1dRM1hs?=
 =?utf-8?B?VG9BMXBEVjB5U09EL3RNMTdrdTVTUVlJanlFYVBNVTJKQ0FzN0doeiszeG0y?=
 =?utf-8?B?SUFTUXdPbUwxdW85OTFkcEdmOVF1akhhUUtDbUFIMnhvUDA2eDRuTGVVd1dF?=
 =?utf-8?B?Y1VCc3pGVGdkeXdweEdUWFFOemhScTlhTW5QbkRZRmgvbG9vRkxwVVpQaTZj?=
 =?utf-8?B?RTB5MjNBYWhvUDd0d1Zkd3Q4eWNETUJ1VWVJUzFkR3VWMGJzVlZBaGNaNTND?=
 =?utf-8?B?SUE1bHFSWUR1UU1XRmV5dFRYQ0E4VFVYcGxFM2JDRHQxSUtYaWswamRoUkE4?=
 =?utf-8?B?eWFZWWdiM29JdVd1NVNoVElKWEFsRHJLQS9FTDJwSC9GWFFacGlNZDk2dFFU?=
 =?utf-8?Q?xpBsAr3PN/I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFR6UGlWYzBHNUc0cy94ZFJrelFMbHA4TGJyN2V3SW04c2ZERkVUVm11N1M4?=
 =?utf-8?B?Z0pFVmREVUVpMlNIaHpiZ2JWR3RLcnByOU9TME1OMDJGaC9veFdNNnR2QmM1?=
 =?utf-8?B?UWoxSENyMmFzeTd1b3ZoMFJQcnZBa0tiTlM1aWlUYnd6b3FGNW5MRC9WRExJ?=
 =?utf-8?B?SGpzR1E1WVBCOVdUR1pFa3hxUDYyalN5UVI3UExyMkNMS3MvMEZuckVmYi93?=
 =?utf-8?B?dlFpem90Nis2dkY1SjBNMlFKU0V0cTJrZnBtcnZjS1Y0MjhRb2FENFBJWW1G?=
 =?utf-8?B?UDJrOURXWnZpeXM0MGhqenBROGU1Q3dSWVhvWDIwVXZjSmZjNHFKTEllUVAv?=
 =?utf-8?B?TjdEdkZGbmVjbU9UTjRObTFPQVV6dWNhc2VHRUpzQzNsbGkrYmR6SnVlSnY3?=
 =?utf-8?B?bHg4R0t1OXZGcXNpUXM5NlhqK2F2NnE2Tk9rWTJtVjdJWmhpU3hENitkLyth?=
 =?utf-8?B?Z1g1UW1UVkRXMjRRTHI5YWJMRmxaY0NzV2FYY2VZc3M4THhSY0RMTDRYalBM?=
 =?utf-8?B?dVZPZDAzaTJTUVgySmhvLzFTLy9lWmtST3FyWEVYYlIvVVFCbFVqeXpMRmts?=
 =?utf-8?B?QkVKMHlFU00rTVlmV2R5TnBtbGFYMGtac3FjQUFqQnM2a2piTytWaUxQcGJG?=
 =?utf-8?B?RXU4QUtBL09KL0pFVlZEL3VVYzhQM3U3ZWs3bVZlMElFME93SDk2NkdndXR0?=
 =?utf-8?B?TjgrcW12dUV1R3I0Z2s3SDM0cVZieWExSzBjZkZLaGpCczVvZmpqL1JyMHdr?=
 =?utf-8?B?NTM1Z1Z4MzdXZkVGYmROTkl3djJDOHJoRnEzeEZiNmRnVFJCVU9kWVlTS2Zt?=
 =?utf-8?B?eVBueFZuWVhVVVlaVnhLS2RuM2FlL0RpU3E2WVRIcmpncnUycmd5RmpXbWlu?=
 =?utf-8?B?SVpSOXA4cUdzWmNuOHR1MkxFMVdBRFFYcWJYTnFUUDV5OXB1MGM0NTBsamlJ?=
 =?utf-8?B?Y2VkLzIyNFFHN2ltNDg4RUZEbzBac1VXN2lHcVE3SzFnTEVVditwWnB2aUNy?=
 =?utf-8?B?Yk9IeDJsb0lmbWlHZnJyNkpRS09GQTEwczd2Y2NlZjdyVGk5cmJrVVk0bHUv?=
 =?utf-8?B?L0VDbUkyUG0xWFZ0Y2xqZW5IUzlHejkrbThscURBdHRYRXBrUkljczRFYXJj?=
 =?utf-8?B?NnRnR2dET2FPMGMxVGROMlBFUHdSRk15allKNHQzNysrVjlzR1RzTU80T0Ny?=
 =?utf-8?B?bjZIREtwb1FpQ2M4bGNsUG5JZmJmOXZsbkxDVkc4bTh5WEVoMG1uN2xRUm96?=
 =?utf-8?B?ZlkwYm10NGZIWlBQWUNReTBsTHo0NjJ1eUM4dy9nUDlOQlZJSGVTaFcyMEVy?=
 =?utf-8?B?SFhNamtZdmMzbDhvL01PM3JVQ2hxRWc1dlRFUHpqM2ZjZHhYVE1XVWJFSWFK?=
 =?utf-8?B?dExqWHk0ZjJSRnhnaG1CVmF2QVJWUWxBSG1DVW9naE5udnVML0Fuek9QWTgy?=
 =?utf-8?B?R1J3VllTMGFWazdwYXgzT2Y3RmZENEdhdTZYemFZN2JCRm9IVHZCbmVlcFBr?=
 =?utf-8?B?dGc4OXlFdGhiY3hSdTJTOXQ1T1Nlcit2eGlDYm1VRmdEeW5vaHpVMHNnUTdn?=
 =?utf-8?B?aDRTZCsxNkNQZzRObDBLQ2tDTzhPbGcyd0RPWUJpR0lPc3g3NnVZQXUxY0or?=
 =?utf-8?B?QW0yQVlqUUpSYm1tYXcyL1N2TTQveUJ1bDc0VENLKzQwNkJkcmNyOEQ0MHhL?=
 =?utf-8?B?eENsdnIxekhBaEhUdktad0pYV2tjNlp5VUJqVGZHcjRQemd1TWJXSnpkVGcr?=
 =?utf-8?B?SWFDWTBSN1IvVmd0L1JiazJWdjA1NUZlS3JjV0M1OEgzMWg2YytiTEFVUEkw?=
 =?utf-8?B?dnIxdUFIMHFkdEt3ekRPbXo3akdkUzR0bjZyc0U5YXJ3bkRnRHBUM1lLdXEv?=
 =?utf-8?B?a2xqRjJpd29HZFpYSGlXKytjbjBxZGxzMWJlVjBKcGRvck9UZHM3a0J1OHJL?=
 =?utf-8?B?ZXJZaWd4LzNMU0t2RFZXcjRRT0lVWWFITW9vTlU4VmREenVFM3A3cERQNXNK?=
 =?utf-8?B?T3JJc1ZZdmtxS0F5S1JqSGRnUWk0ZVllOGMrc0ZsbGNlQnFCQTg4WUVGU1ly?=
 =?utf-8?B?S01LWnhBYnRSZ3c0QnFESEkydmFlUTYwTG9VRFRPV2hwYWVubHNSRUhFWkVv?=
 =?utf-8?Q?05/kWqweqfxb9g2BihYkcxfSN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc6d6e4-cb64-49cf-3d7d-08dd8f0feef8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 15:41:15.4817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JP41VdYQRcXDc8JhguHJFM4dc7P7qbvhQpn6cvvFghVI+/9rRimRrY/uWx4z//4mooGb6W5QYdzUUwqz6C8DDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9160



On 4/30/2025 1:07 AM, Simon Horman wrote:
> On Mon, Apr 28, 2025 at 08:32:33PM +0530, Raju Rangoju wrote:
>> Add the necessary support to enable Crater ethernet device. Since the
>> BAR1 address cannot be used to access the XPCS registers on Crater, use
>> the smn functions.
>>
>> Some of the ethernet add-in-cards have dual PHY but share a single MDIO
>> line (between the ports). In such cases, link inconsistencies are
>> noticed during the heavy traffic and during reboot stress tests. Using
>> smn calls helps avoid such race conditions.
>>
>> Suggested-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> ---
>> - PCI config accesses can race with other drivers performing SMN accesses
>>    so, fall back to AMD SMN API to avoid race.
>>
>>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 81 ++++++++++++++++++++++++
>>   drivers/net/ethernet/amd/xgbe/xgbe-smn.h | 30 +++++++++
>>   drivers/net/ethernet/amd/xgbe/xgbe.h     |  6 ++
>>   3 files changed, 117 insertions(+)
>>   create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-smn.h
>>
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> index 765f20b24722..5f367922e705 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> @@ -14,6 +14,7 @@
> 
> Hi Raju,
> 
> I think you need the following about here:
> 
> #include <linux/pci.h>
> 
> To make sure that pci_err(), which is used elsewhere in this patch,
> is always defined. Building allmodconfig for arm and arm64 shows
> that, without this change, pci_err is not defined.

Hi Simon,

Thanks for pointing it out. Sure, will address it in v3.

> 
> Alternatively, perhaps netdev_err can be used instead of pci_err().
> 
>>   
>>   #include "xgbe.h"
>>   #include "xgbe-common.h"
>> +#include "xgbe-smn.h"
>>   
>>   static inline unsigned int xgbe_get_max_frame(struct xgbe_prv_data *pdata)
>>   {
>> @@ -1066,6 +1067,80 @@ static void xgbe_get_pcs_index_and_offset(struct xgbe_prv_data *pdata,
>>   	*offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
>>   }
>>   
>> +static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
>> +				 int mmd_reg)
>> +{
>> +	unsigned int mmd_address, index, offset;
>> +	int mmd_data;
>> +	int ret;
>> +
>> +	mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
>> +
>> +	xgbe_get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
>> +
>> +	ret = amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
> 
> nit: Please line wrap to 80 columns wide or less, as is still preferred for
>       Networking code.  Likewise elsewhere in this patch.
> 
>       Flagged by checkpatch.pl --max-line-length=80
> 
>       Also, the inner parentheses seem to be unnecessary.

Sure, will address it in v3.

> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = amd_smn_read(0, pdata->smn_base + offset, &mmd_data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	mmd_data = (offset % 4) ? FIELD_GET(XGBE_GEN_HI_MASK, mmd_data) :
>> +				  FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
>> +
>> +	return mmd_data;
>> +}
>> +
>> +static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
>> +				   int mmd_reg, int mmd_data)
>> +{
>> +	unsigned int pci_mmd_data, hi_mask, lo_mask;
>> +	unsigned int mmd_address, index, offset;
>> +	struct pci_dev *dev;
>> +	int ret;
>> +
>> +	dev = pdata->pcidev;
>> +	mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
>> +
>> +	xgbe_get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
>> +
>> +	ret = amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
>> +	if (ret) {
>> +		pci_err(dev, "Failed to write data 0x%x\n", index);
>> +		return;
>> +	}
>> +
>> +	ret = amd_smn_read(0, pdata->smn_base + offset, &pci_mmd_data);
>> +	if (ret) {
>> +		pci_err(dev, "Failed to read data\n");
>> +		return;
>> +	}
>> +
>> +	if (offset % 4) {
>> +		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK, mmd_data);
>> +		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, pci_mmd_data);
>> +	} else {
>> +		hi_mask = FIELD_PREP(XGBE_GEN_HI_MASK,
>> +				     FIELD_GET(XGBE_GEN_HI_MASK, pci_mmd_data));
>> +		lo_mask = FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
>> +	}
>> +
>> +	pci_mmd_data = hi_mask | lo_mask;
>> +
>> +	ret = amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), index);
>> +	if (ret) {
>> +		pci_err(dev, "Failed to write data 0x%x\n", index);
>> +		return;
>> +	}
>> +
>> +	ret = amd_smn_write(0, (pdata->smn_base + offset), pci_mmd_data);
>> +	if (ret) {
>> +		pci_err(dev, "Failed to write data 0x%x\n", pci_mmd_data);
>> +		return;
>> +	}
>> +}
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-smn.h b/drivers/net/ethernet/amd/xgbe/xgbe-smn.h
>> new file mode 100644
>> index 000000000000..a1763aa648bd
>> --- /dev/null
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-smn.h
>> @@ -0,0 +1,30 @@
>> +// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
> 
> Checkpatch says this should be:
> 
> /* SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause) */

Sure, will address it in v3.

> 
> 
>> +/*
>> + * Copyright (c) 2014-2025, Advanced Micro Devices, Inc.
>> + * Copyright (c) 2014, Synopsys, Inc.
>> + * All rights reserved
>> + *
>> + * Author: Raju Rangoju <Raju.Rangoju@amd.com>
>> + */
>> +
>> +#ifndef __SMN_H__
>> +#define __SMN_H__
>> +
>> +#ifdef CONFIG_AMD_NB
>> +
>> +#include <asm/amd_nb.h>
>> +
>> +#else
>> +
>> +static inline int amd_smn_write(u16 node, u32 address, u32 value)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline int amd_smn_read(u16 node, u32 address, u32 *value)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +#endif
>> +#endif
> 
> It feels a little odd to provide these dummy implementation here,
> rather than where the real implementations are declared. But I do
> see where you are coming from with this approach. And I guess it
> is fine so long as this is the only user of this mechanism.

Sure, thank you.

> 
> ...


