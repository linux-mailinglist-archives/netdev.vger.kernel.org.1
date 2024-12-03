Return-Path: <netdev+bounces-148300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ADE9E10F3
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 02:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F56B23032
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 01:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A1A2E400;
	Tue,  3 Dec 2024 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oVF8IQ87"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8DF17555;
	Tue,  3 Dec 2024 01:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733190555; cv=fail; b=NhW9bWFDe0EcUe1F6GpMvNvphc/h4uZSDAjBVJ4qrqGSHZ5AM59Mjr1PK1oZpVPLR2OyNApU269xZrbHLgKI4hxvOViHbHMJs0hG/JFzUzMXLaiKtytIYJMdx9RIFX0wLvYW3gXw802Kxeq/JUultoNTTqvivFRGiLWWcpQYhUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733190555; c=relaxed/simple;
	bh=M/afy95+z7hhciOoGjn4MZMzBO/QJlSgmG7dfUg8Tu8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LQwQeZxJP9GVY9F3Fbx+7B6tMOHnwTsBFCdeTr+xjFe9C+vDJH6EBBxm2lEmnMVbc++ALOJm/X0+976xw9MXWU2VzWjAq1j5SCKZ8V4Ek8iwS9JOTQBqnTxCY+h/0r++1cvb6/N6qVK0V3HZMvHYMKppA6YjFZCWiVOwaF3jylw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oVF8IQ87; arc=fail smtp.client-ip=40.107.20.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8L1hpODwmvYLfH0LE52499V/PfGOvEFoAkqXTviXaREBrCOVdgFWUe/l1QwQbWCvYQbng+259dU+iV5NN5f0UKoAAv2f8cN3LhHrWUUcr5dSbm9IcgZEG1r7+87dhKv7TXrcDOisz2NerP0OWhf99xJ7lStyszQNc8R90zWgCIY3l0Hd6RCliTEm5Ii4AyHDk8pJJvL3naLxNiGjfdrGVNXoWanJiHtnJzno73qaVYfssw13cvnnW+IOII8vS4X2lZITCu7mK6IWYBLSW0nDb9uKhFpsjHDcdiDU3bE+M0Ar3l7x54voaNXdrM2O618yphZMRstw98ZGKiGTojhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/afy95+z7hhciOoGjn4MZMzBO/QJlSgmG7dfUg8Tu8=;
 b=Gjf0Q8IzE15r/++mR06DSgcVlxC4wPpztXixtcEQIaVyoKBAmmR6PM+5tnCJtgp35D1EUr/4dpftbiIip0BTShkutQZPh5PI6DdnLmcEoPi+zlCJwHgJZDv2VSoImud8FR90AcppZ0pwZsk2t2IkPWwbUVFuHHB8ZsdlOCjxmc9SNmm5LFgXFooh0UcE5FXHgXh/DFUfLqZOjOiR0DqI9cbjLpXwWCIuhz22H6TpJpcd1EZ+TvjaCpiNISxojCXILis2X63nqakEnzFHVjHkkm9EaDstrSr6Af7zLacZSUFjHgUySRe5VXBpRCyHmLdCORU6FLLwSjAY3PQJH2uZcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/afy95+z7hhciOoGjn4MZMzBO/QJlSgmG7dfUg8Tu8=;
 b=oVF8IQ873E861X4sfEz9VYw2SL1MzrpnJzzp38w0I0CsbfxpisOo5kGK7rdPOxXHN/TiTrzsmAhH63qI4OOJW4zg8DqK0p6dkBmFQV9UNN7ITqCyNeVyOVNUO2XA+vNRdsSGK7F6p23HzhOvGr7PYJG8+l5d4azYoURoKJA9xCLcwozOobz5/cxp8Efhk3iNZalDHSVHKEe2QIImwN2mZg/K3IXkMjxcgPIy2M8Xn3wsshsyEq4eyuWs8JnETkCL75JyoSuUbX7Oj3BJ6rIX5Ei7nbVzBUaPVcquQAKRFYFHJpuaAXivZSl5ZjuE2D1D9aOSuYHf4SZWNwY9r6pwKQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 01:49:10 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 01:49:10 +0000
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
Subject: RE: [PATCH v2 net] net: phy: micrel: Dynamically control external
 clock of KSZ PHY
Thread-Topic: [PATCH v2 net] net: phy: micrel: Dynamically control external
 clock of KSZ PHY
Thread-Index: AQHbRJjPwRloLKExskGy9cVwWrKrw7LTCWwAgACwmgA=
Date: Tue, 3 Dec 2024 01:49:10 +0000
Message-ID:
 <PAXPR04MB8510D36DDA1B9E98B2FB77B488362@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241202084535.2520151-1-wei.fang@nxp.com>
 <003d5029-2339-4e18-b632-be35384b2f7a@lunn.ch>
In-Reply-To: <003d5029-2339-4e18-b632-be35384b2f7a@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB8274:EE_
x-ms-office365-filtering-correlation-id: 9183c97b-2940-45bb-3595-08dd133cae78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?NU9SSi9HckhtOUs0Y2VFRldyMklScFJab3p3Q21BUjhBVEZoNDEveUlhS1Zj?=
 =?gb2312?B?S3h0VjVOVWprbW9KV0JRS0tLOGJqcllJWHhKSVJhUmlSUTJsUVpmR1l5dDVp?=
 =?gb2312?B?SXhuUmEwYStMdXk4bUNYdlBvTG1oYndYaXJzNEIxT20wZ05GbnlDVlpQNVZM?=
 =?gb2312?B?aUxuck5UWEVyZHgvWi93L3J1QnJLOWtvODZxbmFmdE1YVnJqcmk4Yjk1SENw?=
 =?gb2312?B?NndQTFg5ZDdNVzNNUHZ5Mm5yMjV2NEpwZTluWmE3b2pxU085TU5BU05EZiti?=
 =?gb2312?B?TTFNSEV2ZGYzS1dRVGtyVE5ZMWxnY0JqeTlCa3QrM3RzTk1CZkZ1NExlOThH?=
 =?gb2312?B?SDlHdUlWZUVHdUVFblgxeEdRL2pCQ2lLWmpvNkF4eDE1S2k5c0NzN0xOTklu?=
 =?gb2312?B?ODk0VE85dWltRENlOVp2OU9OakplWmNWUnRaZUVoRlVmUTJVM0x5UXJTZVVs?=
 =?gb2312?B?RW1GaGpXeTAxQXNpa2lZR1RxUnFac3lLTEVGbHdubnpNQ1Z5bGZRWlZYUXVF?=
 =?gb2312?B?VHJCV3dWOTNMYjJkb2lLU0lVQWJrOXlhYmYyNWJTOUFJS08yMFEyNDdkTC9Z?=
 =?gb2312?B?d3EzK1NnUkl0ejJiZlNrOGpudk0zS09Ob1htVHU5dWtnMTJVRStubnkwMHU0?=
 =?gb2312?B?YVlSbWpENFhBVVlEaGpMbU9jT3pnam5jaFdZZ2V1YUdsN1BhbVhBOEl6NkNC?=
 =?gb2312?B?VkpSMmlaVndpS3hlOW1WV3Q4ZFJxUGhuREtsS282L1NYcjZIQThEVHAwY3RF?=
 =?gb2312?B?MVF4Tlp4Vjh4RzhobGlqakxrYWNvaTFTeFdkRkFWVU5Qd2Jhc1R3SnNlVUxM?=
 =?gb2312?B?bm51ZnhxTlZhU2lQYUIwcFNObGlWSWZZMjZVNEw1QVdrWURPcFVVRVZBZTBJ?=
 =?gb2312?B?QUZoVGlNNkRFakF3QmZzNGJwdC9aQzNScXNlNENDUnhWVWdYbTV0RWFxQWdH?=
 =?gb2312?B?Q1RXd001ZXRZOWZkdXVNMWtKVk9BL0tOam8yYUZpNzNRN2FZTDgwSXQzbnVQ?=
 =?gb2312?B?NkNiWS9ENDE1TlFXSlFYM2YrSXJIQjZsZVZORlV4WTRoSnZNZWxZU1pLWGxT?=
 =?gb2312?B?ZzJlNDVZemUwYXJxU0VTN0xVRDhuWGdxU1J1c3dHdmRLcE03Tm5Mdjh5OGx6?=
 =?gb2312?B?UEwyNVovTS9BUGJGQ3dCeHpoc0pNcXloN3NmR2x0R0tnZm8ra3ZmQklPYU8z?=
 =?gb2312?B?M1g4QjFNbnEwSGFHeUErV1dDbDE4OHd2TFRkNThPNld6VHpUWE1VYWNuOFFy?=
 =?gb2312?B?TTVVeE1PSEx0TEM0VEpac0ErUWhXeGZxMzdoVy9BTm1zV3dubUY5enZ1QWQ5?=
 =?gb2312?B?WElDdWhnNVpVOCt4OFVwYTVKY0gwMXA0YXY2YTJUMlAvVjdhcStwTVp1NzR1?=
 =?gb2312?B?SEwxUERNb053NnNkUXZKb2ZMcWxUVzFWSmJMcEJCKytzNUJscXVYWGtDVmlF?=
 =?gb2312?B?RlBvVE5jUk92d0xXbjJnNTh4aHQ4UlcxL0kwcnNqcGRYaWNzR0RlTW5XMWhU?=
 =?gb2312?B?VmxVY2N6Z2hGa2xnUXpaNUp3Wm1PVm0rVlRPM1dvcVcrM2hkTGxEQ252eFp6?=
 =?gb2312?B?bUszYWpSR0VWTGUyZmFndXM1UVRZZ3RXRVVsZnpQUnkzd2tDMnRNRjJZbnBH?=
 =?gb2312?B?NWozWXc0cHY1bThKZG9kK0tqZVlZZUNRV0FQWkJudEJEK2U2ek5kWHQ0RVl1?=
 =?gb2312?B?SUd2MTg2dVdnWDNDcGJaTFpUSTVvbUI5eXVmQUdWUDQ0UkNnbFNXQlNoU0lt?=
 =?gb2312?B?NlhZdmgwbzNWaThlTW5POEEyY1lhVDZaMVd1Qklqa0VVNXhKVmlqZlN2U05r?=
 =?gb2312?B?WW5CcitoenF3NnJyT1lTTjRTbDZ6alIxbHFjZUQvcnNLTG95clgwc3ZLaURI?=
 =?gb2312?B?bCsrLzh1ZDhrUXpHcGR2czg5TGdCMFQ4VW1yNlR3OVhDV1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?cVZwazJHWXlWbWl3REVGWkRVbUZXeWJBZy8vR2FoTWFYZU5YZWVXLzR2QlpN?=
 =?gb2312?B?blk3bnVlWTQ1Qzl5TDhxSHc2UVRzU0NLQ2tRM05wczVIYXZSeGIrVndUdjVo?=
 =?gb2312?B?L2dFaVBKY2JnNGVHTGk1MmRUalR5aFVDZmlwaFBKQmtCcDFqdUNFR1VqU0dG?=
 =?gb2312?B?S3JaL1kwamhNcVJzYW9FMlhIYi9vZ1Ura0xIcGs1ZnBDOUpVdlZPbEt2RUwz?=
 =?gb2312?B?c0lKK001ZGpDQ3RvY3YyYmVUWlNXUS81bG9NbzRRL0pMQ251NklQK05ZdEhC?=
 =?gb2312?B?ajFjVFJWN2NMazVoZXNmNU1YWElibFZydWYwU3FXSzE2RzJ3ZGJ4MEdNQ2oy?=
 =?gb2312?B?R2JRQ3RYL1lVY1c5UDlwRW5nSG9CTHRFMjA0ajlUVGZObzArNEJlNnJlTS9T?=
 =?gb2312?B?QkZyUjFsUVpoOWVOcngzd3FRMzNhenh3VUVvYS90ZUVDMEFwUml2Nm9EUkZH?=
 =?gb2312?B?UUtzUkgrejVkQktSZ0JuTms4WlduZW5NVEIxSHB4bGJtbUYvQWJUeVNkM3Vz?=
 =?gb2312?B?bHU4dzBNZmRmdWYyejI4czEySUw2VDNSKzZtdVRXa1hGVTN4RkZPYjNOemJV?=
 =?gb2312?B?ZWl2VS8xR0RDeHZqd2Z1MDVEUEJaMHBETjl3R1dXWGhpZnorMXh0aHZ1c01j?=
 =?gb2312?B?VGR4S3dWcUZmQUJGYllwdWxieDZiY2I4QWdIRnE5VU5ZVWlrWTJnWWdkL3Br?=
 =?gb2312?B?bTZKQ0lsNXpWZmViMjh0czJET094cndYL3VtZ2FubDlvSTNSNkJDNVZneW1o?=
 =?gb2312?B?Q3J5aldSRmVZWTFDSUtzSmtoYUxLbTJKL0prQ3JMb3FNOGZlQXdPSjdPb1ZI?=
 =?gb2312?B?ZC9BZ0x4Njk1dEQ3Z2h2Qis1VitIQkRzc2VnZ081cTRCNlM4TDd5bW5yenNx?=
 =?gb2312?B?WUlKMmpGaVEzV2FPY2I4QjltM2VQdjlHeit3VnZnWUFtR3EybmFyVk8waElz?=
 =?gb2312?B?OU9VSWtZaHlqc203bnlkTHNRRlJHN3RDTDVGb2h3dG1rSzJzL2VKM2RyTktr?=
 =?gb2312?B?WWVvWDNCRStnTGtlUExHMGxMQ05Tc1MvSkw1bm9UU0ltUXFKTFJJS25RS3Bh?=
 =?gb2312?B?Rmk0aGdURkw1eE1VTnV6Nmcram0wWFpEcjV0YTcxMFpaZEJIWENZdDgvNnhL?=
 =?gb2312?B?RE1SdnQvT1lCeXY0QmtHNmhYRHM0VVdUTG1CVnlXck9VNkY0QWJCdExZSUhF?=
 =?gb2312?B?UDNMbE9iVzM3RnVmSnc4KzBBbmhPbTFHd3JnZWcxdVVXaFZKVjBRRU9qQnJM?=
 =?gb2312?B?cWdFbUg0cnNwMGQyL1cyaTZDeWV3MDAxa3JPemo5Vld5bndsTkU0Q2RrSDJH?=
 =?gb2312?B?M0gwMTdPTmg0UTVseC8zL1RTa1RYVjFibGZKSU10QnlLQURjam1sdTJwTktl?=
 =?gb2312?B?blNybWdiZlo0b2s2YURWT00rWWswNDlmTWEzRkh6MVZJRzZCVlJ6MU1WWkp3?=
 =?gb2312?B?YnJCaWNIL2xjdmtJL2dpK1dLZVkwOHpLUkRpNmxydm05Q1RyZDdBNHNoT2RI?=
 =?gb2312?B?QUxhaUNKdFFEc0FCdEorZzl0a2ZqaEVzdkcrWm4rUGdtajFmdjZFcmJxNVhF?=
 =?gb2312?B?TkRWYnZ1TWxjdmR3WW1GMTcrMzdDK2k0eG1NemllSW5SWEx6aC92UzNNNzUx?=
 =?gb2312?B?ZTZMQkV6YVhNb0VLbjVnc1E5TldDdHREb2sxc1dmWXBkeTN6dlFreVZRN2NE?=
 =?gb2312?B?ckYxZDArVGxTVUR4czE3ODRMM1NraGR0dVlXektVdXg0eDJqYS9VdjFheWor?=
 =?gb2312?B?VjhnbXVEMC96RGwzaDhMUVJjWWtud21tZUlDc210dXlvQ2VLeU1NMkdCV0p2?=
 =?gb2312?B?am5Lanlwa3JIU09uSjhVenMvcjBXRldJZ2dLUEZXS05KNnU1YkdCSWVFNGh0?=
 =?gb2312?B?a3BXRlIrbXdBS0oxTHRUK0szNW5weTdPTWVSRE1LNXV4MDZUZFEzTkphNnBH?=
 =?gb2312?B?TGN1bFRrcXg0YkdyUkh4SDBmRWl3TXlHZWJQZDNnQ2phNHQ2TW0zVFYvMTBI?=
 =?gb2312?B?dEs3UjRDbTVmeE5CcEJrQjlZMGRxTllHMTY1UHI5VkhJWEV3a3lOSG9TZ093?=
 =?gb2312?B?c28wcWk5YjJWb1JWbHBsdzE2ZUlmUy9LcFVZT1VsWmtMY0Z0aUZ4ZWJMeTB0?=
 =?gb2312?Q?FGYE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9183c97b-2940-45bb-3595-08dd133cae78
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 01:49:10.2040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ziSo34Nf5hcHqNw2XfME51Mcv1IYtfb8ow1ZU4Db2tdvJCM21RiiYzULN/csopDKJVUyo0MfRzM2MdfMKS7MbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8274

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+IFNlbnQ6IDIwMjTE6jEy1MIyyNUgMjI6NDkNCj4gVG86IFdlaSBGYW5nIDx3
ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogaGthbGx3ZWl0MUBnbWFpbC5jb207IGxpbnV4QGFybWxp
bnV4Lm9yZy51azsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4gZWR1bWF6ZXRAZ29vZ2xlLmNvbTsg
a3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsNCj4gZmxvcmlhbi5mYWluZWxsaUBi
cm9hZGNvbS5jb207IGhlaWtvLnN0dWVibmVyQGNoZXJyeS5kZTsgRnJhbmsgTGkNCj4gPGZyYW5r
LmxpQG54cC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djIgbmV0XSBuZXQ6IHBoeTogbWljcmVsOiBEeW5hbWljYWxseSBjb250cm9sIGV4dGVybmFsIGNs
b2NrDQo+IG9mIEtTWiBQSFkNCj4gDQo+IE9uIE1vbiwgRGVjIDAyLCAyMDI0IGF0IDA0OjQ1OjM1
UE0gKzA4MDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+IE9uIHRoZSBpLk1YNlVMTC0xNHgxNC1FVksg
Ym9hcmQsIGVuZXQxX3JlZiBhbmQgZW5ldDJfcmVmIGFyZSB1c2VkIGFzDQo+ID4gdGhlIGNsb2Nr
IHNvdXJjZXMgZm9yIHR3byBleHRlcm5hbCBLU1ogUEhZcy4gSG93ZXZlciwgYWZ0ZXIgY2xvc2lu
Zw0KPiA+IHRoZSB0d28gRkVDIHBvcnRzLCB0aGUgY2xrX2VuYWJsZV9jb3VudCBvZiB0aGUgZW5l
dDFfcmVmIGFuZCBlbmV0Ml9yZWYNCj4gPiBjbG9ja3MgaXMgbm90IDAuIFRoZSByb290IGNhdXNl
IGlzIHRoYXQgc2luY2UgdGhlIGNvbW1pdCA5ODUzMjk0NjI3MjMgKCJuZXQ6DQo+IHBoeToNCj4g
PiBtaWNyZWw6IHVzZSBkZXZtX2Nsa19nZXRfb3B0aW9uYWxfZW5hYmxlZCBmb3IgdGhlIHJtaWkt
cmVmIGNsb2NrIiksDQo+ID4gdGhlIGV4dGVybmFsIGNsb2NrIG9mIEtTWiBQSFkgaGFzIGJlZW4g
ZW5hYmxlZCB3aGVuIHRoZSBQSFkgZHJpdmVyDQo+ID4gcHJvYmVzLCBhbmQgaXQgY2FuIG9ubHkg
YmUgZGlzYWJsZWQgd2hlbiB0aGUgUEhZIGRyaXZlciBpcyByZW1vdmVkLg0KPiA+IFRoaXMgY2F1
c2VzIHRoZSBjbG9jayB0byBjb250aW51ZSB3b3JraW5nIHdoZW4gdGhlIHN5c3RlbSBpcyBzdXNw
ZW5kZWQNCj4gPiBvciB0aGUgbmV0d29yayBwb3J0IGlzIGRvd24uDQo+IA0KPiBUaGUgcmVmZXJl
bmNlZCBjb21taXQgaXMgYSBvbmUgbGluZXI6DQo+IA0KPiBAQCAtMjAwMSw3ICsyMDAxLDcgQEAg
c3RhdGljIGludCBrc3pwaHlfcHJvYmUoc3RydWN0IHBoeV9kZXZpY2UgKnBoeWRldikNCj4gDQo+
ICAgICAgICAga3N6cGh5X3BhcnNlX2xlZF9tb2RlKHBoeWRldik7DQo+IA0KPiAtICAgICAgIGNs
ayA9IGRldm1fY2xrX2dldCgmcGh5ZGV2LT5tZGlvLmRldiwgInJtaWktcmVmIik7DQo+ICsgICAg
ICAgY2xrID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsX2VuYWJsZWQoJnBoeWRldi0+bWRpby5kZXYs
DQo+ICsgInJtaWktcmVmIik7DQo+ICAgICAgICAgLyogTk9URTogY2xrIG1heSBiZSBOVUxMIGlm
IGJ1aWxkaW5nIHdpdGhvdXQgQ09ORklHX0hBVkVfQ0xLICovDQo+IA0KPiBhbmQgaGVyZSB5b3Ug
YXJlIGFkZGluZyAxMDMgbGluZXMgYXMgYSBmaXguIFRoaXMgc2VlbXMgb3V0IG9mIHByb3BvcnRp
b24uIERpZCB0aGlzDQo+IHRydWx5IHdvcmsgYmVmb3JlIHRoaXMgY2hhbmdlPw0KDQpGb3IgaS5N
WDZVTEwtMTRYMTQtRVZLLCB0aGUgUk1JSSByZWZlcmVuY2UgY2xvY2sgaXMgcHJvdmlkZWQgYnkg
dGhlIFNvQyBhbmQNCmVuYWJsZWQgYnkgRkVDIGRyaXZlci4gQmVmb3JlIHRoZSBjb21taXQgOTg1
MzI5NDYyNzIzLCB3ZSBjYW4gc2VlIHRoYXQgdGhlDQpjbGtfZW5hYmxlX2NvdW50IG9mIGVuZXQx
X3JlZiBhbmQgZW5ldDJfcmVmIGlzIDEgd2hlbiB0aGUgRkVDIHBvcnRzIGFyZSB1cCwNCmFuZCB0
aGUgY291bnQgaXMgMCB3aGVuIHRoZSBwb3J0cyBhcmUgZG93bi4gQWZ0ZXIgdGhlIGNvbW1pdCA5
ODUzMjk0NjI3MjMsDQp0aGUgY2xrX2VuYWJsZV9jb3VudCBpcyAyIHdoZW4gdGhlbiBwb3J0cyBh
cmUgdXAsIGJlY2F1c2UgdGhlIEtTWiBQSFkgZHJpdmVyDQplbmFibGVzIHRoZSBjbG9jayBhcyB3
ZWxsLCBzbyB0aGUgY291bnQgaXMgMi4gQnV0IHRoZSBQSFkgZHJpdmVyIGRvZXMgbm90IGRpc2Fi
bGUNCmNsb2NrIGV4Y2VwdCB0aGUgUEhZIGRyaXZlciBpcyByZW1vdmVkLiBUaGF0IGlzIHRvIHNh
eSwgdGhlIFJNSUkgcmVmZXJlbmNlIGNsb2NrDQppcyBhbHdheXMgd29ya2luZyBubyBtYXR0ZXIg
dGhlIHBvcnQgaXMgZG93biBvciB0aGUgc3lzdGVtIGVudGVycyBzdXNwZW5kIHN0YXRlLg0KDQo+
IA0KPiBUaGUgY29tbWl0IG1lc3NhZ2Ugc2F5czoNCj4gDQo+ICAgICBXaGlsZSB0aGUgZXh0ZXJu
YWwgY2xvY2sgaW5wdXQgd2lsbCBtb3N0IGxpa2VseSBiZSBlbmFibGVkLCBpdCdzIG5vdA0KPiAg
ICAgZ3VhcmFudGVlZCBhbmQgY2xrX2dldF9yYXRlIGluIHNvbWUgc3VwcGxpZXJzIHdpbGwgZXZl
biBqdXN0IHJldHVybg0KPiAgICAgdmFsaWQgcmVzdWx0cyB3aGVuIHRoZSBjbG9jayBpcyBydW5u
aW5nLg0KPiANCj4gU28gaXQgc2VlbXMgbGlrZSBhIG11Y2ggc2ltcGxlciBmaXggaXMgdG8gcHV0
IGEgY2xvY2tfZW5hYmxlL2Nsb2NrX2Rpc2FibGUgYXJvdW5kDQo+IGNsa19nZXRfcmF0ZS4NCj4g
DQoNClNvcnJ5LCBJIHdhcyBub3QgYXdhcmUgb2YgdGhhdCBzb21lIHN1cHBsaWVycyBuZWVkIHRv
IGJlIGVuYWJsZWQgc28gdGhhdA0KY2xrX2dldF9yYXRlKCkgY2FuIGdldCB0aGUgY29ycmVjdCBj
bGsgcmF0ZS4gU28gd2UgY2FuIGtlZXANCmRldm1fY2xrX2dldF9vcHRpb25hbF9lbmFibGVkKCkg
dG8gZ2V0IHRoZSBjbGsgcmF0ZSBhbmQgdGhlbiBkaXNhYmxlDQp0aGUgY2xvY2suIEluIGFkZGl0
aW9uLCB0aGVyZSBpcyBhbm90aGVyIHNpdHVhdGlvbiB0aGF0IHRoZSBjbG9jayBpcyBvbmx5IGVu
YWJsZWQNCmJ5IHRoZSBQSFkgZHJpdmVyLiBJbiB0aGlzIGNhc2UsIG15IGN1cnJlbnQgbW9kaWZp
Y2F0aW9uIGlzIG5lY2Vzc2FyeS4gT2YgY291cnNlLA0KdGhpcyBpcyBhIHZlcnkgY29ybmVyIGNh
c2UsIGFmdGVyIGFsbCwgdGhlIGNsb2NrIHdhcyBlbmFibGVkIGJ5IG90aGVyIGRyaXZlcnMgYmVm
b3JlDQpjb21taXQgOTg1MzI5NDYyNzIzLiBCdXQgYWZ0ZXIgdGhpcyBjb21taXQsIHRoaXMgcG9z
c2liaWxpdHkgZXhpc3RzLg0KDQpTbyB3aGF0IGRvIHlvdSB0aGluaz8gU2hvdWxkIEkgc2ltcGx5
IGRpc2FibGUgdGhlIGNsb2NrIGFmdGVyIGdldHRpbmcgdGhlIGNsayByYXRlPw0KT3Igc2hvdWxk
IEkgYWRkIHRoZSBmb2xsb3dpbmcgbW9kaWZpY2F0aW9ucyBiYXNlZCBvbiBteSBjdXJyZW50IHBh
dGNoPw0KDQpAQCAtMjI0NSw3ICsyMjQ1LDcgQEAgc3RhdGljIGludCBrc3pwaHlfcHJvYmUoc3Ry
dWN0IHBoeV9kZXZpY2UgKnBoeWRldikNCg0KICAgICAgICBrc3pwaHlfcGFyc2VfbGVkX21vZGUo
cGh5ZGV2KTsNCg0KLSAgICAgICBjbGsgPSBkZXZtX2Nsa19nZXRfb3B0aW9uYWwoJnBoeWRldi0+
bWRpby5kZXYsICJybWlpLXJlZiIpOw0KKyAgICAgICBjbGsgPSBkZXZtX2Nsa19nZXRfb3B0aW9u
YWxfZW5hYmxlZCgmcGh5ZGV2LT5tZGlvLmRldiwgInJtaWktcmVmIik7DQogICAgICAgIC8qIE5P
VEU6IGNsayBtYXkgYmUgTlVMTCBpZiBidWlsZGluZyB3aXRob3V0IENPTkZJR19IQVZFX0NMSyAq
Lw0KICAgICAgICBpZiAoIUlTX0VSUl9PUl9OVUxMKGNsaykpIHsNCiAgICAgICAgICAgICAgICB1
bnNpZ25lZCBsb25nIHJhdGUgPSBjbGtfZ2V0X3JhdGUoY2xrKTsNCkBAIC0yMjY3LDEzICsyMjY3
LDE1IEBAIHN0YXRpYyBpbnQga3N6cGh5X3Byb2JlKHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYp
DQogICAgICAgICAgICAgICAgfQ0KICAgICAgICB9IGVsc2UgaWYgKCFjbGspIHsNCiAgICAgICAg
ICAgICAgICAvKiB1bm5hbWVkIGNsb2NrIGZyb20gdGhlIGdlbmVyaWMgZXRoZXJuZXQtcGh5IGJp
bmRpbmcgKi8NCi0gICAgICAgICAgICAgICBjbGsgPSBkZXZtX2Nsa19nZXRfb3B0aW9uYWwoJnBo
eWRldi0+bWRpby5kZXYsIE5VTEwpOw0KKyAgICAgICAgICAgICAgIGNsayA9IGRldm1fY2xrX2dl
dF9vcHRpb25hbF9lbmFibGVkKCZwaHlkZXYtPm1kaW8uZGV2LCBOVUxMKTsNCiAgICAgICAgICAg
ICAgICBpZiAoSVNfRVJSKGNsaykpDQogICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gUFRS
X0VSUihjbGspOw0KICAgICAgICB9DQoNCi0gICAgICAgaWYgKCFJU19FUlJfT1JfTlVMTChjbGsp
KQ0KKyAgICAgICBpZiAoIUlTX0VSUl9PUl9OVUxMKGNsaykpIHsNCiAgICAgICAgICAgICAgICBw
cml2LT5jbGsgPSBjbGs7DQorICAgICAgICAgICAgICAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHBy
aXYtPmNsayk7DQorICAgICAgIH0NCg==

