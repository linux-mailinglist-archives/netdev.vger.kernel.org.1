Return-Path: <netdev+bounces-116688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A4694B5E0
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695111F23A51
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A20D4653A;
	Thu,  8 Aug 2024 04:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zf/2Nf/Q"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F079479
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 04:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723091039; cv=fail; b=Y+jyZyTbSptavNWjKG9C0nbm7bd6tRGVAmh3KgkBtH/u/0ZwucskntMNWefwac7gMHrZpEgT+9Wb5fFNw/UKpvSHvB40+vLsuf9Jm/scfF8vlPdEnQ27er1dmRxW6ClUplMF8P2XdycIObXebIjdNs8BEGtMsDxHApB+zCCJctg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723091039; c=relaxed/simple;
	bh=AzqRCPQdFRI4C+aIXnBGAwz9o4shZ5oLYDD0m9PSsUY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GNaH301kuKctLGSu+0yu3SxHHkS4fWyvx7/7bbHJ6qliDeo8uB0lvVWuS0yecDIx9UchesfyzoZqB7SzPqOabsjgz9yIWRMlHsa/u4vfqNrNOV+aq1T91fDV/9R4qc2aVvSQxJdieY1CtaFnlGMmFOlfcv1FP8hU2Pg7aFVrLUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zf/2Nf/Q; arc=fail smtp.client-ip=40.107.100.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2TMwzjpkMbwPYA7313qPbHwkm67FSdL3llvbKort3V61SxYVra1EiR/rxa/FFRIAvELn9iNO3kl6YSxilBeQy/JEcOF8/szvRSFia6AyCdpwUvzGljOX1jikPuAsDhxsd4JB9zBRH3HY3M/IHGlExxU0p6ZHhbxJLvjadJ/RXzDgNm4VIxotj9agmdAS96SL2iRKlWe49dezQUOj8E8wWJCblHnI4KN8lQLalz3ow9EAnH8dYY4jYjmvvInHty8bl4Dm2JdMrpaU6JTiepdEdF+BjU84VdMKGz0TW2LSeoUQg3FafUeFZGXIRTw4kRdNrbP+2EJJ3VC4sVXczCBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X48L0Dad3tNek7DoT6vGe3nLKdEfHKnGio/DtmWhs0Y=;
 b=qfvYEK04mRa1aLMdWyrdEn/sbSMv3J1muwuQUXuZ6nVaKrFDHGvyfK3IoLKl2wAPrbQ6jwprKbUaatqJbANx6tSJJ3El6H9VSOFjf8dJDKEWsT7xhFq4PHM20QvRg28D72yBFYExI0+fn/NGLjupReceRePNfBn1l9LKdk3Mn0bi6rK7h3Mb5Kc33s2EfwpupgDmkLDgmMuNekCYSrvV8owg2BDkEVfid5Se22Y4U4HPGCr/01oofHSfih+nJWlCSzUb7PvrDqxBTcETmJQNATJFbdMzSC58wtaHk3uB2+QR7AEvxaBak+LZNulPUX+U/IvHXwZtAo0FFy8nQyR6kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X48L0Dad3tNek7DoT6vGe3nLKdEfHKnGio/DtmWhs0Y=;
 b=Zf/2Nf/QzixWaMNvLv0l+lp/u35bnHUxuazX/Fx1z3uePzwehigjs3B8Cj/qbPpPTKkDhAtKSrJrU/w64T3SjwlJZCzb9djvpdjZTvUVfx97HrM4+uEd27FiSJWgN1B3KClhngar47m92AaibBw6IHe6ORrzbz10rZpDX+myhqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Thu, 8 Aug
 2024 04:23:53 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 04:23:52 +0000
Message-ID: <7a61eaff-3ea4-4eba-a11f-7c4caaef45dd@amd.com>
Date: Thu, 8 Aug 2024 09:53:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net] net: macb: Use rcu_dereference() for
 idev->ifa_list in macb_suspend().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20240808040021.6971-1-kuniyu@amazon.com>
Content-Language: en-GB
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
In-Reply-To: <20240808040021.6971-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:3:17::21) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0c1e69-0f8b-43e8-55ab-08dcb761e8ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amIrSlI0TGc0N3hVb2FhTUkvM0I3R0lPMnVzQUJOVjB1ZHcrY2ZoLzBjaFNt?=
 =?utf-8?B?ditDSjBkc2RVcW9kZmpGVk85NU8rMHNMMjNERHJiQU0velNkY3JPNkpLU0Ro?=
 =?utf-8?B?S0JtU21saWQzeTVmS053QmRDUGJCcEVKMWNwc1QrZGhaY2JXVmxtbjRSMTla?=
 =?utf-8?B?bXIrcnpNQjc3V0lEVndDcGhHYmlrSk9PSjNHemc5ZkZEMDBQblVNR0VXdXNu?=
 =?utf-8?B?ckEzZDdTaDF1Z1MvbWFVeGdBODBJQlV3R3hLQ3FrSmVXcGNEODBvK0wyM0xi?=
 =?utf-8?B?MisxbEdadkZMNWtySHJhS3dEVVdOR3lUdzd4cy9XdndRN2E3SDBVb2VCeHgw?=
 =?utf-8?B?M0Uxd0Qrb2piMVRFSjdodmd3UjJWMFIyNUhmU3Y5V29ocTQwYW9JNVgwZXVz?=
 =?utf-8?B?Q0Z6K0FvZFNaaXZrT1hmeEp0SGxUZkZGaGlFSkErbjN6dnpzKzA3ZTBXdGNM?=
 =?utf-8?B?SXpuT0VZV2ppNW13U0xLOXVPeEV3U1pMeDdtemg4UWhvdGZ2Z0NIRUVOSkJP?=
 =?utf-8?B?TkV5QlNZSzhGdThVejRMa3lOejRUSzRRYzdjVTQycHNKSk50dkNnTUtMdGlq?=
 =?utf-8?B?NE00ejB3clBZN0tkL05IMUQwdjN1aVd2Z2J5ODJ6TllLSktwQVc3WUYvWWo0?=
 =?utf-8?B?ZVhsQ3JUbWZNamlPU2xaOUwxWUJ0MzMzWlF0VG9qV2toS1l1N09xdEM2RGE5?=
 =?utf-8?B?L2IxQmYyRUFUT1E4UmhGNXg4M0ZyODRwdjdhcFVxT1A3bnc2TzF5VGZTSDNX?=
 =?utf-8?B?eWlLY2JIczcrNktDczJvVENFL2VEZmNzckY3T1NpVDk4YWNYd1ZYTUwzOWZV?=
 =?utf-8?B?aWVkbnZhWUVzSXRwYTNSZXBoUllhRk1NdnBlMkZJWkpnRlhzY20vUHg1UHFZ?=
 =?utf-8?B?c0w2czlCajRHWXdySmJzTjdQT2ZlVmVGSmQ1OHdtQkJvQXJQY2t1VUVkRGtm?=
 =?utf-8?B?YTB4cHl0WWRJN0VoU2lWemhGM3hpNlQ2WG93YjFlZzRVZ3hPcU5pVFo3ZHVz?=
 =?utf-8?B?V2JUY2JGWVVqSFpqOGx0ZEN3OEMzZVNuN29CUmlEYWl2NEMxbXNOMVRiUDE1?=
 =?utf-8?B?cjdVVlBkWElFa3J6WXI1aEU1em1iZTczUGtuR01NYnpid3hQUzR3elVwY2Jh?=
 =?utf-8?B?OWNkY1hKT2I4dVI2cVkrMFR6RG5JTkltK1NDOVBIRDZMeFlGQVlTeXQwVEc2?=
 =?utf-8?B?M3VSbVFid200OEF3djBZTFlycGp0Mmw3b2NMRE9CMkxMUzNzenZ3S0VLc1dD?=
 =?utf-8?B?eU91clMrTENGUEY1ZWxrMjJoVXI4OENwbnNjMEhhU1BTaVlINHJocHkxSkhv?=
 =?utf-8?B?dGRra1lkbzBVbnphMXB1dlBQWDRmMW10M0NKVmZuVm8xTEFsOWY1ZHo5STBn?=
 =?utf-8?B?dm9OSnJDb1gvYUFyRnNIb05OYXM2S2EvbTZpN2JrQ05NV3l5YXIzcG0vdGVK?=
 =?utf-8?B?aDI1L3V2V3JOMlFjK3N5T1o4OUZuUGp0bjN4ak9ONUVweEx0cERkdmdER1Zw?=
 =?utf-8?B?OUlEZ0thQnAvbndPcjJaTVczRHVmMm5SQm53a0N6aWRCVm16Nnc3cng3U1U5?=
 =?utf-8?B?RXRvM1h2ajZ2UWw1OUZQQjJLMmVuQ1YwdWpiQ21oU0ZiT1R0bktKTlUrNGRu?=
 =?utf-8?B?bHo5S09sT0JBOVRWbEZLYVZjOXRpdE9ZT3VrSXhCTTJoWlJPdCtFSnFoRUxr?=
 =?utf-8?B?U2dLQ3orOHFQTElBSnBZNXR6OUdtdXBHTXNlNTZxdjJJd1FzZUlCR1ZqZUwy?=
 =?utf-8?Q?Qg/t04+heddCobKAuw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDRGMVB5ZDJYUExFYUE3cXBUSWxnajNLdDdPVWpvWS8xcEdnajhtekRXLzNu?=
 =?utf-8?B?RHFWS3RNaStQL2tEWXNScnZJaWxybWYyRTVKQjMweE55VmVEK3A1Y2hvYWxa?=
 =?utf-8?B?RGxwZmFjWWpmYkRxRS8xZlIvSDBFOWJpcHN3K1BGVGVWOGZFSGx2ci9uNWRJ?=
 =?utf-8?B?VHFwNmVaamswY0NvaU9sMWNvaitXZWxhSFpFNk9kTDA5MlYyTjF5MmhvMjRv?=
 =?utf-8?B?MkpIdjg0NnNHZUgraFJXbGtrU0VXRHE0NnA4aXR3TG1oQkhiT2FlNmtnQURi?=
 =?utf-8?B?UFRFZGFHRXFPcnlQZkMvODdWUWtVNWhocUVvWDZqWHhWWHVRSUlFTGdJYjdX?=
 =?utf-8?B?N21LdlhucWd6L2RtVVdJK3JOakQ2dmlDajJ0ZDl4REd2RmI3NlFnQnk4ZHdM?=
 =?utf-8?B?V2t6eE1CQkFZaDNadUxQL0FWclJuQVpSQVQyOWRHNkdTMXR3b3Z4bTBRb0dp?=
 =?utf-8?B?endpTHNzOXFIVkh2Q2swcUZsLzUvVXJNd2M0dER3TlNRUjlmQXRYbEN2KzdX?=
 =?utf-8?B?cDRFQmVrTE94LzZsb1hGbEhrWkRPNktvaVo4WXZBc3gvYU5Nc2ZHUDgwbm1K?=
 =?utf-8?B?akRWaWNiejZhVDI5Y2JjUW0ydmc5bllxR2FRMk9LT2dMYXpTNUtrQThrWXhU?=
 =?utf-8?B?SzM2OE5oclV5STZoWnVid29MQkhoL3hncEpzY0Q3NkJQTG5IVjQycFJSK3E5?=
 =?utf-8?B?eThWNDJseE9IN2pNV0ovd1YzTFkzTnF1NXY4YVBLcUF6dG8wWHBMVmJuZ29u?=
 =?utf-8?B?V0JnUUFwSVd2SUxFZ0NHZm50ZWJ3YzRWczBnc005dG5KQVJsRzlORnQ2dWNx?=
 =?utf-8?B?SVRYOTZ2ZkZ2OGpqdU9oVkxhQ1c5aUdSS1Vtd21hc3g0SHRzZGJ0dXpLd3Ar?=
 =?utf-8?B?QUwxcVdxQUZJTHVXTHNJV0lUd1VmZkJGWFlla25nbk9KRWp3L3BHVVc0clQw?=
 =?utf-8?B?KzVWY3cwMlR6V1F6TFBTK0paOHZFbmtBVTNTMG5DMW4rV25BQ1RqWkJ0UjhF?=
 =?utf-8?B?QU5GL1RkNDB2REtQSktWdnNmZnAxczU3ZFdlL3k4R3RheFhwRTYrb3NnaEdE?=
 =?utf-8?B?TU5CdW5iQ2liWWdMVVVaVTZPaXZBZXB1NUVNOVlta1VabEV6M0JRUXdNbGN1?=
 =?utf-8?B?OEgvYnhQbHdQMEhjM0dkeFBoR242RGdKU0FVNTdYWFpzQisvN1k2QzEvRUVT?=
 =?utf-8?B?dy9VdG0ybU5ycGZ4T1ViQ2lvc1N5VUNCcmhKS1ZQTFhZaUJoZXdxaCtpaWhJ?=
 =?utf-8?B?NHZvTjFHMzNLb1lsdWU0TFU0WHBFeXBqdnc5ZWo5d3ZvNlcwd3cydDBqT0dZ?=
 =?utf-8?B?M2tmTVNQS3BFYWVtVTZvdnZNYndLSTZ1bjVRVFBZOGhkV3BWUmFYeGRWNkhp?=
 =?utf-8?B?SkI3Mnh2c2J2aVVtSFErOCs5bnBCR1BEa1VTaUFnd2w1THBnYnZpL2UxN3Z2?=
 =?utf-8?B?Yk9HZ2tjd2pOMGRlU0xtQVpINWIvUHU4emdreDllaWxROTJ3ZjJsYjVTeW5E?=
 =?utf-8?B?NVRxT09vRmltanpuYUhWSStBUnU5ankrdW1sZ1dnK2ZxRVpuQ0lLMitHTUNH?=
 =?utf-8?B?RDYxOHRJa1VocDZLakR5OEE1cjRYWnYzcUhsUk4xcHhtSklkVHJoeUwzTEsz?=
 =?utf-8?B?dHJMWXFkZ2dPWjZXWnU4aWdOQnUya0pRaDF4Umt2SytISzJRemxVSGV2dHhh?=
 =?utf-8?B?NU5DeU9pWmp3c1FaYm8vTmxncVd4RXB4VkdnM0ttZ3ArRThjVEtXUklEaUVr?=
 =?utf-8?B?TitwclNCaVJtaHp4RXlGNHRYaUZyVEE4emZvMnRUa2pCTkdEUTgwOHBQS1h6?=
 =?utf-8?B?N2k0NnFvRnNJQUtGeVA0azF5V0IxQ3d6cmpSYWx1OUdxSWpuQ2RNUHN6a1Nh?=
 =?utf-8?B?MzVsU25sY1RqdlFEbkxRNTZSL2hQa3JQREhPN2tWQ2R3VzlwNWFNUkZaYS9D?=
 =?utf-8?B?QnlNQjZaK3dLeFdnT2RYY1hodXVSdXYwMGlVSXdnSWVMdXordEg4dUZ2Zks3?=
 =?utf-8?B?RUR6MEpjanU5aVEvaHpEN2kzTU1wUTFXTEJ1Z0JLaXQ4UnJuZldnVTJyVk9W?=
 =?utf-8?B?dFBCUC9rNVg3Vjgrb3ZqRjZPTWtCUDZHa2hPTDBoYjhXOGxiWVR6UWV6Snhs?=
 =?utf-8?Q?yWCKBwDSy6k61zwB5XLc+FXtm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0c1e69-0f8b-43e8-55ab-08dcb761e8ce
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 04:23:52.8235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyrYXS6Z8iv/7++ZwsGe9pa4tZS2xM0/waT8sI+HNRCdEc0vwaDbKfheb4sWI7WP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525

Hi Kuniyuki,

On 08/08/24 9:30 am, Kuniyuki Iwashima wrote:
> In macb_suspend(), idev->ifa_list is fetched with rcu_access_pointer()
> and later the pointer is dereferenced as ifa->ifa_local.
> 
> So, idev->ifa_list must be fetched with rcu_dereference().
> 

Is there any functional breakage ?

I sent initial patch with rcu_dereference, but there is a review comment:

https://lore.kernel.org/netdev/a02fac3b21a97dc766d65c4ed2d080f1ed87e87e.camel@redhat.com/ 



🙏 vineeth

> Fixes: 0cb8de39a776 ("net: macb: Add ARP support to WOL")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>   drivers/net/ethernet/cadence/macb_main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 11665be3a22c..dcd3f54ed0cf 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -5250,8 +5250,8 @@ static int __maybe_unused macb_suspend(struct device *dev)
>   	if (bp->wol & MACB_WOL_ENABLED) {
>   		/* Check for IP address in WOL ARP mode */
>   		idev = __in_dev_get_rcu(bp->dev);
> -		if (idev && idev->ifa_list)
> -			ifa = rcu_access_pointer(idev->ifa_list);
> +		if (idev)
> +			ifa = rcu_dereference(idev->ifa_list);
>   		if ((bp->wolopts & WAKE_ARP) && !ifa) {
>   			netdev_err(netdev, "IP address not assigned as required by WoL walk ARP\n");
>   			return -EOPNOTSUPP;

