Return-Path: <netdev+bounces-119858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E824E957412
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 21:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1802282A2E
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 19:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981461D54E6;
	Mon, 19 Aug 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b="TO8pYvmx"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2089.outbound.protection.outlook.com [40.107.241.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002C01D54D4;
	Mon, 19 Aug 2024 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094139; cv=fail; b=aAfYDi5WUGioqjjvSlWBi/KIm6XfTl9lEA06ZSFYHnqzkqu9EZPadblMOgovkwHuti+BIvDSJNq1etcVR4xNzZ8UCzh8RsAxJ5zUwMcLtxVYcpjaXoyjIy9uAocZghbkWubsKzpnMDLhEgVBZoWsRkCnRHvqVIdGuQ0JS6gccU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094139; c=relaxed/simple;
	bh=WwXsIjF3q0d5Zl1JBFHmQ2AM7DY5WVioix+ALE/iznk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TLp/CaTypVJpWy1Hd0W7598hZpMtCvEqupcRv4czuHer6u/eofvsJwIAsy4lDe7cCMAimSNq+9lHmk3zTMogvbyUkcwRd3hvYJqKx9DZrQyVGHzqm19NOXzBmzFmgWJ/zlPHcpoGOa2hPCt5qbw0nVbufDU+XtplsJy3KKp2jMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b=TO8pYvmx; arc=fail smtp.client-ip=40.107.241.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYaf0mjaBny+n1nmVPTcg90Nt61j+MnMWtMBrmdizE41ZjlOU9cieX41KVFtN01uMYZccefe7p8Ie6KKTrC8uWFR5iMDS0JdR3P53YwO6ec1yIxlaJnFYShHLeTFxPInhiHG8ULzNIZcBhfoL1AAP410dQKfub4KBuw5nHfSDTMAuY0JXedWP/Df1ynKlIHI7Nd2iNjVL5F50tZrvIKw+JrQMAbYDU99Ks5eGYw1CkjC4dGfV8OfiYU6F3tRiiS3uZN18qGvDMYgXjx4DqLxAykmwboWKT175wyYw3E7f+vBk2pe55PThBb9eTu2fMsDEaLbP4nBXAX30SymPQ0tmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmycmqGR/WgZMgWF1BDbq/1m8ggYkroPndvnYwNpYBg=;
 b=IiMkrOOo402St55A2Evjvhq9wz2DQ82Oqyx7kROWa0KJyqqgj5wndgqnG1bsvGl75km4M34iQ1MuRWc2GlvUm1tGZ4+refot0tYccJUqpiKYW9Ki5/cUQLJOgyRBsVd90YddFdUdN/rI2Gs90fDAzUo0LbcB2FkaS7ex+8QNUEIfa8TyaMPFYvsSxFzajtOrUmNe8FyZ8y4mSJVqLB57OSyoMyYrA0Qs8KMAFd8NBQImAXdeBKYRl9cR/ib97/+FK5HQkurO+xBO/8tJDsHXUUDhdywW6/a622SgiR/QkfqNIL90hjfkS02J2SW6xGhIG2sjMMrMgWjdBjvpsT5/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmycmqGR/WgZMgWF1BDbq/1m8ggYkroPndvnYwNpYBg=;
 b=TO8pYvmxhCQkCvFxsqFfRAdOpMpm9W4ZT6XESSA48s6WQXvTQ0ciUP6Cu6/PgljD8alEYCxUqG4Lzq0C9XY+i1NFiqg2KEKItjRZfw6wvHuKCZuksSQqJNnf0K9YvY1utzuQx1OulfrpOmbH6eEwLpe7yFVjLmmrAMC+VOHqEww=
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by DB8P189MB1109.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 19:02:13 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 19:02:13 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>, Kyle
 Swenson <kyle.swenson@est.tech>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: [PATCH net-next 1/2] dt-bindings: net: pse-pd: tps23881: add
 reset-gpios
Thread-Topic: [PATCH net-next 1/2] dt-bindings: net: pse-pd: tps23881: add
 reset-gpios
Thread-Index: AQHa8mpN0YpdDvrWdUeonjfwn/G2Sg==
Date: Mon, 19 Aug 2024 19:02:13 +0000
Message-ID: <20240819190151.93253-2-kyle.swenson@est.tech>
References: <20240819190151.93253-1-kyle.swenson@est.tech>
In-Reply-To: <20240819190151.93253-1-kyle.swenson@est.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|DB8P189MB1109:EE_
x-ms-office365-filtering-correlation-id: 30938793-857e-4768-6336-08dcc0816f94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?kYSfyPUKyYaGti50I1XoduYZCsGcGOQjSjC/Wlq2PTICdjLA6WIF5qG2Cx?=
 =?iso-8859-1?Q?oEL4TiFSTgg0Mi7+L85ORqjuI1cjfhNfknHdGgnMqRu/4faU0w7w3opxKf?=
 =?iso-8859-1?Q?RZAShsRaxEgGdkg9ujHTicDDgMHXKTqg/IC0Fumm9jjrCUZGvj5tqqqyEw?=
 =?iso-8859-1?Q?EGheNGdU5quvE0R6KS/z5sY/y9H0SN0NLj9ozSSvK6H6jN2+R6CA0aqx7f?=
 =?iso-8859-1?Q?aG+oW0dSGoDSPNqNkkHOL2QPShE7qCyAbGqrVhFhtqG4Ig947RS1z9OgN9?=
 =?iso-8859-1?Q?7hx2q6kulTTnNm1LeHV/SjMpLE0MtGg23aYN4HcbdjspiM1fpdN0Gzbcfv?=
 =?iso-8859-1?Q?G/OexX/PaX1GfoNn8mkqsVJ/qUy0HKV6U/r4/pCh9XkTizHmnX7lVpjbWL?=
 =?iso-8859-1?Q?nHn3s7khL5QZvQfBka1kW+v3AcDY+HlSU0M96osT4ZJ9jA3+8s8N8nXklG?=
 =?iso-8859-1?Q?XOoY4vLBP/vLWFwIWCDOq5tMZ+6d+/oMHcma0t41xDty/TXyvYhMTq6kN6?=
 =?iso-8859-1?Q?mSD6/MZhKFqal/EXFBXT2vj+bx1xC+Slkul/OSc5Bex6BsvXKGRYzwZB64?=
 =?iso-8859-1?Q?2/5lBqTRl2DYIPKPAv3c+/RxFxBZQtlyyFNGbe/VY7kfUqEsH8vqANsv8T?=
 =?iso-8859-1?Q?3OeHPxtP41LZGdjeSJJY8NhWXxUG+tZzYGD2+I0Zo3NFud3SPx2pXlr0Vk?=
 =?iso-8859-1?Q?W3vDSyI1a2UkZaKWzALTyX/pLLGM3PEGrMeZf5kUzuSE6HpAJ4w/SoHeFU?=
 =?iso-8859-1?Q?vBYIJq0FhSfKKV/Ky/K66Q+C5BtlnbjEZEfOnIfpZGp3GqUNLEOMCE5Hit?=
 =?iso-8859-1?Q?ZyG777maiaqJwNoNXr3YpOPVPrWv0A6TaLLc+saorukDyn7DZ/9R9EeXCl?=
 =?iso-8859-1?Q?9ND02PQRK23CE+m7zdcBBcOk+mHPt6U7mOo55M65LmbqWBUDdFqsKGQWMA?=
 =?iso-8859-1?Q?dhGw6IaIXTRTyhoOtMt+7/MUTfI/3EKxzRlZ3Zw+nC2OJpQ1x4R57PC7Tf?=
 =?iso-8859-1?Q?79QavkcQmo8FyMgl/v0HXYZJNLFcNpjnyAYXaR22CEsyuvd73H364E9IJh?=
 =?iso-8859-1?Q?hpc+AM1Z0urPh6iKo7HELWHaXcEyx5dbf3PumuHiohvb8ZuRQIuVOGpB/X?=
 =?iso-8859-1?Q?Q/rvc/foqYQTZcKMmgVnGrzO0T7hbMBv3P3ys6IpWUbzqKFQU7DkCOt7Ln?=
 =?iso-8859-1?Q?iGJ7pztaeFlMHcSeT3vxam0JID7tjsyZmtdUgYvuG3iuG0dg3Dswt8REod?=
 =?iso-8859-1?Q?26b/w8f5LI9KcVqyU1mxAmp4guNNuCLaAo/HdvWcVq7pQfHUJx5HA1tU64?=
 =?iso-8859-1?Q?StKBv9BaNVbcfgFJXRlqKZQ7iF7GlgpiENK+LDwdBvr6p1S7FaJ5N1XXsV?=
 =?iso-8859-1?Q?CHDRt8Kk3B1OjJzSEnosJ6X5mz+IM9PnYXEt178V5fSv4sBt3uiDTf5eHe?=
 =?iso-8859-1?Q?SaigOaO2n2EfcxQhqVkXosw/Z3ANiEBqrmBUmw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?33c8wOFn3UqZHlZzp2dXxcMsOsJ4boRkTN5e+u/SrGM8YLC8IpRnDh7tuZ?=
 =?iso-8859-1?Q?U+NDoyqQcPjURuSjsq3Bn8uE0wtx44wGqaq/LcdftifbT7hSN1mM6ZUV+k?=
 =?iso-8859-1?Q?3QS0Ee/akmO+h2YmgerrfBngjO7fX5y91TEn/7r9sqge+krnjVrEYx4NKh?=
 =?iso-8859-1?Q?BE55auYlOKJktT8Su0q11BLkMC7pblZMQt2LUUgdiKCYF+g86/ZgOIDpI1?=
 =?iso-8859-1?Q?Dla22NqE053HMXlTKceexgzDuTuRM6z3LlzAprHIlGckawuxf1YMP9jdnz?=
 =?iso-8859-1?Q?EVhXe1E3mabvp+hnJjGXNGjfsUfJlFMvUrbTcJ+OHpoU31ETEHlThxe+ls?=
 =?iso-8859-1?Q?ka7zp9pMDxrLqugtYzuaj3yHXOI7FzcKZi3UxjJ9R2WtBJ+ZVG6RJauAOq?=
 =?iso-8859-1?Q?2ciYz9e58PQxMLNKe8Bpg7Td7UVs6/bniXMalrCQmF0vkZnXOmLOWsKj1K?=
 =?iso-8859-1?Q?xnWng9LAquZjUfxEI8qWS6ok8rlu163rlH3Si3q+q3ishfRizkGJXZrKZX?=
 =?iso-8859-1?Q?CTpXKMgiOE+dYUbEOfMnkkzoYjIvwpFBn24Kxz6KbOiKu+VMrw7WjSmyhl?=
 =?iso-8859-1?Q?G052e87CjGqnwz6o2bbOpGL4iaGVrZCO+CBCBBEnugJxhtquM8nD82Mp3S?=
 =?iso-8859-1?Q?rJ5majVDi9W4D+pRn5fXg7UpkNcF9GYgab0T9FY+c+LaeK2tmg/g41Ljj6?=
 =?iso-8859-1?Q?T3Lpwx+MGCqkVedglQ+jFCOf7KsE4WjFlrCuPihwf4beg3auPhSPjif8fS?=
 =?iso-8859-1?Q?blaFF3Lly40P3U6UX2S3ixMFPSIA6ek2rF27Jcg+3IWRqzJjhmPO92T4+T?=
 =?iso-8859-1?Q?q65fy4Sv895nPRdsC3VMNVJGDwFz3G0G+/SbDjZzLbBLV4JnChMRgAnq6Q?=
 =?iso-8859-1?Q?aeHOaSDun4+ucfY3H1fpfkjSiiOgunKm46MWCVLMqpW0wEFNi3i8+ne1hI?=
 =?iso-8859-1?Q?rd0JL4IflfpCVhrlv7vgTBiuW6LfqInjFNqIsISof4ac8cHqk7/hZAL/po?=
 =?iso-8859-1?Q?W4uyhfT/acoj594tBvXbrmJqNEPKWEXA4SmTlxtUDXaKYmaLULsjm4YgDJ?=
 =?iso-8859-1?Q?BNMVYPHnKHilpbtNE1QktT/THP6awiA86KmqOTSBkMD/vJigT6HoiYjYhU?=
 =?iso-8859-1?Q?2zR0a9NkTj6ffk3f+NV07wFU6sDtindcNiFu+wsXnjZZcTzKxiI8l3oaUP?=
 =?iso-8859-1?Q?AW1/z2+rO0jsURs2WmU8ZGQGRuYMeV1iXP+lKExv3V3jPCjw0AyHQvbllY?=
 =?iso-8859-1?Q?BPhoGNVWGrFNTT5a7wry57LTPTF+8kZBSxwW7kDYbWPcxAkK+0A0tcE0t4?=
 =?iso-8859-1?Q?RRtw7vHUuG9v7Ms+KW5pnmoQQcomHLggzhnkPSVcfdKzKm0EcZSxBkY6gX?=
 =?iso-8859-1?Q?u8qVufa2d9hA6f+amx4fASlNjJZCL5iZKSOAZj+9kRgT4fJXdPcmhuCfwd?=
 =?iso-8859-1?Q?ocz/mkWpzpqiuKa3Z6mY+JxzTKqOXrD3ZTYDA6/r0ASl1BFXSFbw0Eq6cH?=
 =?iso-8859-1?Q?9IhAvfSrLnkQnn+BE0hFlYsq5FRNyoOs//eW5R0rDE2xIc9W/LqYkzx0L5?=
 =?iso-8859-1?Q?pgRv5YqNcgrhWB3oOUWdiW6C9aioS/fElI8rEU8s0wKYl4QRqM97GbreRQ?=
 =?iso-8859-1?Q?hcVn3iwCZkCKObm7OAh8kIUXOX7lxv0KMSLQn1qQ7lCzPcxonrJDjP9g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 30938793-857e-4768-6336-08dcc0816f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 19:02:13.4888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hS8RIH3aF9iT26/UVNf7hkNzJl80TCZrZ/R0yj3RFq6clu7fZvr2ASeHLHn5Pj3eNauqaSOP/rGZLTBPKTo73A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB1109

The TPS23881 has an active-low reset pin that can be connected to an
SoC.  Document this with the device-tree binding.

Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
---
 Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml =
b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
index 6992d56832bf..d08abcb01211 100644
--- a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
@@ -21,10 +21,13 @@ properties:
     maxItems: 1
=20
   '#pse-cells':
     const: 1
=20
+  reset-gpios:
+    maxItems: 1
+
   channels:
     description: each set of 8 ports can be assigned to one physical
       channels or two for PoE4. This parameter describes the configuration
       of the ports conversion matrix that establishes relationship between
       the logical ports and the physical channels.
--=20
2.43.0

