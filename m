Return-Path: <netdev+bounces-148563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74C49E22F1
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8DBF16D24A
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33561F759C;
	Tue,  3 Dec 2024 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KSuYuFf/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2273A1F707A;
	Tue,  3 Dec 2024 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239538; cv=fail; b=AmUgyjDLoAHN+ls47SITol8VlKLRxwiH2GYYSsI1Yjsp23oIBJutoRBSaHSK0fu3QmVm9aySJDcE2l2iNa+UHsso/J1uyyAjwrdsg417zoSOPC62eXeokH/3b3KbpbgH1smXl0zU0VZwLQgCTMAMnVi5Fvd/zzj7dUaFsQ9bIaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239538; c=relaxed/simple;
	bh=XnCp/5woM2kzyJPFjnxxxbePdBJb59/CZDx8Q+FI5mA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vl0vEa/qlGfTv3aTMh7csm2nwfs8Q0zTZ8MUPB8u7a05L2qAacGw8z+ZoKstAK//c3vysO0LoTwsFQkrJy0PgfIudMEirQuaDOCN3r/Oo2vyTNZu6/NNSoCayr0GzWejKa5+mSsNrsGolhazOY5Sbdbo7Ga2WfTyguwlwVbkU4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KSuYuFf/; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m89Op7Ubad15t2thKUR/lNfaFqsD5niUzyFEtsCLcwSrD6To3XPLzJ8nFl/X+3NQiLUUWR81EW8MGyvKPm6B1r0K5ruHHC1gqDNsmCEqJ7hSY/R9VqEVyg70sJgNwj5SOZYzbDwefg6lSZ/NSeI/ikZyUXzaAvQ6HWY79c8BJbeImFTkGQfVCfbOV85CVOi/++pkykXDMXshtGIS4uR63nmquAC0gAg2Hj9mC57MXOqgNG9U7dA37x4PDydCXYKpc+MZ9pI+nphHIREOMJHWA94OdwDvGFq98GEyce6T1wUU5n5qVQYP7WMD9fTzn7xx4TLC4iVUENDO4ZJn1SoGgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUqxDdXETxmiq+tjT51fm4LOd0AzveYnoUwRjwn9Wao=;
 b=pit3id1l89UGb8i9IdciGRzLfxVwXXFI83ZZpQvbzc97WrtZeY92Pczbrr/xL0YntBpLViyR9ok0zQR8VaNBZUI+J11f7RJiJwzTXI1GgUunP9FhakAhBLHmOCZl2DI0Wn30LCsSUIolrT5Xu0mDeD3Zpsebns+g46lv1bOMfS6f+8nRnYRXWmmbSGiP98lksXSViHA67K9uluP6/itfc89c0BdLbDb3x1mwUwu9GhyFMDGX9xzoqqnBO1oW1bdMZKO+NpmVi9GmM3MWjCkbJkUJHSEuE3br/3Pd8efYcXdDg1cTd4hO9kPxuoj6BfWNHkNNvF/BlsvFO2npxCf5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUqxDdXETxmiq+tjT51fm4LOd0AzveYnoUwRjwn9Wao=;
 b=KSuYuFf/oSIJMxshGwFvcTScFmylDmu4uNOR5ZOB0AUdIv++Q4tzL0Ly04ahvmuB557d0PPJGjRguH6gpbifoltCpmLAmXWO8av5E5jmmZjye0kRoDBHmnuaTOh7sFWaz/Ht+poKRgm3tiRTS4aonQTMErYgw16ZPY2mbCxU6pE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 15:25:32 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 15:25:32 +0000
Message-ID: <19ccef4d-fcf9-d772-4a5a-4e57779ecae6@amd.com>
Date: Tue, 3 Dec 2024 15:25:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 23/28] sfc: create cxl region
Content-Language: en-US
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-24-alejandro.lucero-palau@amd.com>
 <20241203143749.GH778635@gmail.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241203143749.GH778635@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0026.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::13) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN0PR12MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: db7a8a90-9ab9-43bd-3f2e-08dd13aeba20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWdrNXhCSUQvMGxTTk9IZWt3UGJack1DNFBubkdUVE9pc0VKek80ZWhLMkNL?=
 =?utf-8?B?cTVwRDFsRkZsNGVLUzZQM1JSR29nRmEwUENFUnFobUk0cllhcjBNMGVUazFY?=
 =?utf-8?B?ejRGQkNqVW00WDNFTHk5MXBZVTRhRjdlaHNCblJIdXV0WUdRTHdoRVp2RHQ5?=
 =?utf-8?B?VStmSjhSWW9DaU9mU2RrUUlvN25uTmZMdml2TytTVDhrSVFuMjBJU1RHV0s0?=
 =?utf-8?B?R2VvOHhrcnFFNUc3OFZkODRXeGh2MlE5YXF4aFgxOEJpaVZLY1VYM1BwMks3?=
 =?utf-8?B?emJTb2RFcnplVjRuZERaUXpKc0l1TDhsanFtQmVWL2ZxL3Z1Vkd0dWlzMHVM?=
 =?utf-8?B?Q0N4T1E2MGZQSDhxa2JmRFdTU2pwODlEVlBMKzFFZTYyb1ZMMXgwakZoMCtu?=
 =?utf-8?B?QzI2cElEN1pGVFZQQk5NQlR2VVhCZW1ZbkdrWVByYUhKQVM1UHB1MEpEcnF1?=
 =?utf-8?B?M1RrN0RYdldmczVIL3R1SGJjZkNQdStqQTUrTlVmNTc0WXA4T0c3ckRVdGJ2?=
 =?utf-8?B?ck9IZlZSNnNzb3dRbFY5SlN5TVlZbUR3bVEwTU9jSmVpYzU3OUdka0QvRXow?=
 =?utf-8?B?ekc0MkRsb2g3dzZIQzJwbE5PM09NckliTXZweFVqb1NMREtINDhmcyt2RzFO?=
 =?utf-8?B?R3BxUGYrL1lWUHZzUm9ldVY1ck01dmI2MC91Z3pZQng2UVh1SW5YUzhmZGdo?=
 =?utf-8?B?WVFrTnZ1eGxMUHhsaTRIeHBGVkFlTzlMeHZHMmlmQ25QVUk4Rk1YclprZFNY?=
 =?utf-8?B?UFlxZTYzd0xiWC93SFd3V2llQWNZVW5DTXRkWE1wRzBYZ1psb2VQbHlUWUlZ?=
 =?utf-8?B?d2hwYUdiNGJCNVlZSmpyem05dkU5TFlwaXZleGoyaUlQNlE3Z1dlT25PSzls?=
 =?utf-8?B?Q1dZUk5KYzRHemJSZU1zakV5eTJlOUk5UnVBVWF1OGdBV2ZYY0M0R0FFdVhr?=
 =?utf-8?B?MVV2SUd5R2J2czlteHNGMGo4UWxNWTZFSmEwNC9aeTJzcGF0Z0NpcFoxWHV0?=
 =?utf-8?B?cjltcm1mSGhRNERLclpWWkZHSHdlWTlSV25JY3o5eGRRNHRyZ1R6SFBERDhC?=
 =?utf-8?B?VGwzbExZRlc4eHJ0YUJvV3JRZWMvVW9RZmtNZVlxaGJPYlVnT0xOVE9RcmRL?=
 =?utf-8?B?a08vNTJTbWtHSHNqOW41YjF1emZQcm1hRy8zajZvSloySGJpTi83R2ZYRkNV?=
 =?utf-8?B?YVgwV3U3MkYrT0VYMFd6dlJRbm4xZTBpV0JRTXV5eXZmMlZWazRRWldNQlJT?=
 =?utf-8?B?alRIN1JBL0w4NHNBcEpSRk1wcmYxczF0M3hWczZIUTZMU3AydzhxTERoc3l0?=
 =?utf-8?B?S3RCRGFYclN3Qm4zWkNGQmlzZGdWelRWS2VuNzVxcS83VElwMHovQVVIN010?=
 =?utf-8?B?STVVcDFuYzQrUDF4NUk4d2VEc3RPdXFZVGpnbnpYWWsvOFYrTzZiVGtQU3Ft?=
 =?utf-8?B?L29iN1JnT29Kc3V5ZTAxQXZxQkJrc0xDYmpLMjlWTlZtdVFLQWhSb1Z4NXR2?=
 =?utf-8?B?SFh1L1dzZWt5Z2VrWWpwd2tOS3lDQXE2Z1VKeDNtV0ZPUFJ0bzFpM2RKcXh5?=
 =?utf-8?B?ZDdWdlpxYkErNXhac2xIVkJrQkpucFBZM0xFeC9SWkZRM2lQSDRHVFAvTjZ1?=
 =?utf-8?B?WWdnc2VIY0w3eksreXExZHpxRGZLZzV3S1Q5aHE2V0dVcHorNks4OW1HcHRl?=
 =?utf-8?B?UlFNaXdPMHQxV3BiOEs2ZXlaeHN2Y3RoSDlGemplMEsreW1rRHIrUU5IRmFB?=
 =?utf-8?B?RWREU3ZuYXROajZGSWUySXk5MzJwQ1hWQjhSZ3A5WlJJRFZzYllzdGVTSnc1?=
 =?utf-8?B?a0pPK0JyS0hZYytreVdPbi80U0svVlVUNG43WG9ONTlwSjlvbXV1RmxVTm0w?=
 =?utf-8?B?M1Y5a254ZmE0dCtaL2pWanZTR1ZXSTRMNDBPY1k2UVJhaWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0ttYmpRL3U3S1Y0M1dtNU5hRlNVRm9TTUVibXFhWnhQT2dCN3N6UExUaHY4?=
 =?utf-8?B?OG1oWVg4aVE5bUlJWkMweWFmbkZzR0lhZjlVRjBZdmNWdmNIeDJlR2tQbjhF?=
 =?utf-8?B?UlVqNElxQUdYMVpkd25XRFdDRGZ1VCtuaHBIYVJKeEFkUGhtdU9OS0JlZ0tJ?=
 =?utf-8?B?WWlTV3BwOGZYV0c3Y1hiZ0E5MzViZVRLUzZlYmd3MmVGS3UwRmNzWGdFVzQx?=
 =?utf-8?B?ckM0dXVuY2o1OGpMN2FUT2FoNFY5dkJDYjIxYjZBNUtMRGppVzJCMFBWOVNJ?=
 =?utf-8?B?anptK1FqQlRCa0lMN2lzMC9MalFCblUvRDFvcFk1TEdVQzR0UEh2QUpieXdE?=
 =?utf-8?B?TE1kNDE0ZEJ0K1pORUhKanlSUHRqNG5udEppbG1VOXZ1YjdINWJBb2pBako4?=
 =?utf-8?B?RXpTTXV6V2l5WVRkQXJ0YnNZRDIzek1iTmEzc2JIbXovZGhtUHVHYmhuQ3lu?=
 =?utf-8?B?VkFsVVk1bmkrazFSdktpZjdHY0NOVVowZURWZGx5N01ZSmtCU1ZUeGpEcjlk?=
 =?utf-8?B?ZGlOejdEY2xjSWRHell0MUZYL1o0OEtsV1pSeU1EQ05TL0xrQitzMlpML0kr?=
 =?utf-8?B?Z3hMSzh6Mmh5MlhmWVNxOTVybW1RQWoyT0MxMEtvdG9sNFJESVNHZXdKQlpP?=
 =?utf-8?B?V0JSQUczS2dYYnkrZTI3QWpCei9GRTFtQzNjWS9YV1dDdlVqeVpuTHFkWncy?=
 =?utf-8?B?MDc0N2dac0k5NktxVWExU2hrUnFJcStUOGQ4UE1MVUZ6MzVrZXhOMTFvUU9B?=
 =?utf-8?B?UnNUb0NTK1FHTGlieGVjQm5FRHBjYmdpaElTc3kxSG12YnA5NVFWZFN3TWt0?=
 =?utf-8?B?QXRrby96QTBSL0g2d2d4NFZDSXJOMjV3RkZla2laWStiQWZPRzlZc1Q5V3Mx?=
 =?utf-8?B?dG0rOThvOWt4N3BGa0t3K3RhVjV0YzNseEpVUll0M3ZONWNWUVhDVkxzTWo3?=
 =?utf-8?B?djc4eXdtVDBDazVTbU5zcmlTU0gyTVIyUTVoejQwK3hURUlmaVJLY2x3OTgw?=
 =?utf-8?B?dWZNRDJFcVZXS0xGNWI0N1Z2VjVlaFJQakVabXpDelF0RjJyQ2ovc1NhRnZm?=
 =?utf-8?B?aGttR1hDWm5lVUxTVFp0NkxIbHh3REdadXZETkFkeUVwNGFYNVBlQ3E3eklW?=
 =?utf-8?B?M3drR01ucTBOL1R0czJPeHpad1BFclAveXJiVHUwbjZ3UTJ4TXNOWFVFeUZK?=
 =?utf-8?B?Y1l5WFp5VldjSE84VlZia2U4MitFVkVZU0lVTFp3eEx0RnlsbVBFN1AvUWRl?=
 =?utf-8?B?QTEveFIvVmlTQVEwWFdkemh3TzNYcFYydFBUNng5c2YxQkU0WGJaYyszdDZQ?=
 =?utf-8?B?WHRqTEw0ZU9UWDU1UHk0TC9DQ1dPak1RdU5VTUZaT0xGakt5eHpsSGQ4VVQ3?=
 =?utf-8?B?ZytiZDBRbXNBazlLcSt6THdpVFJ3Z2dxS2VtcGVRTEpPcXE3OGN6QWlmM0pr?=
 =?utf-8?B?MHpvcnl6YVkvd01GZjYydmY1MGZlU0FvcGl0TFJhbGRqeUdXRzN0bWc2QVBH?=
 =?utf-8?B?QmJiV0krMXpyU0RUdUtZbGd0NmkwWDZZL1JhQ0l5SjRmZG4yQU9wTzhMTkkx?=
 =?utf-8?B?aENzeG5aSWNjZGFWQjBrb1BtYlJHeUxWNEtHRlNVcU4vWnBtbzdxMHRkS3Rw?=
 =?utf-8?B?T21DU01oWUkwZ0ZhL01vSElSN3dXdExLRE54QzVQL0dNQzNZNUZiVUpuY0o0?=
 =?utf-8?B?c2o1aDlOWmxTNU9rMENrU0lyVGRpcDMxNW1OL1BBZXY3VkJPMkRrcmpLcU9Q?=
 =?utf-8?B?cWFPVlJsOXlGaUdyOHlmcUdiWGFEV21MWUU4YWNoK0F5Sys2b2tGMVIwZito?=
 =?utf-8?B?UXVwWnhGSisxM2ZCUW8vbm5FTDlsYWsxQ2ZlbHdYRVp2VkxZOTJxY0Iwazl6?=
 =?utf-8?B?WkY0bVcxNjR2eHdLb2llMkJ1Ulg2ei9DajdDRmFNWE8ydFpjazJUVFZ1dGcz?=
 =?utf-8?B?aC9LLzMrQzdLdWRmb0pjcjRNOXBnNnNZWTNJR2VpbkYyaEJhR0QyZ1NwVSts?=
 =?utf-8?B?Y1NNTDg2cFlZc2dWZ25UR0JhU0d5MDJyV01QOWJrbXQzNDB2UGhybmFQYzlK?=
 =?utf-8?B?anNCNVkya0w5MFZvdGsvMUxkZFIveS90WkJydnZ5MzByaWRvM1pZaHBzam83?=
 =?utf-8?Q?LZ6X+rbS35eOQ9DofDv92tkG3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7a8a90-9ab9-43bd-3f2e-08dd13aeba20
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 15:25:32.6999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDQBXRh0TSmxGUVISDD8j3QQrYCOh8g1UZFWkVkKG0/YUcK7z/HmerZdshXtfQCGEpYjTSWqRchASI5QmFstsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859


On 12/3/24 14:37, Martin Habets wrote:
> On Mon, Dec 02, 2024 at 05:12:17PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl api for creating a region using the endpoint decoder related to
>> a DPA range.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> One comment below.
>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 6ca23874d0c7..3e44c31daf36 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -128,10 +128,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		goto err3;
>>   	}
>>   
>> +	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled);
>> +	if (!cxl->efx_region) {
>> +		pci_err(pci_dev, "CXL accel create region failed");
> This error would be more meaningful if it printed out the region address and size.
>

The region can not be created so we have not that info.


>> +		rc = PTR_ERR(cxl->efx_region);
>> +		goto err_region;
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>>   
>> +err_region:
>> +	cxl_dpa_free(cxl->cxled);
>>   err3:
>>   	cxl_release_resource(cxl->cxlds, CXL_RES_RAM);
>>   err2:
>> @@ -144,6 +153,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>>   	if (probe_data->cxl) {
>> +		cxl_accel_region_detach(probe_data->cxl->cxled);
>>   		cxl_dpa_free(probe_data->cxl->cxled);
>>   		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
>>   		kfree(probe_data->cxl->cxlds);
>> -- 
>> 2.17.1
>>
>>

