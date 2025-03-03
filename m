Return-Path: <netdev+bounces-171162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DB1A4BB5F
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F311894C41
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F051F131A;
	Mon,  3 Mar 2025 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FVF+ogR/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DB11F0E5A
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995691; cv=fail; b=HRQ1vQG+8QSpJxDPa3r+6X5IZV+X0/bWIOOX1Dcrnfxk2M6ndFa17Asz7ar4LMAxSHRD8Wawe8//vhvgfmO9HW5RFBRxcWRsJ6Hwh44jDdUTGdD+UvF48nHon2z6sLhMo6yIEIzB5y5+rXI4uPe+tIEEfpmkHJUKBer52bo5h/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995691; c=relaxed/simple;
	bh=y+vVLrwni13gbeu2srcwYi4j7p5uXB8f0sv3E8OXyb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H3YKYPBjfoIcX1jcLLje8p8VzBzDvggQR240ScMW7ziTKyDqmRxg3rJc0v9q8a+oC/i+11/D6aQulp8T7RPPCyISeoJhA2VLpVqj3hmlFrOb4FmuAhW63BTUoFGyHJHmu9X+C3MKzwoEdAf/cV18Q/aYmzE3LVTSSo7fwOsP7Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FVF+ogR/; arc=fail smtp.client-ip=40.107.95.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmVPn9Wtaw6qdxaHJ1Cozskr1+FqJuxR4z66VnMCqXrt8YP7N0yzxmFpmdCucHMx8MCZM6sfhfUdv/JU89r8XdxsQkAJiBVMSoM1XMeeKiOUiLZA8p02TTStZZTLLH3WVl3KdbYY7/OiKS7DjHeBU/234hnClFncnv34hYWLBCxpBln0xtAwOMSsMvrdhb/AMTkz2iaVsDkK95Fil4iGbFvSkATguzgoyvD37Tbvyl/twhu57397fuCMWVKIvETUBEeTOw6VXiClBOkwd+HI5tZnORyHrGFwfS3m5fIaUz827fdkmdGh3aUmcsy3x2kiLp4fLAXH7rZ2Ox5Yyoil2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVkUAoPpVvB81hhVHOr7Iq215l4LBqK/8r0eErLLVAg=;
 b=JMGbBt4rgBEEOkMtLHt+jV582VVHk/4tu18Eop1+k14zY3J+/KAyz+FTwUuALIi2No1z0GBq/Mhzix8ZFNlQFtmGGM7JfJP5Ur+PTyZA6IhTQz5nvlB34Xw7sq3NkDD7Gf5e3dg0mUy3ZFB16xC49WI5BusZkDKbJzbHvLf8MsWhWa4/hoCPVjGRakmrDYch94NnXBcsJK+aOOTBRQjCRG6IaBSUMY+iByxr0TZ2SECVyYrpqS36E+UdhDzBkwdH2zFV1fo9W79Us4SvbzHmiY/UbfocT4DTWPMwicDGVvyTlO6WdKPLjeQ/cQnTaB6kr1UA+lvcrEUj4HOYUy3PLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVkUAoPpVvB81hhVHOr7Iq215l4LBqK/8r0eErLLVAg=;
 b=FVF+ogR/7mPc8LaDaWHQof9WWG+xHQPaoO0sHABargyFA7RqPT9tE6+AYAjgm7aYJhYgkeKhhyKIUZdu3LnTPxE9MmPwzwen+kGS6uoobgYJrbJb6kHkZtuyqec9KQ/VUvMor7/p0kb/2mYuRzZnSTwC+Q37W+9Nv+VZJE7nMu+SkZus0zYVaaVoUxoAkP4MomYSaGDM8BFmhP4azvbWmsDOcTzz8N1AfcQEscYCUxhpEYRs4Oh3HmhCSRFZlEgEXrF6YSCn+Mk7D8lJcA8RmCxOhimnDIfUuOhUqJyH6mA3qxf9h+oY5zVWQabk1OqUqBW1QH5FjL2makbUDET5tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 09:54:46 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:54:45 +0000
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
Subject: [PATCH v27 18/20] net/mlx5e: NVMEoTCP, async ddp invalidation
Date: Mon,  3 Mar 2025 09:53:02 +0000
Message-Id: <20250303095304.1534-19-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303095304.1534-1-aaptel@nvidia.com>
References: <20250303095304.1534-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0535.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::20) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c258d2-aff9-4cd6-9536-08dd5a396dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OhIK0DN3CEbtAw4ZAV+bWKHR1oslBkOr1iKb/+kGcc01cb/U78Nnz+hS67B4?=
 =?us-ascii?Q?HeT5HuTyHLp2KF+APuXG0WYquTmsjXAbpZloM4VqnD0uU7ZInHXUGHagn6Dq?=
 =?us-ascii?Q?qZOADwEGJR+3beNpkzE/DT91mwncfl+NUfZP3HT5weUwV3ttCuDzQHu0zAK5?=
 =?us-ascii?Q?A4SHKcBg0iZoytm2KbQuVXzB8Q1lpELDSrbhLw+FqsQrza4zGgrfh5GqLNE0?=
 =?us-ascii?Q?7UE7sw3YdoIaUJmBWkNk2Bbh7G5a5ovQpnpjbJRnwb65Qkn02btN0N9Cre+k?=
 =?us-ascii?Q?PnbE5piun9MIuFQRLAeDJg2o7yL3Yy7zero2hXxH5YbSLH6Vig2L783O8Trl?=
 =?us-ascii?Q?7Aa2i6fXio5mv5rp0rw/DlMhT3PnLT1VZGN/MnW5Xzn02YesP4t82tNy0vwm?=
 =?us-ascii?Q?Zv6C4TJjDRWKcf2oMmCWKSfy0A6w1CMBtzwvX8g2DdZM5lLeXH6MvzgLjgqL?=
 =?us-ascii?Q?+Vr0U46rKAm0NTFrq5k7k3xgrP15p27WfM0gor4TuQDsG0lpSy9IvxCFTLig?=
 =?us-ascii?Q?MLY6JAhRB3vOJC1SiaFTmofVD1Dce5Qi4+diFaH8q5eLEeHbN8+lo+zH5n/n?=
 =?us-ascii?Q?7yLKMipOX1MKgXgpoQleyXW1H5mvTlpSz/uL9sgyUcqTSWrsFWHY4XgyyF1Q?=
 =?us-ascii?Q?pcXqDecwJzmivn4W/ca4ZFFigtdW+SHXfz4mQ8+aT2UJkLQbc+UA9q3dH7sy?=
 =?us-ascii?Q?0N3CZqMELxp2o0b4ZhO0W/svMWOPHMVX1uXYudKdn3BIZfs8LX5/8DIkH43O?=
 =?us-ascii?Q?68lwTjuGG886v2lAjTd2RrRQ0PZq/IRk0yKGd22hULtIz7poNl/WFIYKfUo5?=
 =?us-ascii?Q?N39ti16/ukVUn1yU5jTDiiHt0JLPixFW0zPKaJeDPu+f1w7LpSR20G54KScP?=
 =?us-ascii?Q?r2ZePvZ5P7dHgDXF2wJyojBX23DPFDS2VrnlKIo+QGdYiu4pk1vvJm9SyC7e?=
 =?us-ascii?Q?nHu2UbqCrkPWfFye1N+aFRqzCZk1fsosHeQyxB4Rxw/WY0Ed0sZAzWhmLdhs?=
 =?us-ascii?Q?bz/wczjtBWKgkw1TfXGb8DvISpf3Gnj5o+B2PeyOBx9ZkRDbSEq/j7rLKQ6G?=
 =?us-ascii?Q?mRpPO6r5IGfxjDj4dTdK1pNNJiNb0apA3EGjXveCPc0ZLQYq1fgiJqvWXJvH?=
 =?us-ascii?Q?HlWc4zH6uku4jds7Az9w0FtOskgRFyjtNcg6pc6frO+C2At+ttRhmdxxJUjM?=
 =?us-ascii?Q?BbleFVx7hG9dzGf5Hc8i0bJ9ZmWkeqVWSls4fiCpqIcBuLk05Xz8x+lzTxxR?=
 =?us-ascii?Q?Lq0C5PFWZRZe43SO+cbo3Ik9lscJH2mvcmvELmAwWF7ZhTTFOR86oAkN4pgy?=
 =?us-ascii?Q?hGsHGYLJGf3HLgXc9PZap9j/IBDPYYA5+3NozyVIa8FOBrBXZnl34YvfHu7I?=
 =?us-ascii?Q?2XIiaUBXVOrnUHJPq+QXGTa6sFXZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0xZz24RYpMw+lgntF78d+kv8CbaGWpWYtAlBbNQM90fK87G2Vc4qR3UID6Zr?=
 =?us-ascii?Q?VJfbeJegGFU1922is+ghauErIfGvtAhoqGIkOKiFzis0MZmU/eVQOxrDnLSb?=
 =?us-ascii?Q?UFVPoamJcN2MXZ2NYfrIXZx/8vPzSTWbSttXSzPNM8XC03wsx+I/uQbI+aMh?=
 =?us-ascii?Q?gLeZ0I5KyX6TPjXJUUagkRD01i98+YMCJu2MNtfX2jWZDMDB/lpl2hwwV7s8?=
 =?us-ascii?Q?EV+Ul80LiNSGwBvNqSUsYgOliTpaFdvueIcMm0WdRt9Ns9OZ8WB3+1oxOoaX?=
 =?us-ascii?Q?IWp/uDOPyRs08DnAPFhvAq1L8+DX9QqgMl0bA/avUTd0Ip+p5JYCkIIHZC/A?=
 =?us-ascii?Q?BSxhW6sP+bIRB+makz4MaxOOoUooqD1fqVnxBt1SAUPKCDkndrU2ywsLN3Xx?=
 =?us-ascii?Q?fKyQnXhzsYDA5yyWcseuvM8TX0HZjcAYBFwO6+mW7f4lAtfJ9STK8ymwd7EP?=
 =?us-ascii?Q?dlJwcTwlgra/O67PIWwKsqyzju75Q+7y9ymH+SSdOtSuckEJCCSKXOheXfvx?=
 =?us-ascii?Q?lN07opV82Cy6LsjFApp3/lLx3NkXTufyO4BHITgavYg3ecxnnv0ypcjQSFPQ?=
 =?us-ascii?Q?Pm1HwnBF9VE1IGJs/234cXKEOhQlJYkRJkpiqwTJJ7z+/7PjfiMKy55YimXA?=
 =?us-ascii?Q?QASXIY31BmJltcp+OZg5vL8BvrXnCv/23UA+T9uBN2KJJjnuLnnqWbtmtrmp?=
 =?us-ascii?Q?xr4Hb9f237PCyrSJ3HPTuk1kD/n2a5XAT2nFrRJ223BkcCAqWxP4Q2HzDUEL?=
 =?us-ascii?Q?v0RjT/YzGjW14iIrC5/ckWwke/lMEI/ruq4qvGbwFIrYG427yXSRlMzoKRf4?=
 =?us-ascii?Q?7h9a+GvZCKMWrX5nkiW9/usth5lVSQmX8zoZlCWiPVCnV8CEUADTN+dMw3c0?=
 =?us-ascii?Q?bmGpVKqPE9a0zKV8w31oFHQIuLLvKJnlxnZiUkM2VKCqr3UMRUdJafvusUKD?=
 =?us-ascii?Q?/FAl0ayEL13EGMyfiulE4r+jwwj26bo1inuSBE6u8fT2n5FxLbc4+OxcvsUa?=
 =?us-ascii?Q?kSm9HjPclnA5PEcpyu/3kgygZnx/W6DqMZxk/RQxfcg/AMQ93zbIkbwoNKEv?=
 =?us-ascii?Q?PHCr2z+xfTW/FB4X4dh53a7sr+NN2OZJpQ/fu+6sUCagsWEPosKJsBtuc+Lc?=
 =?us-ascii?Q?0NamCbAdmUfgY51IXajdUyVs3OqBI60xRSN+1Tsk3/E93TYAw6RuUNmrOJKm?=
 =?us-ascii?Q?fxiDe0uEi8NA9GQxuxRz5jRA6QFPbU1cwcZPuz3lgpvbynldIhta0k381k+S?=
 =?us-ascii?Q?72IMwJoL6HrUbn/AooRDBcofJk45OhYNth62mHEIi3gX7F3FcRmBOyLuurBu?=
 =?us-ascii?Q?jCoQYHpYx8glysuf0Q3AVWeQdAlR2Th0Oa7uR98efFJ7PjvqPHEuKYGYgEgg?=
 =?us-ascii?Q?Mv7cF2wH7x0JIDdihqBFSArrPnliU+fnzhQPfpCrNBnLv+IdOEYQWyYr+QcJ?=
 =?us-ascii?Q?CBM3H87t+WXYh6VnIHTNIPsupWa/hYFQqmkRDjFU97YX7+MjtMb3j8K7UBez?=
 =?us-ascii?Q?oGuwyLl8ikO30dxTz8PUaGgKliJzCOwKb0NdaDGCKvqtXkisirrNUghRANxv?=
 =?us-ascii?Q?/axA/FtrgPtzkIC0Dq1f+B5bcX1hrv/BU+cLyeki?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c258d2-aff9-4cd6-9536-08dd5a396dbc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:54:45.9167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3lRdRN0sG7I+mzU2ivZYYVcRCEgzCPZaiYwvKV+mWyCUz4aXON83Ps8oEkYtc5sReFsq2hh/+YsCyr6bjwfkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187

From: Ben Ben-Ishay <benishay@nvidia.com>

After the ULP consumed the buffers of the offloaded request, it calls the
ddp_teardown op to release the NIC mapping for them and allow the NIC to
reuse the HW contexts associated with offloading this IO. We do a
fast/async un-mapping via UMR WQE. In this case, the ULP does holds off
with completing the request towards the upper/application layers until the
HW unmapping is done.

When the corresponding CQE is received, a notification is done via the
the teardown_done ddp callback advertised by the ULP in the ddp context.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  4 ++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 66 ++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    |  1 +
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  6 ++
 4 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 2fc4a7ce51ef..2589686438c0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -73,6 +73,7 @@ enum mlx5e_icosq_wqe_type {
 #endif
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
 	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP,
+	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE,
 	MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP,
 #endif
 };
@@ -251,6 +252,9 @@ struct mlx5e_icosq_wqe_info {
 		struct {
 			struct mlx5e_nvmeotcp_queue *queue;
 		} nvmeotcp_q;
+		struct {
+			struct mlx5e_nvmeotcp_queue_entry *entry;
+		} nvmeotcp_qe;
 #endif
 	};
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 9b107a87789d..5ed60c35faf8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -142,10 +142,11 @@ build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe
 		       u16 ccid, int klm_entries, u32 klm_offset, u32 len,
 		       enum wqe_type klm_type)
 {
-	u32 id = (klm_type == KLM_UMR) ? queue->ccid_table[ccid].klm_mkey :
-		 (mlx5e_tir_get_tirn(&queue->tir) << MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT);
-	u8 opc_mod = (klm_type == KLM_UMR) ? MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR :
-		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
+	u32 id = (klm_type == BSF_KLM_UMR) ?
+		 (mlx5e_tir_get_tirn(&queue->tir) << MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT) :
+		 queue->ccid_table[ccid].klm_mkey;
+	u8 opc_mod = (klm_type == BSF_KLM_UMR) ? MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS :
+		     MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR;
 	u32 ds_cnt = MLX5E_KLM_UMR_DS_CNT(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
 	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
 	struct mlx5_wqe_ctrl_seg *cseg = &wqe->ctrl;
@@ -158,6 +159,13 @@ build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe
 	cseg->qpn_ds = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) | ds_cnt);
 	cseg->general_id = cpu_to_be32(id);
 
+	if (!klm_entries) { /* this is invalidate */
+		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_FREE);
+		ucseg->flags = MLX5_UMR_INLINE;
+		mkc->status = MLX5_MKEY_STATUS_FREE;
+		return;
+	}
+
 	if (klm_type == KLM_UMR && !klm_offset) {
 		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_XLT_OCT_SIZE |
 					       MLX5_MKEY_MASK_LEN | MLX5_MKEY_MASK_FREE);
@@ -259,8 +267,8 @@ build_nvmeotcp_static_params(struct mlx5e_nvmeotcp_queue *queue,
 
 static void
 mlx5e_nvmeotcp_fill_wi(struct mlx5e_nvmeotcp_queue *nvmeotcp_queue,
-		       struct mlx5e_icosq *sq, u32 wqebbs, u16 pi,
-		       enum wqe_type type)
+		       struct mlx5e_icosq *sq, u32 wqebbs,
+		       u16 pi, u16 ccid, enum wqe_type type)
 {
 	struct mlx5e_icosq_wqe_info *wi = &sq->db.wqe_info[pi];
 
@@ -272,6 +280,10 @@ mlx5e_nvmeotcp_fill_wi(struct mlx5e_nvmeotcp_queue *nvmeotcp_queue,
 		wi->wqe_type = MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP;
 		wi->nvmeotcp_q.queue = nvmeotcp_queue;
 		break;
+	case KLM_INV_UMR:
+		wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE;
+		wi->nvmeotcp_qe.entry = &nvmeotcp_queue->ccid_table[ccid];
+		break;
 	default:
 		/* cases where no further action is required upon completion, such as ddp setup */
 		wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP;
@@ -290,7 +302,7 @@ mlx5e_nvmeotcp_rx_post_static_params_wqe(struct mlx5e_nvmeotcp_queue *queue, u32
 	wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(NULL, sq, wqebbs, pi, BSF_UMR);
+	mlx5e_nvmeotcp_fill_wi(NULL, sq, wqebbs, pi, 0, BSF_UMR);
 	build_nvmeotcp_static_params(queue, wqe, resync_seq, queue->crc_rx);
 	sq->pc += wqebbs;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, &wqe->ctrl);
@@ -307,7 +319,7 @@ mlx5e_nvmeotcp_rx_post_progress_params_wqe(struct mlx5e_nvmeotcp_queue *queue, u
 	wqebbs = MLX5E_NVMEOTCP_PROGRESS_PARAMS_WQEBBS;
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_NVMEOTCP_FETCH_PROGRESS_PARAMS_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, SET_PSV_UMR);
+	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, 0, SET_PSV_UMR);
 	build_nvmeotcp_progress_params(queue, wqe, seq);
 	sq->pc += wqebbs;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, &wqe->ctrl);
@@ -330,7 +342,7 @@ post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	wqebbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, wqe_type);
+	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, ccid, wqe_type);
 	build_nvmeotcp_klm_umr(queue, wqe, ccid, cur_klm_entries, klm_offset,
 			       klm_length, wqe_type);
 	sq->pc += wqebbs;
@@ -345,7 +357,10 @@ mlx5e_nvmeotcp_post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue, enum wqe_type wq
 	struct mlx5e_icosq *sq = &queue->sq;
 	u32 klm_offset = 0, wqes, i;
 
-	wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
+	if (wqe_type == KLM_INV_UMR)
+		wqes = 1;
+	else
+		wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
 
 	spin_lock_bh(&queue->sq_lock);
 
@@ -844,12 +859,43 @@ void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi)
 	complete(&queue->static_params_done);
 }
 
+void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi)
+{
+	struct mlx5e_nvmeotcp_queue_entry *q_entry = wi->nvmeotcp_qe.entry;
+	struct mlx5e_nvmeotcp_queue *queue = q_entry->queue;
+	struct mlx5_core_dev *mdev = queue->priv->mdev;
+	struct ulp_ddp_io *ddp = q_entry->ddp;
+	const struct ulp_ddp_ulp_ops *ulp_ops;
+
+	dma_unmap_sg(mdev->device, ddp->sg_table.sgl,
+		     ddp->nents, DMA_FROM_DEVICE);
+
+	q_entry->sgl_length = 0;
+
+	ulp_ops = inet_csk(queue->sk)->icsk_ulp_ddp_ops;
+	if (ulp_ops && ulp_ops->ddp_teardown_done)
+		ulp_ops->ddp_teardown_done(q_entry->ddp_ctx);
+}
+
 static void
 mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
 			    struct sock *sk,
 			    struct ulp_ddp_io *ddp,
 			    void *ddp_ctx)
 {
+	struct mlx5e_nvmeotcp_queue_entry *q_entry;
+	struct mlx5e_nvmeotcp_queue *queue;
+
+	queue = container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+	q_entry  = &queue->ccid_table[ddp->command_id];
+	WARN_ONCE(q_entry->sgl_length == 0,
+		  "Invalidation of empty sgl (CID 0x%x, queue 0x%x)\n",
+		  ddp->command_id, queue->id);
+
+	q_entry->ddp_ctx = ddp_ctx;
+	q_entry->queue = queue;
+
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_INV_UMR, ddp->command_id, 0);
 }
 
 static void
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
index 8b29f3fde7f2..13817d8a0aae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -109,6 +109,7 @@ void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv);
 struct mlx5e_nvmeotcp_queue *
 mlx5e_nvmeotcp_get_queue(struct mlx5e_nvmeotcp *nvmeotcp, int id);
 void mlx5e_nvmeotcp_put_queue(struct mlx5e_nvmeotcp_queue *queue);
+void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi);
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi);
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index db5e220faf55..0b9a8272430c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -958,6 +958,9 @@ void mlx5e_free_icosq_descs(struct mlx5e_icosq *sq)
 			break;
 #endif
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
+		case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE:
+			mlx5e_nvmeotcp_ddp_inv_done(wi);
+			break;
 		case MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP:
 			mlx5e_nvmeotcp_ctx_complete(wi);
 			break;
@@ -1068,6 +1071,9 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
 			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP:
 				break;
+			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE:
+				mlx5e_nvmeotcp_ddp_inv_done(wi);
+				break;
 			case MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP:
 				mlx5e_nvmeotcp_ctx_complete(wi);
 				break;
-- 
2.34.1


