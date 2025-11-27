Return-Path: <netdev+bounces-242263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58336C8E336
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AE63AE2A7
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C705F32E6B8;
	Thu, 27 Nov 2025 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZW/xEU/i"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6DD32E759
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245383; cv=fail; b=Vd7pqin3mQKAaFVnjXzfZhh3idlkcIXHVrwDO+gHAbfhRh3aUi2Bvw9JKvQ/0H/GONzSRxJJohYhqEwx57QQ6TOmBGh8z4ymob2Tq8KNUIcYr6akSawqpg19PV/7w+rlweGJOwKPEsDKY+RA3m64mjCplMl9bHyXJcA0YZFg+T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245383; c=relaxed/simple;
	bh=guX2CIgIihKMrOehTWwtiw6Xz8SnR5N/7PAOR2FxSMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KDhSFLWbXU1ZxZQX2pjVBDHOpLsmoQq3qnyZQPFMHLb2Hoz0CMikO+DWgEf8tPWHV/D1K0NEjYPjY89lr3QZgagGA9gngMEayfRPeFxULSrHZlw+ej9J/ZkP/kzl4/Oc7QrehZ0V4VINx35j1ZBh0UrPXJ4JKOWogsZ6188FnVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZW/xEU/i; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKhYOYltu7yUOLjYHUnnMvSQfhvsE02Dl3pD4wSQrodRgYE4QJEq9UTugBUxLmRxgIx/Z7egArRnHQ2jRrISiGN8apjWr1NCHjkM6yLg3fYBKXzUaxJIGDwYdPny7Wu1Hy80Vkjf8r0TV0zzUKQUy+/HXX/GYUUegbOx135mhy5VJlCfYBOl3ekCqKdBEadj1kM5AqdrCIaz3zMfYjjWAxOWCiKePtmWTQJZvxEBZdsnILad0ouCHdSTe/ntOtrrsq4yT8DfnktG2GIXvFTG6vGl+6kZxj/a6VmFs2RIHkU9qjKpTKo45iUUhD1ACnU6F4oA+pfQjLkC+2GozEnfOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOeWb9rJmtLEuxhsPP9gEy5exh06MWMv0d++SbiamPw=;
 b=hPuweN/qAWl7VHjh27bjJEk5P1GjZv68GaUaztv4qAMWds+GFTaoJ8hPgp+nlas4POs+tOXpjWwu2QWPj0I1aXMqb/LcxwdUOVrnFNzTP9zcwfkK4ttplxpY8vHU2bH0rJX0SqRbqlea8UFSGC8A7m8VVGPkES+uJr7snar6+LXgw0aVYb4iZgEKa5hrKYo+dQoryBKwKX+DL2OFdrQVhiFYoatEWB19txGOoN2/d3616P2rjqs+k0j21C8mudytCS8kHlo/TIysITCHU9juB3fpKIJj/T9FzxRRLcn4Z1EKmSlZjVNox3mx+6OZjkNSrrPVwsfyHLfU5F7ZdiCsMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOeWb9rJmtLEuxhsPP9gEy5exh06MWMv0d++SbiamPw=;
 b=ZW/xEU/iusf4pNlddrO/xqjRxMJIgcWyGtFC3DGnJ5SE/OJqCMhIN3SXDFLxyK1YkR86S0yrB1r2EDQbHn5izS6ct6YyfpE/5zmpy7VXjndTg95H4cQOkMQmbBiSphdbAtlcrhevDY86goCseXJbsA801xzrhpoPko1HNRK6GYLeH4sT9+z4WsMUpgLMbY0WeJ9Ie2FdGI7fKIxlomAFyw1wIUhBzMYtgS+9Z29CMmQmGKkKpDqyge7hjVrBCbgO6AoUlP+N7t8+qSJAN6c1ifM192VgxX9w9Lx1hT36DiovC/8SBMr/CrY3ZbUxsOz4PtNHHiO4nMBTBk5YKwxw7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB11844.eurprd04.prod.outlook.com (2603:10a6:800:2eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 12:09:30 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 12:09:30 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 09/15] net: dsa: tag_qca: use the dsa_xmit_port_mask() helper
Date: Thu, 27 Nov 2025 14:08:56 +0200
Message-ID: <20251127120902.292555-10-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127120902.292555-1-vladimir.oltean@nxp.com>
References: <20251127120902.292555-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0056.eurprd03.prod.outlook.com
 (2603:10a6:803:118::45) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB11844:EE_
X-MS-Office365-Filtering-Correlation-Id: 205683ac-df02-4e6e-2183-08de2dadd039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|10070799003|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SogVgb4MFBQRag3BQhAJALDCapby0OCq0sSGA1YKonbc9Bc9Y02ijpvxaZmA?=
 =?us-ascii?Q?O9xBbfd6EzAU/NMNE8+/RYZHaKxnz5y6xxcQlBlSg4cFm/XeaYqpLj3hqdbL?=
 =?us-ascii?Q?m9Oq7GLfqABwQCOxUQmVulIk1cfwrmBT+2MPb8lon7ocDPKT0cbZ7nLnbbCK?=
 =?us-ascii?Q?pzjNdg1vckj7muyILLZV5DlzI1u2sstc0QJGsBQ9jQ7t+y0C9KU+OSoi19Kx?=
 =?us-ascii?Q?dcvbxe9FGDP1Hklujv/u0BbOIs6nGCF9BW36lWQOaermhL6iTkUEle7uazTk?=
 =?us-ascii?Q?SObt7vzoHqWBR4PhGtwcHXMu7sbohorSDpFWbNQ4/7v2y3uQKBXaOIQ/tb4A?=
 =?us-ascii?Q?xpQQbK55O93jtE7nynCGe9nkq5H1c/xSQVj917lmxKglYoRjMXQUvnuEtVr9?=
 =?us-ascii?Q?By7pxxTxLwT/CNVHu5IT3Bcy3AS2rC1gXY+KMMW6yp1sRKmS/YT9xKmY/ZPZ?=
 =?us-ascii?Q?4uEhIJv2j8FrzBtxKVTZcszYHT+uHgidMVKEyttHRhMLu4wA+5HK/Yz0Ix1k?=
 =?us-ascii?Q?OvAAx8m9akIbHAHlN7zgLVAfy5HhMH0Fz69lHBTc8HHOcreubkzsVgQhtE1u?=
 =?us-ascii?Q?IWL2PvrKBvnf/rkGmnCc4LFsCeFPeLOFXPdrPQF5C6wxPzXqsV08CXFc5LGV?=
 =?us-ascii?Q?aZV3kQxHo5wfoYcoVX1p3+Qi9ho3HZuM8mJcaIuD435YZiLUui+KLbngPNrL?=
 =?us-ascii?Q?yk1LCutICiROJAozikqy0jMQoztQlFe2RqTvwPd4vqbelXvVOo+oKA7ozJTZ?=
 =?us-ascii?Q?l33jA6ZXj++Pm3Jdw7vtedovOZzxS3G1j6/jVP7RpdHPSLE+XF+Hi/tyS28z?=
 =?us-ascii?Q?ozUdOyBgDDY3o76DfJi0sQVoEXkCWoNW55dhbLNcnKimhhcgXpA9gTbLsnUa?=
 =?us-ascii?Q?O1cdn23tYy87o3Ya/OgOGq+UfYb5udTxpyvGu6W/NAVbhjcisFd3/Nj3YHUP?=
 =?us-ascii?Q?RUbmcuqU0Er8/Y9SVM94fe+EindKanazqf2On1DO2b2PtMWuEN4t1HsaVeAJ?=
 =?us-ascii?Q?yN2AvfICZuBzkmRoKbBqzGiWu23glp3uHZc8t24c88NN42dP6SbEmbnEdoYM?=
 =?us-ascii?Q?Y//BsnySqBeGmfzgr6FhzbMWNeQf6mJM5rYoCrclqEobKkfXYDQApXi+H0nU?=
 =?us-ascii?Q?diV6NlJ3gz944N2KuVRDs/V+SUbbi3VOguaTeuQMI39TPm/btcoHvgr4iLgU?=
 =?us-ascii?Q?mfIIzf6Q/4aAU0mm2AD0c1nBk74BoT9RVLsAsVEKqLbE9fkIbLe/60tOHle/?=
 =?us-ascii?Q?wWG2iBR7K2tQq/qnbRMdbckakllRjMg0xs8YW4lOOVBkgE4lQF54vt7AOCwj?=
 =?us-ascii?Q?chB/tyZ0xkS2WANk5wFvaA27Lx6t3X+Y1cvGn4aMVf9zOOcXXumX8jAP/CrU?=
 =?us-ascii?Q?X68IT+Og2kkTpLEZpOpgiw4uwDWK50aY1x5FUdRcpYx0P8vAHejvPe7JPfsg?=
 =?us-ascii?Q?y+YwB/uZotk7OMauhV5GrubVgV1AuAgr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(10070799003)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e5CPMLPr3FiobvJpRSFXv82zPibu1IrV1PcXqg4K5UyCRcCg2M3qSEMIu4LO?=
 =?us-ascii?Q?YYTOnjIRns/i5G5QNqThGXzh8B5lTjOl1Z8eskOT1pL5eafGf72SgKXamx5J?=
 =?us-ascii?Q?xWad/4SpEeaZh3JibOMpVRCOpweomaY8nJQ7e3ConuII8I+X4fM8ZQ5ABIdl?=
 =?us-ascii?Q?eWcOklKYbt4Nvg8Bw1aAUki4DSsv2alu7fdtZOxpYL9wkHaxSGio5Y7xmE+T?=
 =?us-ascii?Q?QF1s0/qnOSVG5mHXoQDcv0KeFAhoLcEibIXmqxFet4YZLESX3qmEm1cltZmX?=
 =?us-ascii?Q?fgR2AE6SE/nymQ9sOl+1Xx2tyjXmNrqbwQkotR5wwZmtv6XUhGPr+pYYWCHU?=
 =?us-ascii?Q?FC8zcueJEYYRZ1GwqduatdFp0J8fBcMmgK+YuA8NP8E9MC4gy1PP8Ht0OHZE?=
 =?us-ascii?Q?pnED6H0pdSUbtXvmyjaVV1uEzK23vT1/xrZlZi2R9D/2WcZsDoSLSHphIhbq?=
 =?us-ascii?Q?Saf1rXWTcO1mkG2Gfg61lV4N1jXeaTLSAGHn0VgNU8v9Q1feFs2+vzfnMB4x?=
 =?us-ascii?Q?phK7a7RNNbAJKCR0zOW7wMlYXE57Ec+MtjPhZSmWB7PJ5plHRtnLphfbcShf?=
 =?us-ascii?Q?EFQaJW5Len8gYGPpTbajiTFFs3rqJSyJLMaulIKFnqfbbuqEtYS27PfHj1Vb?=
 =?us-ascii?Q?Hh6sVCQTm1F/M4ssKENdYI36vTJKz0svJ6xu9gVZ+rESZ5CXKDHNR14DuFRL?=
 =?us-ascii?Q?CTcm+YkixYQlMnvsQyAAkDlUjp+6vMWzieNMatsa1pEcBLb51pN3i8523LqA?=
 =?us-ascii?Q?2GEbbH+sMKn6RkhBzlGNSX+4uWkMpV9e+tqfczKj2FujJmOCPvRlBq2sXUfO?=
 =?us-ascii?Q?0NrZFA2WyoX1/OO8YeX9Lt9GIa5h9K/1OLn9ckefScuQiXaLA667j3GWZlLH?=
 =?us-ascii?Q?2LH9SBK81ZgZ8Y3g1LsKPJETLOOT+7jOeC3Uf6ptyJg3s4Uqq2u1Oq6bdp0K?=
 =?us-ascii?Q?7nTHvJ4qHzUjhKjHYmWJ7vnVhCg/Pd61ePR7eWB8+o13Hh5Evcfh19ObicgO?=
 =?us-ascii?Q?nRb8Bnl3ZgIknPwV3vJ3Lm1oZ75nF7SrxO7/2YDpb20+4I1D6+2n4iF2dfSM?=
 =?us-ascii?Q?C5kCzYRdPj8fUrKlTujIlMzNaf7wnttHZoQ4FkgbNk5l571Q+yjkylwf/qpY?=
 =?us-ascii?Q?TdukqfGSNohpvSdELxzJyYyG1DXxyY0eC+wg2mMjpnalqVpp+sWGozHXBfi3?=
 =?us-ascii?Q?/bhCZoD3gp+7oCvnux51mf0PPO0bGZAfDmaim27c9s9f130vIXtLwI6tigqN?=
 =?us-ascii?Q?e6qWRh5NhuNx9a8FyhpqFJuKV8GqRSenvhGxtydB/qhqLO37ei3Ar6wnHisp?=
 =?us-ascii?Q?w0RYpqrDGTlcyDBC22U8wKxZMZX/+TmsE13R6sH+p78gxxgt5wh6r0TQaJjq?=
 =?us-ascii?Q?0odksLNGsnebMVOPneLiL0+jTNVARETUXg3xhyHjXAoLCyjQAAPPoeN57Oqa?=
 =?us-ascii?Q?AHLbS5SHlKsub3ShrM8icFn/O15B4FLRboun68Fhnt2eSdIMh7ld2gPB8cEI?=
 =?us-ascii?Q?dUlljd63fGVwt4HZY/3WIsMVeswMYDgy6AD6RIGh6QO7EbJTgXVTIY6V79cq?=
 =?us-ascii?Q?oKt8voTY+e0ALzisMkhUR7U7gO478mwJ4dzY8DGgQhu84xUfojF+VU00Gspc?=
 =?us-ascii?Q?1//bWVAuaJZqodbulMbNkjB7OBYlJ1Uu1+xDNGkOezMKsWrYjzrQAAVwS2xr?=
 =?us-ascii?Q?v47sHw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205683ac-df02-4e6e-2183-08de2dadd039
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 12:09:28.1085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gq9yufzCfIJmjyjwzTFCaqWMpIHtpVsFWmhXDdQJGmPwd+m72r4L5fF10ckB4dBUBYzgRV6397DqljkzQvEBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11844

The "qca" tagging protocol populates a bit mask for the TX ports, so we
can use dsa_xmit_port_mask() to centralize the decision of how to set
that field.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/tag_qca.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/dsa/tag_qca.c b/net/dsa/tag_qca.c
index 0cf61286b426..6d56a28c914c 100644
--- a/net/dsa/tag_qca.c
+++ b/net/dsa/tag_qca.c
@@ -14,7 +14,6 @@
 
 static struct sk_buff *qca_tag_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_user_to_port(dev);
 	__be16 *phdr;
 	u16 hdr;
 
@@ -26,7 +25,7 @@ static struct sk_buff *qca_tag_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* Set the version field, and set destination port information */
 	hdr = FIELD_PREP(QCA_HDR_XMIT_VERSION, QCA_HDR_VERSION);
 	hdr |= QCA_HDR_XMIT_FROM_CPU;
-	hdr |= FIELD_PREP(QCA_HDR_XMIT_DP_BIT, BIT(dp->index));
+	hdr |= FIELD_PREP(QCA_HDR_XMIT_DP_BIT, dsa_xmit_port_mask(skb, dev));
 
 	*phdr = htons(hdr);
 
-- 
2.43.0


