Return-Path: <netdev+bounces-58874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B798186D4
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 13:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3013A1C23D25
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 12:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20BE182DD;
	Tue, 19 Dec 2023 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sFW8Lu9+"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05943168CB
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvHljDO1bzhyMpglO6E7Fw01Vz+n+eQ8n+fs3WAxq5bhzJZ/B6fFOyPgzdzOPcMfA0T0fjkydOwuNjtUoE4/Lsy3Sa3VQI9Img8tHWdqbsn3Jny1kIsRy7CJOT7h5WL2UCzzAAAXSz+V2ccZyFEH5mHA7L0CFOt3WGVCXPX1DcwZIqs5CowiGRLuCnNSFR6RwNH2hGDILwFz+tSuQ18R2nygYM0rIEtEoufsw8S0WraQTygFVY/aFPXErv1DSBia0fbZZIB6XYzonUxBsR42Tt89HZwj4tkPiIxnJdQ0aDwsj9bpt3sHFV4jKDBpG8EjO0tvec14bEXPw/q/U8I/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKv9V1sdLPZ7IpF3xTZC2Xs7ndL+giaaHY/Q7ZXuGUQ=;
 b=YI37K7dmht+bMsfpuxv/b+4/4gVEr2lZURjFngWEQlQ5LGlUevyVnSiEouKKuYVbEkqynHOgt4kWEouBuorQLy5HOEuF5EgegrrPJiFSP3LiSjkoEnXo9a3r5HT4iFc0TrWIh5BL4vlmnZq9r1Dym58pyPfFzmovnxZQvct1sODSgcyjSDgL5zqPgxT8sJx0aPQj7YRx951cZRYwwbCTWJK0/1kxIMLRXq443nZURMQhhHSheMnJgpmQmk+x0lmGGrDDqgVxy/81Gx6+IJaiQSTBWk6xobctVgiFPqez6qYcwzQrFYZPjuo23XOs1rC3RhcVK9oMmw3VdI1xGohc5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKv9V1sdLPZ7IpF3xTZC2Xs7ndL+giaaHY/Q7ZXuGUQ=;
 b=sFW8Lu9+hDH5x6R6ve42LCHREkoBUgqCShQL1j/pVJfunqOK8puH5pe7aeSmxbEQCsfLSUasRlg9zfUlOhyAnxc26qejpUiZ/RZa+U7fT+X4lRTYZrzBkELKlU3QkVQI7S+OFen+UNIrCUUc2I1HiEUMbfEeVnXWcepA50W3W0Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM8PR04MB8033.eurprd04.prod.outlook.com (2603:10a6:20b:234::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 12:00:02 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 12:00:02 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v3 3/8] dpaa2-switch: print an error when the vlan is already configured
Date: Tue, 19 Dec 2023 13:59:28 +0200
Message-Id: <20231219115933.1480290-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
References: <20231219115933.1480290-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::18) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM8PR04MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 000a5569-ec6a-4db2-0d82-08dc008a07ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xbyOAZNaCctGmdUXjHnSCmxrzkrRae0JCjuqYbgdbHY+czzMYyL/9JorFN4aJAqlrTpAvuHTPA7B0vau2HitH6S9THV0CZtdt0NQchKj892APGJmTl1/KgRKa1RMyZDwrLStxPUlqNXlEs0njXzda4ZuH+zR1DN5yxLhdqWvliBWGDSsDljpHSQNpjDovbTLBLNmaDE70Z1FGtXbcnwPdA3BloPfnXMuUn4N7ogXzrWm42Ucb7nenXeJVtLpmftqHC0QHV3QGTzZszRN2vHxiAvlhT5mVCIq3p6EAuT2Sm/kyuZCLjFdoHso6J1z0CHJR5QAERUprJKGg1OCxjw6KMmxw4iUAsa6aT+wpX2fJ8hyisNViYJH30xC03h9RlBwe3faiY9ZRnnMwlb+OZBvJ9ttzBpwL6Tk8ivYPHxvIPp0Oe+rA7/o58BNHr5qwbDKKEICd/Sgn6rmQ9nqSQHTy2XqDW8rDTiXheQVvdlMxTI/+fUXj1bYNjNAi/zJHQxD4IedEK+UgMZ/1sV2bZ5ZrDufiKLSKLes5suy1WTAA2Ios1LWKoD1NLRbldsvRJml
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(1076003)(2616005)(26005)(38100700002)(8936002)(8676002)(5660300002)(44832011)(4326008)(41300700001)(2906002)(66476007)(6506007)(66946007)(478600001)(6512007)(6486002)(54906003)(66556008)(6666004)(316002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fCn6FlEuWQGkmdlu8wGMYcMrl8nsmnil2/5os2bwzXDzUhQ9pryAie84nKBn?=
 =?us-ascii?Q?LazSAhDCUXYVQk6Y8/wRUL13IQybpY5zdUnvMHW5QGfPq+j0u0wrm8R40H4b?=
 =?us-ascii?Q?66jAbuE2oCsJrQ3R2aTSFFqIfwLD453ghhGsFzQwk6XCioh6xeHfgwR4h6ap?=
 =?us-ascii?Q?5dCI5pUwW8HlbgY4RPSvJMvq4KcuGI4KoXckSO5jRB7CW3eSpqgP32+g6DSa?=
 =?us-ascii?Q?B4XYr9HNneHFuMEVyOsi/EoPT+Z8p7Pq9lLNiKrrGpZYPuDc1FZ37TK6wYEt?=
 =?us-ascii?Q?Z8X8mYRMkyGrvzrIkIku23ca4DQSNZlGtDcyDRUuEe7U48bmRzrUKMknsLM6?=
 =?us-ascii?Q?8enB6hgPjsPo9A+zEZFn8yNiIXcUkK/MvC9i85D3IXusA6YuhXcqlcyqt6aS?=
 =?us-ascii?Q?aHuXz3/XYHUp3u8YEsON07X1KJK9D7s534BlHHWgeHXYDl30B2RshkOgkDGW?=
 =?us-ascii?Q?caAxh84TVgWzENTgodWx2NIo3sBm27tcnS1dAqEBmY7vgl16YQUClgwZvkIJ?=
 =?us-ascii?Q?/NvyVlZ8OQ1yURDWaNrsrZjzfIVZl0S5cDTAeC6C7dRee1q3C/j9hoAh0tzv?=
 =?us-ascii?Q?5K92WZZ6HiXwJAdKZQHA4ACAGkG9iRhy8LYCD+hHjgSJGgjCyKbkFMYJEjDH?=
 =?us-ascii?Q?iWJA/86j+x63y5eVqxzsSTksg5UNMa4qYBJT+Rq4Dqw/rRRP2e+R5FXYGIEn?=
 =?us-ascii?Q?MTio9L6bydPykLhtwjebXTD6Fl5mNJTj7SssCMrwKpPIMr/v3ePK9KxHaes5?=
 =?us-ascii?Q?EentGg6WiJbZLub8YYCOitX6JFvZhejB2oKAZFjMGc3Ww5w0+CnGVuyAiHpF?=
 =?us-ascii?Q?mjnu8pWmswkZnMHuV1BwMmZAtL2kXobMrFwwv/dEXnsztaoud4p5usqK3h3r?=
 =?us-ascii?Q?gT1/RRNaTik0Bl5pQTzgNRVnljPcgvpS2nhHhr5rW+0Byv7JfAG9fSZzHZIx?=
 =?us-ascii?Q?2IEAbk9nlZ/HocnlTtIS7te3Q64DsdD5dSWwqlKi74VWHFDog7WwJ9MekKSd?=
 =?us-ascii?Q?z6RfC4F3bjxyDegjM9RjmlpWag/LZdAf6sXdklwBBiOfSqk4i5DJk5RWfcbO?=
 =?us-ascii?Q?rwVPOkICHs2ZyYlrV8SbiO/fhkhRcUjMle0k6gyJ1A06OpY0K/P/LiT/YX7q?=
 =?us-ascii?Q?rjpDNkfqJrV4+W6OP5ivAuIwmNz2K67pIRNWgNKyKUs0QnM4bHPS7e3WCNoT?=
 =?us-ascii?Q?iF/8P7tl2Hdsdbb6kXtBvpBKUmFFFFNvEa+6rQpcLjmJ0db8uYS/eBHFowsy?=
 =?us-ascii?Q?2fZq/tX1fBLUcwoZlYcs4uhAkq/PEhHZdTv+7mdSta/SoLTUG0BfHuZ647Ch?=
 =?us-ascii?Q?94vUOBtOV/zLbhdQ4wV220hFaBsldYQ1itOVgPyZVkjHM2N2pMt6CEcQ49oa?=
 =?us-ascii?Q?PVdrUsJIPV9rhEL9QnVmIXtTd0++9OtkO2aJDOhY3Urh9ofGpJb5ywyJjQlh?=
 =?us-ascii?Q?zh6ZCnzXHft8BEIlAChgLkKB2DzH6grHepMAE0vIMCixsrJr16TgmZw0ny6S?=
 =?us-ascii?Q?zQ/kg91cBT5mAu8C0i4I2LZfcNImBNsV0y3u63s0X377qMJqMTWvht7IeDKz?=
 =?us-ascii?Q?9y9PD1DPRRVSQz8HJ9tM3EmiinHbegSR/8vnk0EQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000a5569-ec6a-4db2-0d82-08dc008a07ab
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 12:00:01.5751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDN16xKCmcEsiGz29Co0RGiJQEWnW4aaiinpCB4205bzNfbf3+jpUAzZboI0tJh9EmlTJ1PytMF8faaUrjPLVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8033

Print a netdev error when we hit a case in which a specific VLAN is
already configured on the port. While at it, change the already existing
netdev_warn into an _err for consistency purposes.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v3:
- none
Changes in v2:
- add a bit more info in the commit message

 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index a41d5c7428ab..0f9103b13438 100644
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
2.25.1


