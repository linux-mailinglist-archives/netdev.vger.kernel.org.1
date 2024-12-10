Return-Path: <netdev+bounces-150642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CC39EB0E2
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9F416348A
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8925F1A08A8;
	Tue, 10 Dec 2024 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LVtFWgTF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0DB1CD15;
	Tue, 10 Dec 2024 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733834071; cv=fail; b=J3BLL6k/9z6noBK8THGn1orw/1YmeKVyhJi54W2+wFP8aVZPEO67zWcnjGkZKeU0Vhl5vO6cHpnnXKiJtonppzMZgT13HavnG9gAmsiqmg4CTms04xlOISZ0TV5OZpfDtfFrH0vkzHgmJVzOoxTqCeWjiKt1Bem/3Gve7nm9jsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733834071; c=relaxed/simple;
	bh=Avb5oAWXkEkA+inRJHgAbxdOSOFSlOZ/olbvOGD8E3U=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HqkohBvpoEpDdn8x4Ba2RNjAwhfO1bw1gGcv/XAnbRBmOetieMdjAf4cSJW2BKmuGS5rENLBvJ+ycMFaxfY11ISPKrt+nIQwfccjSDZcY0tzX9JtwS1r++LQkViP9ZKQ6PL5RAThap3aGDegHcXLnT7gK0CH/B1GOUVdHYZg9PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LVtFWgTF; arc=fail smtp.client-ip=40.107.95.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BI2hhwObPGwpXt10gKnbohWHV2bbZl2sEvp11nylIi+fJkbPCgoQzifSnvHqwcTdgUthdFBh4w4/ofqHgpQypvcvFwIw87xajd4Fx+DIRY/7+vl8K4A3NPRtXS7GVNIsK1uJtqDOTOOa0ovCGVeHp5LlwNhQ6tR+OU+jDsfiS3aFhbuI2/V2k2toVN70fRhlM5oDvC25VoJVyMrClLjU8FwwRp6CzJto2oRtxP+InHXolHAKEpRspKQ3NjR2qVR0KJEcr7xMdhkcmFJ82QitxafhaCJeKyeV+1IVNJHxkf72AhkOoicjVsxLhuil7T/QgmQCdwCOUF5UyWFpEbjRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RhU23e6/RuZqlul4eU6gabMmLGZ9W9tUM9XtTVyz2o=;
 b=h/iU+uszSJux7J2mjRD/ZU7+q9/hz9OSVdVYjzbv2+oL0SVZFYPgSbMQDrSS01UrGsoM3uMQfQrddHbsixNS697FHhvRLNGyW5+xsskJYIdR0WXmR3nQJ9oHOGdIgjkks16ikQnltNhuH64FCRlofheW10cJB3mhs09l4boZvYhew2TitXN+6N1snjbWCkJuaKD8uSvXTZCffKmUez6MB1wYONIEOizO6lVa7+565o/hvVtQ6xacgpa1HWdjGI6v2uwooX00klinfF1Vn60Y4HVlmvz10kKbgPfTNsY/hU335XL9efw9WxWGuIAxLv0cVCHxBu6HZehq/bh7owR6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RhU23e6/RuZqlul4eU6gabMmLGZ9W9tUM9XtTVyz2o=;
 b=LVtFWgTFf7mZ/de3rlpEKM91Xuds8/A+coePN9fMHXQf76r6LY0OSEdwnLHDoPsV7Oddw2zZNYqCg2Mu6Z+szhHIizr42otKJHNiSfskHeSClGOvTJ7eON74i6+Yx+Dsv2rrzvx1uswciDKfs/w3vwV9IFP6h+mH9XVxJWGDKAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 12:34:27 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 12:34:27 +0000
Message-ID: <5cf7fb31-5e84-5baa-5f43-37ba01eed957@amd.com>
Date: Tue, 10 Dec 2024 12:34:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 16/28] sfc: obtain root decoder with enough HPA free
 space
Content-Language: en-US
To: Edward Cree <ecree.xilinx@gmail.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-17-alejandro.lucero-palau@amd.com>
 <6c4f75a0-b63b-9591-5ffc-db4bf4bf3a16@gmail.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <6c4f75a0-b63b-9591-5ffc-db4bf4bf3a16@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0438.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::11) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 758fa3de-c382-45d6-31d8-08dd1916fc38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkhmd1dOUXJUYmdmeVVRMkRpNE5KN0FGc3N3d3dzcENLMFdlRGJCOXdpcDhv?=
 =?utf-8?B?enhKY1R2ZTUvMUdrQ0I2bnRYU1VNNjNnSkhodlQvTnprYnViUnJ6N3I0dndQ?=
 =?utf-8?B?cVpWYXBUdUlqZCt0cGc5STR2MjgxczZRdWtESm9Ob2pCS1pHdUZIVzBxcmR4?=
 =?utf-8?B?RVN6Y2RkaUYvSCswSkZ1TUhUazBvOEw3ZFgyZXVKUVptdGFKcTh0TGNmSWpI?=
 =?utf-8?B?c0hoSUQwSE03MTZMSXR2NWdRVG42NktQSitBZFZ3MHVYUld3NDFrcVhGR2ZL?=
 =?utf-8?B?M3A3OTR2Q0tnL1BRckJlWldNdGFla1BPM0ZHSFB6aHdPOGl3d2RpbTFoNHN4?=
 =?utf-8?B?cWo4ZjVRdkNmb3B4OEc1TjlIYXRYa1hxeXNycDFNU1lrRk82Y2JIOXM5ZFJu?=
 =?utf-8?B?dVp5QkNpOXlBNk9HcFAyOU9GR25lUWVzdndNM29HMEtIbDloM3JQTlVHMWJi?=
 =?utf-8?B?YzBiN1NHY0oyRkd1UmhFc1VIR1F2bGZleU9WUVY2VnhGYkV1K2JRU2FmKytN?=
 =?utf-8?B?dUU5bkxhcFlUMG9EQkJFa1U5MkFVSGNJK3RncHZDSlBVKy83OFQxajVqNW0x?=
 =?utf-8?B?K3ZhV1Y4VTQrWTFicHMzdE11WkEyZ3luV2U1NjY2RHUwUUt6VTlQdXV2OGF2?=
 =?utf-8?B?bWU5RVVYUHBEWnprTzl0dU56b3hEcCthUmlhMWhFRzEzZFpvRFdBS2Vjdis4?=
 =?utf-8?B?cDkxV0crejUzb2ZGT0k1Q2RmQXMzeHdJTk1iTkVVaGhuTTBQL1NIWXczWmpZ?=
 =?utf-8?B?QlpwTjVPZHUwUUJPdDMya3ErelFBdzNCM0Z0dVpQS3ZTa1dPT2FPbytFQWh1?=
 =?utf-8?B?dk14TGU0Rk5EQ2tpcVhVQVJDblJhcTlqZTIxT2NaanE1NXI1OG92MVdhMWhY?=
 =?utf-8?B?NGxidWIwcFhETUdLSytBZmJLN3hVZWVRbDhEdmJjSlJrS2llTjhEYWtXZ2ZP?=
 =?utf-8?B?MWdINWY0K0lkZVYrZWpTRjhaYTl3STh3THdVdDNJdDRSNmpkcHl1TkRSQmN4?=
 =?utf-8?B?dXM1clJ1ZFB2Ky9zRWgyWlIwNmZMM1g1MnZwbWszSGFyYjVsM2Q4blRrczhK?=
 =?utf-8?B?N2FXQ2xRcTVydS8vUWdrU0ZuWVk5QWplbi9OQmo0U05mSVJGTUJDQzgzN0tw?=
 =?utf-8?B?SUFtY0cwSVFyOE82QzBzTUFQR3RKU2FLK0lCRWpJSEVOUkRDVWJnSzkwVXFq?=
 =?utf-8?B?SnRSd1RSY3NMNDBHcEt2SUh4R3dteUxlL3VvVy9YL3h6U0lzUERpWDFzUGRu?=
 =?utf-8?B?QkxlVDlvamd5ZUdxVkJyc1JFWE1GczdRNUxyZXE5Q0RSTm42aUVXcXk2b2RD?=
 =?utf-8?B?ck95K1VEdzZtQVMvdVVzYlFFUzRvUkpUcjBZTXRVdDFaRDFKVGRLL2NRMXhq?=
 =?utf-8?B?d2pWNzJtMkRFQUgyZXhudm5ldENja2JINytPeHFxMm5OTGRma2l2aWlJVmtK?=
 =?utf-8?B?L3huZnFXWDNPb1JZUnAycjRkQUoxbDlHNlJMdDRXLzNDUzM2RHcyRG5LVVdO?=
 =?utf-8?B?NWxxemxEaEV6Y2RWZ0dZQW53VXQxSFNSRXN0aENRUXZsZVRFcHdwNUYyNndE?=
 =?utf-8?B?RnFwL1pKWko0SWR2UkJwY0N3d2ZKOU8wNk9DeGpBeW12dXAxNytYaEFOdHlR?=
 =?utf-8?B?L3VmdjMvRlMrTVp6NEI3cFhvN2gyaU1PRy8zTWxUSDEyQk5ZMERja2hMcy9X?=
 =?utf-8?B?ZDBmbGd6elJ3T2hRRWhkdzQ1YndWTFRHbXJSSFhYZ3FDak5YWVhzSWg3SGp1?=
 =?utf-8?B?WWdodURqTmZBZktXVm9rYUdBMlV6c1lWOGd6ZldSR1VRbXNRY3YwcmRHdW8v?=
 =?utf-8?B?TUlQTk5RS3BQajB0UzVGTG9qRWRpa0xjVkZQamR4dS8wdktucWpKYUJQVHF4?=
 =?utf-8?B?NzRNMm1CTXhCWDAwcFdBWkZ4YnhOdG8vWklYeUhlNWFTdUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWVveVZxa3lpQzRNejU2RjJlOU5LenNCN1BST05NTk5zYi81MW5SK2owaEQ3?=
 =?utf-8?B?SjR4TnUrVmZ6U2NRa1U4ZzMzZitTL3VOMEhBVFVZYlZ6bkdmcFA1UmZTaEEz?=
 =?utf-8?B?TWxXTmNyeXMxdnpEQmk2NU85bFdSTkR2cGttdHpSVU5OVmRzSkVuTnJMZm5B?=
 =?utf-8?B?RWhJUHlNcXh0YmhlT1kxS3N0SWtYbWo5Q2hEeXQ3NU53aHBoeHhZVzNjZElE?=
 =?utf-8?B?Wnp6V1pzR0Q4eFJteUZzRDM3RWhsYVZ2aHRTbjF5QlRmRUJOT0RPM2ZqQm5N?=
 =?utf-8?B?aDhOTSswOEFhR21XVWlLMU1PNlNleDZDSG5LL3FDY2dZZlhJVWo5Z2xxQ0FW?=
 =?utf-8?B?a0g3L1hldy9aN296aE5JSWliR2lCZnJNV2FGU1dyQkIrcGtIQ3VKUk1PR2tx?=
 =?utf-8?B?U2xPc0lPL1pSUy9WVGhYeUk0eWIyTUIvR1VKZUM0aytudTlBRDR5b0wxeHNi?=
 =?utf-8?B?WVdLMlFkOWlReTJJWmJvWkZlL3ZVdytWTWdhNVJjTCsvdlRJSjczSWNJaytj?=
 =?utf-8?B?UjZqQlUzRGxCTHQ1ZjhGcS9pQnpCY0FEUEdoM2ZZckZicnRzdVBmaG8vdXlz?=
 =?utf-8?B?Y1hsazZvekJCUzZqdFY4cms2QW9TMWhoRzJsWDNNamFZeGl6VE1jMmswL05H?=
 =?utf-8?B?cnVoRzdlZnpUcVVseUhpRWlRbVVaUVRyQWZpcTY5dXFvYW5nTXB1czdMaGhL?=
 =?utf-8?B?bVk4bkZ3TGxYaDNFWXE4NjgySWNhYzk0TkRKdEhiSGhpZ1BDT0theWxrRklJ?=
 =?utf-8?B?L2hDY0dHTmpXa2RSblFpREFYN2g4TStHb1E1L0tmSWEvWS9XZmNxbUltTkFi?=
 =?utf-8?B?dURvRUpuTllJZS9nNC9NRzg1M21xc1l2VXJiNitkb1dTbk9Xa0Q4L01KNkc3?=
 =?utf-8?B?NEpPUWZPdGRWUVhJbDc3UGZVR1p2bVpjalVDRjlkL3h6L0VyWnJBTFNsT3E2?=
 =?utf-8?B?YmxUMlNLSEpDSzZrODkzYk5YOVZOU0xOSkdja1dydk00bFM4bFVEdTg0aXN0?=
 =?utf-8?B?cTdYUExGY1l0cGVvT0duTGRTQXd2QS8vUFN0d3JVcSthZ3hwdDN3cTlmTllZ?=
 =?utf-8?B?YkxOZ1laVlR4NWdoQ3cwMkNKUHhhU3BNaXMrTTI4N1liZG8zeVA1anNNZ3RZ?=
 =?utf-8?B?SUZob3FVZTg1T3MzckM1dkkybkhoOEs2dnJKRCtNMHA1RStvVGc1SktteDB1?=
 =?utf-8?B?NTRyems3VnFUdjlHTEtVNHN0RjFoWEwzY25hVEpnOG8zeHNNNWR0dEpiazFU?=
 =?utf-8?B?M24rR3NqL1JicG8wTGhkY0lhSzgxSnUyNXowbDVMWmdhNnFyM3lYeUdNNXkr?=
 =?utf-8?B?S2hIbzA0ZFA4SjV6Ym55YTg4MmZZU1hFRnN5L2VodURrMVpHbmQ3a1FEejdm?=
 =?utf-8?B?bzJPQis5RWVWeWZadzEybGRqVXpQbllZZXNjVG5xRFJoR0M3Qjc2T2FhaG16?=
 =?utf-8?B?ZXRKRW9UZzhmWko4bkF5WWVpYnlKelI0VHJndHRiUk5Jck5jdTF2K2xvRDVP?=
 =?utf-8?B?ZDR6RDhHTnIvT05SQXRSd3gwR3IzR3VZSXNrQ1VMMTBKTnVEYVg0OVhraUlm?=
 =?utf-8?B?b2xMY25sNDJHdzNITDJTczh1bkR2a2ROeC9Va0xhN3htMFV3bWdWTkE0bXNX?=
 =?utf-8?B?MFVqRUUvVzJyMHJIcnh6QTJBeS9uTXBsV2dPWXAyRlpMcnNCRXF5RE92Z2Zt?=
 =?utf-8?B?WEFFaHhSdVZ0SUE1U0ZCdXFiL1J6Q3VJbHBneUtUMW90OHlVYmFmUy9VdGh1?=
 =?utf-8?B?QUJrVEp2MDZCQkkwSGJqYnJUZlZnYmpBaWhySDNmRG9jU05Rbkg3K3JVZjdJ?=
 =?utf-8?B?SW5TZjl3QXVBaEhCQkkrOUh2UWxiaU1aYk12VW9NaEZLTnBOejV2TlQ1Z3po?=
 =?utf-8?B?VU5VTVFzZE9rV05rSENzbGhaOWlQZEVrYUZDcmQ0MjlZN3d6ZDdlck9QbmNF?=
 =?utf-8?B?TWZwUHhTaWloMVV2TVYxMnhFS2lmV0ttUjR5ZTlGb2xqV1ZRampvdkdVVHMx?=
 =?utf-8?B?WGJmR0J3cng3OGp3STlWRUR5WHJ4aHZ0UlFSMTlOTXVyZWpNcUdzNWlaMW5u?=
 =?utf-8?B?VEtKcTVpWDIzdnJDaEsrMTBJSkwrUWFxeXBnei9jTHJDcncxVmxuTDVZYXAz?=
 =?utf-8?Q?tAiXMY0OqKr+NuN2sakGA53W4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758fa3de-c382-45d6-31d8-08dd1916fc38
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 12:34:26.9990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqqHsjXbH9Do2bF3gAhwXR5l4F92ZBuS91RVanmr58wG3QitGwGgLXyN8fl+CTbiG3w5u5O2Nj2G9iqYwYdvWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713


On 12/10/24 09:51, Edward Cree wrote:
> On 09/12/2024 18:54, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Asking for available HPA space is the previous step to try to obtain
>> an HPA range suitable to accel driver purposes.
>>
>> Add this call to efx cxl initialization.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 8db5cf5d9ab0..f2dc025c9fbb 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -26,6 +26,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	struct pci_dev *pci_dev;
>>   	struct efx_cxl *cxl;
>>   	struct resource res;
>> +	resource_size_t max;
> While it won't actually match because there's no (), the fact that this
>   is the name of a common function-like macro is not ideal.  Can you
>   rename this variable to something clearer ('max_size' perhaps)?


It makes sense. I'll do it.


>
>>   	u16 dvsec;
>>   	int rc;
>>   
>> @@ -102,6 +103,23 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		goto err3;
>>   	}
>>   
>> +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd,
>> +					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
>> +					   &max);
>> +
>> +	if (IS_ERR(cxl->cxlrd)) {
>> +		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
>> +		rc = PTR_ERR(cxl->cxlrd);
>> +		goto err3;
>> +	}
>> +
>> +	if (max < EFX_CTPIO_BUFFER_SIZE) {
>> +		pci_err(pci_dev, "%s: no enough free HPA space %pap < %u\n",
> s/no/not/


Right. I'll fix it.

Thanks


>> +			__func__, &max, EFX_CTPIO_BUFFER_SIZE);
>> +		rc = -ENOSPC;
>> +		goto err3;
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>>

