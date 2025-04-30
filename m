Return-Path: <netdev+bounces-186974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14FEAA461F
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B0D9A788E
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 08:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E16321C163;
	Wed, 30 Apr 2025 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tI6+6rnN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F2621B180
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003514; cv=fail; b=bJVGxKN2uk3kPEdAhjbqPN25J3U1TI2U1Qn38LzzOmFKMU2zVxKvbipVzLbEHU8tEWAGXX30iSloZjRGhWi6+J/IBXj1avaYmVNMg52GP1KWgUNDqEpljxZK/1NEqOCicxsBL/q+1kiUZ1HVT8Dw+pKuz8NCCQOrJ3fd3s9WGBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003514; c=relaxed/simple;
	bh=WcTo+5U6dmp5Y9nYp0MaW9cNYX/ty11B5IuYl49MZoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dFSYamYbUjQ2PDrIo96zauX5AKet9WaM4182902sRw1QdQtazc28Bc+rlEnU2BLNvfVllkm7SCRbYZJn1hFWDytmWlEIBq122nS4F1FK0Kxz1BK6uOFf2CVSGiWH8/2IllmSFoqXtSu+xGlMG/fLwUJY1vxO4pDDLQX5Ztwcx7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tI6+6rnN; arc=fail smtp.client-ip=40.107.95.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXLMq9bFfe+H02Xw7vT6r9zqU9KxpCsEOFM6JC4OFJGUYSbkMhXi4oL6uNhrKQM1Fv0INLqlu8dPETfgwLdfeP6TGvSgkMNxTRIpkYhopOin32D/Z2qmqAd3PcZOU2prIphSV1gkS8FIK2AGwyKbaIZMFAhu+HeBB3vSRFEYMMVE20Af9LJ/dUTrZtyO/HPq43+/edvGR1ed9ht8ziStSXUtd1bs7FJIKHpIFCw4Ce98sJsz3KbDh24b5UKoabGQM9rJXjYf3TWOt5g4mdpgSgn6B3c73hhw1T1Nv4TSPNGvtz9TgSFrL2rg3/UqjG/eoqd3NO8dcku8GMjifyLNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4w2k/v+fhG1ErLhtYkooeovqE687BxRdvZvQsNLn1zA=;
 b=scZjR0smw5AsWzZDBSmHpD9GqFc0N1AIAA4mBoWWi0WpnElE35FAjtHmqtxY+FmPGtrGKBvzChDp2+jW9RYv1A0OKmCUvSa2rjVd0WVoBBSgCibBUv+UbjxMwPr1ahc+8Zeu47J3e2rTCjmrV1XHdwZK8JtfM8P2k34434T608dXXBbuk7eHAqtE8uSCD8j1ocIbX8EwBvB4Xvv9MJ4dIPRmFbZyDjzY2tYSFb4vZMOl/Lx/vehzbsURRQdFiwHGH0Uh36SHr9Efh3oCuoVlKZt0IDnTEAgFB411aghq92r6FLqZ2VmcxGgoYFcsVxnGa3UM8hJsCMqtkWYsr3tRGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4w2k/v+fhG1ErLhtYkooeovqE687BxRdvZvQsNLn1zA=;
 b=tI6+6rnN9aXnIfKCyJBT/YoY+YNL5M7diOni8zinPS6E6qhcTd4YP3iyeATNqDV8GWGwaKZlK3KkMuo/XbCmt250OVlmDcQJNhJKajU4cm2Crguab2imO9OaJlkkVQWiDraPD0sPWDp8ga7CRCbgLB8Nye8MR17HlUvHg9zebPzL+1uwA52LTZFivaRLuJRD2DHQ43OPcl1DPYE3omDo/ln3x0gC58oZRq332uty3CoCBYOucFqOuQvRWLAxWK6RTm1oJ2C2Iz1ATJGS9LfCwQtC7ORFcoK3bH0q6dpZArc0hQFIB6oN9aRBjbuEjakPNbiikjkk1Uxuv7ZRlgRkCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 08:58:29 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:58:28 +0000
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
Cc: Yoray Zack <yorayz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v28 07/20] nvme-tcp: RX DDGST offload
Date: Wed, 30 Apr 2025 08:57:28 +0000
Message-Id: <20250430085741.5108-8-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430085741.5108-1-aaptel@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f76aaa3-b9e3-40d7-c412-08dd87c52c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HfYsfw1XiJgkjIo6iuboFPDY1Ypy8B0SNUqq4tj18D15fARava438dtOJIKD?=
 =?us-ascii?Q?mJ3vJ+SfGnatidN7TJU/AhpFxD4Mp/FoJjLWJG8fUqoMzlxIF9UdYOaZlTC7?=
 =?us-ascii?Q?eTkiou/CJPBYVs8Wvhf9AGzaxcY/Kj5QgOT5i8GD6CFzE+9UllQJLjFNObwQ?=
 =?us-ascii?Q?8qOmSknqqAkEo4bfhEc9PzM/Q9wOO+xKIMqJ8flM9TbQgnusuKFA0rDZcZ1W?=
 =?us-ascii?Q?vC3mFhhQtGY+mrrrb48NLiG4oEtpClKNG5nDOnsNG/UzM1sIeWqaA2OyOcJH?=
 =?us-ascii?Q?rXMy48Z6Xvb+qyLL4ouGsc7Kqgld25XIX/lU3tY3bLfAllG9U4jfBDbnh9HF?=
 =?us-ascii?Q?t+OYF1SmCaxA8VwhwSDYSr22odDbBWAD2fKK3YuMH6s1hKTwofGAIB6e6Y/o?=
 =?us-ascii?Q?Eeu6gwCgMMM0c3vmeLt7Bz0VIPq7WL2hj7oRv2tm33IuevNWEecQltdmQKAP?=
 =?us-ascii?Q?QMxkLNXh7C4GacqKiBymqrkeKtMaePAfJm4tL4340ackOpGxFPfeQdnU/m2B?=
 =?us-ascii?Q?QvmDqH+xZY+ludeZ5TR6E3SJslFyxsseVJTm+3Yr5TasJf1TcOoQI5I0yu43?=
 =?us-ascii?Q?dcGeF0vlhhzPbY1/JAbVI8rNM+fUjOv/guBbPqvTKgf9ohjbgnnx8Dyje+8X?=
 =?us-ascii?Q?AK6YzL1Ud8fv6vgUaMCl+acONzJHch5PwzX1Yqc766NeHH+pFOhDv7ldZM7s?=
 =?us-ascii?Q?fI2d4VoaEFh7K/YUdwDEk/sUX/gSxcvGnA8KHdC0sJ/4gz7KAonTbyKL5ijx?=
 =?us-ascii?Q?dzFmanURFnFZUfCWnWOXsOsoomojNlorRzhDPIJG4+kTJxQZppBCA4QMejEA?=
 =?us-ascii?Q?Kgt3ILIBbEDwV91m0kPaMnAFga23Yh/6wri7byQbmSSaDOSfHwMan0oGhMs5?=
 =?us-ascii?Q?MTHx/oSeWk8JWkOGsR5HBtHpRKEQqPTQt02ZS7xCp4XunOF/6rYNanMSC3dq?=
 =?us-ascii?Q?DUSqPmX75WvhKezSxjffyhyLqVA9YNLZ92l6aF2rwznNDXZGPJdQmnLXxjh/?=
 =?us-ascii?Q?3AQ0Ir3zOFATpp66NLo/Z7gFXpyD9cwzdc/CEN7eryuTQAhJM1t17AjKzW+h?=
 =?us-ascii?Q?lI28q6syTW16ulyjWYViRntBEmxvGx+wZkVF+GWGYvlUVRJUvyBZg3wtkK2z?=
 =?us-ascii?Q?c5bEpTuzDtObrURc0WZp7rf+aK8AMgLC9c7jdC1Xc3usjMWDlzVbeKclZoba?=
 =?us-ascii?Q?FjQpaTgfCaUJ4dd0+wq3DAkTOnpdYqv2vzIjxFLKt/L5LBLMYwVZIHaHhBQr?=
 =?us-ascii?Q?r7SInHtF8EjklnJ1PUQ6PFXXk9isYheh2+RCgmWnc8P4wmVquQ92CXbYlDO/?=
 =?us-ascii?Q?51OPRvCxV+VDi5IzGKtfUEov2WGAiJIFNZDMEW8cUNIaOesAFwzY+iThdkyC?=
 =?us-ascii?Q?L9p5JFTdvCs3Q0B1x1SMquAEkiBUuOb5aUky4aFVY6wiPiE+1MidIWvELDIZ?=
 =?us-ascii?Q?YFke/HTvrtc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9dHVdnFjWjlFR2fScsN56uEDGyeh6u/ijYwTT14/pZ7TnkjOMLzH8ehitAl7?=
 =?us-ascii?Q?BWVg7AropApUqBDEcW/0Qxh7vhEpKAO0qWGrQgueSiUuAbiGVjZj5Z75Ssa4?=
 =?us-ascii?Q?gVSctbRoRpF9O5p5EfspgD3eTGzDtx3Ma+m/qe61ZCYBLz6I4H2iWZA7Aswo?=
 =?us-ascii?Q?gXNCtGGMGn+N+LqLK6uXuOUcLsMb0GH3WEmildmZdb+yoGY9q5HpVk93NQ1A?=
 =?us-ascii?Q?m94TzfWVFrz0R/n0Do44R/5Nixjh1596YC5WxhoqPttJAHS+wv/unifmE2Ck?=
 =?us-ascii?Q?lBc+019vVsUKZqT37KaoF6TxLyWdD7bSoKy5UL1ScHgTwp21iyei89f7p/1a?=
 =?us-ascii?Q?8M8cgnxdIiDKcqY8W84dhV58A+LLNHmH5Bu958Agpviiy47079gu23WQxxZz?=
 =?us-ascii?Q?pMsELxToKR9coVvxDC9UNYQxxPZ//nLdDOgfzPNvzAudktqdEdxlQ0r4IGMb?=
 =?us-ascii?Q?X3e+fZC40vVwUbmh2EIXe6615xmVTf4WS4LbemVaCWIr2QO7IMtW5xVW1sWX?=
 =?us-ascii?Q?3LxhzEQPlJw7W+OWZkffveMvX4pLDn82B8jOW9Hu6FGZtXt8m8GJIibFCSnT?=
 =?us-ascii?Q?lSrQSKAhYZEcM4DElgmDEYBsUHr2XjWk3iWrW/UCgLbwH5WdcIMhqqrfRU1I?=
 =?us-ascii?Q?Hip46lV/tP4iAgd63bSl2KJITLno2xlOmHMBUTLP18kS737mGM26qXJi6K6m?=
 =?us-ascii?Q?r3eVK4f6fEfCpQRoQNiQiBUdfHCfzQQaURvxKNaissEbzFK0Z+M6UoESzQev?=
 =?us-ascii?Q?BMkow4XKOM+Xor4YAZhl1IgEZvXF+UbAYe8MDYjT2YaYzG7GNUU46YZwcJBO?=
 =?us-ascii?Q?DJrEJxFu4/Kz+PcFl42YRjcE+UmzC3gNgFcP4ECmXKMuWUj/wFht15adv5sP?=
 =?us-ascii?Q?23jMxmq089AmH1i+5+LqwrfMyQnp9HTMVcPzEPBk07IeH1odEn1idtF1Rs9R?=
 =?us-ascii?Q?wbdvpOx2GiAlrGg2voM7ILdKscVXBvJL2p0+DOdL+dC8CydxfzlYT5kJJjBQ?=
 =?us-ascii?Q?2fMEQifOo2WruvGhtspDp4i5S7mCqVXDhAwjodAx7HuZXJOvDlGQQyy8ZdHb?=
 =?us-ascii?Q?2CWCt9JkK1vD+38PtWhcyAoK2Qvc8d2tXGo/15laFy22dnD3slX2tQ1LuxKl?=
 =?us-ascii?Q?3mmkWJbCdtXP5VTmmjjMnbHi4V2AflT6ru047EKRhY3vu1KqKVGA6uoGOTjJ?=
 =?us-ascii?Q?TqABbXxqatKlGA31808ro8YPTIHTXYSLRXgAvQrOieFC9tuIsB4DjF7YMhz/?=
 =?us-ascii?Q?NvtOXlioIiy1XZ8kbZR7ZhoI3x/BL90a9qP3SGEL8VGw0I41CTHBli8SHdvM?=
 =?us-ascii?Q?cXl3WE5CNE46za+RGx4/J/iImMnOnghY39pl266Qr7W9x1pdU+6N7NAQbFTl?=
 =?us-ascii?Q?QZAJabm4JUn6dTkISA5K3+NvkBQawcUozSU28GV43t0txq4T5Zw9Kp0LNJ9y?=
 =?us-ascii?Q?IcqxjWl9P0XGngPnAHXWyH37ygaHAkvN5+sLHWiIwdKj7R6f7bfOndak7H8W?=
 =?us-ascii?Q?cXUWE75Dsj6iD3EqPCsFDCcvodHsbXGCXh/kwRsSCCJh4VRvS0+rLl8kr21D?=
 =?us-ascii?Q?YCHmRCuu5tq+tf3C2YECCIDoomQFzgeG5cq05XQs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f76aaa3-b9e3-40d7-c412-08dd87c52c86
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:58:28.3182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2Lfsgn1IZ6hjl9AS7N1FqHK9pVLXV2fzSP/Ud4okaKhnwsD4Apt+9xeD+6JdYet7ynuWYgcvozL1EEuA6EXvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208

From: Yoray Zack <yorayz@nvidia.com>

Enable rx side of DDGST offload when supported.

At the end of the capsule, check if all the skb bits are on, and if not
recalculate the DDGST in SW and check it.

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 96 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 91 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 498b524b8eef..81d97fe5b2c8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -152,6 +152,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
 	NVME_TCP_Q_OFF_DDP	= 4,
+	NVME_TCP_Q_OFF_DDGST_RX = 5,
 };
 
 enum nvme_tcp_recv_state {
@@ -189,6 +190,7 @@ struct nvme_tcp_queue {
 	 *   is pending (ULP_DDP_RESYNC_PENDING).
 	 */
 	atomic64_t		resync_tcp_seq;
+	bool			ddp_ddgst_valid;
 #endif
 
 	/* send state */
@@ -433,6 +435,46 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
 	return NULL;
 }
 
+static bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
+{
+	return queue->ddp_ddgst_valid;
+}
+
+static void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
+				      struct sk_buff *skb)
+{
+	if (queue->ddp_ddgst_valid)
+		queue->ddp_ddgst_valid = skb_is_ulp_crc(skb);
+}
+
+static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
+				      struct request *rq,
+				      __le32 *ddgst)
+{
+	struct nvme_tcp_request *req;
+
+	req = blk_mq_rq_to_pdu(rq);
+	if (!req->offloaded) {
+		/* if we have DDGST_RX offload but DDP was skipped
+		 * because it's under the min IO threshold then the
+		 * request won't have an SGL, so we need to make it
+		 * here
+		 */
+		if (nvme_tcp_ddp_alloc_sgl(req, rq))
+			return;
+	}
+
+	ahash_request_set_crypt(hash, req->ddp.sg_table.sgl, (u8 *)ddgst,
+				req->data_len);
+	crypto_ahash_digest(hash);
+	if (!req->offloaded) {
+		/* without DDP, ddp_teardown() won't be called, so
+		 * free the table here
+		 */
+		sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
+	}
+}
+
 static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
 static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
 static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
@@ -521,6 +563,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 		return ret;
 
 	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	if (queue->data_digest &&
+	    ulp_ddp_is_cap_active(queue->ctrl->ddp_netdev,
+				  ULP_DDP_CAP_NVME_TCP_DDGST_RX))
+		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 
 	return 0;
 }
@@ -528,6 +574,7 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
 static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
 {
 	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
 	ulp_ddp_sk_del(queue->ctrl->ddp_netdev,
 		       &queue->ctrl->netdev_ddp_tracker,
 		       queue->sock->sk);
@@ -638,6 +685,20 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
 				     struct sk_buff *skb, unsigned int offset)
 {}
 
+static bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
+{
+	return false;
+}
+
+static void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
+				      struct sk_buff *skb)
+{}
+
+static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
+				      struct request *rq,
+				      __le32 *ddgst)
+{}
+
 #endif
 
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
@@ -904,6 +965,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->pdu_offset = 0;
 	queue->data_remaining = -1;
 	queue->ddgst_remaining = 0;
+#ifdef CONFIG_ULP_DDP
+	queue->ddp_ddgst_valid = true;
+#endif
 }
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
@@ -1227,6 +1291,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
+
 	while (true) {
 		int recv_len, ret;
 
@@ -1255,7 +1322,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		recv_len = min_t(size_t, recv_len,
 				iov_iter_count(&req->iter));
 
-		if (queue->data_digest)
+		if (queue->data_digest &&
+		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
 			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
 				&req->iter, recv_len, queue->rcv_hash);
 		else
@@ -1297,8 +1365,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	char *ddgst = (char *)&queue->recv_ddgst;
 	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
 	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
+	struct request *rq;
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
+		nvme_tcp_ddp_ddgst_update(queue, skb);
 	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
 	if (unlikely(ret))
 		return ret;
@@ -1309,9 +1380,25 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	if (queue->ddgst_remaining)
 		return 0;
 
+	rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
+			    pdu->command_id);
+
+	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags)) {
+		/*
+		 * If HW successfully offloaded the digest
+		 * verification, we can skip it
+		 */
+		if (nvme_tcp_ddp_ddgst_ok(queue))
+			goto ddgst_valid;
+		/*
+		 * Otherwise we have to recalculate and verify the
+		 * digest with the software-fallback
+		 */
+		nvme_tcp_ddp_ddgst_recalc(queue->rcv_hash, rq,
+					  &queue->exp_ddgst);
+	}
+
 	if (queue->recv_ddgst != queue->exp_ddgst) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		req->status = cpu_to_le16(NVME_SC_DATA_XFER_ERROR);
@@ -1322,9 +1409,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 			le32_to_cpu(queue->exp_ddgst));
 	}
 
+ddgst_valid:
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
-- 
2.34.1


