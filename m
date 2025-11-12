Return-Path: <netdev+bounces-238036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E639C536A2
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 17:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7F1563D40
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E144340274;
	Wed, 12 Nov 2025 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IA1sAoQ5"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FA233F8D7
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960249; cv=fail; b=BR4zoPDW3egr5xZzAizrImek+6/n5naw1M37yoLRq1+hSO3OjQixjlwzPcJqNjC/cUCSAj25XgTuXD3uSlqxGde6d8P3d/piJ+tVmD4INSFAwmCf6dDK0vrudM2h/0JKNxmnoomXTcz7WIYBlfhIL7M0Z6mrLL9jTrERFux7l30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960249; c=relaxed/simple;
	bh=DTjdK2fEEKY18jVbnJ99jd+/vgQLj7l/HDtjMdXIA+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m7YGq7/4gbRM9EWpM1ZvCLyOiFpfxIy69DjvjEPXGl/kCqNvaVhTrLVq4CHXnQ2Sh/XnCPCOG74h7jHMgzsWSwEB/8xVrwXMfJBrn0kPX+NNTCcLhveRIFycvCK+xaSd6i0lBJ9TRygmQRCW+1WotM0D5JRYhdU1CKZy5F0AAKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IA1sAoQ5; arc=fail smtp.client-ip=52.101.61.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uozYgV9rEAxDMC/DYFNzfrpAWNOgFm26T+eK68956d0oR+mk9oM3S96J/QD8q933c6XN0Hs3LCVFRUT8zT84Ym5laP13tvOkTAja49Y/1B8X8f4iPsFVuC4us4xXlNp6EzxH02fXHXp1hGaeq416L4/45DFWBoD7e0Xpf3HjUxOU4T+EMeIvRe/H0h7FZP263IxbOcYuPeZg9vgvvEmpUGNDHY3Mr0pgINftzVJqR1hiYBvd0enBFLcoxB7eqcLXC8P+7/p7F9v7cT2rg5MkVgUFF+CLG/Cvs7dZ5otkIlgCLzNg6FRgrmeFHvLhMQOaiY4OqmEc3emAy0tkMMhMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfIFGXUCYnebZxQNIcBufmv73037if0PZS7+W4K27qA=;
 b=CjK5Dy8QnRNjch3tOn/y2Uv4pqrW1pquYWstKoAZY0OlsmM4X67wfJPNJJnDVKsy00igwuSye2psx0Vl3RTgWjsVknnzzGrdVbFkfb11dIHJevhDAzKysfH3pA0JrpqodWd9KtZX+wl7fFWRCemz7fwQ/0JMI5FuWVMAXm27BPdUSbp84rOKwIB9WziAL3s3j7J8VV8dTl/WVzqJBwH7PhnlsRH5WurScTUAoXhMp1/AwfePsN+rjKZLM5wgOsmPnYAPFGB3p6SZBinJIAup7QELRe0SZiOC2iOiKAoQo0OpBbvoTVOtMnYzxtRdcJBwmAA8lPo/MKKnAZGSR6clYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfIFGXUCYnebZxQNIcBufmv73037if0PZS7+W4K27qA=;
 b=IA1sAoQ5je2+IMCcPfeXwjPafn1recKsTEX5u/yh4nfutwlihxdoB+otRq3r2IKbSLXP1703guNA46/CMf5k7SCw1R58yDopxTsLMQJEbM9Neze+Z+18LspFi6FszZQP+BXmJd03PdAFRqG/9tCiDnNrM+sjpCJACG3no2rTWoTY1U2gT2lQ1YyCK7j05m80KUqfSFTJzVbEssh3hP+l1jeWJ1aTUz0nS6C1rFbemOxBvjOYVbRmqcF9Ouee7eOXbbX8/QI5YjkDYWrUiSNeQ/lV5efjPykl7GAbsjJL5S07UENWADZ0K0JczB6N4uObL2wHvPaongtNu/4AEQOZlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 15:10:44 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 15:10:44 +0000
Date: Wed, 12 Nov 2025 17:10:33 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove eth bridge website
Message-ID: <aRSjaUw6rA7eQXYx@shredder>
References: <0a32aaf7fa4473e7574f7327480e8fbc4fef2741.1762946223.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a32aaf7fa4473e7574f7327480e8fbc4fef2741.1762946223.git.baruch@tkos.co.il>
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f27be2-cf3c-48de-4b21-08de21fda6bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTB0YkxacTAzRDdsNTl4Y1RTYTA0WDZGSU9RZWRYbEkwRWZ1NE9oNy9YVWxn?=
 =?utf-8?B?UCtsSHY2TGY3Ym84TE5yR2JqVThWcktWQjBFT01HSVZMU2Y1TnBQdFdlMGNV?=
 =?utf-8?B?dmJldkpwY0hBNExoZjJ6dlFSSGhRc21TTno3dDBaTkJhK1Vvek0wRENJOGFY?=
 =?utf-8?B?WEN0ODdyM3RUUHhFUW9ZcE4rYTBJRlVsWWxNdXIrTWNHK1V0U3pWR3k1YU44?=
 =?utf-8?B?WWt3NVRPU0I4VEpjZ1E2MUt4UzZMVmhrcWNaS2xQc0RxSXIrUzdBMGFsSjhv?=
 =?utf-8?B?RGRFMXdKQnQ0QXFLMTJvdU4vVENBQ0t4SEZva0V4QVRuOFdGTlhXU204MktF?=
 =?utf-8?B?NFVyRGpGWnhwRnMvWlJadkswOU9lU21idHBVelVzTk5YbVRDKzQ1aGZja21h?=
 =?utf-8?B?Zm5FZkxuQlI5M1Z0S3FORk90anY3QWl1TzR3QUpxVEFjVVBsc0duUTY0a20y?=
 =?utf-8?B?MWduS0RkY2ZDcEsyaUJiZ1ZGQ0hFUEEwdnVCbFBQWWE0Vkk3WVNvR3ZCLzdK?=
 =?utf-8?B?YnY1RzFnazNMUlJUbGhkR2hnZWJnRy9nRVYwTmNrellQQUthR1RoWkxqV253?=
 =?utf-8?B?eEZpdS9TeTVyVG1hSG5EUDI1dDJZMGtMbkR2ek0rMjIxQXIxMlU4eVJjRjcw?=
 =?utf-8?B?L0JqWDZKeTFpeWtQMDhxcVlaWEIvMmY2M3ZSTURYRmlvSlhvbWV5UUl2ZVZm?=
 =?utf-8?B?SEwwRjhuK2p6cWhVY2ZOUFZlZkNpZTlBSEE4RVZBZlpHZmMvWmxNbDQ4Vy9v?=
 =?utf-8?B?aE5POTlxYUwyalJacEZEbi9OWGtWT0ZQVVdBT3hTWk5vTDNldk9LWlBNUmhj?=
 =?utf-8?B?VFRaWlhVcUIvUEllcTQrS3hCOGpaaFhQVHFya2FZbGpqUUhuTjdTVWdxWHFR?=
 =?utf-8?B?M04xOHFJODZpVWswenZmcmw1WVpZdlB2Qi9wMUlKK2VGZlJZaUZHZVdYclVI?=
 =?utf-8?B?dU9pK21iUnFjNEtsZ3IzSENDWFhaRFBLVXMxRnJrb3dHZ044anB3SjArUys2?=
 =?utf-8?B?Wnl2bUMvcmtDemU0SVdoZS9sUXVFRmtpYkR1UHk4MVYxWnVLQzhaY0pIMms3?=
 =?utf-8?B?Q3lsR0xGUittcCtHSWZ6S012M3hCQ3Zxd2RsanlVWGxsWmdZU0FscU1QZkZa?=
 =?utf-8?B?bmFKMG4zWTRUSmh5VVRGTGc0R3ljVjkzTUdaWlJ1OG16emJaRFpFVzFDcW1D?=
 =?utf-8?B?Q3RuWHhleWM5b1JzQ3ZGRDVoMjdpWWpqYWdJMmhYY0pyRWhZQ3BPVjB2djdC?=
 =?utf-8?B?VjhPS0srSU1CaVV3MnRQaUlJT1BGSWNJNmwrVm5kVng0elBKaU9ablQzQkJD?=
 =?utf-8?B?Z2svemQyS0NJUXBiYkxKRTFOLzlYMmZMdkNQbHVKZ2dMK3BVT1FrZWpWMzls?=
 =?utf-8?B?YnVYQ0xPWENtU2ZBaWR1Nkt3TUs2MXZIeHJjQXFlcnZjVjVGT1ZnVXVFRlI3?=
 =?utf-8?B?UG5NdW1OZmdSYjVCVXB0cUpqZlVFalBPakpCZnJ6V0V6TSsxRlNBSGxqOThu?=
 =?utf-8?B?NzZsd0MvSHBWRzYvS0lmUnRuU2NqWW91UitkUGR2UkwyUHFZNW9lditYQzk5?=
 =?utf-8?B?MWt3RlNyZGdzRVJWdFB3NThoUC9ZcVBNRERnMWRmK3lHOVBWVjlBRHRxQTJ4?=
 =?utf-8?B?ZzVQVXdMeFh4a2psRTFjMXM0Rk93MVJEa1FDTFNENzAxRmEwN1I1S1ZpY2xU?=
 =?utf-8?B?WENWQ1V1UlhlOHJTZUFVSUQ2cDVRcmR5ODVGL3JHVVBFZ3RNWnowTnB2MnVr?=
 =?utf-8?B?R2l2V09HNTAxNGNsYis0T2hpSTVReEpDdjZFZ2VvOFBCSTF1L2xmd2NCVDBY?=
 =?utf-8?B?T1hKVFlhRFJxR2NqR0pQczVVeUE4UnU3MUJHVitpaCtTZGJDTUZqalVuSHJl?=
 =?utf-8?B?eHgyN2dnV2VoZ2Rva0tKeXRHa0dRZittZFFZR1hrMElDWDlCalhTZy9uN3g1?=
 =?utf-8?Q?qv7VZ2Fmg9+LjBHIpJssayOYcNMQQmeA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnpGZ0J5eW9RSlBwamJVbkNwOXRxbHA1ZEt0WkNWUWF4NnVvYnc1UXBOMDJh?=
 =?utf-8?B?QUh2M2ljeEVXbFNaOGNxK3JVVXZMTXdEOE00YXd4cG1UN3R0cEkwWTc5MGV3?=
 =?utf-8?B?TEllT3l3T3pFYVZLYlBQalZwRnpaMkJZVEg4SlVuY1ZqdnpOb1N5cG1vaEdL?=
 =?utf-8?B?L1p5OUtLdHZ4TTVtcm9pb3lIV0E0TmpzUkdxbWtQNlFjR3pyQ05uQTRjY2pB?=
 =?utf-8?B?RGNTd3U5ZG1idVhwNnEyRWhzTlhFWWtQQjFKVzdVd1d5U3I3YTdtL0RQNG1T?=
 =?utf-8?B?S2dBMWZnbzZLdzlmZThwTWFvbFNtVmRSSUJQbE5yc3UxZHNSeVdiaEd0NGZn?=
 =?utf-8?B?RmlzZW9BWktvODh1QVZlSkdHKzVrU0ZNU1g3NFdpOVVraEFmbStCMXgycjdE?=
 =?utf-8?B?Rmp1SmtnZENaM1ErL3duM2N2dUpQZ1JGUURtcmF0YjlkUTg0MXh6VEtEUzVl?=
 =?utf-8?B?ZzZYeXZwck1aRTVpQTVZYTAxVm94eEdJaEZtbk5jWlZpRC9BVFJOeWw0aU45?=
 =?utf-8?B?cXVOOUNjeXE4L3dyaG9uQlNuNEZVbVZLWlgxYjhnVnJHaFFONHFvUkZUb200?=
 =?utf-8?B?ZmJreENoQUpZMENlbDVXMk9tQVhZeEJvNDZuY0c3ck5IZGZqL0kzY2wrNWFC?=
 =?utf-8?B?cWhHUzAzTGFUWDVya01ubURtbHM4SjZ5eEhuVUYvNUNkOWRLZ1dhN0xNNTZn?=
 =?utf-8?B?Z2JJVEYwMGpQQXBBbHF3czA4YnFNYld0UHIzeHljaE5helVxdTRtSC9uSUVt?=
 =?utf-8?B?MHlGd1hVc09WRFkxR05vaForUW0xZW5aRkF5ZDFuanN6Y2tiNHJFdkZCZGMy?=
 =?utf-8?B?UW1wUnd3M1lpMGo0NHQrcUJ1VTZZZERvUysrenBjYzRjOGVSQ1A3emY1VGJM?=
 =?utf-8?B?K3FBdTBXZ01XNnNFWjFPSjAxaGREM2UzTEMyRm5wbElpRXdHeXR3c0JhRXds?=
 =?utf-8?B?YWtGamhteGlSUklrUkljaCtFK1ZzaUF1Sitpc3JpeTY1V2FWYXY5aVJjVyt2?=
 =?utf-8?B?a1Y4MUhWL2E5L0JyL3VoQ0p1eWkwa1ZoM0l5V1B2WEFLOXRxemtFTlVvVnYv?=
 =?utf-8?B?Yk43YXZlRFJwbFZaS2ZPODdSc0NOSm9IaVJQN2lRZk11RFM5bWVKdndVTXhw?=
 =?utf-8?B?OU1QdnB5Vmo3SGdkbXA3YWw5SWN3YjdlaHZKVUZVSVptdFhJb1VQdURqSTBL?=
 =?utf-8?B?bXQ0bGlZUlVYSFJ4dUM4SlV0YVNmenlZWFhWNkVteldXbWlxM2dEMURLN1c3?=
 =?utf-8?B?S25tOWlPaWVMUGRzY3BoUUV6bGliKys0NTdWNUZBUVh4OE93MzU4bUpHdXla?=
 =?utf-8?B?M1ozZG5HY3lKL3lwdSsvZmYwakpEMjduTUx5d1JhU0xIZ1FjeUh6ZzUzZVkw?=
 =?utf-8?B?UFVMQ2RmbFZHQmFleUlPVU15MHNZMzJXYkUxd0VsVGRZTzNTd2VIc0N4UEd1?=
 =?utf-8?B?cUVEMHEyT2tvSk5iREx6MElnYXFJanZLaHVIN0JKeWYram1TV21RcThDQjEw?=
 =?utf-8?B?c2ljOHdUTGZ0NWZGclRiODNIYW5VaTdWSEZ0bHQyTElHTVpRQ3MrdkZEK2dZ?=
 =?utf-8?B?L0xjWnh5U3NyaXhmUjY3ZzMwc21KaHJaQ3Z4S2JXVGpEMnByTkRVbjRpSG9F?=
 =?utf-8?B?RDdqYXhwWWJVdHlMK3Q5QVRzSzZLQk9WMXhqU09tOGQreGpTd0M2RTdyalEv?=
 =?utf-8?B?RENCbTRYRzVjbXIyRU1ZbE8rTytlY25OUms3TzYzdU9NMFRIamdERmNHNVZz?=
 =?utf-8?B?TU9vcnYvM1Y3M3A3Mkx3UVg1Y2NtWlJVcmhZbUllWEFyMC9XTitUdTRCRzJP?=
 =?utf-8?B?aUtxZTFjWmI0Q3M2SDEwekhxME9MV2w1QUh5UDBzOU9qWjYxNW55WmcyME95?=
 =?utf-8?B?T1V1R3c0QmJObEtNY3VjZThXZGw5RzRQL2V1MFhBRG5CYlVIQWtLSkh1aXZm?=
 =?utf-8?B?RVFyZFdMQWsxR3VHVm9KUkNBZ1hSeXB5S2RrazJKeERzdnNlTElnRmZ4QjBT?=
 =?utf-8?B?dWhIdTBkeEZ0S3NSY0FxWnVFSldSTEFPNXdtbjBCQkIzV05OT2JHNlFSR21G?=
 =?utf-8?B?b3l5OXRQcUZzMTRGcC9vWFR2Q3FYTzZoQXNPRHA4dUJ4YWVqTGE3c2RsUnFo?=
 =?utf-8?Q?gGbXOGdOEEgE9tIk2LelgaVnx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f27be2-cf3c-48de-4b21-08de21fda6bd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:10:44.3438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATQAcH6f/tw/n9k3cuyhvra6a5MGiM0XbYmJaJYul9VMDZfJQiFzdIdfJT5wBBPSIajZCu+lJd1gCFmOcxXaZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753

On Wed, Nov 12, 2025 at 01:17:03PM +0200, Baruch Siach wrote:
> Ethernet bridge website URL shows "This page isn’t available".
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

I guess the correct link is:

https://wiki.linuxfoundation.org/networking/bridge

But it's outdated, so it's probably best to just remove the URL.

For net:

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

