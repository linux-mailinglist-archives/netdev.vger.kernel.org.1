Return-Path: <netdev+bounces-297037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c1JoJFgFKGq67QIAu9opvQ
	(envelope-from <netdev+bounces-297037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 14:21:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0984565FFF5
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 14:21:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=DfeLmf67;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297037-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297037-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93DDB304A8F8
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 12:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B7740F8CF;
	Tue,  9 Jun 2026 12:14:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A481E40BCDA;
	Tue,  9 Jun 2026 12:14:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007282; cv=fail; b=pCmMtmICdEF1JB7Lm7aHowezHF/bF+qAn+e77yTVNa8I+sdhcLmrrnvgbiazVjFj7zrWt9JCCXjMXAxuWIT1t3U7vHjFyBs5e00IcVro4044FuB8u1F5/mB5sdR5puImfqCZI2gsiwpUgRbN4YOAkDG+f1SB5ytSNe9RUneyrJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007282; c=relaxed/simple;
	bh=B4C9WMb65IdNf9ZB5XU7TzLhFYMluND3/LqEZNjCvO8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pMWyuS7rUERjucHp/aiY4buwYJ0iLliJzRGvhva4e0R2Cfy0gTvN1I0x43Ro1v8UQ8SZxPwxfY2exEqTFx7Kdze4OcOvtMDxitKeF4dS9GHK6q19xBSQ9G4R08Uf/u02eZCayy9rFwpEV+gJIU0wNAWseAZzPvsEH5bR3HV2u3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=DfeLmf67; arc=fail smtp.client-ip=52.101.62.68
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grjmPDu+CQm1BHte7Im24KUmbEWmq19Kbl4g8IFPlWRL8D3Q22SWLKchGjdRcgzw1/1AI3GAnODT+8H3bPLUeXj2eus4IZT7n1rVyj44om1CVdm+2n3EaPO6g1C2Uk7OPYn1zpHnA1T181mc+PkKOXf6ye5DWLqzDxtAVy5F8ujdlkwK9qB7dzeVCFqd19G7I7eeArt3NdmyZ42Pdq6WPZpISqLgSZfD6fyWozsXaeWMcZ29E9RFMeO+Uzku1AuR1vFX4Cn+2dBxA+bh7FQ5KSGLRDgQHpJww6k2GpRRnf1bfSo/ZsISLujl2HQbQpgkxzCJzsVPeuZodLE4E9YtEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4C9WMb65IdNf9ZB5XU7TzLhFYMluND3/LqEZNjCvO8=;
 b=a9qRy5rr+JNvI5ciV/XTd6oWlFzb+19YOAQ+UA7GwsqDFLmdyCL6QpICdPNHX+CfUg7IOKcX4dDnd9fnWn6/cY9Y1+iSmin93ySPvsdLXPw/x7Xf01kw1MI63OZkBEyNFabr5ACEj5OlqRcjwNzPR/EX+zn/SQu97J9Tj3kjdd0hbXTA/rZDp6v7bl2OKcOdcoaDtANmqMnq6b44822ApNZvlrO1PuSidhBiHPSn3ZDai8w8A7tgL7Wgl5PLl99vJSJc01322K2NsYYKrWLzJcaOf3KcD1uVSNjdAiR81SyojaMyIY+paLyqsk45lzhRsD5UUDCOpRjzzmB403GOeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4C9WMb65IdNf9ZB5XU7TzLhFYMluND3/LqEZNjCvO8=;
 b=DfeLmf67AO4mgkB5HQ6r27dJq7Z+WFnd2PXLzONAkaJRr1uvJJ2tFi7zYjy33fl8/kUch/PYACsdhHNrg0nhlSVNk5gDY1BcSHmyro0jEqY9O+MM+vc1MItY7TKFzQ+sEHWebsyz9jUMwOjNchn0uRAlb35T0uvhgRRXflBLlVg6KO2CneBN6iMI0qNSKy4HuQ611XwGNg2NPlUfBoVwY4aeOllDSdb8BEVhz32RC4OY0BO/Y7n0URa77Z5tA63qB6SNqC2EU5blxOwaFnrEGzhpxg7Q6b4+WQnUEesbyDrmkrG4SMQFTOH5fgmRGcF3bAnKRYbkRwTMmsoLn4F7IA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by MN2PR03MB4959.namprd03.prod.outlook.com (2603:10b6:208:1a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 12:14:37 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 12:14:37 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"Jose.Abreu@synopsys.com" <Jose.Abreu@synopsys.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: stmmac: xgmac2: disable RBUE in default RX
 interrupt mask
Thread-Topic: [PATCH v2] net: stmmac: xgmac2: disable RBUE in default RX
 interrupt mask
Thread-Index: AQHc9AbX/oHwW0LOEU2/x0EyQwzs87Y0zoaAgAEppICAADLagA==
Date: Tue, 9 Jun 2026 12:14:36 +0000
Message-ID: <a343fd07-385d-442f-9895-5b5a31439266@altera.com>
References:
 <20260604094512.21243-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260608152717.157757-1-horms@kernel.org>
 <8bac773f-5016-4afb-8506-9d48eb2e70d0@redhat.com>
In-Reply-To: <8bac773f-5016-4afb-8506-9d48eb2e70d0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|MN2PR03MB4959:EE_
x-ms-office365-filtering-correlation-id: 7aed2a9e-5fac-48d4-7654-08dec620ac97
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|55112099003|38070700021|6133799003|18002099003|22082099003|11063799006|3023799007|4133799003|4143699003|56012099006|5023799004;
x-microsoft-antispam-message-info:
 ROTGksn4zyH0a3MeoElGZ52d6RgSBTcMfzUB+ONbxkavf26grxpRiZUIMrqRR2BC3f9sxqQhnQdXPMsl+02MvjIeT3Ic1dypO2C1m2Sl5x1V4RHLFIHHy/ag8JNxQGYlBhon44mRNslBYgKrVqY2Jdi330vyglShih98Jti2UZSWkbTjpGQr7l34k8Lug1o2KqWrRYsFAXp/YMVrF/ZY8aGLcZwPZgdp+x/WBlt3zbS+0xCRV2NUHjyvV70+KWwTFizv8POwnopb7uycD6vBI0K8GtCdCwoYjIYHQfN8n4jSkRnSrt4cq0+4p8eqtO7sSn1zPREzmZy8x2Z3w8AT94KN/MbT+rc272topme0kKbRqjGGMl609VAdIkQOJi37rqSqYcTYQCA0rdIwgz3iTPnBtN/AbOkzaMvlcYNZMtkRvpOyYeSKyoBNHdfODsmVqDR0QOMhtoEnvwD7mfWnS9GIlVNpq/0zYqoZQIj9wCbItOJ/URMBP4moglm6LFqnT0K6sKv8jAQ9YuWTnEDguZr96gVw7DBFio7O/TXmFXTOF7LlAZrpipyZdaNI0bh2F+88kqCy7na1GhKk//yu/ytWI8671hKzubADbH0vX8zB4yKCTfZt0JZpdlP+3TWDoMbMUHxgcfwYFVoYrSocKY+4horS4RAXrG6yP2y1S5bP6FN2OmEt5xOJOzu4WMC1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(55112099003)(38070700021)(6133799003)(18002099003)(22082099003)(11063799006)(3023799007)(4133799003)(4143699003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1BWVWxRU3M4c0RacTliS1pGVXg2cEFVbHJndUdkcU1NbW5BTTVHbDJsVU9Z?=
 =?utf-8?B?RmpzS3pkSmhsUGpJZTNMaFBCVzIwL2pHdFVNMHFkUGZNcFEzamtTaGl6M1JJ?=
 =?utf-8?B?c0U2NWEvMjR1ekpkSVVzTGVPT3FrMmszVVdBV2pHZXU2UC9rT3YwMWV3S1pH?=
 =?utf-8?B?UytyZXFsUDVQSk1HTVo2Q09XRFZ3ZVIyTlVzTmdUTFpVTkhSSW1HdVlCNE5H?=
 =?utf-8?B?V2wxUkgyVGtRUk1sNEw3QnNiMlFKa2poWXl0dCtYNm1BSkw5VmxmRVVQdW5x?=
 =?utf-8?B?VmViMUxud0UyWFdvQm1RaG9zalhnbGZ5dVdsNlBzODE1UVk1ZlFvSlNNZlRH?=
 =?utf-8?B?dVZDQU1YcGMzTytJVHhueHl0NVBmbDdYR0R4MFVwS0J5WnQxQ1JCZEJFb0tu?=
 =?utf-8?B?SjU5Q3V5eUprdUE1OHJjajRtazErTHJ4dElIalNYMWRWR2w5Mzlpcm00TTBt?=
 =?utf-8?B?MjhLWWhJWVM4VDV0RGREYWxHeXJJNTN6N0tQS2VXMXkrbWovMUpIQ2F4SXor?=
 =?utf-8?B?a21tcXl5SEtPT1lyd1dBOEg2bDQ3dUV5V2pReUxYQ0ZWNk55RmtBbkxRc1lx?=
 =?utf-8?B?V3ZrdFRYZWkzZXpjQm9TNzNpMDFURWowREFKUU5VSFNlRW9jWFNINVRRVFFU?=
 =?utf-8?B?KzE3dnNPUUgwSithYWt6YXJuT0luWksvMVhGNFVOMUt6cVU1VnZRQTF0YjFa?=
 =?utf-8?B?Z2s1dDJ4M0s1R1JiZ1ZyOEc1TG03MmtLcHN1OXpCZVdxc3pHNkFuaGtwS0N3?=
 =?utf-8?B?MEtjZDFobExkLzVEeEYrL3pHbU1aamlsdVQzb3U1K1ZEV3FCajVkOUV4em9S?=
 =?utf-8?B?aEhFVU5ZZjVtenNCSEMvVVg0NzlMQjRNbmxQM0swbTZIa0cxY1pLeWNmNWhG?=
 =?utf-8?B?cnQ5ZWtvajkwM0ZRNFoyeG9BYktLbjNiSHk2WFFPcW9mRi9vVmhuclNkWWpq?=
 =?utf-8?B?OXdpSUFNcDBGTklZb29nZnc2MWpKT3dzQXZ2YlNUbFp1a0ZHUkllN2ZuMzRI?=
 =?utf-8?B?REY4Q1VDSWRIMWFicVlWc1lkcUdpbCt3R045MFBBWkx5eXorUE83dGtWL3Jm?=
 =?utf-8?B?bHgwTGkzdWtEMCtsbjhLUk9kSHAwNkVvQktkTTdRclJrZUNFV2JmM1lXcHVz?=
 =?utf-8?B?elh5dGNVc1JBeHhYREI1Z3hTazJwS0p6aXYrNytma3hoODh1UVpPWm9rMGRs?=
 =?utf-8?B?c2hxN0loN0lHYzQrZTRnRWFtMzVibSs5UC9jNGVEeEh4aTZMbjVJQmhMMGlK?=
 =?utf-8?B?U083SHVUd1kzQUpMdFluRzVRa0RsUXBFckxYbHVsWUc5YktaaXIrWWJIWFpS?=
 =?utf-8?B?R3FGREVMU0JqVmVoc2NEcHN2am5nRXNXZmQ2WFdLSElSTUNKZnZldE9sTTdn?=
 =?utf-8?B?TUtZRlFIbG1lNjBQcjdEQXJ1WkVBQk51cTN5ZUNRb2JHOTYzczdnTVBEeWZB?=
 =?utf-8?B?NWQ3N0o4ZG1JaXVWWloybElXUGFXL2Zqc3VHa2hnK3FrS2x2UVE4VlYwT2ZM?=
 =?utf-8?B?WGF0RmIxenlwR2Q1T3pvTExKVVd5cXNIYjhQSVRyUWJIWGZRK3FRUXB4OEt1?=
 =?utf-8?B?OTRMMW9IanVjZ2hxcmhwemtVSkV2WXk0Y3l2ODBpd2UvYXllN2UvNzh4Q3Iw?=
 =?utf-8?B?NTBZQW00bUpEamUvc3lGdHVXSnB4RnJSVDRIUmxPVTJQYlZHOFhIVnpiM21t?=
 =?utf-8?B?TnNEN0labnlmV1lGTE1XSmcrYUhEVDJ5SnROWHJHS3ViMDdGSStiR1pWTm5G?=
 =?utf-8?B?VFU1MzhDOXgzRTVqR215VlB5Y1l5bmlFcGc0T3M4WW9XSnMxc0EwRDkvSk15?=
 =?utf-8?B?Y2ovZ2ErWGVzYVRmaHhBZzI0bU1tRFZ2ck41Q0tCVlgrb0ZYWXRHb0FjeDJl?=
 =?utf-8?B?WFNXcUFMTHJpN0REdzlCZmRkNVBIOThCUStOSWQ4azZyRFVudGxRT2g3M21O?=
 =?utf-8?B?a251a3hyOGJKZCt2bHVJSnkwdDJCVjVRQzU5ODgxUjJadUp0MHNuQW41d1dI?=
 =?utf-8?B?L2NFUFFXbWorQTljMWJpa2ZudWhiVWRvT1cwblJ2S015S2xnK29hT1dLYlJo?=
 =?utf-8?B?RzJ1djRPMjg0VEVnQUxJV0ZGTnBST0xzOXVXbndsaUhlQnhHVzBsWEpBMVNa?=
 =?utf-8?B?dE9qN0JJKzN2SFN6NWdNRDZJT0pBLzNyWXVTc3laRDNnbUhZY05LMGgranpm?=
 =?utf-8?B?NGZzLzJYMlUrRzV1WHBTVXlzTFpycjYvT283WmtuenEwQkNnbjJTYm1qMzBY?=
 =?utf-8?B?K21SRmQ1b3VrU3k4L2pZMnJEeVNIVGxicUYzVjd0R051Sjk2bjYyaE0xdmR0?=
 =?utf-8?B?eFA2ZkRBVGJMWmRGYjNWR0g3ZzkrWDlKeXRkc2MzUzlXSjlZbGdsVW9yZjhh?=
 =?utf-8?Q?NKUAzmL5rnqeEq7qAFiixWfsbD7ObOvDVHWpEpg4swzIS?=
x-ms-exchange-antispam-messagedata-1: xiHMbcbVn9xoyw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE4328E8D0354C45ADFF74F26FDC83AA@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aed2a9e-5fac-48d4-7654-08dec620ac97
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 12:14:36.9862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vE+PhzfWn5cRvnUoM5mElfIYMCoY1/fWSrwINOoThQ6rlFbQIXW4MIDZFDc1YDQjaENlCJMFoBbrbfKMI1SM774nTBT+4pjGAZG+WC6nNLVYCjA+A9ZOm84ikBkKw+0lspMdJlodDduMpn948sKKtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4959
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297037-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,synopsys.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0984565FFF5

T24gOS82LzIwMjYgNToxMiBwbSwgUGFvbG8gQWJlbmkgd3JvdGU6DQo+IE9uIDYvOC8yNiA1OjI3
IFBNLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+PiBGcm9tOiAnU2ltb24gSG9ybWFuJyA8aG9ybXNA
a2VybmVsLm9yZz4NCj4+DQo+PiBUaGlzIGlzIGFuIEFJLWdlbmVyYXRlZCByZXZpZXcgb2YgeW91
ciBwYXRjaC4gVGhlIGh1bWFuIHNlbmRpbmcgdGhpcw0KPj4gZW1haWwgaGFzIGNvbnNpZGVyZWQg
dGhlIEFJIHJldmlldyB2YWxpZCwgb3IgYXQgbGVhc3QgcGxhdXNpYmxlLg0KPj4gRnVsbCByZXZp
ZXcgYXQ6IGh0dHBzOi8vc2FzaGlrby5kZXYvDQo+PiAtLS0NCj4+IG5ldDogc3RtbWFjOiB4Z21h
YzI6IGRpc2FibGUgUkJVRSBpbiBkZWZhdWx0IFJYIGludGVycnVwdCBtYXNrDQo+Pg0KPj4gVGhp
cyBjb21taXQgcmVtb3ZlcyB0aGUgUlggQnVmZmVyIFVuYXZhaWxhYmxlIChSQlVFKSBpbnRlcnJ1
cHQgZnJvbSB0aGUNCj4+IGRlZmF1bHQgZW5hYmxlIG1hc2tzIGZvciBYR01BQzIgZGV2aWNlcy4g
VGhpcyBpcyBpbnRlbmRlZCB0byBwcmV2ZW50IE1BQw0KPj4gaW50ZXJydXB0IHN0b3JtcyB0aGF0
IGNhbiBvY2N1ciB1bmRlciBoZWF2eSBSWCBwcmVzc3VyZSB3aGVuIHRoZSBETUENCj4+IHJ1bnMg
b3V0IG9mIFJYIGRlc2NyaXB0b3JzLg0KPj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvZHd4Z21hYzIuaCBiL2RyaXZlcnMvbmV0L2V0aGVybmV0
L3N0bWljcm8vc3RtbWFjL2R3eGdtYWMyLmgNCj4+PiBpbmRleCA1MTk0MzcwNWEyYjAzLi5iNWZk
YzI1M2EyZjI0IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8v
c3RtbWFjL2R3eGdtYWMyLmgNCj4+PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1pY3Jv
L3N0bW1hYy9kd3hnbWFjMi5oDQo+Pj4gQEAgLTM3OSw5ICszNzksOSBAQA0KPj4+ICAgI2RlZmlu
ZSBYR01BQ19SSUUgICAgICAgICAgICAgICAgIEJJVCg2KQ0KPj4+ICAgI2RlZmluZSBYR01BQ19U
QlVFICAgICAgICAgICAgICAgICAgICAgICAgQklUKDIpDQo+Pj4gICAjZGVmaW5lIFhHTUFDX1RJ
RSAgICAgICAgICAgICAgICAgQklUKDApDQo+Pj4gLSNkZWZpbmUgWEdNQUNfRE1BX0lOVF9ERUZB
VUxUX0VOICAgKFhHTUFDX05JRSB8IFhHTUFDX0FJRSB8IFhHTUFDX1JCVUUgfCBcDQo+Pj4gKyNk
ZWZpbmUgWEdNQUNfRE1BX0lOVF9ERUZBVUxUX0VOICAgKFhHTUFDX05JRSB8IFhHTUFDX0FJRSB8
IFwNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBYR01BQ19SSUUgfCBY
R01BQ19USUUpDQo+Pj4gLSNkZWZpbmUgWEdNQUNfRE1BX0lOVF9ERUZBVUxUX1JYICAgKFhHTUFD
X1JCVUUgfCBYR01BQ19SSUUpDQo+Pj4gKyNkZWZpbmUgWEdNQUNfRE1BX0lOVF9ERUZBVUxUX1JY
ICAgKFhHTUFDX1JJRSkNCj4+DQo+PiBbU2V2ZXJpdHk6IEhpZ2hdDQo+PiBEb2VzIHJlbW92aW5n
IHRoZSBSQlVFIGludGVycnVwdCBicmVhayB0aGUgZHJpdmVyJ3MgYWJpbGl0eSB0byByZWNvdmVy
IGZyb20NCj4+IFJYIG91dC1vZi1tZW1vcnkgY29uZGl0aW9ucywgbGVhZGluZyB0byBhIHBlcm1h
bmVudCBSWCBxdWV1ZSBzdGFsbD8NCj4+DQo+PiBXaGVuIHN0bW1hY19yeCgpIHByb2Nlc3NlcyBw
YWNrZXRzLCBpdCBjYWxscyBzdG1tYWNfcnhfcmVmaWxsKCkgdG8gcmVwbGVuaXNoDQo+PiB0aGUg
cmluZyBkZXNjcmlwdG9ycy4gSWYgcGFnZV9wb29sX2FsbG9jX3BhZ2VzKCkgZmFpbHMgZHVlIHRv
IG1lbW9yeQ0KPj4gcHJlc3N1cmUsIHRoZSBkZXNjcmlwdG9ycyByZW1haW4gZW1wdHk6DQo+Pg0K
Pj4gZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX21haW4uYzpzdG1t
YWNfcnhfcmVmaWxsKCkgew0KPj4gICAgICAuLi4NCj4+ICAgICAgYnVmLT5wYWdlID0gcGFnZV9w
b29sX2FsbG9jX3BhZ2VzKHJ4X3EtPnBhZ2VfcG9vbCwgZ2ZwKTsNCj4+ICAgICAgaWYgKCFidWYt
PnBhZ2UpDQo+PiAgICAgICAgICBicmVhazsNCj4+ICAgICAgLi4uDQo+PiB9DQo+Pg0KPj4gc3Rt
bWFjX3J4KCkgdGhlbiByZXR1cm5zIHRoZSBudW1iZXIgb2YgcHJvY2Vzc2VkIHBhY2tldHMsIHdo
aWNoIHdpbGwgYmUNCj4+IGxlc3MgdGhhbiB0aGUgTkFQSSBidWRnZXQgaWYgdGhlIHJpbmcgaXMg
ZW1wdHkuIFRoaXMgY2F1c2VzDQo+PiBzdG1tYWNfbmFwaV9wb2xsX3J4KCkgdG8gY29tcGxldGUg
TkFQSSBhbmQgcmUtZW5hYmxlIGludGVycnVwdHM6DQo+Pg0KPj4gZHJpdmVycy9uZXQvZXRoZXJu
ZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX21haW4uYzpzdG1tYWNfbmFwaV9wb2xsX3J4KCkgew0K
Pj4gICAgICAuLi4NCj4+ICAgICAgd29ya19kb25lID0gc3RtbWFjX3J4KHByaXYsIGJ1ZGdldCwg
Y2hhbik7DQo+PiAgICAgIGlmICh3b3JrX2RvbmUgPCBidWRnZXQgJiYgbmFwaV9jb21wbGV0ZV9k
b25lKG5hcGksIHdvcmtfZG9uZSkpIHsNCj4+ICAgICAgICAgIC4uLg0KPj4gICAgICAgICAgc3Rt
bWFjX2VuYWJsZV9kbWFfaXJxKHByaXYsIHByaXYtPmlvYWRkciwgY2hhbiwgMSwgMCk7DQo+PiAg
ICAgIH0NCj4+ICAgICAgLi4uDQo+PiB9DQo+Pg0KPj4gV2hlbiB0aGUgaGFyZHdhcmUgc3Vic2Vx
dWVudGx5IHRyaWVzIHRvIHJlY2VpdmUgYSBwYWNrZXQsIGl0IGZpbmRzIG5vDQo+PiBkZXNjcmlw
dG9ycyBhbmQgZW50ZXJzIHRoZSBSZWNlaXZlIEJ1ZmZlciBVbmF2YWlsYWJsZSAoUkJVKSBzdGF0
ZS4gQnkNCj4+IHJlbW92aW5nIFhHTUFDX1JCVUUgZnJvbSB0aGUgUlggaW50ZXJydXB0IGVuYWJs
ZSBtYXNrLCB0aGUgTUFDIHdpbGwgbm8NCj4+IGxvbmdlciB0cmlnZ2VyIGFuIGludGVycnVwdCBm
b3IgdGhlIFJCVSBzdGF0ZS4NCj4+DQo+PiBCZWNhdXNlIG5vIHBhY2tldHMgY2FuIGJlIHN1Y2Nl
c3NmdWxseSByZWNlaXZlZCB3aXRob3V0IGRlc2NyaXB0b3JzLCB0aGUNCj4+IG5vcm1hbCBSZWNl
aXZlIEludGVycnVwdCAoUklFKSB3aWxsIGFsc28gbmV2ZXIgZmlyZS4gV2l0aCBOQVBJIHN0b3Bw
ZWQgYW5kDQo+PiBubyBpbnRlcnJ1cHRzIGZpcmluZywgdGhlIGRyaXZlciBoYXMgbm8gcG9sbGlu
ZyB0aW1lciB0byByZXRyeSBhbGxvY2F0aW9uLA0KPj4gd2hpY2ggY291bGQgcmVzdWx0IGluIGEg
cGVybWFuZW50IHN0YWxsIG9mIHRoZSBSWCBxdWV1ZS4NCj4NCj4gTmF6aW0sIHlvdSBuZWVkIGF0
IGxlYXN0IHRvIGNsYXJpZnkgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIHdoeSB0aGlzIHBhdGNoDQo+
IGlzIHNhZmUuDQo+DQo+IC9QDQo+DQpIaSBTaW1vbiwgUGFvbG8NCg0KVGhhbmtzIGZvciB0aGUg
cmV2aWV3ISBXaWxsIHNlbmQgb3V0IHYzIHdpdGggY29tbWl0IG1lc3NhZ2UgdXBkYXRlZC4NCg0K
QlIsDQpOYXppbQ0K

