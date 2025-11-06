Return-Path: <netdev+bounces-236456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EADEC3C785
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF483A8D20
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9C1350A08;
	Thu,  6 Nov 2025 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QPcPmWvq"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF35350A14;
	Thu,  6 Nov 2025 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446395; cv=fail; b=ZAeUHfAV+DG0cxkjrJ4O3oefqAJ5SrTWVrmg7ZiG+DYdhrTz7VHTQjm+o8ITC2KmNmdVri7RV1B13qFN0MUXfxGLyahqPHxzYmR0C1XV/P53giFlwNEuDkoSWxGnx2ZllkfRDsEkbP3MkMHJEjTTXyUM1QH7Hq0G9h0aEPkBeV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446395; c=relaxed/simple;
	bh=U0gjCOk2m8JAA4kPqR5Ws7rm0wSpsccVyXS+lQAG7kA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HtBus9XwHBdehq3Xus54/W6mYfpG1BU8afjw+brBa+Gs0W/dEjn9lULAXKjqda9XboyPew2ygqcg3aeDRHVntwsgu2AJH2ugzt/+seOMEw5S+7XWnogdQK4vRlVgEb7Cur4MsqOcq1KoC7UYWxCk6Q56u8CkUvVoUqZhzbscwEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QPcPmWvq; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEE+PME69SXMEetQGkWYLsNyanyPq5YZCu/botkT0fFXPnm3GXnIcYZ6FjNNmkezdI7E/+PJ3WbaOEzOd6qVWHmL31fJcGIXRXFOKGzAYAC4mghhFB8BLyyGfBimFESXbjEG4cLf99Kf2cLrFigTq5Eo20WnYnsu25aItR1XAtC+EJmMk0bTiVFd+GfKAxO1UWcXIBqzmqzLHhuYGb6XIJwgFyry+Lm+77w5D2Ds6W045KhjSNPEE6gBH9A87Sc9goBKzDbncpCriUGOo/4o28WSgsvkM0FP5VKmpArqjgPbKw7j8AhfTHq6iFQXLlqbnScYmeBz3FNHPXNkjddtjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0gjCOk2m8JAA4kPqR5Ws7rm0wSpsccVyXS+lQAG7kA=;
 b=a/IMwM/7JMy9DykgsqIyYaUvKI6CgMSayDFenHEhw0ISubTxJNLZGfZzV+801XOHLRAxBfj2XYUFSKEkkibueDWx0xTZzSvI3cymQjgugMMzKyDdNwH4Li1MbJv8Xnrt2/L4CMj9WdOs8ZgrCzAfMwlqP1NVBKmy7kp+ZVSCAjxiRyVX3S0I8lMdzC8A1l1vUj56BgzpZqFQbtlo/DGowd9OOlwlCAUEBio+AMj+yFF2OuxG/7dRqsQEqQei+577d2ofYhNuZNkIBrtbwDWv8hj02V+9lBRqO2x1MYh3GuajvvrYqgOtzObHYv7RXDuCWKSjeQhLDcw8xn1i4dZugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0gjCOk2m8JAA4kPqR5Ws7rm0wSpsccVyXS+lQAG7kA=;
 b=QPcPmWvqeZRwJqkAToVE5VJTYhXNvyKCDpUYSkc7BCSP366NyByhDHpJ9bTpwfr9P2jrcKdZU1oFI2UA6NY76vW9Fu23cjOtryI5ivROAYu81JSsDCUmK2zKHHvvcMNwbdLffQ3vRTjgXR5GXzEFOJNOcfPVEzKtZ+xcoryS51zOog38MEbBXzc6MrGHymXX/BUbZFr3HdcqrmJhgMqa11GKun6crp0hkFz43JbZ6L4JTzyo9yj+o7th5OakCtqovxTBK5c/KpKnqJAPP8at2wSRm5A9pBvWffvPsk37GfFu2QviMG6fxK8BCrLr7sjz0WDMU996BEtRPFUbXExKGA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GV1PR10MB6660.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 16:26:29 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9275.013; Thu, 6 Nov 2025
 16:26:29 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "olteanv@gmail.com" <olteanv@gmail.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "robh@kernel.org" <robh@kernel.org>,
	"lxu@maxlinear.com" <lxu@maxlinear.com>, "john@phrozen.org"
	<john@phrozen.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"yweng@maxlinear.com" <yweng@maxlinear.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "bxu@maxlinear.com"
	<bxu@maxlinear.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "ajayaraman@maxlinear.com"
	<ajayaraman@maxlinear.com>, "fchan@maxlinear.com" <fchan@maxlinear.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>, "hauke@hauke-m.de" <hauke@hauke-m.de>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jpovazanec@maxlinear.com"
	<jpovazanec@maxlinear.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v7 12/12] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Thread-Topic: [PATCH net-next v7 12/12] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Thread-Index: AQHcTLxDDivhhsZUI0Sg1sdKzKnvuLTiKW4AgAOg3QCAABBvgA==
Date: Thu, 6 Nov 2025 16:26:29 +0000
Message-ID: <471b75b6971dc5fa19984b43042199dec41ca9f3.camel@siemens.com>
References: <cover.1762170107.git.daniel@makrotopia.org>
	 <b567ec1b4beb08fd37abf18b280c56d5d8253c26.1762170107.git.daniel@makrotopia.org>
	 <8f36e6218221bb9dad6aabe4989ee4fc279581ce.camel@siemens.com>
	 <20251106152738.gynuzxztm7by5krl@skbuf>
In-Reply-To: <20251106152738.gynuzxztm7by5krl@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GV1PR10MB6660:EE_
x-ms-office365-filtering-correlation-id: a37e1629-c9a3-4a63-8b35-08de1d513d5a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YWc2NVZXQWZ1QklRU1pWbGgrK2ZzT1R0VVRwWWRTOEFhMTdlNUVoODA5TDJ6?=
 =?utf-8?B?S05CbkRUWDVjSTVEeGxGQzdMdGptMERENlVuZDFuR2RDY0xTenMvOHZndTds?=
 =?utf-8?B?aEF3TGNWMUNkKytQdGlJN0llbEhZVWVhK0oxb3dmcEhrVlcwVHIzTnJiZjRr?=
 =?utf-8?B?c1ZWTEtLOVdSbzFyQVNJakhtK0JjN29aa1dmd1A4ZVJ3TFlibVJ2V255RnFV?=
 =?utf-8?B?ODlTMVg3Q0kxNjUra251RFZ1d3pEdUF4N3g1NTA5cmZXWWZJaXJVbHpzTTVZ?=
 =?utf-8?B?OUdnY21UWE5BbTFzTTJvenFyd21KRWNMVTF1SUo1YUM3U3ZrUUNzVEk0bWIr?=
 =?utf-8?B?VURKK2RnT3RJUzJPUThBOUcwY0hXN0ttdWd4SnJaUDRWeHdZR2lFd2FCTHZk?=
 =?utf-8?B?QTErQ0syK3pTakNVYlBBVmhVRkE4RkRJQ2hkdkRmbENVRGZ1UW1DWnIvdGRx?=
 =?utf-8?B?d092a2sxc2Yra3pGWUZwQzNGK2RnSnlxenBnbEQ1Yy8xc0F3N3BRQjRsZjZo?=
 =?utf-8?B?eHlCM3BnQkcxN1VNYkJROGc3NllnRlpJd0hjNm1HYkFKdU80a3VMZFNrbnND?=
 =?utf-8?B?bjhrSnltenZsYXh6UTBFdENscURPTEorOTVYZWh5TjRjU3RLVmdaUUk0d1Ns?=
 =?utf-8?B?eFRlUzB4Vm4yTm94RnpqN2pXYlc2NnlJb0I0aWIvTXBCdzg1MHZGT1MrUy81?=
 =?utf-8?B?WHRPZWpYWGJTZUZWQXFqUE91MEN6RExjZ3FJNXRsck5IeEtCTnNkOWdIT1g2?=
 =?utf-8?B?OEFjLzhpYlVibUJlVzBlZDg1Q0JWVXVadFhBOWs3bDFUVmN3MUFna3BPQVZ1?=
 =?utf-8?B?cTBkZ09BZzdQT0V4STQxNUd1OFJWdVBmWHV3bmY1R0pCVlZCM3oyd2Jsd0ZX?=
 =?utf-8?B?d0NEVjFCTGt2SHlOYitCT29xWmxaaVJzcHhEd3pJUHJmQ3lXTERPQTg3NWFr?=
 =?utf-8?B?Sjl3MnJvU2FsbG1jUjNpa3dlaHA3SXBWV1BlN3l4bmRwVGhNazRlTk9kMGlP?=
 =?utf-8?B?RHVrUk5SSXhkdTlMZFJvU3dJYmdGRk81YmhnMkJrRkovbmw4VjhxbTBSOWU1?=
 =?utf-8?B?MzZtcDdST0lVeUlzRHdyaUVUZUplVjczVDZiczVaeG1mcUFrcmJSYjFhSWxl?=
 =?utf-8?B?VUFMeFFkSG1GZmxoVHdLb3dQem1oZWo0YnhkVUM1MFhEQzlWdGZnYnF0bkkw?=
 =?utf-8?B?cFVKS25LUFhaaFArQUFhK2JoTXI3bG9IVWtMR0JCeFpQc01FNnJNL2UvRTVh?=
 =?utf-8?B?dTYyT2tVL0pwYXIrajdWd1VWZEhkcWVuV1NIRzJRb2RGMWlETTZIbzJvS0Ez?=
 =?utf-8?B?d3A2aFduTDZRQnM2djZhaWplbURYOXJIUENiYkNqUW5PUDVLUUJlZE9zQnI0?=
 =?utf-8?B?UnBVQzBCdGp4eVpubjhOQTZUL1dBSTZmYm9Fcmdsc1NhQTBvZENWRFlrMXJ0?=
 =?utf-8?B?aTRHU1NyaU5IK3BpQzhPckNxaXVVY1VGV0d0TEoxOEIrRjJMQWpnZ0dvSUtH?=
 =?utf-8?B?N2tPWE1iMy9sMVJ3MllKbmhxbnRLK1lBdFN3VDZISGpKcldpeE9VZkxJdTJW?=
 =?utf-8?B?dzR0YWhQNEwrcGZSNzVuKzhBanZlQTdJTmxpWUpLMHVJamJ4aXFmQlRaZjJ6?=
 =?utf-8?B?MkE3UGVlbDNJZTJYV0FxKzEvajRrS0xxU3NFb0hlbWFLN25Idjl3aHlpU2xw?=
 =?utf-8?B?Q3NKb1kxUUo1djdSMm80RG15WHFHZXNMSFpmOGVNWDFURy9Na0V3TnY4UGh1?=
 =?utf-8?B?emI0WnhoUUNlWU55amowWUdwSHNFQ3BXaytPWjh0NnNmSmxwT0MwcXBTdTlk?=
 =?utf-8?B?NmkveTZiUEppRE12V0kvOEhvcUx0UDEzYXlOdWtJdjhyUHFEMFppaEt5Q2ZP?=
 =?utf-8?B?V2g0WWg1Vkp1dDNydjY1TzJEMUp1L09ib0o0NkRlczRsYjlyWmxRc3dtOUhz?=
 =?utf-8?B?NGlSdlVvVnpKVGlGblh6TktnWDRLNGl5eXorYTFIU0NUZ2UvWmZsVWJiTSt3?=
 =?utf-8?B?akpBa2pqRndnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFMzbHRVWjdtZlF0T3RmcHZ3VkVHbG5WSDIvRTZ2VDRHdWsrOTcxM0Z2U2g4?=
 =?utf-8?B?cUdXcnFsTyt2aTN1U2IzQnlhWTB3NjRhMHR4SHdML2xxSWR1azl2b1ErOGti?=
 =?utf-8?B?dmJrQ3ZMUURhZXJ3MTE4RDM2OXNuZ1RQa21qYXVCRGhuTmpIQm01L0ZrSmFV?=
 =?utf-8?B?SEErK0poWGcxQkpwMVJyNGFNa3JwOXRjYVJwKzU0Y0xKV216OC9vMlppUGly?=
 =?utf-8?B?QjdNUEg0ZlNEVHZyd0N1em03RXZoaUpZR0NCVU9xa2NFcElyODNwOVRUbGw0?=
 =?utf-8?B?VW9QTDUxdmdSWTlDN1R0My9CL3RZSHpVVUx3Q3RxRjlZdFRoczNlalV5eEp6?=
 =?utf-8?B?ZWdaMkpWR0lZNjRIS2dQcVVaajhzZk84ZVF2alVOSWswZ3ZOdnRiYWkzVWYw?=
 =?utf-8?B?TGNkdkNOUXAzV1M0WElDalZOODZjd01rbC9tQnZ3cFRNOGI4V0h2SWdkMW1F?=
 =?utf-8?B?ZDdzQU81SDFIcmdjdGQxUncyS3A2aEVRR0JQYktkd1FIUDg4V0lVZHZoLy9Z?=
 =?utf-8?B?RVYxd3NmYWMwcVZxZ3Y5cXJEV3NDY096Z3RwMU1jZ2w0bUlrZlpxQjlYSUlZ?=
 =?utf-8?B?MHRTSEtzS1lwUlRtd3IwR2FhdExjdEFuaUt4TGVSd2NsVUcrdGdZZHZmZzlP?=
 =?utf-8?B?UXhvK29idUdqVHBHcjVKTjVVOWdpbEFXcStXUXhBSC9FOWVzWkh0eWYyN1RD?=
 =?utf-8?B?N3lUamw4UHkwdzNZQ1F4TGVUclNGQWY4ZW8zQW9Jb1ljdTd5TE9sUmMvMHBo?=
 =?utf-8?B?VmY2L2ZzQTBBcDc0clZDM0hVQmRBUDRETEQ0QkJLUzFBOFcrODROa3F3SkU0?=
 =?utf-8?B?OGtRSkVaMm5ibHZwMkJ4RHV3MStxeWlZTDlyZmcrOXYzQk1SdmFJZG1jL0p5?=
 =?utf-8?B?bkF0aHRyWC9kYnBNTWgvSFBBR1Jva1JiTzNOVk05UmhEV2VyNmh1aTd3M0RO?=
 =?utf-8?B?RzlhKzhheWJQZjlmKzdHUTcvaHhVRXA0bVl0ZzBobzc4RVhMRk5HMGxoZGNB?=
 =?utf-8?B?SEFMNFl1M2p5VDFySjRMTUFJQm0rZXNpZWJDVG1rTXp2cGF4RHo0OS9qcnNV?=
 =?utf-8?B?NzdCdGlibVI4MHVXcXFaR2svTmgvM1dhNmtvRFVBNnF3MlFSSVNtL1pqUWJh?=
 =?utf-8?B?dENnaGNNbmNpNWJjMFFNTm42eFljYWNxZzZ4a291T3pITFJQczNXSlJlbWI0?=
 =?utf-8?B?dEhVZitDRVI3OFJFN1JmTDlISC84SHJwbGVjSCtUQ0VCZnF5VHpVVWV0ZnNC?=
 =?utf-8?B?NklxRjJvR1FmaWpjQ0FmTUVYampDOE9KNGNwczFnWnB5Q1hONmJNMVVJOTBW?=
 =?utf-8?B?dW9zQTlKOGJVODFINytmWWhLcXREanZ0a010UUprSDJQcUFTYnZNQVg2OFRh?=
 =?utf-8?B?dnB2L0dxeDNRODlCKzNlRmdzOHRDUGFFQUlXWSt4ajVwZVNFUjMvWTJnSDJE?=
 =?utf-8?B?c240U01oMzlsU0xVNkdkU2RJRnJlUmd6ckJsTzlJNEI5Rm84WnIvSUJ1MSt3?=
 =?utf-8?B?UzN6ZHBmcUNUcjQ0a2dENElwTFN1VjhGOE9xTTVLOTNOb1BTRE1wbUx5aTRH?=
 =?utf-8?B?NytzZnZyb1FOOW54ZkhhZEVDU1d3cVVISHZWc1A1aU1SQzdCUm8wTE9BOGxB?=
 =?utf-8?B?MExXckY5SVNmbEZTc2xUTVZlaXZDWjNDdUZBaHlHcWEzME1HR0ZNTGlrWlIv?=
 =?utf-8?B?QlhwanNEaWNYbjFKb0lQai9Gc01NZGdwV1BObnhOcUtVRG1lT1luOG9UTktB?=
 =?utf-8?B?TENuL3p5YXhnNG10b2RVcjZHa2c2Ty9wc0ZyMmtoZ01CNnVseFNXbExRN0Vy?=
 =?utf-8?B?N2RPTzdHd1NWeThrbXowQTBLRzdFbkV5SVRraWNNUGp5QVhqYUJxR3hMUlpU?=
 =?utf-8?B?dFJMT1VGYk55K2xpTDE1RUlrRmxLZWNSZXppRTByVTZ0RFdENWMrbk55SXBJ?=
 =?utf-8?B?WkJVOEhzSXNXSE12WEhIZnA5SmJtY2xjM2diTFZ5bnRkcHVya3RmVFZmc1NC?=
 =?utf-8?B?SUltcFVId2RHOVM4cUh4MGhWTWtWTFNHaFMxVDd3czFaM0dXejJMNmRWSE5z?=
 =?utf-8?B?aXhCN1h2aXJmdXdSL2RVMEZTbC9sN2VLenE4NUdSUGFmYmhhVFAzM3RmNVJK?=
 =?utf-8?B?QWhHYSsxeUNEdG5PM1hZU3VJSjIwakkrMytEb2JBa05BbnVCR3RTdFhUbDVD?=
 =?utf-8?Q?HoxSiXiMCQL46RS+gDA1TIU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <907DA6C98024B4418F4DCDE209430E00@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a37e1629-c9a3-4a63-8b35-08de1d513d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 16:26:29.1415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XgY83ycY+HCfMpUh7FHEVzP00eg9qi3Ls4j1Ab/VDXixerFHL+80U5BvI9pyeTx9Pc11+9wFMfLoHkZTLAiQmOj1oW3KZv8NPFrKMNiwD3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6660

SGkgVmxhZGltaXIsDQoNCk9uIFRodSwgMjAyNS0xMS0wNiBhdCAxNzoyNyArMDIwMCwgVmxhZGlt
aXIgT2x0ZWFuIHdyb3RlOg0KPiA+IFRoZSByZW1haW5pbmcgZmFpbGluZyB0ZXN0IGNhc2VzIGFy
ZToNCj4gPiBURVNUOiBWTEFOIG92ZXIgdmxhbl9maWx0ZXJpbmc9MSBicmlkZ2VkIHBvcnQ6IFVu
aWNhc3QgSVB2NCB0byB1bmtub3duIE1BQyBhZGRyZXNzwqDCoCBbRkFJTF0NCj4gPiDCoMKgwqDC
oMKgwqDCoMKgIHJlY2VwdGlvbiBzdWNjZWVkZWQsIGJ1dCBzaG91bGQgaGF2ZSBmYWlsZWQNCj4g
PiBURVNUOiBWTEFOIG92ZXIgdmxhbl9maWx0ZXJpbmc9MSBicmlkZ2VkIHBvcnQ6IFVuaWNhc3Qg
SVB2NCB0byB1bmtub3duIE1BQyBhZGRyZXNzLCBhbGxtdWx0acKgwqAgW0ZBSUxdDQo+ID4gwqDC
oMKgwqDCoMKgwqDCoCByZWNlcHRpb24gc3VjY2VlZGVkLCBidXQgc2hvdWxkIGhhdmUgZmFpbGVk
DQo+ID4gDQo+ID4gU28gZmFyIEkgZGlkbid0IG5vdGljZSBhbnkgcHJvYmxlbXMgd2l0aCB1bnRh
Z2dlZCByZWFkLXdvcmQgSVAgdHJhZmZpYyBvdmVyDQo+ID4gR1NXMTQ1IHBvcnRzLg0KPiA+IA0K
PiA+IERvIHlvdSBoYXZlIGEgc3VnZ2VzdGlvbiB3aGF0IGNvdWxkIEkgY2hlY2sgZnVydGhlciBy
ZWdhcmRpbmcgdGhlIGZhaWxpbmcNCj4gPiB0ZXN0IGNhc2VzPyBBcyBJIHVuZGVyc3Rvb2QsIGFs
bCBvZiB0aGVtIHBhc3Mgb24geW91ciBzaWRlPw0KPiANCj4gVGhlc2UgZmFpbHVyZXMgbWVhbiB0
aGF0IHRoZSB0ZXN0IHRoaW5rcyB0aGUgcG9ydCBpbXBsZW1lbnRzIElGRl9VTklDQVNUX0ZMVCwN
Cj4geWV0IGl0IGRvZXNuJ3QgZHJvcCB1bnJlZ2lzdGVyZWQgdHJhZmZpYy4NCj4gDQo+IAlbICRu
b191bmljYXN0X2ZsdCA9IHRydWUgXSAmJiBzaG91bGRfcmVjZWl2ZT10cnVlIHx8IHNob3VsZF9y
ZWNlaXZlPWZhbHNlDQo+IAljaGVja19yY3YgJHJjdl9pZl9uYW1lICJVbmljYXN0IElQdjQgdG8g
dW5rbm93biBNQUMgYWRkcmVzcyIgXA0KPiAJCSIkc21hYyA+ICRVTktOT1dOX1VDX0FERFIxLCBl
dGhlcnR5cGUgSVB2NCAoMHgwODAwKSIgXA0KPiAJCSRzaG91bGRfcmVjZWl2ZSAiJHRlc3RfbmFt
ZSINCj4gDQo+IEJ1dCBEU0EgZG9lc24ndCByZXBvcnQgSUZGX1VOSUNBU1RfRkxUIGZvciB0aGlz
IHN3aXRjaCwgYmVjYXVzZSBpdCBkb2Vzbid0IGZ1bGZpbGwNCj4gdGhlIGRzYV9zd2l0Y2hfc3Vw
cG9ydHNfdWNfZmlsdGVyaW5nKCkgcmVxdWlyZW1lbnRzLiBTbyBzaG91bGRfcmVjZWl2ZSBzaG91
bGQgaGF2ZQ0KPiBiZWVuIHRydWUsIGFuZCB0aGUgcXVlc3Rpb24gYmVjb21lcyB3aHkgZG9lcyB0
aGlzIGNvZGUgc25pcHBldCBzZXQgbm9fdW5pY2FzdF9mbHQ9ZmFsc2U6DQo+IA0KPiB2bGFuX292
ZXJfYnJpZGdlZF9wb3J0KCkNCj4gew0KPiAJbG9jYWwgbm9fdW5pY2FzdF9mbHQ9dHJ1ZQ0KPiAJ
bG9jYWwgdmxhbl9maWx0ZXJpbmc9JDENCj4gCWxvY2FsIHNraXBfcHRwPWZhbHNlDQo+IA0KPiAJ
IyBicl9tYW5hZ2VfcHJvbWlzYygpIHdpbGwgbm90IGZvcmNlIGEgc2luZ2xlIHZsYW5fZmlsdGVy
aW5nIHBvcnQgdG8NCj4gCSMgcHJvbWlzY3VvdXMgbW9kZSwgc28gd2Ugc2hvdWxkIHN0aWxsIGV4
cGVjdCB1bmljYXN0IGZpbHRlcmluZyB0byB0YWtlDQo+IAkjIHBsYWNlIGlmIHRoZSBkZXZpY2Ug
Y2FuIGRvIGl0Lg0KPiAJaWYgWyAkKGhhc191bmljYXN0X2ZsdCAkaDIpID0geWVzIF0gJiYgWyAk
dmxhbl9maWx0ZXJpbmcgPSAxIF07IHRoZW4NCj4gCQlub191bmljYXN0X2ZsdD1mYWxzZQ0KPiAJ
ZmkNCj4gDQo+IEJlY2F1c2UgSUZGX1VOSUNBU1RfRkxUIGlzIG5vdCBhIFVBUEktdmlzaWJsZSBw
cm9wZXJ0eSwgaGFzX3VuaWNhc3RfZmx0KCkgZG9lcw0KPiBhbiBpbmRpcmVjdCBjaGVjazogaXQg
Y3JlYXRlcyBhIG1hY3ZsYW4gdXBwZXIgd2l0aCBhIGRpZmZlcmVudCBNQUMgYWRkcmVzcyB0aGFu
DQo+IHRoZSBwaHlzaWNhbCBpbnRlcmZhY2UncywgYW5kIHRoaXMgcmVzdWx0cyBpbiBhIGRldl91
Y19hZGQoKSBpbiB0aGUga2VybmVsLg0KPiBJZiB0aGUgdW5pY2FzdCBhZGRyZXNzIGlzIG5vbi1l
bXB0eSBidXQgdGhlIGRldmljZSBkb2Vzbid0IGhhdmUgSUZGX1VOSUNBU1RfRkxULA0KPiBfX2Rl
dl9zZXRfcnhfbW9kZSgpIG1ha2VzIHRoZSBpbnRlcmZhY2UgcHJvbWlzY3VvdXMsIHdoaWNoIGhh
c191bmljYXN0X2ZsdCgpDQo+IHRoZW4gdGVzdHMuDQoNCmhlcmUgaXMgdGhlIGNvcnJlc3BvbmRp
bmcga2VybmVsIGxvZyBwcmVjZWRpbmcgdGhlIGZhaWxpbmcgdGVzdCBjYXNlcywgbWF5YmUgaXQN
Cm1pZ2h0IGhlbHA/DQoNClsgIDUzOS44MzYwNjJdIG14bC1nc3cxeHggODAwMGYwMC5tZGlvOjAw
IGxhbjE6IGxlZnQgYWxsbXVsdGljYXN0IG1vZGUNClsgIDUzOS44NDUwNTNdIGFtNjUtY3Bzdy1u
dXNzIDgwMDAwMDAuZXRoZXJuZXQgZXRoMDogbGVmdCBhbGxtdWx0aWNhc3QgbW9kZQ0KWyAgNTM5
Ljg1MzQwMV0gYnIwOiBwb3J0IDEobGFuMSkgZW50ZXJlZCBkaXNhYmxlZCBzdGF0ZQ0KWyAgNTQ1
LjY0MTAwMV0gYW02NS1jcHN3LW51c3MgODAwMDAwMC5ldGhlcm5ldDogUmVtb3ZpbmcgdmxhbiAx
IGZyb20gdmxhbiBmaWx0ZXINClsgIDU0Ni4wNzU0MTFdIG14bC1nc3cxeHggODAwMGYwMC5tZGlv
OjAwIGxhbjE6IExpbmsgaXMgRG93bg0KWyAgNTQ2LjY2Njk0NF0gbXhsLWdzdzF4eCA4MDAwZjAw
Lm1kaW86MDAgbGFuMDogTGluayBpcyBEb3duDQpbICA1NDcuNzc5MzA4XSBteGwtZ3N3MXh4IDgw
MDBmMDAubWRpbzowMCBsYW4xOiBjb25maWd1cmluZyBmb3IgcGh5L2ludGVybmFsIGxpbmsgbW9k
ZQ0KWyAgNTQ4LjgwMzkwM10gbXhsLWdzdzF4eCA4MDAwZjAwLm1kaW86MDAgbGFuMDogY29uZmln
dXJpbmcgZm9yIHBoeS9pbnRlcm5hbCBsaW5rIG1vZGUNClsgIDU0OS41NjE4MjldIG14bC1nc3cx
eHggODAwMGYwMC5tZGlvOjAwIGxhbjE6IGNvbmZpZ3VyaW5nIGZvciBwaHkvaW50ZXJuYWwgbGlu
ayBtb2RlDQpbICA1NTAuMzY2MzAwXSBteGwtZ3N3MXh4IDgwMDBmMDAubWRpbzowMCBsYW4xOiBj
b25maWd1cmluZyBmb3IgcGh5L2ludGVybmFsIGxpbmsgbW9kZQ0KWyAgNTUwLjM5NTAzMl0gYnIw
OiBwb3J0IDEobGFuMSkgZW50ZXJlZCBibG9ja2luZyBzdGF0ZQ0KWyAgNTUwLjQwMTA2M10gYnIw
OiBwb3J0IDEobGFuMSkgZW50ZXJlZCBkaXNhYmxlZCBzdGF0ZQ0KWyAgNTUwLjQwNjQ3MF0gbXhs
LWdzdzF4eCA4MDAwZjAwLm1kaW86MDAgbGFuMTogZW50ZXJlZCBhbGxtdWx0aWNhc3QgbW9kZQ0K
WyAgNTUwLjQxMzg2OF0gYW02NS1jcHN3LW51c3MgODAwMDAwMC5ldGhlcm5ldCBldGgwOiBlbnRl
cmVkIGFsbG11bHRpY2FzdCBtb2RlDQpbICA1NTAuNDQwMTExXSBhbTY1LWNwc3ctbnVzcyA4MDAw
MDAwLmV0aGVybmV0OiBBZGRpbmcgdmxhbiAxIHRvIHZsYW4gZmlsdGVyDQpbICA1NTAuNDY1NDc5
XSBhbTY1LWNwc3ctbnVzcyA4MDAwMDAwLmV0aGVybmV0OiBBZGRpbmcgdmxhbiAxMDAgdG8gdmxh
biBmaWx0ZXINClsgIDU1Mi41MTkyMzJdIG14bC1nc3cxeHggODAwMGYwMC5tZGlvOjAwIGxhbjE6
IExpbmsgaXMgVXAgLSAxMDBNYnBzL0Z1bGwgLSBmbG93IGNvbnRyb2wgcngvdHgNClsgIDU1Mi41
MzA1MTNdIGJyMDogcG9ydCAxKGxhbjEpIGVudGVyZWQgYmxvY2tpbmcgc3RhdGUNClsgIDU1Mi41
MzY0NjNdIGJyMDogcG9ydCAxKGxhbjEpIGVudGVyZWQgZm9yd2FyZGluZyBzdGF0ZQ0KWyAgNTUy
Ljk5OTMzMF0gbXhsLWdzdzF4eCA4MDAwZjAwLm1kaW86MDAgbGFuMDogTGluayBpcyBVcCAtIDEw
ME1icHMvRnVsbCAtIGZsb3cgY29udHJvbCByeC90eA0KWyAgNTgxLjg5OTI2Ml0gbGFuMS4xMDA6
IGVudGVyZWQgcHJvbWlzY3VvdXMgbW9kZQ0KWyAgNTkyLjk5NTU3NF0gbGFuMS4xMDA6IGxlZnQg
cHJvbWlzY3VvdXMgbW9kZQ0KWyAgNTk2LjY2NTAyMl0gbGFuMS4xMDA6IGVudGVyZWQgYWxsbXVs
dGljYXN0IG1vZGUNClsgIDYwNy43ODk3NzhdIGxhbjEuMTAwOiBsZWZ0IGFsbG11bHRpY2FzdCBt
b2RlDQotLQ0KVEVTVDogVkxBTiBvdmVyIHZsYW5fZmlsdGVyaW5nPTEgYnJpZGdlZCBwb3J0OiBV
bmljYXN0IElQdjQgdG8gbWFjdmxhbiBNQUMgYWRkcmVzcyAgIFsgT0sgXQ0KVEVTVDogVkxBTiBv
dmVyIHZsYW5fZmlsdGVyaW5nPTEgYnJpZGdlZCBwb3J0OiBVbmljYXN0IElQdjQgdG8gdW5rbm93
biBNQUMgYWRkcmVzcyAgIFtGQUlMXQ0KICAgICAgICByZWNlcHRpb24gc3VjY2VlZGVkLCBidXQg
c2hvdWxkIGhhdmUgZmFpbGVkDQpURVNUOiBWTEFOIG92ZXIgdmxhbl9maWx0ZXJpbmc9MSBicmlk
Z2VkIHBvcnQ6IFVuaWNhc3QgSVB2NCB0byB1bmtub3duIE1BQyBhZGRyZXNzLCBwcm9taXNjICAg
WyBPSyBdDQpURVNUOiBWTEFOIG92ZXIgdmxhbl9maWx0ZXJpbmc9MSBicmlkZ2VkIHBvcnQ6IFVu
aWNhc3QgSVB2NCB0byB1bmtub3duIE1BQyBhZGRyZXNzLCBhbGxtdWx0aSAgIFtGQUlMXQ0KICAg
ICAgICByZWNlcHRpb24gc3VjY2VlZGVkLCBidXQgc2hvdWxkIGhhdmUgZmFpbGVkDQoNCi0tIA0K
QWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

