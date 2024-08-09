Return-Path: <netdev+bounces-117218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3FB94D23E
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 16:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DD92820FA
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B952194C62;
	Fri,  9 Aug 2024 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HlUr53oy"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB3D193078;
	Fri,  9 Aug 2024 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723213951; cv=fail; b=QtpbjAc/fGIUvxErhd9jFMis8Hnp1k6j2TmpvlI7k1oKVxDTqDz/CHyTgfO44gEohc8Cqrh/sd3cfLw1+KZL5ovS9Bg9GL/d15ZU9i/eihZtuWwWnk+uafQevMAKZ/s5NGk/fM65OFib6SNujWK4k5qI+zQEj8ryMQa6LX7qiK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723213951; c=relaxed/simple;
	bh=kOJXG1KTKRXzWzc+VZfvv1FH5Q+fObLv5pxDcenAaL0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=R6CUKSBdX18Tj+ENbjHUnPNw0JGpeLkVlsYAnMODyOozVqeZQ1H81ulngFiJolT/QafzX1O+4YPkDss1aKDNJaG1kua5pEl6rVTMlSxyqSBQHof6JWgvMi1mfDUYmij0OLXvvNPFsstw2ImEedTuheleJdDSnf9tIUGLWoL1fI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HlUr53oy; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8vMV2V5xmQsIZv1+RKyhv+GSmRl8gZVIvWrF0z/2h2k6Lx1IeZa153mQLjpwoAmiTCqeob+OMNzti8tI69QjBi/hIMFktn6zUyCqjyhw3XCJj0AdhRgAuHBkQdFMDjxM3eYPmqsjoJj1sGJdz4CQWmWk/7R9BWnJZW/Q8MXPBZ7vcHES75ElIAHTp4paXkdSq1kCwJ67bxF/YqEcqHpZ3ceTrLrhDsYeJLtdlO1xYOL/feVcPERZR26rXRA+TbIMjyHVI9StY5rD+3nHF3VVY53K3N3ppTZZH6Za+CgXT7h8W/fjdddbLLFmy1LUQpk7mWYokfA4Dm/4Lfa74rbDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+tk+obv+4f80a0eJo+yVd0CTrvIfDkUOL2Il7vGIG0=;
 b=MMbzW7Y8lXsq69fR95+cvB8HBFPSaqMhNUlEGVwZ1CnQ2YuILcTWhVJwPyTXWsl0dToUdFh6degDPziALPMqXyFuTjWEbHifozKEk8wx/VJ+P/wGfzEr+XIjAxzwLtk5r7ZMgwDWSsNWpaRDhLw1bfh9ubZJXzrxXAGnOikSX5o3sfLbeQ0V0C2+7rCZlsLuzjIM1Cd57rc5dmv4KX7Jy5kwY55kd3++MHRsPkEX27JZNasZCQTybeCoCS+JRw+tSJ/s86Ef4UEzR5B5DQYe0QAVdr0dgKAkRXTkZEs6NWz0K+KRzP0fgTPR7YVkg9ianT6KOfF4XFt91G8yTKS9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+tk+obv+4f80a0eJo+yVd0CTrvIfDkUOL2Il7vGIG0=;
 b=HlUr53oyb3DSIcv1YMVkOgIs6Oi5OWuV88dr9t5fQnEJgnrhiQSrOMjK28IRJ34hf57n4w9mKJt1RXBJL3Gx1lrCSuyzSFWIMGn9qM4ryinqzY+3DLAnRg1dP4HlTnBV6jTjvid1xGIpn8drxYi774HscxTb88yBPzd0AiMG660dVZZBN0IlHCwB9j1Behy77O9Sa0es453VFkCHBx/FzwiV/pKlZTz3kxy/qvFf4OfpMDxYG41NFXrRPDpayom1lL8MeIZNATitf3kU/3VeKNOkTX/qeVWF/2q/inrg7w28X+qDsiQXwAsEGSdlgvKo/6iDQD84kNLVD5LT5t34uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 14:32:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 14:32:26 +0000
From: Frank Li <Frank.Li@nxp.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: net: convert maxim,ds26522.txt to yaml format
Date: Fri,  9 Aug 2024 10:32:06 -0400
Message-Id: <20240809143208.3447888-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1dee6e-814c-4e74-8eac-08dcb88016f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E8KJfTIFXDnwJWLlvb5wtfYnGVWH8+qInCp0j2OJxciiU7C80WaxlmGQVPPX?=
 =?us-ascii?Q?48+07vmShwX0tiLm/jSNdp9jF4zb6F97xkguPIlP1qt4GxEoEpJZq2v0uNDa?=
 =?us-ascii?Q?iTJIs5s2IanCKxMmv8jyUsH+yYBnsRVXwjWMJFaToVZNEmLM6jANaRdqyWAR?=
 =?us-ascii?Q?xkYXZ6avJdzFxg2P2BUVm7JwLn9YEoKd6xpbSK+wfR1NnOrMUnTbH/25H4WW?=
 =?us-ascii?Q?qrVOAU/2CD56H/ap1aUYBt0d0peunPW4q3NlZEdp3EWv6a8vaLufzLn4XTEI?=
 =?us-ascii?Q?ppIwnQ0Bi00itJ2pmaB9AJtfWadbt6o2/uk/jGd9L0D/YOcO2Q3EfX/xfiMI?=
 =?us-ascii?Q?wurJZchbPWpBduE7MOvbgcUdXeddOAVtuuh4eF9CuPkOZLVuzS4uEm3xn5ep?=
 =?us-ascii?Q?qM2JnRFLW8jNzltCdYLUCoYB7UNpYOyLCxZcZ0+LhPAYvT7JrU5ypUsVUOYY?=
 =?us-ascii?Q?zmG+l7/H1BrWkLuqS8avt+34lXZ5dH+s78y7pVk2EcwEffZTLHDpVGfWWeEr?=
 =?us-ascii?Q?DKkP7hKHLr8k0Ic7AKmQX747XbzmyPBXgkBF2QxTM3ytdN+5dGBo86LUJfXX?=
 =?us-ascii?Q?7MazYXrDVvDqIMa9PKSAWVDvdbUttGMakewtRRx/fADxK7FXZKSlFMj4t4cb?=
 =?us-ascii?Q?9O8lJR5H5h7wIXDetATgN442lgXnTAqnRPc0nPTad126ZQ+DARMuB/msAyvm?=
 =?us-ascii?Q?ZT57IuZ4T85CSBiKXndtaVCZT6LBWpiVWa32CrKswoANsyZ90piTSBVIlWnK?=
 =?us-ascii?Q?/+rVb8QcjrvvyeIAwZEh7nH9x+h9g32el9cj0L5lF02LLvHNaDnqUpqZADgf?=
 =?us-ascii?Q?wyqyYSSGM4jnLS+/RhmqwhTiQFiH19nbTAOC+c+prTh84oWERJii/HHbIKem?=
 =?us-ascii?Q?Bl6UKU/sArDUy3rkwOPgX51GriWNgSBYiK5t7NXoJyVYFaMOMmKTDXw/Ipka?=
 =?us-ascii?Q?k14S6N3uIHG/y59EENMlGtCQ9h+sfQwBruIJYMVRg6AZhdqejWGgjDFpQxN/?=
 =?us-ascii?Q?Ndv6J6a4Wuqhxh3dyqSbZZ4WeITGGg8oZ6LJIzqdz5gGp0cpMI7jj9rdynH0?=
 =?us-ascii?Q?R5hlKF2OkaeczwC7URqlZh85mymM09GWDVdeTFOF9AKJaM0SAic/wm1yN8S2?=
 =?us-ascii?Q?ScuDGcj/hPEvRZVElFbXg4I+h9Te4Nm/7YKOS9uGmVf6VheXZCGs2yA/pnJt?=
 =?us-ascii?Q?FFws/hQ80Jig9u7fi4OiuiRFwLgNX7kVNZxNxKMTCt9UPCejynAParC3VaRH?=
 =?us-ascii?Q?2KqYddc2yv5PRCDycNsJuh2ndad1AUD9TloYxDLzVBhBmSPpNcGnCf1KCezT?=
 =?us-ascii?Q?iDC+KaskaEsHeOc8VbY7Y/M7IrqEx6NZWvIL7ozeogSRZIBU5z8BuXRnSmlg?=
 =?us-ascii?Q?hMapljcWBwOPTYdFkOJ2fgHE3pHi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8zAZdfwSOd3mRPpab7n7nnHdt0onL7GfVA9JmX4iWChglQoroJL2Q8mGe0l1?=
 =?us-ascii?Q?cPFqQ30jQnLD3J4E5XYzggTGuEkFSgSGjF/4DSK10wWBT9WwFJ0wBOb3ac7/?=
 =?us-ascii?Q?T8r5LK+xrxbt+JFxTP6CrLw3Ztk5cKNz0b94PnY9zeHuqN5DhPXpUsBTQZA/?=
 =?us-ascii?Q?PReR6OTPPNmEfgcp2SSs8HhdjN4yM1xkjlEBhNiD6bKzeJAOfMh06nS0j3Mm?=
 =?us-ascii?Q?zMFhLB0wkvKkefkITOzqM7hrgE2Pr+wbcDekgY1RYL/VDntthdadrd5Rp2tR?=
 =?us-ascii?Q?YcUDMPUCM6CvI8cHWC3QNUZp5FD3nPcr1kQqKAFTMepM+KAc5bnHsvf4TuMT?=
 =?us-ascii?Q?oX351215v5RGtpfIxbGI55veOBythTPsn4uxKax38RzuzH07BDyylr2tLTZs?=
 =?us-ascii?Q?h0+5/nF9ndwAyR5d+97cBB5akC3HmtZ3nM3MrNlpQ2DbJ+bYeylddlRf/bQo?=
 =?us-ascii?Q?oxbXTCYv1UZE2pefeuUcgkA4z6hVHKn2zVsKEkDvFFoCrOv6PkiNkFrOoT7f?=
 =?us-ascii?Q?0UIhYjD/GRgJ2ki2kcf+GNT1NTIKvbp4aLSrbnPPBfnoGV2EAVKMclnAB/a/?=
 =?us-ascii?Q?vtm17cbM6J2Ng894raQ0A5rl3ZB5J2FcrPA4DernhZPKtDTiw1ZEWtjcgBb5?=
 =?us-ascii?Q?vK7emexCxDiCfQhZNm3B9RAB/obZ+hk51BKH107psr8Gx0vtmHPsjw3KIMCv?=
 =?us-ascii?Q?v0JuSmxZpuzatUWQwpOdecgAmhd4u1wHkBKbJo53T5rMw6BZ75kP+YxseWar?=
 =?us-ascii?Q?rB8zEeSF++pf2ANZQC6RTTsgmmDasWAioMzxW21aHy8KxbVFbUzQeczLcHqZ?=
 =?us-ascii?Q?OgTk9puO0bizBZafTGpcjYIYt1lN/04fsIqAnO/h8oK1p47i5aMCj3tAJ+fW?=
 =?us-ascii?Q?EGBSaJM4BI0s/pdwvTjzzw5I4tk7XuhuowJZaxEHOQka0Gq9KHm7aCCD1jNP?=
 =?us-ascii?Q?yL2rlJqIxgsYwbgydYDvc2i4mCO8f5ZS0p2V9n5/1TCwK+270cPFS1MeL85l?=
 =?us-ascii?Q?ZOnWw7a1G62zlFMERVg7vyrC/gsXKLAymo8L+Zk8fio5fN/daodUPSMAVDVy?=
 =?us-ascii?Q?JczG6sKynrXOoZWom24yNBSJqq+TMLYBlJl/IF5cowbhsxrgxBp2XHQkvYR0?=
 =?us-ascii?Q?WG0F9DDLBGqpbW7ZStEoxLmBrz+5RV4bQR/ivnPcf1EUzSJjFUQEUyIk6CNE?=
 =?us-ascii?Q?7HCCDAmv50EE92BcpiAUO8Imj58YteZ9cVS3JzNbEeviN2fL2zhg7JuRiM5I?=
 =?us-ascii?Q?5o4A5egzVbCAfYXuPiemmDv6udcwnsUtB7jxVKtTjBPHNhZssOZP+Y6SUywt?=
 =?us-ascii?Q?FLfUt6UJmBPbnGxDE+VMhKMPLn7SnyE9CVflOjdakp7EV24kjt2844TjPAV0?=
 =?us-ascii?Q?VfhE+HkVCz+81XTApQG7lFU5aOgNpR1ICs/kqjUxjD1EIZEosEjIB0uS02N2?=
 =?us-ascii?Q?sOK2nB6CXFHBVUuoCHzoLpuKYReqjcRommzdML6X+HrMHisF4T9lS8TUDKUI?=
 =?us-ascii?Q?1upnwGwkEQhBF2OWUKU4iPrq3P8O4UsIhkuYca2DWnRwtC+uh9KWLYC9noH4?=
 =?us-ascii?Q?QnewK86ll2lqqeD82n6iTVR6HjCoD6QOTs/AanLH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1dee6e-814c-4e74-8eac-08dcb88016f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 14:32:26.1804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXscWnxnEvfXXvUFb6F4jKgT69hzAUMhesESgyIZvgQHR00Gzm/wasWlRYAiCuLf1OcMRVXS7z2tRqwVYfINBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9284

Convert binding doc maxim,ds26522.txt to yaml format.
Additional changes
- Remove spi-max-frequency because ref to
/schemas/spi/spi-peripheral-props.yaml
- Add address-cells and size-cells in example

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: /soc/spi@2100000/slic@2: failed to match any schema with compatible: ['maxim,ds26522']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/net/maxim,ds26522.txt | 13 ------
 .../bindings/net/maxim,ds26522.yaml           | 40 +++++++++++++++++++
 2 files changed, 40 insertions(+), 13 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/maxim,ds26522.txt
 create mode 100644 Documentation/devicetree/bindings/net/maxim,ds26522.yaml

diff --git a/Documentation/devicetree/bindings/net/maxim,ds26522.txt b/Documentation/devicetree/bindings/net/maxim,ds26522.txt
deleted file mode 100644
index ee8bb725f245a..0000000000000
--- a/Documentation/devicetree/bindings/net/maxim,ds26522.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-* Maxim (Dallas) DS26522 Dual T1/E1/J1 Transceiver
-
-Required properties:
-- compatible: Should contain "maxim,ds26522".
-- reg: SPI CS.
-- spi-max-frequency: SPI clock.
-
-Example:
-	slic@1 {
-		compatible = "maxim,ds26522";
-		reg = <1>;
-		spi-max-frequency = <2000000>; /* input clock */
-	};
diff --git a/Documentation/devicetree/bindings/net/maxim,ds26522.yaml b/Documentation/devicetree/bindings/net/maxim,ds26522.yaml
new file mode 100644
index 0000000000000..6c97eda217e83
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/maxim,ds26522.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/maxim,ds26522.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim (Dallas) DS26522 Dual T1/E1/J1 Transceiver
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - const: maxim,ds26522
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        transceiver@1 {
+            compatible = "maxim,ds26522";
+            reg = <1>;
+            spi-max-frequency = <2000000>; /* input clock */
+        };
+    };
-- 
2.34.1


