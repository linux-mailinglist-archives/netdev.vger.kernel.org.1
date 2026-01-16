Return-Path: <netdev+bounces-250540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9454D32496
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 15:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB5F2301EFD4
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9501028C864;
	Fri, 16 Jan 2026 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MHOwWPAd"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013035.outbound.protection.outlook.com [52.101.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9622773E3;
	Fri, 16 Jan 2026 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768572167; cv=fail; b=nAquwyEiP7GrFXWxtBl5HV230haYpDfkOSIaFi7qkWcb/+F3wtBG67ukcjiz/gZgJFqRcg2kiokCA6h7GFqtA1Yn1B9VnrW4JkMPclskkGJKYl9Lqu7mVMN56SXuCBd3ZPSlezDcGz0s8nIn4M6Cckf2AzUWa26emBxDZ1zTZoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768572167; c=relaxed/simple;
	bh=iTnOVtdPMoKmq3KLcWnJWxMSHZR2p3XRtcjQWaAUxpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QVEW1bEdjeB3PKGP/7xgEsmEcc/+0x0g+vha0cS3oqTbJe1N0Bt6/XmWgaITFDkbWFGrcBgM7ZkLJ1HnFUJWX8DMSCZKedDdYkjHFu5H6eDtBbxzVE77ddFbFFMaaek0NeX/8axETgPktDItaE9IGqRfrEOXhtCNUjunZOainNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MHOwWPAd; arc=fail smtp.client-ip=52.101.72.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Br+R2Hh0EFVoLtKqFXCeIt73l0WslbkSHlgUr19hEqL5S33g/oHL+snIi78f2AzDE14V/iY6ffuaw6aOvyfUAFtyzwoHIYo1PiXu8xUPf2jw19bkvMF9HplxQhSc/bMlbvf1jp0FaS+ypRlLX0gu+74Gc/pawij7jIqsFDFhSzTPIK0WMqfVdCQAcQnQBonzQonCbSEBJUq5FzEhXx7+ShRw9qgiNHMX4XXJUt4PJzlSzw8hmaonX5gfGAt9ihIgsRqE5rZGIC0Nls68JzkcRP9wYK8DNyQAR1dLJfMkzArwTOYWOFPGS8pT7fMFmS2yVyPbOT9KV4Mben37qvSlzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GT7p07d9uhNxPEBl/RPUTAa9O/6vV7BGI8TGdsGDwGs=;
 b=WjanZAO5eoeBwsmMGNKCHoxaKsXagsOgD2dRL7pWCA/1Nfn/wheXVociB98q3lmNyn2U+htR2L5x5b14a68Wd7tfUl23MOGrO6UtMU3mjhxgem5K5htRFUdsfpluKmbnJQOzyTkQQEPbg11kV0me7qb+II7IynEvBbeIIGyrWNNxOMvL0pdvlYnnZy9rhtUsYWdO0n0L3saQet/XfmRHYAMEDVpfxDB2u1i6N0Ngg2zTGzEkbIRCpKHDPQUn1K+h0H1LXuPYpcD9sSihNerQN7lH8PFonnfDwE7BVnj2z4SP1OS3QBUUNJxZdIisWRWSEiWt7FoMQp5HXkWXAg4UwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT7p07d9uhNxPEBl/RPUTAa9O/6vV7BGI8TGdsGDwGs=;
 b=MHOwWPAdJtEZ27ho83iAkkBlEVXKNuNReacZmQy+kzeaeY3rMrrp8DDv1fAxRFftQCBe8tJsotCzOe4MQ73iPhmr8QHbpMWPVuMw/YBBAO3xbbRpdjgRV0oYfYOYdYXUo0HcY4EfeYiVQJq2RQLQscfiE1TzbrQaNoZEbAlULlfUFA6FDn8AI8YEARI+ZAg6Wel72RHwI2VF+DIKrA04VdiJBStRMjj1Te1ltJJ5eDFMqHg3sooOXSZTcDFrScakrEsRiN99f5Pt+92IoMOr0pTWFioe5oZpQmtrIGdNdFkNrRM2b/m6ICjJzSzP7mvOkIrFnNYgQxkZlSAMzHmRBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB9PR04MB8432.eurprd04.prod.outlook.com (2603:10a6:10:243::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 14:02:41 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.003; Fri, 16 Jan 2026
 14:02:40 +0000
Date: Fri, 16 Jan 2026 16:02:37 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/15] mfd: core: add ability for cells to probe
 on a custom parent OF node
Message-ID: <20260116140237.kfkegpkubzn7l63g@skbuf>
References: <20251216091831.GG9275@google.com>
 <20251216162447.erl5cuxlj7yd3ktv@skbuf>
 <20260109103105.GE1118061@google.com>
 <20260109121432.lu2o22iijd4i57qq@skbuf>
 <20260115161407.GI2842980@google.com>
 <20260115161407.GI2842980@google.com>
 <20260115185759.femufww2b6ar27lz@skbuf>
 <20260116084021.GA374466@google.com>
 <20260116113847.wsxdmunt3dovb7k6@skbuf>
 <20260116132345.GA882947@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260116132345.GA882947@google.com>
X-ClientProxiedBy: VI1PR09CA0129.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::13) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB9PR04MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: e5aa26c7-f5f5-48c4-1d15-08de5507e997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkJ0OXFoUXZJZUt5ZWdUK0w3REo5cW85WnBnRU1FKzNCTmlTbDQ2U1Z6YWRC?=
 =?utf-8?B?cnNVRExZTXlHVjJWWmcrQUoxWkJmcFd5aXhRVkxhSndzUC94NFhYZDl6VnlS?=
 =?utf-8?B?c0s0R01Jd0N4azZEcVhmUkxOcEJRT00vZ3NkME14anR2N3ZPdGtUazU1YlNh?=
 =?utf-8?B?QTg3OTFmWnRnaUozUklLV1VUMmNNZVIwQitiUVlXUC9naWNFZkpsQUhUTVQy?=
 =?utf-8?B?amp1TmdZaEhFOXYzNytrNmdhbVFqdlRwVmwyeUZtMUp1V1R2MXloMnRnVUF6?=
 =?utf-8?B?NVNnZkc3MmlQeUVaZUFCbUtLbDBuVjFoZytsS3hzWFBiSjRyaUt4SjVibTNS?=
 =?utf-8?B?Q2MrZEMzV2wzenJHODRaQzduN3czRDVNVG9PRXd3UFhYUlU3UnJtaUtPbjhS?=
 =?utf-8?B?bFRzelZBMjNOMXh6dWxrTXFkTzMyV2ZoTjUwaDdkL21uSC9MOFB3WHZsZGxi?=
 =?utf-8?B?dXhLM0t5NUZQLzJIR29HZ1ZuUXR6NzlDY09Ob1M5TGVjbTQzd0JSa2VxNEZ6?=
 =?utf-8?B?ME9VUEZqM0s1dnNhcDFvUHZjU2xSMUp0Wm8vQUlpMmk2dXBIM2pjcGpaTWdX?=
 =?utf-8?B?R1c1Zm9kZkhCZnVjZnRJZnJXUXdHYnF3OVhkSlpUKzB3dFQ4R2JpWk95bFE1?=
 =?utf-8?B?cXp3aExTK2UrODBtdm5pN3hMVGpMYkJ2ZFJtY2RUMm9Ga3J1ZkZXQ0ZMRVh1?=
 =?utf-8?B?bXdEMmZMMWRuNEJVdkZCc2xQZ2o1ZzRCL3p6Nk1FQkYvVUhSSTVwenFHT3ZM?=
 =?utf-8?B?YW1QUXp5emxhYzhIWk9kVXRtNGRuUGtDVGpmekF3OWlBYVF3aHJWNUJUTUxN?=
 =?utf-8?B?d0ljMnZrenhQaDBBYlFsOUZLQ3ZZOW9HeHZRQ0lsaVdjVjdkQ2lONHZIdnlW?=
 =?utf-8?B?dTZNSlFFK3FRcnYvSmNQUytzaFFDa1ovNmZYQXNaRVRuSWNkMDlKeUVjUmpX?=
 =?utf-8?B?bURLSkUweXJrRFV6a3luQnQ3bTh0SnZZNWIzeHBVS3RhWDBlelovd1ZFZ2E2?=
 =?utf-8?B?K1hMOGtFSkpOejE4Zlo5Y0IwZjJMbXBvdUlTR1lGSzJBY3kwdXhyck05azBw?=
 =?utf-8?B?N2xPQjhqMm01SUZPZ1FGZkJ2T1AwUXpGL0sxMWJaQVVUZVpGaU9FaUhIcU9V?=
 =?utf-8?B?eW96U3JjS1JXcDZIcnJ5STd5dWhVTGtuRjBTeUF6ajZiRnp1R3pIV0tIckUy?=
 =?utf-8?B?a3BDZjhUZ2xKMUh4Q3FtM2p4bUYvWTJOb2szRDlHaHNZV0FDbmFNdFlyaEdO?=
 =?utf-8?B?ZjlKWTVJbmF4WUp3Q0srVHB1U05UZXJMdE5hdUhQbUl1M1JHS1BrRkVjL0JM?=
 =?utf-8?B?WWZJV2hVeG55YjFzZTB1MVNWQXcwWU5DcUgxbUZPQTNrSjJjQTNsdEVmaDlF?=
 =?utf-8?B?bzhmUktaRm9IbWVsZlNiZjZUcjlaMkpvRVJLMjN1QzVPODBva296SWpIN2R5?=
 =?utf-8?B?ZCtrMWV4OGNLTitEOFdoNFIvRGVIUm90eEZQTUwyZGU1OThHcGp1UmxEajRw?=
 =?utf-8?B?VVhuZkdoM254ajRlQkwxRDFFTXdmYVlOOCtGS1lldUlycUd5V0NqUDNiRVVW?=
 =?utf-8?B?bHZpc3hJVW5iNlFBTFRPQ2tSdkdvaWE0Tmtzd3Z1ZmM3SGkyVWRsSUJRU2tX?=
 =?utf-8?B?QXZsWHpnaERBWERwSEtKZmJhL1FoVW1UakZuWkZtMnRKLzM0UzVIWUxWUHpH?=
 =?utf-8?B?cjNMNFUvTWFkS3EreXlRVStyYkJWM1M1akU4dnVwdzNkcXpiSWcwMC9pWGh6?=
 =?utf-8?B?eFFXZWpNZG42M3RVVHJ4RmZpQ3Z1T0pZVS9RNXhCMTBLWE1UTDExUEJLVzhE?=
 =?utf-8?B?WCtYeGZzWEwwTGZjZHRyck1wUnVPNHNDRUhWRGtSUGNkcU92MWNOaFhVUXA4?=
 =?utf-8?B?aXdDdzloQWg4ZkFFdVZPbUswNHJZd2NxN0hZZnFnMERjaGVxbFV6SGlNeEJI?=
 =?utf-8?B?VHV5ak85UDI5cTg5SnprZUprNmdMa0JyZTJTSkQxeCtjWTFaanNWN2tLUlI5?=
 =?utf-8?B?NmNXNzNBSy9jeXduSEdFeHdSdmhXdnhuQjN5bkVna2JsTlZqbDRxZDllK0N5?=
 =?utf-8?B?b3prT0I2Zm4xM0J1REFLY09xRG1IOENHM3RFMHFBMWR6Wk5lQW54Sk5CTkYx?=
 =?utf-8?Q?kZMY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXlxUDVtNFB3blNyMEhUOENWR1RPWHRNUkFlSzduUDZQRCtNTmVhTysrdDN5?=
 =?utf-8?B?Q1Q4bE4zRTlwQnFxV0RoRnJpR240U0xKTlY5TzlmQ2Q3K1Z6RmhnMlE2RW92?=
 =?utf-8?B?TytUcWtYVmpJcjduM202Y1RCSEhvM2h0Sk95VDkvTm1NaEROVTZZNWQyQkE2?=
 =?utf-8?B?enR4UzlEbWdHWXNOZUNUTmtZaEFrSWwwQXhEdGkyZFpUNXJsVkVaQWc2REQz?=
 =?utf-8?B?U3RTenViL2dUTkdrWHM5dkhUalRFL0NMVHVBSnVXSlMyK0l1NnRpMDBEYjdz?=
 =?utf-8?B?VnIxYlNaTUZ1eHFMRk9yOVBmdmNSRThBVmxUZDBTSjBSQ0F0eDN3V2xwYjdv?=
 =?utf-8?B?dytMcVBTUlUrMkFubitGUkxjaFd6RWl6MWVCSzl4VkZtaWZXTkM0aTd4ZFhp?=
 =?utf-8?B?UnFaWkxFY1I0UHVlTjhIWjB6MW1vMlFxaHlhSnNxMmdNdjJXWVlVYjBPamc1?=
 =?utf-8?B?aEdSdWhtdG0wQVJPT2RldFNKMlJUZFFPV0Yxekw4WElUb1pFditUQ0ZvVUdB?=
 =?utf-8?B?bTA0WnJaaXo0bnlFYnlhK1dKckpNbzhCOFRNOUNLOGYvRUFoQnR1eXhlVVRo?=
 =?utf-8?B?eU1BTlMrcXZvekl5UlF0T3JmVkkxTDFhQmJMYUt5L1g5U1BCek82Ukg4OWEr?=
 =?utf-8?B?OGhnY2FJVGpQWEhEb1pnanQ5QlV3bzQ5Z0RyY2RmSG12cC82QU4yeEhMejhu?=
 =?utf-8?B?UTNwNXd1a2F4V1VaMjYrRUd1Zk5aaVBkY0N1ay9YUzYyTVFnM1VuTnVBU1Vp?=
 =?utf-8?B?UCtzRE1CWUU1NHMwNXM0cGpOSW1xYy9Kb0tHU2plTXNwSk53VmtWa1NlcXNG?=
 =?utf-8?B?RnVEMmdvM3BPZjE5VE9yY0NuZGRORklLcHR3eWRmMUlVekNOcFdweG41d3g4?=
 =?utf-8?B?SGo0eFZhSk5lWmVjMHRNWndrZXhXZ0FnWndoM1BvZkpJc2h2Skd2OG1vL2pO?=
 =?utf-8?B?ejRzSVp5cnZSWXVYTUNxQlBuVFNkUzFNT2loVjlVY3dtQnNXRHlybmIvRm1R?=
 =?utf-8?B?ajhLNUtNRUI3SmljWkltN0U5dDFSQjROdmtuenpyQjc2enlOUDJCN3FET3Y2?=
 =?utf-8?B?T0lhV0JmWENvRjhxS0JxMTB3QW1yeHhXOVdnNnhPVlh2a1gwNW90ekFoYXoy?=
 =?utf-8?B?T1VaU2g2MFFLZys1OUl1TVlBY0lheUtxcldnRmtmV002RTVGSDU2Y1RLQ2Ja?=
 =?utf-8?B?UHRRQ0pYZjd3UDN3bFdma3hHeGs0ZFpZZjg2SVZMWHR5bFlQUTVEMXkzNTRq?=
 =?utf-8?B?VUZ5WFg1OGlRR0pYa3kydVdZT2VqUkMzakE3SzZlSlVJbnN4MUw0WTZrZHJm?=
 =?utf-8?B?UmhPRmllR2RxQlZ2a2ttSGZ1ZFFrVlVCTGx5cVRBNVF0cUZkN1pJbmtDNWdQ?=
 =?utf-8?B?bWlOVG5RY0thMjZOMmQ0ZWR5aTBuZlVOckFML0krNHBTRlVCdGU0YlVONGVo?=
 =?utf-8?B?Q0FycjdtaThzeW9jZC9PUWszN2N1VGRuOEpHTjNrRVh5U0xLS3M5bFpGbEFX?=
 =?utf-8?B?aGxhZ0pqcDAzQm95amRyVmU4WVFkbU9aN08zM0ZlSnA3TmJvSThvbncxclJB?=
 =?utf-8?B?b2xKNG1vMFdFenZDRDk0QTdKRlpPWlBQbmxDT3VtbDk3WGtWQWhjMWx3RjlR?=
 =?utf-8?B?dWZXY3BjRytWRXlBamN3d2d5cDdwVUZoYzB2eTBDb0lnUjdzYS9oREs0QXJX?=
 =?utf-8?B?UGRybU4vbThQTnl4U29ZOHY1WFZINmd1aGJCVmVXSWdBZDJEdzh2TWpGUnA3?=
 =?utf-8?B?Wi8zdGNibkE3T2FyMG1TK2EycTFaVlNlU0lOQ242dU03YkZiQ3pQNHowR0Fm?=
 =?utf-8?B?VEUvQUUvYmZIRnJXa0VUNFBIY2xQa1hoSnlBQUFidTcrMUVEWW8wQW5GdUZr?=
 =?utf-8?B?S0FiZVN5Q1NhN3NnVGNadGlpR0t3aFRQMHVSMTdERHpidlVJMXRIY3dSS0o5?=
 =?utf-8?B?NGZvc2ZGV1FQbVNwbzYzYXNtNjU5WHJad21mQW95YWxmNVdWQVdZUndOV0NL?=
 =?utf-8?B?eld4MTRLQzhFT0YwdXlUVXF2My9mMldTVGFxRk1QbzFIbzJvbWNmUElRTTdq?=
 =?utf-8?B?QlZvZTgyOEdsMUZYdTd1bkxEeXpaZ0o1SXVDREtPN1R1VktzelM0b3RTeGM4?=
 =?utf-8?B?VDVEd1NXM0VnYUl3S0xEVmhhRkxIY3cxOWRBdkhmMmxKUGxQMW92MzBjMHln?=
 =?utf-8?B?MTRzeXFVQW1pUjBZMjN4L2VIVktTQzRFdkJPRFdWb2Vndk83eGI2UGRRdEVG?=
 =?utf-8?B?UHUxcmtibkxHNHN3Z29FblJ6M0UxaDZieTkzdFY5VUlUL25DZWlnTk90TDdp?=
 =?utf-8?B?cnpWejNNZjhUL2FSN1d2dmFqVFRZN3dJWE8ybnlYR1Rsd0RkTzVsU0FpRHBl?=
 =?utf-8?Q?2S6Ir1mkWHEPsjiN7JnLIkppkRTVrs5xhPdLEnRwbN+hu?=
X-MS-Exchange-AntiSpam-MessageData-1: uKvn9LHozIwWn8fQQivNeT3nwHZ493YrVc8=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5aa26c7-f5f5-48c4-1d15-08de5507e997
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:02:40.6904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avdejz1BmGR4+70/8sBFgetA1nbXB+ppANmzE6o9/o9C/ybdU9bQjBPXp3T5N6BzODysrV8nlZQ19IxKNx6zcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8432

On Fri, Jan 16, 2026 at 01:23:45PM +0000, Lee Jones wrote:
> Please send me the full and finalised DTS hunk.

I gave it to you earlier in this thread, it is (2) from:
https://lore.kernel.org/netdev/20260109121432.lu2o22iijd4i57qq@skbuf/
(the actual device tree has more irrelevant properties, the above is
just the relevant skeleton)

With the mention that in current device trees, the "regs" node and its
underlying hierachy is missing, and patch 14 from this patch set uses
the of_changeset API to dynamically fill it in before calling
mfd_add_devices().

> > I think you are missing patch 14.
> 
> Right, I hadn't seen that.
> 
> Would I be correct in saying that you're pulling out information from
> DT, then populating MFD cells with it?

No.
I am _creating_ information in DT based on hardcoded resources in the
driver, in order to probe MFD children on them.

The reason is because I didn't need to describe those children in DT
thus far, and still don't, except for the situation where they need to
operate in a non-default configuration, which is board-specific.
More concretely, I need board DTS writers to be able to add the
"rx-polarity" and "tx-polarity" properties to the ethernet-pcs children.
These properties are handled by a different driver. The DSA driver
stands in their way, so this patch set gives an OF node to the
ethernet-pcs driver to customize whatever it needs.

If no custom DT property needs to be specified by the board, it can just
as well omit specifying the "regs" node and its children, and the driver
will fill it in all the same.

> If so, that is one of the
> reasons I like to be able to keep an eye on how the MFD API is being
> used.  Populating one device registration API from another is also not
> allowed and has been the source of some of the most contentious
> submissions I've seen.
> 
> Looks like I briefly mentioned this before:
> 
>  "I've explained why liberalising the mfd_*() API is a bad idea.  "Clever"
>   developers like to do some pretty crazy stuff involving the use of
>   MULTIPLE DEVICE REGISTRATION APIS SIMULTANEOUSLY.  I've also seen some       <-----------
>   bonkers methods of DYNAMICALLY POPULATING MFD CELLS [*ahem* Patch 8          <-----------
>   =;-)] and various other things.  Keeping the API in-house allows me to
>   keep things simple, easily readable and maintainable."
> 
> Add in a few function pointers to be used as un-debugable call-backs and
> you're well on the way getting a perfect score for breaking all of the
> guidelines that I use to keep code "simple, easily readable and
> maintainable"!   ;)

Ok, but this is highly subjective to you. What you call "simple, easily
readable and maintainable" I can just as well call "does not scale
beyond sticks and stones".

> ... but if it is split-up into heterogeneous parts which get registered
> separately then it should meet the criteria.
> 
> You're hearing "once driver has been merged, it cannot be split-up in
> such as way that the MFD API cannot be used" and I'm saying the exact
> opposite of that.  It absolutely can be used if the new layout meets the
> criteria.
> 
> I'm not sure how much more I can make it.

The (DT) layout is given by the driver's history as non-MFD.

> > > Does this all boil down that pesky empty 'mdio' "container"?
> > 
> > Why do you keep calling it empty?
> 
> Because it has no compatible, unit address or any of its own values,
> which appears to make it untraversable using the present machinery.

The fact that the unit addresses are untraversable by the OF address API
is exactly the issue. They are addresses in the address space of the
Ethernet switch chip, you can't memory-map them into Linux, you have to
go through switch-specific SPI reads and writes to access them. Then you
wrap those SPI reads and writes into regmap, and you can present them to
platform device drivers and they (almost) wouldn't know any better.

> > > Or even if it doesn't: if what you have is a truly valid DT, then
> > > why not adapt drivers/of/platform.c to cater for your use-case?
> > > Then you could take your pick from whatever works better for you out
> > > of of_platform_populate(), 'simple-bus' or even 'simple-mfd'.
> > 
> > I asked 3 years ago whether there's any interest in expanding
> > of_platform_populate() for IORESOURCE_REG and there wasn't any
> > response. It's a big task with overreaching side effects and you don't
> > just pick up on this on a Friday afternoon.
> 
> Enjoy your weekend - we can wait until Monday! ;)
> 
> There clearly wasn't any other users.  Or at least people that haven't
> found other ways around the issue.  But if you need it, and you can
> justify the work with a clear use-case, write support for it.

I'm not convinced that I won't be wasting my time.
I already know that this will be the case for the MDIO buses, because I
didn't have the inspiration at the time to create a "regs" node and to
describe their resource there. So their unit address is a random
"mdio@0" and "mdio@1", and obviously of_platform_populate() ->
of_address_to_resource() can't work with that.

For the children of the "regs" node, maybe this could help, but then I'd
run into the "multiple registration APIs being used" thing that you also
dislike (and which is currently _not_ the case).

So I pretty much know that of_platform_populate() won't help with my
currently established dt-bindings. Changing them is highly unattractive.

> > > > > given the points you've put forward, I would be content for you
> > > > > to house the child device registration (via mfd_add_devices) in
> > > > > drivers/mfd if you so wish.
> > > > 
> > > > Thanks! But I don't know how this helps me :)
> > > > 
> > > > Since your offer involves changing dt-bindings in order to
> > > > separate the MFD parent from the DSA switch (currently the DSA
> > > > driver probes on the spi_device, clashing with the MFD parent
> > > > which wants the same thing), I will have to pass.
> > > 
> > > I haven't taken a look at the DT bindings in close enough detail to
> > > provide a specific solution, but _perhaps_ it would be possible to
> > > match the MFD driver to the existing compatible, then use the MFD
> > > driver to register the current DSA driver.
> > 
> > The MFD driver and the DSA driver would compete for the same OF node.
> > And again, you'd still return to the problem of where to attach the
> > DSA switch's sub-devices in the device tree (currently to the "mdios"
> > and "regs" child nodes, which MFD doesn't support probing on, unless
> > we apply the mfd_cell.parent_of_node patch).
> 
> No, the MFD driver would adopt the compatible and register the DSA
> driver for device-driver matching. You could then obtain the node for
> parsing the DSA using node->parent.

By node->parent do you actually mean device_set_node(dsa_dev, mfd_dev->fwnode)?
We're not addressing the central problem that the spi_device doesn't
have DT bindings that conform to both the DSA expectations and to the
MFD expectations. That's where my "regs" node comes in, but you don't
like it because it involves the parent_of_node patch.

> I suspect you'd be better off manually crawling through the 'mdio' cell
> in the child drivers using node->parent.
> 
> > > However, after this most recent exchange, I am even less confident
> > > that using the MFD API to register only 2 MDIO controllers is the
> > > right thing to do.
> > > 
> > > > Not because I insist on being difficult, but because I know that
> > > > when I change dt-bindings, the old ones don't just disappear and
> > > > will continue to have to be supported, likely through a separate
> > > > code path that would also increase code complexity.
> > > 
> > > Right, they have to be backwardly compatible, I get that.
> > > 
> > > > > Although I still don't think modifying the core to ignore
> > > > > bespoke empty "container" nodes is acceptable.  It looks like
> > > > > this was merged without a proper DT review.  I'm surprised that
> > > > > this was accepted.
> > > > 
> > > > There was a debate when this was accepted, but we didn't come up
> > > > with anything better to fulfill the following constraints: - As
> > > > per mdio.yaml, the $nodename has to follow the pattern:
> > > > '^mdio(-(bus|external))?(@.+|-([0-9]+))?$' - There are two MDIO
> > > > buses. So we have to choose the variant with a unit-address (both
> > > > MDIO buses are for internal PHYs, so we can't call one "mdio" and
> > > > the other "mdio-external"). - Nodes with a unit address can't be
> > > > hierarchical neighbours with nodes with no unit address
> > > > (concretely: "ethernet-ports" from
> > > > Documentation/devicetree/bindings/net/ethernet-switch.yaml, the
> > > > main schema that the DSA switch conforms to). This is because
> > > > their parent either has #address-cells = <0>, or #address-cells =
> > > > <1>. It can't simultaneously have two values.
> > > > 
> > > > Simply put, there is no good place to attach child nodes with unit
> > > > addresses to a DT node following the DSA (or the more general
> > > > ethernet-switch) schema. The "mdios" container node serves exactly
> > > > that adaptation purpose.
> > > > 
> > > > I am genuinely curious how you would have handled this better, so
> > > > that I also know better next time when I'm in a similar situation.
> > > > 
> > > > Especially since "mdios" is not the only container node with this
> > > > issue. The "regs" node proposed in patch 14 serves exactly the
> > > > same purpose (#address-cells adaptation), and needs the exact same
> > > > ".parent_of_node = regs_node" workaround in the mfd_cell.
> > > 
> > > Please correct me if I'm wrong, but from what I have gathered, all
> > > you're trying to do here is probe a couple of child devices
> > > (controllers, whatever) and you've chosen to use MFD for this
> > > purpose because the other, more generic machinery that would
> > > normally _just work_ for simple scenarios like this, do not because
> > > you are attempting to support a non-standard DT.  Or at least one
> > > that isn't supported.
> > 
> > Sorry, what makes the DT non-standard?
> 
> The fact that the current OF APIs can't parse / traverse it.

Are there any standards in this area that I can refer to?

> 
> > > With that in mind, some suggestions going forward in order of
> > > preference:
> > > 
> > > - Adapt the current auto-registering infrastructure to support your
> > > DT layout - of_platform_populate(), simple-bus, simple-mfd, etc -
> > > Use fundamental / generic / flexible APIs that do not have specific
> > > rules - platform_*() - Move the mfd_device_add() usage into
> > > drivers/mfd - Although after this exchange, this is now my least
> > > preferred option
> > 
> > I could explore other options, but I want to be prepared to answer
> > other maintainers' question "why didn't you use MFD?". There is no
> > clear answer to that, you are not providing answers that have taken
> > all evidence into account, so that is why I'm being extremely pushy,
> > sorry.
> 
> That's fine.  If questioned, point them to this summary:
> 
> What you're doing here; attempting to reverse engineer old DTBs by
> extracting information from them to populate a different device
> registration API (DT, MFD, Plat, ACPI, etc) is not suitable for MFD due
> to reasons pertaining to; keeping things simple, easily readable and
> maintainable (see Patch 14 for an example of this).
> 
>  - MFDs should contain multiple, varying, heterogeneous devices

Check

>  - MFD parents should only use one registration API at a time

Check

>  - The MFD API should not be used outside of drivers/mfd

Not fulfilled, although I'm sorry to say, but if it comes only to this,
and the alternatives are of much higher complexity, then I'm not sure
that it really makes sense to NACK based on this.

>  - Dynamically allocating mfd_cells is STRONGLY discouraged

This comes from the multi-generational issue I am talking about (not all
generations have the same children), and dynamically generating the
cells was the most elegant way to avoid these warnings in mfd_add_device():

match:
		if (!pdev->dev.of_node)
			pr_warn("%s: Failed to locate of_node [id: %d]\n",
				cell->name, platform_id);

aka never provide a cell for a child you know you don't have.

> 
> If you think that you can match all of the above criteria, then you may
> use the MFD API.  If not, then it is not suitable for your use-case and
> you should seek other means of device registration.  I suggest;
> of_platform_populate(), platform_add_devices() [and friends],
> 'simple-bus' and 'simple-mfd', although I'm sure there are others.
> 
> -- 
> Lee Jones [李琼斯]

