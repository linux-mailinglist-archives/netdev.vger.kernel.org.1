Return-Path: <netdev+bounces-173750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A42BEA5B8E0
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 06:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E88627A67BF
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 05:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E2A225A38;
	Tue, 11 Mar 2025 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LTGGb2OM"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013025.outbound.protection.outlook.com [40.107.159.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC4322576E;
	Tue, 11 Mar 2025 05:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741672606; cv=fail; b=J5R1O6EpVFdI8E8FqCHOGniwdl9b1J2tpKaenH2Q1GMxacJQvi00H/5hM8a/bV7rZ2SkMSy/0G4ZKORQmwGxNlDqnzlWoW5HhZS0Z13kwBNxe2AqVwQcYkibUCHk9KkoRGx/wq8EtvW2syzpX3/Y5aEAfvyPlPTEDlGOmBC7aMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741672606; c=relaxed/simple;
	bh=l3+oGmRoX4QhjhrLxwkOHweXlGQQXCYY5VkywGoAioQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kv9awXq32ELRjfaPuwmcV4N9lZL8NjUx/ltkqMvu0P7kprCBK45M1+TnpGs61jA7pEPQfHDb41qoxFMrA+38p0ldP6O2QgDacGasFl3oWephTOq9jOSexBA+3Nuqr63fIdslzUaDp7GuzHHKTGhA/Wp3tgzdFw1vkbVY8SK8Zu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LTGGb2OM; arc=fail smtp.client-ip=40.107.159.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/al8S1/Ya/L1MeQrOrGw2GCojzmJH+IY4iHU6bFZLqZ9WxWwgDN4gZLeHYdquMs5HdQancl+nIDWXqR3GiNVTnwLUeHxW1PP4Q0qrBZmeKktAGw0H18ubjQsRQuMnxlKAsU1AoDkODWdgNjrJmgAUm458lohCvXvf7BXmzPJ8dP5Pqz5rzZpltHYRPcmvEZ8rRW4PHcMUmBbKT5EUTOFW2lDogZ0UYBbh99znJqVlN9bxPgr26G9GcRSc3hdofWJohO8x1oQ8h53h49Gtd7PurJonHLacbMvv8k7gGnCVIOYycgwbqcjdZBZWBAJwBtp1L8qZQCDWmhdIMMQIdQ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qzDxX0DIlMzbmGUBw7+OLnlgDRwamz3CNAwoupBurQ=;
 b=TbRY8xOkRe4MLH6izDXBumus/w/6M5s6vjl7akaA5NXPJplqewuQ0cWRNh1N/riDw6wSRr7m/cGDpKjUOzFuCzXWptZ4zbnQURmkk/RpXNP4Kat0t+9/En3bFyLwCB+oTxlErCqt5DZ3kUUoHpU5qENGL8iOOl+EO6RGR73BssfOSFL9ulvyB9m+N/jWkjtGSei3ggTZTlZj8ENG3qJ796UgT9Unu9H0A1gXGyyrRnsWzkrh/yMLjPxx+3rj0Jki+4EzB2E1+0jEdzT59nAYLJ8GTWnQ95bWsmSGjClVQcqA/anz/E3kZVSZl6eQNR2ugKKG3UZcyE8ONJS1B7dViQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qzDxX0DIlMzbmGUBw7+OLnlgDRwamz3CNAwoupBurQ=;
 b=LTGGb2OMde69PQQD5YCtcsuH+uNMDh4/SA9Rzs89e28N9WGZ3qh1pDDC5OlHxjrRaiLX01N/nZWop1PoGeboRJ72zLphHCXDwgHBpem5oUfprQ4jkDRUrurGSuJK5yCn3bPGXwLG9dCTMy0MAcccdfrgR+Y7evrcDABTUAFpY45Pe5jyVRxtRL10l36ACMTSAsy77TkHbP5QkLIcDebc3FWYQZGIB3PAvhZlPkGPAYugU2S9GsPLPLV7/VWxFMBaHaJwfShRpsQpKDbttLRBdnwFPrGbnqmlFllQ03ZB8E3ezMhqL4zrDuSfEuZPj2pYP/fTknrt8wPKu5FSbhJcIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10945.eurprd04.prod.outlook.com (2603:10a6:150:21e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 05:56:40 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 05:56:40 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 08/14] net: enetc: add RSS support for i.MX95 ENETC PF
Date: Tue, 11 Mar 2025 13:38:24 +0800
Message-Id: <20250311053830.1516523-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311053830.1516523-1-wei.fang@nxp.com>
References: <20250311053830.1516523-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::23)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GVXPR04MB10945:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5c25b5-865e-4d50-387e-08dd60617df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bjjlhs1zobSnNfEWSYmPe/v45faQ9VmCThQUuXm/2Ep2LVQLO5bv18Qi3iLZ?=
 =?us-ascii?Q?fNodK1bYXoWE0yKInyM/ghy9ofdc0KZiUed6+yEPr6ex5jAkRLXYNEYIB2iv?=
 =?us-ascii?Q?FUhcZlKMDGOUxB6WYDMRcMg6GsGPWOboMAyTYLB+p/hByt3D6tC71zlWLqoc?=
 =?us-ascii?Q?xAt91thq7uSFehCNum1w5VwqN/+eA7ocHzKq1kk6jQXvKTibdTEsPwE+mZJx?=
 =?us-ascii?Q?8v6eCKDB3yhsR7+m8KqmLLj1+EH7fKCsDLcacd4xaxRkUI1TkBzhJkzxcwhI?=
 =?us-ascii?Q?DP3FuMnGQ2dGZOJb1PsmLIVwZYsHfTpS00L+ds8sscKH13eT+vxBXA03RRuO?=
 =?us-ascii?Q?a/8lRY46EdZ8V6lqqw6X9sqrGxoL737Kuq7IbIfKYA4tuc/VSuxxB3RkrCi5?=
 =?us-ascii?Q?sTuO+dP76IYkJgj3dO0O+a6Dm1nOSF5MtUWyMMUfHhFOUUvYtX3GXYVlSufF?=
 =?us-ascii?Q?Mh8yTt8l33NUlKvMM++FAausHMarO9MIvLsreBdc9kyupvybk4fNG9TGkOrC?=
 =?us-ascii?Q?TpPhChelBYkvgWs02q5xBWMPbWbypbbwHEQce2HiKYH+pS4EXQN8mjIbMWeb?=
 =?us-ascii?Q?2lsw4mbqG52fzdhcUV0Tp4SnmUxVHo5WBsoFgbxxiOKPXeT53ckbU3qENijQ?=
 =?us-ascii?Q?ChMfsiE3qptztGthlDuObMkv9dix1klFlga5ky392ZKzMY8Bv8CJUqKpzjZY?=
 =?us-ascii?Q?AH5aMle1Lxt2tD/jRS2nfYxLUrjlxibsKBGxGwyJngKN6VE22rQ0gp3n1c0s?=
 =?us-ascii?Q?QwcOJsd85OVQBF6vfh/F5a1OBhXhCZZPKNQBbtFACGYatTOZO+wJh/eugau+?=
 =?us-ascii?Q?G6KShA4/yxvK1t0dntIAslr48aIK5UGvp6QQ2udwwsHHsYF6+xr8c40GH5Fj?=
 =?us-ascii?Q?sEPw70uwsIpUI3QC9WzRkTuwqDnyT8h0CJRmbFF/IuHk+P+X7dF/4s7SijWZ?=
 =?us-ascii?Q?LR1RR0KNk+0i7K02Yi1kQR3+1XpLmlhjCMzj6/CyvJU6aJGgW5SdfSrDVQsk?=
 =?us-ascii?Q?PGNOfgA9j2XVthzIew8gLYJpZkzptwjSKOhyxgAe9R8gISxgIqCSpYfjRqLE?=
 =?us-ascii?Q?Qac2fYeX7Rvcb4SLqA3dlBjtVPFgrxeyWUjauDsyQ2hbDZDTnACoTAaIqWAZ?=
 =?us-ascii?Q?2Iblz/QcfgThvflo3napdxEni3G7n0C23haef8IBAwTb4m8X0HbCnDlOsj86?=
 =?us-ascii?Q?d9dUQDFWqx9N8z9K9J0b0lZJq9I2XCR5J+tBSVeBCWmCC9J1MZCN5mFBY7e5?=
 =?us-ascii?Q?SKxOG8o0XZkXPc4X6kVgdKRutuTKzvsHHy71Fx381VvObu4Ub5eWOwjl6sIO?=
 =?us-ascii?Q?Uz8eCqMwwYkuY2ptOo1XwNriX79hl6bgHy05EOd8k4wMXCXsYFaAkTXI76HY?=
 =?us-ascii?Q?r+oVaDCLThvkmJtt1kEOyzbnldF97+ICLS+UjbPvsLULt3PkUI7sgOsJb4wW?=
 =?us-ascii?Q?lztarQeO8e3+SFBXiMUGsI08JmHkqZiG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/xgHJnTMGgaHoURFXRH+2552opTOZB1CsOQJDU78C5rV5/DT+q711UmBUJaj?=
 =?us-ascii?Q?h9MkcU73y7cb5e3yhpzLAXYv4WQIsrlYnDyHhf4Nvgu2ua7MZOB+tXqEAMoZ?=
 =?us-ascii?Q?4P2RkpBMLyD1ShMCqhHdQCU7nWJZgPXwFi1NL/Jji0nkvLrLCoaajPQQ/fZf?=
 =?us-ascii?Q?dRfiI0o95BMkYTW88s/+0zgzUYKBwBXpASh0AWmXGC7PAqzSfFfOeElgWhr2?=
 =?us-ascii?Q?WXbFQNJz9i/2oS9xLerrn711WLH8L/xvMoj+Xg1h8jU+BfPGF193Cijh/Ac3?=
 =?us-ascii?Q?xIpypS092elK5/jXTRoGM+2nSwW5j0S8G6bVgczT7KfrWYeCKa1xRMdva6eo?=
 =?us-ascii?Q?fcokREW5bTyNrzW8dGo57ar6Aiyn2sucDeSVNYJHZFkBPr5OqAfbAoouwuyI?=
 =?us-ascii?Q?HNO7fNJ66ko7Jj+nmNoFPjJpcbaIVZexMdq8gU4y5oCYq9icucT/YWbvf5uD?=
 =?us-ascii?Q?gHIsmqvfnDR+39XtVZWAOVCf+GVqPpR2t7tlkYoGtMz8fBswCIf9hAUzWmCO?=
 =?us-ascii?Q?0BQJvFJdh4JIay411lwlAHdewF2zZXOSMS8ctFkQPf/HRu3pj5UxPCno4m2e?=
 =?us-ascii?Q?ob085PY9SHhax1/SR3x7j9W4c3ReqHKP84dCIYJOB8UUK2uOj5Y5k9r4E82K?=
 =?us-ascii?Q?z021QsCuywJTPYXchuqMjo805rhhZv+PSdc7blMfvGwLW1ZXRT7+ao1uCcMr?=
 =?us-ascii?Q?wRVtPsvvzmG1zQTCTJCiXbZ48gyqKHWCRE/aBrI3VJ1l2SpaUk/nlwJcnkNe?=
 =?us-ascii?Q?mh/FExBM+cC9rALEgzDxU9Uiwo1k78eFhWW+o0HuB38dJyiiZKwMDNNaM30c?=
 =?us-ascii?Q?ooNgiGLrTMn6rqOMnGPK/uF0smLp7zTAvo/6iw3jOXDo45VZIWlldX+OB3TA?=
 =?us-ascii?Q?yvpwlDyKOkjgmfitJP7XpsEOW0U7lE22j294l1TC4IRnw+hthxBn4VqHpYEq?=
 =?us-ascii?Q?A9r/XH+unIaYMap2WDNYE+li1uZmvCkhnpD+f0w8GFte0hwes3m55UmZxpL3?=
 =?us-ascii?Q?3Kc7ca0cqsD6B7YxBLTDniubcgHwSTqNhovWaJ7yuwrHIVhfxbPiu1qS2bTn?=
 =?us-ascii?Q?jx5ZR6z8gLUEQXdVBSi1FCNnN4/CKS/eoNPBqUQMMWb1vQSOdZQMUQTb2tfK?=
 =?us-ascii?Q?Q7vg8AFVEWl64px3LOeXC9dCx6FvgDcQlW0DYZrZX6fHyjIgFmqxy6unrAd2?=
 =?us-ascii?Q?OtMHPnQpTu27LPGs4IjsTuXcAXcUAitGenrRu4i3E3RWTkKLTq3EspQw874P?=
 =?us-ascii?Q?djBL5fV95NQTEaTxochPZ6tU88O/JRQwiinuRkMrxSmr+MjGJde5MH4dBBNr?=
 =?us-ascii?Q?CcgjeynteEfko3m63SetuptfaE1egVLkXMxHiFFxFocKXLyoD+Y4066sasBt?=
 =?us-ascii?Q?ehx1PNROoFqyDbz8BETm8SpJb4PKqi49k/iIH6RZKDoeUbTKGMZ+bkIjpwoZ?=
 =?us-ascii?Q?ZkIZFC6yyiiemdSg2yO9kMKmh8lQieBNNyNkkeDdj9AEO8XHzzUAE+6oehRd?=
 =?us-ascii?Q?v512o9JO4dA19LhiDX1v2w6eXyJIRzhalbhXkpDJ+wDNzXeQtI4MQNxjCyZH?=
 =?us-ascii?Q?XxgED8NLobCnD1r3mnmelz18az8n5E+Y/XTtILuc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5c25b5-865e-4d50-387e-08dd60617df6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 05:56:39.9995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1wauOI1gwi7cgQIacWwl9X4dnWUkW1bi+KrhM5LmfPlsPt7UTit7PQG/3PPXHGoRD9X1OAw8eqh/JcT6QhpDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10945

Compared with LS1028A, there are two main differences: first, i.MX95
ENETC uses NTMP 2.0 to manage the RSS table, and second, the offset
of the RSS Key registers is different. Some modifications have been
made in the previous patches based on these differences to ensure that
the relevant interfaces are compatible with i.MX95. So it's time to
add RSS support to i.MX95 ENETC PF.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  |  5 +--
 drivers/net/ethernet/freescale/enetc/enetc.h  |  2 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 11 +++++
 .../net/ethernet/freescale/enetc/enetc_cbdr.c | 14 +++++++
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 42 ++++++++++++++++---
 .../freescale/enetc/enetc_pf_common.c         |  6 +--
 6 files changed, 67 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 2a8fa455e96b..5b5e65ac8fab 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2436,10 +2436,7 @@ int enetc_configure_si(struct enetc_ndev_priv *priv)
 	if (si->hw_features & ENETC_SI_F_LSO)
 		enetc_set_lso_flags_mask(hw);
 
-	/* TODO: RSS support for i.MX95 will be supported later, and the
-	 * is_enetc_rev1() condition will be removed
-	 */
-	if (si->num_rss && is_enetc_rev1(si)) {
+	if (si->num_rss) {
 		err = enetc_setup_default_rss_table(si, priv->num_rx_rings);
 		if (err)
 			return err;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index a3ce324c716c..ecf79338cd79 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -543,6 +543,8 @@ void enetc_set_rss_key(struct enetc_si *si, const u8 *bytes);
 int enetc_get_rss_table(struct enetc_si *si, u32 *table, int count);
 int enetc_set_rss_table(struct enetc_si *si, const u32 *table, int count);
 int enetc_send_cmd(struct enetc_si *si, struct enetc_cbd *cbd);
+int enetc4_get_rss_table(struct enetc_si *si, u32 *table, int count);
+int enetc4_set_rss_table(struct enetc_si *si, const u32 *table, int count);
 
 static inline void *enetc_cbd_alloc_data_mem(struct enetc_si *si,
 					     struct enetc_cbd *cbd,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index f991e1aae85c..53dbd5d71859 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -693,6 +693,14 @@ static void enetc4_pf_set_rx_mode(struct net_device *ndev)
 	queue_work(si->workqueue, &si->rx_mode_task);
 }
 
+static int enetc4_pf_set_features(struct net_device *ndev,
+				  netdev_features_t features)
+{
+	enetc_set_features(ndev, features);
+
+	return 0;
+}
+
 static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_open		= enetc_open,
 	.ndo_stop		= enetc_close,
@@ -700,6 +708,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_get_stats		= enetc_get_stats,
 	.ndo_set_mac_address	= enetc_pf_set_mac_addr,
 	.ndo_set_rx_mode	= enetc4_pf_set_rx_mode,
+	.ndo_set_features	= enetc4_pf_set_features,
 };
 
 static struct phylink_pcs *
@@ -1108,6 +1117,8 @@ static void enetc4_pf_netdev_destroy(struct enetc_si *si)
 static const struct enetc_si_ops enetc4_psi_ops = {
 	.setup_cbdr = enetc4_setup_cbdr,
 	.teardown_cbdr = enetc4_teardown_cbdr,
+	.get_rss_table = enetc4_get_rss_table,
+	.set_rss_table = enetc4_set_rss_table,
 };
 
 static int enetc4_pf_wq_task_init(struct enetc_si *si)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c b/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
index 4e5125331d7b..1a74b93f1fd3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
@@ -299,3 +299,17 @@ int enetc_set_rss_table(struct enetc_si *si, const u32 *table, int count)
 	return enetc_cmd_rss_table(si, (u32 *)table, count, false);
 }
 EXPORT_SYMBOL_GPL(enetc_set_rss_table);
+
+int enetc4_get_rss_table(struct enetc_si *si, u32 *table, int count)
+{
+	return ntmp_rsst_query_or_update_entry(&si->ntmp.cbdrs,
+					       table, count, true);
+}
+EXPORT_SYMBOL_GPL(enetc4_get_rss_table);
+
+int enetc4_set_rss_table(struct enetc_si *si, const u32 *table, int count)
+{
+	return ntmp_rsst_query_or_update_entry(&si->ntmp.cbdrs,
+					       (u32 *)table, count, false);
+}
+EXPORT_SYMBOL_GPL(enetc4_set_rss_table);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 1a8fae3c406b..bc65135925b8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -625,6 +625,24 @@ static int enetc_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *rxnfc,
 	return 0;
 }
 
+static int enetc4_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *rxnfc,
+			    u32 *rule_locs)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+
+	switch (rxnfc->cmd) {
+	case ETHTOOL_GRXRINGS:
+		rxnfc->data = priv->num_rx_rings;
+		break;
+	case ETHTOOL_GRXFH:
+		return enetc_get_rsshash(rxnfc);
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int enetc_set_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *rxnfc)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
@@ -685,22 +703,29 @@ static int enetc_get_rss_key_base(struct enetc_si *si)
 	return ENETC4_PRSSKR(0);
 }
 
+static void enetc_get_rss_key(struct enetc_si *si, const u8 *key)
+{
+	int base = enetc_get_rss_key_base(si);
+	struct enetc_hw *hw = &si->hw;
+	int i;
+
+	for (i = 0; i < ENETC_RSSHASH_KEY_SIZE / 4; i++)
+		((u32 *)key)[i] = enetc_port_rd(hw, base + i * 4);
+}
+
 static int enetc_get_rxfh(struct net_device *ndev,
 			  struct ethtool_rxfh_param *rxfh)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_si *si = priv->si;
-	struct enetc_hw *hw = &si->hw;
-	int err = 0, i;
+	int err = 0;
 
 	/* return hash function */
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
 
 	/* return hash key */
-	if (rxfh->key && hw->port)
-		for (i = 0; i < ENETC_RSSHASH_KEY_SIZE / 4; i++)
-			((u32 *)rxfh->key)[i] = enetc_port_rd(hw,
-							      ENETC_PRSSK(i));
+	if (rxfh->key && enetc_si_is_pf(si))
+		enetc_get_rss_key(si, rxfh->key);
 
 	/* return RSS table */
 	if (rxfh->indir)
@@ -1249,6 +1274,11 @@ const struct ethtool_ops enetc4_pf_ethtool_ops = {
 	.set_wol = enetc_set_wol,
 	.get_pauseparam = enetc_get_pauseparam,
 	.set_pauseparam = enetc_set_pauseparam,
+	.get_rxnfc = enetc4_get_rxnfc,
+	.get_rxfh_key_size = enetc_get_rxfh_key_size,
+	.get_rxfh_indir_size = enetc_get_rxfh_indir_size,
+	.get_rxfh = enetc_get_rxfh,
+	.set_rxfh = enetc_set_rxfh,
 };
 
 void enetc_set_ethtool_ops(struct net_device *ndev)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 3fd9b0727875..c346e0e3ad37 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -128,15 +128,15 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	if (si->hw_features & ENETC_SI_F_LSO)
 		priv->active_offloads |= ENETC_F_LSO;
 
+	if (si->num_rss)
+		ndev->hw_features |= NETIF_F_RXHASH;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
 		goto end;
 	}
 
-	if (si->num_rss)
-		ndev->hw_features |= NETIF_F_RXHASH;
-
 	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
 			     NETDEV_XDP_ACT_NDO_XMIT_SG;
-- 
2.34.1


