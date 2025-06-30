Return-Path: <netdev+bounces-202461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8965AEE024
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48BAF7A3175
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9CF28C02A;
	Mon, 30 Jun 2025 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qv1LbM0L"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FFA28BAA1
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292526; cv=fail; b=gzxjTi+DMTFUso6Ixfly+6j8h5Amub1GpmVOdnG+yl5iLYeAa+SS2O9NhqMDeY/Edp2n+6BMquDiECuNa3Kb4nOZmId/F3LeeMFhw/y8Sk5rmfoUdp6qCU3mCwTUPCq8YfQ6D3A4iWkeeCkMMsxrXGQnR4wVmSPLFPkoLB257XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292526; c=relaxed/simple;
	bh=v9Qt32zUMOjik0CHLh6UqO8FssW5Rs1lygOUW+KSSHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ya7uoZPRKy4uD25o5mhopfeLGgdyreN8LGRUoxLVrM9hUQZQbJCcBVfSJQcVf/twjOQ4c9SCaA8ghENVZzYxlsRhK84IsZKoR7TGGHVfSUxMblJDAf8ZiRHKTRBiVIS/HmtxJeBnsMGPmNrfOQHBYagwpiJ7CcVJ3pqndtjvAqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qv1LbM0L; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhYANoBzNeHX8lq4ZkgQqTcXo2xLUNmUB04YOpqRVWJL0jMqawlJSJftvM0MzvcCWl8k7XAIZ1tkmS5Y1Cmn3LCZNRMiT1lbE4C/ES4pZ0FU++xwLy9fyvOeYtD1lJP3WARJmQaq+FpR/5wS6Q8GgSjyvdSILScwB6NwuH+bBXaYJg9jh261QnVWUDWSWbAk5ziRHozPNXtuCeg5vd98EO6wDJsRIbjUgjWXpTCfZXtchSNJoXgcOFuI2bQpLSXXLXTLFHOM5qH4fKENu1hP0kETdJIAp7WKFfqWACcYXJ24+NuWPLqVr0czGNh4uyQBnQ2ERMedm2JZ5JWmZdBU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9smcp2yWFDzRn8gspVOSFVTjI6rXMWnew2EUjwepUg=;
 b=KOuJ9c9ulbSTPk+hmarFq/uP9xkG5Td8ctuRr5F67KcwZwonxGRHBHUxmPNs4vehVcT6WssVOvpCUHT/j6meMVAcwBfBSALVFH8UEm8m1+caw3kRtMv5w/1B5Jj11r/+XSemclX7h92i64BCy0itTsUinqV+BpJgguoVEvbCnRwvXwD9mkBhA5dhEz5nByzmZbPpHmaixw9QPHyhDrABYSCnORdKJ/h3z2cBiglSp++RGkc/PNujRHXdxVrSeBindubLdgwZmpVq+5S0+IIeBAz5/NE5jKW7K18CXGpBlll5gvoKIRCoOPfCtmqGGoiCwYvOELyaYaDoPlygvIL3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9smcp2yWFDzRn8gspVOSFVTjI6rXMWnew2EUjwepUg=;
 b=Qv1LbM0La/Vg5W/g5J7n1CUtBhDkhW0ysOhuzM+J0BrSk1nMhBSuDBuwqbVJ/cr3a/6SByXmOyV92cUPazWqY/Xj1NjTwOXtf45U7q5tUE2PgAjnaudBz1JKwMXe5CIsdEfQukPXl31nuXfvp5m2beIilJIsqUCHvfSwEFScYNws84yhVOe9PT70TcANHI/fOBqQdJ1R9iUmWNp7AqvcFMr7aXDP5Jmrb9dIy1dM+06N/GcL9yACFzeCy2CLiURdGWJ8jae2fLkzOPgP6xcx5PfmvplUavYhzwxPFLb0aPXdluofbLq2h+zmjDHVln9U/uQeR9/2uysyx2b2iSTsSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 14:08:42 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 14:08:42 +0000
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
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v29 11/20] net/mlx5e: Refactor ico sq polling to get budget
Date: Mon, 30 Jun 2025 14:07:28 +0000
Message-Id: <20250630140737.28662-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630140737.28662-1-aaptel@nvidia.com>
References: <20250630140737.28662-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: f281aab9-383d-450b-34f2-08ddb7df9e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?efzuVmvlD6klHFYWW/Yb+vwSHRQ9kqkva2cjp2tdGWabkOBKJLYRqcfaMmEf?=
 =?us-ascii?Q?o985YJ/WZmoBIhtQ0NZh7JwyG7X8OTgW662Am1aOuFG8SScqhXTjO2i4gIGG?=
 =?us-ascii?Q?koPMxI1UpdvdMO1+s68rNQ4mVARlqcdGKHifL9sy1Jn+Ys/FhZDBK2DB2PgI?=
 =?us-ascii?Q?YeKUdyTTbgsMKZFql/JDNih+4uyeTGzz5+dmksqKhcNjiXczdvMedYJN8Kci?=
 =?us-ascii?Q?OPKjpWo2VcDAcN0tj73uBHr+DORYMa32xAdPdX1/drEsJO2K49Ump/Q+crf5?=
 =?us-ascii?Q?5U/0T8+/UPD3psr44M6//xFOyVFCwWLT8EiFHem1Fdl5BSQvh8shbGh7Z/Rt?=
 =?us-ascii?Q?4GsX5AIqEvtqmHXuyutMIIkeKj/YUiRNZJ7VHxMYeIFarCnl4av8K8GUWUWQ?=
 =?us-ascii?Q?EqQwCnoI8p0D5T8847RnZdAj89pM8L6TIhSgI3W30vmK5aWxAthNrQnuPR39?=
 =?us-ascii?Q?sLA3Ir/1HcT0DFGk9WWuO0zY3mj8ROYg44AJlTCxMqbOsRsSOsW7G2uRp/gm?=
 =?us-ascii?Q?ZteAfbcZbEyUuzop6sN2DbesWf6aYUzYNHo856KFnlXziNYSiuAA4f2qVCft?=
 =?us-ascii?Q?N3QeheiPkymyiYhe0lZBVZhaUqcU+l+B79TVRXnUgIQ1bFbxRwjL9cwsXNaV?=
 =?us-ascii?Q?wvLSXppd0qRV6rtKcdIcnjGJ1DmtLlr5YLmEh2SIhjxFPK9IpMsXB706hJUF?=
 =?us-ascii?Q?9x00Th6Zm8y0lJh287hsNeo1KjlQr+TmNl5yAMgEIR40Hc/EVyDiXnZnR/9E?=
 =?us-ascii?Q?0RW4J9A0IlkT8FfQ9aLY1Kb/mJVSSOS4vt3ahEgoOIT/EFlSD/o7/1EzYf7i?=
 =?us-ascii?Q?FQAbKDbSRDItcuJC+79SM25EBAdFU620lCitVwdHaKLqnXM1weFfNE76dSPb?=
 =?us-ascii?Q?2qcXmGyGsXXo1SbLxCQm52HuiqwsI2uCpSexZNrumYF7JM1nqislDg5LAw79?=
 =?us-ascii?Q?uaptPxLgd/tj07C9HJ+PTQR4y9+5TmeuIEPiipsQaO+ONunb4/4jz8AWTaNN?=
 =?us-ascii?Q?RoLvOozwO+WLvwmUHErf8EpQ2n3vl9Eu8U6YDql6RasnnIgjh2q4F5FdMzeE?=
 =?us-ascii?Q?ergaKIfTH0XV0ddZs9dLQisp+TLhHbAAsMolo1zxIpJY4mK5B4NcnonRfakQ?=
 =?us-ascii?Q?AfIF3stLdywfVvp1WlNGMutb3uzjXnmEtuw1iNZfQk6omv6rngaLQjwTWHnd?=
 =?us-ascii?Q?RE70cRowyb5ZUj6c9dmog38xhuIlB6fhpOe9bC3d8eD7wWqnrzxuXYPLr7uY?=
 =?us-ascii?Q?Qe3/eanqK8c6DHWYCOB5xJdPiEX4Syn9Cvq0iyT8Jyh8m6WOnkhB9VKzDY67?=
 =?us-ascii?Q?+JWtBqqFWki4Db804pXrnLyzokBA9bcTX/F8ApuJYhlc1NYazN9ndZI6az4Z?=
 =?us-ascii?Q?pf4hOKOIbTTV0foD8XCOQi2hGik6qPge1suannjllgUlzr27FCGG1wVjjycv?=
 =?us-ascii?Q?bI5Vw71QrdI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?83sfCKWrf1il/rqX/QxRjcvfONt3AffPenfHzQyzevF0/cwIoijOM2matKLj?=
 =?us-ascii?Q?ASCTnlvUmdPjtvE7af9V92GIyLRxQpxMMJLmOqU0Tb+dsRTgMpivw+6MHSzP?=
 =?us-ascii?Q?GZ0l9nQ4UBkYgYqGk28nyJBuj7rd6W33SiKr3iN1dU6MX73hFdgbxyzMf9EV?=
 =?us-ascii?Q?Xl2WW/aI4dv0l44jfcCBeNtbdTOCu17qqSDk/V9uzrnlp5N5+2HbCzRbiXg5?=
 =?us-ascii?Q?nxLwQxlgz13cnKBQdYeTaX2tuL6cXWW2DZweWzlsJre6SnWNEZOKTYdZwjcV?=
 =?us-ascii?Q?DdvrFRj9Pu2Kzv1jBa+Wm9NxZ6EXhG9zjjg9xmD84Ctq5VWBqUimhQhDpNmI?=
 =?us-ascii?Q?B9TcE5lAJ69DLFxmVcsgJ6OiE4AOqWAQCjjdXwJtsql21r5/njp/y2I3JtzT?=
 =?us-ascii?Q?77DWaP/wmrN7vIIcdmcjC5hdt3/nc98BlABz7IzTqjG77v+LI3Ytuy7YVNUg?=
 =?us-ascii?Q?9exTs0QKkZjRBUr4Y0bg0ARBHjkeHPl1EFldPF+S01a/rCsH/SwSrmyGkZ+H?=
 =?us-ascii?Q?Y2ZvYYBIvD2By/Gpc/2fuw2h/8aPBRW7OPMKOhEkuRwJrlrz25s+RFkp/vYF?=
 =?us-ascii?Q?tOT4VILkdzrXB+cOnIk6IbabTPeK8zoC6sXRvKRWKicHk1kNuwBLFDy9UKrg?=
 =?us-ascii?Q?IFbIr9LNaW0TFt4xJiRop/vTAHT7wvbHgtCpNo2zrcUZ2EwEZhfeBmWTsgcu?=
 =?us-ascii?Q?Bvuxls6NuKtbrKGfMAA5GpSAGeQf+2pXpi6tiXzz5BaXvFBTH8GuQ25v/wpl?=
 =?us-ascii?Q?TvKU/eqNVEcMLV9GEctEJn5S+BEsbdBveV9/XRtqwxmuqkPeD4Fiyjf2jRu8?=
 =?us-ascii?Q?VNSPmEEcnUTA4kJx13aKx94swPJcIefBTg/Dsc6SsX8KdKdfvu158HeghyNR?=
 =?us-ascii?Q?E+qzVdGG+lMVQj4jA9fBim5m2uRpE7YTd4pipjhDgh/rYiGysFQK01lIK6mQ?=
 =?us-ascii?Q?iWR/xYWmQQ/JlX0r0EzbArv/NkX2dRQZzkrrheZWDRv8idMlvtPOoSho2ASf?=
 =?us-ascii?Q?1Ygnf0glYEs3IlMUiOe6mROmt1gSm+Ll6ysDjhXE9eS3wP1Yt7MWZG0GFbKU?=
 =?us-ascii?Q?yBSj+xOKI93xcTUAtx/sO6MP7U2Ep+O/g8h0ZzA24yH0KRhmw/pdL9kPxj1W?=
 =?us-ascii?Q?bmUiArMgDkUNLDLNF9NUjSbdp9zB/zbcm5sywbosoFH2KhZYyKkbVG9t2sio?=
 =?us-ascii?Q?OOdgJpJ3ZMPes2ycD7jR92W8nej/162XeGgqWN1VWm92y4jtVb8GVvnqPnuF?=
 =?us-ascii?Q?SWdv/Ilt2DVcdMAZn40NH3+JvYB8/nQYx+BCpzhn/cZBHlLNR6IyZ/KAQMv0?=
 =?us-ascii?Q?+XwewTFPPCJLLoWgFDRIzJeNB2ycMT5tJILotaG2LxcSNqOhMhaSHyZvveh2?=
 =?us-ascii?Q?qo0/xAcAA+IbZcNEX92Tfp2YTVSpwoyRWr94iTZRUKmJuLcTo5bt5rtzxbRL?=
 =?us-ascii?Q?eHguyHcT3H+IzENal7mIR+Npiycs8mZdbSQ/gUM9EhsMUN9jEGtqcA5Y6dI5?=
 =?us-ascii?Q?EV1Kx2sU/qaqW7MiSdWODNECVPSD1Sgd5Un+oiBDlpdYqOQ9zSh2s8h1Iqga?=
 =?us-ascii?Q?Q/puCIQUZwxRgY+AxnVQAyUx4UYQDvaEI++cDkaB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f281aab9-383d-450b-34f2-08ddb7df9e50
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 14:08:42.1631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xFqckA6Sv3pomA6B8Mzrd4BBqvxZmTXPM7YKo61eR3QBcgMsB87OYMFCLtRDbvwfhfx9RDyaBbb6krTFnKZlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090

From: Or Gerlitz <ogerlitz@nvidia.com>

The mlx5e driver uses ICO SQs for internal control operations which
are not visible to the network stack, such as UMR mapping for striding
RQ (MPWQ) and etc more cases.

The upcoming nvmeotcp offload uses ico sq for umr mapping as part of the
offload. As a pre-step for nvmeotcp ico sqs which have their own napi and
need to comply with budget, add the budget as parameter to the polling of
cqs related to ico sqs.

The polling already stops after a limit is reached, so just have the
caller to provide this limit as the budget.

Additionally, we move the mdev pointer directly on the icosq structure.
This provides better separation between channels to ICO SQs for use-cases
where they are not tightly coupled (such as the upcoming nvmeotcp code).

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h             | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h        | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        | 5 ++---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c          | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c        | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 65a73913b9a2..95cb1bd0403c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -548,6 +548,7 @@ struct mlx5e_icosq {
 	/* control path */
 	struct mlx5_wq_ctrl        wq_ctrl;
 	struct mlx5e_channel      *channel;
+	struct mlx5_core_dev      *mdev;
 
 	struct work_struct         recover_work;
 } ____cacheline_aligned_in_smp;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index e75759533ae0..89807aaa870d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -46,7 +46,7 @@ static int mlx5e_query_rq_state(struct mlx5_core_dev *dev, u32 rqn, u8 *state)
 
 static int mlx5e_wait_for_icosq_flush(struct mlx5e_icosq *icosq)
 {
-	struct mlx5_core_dev *dev = icosq->channel->mdev;
+	struct mlx5_core_dev *dev = icosq->mdev;
 	unsigned long exp_time;
 
 	exp_time = jiffies + msecs_to_jiffies(mlx5_tout_ms(dev, FLUSH_ON_ERROR));
@@ -91,7 +91,7 @@ static int mlx5e_rx_reporter_err_icosq_cqe_recover(void *ctx)
 	rq = &icosq->channel->rq;
 	if (test_bit(MLX5E_RQ_STATE_ENABLED, &icosq->channel->xskrq.state))
 		xskrq = &icosq->channel->xskrq;
-	mdev = icosq->channel->mdev;
+	mdev = icosq->mdev;
 	dev = icosq->channel->netdev;
 	err = mlx5_core_query_sq_state(mdev, icosq->sqn, &state);
 	if (err) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 6501252359b0..5aa5b5833c56 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -83,7 +83,7 @@ void mlx5e_trigger_irq(struct mlx5e_icosq *sq);
 void mlx5e_completion_event(struct mlx5_core_cq *mcq, struct mlx5_eqe *eqe);
 void mlx5e_cq_error_event(struct mlx5_core_cq *mcq, enum mlx5_event event);
 int mlx5e_napi_poll(struct napi_struct *napi, int budget);
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq);
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget);
 
 /* RX */
 INDIRECT_CALLABLE_DECLARE(bool mlx5e_post_rx_wqes(struct mlx5e_rq *rq));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index dca5ca51a470..d2936a75e5e5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1584,6 +1584,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
+	sq->mdev      = mdev;
 	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
 	sq->reserved_room = param->stop_room;
 
@@ -2055,11 +2056,9 @@ void mlx5e_deactivate_icosq(struct mlx5e_icosq *icosq)
 
 static void mlx5e_close_icosq(struct mlx5e_icosq *sq)
 {
-	struct mlx5e_channel *c = sq->channel;
-
 	if (sq->ktls_resync)
 		mlx5e_ktls_rx_resync_destroy_resp_list(sq->ktls_resync);
-	mlx5e_destroy_sq(c->mdev, sq->sqn);
+	mlx5e_destroy_sq(sq->mdev, sq->sqn);
 	mlx5e_free_icosq_descs(sq);
 	mlx5e_free_icosq(sq);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 2bb32082bfcc..f4c8c3f3c0d7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -993,7 +993,7 @@ static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
 	mlx5e_shampo_fill_umr(rq, umr.len);
 }
 
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 {
 	struct mlx5e_icosq *sq = container_of(cq, struct mlx5e_icosq, cq);
 	struct mlx5_cqe64 *cqe;
@@ -1068,7 +1068,7 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
 						 wi->wqe_type);
 			}
 		} while (!last_wqe);
-	} while ((++i < MLX5E_TX_CQ_POLL_BUDGET) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
+	} while ((++i < budget) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
 
 	sq->cc = sqcc;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 76108299ea57..af0ae65cb87c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -179,8 +179,8 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 
 	busy |= work_done == budget;
 
-	mlx5e_poll_ico_cq(&c->icosq.cq);
-	if (mlx5e_poll_ico_cq(&c->async_icosq.cq))
+	mlx5e_poll_ico_cq(&c->icosq.cq, MLX5E_TX_CQ_POLL_BUDGET);
+	if (mlx5e_poll_ico_cq(&c->async_icosq.cq, MLX5E_TX_CQ_POLL_BUDGET))
 		/* Don't clear the flag if nothing was polled to prevent
 		 * queueing more WQEs and overflowing the async ICOSQ.
 		 */
-- 
2.34.1


