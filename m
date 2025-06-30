Return-Path: <netdev+bounces-202465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4780EAEE030
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D2C188A29E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6211E28BAAD;
	Mon, 30 Jun 2025 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KaWTrQ+P"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D7228BABC
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292549; cv=fail; b=gv8Mb9eX+5NMuTLvdZdvIDPQLRdrHkKrmnuRVMRwt3L6O2M1M932CvL/eJHe7qP1jvof0PkE8NeqyEX/GIwGdQ90743Avjlmi3s2f5VH7JAnPUYeUlQ+fuvp6XyzJh0kj3d2g/mfN7ivWw5E4qV5rgLQ1ej+KyH3gYO5SDWhgEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292549; c=relaxed/simple;
	bh=to9A3qlRYfGmpnXBgXLKXxSBAbW/UiMEEc29eQAdxLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kBYvaK0Uhsiwy17SUjbTv83lcldAVjUdsszjXau4CCWFC5XxrvtYcmfs6lcC6ll5VizQ4lxC450Uopq1OXhH+KC51eJiX0PSZpwpKI5q9SigAi1HhTPpEavXW/nPmIBnrvonXgn2ObdO04ahfU4NKa4ip+8MkrC75AN9Ugj1KkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KaWTrQ+P; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lW3wTo9NCUPrvrw0DeHzEIIWuQ5H1TLwXWmbbPhfvpzgiCu4P/SH2CmpwWB4BRRNd973uFsK+emTtHniF7ZC+DOKgVUJ4daaFXSsE+hhs9MMLA/OnFrbmg2HkidGl9OjszCoVRyfLz0wG3KQG1EeHxq6iUzX2sMUv8arBKK970Wt9l3OQz7gH0I00c0CzglpBUVrPjfkgzTihgRc5mbacUfVLUZLZXS6F/0Nj+E2icJamuMF6tuzyGi/ltKWRh0nIEMToALhzMuzLwGGI5DTT74jp/jdngSUeIpVfXPFAF9QXcxdiqwZraKbvdZwZ1BdMJ7go1vshCJbx3MWzg1yJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7H/H06c9QN2bLD0qSRoU6+NRyxJ1ODCmdS0WUUpnaA=;
 b=TWMf1uKkmc6INsE9vjSvV0G4yd3U4FGHfCwdleYGn9hHJNuO25iGTS1CCI4ln6p2kuDgj1FwU8n77Wq8k4foX3XpXIh3+bWH+gXqiSxzZURwhOszFA9WH1Q/aaq+41/UNWTe4OMKajWaAa+++34vYpAqObQ5f4MXi8mMCGwGG9B82g/6hjBGwaMeppfqNwDefJnmUUZb61sm66+pdBthiW7GRpbDIM3CyQaUj/P+6d183KciHWNZhOzSyhAKH+URaOkyDeFVZnpXHpbDGOoUqzUV5LzPfr1nWNNNqONuWzPkk8MTYCP+lMEeOZ7Y7FtY2cPq6zV02o1Ti+glm6woag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7H/H06c9QN2bLD0qSRoU6+NRyxJ1ODCmdS0WUUpnaA=;
 b=KaWTrQ+PFOGIf2YHOgl+PRBiv51AShYzrXYzqfnkl+uXo90BwAKS0WhoJGhtIm9tOPzWBhHq47SEyAVjGpMMFFK2TYkvZg5n9UEXwnoo9PfJH5a4ICkepCJtKw+lPdwrFOsn2aq1Y58RwdFtuOHp5mhXIpB5lSTPW0zZCcsxNyLKqKQeDwJQJWhuBUK9Z6ha9eMZPl0XMdeJBqCiK6qbjsr8WVOLZO8xqaaInazWnv7M5iNOcmlxzX16WDc7oNKTMZ8k2y0XL9mXUHAB2p4QXKAAqvdrtuBdpaBeeHvITvf9By0JO7YswE0PUSqQ2HWBGHsA73kPeyr/99Kio3LONg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 14:09:01 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 14:09:00 +0000
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
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v29 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
Date: Mon, 30 Jun 2025 14:07:32 +0000
Message-Id: <20250630140737.28662-16-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630140737.28662-1-aaptel@nvidia.com>
References: <20250630140737.28662-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 86bee5ac-831f-4b20-99c5-08ddb7dfa98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N2ZNe4sfbmo4OjF0kkCUEY3JxZCLToAFcU7c1UyJhenFJnBIBqsniQeA2tTz?=
 =?us-ascii?Q?g8L1tOkkbHTFyXfeZIxb9KYPHBD3HW17kS5IZMQAAmtJqIJqwVVQxVG2V9Il?=
 =?us-ascii?Q?5IhsUT1mUkadxjvSiGg65vO1y0/dipOBBNV2pQyRxCRZzBZOFKO/gJm+VZwU?=
 =?us-ascii?Q?BOA+16ikHWcili76GeN9eKQSIZWOL9diYEdSVo6oz0uYxeFXDLS2M+0X3bSj?=
 =?us-ascii?Q?mTJuY9dwRIgqQNJMVRUc7pXdbyuLNNWCJF0JS3Jrnok1oivDHjGtMqTHxd0k?=
 =?us-ascii?Q?ppmttJhkULpCpowotQpDQ9ifV0iBJy3G/GIsG8CJJP17RRpebLdyv1cJ7RRg?=
 =?us-ascii?Q?PoLBKZXM9doIK3CcY0w9HZqB35R/OGNpyZN+uYXVC2gdRnlTqzI+qVEjL/oD?=
 =?us-ascii?Q?M0POlFoAZEZLLgZnhg9dOb+WvQzHcfHR2o7N/ydKofVktXsB9UODiAtAT3Ry?=
 =?us-ascii?Q?Z3CbXwBgh7VUdp7Vgf7Sadb/PYjSXq05Em3WJtY8APCndf3n8F3EZbXydfUi?=
 =?us-ascii?Q?gN2TOknCbGEUr0e7cuBRlLEQDelNVU52CAmXsjJy9z0oWXaEUeSnAJ1A0COV?=
 =?us-ascii?Q?mhp9yaF2BnwoTsWHdLBZ3ktNxvdhdkrAvPFKbDqCHBs1pz8l8gxLFxYNUBqY?=
 =?us-ascii?Q?ceygDL5JVCInCGJcBp5tmt9uKT++yAaY36XZl2wsZcTG2I1ClF03dQtcxcJp?=
 =?us-ascii?Q?SYvapucnrko44GiH5AVGJR3ygYzad03Fx1CTXAx/LQmTSOSZEFkdxKmOOzVr?=
 =?us-ascii?Q?MRyAb2pGvkPTdAjTfiGwlv89O+LaAVmh1L2sSvEiGN5EB10sIhitCKUNa/Ve?=
 =?us-ascii?Q?aAsP+H9g7hivBBHi3dRDaKOnMxW1xXbVqsyyPc4FG/yuIDjQfmQ2LwYpXd5s?=
 =?us-ascii?Q?bX5AAfhzDFaILMU2zJnONyqtCwTVCvwajXkxK8GOUQZuGhlBruXBo++qu7kA?=
 =?us-ascii?Q?adXQRmRh56ghkbrRphjV28ljruFRtAkNMKg8bew0cSVhFzGoPBe8SWmJsYWG?=
 =?us-ascii?Q?3LbDhGGjg9pv0WALI6OOz2ZfCQpgRHNHvWBDGMeVh27R9QA6avURx9WmTEd7?=
 =?us-ascii?Q?jVYk2Z6wNKbbJzeFkrZBzmMdQLVIOqwURZv28TN7HCeAzWt9mqd/7ggQQWHk?=
 =?us-ascii?Q?8mphv6knVv7to1Y+Wyfsmr4/h8DNH9EffoeUf3YLkNBsChMv8On7x7CPP8Xc?=
 =?us-ascii?Q?FQqKVagNyyKJMaElSmuoWFJd9yIH92kG6lRrfcHAXLFNCIYD4tV2RNPllpG4?=
 =?us-ascii?Q?KTJJdKE1X8wbNn9DRLdZvbMBCLYmEZc4dBaZFvy+27iY7kgnn3cXgLJxHk6s?=
 =?us-ascii?Q?dDeCUCPfNRcD/TybOBwxN04I1SUqu9Q70zd7zu47OoASob9L/B4JLXRwJCEo?=
 =?us-ascii?Q?UohlkBK1vdxk/MucLxV6g9BT2JJD5twPtiefdMxftCvpQbt0NRmvsRqGXez6?=
 =?us-ascii?Q?i0SMdAObQp4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sAfjRBwOnqwhCtcr7U5T4ByJ1rm4OLMVxBYdKeFuPWQEzU3w9SOmYbbp6nnm?=
 =?us-ascii?Q?V6vPlhwfqDoc53TWxyRYZhrHTXj7TMDXLza5m6TcreNg4xCU2zKcr0oKEB9M?=
 =?us-ascii?Q?IgGfFN3/YQeZOR/cQye+coDwOxHiMNuhar2qv0Gym0sjWMtoeN7xDU0cwIsg?=
 =?us-ascii?Q?+vlPF1M6fTDIf/Zw0LLbRF1vKXGWJpbNWq3EfiS2bTU1MJm9wcnZzLTAcDZ1?=
 =?us-ascii?Q?qPjaiyoKIaRgCF+Dk1uz9D4HZrIW6e5UjQKmluyGyBqEa8PbykKNg0Vi50yP?=
 =?us-ascii?Q?C26Ws7oo+/PopkxiP7vUNa+U01OTezFIOY0w/xbhfuVsTh6gjST4daS7XrLp?=
 =?us-ascii?Q?RWazvDnbx7o0kaKwBG33U2x7KuHYmz01unF+8rZoqOP9+eCHOs0afzvtynwh?=
 =?us-ascii?Q?mSnDe1D+L9+aWBmcHvNJqqhV+FxRwg7FWsn0EFX+8+P0NqIqLq3xrwSP7BN/?=
 =?us-ascii?Q?KRshue/ExcRKXlCgF6glfJ2B0rhDn5LNMnPLv6JTMaP0heCNdEtoRHUTHLfB?=
 =?us-ascii?Q?zl7wXX6EZ1pHs0FdRP2ZgNJ8I3H3pklfMnOa7SfcT7SWg7jayOpr+4GkBRnN?=
 =?us-ascii?Q?IcjDofCnoEBq8zmLMWX+85LQg6bwb6GJu3whQ/hLMgfy5fc3mjz6vSQ96/Wq?=
 =?us-ascii?Q?pJvC/YzGtH/VY8d2YNmJ5rOYpGHeLcG7s3Yfbe1zqnZ9Hk2dsMq3ePMvOsYz?=
 =?us-ascii?Q?JkFH3JPOZEnsAP0zsEPONMa/IeAOk61ynq1MDaOg4ZsHtClNLXAxdkGqN/Vh?=
 =?us-ascii?Q?T1jlYdoMv1pbx9RWaRfN7Wwk6eV+W0Gb/MSIyPvifG/laKHLXOP+ZpaGvuyt?=
 =?us-ascii?Q?wYUMt3W5L8sqMbc2TdKllWyggpoWRD7PW21oEPlhH7RcVz6wJcQxMbmN/nk0?=
 =?us-ascii?Q?6uJ5lEtapHwPLPEY9WYR6Uet0YSD+1rkg2nllxZNgHK42CORg+tSh1ebVmv2?=
 =?us-ascii?Q?JN9A1j7o/hcsn/HbfK6PkTFlslAJH7pwFevEFI1GU1hLM1o0Kvcb5SM5Fl+j?=
 =?us-ascii?Q?9Fm2ls/mUjLqYuKMUDTl8GZsEnGQU54IoBsVYqVnUIBVeZImbW4uVXvuydcx?=
 =?us-ascii?Q?+rVcQabq7VpZa9aKJ3ihBknB320LnAFq5CSsgaI5D4uvwRM/8aTJdFgVwP/q?=
 =?us-ascii?Q?WD6i+SkXpBPFiwC/ogezz1KiRu0LWVC3pPY6bG8n3HrweW4GiSJSqoiQp4IC?=
 =?us-ascii?Q?xxv449TZorEZwM60ovH/wKYPFxbxOJaps5eOF5nYsw1gT2Z6/U96o+cVvAhj?=
 =?us-ascii?Q?AtvOUetbI9AsmJ8izemNXuPf/Huzl5ht1z3E890ROq1j7/GYAsVL8tXhsFfv?=
 =?us-ascii?Q?xPec5dlpr1jBxRn+ZX99o86yHG68AJcvvcHjAz/pVO8JXcGJU6brKkEE8C1A?=
 =?us-ascii?Q?nogzlDAkQ90+EaK1VJDaBVK3ioFsj5+eRJNWah1hipGIs2nm+LzxJEshU53r?=
 =?us-ascii?Q?gl71UZvl3CuYmMHkdY9OYEGtGajeHIuI0QKlQ3hQTBF1uR/LWqTGi7y92uvG?=
 =?us-ascii?Q?3oHUncc1QW+SfiMXbh6tjnpVw1fQ/XV0otoAW7Z0aUbuFceo5toCIEKrpDWF?=
 =?us-ascii?Q?O3ccpKy74NmIxWFLbPcW6QiJCLEkC13cGPh7cf3h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bee5ac-831f-4b20-99c5-08ddb7dfa98b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:09:00.8626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82R5hornPk85Is1lii9aYDPqXpoRg5+vcaMdY2wCGp4MwyZ6AxW8J58AbssAz7xeIU64R2g/EGqIHxIB9TR6Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

From: Ben Ben-Ishay <benishay@nvidia.com>

NVMEoTCP offload uses buffer registration for ddp operation.
Every request comprises from SG list that might consist from elements
with multiple combination sizes, thus the appropriate way to perform
buffer registration is with KLM UMRs.

UMR stands for user-mode memory registration, it is a mechanism to alter
address translation properties of MKEY by posting WorkQueueElement
aka WQE on send queue.

MKEY stands for memory key, MKEY are used to describe a region in memory
that can be later used by HW.

KLM stands for {Key, Length, MemVa}, KLM_MKEY is indirect MKEY that
enables to map multiple memory spaces with different sizes in unified MKEY.
KLM UMR is a UMR that use to update a KLM_MKEY.

Nothing needs to be done on memory registration completion and this
notification is expensive so we add a wrapper to be able to ring the
doorbell without generating any.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  21 +++
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  16 +-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 149 ++++++++++++++++++
 .../mlx5/core/en_accel/nvmeotcp_utils.h       |  25 +++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   4 +
 5 files changed, 212 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 6a4adfb3ea59..aee4b458722b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -146,6 +146,27 @@ struct page_pool;
 #define MLX5E_TX_XSK_POLL_BUDGET       64
 #define MLX5E_SQ_RECOVER_MIN_INTERVAL  500 /* msecs */
 
+#define MLX5E_KLM_UMR_WQE_SZ(sgl_len)\
+	(sizeof(struct mlx5e_umr_wqe) + \
+	 (sizeof(struct mlx5_klm) * (sgl_len)))
+
+#define MLX5E_KLM_UMR_WQEBBS(klm_entries) \
+	(DIV_ROUND_UP(MLX5E_KLM_UMR_WQE_SZ(klm_entries), MLX5_SEND_WQE_BB))
+
+#define MLX5E_KLM_UMR_DS_CNT(klm_entries)\
+	(DIV_ROUND_UP(MLX5E_KLM_UMR_WQE_SZ(klm_entries), MLX5_SEND_WQE_DS))
+
+#define MLX5E_KLM_MAX_ENTRIES_PER_WQE(wqe_size)\
+	(((wqe_size) - sizeof(struct mlx5e_umr_wqe)) / sizeof(struct mlx5_klm))
+
+#define MLX5E_KLM_ENTRIES_PER_WQE(wqe_size)\
+	ALIGN_DOWN(MLX5E_KLM_MAX_ENTRIES_PER_WQE(wqe_size), \
+		   MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT)
+
+#define MLX5E_MAX_KLM_PER_WQE(mdev) \
+	MLX5E_KLM_ENTRIES_PER_WQE(MLX5_SEND_WQE_BB * \
+				  mlx5e_get_max_sq_aligned_wqebbs(mdev))
+
 #define mlx5e_state_dereference(priv, p) \
 	rcu_dereference_protected((p), lockdep_is_held(&(priv)->state_lock))
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 5aa5b5833c56..13a9c249cd92 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -71,6 +71,9 @@ enum mlx5e_icosq_wqe_type {
 	MLX5E_ICOSQ_WQE_SET_PSV_TLS,
 	MLX5E_ICOSQ_WQE_GET_PSV_TLS,
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP,
+#endif
 };
 
 /* General */
@@ -290,10 +293,10 @@ static inline u16 mlx5e_icosq_get_next_pi(struct mlx5e_icosq *sq, u16 size)
 }
 
 static inline void
-mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
-		struct mlx5_wqe_ctrl_seg *ctrl)
+__mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		  struct mlx5_wqe_ctrl_seg *ctrl, u8 cq_update)
 {
-	ctrl->fm_ce_se |= MLX5_WQE_CTRL_CQ_UPDATE;
+	ctrl->fm_ce_se |= cq_update;
 	/* ensure wqe is visible to device before updating doorbell record */
 	dma_wmb();
 
@@ -307,6 +310,13 @@ mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
 	mlx5_write64((__be32 *)ctrl, uar_map);
 }
 
+static inline void
+mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		struct mlx5_wqe_ctrl_seg *ctrl)
+{
+	__mlx5e_notify_hw(wq, pc, uar_map, ctrl, MLX5_WQE_CTRL_CQ_UPDATE);
+}
+
 static inline void mlx5e_cq_arm(struct mlx5e_cq *cq)
 {
 	struct mlx5_core_cq *mcq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index ca9c3aaf941f..f5df4b41c3ef 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -4,6 +4,7 @@
 #include <linux/netdevice.h>
 #include <linux/idr.h>
 #include "en_accel/nvmeotcp.h"
+#include "en_accel/nvmeotcp_utils.h"
 #include "en_accel/fs_tcp.h"
 #include "en/txrx.h"
 
@@ -19,6 +20,146 @@ static const struct rhashtable_params rhash_queues = {
 	.max_size = MAX_NUM_NVMEOTCP_QUEUES,
 };
 
+static void
+fill_nvmeotcp_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
+		      struct mlx5e_umr_wqe *wqe, u16 ccid,
+		      u32 klm_entries, u16 klm_offset)
+{
+	struct scatterlist *sgl_mkey;
+	u32 lkey, i;
+
+	lkey = queue->priv->mdev->mlx5e_res.hw_objs.mkey;
+	for (i = 0; i < klm_entries; i++) {
+		sgl_mkey = &queue->ccid_table[ccid].sgl[i + klm_offset];
+		wqe->inline_klms[i].bcount = cpu_to_be32(sg_dma_len(sgl_mkey));
+		wqe->inline_klms[i].key = cpu_to_be32(lkey);
+		wqe->inline_klms[i].va = cpu_to_be64(sgl_mkey->dma_address);
+	}
+
+	for (; i < ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT);
+	     i++) {
+		wqe->inline_klms[i].bcount = 0;
+		wqe->inline_klms[i].key = 0;
+		wqe->inline_klms[i].va = 0;
+	}
+}
+
+static void
+build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue,
+		       struct mlx5e_umr_wqe *wqe, u16 ccid, int klm_entries,
+		       u32 klm_offset, u32 len, enum wqe_type klm_type)
+{
+	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->hdr.uctrl;
+	struct mlx5_wqe_ctrl_seg *cseg = &wqe->hdr.ctrl;
+	struct mlx5_mkey_seg *mkc = &wqe->hdr.mkc;
+	u32 sqn = queue->sq.sqn;
+	u16 pc = queue->sq.pc;
+	u32 ds_cnt;
+	u8 opc_mod;
+	u32 id;
+
+	ds_cnt =
+		MLX5E_KLM_UMR_DS_CNT(ALIGN(klm_entries,
+					   MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+
+	if (klm_type == BSF_KLM_UMR) {
+		id = mlx5e_tir_get_tirn(&queue->tir) <<
+			MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT;
+		opc_mod = MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
+	} else {
+		id = queue->ccid_table[ccid].klm_mkey;
+		opc_mod = MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR;
+	}
+
+	cseg->opmod_idx_opcode =
+		cpu_to_be32((pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
+			    MLX5_OPCODE_UMR | (opc_mod) << 24);
+	cseg->qpn_ds = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) | ds_cnt);
+	cseg->general_id = cpu_to_be32(id);
+
+	if (klm_type == KLM_UMR && !klm_offset) {
+		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_XLT_OCT_SIZE |
+					       MLX5_MKEY_MASK_LEN |
+					       MLX5_MKEY_MASK_FREE);
+		mkc->xlt_oct_size =
+			cpu_to_be32(ALIGN(len,
+					  MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+		mkc->len = cpu_to_be64(queue->ccid_table[ccid].size);
+	}
+
+	ucseg->flags = MLX5_UMR_INLINE | MLX5_UMR_TRANSLATION_OFFSET_EN;
+	ucseg->xlt_octowords =
+		cpu_to_be16(ALIGN(klm_entries,
+				  MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	ucseg->xlt_offset = cpu_to_be16(klm_offset);
+	fill_nvmeotcp_klm_wqe(queue, wqe, ccid, klm_entries, klm_offset);
+}
+
+static void
+mlx5e_nvmeotcp_fill_wi(struct mlx5e_icosq *sq, u32 wqebbs, u16 pi)
+{
+	struct mlx5e_icosq_wqe_info *wi = &sq->db.wqe_info[pi];
+
+	memset(wi, 0, sizeof(*wi));
+
+	wi->num_wqebbs = wqebbs;
+	wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP;
+}
+
+static u32
+post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
+	     enum wqe_type wqe_type,
+	     u16 ccid,
+	     u32 klm_length,
+	     u32 klm_offset)
+{
+	struct mlx5e_icosq *sq = &queue->sq;
+	u32 wqebbs, cur_klm_entries;
+	struct mlx5e_umr_wqe *wqe;
+	u16 pi, wqe_sz;
+
+	cur_klm_entries = min_t(int, queue->max_klms_per_wqe,
+				klm_length - klm_offset);
+	wqe_sz =
+		MLX5E_KLM_UMR_WQE_SZ(ALIGN(cur_klm_entries,
+					   MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	wqebbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
+	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
+	wqe = MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi);
+	mlx5e_nvmeotcp_fill_wi(sq, wqebbs, pi);
+	build_nvmeotcp_klm_umr(queue, wqe, ccid, cur_klm_entries, klm_offset,
+			       klm_length, wqe_type);
+	sq->pc += wqebbs;
+	sq->doorbell_cseg = &wqe->hdr.ctrl;
+	return cur_klm_entries;
+}
+
+static void
+mlx5e_nvmeotcp_post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
+			    enum wqe_type wqe_type, u16 ccid, u32 klm_length)
+{
+	struct mlx5e_icosq *sq = &queue->sq;
+	u32 klm_offset = 0, wqes, i;
+
+	wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
+
+	spin_lock_bh(&queue->sq_lock);
+
+	for (i = 0; i < wqes; i++)
+		klm_offset += post_klm_wqe(queue, wqe_type, ccid, klm_length,
+					   klm_offset);
+
+	/* not asking for completion on ddp_setup UMRs */
+	if (wqe_type == KLM_UMR)
+		__mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map,
+				  sq->doorbell_cseg, 0);
+	else
+		mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map,
+				sq->doorbell_cseg);
+
+	spin_unlock_bh(&queue->sq_lock);
+}
+
 static int
 mlx5e_nvmeotcp_offload_limits(struct net_device *netdev,
 			      struct ulp_ddp_limits *limits)
@@ -45,6 +186,14 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct sock *sk,
 			 struct ulp_ddp_io *ddp)
 {
+	struct mlx5e_nvmeotcp_queue *queue;
+
+	queue = container_of(ulp_ddp_get_ctx(sk),
+			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+
+	/* Placeholder - map_sg and initializing the count */
+
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, 0);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
new file mode 100644
index 000000000000..6ef92679c5d0
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_NVMEOTCP_UTILS_H__
+#define __MLX5E_NVMEOTCP_UTILS_H__
+
+#include "en.h"
+
+#define MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi) \
+	((struct mlx5e_umr_wqe *)\
+	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_umr_wqe)))
+
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_NVMEOTCP_TIR_PROGRESS_PARAMS 0x4
+
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_TIR_PARAMS 0x2
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR 0x0
+
+enum wqe_type {
+	KLM_UMR,
+	BSF_KLM_UMR,
+	SET_PSV_UMR,
+	BSF_UMR,
+	KLM_INV_UMR,
+};
+
+#endif /* __MLX5E_NVMEOTCP_UTILS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index f4c8c3f3c0d7..c89f0fc70617 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1061,6 +1061,10 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 			case MLX5E_ICOSQ_WQE_GET_PSV_TLS:
 				mlx5e_ktls_handle_get_psv_completion(wi, sq);
 				break;
+#endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP:
+				break;
 #endif
 			default:
 				netdev_WARN_ONCE(cq->netdev,
-- 
2.34.1


