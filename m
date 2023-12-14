Return-Path: <netdev+bounces-57133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1898123B7
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1628728267F
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347F737E;
	Thu, 14 Dec 2023 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cU/jUGvY"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1B985
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 16:09:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flr3GtGgo5jXUGmxtOmUSuzBfxjAh+XqPab5bZZrM4jWhks59CNhrw4WBUzLNN8hXrscLJLVnNFth7vPUWyp55g7kgnUqYix5vbLgyBd+9c+hUeUJ8g6s3xblT0RGArW44D/WO21tuwXBE/N7NOLAW6XrdAyUkJFm9od7PZgY9a6SA0xeRYBRUK+X+g/0d6IZmxcOHtWUmkwy86HpKhle2sktsgD++86XEg3uSAY/X+Pf7SteR9apwsGqwhiklNLIp0ZXuMRAjKXTuJVgKKvWP7aSDiDMjt+rKtdh6vwN2sU+YLXIRlNP7hFBazNChcqz3VfP68QY3zmL3mXBjK/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPNaKI1iLaGBP+ogX5L1GcnJkb9nfi99C1f5jXkLVm4=;
 b=kz6h82wYZ2NPhCnT1bDo3eqFMcCuW4pRy5kN26HrrNu1wkD2bEpB1T/cS7HFRQiJSAOnBnzII/U+oNYavBlUdNakHoTOEkOHb66BTUEKKeRz/vIeYvXhTpQ7K9eetNZlFKyfXbmZhu7TqRNbqGRzfmNCPsd5SN4izYM5dB5iJfUfQh/Zocep4kefY8CL3wvvE2DExi9BTYikXUs6grk95zem+1Iggl4SBN1QpC418pVmmfuy+zWHtHwXDVlaHty+0m8N8o0XtdO8bmBkRUHgLRbgVmFuIilA4feSfpQZwPKFsvO0HR/F5GB+pCmuJ43+9J8DaeaKyXvzACx13RBCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPNaKI1iLaGBP+ogX5L1GcnJkb9nfi99C1f5jXkLVm4=;
 b=cU/jUGvYLn9eIQDhjKNEQd+NA2xiHPSknLpBwbQMVlyv0RE8naRTUr5Ix1v/OG5JKLqrmUJPGKZvi6ZICZtsKM3uDd9lS/jrHJ1fVuM/uauwXPrdLssNtPG7BMketi7b6EpJG6vwK8CGqvmrM1NLd4zT+xycksKTzTtmNYk9XXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB8169.eurprd04.prod.outlook.com (2603:10a6:10:25d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 00:09:35 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 00:09:35 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net 1/2] net: mscc: ocelot: fix eMAC TX RMON stats for bucket 256-511 and above
Date: Thu, 14 Dec 2023 02:09:01 +0200
Message-Id: <20231214000902.545625-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0135.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::28) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ece0a8c-1d4d-400f-d5a8-08dbfc38f418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sel6OBx7VxNpgyE4O+lFoymgvYwkRkyb7qwl3oYvN5SciJdBsHbWnNkjy9l8iZ8i/UszIoxclnpFEAhQemo8HJwJUWDbTc2qKCyGLcmj9Fe4x0f8FV5q5ozX8OF7G6HJ+0cXKHlE+h+Vg6DCbPQyii71+3pqnQvBarw9j5RDOqovD1HirhvH85ynY7rB+AmRO3VjdyHH9L894ZYovfXjPWMp0fw1tCIXOrg0ge9Hjk3XU3s3IGPq/wtdq+7fmwn55dI8WQkemOGvwNGXd5V/QE4N46KaHHqFb4v2SV9QKQXDMWkbdkvC7J2MyuIj+okKNcfZ0W966Zd7GlyNZOH9MkUiUnYI8j96oEsOzxhLzPH7ivxQ1uA6kbXrwJTSg30N82u7tJznbwHAVNXchNMXSVM564UDkLsgnR1+8KtQJKvqa5Hl1NZjEKOQtSNdco+LieL6F0uViFccdWTSVel7bj8U0t68PLwERJb8Uwwcdc7KaMI6lQdge7xVeFwRBt/Drs2QUINjA6hy3eeNymwPXKjUocw1H4C5t2U+MDNQk4+UfF1Gd9tC7ulb+vQJKCdtPvwN64poJBX8NGZmz/+YD5fhEkLGRt2FgYEetNWngF8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(2616005)(6512007)(1076003)(26005)(38100700002)(8676002)(8936002)(4326008)(316002)(2906002)(44832011)(5660300002)(966005)(6486002)(478600001)(41300700001)(6506007)(6666004)(52116002)(6916009)(54906003)(66476007)(66946007)(66556008)(38350700005)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DSo1y+G39wSkeXz9fpjzuRUoFm3ffX+hENWO9uNpNuAyLf2R/STe0XIkSble?=
 =?us-ascii?Q?AT4vWXkhHcZ1UY7GKpryjliK3kSXWfNxGMa2ChkP1BEApMyu2AWvMvAsESef?=
 =?us-ascii?Q?/KZxIEaL5GjCLErU7EHpLVdYwhgfYhdmmTG2LYZ/JEaDfeQwXSK55JHLIyVB?=
 =?us-ascii?Q?QWGEY6U60mHy18hKuHbg+EBYNP23R99bNjm0UiPXuK4ytpKU8p1RpqmfNBnT?=
 =?us-ascii?Q?mAXotg4PCgVFk3D/OXffvWLnN42Lp5VABw+e7Up5MDtq/8+fGkjB9A/Y6rqc?=
 =?us-ascii?Q?as0DqAVy6OIAA38TXh09GWVoSQXkXgPBZ2ZBu/aY7/HH9VrQbqE4IiX2mKQZ?=
 =?us-ascii?Q?1y1VeLcFBBI4lgPNfErbgLdIsN1JGDIf8NIEPWO4pe5l0QxovUzQkkOrmgzb?=
 =?us-ascii?Q?cI536UExvkShqhGWMF/32Vq2tadZGwIyqv8iKLmG2M5zJVYurIfz9CoICJIa?=
 =?us-ascii?Q?eS3RIU8YULkmIL1I4u+x/N0ndkSupBFrj7U9P8dDGDcVgeyWjd37jQ52WStf?=
 =?us-ascii?Q?5ETWvBfKBXJGRc9y/cOebyDz1oXtQqQ+QzNDl0xIE520oo2qsgdeLFNzmLkE?=
 =?us-ascii?Q?DTqRAbZSfziVvzmhUDuOwibIdIRTAs0qdhWgity9T3vjyooCqqmyZVM9rzgF?=
 =?us-ascii?Q?U0IrXWTkVhHXySowYccikfES+Ka4BFLtRg/UjiwmvZyrWyF7G6tyiaMWOGYQ?=
 =?us-ascii?Q?hA6DYhsMHJtHCKNsqDFD1wiIF31lXNgSTqX31u5ww7cHQqOkNu5Azf/DlGfe?=
 =?us-ascii?Q?SwBs5Uirid8GVywaZSmLnhpvJuPJ3b4SXqbRLuoSbVZ3pxn7gq9464PC0APQ?=
 =?us-ascii?Q?ARBohrRRNnytd8nWBhxmLPUWoiKNQovI7SxlYFr7CxikBaiFq7DFMojAHMV8?=
 =?us-ascii?Q?HIyv2qcIAyf6luwz8JnpFfcHhl1qMfrAuz7MZZSVDd1sce38y/4jKALk/xtz?=
 =?us-ascii?Q?PfFmgHGhH5RkjHtrfJ0irRZd2gLk8/CeHRmzDP+Xx4XmoMWt74O9r11J6kP7?=
 =?us-ascii?Q?kvIVlpnWK2+qAdjpLANwKJMcLUcJCsGaaqlZykzzJl0qtCDWsGFPNb2DLaCi?=
 =?us-ascii?Q?EdHdXDbb+nEo+hWEd50jK2V8C0iKc/jTHbGD4NRpkH1mz2ijc/d+IE+lF35L?=
 =?us-ascii?Q?avoCfgNPGpcIuwVnUr0yDwAwRyN126ftyhIdDsmQRJ6sLBRI1r4eZVZoV2Qi?=
 =?us-ascii?Q?JTnLwaz0J6nBlX129VmjPz+XmdPb+YFRXt1R4afNl4pmt8L/du3Jtb2wkSQm?=
 =?us-ascii?Q?JW+gmUo8PGdrA0uJY7MwF61ArUgwJ6E38RJELu0oARhbDRVunSLfopbi7Wkg?=
 =?us-ascii?Q?Blu1M4DGKraF/+4nMxm0To9XfRrBp5EC4BRGY+coUNlw3t7LCsBdDGjYq3tH?=
 =?us-ascii?Q?SErZ2v6lFYxPcWrifbwmhP2IrZk6RYARagOywthhLezojC/ngoPQMFs3tkCk?=
 =?us-ascii?Q?P0AnUXaeQI0GgcNjpZs7kfviMUTydfT9P3hnQrr9k61imrg3jn2rzZj3Aw8R?=
 =?us-ascii?Q?U5bu+Ce843VCzkKxFe90cpUQvyTMucdje4xijuFX3QqC3DmXyYtYKaEKWTaf?=
 =?us-ascii?Q?/5+5pi9jt7fyJRbqOaMAJVjyRPKGNUqVtwPgLXV2L39YpJQx/rqNHyjXYpBH?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ece0a8c-1d4d-400f-d5a8-08dbfc38f418
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 00:09:34.9600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiCqDzjs+UovBQXKQ5/aYFl6zKElxfJ6pCBPwDJWclADI3aikszrIQ0RkFFqolkWJHU4VbBRaN+3/ZLHB6reCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8169

There is a typo in the driver due to which we report incorrect TX RMON
counters for the 256-511 octet bucket and all the other buckets larger
than that.

Bug found with the selftest at
https://patchwork.kernel.org/project/netdevbpf/patch/20231211223346.2497157-9-tobias@waldekranz.com/

Fixes: e32036e1ae7b ("net: mscc: ocelot: add support for all sorts of standardized counters present in DSA")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot_stats.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_stats.c b/drivers/net/ethernet/mscc/ocelot_stats.c
index 5c55197c7327..f29fa37263da 100644
--- a/drivers/net/ethernet/mscc/ocelot_stats.c
+++ b/drivers/net/ethernet/mscc/ocelot_stats.c
@@ -582,10 +582,10 @@ static void ocelot_port_rmon_stats_cb(struct ocelot *ocelot, int port, void *pri
 	rmon_stats->hist_tx[0] = s[OCELOT_STAT_TX_64];
 	rmon_stats->hist_tx[1] = s[OCELOT_STAT_TX_65_127];
 	rmon_stats->hist_tx[2] = s[OCELOT_STAT_TX_128_255];
-	rmon_stats->hist_tx[3] = s[OCELOT_STAT_TX_128_255];
-	rmon_stats->hist_tx[4] = s[OCELOT_STAT_TX_256_511];
-	rmon_stats->hist_tx[5] = s[OCELOT_STAT_TX_512_1023];
-	rmon_stats->hist_tx[6] = s[OCELOT_STAT_TX_1024_1526];
+	rmon_stats->hist_tx[3] = s[OCELOT_STAT_TX_256_511];
+	rmon_stats->hist_tx[4] = s[OCELOT_STAT_TX_512_1023];
+	rmon_stats->hist_tx[5] = s[OCELOT_STAT_TX_1024_1526];
+	rmon_stats->hist_tx[6] = s[OCELOT_STAT_TX_1527_MAX];
 }
 
 static void ocelot_port_pmac_rmon_stats_cb(struct ocelot *ocelot, int port,
-- 
2.34.1


