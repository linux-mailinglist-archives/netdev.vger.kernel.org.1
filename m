Return-Path: <netdev+bounces-115589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A67947088
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 22:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5AB1C20810
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 20:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D601384B3;
	Sun,  4 Aug 2024 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="w15O0Qcc"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013045.outbound.protection.outlook.com [52.101.67.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C634877102;
	Sun,  4 Aug 2024 20:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722804604; cv=fail; b=IWoxUP4f5e1N8yn4fQEt17ocVOjRc3Ec2nHKWr6vr+2SrChjvCLbdynZjyl3RVjUswm6m+nHRkEWfGTj4sJWI//Inrg7fcVmhwxo9wmM1dkUniuw5fPssrdQdXBUQNBCt8+D6TfxJ6blt2pg79XqHKAbFJmQU65FfwrX3h8knXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722804604; c=relaxed/simple;
	bh=rsfZWh6Pdl8abiHTkN8k5uYzX6cbziQ2r4PDgjZREk0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=B663h9KqAAEN++b9jfeeRDcftCag6XL6VtNhfvc7aJdFYl0bDfPLGeAnBuC07MsHTfMJdpe8Z66s90fGir3djkZmF5EcIPSOGsmEc+omnbQwCjz6qTy9YXB8z+2I9Yx7m/Ecwao5oa0rMItMcn4VcKs2Sx+muVJsNwrL5OviTTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=w15O0Qcc; arc=fail smtp.client-ip=52.101.67.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSPypwUng6dLspPuJLzYnoZBrjt6Gzdnp6qazIpZWworA5A0caUH7PORJP0xXZSXIfersTA1g/Q1pmmoJU6IjE/tVKoMWOlh67Aq3kTBFtSqxWxD8A/tT1GnNlQRdMPPPHPBMZA7oIPk/hSX9oIUaPOYztoimQq/kdNAPAY+hsgjQh/bTc6pUIU1txaofUYBxj2wfrFkKtPH9oNChuhM+LlpyvHmb/n9cZmeDu+F3K6uBfrLXgP8YYiSSwRKjzwnZrGxNCbowygRxBDS3CbB03PVXc36fUhyUUpx7zywT84PbhN/+RG/jRWtMweKW0y09JLsvJ2tB9XbcumpHXQ0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwKhSRw+uiEh5mXtgk+giF0HBGnyeb2UKaFcSBnRScg=;
 b=fboHan2sFZA2vWWRrcsyvKp6l3SvnnUtCqmasOOK+dvxwHGn0SI0/XHHtndVi5fz6Ae+HFDyFpa7tqFE0Iqw2I9vr7IuakFrzIIBbL+BcuzqLIEzc60XrKFMQYHHPimmdC3dzzU1Y3fRSAGUTOu7xh7bHlaWDVkcKrgDrwYQcOSMASwh7gYsZRo/Vx2dOmJWzJx1WMCdSCoBqZ4+uEKSqqUvrbtpT3KyfC4AG03mooviS9WZ9heVJbzhInIIWzbsB8w7HTrnIxzf4n5tM13kKXTIKTWNroYmOiZ720+Kt12d7jtx6BHBpuPFaqpJR8Bvbej3H5ngBrYA1g7O9+FuGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwKhSRw+uiEh5mXtgk+giF0HBGnyeb2UKaFcSBnRScg=;
 b=w15O0Qcce+QuQ/VG774emuAEM7i+n4KaKNRp9SzszBcaZdzyaf11+417l79GPZl+kP6SScI9LxM1sGmSujSYYCfRVqcnurVn9D9hOP3/AdQKGkeR90rEkvW28Ucx/OAQh3PXWG3h9uW2k1N3U43LS0sIGQkS5oMXywZT4dgqSZm0gnaQIkvTDMyoOqkwr23IouywtK3YVlY9iUG656peJnbcBpR5EeJZs6fEYj31KIDVxYGQMnpbDWEO8+umDq4asHA+4wsgVyE5wLpyZ+FO18/Ono/oqOESCaEqD9EFIw9lt4/fI8fPVLtvmJclfcBugnNAKZsmaUiBeJHXX09otw==
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com (2603:10a6:20b:431::16)
 by PA4PR04MB7965.eurprd04.prod.outlook.com (2603:10a6:102:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Sun, 4 Aug
 2024 20:49:58 +0000
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27]) by AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27%4]) with mapi id 15.20.7828.024; Sun, 4 Aug 2024
 20:49:58 +0000
From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: dl-S32 <S32@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH 3/6] dt-bindings: net: Add DT bindings for DWMAC on NXP S32G/R
Thread-Topic: [PATCH 3/6] dt-bindings: net: Add DT bindings for DWMAC on NXP
 S32G/R
Thread-Index: AdrmrOTtkwWMBqX8SE2obTTIuZV8xg==
Date: Sun, 4 Aug 2024 20:49:58 +0000
Message-ID:
 <AM9PR04MB85066A2A4D7A2419C1CFC24CE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8506:EE_|PA4PR04MB7965:EE_
x-ms-office365-filtering-correlation-id: 95e724cd-036c-482e-17f3-08dcb4c7010c
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bsV0Lq89C/tHUrOl3M0uTMiXfknKIIs6y7Ka5KPhdaZSRwbi8G+mxj801D2/?=
 =?us-ascii?Q?TKeJJn7IkZmxiqaqpBsmOGaTk0lSbNnVUG6rG12czWjcli6k3oyIzuJ2Mp+D?=
 =?us-ascii?Q?zxMEQaDCRmwz0ghL/t03ct+8/sC4r6WZDfSYwS1N5RZ48fCswEu1+4xzS2YI?=
 =?us-ascii?Q?rsFfqi4Ozjxv5FAe9A/xpNfIGGbKzit6PjVGmdHoQj4ucBWMcq3e45BfgU3u?=
 =?us-ascii?Q?O+8PvfU7peBT+4Nn2WeFREbaIvaLgYflk5AJwYM4Jm9Q6bMK+fnGJYyIlZfL?=
 =?us-ascii?Q?V1uUZidwJLbs9Iax6mHxc804ftZIwESwfZaRTFiokP3s2G/+ZVXcIejJaVhn?=
 =?us-ascii?Q?wuQH+NaVwUWxkXNwibVY+S3X7PTPpJlgY7oxMtFcVbaK4N9SsFRBo+bDP1PS?=
 =?us-ascii?Q?flP1367ov54ks+jm2QEB98rMaWxXTxjswPFIkPdJ+3Y4QoayLCuMhshCFvfR?=
 =?us-ascii?Q?pmIiRvCn1Lkd1V6XGziiYfIFcnkgiyvNLiusoGn24xGJfxdeK8RTeH0KlcUj?=
 =?us-ascii?Q?w4JLcnCueUER9Azh79A59g8/mKDPlf9hBrPJ7vL08L7HUB9P/oJXeC9B8AZK?=
 =?us-ascii?Q?LC6dfIqoiGKkjS76b3D7hrl7GOBUNn1o4puPIzTZuVTyAh4Pjwt5Cl1Zqj8c?=
 =?us-ascii?Q?jERb5bMxhFK4wqotPbsECF2J178icXcl5yT2eAYCSu+7epqiwGNIVUEb5mbL?=
 =?us-ascii?Q?rhM7GikltQLiS/qsHs2qcxwjA1biJBGceHJFkz1QnPSFtxnawlMFZXFe/ihw?=
 =?us-ascii?Q?LC2MZlzjjlyUHr2tAxk4G/NFZZQoiwAWf2sjXFy1SvZKGvaY8eWxf56a7zFJ?=
 =?us-ascii?Q?2RvpJHYllT5FGtDsqeycS9Gs2h2Ys6Yax3EhgLRaLRB9s5VHfSUmF6pgY0aA?=
 =?us-ascii?Q?XnU+6YTelkspdGbitthfBfDknDKVIdlZWA8HoycufZsQVU9AB/+zIdmgjhO6?=
 =?us-ascii?Q?vZ+QI3tBy0tZ2BQpSWEP+hvB6+klZovghfXzlIaWzrTLYzEIt4puEwt2C++F?=
 =?us-ascii?Q?xqvERjw3kVLrmnWVa/Vzv4XcYEPxhWjHvPhEDn2tI0onbJJDFfUo6xqaBFxi?=
 =?us-ascii?Q?6JInip4C9NwGmji55HioQNF//Fi3A9IogaPnDajiWNhlTfyd/gLc8BrNBYje?=
 =?us-ascii?Q?R5u9HtH8jPy0XIJt5ygPmMrtO5/FqGv1Y0n9O5uq2dB+6O5cpNNb4+FSKEhG?=
 =?us-ascii?Q?xyQV7QXpmQufWT809Y2345evqE41H+DlGDGvI0EImLwnn5/++TxWPCewMSYp?=
 =?us-ascii?Q?xDF+UglG1mJU6DJpdeS9mcc2vZh+StpLJQ9VxGJ0Ua2sUJQS0Coodf6apv9G?=
 =?us-ascii?Q?iH9j2arImeP3UtI1nqcRm3kcRX0eFAZRd7T9hF+Unj6ETZey70kTgxqXNIp4?=
 =?us-ascii?Q?hYB7/gI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8506.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gOZguMxaqw8ic/M74yQiP+Ij+BmDG0gblDTO9anF3MRHTWqOLWtL6UW8TXR7?=
 =?us-ascii?Q?4OKECdtMt7OYNiBLQ0uMTnGs+shUmhGHQajo/RMe9E/jD05BzubyPqOvqbsE?=
 =?us-ascii?Q?VMlCe1smfuLFcqL2S8jOrdnqL5KPLlPmVaqC99MR9z9c4pdsZs3iZXR3a1OS?=
 =?us-ascii?Q?bakQWk8KZGcljk65Xtqx91+XlOrjOLqt2mOJBRdWjBJWX2KyFc+Hpf4wS8db?=
 =?us-ascii?Q?Kb2oDtf/AS+XHIsHgFDRtgHo3+uvlk9vA4YdDR8nXf9bgpBk6OzNFX/As0mG?=
 =?us-ascii?Q?MKyWB4PoPQ1BiOB1tbmcsenqZ37lF8APTB3VYr8we9Xy5QyZJdbg2JF+McUC?=
 =?us-ascii?Q?WE+zBY8Om8UpkJRHdG6DPLlWeSHOxlutVdUghStoU8u9fX3WabG9P74TViIx?=
 =?us-ascii?Q?bDjcN1S2CAqR8Up0CJxi8aajtjb5JJqVlIxkLzcIPb3xmKrTCGNBkbW9AvpL?=
 =?us-ascii?Q?FMeIe4pqA79tk2fCK9rD3+cbmy2fHjXkDal2JVq/TUVn/Rv2/AoOo3bGZSvn?=
 =?us-ascii?Q?HS4C5tZciuhvizLGJutFud6+xt9pFAJOk+Npr7zty+u+/d3KTXbiQDhi6IbX?=
 =?us-ascii?Q?TKLuUv6Alyd6TA0QB7buybouATxizYJOm419i0H2StvgBi+fAs4agJdlBk1/?=
 =?us-ascii?Q?cxIxi/6KQbG8M0TVGVj8ItH1OwfiHb907wg2Ijkg3nHzcTmXUINehbLwWQZR?=
 =?us-ascii?Q?18q0L5tfZox5bEBw5MXbvdKx/fDcRJcQwTsDqEgF/9TX2T43x8eQLEtLYGeU?=
 =?us-ascii?Q?yFL1P8AQtvS7nwXoitFl9flxnA7PsWUIMwSitPPh97GVt4XtITBp+R4xAhDB?=
 =?us-ascii?Q?Gm2yNKkOIDBFBUwqKpYumWG6AZL56ggQhEwrGFxc7l3LFSYfJWYwI3GcDKlZ?=
 =?us-ascii?Q?VObyMJHTJPx5txMocV2dA3CIXq0Gy0droiwLB5JP6P0Dm2xU1jXKrcV8/NOT?=
 =?us-ascii?Q?MFVMDfqs39mqKg9pKBDadj0WvFEbCTbv9bkBt6+sjurDjp4mliJnYs6K76XD?=
 =?us-ascii?Q?QxpMG6vQzQGMLPmQ2VoSVJqIzRt4kVVCY2v32R4qTzvH6UMJ1jYBlnuc2Buu?=
 =?us-ascii?Q?t11CBt/Q0EOuVHiSsVRH1u5KconVJVEZ0cWqv85h1h921Zk9uifZZQUSuYuh?=
 =?us-ascii?Q?WAAU/xd2BJfEmGphiTfvtz8Qa7DVnZJOD6FKA5eF0brxdIgX9eVWY4ifdTAA?=
 =?us-ascii?Q?bd5RcpBUg6SxYazRjRawAUkw6N6E/O+XqA0pV2LhOhH6K1D+auQ/WjTq9qi5?=
 =?us-ascii?Q?o/pXZk6ZR84jAS61f5M0bG6RFwwvRnHDn+vdmFhT1SASe1b/xf5nxNzlAvwx?=
 =?us-ascii?Q?++M9MXSWIZQbUxpSGf5KcGYp2g7YWXzire9OQ2pk+AJ2q0NqSRtN7IdB1dkf?=
 =?us-ascii?Q?4A1rDaKu1sUr+0AfwsE+gSEOvcJnXB9fRAMKyY0qkqyDSXKCPSYL9kjhUv4W?=
 =?us-ascii?Q?6s7dGyZ6k1DTpmbmxLc/uvgxj7BmhuHqO+WFXLNrln8uTxPEb9cYcMycCsML?=
 =?us-ascii?Q?noM45c5gCH0Xd3Er9Y4Eub5qHze6pKVjCcqcnSBAnrZFOyLX3+1ZoPfdrqUd?=
 =?us-ascii?Q?TUhUL89bW3tDnOc9CGyo6wIRLl3BaUlD7lFUnE1+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8506.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e724cd-036c-482e-17f3-08dcb4c7010c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2024 20:49:58.8563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6lrJzuIad+BiLWyBFbFeGr5ZjuoJWf/XQhl+oyFokvRDCPnvKvzmfKfLzaA9beAxtMe27nBIMiFTtbBDgJ2dnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7965

Add basic description for DWMAC ethernet IP on NXP S32G2xx, S32G3xx
and S32R45 automotive series SoCs.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 .../bindings/net/nxp,s32cc-dwmac.yaml         | 127 ++++++++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 2 files changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,s32cc-dwmac.y=
aml

diff --git a/Documentation/devicetree/bindings/net/nxp,s32cc-dwmac.yaml b/D=
ocumentation/devicetree/bindings/net/nxp,s32cc-dwmac.yaml
new file mode 100644
index 000000000000..443ad918a9a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nxp,s32cc-dwmac.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2021-2024 NXP
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nxp,s32cc-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP S32G2xx/S32G3xx/S32R45 GMAC ethernet controller
+
+maintainers:
+  - Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
+
+description: |
+  This device is a platform glue layer for stmmac.
+  Please see snps,dwmac.yaml for the other unchanged properties.
+
+properties:
+  compatible:
+    enum:
+      - nxp,s32g2-dwmac
+      - nxp,s32g3-dwmac
+      - nxp,s32r45-dwmac
+
+  reg:
+    items:
+      - description: Main GMAC registers
+      - description: GMAC PHY mode control register
+
+  interrupts:
+    description: Common GMAC interrupt
+
+  interrupt-names:
+    const: macirq
+
+  clocks:
+    items:
+      - description: Main GMAC clock
+      - description: Transmit clock
+      - description: Receive clock
+      - description: PTP reference clock
+
+  clock-names:
+    items:
+      - const: stmmaceth
+      - const: tx
+      - const: rx
+      - const: ptp_ref
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - phy-mode
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/phy/phy.h>
+    bus {
+      #address-cells =3D <2>;
+      #size-cells =3D <2>;
+
+      ethernet@4033c000 {
+        compatible =3D "nxp,s32cc-dwmac";
+        reg =3D <0x0 0x4033c000 0x0 0x2000>, /* gmac IP */
+              <0x0 0x4007c004 0x0 0x4>;    /* GMAC_0_CTRL_STS */
+        interrupt-parent =3D <&gic>;
+        interrupts =3D <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names =3D "macirq";
+        snps,mtl-rx-config =3D <&mtl_rx_setup>;
+        snps,mtl-tx-config =3D <&mtl_tx_setup>;
+        clocks =3D <&clks 24>, <&clks 17>, <&clks 16>, <&clks 15>;
+        clock-names =3D "stmmaceth", "tx", "rx", "ptp_ref";
+        phy-mode =3D "rgmii-id";
+        phy-handle =3D <&phy0>;
+
+        mtl_rx_setup: rx-queues-config {
+          snps,rx-queues-to-use =3D <5>;
+
+          queue0 {
+          };
+          queue1 {
+          };
+          queue2 {
+          };
+          queue3 {
+          };
+          queue4 {
+          };
+        };
+
+        mtl_tx_setup: tx-queues-config {
+          snps,tx-queues-to-use =3D <5>;
+
+          queue0 {
+          };
+          queue1 {
+          };
+          queue2 {
+          };
+          queue3 {
+          };
+          queue4 {
+          };
+        };
+
+        mdio {
+          #address-cells =3D <1>;
+          #size-cells =3D <0>;
+          compatible =3D "snps,dwmac-mdio";
+
+          phy0: ethernet-phy@0 {
+              reg =3D <0>;
+          };
+
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docume=
ntation/devicetree/bindings/net/snps,dwmac.yaml
index 3eb65e63fdae..3311438f67ee 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -66,6 +66,7 @@ properties:
         - ingenic,x2000-mac
         - loongson,ls2k-dwmac
         - loongson,ls7a-dwmac
+        - nxp,s32cc-dwmac
         - qcom,qcs404-ethqos
         - qcom,sa8775p-ethqos
         - qcom,sc8280xp-ethqos
--=20
2.45.2


