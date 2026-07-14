Return-Path: <netdev+bounces-307310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SPtpMAWWVWrqqQAAu9opvQ
	(envelope-from <netdev+bounces-307310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 03:51:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A80C97502D4
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 03:51:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=NUs2tltJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307310-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307310-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 707E5300A254
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 01:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4998A370ACC;
	Tue, 14 Jul 2026 01:50:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012019.outbound.protection.outlook.com [40.107.200.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F9035F191;
	Tue, 14 Jul 2026 01:50:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993856; cv=fail; b=U2/JX5gHR7dgArP5tABaSqtJXNGhjsgnsUtikw969BwdVXCbDaWa9mgvp2htGcrz6PehqdzN6wubuil0fEmnDh/rZ5EJKtq7xQKTa1wfhlgxNOeXKRHs742IjaObv/l2Vr1LmP1FIMANkWfp5TgnaJEhiDIBCrYFmgdSn8RFZHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993856; c=relaxed/simple;
	bh=dXuFkpWNPCfI/uZgSy+KIcPJLPw2kPLOu+gWqjYtPfE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wl/VN5A4dzYmVm1xe33Sr5o7aOy7mVhAyQiqWbg898eYHK9svKZADI0851MG44PGxWSVhc2sP0OLYXZS5mFFH3URSj64kbtV1yoZVc+4rgtuUexTHt8Wyu4r8qtrE35Y6XkBwebyp8QlZPMejE9Z2BSZCyI2Hvfc45cO1A0qqnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=NUs2tltJ; arc=fail smtp.client-ip=40.107.200.19
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPFC45gxkieeOpyDsv6chHBi+UpDdF9kUcDO7F6upc94v1zwE0WC5eTRr+otXr0T5udmby8fyFsZKqdNYRrZZ99Hgz0Z2sjE4bRsydg92eWi2laLhiFHvdSVq52gu7wAbrf8E5TPp94g8KlypJrhtmP9+zNyD316XX85AgpczQ0N7DHynYQFLtXq/72OSGN2Fy7N/S651qulrcV5EsU/bBzqi+ixKtE8ywte3cppsyBk/xP9mKXWHNJdMlETSpS48IhnFdohSLlev9cfQ3oWCVvBx2iyYDBorByJHJxqmly65y1B4+oIZu5yHjkeHRCqtTWHAJ45UGnn2bJ/cbTSbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXuFkpWNPCfI/uZgSy+KIcPJLPw2kPLOu+gWqjYtPfE=;
 b=akmy/oeZjafp8VOyKE91gMPuC3rdlPTcARBq1WEzcjW/NwqeBbCX5coCgj8PpSF0q322x/3XAT1sgzvrx5eYsnKbfz7Fa9KXR+53vvMpC+w8EBrtniJHkn2W2s2nVPk6ko0wj/kvbLt/YGJ0M83MA+s/AklyoXUbxPanmBJh+09CGOv3ftVmsTBa8md5d1GzPh+w8yJe+Pa6IsZjPCnp9qHwWADr8KPq4GwkkKZd3sw/L0fhX9/ezyNkxP5/A5TpGXIxHuRHvqt9lt4Hr6jgqEnzhRRG7ttx1YM8trRMURjtI2bYEFEY7BQPti2FvpyOxlQJyEH3A9/SNQBQzP8CFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXuFkpWNPCfI/uZgSy+KIcPJLPw2kPLOu+gWqjYtPfE=;
 b=NUs2tltJmppTKp52irEz768wVGYjooQQHCmKYLuNwdBy43OtordmArvTYhCc+MAvC0Uz7eMpyFGkeJRdhAjGIhLZH9EmKZOHFog1hdRLmdUO9a12TXQr+ddv6NQ5VLW4ppvK+SsvMwwWipF0e0JQJgVAbMyAZwHPQ/PC00vMdPovGX9D2t2feDAXOIOtp28AF6aulJkY4GIxR27egBR1sK6gJJ0r8U6Z7dRCe1HhJfhJDy7aZ76wcz48LBPg/+T3pKoD+hQrrn6wlxLCe3BcQXMoDam8enoC8Izg7RgiKuXrH18RpUk93UYR3BuBYaXyGeSUWeM8ajJq3ldrTrBnAQ==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by LV8PR03MB8162.namprd03.prod.outlook.com (2603:10b6:408:297::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 01:50:51 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 01:50:51 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"Jose.Abreu@synopsys.com" <Jose.Abreu@synopsys.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] net: stmmac: fix l3l4 filter rejecting unsupported
 offload requests
Thread-Topic: [PATCH v3 2/3] net: stmmac: fix l3l4 filter rejecting
 unsupported offload requests
Thread-Index: AQHdCId6Wj9ZvtWAUE2zYCIZF+m9K7ZsVVgA
Date: Tue, 14 Jul 2026 01:50:50 +0000
Message-ID: <35415c60-4db1-4ccd-9b38-3828fa220808@altera.com>
References:
 <20260630115622.9426-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630115622.9426-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
In-Reply-To:
 <20260630115622.9426-3-muhammad.nazim.amirul.nazle.asmade@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|LV8PR03MB8162:EE_
x-ms-office365-filtering-correlation-id: a4997650-7a2e-4493-54e5-08dee14a5589
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|3023799007|18002099003|6133799003|56012099006|4143699003|11063799006|22082099003|55112099003|38070700021;
x-microsoft-antispam-message-info:
 7Wv5T4DVEJPyqjB1CwLxT9uavygIdwnNd9bfQVyRBGZ3pBlZD0Wu6kKuFAk42PDtMwHxWQ0jAdALpxJYYkBLQ9kiJG05XJq5BUPOuxNxsUKNr5+Uf5qfgFTvODz598R12txaF3SNp6+nid/vI5NLYwIm3sKTwBjT6sKhR45Bl0itNrZ6AHLWSmcCb3PJRSyztGfV6WMl18Lx0/bZtgJ44OYM2wgw37qDGbrB5egbJYKAvX8z6EDWcIZyjopjnVIb/pLUX75+JSPTeYUO2cSMQcP76QpE5VxD//YqlwF/uKzpLz5WKwqM9qjOJQI90GC0toiUCcG+3TBIQFJRUJvMZvGGhCfWyweD95qH0jcIFnENGTFGGlR2mOLXLdJoP21kAdRuc/R+/xEBx0NuZPCwSkyP0eq6/mVJKrqs4Q6/utoWKvo/xrTp2pX9EoV457ysycTZU1CMTzuggSbUui68EpD5Sjue2l1FVqzwpXNa6JEpfBZMG4jm3vVzXGN9ttDo311n6j9NVtEaRr5NmIRASdi7+C5B+5pP6Z6gTrXT9qbBC9FF6ikjgcUxccNH8PbVshhg4/Y9FP8Y9Y9+QxjCacNj7TMlyk6fRee9BDLNOjwAXzYTbSexyGl9ur+a0BfK7rrBuQsfP6bdTM5D3kf0oLX4YK9o3l0ztYgUIV/PgD/MmXHtg4m41YxnMQjj0gxSkkjb+Uu/D43UodKeAgusIPmS9PWfi+07qpAyu6buORg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(3023799007)(18002099003)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(55112099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TW9Wc0p5RVFyVS85Vkx6a1MrMVd5eDBMazdqaU10TnJCbHhNQ05Ia1dYQWhY?=
 =?utf-8?B?UUlsQTlWZ2psdHpqZitHRE93VlE5dGlub0NOUDRPQkdldlVlRUxHOEFyYmtL?=
 =?utf-8?B?aHd2NmhMeUZCUlVZeDVnS0czNGdnM0luRjJrUmlOc21Temkya0xGQUV1K1FL?=
 =?utf-8?B?U0oycnM3WkpEVEJ3aHdkM0VjUHRweTRTb2d2N1B0VXJLSnc2aFFnQURPbHp1?=
 =?utf-8?B?c29zak1MMjVCV1JwbFU4cm12SHlCREdJK1I4RFZqYzV5M3U0bEtEUzFzUnpm?=
 =?utf-8?B?NjRWOUI5Mi9RcnU3VU41eWpMWmdRdUV3SHAvK0RXU0s1NmVNNlAySXJHV05R?=
 =?utf-8?B?SHNhTlR0S1o1WnVLVUE4d1FjN3FJTTVXVHkzMzM3NjVFL0NZek90QmxNQW5n?=
 =?utf-8?B?QTVjRlVSUS9zQUIzOUdxN2ZJcGhudXQ3ZUVjV2QyVEUxbXhWalB5OGE3WU9D?=
 =?utf-8?B?LzJiUDVWYm9LQUxQZWY2aEIwcnB6ZW9OdHViV05RQUdkYVk2NDdFeDdwL1B3?=
 =?utf-8?B?VDlnNkxTNjlRTStnZWdGakR1cUFSY29TeXJ6WVp2cFducy9zRTdPdEsyTklq?=
 =?utf-8?B?NzJpdEYwTzFiRUlKdVFiMHdoYWFFbUptVWFzekhTZW5SU0gwbnJMQittL1hR?=
 =?utf-8?B?WXN0dXJxOHF1bnpYMWhzWWdieDVEQldsc01PODdNaW1qU0JyRWVORWRkWHV0?=
 =?utf-8?B?YzcvS1BYT2pHdGFSREJqcVBpeG41aGMxUVJNSE5Hb1JvMHVSUko4M2UzR295?=
 =?utf-8?B?Zm02QXhvWFZWbDFodHVSYWVlays5Tk95RUYzcWk3bHh4SzNMNEE3TWExMG5y?=
 =?utf-8?B?enovRHovNkM0eWhUUXBQMmxEaWJLQmZMaTNsVElSQ2VwMVJIS0VUTldZMDdK?=
 =?utf-8?B?WDJNd1EzNHVtSFp6Zi90NkJ4YjdMUzdwMDlhVk9NemdmWXRhRUEyNVF3SHVZ?=
 =?utf-8?B?Z1Z4M1o1OTVlZ09GN1lGY3JCM3FDTnEvWTVoL0Z5RVJKekwxcTFpakVOK21R?=
 =?utf-8?B?KzVnbWhTbXFYSjlRWmk5TVpWM3lQQmRSbURQNWFINDVpY21TNXBvR3NLR0h6?=
 =?utf-8?B?WnZyNUtFckhYejRsWkY2L1ZsQXVZVytkemJackJ6azhMVnJlL0VydFlyajJ2?=
 =?utf-8?B?S0tleEVtVXBkbUxkQ2lGQlhwaE1sOS9rMFpLMGN2NHdWN3ZJcjZYVGRYUG1a?=
 =?utf-8?B?Nk1ScjFybEZTUnE0cGc0QzRoNTJHazhmcmc2TlR5bU9OelFVZythWS9kQnZt?=
 =?utf-8?B?enFvRlFQTS9MUmNTOEppYlNVRytqVjJORGllMlh2NVRQR1dLRklLVkRzTHF2?=
 =?utf-8?B?Rk1kN0RmbHllOUdlb0tQcEJ6cldQM1QyT1FkMzV2b3NOVVVHc3pRRWlVTXFL?=
 =?utf-8?B?b2FjNzJQRWxHR0ltZkF0QU9CVDhFU0JpaFpaNmNyd082NHVodmJMTElNcjJ3?=
 =?utf-8?B?cU42N1I2V29TOS9rME5FSVJHRTZ2VnVPRDZCYldNVTRBRE9hNGhuejByTDgz?=
 =?utf-8?B?QUQ3QVUyZzR0bGp4YUl0RkkvdE1PZVpQWEVRZXVpOGZqcU02Q2xINStJMHdo?=
 =?utf-8?B?RHhsR1k5WTljY3VuYjIyLzVTTUNTaHZKRnpndTF2WGI3emFHQ2ZrdkVrdjI2?=
 =?utf-8?B?WDlaY2I1OWRwbWRPRkNqZ3phMjhZQ28xQlJrNHpKaUtFeXl0c2x4V0pCUGQ0?=
 =?utf-8?B?c2pwSllndXpCY1VDczB2WVJBMXVQOEFGVXVJMnZuK1lWdnorQkQ0M1g0cFFr?=
 =?utf-8?B?dW1xV1FzY3d0M04zaGNYc3hNQy95cDRKemxhTnBHOUg5UmFvN2FjN0NLODM4?=
 =?utf-8?B?WTQ1ZDNqT0xNbDA3TkNnc1ZnblB0dmc1NWJ4TkFtclRCRUFaNTZhcmJ1ZjZM?=
 =?utf-8?B?VmVKRWdKK3g1djVwTTVzdlZmNjhpckVUYUNtMGhrTm1vUVBSU1RqZzBkRCsz?=
 =?utf-8?B?SmRIZWVsY0thS0NwN2hPc2thQXFxbFlIa04vTUp2MXZhZTFuZVk3SUZkV2Nk?=
 =?utf-8?B?QlpMSlcvOU5heGQ0T1dpZEJVbnRuSXBRaUtUMnlkMzBIK2xFZjU3V0EyNFB6?=
 =?utf-8?B?a1MycDEwOFhpOTZ0OUN4YnM2bUh1bEJaaEhwR1I0M1FkSUJBdXIwR0MrK24y?=
 =?utf-8?B?THFPc0xKQjVJWkNmWU1WckRGdzJPa1RlaGZ2NDdiZitTWFpmSzlGcFd5ZXdL?=
 =?utf-8?B?WkN6OGxUSWVNdFEybDVNMmtUMytzNW90dEErTm95clJnTSs4VzlNZ2VOd0sy?=
 =?utf-8?B?WGNzYk9Pek10Z0FiNlRjQmFka1NzTlpoZ1ZQVXYrZFZQb0wvTDI3YmJvSUFm?=
 =?utf-8?B?RmJ0UmRqSmNFSHZvMW9GOWtmNy9IenVDVTh2eGdYOXJ2QWN3OUlDTXhzQUFp?=
 =?utf-8?Q?mjYcCu42h4Vt8VvQelc0zeqQFN/XPbvaGiUheKeBhgw3n?=
x-ms-exchange-antispam-messagedata-1: dXKhpdhT23Lyzw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <289C804834074C489BDB0781A68CF188@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a4997650-7a2e-4493-54e5-08dee14a5589
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 01:50:51.1558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QT8cvH818iVS2i/nQHPp/iytffWv5rLHgcfJShYC3Wk7MuLIp5JCaQk5My0vOJez0E06iFYDDm4qVb/Kpx4UWov6jCCPgb4Vl/Owe/WUWFyIY6cE6m1rLrOAUArE5jBDW+OhaszlXLIkVCWgYFfNtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB8162
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307310-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A80C97502D4

T24gMzAvNi8yMDI2IDc6NTYgcG0sIE5hemxlIEFzbWFkZSwgTXVoYW1tYWQgTmF6aW0gQW1pcnVs
IHdyb3RlOg0KDQpIaSwNCg0KZG8gd2UgaGF2ZSBhbnkgdXBkYXRlIG9uIHRoaXMgcGF0Y2ggc3Rh
dHVzIHRvIGdvIGluPw0KDQpCUiwNCk5hemltDQo+IEZyb206IE5hemltIEFtaXJ1bCA8bXVoYW1t
YWQubmF6aW0uYW1pcnVsLm5hemxlLmFzbWFkZUBhbHRlcmEuY29tPg0KPiANCj4gVGhlIGJhc2lj
IGZsb3cgcGFyc2VyIGluIHRjX2FkZF9iYXNpY19mbG93KCkgZG9lcyBub3QgdmFsaWRhdGUgbWF0
Y2gNCj4ga2V5cyBiZWZvcmUgcHJvY2VlZGluZy4gVW5zdXBwb3J0ZWQgb2ZmbG9hZCBjb25maWd1
cmF0aW9ucyBzdWNoIGFzDQo+IHBhcnRpYWwgcHJvdG9jb2wgbWFza3MsIG5vbi1JUHY0IG5ldHdv
cmsgcHJvdG8sIG9yIG5vbi1UQ1AvVURQIHRyYW5zcG9ydA0KPiBwcm90byBhcmUgc2lsZW50bHkg
YWNjZXB0ZWQgaW5zdGVhZCBvZiByZXR1cm5pbmcgLUVPUE5PVFNVUFAuDQo+IA0KPiBBZGQgdmFs
aWRhdGlvbiB0byByZXR1cm4gLUVPUE5PVFNVUFAgZWFybHkgZm9yOg0KPiAtIE5vIG5ldHdvcmsg
b3IgdHJhbnNwb3J0IHByb3RvIHByZXNlbnQgaW4gdGhlIGtleQ0KPiAtIFBhcnRpYWwgcHJvdG9j
b2wgbWFzayAob25seSBmdWxsIG1hc2sgc3VwcG9ydGVkKQ0KPiAtIE5ldHdvcmsgcHJvdG8gaXMg
bm90IElQdjQNCj4gLSBUcmFuc3BvcnQgcHJvdG8gaXMgbm90IFRDUCBvciBVRFANCj4gDQo+IEVh
Y2ggcmVqZWN0aW9uIGluY2x1ZGVzIGFuIGV4dGFjayBtZXNzYWdlIHNvIHRoZSB1c2VyIGtub3dz
IHdoaWNoIHBhcnQNCj4gb2YgdGhlIG1hdGNoIGlzIHVuc3VwcG9ydGVkLg0KPiANCj4gQWxzbyBw
cm9wYWdhdGUgLUVPUE5PVFNVUFAgZnJvbSB0Y19hZGRfYmFzaWNfZmxvdygpIGluIHRjX2FkZF9m
bG93KCkNCj4gYnkgcmV0dXJuaW5nIGl0IGRpcmVjdGx5IHJhdGhlciB0aGFuIHVzaW5nIGJyZWFr
LiBUaGUgYnJlYWsgd2FzIHNpbGVudGx5DQo+IGRpc2NhcmRpbmcgdGhlIGVycm9yIGZvciBGTE9X
X0NMU19SRVBMQUNFIG9wZXJhdGlvbnMgd2hlcmUgZW50cnktPmluX3VzZQ0KPiBpcyBhbHJlYWR5
IHRydWUsIGNhdXNpbmcgdGNfYWRkX2Zsb3coKSB0byByZXR1cm4gMCAoc3VjY2VzcykgZm9yDQo+
IHVuc3VwcG9ydGVkIHJlcGxhY2UgcmVxdWVzdHMuDQo+IA0KPiBGaXhlczogNDI1ZWFiZGRhZjBm
ICgibmV0OiBzdG1tYWM6IEltcGxlbWVudCBMMy9MNCBGaWx0ZXJzIHVzaW5nIFRDIEZsb3dlciIp
DQo+IFNpZ25lZC1vZmYtYnk6IFJvaGFuIEcgVGhvbWFzIDxyb2hhbi5nLnRob21hc0BhbHRlcmEu
Y29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBOYXppbSBBbWlydWwgPG11aGFtbWFkLm5hemltLmFtaXJ1
bC5uYXpsZS5hc21hZGVAYWx0ZXJhLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjM6DQo+IC0g
QWRkIGV4dGFjayBtZXNzYWdlcyB0byBlYWNoIC1FT1BOT1RTVVBQIHJldHVybiBzbyB1c2VycyBr
bm93IHdoaWNoDQo+ICAgIHBhcnQgb2YgdGhlIG1hdGNoIGlzIHVuc3VwcG9ydGVkIChKYWt1YiBL
aWNpbnNraSkNCj4gLSBSZXR1cm4gLUVPUE5PVFNVUFAgZGlyZWN0bHkgaW5zdGVhZCBvZiBicmVh
ayB0byBhdm9pZCBzaWxlbnRseQ0KPiAgICByZXBvcnRpbmcgc3VjY2VzcyBvbiB1bnN1cHBvcnRl
ZCBGTE9XX0NMU19SRVBMQUNFIChTYXNoaWtvIHJldmlldykNCj4gLSBQYXRjaGVzIDEvMyBhbmQg
My8zIGFyZSB1bmNoYW5nZWQgZnJvbSB2Mg0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBObyBj
aGFuZ2VzDQo+IA0KPiAtLS0NCj4gICAuLi4vbmV0L2V0aGVybmV0L3N0bWljcm8vc3RtbWFjL3N0
bW1hY190Yy5jICAgfCAzNCArKysrKysrKysrKysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDM0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9zdG1pY3JvL3N0bW1hYy9zdG1tYWNfdGMuYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWlj
cm8vc3RtbWFjL3N0bW1hY190Yy5jDQo+IGluZGV4IGQ3ODY1MjcxODU5OS4uMTRjYWJlNzZlNTNl
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1t
YWNfdGMuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9zdG1t
YWNfdGMuYw0KPiBAQCAtNDQ2LDYgKzQ0Niw3IEBAIHN0YXRpYyBpbnQgdGNfcGFyc2VfZmxvd19h
Y3Rpb25zKHN0cnVjdCBzdG1tYWNfcHJpdiAqcHJpdiwNCj4gICB9DQo+ICAgDQo+ICAgI2RlZmlu
ZSBFVEhFUl9UWVBFX0ZVTExfTUFTSwljcHVfdG9fYmUxNih+MCkNCj4gKyNkZWZpbmUgSVBfUFJP
VE9fRlVMTF9NQVNLCTB4RkYNCj4gICANCj4gICBzdGF0aWMgaW50IHRjX2FkZF9iYXNpY19mbG93
KHN0cnVjdCBzdG1tYWNfcHJpdiAqcHJpdiwNCj4gICAJCQkgICAgIHN0cnVjdCBmbG93X2Nsc19v
ZmZsb2FkICpjbHMsDQo+IEBAIC00NjEsNiArNDYyLDMzIEBAIHN0YXRpYyBpbnQgdGNfYWRkX2Jh
c2ljX2Zsb3coc3RydWN0IHN0bW1hY19wcml2ICpwcml2LA0KPiAgIA0KPiAgIAlmbG93X3J1bGVf
bWF0Y2hfYmFzaWMocnVsZSwgJm1hdGNoKTsNCj4gICANCj4gKwkvKiBCb3RoIG5ldHdvcmsgcHJv
dG8gYW5kIHRyYW5zcG9ydCBwcm90byBub3QgcHJlc2VudCBpbiB0aGUga2V5ICovDQo+ICsJaWYg
KCFtYXRjaC5tYXNrIHx8ICEobWF0Y2gubWFzay0+bl9wcm90byB8fCBtYXRjaC5tYXNrLT5pcF9w
cm90bykpIHsNCj4gKwkJTkxfU0VUX0VSUl9NU0dfTU9EKGNscy0+Y29tbW9uLmV4dGFjaywNCj4g
KwkJCQkgICAiZmlsdGVyIG11c3Qgc3BlY2lmeSBuZXR3b3JrIG9yIHRyYW5zcG9ydCBwcm90b2Nv
bCIpOw0KPiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ICsJfQ0KPiArDQo+ICsJLyogSWYgdGhl
IHByb3RvIGlzIHByZXNlbnQgaW4gdGhlIGtleSBhbmQgaXMgbm90IGZ1bGwgbWFzayAqLw0KPiAr
CWlmICgobWF0Y2gubWFzay0+bl9wcm90byAmJiBtYXRjaC5tYXNrLT5uX3Byb3RvICE9IEVUSEVS
X1RZUEVfRlVMTF9NQVNLKSB8fA0KPiArCSAgICAobWF0Y2gubWFzay0+aXBfcHJvdG8gJiYgbWF0
Y2gubWFzay0+aXBfcHJvdG8gIT0gSVBfUFJPVE9fRlVMTF9NQVNLKSkgew0KPiArCQlOTF9TRVRf
RVJSX01TR19NT0QoY2xzLT5jb21tb24uZXh0YWNrLA0KPiArCQkJCSAgICJvbmx5IGZ1bGwgcHJv
dG9jb2wgbWFzayBpcyBzdXBwb3J0ZWQiKTsNCj4gKwkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiAr
CX0NCj4gKw0KPiArCS8qIE5ldHdvcmsgcHJvdG8gaXMgcHJlc2VudCBpbiB0aGUga2V5IGFuZCBp
cyBub3QgSVB2NCAqLw0KPiArCWlmIChtYXRjaC5tYXNrLT5uX3Byb3RvICYmIG1hdGNoLmtleS0+
bl9wcm90byAhPSBjcHVfdG9fYmUxNihFVEhfUF9JUCkpIHsNCj4gKwkJTkxfU0VUX0VSUl9NU0df
TU9EKGNscy0+Y29tbW9uLmV4dGFjaywNCj4gKwkJCQkgICAib25seSBJUHY0IG5ldHdvcmsgcHJv
dG9jb2wgaXMgc3VwcG9ydGVkIik7DQo+ICsJCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gKwl9DQo+
ICsNCj4gKwkvKiBUcmFuc3BvcnQgcHJvdG8gaXMgcHJlc2VudCBpbiB0aGUga2V5IGFuZCBpcyBu
b3QgVENQIG9yIFVEUCAqLw0KPiArCWlmIChtYXRjaC5tYXNrLT5pcF9wcm90byAmJg0KPiArCSAg
ICBtYXRjaC5rZXktPmlwX3Byb3RvICE9IElQUFJPVE9fVENQICYmDQo+ICsJICAgIG1hdGNoLmtl
eS0+aXBfcHJvdG8gIT0gSVBQUk9UT19VRFApIHsNCj4gKwkJTkxfU0VUX0VSUl9NU0dfTU9EKGNs
cy0+Y29tbW9uLmV4dGFjaywNCj4gKwkJCQkgICAib25seSBUQ1AgYW5kIFVEUCB0cmFuc3BvcnQg
cHJvdG9jb2xzIGFyZSBzdXBwb3J0ZWQiKTsNCj4gKwkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPiAr
CX0NCj4gKw0KPiAgIAllbnRyeS0+aXBfcHJvdG8gPSBtYXRjaC5rZXktPmlwX3Byb3RvOw0KPiAg
IAlyZXR1cm4gMDsNCj4gICB9DQo+IEBAIC01OTgsMTEgKzYyNiw3IEBAIHN0YXRpYyBpbnQgdGNf
YWRkX2Zsb3coc3RydWN0IHN0bW1hY19wcml2ICpwcml2LA0KPiAgIAkJcmV0ID0gdGNfZmxvd19w
YXJzZXJzW2ldLmZuKHByaXYsIGNscywgZW50cnkpOw0KPiAgIAkJaWYgKCFyZXQpDQo+ICAgCQkJ
ZW50cnktPmluX3VzZSA9IHRydWU7DQo+IC0JCWVsc2UgaWYgKHJldCA9PSAtRU9QTk9UU1VQUCkN
Cj4gLQkJCS8qIFRoZSBiYXNpYyBmbG93IHBhcnNlciB3aWxsIHJldHVybiBFT1BOT1RTVVBQLCBp
ZiBhDQo+IC0JCQkgKiByZXF1ZXN0ZWQgb2ZmbG9hZCBub3QgZnVsbHkgc3VwcG9ydGVkIGJ5IHRo
ZSBody4gQW5kDQo+IC0JCQkgKiBpbiB0aGF0IGNhc2UgZmFpbCBlYXJseS4NCj4gLQkJCSAqLw0K
PiAtCQkJYnJlYWs7DQo+ICsJCWVsc2UgaWYgKHJldCA9PSAtRU9QTk9UU1VQUCkNCj4gKwkJCXJl
dHVybiByZXQ7DQo+ICAgCX0NCj4gICANCj4gICAJaWYgKCFlbnRyeS0+aW5fdXNlKQ0KDQo=

