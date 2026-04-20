Return-Path: <netdev+bounces-279840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E2UFhxI5mnSuAEAu9opvQ
	(envelope-from <netdev+bounces-279840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:37:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8269342E668
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CC0035D0068
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F782E11C7;
	Mon, 20 Apr 2026 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="ygsXutdw"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EEA20B80B;
	Mon, 20 Apr 2026 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696595; cv=fail; b=gw1YoO8Lhtf4YyUjXbaZQK/rf2x0Z3sL9HeWCex1EztffoGqPw9jCeZmvb0qs8SMnlVu4sG0XwENNTQDZ/wgjDnk/J6paKU9vxa327jhKdhFrZ4Ve6GhRmBfEoLHygOL4MhJOsmoDSnfAvk0yl1gkqeIg7v3w6J0QBOqgcS37DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696595; c=relaxed/simple;
	bh=juQhCl2D00VzZ9tc+4WDMuvFoiUYo/uincxGKZq0S0U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uw1CKguBDvo1r6UF7a6xXFa4uj+4VfrMAwbHQvG+8kYLp3VUTQTwtwPRv89I9xdKIfIaNuVkz4vtfe/AnBLtJpypSc9+PlBk5HGH2iTZAc3uIugkNvjSvM/wVqFMrNXTJV9ZGqruWiGyUU2tSsX1of8QHIcllM6h4/yOfO5g06s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=ygsXutdw; arc=fail smtp.client-ip=52.101.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haDY8Tuip/qki6viFv/b5BYeLVLxZrc5R8IlN9rivktB+/Stu14gls0/I5rr9rEFCr+GcrJVLC/CHHl20SHuyXrp07BpZTORa9rY/n8NEGsCDS21NSQn94GlpC+nvalL+CVp4X8GtLRv3zx09jfwHX5moN+kt2mrADDgsmlF4vssFwmZbxzqb4svaGIDdM3vRMaihPrSLMifkXnPyYoykQ8nZOdRYYg7UwPgncJgkPnmllhITPk638cer8e42YPWkdZUQGgLWVATVlbyyBc4LX/bLy/ANye07xlm/ZDT+73SdPjGwB8A6yNDZKmyaHMcjgZ9qKawT+P511ACAqZh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juQhCl2D00VzZ9tc+4WDMuvFoiUYo/uincxGKZq0S0U=;
 b=y6fj6uMSpLzEoHIl9ikPlyxSLxknD1zWWLfB8eBuIVPzBDdmBbozdyATTyb7KEdHZLFIjmxJSPfbwwMt8O0pOFrMT7U8Eh0e/Ye708PFk7IKYIt03bv6hvKJe+rR1KF3RtSZcRr+CcSh560Xfq0tqdtqDn+euj63aeEMheeZqmN/tQX2ftMOWl/3eOBBRGqEF+S2AykV3i9fBtwgfodn5sbwvtaXv6bqEcK1182093PdPgChGsMEwh8w9k3HN7c4CyrymrOATL4QN8pKMg39aD7MbR/Umfa75ywFHr9NhVYoZiQiVsvursVjvu8YHB8QVym/RWF5cwcUcyW6GU6cHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juQhCl2D00VzZ9tc+4WDMuvFoiUYo/uincxGKZq0S0U=;
 b=ygsXutdwqwz1ByosVUZyPdJPEZqvGPh3KxOVcEUX69LsLoZzwnqpOMtUatjAWex02SsbeG62hjaQ5Xjyz6WOF9eWRyZRek2xeHOqCCqNaRGKohKOKEPFLpDL04Ee3JOq2KzwPSdBFiWFfu1xYdT9BtIgy5OlAQvpkMuUxRw2H6r6mg98XcBgAlcfJuKEyyztmNNIpuwxUX8FRMLGNwfyIld0wjWwlqpKvCqQhGC9dBzhWuq03zgzyL1dEsi6VOkQfjuABf1dQNEJATquAEjw3yLewx0K4oHKWN1uNosZeAPcz2QEg+uFB6ENthHyMYbiCSvLORC7D2jB8MsyXvSgjg==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 GVXP189MB2007.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:6f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.32; Mon, 20 Apr 2026 14:49:48 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%5]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 14:49:48 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Lee Jones <lee@kernel.org>
CC: Jon Maloy <jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] tipc: fix double-free in tipc_buf_append()
Thread-Topic: [PATCH 1/1] tipc: fix double-free in tipc_buf_append()
Thread-Index: AQHc0MdsOiuDtYmLQEW/2MapjzEborXn80hggAAQYICAAAJR4A==
Date: Mon, 20 Apr 2026 14:49:47 +0000
Message-ID:
 <GV1P189MB198853F316580DDA547F4925C62F2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260420130524.3527420-1-lee@kernel.org>
 <GV1P189MB19886E03BDD0F407B757E5ABC62F2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <20260420143309.GD3202366@google.com>
In-Reply-To: <20260420143309.GD3202366@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|GVXP189MB2007:EE_
x-ms-office365-filtering-correlation-id: 921bafd4-e74d-4161-0a30-08de9eec11ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 ftKYELEM9dKiI46nNjyOH3oZOVbjxzvdgQkMc5e+ERYLjVXflOtiqhqUULatDK7qKQtAQVh4mv2C67JCnIbFCzML40wbnnKkihtm/tq9mH16O7FZud2WzGbtPJ9cZCRfCKUOeWL+eUJQETmRIahc4vy7fWLBNOEfI31H5OI9XLPHv4X0fHTE75aHVbr2vX63iAmdjy7JqgiBWGO+8KM3zR3ru86Ok+a9wezeiqtdrBS4nRPX7S90MxomuZdTtLMBkEzqemjoPmXuKBMq27kt2E1k1KCKjy9AnIzzsrCLUHK+jwcj313jH281Pr8K1O9PLgBHQtT0fEcFekkyNo/x+B1mB4cZQrZD8cbNxhKoqv5JDeTW2pJo+8Tmjq4MKso0GPm1Z3EKdJovracj4gqr7IyLrAiPqjDBCE56qmgfAprlmx0y+kz4riIS3aTOZ2rjlkE+1eVTdtXRadEiNOFhSUsSploBX1H3ce7GTZgFhictJ1U9yQK3JjBqgQJMBTfeVlH50q/XF+ibslAbrfpHyDq3Gjh4DiAQRAfX0/oF+sepf/fBTwmD8jJy969f1KNzZM41dBXaQS6+6+2XAALe/b6dmnVM8YZQMnFNbLZ+Ho8Mh7sk2TLV1b+xKH19gZw9VJoLJJnGdQHVgiGo210y4PUhWzS3cMWgkPcBISj0SlZ6qgmYXrsy17qHcUo8DBbDrS64lCrPHVYcfCRzik4LGr/v//evRQgXFpv6hIcSyl2DuJcRc5shbb08ZxPD8bY/KjpVe8eQjvPZvr5dZhP0xuwTPHYhVmI0jfQrAK0xfKo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QnhiYnlsT3lsd1FZZm9ZVjA5K1VQUlcwdlAxZDRRSjZtWis3Mm1KUFArQ1c1?=
 =?utf-8?B?d0hqMVUzckZWYmZkT2VuK3BjRVFsVXh3NVIxbjg2NnRtRWRFcVRmZnBEMTk0?=
 =?utf-8?B?YTZjczhzU2Z5Z2JYbU8wWG5MSVFOeWN4ZkZvSGdrcVZCM2UxejFrRldPL3Bx?=
 =?utf-8?B?R1J3Vm5uRlgyTWEzRUhKZndpUzRSalJmK01XWk1mYURZS0ZJQ0t2b2pKNitw?=
 =?utf-8?B?dUFWblNxS1ZBZFVwdUtmZXJjMDJ1ZHpkMUIydzBvcnplb3RpcDh0Y0xhdWJo?=
 =?utf-8?B?NEdRNmU0SFhhTnRYRTVzbnZGbmVkODdGSjlwVkJkaDJXRDVWcDhuVnM3VFFY?=
 =?utf-8?B?R3BOQXVtL0JMMkpDb3JPZWxudGRXMk1qemZnellGRXMzZ1diZlIzM2cwNE9k?=
 =?utf-8?B?ODl4MERVVWFvR2p2NE9BNk5DSG5Gc2pCQ2RBTjFpQnRtSEYxcllhYnpDTUJv?=
 =?utf-8?B?M1M2NmkxeTlsWnNJNzBPV0diRDJIYy9pS1dYeE03azNrd1pxMG9WbXZnSFNH?=
 =?utf-8?B?NDUxb3ZwVW0xK1U2RWFoc2F6TmdldVF6OUYyNmdnZUdKdUQ0b0hjcWNKNE1w?=
 =?utf-8?B?RExEbmVYclJQdlorZWRYNFF3SktQSzA0REdSSVFkQmFwNnRraXloWVdwTEtn?=
 =?utf-8?B?VTRISWNQaWx2SnBQUFBOcmxQMVNVdmVoQWpXWnZxaWt2Q1BvMEw2MWN5WEhq?=
 =?utf-8?B?Q2pzYitacFpza3BkclpOUEpieFRQZjZmcDJtOUJvMnFLa3BSRTEvS3J3cDdk?=
 =?utf-8?B?TUxLeEhZWU1ybW1MdFNDdGVyM2dYamROeG1VTWJmYWlSSzJlRjNPNytTSk5R?=
 =?utf-8?B?eFh6TkNLSFl2MXlrSVZITk1YYy9wcmRpejdIUzFySmVOVDRRdUc0NmQxQ0Rw?=
 =?utf-8?B?ZXM2bm1KdFNMeVNGTER3OTNDYmIyUHdQREZjOG9zbVlSYWlqY1VMY1FCMk5X?=
 =?utf-8?B?QkJNOVdTRERyMng0NFJidU43YVJNTC9OdjBneEd3RWNRSmFSZTFJc1VqTzVw?=
 =?utf-8?B?SjFSWmVkOENCQURXV2JxcDVFT2dPUWJJaDRYN1FtQ251Zmpxdkh5YkNLQWtB?=
 =?utf-8?B?UzJxNlpzWklCMDd2aVpZWUt0V3BVTVBaNkFUL09UUGpuRlR0bWNBRzI4TnVJ?=
 =?utf-8?B?aklCMmVOYWFjbDBuYWJCTmY1R1VjRUdjUTFJM0FDaE9GcmYxREUxZ0VJSUhw?=
 =?utf-8?B?eWhiMXZrblJXNUVwV1MraHhGeXJsd0VNdmFQcXc4SHZ3NHBMdXltenU2SEI1?=
 =?utf-8?B?Sk92eWRBcEpNamYxUlZIZHFRMFJNMFBveUowbGlvamdGbENvQW5JOXhRcUVZ?=
 =?utf-8?B?MHlLbHBRdEN1S1N2TlNBYytERjdBVDJLUnlWSm1ic1BKNUdMN0t0dHIvcDgv?=
 =?utf-8?B?VHkyUzFVSFA1NWlxckdraC9meHo3djQ4SFJzNGFwMGZ6eWxiM2orOVZQb1NT?=
 =?utf-8?B?eUJHNVIvdktkUlc3MkgxYUJidkZadHpQR2plRDVRdi9EUDMxT3pTMFZCWWQv?=
 =?utf-8?B?TjZPSUp0b3JjaE9xd25RY3hCRmtVYkoxSnpvZ0ppRHZKd1FmWStTblkxWWtR?=
 =?utf-8?B?OWtHL1h6VFQrTWVRVVI1RnE0RUpLQVNMZmF2V2pHVG1ZblY2cjlqS3FDeDB0?=
 =?utf-8?B?am5qNjhialEyekFiOEpRYW5icEUzL2ZhMzZtUkhWMlVLUWw2L056dG5Wc2xr?=
 =?utf-8?B?cVpaQUFLSFlDaVlKakpCbnBabUpvZjdOK3crTDd1bUpKR0dGYmRqa0NUUnpG?=
 =?utf-8?B?cHJ5M0RUL1I1MnVXRXhaUGIybGYrMHdzTUFTNVhNcFMrR2dXb0xLekJHdFpi?=
 =?utf-8?B?ZnhBL1JCQlZ6Q0kzZVIxbC9weTFIaHNYdHNvNnpVWk9rNXd6eWtza0ZkWk9E?=
 =?utf-8?B?NWxYSHAvWm1TZVh2aFZCY25lMEtGd25lRUFSN0NWTXcwczRXWnppOWFydjc5?=
 =?utf-8?B?RmNvcmgxNWtOZ0NPeU5UVzB5TUxaMG8zSm9vK2ErWjh4blhyRmF5ZGZrWEdW?=
 =?utf-8?B?d0YxNFhIMHhzU2QvTFc0bFpqS3hKTllyb0VCN2VUL2NOVjdkend0YjFGYlRI?=
 =?utf-8?B?NWhjdFFhaFdHNmR2RlZaUXpFaEhIWkxiREZ3VzEyS3Z5ZjRvWGM4c0pCNldq?=
 =?utf-8?B?RitkSURuWGtiNFBNbDZwZDNGcXpSajJqdWExeW90WEhvMEVmVlNFUElEN2Zl?=
 =?utf-8?B?VkxweXJzNE5NcGdaZVpoaUZXVDVCcUpDQ0JQOUh5NTVHNXZvdm9aQkVETDA3?=
 =?utf-8?B?N0o0a3laYjZyZ3RQV0w4b3N2aGVOekRDTHN5aXl6OWUvOGhFMC8yZ3FIeGNL?=
 =?utf-8?B?ay91MFVXeWlycUJPZlZEVHhpY3FpYkNmWnhWTys4UFQyMXUwRnhqUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 921bafd4-e74d-4161-0a30-08de9eec11ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 14:49:47.8720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zRW/dpHE9zeikbIzFgvbD3HbO//ADCGI4ZqvTiM6eE51Or4N+8XoHouFQzSD4DVnAcEprJeo36jgjiuFExY8B7CgbyGmLik0waho3IX+fFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB2007
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279840-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[est.tech];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,est.tech:dkim,carlini.com:email,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: 8269342E668
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pj4gU3ViamVjdDogW1BBVENIIDEvMV0gdGlwYzogZml4IGRvdWJsZS1mcmVlIGluIHRpcGNfYnVm
X2FwcGVuZCgpDQo+PiA+DQo+PiA+VGhlIHRpcGNfbXNnX3ZhbGlkYXRlKCkgZnVuY3Rpb24gY2Fu
IHBvdGVudGlhbGx5IHJlYWxsb2NhdGUgdGhlIHNrYg0KPj4gPml0IGlzIHZhbGlkYXRpbmcsIGZy
ZWVpbmcgdGhlIG9sZCBvbmUuICBJbiB0aXBjX2J1Zl9hcHBlbmQoKSwgaXQgd2FzDQo+PiA+YmVp
bmcgY2FsbGVkIHdpdGggYSBwb2ludGVyIHRvIGEgbG9jYWwgdmFyaWFibGUgd2hpY2ggd2FzIGEg
Y29weSBvZiB0aGUNCj5jYWxsZXIncyBza2IgcG9pbnRlci4NCj4+ID4NCj4+ID5JZiB0aGUgc2ti
IHdhcyByZWFsbG9jYXRlZCBhbmQgdmFsaWRhdGlvbiBzdWJzZXF1ZW50bHkgZmFpbGVkLCB0aGUN
Cj4+ID5lcnJvciBoYW5kbGluZyBwYXRoIHdvdWxkIGZyZWUgdGhlIG9yaWdpbmFsIHNrYiBwb2lu
dGVyLCB3aGljaCBoYWQNCj4+ID5hbHJlYWR5IGJlZW4gZnJlZWQsIGxlYWRpbmcgdG8gZG91Ymxl
LWZyZWUuDQo+PiA+DQo+PiA+Rml4IHRoaXMgYnkgcGFzc2luZyB0aGUgY2FsbGVyJ3Mgc2tiIHBv
aW50ZXItcG9pbnRlciBkaXJlY3RseSB0bw0KPj4gPnRpcGNfbXNnX3ZhbGlkYXRlKCksIGVuc3Vy
aW5nIGFueSBtb2RpZmljYXRpb24gaXMgcmVmbGVjdGVkIGNvcnJlY3RseS4NCj4+ID5UaGUgbG9j
YWwgc2tiIHBvaW50ZXIgaXMgdGhlbiB1cGRhdGVkIGZyb20gdGhlIChwb3NzaWJseSBtb2RpZmll
ZCkNCj4+ID5jYWxsZXIncyBwb2ludGVyLg0KPj4gPg0KPj4gPkZpeGVzOiBkNjE4ZDA5YTY4ZTQg
KCJ0aXBjOiBlbmZvcmNlIHZhbGlkIHJhdGlvIGJldHdlZW4gc2tiIHRydWVzaXplDQo+PiA+YW5k
DQo+PiA+Y29udGVudHMiKQ0KPj4gPkFzc2lzdGVkLWJ5OiBHZW1pbmk6Z2VtaW5pLTMuMS1wcm8t
cHJldmlldw0KPj4gPlNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlQGtlcm5lbC5vcmc+DQo+
PiA+LS0tDQo+PiA+IG5ldC90aXBjL21zZy5jIHwgMyArKy0NCj4+ID4gMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4gPg0KPj4gPmRpZmYgLS1naXQgYS9u
ZXQvdGlwYy9tc2cuYyBiL25ldC90aXBjL21zZy5jIGluZGV4DQo+PiA+NzYyODRmYzUzOGViLi45
ZjRmNjEyZWUwMjcNCj4+ID4xMDA2NDQNCj4+ID4tLS0gYS9uZXQvdGlwYy9tc2cuYw0KPj4gPisr
KyBiL25ldC90aXBjL21zZy5jDQo+PiA+QEAgLTE3Nyw4ICsxNzcsOSBAQCBpbnQgdGlwY19idWZf
YXBwZW5kKHN0cnVjdCBza19idWZmICoqaGVhZGJ1ZiwNCj4+ID5zdHJ1Y3Qgc2tfYnVmZiAqKmJ1
ZikNCj4+ID4NCj4+ID4gCWlmIChmcmFnaWQgPT0gTEFTVF9GUkFHTUVOVCkgew0KPj4gPiAJCVRJ
UENfU0tCX0NCKGhlYWQpLT52YWxpZGF0ZWQgPSAwOw0KPj4gPi0JCWlmICh1bmxpa2VseSghdGlw
Y19tc2dfdmFsaWRhdGUoJmhlYWQpKSkNCj4+ID4rCQlpZiAodW5saWtlbHkoIXRpcGNfbXNnX3Zh
bGlkYXRlKGhlYWRidWYpKSkNCj4+ID4gCQkJZ290byBlcnI7DQo+PiA+KwkJaGVhZCA9ICpoZWFk
YnVmOw0KPj4gVGhpcyBpcyBhIGtub3duIGlzc3VlIGFuZCB3YXMgcmVwb3J0ZWQgdmlhDQo+PiBo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbmV0ZGV2YnBmL3BhdGNoLzIwMjYw
MzMwMjA1MzEzLjI0DQo+PiAzMzM3Mi0xLW5pY2hvbGFzQGNhcmxpbmkuY29tLyBUaGUgYXV0aG9y
IGRpZCBub3QgcmVzcG9uZCB0byBteQ0KPj4gY29tbWVudC4NCj4+IENhbiB5b3UgaW1wcm92ZSB0
aGUgZml4IGJ5IGFwcGx5aW5nIG15IHBhdGNoPw0KPg0KPkknZCBiZSBoYXBweSB0byBtYWtlIGFu
eSByZXF1aXJlZCBjaGFuZ2VzLg0KPg0KPkhvd2V2ZXIsIGlzIHRoaXMgYXBwcm9hY2ggc3VwZXJp
b3IgdG8gc2ltcGx5IHBhc3NpbmcgYSByZWZlcmVuY2U/DQo+DQo+djEgYXBwZWFycyB0byBiZSBz
aW1wbGVyLCBlYXNpZXIgdG8gcmVhZCBhbmQgYXZvaWRzIHRoZSBleHBsYW5hdGlvbi4NCj4NCkFz
IEkgZXhwbGFpbmVkLCB5b3VyIGZpeCBhZGRzIGV4dHJhIG92ZXJoZWFkIHRvIG5vcm1hbCBwYXRo
IHdoaWxlIHRoZSBlcnJvciBwYXRoIGlzIGNvcm5lciBjYXNlIGFuZCBpdCByYXJlbHkgaGFwcGVu
cy4NCldoYXRldmVyIGFwcHJvYWNoIGlzIGFwcGxpZWQsIHdlIG5lZWQgdG8gYWRkIGV4cGxhbmF0
aW9uIHRvIHVuZGVyc3RhbmQgbW9yZSBlYXNpbHkgdGhlIGxvZ2ljIGFuZCBoaWRkZW4gdHJpY2sg
aW4gdGlwY19tc2dfdmFsaWRhdGUoKS4NCj4+IGRpZmYgLS1naXQgYS9uZXQvdGlwYy9tc2cuYyBi
L25ldC90aXBjL21zZy5jIGluZGV4DQo+PiA3NjI4NGZjNTM4ZWIuLjAxYTY5MzU1OTU4OSAxMDA2
NDQNCj4+IC0tLSBhL25ldC90aXBjL21zZy5jDQo+PiArKysgYi9uZXQvdGlwYy9tc2cuYw0KPj4g
QEAgLTE3Nyw4ICsxNzcsMTkgQEAgaW50IHRpcGNfYnVmX2FwcGVuZChzdHJ1Y3Qgc2tfYnVmZiAq
KmhlYWRidWYsDQo+PiBzdHJ1Y3Qgc2tfYnVmZiAqKmJ1ZikNCj4+DQo+PiAgICAgICAgIGlmIChm
cmFnaWQgPT0gTEFTVF9GUkFHTUVOVCkgew0KPj4gICAgICAgICAgICAgICAgIFRJUENfU0tCX0NC
KGhlYWQpLT52YWxpZGF0ZWQgPSAwOw0KPj4gLSAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSgh
dGlwY19tc2dfdmFsaWRhdGUoJmhlYWQpKSkNCj4+ICsgICAgICAgICAgICAgICBpZiAodW5saWtl
bHkoIXRpcGNfbXNnX3ZhbGlkYXRlKCZoZWFkKSkpIHsNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgIC8qIHJlYXNzZW1ibGVkIHNrYiBoYXMgYmVlbiBmcmVlZCBpbg0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICogdGlwY19tc2dfdmFsaWRhdGUoKSBiZWNhdXNlIG9mIGludmFsaWQgdHJ1
ZXNpemUuDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgKiBoZWFkIG5vdyBwb2ludHMgdG8g
bmV3bHktYWxsb2NhdGVkIHJlYXNzZW1ibGVkIHNrYg0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICogd2hpbGUgKmhlYWRidWYgcG9pbnRzIHRvIGZyZWVkIHJlYXNzZW1ibGVkIHNrYi4NCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAqIFNvLCBjb3JyZWN0ICpoZWFkYnVmIGZvciBmcmVl
aW5nIG5ld2x5LWFsbG9jYXRlZA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICogcmVhc3Nl
bWJsZWQgc2tiIGxhdGVyLg0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICovDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICBpZiAoaGVhZCAhPSAqaGVhZGJ1ZikNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKmhlYWRidWYgPSBoZWFkOw0KPj4gKw0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgZ290byBlcnI7DQo+PiArICAgICAgICAgICAgICAgfQ0KPj4gICAgICAg
ICAgICAgICAgICpidWYgPSBoZWFkOw0KPj4gICAgICAgICAgICAgICAgIFRJUENfU0tCX0NCKGhl
YWQpLT50YWlsID0gTlVMTDsNCj4+ICAgICAgICAgICAgICAgICAqaGVhZGJ1ZiA9IE5VTEw7DQo+
PiA+IAkJKmJ1ZiA9IGhlYWQ7DQo+PiA+IAkJVElQQ19TS0JfQ0IoaGVhZCktPnRhaWwgPSBOVUxM
Ow0KPj4gPiAJCSpoZWFkYnVmID0gTlVMTDsNCj4+ID4tLQ0KPj4gPjIuNTQuMC5yYzEuNTEzLmdh
ZDhhYmU3YTVhLWdvb2cNCj4+ID4NCj4+DQo+DQo+LS0NCj5MZWUgSm9uZXMgW+adjueQvOaWr10N
Cg==

