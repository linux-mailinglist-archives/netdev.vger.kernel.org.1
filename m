Return-Path: <netdev+bounces-186979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EEFAA4624
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2381BC74DD
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8A021D3D6;
	Wed, 30 Apr 2025 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nfaXNj9S"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0489821D5BC
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003535; cv=fail; b=cFkRqdpny6o5hoWKKDSaHWBQBphekFXajxyIyjQed4YHWUVtwhcqnw1tssYUdDkSgD8FNPBTQ3fORLzJwASESoy/pzEuhfUJJT3HpF1ySX+pVcIB9fuJnsRDw9bDdzEVOM6Wg7ogcAkwNaPH/kiu4KDppggCgnTjUEexyubylB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003535; c=relaxed/simple;
	bh=KnjtOf4CJuJagzt2B/fUijwp+MJLl/bV6xJQmrVjZbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bsf1mravnGoCaBdvTgv6oLCOxW6PJ6oD+BG+FF1U/Oei1RmtJm50VBw+TASB3G1yuZIbx+Jt7/4o4MllR3WsR6Tp6VbtoM29FcXSdgtRu9cTYeTWL2Pdy4ENO6+hNCCSSSJRWGNX9eCHqNlFQrdCfgHZp2OYGetEXNgESOAKi30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nfaXNj9S; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLUciKrmBQ+9yhcI563Jb1DB7wE2bBxajet9ejyyGf+IVXN/4kzmxucUpq8nPlKrPL1G5fGgD6atv28xPWndqLdwN8VMmICnQps+L1S7HIzFqNyBz5HbwUkOXYbrob7c76mzbBcA6/crWDpAJFuLvbT6xSZMiXzEwc/sDqwSAmZOTWUXxjn6o/HJigKpxpNbmcl+n67trYplB0Kxjl6WuQZ7g8/ItvgWbxdzwIjezHVYud8D2KIRlY+q979xKHkWQDFqDx3VCNjYOCoGERcm2B6OzDY97XdDZ1FArL8pjvTbz2gMQW8/pWZEzUR2dbXqoOCBk8tdA04CnKmsjyxB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCs3+vjvop7JtqpsrJC1ErZSM3pZ8871ZHCdYgywa+4=;
 b=U7fVbSX1WqKj0ugDnY51yySQbH0FboIHZzA5uicVTsH/91VTCxnNRe4cCxsSFeWBYc53xAwQ1RupU+cHWN8fPgReQSXZ6HPXCEmMeDcaJk7uFjIFJWX4MygNQnm8b8AcR6lLvcKOJ7/thKRb/lSQARmqeU4zD23NPUCjIVAWfeawBIFmlLOCqOwGxSk5aBqHNUXUcZhp5x55wHSCMFZs7MkuiE9yDgFeEDSqOOwxdX2HDMc2hak+Feqokmd/Q+1swvlbI1ylXMpwyRjguAaN+4du/9mD65CmqTcJ2busmDoTIRZmcmdmK9UrMh5S5++PTc/4VPtJEESO+V/Paaz1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCs3+vjvop7JtqpsrJC1ErZSM3pZ8871ZHCdYgywa+4=;
 b=nfaXNj9SCBgBGZ8UoHRqJ8pklDaZsV3lzC2zFpxQcOWWV98ZorOrRmbHuRrLmYvtSCNcixhqSmSreZAWwELw7WZP1xcdvQ12di07CTsVgdtzoxYnImwb2Ibc8wKvS4rWsrcjBUyyU21JvrvIrVc2bGokh5M1xpc7cemmYZ+3v+G1swdRIXi003g4fEYdUAmAxpSqXfLF9RyTm5HNRD4aA2iTXlppQYvIKDfLX5h/7xcMlCFFZwDAAq0BTnSeY/20vJdiJ1ZmiJW9zReIrhFTrZirB/2DBQ+dNgAfUukd0YrAW435jO246ng5NU3rqJkZNRntw8rksHw1sLOtFSK5iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 30 Apr
 2025 08:58:51 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:58:50 +0000
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
Subject: [PATCH v28 12/20] net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
Date: Wed, 30 Apr 2025 08:57:33 +0000
Message-Id: <20250430085741.5108-13-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430085741.5108-1-aaptel@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9f1d38-2de0-4d75-9e9c-08dd87c539c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b/nb36lGtC1uY/1At8EUZZQ86sln8F/BiFUa4pTzg2srYPFGPBtNL/TKFlQ/?=
 =?us-ascii?Q?CIGH357r0X4HdgM8Wfrg96YQBJ41XHlm8iHPoMQ9s9yHppepUoUIt+Ab8vjQ?=
 =?us-ascii?Q?1Vj2WhcsYPlKr4JwyICX/v7EBfr669/pCQEoHCuDNCdBgpXH2eFLI4pP27xR?=
 =?us-ascii?Q?LkcroknEX4h1n0IrRT5rYa+IPkrggh8XeBr5Vc/TT3gz69qyfY8mUKXFY3+4?=
 =?us-ascii?Q?6Qc3DmPls4VC4MVYTbiAs3H5Mach32n2is8e6PLh4e8WwiI1RTwwNX6aWpHz?=
 =?us-ascii?Q?UUlbsEsghBIPXygoTCQn24qqYrpqjtmJiGO4KlRTHmfZwDmFVvIhYz7U7Ol/?=
 =?us-ascii?Q?sQ9beXZ+sg8DEwm+QD7YGXkCxPsBV2MklUai1BqspqVqtOhpBSGSwKhYSCcs?=
 =?us-ascii?Q?cIUqs9J03RV+DfXuWFJpTpiAcQSgWw80nx1wP1AdNAPE6UShemTbjscx15RK?=
 =?us-ascii?Q?CNPUn6i2L7ApQXCGYToYt9pYtha8Fs9s6PbKOxuYt5kkb2HCLYFyNZJE1CUK?=
 =?us-ascii?Q?6klZ4mRSTBLryHHqpeb7S6euy3yjfzZCGJFnq9yMZRBqbMoXKNLZiKNdG7zM?=
 =?us-ascii?Q?hVnpeNZEwSAicyx7wZ4US/MjXg/zk5xv1WZ7v2xuWTXFeScgtaBmJdA9nKGk?=
 =?us-ascii?Q?svpRHpiDhLzni7HFO0NpakSPYQGNXaz4Qb1R73OLbpjHRSOeO8dcrCQjVUwt?=
 =?us-ascii?Q?lJWvlGizYWWsjNwgn5oIxjvkJa7V4L346Sr+o2iOIcw1V0L6L4xA6U+yaccN?=
 =?us-ascii?Q?yAVShiiZhlV+AFFK66e+7x7mHx6Wtw+6UNepJGBJlYR3qBniBaDHoxWEY54T?=
 =?us-ascii?Q?ot/6NtSRWOhUF+pmfC1pCWRqKdLkBN8OzABhTk3USL27viHvVbJwXEc8MYee?=
 =?us-ascii?Q?x+7fEcAFAPZMzgv7xRLRrA40ZGOfUlP/M7gxbNcw4kfE3jD/bPzLWufRfcfZ?=
 =?us-ascii?Q?u/qrTDjbAcBKxzcJAhokjSeZ5vWSfoa8/4FUjsEKnwnSrg14bl+vsI2QgJ9C?=
 =?us-ascii?Q?HNzc/d12pHR6SFrrpl0JH5sEcyWWnF7nC9jXHaNOm2C1BZuI+qdV9Ij4D/fZ?=
 =?us-ascii?Q?r18GKL8kflKsqTQedFeglwDSSyUfJAdhtENBlGh0NCAqdjMGUWC1XSueyJz2?=
 =?us-ascii?Q?bcD6klSh0s2nUWEWoqWvhfGjpMdnCgwmGhDeKgNRZANQWDCm9Rzp+/6OsnuO?=
 =?us-ascii?Q?jn98jdsxNtW5/SePQXyb539aJFPwyqXm9cqzNnR2X0RQp1+TD8VvEeBtqzQ+?=
 =?us-ascii?Q?FWc7cptUzZxB6DMajxH022tdQIwbSyk+HaqzWF0TGb4H0Jpr4qB2cM8AvQqq?=
 =?us-ascii?Q?NeZy+bmbDYa6YPceMYgBb1mLNtlk4SCU25vHf1+GER8GMOQnYNPAYvRuXeZR?=
 =?us-ascii?Q?m3p4TmjSRbzCQsFOjF6m5Mt3R29t1rib1jzKncrqdd6g3rn4d0BpWBzh4oz2?=
 =?us-ascii?Q?6NkewDgFoVA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AVbDi37K3c77OqURpFQjB9/prD7TSnAcvppE53gVvpRYSlKYZpox+W4M9aWL?=
 =?us-ascii?Q?W88KY+mjwTYawPJK04fePu5dRvLF6o0HVOT3Jrbrb5lAxWwN4fxOH3KFdQZP?=
 =?us-ascii?Q?2C+aO9L0tOZQCNgbr8dNB8VJvGEGpb/AvEV0q51UVHaRqqkxUtZKcb2wM+ed?=
 =?us-ascii?Q?fSyP/lfxt1qBsqiZlYCIbOkvAIXg/yXYZDfldZ2TaDON4hbeU5FivGMjYwiW?=
 =?us-ascii?Q?/31VRAwaZnV1SDw9IvsG+/sTGuA5xevAUPVrEil0notsdfRGrZkQgLaQsuBK?=
 =?us-ascii?Q?W05nmPc8d65IioNRh3B1C5Wh9DdKFiBAMw7UBTWMIaVeHnyhVcdlYFaPNyGf?=
 =?us-ascii?Q?eZ3JZEOKngQH/D3iXtiEmQhy8afReHwUNA33+8im3wBGWIGyznav0ibbBYYr?=
 =?us-ascii?Q?FNe3FAlsoBgqkKzZ9H7IoKJVxtQjaIxUCig8bZQLxiN4Em1FMjm0646XDEOK?=
 =?us-ascii?Q?mRPU2e+hxwK/RcI95yLVp/As1nW2ShjbxIY4EkjOu40SVM+RuwF4s0i4xr/V?=
 =?us-ascii?Q?mVViqCvw6RNql6CKR0CSBM0Ne4Nfgx7ulR8itb9BRWT+Jr4yzW0VwJ25//xY?=
 =?us-ascii?Q?3zmlw09YzayMd5bfGmY/W1udBjeelgI5fnGGddbNx0ZGvCufLP1oiyMVHFwQ?=
 =?us-ascii?Q?h2Gb4XdTMKX7iXN3PkKEqQc/EjnFjbraDCWL37HqK8QsQLve2F9+yAeOtkRc?=
 =?us-ascii?Q?LK3rRCW9x3n0JGj4dRqtVao75OZ6JS4IsAcr+2ESB/VZaK/hiRVZK1FY0w+1?=
 =?us-ascii?Q?YO3zrtghB+VFSZcAEcq7UTBNo3kss1O3MGbkEWwhZDwOM2Duh+60MPE9lNuj?=
 =?us-ascii?Q?9EyfuXk/soSKWRwuBZvO81W87cYfSpHgGXERKIC0SLsQev2CVbjGSu1UKzXt?=
 =?us-ascii?Q?tSsc3PQ/CBNEy2nYfUVelxfQc6/lix8w8gNEZy478UQo6BjL1HKN1+kpx0A8?=
 =?us-ascii?Q?eJeHwpUsAC+zKW0x3RXFWHHe955TvukxHMaENV12M/pgHjXdXxS7X6O09/ot?=
 =?us-ascii?Q?OSTThaemAlfOUsCnL2hKXX92Z4B4FZ2hqlGdjsNHWz31JpqVsW8KCKUtFHcw?=
 =?us-ascii?Q?GBl7gl/1cPGAbF4pgoyCPsN4pEnsntMbCRgV6avhqodwh/i0uVw2BVM/wXaN?=
 =?us-ascii?Q?nvPuXys7mKYsz5DyznCyARf/c2eC9GGbo5p4JWF586LkqnoicBEv6NQX15Pf?=
 =?us-ascii?Q?jSs1bfd1/Ox3n/k8TqxrgsgSaBQ79aIAp+BFC4EU/3fanow3AHa7i8wcoFpe?=
 =?us-ascii?Q?O3+kO6KIXZvriE0SKuVMyEiH4wgyOeGb7lTFKDaog2DWRh+aC+0D7MPI2iR1?=
 =?us-ascii?Q?a6jus/1M51XdLQhLPZ5Xlg3fGkiLSIJeawuA8+7QZiZ19BEjs/ipnhVNXv48?=
 =?us-ascii?Q?B+xVfWtTjljii9mEHo07hCvd1Ps+HZMmsx+eWKpIxnSOarYCIFfXgTM6+8oy?=
 =?us-ascii?Q?YP3Hc9Aws6Ws0jrDzq0RlonUVa0PEoIOBR0m3AB5bePc8l+AGGA81s/DWni0?=
 =?us-ascii?Q?HT3LeaLUMSXkc0DWd69pH+GLf0OvacvG5PhqDqjToNn0KDfsZxbgIfxn0tKd?=
 =?us-ascii?Q?DjCZbJUo7HuqAeVQhq1uWYL/slUsGsExH3nmvLjz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9f1d38-2de0-4d75-9e9c-08dd87c539c8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:58:50.5432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUWfwb/QuhU2TER5uWqKGSHNQgX9/8pAT++cl8E4qN3+3UpoQha5rtzdjNkWThI2+4fG0ppznM09tLp9hg8ZUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319

From: Ben Ben-Ishay <benishay@nvidia.com>

Add the necessary infrastructure for NVMEoTCP offload:
- Create mlx5_cqe128 structure for NVMEoTCP offload.
  The new structure consist from the regular mlx5_cqe64 +
  NVMEoTCP data information for offloaded packets.
- Add nvmetcp field to mlx5_cqe64, this field define the type
  of the data that the additional NVMEoTCP part represents.
- Add nvmeotcp_zero_copy_en + nvmeotcp_crc_en bit
  to the TIR, for identify NVMEoTCP offload flow
  and tag_buffer_id that will be used by the
  connected nvmeotcp_queues.
- Add new capability to HCA_CAP that represents the
  NVMEoTCP offload ability.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c |  6 ++
 include/linux/mlx5/device.h                  | 51 ++++++++++++-
 include/linux/mlx5/mlx5_ifc.h                | 77 +++++++++++++++++++-
 include/linux/mlx5/qp.h                      |  1 +
 4 files changed, 130 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index 57476487e31f..a1b437b91c4c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -294,6 +294,12 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 			return err;
 	}
 
+	if (MLX5_CAP_GEN(dev, nvmeotcp)) {
+		err = mlx5_core_get_caps(dev, MLX5_CAP_DEV_NVMEOTCP);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index b071df6e4e53..4ec55b8881a9 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -265,6 +265,7 @@ enum {
 enum {
 	MLX5_MKEY_MASK_LEN		= 1ull << 0,
 	MLX5_MKEY_MASK_PAGE_SIZE	= 1ull << 1,
+	MLX5_MKEY_MASK_XLT_OCT_SIZE     = 1ull << 2,
 	MLX5_MKEY_MASK_START_ADDR	= 1ull << 6,
 	MLX5_MKEY_MASK_PD		= 1ull << 7,
 	MLX5_MKEY_MASK_EN_RINVAL	= 1ull << 8,
@@ -821,7 +822,11 @@ struct mlx5_err_cqe {
 
 struct mlx5_cqe64 {
 	u8		tls_outer_l3_tunneled;
-	u8		rsvd0;
+	u8		rsvd16bit:4;
+	u8		nvmeotcp_zc:1;
+	u8		nvmeotcp_ddgst:1;
+	u8		nvmeotcp_resync:1;
+	u8		rsvd23bit:1;
 	__be16		wqe_id;
 	union {
 		struct {
@@ -870,6 +875,19 @@ struct mlx5_cqe64 {
 	u8		op_own;
 };
 
+struct mlx5e_cqe128 {
+	__be16 cclen;
+	__be16 hlen;
+	union {
+		__be32 resync_tcp_sn;
+		__be32 ccoff;
+	};
+	__be16 ccid;
+	__be16 rsvd8;
+	u8 rsvd12[52];
+	struct mlx5_cqe64 cqe64;
+};
+
 struct mlx5_mini_cqe8 {
 	union {
 		__be32 rx_hash_result;
@@ -905,6 +923,28 @@ enum {
 
 #define MLX5_MINI_CQE_ARRAY_SIZE 8
 
+static inline bool cqe_is_nvmeotcp_resync(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_resync;
+}
+
+static inline bool cqe_is_nvmeotcp_crcvalid(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_ddgst;
+}
+
+static inline bool cqe_is_nvmeotcp_zc(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_zc;
+}
+
+/* check if cqe is zc or crc or resync */
+static inline bool cqe_is_nvmeotcp(struct mlx5_cqe64 *cqe)
+{
+	return cqe_is_nvmeotcp_zc(cqe) || cqe_is_nvmeotcp_crcvalid(cqe) ||
+	       cqe_is_nvmeotcp_resync(cqe);
+}
+
 static inline u8 mlx5_get_cqe_format(struct mlx5_cqe64 *cqe)
 {
 	return (cqe->op_own >> 2) & 0x3;
@@ -1245,6 +1285,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_VDPA_EMULATION = 0x13,
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
+	MLX5_CAP_DEV_NVMEOTCP = 0x19,
 	MLX5_CAP_CRYPTO = 0x1a,
 	MLX5_CAP_SHAMPO = 0x1d,
 	MLX5_CAP_MACSEC = 0x1f,
@@ -1486,6 +1527,14 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_SHAMPO(mdev, cap) \
 	MLX5_GET(shampo_cap, mdev->caps.hca[MLX5_CAP_SHAMPO]->cur, cap)
 
+#define MLX5_CAP_DEV_NVMEOTCP(mdev, cap)\
+	MLX5_GET(nvmeotcp_cap, \
+		 (mdev)->caps.hca[MLX5_CAP_DEV_NVMEOTCP]->cur, cap)
+
+#define MLX5_CAP64_DEV_NVMEOTCP(mdev, cap)\
+	MLX5_GET64(nvmeotcp_cap, \
+		   (mdev)->caps.hca[MLX5_CAP_DEV_NVMEOTCP]->cur, cap)
+
 enum {
 	MLX5_CMD_STAT_OK			= 0x0,
 	MLX5_CMD_STAT_INT_ERR			= 0x1,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 0e348b2065a8..c4f957e5fe94 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1598,6 +1598,20 @@ enum {
 	MLX5_STEERING_FORMAT_CONNECTX_8   = 3,
 };
 
+struct mlx5_ifc_nvmeotcp_cap_bits {
+	u8    zerocopy[0x1];
+	u8    crc_rx[0x1];
+	u8    crc_tx[0x1];
+	u8    reserved_at_3[0x15];
+	u8    version[0x8];
+
+	u8    reserved_at_20[0x13];
+	u8    log_max_nvmeotcp_tag_buffer_table[0x5];
+	u8    reserved_at_38[0x3];
+	u8    log_max_nvmeotcp_tag_buffer_size[0x5];
+	u8    reserved_at_40[0x7c0];
+};
+
 struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_0[0x6];
 	u8         page_request_disable[0x1];
@@ -1625,7 +1639,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         event_cap[0x1];
 	u8         reserved_at_91[0x2];
 	u8         isolate_vl_tc_new[0x1];
-	u8         reserved_at_94[0x4];
+	u8         reserved_at_94[0x2];
+	u8         nvmeotcp[0x1];
+	u8         reserved_at_97[0x1];
 	u8         prio_tag_required[0x1];
 	u8         reserved_at_99[0x2];
 	u8         log_max_qp[0x5];
@@ -3772,6 +3788,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_nvmeotcp_cap_bits nvmeotcp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -4024,7 +4041,9 @@ struct mlx5_ifc_tirc_bits {
 
 	u8         disp_type[0x4];
 	u8         tls_en[0x1];
-	u8         reserved_at_25[0x1b];
+	u8         nvmeotcp_zero_copy_en[0x1];
+	u8         nvmeotcp_crc_en[0x1];
+	u8         reserved_at_27[0x19];
 
 	u8         reserved_at_40[0x40];
 
@@ -4055,7 +4074,8 @@ struct mlx5_ifc_tirc_bits {
 
 	struct mlx5_ifc_rx_hash_field_select_bits rx_hash_field_selector_inner;
 
-	u8         reserved_at_2c0[0x4c0];
+	u8         nvmeotcp_tag_buffer_table_id[0x20];
+	u8         reserved_at_2e0[0x4a0];
 };
 
 enum {
@@ -12505,6 +12525,8 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE =
+		BIT_ULL(0x21),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
 };
 
@@ -12516,6 +12538,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
@@ -12890,6 +12913,21 @@ struct mlx5_ifc_query_sampler_obj_out_bits {
 	struct mlx5_ifc_sampler_obj_bits sampler_object;
 };
 
+struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits {
+	u8    modify_field_select[0x40];
+
+	u8    reserved_at_40[0x20];
+
+	u8    reserved_at_60[0x1b];
+	u8    log_tag_buffer_table_size[0x5];
+};
+
+struct mlx5_ifc_create_nvmeotcp_tag_buf_table_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits general_obj_in_cmd_hdr;
+	struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits
+		nvmeotcp_tag_buf_table_obj;
+};
+
 enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_128 = 0x0,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_256 = 0x1,
@@ -12903,6 +12941,13 @@ enum {
 
 enum {
 	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS               = 0x1,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP           = 0x2,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP_WITH_TLS  = 0x3,
+};
+
+enum {
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_INITIATOR  = 0x0,
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_TARGET     = 0x1,
 };
 
 struct mlx5_ifc_transport_static_params_bits {
@@ -12925,7 +12970,20 @@ struct mlx5_ifc_transport_static_params_bits {
 	u8         reserved_at_100[0x8];
 	u8         dek_index[0x18];
 
-	u8         reserved_at_120[0xe0];
+	u8         reserved_at_120[0x14];
+
+	u8         cccid_ttag[0x1];
+	u8         ti[0x1];
+	u8         zero_copy_en[0x1];
+	u8         ddgst_offload_en[0x1];
+	u8         hdgst_offload_en[0x1];
+	u8         ddgst_en[0x1];
+	u8         hddgst_en[0x1];
+	u8         pda[0x5];
+
+	u8         nvme_resync_tcp_sn[0x20];
+
+	u8         reserved_at_160[0xa0];
 };
 
 struct mlx5_ifc_tls_progress_params_bits {
@@ -13283,4 +13341,15 @@ struct mlx5_ifc_mrtcq_reg_bits {
 	u8         reserved_at_80[0x180];
 };
 
+struct mlx5_ifc_nvmeotcp_progress_params_bits {
+	u8    next_pdu_tcp_sn[0x20];
+
+	u8    hw_resync_tcp_sn[0x20];
+
+	u8    pdu_tracker_state[0x2];
+	u8    offloading_state[0x2];
+	u8    reserved_at_44[0xc];
+	u8    cccid_ttag[0x10];
+};
+
 #endif /* MLX5_IFC_H */
diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index fc7eeff99a8a..10267ddf1bfe 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -228,6 +228,7 @@ struct mlx5_wqe_ctrl_seg {
 #define MLX5_WQE_CTRL_OPCODE_MASK 0xff
 #define MLX5_WQE_CTRL_WQE_INDEX_MASK 0x00ffff00
 #define MLX5_WQE_CTRL_WQE_INDEX_SHIFT 8
+#define MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT 8
 
 enum {
 	MLX5_ETH_WQE_L3_INNER_CSUM      = 1 << 4,
-- 
2.34.1


