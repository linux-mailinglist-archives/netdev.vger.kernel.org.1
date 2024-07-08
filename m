Return-Path: <netdev+bounces-109968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A684492A8C1
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8570B216AB
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1CF14AD29;
	Mon,  8 Jul 2024 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ndlKJtgp"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F0A149DF4;
	Mon,  8 Jul 2024 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462214; cv=fail; b=IE7hPZtBDKrP3xKYsMICSmnVgcIQMnqWbDUHUTjIbAhzor8lntZs6hXUQTDxOQ/lJ05QgjCCKlgmljdd6NDAzy5DveLi/g0cDNPA9k2IBsJiX1rtoNII7rqfpRl6PI5ipjvlNQL14b9unNzIcrNm5k+yNfyzgl1YmgsJf7Vr2Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462214; c=relaxed/simple;
	bh=FctKiJtnCpILoNYRf3LCt3/zWpmkTI1uPCtOT+B1Gmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PTBHwSKBWJlZIW98999uGkXRhzKCrO8K/2/suo1Od3uYL/GCaJTcQJPs/GnXvuOy8vYdpThCBFMRbX6gjDBeuZGydtbQExiIH0C8fpmapa45/gKOH75wbMcbeGzs5arwwm0LM4zrMke2+DWg3decoqCHimd3CYzA5HxQjQsc+Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ndlKJtgp; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/HLbM3/sFt8KTRf46rfovlrtqeJx2C3QJGxfu2Xf33+wda/8l8Zk3aLQa/wwJmsv7baViSRjiHyEIAxgtvq0XR7sZzaSQ2+T5XGtYTtyjGxoj1EdZzDrcRM93SzR515grnKaAuaN0CDX/ZbN21QNdbkBdQjRplNinLz09TSqlN7fZ9a8ZCUIFwpMQqox8mpmWPrquOngUFrCJWjPkdC2Iv61rRzRuyQq29TBIphJvykwVYr5SkutlE1g5Cg6G2K9jtiZrHIbjTYmH3kU9l7Cuoda/ji5eO8rXi/E2vCpCSAB0PQuvV37e9Dml/y+MGA45mQMPgVH9J0FnGuRNRsgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUcPJud1lduNOdrm+gPGDV6AdcKouB8HkpYCVpbovrM=;
 b=J0xhAfGvn7h8my8dI+P5xHNGNZThzyvT5pherNJMyssyvmfB2CTk8cjwU8Ik+ivXz/WTqs4+jEwk11sddai6lIQAtdrQvxXAJ+ABWaIe1JB2TKRf8cnCBI0gBukW5m18Ol/5uNw2xiRjwV3fhZzSmnjbpmM2l5jIQEdfPybjNBzNIapSIwfih8g6etrRYm5Oa/cc2zx1Iy4c3Haenrz0OhfRpDQRf18XWtHXQ5vx5STgIFaIEMeYcfb8vI9lpVAY4r+6s0fg0Jng/HnCga0cO1SkRXfAMdzbQNRXed3VUIs8g/3cjK7vfBuUnsyhF9dn+Utk3rOTng8euZxd1WFVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUcPJud1lduNOdrm+gPGDV6AdcKouB8HkpYCVpbovrM=;
 b=ndlKJtgp6Zn3TIZUbAhVkp/jhXJqG2QV/qfW2NpkMmG+fStVVJFVatvygQmTrWuZVLxko7MZSO0HRRo1qlnm+joYYo39M3xfRzIzbtG/VN7N2g8EW58tnU8T3Ezp27kV6n1ksWKySrj6s05l0Tomo/KPO8ipZybKpH62orlDzCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10718.eurprd04.prod.outlook.com (2603:10a6:10:58f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 18:10:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 18:10:10 +0000
From: Frank Li <Frank.Li@nxp.com>
To: robh@kernel.org
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	madalin.bucur@nxp.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sean.anderson@seco.com
Subject: [PATCH v4 2/2] dt-bindings: net: fsl,fman: add ptimer-handle property
Date: Mon,  8 Jul 2024 14:09:49 -0400
Message-Id: <20240708180949.1898495-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708180949.1898495-1-Frank.Li@nxp.com>
References: <20240708180949.1898495-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0022.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10718:EE_
X-MS-Office365-Filtering-Correlation-Id: 179e4348-f945-44ad-6621-08dc9f79348d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?MeTQMfgQvW05cXwM9g4Ra64eYKgNc973CGDCvmK+pNozhJioam4UGd/lT8jz?=
 =?us-ascii?Q?6tgSEscX/eeqByE7r8jsmfq7PBR1CpHOprhuVVNyni1wIUg/4CZZw0Se1W5y?=
 =?us-ascii?Q?q9+j1nwRuCGbiiKjRiP5eIcPkv7Y9FbUtAikfaAuMQsznnKpgc7343EKwSo6?=
 =?us-ascii?Q?oqrhTsyUJ4EaTUWIwvg/CP+vLfO1/5Y6e0ZDvT7CJzJ1gOQ1v/bU1UW1M29a?=
 =?us-ascii?Q?BvlR2S/LReR1+3UMx995S3aVu5673C9SL4+TiE66m5L5/7dmS4HLeZn7chs6?=
 =?us-ascii?Q?28dDGYaAOh1sEXo4lpDVD/UQl0WrAY7InTlWlpAfuDNzCIWoAU5n2GaTB3ZO?=
 =?us-ascii?Q?em8xG6miTZatB8bMKcw9mBWibWk++Gmrx/q4j5q1981VxfLgeB5IwIzeWBTB?=
 =?us-ascii?Q?/Yu+Xx7Eh08xcPlEWJIPoeezPrMs0eneFuxm5/I9TaCXcWT+q+QPC0Jrh5TE?=
 =?us-ascii?Q?HOQZw2DbcOUtMhvYMi69cwnNe60loZ8mvpHyuOTag/7uJpHwdxNV/rjqIMji?=
 =?us-ascii?Q?YXlKovCvlAjsnl1JvPxZb/YeAmD82szLWXiqyjEROoYRCY6fTuYPrRod4Nd3?=
 =?us-ascii?Q?S/yWzN2NWNJjWMdDf6wadN5BXRCEwhingnWzXPaIIY9vWcv+p6c31MgwPIbw?=
 =?us-ascii?Q?tNNxFLcU1Wk4NTb5Bdz6DjSyRmBR1tqg8kmavuGSEun0HTuUy/agXjLJOQAr?=
 =?us-ascii?Q?Qw8fAX4wbAqm+W+TqZzziN9pconRteqlwCIsGNYHPvd4QLRs6qRMme6R+Ehv?=
 =?us-ascii?Q?Myl5CQAhpNRiZOAtKeRFKclIZFYk0IeEL8EccjFyqXBGwbxreprJzfCJ4Rtf?=
 =?us-ascii?Q?y2xi81JAFZFRasa+cRaxrJ7o3eHGF0J7C4DyW/cdB8oAP2j7ORG4ns/68hes?=
 =?us-ascii?Q?b+oWsLaXHastpyyg8RHYpsgsyDUkzZ2W2BCEqZTqDESzxVl9gv+LF/ZLkgKc?=
 =?us-ascii?Q?004V+L+idr0MVrj9XZ/w4EgXGjbXtkLM7gUbpENPslYcQPK9GpVePbCIzG2Z?=
 =?us-ascii?Q?H28FgjhKBEiaO4B1GjCUS+nlf/0hsKGmu+DuXcmo1WRFUC23IdDUWgjrEpWu?=
 =?us-ascii?Q?NpchsgaVC2deqhg+XDfmX4xqhw2yCcawCsSjEnWAmM5Mj8AKur1CH4TbUrDv?=
 =?us-ascii?Q?R4aRgA8PctTIY6uXbz8vUB+PmcgCRzZj0bYIf0AP63aG/Z3+C2a1Um45wEMa?=
 =?us-ascii?Q?7XSFy1lCUfR2QQf7AS74su8FrQKJmh1rvGGPPCeZ9I1CjDiNAMERMAcAklUX?=
 =?us-ascii?Q?UML1ihp/hGPCyauEtLO7ufaC2VZ0H+1grcbhj7JuVy6n5hDadrJQHQ9DVRzX?=
 =?us-ascii?Q?QP1TBX6iIwZYEG5gqNsfzmsXp/GJZ023n8fhGPz/5jrXizIsW5nJTQRVliTc?=
 =?us-ascii?Q?WUo5G0UeAWZJ0CQQDUP1YuOM/bhlXUcqWoCpLK0mxdxrT47w6Q=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?LzD6TDWWXyYrkRtXPMmJpdhhrq7D6lvYDSDV44VI/n8hOiw8k7e5nwZbBJZ/?=
 =?us-ascii?Q?g84ljTBjgxzHOXBIvfAmMCiD2otC0wtTpia+xT4/P5sxloXWmDB+gZV1rWbq?=
 =?us-ascii?Q?BcsdlsW035TsM5GofAiUq8+bv07qWbJufLNnrbqfhT4jI9oJNh6N752Yyvma?=
 =?us-ascii?Q?BSgyZ21/QSd+sbPmUTsWL3HLbtCQAf2DXRzUVzhGJCLT4xWMXXj5PGgRIW7q?=
 =?us-ascii?Q?MOBGzGRfzweDun7wkrfNDJ+TWFd4P/vgeN75a66IjT+jLmPhQmWTWNsU6YrJ?=
 =?us-ascii?Q?/ZoJtzWV+t7x47NpbO4HBZHav0jsuKyCfxgUJuYsAuOX/tBluT64k4XZ4Tbp?=
 =?us-ascii?Q?lHLwqcpsqT/bswjNpEFYJdDfdbgGJrAewZAwyeUUEGRWMz6A7Ofqf91DcTS3?=
 =?us-ascii?Q?F3Ku1c1nsAGT6JRraAmcKyIoOprQOvwmjT8ADVRvtk6Jh3k/AcI8zS/PB1my?=
 =?us-ascii?Q?r3c3sES6sBAmS/AaUwtY8I+8UJP2CoAWBzh0gnrJgWSdQ2GmHNgHctoQbuIJ?=
 =?us-ascii?Q?8X7+sJIDMGRtlhiZsvoCCk6HHDAAznY0mDMstNvNeRjKXXCU8xuFOGmk7fq8?=
 =?us-ascii?Q?yyT1iTr18xN5m+if2fO32w0xHx6VUzNdhcDas+Kxv0eocW+vZeoklDU5HrrH?=
 =?us-ascii?Q?50cdSjL5Ib8uDsbaXtdgBs7eQVzGHAgZBTTIJfPxjqjTC8ClnPIZNGJx3VIW?=
 =?us-ascii?Q?7tgLLGePK/bQDeraqZuV5enxo+L3V2Ubv6t4xJA+l9DyEtVs9b7ctkR9hijn?=
 =?us-ascii?Q?BfMmjXmHMxcdwsJWydE9y3IX49wNupAmOnFcFuQNCpz0k3FOE8nlFrXXN7A5?=
 =?us-ascii?Q?F4GoypmmahrF4BALzR+z+Wmp4iXX1SqR+Ze2Yv6fro0n27PaFV6y0H34Dx0Z?=
 =?us-ascii?Q?2SFo0pBCXrD2bjaoMOpyOWTOk3yr9uF5qDrhp2DWxH3Y5oGabiT4FCIPCn7z?=
 =?us-ascii?Q?riC52pQzFzbMFYIepzhWLhyszGCIWP1HfUVstnyKUl9q5QR1SpS/UMUz+5Um?=
 =?us-ascii?Q?p4l7wkTyRv91AxdAppw9osdvu5aMS2oGviaCndef2yYUirm1Lw9jXDsBDVs9?=
 =?us-ascii?Q?T55vm8xjeaL7wFA/JMNp0MGalotg7gODHfYJGDaN7pav1JFiFbWSqnyE0qx+?=
 =?us-ascii?Q?N47oliwl7CmSwMFEC84LCRkXHnr0MoeSH7H2SSzb82Fh5FLG7sVF58z03vN9?=
 =?us-ascii?Q?yxVlotEvyUBJ5S8R2vpUiYyQViWGTTblJXisxYk4k60TW+5CbDkojOyQKCg5?=
 =?us-ascii?Q?6gWQLQCb/5KRmvMkW5Tle94T/azvAWi2GmjTyonzOal4CaJVGggWfYrynNQ0?=
 =?us-ascii?Q?S2IyrvoLGQPJS5jEc7SgnsyOW5+VWzKG6EnWuBUzGAmNKg7DKgURrFnzbiTq?=
 =?us-ascii?Q?doomk5TsVzGQgr0yKwepw2sjkolUF+qCPnrroII9Lv08Bhlb6gDZtWXLPQC9?=
 =?us-ascii?Q?KxEHbX/elPmUOUjs0y6DEIvIsNutuZiAz2CqrWKKmPvB+/R6d7O/THcgs/er?=
 =?us-ascii?Q?sPG8V44jVwv3mOAik+meQA3VcLvoE07oAuDsPLQ5Tp5Huby+EPIH6vYM55rQ?=
 =?us-ascii?Q?7DsvDQj3fq5ji0NMqZ2DPaE1TyCNdBMmrJbcdMey?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179e4348-f945-44ad-6621-08dc9f79348d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 18:10:10.4236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qps2UjcZEKEz55kMZHhlQPTQFpDwLs15gvL12IFqPdcNNDd8IU/iNy4ecM4S46D2Wqj+u/r+2jeZN/YXGlK1AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10718

Add ptimer-handle property to link to ptp-timer node handle.
Fix below warning:
arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: fman@1a00000: 'ptimer-handle' do not match any of the regexes: '^ethernet@[a-f0-9]+$', '^mdio@[a-f0-9]+$', '^muram@[a-f0-9]+$', '^phc@[a-f0-9]+$', '^port@[a-f0-9]+$', 'pinctrl-[0-9]+'

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v4
- none
Change from v1 to v2
- Add Rob's review tag
---
 Documentation/devicetree/bindings/net/fsl,fman.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,fman.yaml b/Documentation/devicetree/bindings/net/fsl,fman.yaml
index f0261861f3cb2..9bbf39ef31a25 100644
--- a/Documentation/devicetree/bindings/net/fsl,fman.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fman.yaml
@@ -80,6 +80,10 @@ properties:
 
   dma-coherent: true
 
+  ptimer-handle:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: see ptp/fsl,ptp.yaml
+
   fsl,qman-channel-range:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description:
-- 
2.34.1


