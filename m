Return-Path: <netdev+bounces-147541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B429DA140
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 04:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA19C283622
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 03:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F59B13957E;
	Wed, 27 Nov 2024 03:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="Fu0nNzu7"
X-Original-To: netdev@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021087.outbound.protection.outlook.com [52.101.129.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CD0288B5;
	Wed, 27 Nov 2024 03:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732679830; cv=fail; b=CCFRYml6Rzbs2KyZzxKtK9lauTqnPawS4wrDFPtaOzukiNJzCsMqT8TNEEHz2IuyZL5k7ELSbOjFGDipzem3mhKb8+xzDonLX/jmTK6jAcu6OMnBGWEoBrBQ/oY3XI+1ui2GA+koyduxj5lUCG56/QZ+HaPwikFYkDNRIWFQoDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732679830; c=relaxed/simple;
	bh=35HjbVg4MJ54z6Mvg57/8rsK5tWON2U0ckWSOcw6ToQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LhGXCVKryxunZ3d/jhB5z/mjeLQkJ5VRytCQDdkmmYtmuMxMu7gCMuEljysbBXkcEH7OJU1bXNkZ6QbJIl571XEUxXmwnE2XzaQTyqR2UAfa5LQvzZPaq/bKUvwORgLrDMJLEtjm0K/VJEISAYat3F2bg54jjFwqtgHIR5RzM/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=Fu0nNzu7; arc=fail smtp.client-ip=52.101.129.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+omy9p8sPcBt1S1jgjWLbHc2+6yrZhu1F0fAu3vRMrOtqvi7blOu9J3THNi7ZjiVF9cz3iZsHgpbPVCf2L5pgZqSDFqbqfWJE4lA4B+4GVghBjP5w78Qi3/q6nComOOwJOBBqEplj9I+Gmht1RQcBinHj+LmUpM+5wwrh5a7PkntHYkRuiqkAvdeeseUtEA4uheIASAI/8qkPlV0Wg5O3r9BGOZtDLbiw9DwAyExgjlPEqPkj/jksKxWN3JWlj1TZhOlYnluU/qNafqZ4etc/VI6EBZC9bdEo3dH6qlO7Bc1t/tni0hhfd2MJMWSQ1ge0+bn0OxGuh5VElnvXt4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35HjbVg4MJ54z6Mvg57/8rsK5tWON2U0ckWSOcw6ToQ=;
 b=v9qj09JbEN+nesS1Rphn/uixhA7lBZABokgYwqUT54T7sH8v7s+Pkv4gHdid+TdT2aAI3Kjp4Mt9YQy6xiorKn0S49xJ0gtz5ASCdNyhGKwH4YKsY5oaYrf7nC5Py4d6rSghllxMbNLL4f1pOipENFwBhmvZIVB02bgvUN5tNdqpGDBtrVDOSc7D08P2Mb5NWLWqsmQzZfNv4MkSYMnK3fRVnJ2ZtqcqkUX3FnmR8AYrx9Ny5fmjNHAvaFJ99wow5DzUsXD9EETMlpHuYNdbQrOWVEcsYQPlssfPFZ7412OC2ajrsea9IG4fKUI77ebyqbCB/oFzOSjwShbrYQMr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35HjbVg4MJ54z6Mvg57/8rsK5tWON2U0ckWSOcw6ToQ=;
 b=Fu0nNzu7Iw5VZRxpq8IvbQph2URsAU/KjMMY0YzTIWAVwIxT3X6fbK5SNYeC//1Uf77UMQ8H4UrPaI36kwzz/laClPNJNBpfaxPy4z1/elX9rdfmMXLfwivEpG1VfDuunRmW3A4AzY5/L0NWd0KadUm1KONJYbYiA5NbIyyFB/9M64M2HRB+CXMeQu2+DFapbQPwN8fZ1ItGpmMFWpmy00KMlXXn8UM5JBKJxkJ3xMYiyTsun0JHdUzi6rV5Qo0mEwq/gWpOPhOuG6P47AE6EwfBZ7XTWToQfx1HItKF0BhoZLaDwj5UicBDCWKomoocaLPP2mbzB0b82Qh1ozjkPQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB6728.apcprd06.prod.outlook.com (2603:1096:400:44c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Wed, 27 Nov
 2024 03:57:05 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 03:57:05 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>
Subject:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5leHQgdjMgMS83XSBkdC1iaW5kaW5nczog?=
 =?utf-8?Q?net:_ftgmac100:_support_for_AST2700?=
Thread-Topic: [PATCH net-next v3 1/7] dt-bindings: net: ftgmac100: support for
 AST2700
Thread-Index: AQHbOyDbxNpji49FAkKFh0hSsYNmWbLH0kUAgABhcICAAlUlUA==
Date: Wed, 27 Nov 2024 03:57:05 +0000
Message-ID:
 <SEYPR06MB51349813139B962351E459F29D282@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20241120075017.2590228-1-jacky_chou@aspeedtech.com>
 <20241120075017.2590228-2-jacky_chou@aspeedtech.com>
 <cc93cc7332e97e31f90edc13496951dc0df12744.camel@pengutronix.de>
 <de34a628-a74c-4558-817e-345a3de46e2e@kernel.org>
In-Reply-To: <de34a628-a74c-4558-817e-345a3de46e2e@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB6728:EE_
x-ms-office365-filtering-correlation-id: 0d45e7b0-7ba8-4a58-ec59-08dd0e978ea7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGlWNGcyNUorcUt0d3VmMXVFYlZ0TU1qZnBRQmc1aW1kRWlhZ1V1Yy9VU3M3?=
 =?utf-8?B?b3kxcVpSNldhcXRrQ1hGcTFwVnh3NW1penBVMy9FVzhsc1NTOXplYnFhZno5?=
 =?utf-8?B?ZzY2THFrRWg2cStYQXFnRkNXbTM3TkxkZzV1dGMycmRCNVJFSGRDMmNlY3ZY?=
 =?utf-8?B?dGR6Zmx3TGxLekNGaUNVSTIyUjBmYTZ6Y1NvTnk5cGo5bVNTMXpDTjNyaVcx?=
 =?utf-8?B?YzVmek9yQSs1S0duUzdJZXpxZFUxTjlveHh3S0ZPOFVPVEdsQXFUREd1bFFE?=
 =?utf-8?B?eDNJUFdsWnpzNTJhN0puazNjQWZrRFhIRnZuS2FZUW1NUHNwdjZIcGRqckFl?=
 =?utf-8?B?NXhqbGVyK2dLcE0xQURlRmhRWGtrUlVyL3JWLzV2SnRnMTl0amwvYkZSaURS?=
 =?utf-8?B?OTlXNk1ZVGV0SGNDTXBTZ3Z4d2xxTFhvT1gvSHB2YnVaSWZueFB3M1ZIRndi?=
 =?utf-8?B?d2RWVXRxNU1CTERZSzV4dGx1M1VpNUpETGJQMWdrdTJ6MlV2NERHYXRLQ2NC?=
 =?utf-8?B?NG9XdjhyWllkMDM5QS9LbnNWM081UEtDK2p2ZWxrWVhQRFZMMVRzOUhsUzlx?=
 =?utf-8?B?dW9CdHBWcDIvVVBZd0pUMWJhQ3piMGFPWEJtQkZGc1ZGUDFQeDd5ckJvaExl?=
 =?utf-8?B?elNjOXM3YUEwL2laMkJDaG1CSWFYR3F1Q3d5TStlYW5sUjVBR3o4cmdtaFFs?=
 =?utf-8?B?TVFGWDJVZ0JOblgrNzZseVVhbkJ2enV1eFJQYm9lbGVzMzlBZXM4Tmc4ZlRw?=
 =?utf-8?B?NXJyVmdpL2VGMnZScnU2cVpUWHRxbFpSNVhraDkzQjR5VzcxNGN6eDBkUUVH?=
 =?utf-8?B?RUtaM3lVTmE4S1RWR3J2Zkxsbk5ESElNS1BTOWRVOWplZ0dZRllNQUhjME0x?=
 =?utf-8?B?YkZWc1E4VnlyREdDRE1RdDJ5WkQwcmJZTklZSHJGbU9rNEtnK2NqM1NvYzNK?=
 =?utf-8?B?T29KdzhDSVZVVHg4WDh2eSs2cGJsaDVVZHJwUHorWktMeS9OU1JtMkVkQnk2?=
 =?utf-8?B?eHVJYVhNRVh1Skh5MlIxN2pBRWc4NTdUejhhMVNETFIxcWx2UTE0NjdyUU1Z?=
 =?utf-8?B?c2QyR29hTEp4eTZvdzdJc1BuWStQT2tDdDdYYzBwQmk4QkRZM2NROEwyRTNy?=
 =?utf-8?B?Y0ovZGFhc1NpbDFKd0lmVjZvY0ZqY3BUNEh5dmxpQkNYUXR1cWg5ZE5NNGdj?=
 =?utf-8?B?SUpqbTFZSmtjL3lQWlF2dmtnZ3dyZW5DQXcyd2g3K0R1S1hhalhDRjgvQ0pn?=
 =?utf-8?B?WnE2cjlvWGhWVlp5bzdrRStJR3lKVkRhbU16Zzkzd1FPTEdwS0tMRG9UYjdO?=
 =?utf-8?B?M1Z0djNpVFVtODBkd2kzenZvNUR1OXdTLzF4RWp2bnNIUE5WMmR2b3g5Wmd0?=
 =?utf-8?B?ME00UUpzcWQzTXJzeXFIckl5aHUrVVBxcjFwZDJob3B5QzJkbFpWTzN2ZStD?=
 =?utf-8?B?YmxzOG9ydU1GdHd2ZWpyZGN2MytHalFsRWpUWSt5VDhSRkp1WUorTlhsZDhv?=
 =?utf-8?B?c3VKWDJJc0xHdTZ4Z1VBZFJXWXhkYm85ZW42akRaV2xNK2N5aGloVDVFS2Q3?=
 =?utf-8?B?V3hsMUlsZHhjM2RxSHo5RHNQOTJXMTBLVFRsREg5QlMwc0xzWDVTTm1lRnV5?=
 =?utf-8?B?QWFaVFBJKysxTDlZbmMyM0l2ekRvNkRwR1NuTmxla0NSVTVSM1lYbFRkODNv?=
 =?utf-8?B?NHBYWk9MUU9xWGh0MTZjTm02eGZKaUErUUUvUmYrakNIVDJTeWJTdUIyRm1w?=
 =?utf-8?B?dW5yVHVSYmMzRzVUMjN1RVo2YSt3VUtyZDhNUHdFTXBEMmpVT1AzdWFOaUFy?=
 =?utf-8?B?TDhVUnlBUWZuY2pVT3RiSTkzZ0RLVTNKNTZHSElIcTJKUDJjWnQ2bnRnYlRU?=
 =?utf-8?B?eHFvYWN2TlZzVlpyVkhOQVV3RSszaXNOWTZZUEptSHBmcmZ1ajY1Y284Wm51?=
 =?utf-8?Q?L84w/PxTyGu1LaviwZ9dfe3I2iHjp55y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0JsOVNhendpQ1pVYURaMWtSUW1mRVQrdDhGV0ZmcmlQbGZURk1wTG5FS05i?=
 =?utf-8?B?K0lrUnhqTVBUV1Z1ZFpIcUVyTldOUDJBOXJpV2diVjFoRFhJeisxMTF3VFBW?=
 =?utf-8?B?bGZiNk8vYlllRm9NU251TDNvWmtJaFhYeTlOMFRCaUlROFozWTB4SjJaQ3VE?=
 =?utf-8?B?VVNMeVM4NDBPZnE3RmdPT3lpUm5YYk5HQlRLQUJxdng1M1BjcDYrN2xOZTM3?=
 =?utf-8?B?akdmMkdvVFdCUVdFWDFsM2E4TzBHNEI4Qnk4ZWpwU1ZMdFpueHFpQ1BaZ3pl?=
 =?utf-8?B?WWR2V2trdHBnR2ovSXNORytBc1BJZVBlYUp1dEROQnc5TXRIdE1GNHB3U0Nq?=
 =?utf-8?B?TWp2czFaTmN0bmJoWGlPdi96NlorY1lGcU9KRi9OR1JvMEZiSUpVdDJzVjlU?=
 =?utf-8?B?M0dqazdReGQ1WFBlbkVSek4zUDNiSWptazBXQWQ3NWk5TWVZUkR4YkdzS1M1?=
 =?utf-8?B?WUZCbExSaGhkTXdoRkpuVEp3dHJFaVF5VTFpcks5T25NNnN2d3ptNjI3c0h1?=
 =?utf-8?B?alBGYkFibjUwOHJyWW5BUVJCN3N4ZzBXSkltY3BPWFcrRWVGNXc3MGxiSndR?=
 =?utf-8?B?a2k0Vm9sVjcyOWVzSDE5enRhdzlsQVZkNDFRcUpKcnc0ank5c2ZDZXduSWV4?=
 =?utf-8?B?eEJzWlhaQ2M5ZldxSmhjai83K2JvaXNqTEhXZ0tNZnpWWUJDcS9DMjZmdDll?=
 =?utf-8?B?bEhTRUdwc1lkL0Z0TWhIbXhvZ01TZ2FNZHBXT1RJSEtZLzRlVHhmZVNSZFFJ?=
 =?utf-8?B?Q0s3MmhGS3RvU3c3czgySEJaNk1JR1diVDgrVFYxVW5vVjZncE9DYmp3RVRo?=
 =?utf-8?B?WFJCZStwY3JCWjZDbE43aFA0UlA4M254Qm5EeVF4ZkR5VXIvZGdGVlIxdTVC?=
 =?utf-8?B?bGp1SndtZEhaKzVlczZXVzZXMTN4b2tvYTJ2NUhhN0NncXpFd2J1TTFwTnBn?=
 =?utf-8?B?VU9Jem1Hc2Q0MCtBNTNLUEpNaHN6T1FDakdPemUwblRxVklyUHlUMXlNLzg4?=
 =?utf-8?B?V0tQbU14T3BSMHpEWktDQndxSm1zM1ZHLytvVVBTYUFkMGtWbmZHMWNQK29K?=
 =?utf-8?B?R250ZVVNRFBUUjdnNEhpaUYwQ21TYS9QQVJHbHZGT1hyYWNJWXNWc1VuTVVo?=
 =?utf-8?B?cHJMMlVIeHVLZ3FzNlVVVXg3RlRtS1JJdlFHUndKTHB0ckNNYnZEaU1FaENK?=
 =?utf-8?B?WG1nSnNWRHdZei8yZWRwNndVOVZ3NE9BL1RWNTUvU0FxcHpWK0E2OGwvdDRS?=
 =?utf-8?B?ang5N2tlOGQxV1J1aDJsNHNtMUlZTnp0VzRzbFpCRFkxa2NhemxhaEd1STNT?=
 =?utf-8?B?L1lHSlQ1SkNLN21mV2xvcXN5bmpzNG94SE8zYzM3TldzL3RDODhhbUUyTDNW?=
 =?utf-8?B?RmJDOGVsVjErTncwcHY2d2pHSEpPT0VTSWhRSnZjSGtocEtpTEIzZUJZRElo?=
 =?utf-8?B?Z0kzcldBOVNqZ2liRjQ1bWtmd0hYTzZ5djMxaWZxSUdmUGxLOUtnZXRsaVdH?=
 =?utf-8?B?RmVsMXFDYmIyQStVUjQ2TDRydFk4V0UyTm1HeGw2VmdJclpzM0JvNkUvNWIy?=
 =?utf-8?B?eWJpVTdIYXRueml0TjJYb09WWHcrcXlwemlmYXczdmdGTFpMRDExZzh0bWh0?=
 =?utf-8?B?NHlyUzVVN3BiL0NjRG5tUi9aVklEYVdXUlhaSmZQTFNxS1U4ZXdnV2hUMkI1?=
 =?utf-8?B?MCtkU3Yyb2VmamErSWxNTE9pS0xCY2xXU3E4QUZOb1pVNzd5TlZOeTdleGNl?=
 =?utf-8?B?L1RjN1dUVUNVZ3NaS1RXQXNNSzZrLzZDRHhJK1BkOEhLSkF6ZWR5L3c0bzNB?=
 =?utf-8?B?a0w5eHc4MUxrVkF4UGVNUWJSTHpHRmFhNHdOS2ZKNURyVHJUdThYalFmbTRR?=
 =?utf-8?B?cXRJMjFDTzdvWHR1djVrcmt5VEN3OGNpSytVckxRMHdmSVIxNDUxVFVnSFp5?=
 =?utf-8?B?ZUJZKzE0dVNZYU5yaVZtWURYS3kwQWJ6MjU1QjJLdUdFUVEraUY1WG8yOTlZ?=
 =?utf-8?B?QkIwQ2N4UVFrVzEveEs1bUxoM0M5RkxwZWduTmkycHRvcW9PbDBnVCthZVYz?=
 =?utf-8?B?NXNGZzdFUzBoZzlBUkpBQ2N6andzbkJTQkFWa1p4THllczBOVUFzWGdTUGhl?=
 =?utf-8?Q?SLw+HrzX8CfUqY5z3VB181i0C?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d45e7b0-7ba8-4a58-ec59-08dd0e978ea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 03:57:05.2154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJFp2gY1WS59uz/FKLE+1D3gOpj5X3p3bBLmjns5kvOz7Tjf8V4EziHmlpkutY/UsSVDRA/UJssrDHgka+ZuRfBs87k1h3Gsd71UNrkxGfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6728

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gPj4gZGlmZiAt
LWdpdA0KPiA+PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvZmFyYWRh
eSxmdGdtYWMxMDAueWFtbA0KPiA+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9uZXQvZmFyYWRheSxmdGdtYWMxMDAueWFtbA0KPiA+PiBpbmRleCA5YmNiYWNiNjY0MGQuLmZm
ZmU1YzUxZGFhOSAxMDA2NDQNCj4gPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL25ldC9mYXJhZGF5LGZ0Z21hYzEwMC55YW1sDQo+ID4+ICsrKyBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvZmFyYWRheSxmdGdtYWMxMDAueWFtbA0KPiA+PiBA
QCAtMjEsNiArMjEsNyBAQCBwcm9wZXJ0aWVzOg0KPiA+PiAgICAgICAgICAgICAgICAtIGFzcGVl
ZCxhc3QyNDAwLW1hYw0KPiA+PiAgICAgICAgICAgICAgICAtIGFzcGVlZCxhc3QyNTAwLW1hYw0K
PiA+PiAgICAgICAgICAgICAgICAtIGFzcGVlZCxhc3QyNjAwLW1hYw0KPiA+PiArICAgICAgICAg
ICAgICAtIGFzcGVlZCxhc3QyNzAwLW1hYw0KPiA+PiAgICAgICAgICAgIC0gY29uc3Q6IGZhcmFk
YXksZnRnbWFjMTAwDQo+ID4+DQo+ID4+ICAgIHJlZzoNCj4gPj4gQEAgLTMzLDcgKzM0LDcgQEAg
cHJvcGVydGllczoNCj4gPj4gICAgICBtaW5JdGVtczogMQ0KPiA+PiAgICAgIGl0ZW1zOg0KPiA+
PiAgICAgICAgLSBkZXNjcmlwdGlvbjogTUFDIElQIGNsb2NrDQo+ID4+IC0gICAgICAtIGRlc2Ny
aXB0aW9uOiBSTUlJIFJDTEsgZ2F0ZSBmb3IgQVNUMjUwMC8yNjAwDQo+ID4+ICsgICAgICAtIGRl
c2NyaXB0aW9uOiBSTUlJIFJDTEsgZ2F0ZSBmb3IgQVNUMjUwMC8yNjAwLzI3MDANCj4gPj4NCj4g
Pj4gICAgY2xvY2stbmFtZXM6DQo+ID4+ICAgICAgbWluSXRlbXM6IDENCj4gPg0KPiA+IEdpdmVu
IHBhdGNoIDMsIEkgd291bGQgZXhwZWN0IGEgcmVzZXRzIHByb3BlcnR5IHRvIGJlIGRlZmluZWQg
YW5kDQo+ID4gcG9zc2libHkgYWRkZWQgdG8gdGhlIGxpc3Qgb2YgcmVxdWlyZWQgcHJvcGVydGll
cyBmb3IgYXNwZWVkLGFzdDI3MDAtDQo+ID4gbWFjLg0KPiANCj4gDQo+IFllYWgsIERUUyB3YXMg
bm90IHRlc3RlZCBhdCBhbGwuDQo+IA0KPiBKYWNreSwgd2hlcmUgaXMgdGhlIERUUywgc28gd2Ug
Y2FuIHZhbGlkYXRlIGl0PyBQbGVhc2UgcHJvdmlkZSBsaW5rIGluIGNvdmVyDQo+IGxldHRlci4N
Cj4gDQoNCkFib3V0IHRoZSBEVFMgb2YgQXNwZWVkIGc3LCB3ZSBoYXZlIHZlcmlmaWVkIG9uIG91
ciBTREsgYW5kIGc3IHBsYXRmb3JtLg0KUGxlYXNlIHJlZmVyIHRvIHRoZXNlIGxpbmtzIG9uIG91
ciBnaXRodWIuDQpodHRwczovL2dpdGh1Yi5jb20vQXNwZWVkVGVjaC1CTUMvbGludXgvYmxvYi9h
c3BlZWQtbWFzdGVyLXY2LjYvYXJjaC9hcm02NC9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWc3LmR0
c2kNCmh0dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9saW51eC9ibG9iL2FzcGVlZC1t
YXN0ZXItdjYuNi9hcmNoL2FybTY0L2Jvb3QvZHRzL2FzcGVlZC9hc3QyNzAwLWV2Yi5kdHMNCg0K
V2UgYXJlIHByZXBhcmluZyB0byBzdWJtaXQgdGhlc2UgRFRTIHRvIG1haW5saW5lLg0KDQpUaGFu
a3MsDQpKYWNreQ0K

