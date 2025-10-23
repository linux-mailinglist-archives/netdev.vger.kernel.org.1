Return-Path: <netdev+bounces-231992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574CEBFF790
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B349D3A7EB5
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 07:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC8C2C0F76;
	Thu, 23 Oct 2025 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UvWMDGWL"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013050.outbound.protection.outlook.com [40.107.162.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D535328725B;
	Thu, 23 Oct 2025 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203778; cv=fail; b=tP8MsWpYJV2OPg+B4toR+NYvtXcSOoA8R4pXx1KNSd5uZMF9GtTgPRXNSQnFFsfIuwE5YgbPtRyn7J/nwIzyGKdcrv7EGQMkTeiP0VbAYkcYi5A6eLDuGccSvtaG2ngIaHHlTr/UkA1/ZJjZ3PzKPtC1gJQD6h7Tw+tT/eeHdgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203778; c=relaxed/simple;
	bh=v+LGqaJDbaE4YQd5j1uIJhfEE4OuedcFLV6thO+nTs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RzfxbJtbyAcBOMx0ssyBkpCwctQrPqeiF6FHv82b0MUXWBb+qupCRogTYHUY5XQhVNcrBRzUG4GulWM/nwMMnPDSapgeXDltEI3fMJUmpMmDYalM+m9q0vGzp/1B/QCrlo4UfZ5AdfEUXEncUJJEtyp+vNnOdBdildps13t0fBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UvWMDGWL; arc=fail smtp.client-ip=40.107.162.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nmenwgly88YH1v0sQZqS/VSJJCUojPlSDkc/ct75aEHUMF78Gw57LB+ltK0JYrhZMB5zw+dA+Q/+S/e5DPpiqPUrjuP7+fcKmlBqVMy4pUmVqypRxy8ZzN0Uga9M2YQ8xQOsvfN6cPhsRcbTva14wxywEhVQdwD18RIXYKLCfIDbynFN+Wy+IFYxTDfmByhguZSQBdjPyucxnMWwrgPNLGj9r1sBWmMhny2zy+8Pn7RPRuLemAs2JmxMwnhVfuzCTfuJtjbczSqKySlPjfpIq+Rn3D+31vG7AqZp0CsrxnPkr1mF4iZsdhPWw35+If690CtAyWImrKMJ/wo+jvciRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7L1QK0sOID1c4hot9AaVDS/DjDP4szS3yJcavVRnt4=;
 b=iS1ysmwcEUUn7XXsT8nF+sZesygWbCpA/dN6D0PaRTSCN8uYL5kd9dzqaK0gzFldrAgvTes32gYqGLxqsatD+n5j1cU9f5Ab0/cAtAn825hc3wCKfFIVv5S7CHfZzm3tFDULyAgadVkYvUo1yW0U1MTt0cwMBd0jvdtkLIr5HoMz3ie+L7Z2D48kXfALkd3O3Vx0xhbHOPPIJ8ho2PU/jj5pmGNe+Ae3EI9QQRWuQ0JDvJOypqz+NUHDQBj4Q+cEPDb7P83YmwbkTuJrtha0n7avKHMYKH5hdkiIsfIPyymxBRETZ4Js8izljQSzRdLbWqn2OBPtwAwHBSu287SNUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7L1QK0sOID1c4hot9AaVDS/DjDP4szS3yJcavVRnt4=;
 b=UvWMDGWLQmvjI7T6W7WwLdk8hRdf+XOgkKcJ803X9MAzGC+taLrPnHL/FN27/8GACKYtHu0b2rAnFl5dyZjzFDP8tT9/eWq5hou3YWuJxrSalBaZTPZU9celx7o6qNSSleiCj3PNS7TjoEYhxQUcy0AHO3heJ/H1OXVpJE/Bz7WB5W8YVIo1BvsbH/Y5TXL1sOy870rwZWgprjXHM1/8iP6FTddVcwesim9im0T3Ye6nlTTbRuOcb9sMmQpVN4x7fadP+HhrsuXC5yOvHBNqc4ftJKofW9vLHOUHWMRbmhyLk/t/pGI6OCAqKU/iOl3nScHZepoadbEJm3UGZyyi1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB11697.eurprd04.prod.outlook.com (2603:10a6:800:300::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 07:16:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:16:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 net-next 1/6] dt-bindings: net: netc-blk-ctrl: add compatible string for i.MX94 platforms
Date: Thu, 23 Oct 2025 14:54:11 +0800
Message-Id: <20251023065416.30404-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023065416.30404-1-wei.fang@nxp.com>
References: <20251023065416.30404-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI0PR04MB11697:EE_
X-MS-Office365-Filtering-Correlation-Id: 90abdc26-40f3-4f49-9ec2-08de12040d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|52116014|1800799024|376014|7053199007|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ijw+cu/ht/mI3BxbwHTE8sKGQB1lerNKfHAo8Eznagw2op/wxE+Nz0Sk5x3G?=
 =?us-ascii?Q?u5B9Kedn9xX7+1CIrX0E2B+ZpIDWlDblYpNlhbOqT3j1G8Zio3mVLNARQOx4?=
 =?us-ascii?Q?rxSsiUhvntPJrpsTLljcl5ILfxLZlT3ybx1fX52yH1erDE2mEOUxWGcvqXVe?=
 =?us-ascii?Q?UpPOU4Ap88SA5Z+IWGb1rNw6tm8FuutEvjS81cBKFnOlQl/VCOtgisTBzIdB?=
 =?us-ascii?Q?6ibdRnSFSKkQx/6fB+PK6/dpvnnlgYaT+Ax7J7pSK2L79BOK08ZhxcJ8ubV1?=
 =?us-ascii?Q?V+Nma9os+K+fQ9HuACnNef3Y22qFWpwWAIOGWGNEkhL618FfzDO/EH5zKwrv?=
 =?us-ascii?Q?gy8oBnIg3xxgNenlplVClzp0GWmNn0m46ifNZhUP32DXxpmqBz09AOG9F17q?=
 =?us-ascii?Q?iFFKlhbT1DKLw+8aHsZYXAuYyQxkGreTKfTbAvOkL8n9sTOqWQkFaaUS+tkf?=
 =?us-ascii?Q?ioTHc/9lo/39ZPccmJRCTGH/XNapMiIgVGIkZvPq22zLoUchuoMXcooL/OTg?=
 =?us-ascii?Q?CHFnu58W7W63V199XRyrxQ/ehAc7vKRybY4cHXzxVCl+8Zp+EI9BcA3Rijef?=
 =?us-ascii?Q?7uGu9W0r0F3eFKQrYx85pdLOLLnoC+0ua4d4irtPJtzKTQK+p+J75BT+nlmn?=
 =?us-ascii?Q?JkO4eOGlaxs0UhihKFECyI3PsSpqilnjPFpL8HpgNDw1nfpnPirmKTLIrbPy?=
 =?us-ascii?Q?hXvLUYtNAcrlSVMtnP1WAVLsgmzDNFiOAg8tZxnu1EsVLQRbiVoPVvPQHZsV?=
 =?us-ascii?Q?fnl++KVbOlw5zR0r++bOXw5G59360Ra5NeoyfmnPOUEqz2L4JJyVd+z8Q2Vi?=
 =?us-ascii?Q?HFBTK7wdX7n2PbXPC2R+S0OtDbgTh3RyQJYvLVnayYhSR+FtlPsJdZcVu35T?=
 =?us-ascii?Q?pZkAPMjspjcA8OrdTWvy7tRxrIBLpRxwd6AYHdV6+HNwMh50W6KHdMKU9rrF?=
 =?us-ascii?Q?jM9oYZ3yMutn+dwxhHBc/OQTNSosceQtdhHlAk+2xmNZczbUDmbMykRG1iWU?=
 =?us-ascii?Q?SKTPuZy9Gg09WRmtOBUTYwQvPmYFaroPS0bUv9cdsroemB4kR09vfPTRJ2iN?=
 =?us-ascii?Q?xtt/nf4nBKnIgb/dT50eZFP1PMlq70XyAEXCxUQPFMeCPUBXX8PlJUT64FIi?=
 =?us-ascii?Q?431xZvIorj3ZmEEChnJhy0oQxif9JlYq6/Gh/X/a+pJ7pLANUg/epjT+PLu8?=
 =?us-ascii?Q?/To9z9i35dX056HqKYqIZyPsQ++cJ1jyh3QI69HiLInkEG5Ds90XVL/j4HZb?=
 =?us-ascii?Q?boJJF/wY8d1wIbNW2qTkrHAW1oAwUuysAcC8pKQfDhBhQ7b6K3Y+n7jmgdZW?=
 =?us-ascii?Q?9Fc3IKjkJ5VSPc8PgWccKZz3deU/03MsT8Ob5PgwoDTMv80XH3/jyC6LO0yR?=
 =?us-ascii?Q?QiZ/4KvrM7TXuGffvkmHT4Ad0cgC+8ANO/9mEgyy8SYMnTnrhIiP+fiPYJFG?=
 =?us-ascii?Q?5hs2O7ELbJFFRexqc4QC1trp5I5TxdquitTVSpBUfNpzdVVQC92emQmj0oi1?=
 =?us-ascii?Q?2+mgS+uLMVFZ/EqObcqxFE3qv2Op19KlmhtKdBoyPhLIfJ4pvo8+2fKn9g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(52116014)(1800799024)(376014)(7053199007)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/U+ELnJgb6VeJ1UK1mtHQpIGm9VUZb221Q1XpPKbqSzGgCTmH//CYM3jK697?=
 =?us-ascii?Q?QhKKV6a0LzjhD8AiRW7YZDMPbugcOBxiVNfAVnrbTPME+AxWkV6aJScVVEy9?=
 =?us-ascii?Q?IZu+U2ZwJ6xJFR+4Du87EG9uMTZJvDJMhnNYcu1y8Ag68TfbNwk+gYlDT3H0?=
 =?us-ascii?Q?fGm1DRtucBlWGz34bNraoL9i7fvhYL2CvgqKR9V1AV3+kShScIVUWY9T2TZt?=
 =?us-ascii?Q?058H16mh4/IaThdhmTnoHaOGf5550FCgNA7wbM0ezDUzTiywZhy+tdp7YLnS?=
 =?us-ascii?Q?7vQi9kTZcoM8mB5wPgTYMooFfGg9py6zsOR1rZujttud0K9Py3xCs2RMp2o1?=
 =?us-ascii?Q?pyLV6LyArImhYYbX9+SyAsp9pz8f9yqi7z7ordZhOxW8+BL3gMB4c84r+Ir5?=
 =?us-ascii?Q?SLRFwDDDwbCZRPEZseOnEcps5z+geEFxFGaMswKHoVkSSRzMubAC2WYneC3R?=
 =?us-ascii?Q?Bm3G0Vjs2N9kRZ8LcUWNhwfSgrQVauALV7C/22MORvU32xfOePCEiqsYg1kp?=
 =?us-ascii?Q?ClcvR2NlOZ83SoGA2XGhkBNhkvSVjJLdLsRY5WZFMNYkJ6FOe+6++GNrBUaD?=
 =?us-ascii?Q?+do0My/B0T9OcWBEGhlta4JQYPuE4dWbPXFnJsoGPCJz12Sxf9/49bUFIJod?=
 =?us-ascii?Q?3pch3kVQrSNMnPHsUty0Fld4RMzHtPbFelCjhyV5L6qDCAEwXVr87kqGyCuh?=
 =?us-ascii?Q?AXftTYp8sr6or2Mf5mxnX3a5fkvrMdxrsi6tVdNcuAZYZgQRZZLu9bjjQXvS?=
 =?us-ascii?Q?iPaZH3Mw9g6J00eXN+Q8D+cdbQErNL27oQdtyjejSQ/tHMgkOK/EXZIo55b0?=
 =?us-ascii?Q?zkkx78mPFCZX8qkN367zFN8vRTJTug5yE6wS+EEySyxtL8KQIkr7dtQf6wrV?=
 =?us-ascii?Q?HmXJBUJ7OaGbjCFVJnLUnSgGXmdxoIbR21AVk7R6qAwDdUJ/LTokkt0RZpxg?=
 =?us-ascii?Q?VwhcbVTilh/s8gM4bJpZrKlVOUe+JX7EMpDyS+4pNg973W3eZHg97mNTV71B?=
 =?us-ascii?Q?xzPmA5KQ97JTiXgkAxuxZpDEV32AFXA7OpbKsFv2sQSwaplSIRUaaMvtiVu+?=
 =?us-ascii?Q?IjKGvMfVG1q6bulYvdrTLScfOYADn7vISy0+TFpslTVJVm+8cb/+kZyau1G2?=
 =?us-ascii?Q?7cgZBebdgZbus59UgaoA9TjaUT2odRr+sB58fif9benoqy+WMIzcTJeDPs4H?=
 =?us-ascii?Q?3q308hoy55tDD0nFgW8MNnmx+Q5SQEYHa+z9cxuCFOqpx+cEWP6UX0fifDew?=
 =?us-ascii?Q?6T+/5wpa9fTvcyeSyhVPbXwIY10uzfB+Ie229svTFgz+NRurcROdQGinKmes?=
 =?us-ascii?Q?k6F8oxUGZaBNwPrhzTB8BuaY/pKPVrH1ghIdGcdg1zi5Lo+4gw+IvxHivMXJ?=
 =?us-ascii?Q?ScUEKPMBlcgJHIjp4yYsQGhxfytb7bApzOeFP668QD26PmmB3IbDANqP0csO?=
 =?us-ascii?Q?ZV+Zst+2CcXk710mx9K9rxVl2nPPsjZrY8en6+euUAGc1wkWo3rrXB7xESR0?=
 =?us-ascii?Q?5qaxgsVYE8OGM3XtyjKzWjZTdkkAUKVbEH58YOVi+fFqoxI/jHNy3i4hPECL?=
 =?us-ascii?Q?ADL3UznBsa/a1xPP3bwUopm6gofDcs0NW+bgH2aP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90abdc26-40f3-4f49-9ec2-08de12040d86
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:16:15.3502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91GFKUJNUOSNNnYjgJsfrpCpcnJDY4PmqGIel7VSs0jfREQv91/74z7ovd/7m2jrjnrRX7jPBnnMfV7tFuluzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11697

Add the compatible string "nxp,imx94-netc-blk-ctrl" for i.MX94 platforms.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
index 97389fd5dbbf..deea4fd73d76 100644
--- a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
@@ -21,6 +21,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - nxp,imx94-netc-blk-ctrl
       - nxp,imx95-netc-blk-ctrl
 
   reg:
-- 
2.34.1


