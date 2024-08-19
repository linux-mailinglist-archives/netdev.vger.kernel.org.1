Return-Path: <netdev+bounces-119857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 501F5957410
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 21:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69911F224ED
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 19:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03781D54C9;
	Mon, 19 Aug 2024 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b="hyVhnDIy"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2089.outbound.protection.outlook.com [40.107.241.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F153E177991;
	Mon, 19 Aug 2024 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094137; cv=fail; b=pZ9fg9cFXrpmw6PA8wKNkTv1yT0RCNYi6EEQ975Xi6DfPEfC3LKcK42Ow+7LkBYidTmHOy5oqotl1T3KOhnMoCTwTOWpuDbmzJWHpoHaOrReveKEF0e7LXPb0czLVvvGT/r8fJcPkxzWuoCztWC1hyw9rpF8lCaSF1nuwF5FXRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094137; c=relaxed/simple;
	bh=e/yGQBkplcj+rGzl2WBB7dnfx34k5p7GZjPD0dfdy5M=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q7rB0eVfG+wd4fsX/UarDT6XKdCcoeaHQsySka/eor7p6q3q7OOPllKwQRHveZ3SQP81hhk/yOqjNiE4NAZU4eZtkw/ECX09MG+Z6u0TQBYnSc7XG4rQjqJSE0XYSe0aUJgzfTV6iE73vAQPkXM0afEUq+t5Lr0qtGUx8Qf/1ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b=hyVhnDIy; arc=fail smtp.client-ip=40.107.241.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAAT8unkL1b+V1FJKFvPy3VN8lHhu+RFNrDwVB4wvEv1+jAzXgvd9zKcdPpDGH4dqkKh0KK7gJxenxHDqmaYt96VUmDX5jC1qc9K5xVBtX7Fmp4VwStEG+T3ji3fneQzWIOyfIJH3+6DGhrkfOMw9HJKshFFatIuD+rjNeYNRBbT8SC6o8BvJlR6Y9S3WQWPhR/UMFY9CY/+b2eoLnZ5x/x8TD8gQ4+lguOwknHpS7eDSL1qviGlMS/iILQhgCuxpsAEuzX2E44OSUwRCqVuTxqD0wbsvnFcIeHtfNiBd84NAEiZ5+JqDoSPJeswqOOmF3Etg6BMHJIYETvlHtm+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2oL33fQ3c6B6o6U+E+RafnBILFbP4GxvcwRTFoHF/4=;
 b=sSgouKgv/+9/kyyBOD4h+jlZhMKp941AAQLJcRPlGWdgk+pugq8S57aK/RsAGKXv+OVUoLKkPDlBQVZVxKN7VZSXhHgkGKK6jLije8vSHEo6FnQdV5CcwzEadNo04/6l8VJNlNwX4oBLK2qob5zoT2GRHdM5Ts5mzjwGMjdDg4jsGNn5qfLnP71N5SlBcqyeEHInLDzRkQE05xM/uMQGLprR5/4UQdNn92Nrx9bihJIWpQFEYqXhDEXgYDvOx/qGb+gomAkJNIM42zPinf/1Wk/eXyYiib2B+2B/Ti2/qRA/i5Y/hPW1Xq4VaIkzN0WSYySWw3DF00x53c7tHi19Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2oL33fQ3c6B6o6U+E+RafnBILFbP4GxvcwRTFoHF/4=;
 b=hyVhnDIyVRyqyMvBDWIj9937iFVEZ9dc0MmTtP9CyhtXRNE6dGmdGB4lpCCwzBg9Hqr6IRDUUVM/NlB129H2n4IgsiqroC8ECuwEAuk2iezmtzUR2jxAXbllboqaFkYUGTD8Z6hVt+Vu9xKqWEXaCPqKFPW7fY60tlSaQHyIsNs=
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by DB8P189MB1109.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 19:02:12 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 19:02:11 +0000
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
Subject: [PATCH net-next 0/2] net: pse-pd: tps23881: Reset GPIO support
Thread-Topic: [PATCH net-next 0/2] net: pse-pd: tps23881: Reset GPIO support
Thread-Index: AQHa8mpMRJPrUGj8GEqiiVp55FPasw==
Date: Mon, 19 Aug 2024 19:02:11 +0000
Message-ID: <20240819190151.93253-1-kyle.swenson@est.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|DB8P189MB1109:EE_
x-ms-office365-filtering-correlation-id: fe3e0428-fa4b-42ab-e1a2-08dcc0816e92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?6oxHVbPrLXtgCzjjCnRNPnwgHLUX7FBtgJSryvUVjCCwQe4JfJIgADFiyc?=
 =?iso-8859-1?Q?dUVTP+ILxMEmcMHZfaPu5OpwbQ2Ep3U3jbd/+j8zHtaY+bawxgqC9As4ua?=
 =?iso-8859-1?Q?oFu4JVdNOgFozm6/l15T1cO3Y3E6BLra9csXrcIHeZgD2Ht43fYNV8LoaH?=
 =?iso-8859-1?Q?tIwpQbCkcfqFuNd8CiWH8jQIsMJewpMuY5/X7dXGIU5mlyhaCfIhRLtTU2?=
 =?iso-8859-1?Q?24MZfoJ+/UtzRXqWLuWYPadaW3J2/SgzFPT5KNyQ34viQ8579eCcvHurEq?=
 =?iso-8859-1?Q?QkhZNV51zulx6+A5ay+kt5+9CTAFvlHhzPVz/3kUaYIk+YEal07UfgCD0m?=
 =?iso-8859-1?Q?woQ3vUY1j/uWVFVd538ocgtEgpS64N8UfsKD4MXA/fr97fa8ri1jpBdlNQ?=
 =?iso-8859-1?Q?QTqz7LAsZP3pTx92mrZCNGbOuLjRkJcqTNJQv5V5lZqgz9ePg2hbmEcky6?=
 =?iso-8859-1?Q?rVemxRbfKUiKq5kxWdtQ7hiCGhzAcAbe+LS7utVBN8P42ZIBOIpSaATOvS?=
 =?iso-8859-1?Q?gFLWodJTACTXmQ/hWzq9alkQwzDMVzAg2bgrV1d0yH1aaz3Y9TTMv7gpnU?=
 =?iso-8859-1?Q?Eq2dNNV9gYOKKI24K/e1p+rTwnDTVITy1fcCbvjKbPoJotT4OaOiAl4sJy?=
 =?iso-8859-1?Q?JRoVT3WU6UYOypoGWS1XYwbhZC3hv69YuVEwR8pK3AfA2YhllX56tcnS9t?=
 =?iso-8859-1?Q?3AgO9TutbzpmfdXuJvEmLa2LWKcyKxMcGxN3In9XzhrY/bzq5xM3ljycIE?=
 =?iso-8859-1?Q?HUoT9q0Eq/pMj1ZCqdDL75ITEgKN8r6On+3mgB31kWgIcCsnUzP4XHmnLt?=
 =?iso-8859-1?Q?9jfyfZp1VGOr13Uo7kfFhPbXCIooZsBvKg1rdv3Q9cnWQtpl9Eh9Vgfzla?=
 =?iso-8859-1?Q?cTKm5nigsU1bXSsVKLGc79bB4pO6mSaNidUIPPVn21z90CD0Gz/cjcc0RA?=
 =?iso-8859-1?Q?yQ7DPfF4w57AgQWiIWNYBV9RWwgJ6zibc+uiHOJTwIb1IQDcbj8/1nZuUe?=
 =?iso-8859-1?Q?Ue+Gc71weJKhkfbKw9W+1CS85rwHehKO01GiEZ8DZIvL+bLKyWdZ0A+41m?=
 =?iso-8859-1?Q?3IgOrLpzWwdsgPG5z6li51r+phXGtjZzYYswycJIuTtguleYZjOi1rp7Xt?=
 =?iso-8859-1?Q?71Zf6lTiWs7kZlNNPmKhdfemgCo3aGNuAj7AeJ29tGbLRX4SnPDP+5Og2Z?=
 =?iso-8859-1?Q?rf0E6o1nbtvQuD8Oi1uC0VbUg/3hgYuUaqvIu4phtbTJHwE3Znh6jeFee9?=
 =?iso-8859-1?Q?Uamx+RP2r+dS8RD4TS70H/ZyWtMNFYbOKzyfLA5rnyZljYYs8wvF1TgpZJ?=
 =?iso-8859-1?Q?xMXiKwZBGJNQyNl0c5mO0YwoC71LMSgBCBUPgNpxZgYet1UxSCAmbeFYEL?=
 =?iso-8859-1?Q?2tJcINmm50MAQEKup71rARPE9LjpMR+UvReVcQnJXmaK5Rl0ZHXmaO7HlR?=
 =?iso-8859-1?Q?ityap6S8u2hj4/5uTB72BE58MFZPQ0jxn3T3mg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?AAxRGTX/gAAy0h1EKuzWCbRYWMl7bR8Ad5/OaTcRRY+uZ7CCxtKyRTASTH?=
 =?iso-8859-1?Q?Js7D7QKk/BDa5C5CiaBWvayym5+oKsA+0PaVke8yIic1cVy/bPR2TMkbG5?=
 =?iso-8859-1?Q?4+OUpw/oymzYvmBuzEdtX+hjrCBMNL5QI9DTPQPVcpHQeR8okd+1Dpj0Sa?=
 =?iso-8859-1?Q?404vbwa62nN3uHEYhpy0kt/94zmQsp7V52nChCSHZssAyQfFPC9JtqVTUw?=
 =?iso-8859-1?Q?B6YRdi9IP7frxtY4O/OWHBOuLGK2g7MM6jfVxAd5oN36XCoYQaFUCms4r4?=
 =?iso-8859-1?Q?XnxZ9fUquSQCMJTJcaRdPLRSx8zqkgW5Eqk8uuEaLqiTiE3NeGjmAvIKpN?=
 =?iso-8859-1?Q?2BfBduo9Ggj07Kb/zAwftcxevgAOydonGL7jVga01zyDJToKU6bTeI2USf?=
 =?iso-8859-1?Q?eBpMLGSbgFa1hBGpNqZl7N1tEIj/ZZ+mIJ9TL9PeaEj26xlBKCqD3UBpRv?=
 =?iso-8859-1?Q?80beCHALh8YOa7GZNzEFN9WuiYXZDTC3wvk2dW4QZIQSUNjdEiqNQg1xwj?=
 =?iso-8859-1?Q?ll8WlJFWF8MXIyQwNserYmcuhg9MahEHblJGiq4JHWvRjeXl23x5AcknJW?=
 =?iso-8859-1?Q?cPy+56fSoKKTwUT3NM8KXdoQ3hhBIU8wBPe9ZeOlc2qp/m+mEJKg1eH0ab?=
 =?iso-8859-1?Q?F8+ir6DJCz95xmtRS65YHtO++FkltVNb2WHRbL/28gBzPFNq9mLkxe3CVT?=
 =?iso-8859-1?Q?By9q74iFEAnAOq+HjdKxPM49XIskNlM7M6SQwFnmRO501C2JeTuR/inJGP?=
 =?iso-8859-1?Q?xJh/j8tq9xZMhhH0naEwdx0NdwWepQcTP2RXlLnqmeI9iFqGS4K/jsuBTJ?=
 =?iso-8859-1?Q?4u0FIm52Pf8NrhLuMhllsbv7QB8CGjaH0YjyofWd5trTQhC+hOFmUm0fSt?=
 =?iso-8859-1?Q?W0hDx+NHWy3QIOYdu/6x/b4LfKe391cIXWBSP7kl4RlOLFfFSxrJDufsAM?=
 =?iso-8859-1?Q?m8qvn3oWSEWCT0xQJ9/48Ir6joh2Ja6wTPj+83+M2BbWnB8h3NHXyfs4dt?=
 =?iso-8859-1?Q?5tLXCKKHkkSr/J+7bZiIlw61kPcFlq/t4ah/iu07jvdTeK+s8BPBMoyPl6?=
 =?iso-8859-1?Q?0spOqB96iKlUC7vGq+3kqlBrEx+9ye4Ah1NlENjJ5caMYyN8tXTM57+wSe?=
 =?iso-8859-1?Q?qt5WPMmxdHp/LQLaO9Rd/T6cnu1umCbHId4E8OFciqvGjw6dCFt/DGE3OB?=
 =?iso-8859-1?Q?IY5Wa7OVz1Gg59uQ94SmqnczUU7LKhHQBL0+m6wB4VDQV6eQHmcNw0Krsq?=
 =?iso-8859-1?Q?FpN2WsOIgrADoeqjMmP+tvN9A3SeDS7AR9BlqVxf8KCFSlIfBiIk6K7UqX?=
 =?iso-8859-1?Q?sLDDaXUrQNXMhllHRfxbiehhd+5duuwNN6KyT5mXOSblyrAxvjVvq9l5bY?=
 =?iso-8859-1?Q?aKLSzYdxmKDstrzawTgvjqWPMg7ehMvBVNAXXUTTIyARcJL3NpMYlMmAEs?=
 =?iso-8859-1?Q?8dr2W7HVvBEHGSAsev1mHcZ53ZqFb2EkPXbuKEdJEMHkpAIaZ08CE3Ha7f?=
 =?iso-8859-1?Q?F3+zW2P5f1eNtp4fzt8HE9rfy/6G57akhujvTk0Rj/0pOX3sy/YSydqESc?=
 =?iso-8859-1?Q?AnKqXJf6PHAG5XGWqNm3WPCOyUTt1VcDmBvF++Sxkv6V1zo6cYXAcRz/c6?=
 =?iso-8859-1?Q?PHRjPRuoRUm6UIT2o9frxMq/5gVZFw1Zor8ubBVQZ3Ts/NiMlXLIHJgQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3e0428-fa4b-42ab-e1a2-08dcc0816e92
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 19:02:11.7716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZohurNKbQiXvqMtygJjG3nZkqB8I4GAQQJ7zFrcSH/kHySlGmfY8IzOmNGRa1Zuy3rgFMlNxOsDKdWiKCHkvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB1109

On some boards, the TPS2388x's reset line (active low) is pulled low to
keep the chip in reset until the SoC pulls the device out of reset.
This series updates the device-tree binding for the tps23881 and then
adds support for the reset gpio handling in the tps23881 driver.

Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>

---
Kyle Swenson (2):
  dt-bindings: net: pse-pd: tps23881: add reset-gpios
  net: pse-pd: tps23881: Support reset-gpios

 .../devicetree/bindings/net/pse-pd/ti,tps23881.yaml |  3 +++
 drivers/net/pse-pd/tps23881.c                       | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

--=20
2.43.0

