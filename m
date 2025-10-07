Return-Path: <netdev+bounces-228115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DDFBC1A71
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 16:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9AC0734F95B
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 14:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FE22E11AB;
	Tue,  7 Oct 2025 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ire6ZoiP"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013062.outbound.protection.outlook.com [52.101.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D112E228C;
	Tue,  7 Oct 2025 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846113; cv=fail; b=lSL0XAj3OCtRpNXf/hTGKasbpe/texUjVUiPYh7lAkte1kKlblXK16pjm8a8aNP3ZfWNkZaUyQpUKTH4nKTCgvh61O5QwuJdZmb3i2XpjvqcLQJO0KagQvcAGIHh4NgrLrjysXpvMmNYh9Ly8JXNKFQm9trJdbzhLxMVe3mu61k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846113; c=relaxed/simple;
	bh=K122ijpEhOTjQi+4wu/kqWEwdAXUtvxTgCW/N4+5T1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jFFabmZcDHINAzYXNlGGmt8LrOgvC8Ib9zR4Jenwk7UHzYK47lg/dTG6O4OFm9BmKkdtbISfcWsl0wM2rmwJwrbF2ol+D+RCZSsmENjBF64Sn0atvLBx4ugNBC62TrrbONqdVvDag3t5wKjOANpqMSQBEKCrV6RVKr8OAtgWKxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ire6ZoiP; arc=fail smtp.client-ip=52.101.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3TngxhnX81bHvuGuSIs4wxv2hBbhN5U3+uw9deQjbV81pWfTzrcq4HLYAiuzlLjZ+GR0LYNZkoVINmQpPl9HlgqQLNq7aeMoD+NpFN1+dl+RSIM24vGiv+tAc0TNfvCAJTAXaO1z6S0coOYo4flQgNmPUJc62gJwpTSzAQrWo8FaYckzKNfeXeSW9WZmv9VMFKfCcDsrp0rPtbQWQ3H5fJn3WO1ZaWZsBJjAmfjT0Q9eOOR07FoX4dTAgfXHnt1I+ypxsPaWLWErWMlI7kEEqrgRmF5eCVQYiBpiSaYTB2IV6AdW+fNYnnXmCMU4LX7mq2w0L4PbrZ2+vgOPnDEbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsXDC7X6bd2Pst0S1/SSINdE/lcpIP+tIkyT7WQnGUY=;
 b=aW/OlWuzyiIdMUjF7KUlS5CezOr73ggdL3uRVck/G459CTXFW58ExdMBrVohAEV1u/IBrZ1Hakj33FI8tb1l7lnjVC6UWln5vNtNe5rbEnz9vTs8pcn/hlKbAYS2SgtSzz69qeIqO3ugYGaWQ8Ugi7KYNjrzq86Tc+Adot2rStrYSZA2zXE6ssgCX/lmjHNdoX949JzpbXC2MhqCqNR6evuDPuF/ZG2VxLsvN3G0bUhocWmbO5ZW/CbLFxNWdGFOEr3rzIygBEfz7en03ZrC+tImiEgw3e68kv7cpEVKHeltrsm+I/BRhrfTC0q/eGyLDJZA7FhDCSAyfEZYMnaewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsXDC7X6bd2Pst0S1/SSINdE/lcpIP+tIkyT7WQnGUY=;
 b=Ire6ZoiP74UI4cYuMJcd/S2PIkyJm1DJNPQA0HafWhM2vp7UH1wedg/v6PXqhoQyiv+k8BDEhZ3CuU9/D1um/Pi+wlqA0uhXvaZcXykJiXu2WFjzgEU+iBWEcu/28j8kOW5ELPYqE0hC/clF+bpxo+KYG4H+OvUp4FUzDfQkbQYRB9GtfnD6hL+D9j8bUgOlkHuTGJD6lhG+NMhcVJ8XIBcdEV4VhfgjJg6n4f5kDJKL6FqjGoLRZokwj9q/e9vWcfX9islZ/IjAllSxLuQvUmPoFvYO/4rTiTxXCDiSYx34IxFtvRCESZLDem8Pqd7+peQaQIDeu5f3MeHSB0+z2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7429.eurprd04.prod.outlook.com (2603:10a6:10:1a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 14:08:23 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 14:08:23 +0000
Date: Tue, 7 Oct 2025 17:08:19 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <20251007140819.7s5zfy4zv7w3ffy5@skbuf>
References: <aJH8n0zheqB8tWzb@FUE-ALEWI-WINX>
 <20250806145856.kyxognjnm4fnh4m6@skbuf>
 <aK6eSEOGhKAcPzBq@FUE-ALEWI-WINX>
 <20250827073120.6i4wbuimecdplpha@skbuf>
 <aK7Ep7Khdw58hyA0@FUE-ALEWI-WINX>
 <aK7GNVi8ED0YiWau@shell.armlinux.org.uk>
 <aK7J7kOltB/IiYUd@FUE-ALEWI-WINX>
 <aK7MV2TrkVKwOEpr@shell.armlinux.org.uk>
 <20250828092859.vvejz6xrarisbl2w@skbuf>
 <aN4TqGD-YBx01vlj@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aN4TqGD-YBx01vlj@FUE-ALEWI-WINX>
X-ClientProxiedBy: VI1PR0102CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::16) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBAPR04MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fddd51-ae98-4088-3d15-08de05aafa08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDAzQ2ZYYkl3WGNvUlE3VFpReUUzQzdXc3FFbzlVai92TTAydDR4aE4vSU1L?=
 =?utf-8?B?Z29hNlNVMkpyU3F0RlNjeHNRcTNiS0V6TkRXakZnOEtycVJmQzZLaUxOUUs1?=
 =?utf-8?B?dVE4VmdMMUFVUEkvS0RySHhHaXFML1l0STQvK3RXSVZGbGpDSnVDSnhqcnF1?=
 =?utf-8?B?YktxM2xGV0FualQ3enp5MTlyS1YzMFN4M3Zud2xuaHU5T0RSbW92Y0hjOW9L?=
 =?utf-8?B?OHRraW1kcFdIOTBjWGVBV0dzUzlabUpVdFJPa0Z5eEpKdGxkS3ZYWllTZEk4?=
 =?utf-8?B?MVZpNHE4ckszeXJSb2lWV2xROUNsRkluMzNuOHpzYXBtZFZSRk5udmh2b0J3?=
 =?utf-8?B?RVVFNlNpSGR0Y3FNUWZYeGZYVXNhMkVYUkRVSHBGVk5jR0hJY3NVd1dSa0F1?=
 =?utf-8?B?RTJ1ZUJqOGVOZytKT1d1dWRlQXE2WFlrd0NqVEFhS1dtM200bUplcTU0N0sw?=
 =?utf-8?B?NE1HRnJMcm5sWFByYm5uOVV4QlllVlR6YU1rMUZKK210bFdacC9nSHNnTGIw?=
 =?utf-8?B?cFJzai9RWFhRblNnM2FPUStJOFZUQ2w4cFBIa2JiemY0YXNycmdUbHZuK1p4?=
 =?utf-8?B?aEwyeUFSMFRjRjhDZDhrOHl4cXdPM1lVZ2RDVDBCZHlUcmNFQm5mUjIxb25V?=
 =?utf-8?B?dmViSVNNbGtUemxrOGxJdU96UjduRS9CaG9icSs4NEJETXJOYnpDcUpPUk5h?=
 =?utf-8?B?YXB6cHVoM0o5OWVnMXJ6MExHcVhoQkFzTEhwRDRraHhaS1M0eHljeTZnL1A1?=
 =?utf-8?B?clRnOFloK21YVjZ1aGtFRlowUE80U0xiVTJ6Yy9oaWhJNWNJaGtjbXFHN2Vo?=
 =?utf-8?B?Y2c5My85M000Qlprc0FCeFBEd08vdGF6ejRBZDExTWM4YkJJSTUwUVRNQ2NX?=
 =?utf-8?B?ZHQ3MkhWU1oxZ0dmUE5yd0FQRlFuM2ticmZSVnpUSUVmTFpvK2ZuZUkwU0tV?=
 =?utf-8?B?dXNLMCtCekRkREk0QUJXbzYzNy8reEYybHkzTTFHaHZLdVpQTHBnWFN6QmRR?=
 =?utf-8?B?U0RGbFpXU3JwRSs2b051WnhrV2xqK0VVS00wSUZlTEw0WG4wcHFDWTUzbElC?=
 =?utf-8?B?TjJTNVZ5bHJEbTBJb0lFOXE2a201RHprTUlSbDJNWWtMampkeW1jSkpyWjgx?=
 =?utf-8?B?OUNISStsOUsvZm02M3czcUp0clBaRUFMaUt3QUgvejdSNHVnSExaQVYxbU1J?=
 =?utf-8?B?ayt0N2IyNnFML01rRG5oSVpZcHcyUnZ2R0NkY3RFcTdiczBkY1pxYWNOTDdn?=
 =?utf-8?B?b2RLS0FkM0NLcmFmdXFSK1ZEd3F6WmRVT1F0QVRxU3MrMUdFdGd1d2FKWmxh?=
 =?utf-8?B?SzRjRFhzKzU1WDFYSXVKZ1ZxZlFPd2kxVlljWUpoMEY0TTFKY2ZtN1FtNkRZ?=
 =?utf-8?B?d3dPOEo2NTVjTFdvTmRFWTYvdUVzNmFLQXgrdm1JVS9YbTYxekY0TWlMQ1VO?=
 =?utf-8?B?anlleGJJbWFCbWkrUWlxVGRSY1dWODVZQVZVV3gvSHNRWC9xUzJ4T2lBVGNz?=
 =?utf-8?B?WTdJZFZIcjNud1BnYlZlYURtbmJBR0xYbHlTd3BvMWlNL05RcDM0VExGZWto?=
 =?utf-8?B?Vkd0K0Q5ei90NWFwRi83eGd0NHJRS2xEVlVHV2RoaWhmLytMeXdsUXMyYTdi?=
 =?utf-8?B?TFZJVGJ4NGFhYzl1TkFEQ0RGTEdFTmJtUlBjODlNQXczMExydjh6QlBMRFF0?=
 =?utf-8?B?UXZQQklhU2pSYzYzbG5icTBiUDZrQXNXZWdadmo3ZS8wSHhtZEk5VUVhZG1p?=
 =?utf-8?B?L0F1OHRYc2NuRUY0ZGtjd0gyZmdTMTR1RmlpQlhOQ1lOQ1laZGNCMk4wQk9Z?=
 =?utf-8?B?aHU0bC9kUExUR3czRVhScXM5QnBPdTYvNWFpYnFNUm9lZ2JSRTNsSGdQUUxs?=
 =?utf-8?B?aWRvUjE0d21BbHNHSlUvOC84dTd1dkt4S2kxMU1XcEpPd2t3VE02cmtNRWJ3?=
 =?utf-8?Q?Se7KpRieOL87jedkmsGAuvWIOqFtLeuF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFpKMThXb0tYS3EwU01zTDQ5Q0hRQ1VaY1FRditMcGtqMGFPS2NMczkxdFNS?=
 =?utf-8?B?bEVHOHpnajd0M2ppYm1Gc2RlSHkwMldNZ250UG9pL2luZTIyN1AyenJPZ1d2?=
 =?utf-8?B?RUkyNDBienFxdEs5dmtJeVBTVnJFRFZTd3BPcEhHWkxhZStBbzJTVDhNaCs5?=
 =?utf-8?B?WDF1RDNvcmdEYlQyaUErOVNXYW02blV2L2E5d3VXaDNET2txQ0xFa3R6Q0hx?=
 =?utf-8?B?UmFsMUFQZEtCSU9CYWIwOU8yK1czN1JMRDBzQ2R4NENyY1JHWmFYMDB5MW9L?=
 =?utf-8?B?YmVHdnZVTXZ6c2Z2WCtJMjEwY1hGd2k2ZWJhNDJLSVFPTzNrcmZod0NyYUlu?=
 =?utf-8?B?ZDJUbWNTeWM4VkxjcWNKRllWVWZSaDdwbGNSY3BDMTIxcW4xaUFOWmI4UlEv?=
 =?utf-8?B?UHF3Z2t2NHgwUFFVdi9sVUZSWkgrSzVmYkZwYnFUanRTNXRtcmJqTS9EcUFi?=
 =?utf-8?B?YVYyZEFaRWdEdU9DeXN3S2FvUXNxMWM0SkQzMHZ0MXBGcG4rZmYza3YwYmU0?=
 =?utf-8?B?SEdSN2M3MUtnVWJxcFBvbS90ZjdDSVdualZDQUtVM05kRXVveGJYZnV2SFZS?=
 =?utf-8?B?UTBmUlVyVEVGOVUrLzI1QzBUZTNVQ1JQWXJMSGtvcjJnZDAvdFlPak5zUWV1?=
 =?utf-8?B?aE1uVWVZeEY2cjBUVGZRSWdUM1Y0NE95eGlVNStHQjBBcmV2cEcyeTcrMWVX?=
 =?utf-8?B?NDBLN1J2YXJLZkxvUm9MYzZwUU5BSEtDYjlDMjZEYW9nRG9QZmkyaS9qb1Iw?=
 =?utf-8?B?VTBKRjNlYk9USUJNWmhFMzJQUmlOZXpqZTM4M25zVXh1T0ZWd0hEQ3lkU3pl?=
 =?utf-8?B?Ni9sL1BGM0FCUWQxejhrTWRoU2RiRDlhcXlpODU1NFV5UU1NdjFpTklMOGRv?=
 =?utf-8?B?T3IxVnZEb3dUbkViRklPMnRTMlpHUUNaamdBUUtvdmlNeUYyQVYvYlZkVk52?=
 =?utf-8?B?ZUFGUkVBdm5QS0w3Y1lPZjRHTDhtWDIrWTNDNUhGSlFNdHBRbzVTTXIzSm9R?=
 =?utf-8?B?VU1qNnVZZGxSdzdBTThWRWRib3dtZS83SWkycTFjdG5TNXEvRVFmN0xEQzN1?=
 =?utf-8?B?b1JZbzAvZnJDSmo5V2Z3ZDNtZlVtZWpVZDRJckZscEIxWE5IZS80OStkaTJy?=
 =?utf-8?B?aDc4VVg3TnNtSWYydjEvb2hJTThjUklET0JXaDI1NWplSGwycXM1WUdoRnk5?=
 =?utf-8?B?VjRreUdpYnFDRmxqUSsxTzJLK3BoR1ZYTXUwcTM0bHQzaEVNalhGQThpVUNn?=
 =?utf-8?B?SGFJQ2dXb2NNMEJNNlc5UnRIMlNyeWF5M1FiRkdhMGRGMnpJc2JYVTJxZjA5?=
 =?utf-8?B?RndodnZWZU5aZ1E1UkJjSVQvbEVJVkpzM1J0QlFiQnRTTk9TQ2E4cW5vYUFR?=
 =?utf-8?B?SGI3emFFTXhZYWMycEpSVEtxNzkxVDBwQUt3RnJscTkvcExUNXh4VHVtSW8z?=
 =?utf-8?B?ckhaZmRyeUN4OGJNSldNRHFDeFlIcEx1WnlqTlZ0UXk4TG5rakg3a3VqUkgw?=
 =?utf-8?B?WVpwN1Q0dkg3VzYzMHNIZkdMY3YvZDVJZkc1WWkvaHVRL2xGMWJQUjZMWGJC?=
 =?utf-8?B?UTMzWU5aalBjcXAxWUVaTjBidUVicjdZdGhvOXVXN3kxWkFzblgwWlN6MklP?=
 =?utf-8?B?aUtUUHJEdUY2UXZGbkdvRDZGNGx4aTE0T3ZZSGZ5STZVbXJjbnFqRU9PNDB5?=
 =?utf-8?B?SUlJZHdsS0VkSU83TG1WRytGd0d4dU15enUzWDdhTGx5WmhSRmpMUmxpcExh?=
 =?utf-8?B?M3Rnd1ozWXpXMjFGSjUyMjZHckZZdTZzUUdDYld6TFpUVHBqUGdLOUxkSnFq?=
 =?utf-8?B?dkpYcnk0bW82NU8ySDVNSWFRYU9aTGM1Yjc5aEVycGhaRjJTREJIVGtDMUxW?=
 =?utf-8?B?eXgrQWlHQk45TjExOFprSE1aWTB6UVpDa09oVGY2MGNCR29OdFZwdEdoaXU2?=
 =?utf-8?B?T3NHMXlvM2xZT0JkZEkwUWxib24xSnc1MW1Mb1lwNFJlMTBQWnlmN3E3bzNJ?=
 =?utf-8?B?QmlsekN4N3hlaUR4Q3J6ZkpBVUdtOXJTRVpGRGhiTlRVaC8rUEpIejl0WGc3?=
 =?utf-8?B?SGEwREM1SmhFbHA0d0grZ0tiLzJVZHpLVmZvdXhCczZyOFhJVXA5ZlVRQlpW?=
 =?utf-8?B?T1JTR2tUS1ZBTUJ4U0g3MURmSmZRVzFlQ3BRdWlCT0dQdTMzVXEvU2w3UTAr?=
 =?utf-8?B?dTk3Yk9GS0I2WGZTZTZWVHVLK2tsVmNPZTgwZW13dkJuT2k1cktCYkQ0WGg5?=
 =?utf-8?B?RjBHM0ZSR2NnaHNYYkJheGZyUi9nPT0=?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fddd51-ae98-4088-3d15-08de05aafa08
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 14:08:23.3161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUarTsXyOt293TeGQYL3ML1Y57DxKqsKMdmafNqE1A1lnKJi9fgLTslvVUnZuq7ytfiAs6fBNueuLALSWu7jzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7429

Hi Alexander,

On Thu, Oct 02, 2025 at 07:54:48AM +0200, Alexander Wilhelm wrote:
> Hi Vladimir,
> 
> Thanks your for the hint with the IF_MODE register, I finally found the
> root cause of my issue. Unfortunately, my U-Boot implementation was setting
> the `IF_MODE_SGMII_EN` and `IF_MODE_USE_SGMII_AN` bits. This caused a 10x
> symbol replication when operating at 100M speed. At the same time, the
> `pcs-lynx` driver never modified these bits when 2500Base-X was configured.
> 
> I was able to fix this in U-Boot. Additionally, I explicitly cleared these
> bits in the Lynx driver whenever 2500Base-X is configured (see patch
> below). Iâ€™d like to hear your expertise on this: do you think this patch is
> necessary, or could there be scenarios where these flags should remain set
> for 2500Base-X?
> 
> 
> Best regards
> Alexander Wilhelm
> ---
>  drivers/net/pcs/pcs-lynx.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
> index 23b40e9eacbb..2774c62fb0db 100644
> --- a/drivers/net/pcs/pcs-lynx.c
> +++ b/drivers/net/pcs/pcs-lynx.c
> @@ -169,6 +169,25 @@ static int lynx_pcs_config_giga(struct mdio_device *pcs,
>  					  neg_mode);
>  }
>  
> +static int lynx_pcs_config_2500basex(struct mdio_device *pcs,
> +				     unsigned int neg_mode)
> +{
> +	int err;
> +
> +	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
> +		dev_err(&pcs->dev,
> +			"AN not supported on 3.125GHz SerDes lane\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	err = mdiodev_modify(pcs, IF_MODE,
> +			     IF_MODE_SGMII_EN | IF_MODE_USE_SGMII_AN, 0);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
>  static int lynx_pcs_config_usxgmii(struct mdio_device *pcs,
>  				   const unsigned long *advertising,
>  				   unsigned int neg_mode)
> @@ -201,12 +220,7 @@ static int lynx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
>  		return lynx_pcs_config_giga(lynx->mdio, ifmode, advertising,
>  					    neg_mode);
>  	case PHY_INTERFACE_MODE_2500BASEX:
> -		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
> -			dev_err(&lynx->mdio->dev,
> -				"AN not supported on 3.125GHz SerDes lane\n");
> -			return -EOPNOTSUPP;
> -		}
> -		break;
> +		return lynx_pcs_config_2500basex(lynx->mdio, neg_mode);
>  	case PHY_INTERFACE_MODE_USXGMII:
>  		return lynx_pcs_config_usxgmii(lynx->mdio, advertising,
>  					       neg_mode);
> 
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> -- 
> 2.43.0

Sorry for the delay. What you have found are undoubtebly two major bugs,
causing the Lynx PCS to operate in undefined behaviour territory.
Nonetheless, while your finding has helped me discover many previously
unknown facts about the hardware IP, I still cannot replicate exactly
your reported behaviour. In order to fully process things, I would like
to ask a few more clarification questions.

Is your U-Boot implementation based on NXP's dtsec_configure_serdes()?
https://github.com/u-boot/u-boot/blob/master/drivers/net/fm/eth.c#L57
Why would U-Boot set IF_MODE_SGMII_EN | IF_MODE_USE_SGMII_AN only when
the AQR115 resolves only to 100M, but not in the other cases (which do
not have this problem)? Or does it do it irrespective of resolved media
side link speed? Simply put: what did the code that you fixed up look like?

With the U-Boot fix reverted, could you please replicate the broken
setup with AQR115 linking at 100Mbps, and add the following function in
Linux drivers/pcs-lynx.c?

static void lynx_pcs_debug(struct mdio_device *pcs)
{
	int bmsr = mdiodev_read(pcs, MII_BMSR);
	int bmcr = mdiodev_read(pcs, MII_BMCR);
	int adv = mdiodev_read(pcs, MII_ADVERTISE);
	int lpa = mdiodev_read(pcs, MII_LPA);
	int if_mode = mdiodev_read(pcs, IF_MODE);

	dev_info(&pcs->dev, "BMSR 0x%x, BMCR 0x%x, ADV 0x%x, LPA 0x%x, IF_MODE 0x%x\n", bmsr, bmcr, adv, lpa, if_mode);
}

and call it from:

static void lynx_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
			       struct phylink_link_state *state)
{
	struct lynx_pcs *lynx = phylink_pcs_to_lynx(pcs);

	lynx_pcs_debug(lynx->mdio); // <- here

	switch (state->interface) {
	...

With this, I would like to know:
(a) what is the IF_MODE register content outside of the IF_MODE_SGMII_EN
    and IF_MODE_USE_SGMII_AN bits.
(b) what is the SGMII code word advertised by the AQR115 in OCSGMII mode.

Then if you could replicate this test for 1Gbps medium link speed, it
would be great.

