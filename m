Return-Path: <netdev+bounces-58877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EF48186D7
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 13:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CA9286C93
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 12:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD30115E95;
	Tue, 19 Dec 2023 12:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nKDuRacB"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AFF1864E
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyvIbY0ySuRBrPLAe20LHHzgonPaPAXZjo8D6+op5RKsCEAKhRpeUlhu/M3yuBPa7YJB64JRRc+aFePRCt9YOiZJBi8GBfb4CCCfrWu3WWvX+/Daaxuj0NcCbWhd7H38BEGZ9tiJIy/6Ls4p6Hb9NennLnu5oiPuM+WoaEdAVhSYJaWtfmE6QUPG/xpUtXpU2Pejh8uJxzUqRXV7WVKojFW5XnbrYBgW1S/Msl/uJMj5i8qxh9F+TeThyKsFSjYTE3n9iQTIgDAC7NmKid8f7AdJ+1lUu0wtnnq9vaBa/atHTarHWwcuDh2BU1XgaPPpQneohBsPDgy1KU4b9pQOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfOVslG5kHJHnbfw25FqC6IeSxt07JdmjQp0B9v0JyQ=;
 b=k4julQl+9ZFLI4UUWmpdOphP+3E5rQiGkFmNT8ur4ivZbLsJzdMAu1KhZlvZinhfIl6B9Y6I1wUZYjfjxoW4xzmnoK5DFStXSrqUEy84N87Ll4hJxk7xMad0pj1pufxMJuy4ECz9aHpVutm3rT0pRdVvC/vxa3EUOo6Mk2wPM28P0bOyvTtsXn32DKf0KfQNWMJis/wXPmPLsVQLXyU13IHC0emgqYrWYzEa+xuc42dsKnrp7D7CuLEb5W7Jtks7ICXJx9pYpkhU0QRdp+28H7SkypRJIYw9HBgdOcSPiUdj6/TQwaymCUAbRtK9Bml3YGGnDesm+pJ0LW7HwMkqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfOVslG5kHJHnbfw25FqC6IeSxt07JdmjQp0B9v0JyQ=;
 b=nKDuRacBalaUfPogL0mJYty4HICzoSqVho3zfh0CDi8qPr5CP7sHA1vLoF0K+iAY7F9g9rcBtNt75wHJoAdbCotpwDFLdjKoDPFDbrU/7DZBpGoFpG6LEhfoj0snY0by2Eu09MRaCCwdAHNQJfLV6C87IENs4KRnfTh3nu6b1yw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM8PR04MB8033.eurprd04.prod.outlook.com (2603:10a6:20b:234::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 12:00:07 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 12:00:07 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net-next v3 6/8] dpaa2-switch: reorganize the [pre]changeupper events
Date: Tue, 19 Dec 2023 13:59:31 +0200
Message-Id: <20231219115933.1480290-7-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
References: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::19) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM8PR04MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 535cf932-031e-4eb2-23c6-08dc008a0aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m8s4A+7BqDMlNYt337JeHB+eJZ29qE/DGcBG2qSZvRVhCu+KHZBuOHsb9goojhu8wCeyhBm9M42rPTuHuEhGpKrzvf6ZVB4xR3VzI02p6c3PFssga9E4aMhD4BRdIeHtRzgPFP2sB6aTzqnw0KgbOzXGjAc8M91XceMUyRWb3Uvgk/1eDXDWozcqTIYacZ1ObAthvhGbDJZPQj00UYnanGIyXswyaJjrbC8Eu1z6kiMY3BBNSHwnIKMo1cP0X9UzHeuh0ZT19IOQDLd7gKThGsHd0cVQ3oY9nGIZibtHZh0wC8g2In1sqIievV05iCXcKjzxsSmZr3jfbDrGY7wcKmHCPIH2XM2+dzJCUiGelj7z5TrjE2TyPGxLNgImQORvbDOz03y4MmzZvEUHVo1cL2r1OQHHRdyK2BwhnoLd6jitG/84UPz4h0xiYieERH0NrUydXgn/0ujxXaH7wJvuaJbk+3eQhClab4ruj5wBip2Fm7Pq3cDp9eIEcMosoZym3sJltbzqOX2OAhzxfq06/cuT+h3ZIvxKbNpyoVOGH1tjri+puRH6xap/F7iila8a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(1076003)(2616005)(26005)(38100700002)(8936002)(8676002)(5660300002)(44832011)(4326008)(41300700001)(2906002)(66476007)(6506007)(66946007)(478600001)(6512007)(6486002)(66556008)(6666004)(316002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DpRndWZHhkwKXDbtcjamRDrfWOK60qE3qFrnzN7TPVAr7guANJB0p1dbcf6K?=
 =?us-ascii?Q?iEaK4V8KhAGw4Uv4sT1T6CgJvx5cw+S+/l18k106MxZY11MZEaaq9JMUALj7?=
 =?us-ascii?Q?CR+QEZrBU3irul6xj4ULtOdXfCo6rn5hht/jfUq1Vemdn34VsJjjX76AdcPf?=
 =?us-ascii?Q?IS6uTOrJBoulR7lqhQwL/z6ncDWqrBdlS6DibyQBJA+ebHlgSMA+J51jPdZV?=
 =?us-ascii?Q?TBWhSEZWFZ/nm2yaskx8qs4YMAwpBRT4xZdsbpO9TjE1fvPs7XQiSt6RRBju?=
 =?us-ascii?Q?mLhBl9XQKG/tl/rEh+vRDPibEIVgvniBjjLXhGSUBa2sfoM0OYRvz1Qhn1wz?=
 =?us-ascii?Q?3gHeM6oeZY5QQbDrXsJby06bRbUxd/V/y4arrxS9QeyaO9j9ISMJgBjVhXBF?=
 =?us-ascii?Q?yImJk1KDtXh8O+tvpeLHx4IPQOyK7ehrtF8kB5QKF47xjDjEkiJTPbbEVwiU?=
 =?us-ascii?Q?paFomPYClIocU669sDXnWi0lYRhVtZhVLLRpoifSQvF2j8zPWbTERsjEayGz?=
 =?us-ascii?Q?/1B7zqc8aAI4FIPueJDOA5jVEZw3luLPd4VBBHf1ahSUIOC/EkUlKX/c1Lt/?=
 =?us-ascii?Q?UIVkctkstmEqDHojsurPbqRDWc+9yWuopZrDfE/dIxKGwR2Q8lLPk4DqY3TT?=
 =?us-ascii?Q?hJ1LpjHfp4wLr7NGVgAQgRUatkQxwH6jyC6+mbasJ9wKHkD8ipxbDuQvvRMb?=
 =?us-ascii?Q?B0jpOepeKuaUkbo+X9cTfbyejwugSBrCe5SyonEg6dkJseIPiH0iCg1VM05b?=
 =?us-ascii?Q?hnecGT+dbhGM6I2etItWcH5FDw4ZeHvN10tT2An7BT8ge7mBegq/2G4M4cyd?=
 =?us-ascii?Q?GJIAbUDO/m12E/IGH6wMNKxArQ1pmyekqnWkkbrlZKHiK8CaMZYc4MlzDXJy?=
 =?us-ascii?Q?FH6dTKApVjWe7XleVyoB/LMvxBd3POLFgWco6Z9e8UaFnp/D5aJuUrHj1XoI?=
 =?us-ascii?Q?UxGEZijHTxoACLiDsvdlgJSg7J0CBCmE4YjqGe0qWp91WCHRk42hpM8j/0rK?=
 =?us-ascii?Q?W7Olvb4qOrE1WU6ES8gpQemlRU4dtxNxVXEI6qP3XskYXgp2WYEgdN0Ihmoi?=
 =?us-ascii?Q?i8Cqmwzstx2eRqeugysspxmRjrGsb0jYWCPOBT8F0odFI+wcD5woOcT+MrXT?=
 =?us-ascii?Q?0Db8QtHC5sWsY95ZWo4kYIr1CQTllu+me5k/0MGqImWxPO3LP1BceNh1gxP3?=
 =?us-ascii?Q?jaMdyHrGwbNZVnQ28C9xBTSO5djmt7KrsgW3tRkpS4/fERtS9f3bvbac9O1+?=
 =?us-ascii?Q?Qwei1YgXFBYkxtfUruBkNnZpRoTAh0mZtwrD/hXa93f+P+QjE2wDj4UcOKmq?=
 =?us-ascii?Q?M6ByDmkS8W/d4WfSo27trWDmgkekSSzPb+8Afbo+XKaxw9UIoLwk/xlA/YmE?=
 =?us-ascii?Q?1YaZPxwJuFd4H4kHyQm8zRdWAp6sU135LnZMiRssdCWN/kCuvD/fnTQeKski?=
 =?us-ascii?Q?95xnZkwGn/TNTNhacDnopmM3b0gmg3GyQs81nhXRv7sKusqTbJvQ1tBKuXAZ?=
 =?us-ascii?Q?kWCr8VoBpcCidx5IkfcYSeh6l3lVM9lThcbbgyCQffycQMglPrkgsP6+6sSC?=
 =?us-ascii?Q?F1slxhtocY7+pmKeaixPaNYU7GK+u5RtxYYCa74+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535cf932-031e-4eb2-23c6-08dc008a0aeb
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 12:00:07.0718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWrInTpRGSMYVkYOvl0nVT5IB0WlDXx7rAyncUbiaqD2c1c26WVZURI2/m8KFSKqxzdwj3bDt+ZwNBaVk2bQpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8033

Create separate functions, dpaa2_switch_port_prechangeupper and
dpaa2_switch_port_changeupper, to be called directly when a DPSW port
changes its upper device.

This way we are not open-coding everything in the main event callback
and we can easily extent, for example, with bond offload.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- removed the initialization of the err variable
Changes in v2:
- none

 .../ethernet/freescale/dpaa2/dpaa2-switch.c   | 77 +++++++++++++------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 1b8d233e0802..a9a76d640bc8 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -2173,51 +2173,78 @@ dpaa2_switch_prechangeupper_sanity_checks(struct net_device *netdev,
 	return 0;
 }
 
-static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
-					     unsigned long event, void *ptr)
+static int dpaa2_switch_port_prechangeupper(struct net_device *netdev,
+					    struct netdev_notifier_changeupper_info *info)
 {
-	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
-	struct netdev_notifier_changeupper_info *info = ptr;
 	struct netlink_ext_ack *extack;
 	struct net_device *upper_dev;
-	int err = 0;
+	int err;
 
 	if (!dpaa2_switch_port_dev_check(netdev))
-		return NOTIFY_DONE;
+		return 0;
 
 	extack = netdev_notifier_info_to_extack(&info->info);
-
-	switch (event) {
-	case NETDEV_PRECHANGEUPPER:
-		upper_dev = info->upper_dev;
-		if (!netif_is_bridge_master(upper_dev))
-			break;
-
+	upper_dev = info->upper_dev;
+	if (netif_is_bridge_master(upper_dev)) {
 		err = dpaa2_switch_prechangeupper_sanity_checks(netdev,
 								upper_dev,
 								extack);
 		if (err)
-			goto out;
+			return err;
 
 		if (!info->linking)
 			dpaa2_switch_port_pre_bridge_leave(netdev);
+	}
+
+	return 0;
+}
+
+static int dpaa2_switch_port_changeupper(struct net_device *netdev,
+					 struct netdev_notifier_changeupper_info *info)
+{
+	struct netlink_ext_ack *extack;
+	struct net_device *upper_dev;
+
+	if (!dpaa2_switch_port_dev_check(netdev))
+		return 0;
+
+	extack = netdev_notifier_info_to_extack(&info->info);
+
+	upper_dev = info->upper_dev;
+	if (netif_is_bridge_master(upper_dev)) {
+		if (info->linking)
+			return dpaa2_switch_port_bridge_join(netdev,
+							     upper_dev,
+							     extack);
+		else
+			return dpaa2_switch_port_bridge_leave(netdev);
+	}
+
+	return 0;
+}
+
+static int dpaa2_switch_port_netdevice_event(struct notifier_block *nb,
+					     unsigned long event, void *ptr)
+{
+	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
+	int err = 0;
+
+	switch (event) {
+	case NETDEV_PRECHANGEUPPER:
+		err = dpaa2_switch_port_prechangeupper(netdev, ptr);
+		if (err)
+			return notifier_from_errno(err);
 
 		break;
 	case NETDEV_CHANGEUPPER:
-		upper_dev = info->upper_dev;
-		if (netif_is_bridge_master(upper_dev)) {
-			if (info->linking)
-				err = dpaa2_switch_port_bridge_join(netdev,
-								    upper_dev,
-								    extack);
-			else
-				err = dpaa2_switch_port_bridge_leave(netdev);
-		}
+		err = dpaa2_switch_port_changeupper(netdev, ptr);
+		if (err)
+			return notifier_from_errno(err);
+
 		break;
 	}
 
-out:
-	return notifier_from_errno(err);
+	return NOTIFY_DONE;
 }
 
 struct ethsw_switchdev_event_work {
-- 
2.25.1


