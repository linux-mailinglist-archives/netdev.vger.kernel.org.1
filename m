Return-Path: <netdev+bounces-168457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CD4A3F10F
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E2017A8B4
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D325F2046BE;
	Fri, 21 Feb 2025 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QsZU0E4a"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C09204591
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131667; cv=fail; b=uaX9CjUo+lVeeN8Qnzon691US9Yf/0vFmEPmfl0MDyA9vkS0JVA8n8Iiy+dgLv14u2RwfbCMQVzQQ+UBi/S/Yc8KUGNWBFAl4uAF6Pul2cqiE4xuPv6CRztSSI1yLo84H+/iBJX+81gd3ouI7MjXIDXV3QSTxDTyvgx8JsYgBUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131667; c=relaxed/simple;
	bh=oPRjPMy9WJOOJFZ/G8jPTBZkTwdoTUJwNdUpS7FLeGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eaeQNpz4OzqdTqpimkVUkaA84jJEmk1GJOUClzKhhce8jqT4yg4W5QL0Z+nv+xBfpT3FVAl29QG9338pWz+yIvZaNnxQgibYtiwcm7YPsB3vRa+1wmh5xybnLkvrn4i7rQWb9u9xkDkn376Rly9Ni3NQGkhxF6Ttjp6hV+oSpQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QsZU0E4a; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKhu5bui478yMfEh79jBmiAkGnrmluTZe5yNSzOxAYwmq3S2N4tdLTg8Xsks99ORVTaKFOhjBEYOQzz792eCfUMYKDcsmaD1IYBjbLSQWu7uDhjzChnsX280bNG/abVyGE7gLo+/teuLNeN3zjJXlqQvpSevylVxGxi0EII3rCsBlNnyMs2+LamC4ZTa6GYmVelx0KQYsZaN1gBYEtU+OywkHQxZt2AgQGzTaTZnv9MJRjKJDIYbFBaorbIywzPMyLN9An6ZGf7UN282BV8ajcQZby6wMLkflY/51zKF+1TGlVrbbCXI9IJHq2AlFYTeWq2w7v/PcisKNiNWfTFUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efobVYfaGfbj6+WJweZxAjXW84+7bgbJF9/LsFuTHjI=;
 b=kb6IN1NJ8azKrO+LtSKbiMibSOOltfbNLEuqmlEUhtohxgjTrExm+JIAOrLeaBHe/nyAsVoBn6Td62XxrVO29mjT4VTIvqFuk1wE1MvyBvulvrafslc/bnuwGvrWk4tmc9JMHFN1fPe9Hh3Q3njflmO5mlepqdI1tpjqYhWdoYbQNB+Wa+85RRcJvyCgBWpSPJolio7sevse/QHhEQ2YYtpX8qgGxD6ZpTPJG+JTgbwaFiFGkpov7DZl58nKSxIpBtQ3sC7YstRFsRHspS6AHcNNkFfNm7YwfNCYezwYhuaa9hsrH4QZVsBl09atAZSa0PQ5hRM1zoY1PnJyKGvgYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efobVYfaGfbj6+WJweZxAjXW84+7bgbJF9/LsFuTHjI=;
 b=QsZU0E4asQcYdaC07cJPdKgKY3pH49VfQJfeeSivpilGuRicmiVbgfWXKsO6Br7VdVxKCAkFpm4wwVofQmjzv2rXiGgy3JimgtcygYDqVmtjqJkseq39tbNZRoIBfHChe06PC76T6jeRcCO1jzKPScbV6GC+QV3z4FrPbKlL/NkxQiY+fWOkKPdkYKVEBh16migy9Vpuw9W2IDADO5yeO0ioIzEQaGVp3sr1yguckkNkuWwPqe/PU92BN8bSRu3/K1BhRX0E+Pz0O99KVm5vVYTR+dO06414Gzg3RN17IqEReoAhWiGE5E2F8q8iebem5QSOOTHoMpHmSjJgL8Zkkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:54:22 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:54:22 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v26 19/20] net/mlx5e: NVMEoTCP, data-path for DDP+DDGST offload
Date: Fri, 21 Feb 2025 09:52:24 +0000
Message-Id: <20250221095225.2159-20-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0028.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::19) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd786e7-b0f9-4271-8531-08dd525db792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SpVwdDTMVueQzAqd+0sg7ztYAm+0PSYvsDuQM+1tXppunZ1ZLtz4iMvVpOAT?=
 =?us-ascii?Q?K3j8gNBvxEhYdQ92QqKUSx7Pj8lyb3JE1Pafs0INFowQKUjFt3FGJJuxo/nU?=
 =?us-ascii?Q?3d2TSiDLxWUzCF0R+9tLMw3JOZm4JWn9OdqaDXSLrEuG+lGhz/Tn36joMXzE?=
 =?us-ascii?Q?kxQigrRI2rozZwnS1TllZH7PMtzAUUTyqp9TdQ3oYImTd41B8nXo0OQ92ZOB?=
 =?us-ascii?Q?/FdWzQNc60xNfoRuMCltrYDRDOwDImRlSWQuYDSzC2l6fD7HyaEQZOh86WxO?=
 =?us-ascii?Q?CIFKd4beq93AMUVu7G3U3bseZMEtcxAUWPKTK2ETGqBvSlmgsf2yK5lafrxE?=
 =?us-ascii?Q?XPUpQRONBwFiPpNaoy3DOSFOQmIJbArS5X5EuD6wT4OE4i70dVP/gE4c2NVu?=
 =?us-ascii?Q?IuEplzPm3KrYYXIFCRXswEoeYB+OGmzgRCYsSgcfJbJ8Q8hWh8a1YoIDoQnO?=
 =?us-ascii?Q?Ijzd8F/Edf3a6a/OlU5sgVmlalVYG4s0baRzJQye8feruNL7YosgAn2qkL3O?=
 =?us-ascii?Q?wk8kT29XYBZIsy+7vOD1IkbFPcXIWjqjU58qpit+4/AYVLwSfaZFvmlgMZnf?=
 =?us-ascii?Q?PVfoqUjoWTyk30u8Do2I+H1HHvDUSZwzcU3HG7LBFLmk3FvvUoXo+CzcmYXs?=
 =?us-ascii?Q?lugP2tw47chphm8/SccDo+wILzJ/Qgw9QoISVp9N5+BjgcooU5Erolp8cMsm?=
 =?us-ascii?Q?8NrI/ocjDkSmYZvzRMdQ45c24CSwirdDP6yziwi++W8vTXVOC1oUo+xEC+FO?=
 =?us-ascii?Q?rUGmP1FqXjHksFx+uiJxsvT1+eF3gIJIgYnX9PcM2LwWFPOJiU936MTnQ+pH?=
 =?us-ascii?Q?vKHjmxca2S1nNVfJmpyGiiq6jDoUyx9Y4x5M8knuucCNIb7L6H5cK6A5MHhN?=
 =?us-ascii?Q?VuC9+2EzoY9u9G0SsvR24Ig3nyV9C3KgVGIdLSVPFMfaM2V0ByfK7kqEhYGm?=
 =?us-ascii?Q?yhu8wdI7YBJUgAF84F/ptUto9GvP1gd7dHcGK4tIHfbVOAEUIcXIBIp1Lx15?=
 =?us-ascii?Q?oh4FDC0Ewk6Np0Z+ZvRz77wJJvRdCv4QXT1WI+OkJrVLmJCs7TIY4SY38mGI?=
 =?us-ascii?Q?PuYZ3FWKQ4Vo13daoWy3YRS8MwwFuJzv8KS904gMNlvGgkRg8YQBYNTcvSfW?=
 =?us-ascii?Q?V4bunykmvPQ3Mkjf6xZWSVS34FULd0ecmaTrrAtdOeGUdZoFx5VjU/MhLgGt?=
 =?us-ascii?Q?Y3JviHevTOfjxQ63NlkF0uP0VSYYulWXCYj/fnPpP21pWcEbgSTWL4WhaKnQ?=
 =?us-ascii?Q?ZgOji9g8p6L9p5rs2DJfuHVk2Ap7pqkHV/KjaKL90xeDVDAtLDtAs/QM0nL/?=
 =?us-ascii?Q?g4vtguq/B5MfPLmvd4+44rjobIQ56uwlAXB0gdSuRKfcYjipYqGmvgLYft6+?=
 =?us-ascii?Q?yKoAPti4rxy4pE5AgFnrsqWyUF0k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BhwYQ6U2tYLlTSlqbkxYcwPnVNyAuWq2Hfi7Qd1s0Yf2FPMrXjZrh9Q0uSA9?=
 =?us-ascii?Q?AMs6j8LXXSE2ANYIEx5bAWdukQOsMxxA8YqSSNdzyS7JMXr7dxijila+6xiS?=
 =?us-ascii?Q?Bzkl8RIYgdIKf2neS0R5L8+2Ytq0EHGLMOG9lmyLBNK1ZhE97bxeMAHJbjJD?=
 =?us-ascii?Q?iCzwV4JDRzzod7L+XByJ5/y+fwAPGf+A6SZQhBZvm0ldwVn4mF8C9926wWUf?=
 =?us-ascii?Q?sbycrC0Ee9jtOwHl5LhxvD5TESpounlSgDWpvpuXNbI/c/9tInIG8htVq1B1?=
 =?us-ascii?Q?2k3asZi7Q9T4GNRXeOYoY8WhaJCuXIJ1T4Ww95dxJ1bhapPN1iGjzLtkMTT7?=
 =?us-ascii?Q?wbNZqTtjE2lfN0ghhju8QfBxUhrr9ltHyd8Sr337a0G9KraElURt2hpQq5zQ?=
 =?us-ascii?Q?qqo8xTGkVJbaEF1JEf9rdDHYlGvv8gqOV80WKC68Brt762ZK/inTh2SkG+2t?=
 =?us-ascii?Q?bfBaDPonHoRcKvXXvMZlnCQV3aFIbx0l+LYQaV47MS32CYECsj2eHJAq2jK/?=
 =?us-ascii?Q?KrR8g6fEuMUAuWSVaURzw2nBlo9GsV/a4gQ8aR/9JlPQLjhKevt6dOncInk3?=
 =?us-ascii?Q?CfvyDNFA9311nD6GMzjqRuKr3fzVtMs0zW89XwiAgQGQCfdhEacC8d6Y103F?=
 =?us-ascii?Q?hu9lNf302VMpwChfaIwc9+MVFXqHnwvsEDZpSzMJrrrSzBWryzhUS7MBy38h?=
 =?us-ascii?Q?W1H06hXNclMpsJ5e8/0pW7YF/6XVhFUsYUE4DK3jQKCU5cK6JejwT8UzuUMD?=
 =?us-ascii?Q?FJy9kUFV7TN7hz++x88kaRpmS7cs3f+hd89VTzlg+07e4ApEpdJdedOhlJtG?=
 =?us-ascii?Q?7blr9B/bbY5//dHX1Vd8+2zh4uk5Tv9Rp4WQ49/gwk9APtddDcbXOVsWUxXf?=
 =?us-ascii?Q?ZMbKmPOItrFIYBQJeNr7Q9yYlLJPSLykhIbyXzJmnXyjOtpz2RPVJytWlDu4?=
 =?us-ascii?Q?6a4e3Iw9E6nhJNd1+7M80myA8zPiaZYBXYOS2u+77n5fUOlZgUMvOy2QrcfC?=
 =?us-ascii?Q?9352Y1Xx1AnzfjhYSbWSrGmheDV5vIOA9KAk1ZZ5jD34STO6fZ0qVxLrZBIB?=
 =?us-ascii?Q?tNqdaXJS+ehMxIfzk8HJr+tOLwRx99mFpWwO27JLr/2Exmgxmv3r2qp11QfN?=
 =?us-ascii?Q?pqJNvfgYjnhpJ15iTAoj3xgufDW450mlu1QSJBBvEn28yEJq5ZzaIpCymoAU?=
 =?us-ascii?Q?Es1EyMn8tg57uzjLuP5XAerxA2Kxyr3QnG2TQOMSDVW39opPvt7+liLDf1+/?=
 =?us-ascii?Q?oF0Bem0seP65yW2uL829ffBPRfc0TMGkAXOmdQTWaanFO+G5JAc1705jn3dS?=
 =?us-ascii?Q?1ITvqvhOvvKaOZc744woQ5MPRM5SyFlwn5a7F3I6F8n6aWQbP1jdczoMnrIc?=
 =?us-ascii?Q?CvNBupEho7laxV8EYf+lQdI28DO7EABobANRgIGfgGqguc8QTJlhV+W/3xFt?=
 =?us-ascii?Q?uBQS12Q7pgFekfv53k+lJ0Kw2dJyB62QCJbBGz6tLQNIHk4vsIH/9MHBlkPH?=
 =?us-ascii?Q?NDhF74aE/xbinFEpEruSXygQDLvs5Y4HH6hLp4cktbKp1Qw5txPanwQcFECO?=
 =?us-ascii?Q?clqUEBtdjic6DQKh1Ty8FnuhHJ3F3esc0ETXbeht?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd786e7-b0f9-4271-8531-08dd525db792
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:54:22.3597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jf2HJbW73qmG4vuhBqXV3AFJd1ZjttvTvSDbCMOw2ozFutAgiPeBFfeVbRYhx9WXV4mVCTfAyYpwNcbg6BCWvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127

From: Ben Ben-Ishay <benishay@nvidia.com>

This patch implements the data-path for direct data placement (DDP)
and DDGST offloads. NVMEoTCP DDP constructs an SKB from each CQE, while
pointing at NVME destination buffers. In turn, this enables the offload,
as the NVMe-TCP layer will skip the copy when src == dst.

Additionally, this patch adds support for DDGST (CRC32) offload.
HW will report DDGST offload only if it has not encountered an error
in the received packet. We pass this indication in skb->ulp_crc
up the stack to NVMe-TCP to skip computing the DDGST if all
corresponding SKBs were verified by HW.

This patch also handles context resynchronization requests made by
NIC HW. The resync request is passed to the NVMe-TCP layer
to be handled at a later point in time.

Finally, we also use the skb->no_condense bit to avoid skb_condense.
This is critical as every SKB that uses DDP has a hole that fits
perfectly with skb_condense's policy, but filling this hole is
counter-productive as the data there already resides in its
destination buffer.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   6 +
 .../mlx5/core/en_accel/nvmeotcp_rxtx.c        | 346 ++++++++++++++++++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.h        |  37 ++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  44 ++-
 5 files changed, 420 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 084dedd57f1d..9ec405964a6d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -110,7 +110,7 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
-mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o
+mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o en_accel/nvmeotcp_rxtx.o
 
 #
 # SW Steering
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 2589686438c0..656a64303813 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -582,4 +582,10 @@ static inline struct mlx5e_mpw_info *mlx5e_get_mpw_info(struct mlx5e_rq *rq, int
 
 	return (struct mlx5e_mpw_info *)((char *)rq->mpwqe.info + array_size(i, isz));
 }
+
+static inline struct mlx5e_wqe_frag_info *get_frag(struct mlx5e_rq *rq, u16 ix)
+{
+	return &rq->wqe.frags[ix << rq->wqe.info.log_num_frags];
+}
+
 #endif
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
new file mode 100644
index 000000000000..f9e63923a142
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.
+
+#include <linux/skbuff_ref.h>
+#include "en_accel/nvmeotcp_rxtx.h"
+#include <linux/mlx5/mlx5_ifc.h>
+#include "en/txrx.h"
+
+#define MLX5E_TC_FLOW_ID_MASK  0x00ffffff
+
+static struct mlx5e_frag_page *mlx5e_get_frag(struct mlx5e_rq *rq,
+					      struct mlx5_cqe64 *cqe)
+{
+	struct mlx5e_frag_page *fp;
+
+	if (rq->wq_type == MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ) {
+		u16 wqe_id         = be16_to_cpu(cqe->wqe_id);
+		u16 stride_ix      = mpwrq_get_cqe_stride_index(cqe);
+		u32 wqe_offset     = stride_ix << rq->mpwqe.log_stride_sz;
+		u32 page_idx       = wqe_offset >> rq->mpwqe.page_shift;
+		struct mlx5e_mpw_info *wi = mlx5e_get_mpw_info(rq, wqe_id);
+		union mlx5e_alloc_units *au = &wi->alloc_units;
+
+		fp = &au->frag_pages[page_idx];
+	} else {
+		/* Legacy */
+		struct mlx5_wq_cyc *wq = &rq->wqe.wq;
+		u16 ci = mlx5_wq_cyc_ctr2ix(wq, be16_to_cpu(cqe->wqe_counter));
+		struct mlx5e_wqe_frag_info *wi = get_frag(rq, ci);
+
+		fp = wi->frag_page;
+	}
+
+	return fp;
+}
+
+static void nvmeotcp_update_resync(struct mlx5e_nvmeotcp_queue *queue,
+				   struct mlx5e_cqe128 *cqe128)
+{
+	const struct ulp_ddp_ulp_ops *ulp_ops;
+	u32 seq;
+
+	seq = be32_to_cpu(cqe128->resync_tcp_sn);
+	ulp_ops = inet_csk(queue->sk)->icsk_ulp_ddp_ops;
+	if (ulp_ops && ulp_ops->resync_request)
+		ulp_ops->resync_request(queue->sk, seq, ULP_DDP_RESYNC_PENDING);
+}
+
+static void mlx5e_nvmeotcp_advance_sgl_iter(struct mlx5e_nvmeotcp_queue *queue)
+{
+	struct mlx5e_nvmeotcp_queue_entry *nqe = &queue->ccid_table[queue->ccid];
+
+	queue->ccoff += nqe->sgl[queue->ccsglidx].length;
+	queue->ccoff_inner = 0;
+	queue->ccsglidx++;
+}
+
+static inline void
+mlx5e_nvmeotcp_add_skb_frag(struct net_device *netdev, struct sk_buff *skb,
+			    struct mlx5e_nvmeotcp_queue *queue,
+			    struct mlx5e_nvmeotcp_queue_entry *nqe, u32 fragsz)
+{
+	dma_sync_single_for_cpu(&netdev->dev,
+				nqe->sgl[queue->ccsglidx].offset + queue->ccoff_inner,
+				fragsz, DMA_FROM_DEVICE);
+
+	page_ref_inc(compound_head(sg_page(&nqe->sgl[queue->ccsglidx])));
+
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+			sg_page(&nqe->sgl[queue->ccsglidx]),
+			nqe->sgl[queue->ccsglidx].offset + queue->ccoff_inner,
+			fragsz,
+			fragsz);
+}
+
+static inline void
+mlx5_nvmeotcp_add_tail_nonlinear(struct sk_buff *skb, skb_frag_t *org_frags,
+				 int org_nr_frags, int frag_index)
+{
+	while (org_nr_frags != frag_index) {
+		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+				skb_frag_page(&org_frags[frag_index]),
+				skb_frag_off(&org_frags[frag_index]),
+				skb_frag_size(&org_frags[frag_index]),
+				skb_frag_size(&org_frags[frag_index]));
+		frag_index++;
+	}
+}
+
+static void
+mlx5_nvmeotcp_add_tail(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe,
+		       struct mlx5e_nvmeotcp_queue *queue, struct sk_buff *skb,
+		       int offset, int len)
+{
+	struct mlx5e_frag_page *frag_page = mlx5e_get_frag(rq, cqe);
+
+	frag_page->frags++;
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+			virt_to_page(skb->data), offset, len, len);
+}
+
+static void mlx5_nvmeotcp_trim_nonlinear(struct sk_buff *skb, skb_frag_t *org_frags,
+					 int *frag_index, int remaining)
+{
+	unsigned int frag_size;
+	int nr_frags;
+
+	/* skip @remaining bytes in frags */
+	*frag_index = 0;
+	while (remaining) {
+		frag_size = skb_frag_size(&skb_shinfo(skb)->frags[*frag_index]);
+		if (frag_size > remaining) {
+			skb_frag_off_add(&skb_shinfo(skb)->frags[*frag_index],
+					 remaining);
+			skb_frag_size_sub(&skb_shinfo(skb)->frags[*frag_index],
+					  remaining);
+			remaining = 0;
+		} else {
+			remaining -= frag_size;
+			skb_frag_unref(skb, *frag_index);
+			*frag_index += 1;
+		}
+	}
+
+	/* save original frags for the tail and unref */
+	nr_frags = skb_shinfo(skb)->nr_frags;
+	memcpy(&org_frags[*frag_index], &skb_shinfo(skb)->frags[*frag_index],
+	       (nr_frags - *frag_index) * sizeof(skb_frag_t));
+
+	/* remove frags from skb */
+	skb_shinfo(skb)->nr_frags = 0;
+	skb->len -= skb->data_len;
+	skb->truesize -= skb->data_len;
+	skb->data_len = 0;
+}
+
+static bool
+mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq, struct sk_buff *skb,
+					struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{
+	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
+	struct net_device *netdev = rq->netdev;
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_nvmeotcp_queue_entry *nqe;
+	skb_frag_t org_frags[MAX_SKB_FRAGS];
+	struct mlx5e_nvmeotcp_queue *queue;
+	int org_nr_frags, frag_index;
+	struct mlx5e_cqe128 *cqe128;
+	u32 queue_id;
+
+	queue_id = (be32_to_cpu(cqe->sop_drop_qpn) & MLX5E_TC_FLOW_ID_MASK);
+	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
+	if (unlikely(!queue)) {
+		dev_kfree_skb_any(skb);
+		return false;
+	}
+
+	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
+	if (cqe_is_nvmeotcp_resync(cqe)) {
+		nvmeotcp_update_resync(queue, cqe128);
+		mlx5e_nvmeotcp_put_queue(queue);
+		return true;
+	}
+
+	/* If a resync occurred in the previous cqe,
+	 * the current cqe.crcvalid bit may not be valid,
+	 * so we will treat it as 0
+	 */
+	if (unlikely(queue->after_resync_cqe) && cqe_is_nvmeotcp_crcvalid(cqe)) {
+		skb->ulp_crc = 0;
+		queue->after_resync_cqe = 0;
+	} else {
+		if (queue->crc_rx)
+			skb->ulp_crc = cqe_is_nvmeotcp_crcvalid(cqe);
+	}
+
+	skb->no_condense = cqe_is_nvmeotcp_zc(cqe);
+	if (!cqe_is_nvmeotcp_zc(cqe)) {
+		mlx5e_nvmeotcp_put_queue(queue);
+		return true;
+	}
+
+	/* cc ddp from cqe */
+	ccid	= be16_to_cpu(cqe128->ccid);
+	ccoff	= be32_to_cpu(cqe128->ccoff);
+	cclen	= be16_to_cpu(cqe128->cclen);
+	hlen	= be16_to_cpu(cqe128->hlen);
+
+	/* carve a hole in the skb for DDP data */
+	org_nr_frags = skb_shinfo(skb)->nr_frags;
+	mlx5_nvmeotcp_trim_nonlinear(skb, org_frags, &frag_index, cclen);
+	nqe = &queue->ccid_table[ccid];
+
+	/* packet starts new ccid? */
+	if (queue->ccid != ccid || queue->ccid_gen != nqe->ccid_gen) {
+		queue->ccid = ccid;
+		queue->ccoff = 0;
+		queue->ccoff_inner = 0;
+		queue->ccsglidx = 0;
+		queue->ccid_gen = nqe->ccid_gen;
+	}
+
+	/* skip inside cc until the ccoff in the cqe */
+	while (queue->ccoff + queue->ccoff_inner < ccoff) {
+		remaining = nqe->sgl[queue->ccsglidx].length - queue->ccoff_inner;
+		fragsz = min_t(off_t, remaining,
+			       ccoff - (queue->ccoff + queue->ccoff_inner));
+
+		if (fragsz == remaining)
+			mlx5e_nvmeotcp_advance_sgl_iter(queue);
+		else
+			queue->ccoff_inner += fragsz;
+	}
+
+	/* adjust the skb according to the cqe cc */
+	while (to_copy < cclen) {
+		remaining = nqe->sgl[queue->ccsglidx].length - queue->ccoff_inner;
+		fragsz = min_t(int, remaining, cclen - to_copy);
+
+		mlx5e_nvmeotcp_add_skb_frag(netdev, skb, queue, nqe, fragsz);
+		to_copy += fragsz;
+		if (fragsz == remaining)
+			mlx5e_nvmeotcp_advance_sgl_iter(queue);
+		else
+			queue->ccoff_inner += fragsz;
+	}
+
+	if (cqe_bcnt > hlen + cclen) {
+		remaining = cqe_bcnt - hlen - cclen;
+		mlx5_nvmeotcp_add_tail_nonlinear(skb, org_frags,
+						 org_nr_frags,
+						 frag_index);
+	}
+
+	mlx5e_nvmeotcp_put_queue(queue);
+	return true;
+}
+
+static bool
+mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
+				     struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{
+	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
+	struct net_device *netdev = rq->netdev;
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_nvmeotcp_queue_entry *nqe;
+	struct mlx5e_nvmeotcp_queue *queue;
+	struct mlx5e_cqe128 *cqe128;
+	u32 queue_id;
+
+	queue_id = (be32_to_cpu(cqe->sop_drop_qpn) & MLX5E_TC_FLOW_ID_MASK);
+	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
+	if (unlikely(!queue)) {
+		dev_kfree_skb_any(skb);
+		return false;
+	}
+
+	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
+	if (cqe_is_nvmeotcp_resync(cqe)) {
+		nvmeotcp_update_resync(queue, cqe128);
+		mlx5e_nvmeotcp_put_queue(queue);
+		return true;
+	}
+
+	/* If a resync occurred in the previous cqe,
+	 * the current cqe.crcvalid bit may not be valid,
+	 * so we will treat it as 0
+	 */
+	if (unlikely(queue->after_resync_cqe) && cqe_is_nvmeotcp_crcvalid(cqe)) {
+		skb->ulp_crc = 0;
+		queue->after_resync_cqe = 0;
+	} else {
+		if (queue->crc_rx)
+			skb->ulp_crc = cqe_is_nvmeotcp_crcvalid(cqe);
+	}
+
+	skb->no_condense = cqe_is_nvmeotcp_zc(cqe);
+	if (!cqe_is_nvmeotcp_zc(cqe)) {
+		mlx5e_nvmeotcp_put_queue(queue);
+		return true;
+	}
+
+	/* cc ddp from cqe */
+	ccid	= be16_to_cpu(cqe128->ccid);
+	ccoff	= be32_to_cpu(cqe128->ccoff);
+	cclen	= be16_to_cpu(cqe128->cclen);
+	hlen	= be16_to_cpu(cqe128->hlen);
+
+	/* carve a hole in the skb for DDP data */
+	skb_trim(skb, hlen);
+	nqe = &queue->ccid_table[ccid];
+
+	/* packet starts new ccid? */
+	if (queue->ccid != ccid || queue->ccid_gen != nqe->ccid_gen) {
+		queue->ccid = ccid;
+		queue->ccoff = 0;
+		queue->ccoff_inner = 0;
+		queue->ccsglidx = 0;
+		queue->ccid_gen = nqe->ccid_gen;
+	}
+
+	/* skip inside cc until the ccoff in the cqe */
+	while (queue->ccoff + queue->ccoff_inner < ccoff) {
+		remaining = nqe->sgl[queue->ccsglidx].length - queue->ccoff_inner;
+		fragsz = min_t(off_t, remaining,
+			       ccoff - (queue->ccoff + queue->ccoff_inner));
+
+		if (fragsz == remaining)
+			mlx5e_nvmeotcp_advance_sgl_iter(queue);
+		else
+			queue->ccoff_inner += fragsz;
+	}
+
+	/* adjust the skb according to the cqe cc */
+	while (to_copy < cclen) {
+		remaining = nqe->sgl[queue->ccsglidx].length - queue->ccoff_inner;
+		fragsz = min_t(int, remaining, cclen - to_copy);
+
+		mlx5e_nvmeotcp_add_skb_frag(netdev, skb, queue, nqe, fragsz);
+		to_copy += fragsz;
+		if (fragsz == remaining)
+			mlx5e_nvmeotcp_advance_sgl_iter(queue);
+		else
+			queue->ccoff_inner += fragsz;
+	}
+
+	if (cqe_bcnt > hlen + cclen) {
+		remaining = cqe_bcnt - hlen - cclen;
+		mlx5_nvmeotcp_add_tail(rq, cqe, queue, skb,
+				       offset_in_page(skb->data) +
+				       hlen + cclen, remaining);
+	}
+
+	mlx5e_nvmeotcp_put_queue(queue);
+	return true;
+}
+
+bool
+mlx5e_nvmeotcp_rebuild_rx_skb(struct mlx5e_rq *rq, struct sk_buff *skb,
+			      struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{
+	if (skb->data_len)
+		return mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(rq, skb, cqe, cqe_bcnt);
+	else
+		return mlx5e_nvmeotcp_rebuild_rx_skb_linear(rq, skb, cqe, cqe_bcnt);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h
new file mode 100644
index 000000000000..a8ca8a53bac6
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_NVMEOTCP_RXTX_H__
+#define __MLX5E_NVMEOTCP_RXTX_H__
+
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+
+#include <linux/skbuff.h>
+#include "en_accel/nvmeotcp.h"
+
+bool
+mlx5e_nvmeotcp_rebuild_rx_skb(struct mlx5e_rq *rq, struct sk_buff *skb,
+			      struct mlx5_cqe64 *cqe, u32 cqe_bcnt);
+
+static inline int mlx5_nvmeotcp_get_headlen(struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{
+	struct mlx5e_cqe128 *cqe128;
+
+	if (!cqe_is_nvmeotcp_zc(cqe))
+		return cqe_bcnt;
+
+	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
+	return be16_to_cpu(cqe128->hlen);
+}
+
+#else
+
+static inline bool
+mlx5e_nvmeotcp_rebuild_rx_skb(struct mlx5e_rq *rq, struct sk_buff *skb,
+			      struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{ return true; }
+
+static inline int mlx5_nvmeotcp_get_headlen(struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{ return cqe_bcnt; }
+
+#endif /* CONFIG_MLX5_EN_NVMEOTCP */
+#endif /* __MLX5E_NVMEOTCP_RXTX_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 0b9a8272430c..03e385aa47d8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -53,7 +53,7 @@
 #include "en_accel/macsec.h"
 #include "en_accel/ipsec_rxtx.h"
 #include "en_accel/ktls_txrx.h"
-#include "en_accel/nvmeotcp.h"
+#include "en_accel/nvmeotcp_rxtx.h"
 #include "en/xdp.h"
 #include "en/xsk/rx.h"
 #include "en/health.h"
@@ -336,10 +336,6 @@ static inline void mlx5e_put_rx_frag(struct mlx5e_rq *rq,
 		mlx5e_page_release_fragmented(rq, frag->frag_page);
 }
 
-static inline struct mlx5e_wqe_frag_info *get_frag(struct mlx5e_rq *rq, u16 ix)
-{
-	return &rq->wqe.frags[ix << rq->wqe.info.log_num_frags];
-}
 
 static int mlx5e_alloc_rx_wqe(struct mlx5e_rq *rq, struct mlx5e_rx_wqe_cyc *wqe,
 			      u16 ix)
@@ -1560,7 +1556,7 @@ static inline void mlx5e_handle_csum(struct net_device *netdev,
 
 #define MLX5E_CE_BIT_MASK 0x80
 
-static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
+static inline bool mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 				      u32 cqe_bcnt,
 				      struct mlx5e_rq *rq,
 				      struct sk_buff *skb)
@@ -1571,6 +1567,13 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 
 	skb->mac_len = ETH_HLEN;
 
+	if (IS_ENABLED(CONFIG_MLX5_EN_NVMEOTCP) && cqe_is_nvmeotcp(cqe)) {
+		bool ret = mlx5e_nvmeotcp_rebuild_rx_skb(rq, skb, cqe, cqe_bcnt);
+
+		if (unlikely(!ret))
+			return ret;
+	}
+
 	if (unlikely(get_cqe_tls_offload(cqe)))
 		mlx5e_ktls_handle_rx_skb(rq, skb, cqe, &cqe_bcnt);
 
@@ -1617,6 +1620,8 @@ static inline void mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 
 	if (unlikely(mlx5e_skb_is_multicast(skb)))
 		stats->mcast_packets++;
+
+	return true;
 }
 
 static void mlx5e_shampo_complete_rx_cqe(struct mlx5e_rq *rq,
@@ -1638,7 +1643,7 @@ static void mlx5e_shampo_complete_rx_cqe(struct mlx5e_rq *rq,
 	}
 }
 
-static inline void mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
+static inline bool mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
 					 struct mlx5_cqe64 *cqe,
 					 u32 cqe_bcnt,
 					 struct sk_buff *skb)
@@ -1647,7 +1652,7 @@ static inline void mlx5e_complete_rx_cqe(struct mlx5e_rq *rq,
 
 	stats->packets++;
 	stats->bytes += cqe_bcnt;
-	mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb);
+	return mlx5e_build_rx_skb(cqe, cqe_bcnt, rq, skb);
 }
 
 static inline
@@ -1861,7 +1866,8 @@ static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 		goto wq_cyc_pop;
 	}
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto wq_cyc_pop;
 
 	if (mlx5e_cqe_regb_chain(cqe))
 		if (!mlx5e_tc_update_skb_nic(cqe, skb)) {
@@ -1908,7 +1914,8 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 		goto wq_cyc_pop;
 	}
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto wq_cyc_pop;
 
 	if (rep->vlan && skb_vlan_tag_present(skb))
 		skb_vlan_pop(skb);
@@ -1957,7 +1964,8 @@ static void mlx5e_handle_rx_cqe_mpwrq_rep(struct mlx5e_rq *rq, struct mlx5_cqe64
 	if (!skb)
 		goto mpwrq_cqe_out;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto mpwrq_cqe_out;
 
 	mlx5e_rep_tc_receive(cqe, rq, skb);
 
@@ -1997,13 +2005,18 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
 	} while (data_bcnt);
 }
 
+static inline u16 mlx5e_get_headlen_hint(struct mlx5_cqe64 *cqe, u32 cqe_bcnt)
+{
+	return min_t(u32, MLX5E_RX_MAX_HEAD, mlx5_nvmeotcp_get_headlen(cqe, cqe_bcnt));
+}
+
 static struct sk_buff *
 mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 				   struct mlx5_cqe64 *cqe, u16 cqe_bcnt, u32 head_offset,
 				   u32 page_idx)
 {
 	struct mlx5e_frag_page *frag_page = &wi->alloc_units.frag_pages[page_idx];
-	u16 headlen = min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
+	u16 headlen = mlx5e_get_headlen_hint(cqe, cqe_bcnt);
 	struct mlx5e_frag_page *head_page = frag_page;
 	u32 frag_offset    = head_offset;
 	u32 byte_cnt       = cqe_bcnt;
@@ -2429,7 +2442,8 @@ static void mlx5e_handle_rx_cqe_mpwrq(struct mlx5e_rq *rq, struct mlx5_cqe64 *cq
 	if (!skb)
 		goto mpwrq_cqe_out;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto mpwrq_cqe_out;
 
 	if (mlx5e_cqe_regb_chain(cqe))
 		if (!mlx5e_tc_update_skb_nic(cqe, skb)) {
@@ -2762,7 +2776,9 @@ static void mlx5e_trap_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe
 	if (!skb)
 		goto wq_cyc_pop;
 
-	mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb);
+	if (unlikely(!mlx5e_complete_rx_cqe(rq, cqe, cqe_bcnt, skb)))
+		goto wq_cyc_pop;
+
 	skb_push(skb, ETH_HLEN);
 
 	mlx5_devlink_trap_report(rq->mdev, trap_id, skb,
-- 
2.34.1


