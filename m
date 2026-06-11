Return-Path: <netdev+bounces-298323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N31+Kv0NK2rA1wMAu9opvQ
	(envelope-from <netdev+bounces-298323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:35:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 289FA674C74
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 21:35:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nokia-bell-labs.com header.s=selector1 header.b=nXRy6qpM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298323-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298323-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nokia-bell-labs.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F0C63073414
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F88329C7B;
	Thu, 11 Jun 2026 19:33:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117FF2DC79F;
	Thu, 11 Jun 2026 19:33:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206390; cv=fail; b=JwLCX0o/peCyBc6y6UdivFYADVjWLx4Um5iQKk7cznK+q5stNhzxLTXX7jog8hcg2PfvIUjPehWUajpWL4hncDPFcuYgiQQyv9SvJVjzYUcifRF9O/U+ObtlAZzpcHyk0mhaoqjEN+fEXxsqZmbJduVS+pOWf4fnmdw/5unqczc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206390; c=relaxed/simple;
	bh=lrZabOIII74md+4LB6rfVk3S/UTcFgqBiXU7wj2I++I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ueU/4NkT9TJqFFcfUusgjItH4BQBGWfTRk9fuRz/AYOCOGD/DOlf7CmOCbBu6/BQauXW+tbfRy0uD1CNJDhiKICe3nM69QMK5xcJ1oJFGlhcVUrLSEA3VtxPDCch8pnxCuXa4lBMOpUN3JnV+ntSYiN5MegGlfbG0FkpvymcdjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=nXRy6qpM; arc=fail smtp.client-ip=52.101.69.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZ3zs0fX41tL5Hs/Kma99GGtaOaqvDU1aNNn6i0pknYaPyOqAd8PV+lpmfWGDgdKK69rYl1FfKIyusa/NIqWOHmmVC0euQ61XNjZJm0k27RBhhD8yk8IfkQaXwnwBW9kmL98g0g6cEUvcumSpvDdfHmw6LNfzxaVKpcV8S7KrTg9+ekAla1B/S740CTaTLHRdvlxOCmO0EX7V9pbH+0KtsfXHoa0gFCAcGiBHbqQ311VJxm29V127qsIjQgl7UPuOYe0rshKmvJuQFnzMw5iNnPwaHXEt26JbgJTIg4LKrE0rcFaQWrUJvtRPmNI6UwMXxP19lRVlmK33hj3PyKz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrZabOIII74md+4LB6rfVk3S/UTcFgqBiXU7wj2I++I=;
 b=kBLoL+5/iHYi+CaerJZF9T2UMRHcBUONjX2uKMQkGaWawJEf2NqmS0E0mT7yO3rwqHjUNicGvn/8eE91Dl4WeS1b4gf9NAD0GD2MTTEXUQ89BsjMl5vADqYJP4qlBvqFxsCa64P7nQj7kkYuKiW7Otstck5yoY2fGX+P9rsYlKjEu3SSd/omGcrSB/nS63qQuzRE7pXebO0dAKfZow90HkNhEAa46/PKRjBAdOR10nMR+le5byNrAu1MD/qCBsNDgiGEudxOlL+HqtnWd0QM97zUZ1JH6SBOw9ALJiBM3sh3pEltFTn1oA/8dJ2CLUN9PFTDVCmJ50BoxqvxgIQzsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrZabOIII74md+4LB6rfVk3S/UTcFgqBiXU7wj2I++I=;
 b=nXRy6qpMOu+jk9b0ukr1xalBXysZaFK3liTFz9IBzRao2IYV1K2l5UAyi/P0sRA95K3Z/jnhRDuYvrjzxyxo4brtKawfAO1zqndjLLCnq4rLCktHPdHGKfte+4g3WkzID3evBEYy2/AFyWeiqhXDnGE5Tag51xOgAciWY8OesEi1B6N9JE7sj3MrGXLNM97X/I/7ClRGvJUiwUYDrFdkE9Zw/43rKXfvp9/OxshUEs16xOeRGcvOrsn3Kg5xQt6j8OSeKUmjlM6PmVzy4DTCGq6k0/PQwR58LuK7s27Z8fjS6FA7xxQU3aw8GFyLi55NBbIi3n8n0VA3wiio6utv8A==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by GV2PR07MB10455.eurprd07.prod.outlook.com (2603:10a6:150:2a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 19:33:05 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5%4]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 19:33:05 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Neal Cardwell <ncardwell@google.com>, Eric Dumazet <edumazet@google.com>
CC: "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>,
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
Thread-Index: AQHc+b18uTDopa6mw0SMYyfW7UPxZ7Y5lEOAgAAowYCAAAB5QA==
Date: Thu, 11 Jun 2026 19:33:05 +0000
Message-ID:
 <PAXPR07MB7984D14DA66C0E4B89BA1D4BA31B2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260611161504.228319-1-chia-yu.chang@nokia-bell-labs.com>
 <20260611161504.228319-4-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iKkPJqOM=0KV8O8=2zWrZObj+E+VJoLztp4sUi7Vj0aQg@mail.gmail.com>
 <CADVnQyk+sOAKU_WtPja7_hgiXw8he9U1g6AY7iEm5q3F3R-Hag@mail.gmail.com>
In-Reply-To:
 <CADVnQyk+sOAKU_WtPja7_hgiXw8he9U1g6AY7iEm5q3F3R-Hag@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|GV2PR07MB10455:EE_
x-ms-office365-filtering-correlation-id: 5659b6d5-4a57-49dc-4989-08dec7f04257
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|38070700021|22082099003|18002099003|4143699003|3023799007|4133799003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 Ki2cUgG+cR9bPPAg0/enqCIgqaYOZmpY55GhaChAoNFoXiP3BsNe0SmjKduk15GTxcZ3DLznBtRus/V34GAWn133KA0pf5aiZG96MEXj5HXUCu6C9ottXGqOZIEM15hnP3NUHwFgMqPY7JFq0PXiLojkqQv0TW91mwjmXI1s+izFb2XeQ4baQErLZtEK7692nYi9fNI6JQTgp/VIi6Sb65k1FMvqpyZcrFjF8gi4XCca7pr6henXxWv1aaD3QUupAcxT4JGjTN/5/jqFlozHSFhU3Gk35P0Vcv7jfX4tnrjaJCfKay3oSWqaZhgbsVu0jAW5sqZR/om7MKiUS+CoMxiYuplOqbwY1t7UM/f+ft6eTl4y2u56UwaolGnYv2eEi/zL6MTkdwdqf9QBbItEVf4+u8qY2S6OONbN87WMoCwxtwkbGpQACEcUH8I69r4DDQflc7Wl73hyxlnMrAhkxK40vqluMXsnth6373fkAPzrRokufX4aEFriHMhN6Nn5zGWKQBbY6pI/btcCtL5g0F11ppZYOBjJ8xBghALbDKafzz3CDi6g8T+NF7Lnj8Sjolo6duq0Fi0sLbVkE3MECjuvIK8BZbFshFx7I2D5/WjNY5d/Uz1n1AW9ZtfH6H30DoeyL7DfRFF2ZR3nZv3QSyNjT/BZ0WebCXVZ+hAju2TWINeq4GZS3IaDz3rDdG4Rl43RVXufVwX45l8rWtxNRVnf2J9vTOOFnsN6Ny/V1cprz4cSVkZIF+DW43mqU+0H
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(38070700021)(22082099003)(18002099003)(4143699003)(3023799007)(4133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHprVnlLY3p5MzdaWVV0Wk01THFpd1lBZ3E5SVYzUWtTTHlUZ1RUalE5UFNh?=
 =?utf-8?B?UFRzc0VFZWpVaVloYTB2WklOMnE1YncwWk0zMitFVDdCSEdtWDd4VWxORUgw?=
 =?utf-8?B?TGozNHA2ZnFvMFNoa0g3bjU2VXhxWXFzcTlWQUd4VDlXbXRxdWRlNVNjYVJD?=
 =?utf-8?B?M0NzM01LYVl4Nmd0RjJETVY2MUNncC9zenZ2dk5vWHJ0Yy94aHdzVzBsSGhP?=
 =?utf-8?B?WC9hK0EySlBXL2Fac0RXYzdJeVJZTjRpV0dSdUo5a1pWMnJmb3ZqNGRibzRI?=
 =?utf-8?B?V0NlcFNHMlZ4WkdEYmVJZUhmVzQ0WENzMWR1Q0pRbjNWOXEyaXdISFBmSzk1?=
 =?utf-8?B?TGFjV3Z6SmlwUkhzcDZjQUkvRDM0M0JDYzdRQ0pwZTF2NS94ajRmN0M0SnVn?=
 =?utf-8?B?RXp2a3NzN0ZZdEdQcjZHVjk1Z0o4NjE2QWlsNDA0UVRCTTZJb2pHWWg5b3VR?=
 =?utf-8?B?MTBuZ0lLV1BUb2J4VDlLcG9ZN1QwM2plOTdNUXcvZEZoYkJOVzQ5WG1rcHFG?=
 =?utf-8?B?WitVSFk3c1BKRUJjMGtKOFVLL09tZVlCVlA1REhZZ3d6Y2p2cVZMVXBCWTRD?=
 =?utf-8?B?UllXeG83c1BLVVdQYUdYUDArQTJkVkNncDZUSkhEbHB2SHdKcS9KbzdremRl?=
 =?utf-8?B?UUU5NE9pSHhpQjNkcWVPNlp1VjJGaUlVT0JySjRYSkdCWmM1VS9ZbVdXREVl?=
 =?utf-8?B?L2tnR0ZWeEN4V2dQLzZzdy85Rmw1UUpwQXNpV21YOFlrek54OHRoK0ozcWYr?=
 =?utf-8?B?b0lrTktoR3BHUUVEdmxhWUc1TWh5dnE4VktJS25RNmJrT3VkWndPalF2eGF2?=
 =?utf-8?B?TlN5Qi9YN1Znc2c5U2ZQSUxNVEJ6MjZoOXhZb2pEd2M1K0Z5ZjY3M2lFTHF2?=
 =?utf-8?B?Q3NhR0dRNzZ1ZUk1UnQ4cXArNHI2QVRnRjAyeVVJSzNpYnhsT0hOcXB0SmZ6?=
 =?utf-8?B?NWhmY1ZuUmV1alJEbDJ1eWk2SDJ5Y1I2c3FsS1Y4WVhZRmlONGNNSHFPTVgv?=
 =?utf-8?B?YmkydXc2VmZYblA2djFTR1ZKOFptTC9DbEliTkxJOHR0L0dHQ2ZOUlJkblhr?=
 =?utf-8?B?RXJMZXVwMld3eWVyRHlCb3lSd0JRcFRIYnN1T2NGVHFLNUYyRS85NWQ5bjNx?=
 =?utf-8?B?RURmQnIyc215bGhHem1PVDNnQ2xBTU16RFJYYW5haFFJMndWbmxoZk53TEs1?=
 =?utf-8?B?ZTdNR01GdENpVkt6RXJHY0ovalRwS2JnZE5wMjJZQTNUejY5UFJ6QzMwbUpy?=
 =?utf-8?B?dGlCK2xPWC9XK01oS1NZYVUwTjI4OTdVbjY2dllKTDhKTG5hWU94dlJtN2Rl?=
 =?utf-8?B?bWo1eE5YYUZsMTBqQzN6L1pUMVV6bU84OFJ2TjVuQld6RzQvVjZlWkw2blg0?=
 =?utf-8?B?V1JJWVZpTDUxamJVRTJpQ2dHVENaZWZZZzFxbDNDOW02UlF5WG1rWDB1SDAy?=
 =?utf-8?B?aDhiRWY5UlJqSDJoV1hzV3Y3RFNkQklEczVBVURuTDVFMWJQNWgxQlRIWTlU?=
 =?utf-8?B?WDRPdDNIRWRqc0lZSG9DVnRDeGxlMmlvMzA1V0RWM204WDcvWmJYOVI3U1A4?=
 =?utf-8?B?b1l2VVJpSUJnQUhpQmFFengvZjkzdGFKajJudjFhTTZGVjRVd1ZyT0h6S3FE?=
 =?utf-8?B?cFhvWlNCbk5EUG0vbjFBcnFENEZMOHBTS3JjZU9rSDdkZTdQWEpZSHZSQ1NO?=
 =?utf-8?B?ZEtVOHJ6YWhWMDFJREZUMy9wRE54cWFibG5MeWJRb3Q1OCtMSnBXekhpeFRz?=
 =?utf-8?B?bEpDcmtWVXlRejdxczNLWjdzN2Z0c3lzUWlpNWZMa1J2NEVPazNCa3VZNlVL?=
 =?utf-8?B?WnIzWWRpZlo3blkxY2hzSUZKcGxBQXNOQTh4ekl4b0F5N05NTG41Q3pjaFBh?=
 =?utf-8?B?L2p4YkVDc2M2NXQ5TTc0RDdwelg5N0l3QXk5R0xHbmFnM015UXh0K2hpcHZu?=
 =?utf-8?B?Q0RZbHU2cWJQUHdHamlad1ZPM2tqV2dNbXJuVy9mVzlxVXJRdzVra0lIa25C?=
 =?utf-8?B?UDg1cWxNOU1MN0FhTlM3OEZlRThSWEorNUx0NUlLUUxrRWt4eWtiVUlRZGRv?=
 =?utf-8?B?OFdqckZKcGM0UkVZUlh6RTNUQnhPUm1QSGhPWFR3M3JrckRyNmFFa21VTTlU?=
 =?utf-8?B?dEQzRnNyNngybStmeWpzTllLVExLYnltVEtXRXAvSTVYUUJTRWpnc0lUanZN?=
 =?utf-8?B?N2RqWlNDMlhQVTJJd1RSblQzOXY2RGVtdzZrUkowR0tHWXFnNkxhcHZrUkxK?=
 =?utf-8?B?NVBrakRjbVpwYWdacXJsL1paTGl3NTVMVkp1bE90M2U1VmZlMERoVzQrbEtv?=
 =?utf-8?B?eHg3cGRQc0NaL2FpQ2cxdkNYL3FvaFVLbEN0clk2U0lzb1ZlL0J2STRvR1FD?=
 =?utf-8?Q?5mKYjG4hJ0yxhqag=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5659b6d5-4a57-49dc-4989-08dec7f04257
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 19:33:05.1840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D56WF0hNWqZq2hOiFmNMPw7IIkQCCHLTl0EbQE1lI2bFA5i2nQV8SUhfphA/7qF45e0jXV+ERRaytP3GphI2IAhgqur6a8y3Yf7Y7glAX4Fids4eINLnUU2Zf0Tqovfu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB10455
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
	TAGGED_FROM(0.00)[bounces-298323-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:ncardwell@google.com,m:edumazet@google.com,m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:kuba@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:koen.de_schepper@nokia-bell-labs.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,lunn.ch,gmail.com,google.com,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
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
X-Rspamd-Queue-Id: 289FA674C74

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOZWFsIENhcmR3ZWxsIDxuY2Fy
ZHdlbGxAZ29vZ2xlLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEp1bmUgMTEsIDIwMjYgOToyNyBQ
TQ0KPiBUbzogRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPg0KPiBDYzogQ2hpYS1Z
dSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+OyBob3Jt
c0BrZXJuZWwub3JnOyBkc2FoZXJuQGtlcm5lbC5vcmc7IGJwZkB2Z2VyLmtlcm5lbC5vcmc7IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBqaHNAbW9qYXRhdHUuY29t
OyBrdWJhQGtlcm5lbC5vcmc7IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnOyBkYXZlbUBkYXZl
bWxvZnQubmV0OyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IGRvbmFsZC5odW50ZXJAZ21haWwuY29t
OyBrdW5peXVAZ29vZ2xlLmNvbTsgaWpAa2VybmVsLm9yZzsgS29lbiBEZSBTY2hlcHBlciAoTm9r
aWEpIDxrb2VuLmRlX3NjaGVwcGVyQG5va2lhLWJlbGwtbGFicy5jb20+OyBnLndoaXRlQGNhYmxl
bGFicy5jb207IGluZ2VtYXIucy5qb2hhbnNzb25AZXJpY3Nzb24uY29tOyBtaXJqYS5rdWVobGV3
aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hpcmVAYXBwbGUuY29tOyBycy5pZXRmQGdteC5hdDsgSmFz
b25fTGl2aW5nb29kQGNvbWNhc3QuY29tOyB2aWRoaV9nb2VsQGFwcGxlLmNvbQ0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYxIG5ldC1uZXh0IDMvNF0gdGNwOiBBZGQgdHNvX3NlZ3MoKSBDQyBjYWxs
YmFjayBmb3IgVENQIFByYWd1ZQ0KPg0KPg0KPiBDQVVUSU9OOiBUaGlzIGlzIGFuIGV4dGVybmFs
IGVtYWlsLiBQbGVhc2UgYmUgdmVyeSBjYXJlZnVsIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3Bl
bmluZyBhdHRhY2htZW50cy4gU2VlIHRoZSBVUkwgbm9rLml0L2V4dCBmb3IgYWRkaXRpb25hbCBp
bmZvcm1hdGlvbi4NCj4NCj4NCj4NCj4gT24gVGh1LCBKdW4gMTEsIDIwMjYgYXQgMTowMeKAr1BN
IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBU
aHUsIEp1biAxMSwgMjAyNiBhdCA5OjE14oCvQU0gPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1s
YWJzLmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gRnJvbTogQ2hpYS1ZdSBDaGFuZyA8Y2hpYS15
dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPg0KPiA+ID4NCj4gPiA+IFRoaXMgcGF0Y2ggYWRk
cyB0c29fc2VncygpIENDIGNhbGxiYWsgZm9yIENDIGFsZ29yaXRobSB0byBwcm92aWRlcw0KPiA+
ID4gZXhwbGljaXQgdHNvIHNlZ21lbnQgbnVtYmVyIG9mIGVhY2ggZGF0YSBidXJzdCBhbmQgb3Zl
cnJpZGVzDQo+ID4gPiB0Y3BfdHNvX2F1dG9zaXplKCkuDQo+ID4gPg0KPiA+ID4gTm8gZnVuY3Rp
b25hbCBjaGFuZ2UuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSWxwbyBKw6RydmluZW4g
PGlqQGtlcm5lbC5vcmc+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDaGlhLVl1IENoYW5nIDxjaGlh
LXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBpbmNsdWRl
L25ldC90Y3AuaCAgICAgfCAzICsrKw0KPiA+ID4gIG5ldC9pcHY0L3RjcF9vdXRwdXQuYyB8IDQg
KysrLQ0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L3RjcC5oIGIvaW5jbHVk
ZS9uZXQvdGNwLmggaW5kZXgNCj4gPiA+IGU4MDkwZjU0MmY3Yy4uM2I0MTVjOWRjYzU0IDEwMDY0
NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS9uZXQvdGNwLmgNCj4gPiA+ICsrKyBiL2luY2x1ZGUvbmV0
L3RjcC5oDQo+ID4gPiBAQCAtMTM2Niw2ICsxMzY2LDkgQEAgc3RydWN0IHRjcF9jb25nZXN0aW9u
X29wcyB7DQo+ID4gPiAgICAgICAgIC8qIG92ZXJyaWRlIHN5c2N0bF90Y3BfbWluX3Rzb19zZWdz
IChvcHRpb25hbCkgKi8NCj4gPiA+ICAgICAgICAgdTMyICgqbWluX3Rzb19zZWdzKShzdHJ1Y3Qg
c29jayAqc2spOw0KPiA+ID4NCj4gPiA+ICsgICAgICAgLyogb3ZlcnJpZGUgdGNwX3Rzb19hdXRv
c2l6ZSAqLw0KPiA+ID4gKyAgICAgICB1MzIgKCp0c29fc2Vncykoc3RydWN0IHNvY2sgKnNrLCB1
MzIgbXNzX25vdyk7DQo+ID4gPiArDQo+ID4gPiAgICAgICAgIC8qIG5ldyB2YWx1ZSBvZiBjd25k
IGFmdGVyIGxvc3MgKHJlcXVpcmVkKSAqLw0KPiA+ID4gICAgICAgICB1MzIgICgqdW5kb19jd25k
KShzdHJ1Y3Qgc29jayAqc2spOw0KPiA+ID4gICAgICAgICAvKiByZXR1cm5zIHRoZSBtdWx0aXBs
aWVyIHVzZWQgaW4gdGNwX3NuZGJ1Zl9leHBhbmQNCj4gPiA+IChvcHRpb25hbCkgKi8gZGlmZiAt
LWdpdCBhL25ldC9pcHY0L3RjcF9vdXRwdXQuYw0KPiA+ID4gYi9uZXQvaXB2NC90Y3Bfb3V0cHV0
LmMgaW5kZXggZmU3MjVkOTRhMjI1Li5hNzIwNmZhNjE5NTcgMTAwNjQ0DQo+ID4gPiAtLS0gYS9u
ZXQvaXB2NC90Y3Bfb3V0cHV0LmMNCj4gPiA+ICsrKyBiL25ldC9pcHY0L3RjcF9vdXRwdXQuYw0K
PiA+ID4gQEAgLTIyNzQsNyArMjI3NCw5IEBAIHN0YXRpYyB1MzIgdGNwX3Rzb19zZWdzKHN0cnVj
dCBzb2NrICpzaywgdW5zaWduZWQgaW50IG1zc19ub3cpDQo+ID4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICBjYV9vcHMtPm1pbl90c29fc2VncyhzaykgOg0KPiA+ID4NCj4gPiA+IFJFQURfT05D
RShzb2NrX25ldChzayktPmlwdjQuc3lzY3RsX3RjcF9taW5fdHNvX3NlZ3MpOw0KPiA+ID4NCj4g
PiA+IC0gICAgICAgdHNvX3NlZ3MgPSB0Y3BfdHNvX2F1dG9zaXplKHNrLCBtc3Nfbm93LCBtaW5f
dHNvKTsNCj4gPiA+ICsgICAgICAgdHNvX3NlZ3MgPSBjYV9vcHMtPnRzb19zZWdzID8NCj4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIGNhX29wcy0+dHNvX3NlZ3Moc2ssIG1zc19ub3cpIDoN
Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHRjcF90c29fYXV0b3NpemUoc2ssIG1zc19u
b3csIG1pbl90c28pOw0KPiA+ID4gICAgICAgICByZXR1cm4gbWluX3QodTMyLCB0c29fc2Vncywg
c2stPnNrX2dzb19tYXhfc2Vncyk7ICB9DQo+ID4NCj4gPiBDYW4geW91IGV4cGxhaW4gd2h5IG1p
bl90c29fc2VncygpIGlzIG5vdCBlbm91Z2g/DQo+ID4NCj4gPiBXZSBkbyBub3QgbmVlZCB0d28g
ZGlmZmVyZW50IG1lY2hhbmlzbXMuDQo+DQo+IEknbSBwcmV0dHkgc3VyZSB0aGlzIHdhcyBwcm9w
b3NlZCB0byBtZWV0IFByYWd1ZSdzIGdvYWwgb2YgaGF2aW5nIFRTTyBidXJzdHMgYmUgc2l6ZWQg
dG8gYmUgYXQgbW9zdCAyNTAgdXNlYyB3b3J0aCBwYWNrZXRzLCByYXRoZXIgdGhhbiB0aGUgZGVm
YXVsdCBMaW51eCBUQ1AgVFNPIGF1dG9zaXppbmcgYXBwcm9hY2ggb2YgMW1zIHdvcnRoIG9mIHBh
Y2tldHM6DQo+DQo+IGh0dHBzOi8vZGF0YXRyYWNrZXIuaWV0Zi5vcmcvZG9jL2h0bWwvZHJhZnQt
YnJpc2NvZS1pY2NyZy1wcmFndWUtY29uZ2VzdGlvbi1jb250cm9sLTA0I25hbWUtc2VnbWVudGF0
aW9uLW9mZmxvYWQNCj4NCj4gV2hlcmUgIk1BWF9CVVJTVF9ERUxBWSIgaXMgZGVmaW5lZCBhcyAi
TWF4aW11bSBhbGxvd2VkIGJvdHRsZW5lY2sgcXVldWluZyBkZWxheSBkdWUgdG8gc2VnbWVudGF0
aW9uIG9mZmxvYWQgYnVyc3RzIFtzXSAoZGVmYXVsdCAwLjI1IG1zIGZvciB0aGUgcHVibGljIElu
dGVybmV0KSIuDQo+DQo+IEFGQUlDVCB0aGlzIHByb3Bvc2VkIHBhdGNoIGlzIG5vIGxvbmdlciBu
ZWVkZWQgbm93IHRoYXQNCj4gdGNwX3Rzb19hdXRvc2l6ZSgpIHVzZXMgYSBwYXJhbWV0ZXJpemVk
IGFwcHJvYWNoIGZvciA6DQo+DQo+ICAgIGJ5dGVzID0gUkVBRF9PTkNFKHNrLT5za19wYWNpbmdf
cmF0ZSkgPj4gUkVBRF9PTkNFKHNrLT5za19wYWNpbmdfc2hpZnQpOw0KPg0KPiBBRkFJQ1QgdGNw
X3ByYWd1ZSBjYW4gc2ltcGx5IHNldCBzay0+c2tfcGFjaW5nX3NoaWZ0IHRvIGJlIDEyIGZvciBp
dHMgcHVycG9zZXMsIGxvb2tpbmcgYXQ6DQo+DQo+ICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9MNFNU
ZWFtL2xpbnV4L2Jsb2IvOGFjMDFiOTdmZmQ5OTNiMWZlZDkzYTAxNWVjMzBkZDA4NTg1N2U4Yi9u
ZXQvaXB2NC90Y3BfcHJhZ3VlLmMjTDE0NA0KPg0KPiAgICBzdGF0aWMgdTMyIHByYWd1ZV9idXJz
dF9zaGlmdCBfX3JlYWRfbW9zdGx5ID0gMTI7IC8qIDEvMl4xMiBzZWMgfj0uMjVtcyAqLw0KPg0K
PiBUaGVuIHByb2JhYmx5IHRoaXMgcGF0Y2ggaXMgbm90IG5lZWRlZC4NCj4NCj4gbmVhbA0KDQpI
aSBOZWFsIGFuZCBFcmljLA0KDQpJTU8sIHdlIHN0aWxsIG5lZWQgUHJhZ3VlIHRvIG1haW50YWlu
IGl0cyBwYWNpbmcgcmF0ZSwgYmVjYXVzZSBBRkFJSyB0Y3BfdHNvX2F1dG9zaXplIGFsc28gYmFz
ZWQgb24gbWluX3J0dCB0byBkZWNpZGUgdGhlIGJ5dGVzIHRvIGZpbGwgaW4uDQpBbmQgaXQgdGVu
ZHMgdG8gY3JlYXRlIGxhcmdlIHBhY2tldHMgd2hlbiBtaW5fUlRUIGlzIHZlcnkgc21hbGwgdmlh
IGBieXRlcyArPSBzay0+c2tfZ3NvX21heF9zaXplID4+IG1pbl9ydHQ7YA0KDQpXaGlsZSwgaW4g
VENQIFByYWd1ZSwgd2UgZG8gbm90IGJzYWVkIG9uIG1pbl9ydHQgdG8gZnVydGhlciBlbmxhcmdl
IFRTTyBzaXplLg0KDQpUaGFua3MuDQpDaGlhLVl1DQo=

