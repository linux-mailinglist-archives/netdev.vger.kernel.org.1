Return-Path: <netdev+bounces-118743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 891529529BE
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 09:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF6B1F237CE
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 07:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A5C17A5A4;
	Thu, 15 Aug 2024 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lq3dDn7C"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F269145B2C
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706309; cv=fail; b=gk8Lr76OyjDArTfKC0K380oWih5kTli5PGtoYrQQAI9gNb/37zFi7bSWYyP+l+pGqFOgRkkqi5rv2nobCV0DwPAHHsJ/sLpbUfgduItkHduW3RIXfU+TxU0dKj7nviPUZX06MYxKKV3slihu3E8Klx65DBbnv0PCkTk1cOAosUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706309; c=relaxed/simple;
	bh=LeW2AziNUsLDi+2ySYaNj5cOWaKaNIFZxDrcxpbopqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0Pqc3zAsCs/F4qGKQRLoWJmdt5yoto8N8uteaIvE11iCS1Hp6Otc8zDOt6IpHfDT9E16S7XeP/XiRNlXO6ZiXRqyLGUEWgagQpWIuyKJB28ne6R8VD9ZcqfnBuDjurRC2zrUbKXsp+2uHxR8xU1aYGjmD84vV1f9RT49LoXMKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lq3dDn7C; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENI/VQp1fVoodJRwpxbTcyN9eJ5Er6UwimWLCexx2EF7tSF/GKMuLFC+yiyLkFXD6Ip2BVCd2r1CJiBGu9NJDVnnoxQEO0G15wOZ01SHBq7hJvmIVS28TarYORbH0lFvxWTXQZot/mY11cCAjLLyOl49xCyVJSB1iZga6Vm2b3xlmvpxl4KCkktg2f4YbQ9ASqtkhxHcR8rqkCIuUIUoDmk5oHTQ4ciDRvU7dciuXXCPirGcfC/rDREcGiavknlU++ajhBnrjjXL+GGjcuZY1dri1D5opCUsUmFgG9KRE+QNxq9n/B3NnbH/D3syQIVIb6AI7NAiGGPWx3L3s/XC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnEHs5qN75UExovDalECOn7B7tzDrriTS5gkR+K+afw=;
 b=VwN3prfw1dvjdJvj/NXSkU6e5Q1Hfu4477TwUudkAx8ufHDOCve18JzDwlZRxBxz+X6SOmg398YRWnlEQMgJYPxd2WyVY4vRBzPuXyxrzq6512qFA7qZMUhtHtx20Ytvlt2HJ+lMqSkJDAxEfu8jMEbFZs0YXckiWySOufC6mZtE5sdzwfa5uJ5b8v2ND9eSLLUyZBVas9Cp95K09hduzvpcow2eLRXZnLweEp9Q+QZjZaJACAHmNeik6r5AWaJniLldGVSm/PAoG3KKSRbT6l2a7jn6cnd321LYONwEML0i5LMA1wzNMk1sqbIWMUOFpAlfb5BPuFTOAz03mLBsMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnEHs5qN75UExovDalECOn7B7tzDrriTS5gkR+K+afw=;
 b=lq3dDn7C4as2TDLVhw3fMYE3EZ13uXREwfXZZZBMnmgqkt+aWAVPq5r4aekPFF1Kl4/mhgMQOLLI37rnpCWfCw7IynArun6CmpBgUfzFywoM80HKunHmItpER4lmY5/lNO9XFC0vYM0vtQb818jKNqbj/bI8pkE+Oxu0WuqECcM7mu4WC+tuOD3LkyDRnsGhcsEsYgZcs0U+M5Xv3f4wkQvqdEnseB7USDoYpgIKbed+/PJKt3090og0r6xeCRQhzamPt1YU9Z4gHL0CXsiOnrW/jKt92HwTqTgzPUIF6haeEseOnrxioe1+nZ6RelezkU5Ck9mFXQRjtDspFi36zQ==
Received: from SA1P222CA0125.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::19)
 by SJ2PR12MB8011.namprd12.prod.outlook.com (2603:10b6:a03:4c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 07:18:22 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::34) by SA1P222CA0125.outlook.office365.com
 (2603:10b6:806:3c5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Thu, 15 Aug 2024 07:18:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 07:18:21 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 00:18:10 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 00:18:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 15 Aug
 2024 00:18:07 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 1/4] net/mlx5e: SHAMPO, Fix page leak
Date: Thu, 15 Aug 2024 10:16:08 +0300
Message-ID: <20240815071611.2211873-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240815071611.2211873-1-tariqt@nvidia.com>
References: <20240815071611.2211873-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|SJ2PR12MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 2432da12-e688-4ca1-2be0-08dcbcfa7199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NUaKqURTEFR00YaPJzW1UtgGBdYT0w/xbrNhBsXdb8ldVFV6O7EQLattXxJk?=
 =?us-ascii?Q?C+RvtpMlyDnMvbrSdA4lLMNPoy2mfjZrOsYnlqCZ6SIqfZkLFMUIb014oSOg?=
 =?us-ascii?Q?8gpf+PV61Jkm9Ext3B8Oi4ITLEMYt7Bw1WUkUaEm9KBg4foHt5YEda4Cz3np?=
 =?us-ascii?Q?R0BxI9azSOfgKWTydmQG0d3s7myvNkQeyxAFb6ziw847qkZTBai4yc+VDaaY?=
 =?us-ascii?Q?A/ONDXk44eWWbMO+2Nvv6i1i2O87+om1R0rf6tamR4qOxfsEOjKKvH8YqGXx?=
 =?us-ascii?Q?BC+cLPL+0Fyov51e5IOOs+PVrHf95PLrWQQXOXQhntppnbT90z6ME+H1iUI8?=
 =?us-ascii?Q?uzuPh9jrArstdyYwLDHITgXuEG62heUlvhOJIUaAmFe8IXmezq8ZC3uS9/xX?=
 =?us-ascii?Q?YJ8tQEjAlyzUFP1VEEfU48xBqWOq92omu9/sCSzD/+O6EDN/t8DnP1RyE8WH?=
 =?us-ascii?Q?XeaquElSrAkNbqJDHDJDH5zTxvEbnAqyWrxNEpZi4kXGTyY3blGqL5mtTLhu?=
 =?us-ascii?Q?8yHFJ49uLQYDxysqM7f0jfUzg94k+UK+v0IsBHjZNb67K9Q32SVcJB9jeoN8?=
 =?us-ascii?Q?jx7x7JQ0dKD51zhjTUHZo+Bk9SFSTCZ7sIQw5XDGFAMyBY+oz+ndlhtW5LkT?=
 =?us-ascii?Q?VkerTNt6MtrOEHS2g+Ly+iaNADmMmw0km5J5YhUFmMVf4HpX+iienlR/eFx2?=
 =?us-ascii?Q?eFuHRrpVgg85AW52dOFJpvpmFygQUi85+pPZZEq90hVLQq9ByrDUexq1mUYc?=
 =?us-ascii?Q?Raj6rFU3F9zfDY/wuImPZwi2dT4gxsYUnZ1jHcdPCgKfGQvduQyfkAAnVBdY?=
 =?us-ascii?Q?LTIhHsLN74RfHObWyS6pIDg9wbyRZ6wWz2WlCDtn+5dlzRnsV9m4CEigAJh4?=
 =?us-ascii?Q?wcHjAzCNpf8/GTdSuGpumBOV9+ig9X9PmzEaHiOHu6usm8izuqLfaqQX+DTR?=
 =?us-ascii?Q?nWmn/23VLWUAxRgYhnLY4EjgW1BypVSR4kEcJ7MyP9I7H7P6Jh4bm3bgG/Qn?=
 =?us-ascii?Q?TuJ/5aOpjp7+grLzkjDItOqzcR1oAUc0TYkIl35kCmWxw0hSQDKvNC/63COC?=
 =?us-ascii?Q?Yzfpo15aF0NPlT3Snu5jHxItKMoJJuGphCnac5oiB4/egMGDCyg9EdKfc93w?=
 =?us-ascii?Q?EJrUVQwzmwDzX9GL+cMzcss49W1yRVCeK/nUN32sXxLFPrLCINoqgWXCFqHG?=
 =?us-ascii?Q?CkGXBPUM12GPbPVSj6SucmbuSbEcIow4aGCjUWMjHw8aHk7bWeemXI8qB02u?=
 =?us-ascii?Q?m8Zh9+vPoHylm8wFH585gT4y8PoRZLvd+y0HydkJx6o2gXU3W1Lm1nN5XUYl?=
 =?us-ascii?Q?ts+JaDguds/0gEIxQdVvqMINVrnWZKKYJciTP6WTeVCHAuHXhiOBrXV2ddAI?=
 =?us-ascii?Q?VsUyUyi4hbYJtJrKDMhr4a/NecTo1L1JH9fwEWTWcPaqkmbH71Yjh0f+TCRR?=
 =?us-ascii?Q?VPVlxEIXV/XEJ4PDo9/QL58nswTUYdmv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 07:18:21.2071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2432da12-e688-4ca1-2be0-08dcbcfa7199
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8011

From: Dragos Tatulea <dtatulea@nvidia.com>

When SHAMPO is used, a receive queue currently almost always leaks one
page on shutdown.

A page has MLX5E_SHAMPO_WQ_HEADER_PER_PAGE (8) headers. These headers
are tracked in the SHAMPO bitmap. Each page is released when the last
header index in the group is processed. During header allocation, there
can be leftovers from a page that will be used in a subsequent
allocation. This is normally fine, except for the following  scenario
(simplified a bit):

1) Allocate N new page fragments, showing only the relevant last 4
   fragments:

    0: new page
    1: new page
    2: new page
    3: new page
    4: page from previous allocation
    5: page from previous allocation
    6: page from previous allocation
    7: page from previous allocation

2) NAPI processes header indices 4-7 because they are the oldest
   allocated. Bit 7 will be set to 0.

3) Receive queue shutdown occurs. All the remaining bits are being
   iterated on to release the pages. But the page assigned to header
   indices 0-3 will not be freed due to what happened in step 2.

This patch fixes the issue by making sure that on allocation, header
fragments are always allocated in groups of
MLX5E_SHAMPO_WQ_HEADER_PER_PAGE so that there is never a partial page
left over between allocations.

A more appropriate fix would be a refactoring of
mlx5e_alloc_rx_hd_mpwqe() and mlx5e_build_shampo_hd_umr(). But this
refactoring is too big for net. It will be targeted for net-next.

Fixes: e839ac9a89cb ("net/mlx5e: SHAMPO, Simplify header page release in teardown")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 225da8d691fc..23aa555ca0ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -735,6 +735,7 @@ static int mlx5e_alloc_rx_hd_mpwqe(struct mlx5e_rq *rq)
 	ksm_entries = bitmap_find_window(shampo->bitmap,
 					 shampo->hd_per_wqe,
 					 shampo->hd_per_wq, shampo->pi);
+	ksm_entries = ALIGN_DOWN(ksm_entries, MLX5E_SHAMPO_WQ_HEADER_PER_PAGE);
 	if (!ksm_entries)
 		return 0;
 
-- 
2.44.0


