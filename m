Return-Path: <netdev+bounces-149672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EA89E6C4F
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 11:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002C028AFEC
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54281FCCFB;
	Fri,  6 Dec 2024 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dT5YE10N"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F41FC110;
	Fri,  6 Dec 2024 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481203; cv=fail; b=Ss1W3HqtSEomUsyVbj3972n8VqJM9drwb5TV4hQYFKqT8B21ZxqqcbCYQj5uRQV45lctE1oZT0JqXR6RU1kgTTE2icyQdDQu5FQ2y+J/fD3ANMik39f4IduaAJnmzx/cxaXXiDOXgphBPMKqPNQTlepvB0pnvnBRzQiXBlOIR9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481203; c=relaxed/simple;
	bh=Io7UoVHWBMBWzrA8Nn54KYMnr4pETmxaku+0dOReZq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hWa+dbHkIqOYA8/vPFmIFC6f0znECDZd0+kXPHfIAGwJRDjWS03jJ40VeDvXGwqt+zVmRTErwWs8578P3vO8uc9xqSBJ+1L5GKUr+Fh5EyoQYYx71cvpITwb8Vj/iQetqsNuZXk9zclxWKJYg6Qg03HbL6oj39Q7FGHCz+LdwUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dT5YE10N; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPvXSQfAbgPJ3377xfTo4ExnP2Aha/WTLIpLTGAGYsRgwYoNMRHlgsTMfJKiQMx+G0P89ev0m/jbipPmHmGXlgrUurlpRSbEgxrNDfQCSC3gFMm/r6UPRQND/dih7qC3GIcihzhv3/NojyGnETcO0eJTW6bMwxxR7GeHPvE35Dt+H9c/F4WkXHq+4y4O6L7XPraIDy+LNBrZ15onmfrxhD1xGJ7zwkY/94QtFmjMxCLNoGnfCVIpCD/cZ2Nk1RoKGkNG8lhhNvFIbIvwWlEf2kofhUDZ42T6LFmCWITMlXUCT7vbcKO/nsboM8Bvbd0fIAYSnQvOd12COwsX9GPakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Io7UoVHWBMBWzrA8Nn54KYMnr4pETmxaku+0dOReZq8=;
 b=hHz88KXmsEqYo5AnJMghprF+HEXPIs1UfizdsPPds7ZzofHM3UINTTc3tvnK2njhvjxlgWvPPk5PFj9Ulfuwis1DquhAGqbN8/BPjhHPTKiQ4drj1BetFFiLRIcO+4jYrC92/uthcX/YI4ddBmEAp2stUQOjWFyCAZcpCn3R2TbzP1/ZBUp3SE7BP26uAzI1qq7NCLBAF1zvVhuaoKSWLXsFGcP8kmgwL3CyJqjQrruGFVAJhQIsKFlqrNTy9TMG7ZQVCbfBYPxyvVlDqyCsNAfB5/AcjgIXpj233K50zeoPm+uCLdSWP7hwUvAS1Kfk4XpnWRhl5GZuJ96YRB4XBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Io7UoVHWBMBWzrA8Nn54KYMnr4pETmxaku+0dOReZq8=;
 b=dT5YE10Ne2xwhD/J/Ru0LmJ6YqXCrgumBFIokMtyIvdaDbApxyUHW2kUzdlstCSgvLrNuoVesGyf09AiQxmwZTeFl/uBGWASBNvXZROM50p7hw6xJyLijw0H8MonzO65DV0+rX7QNfp2SXRfF+8FdNZ3awlLEYses7ol1LXrexfllX6IaiyQ2esUAGF9ZNp1o2NvPlYBG++ERFgxT5XlgsGxnWJDRDCD/aolfl4oohXalrIhMj14ZoT70I89C5UGQenNtK35vgUjAfS/kJEBo3MDbX4OEz34Gi93Grn9ekWCaSDPHNw9VtQb8wWrA0rRRCjDkXv0be9ehX2L0MZ5Pg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9866.eurprd04.prod.outlook.com (2603:10a6:10:4ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 10:33:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 10:33:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Frank Li <frank.li@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v6 RESEND net-next 1/5] net: enetc: add Rx checksum
 offload for i.MX95 ENETC
Thread-Topic: [PATCH v6 RESEND net-next 1/5] net: enetc: add Rx checksum
 offload for i.MX95 ENETC
Thread-Index: AQHbRg+5C4mdptfiA06bM4c11AC4ErLY9OWAgAAMdbA=
Date: Fri, 6 Dec 2024 10:33:15 +0000
Message-ID:
 <PAXPR04MB85101D0EE82ED8EEF48A588988312@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241204052932.112446-1-wei.fang@nxp.com>
 <20241204052932.112446-2-wei.fang@nxp.com> <20241206092329.GH2581@kernel.org>
In-Reply-To: <20241206092329.GH2581@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB9866:EE_
x-ms-office365-filtering-correlation-id: 09e51b8b-1c0a-4f71-8db2-08dd15e16449
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?U0lDeWs4ZkIxV3FoT3h0M3R3MjV4Y3Q3cEl2RUtJNkdmcmh1TmpnKzRtNjRw?=
 =?gb2312?B?WmZWRTdmcy94VWRRVUhOemdFUzVWMFZNNUV4Z0FpdzdDTnJOMnpJL0RieHl6?=
 =?gb2312?B?Mi81MFZ0T0hTZC9SN2VKUklyakFDSzM0VHc0WnREMVphUVlnRmRWRzZUc3Nu?=
 =?gb2312?B?Q2NSemlkc1NteWZJUEk2UnAwN2I3L1lnTzBSUXExd24rRHlacnF1cEdmc3Jq?=
 =?gb2312?B?Rm0wOWV4bEZvWFFmSlRhOVQ3bEk3WjZGaUxzdEMrbWFOYStiNWVOS3djeUsr?=
 =?gb2312?B?S0FydHFqN0JVM1FVb2hiSndqRHlLdVAyYnE5UWYwWW0rRC9mNm5naW9pSGla?=
 =?gb2312?B?bUtoOURZVnE2NnVXNldSV216RjJhemFkQ2daa0d3N24xTnRNVEZTeFZhVUUv?=
 =?gb2312?B?V25DNWVmRkxWRzJybkozbmtWWWVCZDcrM3YxT0ZoMFJGVFRTY1pDRHRQOHFD?=
 =?gb2312?B?eWZGblF4bGI3UFJObWdJYmgwa21ROUJnM096WEFOcjdYTVc4S3lWbXgzbVUz?=
 =?gb2312?B?WDN5bTMwT2xXa0xUblZPZmU3T2VDUVRva1ppR3FzZDRuZ1RmamJFelkrNUU0?=
 =?gb2312?B?alB1Ym51Um1VNW9iSDgxQkE0ZlI1djhZRGZBb0tXdGpVR3lLL2lXZjVjNUh4?=
 =?gb2312?B?T054L21DeFQ4bG9ZYTlSbHMweWNEZEVqZHZSd0J1czl4eElWdlhmbkpPamVw?=
 =?gb2312?B?d3NzcFg3S1puOUt5ZGVXQ0lMWU56Mjk5Z2FFcEdHMWIrQXp4ZVdQT2xWUFR5?=
 =?gb2312?B?bnFXK2R0TGw2WTdSdkE1OE1Qb1pyckVvcWQySzdZYzdodG5zb1hSRlloaHJS?=
 =?gb2312?B?SFRUWmJvWDVVcnpOS1p6MStNSS8rdzF6R20vdDhCUlRnNUVPL1JvemVWbEpQ?=
 =?gb2312?B?YWxNVGN5Z01PbkxhcFMyaE56K2wzNU1xTnZSTTBMOXpqQzJuWlpKNGViTjBV?=
 =?gb2312?B?M2IzTFJKY1Q3SGlUeVhyenphSnNqbHp0OXYxVE92VHNUS0I1OEZoaVMzLzFJ?=
 =?gb2312?B?TmlTSVhKSnl6S2tHRlJYWlRzUFZqa0dvVDBJNk91TU94c3pwWFJVWkdSQWZO?=
 =?gb2312?B?OEM3S1ppV3E2SHk2bHgzVmk5OEh4YTN2eHRpa3Zudmx0Qzh3anUxdUNZNWdE?=
 =?gb2312?B?T0R3Um5Bb0pxSFZwS25aeW1MNnJ5N3dGUXFsYkFGckFXZXdSTllkcU5MdFJn?=
 =?gb2312?B?L3dRS3RQVytDSFA2bzR3Z00zSW1Fa25HdW4vMC9LaHB2ZjVYdDVrTTc2Tm5o?=
 =?gb2312?B?NVhDem1VU21kaERURmwrbUdnTWhXZkswSTRLdFFNUloyeTdWNnVwUW16YVMr?=
 =?gb2312?B?WHlsVk9CV2lWbzZOZ05EUFA3d3pRMTA5b2UyS0FqMEZIN2JVQzZhVEJ4SFQ1?=
 =?gb2312?B?TG5GM2RRaEtaeDlwSnhBT2dHdUVvRHJ6WlpFL0VLaHZEeVAyNUVXL2JHdzFO?=
 =?gb2312?B?VGhZTnR3UVloYmwrVG8rSkVmRFpQdDFXMjZQTitQc2NtQ0ZYTExtWVljaWw1?=
 =?gb2312?B?U2NNczJheFo1S0RhcTJvbFJOTHRJOGhCVDh4eXFyRy81eGU0aUdDZnBic0Q5?=
 =?gb2312?B?R1pkelpobWljL3VRRmkwS3RXTmdBckRYenUwZmo5R3dCMHFZSUxDQmxlSUhD?=
 =?gb2312?B?eTAzTmR6NkpiYmdlZU8zM2lPcXl2OFc5K2UvY29Dc2xGSUJlQzQzT0ZzWTlY?=
 =?gb2312?B?a1NCSHdMZTdTNlJRRTNsOVJwZ3RhcGtWdTVJOWtTcXFESHFvV3E1WG42ZVQ2?=
 =?gb2312?B?UXF4SXNZRWtCcHR6Y1ViRGRiOVpYYkFGNDFJTHVVbzlRUFVJMTZqT2k4UmRN?=
 =?gb2312?B?ajZQUVR4V3d1V3R4c1ZaWTNpUE9aang1WFMyaVk3Z2Ryd2hZM2dBQzE2bWxy?=
 =?gb2312?B?N3RjeG5ub2NWZ3JqR3d3OXNhTEF5SGpTSXhnc0JIelg5RXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?QUdyNE1EbGtENEFZYVAzcmg0Ry9YNENnNnZ6S1YxZ2FUNk5pZ2RwaXZHMitO?=
 =?gb2312?B?dlBoUEpuR2dFVWxUd2F2eTdhTFA4NHhmK2R6ME5TWmRXRUp1MmIwQUR5MHFy?=
 =?gb2312?B?emhCZ29uNUlmRUpnRkZoMFdGNEtva3JZSXg1UWxqb2tVaEpxaTlDTjJxOE1T?=
 =?gb2312?B?ekNlNWFlQVpZaTFFOVBSWWxwVlJkeHVtMnlobGhydGZWSFpxSGdBZTR6Y0Fh?=
 =?gb2312?B?Nm5Gd2Fzd1VjeFYxU3hXQkxyUEJITlJzQVFDS1ozR3pFVHlOeEhSaDNZc0dt?=
 =?gb2312?B?N1d0cHM0ZjNRY3NVay95VGkvVm4xaW91NFFPRjBzby83Q3BtaGlsTUJ5b1NY?=
 =?gb2312?B?a1ZBcUlLbE5FZmtzT1NsR1VSTTJnTTFWeVl0Y1R4TS9sakNsZ3BucThPRCti?=
 =?gb2312?B?Q29sZU9GNm9jZjZtM2JaQlhZMkt6RTFkdzhJbWtVOURiNzVFcFVCMUVlS2JS?=
 =?gb2312?B?YmtEbGVpNjZvUjZ4dWswWEpYblZPbnhWdnVjYUpHZWdsWE01eGdNb29kWXlC?=
 =?gb2312?B?RWxaNmE0Z1NnVTBmTVlqYnFhVDlWcGEwMHppZjdjNW5aUTBlci8wUVQvekZI?=
 =?gb2312?B?V2RmSDlCZUw2MzB1cGROWncycU84c25ybDVaaHVWY2hjQ3Zqb3p1NjRvdmk0?=
 =?gb2312?B?aXFYbmYvOWR0OFNSckJmdUkwWU1XSlBSZ1pOSzZMT1RFWG81R2ZMNGg0Risz?=
 =?gb2312?B?TzNZZlB1Y2NqWWYzNW9RV1Z0T2s5Y3lIRXd1OFRydks5NjM0VHp0Q3VuVlRo?=
 =?gb2312?B?YzMwVjVjbm12WHU2WWVEY0dseWhxWVFNV2Fid1l0S09zK1N3K2hOSkpyZ0tT?=
 =?gb2312?B?TjZUVHNGcXpSUHM5VEJMSHduYkI3SmUxRGhoNGlFcFNCbittV0hnaERvRXd3?=
 =?gb2312?B?WmFHWGlOM3hKR2t5aHg5cVdLOGpLL3d0ZExBYk9DL1VEUm0vK3BTVzhIaXJk?=
 =?gb2312?B?YUR0dElQYU1iK0RNd1N6UEFRRXJQRGNjdVlRZlQxZkVPWGFoSjJnRDBUaHR2?=
 =?gb2312?B?ZE40R2podWgzWEhzakt1VHRZSzkvSjVEdEQ1d0xiMi8vcEM5YkFZVlVrYmFD?=
 =?gb2312?B?d2RjUk9xWGJNT0haRTFndGpucHRyMmIrRFZ5cGhZcmJ3T2ZYRVlQNUNSNEln?=
 =?gb2312?B?bGlHMVpFNCtuRXpLUkYwZW5Jb1lZcC80TmFVZmRhRzVqTlJBMzlHQkVRdnJy?=
 =?gb2312?B?YXhST0g0Q3NIVStxbHdKbDRtZmV2NVAvMEJhSUYyenRaYjk0YzZ5NHp6TXMy?=
 =?gb2312?B?cGpCZ084a1pNREJNcUROMEljQWNRNk5ScGVqR0NVclV5REtRYU8yQmhqZG9V?=
 =?gb2312?B?VS9uYk9kRk5VZUxBRkpDSXdWYWFhd2N1VzZYYWM2bWdDVWtZVURhYThYMllp?=
 =?gb2312?B?OUs1QmJOcjVleFl4cWo3bEdBb3Y4dXBUbi9UVVhwZDNLVWU4RWxoZy93OTgw?=
 =?gb2312?B?QjNsUGR0TlQwSENvTFJ2eGVNNEYzbHpmbldBb3o5bjVtZDZpOTNSS0VIVkd4?=
 =?gb2312?B?NkJnemxEVVhieXl5L3d0K0dIUjhtNEVJTDVHaiszMTdkSjlGbXUydVNZM3lt?=
 =?gb2312?B?OEJISDJvR0N2Y09KZ0NNWlg1b09JWnJqd0hvL2R5V01RSDdWR3JqUElPaDl5?=
 =?gb2312?B?dUdYNytJZ3hyTHhOcE0wNWJFOFpZcVhVM0N4b0VzblRRaSt1cFFLS3ljQnVR?=
 =?gb2312?B?K09kQVRSMFYzRERhQjFzQ1YrNU1vM1BHa2M0NW55azRBRmpqVWRsSnI1QUZD?=
 =?gb2312?B?Yzg2WDlFdFhDcmN1U1h0RjNjblVrYk4wNzNKNGlGeHk0WDlBTEdacUVMV29S?=
 =?gb2312?B?SXBDdFIwRUpLZERCSUVKTk1sYlhiMkdQRE53UzVTaEptc2NqODBWVDA0NW5G?=
 =?gb2312?B?UUwrNXRsZjNIdm5JZUJIUmFzZnlTQkFqeEtrN0pheFExRnhENDQrOVpUNWtV?=
 =?gb2312?B?UE5aV0krVVY5RUp5OWRCV0lPNytqNWlGR2s2b2pHQzlrYlQ3RG45Q0J1b0ZM?=
 =?gb2312?B?dmV5YjFzZ3I1YzU1dGhNYy9nTktSVGhEcDV5Wjh5TXUyWjlKZWtSc0FBZm9a?=
 =?gb2312?B?Yy9LdENzYUpCVHVZakg4ZCsvZ1NZeHNHd2FUVHlhdlNYUnhFR2ZZbHNXZnUr?=
 =?gb2312?Q?DwxU=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e51b8b-1c0a-4f71-8db2-08dd15e16449
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 10:33:15.0595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ol8ToNhCCObL9s+ZGwAmrCIw6V8UEQNfo2DCh8GOEkU05EiLnFc7/VK+l+A+xAObgQuiegtFdZRhxT66j3s8VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9866

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaW1vbiBIb3JtYW4gPGhvcm1z
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTE6jEy1MI2yNUgMTc6MjMNCj4gVG86IFdlaSBGYW5n
IDx3ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogQ2xhdWRpdSBNYW5vaWwgPGNsYXVkaXUubWFub2ls
QG54cC5jb20+OyBWbGFkaW1pciBPbHRlYW4NCj4gPHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPjsg
Q2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsNCj4gYW5kcmV3K25ldGRldkBsdW5u
LmNoOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOw0KPiBrdWJhQGtl
cm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47
DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGlteEBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiBSRVNFTkQgbmV0
LW5leHQgMS81XSBuZXQ6IGVuZXRjOiBhZGQgUnggY2hlY2tzdW0NCj4gb2ZmbG9hZCBmb3IgaS5N
WDk1IEVORVRDDQo+IA0KPiBPbiBXZWQsIERlYyAwNCwgMjAyNCBhdCAwMToyOToyOFBNICswODAw
LCBXZWkgRmFuZyB3cm90ZToNCj4gPiBFTkVUQyByZXYgNC4xIHN1cHBvcnRzIFRDUCBhbmQgVURQ
IGNoZWNrc3VtIG9mZmxvYWQgZm9yIHJlY2VpdmUsIHRoZSBiaXQNCj4gPiAxMDggb2YgdGhlIFJ4
IEJEIHdpbGwgYmUgc2V0IGlmIHRoZSBUQ1AvVURQIGNoZWNrc3VtIGlzIGNvcnJlY3QuIFNpbmNl
DQo+ID4gdGhpcyBjYXBhYmlsaXR5IGlzIG5vdCBkZWZpbmVkIGluIHJlZ2lzdGVyLCB0aGUgcnhf
Y3N1bSBiaXQgaXMgYWRkZWQgdG8NCj4gPiBzdHJ1Y3QgZW5ldGNfZHJ2ZGF0YSB0byBpbmRpY2F0
ZSB3aGV0aGVyIHRoZSBkZXZpY2Ugc3VwcG9ydHMgUnggY2hlY2tzdW0NCj4gPiBvZmZsb2FkLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4g
UmV2aWV3ZWQtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5
OiBDbGF1ZGl1IE1hbm9pbCA8Y2xhdWRpdS5tYW5vaWxAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiB2
Mjogbm8gY2hhbmdlcw0KPiA+IHYzOiBubyBjaGFuZ2VzDQo+ID4gdjQ6IG5vIGNoYW5nZXMNCj4g
PiB2NTogbm8gY2hhbmdlcw0KPiA+IHY2OiBubyBjaGFuZ2VzDQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5jICAgICAgIHwgMTQgKysrKysr
KysrKy0tLS0NCj4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2VuZXRj
LmggICAgICAgfCAgMiArKw0KPiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5l
dGMvZW5ldGNfaHcuaCAgICB8ICAyICsrDQo+ID4gIC4uLi9uZXQvZXRoZXJuZXQvZnJlZXNjYWxl
L2VuZXRjL2VuZXRjX3BmX2NvbW1vbi5jIHwgIDMgKysrDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwg
MTcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGMuYw0KPiBiL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5jDQo+ID4gaW5kZXggMzU2MzRjNTE2
ZTI2Li4zMTM3YjZlZTYyZDMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQv
ZnJlZXNjYWxlL2VuZXRjL2VuZXRjLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9m
cmVlc2NhbGUvZW5ldGMvZW5ldGMuYw0KPiA+IEBAIC0xMDExLDEwICsxMDExLDE1IEBAIHN0YXRp
YyB2b2lkIGVuZXRjX2dldF9vZmZsb2FkcyhzdHJ1Y3QgZW5ldGNfYmRyDQo+ICpyeF9yaW5nLA0K
PiA+DQo+ID4gIAkvKiBUT0RPOiBoYXNoaW5nICovDQo+ID4gIAlpZiAocnhfcmluZy0+bmRldi0+
ZmVhdHVyZXMgJiBORVRJRl9GX1JYQ1NVTSkgew0KPiA+IC0JCXUxNiBpbmV0X2NzdW0gPSBsZTE2
X3RvX2NwdShyeGJkLT5yLmluZXRfY3N1bSk7DQo+ID4gLQ0KPiA+IC0JCXNrYi0+Y3N1bSA9IGNz
dW1fdW5mb2xkKChfX2ZvcmNlIF9fc3VtMTYpfmh0b25zKGluZXRfY3N1bSkpOw0KPiA+IC0JCXNr
Yi0+aXBfc3VtbWVkID0gQ0hFQ0tTVU1fQ09NUExFVEU7DQo+ID4gKwkJaWYgKHByaXYtPmFjdGl2
ZV9vZmZsb2FkcyAmIEVORVRDX0ZfUlhDU1VNICYmDQo+ID4gKwkJICAgIGxlMTZfdG9fY3B1KHJ4
YmQtPnIuZmxhZ3MpICYgRU5FVENfUlhCRF9GTEFHX0w0X0NTVU1fT0spDQo+IHsNCj4gPiArCQkJ
c2tiLT5pcF9zdW1tZWQgPSBDSEVDS1NVTV9VTk5FQ0VTU0FSWTsNCj4gPiArCQl9IGVsc2Ugew0K
PiA+ICsJCQl1MTYgaW5ldF9jc3VtID0gbGUxNl90b19jcHUocnhiZC0+ci5pbmV0X2NzdW0pOw0K
PiA+ICsNCj4gPiArCQkJc2tiLT5jc3VtID0gY3N1bV91bmZvbGQoKF9fZm9yY2UgX19zdW0xNil+
aHRvbnMoaW5ldF9jc3VtKSk7DQo+ID4gKwkJCXNrYi0+aXBfc3VtbWVkID0gQ0hFQ0tTVU1fQ09N
UExFVEU7DQo+ID4gKwkJfQ0KPiA+ICAJfQ0KPiANCj4gSGkgV2VpLA0KPiANCj4gSSBhbSB3b25k
ZXJpbmcgYWJvdXQgdGhlIHJlbGF0aW9uc2hpcCBiZXR3ZWVuIHRoZSBhYm92ZSBhbmQNCj4gaGFy
ZHdhcmUgc3VwcG9ydCBmb3IgQ0hFQ0tTVU1fQ09NUExFVEUuDQo+IA0KPiBQcmlvciB0byB0aGlz
IHBhdGNoIENIRUNLU1VNX0NPTVBMRVRFIHdhcyBhbHdheXMgdXNlZCwgd2hpY2ggc2VlbXMNCj4g
ZGVzaXJhYmxlLiBCdXQgd2l0aCB0aGlzIHBhdGNoLCBDSEVDS1NVTV9VTk5FQ0VTU0FSWSBpcyBj
b25kaXRpb25hbGx5IHVzZWQuDQo+IA0KPiBJZiB0aG9zZSBjYXNlcyBkb24ndCB3b3JrIHdpdGgg
Q0hFQ0tTVU1fQ09NUExFVEUgdGhlbiBpcyB0aGlzIGEgYnVnLWZpeD8NCj4gDQo+IE9yLCBhbHRl
cm5hdGl2ZWx5LCBpZiB0aG9zZSBjYXNlcyBkbyB3b3JrIHdpdGggQ0hFQ0tTVU1fQ09NUExFVEUs
IHRoZW4NCj4gSSdtIHVuc3VyZSB3aHkgdGhpcyBjaGFuZ2UgaXMgbmVjZXNzYXJ5IG9yIGRlc2ly
YWJsZS4gSXQncyBteSB1bmRlcnN0YW5kaW5nDQo+IHRoYXQgZnJvbSB0aGUgS2VybmVsJ3MgcGVy
c3BlY3RpdmUgQ0hFQ0tTVU1fQ09NUExFVEUgaXMgcHJlZmVyYWJsZSB0bw0KPiBDSEVDS1NVTV9V
Tk5FQ0VTU0FSWS4NCj4gDQo+IC4uLg0KDQpSeCBjaGVja3N1bSBvZmZsb2FkIGlzIGEgbmV3IGZl
YXR1cmUgb2YgRU5FVEMgdjQuIFdlIHdvdWxkIGxpa2UgdG8gZXhwbG9pdCB0aGlzDQpjYXBhYmls
aXR5IG9mIHRoZSBoYXJkd2FyZSB0byBzYXZlIENQVSBjeWNsZXMgaW4gY2FsY3VsYXRpbmcgYW5k
IHZlcmlmeWluZyBjaGVja3N1bS4NCg0K

