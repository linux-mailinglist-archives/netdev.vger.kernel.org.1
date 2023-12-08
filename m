Return-Path: <netdev+bounces-55425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843B680AD2A
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14AA31F2116B
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8F250269;
	Fri,  8 Dec 2023 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tC+vUfpF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E902098
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 11:36:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZDKFrjVPARKUzZpSYpIfRZfAl5osaN5ggDWDDBhrJsJkC6QYfyGqi6YMOvh2rdmfHDDY4TMT3CUHP9FNQ4zU0vAx/astAcC0oeFEPNP+arcjxCVJ2mPDFBZLS8N/zQNDYJn+RofO+h86Okh5DVXc70Sv/e5JtLPTcaHHNTVV9gyv0syDr2r6MK5OS3/UUo7PNCbtLHNwgASVf553/qj2SgRdDymWOO6uSjN8H4T2MIulf/4Xp6Nt7KT5b1YOhDEUgw4+uLD8S4hgNtdmfp36EEToo629ZQtU85KYW0qi3agoRP9UOCr/Tw4Uf3jP3V5jaoPzdJ/BLhIqfnorlGn/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Id324msxC4FP7tatrN+FNt8ShGKXuv6823a/jXbUlYM=;
 b=MkZq5XBh2AyXJYClryTYSXHMjBOzPcjYvaolbfY6bz/5w1cTHIifhXoUzPWA/LSfsUpv2Aj9oaniprGXAPbB7U89+bTCG4zvQk59RTikVZ6OZT9TlsXM4a55WnDfhWuPh4fx9pJJ10Czzftg7TAkugGEBaTDmqG+cqw3O/ZXqyvAKx/AQlFqyOEju0olvSJQnWlFU3d7jdRcvyE+ot8CykOuuU7ImVU2y5rPlZUTpkBFBTC+SjGkGzLTfkuJu3L6+Pw7onc1RR5J/J/xapElZPYLs5xts0bedM5LqT/zvXC+y2WqM4bQ25zK4KlCkCtZk8CsdsRMTVEbzFUxgdWtAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Id324msxC4FP7tatrN+FNt8ShGKXuv6823a/jXbUlYM=;
 b=tC+vUfpFNKmGPTKFMbw43/ZpgoW+lTKx8Vxys6f4qYEwm3xX7NRTxpQDjmDybePPR2HWui52GEJ9n5mXhHeafBBOANarn37CCqSiIwFNdwELpRdmMBBd41V5XTXeWJ48p6l4rFORaSoAzT4JCbvIhB3UR4rKMfWrPQh3EyZVZMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by GV1PR04MB9213.eurprd04.prod.outlook.com (2603:10a6:150:28::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 19:36:55 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 19:36:55 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Madhuri Sripada <madhuri.sripada@microchip.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net 3/4] docs: net: dsa: update user MDIO bus documentation
Date: Fri,  8 Dec 2023 21:35:17 +0200
Message-Id: <20231208193518.2018114-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|GV1PR04MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: e26bf1c3-f8f9-4ba9-d981-08dbf82508d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6pCEZ8NpIFc2OWVtB9VFUDVA7gvPzTIXKqyC70lHOyIPvHr8x/h4YGLNo42pVTQmylcB0t4mdZqm68N8+XanAO4gtxu7XInglTu9p/I7saGd3lX+Gfn0LtndX5Z0N5zaCHSp90TrJiD4i7ockfodhBM8Rzwx3IY/gC2dBgB+hxRvkV4qUqRXSVZhDJ6rtd/fdz7JDFLZtGmD65lsBvhNoI1EXfSh//JdAC83Fg+jiggn09FssB8sYta4WqDE3iZ++1MQRDSR+3yV7tuBWyA4q06hZyuv0/5VRAYTX5H5kzidjs7YSAJlr5/DG531qvf7i6eT9v01WSdB0YaVWuQ5oad6k4phuNFX4hzNhM1gAkaPvVYbw5b2/NHD68Vp9BNmcGkiQGA61R9tOqKAK0FZxz7OzVRtcGgAiehlyx6XFKIBC1XcAZFLGPN1iFs3oLjCzpo/vDn4PP442SAIYtHbWyhGVwJkFf0p76O2TDs8pKw3JckWqeclCUT+SCuvOHAj3BSytHzB/mkUklQ2LNAX9oqovtG7kXJzcqpGlwigPYaYNqPLCVpGmhMx6GNbucrY4mbX8GVrYQYwf/GysmrNkxCfku/MPkzmjFG0FJRLIyGbAjPxTqHz+A6LUIL7vVim+gY7Wr4Z4n6rXIUcS/Do0NZOU3gyD7azo9R5/4btn78=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(8676002)(6916009)(66476007)(66556008)(66946007)(54906003)(86362001)(36756003)(38100700002)(83380400001)(1076003)(8936002)(2616005)(26005)(52116002)(6512007)(6506007)(7416002)(2906002)(316002)(478600001)(6486002)(6666004)(5660300002)(41300700001)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SFWKy614j3l8UiRyXhZQVDCEpeN/DHo+4NIgR8JD34B6YLDIXKzyZcp2usZL?=
 =?us-ascii?Q?AgMPDqxhwDdeYqVqoJ7HC0OUJKKKtXBase3KoAApxNPPx0Xz1RUIffVxAdvk?=
 =?us-ascii?Q?Prvtkkuz22btXyjpJ5zqsiEFOLl0MnqGQ3kCXARUvjOv+D0/lX057gsyPRnD?=
 =?us-ascii?Q?ItrBmKvGHreHtGetgfSgCIh7vSJOS7bxofmwZf2D0sadluWtw88Av4J2De1s?=
 =?us-ascii?Q?cmRvua3ofhydKwe9Tfz8OqXbYkt+m3DYFey7r5xtf5kiM7GKPPuq0jm2i60E?=
 =?us-ascii?Q?k3Uj+zN7fB0zZSrYyojQ6gxCpM4Lg7CA8wtacz59PuICAvd6nHzAN+LYI4hE?=
 =?us-ascii?Q?pP99fPm2c3Wn9LLPs69iEL62aGWL0kpxzzGSY1Fx/Laq0UvWIA4W6swhwkLu?=
 =?us-ascii?Q?pVVfVgMPkygd290vXFx3Cn36Jy1IS4+Sww79gk15JiJjhn7+Idtux2k4fCjV?=
 =?us-ascii?Q?Q2oHf8sw2uJeQPWwBokLYclRgGPFzNU2t7EJhGFRi6NjbSXl3QbP3NjUuZzK?=
 =?us-ascii?Q?s90m87i9Y5DGs3GPyC2ukXuy4cG0lRdwKLwiCTtEdJEdMeU752/WDFbbWxft?=
 =?us-ascii?Q?v76//w+eiI6YsZi4i5GYkUCqlgyWI+P3NdXhFTqgSX/9NApaSYlQPHqLeQHr?=
 =?us-ascii?Q?LBxqE3C/NHAKKW2xqlhMrMmzo5rNx4pcJ52aIip/1uWNcxU8thCLY8Yi6Nmm?=
 =?us-ascii?Q?xjU4Kq4A6RVTD2tdKMmV62kArU3HOoZPb628DRVZIiJpJ9/vD6QUqAXbHwuj?=
 =?us-ascii?Q?bD2MaDq3rYFE6MdfZTHmrI0etxJkXKZL/5NgHrgjLdf0twxVYT9kDhcdxJiq?=
 =?us-ascii?Q?mnNZnSnWZB9Ajv2C8eChEiRnE7EBDBH4PW2mLYROqwD1Av/c1jEBuQ0znPJf?=
 =?us-ascii?Q?2x/yUxbWacvyVt1nQJezXgLbvXczjSCLzK/9RBrLTqv0bV0nFHIbvVmPs6IB?=
 =?us-ascii?Q?pYDyBfVxN2T1iXSzMxBqHIzsTghDCQ8NEAJav6YOt3cpID2zenz2vq7gRyBR?=
 =?us-ascii?Q?JbTzxS5FzRS7fTea47AYhMBQm6XlQVkrkHmo5Fu+FBRBir9BW0S/CBdu9vzl?=
 =?us-ascii?Q?AJ0SeT6/qTZjM5w59Vbv4Khm+ADowd07o3vuW3E5K1JacpY7JmgTlgEJUVE8?=
 =?us-ascii?Q?LT+OL1PZC0TwFvE2dLCMrICgtWd/jmZEfbiqLoAQIjKw/m7v7xQiTiHg7mb/?=
 =?us-ascii?Q?QSsHe5HJgFdeFnm4NH16JCZU0vMbdrZZCDpqzACITvzlr0a0QCijvrPNNshe?=
 =?us-ascii?Q?qKmk/fcvphxJd1/DEnrhA8I+LHAOyrQvAx83cdnZ1wmk8GeaWtgNoRJpO+Ww?=
 =?us-ascii?Q?7J7KxkchJ5G0/4x3GftDGUWhA7Nu8NuEaMUu8HTa9N45BBEt9Fnh2fcebLhn?=
 =?us-ascii?Q?URb36yIGvS+V+At5xpMIvqZ3HkmlJifh9wiufZz/PnM9umVPnQOJXq2oAbK8?=
 =?us-ascii?Q?daueRcEfFwmwRmfB7D/Tq47vRVnQy3XJ0/elIEPymN0qOaC/UK3wy9UpQoLL?=
 =?us-ascii?Q?9MP8MQUPwOMeHhkplBNzaY712NipdS8PbrfUZL0pKlbCrDhjzXTTCYmVOnRU?=
 =?us-ascii?Q?ldZSK3Kw6xVWh1OkcGwQAsb7IcpqKQvh+Otn5Upr/8IeX8RQDUdDajf+bfFo?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26bf1c3-f8f9-4ba9-d981-08dbf82508d1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 19:36:55.0700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuMe3bFP4FxfRgbaqYRs1Fpt+8n/6ikHlnj9NRePf54WzXRf/FVOF6he8Ya30f9YTYHMVSyT2JKPdiwFTQOpEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9213

There are people who are trying to push the ds->user_mii_bus feature
past its sell-by date. I think part of the problem is the fact that the
documentation presents it as this great functionality.

Adapt it to 2023, where we have phy-handle to render it useless, at
least with OF.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 Documentation/networking/dsa/dsa.rst | 36 ++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/networking/dsa/dsa.rst
index 676c92136a0e..2cd91358421e 100644
--- a/Documentation/networking/dsa/dsa.rst
+++ b/Documentation/networking/dsa/dsa.rst
@@ -397,19 +397,41 @@ perspective::
 User MDIO bus
 -------------
 
-In order to be able to read to/from a switch PHY built into it, DSA creates an
-user MDIO bus which allows a specific switch driver to divert and intercept
-MDIO reads/writes towards specific PHY addresses. In most MDIO-connected
-switches, these functions would utilize direct or indirect PHY addressing mode
-to return standard MII registers from the switch builtin PHYs, allowing the PHY
-library and/or to return link status, link partner pages, auto-negotiation
-results, etc.
+The framework creates an MDIO bus for user ports (``ds->user_mii_bus``) when
+both methods ``ds->ops->phy_read()`` and ``ds->ops->phy_write()`` are present.
+However, this pointer may also be populated by the switch driver during the
+``ds->ops->setup()`` method, with an MDIO bus managed by the driver.
+
+Its role is to permit user ports to connect to a PHY (usually internal) when
+the more general ``phy-handle`` property is unavailable (either because the
+MDIO bus is missing from the OF description, or because probing uses
+``platform_data``).
+
+In most MDIO-connected switches, these functions would utilize direct or
+indirect PHY addressing mode to return standard MII registers from the switch
+builtin PHYs, allowing the PHY library and/or to return link status, link
+partner pages, auto-negotiation results, etc.
 
 For Ethernet switches which have both external and internal MDIO buses, the
 user MII bus can be utilized to mux/demux MDIO reads and writes towards either
 internal or external MDIO devices this switch might be connected to: internal
 PHYs, external PHYs, or even external switches.
 
+When using OF, the ``ds->user_mii_bus`` can be seen as a legacy feature, rather
+than core functionality. Since 2014, the DSA OF bindings support the
+``phy-handle`` property, which is a universal mechanism to reference a PHY,
+be it internal or external.
+
+New switch drivers are encouraged to require the more universal ``phy-handle``
+property even for user ports with internal PHYs. This allows device trees to
+interoperate with simpler variants of the drivers such as those from U-Boot,
+which do not have the (redundant) fallback logic for ``ds->user_mii_bus``.
+
+The only use case for ``ds->user_mii_bus`` in new drivers would be for probing
+on non-OF through ``platform_data``. In the distant future where this will be
+possible through software nodes, there will be no need for ``ds->user_mii_bus``
+in new drivers at all.
+
 Data structures
 ---------------
 
-- 
2.34.1


