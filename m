Return-Path: <netdev+bounces-92356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 056CF8B6CBC
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 10:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B401F2357A
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 08:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F577BAE4;
	Tue, 30 Apr 2024 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b="OaZw/Q+S"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2132.outbound.protection.outlook.com [40.107.15.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEFA7605D
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714465485; cv=fail; b=QNJMHMFq1CP2AEewwchdz/3aYkyABocagWJwXFTfHJnJBeYVWsT6c4xVARW9MWODBU7b/oazVUwJXQwfl7Mb/50/h1zMG9Ts3jqsd2Ks9rrQc1XMUjs5xU/swqYlBz5Unhp4zegfOWH0TihJNQvKYn10Re1zVYj3ELY6fpmHeHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714465485; c=relaxed/simple;
	bh=ux5NOZal3YjfsyF1f3mt+pG6ZuE2j9j8D6x5kRCzuIs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rdXh2Td0NU8bEeQB//ngi+icNc4iQR/FLHhPe1OoK5XLJ9HAqoBsn66zkUVEC7FQ1ZlLeixmibzhpp4kpNcNvMmpx7Wq1zyit86Hr/zplQlVEQWxxDa1G8SrvIrLgG852mLC/zzRRthAtT7HuSHAQGZgnCC4FlBSlUtQhLSH/yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raritan.com; spf=pass smtp.mailfrom=raritan.com; dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b=OaZw/Q+S; arc=fail smtp.client-ip=40.107.15.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raritan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raritan.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2rYFklvtdGYZypYrf15Zhaf1HYPLyPZ1xEPW1m9KsKl2LxUjZVpteNH3VDQWnNGtDistv6cLyQ9vIZc7agg24GlqCEBZwaCTmOD/cCsQm5qTj1zpRGbrXTVTC7HlCNw5VXzRz7ns/n8dueM71F2/NEFLAwNi5O08euyyTgotcBFpaMB1W57nT1Z+8ZSiaiQQKOxLUsvLXaV9XPgMeZsDdkx81RxMEcc+X5c9+a30KIPkW/CbdSo42Q7zo5DC0EqfiSKkjfikotSOo1dfMkaNW3fAZO+QshRCXvK778yN557oD60pyycvuwQYSsRID6m15D3RQJZ76iP5RKysaEZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zro1eve8Kxa0+eAXf4b48gG95TbKKcsQziGHQETFZjU=;
 b=NL8OTsnx4ppSAVZFO3S0G1nya0uWsAE+PfQZOIKOJaq5sp0KBixqKObDzg9Nl/m5JnfPXDE6A4q+QqwbrYTHTP48FkFAu9tKA+m330ra0Hq16FBaNngGByppc6/mhz5KsTI7wAr9/SLqcSt0tYDvVYvQqgTsxTKxEU3aR932Ds5HwgeStsCqAy2pAEua6CIbwagIQpH2TcPY2CISfTqrmPV9IBKP7mAppSZGjinOn8tEAedZmcR0lcTBKASqWTTG0mQ8I40afxgSkPF2bl2DmmXxPJiu5ODbNj1OKRF+YxGG3QWlCnq3y9YixeZ8yAVu8e8/V58Fs3hkzQ8HC4zADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raritan.com; dmarc=pass action=none header.from=raritan.com;
 dkim=pass header.d=raritan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grpleg.onmicrosoft.com; s=selector1-grpleg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zro1eve8Kxa0+eAXf4b48gG95TbKKcsQziGHQETFZjU=;
 b=OaZw/Q+ScumIrOKQDsygXVUkmfPZv10AUMGwLMGd4RKFMiB5eCqcldPH6j0UQN0E/HIc3Na7XSA2NilNUCxtJnPyPIiNlxmPrNGC8+RjVg2nsEw+KKfawdmVV9Pu3AVgz5P0E5cn9XsL2PoxP+qTIzdK0uqUEFJj3/l0xwJ+VsA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raritan.com;
Received: from AM8PR06MB7012.eurprd06.prod.outlook.com (2603:10a6:20b:1c6::15)
 by AS5PR06MB8824.eurprd06.prod.outlook.com (2603:10a6:20b:676::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 08:24:40 +0000
Received: from AM8PR06MB7012.eurprd06.prod.outlook.com
 ([fe80::9832:b8f4:ea0c:2d36]) by AM8PR06MB7012.eurprd06.prod.outlook.com
 ([fe80::9832:b8f4:ea0c:2d36%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 08:24:40 +0000
Message-ID: <959c3cf5-c604-4b36-adb8-ee28ed4ef9c4@raritan.com>
Date: Tue, 30 Apr 2024 10:24:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net,PATCH] net: ks8851: Queue RX packets in IRQ handler instead
 of disabling BHs
To: Marek Vasut <marex@denx.de>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20240430011518.110416-1-marex@denx.de>
Content-Language: en-US
From: Ronald Wahl <ronald.wahl@raritan.com>
In-Reply-To: <20240430011518.110416-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::9) To AM8PR06MB7012.eurprd06.prod.outlook.com
 (2603:10a6:20b:1c6::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR06MB7012:EE_|AS5PR06MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3c9435-ce3e-4c99-dfee-08dc68eeface
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkhHWkJpanNrU1NZWnZ0cmE0VlhPejJZQ0xhbWlHdDRrOWljNy9YbDVhOThC?=
 =?utf-8?B?WVNsWjhaYmxrSXo1czZqOEpkeHRaMU1wdWQ2b2Y3eEF4SjFOdVJLZmFlcVNR?=
 =?utf-8?B?WHQ1ci91OHVyV2hmZldJNUltaXlHQ0VYQzBEenVHaG1vK0EwVEh6eFNVVGJ2?=
 =?utf-8?B?TldJR2kzVUpsQnpEcWc3VmM1ZFVYMytRTTlTMk1KNFlZcXU3bXpoaWNuQ2x0?=
 =?utf-8?B?alBtbUhuZytxeFFDcFFDaGVBbTJUQlZVY2NFQjFlcnhSWjI0ZmlYbTV1TjF6?=
 =?utf-8?B?UDFUQ1ZxRGl6dmNNcFlrei8ybzh1Y0ttTGZsRGZBTjlGam9vajNGTFlIWVk0?=
 =?utf-8?B?ZkJyL05heEtKR25sWloraUQ2QzU1Y2grWWpEQ1FzY0QxQlhVRUo1NHVwV1ZL?=
 =?utf-8?B?b1F6Ni9vNXFqbms0Y1ppQjMxbjJlUHFobTk5c25hT3U1YmVFRjB4bzNtU1Mr?=
 =?utf-8?B?SHFDVktCU2gvdjYzUFlscDdscGdER1Q4SUd1aFJpSkxtM3JpSWxOOEtQY3ZN?=
 =?utf-8?B?UTBieW44ZmFpbGh6K2l4UmQrMGg3c2tsZUdaNnBRc2tGbVhtL2pkUXlJY2R0?=
 =?utf-8?B?Wko3RTVFY0lkaFN4bFAydFlROFNnRzRGSDVza0lKQ2haVTkvZ1ByQWNQaXdQ?=
 =?utf-8?B?S0lLdEx4cHFWaVhpeldIeVFucjNPWjUydFhHY0s1d1lWRmljanR3Y3RFMXZO?=
 =?utf-8?B?RDlGZkpDaVoyVG91NFM5VHZsMDhxcWZFcXlZNGJWaThRNmhqQll2QWgrWW9l?=
 =?utf-8?B?VlhZN2xwbjBTMUdHNFhIVnhiblR6RFZWU0NnZG5xcGQ2bnJlSEpjUEF0OHFB?=
 =?utf-8?B?a09wNjNUeVJtcjhVd085R21jbUtSYUVqM255NlZFQWFWQlZ6QVdodndFSzVZ?=
 =?utf-8?B?NjB4b2N1S3M5c1JyMjhENW8zRDUxQ0hMeU51dEFsVWhZbHBFaWpqUG9laG9L?=
 =?utf-8?B?ZFNVK2RhbW9xZkJ5NmtiS3QydHhwc2pJcDkwcTBIQncwam12WDRHODFuUkRx?=
 =?utf-8?B?bUQ3Z0RQNmNOeWxYNGo3YjdtZnYxL3FGSnBxWDVoYktZdlBBOUJqbXh0azV4?=
 =?utf-8?B?SjEzbE5SQWkydG5HYVBCSnFmTGNPOVplcnFXN3NEM1cyV2J2QlRQcUhkQjFX?=
 =?utf-8?B?dVlvTTUyUUxkUlJ0MXNwSkQwbys4RU5hbHFZZXJXdUg0czk3SE5OWVJqR0hI?=
 =?utf-8?B?ZjFFYmtsK045cnJLYzBub3RCUjVnWDRjZFljVHV2Nnd5M2Z2ZDV3a2ZlZ1Z6?=
 =?utf-8?B?c2lFQzc5Slc4QVdCck5ZSFc0VE5lbkswei8xVWVWMTI5bEUrOHFYZ2xGaVBG?=
 =?utf-8?B?dnVOa1h6WXNsS2tOQkJoczF2R2JJa0N0WjBtblptSTNmL0FTVE9GS0g2MzI1?=
 =?utf-8?B?WU1lOXJKemxRSE1HaHQxdEtzSGxEcEJPQTEzeTRZZ1dIcEExblJwTTgxcndQ?=
 =?utf-8?B?QlFxSGJ0Z05XcGxQaUhWeXdQMGlPWEdZMytpRy9Ma0x0eWR4S1h4RXQ4d3dk?=
 =?utf-8?B?Zm1mSGcvQVRQNjNWakdRc1lQSVdKVElYL20zcndGeWJuKytkL2tPNUt4WE0w?=
 =?utf-8?B?ZkxtMEk2RHgwMUNyQ2UrQWMwVmVRWDA3d3pLWjVmajRESzdzelFWL2M1R1RU?=
 =?utf-8?Q?i4Q4lRtBwyC4XL75GSlpH89kUkL7yM+d2+NLvjSBgOSU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR06MB7012.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1hGMFRURkd5Z1NLUlpLb1pZUW8wdlE1QW1xSFczbEQ3dHBQa2h5MEVxY1cv?=
 =?utf-8?B?N3NTd3VvS1hwOCtRdG9lb0xRUGdhL1VYeEJmWHU2eGJYR2hBUFFleGVJOVZD?=
 =?utf-8?B?TDRLQWM0NTB0aGlwQ25UUURPK3o3QlVvOXI5QzFoc1gzbkJDOUYvRC9XYUR6?=
 =?utf-8?B?WUQzV29QNUc2Z3l6MFBESk1rQ3IyVTBscjFrSnU2ZW4yZzUzUGg3VlZKN09r?=
 =?utf-8?B?WWtOZVIyMG1HR0ZuOGhWMHlaOFBxT2NpRWkrai9pdnNDWTNjT29UTTUyMjVD?=
 =?utf-8?B?STdlUHRoSUpQS3BqZXlBS2RQOXN4VmkvMDUxN280d29lN2ZtYTdzdDd3Y1lp?=
 =?utf-8?B?YldSV28wZDhJVmFlTkg2eWtQb09zRWs4NDM5clV5RXFBeHpIOGZpVTBBcGNs?=
 =?utf-8?B?WENYSEdxT0x5UHpWNWxkNGRkdWFTN054RG5pbzB1UmNSOVdKUXNUZHpqbm9Z?=
 =?utf-8?B?RWttcWl4d0UyZG9GOGh0M094Nit0c3o5elppMTFnZzRJS1B0YkFpakY1RTA0?=
 =?utf-8?B?N2xJMFFWeE82VWZKTmF5aEI0Z3ZqT00wZVI3THlLaTEzU3l1OEhRWTM1QlIv?=
 =?utf-8?B?c1NLbEZMM3VZUkgyS09QY2t2OFdrbzBhSC95VzVJejdLSm1RRXJONnNnTVVr?=
 =?utf-8?B?ZkxUVTVsRVhUVEV3NEgzaXpvTXZ4RklQM3lFaVhZZ1d3R3B0OHdvdDhBVnIz?=
 =?utf-8?B?YjllSHNQSm1TQlkxY0tvdVFHcTJtR2xZbHdhOXdxNlZWOURvcGlTSlB0Y1BM?=
 =?utf-8?B?MHg1R1RRUW1VZ2FXMHJHZGhkMTZCcXlEUWVucGpMeUlCcERXbUdGUzFNa0RB?=
 =?utf-8?B?LzhYS3RLVEhUR1FaMlpRYVZLMzRtejEybEt1dllqMXoxM2R5ZE1vK3V3YmNS?=
 =?utf-8?B?dGVGYTVqa0cycjlNMDZQVE1ZYzVtMlVsUGphTEFsZkhtcDRUSkpLS0ZxdnFT?=
 =?utf-8?B?ZmhHTGtPOTFCK0tNOS9pVGJBWkR6MzZ6dnQzaGYwVTJXY0VWY3NkWWQyemM3?=
 =?utf-8?B?OU5STW54NWRKNkwwNGhiaUtSTlZGdlIwMWVTL04veWRXcTRIRVN0bGFlSjVV?=
 =?utf-8?B?Z2JWelB5WUM2NWwrQVMzOHRmYlpuM3RadDF6SG9nTEQrbGlyYVk1KzFFeUZE?=
 =?utf-8?B?WElYd0VoSjRMZndTZ2hyaEhxSVJLa2srNW5HNE9YZDQxLzhOOVdlVmE1Zzhv?=
 =?utf-8?B?QWdjNnVCYytMRVBjRUhVd2VMVU5IaWtFTHZmNlZVZy9YTW5WSEpBcWsrL00x?=
 =?utf-8?B?VzAyRkIvSUl0WXFvdUJYVndUTUJ3TmdGMGZuNmxxTFlyVUMvS3JYN2RRckdZ?=
 =?utf-8?B?MENqNEVJM0pFWU1DQ09BVUxXQzNnSUo1bFE0QWVya1BZcHlCeVZpbTlPcGw1?=
 =?utf-8?B?MTRQUENBMFJ5RXQzajZLNGFDYTg5NC9mbHBsbDR4OGQ4N2xnSzVMck1VTEk4?=
 =?utf-8?B?ZmsvZGt3RmVQd2llKzF1ZkNlVE1pZ215ZTRvaUN2U3lyQU8xUHpYOVBGNnhq?=
 =?utf-8?B?ZjNCV0NOSXBja3Y5ZFpuR2pjMlRGSTJ4a3dPR21PckJKY3VoSWRjQkhNZzl3?=
 =?utf-8?B?VHFpY2I1ZGhpVTBjd3M0MWMxWjIvcEMydXBiUmlZbHk3Wmp2dkxoZVN5NFNq?=
 =?utf-8?B?ZHFSQUFGWFNobFZKY3hvd2s5Qi84bm01WjZmQTQ0dVFwemFIcW9md1R6dVJ3?=
 =?utf-8?B?NkRQUEZMOE9iMlRMSDYzNXcxS01mbzFnTFFReE5odm96Tk9PN0laQmRMU2JJ?=
 =?utf-8?B?cEV5NDVzSmx6NjZDR0NnaitzdnR2bXduUWhJMTlYcmd4VzVvakMvUk04ck9W?=
 =?utf-8?B?Mm5tQ1VWUWIyRWZ1djYzbHZZeGVGV3d5R29LRmp0ZHBlOFNiTHhOSlJjRTlt?=
 =?utf-8?B?UVE1YUFWLy84ZlpEVEZ2KzU1U29NN092OElYcllNZDVVbjd4MU8wZG1rOXh1?=
 =?utf-8?B?YVZCamY1MkJwMEx1OVhJTXYvaHhXYVRuUGkxaGllTGI3S2cya1ByMHFNby9B?=
 =?utf-8?B?ZDRHdjRrVHNHUUVEUFlaSXM1NkhqK2xKRmhrTG55NHRNN0E1MGVPMDJpd01k?=
 =?utf-8?B?S2doSDZPcUkrTVNpNjFmdEw3Y20rTVhBcTRRRFJHTHNqMGhNVWs2WjAxaVhC?=
 =?utf-8?B?cWpLenN1UjA0cU9iYWpMNjFGZDdwa0FZaE1takV5UlppWkI4dTFEM1dtNjdx?=
 =?utf-8?B?VGc9PQ==?=
X-OriginatorOrg: raritan.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3c9435-ce3e-4c99-dfee-08dc68eeface
X-MS-Exchange-CrossTenant-AuthSource: AM8PR06MB7012.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 08:24:39.9977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XiDMAD2nZt4khIALqk5mR4wDnAoFVGDKJTUX6T4HnQZblrksFYUO56snPl+aKnRnhHX+ozGwAjmVAu3/U/68w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR06MB8824

On 30.04.24 03:14, Marek Vasut wrote:
> Currently the driver uses local_bh_disable()/local_bh_enable() in its
> IRQ handler to avoid triggering net_rx_action() softirq on exit from
> netif_rx(). The net_rx_action() could trigger this driver .start_xmit
> callback, which is protected by the same lock as the IRQ handler, so
> calling the .start_xmit from netif_rx() from the IRQ handler critical
> section protected by the lock could lead to an attempt to claim the
> already claimed lock, and a hang.
>
> The local_bh_disable()/local_bh_enable() approach works only in case
> the IRQ handler is protected by a spinlock, but does not work if the
> IRQ handler is protected by mutex, i.e. this works for KS8851 with
> Parallel bus interface, but not for KS8851 with SPI bus interface.
>
> Remove the BH manipulation and instead of calling netif_rx() inside
> the IRQ handler code protected by the lock, queue all the received
> SKBs in the IRQ handler into a queue first, and once the IRQ handler
> exits the critical section protected by the lock, dequeue all the
> queued SKBs and push them all into netif_rx(). At this point, it is
> safe to trigger the net_rx_action() softirq, since the netif_rx()
> call is outside of the lock that protects the IRQ handler.
>
> Fixes: be0384bf599c ("net: ks8851: Handle softirqs at the end of IRQ thre=
ad to fix hang")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Ronald Wahl <ronald.wahl@raritan.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: netdev@vger.kernel.org

To me the code looks good. An iperf3 test shows that it now has even
slightly more throughput in my setup (two interconnected ks8851-spi).
Thanks for this fix!

Tested-by: Ronald Wahl <ronald.wahl@raritan.com>

> ---
> Note: This is basically what Jakub originally suggested in
>        https://patchwork.kernel.org/project/netdevbpf/patch/2024033114235=
3.93792-2-marex@denx.de/#25785606
> ---
>   drivers/net/ethernet/micrel/ks8851.h        | 1 +
>   drivers/net/ethernet/micrel/ks8851_common.c | 8 ++++----
>   2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/micrel/ks8851.h b/drivers/net/ethernet/=
micrel/ks8851.h
> index 31f75b4a67fd7..f311074ea13bc 100644
> --- a/drivers/net/ethernet/micrel/ks8851.h
> +++ b/drivers/net/ethernet/micrel/ks8851.h
> @@ -399,6 +399,7 @@ struct ks8851_net {
>
>       struct work_struct      rxctrl_work;
>
> +     struct sk_buff_head     rxq;
>       struct sk_buff_head     txq;
>       unsigned int            queued_len;
>
> diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/et=
hernet/micrel/ks8851_common.c
> index d4cdf3d4f5525..f7b48e596631f 100644
> --- a/drivers/net/ethernet/micrel/ks8851_common.c
> +++ b/drivers/net/ethernet/micrel/ks8851_common.c
> @@ -299,7 +299,7 @@ static void ks8851_rx_pkts(struct ks8851_net *ks)
>                                       ks8851_dbg_dumpkkt(ks, rxpkt);
>
>                               skb->protocol =3D eth_type_trans(skb, ks->n=
etdev);
> -                             __netif_rx(skb);
> +                             skb_queue_tail(&ks->rxq, skb);
>
>                               ks->netdev->stats.rx_packets++;
>                               ks->netdev->stats.rx_bytes +=3D rxlen;
> @@ -330,8 +330,6 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
>       unsigned long flags;
>       unsigned int status;
>
> -     local_bh_disable();
> -
>       ks8851_lock(ks, &flags);
>
>       status =3D ks8851_rdreg16(ks, KS_ISR);
> @@ -408,7 +406,8 @@ static irqreturn_t ks8851_irq(int irq, void *_ks)
>       if (status & IRQ_LCI)
>               mii_check_link(&ks->mii);
>
> -     local_bh_enable();
> +     while (!skb_queue_empty(&ks->rxq))
> +             netif_rx(skb_dequeue(&ks->rxq));
>
>       return IRQ_HANDLED;
>   }
> @@ -1189,6 +1188,7 @@ int ks8851_probe_common(struct net_device *netdev, =
struct device *dev,
>                                               NETIF_MSG_PROBE |
>                                               NETIF_MSG_LINK);
>
> +     skb_queue_head_init(&ks->rxq);
>       skb_queue_head_init(&ks->txq);
>
>       netdev->ethtool_ops =3D &ks8851_ethtool_ops;


________________________________

Ce message, ainsi que tous les fichiers joints =C3=A0 ce message, peuvent c=
ontenir des informations sensibles et/ ou confidentielles ne devant pas =C3=
=AAtre divulgu=C3=A9es. Si vous n'=C3=AAtes pas le destinataire de ce messa=
ge (ou que vous recevez ce message par erreur), nous vous remercions de le =
notifier imm=C3=A9diatement =C3=A0 son exp=C3=A9diteur, et de d=C3=A9truire=
 ce message. Toute copie, divulgation, modification, utilisation ou diffusi=
on, non autoris=C3=A9e, directe ou indirecte, de tout ou partie de ce messa=
ge, est strictement interdite.


This e-mail, and any document attached hereby, may contain confidential and=
/or privileged information. If you are not the intended recipient (or have =
received this e-mail in error) please notify the sender immediately and des=
troy this e-mail. Any unauthorized, direct or indirect, copying, disclosure=
, distribution or other use of the material or parts thereof is strictly fo=
rbidden.

