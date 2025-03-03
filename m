Return-Path: <netdev+bounces-171156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BD2A4BB50
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D213B44E6
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCCF1F0E3E;
	Mon,  3 Mar 2025 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fwlX7fa6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA8A1F1527
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995660; cv=fail; b=uYQuGJ/BvLxd1oQ+YWiN78dDJ9AM2LX5mOyJwIwJYkWYUQ5lLshbfu4oFcYPyAUUVGxFSHviGjdg3oTe0GvxlBhgg7gktbCKddHxDLuphDB42CYNrt9naDRUeszvr6SXzYqyJhdeCmZJ+IFStOxLZguSJ6xzVUsaTWUmIMlhTew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995660; c=relaxed/simple;
	bh=Lp4ln1g+slJwwA4KdyhCyMvuCoJ3/LfNTaE8oX2EUHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cuUWOBRGoAP7rIY4Qnhx6eYSjHZhuCK5e0QHfm767L6v/kqHw/Bpkr2u1oqOeJGMXk9Pz+8+xTbpTQ/jAGm5az5q6jJz0o3dIjy+IQgUAmgs64g8ORBRMfjqKsUVjFI7QvmDpeSQAjLSLQpJ0auKlSHI2nx5V266sWDrpQGmAjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fwlX7fa6; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfARmKo89Wumkhr1EZHH2k1/SQdZtHdpLq3u/q/zvqG8R2jWAIW1MM/QbGDpa/x2MSqoeFxfuYfhFA5jMJcVBSi97PiqhIHKWtbCiXJAsarA75H3WiQALmztN4MGY0/1GChDdk1DKNPZ0nIHjbbfdEuOBf4hQchFN9RlOManLBfxBiwP9AegjfuYy16r3qT2Quq1DKC2q8oSMGf9msU+IQ7XrTxFMo4gEDLB9F143AMoBy0j5Df4s4KZv3RxysV6NwrXjClI5wsrVdCETL92Sx5rerh92PjfBymhsqukho3BJ9Qx5op2QflGh/kaWzhJ3iog70CfELvTaK2mfF+0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUL0ug/GDLqiRV2lrlEBAShRpQF10I8ViTzlVJS9I6o=;
 b=C7HTyzyuX5AjgIvnH5fBh5jJio5y3sP/FP+wsX2jtjNCUaqKuAIZZnVOYGFwvbT6pwBdHaCd3iKolF+FI1m4VJR0QOoPKNwYNmtUl3bem6pz9FbrxyWOeZlm2U14GZ9XpdExTpy+Gz2XLnCjnuOqfv7sUGFwNgR91bP7lcRQIeyqdNNflGQKjMV7wY8mv0Y6YIuctQelHGWI7XzxvBAY3W3ssmIpciJYuO4QD88E/rU+W9e5P5+bF9w9JPnfJFY/AfcKisVt3ZMBLTCzBs8R77oAS4jFicwWH503IkpeNoCfR+RIrN3AhsyiQ2PSHvPZfm645IVtoxH3WGS2UvHedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUL0ug/GDLqiRV2lrlEBAShRpQF10I8ViTzlVJS9I6o=;
 b=fwlX7fa6PL4lebEfcofTLNWDGsmh1GV3UcdpOnNiDI8wJKzmHNtj2geg8zTaoOxAaHPAi+QiCrdQaR7/4QQtv6hyY0QK4cuDbC9UmEqXGRyrdbXHLk90EOJ+Cvyy61Kvy3z5Nj6QbYSd5YJ4uTwX2NFMhyBiW9XoDGcZe1SD594vmMnx/Yi7Z1u63OPKU9VpTwbP7hGm0RXTIdgPWhnZLENciN8HQuUf5FhvT3RTmO6ngpSA3YbK6ue1Y6JqxEaXvN4Iro4DvHOPZQz8vIdiZ3NrDr0837RpZB+ez5gvVjeIh6Xx/6p+e5zhniGd9g+GYXjQ/n40N60xJzfZy4e36g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Mon, 3 Mar
 2025 09:54:16 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:54:16 +0000
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
	tariqt@nvidia.com
Subject: [PATCH v27 12/20] net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
Date: Mon,  3 Mar 2025 09:52:56 +0000
Message-Id: <20250303095304.1534-13-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303095304.1534-1-aaptel@nvidia.com>
References: <20250303095304.1534-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0135.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::10) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: e9db2589-951f-4127-0bf6-08dd5a395c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZTFD7u25maUNI/EL9IG1Chc0cCHeeUfvGgUNMuMVHM+AjjhtOz22Qdsg8h27?=
 =?us-ascii?Q?ZqNaU3aO9EHpg/EHkfYhNVId9tVGI9xydutZWWHhtVXWJxJcv6eyY97+TNza?=
 =?us-ascii?Q?LJ1OwXTbJyr4Cur3JqmpA1uODtRADRbSaOFiAX4Wu5uDAsHX64d73khBpYkQ?=
 =?us-ascii?Q?PPhbehK1EQofKAz0JfELgLTiAWthpm5TpH8YIOD/MJZTbarZ0P5os5FuorHi?=
 =?us-ascii?Q?jH7yhpUsrvUp8G9PO4LcpBwrrDzKGBghXctjaDQP+d+uJBOO2yWZNv0ApDMl?=
 =?us-ascii?Q?i1eXarHPRvnlEd/mqeM1rPkjM6K5efbmxTr1UH6zxzg1uQIfLFBKDbOB7yjZ?=
 =?us-ascii?Q?rTxgb8ozYjOqX54aWv9rOUh2BZmpCyeaKgWMFg/BFi0htMUWybbueGNvFtO+?=
 =?us-ascii?Q?r7K8MGprlLazqxg6gtiu4ajHhzFw8PtX/sAuhLKRjRE0HzLDDRXFnyDvS8vR?=
 =?us-ascii?Q?SYtB7z9C3krtN498AjS39ORRo8ueRdEuBZU1te4qp5BSyCeU5GxJSZfPMW/B?=
 =?us-ascii?Q?q0npzCuCh9OXnjn9nO+hfzAadDlSfxAZtrHS+3WBr92Rx62IRGOy/GHBA/z+?=
 =?us-ascii?Q?8RiD8U1GpsPPWM36V2qWN1zWYyAmxz8RYsOAacDgqiKqAEMBTVGJo0JX6L5M?=
 =?us-ascii?Q?hhivRIwWDoBlVyhbDiH6y/+qvUGh8a908LfDJatBWAMog4833KLe3UiLippu?=
 =?us-ascii?Q?uEQHy+FP8Q0EFzzaSisx2wbLW7GJyaPABgtQOFxMNk0MLyvwoNbauJPyPu0a?=
 =?us-ascii?Q?ax7jJ00FNiAXaWu8KfuarZEobYBZyTse2tfwNpdhvg5/o+fiGoI4dPtnwSxP?=
 =?us-ascii?Q?4aUby8S3fmsYy4NAOBeBZoZYByCr/xs5Kkq6lsng4wWf0mOcxif42k+XkuA/?=
 =?us-ascii?Q?RZGcPqznzQW2Sq9NfTpJ+REQe1JqhPVvdtUzTLQcykhtR7Ow9SMFGt6YtGxm?=
 =?us-ascii?Q?X1/fvs3voEQrTk9SZm97EHoieIEloxLsqRPe85qdSqEaTfNNgJtp6Cm2l9OI?=
 =?us-ascii?Q?u7Nph9KmplA9yr7gHyVo47MJbZPzJO/n+ugi/OCNp8Nw+shiFyqnu0kaYzhX?=
 =?us-ascii?Q?51FqN7U2KUpen5Vw+6TSG82B/I63Ak5OIQbmvKQ8L73kgDM/MW8J02Y6r+6M?=
 =?us-ascii?Q?ND3c5vRT6BrRRrCS1X+ZYHAJDCxVnyRQVNvz2iUHDGIrRprZLmogk5oS7l7D?=
 =?us-ascii?Q?LFAwE9xHD5Q63XXOc+18DihNO72bGS89xumIt87/IY486+mLJl2sMqB4f4tX?=
 =?us-ascii?Q?d2KBOcDAGhAgb1UzdxRJoEBIjeqT0cn54qWUN9J3sDsuZYRyIy2EqfamYaSN?=
 =?us-ascii?Q?E/lkoI6B3Npk9pKTomgkgVyJapNz9L5OwmFkpkoX3sqaVYi+3D44CVsCtUNs?=
 =?us-ascii?Q?HQGdElKZmDqQxtiHKGlZaNAv3XGR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tt9q1eqcKMWvkM3uGwj7uAL7h53a6Lqp987NCAsMmN93w4IpmmUSfddW8WMh?=
 =?us-ascii?Q?zAO7Tq+c4B3HnP23vQw7c6wvlXMv7IXo00a5RcDNEhEhtXq71J88HA/sU4gK?=
 =?us-ascii?Q?mCWcCRdkfqsb3ayMQmRS36xh2CXPsbEiLaIRRMlEtig3gSnRSTSxkYwh5E7X?=
 =?us-ascii?Q?6Ov2q9P4emDpIgXAfDpULG3NUs4MUg5sKJm8d3LG/1Pmqu5OInlG90snPzzT?=
 =?us-ascii?Q?UX6qg2b6Tdd6OEni3Xto39u7zKDHcSkgRi8odu8TDFfo49oNhLBjEAOfScRV?=
 =?us-ascii?Q?HTuJYvJGHIdBqyHUDEItKRtgesCUDFUFs+IJNawgXl5dOJbknreXEMfwb2kR?=
 =?us-ascii?Q?Lwp8XLBZ5JFb6Vvo7dIk8LPF7ijOa6MSgCAQiACbhu5s+VlIYFTomU7vRUMS?=
 =?us-ascii?Q?Cnsxes4BVtAtbxUuHuhAmEM3jJMzv1Ys3+lb2pP5YF9QVkXD/8xMyTMU6aSP?=
 =?us-ascii?Q?VfWoKPhgqH+V7ZHDVnxQh06vGdDfkRCmtJSvYSg4tb2pJvBo4I4qLKeXI2zP?=
 =?us-ascii?Q?Qr/Rtedd30Ok2pi2Mcc7Hd7e4TAQtJe42yS6ZAX17jnwoOhabngAz4xBRHw/?=
 =?us-ascii?Q?6OOtI6JD9dVahPYPplrK6cjjsFmNjlaOsNREEyVSE7b5UKVBd8vjGkYneNn/?=
 =?us-ascii?Q?N60ZuOcPxzUpGmoxEcvjiM9EnyrYHd+c3a0bcJ34aQfJav4syl1AeFrpgvQf?=
 =?us-ascii?Q?0zNsrkOhStZmFMFKheQDGAHq/w/G0VL8Wlk/72IY8RSJcQrs8j37N9DSrfr0?=
 =?us-ascii?Q?42c6aHhFSrz/NcD4ZWf6mlA+36bfkdmAIloFSRhBcql3T4qRDeCXIwV3aXX+?=
 =?us-ascii?Q?YcczQJDaa2oE8rCoJAQWxWZLKNZv0GjP29OW3t8xd5ek5yUH2zJDUHTJfh81?=
 =?us-ascii?Q?UE405NJgMX36YJE6ZV2L3sFr/FHJDIK4lOgYJfs9U0w+NXsfgQdPcxQ1p+wY?=
 =?us-ascii?Q?4sLZB996HeziuJPXY+Rqzm/GS3XG+jDk/w1sdEAUv+D8fD59zqHyY9zA5fYG?=
 =?us-ascii?Q?RLYpz2ivtoDdr79jXQ84mJDfD9A0bpOeDnkL039zEkc01k/6iik6UbHPlfdN?=
 =?us-ascii?Q?VoI2NBUmr9JMphpjmBKZko36OnbOGgSZATwYIfPfIc3rmDU5a5c6P2ft8j+r?=
 =?us-ascii?Q?RgeoCg+LikrJoKMicGQ9X+LqMclJDKueIoxvckVf2F1gITNQxOQSCyilH8xF?=
 =?us-ascii?Q?gF4wiwTbZ7mgqxF4UVcEHSn0hxdorHMTTvtNgn4YB50ldNK6dXOOy1uQm5ZS?=
 =?us-ascii?Q?/XZZRc5O3U/CNXDB34W5C/q75tlrsTiLHF3x6gcsGsZk9X8nNdXfYyH0dK26?=
 =?us-ascii?Q?vJUqiO+zekCpwj2/vV3eL3fr9RmEhtKpCHXUKzOVLJnNRJx71edEWbmdMInU?=
 =?us-ascii?Q?yE5BQlzZjmZEVjrqXdOSrv1BJQYT57rBKJQR8vtQmSowbhWNLJ6tEYWzBwS2?=
 =?us-ascii?Q?fY6189xVL0/VN1FbTTMu1XfzbZnunbZraRgRUo4yNk+H0uNyJcs/cZrhkhve?=
 =?us-ascii?Q?Q2FgvA/CGqavWl0NhjekOtqtetwzvXooVJLA811T/fvHHK6Fa6hQy196Hhuh?=
 =?us-ascii?Q?ZU+cZFAIX8jYnZG1TSBrNdf6/l1JlGxNaNuDF3OT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9db2589-951f-4127-0bf6-08dd5a395c21
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:54:16.3941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cK/1Bd2mZ6kDlcufgMDxrj7iII0LS6SjL+MjHX2KCO5hlBYIVSL6PE6nQkacASAomTI+TdM2c3+4srTYxxes6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

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
index b253d1673398..045eafd0167f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -287,6 +287,12 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
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
index ee329b80e426..ec0d2499fc98 100644
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
@@ -1475,6 +1516,14 @@ enum mlx5_qcam_feature_groups {
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
index c0ac8eec338f..23271a548599 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1596,6 +1596,20 @@ enum {
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
@@ -1623,7 +1637,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
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
@@ -3761,6 +3777,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_nvmeotcp_cap_bits nvmeotcp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -4013,7 +4030,9 @@ struct mlx5_ifc_tirc_bits {
 
 	u8         disp_type[0x4];
 	u8         tls_en[0x1];
-	u8         reserved_at_25[0x1b];
+	u8         nvmeotcp_zero_copy_en[0x1];
+	u8         nvmeotcp_crc_en[0x1];
+	u8         reserved_at_27[0x19];
 
 	u8         reserved_at_40[0x40];
 
@@ -4044,7 +4063,8 @@ struct mlx5_ifc_tirc_bits {
 
 	struct mlx5_ifc_rx_hash_field_select_bits rx_hash_field_selector_inner;
 
-	u8         reserved_at_2c0[0x4c0];
+	u8         nvmeotcp_tag_buffer_table_id[0x20];
+	u8         reserved_at_2e0[0x4a0];
 };
 
 enum {
@@ -12491,6 +12511,7 @@ enum {
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = BIT_ULL(0xc),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_IPSEC = BIT_ULL(0x13),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER = BIT_ULL(0x20),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = BIT_ULL(0x21),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = BIT_ULL(0x24),
 };
 
@@ -12498,6 +12519,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
@@ -12871,6 +12893,20 @@ struct mlx5_ifc_query_sampler_obj_out_bits {
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
@@ -12884,6 +12920,13 @@ enum {
 
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
@@ -12906,7 +12949,20 @@ struct mlx5_ifc_transport_static_params_bits {
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
@@ -13226,4 +13282,15 @@ struct mlx5_ifc_mrtcq_reg_bits {
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


