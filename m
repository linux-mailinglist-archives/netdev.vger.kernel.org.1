Return-Path: <netdev+bounces-216364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2999B3352C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30C5189ECAE
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE1927605A;
	Mon, 25 Aug 2025 04:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IUei5oKQ"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013020.outbound.protection.outlook.com [40.107.159.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41C024EAB2;
	Mon, 25 Aug 2025 04:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096610; cv=fail; b=epM9B+ybjC2c4PqukK3r1OiQgT1dn2srl0v1NWnoQ1yo1aUFcqCv7IydVzlKsDIBqG9A390fvYVoB9XBDf8pA0xSZMuM2PsHlsEr6zFMZpu3BUSe1ktjU+gmjX6gUiFu0E9LOq9wdYcBZuLfkf7USydMLx4jaItrdiWfKLh1jP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096610; c=relaxed/simple;
	bh=+eL/Nm6j1hcb8rF3gfXMdzBQBQbR4SQLxw5aEIhCNzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=psyNS3b+fYQvlnVDcPpAXFuVmmap6dBWTe3w0mN1iqLgC68yVsKoam7yXt0DuvMfvPuL+I5ijFZhFQs421uKlzugH1/AAP0Ij0k0pgZKQvSc9KRQPK8m6vujLxqFt6CnNe9YjcJu3nYxPORblbIJHOnV7o0xp07jFG5NDJBdoYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IUei5oKQ; arc=fail smtp.client-ip=40.107.159.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYTrQnQ9qBP24BaRQuFz7qZJXHtCwgtKJJyK9Nrbwz8IrAjnI19NEYXe1ujRryXFTHgzP07oexoBD9qwqtyuG5qNeMA3Pa3xGBSHhzjO692NUjwkfZ9u81ZvFoMW/K1wvCy3pBqwlEMRu5LElvexYeglUmurnaiaLqFcXKWT7TM69GhhkXvkl4eexcGHK9wsIQ9OEkUE4s81IZaH4va+/tv6635aVikF8//8Yk6W5vAGO2H5rb/LP/ssObvfbOuN60NlcrYGN36ptFzsEFuHc+irmJLw3sFTiGDdZHBDptz7fbH4KFJQBp+NBOfIhJdUJeV1+YN7mKXXX95lRM7eRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBMkF+boKbT0owI8NmRSpuPaenL3b6ZeliLOIgLVOyg=;
 b=j0krqO4gJbjgwDya8NHL0nHnna4eg8Ak3un9u4hTbxEDpKL6e5AyffTqenVukhpvrjJQoo5LIRhpsdHcMR4ELlMQKwuUoV23jBCNfdU3vmV+uHaAdK7uSe/McBVNegOXlksOqoN2lPuOWSbQI2x8nLwAu+G+AYO/6ZNm36YXPscl1gQ/quh81U+85tYLEjULdXrjeu04H1LYF7ja6Uq5b7uoBdkyaPROntgLDj7neyiGpun/Fbqt1GkO+RmR6aUG1dm+XdfiXIGnUf3yu2PVCfMB5uG+32u+DINIhrq8CtXOIHDZUSTuE6TbO+wV8XU1hLDYGrrlIm4mAHMEQEr2+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBMkF+boKbT0owI8NmRSpuPaenL3b6ZeliLOIgLVOyg=;
 b=IUei5oKQAN0zA8H9ac0pHVO0DgssA9rlKem0whDdjnDvg8ClqphznzKOtl97JBF8isSdSSF+ZWtTQ0nXMnB8iN/087R5mm66o8d56isaWGAQDfGxHxBb4KvP6s/i6yKDiZz3rtDzPlA0ZSCjssDFMQx75/dZt8KKSnPjyt+rHtOXdavUiDJh9gJgXmmEhKLPzrdVZLkuv5DlwUPEpNsBQ0zD4uzEtK4/brOT9OQKpZH227ITM0t5CGsAuIp7li7v14ljIp/S8I/P+UAXemiRKtqZr+Yjohfvf2IBYwqnSHH/eWKVB8nVzR0cekDr+tl5+KuCJK4u6/NL5EBDfSghYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9661.eurprd04.prod.outlook.com (2603:10a6:102:273::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 04:36:43 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 04:36:43 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v5 net-next 03/15] ptp: add helpers to get the phc_index by of_node or dev
Date: Mon, 25 Aug 2025 12:15:20 +0800
Message-Id: <20250825041532.1067315-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825041532.1067315-1-wei.fang@nxp.com>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0d5228-f9bd-4077-17c2-08dde390fd3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8As4pu6wIHnWWa3/avgJJ9qDlf3LFqqGlgwDsn+wiHbILSApqJUK4weZpi/H?=
 =?us-ascii?Q?ip0i/OMIiYKUBl0KhtE1aLxWOgDPx6Hz1wEIuFZP91QSSCNY161WC/zg7ynm?=
 =?us-ascii?Q?s/KSQyvcQJZ9sVz08BpVBV6jLl0k+fd0aCvAsYXAbuFt4CksY0NXxMHEiA8y?=
 =?us-ascii?Q?GBc9TOf+/wvIc1Nk2a/nkhMiNhvVvrlyEQee0RzukbbkUqgsEBAJBZnAkfu1?=
 =?us-ascii?Q?L4EWb/hiUVi7Z1BHC6aQ4almMAeE+rHEmb+/9YJrBC2m9Vp3UEKz7DRmb2r+?=
 =?us-ascii?Q?p8aIs92gbsqkjbbwy+k/EwjfIKESBV68deyyccjllK0H3LuqLjUgpibHGSq+?=
 =?us-ascii?Q?pT8g0WC/jX68tim+YlM9AMrGLckxkn50wFJRGo8bo83z+sVxvt5WYQWGsdZr?=
 =?us-ascii?Q?b7YU4i9SbIVgfs2GA/H9C6ztpSSC3vwRpKsGVIxsmU4JuY+CcPFtcfOkf2eJ?=
 =?us-ascii?Q?GbuNn5L0zgIJlCWrKQCOoMLdVGXgd82wiX2h7Aj5wFr8826lyXy4jXi+cRC4?=
 =?us-ascii?Q?0xHI6vLAgjtq/D7TeMtoB5Fi/0dAfHQg1okCKEDJ8pJqQyFCd6xwHIbaN3Jr?=
 =?us-ascii?Q?zxP96s0Ho8pvsz7lumHim4JzKZRMDB4hgF3ZZw656TXNcLdje6s2+d8Fq+qs?=
 =?us-ascii?Q?fsM+BgsSIbdcBJoYDEXQCEZ6Vq4qda76n8y/FquTvfGf18d+1445zkJdO/a4?=
 =?us-ascii?Q?8HllPxK0+B8917PuZFaMKfjWyDGzEwhVEZ8egCZ9Q3D8h8d488tdDqyGKnJE?=
 =?us-ascii?Q?rgiq3Z1Jb23E9/E493T4nZyjNyrsE2uCqLMSbA+8YWAlokjWcSo8TGdohlG9?=
 =?us-ascii?Q?q37XGZiCKFkdk+uJnbOQ6uO1hdM6N4wUbxe1uimc317vpHN5BBj2O2LY/qjj?=
 =?us-ascii?Q?mnSbeCbTzMnedsG7Z2ejnggIfbkdpthAnS4g0vryH6NWo9QlaN5OawCYI9mr?=
 =?us-ascii?Q?DQz90LUAR8ePQlkMUnzVAx8jKrKyUZsISVLpBiFO2A/W+eQDnAN+wV5juzcx?=
 =?us-ascii?Q?fGOX2fCFcZ/esSBZueW8m3tyb5uJVI6sbpT2E1I5wJeQmwvs3PLSxIzOeqqu?=
 =?us-ascii?Q?JnbevTWVLrxxDP1tIm/wEyA9cSuFt7Fq0G+D6mdvoslmGJjnrmiR7okygwbI?=
 =?us-ascii?Q?cITB+UVHQqQl90mKXogwgXdxX+9XQxs1mmfHrKkys4ZwSOY6GvkAMmHwt1HW?=
 =?us-ascii?Q?0Vg5PfCB20YG9uyBG/xnt07bHid8t/QXL5YQWAONO2wg2nxkvBd5wmCRdcsU?=
 =?us-ascii?Q?6ZTSDmU3txYpDVkgeDikqJgzXHhGA6nN0XDPWlteelZic+kzzw/TMmUcvYHA?=
 =?us-ascii?Q?L+/YsOIAlRMXfR0wYdvBB6JFaSU9WRqeGl7dOmvvV+5F/POtziGoXM7Qdlra?=
 =?us-ascii?Q?HE8gAuSHnaCkgu9l03AQ6oQ0G0zjNUDssKjRLGbUouYUknuSAv/Y5B/tm8TZ?=
 =?us-ascii?Q?tiG7qBTeJjzi4Cwxr9DcqXRtN9kxrgGyyi5B6tWnKyZbiDBDRMTIiv3I0J73?=
 =?us-ascii?Q?Zg+TQooRaUioFIY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JT7VgAF803vwYFStsmm9T8dKwVBrg1Ojm1q61oSYM+WGbtFerv4IQoGUtOv/?=
 =?us-ascii?Q?+CzU+cHUjpgg1UNbGKzcRroK7FLXik8em4AzGNsRuPEpw6Mv6k6mGsu9anIT?=
 =?us-ascii?Q?D1s9Q96LFf/xSQMfkmglikjr6uRIyVAlNfrAKtsDePM7j+DxPtqwis9aSQOO?=
 =?us-ascii?Q?d79U1hNqytm8dxmZsTqR7OWK/ha3khdxHDjHADsNcuhi5C2RpSPiZiPnqoXQ?=
 =?us-ascii?Q?mwRs3qQ8ZBBxhVuv+jrmvCJFDl9pYf4VOktafXjHfyGmKGdIWz4XuzKTRXvr?=
 =?us-ascii?Q?/xIzoQUq7lSXibjX4tPFG4L5r0/DwfpYETkUTf77dxH/CHNtXNfxJjk0sMXI?=
 =?us-ascii?Q?5yPeOzJ3gCxRej0Ev7LQk7fYxJvmd9+HDk5aB9M2yFo7ET6eb7hU0S9SosRj?=
 =?us-ascii?Q?1w+9Y4YP9ter8MY8tv8tlCRuQdnST3U+MuzZdNisGWg6mMMWbYaGAySWgFpo?=
 =?us-ascii?Q?mGEIXxazkKoBFm6wHPl9IjkcdYEMvJEi/TfZG+/JgJQ9flbIKVvvOB2KQ3vC?=
 =?us-ascii?Q?5WLew0h4jpCbu6tFqaYvsJc+qizVOus0bP9Z6SUsrCT2epigSsK33Xg0eHi1?=
 =?us-ascii?Q?C1xUCloyvi5zVT33NMjgCvgRMwHUbWXVBKeUZCpOxT0RVXqvZDAYkXOCVWR6?=
 =?us-ascii?Q?5j/hvrldi2fB8tukTSh+aDW3WHbL+dKS9jiZ2sR5BE1YqyqGqxlMp1GMqjoa?=
 =?us-ascii?Q?byz3I7g9pgSQWdxrghkrNEL2pkIRqw5DenuouY3u5RO4M35sSudGzkxIYim9?=
 =?us-ascii?Q?4+0OtAugo19uOjLBvrIqjlYQ6I/p1IxggTfgfiXrikqa3RX0pUVhWzFiCVrt?=
 =?us-ascii?Q?987xvVR+WMy+9qruzlPy+mGEYTYHfbFq0l1g8Ec9yZAuEhSiTi+T2wjJxAgB?=
 =?us-ascii?Q?oVjDkuvrxaQvLLU4Tokz+Bucco/fvdj6Yj+tgiCi/kwlTFld5dmb5bdJ4GpW?=
 =?us-ascii?Q?hffgV5lSGwesWmpgvBwat14JrI6yCpy7v+f7ajgV+mcKPceE99JRs7VarUMO?=
 =?us-ascii?Q?Khqe8Lvsmovs9o6t58hCY5nU6fgo6SzyGgeGohjf+MJYE8AhUc31ecaPNOi2?=
 =?us-ascii?Q?QzTts2Z9w1jv6D9Aos6bAaEVhU+XxKQJrrv/llSqT+vYVay4jCEG0m0baHYR?=
 =?us-ascii?Q?kyUQHh9MhKIs1EZNnG99UK+rwzLHXRkK4IZtGPwS4p/XCp/bnDE3qDiE2KRG?=
 =?us-ascii?Q?CJRPqhL2FwlNqOU1tlVCqDTYtHYWnBqrslzL8DhS/sTOs+TL93UfMMp4lR+Q?=
 =?us-ascii?Q?gPJcqo/aHR/+oRrr/UX77b51n367R7nynRkcptLkAc/ZUfPl1Bmqx8s1yM3x?=
 =?us-ascii?Q?M4Nn1La/cY0Xqcdtw8eaiAv+V1/uBXkgjHufYVV8Td44tgIhL1ixxivtI2fE?=
 =?us-ascii?Q?h3v/+eayJ0G7lIvB2l2+Ho1/T+8NacnQ3VYWa8DKCtOrUa3oMomEQu1uN0U0?=
 =?us-ascii?Q?bxLMT6FZd+uuoTa+6yH1Xfqy2PjR4XUIqhoLA1TANNXySQMacebQlThfr/ns?=
 =?us-ascii?Q?nZmRijltpJbePh0cLSYVXhloIqwUX0bzrOmbFaQwKLtK3c88s77qLYlq/rXq?=
 =?us-ascii?Q?5oe2pAJ5267kxL4EOk01YeVmdntw8DGduKb8tnBi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0d5228-f9bd-4077-17c2-08dde390fd3b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:36:42.1988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wd6r1e/x0wW2kNhbeLghPnR3K8ayYeuhGatGt37F+nVHFs3jGdmLjFiO4wRKrj/3dZb/CaddlmQkQhpptDoPhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9661

Some Ethernet controllers do not have an integrated PTP timer function.
Instead, the PTP timer is a separated device and provides PTP hardware
clock to the Ethernet controller to use. Therefore, the Ethernet
controller driver needs to obtain the PTP clock's phc_index in its
ethtool_ops::get_ts_info(). Currently, most drivers implement this in
the following ways.

1. The PTP device driver adds a custom API and exports it to the Ethernet
controller driver.
2. The PTP device driver adds private data to its device structure. So
the private data structure needs to be exposed to the Ethernet controller
driver.

When registering the ptp clock, ptp_clock_register() always saves the
ptp_clock pointer to the private data of ptp_clock::dev. Therefore, as
long as ptp_clock::dev is obtained, the phc_index can be obtained. So
the following generic APIs can be added to the ptp driver to obtain the
phc_index.

1. ptp_clock_index_by_dev(): Obtain the phc_index by the device pointer
of the PTP device.
2.ptp_clock_index_by_of_node(): Obtain the phc_index by the of_node
pointer of the PTP device.

Also, we can add another API like ptp_clock_index_by_fwnode() to get the
phc_index by fwnode of PTP device. However, this API is not used in this
patch set, so it is better to add it when needed.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v5 changes:
1. Remove the last paragrah of the commit message in v4, which is not
necessary, and collect Reviewed-by tag
v4 changes:
New patch
---
 drivers/ptp/ptp_clock.c          | 53 ++++++++++++++++++++++++++++++++
 include/linux/ptp_clock_kernel.h | 22 +++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 1cc06b7cb17e..2b0fd62a17ef 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/posix-clock.h>
 #include <linux/pps_kernel.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
@@ -477,6 +478,58 @@ int ptp_clock_index(struct ptp_clock *ptp)
 }
 EXPORT_SYMBOL(ptp_clock_index);
 
+static int ptp_clock_of_node_match(struct device *dev, const void *data)
+{
+	const struct device_node *parent_np = data;
+
+	return (dev->parent && dev_of_node(dev->parent) == parent_np);
+}
+
+int ptp_clock_index_by_of_node(struct device_node *np)
+{
+	struct ptp_clock *ptp;
+	struct device *dev;
+	int phc_index;
+
+	dev = class_find_device(&ptp_class, NULL, np,
+				ptp_clock_of_node_match);
+	if (!dev)
+		return -1;
+
+	ptp = dev_get_drvdata(dev);
+	phc_index = ptp_clock_index(ptp);
+	put_device(dev);
+
+	return phc_index;
+}
+EXPORT_SYMBOL_GPL(ptp_clock_index_by_of_node);
+
+static int ptp_clock_dev_match(struct device *dev, const void *data)
+{
+	const struct device *parent = data;
+
+	return dev->parent == parent;
+}
+
+int ptp_clock_index_by_dev(struct device *parent)
+{
+	struct ptp_clock *ptp;
+	struct device *dev;
+	int phc_index;
+
+	dev = class_find_device(&ptp_class, NULL, parent,
+				ptp_clock_dev_match);
+	if (!dev)
+		return -1;
+
+	ptp = dev_get_drvdata(dev);
+	phc_index = ptp_clock_index(ptp);
+	put_device(dev);
+
+	return phc_index;
+}
+EXPORT_SYMBOL_GPL(ptp_clock_index_by_dev);
+
 int ptp_find_pin(struct ptp_clock *ptp,
 		 enum ptp_pin_function func, unsigned int chan)
 {
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 3d089bd4d5e9..7dd7951b23d5 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -360,6 +360,24 @@ extern void ptp_clock_event(struct ptp_clock *ptp,
 
 extern int ptp_clock_index(struct ptp_clock *ptp);
 
+/**
+ * ptp_clock_index_by_of_node() - obtain the device index of
+ * a PTP clock based on the PTP device of_node
+ *
+ * @np:    The device of_node pointer of the PTP device.
+ * Return: The PHC index on success or -1 on failure.
+ */
+int ptp_clock_index_by_of_node(struct device_node *np);
+
+/**
+ * ptp_clock_index_by_dev() - obtain the device index of
+ * a PTP clock based on the PTP device.
+ *
+ * @parent:    The parent device (PTP device) pointer of the PTP clock.
+ * Return: The PHC index on success or -1 on failure.
+ */
+int ptp_clock_index_by_dev(struct device *parent);
+
 /**
  * ptp_find_pin() - obtain the pin index of a given auxiliary function
  *
@@ -425,6 +443,10 @@ static inline void ptp_clock_event(struct ptp_clock *ptp,
 { }
 static inline int ptp_clock_index(struct ptp_clock *ptp)
 { return -1; }
+static inline int ptp_clock_index_by_of_node(struct device_node *np)
+{ return -1; }
+static inline int ptp_clock_index_by_dev(struct device *parent)
+{ return -1; }
 static inline int ptp_find_pin(struct ptp_clock *ptp,
 			       enum ptp_pin_function func, unsigned int chan)
 { return -1; }
-- 
2.34.1


