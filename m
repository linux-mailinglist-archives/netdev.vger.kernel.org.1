Return-Path: <netdev+bounces-142641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C50A9BFD15
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 04:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA241C21174
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D12A1885BD;
	Thu,  7 Nov 2024 03:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LZOLiRhA"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011006.outbound.protection.outlook.com [52.101.65.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BED1119A;
	Thu,  7 Nov 2024 03:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730951635; cv=fail; b=AHSKIVoSrKnj3dro81Uj7B/WWIsukB70j3J/2GTbVWT2WXwaZuBiIXGMAVJIDK8F2d/TYgCPhkJiZ63+l+t5h5RC9TKQJJKdLA3sTDKYXJmTvForo+7+XQAKEVoMjBP2lv3mpcXVUf0ujA2nbcLKmdtGdvb2OSEWhQBKpy04MKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730951635; c=relaxed/simple;
	bh=/J5/MNopf3E2AZ6qz2vnSDXeiqupNdD/WAcIuau6neQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bUKoh2M2WQn5wt6xy3Rzmn2LdCQIgjcxol57Z0XYVwVFt0LCKYK92pVUoQhLKCf+4R43DFzCK4An7amdBlX7shwW/dz/HRKQ8OTPYP0SuzrrlV5bSaaFDLkpW7TLTDQm+rchkzEHlUNqsIrxZaVxoMMFO7dTcr+c1S+KjBwbMXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LZOLiRhA; arc=fail smtp.client-ip=52.101.65.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAAvMhZbXl6YNl9PIKJ6NRKBrqZ+o7wsFogGgkhZQbcFeR1sOLetAvUCckEAJlnJLWE502mQ4RQHFUTWfLdXhDxWVFd8HJ/OVI/A7L950LkfG5jRC5HivKuACSVwpfIb6JlFxyd003u2LTMaCAqYEbEVhMd4nIS8KapfztukMU45DB2+lz9S58HxjtUxMSer/bELRW/ee+TkC5LduQsF7OnzxfBt2+ggMFMGWhSvP9jlUVj9HN6D36ssBG9OFVDHhq5Tw/cY/SnEls910oiiYRPdJ+zZJyKmvq8kd/8Vks+qHneSSyV3vKP4TfZ2xgbBfTeCV8xVGFX0W/MIEcckjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SAF/wao1tjfOgav6JGbS8bQHXEKbI3ddLCD8NQ9Nbc=;
 b=hLAuU/oNuNKOKJPTRlr2dyQX/o4Qc5Wny/Lv8y22YEQoeSC5O3U64JkLIDpWliJb9mvXgjj6JpFj9PAjYxsHyvNwOlAwVX6v9k1BIfL+5HIJGS/+5zxtRXX51yvvIMv21/+YRxGnZfsR8yk2oHqDJTmtUTTb+LBtoI/QlPSGcBxvO2mHwMq/y2b3HY0wKeFav7CHI0+M81CAeUZpF8YLHByTGl6PDmCp/OSXFtuiBx6jy/2dY+coBZJyG7EdemMfxjdkaOT2dMnwHKhyhmfByq6Kf9aWtTfQ1gGI6vAJKK2k4PnmeSsm1OodAsWCVy3gU28NQp5wsXp77PdyR3e12A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SAF/wao1tjfOgav6JGbS8bQHXEKbI3ddLCD8NQ9Nbc=;
 b=LZOLiRhADBKTd63t4ePXt3IE4iWDwi1en6kU1/Wmf4zFP2sfM/8JpjrPXiLFMEqXr2kMleM5xMZWcwtcGZJJKOr3IPvA6VSTedhhC12a6p4fZGHG9c8gZIDAyRXzj0CQslP/kcznlu0gFusm31I3lnvARXHTKaHvlg9xMakZlT9o3CoqMHYLi3rvvbAH6z1pZSIwKhZOux9Ekpo2gEpdDmyuexh3UMgBUhFceQRsLemxIKBmIpGQAFqZYEOuhDzkbB8io/LGZssrdrfXNRRDJTcTR7RtFUPYCVqkWNR04ItAoV0zFGjoXvSgqbgmuqOX7RT2ZhwWwU/pMqbbzpK+WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7898.eurprd04.prod.outlook.com (2603:10a6:10:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Thu, 7 Nov
 2024 03:53:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 03:53:50 +0000
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
Subject: [PATCH net-next 0/5] Add more feautues for ENETC v4 - round 1
Date: Thu,  7 Nov 2024 11:38:12 +0800
Message-Id: <20241107033817.1654163-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0154.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::34) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d23b03-ada9-4006-d6fe-08dcfedfca1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dFBaQfFNsBS/zoGyjK2yJc1XbNBQqOGq4xMQG6Qa6Ajya3JmoH+ClEsJTjbU?=
 =?us-ascii?Q?vG0wiyVG18Xj2009A18ZulVzWcMpu/RhdEGbRABxjAItMxraIP9xdIIcgQnP?=
 =?us-ascii?Q?pidq2p/e62VMEgKP9CaSg9FxPG5waY4UOa7FVBp+44mEYg+gP4kw6KruMIQ3?=
 =?us-ascii?Q?+JKDmIA0p3U95zRzZNEleW4qokdFOv9S8VberWLo1KLsrP26uicIMC29RFP1?=
 =?us-ascii?Q?G4HLH0c44IF24BNxQyj+GngQP9CEvkAz7BiyZYyab7U6ESa2czGx+yUg+sOQ?=
 =?us-ascii?Q?D+Lyd0i6j97vv7Tyd+JyOpf3MMe2cBRckKcOBDfSAC65A34/KMg7lAY9pyqN?=
 =?us-ascii?Q?OBBjZX6hbH8iB1UEo4GO8WCmYHlxdTESqf95mfW/RTtDxih0ApsTUiVKPaqO?=
 =?us-ascii?Q?cBYpaOwBeEsFeduu+laZfDA5lWNLHGtmY+t8Xlha9hMRwKM9e6+DviEKKwaz?=
 =?us-ascii?Q?i2NEAxRkE0qjv71j5Yuov/BKKiUVXxU+ksArP8gRDpxI+NqVIOeROxtxxcJa?=
 =?us-ascii?Q?J1wswb1aMxNh3ir0uh5H0peklOJYv+NJJ3K8WkseCSKnSnSSpswsKXHJxvCs?=
 =?us-ascii?Q?3bED8QMyR9Xi253k17j4Ty4FJv8rUOGFHFu44tyiVHSyXq6ZQhJ2BkJw11lj?=
 =?us-ascii?Q?LZGxGLAOtLxCijyYbyWGsnfiISYwcEB7dwLv/VjsTVxxzgqQ8gjnqDHq5dCZ?=
 =?us-ascii?Q?WJIRV9er9duGe8fLrtAIhNqx3qj8PfqjLKlSoe1183zMwJ8LxBZfH6RnQTsR?=
 =?us-ascii?Q?+mD3FnilavnEbD2mvLIG9D5TcgaaiTEnHnOIVV3ZrpaeWKthDrlHL8REPYiC?=
 =?us-ascii?Q?pLFufUEkBfLgHxNK/Gij7frhlsX9E9mKjL5/b/b/S77IBvf0kjK8NcemzEd0?=
 =?us-ascii?Q?+OBOm+PkYf/SHzNWYgkFSBruV3WVG1Mx5qBfAdOBCwnOdSHc09Q/FF3Beffi?=
 =?us-ascii?Q?PB9kneIp8MB12ujRXaCzVhcYkVmbSH3YCi7DHM1VG4kxqVKTt9wl48BkTR3T?=
 =?us-ascii?Q?SAhfrQNY6SvsuT1B6U6NvsnHw22rWahtrU6Y7vCBknKeISAOrTY32Yeh4OcN?=
 =?us-ascii?Q?7bJpZSzKsLH4PKA8exPiSozSDchVf7Q3kd5iXfvjUT+hLXbbb7S8D2iTfzG0?=
 =?us-ascii?Q?SNXB2GIpsJiMJTr+n3dxLxvBqU/VTFJ3W6GNyKH1DrrmLQ+duNR/X1uTb2vS?=
 =?us-ascii?Q?vIymdPKAshd999Wx0k0l+K2XxjGV/gLXuHzFIHyuGAJly90kSGo6di9kOMCZ?=
 =?us-ascii?Q?YAXjWIePZy1AprGi62iJFTzOREKksSdi06Ucc48WV6VYfoptQvgJWVdiMlO3?=
 =?us-ascii?Q?6IselkyhZZlHi6YTVsCZuieivsha3jBomYryFD0LH79/bww/UCfw7aelkO/I?=
 =?us-ascii?Q?0p2kapQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tz9RtEwV9Cv/DVZQU3RK6VE/4eRt4b7SSj+DNGdUeurwginHD4fIcH8j5UHa?=
 =?us-ascii?Q?4VT+DkOx/b16Q+E2KiieR9wfZFgWlRGRi3XoOyf/HsDipWXVmwXEaYfyMU5m?=
 =?us-ascii?Q?MQN5Ii2IVI7hOJc3NYk1N6D58wuUF/r0FWYQkSx+P915FsjLnD8btmHd7Ci7?=
 =?us-ascii?Q?Pw+fhjxEqOOTKsle7lyWmhhtWlSQgP1rdpPzKAAi4YswWGtWx+BA4FwZQOlu?=
 =?us-ascii?Q?uaw0YZh+AIJ1TtdxLzlcge2ggltjjb5pSSTS2pKdP7qrSiAOL68r8dXfyl5o?=
 =?us-ascii?Q?rr2LXwjV2k3H/p/7C1poqKM+SVhEBRtRdTjRiSs7XjGuklX9ojj/3u821na0?=
 =?us-ascii?Q?YiwutBaqFoDPtSGz5v3KzqpJnqM6Pf3VkrltSHqbw1gvjJ+I+pASQ957w9tg?=
 =?us-ascii?Q?Ohppmc9alHcCGyaFCyn6iRNqeVU7zTNLYSM4uTTgXzpxTDz1n7IMNglncNhf?=
 =?us-ascii?Q?VMLVBicCQd1M/lvyGCWLahBW/PbLQSkXjHunIkCVP0Hz8arlBaPMGBvSHZM5?=
 =?us-ascii?Q?heiAeddveUc+Z/3h38VwzpkrKz5nrYT8ENhSXNiLjKgeNuIaGy1hEIR9ItX1?=
 =?us-ascii?Q?cFPPe8yZGhq1MKiE67byTAPdgUOsod9FiyXZsRsoPuGDWlvDAPJjzsZgDMyI?=
 =?us-ascii?Q?q3Q28p2Q8TrTNJGExo7/YKUwfAshFp7G/zhDWhkx/H6PIQmqD1K0R6qZTwaD?=
 =?us-ascii?Q?QSdHQ3cFHeQXCb+y5xz8kqcjUF40C3tOi2C9pH/uKWMHGCjQE5lkPm5uW1GN?=
 =?us-ascii?Q?o5G9KN53IO9vdwkPXLIxtroVOpRaIKHpOfIstUDVXq26R7ylPdEjdfYFjbq4?=
 =?us-ascii?Q?FF3Egj80UQqbbxTKjJmxNb+YCFBdvYsV7dDmvUIxaBWTCJXiAxdxbp93XcI3?=
 =?us-ascii?Q?uI+NPcEybTyjyBXuW8PhL/Sxt0jX6lp6/PSES/Dwgf6bGqzGVbJHiyO9C7FS?=
 =?us-ascii?Q?tFFglNqO2CIZRa4gBfcZenkPaqiDPuymQRxmec4+mA/YENLd2iFCkGcYonL0?=
 =?us-ascii?Q?STSn3fYMPL/iMwziumln50ka4wh2jcB/4rD45iUwGmjj7W3zil95D9e0lj3F?=
 =?us-ascii?Q?LJVzJUnKSnVc3hVvzYtaxdwNHqMaOVPhDiy75m3PClttD930xr9XfTq/rK8b?=
 =?us-ascii?Q?iJr5VYkMx+phSa0qbuxZ4wWQLQRkux0sb/0cOj9Wb1VkzqczSmoWR2IWRGvb?=
 =?us-ascii?Q?CDuiC+tRXu0If95eVopj3+cEsJDNU7rXoRzxhcowd6D6MUKz+i/qGM/4sd1p?=
 =?us-ascii?Q?nWJH0sFrB5h6m/RVRyAgoDx0KVcqzQX8n4zfMQsSa5s0fzTUvNlnv1q9xSAT?=
 =?us-ascii?Q?PJA8FwHaFfWDPEcU6qE9+X6B2ikyYCZzUC7c8N8YF+fyfvNNU4ofNDjgtQU0?=
 =?us-ascii?Q?O7De2tCCCR+tJNRCNS7Q8kpHQ9ZfyafssAkfo7Gy4UThcF19jt9wuHIHzG0Y?=
 =?us-ascii?Q?r/MJLf33v18huZgytRxIOzIi1JeGNtPCinbAPZDpFIPvKKMbypueg0O7RTCu?=
 =?us-ascii?Q?cjKgCTnkqf+2NW+EwShNq0Qcr0m5B20FlPWMIMT9JCexi1lAu/FfoOjk8szG?=
 =?us-ascii?Q?65+nJqKg3Flf2+OAZnB5GByDYF+niwYNGVd3AV4X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d23b03-ada9-4006-d6fe-08dcfedfca1d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 03:53:50.5054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lXysbtEPn6MVOjtVVsET6OQtwjmuBHL+n2pLugO9fnfDQ1CSZ4n9R2vCV9KDLZlJsIm8pleIrbtCwNIU0SFlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7898

Compared to ENETC v1 (LS1028A), ENETC v4 (i.MX95) adds more features, and
some features are configured completely differently from v1. In order to
more fully support ENETC v4, these features will be added through several
rounds of patch sets. This round adds these features, such as Tx and Rx
checksum offload, increase maximum chained Tx BD number and Large send
offload (LSO).

Wei Fang (5):
  net: enetc: add Rx checksum offload for i.MX95 ENETC
  net: enetc: add Tx checksum offload for i.MX95 ENETC
  net: enetc: update max chained Tx BD number for i.MX95 ENETC
  net: enetc: add LSO support for i.MX95 ENETC PF
  net: enetc: add UDP segmentation offload support

 drivers/net/ethernet/freescale/enetc/enetc.c  | 345 ++++++++++++++++--
 drivers/net/ethernet/freescale/enetc/enetc.h  |  32 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  31 +-
 .../freescale/enetc/enetc_pf_common.c         |  16 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   7 +-
 6 files changed, 419 insertions(+), 34 deletions(-)

-- 
2.34.1


