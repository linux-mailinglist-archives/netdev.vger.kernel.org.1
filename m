Return-Path: <netdev+bounces-152052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FEB9F2883
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 03:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56E417A1270
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 02:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D7613D244;
	Mon, 16 Dec 2024 02:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y820JUoV"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2075.outbound.protection.outlook.com [40.107.241.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9178F13C8EA;
	Mon, 16 Dec 2024 02:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734316176; cv=fail; b=eQMZnHjhvEixVROuM3mSzXopCa9mUtBY1d1axyHx3vNxcc31Mt923uLATFS9JwIbObO+BsR5IEauXxzb/rkSgNB+NnmAq7czcq7hbXnM9gSeh15ueQxn9RUSBhOJZcayqP1xlKJYURU06g6Bol9bQEQ0OzMfrQVHwhkpJ8T3iZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734316176; c=relaxed/simple;
	bh=pRoayN3lGYP1jwLrgAadBeSfgdVpbZIazKo+zy46F2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=umfNKTVlfPh/ZxAZP7E+z9aLpkMwWfmKSaChC+sfjgkzGxMDKmfLWyFjTqSWyEJNp67nHfBQHZ9RP9xKQoqUXq4Lvo/JMpy8FiU9LP3PoTK6r+bbODwTRZbTggA0V1FpRbqBZi59S7OCehMdWa/wVxfyG7+A1wgFdWpMTDTJHTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y820JUoV; arc=fail smtp.client-ip=40.107.241.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZm+0lENBFE6vqHl4+zwFgxmli2AexWcLP1UZ2nYo2sgQbzu+frEWchuifIEejQhqzQ8nh/RaILlpQsKY7XhAGMgSfexAThqdflf0kXd+EXMFmPuFUUAQXQKGeTvT1Snv3/JCy7K9j3dqZNTvjcdM8pJ6lBH6BnFeZpVyJ7X9JSr+UPxBEf/BQLLx3wzOmEbHzFpPv3Jk1s/NafTUpMaRXER6fhBcamBwOyWgvorAPDjsUdQG25YQ0zLuQs5t05KkWMzRlgbCZXf4lBbYB7NHVRuEUL5QI2BuO76MLLdAZbRnTnGRalftSfcwgpdW2WmIt4gbW7zSnw5CS0EsG1JOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRoayN3lGYP1jwLrgAadBeSfgdVpbZIazKo+zy46F2U=;
 b=wvIbbjHetbKLgJoSb2agqjztV8SXIr5hp1WLQqZfnGMSK4/UVu4n6A4JGUYiKcQjA6tNv9UVj7SL7GK5v4KZBG6J8Hrk+YB50DGCAVNKbygo1LxCYdEd3azl8feTNyoiSEDRWOT5A59uBQ5RvTfpbciX5TyoutymI5kQVXAzGTVlpPU7Ct1Ebn+8xJU8s9DBcYwvxFeE+fsJ6sxHVC8IRYOEhW4slVRewuYOJOinTP0zI07P+y1ls/FGDlrqEAj7POuiM/CJ7EIPBnJ3UuArLgYg2hBLIDO8Tf8JVaplASGNpdoT107ytixMjYe9UmI80cBHDs6yzVEETFpf4Uiv+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRoayN3lGYP1jwLrgAadBeSfgdVpbZIazKo+zy46F2U=;
 b=Y820JUoV6OUXmRoYb4bE497+POx5hht/VLWR0rqMgSOABiisU2snHq+FittUPs7XuISXktnh0FQ5QDzOqO+Bzs6qDE+d95AqUdQ7nVmvx11+VXzS8wTZ+b5594aScNxE2jC0YPZ8qolsp2qTjvblzrJtCXXC4HE8ZkZbuVt86wKcwOQFDgR6U05GP+mNtctrS6isvn5vysRTXheZxKL+DA9K/RkPaG0NPlSDLUfu8qkTRvsUKQoXOIrpEIn02KRYeu2jVXhLviWkW7a1qNkK4w5LvfRtWMY+2VQO5IvRi6eoFqgM8A6rx7m22JOudPGT0JWJBQju5+wvSUJF9W7dfQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB9512.eurprd04.prod.outlook.com (2603:10a6:20b:40f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 02:29:31 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 02:29:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>,
	"heiko.stuebner@cherry.de" <heiko.stuebner@cherry.de>, Frank Li
	<frank.li@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v4 net] net: phy: micrel: Dynamically control external
 clock of KSZ PHY
Thread-Topic: [PATCH v4 net] net: phy: micrel: Dynamically control external
 clock of KSZ PHY
Thread-Index: AQHbS5+I10H4FCra30ywehW5f/pprbLkAL8AgAQdycA=
Date: Mon, 16 Dec 2024 02:29:31 +0000
Message-ID:
 <PAXPR04MB85106B8C8B32C92085642A68883B2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241211072136.745553-1-wei.fang@nxp.com>
 <73d5ea2b-8cec-46e9-80a9-a7a96657c2d4@lunn.ch>
In-Reply-To: <73d5ea2b-8cec-46e9-80a9-a7a96657c2d4@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB9512:EE_
x-ms-office365-filtering-correlation-id: 7c7bf401-a8ce-4067-de9b-08dd1d7978c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?Q0MzcGM0MDRLZUxhYkhDd3dEQzdpVGlEc0xCMFZnbnRXY0ZmdXYydlg3YUpX?=
 =?gb2312?B?SGpFczUwWlNrSFRVSnF3bUxOQU5zNkI0cEViNjI3TVh1aXJ3cGQyMW9ObkRU?=
 =?gb2312?B?elZPTjhVckJsV2xjVlFNcmJud0RqSDlEM2xGT1U1UUJXUHNaUWdhdVNSUklF?=
 =?gb2312?B?UEdQZllSVWpyeHhxN09sdjZ6SVpBR3luZ1NIQXQ4U0xCNTNyaitMK2NoOWJ1?=
 =?gb2312?B?VWF3eENSU3d2TWZiYWtaQzJZY2xpSkh4Y0NaRDRCZlMxT1RXVHI4OWJWdDNU?=
 =?gb2312?B?anNsck9lbGJXSkFGdnBFZFdxSEhzZHMza3Q5TnNuNzVDRFdHeHRyUFRTWTdq?=
 =?gb2312?B?bUhrbkhiOXN4Skk5WmpyUG5sUE1yZE9vd2J6dzZDdGltU1RkeVExQ0lDTjRV?=
 =?gb2312?B?Zm5xK1pRSEZHQTFPV3JHa280amZURnBOb3daajJIVzVtK2NuaU9TcG9oR1JF?=
 =?gb2312?B?OHovS3BnbittUmxBams3V2xMbU9vZkprUzZqOWJEVkRUdEdFUEE4Q0d1ZFly?=
 =?gb2312?B?Ull2ZDZwS2IrZ3V3Vm1XOTVxUnBZQW9ka0xyRWtEckpaV1ZMTW5Wei9WeHhm?=
 =?gb2312?B?dHIwL2xtMGJiYXExWGE3aHdNaXlUNFVQazUrb0dSUHhpUHhxQWFiejdLQWEz?=
 =?gb2312?B?UUZ6enEvTEQrN2Zhb1BXS3RrbFV0cXgwVkRWeTZ2WGNSdU1QYnd5bDNzbmlu?=
 =?gb2312?B?TzdLNzhsU1dFYmI0YlVBaXB5bWkyVWdQQ3RBeDgwaTVlZFF3S0piTTlBcTZX?=
 =?gb2312?B?RHhIQWpFeHhBNDhLTEdscWdVdFRkYnZ5UzRtOHJNQTV3cFpaU1d5dHkyZEt5?=
 =?gb2312?B?WXlkSTJWMFlxVVBLVncrYXIvOGtqbDhFWWFVMkdyVk9OaVZGT2NWcHllZTFV?=
 =?gb2312?B?N1kyakh3RzZ1S0pZaFliZGU2VCt2M3I0bmcyTk05YUo0aldVMVc0QkV2SzlB?=
 =?gb2312?B?bFNHZVdLcWw1Ulg2U2NaVXlGemJodGh0Y202K1VhL01Vc05ibnQ4RmY3ZGU0?=
 =?gb2312?B?VzFCR2RncWt4VWVUTXVHUW9GSmpMSC9qSnFuUHNORnJuQ2ZxaGFBdzRGUHA0?=
 =?gb2312?B?Q3AxWFdLcXhmSWEvMzZpaGhIc1RtUFlGQmNUYitpTXoxQTM2K3hkclpGZDky?=
 =?gb2312?B?emFzdHVVb2R5L0lPaCtoMXlDUHU4ZndyNXAwNVdVcXFLVVhGOWhmQVpjdWNG?=
 =?gb2312?B?RGNhT2tQb0VnNWt4dG1xMWkzNVp5cEtpMHVrdXJPQlBMdWJjamNRR2xBa2Jj?=
 =?gb2312?B?cmdFNWh5R1dQZ1NKU2xTOHNOdjBXSDV6OE05RGdtWHp2Y3JJVnE2bStTYjFq?=
 =?gb2312?B?ZHZYekxkRFZHRHNJdWdXRDZJaG9MNldWSlVpc3E0dkRCR0srd3kxQkRhd1lk?=
 =?gb2312?B?dzJhazEzUUZJaUJWQjNuTnJLSTd6aHQ2aTEwSzFuY2hNQjUxVURMMkQyNllW?=
 =?gb2312?B?akc4TTE0RGg2ZDd2YU5jaER1MDR5dklIVHlhakJqNnRjNmhuMXpKcU5rL2N0?=
 =?gb2312?B?WUJOanpNMnJsM2VSaDdmKy9mTGk3dnBuU1V0dVNjaXJNcnU5WWRiWUNvejJX?=
 =?gb2312?B?SEQ2WENDZnJSSVFlN2c1RGY4cXVOTEdlVW0ydVprL0dFNW5CdnNIYXlCOXFU?=
 =?gb2312?B?WGgwUTBEUFpFdTF0SFhHU0ZXRlhpZzJha1V2VW5CNjB1b3lQYkZSNVNuUUFW?=
 =?gb2312?B?RC85MGpNQnNTY2ptaks3MHpBeEVpeEJmMzNrVERGQys4cnlmRXNlZm5wY1Nk?=
 =?gb2312?B?bEFuUkw4d2hDSTBlLzdvbzF3ZFhiK2hMNFVBRm9mczJ0eUg2TFUwbFVCUHoy?=
 =?gb2312?B?WXcrTDZlMzFEVUNmb3R5YkM5WG5CQWxWQ3V6NnZ2U25aVzRPck1ITDlGM1Ew?=
 =?gb2312?B?NDhjTVhqeDhYdkdlLzc1V2QzMUxXRkErMXFmRnZoU0pkL2xlZzhGUWN6aFpK?=
 =?gb2312?Q?OFBpMJeO91UUy44dScASdF7PnBWleyRg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VWNqMlhzNG9VbFRmY2NPaE50UlFDM0NlbFZjUmRPZC9ONUlzL0F3alNLVTFa?=
 =?gb2312?B?UU0xNGdNQVpyT256b2p1OFBDRmtKRXUybmQ3OGwwR3diTmt1Ry9wbzlIbmlX?=
 =?gb2312?B?WkZVRW44MW92RXpjZ3Y1OFZ4eHQwTHZZSHhMdUNPNTVlNFM2eEtBN0ZCTzFW?=
 =?gb2312?B?bmxqNUZjWjIyUHY3QjN1SXhnS0tpd2hHL2s0T2lUUmttOS9OdlZ4M0UwV21h?=
 =?gb2312?B?RGczQW1Bb0o5S1BjZFNsVGg2dTdWdlpPd2tYOS9hSHVGRld2M1NjNmhjZVpJ?=
 =?gb2312?B?OFhFSTBJOUY3K2pZTW9NL25aSU4xckxscUdSdTk3WERuc0ZnWW15SldBNE5i?=
 =?gb2312?B?ZGMySFF3aHFTdlpPUlFWTG5NWStRZkY3V3NKeXFEMTNDT1ZyMmRpeXdrWjMv?=
 =?gb2312?B?Kzc0VUNESnBxREQyb3c0ZmV3RzJQOGpyZFV3RmEvc1JHZVJOdWRqUUY3SUdz?=
 =?gb2312?B?OEFpYXdxbndjbDYxUThrRGl2dThkS3JQLys4U3VQRFF1U3Z0TXF3MzA3THYx?=
 =?gb2312?B?UnBXYlJEb2hGb3Focnlrc0pDWFJKdEVsekljTks5aGtSWVhOM0loTFdzTWdu?=
 =?gb2312?B?dkJ3Sy9KejdQRmhaZTBnYlZMb3dwa1VuS1lTQTNUOHJuaHhZVWp6aC9vbW01?=
 =?gb2312?B?WjNydVdMaXoxd21pcElZdnZYT0lSNHN2VnRDaDdiWlNTT29RdGU1OVBBamI1?=
 =?gb2312?B?YzNrQjlTY3cyYkZWNERHbGtNcE12MFlrSTFGdFZhSmdBbGpLZ2xlQ2JWK1kv?=
 =?gb2312?B?ZUR2cDZEVktZZldheElMcGpqaXZkMkE5d1A3UURZMUpZaVpsTlhpTUJVbmlQ?=
 =?gb2312?B?alcySjkwdGJUVGkzUnQ2b2E2aHQvUGRUUG04VXJUYjRLa2R5MHh0RkdtemZi?=
 =?gb2312?B?UkdSaFlnODUxVTBLbjFPbGhQVkhXZ2VZNHFiYjZtN0hTU1BhN0IzM0xzUy8w?=
 =?gb2312?B?SjJOeVNhejhqeER6UmYxN3ZtOTdVNWM4cDJSYzVCVEZQM0FrNHRISlJOZEh4?=
 =?gb2312?B?dUdiMzFnVlUvZGtncU8vYmFoZkNkMURsZDZld1NjWndoS09EYVBiRnhRK2VX?=
 =?gb2312?B?YWliYU1xM1J5akpyMngzbEJMR3g3MjMxUEV5M0lzV3FWT0dpUWdUQUswMk1S?=
 =?gb2312?B?WjlCU1JQOU9zd2pnZVo4UlBPaDVrcWlaSGszVWNFaElueHo1MFc0M1ljeU9B?=
 =?gb2312?B?c0Zkb2F1UzVnL2xKZXNta3ZIQlBOa2lwV0RDZTloc1dBUkFXWWpXenpFMkQ1?=
 =?gb2312?B?SzZrMmNLbFNFT1ZNc2dNbWs2VjdNZGhvamwyYVkwMjJBbDFoN2dsOUo1K1la?=
 =?gb2312?B?WFRVQ0F5bzZKMXJMTHJYQlp6dVR0eFRBNno5SDVtM3F1cjNIR0U4THpJb2xu?=
 =?gb2312?B?VUgzUmFsTjRzYXh1KzNTK1kvMTY5UFJhalFUTmZyTk5wYW52UlRmcnNNeSsr?=
 =?gb2312?B?YUk3UGJXRGVramlXNjcxbFBjS1p2WW0zZ1VCTVlnVFNLdHFBZ2dtaTBwV3BB?=
 =?gb2312?B?NWpLTHlWQlM3ZVlXeDRsbFRFWURFREhGdlhQemd1NkdZSU9HUWtDcjBHdTZE?=
 =?gb2312?B?UGNNUTNJRVFuMlFNakZwbS9ueU9TVG1pTVpDdVA4ZDZUMWIyNXlXUEFZcll2?=
 =?gb2312?B?aW5WZnB3Ym5sSWZIM2MrdWdDYzZNUFNrUHh3RzJRSkI0cEc2a1ZMSnN5NURY?=
 =?gb2312?B?NkNsbmVIeUV2cWFSQkdkcnpRclpaSFJWUTFvSnM1UnpDamtUeHZ1SkFCQS9V?=
 =?gb2312?B?SWpzTkZ3K3NQMjFIQ05XUlMvM2RzRndBM3Y3ZGxxMGN5U3g5VTFXSmtQam9t?=
 =?gb2312?B?aE1xMEFGWE1nNU4xSVJLd3lsYlNaRUEwODY5Z0syUHFjVW85NGxLRTh6NTB6?=
 =?gb2312?B?OWYyRW9uSTVsSFhSV05Jb0wwZi80encxWVdEQzZXZkw1VWdaMGRDQnZHZnhZ?=
 =?gb2312?B?dms2d3BJb0ZseUpvdkVtbXptTGE1T04yT2tMYzNLdjc5dVhhUnBvVFRJbk9W?=
 =?gb2312?B?eGNVMER3eG0yVlRrNHhjclRUSFYrcCtuZEFPLzNTWklRRktHcUphTXNJOEZK?=
 =?gb2312?B?K1NNZGpQdmJYWUpjT3QxbmZSTDJrSmFWOXFrSmZFNzhzdVR2clBsYVFjYjZH?=
 =?gb2312?Q?g+qU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7bf401-a8ce-4067-de9b-08dd1d7978c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 02:29:31.0931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +zosYPnOOuz1xa63iBZll5OJTPJ6BePlt8Y2mX/v6x5yrVVmpFISRn+02SUQ92BoudfTM9Kr9grkCzAPCtK0xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9512

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+IFNlbnQ6IDIwMjTE6jEy1MIxM8jVIDE4OjQ1DQo+IFRvOiBXZWkgRmFuZyA8
d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IGhrYWxsd2VpdDFAZ21haWwuY29tOyBsaW51eEBhcm1s
aW51eC5vcmcudWs7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7DQo+IGVkdW1hemV0QGdvb2dsZS5jb207
IGt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207DQo+IGZsb3JpYW4uZmFpbmVsbGlA
YnJvYWRjb20uY29tOyBoZWlrby5zdHVlYm5lckBjaGVycnkuZGU7IEZyYW5rIExpDQo+IDxmcmFu
ay5saUBueHAuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHY0IG5ldF0gbmV0OiBwaHk6IG1pY3JlbDogRHluYW1pY2FsbHkgY29udHJvbCBleHRlcm5hbA0K
PiBjbG9jayBvZiBLU1ogUEhZDQo+IA0KPiA+IFRvIHNvbHZlIHRoaXMgcHJvYmxlbSwgdGhlIGNs
b2NrIGlzIGVuYWJsZWQgd2hlbiBwaHlfZHJpdmVyOjpyZXN1bWUoKSBpcw0KPiA+IGNhbGxlZCwg
YW5kIHRoZSBjbG9jayBpcyBkaXNhYmxlZCB3aGVuIHBoeV9kcml2ZXI6OnN1c3BlbmQoKSBpcyBj
YWxsZWQuDQo+ID4gU2luY2UgcGh5X2RyaXZlcjo6cmVzdW1lKCkgYW5kIHBoeV9kcml2ZXI6OnN1
c3BlbmQoKSBhcmUgbm90IGNhbGxlZCBpbg0KPiA+IHBhaXJzLCBhbiBhZGRpdGlvbmFsIGNsa19l
bmFibGUgZmxhZyBpcyBhZGRlZC4gV2hlbiBwaHlfZHJpdmVyOjpzdXNwZW5kKCkNCj4gPiBpcyBj
YWxsZWQsIHRoZSBjbG9jayBpcyBkaXNhYmxlZCBvbmx5IGlmIGNsa19lbmFibGUgaXMgdHJ1ZS4g
Q29udmVyc2VseSwNCj4gPiB3aGVuIHBoeV9kcml2ZXI6OnJlc3VtZSgpIGlzIGNhbGxlZCwgdGhl
IGNsb2NrIGlzIGVuYWJsZWQgaWYgY2xrX2VuYWJsZQ0KPiA+IGlzIGZhbHNlLg0KPiANCj4gVGhp
cyBpcyB3aGF0IGkgZG9uJ3QgbGlrZSB0b28gbXVjaCwgdGhlIGZhY3Qgc3VzcGVuZC9yZXN1bWUg
aXMgbm90DQo+IGNhbGxlZCBpbiBwYWlycy4gVGhhdCB3YXMgcHJvYmFibHkgYSBiYWQgZGVjaXNp
b24gb24gbXkgcGFydCwgYW5kDQo+IG1heWJlIGl0IHNob3VsZCBiZSByZXZpc2VkLiBCdXQgdGhh
dCBpcyBvdXQgb2Ygc2NvcGUgZm9yIHRoaXMgcGF0Y2gsDQo+IHVubGVzcyB5b3Ugd2FudCB0aGUg
Y2hhbGxlbmdlLg0KPiANCj4gPiArc3RhdGljIGludCBrc3o4MDQxX3Jlc3VtZShzdHJ1Y3QgcGh5
X2RldmljZSAqcGh5ZGV2KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3Qga3N6cGh5X3ByaXYgKnByaXYg
PSBwaHlkZXYtPnByaXY7DQo+ID4gKw0KPiA+ICsJa3N6cGh5X2VuYWJsZV9jbGsocHJpdik7DQo+
ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQga3N6
ODA0MV9zdXNwZW5kKHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYpDQo+ID4gK3sNCj4gPiArCXN0
cnVjdCBrc3pwaHlfcHJpdiAqcHJpdiA9IHBoeWRldi0+cHJpdjsNCj4gPiArDQo+ID4gKwlrc3pw
aHlfZGlzYWJsZV9jbGsocHJpdik7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4g
DQo+IFRoZXNlIHR3byBsb29rIG9kZC4gV2h5IGlzIHRoZXJlIG5vIGNhbGwgdG8NCj4gZ2VucGh5
X3N1c3BlbmQvZ2VucGh5X3Jlc3VtZT8gUHJvYmFibHkgYSBjb21tZW50IHNob3VsZCBiZSBhZGRl
ZA0KPiBoZXJlLg0KPiANCg0KSSBoYXZlIGFkZGVkIHRoZSBjb21tZW50IGluIGtzcGh5X2RyaXZl
cltdLCBtYXliZSBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gbW92ZQ0KdGhlIGNvbW1lbnQgaGVyZS4N
Cg0KLQkvKiBObyBzdXNwZW5kL3Jlc3VtZSBjYWxsYmFja3MgYmVjYXVzZSBvZiBlcnJhdGEgRFM4
MDAwMDcwMEEsDQotCSAqIHJlY2VpdmVyIGVycm9yIGZvbGxvd2luZyBzb2Z0d2FyZSBwb3dlciBk
b3duLg0KKwkvKiBCZWNhdXNlIG9mIGVycmF0YSBEUzgwMDAwNzAwQSwgcmVjZWl2ZXIgZXJyb3Ig
Zm9sbG93aW5nIHNvZnR3YXJlDQorCSAqIHBvd2VyIGRvd24uIFN1c3BlbmQgYW5kIHJlc3VtZSBj
YWxsYmFja3Mgb25seSBkaXNhYmxlIGFuZCBlbmFibGUNCisJICogZXh0ZXJuYWwgcm1paSByZWZl
cmVuY2UgY2xvY2suDQogCSAqLw0KDQo+ID4gQEAgLTIxNTAsOCArMjE5OCwxMSBAQCBzdGF0aWMg
aW50IGtzejk0NzdfcmVzdW1lKHN0cnVjdCBwaHlfZGV2aWNlDQo+ICpwaHlkZXYpDQo+ID4NCj4g
PiAgc3RhdGljIGludCBrc3o4MDYxX3Jlc3VtZShzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2KQ0K
PiA+ICB7DQo+ID4gKwlzdHJ1Y3Qga3N6cGh5X3ByaXYgKnByaXYgPSBwaHlkZXYtPnByaXY7DQo+
ID4gIAlpbnQgcmV0Ow0KPiA+DQo+ID4gKwlrc3pwaHlfZW5hYmxlX2Nsayhwcml2KTsNCj4gPiAr
DQo+ID4gIAkvKiBUaGlzIGZ1bmN0aW9uIGNhbiBiZSBjYWxsZWQgdHdpY2Ugd2hlbiB0aGUgRXRo
ZXJuZXQgZGV2aWNlIGlzIG9uLiAqLw0KPiA+ICAJcmV0ID0gcGh5X3JlYWQocGh5ZGV2LCBNSUlf
Qk1DUik7DQo+ID4gIAlpZiAocmV0IDwgMCkNCj4gDQo+IFdoYXQgYWJvdXQgODA2MV9zdXNwZW5k
KCk/IFRoZXkgbm9ybWFsbHkgYXJlIHVzZWQgaW4gcGFpcnMuDQoNCk9rYXksIEkgY2FuIGFkZCB0
aGUga3N6ODA2MV9zdXNwZW5kKCksIHNvIHRoYXQgaXQgaXMgYSBwYWlyIHdpdGgga3N6ODA2MV9y
ZXN1bWUoKS4NCg0KPiANCj4gPiBAQCAtMjIyMSw2ICsyMjcyLDExIEBAIHN0YXRpYyBpbnQga3N6
cGh5X3Byb2JlKHN0cnVjdCBwaHlfZGV2aWNlDQo+ICpwaHlkZXYpDQo+ID4gIAkJCXJldHVybiBQ
VFJfRVJSKGNsayk7DQo+ID4gIAl9DQo+ID4NCj4gPiArCWlmICghSVNfRVJSX09SX05VTEwoY2xr
KSkgew0KPiA+ICsJCWNsa19kaXNhYmxlX3VucHJlcGFyZShjbGspOw0KPiA+ICsJCXByaXYtPmNs
ayA9IGNsazsNCj4gPiArCX0NCj4gDQo+IEkgdGhpbmsgeW91IHNob3VsZCBpbXByb3ZlIHRoZSBl
cnJvciBoYW5kbGluZy4gSWYNCj4gZGV2bV9jbGtfZ2V0X29wdGlvbmFsX2VuYWJsZWQoKSByZXR1
cm5zIGFuIGVycm9yLCB5b3Ugc2hvdWxkIGZhaWwgdGhlDQo+IHByb2JlLiBJZiB0aGUgY2xvY2sg
ZG9lcyBub3QgZXhpc3QsIGRldm1fY2xrX2dldF9vcHRpb25hbF9lbmFibGVkKCkNCj4gd2lsbCBy
ZXR1cm4gYSBOVUxMIHBvaW50ZXIsIHdoaWNoIGlzIGEgdmFsaWQgY2xvY2suIFlvdSBjYW4NCj4g
ZW5hYmxlL2Rpc2FibGUgaXQgZXRjLiBTbyB5b3UgdGhlbiBkbyBub3QgbmVlZCB0aGlzIGNoZWNr
Lg0KDQpPa2F5LCBhY2NlcHQuDQoNCj4gDQo+ID4gK3N0YXRpYyBpbnQgbGFuODgwNF9zdXNwZW5k
KHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBrc3pwaHlf
cHJpdiAqcHJpdiA9IHBoeWRldi0+cHJpdjsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJ
cmV0ID0gZ2VucGh5X3N1c3BlbmQocGh5ZGV2KTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0
dXJuIHJldDsNCj4gPiArDQo+ID4gKwlrc3pwaHlfZGlzYWJsZV9jbGsocHJpdik7DQo+ID4gKw0K
PiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgbGFuODg0MV9y
ZXN1bWUoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikNCj4gPiArew0KPiA+ICsJc3RydWN0IGtz
enBoeV9wcml2ICpwcml2ID0gcGh5ZGV2LT5wcml2Ow0KPiA+ICsNCj4gPiArCWtzenBoeV9lbmFi
bGVfY2xrKHByaXYpOw0KPiA+ICsNCj4gPiArCXJldHVybiBnZW5waHlfcmVzdW1lKHBoeWRldik7
DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBpbnQgbGFuODg0MV9zdXNwZW5kKHN0cnVjdCBw
aHlfZGV2aWNlICpwaHlkZXYpDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBrc3pwaHlfcHJpdiAqcHJp
diA9IHBoeWRldi0+cHJpdjsNCj4gPiAgCXN0cnVjdCBrc3pwaHlfcHRwX3ByaXYgKnB0cF9wcml2
ID0gJnByaXYtPnB0cF9wcml2Ow0KPiA+ICsJaW50IHJldDsNCj4gPg0KPiA+ICAJaWYgKHB0cF9w
cml2LT5wdHBfY2xvY2spDQo+ID4gIAkJcHRwX2NhbmNlbF93b3JrZXJfc3luYyhwdHBfcHJpdi0+
cHRwX2Nsb2NrKTsNCj4gPg0KPiA+IC0JcmV0dXJuIGdlbnBoeV9zdXNwZW5kKHBoeWRldik7DQo+
ID4gKwlyZXQgPSBnZW5waHlfc3VzcGVuZChwaHlkZXYpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiAr
CQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCWtzenBoeV9kaXNhYmxlX2Nsayhwcml2KTsNCj4g
PiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gDQo+IFRoaXMgY2FuIGJlIHNpbXBsaWZpZWQgdG8NCj4g
DQo+ICAgICAgICAgcmV0dXJuIGxhbjg4MDRfc3VzcGVuZChwaHlkZXYpOw0KDQpUbyBiZSBob25l
c3QsIEkgZG9uJ3Qga25vdyB0aGUgcmVsYXRpb25zaGlwIGJldHdlZW4gbGFuODgwNCBhbmQNCmxh
bjg4NDEsIFNvIEknbSBub3Qgc3VyZSBpZiBjaGFuZ2VzIGFkZGVkIGxhdGVyIGluIGxhbjg4MDRf
c3VzcGVuZCgpDQp3aWxsIGFsc28gd29yayBmb3IgbGFuODg0MS4gT3RoZXJ3aXNlLCBpdCB3aWxs
IG5lZWQgdG8gYmUgcmV3b3JrZWQgaW4NCnRoZSBmdXR1cmUuIFNvIEkgdGhpbmsgdGhlcmUgaXMg
bm8gbmVlZCB0byBtYWtlIHRoaXMgc2ltcGxpZmljYXRpb24uDQpVbmxlc3MgeW91IGFyZSB2ZXJ5
IHN1cmUgdGhhdCB0aGUgdHdvIHBsYXRmb3JtcyBhcmUgY29tcGF0aWJsZS4NCg0KPiANCj4gSW4g
Z2VuZXJhbCwgeW91IHNob3VsZCBkZWZpbmUgYSBjb21tb24gbG93IGxldmVsIGZ1bmN0aW9uIHdo
aWNoIGRvZXMNCj4gd2hhdCBhbGwgUEhZcyBuZWVkLCBpbiB0aGlzIGNhc2UsIGdlbnBoeV9zdXNw
ZW5kKCkgYW5kIGRpc2FibGUgdGhlDQo+IGNsb2NrLiBUaGVuIGFkZCB3cmFwcGVycyB3aGljaCBk
byBhZGRpdGlvbmFsIHRoaW5ncy4NCj4gDQoNCkdvb2Qgc3VnZ2VzdGlvbiwgbGV0IG1lIGltcHJv
dmUgaXQsIHRoYW5rcw0K

