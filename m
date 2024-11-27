Return-Path: <netdev+bounces-147621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C879DAC07
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 17:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B6AB21B49
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 16:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FB4200BB6;
	Wed, 27 Nov 2024 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B2r9TWX/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8465201007;
	Wed, 27 Nov 2024 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732726067; cv=fail; b=oO4Djw/UXsCUAB3r/0s9pYjpJQSO0qcCXtm90fDzrMF38bloys0EQ6pLVLi5utgiKZIM+HJUEZixOVrgluBasy5pDFBE4nB2ym6o0D2B6T+/KZ50ryCvkYjt4IW2x4N0d6GdLzKrNjl5Wls2Wm+T7IWZWtOm8brH+weaHpidm5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732726067; c=relaxed/simple;
	bh=RSXdar3zXYs09/lYxSt6GFXpX8E0WSt7Y3fsn+eYUrs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E8b5eADFEZMtfTB3GA+4+OAO09xKtJN41IgKFEC6PDyl55sdIppLR8OFMAOK3PSqY7udCJa/0Qqx7wk/TOz8kGKmJHGN+EWj/4uIrGfoi0MMcEqf8CVb4HKW1kq5Q6Rb+lBqpMZKXfEbCIC6rEZWZT45l509s6UN/frWCZCKxiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B2r9TWX/; arc=fail smtp.client-ip=40.107.100.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLOT6Tslcjq/WlvXFMHXETIl+tkoatGJwlh85m3JcItGPzOVf6kvbXURH3us7jccXLwpGrKUbKZmbApNvsN6vUhsvLX8S5uOUKcKDLqFUi6e9X+5yRLoAOqaV3eEKnClAEl4ZXf6J62TYBerRnRTdl5mvL/dkSKBA23UW/Pa0bWjLT2/ja1i2xd2/9PO/AiuQQbPn5/1x9Z7zsXoTfpVrRz72LkIqdWhXpv5HBebLLsgLIqsyJQCrZb/AHgoTcoft32t/S0z1JN3lx0MkS6j7Ipy253pNcJeZDh/Ldvngwth8oakkJu3anOvy81XfAnbDTykRtBWA+HtloU0bdMn1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lx5ksZiFEcSv43sdwOUK3b+9c08NOgG2EzG/FgIp0zQ=;
 b=mXO+aq7CvgDc9o9PfLEc8eNlHW3Sog7g90ULZV6fSEy/+qKBa7MQrkWXXcv7Dk7Bhx/nYpXV9hm6RVTe2lA7rr9/QGeespttGT/lTHqEXpEWgdP258lOnZWiHiVqLxAwyvuK8UEkkT7LN333SqDacmDFMMrQ6c6OWqD3bJDGjI6Wg/er7nYSthq7gvLYxt3cogTOVdxEXmcqIte7kRM/zjj5VgR4+52q2Kw1Xn9W0H5lTnz52cmUVq6KH0g3qbK9AiJfuI4r8p+VSABs2i8dn1k+Ab4SdNa3joYoI6EI57k5VzsEZie8i2nXTykxMlY0JOf8uHglASNuXXsKffqM8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx5ksZiFEcSv43sdwOUK3b+9c08NOgG2EzG/FgIp0zQ=;
 b=B2r9TWX/wt4ObFecvOh6aAo+z8QVBxWBprvCKENfsodkf1yeYtsZDZU9VplIdsHlaUZZmFo4sMtH3cebXCVOWmdK5GX0cn5AMLSsd1JnYxZaOv17Qh/uuC5WiQsv6QOGUoE8KwTcAXCkI/T2/5WyC3sr5sWTY9qlm4LtKntz/kY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 16:47:42 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 16:47:42 +0000
Message-ID: <8c3a262e-3e73-6391-8bfb-589600832024@amd.com>
Date: Wed, 27 Nov 2024 16:47:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 18/27] sfc: get endpoint decoder
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-19-alejandro.lucero-palau@amd.com>
 <a633d595-88e0-4c7b-95d9-31dda88f712e@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <a633d595-88e0-4c7b-95d9-31dda88f712e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::11) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 04015074-6359-42fc-0bb1-08dd0f03360a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anFPVlVxU1JSVGNXWGFmWlZvaTgvZUczUjk0Mk5xNmpEd0V6M01wSzZod3pE?=
 =?utf-8?B?KzVPa2tRcGZPc2FqVElhdUlLWXJNZ25lUDFySGZiSG5EL1BmalJBMCt3Yjc3?=
 =?utf-8?B?SlpUMmlWWHdGWWdnS1A2elBGbFEyZlVmdkVtUUl4YlNWU0xIRmxjdUpyUFF2?=
 =?utf-8?B?cVJyWXhMcTNsU0szcmRHWHczeVpsMlAxTkZGK2xVWWhpTFJpRXNkTy95Qm01?=
 =?utf-8?B?L1U5WWZ6NXQ5dzdlRjM3Kzh1cXJ3bm1mTzB5cnkwbURjd0toOGw4blAyQ0Ju?=
 =?utf-8?B?a3VSTlBTS0EvYUQvRkIzNmFhY3NkeElzME5MbVpxZGxtS3lmS205ZEFiR0Vx?=
 =?utf-8?B?OFFZVEJkT1lodE5YK3NmY1pHdmVrMmdXYjZ6S2FYWDhDU001M3JrcEFVUFlk?=
 =?utf-8?B?V3diMWdkQjVzSTVWV29VUzBWdXV6S1FFN1k0RlpaaFk2SVdSUGNObzJMZEp0?=
 =?utf-8?B?RVdnQnh2MFZlSzFNbHQwVURKcW01WURtMjJvdHR0MnV2ZUt6L2UzYkozQ09J?=
 =?utf-8?B?SFJMT1FBaTJhYytCRS95NkpPQXg2VVNtM0dteUpxOERHTnRtaUE5YW5OM1Vq?=
 =?utf-8?B?TndEMUdyR091a1A4VGlabi80dit5eHJ0QVRVUnl3N1FUZDJiTlV6ZnA2T0F6?=
 =?utf-8?B?RzZIdkNzVVBQUmNVUmFGeU11UjdNMG8yMG5QMThvWVI4ZXpmS1NiazZzSEJZ?=
 =?utf-8?B?bXBDdjB2aHNxSXBsSFNwQXhDVXQ1YmllWGttSXNpTG1ZcUVManVUZkdEQnBY?=
 =?utf-8?B?MTAwTXNhM29FaHJ5aktYd0pJTnlJTUNrRzdaSXQ4ZGdWTHg2Q2ZyNXY1cS9s?=
 =?utf-8?B?MFQ2emJSTFNscXdGRFpKV2x2cU8wdjRRYnpOT2RXN1p3UVlndEFpODNEY0NJ?=
 =?utf-8?B?TTI1clh0MzBETDFIcjYxRlU3UlZ6cTk2TXVwMUZRUmV3NjZWSHdqakwxN2lO?=
 =?utf-8?B?aTFzNmVPQXJOY3RIMUp6WldIMUV4K3ZPM3ZpRVNMeE1vZm16T2JvbkIxYjJM?=
 =?utf-8?B?RWNNSElsTEdFRDVUQmNwanBsTDB1UzdPbmkvbm5XZnIvd3ZISkJrNmp1b1lq?=
 =?utf-8?B?THQyZHJqbFl3VVBmb2RCN2RCZjU3WGU5VEJadEZseGpGVzAya2Z0Qk1GbFdY?=
 =?utf-8?B?RGJtNjRza2R4NVRXTlh3cEt6UEUxMDY5R0lkWUVodGNhbzR0RXE5aEc5ZjFs?=
 =?utf-8?B?SXhBTWdJdngxZFU1MVhidGVUbWNOWUVLMFlzYkhwUU8zUkpRRllpMkRENlJ6?=
 =?utf-8?B?YnA5TGlGb21Wd1JpUzBlU0IvTDM4K3ZHajNDRU9pT24zZVhtMm8wOWYvWlph?=
 =?utf-8?B?REFOOThvN2tDL1AvV21sajFZVjh4NzVCb0svSldqTHp1K3NDNklrSVJmZHpX?=
 =?utf-8?B?Yld2NmxCcVk0bVJza3Nmcm10dEVlbnZHZStMV3ZTQWs5U1BaWFlIRmZRaHFQ?=
 =?utf-8?B?cFRuRWFmV3NEeWw1TU5YYm5YeHRKKzFXV3lHOGRYRUdMcW5BdVR5UG52WWQ2?=
 =?utf-8?B?dVhhSVRabm5TZEpZZGY3UUpZS1k4R2xpWTVUVVpIbW5GYnRndDZjc3hON2Fq?=
 =?utf-8?B?SEt6cVEzUlhOK0RxTlA0c2dqS05kYTdqRXpTOG1jTHkzTkdQczA2M3MraDVQ?=
 =?utf-8?B?NXdlYkxySGFGUUZwa1BHUUFEdXI0VjF1emtYRElJSHRVV25xck5XOGgyc1Ur?=
 =?utf-8?B?aTd1VGNhMGdsMlBYdGpzSC9lSVczVklCb3kvMi9LUEl6UGtEQkV1R2tqOFlo?=
 =?utf-8?B?QWM4MFNicXlxSXJMUytUcTJONG03NTJWTkI3ZHBObFJBRzJ0bXdYbmR0aWhn?=
 =?utf-8?B?NnU5UjdkeXBLWituT0xyZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGttWEFJajdpN1JxNFNwbDBKcTJTcWY1eHVPOUhjTy83TnRuT0FBU1djNFFZ?=
 =?utf-8?B?MGp3dGVvM1EvekFzam80dHNuY0V0eXA4NUVvV0ZZbDdYb3l1Y0FkTnh3SzNX?=
 =?utf-8?B?dW4ybTA1c3JzOG9vakkxZ0t6NWpMTi9UWVBEam9qNTNwR1lIYmJ6cnAvclZH?=
 =?utf-8?B?YWlBUTl3QWx4L2hDT2JGZ1o1VGd4TUlvdyt6WW03Vk5KYzJpYTNwKzZvVnMx?=
 =?utf-8?B?UDBiemRkUDBpOHVRMDRmT0c2S1hDR0pqb2VOZ3MvdFpZSE5kNDR5TXlaNGZp?=
 =?utf-8?B?WXU3RjVIS29mdmlsVk1ZWm9BRm82bmgrb0tiMm9ORG9IRDFxT1pNMmovYjFq?=
 =?utf-8?B?Tjdsc1kvY1JmdDV1Z0ZJQnBWOXlxQ1dQbElxQVBxMlhHMGZ4MDZtbEhvWnhV?=
 =?utf-8?B?aWpzWDBUMlRtRDNHbmFRd2E0RnZpV29NYjZnc1l6MG02K2FwN3g4Z0VOQ3NL?=
 =?utf-8?B?Nkd2L283SXV5R0V1bkJBTXRkcDFENzZxYmNacUdXYTNncHBlQVk2b1RHVmpI?=
 =?utf-8?B?WUdWRVc4NjJtT3FvbVVpYUFtK1psQktaWVNJNnlHRWpFdFVLT1FCYUtnRlg0?=
 =?utf-8?B?ZWphQWcxK3N1RVdMR1JtZTBITlJIR2F6L0hKbUk0aUlHRDBiNGRJY1Q3VG8r?=
 =?utf-8?B?dUFLVTRuWTNzN3ZkMFdhZ1NBSWFrTTVqQ1ZrK0RNaGhWOVZtTzR5MFpPVXNn?=
 =?utf-8?B?dGFVNkFPOS9uU2llb0JrOXA1ZzNWbTlpdVRXQ1IzQ2Z6dVpXSGhsMkRRZ21O?=
 =?utf-8?B?Y3lnRit5YWM3dE9kY2JpNzkxbUhQNXpWRzMwNmhhQUlqd2lvNXlYamZINXpX?=
 =?utf-8?B?ckVkWDJiZjBGWDJnNW9DdVVscEhGek95M21waVpNa0RLUHVSbEU2eDJDMnhR?=
 =?utf-8?B?dk94eVc0aHoxbFEySXg1SEh5c2ZSTHFVZzhNNEFSU3JrVW9YcytXcm1iRzZO?=
 =?utf-8?B?aEg5bUlqdzBocEFZTU1rRjdCYXlLN2VmMER1T1M5ZEEvMHFZUVVSWXVNZkZN?=
 =?utf-8?B?TDR2U25DNGFuRWFTK0dyaGxCWmlROHVXYjg0TThUWS95OUJhNzU1WGVoWFdI?=
 =?utf-8?B?VmxzOWNoRTd1NzFLOVhQOFpLMy9JVjRzOEZkZm1WQXY3aXI5NGdJcENiaEJ0?=
 =?utf-8?B?SUlyNC9yNU9kNjRNL3Z5anZ6bjcvVEE1Mkg5L2hDL1BSVEtOVjRLVTBlMEt2?=
 =?utf-8?B?WmxMaUwxMmhFTlFKSlNwRUEyODZ5d3dNWU1XbzNXNWVvTVVhVEFkTUNqVGpn?=
 =?utf-8?B?eTZ4TGNBSzlTVThaMHZyTmxnQmtneFFoenBPNEd4ZlFuVnJiVTdZYURwbDd4?=
 =?utf-8?B?YUxwanlYREJhV2FBN2pDUTJidU1yN204WFRFenVzMGoycGxYUUNrOHRTMW1G?=
 =?utf-8?B?U3RIaUtLNlA1Y1dtL29IVGEyRjNDdGlnQ1NNL0lkWkhXRkQzNG1aRnhlYXNu?=
 =?utf-8?B?UXpWeUcyc0xzZFFVcG5tSm9XY25mcWxEN0h3SVB6b2hVRm5tT1ZGNm1CY0xz?=
 =?utf-8?B?cFpTYWxPWFB0NHlzVlREK3I0QUx0R2poa2d2a05uaUJLU2xnbEdFRUhkL1dG?=
 =?utf-8?B?eVUvZzk0eW9EUGcvS1RUSmZzWDBSbUlxNXA5aE1uQ29JcUtmNnlzN3lCUGFt?=
 =?utf-8?B?RGVLWDk3MWZvTktYZXRXMjJ0ek5CM1I3Y1RWTXltLzMrK3Q2WHp6MWtKUnN3?=
 =?utf-8?B?VEZudTBFZkNDbGZQZGg1TzhWaWVJMFFkRG1ZQU1vTkI2ajQ5Ukg3K2F3Wlpn?=
 =?utf-8?B?S2d1Z0xXYzJUVlFXZTRnSndZY0lmSnBKTnRhNERKYzhUQ3BOMjArMDlPVllP?=
 =?utf-8?B?RnM4eEpyMEV6ZENZL2lIOUFJVStyL2ZZWTcwbjczQjNnZzdHWTVKVnV3ZVpz?=
 =?utf-8?B?TXVSOXR5WklLU2M1MWU4LzFSdjkyR0ZQRFdKcGhkZjc0TmhyQS8yMlVKSk4x?=
 =?utf-8?B?VlBUR05ab21sbXpiYWJsQSttKzRmSXEwU29CSGxtaCtmbGhabENYV1JHZ1hz?=
 =?utf-8?B?TllHZElucVNKaVVTUlMvdGVVTmpxWEI3L0pKcDN2Q0JMMFI3TWJKRGMzWi9L?=
 =?utf-8?B?TjdiRnlsR052bXVib3oxemlwaTF3cVRMMzJuMURUN0tIWURTRW10ZzExMnpI?=
 =?utf-8?Q?f9/mC8fkFVCj0Ea1ydOUDXWec?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04015074-6359-42fc-0bb1-08dd0f03360a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 16:47:42.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c95uD6LZB4fBqotESBsmu/BNW7Tmn3gcMCjhtZ/X2FOpuFICXTe1hXDXpa+3+utE6O7mybAF/uRzv0MfNZbuUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555


On 11/22/24 20:45, Ben Cheatham wrote:
> On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl api for getting DPA (Device Physical Address) to use through an
>> endpoint decoder.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 048500492371..85d9632f497a 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -120,6 +120,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		goto err3;
>>   	}
>>   
>> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE,
>> +				     EFX_CTPIO_BUFFER_SIZE);
>> +	if (!cxl->cxled || IS_ERR(cxl->cxled)) {
> I'm 99% sure you can replace this with IS_ERR_OR_NULL(cxl->cxled).


Right. I'll change it.

Thanks!


>
>> +		pci_err(pci_dev, "CXL accel request DPA failed");
>> +		rc = PTR_ERR(cxl->cxlrd);
>> +		goto err3;
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>> @@ -137,6 +145,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>>   	if (probe_data->cxl) {
>> +		cxl_dpa_free(probe_data->cxl->cxled);
>>   		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
>>   		kfree(probe_data->cxl->cxlds);
>>   		kfree(probe_data->cxl);

