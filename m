Return-Path: <netdev+bounces-56998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2326281185A
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C482810B2
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F059785363;
	Wed, 13 Dec 2023 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r6wWm1UD"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA5CF4
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 07:51:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCnBLo/H4eagsKcextRUa1yxhFaORFRDT9xrP1PgpAEtrZbMGpfwtk4aQPziQbBWY6ad0GgrdBzLCzpWRBvAPhuzgdWIuYQGxGX3+eK2QH4MdP1BRlMMm6OlQ2LE98/nmGr0lPfO5xIqdER2YatWdfiYk6UbSdQSMNehFqujhYVuiWlL5Y92giJwLdw0eqaFezaY5GPNE7/72a5vdWW4cij8frR/jmNa18rJCXtpTjGAO8EM0FEwcQGuSnZu73yLHqQ+XeHhhlwMIuXuf94EH99t+621Ab5esk5VpK2lSAqQdd7BgWwnRZIncPc4e5ohdSLyuv2rFUAQk8U3XAHVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBGU9F3Y9fQ9WTajUAlLWHnkIDyy6Ss9kVMWL4fClLM=;
 b=cB6YovU2O24SUfRtOp3DWR2Mss8v7vbxTFwG7DPo15VGI3R79xcnLb+QNYjL3Au34HXdNuPPPZqStvrima5xEMR9mLzpTm9p4uW/OL8GcXYdt+KurYgOUKMjjIX1OS5SRbBOVDBjnv9scNbn7GWltjlk2Imq7JEGiB4sQbSWPddOXrzRZyUggzpcNh22Emgv5Kda1comqDN5FhZo6QJnLLl2VEK2xRUJdZdBjNxJdkOgX5a5abgkQUYY55+7IPozUGw4nIfrvopJZZg0ALAL7XoUwHcl5jizu8B1bUqE+2H1WZ8/m7pHDGaZZPrN1tiasQle0P0UDcMqauaVXF5FaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBGU9F3Y9fQ9WTajUAlLWHnkIDyy6Ss9kVMWL4fClLM=;
 b=r6wWm1UD9/nGPI6SaRIse9NFjdg25ZUCZHx5Klsg4dzcsqVUO2pgn+cqSoAWHt6Z5FdGHTeBwRIM6jg/YoivTUKu0m5OGVjVeTv3hEy8Sd0a6nKvwn/GnVexFmEGmBoXBYdEwVO5peQM5zP+gCtFWx4wY81/OB545g7kAxaF/UE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB8106.eurprd04.prod.outlook.com (2603:10a6:10:24b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 15:51:55 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:51:55 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next] net: phylink: reimplement population of pl->supported for in-band
Date: Wed, 13 Dec 2023 17:51:42 +0200
Message-Id: <20231213155142.380779-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0088.eurprd05.prod.outlook.com
 (2603:10a6:208:136::28) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: f850b205-0339-458c-fffc-08dbfbf36eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aYA6gqkIto2eQx7J2iAUnHgKzrfyv+ztjD1APtV1pnPiLFBAfzeQYSjK9Wg5NOszjlQGZSqaL9kn6doUSHg9bj8VAX59PWvIqOEWrRKaKAVEyWGVZA3ilnPvPrR9UNOMxQigeoxhoDIQ1D7sh21o6L/1NlclGZuBgJC/XWbHvsUctfGIuB7MjQi/Sf5GapQYvAupFTVSjttqfG9yqU5Ml7z6oPAPmtRYjG447rfwINAi8MxG3cKiyRl48LoB40P5Wl3k67fNVBCQe6b4+sRPeOEtf1IBguiaHw81aptOkMTVmi5x4mUFxp3kcz0i8eCoGjhSeEUa01Q8UcKrAJndgaSggCXyVu3t1AE/brEgHRTc3VeSRtuPhfJ0AOxibP5wduG+SRCX6ak/oypzqSw8MNjhiC794HFeHnFaZUH1Vdird87i4hgVJ2c/qejI6f272CysLTROguywAd8I8N6E6j85yCH9mABqSbVOb1V/7J+FUb00pn7Ay/7fzwOmZbVSkz7ql/ySD6V+haLjjRs/E653B9QBLGAr2dX6asKShEHP3x/SVY/mAD0/hTY8q2vtjUL8AokIvjklmQtpDIKjScObW1bYKoIh84XvRK4Kd7dTmhBVMyuWcRTzItoddTFP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(2616005)(26005)(6666004)(6512007)(6506007)(86362001)(38350700005)(36756003)(38100700002)(5660300002)(8676002)(8936002)(44832011)(4326008)(52116002)(83380400001)(66476007)(54906003)(6916009)(66556008)(66946007)(41300700001)(2906002)(316002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HtRdMNMJ2fl7EdQZUwLzkFXpw8E/HZJPdEYsI2xUYRRZ9hOgJWyVTkDzSXA5?=
 =?us-ascii?Q?SKWXyJ3zbn1GB2SnQmzXwlTlerQOnJVUNRm/9AAxE5U5Sd1E90Fp03f3pfdk?=
 =?us-ascii?Q?c9TlCS3b+j5ZmBHrLel9EGZArGx2JiHckXK6YttDPKl+fsHi97xbtHvJlMDd?=
 =?us-ascii?Q?9zUAtbypZqy7exOgTtJGekNz2KMgOnpRZUQY3BZ2QWsRnTnOaf3+bPMNcnkY?=
 =?us-ascii?Q?oO1cgTuIbCf43V6vmj2jntpvW3W2QYae4XeQ6NuK3g3sjvBdDY9Srd5l4C96?=
 =?us-ascii?Q?LSMzlsKJs0ftPahXdIZkuPBkd5vjq2qD/iJO1BqN4BI1ysnoVulUckeo0Pm+?=
 =?us-ascii?Q?ydrLWEgnA2BSLwB777JIeJCF2jiTU/Ful9wlyK0Eeb1iYgtRk3tvUU+HvaNp?=
 =?us-ascii?Q?evKMn7N79VRAKU/KHo+axHZP4hM2vFDmnMJmaCdQfCa73WfqHugBmZLMzDMh?=
 =?us-ascii?Q?uQs+nm6LAJu0w6bx8N1jRag+jpE4Z6nCR8e55aG0TQ1QzuFPSC4RgblLhtba?=
 =?us-ascii?Q?pQHIN9Lo4cWzi8FB+KNN1szLSJySoirFOrVuHBNgKvRYJE7/nnyuJO9k587m?=
 =?us-ascii?Q?n4fvuHpfR+VJSBu+OSlbx23/ziiMQxwj+TWCOvZ97WKY5mlnctNek1MAbJvA?=
 =?us-ascii?Q?H8JZOxFtQgV1UU32OVesTAkRZtyCFYPYQxd52HS2G5Os95l+6a/BZjSTcTaS?=
 =?us-ascii?Q?yy9YcK9FhT+4XPkgcA1AFyzbp2mV20bqJ7ZqxNdqeUgp3CVdpNHNW/GgwOfv?=
 =?us-ascii?Q?0AluMu8hukCxfn8liyBFl5dCjGYZyUPPRitoS3rchC1kp/518+vRk2kf4syO?=
 =?us-ascii?Q?ed2TcMZu0YKl6eJlxhsMNfSOdL+FiQsl5+pLJtD9aTaqU0SaJkuQ83y39udg?=
 =?us-ascii?Q?sKj6J8SwQUMQ05BZrmSuD0DZNOsiJwbR/zHNqXbg1DehEPT5UYs1BAgeYZ4c?=
 =?us-ascii?Q?Z4nUamxmH9vQ4z0IY7Vh6Nocuw1loy+M4zABIJQH2JGrmSourX1s10l2vM8x?=
 =?us-ascii?Q?HTooJLHc3TVGB0NB1rqG62Q5FXmzm1tflb4dTT20lYms3wFFn4clyPZ3RmM7?=
 =?us-ascii?Q?7YjtVZD5Wj2NWfbv2aeJUErVUJ4S1erjInGlw+ZNJ6Ken3nZk+bQLi4JTgXE?=
 =?us-ascii?Q?cfIYD9PDg/9zcQLWjLe+q/yrGjwoXHrNqowDWMDDJNZcG1mgTr99q86UXg56?=
 =?us-ascii?Q?/QeGcHXxZE+DimVlrM1LaEa8blP/a+7d8juafyXjxuqqaL8gSwYCy7cpN72H?=
 =?us-ascii?Q?GXbqLp/SNiJfIzv9ZGqpZnch1WzrJaQ3z4WvpYPWMlI99tgfs6GakxY8kh67?=
 =?us-ascii?Q?vSrFV/LExwS3Nz0Mi7XzMyvEcGZ1/TnuBJnl/zWciw7RupVTDg6t0mGJHTo5?=
 =?us-ascii?Q?rnmZ15Kw26jx8sQuDjhP7/GYwLoaxT6kDVeXncbooeDXL73OijwdrKVoT/ae?=
 =?us-ascii?Q?uXYRujvRpKGRqGcF8M/QijWayZKj6d8FPHvRjFVvZX1gojhaIoU1DU2fH/fX?=
 =?us-ascii?Q?HT55+aUfRUL2ZaMhKs+YJim+VgrR4yMtcNaopoJmFMiajdlt3pTrKgwp5WfA?=
 =?us-ascii?Q?jgR2I5FPCy+r0tfXrIQT7rNvpwS6D/Vr4lw1t8aaZuG4+xsM5Vp7V+lhiGt7?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f850b205-0339-458c-fffc-08dbfbf36eaf
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:51:55.7194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zk4exTtdAlXgEI+YAoDu2zZ41+40pGMD8d0+NMyf45NGk6RBCrTqGYn38syxNopNodbvsHmIgmTJoFXzWmGaQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8106

phylink_parse_mode() populates all possible supported link modes for a
given phy_interface_t, for the case where a phylib phy may be absent and
we can't retrieve the supported link modes from that.

Russell points out that since the introduction of the generic validation
helpers phylink_get_capabilities() and phylink_caps_to_linkmodes(), we
can rewrite this procedure to populate the pl->supported mask, so that
instead of spelling out the link modes, we derive an intermediary
mac_capabilities bit field, and we convert that to the equivalent link
modes.

Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/phylink.c | 71 +++------------------------------------
 1 file changed, 5 insertions(+), 66 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 48d3bd3e9fc7..298dfd6982a5 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -883,6 +883,7 @@ static int phylink_parse_mode(struct phylink *pl,
 {
 	struct fwnode_handle *dn;
 	const char *managed;
+	unsigned long caps;
 
 	dn = fwnode_get_named_child_node(fwnode, "fixed-link");
 	if (dn || fwnode_property_present(fwnode, "fixed-link"))
@@ -915,80 +916,18 @@ static int phylink_parse_mode(struct phylink *pl,
 		case PHY_INTERFACE_MODE_RGMII_RXID:
 		case PHY_INTERFACE_MODE_RGMII_TXID:
 		case PHY_INTERFACE_MODE_RTBI:
-			phylink_set(pl->supported, 10baseT_Half);
-			phylink_set(pl->supported, 10baseT_Full);
-			phylink_set(pl->supported, 100baseT_Half);
-			phylink_set(pl->supported, 100baseT_Full);
-			phylink_set(pl->supported, 1000baseT_Half);
-			phylink_set(pl->supported, 1000baseT_Full);
-			break;
-
 		case PHY_INTERFACE_MODE_1000BASEX:
-			phylink_set(pl->supported, 1000baseX_Full);
-			break;
-
 		case PHY_INTERFACE_MODE_2500BASEX:
-			phylink_set(pl->supported, 2500baseX_Full);
-			break;
-
 		case PHY_INTERFACE_MODE_5GBASER:
-			phylink_set(pl->supported, 5000baseT_Full);
-			break;
-
 		case PHY_INTERFACE_MODE_25GBASER:
-			phylink_set(pl->supported, 25000baseCR_Full);
-			phylink_set(pl->supported, 25000baseKR_Full);
-			phylink_set(pl->supported, 25000baseSR_Full);
-			fallthrough;
 		case PHY_INTERFACE_MODE_USXGMII:
 		case PHY_INTERFACE_MODE_10GKR:
 		case PHY_INTERFACE_MODE_10GBASER:
-			phylink_set(pl->supported, 10baseT_Half);
-			phylink_set(pl->supported, 10baseT_Full);
-			phylink_set(pl->supported, 100baseT_Half);
-			phylink_set(pl->supported, 100baseT_Full);
-			phylink_set(pl->supported, 1000baseT_Half);
-			phylink_set(pl->supported, 1000baseT_Full);
-			phylink_set(pl->supported, 1000baseX_Full);
-			phylink_set(pl->supported, 1000baseKX_Full);
-			phylink_set(pl->supported, 2500baseT_Full);
-			phylink_set(pl->supported, 2500baseX_Full);
-			phylink_set(pl->supported, 5000baseT_Full);
-			phylink_set(pl->supported, 10000baseT_Full);
-			phylink_set(pl->supported, 10000baseKR_Full);
-			phylink_set(pl->supported, 10000baseKX4_Full);
-			phylink_set(pl->supported, 10000baseCR_Full);
-			phylink_set(pl->supported, 10000baseSR_Full);
-			phylink_set(pl->supported, 10000baseLR_Full);
-			phylink_set(pl->supported, 10000baseLRM_Full);
-			phylink_set(pl->supported, 10000baseER_Full);
-			break;
-
 		case PHY_INTERFACE_MODE_XLGMII:
-			phylink_set(pl->supported, 25000baseCR_Full);
-			phylink_set(pl->supported, 25000baseKR_Full);
-			phylink_set(pl->supported, 25000baseSR_Full);
-			phylink_set(pl->supported, 40000baseKR4_Full);
-			phylink_set(pl->supported, 40000baseCR4_Full);
-			phylink_set(pl->supported, 40000baseSR4_Full);
-			phylink_set(pl->supported, 40000baseLR4_Full);
-			phylink_set(pl->supported, 50000baseCR2_Full);
-			phylink_set(pl->supported, 50000baseKR2_Full);
-			phylink_set(pl->supported, 50000baseSR2_Full);
-			phylink_set(pl->supported, 50000baseKR_Full);
-			phylink_set(pl->supported, 50000baseSR_Full);
-			phylink_set(pl->supported, 50000baseCR_Full);
-			phylink_set(pl->supported, 50000baseLR_ER_FR_Full);
-			phylink_set(pl->supported, 50000baseDR_Full);
-			phylink_set(pl->supported, 100000baseKR4_Full);
-			phylink_set(pl->supported, 100000baseSR4_Full);
-			phylink_set(pl->supported, 100000baseCR4_Full);
-			phylink_set(pl->supported, 100000baseLR4_ER4_Full);
-			phylink_set(pl->supported, 100000baseKR2_Full);
-			phylink_set(pl->supported, 100000baseSR2_Full);
-			phylink_set(pl->supported, 100000baseCR2_Full);
-			phylink_set(pl->supported, 100000baseLR2_ER2_FR2_Full);
-			phylink_set(pl->supported, 100000baseDR2_Full);
+			caps = ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
+			caps = phylink_get_capabilities(pl->link_config.interface, caps,
+							RATE_MATCH_NONE);
+			phylink_caps_to_linkmodes(pl->supported, caps);
 			break;
 
 		default:
-- 
2.34.1


