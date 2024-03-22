Return-Path: <netdev+bounces-81320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5BF887337
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 19:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368101F27624
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 18:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F7367E6C;
	Fri, 22 Mar 2024 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="bTEJEmEG"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2103.outbound.protection.outlook.com [40.107.15.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D26339AC5
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132413; cv=fail; b=c7hhdupgi0AOhOoxro39CF+NcWE4oULGcapHFw9GTkhcrvEMXj8iTmNPxmK8QBtHSMd/FHLZgMal9h4BZptekfFVaX0HVLrQjY6C/wkx71y1uEMOykAc/cpZWrWtb3hANUv1Jn34KCB1ldqZCbVJlfPonCRDHFNChdEZIweaydM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132413; c=relaxed/simple;
	bh=I9TVwxW3QZ1eV6LN+Ym5bOEIXtY/ZHtXJ/pIy92eEi4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fjf3g82Ab5xhnw3E63O8FnWUK6Od6aIiyTlrDgyP/2v5By0toorvWIHuYyC9PrWn1uqE6z+pG+9/9w5LibLzpEAd+t8u0BApHjC9zTFJLAVrQEW4JvCkstB63+Xl4SeOufEt9iQ7+qQgQESKU1XXL3o9qV883x5uUtUo0GIbVDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=bTEJEmEG; arc=fail smtp.client-ip=40.107.15.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuTcXnhC1GG5TMGG2pj6lkh9RbMmrm8QMjm4ngy8f+cd1VVvdw2FVFSXHiL7W8bu8HVY3zzyjSt4q1WqvxK0zN77CV5bM22sjGi4gCV1gzuNYEfrHeAFMwEoRpubmJ0DyomB5KbkO2VaFtgLK5eS73mQgJjNJv8idd2OK94gMaoDbH6bjUp9i4ZbJrUbYu8qnXu3vN40RLH+xh5MdpQh8u/MLnc6gL38GibZfU+q0Cl9OGZOTOx6n2aHW8w+WfaJ5cRAIZYkZCAssvbjX0eTMcqkPKUBICWUhDKAeT0t3ByOfbp7YGHxEzf3v4cx8KmCyIj33XlG5JN0ZKiPIX6bag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9TVwxW3QZ1eV6LN+Ym5bOEIXtY/ZHtXJ/pIy92eEi4=;
 b=BmyIkd3Dz/eedKBugyK+upHRJAzIzmMXxFQapnP7+g5nvPSHOQCJb5BzmHlx+D2Oj1uMcbpFq+DRS2cV/v4ihQPFK/Inm9Ffythyh3JginBDdoNJ9ZodJKJy2yzeZDGK9ZQPmAn2cPCepv8+sy6vf3+z9v56JLdzZLMSNE6Xz0A9Jr1Ac7zRilEmpazNFjIi4AOsYEL3Jk8xZOCDPuCjOH10HFPYCwQVHI2dH+/jY2X6d51DZHaTsOdxXdCwbjkRR3EGucs/YeWMMJPrFQT8IKSROSGgOP29JzYr82LniFgCx+awqWlpIkKMNV9JwyFHCtCGgmi6Mpu484QTaJpyow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9TVwxW3QZ1eV6LN+Ym5bOEIXtY/ZHtXJ/pIy92eEi4=;
 b=bTEJEmEGl7E/+tECvCAyAxuo9eAgJRKzCtKV0tY59nkhwqT5ifBjBLSbAIPkbC/+ZBhufS87dbjD6mg26/XHcAzvUlQagkOsRIrnX9FAyJK6/HD58CGVEYjscFNj1xCV1Hguhc5vhQe7YMHFjIuLEDkJ0fmweLJAGrHfmPjKUQM=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB8785.eurprd04.prod.outlook.com (2603:10a6:20b:42c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Fri, 22 Mar
 2024 18:33:29 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 18:33:28 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Gregory
 Clement <gregory.clement@bootlin.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC 2/7] net: Add helpers for netdev LEDs
Thread-Topic: [PATCH RFC 2/7] net: Add helpers for netdev LEDs
Thread-Index: AQHafIZ60MoLVCu3sUeUfDRIEi9eZrFEFdAA
Date: Fri, 22 Mar 2024 18:33:28 +0000
Message-ID: <1fc37850-e74a-47a8-9c74-2fa08b4eae9e@solid-run.com>
References:
 <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-0-80a4e6c6293e@lunn.ch>
 <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-2-80a4e6c6293e@lunn.ch>
In-Reply-To:
 <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-2-80a4e6c6293e@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AS8PR04MB8785:EE_
x-ms-office365-filtering-correlation-id: 19809f38-3673-42ff-d63e-08dc4a9e91a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NUtPa2dPg6O/uZDtlZPVhdUMxMmdsSNvN1te6AC9N4iaAkQDMwSI766T/5dtSPyc4a9S34rLhSHyfPJacju6za7kOirqRQTQy0+43tDwf2bp4An2RkLY1ybW2dgMw/GW5mSnLU10MwnwjFI3iW0vtX8DsqW67S9S0ytvvbKSHBq5jngatIxdnqGCCj/TV6MWrWoCj7kHRZbWflejGHtppSWYZJeEOOqruXdAuzVi6P8QeOGByz+DB4IzIJcHVDjxyaWErKGC7VzQAw2hhKIFYJb6EvzJ1s9Eb7stn9dFhQ0RcYPnpMjnLv2RvLiKypth580RWcSSe7vVeBl8uUYprnehnFtsrdZ+ysxd35PY6yyjF9X+LNEP6ndIQ0x15Ta6p3dQZEPkQhheYWWYaOFEbw05UFF9COgpsLDQ/HQGso7lw09e5BQbpZcPs4WRNTLMAohSwhwuBO7CuGJTPopxmia2qoi0waYC1h4lDL48BvyCof59+fhg/lQSKWEAPVsZ496LROYrcKQyfaESU2hVcuijalHJD4VAc2khPhS0fLkKUxKf3yj3Wnh29HF8eJMLHPwph+GYKEHrzpRmrvxqu8KfXrlRN0hNot9D3qtszY+yngsmuIeNXL4XKsCoEryvqX1+lvE6xc57taKEzPQvTv8uBkjbpV9DhZf819/tEjB8yGanaV0yh4KiKzWhQZJVsQUUBgI+H5bT4q7CC8Izbg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGt6RkZubW95dmFXTEpIbnNGTFNNcTVNZ1prUnd1QzRUM3VIbTBra0dYQXdH?=
 =?utf-8?B?YndJMWo1VS9RY1duVk44VmI3cCt5R0VoejFINjZBS0t3RXpJeENJTUlkUi9o?=
 =?utf-8?B?SHMvOEtBdGxpT1J6WW94UGVreE9zdTkySnhyOXphUktJcHpKOHEzY3RHOHdT?=
 =?utf-8?B?T003ckxnaktlTWdma09Zb3J6ODd3YzNtbDkzcm93dGlqL3R3Rk81d0xnUVph?=
 =?utf-8?B?YjhCZ0ptNGNBVThNRUpoMVZZdUQvTDBnU1pQVU4xTHVYcS9BR3IrR2Jzbko5?=
 =?utf-8?B?TU8rcFowVTFEdjYxTGFSaW9ISkNZVDlsTDlGcjc5Y25Cck0xaG5HaUZ5SlRx?=
 =?utf-8?B?bkpxODJkNjZiOS9JS0kybTNiSGlMeTI2K3FBRTNxaG9qTm9zbEU1ZEZ0OTY0?=
 =?utf-8?B?dUZxRWhFOVhOWjNZZGh4Q3dmVExRWkhhUkdpeHpjUEQ5MVVHVHVTd3dGYktk?=
 =?utf-8?B?Z1plYnhjRDlBV0luNDY3M0ZIUmdpRWswSU5jaDV4WC9PUkdjaHJhTC93SElt?=
 =?utf-8?B?Z1F0aFpZVTlXekthWkxIZG1BTytmNFlrM1JGR0Q5RjFYdUJuYUJpNGdkWXV5?=
 =?utf-8?B?ZWlIRDJnSHI5RUNiVFpUQ1I0NTdVNEhhS3FIWm1tdDZZRjZuUS9LUTVTM1o4?=
 =?utf-8?B?ZVI3ODR6Sm56TWhnT29JTGRDK0ZUQjVBQU95TEFlMElPS3BxM2pZelN5c2RN?=
 =?utf-8?B?Z2FiSi8yS2hxdTgrZ1RRcGlJdmdDOVpLcExGVjluMmE1QkdMN2Q0TzBjRVFX?=
 =?utf-8?B?OUJEYzd6OTk5eEtCQ2gzTytFbGJxdjh6V2U4QjY3LzNFM241MjVEL3h5UTls?=
 =?utf-8?B?V29VZlE4L2tKaHdqdEIyNlNkaFltRmVwSHlZTktLK0ZyelN3Zm9DNHluYk5E?=
 =?utf-8?B?L2k1UGYvK05reVZBbU5rRnJFUUthTEhXc0Z6akkxNlRlakprY2ZBeE9nZGtF?=
 =?utf-8?B?Y25uMkl3MXI0NjVpNGpQWTZCUXZMTUR2bHRqR3Rpdk1Bc0hETWlDa0pZQjFy?=
 =?utf-8?B?VXloem8weHJvSmZXaHNYdmlDZjRNaXRPSFFOOFdpeXMvaExEL1hyN01KeWJx?=
 =?utf-8?B?OTNHSDFOZ21VY2U0R3Fna0J2QnRSdlN2S2s2Zk1vZzA5OXROcEJEK1BlOG1B?=
 =?utf-8?B?OTNWb2l4WERmb3FuTnM0T2doZW01VTMyQm04Y1E1dEo5dGN0Z00rNkloVUtL?=
 =?utf-8?B?NlQ3MUNOTmJXOGprekFhWUx4N1NXQjNuOEJ6OUdUcEdZUHVlbmphYTZpS2pM?=
 =?utf-8?B?U012d1Fnd1ZRSW0wKzNubWdQOHExK20wajkvOUdzelNRUDFwWlVpY29hWUxP?=
 =?utf-8?B?bzZtSXVEOUt1QnduTVNXTUVET1hBdmlYaXY2aCsvZkVkMHh2MVExcjRpTjMz?=
 =?utf-8?B?bkE1T1pIZG5TNUJQNWFEcEwzSnh6RmhaS1kvaGUvb3lXeXdldEZEd1RsREd5?=
 =?utf-8?B?M0ViUCtkNVhVdVZRWWg4MWIwNzVOV3NYdmJvdjQ5YjNMMStmUHRjVWh2cHB0?=
 =?utf-8?B?OGN4NWJqQ2FMWXhENVU3aVJoRS9uSldqVEtTWmNnQlBLMGNEZTN3ZG9BT1p3?=
 =?utf-8?B?Rm45SDJTdW9JVy9YNi95SVhsNXZtSWV4QnpZZC9BTHdxSVVIWWIzRFM4SHFC?=
 =?utf-8?B?MVEwSTZCWVF4V0w2Qm43bGZpa3ozMVowR3hXWFJmc2taUnZtbDJUZ1JCdmlN?=
 =?utf-8?B?eUQ5dTg0aE9xL0dSQ3YxbHh5VGRLUGkxcWRRZDRkMVRYakVoT3pHL2pWakp1?=
 =?utf-8?B?eWdXNlJadEFpN09FS01ERTJCamhpVW1BdUpia25HWGJmVURTaWJzd1FISnZC?=
 =?utf-8?B?SStqaW1JR2hhZVFia0ZRZTVDTjQrUEVZOHFTSU1HeXlIWlhYeWMwUmVCdUY3?=
 =?utf-8?B?cDdudml2bXM4MXFIVWs4RlNzZXJEUXZBUEl0YkVRT09taDVCbnlqY09MeVpi?=
 =?utf-8?B?L2FRTzZRTEpCQkdVVmppUlNHeU5BcEVEdC9ZSVJHUEU1ZVNlMVNraGdOTFRE?=
 =?utf-8?B?MEU3SG5HaEpqblBNaXNsd2RYZDgzL2lvSDVMSitiUHhFeUVVQkxHOXBvZ0V1?=
 =?utf-8?B?S2EwNmJJZEVockg2NGp4OWZNTXVnVHR1Mk9nOTVUVUhTU2VvZmRFV0MvSVVo?=
 =?utf-8?Q?QIeU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED82BD3C006A244F8BAC6CB6A21AFE4E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19809f38-3673-42ff-d63e-08dc4a9e91a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 18:33:28.8185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UOg536NleYUJtkSThBhcCxfa1/c44HaYnC66F9D7+zXOnug1nQRVAGG1VlPRNLJFVlRSWYqxU03LUPlGY2NUjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8785

QW0gMTcuMDMuMjQgdW0gMjI6NDUgc2NocmllYiBBbmRyZXcgTHVubjoNCj4gQWRkIGEgc2V0IG9m
IGhlbHBlcnMgZm9yIHBhcnNpbmcgdGhlIHN0YW5kYXJkIGRldmljZSB0cmVlIHByb3BlcnRpZXMN
Cj4gZm9yIExFRHMgYXJlIHBhcnQgb2YgYW4gZXRoZXJuZXQgZGV2aWNlLCBhbmQgcmVnaXN0ZXJp
bmcgdGhlbSB3aXRoIHRoZQ0KPiBMRUQgc3Vic3lzdGVtLiBUaGlzIGNvZGUgY2FuIGJlIHVzZWQg
YnkgYW55IHNvcnQgb2YgbmV0ZGV2IGRyaXZlciwgRFNBDQo+IHN3aXRjaCBvciBwdXJlIHN3aXRj
aGRldiBzd2l0Y2ggZHJpdmVyLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgTHVubiA8YW5k
cmV3QGx1bm4uY2g+DQo+IC0tLQ0KPiAuLi4NCj4NCj4gK3N0cnVjdCBuZXRkZXZfbGVkc19vcHMg
ew0KPiArCWludCAoKmJyaWdodG5lc3Nfc2V0KShzdHJ1Y3QgbmV0X2RldmljZSAqbmRldiwgdTgg
bGVkLA0KPiArCQkJICAgICAgZW51bSBsZWRfYnJpZ2h0bmVzcyBicmlnaHRuZXNzKTsNCj4gKwlp
bnQgKCpibGlua19zZXQpKHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2LCB1OCBsZWQsDQo+ICsJCQkg
dW5zaWduZWQgbG9uZyAqZGVsYXlfb24sICB1bnNpZ25lZCBsb25nICpkZWxheV9vZmYpOw0KPiAr
CWludCAoKmh3X2NvbnRyb2xfaXNfc3VwcG9ydGVkKShzdHJ1Y3QgbmV0X2RldmljZSAqbmRldiwg
dTggbGVkLA0KPiArCQkJCSAgICAgICB1bnNpZ25lZCBsb25nIGZsYWdzKTsNCj4gKwlpbnQgKCpo
d19jb250cm9sX3NldCkoc3RydWN0IG5ldF9kZXZpY2UgKm5kZXYsIHU4IGxlZCwNCj4gKwkJCSAg
ICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3MpOw0KPiArCWludCAoKmh3X2NvbnRyb2xfZ2V0KShzdHJ1
Y3QgbmV0X2RldmljZSAqbmRldiwgdTggbGVkLA0KPiArCQkJICAgICAgdW5zaWduZWQgbG9uZyAq
ZmxhZ3MpOw0KPiArfTsNCkkgbm90aWNlZCBwaHkuaCBjYWxscyB0aGUgImZsYWdzIiBhcmd1bWVu
dCAicnVsZXMiIGluc3RlYWQsDQpwZXJoYXBzIHRoYXQgaXMgbW9yZSBzdWl0YWJsZS4NCg==

