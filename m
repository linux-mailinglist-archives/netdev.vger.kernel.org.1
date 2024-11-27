Return-Path: <netdev+bounces-147575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4779DA4A7
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 10:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC36D16438D
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 09:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0301922EE;
	Wed, 27 Nov 2024 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BnJoL5ZG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0519D190685;
	Wed, 27 Nov 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732699069; cv=fail; b=qfaWv7y6IyhDsWzaAGMAsui3YVyKrSdk7EYw6lnOqRoy94a0KQWgxlzs4IgdB0naWDMOYGq3K+YVgq6K87TQCkJngrAdAauzVpNKArGt58ZiK2Af0g7ZIlaQ92O0VO1F80k5TXLPw5EmDA5vJnmEZq0Sg5bOCfyGST2wdbvlNIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732699069; c=relaxed/simple;
	bh=oSALaR0/sUF9nje2Ih4Sssmb8DUetbdJdsyB++PYfew=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oUgFBpFWJhMcNJ01D57APpE449zUPyXvJ92yhefgHVxPnlBX3WaQtjXL2JuC5Vl5c5As+vtWUNpNTAy3CJVEaCJH4TK1XOQPci2JwtukU0sC/tWbjAloVabuGKh1FTygreFoSI/0n+RvKUIAulZVA/zPk362r9Hmy0AGZoe5mrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BnJoL5ZG; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLcKPXUBLnZOp87J559anUAlLvvmXRMSV+wDheUn4y4uDioaE29pN62ulr9b7dV+III0sVR5bxuJxsWD5M6ocHQN5pWSASS3vizw63pr5lRdct9C4heNQwATAASkFJCUHhSS9udDA5EGWeYh1HDCVQak60eC8mss+AYSxuFNdHqjq3fVbE/Mqi7Uy8wqi6s61rKzTipStXZfdFdmK3AHR5N/EwmkMmTZnvXBqM1s6Oi/5RJdsfYLNdgXmfTtD1Vbs9PGzZuMtS9YFd4VCDPieHT8jKMOH5jvXKrFIb64pHsQkxUIWaB9lR7I7fe6YTW5rlZKsovyh7sF1/hUSFv4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDUpRVU6Uv+5t0Ks1oKhrbG3PeRo9puuJuCSOBNZvD4=;
 b=DIsZWXBZPlCcRmdCh5NQvJ7Qtx0qFlAIvga1ljSUiL/HgN8q0O+cAVfktgl8sNT39kiukuhd1kjyaEWDFNKXfr4/AIha8SbLcWbUtJyl4MtEL9BuykqN5PaIRjl8dW7X1BU+2DrSHUIjNf8vvHOiOpd0RgZgtXOhgK3RhmXRd1OYhckILTecneln+d7qxS9tE1TfoFuXwEK7fuU4kRbvrrwjH/hPXwH/2dklRcTsQjDhodJpsn4MOJpgptXzjA/liCK1Km9fdxOpEeFOAjcJzcIJ2O4iGkyesyCfr/5ejAWsoHxC9VFiJ94hE9YzPVnkfBkdfOpzQM1NtIgZj81z1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDUpRVU6Uv+5t0Ks1oKhrbG3PeRo9puuJuCSOBNZvD4=;
 b=BnJoL5ZG9R+4+CpVO1PMe/c/ptqCiHbje5CRRwZ1jMEMk2STwgG9m/+3rCSEEsrStscDw9OVITRtf1bXhbPiMTlbWIo/cCMeMVvpoylMfdF2a4t6oxypzRnKbhk0ibZLANqgX+4tDaTRjfxat+fdjTeunvZIhl3S0/F1vAKXK1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 09:17:44 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 09:17:44 +0000
Message-ID: <a844e2c1-b3ea-4abb-064d-65c005279cc8@amd.com>
Date: Wed, 27 Nov 2024 09:17:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 02/27] sfc: add cxl support using new CXL API
Content-Language: en-US
To: Fan Ni <nifan.cxl@gmail.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-3-alejandro.lucero-palau@amd.com>
 <Z0YOju3FaSSCJRRr@smc-140338-bm01>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <Z0YOju3FaSSCJRRr@smc-140338-bm01>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0015.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: f6be757d-d829-4ce5-ea0e-08dd0ec459ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ampmcytqREFCWnNSWkhDZ05hU1VEN3FRUVVrOXlPZnRjSXU5VnFLZ2lQd3lk?=
 =?utf-8?B?cFVyR3l0TDRIcGxjVDZUb3pZZjlCVDd2YnZOUndnZlVVeXNKU0x3aTE0cmdp?=
 =?utf-8?B?Q2tFMkZ2MzBTTkt1cStMeDZObk9wOTI4VGd6WlhtTUtpQ0p5ZS80RTZkbkNn?=
 =?utf-8?B?TVFaWHBCUE1TUmZaSllZZ1kvUUJZVGdzZ29nMW9DaWg1SXNONWV6Mm10OXly?=
 =?utf-8?B?aVBETGhyOHdHTDRDUjF2dnE4VDlQdDdhKzFOd0NtelBvWXpZK0laZU4rOXpQ?=
 =?utf-8?B?S0tFNEZVZ0lJVEc5bXIvLzZ3bzFuRGdkYklESEMwU3NrZkR1amxsdEt0WTV0?=
 =?utf-8?B?QWUxdzdadjdZZUgzbHgrWUxqckYyUVlnMnBuNURDaVV1dU92c084d2hMY0xU?=
 =?utf-8?B?UXBDZVkzTXBzZ0gzV1hrcUtKbmtHY0N5WXJKeEZ2WHMwM0pUbWZ0S25GM2p5?=
 =?utf-8?B?Ri80b0NaaEE3NnRzL2hCMng5WEhBRmRNNlRER0FFZUxyUzRjL3J0S2NndE9K?=
 =?utf-8?B?bnFqb1U0NVpraU1MdlhyY3IzbkQxYThpRitzd2V3U00zSE9EVkJhbGhKTDZJ?=
 =?utf-8?B?c1VrOFQvV1QyNW5YYzh2a0hiNFhycERncDdsZVRWdmRoNVNrWGZPcE5tVitp?=
 =?utf-8?B?bFJGazU2cFcraGFoVmZMN3oyNlp4aWh5T0Uzb1FjaU1YN0puRzk3SHRvMXVD?=
 =?utf-8?B?THpUOHNQcUtjZ3cwcTRLZEg5NmxzVjE4Zk9ZR0xCOWtkZjV2TXRFUGh2QTI0?=
 =?utf-8?B?eTQ5R0txaVdvSzVPbUpyVjg4eENLRnpJNi81Tm42c2FLaU5VbnluM1JiU0FV?=
 =?utf-8?B?ekNuUS9vNU9vOE5MNHoybk5xcDdOV20wWXI5Y2s1ajJWQzFhZDdDZWZjTDJp?=
 =?utf-8?B?Z3FodUY4K005Szd5QUF2SUxueE9HTEJsbTNmMzFHay8vZWdLT1NkbnowcFRI?=
 =?utf-8?B?QllUMVZNZkQrdXdRMEsvWE5zVVBkRWUwdGxhSlV3TVFuNGtZLzBqMHpER0NM?=
 =?utf-8?B?MXZNZmNjOUFoWC9wN0QrK3g1VDZIQ09FcnhZQmdpMVZXM0NrSytjd1JGS2l0?=
 =?utf-8?B?RUlDUStvemdsL3Y3VG1PTjFoSnNYVkJzNWlMNTVXTmVOdjVYSVgzVzlvaXA3?=
 =?utf-8?B?WmczamtjaUNoWXdQZnJyUVpYZTJqL2UyWVdONm1VVzM0eU90UVM4NEtRZ2d1?=
 =?utf-8?B?dFdYYzhpejd2UGtDU1V1MXg5Q3h5TkJNcHEvdWtSelpqRkNKZVV3U1V6WFBu?=
 =?utf-8?B?NTMwYjA4MTR3MjNQcTNxQ0k0aDhUR1JHR0FuQkkwVzM0MjE0dG1YRVA1Z3Jv?=
 =?utf-8?B?V2dCVEhGZzdSQ2E2WkwwUEhnajRiS252ZkhPRFRvc08yL1YzdzlBTkFnRnU4?=
 =?utf-8?B?TTJHVDMxLzdTT2F3cXJJTGoybTRGL0FkVjRkRVJESkdCbGxGOFBxc0VLWlQ5?=
 =?utf-8?B?MTNXaHdZeTR5T0haVVNLSGpXZVo4VXI3MUh4d0tUdTc3QjA5UGlGbHFiYWJO?=
 =?utf-8?B?dDlzRnV2d3pHL3NCR3hkY2dGZkx6VFNxa0hxUmsyaGhyam94RTZoYUpHQW5w?=
 =?utf-8?B?dkE3ODFwQWxRb1JrMDFoQUFCMHc5anRkT0Z3WFZCUGZYcC9Ub1RlRC93dkRt?=
 =?utf-8?B?K1dvUC82ZkhadDMwRE8wMXo2YVNMVGVyT3g5bG1HMm5QMktIWjZlNDJPWmRS?=
 =?utf-8?B?ZldGSTBaNm1DRnRvZTF3UzVmbWs4MURoaW9CVFhZTWh0MjdnTXFpczZNdXRm?=
 =?utf-8?B?RDhBN2ZESHRSejUvUzdyamswdGNZWVM1eGFkMUFtb1hEVjhFZ1ZFWEw2TEdU?=
 =?utf-8?B?TTlLVVdDYmFDSkR1TmY5Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3BKTDNuQzV0RmlrU2RmVmh4VXJvYUNQWFM1MzhxRE9iR3QzSjk5b0dKZjRJ?=
 =?utf-8?B?Y1I1QWx5OHlFcVgxZ1h4elVMakk3enV5bnowZTB3SG10bnBLcUFMYXU4Tjdo?=
 =?utf-8?B?R1A5NnlhMzNWZ2h6c21XVVdSYXhxQWVLK0xsVERXTlJYVjlROVFkQU0wUjN5?=
 =?utf-8?B?RnRzN1lPQm1zdDNCTC9TdGNWRWk1NXZCbjZBR283Qis3S2NlbXluZ3NxbjJz?=
 =?utf-8?B?eFYzWUFENEJhQnd1UzJjWW4yUStHOHVveVVIL0JFNXB6ZjcrbjF1b2Qvelc0?=
 =?utf-8?B?NDUwb3ZRUkg4N2grbDB3M0Nlc1M0enl3b3JiKzRiZitnSmZZWWRVY0tha2hL?=
 =?utf-8?B?UVRFQStFRE5ORlFKSitGei9ReVp5cDNteGFNQzlJeEg1cDdrQ1NXVFdNQ3N2?=
 =?utf-8?B?OFZCMTYvUVVRaTlHV3FNdXg5Qzlta3V1R0pTTlRNbU5sR09COFkwN2hKTEtY?=
 =?utf-8?B?Y2JFYkRBMmQ3MWJJTFNDRDllYzB2R01vVWxsd1o4SUU3d0t3OUp4bmp3Umk3?=
 =?utf-8?B?TWh1MW1ER2pHUyt2dTdyb0hDV21BT0RoRGtadU5QNEw5Y0hZclJtY3IzRXBM?=
 =?utf-8?B?dkRVUDU5V0NSOUJmR0hQb2NoY0tOemZsZnRxN05yQmVLZ1VZZDl0NkFkb3hi?=
 =?utf-8?B?NXdvK2U5TFVXOE1FN0tDb2xTQVdaaTBndjNSdGNyQmh2bng4Y2ZHa1ZPRGh3?=
 =?utf-8?B?VHhwVHJRUjEweHl4eDNwcVA2K0lMYkFGVXVCdEdMdUNkRkZsUWx0YjJVSUZt?=
 =?utf-8?B?WVh0RWdSZGw2UUI5WVZ0aGxPK04zYi9rQnlvR1QvVnIzS1hXbkZSZkFTQ3I4?=
 =?utf-8?B?QldldGFrNHJYbEsxTUpEVW1aT25veUc4V2doN1pUZWRybDZsdVFrRzF2MG9Z?=
 =?utf-8?B?Q1REMXRDQ2VBbUJQcnFBQlI1bmdGbVpFM2tNNGNpd0luMDc5TzJudUlpMytu?=
 =?utf-8?B?aGZlNU04dnl0TlZmWTY4djAzeGYzMzhJMTlxSmRNOTFmSFNDZ0V4c2RGSTdR?=
 =?utf-8?B?OU0xemVBV1Y0ZmFtZTNvUSt6MGVwT1BSQ0VzOUJUbVAxTEh4ZU9mK3JxRDlC?=
 =?utf-8?B?MjdHMk8zQzRNMzJqVy9WcG85RHJKc1NsN3RRc1BaSTB5WW51NHZvZ3dhSWR2?=
 =?utf-8?B?M1Y3KzJ4Mk1uVWl1SWJNVDJScXpDeW42NlRFSG00OFBJbVl2Z2FKc1MycU45?=
 =?utf-8?B?cUdzOGN4STdVQ0NBNGZEeDhjNVlidEFsLy80cVVDZW5PU0JOVTFjMTRjNGE2?=
 =?utf-8?B?c1ZzS3NoM2dVbWZrdGVLSHJTWGlnT3RmOWdtaTZvVEdqakN4bGk5OXJJN1Nr?=
 =?utf-8?B?b1gwZU95NWJrUHlKeGNwaXMwZmRCenAyeGdCb29HWWVqanhGQXV1STNBMVUz?=
 =?utf-8?B?K0l1QnQ4WmtsckhveWFiWE4wTHMxZ3l1ZEc5bGl1S0t5aWNwMWFJMi9oVnlt?=
 =?utf-8?B?WWNsZDdBbXE0RHJVdlRCMzRRZEI4TDBJU3lnN3NkV3poQUJvaGpSVFUvRVdG?=
 =?utf-8?B?dDJIemhJTmFETlNjeFNkMlR0N2NQTlZEdHJBT0xiYjdwM01JeWVCakl2U2ZT?=
 =?utf-8?B?OFAzVXliS3FVOVd5blZKOWNIV0hiUWtDNGVsb0hUbzJVVC9ob3Z2cFBSZDl5?=
 =?utf-8?B?dmJ6MU9scVdWdW8zWXRFRlk0TitONnpBOHpoMnFiK0hzNDc5SkZWSFI5cnU0?=
 =?utf-8?B?clZtdWJ3VzRsakt3RFpvMDNrdWYrcUZYN25ZWTV6S29DcXB0R09lb0tENUpL?=
 =?utf-8?B?TjN1aUhkQXhCcFY1T1lMc0VMVkdMV1cyMTlBb1BwK2hpQWJMK3pGY2NLRUdC?=
 =?utf-8?B?UWNucDVxQTZFQ0htcnZkcGpIbUh0V0hEcWJmTkluM0M2djBKMTlOK01ZaUZC?=
 =?utf-8?B?NUF4QW51UXNVK3lzSVVPWXJERjUvYWdsd1hGaGUzcnBJM0IrUG5CY2k2RGQx?=
 =?utf-8?B?THVpdnNZaWlnZVZ3eTMvUEFDNjV5VWpCVGhzYVNOSTg1WWFOeTBvMlFQclJT?=
 =?utf-8?B?TGJLNWZNU0lwY1FOcmY2emhiUXJtendnc3dybElXMVFLMHA5Z09FR2I3N0tW?=
 =?utf-8?B?SGV0QUlJT3dDMjk0VmlwRWRjd0VVc0RGbGxnQ3d6OCtyUzJSZVlvcTZkTXBY?=
 =?utf-8?Q?udJT1RaWr4H59D/8taLEMYyzj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6be757d-d829-4ce5-ea0e-08dd0ec459ca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 09:17:44.1673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOT7uzJCaE6O+mSNcw37zgtKsVgYKo8viXFXNk1Qw6hi1tEafF8p88aCNn0dNX0akwYby7/dPnsv64qyiZpMRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715


On 11/26/24 18:08, Fan Ni wrote:
> On Mon, Nov 18, 2024 at 04:44:09PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add CXL initialization based on new CXL API for accel drivers and make
>> it dependable on kernel CXL configuration.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/Kconfig      |  7 +++
>>   drivers/net/ethernet/sfc/Makefile     |  1 +
>>   drivers/net/ethernet/sfc/efx.c        | 24 +++++++-
>>   drivers/net/ethernet/sfc/efx_cxl.c    | 88 +++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.h    | 28 +++++++++
>>   drivers/net/ethernet/sfc/net_driver.h | 10 +++
>>   6 files changed, 157 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
> ...
>> +	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
>> +	if (cxl_set_resource(cxl->cxlds, res, CXL_RES_RAM)) {
>> +		pci_err(pci_dev, "cxl_set_resource RAM failed\n");
>> +		rc = -EINVAL;
>> +		goto err2;
>> +	}
>> +
>> +	probe_data->cxl = cxl;
>> +
>> +	return 0;
>> +
>> +err2:
>> +	kfree(cxl->cxlds);
>> +err1:
>> +	kfree(cxl);
>> +	return rc;
>> +
> Unwanted blank line here.


I'll fix it.

Thanks!


> Fan
>> +}
>> +
>> +void efx_cxl_exit(struct efx_probe_data *probe_data)
>> +{
>> +	if (probe_data->cxl) {
>> +		kfree(probe_data->cxl->cxlds);
>> +		kfree(probe_data->cxl);
>> +	}
>> +}
>> +
>> +MODULE_IMPORT_NS(CXL);
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
>> new file mode 100644
>> index 000000000000..90fa46bc94db
>> --- /dev/null
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
>> @@ -0,0 +1,28 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/****************************************************************************
>> + * Driver for AMD network controllers and boards
>> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published
>> + * by the Free Software Foundation, incorporated herein by reference.
>> + */
>> +
>> +#ifndef EFX_CXL_H
>> +#define EFX_CXL_H
>> +
>> +struct efx_nic;
>> +
>> +struct efx_cxl {
>> +	struct cxl_dev_state *cxlds;
>> +	struct cxl_memdev *cxlmd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct cxl_port *endpoint;
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_region *efx_region;
>> +	void __iomem *ctpio_cxl;
>> +};
>> +
>> +int efx_cxl_init(struct efx_probe_data *probe_data);
>> +void efx_cxl_exit(struct efx_probe_data *probe_data);
>> +#endif
>> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
>> index b85c51cbe7f9..efc6d90380b9 100644
>> --- a/drivers/net/ethernet/sfc/net_driver.h
>> +++ b/drivers/net/ethernet/sfc/net_driver.h
>> @@ -1160,14 +1160,24 @@ struct efx_nic {
>>   	atomic_t n_rx_noskb_drops;
>>   };
>>   
>> +#ifdef CONFIG_SFC_CXL
>> +struct efx_cxl;
>> +#endif
>> +
>>   /**
>>    * struct efx_probe_data - State after hardware probe
>>    * @pci_dev: The PCI device
>>    * @efx: Efx NIC details
>> + * @cxl: details of related cxl objects
>> + * @cxl_pio_initialised: cxl initialization outcome.
>>    */
>>   struct efx_probe_data {
>>   	struct pci_dev *pci_dev;
>>   	struct efx_nic efx;
>> +#ifdef CONFIG_SFC_CXL
>> +	struct efx_cxl *cxl;
>> +	bool cxl_pio_initialised;
>> +#endif
>>   };
>>   
>>   static inline struct efx_nic *efx_netdev_priv(struct net_device *dev)
>> -- 
>> 2.17.1
>>

