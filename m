Return-Path: <netdev+bounces-124639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF82796A497
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF941C21414
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5707D18BC0F;
	Tue,  3 Sep 2024 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OxzrGVfG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C006318BBB0
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381389; cv=fail; b=qQn3xdqOrADWsBX28WQrQjMPMwRU8B/Sve+TLgOz4A6Lb0TCTqEw85CpnihILesdnJgfrdiBKKDG/XETGqjAurTeh8yMuyb6VMMPF3rLBnUl2mOjL3yUa9VzUgg6aT9wg97SH8J9rm+/QiqqvqvTuExcgn6uSyheqmn+JtACQgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381389; c=relaxed/simple;
	bh=rvVg4D+ipbkJBl1dWsVjybkrCe7OHJciTfnlJZ0G+pA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h99672X3V6opMOnMvP3tzSsLMn1bQEY6rKp1+42I3njZ0xPxak43U0NL6TV+qb/sgvsWrlmtz8BbTT9ucyxehFnCEgE3TlmE6ZjdjnnllfkSxOTIcHjuZtd36mrBsq6w+emY5DW64Xj+vIqHNaBxkbn1YewmPPKgPLVBErOjXVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OxzrGVfG; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6sZIt2zke1GXctwxWz59Fdc7AvW3jE/2F9b084+f6se1BmMmFYkh3WAwC6wyLlSoZJT+ZUQ5tuCeHKv81hy6Pz/LxkRAC8+Nfk9Cc7gHPwzvdwTiHEXwbULPXNCeGHtzZaJRW8ZUz1jYKuhCyHic1eWmps9a0HRBEfUCV329hpPPCYuhWb/oQGMMLABzEcyTa4YBJwYw/klZDVmRfrhM0iQcOvMbcXv725Wr5Mvw1eIsMrramS86gqejq0uuwpp9ahnacVqdWfxuXUv3k7vT/lKDWo1DF/C7kVvzovH+gLvJCLZa801hvSk3j6dPz3tauS1WW4FSdJA1u0HTrHD8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/4b/OUEFBUhaGd+ixdurqHzUKHmSg+SbFPDVYJuugw=;
 b=Nbi34kM0e4To6xQh2jiwYex38ckM2Lr3ZKUd/jQcpjpArH7fQyqXLLmctZWa9z/c4cqz2Sxx+X3unSfxHm5e+7IM1SJRLCkdDJW2k53N/j3CeYBEqpMio8MV4SDPgEchmDFJ3YfUGaKGuTuWIbl8xyXDnwwtMJTopdQZtWlzdSDvObLGwlI5OBhKSUoT1AVOwBQJgMZBs1VeXvwPzxmUU0YJMB51USwEa1EpXUwBpm5ztU/l9b7Sa/ks+KFHzTOImnwMEsHhrcVwzKzYgVxZnY1BcCezV+mJubwIbntSHn0eC8zIxFJiyyZAe/aStE4H6hPjrjqFEvj8UkyFqhNDoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/4b/OUEFBUhaGd+ixdurqHzUKHmSg+SbFPDVYJuugw=;
 b=OxzrGVfGNxw3MnCJk6L+AlR7L4PF1VWsAOKg7LwvTmxDqgbYwZQjOxecTRvJqsjzHnDcEKZBeNRBTp4XXvKS2bH8tQB/5lwmQ1SQ37dGaRUhtli9HtOGHPBqJZEb9OAFTg7uwhpkbgQ6rPxWZ8JOXUkRoYY4hG6UISJtpz4vG0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by DM4PR12MB7717.namprd12.prod.outlook.com (2603:10b6:8:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 3 Sep
 2024 16:36:24 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 16:36:24 +0000
Message-ID: <36f30b18-36e2-4e7c-a801-47fac932b1ed@amd.com>
Date: Tue, 3 Sep 2024 09:36:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ionic: Remove redundant null pointer checks in
 ionic_debugfs_add_qcq()
To: Li Zetao <lizetao1@huawei.com>, shannon.nelson@amd.com,
 brett.creeley@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kalesh-anakkur.purayil@broadcom.com
Cc: netdev@vger.kernel.org
References: <20240903143149.2004530-1-lizetao1@huawei.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240903143149.2004530-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0114.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::8) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|DM4PR12MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6f365a-dfd1-41e0-da19-08dccc368ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmJjNTdNUTNFUzE5RGI3bGJUWC9aWWV5V3FUd3hqbkdvdUNKRzl4S1hmZytG?=
 =?utf-8?B?dWMzRGJ3RU9lL0dVYU1mcDUyUDMzeGtPcGxOVjliSVEzVnVPQ3ZKVUVhUUhh?=
 =?utf-8?B?U2UreG04RitwKzlSek4vL3FRaDd2VnYrV1hTbHdOQWRWRy9sbGpqNVdRM1Y3?=
 =?utf-8?B?a3ZaeVh5WEJPdndQcVhpR08yL3VrNWJvbTZSNE5RWHp4WVQvY3JWT21XM21T?=
 =?utf-8?B?TFpESkF4T3Fza242b0U5Zzh0bHc4aFJZbnBPRllpaW9TZFZ4cmtiVnpZRmxB?=
 =?utf-8?B?OXJaUHQzY1VsVnlYa1QrWXVQZmdXekJ3SGtab0lUdnV6Z3dkeWVDc1pHNFQr?=
 =?utf-8?B?YjVGcW1IOEZuZVlJa0RySlhXcHc4WDFHcVdXVnRtZHFveWJvL0JiV2RpL0dZ?=
 =?utf-8?B?U0h3b1pGdlljblZocjd5QnNrT0dFUS9yV25SQjJrdjJURGNGK3BlNHVQQUtk?=
 =?utf-8?B?VFVrUDVJRys5bjdUdHkxRE9mdE1lMTBKWitXTXo5eG0zeEZiaWRZSVc0RjNu?=
 =?utf-8?B?cVFURDRkeFkyZGNMVGVoOUZrVlgzUG9meG9md2E5Q2hTZ2NoekxUOGxpUUZ4?=
 =?utf-8?B?SDh4NkRmY1FTZU16UCtySDdEVEVPYzc2aFY1ZUs1KzBKMldwTUwvSFhvcU5D?=
 =?utf-8?B?S0ZUdEk1QU1HRVhpUHRzMWNaUSs0M21qSERrL3pXZVc2MjA3U0k3aWxmVHI0?=
 =?utf-8?B?KzBRdzJwV0dBYTdNanUzLy9lNkRDd2E2V2I4UnlsRmhsVjJZZnpPNlMwdUE4?=
 =?utf-8?B?eVBsTWQ1eWxHYlBsWTJvU2xYbHFWaGpIbG45YmtKSGxUQ1Zpc3UzZXphMDE4?=
 =?utf-8?B?OXFRcjIreUdxT3JRaXY4dXJIQjB3QVFIOS8zdFAxaGRBZHBCTG1CcUlFYjJp?=
 =?utf-8?B?KzZBa1cyMVljTGQ4djdzOVJ2QTYzazU1dzJ2TGNPRXVjckV3Y2hhcFlhUTll?=
 =?utf-8?B?bXZJcGhuYkptOUFGN052YTlMRVBTQmVpWVZxYnR1a0psZXBYVE5DbkV3LzlX?=
 =?utf-8?B?MjE1d0pZbTZKRUhiK05sdHNoQXdXOFZnMXM5TXdtV0lYdGZqazhtc2Z6YzNW?=
 =?utf-8?B?M0tVT0FBd1BFRVZFY1JrLzlJY0x1TEVudkwrWC93VTcrLzkxb3dVdVd1Nkwr?=
 =?utf-8?B?TlBRT1lDYXp1amwvUkxMb251UEUza1JBclVHNG9HZldVRDN1bEVqYTkwMnBm?=
 =?utf-8?B?djRyV2xQR0ZCT0syM2JxY2hFQWJxNVlad0VwRkhLcUdWM0YyeGNKeHgrSUpv?=
 =?utf-8?B?REhieDdPandWcjR6NlUzMjRMUW5hVzI3eFdaelR6eWJBUnk0T25BbWxCMnZq?=
 =?utf-8?B?VXp5ZmdmWnIxdnZydTFtQ0poQU1QZ0g0Qm9VMkhCdTVPMzVyeGdnOWpsV1c5?=
 =?utf-8?B?enhjaDkxZXhPZkNCelZRdEpTNmQxQVBoTzRIeHo3ckRxblVKQ3pxektsSWJr?=
 =?utf-8?B?K2NRTnZTZktNajlYWFZEVDFFdEtYYlRXYnNwUFpTZGMybFB4ZVhWTnlLMmVj?=
 =?utf-8?B?dk5nSjBVenhwak9GaUxRMlFHRWQ2R1JIL3djQmFBZlJ3VTJ4eFJkMFJ0bWlF?=
 =?utf-8?B?RW5Jem1XWnJoWUlFTVZZYXg3VVd1MUVhNHJqRjg4ZEZxelQ0bEtBQ201RE9u?=
 =?utf-8?B?Mk5ER1FaSjBhMmJBOEYzbHRTclZwMW9xYjY3dmtVQWttcnRDZVFmdC84ZVBZ?=
 =?utf-8?B?ZWtMS0FoeDlqcDhrbmk2QURDeFI2dHdIUm5leGVxZllOcHM2a0xZRHJ3bFFQ?=
 =?utf-8?B?NGdEZVJ2QlFGejZYM0lmU3JiM2FIM0M5aktuKzlSUG5vSWd2R2pwSTQvN0hn?=
 =?utf-8?B?eWZKdkplYVRUWDlkV0FXUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWpxZklOMmoyYStneUhjVGF5MWZVSlZZM293aDAvdVN4ZkpRaW5mTDRMaEpa?=
 =?utf-8?B?YVYzNnpocVlHdGlLbFpHWkZOTW5NSHViNk9ZZFJxUSt3MlNLYjg0ODdtbk5S?=
 =?utf-8?B?OGJjYXplck1kUHdtVEJZS21sL0ZvRWdaOXlqYzQ1aGVUWlhKNGJ4N0FKTkNC?=
 =?utf-8?B?MDlXRHJBQ1Z3K2tOMHJRSGFZV2EvS1FUNEIvN2ZEOXlTa1lqcDJGNGVkZXhD?=
 =?utf-8?B?ay82eG1rM3FDNHJ1WVVhQTJ0b0VCUVRBWXVJckZVQTBmRm02bGhPelpLYjhm?=
 =?utf-8?B?d3NOS29OTGNoZTcvQVlzRVBoZ3pDMDhBRmxVNmhkNCtqTnlNZ1ZxLzZ1YkY3?=
 =?utf-8?B?ZmRCdlBGNW1TUWhHd01kMURnWVRLMC9xSlBadTlzS25RamdpSXAwYWVkOVB6?=
 =?utf-8?B?d2d5dGhlRnlPSGRiVXk0V2pHQXQ1RFFucyt0NUVSdC9WVW5GOGtvK05PSlVL?=
 =?utf-8?B?TWxGSVR1UzVRUDlBTm5ndTYya084emVSV2xqQ2ZaTERvL2hneUtVTE95cG91?=
 =?utf-8?B?ZEN6QllSejRLMWhBYWFCK2djaVdHdUZNalU5Slh2dEJuandSVDFGNGEyWXg2?=
 =?utf-8?B?Z2o5eldnc0drdTh6M0JBS01ZVWJBZVdUdDlWUEZoTGt2bTIvYXZzSXB3cm82?=
 =?utf-8?B?ZENuRjh1YnFEWVdjSVozWkxJY1hQYWdwUG03eE9oTFZSOThPc2dQVmptK2tY?=
 =?utf-8?B?bTJuMUxaYnBpRUNGUlhZTWlHbEt1eU45eTM5Y1FKY0hkUy9wQUZNNUc0UFZs?=
 =?utf-8?B?a2pIRVpPU1dCaUJkZzNJdnhoUkdXdE9xOWFsa2tsbElPWVJ2MVJ5V0pmNko5?=
 =?utf-8?B?UWRjSEdNa0tSQlFrbjNuL2s2TVpwWEU2bDVOTzJuQjcxNzVUdG1DbGdOVm1q?=
 =?utf-8?B?M0NjWUUxeGF0U2l5UGdwZHlnbCtaRk5VQ1hNUXp3OHlkb2tlZURCTThjZ2RW?=
 =?utf-8?B?dG4yWXRab2h2SlRacFNtci9MUVE0aGQzZEVTeXA1T3BQS0JZdTNFZHVhVkoy?=
 =?utf-8?B?aGcwWDhkekZpUklHMENiVE9FQWpYck16NGpCNnVPNnZaOG83ZlMvV0k5Z1Nh?=
 =?utf-8?B?eXUwN293dVNvd2Q3bmJiRWtTbWJtUms5VUVXNllTMmhlSGY1V0ptWkVTSjBa?=
 =?utf-8?B?aWtFTGJSQit4RS9BNDhRRDhHV25XeTJhTldGT2RNYXFwWnNxRUpHT2xqQUdX?=
 =?utf-8?B?RXNCMEZibHlVeHk1ZVlwdkpTUWpRcG1idWJDQmNGOXVzWUZDWUdGMnUrTjhN?=
 =?utf-8?B?OXQwd3ZCNE5wajRHQ3VRMllZY09sN2Z4amxNOFRMU0JGNDRTTzhqK0FLTUJJ?=
 =?utf-8?B?RndhSG90VGlaejlJNXFYRStoK3FpYUtkaDVtdnVLT1FESDA5amJqYU1FMWl5?=
 =?utf-8?B?YVVoWXIyWGFjdnB0R3JGSWlKWEMyLytlR3pHNVQvVWM0SjFhRUxia2JPRHRq?=
 =?utf-8?B?aE1OZm9WVTRKQTRiaElJY1k3VjdUR0x6dEdheTR4RHEvY3NVUFNmajdYM1Ja?=
 =?utf-8?B?Nnh2R1ZYSWs2dVZFaUFkV1JXVkd3VzZPbUtVM1pJaEhhSXBvRnNENERYWktY?=
 =?utf-8?B?bU5kdHFxeFprSGtUOWpFb3JsVmFqSVk5QVRMRnh5aUZGemRYTjBXd0g0MEFh?=
 =?utf-8?B?a2krdCtwV1ZON0xhZlh1R3dWTVBiMzRVeU5jZXNlL2gwQ09YajVpMCtJcUNv?=
 =?utf-8?B?elFjZDFVRWVpblBmT3YxbEFoQ1dWUGNVM09McGMyOER4QUpHdzRLWDBlRlMy?=
 =?utf-8?B?QzNZeS9KMUpUZ1ZGTGtKVjk1MTJmQ3FndnNYV0xaRUp2OUl3U0RYVG05RC9s?=
 =?utf-8?B?UnJlVVkvVTRNSnFDWDdYS1p6NFVOOXdVSmNWK1l5MDhiaXRQWnAxYkkvR2lU?=
 =?utf-8?B?cGExbk1YZDV3Vm9wYWpPQ1FQb0lBcm50ZFFGQXBIVmo2NWVOMWZwZ05KV0h6?=
 =?utf-8?B?VFh2bUNnc3VoWURIeHBPakg5bXB5aUhlSDVJbWsraStvcEZOcHhkUzBTMXV6?=
 =?utf-8?B?WVAvWW5QWmJlUkJHYTNCemgzaFpLVkdWNlk4aHZjeVpDL0htdmtGK2ZnVXd5?=
 =?utf-8?B?MzVpYjNydUlwV1BXTzVjVjJ0SDBBYVRiczZLckt4SW9kKzF6MDFjT253d05E?=
 =?utf-8?Q?sVVjWnmPlPpV3F4SKN1oBmLmH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6f365a-dfd1-41e0-da19-08dccc368ceb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 16:36:24.5618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b58wGcB7v3rgEmlE4cvVqWZOUicffxQxBz2cw7JGRvxxDkqO6jcLomfNXMfTJq9C+8EVeuhgbU6JpmdvFrGCQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7717



On 9/3/2024 7:31 AM, Li Zetao wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Since the debugfs_create_dir() never returns a null pointer, checking
> the return value for a null pointer is redundant, and using IS_ERR is
> safe enough.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_debugfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c b/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
> index 59e5a9f21105..c98b4e75e288 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_debugfs.c
> @@ -123,7 +123,7 @@ void ionic_debugfs_add_qcq(struct ionic_lif *lif, struct ionic_qcq *qcq)
>          struct ionic_cq *cq = &qcq->cq;
> 
>          qcq_dentry = debugfs_create_dir(q->name, lif->dentry);
> -       if (IS_ERR_OR_NULL(qcq_dentry))
> +       if (IS_ERR(qcq_dentry))
>                  return;

For the patch contents this LGTM.

However, the patch subject prefix should be "[PATCH net-next]" for the 
first version. Specifically, replace "-next" with "net-next".

Thanks,

Brett

>          qcq->dentry = qcq_dentry;
> 
> --
> 2.34.1
> 

