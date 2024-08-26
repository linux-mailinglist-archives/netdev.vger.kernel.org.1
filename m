Return-Path: <netdev+bounces-121928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3C595F546
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C13282363
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 15:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DA21922C1;
	Mon, 26 Aug 2024 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LErssb8F"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AC23C17;
	Mon, 26 Aug 2024 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686747; cv=fail; b=DsnQToqJ6tNGakfLGsCSnv9Q9lwnt0u8Rcqnv/w2vOa2fvkDkSAj03sq8WQrEGjCoGyG7KURUr+SyH1TG/zKcjp2e1tWQBiAy2TYiFqaNDL7MNoJO3wjommkvv34A818/fAiEEN5n2u3kSJQQPerv4keZOjHOFNg9JsMFp04x24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686747; c=relaxed/simple;
	bh=6vgl9bzWTyiC/dS92AGqBJtSJo8KNnS3Hi87Itjn5e8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Imj82T4cDTOI44XOvc59brTzfRVpXOgrH1KgeDm6XkPgI4t688i0yZYV9MSzby/DGqZFvKJDe4CLTq88UNbicFGKXUyrRPZ7WE+MDsk3ih5ABsZnskeTh7niK9YmRNcBwdM9LdhyZgGo+c9y4NP9WnHx5BLibKOKDnybd2gMsp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LErssb8F; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P22TtQA8ZcgzByM2bR9K0Ear074EYfLc7D0YHa1wLeOQoVTpc/IxTUZEOCkimioPf47uSWB5eXiZLc1svOZQEz0iQzqH9t+uC43AuRg3P3lJm2rHlB5+nOuPxjtejNAutf4a8cITLOORvBYZtxZpRPfpgSfLMwIysw5Qc9aaNXhrFMH/rrM25Aa/JAHA7qr4u9vgSxJd107VqdlNQUT9k7lgz+oAM4qCqdsyemq8juiseCFI1YrVlMKGcP0Mon4iXvZZb8sHY9Gf2Ru6mxF5MJh75rCXDEBp5E3kgVKcBTQmyQr0IWcGuY6kTR+Dv2MiNKn6+NyXqR7IYbbpQllLYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+yN4cq+qW46MM9FEsJHe+v3hbiw15PItkHzbzr22sU=;
 b=UU0+a+43C2ZcP5ggmA9qHgRxNWb4GeQXkL69hwLsKhQcNYfFgHvFYuYjiosi50oEusKrU/KqTz4DSIgrKnCx2hMjmbqlbyKrwy3lQaFKBIOHk0C7g5B3cBgRz+1e+iZEUPXbbSjt7r83GsdhSNT0Tp/qlNseNvIyxhYpSnWerUTJwlWcZ0zYFYGDQpcVyiTSJYS5L67wPTn5Ai8hZ0aQzM8xhEmPSlcZVJWpegTuRsyKbttyZsno8NBMbHUXFz/7NO/eIzGcglHTYaiVUcAsDjVkp94orRJ/2SZR9kqIIYvXdKxpiZhQleQ8xu+oYKm7F6NmAkyvvrUGXggfxuHVBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+yN4cq+qW46MM9FEsJHe+v3hbiw15PItkHzbzr22sU=;
 b=LErssb8FFZAWF5T27vqxKKQlSpTaDCqFv/CQV9hAVUC7zVwBJGxGfQT3XUAeUzAT8Qe6SzEROxq67GwmMzPSmj5Y6Wj83JIfRPLaCKGVk5VmACRvJGqu1riV65kqnFW6p5JozBzqto0UETvHgwbOsAYRtdGHWavbLWBdbUtheVQ8JHE+AzI7b/iZ4O5wtXasCJN1ui2P9WDCtvY5PVhKLumdlNF+D2++c7syPSsnw7ExpApsg0+2x68VEeQNfwglcxkF0OfUr9lR66uXLTSDr99DyypwOlI0j1/hvgOEcNt9oduXibDTvt73rtitt1pmZKCXZSc+TtuVf808JhG+wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 15:39:00 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 15:39:00 +0000
Message-ID: <6545868d-464e-4b87-b0cf-28f34d77b694@nvidia.com>
Date: Mon, 26 Aug 2024 18:38:50 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/6] netdev_features: remove unused
 __UNUSED_NETIF_F_1
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240821150700.1760518-1-aleksander.lobakin@intel.com>
 <20240821150700.1760518-3-aleksander.lobakin@intel.com>
 <CANn89iL+VTJ6tEe-PZ24h+0U9BYs0t4gZDndiy7j1DwuKMBEFg@mail.gmail.com>
 <a1b025a9-4fa0-42d8-9ad7-5a3888574b3f@nvidia.com>
 <20240826080900.57210004@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240826080900.57210004@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF0000452F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::358) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|MN2PR12MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe7da2e-fb98-42ee-fe6e-08dcc5e53484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Kzk5OUtsRlpmVEpVSUdhdjZXVHA0TXh5VzNLclZpRCtUUGVPbEVSOUFoSnlp?=
 =?utf-8?B?Yld2cHU1Y2ZhNTBNOCtrUjdETW9DQ21XZXB4TFFzRE1ITGRkc0E5dHpuZVRl?=
 =?utf-8?B?bkZleWhJa0Q3Q0RnME1YNGMxMS8vNENBN3oyTGpiWkVnYXhRWkkyTDZrTk94?=
 =?utf-8?B?RmNzNGsybG9GNFUxL2h5UlRLUGxJb3JTd2tLRGFYQTJKQ0tZVlJRN0hrVWRp?=
 =?utf-8?B?ZWRDM1NTay9PVHkwVGZ4TXJmdjJSUmJJeTV1cE5yeEd4SUFkd0MvbWFSQVdU?=
 =?utf-8?B?bE1zZCt3L09JeXBXVnZLWEtuY3QvOXFQeDR1am1WalBiQW16OXk5SFZJbHhu?=
 =?utf-8?B?R2V3MWU2c2Q5OGd2TlBjWmMwNnNrWHpmOEVhdGJRbVFaOElDVWQ3S2RXS3pZ?=
 =?utf-8?B?c2MwMkxGVHBqaVh5bklTWkp1QlN6ZUhDSSt5a1J1d2kvTHNIOEFSSHdnNitN?=
 =?utf-8?B?TWR3WTczUngrWDhYb3FhdnFUSGIxMGFMOHR6RTNiWVRtWGJoRUVXYnhYVW1O?=
 =?utf-8?B?TS9SUGFWZGlxWGhpR3VINTMrbTBVV0JqN0ZlZ2pFYm9nVnlBVXVQNkljVm1p?=
 =?utf-8?B?SGE0SnhkTnVPRllwTXdQY3kyS2ZONkwvUXVqd2FUanVyelA1aS9JZ1FzR0RJ?=
 =?utf-8?B?ZkZYeEVzZG9tYk5RakYxc3lUUENKQ3JPam9GOU13U3V2a1kwOXFqanZRbGlV?=
 =?utf-8?B?VmpIdkhoZTkyMGpuVjZEWFpPd2JqMGJwWUpxMC9WQ0hwTmJ1d21uTzBCR1Aw?=
 =?utf-8?B?SWdPNk84VTlCSzhxSllxc0pBY28rK2lseFNRck5keFRScm8xeCttMFcwWFZN?=
 =?utf-8?B?dnd6bllEdGV1WkZJNzMzejkvdHZkNzJveFBpME5GbUd6cVlwWmlzb3ZqUkRJ?=
 =?utf-8?B?N0RnMzVnN1l5VE5ibXlBbjFlVGRRTjF2MTFOZkYwRzFZVG14b253U2hZMVAw?=
 =?utf-8?B?cVFoNkZacEdlQzJRc1cyM0FRY3o1QndHL1VPaWJtN2YxZEJUK1ZQM2s1Tzg3?=
 =?utf-8?B?bHNiMzkwb2lpMGg5OFg1bERSa2RqVnVHQVZHSi90MkhFaUV4MUZzcFhQc0pM?=
 =?utf-8?B?Rk1WcEJqK2tMREVvVlZQVUZSTi9jZjNKOEw3M21YdzMrTnUrMmRTU1E1YWgy?=
 =?utf-8?B?UC9LMGlQNERTdVdJQVRQOGljeXpEdkxmby9yN3Ztb1licW5FSUJJZGtuRlY5?=
 =?utf-8?B?WTRaeFRWcFVVVWRpbFY1cnZQYzhiaUtpcDZrM2VnRzJJTWI5dGhVWm1xbGN3?=
 =?utf-8?B?YzZTRUxaVUdIQ1NFd0x5QVJYZlpqR2hDQm4zcmUyL0xHOXVodzVkM2VXUnl4?=
 =?utf-8?B?REVBSE5ZNzB4QVIySVVxWUdQd3FWZzM4NkdMVWduYTBDckdkV2NPSFV3TzVG?=
 =?utf-8?B?a3BER29kR2ZYMm5sSzcvRk9pdkF0akFFbWo0L2VVckltMkhxWUpHN1R2Mitq?=
 =?utf-8?B?R1BTVlh6Y1BsTWhJbHM5czdwb1hhb1Q0SlZhakNvd2lMdzh2S3VORzBUVzJ3?=
 =?utf-8?B?bGp0Qms4R2ZzaVV2NzRrNWhHcy8wUXdDV1F3bVVyVWxuSkw2ak9EemlTZ2FV?=
 =?utf-8?B?clh4V0l3akhzREF1bXNtbDhWdEZqUEdHR2tmM1NwYXFNU2tVMzdJaWpZZXdj?=
 =?utf-8?B?SnJEUjBjNldUVGpNRWJFTlNNaFl3MFdnalNSYTdMSmxuRHJkTTJ2VEhRdVRz?=
 =?utf-8?B?S3BSOVFUS1VzNlRkNVptM1pPSkM0V0N4R0RIM0YxbHp5NnRpa0RmZUp1MU5t?=
 =?utf-8?B?Y1ZQMk9XYTJmc1ltLzBMNHRVNTBzZFFIM1FoRGFURTFCeFBiSVpCWldIb3M4?=
 =?utf-8?B?NGdyaFEwNDVtM2pYbXJVQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SExhZUJpSDQ2VHBNT2Z1N1U3cGJ6blkvay9BdnJ5T2tPT01CS3pwcVEvU0Y1?=
 =?utf-8?B?S3MrZit1dnpRbmFqVUxVMHd5czVxdHpydDU2RmZqeXRRVmNHNlhRNzB4UGFu?=
 =?utf-8?B?MFNrZXBkckpsNGliWWhXQ3VGMHlQa0xNZERYMzVHL0oyak1aTmdOU2JqRGRS?=
 =?utf-8?B?amk5dkFPTjU1Z1VUUTZkOUFvOHdQbzhEWWlsNjlLbmgxYktGL1prTkVTbnY3?=
 =?utf-8?B?RG1uOFg4ZThydHdZZG5McWpJNG5HNC81eFN2UU5yOWhCcEszNktiVDBrRXF1?=
 =?utf-8?B?ZzIzQzJvL3JrZGJCbVlWT1MyV3k0UjE2UU9mWTdyUUM4U2RPUGg5cjd2SkNI?=
 =?utf-8?B?UTBLSkhKUHdOSE0rcS9STytLcEYwKy9wRUsvRW1oRG9wK2ZzT2lwemgydnRD?=
 =?utf-8?B?eDVyZmdFWDV0STAvRUxGb3Z3SmNiQ1J2VklMU1UvSnJ5bEV5azNVaUhqSlVj?=
 =?utf-8?B?T1hSTVU2amNidFVtM0VkRVNRUWo1QjBKTDZzbnduWGdiMzZ4bWpKWEtldkhB?=
 =?utf-8?B?K09TYXNydFZvL3hQcmpEU0VodlZ0cHdBSTAzcGZ3TEptM0FwR1RJRFJpc2Ni?=
 =?utf-8?B?UmhWelJiYmYxUU5Wc0w0T3VoRlZrd3RHS2wzRURmY0Q4Q2xzclhDUHdyaEhx?=
 =?utf-8?B?djEwajVSMkhtTTVHL0ZjMlJhQTYrQjVzdjdGalZ2M1JLMmxjdmM4T0VEN3hN?=
 =?utf-8?B?YUZaY1YxZm5DK3psTC9TWG5hK2xlQjZIdjYxVkk4S045M25QMWxlVm5MSk40?=
 =?utf-8?B?OHVMOVdweFRmcVd3bHVQb0hWL1lPcnZHM3NrYnl5blpNQzFsRzZmaVRFRGJV?=
 =?utf-8?B?Ny81aGkyVnNhS001S0p2Z0txaDJLY2xrMm41R00rQUV6eThCZ1VDajcyd0gw?=
 =?utf-8?B?OVJwMnMyYjVpN2ZjMnVHblllcmhhS2h0STFmdEhIQnM0akJHWUZNWHJoWXlP?=
 =?utf-8?B?VURxM1RQZFBDSVFrTnNEOEcyTlQvNEJJVWVrVEZsU1RmZGlSVjlNTjFITEVu?=
 =?utf-8?B?UzVLZGxsVTF6OWhNMGkvSG84NWplMTdaODdQOGpQeGozSStLVE51dmlEeWMx?=
 =?utf-8?B?a1BjMENaNDYrU1NzWnRGQmt6UnM5a212NkZtSzBzVm1JUklvL0U0Q3p0VVNG?=
 =?utf-8?B?dzkwdkRIdTZaZEJJUm9GYU5jQlpOZDBjendLTWU1WTdrM2xMTlM3c1l2RkpP?=
 =?utf-8?B?S2IzaWh0M3BseStJOE8yR3VweVd5M2g1VVNNN2RPRGxMS2NXT1Qrd0dlc2cz?=
 =?utf-8?B?bW9pNUxlWmIzMFpmTE5hZXFQVHBMOVplbWRnVUJSMkxwQmlORlMzN1ZUdG81?=
 =?utf-8?B?alJaZHhXam9DeUc5c2lndno2TFRYKzJMT1hIUGN0VlFLWGNtWWNkNE1GZkZJ?=
 =?utf-8?B?Q2M2dytYNDBxNDNMVWVlaDBqOFZOL2FNU0RxUDcxQlJEMitDcDRYUmM1elp0?=
 =?utf-8?B?cVdaSHJsQ3dSSHB4bGZRcjlETzluVGFVM214a2R2Vlg1T1FIK2wwc3hjK2tH?=
 =?utf-8?B?YkErUlRJQkorQWhCd3Q3RHhKOUZvSHBiTTY3V0Y0MkJJZFN1a1kxWDR4cFBz?=
 =?utf-8?B?TWxRekdyMnV0VVg5OWczVzM0NTcvWHVDUVVRcG5PZjFBcEZFOFJhRmlYNXhi?=
 =?utf-8?B?VXl3UmcwU3NmRkt6QXdOTHZmMlRZQm5EbDBYMGsrSDF6RElsOFdaeWlJZ3ZU?=
 =?utf-8?B?UUM3bEhuT05FbkZ0MkU4a3ZoRWxYTlI3bW91VHJJcm0xR0JkUUY0clZEVlpK?=
 =?utf-8?B?TlFEMk5DdTNKRGNsL3FoRlBtQ2lEVy9KL2lWQlovNzBJcXdhcVRtT1BjbUo2?=
 =?utf-8?B?UFpkV1laaFlteGg0SGRLdXdnTWZxR2wvbkdDMW5iSlFhRk91ZHppbVgxSExH?=
 =?utf-8?B?VWRMZmRIWmpCMnhBZGtVcWJiOGhiM01wbnpyL3AzcGpOeTZValBuM2xRYkF1?=
 =?utf-8?B?REtNTFRiWWVxUmEvM0xkbS9KWTlyaXFJSHBONlNHT3VOYVBoQ3RrTXp5VEtH?=
 =?utf-8?B?R3JrbUpPQmxVeUJqc0pjcXB1bGF1T01lNDVJU2Njc2hKeGJUd200cm5aTGFP?=
 =?utf-8?B?OWRNT2U1d1Y1MGx0eDVmbU0zQm5qOEJtWU1icEs0MXJtWW91RVo5QVBsREtT?=
 =?utf-8?Q?m+QqpmnFRfAWS0EVkjzghAN/h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe7da2e-fb98-42ee-fe6e-08dcc5e53484
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 15:39:00.2110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzAdwYSn08PQ4q0VqqWyiQiqEiKs9uZOi6TdGurdrb0Np97uUENmNtf7SEySzeUS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109

On 26/08/2024 18:09, Jakub Kicinski wrote:
> On Sun, 25 Aug 2024 11:19:49 +0300 Gal Pressman wrote:
>> On 21/08/2024 18:43, Eric Dumazet wrote:
>>> On Wed, Aug 21, 2024 at 5:07 PM Alexander Lobakin
>>> <aleksander.lobakin@intel.com> wrote:  
>>>>
>>>> NETIF_F_NO_CSUM was removed in 3.2-rc2 by commit 34324dc2bf27
>>>> ("net: remove NETIF_F_NO_CSUM feature bit") and became
>>>> __UNUSED_NETIF_F_1. It's not used anywhere in the code.
>>>> Remove this bit waste.
>>>>
>>>> It wasn't needed to rename the flag instead of removing it as
>>>> netdev features are not uAPI/ABI. Ethtool passes their names
>>>> and values separately with no fixed positions and the userspace
>>>> Ethtool code doesn't have any hardcoded feature names/bits, so
>>>> that new Ethtool will work on older kernels and vice versa.  
>>>
>>> This is only true for recent enough ethtool (>= 3.4)
>>>
>>> You might refine the changelog to not claim this "was not needed".
>>>
>>> Back in 2011 (and linux-2.6.39) , this was needed for sure.
>>>
>>> I am not sure we have a documented requirement about ethtool versions.
>>>   
>>
>> This is a nice history lesson, so before the features infrastructure the
>> feature bits were considered as "ABI"?
>>
>> I couldn't find a point in time where they were actually defined in the
>> uapi files?
> 
> Keep in mind that include/uapi was introduced around v3.7, before 
> that IIUC everything under include/linux that wasn't protected by
> ifdef __KERNEL__ was uAPI. So all of include/linux/netdev_features.h

TIL, thanks!

