Return-Path: <netdev+bounces-149419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D459E58F5
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81E0285875
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E87B21A453;
	Thu,  5 Dec 2024 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MG2l2TiQ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97052217F50
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410535; cv=fail; b=amXzUH5XLwg/chqVcnAa9Aqdef9WkYRhxIggqnpuBgz/nAM9G20E6w+ug328v/HdNHb2azY3ZtiAjOhnYZ9wGC52QxtAaFK5rJXvnY5UulJbAG1oIsHBQlyEsutjs0RyUIgRIdb5GvejjGAZ6tRrbOgNqSN+EWuBt6ZCqMeQTt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410535; c=relaxed/simple;
	bh=GALEKpKwEsYGan7snQkwqwMfl9ovw7xOr/qdnWRdzm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TIBXgIdVcpSJjnLaILBbSOdD8e7TIz0ma57KDpKTRcgEzep9SispxsicyGkXJuQSWFjrtdhg9meaIULpJh4cfmuUugV2bJiUV4OT+D0U7aHkbKRZv+eiqVlrrVgIpcEA5On9jlAm+bZuWzlenxiIm/Mvt+6IXpoEZ3Bbuc7AYiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MG2l2TiQ; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPBNOvyFIDI2MV0EBg918UJB7qYM6diU3nIu3LXfwrVrGg0/Bz2FA/YG4FIja9xHT7ZbElhARsd8Va61Si9X/Ohmh8hQdgXkAtftx2ZgQbqkDtgDySGHz4mDd/mZLzKrZaBhK1N1wPKpjqNmWQLbbrBnZCGVsBgExWbSYn8wCEUQGRVE5x2YF9x97BzXv57lSDBK0VG0HHCM2tcX55T2t0++NdbpOvgtc13acak7BmRCsYsY0M6pIuAaJqiyENLz3/uH69PKRq2FFgb5E4V6mJdfwo7WtZp4TzCLDuJZnKsmCvILyh8k0OhgjQP7MvlubJ8AM2nTxyPYdIluYb5M6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yvCW7F9dhXq+p2GMji4rTcGjvnAHO0gk8DKOUmj/zc=;
 b=zWVAFHulWwkfAJPB4QtMTiYLv1T9YxstJvUDEa4I+iXFwwQmcAJ7vEe5NA7hi02hfu0xijw/0I8ygz2/NLay45QMEVcmVzmm4wJMzr8Fn+J7aYyMpxDHAH8CzG/9BGFTsYpPDYvWDYvAnitdP5wJr5Q8mZNV9c5ysoAZWKLEEUq/xM5usHgXsX6UPFUTyxKNX4tT0712T/4xB3Im42eN9RM4V2t1xu1J+GWEFRROfvs0BghVQ9neNomDfJCYePuGGg9bM1fxKEkEsaiCUy6dvTqWRfQDynvhFc31HxcGy81c49adFJDWcNKjUf7ly9HavZDRyfojvtgiEsoM/IEXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yvCW7F9dhXq+p2GMji4rTcGjvnAHO0gk8DKOUmj/zc=;
 b=MG2l2TiQnSnu5ILO/eVcYn6TOw/4QtL1qW7NgMm8CK60uu1CrX6Bp8s5z4qAyTJ5YeQ2LD/FTbCvDp62gCo8fa0xYPvjIrFFA05mG5ASeyzac0ajdm5rODf/KL2Bno1kMCZlwV5idU5iS2BDEzxgOH1v1g1QOgw/x8cL+0PE2Rda4nuSI+K6WBrrNDQpP+nN/IdAocI0B1QnV9WXZsYt4PI/dt78Vv3ATomjWB/kH53JwSwnBypAIjsTpAOBO93AsFZVcvgD1FFjQizzBMxthcEaobxJ3eB4PnTAkl4TSf3EHLrDPcgU1+tVN57NsL3Y7wfgJVj8uZrw3t/6bg652w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10443.eurprd04.prod.outlook.com (2603:10a6:102:450::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 14:55:30 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 14:55:30 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Yangbo Lu <yangbo.lu@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v2 net 1/5] net: mscc: ocelot: fix memory leak on ocelot_port_add_txtstamp_skb()
Date: Thu,  5 Dec 2024 16:55:15 +0200
Message-ID: <20241205145519.1236778-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205145519.1236778-1-vladimir.oltean@nxp.com>
References: <20241205145519.1236778-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0118.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::47) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10443:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3794fb-9664-4193-d7a0-08dd153cdc61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?joyetNA1b8T7j022hMVulq3ggn4hDVn02RtkUI23E3Puq0eCQPXmWU0VeZGf?=
 =?us-ascii?Q?WPVNXR4U1VuC21WlYtV89mWFOY58J8+iiRQEl/f1BPtP8O5ZOsK4LYjCP3yb?=
 =?us-ascii?Q?KtDl+mEDBvExQd54GvK8Z9hfH/+II0h4UE1wV8sD04Ee82Lvz51IHMH/p+JY?=
 =?us-ascii?Q?GymQ9kii22F2979vo4j+JBVVjh7isgi8sGKgt6HCt6LRUeeXaGi9IqRHvq0M?=
 =?us-ascii?Q?KVJ7FtTi2e5qudWFPFI3ZD95tNRx4jU9KCQ1P8+nb5HY2CtKyAgl/q6rryym?=
 =?us-ascii?Q?mHPCS8MElPMS5rkMHDau1TJ50/sWYDLaO9F6KQuRXXIadX56+bOZUIRvAC5M?=
 =?us-ascii?Q?l2OVlm7xh/QvykajcVo5dIhZJn7p167+uYCPSahfIyV36GycBnJCJiM2Nvy5?=
 =?us-ascii?Q?rQO6ZpJkQ8A6DnkyNyYCb/3mfbCbyxcPGwF2MC2kKgKYn5KN/GYCls4z5I0o?=
 =?us-ascii?Q?Nslzgbi3CjD/Xb7R/Iw7rvekVf3PZlbLV75rD1OVwDdtbMJQs6Y7SOFSIoCp?=
 =?us-ascii?Q?vbqc+7UsDOlg1gFdnEOX/p1FKua+sY0mcHC7tgM71F9sCRBrzS3CbspjkZax?=
 =?us-ascii?Q?lHrsDzK/NmMeTNePLxif5xRyKIL88SexoJCpC/eg1iCIaRlVb4Kz1oQtK9uQ?=
 =?us-ascii?Q?ZxA8xx6spDttTBlzCXqySNro4pURwuFZM2698ahQhntkj4Rj6YhzIc6LxBMb?=
 =?us-ascii?Q?ENEW8qggAsNdCc75Hz0MprkEva0OoeVBIMJ7zBpH35KwUvwPSJRa0rbbOOl7?=
 =?us-ascii?Q?rzNfMGrswZv2H9JtyL+TC82V6za9O57rZd+Dk/54n2P70kPm1J4leL+tm1fd?=
 =?us-ascii?Q?aUfglk+lPxmzheiXtX/+WnpqyJHn4/8Ekz1eXiYn2vYKEAZG6xeA8SiBalP8?=
 =?us-ascii?Q?OMbxU+/Wl8lZwtEivdLKJMLSp/dOFo+sYhws5tn6MOBrhazu0sC/7XtPhCzF?=
 =?us-ascii?Q?1UbMWSM5dUvWinm7UZb6FwD8NMqHSfE6iMLNYjYAtz3unyfBsXKyEjPEnP7x?=
 =?us-ascii?Q?IoJcCGGxZxEkmWRKSk3QYHEs13GO6/8tB0p55HjYptCRsj+mJS8O9cpodGID?=
 =?us-ascii?Q?iWzq1uPQX2YvCDgoeIrE/GFQN2gkzlKZhmbpTbldXD6FR8gHjAOlqdwLINrK?=
 =?us-ascii?Q?k9Gw4kE4YAQrCqByIJyJ7ZE2Ly9KujsYoRsMAugvtJiI5fz6ni4sJrTMuJeY?=
 =?us-ascii?Q?MgLYOWEakM/kmubswxmP0bs1yuIy/et18MLq4DgD6oZ3wMwdXIggBq1xUdea?=
 =?us-ascii?Q?OqGdcrDOWVeNKk8g5qrmINMY4Q/9baIAfHZZVzvvdjCpy9Xt0B5YDuQTevEk?=
 =?us-ascii?Q?xb26T41QORLXNka9n5YA3ayniQRaiOcwejFqPVwXtyJxePqilxIAYSSL33Mz?=
 =?us-ascii?Q?Mu/ST0R1qY33Elmcgb8GCmDye1KhdmIzSQ6SoskJXFP6kIyRMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3xh68YRWmt33b79P1BS5SsTzINGjaUEMii27QQ5u/jBC6OsJDrekOtcuj1Yg?=
 =?us-ascii?Q?88rqWjjQMUXcKb/9Z+cW4YYH/4lrv4UlAJFbiPXVeTVVfpjJO/GBSX2EBfhP?=
 =?us-ascii?Q?kUh4vxl30EedIyLeqc05p3Ctf+PugdFM/Nt+f1ZHyk3EPCfQ9JjmJzSNZeSS?=
 =?us-ascii?Q?txBizW9cXgmq5oyAh3CrlOjLl2NYqvpc40xtuykv/seMzQkNZL7i0KGywVrp?=
 =?us-ascii?Q?7Kuzu5QMKavwEVmKVbgH7LJUcKSwkBui5tox/chBkVy6QX2dbT7BvkyBMAlp?=
 =?us-ascii?Q?7dkuDb8lVLXlJEse1EC7Y2lz54Z0qsS15HkuUQNt/IP165NNpax7ulDZsm+p?=
 =?us-ascii?Q?Tss3BgS/9tKrTPhrgFD8oSJ1zHm25D208Ui0zmdFElVNakGtlyDUXVe//JFI?=
 =?us-ascii?Q?HGCnQTnXNkajvFiIzKd4QZ6dY+Zuiw7OzvkJ/QLnxoe/MJWL7CQ1LRRnZD+R?=
 =?us-ascii?Q?r4L78MM9QDQld7AJM/6/ydxSPemefjrCTFVt4On0XpN7xRy4T+Cw/8Wzv7yP?=
 =?us-ascii?Q?BsAd2V5s9FU6duTFuL1oqg5xiWJTKLnEUfq95shEwtdRqAnSY8K3q+JRtVuo?=
 =?us-ascii?Q?GvtF+9TqeqcnZlgYWeZeLYbnapnIMxrXh88PKdz3DV6yjAL3W+kyXynykBTu?=
 =?us-ascii?Q?8oziDcsvSSDZGEPzEEZNyCnaaCaeXRkgLo+cGwi8kM1vbPHOBOAGRFNJHtQV?=
 =?us-ascii?Q?JeCJCweORtWsoEshZZW3T8mul7ahbgVNERWYmlfhI6YXnQTyVBcWHJ65r5bo?=
 =?us-ascii?Q?h0/IbxI+cqRHtJQZTW//QpJxx/vvli2mRe48pK3xSmwB42TT8VPUkzm0gBuV?=
 =?us-ascii?Q?70Dqg9zWcsAU4IyeYx4gDK3CtHOztup8j249U4v3W+O6etTb+hWGix8iXIYj?=
 =?us-ascii?Q?O8zBYaZHs4r42Ma3bRz7prS1OzCtJQZkFB7pzfoT1g+hl1SYZ9qpFKDNi31O?=
 =?us-ascii?Q?LlOcrGVLw4Owe03xH+nEv/EDY2ewdMdTnsg80ETPwNw+HwbRzgvwJUhCZlE3?=
 =?us-ascii?Q?IKntMFGQiv3wOUGHhlYys884hpS5VwPdQ9rPeZGtRkJsSPrk+je4s2wloj3A?=
 =?us-ascii?Q?xMrd7hfT71yzDrWI+aCXPEUz9oJIpU23OwR1JZhJArGLC3nSbpJYgZvrEfC5?=
 =?us-ascii?Q?wBedvxGVqIppgra/iTOZSPa9VxC5b0Gy1s2HoS6WlNdZ+vkG9chQol4LshH1?=
 =?us-ascii?Q?sn4bSDwuQUIFUGcMEie4xQ2I0kxIwdgCNdkCI5iTrFh4V8MLWWsHOJZCKhyF?=
 =?us-ascii?Q?fK3h33FINT6092H7v2rgueeXVZRZEOFA27gk/Jk8FOGh2/XwuizOhERgYMX9?=
 =?us-ascii?Q?B26gKedAEQy6ho2DiKUCk7Qk5XBDGqfZu7laFtRYNifFDTEuBAckFHhF22Mz?=
 =?us-ascii?Q?1iRnyLujK5wh5i2h+EinR57885BPogTEj6TlUop6IoLLo1W6C+nz7/i6uDtF?=
 =?us-ascii?Q?wBg+zZVZ7trelG6cRNpnvIkOXzQpAkUYh9jKocovu8K8MFPwSQiGEBAy4OVG?=
 =?us-ascii?Q?bbIZcdm9EFns/iUFLSbuaDouGXwf6B/i367r80b9RUR77iWfoNCmCdvBuTFW?=
 =?us-ascii?Q?ruKlh2tDU3wkV8gOCtKMPAq1BctRBmQY2u/lkd3pKr68X2RlVfnovY4dB4lP?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3794fb-9664-4193-d7a0-08dd153cdc61
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 14:55:29.8898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9JvzNdbzkV7QIwqV0G6nMKsbmaBGtkApXIKE8rtNgFOvvS34mAaL0v78x7syBHWMJ5WJ6GdSLaMy1NEQMX93w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10443

If ocelot_port_add_txtstamp_skb() fails, for example due to a full PTP
timestamp FIFO, we must undo the skb_clone_sk() call with kfree_skb().
Otherwise, the reference to the skb clone is lost.

Fixes: 52849bcf0029 ("net: mscc: ocelot: avoid overflowing the PTP timestamp FIFO")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/mscc/ocelot_ptp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index e172638b0601..db00a51a7430 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -688,8 +688,10 @@ int ocelot_port_txtstamp_request(struct ocelot *ocelot, int port,
 			return -ENOMEM;
 
 		err = ocelot_port_add_txtstamp_skb(ocelot, port, *clone);
-		if (err)
+		if (err) {
+			kfree_skb(*clone);
 			return err;
+		}
 
 		OCELOT_SKB_CB(skb)->ptp_cmd = ptp_cmd;
 		OCELOT_SKB_CB(*clone)->ptp_class = ptp_class;
-- 
2.43.0


