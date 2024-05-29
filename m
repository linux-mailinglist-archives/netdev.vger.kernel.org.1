Return-Path: <netdev+bounces-99105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FB88D3BAF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC8EE280E61
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E83184114;
	Wed, 29 May 2024 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LP6lcJCj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EFA1836DF
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998530; cv=fail; b=WjM0ML7LT77SdYqfBA8GTjMFAsWofVQmaoTVN/4SIGgUZJJKeokITt28cVMp3uYl9IA9m/zFdJlJBRhGnOQ16KybunD6iVLKhmJDo3hSZuD91gfzeGXp5Ew/hgYALkInD+qNZlrzBUkQRN1JesWDnDgimTZ0ic6hA7vGdvbyWag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998530; c=relaxed/simple;
	bh=6o1qLQ45xbEnmMAPTOb4Yy/I8hh6yec/O7clD5FNNNE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SnQA1Y8fFNhbKRqFpz+kKvUr/t/8A2qylVB7CjSoOONMbHDsr0MLDFb4VyMftAeLCnULHh6v1xhhbRX0MQREOK5B+J2WKHf8kssAuDcuaS1Y9DFcZVHBd1W4P95ta/dpAYgKrcdRO67dJaj/EfVDYwy4FiCpZnFMAvub5IgXsuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LP6lcJCj; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgVz1gURyVNqZ8pQFotRCFPnFZHhZPNL73ixzhaMY9ZjRXOoBiCX8Wk3egkmeAkt/uGdHvMXc0SLiQAlHEM+AhpiQOhCDP8ABlXdti2GJLRzvZifA3uCPZzLtaNOWaAw5LJ9l92QX6Ddj460+jpjuJ5afCW1Bf7Zl6Fv9U3RlMkTNUoMUcYSt+D4Iuas7D9OziAt+OXXxtfWES1TIafFKrdykN5idfhavhOfefODZYH9PhBlaRnSwDGuqCRVVJ8aivSREj38Oq5NXiUKqqucMulGuLkSbmopqE4shsgIyUoBj6e77PF0g3rNbjigk2e8hTn/ecS2yMU4MiL//IQrmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLhErX7QtTGvSDg+MJUuVrGYB6HV3YvdQKGffhQk8kc=;
 b=gAGYlFfREvYuXqj1X1lTVqqG5nzpeAsB50WDpRVm5S4hF9QHatvsbdD1pEEMzNpDlzzb4rAgeRDRJ1+2I+sci7QMQfQgqiMdTBI0whjCbhALvlwvolrA+4x01AujfMKd3LPL95D3d2LyeNQH/EtszYOEgPdZO4VXf4Es8sGsmCczGULcKi9bQ4mj13EunpK6jPs//09rQv33gw3tHkkA13CFeJahAnME1WW2y05+f/x3Y1sKSJaOvoppFMJSGaeve8LzINwOQ+iwc3HKmtRPK32u9JBdO5+FoLHt8E62Pncorsvj2ViMmkO3QHx8CP2nyjrk/+b8qY1JhDPF+9Xp5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLhErX7QtTGvSDg+MJUuVrGYB6HV3YvdQKGffhQk8kc=;
 b=LP6lcJCjHONVlZm+IlH8Dw4dZ/6E6gmaPIw7HT1vwJaAMe0tjob0IrQi+FrHKrinbTQYPJP2DINJZA0aq1kR5dc0rRkVMtyMp4yvFHziwFemOMB6hGAjkyg6S2IQ0Nmqfwfkm2aPUiRoABLWsgjFUYCl7L8q1X05uPqo3Ruuchc3IC8MB/wWrcVUNt1OYHqGBQ37DoV6gRpmI709nDKpt8438ATQVdHqrWUBd2rQ7201+V0zisYcZUz4p+A5AMKHzqM0NuBt6vB3ido5mgWSYz++d9IvOU1jet6+mFFEppKJRk2y4rYEkl/3RxK/GfYjwOC0WX4/b3cc8/ufRRO59A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 16:02:04 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%6]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 16:02:04 +0000
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
Subject: [PATCH v25 12/20] net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
Date: Wed, 29 May 2024 16:00:45 +0000
Message-Id: <20240529160053.111531-13-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160053.111531-1-aaptel@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0211.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: c264c2c3-bb79-4e4f-759f-08dc7ff8af11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?27OQSagN1XYiRpIRmzejob7/11rC9mEK26SStpPkSijH8YzbCs0SlTLLoC9A?=
 =?us-ascii?Q?VR9MHnzutHAhVSq2LEYfNY/V+hefZmAPUdQOFzJzTwGm8Nw85jtWogOhw2Ce?=
 =?us-ascii?Q?hD2loapBTusFW/2lB8qds1cfHY8v8mXjt9XtVMG9Of5mkC0bVeWCXcM2h4px?=
 =?us-ascii?Q?+C5lIk94uQbIbiVdrf4tvSYV+aJlAmL1ANnCdp83+qnsuZJo+E/bnjv2y2k4?=
 =?us-ascii?Q?ucx7Xc13qDRp2U1yY6HZNokXF5ix10xGsqwJAGmEQk6GfX9ljmIqKvQdM9iq?=
 =?us-ascii?Q?DkaNi4H3Kxehi51EgORj0zTBXThGJXHer4c6zT60ClibNH8GnzPSXs9F3PBJ?=
 =?us-ascii?Q?d75sS2EkkmfBTYhgszeygZHXGCpOqdqSi9GpgEhGZzhAWH7xRj45i0XKVYwE?=
 =?us-ascii?Q?CM/OiNedi9/LwOj0qSTE2ELZlLOviJQIfgzlkRdb7oQSZ6SRVQ+q9HU0fc9D?=
 =?us-ascii?Q?+D3oPSbIpVoP+0X11hv1eXLFaOtDfaJchFlhlUoNh3EpTeQG4CxuSF1gLRin?=
 =?us-ascii?Q?PPCczKwZWmvBaBfyIMi0TjlDdoCL23A0rBEuLrXpAGvXZv+xl7UyTm/YLLnZ?=
 =?us-ascii?Q?M/Lm4tqyWRS4I/fmy5Xg4GyTbCkZJU3LBkvluSuFVCQ7z3MeCSre16JS2+fw?=
 =?us-ascii?Q?KTvL96EkxD5hUbfQ7C0GizQIkHHG8PJPqbkEYS6FK4J1f6e+UIrgubrHSKrm?=
 =?us-ascii?Q?9Uqd1o2sjMsKugZMoFUtzqSgafsQA+cwnW5BBSt2OpsdgP4y1Bd8kAqOmyIw?=
 =?us-ascii?Q?IoPpwDe23brb4JWx9EYTeOooUDn91FaIrimpHc0gTgIQTAYjV8AuvD9j3KgO?=
 =?us-ascii?Q?DIF2SC7RZLPwBLG/ATFBlXe2F8kwI0XfZwjzenJglXB5x+2LGT7D1UCbW57z?=
 =?us-ascii?Q?hzWuOvIsIL94zHIqtuCKeYOLe57G8cNrFmXkF7lfO3zuGRhNPugLrg/A++fc?=
 =?us-ascii?Q?HTu+AKQWw7BrbhszmZ7ONpx17ReTU4tSzIFltUpCELvFDBzteYOnJ+NzPhql?=
 =?us-ascii?Q?25YUtpgnEFFN9ScwpeV6zw4jGv6y/MNTKZgMNH48ztEDQkb54jybcEzN7vKf?=
 =?us-ascii?Q?zhOeMgmUEEjyRGu5VQubQahQ180fHakWpE1VXfsfLTB3PAGvt8hiXJzVivjL?=
 =?us-ascii?Q?d1RLWKeC5WyGkaFMWWobRSMEkkVIdRwBfFRNL4YYrE2XJfmeGROaJgKLwIoR?=
 =?us-ascii?Q?MkA2cOddib/W2etI+zN1JTWipRyk5Ade7ru5VKonidg6XDhXueic9b5IzMQz?=
 =?us-ascii?Q?HByyLxuDnGvTanTsDVn+45URmdoZRVr6b+vb6Qx53w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bHbdbF+CC1Hk0UnhfpI4x8yHRj9zFsfH84uXkKYb8OuhDuA13OMYTUjvdKst?=
 =?us-ascii?Q?ZMpCrWVMlJFVVtoZd/LPxMJCHMZO0OUXWtgNw6YF98QZiKtPvroQZroopedP?=
 =?us-ascii?Q?njdlIj5ynCUBt+D0qQwRueGQUsM6OUqvcxvM148iqfj0iZbiKT3MRDvReM9H?=
 =?us-ascii?Q?GEgeOmk9cdF+6Mm5m+6VWTHyjM1HZZ/kpt36SgWrsk2l9I9EJ7Oc84B3CPIt?=
 =?us-ascii?Q?cpRsQqsKCrfZlTPbaLhrQ5DOEPkUZ86Tq5QpaBX1hlaRtllJDgTgN8vyW8xF?=
 =?us-ascii?Q?U46WQsmyBEtapydYN/yozGWrUigStCoiWDj2d7noYRBDGsTgLjOEnha+uO4K?=
 =?us-ascii?Q?8iZ9QcBocFNMkuHgrxnIrEUR8sc4yp98UsPcw+CfV3Bow4Q9yrUxMoNKCISE?=
 =?us-ascii?Q?dTvlL44fLZIuW/KA/a7DocFnEQDPK7zTIyVWU3ORR8xJtWqa+E3TcBriaoE4?=
 =?us-ascii?Q?Foys7dTptq70b5U8+ENZP2YWq9eiTXrajuBdkMb4Lf+/Mvixr6dT4j0Ii2N2?=
 =?us-ascii?Q?QK6MoLCjB2G9QEwGKQ/8MU8NmjXHqwSRiMK/ymRkEYj/Ne2QU82KRlWUZN/c?=
 =?us-ascii?Q?Mtmm/L0To5Ewj+hAgRqWZuI214H6+HlNCJY8IOI+H1Bhh3HpmHJhkPb2EORK?=
 =?us-ascii?Q?dIaxgHojVMeQQew0TbV6MDno+rusrtFL/S1FdX12HlXYW4pte7ebT90vLnx7?=
 =?us-ascii?Q?x/waLrkKp+5u7DbsGTBcKyL7QF+pLa0GK7NvlDPRyLrXrygsTjmyG+EjxHOT?=
 =?us-ascii?Q?4NF9QnfNYF7oOuRK+DeqT7R/bQWLDuc+gi5MKvH0ctMQqdytpye357xk6u31?=
 =?us-ascii?Q?SGN5m0D1FpU4h7UiKbhu1Vdx8PQyWrWxRnc/md1IMUveh4CdvC7r+ughrer0?=
 =?us-ascii?Q?VUsXsezXeAULYl6odWzwgz9PGBghNlO4qOoa0PjPXft+TnFth9HBEVMQMeE2?=
 =?us-ascii?Q?m8JdIk/10LpvwN9H+XKcYMGLqLCmfgAXnVI7vJw/up7bLEPhcNuWY2+UgUeo?=
 =?us-ascii?Q?Afl8LJ0Gc4U4msODntZR9cAz3NpMZWR8HaYFoWfQWqUkDXGFM+WWmlDBHm/P?=
 =?us-ascii?Q?sdP8lKXSHtr7eia0JfW9LhgLZE1OJN1JSe9YdbV69lr//+VxSBb7hmYXUPyK?=
 =?us-ascii?Q?ZufSlfwFVXaD2A6Q983eiV3bG93AF1fAgNprpEQQoZxs4LrY/StYI1rtbla1?=
 =?us-ascii?Q?qjFsj3nFwV6b7Cz3opEVLIQPVAf6jU1kt5hRiAiKJJoijuI49h+y/DQsTAWO?=
 =?us-ascii?Q?bkXp7d10XjfU+Ifb5xIqCvV3whmnvAMgfeWhamAeT2f5OtcHWuMOz3ELIuTA?=
 =?us-ascii?Q?IsHTvCypltloON8hkkxXObPllpzeEdI9RcK62D6+/uWaDrbcvo+Y4V5whvbi?=
 =?us-ascii?Q?cADHkwiGRw1D6b2Tlgao2sr8mZFAC33emLeJs1iSkL98GBFnaP0prfqEPSQt?=
 =?us-ascii?Q?Ro5SomnaTaHdJo4SeZhw20JaDs1CnvYW86cGXajeF39ZM5n2lSFehUm+Orac?=
 =?us-ascii?Q?Can8m8G3xeWVBbWjE8kk3kKLlqZ/q/ZP2N4GBkG7Ge9xLySldu5V4eLp62Zn?=
 =?us-ascii?Q?YKWRKnFSKX2Wc0pKlx4CAjTLWhioymBYTmGtIbem?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c264c2c3-bb79-4e4f-759f-08dc7ff8af11
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 16:02:04.6625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74RKvllFx9wjRGxCoS5Avh9/BzmxCJCgkvPeoyjdSA9a95vfeYivBgmApZcWLQR3VXlmFj7+lkXJR50dhXU0sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799

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
 include/linux/mlx5/mlx5_ifc.h                | 75 ++++++++++++++++++--
 include/linux/mlx5/qp.h                      |  1 +
 4 files changed, 128 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index 2d95a9b7b44e..fb80b717e9ab 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -280,6 +280,12 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
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
index 2c86dc56378a..d49598beb94d 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -264,6 +264,7 @@ enum {
 enum {
 	MLX5_MKEY_MASK_LEN		= 1ull << 0,
 	MLX5_MKEY_MASK_PAGE_SIZE	= 1ull << 1,
+	MLX5_MKEY_MASK_XLT_OCT_SIZE     = 1ull << 2,
 	MLX5_MKEY_MASK_START_ADDR	= 1ull << 6,
 	MLX5_MKEY_MASK_PD		= 1ull << 7,
 	MLX5_MKEY_MASK_EN_RINVAL	= 1ull << 8,
@@ -798,7 +799,11 @@ struct mlx5_err_cqe {
 
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
@@ -847,6 +852,19 @@ struct mlx5_cqe64 {
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
@@ -882,6 +900,28 @@ enum {
 
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
@@ -1222,6 +1262,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_VDPA_EMULATION = 0x13,
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
+	MLX5_CAP_DEV_NVMEOTCP = 0x19,
 	MLX5_CAP_CRYPTO = 0x1a,
 	MLX5_CAP_MACSEC = 0x1f,
 	MLX5_CAP_GENERAL_2 = 0x20,
@@ -1435,6 +1476,14 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_MACSEC(mdev, cap)\
 	MLX5_GET(macsec_cap, (mdev)->caps.hca[MLX5_CAP_MACSEC]->cur, cap)
 
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
index 00283c18aa0f..5542e1fb537b 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1484,6 +1484,20 @@ enum {
 	MLX5_STEERING_FORMAT_CONNECTX_7   = 2,
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
@@ -1510,7 +1524,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
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
@@ -3519,6 +3535,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_nvmeotcp_cap_bits nvmeotcp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -3771,7 +3788,9 @@ struct mlx5_ifc_tirc_bits {
 
 	u8         disp_type[0x4];
 	u8         tls_en[0x1];
-	u8         reserved_at_25[0x1b];
+	u8         nvmeotcp_zero_copy_en[0x1];
+	u8         nvmeotcp_crc_en[0x1];
+	u8         reserved_at_27[0x19];
 
 	u8         reserved_at_40[0x40];
 
@@ -3802,7 +3821,8 @@ struct mlx5_ifc_tirc_bits {
 
 	struct mlx5_ifc_rx_hash_field_select_bits rx_hash_field_selector_inner;
 
-	u8         reserved_at_2c0[0x4c0];
+	u8         nvmeotcp_tag_buffer_table_id[0x20];
+	u8         reserved_at_2e0[0x4a0];
 };
 
 enum {
@@ -12063,6 +12083,7 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = BIT_ULL(0x21),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
 };
 
@@ -12070,6 +12091,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
@@ -12443,6 +12465,20 @@ struct mlx5_ifc_query_sampler_obj_out_bits {
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
+	struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits nvmeotcp_tag_buf_table_obj;
+};
+
 enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_128 = 0x0,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_256 = 0x1,
@@ -12456,6 +12492,13 @@ enum {
 
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
@@ -12478,7 +12521,20 @@ struct mlx5_ifc_transport_static_params_bits {
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
@@ -12790,4 +12846,15 @@ struct mlx5_ifc_msees_reg_bits {
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
index f0e55bf3ec8b..c2805cf8d7fd 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -227,6 +227,7 @@ struct mlx5_wqe_ctrl_seg {
 #define MLX5_WQE_CTRL_OPCODE_MASK 0xff
 #define MLX5_WQE_CTRL_WQE_INDEX_MASK 0x00ffff00
 #define MLX5_WQE_CTRL_WQE_INDEX_SHIFT 8
+#define MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT 8
 
 enum {
 	MLX5_ETH_WQE_L3_INNER_CSUM      = 1 << 4,
-- 
2.34.1


