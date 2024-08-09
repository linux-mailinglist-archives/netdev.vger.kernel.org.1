Return-Path: <netdev+bounces-117293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D47C794D7DA
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 22:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353CAB212ED
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 20:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5EB16086C;
	Fri,  9 Aug 2024 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fLkLZya4"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445F31D551;
	Fri,  9 Aug 2024 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723234039; cv=fail; b=EJhI5MHsW0L9+mjtSrspfPRQ7JRealJ95k5me7t/osrA9DsHIjZr0QDaFXXWa0yUdQbOwQaDgCRecs35Vw6YaIFsYQzftuUofEMDeGIV5BOA6aBsmEMGU1iNP1OCPSWWhwy2cpbo/EfMEakgutzw9q6MKE9392IDgPgazvurte0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723234039; c=relaxed/simple;
	bh=YrD08t18iCV/6SgEE9mlFugQZGxUS7eU/E4zqQhQEFA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bQ0bMw6OhNP0BcD8K10orA7Y5CkibD4LLioMdxh4mWo8FjApmsjhfOxsWA3oZoSsV35QEthlT0wrbHbDFGooNxEaCkulUl6CqUD57v49JD49kfZ8XEQicYcKg3rDO6rUz1bpfLXBrCg/ifgbBLeIjux+n7k+ihWFQ34ayC7lZSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fLkLZya4; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3AyQqxFtBYUM78sn34Md1OnbP3thrYTvHrLtinW4ui0NiaGHNnWxKjg2gmlM2H+X469GmthG7dllYJC/C60c62iiU6wMV7VZ+Lyp9actt7lxeHxOHd4yRtC+8zQ7RzgILnVeYSoDGv4pvkippBsDFu3vTdFHV02tWSBMN0XPqIBEXp6wy32E0D/ChIZdSn47pnSeotB58UpJa11islL+x9YtQqVDHXIWgaHO9L+9qN++SD95AkZRhq75CQ3qjtGL5vp5+6/BQaErVltOVBNFAHQlu5fwhzWEKNkHOcRMN2pRut2/zGM6Rzrd8NOGrlHjJRiy5eeAxX1l8nfSYJnag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qk5N22R0hMrNlIwJIgKRoxKlK6q6KXEPcOuceEIDGhk=;
 b=xJ9xPiVzm0JV00pCIoCOWVaU1c9pj9SIALDZOD4HcDx6l6OSrJkJ42glxqKHGMn08fm8CHCIeX+BYBym84S6i8Za5ENUtlJNl+unFBH69ST/Nz+MVdPBRNcPdXG1xYmaEmmbsgcyWBwvr87yBcaoaq/r8JkGdDPE90G3qFJtqHcqU8eWLbXRgJDFaTgrtYRZ01bHLVpxk07KaZ8Gv00dZpvZxMZZTiMpwmZNBY9iB/Z+L8vwlviHmyJShqSXtAHqFU7BrClzIDOIYPIN0maLnVUrUvtOKLK2fLYiItBvULNZx9TZnyygyB3+rD4nuLm3ptHLiAhymgxf+jVYAsNaOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qk5N22R0hMrNlIwJIgKRoxKlK6q6KXEPcOuceEIDGhk=;
 b=fLkLZya4J85xqU1rTMLUaHA+TLMLrI8EDb/7TS+Kg6PzQUaO0IQV2i14avz9IJhmX8yTvM1KJzVN3UzoMxH+y5MK0VoxqpNjXYBQVp8iUqZCy8rJDrouPJmslHmZVKWWSi6lqkmJu/qy2EtSYY75HhAB9hIvvRAfA8yQra7JOSCtAqqV6qEanZIAD6EHegR9+/RklVsrVW3u9ehiqp32xSQL4M+CKEi/O2o+nwDiMc8eem5RW/9IIgCj9cIT2ZAFGXqyomckweNHFQvZC1Kw3duuUmAWsk9o9CEAFzyv0w+5HQ/EWnPO4jWLXfQ9zM6SvsUpDul90RpnnCb1ypc/TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS1PR04MB9478.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 20:07:12 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%7]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 20:07:12 +0000
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
Subject: [PATCH 1/1] dt-bindings: net: fsl,qoriq-mc-dpmac: add missed property phys
Date: Fri,  9 Aug 2024 16:06:53 -0400
Message-Id: <20240809200654.3503346-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0031.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::44) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS1PR04MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: 9131b954-ce07-490e-51a6-08dcb8aedb41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MsckTSpP48s9VVd0MsWif94jbWsUg+AKyQ3nRCzQ4mOOi6L9IwO6xnEdbhiV?=
 =?us-ascii?Q?JTI1W+LlmP98rd5QanHjwkYXgaSOhQOAt+3fNNSkISKrf0jHNv950OAGCTZp?=
 =?us-ascii?Q?N7u3rv7QsBTV7lsj85usZy9SRCmpjxkIQ2VaSJEs/ROeF1aHUK/HhUny2X15?=
 =?us-ascii?Q?lWmtP3tpKKzfK+6PBtHnXGweKmb0A0DnuXs3IACbJ4pWDlpSXP/fX6/FI3aY?=
 =?us-ascii?Q?vFYe+Ob2Trc4ow7xfVgsR64POeNQp9W7itwkHE0jPC7efZdgRH/voaVq5Opq?=
 =?us-ascii?Q?I/ZKFwuS68LNhjks0UVQ1712XxPCj6ThKIS9ALbHfg3HThMAcu2YVaRJjuPI?=
 =?us-ascii?Q?T/tPCYMvy+AxcUc09t8i1YU4xwODXt1te2wDfUXAIoSG5ggkFsxUrUIAEqnd?=
 =?us-ascii?Q?EsXiZJ7Zn9NzFBJC0c/OACASfcapPRpH477oCuYbMkYoWlI+95TrAVsL5C7J?=
 =?us-ascii?Q?SrIit3F5k/Ig7peC2xVB92PCVqeM3F56Pf7Ho69Xz6GvCiBnZmm2uA/Z9TMC?=
 =?us-ascii?Q?XZOK+dQ1ZyW2pehLRUfmeVIPDjDDL0wXwqdA50nECYyjJwkxr5U9l8MEjRe5?=
 =?us-ascii?Q?EfuM9ntO4mhsoriMDqfak+pWjLgp3zMjZ/GZbBandYp//6WW4/wTRwvwWedS?=
 =?us-ascii?Q?eIejFfYBkHsjusegg5oSTYdKT2Fdswl1mO8JbumszVBHyA2NkdgCxwBVI+E5?=
 =?us-ascii?Q?bQF7Aey17elX0t3eJeSsENtmdrkoLz0c9EaD0YmrztERoVAP3MO17S7OoMKh?=
 =?us-ascii?Q?Yl5lmaufU5AwUJhQo+aQfMWnH687rT8E6qYP9QZlQFr0eUFQr3k20nE+2piX?=
 =?us-ascii?Q?6c1d6gj8Ue8OKqjs8cpeadfacJl2SjpwgACa7NgEa6dNkvf2lqtwf6ZNEzS0?=
 =?us-ascii?Q?hZUoASFE2c3H41wlEJsOcx1ICnQag9st0E7yZEERXWzEJFVW2XpKkxAQnFft?=
 =?us-ascii?Q?Os60LwZ+I5xCSWC7Sw4daBtRQy+z7E2EwiB8moA8OdyX/aqoB3mspnJKE9rC?=
 =?us-ascii?Q?ixzWpwJaKNc78Pp3GNl595rLv0045sGwrKHj44J/nbJSw67pFuauwrtDB4yf?=
 =?us-ascii?Q?QPUrya+ahO+L36tyXxkNrILI1/Msj05rkUAROnTCJJIaeKshD+9877ACEd8N?=
 =?us-ascii?Q?IeKLDGE04OMt8fzNtujqe/OGpMWfMnsvnnOGZfOoLIW+5GkAwpG7Ur5qdsja?=
 =?us-ascii?Q?+HhrJU+9k/3O6Bob3+mETelJ7cCdjhNBH8tQ+8Q7ANZ+EDnuaTK90KwvLBYU?=
 =?us-ascii?Q?fk7TgakZYWWOOUJ6TeQ2k6DuLyE0H2e7e5unEBdLtSy7FbtTQguG+JkiFzew?=
 =?us-ascii?Q?uH0AwNwxr3M1A06O3zhGB33Ke7l4O2RnriLwAqHrXs1b0Kw7nUmhllEmFU0O?=
 =?us-ascii?Q?aYQeW03/gxNA3eUo+n+gvYnuE2WLF1C8MJ18rgI1TcmdSm2lIyxs3cwiRfm1?=
 =?us-ascii?Q?CcuBN73zXUI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EGZu32s5DgRM0UpAMpMWtKFpWnO+OkPKceaaoZOBesVvjo6VZseKtJuPG0QG?=
 =?us-ascii?Q?23YibOpCffDGfIv2Cb4ySC1YDnacySf60Dr1gGysPmd2ESZlySHDTwGo32EK?=
 =?us-ascii?Q?b9JUMy7rV8Qd0PwXJr5xUQNyZh+b4HEAopdprH4LuPjgKzVotBnbZvcoFc9k?=
 =?us-ascii?Q?Eofyh5ABZmJfWaRXlcPJ0MfY++tU2DXxy9274kcjpr2fblpTZKQYCAwjCmB6?=
 =?us-ascii?Q?Y7S/gT+PRfZQCHW0GBnt0ROlThAtDabRAqWZjJ8WTZvZlk4tZ5EwuFrEyg4U?=
 =?us-ascii?Q?cywBq61ZiLCFCjJL80nMfs534ymipOq+X2dBT6NnkO57JlBF3Bfa6RSMMlxM?=
 =?us-ascii?Q?96jsx9hEntdRETclgnYGxBNuFa6NO4r8KvivtV/nRMAYL/sMpErCPzEqYMaR?=
 =?us-ascii?Q?E3V+1wYCgxz9NwNZbF3DZqKHxfV3gz8iaBrBHVZs3hzf4TDVdAMgTJzI9ZW/?=
 =?us-ascii?Q?XO/NVSyhDIt448gASIBdFR2DwBBR37HEu6ISuefBUxrMuY8vbJsHgsmQeO6a?=
 =?us-ascii?Q?OtOre2AAbvxFAwLqOVSlc6omQKkWqNJ33GnU29iYA2cnf3vcqE/CHQpMFW5V?=
 =?us-ascii?Q?PLJMtxApsvJVYg8sttZs/LANaFdh+sGaXazIIbqpKLYhyMUdAnL77gZFKEUc?=
 =?us-ascii?Q?L4eHihdDDCvhWK1dZR15LOZJMa+y8o9bMlnI+CUK2AaGM/rUsTDKaiTmBwAp?=
 =?us-ascii?Q?3qE7FWzsj39i0zhDCTPk+NaAkaezgVkqvHF+r5nzvdmEHQ/E2JrV8gI22Uwv?=
 =?us-ascii?Q?f4ezr9/ucMg9cRF5ZhEBsoAGlebV4YYlAOsw6ixdVB/0Pr3bxrm2D9/emu1f?=
 =?us-ascii?Q?QTK4b1xgUoG/wOdFDHuYWpCtRPo8qmxSjow9IuAZmzFtdEkpIZiUDDE6od1u?=
 =?us-ascii?Q?mVmbEBLGnwWqMX1yfW7PTBZDQqR5pS4Dbok5aETVB6JsF2G/u4+CnGBZ2eDb?=
 =?us-ascii?Q?7c/eVZIuVP395EFB7pECced2OvGSoELDjVXDaUWN4YJ5epCVHtr2LfHR3oYA?=
 =?us-ascii?Q?oMBxL+TNDPxMQk1FpcZESbbpN59OauR5MtC4BT3PlrfSAZ0nZqBgVU1vRB6g?=
 =?us-ascii?Q?zSpflpOjwjkp6MjahKntWj88pyrkrGw/C0+70PbIOS6JbwDeNXhVIF/mPs/B?=
 =?us-ascii?Q?fwWR5Y+i0UEJ4Ay5YB+cND7ZdEisCHxMN4a74/qLNauQH1Kv/zOIE6N1yv4f?=
 =?us-ascii?Q?IsDFI8Y/B24jOMfXGszdyZliUxq/FV3R2D83GlLiHm12xEvjJbe94cJHbAB6?=
 =?us-ascii?Q?Oy6+drAvUELpS/d5SigKRXKZHuWcmrBJEQP8TcOsH0h3o75F7ga1cAfGXKfd?=
 =?us-ascii?Q?R3SIO+Y8BIJq6bZXVtwFovZWyUtqPIOKY7w49hPYQs69GcOk+vcB+V+UqucF?=
 =?us-ascii?Q?mCZVwf+Lgk9AnQ9+E7tzhbss+NRxcmtmB92X5Gqrbyzm5zO6RaMRtX88fTCF?=
 =?us-ascii?Q?Fh5PUusaaU2bq/we+kiQVvTSb5By1dbW8jBFYtRVTJE2O3XcJR8gc7JcAbCv?=
 =?us-ascii?Q?hPtDJYSdDoip6zqaEWPq04gBXngLlc35npdP1UrkGa3oR7xjAMIUZ4oyBhJj?=
 =?us-ascii?Q?ZqrChQZ0N0SIphb7h8M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9131b954-ce07-490e-51a6-08dcb8aedb41
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 20:07:12.6122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OvmjMtribLgDMRSHbc7IGQaHayr6VaC7HRp/JkEufdCwBXtlsdcPRZGZabps9ElgtQVQ5nVziZw/9kdPK/neA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9478

Add missed property phys, which indicate how connect to serdes phy.
Fix below warning:
arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: fsl-mc@80c000000: dpmacs:ethernet@7: Unevaluated properties are not allowed ('phys' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
index 6538e0ce90b28..25d657be6956f 100644
--- a/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
@@ -38,6 +38,10 @@ properties:
 
   managed: true
 
+  phys:
+    description: A reference to the SerDes lane(s)
+    maxItems: 1
+
 required:
   - reg
 
-- 
2.34.1


