Return-Path: <netdev+bounces-264673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Gh1JyBlqmnnQgEAu9opvQ
	(envelope-from <netdev+bounces-264673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 06:24:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8FF21BB14
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 06:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 049843030EF4
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 05:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AB636D4E2;
	Fri,  6 Mar 2026 05:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="IU7nvU3N"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022134.outbound.protection.outlook.com [52.101.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F2D4A0C;
	Fri,  6 Mar 2026 05:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772774684; cv=fail; b=jRSfrAlzFt95+SdOUE4q9g9jQVX0thv9hWjxg1rBx9ZJfHiCcCr9awLz34ErVd1I+s0sjHjlsP+/DM1c+PQGKxvfzPwJj0TTWtx6+2pglj/GeDVWPpa3Us3vUONTO2RNJIf5RGtInYnm7LZ/x53JaU81l7O9Wk79GJr88pnnCB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772774684; c=relaxed/simple;
	bh=YoCenWUyPCnkA9CdgF4rYpfvDPTHuhdWOSsP6B9655s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L0v7cLy+kN61fv5qLTsG0B6Q2VWSC4F/Xm73DF9w/i02+miC45otiP9BI+Y+Duh36I8cNWmCt+dtk5ft1YpOCQKxXMhNOkzkfoDdyz5uB/JHL7F0OT/+3CiOpUU7CnaTfH+ujDbo2H/5/3MZHyQ6xO+7Fs2kfveWdIRlh9Pg+og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=IU7nvU3N; arc=fail smtp.client-ip=52.101.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TashounrBNVikwBQwcZRcjjt2P6X5xJhpoFHTt0N5bUTJxC9xz2CdBeeKdTz4zCSAdepSSjFft8Ekq+orb4z/UJlsIXDiEvtsskq+AE9h7J9r3Dynu17yby+cO8XrahC8th6IDEDcmWVxFeotu8mAPV+TQNI/k2nUcRar+bgU/gJjBeiV20QwWsZlr33pvngRs0UAvhTsnFZhksiEA56aqJSzBZ/7a6Qf9CxJePnLZwpzl60AMBGvZMhGke/HrbAEQz6Dq+z3+3PRr/KQS0wzD6Zmc9u74p2gXIB+no2Ctj8N+gLPFvb+JiKgaydbK0jDFYpIpWZB05rx+pOmPm9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoCenWUyPCnkA9CdgF4rYpfvDPTHuhdWOSsP6B9655s=;
 b=foXXShk9MHsk2kplA7pej4RNgcjdkfekEr980zp0RotV7nAZmgO8c3QmPlm6mcG11HBhFNryPZQdYITn78AcsL7lnHbj6MAJH8Yf0/a8mY3yM1X9WKQwmuZF23H4xyqYtFfSUcuugCUmUboNWJ2/prMpqh0L/BgPfS36Vt9npbDXZmpqJJyj+N3/lrxKIWu/rdQD33f6+7hoGjcL6hHmgQvkUNYDnyMR5219IY2uNJ8kYf9cCdXoudn3LyK6C0f3hapHNosvQ8J4LWc9J3ApzfZVgwRxdM92ENeRwjIvzL4myYW4hxRrgg6HLaxF9e2BhBwOOofwfUv3vBxMaGZ22Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoCenWUyPCnkA9CdgF4rYpfvDPTHuhdWOSsP6B9655s=;
 b=IU7nvU3NdfutlCBWqrxEQ4l/sC/bfjOTyzC9sVsiHGSV7bwsCsGLXoPYeVj7HAnyAptdYdMhra/cemNfv3nZC+DupzQhQaTVg/hvRTjZQljmsaTk0IPhO5bqjAqccz1OL4b9SA0QFKwBl7igU8JOOZvrhQ5sE5Q8fxQvCeYRZQpjpqAjYlSnfOE9F7xtDxBhjA5e2sLgdxmOcn2oa0TNtEG/qRD7WKkCe0CrMX37zT/yKJB1ETp3K4wjy5zhgjG0rcF1lW9zTXPTxjWWXP9fRx6i6I8SRcHIk9Qhzbw6PYreBejRszniTogMbm6suAN8msC5F/sX+I2CEj9BfjKjvw==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEYPR06MB5860.apcprd06.prod.outlook.com (2603:1096:101:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 6 Mar
 2026 05:24:37 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%4]) with mapi id 15.20.9654.020; Fri, 6 Mar 2026
 05:24:37 +0000
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
Subject: [PATCH net-next v6 5/5] ARM: dts: aspeed: ast2600-evb: Configure
 RGMII delay for MAC
Thread-Topic: [PATCH net-next v6 5/5] ARM: dts: aspeed: ast2600-evb: Configure
 RGMII delay for MAC
Thread-Index: AQHcqi7Gxnd/yfDNn0+qSBvgjkBecbWbib0AgAPdJDCAAIk4AIABCqig
Date: Fri, 6 Mar 2026 05:24:37 +0000
Message-ID:
 <SEYPR06MB51341775B041AF86CC8769F69D7AA@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
 <20260302-rgmii_delay_2600-v6-5-68319a4c4110@aspeedtech.com>
 <d38f54b2-4a99-4a54-8403-e4f4a9704386@lunn.ch>
 <SEYPR06MB5134AE0B0042E05E8E58A5239D7DA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <70ed84fd-ac9d-4157-ad20-36deec0c5f82@lunn.ch>
In-Reply-To: <70ed84fd-ac9d-4157-ad20-36deec0c5f82@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEYPR06MB5860:EE_
x-ms-office365-filtering-correlation-id: e76824a6-9530-45d7-f4ad-08de7b40a8a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 rqgmrW+jxHnauFHhViTpq4sDlF10sqCWZrQtzbgWFFRDhaUw+M1ilFV8Z0xodgjoveJa9hBw9TbXViMmA4tCkO7yUFbEM3SUyklsJANqwZS+DuI1YqmZYUSKknOvGk8iuwj2qfQZjZvmBCVwdnTPtlLa2wpa/TPitr4aNV7UZewMT4rYGnfH/LS3R2l1N/GNru9fu6iFYET534kP6mkpRXGOEtK3mEvTqkMAn5paYCXq3bb83nJy1kjrccstGvYxPtILhCTTuWMfZ1HPDKo1oFAwOs07TWZh9X38AKMyDb+ZpzgdSrpNZkq5zBpWRKtcBZFv5+87NLhjSCTcyO2GiJ5Q9nILPa3xyR4hUQt5RmU35+e8znnFO4rP+3UuWJjPOyFbpMh8aOFzKP/LWbmpKQ4CDP3Z/VBukF7QSeELYmAZTTF0P+hnTrtA2XPMCIzyYsBG3MOe2eGEYRDmwoknF6wP7oSvrmzm/RqSiJvmy9AFqVSCjro51BbdNIB8I+gHRhYh0sS1FV707dtjrI33J08NQfaoDw/ziVOBE9sVmbQ3KKoaZYQ++PCbEeCchCzU8HhSUlThN5a+9peNOXhxKn0HY9Gi7hX+Ni1KnMuZJIyO0nmh0+iW61Ut1qw5QYpWbjXrDiEJSLs342did06Ny/PdmggRSMO4KlzljUFmuAc697Ui/ehKO56KVun4n74X7Z7ZGIxivEWvFtBM8RBEUAW3rhKhg8POa5xbJOvdbpGfk+f0buRjUjgg2W4FhBxnHgrhb9By2z4YsQ6AiLAFhWlfWDRa8ObbZYJM5CY3AJ0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bW4ySUZYMXhCU042OG9iRDEvdWI3L3FyTVB5Z0h3QnNxcnNUWVB2N3ZHZDFJ?=
 =?utf-8?B?MUhYZnNSclk3aDJwcmJoVm1Jc0YxTWkxcUpQdWFqdzdyVGZrZ3FkbnQ1UEtV?=
 =?utf-8?B?VUc0Q1JaZFFvTzlRNlZ5eTZKL055czBFSXdjak13aWNZSzMvN2V5dVY0cVNy?=
 =?utf-8?B?Skd0dk9zMUtSN2Q5MmxINnV0Ym5mK3Y2RXhLQVJleXV6SUd4TVE3RUN5NW9G?=
 =?utf-8?B?cytueUhQV2VPaUR2amJDQitKOEFoWWtYQ29PQ3VZOTZIYzBJblFtOVBJSjZ2?=
 =?utf-8?B?cnc4QnpGWWpKcWd4ZDdlelBuRm93TTdMWVRNY0E0Y3k0ZXlsMVNRNWNvbVEv?=
 =?utf-8?B?QjJtYnM5VFo3cyt2dTdGSFJQUGdlblVsMTU5cWxUMGpMWDFVcFh1aWpjR1o5?=
 =?utf-8?B?WElWaS9qMFkxb0IwNnpuYlBBNmJZdFF4Q1FoZW9LMFdIZEluVGxxRHhpYjJY?=
 =?utf-8?B?UFJSNkRxNUZtV216NlRxZmo3ZW9rL3Y4aDQ3dlFFelpPTU5pd0FQM2UvU3Nv?=
 =?utf-8?B?OTlrOHBnOVArOTdzZWpVSmVoeFZOWXAvRS9VbEViT2hYUWp6VG0yb1JUbitq?=
 =?utf-8?B?WmV2SldYeHIyRXp6bVl1dnROWUQvL0lrS1RvYVJYOC9uU0RJUXZrRDF2L1Q0?=
 =?utf-8?B?cmlYTFpsUnlzblJabmZFYjkwT09ZeStVWVlMYXpqTWtIVWNWZC9pMUtuUG1z?=
 =?utf-8?B?RUErNEMyUnkzRHQ3VGM1Zm5jQkRmUjBZemYvMjJUMEg1S3hSdWNIZGdKVmZW?=
 =?utf-8?B?S0dFZG4xMzgwdjY0U3hnRmRGdHg1Z0pPL1Bpbk5lV2NUWDlUazdrbnd5eHM0?=
 =?utf-8?B?UG1VYWdvWlBFdXBGUWNZaVRZa1hTK2pIcWM4bUdvb01iKzNWR2JiN1hjK1F0?=
 =?utf-8?B?dnhobE1pQUloR0lBM29Qa1B3blVQdGtrWlhqck5Fc3hkUTAzcmZkSUpIalNN?=
 =?utf-8?B?Z1dqRllFem1zR0pnSWQvN0lEbUQ4RkJsamFRYjhVQUJ3Wm1VQWVGcEtBMC9h?=
 =?utf-8?B?cVExUGZNZ1dZdWhUY0NIYTlMdlo5MllPdjh6RGk0ZEdLMGN4MUZvVDBEa3ZS?=
 =?utf-8?B?QmVuSXBWZVRUZXFiL3NXOVlqYUE3WGRFRWtXWDZTb0oxM25zZmhUdkJ6ZGkx?=
 =?utf-8?B?OS9HZmtrR2lja2htQXdaaVFtaFh3RFZQWGlTNWlmdm1tbTh6dWd4ZzVCNlhT?=
 =?utf-8?B?c1NwZFluNVJKOGdZOUk4cmtHaENKUFhmNFp1MW1MVUtPNFY4OW9uaGdjV3FL?=
 =?utf-8?B?d1ZJMzlhdFl4L2o2ekVtM1RaQzFlUm5LdGRBc2JhNjJZeU91UUlnRDFYMVNT?=
 =?utf-8?B?YUNqSHlKZU8yRDJFbHlZVUtkT0VtQTRZM09PeEpEWXJUMWhsa3gvNU9aTEoy?=
 =?utf-8?B?K1VmZVpMRmRrVWhxNjNUY1h5aXA2M1B5MGVsYTZOWWZoL1V1MkhWM1Qvdi9T?=
 =?utf-8?B?R2hKcUtNMk8zR2lFUytKV2FTenFXWjZDZEQrbjdNRys2Q08xbjN6OW55MTRI?=
 =?utf-8?B?MTM0WDcxeDNna2xiSW5iYTRWTlptQnJQZm9BaEN5Rmt1NnlhblA2Ulc3S2JE?=
 =?utf-8?B?N2doTVZFMzVPdjEvNTgveHM5bCt4dFYrb3hKaWx6MGRrU3BwUEZjbHVqNWZo?=
 =?utf-8?B?YWF2VFhLeU9sbGdid1JWTVY0M2lhUzlqUWlqZ2RwaDlra041QWZxa0JRSko0?=
 =?utf-8?B?VG9ySktwRFdQOFZkN0hwNnUxQ2h0dCtwMU8yQngxSEZaMExJTzkzY0R3WVVE?=
 =?utf-8?B?aTVwL3lPOEYxWVhaRTJoWFRlYVgyY2JZTkZHQzVzYm1SL2ZtZm5IRWt6aTlC?=
 =?utf-8?B?alI1WHVYajIrTEJzZHJEQW4zcDVwOHQzWHM2N2tTZURYdmZVbFFZUTgwZWtO?=
 =?utf-8?B?S1ZNNWpHcFl2MmM4S1BjcDQzSFQ1dFQrVkN4SlFudW45ZDQ4elAxZU5iSU56?=
 =?utf-8?B?MHFoTVh2Ui9mN1FWRWdKcU91dmhodmtKR0FQdWYwdnVtMnYvRzhNODR2Vkdr?=
 =?utf-8?B?ZXk2VHp2bDYrOGtndklVQ1pqcWhxVGZ0dWFsSnUwOXk1WGMzRC8zYWNwOXRG?=
 =?utf-8?B?bVhOM0NXditUMnV1UlljKzdDOCtWOG1nMUtyZXQzWGNuem5ReWdVZGtBendt?=
 =?utf-8?B?UmdyNXJJczkrVTBabG5TamJ6bEJVVkhLZW1QRytRcmpnd0pPYU1DcG9tVHBK?=
 =?utf-8?B?WCt4dHdUK0RIbUhNR05zY2F0RGwxb2ZOZk9QdUxSQnZLYkZlZm03Q2xyNzFu?=
 =?utf-8?B?SEQ2NHpnMnZxejRSTWRFRHBRQXZiUGduSnJXZ0UwV1JzVVJUTWdxUEVkMjJ3?=
 =?utf-8?B?OC92cDl5T3ExVlQ2RmsvWFhzUkpNaTFZV0NFYVZUNUMxYjkyWWtUUT09?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e76824a6-9530-45d7-f4ad-08de7b40a8a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 05:24:37.0415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WXb6dnVsJCC69M03dfTdzd49sq9ixaqQHrazQz3x9wOuRUo4+QzlPaDw9B8M/Ns6zCBHSpnD1egSJyQ2yjC9c+n5ylUeL3Y8n0aCI1pNDIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5860
X-Rspamd-Queue-Id: 1A8FF21BB14
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[aspeedtech.com,quarantine];
	R_DKIM_ALLOW(-0.20)[aspeedtech.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264673-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[aspeedtech.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SEYPR06MB5134.apcprd06.prod.outlook.com:mid,aspeedtech.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

PiA+ID4gPiAtCXBoeS1tb2RlID0gInJnbWlpLXJ4aWQiOw0KPiA+ID4gPiArCXBoeS1tb2RlID0g
InJnbWlpLWlkIjsNCj4gPiA+ID4gIAlwaHktaGFuZGxlID0gPCZldGhwaHkwPjsNCj4gPiA+ID4N
Cj4gPiA+ID4gIAlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ID4gPiAgCXBpbmN0cmwt
MCA9IDwmcGluY3RybF9yZ21paTFfZGVmYXVsdD47DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlyeC1p
bnRlcm5hbC1kZWxheS1wcyA9IDwwPjsNCj4gPiA+ID4gKwl0eC1pbnRlcm5hbC1kZWxheS1wcyA9
IDwwPjsNCj4gPiA+DQo+ID4gPiBJbiB0aGUgYmluZGluZywgeW91IHNhaWQgdGhlc2UgZGVmYXVs
dCB0byAwLiBTbyB5b3UgZG9uJ3QgbmVlZCB0aGVtLg0KPiA+ID4NCj4gPiA+IEl0IGlzIGFsc28g
b2RkIHRoYXQgcmdtaWktcnhpZCBiZWNvbWVzIHJtZ2lpLWlkLCB5ZXQgYm90aCBkZWxheXMgYXJl
IDA/DQo+ID4gPg0KPiA+ID4gV2hhdCB3YXMgdGhlIGJvb3Rsb2FkZXIgZG9pbmc/IFRoaXMgaXMg
d29ydGggYSBjb21tZW50IGluIHRoZSBjb21taXQNCj4gPiA+IG1lc3NhZ2VzLg0KPiA+ID4NCj4g
Pg0KPiA+IEJlZm9yZSB0aGlzIHBhdGNoLCBhc3BlZWQtYXN0MjYwMC1ldmIuZHRzIGlzIGFuIGV4
aXN0ZWQgb2xkIGR0cyBpbiBtYWlubGluZQ0KPiBrZXJuZWwuDQo+ID4gSW4gdGhpcyBzZXJpZXMs
IGZ0Z21hYzEwMCBmb3IgQVNUMjYwMCB3aWxsIGNvbmZpZ3VyZSB0aGUgTUFDIFJHTUlJDQo+ID4g
aW50ZXJuYWwgZGVsYXkgdmlhIFNDVSByZWdpc3Rlciwgc28gdGhpcyBwYXRjaCBpcyBjaGFuZ2lu
ZyB0aGlzIGR0cyBhcw0KPiA+IGEgTkVXIGR0cyBmb3IgZHJpdmVyIHRvIGNvbmZpZ3VyZSBSR01J
SSBkZWxheSBmcm9tIHRoZSBwcm9wZXJ0aWVzIG9mIE1BQw0KPiBub2Rlcy4NCj4gPg0KPiA+IE9s
ZCBkdHM6IGdlbmVyYWxseSwgbGVhayB0eC9yeC1pbnRlcm5hbC1kZWxheS1wcyAtPiBDYWxjdWxh
dGUgdGhlDQo+ID4gUkdNSUkgZGVsYXkgdGhhdCBpcyBjb25maWd1cmVkIGZyb20gYm9vdGxvYWRl
ciBhbmQgZGVjaWRlIHdoZXRoZXIga2VlcA0KPiA+IHRoZSBvcmlnaW5hbCB2YWx1ZQ0KPiA+DQo+
ID4gTmV3IGR0czogSW4gQVNUMjYwMCwgd2UgZXhwZWN0IHRoZSBNQUMgbm9kZSBpbmNsdWRlcyB0
aGUNCj4gPiByeC90eC1pbnRlcm5hbC1kZWxheS1ucyBwcm9wZXJ0aWVzIGFuZCB0aGUgZHJpdmVy
IGRpcmVjdGx5IHVzZXMgdGhlc2UNCj4gcHJvcGVydGllcyB0byBjb25maWd1cmUgUkdNSUkgZGVs
YXkuDQo+IA0KPiBZb3UgZGlkIG5vdCBhbnN3ZXIgbXkgcXVlc3Rpb24uLi4NCj4gDQo+ID4gSXQg
aXMgYWxzbyBvZGQgdGhhdCByZ21paS1yeGlkIGJlY29tZXMgcm1naWktaWQsIHlldCBib3RoIGRl
bGF5cyBhcmUgMD8NCj4gDQo+IEkgY291bGQgdW5kZXJzdGFuZCAicmdtaWkiIGJlY29taW5nICJy
Z21paS1pZCIgd2l0aCBib3RoIGRlbGF5cyBiZWluZyAwLiBCdXQNCj4gdGhhdCBpcyBub3Qgd2hh
dCB5b3UgaGF2ZSBoZXJlLiBJdCBpcyBzdGFydGluZyBhcyAicmdtaWktcnhpZCIuIFNvIHRoZSBQ
SFkgaXMgYmVpbmcNCj4gYXNrZWQgdG8gaW5zZXJ0IHRoZSBSWCBkZWxheSwgYnV0IG5vdCB0aGUg
VFggZGVsYXkuIFdoZXJlIGlzIHRoZSBUWCBkZWxheQ0KPiBjb21pbmcgZnJvbT8NCj4gDQo+IEkg
YXNzdW1lIHRoZSBNQUM/IEhhcyB0aGUgYm9vdGxvYWRlciBjb25maWd1cmVkIHRoZSBNQUMgdG8g
aW5zZXJ0IHRoZSBUWA0KPiBkZWxheT8gQnV0IGxvb2sgYXQgYWxsIHRoZSBib2FyZCB2ZW5kb3Jz
IHdobyBoYXZlIGJlZW4gc3VibWl0dGluZyBEVCBwYXRjaGVzLA0KPiBhbmQgaSd2ZSBiZWVuIHJl
amVjdGluZyB0aGVtLiBUaGV5IGFsbCBzZWVtIHRvIHVzZSByZ21paSwgbm90IHJnbWlpLXJ4aWQu
DQo+IA0KPiBXaHkgaXMgdGhpcyBkaWZmZXJlbnQgdG8gYWxsIHRoZSBvdGhlciBib2FyZHM/IFRo
aXMgaXMgd2hhdCBpIHdvdWxkIGxpa2UgdG8gc2VlIGluDQo+IHRoZSBjb21taXQgbWVzc2FnZSwg
YW4gZXhwbGFuYXRpb24gb2YgdGhpcyBvZGRuZXNzLg0KPiANCj4gPiBXZSBob3BlIHRoaXMgc2Vy
aWVzIGNhbiBrZWVwIHRoZSBvbGQgZHRzIHdvcmtzIGZpbmUNCj4gDQo+IEhvcGUgaXMgbm90IHN1
ZmZpY2llbnQuIEJhY2t3YXJkcyBjb21wYXRpYmlsaXR5IGlzIHJlcXVpcmVkLiBZb3UgbmVlZCB0
bw0KPiBjb252aW5jZSB0aGUgcmV2aWV3ZXIgdGhlIGNvZGUgY2hhbmdlcyBhcmUgYmFja3dhcmRz
IGNvbXBhdGlibGUuIFlvdSBjYW4NCj4gdXNlIHRoZSBjb21taXQgbWVzc2FnZXMgYW5kIGNvbW1l
bnRzIGluIHRoZSBjb2RlIHRvIGV4cGxhaW4gaG93DQo+IGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5
IGlzIG1haW50YWluZWQsIHdoaWxlIGFkZGluZyB0aGlzIG5ldyBmdW5jdGlvbmFsaXR5Lg0KPiAN
Cj4gQW5kIG9uY2UgeW91IGhhdmUgY29udmluY2VkIG1lLCBpIHdpbGwgcHJvYmFibHkgYXNrIHlv
dSB0byBwb3N0IHRoZSBjaGFuZ2VzIHRvDQo+IHRoZSBCTUMgbWFpbGluZyBsaXN0LCBhbmQgYXNr
IGZvciBhIGZldyBib2FyZCB2ZW5kb3JzIHRvIHRlc3QgdGhlIHBhdGNoZXMgd2l0aA0KPiBvbGQg
RFQgYmxvYnMsIGN1cnJlbnQgRFQgYmxvYnMgYW5kIHVwZGF0ZWQgRFQgYmxvYnMuDQo+IA0KPiBB
bmQgdGhpcyBpcyB3aHkgaSB0aGluayBmaXhpbmcgdGhlIGlzc3VlIGluIHRoZSBib290bG9hZGVy
IGlzIGJldHRlci4gSXQgaXMgbXVjaA0KPiBlYXNpZXIgdG8gY29udmluY2UgYSByZXZpZXdlciB0
aGUgY2hhbmdlcyBhcmUgYmFja3dhcmRzIGNvbXBhdGlibGUuDQoNClRoZSBjdXJyZW50IGZ0Z21h
YzEwMCBkcml2ZXIgZG9lcyBub3Qgc3VwcG9ydCB0byBjb25maWd1cmUgdGhlIE1BQyBSR01JSSBk
ZWxheSBhbmQgDQp0aGVzZSB0eC9yeCBpbnRlcm5hbCBkZWxheSBvbiBNQUMgaXMgY29uZmlndXJl
ZCBpbiBib290bG9hZGVyIHN0YWdlLg0KU28sIHRoZSBwaHktbW9kZSBvZiBNQUMgbm9kZSBpbiBj
dXJyZW50IGFzcGVlZC1hc3QyNjAwLWV2Yi5kdHMgd2lsbCB1c2UgdGhlIHNhbWUNCmZyb20gVS1i
b290IGR0cy4NCg0KQ291bGQgeW91IHBsZWFzZSBoZWxwIGNvbmZpcm0gaG93IHdlIHNob3VsZCBw
cm9jZWVkIHdpdGggdGhpcyBwcm9qZWN0Pw0KDQoxLiBEaXNjYXJkIHRoaXMgc2VyaWVzLg0KMi4g
Rml4IHRoZSBib290bG9hZGVyIHRoYXQgd2UgcHJvdmlkZSB0byBvdXIgY3VzdG9tZXJzLg0KMy4g
U2VuZCBhIHBhdGNoIHRvIGNvcnJlY3QgdGhlIHBoeS1tb2RlIHNldHRpbmdzIGluIGFzcGVlZC1h
c3QyNjAwLWV2Yi5kdHMgc28gdGhhdCB0aGV5IA0KbWF0Y2ggdGhlIGJvb3Rsb2FkZXIgYWZ0ZXIg
dGhlIGZpeC4NCg0KbWFjMDogInJnbWlpLXJ4aWQiIC0+ICJyZ21paS1pZCINCm1hYzE6ICJyZ21p
aS1yeGlkIiAtPiAicmdtaWktaWQiDQptYWMyOiAicmdtaWkiIC0+ICJyZ21paS1pZCINCm1hYzM6
ICJyZ21paSIgLT4gInJnbWlpLWlkIg0KDQpXZSB3aWxsIGFsc28gYWRkIGEgZGV0YWlsZWQgY29t
bWVudCBpbiB0aGUgcGF0Y2ggdG8gY2xhcmlmeSB3aHkgdGhlc2UgcGh5LW1vZGUgc2V0dGluZ3Mg
DQphcmUgY2hhbmdlZCBhbmQgd2hlbiB0aGUgTUFDIFJHTUlJIGludGVybmFsIGRlbGF5IHNob3Vs
ZCBiZSBjb25maWd1cmVkLg0KDQpUaGFua3MsDQoNCkphY2t5DQoNCg==

