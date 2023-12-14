Return-Path: <netdev+bounces-57134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A638123B8
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E885D1F21853
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85A518A;
	Thu, 14 Dec 2023 00:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bC+UwS7z"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F392C9
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 16:09:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJe0ghVN9a4NyVLd+g0TzO1ArPkY0yAEOiqRyLnG9hmheuEnZVWd5lscBd0tFzDWEzlbv13lWa7ldr2KSJ27+p9cb6egPWn3wCBoAM1awl7QWogTscEsWyFMe/QuMSOrig4/xm2/5aOmGtnWfXUjQs4YzFPcNZVu+UwTorEm/zWBm4gjXdHO4GkmGO+4aLGoTOqJhpmle3hTONIM03oihw0vkLIXqHyAKw3zcrypLXJSdeuEvBCrwE/5nZAsx/Cw9MLRCBEltA+LLCiGfabN7zYOPQfWR9EtoWuXY8QIghJPpWg692Ddg0s3ocIHUmluOzOO0jx2bQKTUg/kVBSm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoEThFXlLX3HzWVvNO7YKv5/Q90o0N0Kk0CUhC+DbdU=;
 b=R6/wXiVgbMyVKY11EILg2+8v9VanEYw4c0fSrMvph/rTu7wXfBB5UoJ0/7xeBhqQAc1MHnMLZ3rvw5wIx6OQrmsnROPehaWNNZwmSnWcKvIF9Q8e2kGoKPexqcSj+ezEIZZdBDcIKZG15hdwmHk3kS3IKhCt2PNGk225x5Ak4sA6RlZHnJQh5vfRVDW5K827liNIvsaAm+Rle0Bb1QCBXexyP6uKacz9h/6U76QQ1hTgS//cGpK4xyfMyrH8fdzgEvr92/gaS1P49UqisrGFkto3GWgqlxHmdm1mO4H4sCl8pq75XiwsaXvbmMWO545HMxJILxTt+LwxVZEgAhbGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoEThFXlLX3HzWVvNO7YKv5/Q90o0N0Kk0CUhC+DbdU=;
 b=bC+UwS7z0G7fYLaqmvS79vSwNro2KcJQbBuU3KeNUwfdS/JS+jV+f+7IcmSMjkVRvAkZgh4e4ruOAkfglY66t3TNyFpuGI5OfDC4dFEUo34713FgptINJQmAeW+7h8A2ztPkdkMDpL3vCW979RTgPU3ntkheoH4q7b4KQIKO3bQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB8169.eurprd04.prod.outlook.com (2603:10a6:10:25d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 00:09:36 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 00:09:36 +0000
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
Subject: [PATCH net 2/2] net: mscc: ocelot: fix pMAC TX RMON stats for bucket 256-511 and above
Date: Thu, 14 Dec 2023 02:09:02 +0200
Message-Id: <20231214000902.545625-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214000902.545625-1-vladimir.oltean@nxp.com>
References: <20231214000902.545625-1-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3e4133bb-8e8c-4603-44f1-08dbfc38f4c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m4Eqjay61RO2u0NOShMnBcruym/mHG74svh20CXcPyGbKiQpp3q9tnO2HyzMvi1wYyYhF+8m1eTLArgC1lpW16hTpsG65DTjy7sEJbcYV/KOMf66oYpPFcHgMYwqKdPOCsOXO9JHO5jzNhMZP1lH1u9xyOmRBpc2VdVbIIUZnfp8CLGlqRbYUb70EANQCf+ahc4iPROA/MRa8NMVje8zXKAoEtlYjbdvY9S/WceO20t+/YDE4UnrGgC3ySS4OdzPZQcMothMWG11b8V9LzDKvggIOye9nzSfgjLBFOpqu95oaxlg7zOIBdN4tVSLvtfkFTc42NQ/JsF65ts/DlEaGIg4rLwYmbFAEhQNPpI3Ckdp3gVqLcgc0348AF0lvGFV/Qk1Le8xZbgfzy3MBr++kBYYnwRk1NHDsblswagGjephSKCeMqpsfaYV/YwQETiX2MZtEWOoZwNDEHy1E8DaBe83OdZwHuoKB53VFdPHHDOI4cVjE+D5/sAkiyIWzg7BLzGdmdlEYO3E4D97UTWhFv+bs0a+Ir+CHIY7ud7go1HnMZ6h2CmAvHeH5QNwdPltAwey02MK6TMI5QXXSP4oCGDqUA0zkSifW/G31ED64U73SteXCiHxSnVhKidj08dZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(2616005)(6512007)(1076003)(26005)(38100700002)(8676002)(8936002)(4326008)(316002)(2906002)(44832011)(5660300002)(6486002)(478600001)(41300700001)(6506007)(6666004)(52116002)(6916009)(54906003)(66476007)(66946007)(66556008)(38350700005)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vw8+xCShIxrVPF2CrMxI2F9lE6cZ92uonjG8nQ+788mh7VqFmFdhWLFoUTx4?=
 =?us-ascii?Q?wBKpqQZMxgaTdo8BhgyxoPM5PdLYE0lgHMDZ2B+yLdHh0RoF1arVZVnZ6uml?=
 =?us-ascii?Q?TS3wQswzlXzgEF75Gm4QVKIvuLaoi0Gi9i5wetgiC2SGdpOnUiNkUJtHSWzn?=
 =?us-ascii?Q?Q8sZYUqv9PmKFvE6SBzE1xsz0spVbJ41s57Tp6Fe5kyYXdMyuKx3Z2iZHdW8?=
 =?us-ascii?Q?eOG3hc6Ayo2GmN6eOVg858cPkWSCQ4KG2s7yQ1z9pHe1fIoBpfV42EcdPOQC?=
 =?us-ascii?Q?YwZKGSue1xkMwGDgQPGsblwGxTm6TLDcNoGdEAx7u1Lrpecy6CVAfC5sIHH/?=
 =?us-ascii?Q?6YmnqIkAp2lwS23wM+Y5OVwTe+SR3CZYvBND4+vI8nFdv6nw1wMywV++fF1L?=
 =?us-ascii?Q?iSlFq4UviaHhGnjY376jQCI3mVB2AYcH0FKO1f6uI6Bdrmx6BIkS1+wy9oU3?=
 =?us-ascii?Q?S7vJT40M0lCiuCAryTrLN5DY0f550W6XX3XBVIS3jDXSVHryrM/LSOMBDlqj?=
 =?us-ascii?Q?f8pFafPzfLGwJNBYJi4NRki8tPmb9MeE6NPyNqR9mRsfQcM8I9zItN1JyBhb?=
 =?us-ascii?Q?pY9yoVDhIOCIF+HO82EnlFWF3tN7ynLncw1QToP117nl1WfDPHRavRSMjafR?=
 =?us-ascii?Q?0zNZ8EmIpo5zOjh/Q2fWrPOx1RtEDvjNj7L9/Q6zHoam8hmmVly+AAgk3ehy?=
 =?us-ascii?Q?cmxU2BZCHKJcf68A+W23FYvtaY5gaoG9ikXlWDyshMA54Ttei/h5OfRjWdy0?=
 =?us-ascii?Q?qvJvAS59HGK5Zb5T5BIW4DQUYZ0uE/07iffV0a34y7HUW2SyJXqOPxUMCZ5M?=
 =?us-ascii?Q?HqgZPe7Jdb6+miYU5b1s5OwfOtTT2AgEHkLuIjTbSyR2jQPoGeTed9nfcgpY?=
 =?us-ascii?Q?y1LQGMePchrXYspv8YpOyxOH4v9rTAbLFZsShxwkzn+yqtCkoy+0+afu1zC2?=
 =?us-ascii?Q?VPh9gKhU8Sg2CL/W1QSo3hQtXP186+D5hC/Vxgn1ETfYe9lItIdyRzQDIo2z?=
 =?us-ascii?Q?uUrWzKzEJt7qg6Z9LgIKHC9SlfnKZXZgdASUA1vbvQPUhyPZhILtbkhybYbj?=
 =?us-ascii?Q?B6ShoV3MmTd6im9iTPbJwsELeRNbDcNQvEi3d93IP8YnDs3knxSV9S8qR7cT?=
 =?us-ascii?Q?6mrVRXjSW+4LCNMvFG44QpWtfq4RiAHzA5Ma5NcL46GxBcap5wB4UJ6xmb93?=
 =?us-ascii?Q?sN0+vP1o2TDlczheEZZ/GBWfK/wuyv5tPyz23SdCs+zowg6pv4QrkJj/qxsq?=
 =?us-ascii?Q?l4r5BPGZGVAye6t1jLev+NiVXC1eEx1XqF7Ma44pLrqiQFgaS8VuWo+HrQ45?=
 =?us-ascii?Q?5YPXd+QRm7EARrDqWm1Sbc2SAdwpFmAAt8Bp/kO/4HQpdR5PYM9JfVAkrDVb?=
 =?us-ascii?Q?7qrP88TssZ8ypUXry3+3v0GxkmYfOAe0j0de2lxI4wdHwaqpyBxgmhmAN3w7?=
 =?us-ascii?Q?XcOUVlOIxzehfhIjnJj5dV9jX5es0RGPqH2AgqYH303yNfpZwLKQXQenDqo0?=
 =?us-ascii?Q?J8wgYZDDcaRSyOwkWNEmBuhEVmm1P6nacsU5uFCaEQ5X9yRq58LmG8gEWhRK?=
 =?us-ascii?Q?PDh/l+V7rIiHd2ihf0OJ4Lo5x3pSfiYXOzuLKAIbbx+75ZKP2U+/MvNDnZeS?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4133bb-8e8c-4603-44f1-08dbfc38f4c9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 00:09:36.1319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlkQsw/o6G7PeZgLdhy2UWw4VL9eE6dvxkIANGw8Cx2MoU1UercoBKds8BGveqLkjRUDSiMIq2yWxPmti+Rn/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8169

The typo from ocelot_port_rmon_stats_cb() was also carried over to
ocelot_port_pmac_rmon_stats_cb() as well, leading to incorrect TX RMON
stats for the pMAC too.

Fixes: ab3f97a9610a ("net: mscc: ocelot: export ethtool MAC Merge stats for Felix VSC9959")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot_stats.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_stats.c b/drivers/net/ethernet/mscc/ocelot_stats.c
index f29fa37263da..c018783757fb 100644
--- a/drivers/net/ethernet/mscc/ocelot_stats.c
+++ b/drivers/net/ethernet/mscc/ocelot_stats.c
@@ -610,10 +610,10 @@ static void ocelot_port_pmac_rmon_stats_cb(struct ocelot *ocelot, int port,
 	rmon_stats->hist_tx[0] = s[OCELOT_STAT_TX_PMAC_64];
 	rmon_stats->hist_tx[1] = s[OCELOT_STAT_TX_PMAC_65_127];
 	rmon_stats->hist_tx[2] = s[OCELOT_STAT_TX_PMAC_128_255];
-	rmon_stats->hist_tx[3] = s[OCELOT_STAT_TX_PMAC_128_255];
-	rmon_stats->hist_tx[4] = s[OCELOT_STAT_TX_PMAC_256_511];
-	rmon_stats->hist_tx[5] = s[OCELOT_STAT_TX_PMAC_512_1023];
-	rmon_stats->hist_tx[6] = s[OCELOT_STAT_TX_PMAC_1024_1526];
+	rmon_stats->hist_tx[3] = s[OCELOT_STAT_TX_PMAC_256_511];
+	rmon_stats->hist_tx[4] = s[OCELOT_STAT_TX_PMAC_512_1023];
+	rmon_stats->hist_tx[5] = s[OCELOT_STAT_TX_PMAC_1024_1526];
+	rmon_stats->hist_tx[6] = s[OCELOT_STAT_TX_PMAC_1527_MAX];
 }
 
 void ocelot_port_get_rmon_stats(struct ocelot *ocelot, int port,
-- 
2.34.1


