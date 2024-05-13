Return-Path: <netdev+bounces-96020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA618C402D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B913E282BA4
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98AD14B949;
	Mon, 13 May 2024 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nyi2Id4/"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2086.outbound.protection.outlook.com [40.107.105.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118314D2B2
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 11:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715601239; cv=fail; b=D7OuJZPeCoG+89GhXgEgMUyWBOsFmgYZmSaPmhw1I8Yru61d5jJHvuIZwfKCKTF71qeLLV8teB48WELY8L9DRw5jXFwnVso+TIlrW/vTI78U+7XKTcGJ5irX9aSTDsNVmpstvish4YcCPZQvzNx9XrFPtz6PxPdd6QJjmEal/CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715601239; c=relaxed/simple;
	bh=XXz4Z9HHDK4GJac+Aj4BxLT8GvWpauAdE0pBqqbbWZw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gArZo0s3SSn+BWXcdxg2ne4ZX9om1C4GWMjqXtUYwtXNS6KeY+XYjokjFe2yC8yZVu7/kk++Yxn/iQXqGAo+LIAXbhAaTot07D9OhgD9rt5MPGMAvEZUGJyKDDmPV9kFTV6v+v9qvXT/bMztVYfqN+MVWAQyKh7svnPudba6Gdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nyi2Id4/; arc=fail smtp.client-ip=40.107.105.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ch4dRdWYsB66gBfxvOrGROYBkMkzG5o0+o3DL+Fj5temY4DLK97IcBrrka+EozkEB9iGUkVs/PJM7w0mEAchPA3qKVmuqEFJKeklPS2gFxcphX0GMfAyQesKOMEv2WRVLG1JJ8+EJcXwm/3ClpIZt29FzyUinOZuEmj5gPChWpFJsrvNMVwWZc05TToOpxBVZ6eLEFTDnJgwkDcdJ6BJxeftkPEv3nM+abcfRomvDBt4oD4T0WfM1hOnmBqWWyVBry9sDIVnUOEmhwzdNTl0AgPYeEOUPmDHxFMW2y3qkcqk+mXa72wh/jmPvrOBWCv2vRh0MIe2mS27RBfUHLJuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A11+9ym35pWVX5NG0smygaEEccFXHZKV6g+90KFlNXM=;
 b=aSU7KOat1p3uEpF5qIxzhrMSm/WEA/56Bqo7eMIT6B+EmjVcCthTnTPQi9ZC1Y9U5RwXGSpNz43p33vX8XHTYv5fl6Lk8uT45JWf4TnzuGIrgtGfJwj/fsGIj2k2rYJCh0QoZ/Stht0DqeHmt2JVZ5qe156gu49Vextf+rxU5Q0yK2PTo9RjaX/tN5VfhGEqA1w1MLVTAE7QffKcSoufYpDHPsrWMz+RPOVZDSJ4yq0lpaRaEjV2ZXrXvZXGR7U8Ssxz7exQdqkOR/PdLEtVg4CF27hrjB6fnBPSk4S+6uSQ3Bqg6qiN7u/ddW8LqpRe/FM7rHx7dTaRNQVtL/8Wtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A11+9ym35pWVX5NG0smygaEEccFXHZKV6g+90KFlNXM=;
 b=Nyi2Id4/jQelS08y9G9kBNSINCAShXO3yG0SfGWD7Q1hIbwnabW/k5h09/DM+4IwmiXa7GgMtbzf8/U2yD6gmP9FbGjrHQlYpcupy6tjfPOyhmuQWayZmsywLcxvIddj6zvsRFZZm/tErH36okU+ASbA3JEblYFz/bB+pmJGFLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by AM0PR04MB7121.eurprd04.prod.outlook.com (2603:10a6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 11:53:55 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::1a84:eeb0:7353:4b87]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::1a84:eeb0:7353:4b87%3]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 11:53:55 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: pcs: lynx: no need to read LPA in lynx_pcs_get_state_2500basex()
Date: Mon, 13 May 2024 14:53:45 +0300
Message-Id: <20240513115345.2452799-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0008.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::13) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|AM0PR04MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eed0978-c90f-4aa8-e34c-08dc73435db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2+H7h47lt7DpZ0qGe8NMF7E5qufloYj9BJWtkJJ7LOrK1w4Cdxuu56NfBBsx?=
 =?us-ascii?Q?6mb4HLMkdhQfYnfd3O2LKpOw76hN7fDnXXaf1rFLw5H+zUtpG2OVHdTy8QO9?=
 =?us-ascii?Q?qrlX+RK2mDKO7kYLoBPuMXqEJLsDOZJtUjLsGy7GCP0cEI7mawTFdD1dctvn?=
 =?us-ascii?Q?mGkPGe/UeAojtHgh0AbvP1UieWJvqIrWC0gvEst0uZ9PtqgGGT2uox03NVOi?=
 =?us-ascii?Q?Iqk0gr1mjIHHIwk0uMZmvykdel3Oy1Ks8Kvy0Y2/SQ4VkJ0WF29s63I4tuQ9?=
 =?us-ascii?Q?2XsHQ6PuKfV7gkDb3z5oNLxN6+um4CpEmq5NDf1Q/juBRM2tKlYwYSiB3B4Y?=
 =?us-ascii?Q?Gh3005cHcxVuTL9pw8sywGooHOLIXCfOgBYHadFayT8KcQlvmF5SHLTBt8zI?=
 =?us-ascii?Q?IK/9dLxcu+XWYuHOu3KDFaBAuvja3cwrwumfmn3pAENDJvFXWaIYVdowpgtb?=
 =?us-ascii?Q?XYZTs47/o0TN3L+mA2L6T6Jv3cds7wKbO9UjyUTfUslXvX6vBxW1sHQ0crKu?=
 =?us-ascii?Q?IzoK5bmmOx8MqTEjA0yTey3giCJyg2tIUig//8XTAKlen7wpUpHK4R5OxL9r?=
 =?us-ascii?Q?bA0X17ehqlBkwVghcgRzApUcx4iOhr+BllXVSmK18D+WZLdKEKJEryx0Ufo5?=
 =?us-ascii?Q?iyDZmzvYFfe+s0gNVXrd8hlutjnATbF0gulnDZSGdoSw/uosrgoScXwgRr+Q?=
 =?us-ascii?Q?bF8G/Ui8mtmkOoWYuFDlHWuDuEoMGVW1as8a4PP4WkM5I13L4upyZD/X/l3O?=
 =?us-ascii?Q?jQ5oMtcmLHdLCaaIXmY3rYAviOHz7iYruwCTC/2pMrfz+SAdLOfj3PcNrRDf?=
 =?us-ascii?Q?eePuojXEwFsslh1yycB/+vfx6ahPGzn1BBqAhJh16yVNv+rqg0naUDqwd5Hx?=
 =?us-ascii?Q?VIXLvNdnvG6SoCUGFdw6ZO/+leGpjFbwHSJhj2gWXm8m+5bD+xq8O4+3hadJ?=
 =?us-ascii?Q?7sQt0Xkdiv9an5cYY76PUVjfJzvqNud0n94pFbpDPPHAnGgNqdrf9QlVVL61?=
 =?us-ascii?Q?lJ47/T+2Iqh8rygsnGa1S7Max6Kwe48VdrY1sQdj4wTLOgyLabld01wmDVLQ?=
 =?us-ascii?Q?q5QUZNu2pkg3rIF+qY2hFp2E2TdCfCZ2iul7ej36cQ5ovxC6Tzvkej5LUs7I?=
 =?us-ascii?Q?ZE2aNtvnjTHXI/GJbzPFaNvT1DIVQBUQuM889uL9DD0hvbIUQFTZ0p3QVD1y?=
 =?us-ascii?Q?qKPIIa2g4PM01c5xvag7bDOLEVz/GqMUjTlVINPptquUweHFIx9r+k003Pem?=
 =?us-ascii?Q?jemitNoID9yfrY+FyOwh+yQElHTmel8977MuNfufrzr57TaJhI8mX0S0kcWi?=
 =?us-ascii?Q?F7isk85fOOeLC5t9iuhGMxN79xUkKCZjOWagbx9tZjxNqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ki2tZeMgC9JxgQIcBmgAU9GczHLr1/+vsGxtCmdeYLgRQV2xWzC6uHNvnxJS?=
 =?us-ascii?Q?/+2lC8CnoAjIBFClI69UfmT1wuqZdHTq8yGO8ANsFjuN3cLeG/XuxIlAvSzC?=
 =?us-ascii?Q?VpJvXA+GweyJBWWGv9qjxo7XcxsKfWGRi4UGb0SMbzPh3fa1AqE729hwrwl6?=
 =?us-ascii?Q?xbQxCzQg6NJP38TQ+TrcuPYbl4Skd+Auzb+s6xxBPiQ0185JJyWFOZyiXbFo?=
 =?us-ascii?Q?EP4EkL6YjNq2JZi+A+w4HLgCFyUcwi3SNBoST9KHFh54J3kqQ2E5qpVcRaP7?=
 =?us-ascii?Q?7lc474Ajl/+sgBwC/0jIzLs3PAGZ6SqS17Ge0x5d4NCVE+L7/hc/oTWvUrMj?=
 =?us-ascii?Q?uPlA3PTvlMgtcV77Z3Eg+tMW334icFnsxLih+JUDLwZ1aHQaZtAbElZYQiWz?=
 =?us-ascii?Q?dFy5sESuPAQImuRlaFoWsP5pN98LZ6uGz6FfO0yHqzt4DZTr1TShzuvQsF38?=
 =?us-ascii?Q?YCeKiQEJ3QdllbTgzVkukRcYELssQRKcB+Bl/1n0mf2bHISUShMMYUb8/rFk?=
 =?us-ascii?Q?quvcer5q5FDnPMWrxmrmQ+TMPOtEo5EnQV/lZyXNgcCyjmrK6OZS1CGzIeMI?=
 =?us-ascii?Q?DUV4iMo4MO9mNt/09orYL0GT08/2HMR9OeLcGu/HhxCFm09lL/QN3cTcapk/?=
 =?us-ascii?Q?t+Ki/co3tuMaheLZf4YHGfCIAUm4HJ3zSkRFe5tRr78iYZFNvsRcMC6nGtF1?=
 =?us-ascii?Q?XNaUUSiQda99kIT3p+Ij5iqqr5IVkMUtqxePgrZlCNMT/G34hDu8vgIHrU4n?=
 =?us-ascii?Q?+g0io2H3W1PEKV6wIPw4/DjZzZ4zVL+cPU15dP9C0iUjTvdb0tUGgKuk9u78?=
 =?us-ascii?Q?h3vAEyUR0D3JCTtDX1m+JQ7eF70B2N7r2utayIvhJxAv/1bqMMQerxKBt0ho?=
 =?us-ascii?Q?GboB9+3NriLuVRPjliZzgbwFgT6XlqB9xF1bc3jOPPtBriUPd6ah/Z9PGcqa?=
 =?us-ascii?Q?9k11liv3vUeT4bzpOLIyRRbfpI6sHOjiQe6/s1vwNL8uQbheKECGpCbs514M?=
 =?us-ascii?Q?nNiF9YAQ4zoQpxvnVNQ8CfysLOdncXzKLDxpELkX/wCAr5mi8/uvBJ+QLJ3A?=
 =?us-ascii?Q?UiCLuPtLQmSBmemaB1sxaLAhN3EFXbOv9eTFMBkpSd1c6vm69/a0sMNjNCw6?=
 =?us-ascii?Q?oY3PSN5Qat11g/2W6zQaPpMBeusP3zm5eYWupw1wE3CGDP+ewIa6gNEXS66T?=
 =?us-ascii?Q?ePP1KWP470cHtrk+ytESGrBCarAUob1+GuZuBb4e0TGcoj0gEW+Tix2Wm965?=
 =?us-ascii?Q?KZnsjtupnDFpTN4rOrOEjw1gEysrbQ+1YluZPyU31x9hOLYL562Xm/N/zRmE?=
 =?us-ascii?Q?gc/m6xtPbv17pNA/NML7nkvcVSJpRg8GbHxBPpiJ5IdIq7vb1pgzesTL/PjI?=
 =?us-ascii?Q?z2r3G4435wNe/vs4vF9S01EHF3OioZt27/UsXGZZw8bQG0JETiz2vnvpB6EN?=
 =?us-ascii?Q?rI4RAx7Fhl/plSbOhXUmxarECxWsi5a/xa82U0/0I9p4qGyeUa0q7EXElRTL?=
 =?us-ascii?Q?iyotXQFz1IMZ303dXCLnpqeKhO2vyQrPHz8JrFcNwywrgCdz+xs64/BnnA/m?=
 =?us-ascii?Q?S7zyQd2Dutr3WvoqbZcfO/g0852I6RUIyAFXpAcsgVG5aOUp/YgXsLp83nC4?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eed0978-c90f-4aa8-e34c-08dc73435db3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 11:53:55.3950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8YspL/AhSQtEqRvd9tQYVzZHhC2GGx4pY7H+h9/DsHQwrhqCgKBKbGVV9Pr6+e6ua2hJvRCtoyeSQPJuGMuCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7121

Nothing useful is done with the LPA variable in lynx_pcs_get_state_2500basex(),
we can just remove the read.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/pcs/pcs-lynx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index 853b8c138718..b79aedad855b 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -61,11 +61,10 @@ static void lynx_pcs_get_state_usxgmii(struct mdio_device *pcs,
 static void lynx_pcs_get_state_2500basex(struct mdio_device *pcs,
 					 struct phylink_link_state *state)
 {
-	int bmsr, lpa;
+	int bmsr;
 
 	bmsr = mdiodev_read(pcs, MII_BMSR);
-	lpa = mdiodev_read(pcs, MII_LPA);
-	if (bmsr < 0 || lpa < 0) {
+	if (bmsr < 0) {
 		state->link = false;
 		return;
 	}
-- 
2.34.1


