Return-Path: <netdev+bounces-235370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81561C2F5DC
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 06:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBDD23BF5F0
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 05:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBB3299920;
	Tue,  4 Nov 2025 05:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="X1ghNEj0"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022097.outbound.protection.outlook.com [40.107.75.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5583626E17A;
	Tue,  4 Nov 2025 05:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762233785; cv=fail; b=rJEPZ2TXCyiwbp+joDx9AmbIzffwalEtCwz0YkV4IHx3C5BKbHzX6CyMGgAg0Wr2Mru+855KZcriv+9rdAIWm8Vy02pUJzsPmAl5w1o5aeyfrWzv/F7Jtov/+mvJEWF27MVZPsH0nALHPLBz1aMh1CIa21M3PoU/rQrTDlzMJMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762233785; c=relaxed/simple;
	bh=3hImfx6CtGij021cyEYKMO9NeHQUxfLhvhEsm1xwihQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P8cFbD8eOqD1V924uAfK5eIm5bJYw7CE1sMEZWdgRIFFOrck2M1UXwHVBM8RXAKzd6tBKw7/xHagphuysOTkQ1T9ZdSVp4v1OuMLgKxl8KYyIFaHJAhIJ608NKnPcUD7eBx7Uzu8s4B7u/M7CzlFNvgtdxgdqTpSVuU+N5OOmLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=X1ghNEj0; arc=fail smtp.client-ip=40.107.75.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZ3qTzQ/w4dR4AlKiymqN2y5c1Fic49DbRAaqAOxiyKF9UV6qnA7+7TfWEkt5cEz37NbRMk6BjeiyVUTNyI7/4rO63c/nksfU7/ki4E4ioO9L6WUXZDwWX9c1AyGanbndH77U0phUHXd8XTN+RL4NIUCsGHuXVhHx7ucnKU38KM6tFRQhwAz3mBItg3VkKY8oZz2sq2JQX4GAbR2z+tZwa4iDr3SdtaF0EyPJpjHsno6GiaCIZsb16J7TseVRbA78jbMdxu9tMAiDlib0DR3/zin5GhzEx6Z1NUeb2qkfG+y0d5A9kyhG/6liAHXACgqLXpR0aFwpJuPznCi/WqtgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hImfx6CtGij021cyEYKMO9NeHQUxfLhvhEsm1xwihQ=;
 b=eQB3JmS4UXJ1hhcjqRF21cHBK9wBITH2lDUcmEc5d8ERN9lWd5dsaLIpT7ZC2LyPJ55lvKxhI4hbVpMVKLPsu9vNqiRaa2P8MQfcJiQbZpXH9IXzuHK8db4dwNPJKKRIGKH3sVsB8xNEIVqZTwc2bKo1IHujmaxnlSZCNi/jMGxgKF4yLbzIBgPSyIgkqYo+XcpegjRfAeVNK50DyudB8naMB/RQee36iDF+Ci8S5mFfTKkX116VRfb0dvvPwhbu8NrsxUlab2rOw/e+tGIAEM9LhmITR5Lj2dHgaNJ/bczJpFz06Klq+kJUZAMcs85n0ab2tXM+6ZBZfO/nNrxcag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hImfx6CtGij021cyEYKMO9NeHQUxfLhvhEsm1xwihQ=;
 b=X1ghNEj0zXfgZ9CrqjqRDLDMiIkr22FB4De+JfVfFIpMRv/EkEy71cqxALBiTH4T5qIxEQxHIiW5L7WheCIeurF9ieA84sPxmMMbkPmWLUVJ6Reg8B1uGfVcSAFATfV2xVM2MdrKFLrbrO82dtUl2C1cBm9gxb/WJkdeVeBpjcJknNZgIE9Acb/ujA0ipI+AYhvy+vkSDv7nb82teMME5GC84iCW1HC0nuYjr3u21Xo6IfJUj2AnLfEy6iqt8HU0PYQXTuvs8VZA8KOTTRpvLFSlKUnRs2tB65T1mCA5G0Q1IYGEo38bnA5vceUBssimtCNAplLbdVsWjmTy1cMyGg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by JH0PR06MB6653.apcprd06.prod.outlook.com (2603:1096:990:31::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 05:22:59 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 05:22:59 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject:
 =?big5?B?pl7C0DogW1BBVENIIG5ldC1uZXh0IHYzIDEvNF0gZHQtYmluZGluZ3M6IG5ldDog?=
 =?big5?Q?ftgmac100:_Add_delay_properties_for_AST2600?=
Thread-Topic: [PATCH net-next v3 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Thread-Index: AQHcTJUB+TmCwKSgIEaeQsrh+oaRd7Th6AsAgAASqkA=
Date: Tue, 4 Nov 2025 05:22:59 +0000
Message-ID:
 <SEYPR06MB5134396D2CD9BD7EE47137F09DC4A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>
 <cf5a3144-7b5e-479b-bfd8-3447f5f567ab@lunn.ch>
In-Reply-To: <cf5a3144-7b5e-479b-bfd8-3447f5f567ab@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|JH0PR06MB6653:EE_
x-ms-office365-filtering-correlation-id: df383239-33dd-4bb9-8df6-08de1b6237f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?big5?B?dXNNcXNvK1l2UnU4U0JVOGhYbERyejZWQ1dJbGpiTEhvR0FFRDJia1VGVE56eW02?=
 =?big5?B?YjBHU3NVVkdvNHlwOGtYYlp6anFMSGZDcHZzYlJuSUZoUkpUWUxWbUtOaTg0ZXRL?=
 =?big5?B?cHB1aTVqNXV3R1FnbVJzakRnbi90ZFlIb21PbjNoTW5SU283YnJEYzZZSHB0OFQx?=
 =?big5?B?YTd2WWNBUWFiNlVZclBVZHAwK3JXUVRwbEtmS0ovelBvd3VNYU1Sc0F5OUhRVWJ2?=
 =?big5?B?dHRWeXFNcUVGUzl3eHcyZWdDSVdkcHBZY0lVOUZReGJhbXVwM2JNOXBHQnQzVnpW?=
 =?big5?B?MUtvV2pBZUdUMCtZTCs0Ym93d3hWZWdaS1RYMXB3QmpFRlZKQmVyYStnelNQd2xi?=
 =?big5?B?WFNoVGNQbG5SNDhyM0Fzc3NDeXlXY2JFNEtkZTFZYWFwZEpkVmFLOTBNVm9zWVlh?=
 =?big5?B?MDJTZUlYOU4wdXFVV0s2ZGlTWFdOMEEvUmJaTFRJc1NQbit0bnlnN3M2SkROY3VL?=
 =?big5?B?bWVtTW5pYXhGb2J5Mko5U2NqbU10aVl1WEVzQytDNUNWT212c0NmVmRCQ25pck5F?=
 =?big5?B?YzVEUU9vZE1GaVYyVVRVUUNTNHJmVml5bVNMM0FjVWhYSTd3ZUt0aVJueXNSMkkv?=
 =?big5?B?eDd0S2pnSk1iVUtlRUx1ekVWRG5tYmVqVnl4ZHFUdWwwNDh5aXJrcWZMTCs0Y3E3?=
 =?big5?B?aUxaM3hVYUZtWXI3RnBneGV1emRPSFNCL2RPUzFVZjZORExnR1pDYzF0ZVdtVnpQ?=
 =?big5?B?dDRlSnN1N1JObSsyS001cExCRG5XelFOMXlFN29vL3JsbFZaY1ZXdUhGamlzNjZ3?=
 =?big5?B?S2VLTkFHZEg0Y1RBQXN1MUQ5TzR2bHhWL3Z5ZDdLdHRKTDluNmVqQkt3U25GTm4w?=
 =?big5?B?UUV5Q3EvRTJLOFlMMFJEZytlTVZ2TlNMajdYUmlwYURuVXpwOEZRZFlIQzd2WERJ?=
 =?big5?B?K1Jnay9HdFRLYVFqcEgvNVRteUlDQXZ4U0NOd1RMOHU4OE1VbnR5SFZHdk5qbHlk?=
 =?big5?B?cWVXQ2U4aCtZdFREMVRjU3ZPWW41bTM5NXBwZ1FrV0xJN3QzL08vY3VLdHM0Qkk2?=
 =?big5?B?NXp0RkhwVFFmcUNsT3p1UVRGNTl1VGRSVkFXOC9ZRTRvdDhGQzhzYWdlVWNBcUxp?=
 =?big5?B?ZnZVOEpBbllxZ3pReUFpMzIwMEJwQ3psQUZCT0ZjUWd5N0ozUmNxdzFTUVQzUVkz?=
 =?big5?B?WEVWMzU5bXM0UGtDaW5VL25na25xL1h0a1NLTzUzLzJVd3BZR29ab1ZWL1FqNUZh?=
 =?big5?B?MXFmb0tEK3dpQXZyUm1FcklYYjRneVM2MmcvVjhwTFAzdHZxWWZuM2NSNHZtbklN?=
 =?big5?B?Zlluc0QvdEZXQW5pakZ6QlVZTHNOd3VQVzBaVW1uekM5N0QvK1BRaldTQW5YQ0VR?=
 =?big5?B?eHlBYU5TeXg4bm1qRWtGQVc4UDJZRk5lY0R2eGV6Rk5Ud1Y4VER1UjF3dTZaWWZO?=
 =?big5?B?MmQzekpjQkZIZWJnYmFWME5GS0MxemExMHhIb25kUHdMWXF2UXR5Wi9yUEZHLzNu?=
 =?big5?B?MlNmRWs1dXFKTVZNV0RqVlE0bjN2Z3EwM3JQNXVNdEttVzZnem55T0JubXdPMCtK?=
 =?big5?B?eGtRZGZSbmI4Ukp1SmtWYm4wZkRHMjZYSVdwOXo2bDhDNzRzYUV6bjM1MDFScEN6?=
 =?big5?B?cDMrdGRhaG0wYlRsU3RmdXI3eFd4WDNUSWNVSHg0Mk11K0p3NFVjNGorenpkRE9u?=
 =?big5?B?SGpYVG1kV0hlZG44RGhyV2haUERUMDkyRW9pcDM2K2E3bXhlVUttSDhKMkdDaUl5?=
 =?big5?B?TGhqaS8raE50M1EzSGJqWkFRejJBY1FZbjNqQ1Z4S3dXR1hSc29DMFAvVFovaFpS?=
 =?big5?B?ZWZsZ3hnMXlSMzBHVVhydHJ6b1o4S0k2dnpEMzRvUWF4UHAzbTNsMG5ySWpZTTNr?=
 =?big5?B?MXJsK1dwazZnczFwTm9XSDZmRlVQMXhNR3dDNUtKU3pZRmdha1c3Unl5SlNWVkhp?=
 =?big5?Q?Nq5kmV7HhqwPJmwWFYfL3p/MoLn9vRrAPd1nO1R6KIloOnXZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?L0xrRFVJTnRkTVlyelpEeFJQMnYyNjlFRjBTb0hCSGZOYzR0dHdHSWh0NGVpcEp4?=
 =?big5?B?anpxUVZJRGZ0UTNpcTdYck13N1g0Mkp0K0ZJbGwxR2JnVXRVWkNlSldLcHhWaGRX?=
 =?big5?B?TkZuUzcvTk9lc2k1M2FjQUdjZTZjRzhCRUFIdm1vSDdvVlB4VGt5ME5kd1ZkaWU4?=
 =?big5?B?RGdBYmQzR0R1OXBaRGgwQm84VGdpcmNpMVhmWjhXRkhjckU1OVBhTzIvL0NqVFlh?=
 =?big5?B?eUhQajFzL2F1enNvYmJlMWlScnA4YVRtemtDYkk0ZmpRVmtWdGdYQjRVRTdpZUhm?=
 =?big5?B?UHpuRGJrOUlQd3E1QVo0U1JNRHdKcW1NZ3B4RWhLbG5iM3krRmFybmN3azdVR2Rs?=
 =?big5?B?OVpzNGVvVTNmY0NOZmhJcytQQ1prcDVyMUk5OTRqaCtPbm1hN2lGU05sNlF2N1lF?=
 =?big5?B?YVo4QlM5TTVraWl5WU1BQ3dNSGtpd2F1SERFUzBsb3dOVDJ6bXlwQ2k4N1RlbVBZ?=
 =?big5?B?WkR0ZGhHSTlSa1pMeFYzQTE2b0V5SFV0YUJ0M3c4SGZRdTArS1VRT3MzZ3dBY1Iw?=
 =?big5?B?QkdWVnROTytWaFhMN0xrL1I0WUc4UzRQYTBSMG1OL2JQY1N2alJWSU9TanI0VjRW?=
 =?big5?B?cGsxMFBINTI5VitEU3pxVkZXdTQrUzZBYnJ6dU1OUUZIUFlKNDM3cGF5VjhKVmNC?=
 =?big5?B?aFJuY1lOYXFBY1JyNTRBMlF6bjBzRzA4QThKNXVRSURuM3FTUXdXcDdFY3JSdWVt?=
 =?big5?B?YStHVnBKMlc5a21FMk5UOU9rSjlSRDNxM0FRSG50YmFOQ2V1WmhlODlKdmROdFZG?=
 =?big5?B?Uy82a25tYWdCMGc1ZWF0RVR3K3ZndFRsSER6S05jR2FWMkRNdEwvRVNIWTU2aXRn?=
 =?big5?B?WHZBZWdoVHdmdHV6bHRNTDlSd2NlRjZLbnVCeEM2VWdnRVgvbEVkTzdobnFoVHMr?=
 =?big5?B?RUp4RklHWTZPN0IzYkRMRjVIWkdCajFzdVRFZ0wxT2U1SzJLU0RaZGhHSWxlRWFE?=
 =?big5?B?YmZxN2kyT2VzTjZkL0owdmtxcXh1OXJhT1dLWWVFR1U5YXBNRUI3SStEVXlabHlO?=
 =?big5?B?R1dKcTdGMlo4dnBHVzd5L3N2MTkweDhwb21lUUFqWXNHd3ovclNwTlBya2lrSTMy?=
 =?big5?B?Z09KVk9YNnV6V0lhUUVXdWx3V2dEdElQVWlwbXBGS2UwWm05UTV5ZmhkdERaMmhD?=
 =?big5?B?RWV5OGhPR1cyZEJLVVJSS2orMUJYby8xRHZ5TFhvRkg5bUVFSXdZdlRhMmNnOVdI?=
 =?big5?B?U3NSK0xyV2RCQk9FWVBkeEN3U2k0VHNKSWFaRFliRi9OWHRmM2xnU2VTdFJKdUha?=
 =?big5?B?ZHJXQ1lUTURBM3lucjhOUjF3dUpKYVdBZzhPa3JTd3JXSXVpMFFqRW1LdjZLKzBC?=
 =?big5?B?UnZCeDN4ZWhDbjlvM1p4VzcwV2xrVGxrTklZLzFxTFl5QmMwQ2tYOXROSE1TTDN6?=
 =?big5?B?Qk40NGJZRkNLNkJja3NCV3EyLzdoQmtLNEdaNWwrMjJaRUp3UUdtSTk0SjNzdnN5?=
 =?big5?B?eXhxVXEyMGZtZWpKcmFpRWlKblNwU0w1NGZXYTNMYlpWdGJ4eGF0SXFmOEtWRGtC?=
 =?big5?B?d3JkdzBoVldNd2gwSWhlWG1qN1h5S0Jsdkt1dVJlRjAwUmErbFZubmdwQ3htNXUv?=
 =?big5?B?Sk9FQ29ab1hpc0NkSHVicStFZ2p2WnZSdXlzUzMxM2JxZUxyMURzaGtKN0h1aURk?=
 =?big5?B?bzdWTnZSaTljMUV1c2d5K1VoVHBLNFB2VHBEbjZhMGpaT2hxdTIrV3pnMmIrNUV6?=
 =?big5?B?dkhSblpabldJc0pJalcxRm1RQ2NnMytGUkNhdHB1VGxFNnUxZGthQVI0S0huWUtO?=
 =?big5?B?dWZPQjEzUmpXUHNFd0xaSEtQR3BQcVRSbXVhaDNhdmw1T2tXQS9jMFlPSENLZm5Z?=
 =?big5?B?eGxJOHlrZ3pNL1ZPV1AwMHUyZ3V0c2JnU09qTVFFaEtwUlc3dW56L3F1b3NZSVgx?=
 =?big5?B?ZnFoNG41aEhOZitYdW5Vc01BKzBGQXNncWJmSmdpamNicnVZbUJxZXVINTQ4ZFZJ?=
 =?big5?B?eGxCMjNRZ2pkWFJMU1hwV2trOXBTY3ZSNFZBeDNVV0d6S0VVT01EZGNQWlJ3YjZD?=
 =?big5?Q?fBjbJ4CvbZfNnKBK?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df383239-33dd-4bb9-8df6-08de1b6237f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 05:22:59.2408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MfPlLFyBX03N7nd+O9BSk86LKyIc/sfTy5+SCehtA9gFJqcqmioKmlxfS2Y204WsYSTWbpRnE24ncHnv2CEn5ylcWqs1mUAW6ywM18ChEFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6653

PiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9u
ZXQvZmFyYWRheSxmdGdtYWMxMDAueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL25ldC9mYXJhZGF5LGZ0Z21hYzEwMC55YW1sDQo+ID4gaW5kZXggZDE0NDEwMDE4
YmNmLi5kZTY0NmU3ZTNiY2EgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL25ldC9mYXJhZGF5LGZ0Z21hYzEwMC55YW1sDQo+ID4gKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9mYXJhZGF5LGZ0Z21hYzEwMC55YW1sDQo+
ID4gQEAgLTE5LDYgKzE5LDEyIEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgICAgICAgLSBh
c3BlZWQsYXN0MjUwMC1tYWMNCj4gPiAgICAgICAgICAgICAgICAtIGFzcGVlZCxhc3QyNjAwLW1h
Yw0KPiANCj4gSSBkb24ndCBrbm93IGlmIGl0IGlzIHBvc3NpYmxlLCBidXQgaXQgd291bGQgYmUg
Z29vZCB0byBtYXJrIGFzcGVlZCxhc3QyNjAwLW1hYw0KPiBhcyBkZXByZWNhdGVkLg0KPiANCj4g
SSBhbHNvIHRoaW5rIHNvbWUgY29tbWVudHMgd291bGQgYmUgZ29vZCwgZXhwbGFpbmluZyBob3cN
Cj4gYXNwZWVkLGFzdDI2MDAtbWFjMDEgYW5kIGFzcGVlZCxhc3QyNjAwLW1hYzIzIGRpZmZlciBm
cm9tDQo+IGFzcGVlZCxhc3QyNjAwLW1hYywgYW5kIHdoeSB5b3Ugc2hvdWxkIHVzZSB0aGVtLg0K
PiANCg0KVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4NCldlIGtlZXAgImFzcGVlZCxhc3QyNjAw
LW1hYyIgaW4gdGhlIGNvbXBhdGlibGUgbGlzdCBtYWlubHkgZm9yIGJhY2t3YXJkIGNvbXBhdGli
aWxpdHkuDQpUaGVyZSBhcmUgYWxyZWFkeSBtYW55IGV4aXN0aW5nIGRldmljZSB0cmVlcyBhbmQg
c3lzdGVtcyB1c2luZyB0aGlzIHN0cmluZy4NClJlbW92aW5nIG9yIGRlcHJlY2F0aW5nIGl0IHJp
Z2h0IG5vdyBtaWdodCBicmVhayB0aG9zZSBzZXR1cHMuDQoNCkhvd2V2ZXIsIEkgYWdyZWUgdGhh
dCBhZGRpbmcgY29tbWVudHMgdG8gY2xhcmlmeSB0aGUgZGlmZmVyZW5jZXMgYmV0d2VlbiAiYXNw
ZWVkLGFzdDI2MDAtbWFjIiwNCiJhc3BlZWQsYXN0MjYwMC1tYWMwMSIsIGFuZCAiYXNwZWVkLGFz
dDI2MDAtbWFjMjMiIHdvdWxkIGJlIGhlbHBmdWwgZm9yIG5ldyB1c2Vycy4gDQoNCkluIHRoZSBm
dXR1cmUsIGlmIHNvbWVvbmUgc3VibWl0cyBhIG5ldyBEVFMgZm9yIGFuIEFTVDI2MDAtYmFzZWQg
cGxhdGZvcm0sDQpJIHRoaW5rIHRoZXkgc2hvdWxkIGFkZCB0aGUgbmV3IGNvbXBhdGlibGUgc3Ry
aW5nIGFuZCBwcm9wZXJseSBkZXNjcmliZSB0aGUgVFgvUlggZGVsYXkgYW5kIA0KcGh5LW1vZGUg
cHJvcGVydGllcyBpbiB0aGVpciBEVFMuDQoNClRoYW5rcywNCkphY2t5DQo=

