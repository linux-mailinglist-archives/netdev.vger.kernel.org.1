Return-Path: <netdev+bounces-295126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KHPuAyI/IWqEBwEAu9opvQ
	(envelope-from <netdev+bounces-295126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:02:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 960CC63E487
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:02:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b="k/EebRvt";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295126-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295126-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71AFB301BBBD
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 09:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE3F3E5564;
	Thu,  4 Jun 2026 09:01:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27869346A1E;
	Thu,  4 Jun 2026 09:01:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563696; cv=fail; b=jJDa+++nsVowajcLk38Iug80IVcSR8NkzkqZZ8HQk2VPgrKbJIQQy5NGpgDD0wnojvei4+e+rHnTh/dH1/FH0i2SYpsBc16d76fzK3qo8bDxZoBfogFlYqB9tS+RA1Sg5WlclGTslR05Lx7LlEp3O5945B6AOQTQCL1WHYl8pUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563696; c=relaxed/simple;
	bh=Bqzit4W3QCR3WYsXIbR04SiiZvMfyRCHDTrhZpujjdU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Afo6lYu1eXQtBiNhup6fimjA5X9Z91Oi1FKKXZU2vAZaDoNv3cvmYXoM69jF6IA5n3rlGeCCNj3oZo8Tts1MDcJj0Zh543LCF+AzCsYdeB+Tkrb+TiP3HAr3v5DVGALc5HGZrv/L5mMZDn+uIpbeqvVcJncPyeZ3X1pN8c7+FfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=k/EebRvt; arc=fail smtp.client-ip=52.101.201.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3AbPvdQpNlPc/4Bq8UBdRqtN5itD1q05EeS0JXdCg2PYgpVbLUUCFfssnNCqLEIsbUxGejDVvf8MDWXENqxxwbNCbEK5UTZg2zmAMVqnazjx2M1ybneAk7wg+mKS/MpIV6cInzhv6eJBYZQE7qpF+RERHaiuhMrjjgBnUKmYRnmfC88KSibRlwZuyhZUPXxUDO4TxEB1bn9/KY4BHIbJojojKHbMKW0mCS1H57nrg6ZGsNeWBNjEtbLU730EtaW+wHlVr4DxC+DcqPVSpiwiSBDHzmBUvMOnByNq7TXGhJfgoAfTAQ4R6U8xm5T0Eh+e03YU2Pv6OWzL+IylD8iyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bqzit4W3QCR3WYsXIbR04SiiZvMfyRCHDTrhZpujjdU=;
 b=g0/4vvWTpSaEw6nMKD9kUfnvgVR+dVzyJxUFMIxJbqtLJexB/QC9pU7GI4kxrJxka2xCiPEia76lDfjFeoGUVUMRYaYVfkRrNAOkc8LHAP6pkVlCoCRkC+P9cnqzXk9gV+m8xKvTGeB+E6P57m7y+X9Dz6uCoHLpmG119/XDJwOOa+CatRaeCv7b5yatgRvYWWebVtmNuCH33yJUh416A764z/NFAnva8rM9UckaBe9kDznWpWj/8vWVcKJlrT02ueBxl3CeXPn84+mmc5WTWLGsX5WWw0XZvvFtfMg39qM5TO96/3BmmQgRCuaBLLi37lDqLcC0QFu+0zN8JOAX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bqzit4W3QCR3WYsXIbR04SiiZvMfyRCHDTrhZpujjdU=;
 b=k/EebRvtdp9eIKG6Ed4ul7Bumr+r8yxs8VJEZKT/N6JVDaeMrBuxZdoEsJtKDRaWihdYtPGNOSCY4WuVAUcZ48zVAng/HdJ1KaqKYrGP3HsPO7T3NXI2ze4/ypFYHi+a7XeD+Zy6pvSs2v9bUvads1xf4nr4dRunx5sb0hntqChZff3WbmC3+/uMETfAvChzau6ue/nHdAkv6WltmjwlL3bQtmZg5WzJRTCcfjw2u8O1umVaRVs1I9GP0o2LYJdYuL1Asg6HOvbKNMcyz6n3ON5gJJNwK8LwRlTus86LSNCGwhzN2dhHlVtFeAld8r4LATKe7izp1TVEmWMsSJ2nrA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB7040.namprd03.prod.outlook.com (2603:10b6:510:294::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 09:01:32 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 09:01:31 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"Jose.Abreu@synopsys.com" <Jose.Abreu@synopsys.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: xgmac2: disable RBUE in default RX interrupt
 mask
Thread-Topic: [PATCH] net: stmmac: xgmac2: disable RBUE in default RX
 interrupt mask
Thread-Index: AQHc7zs59LjZoyL/IEeye5wZsOHR4bYlYYyAgAjBdwA=
Date: Thu, 4 Jun 2026 09:01:31 +0000
Message-ID: <6837ed21-196a-48dd-b8b0-0f6691a946d0@altera.com>
References:
 <20260529071734.27722-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <e10fe18a-a0a0-4c80-8ca6-88d0e0f18559@bootlin.com>
In-Reply-To: <e10fe18a-a0a0-4c80-8ca6-88d0e0f18559@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|PH0PR03MB7040:EE_
x-ms-office365-filtering-correlation-id: 4b9e294a-7974-4fa5-ac18-08dec217def8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099006|6133799003|4133799003|4143699003|11063799006|55112099003|38070700021;
x-microsoft-antispam-message-info:
 /kWkfnaae5WZoj5Uc8NfHQNplrwYixqQnJXie3mjk+Qq1H0KghM9gIzZxzb+EE8ZPdXCTEkcHBpCY1MtiKO5cg6i8w49JMI4bYq5K9PS95ZmewSXouzI1Nfsb4YTiQaE5EvxfwgcBleJgvxacjRVg/oVdf1dbUppbgqSWk6B4J8Y23/UScmIZKcQYVXRHOnAR+hkDIHqa+/ATTwZvekgFV5WuAuwxzmPfQsqxAXZJFlp8mEa59Z681m1RNHamkWNcd/3kuEHfhvGIZOo8VfmkO5jJSptYuFHD/iXbaUjD5kdLnwueKOpZ1uWGK7O4HDB8vfQtxT5TyIofRDBLJGiYMVNb986Aq9OeQUY8tii1TRckW2bxpl3slvcqZXYGKH4JblpnSiAvly9dwwSbPvKma2FXzad7QhsLFODUlSEJ3pmtNdSfsUwg5dgzloqfsYIm1Ckn/h7AHP8JWEDb2+WuJx67Or3OMZZ/CztYBxwKzbB9TW+n6fYsG/okgJeCYPaXMt+xzT+esvDMzjD745NiOLws0CF4Ejz4vTZiOBY6Fps3m0sH5cy2bdhFUHJFpR3sRvBRDKpWvzUZlxwrMcCihfC1cEsA3vguJf7deCzp4MpcbtGakPcmYL+oWmKDavzXHXEu1j3sZsG/+NhCBq4HIxaDMARgU3ebUpZ4QlaY9vFDyTrF+XdjjuBek+PwyHVWFEw6qlEgRhwviSvXBCtRQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099006)(6133799003)(4133799003)(4143699003)(11063799006)(55112099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SG1KRkRWY3h6V3ZQcFBkd2VzV2ViczFsMEFRNkR4MlNnWmc4M0NaR01FN2p6?=
 =?utf-8?B?eWxkeHZkSmMyMjJKbUJGcDB0TkxQV2FpalFsRGI1R3E1dmRZUGUxUmNIdUpS?=
 =?utf-8?B?SW1scXdQd08yQXU1VUhRRFNFeEFUbUk4Wkl4WUQrNnc1di9SenFDeTJuVWxl?=
 =?utf-8?B?WnQyTFUzUWRpTmNmL2NNQjBiKytGTW1nUXprSTZRVDYxclZTM1VIZlBhYmJl?=
 =?utf-8?B?b0t2MmVzd3p0eUpOR2V6SHNaRnIvUXU2dmpPREdQZHpyaHZwUlk0bHVMWllY?=
 =?utf-8?B?VHBUSDJZY0QzWUxxc056Q2pLYVZwQ0hjR0lTZ2dxczdzQkVrTHFDMWZMZlpC?=
 =?utf-8?B?SzBSRm02ZEgrWUNTTytqdkw2Y0R6SGdTWFlWQnhYdFZTTmQvL0QyMnYyL2JU?=
 =?utf-8?B?enVrdkhlRndrcFNic0krK3dRSmhrRTBoWEp6MjVpK1J3SWlxSmp1SUhvQ0lk?=
 =?utf-8?B?R0RUdjJEd3Naa2x2S2JsclU3YjRUMFE2b2dyTWs1Q01hd2dRaVBxY2VDdTZx?=
 =?utf-8?B?amFzZ0JTc1RNTHlqVVFLNGh6Y3RMUSs2VjZLQ2pTWDF5MDBoNXpzN01rUVRD?=
 =?utf-8?B?cTJlbm9aZHFNaSttR0xDOVFPRXV6NllWZVlPVzFXUmZMdWx4TkRUalVqT25Z?=
 =?utf-8?B?bDZEMzRmbW81WEJ2RnJVNVE1b1ZTYm1LcjY2YkRjY1E4cFRLSWovczc1Yitl?=
 =?utf-8?B?N0NKZ1grdDE0U2xvRjltWDEycGJDVmZ3Y09QNmJPdDBKMXdnMy9HUDVBRS9Q?=
 =?utf-8?B?R01nZnlLNkRtcENFTmlwdTlNYzRtYnpSUXk2UmdacFFJazdLYU9ZakJ4bUY2?=
 =?utf-8?B?RWdpSmNtK3BSV2doUHZ4YmpOWUljYzlYNW1TUGN3bnpYSzZJTjJEbEoxR1lY?=
 =?utf-8?B?UWU1bzM2ZE9VQ3RlYUtwK2hkNjJEUG8vTXNvS3RxQ2lURW9pS2N2SEgvamN4?=
 =?utf-8?B?ZFU0N2lhQ05KZ2Q2dEZXTG4wUWYzQi90aTVmNFlvbzhhcmNVeHhvRHd6UXp5?=
 =?utf-8?B?Z0JlU3pTMEhENklJajZ3MDJWb2dMbDBPTVJ1NlNOUEhPQ0Zudkd5dC8wYlFS?=
 =?utf-8?B?QmVBV1EvMkI4QXA2WFdhOHZXVG4vZkJNUFlUNXdHbVVLdzJHSk5UTWFDRDMz?=
 =?utf-8?B?MzBTb3NhdTlYUHNKSmFUc25pTzVkS1ZNcjZQZmtnclkrV2RsbW0yckRDSU04?=
 =?utf-8?B?ajhmY2pzY0JQczc5UCtXTzkyMEVYZ1pQOHowOEhpR3p2b1dPTUNVV1JTSHg0?=
 =?utf-8?B?b0dFSXZSUFUrQ2hlWnQyYnhGQW90TE13QTdiOXJGQkZYbzRSOGJvZjlPNmww?=
 =?utf-8?B?dFYrbFNYMFlHUlJFVWdCVUpxelVySmIxUVg2aytKMUJlYmhVTHhOZ3RTcVls?=
 =?utf-8?B?REVpc3pUUTUxUkxTcVlSSlRxdzdOaVdxTkpEVHYwM2FKeHJzM1JYcnpWbTg0?=
 =?utf-8?B?dDk1QXNTK0lzTzBDa1VmRldFQkZjZ2FPL2lRTXhKYlZvYWFoMHVSUGNpSnFr?=
 =?utf-8?B?Z0FBNGVvYnpPV29WZkVLLzFZcC9VQVhFWFhWdlNka3ZzYmdZMDVYMzFlZWZk?=
 =?utf-8?B?Mm52OVdSRlFnM1R5WHhydzZXaTQ0Wm9DaHBsc3E1Y1VrNGZnbm9nenVheWUx?=
 =?utf-8?B?RHU3RGNkNW9NMHNxQ0M4ckJjeXdrRGJsV3VlZXdQdTZFdHl4SHd1RWoxT2dM?=
 =?utf-8?B?dzlGU1BzYUVMTnVTbzJOMjBsNVo1eGh2VUZ2L2FaUFZFVHgzd2hQSHFHOUFY?=
 =?utf-8?B?bTUrM2lFZXVrZHdmOXdjdnlwWkRMcHpydkVrb1ROK0RWcVVLVmlzMHVBN3pY?=
 =?utf-8?B?dUdwQzlRU1diRncvR3U2UzF6cnlwL2phSW5pc3NDVHlHSGdCNmFYVnhjZ2lp?=
 =?utf-8?B?aXBHWEtRa0YrbXppZnYrTGVCZHlxYXJncXBGNlhXWElOMXJMN05IeDlnVlQr?=
 =?utf-8?B?bzBmQUxNeUs0MlVXWnMzOWxhanJ4U3RqaVp1UkNvNVhCR2ordERYU3F2eEFj?=
 =?utf-8?B?d3dJRDhnRnRPU0NiWTYyWnlmb09LajVzNmNRa1ovWXJrUUd4d2M2OEZsajQ4?=
 =?utf-8?B?eEltczhRUzF5VHpuYXBBQ0NYcXBPYUM2Z0hUUDRhYlZ3Q0JHZDJucjdydC9E?=
 =?utf-8?B?TmdZM2JUajV6a3VkY29NMHdUZFpmY1V5Q2pJVVJ2SVNGTGoram15ZXhoOG1q?=
 =?utf-8?B?T1NzTzhEZmNyUzcvNTdDSjlaMm8xMmRBUEEyY005TzVscTRFSFo1TDhlbXFa?=
 =?utf-8?B?Ty9sRkNZZWpzdThNQVFKR3hRTTFNT1lsbEhOY1g5Si9UYkZiSWF5cVU4bTFD?=
 =?utf-8?B?ZEdSZHFLL21OQkVrVDJuOVh2cWpKTGgrNlhyVmNkVThpd3I3UnBUMG13YWNW?=
 =?utf-8?Q?5obRerwVzbqRTasNl6sOx57d9b7zhs80FpUA2Vhk41zbO?=
x-ms-exchange-antispam-messagedata-1: HoVa0owysbvbSQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <244410BB15480349B5B69A142EB1F0E1@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9e294a-7974-4fa5-ac18-08dec217def8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 09:01:31.3843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5UJ7EdZaeWX8EO6bUoSPruyZbZADn+XEz6XWEkxyIM0MNmTEvFazCyQWyNXonigUH9OjYUmoFj+ayVehcVNHzDciRTZ1073xsVcS81o6lCw6E0uSwKypM5PO3fAH5P2dllfjYJytCADcfrn4c3PpUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7040
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-295126-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,synopsys.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,altera.com:mid,altera.com:dkim,altera.com:from_mime,altera.com:email,outlook.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 960CC63E487

T24gMzAvNS8yMDI2IDM6MTkgYW0sIE1heGltZSBDaGV2YWxsaWVyIHdyb3RlOg0KPiBIaSwNCj4g
DQo+IE9uIDUvMjkvMjYgMDk6MTcsIG11aGFtbWFkLm5hemltLmFtaXJ1bC5uYXpsZS5hc21hZGVA
YWx0ZXJhLmNvbSB3cm90ZToNCj4+IEZyb206IE5hemltIEFtaXJ1bCA8bXVoYW1tYWQubmF6aW0u
YW1pcnVsLm5hemxlLmFzbWFkZUBhbHRlcmEuY29tPg0KPj4NCj4+IEVuYWJsaW5nIHRoZSBSWCBC
dWZmZXIgVW5hdmFpbGFibGUgKFJCVUUpIGludGVycnVwdCBpcyBjb3VudGVycHJvZHVjdGl2ZQ0K
Pj4gYW5kIGNhbiB0cmlnZ2VyIGEgTUFDIGludGVycnVwdCBzdG9ybSB1bmRlciBoZWF2eSBSWCBw
cmVzc3VyZS4gV2hlbiB0aGUNCj4+IERNQSBydW5zIG91dCBvZiBSWCBkZXNjcmlwdG9ycyBpdCBm
aXJlcyBSQlVFIGNvbnRpbnVvdXNseSB1bnRpbCBzb2Z0d2FyZQ0KPj4gcmVmaWxscyB0aGUgcmlu
Zy4NCj4+DQo+PiBIb3dldmVyLCBSQlVFIGlzIHJlZHVuZGFudDogdGhlIG5vcm1hbCBSWCBjb21w
bGV0aW9uIGludGVycnVwdCAoUklFKQ0KPj4gYWxyZWFkeSB0cmlnZ2VycyBOQVBJLCB3aGljaCBw
cm9jZXNzZXMgY29tcGxldGVkIGRlc2NyaXB0b3JzIGFuZCByZWZpbGxzDQo+PiB0aGUgcmluZywg
Y2F1c2luZyB0aGUgRE1BIHRvIHJlc3VtZS4gVGhlIFJCVUUgaGFuZGxlciBpdHNlbGYgb25seSBz
ZXRzDQo+PiBoYW5kbGVfcnggLSB0aGUgc2FtZSBvdXRjb21lIGFzIFJJRS4NCj4+DQo+PiBSZW1v
dmUgUkJVRSBmcm9tIFhHTUFDX0RNQV9JTlRfREVGQVVMVF9FTiBhbmQgWEdNQUNfRE1BX0lOVF9E
RUZBVUxUX1JYDQo+PiB0byBwcmV2ZW50IHRoZSBpbnRlcnJ1cHQgc3Rvcm0gd2hpbGUga2VlcGlu
ZyBub3JtYWwgUlggaGFuZGxpbmcgaW50YWN0Lg0KPj4NCj4+IEZpeGVzOiBkNmRkZmFjZDk1Yzcg
KCJuZXQ6IHN0bW1hYzogQWRkIERNQSByZWxhdGVkIGNhbGxiYWNrcyBmb3IgWEdNQUMyIikNCj4+
IFNpZ25lZC1vZmYtYnk6IE5hemltIEFtaXJ1bCANCj4+IDxtdWhhbW1hZC5uYXppbS5hbWlydWwu
bmF6bGUuYXNtYWRlQGFsdGVyYS5jb20+DQo+IA0KPiBXZSBoYWQgYW4gb3Bwb3NpdGUgZGlzY3Vz
c2lvbiBhYm91dCBlbmFibGluZyByeCBidWYgdW5hdmFpbGFibGUNCj4gaW50ZXJydXB0cyBmb3Ig
b3RoZXIgRFdNQUMgdmVyc2lvbnMgOg0KPiANCj4gaHR0cHM6Ly9uYW0xMC5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/IA0KPiB1cmw9aHR0cHMlM0ElMkYlMkZsb3JlLmtlcm5lbC5v
cmclMkZuZXRkZXYlMkZFMXdCQmFSLTAwMDAwMDBHWkhSLTFkYk0lNDBybWstUEMuYXJtbGludXgu
b3JnLnVrJTJGJmRhdGE9MDUlN0MwMiU3Q211aGFtbWFkLm5hemltLmFtaXJ1bC5uYXpsZS5hc21h
ZGUlNDBhbHRlcmEuY29tJTdDYzNlMGEzNTk0Njk0NGI3Y2ViYzUwOGRlYmRiNzI5ZDElN0NmYmQ3
MmUwM2Q0YTU0MTEwYWRjZTYxNGQ1MWYyMDc3YSU3QzAlN0MwJTdDNjM5MTU2NzkxNTczMTM1MjE2
JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SkZiWEIwZVUxaGNHa2lPblJ5ZFdVc0lsWWlPaUl3
TGpBdU1EQXdNQ0lzSWxBaU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJbGRVSWpveWZRJTNE
JTNEJTdDMCU3QyU3QyU3QyZzZGF0YT16Z09kOURha0xBUCUyQkZJT0dTTFl4U3ZYZWpIeEZhZSUy
Qmhua3RkSDdUMVVVcyUzRCZyZXNlcnZlZD0wDQo+IA0KPiBXaGlsZSB5b3VyIHBhdGNoIG1ha2Vz
IHNlbnNlLCBJIHRoaW5rIGl0J3MgaW1wb3J0YW50IHRvIG5vdGUgdGhhdCBpdCdsbA0KPiBub3cg
bWFrZSB0aGUgInJ4X2J1Zl91bmF2X2lycSIgc3RhdCAodGhhdCB3ZSBjYW4gcXVlcnkgZnJvbSB1
c2Vyc3BhY2UpDQo+IHN0dWNrIGF0IDAgbm93Lg0KPiANCj4gVGhhdCdzIGEgdXNlci12aXNpYmxl
IGJlaGF2aW91ciBjaGFuZ2UsIGZvciBhIHN0YXQgdGhhdCBjYW4gYmUgdXNlZnVsLA0KPiBvbmUg
Y291bGQgY29uc2lkZXIgdGhhdCBhIHVBUEkgY2hhbmdlLi4uDQo+IA0KPiBEbyB5b3UgaGF2ZSBz
b21lIG51bWJlcnMgb24gdGhlIHBlcmYgaW1wYWN0IHlvdSBzZWUgd2hlbiBidWZmZXINCj4gc3Rh
cnZhdGlvbiBoaXRzIHRvIHNlZSB3aGF0IHdlIGFyZSBnYWluaW5nL2xvc2luZyBoZXJlID8NCj4g
DQo+IE1heGltZQ0KPiANCkhpIE1heGltZSwNCg0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3IGFu
ZCBmb3IgcG9pbnRpbmcgb3V0IHRoZSByeF9idWZfdW5hdl9pcnEgY29uY2Vybi4NCg0KV2UgZG8g
aGF2ZSBpbnRlcnJ1cHQgc3Rvcm0gZGF0YSB0byBzaGFyZS4gT24gQWdpbGV4NSwgdW5kZXIgaGVh
dnkgUlggDQpwcmVzc3VyZSB3ZSBvYnNlcnZlZDoNCg0KVW5kZXIgaGVhdnkgUlggcHJlc3N1cmUg
d2Ugb2JzZXJ2ZWQgZXRoMDptYWMgZmlyaW5nIDEsODIxLDgxMSw1NTUgdGltZXMgDQp2cyAyLDYx
OCw2MjcgYWN0dWFsIFJYIGNvbXBsZXRpb25zIG9uIGV0aDA6cngtMCDigJQgYSB+Njk1eCByYXRp
by4NCg0KQlIsDQpOYXppbQ0K

