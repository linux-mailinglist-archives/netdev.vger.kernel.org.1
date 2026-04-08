Return-Path: <netdev+bounces-276426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD40Ckot1mkUBggAu9opvQ
	(envelope-from <netdev+bounces-276426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:26:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA77D3BA800
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 422B0303791A
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 10:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9839B3ACA45;
	Wed,  8 Apr 2026 10:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="adUHgW8+"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010016.outbound.protection.outlook.com [52.101.201.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34E93B19CC;
	Wed,  8 Apr 2026 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775643880; cv=fail; b=JQEWfMB+xy2g7t3GuOmmjtBkaIEGM6SdWZGJdHbu3gbf5KJc9A/hFlE7Csn64wJPzk+eWa5LU9HvBf3I6MvjtM7eC5Gvsm3GJYBJ/izuQVilVATMUti1wi8WcsdgKQoCm8gUrgoBiIKYJF1vZU0wjW6oC3r/9GogcRtcKFBpw6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775643880; c=relaxed/simple;
	bh=V1qcoLQPe2okkgPrW9kqa9JbaXMy+2z53wU1SuE8AXQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fq9AYua1JQs3bEBLF56Ij5zOoVRCDY3y2js/DGwb/y4xw0l0+U08IN05ztOLW6sHUj0qfPUTbedI676Zsrv0PfW4vs/DUSe2EDO9XCSS+WhT+EQXkgcEyGFx1q0zShMYOagfRmQ/h1HIwZ3czyINb6fZ4yiybYFrZNMpCO6nbeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=adUHgW8+; arc=fail smtp.client-ip=52.101.201.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxHIofvFDZchLXa2wvUdCujLQPkB08+/IWDTMJX2bTTexZNt1EMrBgdehk8kkuLxdXQuBQB1DcL9byvLjqIfYF4OojKMKVSIe/BRkmdGGIB24u58uotsHu1lvzMifYKN1U+cbp96fBLJAcUBBu3RLffYP6eyGRtX8HJBduMq5TMCryWfvBqS11eIQIYUJdPs6HHyqI3SUZHVuC+YCbRKA+u/cKP4j91SGaub5Bw6WWfcHwzf6fc6dORTedcauk2nV8RJyKCGJ5OFyMzSc9CYiqTxRZFyj5hZSAhgMDS9muoH72DyO8wIhbG6BfYbPAbAgyNFDTDEjcZULDJf1+U78A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1qcoLQPe2okkgPrW9kqa9JbaXMy+2z53wU1SuE8AXQ=;
 b=XZHmdvyZF25UGwik7NFAxgxx4Ni2P/Y94ZJ2osDI3B5A1LFnlO8TI0S9MAIZivR8Bk7HFghFG9MiPzhAdAbN3HxOpyn8tuWPYqEFyT/qS9nNDrTSm/81JusimcTNAJsibTBYqvzXd4y1YvK/nLsTkny6GLhMR3Ea806Q+02e5vhcqorrJ4pcr9UDflfNibP66Rk42mQ1VEp0jWNTe60ZoPMSRYbe30bYS+RnuJg/M3knP0iOZcuFaCXw2FbMsRs6CCakO9aghw2L/5Un4UUMT4ExLaBiDF8753rSSWI1/bkOaa078VvZ/QGIqNN36BHxsiqZK59NmPm6GZU/1+1Dhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1qcoLQPe2okkgPrW9kqa9JbaXMy+2z53wU1SuE8AXQ=;
 b=adUHgW8+1s51qI8VlaAoWar313QIJA5uM8EIGj3CoCW+a3t3z5upg/VRK2lh+g92K5lP3w2H1IDoHyq6jl0O8jCgwHPTrjztXcn8kXqKzq2QBlLz6VEh8okxe/riR/xkqZoxPlaRnCiEaiZPo5yQBT0OSPb2WM5AYCsSqz5jIa3KqkG4kZgfMXm10vbRO9ifiS/MHhpeGklkJEwz2jlsNceF48Z7/JgBMap6zi3O3iX63Sqy4KFJKk1QXoi/WUDEIhi2qj918tm8EcHxbFudtHhPePt9svLFgmE54We/LjhqdcSRARHPXOL4K0iXr6odkUJaT37r3tVCuv6pnYipXw==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by SJ0PR12MB6877.namprd12.prod.outlook.com
 (2603:10b6:a03:47f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 10:24:29 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::d512:9f9:1c70:e24e%4]) with mapi id 15.20.9745.035; Wed, 8 Apr 2026
 10:24:29 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "sd@queasysnail.net" <sd@queasysnail.net>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "shuah@kernel.org" <shuah@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net v6 4/4] macsec: Support VLAN-filtering lower devices
Thread-Topic: [PATCH net v6 4/4] macsec: Support VLAN-filtering lower devices
Thread-Index: AQHcwEV8JCUz5mbuoUiqCSPj+c8ZLrXL3u8AgAfhGgCAASHNAIAAIWCA
Date: Wed, 8 Apr 2026 10:24:28 +0000
Message-ID: <3aab1732c62fa8241ea91f2e26720ba47d646a3a.camel@nvidia.com>
References: <20260330130130.989236-1-cratiu@nvidia.com>
	 <20260330130130.989236-5-cratiu@nvidia.com> <ac6BsG4IhAajip1s@krikkit>
	 <e2eefeb7033caa859551834d3448a77b7af3c7d4.camel@nvidia.com>
	 <adYQ3OMfEEWFTd7X@krikkit>
In-Reply-To: <adYQ3OMfEEWFTd7X@krikkit>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|SJ0PR12MB6877:EE_
x-ms-office365-filtering-correlation-id: 2f939347-5f6b-461a-4774-08de95590476
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 sClUiSYnWlkUSnc/uMYDZ5anVI7YeKcFSJ+hGDkvwdgylfPRbCM0hXKDPF4O/kthYDp2XegWJmkb5yI91YfkBCLBe3CWBLBwVCODTiRfZT/ocEoLKYpwev8s/bqv8YhgfgMLDK5Ei9FZasvfP98yTsbxRHPGTbQ71a/ZL6IJfVAzMXGtCivKI3RaRN56eHKRIvvLKZvC4vs0YYEZQOZPTNTLIOyCEhntPuc5fC8Dc7YrKit1HF7dAT1p0TKtOtEetn84X/Vpgbuf5UYFte9M/q0FVxmuHo4O83V3rhYyBh195vo3SWZsNDyDAYRolfVjrbPyLS2wj3YPmvWh5w/WTHIdbN6oSooN83GTPm55114BUXaOr42bL/TX4K0KfQI6+h3MmRGaW6GI3qauGosGlgJcZ9T74Y3nsAXo1jbO12ym7waglOdJhdxblKpHieRZh6290DUK/6EZGESeFz1eauVfufFlot46q0vAIzHi0P46H5BZrItN39ZSoNgsqvCj6xODAE6cgeg0qFAkk9XQNNH8DVX1ywQ4zwwLOqCdsWyqnG/D7AWt1uBiVEETmnUouFhYjtZS3ZTZbtahE/aBY5NaLZJmvreZI0PEYKTGzTXnGQR3lDVcuQ4nRuJKfj+/Xjnu5yxpso2gYLUb1Siio1EGcQosHeSgQYCNbzyV/j6gbUGFxxJdtbgW+A245NXUT2Ubh6FaNRm+0VdjqEXKa4MUAyTxJIXBUfRSVdJ9AmaGt8uRHYNSxHI4M8SuPcy44NYo+iyr7rEoOpyBTkgEXsJ3i3UK6eBX7lTlYl831Es=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1dINEx1ekljeGVyS051cmNhNGNWNXZaRDVPSnlnUTc3UmQzdUVnQys4aWRF?=
 =?utf-8?B?eE0rVThiOXV2VmtWN2s3Wkg5M3JrTUVpazl2VWkreTdZZXUxNmVEU1l3UFlF?=
 =?utf-8?B?Skk1UlpFa1pqZ0xBR244VzE4NHQxSnMyUDN5a2VFWXRZaDhtbi95S2tYWjE1?=
 =?utf-8?B?MTRoem9NTmxrdHluYjhyKy9udytCQ2h3eHRRSk41KzdVRGxSQjA0dlFZR2Nk?=
 =?utf-8?B?R09KeHdkTEpsR0orcG82RzNhcDRuMWFpR3lMUUlyWnpqVVpESElaajZiclJt?=
 =?utf-8?B?T2FtNDArMW1NY2xKYzV0NnArVDhhUldjaHZUUU5GMG11R3FWM2haR2VCeUM2?=
 =?utf-8?B?ZkxtaCtaVkh2NmxubW5ZU1ZCMDNlNDdlUURWV2p0SWRKUytONkV1WER1ckdp?=
 =?utf-8?B?dlFzaWZLTWYrTzBRVFBkWWtJMjNoTTZpWU5YMHpVUVo3UmFDV3BQbDdyQ09w?=
 =?utf-8?B?aVNCOFNNTmFURU1vMFg0aXBpQ3o0blRjVnUrTm0zRC9zV3o3Y1ZqQnNoZWpV?=
 =?utf-8?B?SjNlNmdsWFBTem14ZlZxSWhRQkhTY1VVTllmWTRSUndwSVVadnA3b0MrM1N5?=
 =?utf-8?B?U09ES2FOeWg4My9xeWNIaDhEUHRZcTZNWElEYW9ubkJZbG9DTkRVQ2ZjVEh0?=
 =?utf-8?B?T2kwS2tHUjVWdEl0bFVIa0NuaGxTaGxnbVFWdnE2TTdDZkp4TVI3M2tYekZs?=
 =?utf-8?B?WnZmNjAyMmVLWFlRckViY2tra0xEOFNwR2JZSytxNGZNVHVDeUJidTN6R1dD?=
 =?utf-8?B?c29CbUtwUUIzeWt5REFjMVZadzE0YjFpbGhvNEN0WkVQUXZmTHVlcU5FNmVa?=
 =?utf-8?B?Q1Rnb0YwR3ZjYjQ5eUNOV3FPbUo1ZGlIZ2dmcWM2QkNIOW5wR1lUR3hGQ1VM?=
 =?utf-8?B?OUQyYUlVNWMzYy9PSTU5dGR2OWJqUS9FUit5RWp3NnVCM2M2MktjM0N5dEQx?=
 =?utf-8?B?Ky9STlh1MVJYTXNnL3Z3RXJZaE1aTUZCR2xyL0lycVFweXdUcE02QkJzSWJ0?=
 =?utf-8?B?YnNJcURldzV3NFFEbVdtTTYzU1pTWWdmYTZNVFhlWUEwVkI1MUFjbjk1cldJ?=
 =?utf-8?B?ZFo5Qmtab1U0cjFKaHBFNmZ2OWcwYzdaV0V6aXduaFMyOXN4SERCcm9NQWNk?=
 =?utf-8?B?M1RSMUcydFF2S0c4T0szWVV5RkRaQVZFNFNjYVk3VUl3aC9paWFnSkthODc1?=
 =?utf-8?B?SkVPaHJYZEhRdVVJbnptZE1rVlVXbW9raTJCVjgxUlNqRms1aHVCdHRCSkZW?=
 =?utf-8?B?a2V6YkpTMi9QQTJNcnk4R201b09XMGdPQ1kwcG9RQThHbFJ2ZGt6aVBieVo3?=
 =?utf-8?B?Q0JsWk1vbTV0SFU5MG5rbW1VZFpYbG9YOHkxb0xWa3FlT1JWOGw1eXkzLzJ4?=
 =?utf-8?B?WlVUeFFjem1weURsV3JBTkhIOVZrTEsvdG1TZXB6dndOeXdKTHB5RDNXZlhV?=
 =?utf-8?B?U0xMMmd1QXliZ201cmRuUHcrS3RKUzUwcWdIbmJJOFo4bDJZaXUyamE4NnVm?=
 =?utf-8?B?emFHTUpKa3ZJb01DNUlUdjU4bXdkSXo0VjM0emtCa2RXTGNqWjNYWEtYVGJp?=
 =?utf-8?B?WXM2RFE5akJYOENWMlpoOUFVdjY0d0dXMVN0U0tab28rc1NFMThNT20vSmFm?=
 =?utf-8?B?ODNIU2VWOVk3NFppRHJFU3JoaTV1d05CbTc5RXI1VVY3ZExzVnl5d2RhMlBt?=
 =?utf-8?B?eEVWL1hPNk0yRXRmRm44RkJPWERPanBSZ0dVWjdpRDM0bTg0U3FxUlVQcnVp?=
 =?utf-8?B?clhqUWcweDhjMkF6L1dFUklBSDEzNm5tMmN5dTVIZC9KWlBPTHJ3VUo0WG1Q?=
 =?utf-8?B?M1BtYUoxNW9TUk94UGJGbkNoc0pJb2NmRVQxM05RenFRTXd5VVdscWNnVHJu?=
 =?utf-8?B?QzF2K1grSjE0YzJDN1FOU0JZQnh0S0RRMEZsL2Q4aWZSb0FRdmFkUUd4UFYw?=
 =?utf-8?B?cCs2WnNLVDR5ZUU5LzJMNnI2dllYRi9ZUUw2OU8ycnZUaFlweXk3RTlXVW5w?=
 =?utf-8?B?TWpjc0VyWGY4c1QxbldRWVVpVGZKVlM0aHJGeXRXSDlwdGJhbUJOTGJYRlJj?=
 =?utf-8?B?bm5WajE4QWpUWGtnMk1kZEtiUVVoU0FYZFcvWWJmTjViTUtkaHg2cElqbXhU?=
 =?utf-8?B?S1ptUEpOTWw0MUtuWGU3RVlxODJWTFBwZHc3Y0I5N0RVT0JtUWlJWk42REww?=
 =?utf-8?B?YjVrdUN5VUNXOVpWQWhqdmd1SzMySUg1WWxPSHpyUG5EZHRlSTc5NTByQ2Mw?=
 =?utf-8?B?cDgyVWk3ZlBEczY1S0g4VmpqSW1MMktxNmJPU2MrTlc3UlIxWm9JMGx2d2lS?=
 =?utf-8?B?elIwaHEyRXQxU2RPb3VTQWN3OHlIVWt1YUdobWxJY1NJTnZNQTAwdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CD50F95EFF9D44690E81487AA7ECA9C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f939347-5f6b-461a-4774-08de95590476
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 10:24:29.2263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DasyjVMccz1Yi8lBF8TVwKzLNWz/waHSVhkP3U2+aRNnuRetf13pF9AeNsM+JTrt794GPDuG2ryeBYDgw32ZTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276426-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:replyto,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: DA77D3BA800
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gV2VkLCAyMDI2LTA0LTA4IGF0IDEwOjI1ICswMjAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+IDIwMjYtMDQtMDcsIDE1OjA3OjQ3ICswMDAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4g
T24gVGh1LCAyMDI2LTA0LTAyIGF0IDE2OjQ4ICswMjAwLCBTYWJyaW5hIER1YnJvY2Egd3JvdGU6
DQo+ID4gPiBJZiB0aGlzIGhhcHBlbnMgb24gYSByZWFsIGRldmljZSwgdGhlIFZMQU4gZmlsdGVy
cyB3aWxsIGJlDQo+ID4gPiBicm9rZW4uDQo+ID4gPiBJJ20NCj4gPiA+IG5vdCBzdXJlIHdoYXQg
dGhlIHJpZ2h0IGJlaGF2aW9yIHdvdWxkIGJlOg0KPiA+ID4gDQo+ID4gPiAxLiByZWplY3QgdGhl
IHJlcXVlc3QgdG8gZW5hYmxlIG9mZmxvYWQNCj4gPiA+IDIuIHN3aXRjaCB0byBwcm9taXNjdW91
cyBtb2RlDQo+ID4gDQo+ID4gSSBpbXBsZW1lbnRlZCBhbmQgdGVzdGVkIG9wdGlvbiAxLiBJbiB0
aGUgdW5saWtlbHkgc2NlbmFyaW8gYWRkaW5nDQo+ID4gVkxBTg0KPiA+IGZpbHRlcnMgcHJldmVu
dHMgb2ZmbG9hZGluZw0KPiANCj4gSG93IHVubGlrZWx5IGlzIGl0PyBSZXNvdXJjZSBhbGxvY2F0
aW9uLCB0YWxraW5nIHRvIEhXLCBkZXZpY2UNCj4gbGltaXRzLA0KPiBhbnl0aGluZyBlbHNlIHRo
YXQgY291bGQgZmFpbD8NCj4gDQo+ID4gLCBpdCdzIGJldHRlciBmb3IgdGhlIGRyaXZlciB0byBi
ZSBleHBsaWNpdA0KPiA+IGFuZCBsZXQgdGhlIHVzZXIgdHVybiBvbiBwcm9taXNjIG1vZGUgdGhl
bXNlbHZlcy4gS2VlcGluZyB0cmFjayBvZg0KPiA+IHdoZXRoZXIgVkxBTiBmaWx0ZXJzIGZhaWxl
ZCBhbmQgcHJvbWlzYyB3YXMgdXNlZCBhcyBhIGZhbGxiYWNrIGFkZHMNCj4gPiBzb21lIGV4dHJh
IGNvbXBsZXhpdHkuDQo+IA0KPiBJZiBpdCdzIGluZGVlZCAodmVyeSkgdW5saWtlbHksIHN1cmUu
IFRoZXJlJ3Mgc3RpbGwgYSBiaXQgb2YgYQ0KPiByZWdyZXNzaW9uL2NoYW5nZSBvZiBiZWhhdmlv
ciBmb3IgdXNlcnMgY29tcGFyZWQgdG8gYmVmb3JlIHRoZQ0KPiBJRkZfVU5JQ0FTVF9GTFQgcGF0
Y2gsIGJ1dCBJIHRoaW5rIHdlIGNhbiB3YWl0IHVudGlsIHNvbWVvbmUNCj4gY29tcGxhaW5zLCBh
bmQgdGhlbiBhZGQgdGhlIHRyYWNraW5nIGlmIHRoYXQgaGFwcGVucy4NCj4gDQo+ID4gV2hhdCB3
b3VsZCBiZSB0aGUgcG9pbnQgb2YgSUZGX1VOSUNBU1RfRkxUIHRoZW4/DQo+IA0KPiBUaGUgcG9p
bnQgaXMgdGhhdCB0aGlzIHdvdWxkIGp1c3QgYmUgYSBmYWxsYmFjay4NCj4gDQo+ID4gUGxlYXNl
IGxldCBtZSBrbm93IGlmIHlvdSBhZ3JlZSB3aXRoIHRoaXMgYXBwcm9hY2gsIHNvIEkgY2FuIHNl
bmQNCj4gPiB2OA0KPiA+IHdpdGggaXQuDQo+IA0KPiBJZiB5b3UgY2FuIGNvbmZpcm0gaXQncyBv
biB0aGUgInZlcnkgdW5saWtlbHkiIHNpZGUsIHllcywgdGhpcw0KPiBhcHByb2FjaCBzb3VuZHMg
b2suIFRoYW5rcy4NCg0KVGhlcmUgYXJlIG1hbnksIG1hbnkgZHJpdmVycyB3aGljaCBpbXBsZW1l
bnQgLm5kb192bGFuX3J4X2FkZF92aWQsIEkNCmNhbid0IHJlYWxseSBicm93c2UgdGhlbSBhbGwg
YW5kIGRldGVybWluZSBvdmVyYWxsIGxpa2VsaWhvb2Qgb2YNCmZhaWx1cmUuIEJ1dCBwcmVzdW1h
Ymx5IHRoZXJlIGFyZSBzb21lIG1lbW9yeSBhbGxvY2F0aW9ucyBpbnZvbHZlZCBhbmQNCnNvbWUg
RlcgY29tbXVuaWNhdGlvbiB0byBhZGQgdGhlIG5ldyBmaWx0ZXIuDQpBbiBBSSBwcm9tcHQgb2Yg
IkV4cGxvcmUgaW1wbGVtZW50YXRpb25zIG9mIC5uZG9fdmxhbl9yeF9hZGRfdmlkIGluDQpkcml2
ZXJzIGFuZCBjbGFzc2lmeSBwb3RlbnRpYWwgZmFpbHVyZSBzb3VyY2VzIGFuZCB0aGVpciBsaWtl
bGlob29kIG9mDQpmYWlsdXJlLiIgcmVzdWx0ZWQgaW4gKGVkaXRlZCBmb3IgY29tcGFjdG5lc3Mp
Og0KIiIiDQpBbmFseXplZCAyNCsgaW1wbGVtZW50YXRpb25zIGFjcm9zcyBtYWpvciBkcml2ZXJz
LiBIZXJlJ3MgdGhlDQpicmVha2Rvd246ICANCkNhdGVnb3J5ICAgTGlrZWxpaG9vZCBEcml2ZXJz
ICAgICAgICAgICAgICAgICAgICAgICAgIFR5cGljYWwgRXJyb3INCkhXL0ZXIGNtZHMgTG93ICAg
ICAgICBtbHg0LCBuZnAsIGhpbmljLCBxZXRoLCB2bXhuZXQzIERldmljZS1zcGVjaWZpYw0KTWVt
IGFsbG9jICBWZXJ5IExvdyAgIGJueDJ4LCBxZWRlLCB2aXJ0aW9fbmV0ICAgICAgICAgLUVOT01F
TQ0KRmlsdGVyIGFkZCBMb3ctTWVkaXVtIG1seDUsIG1seDQsIGljZSwgcWVkZSwgb2NlbG90ICAg
LUVOT1NQQywgLUVFWElTVA0KTG9ja2luZyAgICBWZXJ5IExvdyAgIGJlMm5ldCwgbWx4NCwgbmZw
LCBoaW5pYyAgICAgICAgLUVCVVNZDQpSZXMgbGltaXQgIE1lZGl1bSAgICAgcWVkZSAocXVvdGEg
Y2hlY2spICAgICAgICAgICAgICBQcm9taXNjIGZhbGxiYWNrDQoNClRocmVlIERyaXZlciBBcmNo
ZXR5cGVzICANCg0KMS4gU2ltcGxlIGJpdGZpZWxkIGRyaXZlcnMgKG5ldmVyIGZhaWwpOiBlMTAw
MCwgZTEwMDBlLCBpeGdiZSwgaWdiIOKAlA0KanVzdCBzZXQgYSBWRlRBIGJpdCBpbiBoYXJkd2Fy
ZSByZWdpc3RlcnMsIGFsd2F5cyByZXR1cm4gMC4NCg0KMi4gQ29tcGxleCBvZmZsb2FkIGRyaXZl
cnMgKGNhbiBmYWlsKTogbWx4NSAoZmxvdyBzdGVlcmluZyBydWxlcyksIG1seDQNCihGVyBWTEFO
IHJlZ2lzdHJhdGlvbiksIGljZSAoc3dpdGNoIHJ1bGVzICsgcHJvbWlzYyBtYW5hZ2VtZW50KSwg
cWVkZQ0KKHF1b3RhLWF3YXJlIHdpdGggcHJvbWlzYyBmYWxsYmFjayksIG5mcCAobWFpbGJveCBj
b21tYW5kcyksIGhpbmljIChGVw0KY29tbWFuZHMgd2l0aCByb2xsYmFjaykuDQoNCjMuIERlbGVn
YXRpb24vcGFzc3Rocm91Z2ggZHJpdmVycyAoaW5oZXJpdCBmYWlsdXJlcyk6IGJvbmRpbmcsIHRl
YW0sDQpoc3IsIGRzYSwgbWFjdmxhbiwgaXB2bGFuLCBtYWNzZWMg4oCUIHByb3BhZ2F0ZSB2bGFu
X3ZpZF9hZGQoKSB0byBsb3dlcg0KZGV2aWNlcyB3aXRoIHVud2luZC1vbi1mYWlsdXJlIHBhdHRl
cm5zLg0KIiIiDQoNClNvIEkgZ3Vlc3Mgd2UgZ28gd2l0aCBvcHRpb24gMSBmb3Igbm93Lg0KDQo+
IA0KPiA+ID4gT1RPSCBtYXliZSB3ZSBkb24ndCBuZWVkIHRvIGNhcmUsIHNpbmNlIF9fbmV0ZGV2
X3VwZGF0ZV9mZWF0dXJlcw0KPiA+ID4gYWxzbw0KPiA+ID4gKGtpbmQgb2YpIGlnbm9yZXMgdGhv
c2UgZXJyb3JzOg0KPiA+ID4gDQo+IFsuLi5dDQo+ID4gDQo+ID4gV2VsbCwgaW4gdGhpcyBjYXNl
IHdlIGhhdmUgdGhlIGNoYW5jZSB0byBkbyBzb21ldGhpbmcgbmljZXIgKGV2ZW4NCj4gPiBwcm9w
ZXIgZXJyb3IgbWVzc2FnZSBiYWNrIHRvIHRoZSB1c2VyIHZpYSBleHRhY2spIGZvciBhIHNtYWxs
DQo+IA0KPiAoVGhhdCByZW1pbmRzIG1lIEkgaGF2ZSBhIGJyYW5jaCBvZiAibWFjc2VjOiBhZGQg
ZXh0YWNrIHRvIFgiIHBhdGNoZXMNCj4gSSBzdGlsbCBuZWVkIHRvIHBvbGlzaCBhbmQgc3VibWl0
LiBJIGRvbid0IHRoaW5rIEknbGwgZ2V0IHRvIGl0DQo+IGJlZm9yZQ0KPiB0aGUgbWVyZ2Ugd2lu
ZG93IG9wZW5zLCBJJ2xsIHJlYmFzZSBvbiB0b3Agb2YgeW91ciBjaGFuZ2VzLikNCj4gDQo+ID4g
Y29tcGxleGl0eSBjb3N0LiBQZXJoYXBzIHRoZSBWTEFOIGZpbHRlciBoYW5kbGluZyBjb3VsZCBi
ZSBpbXByb3ZlZA0KPiA+IHNlcGFyYXRlbHkuDQo+IA0KPiBJJ20gbm90IHN1cmUgaWYgdGhpcyB3
b3VsZCBiZSBhbiAiaW1wcm92ZW1lbnQgdG8gVkxBTiBmaWx0ZXINCj4gaGFuZGxpbmciDQo+IG9y
IGEgIihicmVha2luZykgY2hhbmdlIG9mIHVzZXItdmlzaWJsZSBiZWhhdmlvciIuIFByb2JhYmx5
DQo+IGltcHJvdmVtZW50LiBPciBtYXliZSBpdCdzICJ1bmxpa2VseSBlbm91Z2giIHRoYXQgbm9i
b2R5IGhhcyBldmVyDQo+IGNhcmVkLg0KPiANCg0K

