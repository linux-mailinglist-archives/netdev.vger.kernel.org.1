Return-Path: <netdev+bounces-168448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B302FA3F0FC
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992F83B3094
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D343020409F;
	Fri, 21 Feb 2025 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iTbrXM+K"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D541A20102C
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131624; cv=fail; b=QdBxRk4Zv19inmkJ50Ok8kwemjHelWDxFcwFhw1s8JylIbQiV8WfrM+BnwhkHlle6kf/SH1oxfZdes7qDREGd4YxiQ9bbrUMxKkR8PMp9zvQ7kcfZi2MLIPErsVBv8z4xVBHgjAmoaCYOgQLZ0/cTLWumCcfgpABN0ONe/4Za7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131624; c=relaxed/simple;
	bh=oG+u3syuvDdaQZbIwe0GgGzLiIb28L+z5CcFq5YS9Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QFPM/YW0lQtQsfSm17iFtaEwp6rPRdwiHGUBOyGKoPWEVVjUVi+dbpfpMgIl3ZKfxaU3Xts0flCiYyQIOOhFf4zTPP1gN/rJfKLhoS71EDChwsWC2bEciSvJDaMDSGfOARkKWLkYUikNnPq1xlEwjAw8iWJuy7MUC7yNTjRYB4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iTbrXM+K; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpYYKMr5XpTdisWaSOiJltOFEkMVJllt7WnIdAPCCvsWcreB/0SexMMwkCMUf4zoVoWw9kqeRIdwnWC/kpbWcWJQasJ6fY2kqHHj+ZDFNQWxNLi0oDIkvettjbeiQa85o8tsRpFIjYAjesLG2LdCX/5jkJ/cPlYSrQ+zXlCQkjaCE2TArXaI7eifl/2XrbrLs1d/zDYMuou8aFjWlACDo2N+SougIvHvxooJ0iNRLTjb1IzSok9/kZJtlFPbORG1P+Vw4WmTOlAGQ9VvnCP+RQzWrF2/UYM9yMP7YUtW8c+Ax2fR7mschCh+f82QM5oVKvcQSEVBM9Jd8IEjaAeXMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hf2KBOsH+UX830Zr3ys/hr9zNNbiU6RcSv5Uqte9dmY=;
 b=plHqWIEx76HSt8h9MX6W4zdFFB65eI7nV8kFAoccrEcsRXL0YamrXGnNgUGADTFbEBFRtducOBFBiMKxzyyFE5T9IBgCQWFWJXhreF0tVriyE3FGJr9Y83o7L5Oag58X4A44fc4bxwimZ8l1BRDpT7lROyEL/1W+h5sew+93GqF4TM/laRAwKEHsjKer+ylAtLlIUnFZX76LWUosu6X1P+Rtc4x5zaclozE2u2Qf4c/a7wrdX6xFnrjuBogulYlrGeNxaPRk3o9JXWcIJyxdCrM6V6MzuXgT/3yg5Z+9MuwoM61lq5o2ircNg+0drifYyJg6bp9t2H7skNHFXPixIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hf2KBOsH+UX830Zr3ys/hr9zNNbiU6RcSv5Uqte9dmY=;
 b=iTbrXM+KxcIKZzhgOPjX1GDVUBCL0jVnbJVosWqedkQrBNRSM/8rb8/URJh5iw4La9uyPRvdBJckmRfwhj4wlkNI542FeqZ93OyX5zNMAIqrAmFs4nKwLmZL99oKWjQgORds8SQev+TcYToDSWz64OIgjUmpIzF8m/2KP4SJpMJnA2PM+ISHa7IgCky7CjgC8W2O2jCAqLBdRxDW0ahas/IBVe8fmTtFCNIAjwsi2n2rYFPelCy3eBEIF/ZbA6ebcE6tdB8TNLSyJx1Su6wVXUFIjfnMMBGAjIJtVlb2vX5bt8a9KpRXN03wuAQPRwfT9yN0g2+bcdZZnW80SdFJZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:53:38 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:53:38 +0000
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
Cc: Or Gerlitz <ogerlitz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v26 10/20] net/mlx5e: Rename from tls to transport static params
Date: Fri, 21 Feb 2025 09:52:15 +0000
Message-Id: <20250221095225.2159-11-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0447.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::20) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: c928c184-2c08-424b-277f-08dd525d9b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RMu1jFSE39NpFeUIk1xrxnrpk0dvECHLB2WWJB6Z7wPeqWhq2AqVY5hzitOZ?=
 =?us-ascii?Q?j4X1hI4M6Syf3yGeS2RWBpwSeY9jiG/7K8W+mh/E7wvVjTo2pvntYTcaKNud?=
 =?us-ascii?Q?zHB6lNSTYJFckxGyFg9FH9FPWCw3+BDlDITmYbEOngC8kUEhMqJrYr+LHOff?=
 =?us-ascii?Q?+60rSG8xUg6JAr1EKXfN1B4JazNGsslMlhc/uLDnSb+K2y0iqHwtlGl00Fgx?=
 =?us-ascii?Q?XjlOLWh6AHw/xUHThiOflGydMrmUzj39+aYvymo4MCvY2xax1ewaSFts5iCr?=
 =?us-ascii?Q?ItUbiHVEfTH6dtlyWwhe7v97iOjvyvzM/+fcPqjT+Fwmoasem2fl49Z32SaG?=
 =?us-ascii?Q?Hh7jy2Ucft1eYOETxaPWTaNV9HuL6xYZKMldS4TCfrcztYdd69XqLpLyTeNc?=
 =?us-ascii?Q?pC5vItbdOBLg/1+A2xGrI+KpDjvmyVRmCSQqdSnyIFGHpQcxvEPg2+b3s+OM?=
 =?us-ascii?Q?i6SNzbZmJxSDiHG4Q4FUsPK+UnVIcA8KYk9vpRSwqvyrA6wCCuPudYzFHsd9?=
 =?us-ascii?Q?fO25kGfS/KUM6boCCgjh3Q7fk8/ebiI3MnTzhCVrpz/ly1VvdWKC1WMPzmsh?=
 =?us-ascii?Q?7rsV5373EBKXav7hQ8dh+WYbiFwE+pchUEu30OIjMjfK83L1rDBheKwglMtj?=
 =?us-ascii?Q?XX6SNbCE3K5XX1AtakcFjR9MZOQSJJBt3/sEAcNaa6CDujbt8KW17n25OgTK?=
 =?us-ascii?Q?TZfFN5nDYjea/5L5RGfXcggqVma0o6+sKprXp0nWMYN/F9XwuZ1ZdUxgyw1G?=
 =?us-ascii?Q?bahogO4xsdRkIZVpEH8RswsmLbqZoLPDs0TV+MJbprgCYM3HxHWWQBc7gXUy?=
 =?us-ascii?Q?ZPc/ZI8Bhi9kcRVYhJVspBGqC8v6O/Ua23fMY4RfkNmrlI12qyF26pKeNWfe?=
 =?us-ascii?Q?zdiLupS0hmZ8A2OvXu+lF+p61Ux5gd/grJ6oZbeD/1/FYKFZ9x6WmcL5wYnr?=
 =?us-ascii?Q?dnbd/K7+E7aMzo9o6jkSpbFWyFZl1qCHGWSVYoItwBs9mDK4AdgAwY4suMiM?=
 =?us-ascii?Q?VidTik2jFjJOw8reg6bwd1kDV29s+GbJ1Da64bPArZRLjbKM64IYZ4VIfvja?=
 =?us-ascii?Q?d7JEuuzFFBJqsNVYfnmCZ64A3txhZnQOra3gSqXzq+FR8/2GrJlo8PAw2+dE?=
 =?us-ascii?Q?eA9tFWLoFq017Qew80bRHinx5lfj8SIwnouIQ1S0uVCOY1SF5G06dRM2n3QG?=
 =?us-ascii?Q?qZDnGePBTmAjTf4YHLZaPQI+S4x+GsbzlUqhO+dUnp2kfCGX+cPo1PuYcRJV?=
 =?us-ascii?Q?E4Dqc31O6n8ob24wfpKgbFFrcTohIv5ijFUhr6+0bhzfCqKKJs533axOuQ7G?=
 =?us-ascii?Q?2CmUHwKrpsrjoh5CLUHASOkI7zRYtXN4SRbpO0JhfS3RnUCyVYd9IEFDjFtr?=
 =?us-ascii?Q?6ii7LTcE2bkdagL5e+5PWWswFpAP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cNIr2n2S5AHBlXcDC/FYxb5cFu6Ana/E2f8GU8Vlyk/VWH+6Xuvz2HzGXTn8?=
 =?us-ascii?Q?rqdZy9ymS5Z4IEwLrEHYQ7eSlf8j2xbBmAf+6Ya+9G88jabU04HUkBg2pJE0?=
 =?us-ascii?Q?Q9jOugkeOHObvDgqAl4k/iY+FvPEBuFiXt/HhTNMNw2dFzKw01Dd1OUqv9BC?=
 =?us-ascii?Q?CgTa+a9t/PvVoDpx4SrQv5W2qFjJuvnIfO5z/uNoD86txzgu2srCB8+6MBrk?=
 =?us-ascii?Q?p/9K2mteIzCdyMdp1RzSijxDbIyGAo20m0A09cOeQ92MHsWzT23Z6JwdOEW+?=
 =?us-ascii?Q?8WlmftQjEwUnXRHfyifzGM+CSLYPTsx9/jYfs5tZN4dOKyWWgxSoX+bKfsem?=
 =?us-ascii?Q?EDC0oBk7aLsYi7xpwbNOimINDOmw0EhHE/mz2SO1vIN24QtkDMHovbqNO7CZ?=
 =?us-ascii?Q?MGMMYE4Op0A4wGXafOf0LrJwZ9wt1rai5nhgfPeoOpxpX+l3Tx8/oB4ZGi6R?=
 =?us-ascii?Q?VKVXNAHD9XCBhcSSytGYhgelNoqRqCc97I+UUgnAsJX0Ou4PSD8XyqYi9QKp?=
 =?us-ascii?Q?81YdQRIhJ80KnhrvZLZPuExlBCX9GvNMREDFyuZIMiMMJerzOVlztDSSakmG?=
 =?us-ascii?Q?LFlhCn7jjdnD0UBqSDdYRGEmBpnOLyhwRMpiC4Jhgu7dIlFW90MLpKvMwOmi?=
 =?us-ascii?Q?H1do/1fNyM+oaNcoI5Hbd+vRDnvPzrN1ElJ5F6YE/4wfVsBDDNgzpGUaInKM?=
 =?us-ascii?Q?qOlNwu9912BsFd7kzcas2pzpAjmsoBIoFuKODtoez+7JebP0JqBlBepaAxRm?=
 =?us-ascii?Q?uC+4Es1IoXo+N5PuCU8pqHy521RMQMXdsI+25+EsHea7wCMAftop3sWj/up2?=
 =?us-ascii?Q?KE7jDO4TDcYorlDtVfKTBlOSW6ifbtcip5llxAII3VsUILWjhntIkjl/o/rY?=
 =?us-ascii?Q?/oNWwGq59PKy4smzHsB8GG1h1iNG0HgP5fDpSz0ULWV590mb7SixAOEtdpqm?=
 =?us-ascii?Q?Ic/roCq/9TqBknGDearnqk+t41JA2k6/xF9MP82eE1QyBpU7KVNECTmlrIub?=
 =?us-ascii?Q?duDa1R36mIwwChlRYQpo3VOPCtU+0Q6lxGs5jIcAbURztnVOpLa3pEgO16Tz?=
 =?us-ascii?Q?O8QEekuKZTUIt9EnVQ7ndnR8fBK6r6slvWMqRAiYnWIoSIks9T96Acj4fZzX?=
 =?us-ascii?Q?LbuR+ldJ7VxHM46SUbXFzudpUI6WJDW3U2dcGwwvRxtnLnFYrTuKVzsM6/k6?=
 =?us-ascii?Q?Fmael9MUTCeRl9b4i3WtQqWBuBQu3R85kU69c5OLwH5A53n65kcED9nNif+P?=
 =?us-ascii?Q?mMMwQ60QuADXogXrnp08yyPyVGu2891MjL30VFSjrXu4YZuTaqZer9Pg5VOg?=
 =?us-ascii?Q?OAXQhXxxROieGzOrCQiBFBtOPjnjcwrwvvRB3UxLgH3kYWtFNePN4m3Zxju8?=
 =?us-ascii?Q?B7RSujaX1u2/AwgqT2bq91O1GC8PZrsXCK4ZTK5J1bwRxa+1Mqb7qprsvcZS?=
 =?us-ascii?Q?i006MOsUl2Rf+gifWHfaMF6ITAi6hVbkZdvR6HDpXyUa9PQf8Dv66NVcO8rS?=
 =?us-ascii?Q?TeKEFdrd6u8Xghpk8sNoaCMZddD+vm2lm8ABmpvU9EhavS4A7Rus/otTm50j?=
 =?us-ascii?Q?/hDGDwd4FfrIGzGyt8XEhRRhyknUz4raTVSu0PbC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c928c184-2c08-424b-277f-08dd525d9b94
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:53:35.3627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyD8tlKcHu9aICTP0lMJ0v0ll7MA6jhtTWiytuEaNik/i8N+LDs+6jkulvtHhrKS9foa5SnjDNBW9Cs42QGE9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127

From: Or Gerlitz <ogerlitz@nvidia.com>

The static params structure is used in TLS but also in other
transports we're offloading like nvmeotcp:

- Rename the relevant structures/fields
- Create common file for appropriate transports
- Apply changes in the TLS code

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mlx5/core/en_accel/common_utils.h         | 32 +++++++++++++++++
 .../mellanox/mlx5/core/en_accel/ktls.c        |  2 +-
 .../mellanox/mlx5/core/en_accel/ktls_rx.c     |  6 ++--
 .../mellanox/mlx5/core/en_accel/ktls_tx.c     |  8 ++---
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   | 36 ++++++++-----------
 .../mellanox/mlx5/core/en_accel/ktls_utils.h  | 17 ++-------
 include/linux/mlx5/device.h                   |  8 ++---
 include/linux/mlx5/mlx5_ifc.h                 |  8 +++--
 8 files changed, 67 insertions(+), 50 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h
new file mode 100644
index 000000000000..efdf48125848
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/common_utils.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_COMMON_UTILS_H__
+#define __MLX5E_COMMON_UTILS_H__
+
+#include "en.h"
+
+struct mlx5e_set_transport_static_params_wqe {
+	struct mlx5_wqe_ctrl_seg ctrl;
+	struct mlx5_wqe_umr_ctrl_seg uctrl;
+	struct mlx5_mkey_seg mkc;
+	struct mlx5_wqe_transport_static_params_seg params;
+};
+
+/* macros for transport_static_params handling */
+#define MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS \
+	(DIV_ROUND_UP(sizeof(struct mlx5e_set_transport_static_params_wqe), MLX5_SEND_WQE_BB))
+
+#define MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi) \
+	((struct mlx5e_set_transport_static_params_wqe *)\
+	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_set_transport_static_params_wqe)))
+
+#define MLX5E_TRANSPORT_STATIC_PARAMS_WQE_SZ \
+	(sizeof(struct mlx5e_set_transport_static_params_wqe))
+
+#define MLX5E_TRANSPORT_STATIC_PARAMS_DS_CNT \
+	(DIV_ROUND_UP(MLX5E_TRANSPORT_STATIC_PARAMS_WQE_SZ, MLX5_SEND_WQE_DS))
+
+#define MLX5E_TRANSPORT_STATIC_PARAMS_OCTWORD_SIZE \
+	(MLX5_ST_SZ_BYTES(transport_static_params) / MLX5_SEND_WQE_DS)
+
+#endif /* __MLX5E_COMMON_UTILS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
index e3e57c849436..ab7468bddf42 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.c
@@ -100,7 +100,7 @@ bool mlx5e_is_ktls_rx(struct mlx5_core_dev *mdev)
 		return false;
 
 	/* Check the possibility to post the required ICOSQ WQEs. */
-	if (WARN_ON_ONCE(max_sq_wqebbs < MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS))
+	if (WARN_ON_ONCE(max_sq_wqebbs < MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS))
 		return false;
 	if (WARN_ON_ONCE(max_sq_wqebbs < MLX5E_TLS_SET_PROGRESS_PARAMS_WQEBBS))
 		return false;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index 65ccb33edafb..3c501466634c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -136,16 +136,16 @@ static struct mlx5_wqe_ctrl_seg *
 post_static_params(struct mlx5e_icosq *sq,
 		   struct mlx5e_ktls_offload_context_rx *priv_rx)
 {
-	struct mlx5e_set_tls_static_params_wqe *wqe;
+	struct mlx5e_set_transport_static_params_wqe *wqe;
 	struct mlx5e_icosq_wqe_info wi;
 	u16 pi, num_wqebbs;
 
-	num_wqebbs = MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS;
+	num_wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	if (unlikely(!mlx5e_icosq_can_post_wqe(sq, num_wqebbs)))
 		return ERR_PTR(-ENOSPC);
 
 	pi = mlx5e_icosq_get_next_pi(sq, num_wqebbs);
-	wqe = MLX5E_TLS_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
+	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
 	mlx5e_ktls_build_static_params(wqe, sq->pc, sq->sqn, &priv_rx->crypto_info,
 				       mlx5e_tir_get_tirn(&priv_rx->tir),
 				       mlx5_crypto_dek_get_id(priv_rx->dek),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
index 3db31cc10719..5e00e1a98eed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_tx.c
@@ -33,7 +33,7 @@ u16 mlx5e_ktls_get_stop_room(struct mlx5_core_dev *mdev, struct mlx5e_params *pa
 
 	num_dumps = mlx5e_ktls_dumps_num_wqes(params, MAX_SKB_FRAGS, TLS_MAX_PAYLOAD_SIZE);
 
-	stop_room += mlx5e_stop_room_for_wqe(mdev, MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS);
+	stop_room += mlx5e_stop_room_for_wqe(mdev, MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS);
 	stop_room += mlx5e_stop_room_for_wqe(mdev, MLX5E_TLS_SET_PROGRESS_PARAMS_WQEBBS);
 	stop_room += num_dumps * mlx5e_stop_room_for_wqe(mdev, MLX5E_KTLS_DUMP_WQEBBS);
 	stop_room += 1; /* fence nop */
@@ -550,12 +550,12 @@ post_static_params(struct mlx5e_txqsq *sq,
 		   struct mlx5e_ktls_offload_context_tx *priv_tx,
 		   bool fence)
 {
-	struct mlx5e_set_tls_static_params_wqe *wqe;
+	struct mlx5e_set_transport_static_params_wqe *wqe;
 	u16 pi, num_wqebbs;
 
-	num_wqebbs = MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS;
+	num_wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	pi = mlx5e_txqsq_get_next_pi(sq, num_wqebbs);
-	wqe = MLX5E_TLS_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
+	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
 	mlx5e_ktls_build_static_params(wqe, sq->pc, sq->sqn, &priv_tx->crypto_info,
 				       priv_tx->tisn,
 				       mlx5_crypto_dek_get_id(priv_tx->dek),
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
index 570a912dd6fa..8abea6fe6cd9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
@@ -8,10 +8,6 @@ enum {
 	MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2 = 0x2,
 };
 
-enum {
-	MLX5E_ENCRYPTION_STANDARD_TLS = 0x1,
-};
-
 #define EXTRACT_INFO_FIELDS do { \
 	salt    = info->salt;    \
 	rec_seq = info->rec_seq; \
@@ -20,7 +16,7 @@ enum {
 } while (0)
 
 static void
-fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
+fill_static_params(struct mlx5_wqe_transport_static_params_seg *params,
 		   union mlx5e_crypto_info *crypto_info,
 		   u32 key_id, u32 resync_tcp_sn)
 {
@@ -53,25 +49,25 @@ fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
 		return;
 	}
 
-	gcm_iv      = MLX5_ADDR_OF(tls_static_params, ctx, gcm_iv);
-	initial_rn  = MLX5_ADDR_OF(tls_static_params, ctx, initial_record_number);
+	gcm_iv      = MLX5_ADDR_OF(transport_static_params, ctx, gcm_iv);
+	initial_rn  = MLX5_ADDR_OF(transport_static_params, ctx, initial_record_number);
 
 	memcpy(gcm_iv,      salt,    salt_sz);
 	memcpy(initial_rn,  rec_seq, rec_seq_sz);
 
 	tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2;
 
-	MLX5_SET(tls_static_params, ctx, tls_version, tls_version);
-	MLX5_SET(tls_static_params, ctx, const_1, 1);
-	MLX5_SET(tls_static_params, ctx, const_2, 2);
-	MLX5_SET(tls_static_params, ctx, encryption_standard,
-		 MLX5E_ENCRYPTION_STANDARD_TLS);
-	MLX5_SET(tls_static_params, ctx, resync_tcp_sn, resync_tcp_sn);
-	MLX5_SET(tls_static_params, ctx, dek_index, key_id);
+	MLX5_SET(transport_static_params, ctx, tls_version, tls_version);
+	MLX5_SET(transport_static_params, ctx, const_1, 1);
+	MLX5_SET(transport_static_params, ctx, const_2, 2);
+	MLX5_SET(transport_static_params, ctx, acc_type,
+		 MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS);
+	MLX5_SET(transport_static_params, ctx, resync_tcp_sn, resync_tcp_sn);
+	MLX5_SET(transport_static_params, ctx, dek_index, key_id);
 }
 
 void
-mlx5e_ktls_build_static_params(struct mlx5e_set_tls_static_params_wqe *wqe,
+mlx5e_ktls_build_static_params(struct mlx5e_set_transport_static_params_wqe *wqe,
 			       u16 pc, u32 sqn,
 			       union mlx5e_crypto_info *crypto_info,
 			       u32 tis_tir_num, u32 key_id, u32 resync_tcp_sn,
@@ -80,19 +76,17 @@ mlx5e_ktls_build_static_params(struct mlx5e_set_tls_static_params_wqe *wqe,
 	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
 	struct mlx5_wqe_ctrl_seg     *cseg  = &wqe->ctrl;
 	u8 opmod = direction == TLS_OFFLOAD_CTX_DIR_TX ?
-		MLX5_OPC_MOD_TLS_TIS_STATIC_PARAMS :
-		MLX5_OPC_MOD_TLS_TIR_STATIC_PARAMS;
-
-#define STATIC_PARAMS_DS_CNT DIV_ROUND_UP(sizeof(*wqe), MLX5_SEND_WQE_DS)
+		MLX5_OPC_MOD_TRANSPORT_TIS_STATIC_PARAMS :
+		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
 
 	cseg->opmod_idx_opcode = cpu_to_be32((pc << 8) | MLX5_OPCODE_UMR | (opmod << 24));
 	cseg->qpn_ds           = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) |
-					     STATIC_PARAMS_DS_CNT);
+					     MLX5E_TRANSPORT_STATIC_PARAMS_DS_CNT);
 	cseg->fm_ce_se         = fence ? MLX5_FENCE_MODE_INITIATOR_SMALL : 0;
 	cseg->tis_tir_num      = cpu_to_be32(tis_tir_num << 8);
 
 	ucseg->flags = MLX5_UMR_INLINE;
-	ucseg->bsf_octowords = cpu_to_be16(MLX5_ST_SZ_BYTES(tls_static_params) / 16);
+	ucseg->bsf_octowords = cpu_to_be16(MLX5E_TRANSPORT_STATIC_PARAMS_OCTWORD_SIZE);
 
 	fill_static_params(&wqe->params, crypto_info, key_id, resync_tcp_sn);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h
index 3d79cd379890..5e2d186778aa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_utils.h
@@ -6,6 +6,7 @@
 
 #include <net/tls.h>
 #include "en.h"
+#include "en_accel/common_utils.h"
 
 enum {
 	MLX5E_TLS_PROGRESS_PARAMS_AUTH_STATE_NO_OFFLOAD     = 0,
@@ -33,13 +34,6 @@ union mlx5e_crypto_info {
 	struct tls12_crypto_info_aes_gcm_256 crypto_info_256;
 };
 
-struct mlx5e_set_tls_static_params_wqe {
-	struct mlx5_wqe_ctrl_seg ctrl;
-	struct mlx5_wqe_umr_ctrl_seg uctrl;
-	struct mlx5_mkey_seg mkc;
-	struct mlx5_wqe_tls_static_params_seg params;
-};
-
 struct mlx5e_set_tls_progress_params_wqe {
 	struct mlx5_wqe_ctrl_seg ctrl;
 	struct mlx5_wqe_tls_progress_params_seg params;
@@ -50,19 +44,12 @@ struct mlx5e_get_tls_progress_params_wqe {
 	struct mlx5_seg_get_psv  psv;
 };
 
-#define MLX5E_TLS_SET_STATIC_PARAMS_WQEBBS \
-	(DIV_ROUND_UP(sizeof(struct mlx5e_set_tls_static_params_wqe), MLX5_SEND_WQE_BB))
-
 #define MLX5E_TLS_SET_PROGRESS_PARAMS_WQEBBS \
 	(DIV_ROUND_UP(sizeof(struct mlx5e_set_tls_progress_params_wqe), MLX5_SEND_WQE_BB))
 
 #define MLX5E_KTLS_GET_PROGRESS_WQEBBS \
 	(DIV_ROUND_UP(sizeof(struct mlx5e_get_tls_progress_params_wqe), MLX5_SEND_WQE_BB))
 
-#define MLX5E_TLS_FETCH_SET_STATIC_PARAMS_WQE(sq, pi) \
-	((struct mlx5e_set_tls_static_params_wqe *)\
-	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_set_tls_static_params_wqe)))
-
 #define MLX5E_TLS_FETCH_SET_PROGRESS_PARAMS_WQE(sq, pi) \
 	((struct mlx5e_set_tls_progress_params_wqe *)\
 	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_set_tls_progress_params_wqe)))
@@ -76,7 +63,7 @@ struct mlx5e_get_tls_progress_params_wqe {
 	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_dump_wqe)))
 
 void
-mlx5e_ktls_build_static_params(struct mlx5e_set_tls_static_params_wqe *wqe,
+mlx5e_ktls_build_static_params(struct mlx5e_set_transport_static_params_wqe *wqe,
 			       u16 pc, u32 sqn,
 			       union mlx5e_crypto_info *crypto_info,
 			       u32 tis_tir_num, u32 key_id, u32 resync_tcp_sn,
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 0c48b20f818a..c1c4589794ae 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -457,8 +457,8 @@ enum {
 };
 
 enum {
-	MLX5_OPC_MOD_TLS_TIS_STATIC_PARAMS = 0x1,
-	MLX5_OPC_MOD_TLS_TIR_STATIC_PARAMS = 0x2,
+	MLX5_OPC_MOD_TRANSPORT_TIS_STATIC_PARAMS = 0x1,
+	MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS = 0x2,
 };
 
 enum {
@@ -466,8 +466,8 @@ enum {
 	MLX5_OPC_MOD_TLS_TIR_PROGRESS_PARAMS = 0x2,
 };
 
-struct mlx5_wqe_tls_static_params_seg {
-	u8     ctx[MLX5_ST_SZ_BYTES(tls_static_params)];
+struct mlx5_wqe_transport_static_params_seg {
+	u8     ctx[MLX5_ST_SZ_BYTES(transport_static_params)];
 };
 
 struct mlx5_wqe_tls_progress_params_seg {
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 4f3716e124c9..2936580c35da 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -12881,12 +12881,16 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_PURPOSE_MACSEC = 0x4,
 };
 
-struct mlx5_ifc_tls_static_params_bits {
+enum {
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS               = 0x1,
+};
+
+struct mlx5_ifc_transport_static_params_bits {
 	u8         const_2[0x2];
 	u8         tls_version[0x4];
 	u8         const_1[0x2];
 	u8         reserved_at_8[0x14];
-	u8         encryption_standard[0x4];
+	u8         acc_type[0x4];
 
 	u8         reserved_at_20[0x20];
 
-- 
2.34.1


