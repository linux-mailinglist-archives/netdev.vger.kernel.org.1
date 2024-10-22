Return-Path: <netdev+bounces-137688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831BF9A952A
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 02:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BC81C2247B
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 00:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E810028379;
	Tue, 22 Oct 2024 00:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b8w3Dvwz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2175C4A35;
	Tue, 22 Oct 2024 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729558240; cv=fail; b=erwyqRqH0dXKj+HGkkT0war06OnJTLXf3ek9rPfX/vz5zO03XttRVoalPlrTdFz5o2K5CVHsEVHQW/k2tX0zWCUxZ26hO3pS91IwweMwgI/LVBsh/krGkWi+YY4P2No64zmcv4ykzGgJNYOMzKEoZBUbJc2FdrLM97xpOEw+xfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729558240; c=relaxed/simple;
	bh=E7gprF/J75GeAhpepkexsDCLYXrPZfQ9qg29O/AiouI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e7uxcG4Q9q7uZ4TaEwDNQ8So1HK+JMgnl6wwaJkYbioqwoPTbcB0S9/8RFVG4zW+5t+kIq1MsuqyTQEw8ZZjpgJA+JOpO3qlBmTZGamb5GE8NZ7RYdzPPvStTBJG66+5iu8BdsYwBTgQmr1Yoj6SZyTzkTvsZRr0YiMWOMZCJ+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b8w3Dvwz; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzw9m4jsBMj4kZ3thDG+XkEYhtf1u38wkY2V7Wn1sPAMi0LsPxoTZjzF2g98pLsz32tQaQ9tDfjF8ndL3QfpeIjgWh7JOB/WrG6busPYspQxLhLwP1tIblFAIiD1Y2V4lCD8mjEjAJ2JkqyL0YmSv4ZUEZnDTghmEcoKtKJSQg0VsyixTkKzJWUwttxNc9H4F+BsHXGl4gWx6ELravoa9doHtZQRsLptW2f4FMC4mpJwB8foMn13lIm+d+HBwkKWuHI1+mCyOQInNNQxvhRZfOTxhm6vrnkFRfi5NDl143QUi+m2gKdgfojBAkuJU842AcHBIW3CtjpVXOQ07CoIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpA1eVcvPYR75TqQksvbL1U91C6hrraOw1vWGvzoxos=;
 b=Gv1F7xjg4v0CykwYU/P7yQRKumWzhavgkr0ier8CysPdoyoICPn9sxMCTdrg6M+99cIsHP/xClEw53TboHClXmvvhC1CC5KPZSmSKksqj5tXrYKlGbtM9uF+H2uAmEkbVCYK9sKiZLJ0FsUBKMNQgRBylXeIPHMXR3omadiWH3QLAIggR9DDdu13oYByzFQZCT6tznOV+YSzGZtheikMvHiPOIhAKcxF//iJqh+pH2EhcKJLxqyAT+zvYJvmOwMkmLPC1A0Suni+EtMeWlzZqFNTCXdjW0s8WeRY/ZhXjXnmpb62pTjX/ED9SDjvIOAbl6fDPN0yhk/uEkCxmLrWlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpA1eVcvPYR75TqQksvbL1U91C6hrraOw1vWGvzoxos=;
 b=b8w3DvwzgP3zm2aNCpB8c7iEZOhzzeLCsBEATJoJYCftd4vHdTygVhovJYrBrSEHmWZh0ggU8LndD8c/db8Hlv+w5vPrqzrUeGeBCqrQoCW5JfgpBHa1ID0yCEQ0jxXK2kaalxDagFKLVuiGC/UMsmvXWr4GxyIEBCGj2I3uf64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Tue, 22 Oct 2024 00:50:34 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 00:50:34 +0000
Message-ID: <1b807d16-2025-4c2c-9511-573e63be1d59@amd.com>
Date: Mon, 21 Oct 2024 17:50:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 net-next 0/5] ibm: emac: more cleanups
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20241022002245.843242-1-rosenp@gmail.com>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20241022002245.843242-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::17) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: ac63823b-885b-4f69-56cc-08dcf233896e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmJXVFZxWDJMOEVvRHJFL0ZTNUF2VjMrV3ZYTDR3ckFDUU56TzhuVHJHSTd6?=
 =?utf-8?B?UFBsRUJCK3dydmFQb2lodWFiU0JJK1BXTk82ME00MmszT2x5aGpYdUxuSDFV?=
 =?utf-8?B?YkRZb0xTZXlGOExZTWxyUkpZMjUyV25ZVUtXL01lM2UxK3NJVE5KRXVXMGFy?=
 =?utf-8?B?QUt0R0xWZE94NnMwaVlsVGRnUEVVTThkbmVaNWs5cGZDcGNERHI1MkNEbjRV?=
 =?utf-8?B?eFRiQVhIUVRWbU5PUndNSjZYdnVrS29XVUhZbnhBN0F0VFRyYkxySk9BM21s?=
 =?utf-8?B?SkxabnRMUmpKWWtmWXBuOFVubGRLWUV5cWRsRkpOUDRKanlRRkorWklhOGpF?=
 =?utf-8?B?bUR6Nm5CVXVaaS9pYUZsbXRUQjZyVEtGV2RGTloycmkrdnlJN2VkM1hOQmpQ?=
 =?utf-8?B?SzVYeXpzNWJibjlMSThXZ3ZiRjB4b2tPTThxQml0V2ZzNEVvOTJNN2ZyMHFO?=
 =?utf-8?B?Rmc4ODkvVjZ4cVg5UnF1ZXI1R2dZTUpnYVQ3ak5XVy84UVpoRi9LeERScFBa?=
 =?utf-8?B?UCt6a0RoR0tmTXcxTUlFTEFTTzRLZVUxRzFjK25JVGYyaWFPOEpTWEtBQTBN?=
 =?utf-8?B?T2Q0K3JVS0pkN0htUTQ4MTl0a1oybWZhMGlteUorL2Y3Z1pvT29zZk5MOWwz?=
 =?utf-8?B?V1lRcU5mM0lkdmF1NTZVQ3U3NzV2N0JnNStVbWpLdzhRRFM3SjFRbDh5S2Y1?=
 =?utf-8?B?Y0czN0QrZ0JxTWdGT0E1MGlsaWswTWxEQ0lrSlExVTA5MnlCdnNGK1c0Qk1K?=
 =?utf-8?B?Tm81aVU1Z1ArQ1dnTDUyL3lQVWxmdFY5MUd0U05hSTZ3UHRIWVBRcytpVS83?=
 =?utf-8?B?bXNwaWlDRlRRekdlMDVzcnVzeGNpaTF4bnFZNURsMkhQN1V5V05BQWIxcDBZ?=
 =?utf-8?B?aUdScUc4b0dhUUY3bmo5ZkxBMDlINUdPajc0QkY0bjI0QmVwaXNST1YzSlo5?=
 =?utf-8?B?MUwvRXVVTHo3ZEFOdWNtQnptRzdkaHFHeTB5ODdmVktuYmJmbm0ySzBiSE5X?=
 =?utf-8?B?VE5aME9GRnpiN3graEdjRDVvOStJSVZoSU1rVjh6ck1WNlJQTUhLZmdtRjVz?=
 =?utf-8?B?QXpKUjRBY2FuUitPcjBvbFNxQmFibENKOE9SQkdyRDdGNW00MGRiMGVpY210?=
 =?utf-8?B?bG9UUlVwRDRibk54TjVLWW5iT21DVmlQclpiWGMzVnN4TUdkKzVpMTNHVkpN?=
 =?utf-8?B?VWYzY2ViQzlmZmNkMnF4NDY2czkyOGVpUzMrUHgrbmM2MkI0clF1b0ZQODdU?=
 =?utf-8?B?YjJHM2ZoN1J5MmhBb0dNaENWdW0xWXJZNEpaV04vQkhhWVpZUnNJWkpVdndK?=
 =?utf-8?B?Y1pnWER6enJ1c2xPSkloR0J5N1ZSTWZuamRXTkR5VWFKSmllT3pOdXdlUGxY?=
 =?utf-8?B?bkZmMk1NK1dMM1NGTVlNMTBtVGdKTVNJK096TE45b0FFS0srR21LSDcxZkh4?=
 =?utf-8?B?UFRFWWVPcFA0N2xoRE81cHJKbFhuUlFidXVDazJ0ejNZOVB6WlNROHIvWHFI?=
 =?utf-8?B?MzltaUhxbGlMa1FORG1FLzAyWEZzbHIzblU4V0JqcHQyQk5aVDE4V25TZTFE?=
 =?utf-8?B?WXYvQk5aTFkzYmNFU0IzNXBHZ3JmQUFadyt0QlJGaEhXUk5aaTlCb2RzRCs0?=
 =?utf-8?B?d2ZvMURxdHJFQ3cxZzVUSlFtb0J0VGVRdjN2enoyQmt1R1NqZXR1WG16dG9y?=
 =?utf-8?B?bHVoY1FmMm5SMlFPcE1wd3kyR041TXN5Q0pMSzZWa1NpSW8xL0p6ZXMwVkxN?=
 =?utf-8?Q?SNhuFXYzL3Ydkmx1PEREbMfHwKduSo3bGBHgsYp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3A5NTFFc3RWUFhZdFNicGFZNExyajJMcTA1R3pkQWdjamllYlFxQ2d4VFk1?=
 =?utf-8?B?cFVHSHNwbWkva0pmNVlTR0JBTU9WemlwWU1Md3hNRS8wUWF3MHRiQktWaU14?=
 =?utf-8?B?d1FWeGpvcEo0MFRTMFFxaUNQYlVTZXRqYXJkU1ZXTGJjT1ZYNWl0UERhdEhO?=
 =?utf-8?B?MlBLOXZQSGNQbzFtcys4YVZsV2JtOTNHZVNUYnhkQ1NsR3JXcUk4RTUzbU1Q?=
 =?utf-8?B?V2QwejJGSjk1cm9XbUlYSzlRVlk5dWdyT2tqUy8rcFRQNk41Z3RlYkM1NU80?=
 =?utf-8?B?aWZ0V2c3dHl2OVNUWXNtZUtueTgwMUQvSWxRZkpCVUdlaGhPZDlMbW5Nd1ZO?=
 =?utf-8?B?bmJpRWt5S3FMY3lQcVdWQThxRDhGQUdOZGRsODE5RHNiRTFobUQyZkVabFhO?=
 =?utf-8?B?aXVzRW9lZlJDbzFxMlUxL1FsWmZkWE8xN25YOXpWS0l2c0Q0TEhGUDZGeDdE?=
 =?utf-8?B?dldHTUxDZFBQZlZzaFlzUktSQmNWbDRxUEpQVFhFUzN3dmFuVGJkY3AvTDNR?=
 =?utf-8?B?NnpIM0IyajRlZ0g3VWloZXhHZy9aQjZtS1Z3Tm1XSnNPUFlRTXNwcXN2RlFG?=
 =?utf-8?B?dHhLRmVhN1hNMkxTd05RS0RLZ293VS9XYjMyM3J0Vi9ZbU5uVXpzc2VNeWxP?=
 =?utf-8?B?b3VRRTJRT2dTNS9LdnNCTUFNZGw2d1J5RjkzVTY5LzRoRFBaSEdjS0pIeDJU?=
 =?utf-8?B?UUVVMVFydERqS2tqdzE4L0FEeXpoVzJXc3VPVStUdXRCRTEzeFZWQU0wVjdD?=
 =?utf-8?B?ZnJNQzY4V3NoRm51OXhXbE1mSDB6VlR6QzBmQ25zU01nUGtBR0svK3BqbklQ?=
 =?utf-8?B?ZFFLVnFBTkNpbjBmbEtWY0pNN28zRC9NWGU0Tk5jUlpvNzEySFo3WW9YQ1pI?=
 =?utf-8?B?NEpBaGc2Ujl4TlE1VjFVNDJ6V0RwREI0RUpGRlZFdzI0eDJ5cjFqNTVGeFFq?=
 =?utf-8?B?WksyUitIMk5uUnh6WEVIOE9UOU5MMnA2citySDZZNnpuYWhNbFhDV2tyQ25W?=
 =?utf-8?B?eUkvTW9ZSVNwOC9lanJjT1BnWFRiaWZiN3k2cjNmNDlRNHZYUDROZWkwM0JG?=
 =?utf-8?B?b0pyMEpMc1FGMUV2c29qQms2MjNjV0MreGpqN3NRSnlxWTFTWURkSHMwOEpM?=
 =?utf-8?B?bjJ3OWsrTmpPSDIrQURaZElHNGJEUys0Z3pQNENWRWZ6V1Q2MCtJTXorKzR0?=
 =?utf-8?B?YlpUQlFDV3lYVzNPdy8vand2cGc1Sm9YT2FjK0lMNGVrQ0MzdStoUW5lK3pD?=
 =?utf-8?B?SnRBZkh6VTEvMlVXa203dWpkcFJaUlZvZWsvdEJCWWRobVhZMGhXeFQzb1dD?=
 =?utf-8?B?YVBDZkZJRkdsT01RZkZteVgxMGRoSWorMTJabFdVZkxPUWozMGxRTUwzMXhL?=
 =?utf-8?B?N3l6UE5GKzBUTUxOY2psTDd6dDB3RHh4RlNIQ0JvUVdkb1RNbW4xbkRmcFMw?=
 =?utf-8?B?SWo0aGdmZU9qL0w3YjJCUVdQbW1uVm1TUFBUUW9BVm14MndFSnM2MzY2NkFx?=
 =?utf-8?B?cmdNdGlwamN4NFBJblp2NFRPVS94TmJiR3JSZ0RLVUxQY0cwK3FFTDdqaFBl?=
 =?utf-8?B?WFp0bmtobmFSTXlnM0phU0VTK3ovbmZrbkFCYk50Zm0zM3lrWklHNWJteCtI?=
 =?utf-8?B?emNoMXlRZEZPM3ZzY012dEVvTVUyL3hkcUtZcmowRE9BS3J5T1JIaysvZE81?=
 =?utf-8?B?TGt4RjR5ZHUyTUFWNHVXVHp4STMrdzRPRkVKZ09MSUdZdy9VeWx1cUdtL1pY?=
 =?utf-8?B?NkxuWlB2enFKeDBEK3RON2JXbEh0MDNIMUtRa1lkNXZKdnBCbEp1NDJJNGZl?=
 =?utf-8?B?VDlXcUltWmV2UDBWWXNzcVFPWUo3WXRBcGtMZk0yV2FIL2wybHVOOU1IV3Rh?=
 =?utf-8?B?dzhZZVNQZktNWjdIM3Vxc2QzMC9wL3lMeDBRaERidjZySU0zTTc2cGRJTkMy?=
 =?utf-8?B?RmJiSE9wMVNFZis3NXA3U2NhYjNpVlFVeDFkNlRzaGFWYnN2ellBdWh5SnFn?=
 =?utf-8?B?UGMyV3dHMUU1YWFRaWREUklRVDQ1OVROR0VsOXMybGZNQm4xZW5jVVlJUjJm?=
 =?utf-8?B?dTNJaklHUk1SdXFkT0VNRmRINm9Dcmx4NlFEWlBocUthaW80K3pOSDdYUWg0?=
 =?utf-8?Q?OhfK7h0ebZkM6uLfm1sdlhYs4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac63823b-885b-4f69-56cc-08dcf233896e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 00:50:34.4242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBrf5klOP9UaELAl0yBxDyFWOYzq1/LJv291FyQpsspSUuxjUPk2FRJnWjrBYQhNQ8QbtMU5drhQ2Nq0z/gufA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524

On 10/21/2024 5:22 PM, Rosen Penev wrote:
> 
> Tested on Cisco MX60W.
> 
> v2: fixed build errors. Also added extra commits to clean the driver up
> further.
> v3: Added tested message. Removed bad alloc_netdev_dummy commit.
> v4: removed modules changes from patchset. Added fix for if MAC not
> found.
> v5: added of_find_matching_node commit.
> v6: resend after net-next merge.
> v7: removed of_find_matching_node commit. Adjusted mutex_init patch.
> v8: removed patch removing custom init/exit. Needs more work.
> 
> Rosen Penev (5):
>    net: ibm: emac: use netif_receive_skb_list
>    net: ibm: emac: use devm_platform_ioremap_resource
>    net: ibm: emac: use platform_get_irq
>    net: ibm: emac: use devm for mutex_init
>    net: ibm: emac: generate random MAC if not found
> 
>   drivers/net/ethernet/ibm/emac/core.c | 42 +++++++++++++++-------------
>   1 file changed, 22 insertions(+), 20 deletions(-)
> 
> --
> 2.47.0
> 

These look reasonable - thanks.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

