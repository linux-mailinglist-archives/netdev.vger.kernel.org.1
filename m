Return-Path: <netdev+bounces-118630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F34952435
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 22:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1F41F288C2
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 20:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C88A1C4633;
	Wed, 14 Aug 2024 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QsxI+6ij"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF991210FB;
	Wed, 14 Aug 2024 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668402; cv=fail; b=H4dDy1SLAltUf7Zh6JDZMTIONzFTB0fAnPqUwRQ5sW+gqVG0XPARo4CPh5A6I/c74nB+EL76dPzgB2HQlOYzZ3QvddCHBwzsBHKSznIS4Ztebk0rSA1w4wF+hLloxDVTyJJob9xiOfM9s9y2s5i0Fj7oDf/m/aREW0gg0m0Nz0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668402; c=relaxed/simple;
	bh=hJnZnHBXVQmK06k0U8wzJ6NX1rH/Rr4kZqSxRidD9fc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=n5Xhy4Inz7RT2tQPpTH1YGee5ZlKS35AhGRin2S8JeznNd+fpMY2lRjJHKfo6NmjIiSb+5mVizJeOdSv7CQAZt7EFr14dMxnSRefA9m9G8MhiyWWnyZ6uAB1t0r06CebP4zVN7aLbgagltVFmWKblfDnr2j/AO4jHoN5YQIJFl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QsxI+6ij; arc=fail smtp.client-ip=40.107.22.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCWqp7f7O4oCg/zPl68xB9fO80b3jdaDTEgyOHmoTaBvPWSs8LttZTsmsXwHOblHC251tGtTl5aCNXwQ2oZZE6cvsU6pGarU0Jae6K9d+ARHnDd4jlW23iEZXMjEHv1KYYmfZJKFNR/wZiPQsujB68QRv7akD2lE9RYioKJww+SZoar9mOar65BWpUIlY57G7sfp9AP7sU56jlqBJx0FZs7SDvbtaxMJ18r8KdE5i+hyddSEa3GYQ6lKmIty6l2DmXCPMamSVGHevXbAs33b+V0tZ6vgtkfX9I8PT9HTOWI+ggVofuEH3svLNYDYVknlXDE95kXFnuGohbCK9G1u+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDxdOnbiDPQ55SL3ikDy1a7FboOyHIkQiUxGzih1moY=;
 b=BQAwb6fObD/wLUv+hMo0Wb99YQiX0rLW8LsI+ttamNUHxLPetGqBBC3YvPkSjiNdINlG2k8R++AOAfKHRpCrjZKg+NVLX0I7hYbQ9uIlYvlTp8ElAof2KOCpUTEWcLKH8OcjGhBcWfnT9DXxTuNyltp//zpiIw4Hcz2Dt/UbEg/czM5uNZJuLdYmgUMYC9Pr4rdMA1ljtfprtARn8Ohem7rBvYKY1rRMjQ/ZSVl4fqcekk8xkwQrWGu99uPhpHvY8APreoSLV/YmN9Qh5gDcgX34jdQPIO0C6YTg7Ha0Yxke9MaJfgKKBi6FIT2mPAODOUUfM5Og4klv7PsDHTKRrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDxdOnbiDPQ55SL3ikDy1a7FboOyHIkQiUxGzih1moY=;
 b=QsxI+6ijYlkMs4Ee5P5vQh4cffFPwuANul+mYnzgtmeDjWcya+++K1soQDp+iBljZV2h1dFI2KIxWJpXA87M1/1SIOhhVGXxF5/A+oSemkvb982Bpk/hqmebhAcD0uBoy2A80/E4Ca03FfiSxkXlSUr4NSenLJUylQe8iRsKIhgA0ZRUUsmQ4Na/+49D15SBz6pd4E02XFHXtYW4wtiTE5cfjrZOQ0tE5iZd5QETRuiX/QjqSpVhjYTMHtIcqiKx8PBJq9X25dynupJOjiA4toH2CWfgNlfAViT3OC8hblWdasDC5s5kKE2injEK1iGvu0+jfqqVZ7ZQgJZtXnTmlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7288.eurprd04.prod.outlook.com (2603:10a6:10:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Wed, 14 Aug
 2024 20:46:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 20:46:35 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Yangbo Lu <yangbo.lu@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org (open list:FREESCALE QORIQ PTP CLOCK DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-binding: ptp: fsl,ptp: add pci1957,ee02 compatible string for fsl,enetc-ptp
Date: Wed, 14 Aug 2024 16:46:18 -0400
Message-Id: <20240814204619.4045222-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eab749d-d27b-4a72-d22a-08dcbca22f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zEpVJ8VJE6xsiY+DI+LDWoTFSwI5pcvpEjCz9OfcZPYIWXap8JAlWyMSsSPb?=
 =?us-ascii?Q?5n807AxImnRCKhQRtm4+9txvvSIRtkptTirUJHP7kcdWQYYXww5oRfiq6foG?=
 =?us-ascii?Q?PcyvhPp1BHKxbVdkT+WJ8OIlk3yH8IZEDr8M6pG12puxo8us+9YVmun41xT7?=
 =?us-ascii?Q?H6L6pW3EJA38fPAYxnFiHuQ4z25PZYmKk4ROIsxpnAN0SCZBkSETofeBLIVA?=
 =?us-ascii?Q?IGwg2pcHlqmzVZJ4hO9UVqC92F1ZJkD/oAP2JWmhTVI6Utov3tYT3YaXZn09?=
 =?us-ascii?Q?z2m+BTsWFJbFl/fZ1Iu9VjojrHDYtnAU6ZKyw6C6fDakmaPGcxcOHy25+shk?=
 =?us-ascii?Q?MgE+SbMGJO07tQktKJkmfMZ544NsU4uOCzrgU6TSvKOhI88BDIFi2EmrhXAM?=
 =?us-ascii?Q?bifUEueHXOADD5XSnpIwavenBIKs+6eoyQM3LpevQ6+N3W0ovWvKLn0TFmxk?=
 =?us-ascii?Q?cHnkSVlrrZUrhKtLMDYAgUt63B95saO1nnhve4awiUKveZifhWMFIhA1asoN?=
 =?us-ascii?Q?79r18guyVzezYOJcDzBte6IYZ7B19KDDjalbvE/MVmfbuefSriR76JUKB89Q?=
 =?us-ascii?Q?KeaPhVxbOSrCi28ycd+ub9YGT/Ga0TAszcB13JBLyePH1kgt3t9yc7s+MzHn?=
 =?us-ascii?Q?Bt7EXhA9FVT2xDo6sj209UvWAF/SNGTS+xEwUw7zX0S5pEgD7FO+vf5OGvfw?=
 =?us-ascii?Q?DdaGNTO1DE9SdYQDoZ3V7cJpfSRU+u+pilQQJXbqNcEWU9P+MZBin36oRh9r?=
 =?us-ascii?Q?gK58p7+hIUkwl6UCwqoOi2gqdvOIq8ZzJFC3jCGqPgGzkXRjFMbTpJNVhQre?=
 =?us-ascii?Q?LLokQ6ruwzZ6k+a2VK+nCCsDie3KZOT3f+rH1CBhPiBqRTTeZogoX6xXnT95?=
 =?us-ascii?Q?r8HBsTEqXg0j7VVL5zjht91iMYaLJsgbe0CwrZAv0faWHYAjiJszkytrIAR1?=
 =?us-ascii?Q?lp9sbKZkScXCtf1AGoM3sN+yYrZSLB+QzVfMwHRNIjipaTGLGzGOePCCUIYr?=
 =?us-ascii?Q?v2teKvPvnZCVQN+80PTTi/aDE8rINs2zMO6fFGD1zqNESgvwicsU/nHEmIId?=
 =?us-ascii?Q?OxvyHQQom5WaqVLHfxhJAplnH4+Ul79HWQKfyIKQqZgPtCBgVOD8BbktVUqA?=
 =?us-ascii?Q?7B0+lgMQjcQuG/nmy1Gey1YcUZNRIlw2goiA1z6rQiUESu4K8keCEPgcVt10?=
 =?us-ascii?Q?MF0/oYDsUH1TVvXBGQIfIDncpetsBw+N16HXDVFN2SD+RBPSockP1YEMx3nC?=
 =?us-ascii?Q?ak5Xf/JA54l0MT3o2IpI05Gerzqhu24XhW/gBmIAECsOlzlQFzefl6zSHeQB?=
 =?us-ascii?Q?Xt3Tw32li8hrSGs9PROfYcxukMgQYYBjYGiXZzhEdqWC0kr5FwTcjKA+I+2F?=
 =?us-ascii?Q?XW3Y7hohnzwyb0V8UKXVAf5B4S/b0SFFQAPiQLBwxRvSmjg+hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TA1aw2v6w3kBXiiUhMmjbOTvNSjYF//BfdJf7kN7Xuhe44I1Bn74SJ567CoQ?=
 =?us-ascii?Q?22hqua8832vvOUmeMTrSZhtIp4xFEERDIqsCcyqeq8ffW+JIVhJlQD0zells?=
 =?us-ascii?Q?CDL2Z4WkamAIfdek6EMyunoNhh6uhLw4F6Q1A4sZE3VAmjlo4lsk0f/W4M+o?=
 =?us-ascii?Q?1Fea2AksDVDRpZyHUkN3+sAKsaMTCFFImlZdNjHW4JKKHcoxYmCd+ZNz8UXH?=
 =?us-ascii?Q?/YadU8AnnPyHrEnuNOIAiHx8XmZTMIIfD9EVCgs9Y+F75OqxcgNKOz910SoA?=
 =?us-ascii?Q?wNmPF4rWLLjh+k8+c0xvipuO1N9mb3SO8bWfNvOivOJ5y0hbIwqihUU39R6w?=
 =?us-ascii?Q?rTNXXfVCOzHyOSjru3w0PvegYE0k66M9di3BcoYjByMbfhb7IM4QFA+nIkMx?=
 =?us-ascii?Q?1ZyY9LaSoq5KIDVzOXlKszx2npoMlE1sLocRp0A/N59c2uOEw2zSYtkErSPe?=
 =?us-ascii?Q?UC2FDW8bop+Q3dWyLJxQqNGBCYa3VLY5DVNva1flOvkWM28b8pqh7o2IPBQA?=
 =?us-ascii?Q?/vJZD7qvadHhT/XtvXs9rbdS2KYnKUw9EnBMsGdPyKuWFI/BpNTBWYS6hxzv?=
 =?us-ascii?Q?iCKGkZ+DZg0z9uqaC2SHJq2ywDrGdD9cVsyouQGVwH2HSiiFlRy/eeZVvR6c?=
 =?us-ascii?Q?IQJaMFMrVZehGU4VGCnMbXTnIKg0s1FQD9q9QzmAY+GjJHmc+4yfd/gXHNQ4?=
 =?us-ascii?Q?H5ChzTzdj5/1CD0VHTgnmLRLvcDSLLaDs7aeDCOTnr+Zp3oL1suY7H7QwC55?=
 =?us-ascii?Q?pOLc71mfg9Jxx4ocxs7y41AxHOMgLJBZUOSIk7rMiECgaqZu+bAJO4FeAOvn?=
 =?us-ascii?Q?DJ+n8yrMz4OZLrAHok6OIA5SzVPqVLkYS6znhp6mWiLMEeHpMpgjXyoE3CdQ?=
 =?us-ascii?Q?GvgbG7BzG2OZOtj8wjln+QA1cOMnj3GsP6BoHMmOSyKpwpjPj9UH26gji2c+?=
 =?us-ascii?Q?0tblqgk2p41fHWrLXu7tQvKpVYqhb5tUXsZv42DoRcn+utIMUUOdGtWk7H9J?=
 =?us-ascii?Q?LRTtVyWWwivBtTbLk3VA4/4bUX88yDSRXNIkaWOf1hyzzpIFCtIfbxs6vWGt?=
 =?us-ascii?Q?jzxJyO1VuCsSz2ftESmLk8BnquU4AFQ0hM1JG25WvVO+doqB+ZwyFJDNxOd+?=
 =?us-ascii?Q?hIYRT7VPBWic5hvu4H0y23WNxM3Xvk/GsS9CbA/IqmvAx23Qm6HbUHs5qWJE?=
 =?us-ascii?Q?ReqeIprq4uWeSQ0OSdO22tQV41edbGBztCcK/+6LgwcPoZK5ilxTH3JFFqjt?=
 =?us-ascii?Q?TADf1sK3nCgcipW5B2yX3gxJSrqR1lElXwnfUEyz8cKlU2l2s/gmwYfBnZoF?=
 =?us-ascii?Q?HNjBmmgEAKfeIVtQSA60+MxLG3nsaqhodrdAyTwZvb10FWU2LRqiVSkT23vq?=
 =?us-ascii?Q?vy16YbtvsvDv62oQWDj0S86H/5EgTb9ONZsJ/P0QFf+fbKRbQEdC2NYT65JE?=
 =?us-ascii?Q?xNWJPii3bSiOwogAChffrr5JvH/fnUJ9PT69SEdz+p2Q6hhKoCCpAJUV5O54?=
 =?us-ascii?Q?iwaI0tfh8BTlE4fkEtSof7a1vhBYADjoo6sSVrueV5GX7xoQQf69h+IjKFLw?=
 =?us-ascii?Q?aMx9+Q3uTEExU/EnBGk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eab749d-d27b-4a72-d22a-08dcbca22f9d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 20:46:35.0781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CHhdm8PYv603BOPeXJTybSVhXMKt0/qJFQRNSZYwhp2ayLPzbammobRmHchkxUF6OSw2gvitsTSO/gzebRDrjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7288

fsl,enetc-ptp is embedded pcie device. Add compatible string pci1957,ee02.

Fix warning:
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: ethernet@0,4:
	compatible:0: 'pci1957,ee02' is not one of ['fsl,etsec-ptp', 'fsl,fman-ptp-timer', 'fsl,dpaa2-ptp', 'fsl,enetc-ptp']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/ptp/fsl,ptp.yaml      | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/ptp/fsl,ptp.yaml b/Documentation/devicetree/bindings/ptp/fsl,ptp.yaml
index 3bb8615e3e919..42ca895f3c4eb 100644
--- a/Documentation/devicetree/bindings/ptp/fsl,ptp.yaml
+++ b/Documentation/devicetree/bindings/ptp/fsl,ptp.yaml
@@ -11,11 +11,14 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,etsec-ptp
-      - fsl,fman-ptp-timer
-      - fsl,dpaa2-ptp
-      - fsl,enetc-ptp
+    oneOf:
+      - enum:
+          - fsl,etsec-ptp
+          - fsl,fman-ptp-timer
+          - fsl,dpaa2-ptp
+      - items:
+          - const: pci1957,ee02
+          - const: fsl,enetc-ptp
 
   reg:
     maxItems: 1
@@ -123,6 +126,15 @@ required:
   - compatible
   - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,enetc-ptp
+    then:
+      $ref: /schemas/pci/pci-device.yaml
+
 additionalProperties: false
 
 examples:
-- 
2.34.1


