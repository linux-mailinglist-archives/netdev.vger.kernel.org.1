Return-Path: <netdev+bounces-190933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AE9AB9595
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 07:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B263D1BA3446
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 05:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E286F2206B7;
	Fri, 16 May 2025 05:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aOI+jdb2"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013020.outbound.protection.outlook.com [52.101.67.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBE1288DA;
	Fri, 16 May 2025 05:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747374426; cv=fail; b=ikEHbqEt46hKIKjKPtYKM3026VweOVQDc37G66cWwnHVUIAGk3ldhtyPV5wCiCwyRQEFbawH7a5VFyCdaAWKRj4M2n6bMrjr3QD/SZY6zI5yfESEtjt/xOsDvIAtCSV25mdiJO8zG0Yu43w/uEARy83jdQACNcXZakC/5diKyJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747374426; c=relaxed/simple;
	bh=NcUKXWHRAp/kU6qG9K0rqvGUDtlZO5EIAE3uK3L7BGk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=peNtL/pWOPc+cw151VriUtHTuo/8hEacS8V0HUDpBvt8PuTPCr5gWWneL4KhIGf53blEAQ+AvRx3c2HUeKTL1EFH6DvmcEs4upSYgXEwXK8Zzkj6wDOSrDZ7BMednfa6QjV+mC8tXY6svi2ugxBkaHobwOusRzRzP/taWWulrT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aOI+jdb2; arc=fail smtp.client-ip=52.101.67.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R7tXntZ4Y+47+g+ThEtGaqcvgp7ASJFLHPD5m9u00lhkuyBMyWpyTY40WB/a1gMc7d2uwcnktI5V6AD5gIGhkY2i2yrIySE2FVRDJcLY9bdDBktbSwfuwJnydnq3bKbNu5cvYit/rjPjjyCVIBOfqM9U/60ZKAp6IhVQ9HlBwlpwnfy/KZqy727d4nTjpzD59GAjugvhNT8qaT1WGe4mlqcSLgoKCXDWTnpAE/p54e8S7k/4Q2L19TKr/7GX6nRSk8sfja1g6iwzDSkeRe0VsWnryGERNKjYg8gWyHfkyqDM6jXdJHoZloBrSSZzMS6CEyx2kYB24eI1B1iS/p2lWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOj+DHHoZqTvJobXs7qJFydH/N5EOOPEqt15AKbiveA=;
 b=xjOZhmxNxpsH4VoysBCynngZYt44/2yXmZzluwwF83wMGLmqJoeVnFipUeCEO+po+glJtISsfKBRi36oCVM5QdsN643czUkKOjUkaL1ByNp4B5l/OpkEZjtV8IXVeamsBDcSXMY4qnJl3MDxfFff8QvZAlDay31brm4vRa0crucTBueR8JDi7oE3CM+Zsj0+t0zHnXaVuHPINE6C8S2IMkEz+OiWRyN/vaGnlPnS8kdD4wvhM4F/MA+lyf8t4bPO4aJHjwB/A8VH9zJ+dR638nPIGhgMwOQYGagd9hJOV7BfOOqD95NZDhHeiz6MOzaXP1J30trSNth2zUbGG/XdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOj+DHHoZqTvJobXs7qJFydH/N5EOOPEqt15AKbiveA=;
 b=aOI+jdb2jWDubvLUou6zlUsVIuvLfLEiEb9+ae+6DsySgnJOJQddxMtgj2PCql0WMHO8ufwXTjgRNqt31bP15uTzi0WOkYTRZGe0deNEDBe/SXxoPhqGZIYY6CL52pK9QoYAJyz7xqakyWIEvRmgEbsdELdKOiIYmabUyEb4WvquyUgQzD5dK83TX8Iu5tqKQ0fbihs+jqxjUw9n6iGHslRlh8gu/umEVxd5iQm4sk4jNhVOP0SKApzTjvZVmIKRzPw1hT25Qu6OoX+ECyvLA006O2Qzm1042TgwFKrXuuqKP5wNBTppBHVWmecBKW9gNZUh+3SDhWwgDV0Gzb/Z/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB7572.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 05:47:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 05:47:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next] net: enetc: fix the error handling in enetc4_pf_netdev_create()
Date: Fri, 16 May 2025 13:27:34 +0800
Message-Id: <20250516052734.3624191-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 910cfa75-5fe7-43f2-512e-08dd943d1478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HlimePQySFxSeHZCTOij/fQqWZXMLXg7bYgQPlMBOSx3FtR3b85rzPCCxjIs?=
 =?us-ascii?Q?1J3xawHo3xFR12LppQBHQeAkCU/TFr/7goCWb3OLJvYkgugqXYkkoO3nGAAP?=
 =?us-ascii?Q?0imDBV1+fx2sA5mpq+HjRbtNnSXZWjF+/cXbLy05ypFNL5IGuXctvgQ8Fgi+?=
 =?us-ascii?Q?ZM4CCukf+IM3SK3GEGKg5j4mGQ+C2QjCF+RryJ6pJ17ebZyXwkXW0RYORIcQ?=
 =?us-ascii?Q?VT7RBA0wxWQEtxz2HwYf7xT9smhlkJ95ZbbY8iJ35C+qEO4nMqYbhCFfm59P?=
 =?us-ascii?Q?6M9u5Siw9ztkmDrJZm4kwWHWw6J8KcuyrWvnBntxB2CJwd/TiaL3WOUjGhxr?=
 =?us-ascii?Q?wIB4qgBked0rISnuLo8nIg4ckKlYBYXZZW4OHNbPpexTWGwGuK3DTajAVKpU?=
 =?us-ascii?Q?y3mMvY/PlbpjOpb7pZ09CHt9PGHBtk8H/hupquDsbD6t37wyq25hMgLtul/r?=
 =?us-ascii?Q?iHxnwO9J4l4NHZpflWEGZ7ytCsyny9OBiHHXo+9BE38b02W5s5YRRRsZcGYd?=
 =?us-ascii?Q?HTDkMXxHmRdtlnvWM+vA4B6P0Fcp4noth9EQezon7tGS5tnXFirc3CHOzArn?=
 =?us-ascii?Q?sk4SlykKtZZtrjaJbzAcK2iz+i0tHRl077NgNn12XmRRfznEnXaGz0YrSTr2?=
 =?us-ascii?Q?dCy702kRsqbcYTeCZ54AIO49U6XRa39EiWnr43OM7PVLvqJ1CYZJgpkvxBSu?=
 =?us-ascii?Q?2pnBLfQA3FX9YUecX6FvVn6i6qkw1QlDHVAoik24jazqdsqDA7E9gGcBKVtr?=
 =?us-ascii?Q?YsPxWib4VAWC+8rM2tg96z29nvZH8YW35nHDCcnX8dav8qedYJc8nusnSO0I?=
 =?us-ascii?Q?B8BSmwzIPfjGV5PazHuJgyu9FbTPT0UtVjEIFYixB5JjdoRSACWo537S9AH4?=
 =?us-ascii?Q?sNYlkifTCWtVBVw1Xqhe67iavdmV8GJCoVqgkfM/9XTC6ksg8//QOpZ1WAf8?=
 =?us-ascii?Q?1Q3wGEKZJRT/FzjdGRibEVE2zV7GwYaidYBgYXps8uGLDybjwD57dRsWZngZ?=
 =?us-ascii?Q?+2nTV74i+OmyqpvQPpWDD3dvxb5nD47YjtZz8rnLgm4CN6sfva0kubg5o/I3?=
 =?us-ascii?Q?SlS/p7k1amphTedkl04ltxLZPjSPKYOVVA/eYv7p5CO4Jm6tqKHyA7y5GB47?=
 =?us-ascii?Q?Zrp6SHqwyO/76E423LWQQuVmWmLimwJyF47ckDvcqX2BqOWCDx7i6sq+c/I2?=
 =?us-ascii?Q?oRintOoncPGpnYPDz1Mdd5pEuu0nhZz9qB5hmx4uTvfgpEO1J4txQErfMQcr?=
 =?us-ascii?Q?EWLcY5RQKx+dhtPX6bycZa/TsceflAV0WXLUJP8XuX9EBMdpS3mLk1ktRsyS?=
 =?us-ascii?Q?tNKYoBmlvwOEqivfwEnV/RVt815VyIG55W9VTqV5s9MJVnMl/uBqto6yLAY2?=
 =?us-ascii?Q?E2QnfWZG6AIiEKYcGCYX1M5YCFS+ZJr10bXYA4HYMnglFjHhm8cRqxXVBvd/?=
 =?us-ascii?Q?/dlLXicSVDuJSV8J9wmOPTK8nXU0ZIOTp3Rq1FhtfEIp/nzZyHUdcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rn2rlGfmdjYnxG/LQNnTCQFsA3MmVad53drOBf7HoLPYwJr9jCXbBhQ+Nbmk?=
 =?us-ascii?Q?VMsqRz0cAAMvKBACvVIqpzv09aTQXmmtz3FUPze9bTcEGuoa4GjfI1irJAyI?=
 =?us-ascii?Q?SKnSuO47EWIHv0LTCPS14FNMowb4a08qZWq/j0TFLrnXZM/VroUU92u5HERi?=
 =?us-ascii?Q?b0wTPhi2+/AByfYFjuEbz/cdlrY3fV4j9wdFpPz+e+AN1z9AxAoUK3PyL7yH?=
 =?us-ascii?Q?WEPg03V2yzurMAPlsqWpGcHa8flExw1ckyveK/JNJb/ARL2bcQgmScYLR3pQ?=
 =?us-ascii?Q?9ye0i6l9Q5YPLzkejwQugIMsA9ymvzJPkE1kowve6xDYlLCB0lMIwy/R+SLH?=
 =?us-ascii?Q?AE/JhSI8J39ujQ5mX5VEGSmJYoR7u1EQkP+jeWSJLNNmS+1lS3iFCAcWOpK6?=
 =?us-ascii?Q?fMOJJaiuHkYHZe5vm9bjgxerL0OUaAtqpXzeXmk3gASBKp6Fdy9XsGDjLMjd?=
 =?us-ascii?Q?bQ/dN/DmvzvcolBwiZO2Yal3gvCYc5vT43JWkudk9sYGDxvT9b+zhTS00Zm0?=
 =?us-ascii?Q?nK+pJ+xSmRGQKfgRrDgf72DC5jZesU1Xos1FwhhB1l6bzNaIUx9EHM3JV8Om?=
 =?us-ascii?Q?01Gqd7DRdz7j8ttRAQ6cfd/FBaaYy+urdeM63aFyVIkOCuRuJiHzYucOH581?=
 =?us-ascii?Q?SdXpOUtkDF9MQY4pHsmTAaU8azTOWpmuOQYzK36XFMMDtt7JnQsIt8SCWBsR?=
 =?us-ascii?Q?c7crDyu3oAxKEQPvEM4c/7AdDMDa8jAogYQyRL8OhzfNaI8KrRGy9/JZvVw1?=
 =?us-ascii?Q?iwUFx+9BWPVEHqtOdycQm2iPV9a9N5aH68+qm92JERR4zLe0LbCSz3sF+Iva?=
 =?us-ascii?Q?TANrE4md2e/z6AwWIbbgvEZjCv2bL+0mD0ymaULD2hvGvfViaM+zlHUKLgf9?=
 =?us-ascii?Q?wy3wECfWVFd+idVPxjQKFYK1Fe34wjBSNszAil5K9L4A3T8V2c/oVrk/5vh0?=
 =?us-ascii?Q?sglKPJaWV0UWAq7ftvMXAPfGgb9ph+mYYjP89B7TPGVUCIyZGM4tChoP59aS?=
 =?us-ascii?Q?59eAGky4w/lGCBRUkjL2cRLO3FgjQij/l83wqB261828SmZcbxVqyqQDlUpp?=
 =?us-ascii?Q?uqvZnKta6Q1HrLqj+y51kyE1e9z/3FNCQ1qjtfKOybbb4KIRhLibPfxAdfea?=
 =?us-ascii?Q?yg/ihjCzXpcgJ5eW+qnuQbeMyZTSfCczeITQgj5HH9ZqGeTqsKxPMIcjytPY?=
 =?us-ascii?Q?BInG7sUkzi6nmQYsC45C7qRlP0exhPY79zxNSNZ3Jn8NzspSgKWr+VvPLFLi?=
 =?us-ascii?Q?jtQu3Eb3CuLtdEJPstKBI6GZ3ifZFeBHmUYa+lybCgCSFvINbYVzpeegfN1p?=
 =?us-ascii?Q?f5TRNDpHxBVSsYmjUYhs7TZNfZNpvXOkZknpxKbzx6fdcA+yd95zkJ4Cd3sV?=
 =?us-ascii?Q?smzRbnmT/8GZVLZXwp+EX2D22fMGijGb+ppd0z5aUYb5x3IBLvNUpYvKG0WF?=
 =?us-ascii?Q?pjqePmNsepInzODfTTTlsKp9DvSNfroUlkKKon6tAP926wu3K/mCyb/Y2Fva?=
 =?us-ascii?Q?Aa0ths1F1n5QYe4jSXf/WDaasnREDgvTUjNe4FHD8qRezwZLq2lQJbSlhUNS?=
 =?us-ascii?Q?622HM9TUcq3H0lEco0P5bTJOps9+8XK48vADUwtw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910cfa75-5fe7-43f2-512e-08dd943d1478
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 05:47:01.9548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InHpiPaLVLozSQKlJ1I+MNfexeFBpbdybHFcp/kbBXv6JgE8Jx8iDvfa2nRA2TzreIaqYOAkNKLNXhCtwGLXUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7572

Fix the handling of err_wq_init and err_reg_netdev paths in
enetc4_pf_netdev_create() function.

Fixes: 6c5bafba347b ("net: enetc: add MAC filtering for i.MX95 ENETC PF")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index c16378eb50bc..b3dc1afeefd1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -971,8 +971,9 @@ static int enetc4_pf_netdev_create(struct enetc_si *si)
 	return 0;
 
 err_reg_netdev:
-	enetc4_link_deinit(priv);
+	destroy_workqueue(si->workqueue);
 err_wq_init:
+	enetc4_link_deinit(priv);
 err_link_init:
 	enetc_free_msix(priv);
 err_alloc_msix:
-- 
2.34.1


