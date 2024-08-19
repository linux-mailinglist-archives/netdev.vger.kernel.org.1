Return-Path: <netdev+bounces-119759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1224C956DD0
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B47BB25D61
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8171BDCF;
	Mon, 19 Aug 2024 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oDhYNGNJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD66316C683;
	Mon, 19 Aug 2024 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078915; cv=fail; b=dNwivOTZWItiXzuZL9iRGPRosMuvxof71TOnWgM6pZXWv/BpTtiEFnj7cLTQyK/fvkZZe3P1PrCII7dv0FlVozd8mkbZdiAIpZNSkHDqmXqiR1F6KSA9kll5OaItf5W1HUdDJ8N2k02GlrG/ax1/UX+R1QrW+JF2sYgbxt86pao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078915; c=relaxed/simple;
	bh=qO1V/lPh0CYX1dOYumlZyC4ch/QXmTt49/wnuqsa+qI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kjZM6GtBqAKuKAFRrI29X3FB1lxtkZLTDuK6JtucxM8XWPwKSc6r5UtjY4iQlNvXQUaqWCYGnKSs/xX0VUyEHyWQnU6QkyytXK88dC1uFwIb39wQnZdIt4sjnXjiPRzh5K4INVrfUxchFwTVPXkCOCOVFX/qveDQ183EQIWyP8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oDhYNGNJ; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FtPLtghBCGbQUpFI1NO0BAx02x9s+d5RLEOvol4WYHNmZ+IgYq9zodNUkKcflWONYfxEcfk5SGb71QMPo1g4d7b5jX+NVy0QFoUIVtkTtiuKZsxkgpNXuKSVbrSgDqldNTxzYrC5mLGDTvA6Fl9LVI5lqUE+7RhreOleWPsgd53Z68MbUIVV/5cdAq5pUB7TEefnQxE0B9ZIRW6/xeFk9W2qFl/wqxE03WVeT8dID4H68noRvQV2HVrtEoBZ+YRiVkVQY+V8h1kWXYoEjtpbs0kuoVUViFrBioCCibR8iW/W1ghnJMfKxa+ka+JcHpmXc6SRROOR8oTRv8JdjvpbnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxgKcSwwEURqCTz/yvzdfi5QmyI9hm/7f/sy7K/z82g=;
 b=etAzJnfAC654LkndiPSfa4sohacOlaV8KwRv9uSQT1fCitt4e8kjptnFTi9NYq4jUAcGkerTycY/oBouK7LK4lwERtOc42JsykDbAqmkzvb6UfayhkIed+GDxZNikr5S2L5oyNYHx7txYxjzn0ThLlcxNiftXmopv/Dg56UQOeKVO9oxhJ+OynClo+sGDRlIg9GHM5ZwjgA2/QXhzOrrIL6LHU0+ewDQFgdmkkNl3IEZ/beHoX9musvQbInqJeq9UR9rkbNx9Wm4W0hysJoE5fGlPCJyweGYqx9qy5EXqzIk0B82+I+zGoi1+l90r/LudBSMh7FV0PoBbIF2Bdns1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxgKcSwwEURqCTz/yvzdfi5QmyI9hm/7f/sy7K/z82g=;
 b=oDhYNGNJ0eJG8ccTgSm9GH1+lK5uEvCknKAXRfWruAJDUvsLXbQITR37o5pBGfcOkwCtpY7TWUG79PrT1/WBnaZcx35XWBplWODoBrqahHKdcRdeiTqGfiwmA+JNAZ2isOkmXREJunyY8TZ/DV5l1NQ4RT2tsTRzJ+eNerO2SLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 14:48:30 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 14:48:30 +0000
Message-ID: <adcc692e-8819-3741-31d3-d1202cc1b619@amd.com>
Date: Mon, 19 Aug 2024 15:47:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 09/15] cxl: define a driver interface for HPA free
 space enumaration
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-10-alejandro.lucero-palau@amd.com>
 <20240804185756.000046c5@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240804185756.000046c5@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: 6470702b-40b2-47b6-c3a5-08dcc05dfdb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amUyeGNseDRKQ1ZxVkJBYTBLVkM0TzBZc3V3N2xjN1JuYjB6dGhzVTBWMTZP?=
 =?utf-8?B?V0lPUzFad1dobVNlY2cvdlFrM01Pc3kxNEFLVVRlblRTdHBOVWJXS3hlQ3RL?=
 =?utf-8?B?aFFaRy9mSXFYQTNncGpaVDZ2eHRUemRXakp1OHZjdXorMlRkN1B2TlFtWC82?=
 =?utf-8?B?aVNocjdMU1RZQWVod0VtOXAyNlBsN3JSaGRjQVJKSDJPL1hQL3FBQ1NCUjA5?=
 =?utf-8?B?SHhieGEvdnAveWZkZFE4RWRaQVdTMGpCSFZHN3RXMUZROFJROHphc2M1WkMy?=
 =?utf-8?B?TFRwMExOUklXaW1ZS0htQ2huZUxzYUI2NFNKakNxbGNadzBRc1J2b2RmcUVw?=
 =?utf-8?B?Zm5DOVB6L3dmZnF4MlJSR3dKL1VFVWtCekt2QmlzS1lodzNBeWE0citBelhi?=
 =?utf-8?B?TUJndVptdHJkR1hFc3pvSWpzY0dPUms3bXBZWkkvQ0tvekl4SzJFYTFrOVEv?=
 =?utf-8?B?ZUVIc3VtL0hqMmtuNTQ4OVB3QmVVdDFpRjYxRGk0VUpiWmpLSG9JcmE2bTZN?=
 =?utf-8?B?V3Q0V2JsMnRPYjgzWnVNMzkyeHhjSGtoa1VqYW5KczZGdWRaYmMybUV6NW84?=
 =?utf-8?B?b2QzUEZiNFEvVVpmQVZRL042WFZnRnh0S0dicTdiY0psVVQvVzZGNElFNmdk?=
 =?utf-8?B?ZWNnVzZoeTVOQTNhOHdjYW1pa2VQTmdRdmFWU2tLcUxVUENwZHJWRGRGQk9z?=
 =?utf-8?B?SmFuRWtscnhkQlIwZGRtNjczS2tlWFo0ZjBNbFEwRlpqd1UveHUrcThKTU1o?=
 =?utf-8?B?endwVnFTMW16ZDVLem54bUhQTHh4clQ5WkhPSzZNMUJXZ2kyN0VLWk1rS0tH?=
 =?utf-8?B?emphVE9ZV21YNm04ejc1MEdMSDN4czRtNGhFdU90dlIxazRBL0ZVblJKaTJR?=
 =?utf-8?B?dVBFa200TG5UbmM1WXRLb1YxcXNEa1lDZ25zazZGSVBlRkdIcWFQSTR2UmVm?=
 =?utf-8?B?T3p2aTFoYnUyQ2x2clZKa21wZ0Y4MXRNbmYwcUpMMFVjbDNyZ0FaOWxZQy9y?=
 =?utf-8?B?Vi91TTM2T1FwQUVKTnIyVUdZdmNuOVJZbzhSOW5IKzhWOG55clRZaXdmbDho?=
 =?utf-8?B?ZmNzMHJ5dWtTcXNrQkFqTFVGZ1ZXbkpJYnRHcEVjQ09qWEs0bmhkWHVMMzZ4?=
 =?utf-8?B?TitGcW5JT2hjUG5hNzA0b3FVMnlSTVFsUm9TT1M4amxiZzcxeXI1elFqa20y?=
 =?utf-8?B?VHNIQk4yejZOVnNPN1pqUzFuUjdrVGNVbzMyMUNYZ0Z2OUFCRjJSUHYzdlJJ?=
 =?utf-8?B?TzZJWWUwWTNDZi90OFVRMng5TkV2L0pORE4wTGFJUlN1anJldHYxNHJDcFI1?=
 =?utf-8?B?aExmaUV4V2NjNStEcHpEUk82ektQTjV4b1pKN1FYaGJ6Z2p3azZXbjIza1hv?=
 =?utf-8?B?bnpsdEhzQTlCNG9KS1BBbUFXS2JoMkhCd1M5Z2xwZlpFUWZCdC85djlyMmJl?=
 =?utf-8?B?Qmdld2dGMm5RRzNiWkVJaWsxRTR6Rlc2Znl5N2c3ejZTdHhJR2JUZk1LTEgy?=
 =?utf-8?B?NGlNS2RnZXArNzEyY0U5d0VUUEZsb0ZreTBSaTZKazRwWmMzbmU5ZHNhNnpj?=
 =?utf-8?B?OHR1ay9YSjdGRTh5ZEJrdGxYNWFiaFlpbnl6TWFabGtkWUhKOTVHRGMxM3NO?=
 =?utf-8?B?cFpYRWZSajVTN25FY2Y2ZEdIWHNiRnhTUFgyVzByU1VmUmUvQWhJOWJtK0pk?=
 =?utf-8?B?Qi9BdGpkQ0dueDBwOHdiS2FqTEFWald1UHdTeEhxeDI1djJLWUpnaHZvZEFn?=
 =?utf-8?Q?Koo4ebnpr+erUwLkwE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eE01OEhnR3kzc3hqU2t4TXVWZlk4NkdnSC9rOHlacTlpYjR3bm1XMWZsd3lq?=
 =?utf-8?B?MXRUMU4rcCtQcUREVDIrMGM1YW5wN2ZnZjV6Vm0zRDVPcDI1WVBKL3haTW5X?=
 =?utf-8?B?UGp6a0ZTampYbjUxaUdKZjZZSDhLR1FsTmFWa1JoM0EzYUNTK0EyUGJoSEk5?=
 =?utf-8?B?L1dLL1FLTzFCcm5iSGUxRC9wNGk3dU9jYlNkUmhPYXlZeSs4ZExOMzR4NTMx?=
 =?utf-8?B?RkpsaU1NVEtRM0V1TXVoWUtiaC9wd3l4Y3YwOGFaWGlOZjRHN1l4VE9SU1NF?=
 =?utf-8?B?dWZWVCtIY3JsVGYvSGQvZi8xVFJIQWRUcHMxTEF3VTNuRC9iVzlibXlmeTRO?=
 =?utf-8?B?ZGREUWxzQVlrSEdQQXVUclNrNWd1SExjU2NjUHY5Lzhkenl6WTEwSVRBc3gv?=
 =?utf-8?B?UDE1WGJEZ1k3cWtLTlZsSFJLRjM0RE1qUTFUS0RMUFhteW9SbHlyK1JxME0v?=
 =?utf-8?B?emNaMU9nVFVUeGJGYjNkVTNud29WQ1BYd1htdWR2eUFtbFV5cTRSNWhJVW43?=
 =?utf-8?B?SHFZcVl5aUpHMnVuenlmQVpjVUIyWmlQRlJhbituL3hCVTZIdllGTGlSNFZK?=
 =?utf-8?B?bzJuYlBaU0VWOFowV0JaUHFsMFc0SnNwaTdvUllQM01sVTZnSSt4YjQzWmVC?=
 =?utf-8?B?UzluMmxCNHdpS3hTM2xTcHhMVDI0MGplSjdKSzZiUmdTTFo2WUpqTW1kdmd6?=
 =?utf-8?B?UFl4TXFTTlZBamNqME1qSk9UdnFkeHZQeDlUODVndXhJeW5PYUxRU1hiRUpD?=
 =?utf-8?B?ZWJUeFRTSUVlZ3lZejZDQTE0WFdoN1gyMyszb2Rzd3ZMc0xIc1U2SGhiQk91?=
 =?utf-8?B?L2tFSjkzNDltZjNhUlhVZUZSNTZRUDFsNmxiaGhPNDd3V3l4dVBLaE5DTmdS?=
 =?utf-8?B?R0JwcW0zUHE2SHhkanVOSEJXalRSbFRBTUpsdTNGRjkrbG4vTXlIL2xvcGJr?=
 =?utf-8?B?NjArY3NQQzFXNUc5R0tOR3JxS1NobE5YR0JBLzNBa0tuT2R0YVJiNmdQZnF2?=
 =?utf-8?B?dFVNazA4SzNyY25TN0JTOWYrd3lZSDZxNGtoNlVSUzFrc2YvQW9Zdmd0Z21M?=
 =?utf-8?B?dHdZSVFqR3dFbnRkcUlWQ3hhV3czMWxUWjdIR3BlcWllSVRseVpJRGFnbnBV?=
 =?utf-8?B?VmdTZE0wQ1hoSmU5RExJOHdaT1NscUNmUjBQblNaS0lJRTVHT2VYVkd0dUkw?=
 =?utf-8?B?L1RyR3RwbCtWakJiVFJqRE1UTitUZUdpV0tiYzRKUE9KY0lZNUhwdnhUWjdB?=
 =?utf-8?B?azZkblhyOVFyTEt1LzdEcmhNaWpITFpOdVVrRlZkUkpDbWhFWDk1cTJlVEIx?=
 =?utf-8?B?Q1ZjVTRxYTVKaTRVWk11SElmQm1pbmJqbkxpaUMyK2RRdnBBRzlnZUVyRWZ4?=
 =?utf-8?B?NUZFZTdtVVFqb3MxNDZQS1Bqclo0QkNabWdiNDJQYnM5TzUyV1BUWExYMUYr?=
 =?utf-8?B?eUlpQms4Qm80am5SYzFlTHJ1Nzh6TThrNDJhOVRWdG5RQjgxVCtPL1dtbnRp?=
 =?utf-8?B?cmpjbHNERWEwMFlBUXVhYWJneTZndXhFV3lDVkRaSzFvVlpPM2lBWk1LWXoy?=
 =?utf-8?B?WGVvZTIwZU5HVmhIQmxvWllXYTdRYVdTb3ZtTkJwb1AvSWRBOGtWUU1WMTUz?=
 =?utf-8?B?TWdqVEhRVFl6cFdmTWN5bExDdzB6MG1zUVRaQWx0bll0UHdqZkV3V2VWNVo5?=
 =?utf-8?B?Q2h0U1BmakJMcTAzdWZQTnhwSW9ucWZtVmtvVlRFRHFmanZ0Y0h0M0Z4T3g0?=
 =?utf-8?B?Vkt6TnRkbFhPQnkzMDQvaWNFa21rQlh3bUhCbkVkS01jSU1id000bVdwMW95?=
 =?utf-8?B?RldvenF1bytNMUNrSWRFNFdQcWxnWVYySkM3a1F4RE5SSCtNdm16N1Vwa2tZ?=
 =?utf-8?B?ay9YdHkyLzlUV1haWXl4WUFVYUdCRElNTkp6WUVUb0pyck1TVk16RXRGd2dE?=
 =?utf-8?B?SWozL253VENRR0gycFNyazBZZDJWZVgrN0lyV2JmK3hkcmk1ckFBY3VhZTdF?=
 =?utf-8?B?dnYzNm5WNGxlcVNkRG16Yi9Ga3JRRGpsekpNTWpMSU5oSHQxa3NXek1sTFBs?=
 =?utf-8?B?eVdBbXYzM1ZobjNLSnliTFVPZExOZ09nTkRKVzBVb2ZFeTRySG1zcDllbWhl?=
 =?utf-8?Q?KVIqiVkuHEnfmD+47Zj5UxwUr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6470702b-40b2-47b6-c3a5-08dcc05dfdb8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 14:48:30.3937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDotmB1YhlsGdfzBCviVkEfu1aqcoY+W6gR0gSQTFmloMc9HQ8xcrmruu69P/CsYFc784Jx7TialSgdudMaezw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727


On 8/4/24 18:57, Jonathan Cameron wrote:
> On Mon, 15 Jul 2024 18:28:29 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from device DPA
>> (device-physical-address space) and assigning it to decode a given HPA
>> (host-physical-address space). Before determining how much DPA to
>> allocate the amount of available HPA must be determined. Also, not all
>> HPA is create equal, some specifically targets RAM, some target PMEM,
>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
>> is host-only (HDM-H).
>>
>> Wrap all of those concerns into an API that retrieves a root decoder
>> (platform CXL window) that fits the specified constraints and the
>> capacity available for a new region.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m6fbe775541da3cd477d65fa95c8acdc347345b4f
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Hi.
>
> This seems a lot more complex than an accelerator would need.
> If plan is to use this in the type3 driver as well, I'd like to
> see that done as a precursor to the main series.
> If it only matters to accelerator drivers (as in type 3 I think
> we make this a userspace problem), then limit the code to handle
> interleave ways == 1 only.  Maybe we will care about higher interleave
> in the long run, but do you have a multihead accelerator today?


I would say this is needed for Type3 as well but current support relies 
on user space requests. I think Type3 support uses the legacy 
implementation for memory devices where initially the requirements are 
quite similar, but I think where CXL is going requires less manual 
intervention or more automatic assisted manual intervention. I'll wait 
until Dan can comment on this one for sending it as a precursor or as 
part of the type2 support.


Regarding the interleave, I know you are joking ... but who knows what 
the future will bring. O maybe I'm misunderstanding your comment, 
because in my view multi-head device and interleave are not directly 
related. Are they? I think you can have a single head and support 
interleaving, with multi-head implying different hosts and therefore 
different HPAs.


> Jonathan
>
>> ---
>>   drivers/cxl/core/region.c          | 161 +++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h                  |   3 +
>>   drivers/cxl/cxlmem.h               |   5 +
>>   drivers/net/ethernet/sfc/efx_cxl.c |  14 +++
>>   include/linux/cxl_accel_mem.h      |   9 ++
>>   5 files changed, 192 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 538ebd5a64fd..ca464bfef77b 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -702,6 +702,167 @@ static int free_hpa(struct cxl_region *cxlr)
>>   	return 0;
>>   }
>>   
>> +
>> +struct cxlrd_max_context {
>> +	struct device * const *host_bridges;
>> +	int interleave_ways;
>> +	unsigned long flags;
>> +	resource_size_t max_hpa;
>> +	struct cxl_root_decoder *cxlrd;
>> +};
>> +
>> +static int find_max_hpa(struct device *dev, void *data)
>> +{
>> +	struct cxlrd_max_context *ctx = data;
>> +	struct cxl_switch_decoder *cxlsd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct resource *res, *prev;
>> +	struct cxl_decoder *cxld;
>> +	resource_size_t max;
>> +	int found;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	cxld = &cxlrd->cxlsd.cxld;
>> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
>> +		dev_dbg(dev, "find_max_hpa, flags not matching: %08lx vs %08lx\n",
>> +			      cxld->flags, ctx->flags);
>> +		return 0;
>> +	}
>> +
>> +	/* A Host bridge could have more interleave ways than an
>> +	 * endpoint, couldn´t it?
> EP interleave ways is about working out how the full HPA address (it's
> all sent over the wire) is modified to get to the DPA.  So it needs
> to know what the overall interleave is.  Host bridge can't interleave
> and then have the EP not know about it.  If there are switch HDM decoders
> in the path, the host bridge interleave may be less than that the EP needs
> to deal with.
>
> Does an accelerator actually cope with interleave? Is aim here to ensure
> that IW is never anything other than 1?  Or is this meant to have
> more general use? I guess it is meant to. In which case, I'd like to
> see this used in the type3 driver as well.
>
>> +	 *
>> +	 * What does interleave ways mean here in terms of the requestor?
>> +	 * Why the FFMWS has 0 interleave ways but root port has 1?
> FFMWS?
>
>> +	 */
>> +	if (cxld->interleave_ways != ctx->interleave_ways) {
>> +		dev_dbg(dev, "find_max_hpa, interleave_ways  not matching\n");
>> +		return 0;
>> +	}
>> +
>> +	cxlsd = &cxlrd->cxlsd;
>> +
>> +	guard(rwsem_read)(&cxl_region_rwsem);
>> +	found = 0;
>> +	for (int i = 0; i < ctx->interleave_ways; i++)
>> +		for (int j = 0; j < ctx->interleave_ways; j++)
>> +			if (ctx->host_bridges[i] ==
>> +					cxlsd->target[j]->dport_dev) {
>> +				found++;
>> +				break;
>> +			}
>> +
>> +	if (found != ctx->interleave_ways) {
>> +		dev_dbg(dev, "find_max_hpa, no interleave_ways found\n");
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
>> +	 * preclude sibling arrival/departure and find the largest free space
>> +	 * gap.
>> +	 */
>> +	lockdep_assert_held_read(&cxl_region_rwsem);
>> +	max = 0;
>> +	res = cxlrd->res->child;
>> +	if (!res)
>> +		max = resource_size(cxlrd->res);
>> +	else
>> +		max = 0;
>> +
>> +	for (prev = NULL; res; prev = res, res = res->sibling) {
>> +		struct resource *next = res->sibling;
>> +		resource_size_t free = 0;
>> +
>> +		if (!prev && res->start > cxlrd->res->start) {
>> +			free = res->start - cxlrd->res->start;
>> +			max = max(free, max);
>> +		}
>> +		if (prev && res->start > prev->end + 1) {
>> +			free = res->start - prev->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (next && res->end + 1 < next->start) {
>> +			free = next->start - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
>> +			free = cxlrd->res->end + 1 - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +	}
>> +
>> +	if (max > ctx->max_hpa) {
>> +		if (ctx->cxlrd)
>> +			put_device(CXLRD_DEV(ctx->cxlrd));
>> +		get_device(CXLRD_DEV(cxlrd));
>> +		ctx->cxlrd = cxlrd;
>> +		ctx->max_hpa = max;
>> +		dev_info(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
> dev_dbg()
>
>> +	}
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>> + * @endpoint: an endpoint that is mapped by the returned decoder
>> + * @interleave_ways: number of entries in @host_bridges
>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
>> + * @max: output parameter of bytes available in the returned decoder
> @available_size
> or something along those lines. I'd expect max to be the end address of the available
> region
>
>> + *
>> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available (@max)'
>> + * is a point in time snapshot. If by the time the caller goes to use this root
>> + * decoder's capacity the capacity is reduced then caller needs to loop and
>> + * retry.
>> + *
>> + * The returned root decoder has an elevated reference count that needs to be
>> + * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
>> + * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
>> + * does not race.
>> + */
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
>> +					       int interleave_ways,
>> +					       unsigned long flags,
>> +					       resource_size_t *max)
>> +{
>> +
>> +	struct cxlrd_max_context ctx = {
>> +		.host_bridges = &endpoint->host_bridge,
>> +		.interleave_ways = interleave_ways,
>> +		.flags = flags,
>> +	};
>> +	struct cxl_port *root_port;
>> +	struct cxl_root *root;
>> +
>> +	if (!is_cxl_endpoint(endpoint)) {
>> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	root = find_cxl_root(endpoint);
>> +	if (!root) {
>> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	root_port = &root->port;
>> +	down_read(&cxl_region_rwsem);
>> +	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
>> +	up_read(&cxl_region_rwsem);
>> +	put_device(&root_port->dev);
>> +
>> +	if (!ctx.cxlrd)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	*max = ctx.max_hpa;
> Rename max_hpa to available_hpa.
>
>> +	return ctx.cxlrd;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, CXL);
>> +
>> +

