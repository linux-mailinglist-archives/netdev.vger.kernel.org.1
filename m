Return-Path: <netdev+bounces-245045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF022CC65C1
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 08:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C9583015EEB
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 07:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D92D2EF646;
	Wed, 17 Dec 2025 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MwIBpbDY"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ECE335568
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765956534; cv=fail; b=j2tyO8wtAj9+r6YU8+6NawzwaLmonlfubrprejMP5C2a2XPqBvkNcFW400IQ96pYRCM2Ijghcbr23EgevjtqhZDFTN82Ec64pUJcJjhSgy114RV+tuRyBanS94hJ7v5zUDgUHxD14bnvDlcE8F1n9ZwrFk9BpGSX7izI8eVd+3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765956534; c=relaxed/simple;
	bh=IHL90WUdz0sXvxtiH71wRZVUK5UifM1qDimwjBcyn7A=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O4Ktuo0p84fCmh+yeP/rNtE+zeUR5FmqjfKNpK+OMbkH0+JgQlTBlw8LuD7Wh0U/8tyxfIug2nt4RobrhHCB7OsdVjMWW9ajJBJaKhPC3xQNvsRWHp+RMHwtHefxde4PCCWnHH5vrAXVLnI2qcLmhRwaol7GGSd9AOzPkRxFirQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MwIBpbDY; arc=fail smtp.client-ip=52.101.52.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9Xu1QPM2N45h02TsIYopCWdrJW93+n2LE5WX+b4yVaY/27s5TYW7uNRGuWhvU5M+up0n1l/1xws8ZlXEGWgg+uKfrio2flYEVr0pGt4/Nah/1rC/TMSewrJ1jq6NPoevI6dy3EbaaG1Jpz7G9e9jJccalwh9hg94dCFsw7xW2SnTA27wF8aDJb5T8SylFe9+G9fWg2A2wr7A87ERyI1tfTkALuGGo6mU7g0JBV3S4/BFGE+zBS9z+A0dgs+WeSOddXd3SngV1TAiSap9lY46vWBBmt2RbOpHlvNpXweDEFqCfSKh0gwW7hxMs3fryAWD99uW1Ignop9aAvxe1fMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iySgWEaq+20hzUjOLdTx1ezzbqvELcD7Af7TV/Ja8bk=;
 b=yMKB+Byos0kM5GCRFm/u5rAdtGOhetBhR0li+dSs3pjBNvNjnVc+/LQxHm/KVGrImjpDriPYDIE7Rw2sFkIuFIjiDi39CZgFj1dUHntncVC9N4uK313ubKNDrnz6MMjMJzSq20KEiF9s31NIOrCX0LFz360RL994RWqqcOxBbjWcaQP0Ti7FRfMovCqmo+BrCZ8as1R3My2Fv7WAWe+kVjfaQNRowX8P6olTKI3UJQ42/3PdUF7jbKQm8+E/Ut2yp9s2L8fMrebc3TRLRmOLYFBhVcyJqWyiUQEFFSHPDRJP0oIJyECNMM217ACC+IWqI3KD6ey3Y+2XYd1+PjwWTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iySgWEaq+20hzUjOLdTx1ezzbqvELcD7Af7TV/Ja8bk=;
 b=MwIBpbDYyeWlxdtLZLPZc7vg+tOMf0V1hLIZBZRBSEeEgK2KcjjE9lj2nRL2DwDYhV/618Y8Hj/bqOPWWNWEtDOuERUxDh2BR/u2PZOJM7P6LtRP87CU4usxbicOw084xXe7CaAhXlZSR+qzxcmt5JyU8Qfr1zzW5IoRVEn9fet/SaL+uJ7WZh0o7c4HRr115h8slhHuvuWyA7BmR/Z829kmnlIkxVzB+VxhuLWZERPO7rENens9DBQ6tZ5pB+o1FMbrBURlBj6S8XO9i4KNBbmYavWpj0wsDb9pJmno+aTUieZLA6J6WH4TzZeiFnckNb38H4aR82yLBFPkvYw4rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 07:28:49 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::d40c:ec80:91ad:9b57]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::d40c:ec80:91ad:9b57%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 07:28:48 +0000
Message-ID: <a5ef868d-b957-4124-a9ed-030f863dcd29@nvidia.com>
Date: Wed, 17 Dec 2025 09:28:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ptp: prevent info leak to userspace
To: Kyle Zeng <zengyhkyle@gmail.com>, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
References: <aUJYSv6kqb9QauMI@westworld>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <aUJYSv6kqb9QauMI@westworld>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0014.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::8)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: 194615ac-ceb3-41cf-348b-08de3d3deb53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mlorc1o5cmp5bVpaVlBWWlFpeEVJeld0TzFEdXFhSHlsdG9WU3U5WG1mYzRh?=
 =?utf-8?B?czNUdHdvNkVoMEZLZUZLYnhuL3VxeWJGQUY4WDRQanFOdkZscE03T00zOVdJ?=
 =?utf-8?B?MlhkNXRBM3lWdFRzNTkzYWE4MW1pU3FNRWZ5NUtXalB3RGpYbllIOHR6d1Bn?=
 =?utf-8?B?TnBmVk1ONFU5VEZuR0hBc296em1Ra2Erd0ZBS0RTUHQ0UFY1V0kvSEZFeEd3?=
 =?utf-8?B?c2ZDbW9ybURjdVJWOW83aVBQWFZkeVJmR3l0UGpZZGY2cEVLWm1GTVlIWG56?=
 =?utf-8?B?bDZLb0ZQdjVuMVloc3Q4UkRML21XN2VtaUdBQ2R5bFI0UzZEK1JDZEw2YkZi?=
 =?utf-8?B?L0hScWVRQVVyeGpibFpJcGRkNzY1NHRhZDZ0V1FQNE1XQTJyQnQxejlTR1lQ?=
 =?utf-8?B?RjdiNlc0dmxweUEyQlIxMXlxY1k3aG5xYnlzYzdRUkVSQ2MwM3k1RG1CK2dw?=
 =?utf-8?B?bTlFaDl5d3lPWUpLSldsZ3ZKK3FzSlBYei9lUDIyMkYwMW9sWG1MYWlobmty?=
 =?utf-8?B?dWhTbWJ6YmRwbkYyaGpvVm5xV3g0TVdGWWFMVmJkeTFFTTY4NnQ5emtxcGw4?=
 =?utf-8?B?NDE4eEJzUkZWZm8zNXp2bWFBM2k0b2E1WXFyR1NlUDRBZnlWSWtvWGwyaURX?=
 =?utf-8?B?T2tHL1dyaVBhYVQ3YWZNZ0ttUjNrZzNWeTlDcU1NUGNCNW51WDZYaTdGSEYy?=
 =?utf-8?B?eEt4cnkvQTRaY1cwellkbGMvK0t5eXFGUGZpcU5aVFZFY01YMjdzSG1pd0Fq?=
 =?utf-8?B?SGloVGZ0SG1icEpwVm1BbkpXSnJMaGhCSTlweFFrN2FzOUFUa0tOR3lpZkow?=
 =?utf-8?B?MWJabUM4OVpBRGdsdWF1MmV6YUdOYjdqZ2J1WHZDOXBMaU05dEJ4cjBaRDdw?=
 =?utf-8?B?U3E2a05hQ01velYyMEtzQ1dRUVRxYlo3ckxvOXVRaDlLaWVXL3JsZGIwS1ZI?=
 =?utf-8?B?NXdreXRSTFhjeGRUaGhlUHUxQWthUFRJeXBQcG13aDV0YXN6RHlteUE4RlVF?=
 =?utf-8?B?VUt0NVJBS3d0ODNtWksxU1FFd29NU0ZnNU03ZUpZUkRtVkVlNGhFMWplQVFn?=
 =?utf-8?B?YUcvc3RCRTdkelVyeWpOemh1c1dqWFpxeGRZZ0srOTZaZGVKR250YkNiN1FN?=
 =?utf-8?B?VTcvd0ZXNmJ3SHdXZU9WaHVHOVR4REFwa2NFZEZiUnFWUkJ4cG0yUFJ4Ryt0?=
 =?utf-8?B?S2NUSEVTdm5GWCtNVFk3VDhmL0UzaCtabllKa2g0YTM2ajZsSHUxaVpoK2hD?=
 =?utf-8?B?MnpMTXRUa3RtZDNzUDBsSnZMUytjRGJnaUlxRkNJTzZORFBJZW9zL0xWZm05?=
 =?utf-8?B?dGJiOHVwMTFLd0ZSdGZBb2s4Tkx1SjhPZ05zRHpMWk5ORE9nZ0QxYkU5U1Js?=
 =?utf-8?B?bzA2SHRxY0lwRFBQK094M3ZSNkpsNXdvUjl0RWZWVFRIb21HYzV1WmJFa1V2?=
 =?utf-8?B?YWVyTkUwejBESTBTT0M1Z01VR0VQWHpvcWFvNHZXMUdjcnBiVUpEWUlRcUNq?=
 =?utf-8?B?amNHQ1J2VE8zYWwzeWtDSitrVERpTnNHU1NmQ2pDSUZxZHpTUWNDRTM4R01J?=
 =?utf-8?B?WU85b0JkS1YzRTBQaVJ3VVVzNXNkeUtzYnFrSWxUZHZMV3JlMnpOd3BKSTl3?=
 =?utf-8?B?QWhIaXdWTldHMHJZTHhhSXJZY0JYbFpOZkNPd3MyMHpNME5QbkJiTEZNVEY1?=
 =?utf-8?B?S21IZzBNOWVLS2lMT1lJTXRQYmdQM1BpWGFSYXc3SzNtVWQ0cGxQT29JdVdr?=
 =?utf-8?B?QUoyOVBMTm03b1EyWG5ldGp1bTdqOGljM0hOVUN5VTVKL1dCWEVWTjB5Mzlx?=
 =?utf-8?B?M3M5ZmRlRXJtcS9oZWYxY05PcWNWT1FlYnFSUWdoWkV2Rmp4aUQ0dWtDMm9s?=
 =?utf-8?B?Sm1NM1d3Z3JnVmEyeEUwdEhFbWQ0L1RpRmNFMHUxL0NpaFlzUW1wSGMyMkRw?=
 =?utf-8?Q?mQuLnIY1knW+JECpaamY1ObIwRp3M3uX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0dzR3FvNmJGekdIZzZiUHprRHN5Mm1zSEdscklqcXZrejRaNlJnWTFjVUh0?=
 =?utf-8?B?ZzVmL2VUL1o0WmtYdmpQTjBGUmtqUVpXQm1QWmVIbWNWRkpEOTBzck1XOXJJ?=
 =?utf-8?B?cC9oVHhHUXRzdDRTeHMwK3I3N2JwOXUrSmRpS01aVit3dHJueUlLSGhydXlJ?=
 =?utf-8?B?Z083RXFOSFIxUUlSTXMrdXR4QVVZcU11Lzg4QTNVSjBHYUJqMVk3RGIzdzN4?=
 =?utf-8?B?Y05pZ25zY0xic1UzbVhWdWJ0eWE5K0Q4aFYvOXBUaE91OWVZaFlRbVNNNVR0?=
 =?utf-8?B?WFRBRW9USUE2aWNGd09GcXpIN1ZTR0x3T2JJVTNMSnFobmg0UTJNNkJuRUF6?=
 =?utf-8?B?UllTRTZ1a0pMTm1MMTRYRWw2MTlkN005aVpwT2ZRdGZRdUxld0UvSEppTk83?=
 =?utf-8?B?V09vQ2h0aFJtd091UXQvbGFhUCtTcFBTSDB0VENwcDloK1JTL2pNQTY2UERG?=
 =?utf-8?B?OGpkSXNESUN0WjVMdGpSOW9xdE1mazU0VWFJUXJkRSthSGdMdU5qM0w0Y1d0?=
 =?utf-8?B?U290eDIvSG1RYncxN0VzSmtxRHUvMUxISHRRNGhGRTQ4UlNmZWVEZnp1UTVo?=
 =?utf-8?B?SFQ1Skx0UHkzMTBsRGdlVmtBc0NMQ3JjQys3RzF0c2RFS0MycDhOOUswcSs1?=
 =?utf-8?B?Vi9LSm1GalpQWXBZWk9FUVdsNFZMcWlJdERsY1BwTkJLbE96bmh5Ymd2cm1D?=
 =?utf-8?B?K0NSYU9VTm42VVpUT3JqdXVONnY4L3J1YmZkeUFrMzN6WEc0RUlRZk81SG8x?=
 =?utf-8?B?U1RVU3dsdkczUkJGcFFQTXJOemJHa0VqS3RzVnVpeTZGTzFRY0dORXpSS0p5?=
 =?utf-8?B?WC83d1dSUFVLRFRLNWNaMlI4cDBoVlpVRFl1eDFyQTUzT1hUYVRhWStxaFFF?=
 =?utf-8?B?dGdoWW1NWUJnZFh5NWp3TGFOcWp2MFZnSzJ2ZmJ4SWFxVTVFVGgvOFpXU251?=
 =?utf-8?B?NzE4MEZZTUo3OFlIT1NybDhZVWZEcUNFRnRIdExscnM0akg1MWIwbnZxM1dM?=
 =?utf-8?B?dXowK3QxS09DRXQzdDF0UW9mWk0wVTJGWHc2UXZFMS84STZsNEhLOUx6Nnh6?=
 =?utf-8?B?SmhsNUsxQW5IdXFtNW9aS092ejBCQVhTMUwwblVOUDNEdFZWckpLOHVNc2FC?=
 =?utf-8?B?ZTFIaVBWeE1LRmJhcUI3cXl5azVCenZrSTRiVzUza01KN1RZU1BvRjhPanFU?=
 =?utf-8?B?L0VCNDViWFRYdXV1b1hPeWxaRVJBVFNRVU9BbUJzeEUydUVhWEhFU1l4WGd6?=
 =?utf-8?B?NXhFaHpKTnpyREtYdFpSYWUxemJ4cUZsVllwZmh0WkRaeEVvR2RIaXpGTUN0?=
 =?utf-8?B?TDlyZ0N3ZHptSXBENi8xcDZzVmZINHZnRDg3cTQ3dnNZbWRmNnRSeXcyZnpV?=
 =?utf-8?B?Sm53L2l5dkF6WnBrcWxoa0FSOXZIYXdvNXRCNlVDSEU3R0FZM0lUNmt1bGR0?=
 =?utf-8?B?RVBMN050eUtvNW1TMXpWV0t1NWRnRHI5TkVJd09Kb3ovVVFFdGo1TVBpS3ZR?=
 =?utf-8?B?cVFPNGVINkloRnN4c2JHRE1iTE9qWnpydHkvQkxqSVUxMFozTjVmdVI1Y2d0?=
 =?utf-8?B?WHhMbUlhdGltNjFmRit5MzNORmYrQW03Sk55SFl0WW1hS0h5a1BnYlpOZGJz?=
 =?utf-8?B?UFlodjNmM1QzdjhKbDRraFExd3VFRm1mYzNld1luVDRHY1dMM0FEZnVhdHpL?=
 =?utf-8?B?TWhzTzlaMWczOE15R2pJRUg2dXZoUFA0RFEyZEp5QmQ3djBaWUsxWVBmckJK?=
 =?utf-8?B?MVplQkdia1M3TEFBT1FJQTdsaEgwOFhFSXo2a3o3WkRtNXZ5MnkrUkNWMkI4?=
 =?utf-8?B?djQxL2ptRkUxSk0xMzdqQnRyVm9ERVRCM3R3aFMzN0ZYOXV4NUNOSXBUWTdR?=
 =?utf-8?B?SU5pZkxiZ2RPUGk5UUxQeUM1eEhjNWxpdGVUaVI5NUxFbGJkWTVUWjZFdmoz?=
 =?utf-8?B?TFJTNXBlc0l2STdQQWQwSnVQQTJiNlBFQlpMMlkzR1BiTWU2T0czTEtOMStt?=
 =?utf-8?B?WXFlUGQ1UW02SXBjOWc0dXc4RDlKZkVqU24zM28zcEx0cGtLdUg1QXNQZGMz?=
 =?utf-8?B?U2lOSUdPeXpUVTFYaWFhVVZGQWtKUVBzTkQ0N002SUlxbGpoQ3IxNVN4K2tl?=
 =?utf-8?Q?zBjI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194615ac-ceb3-41cf-348b-08de3d3deb53
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 07:28:48.8012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LA5GGERvgocTgD5pYHVtoXxA8C8l2/wxSrehevMliTF4oImRhJOGoNgvhLNzhF+2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577

On 17/12/2025 9:14, Kyle Zeng wrote:
> Somehow the `memset` is lost after refactor, which leaks a lot of kernel
> stack data to userspace directly. This patch clears the reserved data
> region to prevent the info leak.
> 
> Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
> ---
>  drivers/ptp/ptp_chardev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
> index c61cf9edac48..06f71011fb04 100644
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -195,6 +195,8 @@ static long ptp_clock_getcaps(struct ptp_clock *ptp, void __user *arg)
>  	if (caps.adjust_phase)
>  		caps.max_phase_adj = ptp->info->getmaxphase(ptp->info);
>  
> +	memset(caps.rsv, 0, sizeof(caps.rsv));
> +
>  	return copy_to_user(arg, &caps, sizeof(caps)) ? -EFAULT : 0;
>  }
>  

This is not how C works, the designated initializer clears the field
implicitly.

