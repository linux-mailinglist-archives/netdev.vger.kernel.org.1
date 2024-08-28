Return-Path: <netdev+bounces-122644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B8C962156
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA80284195
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 07:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7F515B13B;
	Wed, 28 Aug 2024 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hp/SDu7X"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2076.outbound.protection.outlook.com [40.107.241.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F90158DC3;
	Wed, 28 Aug 2024 07:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830560; cv=fail; b=gy4jlKnYj0ZfWO7mQ58K2vY/TFt9uxUfAlgBkFAg+w3iVqDOXJgWN7ler6ulMUjF/J66umwt9okORaEb95l7ulALZOfNin8Ozbdk0BR40dloCYlIEkmK6Ta9+X5hxs/9HoEa/VZCA0YCpZd4wRodb2KNALU/Yo6TqTMfWKCMPqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830560; c=relaxed/simple;
	bh=K+5/sziZk8q6tVqotAgIWymdnOd7nkMdE0jh2SU75s4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PJ8FrTXcXcV805qPzUg8U8YY40LH7BgVFeteLUipFKM3OJnwCzfkr68LzlR5cY15tHVNvuY4wJpJ1EcICgoQ5K804m2kOag1Mc657pmfNhwgVdcm0IXi91X+FK+WO1J7yho4+57+e94NYCJru0n1RilyygKc3fFWo3zGtXPMrAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hp/SDu7X; arc=fail smtp.client-ip=40.107.241.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNSNtNOh71rmhgzq8Z/OYUwSUoPPK4Ic3+1mGNa9UIXAtRUsOgubY2o1zf/OQBUqZMQivJHTl/GiVFs1psnAH5+jubAoZ29CkURa5PToCwGButMg94AmHFs3nyKov76rj5UMq19mLIJCJeATyLzSg9eXL1YHp/LWLNf021/NRjNa7q3WSo4jcd6GFM1u7kdoL2z3BQPqcxsG9k7eipdykbvKcd83kq6Xc45ZA7l94zAD/jB0jbiT4Pr69ZgErfowQDpcKgREW1/48TOPjrUmoXOWueCGy/rX/JIz13wwUR8PzMO4j8NS6ehJEV790KkjyRntEG8XWkWyEwWlAhHuvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+5/sziZk8q6tVqotAgIWymdnOd7nkMdE0jh2SU75s4=;
 b=l/rhSNJW+TKftXrMvTZUSlYO5rd04ClwIS+YbJWELeXtZeLg1HiHOg0RPI9SoyhBtlxoJrTpLn8WDAI195HyLWon5/6VHyPdyZMxS+D8Ah3G94sxyG7v41D1DWi8luqNPOVBRvWf6BAsT56zxZmJ7YVBe44INgqO2Wzv/gK3lBSHmoOC1ATtCQJdyebaXdjiWibkGGCjCZhC1VFx9f+uiPf5LYeKc5/zUkBq/yxUZEUuYMx5ofw3gJW50H0M11w6bW6ovNEYqpiYeI1mp0TT0IZB+nBMjEjfkKb6qoHQkrl+wzhunJjCsIpFg4IFW9aSIAX6Yk31YF8KD+AApIEcUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+5/sziZk8q6tVqotAgIWymdnOd7nkMdE0jh2SU75s4=;
 b=Hp/SDu7XFZsCtEUpihYCmEP3BwNU0h3h6x3prLCfSPZjkpb63dI9Ye8eioJ3BEXS4KRLseDC0HKYrfrBB0lzPk8h7Ma6lPd9T/zBPc98bSzwQOfolTCcblJT3jfku2oo3YiavNwJ3eonLIigLsdcFSzLrFQhX/Fd3xYjZLhD+MT+nwO8zEwooUwZFMEclkrMhmIaVXv1yI3XsbwaP6CpbLtdTqdRU3pt02lRh27AQFJ+Vkh7JehnjRrtnc1WHw51yOECIclJkTtKf0q7rxGD0az/c9s6w9wP2CJkv8L1mhVkrCRsnF2wZDm69DW5Hb2qG4Y34tfWmSQxvJ3UDm6elA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB10338.eurprd04.prod.outlook.com (2603:10a6:10:565::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 07:35:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 07:35:51 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Rob Herring <robh@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "Andrei Botila (OSS)" <andrei.botila@oss.nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v3 net-next 1/2] dt-bindings: net: tja11xx: add
 "nxp,phy-output-refclk" property
Thread-Topic: [PATCH v3 net-next 1/2] dt-bindings: net: tja11xx: add
 "nxp,phy-output-refclk" property
Thread-Index: AQHa93qWJiFBjD+OmUSVXRJrTkYTd7I5sD8AgAC15ICAAKXmgIABOj6A
Date: Wed, 28 Aug 2024 07:35:51 +0000
Message-ID:
 <PAXPR04MB85103AF88D92A3B08AA7D71788952@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240826052700.232453-1-wei.fang@nxp.com>
 <20240826052700.232453-2-wei.fang@nxp.com>
 <20240826154958.GA316598-robh@kernel.org>
 <PAXPR04MB8510228822AFFD8BD9F7414388942@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <25356e61-2e53-483f-916e-5a3685b5e108@lunn.ch>
In-Reply-To: <25356e61-2e53-483f-916e-5a3685b5e108@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU4PR04MB10338:EE_
x-ms-office365-filtering-correlation-id: 116c229d-29a7-4743-0845-08dcc7340b0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?TlBNSGI0YnRhY0poSXE2bi9zYTV3NlkrNHVReThSL2FJZmd6OG8ybS8xMTFM?=
 =?gb2312?B?TDhDUDlKc1RPZ3UyZmV5elRId2VmdkxqbGF6bEpVQURmRTh4ak9TM2t6ZXZK?=
 =?gb2312?B?UWhRMUVkWUczUTZjaVRrbTREdHpxMlVYd1U2Ry9ZSGJsdUdnRGU3a2dqMTFS?=
 =?gb2312?B?VXVIZTdkRXphTGd0aXBkM0ZIQnh6WDI4VTdPU0pMT0FPaWpYL3RwS2VNalVo?=
 =?gb2312?B?VSsvcmo2SUhTcnR1bXluUytVSEx2RFNuOGFFd20zMVN4V3BoVTJGdmRFU1Zs?=
 =?gb2312?B?RFJVYk5qMTYxSksyYVBjMDNBTjl4OGl4ZC9LTTZZc2I4SHNaTy9LaDE4TGpW?=
 =?gb2312?B?eWFQUW9WcjhGUDZOM0RlZWdUOGtXRmNZMnB2ejg2YVNlUVZrUTBHbVJMUk93?=
 =?gb2312?B?bjRTeDZzZk1KNFArRGJDRUhhUmdBcWFYK1NoL25ka2xESU84ajhxOGI5TlQ1?=
 =?gb2312?B?TytxTVRWQkcyZUZxazRwYlV6RjRnd2twbTBXMWtTaFJuTll6V0pRNUd2QTB4?=
 =?gb2312?B?Z05zMjJ5KzdYOXRtTW1OdWxpb3FBKy8xMm5iUnNOdW9pWTM2THdZMmFObTln?=
 =?gb2312?B?REZTdnlDcnN2YmpWZlVzczJ6RWpnTExOVEc0ZCtxM0lqQTIxRysyTzFjcTU1?=
 =?gb2312?B?cGk5TGZWZEovMVRVeE5aNEJXWkVIM1M3QU5VS0pwZlQvT2FtOElkUEF1eU9t?=
 =?gb2312?B?bGE3WFUzRDM0SnVQelpQWTJ3UkNQVHcvS0JpQURiRVVTYTE2eFREMDZFamZM?=
 =?gb2312?B?NHhpNjEvWmhxbitBSDlJL2RGbkVPSXZrSTBkenlTRytLejJuV3ZpMkVtSCtH?=
 =?gb2312?B?S0h6bFgrUFRhN2VXWTg2REhISGRibE9mQVpRdDlTQ3lJOUhiR2d5ekV3dlVl?=
 =?gb2312?B?L2lMMnEwdzBiZTNQTHNIL0Qzdjg0V0tzWS9ncUhjYkNnSWx2OTQ4Zk9GSjJi?=
 =?gb2312?B?Y1UxOTY5ZkFPQnMwQUNxb0Q2dGFKWlU4eWFkVVBUVDhXcE9oc1IwK29rMjAr?=
 =?gb2312?B?ejdiYTJ2ZFFOVkgyWjhaL2F3a1k5Y2hQUGFiWmxLaHF0Q3dJZUlRQUxlR21j?=
 =?gb2312?B?THJleEZFeDRLTWpiUUZYcDlsZHJBS0grSHFNc2dJVmhNZlFmTkFPOUdnVzBo?=
 =?gb2312?B?QlQ1S09EU3NjVUVDWUhIKzhCMlJjcVBnMFVrY0NtQ1NvVmxjajh5ajE4UCsr?=
 =?gb2312?B?UW5sYm9MUFlhck5YS0NZTGRRVWQyTHUzM2x0bWNnN3RqeDNITFlPSWZSay94?=
 =?gb2312?B?ZzlsODJoc1ZSRU9jZkJkNHJPcjdmZ0lpTDlMN0NmSEFoRW9lTlB1UWlQOHlQ?=
 =?gb2312?B?RWtQaS9kMHJYUE1MV1dndFcwUlFkN0NFelVVRy91MmNqWkIzK09MZDM5V0ly?=
 =?gb2312?B?RUVFblFpbGxGRVJhcXdEWHhHZzNTWW5wM1ZuOTlZdWVtN2QwT0wrS0ZQU2lQ?=
 =?gb2312?B?cUNEOGRpckFHZG9iUDFBVU51SGN3R3lNc0xQRHdlTy9tQXpDeHZ1WldWN08z?=
 =?gb2312?B?ay85bkM5S041WDJkdE5lSTZ5Rm40S3JTbGJvQXRNVWpTZ0FXa2ZycEh4bWlm?=
 =?gb2312?B?N0FnY0dlQm9WVitCcFQ2WVV0dlUwcndQUnk0L3NQZG0yRDg1R3hCWENHK3FC?=
 =?gb2312?B?TEE0bFpqUDl4c2hzYkN3V1BNdHpBSVlJU0k3NVp4aG5oaEw5OUJ1NGhGOHZx?=
 =?gb2312?B?UWVqejlVUlcrU1N6eUk0cVZRcm5iRUtvYlV4dS9ETm50WUkzLy9HRDMxZSto?=
 =?gb2312?B?TzVaVDRFU0hRYWRlbjdoUDczbmxsVm1tL2s3eUpROTJqSXFvdkZhbXdZTDc5?=
 =?gb2312?B?NllxM2ZOTEtGUi80YlhpdGFqU3lNUVlaczFjNnpPblZoL0dYZ0JXTkN0aXZa?=
 =?gb2312?B?SjYwaXExanNjc1hnMjVLRU1GSFQvc042S0c4dGk5YVgxOXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?OVp2enI2b2ZubHNHelFUeFJOWnp5eVdZZTZpM2lDcEFuQzFVUzZ3RHBZalhw?=
 =?gb2312?B?Q0ZNYVZ2cmNFL3A5NFdJalR6UGxQSkZHRUNBMGtTL3c5eDZ0TnV6Tzd4dUNP?=
 =?gb2312?B?aG1kV0tuUGlDVnN4ZFVHbEZzdWF4TkFxK3hjTGowVnJXM3BkRndzOTkyTGZh?=
 =?gb2312?B?ZXBpYzhrUlE5SFgwTGpIWWpsTHRqUjlKWDYwTHNDaG5DckpkbnNNaWRpSzN1?=
 =?gb2312?B?OGtacDFuOHhab2RPV01Edlpjak1SS2JOcEhuVDhGVDlJUnNLc0hKaklKU3hO?=
 =?gb2312?B?NG9ONGEwdUh2Um1wWmNnYTlYbUp5WUZSdk1vU1o2WUZVUnRmMzhLRXR4MFJ5?=
 =?gb2312?B?TnpBVGwrSUNITGJ1anNibzNDMHFlL29wUnVHcUN6MmtWdllCVmlyYUNlYnp0?=
 =?gb2312?B?cm5VQkVNNlM5cjkxaFd3QktrY1VBZHVCdldpK3hubnA1NHZ1RmkyZURpdjgv?=
 =?gb2312?B?UmgxODNadlZydzhnQnBWWmxobHBWWkdDOGI2NjZzRVhCcXNMeTQ2bHA0VzVQ?=
 =?gb2312?B?bU85NkxBbDBVR2ZqaWFld3NXaDhZdklDUkZ4L3UrTHg0SWJpejR2YTBhLzV4?=
 =?gb2312?B?Tnd6dGVRMVN1ZHcxTC8vbHppRzNKMGFhZ0djb0gvc2xuZ202bmYzNGU1cmNw?=
 =?gb2312?B?TmpjV3FDSTdpeU85d2lxQnBzNWFNUXZpV2h6WkY3aHJpQWJDNUtRMThjKzBC?=
 =?gb2312?B?QlY3SFFBSmQyS0MweXdWVm00S3JRMlBieTgrd0FzTVY5cDByalQvcmFiVUZR?=
 =?gb2312?B?cE82aDVZbkcvQzgrWlF0ZWQrVUVIY1dPYUNTQjdUdnFibmhLSE41NkM4UWpQ?=
 =?gb2312?B?K1F5UDRtbDV0WE5yWTZrS2syYlpOTnBRU3VVOEwwOE9RdTVoU2dpRkYyZ1FP?=
 =?gb2312?B?a2E2dWN1STc2OEZRM1o0NGdjbFhKbDRvK0Fzc25scEpXZ0FmdWZZaUU2aTRT?=
 =?gb2312?B?M1FLaVVVTnA4SS9KaVMxcEV0OEdLOURLSy9kMFl0TGZnZnRFMmlTK3VEZHRw?=
 =?gb2312?B?TEY5TFYrTzZoMGVJeTlCcWZuZlpUQ2FjZVlkTHlFbngvYWMwMWpiMEhhZzZt?=
 =?gb2312?B?ZEdZSmtFUk9qUURYMW5Xbko4Z3VmMGdnd3ZwNVYwcC83a0xla0xNTWkvQU9x?=
 =?gb2312?B?bTdwbXo3K1dhUmlkWkpPbTJIcXM3UzRjTms4OFlTaDBTY2dqNVBPWDBQYlRn?=
 =?gb2312?B?VlJxYmUybDk4U0dCK1R1OXZST0FBNk10bVZjSXhwNVhRYWdTSHZpYi9xdnov?=
 =?gb2312?B?RGtFL0lPUTgrUWRJU2lLQWViZmQ1bFJiR2d0U00wcWNxSk9rV3kwOW9MOTlD?=
 =?gb2312?B?U0pNODV5TW94czJsNlB5TlAyUHJPbHF2NkJ2MEltZXJ2MGNadExubkFDN1hG?=
 =?gb2312?B?SStpYTcwc2NzNGtvRXpGd0pLYVJuVGpRRnVOam5xUDRHcHA0SVhWbVNkbVBq?=
 =?gb2312?B?Rld3UGVRczdFQ1U1OE84bHNHL0FGWlByOExrMVJ6WWkzYW1mUU9tcU1iYnhM?=
 =?gb2312?B?TDBMRWdkT0l4ai90YVI2R3FHUXZ6VmxhdmVDRTJqQ3pGQndmdWRyeVhuc2xZ?=
 =?gb2312?B?YlJnTVQwaUZGdkdqUUVnYi84cHlnamNoaG1PSU1NcEdEU0NoYXdVR1IzMjBh?=
 =?gb2312?B?S0ZuL0orN3RzTENNbVgyd09iTWl1Y3JlSDZNRjdVWm5SdUJnWEdiMlRFTkkw?=
 =?gb2312?B?Q0ZJQXhzQUhWeDhYR3RLYkVpK05lVTJMNHBUSFVOVm5WYTJ1WjBwcHZXYmt2?=
 =?gb2312?B?L1FlUjZVUnlyQjV5Z2ZnNEpZeFdDc0VJMUdQbHZ0TXBteEo3bEYzSUtNRkg2?=
 =?gb2312?B?elpDd2ZNcGphS2ovQkxDWkdIeEV6VUZHVUFKeHlKMDJBSmRKUGZyUXJYSE4z?=
 =?gb2312?B?SHpCc3RJUVFPRHZ2cnVIRmJ5MDdUUHVwN24xOHZGSFozYzIrUVNwRVYzSktC?=
 =?gb2312?B?SXVDeStlbzZtZ2FnbDZra2pXVW11MkwxYU5NSytiMDdkVmpQMm4wVk5NTEd2?=
 =?gb2312?B?ejZQQTE0emJTZW1GZEk1RTZOWE5RNUF0eWI4M1lDano1S3ByM3dUbjhDTmFP?=
 =?gb2312?B?WUlwQUtsMnFNRnBxYVUxLzBkQWlHR2dDWnVKTkx3KzAyaHcwV0l1MTN2VXR1?=
 =?gb2312?Q?nTEo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 116c229d-29a7-4743-0845-08dcc7340b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 07:35:51.6897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eF7Zmzssjmgm+NnAnSnpVCAyCZVv05RxBdGAKzb6bpAMjM67GGj/CGxsVhLjbBPN66gcMURzkPMkLDSHgbb4AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10338

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTHVubiA8YW5kcmV3
QGx1bm4uY2g+DQo+IFNlbnQ6IDIwMjTE6jjUwjI3yNUgMjA6MzUNCj4gVG86IFdlaSBGYW5nIDx3
ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IGRh
dmVtQGRhdmVtbG9mdC5uZXQ7DQo+IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9y
ZzsgcGFiZW5pQHJlZGhhdC5jb207DQo+IGtyemsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2Vy
bmVsLm9yZzsgZi5mYWluZWxsaUBnbWFpbC5jb207DQo+IGhrYWxsd2VpdDFAZ21haWwuY29tOyBs
aW51eEBhcm1saW51eC5vcmcudWs7IEFuZHJlaSBCb3RpbGEgKE9TUykNCj4gPGFuZHJlaS5ib3Rp
bGFAb3NzLm54cC5jb20+OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxp
bnV4LmRldg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIG5ldC1uZXh0IDEvMl0gZHQtYmluZGlu
Z3M6IG5ldDogdGphMTF4eDogYWRkDQo+ICJueHAscGh5LW91dHB1dC1yZWZjbGsiIHByb3BlcnR5
DQo+IA0KPiA+ID4gVGhpcyBiaW5kaW5nIGlzIGNvbXBsZXRlbHkgYnJva2VuLiBJIGNoYWxsZW5n
ZSB5b3UgdG8gbWFrZSBpdCByZXBvcnQgYW55DQo+IGVycm9ycy4NCj4gPiA+IFRob3NlIGlzc3Vl
cyBuZWVkIHRvIGJlIGFkZHJlc3NlZCBiZWZvcmUgeW91IGFkZCBtb3JlIHByb3BlcnRpZXMuDQo+
ID4gPg0KPiA+IFNvcnJ5LCBJJ20gbm90IHN1cmUgSSBmdWxseSB1bmRlcnN0YW5kIHdoYXQgeW91
IG1lYW4sIGRvIHlvdSBtZWFuIEkNCj4gPiBuZWVkIHRvIG1vdmUgdGhlICJueHAscm1paS1yZWZj
bGstaW4iIHByb3BlcnR5IG91dCBvZiB0aGUgcGF0dGVyblByb3BlcnRpZXM/DQo+ID4gSnVzdCBs
aWtlIGJlbG93Pw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIG54cCxybWlpLXJlZmNsay1pbjoN
Cj4gPiArICAgIHR5cGU6IGJvb2xlYW4NCj4gPiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAg
ICAgIFRoZSBSRUZfQ0xLIGlzIHByb3ZpZGVkIGZvciBib3RoIHRyYW5zbWl0dGVkIGFuZCByZWNl
aXZlZCBkYXRhDQo+ID4gKyAgICAgIGluIFJNSUkgbW9kZS4gVGhpcyBjbG9jayBzaWduYWwgaXMg
cHJvdmlkZWQgYnkgdGhlIFBIWSBhbmQgaXMNCj4gPiArICAgICAgdHlwaWNhbGx5IGRlcml2ZWQg
ZnJvbSBhbiBleHRlcm5hbCAyNU1IeiBjcnlzdGFsLiBBbHRlcm5hdGl2ZWx5LA0KPiA+ICsgICAg
ICBhIDUwTUh6IGNsb2NrIHNpZ25hbCBnZW5lcmF0ZWQgYnkgYW4gZXh0ZXJuYWwgb3NjaWxsYXRv
ciBjYW4gYmUNCj4gPiArICAgICAgY29ubmVjdGVkIHRvIHBpbiBSRUZfQ0xLLiBBIHRoaXJkIG9w
dGlvbiBpcyB0byBjb25uZWN0IGEgMjVNSHoNCj4gPiArICAgICAgY2xvY2sgdG8gcGluIENMS19J
Tl9PVVQuIFNvLCB0aGUgUkVGX0NMSyBzaG91bGQgYmUgY29uZmlndXJlZA0KPiA+ICsgICAgICBh
cyBpbnB1dCBvciBvdXRwdXQgYWNjb3JkaW5nIHRvIHRoZSBhY3R1YWwgY2lyY3VpdCBjb25uZWN0
aW9uLg0KPiA+ICsgICAgICBJZiBwcmVzZW50LCBpbmRpY2F0ZXMgdGhhdCB0aGUgUkVGX0NMSyB3
aWxsIGJlIGNvbmZpZ3VyZWQgYXMNCj4gPiArICAgICAgaW50ZXJmYWNlIHJlZmVyZW5jZSBjbG9j
ayBpbnB1dCB3aGVuIFJNSUkgbW9kZSBlbmFibGVkLg0KPiA+ICsgICAgICBJZiBub3QgcHJlc2Vu
dCwgdGhlIFJFRl9DTEsgd2lsbCBiZSBjb25maWd1cmVkIGFzIGludGVyZmFjZQ0KPiA+ICsgICAg
ICByZWZlcmVuY2UgY2xvY2sgb3V0cHV0IHdoZW4gUk1JSSBtb2RlIGVuYWJsZWQuDQo+ID4gKyAg
ICAgIE9ubHkgc3VwcG9ydGVkIG9uIFRKQTExMDAgYW5kIFRKQTExMDEuDQo+ID4NCj4gPiBwYXR0
ZXJuUHJvcGVydGllczoNCj4gPiAgICAiXmV0aGVybmV0LXBoeUBbMC05YS1mXSskIjoNCj4gPiBA
QCAtMzIsMjggKzcxLDYgQEAgcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgZGVzY3Jp
cHRpb246DQo+ID4gICAgICAgICAgICBUaGUgSUQgbnVtYmVyIGZvciB0aGUgY2hpbGQgUEhZLiBT
aG91bGQgYmUgKzEgb2YgcGFyZW50IFBIWS4NCj4gPg0KPiA+IC0gICAgICBueHAscm1paS1yZWZj
bGstaW46DQo+ID4gLSAgICAgICAgdHlwZTogYm9vbGVhbg0KPiA+IC0gICAgICAgIGRlc2NyaXB0
aW9uOiB8DQo+ID4gLSAgICAgICAgICBUaGUgUkVGX0NMSyBpcyBwcm92aWRlZCBmb3IgYm90aCB0
cmFuc21pdHRlZCBhbmQgcmVjZWl2ZWQgZGF0YQ0KPiA+IC0gICAgICAgICAgaW4gUk1JSSBtb2Rl
LiBUaGlzIGNsb2NrIHNpZ25hbCBpcyBwcm92aWRlZCBieSB0aGUgUEhZIGFuZCBpcw0KPiA+IC0g
ICAgICAgICAgdHlwaWNhbGx5IGRlcml2ZWQgZnJvbSBhbiBleHRlcm5hbCAyNU1IeiBjcnlzdGFs
LiBBbHRlcm5hdGl2ZWx5LA0KPiA+IC0gICAgICAgICAgYSA1ME1IeiBjbG9jayBzaWduYWwgZ2Vu
ZXJhdGVkIGJ5IGFuIGV4dGVybmFsIG9zY2lsbGF0b3IgY2FuIGJlDQo+ID4gLSAgICAgICAgICBj
b25uZWN0ZWQgdG8gcGluIFJFRl9DTEsuIEEgdGhpcmQgb3B0aW9uIGlzIHRvIGNvbm5lY3QgYSAy
NU1Ieg0KPiA+IC0gICAgICAgICAgY2xvY2sgdG8gcGluIENMS19JTl9PVVQuIFNvLCB0aGUgUkVG
X0NMSyBzaG91bGQgYmUgY29uZmlndXJlZA0KPiA+IC0gICAgICAgICAgYXMgaW5wdXQgb3Igb3V0
cHV0IGFjY29yZGluZyB0byB0aGUgYWN0dWFsIGNpcmN1aXQgY29ubmVjdGlvbi4NCj4gPiAtICAg
ICAgICAgIElmIHByZXNlbnQsIGluZGljYXRlcyB0aGF0IHRoZSBSRUZfQ0xLIHdpbGwgYmUgY29u
ZmlndXJlZCBhcw0KPiA+IC0gICAgICAgICAgaW50ZXJmYWNlIHJlZmVyZW5jZSBjbG9jayBpbnB1
dCB3aGVuIFJNSUkgbW9kZSBlbmFibGVkLg0KPiA+IC0gICAgICAgICAgSWYgbm90IHByZXNlbnQs
IHRoZSBSRUZfQ0xLIHdpbGwgYmUgY29uZmlndXJlZCBhcyBpbnRlcmZhY2UNCj4gPiAtICAgICAg
ICAgIHJlZmVyZW5jZSBjbG9jayBvdXRwdXQgd2hlbiBSTUlJIG1vZGUgZW5hYmxlZC4NCj4gPiAt
ICAgICAgICAgIE9ubHkgc3VwcG9ydGVkIG9uIFRKQTExMDAgYW5kIFRKQTExMDEuDQo+ID4NCj4g
PiA+IElmIHlvdSB3YW50L25lZWQgY3VzdG9tIHByb3BlcnRpZXMsIHRoZW4geW91IG11c3QgaGF2
ZSBhIGNvbXBhdGlibGUNCj4gc3RyaW5nLg0KPiA+ID4NCj4gPiBJIGxvb2tlZCBhdCB0aGUgYmlu
ZGluZyBkb2N1bWVudGF0aW9uIG9mIG90aGVyIFBIWXMgYW5kIHRoZXJlIGRvZXNuJ3QNCj4gPiBz
ZWVtIHRvIGJlIGFueSBwcmVjZWRlbnQgZm9yIGRvaW5nIHRoaXMuIElzIHRoaXMgYSBuZXdseSBh
ZGRlZCBkdC1iaW5kaW5nDQo+IHJ1bGU/DQo+ID4NCj4gPiBUaGVyZSBpcyBhbm90aGVyIHF1ZXN0
aW9uLiBGb3IgUEhZLCB1c3VhbGx5IGl0cyBjb21wYXRpYmxlIHN0cmluZyBpcw0KPiA+IGVpdGhl
ciAiZXRoZXJuZXQtcGh5LWllZWU4MDIuMy1jNDUiIG9yICJldGhlcm5ldC1waHktaWVlZTgwMi4z
LWMyMiIuDQo+ID4gSWYgSSB3YW50IHRvIGFkZCBhIGN1c3RvbSBwcm9wZXJ0eSB0byBUSkExMXh4
IFBIWSwgY2FuIEkgdXNlIHRoZXNlDQo+ID4gZ2VuZXJpYyBjb21wYXRpYmxlIHN0cmluZ3M/IEFz
IHNob3duIGJlbG93Og0KPiANCj4gVGhpcyBpcyB3aGVyZSB3ZSBnZXQgaW50byB0aGUgZGlmZmVy
ZW5jZXMgYmV0d2VlbiBob3cgdGhlIGtlcm5lbCBhY3R1YWxseQ0KPiB3b3JrcywgYW5kIGhvdyB0
aGUgdG9vbHMgd29yay4gVGhlIGtlcm5lbCBkb2VzIG5vdCBuZWVkIGEgY29tcGF0aWJsZSwgaXQN
Cj4gcmVhZHMgdGhlIElEIHJlZ2lzdGVycyBhbmQgdXNlcyB0aGF0IHRvIGxvYWQgdGhlIGRyaXZl
ci4gWW91IGNhbiBvcHRpb25hbGx5IGhhdmUNCj4gYSBjb21wYXRpYmxlIHdpdGggdGhlIGNvbnRl
bnRzIG9mIHRoZSBJRCByZWdpc3RlcnMsIGFuZCB0aGF0IHdpbGwgZm9yY2UgdGhlDQo+IGtlcm5l
bCB0byBpZ25vcmUgdGhlIElEIGluIHRoZSBoYXJkd2FyZSBhbmQgbG9hZCBhIHNwZWNpZmljIGRy
aXZlci4NCj4gDQo+IFRoZSBEVCB0b29scyBob3dldmVyIHJlcXVpcmUgYSBjb21wYXRpYmxlIGlu
IG9yZGVyIHRvIG1hdGNoIHRoZSBub2RlIGluIHRoZQ0KPiBibG9iIHRvIHRoZSBiaW5kaW5nIGlu
IGEgLnlhbWwgZmlsZS4gV2l0aG91dCB0aGUgY29tcGF0aWJsZSwgdGhlIGJpbmRpbmcgaXMgbm90
DQo+IGltcG9zZWQsIHdoaWNoIGlzIHdoeSB5b3Ugd2lsbCBuZXZlciBzZWUgYW4gZXJyb3IuDQo+
IA0KPiBTbyBpbiB0aGUgZXhhbXBsZSwgaW5jbHVkZSBhIGNvbXBhdGlibGUsIHVzaW5nIHRoZSBy
ZWFsIElELg0KPiANCj4gRm9yIGEgcmVhbCBEVCBibG9iLCB5b3UgbmVlZCB0byBkZWNpZGUgaWYg
eW91IHdhbnQgdG8gaW5jbHVkZSBhIGNvbXBhdGlibGUgb3INCj4gbm90LiBUaGUgZG93bnNpZGUg
aXMgdGhhdCBpdCBmb3JjZXMgdGhlIElELiBJdCBpcyBub3QgdW5rbm93biBmb3IgYm9hcmQNCj4g
bWFudWZhY3R1cmVycyB0byByZXBsYWNlIGEgUEhZIHdpdGggYW5vdGhlciBwaW4gY29tcGF0aWJs
ZSBQSFkuIFdpdGhvdXQgYQ0KPiBjb21wYXRpYmxlLCB0aGUga2VybmVsIHdpbGwgbG9hZCB0aGUg
Y29ycmVjdCBkcml2ZXIsIGJhc2VkIG9uIHRoZSBJRC4gV2l0aCBhDQo+IGNvbXBhdGlibGUgaXQg
d2lsbCBrZWVwIHVzaW5nIHRoZSBzYW1lIGRyaXZlciwgd2hpY2ggaXMgcHJvYmFibHkgd3Jvbmcg
Zm9yIHRoZQ0KPiBoYXJkd2FyZS4NCj4gDQo+IERvZXMgdGhlIFBIWSB1c2UgdGhlIGxvd2VyIG5p
YmJsZSB0byBpbmRpY2F0ZSB0aGUgcmV2aXNpb24/IFVzaW5nIGEgY29tcGF0aWJsZQ0KPiB3aWxs
IGFsc28gb3ZlcnJpZGUgdGhlIHJldmlzaW9uLiBTbyB0aGUgZHJpdmVyIGNhbm5vdCBldmVuIHRy
dXN0IHRoZSByZXZpc2lvbiBpZg0KPiB0aGVyZSBpcyBhIGNvbXBhdGlibGUuDQo+IA0KTWFueSB0
aGFua3MgZm9yIHRoZSBkZXRhaWxlZCBleHBsYW5hdGlvbiwgY3VycmVudGx5IGJvdGggbnhwLXRq
YTExeHggYW5kDQpueHAtYzQ1LXRqYTExeHggZHJpdmVycyB1c2UgUEhZX0lEX01BVENIX01PREVM
KCkgdG8gbWF0Y2ggdGhlIFBIWQ0KZHJpdmVyLCBzbyB0aGUgbG93ZXIgbmliYmxlIGlzIGlnbm9y
ZWQuDQo=

