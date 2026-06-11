Return-Path: <netdev+bounces-298336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sP85L78bK2oo2wMAu9opvQ
	(envelope-from <netdev+bounces-298336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:34:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA9E6752F1
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:34:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nokia-bell-labs.com header.s=selector1 header.b=NlhALhC4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298336-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298336-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nokia-bell-labs.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E99F32B3F7E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E18749253F;
	Thu, 11 Jun 2026 20:34:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ED549250B;
	Thu, 11 Jun 2026 20:33:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210041; cv=fail; b=WZbKCsvqD8zcPpBO1G5WbNY2LwSctHo2mXu/BCO4xDkeLkOMdou2dDwXeoaudIoSc2PsC0cF46PulL7AyIr+W1kah35I4xlz5Pg6JuS5jHEzJpcxA/AdnO8Hex292jdPKB9tMOnJ+jrGZOUnAgadaxuSFe7EKGXIAHjzF78hFuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210041; c=relaxed/simple;
	bh=Xij1smrpBnicgJdRPDElogXkIEV2XkryuGFArjGY+ro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kDnUeUR9C8/6WJA/X3aYTb6w1Gx8c02fQEceuOhph5i9kn2mJtJIUSfpS+UwIGURk0AbKCs3/Qcjav/lsu6GYdKoAlUea73BqqesSCzDg8q69jWOEqXOldHX3HVZ+bkf97QYPNK3Vi5OaIh/0elzZ4krBs9BkyG3brKCMv7rajs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=NlhALhC4; arc=fail smtp.client-ip=52.101.65.46
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bX68ggWaYbZ14pJofQR2tsdXnccHdwgRTD+VIYplt4CCsnGtj1OQvIASf4GlTcFKKX8J8roEcPBNTozm5Uj1ywpk8FeeEnk3O+435I0dmartYIsvhRWtLgVFxTGsy3UxJbZpO8E3CppHkhX0wNeEO9NQmMg61ip7W7CdR7pvWdn0ABmE8odw9TOgk4vBlLHzZiVEG4dtf5nQT0alNwqeUq6PdFrTWL3fIZEW5Y4swrUoz3lLc/TKX3nArZMMUxqaVwMLEtG31wPa8XN5PNssmQ5V7zW84MNaAqyWyrk6jnVHfypoUpyFx5/GW7pOW3VkBTw8ioGR7b/f2Y6meSEgQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xij1smrpBnicgJdRPDElogXkIEV2XkryuGFArjGY+ro=;
 b=zLXB+ATYi+0mZ4o5UW9V58yee/VkXTNjeLgUj54v6Ucm5SPJy2n909Fv9OfWjMqjwXc/lgpVOVGBeGVdTGeKzGO7t/paGn46qMTF4d/W4CgH10mJWiHB/WjjaokZj58wOyFZzEERRc40EJDciL6x1QM1jvwkMpSlTYSEiubniy1SCWRF4RKa6g/xIPI0/dC/YoSQwmX+Lm+6E3gWrDfhht8Q/0fvdXOW0IMvfa5yNvTW7ef+V+atK82WQk1pC+q3t41fyViimHnVKvahzqYnORD3nUBjlC3O1cjFW3J3YB9+AjpSe/eSDTts3QVdCPnVC7xk9JAXr8X2x+BgGUI7xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xij1smrpBnicgJdRPDElogXkIEV2XkryuGFArjGY+ro=;
 b=NlhALhC4bkT5giOyvCBST/+5S37m6BxYlwQN7GCAEI3oMuBnS5PW+MjWuR6xKCdL8ps0x0o3iW0Krrp2rSdIaKoBN7trr57UH6pMPZBUD5kHQ3QGrJpuD/htE8PSfzC9cWK0Wyqcg9Zqh0064MeYGe951TLgcp2LBeyAeCWma4Q11VOxJ6emE74Z/kQZYst+eg5yY9iINhTrfOJJZt8C5oeuXvMygHZYam3fV55nPrEZHPy/Ey78MVjwSHjPa+E6bzz/N2jSKEmTceREsc/iLTz0tJELnJb8eDVnFeAAes1NRb3KCEcCmvAzQaeFQFh0/gNKtVbAudjUPiXHHawn0w==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DB9PR07MB8982.eurprd07.prod.outlook.com (2603:10a6:10:3de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 20:33:48 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5%4]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 20:33:48 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Eric Dumazet <edumazet@google.com>
CC: Neal Cardwell <ncardwell@google.com>, "horms@kernel.org"
	<horms@kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"kuniyu@google.com" <kuniyu@google.com>, "ij@kernel.org" <ij@kernel.org>,
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
	"g.white@cablelabs.com" <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
	"vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v1 net-next 3/4] tcp: Add tso_segs() CC callback for TCP
 Prague
Thread-Topic: [PATCH v1 net-next 3/4] tcp: Add tso_segs() CC callback for TCP
 Prague
Thread-Index: AQHc+b18uTDopa6mw0SMYyfW7UPxZ7Y5lEOAgAAowYCAAAB5QIAAAsCAgAADi+A=
Date: Thu, 11 Jun 2026 20:33:48 +0000
Message-ID:
 <PAXPR07MB79847E7E64F4ECFA0FC3A612A31B2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260611161504.228319-1-chia-yu.chang@nokia-bell-labs.com>
 <20260611161504.228319-4-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iKkPJqOM=0KV8O8=2zWrZObj+E+VJoLztp4sUi7Vj0aQg@mail.gmail.com>
 <CADVnQyk+sOAKU_WtPja7_hgiXw8he9U1g6AY7iEm5q3F3R-Hag@mail.gmail.com>
 <PAXPR07MB7984D14DA66C0E4B89BA1D4BA31B2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <CANn89i+dS_h8_FH9KdO4NPu46VSi3uFZ3yGnA6AKD1UzMzySKg@mail.gmail.com>
In-Reply-To:
 <CANn89i+dS_h8_FH9KdO4NPu46VSi3uFZ3yGnA6AKD1UzMzySKg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DB9PR07MB8982:EE_
x-ms-office365-filtering-correlation-id: 43e9f6a3-f5a1-4635-c790-08dec7f8be15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|4133799003|3023799007|4143699003|56012099006|11063799006|38070700021|13003099007|18002099003|22082099003;
x-microsoft-antispam-message-info:
 dvT1DaU97dHTyMy1BNZ8UXS9zZYJ1vaCilQqpH4Q+/uTDbqBV7arfu5BWaSsls/34CT3b78sWppGWZY2Ql9nQJFD/QoO8fYTD32dmKUswXCMUm43zFjHZH8IDEP+8oZ5uwtrpE91Kq55+ClSBe1Q7lJ82iJXyvzjQtBCeOEACpq6186lRKX41JSqfCKUBgW+0NgZ5HMCBqI6AcaZ/iNfLJZi6hI9JbtSTVr01WKEQqyXLZI97xbQEfHyiut+j4jngnxsMsx3t8FKj0jKpLTdcjuz7RjFg0JjjjYrnORa/kuZ/7IshkuIOWfZVCuXRqhV8v6S71AZAOhqyZoFpSG4v6GFifdLYfAGsomFS6qIpDv9+tK6EyVQFZ41FO8XzHxQcditVaF7NXOWOWLKibyMDqkjZD1yl9kbQ2NRymlSveRSCl9gizFY3LjOOqNzXBL5GfS/K39mFSGsQ2ZECnDT1Q8BJd7vH923RNEjX3HTuuQLjV5Sis6Ken0Td7wYW6/VN7s2kAcscfqiqkM60KOAv4ZaETs3fVHt3pZSFPG/9tvbUs+zf1arw6DofQVf3xqfZYvXHlEF0ppzlSj+MF7Mnl9edsjc0ToQd/E/ff00jaqnL+9serlOi3uuhRKOUMoOUj6a7gzvSapXiqbexTy7bcDLIEcvnUz5o5r+ro2nWd2tscjXIPPYZO8w8BVOXMKC9ETLUXGf63U2R/X7y+xteVeRGVu61J8vXmIqNYyYSRHwF3ixrMDCzxwe4WSlholf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(4133799003)(3023799007)(4143699003)(56012099006)(11063799006)(38070700021)(13003099007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WU0ydXRvZzNxeVdlM2t5TUk2M2l0VWZhSXg5ODVUZWIzMVJoM1AzVjI3OHpv?=
 =?utf-8?B?QVVHUDA5a1RWdlVSTkNla01obkE3OUc3TEtXK0h1WEJBcjQrNFJKQ3JYcEtX?=
 =?utf-8?B?NkEwUWNaSDhxY0xpaTF2MEF5WjN4WStxY3lMTndsTGRXUXAwUnBGK29TSGpv?=
 =?utf-8?B?V3oxUzNuY1ErSng1amR3UXVTYWcrNTU5aExjc0p1TzZtTzZQQnZhVmRYRmtN?=
 =?utf-8?B?Q0s4T1djNHUzRHpnb0pNSE5nRzF4VG1xeEdOWWh6V0hjY25IT2RVRWlZUGQr?=
 =?utf-8?B?cHB1SDNIMDZpeEV4ZG5qUVpER1Nodm51a1J5eGUzSlZQUlVnUFdpT0MwVE44?=
 =?utf-8?B?eGxLMjRpWmpVd2E5ZUFmZzdjVkJsRUxVSjIrU0JkNGVKVkI3T2hPaGd4SzI2?=
 =?utf-8?B?dnNEc3BlUGQ4TEFuTE5rbFdRWmw0VzN2QjlpRU9JaDJheC8rL1VqM2JoT1B4?=
 =?utf-8?B?VFFaT1puREYybjFIK0lwakpGU0ZBKzMrK2VJTXg4YWc5MEZiNGVsM1liREZk?=
 =?utf-8?B?UGFpSy9ZaWxHdk4wSXBOVVExekgxZjdHQWYycUZocmtKSUNGaFIrZFA5RXhR?=
 =?utf-8?B?RnFTdzAwcExnaDNMcWlsZkJzbTlkVGg0RDFza3RjeXJvNnZIc1RDc2U3c0h3?=
 =?utf-8?B?dmllR3lHTit3V0xFaW0xTWsvQTdnSGhkanpsQmc2RWJDSEx0dmFicmNWdTRF?=
 =?utf-8?B?M2FRNGlORE9hQnhRWjRNb0FPRXRLaUtYdkRERTZwcVJoa2hXNGRVL3Y4QzVH?=
 =?utf-8?B?TUVzZHQ4MEd3a1FPVUpqM1owTHV6b2k1Qm1ZR2xSRjdIN0JFQTNJZG5WdC9j?=
 =?utf-8?B?MUE3Y3I0Z0ZTMVRsakc1a0sxalZMbGxGTHFnQ0xPYXhEUk8wZnBTeGNZYmpN?=
 =?utf-8?B?TWswOWRiSWRRaWZKdHhjK1Zham9oY1N0aGkyYWk3VHhuMnY3dlNTbndOVVJK?=
 =?utf-8?B?UFNFMk9JaTFoTEdGN1dLMktKQzJEcWg5VFgzRkE5RVF5OWY5UnJHY09TanhY?=
 =?utf-8?B?ay81SW5NRU8xSklTMVo5Z1d3UzRxNkRlSnpOK2FCRGNCWlh1OFdQWHBoR2Nw?=
 =?utf-8?B?SHdvS3RjY0JVMHJ1MjFvN3Jxa3NncjQwcXhDOGY0cG96SSswVDZ4d1g0TkR4?=
 =?utf-8?B?b2RaTGFLS1lIVldUS1RRc3hHQ3kxMW04V2dsbC8rTVNndE9ZWkpnU3ZDcE44?=
 =?utf-8?B?N1huZWtlYzZYZ1dIaTdQZ0pJb0pKUGdiVXRzbE1Mb2xiMzNSQk9aUkJoaXRy?=
 =?utf-8?B?RklobExrdlpKOFp0K05JOXVobTBoVEF3VFhwWndEbERUcmhGaWQvdm00TzFB?=
 =?utf-8?B?OXIvdGJkSUZ0TE5VY05VYXNYWnQ4WDlFUUY0NjFZdjNPNHg1dGUya0lPNXlo?=
 =?utf-8?B?bWMwbmlrRnhLTjRFekhVcjRhM2x4dFZ0TWI2RGkwYTdvRWxsRWFLaHFXeFhU?=
 =?utf-8?B?SVkyUXA3VitBOUNrY0ltakJja0RQdU9yS1JIL2d6Vk90amhyZENXYng2TFpI?=
 =?utf-8?B?b0F2bVRMR0hoNGErWjNBRWRkUkxqd0RINURVa204STRwbXViYTM2MmcrelZa?=
 =?utf-8?B?Mkw5d3BvMzlkcUdRSUttZkdvd29kanpuSVcvQ082QnNhWmh0eXRRS2t5Ujlu?=
 =?utf-8?B?Zi9BejJWMWRWU01obXhlaHhZbE1uOHArQVBtdEdtcS85anVua2MxZ2ovdjBv?=
 =?utf-8?B?cnk0dG90NVRodDFmY09pR3cyc0I1TTJRZTVJR2x6NUQwNzJPSUZCR1BpOUtG?=
 =?utf-8?B?cVZ4UWFWMEFQSVl1aHBRbStaVkRDYitXSTQ4M0lsODJFRDdjNzhFTVpwNnlM?=
 =?utf-8?B?RzJUREd6N0VLcWxUbXV0QktGbktFYUNqT2NLZFpjc0xoeUxleExjOWhETzdN?=
 =?utf-8?B?cTJadHV3bVFobGpiV29UbTVoblJqU1BtenhVOWxGck1WRFNXWDJWVU44TjND?=
 =?utf-8?B?WE9BaVdud2pQSEZQRUd6ZmMrODZ5ZEdYVDJ1R1dBZUNQVHlHb1J0ZzhsWjhJ?=
 =?utf-8?B?aWViOHNndGFTNDVLcityNWlaenFIeEtqVzJZZ2xxb210YUNlSmJVSTFnbHRN?=
 =?utf-8?B?bUJhYWtyRFdrdUtkOHhPMUFiUFVHQ0RuTG5UN1dPeEYvL29OMEUrN1JHVTlX?=
 =?utf-8?B?QW9iYXVWZnZwOXM5REtua3JZZWpCTnJBdXN2dDkwYVFaTm0vS2wrUVI3cUNH?=
 =?utf-8?B?ZW9xRUNmYVM2dWREU0RrWjdkaVI4QlEzQkRTcWlUVEM3eGgzejBERmptdXNz?=
 =?utf-8?B?VUxFK0lPQU5aaTZ2VXhYeXc0dU9EZzlpaWtsdlUrbU53T2x4TGNDRHlqVTNL?=
 =?utf-8?B?K2dXUGREdkVVeWxha3RLNkxDQ1ZmNVFVek9XVmNVa2d1RmswWXhzWFo4WUNW?=
 =?utf-8?Q?eYxzwXJbjk/wb1+I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e9f6a3-f5a1-4635-c790-08dec7f8be15
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 20:33:48.8009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HJJDndOIzDOMkSg5vBtgv9wJJ25MoEc5jKAt8CRFaMu4l/Au8qnCjnShP2dAwp/kihKoRZp/QY2cAqwAoJiiY25sBb79bqCquIzDzS7F8A2d85VLb3y2lFHUS9sl/LK9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8982
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298336-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:ncardwell@google.com,m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:kuba@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:koen.de_schepper@nokia-bell-labs.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,lunn.ch,gmail.com,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DA9E6752F1

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+IA0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAxMSwgMjAyNiA5OjM4IFBN
DQo+IFRvOiBDaGlhLVl1IENoYW5nIChOb2tpYSkgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1s
YWJzLmNvbT4NCj4gQ2M6IE5lYWwgQ2FyZHdlbGwgPG5jYXJkd2VsbEBnb29nbGUuY29tPjsgaG9y
bXNAa2VybmVsLm9yZzsgZHNhaGVybkBrZXJuZWwub3JnOyBicGZAdmdlci5rZXJuZWwub3JnOyBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgamhzQG1vamF0YXR1LmNv
bTsga3ViYUBrZXJuZWwub3JnOyBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsgZGF2ZW1AZGF2
ZW1sb2Z0Lm5ldDsgYW5kcmV3K25ldGRldkBsdW5uLmNoOyBkb25hbGQuaHVudGVyQGdtYWlsLmNv
bTsga3VuaXl1QGdvb2dsZS5jb207IGlqQGtlcm5lbC5vcmc7IEtvZW4gRGUgU2NoZXBwZXIgKE5v
a2lhKSA8a29lbi5kZV9zY2hlcHBlckBub2tpYS1iZWxsLWxhYnMuY29tPjsgZy53aGl0ZUBjYWJs
ZWxhYnMuY29tOyBpbmdlbWFyLnMuam9oYW5zc29uQGVyaWNzc29uLmNvbTsgbWlyamEua3VlaGxl
d2luZEBlcmljc3Nvbi5jb207IGNoZXNoaXJlQGFwcGxlLmNvbTsgcnMuaWV0ZkBnbXguYXQ7IEph
c29uX0xpdmluZ29vZEBjb21jYXN0LmNvbTsgdmlkaGlfZ29lbEBhcHBsZS5jb20NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MSBuZXQtbmV4dCAzLzRdIHRjcDogQWRkIHRzb19zZWdzKCkgQ0MgY2Fs
bGJhY2sgZm9yIFRDUCBQcmFndWUNCj4gDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGlzIGFuIGV4dGVy
bmFsIGVtYWlsLiBQbGVhc2UgYmUgdmVyeSBjYXJlZnVsIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3Ig
b3BlbmluZyBhdHRhY2htZW50cy4gU2VlIHRoZSBVUkwgbm9rLml0L2V4dCBmb3IgYWRkaXRpb25h
bCBpbmZvcm1hdGlvbi4NCj4gDQo+IA0KPiANCj4gT24gVGh1LCBKdW4gMTEsIDIwMjYgYXQgMTI6
MzPigK9QTSBDaGlhLVl1IENoYW5nIChOb2tpYSkgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1s
YWJzLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gPiBGcm9tOiBOZWFsIENhcmR3ZWxsIDxuY2FyZHdlbGxAZ29vZ2xlLmNvbT4NCj4gPiA+IFNl
bnQ6IFRodXJzZGF5LCBKdW5lIDExLCAyMDI2IDk6MjcgUE0NCj4gPiA+IFRvOiBFcmljIER1bWF6
ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+DQo+ID4gPiBDYzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEp
IDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+OyANCj4gPiA+IGhvcm1zQGtlcm5l
bC5vcmc7IGRzYWhlcm5Aa2VybmVsLm9yZzsgYnBmQHZnZXIua2VybmVsLm9yZzsgDQo+ID4gPiBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgamhzQG1vamF0YXR1LmNv
bTsgDQo+ID4gPiBrdWJhQGtlcm5lbC5vcmc7IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnOyBk
YXZlbUBkYXZlbWxvZnQubmV0OyANCj4gPiA+IGFuZHJldytuZXRkZXZAbHVubi5jaDsgZG9uYWxk
Lmh1bnRlckBnbWFpbC5jb207IGt1bml5dUBnb29nbGUuY29tOyANCj4gPiA+IGlqQGtlcm5lbC5v
cmc7IEtvZW4gRGUgU2NoZXBwZXIgKE5va2lhKSANCj4gPiA+IDxrb2VuLmRlX3NjaGVwcGVyQG5v
a2lhLWJlbGwtbGFicy5jb20+OyBnLndoaXRlQGNhYmxlbGFicy5jb207IA0KPiA+ID4gaW5nZW1h
ci5zLmpvaGFuc3NvbkBlcmljc3Nvbi5jb207IG1pcmphLmt1ZWhsZXdpbmRAZXJpY3Nzb24uY29t
OyANCj4gPiA+IGNoZXNoaXJlQGFwcGxlLmNvbTsgcnMuaWV0ZkBnbXguYXQ7IEphc29uX0xpdmlu
Z29vZEBjb21jYXN0LmNvbTsgDQo+ID4gPiB2aWRoaV9nb2VsQGFwcGxlLmNvbQ0KPiA+ID4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MSBuZXQtbmV4dCAzLzRdIHRjcDogQWRkIHRzb19zZWdzKCkgQ0Mg
Y2FsbGJhY2sgDQo+ID4gPiBmb3IgVENQIFByYWd1ZQ0KPiA+ID4NCj4gPiA+DQo+ID4gPiBDQVVU
SU9OOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgYmUgdmVyeSBjYXJlZnVsIHdo
ZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gU2VlIHRoZSBVUkwgbm9r
Lml0L2V4dCBmb3IgYWRkaXRpb25hbCBpbmZvcm1hdGlvbi4NCj4gPiA+DQo+ID4gPg0KPiA+ID4N
Cj4gPiA+IE9uIFRodSwgSnVuIDExLCAyMDI2IGF0IDE6MDHigK9QTSBFcmljIER1bWF6ZXQgPGVk
dW1hemV0QGdvb2dsZS5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBPbiBUaHUsIEp1biAx
MSwgMjAyNiBhdCA5OjE14oCvQU0gPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT4g
d3JvdGU6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBGcm9tOiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1
LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIHBh
dGNoIGFkZHMgdHNvX3NlZ3MoKSBDQyBjYWxsYmFrIGZvciBDQyBhbGdvcml0aG0gdG8gDQo+ID4g
PiA+ID4gcHJvdmlkZXMgZXhwbGljaXQgdHNvIHNlZ21lbnQgbnVtYmVyIG9mIGVhY2ggZGF0YSBi
dXJzdCBhbmQgDQo+ID4gPiA+ID4gb3ZlcnJpZGVzIHRjcF90c29fYXV0b3NpemUoKS4NCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlLg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogSWxwbyBKw6RydmluZW4gPGlqQGtlcm5lbC5vcmc+DQo+ID4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogQ2hpYS1ZdSBDaGFuZyA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxs
LWxhYnMuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBpbmNsdWRlL25ldC90Y3AuaCAg
ICAgfCAzICsrKw0KPiA+ID4gPiA+ICBuZXQvaXB2NC90Y3Bfb3V0cHV0LmMgfCA0ICsrKy0NCj4g
PiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC90Y3AuaCBiL2lu
Y2x1ZGUvbmV0L3RjcC5oIGluZGV4DQo+ID4gPiA+ID4gZTgwOTBmNTQyZjdjLi4zYjQxNWM5ZGNj
NTQgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvaW5jbHVkZS9uZXQvdGNwLmgNCj4gPiA+ID4gPiAr
KysgYi9pbmNsdWRlL25ldC90Y3AuaA0KPiA+ID4gPiA+IEBAIC0xMzY2LDYgKzEzNjYsOSBAQCBz
dHJ1Y3QgdGNwX2Nvbmdlc3Rpb25fb3BzIHsNCj4gPiA+ID4gPiAgICAgICAgIC8qIG92ZXJyaWRl
IHN5c2N0bF90Y3BfbWluX3Rzb19zZWdzIChvcHRpb25hbCkgKi8NCj4gPiA+ID4gPiAgICAgICAg
IHUzMiAoKm1pbl90c29fc2Vncykoc3RydWN0IHNvY2sgKnNrKTsNCj4gPiA+ID4gPg0KPiA+ID4g
PiA+ICsgICAgICAgLyogb3ZlcnJpZGUgdGNwX3Rzb19hdXRvc2l6ZSAqLw0KPiA+ID4gPiA+ICsg
ICAgICAgdTMyICgqdHNvX3NlZ3MpKHN0cnVjdCBzb2NrICpzaywgdTMyIG1zc19ub3cpOw0KPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiAgICAgICAgIC8qIG5ldyB2YWx1ZSBvZiBjd25kIGFmdGVyIGxv
c3MgKHJlcXVpcmVkKSAqLw0KPiA+ID4gPiA+ICAgICAgICAgdTMyICAoKnVuZG9fY3duZCkoc3Ry
dWN0IHNvY2sgKnNrKTsNCj4gPiA+ID4gPiAgICAgICAgIC8qIHJldHVybnMgdGhlIG11bHRpcGxp
ZXIgdXNlZCBpbiB0Y3Bfc25kYnVmX2V4cGFuZA0KPiA+ID4gPiA+IChvcHRpb25hbCkgKi8gZGlm
ZiAtLWdpdCBhL25ldC9pcHY0L3RjcF9vdXRwdXQuYyANCj4gPiA+ID4gPiBiL25ldC9pcHY0L3Rj
cF9vdXRwdXQuYyBpbmRleCBmZTcyNWQ5NGEyMjUuLmE3MjA2ZmE2MTk1NyAxMDA2NDQNCj4gPiA+
ID4gPiAtLS0gYS9uZXQvaXB2NC90Y3Bfb3V0cHV0LmMNCj4gPiA+ID4gPiArKysgYi9uZXQvaXB2
NC90Y3Bfb3V0cHV0LmMNCj4gPiA+ID4gPiBAQCAtMjI3NCw3ICsyMjc0LDkgQEAgc3RhdGljIHUz
MiB0Y3BfdHNvX3NlZ3Moc3RydWN0IHNvY2sgKnNrLCB1bnNpZ25lZCBpbnQgbXNzX25vdykNCj4g
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBjYV9vcHMtPm1pbl90c29fc2Vncyhzaykg
Og0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gUkVBRF9PTkNFKHNvY2tfbmV0KHNrKS0+aXB2NC5zeXNj
dGxfdGNwX21pbl90c29fc2Vncyk7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAtICAgICAgIHRzb19z
ZWdzID0gdGNwX3Rzb19hdXRvc2l6ZShzaywgbXNzX25vdywgbWluX3Rzbyk7DQo+ID4gPiA+ID4g
KyAgICAgICB0c29fc2VncyA9IGNhX29wcy0+dHNvX3NlZ3MgPw0KPiA+ID4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGNhX29wcy0+dHNvX3NlZ3Moc2ssIG1zc19ub3cpIDoNCj4gPiA+ID4g
PiArICAgICAgICAgICAgICAgICAgICAgICB0Y3BfdHNvX2F1dG9zaXplKHNrLCBtc3Nfbm93LCBt
aW5fdHNvKTsNCj4gPiA+ID4gPiAgICAgICAgIHJldHVybiBtaW5fdCh1MzIsIHRzb19zZWdzLCBz
ay0+c2tfZ3NvX21heF9zZWdzKTsgIH0NCj4gPiA+ID4NCj4gPiA+ID4gQ2FuIHlvdSBleHBsYWlu
IHdoeSBtaW5fdHNvX3NlZ3MoKSBpcyBub3QgZW5vdWdoPw0KPiA+ID4gPg0KPiA+ID4gPiBXZSBk
byBub3QgbmVlZCB0d28gZGlmZmVyZW50IG1lY2hhbmlzbXMuDQo+ID4gPg0KPiA+ID4gSSdtIHBy
ZXR0eSBzdXJlIHRoaXMgd2FzIHByb3Bvc2VkIHRvIG1lZXQgUHJhZ3VlJ3MgZ29hbCBvZiBoYXZp
bmcgVFNPIGJ1cnN0cyBiZSBzaXplZCB0byBiZSBhdCBtb3N0IDI1MCB1c2VjIHdvcnRoIHBhY2tl
dHMsIHJhdGhlciB0aGFuIHRoZSBkZWZhdWx0IExpbnV4IFRDUCBUU08gYXV0b3NpemluZyBhcHBy
b2FjaCBvZiAxbXMgd29ydGggb2YgcGFja2V0czoNCj4gPiA+DQo+ID4gPiBodHRwczovL2RhdGF0
cmFja2VyLmlldGYub3JnL2RvYy9odG1sL2RyYWZ0LWJyaXNjb2UtaWNjcmctcHJhZ3VlLWNvbg0K
PiA+ID4gZ2VzdGlvbi1jb250cm9sLTA0I25hbWUtc2VnbWVudGF0aW9uLW9mZmxvYWQNCj4gPiA+
DQo+ID4gPiBXaGVyZSAiTUFYX0JVUlNUX0RFTEFZIiBpcyBkZWZpbmVkIGFzICJNYXhpbXVtIGFs
bG93ZWQgYm90dGxlbmVjayBxdWV1aW5nIGRlbGF5IGR1ZSB0byBzZWdtZW50YXRpb24gb2ZmbG9h
ZCBidXJzdHMgW3NdIChkZWZhdWx0IDAuMjUgbXMgZm9yIHRoZSBwdWJsaWMgSW50ZXJuZXQpIi4N
Cj4gPiA+DQo+ID4gPiBBRkFJQ1QgdGhpcyBwcm9wb3NlZCBwYXRjaCBpcyBubyBsb25nZXIgbmVl
ZGVkIG5vdyB0aGF0DQo+ID4gPiB0Y3BfdHNvX2F1dG9zaXplKCkgdXNlcyBhIHBhcmFtZXRlcml6
ZWQgYXBwcm9hY2ggZm9yIDoNCj4gPiA+DQo+ID4gPiAgICBieXRlcyA9IFJFQURfT05DRShzay0+
c2tfcGFjaW5nX3JhdGUpID4+IA0KPiA+ID4gUkVBRF9PTkNFKHNrLT5za19wYWNpbmdfc2hpZnQp
Ow0KPiA+ID4NCj4gPiA+IEFGQUlDVCB0Y3BfcHJhZ3VlIGNhbiBzaW1wbHkgc2V0IHNrLT5za19w
YWNpbmdfc2hpZnQgdG8gYmUgMTIgZm9yIGl0cyBwdXJwb3NlcywgbG9va2luZyBhdDoNCj4gPiA+
DQo+ID4gPiAgICANCj4gPiA+IGh0dHBzOi8vZXVyMDMuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpDQo+ID4gPiB0aHViLmNvbSUyRkw0U1RlYW0l
MkZsaW51eCUyRmJsb2IlMkY4YWMwMWI5N2ZmZDk5M2IxZmVkOTNhMDE1ZWMzMGRkMA0KPiA+ID4g
ODU4NTdlOGIlMkZuZXQlMkZpcHY0JTJGdGNwX3ByYWd1ZS5jJTIzTDE0NCZkYXRhPTA1JTdDMDIl
N0NjaGlhLXl1LmMNCj4gPiA+IGhhbmclNDBub2tpYS1iZWxsLWxhYnMuY29tJTdDYmEwOWY1Y2Y3
MDBiNGY0NTg5ZTMwOGRlYzdmMTA3MzglN0M1ZDQ3DQo+ID4gPiAxNzUxOTY3NTQyOGQ5MTdiNzBm
NDRmOTYzMGIwJTdDMCU3QzAlN0M2MzkxNjgwMzUxODIyNjY4NjQlN0NVbmtub3duJQ0KPiA+ID4g
N0NUV0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQXVNREF3TUNJ
c0lsQWlPaUpYYVcNCj4gPiA+IDR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJbGRVSWpveWZRJTNEJTNE
JTdDMCU3QyU3QyU3QyZzZGF0YT0lMkJHakRIeHJ3DQo+ID4gPiBoYUtqME8wb3R0dXhyWlUwV0dO
bEZ2JTJGZG1wbUc4QjRGVE9VJTNEJnJlc2VydmVkPTANCj4gPiA+DQo+ID4gPiAgICBzdGF0aWMg
dTMyIHByYWd1ZV9idXJzdF9zaGlmdCBfX3JlYWRfbW9zdGx5ID0gMTI7IC8qIDEvMl4xMiBzZWMg
DQo+ID4gPiB+PS4yNW1zICovDQo+ID4gPg0KPiA+ID4gVGhlbiBwcm9iYWJseSB0aGlzIHBhdGNo
IGlzIG5vdCBuZWVkZWQuDQo+ID4gPg0KPiA+ID4gbmVhbA0KPiA+DQo+ID4gSGkgTmVhbCBhbmQg
RXJpYywNCj4gPg0KPiA+IElNTywgd2Ugc3RpbGwgbmVlZCBQcmFndWUgdG8gbWFpbnRhaW4gaXRz
IHBhY2luZyByYXRlLCBiZWNhdXNlIEFGQUlLIHRjcF90c29fYXV0b3NpemUgYWxzbyBiYXNlZCBv
biBtaW5fcnR0IHRvIGRlY2lkZSB0aGUgYnl0ZXMgdG8gZmlsbCBpbi4NCj4gPiBBbmQgaXQgdGVu
ZHMgdG8gY3JlYXRlIGxhcmdlIHBhY2tldHMgd2hlbiBtaW5fUlRUIGlzIHZlcnkgc21hbGwgdmlh
IA0KPiA+IGBieXRlcyArPSBzay0+c2tfZ3NvX21heF9zaXplID4+IG1pbl9ydHQ7YA0KPiA+DQo+
ID4gV2hpbGUsIGluIFRDUCBQcmFndWUsIHdlIGRvIG5vdCBic2FlZCBvbiBtaW5fcnR0IHRvIGZ1
cnRoZXIgZW5sYXJnZSBUU08gc2l6ZS4NCj4gDQo+IFlvdSB3aWxsIGhhdmUgdG8gcmVtb3ZlIG1p
bl90c29fc2VncygpIGFuZCByZXBsYWNlIGl0IHdpdGggdHNvX3NlZ3MoKSB3aGljaCBzZWVtcyBl
bm91Z2ggKHN0cm9uZ2VyKQ0KDQpIaSBFcmljLA0KDQpTdXJlLCBpbiB0aGlzIGNhc2UgSSB3aWxs
IG5lZWQgdG8gcmVtb3ZlIGV4aXNpdG5nIC5taW5fdHNvX3NlZ3MgaG9va3MgYW5kIHJlcGxhY2Ug
dGhlbSB3aXRoIG5ldyAudHNvX3NlZ3MgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzLg0K
Q2hpYS1ZdQ0K

