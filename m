Return-Path: <netdev+bounces-279650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNQ9JUaW5WnrlgEAu9opvQ
	(envelope-from <netdev+bounces-279650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:58:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D2742675F
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BA61300C5AC
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A970337F73D;
	Mon, 20 Apr 2026 02:58:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2130.outbound.protection.partner.outlook.cn [139.219.17.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D237EFEE;
	Mon, 20 Apr 2026 02:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776653891; cv=fail; b=kBMr4D6J2tzoPK6kthZR3JoN3j8otDcxIRw+oea1Za/C/wIVwL4kHzALo61GMKRWpwysFeYUMBtKAFHT3NUMuNBzQaA6tAlweJmrBZE8q6fD1TPFdMP2njDsGD5cQaVlzJLN3vKnsAtbbHXwKuO3oG3GSV494QDmG/sPceOrnRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776653891; c=relaxed/simple;
	bh=iBNuzJ6YJzNm5fCtyeSyq9Um113rQMELQooPaOgzi4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p3XrwVJlqx64rrbVdPAxEmBqFZSEkRzaAsfmBBfesx9Sj+PtbtNz7ZWwwUISPNGB45aHuwWAdKwl/NLW6utQ4/1rR5Gs9daT3+rELvx/0OLJrofEYNIniSskIPlpapzotpP9awrOH6JL7OYNsparxzxk4Kkfoj5OTwMrYXbywA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0QJZc/q0qfdwvV04vI8FYUkQhdTdab2mxJVSWKlSYHBVeaT217B0a1a9zPfqIndrjOLIKwGlyK4qac1LlLqlZn63Qp50ZVW8bjNigVlsUHuCZdNM+5fahWDWFGvwN71swm40wsOOgLU6FiuM44+kjIry1jikbrAofn0fBt3XTNk+q8ncRhX7mhbutIOXKbP/k66yJRVHTTkF/FcUOyuklUC4cZ4NsHloiUGV+N+ewuLt2mS0cLhBOt3dDmphVOM7y1J/D9CYseFwe9sSTXjxX8eybPQfHZKQ2+sFfgS/4BdU2C4lsaLRVgnY9usQGB5uNB7GP0le4sfY/H8mgwJjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBNuzJ6YJzNm5fCtyeSyq9Um113rQMELQooPaOgzi4s=;
 b=HJqwAepPEQPdxp1QlURttpQSjIWpURhdE5ecfuemJ/kYBe+hPzTTg4OiWHRG5iE/813ZVrlC4zFQq/J3Bik3vRY2XqwDomSuJtz96qOfmdOSF+eb8Wb6z1rwRTrhNCFqWbWGmh/1MDaCrgJk/1fd6YSatAgYvbafXy5xrvRDaNIXdKbKqHK/jEs6wW8wxCSxEuJqLtzzLogAXq8MouvZDTnfD2eltDZLIf0WltJ3SayE68ruqrA1jXCHwMDaHJUIPL4paNxqtlDpXbnE3codU/u9Vda0EEa4OGiQ0WaoP9uIqXdARNEc/Uec4TqTumvrGljp7jKSTT19rijav/idnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0743.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.31; Mon, 20 Apr
 2026 02:25:57 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9769.046; Mon, 20 Apr 2026 02:25:57 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Sai Krishna Gajula <saikrishnag@marvell.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [net-next v2 4/5] net: stmmac: starfive: Add JHB100 SGMII
 interface
Thread-Topic: [net-next v2 4/5] net: stmmac: starfive: Add JHB100 SGMII
 interface
Thread-Index: AQHczhREyFyKF51uyk26f+F3lJwp8rXjh3CAgAO2cFA=
Date: Mon, 20 Apr 2026 02:25:56 +0000
Message-ID:
 <BJXPR01MB0855AAACC82F1485EC4582ABE62F2@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn>
References: <20260417024523.107786-1-minda.chen@starfivetech.com>
 <20260417024523.107786-5-minda.chen@starfivetech.com>
 <BYAPR18MB3735BA5A7D35AFFE8DF4BE67A0202@BYAPR18MB3735.namprd18.prod.outlook.com>
In-Reply-To:
 <BYAPR18MB3735BA5A7D35AFFE8DF4BE67A0202@BYAPR18MB3735.namprd18.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJXPR01MB0855:EE_|BJXPR01MB0743:EE_
x-ms-office365-filtering-correlation-id: 9ccdff0d-2a72-4216-2c77-08de9e842789
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|921020|38070700021|56012099003|18002099003;
x-microsoft-antispam-message-info:
 sPNS4lOHebYxxpLQ4DV/7HaQ4DPtymkefIfApEZEEASH86gio2D9jdQ9b4NVtpwFRsznT3TKX1H807dT7RmOzFgBdzXkhw0ggCqktCYMojagd/YslRoHoBYagppedNBIie4UdHuSHploXNvitOGStZkayTTAHykK9UlhCyF+0U8WBu3K6s3PVUixUGpmZM4FOsj70pNMYW33CoQT1pj5YVR5A4NpsJJ36NNbfL7HXC/F6Wnp2egLL3UXY0o6xc2+F3Fnnm4+hPI5rwSw1kFRC65muhkgsOnZwOnNGLSadx0a/XdRFDuXcDQJKu7YspdXgkhvh7Mb4OJ5t9y1wx3up1/pPIJypik1jkMXYqVfgK1769KsSf98rccOl4rd81cbQME0QWpe+xpIZrJxZeTzsmbNFJocgqguNo9YZHUX8e+jENbPIC5r8yDa+cJu8brNOokD/LMYdUBWFaJ+Jt9LSrvbm/Cx9DEu1c2AlLNOhd7ry5DK0dAMxorqtNMosK5aLkk5VBjPszBXH5Tc2aq2am661Io2uz/3ByO8bD9L2GGkaiCdnqwbxuO5/A1nIVeFhKhJTVgG6YEYx51xaSwuTYGR6UD448X8V6SGB731vK8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(921020)(38070700021)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?LzQ0UjluTCs1WWVJdDVPSTk2NGdTWm9KVUFhaGhPeHZITjJnRnVVSU12cUxN?=
 =?utf-8?B?eTByWFlZamtLdEViT3pMdzRrVUloa05KU3oyK0hITTEzbmdHRkZOUUlaN2lP?=
 =?utf-8?B?dGdFYzc3VHpaUWJNSG1lL243Rkp4ZlM2azJEd1h3cXJpQnVqeW1xQmh0Y000?=
 =?utf-8?B?QU9Bc2RIbHFSWXFjRFVpSTJ5R1hCLzNnSEV1Z3FDVWtwbjVmYTZJWEswMmFU?=
 =?utf-8?B?WDZPL1Z3NXd4ejRVMjI5WkYram5kQjlaMllUdkRnbWh5aFQwSDVCSjV1VE5E?=
 =?utf-8?B?eGFoTlBmU3RzMjNoMUkyUk9NZWtQS1pUQkVscHZhZEpyU0FqR010MXFpWnd5?=
 =?utf-8?B?ZEVYV2pDb0E4bHMrNVR5T1kzSnFHTEV5QjJsbm9ONzg3UFB6SXdSbDdHZktG?=
 =?utf-8?B?MVUyOTZoTUU0MmI4VmdodXJKaW04bzk1WnVWdDFwcWVQTi95MW9iR3NmT3pF?=
 =?utf-8?B?YmRZM0tXbkxocjdoQ1Nkak5NQ2RjeExrU0F3NjgvQkpQc1RHTktzL3c0Mzdj?=
 =?utf-8?B?WlB4d0t6TWF2ZmtUUWFTK0NIcmFuWWNFN0MvT25WNGg4Z3RRVEJhQXB3ckQw?=
 =?utf-8?B?MjBLdkFLRkFWajJVT1RpUTYxZEFPU3dGMndSNUtnMlV5S3VBZWttbjliTDgr?=
 =?utf-8?B?MmtBb0dWSEFtMGR3TVNESXJxTUtid3M2TnhIQ2tpbUpENlNadjRDNVpjVUpk?=
 =?utf-8?B?MG14VUpSN0x3S2Z5cVZPV2NQaVRyUkFHT0pRZGN5Tk95aE1sL1ZzQlBOOGMr?=
 =?utf-8?B?Nk5xTEdtZ2cwLzQvR0tJc2hkaUhGb0dsU3B0L3BDNnhFWWZSMUVPS0hQb3Bo?=
 =?utf-8?B?dnVhYWk4NmRnRmR0K0g1ZTZtTlBZeGlhaFNCMzNUYTEwNlUvYk9sTHJBZk96?=
 =?utf-8?B?dnF4UnhScnAvbE9iNjlVUGkrRFVhTDArLzNHdkR5UHVkdjhzQ2locDFzMXdP?=
 =?utf-8?B?MzlaK3NlUndiclVKOGxIaEEvNU52UDIvUHNSVG4wTHIzYnBaWUp3cmcxamZY?=
 =?utf-8?B?UUpzaU5iZzkzbTJoSjBLaWY1TlRCNnoxQ1hFRU9ESFFEL0tVeUk2N25ESXdv?=
 =?utf-8?B?MnYvSHhUR1RZTEdHOGlDakk1cU16cktGL0l0cjFJMDR1azMyMjBDYUlIdTNr?=
 =?utf-8?B?SGxkRHdMWjF3RTl6dHltTjBqV3R3WXB6WFBScjhvUDJlZDd6M0ZFMzVJdmRN?=
 =?utf-8?B?NHdTTGFkWkRQRC95UEwwdkw3TkFxK2xMNlNZeWs2QWZnREptNkNOTTNmU0dZ?=
 =?utf-8?B?Y21sTmFFbTQvQTJFbU5uNUVWVUgwaWhOUjNyUnBjL2xxaERMMkpiSEFGNmVh?=
 =?utf-8?B?Mk4yRnNYY2xqbDZzTFVORFRQL09vb2tsRkJSK1FRVFI5UFdZUUdKQzBxNmpp?=
 =?utf-8?B?bVN4OGpQNFpyTWNrK1lWV0taRjdHYk1pNmtUNno0VW1hQ2I0S0x2aWZ0REZp?=
 =?utf-8?B?UjExaUdQTHVxbmcrbWVyYzV2N2JPOExRM1NhU2dLdjcvQy91dUk2VHhqSUVN?=
 =?utf-8?B?WGlUdlpsQmZyZVMvZm54U2UxeFRKdFRubWhBRlpjWURvbXFIWHd0MkZOWFF2?=
 =?utf-8?B?TXFaQUxPVWpMeUg2eE44OEExWWZDMTFleW9lUURCc1hKbjFyUmczSXNZS2xv?=
 =?utf-8?B?S25mNEF1bVRpOFhORFB4bjYvSGVHa2xZc0tCYXdPN3haOStVK21QdFJjRWJy?=
 =?utf-8?B?Y09JSVJBSWxTV1hacGhsTUFzWFNVRUVwMEo4N09Md1N2em85ZkRucU5XSDdQ?=
 =?utf-8?B?ZTRXTWRWV0pkaWlhUEJneUYvd3gyaHRYb2N0TzNUSUE2M3VPZ1RRMXJ4RWVo?=
 =?utf-8?B?YXpTQTdsdUhJSHhHby9qODB4elEra0NaS1ZkdjFOekZYSGxEejJtTGg2UG02?=
 =?utf-8?B?RlpUaHg1QWhzQXJkblkxT1lGdnMxT00rS3NrSmMybHk5ZzYyY01BaXZhWU10?=
 =?utf-8?B?RmMzeGFodTNQeXBOYVJkY2ZJaEp0THlySzNKQjFzZFRoMFVvQ2RPcjRJcGxo?=
 =?utf-8?B?MzZscGVCYlU3MW1tZFk5M1huOFdNZHBDaUhwVHVsSW5kZHVXYjdUWlc5SXFv?=
 =?utf-8?B?MUVZN0tXdW1CMW5xQi9ZYUZ6OGxlMHBkb1lGODFpUVRsU2RmTVVNZmdJN0xy?=
 =?utf-8?B?RGxTZ1lzYkhGZGxzMXAwRysvRXU3WHJyeW5heGJBcXo2cmlLVXB5ZGZsSldK?=
 =?utf-8?B?bkcwN0kxU3pCWVNEcXVBR1pXM3RWWFU1amx1WlVLU3VCdTNINDAyYTZNWFpp?=
 =?utf-8?B?bGJPS3IyNCtqSm5xS2NRT241aUcxdUtVbGhIS0Q4ekllVy9HemNHOWZOaU42?=
 =?utf-8?B?TW12Q3o5L2hpcUZ6b2YydE82MExEQjJuRWU1VlA3dWNrcWNoRlhZQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccdff0d-2a72-4216-2c77-08de9e842789
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 02:25:56.8977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OFULlBVJa2uX77qOr7fJTv1Wm2ieqsEmDYabO+zMaRMFR/3DipVaS78WAqBHxOki7gs2dDjvTMgLW3Va8F4S6qi+E9/d1NA86FDg61IT1qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0743
X-Spamd-Result: default: False [3.64 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279650-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[marvell.com,foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,st-md:email,marvell.com:email,BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn:mid]
X-Rspamd-Queue-Id: E9D2742675F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogTWluZGEgQ2hl
biA8bWluZGEuY2hlbkBzdGFyZml2ZXRlY2guY29tPg0KPiA+IFNlbnQ6IEZyaWRheSwgQXByaWwg
MTcsIDIwMjYgODoxNSBBTQ0KPiA+IFRvOiBBbGV4YW5kcmUgVG9yZ3VlIDxhbGV4YW5kcmUudG9y
Z3VlQGZvc3Muc3QuY29tPjsgQW5kcmV3IEx1bm4NCj4gPiA8YW5kcmV3K25ldGRldkBsdW5uLmNo
PjsgRGF2aWQgUyAuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMNCj4gPiBEdW1h
emV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9y
Zz47IFBhb2xvDQo+ID4gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgTWF4aW1lIENvcXVlbGlu
DQo+ID4gPG1jb3F1ZWxpbi5zdG0zMkBnbWFpbC5jb20+OyBFbWlsIFJlbm5lciBCZXJ0aGluZw0K
PiA+IDxlbWlsLnJlbm5lci5iZXJ0aGluZ0BjYW5vbmljYWwuY29tPjsgUm9iIEhlcnJpbmcNCj4g
PiA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJu
ZWwub3JnPjsgQ29ub3INCj4gPiBEb29sZXkgPGNvbm9yQGtlcm5lbC5vcmc+OyBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnDQo+ID4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LXN0bTMyQHN0LW1kLQ0KPiA+IG1haWxtYW4uc3Rvcm1yZXBseS5jb207IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBNaW5kYSBDaGVuDQo+ID4gPG1pbmRhLmNoZW5Ac3RhcmZpdmV0ZWNoLmNv
bT4NCj4gPiBTdWJqZWN0OiBbbmV0LW5leHQgdjIgNC81XSBuZXQ6IHN0bW1hYzogc3RhcmZpdmU6
IEFkZCBKSEIxMDAgU0dNSUkNCj4gPiBpbnRlcmZhY2UNCj4gPg0KPiA+IEFkZCBKSEIxMDAgY29t
cGF0aWJsZSBhbmQgU0dNSUkgc3VwcG9ydC4gSkhCMTAwIHNvYyBjb250YWlucyAyIFNHTUlJDQo+
ID4gaW50ZXJmYWNlcyBhbmQgaW50ZWdyYXRlZCB3aXRoIHNlcmRlcyBQSFkuIFNHTUlJIHdpdGgg
c3BsaXQgVFgvUlggTUFDDQo+ID4gY2xvY2sgYW5kIG5lZWQgdG8gc2V0IDIu4oCKNU0vMjVNLzEy
NU0gVFgvUlggY2xvY2sgcmF0ZSBpbg0KPiA+IDEwTS8xMDBNLzEwMDBNIHNwZWVkIG1vZGUuIFNp
Z25lZC1vZmYtYnk6DQo+ID4gQWRkIEpIQjEwMCBjb21wYXRpYmxlIGFuZCBTR01JSSBzdXBwb3J0
LiBKSEIxMDAgc29jIGNvbnRhaW5zDQo+ID4gMiBTR01JSSBpbnRlcmZhY2VzIGFuZCBpbnRlZ3Jh
dGVkIHdpdGggc2VyZGVzIFBIWS4gU0dNSUkgd2l0aCBzcGxpdA0KPiA+IFRYL1JYIE1BQyBjbG9j
ayBhbmQgbmVlZCB0byBzZXQgMi41TS8yNU0vMTI1TSBUWC9SWCBjbG9jayByYXRlIGluDQo+ID4g
MTBNLzEwME0vMTAwME0gc3BlZWQgbW9kZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pbmRh
IENoZW4gPG1pbmRhLmNoZW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2V0
aGVybmV0L3N0bWljcm8vc3RtbWFjL2R3bWFjLXN0YXJmaXZlLmMgIHwgNTQNCj4gPiArKysrKysr
KysrKysrKy0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAxMiBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9z
dG1pY3JvL3N0bW1hYy9kd21hYy1zdGFyZml2ZS5jDQo+ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9zdG1pY3JvL3N0bW1hYy9kd21hYy1zdGFyZml2ZS5jDQo+ID4gaW5kZXggMTZiOTU1YTZkNzdi
Li45MTY5OGM3NjNkYWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3Rt
aWNyby9zdG1tYWMvZHdtYWMtc3RhcmZpdmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L3N0bWljcm8vc3RtbWFjL2R3bWFjLXN0YXJmaXZlLmMNCj4gPiBAQCAtMjYsNiArMjYsNyBA
QCBzdHJ1Y3Qgc3RhcmZpdmVfZHdtYWNfZGF0YSB7ICBzdHJ1Y3Qgc3RhcmZpdmVfZHdtYWMgew0K
PiA+ICAJc3RydWN0IGRldmljZSAqZGV2Ow0KPiA+ICAJY29uc3Qgc3RydWN0IHN0YXJmaXZlX2R3
bWFjX2RhdGEgKmRhdGE7DQo+ID4gKwlzdHJ1Y3QgY2xrICpzZ21paV9yeDsNCj4gPiAgfTsNCj4g
Pg0KPiA+ICBzdGF0aWMgaW50IHN0YXJmaXZlX2R3bWFjX3NldF9tb2RlKHN0cnVjdCBwbGF0X3N0
bW1hY2VuZXRfZGF0YQ0KPiA+ICpwbGF0X2RhdCkgQEAgLTY4LDYgKzY5LDI0IEBAIHN0YXRpYyBp
bnQNCj4gPiBzdGFyZml2ZV9kd21hY19zZXRfbW9kZShzdHJ1Y3QgcGxhdF9zdG1tYWNlbmV0X2Rh
dGEgKnBsYXRfZGF0KQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMg
aW50IHN0bW1hY19zdGFyZml2ZV9zZ21paV9zZXRfY2xrX3JhdGUodm9pZCAqYnNwX3ByaXYsIHN0
cnVjdA0KPiA+ICtjbGsNCj4gPiAqY2xrX3R4X2ksDQo+ID4gKwkJCQkJICAgICAgcGh5X2ludGVy
ZmFjZV90IGludGVyZmFjZSwgaW50DQo+ID4gc3BlZWQpIHsNCj4gDQo+IHBoeV9pbnRlcmZhY2Vf
dCBpbnRlcmZhY2UgaXMgbGlrZWx5IHVudXNlZCBpbiBzdG1tYWNfc3RhcmZpdmVfc2dtaWlfc2V0
X2Nsa19yYXRlDQo+IOKGkiBtYXkgbmVlZCBfX21heWJlX3VudXNlZCBvciAodm9pZClpbnRlcmZh
Y2UgdG8gYXZvaWQNCj4gLVdlcnJvcj11bnVzZWQtcGFyYW1ldGVyIG9uIHN0cmljdCBidWlsZHMu
DQo+IA0KT2theSAuIFRoYW5rcyBmb3IgcmV2aWV3IQ0KDQo+ID4gKwlzdHJ1Y3Qgc3RhcmZpdmVf
ZHdtYWMgKmR3bWFjID0gKHZvaWQgKilic3BfcHJpdjsNCj4gPiArCWxvbmcgcmF0ZSA9IHJnbWlp
X2Nsb2NrKHNwZWVkKTsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJLyogTUFDIGNsb2Nr
IHJhdGUgdGhlIHNhbWUgYXMgUkdNSUkgKi8NCj4gPiArCWlmIChyYXRlIDwgMCkNCj4gPiArCQly
ZXR1cm4gMDsNCj4gPiArDQo+ID4gKwlyZXQgPSBjbGtfc2V0X3JhdGUoY2xrX3R4X2ksIHJhdGUp
Ow0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCXJldHVy
biBjbGtfc2V0X3JhdGUoZHdtYWMtPnNnbWlpX3J4LCByYXRlKTsgfQ0KPiA+ICsNCj4gPiAgc3Rh
dGljIGludCBzdGFyZml2ZV9kd21hY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KSAgew0KPiA+ICAJc3RydWN0IHBsYXRfc3RtbWFjZW5ldF9kYXRhICpwbGF0X2RhdDsgQEAgLTEw
MiwyNCArMTIxLDM0IEBAIHN0YXRpYw0KPiA+IGludCBzdGFyZml2ZV9kd21hY19wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJCXJldHVybiBkZXZfZXJyX3Byb2JlKCZw
ZGV2LT5kZXYsIFBUUl9FUlIoY2xrX2d0eCksDQo+ID4gIAkJCQkgICAgICJlcnJvciBnZXR0aW5n
IGd0eCBjbG9ja1xuIik7DQo+ID4NCj4gPiAtCS8qIEdlbmVyYWxseSwgdGhlIHJnbWlpX3R4IGNs
b2NrIGlzIHByb3ZpZGVkIGJ5IHRoZSBpbnRlcm5hbCBjbG9jaywNCj4gPiAtCSAqIHdoaWNoIG5l
ZWRzIHRvIG1hdGNoIHRoZSBjb3JyZXNwb25kaW5nIGNsb2NrIGZyZXF1ZW5jeSBhY2NvcmRpbmcN
Cj4gPiAtCSAqIHRvIGRpZmZlcmVudCBzcGVlZHMuIElmIHRoZSByZ21paV90eCBjbG9jayBpcyBw
cm92aWRlZCBieSB0aGUNCj4gPiAtCSAqIGV4dGVybmFsIHJnbWlpX3J4aW4sIHRoZXJlIGlzIG5v
IG5lZWQgdG8gY29uZmlndXJlIHRoZSBjbG9jaw0KPiA+IC0JICogaW50ZXJuYWxseSwgYmVjYXVz
ZSByZ21paV9yeGluIHdpbGwgYmUgYWRhcHRpdmVseSBhZGp1c3RlZC4NCj4gPiAtCSAqLw0KPiA+
IC0JaWYgKCFkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKCZwZGV2LT5kZXYsICJzdGFyZml2ZSx0
eC11c2UtcmdtaWktDQo+ID4gY2xrIikpDQo+ID4gLQkJcGxhdF9kYXQtPnNldF9jbGtfdHhfcmF0
ZSA9IHN0bW1hY19zZXRfY2xrX3R4X3JhdGU7DQo+ID4gKwlpZiAocGxhdF9kYXQtPnBoeV9pbnRl
cmZhY2UgPT0gUEhZX0lOVEVSRkFDRV9NT0RFX1NHTUlJKSB7DQo+ID4gKwkJZHdtYWMtPnNnbWlp
X3J4ID0gZGV2bV9jbGtfZ2V0X2VuYWJsZWQoJnBkZXYtPmRldiwNCj4gPiAic2dtaWlfcngiKTsN
Cj4gPiArCQlpZiAoSVNfRVJSKGR3bWFjLT5zZ21paV9yeCkpDQo+ID4gKwkJCXJldHVybiBkZXZf
ZXJyX3Byb2JlKCZwZGV2LT5kZXYsDQo+ID4gKwkJCQkJICAgICBQVFJfRVJSKGR3bWFjLT5zZ21p
aV9yeCksDQo+ID4gKwkJCQkJICAgICAiZXJyb3IgZ2V0dGluZyBzZ21paSByeCBjbG9ja1xuIik7
DQo+ID4gKwkJcGxhdF9kYXQtPnNldF9jbGtfdHhfcmF0ZSA9DQo+ID4gc3RtbWFjX3N0YXJmaXZl
X3NnbWlpX3NldF9jbGtfcmF0ZTsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJLyoNCj4gPiArCQkg
KiBHZW5lcmFsbHksIHRoZSByZ21paV90eCBjbG9jayBpcyBwcm92aWRlZCBieSB0aGUgaW50ZXJu
YWwNCj4gPiBjbG9jaywNCj4gPiArCQkgKiB3aGljaCBuZWVkcyB0byBtYXRjaCB0aGUgY29ycmVz
cG9uZGluZyBjbG9jayBmcmVxdWVuY3kNCj4gPiBhY2NvcmRpbmcNCj4gPiArCQkgKiB0byBkaWZm
ZXJlbnQgc3BlZWRzLiBJZiB0aGUgcmdtaWlfdHggY2xvY2sgaXMgcHJvdmlkZWQgYnkgdGhlDQo+
ID4gKwkJICogZXh0ZXJuYWwgcmdtaWlfcnhpbiwgdGhlcmUgaXMgbm8gbmVlZCB0byBjb25maWd1
cmUgdGhlIGNsb2NrDQo+ID4gKwkJICogaW50ZXJuYWxseSwgYmVjYXVzZSByZ21paV9yeGluIHdp
bGwgYmUgYWRhcHRpdmVseSBhZGp1c3RlZC4NCj4gPiArCQkgKi8NCj4gPiArCQlpZiAoIWRldmlj
ZV9wcm9wZXJ0eV9yZWFkX2Jvb2woJnBkZXYtPmRldiwgInN0YXJmaXZlLHR4LXVzZS0NCj4gPiBy
Z21paS1jbGsiKSkNCj4gPiArCQkJcGxhdF9kYXQtPnNldF9jbGtfdHhfcmF0ZSA9IHN0bW1hY19z
ZXRfY2xrX3R4X3JhdGU7DQo+ID4gKw0KPiA+ICsJCWVyciA9IHN0YXJmaXZlX2R3bWFjX3NldF9t
b2RlKHBsYXRfZGF0KTsNCj4gPiArCQlpZiAoZXJyKQ0KPiA+ICsJCQlyZXR1cm4gZXJyOw0KPiA+
ICsJfQ0KPiA+DQo+ID4gIAlkd21hYy0+ZGV2ID0gJnBkZXYtPmRldjsNCj4gPiAgCXBsYXRfZGF0
LT5mbGFncyB8PSBTVE1NQUNfRkxBR19FTl9UWF9MUElfQ0xLX1BIWV9DQVA7DQo+ID4gIAlwbGF0
X2RhdC0+YnNwX3ByaXYgPSBkd21hYzsNCj4gPiAgCXBsYXRfZGF0LT5kbWFfY2ZnLT5kY2hlID0g
dHJ1ZTsNCj4gPg0KPiA+IC0JZXJyID0gc3RhcmZpdmVfZHdtYWNfc2V0X21vZGUocGxhdF9kYXQp
Ow0KPiA+IC0JaWYgKGVycikNCj4gPiAtCQlyZXR1cm4gZXJyOw0KPiA+IC0NCj4gPiAgCXJldHVy
biBzdG1tYWNfZHZyX3Byb2JlKCZwZGV2LT5kZXYsIHBsYXRfZGF0LCAmc3RtbWFjX3Jlcyk7ICB9
DQo+ID4NCj4gPiBAQCAtMTMwLDYgKzE1OSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc3RhcmZp
dmVfZHdtYWNfZGF0YQ0KPiA+IGpoNzEwMF9kYXRhID0geyAgc3RhdGljIGNvbnN0IHN0cnVjdCBv
Zl9kZXZpY2VfaWQgc3RhcmZpdmVfZHdtYWNfbWF0Y2hbXSA9IHsNCj4gPiAgCXsgLmNvbXBhdGli
bGUgPSAic3RhcmZpdmUsamg3MTAwLWR3bWFjIiwgLmRhdGEgPSAmamg3MTAwX2RhdGEgfSwNCj4g
PiAgCXsgLmNvbXBhdGlibGUgPSAic3RhcmZpdmUsamg3MTEwLWR3bWFjIiB9LA0KPiA+ICsJeyAu
Y29tcGF0aWJsZSA9ICJzdGFyZml2ZSxqaGIxMDAtZHdtYWMiIH0sDQo+ID4gIAl7IC8qIHNlbnRp
bmVsICovIH0NCj4gPiAgfTsNCj4gPiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgc3RhcmZpdmVf
ZHdtYWNfbWF0Y2gpOw0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCj4gUmV2aWV3ZWQtYnk6IFNh
aSBLcmlzaG5hIDxzYWlrcmlzaG5hZ0BtYXJ2ZWxsLmNvbT4NCg==

