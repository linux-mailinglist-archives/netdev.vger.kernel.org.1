Return-Path: <netdev+bounces-199713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D18CAE18AF
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E793A95A9
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8B128466C;
	Fri, 20 Jun 2025 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FrjWTgEy"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D955825EFBD;
	Fri, 20 Jun 2025 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750414764; cv=fail; b=tzKulsPgPVspNHlDMfBcAnwk2nEXZkF5lmAAiDkdXP3S6wJz/B/sv1+6Qpl4vg3CMYrs+sCnEOiaNFBAEqJpokUXNRT5cl7FIvGWUkz+9j01hrEBbIrqkxwfHmNdN0fbXMk9AAQEgUniS2v/uRId188ODeCRiULvZQv5itbDqjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750414764; c=relaxed/simple;
	bh=CzsGgwCgKHDAanvNHG9lM9rO29ooU2fcUgWWwnzSNPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QQptI9R6TUI/WBempnMlmDJ+DcTtguy0bpLU4byuD0SuAX4BR/K/q9VvnXOr+UP5oE+JnZmu/khmbwSjCQN2fwp0U5R1TuvmBxwqbSeqlcb373XbnPn+mIeFAGbNU/GnatBXE1IigONKzYO4NwxrMtVwE5kF3PjunqMPqFQPJCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FrjWTgEy; arc=fail smtp.client-ip=52.101.70.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hY5u7vywtZA57VRDJkMj7n2p+FRaPr0ktdY/LiB8joe741TCY3kbnJBWLJDafRxblLeTprnT2lE16uM6EjtNkiq8lEfZfZLYxitNaAvGM7k6KdNlNSjmxTYaZKIbXMZ4LjGtCF6oeCPkFOCQcB9tyP44KoywMP3AwInemZU7Yu14IEE2B8n/yUy8/RyKKk+txuRUbtM1GrKKySHcfiz2GDDIHwXhfmLxmqzeNQ7PttqYOX6vXqfD5y56gzkrtUurkcGJUUqqqksE0e4HUmahrfZvnUlCENR07Qb23HjK4HOnZW9xMrQlYbf9DIlH+spcWdcBKVoeWq4DlwT14BwbgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ik68rvNQPlFtvv8O9zTTjhTI1iHVr5pJwEbptNZtx0Y=;
 b=Pz5THrBJiPPDhLGeQoeXTOOL/1AEVCPNT8Tlw7A1xmntJPTbbFkRbEignLx1NtlzftPwtT4q1Hqgb2GYGSaLgjyixy2gR2R9ElQrVpOLhUgn/jusYPC1bQP5qRswKA6w2OBpXPEpxoCgtg49+IfvfqzDBdSdLa55hCDfWjyzWdZ5UGbWvoagr4ePPdTZ9rjbob0vEGJRWwiT0ZDGgUuBwHyexSTf+GxVwse0z8qedMoDBuXmwG81yhjFEalXMIOhZSoAGr/RbNXjBAEOfJL1O8lqFRq5NWnyrBiajmmJkSX55nGgSwFJPim56MI6schyyxu4O87nGqgmRJXgbqzjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik68rvNQPlFtvv8O9zTTjhTI1iHVr5pJwEbptNZtx0Y=;
 b=FrjWTgEyvXWv3X9dhn6xqUjJvTdrzWkVQd+NrOB04rneBW2iRj1r8Hdwg7aUfpoXMo7EeM0yFJlkjfQy5IQ6Kj8z4ufJYOqNKX6lPPmSff4aHev4ZQD6/2l6jmGDD8IuRAK7u1l1r6P3lST+bphtmfpUBC4iq2XpzVXErlVoe8Er0vG0wOspO9DDGR6VqpvHFlBCZ7ss6XE6GalobaLMUY6BBrlznfKAjRAynG+PYY6FYUTH4dw4YDioJay5ivCkfT/YTdzuLpGqD7nz0WkaVWOGfopLjy9YiQpvpU4ZZ2WKWdev88iESBbCDOzYhk6P5GIP+xCcTAYOnZC2qtKmEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU0PR04MB11258.eurprd04.prod.outlook.com (2603:10a6:10:5dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 10:19:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8857.016; Fri, 20 Jun 2025
 10:19:21 +0000
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
Subject: [PATCH net-next 1/3] net: enetc: change the statistics of ring to unsigned long type
Date: Fri, 20 Jun 2025 18:21:38 +0800
Message-Id: <20250620102140.2020008-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620102140.2020008-1-wei.fang@nxp.com>
References: <20250620102140.2020008-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::20) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU0PR04MB11258:EE_
X-MS-Office365-Filtering-Correlation-Id: bd928018-8aed-4339-af1e-08ddafe3ec26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GnFhUNWiYo/I8kRa5Wf2mqqXgNXNYFoOq38x9ckwQ9LnOwklvzLzBpH6HAkU?=
 =?us-ascii?Q?nF7gYSUsFf7Dr/TD9fT0SHn7ptarKb/KKMBvXVxe1foWD579TuJiGV0BRRMA?=
 =?us-ascii?Q?C1DG18AVRBVSniM/QA8MXFHUoQLIKHUWR32K7JogW/EP/AVXUkm6mTMjjDVj?=
 =?us-ascii?Q?G3uX3pjn9VYDtXjXCeFgFv0jLvgzy7ljgZ6OsONKbq6S46hrQ8dFj0JShe+U?=
 =?us-ascii?Q?q9C0t3GQrLDu9FN+aI4X/v+fI0hFo1ws6XlG9+tpqlLNSq3gvXGNTe4ewUU3?=
 =?us-ascii?Q?FMIZJxHU84rd88QnTa/H/JcjCKcWfezou0o2cCVu07LA5gisyrlMYZWJCmZc?=
 =?us-ascii?Q?xXgRxtbPTssEhBRnOQagkVqvNm2yQVTvKvnnMmtcwlCK2ZIPrPkgDjlU58Gy?=
 =?us-ascii?Q?tkpFFMc19NvQVT//77FnloyiSxoO5cNOJ2HelqwCIRjtonoA9Ad+3XIk1zQe?=
 =?us-ascii?Q?k4bM4ONa7Y4wziJh0Chl6wvJvHZzU8cDLZU68cnVsRd9AuZuETC8m9bF711m?=
 =?us-ascii?Q?GsHYiLXU5+Zbls7eJa7tp0UF7my5kJIisw5Zsv9O2nSM3W3/igJvH6wa8IL9?=
 =?us-ascii?Q?/hFsCH1/WGkIOyFR5rdUbZH9P4Box1qTyy1n+jH82oOJsCZqcjjt8u7NPgT4?=
 =?us-ascii?Q?8RPV6YY421czaMn5XG+ZDRR+sAMU2Cc/FCPYSbeQYxkXZggu2Dk7bAfnWMTv?=
 =?us-ascii?Q?dHhK5dUvwyCrR//RYWNN4JB/rOrTRG1IYaaeObA9LKkdKPhQGJF21/nzT0nA?=
 =?us-ascii?Q?+YEmaLJtXvzd/ICfclTICtW4hDzjfReWMwJ5x4qIPBWU+8tArBYQcQnACYxT?=
 =?us-ascii?Q?OaKx0YXUJefNzJuWr/fZInA3/bm2o8XH3cr4wHsFUGRy8M7oBPsIQXXaCTQ8?=
 =?us-ascii?Q?QRxFX4Mpp4+hBbTPWqmBqtiXovsoOsxDi/8Vd2yNUySQVRiWY9xfHncQK5Lx?=
 =?us-ascii?Q?o0RaJx1CJHPjNPGIt/Oiiez7Su2TI5lUJWy96Pet02ac+DyJK9eFUaV4EWVq?=
 =?us-ascii?Q?TTiYNiKUjNojpfN3/c9HtOyRbsMS6kFLHKiFzPz/L/5Nsly0dX6aAgMOQlep?=
 =?us-ascii?Q?GJgDxtRjWQmxaTPo2/tXi3m+8SMYCXiEeC7X35eSnQVQAgppL2eBdlqquWMA?=
 =?us-ascii?Q?73hxM/vPwMRvN+Er4/EGyWG0l/eZvK3F6cvuQgL0Iy8ULtp18YF5YfJP+Bx7?=
 =?us-ascii?Q?NuKqTT6Bxv0MMh7/wF3Hh3TXZEKfXnowY5XWjYB7nUVfCtgCdRgv0+fYCny2?=
 =?us-ascii?Q?/x6oksfLL2G69ocKp8/BeWT/c5TaKuwrZDkJZX8Ob9KZcrOMrT1dc961rFje?=
 =?us-ascii?Q?z0GG8gA85UctGtMbMWkp4bHnYPB1/yg43oO8G14D8gdwNtFhlY9puCkE0jl5?=
 =?us-ascii?Q?9ga9P7mhPDZHuZKT1qGOTS+kN6Ts9Q1gsy1XYEFUk4yxrG9gz/h1yuM8/Vez?=
 =?us-ascii?Q?T8K6JDP2joNiyIW+Ya5lZjmk9CBQqAVu5/WDonV4Obi5ZqyeNfMolQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kGHlUJh7ShQ8Jw4OqlC3NWSVgVBfCTXdnMN6/ZEroffLzRpf8jL34BVdoxf8?=
 =?us-ascii?Q?9tORszEsvr+eydkF/0oSS2HkfD2HCh2gQ7ge80uDwsQ1YhDoHo1LuqhFiUD8?=
 =?us-ascii?Q?WtdwQg+IhFFdIMetcptHfSZns6Q63CjJk/1osXRBygxhLEKoYAsD0Q81KmB2?=
 =?us-ascii?Q?ISXng4zLCQS6Cz6JfAb1fA9QrCkQtsahdlk3T3yte4LIbTOxCFgpUj2pB/Xz?=
 =?us-ascii?Q?v77+6yJUxKjUJxH18XJBPJ+i52qf0hw3XixvGj6lcAG0dKYMS84AaQtXkoPx?=
 =?us-ascii?Q?idwFxsn/twS/nmceRmaonvbixkmBozn7JmDrEH53MA6JROhqN/r8LQ1L5zyI?=
 =?us-ascii?Q?w3F9KBws2ZqHYEvGtIVVMSyPzpds9sfheDXbzWDHUdutnTZRwl6BYt+WkSzH?=
 =?us-ascii?Q?Zhjc2rkAq9uDt/ZlTK0nY7K0I6n7CJmDuJo0G4gfhpQSULkJYf0PPRAaHUl1?=
 =?us-ascii?Q?ebF0ZQ5h882a34PFccgwtdEpmyhNC/xvPlbor9/bCX5coUwTd0UJRGadOcU6?=
 =?us-ascii?Q?g+zsJCZOY+pbPMdzdx8Ea9b4a3k2ctTV79jMZZuIErnk/soNuxuhm3Ep65CE?=
 =?us-ascii?Q?HwWw/CqD49B5TSiSlIwerkqWXECTVvIITt8XkZEwgxRmb+wnRiozQcy0fz3P?=
 =?us-ascii?Q?7YV1kqGSiob6j3fPuuod4MxWkKCWm4KS60AHbt633KPME9iV0O4QVoja+wpB?=
 =?us-ascii?Q?u2WPeqG168UnVuvqMaPEe3fHh2QFAHlxwjmpf2BPsh63m1RDVvN5CDYprMii?=
 =?us-ascii?Q?sfrNgWd0LqmzYq8ipnQ+85lZBpi1ydNdqKIc4FbMq3APpjWtY5UwAD06trzS?=
 =?us-ascii?Q?j9ucMtVpd6JIb7sOpuxTmtodJUqSpCB58DL+80iqKjfvc1Yl0AXCPzS4aqXE?=
 =?us-ascii?Q?R2Sk1w7wCEtDN+xy5mNFz3fkOyF0lF57GvSpVNyvPvJ1uQvMD73BfpwNJgQA?=
 =?us-ascii?Q?kHs4WZ6KYoxx1DcQ7L/fFscOpP4+GzhAC8+9bHhybtkSIVW8bLnOm9aS2gPD?=
 =?us-ascii?Q?IcDoCeeoSx2s3sPAaNWVR2AH18SY9Dv1UCNaeTsc74A1ux65ZSNFk0yvK6dL?=
 =?us-ascii?Q?iXcbH9fbTPncRwmCinh51m8TKln8Htp5gKzZklc6AoewoPmrLOPfEbGh1dI0?=
 =?us-ascii?Q?iu40Jce0BxS7Bb+ne5ncHLacQJvcYpCT1OyRPlG5nSsgIpL+vf/7ORdA+fKp?=
 =?us-ascii?Q?PM8IjkgGPzG+e1ZMTGW5M/nkvlcEaOxs5mPqBjv4UmduBUDq2MNJB55BmYsj?=
 =?us-ascii?Q?RF7Zo8N3Ake8Ayf0NNoDBfVRv8HfzuxFmmNNGKmSDz5/O09VgUTBPAg9nAx4?=
 =?us-ascii?Q?jGp0U0Y4Um1SI4lwDaxSx8zUGrpRIUZVfrv8d6ahHblgyV8wXYdsNRuLhDwa?=
 =?us-ascii?Q?wILIE6mh6CnvCjylfoxwfOFu4639IRjFOe4/Ko01B5iIvinoZccywwaP8Mbk?=
 =?us-ascii?Q?Zwnq7ZJMX2FVCZrsiNhU+DZKuH353q/LK2UFa+EX69pUzaIgDl1N6FA1meXV?=
 =?us-ascii?Q?aOLVc4UEv/WPdgkfJnntUHp/lobP9rCQN8HtYpyVWCZkQAfSE+imnu7Uk7SC?=
 =?us-ascii?Q?merBsGx13nALrXSUlkYIBqXzTJjIlFrtGi76af9A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd928018-8aed-4339-af1e-08ddafe3ec26
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 10:19:21.3518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBZ5j9rdU609r7CBQHeXE/vj06THpdbQd0OnSyQI5c/yNh1AxdcT6PD2wpPlg0uLVyZ/JF3L8IEGKRPRbS3hiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB11258

The statistics of the ring are all unsigned int type, so the statistics
will overflow quickly under heavy traffic. In addition, the statistics
of struct net_device_stats are obtained from struct enetc_ring_stats,
but the statistics of net_device_stats are all unsigned long type.
Considering these two factors, the statistics of enetc_ring_stats are
all changed to unsigned long type.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 872d2cbd088b..62e8ee4d2f04 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -96,17 +96,17 @@ struct enetc_rx_swbd {
 #define ENETC_TXBDS_MAX_NEEDED(x)	ENETC_TXBDS_NEEDED((x) + 1)
 
 struct enetc_ring_stats {
-	unsigned int packets;
-	unsigned int bytes;
-	unsigned int rx_alloc_errs;
-	unsigned int xdp_drops;
-	unsigned int xdp_tx;
-	unsigned int xdp_tx_drops;
-	unsigned int xdp_redirect;
-	unsigned int xdp_redirect_failures;
-	unsigned int recycles;
-	unsigned int recycle_failures;
-	unsigned int win_drop;
+	unsigned long packets;
+	unsigned long bytes;
+	unsigned long rx_alloc_errs;
+	unsigned long xdp_drops;
+	unsigned long xdp_tx;
+	unsigned long xdp_tx_drops;
+	unsigned long xdp_redirect;
+	unsigned long xdp_redirect_failures;
+	unsigned long recycles;
+	unsigned long recycle_failures;
+	unsigned long win_drop;
 };
 
 struct enetc_xdp_data {
-- 
2.34.1


