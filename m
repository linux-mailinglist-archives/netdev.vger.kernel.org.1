Return-Path: <netdev+bounces-220102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 080DAB44765
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41233AA2D1E
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B4D285CB2;
	Thu,  4 Sep 2025 20:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sn7EddJ1"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D7828466D;
	Thu,  4 Sep 2025 20:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018150; cv=fail; b=eibeZ7Bc8Qe4RjM/zWVXV2AR/gm/pmJmW0k5Mb+QaQrLh2/BJ7Kmx/qJyxYvWEbPyFtCe4WnkE+4fz6uXBq3scErYZKK+g/6GmdaxwWAoQW2IMs4DZhqyzjgKe6WlnZpM32lfjmZsOgZ+5RxyaXr0vsVV9iwettpyCvT3yUu6qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018150; c=relaxed/simple;
	bh=kmmIVa5PUfOthYN87O4DGoiRl5BRwSIqTCC8uco7wR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lxoef3Jiym326/wQf3J0L6GlU8PLk8nb4eKzSqs/KenpwGxrKPLpuLZ8U5kTuCFLFhAqOnSL69gykBsNIDk0bAX1Zh/JzaK3ei3G4rD+yOaK6rWC7rzuR1PhQ1tnDlZlhoSKF6f+yjEFnG5ymOKoIfACuuw1H1m/EjoF3G1Rq0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Sn7EddJ1; arc=fail smtp.client-ip=52.101.70.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGMUbqh8D/PapZro7Wxqjm6Zzh2zF1kNblgyO8f6gspn2T8HzZ3aKYqZFihur5IigJmEdmCVRPqx87vC25Y0jzqL0TyifEwBvsGZkK8lwdedVU9MuIZePhZkwoimNQqcqQlHce1+fvi2nEUuIy936gUQ8mAug6t3v6LHk37ngdTd/hwrOhURfWKLX8wHza4aZnGReFoZK3gQTf+OeD2ANfj71RqzZqg3BZmSCOSsMhcGh3RVNIEYZZpq4FoAz831Zuq1TY2RpfpcZfNn3m3butc1OLtG+prJlD9YTs9tLzyI//wTP4MVxw4a6oS1QgbUARjB3zAcEJRt/CKz7YQ88g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDCawbrpeR4iKoITc3HdSV1aFD5ttTqkS9HL/kFEZg8=;
 b=ZG+5DnIXznFDBSwUfihw5KQZj9BYQHF7uIuvXY3upZpyGp6Wza2qYsMeiHPuRmp2BcGThu7rQ9LOP5OfU02Rghyf2NLNvZU8g45e0Pm9ZDDg2D41eJ1E3vi+d3vEkj4Jy6uzwkfXyb7IMBYlD+LOcJCKXWqpViIkgZU0jJ6O83h30TJQczgrg8aFxpF36t79EOeDvNdRKEX/A4scQEDeYR2v3SGhb8etlqxNE8JfKN+rqMDmviVK2KysU0jCX3lQG5w30boqI8XGsxsXfobn7nIfhn9ybGCW1j1OrFnAWn8Wcj6UweuY4J4iVNjTYviBRtnjLtIBYc5vXaZan1N/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDCawbrpeR4iKoITc3HdSV1aFD5ttTqkS9HL/kFEZg8=;
 b=Sn7EddJ15OBU5MexlV4ayY1bAgwvrW1MgzLWKdL2KIzVHCSzoiAULbGJxHq8dADLo6ehv8wVmyHNg7OUGOILszWVbivBjAHlWrfGqq99OakmQbFGUvBV2i4pCrEqjzwI8uLekE2bEl6sjrVwmP4fxlFqH2RMtjFEPe/dDzYI24v2iB9B0yA0lGvNk3mWJ/FllAJ8NsSco0xZ47U3VszpFzfyt3xsTQQqLKuS8O0QiY6E/s7wj4zPBcUJuPFWvPFt8Fa2tZHMCmq2xr1SNMNMHHiuBo9F6EXuSmGpTVk2BCFXY67a3QM9cs5V/FyOmiHNOKyqL6tliUNhzi3M5e//7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by VI1PR04MB10027.eurprd04.prod.outlook.com (2603:10a6:800:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 20:35:45 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 20:35:45 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v5 net-next 2/5] net: fec: add pagepool_order to support variable page size
Date: Thu,  4 Sep 2025 15:34:59 -0500
Message-ID: <20250904203502.403058-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904203502.403058-1-shenwei.wang@nxp.com>
References: <20250904203502.403058-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::23) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|VI1PR04MB10027:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b1267f-8d93-44bb-c63d-08ddebf2a018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8fwWTbx8rljySQ6PHkFZJ8iBPbXFw5x0zp0qKT1xKp5+G/rCZx1TCBuGKB4X?=
 =?us-ascii?Q?l1qcBjjbHRp5+bzF6EcIn7+CDPGIHd9K43z+JjE/aCn0uTSR7tf1as631/DN?=
 =?us-ascii?Q?U141AlAWumKEgI7YC2r7UxsNbYypOe/JzgOnoCnHO3LKN/3sb0ysqcPFw9hM?=
 =?us-ascii?Q?AJckkPy2SwSo+y4RIDTVKX5dt62WXHYkklwjsDRsBcjQf5MSJv/7k6NORme1?=
 =?us-ascii?Q?qCPqOFUN7156Q83IHgaiNwKHGGGFr1+xiim2hGBdzsDwJkHBYeC8sV6OuE9w?=
 =?us-ascii?Q?02oIQO9Xus9iFZ6mfoncYEx0CpkjAp24pu2tAdyp3OjNeY8iksoLdCmINWoi?=
 =?us-ascii?Q?5kKIZjUDsEnHOTZUj/JY5VHnGq0eQxSlYwj+TE2rgG9fTJwgCg0QaSYVh2x0?=
 =?us-ascii?Q?8EpFu7Nwsmc1KqKnELbnbNTHlakv6NjaI55jIvzrvcm5RGwAMsL18nBvxOOJ?=
 =?us-ascii?Q?wOP3oAQyF7xOKASzRzNKf0myTYUmXPDz5PP2ZoqJAZibot+7eYvSqtjdcA1C?=
 =?us-ascii?Q?8fAnuze5p6Zpvw5ppoWoliObAVKtKcnUPEXYuRyPn/4QN6Q/x2dDAhos25JM?=
 =?us-ascii?Q?jAk2WUGgQ8D/pnIIy+t9IR67YXM+ksM2mXpSt0JCnNwV3n3sg9vf8eZgsYB+?=
 =?us-ascii?Q?DYuYKurSjZN74IJXUGnmklVu0A41QaGc/oX6aY/uF8VR8fZ4ZUUafv+MCWva?=
 =?us-ascii?Q?ASr87inQFxp3L6H4jUGs0Dm3DGiCmmSPTSmC6yqliomBYwD0xltvO8EX0knq?=
 =?us-ascii?Q?PTzcNX4NoWI/ZeLifQKHRBTv61LZFW7ohAv6B9IP+PsKxMm9T+4nh/oks+dg?=
 =?us-ascii?Q?dMBTUKWX1k4OnRxzmlfMVM1eLfh/sMX9dfBSf5C69h1T2qRIpNvvc6VXZf/D?=
 =?us-ascii?Q?xv/1sbwpvH20uKX/tiOFiBPvDKvYioUmPEj9piyuercu9ePCHPC43GjT49Ld?=
 =?us-ascii?Q?y+5kWEVvlxzBiMuJwuqfDumos/YLczl/IN98P871DJzlaus4pawfzxytLGm2?=
 =?us-ascii?Q?kLXBHU0hDaGJ5mL9Hxj9gT5hL+LydVLnWtii/sY4whyMWGQ3eG9o0RG49WUC?=
 =?us-ascii?Q?guntNRPjkS41jewRt/fCprRX/DfxBEKn8UWT+/t8N3F3of8x5lS2uxwot6Dl?=
 =?us-ascii?Q?94j4Vc0XsT2BebxBAHKHX72fSJNLVPx5W6EPNC5q4gwhi6UV411o07LCyQNu?=
 =?us-ascii?Q?ZcH+4jC5OfpV+Evu4r7y0VzoqKyIsBM85E/Qkr2DBEB/1f+0FLY90YUn9Q+3?=
 =?us-ascii?Q?MWolpuzda9Za6m/6D1Xj865ns+YknMxlKn4lbCAEstqrDZW/MjX99dqQRAkh?=
 =?us-ascii?Q?YSyeRh6rIvUSvSHln8V0jDxOId9JBq6XAY58fE/irUP7g/mDjGPOlf+JcfDq?=
 =?us-ascii?Q?b0s81enOpCVh7ZNtNiAvz/8uHZeTIlDI1tp8y+HjiidAkVhFnvizwctnt8/M?=
 =?us-ascii?Q?1f4bf7ft78Yz5luNjx+Sh6sjyjeMv7RRzKJ6NDHEaKAt3lJrSImUcsjapjJB?=
 =?us-ascii?Q?q5pTfXQYBNS4Z+w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tp3iKr+PbaCmFUN20EqfBB+DAcQ9O6AqgzXGvszkMxqd/eaMHwOwyPv/uAvg?=
 =?us-ascii?Q?2+5+waOQWtju8MJgMuByteUzQ+kPwjNo5u7lr2An8HiVZbhK+ILZB1x6bkmN?=
 =?us-ascii?Q?yjSJd5/SMM93gj/fXWg7gu3Ys35yArf81t2P+2F9tSFJTnOfKO7pyOPMG//U?=
 =?us-ascii?Q?EBgYaiTJ91TOqo+dclAl0TOvfmUJB+qqVeFh1T89sq7Gn04TARrACOlETokI?=
 =?us-ascii?Q?KJMZmQJxgc9ukug+ZSElRADRKK9Xxr59rqohKYMQRIoGea1mYaEB0ExztMvX?=
 =?us-ascii?Q?mlW8Hncrsm9z6zhPCMuY9YQMotf7hQquEbE8sGOixZ83B2SGdfjPFaNTCQPj?=
 =?us-ascii?Q?SSZMzrq6Og7ewaRQ3QLpunpKvIJT0UBfWv5o1RWF/I5rvd5uNzCHcIlY3bEo?=
 =?us-ascii?Q?vBrg6YEAV9SVmHgWcCdkQRKMbE0o6BiPRttlfGznASf5b5+PvsrB62vGHWcF?=
 =?us-ascii?Q?adRnLI++SW+4vsTX5f+Q3CWXUC9d5hlXzJAU/ER9SspQeAysG+JFeCdlN7VZ?=
 =?us-ascii?Q?9T3v0l9gRFwdSGfWAIJQbeI/4SEvaef8vVe2ZGLeqwymoyjXLPR6CBfzw1s9?=
 =?us-ascii?Q?JJRc/Z9poBvTZuy2Q/QSHp3d7Fnv+NTBEtyO1eDERkh50WdeSb2+xUJNuaUo?=
 =?us-ascii?Q?wpeMyg/4STllFNk9w93HqQ5T03q0Zu3ucGR5B/CIZyK3LbDm1JHFyP0/+4tO?=
 =?us-ascii?Q?aej5NVMQbdocLScJDDOYwEv4yT0E8YbUT/2umEX6vY8f23x9Pw69KIoghNWN?=
 =?us-ascii?Q?YgF95eghlKiJIPKFm77tRAUpj1nNxWMZjHrO7L8zqrkbsI7/x/IfuGJdAMqO?=
 =?us-ascii?Q?pt8jpv/XboDQR1tbsfH/I2UXGzo+E22UiLVMJcqbh8tfhM0XE4tePzDIpPLk?=
 =?us-ascii?Q?sQdWwYPOfa43LSEw89J9q1vc/MEvKbzcvDeSu3up5WIrL1jv+kfwGUSoXEd5?=
 =?us-ascii?Q?qZO0V1XTKhdjWoNSm9Mqbf1dsRPCYR1aDxhxXmGFTOZl40Njohg14MLZwk9r?=
 =?us-ascii?Q?KHHxDUz1R2atmlJyvaIZNVxnQQkKhTyEfQpr89/Fo/kg5Fjpvg8jz8w4ouNl?=
 =?us-ascii?Q?FNkCDtRfJc2FFaPovAbvizNWoP+CQGQCthT+PwXpOQKQTGyfUh9jPKTHjdBJ?=
 =?us-ascii?Q?Mk67Z9M3MRFihI6n3zuTXvLKIDvBAz/k5CcffnlZ9r+7LZG6bfcHXw+zRqNZ?=
 =?us-ascii?Q?zjRLhIQnEiPXkOgEAHGfOVL0UqggKbAYzIDsGPvRqKkca6+v1XPTetWkUKsY?=
 =?us-ascii?Q?ytk+DVlC9lxF8bBZViINKNhpz+JtBZ/R2r09d8rGOPYY5jQ8crCgCS8Hkqyc?=
 =?us-ascii?Q?Uin3l9nDhv1nsLEho7XKRsClFk4nIYjxHr6cM7koywREPmxCY+gE0cfbdOJy?=
 =?us-ascii?Q?DbSL+CABT/wKlHmDsBTW8UNuVBew/6OLxPowDdNarmOPSLzCew+QA8cm5qcN?=
 =?us-ascii?Q?Sqp7oobCVT4Fm+P2eA/OEitfYxXZ4K4drKO3IRaw/FXlhKbQ/BpqrgBu6VMK?=
 =?us-ascii?Q?ZCqP05yXsotBTKHJ2kgoWMpTGeyAuPwJeBmEmjUTCqrnwWPFC0rRRXTpYie5?=
 =?us-ascii?Q?3FNyXLTtRth+OMkEbyNqcMWWyK6Y/U5Psq4aDoVk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b1267f-8d93-44bb-c63d-08ddebf2a018
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 20:35:45.8709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVwxQDqVckekF1buYQQK5NwLpBVaKezFbGmruujT52JdvgLgkGRUnHrbinPk4FT5ojXtdlfY+MSwVvzNQ1A3yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10027

Add a new pagepool_order member in the fec_enet_private struct
to allow dynamic configuration of page size for an instance. This
change clears the hardcoded page size assumptions.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      | 1 +
 drivers/net/ethernet/freescale/fec_main.c | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 2969088dda09..47317346b2f3 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -620,6 +620,7 @@ struct fec_enet_private {
 	unsigned int total_tx_ring_size;
 	unsigned int total_rx_ring_size;
 	unsigned int max_buf_size;
+	unsigned int pagepool_order;
 
 	struct	platform_device *pdev;
 
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 5a21000aca59..f046d32a62fb 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1780,7 +1780,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	 * These get messed up if we get called due to a busy condition.
 	 */
 	bdp = rxq->bd.cur;
-	xdp_init_buff(&xdp, PAGE_SIZE, &rxq->xdp_rxq);
+	xdp_init_buff(&xdp, (PAGE_SIZE << fep->pagepool_order), &rxq->xdp_rxq);
 
 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {
 
@@ -1850,7 +1850,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		 * include that when passing upstream as it messes up
 		 * bridging applications.
 		 */
-		skb = build_skb(page_address(page), PAGE_SIZE);
+		skb = build_skb(page_address(page), (PAGE_SIZE << fep->pagepool_order));
 		if (unlikely(!skb)) {
 			page_pool_recycle_direct(rxq->page_pool, page);
 			ndev->stats.rx_dropped++;
@@ -4559,6 +4559,7 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_clk_enable(ndev, false);
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 
+	fep->pagepool_order = 0;
 	fep->max_buf_size = PKT_MAXBUF_SIZE;
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
 
-- 
2.43.0


