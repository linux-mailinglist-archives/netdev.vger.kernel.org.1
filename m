Return-Path: <netdev+bounces-110433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5681892C5B4
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 23:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFCB7B219D7
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 21:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4044C185612;
	Tue,  9 Jul 2024 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TlFD/ngm"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013025.outbound.protection.outlook.com [52.101.67.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B614374C;
	Tue,  9 Jul 2024 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720561746; cv=fail; b=ZqReI2S+8/m7pC02o+xXQbkVp5CWti3sMYunzSDFT1zBEqjRY+nmTHwNv+ypU+1c0738NJcQI7VuEScxnysqCgVH610nAu94Aa/W1vx6GyatOAmeHS19L7amiimwNlJd6WmQO+NvufES1kK57egOFHqovPGBvDSeh/SMNvi/mQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720561746; c=relaxed/simple;
	bh=E/XMdZWE9aJ+A27IUhYbLIkDpEgCB+yfa8KFaalHCTE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sKYXTIU9XRWyjToxf4VyL3L8e8aIysvbSE3DWu5SULrWQtXjg0EdOmhx2Ean/oqjiEfqJIB+rem2W8J8N6YLhNahYBvnUBn4+Vr08mGCbk64P/hrfCWeirOEE1ZCVj9yea6wIk7H4xwPYk1OoBr00lLMjIF1D3/TnmhAAE1cm9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TlFD/ngm; arc=fail smtp.client-ip=52.101.67.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRg0CCMxNfJ8KfNLckM70dey1OJe5/6iSfilAdc7IqRdd++ZBCuo70nX0GuRyJi6ngIwFh/gmdZtffZ0F2mFZCiRJsPLkNMc8Gkpuf4ItB1vja6otsoUaYnFzm+msRKqLCHO8PK0/fgBNWwgBCjq87PZSF4JnQzzAjaz6aHbQHC5zaVsjx5IYPGfab3kpV3jdDWMazbZXoD7MLLNqWw5o0TtWrOp0XDAm7GQyZI0xTeyMltDsMictzCZQ/n8crxJ1kEMtSMOT1uwT4diikT6kz5F35k4BgfiP65xMq7Eqt9YLSYfSf1IVleMzjeC0ojYwELT54piaCut2jsmNGHxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePr9Qg+GpTnLb5HwdTn/liJiQ+K/eMCpO/f7QPu9zfs=;
 b=eB8xuM0URyTSAj+Rh9bL/+58AzVySRE4o/xBpew4bohFfsD8JqD0sjcHD3Qdyk+M2G2FfA30upqLCsKvpoCpkc6pob9SH7/BWzKN72AUpxZCgTWyVMZ6xG8Qx3wW3cB54ggDo79yNIxGPoZGUdjDbQZeJ4Cq/SmduheYi8HdJtJNSVHgC5DfQA+FQypolO6uvWMJdqaBuEFajUyVmysvInQDnFvguK6kkKel09+g/3XVrNtdndNouRtVQdSPeMI329XS017rPJbO0jfL1iJySDNUUujebJ0OLMkXSwIKS6RbnCVyLB8acQlxxqZggSiuQvR5d9UuTKKVf2e1xeoytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePr9Qg+GpTnLb5HwdTn/liJiQ+K/eMCpO/f7QPu9zfs=;
 b=TlFD/ngmVNGTEfJt4crm8aT25CdBhRa4rj1XUDL1ubVPSpqsApyYKtWPmG5+XefsCnGv7VZKNutxskLJ20sw9c2ycwfgiTU7vS8bs5LYLnN+77DXIOVUeSUu/1WIRuxNEvG/DGHLZOSm1iemLdzXUlnumjVEh6G568EVzL3mJp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7391.eurprd04.prod.outlook.com (2603:10a6:800:1b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 21:48:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 21:48:58 +0000
From: Frank Li <Frank.Li@nxp.com>
To: robh@kernel.org
Cc: Frank.li@nxp.com,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	krzk@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH v3 1/1] dt-bindings: net: convert enetc to yaml
Date: Tue,  9 Jul 2024 17:48:41 -0400
Message-Id: <20240709214841.570154-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0198.namprd05.prod.outlook.com
 (2603:10b6:a03:330::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7391:EE_
X-MS-Office365-Filtering-Correlation-Id: b3461e8e-7f98-4334-c83e-08dca060efe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EFjQObO1L1WojZWNeHKq1rTU1mHPEyOJoFDCq3kWhWAL/dfgPutAeoRi79v4?=
 =?us-ascii?Q?o0dl6iZm65l2KcUEukydDFvcFqTt6bR5Mdtv1mnKNrU+BT1ikSP4gmycOrUd?=
 =?us-ascii?Q?x8aDEeeKLgzBBnCPm4Iho0pPJu7BzF3fWRAqquL6cfvXj7WsxzD7LLuapdUu?=
 =?us-ascii?Q?QQrBY4De3UqyLrO0g918S11CKK8+OWXrXTKBVS1cZ8L8+XFnW+XFs6MnX4Uh?=
 =?us-ascii?Q?PqXviZcQrhYb9JSO3a6j2PpAolfLdU1It680hN1Y3+rl3hvBP96i2oIQEICe?=
 =?us-ascii?Q?Hmug8AqMLH4tQcJ9TBqn0KwPUISzeNtDYpnPQNyHiJwavlCGzlCgQnMikglp?=
 =?us-ascii?Q?2InjXGYLvokT98h4JrJ6K0mlmb7cti2sKDQ9/RPxF4PfYTvN/MQtMl4vm5SL?=
 =?us-ascii?Q?ZT++1UD4B0wcgB2GtqUjfadgc3UFjxX+NbVvqzSrYmVhkXa9QPaA/IlxWAzl?=
 =?us-ascii?Q?cfCeyTbxlK6CVXzVdtw/X2CNAsDEIQwaWGDaI15kpzyDpz0H+S3AjwezkPaY?=
 =?us-ascii?Q?DjUqTQ2jv9NVrH0G67SugImNTo4FZDxEizaVb+z+4hwZggIouQgkNXVmQBxT?=
 =?us-ascii?Q?rV7v/L5hAF7uJyDvoW8u4OLn1u3Cl1Mg8ApzoJbHlln9c4KOHuRsR2e8Qjdl?=
 =?us-ascii?Q?IKSx1oeV81KcK/NqISXjP2F91C+mRTcfnrsnTTu/DhqlX1fDlDD7bCOP0ejX?=
 =?us-ascii?Q?GTpmbsLcZEaHziVNkgR6HDhD8Jvq6DlJuqttRfWmNT1q3W1aoDnhNYaxRxDq?=
 =?us-ascii?Q?RVm9lEITHr/Hdxze8jBDtfd3PpCTTh4M1NHeMV/5VsA2kN2KdkuAsM9nFVlI?=
 =?us-ascii?Q?OKC9lEHH5ZzYlGheKqmFrPzxk8FcZnIOZ2tujW7PdCAILf3YiKyOmj59z6cw?=
 =?us-ascii?Q?3iCZFEI7TGHU/Y51QjtXoi7tkKjK3MgJA16FDilcHXU33BCkeNnUzusBj0J8?=
 =?us-ascii?Q?Z20mXl9BpMq1JxDogA4Ub3e2zIxI8wtcaHjRGItFn8Ka52sJA4zHiyuB8pED?=
 =?us-ascii?Q?55dgheNNe9DQ0BK/K7PSgiZZ9R6YT2yc95DNJglxnaW4UVxUKbk6ErSzk7rY?=
 =?us-ascii?Q?qHRtudDe1ah/g4Py+H6F0x5iI7+nm8BJPGVsBbNbqxN51Gd5FHVqfWMUgkWk?=
 =?us-ascii?Q?0PYHwxghc2P+Qc3RWohbIlUX+XP9jQ1U6l83e3NYWMKUn0mByXsDRCzAEQuB?=
 =?us-ascii?Q?fr6jYtDv9k3XzyS+MY06CIA4dxqUaeciFBaDvY1nEgt9R0yvDotMRlXF+aaQ?=
 =?us-ascii?Q?t45iDK8qd7F2VYfEHDA/C/GuYlyNu0kYKVtFcmFmlvhRYph/tBd7LIgpgBqC?=
 =?us-ascii?Q?N4VAvX9K17FyNGJMDMAJi+n/SrK+iVz9I3+AxdQUsbO9qseIY3/tl0EQUkRz?=
 =?us-ascii?Q?OX/gOQg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jk+dcqH0QloR7d8FzM5M04eXMUCbtRLyFmpX311MNgVWiQ/Wj/ba8WL5apvN?=
 =?us-ascii?Q?DTmN/9znCsfdPgh4cPgykvJ8uIHPdBE9i2DHrLokTcnK/+FCUkABayP4QGw6?=
 =?us-ascii?Q?KxNUv/5onU7LdyIN0QIOP/AJc+MDIqUfGNTi16Srp546ZT45aDrwC6ZV+sD8?=
 =?us-ascii?Q?+Vm5odkNjOKBgODB/H3vO8rsKK7HH6MHLOSf1SwOn5lmJcVI3kFu3BKn0uuv?=
 =?us-ascii?Q?hHlDwoy5aUw5RgnZKb3cdUrWXEWnsTZlB5/RvMbTPaLwYIpAtbv54SRI7/ET?=
 =?us-ascii?Q?0IRodBTYW0UP790oCJbKOwxAZoWLPEDTxTzg1ndHecgxTnbxUDD62qvZEicV?=
 =?us-ascii?Q?9wSNI/BZK/3YAih8c5L6mk9jYEWhLOQGRwQwABihDvk7gggj80MkEUCx53T/?=
 =?us-ascii?Q?dYURGMq5z+5dH33bSvRReTVVfE0f0GpXJ3zhanq1240EQVqMC1cCeLC5Qp9c?=
 =?us-ascii?Q?+2FF0BOb6FC8lwVVIgy48uPpDX/bkh22JoDIE1SW+whhhTeL13yNPTviw+Ph?=
 =?us-ascii?Q?dKl56lshiFnBVdFrSc/WaU41crDxDh3jAGNCfcmrF/W6geNlLiL1JrN311be?=
 =?us-ascii?Q?SFoxH0/wO1oDIWkdiLNgne59Wf6B0V2OMZdIJSAgEHfk4hI6/vLSFTMey0UT?=
 =?us-ascii?Q?VS7E2pQKQCzzU/VR4J3OwlcrUpBGvSpB3ojSMDtkBkOv9O4s0E7FrPDIYGM6?=
 =?us-ascii?Q?5Dc0SEYmFbaPsLyJ8Q34dZmczskBvdOY0+HaJFQUK7QpSJjjdgQXG1WCNhu2?=
 =?us-ascii?Q?LCgGvU35xfSoE1VdLf+jQrt+eXvirCsIw3wa+fiB8N5vXlKdQKowh4nCIibv?=
 =?us-ascii?Q?UazpftJqyzMoEX/oHyz3ISUhxZkZEeSGNhd/fh8JdKc0dYFWsMKcWr2TYFw8?=
 =?us-ascii?Q?I5Wu3CdIufsiShcTx0hK4ebsg8bA2MTf0yWjVCwn6L1v1Zmf38DKDg8WYdlb?=
 =?us-ascii?Q?ikpOoMvEaWh2JGuvn+C6jpej+GkXfY2BXMAy7mpccpwId5+4pMcfBN/e5V6n?=
 =?us-ascii?Q?KnkkuIoatysqu29SQv1EIvFZMpl+txIyaxcMVnj+8NInAIrOifedVUey7RCW?=
 =?us-ascii?Q?NTxBz5erE2nRHKyqsqIE6G7CIx5jUPolo5MZ9LFYPS5kmanIKZdmaR2Pq1+H?=
 =?us-ascii?Q?/xFDeifPpZTwR61fr73VPNVy+2E6sEdeX15TeW+VbCZsauq8ZQtfkfGg0mko?=
 =?us-ascii?Q?VUWOGV9ThIyCphNDYJvE9wpIyofbCD/r8JGHOwS3sSZEtokxyBJ5TNl9NYNg?=
 =?us-ascii?Q?rCTe+iRZqcS/nNto9JQH4T3MHa3pJGkwOSA+mPJptQuYeScH/qbNRSbVkoD6?=
 =?us-ascii?Q?oV+QpGHbJNUyuaez2hLBF78MQS4N1Du3Mlg/gjOAVPXshveEeQAjIbX4IJRd?=
 =?us-ascii?Q?sDYStNZo0MbBb+1aMnhNMPnyIQIspc4XeHSjkOqGFLK9q+3RAQNp7u+Bep1q?=
 =?us-ascii?Q?ZrihXP4Aw4h9bXQNVBPBK/EsxGhLRCBW9cbuTE6+8OXGPbug2tF+penXQorP?=
 =?us-ascii?Q?3CNAzf+TUpP1QvGTtLw5l+jF3GAFuzj6C3p0Ewt7AUFt/dQ5hpf2ERt033YZ?=
 =?us-ascii?Q?u77W0VPR1Elk/8TvzfJekiapkPeszpJnKuo79g9O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3461e8e-7f98-4334-c83e-08dca060efe6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 21:48:58.5244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWlXN/9NXx5/q4Fh2cJxR/i+vRkY3hlvnPEso/tjzw4mpp+05UgIQrxG5A142Szi2eiFJ939onTwQZ8M2sp5SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7391

Convert enetc device binding file to yaml. Split to 3 yaml files,
'fsl,enetc.yaml', 'fsl,enetc-mdio.yaml', 'fsl,enetc-ierb.yaml'.

Additional Changes:
- Add pci<vendor id>,<production id> in compatible string.
- Ref to common ethernet-controller.yaml and mdio.yaml.
- Add Wei fang, Vladimir and Claudiu as maintainer.
- Update ENETC description.
- Remove fixed-link part.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- use endpoint-config as node name for fsl,enetc-ierb.yaml,
- wrap to 80 in fsl,enetc-ierb.yaml.
- fix unit address don't match
- Remove reg/compatible string for pci
- Add pci-device.yaml, which need absolute path.
- Use example which have mdio sub node.

Change from v1 to v2
- renamee file as fsl,enetc-mdio.yaml, fsl,enetc-ierb.yaml, fsl,enetc.yaml
- example include pcie node
---
 .../bindings/net/fsl,enetc-ierb.yaml          |  38 ++++++
 .../bindings/net/fsl,enetc-mdio.yaml          |  57 +++++++++
 .../devicetree/bindings/net/fsl,enetc.yaml    |  66 ++++++++++
 .../devicetree/bindings/net/fsl-enetc.txt     | 119 ------------------
 4 files changed, 161 insertions(+), 119 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml
 create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
 create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.txt

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml b/Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml
new file mode 100644
index 0000000000000..c8a654310b905
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl,enetc-ierb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Integrated Endpoint Register Block
+
+description:
+  The fsl_enetc driver can probe on the Integrated Endpoint Register Block,
+  which preconfigures the FIFO limits for the ENETC ports.
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+  - Vladimir Oltean <vladimir.oltean@nxp.com>
+  - Wei Fang <wei.fang@nxp.com>
+  - Claudiu Manoil <claudiu.manoil@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - fsl,ls1028a-enetc-ierb
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    endpoint-config@f0800000 {
+        compatible = "fsl,ls1028a-enetc-ierb";
+        reg = <0xf0800000 0x10000>;
+    };
diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
new file mode 100644
index 0000000000000..c1dd6aa04321e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl,enetc-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ENETC external MDIO PCIe endpoint device
+
+description:
+  NETC provides an external master MDIO interface (EMDIO) for managing external
+  devices (PHYs). EMDIO supports both Clause 22 and 45 protocols. And the EMDIO
+  provides a means for different software modules to share a single set of MDIO
+  signals to access their PHYs.
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+  - Vladimir Oltean <vladimir.oltean@nxp.com>
+  - Wei Fang <wei.fang@nxp.com>
+  - Claudiu Manoil <claudiu.manoil@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - pci1957,ee01
+      - const: fsl,enetc-mdio
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: mdio.yaml
+  - $ref: /schemas/pci/pci-device.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pcie{
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        mdio@0,3 {
+            compatible = "pci1957,ee01", "fsl,enetc-mdio";
+            reg = <0x000300 0 0 0 0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ethernet-phy@2 {
+                reg = <0x2>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
new file mode 100644
index 0000000000000..e152c93998fe1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl,enetc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: The NIC functionality of NXP NETC
+
+description:
+  The NIC functionality in NETC is known as EtherNET Controller (ENETC). ENETC
+  supports virtualization/isolation based on PCIe Single Root IO Virtualization
+  (SR-IOV), advanced QoS with 8 traffic classes and 4 drop resilience levels,
+  and a full range of TSN standards and NIC offload capabilities
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+  - Vladimir Oltean <vladimir.oltean@nxp.com>
+  - Wei Fang <wei.fang@nxp.com>
+  - Claudiu Manoil <claudiu.manoil@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - pci1957,e100
+      - const: fsl,enetc
+
+  reg:
+    maxItems: 1
+
+  mdio:
+    $ref: mdio.yaml
+    unevaluatedProperties: false
+    description: Optional child node for ENETC instance, otherwise use NETC EMDIO.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/pci/pci-device.yaml
+  - $ref: ethernet-controller.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        ethernet@0,0 {
+            compatible = "pci1957,e100", "fsl,enetc";
+            reg = <0x000000 0 0 0 0>;
+            phy-handle = <&sgmii_phy0>;
+            phy-connection-type = "sgmii";
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                phy@2 {
+                    reg = <0x2>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/fsl-enetc.txt b/Documentation/devicetree/bindings/net/fsl-enetc.txt
deleted file mode 100644
index 9b9a3f197e2d3..0000000000000
--- a/Documentation/devicetree/bindings/net/fsl-enetc.txt
+++ /dev/null
@@ -1,119 +0,0 @@
-* ENETC ethernet device tree bindings
-
-Depending on board design and ENETC port type (internal or
-external) there are two supported link modes specified by
-below device tree bindings.
-
-Required properties:
-
-- reg		: Specifies PCIe Device Number and Function
-		  Number of the ENETC endpoint device, according
-		  to parent node bindings.
-- compatible	: Should be "fsl,enetc".
-
-1. The ENETC external port is connected to a MDIO configurable phy
-
-1.1. Using the local ENETC Port MDIO interface
-
-In this case, the ENETC node should include a "mdio" sub-node
-that in turn should contain the "ethernet-phy" node describing the
-external phy.  Below properties are required, their bindings
-already defined in Documentation/devicetree/bindings/net/ethernet.txt or
-Documentation/devicetree/bindings/net/phy.txt.
-
-Required:
-
-- phy-handle		: Phandle to a PHY on the MDIO bus.
-			  Defined in ethernet.txt.
-
-- phy-connection-type	: Defined in ethernet.txt.
-
-- mdio			: "mdio" node, defined in mdio.txt.
-
-- ethernet-phy		: "ethernet-phy" node, defined in phy.txt.
-
-Example:
-
-	ethernet@0,0 {
-		compatible = "fsl,enetc";
-		reg = <0x000000 0 0 0 0>;
-		phy-handle = <&sgmii_phy0>;
-		phy-connection-type = "sgmii";
-
-		mdio {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			sgmii_phy0: ethernet-phy@2 {
-				reg = <0x2>;
-			};
-		};
-	};
-
-1.2. Using the central MDIO PCIe endpoint device
-
-In this case, the mdio node should be defined as another PCIe
-endpoint node, at the same level with the ENETC port nodes.
-
-Required properties:
-
-- reg		: Specifies PCIe Device Number and Function
-		  Number of the ENETC endpoint device, according
-		  to parent node bindings.
-- compatible	: Should be "fsl,enetc-mdio".
-
-The remaining required mdio bus properties are standard, their bindings
-already defined in Documentation/devicetree/bindings/net/mdio.txt.
-
-Example:
-
-	ethernet@0,0 {
-		compatible = "fsl,enetc";
-		reg = <0x000000 0 0 0 0>;
-		phy-handle = <&sgmii_phy0>;
-		phy-connection-type = "sgmii";
-	};
-
-	mdio@0,3 {
-		compatible = "fsl,enetc-mdio";
-		reg = <0x000300 0 0 0 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		sgmii_phy0: ethernet-phy@2 {
-			reg = <0x2>;
-		};
-	};
-
-2. The ENETC port is an internal port or has a fixed-link external
-connection
-
-In this case, the ENETC port node defines a fixed link connection,
-as specified by Documentation/devicetree/bindings/net/fixed-link.txt.
-
-Required:
-
-- fixed-link	: "fixed-link" node, defined in "fixed-link.txt".
-
-Example:
-	ethernet@0,2 {
-		compatible = "fsl,enetc";
-		reg = <0x000200 0 0 0 0>;
-		fixed-link {
-			speed = <1000>;
-			full-duplex;
-		};
-	};
-
-* Integrated Endpoint Register Block bindings
-
-Optionally, the fsl_enetc driver can probe on the Integrated Endpoint Register
-Block, which preconfigures the FIFO limits for the ENETC ports. This is a node
-with the following properties:
-
-- reg		: Specifies the address in the SoC memory space.
-- compatible	: Must be "fsl,ls1028a-enetc-ierb".
-
-Example:
-	ierb@1f0800000 {
-		compatible = "fsl,ls1028a-enetc-ierb";
-		reg = <0x01 0xf0800000 0x0 0x10000>;
-	};
-- 
2.34.1


