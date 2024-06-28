Return-Path: <netdev+bounces-107831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F5F91C834
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 23:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189741F22567
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 21:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFB080635;
	Fri, 28 Jun 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cgr+JfEg"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BA880045;
	Fri, 28 Jun 2024 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719610664; cv=fail; b=kReTPWwQFEifoCugAdvt9DCAoIvx+8qFNo8zVLTJh7luS/ZRT/n7pcQfDe90GCB0VSmkHOPWlx0ZQSOAXwTO76SMwdQhujJgnJ4EifQY0vKNm/+cwrKRgX8mwvWQD2+/LzWbvEc4Qgc9UzQwDy/gl/xFl26h9nhjcpWHkVF1Vng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719610664; c=relaxed/simple;
	bh=yKIPdT8MSSHoU2VGqTw11AFRRmns4hecXkao19YHRu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kwgeYHB5rxc48l3EKfLWIl220RwVnpK5v9dBJx2OtySKetn67Rz27KnT9993nLVoGNvizXGiCX0EHNiW2b10+eyE1ZLEfDBCMBlcZmUbqPID9f7jThsqEKLIU0RiF6Hy9WtcYSkrJzQ8t5daVOTrvd5CEXbrpy56jLGn4UIVD6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cgr+JfEg; arc=fail smtp.client-ip=40.107.104.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JL9vzUwExUOzjWfivfaKxV5Qs5lgilnCj8cSGV744lHXtS0RsBIhQwe6osQbM8foumlLI8mw+BX4z67wbqyO+EDEUa8x5NOuM1vunJHMT9Rma8SdTBtWrgelxMMpwpTC/vQr5htRKukwCle2c/WnJjrVg8b7LQArGG5T6RxTf76yvQCnIhEbyi4HDYyoVB/aqRy1igiBO5e6fZt/TMegTW/qB5N5x6K27Ml1Rqgyftd6QhHK1jt5lLLxcyM7KNyEF3RKo2YVvinLoF3ycN69azolhzhAmXRKj3Mhr85FLwNhUU2vMB0TPGuY7C9KhBZ/DMuGfjgdkrUF34AYU/pqcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfQPQB849yGhJfCr0PtJzcwrC3W8vXKEMKt/2jek7aU=;
 b=nyqo+hA5hXmAQpQK1W1Mp1Kbd1+EGBQ8y0A+DGIJBouY3ARoPkiGSz/wfdZmlpTQcW93HJLtEJSx4J25TWJV9sfw/+RaS+HTF2+4027/djcGJGVMlbOvNq0PsDvtnK7xbhcZsHCafvq0NdajqFFxMM8NQg1wlQ+yl+FQ7XahAjuhZh77A0HgXSRwn7g29DeHcA8T0BRkkL3pZ9/waxunnx+aTwsJYp/jwXTNjUlmSgMIZX+m4XK/TwTOTRYYSHg8idqhxX9ihTfC9ozdcgOYVvvKgct45RrTxMJ5MGjvy8R67yzL4Ce9ZAeJu/Pua8oE+63x3NFs6h3zUCutOflN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfQPQB849yGhJfCr0PtJzcwrC3W8vXKEMKt/2jek7aU=;
 b=cgr+JfEglxo/eHIl2Xb8NJNKKyZ7YkU8IBLeqyUKzyhQ4oXwDIGCrmSU8jwqP3pIyAVyYOzWLpTDwTr2JhozhT2YdokB+3AqsoDl7mbWVSyZSPqBaLVIGP3YmmYK2/ttbqvhM9A9dmrxOb11wsjvl8lyrYk4vl7eN5UsyP786+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9346.eurprd04.prod.outlook.com (2603:10a6:10:356::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Fri, 28 Jun
 2024 21:37:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 21:37:36 +0000
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
Subject: [PATCH 2/2] dt-bindings: net: fsl,fman: add ptimer-handle property
Date: Fri, 28 Jun 2024 17:37:11 -0400
Message-Id: <20240628213711.3114790-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628213711.3114790-1-Frank.Li@nxp.com>
References: <20240628213711.3114790-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0063.namprd08.prod.outlook.com
 (2603:10b6:a03:117::40) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: abba1491-feb7-4576-fa1c-08dc97ba86ef
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?J6R5gda26zKe8SvEZrF7MVnZ0IB2oETzH9t31l8JHXLKVaWOdUZH5FE+U8RW?=
 =?us-ascii?Q?XmafvfRdVtqK339cZ/f9hsOuIcLU4q+2WVJ6EL0uDiwEc8w3Cz6MAXBQnopH?=
 =?us-ascii?Q?TklvlN3wpRzwQTlXwyfKbLWutQcIlYrwS9xFYnjXixAnCBMlTUZQvuhe/Nhl?=
 =?us-ascii?Q?1mIEegLy8nyfL+iMIYM9nPTb8On+hgu0ZrtUa1JGInuyVB+kZHUi/UIQONs7?=
 =?us-ascii?Q?uEDBrwYqNSxT0ieZEcFIyDV5sm0UjYtNtlFPi17HoCaG5gZVNJF8Hzvn/Tfq?=
 =?us-ascii?Q?jlfz4OcJM9koIS8qV6yw81kO8GtfWy7kOE+FdUOyOhB4UMoupW8eJ4Ui/CZW?=
 =?us-ascii?Q?VArd9H4bt2TsiF84BUEKsEiafxpf21pdU2FQzl3KsksSzMwnPrcjwBJy+xVT?=
 =?us-ascii?Q?aOgpZt4XeLJ9CMVK2cMCj1DU1QD+JxyObK7HfiYmh3G3CpRlBbQVOMzpTrBh?=
 =?us-ascii?Q?gMADtRBbVa4XCOg3TQ3C5xPFIFoNRso/p0jYa8cSA9g69IRBZDsE8jx6O7fk?=
 =?us-ascii?Q?/sAoY7RWLss/+FeP2eztFoP7yEn7Js4pzIvmvctFfLVHvD+9+VUirGQQGGtP?=
 =?us-ascii?Q?OTWcFGHlKLMVq7YYK1QNsCGBkRZqskAe6tx+o16RNyaNJfpvESGbPJTsPLM+?=
 =?us-ascii?Q?6e2JaYq9HyoZPvWRCJfpbcR1nDxR3XwRXTOw/7zE6sDwkK5RIciCunn5+aj4?=
 =?us-ascii?Q?5h8YUPOTPnpV2CWEcxhsYlaMKjh3DR+WfdLm01wQzYR2z4E7w8vyZZMQp9XX?=
 =?us-ascii?Q?cxQ6Bvmxq9TTYx9kiAJ461i8uBrm/l5pq/vrXaI4u/3jnQq1AuImv9bA0Mxk?=
 =?us-ascii?Q?7+LdjyfRXh+vrFTI4YSU4EJSSGh6S/lloeS4dtnYVYyTSlp1KPs60FIpMLEd?=
 =?us-ascii?Q?+Ejw77d+xFWplPWi61eklSPKp6l3a7xWewrm6wGpz0Gu/MZAN44hOPURwqEo?=
 =?us-ascii?Q?usUUIEsa2MwMMm1ipSz22xRjqKt98iarvpsLuUN6sPtN5FO6ALoZUdxbDWm0?=
 =?us-ascii?Q?Fml5NXVWVPSqFQ/8p8zEebpdHr+EMF6K20MESezB6IcxTRz2+bbSQ3JJ/eFB?=
 =?us-ascii?Q?liEET46q4rmUIhrMj5WgQhxShKCSvpfahi0wSh5o4TbpG9xqdtGcrt2Qgy/G?=
 =?us-ascii?Q?2GJ8schkNiThssAtssoeONWVrxo3A/McaDz3IrGN7SsuKU1/dXtU4Np46ylZ?=
 =?us-ascii?Q?ATkoOD+8yp67HPgI6NirEtHMGFopXF+3WHsIbck4AANpbyCQGXsxxukajk+3?=
 =?us-ascii?Q?yTjUfhp8P7OMhBGUsnXzztQKUTGGk2iYHc65hskV+PXPwq3ynbAoFrfwEA70?=
 =?us-ascii?Q?+f5S5wqFg7dMzIu2Fnsbyo0WChGU+hmyXUEBT9l2ZbhWPnE5uZmXjJVwecZy?=
 =?us-ascii?Q?USsRC5mCM0kAwoevGe3E9qT/4IDmzLxcln5Qfc6LNFitTmHFAmvh4SOeoeon?=
 =?us-ascii?Q?bfhatoIdmjo=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?qsNU8UNFpZDZOYUE81uI4KEpnts+DCIfz2H8irlv/5hxZpnhrwMEhMdGn/EI?=
 =?us-ascii?Q?jFuqqLNBv1S7jT1OKB30soN2dqOtLN2Au7eFdWHR38vbWd1M5MXtuB7mXNDJ?=
 =?us-ascii?Q?7+qKkkFL3aoB1nZVBlDnkHIlCZcW91trTdf5b8aFjcebUHfApgR4XscSVQWg?=
 =?us-ascii?Q?H4sPOFmJzyOmDnXN7jvBw0TNxo7dkRw2vo2x5aBpbSrJ/AGD6KCMg3mOEBbQ?=
 =?us-ascii?Q?gHduf4SkgpqLtWTBA7rHELoQCmusTg7PeMFTQGhKiMPmnlNeRnuTu2HL5pP5?=
 =?us-ascii?Q?Jz2ar3ZwNcfQZIPkS920mLRtyHUdlkbHl3wK10JJqnXvekfHP7fCvS2mrW3/?=
 =?us-ascii?Q?mpIKOzqezpGFYqOGkpr3W7k62ELuH9ZgzgNGQ55KRDlF+ZuarDj1sDTSsRwv?=
 =?us-ascii?Q?s1JL+4sB+5NzE95ULVoiO+OKD8DjKejEeL1Cqjwug1BeCx3zBss09UIpFHJ9?=
 =?us-ascii?Q?3u7CWn1Tr8z6sbFmyT8/mfiIlxPXe27p7rC9LUTOPnQnlemmaUvBxpainGXg?=
 =?us-ascii?Q?ySbYNyDOp9RA/gasZVVSX4cEZc1k1cYr4XSbBoSSXgr8z3DLzh0Nuc+vOXvc?=
 =?us-ascii?Q?4qUPF6MenniDQ2/pDoqtobS+nyBseVWWIkPB8LomhvDb2kngwoMzgG6mfbFa?=
 =?us-ascii?Q?RqWfAUi/eWOlTeMyGsA8jxp6/v6HrohSnJNVAJw4jdmZCo57MEtC8vf6D3wA?=
 =?us-ascii?Q?sIB6pq49i1QF/QUUheXW2NPHMZQD6sMvw+atSEMAosuzecMCaeIHaasBP7p0?=
 =?us-ascii?Q?G5zs6cEynNIbuYoe2VxenhG9tgcUVymaP4spdr59mjKVn9pCKIes18AOzDZu?=
 =?us-ascii?Q?jrtLBFgCKOmmopoGmMy1MFHCTT2Q4byVnSN8jTiASO2jL8zp/jlx3hOYRFA1?=
 =?us-ascii?Q?KHhE54DWHzl4ZZ6rwGWpU8rLPNi+IYV04dzRqsWW2C+NOdBkMJcOHF4YLkh3?=
 =?us-ascii?Q?e3eoJsk1AbuKoOtQwpS+19OZZayNiFtB9pKRbwR7dgIykCZaBrne/jR+I6Li?=
 =?us-ascii?Q?+xs52o8peHF07XpNOqsiX/8Aj1vvNcAmLlenAa4Ce44Q5WHjJe/bLH+C2rhs?=
 =?us-ascii?Q?Yj2u6ecVUZ+xEA0kWXWRbK+LqvQnqtFxEI5Wi/0LehrDpL4J1AC3hcGhdLqQ?=
 =?us-ascii?Q?gVRZQyy2AWrV9OBANIlEDt68jFRdSS8XSDQ16w4pYkcWTHKER4FfFCBnHd7Y?=
 =?us-ascii?Q?2IB8V3jCxJJ9pRl721+fFxoB5HGY72Pc6FPZEfMSBRUe/dH7sP8a8eeeOXfY?=
 =?us-ascii?Q?F02wepqjsQJLs+q0eop9DJB8dDQ4T5hwTZ30x5R/yDlqIyaz9COLLBDKPHlL?=
 =?us-ascii?Q?ZEQP8hvFYV76gdtC5zZDKQ1l/wxE+Szp6M28m4iN20xmBt31/xEGtNaC1Qu5?=
 =?us-ascii?Q?XvnWNprfR/OugHbgLEj4fnQJdS8/X08eptSgEEm+kABeWtIBgphTpVaBOVhx?=
 =?us-ascii?Q?T+gBJIj/KM1EfQjIxB7OzpIlxXQZDk/jnJa8M2Vd1IbZ3T0sXAz/fikKenm7?=
 =?us-ascii?Q?k8KBYiVueDERyXMilTjrN6GQqmTGwSy42EXmGZ0sP6bJRmuFdoPNfZEqCp5M?=
 =?us-ascii?Q?kmrKxWSTg5qGqg91s7ItwFgFLOfE6oWeLfgTB+M0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abba1491-feb7-4576-fa1c-08dc97ba86ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 21:37:36.6513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gBojrqJtQ1aatzAC8G6/sOewyH6+JL9rvsi5Ph6eDbYv8pSIHOkKYnRB4qObzamJWwmz5eNaGdx+QGh4xH1jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9346

Add ptimer-handle property to link to ptp-timer node handle.
Fix below warning:
arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: fman@1a00000: 'ptimer-handle' do not match any of the regexes: '^ethernet@[a-f0-9]+$', '^mdio@[a-f0-9]+$', '^muram@[a-f0-9]+$', '^phc@[a-f0-9]+$', '^port@[a-f0-9]+$', 'pinctrl-[0-9]+'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
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


