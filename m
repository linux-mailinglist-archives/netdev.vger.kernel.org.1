Return-Path: <netdev+bounces-145737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 099889D0982
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 07:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22BB9B20DA3
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 06:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6061474AF;
	Mon, 18 Nov 2024 06:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EeqPnrZJ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CB2146A87;
	Mon, 18 Nov 2024 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731910940; cv=fail; b=rM79ED+HlWYfT0VwDGWONfMuEH/tCC+2NS92b3TevBmr4ZV3V4HO/Z2z8iIxUMshLCmEkoJYrP66qpokJjC9owMvqyl7mFiR+wJ2uOsPO093aTxPnOYSCGZrRt8B44m1BrOM0I1A4h4XDYKVG5vFakut6RhtSaZEYwBrdxYE4VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731910940; c=relaxed/simple;
	bh=3yQvtNC4pDjOHNPYgiWqANElX85WJVcRjylGB0cpq1k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=E/8sfpjnGtQHQcY+vx3Ix/V7dyz+MB/ELffPKmrpiOe8x2J/7RHlPHJWr306fhG+CyKg3B/wHsdY5weFIqZ+3XtHIFrLyysXxhTbP63fWAtudC9ypNKCBDKqmVsEj0iS2Xo35y542FVHOvC/m8HM1hbCz8RxWMJ7KT4AhuMBOwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EeqPnrZJ; arc=fail smtp.client-ip=40.107.105.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwmwZ1zMXRDIPmDep5f5GdEx67kEKZQf+JGoO7uEVPvmtaww+67MnTF4No7h+wLfuIcJ/UV/fjVA/GJURONKtEXhzPl/QSA51U5eYDUskrXe8fkogVkjRGoK67gBnSQKE+9H5pIU6hnzp3tReijnwH7434EUbvuyklyQK3OrmR2BfJjU2SaiCjPQ6NUD57o3rqRasj3NJQ3CRRyw6ZtbgddqEPp7PRHH4q1g2VG9hSJZnmNz/15HkUrgVhfLPA+t02iDSAcBXeZwi96yt7tkVU6+5ncFgA1BAMjUk7MMrADW//+uXB19qm+JEd+Rn/Tq8ieWhtiQscyLTx7IeEYwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4w5c+Y/R38Dcan9fRUng+pei+Z8H94X+tQFUhkBwKM=;
 b=BH84Mnr7Suu4kb4Seyg/HsfWTaSjzlsEdFDclF1PuImZG2ukFKHK7HgEn7gV+JKCtSm/WUpSrR4FIkJ1WNEmJvLGyWFxSTsSa43uLlB+5dJao6KbKiIRzxDlFRZ4tnWGybR5s7HnwPSDXBGi/INTeDQRnB0eOBWWY2HUddZ1OUW2Oht9ES6etXPExF7olrZ6YtJV42tnyaUUz0DoUDyJw47dkwLEGt/4P/zQw/wTl0XgMA5DRdleRX1NTRBsFBjtO2gnqK0oiG/x4Wu2j+p1i7W5JfyYYqe6pMuR/TxbAlE/XqNxvsB/OLQRk7l5XHXNXmEOFaMP9kBRNWpVBBJsXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4w5c+Y/R38Dcan9fRUng+pei+Z8H94X+tQFUhkBwKM=;
 b=EeqPnrZJEuZgKDU0MmBA8pCHzUppvRmqUHX2IzzGYwbEt9UnKx7CAVincz1pUXoaijBCrRA73gdGFQbFF6eSeyKjoJAv4sAldsFTqOLVuzqlsJyXwPraaFTvE2esei4ChjN9Sbo+GcWaB4P6t3ZeSj661xZzrMfr0aXx9Yz31qJHOQYU7lJVDV6uf9wGlFIZRT6ehXqUi8qJCUws9/juCOhSOijSJ2RO6UwlD8NgHK0KV03fsEog+a5Hluc66gEMZTpEQRAuNtnNOZu30Su+gl8hOcZQJy//n4X/q/HkUBFkbnOKZtpK8DNzWCioz35IWiioJutCU7m6HqPY//193w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB9739.eurprd04.prod.outlook.com (2603:10a6:800:1df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 06:22:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 06:22:13 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net-next 0/5] Add more feautues for ENETC v4 - round 1
Date: Mon, 18 Nov 2024 14:06:25 +0800
Message-Id: <20241118060630.1956134-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI1PR04MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d71185-ef80-4924-e751-08dd07995759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XMhGFYWvf4YYt5Wt+hZDlw+8frLnleg9/KK7M89Im0OUgkpe4p7dNdLpRtcC?=
 =?us-ascii?Q?x5IZICJJvBgMt4VEVHObaEf9BtN24cZdB4fhR11XicP0cVVdSL7AJCJjaVQ/?=
 =?us-ascii?Q?+Fu4iOU9o4oUszGKxJgjYdSRIlwk4OIMeIyDAgUY3nnF2ft2nxrm5Gs1Qp9s?=
 =?us-ascii?Q?IJm+JvFXEIB/nxcDhsVnQ8e/g3tQA1tFDvUiC/67ZvZHNyB1Rquw3lQW856J?=
 =?us-ascii?Q?thZfXGxDguwO/NOcxEAw8ZRteC0yroGAG0rJYoILsaDr7kYTSmpzGB3mEGyI?=
 =?us-ascii?Q?HDwTTzoBQeIQPB4vfvIhfLLhEgf/MoW6utR800g1TrC0MUl7RB/GL2LX7qJA?=
 =?us-ascii?Q?58FMtdIyEAwlotdueaOXnbu6vnShA0sVU0qiv+UaSlB+j/ZnocEvlqlEFeB6?=
 =?us-ascii?Q?tMBjDViPoIoWQi2IOfxECVHEIFvE8Xr2HuNwrLBvh8rSQYIwBuOl1jNSrJcV?=
 =?us-ascii?Q?Li/rZKN7IzF3it/IuP+4pr+Q9yjGuvTdqV7EXFMe36Mv84ablgN5xsDkS8L/?=
 =?us-ascii?Q?zwmfREBl1NgCxQYxxnTmgWnWcNHLLbSDoSGO+j6npmhyJhbdbqLvHou6z/N6?=
 =?us-ascii?Q?uBH3e7gYkENHrkZ+5/w7C5/Sp+Vn7b4kd+GCpZSVN8/awYg0gDRiEdpEShkY?=
 =?us-ascii?Q?+C1rF5Zh+RnKCVXZY48lR2gjJgAEfEDEdnL5bZmVcHDc6D2/MpOFKNcuiyk4?=
 =?us-ascii?Q?MU36OCI6fv8z/MuPi0WaW6TnhRzy8BM4CMETcAleYcGTqr9l17zfZgGSHCq5?=
 =?us-ascii?Q?N10k4iKQ+dzUgIUYBb4SdQqs3HeHixT+8Wunq2SHh6Ay55Pqj4swaLJW0ZAV?=
 =?us-ascii?Q?kwRuhsQlUTcZCYBI20JVC0KFmbjcA/mpQVc1nDeVAGPZGGOrmArvPQ8aUanf?=
 =?us-ascii?Q?y5TpS3ZOFBbmDQZllqoXeL6XDkT8WiY7LpbKdhEaB2kZS7mgX2cNK0vSqP1P?=
 =?us-ascii?Q?DtojZvB9aWCBEJYMNR6xO3kcH6oU6LpOAJTCuoMuCxjwKDoHUFpX451TlWAn?=
 =?us-ascii?Q?jH+eGAJyyrapp+M0ozR6g6XS/1U5jfRqCmEcZqNJ5UC6rh1NXsKc3pDuMnjI?=
 =?us-ascii?Q?men2iPlxKyJ3O9mQpLYzzQ3IYq67jSTlTCWfndq91h0EzpstlspUMYx+9Za3?=
 =?us-ascii?Q?aZEE3cIpmZyjnMHMkjoFjsb1AqmQyUTdAKSPeAV+uwFfng3gNB/kTscE2Q8n?=
 =?us-ascii?Q?GaAkS3dmIjgxffLJMH+jWdlRIA4IThvRykEDPl8+jRM/A5c54++ndzFrKUvA?=
 =?us-ascii?Q?iZBD/6MScVqbNYg80W2vFII2q+74mYwjxnKFiQE5tzgWHLk6lnRbI+iV9ta0?=
 =?us-ascii?Q?yq04mgbKcZ9V5KE20nNz5cwcELJUuNCS0cT/Rm0au3nufkrN+xoQcxoqDU9K?=
 =?us-ascii?Q?R1d+n2A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K4i1IluKOb56qrGw4F0i8bE26hIf3PZ8D4rnYNn15cVkL/4hmy6GZvFfNXyD?=
 =?us-ascii?Q?3n0DkeE/BPRIxcii5H9XwleCtCdG1Alb+FHYfwhYsVltYj5K3iPY/hW92iTk?=
 =?us-ascii?Q?cTlnN0QBzc/F5f0k1Gdy8X/a+79LUXYPgxcCshwvHfulme6pDB2jUM7b5Oki?=
 =?us-ascii?Q?Vxbh88vKH6uiCHomaCgl13DfMtsLpEJbeVS+vz3GULh5WOHwNj/tbXf/M4gC?=
 =?us-ascii?Q?SRARbbm6qn6BWW5NLijJV4ETonT8IrkBJEPK7zdgyXhDPkO0o7DjFz3qVQFy?=
 =?us-ascii?Q?3oFPJ17ouI7yZhH91u6ToomGMgJWiP6T9W+x2ECZaLnWWPrX6DIplZ6ehMO/?=
 =?us-ascii?Q?TXeqfssSlSrG4maqgskKjyY9CjYLBi9eArADdiapQJjAPMdRbCCjBxVzkicd?=
 =?us-ascii?Q?00f4grb+RVmf9No9gEIYEnXo4Sp/077mNFPQBjIcJesOIstjn36Q+Vs2vQYa?=
 =?us-ascii?Q?pjddxwf7uzj1FUsmiISR4VHL/IOu/m5wcMrNzci8neMzuYyd8lxJ77ywwjrr?=
 =?us-ascii?Q?JYgJcw77g2TP3U0VK7mERczXzZT1TxZRBsy0wiabXehVm2uVUdgQIWWGkKuS?=
 =?us-ascii?Q?cqE/5TbdSqNlL+K4e2XgguAA91XGV7TurR/IG0xx0bGOnytghCrw4+YC1scK?=
 =?us-ascii?Q?qgzb6LQh1dk30BJqxsIQvvBVViw754pOaGNXWe1sYJeULq50bAlE+lmmReic?=
 =?us-ascii?Q?3VKU0U0rLzccC3UQ0bQ6IO7jQGIY90atEQMRTBugc1yruBVWeU4JVSXnBMth?=
 =?us-ascii?Q?8vxceyPteJlPI7r/FdzQ14/w4XbZuYF6k0tDuqIeUXxxVMd6rwpVZdW3segN?=
 =?us-ascii?Q?kBUiPHTxnylXTEPpL4SPLLgrBUKO5E6BIYnS34r8nBXyg/osymDeDra9krw/?=
 =?us-ascii?Q?q+BE6YA/mmZ8DePlDWGjuZVp3th2mwVNGkw4SH6nIygx4YqVxTSZxeQOBNaG?=
 =?us-ascii?Q?7unmAGOHBbNyk28onM8hBMvfF8uBUbeGlkJVtVFnpglx6GyA7d3l4WEbf2hu?=
 =?us-ascii?Q?ySnLxla1GNs2+kk9rESXUyYZSQJUFXXe3wfycKY/XQ/4QH4KKuLm/o4gNkGu?=
 =?us-ascii?Q?jzj7utpS+5adECFZ2OGgwzTkvsEeq0Kv8of66vM0J+Tzu1aEK+1fHXP6rmFM?=
 =?us-ascii?Q?sfbWQIL8FBDrhw73ChxlD4aI8GEcfuXBzoGjHtAVVYkvxJbDyFdPGJ7SYTHE?=
 =?us-ascii?Q?qgQ8IooBiov/csSFFf1tSpgb4wpdyBUfWUdAi1I3Nn4+dOzmsEu477IjJwbL?=
 =?us-ascii?Q?K6OHoQdiQeY3/j1IcDMgNkxbUiMPpJS1kJTMUA2JNtaJ2A2NhRjw9w+svfWw?=
 =?us-ascii?Q?ThfCc76tU6hhnKHYN4kaWyZP6bO49DQMgvOpdlLADDM5jRLObVx9gqk1vph/?=
 =?us-ascii?Q?o1gVuvR/r4Xh0/dLhJG71oEwle1lBGWw03HYuUaWkoaeZx/Uiyv1MHB9l/T6?=
 =?us-ascii?Q?pmBFHLlH1z2HRo5hDJF6ywjCk8QxN/ccZ1+wyDUeiAeYpkG6f9RY5/NAgNHV?=
 =?us-ascii?Q?2LCEyUwYc+KjM3tIsz6ihw+qEatu8fb63KqeMxfGHpzl8TOg9WL3MWO8JkVl?=
 =?us-ascii?Q?91cUQRYlzUTKem+/933ZinDUoV69GbVq3MtVbhq5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d71185-ef80-4924-e751-08dd07995759
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 06:22:13.7061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxHyxj9I8Xsw9Hh/DR6SHvQRbn3UBVfoG4uIXpLeyrWwYnTn5McjeB4rPVrgz2yYEWekr8pXvfz/K9bdCcNxEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9739

Compared to ENETC v1 (LS1028A), ENETC v4 (i.MX95) adds more features, and
some features are configured completely differently from v1. In order to
more fully support ENETC v4, these features will be added through several
rounds of patch sets. This round adds these features, such as Tx and Rx
checksum offload, increase maximum chained Tx BD number and Large send
offload (LSO).

---
v1 Link: https://lore.kernel.org/imx/20241107033817.1654163-1-wei.fang@nxp.com/
v2 Link: https://lore.kernel.org/imx/20241111015216.1804534-1-wei.fang@nxp.com/
v3 Link: https://lore.kernel.org/imx/20241112091447.1850899-1-wei.fang@nxp.com/
v4 Link: https://lore.kernel.org/imx/20241115024744.1903377-1-wei.fang@nxp.com/
---

Wei Fang (5):
  net: enetc: add Rx checksum offload for i.MX95 ENETC
  net: enetc: add Tx checksum offload for i.MX95 ENETC
  net: enetc: update max chained Tx BD number for i.MX95 ENETC
  net: enetc: add LSO support for i.MX95 ENETC PF
  net: enetc: add UDP segmentation offload support

 drivers/net/ethernet/freescale/enetc/enetc.c  | 340 ++++++++++++++++--
 drivers/net/ethernet/freescale/enetc/enetc.h  |  32 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  31 +-
 .../freescale/enetc/enetc_pf_common.c         |  16 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   7 +-
 6 files changed, 414 insertions(+), 34 deletions(-)

-- 
2.34.1


