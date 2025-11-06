Return-Path: <netdev+bounces-236424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E12C3C0FD
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 16:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB30562215
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC538286412;
	Thu,  6 Nov 2025 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wddp3SQx"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013046.outbound.protection.outlook.com [40.107.162.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588E2284B3B;
	Thu,  6 Nov 2025 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442791; cv=fail; b=jP1wHAqQMJwbtAZhmFzKNOdkqrOszOWyfEaYhMnej33xSpCFDIq2O4gdm8yaXGz+d50clBQDXJV9+YOkuT1Q/3dfnPmUcUNrDv8QSvcprH44RU9pZNRD03cbHIDdD8da41L2/mo4WgdDV2ZeEfCo8bnUWBWZtXFzDIAf7XrmUUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442791; c=relaxed/simple;
	bh=zPRKluL/NEqkf5VkBG8gVxRnitWBfiMRkjtJtMmbnnI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ds3XhjtSzJl138zPUr5CMQRw+BK+7PqKkr8Bb9qwK+2RAICvvPzoD7OIDYd0IkTvGgoRM2r2k9hsGrQSKeTafQ6kgf+norA6K9DJLK3GaWJFNdpH1NmhGVpbD6b6j1v4AREJRstG1hvjj/AbL/zO76SYcXyHM0Z1pRlx4b3nYZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wddp3SQx; arc=fail smtp.client-ip=40.107.162.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hq+R/RzfTNpHsbyB1UAN1la8alAfoHU74sLEhYU/Lb5zIuP3feMqCWRoAzR5nqsTBXJtNk0RFR6oorQdF9gP5+UXW6bm8ONhh/fV3xry2l5RiJ2CysV02VmaJefb+DP7P+ns8s4slxwFqannGnsBBDUemYHq7T6AIGf2SlEo4O4z5DqiDg89eVGyoUczwxwsUZ0rEDz1Z/A2K8iEZsyTLf7YV37UEox1OqzWnYYj/Pow9wrCI0BBIFmdB4rqtP1pjloIxOXBZ93IQ/yMtuwyv7BzaCAbrZrrzadWkZ/3odVTS0UjojC8mLJzxFbdKxW6NYCrB7G7Slpfgqj6JA/qhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPRKluL/NEqkf5VkBG8gVxRnitWBfiMRkjtJtMmbnnI=;
 b=f2ddBhGFheTxNghgPppuiVsXW1674aqI2OUFWMHBp643BB2y2DSiHLrHOP5OmJQqUTVIbvE+Sjw88kRF4OFiGFgZirC1VmC2ZIfR/6sMLb6lSQuXVy7d3yd6AasLdZVJm7wpTyH3XN7MQgxjL665j4XldnGfqxwpg5xXS8r2Zndzxkt3RqIO57gRg0mMgWKQp2Xqo6anYWcBEOdrUse5bKeZH3xi9fVTV/c4XwMHZUTdfk9my2ebyc4ogVC2si6pHLw+L6OZctWoOs/CFadw9UWOc1QPik+CzooOY09YdgNSzvj5VPR1STuGTUv6bGJcvHQRJqiFZam3d5MGN8TtAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPRKluL/NEqkf5VkBG8gVxRnitWBfiMRkjtJtMmbnnI=;
 b=wddp3SQxV5vAaT32Tccp80ZFk1vf3TheYPLt0QAf2soL5FxJbn1mXhJqQNlOA7kZl5MCOu6htBMbB/1wRdGjKPOo2jUIiFcLYeWFA/eriaBArKWKhJ+UUcRZm7BSLAoXoKn2HaCqCkqGgzsHltx6g849rtItPh9/YjfKgoQl0QkLFA6x9IEWKQoW5K/bHlK/ssaF5JcX+c/q1w6kpJ3gcOTZqWIIz5iMLBzNUx4agr1W4ry0gbZ0EvzIvTtm4wFRremBZ0NkJpUVaX02WyDdwAmezsaOidvUo7xb7t7jUA8jqOyfXzJSdsgf6Qe/wd2vsFkTNADT6tD3mt8LLtyBpA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VE1PR10MB3822.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:160::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Thu, 6 Nov
 2025 15:26:25 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9275.013; Thu, 6 Nov 2025
 15:26:25 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "robh@kernel.org" <robh@kernel.org>, "lxu@maxlinear.com"
	<lxu@maxlinear.com>, "john@phrozen.org" <john@phrozen.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "yweng@maxlinear.com"
	<yweng@maxlinear.com>, "bxu@maxlinear.com" <bxu@maxlinear.com>,
	"edumazet@google.com" <edumazet@google.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"ajayaraman@maxlinear.com" <ajayaraman@maxlinear.com>, "fchan@maxlinear.com"
	<fchan@maxlinear.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "hauke@hauke-m.de" <hauke@hauke-m.de>,
	"kuba@kernel.org" <kuba@kernel.org>, "jpovazanec@maxlinear.com"
	<jpovazanec@maxlinear.com>
Subject: Re: [PATCH net-next v7 12/12] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Thread-Topic: [PATCH net-next v7 12/12] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Thread-Index: AQHcTLxDDivhhsZUI0Sg1sdKzKnvuLTiKW4AgAOTBACAAA2AgA==
Date: Thu, 6 Nov 2025 15:26:25 +0000
Message-ID: <d9be77db30ec14dac431c316abbfbcb039880400.camel@siemens.com>
References: <cover.1762170107.git.daniel@makrotopia.org>
	 <b567ec1b4beb08fd37abf18b280c56d5d8253c26.1762170107.git.daniel@makrotopia.org>
	 <8f36e6218221bb9dad6aabe4989ee4fc279581ce.camel@siemens.com>
	 <df47ae11-5f54-4870-bea8-8392a7fa47de@redhat.com>
In-Reply-To: <df47ae11-5f54-4870-bea8-8392a7fa47de@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VE1PR10MB3822:EE_
x-ms-office365-filtering-correlation-id: 005123ac-0278-4cbd-d785-08de1d48d937
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmtXVnFoNDRCNGhtVFZyYjJaWnk1T3QxWGJGYUNKSGNTbTA2S2tsajJPWFdn?=
 =?utf-8?B?VzlVWmRXcXlFYVdHVWZWdENCd21HUVpwcFp4MHdBcVgrVVNwcHZxS3FKRk05?=
 =?utf-8?B?VnNGcHpFUFdicnJ6ZlRDSG9pbXdSeCthRlZweTFPV2h3WFVPelY4OEU1clBv?=
 =?utf-8?B?ZzZhUk1HUStpRjRYZFgvQVVySmJQRkRHbFZRZ3R1SS9LWTRHaGlKYVVxa1Rx?=
 =?utf-8?B?VUs1a2JRYWZIa3o0NUJQYnN4VnRxdUM2WnAyVXp3emdmb2V4MXJKT3VMdnNo?=
 =?utf-8?B?dkd3VGxzOW1ZZ0hCekg2ZXZKVlUzU1orM3kwMHZudXNUSlVEdXdlNGxhaktU?=
 =?utf-8?B?S2hDbFRROUk0ZVBJeklWUU9rbHJobjdhYXNPcGE0OWtSOFpwOHprUkFYRktT?=
 =?utf-8?B?WmdwYklHNGNZaE8yYmN4dmxFRFkydnZ1RVZDSks1RCtId2l4Q2JnR3Q2RDRI?=
 =?utf-8?B?T0MxODhYZUVNNjJmYlgxWlFlUTBWNWpIOWJuY0RzaitLS0c5ZnNETitsMWQ0?=
 =?utf-8?B?ME9OTk8vOExzYXZHbjQ2QzlqQmdqeVpFMUF2aHBHbzVsdVVQb0ZmUEx5TnZO?=
 =?utf-8?B?RWxnaVc2QmR2YmR1V3JXK0R6NVJqckcweGdxdU1kVHhEVjJwTDVzbDVmOUhX?=
 =?utf-8?B?b2xXampkbDI3SXEzbEdjZVpicHd3ZDg4dUcxbHpSRFk4R0lLUCtTR1NNakFw?=
 =?utf-8?B?NXZsWVhDOXMxTW5odnVsaWtWb3l0Y1R3VWJrWGVpR0dlaGNZbGRwK1ZTeE1I?=
 =?utf-8?B?OG5keVRkTS9pWkxrZlF4NVhGNzd5RW1HZTVtUVdXM1p3bzFFTisrUzNQTXpH?=
 =?utf-8?B?YzRDbXZLd1BrQ2ttWVVLTWpsS0QzUHQxZldkVi9FcVROcnZyaVhlQ1R6dkR2?=
 =?utf-8?B?Wkx2Y2RUQzh4aHR4OHlGZ3hLWjc1Z2tTQ3NmSURvYyt0dWxqbjFaWFMya3lQ?=
 =?utf-8?B?WUlWalYvMU5BcnY4bk91M2pNOUtzZ2Z6RmdoQkdBemFxVVo1b2Naa1RHWHho?=
 =?utf-8?B?a2FFTHk5aDh5WmJOUUg5Q2UvZnluK1JuZFh4Z01WNW1xeUFnQW5HTUFKTDBr?=
 =?utf-8?B?djl6YXRyS3lYbkw0MnE3Zm0xSzJtUkNGbi9qajByTU8yV2d0ZWJJRU9XTHZO?=
 =?utf-8?B?eXlRdHpQb0FQeEQ0U3hEOEFNK1RIcVBCcC9nOW1pVHlkb3VUSlZTK3VjTjF3?=
 =?utf-8?B?TTg5VGp0cS9MeTl5WklVMzBYWGo0WjEzdktITmZJamZFOXR5eCtSMnlnQnhI?=
 =?utf-8?B?OUw0dThRM0FWUkpka0ZOUCtlL3lqSXhBcUFJSEcvTWRBTmlsK05CUHpPYTZj?=
 =?utf-8?B?UFIxTmIybS9QcjVSWDc2WTVuR0dma0s4OGNoVkswOUYwSTIrTzVhbHBIem5F?=
 =?utf-8?B?MzY4MnZpaHUrUVJteVVnUDVFbm5POUJhcXZvWSs4bm85amErNExRajM5MGVY?=
 =?utf-8?B?cDZQOVpmOUY1NnQyNS9FR0tNRFhjcC9FUVRJc0RTVGxNNUZQTGJzTkZkK2px?=
 =?utf-8?B?MkNsYWdYclFNV2lWanc3OUdTVlNzWjgwbFprMmNEK2dINndDYmdOTFY4MVZm?=
 =?utf-8?B?MytWbGJIeE5WdzE5eXExMGk2cGlIL2ZOTDZ0OE1WTk5CRCswcWQ3TEhlem9C?=
 =?utf-8?B?U0FzZ2o2bG8xeUxVczgwQkkwQUhGc1FZWHYxVm1vN2NjWlMxWVhBN21CR1Rm?=
 =?utf-8?B?djNzUG1ZalNSN2NCNUtZOWFhLy9xa0NJcUEwdTNBOGQ1b3U4VEVtaG1raXEv?=
 =?utf-8?B?cndVWHYxeEFTSjRIbjV2YzR5T0NXK25CYitsUmlNdlh5SDNNL3B5dkRmTktt?=
 =?utf-8?B?dEJCS2NGRGVtK3F4eXNrZlZKWHZvZ0lPZUlDR0t4SGRjTVNNZHM2T09TOEJu?=
 =?utf-8?B?TGw2WDNDSlp3VzJWQU5PaGVzaWQ2eGtIQWM0dHc5S1dEWFZiWnE2NGFLSmhp?=
 =?utf-8?B?bUdPSGhZSTNQZyt4YmVpM2NpZTJJdTdSNldpMUZRamtZcXM0WVk1a0V6bEpM?=
 =?utf-8?B?cER0Vldud2Z3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bnpqd1BnL3NGR2VON1J6TWcyL0d3QWUvckVydVpjcmQzUDl1bkhTMDhKZkVX?=
 =?utf-8?B?VS9UZ1dodjRCQTlnbkRJMjZUVjdXaEZhblNHTGRMamhCV3BXajlTWlVZMXAr?=
 =?utf-8?B?SEpXblpWa3VDU043ODAxS3lzNW14d1FaMTI1OGovWHVpVVhyUXJTWS94Skgr?=
 =?utf-8?B?VnRsbzlISXM4Qm5MaWhTamIxSCt4RlpnQmYvSnA2eWlqOTdYQldGYXVFRnpj?=
 =?utf-8?B?SU5TTmhpQ0hIR0hUU3NDZ1FJMDlGWFNPWDFCS3VucWlnN3FrSHl2OEk5Skpj?=
 =?utf-8?B?elMzQ3JMM3BjU2Z5YnMrRVMwNHZ5bXplYkRISW4ybCtTamZVSy9QdUxwMk54?=
 =?utf-8?B?dUk1azR3N0I1aXNsT0tvUmplK1Y4YWtEQU9qMCtMSWVOa0xXZG9JclNzNGJH?=
 =?utf-8?B?OURFMU9Pck9Nb0lyV3pqNFhJRlpsTVpVWmpqSmI0NUw4ZmVOcGt6L2xLUGUy?=
 =?utf-8?B?dTNXRy9vZmJXeEFvOEkxbGVvdDdxa0RaQURrbTJFQjJCVnlOZXRXYnVMR2tl?=
 =?utf-8?B?dW14MUVZdUNreG1HcEk1OCtVQTNkWDNiNHk5WnFyZHlZNmJjY3IydVB1R0xr?=
 =?utf-8?B?V01NU29QTGxsL2ZTRVFyYTV4SUJrVG1odGF5K29tdmhxM0NQZXJSYmZvMHlW?=
 =?utf-8?B?b3Y5UkZJcU5xR1AzYnBaNzQzSUZxUDd3cUVJMmU5eEJmTERJZy9MS0hsbjlF?=
 =?utf-8?B?SllPaG1BMVBXNEx3b3l3RFdUWVVrZmpVaDBxWkZkNFZTMStLdW1VZXlXMGsx?=
 =?utf-8?B?blNJSTF3Y3R1TzUvNHZlVktWaTQyZEVic0VYQzVoSm8wN253b0RSSTlhNkpu?=
 =?utf-8?B?eXRpYi9iVC90eVNodFZXaXZMbFVid0w5SnNVajdaRTJKS28yemJocWJwV0Fs?=
 =?utf-8?B?V0hhNStjNHV3L2hHS1I3MmRhdVptNzFLQnlVVEp5YkEyNE9WdU5tUVpOYzV5?=
 =?utf-8?B?MjRyMitPQlJ2VzlNWGlEdFJVUjBacmo1NWk4dVdPeWhhQllzdFhhZXBJeFlu?=
 =?utf-8?B?bUw4V2RKMVE0U1ovdjdvZGxadGp4RW1tU1RQd3oySUJxcEpsNm9qbmNkbkxD?=
 =?utf-8?B?L1UrWFhmYTZUVlJZOVhGWGJjclZPRDFmdll6c0h2T1JHU3pMV0ZhcS8vdUZZ?=
 =?utf-8?B?SmR2VkFYVGxZKzdkMGN3b1R1VGhCY1RYOU12MURJdlZEa1hSMzJhdnVoWHBH?=
 =?utf-8?B?WUVrQWFrS04xZ3JvTjE4STByaHlqbG9oZkRFMEZOOENYTThYeTJIdDQ1Z2l0?=
 =?utf-8?B?K210OEZZdXJFYnRCK1NCSDJ3bTdiRWJ0Y1R2NytrT3llYVdJTG5NSGhXcmtE?=
 =?utf-8?B?UVRuRTVEVnNIZ2xWNzczTGJ5ZEJId3htaG56ZDNvK0U2ZVlqMmpqL2VZTElF?=
 =?utf-8?B?bVZNS0YwajZoRHJjTjFZWDdPKzNzMFFWbHE5NTNpYjlPOVN4OUNDMTJpL0JZ?=
 =?utf-8?B?STRSWnlqdlBJRFBoZ2xKdk9sRnprK2FUWVZHVmk1MkZDaURwL2psalNMVnEz?=
 =?utf-8?B?TUtOWDJPTHNYUHZBaVlLRDJZYmY4TkcxTmlJRlEzTWxzOGdZRm5LdWRBb1Ba?=
 =?utf-8?B?aVJhWXlSUC84a29MRmxhUFA0dWVwYmZoVE0vbkJyVmgxWjNZZlJicG9MQ2No?=
 =?utf-8?B?cVhqRGRML3huVG5DQ0luMHlPSCtNaFdrWEFtNFBZa1VRbHpqS0FXanFzTTVJ?=
 =?utf-8?B?ck5kTG9ERnc2a1ptZGJ1c2pDcndhZE5aRnVGUWdSck8yWExnaGVRV0t2bGNz?=
 =?utf-8?B?UGxzTXhyVlZBTU81Z1pVQTNtaTlnOGdLODdBZVdaNStXM202YlVoK1NlUlRK?=
 =?utf-8?B?NDJQRHhQNVhiVS9mdStTU1E5VU8vUWZMNnpmK1dScGo2eEpOdWdsSWpGT05V?=
 =?utf-8?B?cWFCMWI5Q3pGbytJQWxFUnUyZmxhdTI4QnhQRVQ0REt0dmNZZzJSckhZSW9w?=
 =?utf-8?B?b3ZqWTFDVTJodTZ5anNEWVZubDNaWTFFVFlvRmMwajhUOVROTTQxQk1tYUJr?=
 =?utf-8?B?T2w2QlBIdHlvL2tRQ0p5ZlVIdmE4UE5iYVdKKzRkdU8rVEs4MzRrNEdPOFpz?=
 =?utf-8?B?ZTVKcXhIYmNQMkVhbGEvWThlNyt5S1dJM2VITzA5ZGVmaW96L01lOHprU0pF?=
 =?utf-8?B?MnZtYnAweFZxQnZ3OWNORTgzWGFneTgvUVR4V3F3bFR1RWRWa1UremlyVktS?=
 =?utf-8?Q?08tiDgHdPdcFLGSs0NMMUAA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <620DB1B76B17054D857E68057EFE7AE4@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 005123ac-0278-4cbd-d785-08de1d48d937
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 15:26:25.1818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/zemUe2ntoglw7dwzKDk4IPkN6u9PMZpJO70h8A51b6wDbopG1yA/2p9HZ/re753zRzIHtYir23fJ6Q8ALTAjUgfHCGw09svrV8SS+T9tY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3822

SGkgUGFvbG8sDQoNCk9uIFRodSwgMjAyNS0xMS0wNiBhdCAxNTozOCArMDEwMCwgUGFvbG8gQWJl
bmkgd3JvdGU6DQo+ID4gPiBBZGQgZHJpdmVyIGZvciB0aGUgTWF4TGluZWFyIEdTVzF4eCBmYW1p
bHkgb2YgRXRoZXJuZXQgc3dpdGNoIElDcyB3aGljaA0KPiA+ID4gYXJlIGJhc2VkIG9uIHRoZSBz
YW1lIElQIGFzIHRoZSBMYW50aXEvSW50ZWwgR1NXSVAgZm91bmQgaW4gdGhlIExhbnRpcSBWUjkN
Cj4gPiA+IGFuZCBJbnRlbCBHUlggTUlQUyByb3V0ZXIgU29Dcy4gVGhlIG1haW4gZGlmZmVyZW5j
ZSBpcyB0aGF0IGluc3RlYWQgb2YNCj4gPiA+IHVzaW5nIG1lbW9yeS1tYXBwZWQgSS9PIHRvIGNv
bW11bmljYXRlIHdpdGggdGhlIGhvc3QgQ1BVIHRoZXNlIElDcyBhcmUNCj4gPiA+IGNvbm5lY3Rl
ZCB2aWEgTURJTyAob3IgU1BJLCB3aGljaCBpc24ndCBzdXBwb3J0ZWQgYnkgdGhpcyBkcml2ZXIp
Lg0KPiA+ID4gSW1wbGVtZW50IHRoZSByZWdtYXAgQVBJIHRvIGFjY2VzcyB0aGUgc3dpdGNoIHJl
Z2lzdGVycyBvdmVyIE1ESU8gdG8gYWxsb3cNCj4gPiA+IHJldXNpbmcgbGFudGlxX2dzd2lwX2Nv
bW1vbiBmb3IgYWxsIGNvcmUgZnVuY3Rpb25hbGl0eS4NCj4gPiA+IA0KPiA+ID4gVGhlIEdTVzF4
eCBhbHNvIGNvbWVzIHdpdGggYSBTZXJEZXMgcG9ydCBjYXBhYmxlIG9mIDEwMDBCYXNlLVgsIFNH
TUlJIGFuZA0KPiA+ID4gMjUwMEJhc2UtWCwgd2hpY2ggY2FuIGVpdGhlciBiZSB1c2VkIHRvIGNv
bm5lY3QgYW4gZXh0ZXJuYWwgUEhZIG9yIFNGUA0KPiA+ID4gY2FnZSwgb3IgYXMgdGhlIENQVSBw
b3J0LiBTdXBwb3J0IGZvciB0aGUgU2VyRGVzIGludGVyZmFjZSBpcyBpbXBsZW1lbnRlZA0KPiA+
ID4gaW4gdGhpcyBkcml2ZXIgdXNpbmcgdGhlIHBoeWxpbmtfcGNzIGludGVyZmFjZS4NCj4gPiA+
IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEdvbGxlIDxkYW5pZWxAbWFrcm90b3BpYS5v
cmc+DQo+ID4gDQo+ID4gdGhhbmsgeW91IGZvciB0aGUgcGF0Y2ghDQo+ID4gDQo+ID4gRmluYWxs
eSBJIHdhcyBhYmxlIHRvIHJ1biBzZWxmdGVzdC9kcml2ZXJzL25ldC9kc2EvbG9jYWxfdGVybWlu
YXRpb24uc2gNCj4gPiB3aXRoIG9ubHkgMiB1bmV4cGVjdGVkIGZhaWx1cmVzIG9uIGEgR1NXMTQ1
IGhhcmR3YXJlICh3aXRoIFRJIEFNNjINCj4gPiBob3N0IENQVSBhbmQgaXRzIENQU1cgKG5vdCBp
biBzd2l0Y2hkZXYgbW9kZSkgYXMgQ1BVIGludGVyZmFjZSkuDQo+ID4gDQo+ID4gVGhlIHByb2Js
ZW1zIEkgaGFkIGluIHRoZSBwYXN0IHdlcmUgbmVpdGhlciByZWxhdGVkIHRvIHRoZSBHU1cxNDUg
Y29kZSwNCj4gPiBub3IgdG8gYW02NS1jcHN3LW51c3MsIGJ1dCB0byB0aGUgdGVzdCBpdHNlbGY6
DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUxMTA0MDYxNzIzLjQ4MzMwMS0x
LWFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbS8NCj4gPiANCj4gPiBUaGUgcmVtYWluaW5n
IGZhaWxpbmcgdGVzdCBjYXNlcyBhcmU6DQo+ID4gVEVTVDogVkxBTiBvdmVyIHZsYW5fZmlsdGVy
aW5nPTEgYnJpZGdlZCBwb3J0OiBVbmljYXN0IElQdjQgdG8gdW5rbm93biBNQUMgYWRkcmVzc8Kg
wqAgW0ZBSUxdDQo+ID4gwqDCoMKgwqDCoMKgwqDCoCByZWNlcHRpb24gc3VjY2VlZGVkLCBidXQg
c2hvdWxkIGhhdmUgZmFpbGVkDQo+ID4gVEVTVDogVkxBTiBvdmVyIHZsYW5fZmlsdGVyaW5nPTEg
YnJpZGdlZCBwb3J0OiBVbmljYXN0IElQdjQgdG8gdW5rbm93biBNQUMgYWRkcmVzcywgYWxsbXVs
dGnCoMKgIFtGQUlMXQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqAgcmVjZXB0aW9uIHN1Y2NlZWRlZCwg
YnV0IHNob3VsZCBoYXZlIGZhaWxlZA0KPiA+IA0KPiA+IFNvIGZhciBJIGRpZG4ndCBub3RpY2Ug
YW55IHByb2JsZW1zIHdpdGggdW50YWdnZWQgcmVhZC13b3JkIElQIHRyYWZmaWMgb3Zlcg0KPiA+
IEdTVzE0NSBwb3J0cy4NCj4gPiANCj4gPiBEbyB5b3UgaGF2ZSBhIHN1Z2dlc3Rpb24gd2hhdCBj
b3VsZCBJIGNoZWNrIGZ1cnRoZXIgcmVnYXJkaW5nIHRoZSBmYWlsaW5nDQo+ID4gdGVzdCBjYXNl
cz8gQXMgSSB1bmRlcnN0b29kLCBhbGwgb2YgdGhlbSBwYXNzIG9uIHlvdXIgc2lkZT8NCj4gDQo+
IENvdWxkIGJlIHRoYXQgZHVlIHRvIGRpZmZlcmVudCByZXZpc2lvbnMgb2YgdGhlIHJlbGV2YW50
IEgvVz8NCj4gDQo+IEkgdGVuZCB0byB0aGluayB3ZSBhcmUgYmV0dGVyIG9mZiBtZXJnaW5nIHRo
ZSBzZXJpZXMgYXMtaXMsIGFuZCBoYW5kbGUNCj4gdGhlIGFib3ZlIHdpdGggZm9sbG93LXVwLCBh
cyBuZWVkZWQuIEFueSBkaWZmZXJlbnQgb3BpbmlvbnM/DQoNCnNvdW5kcyBnb29kIHRvIG1lIQ0K
VGVzdGVkLWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5z
LmNvbT4NCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5z
LmNvbQ0K

