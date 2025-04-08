Return-Path: <netdev+bounces-180324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D917EA80F69
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C7F426D27
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6F6225779;
	Tue,  8 Apr 2025 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=liebherr.com header.i=@liebherr.com header.b="BdvQKJoJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00701402.pphosted.com (mx07-00701402.pphosted.com [66.159.233.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07828221DB0;
	Tue,  8 Apr 2025 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=66.159.233.223
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124860; cv=fail; b=hxIgRjnMph2NqvTZipBGXMpL3zaLvWqEVoChvbM7O9wZnkHunwluZsisP5G6wMUMdoA1KKtHrXhLsCMTGUTtbg3MI/zqu3eeZOfJ5OZLx+1Mqi+zQHjRwjQF6y9tCAxo8K9MBgdCrBSgeNVzQpDQPJWj2l9xQKj1JA67jzIHM8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124860; c=relaxed/simple;
	bh=sfEBUlY86JF9mQRt0M81iMqVAXdHMfXStCjm37SkNso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YE1x73mxrMOwdVXCdHLc2qEBKWxiBJjR3YPEkQkA0icFuPPYVucp9NwSZpDYAc3ZklJ/YyDrIHyu9XsaFi4vuDkDdqc1761MSPCpTWn0Xm3A7HrSB7ZtxUWDvWJMQ0WHhC/qK+viw/qs8S0iGzqrHyvL3giAnQN5BfzOnej/Paw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=liebherr.com; spf=pass smtp.mailfrom=liebherr.com; dkim=pass (1024-bit key) header.d=liebherr.com header.i=@liebherr.com header.b=BdvQKJoJ; arc=fail smtp.client-ip=66.159.233.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=liebherr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=liebherr.com
Received: from pps.filterd (m0408740.ppops.net [127.0.0.1])
	by mx07-00701402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53851dPq021852;
	Tue, 8 Apr 2025 15:01:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=liebherr.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=key1; bh=0XFgY
	/6we8ATOVhFTkBVvTnO0daERQHKDuW4I3lBqbk=; b=BdvQKJoJv5j8aE3h7oHyI
	e/d3WjLVjyM/qh2eKKQMY4kgxFjo86FAOlli2N2hSMZJWa9Hr1ui/U/Gshe4+Zz3
	fMAXK0PhOOy0+JKL03cdFtcsMFCZFznavN7QTR/KTz2fWdoVE56tLJ2S7gQFE6oq
	rpiBG/U8wGo8GvR1VDNP5c=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyiVrtvDGiIl/gn07hgnMvAW4WyTr0kNbp7A/0XHhw579CXdL2nZGAdeyUPH9tSpWbDQ39WTa2TUV8U45zjoTXiMfSyUVyPJEiSAc7NqNqRKXqxlMbJxn86NoFczhcodn40Gl8f4jyjLFfPo9TWbHcHB4kddOsH2yV1hZGY49+xAi1sBe2Ei5btfX5ivLUaGiO4naLFOMlwOxYiwYA1v4R3C5WduNQDg4hO+gbfc+c7wurLSVjILrGtgz/q/F7VaqjnNZHJJhZH1VMvOX3EuybUrCmZEPpdmt0mwzGSGNaEckJxLaeq3SgHW7IpTvKA+6Sh2/YCTaBiyQh47a9ZFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XFgY/6we8ATOVhFTkBVvTnO0daERQHKDuW4I3lBqbk=;
 b=prUG1kJwbvjbLpPL+qLulmxBPSphbZ/6kjt3f4oAmK74zN1xDrAM4JlT1HDgBD5wFXcikRTRNTm/l8iKb9F0+QW1h8P6LHjFnGHk47Y0TKIoZX/cAOMzgw1Z3wGSW0Qna2326NZMhNr1dA+vTA+PLuyorh6OTUKaFMxiuQF011CiAxixg8v6n5pDlY0iOgS1y2bdvMoxLLZPRlgXG0XLwVLqwXyGFIQtJEeb4qkQW1ryopd1XqLz5ifwaTcFmobsPxAZCWbdXgclhEXakEWzOOfrm7gCvA/xlhEWtjON3PaYopsg6YWMJuqlrKiMz9UP7qKGCykNfEa97WANkBOysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=liebherr.com; dmarc=pass action=none header.from=liebherr.com;
 dkim=pass header.d=liebherr.com; arc=none
From: "Fedrau Dimitri (LED)" <Dimitri.Fedrau@liebherr.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
	<linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli
	<f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dimitri Fedrau
	<dima.fedrau@gmail.com>
Subject: AW: [PATCH net-next v2 3/3] net: phy: dp83822: Add support for
 changing the MAC termination
Thread-Topic: [PATCH net-next v2 3/3] net: phy: dp83822: Add support for
 changing the MAC termination
Thread-Index: AQHbqFo9IjrBTn5E3kmWTGlaedQyF7OZt/mAgAADDKA=
Date: Tue, 8 Apr 2025 13:01:17 +0000
Message-ID:
 <DB8P192MB0838E18B78149B3EC1E0F168F3B52@DB8P192MB0838.EURP192.PROD.OUTLOOK.COM>
References: <20250408-dp83822-mac-impedance-v2-0-fefeba4a9804@liebherr.com>
 <20250408-dp83822-mac-impedance-v2-3-fefeba4a9804@liebherr.com>
 <7dbf8923-ac78-47b8-8b9c-8f511a40dfa3@lunn.ch>
In-Reply-To: <7dbf8923-ac78-47b8-8b9c-8f511a40dfa3@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8P192MB0838:EE_|AS8P192MB2209:EE_
x-ms-office365-filtering-correlation-id: de4eb448-f883-433f-31ba-08dd769d735b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?JHm9EjMTpgya9JeJvTgyv7duaCXnvV9x+xUkZsG25TI1WtMBNLkScTFQdD?=
 =?iso-8859-1?Q?OGsm1xEIwXvQBht9PuBg9aZHijHt85QcjXlLam++GCnqBXfGCgFLdl9PT5?=
 =?iso-8859-1?Q?WyJDlSTbX5lwKjzfCA4oeoxtPwMqPbEQHH2+8286yzyM1bEaMFtT0Moljv?=
 =?iso-8859-1?Q?RgmDeqIORXTUmH6WcIYCDjHSu0aX/9003a8bLKiQkqGNP0Yw9umZ/0krlI?=
 =?iso-8859-1?Q?7hStkm7bdef9aW97+zSVZ4IdkNOisgmqdHLR863n1mjI9WY73GVp639jMq?=
 =?iso-8859-1?Q?UxupClN/2rZfdRVR1taJyMIi2QvO1JsN0wWj1On1E3fc6xR9C804T2PX0H?=
 =?iso-8859-1?Q?O91Js99IXbier08DDked0WSMk2RIaT898NdLjVYdVL9sf79HsswBzoycZ9?=
 =?iso-8859-1?Q?Bzg3PS1hK6ozDYJaoDE0BYdtd8W3ofi0+CWsrTDTTm5Qdh4yPPkLxTOIlX?=
 =?iso-8859-1?Q?7wdDxS+XG/8b1Uz5Fs3vCkMExMaqdiTQSsn0ZSZIrCpDuVhn3rayRCai1b?=
 =?iso-8859-1?Q?b/mmE4OEuVk05dMVNy9X7kALQ72m5NBSVkOB0uBYXBE+40HJtYKD6MrPUy?=
 =?iso-8859-1?Q?6ox89ZoLBfqQKEL6y2xYgxWf+diqfWRJBjzMcIeI/jv4Iq1M0yWXTHq93c?=
 =?iso-8859-1?Q?R/hWHIuYi/jS9jZ5aIzbbRErPVsRMxgYDkKj5/3l2OvieC6ZCKl5WWijGB?=
 =?iso-8859-1?Q?IQW2brn9/g9akzY37PkDWc8IdtL92Nqx8auLRIV2gZDjAf1psoPAi1Jx8J?=
 =?iso-8859-1?Q?tRK7J8gM3MOnebb3aoKB+Sy6plGQj7C05Nq8SVymHX+K9GYnVlsiQZAYUC?=
 =?iso-8859-1?Q?DUJOnPWN06J9DIfW9+gAQd4SZCQ1dn17miE9cOuUxlzeY5nEgNA0qg/ix/?=
 =?iso-8859-1?Q?TqSCULyPQiZ7PZi4PGbt460kU0q43DVn6Ahjag2ggLLunlWfxOSpsIJ0UW?=
 =?iso-8859-1?Q?/X6oxha8D8MYV7LjMfYWNDnMh30esz19nalgc9iSQUjvCxza35ExD3MZBo?=
 =?iso-8859-1?Q?QRd05xtccd5rep3PHfhSxD3J4Ae9uqfg2Cb/zMLze560+nVgTBlb47fHJc?=
 =?iso-8859-1?Q?8YnL7g57JX3u2kvENZ6BXruqUT6lNEAnOZzuTVH07/4jEbXzYg9/ZSjXKM?=
 =?iso-8859-1?Q?6WuYaC8mRv3yiNqarg52Mav99UG2wl4+q412Il3LqY36st7u3q7/931bbl?=
 =?iso-8859-1?Q?bhFte92JuIEITeBVYl6pP+fhJSYHXHQyOsFCgUKeUIiLmA+IeVTlTde8c2?=
 =?iso-8859-1?Q?M+C1qZsclB5lrTulg53PugYTukn9z7NXiqXWurAgSN33pW4Rp6+pzmMu3c?=
 =?iso-8859-1?Q?+5TuRkuFcYKMxGJ7cK7NFvUsaLnoCpHxw9NN7Gi1RxyIqA0iFjIEtHYB1t?=
 =?iso-8859-1?Q?NZgQNlYEsHdaLPjcUGuWdIVjKZHW0vVoVbiOZH/bDt4IajYUqMueTGlxvW?=
 =?iso-8859-1?Q?MnM0ETgKQebsC81lD9L/OeH4mlqMzt6XIYBa/gL9hQRctEZ9jdhUYS8AJc?=
 =?iso-8859-1?Q?UouB82GO9bMg43A9oifM8A?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P192MB0838.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yiKRZxDr9M3ahJAHaxZILHEHrXixuNEyd35B1DIN+ApKf4mbxU06goPGGD?=
 =?iso-8859-1?Q?qgph34nxDCrBhjuo2zOqapBEqepjraeBlvShv7iGMh+G4g2tgYDo7MIWXq?=
 =?iso-8859-1?Q?sOufuSKymap/Oxa9Xswk0zCjVY8ixa9qKTa7lMoQZreIK7OzcLYce0CF/a?=
 =?iso-8859-1?Q?mr+AN+IoTdq2xB66r5uLiYvD4PvPBQXHGZiG4SQAVH+x7Vqk+rdxjKPd/o?=
 =?iso-8859-1?Q?XMNvXhBriwu5RzGncXT89hxO0UXzNqIDhSR+f/BOc31wU/MeGWGZJqefaN?=
 =?iso-8859-1?Q?TR6i1HAt6INU9DCHplqlEXFi54IU+8DAyPaXWhKEC4RL5dNcP+AqBAHRx7?=
 =?iso-8859-1?Q?lbyyHl4JAAENi2hTg1vyRUtotyILlmXxtqTFzukbpDcrpHlOY7Y92206vd?=
 =?iso-8859-1?Q?qAww4M6vrMVlfsWJt9QRM3lpVuj/4U57mTPtpy++qx4wiZw27QWA4rubFE?=
 =?iso-8859-1?Q?c1X3woARuogJMBYTbqQYsSvvAxWJMliokKqwBfKhJJJLlGiG7wfognsea2?=
 =?iso-8859-1?Q?IdsecKbmRoGnAFSA68hMrzQpetoM9RapUbCWkWub6AhY06u74zYQ79StXQ?=
 =?iso-8859-1?Q?PBYBbwgCSss1r5Pb9bYxlckWvvozMDlcceZrE/xvt9pr+tQSzrBepvBrBR?=
 =?iso-8859-1?Q?qHKSGSd0v8dmy1hPm2AuOR0LIPX/H1h+2YGf17DcVDhnJz/9WO6383MA/R?=
 =?iso-8859-1?Q?727o2djZwriBZaKzn7bYUsyi87AsK2tPyJvejYZkzEMCOqgT2zJ/9AkXP6?=
 =?iso-8859-1?Q?0bF/Oq6IytudofqfpK3x3cBzxpm1WL2h7I7hBEWct2O0ggugeC3F24mwcs?=
 =?iso-8859-1?Q?beC5Io5UPG8fBFlFmhy7fMUNk+h/mNQMzP+h3IYQR5Ej0FdUEWEWT/8TR7?=
 =?iso-8859-1?Q?1Hv5inRcAEJJ5XmQYDytVNg0mEmUrhiUSmddyqsuoC5g8nY2fDwokyrbpc?=
 =?iso-8859-1?Q?A+78pMGt8HjKo2ILm+KDZ1BEIqKH8PScoN3efe8Q5mmISaGTB+4c+GCJMK?=
 =?iso-8859-1?Q?nqK7rLoeoTjQv8Oj0hYm+KWcK8+ClkW5toEEFmlWvFvv/ctaPrGo49br9v?=
 =?iso-8859-1?Q?SEsO5QJouAEql2CAw8CZyrgbwWbxcul2j6xPwwcpIxNF78VkXW0/VTR2Nk?=
 =?iso-8859-1?Q?5De/8tKtYLHM79PqJsPMhtE6qXCnMcNeviYObPQsbTnrXu6lIX3xufmRnt?=
 =?iso-8859-1?Q?9gR+hD2zBkFHCzBQp/WqbAFFAGkgTBm0wC2Zl6ifzTyRPrXUJPA4/7sHsV?=
 =?iso-8859-1?Q?HVCz2JEMtWTOKZ9mAMAMSzW169IjYQrd5qE1OxcIcbWDcjbI5HwfEGwOKz?=
 =?iso-8859-1?Q?muEjDCg68TTO0ULG8gKDBm3ra41aWK9t1SYE8+IcnkOppBHO3iQD1OIRoR?=
 =?iso-8859-1?Q?wKlBUtOEA68ICG6m4rbQyMDUAlYttsePIxSYnh/owInU7HYAUSaF4OnT3C?=
 =?iso-8859-1?Q?mdOfvP5SMvej8HkRLboxWAx5FnQKBEj0a4z184Dcfsr7HaF6lOWEmK+saP?=
 =?iso-8859-1?Q?IGsKs5on2yh1IbJTwdN/gRJFGSCCDlI5Q/3/AH1AfQSUpZgN/dU8O013cp?=
 =?iso-8859-1?Q?sVNC2gviUIJg+v6YhG59miDQz0gcZ/2xxvXm1SFT59hcKPcOQKG+0F3f9L?=
 =?iso-8859-1?Q?LNoPoQdHvIMF4XNb3HvfcGmE1pPykf8+065OyAeEn8knPI+BPYTQkhug?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	apMmuZNksdIPje5EvawRa4S+XLZi4Glu8vpDV1Qxe7nTdcwINXoGcGT27y/5lISzMFteFiL+ebQGt4vCewV8iycWJo0Y01FH7V6uxC29EHVxkfO2GH/Mblwy/kBodPTxCTkAFBgwY0Cs4Qv/v9ahBXpPKIhBDThh0FRovijV4p358FWkOQ+j15MoNNEXN+wJuNfpmkzc6u44JSLBL9DNHCuqZFUQtTdj0KV+lsPY726QFkHeUNiuS6bwLwzFnTvIwSMdvJo+fr8Ix6zAdbbXphbpeahsjdco5bObq70BHg8SQTobnKeQB8brZYAui68subA575ARpJJUU2FOl8wG90MJ4BBe6AoYyxnl/9vZ+U+KbZTK0YBzyGdZ8jJR0jd6vSo/R4qedvYeL8EosaZDb0J4R1OVxmOzZ2ArrLKVQYTkeuEKgqIfImwy+ICktjE3Un9crwELakdvYRGFWTEfZNlYupVUCs3iY3fJOmssxfzCGymVrI8+Jnch6IduKz2Yig/6WLtY8k+UXr3LKHeo++RYzKkcX37zMgF90YVMOW0U1taht0AGmO+VMkmiozDAIOxPo/kSa+CR6zzcbXI5CPuWVsKpyT3l7akK7CAr8O946qXnXAq7HQ4eY0RzGyRYyi7SXsmYzoLHXtxFSAniQw==
X-OriginatorOrg: liebherr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P192MB0838.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: de4eb448-f883-433f-31ba-08dd769d735b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 13:01:17.3647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3336d6b0-b132-47ee-a49b-3ab470a5336e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CG7K5ZRA/V/vQXpjsYISWB/D7R9P7hpEUUtmWJKfAVLgCNifs2362YURL8b8fcYN6lppaiyO/FTkL8ZfZyh1mi/xuZk4A0ptNzPwmd8QfD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P192MB2209
X-Authority-Analysis: v=2.4 cv=RsjFLDmK c=1 sm=1 tr=0 ts=67f51e27 cx=c_pps a=ow5/roAxt+uy2znxgqYcZQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=k-H-GU2PAAAA:8 a=pGLkceISAAAA:8 a=PHq6YzTAAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=dNtzZPA4tSo3ZyHCessA:9 a=wPNLvfGTeEIA:10 a=OlpMY7MLeOwsGCYq90Np:22 a=ZKzU8r6zoKMcqsNulkmm:22
 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504080092

-----Urspr=FCngliche Nachricht-----
Von: Andrew Lunn <andrew@lunn.ch>=20
Gesendet: Dienstag, 8. April 2025 14:47
An: Fedrau Dimitri (LED) <dimitri.fedrau@liebherr.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>; Russell King <linux@armlinux.or=
g.uk>; David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google=
.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; R=
ob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Con=
or Dooley <conor+dt@kernel.org>; Florian Fainelli <f.fainelli@gmail.com>; n=
etdev@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel=
.org; Dimitri Fedrau <dima.fedrau@gmail.com>
Betreff: Re: [PATCH net-next v2 3/3] net: phy: dp83822: Add support for cha=
nging the MAC termination

> > +static const u32 mac_termination[] =3D {
> > +	99, 91, 84, 78, 73, 69, 65, 61, 58, 55, 53, 50, 48, 46, 44, 43,
>=20
> Please add this list to the binding.

Add this list to "ti,dp83822.yaml" ?

Best regards,
Dimitri Fedrau

