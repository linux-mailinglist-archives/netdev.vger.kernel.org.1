Return-Path: <netdev+bounces-56874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0098110DC
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 13:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD7D1C20EC6
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 12:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBAA29406;
	Wed, 13 Dec 2023 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iRioFqiv"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2057.outbound.protection.outlook.com [40.107.6.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768A0E4
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 04:15:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSxPzQjIhGZx3da1duwfZeBhw23hHoDp69QTDcEd2yFuaZERD62l/1zsKAmRd4VYLtR2FOX9Dj5HDujNO+ctkMS9RHgOQ2dren4aQOOiyeoxC+Hit90LFgBai7Dju2gudZ3dR/108YUGTUv1IK/nky94pJepPkWtqQn9e52DUPYeUk8U2ICKs2Ei6lewyTAwp9kR+vA7G0dpUs0I1cwk5ClwJMztB6roUCo6RcSuqKqzDn6CWyigCEpLGQlgWmqI7bf5ER55nlAJ9N11Fwyah/D9FPtc4SqwwJnRK4AHvsDSnIrxXfx2IwbMnZfsKk8Yzjk82wlIPdtgvsQbZzaXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MINwNap2inbO1AOWDShHCzH8T/m/ImIfhK/QZcjGEIs=;
 b=d8DAsBUL9qhKyql916tFaSZeKC+qhsk5KRTyekwllqMB5bapmJEJXMo+hnkk/MHhXJZACXENINwdRSa7+kj3Zfp6sg5OSLFytKigV2csy3gWMwMV+QDrkflbZmb8le2xlW3cIFoVEVOg8AHxaNsCX5k0asuHryVP+1aJjC7OeiJgYDMp4rjKcw4+zK1U0PydyAxE234zgo9t1fy8aFcs2VK7F/W4dF6zM/TFvCL6Ybu0BTxUbv9uV90NnakcBao4bQ6RyCto5RkDNO6HQQgzHAuBC0HUpIqvE+tL8ZyPj23LBuQfeJ1lroOwk5WaA02/2+/k7E76Ui6/ZE5x/WLXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MINwNap2inbO1AOWDShHCzH8T/m/ImIfhK/QZcjGEIs=;
 b=iRioFqivzSUIds3eDrYkTzGx+Zl5Oso8NFENeqTaxecCkevuNnfTm++Okihvx4SKXbJuNTVeBfIwwVk82GvL5DwzyDmsACm/CeEIxlzSabCOwrtOJsPAbldvK6JA7yUxudu1PodTObuVz7OrBaH5nfwJyuITk5oXXGOIY9p2vNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM9PR04MB8455.eurprd04.prod.outlook.com (2603:10a6:20b:414::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 12:15:52 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 12:15:52 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net-next v2 7/8] dpaa2-switch: move a check to the prechangeupper stage
Date: Wed, 13 Dec 2023 14:14:10 +0200
Message-Id: <20231213121411.3091597-8-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
References: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0068.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::23) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM9PR04MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c7b519-45f4-4d4a-6014-08dbfbd54030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BwshD3AououszJhTgVL6GKquUMTl+EBox7IWGyZtrS40mvoPy65RnpFFrXBgVUzmZJNxwyCrxVCSYDhztC7LqVq29u/NPGgwsy58ZesToVkbtRehcAnw7u98yT3XlvJdfo57diY+3T4a9odDaEU49rTv/u0hffAC9ab1XCeKHz8I3yVtlefDuUZv4+dMO7Xr8/gZTXy8D5BbOnYO+DJ4z2BiV0HhbbGwWxPdyq7d0GQdfVZYGa6Y+EKiO3eDUZjy3z03S8qQTYeYycB4LaPv3XDJGqXMe14yaTlBCxbqaOx12HdYs664WtIktvED8AmFZx/WEJ2R71Uj1ab0b5Rdt3jfRWOX6fvyqg6fXmhMr3Yt/36cMqeYf85spe0zo8VQJYdC68UD85L5D+VilxEB820J+FzY1fHI2wLRZDQK4yGEl8cezgOqvoGpnPbozjmSuw4odgJlzAw7M1kDq7kY8M6MoAxQYfqjiG4b5wXcHjpQJHJKzilNnz+jTM9+uSyMCvQesZ7no2RbUV6BVDXfiuOX28mg7xm6uZ++Hl+BQBCuK1eVz+nFA4/W2K5JMzGx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(38100700002)(26005)(5660300002)(44832011)(8936002)(316002)(8676002)(2906002)(4326008)(478600001)(66476007)(41300700001)(6512007)(6666004)(6506007)(6486002)(66556008)(66946007)(2616005)(1076003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IsZSeF1Jw2O7NcVRK5RdStTXApR1+eWnl6sRYA3kD25XXJgkGQrbyhqD3tep?=
 =?us-ascii?Q?RG5cfESbLitlRTG/1Q8Zc9wcm1QtCi4QXVTE3dFOPXws2Fg20yaaGbbTw2Yo?=
 =?us-ascii?Q?XVuehgQRsFceiK8vbR108EIX4kWHCu7AD2dvtNK8UJmj9DBUDM9SckbtGhcq?=
 =?us-ascii?Q?IAo4VHRb70rdr95Agw+ClTASD64k7sX5h2LrSaZWVBlKKQFSmSUw168EvJiw?=
 =?us-ascii?Q?9RUtNwwD5YMpVZoGSwkGZEazZJtley3L3+NpHEczuR+R5JWO4zlhhjyiXgb6?=
 =?us-ascii?Q?/NKoR0oDwNYg9zF+yLwF5iqUtALke1ODlwYQTrTed2jzUOd4hOt81sDxcgxm?=
 =?us-ascii?Q?5kl0FxoLRmBGGoCQbOiDCzC4tXk9G6Sj13Yl+ot/JO9VwxWiPvCYVjR1wxqJ?=
 =?us-ascii?Q?ikFFGmH70MRu4YWUEGjFty5CmbanA9HHda2xpS5SDN3Y0nf/mimrTkAGhrjT?=
 =?us-ascii?Q?m15WEgVeyBmqXCSQRzogPXqPa/Utm6WtDJuL5Eyai28qy4NgY6puzoOYmCEq?=
 =?us-ascii?Q?3rXQGx/N/GGC7YEM7+LydYw6Ez6hn8mCe2vOFnwFBL9Fl2lCVieDgYmVT4Ii?=
 =?us-ascii?Q?u4XdWbl5Intf9SS/tSW6Xo8bVrOpkXSTiToyjFm5+auaodg9uYtERzQdzvkP?=
 =?us-ascii?Q?VTFIy6nzZpkqpnE4F7Gv92c5h/dwg/1+u3FovYh5B408JWVjvjAgfxlge4fA?=
 =?us-ascii?Q?Dkf/Z7avTXwkM/cN0JSTgmmo1RY3T12nQrmeK5//5pVEjcLjaNVHzNGuKCai?=
 =?us-ascii?Q?OD9uT+BZu9eiay2kOTMd/ZXlg5oqkY5Pmn9a9RjtJ/loGwY59XOVOYGfeEF3?=
 =?us-ascii?Q?ueuaWOSnsgbWZNEibIcazfAPzJUqD15qKeGIrPcdWAOPqwudhWj1wBPjSmq8?=
 =?us-ascii?Q?fFGseWlb8EZ9DmajpsvK/9P0wjDg8B0DizJhIWu4klTi/XqV1gEP7M2252u7?=
 =?us-ascii?Q?x3rJWiAJzDuhITSNiuyhmcZefEGyzuvMowwcFi6Qf33T2LCDhDgdNJkhKOlZ?=
 =?us-ascii?Q?E/gfSNTXtzIpbjUd2vLX7oTlx0rBTLBpLyFjtezjnl400PGhPcWAS5+qOJ97?=
 =?us-ascii?Q?ObdP1eBqGASOU84aRo8zHLE3bFF849ZqQQyY7MXvX/NhhI4D1cLtDOpnnXz/?=
 =?us-ascii?Q?NU8x5qCka2rhxdanlbf5a93jMXPnBjX7rkMUfz307BnwwRCypD/wsbaWaCa0?=
 =?us-ascii?Q?oYtoN/wwAw+rEQAJqq00wwwrgN+ZIRjqhWU1fV7oZeSFLVEB8SnBwR94Qkb0?=
 =?us-ascii?Q?TqkC7JYvnrMXReHUqZwH/a45BUqb700YRRMqKs4xBOBHgpax/TdA7PLcpeJE?=
 =?us-ascii?Q?ziEYMyoQYEWbHmTg447jrCsf8Dxpx/nmCLimTAshZkOWoXLopz8Ftg0C6UXY?=
 =?us-ascii?Q?bIoKGTx/CspICnjiQ4Ad7WJTaxlVBbD1CIWTYztMW+LRuPPHG6FM0aWxHn8A?=
 =?us-ascii?Q?9hmxSOtNEf/6U/EHWSJDCnKYhWN/3/7+smPUFuu1uWUPqaPH7RT/paWkDW2u?=
 =?us-ascii?Q?4iEPcMvXl+ldy/MFECiUf4EZm7NwuuBVD/T+J0mlNqzltJlnuCcYSxpcIUkO?=
 =?us-ascii?Q?BK4qMabl64g+TQkprZ1DMt+Po1bdc9P9PFDFGJfu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c7b519-45f4-4d4a-6014-08dbfbd54030
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 12:15:52.7698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/rMenSYSCsxUOpHzvmK7ORn3yGKdI0OEE1UV/suffqD7m3gh1pqqNBCw6yZADKDYwLvxce61gj9uGCjfZpNlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8455

Two different DPAA2 switch ports from two different DPSW instances
cannot be under the same bridge. Instead of checking for this
unsupported configuration in the CHANGEUPPER event, check it as early as
possible in the PRECHANGEUPPER one.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- none

 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 58c0baee2d61..dd878e87eef1 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2008,24 +2008,9 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
-	struct ethsw_port_priv *other_port_priv;
-	struct net_device *other_dev;
-	struct list_head *iter;
 	bool learn_ena;
 	int err;
 
-	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
-		if (!dpaa2_switch_port_dev_check(other_dev))
-			continue;
-
-		other_port_priv = netdev_priv(other_dev);
-		if (other_port_priv->ethsw_data != port_priv->ethsw_data) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Interface from a different DPSW is in the bridge already");
-			return -EINVAL;
-		}
-	}
-
 	/* Delete the previously manually installed VLAN 1 */
 	err = dpaa2_switch_port_del_vlan(port_priv, 1);
 	if (err)
@@ -2163,6 +2148,10 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 					  struct net_device *upper_dev,
 					  struct netlink_ext_ack *extack)
 {
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_port_priv *other_port_priv;
+	struct net_device *other_dev;
+	struct list_head *iter;
 	int err;
 
 	if (!br_vlan_enabled(upper_dev)) {
@@ -2177,6 +2166,18 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 		return 0;
 	}
 
+	netdev_for_each_lower_dev(upper_dev, other_dev, iter) {
+		if (!dpaa2_switch_port_dev_check(other_dev))
+			continue;
+
+		other_port_priv = netdev_priv(other_dev);
+		if (other_port_priv->ethsw_data != port_priv->ethsw_data) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Interface from a different DPSW is in the bridge already");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.34.1


