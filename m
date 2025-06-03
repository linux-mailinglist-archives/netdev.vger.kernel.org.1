Return-Path: <netdev+bounces-194853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60909ACD021
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 01:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D1918976DA
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 23:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E85222A7E4;
	Tue,  3 Jun 2025 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="o+UKOpOm"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2068.outbound.protection.outlook.com [40.107.103.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD31DE4CA;
	Tue,  3 Jun 2025 23:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748991884; cv=fail; b=eTOxTigtmKHZXAngwofpMYHrUF90ldRjMLVi8UDail2HJASE7Ov/ecqh0BToGqnJTS/B+3Xcy+rrZ59x/W9bEUrOmqW5eCXuYFWTRFhkWV45c9RBL+7oHu8qe6VEDnYXL8q2AD5ImbmIKAWb33VgXKMhGPboCBosE7+PhuHa6uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748991884; c=relaxed/simple;
	bh=rkb1kmx0q6UorSyWR4vtomFFsoVgDfh6kS7wF4G9hhw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZCNAJVqHXwpRLuzxS2a8Bv+v7yERWjPZS+GOxu8rg3rdkKsSa4dfaq2LMbAjjFcZWL1bFchM3KZH4MqC42UJbzTxFzHP2nLaE5E08hNa/BzoqSMxOnv4VbUiPLOO/DsRQl9Af9JxMNDYPyUTcGYYxmyrwX8fIfQe0aUv296fP1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=o+UKOpOm; arc=fail smtp.client-ip=40.107.103.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEhJ3F8pRuafYDFWWdhDunY6VToF/rNXEUUFECxD9KOAuy9cRmLOxpDxfLGWn4lrx+CHmR/kk6t23wpqjMiL2v2G9UCvj6D4dZmQOyk3w7gIoFbMZafYvlJf3FhLkvA8eIKf0bR/WXWv8yJ0oq0qrEtA9gl4+WG6qawmz4MPBXhSIWwR78URS4BKn84O4cAfZO5qXYptb/v8h7Q5oHvjZ6zhXJy88JBzqagFEgCsGweYvBIoIOPQWjhHC7lwT+Cr6RPHVoB6lLIBmRl+JJXfyT9lAfs/YNBdH+LnWIHvdyCzFE5U/w1ZhzqHxH4c7nZPyncBXh5DFbNZ3qF9yEcqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YslIqLFADGfY086k3xwCZGVEQLHQPyu8PCZb9W2sm1M=;
 b=YwDyjwZ5W+xm8ue9sfWtQrMSoQAcOUWxOUjZRCw2USfcZWWbU2Me+b852D1g1nEb3MoreChbk0fYEjoJA/gTZ847b6LeU+CC6trQKrLTrR/oyCJy4Hm+UhOoafvLvWDdzTkoSMpbsX4FfruTIe7uSveY7PcLN1MM2NuRNVlLXFzDxEChUUCI9BRab5tQ4SAVF6hVaDvHwadoNsoeFmBGBKGHioIYkSXOz6egXdF3O1eqiaCgfriF86kokZUzr2wTk87m4+X7+684uO6AjyXEYcpwRqUrQdyfJW8Ymus06nkLw197xaZopnn7ofjFOxL33JjORQnuedV2ImHch3rreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YslIqLFADGfY086k3xwCZGVEQLHQPyu8PCZb9W2sm1M=;
 b=o+UKOpOmGPzUl9FARriXjQXCRLkrlKUCvlOwbsCfTmoS8OxEwSO2kGDbCDqb4fXT+KLI3SxgYWJiBcVF7H1ZcuIrTK/a+5QNdPpqOI5XzqaqcV++fasUayTKT+zgIuG+twIdH22XGnljid90xoSujzTh37y1yDpDaARj0lzU4iHGbtMl7aDF54MTWY4pLP/iVZTGeq1ee6DY0dgkuRzmGKn4kgrOLUwr1jd79vJJdDErGOU6Qsg9FQtGWJeZx8GlNKRe92sBFXfegEHsp4zCv7V2jxXk3jUXpri+QMy29qcDSs9AcwxCk0iTNJ0Cseew6qtfSn+2nc+7Hh44hbREpw==
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by GVXP189MB2104.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.36; Tue, 3 Jun 2025 23:04:37 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 23:04:37 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: Kyle Swenson <kyle.swenson@est.tech>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: [RFC PATCH net-next 1/2] dt-bindings: net: pse-pd: Describe the
 LTC4266 PSE chipset
Thread-Topic: [RFC PATCH net-next 1/2] dt-bindings: net: pse-pd: Describe the
 LTC4266 PSE chipset
Thread-Index: AQHb1NvgFhkGlGOpI0eq40hKzpfY+w==
Date: Tue, 3 Jun 2025 23:04:37 +0000
Message-ID: <20250603230422.2553046-2-kyle.swenson@est.tech>
References: <20250603230422.2553046-1-kyle.swenson@est.tech>
In-Reply-To: <20250603230422.2553046-1-kyle.swenson@est.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|GVXP189MB2104:EE_
x-ms-office365-filtering-correlation-id: bc7ed83b-1715-417c-9b85-08dda2f3035e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?kTdBaAJLvk1YpTLQ1EPDFppxdZ7bxL6oDdyZGr3aTOV0eXtfMjSI8wbqO2?=
 =?iso-8859-1?Q?Z8VPclR99Faiwdi9zUMOimvpZH7SmsG8EsDUvh5wZsMGoPVPUEqws9wGAS?=
 =?iso-8859-1?Q?NALdg/63Szo+PMU0DOFepJYW1DCEFroVKnjDpTna9cJDZtSHUKy1+yk/ol?=
 =?iso-8859-1?Q?0+JbBGeGQVKo/lJFq/FqazBr66wZ6P5fugQONkQQHxVSJCFz/m/Xcwma/D?=
 =?iso-8859-1?Q?KxRyoqHbnHPFi2XJwszcYjBTBOOJEMrMyzPVfL1ehJzQw7XxLbq+lSqUox?=
 =?iso-8859-1?Q?lKiwu6TcKToocvrgUnjRgg6U81F2n8GgIa7NzZ3rOxF0XkJ0STDI7WpH44?=
 =?iso-8859-1?Q?9XwZVJw1n3ZnYAco8xySom7g99nlUxIZQcNt28jD1JqCQ/V1NZtIGZWXos?=
 =?iso-8859-1?Q?N7n7pC06Tpt2Db5nXPLrqJRNJW47b2h6MgHdAq3L1A+me4YjE1k5hjUH4r?=
 =?iso-8859-1?Q?HW96PG925TIDH9RYAP1CmV+5YjNTqcKjOQIFhIdUpBR75CSAjk1OrKfmUR?=
 =?iso-8859-1?Q?CeRus2i0m5N1nCRFVauKe5uQ3C4NoXnLS7ckgHXkf2GqCQ0/+dJKhHmNTf?=
 =?iso-8859-1?Q?QyP9gQrsDEYEBpgCFihHnwB6iCoL34cBkPEnn0GETDZbkqYgsME5cs9PvZ?=
 =?iso-8859-1?Q?lOKauMF/A21/oxGWGecrn6L1HfSNgdCAgx5ln1GIT6xbihyy2lELo54/wx?=
 =?iso-8859-1?Q?SKO0fvEvKo6Lj37SpbYUYTI6KcuD53dvpmzD7IkbWbIgZlXtYKO7nE7pX7?=
 =?iso-8859-1?Q?UxPx/JxkoSccCpXhxAEck61jAwODA7O6EFkw2QigiHKWKCiA+0Qv/OYDWg?=
 =?iso-8859-1?Q?pn2C6PzdYXukpMjaoq3RsX2CQWO//KhGfLDHq1AxI4IpnNqdGlwV627wyF?=
 =?iso-8859-1?Q?uNL0OIScR5gQdOTpb+TSrJqsgF0aCNmT7tl+a3reKWn87ufbg3sZzmZ1Mr?=
 =?iso-8859-1?Q?O+0xVpLDr9/afrgK056X0BuYUXCvnMJXsvn2/pyhB+PsjWvydQthMomXcr?=
 =?iso-8859-1?Q?isT8CKBI/8nr0JNJknJphlMkXVHArM5oz2nanD24WO85IZYX5HLUfQPUNO?=
 =?iso-8859-1?Q?fdOpcgA4g61NOscAx0Q0ircLeaSURyqop8sXjrtESCaKfp/qQl+H0aZqTk?=
 =?iso-8859-1?Q?Fn98tnof6D+qlDLh91GZqzIza2xy24r+Dfpg3fHVSEVGbhbtOSUe2YQFk+?=
 =?iso-8859-1?Q?FBHVhAUqKoBDfSEVGD2hfeGdUMOKxmHPQ1RjdQ9vsNsnoRQhxl99XxR1Se?=
 =?iso-8859-1?Q?sIwI1iR01ROqZh+BYvDyDaEqiXsX/QHwTmdURvdh5NuCjrs7bdfevEOZ2g?=
 =?iso-8859-1?Q?DnLac2L6O+8nQXObL/xq8Mf8mpUgXvFqdRpinsTs6DI7KX6OSUCkAxzrRw?=
 =?iso-8859-1?Q?bK4RuyC4nDPHVBISz2LeJ97zpVXBl8+LPAAnsC3c/WctRnIVRhYakRRAR/?=
 =?iso-8859-1?Q?BrMvW1xmJ+FU6MQMFHG8EGPKQ9A3rL3N3z3VdkTKudHXkRMPrt0Nn7v56L?=
 =?iso-8859-1?Q?4q8x+KGR7esDy8gly9Spvc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?umi5oxVVcu9jvkI8yR34vWPyKMIuxMcQYeZqjscqYusrOuWqfQvtPrg5vs?=
 =?iso-8859-1?Q?7DD+qMB7/zoP6tVS4i5sAWL4NzMq2hLQeDri5fC20/pYqQNFQQiKvkIZPf?=
 =?iso-8859-1?Q?1uA3Im7uM04WTZ/NBkpLgPnU2EGAGgs0Xpy7Rq12TpKK2hgrk9bexHulwT?=
 =?iso-8859-1?Q?4V9W0v6Fv4vqFH4jnrxcLm0RwC6zxGmTyaHxQiw2YjsMCO4lM57TNFRGzE?=
 =?iso-8859-1?Q?tav2XUf5YCsOp5RzTt6a0zDIRME6DOjNbJaeHKOm3pey77piffT6Ofi2It?=
 =?iso-8859-1?Q?5KWdoyGq8cEjBLndQjNunLKa574LC45pK2CVRwN5etsGnSm2AUgmNrxtcJ?=
 =?iso-8859-1?Q?xGYxBgzMaFnlbwV/A0xtezpOppELfF0f2RYJRykBE55PM77aWgP8STuRDM?=
 =?iso-8859-1?Q?1kf9hdwfBMk7quvegyRZr83oKNGWTsdpYqakbl+4asC+90RnzQSAiYeF6B?=
 =?iso-8859-1?Q?axCHrD6Qd6d205riWbz9IBxuNQxU6HW2nzeioAj2/WWDIKdodE29XdtH39?=
 =?iso-8859-1?Q?5XioP37WS4NCRsDsUjEV34D95r1B4ABQEudT9MEnNGmgE+gIgZ4hhvyDua?=
 =?iso-8859-1?Q?Asif7h3RGlKJ0S4XwVHLncbq/Tv3qprZYGaidSg8gnh+pCfKoY3sD0gNE1?=
 =?iso-8859-1?Q?ElanyWzxdxl2481wRXbL3qFygoWK8m3PLyrPSyMyC4oSd0QH6qtlG4XEMx?=
 =?iso-8859-1?Q?gwLiPtbvVNKGK2hfY7/4WamI0ZPE5fisN/nizFTMQ7QtN12EfpBsc+NDdH?=
 =?iso-8859-1?Q?AcWtH3PRZshS16rGYzgv5m8/ZthS1SOuV0CS/36A/8ptCCDOe3u8auxFTd?=
 =?iso-8859-1?Q?xI3OdP4hR+QTn7bqiF/VH+IeT8gRTlKtg7frQ+LSAnB/1Gc/GwOFZZl6Q4?=
 =?iso-8859-1?Q?Z8keMiSd9wLfF267ESiqb4dI6z8F3ZkJ35KOGbdjG+18MZ5cG4Goo5Mqae?=
 =?iso-8859-1?Q?GzuaKaS0gfdNpJ0aUMgKmDrMYe1I1Q0jif/LOAa53pg4NV3mdzbESfexEy?=
 =?iso-8859-1?Q?3GdILLVuEuwcOtoGc7WJPFVIXLAbrSBy1puDT03A/Gviw9iKaP73Nfiaw3?=
 =?iso-8859-1?Q?VBC9x0fb0DDVLKnLtNbaod22ABEUx7PZWUIRTDwqMZGFlP6Rea5fJFrV0q?=
 =?iso-8859-1?Q?H5kZL4D3QXWfqXi1moOoNruLTYCEtvNG/D7uGVQAE6MkKq2wJuyYBMX6Jb?=
 =?iso-8859-1?Q?egD/rZPQ/h0FbNZ20p/m8YJa+ne7UwDA8ffU1EEc0wVXB6bQoBZo8obeu3?=
 =?iso-8859-1?Q?FfU5eaKsQHOaTGlL/QWd/GrPgUBvq+tQ6uHtVApCreS7tG26Z6xYfV+J6t?=
 =?iso-8859-1?Q?L96EBxmE4CmtBdkYtSB1aGv3+IxKUhj0whK+owSr/CLVhnFBRw2+CqTn2w?=
 =?iso-8859-1?Q?jTE/N0pUTn90JJliRXDN2o1VbXZwH/O6Iflu1Qog1XUZBHrmcro6GkdgNP?=
 =?iso-8859-1?Q?Xe7YldSICuFIKEkC6Y3TMHv3TRBapj69blVfwNBe4GWckMCDWiJHUWR5fU?=
 =?iso-8859-1?Q?n1GMg2ulkY1f6iNRNNlXHCh98HinxUmJ+ZQeECkXy1gjbjNopvZGhBDJ0h?=
 =?iso-8859-1?Q?iJQyH++NfzMXFAgwVg6ZMc5dxp1qFOHpCj9wBg00TiFNHowxroB8DApxrm?=
 =?iso-8859-1?Q?Mo7b2se53JoMi6BA0KCwWibZ2tJvMRSfze6OiqOBow5jjpFOJDyXlLsw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7ed83b-1715-417c-9b85-08dda2f3035e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 23:04:37.3543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5wXJAS7Ag/lloDNs/E3+VRoFJjghiqm5/pXLjqZThk6NvXN+EunSPL+0L7Er2fsonqeHqjpS8QrBNL4ur3h7/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB2104

Add the LTC4266 PSE controller from Linear Technology to the device-tree
bindings.
---
 .../bindings/net/pse-pd/lltc,ltc4266.yaml     | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/lltc,ltc42=
66.yaml

diff --git a/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml=
 b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
new file mode 100644
index 000000000000..874447ab6c84
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pse-pd/lltc,ltc4266.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LTC LTC4266 Power Sourcing Equipment controller
+
+maintainers:
+  - Kyle Swenson <kyle.swenson@est.tech>
+
+allOf:
+  - $ref: pse-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - lltc,ltc4266
+
+  reg:
+    maxItems: 1
+
+  '#pse-cells':
+    const: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  channels:
+
+    description: This parameter describes the mapping between the logical =
ports
+      on the PSE controller and the physical ports.
+
+    type: object
+
+    additionalProperties: false
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+
+    patternProperties:
+      '^channel@[0-3]$':
+        type: object
+        additionalProperties: false
+
+        properties:
+          reg:
+            maxItems: 1
+
+          sense-resistor-micro-ohms:
+            description: Sense resistor connected to the channel's MOSFET,=
 used
+              for current measurement for overcurrent detection.
+            enum: [250000, 500000]
+
+        required:
+          - reg
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+
+      ethernet-pse@2f {
+        compatible =3D "lltc,ltc4266";
+        status =3D "okay";
+
+        reg =3D <0x2f>;
+
+        channels {
+          #address-cells =3D <1>;
+          #size-cells =3D <0>;
+
+          phys0: channel@0 {
+            reg =3D <0>;
+          };
+
+          phys1: channel@1 {
+            reg =3D <1>;
+          };
+
+          phys2: channel@2 {
+            reg =3D <2>;
+          };
+
+          phys3: channel@3 {
+            reg =3D <3>;
+          };
+        };
+        pse-pis {
+          #address-cells =3D <1>;
+          #size-cells =3D <0>;
+
+          pse_pi0: pse-pi@0 {
+            reg =3D <0>;
+            #pse-cells =3D <0>;
+            pairset-names =3D "alternative-a";
+            pairsets =3D <&phys0>;
+            polarity-supported =3D "MDI";
+            vpwr-supply =3D <&vreg_pse_1>;
+          };
+
+          pse_pi1: pse-pi@1 {
+            reg =3D <1>;
+            #pse-cells =3D <0>;
+            pairset-names =3D "alternative-a";
+            pairsets =3D <&phys1>;
+            polarity-supported =3D "MDI";
+            vpwr-supply =3D <&vreg_pse_2>;
+          };
+
+          pse_pi2: pse-pi@2 {
+            reg =3D <2>;
+            #pse-cells =3D <0>;
+            pairset-names =3D "alternative-a";
+            pairsets =3D <&phys2>;
+            polarity-supported =3D "MDI";
+            vpwr-supply =3D <&vreg_pse_3>;
+          };
+
+          pse_pi3: pse-pi@3 {
+            reg =3D <3>;
+            #pse-cells =3D <0>;
+            pairset-names =3D "alternative-a";
+            pairsets =3D <&phys3>;
+            polarity-supported =3D "MDI";
+            vpwr-supply =3D <&vreg_pse_4>;
+          };
+        };
+      };
+    };
--=20
2.47.0

