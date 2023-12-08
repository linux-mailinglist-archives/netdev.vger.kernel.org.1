Return-Path: <netdev+bounces-55424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E82080AD29
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54785281B0D
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD164F8BE;
	Fri,  8 Dec 2023 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R3t6Dh5B"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6351720
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 11:36:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb+lQBHdbQO7uixgsFiLBPbQhf4bhUXcW43MDrrvcw1YN4aL2puNkbzstNktO7+i/O87EA/bJEhqxT8py8bMzn25E2jWMc9kxegCyFo4uuhPQ0b9obnAMiEzPvs6Hs2Lhl03JMkjp0s9+2LsBhgo4V7If106UfjWfY2m2p+fVoH3flTA6Yf0fkjit6W0gCU0un9OjVlRQoeIybqlOE3AKtm/LySpNZlqNAPRKI1o45SvGxc3IVfxGQH/2XU2liNwKvELoOt1+4/TWW1GCf82z8XDlUDc0aDbKxoYfo10dPcYSPutf6/KGRJ8blZZtRjtuFLq+FSiSK3ouqhuV2LiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13KaXno3YDAEXeSK9DARmPeqqORymq9RDF0JvSnc1Jk=;
 b=HH2lxOJj33UN3KVhRfiV1fxVUxWmkXF7vGHcuj8wdJ21eVd5txBHilg8w9k/EzIrFBmxuv0vgjD0zxg5QVWtjtU1XW1ALEDKKbOjmIfz+uV00iEv/OVGq60U5GH8pnfJXxJr5mHIX/YLHM3+52iDYSiLdyRxQAzaDxAaCvpB/+0wEXFvZYvyla3+FgylmF0SYq+RVbEH8k/KBgVO6kPkDoVNEpk3DqyIeqNXgJIOLLQICcUn5WVw+/C8f8rb/bSquTHzuWwp+hl2SMv7DRyixroC0YVteWo7bDrH2bNqBpbdqauceLDQS4G2l/JOHcQzIqJYUg6yLyg4qyb45wKDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13KaXno3YDAEXeSK9DARmPeqqORymq9RDF0JvSnc1Jk=;
 b=R3t6Dh5BcR6nEsl76W1Rk7qLfWy50iYgh0g8CrLaC4gde4ZOR6pym5As0I77gfSUsEeScLkyakbDWIPHf9mrAoWKep4tKNKiKC0eiv3dJmIre8t7LFBvqME0wyHKhwFlvC9yMOQ0KFf4x7y+0Vsvw5FJ502rQNCyRoWSaz4ryTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by GV1PR04MB9213.eurprd04.prod.outlook.com (2603:10a6:150:28::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 19:36:53 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 19:36:53 +0000
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
Subject: [PATCH net 2/4] docs: net: dsa: update platform_data documentation
Date: Fri,  8 Dec 2023 21:35:16 +0200
Message-Id: <20231208193518.2018114-3-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2916f6a8-20e0-4a9c-086d-08dbf825081f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z8202h2pVlmiDxgQoL60HkUyuUpnPPJAkigavbYvp+PI9QG7cPdlu/SR3kRiYkylgBJP+xTYaG5DVvr+TInWN11ej4NwLWtr9ki55sT/kXYZ9hG9gpH8R6BW0YWdgxIf94eJrgXVhx1vy8pEieWpVDmucnyB80U667/Ym9FIYh0sb9IB4kq3G5FMaZiENbpUu+0yI8UH++KOU2WqtTkRYU5JhGC6xS5VVffuJHm3b3W3umZy1X67PBlBV7BtAdDfNoRHpxFBI+91tDK31m3z9hkguRVKm8JhoJFIwTSSICbT2tuUMzM8aYXx0OSRefWD948BySLEggRtP6V/Ety+fcN0O5YxCBxwfiykqZQFd4l+TGyUZqJyHsRG/5lTEx2o54o8ixgd2C6ACaZdcHrEyDpJe1MTmy6SLtXlEk2TSNE/rkNCaVe9hGjfZtPga9COmvZKlQbYBt449cfir8lwoHhwTCZyHHmD2RqpYk2fGc6t3xbm0ENaOyi1ffHOcPvDoIAuikzyNt/J8b2D03YtKSt51bS05x7du3cMRzS41jYMUiGaReoffzSQjgomNQIklzGFKijbx+Zzbe19QoWCfgUjda3KpUR/7UEK3qUmyvJyYmrNJwNvwjLYcXnAVKXyYwLpOE3/dHlYCEuiTmgfNPeOd1fjiQlbobGyiSXDQ1c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(8676002)(6916009)(66476007)(66556008)(66946007)(54906003)(86362001)(36756003)(38100700002)(83380400001)(1076003)(8936002)(2616005)(26005)(52116002)(6512007)(6506007)(7416002)(2906002)(316002)(478600001)(6486002)(6666004)(5660300002)(41300700001)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K+/XUlU3OPdjWEsggRw4bmxSgWiiXZ3+ZNqKjEOkezobcZjgUzfUf/V0ZHV8?=
 =?us-ascii?Q?lIwD4jsw7c9qSeGrKbnybC7uBU7x9YKiMB9WVDHj5JqdpE0f6+trHqQXZwo7?=
 =?us-ascii?Q?dQTeVFX7PaQozk8E1D7S0hJY/sPHWjl19lrk8ufXfvipZN/e49clHLVWy1SF?=
 =?us-ascii?Q?iagwtsYEc5Ua9xQhcIQwFs5q+TzIAMzoMFGgMiJkoR93KubKo14QxY2dO2G1?=
 =?us-ascii?Q?zYbBaed0WA/6PdoFdOWzZ7JHlFAKGbrH5wy7pD7Wh9ix6OnLalD+rVhfNin6?=
 =?us-ascii?Q?6XQ7uZRG/Wlfciw/TV6WEj+Dze/QDB/4Ad09S12vgkbzJHMPDWU5ASgniZqi?=
 =?us-ascii?Q?gPsERzi5TPcLbX15ljeTA+SHvjq4A1zFNyrM/h1XVRiFtr2wj9ljupCBe8Ee?=
 =?us-ascii?Q?jtCYcJoHf0jMFiEvaLofxEe1l9ZDyjl+5QyL+tbwp81YDvy0yA09Icp60d9V?=
 =?us-ascii?Q?W2wln5h+hoEpQsB8hoWvxyG0AmaY/RNcgyLTRT/3A3FO5CdujvSZnKVL0BKH?=
 =?us-ascii?Q?XwthKs8c0Fh85UH/CLCyNQutC9GE03bXTU7+9OlMG59utVfSrv0OrF9l3mCN?=
 =?us-ascii?Q?PDzdjIiyL8M6dFCUTn2uiQjLO4pMmokHrmKKOeythIeJGirdxe5HkPkY91YQ?=
 =?us-ascii?Q?DK2g4cGcM+rFRVDxa4FBQAsX7w8VUh1Tz5I2/eBX4vyz1HhGLJMVpVIxOase?=
 =?us-ascii?Q?7D5lkuwEq9mE9m8lnjr5dOepRhBYiD3CzSfRxgj/lJ+qE0wv8yUtypb54ZdH?=
 =?us-ascii?Q?JqHPFMTX8mAK+QDYQqytZLV87Cnhd2I3QaFgl1qYloW0cs/1nTvtQHCIjVRZ?=
 =?us-ascii?Q?CQz36jVbaSFMKmVsOVBB9oP8LB5Zw4g4ym1/udt9i3XjgBkZG0/BmnL+x158?=
 =?us-ascii?Q?JJ7qnYBLW2LjLNo1ecusR1mteW9XbDEvh/vKXHRI9lXkYYyuvuXo/k9Iv0pf?=
 =?us-ascii?Q?1D9BMq7rydCncbMbZGx1XM3yS6Espzzg7pQJ9C+n6s0kJbCBVH+Wj3ijs/RG?=
 =?us-ascii?Q?mFhWPE+zNHVEW+FdvWk8YeK2eY8+oBHY2AeVFVE1ukVmG7B9BFkyoc+jCgUf?=
 =?us-ascii?Q?Wy9zgw9jr9YNfyR7BAX921CkGY7NpRr1PbCEwSwGUkqVTMXQ16+0RC6kRWIh?=
 =?us-ascii?Q?DZWbEka+WTEVbMzNDekhcpNMN/yiu4Lg1JGKY6vKs65XEdMIJvmbwXvp0wUb?=
 =?us-ascii?Q?Omj2yisdOLKqEChewYQNjrDHwWLULoZv3xtqhff9dlLDXwbTIFF+lbZMwL5D?=
 =?us-ascii?Q?OhnH8VC7RzzS3fYBqveuRC2vExS+flumzi5oQHJswMkgqmtsGFTVOSUZ1sF7?=
 =?us-ascii?Q?z/toF+rGE0IwAIhHnc9J3pi/knC5V7Us/VxI6ctD/H/B8BISdOt9cY+7TslU?=
 =?us-ascii?Q?fhuSCdYUtJlUxh+K5ClcPD7aSmLnTK8q/xM1nY81ekoAxUo8X+UzfJmX+KFm?=
 =?us-ascii?Q?r3cWLbOgyUb2aX2R8ETJ6PPkHyIcRtoNWwTsvR+mlQ47LUmaAAkAVUwxYQaQ?=
 =?us-ascii?Q?qnuYOefkJ3TiEb+n/J+4lM5x/hYHrKwTTCU4lI4WAK1bNAENmPyomNB1rEbS?=
 =?us-ascii?Q?TVHR910F8QU7ebApKHqoB4H7GIe2TRYFwisKufsu4n5sEAcQBxV1tnZXDQgg?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2916f6a8-20e0-4a9c-086d-08dbf825081f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 19:36:53.8228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INHJ5XBVO4xZtxE2iQ4eppluLO84SsAF7h4JzLH2jrWNIIwn/6kNpD9d4cljapByUAC2iGIiv5KtA19lAj06lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9213

We were documenting a bunch of stuff which was removed in commit
93e86b3bc842 ("net: dsa: Remove legacy probing support"). There's some
further cleanup to do in struct dsa_chip_data, so rather than describing
every possible field (when maybe we should be switching to kerneldoc
format), just say what's important about it.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 Documentation/networking/dsa/dsa.rst | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/Documentation/networking/dsa/dsa.rst b/Documentation/networking/dsa/dsa.rst
index 0c326a42eb81..676c92136a0e 100644
--- a/Documentation/networking/dsa/dsa.rst
+++ b/Documentation/networking/dsa/dsa.rst
@@ -413,18 +413,17 @@ PHYs, external PHYs, or even external switches.
 Data structures
 ---------------
 
-DSA data structures are defined in ``include/net/dsa.h`` as well as
-``net/dsa/dsa_priv.h``:
-
-- ``dsa_chip_data``: platform data configuration for a given switch device,
-  this structure describes a switch device's parent device, its address, as
-  well as various properties of its ports: names/labels, and finally a routing
-  table indication (when cascading switches)
-
-- ``dsa_platform_data``: platform device configuration data which can reference
-  a collection of dsa_chip_data structures if multiple switches are cascaded,
-  the conduit network device this switch tree is attached to needs to be
-  referenced
+DSA data structures are defined in ``include/linux/platform_data/dsa.h``,
+``include/net/dsa.h`` as well as ``net/dsa/dsa_priv.h``:
+
+- ``dsa_chip_data``: platform data configuration for a given switch device.
+  Most notably, it is necessary to the DSA core because it holds a reference to
+  the conduit interface. It must be accessible through the
+  ``ds->dev->platform_data`` pointer at ``dsa_register_switch()`` time. It is
+  populated by board-specific code. The hardware switch driver may also have
+  its own portion of ``platform_data`` description. In that case,
+  ``ds->dev->platform_data`` can point to a switch-specific structure, which
+  encapsulates ``struct dsa_chip_data`` as its first element.
 
 - ``dsa_switch_tree``: structure assigned to the conduit network device under
   ``dsa_ptr``, this structure references a dsa_platform_data structure as well as
-- 
2.34.1


