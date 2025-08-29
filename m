Return-Path: <netdev+bounces-218109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96086B3B26C
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE7757B7EEB
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF20A2264B8;
	Fri, 29 Aug 2025 05:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ccuEBeG1"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013008.outbound.protection.outlook.com [52.101.83.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E6721859A;
	Fri, 29 Aug 2025 05:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445247; cv=fail; b=ThptaCN8kczsq7RbEyGsrPlamp6D+4Hkt6p+zQ6F95Gs2tnP2JhUEKW9HpUIzbgCblyD8a+gKSdLU8NQ1O9B91xB5/4Qr+pmI3T1wT3fni+2TSnzEq0HA6/EkVWGvgEEadJuoGpuLBlvSGdyo7+V3XIoXrYni+1D4DdysT9AakU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445247; c=relaxed/simple;
	bh=LpDN8ORCmhQaMDDMjogT4xuaWHUhGLywzYgSUvwciYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IhgOj8A6E7q36UtrVHXvpfh9vQm38cTnedgUQKEIu99iWRPbf2SyYWYlUkKaFxmTtzpkHFaTGVdfhKJ6NhLXxSKR0pu8K5XQEqu3fJdQkl6r6QO51Puu5eQjWTCxpyy4VSwm9NTjF3efz1/YNxL1x5+Nh70thSegY1ADUarawtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ccuEBeG1; arc=fail smtp.client-ip=52.101.83.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mg+QREs/prkqqdgBcQWybUFxodgwKgJtD4NSIEfTjAwU1LbpwHjmq1es95P/WpLwfaPTmI9YAquCqupL2QwIQFbe85qK6x49JBwBL8WaCTCgUvcTmd7Drnoatj1n1C+YArNSJHemN2UEQ8+S60elxv/ppvXYRf67RxE/SJo8Ys8QcEigFCTOb+nzAgWk77OMeu4t9vGSkqrrf0pRBA9TBFjIdmPHZBi0hQdpOvw08OWLzNwWwUrttkeiQnuKl8UcUFaxSHkQ2jS540RhQdBw4BSmJoYZFdumDT3HSbu/OnohFJBBs4ma7gTh4ByN9y2DJbfCAfT3MIjVNVjhwQSsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJHZEdKCsNlRKVUbEqKmc5VMMwSFGc7jbnpKBjXWhp4=;
 b=eZMuI3BOXOeBCKeNE25Ek44Uh1SAMFDYPtQJmYpLi9QhO1QE+RjNrVxl2OOZJJJoe6A4LaaiB4L3/BA6oxZZQDWqySJZOXllFUT6cw2fgjFUdrpBuhGBGfybonWq4QkdausqCuKiOGzkm9euDWFAgoyM16X09tXBERpZR++wVvjCV2R03KEWIWY6piqS5Q4LNFezwpmAH7ZOMHyOeptsEDw1vUGXk7+t/ozPED9y7XcYYNYhgHVYsoCz4cX1B1MBWOQ3D+K556D4O1P6iIzrL2s+EmLLo5KLYWMUGZRDZsJsi2m23K0N2gjfCs0Se38egWkj17LtHXqYe48INWk8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJHZEdKCsNlRKVUbEqKmc5VMMwSFGc7jbnpKBjXWhp4=;
 b=ccuEBeG1/sbEOF0sL+VES4npY3HgBR9QkPcSzNyyLo0idcIHjqvkSSfh3mKo//7zUqYsNZyd6VsuVgC/QxrNzlKnZzKFB0Y/ldM8QYIajnJaWpYNcabiLcOha41833gW7buLavzbGYKu86rqBwEx79KrItG8bwRc1tibd3SekhaJKCAQkceF5+cpAKCKDKqp0ZyTTUE2EFRqDpTDNp0nrNu6MQEQbKdWpLvJbCF8sjjWu3CbFM/7abYJUWD5I5g+zH83zBlRTmPvJA1hL3/UbK92PiiSp79BcfPfOxJ7V2O8D36H/KUAs6rIXa3pMCpijVhu2PLpOf80764LoUf3dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6828.eurprd04.prod.outlook.com (2603:10a6:10:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Fri, 29 Aug
 2025 05:27:22 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:27:22 +0000
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
Subject: [PATCH v7 net-next 02/14] dt-bindings: net: move ptp-timer property to ethernet-controller.yaml
Date: Fri, 29 Aug 2025 13:06:03 +0800
Message-Id: <20250829050615.1247468-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829050615.1247468-1-wei.fang@nxp.com>
References: <20250829050615.1247468-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB8PR04MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e883052-f2a4-4711-b2ab-08dde6bcbb2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XIHyONfLqCupYSNMBxRi74ZVoA1aEX8Gz8S40ApT+8kzYE6iKMowytr4ZlWg?=
 =?us-ascii?Q?CP40Pi8Mav3BUmWY7NAjtx/0XEtu9CfJjuR/SFUS7pP0+6GO4HaP84CxjV6n?=
 =?us-ascii?Q?OIhcG340QJeMfueJ4Y+2QGwV6Q7JonzCERbV8xYNINpZZ1RIYs+3JDXLfE2H?=
 =?us-ascii?Q?h8+v2RY0hmwfT6pgRxVfjRJRpZNjvVzQi626fvbJkeJe5no2MhUEA4/yWoKS?=
 =?us-ascii?Q?rH4bIH9l+MkpzN9CYRqWZ/2M+FlcOlqxXnBe/AG9cZny6wC3UICA0pYEnvBj?=
 =?us-ascii?Q?x9WiMUwn9ifEmA5ZhXNAAs+rse6NuwD0YqC0oBZ9xL4pep2CxZVRZ2i7ELHG?=
 =?us-ascii?Q?zLpKBNJ8rXD9m76nT7v2U6+S+zvgzqN9ap9RYz0y08EQ5eGG4aabH50qHB4z?=
 =?us-ascii?Q?lGy5tnN6b5niTr2PQcX3GbNB3HeapXA9K6Bhga9MC7C3NpNsg4Lf27/dwmQe?=
 =?us-ascii?Q?GgZVISaZti1f5cj3dIajAgIDQbfOiz38AMhac90MP/WlY4J24XrrSOsA+VY+?=
 =?us-ascii?Q?vtlUJzp3pV79v6CAR8N8w1XU9XiYDcQ/Z/GIYd+v1USFi0xLjnG/RiFJViGI?=
 =?us-ascii?Q?pBWQtIbebvvFrfMg6uf7zWWio+28ksyMMzXJvOAyJWaoMzazKheSew6PWNc0?=
 =?us-ascii?Q?wZe6qTdWjPSqsisQ/2bcelCqi9C62NWYcyKj2ghTeMxOyOEuyqkEe3t7fd7i?=
 =?us-ascii?Q?jb/THIq8QDsVtU0AVYH3hYl6qIXtA0u3i34vbaIrxYP0JIB9Ho3LhT9jCH7Z?=
 =?us-ascii?Q?UFfCJgH/Lb56k6tWMfVVtzPjHKNbN4JEozHE1vJQqUOFalsyvf+x8XEBLjZf?=
 =?us-ascii?Q?/YRFDxowH9lJIa4irxNpdu4NHqyCN40INjwxMnBWR79HR6OFnymzr5Wo8mK3?=
 =?us-ascii?Q?qE0oBtYbC84VX2bG32Kat7bX0vX/y+tDqv87B3rIyBt6fNaUaAsRhaGfKX3P?=
 =?us-ascii?Q?LcahSzQRcvGRwIN2UZMltrbTrqiwVWGK7H6POBvsWt9goJuNvvzAbiKhEIkZ?=
 =?us-ascii?Q?GdUf4KlR8jgh5ArSHZMfwzpMKBl+33tOFvaVRQFumLTh21b94gmjpAUZMuH9?=
 =?us-ascii?Q?o+BcjVxRjpkh09MO8W+It0tnS24yWHiIFB1FqAnWV6Tp0gk11bZO7pjCrvFF?=
 =?us-ascii?Q?LNl+3VsrIyR2U94RZ0ngte80+x+pv960TA6x2SJSmQTK4V5w14sLjwrmyTJ1?=
 =?us-ascii?Q?RW/D2CPpEwBoRarFbiTPRE31WCQ0rSiHl8QSQO28DNZLL30Xx3R6aa6S+oDj?=
 =?us-ascii?Q?ShC3Hbh5UoLJrOk+rYNqu/F/TcRc786BNwj5mIM6+BMwJ7C70VKEHvLJHTzh?=
 =?us-ascii?Q?+LNkvZ+dmpg3p8nznbhfjiEpodbMmc5LkXIgZpsINFOT+1g9vcccGAYuH/Je?=
 =?us-ascii?Q?X8qevuvwclThocdoUUX9quJAM3FMyZcn4px0xeU6P3cjofcu+KkLBbGQl5NG?=
 =?us-ascii?Q?80GOTJuCNO8hwXHrORm0d6gLUflZW5F+fnR5dH6XsTmOLy6E1zw/es1KSQhL?=
 =?us-ascii?Q?ZqSAM5mrKN+oOKE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xefAQQwqBbpvXDMhitrnqE8NIqBe1F0YDI1TW08s0mFqZOpiuBkEW3B2Y0pS?=
 =?us-ascii?Q?fLyzzxnUW1V9IgYaxZPMtUZoCzc7egWlqOA2FsF3Wj/i31Vs9zOivPjj1tHV?=
 =?us-ascii?Q?99gk/fIIVzb53pkuZ59CHXFEWQ/ksHUdSfpw1YqUrX1QJSkvFJsItsRw5I2w?=
 =?us-ascii?Q?BESsL4Rs7WWSowzDZPexR4p9kiYSUIrF7Ttrls+Z3rCSiu/abjEkHasu10Ks?=
 =?us-ascii?Q?bCDqPbY92k3S3d3aQ9qFcsaNm2NZHnfdvoMueEREE1hAIW7P0icMuzYHRw5C?=
 =?us-ascii?Q?1vYA5hNLjFHitSARHpKJ3badUsEjOBqc7Kr2ZTpZTbuhD1lCGGROQCPn6LNq?=
 =?us-ascii?Q?/p+C0J9W16SNsO5yaaTSelQd1CMkC2yAi6UwE8hJGdn3dnu+aK5oUo+jCCsU?=
 =?us-ascii?Q?VUBzeSWeO/W1w6yp9M3ZGANcOGKkDRVWNdTB3YJG3X+ZQE3Gni1MjJVAMsEy?=
 =?us-ascii?Q?5RUBPbzDtPQiVkar70KgApnpm3n3lrbKWFuURpQ8onYHnmvFIaD9OOUOZwb9?=
 =?us-ascii?Q?4h2xfybJD1rb/pqjKjFRk+xSY9mt2Tom2swqQstRrYZNL7ck9q2Y539S0N4O?=
 =?us-ascii?Q?IGsQTWpfV+cwXfkg2n9lKecqglm0Tb3eu3y/vwVg6q1iYgbeT+KIe+JdSLtB?=
 =?us-ascii?Q?ouLerIJ2iyPJghzcGbYLdX+uj52iuvqHPkwVPoca0u+7hkrxor/KZ4ICE9sj?=
 =?us-ascii?Q?ZUHs1Pki7XXWRow6m+djbiLR78Z1zqHKLgzWuMOfL92KBRwsm3k/cHwBOoS5?=
 =?us-ascii?Q?wA/S2kvbljDqqBgGLZ6RsjWNR0DnCOYdZvZBdeMY7yy+39Aue54sb0IrmMXu?=
 =?us-ascii?Q?pIBRhNIcC1RRYfnh1VsaKaPU3yY7YNtPcTiu+Osl3zxmqOf2COf2yoSvxqCe?=
 =?us-ascii?Q?vOtKmOttT6/B9g+9IW0DM0U7UYb4u0I6fJy1Ds5pSQ8aYo7soj+NQ0X2ZB7u?=
 =?us-ascii?Q?uppYeespHoa5ly14GZYMdh9KhRJ/N1ftcJruNnijnO0t8QMG9lzav2QG8+sg?=
 =?us-ascii?Q?gYYXaZmJ4Si6aHKqnXxYnT/88MJLVngLrIDI9ZX+GydKWGF1knqf6Wd6+C3F?=
 =?us-ascii?Q?hE6bHBDneI1LsxLaX8pmLvC/e+w8LXgXhCGwx45KXo+qIVzcJ/skuU7NRxwz?=
 =?us-ascii?Q?yol16Jfwfwy00XNAXvX4v/xy65qcWVF/ipA/jAaQRFZL25yyYu9an1KU5vUR?=
 =?us-ascii?Q?8Ly0F75r0nE9hlUGNraIDFNTXO6s+4175xH7m2s+qQRzIMPn479JAy+eleU0?=
 =?us-ascii?Q?2t5NC5EyD7effk9PwJwwjQldg1eOTkxqskYsLpotf+sTIdKPV3AadCEEe+Zq?=
 =?us-ascii?Q?1cW9wOl6BL1Fw+4uvuVD0lujVfnW5LKm1M/TayHJS9KSl4UmJ+RVsh2RA4bV?=
 =?us-ascii?Q?trKiiC5+pxJXJuiUQFUeynjEKyZC5B3jAeaks8yz6VYKmjBnZC11oPZiDuqh?=
 =?us-ascii?Q?iZm+BB0Nfi3yrMZrOd127xoLjw4orFuL+MUKZdZqSaGrq0Xrhs3PKP2IBQZ7?=
 =?us-ascii?Q?WD/b2zUbp9dyY80sVtv/yAoLEZyCZTZN5jwTg4GYLeum22FNzM2w/U0Ek9Mf?=
 =?us-ascii?Q?KxX2LSDHtvB0eIm/LxF8+0z+RV4PuIPdslSYBa39?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e883052-f2a4-4711-b2ab-08dde6bcbb2f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:27:22.7152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDCElFTRkZVPMsQQF1nTdo8bXJTPKzanud/Fc+v7QXwmQH/xTz7vgW6RMBqxj1iu7tOHLHArfHeRH3/1BfaUCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6828

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


