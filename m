Return-Path: <netdev+bounces-168449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7913DA3F0FF
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89EE3B2B89
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD3E20459B;
	Fri, 21 Feb 2025 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rc1CWAah"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075DE20468E
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131629; cv=fail; b=KP6CQJDYOXFcU3T/9/RDOkWgJA47UZmB1D2LAZHXrFPPfQeCOTAIeRl0sbBGGEcNomAH18DJQBUa4GA5e0uQKkW5Aq7o+SRhXtRSkXnZINvADrYrIBr9RbPFAViVGpfhunz6XPDk1TFmYzyWhA10QPaA1kcE3RAp9UlW0j0knMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131629; c=relaxed/simple;
	bh=ktaw1htSZ9wJt5CfcgkmyO7HGMRkE45TkuR0kGv985Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ssb8q3c2JJ6HyxCuUgI1Vy13UxYHqz/7KMyYt8E9sPz3e9RRbpFfgHNhwZeELOgs9R/Hlbbppw092J8bFu9no0NHZt4fzWFmHN1YVrI7l5nZGeQNeKp7e/cPU68/kJWG67dE85gDZlJF8Kr2RCrXLHVFwwIQnmxuz3kJ+FmZ2Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rc1CWAah; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpDpEdAtNUu8VOPd+GYB+GbOG/buAMpSV/EpakNZLA0jw9zs8IL6Ne0m5nAMXBnkYmXBQhJVBR3WHPo8l0dumHKENE9D3h3VjICtss9xVPm9c0GWlI0UXBFrI+WwbcOdUPp+Jl4/u6WbCXIg+7urWAXS8D9mpxJOw8hzqDTNlh2cE3l7rhxkpqirwoMQ4ejrmWRyqNCtSp9t+vp4J/aLt0zbkRlfd7tv/Ipsd4rH3Fj/tBVWNdcRF0ACOGj/MLuqyHzSIXfB1RsvxYz3HhLWVcoouWjvvq6Rgzm/umFB8ChNiY8ehYrOM1pOnu4PNIu7V0IiafO3KaqOcH0NcGlHag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWsA/urTyd1064o+wp7N/kBCgk6oBc/ikBXe0D5SpcM=;
 b=BNuxWNEMrMSjxyHaqT68Cw3/9W6IqY9UWK7Ev61McDpubxHNqBdKRY+BIicXNSMCzxM7+Qs8Mxp4WPCryrD5hvOgyD6CIr+uhuryKb+9fBaKD6JV1R064occvOn7Itwiw+OR+rqurV+CAh2/klc8msqmei7ryHEIbyMS0kymNY9n8bwwlvhLdvfJwOQm35oLv8f8TorPy07lSPlHdsO0dB/Kbqlrxo1w8v+TboITXSVHo/YDj2/LXhJ3LT6+sURwxTIzvhWRs6F190y7nqh/7BEDh6QxMNE2j7D/QiCQ36lXx3yjzBqWJw4ivFVjbpufj3kdK0coRfB7V/uoqrQeSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWsA/urTyd1064o+wp7N/kBCgk6oBc/ikBXe0D5SpcM=;
 b=Rc1CWAahf3kN9kdQAUsrekexv4GtMudaP7VSmmRGuO8ed3K1Yev2tbPl4iNjzN9HqM52ixVLWnpsf1kaJuw7G3VEe7zkewkVF383J4d8Pm1U//wCkfwAcOna8ymdPE/mz+Q7mctuu3KnqX5UYAxv87mW/aKQZHuSOC+KVM6Qu0QMnc4qXlUjEACnIpSqRv12Z4BlQmlDNyPhRy8uEislMwMVYbfOTO8wd8A1hvEXoElO4F/oGgba3IVvhCFX5fPLMtTcTkg6O8f7V7Tsjq8PphWoXq0SFzdNdzhVC2nFW6gb1xIm3SapzjB2tE3m+jhB1CceBcvv6zN9agqzg2Df8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:53:40 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 09:53:40 +0000
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
Subject: [PATCH v26 11/20] net/mlx5e: Refactor ico sq polling to get budget
Date: Fri, 21 Feb 2025 09:52:16 +0000
Message-Id: <20250221095225.2159-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0484.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::21) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc7ee8e-803c-4184-b66c-08dd525d9e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9N26cLmQteU5Zuqke75u0YQR2hJJfHt+3OA7KU/TcNfqs5aJyd0dKrt2RQSh?=
 =?us-ascii?Q?k8ffWkASVMFRPsHqTDMFrGlsMSQcxA8mMlbdXD1uFXE0W/udoTeAy2Pn+NSg?=
 =?us-ascii?Q?h5RwON7J+crK1V1qt9OjJki0eTtpvFJqI2vYeTl5HEk7H/Wz1C5AGHWtieSP?=
 =?us-ascii?Q?T/IhneXmPMH+aX1X7iJabXeWVPDtpJYT+tUxit/mw++ZTGzFbQXWW761UGUT?=
 =?us-ascii?Q?puMylSWOA5IuM6VaIkGr5unMn4vh1rMFHhikpiFyIMf1jTwgaXeEAQ2dZ7ie?=
 =?us-ascii?Q?5Z1VWuzNxlq8fJy9CijKByGjPqpuXSBlKeqLsJhY+sJa5qcjrz49r01W0Zck?=
 =?us-ascii?Q?TuDzRfErZZwOdKY9HOzXf0Bj38DM1FrFDF2sKJI2StZhOVWDbr9hgSlDZa5A?=
 =?us-ascii?Q?vwi/nvQTD5EBpkLM57cUpheuqAHCYvrz335HmG3ZzK03ruvZyMbVprG+JDeR?=
 =?us-ascii?Q?ixqZkFuPMIzDg1cAIP84mM0DwEgeH7VDhF9E5uv7/on4XYChcUhsMYezKLn8?=
 =?us-ascii?Q?LtVaP/MUhX0xTHjEOeNopKnws3FpG178RGR6cMNaRgo/LfCc4phKxoGe7Ttg?=
 =?us-ascii?Q?qv6fPd9mTKwA+e9ZXG0EnLQH5rT0pZ2nuvy1vwylCuc7t+8nE885kt8uGMSN?=
 =?us-ascii?Q?NoWhkT5X3UZ1jVSzhsK3OjoZrMLloYaH8Pjwhu83NM3fnvOhkyXCFMvcjLQ4?=
 =?us-ascii?Q?sP7kPbUdXm+76/YVaBdnrseJeJs9Z86DxT0CnpNGNMIvA223lwZdH+RSXw3s?=
 =?us-ascii?Q?nfkdlwhqEXJudOwdeuLnYOv3YiJ/1XyYAwsz4dj62O7ZE8TpkB30gZH6p4HI?=
 =?us-ascii?Q?bC30sFX2FLPMoR1GUKa6Wc7u6JCJeHt39wR3IIklGGncwRyngo2wEhcJwFvC?=
 =?us-ascii?Q?q3oik2cz6DxAydTUD09hHGDz94KbNUX7SqMAnA47RtRB1xuUJ5XcStH++tBl?=
 =?us-ascii?Q?x/B/wi1m3db6yHh6DqGKuYJ0MmvkpiEdHNYlGCPh2S+p79PaVHPuPuoADBtT?=
 =?us-ascii?Q?bVT8xMzYaOANtKtCgcUlsB4CZYUIRtZgUgV3TY5yvYeifQDE+aERwtmyC/HQ?=
 =?us-ascii?Q?LpxbyeiRBVOFM9zEeqxDYHgg3ayZAa9VpNS620SFFO7W8rRNhPPkFSDCaHkz?=
 =?us-ascii?Q?hsRFcsp7oSr5bQQMHTGU7q2obIViPgrCYqPSrtuQlLE3wMh9tyoSb9BNzmoW?=
 =?us-ascii?Q?LV8b9lBXNeCJWzFPdAhAOS65PkmPFC9sSaDqfhk5Ra1b6VO+7A3SPAZyUWmC?=
 =?us-ascii?Q?NzDRcXw3GDVTMNXY+W2jxqSj6PL6RXw546GNk+5iO/tedrknkT3Wxn5Xy2fs?=
 =?us-ascii?Q?UB6jlftTsN1EXUDmwmqZjuxyIWLrsOG+r5y7mDYzK1i9zE/3kFLgx9J8ll55?=
 =?us-ascii?Q?DoGorTmwuHWw96KVZLf0BaCt+LAR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y51t8peTxDV+WX9cEuZPppSHVfBSWZ+6YsxRua9rDibQTNGvRKn1YLXhbemN?=
 =?us-ascii?Q?pBEMbWCIFA7ozVh3FxxF1gqGlHx5uZ/fL+oCjSMA/uLSqHDFwPNRxY0tbRvm?=
 =?us-ascii?Q?5KDohCV5f0H/LY7rtaZ8w1ScQnfDbDhNflYlfunpNha6f30KeIXrQYwiLHGd?=
 =?us-ascii?Q?Y0ZdF+3ATU/lmdM6kLG4lUY+GTeFe6CAuEWunVOASeEEx9s8Do5v7G/LpXQS?=
 =?us-ascii?Q?HYrRlZiWQ83tlSGPMfvYY9dmWqonDKw6wgxk8k3SvGGLaKO3HqGgVoeYFang?=
 =?us-ascii?Q?kqdHoxxg3Ex5J8VWbBfQexmcTT2FttG4YH0j5QTMnifck0VDMZUko3mpRRyT?=
 =?us-ascii?Q?3Ei4QN+JhP3wsOTbGDSvvv6BmplcPOSmD36DbHnq+SiWF/4efEbXzH3k8DjT?=
 =?us-ascii?Q?+btr6mN11Zz1BBl6OcCQaaCWgi76jFTGAFw2HOpZadyFR43jp05FjZ6HXuik?=
 =?us-ascii?Q?qVggRkLGYuPCsnCYoRwKVroRCD6DCqgrPLuj+eOmQH05KFq4CcSFJEo/onVS?=
 =?us-ascii?Q?HeUO4+Qv95p2UYQl5fatddarwaQSHB23b7WASQt71gOxZjVCjI5vrSwjVBwF?=
 =?us-ascii?Q?0wpcQOr/KVdAxEHYYOvMnrExA9h+khVawXGV7iMw4yRXlTUaE8CoD1Sz+7vE?=
 =?us-ascii?Q?5F7W3tZ03jujrxsygH58FZcWDIo2p+EU8994K6A4+q6EAp5ICqb2+o4Wz/cj?=
 =?us-ascii?Q?xDiWgMtitM2VZ0p4gjR23VLiuP+4SHQ4YA3NsS70Ek3Dhzx0qe6gBnzymuv9?=
 =?us-ascii?Q?qJVKTt65AtxVwZPXeu8rRuGkEitK3U26UtHdMIkKL6QBcb+9ImEF3UIQ3lw7?=
 =?us-ascii?Q?ALHp6Ol9PXwexeQuaMNQ8sx9//DilK9NktUnsRVJUvUIkqKrW++OEGIdqY0V?=
 =?us-ascii?Q?BBz4WyVK8o4d7EtjQQFCZGIpLkWC+zpgQd+CdPMMPr5Xz7p2OpemLzqeOLvd?=
 =?us-ascii?Q?FY/CK/uhXTZVXm4MqrmeQyPBqHnoB1jMSboZotVUHFDkvxepZwxs+W7tamEE?=
 =?us-ascii?Q?UTKZW97CIdi3QZPWIPS6jjpjz3s7mUTFeMMgpmBcNw0hE+56O3GLa8L3Xu4Y?=
 =?us-ascii?Q?l65J9SCwf92bz+zEqjQi3hzcl6L1LO/VpU4lLd5Re0R+VCASBaK195D31JPL?=
 =?us-ascii?Q?an05Xjx7XDf1AHCDirtp5eeEzEShKkj2SQTK96QtWsDULVIMx3MRHZWDZWkL?=
 =?us-ascii?Q?2yA+D5A189/f+kIa+N2qQv/u3D6oeazD/TCcdNABuznKI9qo+pkI5dyKPCT3?=
 =?us-ascii?Q?r2+uOfU8OVCI35tyCUB6FD7ny4OhGYT+F1VPUlzSfJb+mc1JY7XdWw03KBKf?=
 =?us-ascii?Q?Lk+SZvxe0IgQ7YN5YHx1EEr7HWD2JeSRcBOlroWj9Zx1knRlDkWEwS54HNPT?=
 =?us-ascii?Q?72ydxd2EsafxqSbbL4wyzht32jPAVrvUefrnFpqrhCCyq+hU7eUaxttortxo?=
 =?us-ascii?Q?aD1OwjGM2wCWKf2vBCEGTYblAVmNq153SzRP5kHowkN62W24fBraM0HRf3Iv?=
 =?us-ascii?Q?rJ2t+wVd0sZfitXFl9VGfb3wBV4hIUHhHftn2fshDImTlaRO4RgS3AXazNnG?=
 =?us-ascii?Q?D9T9+jH8qIBV41alwCJL8sktIl+NSthodIKdMW3U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc7ee8e-803c-4184-b66c-08dd525d9e68
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:53:40.1425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAQI2aD5ah9l2r65UGCOjnn6t4xRSH/QjyMWNSk3zD3PZua56ZTm+Gg6fSPD+3jk2tirE2HLuME0QJyyycjwdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127

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
index 769e683f2488..999c8ee8c1c0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -539,6 +539,7 @@ struct mlx5e_icosq {
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
index 5ec468268d1a..e710053f41fc 100644
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
index 5d5e7b19c396..229e5efa5a73 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1537,6 +1537,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
+	sq->mdev      = mdev;
 	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
 	sq->reserved_room = param->stop_room;
 
@@ -1995,11 +1996,9 @@ void mlx5e_deactivate_icosq(struct mlx5e_icosq *icosq)
 
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
index 1963bc5adb18..6512ab90b800 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -988,7 +988,7 @@ static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
 	mlx5e_shampo_fill_umr(rq, umr.len);
 }
 
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 {
 	struct mlx5e_icosq *sq = container_of(cq, struct mlx5e_icosq, cq);
 	struct mlx5_cqe64 *cqe;
@@ -1063,7 +1063,7 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
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


