Return-Path: <netdev+bounces-109287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2268F927B09
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 18:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CF11F22281
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC811B3759;
	Thu,  4 Jul 2024 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y2qrFUmh"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34C91B29DA;
	Thu,  4 Jul 2024 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720109879; cv=fail; b=eO0HCHU9TBHeeQ6guwxrmfa5mBCaMSDq26E794nMhA+Cspe8h8p8D0SJPRDm/qSoJiQHr1tVb6n63I5SEfZH7ODEmuoIiXxCTMpZ1H3dpinZICNfu8kjOVMyTyStrubqxSTk6hRM8X8wMiyVnb2ilJJKTUGnfdAFzp+JhZwPdZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720109879; c=relaxed/simple;
	bh=rTJRSzZo3k9frv8Ixws4rScybW5Ts7eBLYlARe+bykY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jRT4/Oomxk1QFwOzqIzmscF+tz9bgAedqNXUf36BuWbZvPa44a2KEiASzE4NBGlQ66PJ7KjFpXYS0oGLj7R21Dv4fZLPMW4k66gNNUi1EAKQuMiIP65lrtcX3SMeA63xsE52YbXswSpZr++9srDZhMBzMVBITj77KEGLqy9LAFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y2qrFUmh; arc=fail smtp.client-ip=40.107.104.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBBb83DwI+gCcK4fTiVcubLL2Fv9kvZ1U3b3XarzEKVL/etz6uVYE700xTtuwbmnEa734iTCJpTp5vtViO6ycH10iUvYmr22Ng1F+FZH8D6HL3v+eF53nYCWqWjJMEbn8k6rLTOvGwC7toj4HqrQRinogN7vgjqv0nNp8xkw/6EbB1zqPRxxa3IYwmZojdqVTGDCqfXlkpQlZDa10rfg3IB83FufsFfawzmX9DuO2oUJnwYVh8fiKQeO6oAXpTHSPngIfOZ9R/E1oXWYcHlPD/M7RhaL8B+XHzQLij+ltMjfGTQo/Cpo0Z3mlDKG/I5bzQ1KpFrmeQP1QyYmtTFfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbuZkPQSyVAb/wARwesuLl3O32QGI/g/nqcE/foJlrg=;
 b=HJi7gusaFOOIdZVOoYx5tR4TZfavFploVSiQkOtp1HvU2qAi8IuRP/OKOM/ZjWByF0c16LCQGQZIFBamzPddIUmX4lGqTYF+fs1gp3GUBFS36UUbOW32/5CTLNsVTWPE1oR+AFhFHTuht/rYlNJXW2v3ZKImdhWM5zoXjNN7+pRKyfBdFZdMfy+pGEY8we72d18lk/F4wDMbAFRzpeM2IGWLSaM2/zQyjb/84vIKYUG9g5DiCXE6P4UTfxNvl3T3ChnOBP3Bd1TfTiDkAfSa8abpnRyO94ZigPFZlyWw9PilXFkwEBlIzCxzQfJC0b0CrqDNOtSmx3VyGMpdbh66tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbuZkPQSyVAb/wARwesuLl3O32QGI/g/nqcE/foJlrg=;
 b=Y2qrFUmhPTa3EspF6XdAxEi7a63LKBqIdUDRgdbyJRQ0GMUxeQqYLDPzKWFyk8yL12QZS9ne/mv++PWtFcv6d9ocHAflFU/DVP+XWADQvezDQohr9tvunW0qHYWrIQbf8tPjYGFKeVQTT//W0GwyYctD2Q0rRnV2Rec9UcZYmsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7992.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27; Thu, 4 Jul
 2024 16:17:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 16:17:53 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org (open list:FREESCALE QORIQ DPAA FMAN DRIVER),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v3 2/2] dt-bindings: net: fsl,fman: add ptimer-handle property
Date: Thu,  4 Jul 2024 12:17:31 -0400
Message-Id: <20240704161731.572537-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704161731.572537-1-Frank.Li@nxp.com>
References: <20240704161731.572537-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: edd809d6-4413-4da7-3cd0-08dc9c44db8e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?YMHeTm294ltDKBhv4IJoo7Zw/6W4WQ//PSft6pcmbt2xGU7Excs3B/4j48kv?=
 =?us-ascii?Q?ov8c7cPeII/aBOJaEl0GqaVkuLIFKb84fVFOGpj8486cRfcebLbUmCICkPIM?=
 =?us-ascii?Q?Uvr6VBLkkfNzaTWIYK8TLgc5UJHJP0DMXe2SPwV33UuRRV+RwP6o2WOzJ4Su?=
 =?us-ascii?Q?2UOWLBUlUP6JYC1pOVRH4JLZlK3pfDlm6YvlcYxb/Y7CabwtFQngQIp+u8eA?=
 =?us-ascii?Q?RuaAF0kA9uAJT1JmHydXi94mUKxyOjeHmvqdfjWU7y0h7o13ii/jtr5ULbbA?=
 =?us-ascii?Q?o+arXMvIbXr2FRocwOp5ylUWiSGspD4b5D4etbGnb9n6XGpvPfpuajEJG0YH?=
 =?us-ascii?Q?ta7ITfAVfJw3tSRB/xBdieU7RrjQJ1G/lqFBFi0lbysUNT9MHPTM5uOlJsXy?=
 =?us-ascii?Q?7SPf/h4mfyg0LgKy0ozTbgc32FchErq9IWrsUmbRoYCTarW8WHybbH+vd8Z3?=
 =?us-ascii?Q?IUYdWbAE6Gpxvxx/DHnKGdC0GWfFX6S2E4qdtu3wYm0OauUFlfdVSlb4AKry?=
 =?us-ascii?Q?Ik9gVj5pzEf3eDOYFfIZmhdYZcbBF5cBe/3Jy34my+LBS5cjeJdvS5MI2Ysp?=
 =?us-ascii?Q?Du5isAYSrXGgAfXBoUOeMvfNSx/B/sBGl8ESY8H0WGqlK16jIBoCI2dP6JNJ?=
 =?us-ascii?Q?jmDIV0rpUrbpFHjkmoqhE8Vl1yFYMESDpKbrMhOXtPZ1gL9OaIIU9P3JppC6?=
 =?us-ascii?Q?HOlqscMCXhlH65InCTVNETvb9/NbTrljujqthd6HMqLd4+bqn4FDAznlnotA?=
 =?us-ascii?Q?hjEiEmNyb0Vdml8/P25HcxYWeSUQS0Zui6yK64AYrwyvZjZv7He+1eYCK6Cc?=
 =?us-ascii?Q?HyWJ28rH8/ouGuij3KQtWmyjUbcuEMp238PHMFUgBvY42zZUfpFjVqr/x1I8?=
 =?us-ascii?Q?cIM62m05Vy4+SELV8MHMOwMX95SFMJUCqcmSMoupYo5Bd9J78hWWo0ZbXSxY?=
 =?us-ascii?Q?vZHy5XA0ACHe9Iz/Vjey0wTk8N0ckgTTJLWoXNLMa8KxgatEh9WbZ6IoMVo+?=
 =?us-ascii?Q?KgF1N96ad4QZJDktbxQbj66l/N1rtjVpF9Heh7xtvgqGB0BvtRcqedieh2OY?=
 =?us-ascii?Q?BfFzfGSdLDxGhcNfdUyknBkeNwdGPW1CZwBLwkBqh0L1kSikgO3BMbAmQ60f?=
 =?us-ascii?Q?qTo21kQZAO3ogAzYSxY+lNKxZU43hM5Zh2kQfV2qQvPqPfoP8tgisSH6o/2q?=
 =?us-ascii?Q?SGJsk+QIo9xkLBTxZXYQtgmZJLRS0tCmG7hZFSwR4Q/4kn0Ml4yBh5mcHHSF?=
 =?us-ascii?Q?BVkp7eObe4LVxJqI0sgXQnsekTW7rr21xXXWPM+7RmXK1TTG0i9sVh0rBWQO?=
 =?us-ascii?Q?igy7DKeXdyDY4bF06kRC8R7RIvKUlkvnrGWjxE0VRdaap97DHM+wZqywFdk9?=
 =?us-ascii?Q?kyIIw5OCIVsiP9LEZTp2EeSyxHhwq18B+7yFxpwahIWtWxB4oJZBy5s57Kq2?=
 =?us-ascii?Q?On7FjP1C4Hc=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?tnNnXXf0F3GrsrrDKgCIjA528kIil8fjAQj1MmUy63+QAO7VAHqFkovObeVe?=
 =?us-ascii?Q?k+/mfthxIjX+X34IH3gDt2FDyo7QNNCKwuJp6RHF837ORhBdGWsEvOzoLj2F?=
 =?us-ascii?Q?NccAzh10gPYVBYvAHotwiI9PVkjt5KUC7E0uEjQyQIT/4ydZ6WhwPl1Lw2PL?=
 =?us-ascii?Q?oVzWnTKSPTOD/ojFmjr1OK/CVUdKVlYjT2bKFsy7A+wIraZMFm1Dhj/rSjXK?=
 =?us-ascii?Q?BwvsR1bTBoXIq4mmso7kXOA2ylHRU+u/2FO8oK2LHP/G6eDFDN8Ufl9/tIah?=
 =?us-ascii?Q?CCv4sF3hvFq13CXWU30vi0Z+eMnN+eZ9wcDdiFW9HACvSAQCAayoHs1ew8Mq?=
 =?us-ascii?Q?VBy08BJeUVH5j/yp3B9QF5n+Vqmk9+UTanH3SUuvvgn1VDAhEppqmU1FbXA8?=
 =?us-ascii?Q?70kao2VgjgGAtQ/fxk/gefxd5LdgdvRHjZanQRBx5/ZFdMSp7tKWUz8i8QHP?=
 =?us-ascii?Q?YLIdDc4W5hOPZb6/LAnoQNW5LzD9A9bUAkUvvOzri8RSNWBZY5dhvJPVYT1u?=
 =?us-ascii?Q?n/XldEJ3Ufjk7LzrBoiv38Cl737h7J/BAorct2owSM/tKfBxKgKMeO4JXLQy?=
 =?us-ascii?Q?2Z5wEPjf3kDBWkFL5ECOPNdEnUS5HeOy7lVxH4QwSjcSCyaYWBeaoVndgRED?=
 =?us-ascii?Q?o5FI67gVC9Sb6tUcI7ES9M/j/GVMtobj5axr31XswIMcrQ5LgiSeAr9B5RkQ?=
 =?us-ascii?Q?v7SIPDfgZSHSTS2GeOQ9BP4/d5bKhbiAjoC1V9s7vs4W6J8xXggj1FH49bXv?=
 =?us-ascii?Q?CxsJD0lDaCWbTTCvvzTYoAkLHiayy8DkLYS6cL7jI10wo9/TtTmOpAZTwQr4?=
 =?us-ascii?Q?i8ZzqGFCGlAFxrmaU1RMwiC7uVLRsCZOfmWcZYAsXR2FnMjWD45bybu7tLTf?=
 =?us-ascii?Q?icx9S6PkS29JiNZTUSZNLe/ZkZx6i67qBwnrQyEfdphU59A2B8ICrK0yTedm?=
 =?us-ascii?Q?d5S6Esl15LmLLtYAD0xclX8mwQOCT6NPDuTRiUV6oGKCoSbIMggBTrkUuqT/?=
 =?us-ascii?Q?d7ympXe5pQHbI7CfmK4cYRAYd82Opq7o7UXJ4MBvVKT5uUHmuua5jo1Abqjv?=
 =?us-ascii?Q?szFpzImt9O6vW8kKCvb+NSTmEYdiha4Fp+iy7mh5fiYpnyjyrPlKAs5KrOu1?=
 =?us-ascii?Q?LLv0GYy/ZUHYT6oLEqdq8IKdMj7CtGvyNJXvsheafaaROHG10ZFR1n4oWSKY?=
 =?us-ascii?Q?cq/SJ2V0IhHC8hjaOXGxshh5gQ0SWqcY25oa794ADOXOLFMD1gJ3NmZx9ExN?=
 =?us-ascii?Q?hHk7dTU8Kib+/mK7KBUBpBb85H+uMwuw+sLqxLs/7SrTmTaq5ap1CFX/vCIt?=
 =?us-ascii?Q?GNo7aCyol1u8G2JGkAOdRd8GBlrDeZpY1G8553jXyEXzeFLXPP1sgyiGD/Mu?=
 =?us-ascii?Q?kMspeo83H2moSii0nE5fdYVkyIlRg/I+8Cw/TUNoHztcC6LWIynPPvs6Vhvc?=
 =?us-ascii?Q?HYAX29lx/qJSd0Je97NUL/YRGL7V5bRItCQaIwmYp5MjKqubBx9KDqvsbMwr?=
 =?us-ascii?Q?ILE8ECI4kx8yD6nNqYcqiNTpwlZn3VN1Hyon5paMVex14w92/zbV3tER32mW?=
 =?us-ascii?Q?qy/2XyTvKOfgcaXrezp0kc89cZq9fjPMWHGi1sgQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd809d6-4413-4da7-3cd0-08dc9c44db8e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 16:17:53.8146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGoHbCjrKqzZb5dJ0a1h8+gGE2a0HypNHA60D4G78b9ypoBa9zWKBP4ymEfnk4BmoDZ4XoOdBMZqRE669JkqXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7992

Add ptimer-handle property to link to ptp-timer node handle.
Fix below warning:
arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: fman@1a00000: 'ptimer-handle' do not match any of the regexes: '^ethernet@[a-f0-9]+$', '^mdio@[a-f0-9]+$', '^muram@[a-f0-9]+$', '^phc@[a-f0-9]+$', '^port@[a-f0-9]+$', 'pinctrl-[0-9]+'

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
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


