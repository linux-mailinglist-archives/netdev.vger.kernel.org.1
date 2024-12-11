Return-Path: <netdev+bounces-151163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3A99ED32F
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 18:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F74162048
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177A91A4E9D;
	Wed, 11 Dec 2024 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hal8MVCa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3DF195
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733937348; cv=fail; b=dKt5peF4kHyS+1ahwLx4Hy6bwoD4jDUgzPceUbRnXwAIuHGWnfDIOcOECAeQZryV7ZxZkrm1eeuhuu4V+t8WpBI/dqegVeD/o+MiSJhUI3vIvUgK5AOiZLUW4t5JFLlxrUMzqwEcfCS5EQkDJ5LGr7XWatxeL2D1m+01LBbDAHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733937348; c=relaxed/simple;
	bh=8XzBr2LZqzbUyE5YUasaqo46s3xZf1xlWwC6k8GQPK4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ezzWVB56D6tb13bOygrxMuXlkss7tWanem2Gi/xQFdf20iu+BBxnI4vhyBiRfmJdHfP9dfPpRPc87cYBhgKss1YY6OMy7FrgxcVU40QDRT7vZlePiIN6RC3QtlPV7KjMAOcy2ppOcgebE2siasiQFqsQ4SZ4/ByoSRD6RAKp854=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hal8MVCa; arc=fail smtp.client-ip=40.107.95.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkm8/LpeJRVo9qgU0hQDE7tlNlBE3M/tYWsO390UJEeC8/p1IkS0HYQ/RCUojU0eBPAXP/F76GQNKTlVuWTNSDXcQrZg7TsJgtCOeYq8aitlyi6HTCvh1ixVNksc13RleIl8lAtsU3UUiseihyW/dycZr7E34TVDm0AaYz/MccA9iw3iLoABM19aSw+KWdba3r2CLj6A9GCIqdIDzXqmgW21bzdktoHHb6K8m8bhOYK94lKd22G/IpluKV2BtzppgLNiBVdkhA4et9EykZd76ztSieCkW2gevfRIoir0yVg4LB3zz+V1RU3H1WSxtyR58sWowFZx9hIZmXHKRFuA9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrn0z7tTTvSRc+ARZtac+bJcwa8kkbjGhi3wUXdqHGU=;
 b=jq8i6OB7Mx+QxiMpSLZD51gqRx7Z/7TiKuReaMTgGS2w1BaFNQolQqC1lhSo+i3P/D4w4pzKhk4EtBdkj8pXje4N5yreTBmNhSpBkCh9qlhqM35koPUEuA72fHsy/9ZK44GkC+FNRzgv76AyL7pYic8PPFMQbuBGOTXHErOrcppNXArWZj53qc4Y1B9lMS811uFkGw1fCFpIwurtrkdXmjCaMvdfcSSiC396USmxxpQuZdWiTlYMd2+PENLFdqM87uO0jl44rxUXGIOAwKvA/sg8RrrU7qvWUoBHCrfnqNJh7MlwddM0I8VZVt/bmIjfG9C9EW/wOmPVMK/1JaBywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrn0z7tTTvSRc+ARZtac+bJcwa8kkbjGhi3wUXdqHGU=;
 b=Hal8MVCaI7tFEsuUp9EjnJkgmrGc5SAnIjTDmiZXJYkJ51zjVFHP3PhLLUocVs0nSD+bAJTk/76gCp9iW5kPOgiZdBdKZUQS41xd4DD1xW8aaEcotYk9JGcu4F8zTMJyqxcY/oQ9Xe9HSWy2Kf2W/HBMNPDBtV8IR4DHzK/VBR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.19; Wed, 11 Dec
 2024 17:15:43 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 17:15:43 +0000
Message-ID: <d624402b-edd0-400a-a035-bf42adb8ec9e@amd.com>
Date: Wed, 11 Dec 2024 09:15:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] ionic: add support for QSFP_PLUS_CMIS
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 jacob.e.keller@intel.com, brett.creeley@amd.com
References: <20241210183045.67878-1-shannon.nelson@amd.com>
 <20241210183045.67878-6-shannon.nelson@amd.com> <Z1llmJmTWBrCwjTK@shredder>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <Z1llmJmTWBrCwjTK@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::31) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f84e7f-0eaf-4e72-f9f1-08dd1a0771c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFdKN3JxNzBaU1BEbUJZaklNRTNQSVAyZ3VHcGtvVEdhc003Vm82YkhSNTBp?=
 =?utf-8?B?UFczeDhjaWZlN2VCalh2amVsaVdyMGpPUFRUTHNVQTFKcWlwTTN5MTA1aEd3?=
 =?utf-8?B?M09jL3JWVS81WldvL09BZlVXQ0ZjY3k1K01IZjcyckVPRVMzcGpkSFE2MXBq?=
 =?utf-8?B?Y2hQbnkwazJxSE5VVTZkczdnODhPRlN3eEhFMUhrT1ZlRDNCV2wrWmMwVlpo?=
 =?utf-8?B?aUVnVjlVbEs0eGw5dldPUmhKaTJFenczeng3YzhtUnI5Ym90RDk4N0p6Qjcx?=
 =?utf-8?B?ays4MXZmZFRCem94WEpaM1JibWhxbll5ZnkrVVhJUTFob2NDd0xBOUNsTFcz?=
 =?utf-8?B?aTJIQ0Fpa3JSSDc0aWx1eFRrRm5tRDdDaC9wREV3c25hZkl0cXUvOTg3djVQ?=
 =?utf-8?B?NmJ0ZERRc3hrM0NITkRvYktCQkRXVThMYk40cXlxOWI4WUZXdDdyei9IUEM4?=
 =?utf-8?B?djR3emRzVGZuQ1Rzc2p3OXFDWFJaUms1OStFS054TmF6bWt1cFQvaVdKRDBj?=
 =?utf-8?B?ZHozZWFYUEtKYk15TndRNGRRc1Nld3czZGdXZk02UHpJaXViLzM2YzBGUnFJ?=
 =?utf-8?B?V3pPSmUwUnEvNmQyL1pUakQ3R1B4dWMxMTBNSEo1SkRZRmlFZDRmcFU4bDFh?=
 =?utf-8?B?cW1ZK3pUZEJKb25hM1ZZVDRNU3NhTXp0ZUlnblN4NGpZOGIzWUducHZXdDdw?=
 =?utf-8?B?YzBkOHpPZFhOcldja1huNGt2WTJ0Z3QwUHIyMWJ5WHJseDd3TmV5U1RxbCsz?=
 =?utf-8?B?MXMxeXhxZUwvVjlCWDcvUjBEbWQrTmRmUld0TWNDVWJ1UGpoTFQyVHNQU2gx?=
 =?utf-8?B?ZGY1ZVRySWRTdXVHMDR0TWJWYXBtWmJBRnAwNS81MjBYMGNPY1pNZDh4MmZa?=
 =?utf-8?B?dm9NYm54SVBTbHA1b3gycGMraGJuc01ud1A3dlZzUEVpeEc5bUxGOG1na1FW?=
 =?utf-8?B?cVRKSW1kSmNNQkY0WVJIdHdoc0dlMVNQWllCMXA4M2pQbWN0MVRCQ2IxaTVY?=
 =?utf-8?B?ZEh2MVRKRndZZkN4YWZ0TUJHQmhJNWFkVTNHVTE5YWxWUWRSR0Y5V05ZZWk2?=
 =?utf-8?B?YXlTenZ3Y2ovRnN1N3VwMW94VERnK1FsZk12cnhubXQ3MkNEZVBXc2x1TFVT?=
 =?utf-8?B?dnNsOWU4M0xDRUZTcEhodmd6REFkOEU0YXdoRjB6c2FCSHcwTkVnZldDQ3lW?=
 =?utf-8?B?dDl0c0tkRlMvOWYrR0FRRlJab2s5MU9MS0dXaC9UUEJIMGFZVFprVTVrcE05?=
 =?utf-8?B?TkpvM1BkU3hZWjZtSnB6Z1p3SlBXNnVCeSsyMjdHOG1XelV1NVJBMUI5STRl?=
 =?utf-8?B?aU9sUVBmNENqQyt2ZSsxa05COGlRclBGZFFuNjFVaElVRFV3WE5QVkd2cnB4?=
 =?utf-8?B?TTFRbHFMdUhBWFV1Uml4RGRXbVpIMWVHTnppWU1PdDNUUENGZDlHbHhNYnZq?=
 =?utf-8?B?RmF3NWpjSldXZWRJSzRKaXN4cFBhSVVUeU9ZRFRkWXdSbmlTRnZyY1h0YjhO?=
 =?utf-8?B?Q1RONEMreTVYKzJ2TzRNdTNzOUlUSGFka3pWTFdlNHN3Sjc4bmJtUHBvVzYw?=
 =?utf-8?B?WnNmd3k3SWF6dFh5YUY4c2lFUWhxbDhGb3hQYnJFZ2pRZVA4N3lhaGZxRUpO?=
 =?utf-8?B?M2g2dnNmM0pXbkF5bDcvNngxdTNNbGJPdkFFK284QW5FZVNKS2daUWZYU1FF?=
 =?utf-8?B?L3VnSHZSdTdPTjEvMFFuU01tNWdQd3hYOE1YMk02cFR4MVl6TG5vcmZpa1Vs?=
 =?utf-8?B?ajJodThlemplVHp3b29VRjVBTWt1Y1hmK2FjdURJVDJ5Q0tlY0Q5VnVuL1BW?=
 =?utf-8?B?TDViUjRQZnlsS0tkTmhGZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elNBOGxidzlHaU5XQjNXRFFpWkZJS1NQNzdicTFJeEdVWEF6QjVOWEpMQ0xm?=
 =?utf-8?B?ejVxaHhKVGJva2tyWVc3QTZ2SUhzbXlrNzdZSjZwN1BQMG1TTnJqdjRMVlRJ?=
 =?utf-8?B?bytsTnh6NlRUeG5yWndBalR1blJ6ODI1UDhzNm5YVVhNV2xhaUhHZW9URXB0?=
 =?utf-8?B?VXhweGM2OGtTd2cvT3ZUVDBGZW1KbjdTanFyQVlwQVU1V3dDc1gyQyt6Z3lt?=
 =?utf-8?B?M2MrdTRWZExNaTJ1bjIwRWdRdlRwME1SQkhvbmpXckxZNmc5TXVLL2JhTWxE?=
 =?utf-8?B?MXJwVjNTY2h0SVFHU1hWTTM4cE1Xd05pOFlvcjA5SzMzU3VveDI1Qm1nOXFW?=
 =?utf-8?B?ZEZRVlFEc0xoR0Z6cENFRlYra1p5ZTBMSUZVM3VUdkFpVklIRFp2dkVhendU?=
 =?utf-8?B?a05hVjFqRC82My9Nd0FEMjQ2cVRXUExrRmhkazhad1M5Q2c0VXY2RG5JYXFi?=
 =?utf-8?B?aU1xZ1BHNzIzTUJhck51UHcxenh4UGw5Q0NyekpFV0FGbHNNRkdkYm1YcGJz?=
 =?utf-8?B?UE5kZ25MOGJnMk9hQ2ZPMEdwamY3YW1XTmtWSG5UQWgxcWdIQk14SUFFcEw3?=
 =?utf-8?B?MzFQSW9lV3JVQU84NC9meTVHRzRlY0QzOWNDTjBvTjc5MmdCN1NqdXJPZnRN?=
 =?utf-8?B?M0c2Tmd0cVV6NUhmMDFWUUxscTBvSlYvK3FSdnJadEFTVU1jcUtuNjh0Z3Nk?=
 =?utf-8?B?TXJ5c0dTRXpYWFJQMG9PTzd1RTAwbjZKM2lObE5vbWwvei9JL0FUV0llSzJZ?=
 =?utf-8?B?UlhJVlRaMDdhejVsVmtTUjFuem5HTzRQU3JxSGV3WnZJVjg4YjBueXZqYXdV?=
 =?utf-8?B?cVRyM1N0bEw2OU10Z2ZlK2E2cS9SM3FLRzdIbEI3eUNnd0tYYndKR3hzTjVO?=
 =?utf-8?B?L0ViNlB5OUpwS29LTVY5K29XZUdCN0trbFQ4SXliNDQyclRxUUZRRDBXdXRy?=
 =?utf-8?B?R2xXVElDdTY3N0J0amtjSFNFMU9ZdzlMNzNCWTZUZzVNZkJMZmk4b2k2SjA0?=
 =?utf-8?B?RFpwbnNLVlFwbEpIeTB5NGcxaktYKzNVak9JWWlDTXI1bGphT2pIZEExbXU2?=
 =?utf-8?B?TmtzdWZoUHg3cXdLMDVLRWlSZDNFTFBoc25zcjhEeWNKd0ZJbFZvd2Q0Q3lx?=
 =?utf-8?B?bmozL21PczF4aWJteEJ0cGF6cjNRNmp1b3gzZnJtQnhDZXUvWi9xWExRRFF0?=
 =?utf-8?B?NUM4bTB6Z3BtWEVkZkpqa3Y4cDRibFlsNGw5clFaWGtrTGkyRnBTK29MUVl1?=
 =?utf-8?B?NStyUTZVTjNzTVZRZWZIeXNOQjd0NGxzOVpCQ1l4dkdEZG5sYnhlMWduL1ZL?=
 =?utf-8?B?K09iSmlsdlFDcVNBRElLTE96S3g4dC9oRklFbGlKeXVHRlJxcTNlb1ZyVVIr?=
 =?utf-8?B?RnBncXRraEo5d0IvNmM4bjdISlhScW1wcmpEaXd2Ym5GN0dCVHU3R3lTUTI5?=
 =?utf-8?B?NHU3dmVZNzRRSDNmcTQwVmowTkVXazlKQWVTU2dRMm0rbDBDcC9xZmhpcFBT?=
 =?utf-8?B?RFk2aHBNSWtGdWxXc0ZhMjVicEZCVkJOektzUE9KaHJDZnIrd0N2dzI3RUVW?=
 =?utf-8?B?SEx5WTQzYlNoaXB5bzVRazNXMlBIV3NQdFNYbTVNRSttYW1CUXhsbkxpcmFx?=
 =?utf-8?B?d1l0aXJYOVVoMTBXc1M0WE5rVXNvSVRmeCtlMEJSZWZ3b3NWSlVXUzIrMXZs?=
 =?utf-8?B?NElqTnVqZE90NExSWEcrM25CemMxa3ZTd01tOHZKRUFpNkw0S2tPeTdFNUM5?=
 =?utf-8?B?L1hSU2NOclBpUG5CcmE2Q1gxbWs3M2dSVDNYckNGNTJOWWhMSEJmYWszeHRW?=
 =?utf-8?B?TldVbWNpTXJZc1dwaE94UWNpYWk3b1Fza0dYNTR4K1pSV2Z3MXJ1ODhWUTNW?=
 =?utf-8?B?VklxbCtsZXNadlV4ZTRNVy9OYjR2YmN5eWVKdFNPMThjbHRNN2pCMDc5MG9D?=
 =?utf-8?B?RndnMDdEVXpFbnZ2SEpmMVROdWRnOFFkUThwbWtFUElzdlVJVHp0YkE3OEZk?=
 =?utf-8?B?cGZyaWdMSlBmNWdNV055cmlhSm04RzJDbEN2NFFpeTFUT3hPNS9EVXdyV2pC?=
 =?utf-8?B?aFJLTG5SQXBaYjZyalBTdUNrcGJvd0VRZTF1SzV5blBSQWlnUFpMbWhGR1Jn?=
 =?utf-8?Q?3nnVIdsVvA3TTRPLUF/xZH8be?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f84e7f-0eaf-4e72-f9f1-08dd1a0771c3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 17:15:43.4648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kqysLAqDbR80MpEyJF35ZxGV1LQhlELKlS+GCHCRI5c6G25zUbBkyTh3JAj0MivBfRo6Eu5/s60lMEWoEaAaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836

On 12/11/2024 2:12 AM, Ido Schimmel wrote:
> On Tue, Dec 10, 2024 at 10:30:45AM -0800, Shannon Nelson wrote:
>> Teach the driver to recognize and decode the sfp pid
>> SFF8024_ID_QSFP_PLUS_CMIS correctly.
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> ---
>>   drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>> index 272317048cb9..720092b1633a 100644
>> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>> @@ -968,6 +968,7 @@ static int ionic_get_module_info(struct net_device *netdev,
>>                break;
>>        case SFF8024_ID_QSFP_8436_8636:
>>        case SFF8024_ID_QSFP28_8636:
>> +     case SFF8024_ID_QSFP_PLUS_CMIS:
>>                modinfo->type = ETH_MODULE_SFF_8436;
>>                modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
> 
> Patch looks fine, but this will only allow user space to decode page
> 00h. I suggest adding support for the get_module_eeprom_by_page()
> ethtool operation in a follow-up patch, so that user space will be able
> to query and decode more pages from the CMIS memory map.

Thanks, Ido, that's a good idea.  I'll have to talk to our firmware 
folks about making more of the module pages available to the driver.

sln


