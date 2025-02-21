Return-Path: <netdev+bounces-168456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECC6A3F109
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4083B2C10
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BC42045A5;
	Fri, 21 Feb 2025 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rm/byNon"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9399E1FF1C3
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131662; cv=fail; b=sJHQJn4PpKUG35cr2STVKGFiz6k6jB9k0NLPvFC2FP7JSOtrnPv5PQcJBkwOTYqYHgWCjJ4eS35epLvF6HSpa9vPDncmlhxvvKSL7HSSDLsvz1O7Kddnym8aiETMs6dullitYNHNbURdfHYH2BIoIb2UNm8EMkciMv3zgTEFBC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131662; c=relaxed/simple;
	bh=y+vVLrwni13gbeu2srcwYi4j7p5uXB8f0sv3E8OXyb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GsQ1YfobwfV5pg/jmIqzpMtQlK+5cNVWDhUerXqyc+Tr0Ra/eF0Gt77tPP5e7Rwc6wMa6AZby15Do1qKonPaw8bp5B/6m4xLgNa13AbH1bAVKvIR7/v4r2Ko3X/g/0sAHuK8rAMUFg8ZZFIj7K2nCe61+BjTwg8I3XzZhNB/5sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rm/byNon; arc=fail smtp.client-ip=40.107.100.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEp275J7x4zhkCA4wJCdteNzg7pX7RTnNvsG9cOPAn45g/teGsaXVeByLdPYLG1+v50gKdASOu8z/Y0c0XjSydJbSjd6CUYpf+4oFjl3EcKafW0EYFXK0VU7chxNK8ABPFo//RrcMF50v5oMw5bV3Q0bIO/ACAmfnz6N90CLm4VehZi/0py1iQY7vO9ZvNxFTw6VnF8cQMdoENb40mvAsabNcQWjlkvoZXetEw3eGyDfudZdlBizkJTVuGnnHnz4ENF40NSmfTGl8xjxjvUykpBPsgm2/zxVeGLVAZtyd0i7cezCYIhXCDHXBvZnTnScRQlpTVcmXLuk7jREsN3xOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVkUAoPpVvB81hhVHOr7Iq215l4LBqK/8r0eErLLVAg=;
 b=p/aCXhO6R/KeYZLG+MWqZ3iERX3k0vP2AcCALduVQcpc+c+VN/TuNPuVt0JMLGsvHwrfm4HFXBm2k3CDMkH3jgk8yfNVTQlyz3VdJZtkUfdbrJpG43BsNA0YYJGoT03q3weOnM5SYvdNcHc6ycks9KXSkye83qij3t25TISXszjSK2XAhiyHIsCqX3yjkW+ujjABuro8N88MHBEiYYWbSUKC56ytXDn3PSD+kV946MpBnc5inMNnI3x2WqhdK+pS1ylkpUPt4P/wyOVu5j7xWwc6bEk6CpD7K5DccL/9jX8hZb5RqsgMGWYXzTmQ9fdPfMwc5f7kIkVUv85BDRhOJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVkUAoPpVvB81hhVHOr7Iq215l4LBqK/8r0eErLLVAg=;
 b=rm/byNonQJ4DRXGzDgpODMpaRHX8M1PpRXmD9x2ULsHHa265zq1n9/81x5mjoefq/qhBoiLBToPJqM4StvWtYn/VaE63fcd80yZD4xTtsoRODJ4iK3dWwjBrJH+fg4FwgA5CwaV9Nf/JtERnY3hi16sRcmqLbQWx+PpNjTlm+BkJOw7uzwdidhnpC2DF2tLHfHmFyP7JA3Dv9S+FNFM/aBH9NM5NBU7H320XRibxnenImNl8/qCfENJ0phZpLaTqUMbDbu6vf/4UbHecHw5nJCDNk/RJeU6kalHl2tKkl0AypJtOqEhDpMjrpwf613it6uZgnw+9suprscDWbKwZxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 09:54:17 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
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
	mgurtovoy@nvidia.com
Subject: [PATCH v26 18/20] net/mlx5e: NVMEoTCP, async ddp invalidation
Date: Fri, 21 Feb 2025 09:52:23 +0000
Message-Id: <20250221095225.2159-19-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095225.2159-1-aaptel@nvidia.com>
References: <20250221095225.2159-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0577.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::21) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: d93eaf9b-6a74-4a1a-ae24-08dd525db45e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dgpVQGjCdUFMSsxJMM4mM+QP8NhBnUQte/r7Ky7YKCgG2zYVROF+tFJN4Jpl?=
 =?us-ascii?Q?Tw3iquR9brt1keoYnNMPZEa4E/RxxIroOZTkwNXTuYEb7WoOtvKS+fSuTtNq?=
 =?us-ascii?Q?4ackU3r/tyfIVbfaRZUKLA6O3/dcVhEYoQYRWp4leiABejt0yy/xP8OGP4LR?=
 =?us-ascii?Q?CwcI6UKIfJ1NZzfeFByMpSG1FIk+YaqEsgGs2SCQ6Z8DGLinKmcU0lOkByu2?=
 =?us-ascii?Q?8YOCvvyLJK5E/nXjU3NE57YTLGfSd2BYvyph2ou2uCL82tyoQmbNJCzsezA1?=
 =?us-ascii?Q?Jl0B7ZJ1uICnhj8Z6Q7lgR977bjEZwu2XW1URjC8pV7qkTK1/5/b8L4IjRFs?=
 =?us-ascii?Q?1xdgiexkeytcQmMkv+0UKcHUfGqaHqT2+uUGil7IYinO/sEmLNaWf9vUa/vH?=
 =?us-ascii?Q?UukAoMxSIqDkRueOIFuiWMnznr9JFr9oVwD69DvLell/JkVI7bSM96ITep6d?=
 =?us-ascii?Q?ClzQkD17qIpO/xZ3fmnOeUXHv/B3rPT9mBBzOZPvtN8zydjGPqeY2Cvjj3Nd?=
 =?us-ascii?Q?jn6YriaAGq/cewro3bFHq/30d21CfSBhb9AIrm6N+xGby0mLAzjdqVoPQcNQ?=
 =?us-ascii?Q?S6l79vR/hmRCMOXiBXZZPpBnfuEaCoMkU/g5CiqiBu59OUX7Bjm4uGqxUdzA?=
 =?us-ascii?Q?WhgXGOthOPU8VHhLvGAZch/ftT4l49N/HC3KE1CE1kJEP+0cbaSjmKr+SQvA?=
 =?us-ascii?Q?jLC0JUmXRfGi9Whv+T0pCPWEIOgueXQ7uPWtI0LFMfo+xdTn5QkyOkEZooMK?=
 =?us-ascii?Q?IyM6A4vemXFinw8Jz3TcNKesgCHHugXDQpB3HtNe1NSxFQdQVFp3DTEF4Qyl?=
 =?us-ascii?Q?F+T5xaQA7YxZqAMGs3hvsRfEtKXYSV9uleMgyoB9+an9ITbd+3sLUIlb2xdn?=
 =?us-ascii?Q?YkLO7YK00hx8lrK0pFI+e/NzmDmA4XUS5+GppNjJZhui+8cvuoTnEF/o+jBG?=
 =?us-ascii?Q?VPuKVyZfeIzYPli/U0nCIWFocIVMnyolA3K21qe8BovELFMpMmb5KzBVgORR?=
 =?us-ascii?Q?Y8iokQvuWTMtnj2TkY5zzQ9vTcYWw0OsCrlxbWBviJ+IOhQz0jWk8GBv+B3Q?=
 =?us-ascii?Q?w5O5azflKADchuCBuaVZ1OaqQCFoZtZBJGgXUE4ZyztvpgxKvwkUANCkHCp2?=
 =?us-ascii?Q?I77g0uiWKBz7zWKnbafv+WpPa6pCfbk/OQWSygFrcqLbB/JzqF0tWCeFdOKN?=
 =?us-ascii?Q?2M/rlCJ6e9YQ0zmOcNZAb95ll00UZsKs5hsxi6BRuN2bMA67hUp23NVn+5s5?=
 =?us-ascii?Q?otOSalI6hrx5pMzWLwOdHmtz4yTvCHOh7GTmxcOsKdjUuBczlTUilxNAT70/?=
 =?us-ascii?Q?mcEyT+a4GAz2AAARg6t3t/tcJtD4EYYOJm1nZJzn5o/DRlgj0SRPJ4Z39Tlr?=
 =?us-ascii?Q?mOLDekLJxEKvDP0Pvocyv9vW9Ak7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LplfG8ZrLVQycRVPuWloxGdeU9jLwOWOsU/oh2Kv9Dx3d5NhD+ZZa0TxyLp6?=
 =?us-ascii?Q?CtCqndTWsUBabjtcyLdFgvOA2r9DglnVJboIC/ud9eC76qqQDXLR4bKfQ7mP?=
 =?us-ascii?Q?Ry2Nh0HaXiVlei0H8+nKqOqzSVrB9Cq25YQ6+i8eRVEsEnW6+IG67He1GnUf?=
 =?us-ascii?Q?X76KuxLRrXPbAhBIbY7aMYeyqTSz4EjxR+5sjjB6kcM/06iUJvrRkg9So6Jm?=
 =?us-ascii?Q?IwNmaAhdoQtSzxrBjujhqdYNJE7t3OS0IwbSP10yA1PzRbyfEq7gxFqi6tut?=
 =?us-ascii?Q?NLqGDI0fWkz6D5xeDE/t6evT9wR2obZONgHq/S/XOC3cuGBciWds0n6tgMUn?=
 =?us-ascii?Q?VqlN8JVP1RdY92VmzqG2S7uFsZjBa5Sf3oDe5WA08GWLozUceXl87Dbv2SFU?=
 =?us-ascii?Q?MlG2cYPhRbLER25/LZFxHovrI5/MnbcXAFzIE19HoTOq08F8mT9rt4ivfvC8?=
 =?us-ascii?Q?QMWB+pNKSkxo241xo5t7nG6RRzm4xkLdn+m/EF0EdMPbo+ZTlG8vKl358Xcw?=
 =?us-ascii?Q?W09khVvxsjsPdCdTJ8pHpK9s9qiPGcAfGdmDTNluc4i47zf3WETD0jHwXXue?=
 =?us-ascii?Q?Q4sq/XsV9LfazWKvd99zXkOfMFWkgVcT68yUIb/0zRvlFjLtZyrR7YbJMFZA?=
 =?us-ascii?Q?5vaeXW3yWiiIuOq+0pALT5bDSXR0U3gqiX2cobjJBkl5ONlAVyt1Jj9OMzlr?=
 =?us-ascii?Q?TeiHoc0qAzP0NxvT0xub0u1QFElD/B+Np5cFqQUpyoGpRAg70nDOFXblKWVj?=
 =?us-ascii?Q?IpwIiVDw7AUWADToT16x90M57CVzqs5TrAKaGhE3ivBAyv6g48g62Ja0+LU+?=
 =?us-ascii?Q?yiT60STV2hIOnqT7k0DNPgCD0xR/LIWWY5y884GlB2aB3jB0ip5ZYVZP08D+?=
 =?us-ascii?Q?SdlFHRCUtEsA4+RPw5GWotO4vaSjb9yRGmDS3Ni/ChVYM+5nDMVKj56bYMeY?=
 =?us-ascii?Q?XXOyILlAjRHiSpsiucLc3XWiBFQzsWei3gwwl2LYfsubtKAaTvP6+km+O4+6?=
 =?us-ascii?Q?JJj5NrkgUB8yVc178gC59Ie7KV0Av8x1PGz77kN1fxJDSolkYqBVbUnlAAaM?=
 =?us-ascii?Q?VxMJ4BZPJtSF4T2Wp182/wlgM+U3izMTPFR7905OES76w5e96oTDGu5l6oxy?=
 =?us-ascii?Q?z5+4aqhLiI+pEvttIgUY9iRFhglYQeFovdoeQH8uiYQV18uFFeMz9T72cs5U?=
 =?us-ascii?Q?Rw9WAmRUH15wSm3p5dt8tgYkK8zGrYVEWdLq2iXR6k/C6NfwP50E6TX4Vyc5?=
 =?us-ascii?Q?dWqVK56JRyMNZ145PnnoV1Nl4n6EKeTJp2Y35CpsTe+dbt94orT9Z6QTWNL9?=
 =?us-ascii?Q?6JdcNElSwk62ImTau2Oqjky5nAQHsIyQMj1cyVUJtbrc7W5AeVpR+dHbNH9P?=
 =?us-ascii?Q?Uwe4OsZ72pRKNgD3+N/bF641kvbx9v/Lo8qENe2n5smetxybGPCuonEUcmEq?=
 =?us-ascii?Q?PDvNh3IrQ0jfxSoly+OwHCcZS5fYUX3hBNBymbvYq8+PkWQqUt2I+Zp9mhEq?=
 =?us-ascii?Q?D7CYr4oPIWA1gITVHf7jqEM2doduSWlsdBDWqkkPj+7fjV5M9M09pAtZIrpl?=
 =?us-ascii?Q?p2Udzt0u+GS68rSBIjf/orbk3kn+tndKwlHy9Z/+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93eaf9b-6a74-4a1a-ae24-08dd525db45e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 09:54:16.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STRJms3569nkua2o308p1//ye4u0kyi9aCMJqyoIDUdj4TNj6NTFJH2iNQMf37VHykf5cJhWB9gokGG4qs601A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127

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


