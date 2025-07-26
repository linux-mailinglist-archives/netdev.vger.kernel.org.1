Return-Path: <netdev+bounces-210283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834AAB12A3B
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 13:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A89A57B520F
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 11:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370F421A94F;
	Sat, 26 Jul 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="miD09Taj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D331C1F22;
	Sat, 26 Jul 2025 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753528103; cv=fail; b=DYyxmihuYQIzU7ZimYYzAKZQNxhw3O4YKR99AjEOujdAZgUO0Kf7ksfZ/X4qU0bREz7tfE+guHQ25iVwtRFurEKLmJ4J7k/MFIA7RzQ1VK3hYB/BROidhdpCxVtW24Q6Lj07KaPuLqnaadPqO3B68J9/dBpOo9b0tQnbkqF3mg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753528103; c=relaxed/simple;
	bh=01r5aTKdi/AZDQMwUykhtm/PyOgUenWLRQ40BB2AU14=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m9h6QNVZ//pOB91TazxEhQx6GCTEGhlCKSlC0tAhTPNo+rxBICPpujd7lJm7JgCB48vutv+N4jic4SEB2nl2mKqvJYSY00sHERS35mNLjxKGYDLea8ryZKN86nMspVja7S8wWTZqYODNU7162YSNiQXNJEEX0NDtn4RRRK/A/Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=miD09Taj; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdThfudW9yi1HPw5zS1rNSaJQhdblXvsrkq1Kvb4TCkuv73mhrYYxJ7Md4XOP46Z/+n5rLsIiX++r2DkLw0ABFuzplkURaZTppoUQq5Nqq7tU/HAmAK/ZNKuN0p5G3zOAhDsYUhAyXkfUj4CIJsoG5bFgNf0Y50ZymB4+qMN91bELGqDEdHqtauDJ0Iwnd8VP1okj5Hp3oh6UJBykeuLAuQ6BHBpFkXlBQBt60L1FPY30FvVtnO0DZs3LeLeaiRa3M7UtzMeGOoHxFcpfUuNJZtfuvS7B6b2mH+lrneD5QiWM3xa9lJyUWqgAJ0wUEjAJELjVEhfxY4d+Z1VOWF3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhuBlFaFqMlknZYG0K+z7U1M2Kxgpe6twi+OYozehg8=;
 b=rQIvkn73XCH76sJuDSWJW+O945vpvUMA6GMzzRwAvYGpk6T/yRYzkNjTWBoxBsyva3TFQzEamkcDaShayAdoANbsiSDBso0yQYkz35WSqvCI/IqfKGdfVIAjfVRn+spfhT3uv3siUSuOwOXtMFgWslajV+hOBHJWMZmcgBSnQ7GIhXZKTjFTK1L0fda0HOB+mhyRz4wrB6Sl2TaEZ9affA2oYKwcebUu1Y6NmUSu3z32yvdgfLvqkhwb4nZQNvNeqLIlpcIU2skVkJvgsXgIBCjcWbmqfH82dbDjsFY4Qwzx7uJTguALQuQ6NDh07Srh5c7uUC9wKV5YtzR8iIQUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhuBlFaFqMlknZYG0K+z7U1M2Kxgpe6twi+OYozehg8=;
 b=miD09TajgB6wQTi7Rcw2aTbhCcTPUlz0ArdzoH11M95HUhgSCdFA1l9/hcIq2F2lka3ghbTxIq6puU1/covqcBeLBGjntqIGJxcW3DSTJv+TtFnncxXVrFrRcUt1QKfIGjyYUqVH+u/5Sg47FKSNv5G3zMngT63sAB4gtvwn6R0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13)
 by CH8PR12MB9789.namprd12.prod.outlook.com (2603:10b6:610:260::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Sat, 26 Jul
 2025 11:08:17 +0000
Received: from CH3PR12MB7523.namprd12.prod.outlook.com
 ([fe80::f722:9f71:3c1a:f216]) by CH3PR12MB7523.namprd12.prod.outlook.com
 ([fe80::f722:9f71:3c1a:f216%6]) with mapi id 15.20.8964.019; Sat, 26 Jul 2025
 11:08:16 +0000
Message-ID: <c0f71a52-f818-4024-b2d8-ed784e47c93e@amd.com>
Date: Sat, 26 Jul 2025 16:38:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next] amd-xgbe: Configure and retrieve
 'tx-usecs' for Tx coalescing
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shyam-sundar.S-k@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250719072608.4048494-1-Vishal.Badole@amd.com>
 <20250725180727.615d1612@kernel.org>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <20250725180727.615d1612@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0253.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::7) To CH3PR12MB7523.namprd12.prod.outlook.com
 (2603:10b6:610:148::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7523:EE_|CH8PR12MB9789:EE_
X-MS-Office365-Filtering-Correlation-Id: abafdfcf-d2e7-453f-b331-08ddcc34b848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZS9HemFPU05xdU9rb2xXQWhpV2FJTE1IYjgvQW9XV25MRDlSYkRsOXQwYmUr?=
 =?utf-8?B?NUMza1ZTYWxoUWwxRHpsK0QrZ2lSNWkwZ0xHenRXdW43Z2Y1UWpoOUtjdDhm?=
 =?utf-8?B?YTRFNWpyUnJUT1VCZ3BhT2RuVjM4a3RkTHU0QWNoMjR1b1pqeWxQZ1JvZjhN?=
 =?utf-8?B?dVNrNVVyTHF3bXVEaFBmL2JtZWl2OG4zOFN6cnJURkpIQ1JxcFpuUEtqVHJW?=
 =?utf-8?B?R09tUktaTTFLaGtJQmVWWEF5ZXhFTXJSM2xaaFcyYU03bVQ0KzJJNlRnQ3g1?=
 =?utf-8?B?TEQ4MURJQW1GSnE0dDNnYWpZUk1hNE50NHlYN3hnTTJaTzVuVzVNSGxmRStq?=
 =?utf-8?B?ZGtqNmJmby9sS1hJeFQvYnI1emZEc3k3MHNLT2FmeHZ4bE1OWWtwUk44K1Vs?=
 =?utf-8?B?WU5ucVBHTFBKbU45MUtzVGhFSTlKN0JhYmtjVWt1dzdsOFpPTGdsTGhPUFJC?=
 =?utf-8?B?MFFqeHpQTUQ4MGVLajFadlZPbmdrNEp3QzZnekxjT0ZUL0VOb3dianFhc1pJ?=
 =?utf-8?B?VUVwR2RZMmx4OFk3aUpreTRiZk1pMXNSb1k5aUo3ZCtaaENOemtTQU9vTzYr?=
 =?utf-8?B?YVFFQXRodHJoU0VuL3lhTGlFMk1FWjZUUFdQdGN0dnlMU1I2UVh1MGE4eEQ5?=
 =?utf-8?B?Mm9yeWFheEJudnpzWDk2VGQxTWNmVXYzd0tPcGU0cytZeGFrdTNGRHkrSG5M?=
 =?utf-8?B?Zk1mRjZOOVVuOEdLN3VkZFJYK1RJY1B4dTlSaEZONEVHMFBXRlBMV0ZZTjZS?=
 =?utf-8?B?NzU3djhQYnFaWHlnUTVMdFdJalNJVEVsT0xMSGMzdVFycFlKQUtJb0VQUC9l?=
 =?utf-8?B?RUJJSzNlMkNhcUVjVVU0ZEFyakdMdFBMUHJrTnlkYkxGbXp6RWk3VFZKbzNm?=
 =?utf-8?B?ZnpFTEYveUEvWDNpUm4wMFo0VWpUWUwxNHRrWUc4T0JQZ2dSY0Ztek93Rlhs?=
 =?utf-8?B?aGRzc3llMlFxWG1PRjQ5azNQVTN1OUhiMkJBUXZBcC8xcmx6VHR1QWN0Ujh2?=
 =?utf-8?B?dGlvT3VJbG9BTFVaeEsvQVhGR3dBMndhRmNZL29KMXdRUHY0VlF1dnQ4QWVW?=
 =?utf-8?B?N2lnQzQwcnB5eDl4cU1HeHBhNTlOYVI2Rlp4RFJUUmNWQ3czcHBPMjRTQmc2?=
 =?utf-8?B?ZlpZZEFwN1orRmlOVTRHZWE1c3Jtbi9ZTmNMbFRVL1Z1V2orYVpFbXFuYWpW?=
 =?utf-8?B?LzVreG12NkN3TGJheE9YQVFwd0d2SGRLQ0NWNFd4MFdWWnRmZ3I5ZkJVbGhM?=
 =?utf-8?B?TkIxV0djbXYrQ2JBS1NweGdQQk1zeUFlNGN6VzliODkrdjcxNFpPWDFSYlhk?=
 =?utf-8?B?bS9seGsrMERTVytqRnBjcjdDSXJmY1ZuM215QVRGQXB1WXUxV0VEcWlLbW4v?=
 =?utf-8?B?b2JzUzNsRHJreW12UzRFNnpDTVNVWUNpamxRNTFhc2xQY1MraUxDeFk2WDNo?=
 =?utf-8?B?L2ZnUklMdlNDdHBzSXFwczk0NExyWHpFaFJYR1g2VDMwcnZRRkh2UXY2U2w0?=
 =?utf-8?B?c1V5OUtHdkxTbkIvcW5vMXJRaFdzck1RK3Aydy94R1hWMExISmJ5Ym9JSVNJ?=
 =?utf-8?B?M1lwdlNwb0xiejVMdnhlVlRqaHkzNE1RVytBdUU4THlLS3pQZmk4N0dRcGho?=
 =?utf-8?B?RmxuRHZTNGxuV1Vtb2dvSDFmakMxSkVXTmRqU3dQb1V0TmNWRXNDTVFCd3NH?=
 =?utf-8?B?dEIzQ3JpakFocVhMVUlZUTlHZThzMG1FK282V1I0Z25VQmJpQThRVW9jd1ND?=
 =?utf-8?B?TGZidlZBK2NLYkpyYjBOYlQ5NUZ2U0N0dkxGVWFEWjZoOXY4Zkx1aWozRnlv?=
 =?utf-8?B?L2Y3L2ZBc1VTN2xoNVArVlNsTWFuMzAyN3ZtY2FzUDkrWkRrMHpNeWtDeE9E?=
 =?utf-8?B?ZzdDTHEvbTNvVlhSVXBiby9DLzFkVStCc1VRQUUrQkZvd2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7523.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE4rcC9TbTNLRmUyV1VId04wWmU2YlgyTkNLL0dmVFNuWVVtMlZHZWQ2bHFx?=
 =?utf-8?B?ZlZib3RoVm0rN1ZaRW5TeGZaeXNYdGpwSnBMOWxhaVpSTTJNQ2hQck1DRjhh?=
 =?utf-8?B?MVFxTmd5blRmMDNFemJhR2ZkL081QjNoazRxWlE0QVMvTXVlaHFOVXhnWWdo?=
 =?utf-8?B?eS9lV09kdkhLN3QweXFIQVRtaEtuSzNkTXVpbWhBeUhZd0U1cldWSzBxUGhv?=
 =?utf-8?B?STd0eFNjZmllUWZYN1QxUzNIVnJ4bU15Nmx6NDRGbzE3MWhwOGF1cjVrOHVZ?=
 =?utf-8?B?d2xqSmZrd3VEYTlWYzZPTW5BeVVHTkdzUlNlMlZpQWkvbkM4WWZpY3BTbits?=
 =?utf-8?B?YUpnM2h4N0lFU0dLOHluY24wc0lNQUxOWW4xTW5yeW5sTWlBUmFNKzkvQkxS?=
 =?utf-8?B?RWJIajlZS05zNU5HSnZVWTJnOG1zT0FSMXVvMUtDUlBqYWI3anlORFNjaysw?=
 =?utf-8?B?U1psVWpyNUxMZDdxVENBYXJpL3k3MTVZRVBCbXlCZmRSalo1Qmx2anVKcUR6?=
 =?utf-8?B?RGVaam9DMWs5NlgzSlVNVjMrdDRvamZsQzJaOGRkSGQ5ekVTaVFLbmFiNWJs?=
 =?utf-8?B?alFoVU13QkJIOWFBWVNtWis5bC9iakxURVJrdXpORUhZTEQzK2lmTkl4WkZs?=
 =?utf-8?B?Z0drSmg5a1lhdnJxRDJUSVZnS3BXdXZmMUJjMTlNTGs1M2hVVVVjZFhIeUVn?=
 =?utf-8?B?TGNzanhkU0hqVUNUQkJEcTlqRkgzMC9UYytPYUY4YlU5UnVzK2pWQTUyd200?=
 =?utf-8?B?VkpLZmg1OXZ4TE5QdHRzS0NjMmJQbkh1dDVkdzU0WFMwNURTdU9wNUhQTmtX?=
 =?utf-8?B?dlk3VmkxcEtYd1FURlF2MUpubWpIWFBLYitvYWJiV3hvaWhNQjVscG9UWjla?=
 =?utf-8?B?STBjUk1wMk9GdXJwdngzS1F6dkZKbmw4Ym5SOXdYYTlJblhoODA4bGc0bm5B?=
 =?utf-8?B?eTMyeER3NGVVSlpmbnYyazkzZjZENXZxSnJOMGUzSXlvQlgyRXhxU3FzTGQz?=
 =?utf-8?B?UmhGbVJEZzJWbkhzWmlvWVlqdGExZ21MQ2R2NkF3RjAvU2FjU041QnR5Umdv?=
 =?utf-8?B?UzIzTXl1bHg4MW4vNG1hTmE1VVpucG9NQUxGckppRXY5bmxGcXMzVmRKdzI0?=
 =?utf-8?B?M25rdExJWmd3S1NUVStGaTI5MDFzVVl6WmdQTnBhRGFhMlJTL0FvbnhCcTlx?=
 =?utf-8?B?UzlIakErbUx0dDR3VjZOKzlBTFpZUEhTZ2hULzE4OWdBbzA3aFBZT3pSTmx1?=
 =?utf-8?B?ZjVnRXUrc09FUFZmdGlDMzFMd2JVYTFNaHBzYWl1emlEbEpsU3V6L0EyTDNM?=
 =?utf-8?B?bHc5V3NHYVdsZEw1NERmRm4zU2h6MmpvS1Z5Q3NHZUMxWGo5ZWh2TkdKc0xi?=
 =?utf-8?B?MXBuZEZMVWFWUVBCbVFaT2toQ0dhNFJ6YmVTR25sSFMzbzY1YWJ5UHd1RXQx?=
 =?utf-8?B?NVR4dVArdnlQSUZLQmJUenMvdW4vRU8vUG5WK2F2RU11RTZNYlo1OGpIN3Jl?=
 =?utf-8?B?ZVF6eDNuS3F5bUpyWTk1cWl1REdRblJsRGhzQjFEbkNpY2poSW1VQnNLODJW?=
 =?utf-8?B?MWhITSswRTIxR085SlBBdXlNMjZwYnlLMG1TNUNQby9DZkp2UUxkT3ZFSFZs?=
 =?utf-8?B?eWFMUXdtWVBQOFRNeDNaK0tRV3Nlbm1iTGVFd3NLZG1QaXdjZUpkcU5GcUs4?=
 =?utf-8?B?NXM5OFF6Q0g4VFJWcXpXSDJaeHBuOTNIejlGd25DQmVuOXFBbndUMjVUV0FR?=
 =?utf-8?B?bGY4SUZMUDNtM0VucktJL0R5VEcxNFNLWm5NcXNCTFQ4N1hHYm5xb3hBYmV6?=
 =?utf-8?B?T1N0bzRHc1o1cUhoSlZqUExFWmd3QTgrN1pTREp1THoyUEFUUU1FcDdQMzVM?=
 =?utf-8?B?M1U1Nnh0aVNzZmRXbG9jR2JLQ2pYRldsUXcrZ3VyNmFEejZzSVFvOGhuVnh5?=
 =?utf-8?B?cTBnOUFyME0wT3RTWmd5L2FneWh1SlBOUExaUTNqYWZvQnpveGQ1WE9XY3ZZ?=
 =?utf-8?B?ZTlweHFtR0syRmgrMzFHZGhVRSt3WWU4RlZ4bVpIRGZwcHF2YVlKRXhUY3dE?=
 =?utf-8?B?bnZESGIzR1hITitRcno2bks1eEh2dGtoWUlJWHE2TUNuMW9NZHl6NFlDVDRD?=
 =?utf-8?Q?S5pjO8YzDuO98K7ZxEV5BOHsw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abafdfcf-d2e7-453f-b331-08ddcc34b848
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7523.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2025 11:08:16.2292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vpCztb+dicE/Ka8I8StH8OIaFUIUxvS15YPJ3QX0wZmY6DbVYydBZfQRoeuxUyZ8RhxL2C2tfuLJqvfIy85OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9789



On 7/26/2025 6:37 AM, Jakub Kicinski wrote:
> On Sat, 19 Jul 2025 12:56:08 +0530 Vishal Badole wrote:
>> +	/* Check if both tx_usecs and tx_frames are set to 0 simultaneously */
>> +	if (!tx_usecs && !tx_frames) {
>> +		netdev_err(netdev,
>> +			   "tx_usecs and tx_frames must not be 0 together\n");
>> +		return -EINVAL;
>> +	}
>> +
>>   	/* Check the bounds of values for Tx */
>> +	if (tx_usecs > XGMAC_MAX_COAL_TX_TICK) {
>> +		netdev_err(netdev, "tx-usecs is limited to %d usec\n",
>> +			   XGMAC_MAX_COAL_TX_TICK);
>> +		return -EINVAL;
>> +	}
> 
> Please use extack to report the error to the user rather than system
> logs.

Thank you for your observations. Since this driver is quite old, we have 
used netdev_err() to report errors to maintain consistency. In the 
future, we plan to upgrade the driver to use netlink interfaces with 
extack parameters for returning error information to user-space.

