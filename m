Return-Path: <netdev+bounces-280098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJyMLvJp52ke8AEAu9opvQ
	(envelope-from <netdev+bounces-280098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:13:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC6343A7C8
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16B90302676D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7033A2549;
	Tue, 21 Apr 2026 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="Mgeh37I4"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595503845AD;
	Tue, 21 Apr 2026 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776773408; cv=fail; b=gLvBhLkVelqbbEApgHSIfpzN8c3FKYdk5ianyEuR6tnYkp7cL2ixLhs4AYGQA5ypAH7ObP5lr9BqzCnx+dMe8eVqXTXATSJvpC0BgXIoVMYCdlDg7M/LLR8YL3zi8pisZUt1/msqWJqYPIR2fcxQUP1VWDvUStQu0amIcUbhUsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776773408; c=relaxed/simple;
	bh=Q0a3XM9CdyBUQ1batam7BfXeINPS/BnCBCZhBm/PZ10=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kxY6wYwX3y/fYS+wECDIiU75Xzwm3mblsEWNf0buUvVUP7i5Mt/YxSGi7ozdPZvX/Wt/xvgRzKU+ytQ/JkXp4EQHSOd6bKVRtBXE9coJ2S+p8pUIFxQ7zhoJbKcVrKZD1oLngNIG0Epk/hQAc1xbT1qFzV2mYO84kltHlZgbft8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=Mgeh37I4; arc=fail smtp.client-ip=52.101.65.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaK+59xxVY87escEfBu+nwQqhtlvC2E/KZ8dzQ2no1Qu5+Mv1wLgFH4Cc+yyiD8oX79+AOW2U5Td0N+73GUerlJJA2YlLTFVXPzlZOcrPZTdb4vkpKk2buTzzOn+RxVfLLCBQInSfCuMaLsh1I8UXRjqJ9ZWvLfBiNliQQ8k3vto7vih8b9eq4vYvXBodpFju542t4NQ3W9JgXE7zLoFNP9BJ/gIGvwP9+SB3HNOKomUXifkozd25ooF31cOZBmR0VlMWtSfUluPZo8FTjK7Zr6qDpFYAycsWJU6AVubi/mqpEC9JwD8vAqagTHN8rdRhY/mCdDMh/cl2Sn7cUiXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0a3XM9CdyBUQ1batam7BfXeINPS/BnCBCZhBm/PZ10=;
 b=Gb1fvnWB66JiwkGZyNOMWvXvwk5IsA8p3a4egXhvR5maW89SEZGcWIK3qH7aBdu752BD/b6lFogF5SfT58Oe0NKCu2hUKDBNclbsKfq03pjb7mctsrkIUmoMh11LvjcQsTlb+S8KCQ7q1ibyaCkIcezA130iZoM5EWMvsFw1jnavVtq+0C9Cjr0U/vc60LA8SA5j4i6dBpvSeIzT6hvmuUPB/W1Aa9jgJ1TLr9K8D5TLyLCGLkvgJI7JyMTPWu2iX5MKMmmen598oC/rCsvKGamH3ENgTzBG6RTfzjmdcBaZEEqLC7cNKqfXYwYe75IQ8vLqMFjHxzKLa6jBebzMGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0a3XM9CdyBUQ1batam7BfXeINPS/BnCBCZhBm/PZ10=;
 b=Mgeh37I4pLBp1skS+cmgrgXali/v5D7kAqvhX9+L4JST/fXCxHZXvSz1V5XQUy4QT8hwoz2l0uFNPtREiktmsF8rHRMuuWZTLwN/HR8rIoqXeFPVQl1RaIL7wEl72dwi5wE12hqEoRdm3tqXM8S5XsKDyoHQGHxu2dXAkBadaV0E8nZDOO9pnzOKdYbLSW5bbbIuL4WeZMXs5KohQAak/qLjlyH72dOMMIqxAd0amdvCizQRUy+JUuvvEjeqVPqHWQu7iSm+RMDvUYN75/6q026/hmNFrZmcojHeIgyTmSLd3CPoEjBFtEjrMMoXm6zNhpeNRQ3OVkrBFOCp3HoqvA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AM4P189MB3381.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:6d0::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.33; Tue, 21 Apr 2026 12:10:01 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%5]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 12:10:01 +0000
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
Thread-Index:
 AQHc0MdsOiuDtYmLQEW/2MapjzEborXn80hggAAQYICAAAJR4IAACCsAgAFFg4CAABf90A==
Date: Tue, 21 Apr 2026 12:10:01 +0000
Message-ID:
 <GV1P189MB198888D44169106BFB04359BC62C2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260420130524.3527420-1-lee@kernel.org>
 <GV1P189MB19886E03BDD0F407B757E5ABC62F2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <20260420143309.GD3202366@google.com>
 <GV1P189MB198853F316580DDA547F4925C62F2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <20260420151040.GF3202366@google.com> <20260421103543.GH3202366@google.com>
In-Reply-To: <20260421103543.GH3202366@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AM4P189MB3381:EE_
x-ms-office365-filtering-correlation-id: d3ab20fe-6cc1-4360-6510-08de9f9eea16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700021|22082099003|56012099003|18002099003|18096099003;
x-microsoft-antispam-message-info:
 vt2pE37b9Udtvz51pRLMZqEAJCUuM+kG+k5OPRyX5mZfQWRdeaHxzA+pdSC3vEuh7YIK+BBXGnh6bTXhfZAer6ZZvutC1F9O02HYxyy3VytyRUC3NonlaQRsCpdjfxTr4a79ylGqcxqI3xo/5oef/FqHWT+uSamIDQ75WtUuHtJ+6AeMNyRSgp5WUqjJMpsajSOtu25AwSrr/AE00q7b0of8jqic/HNusl/f5CoDNNJE7l9xMrkrH+cuj70OmsUWQRnbHuoexBL+2qlpcH2mIoxd6OIFHgormSO3Pl9mAPdYV6wzYoUFddYNLTgBgHobC8DpyDv1Rn/0IV/Pz9xj5XxK7/34klO+yBWqj2MI2maTh5QleKZ6H+E664XM2fqkO54w2qEExhZbKIFMXNM+AjEo0Fx1NZJVhot55wqpuFa3VmoPrSbaKCeO+4EsPd7HMMeVczSAbEPqEQCOKF7PE5nUZrIKdKPy6JlsQiG7GJrDB7Gex7gp1ftJeH/QKcO1qj2J6qr4lFxsCJQksiaj602c1HDz+sGkh7yiXCDgbN4eOBCjF0Z2nz8ZZsgU1p38cKWmaLA078NFzZiT6IG52jv9YJe8hiecX42guLuo55xQQnY20FMOqTVhKQi2jfgm+EkWxW+1lPHUQf5H+jkD1Q1YE6gJ51EKzNcsCOtD6YDbkEJtX2SNwUCok9j5IpPOaBFSzRccS2DoH2pSMFF2OIAxU2QkMEZ+30l6GR27a0YCt/jkymvABJH2UgLO0XDDROlfeHxXePd/RWhBElHC81sND62qC6RbgN2mMx4WwyE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700021)(22082099003)(56012099003)(18002099003)(18096099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnRIdHBYREtySFo3VUE3UWhVTDFzLzBuNnVBTXhydjZGSnFUc1lyckVIck5M?=
 =?utf-8?B?QVpxVnRoOXBmeFNiWFQrSEE3Sm9KdlQ1K3FmcHhGVWJGbXVPdmNKREhweGkz?=
 =?utf-8?B?VnM2dnczS0dua3BGS0tjdzg5M2VOMTlsT081U1JkdGhuejdZcEovZDZkOXVs?=
 =?utf-8?B?Ui9sQzMzM2Y4MGpZaFZLTXljNHUyWStDbjcyVERmeTI4SVhzWDdjdHg0V2ls?=
 =?utf-8?B?b2h0aHFlbTBkVnJTZ05TQjVOemlmQmhXU1JHS1hrYUNrWTJJK20wUU40bExj?=
 =?utf-8?B?WXVJRlZJTWxlcG9EOXh4b0ptYXB1TGRZdzNhSVVnT29yRmtveS9CMkVYT01q?=
 =?utf-8?B?Q1Y5QjNtNlRkTEVQbkgwNDNFb2g0WTNsMzdXTnNFbDJHRERRK1hVdHZwTzBU?=
 =?utf-8?B?cUZuOGd5S290M1UvMFZyd0FvdU5WdXBBOWhiSW54QlpNaEE2Q3dXcElGaXRr?=
 =?utf-8?B?eDF0UXBHNjNpaXFzbjZVYXlLZDFvOW9FQWx1ZVo4Y2VXclg4b3V2VGs5S3lT?=
 =?utf-8?B?eUcveXNGWHA5TG9ZQnV6QjZVNXNXUTlxd1A2NU5JOUNpdFlBNFdObHF6VTVB?=
 =?utf-8?B?RkJFNnlNeTlaUWlISFd6NEVEcVVqcE01QW42enJBdlozekhtelAza0U4ZGN2?=
 =?utf-8?B?bGE2V1piYjJKSXZWWmg0SVlDWUZiRTdoVUxEdVpxSjdMbmttZ2JXTFF1bTYx?=
 =?utf-8?B?cHhqY3dveFB1ZS9rcVBlbldjTkdyUlVBWktjOStvcGdFVnJPWURycnArSTMr?=
 =?utf-8?B?RXArcWdjZ2JJTWRQQkhaQTA5amdTRG5Ga290V20vRjBFS3J0UTVnUTBvUHNj?=
 =?utf-8?B?U012TEdiVkkrUEttVzRMc0J6eVpDeHJ1YU1qT0NvcUNNOCs2K3NRY3pJa2pI?=
 =?utf-8?B?Q1lLeGJFb2VJY084WTRYWStENS84cUhteTFqdTdVelJKMTlEVVFOcW5ya21i?=
 =?utf-8?B?K3hmS3ZpWjVZRFc2QjJ6Z0RLM25HSytaNjVQSFQ0czNaQW52SDl6ZWsxOGVH?=
 =?utf-8?B?eU1EWm80V01TdHRFTjhqemNYR0FjTmR3NzBMd1c0REdSR2xZa0FRVm1PK2or?=
 =?utf-8?B?ekNsaENGeFdjRUwvU25jaVEzM1RPTlR1d0dPclF2QXIxR3JJb01zNlFJamlN?=
 =?utf-8?B?MEsxVnpMcG8wSXVUdVp5NGUycFl4U0M1N09OWW9uNXhyUVdYaXhDZUoxVURz?=
 =?utf-8?B?b0RpdWtUUXVwU2ROVmtsM0VoNzNRS2dNaW0rcnpGdHZub1JhVlUvR1JYSUpB?=
 =?utf-8?B?RTRnQzJIcHpUSm0ybUhrWE1GNkViZVBnRHVKRERLaXkyYUJ4NkJXWXJySXFR?=
 =?utf-8?B?QU9ybGxiYmU0RHVrT1BaM21EY00rM2k4M3lnWmxkOVpvQjNLcHhsZ3gxRU0w?=
 =?utf-8?B?THk1OWhHMFo2KzUyWWVwcEIwN29KZGpQa3FVU0ZVUHVMb1U5VE94aDA0RTd5?=
 =?utf-8?B?TDh2Q0JGbnVvR2RPUmJ1Yk5uQ1ppRWxmaUx0UDRaYzFKOHl5QTBvREtiRHpx?=
 =?utf-8?B?YWxDQks0Vy9CbURlazZTY05sMC95OWhiUW13SVFXemZCQ2F1YW15OUp0NlA0?=
 =?utf-8?B?ZkxoeWhvSnprMDNGc2QxTjhKQ09qb0JEdThJVTAyOXA5TkhGeDVhNDFKOE5n?=
 =?utf-8?B?QU9McTB2c3ZOV0gvK3c5cEpLK2Z4ZTQyUFQ1em1aNUNRQ1FaSk13N3RFc29y?=
 =?utf-8?B?RnlOR1JNQmZBaHFsRkt5THpGa01tRTNlR3hvM1ZMekFVUVl1dDNhT3RDSE5D?=
 =?utf-8?B?aW9UUmVLUDlKcWFpclRkM2lueW11Tm53U1c1RFNiUlRiU2EzbHNZS2ZBWGZC?=
 =?utf-8?B?Y1VhMGtkUnhXUjJjWVZlWGdITFF2SEltbGhHbUFaSkhxNDZLNXFDTElKZ1lN?=
 =?utf-8?B?cE5uendSWlBYRGd6a3FZZ3pBeENLUVFVN1RNVUorcTVuY3RrSVBGQWJFNUo4?=
 =?utf-8?B?cjBCY043dlZpSUVOaVZUVjM5MlhGTENFeEtXTTFMQXhMYkVCQ0lTMEx4MzlF?=
 =?utf-8?B?MVZBZmE5d2JVZVBvMkt2YWFWbDJKSW5mZi9weGthRGlZQ1ZmQys0WjBUODFH?=
 =?utf-8?B?cE85RGIxMW1Kd2MyWndaYmsvYlNSNlNjbzRUT0R3UjdhN00ydy8zZEZ5UXh0?=
 =?utf-8?B?cE9PSStFNmlaMVZCVnI1T2J0ZlFSWGkzdzhtVnBtNTVRdzNqcFJydTh5UkZE?=
 =?utf-8?B?clRzZzBvWjNhckJrUUhRbnBLQWh3amt5WXdtU2t3VWdtSHVkS3FJUFg5MFQ1?=
 =?utf-8?B?VU1tQlhJU3g1U1c3ZTU2MlAvWWw3Zk5zMFl6UW5NaUt1NEIrQ1NESjdraks0?=
 =?utf-8?B?cDFHcURrSGpxbzBoTFhHd1RlbFhudExIc1ZrV2ZwbmxUUFd6QUVwdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ab20fe-6cc1-4360-6510-08de9f9eea16
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 12:10:01.3714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yehO36hRBnHxUlOBo+xQofGTAjR3qc20vvnUQW3tENISOs8ndOBu9zv1V6taQhUy/Feg2zklQMrCL30jssdZWqQJTcr+C2rAYzQb7Si8rwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P189MB3381
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280098-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,carlini.com:email,est.tech:dkim]
X-Rspamd-Queue-Id: 2CC6343A7C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PlN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8xXSB0aXBjOiBmaXggZG91YmxlLWZyZWUgaW4gdGlwY19i
dWZfYXBwZW5kKCkNCj4NCj5PbiBNb24sIDIwIEFwciAyMDI2LCBMZWUgSm9uZXMgd3JvdGU6DQo+
DQo+PiBPbiBNb24sIDIwIEFwciAyMDI2LCBUdW5nIFF1YW5nIE5ndXllbiB3cm90ZToNCj4+DQo+
PiA+ID4+IFN1YmplY3Q6IFtQQVRDSCAxLzFdIHRpcGM6IGZpeCBkb3VibGUtZnJlZSBpbiB0aXBj
X2J1Zl9hcHBlbmQoKQ0KPj4gPiA+PiA+DQo+PiA+ID4+ID5UaGUgdGlwY19tc2dfdmFsaWRhdGUo
KSBmdW5jdGlvbiBjYW4gcG90ZW50aWFsbHkgcmVhbGxvY2F0ZSB0aGUNCj4+ID4gPj4gPnNrYiBp
dCBpcyB2YWxpZGF0aW5nLCBmcmVlaW5nIHRoZSBvbGQgb25lLiAgSW4NCj4+ID4gPj4gPnRpcGNf
YnVmX2FwcGVuZCgpLCBpdCB3YXMgYmVpbmcgY2FsbGVkIHdpdGggYSBwb2ludGVyIHRvIGEgbG9j
YWwNCj4+ID4gPj4gPnZhcmlhYmxlIHdoaWNoIHdhcyBhIGNvcHkgb2YgdGhlDQo+PiA+ID5jYWxs
ZXIncyBza2IgcG9pbnRlci4NCj4+ID4gPj4gPg0KPj4gPiA+PiA+SWYgdGhlIHNrYiB3YXMgcmVh
bGxvY2F0ZWQgYW5kIHZhbGlkYXRpb24gc3Vic2VxdWVudGx5IGZhaWxlZCwNCj4+ID4gPj4gPnRo
ZSBlcnJvciBoYW5kbGluZyBwYXRoIHdvdWxkIGZyZWUgdGhlIG9yaWdpbmFsIHNrYiBwb2ludGVy
LA0KPj4gPiA+PiA+d2hpY2ggaGFkIGFscmVhZHkgYmVlbiBmcmVlZCwgbGVhZGluZyB0byBkb3Vi
bGUtZnJlZS4NCj4+ID4gPj4gPg0KPj4gPiA+PiA+Rml4IHRoaXMgYnkgcGFzc2luZyB0aGUgY2Fs
bGVyJ3Mgc2tiIHBvaW50ZXItcG9pbnRlciBkaXJlY3RseSB0bw0KPj4gPiA+PiA+dGlwY19tc2df
dmFsaWRhdGUoKSwgZW5zdXJpbmcgYW55IG1vZGlmaWNhdGlvbiBpcyByZWZsZWN0ZWQgY29ycmVj
dGx5Lg0KPj4gPiA+PiA+VGhlIGxvY2FsIHNrYiBwb2ludGVyIGlzIHRoZW4gdXBkYXRlZCBmcm9t
IHRoZSAocG9zc2libHkNCj4+ID4gPj4gPm1vZGlmaWVkKSBjYWxsZXIncyBwb2ludGVyLg0KPj4g
PiA+PiA+DQo+PiA+ID4+ID5GaXhlczogZDYxOGQwOWE2OGU0ICgidGlwYzogZW5mb3JjZSB2YWxp
ZCByYXRpbyBiZXR3ZWVuIHNrYg0KPj4gPiA+PiA+dHJ1ZXNpemUgYW5kDQo+PiA+ID4+ID5jb250
ZW50cyIpDQo+PiA+ID4+ID5Bc3Npc3RlZC1ieTogR2VtaW5pOmdlbWluaS0zLjEtcHJvLXByZXZp
ZXcNCj4+ID4gPj4gPlNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlQGtlcm5lbC5vcmc+DQo+
PiA+ID4+ID4tLS0NCj4+ID4gPj4gPiBuZXQvdGlwYy9tc2cuYyB8IDMgKystDQo+PiA+ID4+ID4g
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4gPiA+PiA+
DQo+PiA+ID4+ID5kaWZmIC0tZ2l0IGEvbmV0L3RpcGMvbXNnLmMgYi9uZXQvdGlwYy9tc2cuYyBp
bmRleA0KPj4gPiA+PiA+NzYyODRmYzUzOGViLi45ZjRmNjEyZWUwMjcNCj4+ID4gPj4gPjEwMDY0
NA0KPj4gPiA+PiA+LS0tIGEvbmV0L3RpcGMvbXNnLmMNCj4+ID4gPj4gPisrKyBiL25ldC90aXBj
L21zZy5jDQo+PiA+ID4+ID5AQCAtMTc3LDggKzE3Nyw5IEBAIGludCB0aXBjX2J1Zl9hcHBlbmQo
c3RydWN0IHNrX2J1ZmYNCj4+ID4gPj4gPioqaGVhZGJ1Ziwgc3RydWN0IHNrX2J1ZmYgKipidWYp
DQo+PiA+ID4+ID4NCj4+ID4gPj4gPiAJaWYgKGZyYWdpZCA9PSBMQVNUX0ZSQUdNRU5UKSB7DQo+
PiA+ID4+ID4gCQlUSVBDX1NLQl9DQihoZWFkKS0+dmFsaWRhdGVkID0gMDsNCj4+ID4gPj4gPi0J
CWlmICh1bmxpa2VseSghdGlwY19tc2dfdmFsaWRhdGUoJmhlYWQpKSkNCj4+ID4gPj4gPisJCWlm
ICh1bmxpa2VseSghdGlwY19tc2dfdmFsaWRhdGUoaGVhZGJ1ZikpKQ0KPj4gPiA+PiA+IAkJCWdv
dG8gZXJyOw0KPj4gPiA+PiA+KwkJaGVhZCA9ICpoZWFkYnVmOw0KPj4gPiA+PiBUaGlzIGlzIGEg
a25vd24gaXNzdWUgYW5kIHdhcyByZXBvcnRlZCB2aWENCj4+ID4gPj4gaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L25ldGRldmJwZi9wYXRjaC8yMDI2MDMzMDIwNTMNCj4+ID4g
Pj4gMTMuMjQgMzMzNzItMS1uaWNob2xhc0BjYXJsaW5pLmNvbS8gVGhlIGF1dGhvciBkaWQgbm90
IHJlc3BvbmQgdG8NCj4+ID4gPj4gbXkgY29tbWVudC4NCj4+ID4gPj4gQ2FuIHlvdSBpbXByb3Zl
IHRoZSBmaXggYnkgYXBwbHlpbmcgbXkgcGF0Y2g/DQo+PiA+ID4NCj4+ID4gPkknZCBiZSBoYXBw
eSB0byBtYWtlIGFueSByZXF1aXJlZCBjaGFuZ2VzLg0KPj4gPiA+DQo+PiA+ID5Ib3dldmVyLCBp
cyB0aGlzIGFwcHJvYWNoIHN1cGVyaW9yIHRvIHNpbXBseSBwYXNzaW5nIGEgcmVmZXJlbmNlPw0K
Pj4gPiA+DQo+PiA+ID52MSBhcHBlYXJzIHRvIGJlIHNpbXBsZXIsIGVhc2llciB0byByZWFkIGFu
ZCBhdm9pZHMgdGhlIGV4cGxhbmF0aW9uLg0KPj4gPiA+DQo+PiA+IEFzIEkgZXhwbGFpbmVkLCB5
b3VyIGZpeCBhZGRzIGV4dHJhIG92ZXJoZWFkIHRvIG5vcm1hbCBwYXRoIHdoaWxlIHRoZSBlcnJv
cg0KPnBhdGggaXMgY29ybmVyIGNhc2UgYW5kIGl0IHJhcmVseSBoYXBwZW5zLg0KPj4gPiBXaGF0
ZXZlciBhcHByb2FjaCBpcyBhcHBsaWVkLCB3ZSBuZWVkIHRvIGFkZCBleHBsYW5hdGlvbiB0byB1
bmRlcnN0YW5kDQo+bW9yZSBlYXNpbHkgdGhlIGxvZ2ljIGFuZCBoaWRkZW4gdHJpY2sgaW4gdGlw
Y19tc2dfdmFsaWRhdGUoKS4NCj4+DQo+PiBWZXJ5IHdlbGwuICBJIGhhdmUgbWFkZSB0aGUgcmVj
b21tZW5kZWQgY2hhbmdlcy4NCj4+DQo+PiBUaGUgcGF0Y2ggaXMgY3VycmVudGx5IGluIG15IGJ1
aWxkLXRlc3QgZW52aXJvbm1lbnQuDQo+Pg0KPj4gSSB3aWxsIHBvc3QgdjIsIHdoZW4gZXZlcnl0
aGluZyBoYXMgYmVlbiBzYXRpc2ZpZWQuDQo+DQo+T2theSwgSSBnZW51aW5lbHkgdHJpZWQgdG8g
YXBwbHkgeW91ciBwYXRjaC4gIEl0IGJ1aWxkcyBqdXN0IGZpbmUsIGJ1dCBHZW1pbmkgKHRoZQ0K
PkFJIEkgdXNlIHRvIHByZS1yZXZpZXcgcGF0Y2hlcyBiZWZvcmUgc3VibWlzc2lvbikgaGFzIHNv
bWUgZG91YnRzIHRoYXQgdGhpcyBpcw0KPnRoZSBjb3JyZWN0IGFwcHJvYWNoOg0KPg0KPj4gQEAg
LTE3Nyw4ICsxNzcsMjAgQEAgaW50IHRpcGNfYnVmX2FwcGVuZChzdHJ1Y3Qgc2tfYnVmZiAqKmhl
YWRidWYsDQo+PiBzdHJ1Y3Qgc2tfYnVmZiAqKmJ1ZikNCj4+DQo+PiAgICAgICBpZiAoZnJhZ2lk
ID09IExBU1RfRlJBR01FTlQpIHsNCj4+ICAgICAgICAgICAgICAgVElQQ19TS0JfQ0IoaGVhZCkt
PnZhbGlkYXRlZCA9IDA7DQo+PiAtICAgICAgICAgICAgIGlmICh1bmxpa2VseSghdGlwY19tc2df
dmFsaWRhdGUoJmhlYWQpKSkNCj4+ICsNCj4+ICsgICAgICAgICAgICAgLyogSWYgdGhlIHJlYXNz
ZW1ibGVkIHNrYiBoYXMgYmVlbiBmcmVlZCBpbg0KPj4gKyAgICAgICAgICAgICAgKiB0aXBjX21z
Z192YWxpZGF0ZSgpIGJlY2F1c2Ugb2YgYW4gaW52YWxpZCB0cnVlc2l6ZSwNCj4+ICsgICAgICAg
ICAgICAgICogdGhlbiBoZWFkIHdpbGwgcG9pbnQgdG8gYSBuZXdseSBhbGxvY2F0ZWQgcmVhc3Nl
bWJsZWQNCj4+ICsgICAgICAgICAgICAgICogc2tiLCB3aGlsZSAqaGVhZGJ1ZiBwb2ludHMgdG8g
ZnJlZWQgcmVhc3NlbWJsZWQgc2tiLg0KPj4gKyAgICAgICAgICAgICAgKiBJbiBzdWNoIGNhc2Vz
LCBjb3JyZWN0ICpoZWFkYnVmIGZvciBmcmVlaW5nIHRoZSBuZXdseQ0KPj4gKyAgICAgICAgICAg
ICAgKiBhbGxvY2F0ZWQgcmVhc3NlbWJsZWQgc2tiIGxhdGVyLg0KPj4gKyAgICAgICAgICAgICAg
Kg0KPj4gKyAgICAgICAgICAgICAgKiBOb3RlOiBJdCdzIGRvbmUgdGhpcyB3YXkgaW5zdGVhZCBv
ZiBwYXNzaW5nICZoZWFkICAgICAgICAgIC8vIEkgYWRkZWQNCj50aGlzIHBhcnQgdG8gZ2l2ZQ0K
Pj4gKyAgICAgICAgICAgICAgKiB0byBhdm9pZCBzbG93aW5nIGRvd24gdGhlIGhhcHB5IHBhdGgg
c2luY2UgdGhpcyBmYWlsdXJlICAgIC8vIHRoZQ0KPnJldmlld2VyIHNvbWUgYWRkaXRvaW5hbA0K
Pj4gKyAgICAgICAgICAgICAgKiBpcyBhIHJhcmUgZXZlbnQuICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIC8vIGNvbnRleHQNCj4+ICsgICAgICAgICAgICAgICovDQo+
PiArICAgICAgICAgICAgIGlmICh1bmxpa2VseSghdGlwY19tc2dfdmFsaWRhdGUoaGVhZGJ1Zikp
KSB7DQpZb3UgZGlkIE5PVCBhcHBseSBteSBwYXRjaCBjb3JyZWN0bHkuIEkgZGlkIG5vdCBzdWdn
ZXN0IHBhc3NpbmcgaGVhZGJ1ZiB0byB0aXBjX21zZ192YWxpZGF0ZSgpLg0KTXkgcGF0Y2ggaXMg
dmVyeSBzaW1wbGU6DQorICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KCF0aXBjX21zZ192YWxp
ZGF0ZSgmaGVhZCkpKSB7DQorICAgICAgICAgICAgICAgICAgICAgICAvKiByZWFzc2VtYmxlZCBz
a2IgaGFzIGJlZW4gZnJlZWQgaW4NCisgICAgICAgICAgICAgICAgICAgICAgICAqIHRpcGNfbXNn
X3ZhbGlkYXRlKCkgYmVjYXVzZSBvZiBpbnZhbGlkIHRydWVzaXplLg0KKyAgICAgICAgICAgICAg
ICAgICAgICAgICogaGVhZCBub3cgcG9pbnRzIHRvIG5ld2x5LWFsbG9jYXRlZCByZWFzc2VtYmxl
ZCBza2INCisgICAgICAgICAgICAgICAgICAgICAgICAqIHdoaWxlICpoZWFkYnVmIHBvaW50cyB0
byBmcmVlZCByZWFzc2VtYmxlZCBza2IuDQorICAgICAgICAgICAgICAgICAgICAgICAgKiBTbywg
Y29ycmVjdCAqaGVhZGJ1ZiBmb3IgZnJlZWluZyBuZXdseS1hbGxvY2F0ZWQNCisgICAgICAgICAg
ICAgICAgICAgICAgICAqIHJlYXNzZW1ibGVkIHNrYiBsYXRlci4NCisgICAgICAgICAgICAgICAg
ICAgICAgICAqLw0KKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGhlYWQgIT0gKmhlYWRidWYp
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICpoZWFkYnVmID0gaGVhZDsNCisNCiAg
ICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyOw0KKyAgICAgICAgICAgICAgIH0NCg0KPj4g
KyAgICAgICAgICAgICAgICAgICAgIGlmIChoZWFkICE9ICpoZWFkYnVmKQ0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKmhlYWRidWYgPSBoZWFkOw0KPj4gICAgICAgICAgICAgICAg
ICAgICAgIGdvdG8gZXJyOw0KPj4gKyAgICAgICAgICAgICB9DQo+PiArDQo+DQo+ICAiSXQgbG9v
a3MgbGlrZSB0aGlzIGxvZ2ljIG1pZ2h0IHJlLWludHJvZHVjZSB0aGUgZG91YmxlLWZyZWUgYnVn
Lg0KPiAgIFRoZSBjYWxsIHRvIGB0aXBjX21zZ192YWxpZGF0ZShoZWFkYnVmKWAgaXMgY29ycmVj
dCwgYXMgaXQgcGFzc2VzIHRoZQ0KPiAgIHBvaW50ZXItdG8tcG9pbnRlciBhbmQgYWxsb3dzIHRo
ZSBjYWxsZWUgdG8gdXBkYXRlIGAqaGVhZGJ1ZmAgaWYgdGhlIHNrYg0KPiAgIGlzIHJlYWxsb2Nh
dGVkLg0KPg0KPiAgIEhvd2V2ZXIsIHRoZSBzdWJzZXF1ZW50IGNoZWNrIHNlZW1zIHRvIHVuZG8g
dGhpcy4gSWYgYSByZWFsbG9jYXRpb24NCj4gICBoYXBwZW5zLCBgaGVhZGAgd2lsbCBob2xkIHRo
ZSBwb2ludGVyIHRvIHRoZSBvbGQsIGZyZWVkIHNrYiwgd2hpbGUNCj4gICBgKmhlYWRidWZgIHdp
bGwgaG9sZCB0aGUgbmV3IG9uZS4gVGhlIGNvbmRpdGlvbiBgaGVhZCAhPSAqaGVhZGJ1ZmAgd2ls
bA0KPiAgIGJlIHRydWUsIGFuZCB0aGUgYXNzaWdubWVudCBgKmhlYWRidWYgPSBoZWFkYCB3aWxs
IHJlc3RvcmUgdGhlIHN0YWxlDQo+ICAgcG9pbnRlciwgbGVhZGluZyB0byBhIGRvdWJsZS1mcmVl
IG9uIHRoZSBgZXJyYCBwYXRoLg0KPg0KPiAgIFRoZSBwcmVjZWRpbmcgY29tbWVudCBhbHNvIGFw
cGVhcnMgdG8gaGF2ZSB0aGUgcG9pbnRlciByb2xlcyByZXZlcnNlZC4NCj4NCj4gICBXb3VsZCBp
dCBiZSBzaW1wbGVyIGFuZCBtb3JlIGNvcnJlY3QgdG8gcmVtb3ZlIHRoZSBgaWYgKGhlYWQgIT0g
KmhlYWRidWYpYA0KPiAgIGNoZWNrIGFuZCB0aGUgbGFyZ2UgY29tbWVudCBibG9jaz8gVGhlIGNo
YW5nZSBmcm9tIGAmaGVhZGAgdG8gYGhlYWRidWZgDQo+ICAgaW4gdGhlIGZ1bmN0aW9uIGNhbGwg
c2VlbXMgdG8gYmUgdGhlIG9ubHkgY2hhbmdlIHJlcXVpcmVkIHRvIGZpeCB0aGUgYnVnLg0KPiAg
IEFsc28sIHBsZWFzZSB1cGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdlIHRvIHJlZmxlY3QgdGhlIGNv
cnJlY3RlZCBsb2dpYy4iDQo+DQo+SSBzdWdnZXN0IHRoYXQgd2UgZ28gd2l0aCB0aGUgb3JpZ2lu
YWwgcGF0Y2guICBBbHRob3VnaCBJIGZpbmQgaXQgYWRtaXJhYmxlIHRoYXQNCj55b3UgYXJlIHRo
aW5raW5nIGFib3V0IGFuZCBhdHRlbXB0aW5nIHRvIHByb3RlY3QgdGhlIG1vcmUgY29tbW9uIGhh
cHB5LQ0KPnBhdGgsIEkgdGhpbmsgdGhlIHJlc3VsdGFudCBzaW5nbGUgYWRkaXRpb25hbCB2YXJp
YWJsZSBhc3NpZ25tZW50IGlzIG5lZ2xpZ2libGUNCj5hbmQgdGhhdCB0aGUgc2ltcGxpY2l0eSBv
ZiB0aGUgcHJldmlvdXMgZml4IGhhcyBncmVhdGVyIGJlbmVmaXRzIGluIHRlcm1zIG9mIGNvZGUN
Cj5yZWFkYWJpbGl0eSBhbmQgbWFpbnRhaW5hYmlsaXR5Lg0KPg0KPklmIHlvdSBsaWtlLCBJIGNh
biBhZGQgYSBzbWFsbCBjb21tZW50LCBidXQgSSBkb3VidCBldmVuIHRoYXQgaXMgbmVjZXNzYXJ5
Lg0KPg0KPi0tDQo+TGVlIEpvbmVzIFvmnY7nkLzmlq9dDQo=

