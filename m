Return-Path: <netdev+bounces-278305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJqCLezn3WmulAkAu9opvQ
	(envelope-from <netdev+bounces-278305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:08:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CF73F668B
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C94E93083D97
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E55235A3B2;
	Tue, 14 Apr 2026 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="sWTMO/7U"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010057.outbound.protection.outlook.com [52.101.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B3C2D8364
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150330; cv=fail; b=CsPp/syGvluunRejPKenJioSqGFF3zaMap1Rri0jMW1jwx44fceBd6mOq+8D/EUfETWFqJCIeOoy/lxvH8zNpZDuWbSdwqHM1tRv40xsEC2PFllFZ4mkUJhWqRHDECIOx3ukAhQxwWOFDEFaFVyUbdwSCXRteaVx7tlDp9w1r60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150330; c=relaxed/simple;
	bh=dnN8wlNLcKJacfQEUcV6/8M2Bj0KAvdgIJxS1sjQ5Z8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d7MBc5+cppb/ld9Jr7XJXpH8vxxLizTRxIUs8v1ZVJSBgTD3F7VwcKB1+1Ff1D3c64Gf2nwHRtIT6UwmeSn9itCNCnocyHnKS9FqXn05pGsJTBden+HX0d5jDv7GaYPPw9Eh9mQs/KGAo4uS8Kh9bejzhTVaUwV958DHjRmvFNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=sWTMO/7U; arc=fail smtp.client-ip=52.101.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pr3vB8n0GqfEk2iUMTcDvC6j75PDEc6bORXYU0U9vX4le5/vK7jUuQ+6jiIFftxP0svIzS54z1gRf7DqkmTnrRDrWgU/N4xx1VeaBj/ItDzehFSIH9wVOp020Ocg3wIfPNnIWnR7PF2jRKQJ8JW3IEc2bhwQOs9JMJvDqiPb8lhhb0qrgx6HUkh58qFSFmCUUaYd1UDwhNDGghcWat/lndgXNLKkTVkeV6KTMnC1ddWOVARgeGZH3xOQKaFNT42yvY6dCP/gUe6FuvloRsmXjZn1jUKSlXFa4mCUntM4kkWyd416uEplQNRuBykNMwk3nHIekGBinjib9BeQhj8hWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+27zcSzr7ZfNBGvtVORKiMYrUb2KsAz8H4zJBfQJDzA=;
 b=WjVxl6vySXRpF89YvIEEpD11nAy5di5OJMywtLq52iZU9pgOGpdEDnOKqyzu3xKTqF+cOKV0TcQuCdxxa7dzhbSmn8TrizRcGhCQN3ruUCevq+vQBuGBcBJaMZHwamSiXT7j5vk6elBGYaTNJOQgCMFWP13ujECDZzgnFm4t1b82rpLw3C6MrfIHrSBXk7qFdvFqi2a5A3hFjmsA0jMQQ6efTOdZBH9inw49QBqaqVJZ9Wzw35nBMwy3OBNFYExRQv3O875syJXJq9yWTZbWk2h3sYaEfJGj/f9zkBr+83ymJLv+HslgKWhWRxAdz0vN4vGEanoqF+aqUYn0GOBaDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+27zcSzr7ZfNBGvtVORKiMYrUb2KsAz8H4zJBfQJDzA=;
 b=sWTMO/7U36z9SXWpELn1VaVrANd6cOTMm1/ZrfExYcl5YF0IGclWpN+2tS7gbm0+pIxKX3Q31Kn2ICaZWGaOCVttD/L0Ei4wsOXSgaoA1rw5DwWZAhTzjG3LHEaNu36t6e0yMgH7iXDfkn2w4u6VI3/6pjFo1YHWIFMlkgTErnQyu/xVXT/xdQHP+OOTIWAQplznGWARnX0yZd3/layoVisbUqEAL0t+rV4iF0xt1lkI93Jwhdr4Uw24WqhonA4haY9CV1l9V6BdlfjA95xwROrcPja8o0JoECDZl4dWaBIc/N3FYoQVZwYXr2L+e0KZjou5Wb8kvXZNI8j/IQUTaQ==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 VI1P18901MB0815.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 07:05:24 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 07:05:24 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Dudu Lu <phx0fer@gmail.com>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH] tipc: Ensure NUL-termination of remote algorithm name
Thread-Topic: [PATCH] tipc: Ensure NUL-termination of remote algorithm name
Thread-Index: AQHcyyS0OQwVS2jRCUi+I63KaTpGq7XeIeYg
Date: Tue, 14 Apr 2026 07:05:24 +0000
Message-ID:
 <GV1P189MB19889E0B65316560D9108AEBC6252@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260413085852.76786-1-phx0fer@gmail.com>
In-Reply-To: <20260413085852.76786-1-phx0fer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|VI1P18901MB0815:EE_
x-ms-office365-filtering-correlation-id: 62005320-7daf-4456-fecb-08de99f4333e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 6bTuGfqwqsnEf9sBJys/w6tsTpYoHzeqvqdY9JM1LPfHnSKKefv6hwJk0IVL0Yjt/bCqp9SUrboSpblFQh5lVfj9ke8Yc8mufrgdERvZvcwg3YnHQuVd/+DrcsorX5lNZ9RNAWxotPv/DpJcgOPmNlnNmNKdT2rbc39LZAVrcTfYnt2b8/PU8w7zP2rADe6IusXgrjV9SieUQCcaQdsEqAFpmsdaLKsdUHU2OYo9aiJbRbqIccqkcphOH0hZLbNZpFdvlhXT5G56E2wR2V38MMZHYd1jcW5/tPx7yZqpWpC7O6GB2Vgl7Z/74sc8t+rrVSFI0bTF+QNo8w4pwf6uy2qRn4xMv45Jv9M38uHdSY5n4qvGbgdJuhmj4cSN3+gzNAq7Qm9kxNybrEn1FfSAUoRZjXIaTFkxKoLC3+5y683n0QQXJwGCGlTCRTmFuRuQqUnRKDw+KPiBZ8BlNZijSiJRjRlDYaLuXIDBHTv4lNQ2YFnclhQt6b9QRgZAVvUOVKimJsDFwSrB6cMb4h11Umy/31m6t4p+a+3nChpYXJip2cd3+QRwBO4NnAMxoVDZ2xeZ/N4oqHYiUPnRN7+q7oOJYX4zBlrFJHcCi0VWiDBOjVBPiEaIvY1cvHQP6HGNS0SOMKAlDooXGHCRSV4vQWuLX/x6N7qyR5posssJSwVNQ5z4bA9faeOZHiZTBylUrIe1TFPfDhE5MAik0tMLcpBpUTpl86e/eZRuW2q9g4vJH/sfJyK/7Q2UnrzA8TsdWat9N76oufK/tH8BZZxBtZ1v1RIh/r/xlX3/6nrNQKM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pfRe3VRcibM+qdKcmpcaZpxsO4iF7GQw5eqnwL1dX4g2Ir3c5Y9yZpLEhpII?=
 =?us-ascii?Q?vC2Pn/+PEEhEYHCqWCErx2Fw6nkG33aj2Jcf7ifUlXwYlGCHUDyZd3P3tPJm?=
 =?us-ascii?Q?G1a36OOInv8L9LMYVrhC93HggCrOJFn8scWDEhVhuHcX2Ilhng16j/z6bE6l?=
 =?us-ascii?Q?+DSzMMjYIjSQWytohJh07whcJLeyQuII1N9B8zhqCp5hUaQof07+juowu8Mf?=
 =?us-ascii?Q?kRkRnF29/dOwiSJs3q0vzxYADiT57zbG8K7gabaJ0FZQ/kk6z4PtUVCZvKRu?=
 =?us-ascii?Q?u86+Uhnp9CCEaOfi9gsf+7gCnbpco3rhsRQIeVv2G9NRTFPZi00hIOjkxopL?=
 =?us-ascii?Q?XyxsZ7kmnupwmO54IU/hi8LyzeMerMgujbUe9x56Oze6N4RIpi27Ik10YELb?=
 =?us-ascii?Q?nkVqvoFimvzEc+ZynMDw+7r5chlrp0X0+hzV667nOj5D5tf2T7BE4aXxaBnP?=
 =?us-ascii?Q?hZx7B8Z3+3yCubtwgrQaEKvzoEk8rLG9isGh6uBWrSukthYr7G4iWWR3jt6Y?=
 =?us-ascii?Q?V3hd0KAVZefHEcvAbygF6eXkWU68wlpnQKd9ZKZoqen8SksnFNvO9rOwieWr?=
 =?us-ascii?Q?Ma4gReE5cabJ/zggFQpq/qFumu/rXLLv2i/dTMUfcsuMRaueWH2cVtbJ6inj?=
 =?us-ascii?Q?EsW6sSFXMCm2T+6zuS4TB/W356rJHvOg7vnDFAAD/omwzeVUu1Nel2mY15St?=
 =?us-ascii?Q?tYCnbmrkBbj0+gnyVMI7OQwQ0AMKVt3PRMpV86WLgkAwD5YogfRGTS+hGqgE?=
 =?us-ascii?Q?ATaqZFxqyyl3sR/lCFwAszTGsPK0RIGZI6vYFQBd1aQPSRA9t7t0UsZ4hIwC?=
 =?us-ascii?Q?ENe1P1kK8QHlOzh46cmRqMJsEJ33J/DjI+6N/6qcccOHzdhXjQyQkirUYjA6?=
 =?us-ascii?Q?41FcDbm4J6/KocL+QENerP7ma4vmmLU/jdFunCDBZyUgrHVrWwPJBhoFDi+I?=
 =?us-ascii?Q?CnX636KeQ0ePqOSDuoxe6eFJpuV559yeEUwj4ge7RDqzN0dqrkx7mnjlOtT/?=
 =?us-ascii?Q?lGmeQwtirFjzaOKgFVPOZCEpC4DjH1QP+Hjwqjhda2jl5QrJSvmK+CfPmt9L?=
 =?us-ascii?Q?8M8xKVQVvwlrmZ8ahjPUrqJ6B0Su1a0sv2BSLN9xDMbz+tFFs2EsWxVbpBxY?=
 =?us-ascii?Q?El0HOdVsFGxJAjzIi1T6ycaLNiXYpYU+Pk2qwJhNtrG9bKvkRUBjJH2AZKpg?=
 =?us-ascii?Q?cg3K+y7KlLI1I/NJixptYO9x2Ps490J4wj1Cg1g9KKsEohs4PySKt6Dp0Kla?=
 =?us-ascii?Q?mscddx8yxsyZkKJis6WSISR6M22v0neUC7FJCE0+7KZaag94Jzg3ifbxVpLB?=
 =?us-ascii?Q?tnIUbBOJyF9uBHFkOhc3yjXHfhbYmE9wx5peli+U0tb5Kbdgwz9lDtQeGp+F?=
 =?us-ascii?Q?UoNSb6mnIs91Adrw5zMEU5Y0JL4fPcYbqpjBYw1sIyVjgw+B/jYZmxWrpVbR?=
 =?us-ascii?Q?ydCdKQUYHKONfMdC2DJRl/L90aQbiRcfOpCQipPNvGG7XWSFyxfKVYjgHzth?=
 =?us-ascii?Q?9O76W+TcatzGizXSGhFBBBT9AW4fSHzd66aLuNYDx96dDf5K0tfZOI6tM1jw?=
 =?us-ascii?Q?oCO0cD9eGSAPsWjLVlYN5hGH9WrdgYlkZK7cpf9FBrr8o/+xb/YIZrUwUCOk?=
 =?us-ascii?Q?+CoKqjz5/N4Y4t35Kc1+y5qxUZp39LmpggO/ybCZLhUGEdDzm69aHfXMRw5W?=
 =?us-ascii?Q?a70DI/T0DIMmspn/XvAnaBEI054kWH7B3hLj4vRW5Scu8bk7uKmBzh/hmrTb?=
 =?us-ascii?Q?qIDYHsAfsg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 62005320-7daf-4456-fecb-08de99f4333e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 07:05:24.3916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X96m0wVR1/TriZCl/YSI9IMuSccxLcRY0by1DdYtJL4CHLVfu37753IXj855kzlxEO6EALLVdaL4hf0deEQ5Mnfv+V3WEze667CulfMqhH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P18901MB0815
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278305-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[est.tech];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[est.tech:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,est.tech:dkim,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: 22CF73F668B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>Subject: [PATCH] tipc: Ensure NUL-termination of remote algorithm name
>
>In tipc_crypto_key_rcv(), the algorithm name is copied from the incoming
>message using memcpy with a fixed size of TIPC_AEAD_ALG_NAME (32 bytes).
>If the remote peer sends a name that fills all 32 bytes without a NUL
>terminator, the alg_name field will not be NUL-terminated. This string is =
later
>passed to crypto_alloc_aead() which expects a NUL-terminated string,
>potentially causing an out-of-bounds read when the crypto subsystem
>searches for the algorithm by name.
TIPC only supports one algorithm name "gcm(aes)" which is 8-byte length.
So, there is no " name that fills all 32 bytes" as you mentioned.
>
>Fix by explicitly NUL-terminating the last byte of alg_name after the memc=
py.
>
>Fixes: 1ef6f7c9390f ("tipc: add automatic session key exchange")
>Signed-off-by: Dudu Lu <phx0fer@gmail.com>
>---
> net/tipc/crypto.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c index
>d3046a39ff72..ac072356bf0c 100644
>--- a/net/tipc/crypto.c
>+++ b/net/tipc/crypto.c
>@@ -2325,6 +2325,7 @@ static bool tipc_crypto_key_rcv(struct tipc_crypto
>*rx, struct tipc_msg *hdr)
> 	/* Copy key from msg data */
> 	skey->keylen =3D keylen;
> 	memcpy(skey->alg_name, data, TIPC_AEAD_ALG_NAME);
>+	skey->alg_name[TIPC_AEAD_ALG_NAME - 1] =3D '\0';
This is not needed as explained above.
> 	memcpy(skey->key, data + TIPC_AEAD_ALG_NAME + sizeof(__be32),
> 	       skey->keylen);
>
>--
>2.39.3 (Apple Git-145)
>


