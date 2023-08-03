Return-Path: <netdev+bounces-24072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B310376EAF3
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60631C2156C
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9411F941;
	Thu,  3 Aug 2023 13:43:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A611F195
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:43:08 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9897B171B
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 06:43:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGctJ+v4qlIbKo2SpwtkN1K7m2cX9Iep0MASIPJu7en6+OyT5EYMNg7sAZekg5/xgqcAm/pcixmfYuM6rx/mRJwpH1rqIMDd2FvMP0Ongim2lboTHrUzTGlQ4zK8VZcB/0IDPIQ+H++r8xaJkOQXKX4Wr9YhLoN5jxRYICNy0AmagmVI97KgL4r9z5GGYry+Pwe/MEhcSkhrQgvMoVRdGQo1FK98v08+3/4LpABBI8bBNAOMABZl0idv3R58yxpWZT3pHl1DvNP7rofM+dywLzaIAZO/PclesnazkNXwqdEpXPMgQ/0cO11dRx6TpBHZx3+7XDkqBSA1QfOn24aCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGNvkO15Pkamob9y/ErF64jHXsZge5yXc+uWiZ1ST1o=;
 b=IqNWNi9lDbxfEXFxx199j+G9kgxsFRso8g1dBpkteaus9bFESp7wnXUC1YV3+k7lrIYwgzs5bOIBiwGEl7SeS2UKmk/VjCiZ8dvPDVb+MeqDWSEFFfMh+JC6MVKvzqthEwD9C7mNqLNDuju3GceF3oeqSb2AFUOqZmOeGE6uRrqSNPlhSv9ktBpAZ1Gj2AeyQjZPoVeE3vuPsy4BJP82xxQqg29ff4WaKdt04of+upBRsNb7OTDVq/HKquORXs7NSsirU7DIXVBZHKsfWHLsISCPAYg1Eead5T+FkCkEP3ZkqDIvJpmyCn013DPlU8rYDfFt+Q7lWRd177eMhwqD0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGNvkO15Pkamob9y/ErF64jHXsZge5yXc+uWiZ1ST1o=;
 b=eEN73Q9N3SvLC86aqNsz8j8zSxi3UzeqkNIqWXcPflERqO1Wfjo1VxhBV3j7qhm8l8yLy4b6dYvnU5fz+T9fr/ayJss2hBVRnNZSpbVzaKAPcpu4qE1rMUvCxuuXPS4bdIcG7NDYokIbMZMWDJKlTtu8PUfvWA/V/RugP9BCgYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAWPR04MB9813.eurprd04.prod.outlook.com (2603:10a6:102:391::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 13:43:05 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 13:43:05 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Colin Foster <colin.foster@in-advantage.com>
Subject: [PATCH net] net: dsa: ocelot: call dsa_tag_8021q_unregister() under rtnl_lock() on driver remove
Date: Thu,  3 Aug 2023 16:42:53 +0300
Message-Id: <20230803134253.2711124-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::17) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAWPR04MB9813:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb1a34b-13f8-4517-a634-08db94279053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OgW7g7MgD01BpXVFXcLG/BN3lLa7us8oc8N394SXJd1CPUE5K0wuiLZQy2wOoLhltk3zTozJ/qxkREOKzRFxd9JZAW00ud6qfgL0rVnY3CmeTUUpQFGk5a7lsUu4Jt/UWNL15xvXYvmEmg19APrYnd8nPrTjh+DcN6Rn9XMX/AxfRnp+vFLNH19OQaET5uWta1DkDA7wR8tFzSNZJdwOHqaSDqiToQzsuDz8yr0hG5KXrAB0vq4H0qRPPecmFbOevCp6yMzl+ck0w1E30iJmBESNKAtdzL+lktVhJ8gE7Z59UGyMxzfpVqV4EWbADIWyq8QUx5BKJVCwxUhGuY572n92C64K0AjcNpuzpV+MOpX5N0ZzMuwSRvyJpRzievviDOdpr8YPejwYCBaBFt6AIYHmLmfKpazXxIoUYa9xF+YosCikuamwu4hOP1MEHN6MSdG9g8wCdEwiCl9k7wBEP9984j9gEiIV7qTIcErCZv+qEIPdUt6f8fcMLZbruZfTjdFf8NV6gG54iYRWXOrRbnoxmbKYa9FJBKCwdSXW9MlUhN57PBws4dtm0p4u/l4ubM8zRXlk2u/x4DxhaKW/7JGNWHDQ9QtPyEXTq0146Kk6jgMe0vqLWQ0YVu+/WEX+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(41300700001)(8936002)(8676002)(83380400001)(186003)(6506007)(1076003)(26005)(86362001)(2616005)(38350700002)(38100700002)(316002)(45080400002)(6486002)(6666004)(478600001)(52116002)(6512007)(54906003)(36756003)(66556008)(66476007)(6916009)(4326008)(66946007)(2906002)(5660300002)(44832011)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gp4hRWNpn6ki705053h/4bDK9Xsn/Gr6w/rlyZHErrr3kDSp5NIeQqyaqr0j?=
 =?us-ascii?Q?fJDVGtYpH+OIXDc7PB+FKLkMn6lh9Evvi0pn7HzhrNogBdFjtLDBb8A8svbs?=
 =?us-ascii?Q?/nKLac9rcYvHhzbx1W6ES+Q2qTuznSU7QC1yI1CEoWnta9RKq/kAWmzWYaKn?=
 =?us-ascii?Q?a3zdBtOc3SP4h+GK/N0NbH7gkD854Xw3D4WJiFx7dbKDWZD/2uvu1LBUuba3?=
 =?us-ascii?Q?mkCU8zYfnDM352DrDiw6L0x4blJ/F9BHlEK8anHQPID7CyjzAsvlHzVMPFo0?=
 =?us-ascii?Q?kcUNbQORVbqxwCVcUXfqSJP+VEftxqkf0oYHbMll72AfMYGCo5RQnxOsrAn7?=
 =?us-ascii?Q?bomr3GWXRZMavkhtRC0Ne0bINo4SQ891NrBRie1NqeiyqEPaISv1jcFVIuyB?=
 =?us-ascii?Q?yJ6IYc30baZ2qWFCO9j/ZIzQcS5rKaPQtqXqPdiR34r87rN0pfA1WySEniaq?=
 =?us-ascii?Q?8qBzSFH4Gp6aZ9L6yHb3Szztqi9rLQ1h8kxNo3xmiIj0bYg1uQPV3+aj6RKt?=
 =?us-ascii?Q?gq26zBMuMC2J4Q6I1AKM/2/faD8/immiXRJWz2VsviQC2vZMWhy/wkhCrdYo?=
 =?us-ascii?Q?5yeFUtHB1tfbsLwFQTGh7ZCJiZxr/5Ja5AAHqgweEawCYL3+q5QIi+z8VnyD?=
 =?us-ascii?Q?1VcpKw8QpEnXIAyWvl6Fbf0g/Fk9agUzQzFyDrg2lxq8j5H4p4ofYs1x7t9I?=
 =?us-ascii?Q?3OUboNSIWyAPgnW9tX9CznzDjuRHmS19XK+CZ1D/q+d215m4SrqvKHWMqHja?=
 =?us-ascii?Q?kDfvziJ6RPf7Wm6GEfK9mODr812KLwgTyiiuqrt1yIyrbwq0HcIm5FWTMa33?=
 =?us-ascii?Q?dZWXcqF4VEffuFwQ068auo0/hWXQz+gxv7qFmIVppftF6YaoFqHAI78X1t28?=
 =?us-ascii?Q?wvzN2DvRNV6oEoO9GeEA1j7ZIXPMqjYsHXW5UZczujPU+X/lke7NIKcSSlw1?=
 =?us-ascii?Q?63tsEZpZnU1MJcI2/QOOLpHPHPhpSj1nljr2VQsFBn5bGQ25buYvHAVv7zNu?=
 =?us-ascii?Q?Hz9yxFQy1P+pQsEfh2t94sUGmpW5vxfS/ygxSjKB5TRO+blIbuKp9qUskqoM?=
 =?us-ascii?Q?NLQElFPrdH6IYO2a3K4LqoRy56efnih3tU4WrKvgs3Hb0S72s+FwOC+7ifQG?=
 =?us-ascii?Q?QmIbhsZitvhARpy2/XzukOoCNqkTcSgEbrmZ13IeP47tBePgc4+zeVupREAO?=
 =?us-ascii?Q?2E9cYGFseOQqVi9ybBmVuYAGLgOjQj6rDh0jZq4l7AsIRaZaazRGQ4nZXeCz?=
 =?us-ascii?Q?aqMd5M/bI97pQx9kmY4bRX0/ZoMyWSCfr9/FbdK75jhx3/7Xplgb7BzlRaeJ?=
 =?us-ascii?Q?GT3JVo1zL66McOaBx/xO0GBQQMquedeqtteuLqksNkj20mBe0rDSgBX+FB/v?=
 =?us-ascii?Q?mp9dT+WuKradtkQeFPEmwWqVu2t7zsKIzcocToy2/GMkN+r0x0F56Y587AHw?=
 =?us-ascii?Q?Am3Yd+bysm82lnQFlu+7G8m+MatDxomqmxc5bRMUiMo6scRElThWw0lX40/U?=
 =?us-ascii?Q?nHa1oWqtJYFuFjst9msYbT/fxdg4+rtMsPyUP1+W2krY7Shi/wFhgVJVqazg?=
 =?us-ascii?Q?H+NEx6N7EJQnUAzRKnHxf/lDDrQbiwszOxPPVld7rSINzXHBF7Lx0G1ppJU2?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb1a34b-13f8-4517-a634-08db94279053
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 13:43:05.0965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpZatb8pulPlmzH/aDe/FYEJxagRNOes3RpHXOb5Ct4lCv71y38d1O7il6m+9YDIVrPxVehJnEIQmksXyok97Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9813
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When the tagging protocol in current use is "ocelot-8021q" and we unbind
the driver, we see this splat:

$ echo '0000:00:00.2' > /sys/bus/pci/drivers/fsl_enetc/unbind
mscc_felix 0000:00:00.5 swp0: left promiscuous mode
sja1105 spi2.0: Link is Down
DSA: tree 1 torn down
mscc_felix 0000:00:00.5 swp2: left promiscuous mode
sja1105 spi2.2: Link is Down
DSA: tree 3 torn down
fsl_enetc 0000:00:00.2 eno2: left promiscuous mode
mscc_felix 0000:00:00.5: Link is Down
------------[ cut here ]------------
RTNL: assertion failed at net/dsa/tag_8021q.c (409)
WARNING: CPU: 1 PID: 329 at net/dsa/tag_8021q.c:409 dsa_tag_8021q_unregister+0x12c/0x1a0
Modules linked in:
CPU: 1 PID: 329 Comm: bash Not tainted 6.5.0-rc3+ #771
pc : dsa_tag_8021q_unregister+0x12c/0x1a0
lr : dsa_tag_8021q_unregister+0x12c/0x1a0
Call trace:
 dsa_tag_8021q_unregister+0x12c/0x1a0
 felix_tag_8021q_teardown+0x130/0x150
 felix_teardown+0x3c/0xd8
 dsa_tree_teardown_switches+0xbc/0xe0
 dsa_unregister_switch+0x168/0x260
 felix_pci_remove+0x30/0x60
 pci_device_remove+0x4c/0x100
 device_release_driver_internal+0x188/0x288
 device_links_unbind_consumers+0xfc/0x138
 device_release_driver_internal+0xe0/0x288
 device_driver_detach+0x24/0x38
 unbind_store+0xd8/0x108
 drv_attr_store+0x30/0x50
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
RTNL: assertion failed at net/8021q/vlan_core.c (376)
WARNING: CPU: 1 PID: 329 at net/8021q/vlan_core.c:376 vlan_vid_del+0x1b8/0x1f0
CPU: 1 PID: 329 Comm: bash Tainted: G        W          6.5.0-rc3+ #771
pc : vlan_vid_del+0x1b8/0x1f0
lr : vlan_vid_del+0x1b8/0x1f0
 dsa_tag_8021q_unregister+0x8c/0x1a0
 felix_tag_8021q_teardown+0x130/0x150
 felix_teardown+0x3c/0xd8
 dsa_tree_teardown_switches+0xbc/0xe0
 dsa_unregister_switch+0x168/0x260
 felix_pci_remove+0x30/0x60
 pci_device_remove+0x4c/0x100
 device_release_driver_internal+0x188/0x288
 device_links_unbind_consumers+0xfc/0x138
 device_release_driver_internal+0xe0/0x288
 device_driver_detach+0x24/0x38
 unbind_store+0xd8/0x108
 drv_attr_store+0x30/0x50
DSA: tree 0 torn down

This was somewhat not so easy to spot, because "ocelot-8021q" is not the
default tagging protocol, and thus, not everyone who tests the unbinding
path may have switched to it beforehand. The default
felix_tag_npi_teardown() does not require rtnl_lock() to be held.

Fixes: 7c83a7c539ab ("net: dsa: add a second tagger for Ocelot switches based on tag_8021q")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index fd7eb4a52918..9a3e5ec16972 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1619,8 +1619,10 @@ static void felix_teardown(struct dsa_switch *ds)
 	struct felix *felix = ocelot_to_felix(ocelot);
 	struct dsa_port *dp;
 
+	rtnl_lock();
 	if (felix->tag_proto_ops)
 		felix->tag_proto_ops->teardown(ds);
+	rtnl_unlock();
 
 	dsa_switch_for_each_available_port(dp, ds)
 		ocelot_deinit_port(ocelot, dp->index);
-- 
2.34.1


