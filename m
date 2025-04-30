Return-Path: <netdev+bounces-186987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B34AA462F
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86401C00B9E
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE2621C9F0;
	Wed, 30 Apr 2025 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tCnaXOe9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DDB21D3D0
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003576; cv=fail; b=RzAV+L3AfFTnlNqqhkHadA+2+uP2NE1hLeD+Q8cVPhpGOsh8nHr5Mc6jePh6ll20iwh5VzA7NT5My5Hbin8/sVhxOTJ0mnYyDE6c2M6NXlVgXGnbd5jmxGI6vDK4zv0PIqlnb+Z5T6rKuKWIw6g3NwXezyjniaPgiE39msKl1A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003576; c=relaxed/simple;
	bh=b8DKhsJZogwJgNJTsgC+hxX6Pdow2xpD940e5Sgrqg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SzNFxNNFiesYwmSJ3J8jXqXSURW/XlSJvt2dhg/42KxPLOvJ8zryTzKwrsfjJCqdCGEaQ0Ww0MjBEJJNLfoAmwUOI2vGT4ZGbkLEhcmUi3ZyUk/uK2AypsEtggjUh0CvioD4ld+BcO48i78mAnVnHMN235vkzdqR9XTUTSVoOVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tCnaXOe9; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URuIwj28sS8QtuiCvxBVs76c8fHSByu1nSEW99K9t+ZsSnm+0mPhDhCUqA4Xep3YHf/ifV7Y9QvAn27uMqQLFiyleaPRs/6S7MDDfzQXMqsOg/fbcDHdZQT7aV/qNb9w2Cy+XEpPa/Fbx2Qvf9ZyDmsRPZBpdEkvoZpZxaacoCiB+wg/epKydv64/K+dlgDt23o8OTB7ysA44snY3dIQIfzBRZSL2SozWZPja2B4p1FHL1frFt2+CxHx5E2C8nVyB3+mFHtqbQRSbjqe3pR+qsDIfXJmkO2VDtYXMnMD8GXEHDGfrd1EzelQaIAqHM0lHIS2kLaLIoOC+LUYtvyw2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqvO7MlskCevvDTOKFe9ZTdmi0ZmR2qwn51Rpw42jkk=;
 b=XhcXYO6q6UXFQKAqLteciPVxxhVc77O52woTyZDFTViHQbuo5UNngbMU4+oOamRjRDLrIszHQa/JkZY22UCnljC7bhrhD2gS6IxOL9+2sFsjGwB3IEvthjsP6vGu7CGCw5OYR5EMkIx07mycsOKuHLmlrpt/e3NuMaZ+FqBZwU6b3LkEF815ea1di6B/X78wmwijbQOQ5wkP32ujvYTPrhrh4B052djd+gLMzcWBGYWP1s9Xvp6waqWLjovV08r3BvhLuoO/hV8GRBf606qTpYN282KR5lWEJX3k5I6NFQhzX++YWVBk8zC5IUOZbDj9fgZZxvcGX2D9irdnouJYvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqvO7MlskCevvDTOKFe9ZTdmi0ZmR2qwn51Rpw42jkk=;
 b=tCnaXOe9JaHy7qdpKnrPbyjIYCKluTE2mr/4HksjTR3+oqcSgpZ+G6yRbm+BFDCGPA7L733m5/5HJnLpOwBAkDwbC6wXHlm+z4wJrn7V/Y2x2grxwYBM1H8DkQlStR8zEgxyMjRWwmDmDY77oUopvDuduyBes0FZo5Xlo24XXDNJCYmry1KVyymPkAXlzyr3EKjBFM0ZcFiSmqySqtmOaOIA0NZ0fcBk8HmtFFRCqfZC+0p7grHI2DWTlwNlcWJ4vZYOGGLYzoW4v/hLbgvYQX4BD17WZoUWpwXQn2TDg7i8UNqof5C4LO+J7oTbwLKMS4jCfiHYLI1ujfKpTPuSjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 30 Apr
 2025 08:59:29 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:59:29 +0000
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
Cc: Aurelien Aptel <aaptel@nvidia.com>,
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
Subject: [PATCH v28 20/20] net/mlx5e: NVMEoTCP, statistics
Date: Wed, 30 Apr 2025 08:57:41 +0000
Message-Id: <20250430085741.5108-21-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430085741.5108-1-aaptel@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: bd632fcb-372d-4798-ef55-08dd87c550af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tqolqz+jDuqkjcNyLntmjXJCDe+3lFsNOvdbiiqLYc1R76h/UOI8SWVVMSqn?=
 =?us-ascii?Q?IodHi3EUS/51ExjVk0PvtjFrt5LDZ9kLLi5z6h+QzFUpy7PcmQxRMDysYdJr?=
 =?us-ascii?Q?jiWSXaNSTHEIW9yztQDKmL3sQPAp4S74Ki5FetcQHjxi4auBwcAhgbJ+uDXe?=
 =?us-ascii?Q?6U9R9PjzY+scYzHDw6p26z0/+3LxBGyYeE4Ei+31eug5D8oVjW3nfNDWaumv?=
 =?us-ascii?Q?lVst7GLnEOWL8oaB2xvlFGC8oyrx+4kYfuEPpGJ4Nyl8yE2SzvkgP5bqymVR?=
 =?us-ascii?Q?DtoCl58boeq4vKsuFildX+a4ukaRbaSOah1MsAIDYnnk7ePheKdERd30jvUJ?=
 =?us-ascii?Q?Sa40SpLvfn9nlJhIzQefLaxpoat6ggVhyXA+khWIl41fMM554fZi5C0EiWlJ?=
 =?us-ascii?Q?rY85mb/jN6QuQiuJMd9C8tSrcNTzUOgxc0H36ksq0YgEgEOAR87UmibXWPJw?=
 =?us-ascii?Q?HXmYwJyqqnM8bIsd3D6OieOzIqGCdOTbmiwFPQOrZcC8xsyL/yvdnVNw/ASq?=
 =?us-ascii?Q?nUSlEDY503t+gYIRmgSASdiX1XVwEIfr5elTNYkYYJTIjfhHnYM8b+1W4NuF?=
 =?us-ascii?Q?BUJzxaBj9RApvYPupsYoFVoWQH3iEr0XEkuW8oMz1s70+eVOAM+0UFFRXazo?=
 =?us-ascii?Q?TJyb914aV2Hg0Vwd3kQOobqIP9cgbip169wdZOWpott5Nbrqy2sPbJsvGITj?=
 =?us-ascii?Q?VY2DwOIvlsgD3wZECaM10YKUN0foeM1FcI/jeiNQHy7e1xU4LgHgj0F0Dbks?=
 =?us-ascii?Q?7QKAnRvbqs8rgCmuYL+NUTeqKrYFX/+ajqokJu/UZkufMjY9KnLQwsUlKnWw?=
 =?us-ascii?Q?ifqBd5La3FHS+4deiyCxDeyGYV6SFijmrs/fVjvRzFLqKnCO9O2aQZUWywJO?=
 =?us-ascii?Q?kEVwGi9pGPioIhuJl4rsPDDbQXT8qABTeamwvZMjhxH5HXbgSzyXHFFacmWg?=
 =?us-ascii?Q?5rCjQmjOXUQq+V4a0Q3+QewEleFZNQeezJgwFrNfPEqT9wovaYlNWcqes8Jp?=
 =?us-ascii?Q?0kpDyB1nQWdn3A+Mcqi5U7ezxAIrUx0mK6BrcouTQCXfZ9jp7oWrF8XhKIS3?=
 =?us-ascii?Q?DtM8zI7xTcUZk57zk6rGyUTA+a6+UC4/0M8um8KGhZw2AdbB+pAs62geSNWL?=
 =?us-ascii?Q?1E7UwjuX/cMx57ju7CAmXVUlDI9w5GrHC5KuHdCpBZ/TqoMlG+K/sLqjP9HZ?=
 =?us-ascii?Q?8LP3ylRihQkni0orAUS6FdnUxmm6+4GGD0aY5x0S9RFnuqehiw7szeRw5vwf?=
 =?us-ascii?Q?bZwwZfhsO2ajw0QdJ956cVp0RpOsanleorySroNtvkDZV9vxCDsjZrqzSbAv?=
 =?us-ascii?Q?Q96AQdsKm2jzgqAU+TfyIOFW5M4NKErksa2xcIWi4DNyi6eEr0ShmNOIzJiH?=
 =?us-ascii?Q?uHw2hSdr9YhWFZCQEygd5uERxlWw00+1JUyKDpT/KGps3c3MqZe1LYPJ38rV?=
 =?us-ascii?Q?idVQoGmQyfc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p42ERcZXrznAB5lNNOYq0e3yZ9bHpIcc8LJMn/rIVkLQ5u/t69izDmt6WvAq?=
 =?us-ascii?Q?v5lgF1NQHWDS3s1knX6Hm/fBVnuj7oG/FucgnMN/lBcR4uv36gJR7KpH4Wyd?=
 =?us-ascii?Q?++7xkYinyLOH/pADVludbj2KBCPkS2M4gfvU/kY4Pe5VKKGWTNfLhpHQ8imB?=
 =?us-ascii?Q?HJ92bZS1KL9tieqGiggJNehIyBvjLA4LiYjt5CB+0ZQcpHuP6hZkpmPkvKfF?=
 =?us-ascii?Q?y8uLKcho/U+U+GUsWrkso78UV5rcIzq/yXRd3DG27ukYjIx5rbOfIJqWnUsN?=
 =?us-ascii?Q?/zPmjO9ca6h2YkNcz5BxuwwMZ8smbEOlP1HcI/t63t6zFxVm6eAaazJTmgFJ?=
 =?us-ascii?Q?ZV4ah/tFAEeTcA84mjYscSKkcheSmitp2DzIQ0Avz7uBHx5OeN26Zkbp4Si8?=
 =?us-ascii?Q?6x+UydIoTrnnY+Jw7tjGgAv7QzQfGAfNNghjXZcy076p/yVekNglWg1Ay2Jq?=
 =?us-ascii?Q?Q9q6BAxB44J3iEIiVdupKaDq7R16y+ApWYVaIakpTEkMZgoyubwCqIfMr2xh?=
 =?us-ascii?Q?brnoTSKnMy7/2SExn8sPaJp1Aqb1O19lLgboO1+IDmvK3L8BpO2AsvZIE2nH?=
 =?us-ascii?Q?y2jRBIKpnqO8qPPdbx/6BB7LIMd1xyHWAKhWl37iCvJ+CBnAovX99LBMRUWY?=
 =?us-ascii?Q?5SD+SbXHjwq8alAxO88ropr5rPAIFFhlB5Ywn4A8xY6ZyIHNbxvdi9eHbY51?=
 =?us-ascii?Q?8GcH1FYUMYlsKCSBqYJK8nrf3jgIEtXEMzfOaBHk4ckmdvwS4yqoeHd/vzlP?=
 =?us-ascii?Q?8qae2wnkEIwX0N2ppMGJtZeiE0tya/TJDnYi3bin9a7r5QoHlLw7zysU4LNr?=
 =?us-ascii?Q?EeloBytebOQk3lkjaflze0loJKQysSeRmDUhGxpRWJgL4tV04lfVdywLzyIU?=
 =?us-ascii?Q?t2L5VM/U7h6+Lcz1Iw2TTG+ZbS7BB3kr1kkFACJDDPHT0yvNNQAORVdi1vTK?=
 =?us-ascii?Q?SPYHTB7A69LkJ7hzBRQ7zM/xdr7DJiXvJqNMpLiFUdH5kGpOM/rt24ueUigF?=
 =?us-ascii?Q?jr4yeyl9bPFpDgRGpVKNYx8Rmc+OMTEnOYFrt+cmZOdvMc8AMUsKTewxZpx9?=
 =?us-ascii?Q?b0ckmixA6lBTXhjAiTA7pbl+2Np9+hILGgMMcqTnCQbS1t9XFacMQS6nd9yy?=
 =?us-ascii?Q?SXoLdXbp4XuETUTP3qXsuEkYuOfJvxbAnI4ALJycVsPItFCf3luPypGMrRNN?=
 =?us-ascii?Q?KRtMUk9OM0ERUxU3SelTV/oQ/rqzus79PvnBbxVkSqSw7xcFGUhhVbkGpkRJ?=
 =?us-ascii?Q?RiuFi5Df9w5wbPWNqfGhdKiOh7f9R6VE9xZcvw4FOhaXTsGvs0oY76gbEj+N?=
 =?us-ascii?Q?68o7cAkb2hPxjjtH1zQQYCtOP1L0Xks3WVL3EacO6PssSsg0mpDnuKncj7yL?=
 =?us-ascii?Q?7nPHcpJBKzXyzcXDzLMG2VTOY9zZ1tEHNiTutKXORhcwNjDHQUPFNfO2Liuj?=
 =?us-ascii?Q?/IWmt4QWFaJi1fjfr9ZmDqC+sINzqSSnpB9MnUGgeGHKQkIrhwzb3tCXgUPV?=
 =?us-ascii?Q?BJE20AWFKgRCVZJyWB/IK99Fnx7wPdmLiBzJMJeWHOz1UEJaS/dqaGPXzEwL?=
 =?us-ascii?Q?y7/mykceAUhg+bGxW+YJNdjPHz07jMGbJ2Br5rEv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd632fcb-372d-4798-ef55-08dd87c550af
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:59:28.9704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Th4nx6GHB8v6yhIjYsCtuLLSFVjGChEnI7Lo1h5T8aRQ3UwfrIi0PSAVe+qET/QQm6LZ+adpuU7t0qntyFD8Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319

NVMEoTCP offload statistics include both control and data path
statistic: counters for the netdev ddp ops, offloaded packets/bytes,
resync and dropped packets.

Expose the statistics using ulp_ddp_ops->get_stats()
instead of the regular statistics flow.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |  3 +-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 54 ++++++++++++---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    | 17 +++++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.c        | 11 ++-
 .../mlx5/core/en_accel/nvmeotcp_stats.c       | 69 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  9 +++
 6 files changed, 151 insertions(+), 12 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index c661d46cd520..89d07eca52d2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -110,7 +110,8 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
-mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o en_accel/nvmeotcp_rxtx.o
+mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o \
+					en_accel/nvmeotcp_rxtx.o en_accel/nvmeotcp_stats.o
 
 #
 # SW Steering
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 639a9187d88c..c4cf48141f02 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -670,9 +670,15 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 {
 	struct nvme_tcp_ddp_config *nvme_config = &config->nvmeotcp;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_nvmeotcp_sw_stats *sw_stats;
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_nvmeotcp_queue *queue;
 	int queue_id, err;
+	u32 channel_ix;
+
+	channel_ix = mlx5e_get_channel_ix_from_io_cpu(&priv->channels.params,
+						      config->affinity_hint);
+	sw_stats = &priv->nvmeotcp->sw_stats;
 
 	if (config->type != ULP_DDP_NVME) {
 		err = -EOPNOTSUPP;
@@ -700,12 +706,11 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 	queue->id = queue_id;
 	queue->dgst = nvme_config->dgst;
 	queue->pda = nvme_config->cpda;
-	queue->channel_ix =
-		mlx5e_get_channel_ix_from_io_cpu(&priv->channels.params,
-						 config->affinity_hint);
+	queue->channel_ix = channel_ix;
 	queue->size = nvme_config->queue_size;
 	queue->max_klms_per_wqe = MLX5E_MAX_KLM_PER_WQE(mdev);
 	queue->priv = priv;
+	queue->sw_stats = sw_stats;
 	init_completion(&queue->static_params_done);
 
 	err = mlx5e_nvmeotcp_queue_rx_init(queue, config, netdev);
@@ -717,6 +722,7 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 	if (err)
 		goto destroy_rx;
 
+	atomic64_inc(&sw_stats->rx_nvmeotcp_sk_add);
 	write_lock_bh(&sk->sk_callback_lock);
 	ulp_ddp_set_ctx(sk, queue);
 	write_unlock_bh(&sk->sk_callback_lock);
@@ -730,6 +736,7 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 free_queue:
 	kfree(queue);
 out:
+	atomic64_inc(&sw_stats->rx_nvmeotcp_sk_add_fail);
 	return err;
 }
 
@@ -744,6 +751,8 @@ mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
 	queue = container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue,
 			     ulp_ddp_ctx);
 
+	atomic64_inc(&queue->sw_stats->rx_nvmeotcp_sk_del);
+
 	WARN_ON(refcount_read(&queue->ref_count) != 1);
 	mlx5e_nvmeotcp_destroy_rx(priv, queue, mdev);
 
@@ -878,25 +887,34 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct ulp_ddp_io *ddp)
 {
 	struct scatterlist *sg = ddp->sg_table.sgl;
+	struct mlx5e_nvmeotcp_sw_stats *sw_stats;
 	struct mlx5e_nvmeotcp_queue_entry *nvqt;
 	struct mlx5e_nvmeotcp_queue *queue;
 	struct mlx5_core_dev *mdev;
 	int i, size = 0, count = 0;
+	int ret = 0;
 
 	queue = container_of(ulp_ddp_get_ctx(sk),
 			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+	sw_stats = queue->sw_stats;
 	mdev = queue->priv->mdev;
 	count = dma_map_sg(mdev->device, ddp->sg_table.sgl, ddp->nents,
 			   DMA_FROM_DEVICE);
 
-	if (count <= 0)
-		return -EINVAL;
+	if (count <= 0) {
+		ret = -EINVAL;
+		goto ddp_setup_fail;
+	}
 
-	if (WARN_ON(count > mlx5e_get_max_sgl(mdev)))
-		return -ENOSPC;
+	if (WARN_ON(count > mlx5e_get_max_sgl(mdev))) {
+		ret = -ENOSPC;
+		goto ddp_setup_fail;
+	}
 
-	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu)))
-		return -EOPNOTSUPP;
+	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu))) {
+		ret = -EOPNOTSUPP;
+		goto ddp_setup_fail;
+	}
 
 	for (i = 0; i < count; i++)
 		size += sg_dma_len(&sg[i]);
@@ -908,8 +926,14 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 	nvqt->ccid_gen++;
 	nvqt->sgl_length = count;
 	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, count);
-
+	atomic64_inc(&sw_stats->rx_nvmeotcp_ddp_setup);
 	return 0;
+
+ddp_setup_fail:
+	dma_unmap_sg(mdev->device, ddp->sg_table.sgl, ddp->nents,
+		     DMA_FROM_DEVICE);
+	atomic64_inc(&sw_stats->rx_nvmeotcp_ddp_setup_fail);
+	return ret;
 }
 
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi)
@@ -957,6 +981,7 @@ mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
 	q_entry->queue = queue;
 
 	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_INV_UMR, ddp->command_id, 0);
+	atomic64_inc(&queue->sw_stats->rx_nvmeotcp_ddp_teardown);
 }
 
 static void
@@ -991,6 +1016,14 @@ void mlx5e_nvmeotcp_put_queue(struct mlx5e_nvmeotcp_queue *queue)
 	}
 }
 
+static int mlx5e_ulp_ddp_get_stats(struct net_device *dev,
+				   struct ulp_ddp_stats *stats)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	return mlx5e_nvmeotcp_get_stats(priv, stats);
+}
+
 int set_ulp_ddp_nvme_tcp(struct net_device *netdev, bool enable)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
@@ -1101,6 +1134,7 @@ const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops = {
 	.resync = mlx5e_nvmeotcp_ddp_resync,
 	.set_caps = mlx5e_ulp_ddp_set_caps,
 	.get_caps = mlx5e_ulp_ddp_get_caps,
+	.get_stats = mlx5e_ulp_ddp_get_stats,
 };
 
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
index 67805adc6fdf..54b0b39825b9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -9,6 +9,15 @@
 #include "en.h"
 #include "en/params.h"
 
+struct mlx5e_nvmeotcp_sw_stats {
+	atomic64_t rx_nvmeotcp_sk_add;
+	atomic64_t rx_nvmeotcp_sk_add_fail;
+	atomic64_t rx_nvmeotcp_sk_del;
+	atomic64_t rx_nvmeotcp_ddp_setup;
+	atomic64_t rx_nvmeotcp_ddp_setup_fail;
+	atomic64_t rx_nvmeotcp_ddp_teardown;
+};
+
 struct mlx5e_nvmeotcp_queue_entry {
 	struct mlx5e_nvmeotcp_queue *queue;
 	u32 sgl_length;
@@ -52,6 +61,7 @@ struct mlx5e_nvmeotcp_queue_handler {
  *	@sk: The socket used by the NVMe-TCP queue
  *	@crc_rx: CRC Rx offload indication for this queue
  *	@priv: mlx5e netdev priv
+ *	@sw_stats: Global software statistics for nvmeotcp offload
  *	@static_params_done: Async completion structure for the initial umr
  *      mapping synchronization
  *	@sq_lock: Spin lock for the icosq
@@ -90,6 +100,7 @@ struct mlx5e_nvmeotcp_queue {
 	u8 crc_rx:1;
 	/* for ddp invalidate flow */
 	struct mlx5e_priv *priv;
+	struct mlx5e_nvmeotcp_sw_stats *sw_stats;
 	/* end of data-path section */
 
 	struct completion static_params_done;
@@ -101,6 +112,7 @@ struct mlx5e_nvmeotcp_queue {
 };
 
 struct mlx5e_nvmeotcp {
+	struct mlx5e_nvmeotcp_sw_stats sw_stats;
 	struct ida queue_ids;
 	struct rhashtable queue_hash;
 	struct ulp_ddp_dev_caps ddp_caps;
@@ -117,6 +129,8 @@ void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi);
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi);
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
+int mlx5e_nvmeotcp_get_stats(struct mlx5e_priv *priv,
+			     struct ulp_ddp_stats *stats);
 extern const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops;
 #else
 
@@ -126,5 +140,8 @@ static inline int set_ulp_ddp_nvme_tcp(struct net_device *dev, bool en)
 { return -EOPNOTSUPP; }
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 static inline void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv) {}
+static inline int mlx5e_nvmeotcp_get_stats(struct mlx5e_priv *priv,
+					   struct ulp_ddp_stats *stats)
+{ return 0; }
 #endif
 #endif /* __MLX5E_NVMEOTCP_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
index 2b7f0bf7270c..ec621d886a39 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
@@ -146,6 +146,7 @@ mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq,
 	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
 	struct net_device *netdev = rq->netdev;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_rq_stats *stats = rq->stats;
 	struct mlx5e_nvmeotcp_queue_entry *nqe;
 	skb_frag_t org_frags[MAX_SKB_FRAGS];
 	struct mlx5e_nvmeotcp_queue *queue;
@@ -157,12 +158,14 @@ mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq,
 	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
 	if (unlikely(!queue)) {
 		dev_kfree_skb_any(skb);
+		stats->nvmeotcp_drop++;
 		return false;
 	}
 
 	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
 	if (cqe_is_nvmeotcp_resync(cqe)) {
 		nvmeotcp_update_resync(queue, cqe128);
+		stats->nvmeotcp_resync++;
 		mlx5e_nvmeotcp_put_queue(queue);
 		return true;
 	}
@@ -239,7 +242,8 @@ mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq,
 						 org_nr_frags,
 						 frag_index);
 	}
-
+	stats->nvmeotcp_packets++;
+	stats->nvmeotcp_bytes += cclen;
 	mlx5e_nvmeotcp_put_queue(queue);
 	return true;
 }
@@ -251,6 +255,7 @@ mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
 	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
 	struct net_device *netdev = rq->netdev;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_rq_stats *stats = rq->stats;
 	struct mlx5e_nvmeotcp_queue_entry *nqe;
 	struct mlx5e_nvmeotcp_queue *queue;
 	struct mlx5e_cqe128 *cqe128;
@@ -260,12 +265,14 @@ mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
 	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
 	if (unlikely(!queue)) {
 		dev_kfree_skb_any(skb);
+		stats->nvmeotcp_drop++;
 		return false;
 	}
 
 	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
 	if (cqe_is_nvmeotcp_resync(cqe)) {
 		nvmeotcp_update_resync(queue, cqe128);
+		stats->nvmeotcp_resync++;
 		mlx5e_nvmeotcp_put_queue(queue);
 		return true;
 	}
@@ -342,6 +349,8 @@ mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
 				       hlen + cclen, remaining);
 	}
 
+	stats->nvmeotcp_packets++;
+	stats->nvmeotcp_bytes += cclen;
 	mlx5e_nvmeotcp_put_queue(queue);
 	return true;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c
new file mode 100644
index 000000000000..7b0dad4fa272
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.
+
+#include "en_accel/nvmeotcp.h"
+
+struct ulp_ddp_counter_map {
+	size_t eth_offset;
+	size_t mlx_offset;
+};
+
+#define DECLARE_ULP_SW_STAT(fld) \
+	{ offsetof(struct ulp_ddp_stats, fld), \
+	  offsetof(struct mlx5e_nvmeotcp_sw_stats, fld) }
+
+#define DECLARE_ULP_RQ_STAT(fld) \
+	{ offsetof(struct ulp_ddp_stats, rx_ ## fld), \
+	  offsetof(struct mlx5e_rq_stats, fld) }
+
+#define READ_CTR_ATOMIC64(ptr, dsc, i) \
+	atomic64_read((atomic64_t *)((char *)(ptr) + (dsc)[i].mlx_offset))
+
+#define READ_CTR(ptr, desc, i) \
+	(*((u64 *)((char *)(ptr) + (desc)[i].mlx_offset)))
+
+#define SET_ULP_STAT(ptr, desc, i, val) \
+	(*(u64 *)((char *)(ptr) + (desc)[i].eth_offset) = (val))
+
+/* Global counters */
+static const struct ulp_ddp_counter_map sw_stats_desc[] = {
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_sk_add),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_sk_del),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_ddp_setup),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_ddp_setup_fail),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_ddp_teardown),
+};
+
+/* Per-rx-queue counters */
+static const struct ulp_ddp_counter_map rq_stats_desc[] = {
+	DECLARE_ULP_RQ_STAT(nvmeotcp_drop),
+	DECLARE_ULP_RQ_STAT(nvmeotcp_resync),
+	DECLARE_ULP_RQ_STAT(nvmeotcp_packets),
+	DECLARE_ULP_RQ_STAT(nvmeotcp_bytes),
+};
+
+int mlx5e_nvmeotcp_get_stats(struct mlx5e_priv *priv,
+			     struct ulp_ddp_stats *stats)
+{
+	unsigned int i, ch, n = 0;
+
+	if (!priv->nvmeotcp)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(sw_stats_desc); i++, n++)
+		SET_ULP_STAT(stats, sw_stats_desc, i,
+			     READ_CTR_ATOMIC64(&priv->nvmeotcp->sw_stats,
+					       sw_stats_desc, i));
+
+	for (i = 0; i < ARRAY_SIZE(rq_stats_desc); i++, n++) {
+		u64 sum = 0;
+
+		for (ch = 0; ch < priv->stats_nch; ch++)
+			sum += READ_CTR(&priv->channel_stats[ch]->rq,
+					rq_stats_desc, i);
+
+		SET_ULP_STAT(stats, rq_stats_desc, i, sum);
+	}
+
+	return n;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index def5dea1463d..e350d5d04c21 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -132,6 +132,9 @@ void mlx5e_stats_ts_get(struct mlx5e_priv *priv,
 			struct ethtool_ts_stats *ts_stats);
 void mlx5e_get_link_ext_stats(struct net_device *dev,
 			      struct ethtool_link_ext_stats *stats);
+struct ulp_ddp_stats;
+void mlx5e_stats_ulp_ddp_get(struct mlx5e_priv *priv,
+			     struct ulp_ddp_stats *stats);
 
 /* Concrete NIC Stats */
 
@@ -406,6 +409,12 @@ struct mlx5e_rq_stats {
 	u64 tls_resync_res_skip;
 	u64 tls_err;
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	u64 nvmeotcp_drop;
+	u64 nvmeotcp_resync;
+	u64 nvmeotcp_packets;
+	u64 nvmeotcp_bytes;
+#endif
 };
 
 struct mlx5e_sq_stats {
-- 
2.34.1


