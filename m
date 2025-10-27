Return-Path: <netdev+bounces-233158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4726C0D482
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 12:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F2819A8075
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 11:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8072FE58E;
	Mon, 27 Oct 2025 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="eQAg/IIn"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011067.outbound.protection.outlook.com [52.101.65.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA78B2EFDB2;
	Mon, 27 Oct 2025 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761565690; cv=fail; b=k89hnNQxT+Q44sZIaa9vgsfO9Twn9CCRudZ0eFtNnORJDzTm2WsVcbBJSslzNxCzpnq5PCoKcI5Mf8lptqtnsO394NYh+6g0HHelAnURrlmHqYPBYHSVTbE6UuUZUBjdg+9wTlFOUTUVbsVUpFSPhj/fhIcglrCfRZwvLM6COZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761565690; c=relaxed/simple;
	bh=RA8S8CmAZf6twy7SObFXQShy+vb7h8gboooVDq85tdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SHwOvA5elZwgab90DUNtP5en0BW3zt/gGOiHtscTj8g+RFiivCbwiHCV2EmQg8Cpf7PCUbIVXxfL9j/FsiDUg+xkL8FJ6TxwDN7aiUfuOWfYJHHzm3URUAjx+1GNjVO31jkemwUnUP7YoMBdIxFCMO8bCLRrSbrHHuu0BMZ4C9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=eQAg/IIn; arc=fail smtp.client-ip=52.101.65.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFwV4PoT2Gy+UwiUOoB5fWzvZuqOsnx853qCy+WHcyY23SwhNJ0gWDh235Quy6loONNiCToDJE5Hlu5wgRnJ2hBJkcncOAXAYxyUlMsN01QE++D/DqoSgUB2A6zMfaDBSEMch5hP3aihpxAZfIsJ3Ojrb6j4CZQyOA9JemBLVCRNINea+COw5Jimn3V1DZtlTtIW22nCYnvb73dVL6cUHWxd8Pwe9hp7joEEA45OcMtJW7Z8QVNtJ2Sv9vPzWcxSwWR934Y07gsjf3+Xygop5WrleWOGdOn0G80L31zJLkXG2ZRhGtT4Z+HrBoBelrvp+7F5VoVzZ9rGxEAkJYAt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RA8S8CmAZf6twy7SObFXQShy+vb7h8gboooVDq85tdE=;
 b=oneQ83hhWXkwfCdDPKwO3ScerPJdNn3N7w4Hte+2M4lQo8vNakoMJx27C/p6LOsTImbeNhp4XttiTGXWETNakkUNv7uB1NJ+Zxinan8/lFFrygYnKxP5oYqjEa8wGOSUzEtL3joFkRdJLxM/EydT5EzNmQJJTqewtJ6ebllG0I78eNwVGjzDwY8DpA6uaOWit3GeSkIztTDxtPdUcFQmG3tM7aMhIP8gxfa2c3VA4oLEIsJacfp3gMpL6AwYIKQACtGkvDOt/TC2WjbkhiEkkDHnmtKH6NLzn37aufkqXkrwYeQ1uBsc2p2VV0Hy767mEEueGgGGplNLOTmAtXKuTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RA8S8CmAZf6twy7SObFXQShy+vb7h8gboooVDq85tdE=;
 b=eQAg/IInYmyqDBH0tQqy6jqFJAx4LhvI1ztSrjSyZGcNSAFOdwxcvi1NONHGek+FngaEv74Bnw3iAYCQyZG4DzhiH0f6RwQycagLmAOCPXczK0CS02BQq0+VpWuPJznNkUYZgYN4jgkoNqrleE21tdHfsK/Fm6hTNlhgb+tg02MnC3yac28mwE2u75lQrljmNz2Xvq0YTXnniHAvwsOWIaB3vIRO+5QCA4K7TkLxozLGNddTo+um0+KirjupQNHdRuz4Q8UBKRBKI5sYgdfAkaGilX/LoGz0el6dwGZYYxHG+TOH4p0Zt/4C4a60b9KCXxiBqUoZDSo/5KSx+QuDkg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 11:48:05 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 11:48:04 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "robh@kernel.org" <robh@kernel.org>, "lxu@maxlinear.com"
	<lxu@maxlinear.com>, "john@phrozen.org" <john@phrozen.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "yweng@maxlinear.com"
	<yweng@maxlinear.com>, "bxu@maxlinear.com" <bxu@maxlinear.com>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>, "ajayaraman@maxlinear.com"
	<ajayaraman@maxlinear.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>, "horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "jpovazanec@maxlinear.com"
	<jpovazanec@maxlinear.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v3 11/12] net: dsa: add tagging driver for
 MaxLinear GSW1xx switch family
Thread-Topic: [PATCH net-next v3 11/12] net: dsa: add tagging driver for
 MaxLinear GSW1xx switch family
Thread-Index: AQHcRtMK5MxQV+IwlkiTFIYTJIA9vLTV4XIA
Date: Mon, 27 Oct 2025 11:48:03 +0000
Message-ID: <232e9b3158d06308278fd670e6bbe71b3d3fbf30.camel@siemens.com>
References: <cover.1761521845.git.daniel@makrotopia.org>
	 <81815f0c5616d8b1fe47ec9e292755b38c42e491.1761521845.git.daniel@makrotopia.org>
In-Reply-To:
 <81815f0c5616d8b1fe47ec9e292755b38c42e491.1761521845.git.daniel@makrotopia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AM7PR10MB3956:EE_
x-ms-office365-filtering-correlation-id: 91e6d112-388a-4a1d-4946-08de154eb01c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dEFKRDVyOVc2YUZaSlBqbHhDUTZmZkFZblhFMWdENVI1T0sySmRYenZPVTJa?=
 =?utf-8?B?T1VqWS9MSXM4NGQ3YXZlYUdBbjh3N1AyK0xDek1aU3M3M0VkK3NkQ3BrdU95?=
 =?utf-8?B?bHBkRzJZMEhVRDFLUHNBTkZScGN4dnFtazZYMDNSSWt4TmhKaE12U2U0Y0gv?=
 =?utf-8?B?bjA3UEhxYUdGRkdDSEtMWjg0NDhpb2luU1o0V1ozczJPOUg4VTY4eStpa084?=
 =?utf-8?B?L3Z2elIycTUvOUpmR2cxcE5vRU1CajBEUC9JR1NuNHdvTk96Rk5yOERyM3hu?=
 =?utf-8?B?clAxSGJTb2NLcFJicDIxbEFMamcvTi9TL3ZGelJCbnZMVW1zeHVGS3dETGk1?=
 =?utf-8?B?QzdlUCtTTzFNL1dNdGdoOTFiOVNqNU5GZ1h3dk5vbUhienZFUnc3eWdadWFr?=
 =?utf-8?B?MFRXQUs0dXJxTGxYK1RVR1AzT2RFUW56d2VEY1c0MWdDVWtnemhmbHhNU2xW?=
 =?utf-8?B?cEJoYy82aEdEQTZnN2FZT05IVFdyMk9icTBJM3NEbzRZRTJjZ29iZEh0Ujdm?=
 =?utf-8?B?TG1xUTdCZjk1Y1pJUEkrdnppTUJkdG9FSHc0S1BHd1p6RHB5THFla2VYYVpi?=
 =?utf-8?B?WXd0V0doYTZGNS8yak9NeC9rdkRNdmN6cTliUkNEUE1FNHYvTUkzY3U2aS9P?=
 =?utf-8?B?MXBxNkxOdVpjTHlWNTdkcGV5dTNWUmpzblByVGlCUGhwR2lzM1g2SzdKR0RZ?=
 =?utf-8?B?c1BCWEFDVGU3VjZUQUZwMXhBbHhkKzNtY2M5dVZvMTBaNHdCUVFiYlNTelMw?=
 =?utf-8?B?cGIwY1RFWE4zUVM2Ni9nZjVIaFRheFNkR09DLy9uT2drSWVsZFpOL0JBZHln?=
 =?utf-8?B?Nkc5SVlLVkRZTEYxTzN5NlJ1VkIweU9GdC9lcEpnS21lWjVxdTZGNHgrRkky?=
 =?utf-8?B?WTFUVENyVjdSbWZYYjRkOEFBREhMMVBFcjNROSsrN05mR1NXUmZOcS9OQll4?=
 =?utf-8?B?OWdWNW5QcFgxNjhHc0tHN0xMdG1YUGZjb2NHOXNQbnZOK2pLRmZEZU11ek85?=
 =?utf-8?B?eERtRmREL3dJK2ZuN1llbXFUOXZ0cS9CdEEzeW4reXcxWlZTczZCc1RWYVNz?=
 =?utf-8?B?U0pPeENrN0tzbGI4ZXRpbGFzMWowNnY0d05qb1hieEg3Z3JwZitWZ1FHNWY2?=
 =?utf-8?B?R3RxZk9qWlJERlZ2elJOUUF6TzBNLzRCTzhaTmtYdkYwZjI3L2tTdlBqVkRX?=
 =?utf-8?B?a2h1Ri90dEQ3WEc4Q3piWm9KM2tNTnlLV21samdBT3Nvc2c4QnFIb2ZzYzVR?=
 =?utf-8?B?QW1zcVhDZ2xWcmdiRVhwOU5yRXExbDN3emI4azV1aEdtOHQ3cklVWi9Gc282?=
 =?utf-8?B?bm9qVWM4Y1J2c0ZIT1V4Q3k1NTR6SnN4TTBQUzREVDNiK295cE9LU2F2RWZm?=
 =?utf-8?B?Wnd3QTZEMDdZcXFsalA4c1VxQmtRb0xnY0Z6eUtOOUxBbG1uM3I4MkNmN05a?=
 =?utf-8?B?b3dDdjdaVEZybVBMTkVqNE1MUE8wWVBjYmJRdS9aOEpVSHdMT05HaDI2bW94?=
 =?utf-8?B?RGtsendiSEZTVlIzVWYwa3RRY2NUVEFoNVl6NnByME5EZmY0UnpMYUs4bDJm?=
 =?utf-8?B?b0JBYWthVWFFaTF3bWVWK3FzWlo4RUZtb2VYQlBqQUZJWjArbDFQYzdtZ3I3?=
 =?utf-8?B?SUFqMzJzL0FFYU9sYWd6dU5sTzlkZWtJUDZIb3FuVnFNaGxJWUhIN0xQczZ5?=
 =?utf-8?B?cHU3U3o2WjBUc3lqZm5iWG4yZjVlQk4wa1orM01KL1lPb0pZYjhwQW5pd3hW?=
 =?utf-8?B?RDErK2t1cGZGSnoveFhoU2RtdEdZZ2hrSm5MQU9nZG5GNnBzMDU1VTdneEFt?=
 =?utf-8?B?dUtGdTBUeTNZUHBtbXZGaDFOTVdGZXdWNkFGb0NPbDBKWFlKWUJIMXZoZUF3?=
 =?utf-8?B?L2NIS1liZnNBa3RIWERXMmRNZ3ZHSDI4N2RLVFJtdmRHVzZ6cWxkdVNiVkhK?=
 =?utf-8?B?aE5QWWc4VXhsNXl4STJiMlRCWlJGZ3pVRU5IT3JqRWpxZFBBNktLTDZIOG1n?=
 =?utf-8?B?WUcyeWhiUE1xSmd4KzRmUWpOS1hhY01EdVZ4dytZYXJxQldaaHdsSWtNd1l1?=
 =?utf-8?Q?kRW2Uo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGdKcDUvSy9NR21kR1NUdHpoNVBuVnIrUGxpYWdZWVZERWZVQ0ZNbmVRZlA4?=
 =?utf-8?B?TWhQYVFwYWlDaFJrYXJvaWxOY0xKSHJiYU1WR1dENkIxVU5xaWFUcjBjWDE0?=
 =?utf-8?B?S1gxQ1Jnek9YeXVqaVlTVkJlZFd5V285RDVwd0t4S21VSW0yZWo0MUl4SG1F?=
 =?utf-8?B?Rkd1NXpSWHZ5SVR6bmEwUTladmhzcWdZWTUwdFBqUGVyMHJRSGY0NkVxZWN4?=
 =?utf-8?B?VHBpdURnUWRBMVpBbUJuZWdPNFpLNjdnME5jbVk4RmpZVUx0VGllNVlWQmRl?=
 =?utf-8?B?Wko3cHZ3RzFIZy93YVMySFNtYVNIMllueTQ4dE9DdUJUV3VBbVpiRFQ4cmxm?=
 =?utf-8?B?elpnTFkzL001bzJDK0FuNnJvK1hCL2hwM3dNeXVuY0FkS2xlRTY4VUxiVmp3?=
 =?utf-8?B?UlZqQmlyT1NxU3FnMU9TLzNNMXhFSiszeDUxS2JPMGJrVU5WSTdnRDkwQ1FV?=
 =?utf-8?B?VDdZeXhPTmRRRWJSVnV6cmhueFgzTC92QlpEaXgyOGxCNXVDSTc0UnNZdmgv?=
 =?utf-8?B?bEEyOUpEajlITDI2R1dLdUtVczJ4T0M1WDQ2T0RQNmxBeHVzZzNiSGNZdjYw?=
 =?utf-8?B?OUh3NFVKZ3FzLzRmeC9zaU5oYXkvNzRtejA3SXhWR3ZiKy9YN3BPaklGOEFK?=
 =?utf-8?B?ejU4dG5US2N5Vjh6MU03U09aQ005MjdieUxhNGMrKzU4dFllWUdZLzZWRE0r?=
 =?utf-8?B?SzlwQTJnYVVITXhoQ0RFeFAvZ29ldWFFNnlzNXFxUVhWbkNKU2I2YnJockg4?=
 =?utf-8?B?b3gxZnFKM2h5WmswQjQ4dkxRdmFXN05GaThNWWg5ZTlacWZVRkN6bngxL1Fh?=
 =?utf-8?B?RWdRMWdlaTRTUlZwemUvUkxnQStOd0NuaUdJRTB2TnI4Zjk5c1AyVWtZZy9l?=
 =?utf-8?B?NFlHalFkWW83QnplYk54T0xNbzNOZm9SS3ZmZWp5WjJlREtTbVhaQVE3ei9P?=
 =?utf-8?B?dllsWW1velF0WHhyUzJnd0FTUWF6Z3hZa05FZFZROUQ2OU5yYThHaUlnd3J3?=
 =?utf-8?B?Sm55TEhWbkU3UDMxalYwR0dEa25XRUJmNGE3OC8zczh6S3Y3Y2JreERSMnBX?=
 =?utf-8?B?cFBldXNoU2NBODl6cm9CWExxbHNwYzBIT2ZWL0FlRjVDMEFBbXp1dWxBMytN?=
 =?utf-8?B?Y0U2RXhHZWV2Z1JSbU9HSlloSWFTZ3JyY2ZwZlZscitUeEh5UmYrUDdkSEVH?=
 =?utf-8?B?QXZLSVZDa3AxTDhLNUpoRTJyRUtaZUY1TlFMYmVHTDBvZ2hveGNSdGdRcHpG?=
 =?utf-8?B?OFgvK1k1dmRvQ2Ntb2dUU01VZWpJWi9Gai9YZ0cvaUsxeCtOU2RhcWE4eUY3?=
 =?utf-8?B?MTV2QU9rVWYzdHhkSkJzNDBiVXJNREpWd2NhVVovK3dnVUFLQ2h2OTBjYnZE?=
 =?utf-8?B?TFo2VnBxUU9mVFBWOEw1Yll4cnI5YmUyMWZwdWNSdkV2U082dmZwSVJzUDE5?=
 =?utf-8?B?TFU3T1hJSFNSa1JvY2RDR2JBTENQcER6Rkw4V0thYU9QdnJjOFVwVFdENEJV?=
 =?utf-8?B?bGF4TjBpbHd3YjM5RG1nMWFhYTJQQUJXNld5UGdzTWdjU3ZqYlRsdXVoeXJS?=
 =?utf-8?B?R3ZXRXVwckxBczRkZXhJNDc0RFVxeDc3WVlZT29IcEJrN1V5NzloL3N5dFJX?=
 =?utf-8?B?SElpVVNPSEpJNTh1aFJSbW9oVlhNSVlubVhucDJ3azBIU3JVRjdUaUczejhP?=
 =?utf-8?B?ZDRwZERhYllTRzFXaWRIWCtpY1ErRFNXRmgrSS9xWUthMEQxQjNick93YVZ5?=
 =?utf-8?B?Z3NKa28yWlpFMkQ0WmxaS05GRmRNM1dwd0FRd0lxbXFuRWsxbExBY3BwdnVM?=
 =?utf-8?B?N1JLemQ0eW5QQnNzTENjYnJaNnZ1OXhyUmtaZ2twaFdtQnN2dEdQTi9USzho?=
 =?utf-8?B?ZUhHME1nN2s0YTh2bCtKOUU3SXdYUDZsZzliTG9KM2IzdGJQZ0FXalhHeHJE?=
 =?utf-8?B?cXErak1iTWRDOFlXTEJYVUhlSEsrTjduNDh5emh3NmE1Ti95YjhmVlJOMFBk?=
 =?utf-8?B?RTFhR0pRWGZyTGE4Ykt1NURPTGk2MGpaSy8xenRpZExTalZQMjVab3ROMVJG?=
 =?utf-8?B?d3VGRG4rYmhNNk45WllKd0U4emkwdkx3VFdvLzFCMGp6T3MzckR3dEFwT1M3?=
 =?utf-8?B?OWdVL3ZyMXVtR0o3MDZIU2NLOUYxMWNTbDNEQ0NvY1RvbVFoRDNHbG5nTGxH?=
 =?utf-8?Q?1H70dQVb9uYCGZcFA4TxtXM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92AC6156A6383F42A605E59088368E19@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e6d112-388a-4a1d-4946-08de154eb01c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 11:48:03.8959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckbZQzg9yrLo7l4i5qyvFTXQaOCLMv7IUMupg7miWxsPi3FEMiS3cvJtgqIQAaQDRcZQiSEBye/q1uiYI5qWtDl/i5xNH7upN+Hg+AUG8ZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3956

SGkgRGFuaWVsLA0KDQpPbiBTdW4sIDIwMjUtMTAtMjYgYXQgMjM6NDggKzAwMDAsIERhbmllbCBH
b2xsZSB3cm90ZToNCj4gQWRkIHN1cHBvcnQgZm9yIGEgbmV3IERTQSB0YWdnaW5nIHByb3RvY29s
IGRyaXZlciBmb3IgdGhlIE1heExpbmVhcg0KPiBHU1cxeHggc3dpdGNoIGZhbWlseS4gVGhlIEdT
VzF4eCBzd2l0Y2hlcyB1c2UgYSBwcm9wcmlldGFyeSA4LWJ5dGUNCj4gc3BlY2lhbCB0YWcgaW5z
ZXJ0ZWQgYmV0d2VlbiB0aGUgc291cmNlIE1BQyBhZGRyZXNzIGFuZCB0aGUgRXRoZXJUeXBlDQo+
IGZpZWxkIHRvIGluZGljYXRlIHRoZSBzb3VyY2UgYW5kIGRlc3RpbmF0aW9uIHBvcnRzIGZvciBm
cmFtZXMNCj4gdHJhdmVyc2luZyB0aGUgQ1BVIHBvcnQuDQo+IA0KPiBJbXBsZW1lbnQgdGhlIHRh
ZyBoYW5kbGluZyBsb2dpYyB0byBpbnNlcnQgdGhlIHNwZWNpYWwgdGFnIG9uIHRyYW5zbWl0DQo+
IGFuZCBwYXJzZSBpdCBvbiByZWNlaXZlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEdv
bGxlIDxkYW5pZWxAbWFrcm90b3BpYS5vcmc+DQoNCnRoYW5rcyBmb3IgdGhlIHBhdGNoIQ0KDQpS
ZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVu
cy5jb20+DQpUZXN0ZWQtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGlu
QHNpZW1lbnMuY29tPg0KDQood2l0aCBHU1cxNDUpDQoNCj4gLS0tDQo+IHNpbmNlIFJGQzoNCj4g
wqAqIHVzZSBkc2EgZXR5cGUgaGVhZGVyIG1hY3JvcyBpbnN0ZWFkIG9mIG9wZW4gY29kaW5nIHRo
ZW0NCj4gwqAqIG1haW50YWluIGFscGhhYmV0aWMgb3JkZXIgaW4gS2NvbmZpZyBhbmQgTWFrZWZp
bGUNCj4gDQo+IMKgTUFJTlRBSU5FUlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAz
ICstDQo+IMKgaW5jbHVkZS9uZXQvZHNhLmjCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICsNCj4gwqBu
ZXQvZHNhL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgOCArKysNCj4gwqBuZXQvZHNh
L01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsNCj4gwqBuZXQvZHNhL3RhZ19teGwt
Z3N3MXh4LmMgfCAxNDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
IMKgNSBmaWxlcyBjaGFuZ2VkLCAxNTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQot
LSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=

