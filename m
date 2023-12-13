Return-Path: <netdev+bounces-56967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 199D9811786
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A7CE285FCB
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFBD3308D;
	Wed, 13 Dec 2023 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X9ahzl4z"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C4C131
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 07:28:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQG4lh1olC4CylL6Z52SiBxPBG8sxt5AthZuqoNynhKO77w32XLFRkYzsA9xnLuZZm6Ys7MgpKu1loaVvEizOG2pkd7LM4C7uys/Fq3pxLne0W+waY2wOaJ+QgT04yG4i1TTccgtzUOIYiIjR9fcQkGlxicmyhicdTYH3Z+DTFxceNzE+QJTLOa6LT/aTV8VfNGP7ZpcSk9WWc7ltc0FXNv5+x/P0uOveE9WpbFkKO28FT7ESyGRwsenjFFMQQVNu9jd1cRIKY2TACQi3HThcgVvjHyPBGwB6HXz1DzVs6hjP75u+x8DuDxH89WJDDPCgfYNF9I5dPKTH3MCn9A3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyJuUbafyMd++tfzLzW7KomKI6jfjxHuz5HIQRtG9z4=;
 b=kN68nVsvYynL/xIA6R6OSlRpKL442NbdEL5rbL5D1X8e+K0x8qx5UqGzsCELh8alVshTL+QtstR3Gg9IswaKhdwFMLr4VYLQhSu6TpNL2mhgD/zyqY30gyz1x6YyVKnrkvX3Vua00xFgQsJ6wBqhhBGULq7mXTydysKQ8qNJPPKPmEVY9L//DXpjeBcxOn9HMpWplbWDCijGu322m2+h8r/xxgcACC/g1lMZvXCmt97B+hoRfeTFqCMZvgxoHB77RM7eNUZWA+HmPAiQTPP1cTrCeBa0+FzVChm5ntVvabxzWn+nMRe9nGX/QrJ490Vue/V5unaXGOoJ5UbfOw1Rsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyJuUbafyMd++tfzLzW7KomKI6jfjxHuz5HIQRtG9z4=;
 b=X9ahzl4zkZyefqrh03XbBg49L47alYzSzVo8/7lanj/bhkB+rHmLuSS1+UizAXI+ew4hTtGF308ArYkuny43oaWCZOASaBJTLMwtDp6XC0l4xqEIKH6+ZhqSSkH0b4QOIA58WCKLuq05xwQu+sE0TRadk4iMevdaz0+PmeiVpb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU0PR04MB9273.eurprd04.prod.outlook.com (2603:10a6:10:354::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 15:27:31 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:27:31 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next 2/2] net: mdio-mux: be compatible with parent buses which only support C45
Date: Wed, 13 Dec 2023 17:27:12 +0200
Message-Id: <20231213152712.320842-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213152712.320842-1-vladimir.oltean@nxp.com>
References: <20231213152712.320842-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0015.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::20) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU0PR04MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: 83fc297d-8b5c-4d4b-7ba4-08dbfbf00603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VS7ydzxE6rg5qizn/tfuGt66VTbSfynpL8GTK3/ONvA32XyGXbCum3G0nKUXcPdiQSDbblOXmwD7WGdkwC5Aok1kQbfMoODxtYDBkHQ280XTzTl5tXv3lfxmagcLren3l+QWw0lWwaU/1UHt1Xru5clFBbnBzTqnf7ZUUd1zGN12ZMGnWFunlMG3SX1Wj+MYYbYPDYFzk1PiVPL2ibOcBSlw7tR1oBeSsgm+aSoCHJpsxv/sNO2SjKUpSO+1z3nOtW/NzR5AvagogUKTjtEHEUUg1vcoEtAvxwCkrN+kMeb0Y6YBsktQvzDsQ1nU9BuwUkv52BRlU/5Nv9hyxGycrVNjV1Gls0JXTYaUo6hHdEXTrmeqwqclkggJXlc7sH03p+APxype7IZevAbzmPqBdYUeRPMOyLiezbPSkU4Kt3MXqNA56Uhg7aNsY/yUPWwLoEM8rYvkPk/ZjcboNs17GwGO8/n35tdknfWlN4kLc2DphOh7EJTvmx+u3BYoJqSnS/mpq/TrPO48GDRJETXhygBVEgFtoPJZ4isfofiZd9dDQP9c9+BxxfrmhTqWS4OjcNRwSBoL0CBIuQPqRRrf3tS1GdwJ0DEGdVzSartgz9Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(5660300002)(2906002)(44832011)(8936002)(4326008)(8676002)(38350700005)(36756003)(41300700001)(86362001)(1076003)(26005)(2616005)(38100700002)(83380400001)(316002)(66946007)(66476007)(66556008)(6916009)(54906003)(6506007)(52116002)(6512007)(478600001)(6486002)(966005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6RJUZ+O5j+aLbS+BE4NxCxaB0URxN3uI8TVAXppwobt/mYy3ArfHESOm2Evv?=
 =?us-ascii?Q?Emwl+Lz+TVA0ucFf3/6fd05g1obdl7m3rxBkC138lhDEsKig1P/xJYb7x3i9?=
 =?us-ascii?Q?q/+2Ylpk9LFv8muo4AoYRg9l/E/7vENkPoRyqr5ktCuzidL2xQZTQm09V2bz?=
 =?us-ascii?Q?DMulIoQXsXjwvEkgX9ZVW+o5rAxl0XbAtdPtNxBPc4zUxhuGBYXh+0XlSrkT?=
 =?us-ascii?Q?1ADfh733hgYTiuD2iXizg6KSSt+CECxZvrqqSqKK0weBe1l169GnWHs1G9cz?=
 =?us-ascii?Q?jlHhmDzLI4cOAXzOWqlMHYrUsPr4F1CGDXkhhO3fni9l/MSBlS2QQ4cWZ7gz?=
 =?us-ascii?Q?ycJNNo9bk0xCFyW+LlA+YFiMh9f/MGSV7k0XJFmnSK8LgYHTFCOtaH8Aa261?=
 =?us-ascii?Q?3yfIde8Nt89DRRPXiOskpekMYWXNcO+W1Mbhjs9z4LVQ2uFPiBiKFSKKqK3A?=
 =?us-ascii?Q?Bhq28uS9ZkoagsrJE3/SLDVNIH+v4Cs0yoOLbYQxwGq3JfBn3M3j2SouCAdN?=
 =?us-ascii?Q?ycmAwDEg2d8qpNGXb/m8aH0O8Op7NpvdKcJa3kWrjrfpdmcoUWOAVZOd0I6R?=
 =?us-ascii?Q?fAKDMUHMA6/FG7CYsT0EwDIrTkHDiZZTWqzpICc4P40gcIr9F6WWlAiFllgG?=
 =?us-ascii?Q?6812rY0YVCNlGY33B3HMRrUwPmrA9IGvfFwPdqkknhz+Mnye1DnjvaasmMNS?=
 =?us-ascii?Q?WME9EGyINVZsF7RZbPKFt2xeKSIqNgG9/zf33FT5mLKop4bW2F8PYB92K17X?=
 =?us-ascii?Q?IQc5YExv9IOMtgPRO/Fl4kWKd00n3JX+qham9zDAeiyHYjfAslAXyGRKkcKA?=
 =?us-ascii?Q?e1pbG3VJZTYmG3uXPSIrQtSJj4SA5MMOleYQNQD2T9nCJ3nOtuBas/vkqiEQ?=
 =?us-ascii?Q?6yNbLKXfKmeesOGSYNv9nDhjmuDhrsVY9vpHZIBEQ0q0AEu6jcicOh7V8BaW?=
 =?us-ascii?Q?1hBs8Zuef6GiPOhdZHtECVxARQK8kEm4eMM/WCeyrdtiGqGRUOeIBkMCS+Bx?=
 =?us-ascii?Q?qNcVeDeSHhHcGWWgX13SyiumYBjXWANJcQ4nNK2ii/l/PFIfZ73cwX7AiUrX?=
 =?us-ascii?Q?EyH3TaPaIHtQOQuaqYzgFoBMjDibe4WlQlL9zmKh7LYTBs6WoxMn7oW1NOcG?=
 =?us-ascii?Q?MsSvOavNC/hlPFt82kTYTqHax1nn/hhHChQDtFOhOrX6HY+4ZKpNaKYxIA/+?=
 =?us-ascii?Q?gBTVdS+6jv42Yheqkd6b1i8ajEUz0f3UDksfjnnNZ3RqMceJ74JILUzygTaA?=
 =?us-ascii?Q?m+7PTUz99kd8cB/OoXBnY5iw8WAAQGg/NyYuNjhbrPCwboLd3oJ5Kg0iEWfG?=
 =?us-ascii?Q?ALd/3lc0n28a9fc2q/KJLmeLsdTmphzlKfZeHJVlkK8igICP0gMXdU7gRF+P?=
 =?us-ascii?Q?Y0cgZrOxXMVmaw5MnuO1YmIpfJeclR62GbcsgrjA7YQrVQBRMZrznS+ClDJQ?=
 =?us-ascii?Q?kb/XwAMb0f+gEHocKcOCbomtJnYNDGHWxhqUEbi9WaRC4lFzh7GFwLlU8871?=
 =?us-ascii?Q?m7FL51F+rkGB4eQBsvGI4o5aLmcOMQbiTzdWczgPckH8h28HZFKZ11W+gtKr?=
 =?us-ascii?Q?UdccG9cmc4om/Ll45zcvQXlJXoCBstK6JPfHffdUNMhQe9EdQeTMXgz2/K6P?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fc297d-8b5c-4d4b-7ba4-08dbfbf00603
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:27:31.6540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4MIXxGfOA721vGjHfVY+bXn/sUPI1mwR2lrwYxDpmmVq0jcuDxf0KhxKc9ZZW0hm3KnT0ykIaBC9BfWiZEdvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9273

After the mii_bus API conversion to a split read() / read_c45(), there
might be MDIO parent buses which only populate the read_c45() and
write_c45() function pointers but not the C22 variants.

We haven't seen these in the wild paired with MDIO multiplexers, but
Andrew points out we should treat the corner case.

Link: https://lore.kernel.org/netdev/4ccd7dc9-b611-48aa-865f-68d3a1327ce8@lunn.ch/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/mdio/mdio-mux.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux.c b/drivers/net/mdio/mdio-mux.c
index e5dee7ad7c09..fe0e46bd7964 100644
--- a/drivers/net/mdio/mdio-mux.c
+++ b/drivers/net/mdio/mdio-mux.c
@@ -214,8 +214,10 @@ int mdio_mux_init(struct device *dev,
 		snprintf(cb->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x.%x",
 			 cb->mii_bus->name, pb->parent_id, v);
 		cb->mii_bus->parent = dev;
-		cb->mii_bus->read = mdio_mux_read;
-		cb->mii_bus->write = mdio_mux_write;
+		if (parent_bus->read)
+			cb->mii_bus->read = mdio_mux_read;
+		if (parent_bus->write)
+			cb->mii_bus->write = mdio_mux_write;
 		if (parent_bus->read_c45)
 			cb->mii_bus->read_c45 = mdio_mux_read_c45;
 		if (parent_bus->write_c45)
-- 
2.34.1


