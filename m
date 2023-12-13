Return-Path: <netdev+bounces-56870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 828A28110D7
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 13:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 129CAB20D70
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 12:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E0228E20;
	Wed, 13 Dec 2023 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D0/3CqYA"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2024F109
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 04:15:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gV+M37T6cpcJo9sBir6KU75wcZ1HMK7QC+5EL3WkSK40WLu9aJsq6Jc6SD1Oyk85cxp1y/KjgzmP2+8v+CGm/HAKB7iebJRseMYBdEJIqBLF6/MWs5OJy7n4mTgAOAH1ZhaoHJ8G1gAYUu5bwY0fy74N+1s5ywzLPUr909OKGwKGoR0TWKWpkkgaIrZUrS7CNFSEvZ+VXaaO2niLTR2pu2QRWxEmfCo2J7h2a905kiTJ+QKdPWK95E4YvWrOBcTT8uHRfXFZ1MctBlRa6ish7acYZ/pIjf+5xyNpp5d5ahdSZ2friSEEjf/SvljTIe1e9GxPZRTHFTG4UQBEeKvzew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqeJQ5GFw1rwAbFGp56J8F3dxold0PSHRMi+eGRXx+8=;
 b=BrBCKGnbgKDqs2DDZeZUtXRo8pVFcpkEJevUIVD021c/dxw/8wZaiKhLluicRTTvOkl6n9q1jUMwze0hwBL+LBLh0EP6sRt7BLAg66VuulOBHoeUDvPDwcWK2gyaMArZOv4LW0rJ9P7wq4e1wDgdpV4jNjr/kRghZkRVuuzZYXtB4wJzsoKWBdNRgzTlSKaaJDaVwmfelSPOlYcHLp9FknTtTe6qRMMMoBm3uZmtXKriFLsbH5ZwDkAew7ovnyDc0FhSAW6VCiaI0N6dscwqvY5YLg5T6sKLF+AetzMRGWkcSSYItCXd30ea4D4i91FzyrCejXTgw5mGVgJKoNtfDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqeJQ5GFw1rwAbFGp56J8F3dxold0PSHRMi+eGRXx+8=;
 b=D0/3CqYA04WJlKf2DVu42B+AYDBhGGcCwLkfptQmaOp8b0fi4n70WdYFV674CyvmOLC4aDQpjdQcha1XAG3qqr23no2Ld/bNSFD4UWpbdFSYI5BnoxxwXVgFFVev+v1ESRO8UPvBVy3ZViojr/AI3G8Re49QWmjr+Q4nswZwUxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 12:15:44 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 12:15:44 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net-next v2 3/8] dpaa2-switch: print an error when the vlan is already configured
Date: Wed, 13 Dec 2023 14:14:06 +0200
Message-Id: <20231213121411.3091597-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
References: <20231213121411.3091597-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0064.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::24) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb16bc3-0e63-4ebc-4932-08dbfbd53b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZsY/wxmFnILWeMgMLzvRllbV6EitUng0+5YbJDJFcd1embQ1I7g1sVeUE6tEJg8BI7fdzdiVyrVUq/blrrentNFJGmo58lvmpvktywnL1/M/kOTqRn3PNQ22lSekmzQuj+lBl1cCnesQZMOFsz3tguw4lI8N9rWIdeWSj1/1s/d8BoJjGgcGrJMomxR5bq4+ig+6QpzPskN37aLy+GYUPS4TL3ZqsEyYLG6lPHDQoVt32RXJ6GBRHANgal6bCuhGuGjWav77zm1xGiRuQwbSfJ4AglNZon8ubDmMPHuusxiBHzLYqqHDnMTCf/zgqkv2i4AbdJ6TSR2/wS9vl2xGEBYEtkigh3KIKX8a7IaY4nVjYvQnJ9lmKY0AFPv/tswoH/CPMfBf4Du7NGHohwQ0/zhDgiXL4M6H3Gmc5MWOWBrcYrKMx4BPVk3weIIh1xsgukZMXF0EUe1jZLa/Fnre3njDD1NhnWDWvBNt/ZgOOaElMNwFXTV9M29BWTDLlHdxd6heG02ATmdv8gGvA0t8WIjixjlacbrzikRBLJgVhoico1jQsNxxWZWA1NOXdgFt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(2616005)(1076003)(86362001)(83380400001)(6666004)(6506007)(6512007)(66946007)(6486002)(44832011)(478600001)(4326008)(8936002)(8676002)(36756003)(5660300002)(41300700001)(2906002)(38100700002)(66476007)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zEWCJknWdwfDa8XjLyVeGNMlfEhqPT9YaWe1Q820//Nu1MDtX8MO11jqj3Kq?=
 =?us-ascii?Q?wVIqal2tx9OmLevngNBXFnDLVo+ZFydoavqsC7J2/i6D5voxXWHvGj1wSzDz?=
 =?us-ascii?Q?VHrWbfJpAos9qa8fLIzr4kMDEIwSnDKyRgKxxMpVzBQq3Bf2z7bfu4qlPw5E?=
 =?us-ascii?Q?W6tZsYG4iJyslAr4aIbZk+2hDOE/StDsx1yblG6Tk+2rabiNArg8Q3nXUzyH?=
 =?us-ascii?Q?WfzAqvy3KpqAX75rs5O++hOP0RufYLDnvku2ICPxKy8JSmUcXhh6eXyOmtVe?=
 =?us-ascii?Q?usgWQ8KM6QJJg++HhlmbqsxartDPETOnaD4TweCa/jrN4kWvdtp0UCH9nvjp?=
 =?us-ascii?Q?blihElBBab1D/p+s3WGssP47D4+LgywUXYcYQmFpUv8hpq4JEkimeK3gpUZz?=
 =?us-ascii?Q?ja30Kc9RtDGo4TGNREiD1BB4ewpspjSw/CDvNC6TS4Zu3E1+qxN8M/N2y5Gl?=
 =?us-ascii?Q?Jco/fp/yT066t7NKly7xLzUXN0BM1PPkNCWmd+vIJWMQcGec7Mvd69K6TLHX?=
 =?us-ascii?Q?HISJIHVCRWR4ytBiPFsFn2bxIFGHfiB3Oci+B6vobfKQHWm3A0FSrLR/vQyJ?=
 =?us-ascii?Q?+ihSz0pU7mN+hSW91fKi7vDJ6kMj65KivPjR797Wae6dlJhDHxwPc/xaC3fU?=
 =?us-ascii?Q?4JiuVBIQNW4+xKuU7Axwpwmh/Vuv9y+IR61XqJlPChzOAuMAlfo076C7LMnc?=
 =?us-ascii?Q?9qQde1hGDWSy/dfrIQq6u5COD3z9dg/+NcJTCVVltZdutLt8At5H1aMMzXwF?=
 =?us-ascii?Q?TDqnBkY6BKHfS7O36KzKxAwVMqcut2h3Ji8bI0Fn9KAZvg8l2YfMVaMdCH2G?=
 =?us-ascii?Q?jZsKZk6y3PM89lE3/uR/BWY+mjv4Ot9sbuRlr5UDzTrCbCjdFKZKLQ8L4Hj7?=
 =?us-ascii?Q?3UJG0F35judFaWO+HTBBB1ctXy6CVhbMNFz/eOVhqMWTEs+D2h5yloQTsBkm?=
 =?us-ascii?Q?zj44/5ZXcpyIiEaF5d8KWanKG22NnDIXbbj/9S71eawhhGpKrXCIyG9IRgkd?=
 =?us-ascii?Q?TBkVXCMFw+aG26HbOYPtY2sbq0t7+du5sn5RBSUeZCozI1FYlHMo119ViAn5?=
 =?us-ascii?Q?c5QKOMzqFiJg1rgtyf4u2x2Hizeumdqu8Lhdb7wLq4vqbTvCjvazWuR7Y1FZ?=
 =?us-ascii?Q?ZXAolmqQeY5ihwEyyMtfSRGhEzGF0pm1Y7LYuvPVNFx3f0OWBTHiSftVHanA?=
 =?us-ascii?Q?MZzKLOOkP9yTh3E97ygjLoVWI5V7qc8Vy8aBTyX/rSgdVs4uKCLmIvZgfWgr?=
 =?us-ascii?Q?ul49Si+6lKjrjwXbHTsSOJNquTZwl/tQQHdgtXPH2LMv6L5Coz0iBKCIlV2H?=
 =?us-ascii?Q?U8tDMh41R0/wnxYAExYtwODccFno0n3qwuxTyHAXZsqg2GOvKzb2JJsoiR5C?=
 =?us-ascii?Q?3sCTofUpsihHvDD4dS8KENEO016IFuShOdZ8lRswqzCCwfW1QdT4Wzl/0hiW?=
 =?us-ascii?Q?Ka9pdzJ8OX/mKewGQNY6xMl3P2UlCZ8VJgNGV5dax5fnILlCp4EOAD9M2P4m?=
 =?us-ascii?Q?Z2h3EM5c7LYwxPECXJNTJ8CHYa3m+i72V9pU9l8HxaPWPFou2BgYqYfOrgTb?=
 =?us-ascii?Q?s65HV8mLYAiLNnukDLLpsdh/jWUktx18Mu/Br1Pk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb16bc3-0e63-4ebc-4932-08dbfbd53b4a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 12:15:44.6352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zLNmV8sJCUZtX2Sh2yCXslWWwFrYtypTn9eDEDENb0psU8if5q+YDL5w4CMz4RdzhNxLHDpXZE6i0SbiPyUJoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

Print a netdev error when we hit a case in which a specific VLAN is
already configured on the port. While at it, change the already existing
netdev_warn into an _err for consistency purposes.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- add a bit more info in the commit message

 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 5b0ab06b40a7..654dd10df307 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -289,7 +289,7 @@ static int dpaa2_switch_port_add_vlan(struct ethsw_port_priv *port_priv,
 	int err;
 
 	if (port_priv->vlans[vid]) {
-		netdev_warn(netdev, "VLAN %d already configured\n", vid);
+		netdev_err(netdev, "VLAN %d already configured\n", vid);
 		return -EEXIST;
 	}
 
@@ -1774,8 +1774,10 @@ int dpaa2_switch_port_vlans_add(struct net_device *netdev,
 	/* Make sure that the VLAN is not already configured
 	 * on the switch port
 	 */
-	if (port_priv->vlans[vlan->vid] & ETHSW_VLAN_MEMBER)
+	if (port_priv->vlans[vlan->vid] & ETHSW_VLAN_MEMBER) {
+		netdev_err(netdev, "VLAN %d already configured\n", vlan->vid);
 		return -EEXIST;
+	}
 
 	/* Check if there is space for a new VLAN */
 	err = dpsw_get_attributes(ethsw->mc_io, 0, ethsw->dpsw_handle,
-- 
2.34.1


