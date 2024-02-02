Return-Path: <netdev+bounces-68580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0B8847496
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340891F22D57
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB9F1474CC;
	Fri,  2 Feb 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kz0Nu/zq"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2074.outbound.protection.outlook.com [40.107.241.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA801482F0
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890865; cv=fail; b=ksT1UcU9ICgnH31SF1LxCB9qYM3JJdoCIkX0QMW+qHPkU+NJYsU71DSPzQS0p7X9Lr7z3WtKaW6Vk/emnfcYCKUTtViD/BokuOZgNQm1bg27cV2T41E4zwn2v/uuT/Lr9fa9y8RoEWX8PnpmwMAWdONq/NN+YbckvfA8f0X0cGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890865; c=relaxed/simple;
	bh=9Nw0szS0CMe7XPjYW28V7y8Kcse0VEkbwdo3nQMjNvc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=K8jk5tZSSIELX2Tx3nWvG34b1E729xv1bJE6WgUps3qetvPFOncy2YLcXjMWo9sRabgal05x/njudUHFlw/69BTWa8HhNxDjgb+H0NdPckuUMJXkKUAGqL/d5CQt22TuGscVs43o/ea2tQO88mBu/nMmnfrY5KxDRUhOimr6Me8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kz0Nu/zq; arc=fail smtp.client-ip=40.107.241.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIr2cJgDRDp9QF5SZKTdnscomAycY/YfU+vW/nGrz1piA8ZihDyqo6T/Nioqr3ZEINfXr6488cYjxNlCthscXLZHSJdSTo1OFhQVhRyYYB80IAUUq1ZTjIOaUBviO/U4Rvz3U34R28Z2/dOGX4fOQM3We0jck/CkvjGULyTd/3A+6wwqDRlRTG7PAqvXpTcl55qV9n49DWPbUR6s8Q1IK09qMyfBpnQfWARn9U+1spdMFR0KBGFdZRhsq20SQylRyeEYnLaPMfHnia98K3U7Z3T6t4ny4Y+sDThUHHTU/hhq7TbpnZe08OlUUhlL0tSKdhHUP/9Pc1qnuTAvphfUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ixgmXsW+N2hN/szLpezriAa98C1IvM4GO6Lurmim70=;
 b=hyRF8YCwnubWEbMwWuR+riizBL2SvNM3BN0/vcXuDn+ANyq+w1GpTratHwGyLn/T5q5VVfTtYKAP1WU13ZHEovTr/URb/Y7LFL5gQZHkzL+A6fCK+CfOGGAjzMqPi69E7vKRjj6MWYLVpBWJfEUYaqpZJZr1vgg+ZbZTtsopUC6jOGc3FrU19CVG4u++BSaPI1xP/MkMY6NbF7lJf/V/iVjvWnS/6gjQJBcFmcfrcZf/EgpM0sXjd4GmIkLNMkrh1MwVxwxcNI6AjCfyZxqu2E5t6rrWRtUn+L2vj02vUOhf/CD9hcm83AgSJDTQrPrf3vMdvd7xlFB5yYXeDzUN9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ixgmXsW+N2hN/szLpezriAa98C1IvM4GO6Lurmim70=;
 b=kz0Nu/zqXNrpMcmEyuQTVZF2t9mXOWqTqQ48YJLOlD/jilLr7yaGceQYQqTjCmO88cecaZinUDRiJRMqfudxujJXwuUOpzpDMFLAZlWbwLPwPo5NQV2xsfP8TrZ7nKL9d2bv08LfgDwNcdlctgs4vU+3woHCUIb/1g+K7dZzqnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by DB9PR04MB9234.eurprd04.prod.outlook.com (2603:10a6:10:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 16:20:56 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 16:20:56 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net-next] net: dsa: reindent arguments of dsa_user_vlan_for_each()
Date: Fri,  2 Feb 2024 18:20:41 +0200
Message-Id: <20240202162041.2313212-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0446.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::12) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|DB9PR04MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 774e7cde-c48c-4501-7066-08dc240aef28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KVdeMiui3BXbGovyhhGoZwpneM41yBiC9CnyBRf6b9RFstBvkrxeXZ7EI3owq5Ue/YkzMQFksvqNKqNVwPJFIuj4jA6lQJSU4fAH7XEYpMcbCKey3fRx7KMtE1ARNM6HMjPdSw+GdHzGFTjI4AjQgtSVhAzDJCvcpGHvBIQi2tbOJ3Yv/3ixIIKxo1OWuEdLQDSqMbIKDv237H6usnGKZcLkE/nqwUg01VRUVQTO+bGjcTrduUW9eeNfC9fmRB7yODjsbfBJvypjcuSuOsfmWbIRqwo7Mj1ZWsjhlf2FrB1dxDuzZey0DxF8EIsKrbntMrHPNBDBT9FQQu9jw+l6ewUqbKeDoRmk384WQDGhwy+iapWdYyKz4nha0gT2WPBHYOsfhmsj7Zrc6hDsVV6FhfgE2r/+/ithx26xCu/3mT23n81N6que0/wx0lL3rZM3ZDGXheSebAEwZ2NYGNQyK2Yp2QyYuBNQfXta5GRtLNCrdyO+Ih+8cDYAZHhPuyOqvhfDsNyRX7ooANRDAG7rcvrpOKm8TvtRMcmVtb3qSCfd0TAbBKtIrFBsPsblPoWyK6wXEQG8os+lpVehFqr06/mXLuzX9xBhjsdPZ+30kzG78wPDlZGGU84Shi2Cae/D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(376002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(8936002)(4326008)(8676002)(5660300002)(2906002)(41300700001)(478600001)(86362001)(44832011)(316002)(66946007)(6916009)(36756003)(54906003)(66556008)(66476007)(83380400001)(38100700002)(26005)(1076003)(2616005)(6486002)(6512007)(6666004)(38350700005)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K0I74ZxmhD0RI/2AJhDydXuh9oszlXIVNkTRgFE/kmZk8xSVWgjqDYmX4yfm?=
 =?us-ascii?Q?HG1MgkPhQYJKCKcp5LdkFbOXY9m0S6yzkDZhaHQoXJMBOF4818sJVnmkzWNP?=
 =?us-ascii?Q?yqOnF9U0EEf4PQficvWChR79YTztlWB3ZlDI/mtu80EFPl2djv1M+MWxFfCt?=
 =?us-ascii?Q?y3tk6I7ncBKsYdXAtRpPaPkFSrFGu3zSDTJQEOCrB5jPbQWGA7y5aqSHrfbK?=
 =?us-ascii?Q?P6DgRJNbIv+5Mf+2mifeLvtUm7XD5qL3BIxTsALmjl1s4SMyQ2X0QPWPDtEx?=
 =?us-ascii?Q?cXolRknWFeRDe46TkkGAJdFPiE544dqBioU3UUy/M0LBTT03bmZGMozl5E5v?=
 =?us-ascii?Q?7PV9KKzsDjBdFdnCmEpPjqDT8gvwBHcRTKjXn6rTct62Rfm2Ct1w0fDDYcHe?=
 =?us-ascii?Q?SiCOA0n09gW3tBBh9Wc9h7Arrlas5F1DDJcKfcLxsXSIh7YDkzUL6R86kHUU?=
 =?us-ascii?Q?j04NUntWeSAVWrsNKWjf3zSmheUXFPby4iMZH2ww1KVR7E6Q4icr2keowuj1?=
 =?us-ascii?Q?7PW9DXuAQs5KW9D7TzxqZLKb8b2u5CSzCUtbTVuUm0Vgx3qieewqmTJz5WfX?=
 =?us-ascii?Q?Snb/GM2+bcbVp0zIZQin2q+QZJESIyoJnkqfh20HXRrw2nOqhSXKG4n7RTkV?=
 =?us-ascii?Q?RyEwDz87mrAYd/8z4P9pL77VAMyStFu//H7HfoL9itszWGpwNf9HsTlP5sRv?=
 =?us-ascii?Q?DKqtbVJOuuMiNwxVK053oG+gwoLogCUJV0lePTH5bIQwH2EdNDM6KJpWGE18?=
 =?us-ascii?Q?F/6INLImHgFaKU9JNIZX3JXLVv1l3yI2uTdC+hpPBIociFwPfN0dP4O/77QN?=
 =?us-ascii?Q?MzkLG+8zLfLJrE8CZPd5KQ3XtXGXUopNyzCQH7KcLltjwuS+icPGDLDcou5v?=
 =?us-ascii?Q?g1fGNLZz7ZfWvtMNRVLSRSKGETacFeYSIwSpIT+D48u8tQTvkSRiI9A9v8Pb?=
 =?us-ascii?Q?cENtPOF23+5wGZ11c7Z6yj3htg76MGmAeVMhq+lbHA4281basa2VAmkRqLoV?=
 =?us-ascii?Q?PLR2zRCI/zIsRC26TQw+c/iwf9+qsIOZt4L0521WATOBrGYxtH6xPoqTLDzt?=
 =?us-ascii?Q?PBkK07nJeYSegQ+yxMT8TvuDIWI6FBno2TQewAxIvZFQrWmfoZeESYbQJCPY?=
 =?us-ascii?Q?egDg3jE4aOlow+WnrQz1lJW/Im3FiZCho6r7Rpok0klYXXdOBDdIHEl2mNmO?=
 =?us-ascii?Q?rkEcIDFk266/+fhHWKJX09r10sZceWdgi6hjh+YXFkrJ1/Vtxf5XUZrcjtz/?=
 =?us-ascii?Q?C0dX3cOta2EvRfpVxC7+wfouCkzzALZnmHCUlWgyRe/bRcovIL7Es6798ape?=
 =?us-ascii?Q?4tzhHmCk6WZS5efpt6ruS8uOyoM/3hnkG/34PQ8zcdeG0/0/JuegTKRichxj?=
 =?us-ascii?Q?6qEooq9MfcYa5KF9MdOONElUvtmYDDAKwV5zG5xyf9cOGUMSZTgGzlbS83Dg?=
 =?us-ascii?Q?VmKvUdlCqnFKXLSLIOMX2m+qbt9c8EKaleGfUpEp/3pB+BzF8lUoz/5qUNlM?=
 =?us-ascii?Q?5dkYQ9IZ9oICfSijIL6UFGCdInWHZZQ8Ry3sPDf5+nYZrHj0XvnsLWzFkqKE?=
 =?us-ascii?Q?wPtaxcPVQm0dTBRzegoYIUev3mTSALXTgHwMuBRXGVrWVyBprWt01xv8ykMq?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 774e7cde-c48c-4501-7066-08dc240aef28
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 16:20:56.1670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6xdBzB7zwYwmp57uOOPXGR9DnDJUSK9XMbJZQSdyIlWYnkiGGoudoKNt5fs7EFZnff1tqTU1xp4mcTJcqdUyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9234

These got misaligned after commit 6ca80638b90c ("net: dsa: Use conduit
and user terms").

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/user.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index e03da3a4ac38..ba2e53b5e16a 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -210,7 +210,7 @@ static int dsa_user_sync_uc(struct net_device *dev,
 		return 0;
 
 	return dsa_user_vlan_for_each(dev, dsa_user_host_vlan_rx_filtering,
-				       &ctx);
+				      &ctx);
 }
 
 static int dsa_user_unsync_uc(struct net_device *dev,
@@ -230,7 +230,7 @@ static int dsa_user_unsync_uc(struct net_device *dev,
 		return 0;
 
 	return dsa_user_vlan_for_each(dev, dsa_user_host_vlan_rx_filtering,
-				       &ctx);
+				      &ctx);
 }
 
 static int dsa_user_sync_mc(struct net_device *dev,
@@ -250,7 +250,7 @@ static int dsa_user_sync_mc(struct net_device *dev,
 		return 0;
 
 	return dsa_user_vlan_for_each(dev, dsa_user_host_vlan_rx_filtering,
-				       &ctx);
+				      &ctx);
 }
 
 static int dsa_user_unsync_mc(struct net_device *dev,
@@ -270,7 +270,7 @@ static int dsa_user_unsync_mc(struct net_device *dev,
 		return 0;
 
 	return dsa_user_vlan_for_each(dev, dsa_user_host_vlan_rx_filtering,
-				       &ctx);
+				      &ctx);
 }
 
 void dsa_user_sync_ha(struct net_device *dev)
-- 
2.34.1


