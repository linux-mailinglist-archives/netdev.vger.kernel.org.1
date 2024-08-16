Return-Path: <netdev+bounces-119217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F3A954CBE
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 16:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06AAE1F25A71
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4E01C0DEC;
	Fri, 16 Aug 2024 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pk8FFERW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F1A1BF33A;
	Fri, 16 Aug 2024 14:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819472; cv=fail; b=s42tkJiZEToY2F8Xda/RiIqQWwXTmOpYwtczsl6cd9KNEVlxsDAabxNEhwRK5VlWx/WvEp+0y4wKiQmPfK40fnji+Bl5qN4DQ31ULN1P0qvpg0RubefdHuTYRDEu9MSjJPnOSjz6WaqWdnDn5ZrzLKskLDM4z9cq3Fs7/rGwQ7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819472; c=relaxed/simple;
	bh=pSQhBf27yz7Ro/gAPd+Su7IscV8R9YP23dgAe+JsWN0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gga+XbEHnUikh1VdvPMW3k09xCYeUI1PzzyAf+PZNmQQR0IG5JwCHW3tCkcyzDPu4proUbiw9vqGDwQbab1WuhJQTtZldRfIFgd/heqKSfxXqSiV2g/jguzVeD9orok2cHpoYIUt8LN8zCDl7vHz4pYoAcTJHoDOnW69pPEltI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pk8FFERW; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9HQWHUdL89D/+sgCc+4S5BE3VSnmo7Qz62yh2f2/iV+MsH0EmvE8fyg4PNXiMXslTXcUVGa5dYHOJmMzGcIJmx2oyJaH8C/7gstyyQq+DY95cLUvEk+I+iazrF1P8xiamUuFVh6ahqa/D+k1TdPBJZ8PWYxel12NpDFifuCfP+tnAlHGscsFq5WShVBZf0y2hDgdtAFSnPbkDmCe9zIqW5CiU0wZ4/QK6A3K5gc9ELU1qWbLiqd4J1v3D0ZlhqrKGOfXz9aQiLgxt5YF+3WIjdt3AJ6jkaMm/2Xj26D77w8O+7L4hltnjoo9CN/E48tEPwPvMahxSWpoazjlFFXHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVlqy1I8cdvKaFfd+yEMDoPqsdobUOf3ftSw7Tn6/FY=;
 b=HgxisQqA+A+oSqtdOuMLwDfmowpWDf1ZTkNnHE1Z5wDRdpHLmDoVveb1T8/LmYznRagtbRagRMoINxx++QqCexLQRnVGq0VMSsza0/e1WO7ZD9/ZQGeWV2InGNEsjjMYhu4plVi32aco1pL4xXB/uBiFJTSQDEUcCih1rWsdi79vOtJO6U4saJuZFv+wmSPNI7aOp4zXw8bNjwUoqEewT1AhsDlrdx7AtEl/87ajPgLeB6RHSajweMyl7z7o8iGVdtrV9L48BXlZletgh6NO8f2Z6KmFaE+sLtx/aNgkMIMJV7qk4GHMttJLy8Tnypxq5q+z5p46KQFVjOW5S6FQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVlqy1I8cdvKaFfd+yEMDoPqsdobUOf3ftSw7Tn6/FY=;
 b=Pk8FFERW0R/v6vxvxRzImScJd9eqeYk2Nb5x0y65pHPSIyOHSdkwtR4gojjz2HDDvGz+svb+nP2vyPcFS/vXnaaz3A2T9I9MVB1pbq4vjH2UXzvHMS3jbl4foVRg4KuPO0F1gttsxkoVabF0AGm8njS29FsOnReZ7TPnVI+nCHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ2PR12MB7800.namprd12.prod.outlook.com (2603:10b6:a03:4c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 14:44:26 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 14:44:26 +0000
Message-ID: <be6dd8bb-d7a2-c19b-f7df-3a8da33fe020@amd.com>
Date: Fri, 16 Aug 2024 15:43:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 05/15] cxl: fix use of resource_contains
Content-Language: en-US
To: fan <nifan.cxl@gmail.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-6-alejandro.lucero-palau@amd.com>
 <ZqFxOge1S654X4Uf@debian>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <ZqFxOge1S654X4Uf@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0211.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ2PR12MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d870d8-f0f4-4a42-5346-08dcbe01ed4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UStBQ3diUkNVWVNZaDE4djRManBkOUwyZjNOSVJFOEV3SGtNYzRuZS8rVzZC?=
 =?utf-8?B?VTI0ZjJrcWlwN1N6Q1dTaFhxT21BNGhxem4rMEhxaTFNMk5aRU82RUVMTGdW?=
 =?utf-8?B?TFcwUVVuTG5WY2JuNktmZVpHSmU2MlJVb2g3KzYvcFFMeS9Cd1N3Yzc4b3gv?=
 =?utf-8?B?c2dieDMvREQzMlYzc3BrcjQ1TGR0M2RBK25sQmI1aXphcGZRYVBhQVVvNmtG?=
 =?utf-8?B?MGF6c05FY3h4dDEzSU9JMmdZUHZiSjZ5bXlRc1Q0allnT0R0UnF0L2NLK0xX?=
 =?utf-8?B?Znp2eUd1UTdybnZOK2txdElmbmlzUmMwUysweHRJUmJNdlVmT1VZNjBLM2E2?=
 =?utf-8?B?bExSODI2VTdDRDRJRitJd213aVQwVFRKL1lpTkhNaU1uamFpSHNsMjM0UjRO?=
 =?utf-8?B?YUg3aGhSU0VkbWNOcHRkemJqNW00VzVkcTRiMWhTR2VlRXJST1JXb3hWUXlE?=
 =?utf-8?B?bmwrcEVmdnpWWjZiVmpIekVsbWcwSkVENnRkV0NYamFGZUZWcXI4NmV2U2ov?=
 =?utf-8?B?RGlUeVBvejh1MDZiaGgvNU05M0YzSTYzYXZKQmFWRG01NGtPV2tSYkk0bHV4?=
 =?utf-8?B?T2dYNGViV0h0RFFoVTRIbVE5NUw5bVM0eW1tS3JYSGUvc2dJWmYrMVBhL2ha?=
 =?utf-8?B?dE43N01NTS8vQ1ZzR3RZQzF1azBwakF3T2FOTjE1U040VHY3V05WT0puMXJQ?=
 =?utf-8?B?SS8xTGRjM2J1STV0VUJraWRPRS9uVk8xNHpJU3BpZ2E3aTVianhFK3B0dDVm?=
 =?utf-8?B?U3FwRkJxOEI2MVdSTHNBM1lMNEZLMTJQK2t1VHo0anlnQ0hoSjNBVUxnbHFG?=
 =?utf-8?B?T3N5Z1I1eDBYeWxyK25Eak4wKzY0WU1EUTJvMjFObHZtSm9HNXFaTC83OUZI?=
 =?utf-8?B?a0s1NE5LY2E3Yml0M29HQ2tVc3lCNHp4QXV2QnNBWmFZY1FrOVRZa2dVL1lT?=
 =?utf-8?B?NktMYUZQK1JsamtwbFQzb1RySjY4MlhSQ05sV1FTR2htMFhYWWZOK250VStw?=
 =?utf-8?B?cjJQVkhDOG53bzdKYTdhN1d5MjVUQzMvdUtNdFlSQ25VRFh1eEI1bkFSbm56?=
 =?utf-8?B?VnVDbyt5b1hHVlZ6cng0N2ZKQm1QM05hN3B2RTljZXBtc2dBK1o1am1ydTNF?=
 =?utf-8?B?b1psTWRMQ0pEU0l5ZGlSK3FUT0xCbHhDcXBQeFRSdW5OUlYvZk1ZY09hUWRG?=
 =?utf-8?B?ZmM0SnBxNlB5TVQ5Yml3RXBuZzFXZjkyWERENTdzU2krTW96ajZCWjhoS2Vt?=
 =?utf-8?B?UDNQYWRNYmdibDBLRlRkZ2VqNHZkS1krYUhwa3ZzZ0hiaWhHK0JWakoybHZw?=
 =?utf-8?B?b3B6bHFGZ1ViaU02U3NiSG1vTVVCRjNnZ2Z1ZG44cUpSVVVkaDlpZDRPQ0Qz?=
 =?utf-8?B?OXZ1QzEwRUxPK3E5MzRKbjIvTS95VUM4N3g4TU9PejY3U2RqUjFVby9lSXdL?=
 =?utf-8?B?Q1RsMVVPMGg2Tnc3NEpzZlhFN2x6RUh0a29YQWRVaExjYU9taUx6dmNPZWFN?=
 =?utf-8?B?bEQ5WWFwQVBiRDhxUk5Zc3Z4c3NIZXppSXk0Y1VrMnpqdGtpWndwTHpyNWRZ?=
 =?utf-8?B?NC94bEhjOUwwbnZPMWhlTisxK0pDQnZML0hHMmUxMnBVcXNJemVyOEZBUXRp?=
 =?utf-8?B?bWdQdklqYzJVYVEyN2pmVGEvd3NRdzN1NUZ6VUNBQ1hINTQ4Vnorcll2VmJw?=
 =?utf-8?B?TEhDSy9pU3AraFdvR0hYKzVLOS91djVWMWh3OUcxUlZFYStZZUpCM0JiOVhI?=
 =?utf-8?B?ODFuK2JkTHphWkRrZHd4WFk2b0NRbituZTU5YTdYQ21JbEM0djYxdjVEZnFT?=
 =?utf-8?B?UTh6MlJFYXZRNURrOHB0QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkpNY3FqNkMrQjVxbHFjRW80YVNRWHpGM3RoUUFQbzRZY3pCN3Y2K05NRDVU?=
 =?utf-8?B?OHBrRWV6Z2h0WDNPUjhNSE9mejVseDRJQWYvaXpsM2RmWWFQTEt2eG9mZGh4?=
 =?utf-8?B?WFRmWllxYzI2UXpPTStLNDJ0VUNQM1dTMXVRcDR2cE9VYUpFYTJ2QUZ1WUl5?=
 =?utf-8?B?RVhTbkEvOHBhQ1M1OVVTZHJFcHNIa3BZYW5ybVl6UzVIVnFhRW1Ia3J4VGdV?=
 =?utf-8?B?c3VtOGZVcjU1NXBYcVBaL2g2Y0J3UHFmUUYzRzhVOGlmSDFYZ1laUEpmNkVk?=
 =?utf-8?B?L1N4bm9rWHp1QmpEWHFka1gyak10SVNBNFVYVHl5QmovOTRLOVJNTW1NbmFv?=
 =?utf-8?B?ei9rQlRPOVY1eGJ4cTlZUGtDdWJjWENIVHRJb2V4WGF4emZHSnppc1NwS2RU?=
 =?utf-8?B?Y3EwdmI5TXFlTktMT2FtZkVGeC9rNnRtUENLL1N6WGE5UFhMQk9Ua0M1QWs0?=
 =?utf-8?B?bFJkd3Q4WmZVcUY5YmJwZTBVcndWQXl2THUxcWc4TGpZa2JibWZmWUMxZ0lX?=
 =?utf-8?B?bmVYdFVEL2Fvem41YUNYTEVPakhWQ1J6ajlUS1FSUDU2OFpjanpicENtUXI2?=
 =?utf-8?B?VVFwWUdQOXdmMkdXenFuZERRNzVYazh5ZjlRN1UvVTRlYU9LQWV3dWZxN3JF?=
 =?utf-8?B?aUVlajdNYXZSemVzZmxOYkJ1TzlOaFZZelZSdDZHYjBTTUtZMXhhVG8vVDVR?=
 =?utf-8?B?TkFXcXRHMUFkUFJjcEthUmh2ZS9tOUZTYUszV21WeEdhRGRsbFVraERUSEZm?=
 =?utf-8?B?a05TakVKeVNzYnBDVW9WVExCK1B2RFJLVm02bVpQYlFELzlweWF6Y3FkWUw5?=
 =?utf-8?B?S1JwNjhwSTRRd1RNSFgrOUE0Q3lIWmtOUlJIeUswcFo3L3I2RlNIVGlkUlhq?=
 =?utf-8?B?UDhaMmFsVFpmOTZHTHBwZ3BtSkljSk91ZGNZY0RVaWtMSHBtUUJUbkw0bnEz?=
 =?utf-8?B?Y01lS2pMbGxaeEUxN2pUS1RkMXYrT3NqdVNSTVVnOWFVOVJ2NHpVZXpqVzR2?=
 =?utf-8?B?K1dCY05XbnlSZk5VeVVPV253Y25YK3dhSWZ2bUNmQ2J3cGFaZlVkY1VqZ01p?=
 =?utf-8?B?aTR4TGttaHNOdGw5RFE3Y2Y1ancvejh2QmZ4dXVWMmk1LzJKSE5NbmFWWGpq?=
 =?utf-8?B?ak5rakpkOFc5NFI4Nyt6NFIySGhWZWVqQjU3SnIvalUrNnlkTStWYURqNVJi?=
 =?utf-8?B?aCs5M2h3TFp3WUlsY0hzQnFUeUs0dlpqam9pQXRaRno0d0w5NUZOdk91NytW?=
 =?utf-8?B?RnYzSlJydi9vV29CN09wcm5GNUNGTUxwMWhzcEtXR1JkYzMvRjliZ1ExMkdM?=
 =?utf-8?B?Tjdkd1JlQU9ieGs5SVlWOWt1R2FuS0ZIYlpZc1o5dUJ5SDQxWVhzdStKRzVG?=
 =?utf-8?B?a2VZSXYwenBhNmlWOW00WVZiRmFheStpdDF5RGZJQks4cFVqcXlhdGoyblg0?=
 =?utf-8?B?QlFTN3dla3hYVHVLY3N2eGhLRWh6NEVQSUEzUVdmTHVudHF4WkFLTnNQbEpU?=
 =?utf-8?B?WUp6MHlMMSt4N3hHRUROWXNVTytOS0FzZU5kQ0E0bCtsQXN6TXNteFh3VmZN?=
 =?utf-8?B?SGVMVGE3R3hSNTRXM0VUYzdCcngzd1Zoc0hvajhXREZwK1lPQUlBUDB4c1M3?=
 =?utf-8?B?WWgvZWdRR2h1VzRsL3lzQVNJSWhhSmpraXVyVjh3dW5rRjE2Wlp4Z3pjQ29T?=
 =?utf-8?B?MldjbzJOV2RGcVZ3NEVJeUhHeXJMbnl3TXhidmp2WndRUlBhaitYR0lKeXVY?=
 =?utf-8?B?ZWlXSUFyUE96VTJYTUg3UFV6L1FRbXJIdHhic3FBYlVGQVp2NXlIRXhZTlA3?=
 =?utf-8?B?L0NFa0FBYjVxMkFaSkFkN3MzZTQrRWdHMGN5UC9YUWpUTHluR3dTU0pTSWJV?=
 =?utf-8?B?Q2ZGQ2RiYitYVlFsdTJxUDUyb1VUaDdEYThKaEFERXFvd2dBVzFITVlpbzkv?=
 =?utf-8?B?YktFcEtRakVvU2lnTUd4d2tlKzBNNk84aGZnWWtlSG0vOVdaQ1o1bUVvSm5H?=
 =?utf-8?B?aWhtZ1RvWmlsL0hjWW5GaU9QNk82YnRGYWdPUC9lR0R4TmxPMFBmVjk3Y294?=
 =?utf-8?B?THlOYXhESnBabENqN0NHZ0lpendmd2htYm5WYTBoWVRBMTlJeW55QVQxcmdp?=
 =?utf-8?Q?6MwpT3UptYKd0GkwvKCrFrR+U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d870d8-f0f4-4a42-5346-08dcbe01ed4f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 14:44:26.7670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/gt+0p9Ax2+gwKbNE13dbdBtgtKuTEA1EBEd6qQaGgTzeBMZDiOoa/PA0jaaNxeqEd0urttbXLQNn8lGHkM3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7800


On 7/24/24 22:25, fan wrote:
> On Mon, Jul 15, 2024 at 06:28:25PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> For a resource defined with size zero, resource contains will also
>> return true.
> s/resource contains/resource_contains/
>
> Fan


I'll fix it.

Thanks!


>> Add resource size check before using it.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/hdm.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 3df10517a327..4af9225d4b59 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -327,10 +327,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>>   	cxled->dpa_res = res;
>>   	cxled->skip = skipped;
>>   
>> -	if (resource_contains(&cxlds->pmem_res, res))
>> +	if ((resource_size(&cxlds->pmem_res)) && (resource_contains(&cxlds->pmem_res, res))) {
>> +		printk("%s: resource_contains CXL_DECODER_PMEM\n", __func__);
>>   		cxled->mode = CXL_DECODER_PMEM;
>> -	else if (resource_contains(&cxlds->ram_res, res))
>> +	} else if ((resource_size(&cxlds->ram_res)) && (resource_contains(&cxlds->ram_res, res))) {
>> +		printk("%s: resource_contains CXL_DECODER_RAM\n", __func__);
>>   		cxled->mode = CXL_DECODER_RAM;
>> +	}
>>   	else {
>>   		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
>>   			 port->id, cxled->cxld.id, cxled->dpa_res);
>> -- 
>> 2.17.1
>>

