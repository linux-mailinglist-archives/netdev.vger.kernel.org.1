Return-Path: <netdev+bounces-272504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLq+C/VkxmnnJgUAu9opvQ
	(envelope-from <netdev+bounces-272504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:07:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A162C343176
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B752630614C5
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BF53E0C79;
	Fri, 27 Mar 2026 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="cS4IoJmx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242B53BF68A;
	Fri, 27 Mar 2026 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608985; cv=fail; b=raeE5D8n4TGzYXoGqiQDbQ81dIpZme6EIyoJVriaIzOTLNFkaSxnlDvtJRwsQIxXAnCXQcdqwRLP9Oxy4kcUeSjPn3lb2uUkvKMXwseOML8GV5B/1GhuRXqkdEeCSrb087vBlzjFCnoxH0PkQ+4dEkCmKnrXmpUkjltk6uNWxs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608985; c=relaxed/simple;
	bh=IUpNUJIwrvLVYbHD0CIyvYjjXxNZehla2ExOehtY/SM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dBm1KH1dnCgeGxe+j2cvORmilOMCcrQdb/aSaqFZzZZ9xIfnl1Mre1qkJR+jQEosGvbK/8qN2tko1h33rU6lmY0NSjlfRPGAVk5mrYCroGWeeEhX0dBXcwgTV2jdsL+425mp0olvUtJD9htgHwcoQ2aPrdEEvs8lyV94rAoMBWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=cS4IoJmx; arc=fail smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
	by m0050093.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 62R3eCP82961762;
	Fri, 27 Mar 2026 10:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=jan2016.eng; bh=6+u2po53YmC5RdsyQRkrCw
	PrqJvBL2nYcDBWVLDJClg=; b=cS4IoJmxF4aWg0cqoYejrOWS/nIRX18s53cL80
	wp1OOqYwG+kA6HyNvjIcm++now0nJSRQsUOhWAGidkGLPzLFXVGgfkj0ooQmTsKe
	muqVazwEa9oI56sp8ZNkBkOyW52as1GihHe2/hB7qVfdY8vCSCysfzZkdEQXsZzf
	izgwrY4JwFgXbcQikplloqCxgfZmpquLASIAU4YO7Fw+bLNwnru6DUdjs+fZBj9O
	HFQVxNCOAtrNiTY/ioTwQ//t65I34hYMs3Q4L5nbj0xXwfXqt1rmDFNUExpLRE6Z
	np/qwCamCk7xsqi6pf3rZP/cS085DUfkWzCobKPrGp4T2R3A==
Received: from prod-mail-ppoint3 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be forged))
	by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 4d58uha9td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 10:55:54 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
	by prod-mail-ppoint3.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 62RAnt2J029006;
	Fri, 27 Mar 2026 06:55:54 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.220])
	by prod-mail-ppoint3.akamai.com (PPS) with ESMTPS id 4d5f08bsg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 06:55:53 -0400 (EDT)
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 27 Mar 2026 03:55:53 -0700
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 27 Mar 2026 03:55:53 -0700
Received: from PH0PR07CU006.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 27 Mar 2026 03:55:53 -0700
Received: from CH3PR17MB6690.namprd17.prod.outlook.com (2603:10b6:610:133::22)
 by LV8PR17MB7134.namprd17.prod.outlook.com (2603:10b6:408:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.24; Fri, 27 Mar
 2026 10:55:51 +0000
Received: from CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::98fa:4f7f:dbb7:eb55]) by CH3PR17MB6690.namprd17.prod.outlook.com
 ([fe80::98fa:4f7f:dbb7:eb55%2]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 10:55:50 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        "Tottenham, Max"
	<mtottenh@akamai.com>,
        "Glasgall, Anna" <aglasgal@akamai.com>,
        "Alexei
 Starovoitov" <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] bpf: add helper masks for ADJ_ROOM flags and encap
 validation
Thread-Topic: [PATCH v2 3/5] bpf: add helper masks for ADJ_ROOM flags and
 encap validation
Thread-Index: AQHctt0l6pGf9lNykEmZPNpQGND27bW+BesAgAMRBYCAAA0NAIABHssA
Date: Fri, 27 Mar 2026 10:55:49 +0000
Message-ID: <8B5AD797-623A-441E-8D46-EEBDC44793F0@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-4-nhudson@akamai.com>
 <f0f271ae-4d4c-4d52-8670-a14204da437d@linux.dev>
 <9E9BE3BD-1640-49E7-8801-130945073B24@akamai.com>
 <c0c453f9-28aa-462f-884d-0e9beb2fdf0a@linux.dev>
In-Reply-To: <c0c453f9-28aa-462f-884d-0e9beb2fdf0a@linux.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR17MB6690:EE_|LV8PR17MB7134:EE_
x-ms-office365-filtering-correlation-id: c5081336-736b-436d-10b0-08de8bef6882
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|7416014|376014|366016|6049299003|1800799024|38070700021|4053099003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 5eVwLX3nLIH5GozgAiamQr9Eohpgyz48U9qP+qfQhqd9wVywKFlJfGGAatpWHU/mo2cCixa6KahJtGCW7n764eKjSbnjUYsXcJYvmIh9p7LpLx6YjQ1H9W/AJNsYfSUlCEe8geDIzhliUIveJp14+LQcprq4FHrC6Yk4MZaiYRDWU/fqXz9cv5xp5R4V0GKJvg5wrx5tr+4gZ8IBxyHLNHUAQLMDopQ1vOnSOqZ7Jo1vyQtLfgKQo75pMzFbNhSdErjOhJuZlSgyWnTaLv1iO4FoKsQL2WgXfddnGhO2v78WGCDw9a7DNiTOkWcwEuoH2ZFzVZ4Hs19E+ItImkQJjG/ip5TfoWLp0vOXCz5n9VcKuS884ou0fyNvsfoPxQZb/lJqJxme4vGpDNj3sOtiLv4nKniDQgON1Frtht+NCK73lo8i9rJe2KhHwSlkEwBANf3Ypi6/5Tn/Hyz6yuV7CylJXzQVwVUgtMj4E7PFD+kdwSL1dHH86opDS5qlxV/TrJrX23ZkQyFSGPvUsgccLG+9g+5yFoced7Ym89/TBMgr+I6DOs7L3xUAlQ2/bazuxtuMVHwr9AjwBPIcPr23TODGWmY05qAhQduq2dldkugVAkprd8yCUZlazFxrl6MLQoxn06DTn/31Ayxtb3tln0R4XfHAowuSCI6RjGU+ZJokrkcTtoALj+Q1gGb58Wo9gF4wYwhgFggC1QOwioYNQLPVCwDfhihgqvfA5TJqF38M9rLJDU8pKgfYXbDpVjXCKlC6Z2GJYt5gpPt6t0PvFjjCNafQjDDvhUyg6Ias33M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR17MB6690.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(6049299003)(1800799024)(38070700021)(4053099003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjNFajFHeGE0OXlLWkZ5eVAyR21LYXhzN092clhQdFdzZlhlVUVabkNHNzhh?=
 =?utf-8?B?cFZBbm9WcExnZk9JNWN6bWswd1dlVEFXaE9LVEs1VHRQNFZzdVhRZnJ4QUl2?=
 =?utf-8?B?dHJPSjErVnpMd1VvTlpuS2hNWS9RclExaE8xSTNIeVpxMGIvMzFMRmg2SUZ3?=
 =?utf-8?B?TlJhL2FxdWVXVXprM0FxUXdyZDdkQ2hkK0pjeG9tR0ljbnFmSnd4MnVRU3pF?=
 =?utf-8?B?bCtFRU91WC9QUnI1d1M0ZGU0YjlTeGE4Z0tnMVN3MDRuV2l5S1hBTlJnUy9j?=
 =?utf-8?B?VVpVbWlqUURwdmNDV3BtZEdHOXFhcnkvM0ZQMHNqU3FGa1l3S3l2cGg4RGtT?=
 =?utf-8?B?dGk0THU2NU5RYmxIMmVPQlo5dzg3VHZuazY0UE9BTnVQZTNMeXMrSUdBRFdJ?=
 =?utf-8?B?ZS85eXU4THZnTnU1NlFVY3E2dWZOUEtxamZlWE5pa1BvZFJIb0MrQjFwQkFP?=
 =?utf-8?B?bk43ZHpaVEhGdHo1OFgwYzZJRnU1TmU5Umo4NEtQL0JYYlVvUEJISXVrck55?=
 =?utf-8?B?SUMrVnVTVk1sYWhYK1Y1bTZIclRQTVNnVGJPZjJuQjBqb0lMTm82YmpNVTVm?=
 =?utf-8?B?cmdjWitXNmdraE4xL2t1RzRXaE1GNHJLSDZYV3pkaGtncC9jWVQrSWkvNlBS?=
 =?utf-8?B?Vm1NZk9pNkVISjBjbVdiNytRU3dlczEyeFNDTmdYSFU2emFweXl4TURmMzNG?=
 =?utf-8?B?cmlLNzZSdmM0QUJxWDhiS0h0aGZHTlJpRWlHUTY5NlMxenpxWkFNYnp1MEhS?=
 =?utf-8?B?eVRmSUQ4S1R1ODFmT2dGVTAwY0FyamtCSTRGTW54dUxsYjJTOU9iOU5iZTNi?=
 =?utf-8?B?Q3phTDFQVzBUazBEMm9JWXRmb1dJbjJWT1Rrb1pnT0xYYU03aFhRckdnMy85?=
 =?utf-8?B?L0RLUmgrY3lZTDNjcUJkN0lic3NVcHNFdjZiYnNNelRCSS9VUWg5eDErN0h0?=
 =?utf-8?B?M29kTE1qSXEwSWJvQjFjd1M1U3BqbE5GLzVmc3RwdkRNcHJLMzJZSVpsSjNJ?=
 =?utf-8?B?OUUyQnZBOWw2RHJvL1VDRGZpdzlXZ2QwMEMvNkh1aWxQMXVNK3BzYWhXbXpj?=
 =?utf-8?B?enNLMmkxS0dnMWl6WXFBUGZ6UkgyS3pKekk4VW5lY2tRRXo2Z2xQZzJuQThB?=
 =?utf-8?B?K3podDRKNklEN2pTRWpEa3lvYjhSeWhZQTFyUHMxQ2pxcWNQblNvVm9oRkdi?=
 =?utf-8?B?eTFFN1dzY0lBV1Qrem9SaGx2c0FqWXlPeXJMQXNrR0lEQnNiczJiN3ZwcG1i?=
 =?utf-8?B?YWlqb0svRCsybGM5cFhobUQ2U1QzdC9DQ1lnczlIckFaQVNvNTNjQlBPalg3?=
 =?utf-8?B?ZnRHVlNhTlBmaVBMdkNFM0NpVkZuTVM1TjZYR2s4SlVvd2cyTFREcGFBa2V5?=
 =?utf-8?B?aTNicE1zZmVnLzFsTWFZOEwxYnVEcW5qOEd4b2NRMVNEaHl0K0pTY1JTRFVO?=
 =?utf-8?B?V0x5WUVmTWlGdldvV1Zpb3p1T1Yycjc0a2tVc3lEQ2VhZHRQZll0c2dOdm9j?=
 =?utf-8?B?Y1M2V1V1aERGSXFTdWVuUlltVkNpbXZmMUVIclNJR05CUllpQUxZK3lYbXFI?=
 =?utf-8?B?QmF2YTFTRnVpSEl5QkNnWWFsK1VrbXhPRms5d3laZTZZK1FDdGRsdytLSnlx?=
 =?utf-8?B?bWQvb25BQ1gyRHBmQTNEaXIvV0Z1NWQxMVdZcHNjZVhhODE1RzRkNjdwWkxY?=
 =?utf-8?B?VTV4cUtzS28wSjNhbk5KdW8xS0haUC9pSHYva1ZqTks4UTM2OU51Y0JMdVht?=
 =?utf-8?B?MXEyY2JLTjNvb2h3dnU3Y2lFaExYQ05CY0hCNkN0S1lQRHRueUNYOHlXUXJt?=
 =?utf-8?B?NFlyWXZwUUtNQWtONVdvenlXeFlqdzQ1aGxEOVBaOFhiZFFPSThvNndxOEJZ?=
 =?utf-8?B?NlZ2QWJlNmIyUU1yN1hDWmxxYkxxeFFucGlqd0F5NTZha0ZrK3dGN1AvRXRP?=
 =?utf-8?B?ait2LzFJbUtUSkhBbDlMNFJZRWUyaWZMVUJiQWcwdHZLOGpUcHpmYm8rRUNk?=
 =?utf-8?B?ZDNYNFlPMDFjSS9TR3JoY0FxVHhLQnpTZmJpTHNBZHdkTlcwSHpVby83aWRJ?=
 =?utf-8?B?TS9JNVBoQ01tV2E2SzQrdDJYalltL2p6SXVHTFJYRFhyU3g3aU04b1pFOEky?=
 =?utf-8?B?eVQ2LzJRdUs5ek9NM2dHejJsYVArenZwSmtOd0FIUVdLNHpQWXc2STlqaXFy?=
 =?utf-8?B?VFRKOFJxRUk4TC9XbDRCNnlLQmU1MzJVbjM4L0hMdjQxTDZJT0V6cFNqRmxl?=
 =?utf-8?B?U0tJOXcwRGpjTlpUQVNiVzFZZ0R4dlVobnNYWkxEM01zaDNGVHZUMjNkUUFp?=
 =?utf-8?B?Q3k0MkpxbVNHSmNhL3orTk54SVpRQ1ZjcjdLaG9RQThnejFZY0pWMnRaelp6?=
 =?utf-8?Q?XzKxf29hfSApAvF9y1G2Py/C6D7a8IrK/O204dDxH9D9G?=
x-ms-exchange-antispam-messagedata-1: Qzpzv0cZtIqcuw==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpSB2kWDz0L3J+SQMhvsejMDD2LPsDjkmW+L4vHY+TYbWyPXZ6jHHnFDZCC2JvgwT/nZwh2gWGJl1X61I8+EbswgJufNnSl2/5gjBzOrtnT4A+Xn0vVUQF83Lh5fFKOLEPq7T3p8ZfM+A/y3TAOPBEZzvv9xo+JQg3Y1dFZucp9EbacKPbmKLdzxPvhCq5izpmz0Ju4JslajSWERiDv9XxhNflUrwlCuOKdFL8MxQ8VNaCd1X1ubPUp1n+dE7/bdJ6kzBaMNFgnImPtkzbTnT1q5PbjxPlmqEL/rw0yPb3TSTVxZYKP0Rm6723gZIwlIYYDj/9rxJwdBq300miEMfg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rc43dcyvmuiA1ILFd6YwE4yQsDReq0aBn0qE6upTZAg=;
 b=x6AG9/GNz+WtUbslj3JF/laVi3ueSsDd9cSCaz277sLVvYhtpYBcth4mDJXGe2IjEgPPgTKW1+CQf7rYpoGMOQFI4S1nDhlDY76IixfOI2x+aP/KU6dx1K+9fFpYrtgyRk/JiY8BbyZO0GKoOHz00TlFr6raZnyUxlufAH9vnk3cF8qM/83KbiuxxpewAO4TRbD68o5/zoGTxOUGf4UiDmC7FswHw6JXEh7DDKL7jHd3VVeZUXgGzOoQiG5Hl7WDWW5VL4mmctm9wQrhaNdIxQTOnj8FzGWgdxnOnW/eYCypDdzfIPZ/Nw1IRBMMnghzdhar4F6LWRDHuftbS24hRw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: nKopXuFyYBoV1hh8UNv3kMFXsA1ggyzdA71UA6VbwlXcVU7VNxTLnkaoO6qeZyXCIN6+KkSGPtg87NPjkXmnl2eQrqt/Fhqi0Pb0cIefMzIA3DlcgCr4SUk6AU1rMhaJhtItjfjBSqLVgKNQnxG9QtCNL3hnqWn50hJTM/z4MECT9BV0BUjike7RwXgAAbAM4xt52sdkyKSr5sErD5lPUso6FbQv1WQrkwHqBaI985CxVjTZ2z8uq0M8iado0XiTr8HGgsyIHh5cFAXQyNggtR8vq8hBGCi9fr+NiQ/HSzTstfvXov5jeHnT6EP0XyQZVZTsKLQ/J9wKKTCwMJNEvA==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CH3PR17MB6690.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: c5081336-736b-436d-10b0-08de8bef6882
x-ms-exchange-crosstenant-originalarrivaltime: 27 Mar 2026 10:55:49.9489 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: xVPUV9ZVC+HB2BgL9wPHRuYMRSV9rPlKAhztaXNm+eVwWD0JCYdsp2Y5QbqqMRSjGFBLm4gkSbK4v1DNr1YUMA==
x-ms-exchange-transport-crosstenantheadersstamped: LV8PR17MB7134
Content-Type: multipart/signed;
	boundary="Apple-Mail=_597BC2FE-A05B-4FCF-8DB4-5D4EB80C49CB";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2603050001 definitions=main-2603270077
X-Authority-Analysis: v=2.4 cv=K+ES2SWI c=1 sm=1 tr=0 ts=69c6623b cx=c_pps
 a=x6EWYSa6xQJ7sIVSrxzgOQ==:117 a=x6EWYSa6xQJ7sIVSrxzgOQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=d4nn1RXdvEacMIURMw2s:22
 a=K0spyLC8T49P4mdfCRIA:9 a=QEXdDO2ut3YA:10 a=aUQEjLJJORIxqg3IqZUA:9
 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA3NyBTYWx0ZWRfX3hbjfYZkqH66
 5x5HlvgldKyI/ZZWXNXBu4lBSstl6mc0ZQbiOGo9vLFnm2NkpKdOVLw9D5LeTige0rmYTzU0xR9
 7Hr7TmhDH+peyLQH84ycPJ62ZyznyVmOJl9dyg/tatejp2L+6ooq1jbXJkTLTW9RK2lkSLg+2M9
 Sk1bADAqUAkHv+8SSxIn2qw+ivsq3Rla8BlS4KstGgb7fuOqTyfFKwaz4sfsSsp2i3roJCG/5/Z
 JLoVzdqmWlSZE7+0OiBpuNglU86Ay8s1CadcWUL7Uakjb1rpy+9/vtKF6k+pTctFk3jgo1QXG0A
 TFF5IV9OWYaSIO+qoRKxLhIovYdJSDN/eOjMfAeYG+VSazgI8mwYh+2K2TP47grcx2AhkAPvJJH
 YTxlFnY56N4Bq5FjUXuSHv03ziYYf0ZtHZVOJU5touwx6ZpkAhuEMW3kBArlh04Yy1gcrAE1XP6
 6TXr1xXqMTogz2MdV+Q==
X-Proofpoint-GUID: ckgJSdrbZjDRUcptFgxTsz5QlUipPuE4
X-Proofpoint-ORIG-GUID: ckgJSdrbZjDRUcptFgxTsz5QlUipPuE4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603130000 definitions=main-2603270077
X-Spamd-Result: default: False [-0.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272504-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,kernel.org,iogearbox.net,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,akamai.com:dkim,akamai.com:mid]
X-Rspamd-Queue-Id: A162C343176
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--Apple-Mail=_597BC2FE-A05B-4FCF-8DB4-5D4EB80C49CB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Mar 26, 2026, at 5:49=E2=80=AFPM, Martin KaFai Lau =
<martin.lau@linux.dev> wrote:
>=20
> !-------------------------------------------------------------------|
> This Message Is =46rom an External Sender
> This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
>=20
>=20
> On 3/26/26 10:02 AM, Hudson, Nick wrote:
>>>>    static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 =
len_diff,
>>>>       u64 flags)
>>>> @@ -3502,6 +3513,11 @@ static int bpf_skb_net_grow(struct sk_buff =
*skb, u32 off, u32 len_diff,
>>>>   unsigned int gso_type =3D SKB_GSO_DODGY;
>>>>   int ret;
>>>>  + if (unlikely(flags & ~(BPF_F_ADJ_ROOM_ENCAP_MASK |
>>>> +        BPF_F_ADJ_ROOM_NO_CSUM_RESET |
>>>> +        BPF_F_ADJ_ROOM_FIXED_GSO)))
>>> Under which case this new check will be hit?
>> If a user supplies +ve len_diff and attempts to pass a DECAP flag.
>> The commit message had
>>     Add flag validation to bpf_skb_net_grow() to reject invalid encap
>>     flags early.
>=20
> There is DECAP_MASK check in bpf_skb_adjust_room() and then !shrink is =
rejected. What am I missing?

Duh, right.

Do you prefer the do all the flag checking in bpf_skb_adjust_room or =
keep the encap/decap split?


--Apple-Mail=_597BC2FE-A05B-4FCF-8DB4-5D4EB80C49CB
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCc8w
ggShMIIESKADAgECAhMxAAAAIa0XYPGypwcKAAAAAAAhMAoGCCqGSM49BAMCMD8xITAfBgNVBAoT
GEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEaMBgGA1UEAxMRQWthbWFpQ29ycFJvb3QtRzEwHhcN
MjQxMTIxMTgzNzUyWhcNMzQxMTIxMTg0NzUyWjA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9n
aWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcD
QgAEjkdeMHsSTytADJ7eJ+O+5mpBfm9hVC6Cg9Wf+ER8HXid3E68IHjcCTNFSiezqYclAnIalS1I
cl6hRFZiacQkd6OCAyQwggMgMBIGCSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFOa0
4dX2BYnqjkbEVEwLgf7BQJ7ZMB0GA1UdDgQWBBS2N+ieDVUAjPmykf1ahsljEXmtXDCBrwYDVR0g
BIGnMIGkMIGhBgsqAwSPTgEJCQgBATCBkTBYBggrBgEFBQcCAjBMHkoAQQBrAGEAbQBhAGkAIABD
AGUAcgB0AGkAZgBpAGMAYQB0AGUAIABQAHIAYQBjAHQAaQBjAGUAIABTAHQAYQB0AGUAbQBlAG4A
dDA1BggrBgEFBQcCARYpaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNQUy5wZGYw
bAYDVR0lBGUwYwYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMEBgor
BgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAwkGCSsGAQQBgjcVBQYKKwYBBAGCNxQCATAZBgkr
BgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNV
HSMEGDAWgBStAYfq3FmusRM5lU0PV6Akhot7vTCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2Fr
YW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNvcnBSb290LUcxLmNybIY8aHR0cDovL2FrYW1haWNy
bC5kZncwMS5jb3JwLmFrYW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3JsMIHIBggrBgEFBQcB
AQSBuzCBuDA9BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNv
cnBSb290LUcxLmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFr
YW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFp
b2NzcC5ha2FtYWkuY29tL29jc3AwCgYIKoZIzj0EAwIDRwAwRAIgaUoJ7eBk/qNcBVTJW5NC4NsO
6j4/6zQoKeKgOpeiXQUCIGkbSN83n1mMURZIK92KFRtn2X1nrZ7rcNuAQD5bvH1bMIIFJjCCBMyg
AwIBAgITFwALeewU5YRKbvcMWwABAAt57DAKBggqhkjOPQQDAjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMB4XDTI2MDMyMDEzNDgw
MloXDTI4MDMxOTEzNDgwMlowUDEZMBcGA1UECxMQTWFjQm9vayBQcm8tM1FIVDEQMA4GA1UEAxMH
bmh1ZHNvbjEhMB8GCSqGSIb3DQEJARYSbmh1ZHNvbkBha2FtYWkuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAx+gvYqVaQAmc/yNlMv3t5CK6FN7++3ZChJpOElnFyZWj3h+VwSqN
5WD4VQn5DL515KovgCiv63DeQ1NuXNu3XKKeakHyssixhIL2hqjlPFnsrwXJ2R9B9hAGIiOBy2rK
Var+w87AFUZ70jsZlI70IBnJOYsPYnZRmXBytTxVWk9V7Nnh10RuUfkZE2Ry+P18Z7glHYoQeksi
hz/9uqRUEqt23qDYBR1J7bB+SSW5A3LmoTEugWYzayxb9iM0vVleEHqeuN5nihGn8Y7nIrs5sIo8
6AG2Bjl0O2VgWWVfqhl9IMQlx1ZxHAicuMvDN49LD1yMkqx+LeBLboiFQQ0MVQIDAQABo4ICzDCC
AsgwCwYDVR0PBAQDAgeAMCkGA1UdJQQiMCAGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNwoD
BDAdBgNVHQ4EFgQUD8PIZa7GFc+oX4RLtUq8oUrOL/IwRgYDVR0RBD8wPaAnBgorBgEEAYI3FAID
oBkMF25odWRzb25AY29ycC5ha2FtYWkuY29tgRJuaHVkc29uQGFrYW1haS5jb20wHwYDVR0jBBgw
FoAUtjfong1VAIz5spH9WobJYxF5rVwwgYAGA1UdHwR5MHcwdaBzoHGGMWh0dHA6Ly9ha2FtYWlj
cmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRDQSgxKS5jcmyGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3
MDEuY29ycC5ha2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEpLmNybDCByAYIKwYBBQUHAQEEgbsw
gbgwPQYIKwYBBQUHMAKGMWh0dHA6Ly9ha2FtYWljcmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRD
QSgxKS5jcnQwSAYIKwYBBQUHMAKGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3MDEuY29ycC5ha2FtYWku
Y29tL0FrYW1haUNsaWVudENBKDEpLmNydDAtBggrBgEFBQcwAYYhaHR0cDovL2FrYW1haW9jc3Au
YWthbWFpLmNvbS9vY3NwMDsGCSsGAQQBgjcVBwQuMCwGJCsGAQQBgjcVCILO5TqHuNQtgYWLB6Lj
IYbSD4FJhaXDEJrVfwIBZAIBUzA1BgkrBgEEAYI3FQoEKDAmMAoGCCsGAQUFBwMCMAoGCCsGAQUF
BwMEMAwGCisGAQQBgjcKAwQwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0DAgICAIAwDgYIKoZI
hvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMAoGCCqGSM49BAMCA0gAMEUCIBZ79THtRc/r
DXpg8rSeL4tPy9/eLjXnJvYW5Ek2SUJ8AiEA5j0Wa0K9P2Vumn7N4F5MpbHW2t/kxsdwUu2Vzp6S
5BUxggHpMIIB5QIBATBTMDwxITAfBgNVBAoTGEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEXMBUG
A1UEAxMOQWthbWFpQ2xpZW50Q0ECExcAC3nsFOWESm73DFsAAQALeewwDQYJYIZIAWUDBAIBBQCg
aTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAzMjcxMDU1NDJa
MC8GCSqGSIb3DQEJBDEiBCABJKFWpI2KdPvNzC7yi5taerNZgPomalzoArIURaxBbzANBgkqhkiG
9w0BAQsFAASCAQCSv7Ig9TqX+GApyvRpBhaJ4/VxLFt9PA3te4AkygrJevlyvUY+UakX9MzeoOJF
KHGTpXcAKXCWhvqJX0VoTNN9Hep4P4Z5HfWziNTyWQgV1lH3WWguRG4Fboa9HFFT2o4ySX24sGcW
VmDqjzjUdvHhlzgJeSFrj5uLFUWWw1/3yuOjNUuZnNYsjUoYF/qltXfmDjrS2rkQG8GJzx1iareh
hyIv94SLCc2aN2ASr3lYBz9bQLrsa9LH3pqhkb11+KKeVy4S3q/ZFwFEK2RKPNAjNHBumhh+v+XT
Yt06v9lsqbAsAAaOL5Eo7KDXNOWJvYpeTE0QtFVLGrJESycStToFAAAAAAAA

--Apple-Mail=_597BC2FE-A05B-4FCF-8DB4-5D4EB80C49CB--

