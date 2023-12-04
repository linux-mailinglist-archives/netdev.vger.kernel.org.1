Return-Path: <netdev+bounces-53545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D292803A68
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 346A4B20BB2
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1482E3C1C;
	Mon,  4 Dec 2023 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d6sEnK7Q"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9218CCD
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 08:35:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RY+E4kh+et4pE8MXDb4ZyneDbyOQY/6gLCLiC7mF7AFzE22MYJCGrS3Gx5ASm0PgQqgsokx3UGDtPB8Nu/Y3hj4u821wd89a9kig5CD9Rnifr98G5fSTMtUm0Ev7hWjUzE4s+m1Ltdr63a2da81MTET6eVpOkgU3gSacUczbec5GyTRz4L46n568O3FLyswuObFOuqrJ2rvbKl2vMAsF+7rT2ztGudN1EgDDhqq/5q84yGXmdtCWghXRzieCbNcKsQzmd96RICYF2eHRGiRG6xrPeuo2cIP8+SwqRqiBH5YqicBGQonDYuKQ/JRyVoFC4edvxCAtDsT+uwM/3sPLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvUkgOduqs89pgFDg5vnLX/qQEvizjapYX8Gf2ZgoTs=;
 b=SqhiiGPzTpfIiGtoBvj0CAAWDUzlV2Qf3f+9/9gLS+PIPKnZ8NpjvNmA1wSwZy7fjMJBthScIzeBYJ7pDm45FAu3FGPhJTgJTmu1iC8LeJEH1rOFLqJGz6iy+rzgJQGT1yNDoIhD0CkaXtLSCN0vzkJRZdJ4cbUWkIt4kZekSZGkNt/DNJI94u0ojeUjKJCwljN9H2vYEfWTmBMaRsca81255cFSF549N2McfjcUqHFIdZxFLi8QND6b4sJ6cggopEbhw4a52DTkWqpOlAugpvJVGE5+z1ga8h3LXg9evtKPU0EKuJnNW+ONpd50JK9No6lG8RJAeq5dYEaLvMRNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvUkgOduqs89pgFDg5vnLX/qQEvizjapYX8Gf2ZgoTs=;
 b=d6sEnK7QcqK1FqnPG/5Lvjk6qyzSIfQ8jYEup2j18DFY5D+urpW3GHCZG/hiKDK7uVSoRvI6menb4+onLGYBhBFiLbNIBLXoIJHZFZ2i/v4oFFB4lU+Lka09ztGAIX+HOIYiPMDVLN/+uNccwvfXNWPJwHEYLkKB9j5MdcqfDVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AM9PR04MB8356.eurprd04.prod.outlook.com (2603:10a6:20b:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 16:35:56 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 16:35:56 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 1/8] dpaa2-switch: set interface MAC address only on endpoint change
Date: Mon,  4 Dec 2023 18:35:21 +0200
Message-Id: <20231204163528.1797565-2-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
References: <20231204163528.1797565-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::7) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AM9PR04MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: a2fb31e4-c398-4210-19cc-08dbf4e716e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xbqr/++Vn92c397p7GF+kEHRmFYlB797jOrYSDtxTVm/tGBV5qJNmOdcdrFw/tRcaywigMixMjqOXif2luopgd/Yxs9hIB5rkweIfBQ/kQwjRTkPGoPYBKZtYMcBhFXPEWMOisplihveolaBdOXdddywjpl5VOTfYFji+3eoEiaO9VsNKqCViIDgA5Vu8vlIrETZabB3vJYbXL1mOMl7md7nBQJJfH8/+OZY43trXopYeVfxO/8N4f7kMMmomi/F5xhb1U5cWJqfLI0UWdi3eWH6n0qJs1n4sXHnLPbDo+p8F6Uv75v+ZQa3BQTM6bgZMqn+VGgcqJzGdTiYvRGYu6QaVjefgMh8h0MHMrNtY8I4TAbknG+QxOho5aT+CDuzMYYprCs71rrsZeEwub/9DgZhGYe8NZjfcu4gBLbOBmqlS3qZTalxdxG7Jf/e5JOrWkDQkwByxn6GK1piPCnt94arThCbYhhZVb+gBXAmCeuOGTL3GvJ2lc+fISpC7QpfnX6OfiKy7v2SPSBgm4TfTDqGSw3ju9L1Do3zCKxyAyuwwd3QbwHRmWgYRwjBtsHH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66476007)(44832011)(316002)(66946007)(5660300002)(4326008)(8936002)(8676002)(6486002)(38100700002)(83380400001)(86362001)(478600001)(2906002)(6666004)(26005)(2616005)(6506007)(6512007)(36756003)(1076003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hucAyfeebiFo8ckD9041rBApF+oD8SSoRqwssE/HRCGXKsRug6V0kb/yvN6p?=
 =?us-ascii?Q?wEZf4dfAWt2L5Y7fU22G797ITqM4YBrMDDY7JHyjpftyeqyJVL32d2Z+4QVU?=
 =?us-ascii?Q?40IcHHEoPoYLvEKCPxGYW3Tgb06auh1PXHfWGBIgVZrVxvIcKwz5/6bBWR9T?=
 =?us-ascii?Q?9qGpuxvm8BRDT5Cw9AQS0AKGP3i3NfCfIeqxcs4JFXsaSokoIRQOL9tV9q9J?=
 =?us-ascii?Q?9RW4fX6NL6qEQwvUf3BE/138B8at+QqPgirAXDLbqM2KfOh03aGvNy8Ospj/?=
 =?us-ascii?Q?UDWecdP9432UeCNR0cyw8zIHWZcUl6NMnIz1WgWqSom9wWO3xwUBzdFtAoZn?=
 =?us-ascii?Q?BPv3+qP6vOr0XsUlbSRLLqVc7cP68BgJSNJ2ykEEAc2ilixVr1oUi5NeHN3U?=
 =?us-ascii?Q?umQi4JY+dUrdPCk7qyTQm3Ev81HmBtokV26kZaVqX5uBd40jnlznIxy4WTgP?=
 =?us-ascii?Q?e3PZ48un895t2UujGwjXi4SnjImOM+A76S+d2Ncxox5+lFVNCTaGt+idXFuW?=
 =?us-ascii?Q?4QmR+TXuPZXZfEcWwUMIICkve9gy5pedAYyFZoopJv2cm0F3wbYog7WWoK5L?=
 =?us-ascii?Q?G9z/AkR6YZ7MywYtxaQruX47tjsKfsMWGJIqJ2nGy39UfCzdJ/l7zSiTNQLR?=
 =?us-ascii?Q?LJ16dSyq4DIjSVQBvUS9ONxpL/fZNE6mB/F3zrVlUUZdrSiDyD4Q/0IktWsW?=
 =?us-ascii?Q?NooHFmw19E9YSNRLsTdL5CeUGyOOTinNSgm8woa2FeHuq5zareYHngWLSztY?=
 =?us-ascii?Q?XdjM76ahLYRaIrnKPOQLjyr6unYglItHgNpRTXNyTHycNdX7RX0jf1aYNDCn?=
 =?us-ascii?Q?CWP1l/PyLAsUcN9BTAFHhxu9oCRCMIJv9a7d3m5I2qX3mgG+N/m3NMDN6zT/?=
 =?us-ascii?Q?PHsg3y6GYC+RDDI0n5vU5Mp/wHcFzULH/NyR8mrVaR9HmBbic10Hs+coB7qa?=
 =?us-ascii?Q?+HSCTgZqC8aoJ7fGmCii0/7vP20ysqExifsjZRU3abN+vNu6AX2sZUtpoIsn?=
 =?us-ascii?Q?glZJnz498VEyiYAmEixXHlZkRHKkIQmkjBt1WL6WTe7ro5AZpAbydvmINtRJ?=
 =?us-ascii?Q?QenldewzaYyF5ZZrKYJkXqy96UrSRJJxy7lxPf8pqyae9tO1hF8XMtVDF0WP?=
 =?us-ascii?Q?uOhAmtfzH3rxK+Zu4I3KpFBClvwHelcB4wBrVVtU8Xe7KfNdwOAh/kmFDOqn?=
 =?us-ascii?Q?p65mwL8Xmdteg4KNjagOcP0bafRFp2J2Cjl+0BhBgWt7Hkq0CEyOKdAtmsTu?=
 =?us-ascii?Q?v2e2pU/FswvzAsrypJoiEPjNfrRHsMy1gcSd3FbnZel9M+JwFKx5SXS2Njo2?=
 =?us-ascii?Q?Q3XKx+yWKS2NLtvOJQCqj3Z0GJRxng6EZ4JZuj/0P3Svf+lN5AAGNt9hEAmM?=
 =?us-ascii?Q?ZcX8nd26dP3pLTlB5fS1tD+GB+WRAyh205uBuFQ1tqKWfD5kAvDq5Kj/Aox4?=
 =?us-ascii?Q?CGyUTv8soTCnxbRDQ3O5cblAFnzOiFMGGKG6IdmWDea2gY0jKtTd+DxsEgvZ?=
 =?us-ascii?Q?uAGUAq63SErhDYpI1/9FymTsv6e5L7FHTK3a7BjOQlYFshsVyMyS2JoVcT/S?=
 =?us-ascii?Q?JZh2YYuDRJK0d05EDmy3ovc/GtSYGnlw10OERJLr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fb31e4-c398-4210-19cc-08dbf4e716e5
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:35:56.3312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CS0y43M3tiTgJguhah4Q+3NrGF7HgCUkk8E3UdnxYHm5ZZCD/5D4ySvCIy+Z6wbVq9t3G+2vlPhMbEAUKHVMpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8356

There is no point in updating the MAC address of a switch interface each
time the link state changes, this only needs to happen in case the
endpoint changes (the switch interface is [dis]connected from/to a MAC).

Just move the call to dpaa2_switch_port_set_mac_addr() under
DPSW_IRQ_EVENT_ENDPOINT_CHANGED.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 97d3151076d5..08a4d64c1c7d 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1523,12 +1523,11 @@ static irqreturn_t dpaa2_switch_irq0_handler_thread(int irq_num, void *arg)
 	if_id = (status & 0xFFFF0000) >> 16;
 	port_priv = ethsw->ports[if_id];
 
-	if (status & DPSW_IRQ_EVENT_LINK_CHANGED) {
+	if (status & DPSW_IRQ_EVENT_LINK_CHANGED)
 		dpaa2_switch_port_link_state_update(port_priv->netdev);
-		dpaa2_switch_port_set_mac_addr(port_priv);
-	}
 
 	if (status & DPSW_IRQ_EVENT_ENDPOINT_CHANGED) {
+		dpaa2_switch_port_set_mac_addr(port_priv);
 		/* We can avoid locking because the "endpoint changed" IRQ
 		 * handler is the only one who changes priv->mac at runtime,
 		 * so we are not racing with anyone.
-- 
2.25.1


