Return-Path: <netdev+bounces-115412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 669589464B6
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 22:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7511F22733
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 20:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE6F50284;
	Fri,  2 Aug 2024 20:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aom0ps0K"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5767D49634;
	Fri,  2 Aug 2024 20:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722632276; cv=fail; b=ZGTdJiHjApv269SuU6HIrB6tI4Wsmew1AeEdQEtthgjtDAJ/zyLC8zP6b5gxzWqLIgLDXdCH4dPChYM3uOlYWGC14JXj+GQu8bfVjbbbE0wwLIFaA8IpcV0F/04nwhkennYmODa9KnKWl5rhf/ejT/YFpy5HEipyNcDsyXomSXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722632276; c=relaxed/simple;
	bh=ZGr2sR7a9klhbq7MZaswE9Si7iQqyvlBt/RPordgWbs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=c87IjTeUv1Z1QghYxAYD6DeLFo7NcFITHHIVDMuVUiF54OKpJq+xFcEADqeVAS94j6UCMMjXiBT8KDKaSV5P4Wc8qxkSRQbsO2WvbLQX9Wl124g4vcYo5pYS34klILbgS1VXhBtgOikY2lxh9zU4kYlAyvgvp65ifMTpnyZnkT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aom0ps0K; arc=fail smtp.client-ip=40.107.20.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEtGsozKjCsLuU6CpHbThhZCr8ksjSaXtcJuYnGbNnm5EgXLmoVRmdgoZ1KOow2BWzg9x+KVTTAJs1IQoTGfq0XWiCsHVzBIc+D/OUL675qsp0Khj7S9ODouszUXOu7zwFyAlS0Zybqw1/IuyXbD/UsAuq9bVMXq3Jb2ebhJ0tMhuDf/qof9W48ZdL2Fn5IanXJ6CYE28A/mXOmgIMdA5s+Ve6ERbGrnzR9ArOSqVK9p+e26fSesdU9A9NMQxerjfnYeDjNX8aUy5OvkGIeyXYIIovv6D431xxa3Kdx8Qu8ozCgCTOCJdC1/kMe7TeKnyRHS0ATC+3F7LC0JP1b+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKM0QAU5jniVJE9PxHU6Pi2810RuHxFEXOR8d2r6plA=;
 b=AhAVD1aqlmOdjHBHLUYlkYaSKSULGJC8aw0/n7ymVcxdsKLjnF/+RTUnA85L4bYGpFvXiESMVihTHD+Gwcfs0BX9hlYHAvxHaoVjL3XiV2IIXO8PCxVxB0xmO9WpN+CP9J3VbSM6VkwVJkNvh9Kdh/WFIedEo9DlxZPq7MixWnz764RlJN6YJ/9pjvVoha+Ds770cxIinMkbO/k2qCHr95aV/uOL3dqhm2z9trkwX3/rvw1x3EAMH07kIggLm/x9mWvG94N+mVJQfsnLsP+4Mmc2tiFMzLUsGK9NFmBJxgbjn7b+eaLuIDLQULTb4Rz+FK5JmzoEV0QvSNunO1D+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKM0QAU5jniVJE9PxHU6Pi2810RuHxFEXOR8d2r6plA=;
 b=aom0ps0K4PYBZTQBd3ljnHAL5cBHJEMTjCXGmBzmTp1HaR9IBYW9vMzxzyujZJd/tPsMpCz2Czgz5ar+jEQGs+J3EWHXwgfNVhRuiroJzm6aRBsWKM9rj4gSrtRKU2lqdaciwXazAA9kVtbkRwkpBJVWtkhoMiV6urlHFlFpyQi6iEQTCU9mx2PVg7w19xTQQ7UHPviiaUciincFBDV+Y9BL7tUOLAtrzSMpfiEQPHZgSdA/aHtu+/5uV41UUfI8wz8F8n7/SNaRvNuKzetknn9j9i/6ufBW9/ek0mc+dyXCbFPLA2y6UM7viw+gYSn38QuBDIuViKkrR56heBvpsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9323.eurprd04.prod.outlook.com (2603:10a6:10:356::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Fri, 2 Aug
 2024 20:57:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 20:57:51 +0000
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
Subject: [PATCH 1/1] dt-bindings: net: fsl,qoriq-mc-dpmac: using unevaluatedProperties
Date: Fri,  2 Aug 2024 16:57:33 -0400
Message-Id: <20240802205733.2841570-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:a03:255::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a58b1c-bc18-4be6-a990-08dcb335c580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GJgAmitiJd0xQGzAPzk2dRD3xJMVIWeKVMpXdqD+a2VcpsQ+hFS6IkD5+/gL?=
 =?us-ascii?Q?/bYAX3ND78HaL/Wi5x4cE+oJRjJ8bST+YAeFppO57BiWNrNIKgqKyyOaV401?=
 =?us-ascii?Q?kzCg3safWTR6ldImoXSWuGMQ9BcAH4qDaVdG32X66wBL275AsMpyhRFOc99z?=
 =?us-ascii?Q?rXVdM+uLrtSgULN4ILDpTSxWO1qHMVCqYOlvjhw3OwJVA3QPOg+ixyqYAQpr?=
 =?us-ascii?Q?Yv6yovmi+BAcvLSpbvjqYL7g6eH7WOSsL5XZoTszTomw7H2l4gqF+Smpzycy?=
 =?us-ascii?Q?VcCvc/JB2KQrozgL4G8EyLYXymRgacOhb37Fk7lu9Zf2kkF/rZuLq0yAoW8H?=
 =?us-ascii?Q?EW1FceTkYqlFSlXF5MJybEOmbtu32HXGpRZv0731KtrwmnRuphHR1WQr2hKZ?=
 =?us-ascii?Q?FEggp++wbt3CUI8bfvF+34ZSlcip8RV2U9f4tm0UYyQc+OAv+ixtmZ8MY23M?=
 =?us-ascii?Q?O2TquZofwYh9pkJsYqmfKR5PNyAX3/NA9Cxck27Kuw7NprrNBiQEqfvf3wdD?=
 =?us-ascii?Q?tVKr8P3XEL5cnEMc73FaFizDdzCZ6hE+dExm9019rKtCODIbgHDdbtBeBuUK?=
 =?us-ascii?Q?oKBZqEzymnqh+neNrrboQsGm2DaG3ETGH+IUEW4bfwOeOAOTq/Euaw0sStte?=
 =?us-ascii?Q?FQ5MRygO1yYmCxHlP4WFGAlpEgkg0qMBfT5dZYlEPhLqKaYSuyur7Q4DE38/?=
 =?us-ascii?Q?cVNs23sYxX6TbDD9khfM5VzAYTB0L1Ft2FyOCt+q8wzfdDmtnWzSApgswPn2?=
 =?us-ascii?Q?s4c8ZZS1BG/NFs/1oPQ9AG4BE0yUfp2UCew4PKGKCMWFp5IDHu8+0n3DI4P0?=
 =?us-ascii?Q?6LOUBoISEPQoUEgjSw7dYXpVid8V6u7eZNLObax8FFhb4sdEr/LuP4tRGKeb?=
 =?us-ascii?Q?FqjCwYLd6HrmifvEu9NFTpcw6igOzvvZbrkaNKGOuMmSIs5aizs8qu6Ec3zS?=
 =?us-ascii?Q?kWbmpSTd1OtTMVY9pAj8A8eK0Bz2hYaMg8tCdBfuC7v5/uZltH2prPngP9Bt?=
 =?us-ascii?Q?j1D8gImOJXRcwNTqyUsiF3v9s1VDugTArAXXHXkk3vXhI2SFsqpIJmjXtp2D?=
 =?us-ascii?Q?HlbLHfi4lLl/rgycvSPtvXOizha0PuLQ8jG73PkkemOCIYljzGJwEKPkPKkr?=
 =?us-ascii?Q?H/65EZWevH/iJy1Wo/jOEZSZ1GlxQ3WjNgZnj+UcGA7wdLMP5nJQ9RQW132h?=
 =?us-ascii?Q?4sYCfqkUz7/O+fjq7zLaHDEjROHkSowzg6AP7qj8t6fFRH+JepWnK577ep00?=
 =?us-ascii?Q?NBdLZjpA1KtY6KUUzhyK8vCet0EU+oSYsM3KFLy762DFz3tHdpug3YePMUqC?=
 =?us-ascii?Q?6bAHHbFy5igM3gHM2pzVt499SpAa3H2EkzHhZFFE+/pVzU9+nxZhMoP2SvFt?=
 =?us-ascii?Q?z6FjWpOZq/E2QGakEyJZs2QrAo9Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2CCHSFzLZjQiq0xf8hudDRe0+EpHMEqoY4lDPSO/UAjFUeTSHMTc1g0FrL0/?=
 =?us-ascii?Q?yCxtUhlfaiXfNSvIE8RCBGhuZ1MtkSQn5S/g+XuUSKtDNBB2jMJvDqfqvDZB?=
 =?us-ascii?Q?RUsf2ibQytcQmlnXsVMNGvzy1d3Azcfy/XuSYA6JEs9z+03wS+SuYMc1/EEf?=
 =?us-ascii?Q?5XQIdlYYoUJ2GLVfDjezohQbCeyp+tB5lFcUNoagkTusDguuYaAJyXdZgQ6g?=
 =?us-ascii?Q?VhMoNMzz2wpsN38gtQ7btDO69QBGbiAkMNQ6MBjvIYdn0aggYysyMpcIby+b?=
 =?us-ascii?Q?zwUpeiWjadqwHrqqrgEDMcfhLQWqIeOunhLHM6xexlaPjIzc87KfcGFczXMq?=
 =?us-ascii?Q?GeYRG3xgYXaq7PWcYRUHmirsVSLp03zqYIAe6Jqz8vZ2oiq3Ox+nC55YXoc6?=
 =?us-ascii?Q?oaZfYmsXYAzdEPXFclJQH+WCyl46/ACvqaKdAo4cApxyInpl6P4XbjeSAbAZ?=
 =?us-ascii?Q?W/2+9in/F2UfXyXZxBSy8uUmk/e53kmkXbDjQkFJCl4HCG0Bc27/HbiaBrtc?=
 =?us-ascii?Q?DuiiJbp3KPOLpbBrPVThSIrGY9Py0jU+XJ2lH3hzR43JSWqf7xd2OzTZlHg+?=
 =?us-ascii?Q?PYxh0AkrLNv1H76tAe17xYuO0VJ4K04LluqDPcQDWaNhqDP0f+LE/hTBIxUU?=
 =?us-ascii?Q?V+e+YhADo3nJWBTP3HpLwkyitxPkDCcD03lgeNLm2RikEPgoudmXxEv2zKHD?=
 =?us-ascii?Q?EYC033/7GfS1ZfPie3eWjqud3BB21c8aWhGdWyrhq2bR/66OanALcP8OdSGU?=
 =?us-ascii?Q?p+YdXchZKXJlPaFH1HxYkpCFymfiB4oncZaTnlHvN9nc95CgLM62Zw8PzCJI?=
 =?us-ascii?Q?zzEX7EVuF4iMIXUCJZ6cTK75OIkAlFYwjOkMrMsuUG/CrvQJFHUnYBacfHr+?=
 =?us-ascii?Q?9u1IYYtR68UbNVwuqsdUjT5A0Jilcrnp99mxAzAd6H+QEIHlbN1MJjb8v32M?=
 =?us-ascii?Q?IE4f1m0D+ElQ5UXAezI0x5ZmqCBS01u+rmaQzaf05Gi1y4SbxvVVejUscGp1?=
 =?us-ascii?Q?zFn73iWd6ek8ebssnrer+4KreiaSvTakaOKA5Kc5BOlyBc5CYwG2YaEEFeBX?=
 =?us-ascii?Q?4pBFQK0Ad92fVG9lQXcGrOkG/uQQ/PyrlS/KTU8BvRiW/xIZcvT8LPX57NCs?=
 =?us-ascii?Q?ZKlFng7Hec/SgpmAihAK501RMVng19ZaTfDMEx4M1KO7S+7x2pSapV7UqGZU?=
 =?us-ascii?Q?FWvpLMi6KHXy1r1QkAbPxvoWlJObUgPhIEUeu+ujn0nngS22cG7u897mn8yD?=
 =?us-ascii?Q?9MP/ywmXJkA2xO8ogyU4Zqe3SGryY5U39Mnauwr74JuqlJnu9VW1O5FNRmRa?=
 =?us-ascii?Q?fhZBH9Wy0FGwlTzZGgH1Ut3bGnb3cSG0jN8o5HZDhmxkqPuJJpECnDtBgQgy?=
 =?us-ascii?Q?k7fpbX9t6VY61UJmjH0EE9srw1eaSoWJZ3DAiWjgv3U+AE60U+OGLfRvGnG2?=
 =?us-ascii?Q?oVt7lZ5TXML1c0rJ+ymrLKK4EJqyULmWsHDZYgq3kSBfQNN99myO3DH5Dfld?=
 =?us-ascii?Q?1zjTPc4a8CFXM3QjQLorRQFAUOlwAcDeeqo1iwgB1WlH3cMNDfGH5rkSHLyy?=
 =?us-ascii?Q?YLB4kLjyP69T1hKP2Vw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a58b1c-bc18-4be6-a990-08dcb335c580
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 20:57:51.0807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLoI8Ll3c8B6ti+m275rj7GGI0Q3WFuGP44LAXJ3lx2E8zLtbFn0FZFylQpBrbRRvqUV8tMBDOEFAgE3LRfEiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9323

Replace additionalProperties with unevaluatedProperties because it have
allOf: $ref: ethernet-controller.yaml#.

Fixed below CHECK_DTBS warnings:
arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dtb:
   fsl-mc@80c000000: dpmacs:ethernet@11: 'fixed-link' does not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/misc/fsl,qoriq-mc.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
index a1b71b35319e7..6538e0ce90b28 100644
--- a/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,qoriq-mc-dpmac.yaml
@@ -41,7 +41,7 @@ properties:
 required:
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1


