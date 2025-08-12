Return-Path: <netdev+bounces-212846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1F3B22414
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4ED63BF183
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E382EB5D5;
	Tue, 12 Aug 2025 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MzR4cTiS"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7932EB5CF;
	Tue, 12 Aug 2025 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754993238; cv=fail; b=XIDplN3zVoDLxd64P+fJ6wUD3t/teuw4hi7rvMCN5AxPk+01QBHWL0jyOki5QFbpbbmowZ230khiQzEY7KnjM5ZsXzLtrKtSlRBrK4h+D54QqZs8PIbNi1BORAmnhHqOOaoZXzzmbzxRysQJ0AljBTpWqc5frJ9JgMQ32JBvQsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754993238; c=relaxed/simple;
	bh=UPStruNsblxgi5aPuTiaqGDK+2FGsSrEHomenS1YlMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h9Yg4LNPdG+G8OBGEqKPquPVPgEJeb6oNTY9aNjnYx3B8/SglpHF4Cwxghs/nUFdPduD2AXmZEpNIGOxy9DUhiQYUMYSzku7gq/E7aen1By/ZBQ7LN3sF7Nk+M3ThKXhm/mJsiHq73n5SGJOVXHLwbKe6Dvhs6t9GAcxP0PMDFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MzR4cTiS; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aU2qdokSN4DjZIlxP4TFLz4Gf/M8sZwyfhKXVH/f5Zi49vQRy2UUTyMH5HDtultDUJ2RzrZ6IVaSYb46wMtIiML8e3VfNwx1TrgJpsl7Iqdf+mtdJefXdZpDQHrUY63GIvHYN5F6o2Av1bnthio8l5ZEJcv9OT5ucZl2ASIoqrguy/YJkexPQ+eUuRNjSpAiiLVJERM8CWgb//krIhINuv2wQAaqNXHmgVxpyln+bbYnybKHp+ZyR5Y8PD7V2tQYA5N5WOVpMoK6ujRTq7IbF7jBFemlBVQ7HA/naSH8UzqYT2V3kNzdpKKokmIbOl9ir7JMMdtYbPNYLvVZeUvCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEa58gHYZHM3dS5UinJ4t5aLhAgqTHhckQqKzlRYAyI=;
 b=n+ciwOA6zg1LyyXhmIPFPDNMxcW/QAPpqNvv6OzbT3blE99LRtjriycJhx/YEpn54c+QsToBb2/QpXp6sPgJ4Sbznc8OHHaOReUSAKoZkTsqcnktpwhXRMz8Q2hnhcqJQ9pkv09x9jipib9tV3Nota3u287YWV0DgdGJwa2uCAjf+/t1FfuSnYVnXJCXwnHPKJeVQ+7Pm/PA4cdxphUqdtfjxpSUXRcyeOn+l+2U34jahnjZP1y846TYQ3dle6c8on1m4f6gLyq64BA1XLaV/upxyFPh9YTqZzltWstvdoAA9tfdakA1h4Q9makkOjjky2hGKNFRFAa6RESrKQMhxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEa58gHYZHM3dS5UinJ4t5aLhAgqTHhckQqKzlRYAyI=;
 b=MzR4cTiSjlkoua2PG0BtDHHvY7WVAlKDKRk/B3VUEe91IBWrwv5G4IaNFZ/xEedCHht1d1B2nw8GdJ+Bv96AUPQVr1P3stAIPMB/KxWG8LmmGQyPFHndL9Il6vnlk8mgllPVCgo8iIK+YZuKKQ5ZBRj5sXpZosnlkx1KlLtMSyBz8aQmRuG3dZSesJY3RoqN6Jj19Jx8b8BsuMct4LtcP+8QBaO7FbLF00IflFqJi1rKYaJ54j22+N3sPYn3XfUVDuV10NZjvz/S8l6DH8W6w8SSdQ4l+GNTeb71jvRZvLc99UcMR1iqHFbtu5jNQGpFb05+gQYHjs653gu+ci2uFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 10:07:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 10:07:13 +0000
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
Subject: [PATCH v3 net-next 02/15] dt-bindings: net: add ptp-timer property
Date: Tue, 12 Aug 2025 17:46:21 +0800
Message-Id: <20250812094634.489901-3-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 41275686-ad8d-437d-c499-08ddd9880271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OfXjYD5x2HRJipnJtzblvoaBRcaF5fyORFcUGYocgiFoCUyqFxLUplB/K0aX?=
 =?us-ascii?Q?+VBCONLsYJjpQ3O12T1ocTDjcrlkkKI0n7FR76JXNGtv2BndTswQVj/OHJj0?=
 =?us-ascii?Q?wcMM1f+BBpooLcchgsG8FxcbZ337bhpPaaC/qLrmvjj/fxOigi+1DoOln0+K?=
 =?us-ascii?Q?HGXCIYcJdkMOAPjxtzVj+2W1h1XrtZW2RJ5IpkNB7flJT+WobhXwnqtJCCf5?=
 =?us-ascii?Q?+jztO9kcSyMwaoMri1nJaic/xAEfyDslnUjnkeR4InL4iptTJV+DVfKgOAWs?=
 =?us-ascii?Q?R/NbZ7OU5yZcVUCGqVnZC7i4+8JpyP+bZ6Xx67VBHHjXMB8kZGKjWO0rRDDQ?=
 =?us-ascii?Q?2ESZaUceaLQP94j8AQmsLx0iGtFaSJW7a2odKTbQvn4E+jtWRZWY2Td1wERO?=
 =?us-ascii?Q?66QIw59IPYtH9YhOF6airXo0uiyF+1Pai2SNGqjlbrcWC1wos/7MLP4Tc83x?=
 =?us-ascii?Q?d/utt/G2nUUDQYzOWdo4335PwdQT3Id7Z3Essd+sdc0ffi18rw+fX3jhmtWl?=
 =?us-ascii?Q?REmPvLmHcqWiJL6ik/TfPs7d+wBW0Vzh9PhKe/t19/yHCoMcwXV8U0q93kq7?=
 =?us-ascii?Q?x8q4JQH7el4Bqoymw1QTumXPdWMaiEfq0l3OXz0aEPv5HTv/n5TxCPlY6RzL?=
 =?us-ascii?Q?F9/Et04qWDN8mTqd2vuhylobcREgMh+FwksYpEUyV8tHgHto5icpynKo8+La?=
 =?us-ascii?Q?QFrQ9xAIINlYrC8NvCJjDlGKYTVqxxf7fXN2KShGdflhU6390amkmQvFhdfD?=
 =?us-ascii?Q?+7+J4QwNo8Q42KRa6JgJ2X2INmMg+YWArxubxRTbP4mpiXHV7HjsMKw1aiU9?=
 =?us-ascii?Q?xiqomZYm4SIGlmE47sRRzvI936Z6knsT48QeHolUiLmIFOwN0P2OD1FmmMoK?=
 =?us-ascii?Q?xps0adoFCGyQW4MzHFQuXMSSjRc2OgrDiS1Ud5QKQz1N6FM3pjHO5KP0ueaB?=
 =?us-ascii?Q?dlmDlZnbcxZzDJ47AUcnlhn1m4//ceSfI2rPO6e2bpaO7MjEHtmYqs7QsIH3?=
 =?us-ascii?Q?WuVVjfpQB/jCdjqOI2jiYeSBfnbF2gsLPcQvSvnoDZacXyWb69R1Y/m69twx?=
 =?us-ascii?Q?4fBLonLrchSdfLkwk6kk/SApLeK5KTiOO9y5pj6baYPri33UNxtmO2irZ3mG?=
 =?us-ascii?Q?9ayv0W9TrkXb6gsefJjzefTTri+Bd3m4OkfIDFvkOA7kIuRkW5j82aOsO+D9?=
 =?us-ascii?Q?y3T+8PZ0lvXG6mKFkRTjXTheT7Vdz1Awbs2xgAYWqza3+MlhxrPCCUCZnPnx?=
 =?us-ascii?Q?1yTGGmHS8XYF8KPChCiQn+pfdA9ch+Sg9RN5Mb/tA316KNiwdRwcquS48PcW?=
 =?us-ascii?Q?27qFn8neSEPOxM3pHXsuXQVB8ZsMrmi0rwvLuWXhulHwfR2FeI/SFlDGqzB5?=
 =?us-ascii?Q?grXgdNIf4jdA/2UUb6EeLU3f7fgcRBPtZPkry33nJglZxDajCMPPqHXNujUo?=
 =?us-ascii?Q?WkEx3xepoDpHPqykHXYMAf9zoiAF2lIry04U7N1xvLTVif2yf9phGiIBd7aE?=
 =?us-ascii?Q?fjdNCfDUDaxivYQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N9Nxb6RbTnArU1yMam5hXxSpl+d1bxBpHTt1AsznXLvQfIbQ2+rL7XPaKX1E?=
 =?us-ascii?Q?ktCsyEwccyO3FWy8Nl3q2ZuX3WS6DIifn3iTrg1YtPY2/O/KzQL5IGgQMwQB?=
 =?us-ascii?Q?3QkYREuimBemhfwGvcqiPsLhcSL1wP7XvqlNti6pHpldheySLU3oWGALKfr2?=
 =?us-ascii?Q?AYPBdQKIbH81Q3VoPWOeTUw+ihVYt/Vv2rk/dPyBy2K+YX0dIrqAY/6X2A3/?=
 =?us-ascii?Q?dQFaso8TUTvd8VqspIXGCc6R25NoftblAXrdgAPp1Hvs+lkw/RiIjvi8LtUO?=
 =?us-ascii?Q?7HjtZMYDNQjLr5r2ZHBEY0yGG9nNGhPK/tNLUd+ofbbdwjSsQb8F0jb1liMv?=
 =?us-ascii?Q?cqzgwpm6pL07C/9569Qheab+irZ6UL72c/OZxAC774l7KFRhhxRRNVqQfrYW?=
 =?us-ascii?Q?HIXOPmgfoUDfAUP/52rzxe/sxVlaN81cyp1IXxZ4/8FWRGp9JBtTcZKyfXEH?=
 =?us-ascii?Q?D9v+H82FMCSPqPIH+YKwqoOP2n5/cYrdEjlXeNIeuafQBzz8YS8GtIGpw4t6?=
 =?us-ascii?Q?Il2Wd7CE6dZH9ESztfUfSZugB0TamQPwNOgnRAcyk8FLUlZqbIUr/1wMpJoM?=
 =?us-ascii?Q?RmZekNKztlymqIgriKrlzF9OSgpZo86dSNtQ8Iot9uRuyAW3o2fK8yDfJAl0?=
 =?us-ascii?Q?7q15uljZHMK/jgRoPXEkzyflD7FIouz5OA1FiTDtrh+ciJaWqkyyw13KtAzb?=
 =?us-ascii?Q?6J42lrKO5Y6RGDV0MUQRJC3f8sCPRnQrL81/AlX5UMMwoUVfRqIvQcVKrUSt?=
 =?us-ascii?Q?p5ROiIBY7z/WoNW4+uVWT9vq9WD3AJgbUjKnPzaRWO7MDRDHVUT4KZtid17v?=
 =?us-ascii?Q?dEAYQV0vsYdCz9p96fsh1Knf2YIRk/m065ITDMcJ71ciyUgGWRRQB5DX8ZEb?=
 =?us-ascii?Q?LPvVkxPtfSjo7OAPXt9JTpIs9jztwOgV6RVJTkCTXt+diAEnSkVcHK74R2SQ?=
 =?us-ascii?Q?1UrPtNNXU4QzOJG5bP5QPZDYWcV0YmWoCHmiqFAAdwmLw3ujH5PISqKI9Xdn?=
 =?us-ascii?Q?eLJGew/dyvQHspRQ9roHTsVJBE+EWKUtWybHc8c0LJvwagvPQRk+zhpolAYv?=
 =?us-ascii?Q?APhePlsvJGBJr4KAjBiYustHTzjoS+evVRodjcDJWsZrgllqxrrppiyxJYIa?=
 =?us-ascii?Q?Sus+OPLKJOyy0tuZAKHxk6p3299JEdSulMsXbVmonO8+pbDJo0+oRk+D097G?=
 =?us-ascii?Q?Y3sLiZCNXNzCDnM+UTG63WGKql6bPmxxZRWssPRf8NHAPtSOa5ixw8NxU3Yw?=
 =?us-ascii?Q?jmo3ykSwx4Fd2BfMHY1qTsLBSsFiKBtESeuD3dpdgzZ02vCY3vEbsh1fGErZ?=
 =?us-ascii?Q?GiHceWbUdG6mMdAajzG8i/iBdakoSGmJOi5x9FWSbCJoRvMf47ecaM4DxGxS?=
 =?us-ascii?Q?QHOCE5tqPJdntelNabHMNi0Cxlj4Mny5PpPr2BqQ2K+izs064iRIP61hrlsk?=
 =?us-ascii?Q?5CXB6qq/dh+jxbf4mGXyE9bt5iwM9EWoKTRRq2OtSoBEzbqLb9TNzaff2EZI?=
 =?us-ascii?Q?LQIAUiEGtEKqxl3tnDLqvt/8qeeywGurSLNhW9qjJq4bwfxf2pU4bOHuI5Wq?=
 =?us-ascii?Q?oC0KbjcB1x1JowWyV9U+kke97Xm19RgLca+FHyXU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41275686-ad8d-437d-c499-08ddd9880271
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 10:07:13.8693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dtt3B9+NcEFb8JENL7rsOvsHwLPRA/4KBJeaZW+0xan0llfHOi7J6wXSC2xDVn9i24FyfkAcrjLlI5fVVPerBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469

For some Ethernet controllers, the PTP timer function is not integrated.
Instead, the PTP timer is a separate device and provides PTP Hardware
Clock (PHC) to the Ethernet controller to use, such as NXP FMan MAC,
ENETC, etc. Therefore, a property is needed to indicate this hardware
relationship between the Ethernet controller and the PTP timer.

Since this use case is also very common, it is better to add a generic
property to ethernet-controller.yaml. According to the existing binding
docs, there are two good candidates, one is the "ptp-timer" defined in
fsl,fman-dtsec.yaml, and the other is the "ptimer-handle" defined in
fsl,fman.yaml. From the perspective of the name, the former is more
straightforward, so add the "ptp-timer" property.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v3 changes:
New patch, add a generic property instead of adding a property to
fsl,enetc.yaml
---
 .../devicetree/bindings/net/ethernet-controller.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 66b1cfbbfe22..2c924d296a8f 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -108,6 +108,11 @@ properties:
     $ref: "#/properties/phy-handle"
     deprecated: true
 
+  ptp-timer:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Specifies a reference to a node representing an IEEE 1588 PTP device.
+
   rx-fifo-depth:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.34.1


