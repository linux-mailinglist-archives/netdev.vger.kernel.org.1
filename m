Return-Path: <netdev+bounces-212847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8471B22417
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242671AA83A5
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40502EBB98;
	Tue, 12 Aug 2025 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="diigGEss"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBAE2EAB98;
	Tue, 12 Aug 2025 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993244; cv=fail; b=a6RPiCd11KmEOfOTup1hwA4co6QwJhiDmBIfH014QZ6pM8tQMWD/pmmTSklTf2G1k+XI9I0sPp3eOpxxwJVfHPVn8+FYq2IzqBLb3haFHcsEYwnPMg7mEvzSYL7n4sGhg27UW+A1yrI+Dtu0IXc4pLx/XAldTCmm9ujWL7oUcFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993244; c=relaxed/simple;
	bh=QSDa+z0X3xNWU89mk1wa2iZntT+qNN8hvd8PDj5dzHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fohwB6BqplZBIYMcvO63th3vBv8QBbQ76EnONqmUPoFkiFaJZwwoZx8eeEvM9eVzS3CM5qZ99VrmidVFA6CFjNqhGsAi+HFXHYZ71OYX+BJM9S5p+cDZZDXZ+9NYfxG44lH/orF+JLxGDIg2E0kGxhSCZPWS4r3OT6rvZ3gQaio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=diigGEss; arc=fail smtp.client-ip=52.101.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkFS86V2sDxQyrJCc4YiZ18reOo58dyoCKIa/lpTHumhXN24rJQH5RC4PX75Q9FYz4/leIOGwSCzkhvrvcd+MKgdYaqPy7Zs4+OtZ6N0I0BmfapiO5gXwamf/gUZ1EGfVZfZcqTtYwHdcXIElmbawP6Hxlz/Ae2oP5Zi2aGHXlA5D8YXwtXNg2tqW3ySkVjtO3R2tl37IOgmY1rssnQ2J2oZITIYKF76BXBoUh4pYNx173qg6AgdR2EvWLo5YLI7aE/vOF+CmUgK4NQ/t3D4DQnjKUXJpixlzIL/kflw1ZYcGXxblblr3lUSS7YFGy2Znoyip3ukHCuKF0vhhdSHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abw9KYTmn+muT//6OoddiuGCXKbsF8rnDXu68IRUUoY=;
 b=GNKH3TEEVqXgr9afH9phmPitJZqfBQOtAf+lrBroZ/EsQUbEdXS1Qq22bBJMYTjfAsuflMNWv7jWEtIw/KFeHz0V9JAqGK153H9cmbQSBQpp9hUfGR0aomkAt9F4y0AQ+fXxC3aFkX9bCapwP8qPtQHuo9jCUO1cG4pA0Wq9CPDa5Jc8NTE+S4N3MtyiiyhjFeflMcRovTeQsl+GeQpFtHpFVWsyBFCIt7rx+WyBiOpj5ozZlhLQFClqLlVuUl6j3R+PNv76jdfWSwHAxseayoVxtwA+c2xOqCRkaWP2ZVhlhUY3Mn/LJQomO9q99IZMK7C9ETEitXdqW3rMsABvLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abw9KYTmn+muT//6OoddiuGCXKbsF8rnDXu68IRUUoY=;
 b=diigGEssi/SJ60ltYhkDKZf64inXyzgOI2lB5176Lb6EVNbDvq8TBNXqxlFZ8yFFvZAC6zWz4xzO0XhvaRwubiV5lT9MlZiBn5mnXgOY0qpFf69sd+uSae1EzYAuQXmT+/AUe78vMQavPbe1YwtM5rJttqKgN+l86THgTuqI99LLOODESf1yWhtHAyZ5iQELrWZtViP0AtH3atshrCeh27hm4kC4AMgL2Wco3pnLvjcKvWhZcbQFnCi6aKqjTWmLXB+yKhz4HnUdz/PTc5BUSU5BHvVaESMpMrODh1m2dTiQERm1Bl+O4K1jrfnJqga8kfeiCi6IzjZKoQHVSWTStQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 10:07:20 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 10:07:20 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v3 net-next 03/15] dt-bindings: net: add an example for ENETC v4
Date: Tue, 12 Aug 2025 17:46:22 +0800
Message-Id: <20250812094634.489901-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812094634.489901-1-wei.fang@nxp.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f92196-1dc1-4e18-b9e1-08ddd9880651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KA0Zn15CEn1wesKUzQ7JFsdi4vCiOU3K65Dp5EIjritGfsTlt8p1wBAsI3pE?=
 =?us-ascii?Q?WPpogyu+imij6WuNNJXVBGlznHop1vcX7q0Vbef2rBVelMEZqguosOyyGnxn?=
 =?us-ascii?Q?E6ihI1QW2aKBEB4mbLXv6OBYI2TRCxMbEp9ilWppx9rQBlCE5tsqZfVmeo/w?=
 =?us-ascii?Q?82+O0nCumSbQWpKNbQg87UrkKu19MwXWfZ2raWTZ6OubGn2pWKbsP6e5qgw+?=
 =?us-ascii?Q?5OOv4cJ3dUTJmwdcuhVKBeS7oPL+vCs40IqGnXRI2ILxNF/shl7jT15SYQDR?=
 =?us-ascii?Q?jTJvR6IjGsJT7pAqXaOO70vZsGRwNKDN4JMHMpREvJJVHRgMGkjr5wpu5cWd?=
 =?us-ascii?Q?wISn8VLMBdALjkB5DYTbc1jKbY8oHxf5tbyxIaceTE02ZdXS/ooHRQtKDaPP?=
 =?us-ascii?Q?hOTQb3hnosHG+24hqqTuvq3+pdei5+1zHoBMx47AkcpAWrJcpHE9NU8IXX8G?=
 =?us-ascii?Q?gdoCIA6zrF3nJQ+gk7FcWF611YNxFpx/qhkBaMrfLyer+8iLevpf7NOjX9wW?=
 =?us-ascii?Q?+c6mAGOdmyFsE6aA/EaomidvY4HhHL0RXAmkG/K617aP3eGk21Jvp9Szv9eG?=
 =?us-ascii?Q?mXYbFPWDnTZtfPdgJ3FsE0b4t0PdslWKEBc/5+bVkGn561OPUOHsqV9panjz?=
 =?us-ascii?Q?a4VnWMxlDSV0GH/tg1yN5d9zozz+N9cNYKDFP3afkxdY9aN6+iUZ2/p6LzLG?=
 =?us-ascii?Q?WpMaf8Z5IHBGUOG8MJ4YiGEOR0MtvsKdfTYYUVGC0/BjeQjTdyW0fA1VOl9l?=
 =?us-ascii?Q?jtSUbiRB00z0ir5/WIOTKiYL4Y7xiAV68XT+6xx52VJhZVOLZ4EdceiArzwP?=
 =?us-ascii?Q?3/1AmuDWCe8mOVe4XQv+YsdKV70gKI0kw4e7DOyC2sGNa4kkS4alQIE9lAiJ?=
 =?us-ascii?Q?crA5hd/f6nQUAO1g3+uBe42oCP6F09V2lTtySvIyumZFrpjWiglLdu/AzuSg?=
 =?us-ascii?Q?fuV8euaEXKmbr/HlpVOsHArahJNwfEtiAXUrlS1p+2F1d3voFnZ24XeO8K3e?=
 =?us-ascii?Q?565BKUQINZsgbA6DNPImuAYreiYfZrVOXgddW35788VYCv4ItXLcioJRV9jZ?=
 =?us-ascii?Q?r14QVNSLPBIlCxMX+6A9c7yCuVFiyJKN4TJOx7pfd2D7dxsJtIScJOb4l02y?=
 =?us-ascii?Q?GMl9CxZ9rB2k3xYc0E+F+xtIufv6Mq/4wa+gqD/UXlCfWS4Agd8CtLL2iEm7?=
 =?us-ascii?Q?mfKGqoCUGX9qYtdfgkaGqOGmik+t6+2xwHTMsHIJM8iPiJMeyR5EHI2iqeRK?=
 =?us-ascii?Q?jk+JMiHi8YWmVxTvFNucpgC3ob+079iDaFh9VsGugkzwVUYWBqU3YgSpO5nb?=
 =?us-ascii?Q?bCqE2v8hxmPrfcfFitic2+EY2JllfaB+nPEShn6/mO6UGrJWXvfKpcZYNhNb?=
 =?us-ascii?Q?byr0XZw331MI3gQxj7rqOYqbpoOk6ECvR0smvIWMTIXLhGMywHgx08DmguD4?=
 =?us-ascii?Q?iYutbSE9tmJLtmJAoIBo+YNrBJtupv05SiC4cY2fMY12kvNmpxwSLxKndQUN?=
 =?us-ascii?Q?G9bzptclOC8Azwc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LohhjpSOyglKoReo0sJvEYiZa27OxHwaJ5607xuGTwcbrwR11tkQxpneptwA?=
 =?us-ascii?Q?CVU2td7AZasPw8Kc+9SsKd21RS5CJsLde9a8tWldrtm3bbXoiCwcEizkYkDe?=
 =?us-ascii?Q?iSniAR89fOziPYJ9GYqxz4w3U59ifQ0zzE91OtGXyMNXE6h7VbZZfohVJVA3?=
 =?us-ascii?Q?x5eUQG0n3pVYL1V6nEupVA+Z+DI3BCgfN8FGC+69tkbOH+PG543P2YK0siBA?=
 =?us-ascii?Q?zDFcKiz5DzBk2EFnRZnqiyVPbHC3+20MS5/dZE8S7TjyVz782EADZ9Y9nfvN?=
 =?us-ascii?Q?lvaeR/UIev4MyrZFhL7csHUgEvI1zI/uQYZALKr4stHvV5WTGxOQZjWy77V3?=
 =?us-ascii?Q?C9NPAmvy2rjQUJo8K++wszyqpPMIMZH/b8ACfprEKq/VpLoZnsNZEqftTc0v?=
 =?us-ascii?Q?Hj/H3TohGJUukXdgrYlwT9Dn2jzGLWyGmMoUD6/DNB4j8ojTS5ZqQCOYM9Ye?=
 =?us-ascii?Q?UtCS9yFoHOwWPEdSnHzkskTGErM7lP5R4gm8cG8wn+lPMlUXqd5ZpUkprLYQ?=
 =?us-ascii?Q?hveTCiuY/JxEBY0zLpNlYfijXi8z2vsri7xK8dtJNLxdoeOEbyo+IQ44j4qw?=
 =?us-ascii?Q?oDh35ZETr5SX1IL2yWp0LkcDkIrm/GHLnckpdpSiDqAnIMNXxz7ZK6ZqKTEy?=
 =?us-ascii?Q?FuABjpXf+cHnhr8d4NaskHmnYfzAUJvNfsJ0gpL4LV0mNI2AuIVkyUyVn5/B?=
 =?us-ascii?Q?EgkKb1Cwb0At4E8N1Pers5GK7GzLKyOiMk31qp9cVIQsuGBnAoORPWNqluZn?=
 =?us-ascii?Q?KOIacm08O3Sr7rJMnye3A7TOJy6pRq1DNVRkuBGymOBsN/TOMYi+FaR7Z7ZI?=
 =?us-ascii?Q?lydXay7y0q4OhBAn0EA5Y/57TBfJzaT3oJm0+KKc7ZidE4Zy2786ztnZuxnW?=
 =?us-ascii?Q?sH/H63OBj61Woie/mtbu3H2qSlFTkn2evge5DjXD2B3Ab0Gws5TuoQNOxzwY?=
 =?us-ascii?Q?VJjWT2FPOpoap9vddTlJByOAp5pyrszVoYupjhvzV3Ekii5uhoekZI38yMYl?=
 =?us-ascii?Q?+qOAI/rl9ISfcD7t5xfL2xDDSEbyc1soVfrDTPTTz6fQnFAQJbX43OEsc2c+?=
 =?us-ascii?Q?Ofg2z6iO2IKu5ZZjd39oijWC4qP/K7EoNherhc5TTiK45ySayRU//AmNxSVW?=
 =?us-ascii?Q?ddqr8gsUmcbMjCdpJzgDX5GtE5tNVhshLCiUcTlqfnjb2tS2UUv7dGDHTChA?=
 =?us-ascii?Q?yd98RVI4lo1sXpMWmjsjNGGBWxu8tDmeDqnKyJOJn+VBE70T6CtLbXGTjFXs?=
 =?us-ascii?Q?BmsN8LHVl5IWlKEai887M4JlB2Qox2zWNa5AsA1GK3t8ozjzS9/qp+753R1M?=
 =?us-ascii?Q?/WFFe9MpAVMB8WVhufb3ZqtNFAVU5CSrePCxTzocM3saDakSm1k28z2gYacM?=
 =?us-ascii?Q?T7waDlFe/mGmPjaz8XLg+NCbbW2D+PoJNXztRttOHfciJ6wV1Am6MfILIDAF?=
 =?us-ascii?Q?5bsmSqWqrbf0A/bWRAxl7iGy0Gnw7SNKVm6IUrNlfJ8gv9ydYAS4s3HwICw+?=
 =?us-ascii?Q?dmaxH2+qaGdygGlT5RXKw8UfMrg6NtETzXieN91fS6G+BPZm39ZAVWKWuiGQ?=
 =?us-ascii?Q?kkqVaY/bbWC9W/t8Q2R3/k9gaDWdI32u0dBN2qPm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f92196-1dc1-4e18-b9e1-08ddd9880651
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:07:20.4694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCCtqqAvrr9xrheRMxwIB9xHDt7MLKf7awv0sl2PyPv1cr7RL0iUixxW+dsWsy+uIS2RNgIIaHUO7bkDWbksiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469

Add a DT node example for ENETC v4 device.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2 changes:
new patch
v3 changes:
1. Rename the subject
2. Remove nxp,netc-timer property and use ptp-timer in the example
---
 .../devicetree/bindings/net/fsl,enetc.yaml        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
index ca70f0050171..a545b54c9e5d 100644
--- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
@@ -86,3 +86,18 @@ examples:
             };
         };
     };
+  - |
+    pcie {
+      #address-cells = <3>;
+      #size-cells = <2>;
+
+      ethernet@0,0 {
+          compatible = "pci1131,e101";
+          reg = <0x000000 0 0 0 0>;
+          clocks = <&scmi_clk 102>;
+          clock-names = "ref";
+          phy-handle = <&ethphy0>;
+          phy-mode = "rgmii-id";
+          ptp-timer = <&netc_timer>;
+      };
+    };
-- 
2.34.1


