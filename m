Return-Path: <netdev+bounces-140714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E639B7B36
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5591B24384
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07C919C55C;
	Thu, 31 Oct 2024 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nYaELqOT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C311BD9E4
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379601; cv=fail; b=XXoweuR5faSu+eEXr/1cLP+VnQcppqFS6l4Mm8JRvaYdqZAGeKNdCakBKSyh3N+lJglNupKyBxgrb+nQSAf3UvzLXczmVNeL9GIELMN3TKQQS+e92iZpUQOlEB4lZn59Dfy6rmr7vHbf24u7CTyyqB8qZR2bFBFwkLn/Z3wMHDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379601; c=relaxed/simple;
	bh=ARb+katsooqZGb4V1v+EDk6WAq4zb+/o+qXWqvG4Blo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Od/w0LIAA8JszqtAaM/Goa6bV4f5xISRMnF5TMgdm10xj2+XX1J84B8ji4U+HDJu3k0dQsAZgD1VVsvm7vYWY24+u/zKpZxLMQVCmzxgnwDDrF4yv0kOjFLv/5aHgPU3qNumSxNW7DsaYyWmgibBV8ED5Gqb16jhv3sdi5bzGzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nYaELqOT; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1l3OVaSvlqf5OlH9PuMBbqU4LTOiEwzqVsJ6H0e5OQ/cIFUx5cLDrb4Ich5y7AzaQenbgZHKn001rZzNqyJb3mTVNi035wFF6nkYa/5dutBr39U6zT+huk41/k/5jfgnCp0KL5/Bep1be6HXshuSRSkohP8r8JdC9/xjll17tpTkRv3kSb6M/aT9ombM39uFjwUc/IpgUNzxVAoibTROBN0DKDwps2xBE2mTZoYNDpUZICcdgszLAohwRRI2UgyG9/aDrPKJ1Rb7uhoZyChaaXQkWu3ryRt0iPhheLFbx6Zz/SM/EK/GkD3ZYn6FOkzIZ3Cyw5gMr4jnI5HZkoAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAQLQika97ZjrA7GU2s7Ct8PgEjwxtX1SqYhmgqRfTg=;
 b=SSi0RxnWoQDGnEJXPmDZzn059DpZLrsecwzBpjjLk4LGRqaVeAKs5CXMFh4jMDcJrQ4jj6J+FUw6gwtlcZc5d8O5xGJFRgnrID42iD0xYhjC1BVkzbuAiRtXW/bv59ulBQp15skRccQb33ANlj5aJzWOMhERPRhdQh7RY703lb3yfiBZ50ebllYVH7S3PLKgEH+0yebgJ4l0dZ0J62gwZGxvcVadcOT1H07y9FQGRCyk+XBMPjGDlr1C+Nc53ch3fkUuTnN1RIEEzyn7xw4lzS9pAlZZZoUPWqRBHvMJ0696xMUsaqNb1H7dKzSkNMxvmyvtQzmohnhrpRlpp2Yh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAQLQika97ZjrA7GU2s7Ct8PgEjwxtX1SqYhmgqRfTg=;
 b=nYaELqOTVX5K4h9Ib8wTO081fd8x4lUD3Y0henr+m2Ckzr32i+/yAPkBpQ89gwtkHUGr/2K69YURpOFc/TOOmExVpOAQhG/oHcuNoNZR8Y2LakBLpJ9Yyd/fZd7MbD2m4twnd0GanqJUNPQwcyek8GUj6gOD2GiOulaDljwdN7X2b8/dHzOSNoR5WWjKbfDt1mLs5pcrVc1yrltwO1dgBb/cUUlKXshpS03dgiYZAqIvAr5qOC7iEwh+Tu6ORKzMSb5lUkgvMo4OwS4UNqzFpnD6WtDyavpWg3pFrggVed8zpJW1XlybnCBcneOn87PaDtwoVEzyuDrdlnRIjxzrGA==
Received: from CH2PR07CA0065.namprd07.prod.outlook.com (2603:10b6:610:5b::39)
 by SA3PR12MB9180.namprd12.prod.outlook.com (2603:10b6:806:39b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 12:59:53 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::5e) by CH2PR07CA0065.outlook.office365.com
 (2603:10b6:610:5b::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 12:59:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 12:59:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 31 Oct
 2024 05:59:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 31 Oct 2024 05:59:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 31 Oct 2024 05:59:33 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 0/5] mlx5 misc patches 2024-10-31
Date: Thu, 31 Oct 2024 14:58:51 +0200
Message-ID: <20241031125856.530927-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SA3PR12MB9180:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ead9ec-0545-4dcd-4faf-08dcf9abe9a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tBZSiZiuvth2VU89Fn36R8SKL1XRckH20ygEs/XadSDorm8Zj0Wkt15/Anmy?=
 =?us-ascii?Q?FZLdCBqQsKyXCdgCV/s3AO0ACs1J7jNy/hDRAFRlHVURojHx9Iv+yXwzKcUH?=
 =?us-ascii?Q?IcqgZlOLf3L50UVJfCuzfZD/0n5CrxrtADmjfHusWfCA8franFU6MhUqK7Um?=
 =?us-ascii?Q?XEx59qrrQWeaq/oei+18KsQ9gKAp2E5qPxRd/1L/dvgi37IWtekAn8D7B8s5?=
 =?us-ascii?Q?ACyc2ngDBj2tgTYN7GA4wgrfWk3MZE+1og19sDInRA6oPK0Gl2taxweNMdEq?=
 =?us-ascii?Q?ffoXkD0vJRDYbet7SsnVjPMGeeiDE+qfPkxtCwRNmRe5pnlFEVPn4UAweu7+?=
 =?us-ascii?Q?ybGPUh5h/TfpWRcfMtm5zvW49StTJOYjUut6g2SajwTD8sfNTruN9jGmTcyy?=
 =?us-ascii?Q?3OBLeDlytKoRnii4oVw3fyccaXlxg1PImGpMHKEoFJyg2djkA1kNBhPdisY4?=
 =?us-ascii?Q?7UYkXFHWUCEryw49JxhNL0aBsAxXLrPaf5WyYHcVzyTRthVoZ16ZlhO5hbZl?=
 =?us-ascii?Q?MXp/or9E1WZcTy+Um9wlzwyMFwoEh2qdxUtGUUeaihm+Luf+7MZG2dUnsqil?=
 =?us-ascii?Q?3cZ2REgtu3um4rQ82etV0TfAkI4MYTUzEhvsUoLqZIjs9RqedbVeiG5Wbv7Z?=
 =?us-ascii?Q?bU1KMU+O6Uyw9wdmBviuIyYX1D7spNUVqbvwuMdq8YHx+2eD/DOvtjMWjWUi?=
 =?us-ascii?Q?3FdO1d/o1dWOxEcG4JZEPLoAoLpcg9r/hN1f5I7O3lu97rA1/BazE9MrlG8n?=
 =?us-ascii?Q?XqxYv3CQsjZ3/jKQKSvOdJ8LnicePQ9C4gF52MDhdf+bIMiqqx2kLu4i2yMr?=
 =?us-ascii?Q?uKfFaJ6CXFbQA71iHK25pcCfBt6Knv3Ckg9moZQMfKrHX5TL4OiCmjPFQRJx?=
 =?us-ascii?Q?is9wLbKTQ5hC8X0EWvrJJPluCbfAZW+LHKUikdEj4DBIvh9rrrSq5dRVKiIk?=
 =?us-ascii?Q?3h3IqIPh20KLDzr+8NFvMYyu7IRK9UHQOljICrYidPdOi6q5jteYrGtvfbtp?=
 =?us-ascii?Q?ul1GRr+TTunQ5rkTknHtVj7xqXeycZ/XohZTq2wxOOPvae7N7pW/iqtUp1JU?=
 =?us-ascii?Q?YGJC80yubrUtoRDAfldvzggUX1RjZuBbo8hz8riq70vlSPgL3IS0LvDzclkq?=
 =?us-ascii?Q?wGF0tlbJ905ezvbpW9gVvBR1VfYBzuSBQ4R2Y8OQgWJbL73LyTeDpFSJED7K?=
 =?us-ascii?Q?C/cfvgzKUWSLDk2iVqwEKuoiu+X51aJ5Kdu/W44mwAFdGR2k0Ar6iOTSCvvv?=
 =?us-ascii?Q?OWI+RdklJrwIFMZXoCMLjjhHJzM1eu+mjeawsaY6CN3GjWvfRF1Y2X+eZNxB?=
 =?us-ascii?Q?z9AbZrw1gGNMfci7iL/W5rb8m8LTPAwqvf3xuB8yE1aEJ8m/8TnTcrlDUOsE?=
 =?us-ascii?Q?OuhPwdUXSeslS4xjWktAjMsKPfZHsjrLMhdMFgpFsYiKafsV4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 12:59:53.3207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ead9ec-0545-4dcd-4faf-08dcf9abe9a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9180

Hi,

This patchset for the mlx5 driver contains small misc patches.

First patch by Cosmin fixes an issue in a recent commit.

Followed by 2 patches by Yevgeny that organize and rename the files
under the steering directory.

Finally, 2 patches by William that save the creation of the unused
egress-XDP_REDIRECT send queue on non-uplink representor.

Series generated against:
commit 2b1d193a5a57 ("Documentation: networking: Add missing PHY_GET command in the message list")

Thanks,
Tariq

Cosmin Ratiu (1):
  net/mlx5: Rework esw qos domain init and cleanup

William Tu (2):
  net/mlx5e: move XDP_REDIRECT sq to dynamic allocation
  net/mlx5e: do not create xdp_redirect for non-uplink rep

Yevgeny Kliteynik (2):
  net/mlx5: DR, moved all the SWS code into a separate directory
  net/mlx5: HWS, renamed the files in accordance with naming convention

 .../net/ethernet/mellanox/mlx5/core/Makefile  | 63 +++++++++-------
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 73 ++++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |  6 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c |  3 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 16 ++--
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  2 +-
 .../ethernet/mellanox/mlx5/core/lib/smfs.h    |  4 +-
 .../hws/{mlx5hws_action.c => action.c}        |  2 +-
 .../hws/{mlx5hws_action.h => action.h}        |  6 +-
 .../steering/hws/{mlx5hws_buddy.c => buddy.c} |  4 +-
 .../steering/hws/{mlx5hws_buddy.h => buddy.h} |  6 +-
 .../steering/hws/{mlx5hws_bwc.c => bwc.c}     |  2 +-
 .../steering/hws/{mlx5hws_bwc.h => bwc.h}     |  6 +-
 .../{mlx5hws_bwc_complex.c => bwc_complex.c}  |  2 +-
 .../{mlx5hws_bwc_complex.h => bwc_complex.h}  |  6 +-
 .../steering/hws/{mlx5hws_cmd.c => cmd.c}     |  2 +-
 .../steering/hws/{mlx5hws_cmd.h => cmd.h}     |  6 +-
 .../hws/{mlx5hws_context.c => context.c}      |  2 +-
 .../hws/{mlx5hws_context.h => context.h}      |  6 +-
 .../steering/hws/{mlx5hws_debug.c => debug.c} |  2 +-
 .../steering/hws/{mlx5hws_debug.h => debug.h} |  6 +-
 .../hws/{mlx5hws_definer.c => definer.c}      |  2 +-
 .../hws/{mlx5hws_definer.h => definer.h}      |  6 +-
 .../hws/{mlx5hws_internal.h => internal.h}    | 36 ++++-----
 .../hws/{mlx5hws_matcher.c => matcher.c}      |  2 +-
 .../hws/{mlx5hws_matcher.h => matcher.h}      |  6 +-
 .../hws/{mlx5hws_pat_arg.c => pat_arg.c}      |  2 +-
 .../hws/{mlx5hws_pat_arg.h => pat_arg.h}      |  0
 .../steering/hws/{mlx5hws_pool.c => pool.c}   |  4 +-
 .../steering/hws/{mlx5hws_pool.h => pool.h}   |  0
 .../steering/hws/{mlx5hws_prm.h => prm.h}     |  0
 .../steering/hws/{mlx5hws_rule.c => rule.c}   |  2 +-
 .../steering/hws/{mlx5hws_rule.h => rule.h}   |  0
 .../steering/hws/{mlx5hws_send.c => send.c}   |  2 +-
 .../steering/hws/{mlx5hws_send.h => send.h}   |  0
 .../steering/hws/{mlx5hws_table.c => table.c} |  2 +-
 .../steering/hws/{mlx5hws_table.h => table.h} |  0
 .../steering/hws/{mlx5hws_vport.c => vport.c} |  2 +-
 .../steering/hws/{mlx5hws_vport.h => vport.h} |  0
 .../mlx5/core/steering/{ => sws}/dr_action.c  |  0
 .../mlx5/core/steering/{ => sws}/dr_arg.c     |  0
 .../mlx5/core/steering/{ => sws}/dr_buddy.c   |  0
 .../mlx5/core/steering/{ => sws}/dr_cmd.c     |  0
 .../mlx5/core/steering/{ => sws}/dr_dbg.c     |  0
 .../mlx5/core/steering/{ => sws}/dr_dbg.h     |  0
 .../mlx5/core/steering/{ => sws}/dr_definer.c |  0
 .../mlx5/core/steering/{ => sws}/dr_domain.c  |  0
 .../mlx5/core/steering/{ => sws}/dr_fw.c      |  0
 .../core/steering/{ => sws}/dr_icm_pool.c     |  0
 .../mlx5/core/steering/{ => sws}/dr_matcher.c |  0
 .../mlx5/core/steering/{ => sws}/dr_ptrn.c    |  0
 .../mlx5/core/steering/{ => sws}/dr_rule.c    |  0
 .../mlx5/core/steering/{ => sws}/dr_send.c    |  0
 .../mlx5/core/steering/{ => sws}/dr_ste.c     |  0
 .../mlx5/core/steering/{ => sws}/dr_ste.h     |  0
 .../mlx5/core/steering/{ => sws}/dr_ste_v0.c  |  0
 .../mlx5/core/steering/{ => sws}/dr_ste_v1.c  |  0
 .../mlx5/core/steering/{ => sws}/dr_ste_v1.h  |  0
 .../mlx5/core/steering/{ => sws}/dr_ste_v2.c  |  0
 .../mlx5/core/steering/{ => sws}/dr_table.c   |  0
 .../mlx5/core/steering/{ => sws}/dr_types.h   |  0
 .../mlx5/core/steering/{ => sws}/fs_dr.c      |  0
 .../mlx5/core/steering/{ => sws}/fs_dr.h      |  0
 .../core/steering/{ => sws}/mlx5_ifc_dr.h     |  0
 .../steering/{ => sws}/mlx5_ifc_dr_ste_v1.h   |  0
 .../mlx5/core/steering/{ => sws}/mlx5dr.h     |  0
 69 files changed, 177 insertions(+), 121 deletions(-)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_action.c => action.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_action.h => action.h} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_buddy.c => buddy.c} (98%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_buddy.h => buddy.h} (86%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_bwc.c => bwc.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_bwc.h => bwc.h} (96%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_bwc_complex.c => bwc_complex.c} (98%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_bwc_complex.h => bwc_complex.h} (90%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_cmd.c => cmd.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_cmd.h => cmd.h} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_context.c => context.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_context.h => context.h} (95%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_debug.c => debug.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_debug.h => debug.h} (93%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_definer.c => definer.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_definer.h => definer.h} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_internal.h => internal.h} (67%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_matcher.c => matcher.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_matcher.h => matcher.h} (96%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_pat_arg.c => pat_arg.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_pat_arg.h => pat_arg.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_pool.c => pool.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_pool.h => pool.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_prm.h => prm.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_rule.c => rule.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_rule.h => rule.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_send.c => send.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_send.h => send.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_table.c => table.c} (99%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_table.h => table.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_vport.c => vport.c} (98%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/hws/{mlx5hws_vport.h => vport.h} (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_action.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_arg.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_buddy.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_cmd.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_dbg.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_dbg.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_definer.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_domain.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_fw.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_icm_pool.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_matcher.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ptrn.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_rule.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_send.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ste.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ste.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ste_v0.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ste_v1.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ste_v1.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_ste_v2.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_table.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/dr_types.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/fs_dr.c (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/fs_dr.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/mlx5_ifc_dr.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/mlx5_ifc_dr_ste_v1.h (100%)
 rename drivers/net/ethernet/mellanox/mlx5/core/steering/{ => sws}/mlx5dr.h (100%)

-- 
2.44.0


