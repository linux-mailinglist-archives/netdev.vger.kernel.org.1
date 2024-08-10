Return-Path: <netdev+bounces-117417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B1F94DD5A
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 16:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817A51C209DB
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 14:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E9015FCEA;
	Sat, 10 Aug 2024 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ltdMf+k+"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6184157E99;
	Sat, 10 Aug 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723301614; cv=fail; b=Tvy9yvfDz/tL3ste0Jxfl25GpDlFYSGTHsLdjReAxQn+ghSAP3PgixMOGJvU96A12Wra858Wds3UCxoY3dTN3pqohdYmAVL/YiU7yM6up4J7W1tiBvRZMYCFwEhtTSUYsoA77Lk4nJFoD0Up/WHt1dpM4pvTO0ASKza1lgx4QnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723301614; c=relaxed/simple;
	bh=vV3rgt5NFwvYxHIvwPpI5t80pGlLlVXEo5bSEvIJdjg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=S5psT8fyodMyqwYnYVAWUVzJJ2waTCd0ICmk8pxamJLQscTaQJKqqGfXujMJMg357fxgq2ewYjVtBCas42ci8LPEW4naq4gXDhQWxTwT9mFxLsmb/GUWcM0s1siU4OuANfEijT28xnECBIySesRsPGVim4Pvk1E3HKmfQfwwmBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ltdMf+k+; arc=fail smtp.client-ip=40.107.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvtvyQrV3UH5Z5PBLXOm1CILzqAQcfqHZmM5FZ+twoIQYSdmShLmAjGdpdEf+DJ8ZkVKwIqAmgRi613mSsrECV3KBy5yTVkcI/dk+SH8+TK/lf6y+ms/MuSahla9SxDpeJXF2FkcDfAaa82QyLxODsR22PdgENSUfdLNTYTmz1Tin9UIMkyk/IDKRFJIXAif/v2NZyX1lTC9KNP0JT010deI76pzji6fFQENIMwn6Nx6dtzUJj3Yl5BqA3ElrgH0d07abt5dMCE6oyCHQDaPZHamgaTtMXDZGBq32uZVgvjJTEBjIVDRIwFLGf8mmKaAReSKcHdO7yhtVEXfx8jLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=810fA39cTeCv/nlWjdhCXXcuBDtgf97bRph0LdBMadA=;
 b=IW8uTZ9CYwfIpKhIWNAGCjJnXEk7lZ3NnvTx+Vucm4j00QJFSQFR3ZTWct8JA8u2XJv1wQGnRQP3mFdCbC9i8fhB0afPgDto3hFAvcnZ5t99bxc+gYDBiY99LIPm4XhxzEO8iLbQDjfkx6ZwE+sbzi/8BVOU9EcZCQSdqG+WJYCW4rOzH2UbQwFDnPvceSvuv/sSieTnTuSrZghzgP9MkYwkh1JcgBbuhpbpgjlFuLzz3YIJoAoNk5cVAuNSIUGI2kDfn20wyPfeciZpf/NZtiVSU7SfvBXhl+sDTgknKTMBgyMA9C/VJR+8dEowfBPc82vt51ag49OP2H5JO6KdnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=810fA39cTeCv/nlWjdhCXXcuBDtgf97bRph0LdBMadA=;
 b=ltdMf+k+XeRDYUgc17pH9XvJf+y87TXXpAae0dDFsgs/zKHXMnFNqpo7331buWNI2+8zWWacke2UY3JwlXJT8BxjECfkrFDg/7mxwS9SEKhoEIO6WNlc000zut96TPWlBk8myE8X/evBtNb+M2zrJinGQ9zsSDjZrJ9LHlF6CZGuzPQks9mhk7CFIKn3gSVsZRmMkgyKO3qTRsoZTTZFWBFmXRGpd8XMSIVopjOMD4dNACIfE+DWAErxr6aFJbDc7eZf/Miax82K4Cfir7N/6nV7qPQ290+gdz4Vo8j/pAKSvN9JYJ28VV6/yt+RBcqY5weNue0PfzIewLgjaGz6/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8379.eurprd04.prod.outlook.com (2603:10a6:10:241::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Sat, 10 Aug
 2024 14:53:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 14:53:27 +0000
From: Frank Li <Frank.Li@nxp.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-bindings: net: fsl,qoriq-mc-dpmac: using unevaluatedProperties
Date: Sat, 10 Aug 2024 10:52:57 -0400
Message-Id: <20240810145257.3617413-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0062.prod.exchangelabs.com (2603:10b6:a03:94::39)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8379:EE_
X-MS-Office365-Filtering-Correlation-Id: 632c004d-f9bf-4049-487e-08dcb94c3110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JAG6j0Senhybjc5bFVrvAw28UEc4YldkvE2WHO1KOKXX3sNbC/V9uVfVY+Kc?=
 =?us-ascii?Q?e+HVMsmD1n8vH8NbPsVE9Wm6H7tnKmMB+UmABcS8NzgyMmvN3yKqIAmlrvyg?=
 =?us-ascii?Q?fKwYPtsZpLXjlrPmOfkKMI1xAjingi/kqOHsLdpTkXVQgdLcJg6jMhxJBduO?=
 =?us-ascii?Q?9vqC9yhAjd0NyxzMDW6/KG25CJiePWUNcjHVWj7ob8wfvQpeE0gW9YsW/SbK?=
 =?us-ascii?Q?E4xcCohu0OCT4Qycu2MJURMwKUB1RqfI2DpGKkb7/yt87lcKF+BhQmgKESHC?=
 =?us-ascii?Q?C44tXaN/peqWqTtWfQDPah4zKteQFuTSuIyrYB2NBpDDA5j4ZJhMHbV5nxui?=
 =?us-ascii?Q?pY5AvnwQGMUrQx3vFtGuO6+YF9qhEQO+ivB4hkUMeZhSn/h2S3KrJPCoEbm4?=
 =?us-ascii?Q?ACXG+7/169qcu7rUjonQgmwwCf5GImfdQ44NMkFknqJWUROnnknRfSdQLkiD?=
 =?us-ascii?Q?AVog31zTrpG10YlWaoJU1zXSeAlcPbp3iRvKMlgwKYNOUgSedcqpWRAj33Oo?=
 =?us-ascii?Q?MkvDAC11Q3YJ8wkgEUNjdZvWi4uXzhZFYkhwqsieJjxW2JakB9A/08hrm3FA?=
 =?us-ascii?Q?raQoNriETkrCw2OpEnI+7jvCwcVGrFvxpeOENPzJag+TTNBjmHL4YtNpcjUN?=
 =?us-ascii?Q?993L/J5RB7ukb1/G3NGVYRk/gJKc1PPt6bM5+uWkYims3hciPqNYp4veSDq6?=
 =?us-ascii?Q?JJBsXBNHitIYkC2j/8gPsy4UNdNmSs69eGeQxEEPT62wrDgUivK57AySnB7L?=
 =?us-ascii?Q?+ezZVn16h89boN85PD3JgHVUdJEQw1NAoOe4fLJQ8t9I4N7ylU2wh3oMIZ/Y?=
 =?us-ascii?Q?rsOe4KMD0x+3wTwfgchIuE0/YwJXIm+ZobHC59CylBb4065zZysiwWC37qJ7?=
 =?us-ascii?Q?YmCFhOnmZfd1Nhz8JvrMzfzBaP3FJd5n3IVVDpDl8I93qSHYCc2Y0UemINGf?=
 =?us-ascii?Q?b1RXUO2e4W95EsRK8mRtKuNy97fYtWCaNl2mOee2YRDuVmTvFRPpbfSIznf0?=
 =?us-ascii?Q?F4heh+n0BUSR1dU5NWNZO+d10f/d29lMlEWoS0AGI/4Hc/UV+rU1QI5/VCSB?=
 =?us-ascii?Q?2YxlQEE9qpwO0LYlrdcQBBIN9hii3+onVZtFBN6czamX/ysjSKgunRlxGtWO?=
 =?us-ascii?Q?EqK2ndeSUk/TBMRPJCFL+vUIsRsBhqx4yEZQd1p3u9WyPIDIi1uKO5VuJmHA?=
 =?us-ascii?Q?9uPHmb0Qb2BuIFj2qTArekBLpCN0zW1gNrKdDNrMjzxtPgUB0zVMLAZHPQvC?=
 =?us-ascii?Q?VHDSzjmsvLQMX59jMLciR7cLm+7THBsY1cpIahtPktDi4eVVj2Z/v6EzKq5h?=
 =?us-ascii?Q?mZ3tOweD3Ajs20oo3iuU4w1qnGysDQjLLgc88uDOH2YdGpy5UR1Lxc1ssBUh?=
 =?us-ascii?Q?eVsQ8LnVo/KxaeGd56so84pzF/wM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xaItijn6FY4/ihLYDDDZbP3QNIh0asnoHDpte67r2qjUowXYNy3MR6OqKLze?=
 =?us-ascii?Q?E0lgZrESEstH2LbIt+6EbB8XGYX3V5ETm7B4H4Db4rXr2oKujeOfBqeDuBiK?=
 =?us-ascii?Q?76n37oGX/eEcIeMjMS6br2Ls0Ek8DIdg69MYnW4Ud1iqt+e2hhpp+wCXRxti?=
 =?us-ascii?Q?KGYrDIBVZF+JyLu3vPVzunbX5Lj5BRaysed6gpsTWiWqTAdq2g0iLk9/an0v?=
 =?us-ascii?Q?6FMjVELd+Htl4cd+OdtJk1AdmoWcnZQ+DED30rq7ou2LCw00NPHF/+z+7VY8?=
 =?us-ascii?Q?tanaPeF0PC2Kp3TONzNpZZcO9EFSbdwB0GC2Y7Inw5IAauQ5Qtzl2729ue2d?=
 =?us-ascii?Q?T1IZDCIt7BbPCIXCP+NUzi+a5wEdCXs7Dd2uibwynxG90pF/o+wN6c1KZmd5?=
 =?us-ascii?Q?Ss+tCsKXVbsHV63zDG7OG/taZ8xs08sJRF7mvYO8JQOaZI/KQdGqKo3EgBpe?=
 =?us-ascii?Q?Uo39s8+o1DihvysV1yWZmpcImpbCgrmhE8fhEN/7Sszog4Xa7EY1iiXx7kCP?=
 =?us-ascii?Q?day8bqoS8XSNp2dfWfcWIT0xGx5vSXHGN3w74qxM027xp3kureMkBiBaSYCn?=
 =?us-ascii?Q?Z98AWIerPxGgK2R1C/2oZr1/pF/fbvd3OpSPMS5JXrYZreQZMslPsIZlLG66?=
 =?us-ascii?Q?vUJe6IqVEUmkMRne6qdh4YcWT7+ybznzKh1OLTpPiHz75Mi+Cx1xz7X/0clW?=
 =?us-ascii?Q?DxBUKkGCX0IGs6yZW2yYajL3ovY88wjPD3X1qXtnHLgUz7U9xmKBHOzre0qN?=
 =?us-ascii?Q?pJMn9lN+1BYLHrFfN8jFyCbqRzkrojlasvYxIn0Xf48E7/G5kz8JlZiVh8hr?=
 =?us-ascii?Q?d2V7zzOEjpfl2b83p+Omp0UEyi/XeKaO0jSfvuI1B0wEQ2XBEdHoiRTY3yRJ?=
 =?us-ascii?Q?D0Z08gJU957VoR+y5+ntAkrgzZGSA2xZHk0NSIsVLxW+hKdezgcYzDY2OKWL?=
 =?us-ascii?Q?3P/q7w145gAMD+SdafxWK6c90lCtz59H2UOkgRWHATaCi+3VyRCbVYuGrnpe?=
 =?us-ascii?Q?F7vTh4mVNRii/p7dQ4bD3MHyw+ch2ARBo+0h5mWOGg9dIf64n04hWXFCTti5?=
 =?us-ascii?Q?Krodo7/gT17l04na/4v8sTHLX3+Dt5RUY2y9nlePrpFbvp7dVOlDgctGRo2n?=
 =?us-ascii?Q?5l7LkR3i6B2uqYgmTKTHTnJRlSh33ng1yM4ARo8SjhPAQPtfrgTa5UsHIGw1?=
 =?us-ascii?Q?batIQSbc4Lujr3+rbyBck/vqCuFJuI+QxVyZaNKISmD8A2lo6x7KKcAqQ3Vg?=
 =?us-ascii?Q?xT8kFO0T18jGk6SwAIk85QZSBDrcFFqWW1GIPdyNE4WzU/vUiXWaIpgWLNYM?=
 =?us-ascii?Q?KhjgQRvVg4P4AYO44SWsyVvPvPNoi5mEbs8B0feHktMuwiMSEuO7aQGlpPTK?=
 =?us-ascii?Q?JePRv/8KwoFT6jDDPL/wbKppbAVtlLbuejVePiX//c4HsrvME9jCoBgPOPSf?=
 =?us-ascii?Q?39DyoG2+ejXjq97bm+wr0Czac1oUoFbtTo8B1UkTGE6wu2d6lglsetb8nroh?=
 =?us-ascii?Q?PYh1viCSVOwKUXq5E4v00BqLtYEZ64hpIpDle6TMLUozLo1Ox4AFXChMwHiP?=
 =?us-ascii?Q?EMIiPTfNHi+0smzlMZ8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632c004d-f9bf-4049-487e-08dcb94c3110
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 14:53:27.2998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OMZO6nh3PDwSfg9gNyqzHwId+M29kN1Bj0unZHxg0SGA5M/zMwYburPsKPCL5If5KiUVRhtKlQalhD5ZvKHqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8379

Replace additionalProperties with unevaluatedProperties because it have
allOf: $ref: ethernet-controller.yaml#.

Remove all properties, which already defined in ethernet-controller.yaml.

Fixed below CHECK_DTBS warnings:
arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb:
   fsl-mc@80c000000: dpmacs:ethernet@11: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- Remove properties, which already defined in ethernet-controller.yaml
---
 .../bindings/net/fsl,qoriq-mc-dpmac.yaml         | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
index a1b71b35319e7..0a91d839382d0 100644
--- a/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
@@ -24,24 +24,10 @@ properties:
     maxItems: 1
     description: The DPMAC number
 
-  phy-handle: true
-
-  phy-connection-type: true
-
-  phy-mode: true
-
-  pcs-handle:
-    maxItems: 1
-    description:
-      A reference to a node representing a PCS PHY device found on
-      the internal MDIO bus.
-
-  managed: true
-
 required:
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1


