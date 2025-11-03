Return-Path: <netdev+bounces-235068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08537C2BAAA
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 13:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89E1C4EDEDE
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 12:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1D730DD23;
	Mon,  3 Nov 2025 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yt+IrM+t"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BC230C347
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172436; cv=fail; b=Mb9qCwHj35026pq3CHIlnLhLrJBU7Os3tPHrTatrjQLeUDSalU0DKQ1QWEtcaJSUTJ2O6h6Vu/6LYWMEoVsiIjBhRVDwHryoJbmMMP2aVG51tUFy5RImXg5vOyes7J6inMDMSu5djfS/WSMwob9gLPSUHp7YR5DdGct7PEyrUdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172436; c=relaxed/simple;
	bh=TSL9cHGskynoPIwyz2/EY3SrOFkOEZDHKUE9AzbEfBU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KuViNtwAoCswk26QltQ7yor3pPQ5Ix+djs4MiVeR8yagW84E9OG4htVCt9jq5C7dUfyF0vcH/oovsoT0bMjs9Dofr6g4elUV74DE8Eo4Mqn41OYsSv+ei5ZUGETOjYXEuscUmwlFoJDONqpqWLs+uKJZN5j8HWpZtSBbYNZ3cf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yt+IrM+t; arc=fail smtp.client-ip=52.101.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIV+1o/mu3cukYGgqZxHd+dTvfigtw5PngVD8ZfjVG2AE9JT7KLYfDxoo/o5i4mjb9zeuiuJ96STz8nMFZEqlCOPWE6KmXo1ZG2pglMWRWeLx09N6tMXRbGkgGrFAGagI7GE7yMF77kOVKhLyHW3WtXWcnGsMyxXFyoWv+evlErhfujGU59bGY4cblRB2lrLUFO594YZNY/q+Jo/ShwK2el1tjTPN3QbppWHWmUE9NTp0W90eTYZtmOqy86zxCRhZe9c9lFIfDnYOdpzD/DsTwYxS5qxcAD1VoXYz4/T+NNpVV7PIGvvdrrO5bX+4Q4sfZcIOOu3Zlt+v4v9CFMliQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aAIJp9T+RM7JN8Cqd6UT6qEnREl0kiGQPKykBdOfbY=;
 b=KCGzL++feqbNTBFFjCMVfFco4ttOkAaGLtCGXiuLv2Cljr/4Bfx/YWNjF0GGt55IhkwUsj5Im4Atl9GcfUiatM7NUeJNwQ7PuCWBvHrjR6702U6Br+iDPDN414veBihA3FO5FxSXlNzTiTxhdo0PD6sINSPMgLUhe+ZNu4R/1k8ShlnSMN9WvTKUXSkbOH5d+v6v0zNwwZq2mvsmc7qFryPKBYPhgGGsTXuND6OVaXeF4by81Sbe4ZTAB4o7WYn/iBw3ivsImm0x6Drt6+BPnrd45JAwO7Kj1WjWzthWXDZW6n8NIxKB/Pl00xCEwUFVYJOH2uvb8NzLQYdoVmIqdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aAIJp9T+RM7JN8Cqd6UT6qEnREl0kiGQPKykBdOfbY=;
 b=Yt+IrM+twXie2hTXhzr/mSLNDwl/uxvZmtowyRsMIvUNdGirFoodDgacYZxshWh6sccw3ycoiz/kHH/vxkaXSdvfiO97pHHeHWYT8beF25aglAwgixlUV1JV8w+dUIpiDzwI1GEFLCKeNut5v5l4MKnuHus5LtM3rd0tR2pGMwWvQVkj/S1k0a5jfdldjgm3CbjMHfOE1f+TK9HkCZMW6TKWNokilHQmEbZdR5M3xKFUce7TDHKEo/2UUrp8CMt/3eRm+pqThTm7OZmDuwwh0GT4fFhA8vkL1nDdTD811NT5JeMtrAQNmZ7kYhsm26Tf/slbO7gxZkdZiltq3W4apg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 12:20:29 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 12:20:29 +0000
Message-ID: <66664116-edb8-48dc-ad72-d5223696dd19@nvidia.com>
Date: Mon, 3 Nov 2025 14:20:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: gro_cells: Use nested-BH locking for gro_cell
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com
References: <20251009094338.j1jyKfjR@linutronix.de>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251009094338.j1jyKfjR@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a82754-b364-48c3-9893-08de1ad3608c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2tpN3RXOGE4VVJ6RDBsakxtemlSZVRBUXZoSlFwQjdTM3pOR3JTMkdFOWhl?=
 =?utf-8?B?SGJ3Mm80dW10TWhrSEc4d3ZZK1VlSEZaVW5HQ3FJdi9zYWtDdzc1UGZBQW5Y?=
 =?utf-8?B?eGxxa3RsQXVPcW10WXlpbGpLREUwRlN4bzA0VHgyaHJCRG00YnlYckRhVFMx?=
 =?utf-8?B?YUFLWWlMaGtNOVFwNFQzSVNNUDBVM0JzZkcyY2lKN05la3pnanVyT3FZUXp2?=
 =?utf-8?B?eVc1b3FVV0k3Qk45NzZ3WlBUSFp2QitPZTJpUWM5UThYM0NaWGx2RWY0MjZ1?=
 =?utf-8?B?SmNLRUJodjNiN0IxdFBxbkJrYmJXeDVzbGxzQ3FTb2xHamR2S1pLTU4xYk9I?=
 =?utf-8?B?b3V0RDRNUjZPTU1Obm1nYXhpWEFDQnYxSVFTU2dWQWJYWk5tSjRhVXNoQm5J?=
 =?utf-8?B?RnhaUGY3OUVsNkpYOWtGanBEaUp6NGdSZzFRdzdYeUtvdEo0bXNLeWZLN0pP?=
 =?utf-8?B?Y3cxSDVUWFhxOVc3djJ1K1RSYjkycGFydXZRZlZsYjdPUEttVmRsTnNPbUNK?=
 =?utf-8?B?NXQ4a3VQbDdVVWFHOTdORGxwem0xbWJVaXczbk00RVJFQU1zSlRxREdkd2NU?=
 =?utf-8?B?a21lZ3lFOG8yQ3NiRm9FK0QrWFJxZTNhdEFSQVRVZFBOb1QxbXRQZmVrK0Mx?=
 =?utf-8?B?cWJaNGg5b0ZScEFXYmFEaHdaU1B5WmdiNGNZVFVJNk9aUEh5QkpkUThlUU1i?=
 =?utf-8?B?d0NPUHQ1ZWl6MTZsdmYzSTQxdGJyS0RSMGVpSE1wN01aekxKeEVkWS8wT09V?=
 =?utf-8?B?MEJpeW5nVGdPTUtydnZqVlpJSGQ5VlFjSXdHaisxbFVyTmIxZGRZejZDMTZ1?=
 =?utf-8?B?WjNuSkFkcWZWODdDMFdCN0g5NTQ0U2NSTnArZnRjQ0VmZnRvVHExV2ZzRFNB?=
 =?utf-8?B?K3NDNXRoQjRmTFI2V29ZVWwrR2ozVnpVWHhqQ2o5b1kyd2pLRnRqYXNaaE00?=
 =?utf-8?B?Z2NjSVdPN0hnYW91YTlkRUtER2s3Y2Vzc0lram10Y2VncGRXQ3hXMEt4ZFJ4?=
 =?utf-8?B?TVQrZmlKSlVsOC9OakxJRzVDZ3ZUbGFqc0UrS2llK0daZE9MWDlEQjI4eXhI?=
 =?utf-8?B?U1NEOGhqOGxPcE8zZW0vYVlldHRRRmJuN3VHRXpQZUpZSzFXcGE4Tkc5dW00?=
 =?utf-8?B?WTZrVEN0b3VRN0xzQmdTcFIwUHhwSFMwalZpY2Z1bW41bW9FTmRYS0RLb3ls?=
 =?utf-8?B?dDd2Ni9CZUlZcjQ2QnZkMHpLeDVRUksrejhsdU0yQTQ5alozaDJ2NGVyOXZx?=
 =?utf-8?B?QW41Wlg0Z2VhSzJlSWhEalBIcjY3ejNpMWJOcXY3dFhXbzlkT3Rzd0ROSXlO?=
 =?utf-8?B?dlhnQUhsV0tOcis4OXlVVXNjdGRwdXJXbVM0am5nVTFLNklyM0Q4UWRZb3lN?=
 =?utf-8?B?WGZRRkdzSkJ0cUx1S0VFUDd5U2xpbHM3a3NxYzFHUVBhSnc4TXprazVIUG9i?=
 =?utf-8?B?WVhMVWVKd3pyTjZZMlJITEx5KzdBcnFuZG5DSW5yamx4MnZTbTEwUTYyWmFp?=
 =?utf-8?B?MjJoYWVVVWltby9QWjQzV0xndGRnVWVLQUxTOFhDbWpPQkRWZUw1OWRBdjlN?=
 =?utf-8?B?Q2VLbmc5ZmdVdk9Zek43THBjVkRGd0lBeG5ydldaSXBzcS9MWWZQY2JZY0ln?=
 =?utf-8?B?UEk4ZUNSUGVRR21nVnR3VXE3M3lyOFJVYzVyWXljUmk4b3o1ZUFXQ2dtUGpR?=
 =?utf-8?B?akl0QklRdWZWcm1iSmxMS0RGL1NHZTNmaUEyZkgvYnJmcm10WitZRU1PV0cz?=
 =?utf-8?B?cUJ2eFJPK0g4cTRXTk1TNzdPM1hZdVhTREZsdXRLUE5Pby9KZmN6L0MvYnhv?=
 =?utf-8?B?aWVKK0VqM0R6V0daN2IwV3d0cGx1eFVlUGRUWEhWZDMxVjFOMWV3Yk5YMmF5?=
 =?utf-8?B?aG9NQzEzQ1N5MFVDWFNkY2VCbzl6ZG45U3NDMnhLejJVZFdnY3daSGJlU0hv?=
 =?utf-8?B?TkV1bHdISTltL3NHOWpZUWVLNkJsUTRmZUxRMXliWkpwejhwV1V5bEc2eGtU?=
 =?utf-8?B?YW1NaGN4TUFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDI1ZXJ0K0pGRUlXVzMrMWhkbkJjeFEyV0xkaXY4WjJlY1ZyMWxaS0pJZktU?=
 =?utf-8?B?S2VpYVBmYk1EN2lzd3RYbHNoUUYyd2N1d1BUUWpnd285ckxvQXp2NVZlbnBS?=
 =?utf-8?B?d1hldU5tNXNSVDRubWpPQ1AwVVlZc0FoWU1HYWl1OVhMUTNGbzliWGcydHcr?=
 =?utf-8?B?Rk9TVlVYWEVxREVNbUQ1ZWlxUkM0Sm40amdMZUMvMFpScTNSS3VPVnAycXBW?=
 =?utf-8?B?SExod0Jhelo3VzhjQndiaXEzcENEeldHOFBkNzVaZTExdkVhOG9MRHVDczl6?=
 =?utf-8?B?RlNCcEhpcXpDaWpyUmRqSktBdjIwbUEveDd5RVBhc25QMU1zb0VJMTIrYjZx?=
 =?utf-8?B?aUg2RVIzdDhEWE9ydzltNG5wd1VXSTlseGFqdzhQL2V1cG4zcFQ1SThQUDc5?=
 =?utf-8?B?VUdVZVgzNThMTm0rQWduQ1RsWTNJMm5hZEZ1bFhkR1dCWnErdWFlYVRzYVIy?=
 =?utf-8?B?eU9RWXIyT3dIMkU2R0Eya3kwb2xZUDNTczBjOVhlV1VnZEp4VFRtQ0t0TlZh?=
 =?utf-8?B?TEZRK0poY01XdUR2bmtGMXhVemlKNTdBR2pRd3Jvc3ZadjV0UzlydUNjbk1y?=
 =?utf-8?B?RDZiaHNPZitaWlJqbnlMYVk5d254b2FxVWcrSFF5WEM3RmdDRnZjSXdwNU5C?=
 =?utf-8?B?WitidTFnUDl3cXZIRGhCMmluQWQrbUJjT05JZDNjTHphb0xBZTVsYTRSSDZQ?=
 =?utf-8?B?Zm41djEyTkhGVW1Iak11ZGlDUXdaRTV0b3I2NkhLZUNwNWxadUN0U0ZhdEdD?=
 =?utf-8?B?NDlCVktRN25EYlo2aytscHJoNWJjQzVNY2ZBYUN2UXJSUm9IeVhocTZrbVRV?=
 =?utf-8?B?bHBVYzFBWkZWSHdCTUFMQ0kxeFk2VTdKZkJRSUE1aFFES2NZUjFhNmxOUVNP?=
 =?utf-8?B?dm5GL3BhSDlHMWlxM0laMmZFek9PMFV4YTdjTnhqaGlCUS84bXZ1bnRMZ1hQ?=
 =?utf-8?B?ZTVidXBxWUxmWXgva2pVekxEcHlNaVZZR2Y3OEVlM2pDSVZUMWx0Z09wQVBY?=
 =?utf-8?B?SmZRZmhzZ25USDI3anRRWTUxcDR4cmd6UE1nWWMyMjcxSFBxbFo1NXFYdHdI?=
 =?utf-8?B?SEhYVzYzakQxWC9nWUJIQlMzZnU5WmJsMDErYnBCQlJzZE56YUpnQTdZYXhO?=
 =?utf-8?B?ajVISkVqei9ZWjNZa3ZFNThzRVgzV2FVSTJ0U08zbGV6dDllTytBWEcyY3Z2?=
 =?utf-8?B?a2lGZ3p3RTNvTXhJdzY1MmtkdmNPU2tZSEs0UnpDNUlhOVFyT3lwTjZOR0sz?=
 =?utf-8?B?c1lxeWk0b1FPN2lLbmd2YjZVRUlWL25XRUJKeWYwdzA0WWRsYlZxUWhEbnNE?=
 =?utf-8?B?Yk9keEVZNWFVdEpFVnNtS09uV2hZNlFuelY1MDlJUnFMaUZLVEVwN0pZdTJF?=
 =?utf-8?B?cFZGVmZDblJwTUwwRGhHZGpabm4zMUxmTTZBUmxNamdvSE03ZWFRUXVXVE5F?=
 =?utf-8?B?ekI2WDJYK3I1K1hUd2JwYU01alF2S05mZktRUHhROGpTcFBqdTJwellnMllO?=
 =?utf-8?B?eFNYNVRXeXo0NENHNU1Ua2VsT2NPd0J6VFdNR2NoR3owYjMwQnU2cFR1VndF?=
 =?utf-8?B?SmFUU1A2by90ejZIaWhVMzdTa2VQeXBhak9TbzNRWkYzbGVjOCt6MWtJZytC?=
 =?utf-8?B?WVRUVnJmSzJFSXN6d0toV1pZbXBrUDlXR2hBWGxPcUVraSt0TDlGVzdWL0xr?=
 =?utf-8?B?Wkw5VU5VWW9RZVY1THdOL2JFTXpsZkZIaW1wUnRNTXJFaEFYMDVpMTZzWDJX?=
 =?utf-8?B?NXdaZld3N1cwYmN6em4xOEU1SnFTUnN4VGZ1NVJ1S2Z4ZytQUUtnQUNIVVZv?=
 =?utf-8?B?V3dpVTkrOGdrSjZST3RIYkRoVUJQQlNLRUttUE01bjlNd0p2WTBxd2dUbDcr?=
 =?utf-8?B?S1pKT3ZlbE5XRzdWL1JrZDN2WjJDN3czb1hjenNqeDNLM2FRZnpJcW1nVFJh?=
 =?utf-8?B?bzdnYloxRm5yY3BHbENRRXZGeXMrM2MvTm0zcC8xczNtcTdZbVJOS1M0V2x1?=
 =?utf-8?B?STJZLy9SV1JkN0RtNzNTekxmZDI4Y0cyV2tFcDl1TmpuZW5GUEtLSHRVNjE4?=
 =?utf-8?B?Mi9lUktQRXdGdnhNMVZmaktzbTdBL2RSMEVPbmE2Wk1reWlpaUNDQitRZmNI?=
 =?utf-8?Q?kxYY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a82754-b364-48c3-9893-08de1ad3608c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:20:29.6218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuY7hsZ+laQTsSZ7pc9eLGsdEmm3n8rKQTIzIGT1xmDO64C9Q77P0mby2RimnqA+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243

On 09/10/2025 12:43, Sebastian Andrzej Siewior wrote:
> The gro_cell data structure is per-CPU variable and relies on disabled
> BH for its locking. Without per-CPU locking in local_bh_disable() on
> PREEMPT_RT this data structure requires explicit locking.
> 
> Add a local_lock_t to the data structure and use
> local_lock_nested_bh() for locking. This change adds only lockdep
> coverage and does not alter the functional behaviour for !PREEMPT_RT.
> 
> Reported-by: syzbot+8715dd783e9b0bef43b1@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68c6c3b1.050a0220.2ff435.0382.GAE@google.com/
> Fixes: 3253cb49cbad ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Hello Sebastian,

This patch results in the following lockdep warning [1] when running
IPsec + vxlan tests, can you please take a look?

If needed, you can see the test here [2], though it might be a bit
outdated.

FWIW, Eric's patch [3] did not solve this issue.

[1]

 [ 6953.101639] ============================================
 [ 6953.103703] WARNING: possible recursive locking detected
 [ 6953.105293] 6.18.0-rc3_for_upstream_debug_2025_10_30_15_01 #1 Not tainted
 [ 6953.107235] --------------------------------------------
 [ 6953.108814] swapper/0/0 is trying to acquire lock:
 [ 6953.109926] ffffe8ffff8234b0 (&cell->bh_lock){+.-.}-{3:3}, at: gro_cells_receive+0x3a2/0x8e0
 [ 6953.110756] 
 [ 6953.110756] but task is already holding lock:
 [ 6953.111377] ffff8884d3a52700 (&cell->bh_lock){+.-.}-{3:3}, at: gro_cell_poll+0x86/0x560
 [ 6953.112163] 
 [ 6953.112163] other info that might help us debug this:
 [ 6953.112831]  Possible unsafe locking scenario:
 [ 6953.112831] 
 [ 6953.113460]        CPU0
 [ 6953.113768]        ----
 [ 6953.114075]   lock(&cell->bh_lock);
 [ 6953.114468]   lock(&cell->bh_lock);
 [ 6953.114854] 
 [ 6953.114854]  *** DEADLOCK ***
 [ 6953.114854] 
 [ 6953.115529]  May be due to missing lock nesting notation
 [ 6953.115529] 
 [ 6953.116233] 5 locks held by swapper/0/0:
 [ 6953.116652]  #0: ffff8884d3a52700 (&cell->bh_lock){+.-.}-{3:3}, at: gro_cell_poll+0x86/0x560
 [ 6953.117606]  #1: ffffffff8506b9a0 (rcu_read_lock){....}-{1:3}, at: netif_receive_skb_list_internal+0x309/0xfa0
 [ 6953.119051]  #2: ffffffff8506b9a0 (rcu_read_lock){....}-{1:3}, at: ip_local_deliver_finish+0x2dc/0x5e0
 [ 6953.120345]  #3: ffffffff8506b9a0 (rcu_read_lock){....}-{1:3}, at: vxlan_rcv+0xa94/0x4180 [vxlan]
 [ 6953.121737]  #4: ffffffff8506b9a0 (rcu_read_lock){....}-{1:3}, at: gro_cells_receive+0x4a/0x8e0
 [ 6953.123062] 
 [ 6953.123062] stack backtrace:
 [ 6953.123603] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.18.0-rc3_for_upstream_debug_2025_10_30_15_01 #1 NONE 
 [ 6953.123609] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 [ 6953.123614] Call Trace:
 [ 6953.123619]  <IRQ>
 [ 6953.123621]  dump_stack_lvl+0x69/0xa0
 [ 6953.123628]  print_deadlock_bug.cold+0xbd/0xca
 [ 6953.123633]  __lock_acquire+0x168b/0x2f60
 [ 6953.123640]  lock_acquire+0x10e/0x300
 [ 6953.123643]  ? gro_cells_receive+0x3a2/0x8e0
 [ 6953.123647]  ? lock_acquire+0x10e/0x300
 [ 6953.123651]  ? vxlan_rcv+0xa94/0x4180 [vxlan]
 [ 6953.123663]  gro_cells_receive+0x3ab/0x8e0
 [ 6953.123667]  ? gro_cells_receive+0x3a2/0x8e0
 [ 6953.123671]  vxlan_rcv+0xbb7/0x4180 [vxlan]
 [ 6953.123683]  ? encap_bypass_if_local+0x1e0/0x1e0 [vxlan]
 [ 6953.123692]  ? nf_conntrack_double_lock+0xc3/0xd0
 [ 6953.123698]  ? udp_queue_rcv_one_skb+0xa41/0x1420
 [ 6953.123702]  udp_queue_rcv_one_skb+0xa41/0x1420
 [ 6953.123706]  ? __udp_enqueue_schedule_skb+0x1160/0x1160
 [ 6953.123711]  udp_unicast_rcv_skb+0x106/0x330
 [ 6953.123714]  __udp4_lib_rcv+0xe55/0x3160
 [ 6953.123720]  ? udp_sk_rx_dst_set+0x70/0x70
 [ 6953.123723]  ? lock_acquire+0x10e/0x300
 [ 6953.123727]  ip_protocol_deliver_rcu+0x7e/0x330
 [ 6953.123732]  ip_local_deliver_finish+0x39d/0x5e0
 [ 6953.123736]  ip_local_deliver+0x156/0x1a0
 [ 6953.123740]  ip_sublist_rcv_finish+0x8f/0x260
 [ 6953.123744]  ip_list_rcv_finish+0x45f/0x6a0
 [ 6953.123749]  ? ip_rcv_finish+0x250/0x250
 [ 6953.123752]  ? ip_rcv_finish_core+0x1fb0/0x1fb0
 [ 6953.123756]  ? ip_rcv_core+0x5d8/0xcc0
 [ 6953.123760]  ip_list_rcv+0x2dc/0x3f0
 [ 6953.123765]  ? ip_rcv+0xa0/0xa0
 [ 6953.123768]  ? __lock_acquire+0x834/0x2f60
 [ 6953.123772]  __netif_receive_skb_list_core+0x479/0x880
 [ 6953.123777]  ? __netif_receive_skb_core.constprop.0+0x42a0/0x42a0
 [ 6953.123780]  ? lock_acquire+0x10e/0x300
 [ 6953.123784]  netif_receive_skb_list_internal+0x671/0xfa0
 [ 6953.123788]  ? inet_gro_receive+0x737/0xdb0
 [ 6953.123791]  ? process_backlog+0x1310/0x1310
 [ 6953.123794]  ? find_held_lock+0x2b/0x80
 [ 6953.123796]  ? dev_gro_receive+0x11ad/0x3320
 [ 6953.123799]  ? dev_gro_receive+0x11ad/0x3320
 [ 6953.123802]  ? dev_gro_receive+0x21c/0x3320
 [ 6953.123806]  napi_complete_done+0x1a3/0x7b0
 [ 6953.123809]  ? netif_receive_skb_list+0x380/0x380
 [ 6953.123813]  gro_cell_poll+0x23a/0x560
 [ 6953.123818]  __napi_poll.constprop.0+0x9d/0x4e0
 [ 6953.123821]  net_rx_action+0x489/0xdf0
 [ 6953.123826]  ? __napi_poll.constprop.0+0x4e0/0x4e0
 [ 6953.123828]  ? do_raw_spin_trylock+0x150/0x180
 [ 6953.123832]  ? do_raw_spin_lock+0x129/0x260
 [ 6953.123835]  ? __rwlock_init+0x150/0x150
 [ 6953.123840]  handle_softirqs+0x192/0x810
 [ 6953.123846]  irq_exit_rcu+0x106/0x190
 [ 6953.123849]  common_interrupt+0x90/0xb0
 [ 6953.123855]  </IRQ>
 [ 6953.123856]  <TASK>
 [ 6953.123858]  asm_common_interrupt+0x22/0x40
 [ 6953.123861] RIP: 0010:pv_native_safe_halt+0x13/0x20
 [ 6953.123867] Code: 33 00 00 00 48 2b 05 b4 aa 94 00 c3 cc cc cc cc cc cc cc cc cc cc cc 8b 05 ea 5a 74 02 85 c0 7e 07 0f 00 2d df bf 0e 00 fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 41 54 55 53 48 89 fb 48 83
 [ 6953.123870] RSP: 0018:ffffffff84e07e08 EFLAGS: 00000246
 [ 6953.123874] RAX: 0000000000000000 RBX: ffffffff84e2f540 RCX: ffffffff83d92d2c
 [ 6953.123876] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff817cf030
 [ 6953.123878] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffed109a7484fa
 [ 6953.123880] R10: ffff8884d3a427d3 R11: 0000000000000000 R12: fffffbfff09c5ea8
 [ 6953.123882] R13: ffffffff85a954a0 R14: 1ffffffff09c0fc7 R15: 0000000000000000
 [ 6953.123885]  ? ct_kernel_exit.constprop.0+0xac/0xd0
 [ 6953.123889]  ? do_idle+0x300/0x3d0
 [ 6953.123894]  default_idle+0x5/0x10
 [ 6953.123897]  default_idle_call+0x66/0xa0
 [ 6953.123899]  do_idle+0x300/0x3d0
 [ 6953.123903]  ? arch_cpu_idle_exit+0x30/0x30
 [ 6953.123906]  ? __schedule+0xdcc/0x3180
 [ 6953.123910]  ? do_idle+0x18/0x3d0
 [ 6953.123913]  cpu_startup_entry+0x50/0x60
 [ 6953.123917]  rest_init+0x20a/0x210
 [ 6953.123920]  start_kernel+0x3aa/0x3b0
 [ 6953.123924]  x86_64_start_reservations+0x20/0x20
 [ 6953.123928]  x86_64_start_kernel+0x11d/0x120
 [ 6953.123932]  common_startup_64+0x129/0x138
 [ 6953.123939]  </TASK>

[2] https://github.com/Mellanox/ovs-tests/blob/master/ipsec-tests/test-ipsec-crypto-vxlan.sh
[3] https://lore.kernel.org/netdev/20251020161114.1891141-1-edumazet@google.com/

