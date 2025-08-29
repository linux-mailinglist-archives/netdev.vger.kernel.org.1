Return-Path: <netdev+bounces-218118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C13CEB3B288
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 07:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672A51C85F63
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 05:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F682247289;
	Fri, 29 Aug 2025 05:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TQkemnfQ"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B099024676A;
	Fri, 29 Aug 2025 05:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445299; cv=fail; b=rovTAl/fFuRkf4LHfX1tCK6ckvORdwuj1BEubiibFpku6JbO3IddXgmX9FRUPgT6bvm4zwKxGazQwXGL/pAKvLt6tbk6eT3kreP4USZtI6z2RhgopdLPAme4o8nrn5HjYMc34i7u4VzeIcXeLpP+P1SvHP7xIXXLhwk49zMUf4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445299; c=relaxed/simple;
	bh=hF5UNdOdmYEvr3YO4bJQXUPYEmdEGigM7FH1BEk/g48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hy9EXmXA3TKdsNMcLQurVMjxvb4eic0I8YVwWCbhS8HoVL+B2s4shM6Qa3UfG7i4n8k3Sz5zMWErbUOfoOCqXtrTi4wrb/OhAxv0AdD5xrNVz1hIbGVUov5I+IrfXA2XNEqKm7fInLUn92zRfAA+VHumqv3jHRdN1iDK24f/i9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TQkemnfQ; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OASVu9KeuWwBkrc0skngNFYSBpMxib2IkEDgVReXRCgyuINpkE9jk7f7kBHoA++XCbudJpGgd5s5kNEueIS4EIJ7c2HWqGhv8ndTFb+kueHxMUqcBzOkvamgmFrkkQXxX6pCxyxQoJ6nErmM72kg8ySAZM5HanTblJDioSTj+gtb9vVUcFciQh1daSyKr3PtSI3v9akURSWwL1Q9OLzZKZfI9UOJ99IT7qdPqiNcJqLKOl/1NS9abVmXJKoPfjSWhGZp44b367CKBqYM4WZxMVkAUPhePRSThUR/NS3uoJMVXLEvtgTxUBrkKUHvhT73GIPhDUo4vCYF0Mx/FBhQ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po+Mxy+DD4z8KMzOHp0GSlH9ZT/h6MhFpuYY4gieH/o=;
 b=Da9+vzH9EtfTxhSuvGQv7QC+mii1YFQWBZUUMHW0TZ6sMkLkvFQWOBln/eaX+JgzwMAe35Q5RXfQL/LwbWQhis8WSzjwlZVAElQXBBxFmnP0VaqBE9erwzQRnSmTlp5eV6vHkaIdqwwzfL+w43s89VZl/sVclkCtdLr5oAxgteAzweZNWcigocMSkgx9oaftXh2tT63kClQl4YWzRGu4CQ8BTMZ3+vIaPUJhkfttKUzJrf1oVJqhKRNpyiXeCRbdObukYynvFt05dPLt88/HNr880wnczKyCmLzv1mwGUMuHF10bIytiIuDNgNGvGOuVQrjsI0IpTfzPuwzEAhElEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po+Mxy+DD4z8KMzOHp0GSlH9ZT/h6MhFpuYY4gieH/o=;
 b=TQkemnfQ2Wtb3HdE6WWcfbheEKcjVQc9oaw8gRjIO42HSlRFxK3cclARULN4DvnJs4IEad6HbQBrTA1/bGn9/JQqVTqXrwF+qOHffwsMjo7EmFqAFc+0cJhNhMo/8BWljfxN8l/JsSnomkfoaaJF4JUcki0PI80d97AuMgY2D5/o1WDsDgATx6XWF3jCvLUjAa/tEHZwp/ndzEPF9AkTVhJfU+ldpW8MObGFpqyYeJxhJp3M8LK9VvgS/U06Q46SRAb2QW7leyd2ksmprr6S5R9IyBVf/hlNy20FmONWO0aGQ/SIY0KP+IZM1iuGLZACEibEaOyOwR7W15jnLKkFjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB8PR04MB6828.eurprd04.prod.outlook.com (2603:10a6:10:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Fri, 29 Aug
 2025 05:28:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:28:14 +0000
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
Subject: [PATCH v7 net-next 11/14] net: enetc: remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check
Date: Fri, 29 Aug 2025 13:06:12 +0800
Message-Id: <20250829050615.1247468-12-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 736b0097-5464-491a-776f-08dde6bcda43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sQWJTDB76idGtKFqATEAov3Bwp1en3JidriQk3nLLtkuBbW4ZyBSLluPf3id?=
 =?us-ascii?Q?g0zVhWLDQOMsHu1LF70igScKby63mZloury8hWrzTx6vkCh5uwoi8rWWZx5x?=
 =?us-ascii?Q?czzYNJn2yGbUDJG7Zh7lGkZpzyIjPrtzoIggW3qVbgdpZEBXUf2vLzIV9bgq?=
 =?us-ascii?Q?kZb9GfQVuxvpBTm3hzREiHIh6wto5Cd5Der+DbAuBNMbNfHMYI85xx3cbnv7?=
 =?us-ascii?Q?8G/y/qCp4UofkTik+dI554vVZgHLjyRhUl7eqS/8GD3b7YjGciVGzl3m2SKf?=
 =?us-ascii?Q?QapDHbNCGgpwrcvZGpjxIfZ6x2cEYH7njhutoToL1+Dvdo+LKzKS8lBBQiRd?=
 =?us-ascii?Q?EANOGrH4C0sVLG9dFJ//K/jHJ1/qBesrZKplT+GDXcYlkuDB+r3kG+z/jc0b?=
 =?us-ascii?Q?5GYJNDiCK6FNijxYYdeO1UgY2lFEXuSVTYV8JGi6hR1X+MN7FkBdUe7+xgtx?=
 =?us-ascii?Q?5UjGniIyYs7Wf/oFHwUS4UUoUoR5++hEsasAEjojOWCe8UJdfT9LfKc0lVQu?=
 =?us-ascii?Q?+Zco9zew23aZSF8pH7uI9EjX85A8hS1c33N6ZHck1p+s6ZngdBa365vnA9rn?=
 =?us-ascii?Q?VGs1ITOOrylVLKYQoXCy6Kfx27/7/3Yo1zwNlV3wPf8e+871ctRJ/EvUY7l7?=
 =?us-ascii?Q?hqWvpX/oHcDCBudEkF7OTUvIFrXqba1gALbOAze4eZluFY7OoCIAig71y6b/?=
 =?us-ascii?Q?wxuFC7H8FjQ9F+/5aoP+kHSvYvo3GNAe++sMuwxPkCYJkSLAQPLZ4+WIgpy6?=
 =?us-ascii?Q?Rj1N7EjO7qfyu51vuadDeyPj4X0ekachzflcMk9Qe0Y1eEs2tDKZlVy9Aln3?=
 =?us-ascii?Q?uUPWs8OILICzDiPwEfXvc+zwWsGm22xq5LdbAgCO1JdLBCKN4+OXyf6pd+E4?=
 =?us-ascii?Q?IwgddnCH8z6QxJ/COcrvq+id+C1FNsHXd3Ssj2It8yp8bMq0iyStegMR45HT?=
 =?us-ascii?Q?VQQjXlhNw4DFIUpyYyocK09+pu26zVPzfx2uew8DOVDeUF9I40wkQFdoQI8f?=
 =?us-ascii?Q?plpzBqnHYRowAUE/RonkT6gRg0ucY4kgihEKga1eA8Ojdzb/SsZcigOa64un?=
 =?us-ascii?Q?lmoFAq2JK68br/WAnZWK/ertuErRWDJd+hLquP/yjJOX27QMMVkaUUput+Yi?=
 =?us-ascii?Q?uJXCIeJSXtoU7WSS1dJxGMF1qRPUJlQidnOwZC6zVKgV8+Y8Cx3woJHbIQDB?=
 =?us-ascii?Q?rKNt6GiwH2MCXsFIzZdJJad/2SwGX3PYHNlIT9ckPjHDqfycvYOBHk6CxUAd?=
 =?us-ascii?Q?CfZTO8eEstPX2dpuPnswgsXCGzuRHIw6RfmP0xAxDAZ/shhifPSKXs7v8wle?=
 =?us-ascii?Q?yqk7Qc2ES+xdXjb3yZG79d+K5Uoc2u8m5gPfFq40p0Do12nICYVVCxMS4Nba?=
 =?us-ascii?Q?tGTF2B+5zuQC01UuP8GDKZBlpwSLVX1WBnHAPlIwM1EHK/cnVSo95mLvdh12?=
 =?us-ascii?Q?pu+M+IyimbHbtqjH9tFXDw53TYLP2dvM4CXQep3KU11c3cnf1iuLuKIIkr+x?=
 =?us-ascii?Q?zE1AkIOVazRborQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iTT1x0lCwhhZqEL6xbxWproHJPl2IkjcO+Ww+N06E0qDNg9PSXj/NG7Di7Xz?=
 =?us-ascii?Q?p6UslRNMKc7kgGJ5xUoKT1wEU3BumQvmNjJox5w8TeFAIyu3lMvJQ6h17anr?=
 =?us-ascii?Q?I0xJt0Dtdzj3hCdkJMnsNRCjTddyh4MzVDn6bGgDA6zCcVL3fudpKKu5W96p?=
 =?us-ascii?Q?GHYWC0D8Mpla+P+QdeAlLEZdxvDxkoho1gVbBRbSDA2jYedLi/KEPHe5XSYy?=
 =?us-ascii?Q?w7GTPp85jpM3JF+QMREtIUkEo7RJPwvL0Pp00e9eUe3DqUP8nj+EliuZ7xgg?=
 =?us-ascii?Q?53Ocfjk/aGpJXLJF0wazkS/SQNl0lnNAyE0aQC0g8p9JBmt/M8MCyBsDLyN+?=
 =?us-ascii?Q?AzNFCz5HL7Wr311h8csXQkkT6gqsCMFWX+j+i438bYAiOV81K/eeVSt6FSK7?=
 =?us-ascii?Q?QJv4l2ywz/cJnJ3TSW/Ar+12gmDeqrZgdYRyVxxPn8lvRcYwZaEMCsiugTD0?=
 =?us-ascii?Q?RgefW6OAH0Hj6QaiW8ex7nwYS5zOWYD5X5BpZhAwJnC3YIk9XyO2348fZDOA?=
 =?us-ascii?Q?dz04K4wvYWqvmuE5Xq1pdLg0Hw2AUarPzIIOTPd55FwruYZ1NF8B2+PgtDEl?=
 =?us-ascii?Q?QfIfG/pE6Lw6eAlvIjKYHU52flj6reGf1dhMCSs6usqR/pfSCQl0U0hGeZez?=
 =?us-ascii?Q?mZzaJz72XRa8bM7X0PYZW8MH8JrjJ9zQvYxs+5Sm4AgbyEUp+7RioRV4bIsf?=
 =?us-ascii?Q?DnmxKzoMKNunm65+nupvevN6wyXr4eG4WUftCcVoeBfOQs4LR5N1eY5oJNMt?=
 =?us-ascii?Q?j+sFevg2WA8sPUMojXDHnmPKbujtgceD2q/JSmcaE5J9Qgw7tcCwWgh+t0J9?=
 =?us-ascii?Q?f4hIro+g8Opv46MnNcYKsllF86X5BgJcSEatWHoAxt9wbZI4lO0u/1HACkrT?=
 =?us-ascii?Q?4D0HpRtNVK2KA5IBrkVxb1MPFVvw2zyOSLLvWkEgMMlFcIgDaC8m0fT7N0eC?=
 =?us-ascii?Q?84/3nHQVt13LoVDKBPRfkdv3WOhJnCCDHtAbPnTNlNLk3h3dMEMHrg9t7MqB?=
 =?us-ascii?Q?1l8I/4r4PvTuakIXrGsQ55fmueu4AmXBs33XuClM8BhOVPCKb9bMOksuTo2u?=
 =?us-ascii?Q?Sv+lMpLy1t2NdJrfFtvdc89lIE4SpOaF4llFdLBvdtjZoGh/Jkg4urQQbtvo?=
 =?us-ascii?Q?LDIP4MSmE2MQA46ozOL3hUF0U2ZaOJFggBS/qmzzzD3IHwTeG3jnHrGDoXNU?=
 =?us-ascii?Q?vsSqzKgZAdoTWwUcGJe/McNL/SWRmJ1uEqkroipmbmvok4kwt9EScsMtCNQr?=
 =?us-ascii?Q?8eQ1EXKZE13+lpRcA6oPPyM76cFJA9Y+8cudigSuMprE7I32GJ/QWROtdaY4?=
 =?us-ascii?Q?qed3aBB+QtRjsZMWiFFHf9IEvJi1hoe4XcMezphA2BKjHeIQV5mqXnH1fXRY?=
 =?us-ascii?Q?rOKP7NXilhvSs4m4ebz1Q4iv+zw8L9DOC1jv8OnqwGgP9noc5KjvCfw7q9z6?=
 =?us-ascii?Q?ilzKBkRBJDUoC+rLIj28lKembg3p0CevFjsD/SaxEb9vo93tRJAt9HPDARZY?=
 =?us-ascii?Q?ABmjaehog6NroPdHBHHfS9h+HoMQd7Oqr+r6zOrMQhNTv9qcCWYpjaMYn54b?=
 =?us-ascii?Q?LReJjJBU0Bml0skmth+onhNs6CP64l9sIUNMEw+f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736b0097-5464-491a-776f-08dde6bcda43
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:28:14.9247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rk1GS+SLv1uj/mHETfvvvwVEmZkotcbWeI0SlZq+naFkTWbqFijF3jB0Q9MC8wO7mzhFXlvFBjWqna/C7cG1TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6828

The ENETC_F_RX_TSTAMP flag of priv->active_offloads can only be set when
CONFIG_FSL_ENETC_PTP_CLOCK is enabled. Similarly, rx_ring->ext_en can
only be set when CONFIG_FSL_ENETC_PTP_CLOCK is enabled as well. So it is
safe to remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 +--
 drivers/net/ethernet/freescale/enetc/enetc.h | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index ef002ed2fdb9..4325eb3d9481 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1411,8 +1411,7 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 		__vlan_hwaccel_put_tag(skb, tpid, le16_to_cpu(rxbd->r.vlan_opt));
 	}
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) &&
-	    (priv->active_offloads & ENETC_F_RX_TSTAMP))
+	if (priv->active_offloads & ENETC_F_RX_TSTAMP)
 		enetc_get_rx_tstamp(rx_ring->ndev, rxbd, skb);
 }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index ce3fed95091b..c65aa7b88122 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -226,7 +226,7 @@ static inline union enetc_rx_bd *enetc_rxbd(struct enetc_bdr *rx_ring, int i)
 {
 	int hw_idx = i;
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
+	if (rx_ring->ext_en)
 		hw_idx = 2 * i;
 
 	return &(((union enetc_rx_bd *)rx_ring->bd_base)[hw_idx]);
@@ -240,7 +240,7 @@ static inline void enetc_rxbd_next(struct enetc_bdr *rx_ring,
 
 	new_rxbd++;
 
-	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) && rx_ring->ext_en)
+	if (rx_ring->ext_en)
 		new_rxbd++;
 
 	if (unlikely(++new_index == rx_ring->bd_count)) {
-- 
2.34.1


