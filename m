Return-Path: <netdev+bounces-57580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0370813753
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8535B1F20ED2
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C016D63DD7;
	Thu, 14 Dec 2023 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P7dCe7Xp"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2074.outbound.protection.outlook.com [40.107.13.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABDE118
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 09:07:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3SC4JvzF5CNUOvK5qtxfljYKx4Z7B4sp2p0MWRBtJskPiVB2gBIrOgvbeNgcqRZtaIslUOr9sMYEKUJT42jVCfqvEcL8iuBRzxORJr+vu+btDWttW2YVytnMQoJy7AMP/9q5cfqpnD+6bC2bMQ9cqz4koV+rhMhfd3HiFIhLrZ913ZvK3J9rA9OzT08lbnKPmKPdrnv6LEnRfA/wyHTpBCGBjnzpsUs0Kyq0arOb/B1wH5Klc1taSQYE8e2nK0O32bx9u4kIlK9iIfxRpslPykgYKde+fHpQUw/mB93J1+Fyx5h8glrW4wsc8iCCYu1uBKApeOjuIb2pBqo9mkppA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IROtaDdFQk4TIqx9QOaqxvyhBqKmA9XGiMbkT4UaE6g=;
 b=UZRvckVjxfa5dgSqK+eYeRMEKRlqYSR1Ojg9K0SGrGuri2UoVJE2bVk1ZeiAtVfpSI9E4d8y8+rzCDocGd3SJdf8K43Q7KrdTwSrmPDp0RxfUM03XrRErrOG6O7saxU28fbRKQwaPPoKlLCBnWzankqA6fjv3dUXQyP6X5HWwqC3revou4UefTsLvFr4RppOp6drMfoLwYIkjXkQZ+hOXuzAWIhZEPQF6WKMzOPN9JM+3ff2R9qvjLMlVkjLhHQT55WogP9RSe2KVPwd2BRnvrUc7GFXduhQYOxUA8g1zH++jID/7Jn0xqM8qO/ly165UcXbuZ6k83AC0XG+ndDtDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IROtaDdFQk4TIqx9QOaqxvyhBqKmA9XGiMbkT4UaE6g=;
 b=P7dCe7XpRq3zolXCnSKJxzB7/UC/IABP7FQnhf4GTWUh7lZ8rwhwB5NjbQHaiRGAmXo9aG34N+sjXyOiRxjgaid66Zt8eJglmNrXKkjY1RKaTJpRHSfW7iflosameIRRIsRCmRP4vpCRkIRwpd8hX9fyHrsStgxXMuXdfJDkL7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB7547.eurprd04.prod.outlook.com (2603:10a6:10:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 17:07:13 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 17:07:12 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next] net: phylink: avoid one unnecessary phylink_validate() call during phylink_create()
Date: Thu, 14 Dec 2023 19:06:59 +0200
Message-Id: <20231214170659.868759-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0018.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::23) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBBPR04MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c55574-9de7-45c4-d4ea-08dbfcc71d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9V1DjLBuAaRsiCIFi1q1xf5j5DH087swisGX2ivMlveNfsiyDZGJdQda7kb+wzPcXixwS7E5V8H5DZ5lelZcYcc6P3Ouqy3O0tpwAWf77zzEfEEJIsBBQzHTLNBYeDwbQfZS4flgeKUlRP7fMZ2jFw/w1fvueHq1ZaezUkLAkBX+ljBQK3KyA8Qff71trapuYaI2yElWmkiehZxtCldbrh4WoiYZ6Iww/0RfFpY5HT66A2xCbQ9HQlyjdUcO71IlDSodQkMfzdAuYhCPFYgbbgLCkYISwnxBwqEMp/G/hXHgh/8iU7NHlmMY7HkUbwNQXM/xSyT8HytwnZhpnYKRfWLR+I8PSHNiqdkbbkIysHyCaQlhdAm+xvYUHDRCqdn94rGIIYlkEy42OUxHBHVrWf5ESmSBZtWr/iGscmeCsVAIRF4I+iKT+EiZNRNWxPym8Dh59lXXfW4VzOCZX7AQxrSD8mXJZXhZhNf6Jk5SmYDOge/9ninObVvvnN9NO9dqf05VLaIJbo/UENiSK+4c1HzhHo6aAF7JqzbSsfGxxK7JDfxx1rOLmRJU5LpZEAAC7xSC7NjkBwMsAIis4yVsWJ8uUpQFDjRpmt4bYfj1fvo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(1076003)(26005)(2616005)(6506007)(6512007)(6666004)(83380400001)(52116002)(66476007)(5660300002)(4326008)(8676002)(8936002)(44832011)(41300700001)(2906002)(966005)(6486002)(478600001)(316002)(6916009)(66556008)(66946007)(54906003)(36756003)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KuWugl7V9ujLyphFdRxchQ8v2Cq9vIGVKovswerUeiuUO4aX1QACsYYowuy9?=
 =?us-ascii?Q?5KHSeNJBvby1S+orGGRDR3c19A6yZuLK++lI1S+85zyi7afwKYiUjlR5pRvj?=
 =?us-ascii?Q?0lvmc2pPEBhc0CQnRxK9hS+SiC2qVceFafjEOTT24ItAZzxYaCsA35bLqBn3?=
 =?us-ascii?Q?gsv/SAn1VP9wJbHl3h50sF/e+Q8sFLN8Zqz702pvg4buEo/ivRBZRsg0LHIA?=
 =?us-ascii?Q?3M34Z1cBaibg7R0NAcY/2wcZMfx1lvlVWofDOxCa7WzyF2ZELZCMoTBzzOY8?=
 =?us-ascii?Q?dfrWuOlsOZE8u+PDLSJoCR/z2kzO+gvV7FFDIJvX+Z6EWD8AMmM2eH1dxgfM?=
 =?us-ascii?Q?a4txQtsQNykFsq+jjHJbhrTsHx4WOGyj9f4URbSEzrg1Wl/P6IApT1X+M+U6?=
 =?us-ascii?Q?jxzwo7IX+Em0eDccqEaOFvA19h+1bbye0PPkHxxzX5MHZQ64DkSy67tg+zKf?=
 =?us-ascii?Q?aTFW/hocVIXaEchYvctuojTa/Sa4QZaIkB98EuRutYhi+yqblnV6CI+8qYcR?=
 =?us-ascii?Q?aJryrBYhJzoA6FY/Fqb47uwj54785+LA0in7B7Z14Bm4S48dcA2gg2zLtEv+?=
 =?us-ascii?Q?a+q0uYfuKlisVqcpUtOqPUAlN3L35pMDpTew6km+QjW0aiTTLBEJyMMvivc2?=
 =?us-ascii?Q?TVlCZgUTb0tNj5ZF7fzJN3TkKZvgtANH1Elq0NV1/96UFjoJ1E79QX/Kx2gk?=
 =?us-ascii?Q?slPGeXGpnEBSU8D2XqMRdJL4un08wcvvKKZteYsE3lW3uQeuvANT26jS3OtW?=
 =?us-ascii?Q?4AhrqZ32aM1ll7RQBGVSicnTzstzRPrIHnOTHjR01+pgjq2V56RY9bFtFQgZ?=
 =?us-ascii?Q?2nEqQwohlpZESOPvUrXGhHASU4KTC4YXP1TTEBgNEjAFy8vtwIIWWEmfsO3v?=
 =?us-ascii?Q?31cs6E8BdjbSc0WvWFAwb5zrkqAJqpAKNBlPM/Ka4l0RHEjyblWi1pNbuKL2?=
 =?us-ascii?Q?SaKbhCM/6Flgxaw2zC8VMjXZpeHwC+vAybxNbDVWacP/T5RV4K+vMnR5CsZI?=
 =?us-ascii?Q?/sECNKwn6tH4bux9EhpVPEWwWVNMCvS2R+hNskByF2w/226rTt5rknwzNV65?=
 =?us-ascii?Q?fsbAf6zaeDBMt/aTI50z9C5nsa+8Z1MkxCTNoaevk3Jg4NbOP7MXSNMLvvls?=
 =?us-ascii?Q?YzaSd0Lw2eEjn+yas8UqM+b0jskgZqfYMk0u6g+/YjJ5/FUFrcVjqy9CO1pd?=
 =?us-ascii?Q?WCui12bgVSex062Rd9YORLPhkoaBpcs7u+ns5pgcrCbmCKogORcEW1/8HdQs?=
 =?us-ascii?Q?oPsBRmqYqD6P0EQ09feo+lpszRsY7ppOFdMu3CouT/a8xYwR7SOikcIIAG0j?=
 =?us-ascii?Q?XRt+KTc/KlhkYft1Wh/VK4nfa1RXCgCMmtJwcgVVsdIozWgH4gTvA5wyDtBM?=
 =?us-ascii?Q?cABGaxaq4elR9S5xBrtSd7oeSMavp0AfTyaoIac/HqlhJNKp3YdaCiEPGwz7?=
 =?us-ascii?Q?ts5rfXIm6hTUJOC0uG2pmhIvepBlibbU40KDKP2jZ640Ny81U7TYx94E+2lZ?=
 =?us-ascii?Q?/l+5qfSC1/1p56UUwZmzEvkMM8LJz/fc9XeVGGTMOE3HCvg8jmAHJ+EOTX80?=
 =?us-ascii?Q?uI4iQwz1vFafD1fEF5rw1fcUObtTq8s6lLfIlcx3RnLtwY4I+SHbIr6dYDDY?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c55574-9de7-45c4-d4ea-08dbfcc71d7d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 17:07:12.8676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXg5/2Eh7qYwLDbkPQbjl022EX3jJzo/1CDGYy/lJ+Dsv+w1enkWm69lnzLrC7j2Yh1jMkjAAXRb6SMu7RA57w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7547

The direct phylink_validate() call from phylink_create() is partly
redundant, since there will be subsequent calls to phylink_validate()
issued by phylink_parse_mode() for MLO_AN_INBAND, and by
phylink_parse_fixedlink() for MLO_AN_FIXED. These will overwrite what
the initial phylink_validate() call already did.

The only exception is MLO_AN_PHY, for which phylink_validate() might be
called with a slight delay (the timing of the phylink_bringup_phy() call
is not under phylink's control). User space could issue
phylink_ethtool_ksettings_get() calls before phylink_bringup_phy(), and
could thus see an empty pl->supported, which this early phylink_validate()
call prevents.

So we can delay the direct phylink_create() -> phylink_validate() call
until after phylink_parse_mode() and phylink_parse_fixedlink(), and execute
it only for the mode where it makes any difference at all - MLO_AN_PHY.

This has the benefit that we issue one phylink_validate() call less, for
some deployments. The visible output remains unchanged in all cases.

Link: https://lore.kernel.org/netdev/20231004222523.p5t2cqaot6irstwq@skbuf/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
The other, non-immediate benefit has to do with potential future API
extensions. With this change, pl->cfg_link_an_mode is now parsed and
available to phylink every time phylink_validate() is called. So it is
possible to pass it to pcs_validate(), if that ever becomes necessary,
for example with the introduction of a separate MLO_AN_* mode for clause
73 auto-negotiation (i.e. in-band selection of state->interface).

I don't think this extra information should go into the commit message,
since these plans may or may not materialize. They are just extra
information to give reviewers context. The change is useful even if the
plans do not materialize.

 drivers/net/phy/phylink.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 4adf8ff3ac31..65bff93b1bd8 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1620,10 +1620,6 @@ struct phylink *phylink_create(struct phylink_config *config,
 	__set_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state);
 	timer_setup(&pl->link_poll, phylink_fixed_poll, 0);
 
-	linkmode_fill(pl->supported);
-	linkmode_copy(pl->link_config.advertising, pl->supported);
-	phylink_validate(pl, pl->supported, &pl->link_config);
-
 	ret = phylink_parse_mode(pl, fwnode);
 	if (ret < 0) {
 		kfree(pl);
@@ -1636,6 +1632,17 @@ struct phylink *phylink_create(struct phylink_config *config,
 			kfree(pl);
 			return ERR_PTR(ret);
 		}
+	} else if (pl->cfg_link_an_mode == MLO_AN_PHY) {
+		/* phylink_bringup_phy() will recalculate pl->supported with
+		 * information from the PHY, but it may take a while until it
+		 * is called, and we should report something to user space
+		 * until then rather than nothing at all, to avoid issues.
+		 * Just report all link modes supportable by the current
+		 * phy_interface_t and the MAC capabilities.
+		 */
+		linkmode_fill(pl->supported);
+		linkmode_copy(pl->link_config.advertising, pl->supported);
+		phylink_validate(pl, pl->supported, &pl->link_config);
 	}
 
 	pl->cur_link_an_mode = pl->cfg_link_an_mode;
-- 
2.34.1


