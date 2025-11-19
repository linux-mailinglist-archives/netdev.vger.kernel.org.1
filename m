Return-Path: <netdev+bounces-240111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A3EC70A8A
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB4A8347C95
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE1E30EF91;
	Wed, 19 Nov 2025 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sNDcsKn/"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7122C310630;
	Wed, 19 Nov 2025 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763577092; cv=fail; b=RdIFMbV7sFwpzmBLw8YRDvzUqmdm2cML9Is5rDV4553rKD305yRVGsG35JtkADuZJtWNI/8D20pfcxOPGYQm+CtAH5/fdklO/ItcZ1gLSTQrNRnyCFshGHYjeeo+xFSnyreuo+1bZh0Dk2hi2K0ubN0uAE3bc3TCcwYeP2YXN3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763577092; c=relaxed/simple;
	bh=E7DMrW1nFX4i/Cr9UJ1bfMH2+KrKMuPgrxKq92p19CI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=baKrGcMd3QjwgO5jnh5MvHVrZVKGKdNnbSczYRm2vVYozoWfkaMSGKEB6bCUMTTnB+D8A8lOp+ru/KQ27OJbARwh7b+rDz7wJ8JKBiaPWXogY3wdgZsW8vMksFWcc2IELmcwdtYknHsE7LbxDdu1zSIFSnEG/Z38j/0VKhmTCbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sNDcsKn/; arc=fail smtp.client-ip=52.101.46.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKoSAwdEfaRmqXJNQNb6QW4WJd/x29iw9cPZ+34ClnoSnNDb7S/kiZx8pgii5YAsTuQrdK9CCKRhvbVILQejymBwFnL6gLzugQrefcV4njqBDctuGSvFi6H/nAPDBTyaGXGlghMob6VDTstZtWXOnCh8IofjrV9DP6plz7ZJB8kFJ2G50ZDzJ/xZrIBUkWgjRaGxTWgZA4rTdwE0qaCXAnjw//y9tY059h0z1wLCXmHnEYPSTcqpK6/YXEyGWwnBS4QfawsyGX80O06484VrPrlsGxe31CV18Pijbw88DOHriToaIdQ2ucTJhHqcBO58UAOvWd72PPUCqFGIFKAE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKwiSBtSkET6LXcrVmoxuppH538sUncGrbkQmpwUN9U=;
 b=Kc3RGZA3wXLgR3SMd2gxsazQEjzMcjKMxWe5Wco+xmXhh0aafVM80TlPMZ8CEmJNpB88ohunk4cTNaVpmX0Z6QVWGyFm0/wsvWwQSYo49liVyWRe8ePbRBp/xSMcnV8dC2TFxVzI80wySdng43JFLzrYoUZsnm0Qa/nZvTQRDBE//nTW9+RKss/V6SwmxNBJ2wl8wKgGGejV/rTksledOuxCMhFKx/rovozt2FX3XYL3BnKSfYrqHxxqI2v4U17l1iXm3go4M/ItZZaK8oD31mDHi+4B0uwURVDwKkYP+er0ZHJS/YPhWszob7OH6rv2oJStPODhVeKQxyhb/cjpHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKwiSBtSkET6LXcrVmoxuppH538sUncGrbkQmpwUN9U=;
 b=sNDcsKn/4EynCQfEJ13gOUfl93v36exVMhp64HTOUuZUj4bL9rF4ncELf451Jy49b0mSwwyXH58N1Zk112uIkkIrIhkmXBg/1JCjrlXTzFTcoOIv+qmx0LQVBkFTrTVi1KBrFKi9leQ8EKQaVV/GhbQJLBKFBPqZaTwnJMFcfxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 18:31:23 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 18:31:23 +0000
Message-ID: <458ee5a1-78a0-4953-bef7-bc66d602e11c@amd.com>
Date: Wed, 19 Nov 2025 18:31:18 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 18/22] cxl: Allow region creation by type2 drivers
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
 <20251110153657.2706192-19-alejandro.lucero-palau@amd.com>
 <20251112161942.00001012@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251112161942.00001012@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0262.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe9e0c4-d803-4748-25b0-08de2799d787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjF0My9qRFNJc2QwTVRoY1JXZkxLNkF6aWhpbUVjUUZ5SGJnMXZjNnhYOUlK?=
 =?utf-8?B?SEJnNStDQjR6QXRKbzl0K2NOV1hodCt6TndYN1ZVaTk4M1dvc1VLYktUTkFB?=
 =?utf-8?B?OHRrd0JWaEVkNSt0QW80ckZWc3gzRitETDBZTTgwQXFrRytpazEyb0lMM2JP?=
 =?utf-8?B?NzRiQnNxa0RKUzJBcDF3eTBtc0lrZk1MMGdVanVXTGR3bENYd1NQcFowd1hj?=
 =?utf-8?B?Rk1aSEhXdy9XMS9oQnlwT2pIV3lIa09McWdDRXM0Z0M0cG9YWUtsVkRpbjEr?=
 =?utf-8?B?clg2ODBtNVV2N0p1enpIODBIdVVCQ0dBMHBja3E2YklvSzdMUkdvRkY5Mzh2?=
 =?utf-8?B?Vlc3RFJaenVOSGY1b3JEMTYwQXFHTURvYUtBQTBrMDJrVTdjM3BDcE1DcE91?=
 =?utf-8?B?SHV1SHhHYk1wVEVkdlN4N21nVnBYUHRkbmJpMjkyY2o3cndmSjA0VGFKVFl2?=
 =?utf-8?B?YVkwSE5RQjV1ZWZpMWU1WkUyUjFHdFJXd3ZWdmRET2ZyeVJjaXVLMVd1RGlW?=
 =?utf-8?B?UXY4QXFSWmRTWTRIU1pEaldEU0pEdWpGUGhZSEJDQzc2ckhoa1hoZlpYTWVD?=
 =?utf-8?B?alpLRWR3S3pmR3RuVEV4R0FiZlRSMHg3QVJVU0dBWlpHSitkSnJIaFlMTTVS?=
 =?utf-8?B?Y29xWTQ2RHV5MlhORFREdEQ2QVFGb2ozaWsxUk1pdG83ZUdsejhIOEhCMnJl?=
 =?utf-8?B?SDFCRzQ3TnZYeDJoa0ltdFNQazZ1c1lLQ2luZ0s0MVdvWklKenFrNnpla3Rr?=
 =?utf-8?B?Skw3U0dMTDAxdnVjSEZKaW93cWJLU2V5aS9LcDUrd2tnZEtXemtvczJ0c29s?=
 =?utf-8?B?L2c4M0w4TmJ6MGJnVWRmaG9oWms2YUF2Skp4SHIzVFhyNUV5ZEptL05GOGlq?=
 =?utf-8?B?Z1UzejFjdzR0dTd6SE5QWFp4YUphSlBlalNLbU9NdmxhVG9QZzFnOEZ1MFVX?=
 =?utf-8?B?N1pLUkdZa1M2Y05OV0VqaTdaNnUzRVVnRVhNMkF6R2JkUlRnTFQ5VVVHRFRC?=
 =?utf-8?B?LzlwbldLblh4VSt6SGgrTmNCYnVIbDJjeVBha1dzNkhheVlGN3Q3R0lnMWVv?=
 =?utf-8?B?TUxlL2d0SXpNVlpIbU1sS2c0SU9WZ3E3Ym9pQkt1cktjdmZ5WFBXRzBaekpF?=
 =?utf-8?B?TklORE1wZGEvUG9vWU1PSXNkQTZIcTJzN05rWEIzMjlvb0tCMmltaFRmQ2pZ?=
 =?utf-8?B?RjFkYkpwcXVxR1pqVDdVbHpHb2lSek5Uajh3dTA2djJ2QmFvcEhPSTRIWXZO?=
 =?utf-8?B?N201QXNKR3g2YjljVEVqTVVGaGh1azVpVEcyKzV0MFlRUEZ1MjA1c04vdkxN?=
 =?utf-8?B?dThENVdsT0UwYTZPOUo5U3VnbDdnbEgxeVN5K2ZkaE5YdjZkK1dsaGtvMjgx?=
 =?utf-8?B?amJYRTdacXd1ejQ4TzFqTWdWdEs1NDB5ZHJxRGZJcVJhZEh3OFphUlBGZ3R5?=
 =?utf-8?B?bTVwSktnd3o0aDhXWTFBWDRDdElISWRRTE1CZnV2T2N1UUVYSSs3QVowMzl5?=
 =?utf-8?B?WlhFYWFIcTJralJFcHdEbDZ0QVZ2bjVjVEZZbStWNlBuSE84VlFVbmUvd2lw?=
 =?utf-8?B?RmpGbWJyYnlIK2k0aGRneEdDZ3FoWWhtRk9tSjVCZUsyN0o0UHBpVGJjRzhQ?=
 =?utf-8?B?czZSZ0NkejM5MGljN0JWUjNtaENyUXM5aDhZbm1pVnZrdzd1MXp2N0p1RFE0?=
 =?utf-8?B?dVI3UXljNzBLLzV4a2ZJd2NpT3JYbjY4dXhOTG1FUEVTUk00bXh2YkRmK1pt?=
 =?utf-8?B?ekxFU2Q5ZVQ2UnlwZzFBWCtud3V6MEltTkthZ2pBR2FVc1RnbnJkcGd2aStM?=
 =?utf-8?B?bEJTeDhKWko0dFl6b29ScSt3TTJqRDR5TWprMWsxMEIvMUgweE9YN1pyVHll?=
 =?utf-8?B?YTNnV2ZJSmIxbHRGUzNVZ25CUFlnbzFyZ09vSnVkUWhmU1lNRkFhcDhDYWhm?=
 =?utf-8?Q?pi8aN1NEb6VpWTHgOC8SON6bdHgdQlG1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTNpa0YrSkVRdThJTzdBMXBFMEVaRUtnVFlIRVVjRWlEZTducndxMkNhNUtY?=
 =?utf-8?B?STdCVWxkVDJOT29TMjNXMHRFUFBaOG1Lai9yVUxFRXgxZmxHNGJycHd5NFk4?=
 =?utf-8?B?RWhaemt3aEdZcVEyQVA1aTJVOStjS2g0SndITy9kR29pR2pxdjNzemdkbmlj?=
 =?utf-8?B?dGwwY1lHOWt5Mm0rUmd4dUNURUpoY2R6UjlaeUxSRXM3b21TcTA5bCtRZlNW?=
 =?utf-8?B?d29UMkRoK0NtWHQrTDA3OUl4RVd3SmpEcVVoVjJPMy90bkpVN2xWT1N2b1BB?=
 =?utf-8?B?YlJ5dG0yRThaMGRlL3pERmxLc3NxSFNYZVkzK3pTa2NVVWpUS2pjKzlmMGtJ?=
 =?utf-8?B?dW4rbWVPTU1mdjI3NzhxZnVSUmRTaHRaOEhISGllYnJJK0NNTmhiTTA1cGY0?=
 =?utf-8?B?bUI1VnZwL3pRMGFWem9YZGxTTEJTMXZNMXQ1R3NURFY1UmRTbnk4cFQzTUUv?=
 =?utf-8?B?aGFTcWhoZ04wYS9XZWtxdFJGWUVXcDdHUWpFVEZ2WWg5N2l4cGhpRnlTa0ZI?=
 =?utf-8?B?c2NycWlwNzdXL0hDaGp1NkZhVkRoZWxLRU1STzdTSEV0ZCtyelFUaTc3Z3Jl?=
 =?utf-8?B?a1BaRXhlTTdPZ0pzajQwa1pPUTdqSG02NmI4WENPd0dmQVJCZkowWGg5QXZF?=
 =?utf-8?B?WDgxeDJ4UXJjSkx3M0Jiejc1VXplUmQ3VDJTbDRaOWxvVExYWVVKQ09Wdk1o?=
 =?utf-8?B?NXdlMUIrRk9ZS01pM3ZvY1dPM1E2Y2FlbE55cFRtQnpNVnFMamJYZFd0NlVO?=
 =?utf-8?B?MGlCWVVpeTUxdU9aSVliRW9FZnhiRFhSMHJycmdLcnpnVjJnTnA0SVd0NVZj?=
 =?utf-8?B?U3d4cllQeXV5Qy9ucUdkYjFtaG44V0g5bzdtdG1BZzVDcHBwdnNHdDlVOUVm?=
 =?utf-8?B?K29SS0lXZXN4QkwvMlIvYndkMXd5WnNabGVzSkRPdEhHM0p3d21IZXlmdXVZ?=
 =?utf-8?B?UXFacWI2Y3lsOUJSVTg1NkRHSXkvK2V2ZU9WYXBTbkY3V05Cemg5c2kvSVI5?=
 =?utf-8?B?dUZtOTBNQ1NpeWVMeGx2WElxdENIN0d6NG5SSnlBaVBoU0NyblZqN0hKeURn?=
 =?utf-8?B?eEZXM0Q0NUMvZzZTd2lycXZDNGliRmkyRVNlUG9zdVlLSVhBSmpQb0hEaVQx?=
 =?utf-8?B?S2p2UU9NWmRmQVBsdjVFM2FvQmRKWnBRZmo3TC9jNjJFWVhCUVJsRFZuUWNF?=
 =?utf-8?B?Si9KeUVXYmtGSFhaaFowN0JQaWlkSjBJYzlzZ2hIeVgyWVF0aUNxU0MyQ3Zn?=
 =?utf-8?B?SDFLeW4rSzNGVW1LcFZHQ01rMFM3ZkRDaXZabEhvb0NkazVtcng3eHcrZE1T?=
 =?utf-8?B?YzZXTVRqVmFlSVV6OUhDV1gyYVBRdHN1LzVoOEZkZk1HdzUvQjduTG1JaTJX?=
 =?utf-8?B?OStlbnRKV0FLL0FNRUdWR2NIVEtzcmdQbXUrSC84MlJmNnQybG1xTk5USElE?=
 =?utf-8?B?aVp6NGZXOU1nUGlnRXNuUldOR3lBYVVYUHdRbkNUWmN3S3gwNFpXVEV5QjVz?=
 =?utf-8?B?N0JqY1NSWUszQlpxdnJwd3ljQVBmYmRmV3JDaHBMM2ovNW9QZmoxR3llcmQ1?=
 =?utf-8?B?dU9BSzdTSEJUanFyV05hcUNFT3ZubzNIN3B3MU1ycDN5UFBXTDg1d1UxNmxG?=
 =?utf-8?B?SllHYS82YWFhUjlucmx5d0tuUlQvcUJtdXpXMTF0RVl6aHV1OTV0S0pPYjYr?=
 =?utf-8?B?djhJV3lWL2ZhTnR5czJrcW1tNXpLQk1pKzh3YjRsVVlUNDEzNGJNZGhhdGpl?=
 =?utf-8?B?SGRCTm1zMUFYL21DUTg1Zmo0czZLK3Z5ZEVNRURCTEFEelZ5akRkejFhWllq?=
 =?utf-8?B?R2xpOWJMQmZ0QmZjc3N1RkZWbURrWHA3V21vUUxNOWRLTEhxU0hFWERqb3hB?=
 =?utf-8?B?bVhBK1c4TWFySlo3UFZ3YjJYQmVWbDE3SHpjMVNRTXIxeVFyT1hZdEZZeEdD?=
 =?utf-8?B?NDBQRlB1dEJuRllHQ1pMQm9MdGs4YWk1K3Nad210WEhxUVBOdk9DWHI5amdV?=
 =?utf-8?B?TGxnQzNXc2ZRL3lHNXpYNWovenp0aGwyVkJzQ0x6YWswcnI0anZxSHN1RVZY?=
 =?utf-8?B?NWplOXlXZ0NpanhqeWZKTGJiMkc3UWFZL2RDb1E2TGwvSmYzQjBLVGdRdWsr?=
 =?utf-8?Q?saeDs4FDI+U76pbH4MoMrvV2W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe9e0c4-d803-4748-25b0-08de2799d787
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 18:31:23.4488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XN5t5DmGSNGJ1vjLDf++bSwsjvgZ8tuGd1guPsKP+DExA+/s3T8VNkegEdajpggH4nQQM9o7Dtc9D7WnHq5kow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677


On 11/12/25 16:19, Jonathan Cameron wrote:
> On Mon, 10 Nov 2025 15:36:53 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Creating a CXL region requires userspace intervention through the cxl
>> sysfs files. Type2 support should allow accelerator drivers to create
>> such cxl region from kernel code.
>>
>> Adding that functionality and integrating it with current support for
>> memory expanders. Only support uncommitted CXL_DECODER_DEVMEM decoders.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> One minor suggestion that I made very late in v19 thread.
> Either way:
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 2424d1b35cee..63c9c5f92252 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
> ...
>
>> +static struct cxl_region *
>> +__construct_new_region(struct cxl_root_decoder *cxlrd,
>> +		       struct cxl_endpoint_decoder **cxled, int ways)
>> +{
>> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
>> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>> +	struct cxl_region_params *p;
>> +	resource_size_t size = 0;
>> +	int rc, i;
>> +
>> +	struct cxl_region *cxlr __free(cxl_region_drop) =
>> +		construct_region_begin(cxlrd, cxled[0]);
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
>> +
>> +	guard(rwsem_write)(&cxl_rwsem.region);
>> +
>> +	/*
>> +	 * Sanity check. This should not happen with an accel driver handling
>> +	 * the region creation.
>> +	 */
>> +	p = &cxlr->params;
>> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>> +		dev_err(cxlmd->dev.parent,
>> +			"%s:%s: %s  unexpected region state\n",
>> +			dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
>> +			__func__);
>> +		return ERR_PTR(-EBUSY);
>> +	}
>> +
>> +	rc = set_interleave_ways(cxlr, ways);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
>> +		for (i = 0; i < ways; i++) {
>> +			if (!cxled[i]->dpa_res)
>> +				break;
>> +			size += resource_size(cxled[i]->dpa_res);
>> +		}
>> +		if (i < ways)
>> +			return ERR_PTR(-EINVAL);
> I came in late on v19 thread with a comment on this.
>
>
> 		for (i = 0; i < ways; i++) {
> 			if (!cxled[i]->dpa_res)
> 				return ERR_PTR(-EINVAL);
> 			size += resource_size(cxled[i]->dpa_res);
> 		}
> Is the same but simpler.


I agree. I'll use it.

Thanks!

>
>> +
>> +		rc = alloc_hpa(cxlr, size);
>> +		if (rc)
>> +			return ERR_PTR(rc);
>> +
>> +		for (i = 0; i < ways; i++) {
>> +			rc = cxl_region_attach(cxlr, cxled[i], 0);
>> +			if (rc)
>> +				return ERR_PTR(rc);
>> +		}
>> +	}
>> +
>> +	rc = cxl_region_decode_commit(cxlr);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	p->state = CXL_CONFIG_COMMIT;
>> +
>> +	return no_free_ptr(cxlr);
>> +}

