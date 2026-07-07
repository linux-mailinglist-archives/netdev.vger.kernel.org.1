Return-Path: <netdev+bounces-305319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PBicKgi3TGpcogEAu9opvQ
	(envelope-from <netdev+bounces-305319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:21:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7F9719046
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 10:21:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=A08000so;
	dmarc=pass (policy=reject) header.from=altera.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305319-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305319-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABA2C3040960
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 08:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F1029B78F;
	Tue,  7 Jul 2026 08:08:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CE329D264;
	Tue,  7 Jul 2026 08:08:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411722; cv=fail; b=R5b/h+dVABRB1a+eOa7xowTqiUMFrYyD6mSU8KAPI/PDVXmuztBHr/D+cxkJ9YUgbsrj0zxsuBXSUB1mrLttHCprvfUmoPGGVumxovzj7YxLWAxHqOARwgBVlEdbFKm2uy5qtxMMO5L6JYbRCnzTY/nJlAWrq5z3N5pl5/lah8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411722; c=relaxed/simple;
	bh=4oR0hu9iskowfYfYb9jZeUmxASNDppST3z0H103Mh1I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=odLUk8FWmqL87ZOzB/7HGbOjEuP1uQuwPXMqkmIqWdTSA1uHXAFw5KC4g9OMMKr6Knrqq0fnx2n01//Ij3C8/e4xjJ6KeT12SjGBuvZxtfKlAZv/p3QhRmQ4i+WnamG4lgaOd0j7F7Tu4p3YTmd7RnrIdl5Igalr7OtH0hCVwU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=A08000so; arc=fail smtp.client-ip=52.101.56.41
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQnggwcgFpseyrlCbDrMG2UUlPC5Y+AHPtypBYUKUW8UB3l5IOlZbtphllZ7EiwFkGWcdQj961nFHla+QOC6cH3HNDpEZmg4+afoKQlKl8mSpR0FZ9/rGHeIwZE8vDLfPRtWXO++K1LSNp9Tz4nFyIVu5iZF+tEGLmXPYfeSnyyFoJpTr+CirBeXtrXbHtobbvzFsICRvqtYzaa2FA7NJyazfIoEuTC3oAnoZLUsMTH1XxkpyQgSfYK5n0V3q61kKQW64tFheA/eHc7nVwaGGiCXA8tbUYiXtjqF7U5W7WiHjForKrinOd5APzMNpOuOc0RX8ohTSQaOTRw7IOUyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oR0hu9iskowfYfYb9jZeUmxASNDppST3z0H103Mh1I=;
 b=Hx3CZEHA/4WStXwiEnr+wDwAvoyzMV4VNO+t/9EZ+7g0tzlFuwiTHfKIhn+dqO+7lsKySwUOlYxyDs+/bWW8LDc3gtqNUtilkEjNx8QtdUvxKoLspiD+UlqExqz2vihHzp6SqHuOsZETpd01RYRkguWYUvqfjB6matkIdCtyEK6sChJLiMC4aBzscw1Trq8vA2BNcNv+tb4h4fM8FfI6qwIJa8QqiYMeQ1tR+J+JjJbeKj/Nmw9UOl3LAzcqVGFKF0FNeE4JVuM3f9G8nehcXV276Z721e0xkzpbdm1HrTXFQNwbZ4cL+RCW/PUo+WiULEGirZfWH42BrvXGCMeaFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oR0hu9iskowfYfYb9jZeUmxASNDppST3z0H103Mh1I=;
 b=A08000sommOp+qi1tunsSSqyt4f+FZlpyS7wIC/NjYSprKoN503FDNlrv/9x7zPKxGygJXkoCycde5cMjE70gfnH32CpZoQgVCf/uUZz7KEIv+lZr157RZGfQuG1AtX6YKJp91okfR9fXI5KaXmMYCyJMvHqKAzrmm8+P9zOlzNUDzzxc7VSsj51CuEdk1qFFEZZyAyVaFMITaQcyUaUUtndvvq52JdG27wxmDIellms/CbcEI+vb7Uu9MHa7Xt2Pl7o1qb4yOpqbdnAIgDkYXxrQmkMtdvcq/BEXRalG7HuDfOxHo9+BkjP41s2VSrVieOTc1W1wbCRgr95Odo+Wg==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DS3PR03MB989144.namprd03.prod.outlook.com (2603:10b6:8:39b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Tue, 7 Jul
 2026 08:08:38 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 08:08:38 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "dinguyen@kernel.org"
	<dinguyen@kernel.org>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>
CC: "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: altera: Add Agilex5 SoCDK TSN
 Config2 board
Thread-Topic: [PATCH v2 1/4] dt-bindings: arm: altera: Add Agilex5 SoCDK TSN
 Config2 board
Thread-Index: AQHdDdet/Hhk5cW5yEi55aAhwx3SLbZhm7EAgAAYPYA=
Date: Tue, 7 Jul 2026 08:08:37 +0000
Message-ID: <a93fc9d6-8e69-4625-884b-1b5c54748b6e@altera.com>
References:
 <20260707061305.27580-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260707061305.27580-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <8e9a2c05-178b-4360-b814-660d049e50a3@kernel.org>
In-Reply-To: <8e9a2c05-178b-4360-b814-660d049e50a3@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|DS3PR03MB989144:EE_
x-ms-office365-filtering-correlation-id: 525c865f-4b2d-4d4e-5ef8-08dedbfef312
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|23010399003|55112099003|4143699003|11063799006|38070700021|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 C5kc5wc3Y08XyrRLH//bMvSMkM4z237XVW4Dsm9RciyRtzxOrOsrzx8KaXNhcRl5i9spqWUdJsBEGO8+YSDJCFhaxxfjqC4ZXhHnzQYXXwZo8XfJGxAfWsxq7DdFNLWT4xiO0cGdwhHuNa1iTIJGwhqu0RLGniykspdInWhtMgXENdWvaJhYVtsn1OYShEmhNQKZ1S4Uh3SRTOd3M5ERjnPFiRgFM7OnrGAtEyY5v6YszU9SroFE9n+IbIhhxrucg0nLhup2+Z1opl3c0SeeKbOdmgmUi42p11lY02b/45O0OA7nsrdu1UROIP3hMs7UWMvdiruTNlcHsRaK/OlzqWoFlAlBWRjGqckD1s+4WqAybSbb7ABjzRX+RlZaOJUFzH/Lz34Q2SmXalOAS/fSktS9rugCqKb1HBWhb/zF8C1P4tP1Yry+ve4+mAfTHQKoEleJdkPu19if2t/NOJ+MZR2dfB6hyKZhNpH0XA2IptaCFWVMWsHHbArq1LFDOWv69d9tpEfWzU2N1x5dkjmi2dsg3EgSIHzXwG3a6ZjZtyULqaD8MTghSyXaj9TdJzY1mcoP5IYJkP+usMy+Kru2Cvbpqc/e/g0DdTADaRZxKHyMS0F8Ro6R51CvjkcnJNttcCQSPwSWSehkthBvofcbo3+b7hEfBbrXRHiGJkuQskuIG03aPfKDAalMbSu6nUf/80JAHZbLQRtF/74rBpaIR0IjQAN0veSiVQhhmNGyYMo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(55112099003)(4143699003)(11063799006)(38070700021)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXVKeGZkWURtcnZKWWk3UjV5Q3djNGs0SU9tOW5TNTRjc2JJT243NXVyL2NB?=
 =?utf-8?B?T3I4NUUxSHZEZ094QnNTUTY0SXZBQjdLM0Q4UC82WEZUQmRRamQ4M2F0VU9P?=
 =?utf-8?B?aXR1TTJheExndzAvYU8yR3VjYk0vTnp3djRNbGF2bUt0OU5xb3N1OWFzZE02?=
 =?utf-8?B?M1dxWVVadmwrTis2eXhiTDdiaWdIbmVucTduV0xOL3BpVjFBazlSdmFqYWVW?=
 =?utf-8?B?elIxSTFPY3VkMW85Z1lqVFBUSWozQThnWC9EZWFxRW1sK2RuOGROSzdvNkpl?=
 =?utf-8?B?TnZuK0MvSlJ3YXBOYmtQTjZuVTF5V0JoZnF4aUp2V3c1MUpNbmFmVWFXMGpr?=
 =?utf-8?B?TFNTSklCRFlGWjVnZnhaMmZDSDJLVkdvSnBkZTVZUzBkVFlmYTBqb0R5NGp0?=
 =?utf-8?B?Wk1FWkVDOUNyRkZYV0dGaWVPU0RoditoV1JSd1kvTVFqb0hGZWJ2ZStsS2JI?=
 =?utf-8?B?dDM2Rm5OcEhHN1NQN2JzSkpTSXN4dVdXdEkzc0l5STJwTlNPdmxTRno3Tm85?=
 =?utf-8?B?SVZPckY0eEYvQ3FSNnhYZzE5d0ZXTmpZYmNtUnl0a0JTQmFSNUFpS05ZeHBE?=
 =?utf-8?B?R1NFNHFKTXYzNkNpNG1MMWg2ekVYb05vZkVGZW9Sb1pnSXl0dDhjektWL3NG?=
 =?utf-8?B?eVhnZmhhWXErRUlRbUZxRW96MEFNZ2l6ak5OSTlNSEVBYm9pMmZBeExidFRN?=
 =?utf-8?B?U3ZESEJSWXhmS3grVWYwZnRqRkdycFhrQWlONlcwUDJDbGkwZ0Q3eS90TkV2?=
 =?utf-8?B?NTJ1US9Md3RGTFBTMEx5R20wWmtTYVNYL1haOWNrMlNubS81SEVBM202RmRn?=
 =?utf-8?B?YlBkSFpJK2FtZktWKzJLbG4yRkdxemNzMXBSdW9CNGUvOWNpdFlvOVJkNDBK?=
 =?utf-8?B?WVNFbXlBdE9qbHRqREFJcVJSQ2tVS1RkUllEbE9Jb1hqS0R5aERKKzM0TjRF?=
 =?utf-8?B?OGdWcUROZW5jUmVUeFFERHhWTGMzUkkzVW5FRExDRDcvQUVKYWJoV0t2c0RH?=
 =?utf-8?B?UWMyN016N1JEaHZIeVlPelplQ0JkOS9GMzQ4dURsTlI5eHkxcWliRHU5Y3VG?=
 =?utf-8?B?NUxkT3d5Z2hnTGpmc0IwZ0JjbE5BSVZ4eDBiNkVDUGZ0eEYyVFA4bzhEUkRm?=
 =?utf-8?B?VURlc2JHZWhUWmlTT1JBRXdQL3JzVEVSVWhDalB5K2F3eDluaklRMkZMbjky?=
 =?utf-8?B?R2R6UktmNWx4SHM0cmx1TFpyUTBJdzJ4azk4UXJTR1NRck1WM0lRSEpXU0Jt?=
 =?utf-8?B?akRreG0wT2FieDFhSzQzSDNZSTFZMHFoV2xPUHZTMy9GcWdnQXVhcVNjdlFz?=
 =?utf-8?B?V1hrbkw5SjJBMzlSbTRxK0QybXVOUmdmMy95em1Xb3JoY1B5QmZzeFlFNW9V?=
 =?utf-8?B?ZVlrdDM2WU1tbEM4ZjJUc1c4dHBlRzhnYVVPK1o4MTFjSkFKcURqTW9QcGRj?=
 =?utf-8?B?UG1kTUs5bVZsNHVCNmpuRmF1NndnSUQ3RFZFZ3Jram45WVhqYnplTFRjREFl?=
 =?utf-8?B?RWh6d0VVaFZvYUVpZ1A0WmdHek9DZjB4dXk2UzdEcFBlWWtUSDFXOERhdjR1?=
 =?utf-8?B?aHNha3EvYUttM3NScCt1cWpuaEZGTWNjYVByMHNUdXRFOE5EWDQ1MGN4UC9O?=
 =?utf-8?B?MGJqMkhtY0hLVzNXRmc0K0NNQ3J5a1FNL09nTlBqVkNMQUMzUFIzbU1vaitN?=
 =?utf-8?B?ZTFxakxNcm4rUzVidjY4RkhWaEdzd3hSRXgvaXBxNlZ4STRLVTBKRjdaV1ZV?=
 =?utf-8?B?UkxwRDR3YVhoNWgwa2daT2MzL0JXRDZjekF0bEVkTkY5Z1liVElZWnhqWXcr?=
 =?utf-8?B?YXNGclhDM0hSS2w3MitmR2lablpONTR0Ni83QVd4d1R6c2xseENCUVQrMVJp?=
 =?utf-8?B?YytpeWdkamlteEZmZy9tV3R6cHZKcVhxNDhUc3Y5NzNWUVZIYmozVjVhNU8x?=
 =?utf-8?B?OFdKK0Y1SUJhdm9GbTlRUWFWVWlzWnIxWVVEY05ITHQwRDkrVURTUzNKSVZv?=
 =?utf-8?B?RGJ3cHp1ak9PSGlXMTJVUWQzbFBVRHFaSWNwNkROZVdNTmE1Y2diWkM1TWIy?=
 =?utf-8?B?a3dOSnFqNXJDZEFjUGdwWGhrQzJuSFBWdlRjakd3VXQ0eEhKb3AwNEhNczNL?=
 =?utf-8?B?MWtvS3NXV3h6eFBPSThVdDBTR3Zrck5IVEVSM2pSNjBUWXZ5a0ZnTFl2c2o5?=
 =?utf-8?B?MytNMkhEc0ZYV0JWTkVLWloxdVRQRVJ3RGMrdFJnRmw4a3lmaWx1MnRRQmpB?=
 =?utf-8?B?QS8rVGRHaUtzVk16SjkzdnhBVTNtalZoYkh4RmF3VTRTcmljY1pMa01KMHJm?=
 =?utf-8?B?cWQzd1ZQU2E4UExwVjd0SXM0Nmcra21ndEpYbTVxNFUvalE2U3dYcURlN1li?=
 =?utf-8?Q?5uq5hOwxf2Xny5K/ZMyuguVMVWJ0uKXwBNl0GRZgRSgNB?=
x-ms-exchange-antispam-messagedata-1: cnhyLG0e4EWniQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <94E97A14C6450C4A929232EE785AC613@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525c865f-4b2d-4d4e-5ef8-08dedbfef312
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 08:08:37.9144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eLupp7rqkSnC64Iel7fxCxo9gOqcuZ0AyMJ2M1K5nh/zgkkQpN/nb9S3Aq90z4IBVtxBhGA1yQFcXhyMmsQZjeYqW8yRuUn4RDDdqiwiy5Qjc6+EEBdgrymnGiEt79o6gcPCddu1c7MV0GhVzA/wUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR03MB989144
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305319-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:dinguyen@kernel.org,m:maxime.chevallier@bootlin.com,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,altera.com:from_mime,altera.com:email,altera.com:mid,altera.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C7F9719046

T24gNy83LzIwMjYgMjo0MSBwbSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+IEFkZCBj
b21wYXRpYmxlIHN0cmluZyBmb3IgdGhlIEludGVsIFNvQ0ZQR0EgQWdpbGV4NSBTb0NESyBUU04g
Q29uZmlnMg0KPj4gYm9hcmQgdmFyaWFudC4gVGhpcyBib2FyZCBlbmFibGVzIGdtYWMxIGFzIGEg
VFNOIHBvcnQgd2l0aCBhbiBGUEdBDQo+PiBHTUlJLXRvLVJHTUlJIGNvbnZlcnRlciBwcm92aWRp
bmcgdGhlIFJHTUlJIGNsb2NrIGRlbGF5cy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBOYXppbSBB
bWlydWw8bXVoYW1tYWQubmF6aW0uYW1pcnVsLm5hemxlLmFzbWFkZUBhbHRlcmEuY29tPg0KPiBT
byB5b3UganVzdCBpZ25vcmVkIHRoZSB0YWc/IFN1cmUsIHdlIGNhbiBpZ25vcmUgcGF0Y2hlcyBh
cyB3ZWxsLg0KPiBEcm9wcGluZyBmcm9tIHBhdGNod29yay4NCj4gDQo+IEJlc3QgcmVnYXJkcywN
Cj4gS3J6eXN6dG9mDQpIaSBLcnp5c3p0b2YsDQoNCkFwb2xvZ2llcyBmb3IgdGhlIG92ZXJzaWdo
dC4gSW4gdjIgd2UgcmVzdHJ1Y3R1cmVkIHRoZSBzZXJpZXMgYnkgYWRkaW5nIA0KYSBuZXcgcGF0
Y2ggZm9yIHRoZSBuZXQgTUFDIGJpbmRpbmcgKGFsdHIsc29jZnBnYS1zdG1tYWMpLCBhbmQgZHVy
aW5nIA0KdGhhdCByZW9yZ2FuaXphdGlvbiB3ZSBhY2NpZGVudGFsbHkgZHJvcHBlZCB5b3VyIEFj
a2VkLWJ5IHRhZyBmcm9tIHBhdGNoIA0KMS80LiBUaGlzIHdhcyBvdXIgbWlzdGFrZSBhbmQgbm90
IGludGVudGlvbmFsLg0KDQpXZSB3aWxsIGNhcnJ5IHlvdXIgQWNrZWQtYnkgaW4gdjMuDQoNCkJS
LA0KTmF6aW0NCg==

