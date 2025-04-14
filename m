Return-Path: <netdev+bounces-182161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F2FA880EC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38BF51675A7
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1822BEC3A;
	Mon, 14 Apr 2025 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iYWAT+Fg"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B632129B212;
	Mon, 14 Apr 2025 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635541; cv=fail; b=t3ebLxwOHwgN/EQAIVWcC8Fyj9P5NkY6bpk/4ZcLAuz+PA2axtwwKzCR54euHDaOOmp5OP9rcBNX+ccf4uPgKv772H/9SZDdYjv3vEiytrl6JuqnfCKK3Noc6kegk4CcmOPiYldXCZmteKWloV2fAwj4atBQCx8z3Hi32tcxeq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635541; c=relaxed/simple;
	bh=4hEbZr24ojARwd0bYgK9niUrGA87V53H6aicF45kvSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QL8YY3Dy2lCXjEgjObXqXjx94wLXTNypRrU3CUS/DzsZt5vkd2/Czb/myqgePN1adyI2Yrq8do37lpeKSFQdpZHvxGJafkq5AsjrkfGJbBPMhh2LP7yrEbP4LRrLxwxIGvchDh00VRt00PmDNP2Gin0HgZn2L5oSfHl6Hqe+mbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iYWAT+Fg; arc=fail smtp.client-ip=40.107.104.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpYmmW5V7fv6zhIrU62ymRtDYRV5FuLv/AvYyA8xCYKAVxJnmGSW7urimN4jJQvXFckhallB2d7wcSNFyj6r5K8QlZu3qRd9BQzVod6P34KepzpEcArxWnu4SMgijq71JNP+N3OiOeetSL1GnD8fmsvE4GFo49WKmEmvUlMgtrYUIHVbjG9YcDPVzzYutYtnNXYMUw/kqTUYoobV7jHUquqRXy4+DQyUIRVlHUD8KHIFt5CR93XgvVLCrpwkoZz5i7KMFNtaqzdl6hlYBGvV3VtMc3A2E/zesrG6FwLrsQx+O/sjLnEoltQekILUtuY7SutSFmF4pBEc/6RNGYGVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVSi/WSphvU4b4mh/9I/oGotT/Rkum9DWg0FAPE4mn8=;
 b=jnWMs4pbDnajdgsxLjyjQrmhCxywLy2eM3ynavk4qpG2ZZLmgwcw/GYZdT3He0jkhrV8oeUTvCMsRWCfPRdrMrNbpm3kVpkZIVuI2Vr2GHQ2kRdcbAbijIKowJ86ALxEMAOcIo1nn+/bxKvtt9geovLXqoo2sSg2jB7hR4ASz4Et7jIoCJZ3tVS6+dTCkTvP2QTUOU/sm92vWXNmkM5PAfkHAcDqptD5YqDdO2gfE17+bjKZQvhhk1HQIJ99UF2yn4XAVBqRKZ1FsGr/ZMQZpBuQCUrY6L28ph0mY81Sl+PZxHNiY8R01B0rYCEBC0crgI8si4yccwOLIgGIlKGbjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVSi/WSphvU4b4mh/9I/oGotT/Rkum9DWg0FAPE4mn8=;
 b=iYWAT+FgIOUBZU83VtgGybmPVGds/rEGKPu3cG2eOD+dJDsrON2SJq9H/HaWIszemQGY7gnfJazsVuwiQd/n42xWSEo3fVWJFW2+vZ5alaItJOjTIqXEMOOZJWEbVdanbkOSqhBijutNr3SKytB6P/7p017ZPlaNN9eaYm8jjZNzsL3Jb9H1K5Vu1b1e0OnfIazUOF9ITAWFTn8gjQ//RjAfcPUmsI2n+ZMHo9+9DN010+sud7afQoV6HpsDWml29QICAUD9ph71PiVp2W7FGxcK9Ir+lZ8K7FQouiXPZOvPnN3Na+a2lQoCGaNsLOqhL4tGV/58Vv6toprpC1fk1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBAPR04MB7366.eurprd04.prod.outlook.com (2603:10a6:10:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Mon, 14 Apr
 2025 12:58:57 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 12:58:57 +0000
Date: Mon, 14 Apr 2025 15:58:54 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net 1/2] net: bridge: switchdev: do not notify new
 brentries as changed
Message-ID: <20250414125854.gtong53wmctv5pda@skbuf>
References: <20250412122428.108029-2-jonas.gorski@gmail.com>
 <20250414113926.vpy3gvck6etkscmu@skbuf>
 <CAOiHx=kRUE8_-4q6wOytrZObyyeSBMTHRMhaFGWDAJ-KBq5vFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOiHx=kRUE8_-4q6wOytrZObyyeSBMTHRMhaFGWDAJ-KBq5vFA@mail.gmail.com>
X-ClientProxiedBy: VI1PR06CA0192.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::49) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBAPR04MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ea26ab-ad90-49c8-263a-08dd7b541e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWcyd2RIR1hwVjFaUmNKOVFJOE1SSjlDbDZXN2NkU2dtS3I1U3MzMjhNVTBp?=
 =?utf-8?B?VnlibS85dlFENFB0MEt1NUM4Wnl4eWZBY0ZGL0xQWEdHNHBTZWxKNVB5RmFX?=
 =?utf-8?B?V0x2UmlRMkNBWWx5TEEyMUhNbUw2SFQ5TUVhMkRkUnc2REwwQVZhR0tSdHc3?=
 =?utf-8?B?Z0ZtbEtOYmJGWksvdFhPWUNqSEpYNzJ4ZDlVM3IxMnQrQlJDS0pkNThDQURG?=
 =?utf-8?B?T2lSTVFEMkR5M3I1Qm5rd20rN2hXZVFFaEVNcm5sMTNWVmsrWlNrMFM4TmNn?=
 =?utf-8?B?Q0NWOWMvZkljRTY4Y2k5QVE3aURiY1F4SEJFWCtjVDB4azhXckl5RVF6T0hw?=
 =?utf-8?B?NDFGMStNcVlyWDFNKytwdk9OSXZ5V1hJdTFCTVc1NDJwdVhXazR2dXFkV0k4?=
 =?utf-8?B?Y0Jja1NKNmhKa2crSW5yT2dTS0F2Q21BTGxuU2QxbGRoYU1UanBINE9rZ0pa?=
 =?utf-8?B?dGRja3N6QkNTM2dWbFJWdUdhOExTTnYvbW1wbWNESzRTUGJ1NU1pT1RRcllY?=
 =?utf-8?B?NEVBN2VzSGpiVDBhYlNLTHUxLy94MUtxTzJTdDh3bjBtUGp4cytoN0RaM2VV?=
 =?utf-8?B?NzhaR2hBWjFhNVdjbDNaamFqdXB2S2lBSEJHQitnM1FjWHh1V2NFcWt0MGRN?=
 =?utf-8?B?aFBBRlRRbjhXQjhFeG51SmQyaThvKzJEUG0ydEhBZnFmcy9Va01MUlVObi9p?=
 =?utf-8?B?bDFRYTZmWVdLd1pRZUs5RDdjbjBIVEdBa0p6R0FVeEdLRnJYamNrc2JER2Q1?=
 =?utf-8?B?bTFtaFBzTDNZTE9sTGdBYXR5ZitYcWtHUDlyNE15Mm4zQ2dBZUFTV2FYc08r?=
 =?utf-8?B?U3pnTGw5TmdRK3ZCRnhjUDhjYVdrbjZaRjhzcDZ6U05pdzh0cnB1QWpDSmpl?=
 =?utf-8?B?OWhwV1pTSmJ6UHFUQXpxVWwrYVh1SzNwaEtsM1oyZ0VvS1l1djg1ZDYyTE1m?=
 =?utf-8?B?TEg5MmQ4eGJ1N2lVS0l2MnBnZC9tRVN0cUJQa0xnYWh6K3JZK0RhdytWRlpr?=
 =?utf-8?B?KytjcVZmbnkycFNZYURWYTJZL05jNlhsTVQ3b1Bmbkkrb0FFMy9mc0pDZHpm?=
 =?utf-8?B?aVVkSTcrTUx5eWE3Q09SY2NsalRSTUd2WXoveFNyK3pCcjVvc2pKYUE5NUZL?=
 =?utf-8?B?L0ZHTnY2ZVdzRFZhTExIbGtLcnE2TDlaSGxtcVdWUFVDbU9OdnFIM2haSmNT?=
 =?utf-8?B?QnBCaUJHNjN0aXFlSXh1Y3M5alRFRXJTUHNDOWpSbHFFNnpyNkxEZFE3clJq?=
 =?utf-8?B?Mk5nbmdKenZycE1jRURUQW9tMnpMaUlqYXJjdFljSnRvQWE3cG1qd1hOWmVF?=
 =?utf-8?B?bTNJNTdkamt4aE5BZHZGd0U0RVd3VlZvaGN5L2x5U0s3NmQzbDRSS0NuVW1Y?=
 =?utf-8?B?bmk1bUc0WnlLKzNqWm0xNU9KRDZrZ0dKbXVkVHFEdytWYktSc2JPOElRY0h6?=
 =?utf-8?B?WjBHM2FrcC9zekJ6V01qNVlyTHFhMGV0bzFKeWhKS3RIcGlSanZHL05KTDZr?=
 =?utf-8?B?bjZoQjVMUUlVbnhZZUZ5NCtuWi9GWnpEZWlqR2N5UWorV0VoNkNpbVFYN3Zy?=
 =?utf-8?B?dVcwR3pnWmtkMFlFTEpuYWJVL0NCdnV0SUxwTG5SZ3IrQ0RxZ3VOQ0daUU9M?=
 =?utf-8?B?Y1ROSUJtQjFIWFdQTHp0UHYwa2NDYStuMTJ5dCtHSzNIUXd5Q1FrYkhQaXBS?=
 =?utf-8?B?WmVSRnpxeThrQ3JDaDZmdlpMalZnVWRrRFNCVkpxQ0J6YjRRUEx5UVJpMzUz?=
 =?utf-8?B?OUhMRHNDYXZzeFNSblVYNFo2MHcyaFJZVjJiZm5kbHVzTUU1cDlGZ3orcGE0?=
 =?utf-8?B?L0k2WkRjU0VKU2xFOWtLajA5Y2I0YmhwQ0JReUdxeDNScURaYVJzM0E1Mkx0?=
 =?utf-8?B?MnZoNFFZL09WMFVpWUVYcnprSEIzbzlaVHlTUDJNZ3JmRXgxOHNoMlZpUkxi?=
 =?utf-8?Q?gdzArzDT+E8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnlmeXBpWUVweUFKbGxCeGFXRVRJRGN4NlJjSC9xS01jaUo3dTE4NnNsbjFX?=
 =?utf-8?B?Z1Rkc2k1b2hXRDZSU2FKS1JEWmFGKzRIRStsZU01VmNTVTNtQ0hueXFpQ1dL?=
 =?utf-8?B?c3pXY0twbkdjSzdJNHJWK2VBR3BxanhkZGlkZCtnQ1VvRENNODJBUnQ3bFFQ?=
 =?utf-8?B?U2hMNEtja1F6dm5qWHQwRzJodmo2T1BJbkFzQVBkV0VwU1dhWGZCK2F1WVd6?=
 =?utf-8?B?VDhaUnJRK1FlWTh0YTNNNHF0dFFpaUV1dG9UYzd0bVk1WEs1YU00T0h5a3Fu?=
 =?utf-8?B?dDAzbVhOZi9ScHE4M2VObVQvVXdLU1dtc3g1Zno4OW9ST0t6NG1pU25zS0RO?=
 =?utf-8?B?TzFmdHhCNytKK2t5U0s2L3pPekJmQWdUcWQzNEVaa2RLUmRaWjdnNWNqQmln?=
 =?utf-8?B?b2tPSFVTbEhIWWh3ZEd0bEJ5OG9SdlJCSmlvd2pLbnVDYXRlLzNWK245STFE?=
 =?utf-8?B?Ukd1SEtsOUY3T0wxQ1N4SDJuazRnZ0pZYzc4SVpsV211OElDeDhEbm9NdVA0?=
 =?utf-8?B?TG13L0FnU1VvMjdpZTliemNvVStwYzZURUZmM3JsMkpYS2xhN2NibTRwZ2Vv?=
 =?utf-8?B?MXpHYVNHQjM4N3J0N0lSZ3c4SCtiTEVTdW84K3h5VmpkNUVLbFdPOFFvbmxS?=
 =?utf-8?B?TC9lTXlFYlA4eHVHS3FIUml4dklTaVAreHg5OFhjU1N1T1NlNTBUaGlybG8x?=
 =?utf-8?B?ditKK1NGUUd4TnUwYkhFWVczUm4rMHpnR0dHeU1SaXVtU09TU3RHa1ZGYk9i?=
 =?utf-8?B?MG9haCtPQytSOFBGcVlHbDJ2WnRGeHZTekpuQ1pHMlRuQ2EyaDIyMzhFZHpH?=
 =?utf-8?B?VFhRdGgycjBIZnRhcm13VzlGTWxBWEpIYTV3SHlUVHpodkxRNkhqSWFXOUUx?=
 =?utf-8?B?cG8xbHRjamNuOUpWanF0d1UxMzY2Zk5lUlhBeGhpd0RFZ2pRQ010VzM4ZXVo?=
 =?utf-8?B?SUFmVEZkc1dzNCtQUHcrTytEM2JCdFRaWlRUcjhGQkYxSysxYWdBOVFvUHQy?=
 =?utf-8?B?bDRxLzFZNEFrNWdwdVRaOGxoK0pSNXE1cFpVQ1ZKRHFmVkR3SDB1c0VOalBn?=
 =?utf-8?B?U3ZkbkFzYzNFbVJSRmtTZUd6K0ZsbXNSUmZ6d3BjZU9wUFdPRWtNbE5GMEtk?=
 =?utf-8?B?QUlFZzlSSE1nSkxWdjFiT0FsL2p0TU5OZlp3ZHpGK21KMGtqVzBHWS9Zakky?=
 =?utf-8?B?RkkwTWp1RHZwN2xZSGpzSXo5WEV6SU1LVEJzTEdEeE1yY0QvaEsxeDB3dVRs?=
 =?utf-8?B?Um0wMWYreXRIWEdESUlHckVGR3F6TUkzUThoQVM1VHA4dDU4Mm1zM0lBSDlW?=
 =?utf-8?B?SDV6aE40UEd4NWtob1R3anNWUVF0T2hzNkRNRWpYU3ppU1BUTUE2dGFlZHcv?=
 =?utf-8?B?RlErNlNGaGM1V05SWXAvcnBTeVZWNG1rakZaMlp0NEFOSkdUd1dNQS9tSmNM?=
 =?utf-8?B?NnlDa2c0OFYrck5PUUlKWTlaWmgxZTlRVXJuQlJlUDZINXkxS04rQUtyaHZG?=
 =?utf-8?B?bk1XMkI2T1lqNXJoa01LcVR5MmM0d0dDUkNiMzZTc3pPNitGQkdsWUNnTmR0?=
 =?utf-8?B?RDJETzBTUVlGaHlGTlRzQWd0d2VablRuTU9GelVHQXhhdlRleHB2SDRuTStN?=
 =?utf-8?B?WnNTVWkvQnE0Nm9qVGgzK3NFL0Z0VitPUXdlU010UWFKRkRiN1lzZ1N6Tmhy?=
 =?utf-8?B?NFZDZGV3SFlWSXVhQlVPTnVHdE5zckNHYnZkTE8xajNpcGV2SGxpYkhlcTZ4?=
 =?utf-8?B?ak52U3Q3OHhNeFM0bG41UVg2TGM2NHhIV1pFT01HV0NFMUZVcUVKVVJBV1hP?=
 =?utf-8?B?R0YxY1B0U1d5eXRGK2F6cTExSGM5YnFsemp6ZjFPaFI0TzlUU1I0c2ppazFl?=
 =?utf-8?B?RUFGUWVjYk9IZUpnOVBvN1JlamFCOWJsVlRVQ3VXZUhEbncrbjloelFsQVBM?=
 =?utf-8?B?UE0rQndDNU5zbk95WU4yeEYzbWgrU1Y4ck1pdGJtN3RNNGtJaVpEOG5QWDZR?=
 =?utf-8?B?QkVqcFNMSlFOcUNXR0MwbTRRSE5pT1g2NytRbU1sUGhOQUFuTGtjczdmN211?=
 =?utf-8?B?L1U0V0FQYlk0TlRpMlNGRFZVVTYxSW1JU3orMDRQdTcxalpFRzdGQ1cvcElF?=
 =?utf-8?B?U3BtRHRLSHN3U1d0UllmdC9oRk5HYXYzV2FPajFmYm15ZHVFRHhiVVdRYytx?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ea26ab-ad90-49c8-263a-08dd7b541e4c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 12:58:57.3513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6hN9StE77zrYbq4i6+5YnQBlhCCwHl//l3yB5BUt7WJYzU0b7OMj8TDXi4knHhJT5G/krx1nE+29fnq5TYJYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7366

On Mon, Apr 14, 2025 at 02:11:18PM +0200, Jonas Gorski wrote:
> On Mon, Apr 14, 2025 at 1:39â€¯PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> > > $ ip link add swbridge type bridge vlan_filtering 1 vlan_default_pvid 1
> 
> as mentioned for the cover letter, I will fix the example to use
> default_pvid 0 to have a "working" example.

Please do so. You have consistently given examples with vlan_default_pvid 1
throughout the patch set.

> Will add it. And I did check that, even considered shortly to merge this to
> 
>         if (becomes_brentry || would_change)
>                 *changed = true;
> 
> but then considered that a refactoring too much.

I agree that it would be an unnecessary change for 'net'. You can send a
refactoring patch for net-next after Thursday, though.

