Return-Path: <netdev+bounces-181460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08203A85112
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 03:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E305D189F1D8
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 01:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1C126FA6B;
	Fri, 11 Apr 2025 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="DwBm+h0k"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C282A94F;
	Fri, 11 Apr 2025 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333830; cv=fail; b=q87s4fSTGqP5dMcqYccc6BnuSAlbMuc90sxJVN2xfdw8BpA8Yfes0jXVmbDRTvFlhD4NyeB66aU5ViW9dVst7ea2dCblzkcghC8Z6qn5zZ6RyktLDR9XmbdRWfuQu6KMDEDnHgUcxk8hxt0BcCv+ZSsavmn8QWlWQnogYoVkqLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333830; c=relaxed/simple;
	bh=xnL+QS1tGZ67BwZgSzo3Vr8X1W/mNYYfHKTd8g+n55k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bFzpd2+MzNQT06R/wAXsyP+HrynWOmI4UXKsaI3pK21KGpDJlUTgZUXVqFSE2ssaQlG8kau6u2+InPH/d5JpWWNJkmGUKi4H9Kom5xylvaEJR2UGlvH8Vl/sl8OzxPjNdIEZEU98/sVrdbKCaWJJcNwNVBsah2OqpYo7OSCfAk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=DwBm+h0k; arc=fail smtp.client-ip=40.107.21.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqfmLYHlp5IFBvKWHWJBoLF0I037NuqVdAxoT+QyHtELMKKgb3GzOZL8ETwvU/96bKekHEnknnd0P3gKEZ+zcmtzlw09C1aD1GsaYOskqBZ1ke0mwPbG22MJNzHrP2ec1lTJ0TQzzMyHhAF5CERxP0AEGsyLbpQ2TYW6OrllHgqgUOvj0rvhiW4MfuhOj5z8S/q893w2XQ9bZkfNh36i6PqTbshrB1NkRnfTg4Xzi5vyniVXUaT0WpAnjMspTAkUUYx8JjTUiH7Xeg3hlVSoZbZnF9E38/SEhNIiUvWhwZh+tbm4zk0QrPpbzK9fzhZ+E5YuM5skq+ULP7IDpqOgCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGg1DaOcJy9Ot/5L4EkRlo8HLepEbyoFKC+NnTRC4bo=;
 b=vKBgf9DdFAQSlIUqCIrhAFVBGziSICVQTtCRNr1qgR1nShOzR1HmO1C7b20DMn9PH11YcAoExVKxTs5I6/YTNWOcYjqMns+6PN3P+aqTJxJ+COXR894XL4Az2M1ZoiU/eMw2PBvJTb+h1Lfq9HuBIlBkc2B+FXHGmXRf3YP29ei2eK1TPKFaMS7+bgLUfMOMBw152jBPwrJuzdMgYdqr3sc4ggc91/v2LiCkpv84VwYv+A3dnQpA19HdXYcseYspaS64CB05pC4wsON/gBJudeLYiJxXF2AZshP1hJOlMC9ALMe9JeU2mWeeHBxxdeL7dAI6x0iqOmKYeytcCMzjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGg1DaOcJy9Ot/5L4EkRlo8HLepEbyoFKC+NnTRC4bo=;
 b=DwBm+h0k8Lklokm1khsf6ZJiZvaRcGNhJ7JTjVDMiB+7Nc8aAMvG5jJCazOj1t1BEb0UDA1S8jUBqbyJuk9JU9hGidj/v9DM5tbm6L9ISmyxPJMqvAPwz/xVlGrKXai3iYdZ+mBm0i+rNpPtv0jpcQhFMJxj59ZukP+O5sZIpIz8YqLwc7kxSJ7uFukEe3yX8faQ+qOlJQvQiGU9KGudyJpQ+DptQtTvgu7KMLzTxUGBcg7qMFp20K9ESIsMK/30ARqGh0sdHOClcI2rX/LNL9xkBfNOWfI46vjyCDld7do7ah3pdGtskSuxlc39xzQx9zQW7l4YXS7YAVGADzDTHw==
Received: from PRAP189MB1897.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:290::22)
 by PA4P189MB1183.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 01:10:24 +0000
Received: from PRAP189MB1897.EURP189.PROD.OUTLOOK.COM
 ([fe80::91d:6a2d:65d3:3da4]) by PRAP189MB1897.EURP189.PROD.OUTLOOK.COM
 ([fe80::91d:6a2d:65d3:3da4%4]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 01:10:24 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Removing deprecated strncpy()
Thread-Topic: [PATCH] Removing deprecated strncpy()
Thread-Index: AQHbqhUaBvG+2209iUauNCH8JO/y47Odp0LQ
Date: Fri, 11 Apr 2025 01:10:24 +0000
Message-ID:
 <PRAP189MB1897ABBF1EB2124C3F4FD05BC6B62@PRAP189MB1897.EURP189.PROD.OUTLOOK.COM>
References: <20250410123250.64993-1-kevinpaul468@gmail.com>
In-Reply-To: <20250410123250.64993-1-kevinpaul468@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAP189MB1897:EE_|PA4P189MB1183:EE_
x-ms-office365-filtering-correlation-id: 189811ad-f2ef-469d-03ee-08dd7895a339
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?M7SctMumL0M/FUujTyDNAHf4p9RrQfwF3TH93aUdSYM6WGfaXbzt09jQliuP?=
 =?us-ascii?Q?i2hUwuiGKzkUrvLzo4IPehm59wdF4nFnfGtmi8nSTpFfUTW67B8hstpzOFZ5?=
 =?us-ascii?Q?WkYeATOUV8X+tY/dlk/EYvZyjLI93ZzAvcER17mDgJnQYRqgrjIR/j6jDq84?=
 =?us-ascii?Q?6Q+z7ErnZ7ud5eqCZB6+NFIJ4tLwJSgagl2sYgmDnXaB0B7KEnFMzg2dYvEI?=
 =?us-ascii?Q?083258oqlVOQOvoSXN0Y/8mTlhm493tXsqVs5FP3yL9w4QnZ3/+yjdG2rv18?=
 =?us-ascii?Q?XVd9of7IPWqWuifs5fgaUdMgNwSWTB2uk/mqH0EaFwy1GYuydODnFk6yDj89?=
 =?us-ascii?Q?6pRp9qt31Ha/j5i14FW60g/ThWziTs0Hq5SL0lpGCqbimotiVRRlAb7C574T?=
 =?us-ascii?Q?wSh4dGEo2WrVA1oZAkOk3yENi2XeJJzF++C6+qSK9obKrNIinUixkCKd1Ri7?=
 =?us-ascii?Q?rA6H/zgAGfhuOd6bBHFdW/tY97Vhztf0cK3hK63+0EelCkjKgV7gL7ivDoCC?=
 =?us-ascii?Q?zGx6pWM+LS55gXPd6rUa+4rUreWAIWvYj/LEpeAmsR8VfdOZdt/fNJ4TqYYE?=
 =?us-ascii?Q?HQmXy26ylswZ0T7kJu8W4eMJnSJEGLqCgOb5s/nfhAlQz1e/wJHgyLShh6hO?=
 =?us-ascii?Q?TdTGVYOWlH1Oqsh+1el9cYCCgoSqsKx5jUlOPCYsYoHLLiVdLxzMcYfyUt7Q?=
 =?us-ascii?Q?Sarg0rqFU/6/P9bznFRdTuv3gbbT7bY62qauuU+Ak4dZyU3o/WXX5fRr06FN?=
 =?us-ascii?Q?qPnUg24x29LJttSfq/MCXVhnYcccuVLZ5j48lLBYfG1+KjKOpg6OMurLz7Il?=
 =?us-ascii?Q?Qxo3d9uAgJUEGcJM7zWkEzJ4uM8HPfvJu8Ds3RRyNw5GXBlG024gmRqYqQKO?=
 =?us-ascii?Q?7B36s2xjnzAcMAPG18ZnxpJGh6n5FyhUXIUxEOupUKL1Fk1czlEIYi9MirQi?=
 =?us-ascii?Q?kcVTBLvSmOt/Judlf6s5ckVmRSTSyg9x5SoXsNLd2xi2tfsfvpMOwwQPeu+i?=
 =?us-ascii?Q?tapCeCppqz6dktueFWozIK80SFSmbLjkXpQWT0pYaLho5cJTQ8QYjpzXWvp2?=
 =?us-ascii?Q?KkUsQySQBQxy5qnQyXSLZntJth8zNyn8GCGCM/hxsNEnDSE+kU/ofmIolMyD?=
 =?us-ascii?Q?wQgVoKe7vlM0Gf7pso8gNfn29XGxiAHaxKb1ovmEEhTMuL23MqUHtLSHJxSr?=
 =?us-ascii?Q?daaY+W/gIGgQm2rZnQPywvjC9qDcoQpiu4HklEY7xw7tN7NXIKgUbRroBi+X?=
 =?us-ascii?Q?+RH9TiW6G9tX4zcVxaNu7oSKGnsaRrClO87ujxFa1QYNaUPgg4C2h8vlH8nu?=
 =?us-ascii?Q?6PCq62Ub4cb9lxj9R1lttVn2KJrKhPqY5u+LOmYAfaZG0tQmvt0K768dhob2?=
 =?us-ascii?Q?ug8mgVbLXYKIRv/Sdvcd6zE7JmM2Pj8gmEXWckWJLjdLJbCM5LXzjOC6FyW3?=
 =?us-ascii?Q?BsyybEF0n/PyWvWEXk5VIg2E55BsPXx7mUG3YTA5WSxGJdq/IlTuig=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAP189MB1897.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sO1YBJ5ZlfucVQAeXWq1oPC0T5Fge6TEv+oKsBZCuuL/3qqBAExL28o1180r?=
 =?us-ascii?Q?Xv6TE4nRDpbMu2aqx86yFGbLzM0Xr+2C+EA1f+qf3XBesUo/rGgv2+io08ob?=
 =?us-ascii?Q?9+EUelzxAUIGKZcTNT86a6IdGJRrsZxCioYylnztG6mZ8JbyRcRhN8PW0I8O?=
 =?us-ascii?Q?5j4vvlz/gGW987M/cqBp8hYDFT81Ab9jDFNepKgdzw+NHaj5Y+nnKHjkeXi4?=
 =?us-ascii?Q?iA8Yro+kwLushX+wuMFd0jHivPjRCj+SoNuyzjdaPw3S4gtxfBTaseJBPtMS?=
 =?us-ascii?Q?c/JZA7TybxpiLisqLuKjq1MGJWYgXs+KNTmBKhQPKZ5my2b5lc/vVAWy0UY6?=
 =?us-ascii?Q?NfcpHkoZ1ETEU2grvW6MUfT9jqSmSINIiMb+1vHt/e+iwztFhce6ROry0zbN?=
 =?us-ascii?Q?orVe1t+tdrn9rhVMjzw5tpFfvGqFtZQQRZrCCpl3QDhU+eYZnOaAmB/baLNI?=
 =?us-ascii?Q?8V1AEsm/IfLj0A8aK+lgei45WgYNwAoSjl65owT2ItuH5vcvKUS27HNgBRiT?=
 =?us-ascii?Q?QG+oLL2pZX1lNNH4I8L2dhEYe1MuBnc6EHLvvEq6DuOQilLY0cK0K0aMhZxt?=
 =?us-ascii?Q?brpWl72xdUlBgR54C+Y9+xWtmxjsDp0TmZRdcwQsSpMOqBtOYDcVwSkwPz/v?=
 =?us-ascii?Q?Z4tVqgizRbM0TnMFasrPJ/GQZPYTPTgr75hCSG+ggsDEULtn4C1svudECuoD?=
 =?us-ascii?Q?MRheklFBdEPEP+jXcbQApG39d2YlFIh0KF+XpftHHlBONJy0hTf7tz8lFrGU?=
 =?us-ascii?Q?7h91G0Lt296NI7puSm7mBjzVAlTliQwps/pohDVvKsxx7T4v70Los5LPzW9a?=
 =?us-ascii?Q?dXtZ451+JeF8QGAsfY1cKi+i446xiiKjMryExa9lknOAxoDA5SUfJ19953yG?=
 =?us-ascii?Q?Ok6PnHZlCxKmN18I7bI6QDMl43VQjjYOrRk2kDoeaTvPSNl2icsqJlbX4zZE?=
 =?us-ascii?Q?cYfM7W3dfLNtPgkYJeQIVGwM+qcyjSH8KFjhHoC+GDsdGktNOgLpsdE2s5bq?=
 =?us-ascii?Q?R8QX/bjLRH3Kygy0DQ7KzChhMvRmRqTX7aBcCoz5RGszxOnWJiiOo3CFN8dh?=
 =?us-ascii?Q?+5klbtpv19JTRPlCC3NGEDD08Hfdgh1VLGmedqsIwMqcPop7VpxqPHqVAkia?=
 =?us-ascii?Q?1a6zozYHbfpevDsm0cAd+fi6+01fpTMzZXBMRCOHe3bmkT6tC+312xsp6Hzv?=
 =?us-ascii?Q?2IrAwKdUIa+Bmg5bxrHo0xHnzoXtUkA3i4WfyB79uElVXBumgFqCOrjJdS5V?=
 =?us-ascii?Q?x1Tfen1HI7Vfptu60UmcShgD+oD2OIAtFiPniSaseu2AIthxEoriN6kzFaA0?=
 =?us-ascii?Q?IAHDKjVOlwGzVX9qIRdDet5/a7RwJ+uASTOGqzusnUuQl2kdFSQEhqA+ySJy?=
 =?us-ascii?Q?oDLfq04trOqIb0E3WteSJeo1IUYJuloxcErlkA0BHTV96N+RTLXLGPGqm5Un?=
 =?us-ascii?Q?enpPwVZoxVrzHK9LRPM5mwzQJqRmUGKKyb8Fqqe7d7JYHVMEXjSeW7iQ9rpg?=
 =?us-ascii?Q?CW/XICg7WcT8AxFDShOagj4TYCKnsWqye6ot33Nae0S0OTRv3BpqLuAUwZYU?=
 =?us-ascii?Q?pDOnLylDPq3eQEWdsb3Zakcym2j2lOq9yE/qE0fe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAP189MB1897.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 189811ad-f2ef-469d-03ee-08dd7895a339
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 01:10:24.0330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NSfKxs9AjiNWee26MUQc1y+C0Petzl9tFs8NP/SFHpa4Dp3LLpNHaJeyWbbn/tDbXxSYtnROAfN2xBFvyo1O+CP5NoKNZalqCAlOJ6Xe8+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P189MB1183

>which isn't really convenient for short strings as it may cause performce =
issues
Typo: /performce/performance
Also please append net-next to [PATCH] in your email subject.
>
>strscpy() is a preffered replacement because it overcomes the limitations =
of
>strncpy mentioned above
>
>Compile Tested
>Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
>---
> net/tipc/link.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/tipc/link.c b/net/tipc/link.c index 50c2e0846ea4..4859b3c=
cc094
>100644
>--- a/net/tipc/link.c
>+++ b/net/tipc/link.c
>@@ -2227,7 +2227,7 @@ static int tipc_link_proto_rcv(struct tipc_link *l, =
struct
>sk_buff *skb,
> 			break;
> 		if (msg_data_sz(hdr) < TIPC_MAX_IF_NAME)
> 			break;
>-		strncpy(if_name, data, TIPC_MAX_IF_NAME);
>+		strscpy(if_name, data, TIPC_MAX_IF_NAME);
Could you please do the same replacement in function tipc_node_get_linkname=
() (node.c) ?

>
> 		/* Update own tolerance if peer indicates a non-zero value */
> 		if (tipc_in_range(peers_tol, TIPC_MIN_LINK_TOL,
>TIPC_MAX_LINK_TOL)) {
>--
>2.39.5
>


