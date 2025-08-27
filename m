Return-Path: <netdev+bounces-217174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DB3B37AE8
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364131B67984
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F07314A95;
	Wed, 27 Aug 2025 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eMMmhtW8"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013051.outbound.protection.outlook.com [40.107.162.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D095314A87;
	Wed, 27 Aug 2025 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277707; cv=fail; b=K4h6IAXqZAoMPegM+FwUhwt1WFe6sv7KGtIaM6FJdpkcksyjiuiU0Cjca8tmyrHV1lalQAqIISwcPeE2BP70mhCBYt+oWysfZEKX0VOeUJTI+f2eSMHLUAcmXmc2AmSE052c6No1TK46qSjrd4zQ9MtdXt3ixVEKzZHRyfMjjbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277707; c=relaxed/simple;
	bh=LpDN8ORCmhQaMDDMjogT4xuaWHUhGLywzYgSUvwciYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CKLMinAS3wSndiw+bLuRfI0lUzIjcCpVgYf+2izpa31qRNIo6irxTgw1kOHbWYKJ41HYsFKcApjE7xmNS4piOIqdtw5Pq32O581nJRDhdZc2KFeqtHdZAoNCP3lX4b64cCheuzDOwOMO9Olqh8YIi8UAPv7Eu9NAdNia9At3YEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eMMmhtW8; arc=fail smtp.client-ip=40.107.162.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBfPg+0TK3HPo3OBCem+dOoQj8lp8XBAwbOc9cjeBVvHPkYvt1/PFMDCGvR1I7F4R5RxyvfWvyUh3GCSxN1ipDzr1Qde8wj62jne61zpc5rfbm/Skhjb6NwkIZ5TRuKO4VWEdqwtj4/j04xkX56eKvXOMXYC1zH3H3qb6JsEHnVAbUbQw18lXQ5y4vflT0TxzrBvG/irnfzsT6PWCzXra9hydf41iPEbf5kgKLr3XcQ/AIhunQMsZVKXpCd4JzXXXg+8uNiwtRonfqbVHXb1nwlvyHWPy6pijtg9Y/2nHFInr1ncPxT6vJh7jS/HxULgvtzpxQcmRqmrNq3OC97CBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJHZEdKCsNlRKVUbEqKmc5VMMwSFGc7jbnpKBjXWhp4=;
 b=AhLef1lXB9a+hdgfjfJEIWHUKE6Rw3LQ6nluYAXpKl86oRP0Zrb0Y/zACVyGjuibMmg8KDmVVmfqLhNSxCyHllowMc5iEXFK9BzvmZQXOmRwC/KFS8ERcR39idOnI2Z4I/S1q9+wHBg5VL+T4dQ90HGOOq0GVs8SgbgHr9j6NXZ6asBN9wysasJhIL/TpWlP4Jkmv4+LW5eveBTeRcu2nfrb5X0zx418EhK3notWIhp3SP5m+uBGskBRda0GhgOiR+xM8JBDuUpfv0+lOOFJ9fQ7kqvTtCbdph9ugUycQIunEHa5RQWsuzecaxW7hVhz3yR/xWKGsURp2Jenplr2cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJHZEdKCsNlRKVUbEqKmc5VMMwSFGc7jbnpKBjXWhp4=;
 b=eMMmhtW8M7bWwme7bxiHMAYOrxrzf2VNd1rzjy8kC8AMFAKBEOh2dh+ZSHSRwXVDT/tKK3gn7CRgNeMfOVuw+f8CPM+5bSRWMzx9YrrLU3FzKQJ4Szum/8I37MLVUSIs5oblMgpQkCmJNs6+G9w75btExqCDNHc7MjhaL34bZu7VCbsU7CUH+2wYi6niuAV78nevPXQ+dt1a+ajKMeH+yfsJkGpUAjvx6ImsI/4QKNemUjKTIsJF5wAykCqv9EgMrCplqucEXEb1zEzwaTySFZyFxTEBSnHmWRsdhLnUqadegQ9uafC5cpuN8ixdIgbAPcPhDS3NrErkYNsnjuUgGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PR3PR04MB7449.eurprd04.prod.outlook.com (2603:10a6:102:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Wed, 27 Aug
 2025 06:55:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:55:02 +0000
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
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 net-next 02/17] dt-bindings: net: move ptp-timer property to ethernet-controller.yaml
Date: Wed, 27 Aug 2025 14:33:17 +0800
Message-Id: <20250827063332.1217664-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827063332.1217664-1-wei.fang@nxp.com>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PR3PR04MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 192de22d-57ba-416e-644b-08dde536a574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|7053199007|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?unU5/WBIK0nqeQyzDooCrCeg9VNiyIvBISVDfEorRAZM6m3q35du3mJaZm/V?=
 =?us-ascii?Q?M9A2WtJYc/RFleTUyTr0NbO22rqRbcG6q09RPWgqGAyB7Rg+knxD60qDpxtZ?=
 =?us-ascii?Q?joEIS0vzD+unE8RxxZ8cyAL1Y5xRZ5m1RTyAICVhQv7w8pLBIzR9asslOx4B?=
 =?us-ascii?Q?HVBBYODulOFzVz2Pj8JUnPCvgbHoVbhV5p4FQj7Uc9cEZT1XTanfB/c+sztY?=
 =?us-ascii?Q?8ogTDMrU8pi484gJuWtbziBeE5wJrLWH4En9BNytwg14q4KXYIq2nvD1R2zT?=
 =?us-ascii?Q?wc0yFYjdEu+N4V2rmPgObF/tt7I9qCbWjs9m26BDPEdSK6QjIVPjS4qgPTfc?=
 =?us-ascii?Q?I477zuK+rFu/3mv5YQTZ+X7jJqJG3Ki9n1WWRNg097j7u/8/Js2Op5Ik/bM/?=
 =?us-ascii?Q?cw9K1kZ+TftaOTtnzIn8CpLffPTvyWs/o59ftbUsSDjeT+VVTakjgipfoADk?=
 =?us-ascii?Q?QCySgOBbGPXs5YnRBAhZWte5RV8RRsX5si1fGur73Yt8aDB+IvGvFrO3JZSM?=
 =?us-ascii?Q?pbJLtqWuTTmyToZluN9sQtLD70bMI9vmf+Oh2w6gP97AryD4mK2rE40sZP2I?=
 =?us-ascii?Q?bpSv9+AkrBbgwJEnY79dxQN2A5Rj+eLzEdvZPR72wvlZu797POLdQqMWjpeo?=
 =?us-ascii?Q?E2upu2sjdI7q110oWuFTgkkAC1IRTzQmjdR2e25A13c923stRfn0POL0o6L4?=
 =?us-ascii?Q?x7pcckUag6YiaKUIY/qmEsRYWLbgHChygndgv1m+D4nI8UzMx/2SY1iqncHu?=
 =?us-ascii?Q?tcvL2Bnx/ZILG17jjMD+ju+/cCb8xBiiljsTxa9gEW5KRICf3WPaFpCZ+xmB?=
 =?us-ascii?Q?XKB0qBegbPS1d7rhpkihvGxYrFvDXgU4Bs/AgtcxDKUOBt8tS1m7a5y+CbYr?=
 =?us-ascii?Q?txElrW4G36H7KLqy2kgZ0cQEeiMH9U8IBtZtmkBUByeE5t0ElNLJu4MIY6aN?=
 =?us-ascii?Q?/G/KPKae2tmjYIgm7IzUkSMctMhIcfHyXpDkm3E3vzO6FDqzY7COcAt2eiLf?=
 =?us-ascii?Q?JuPW/P18G8oMQ3XZjlq80uU7Z+4+WNc6LmphG4ffDKcTuzauZsF7c2ZlXaFR?=
 =?us-ascii?Q?NcLRbqrNHul9pSKW/e+6eEfLE0w2EqMnEn7IpyasQmVFiqPwHUqeGU1v6pTv?=
 =?us-ascii?Q?Ityxik1WbXxQMOGMRB7gRLSQgwBoRcBmcpr+jV52UCCoiuWLt/ukGXgQxcAa?=
 =?us-ascii?Q?P4eBUwNNO/m2REKwaj0m3XoLaMZ22KTMXxHdRidhV6rgSA6TgX+p0P4gRsqO?=
 =?us-ascii?Q?kKYyJBT1+QnzFsjJduh8qq1NvLC6kL+XqqkcoMe05JDzBQtKGL4RrGgv0SHu?=
 =?us-ascii?Q?plft+eoKP4rv6kCm3gMQtr+v0FfPnMF4e3codUx33LSVT1321gl982DR7kC8?=
 =?us-ascii?Q?rPdxE00ORb5RYNgiNyHgkgivcdR+X3bAdQmsWWgR9UlWhTlXUAI2fkxKcLnj?=
 =?us-ascii?Q?Ha/UzqGlgmayTPWRBRonc1hl5nYMwpeA8vrVJqWt6BsCwS8OyUmTge4oi4uU?=
 =?us-ascii?Q?UB6uNHu9Me31Ids=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(7053199007)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i0J8ckTWAdWLE1Pzr+Umz/ycOVTp86zX+E9G0HXZ9/4hOssIQsZMsWMP9EBX?=
 =?us-ascii?Q?ldtx8ABlKFTeLHfNGH+lNQ2WddOrUC/yqFZAXnPFjX5nLnuw1ZJrMXpbeJjl?=
 =?us-ascii?Q?IBhyLx7pKLJQQIk8mgMYxC42dYdPDjkvO6ZJREqP1PBmEW3m676IzV58tBrc?=
 =?us-ascii?Q?EYAbiTF7w06uin5w6IFkZL8sxGcQkY/kHx+qIuunDpF6mNDRAg+Q5+CnZz5w?=
 =?us-ascii?Q?jga5AXvAklmR25iUUOTg8RywyeQu5XaGXfbzUBP5s/nkYtLHnfYumERAw1kb?=
 =?us-ascii?Q?5ajYgjF2QizHF3CZ0zCjOi8PJek0CpIkVwt9Xopk/7udBTYdQrmL+OrOJA+7?=
 =?us-ascii?Q?0QOjM9zwJAVX1rrWOArMkPoK9Crmg5K6Vg5thUSmgnRTb6Quyfx4fEbkIqgI?=
 =?us-ascii?Q?whg3jks/++Vstue7HM6ha4187AJXLMOb3ikXzzJrSf1N+pZ3hEdW/xwipuX9?=
 =?us-ascii?Q?hTvtBwpieTr9g7035WcrMLA6nFZT/paw1gpmq37MJ6rSnCiYu8MDILxKb4Di?=
 =?us-ascii?Q?Tg6B2ZUj56OzFgOwFg5ORTCpjuM5KepxyBj7IzXLCgO9UCPsxU+D71Cv72Bc?=
 =?us-ascii?Q?vVGPFG/aaEYjQ2v+NTpiaXT+IUZIjgg01x1a45oZE57oDOxeATaSEe4FlHjk?=
 =?us-ascii?Q?xc5dJcKzJAx9vNRWQSDRKumZXnAKU6pbN3axAlISf+lqXTov/kiJkeZNuzcp?=
 =?us-ascii?Q?rwOqCQsgfQYcW0R57q4xHbq/xAysFcPfNKcvEz8z2KkN1QidnBWGBWR8v26O?=
 =?us-ascii?Q?B9eU8J+nxlTEInlIcPUcI5pBZDaL2mjx178qCZVK9vxSSFP1pl8hMG3t8d7M?=
 =?us-ascii?Q?tv1aRNf/g8/RO70YuOAhAcFhJhQfq5Cxqxu+tBlcVXgevTyOHUVT0VygNyUY?=
 =?us-ascii?Q?ERUytkWSzAPXDHoEFzLqqP4HvSGv4v81OqzZn/1kKojncXmZaLWQ2Xd4MQtI?=
 =?us-ascii?Q?4P3mhoKlTtPmc6J8y9fYG+2R2GSaT9wA4hpWBZqaXaHiATH1M0fLabmOX2bs?=
 =?us-ascii?Q?6x5vsIdnktP6dOe17z+N/UC9gLV1b8j/cxKtXV1WJF+qsQmSywmSAyHFfS1p?=
 =?us-ascii?Q?0l0rDrHwFDTQSlYELZKhTZaxiPDRbkfRGgNu2Kd/4M8ISavvmi14wWxlF8Hf?=
 =?us-ascii?Q?yLUy6HCLy3KW1AOImjb+CyIT497CxYL57RKQGRxsOLuoMkFzVvho0FA3UwQl?=
 =?us-ascii?Q?nhGUl7seJ/yOVicLQ6wyfhmY4Y5pwAw3/bD78OEqAZzQPKKywXMSbZal7p+H?=
 =?us-ascii?Q?jEjBRlon7wbSAdM97r5hZBw2qyIjPUF1UzEJ8rWvmKKr0KWNp4Y7fT0MWGbH?=
 =?us-ascii?Q?+/Ut6OVFDgBybLr9KIUFVHdb6TzLb1eRRmQDCutf7efuIEzGmzm+yB9pKXrL?=
 =?us-ascii?Q?5qPOZ6yWdmSULY3tBq1w9fsWbqRxDjNADtXlFNGbF3Hdl8XtF77EXNoN03qu?=
 =?us-ascii?Q?EBc5JDWx4+3cCW5DwvKj88A3hZCoki6U2S4Fj9G6BgvDpVNZX8Undsr9b8cj?=
 =?us-ascii?Q?4p8j5XpzR/k80YabEbhQ/AsNDGMi8hWdKJ1b4SBFzbQcBwKnelCeL4tOe2ca?=
 =?us-ascii?Q?NEbn2S3yCKpMYmuHNqK82Dj3p0NnEYYWe7nJE5td?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192de22d-57ba-416e-644b-08dde536a574
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:55:02.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URLr/5ZXZRMXF+dgpvtBK4QYrPPKIG752QlKllvu38bCBqThKyCWy5Nw6/MMc5ecUIfwLmDm53akn41lQUI02w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7449

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
straightforward, so move the "ptp-timer" from fsl,fman-dtsec.yaml to
ethernet-controller.yaml.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

---
v4 changes:
1. Change the title
2. Remove "ptp-timer" from fsl,fman-dtsec.yaml
v3 changes:
New patch, add a generic property instead of adding a property to
fsl,enetc.yaml
---
 .../devicetree/bindings/net/ethernet-controller.yaml         | 5 +++++
 Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml    | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

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
diff --git a/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml b/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
index 60aaf30d68ed..ef1e30a48c91 100644
--- a/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fman-dtsec.yaml
@@ -81,10 +81,6 @@ properties:
       An array of two references: the first is the FMan RX port and the second
       is the TX port used by this MAC.
 
-  ptp-timer:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description: A reference to the IEEE1588 timer
-
   phys:
     description: A reference to the SerDes lane(s)
     maxItems: 1
-- 
2.34.1


