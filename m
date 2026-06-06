Return-Path: <netdev+bounces-296105-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kI/1D2URJGpW2gEAu9opvQ
	(envelope-from <netdev+bounces-296105-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 14:24:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FB764D651
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 14:24:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=ABOt3rcb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296105-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296105-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D678300FB3E
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 12:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842D23A4539;
	Sat,  6 Jun 2026 12:23:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013015.outbound.protection.outlook.com [52.101.83.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E242D0625
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 12:23:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748638; cv=fail; b=Ve1IOvI/Ty/NQlgPmLtwpCpMA/RfA6xw+pG6QVj1EDrE7hs6xaX5zQs1YAwY0O8SEpCUsm6NnFnUNDUTpNU/Yvb9iYEuJRcfxaQ+5SrvbtbuwMrcPjSCVoxkY8+dj/JDfMEuq6rWPpVRCk9/Ew+qIGAyqsYEkDV7JaltDQN6+G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748638; c=relaxed/simple;
	bh=TtvSknVCuNlgfUEFzpQJ/DOyZQExEob1xHfiDz/3iDA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LSZCI1N+vErwO+uDIHTAEwIPtJD6mdc14E+UJZFR66DGhOa6vNyv3SNDGgT+Y8T+TNh/G9vBr/2zR2abV8CqgXbI2UTR4eW2PCs/GHUVsITTR4ZfTd6s1RVrP+OFN8MDC2Ulpoxh5n2krOX5MYuG044HxWl0BRPSkHE59pmUS1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ABOt3rcb; arc=fail smtp.client-ip=52.101.83.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucCyy9MuF+x3pW78RY/NWwpeY4DN4kJRKsUKhDlTrizc5cuGFKt7W+EAG+UU1DFCY9mSqYbJ5UQUDIO8A2DXuNJxhxljG35L2ZxwrZJd5UqO1ycp+2ShUr1+svMN5FkLHq0CVd97YvsxiN2NfIAKJUkZRhv6DMbXRx2h6Ar2gEqZ6UbVoZfv+7ktidV22wGa2nx9aJVVm6RajFAxizAn0k7PM1EDC3aTT0LxX2h98/BTSmkxunY7zaYZ9WijTOZRfroc5MOnB2W29Dc4fYZrygtsQPpZ6QRiuBK0HUv14HbdgD8oRmnQhd3hske8VYdWfLdxV6Qgz5iYE5tN3whAgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtvSknVCuNlgfUEFzpQJ/DOyZQExEob1xHfiDz/3iDA=;
 b=No0NcfGKKUUeCgMxahzT3ehuARnD+nfaLw+NTQogAo03F1qkBrkfGb83EAFfzx2LwpX8jeuk1GVg5WXTVmWmrZUL68SHhyRtxFLzkDrT+au3uIMDVPbHwu00wBop83CFiEqAIHxQ0fsfo6uZsqcn/cCAj/Ho6kGSjjK3VWqS30Gk9TfQGPnqdUQaOyYCVlAqcJ4jyMDJ0TsDqwXFaTtuFer31ODJwHSqpncKvPH1DWZfY0hwHPPkaO1ubygx/7jd6aNO17JkMclbiw7zoCEMQWAiJJATKtbafCIJVjtoj4Q1BPVSrIRVLwi9bIXbnOd4WZXER3ZfE72rQIpw2+e/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtvSknVCuNlgfUEFzpQJ/DOyZQExEob1xHfiDz/3iDA=;
 b=ABOt3rcb7++NEk+GFd99d48m01/uqgYMF8Yosfq/l1eGuNZqZIaE9EBqZQ2go4ihF71mv6rPErNhnc+X33LyCMg1CxDjvUoDaakc3iePWXBaETdirX1t+jAN7rLqxFalMKs3yE7ziWuXxByr/eZ6RzS9KePUYkh9NRaG4/3B2RdfirtrSsHNSzBtBn3+az0T4B3RLb3zYa+XAnLMaQ3S36Mw7h1Ljf66x79oiGosY1AS/26mO9EaHbhcggRsjYa+3zGFcYQb8edy/nDbAzyXpIgu39WszGF59RW1urtwkUZjeYAIMwxKPAMLADrZ7aRUU/pK/Sk/R7+mNjJ0rKUe/Q==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by GV1PR04MB10847.eurprd04.prod.outlook.com (2603:10a6:150:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.10; Sat, 6 Jun 2026
 12:23:52 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0092.010; Sat, 6 Jun 2026
 12:23:52 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>, "Wei
 Fang (OSS)" <wei.fang@oss.nxp.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "Frank.Li@kernel.org"
	<Frank.Li@kernel.org>, Networking <netdev@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 8/9] net: dsa: netc: add bridge mode support
Thread-Topic: [PATCH v3 net-next 8/9] net: dsa: netc: add bridge mode support
Thread-Index: AQHc9I0KR17o6Bw3E0+XrQboLDzVHbYww3gAgACyFoA=
Date: Sat, 6 Jun 2026 12:23:52 +0000
Message-ID:
 <DU2PR04MB8629D6CA18622874537E5BA8881E2@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260605014808.686024-9-wei.fang@oss.nxp.com>
 <20260606014626.B0E3A1F00898@smtp.kernel.org>
In-Reply-To: <20260606014626.B0E3A1F00898@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|GV1PR04MB10847:EE_
x-ms-office365-filtering-correlation-id: d1e806e0-c327-42c4-0613-08dec3c6783c
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700021|18002099003|22082099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 HXmeOJyDsDTxOgWq7XheRPokyWqX47nSueqPbKTmfSiheQ6m7myk8R3g7qznCLDnBsNhbKwo19t0MLHzxncZENWpWmB414x4cYaCEMDalSFF1EdoqhrAe/9C2c0zHGM6SwWpjWYTrhq1uNdVMVdxWD9xXNeAfmDHDes9Qd11dTbkqOBtn/rQ80VSvRleJI/s3jHr5FnR9KUX9uv/pxnDohmYW6StWWEuKwDiPw3UYwhdF42rwTZz/y0lO/2QUgkpS3BX8EQd38Qy3/OWt1+WdRtStw7hHwdOwhRHdYR6gyVhV5iagwNirAqZQBtdqgM2s1wYgVa1utFl+J4IKBaCa2pV/B9blH1d4K5Lzb9qwn4oYBm21bfaiqnyq59MgN/s6kjzgDbvYhaYhiO+w3HoQiKl6BpvWNNEtQt07bCzMVG8F7Nk/8TF6TAAwM8AyWltXYygRrv76YvZLmpssCjqMrP3db0NuriWtUDaYovPcWjZdogc97XtWtrvJLplhmA9AzzfH97kvwhuDJfG/5PAonUxoSzQE1JCZaP5uEZwkhc4AyUwuy5bZ4rprYDtCx9clZT8yYCk+KAjgIK1trwJo9rgVjGDkIxTcB/NPm2Z0Ie7DOWndeNsrfcCYqzST9g5IEVIqrrALx+pAK178neKI86hpriBcgPwqNWyScSxARbvFJnmUJcvdj+hc+YB2L3oF1jKwaPxPPtNTYdYEjaJv/qRpYP3Rszj0PwlTEIo9k009xrPXV8sWpEgGWyZpalf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlNZWnUwa1BGYjlPMFBQSDg3cEpzQ0xOSkMwSnlIcDlBQTE5RVF5NjQyekRB?=
 =?utf-8?B?ZEM3c1NEWHdrV3JXemRVclBvd25oQVFGNG9YY0NSMm5MTTg4OXNQcnQrbTU0?=
 =?utf-8?B?WWFUanMrYUhUdDRvbDFUZHBxS0I5L0VaOTBJRitjWVV5TGUrcExaWHQwVHJu?=
 =?utf-8?B?VFFzb3JnZ3laVWFtMTRMNDlYdS9mdzNLeDdrUXZiOEpKdGd0OEVSWHZrY1lU?=
 =?utf-8?B?OW4rK3BnSUFEcDBOQ1ROMm1yK21IZDBpWkU2N0V0d0dkUkVJbnEzTUZ1NGFX?=
 =?utf-8?B?cHBhblFCSytEbWJaSVp6eE93eEtjMG5HalJjL2RNTERScGxuanM0ajNQT3d2?=
 =?utf-8?B?K0dHSWJIc3NWQ0FzU25qMWRGQml2SHhHRkxodk50TU9TaTlETlJMTEZYTDIy?=
 =?utf-8?B?Smp5aUxTQXh6S0NmVVRkWWVpT0J6MkZnN1doVThRN0s0aW1ObzF3MlVhcHdS?=
 =?utf-8?B?VldTeVFhS3oxNUtMUVBlb014YTdyQTNpcHUvVXYvUXJqdVNuek51cjZRcVcx?=
 =?utf-8?B?Qm05KzM1M0VTTmozRXlodnZFSWxWdG9mRzk5UG1IZWtwNmRBaFVLbTVsc0hV?=
 =?utf-8?B?d2IvamN4WkhOZ2trNkM0c2IxcHovTTFtMVNiU1QycWZES1pLWFBkeW00b1RM?=
 =?utf-8?B?L291VllDUWhLMVkrVjliQ0VIRVY3SG1JdGFTUWMxSDlYRUVwY1RVUXF2VHNX?=
 =?utf-8?B?N2REdUJoRVlFam1zdjI5alZZMXM1WGk4YTBFVStEQlBlY1VYMTFCYldtNjF3?=
 =?utf-8?B?c29TbktsZDMxUkdCYjRRajgxckhZK25Cb3QvZnlGdmZwQlVRL1h3RVVwMGRC?=
 =?utf-8?B?NmNjbUdrc3BPVmc0TFdHK0hpQ2ltbUJNZHVzK0hFQU1BUkR0U2dIUlIvVmlL?=
 =?utf-8?B?ai9pR0JnUk5aRnU2bnFUU2lOVTBKUzE1ODFHS3o2c1lObDEzRU5sbTJmcDdn?=
 =?utf-8?B?MERsbVFxRW9oOEJUL0lDYk1kekpQSjMzQ1BqV1RuNkhvZDFwWHM1MG5pcmhP?=
 =?utf-8?B?TkJkME1Pd3NDbndjQ1o0NnErc3JGOWFGQ3VLWW8raXJ4cDZ4NEhVbHBNKzZh?=
 =?utf-8?B?QVAvVERuZnhFeEhpcnUxRU1mcWlsWU1adEhHQ2JPN2hyK1BkSm53andPaDh4?=
 =?utf-8?B?TWhxWGlyZ0NSblhmZklidDNOZlpVbEY5Wi9CcHBQZE1zUy9sWmg2a1B2R0Uy?=
 =?utf-8?B?eHowbWpqRERkaGlVVDZCaVB5RFVEZG01VjVyVmM1ajQzQ0RXZXRyMmZtVXFj?=
 =?utf-8?B?VzhKZkhTRm1OZTBPM0ZDbk0rU1BpNnU5TStwZ3hzN1ErMDNIVXRQdEM3WDdT?=
 =?utf-8?B?M0gyUXZzVE55bzBqbmpyQUxGbzRVbjhtNitwd1RKMGhGc2NVNUtFTjlTOUdV?=
 =?utf-8?B?YWJTVnoyY3M0amlEQWU1TE16ZHJtSXl6VElCZS9Rd21rWUROUHlBeVNZcmNL?=
 =?utf-8?B?SlROU1BBNjhlWkxyaEF6aFluOVhmLzVieDB0dk83NDIvaFUwS3I0T3FSdy9L?=
 =?utf-8?B?SHNYcHVMdG82NEdsckJFSDhxUVU0MDc1ckIzVjZXWUMwVmZxOUtUSzB5UU1E?=
 =?utf-8?B?Wk1DV3hsK2lhaGVrcUpOSGxYMWJNMmkraCtKTHk2TWF0a1dpaDQzMU1ZU29X?=
 =?utf-8?B?V0ZFM0xUTVNMWk94cE9jeW9vL1NWNGowZ1Ryb2xhaGpXVUI5T2paZnJqRHg4?=
 =?utf-8?B?VnlGK05SZGkzcm4wMHFWZXNYNDRNdVBwVHRGSU9ndGJqQ2VEZ2RNUWxmb1c3?=
 =?utf-8?B?T2RMRmZMdkNtVHJ1NmgyNllDSnVJaXVTOVU2UHpRSnRieFRBQk8wcDVEa0Ur?=
 =?utf-8?B?a3Q5WXZUTDFjOXV0TXdBc0V1Ni9LSkdqYmU0YmlWeGZJZnFrUXJoaDVybSs5?=
 =?utf-8?B?NlJocDRFRXpvQll1Z3ZqYTlhbytEVXdaSUVCSE1wSHNHSUsxNmFndGhGUklU?=
 =?utf-8?B?M0ViK2REbWlESW1Tb3pwemRhaXFobTkzUHFhVTRoMHNRSS80ajVIbHFuVnpn?=
 =?utf-8?B?M3E4N05xNTV4OHBtVkhaQlI5bFlIUzJKTmxHbjBLenc0SENHN0diN3laaExM?=
 =?utf-8?B?dWUwaGVheCtVdW5ia2xhczNJMklRa3Vzb0pVcFZrUVF0aTBFd0dwNUM5aTBh?=
 =?utf-8?B?cU8vWUZ1d3owY012VUV5dCtaSXZMSXVKQjNlN0pYYmNNU0d1bHdlT1U4K2Rl?=
 =?utf-8?B?aEppUEZZaG01eTZXTDMwRHVONlQ4czFkZFZFZmRzTDFheHplQ01zV2pFSmxL?=
 =?utf-8?B?d3NQelh6aTQ4MThCQ3p6L3MwbnhSMDgwRlVCSVdLN0xOQzhUdDNzVkZQaXR0?=
 =?utf-8?Q?/8fHWfuhNigH1lQU1g?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8629.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e806e0-c327-42c4-0613-08dec3c6783c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2026 12:23:52.0972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QBPlNJM9YztqYzDi+FKXdLf3ARSWw+4hZJsgWKcaZQbh/NPA2nUV93WxqlgBcqLw/Dy1tkjHwpU77z6k4RTPzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10847
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:wei.fang@oss.nxp.com,m:imx@lists.linux.dev,m:Frank.Li@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296105-lists,netdev=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim,DU2PR04MB8629.eurprd04.prod.outlook.com:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39FB764D651

PiA+IEBAIC0xNTA5LDE3ICsxNTUzLDUwIEBAIHN0YXRpYyBpbnQgbmV0Y19wb3J0X21heF9tdHUo
c3RydWN0DQo+IGRzYV9zd2l0Y2ggKmRzLCBpbnQgcG9ydCkNCj4gWyAuLi4gXQ0KPiA+ICtzdGF0
aWMgaW50IG5ldGNfcG9ydF9mZGJfYWRkKHN0cnVjdCBkc2Ffc3dpdGNoICpkcywgaW50IHBvcnQs
DQo+ID4gIAkJCSAgICAgY29uc3QgdW5zaWduZWQgY2hhciAqYWRkciwgdTE2IHZpZCwNCj4gPiAg
CQkJICAgICBzdHJ1Y3QgZHNhX2RiIGRiKQ0KPiA+ICB7DQo+ID4gKwlzdHJ1Y3QgbmV0X2Rldmlj
ZSAqYnJfbmRldiA9IG5ldGNfY2xhc3NpZnlfZGIoZGIpOw0KPiA+ICAJc3RydWN0IG5ldGNfcG9y
dCAqbnAgPSBORVRDX1BPUlQoZHMsIHBvcnQpOw0KPiA+DQo+ID4gLQkvKiBDdXJyZW50bHksIG9u
bHkgc3VwcG9ydCBzdGFuZGFsb25lIHBvcnQgbW9kZSwgc28gb25seQ0KPiA+IC0JICogTkVUQ19T
VEFOREFMT05FX1BWSUQgKD0gMCkgaXMgc3VwcG9ydGVkIGhlcmUuDQo+ID4gLQkgKi8NCj4gPiAt
CWlmICh2aWQgIT0gTkVUQ19TVEFOREFMT05FX1BWSUQpDQo+ID4gLQkJcmV0dXJuIC1FT1BOT1RT
VVBQOw0KPiA+ICsJaWYgKElTX0VSUihicl9uZGV2KSkNCj4gPiArCQlyZXR1cm4gUFRSX0VSUihi
cl9uZGV2KTsNCj4gPiArDQo+ID4gKwlpZiAoIXZpZCkNCj4gPiArCQl2aWQgPSBuZXRjX3ZsYW5f
dW5hd2FyZV9wdmlkKG5wLT5kcCk7DQo+IA0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IERvZXMgdGhp
cyBjYXVzZSBicmlkZ2UgbG9jYWwgRkRCIGVudHJpZXMgZm9yIHRoZSBDUFUgcG9ydCB0byBiZSBw
cm9ncmFtbWVkDQo+IHdpdGggdGhlIHdyb25nIFZJRD8NCj4gDQo+IFdoZW4gdGhlIERTQSBjb3Jl
IG9mZmxvYWRzIGEgYnJpZGdlJ3MgbG9jYWwgTUFDIGFkZHJlc3MsIGl0IGNhbGxzDQo+IG5ldGNf
cG9ydF9mZGJfYWRkKCkgb24gdGhlIENQVSBwb3J0IHdpdGggZGIudHlwZSA9PSBEU0FfREJfQlJJ
REdFLiBTaW5jZQ0KPiB0aGUgQ1BVIHBvcnQgaXMgbmV2ZXIgYSBkaXJlY3QgbWVtYmVyIG9mIGFu
eSBicmlkZ2UsIHJlc29sdmluZyB0aGUgdGFyZ2V0DQo+IFZJRCBieSBpbnNwZWN0aW5nIHRoZSBw
b3J0J3MgYnJpZGdlIG1lbWJlcnNoaXAgd2l0aA0KPiBuZXRjX3ZsYW5fdW5hd2FyZV9wdmlkKG5w
LT5kcCkgd2lsbCByZXR1cm4gTkVUQ19TVEFOREFMT05FX1BWSUQgKDApLg0KPiANCj4gVGhpcyB3
b3VsZCBjYXVzZSB0aGUgQ1BVIHBvcnQgRkRCIGVudHJ5IHRvIGJlIHByb2dyYW1tZWQgaW4gVklE
IDAgaW5zdGVhZA0KPiBvZiB0aGUgYnJpZGdlJ3MgaW50ZXJuYWwgUFZJRCwgbGVhZGluZyB0byBV
bmtub3duIFVuaWNhc3QgZmxvb2RpbmcgYWNyb3NzDQo+IHVzZXIgcG9ydHMgZm9yIGluY29taW5n
IHRyYWZmaWMgZGlyZWN0ZWQgdG8gdGhlIGJyaWRnZSBJUC4NCj4NCg0KVGhpcyBpcyBhIGJ1Zywg
SSBpZ25vcmVkIHRoZSBDUFUgcG9ydC4gSSB3aWxsIGZpeCBpdC4NCg0KLS0NCnB3LWJvdDogY3IN
Cg0K

