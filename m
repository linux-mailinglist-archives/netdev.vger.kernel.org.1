Return-Path: <netdev+bounces-169639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 817A8A44F22
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 22:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89FBB7A8622
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 21:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191F71A3169;
	Tue, 25 Feb 2025 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T+a0yI/G"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C163209
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 21:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519925; cv=fail; b=Pj58qwiZH1OGkLQ1ESVEylia30dWb6ELv0QQdSrOYHE+E76aF8ABDZAOsGTVLXoTqI/95qe/u0npxvIfQhUEYbmpb0CCmadGG3pFM2t8mBTQZeJXCR83TAiM5AgbhbgLdZWqYBFbTHTrHWWbeD7mQhqBlc3GCy3evD6Xu5xAy+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519925; c=relaxed/simple;
	bh=UZR9uO8QbZBgeAo4pklt7qKo3OqGhTjWToecux3VejU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tpKCc8e1jan+IDyFVlNgTJcpGocnnkQeXjLHtg8v/nfa9x0CENU11kwfsK87D+FevohatdppDmioEYgv1+NJrjT59kIHN98zJ/wCnaNnSmmMkgATfH2iX6BVDKUvemqPVP1u+3api1sMhl1LdV7AgTiNSdPjwrg4+NeEhOe4ub0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T+a0yI/G; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKPKLY4XcXi5v+O4XEuX97ks4juDodp223ernqBzkl1G7qT73wa05FAJ1lQNi72cVFLHH2KOWX/3f152N6z6cwNuAhmGwRyWJkFt89nJtFHkMg+wA3NFZpnBLWsU87cnyI3ara073+jt0LED6H2wEIvddFZukqNpHddUGBN9a4R/I/NS+fSxNE+YA4EeqSVNoMI7Gou6Fcx8D2xkkUvoaVfpZthDbKT2GGWVaLTtZ0m4k9iGj/2l/zfx1qtTmiC2UrpkUp6Hdq/hbXO6UPKZKEJDmN3c1q4mgySzojF8PVdqyV7at8oqSzz+cojxQlKyzUkWygVg/kP9pijT+WW/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Fif+ghJQkKPt6PdJSUUpGpjV52ssT4VmU0SSOPG25M=;
 b=o/WF/JAHe6fUPIfIlqy3+u8BZljSka5MxlbE5Vf07EWxgvNePTcI+hoTFxArJsuvAX4pddC4ZgtIAI/Ly9h96SdWwbbKM3FXYTaTJyss7pQmTgwotfiBX2lZFpm+XglheLxoYOhW/0mzPQlJRiUH/s5/lDSBMIaSV7211/kaGK6GmkEqj2h3DD5lyFcRvw4UnTA77U6k08xgnXd1quOrcZrkYilqsyOhB8khykGuM66YLyrTKZagwq5+SVYfap7deC8bLG+Y87M6NCOqQn0Qb5nIge2bAPTeN3wumFeerXPXH+HpZeJ+WJuE6p3t/dFGdPZ8czvOptaHJiQyOEL5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Fif+ghJQkKPt6PdJSUUpGpjV52ssT4VmU0SSOPG25M=;
 b=T+a0yI/G/w8TEmGMXp41jCcx2ucQ9UoQqezHaJQ9HA/T4k+XSPR4f5fpqqGNnVNHjbUbUY0rUwzmKJZnM1IZ3ZMmYXTNZRV14f4W+DIZpHLuday4d6K7FGIeIARbmVWsBVVSTsHRyUOBL/E6ZLkBN8W06r0ViHMrbjGm6jtKSy1vqEPVAFWDGInhJA3MXXMb5trFNfy0UqSgAcUZK/QdhXgO50Hb3QWOf8WhZAuOe+8BfIGanIZ1TSnoMT/4c9B6qNnm3HuI0Q7fyLR9hztY+FIKH0/qMn1rMkxJ/gVuG5JUL7xjV9WHyl5C2T3RaBPcRo7mM0Jw2iRjLsOYXgR8Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by VI0PR04MB11047.eurprd04.prod.outlook.com (2603:10a6:800:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 21:45:19 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 21:45:18 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-imx@nxp.com,
	Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH net-next] net: enetc: Support ethernet aliases in dts.
Date: Tue, 25 Feb 2025 15:44:58 -0600
Message-ID: <20250225214458.658993-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:806:23::23) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|VI0PR04MB11047:EE_
X-MS-Office365-Filtering-Correlation-Id: eb61f82d-c45f-4fbf-e97d-08dd55e5b269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NUOORxnlb3dsFsD4cHdv2t6p2Ilia/jY1+bfH5m4s04coxZYc/YialbkvR5x?=
 =?us-ascii?Q?HJfC9om/ndcF8OSMlQ0+hJXCpd8OrhEwfcZJ0BEhcMgmztpgEU2ChzjFCgcR?=
 =?us-ascii?Q?0GmWyy0XsNEIbfZ/RP+S7DdgCqIPAVt8CR9Ao1QYBDKcOj1Mb3WJBLZf6bbG?=
 =?us-ascii?Q?5xAyZpVHSRwH/8HZ3tFTy66MzYgzNnFRQFAEk0oeCZPOTteS1jEvlw8gvK0L?=
 =?us-ascii?Q?c7lArUwW8RXxcE/XbiJgb8hyuKJTzX3a/aja2gYqSkHSG9h0wGKmABcbSfsn?=
 =?us-ascii?Q?IfDZZjuDHM2cuQbwBlhSqk9gpxbH1Cn4kB1ICdOwjgOkJd84pezY0aXLz8YC?=
 =?us-ascii?Q?gjg8Wov7VPRLRLUCqE5TiLts8xi6EzYslHmTviQxT1SmAzg3PfzdHZiQyAs0?=
 =?us-ascii?Q?z9yPGSq0hOOW1JEs/lRhVuaSmmWG+qIQCTphJrQKilWlqnNbg/IyczRheruC?=
 =?us-ascii?Q?O4IBfRSO7Tjjc9aXKRQuE9cYdXI0jKg8EjS3WNf8xM83Qo5cusaDUZ/OCQUu?=
 =?us-ascii?Q?S5zRKG1ofiV5M+Oib2BecYrSk/izEW3bFHNU6JguW54C7pH0BNXMtqRWAj3F?=
 =?us-ascii?Q?z6hYEUDWFHSqL6bHmUWRcVZApHbkEw52p9T+aed63WlLktCk1RQ6+wML+eN0?=
 =?us-ascii?Q?OBZpe64a58PbPQT42YteWrb2LhJLZTl1JQ/tlU9OT6RY6cqWEPgzf2nHtiaq?=
 =?us-ascii?Q?JBbsR06Wx9lZ4ekSYGlVzQYQaytt/zL0DRcOtB99MNRp+KRY+9Wx6QSngVnb?=
 =?us-ascii?Q?5xzvAOTGgkNKs2CoNnhtn6OhRnGyVTtiZpuIBNpSyuPWH07hnRxFrnIK+fhN?=
 =?us-ascii?Q?Pi4tdr+l7TffZ3SHFXLAaCQHls7KzQVGCQQGkYOyZ4vank+hDfyWJv2b2E8m?=
 =?us-ascii?Q?pWH64BLx8ZcYcTHvWedEj2uJM9ZF1NsPh557ZAYX4nVBD0WLtJjkXT/aTC9w?=
 =?us-ascii?Q?kqCIEH8VQxTPhAwx2Ho0/JJ12/4LTuFTCIV2ccVBGflSYGJI38e32PApErfX?=
 =?us-ascii?Q?MQDSQ/L8inwQnuRBstBRn53PhN/LP0JQqzArWXmZNnrlI5QfQ1PffSPRbmpa?=
 =?us-ascii?Q?HfTmXpjw/8yjGu7UgpbS6IQ9wH/hAn1Zf8FKD+xyUIQme3n8dUImhPYipZfZ?=
 =?us-ascii?Q?qKKVaxT5j8zzVvdi4B7phLvzE3C/CnydbXliZmV4EZq8AOP4GNG/6wQ/BkRo?=
 =?us-ascii?Q?DdWeGD2SWRYf1UrF11yzhaPG+HQ821JFkhPgTIojp+5Lye5GiYjfN5AQA/qL?=
 =?us-ascii?Q?HP7+ohJg/k77siRydKXXDExVAuUWlKaRNdUxOiIMbnAuK/LMo/aVO/z8v8tq?=
 =?us-ascii?Q?U40uGmwS4eb7NBl8ftUwpnNCPQRm52kKJWCFI1S9OKxC6/LrmOCKn2StmTIk?=
 =?us-ascii?Q?+5jiuELESFlvsHSP6UdX4PImndryTIOq2pU/UAdjKCRibgN+DRVE0TTw7lkP?=
 =?us-ascii?Q?0BROLeJFNPTsxB3w35fB/DlKXA9XD3/H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E5HSeiYCYxd5yT0N9wcW3U0dZAoc3jfcF9Uirmx4FF8mp7gxfXfuSUxj/85j?=
 =?us-ascii?Q?dKadDJkb0lRG/kx8mOd56OkKldCHdJuzRp1Gl3rE3GFME04ni67aOVERNYMh?=
 =?us-ascii?Q?LwR3GW2HVccOA3VrOW+fufdpP2wg/Kutiss22aitvCTJmfeFYdNRvQaRvt8d?=
 =?us-ascii?Q?+sXZm83WB7R2Y7V6yp20I08ChZrU2gNTqQK/xNdzci2pUG6x5qpSAacforY9?=
 =?us-ascii?Q?sz+PmbBC9fV8MqOGxgl+pgvu422YPlLSg3sXQbosBrFmQgUDCPY5RK4Kpxkf?=
 =?us-ascii?Q?+OMzV+MLbGLSidfMn6qPpYM95KOqatiTatSP4vl691BogEtx+749qg0FIQnC?=
 =?us-ascii?Q?mHstRjMTRxw1aJOFzfwrGP/BWqTPBqUn+S9cs19e0hYI8LXSrIQGK5Q9Rpel?=
 =?us-ascii?Q?HMumqXFJ1hKfUtwVaUgx5+WEF+a24/A4DSQkynOwwXVAJi8T3/r52fgGMc9g?=
 =?us-ascii?Q?G/+7K8Iq9BFrkS2b+yI0JNU3v36gJeeybXGY8i4hIivfIQTdGMaU98/UIXBX?=
 =?us-ascii?Q?JuY8ZU4jrPzafZjbTMlhGlm2bMSGUvRaUfg7bjwosFZREXFRPmhz1l5oO7fe?=
 =?us-ascii?Q?FNUcgXGzSKnP1O6eJ5KuJrkt/kzRyK3y3wP5rbvSfcg4nsLhT0qJPKRwgvIN?=
 =?us-ascii?Q?IwbwuRjMitJm8aQaMw6zh07iNJ+Yd0aPOlqn5uDtRAsCodnhQMKpLFb+JuB2?=
 =?us-ascii?Q?XJ66TDpdt/H1ul0U5ousLGf+gvMVndZv4Ql69ATtF4So1q9tc7MW7qLd9mVg?=
 =?us-ascii?Q?BmiW++EswfGCVUvHnBCE7hH1J0Ms21gZ8qDx3SCx7fk8gS+/li6m8WF86ZV4?=
 =?us-ascii?Q?xpUh9J3R9ImxWqGZ0sc3zrr4Hyh9fWwkWacnCpco/rP9oH706QeCDzmJ+TFN?=
 =?us-ascii?Q?BIuRqQRXK+SM6E564TvYMfnDgTNcX13wgA0DSqGlXOoxm8YdXImE13jnvmap?=
 =?us-ascii?Q?EvXDVMJy0BA73amNEFdiosoqefa3vXhuuBHRHzE4BvuJ6WhWGczHkPzpo2bc?=
 =?us-ascii?Q?usczMznkaLdy54GRX5wl/SubzD3Ey9YN6jWpKx9fegMnnDLr4lDymPRtIjlq?=
 =?us-ascii?Q?3fP+4w+Ik3zFCl81tqLoCzJw3C83DdEs50SqfGBanRcwcGMDXuYCRaB11mod?=
 =?us-ascii?Q?3pf4pdIUthrrLCrjjiswfsptT9k7YPCNB8B3v5aRu7eY8FYaR4OxV19VzRuZ?=
 =?us-ascii?Q?XMRjKygpwjDDsY/ZfXciFDcR+O4UJeSrzwfbRRoS/tmOC88Nqnhjek1LSvj6?=
 =?us-ascii?Q?57xDoHu1zGpUNpr2jW/K8g3CQsuF3Hs6zupz3F3gc4SbTPyhhuuC0a2VY/lx?=
 =?us-ascii?Q?5katdUeVylANe19A1FQ2rRCt35o2fg/wbFZ+DU+UtxCY7NXMxgjz1bcQtXlI?=
 =?us-ascii?Q?6ucruYvC1HXR9mKZ+qxKu/dnRqdH/RTNeh+9HyFcfegP6cbwpnQClgRdt4Hm?=
 =?us-ascii?Q?ZWzv6ehsK31yivVbbYVpGuJBGeAQguQNJTUubJP7OLQs4HA5B9GZDnVs8y2Y?=
 =?us-ascii?Q?eSNMcVUH67nXEYsOtwFWcIoJQKaSjylItEKe+UORZwrK2o4hFpfMbx8s8hvK?=
 =?us-ascii?Q?9JY7tNpKgQMv8MvkYynBpHwf6HHUkfaBYLfeQ84w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb61f82d-c45f-4fbf-e97d-08dd55e5b269
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 21:45:18.8077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OeG+nPDnYaQbcuINCvEs06h6ZZ/s9jfYfhAGUZtBR+a+d3YYWYR8B76RLh1w/xYymDeh94FKTc3cjZ64LWj6eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11047

Retrieve the "ethernet" alias ID from the DTS and assign it as the
interface name (e.g., "eth0", "eth1"). This ensures predictable naming
aligned with the DTS's configuration.

If no alias is defined, fall back to the kernel's default enumeration
to maintain backward compatibility.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index fc41078c4f5d..5ec8dc59e809 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -622,10 +622,20 @@ static int enetc4_pf_netdev_create(struct enetc_si *si)
 	struct device *dev = &si->pdev->dev;
 	struct enetc_ndev_priv *priv;
 	struct net_device *ndev;
+	char ifname[IFNAMSIZ];
 	int err;
 
-	ndev = alloc_etherdev_mqs(sizeof(struct enetc_ndev_priv),
-				  si->num_tx_rings, si->num_rx_rings);
+	err = of_alias_get_id(dev->of_node, "ethernet");
+	if (err >= 0) {
+		snprintf(ifname, IFNAMSIZ, "eth%d", err);
+		ndev = alloc_netdev_mqs(sizeof(struct enetc_ndev_priv),
+					ifname, NET_NAME_PREDICTABLE, ether_setup,
+					si->num_tx_rings, si->num_rx_rings);
+	} else {
+		ndev = alloc_etherdev_mqs(sizeof(struct enetc_ndev_priv),
+					  si->num_tx_rings, si->num_rx_rings);
+	}
+
 	if (!ndev)
 		return  -ENOMEM;
 
-- 
2.43.0


