Return-Path: <netdev+bounces-186985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B10AA4630
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 11:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F8E3AEF27
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 09:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C032222C3;
	Wed, 30 Apr 2025 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W1SOOuYq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5A621C173
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003564; cv=fail; b=IDSQGH9/LDOwEoTfRxuVnWuQ2yhcx/QQomdZCSkIovFndb5RvfH3vk8fxHc/35MWYY7O8ANsCfiEvc61yrqdKXnbdV6DJOLEoMyyWBJPVxwYiw1hxZc57DywGEtImsTCQmrJ0PZWBfFSlPhb5w6Ctnu20B/JxuOyjwli+2ifJsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003564; c=relaxed/simple;
	bh=7jkSUporiNqMOqA2Fm+J+CNDpaeplYwD8a3qWJPLkKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bJgW6VmyuGU0zmtqgHfcJni7Xvx1igqZ5sfshqfuhMUkpmE5zxuG7wtjDtaH5dS5qbzHzyWod1ZHmihiOL9kSnKdouMWS2XUKm9M+y61Rxm2LDa0U15QWTha2UEifBXDYwzwvt5nWJ8zF2nKzva+W9cYQ4D76/3MoHXRwmUYkSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W1SOOuYq; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osa2U6dAJhMHHSALclMTAHe3wDSmc71/Do3YnuxWiNyIftrdX9fmlZjup2aHddJGLZAyIAu1I4t1tUWf/PyZJJKI9Vy96+PpOGXnaYWwIPpf+7UWGw2+8KflC9WuaumeV1k1vhwVDikLcbWB8hwtsJyY4SH/OvG3gKFOTZjz0t3FL7S6yaB8XY0BRGVG/73ibpMuua+embP68PYGH2NzChAP+mPl3My9gybxcsMhQr4EYElBXDLCD4d/mNjeGZU+rOzOA7WzzvHYdKfjcVQm6GVPZUl8DgGixIOQTg5JzazcXKgoU8L25F2IjmA1JHpQcMzISCOV2mv6Rbtgyo15RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhwLBw/HhBCWgNoFvq+FUvGUnlZXYORgipDVj3qZNr8=;
 b=W45mPl590uNJRipxtMZzP0p6MtIZO6muRhPlnJ4YYAVWg6yHtZxEPG+zQpvC4mb/C+hOf+AE60nkUoF6fXLvbtK4LFpB+gJwuNXyBgkl4SxFBW3QVWGKS41RRAIc0hGc7KwlJkBWv3EJ0Bax1XzwV32x1Qlm2tpZo2dfyw5wfmLInPJG7pWwtXZWZhnSv977PA6u57zSbfDD9TJfecuRyQwowZHII4QGp3B1Ggh//KJYA/GewVblYFxSKROYgQ7kXdVTnR5bRE6/qqY8jkp2g8t33mTEkNwjoqTCF0Bi0+le9G4xfN0A3St6bMkmrhJcHt6i7HCHj7TPAgF9yRL7hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhwLBw/HhBCWgNoFvq+FUvGUnlZXYORgipDVj3qZNr8=;
 b=W1SOOuYqBaKYnI6tuw1L56dR+GPyDtqBRuij1jHvBR5VrljEDOnXwynwhlrOCAemVgjf92MQDnAa7yN8/mGPx7DgPtFQ+dUh1E2saWk7CkAcKD7iCqeJWdMZlU+4560SrjfgUgnbopjFSY/6Gm9TOlkSGDT5erMCZkbetAPWEAeyY/h2EgOdAJ1g+hGnkebbeuxLaODjKrDTb7hsPPNUnrMyQRlV17RxMxwE4UHCcqaM67vNbMvofk3kkfYgay500CublcZUPrsMrlvcosKDRh9d0BgXjF8nDiHiZYUrd4Y7Ql4fA3MD2Vf8AkdvGLSIdG6nWSkgX2TEuUcIXjzmKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA1PR12MB7319.namprd12.prod.outlook.com (2603:10b6:806:2b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 30 Apr
 2025 08:59:19 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 08:59:19 +0000
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
Subject: [PATCH v28 18/20] net/mlx5e: NVMEoTCP, async ddp invalidation
Date: Wed, 30 Apr 2025 08:57:39 +0000
Message-Id: <20250430085741.5108-19-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430085741.5108-1-aaptel@nvidia.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::17) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA1PR12MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 595c11bf-83ec-4cd1-1c6b-08dd87c54aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?neAzpB8sG93VUxlZDHeRTG7bwXsKrXokuC18LNTUxjCgqPcvH9+zUHTUaY6d?=
 =?us-ascii?Q?K6+lgdmYEsSCUgRfHwCcGjGhYWRmI8xP1M4DtW6bSJsvDc+xivpGqadRGpH0?=
 =?us-ascii?Q?9lAdfo4W0L18Kc/xSiz8lrtwoswl7wpD4fWkQwpROIT/CAdMgrQq40c6+4Sa?=
 =?us-ascii?Q?CnGO9te6oYL4oh8v0zUE+9X8q3gU21eB1DKpY9mvbbvuuoO+MaWpiIaixvlG?=
 =?us-ascii?Q?eW3HR1JjW2vjmKDJvmpDA9zBf1ArzrPtWyv1eN7Yci/9jZjt7/T4EnFwqMBS?=
 =?us-ascii?Q?6VlWhIlQ3VqQdrrVjydZVlMc00Ld2V0/L1DHJeY1LWSRp6naKdb44mhnHZxu?=
 =?us-ascii?Q?RMFKgADZ3Ig5zA2gprVt5KD5xk/I2/7BzV6trJjlvYTryMfy1O+EJ3yTqiid?=
 =?us-ascii?Q?MslD9Q6wgiGyz/MTBX5GQHLP/7T6olg0rTSAk0a02Uu9O0aSwF4BjiRhG+1S?=
 =?us-ascii?Q?TvcrEizBbiaE8VeIKfGoy0QZRiQn5KuMZU06Lgq0Uu/B6V+BfxHQkXCO1nPE?=
 =?us-ascii?Q?g/H8Cno6c5Qa9+TuDiKOm6XgouZZr4cIayXCTMHtFU1YOceUWa/CFRgmydAv?=
 =?us-ascii?Q?y4tpQHUwo7YihwPrn05NuscQ6HRwPPHOOJR7mbmgRLsgB4qaP8eC1OVqUegM?=
 =?us-ascii?Q?jc/lR7SRc77+3N4K1+6/ix/x6VLBQvGcNmjpZflsRrptDV1o2YGkcuJ9NFiz?=
 =?us-ascii?Q?Lw0u0ccu/slSS+VjdcC4PPnA45qcN2OtSGMOYUHzOUC+5yZILx35HpwSZzzt?=
 =?us-ascii?Q?rBh4BGQO704fnRh+c7MJMVj9ye6ai3Bmz02CpwGu/xDNoxLUfIMwObHLh/wp?=
 =?us-ascii?Q?Hc1TRC4TWF6N0GPZ8HulvgBiYx6Xe3ej7R5VD1WbjCVSdv6Kd++wsEmQrkca?=
 =?us-ascii?Q?BO3vlXARXgqNBThDgVi1Qmh5psBsmg04grQipRkTHPrJJJp8tOA2uxd161eY?=
 =?us-ascii?Q?5Xu36uOCOeJr1GwdhoGLLH2dZVzO6ovUT6wXmt93m7q/UbFCKDZi1r7ly7Tt?=
 =?us-ascii?Q?oKxDj6adpLM83l9K1yzT/Cp9uHSkokPrFxVd41RvsfbQfcK4LkByXeFPA+Oq?=
 =?us-ascii?Q?rFj8fPSbvlbBIv4ItqmzFJ8NDcGRakatdkyXWO3vbnrtwhBbeV79NGPCJsFL?=
 =?us-ascii?Q?kv8XXWnDG4KPdlZkl55IamvmIkT2ngiS0qfjrtFU7IYOmU4RTGKZmBZ3sV/M?=
 =?us-ascii?Q?hCZHytEVAVJ4Xrpo9BoGQu4KCQKhSL/I6iqrg+hMHVVGP8UYDYYK+Drc0cH7?=
 =?us-ascii?Q?tTRt0u/ojjP5RQb1stax2Xrahi7gIZ84AIamW6l1kGtckxL09yWBRX88J3+g?=
 =?us-ascii?Q?RIhbf7tUgkKvD3mzFrygw7r2V8RgeWonpXqd/J2OulL1TUTKDKdArKJyQ7KI?=
 =?us-ascii?Q?Q8JdrmUGfdoXMKQWxHahCtXQtbvG1EpyT/6h2TA521bhagnynkryTitJ77aE?=
 =?us-ascii?Q?Zew3woYhfyQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fm48BK3uOedJElFTLhROqYbt3FkRnI/dM6vvLiu9ZtXwfFEAAzfWkhoFsVke?=
 =?us-ascii?Q?pX5smk68oFCATv+i9GYSuNvlZc1WbNn0g8F/vECEegSUy7LDasnEUPG8Eq2m?=
 =?us-ascii?Q?IqTNtCJ1iWgcKjjH63S8rfpOj0JkRnYqbWGjWl3Wb5jtOZfZLoLSJfri7faS?=
 =?us-ascii?Q?Ar5yOhSfF/GUhOaXjEcK7/bCKmQhsDGAIZ9iwtqZ17V6B73Z3RvDcq/vurTs?=
 =?us-ascii?Q?/ju0ZWHXpnvyqBbzFoQiOO0/ZvCIrd6zVll7YwnYa01Lm3cRac4suO0e0+be?=
 =?us-ascii?Q?RDhAsIGdT/grd7wj/O/gXKwlxZCALQdYC7rmWoLOxGbtFh0Q9rzFEj6kQojw?=
 =?us-ascii?Q?GZ/BRVnm+emcEBcLY0zA+cwKJ/QjpRky+LtL9vrInE6rLwj+FJMzmTTPXq8E?=
 =?us-ascii?Q?OlhOo0TMLheYIY67vtDwy/zSCB9jHusBomcf+Qsw0S9PxGUPIXF8b2WJFCHt?=
 =?us-ascii?Q?ZPyo8oqkxYzjczB7SuSHWBYSm15manztLIc2I8DDZ4EjTLEmWzuSxDu6LLud?=
 =?us-ascii?Q?Iq11/wi4Uv5Ok8G1PVLjdo0A+OIf5pUYcON+nrHgKLehgYQlUbdcyYcHJLUc?=
 =?us-ascii?Q?V/SatsbRuCFK506/GarD/dThK79DjhJZI1raprQIZUAjl6f8oJrLqfL4mtCw?=
 =?us-ascii?Q?SI+VVcypsfR7pdUXNB9hUp3jfOKuZ/XLXMSsFa0YsuovlobwjQYF5AbWMN6C?=
 =?us-ascii?Q?cHIok7NxziOXtMh3vMpaqZMmotbn3H2Dcm8lXraZ/W82Yngo/XFA7sh8pps1?=
 =?us-ascii?Q?W4fHtR7vS/ScqYefVbArGF6VIEn/x5bLsIRKpBZOXqhZyv+HGW4FbMSWgdAY?=
 =?us-ascii?Q?W9WfZqckccn7mzdPR1+BwCzBuAK3hIwXovfhW+g1Xwnl5RB3Zr1kJS3/d1Hu?=
 =?us-ascii?Q?MWws8x87CT/4yM76133DAgeHlHfi6FiJ+2sPdqBbJKJdKYoAaglOlTuzor5V?=
 =?us-ascii?Q?s6PNVhyMXIqSbQps6RPHnJAI0op2pLMyv9nUSw+ZfP4G0B/2fDejt0vujV32?=
 =?us-ascii?Q?52IzpfxR+LJrLfZsoIfZ+8zxdHaa0ViolyTknKvwqf/Heh8kfmQ21vvogOEL?=
 =?us-ascii?Q?n4+vbN7EchPuwdtx+NJ06g4AN8gF7fbTEq0OkGHvj8aKa+wDog+W1aLiWVLJ?=
 =?us-ascii?Q?zVYt/AByVk9Ez7EObKAI2zqbn4dsrikq4LjWfNBgHH8lJjjzc5zd0ouHiJWo?=
 =?us-ascii?Q?q61rd7ZajcTtsw24Q7Z/nAvrg8TfYDO/0cHFRhKOScSkS8Dz8yfxZLommGrQ?=
 =?us-ascii?Q?Ir+f3cneU+mgPxWKSgF9qSAPJf9kFh3adUMclZV+LTsngweTtdWf9ihWvW4D?=
 =?us-ascii?Q?v5l00Nx7yuw3vKOITU+4M55oe0xF/xpbt5avzQ+VQBkfa1X3xRXcKki5fdKO?=
 =?us-ascii?Q?e35TAz8c3kT1/cBsAxFK31AvTttSoSEIqblyA4MGGWhARYPROo6ypOOCQwbr?=
 =?us-ascii?Q?IKWriEdOalYerrSYlYEbxOQsDf/6Rn5q3XzqsM+wK1aoqpZS1QtQSgzXZWoN?=
 =?us-ascii?Q?effPUkKN4CoW9FIGm05xPWV2uMbidbXhwZsXJbc0QtUD1fsXQJ20jhfpRDGz?=
 =?us-ascii?Q?fXr+k4Jj/l1jD5gx4/jVn+a9jF4mZQmKlvxaxN6B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595c11bf-83ec-4cd1-1c6b-08dd87c54aee
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 08:59:19.3154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+1Oz1Alax/R13Mh2K4AWCCEIsB00aBq35n0zg0UjWkxRYI0lum4wxXL99N+AtmNzBt1DmhQXXb1TGh8WMjszQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7319

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
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 58 +++++++++++++++++--
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    |  1 +
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  6 ++
 4 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 528e5c97f5a4..b9264a7fe587 100644
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
@@ -264,6 +265,9 @@ struct mlx5e_icosq_wqe_info {
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
index 48dd242af2bb..639a9187d88c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -173,6 +173,13 @@ build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue,
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
 					       MLX5_MKEY_MASK_LEN |
@@ -285,8 +292,8 @@ build_nvmeotcp_static_params(struct mlx5e_nvmeotcp_queue *queue,
 
 static void
 mlx5e_nvmeotcp_fill_wi(struct mlx5e_nvmeotcp_queue *nvmeotcp_queue,
-		       struct mlx5e_icosq *sq, u32 wqebbs, u16 pi,
-		       enum wqe_type type)
+		       struct mlx5e_icosq *sq, u32 wqebbs,
+		       u16 pi, u16 ccid, enum wqe_type type)
 {
 	struct mlx5e_icosq_wqe_info *wi = &sq->db.wqe_info[pi];
 
@@ -298,6 +305,10 @@ mlx5e_nvmeotcp_fill_wi(struct mlx5e_nvmeotcp_queue *nvmeotcp_queue,
 		wi->wqe_type = MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP;
 		wi->nvmeotcp_q.queue = nvmeotcp_queue;
 		break;
+	case KLM_INV_UMR:
+		wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE;
+		wi->nvmeotcp_qe.entry = &nvmeotcp_queue->ccid_table[ccid];
+		break;
 	default:
 		/* cases where no further action is required upon
 		 * completion, such as ddp setup
@@ -319,7 +330,7 @@ mlx5e_nvmeotcp_rx_post_static_params_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(NULL, sq, wqebbs, pi, BSF_UMR);
+	mlx5e_nvmeotcp_fill_wi(NULL, sq, wqebbs, pi, 0, BSF_UMR);
 	build_nvmeotcp_static_params(queue, wqe, resync_seq, queue->crc_rx);
 	sq->pc += wqebbs;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, &wqe->ctrl);
@@ -337,7 +348,7 @@ mlx5e_nvmeotcp_rx_post_progress_params_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	wqebbs = MLX5E_NVMEOTCP_PROGRESS_PARAMS_WQEBBS;
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_NVMEOTCP_FETCH_PROGRESS_PARAMS_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, SET_PSV_UMR);
+	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, 0, SET_PSV_UMR);
 	build_nvmeotcp_progress_params(queue, wqe, seq);
 	sq->pc += wqebbs;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, &wqe->ctrl);
@@ -363,7 +374,7 @@ post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	wqebbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, wqe_type);
+	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, ccid, wqe_type);
 	build_nvmeotcp_klm_umr(queue, wqe, ccid, cur_klm_entries, klm_offset,
 			       klm_length, wqe_type);
 	sq->pc += wqebbs;
@@ -378,7 +389,10 @@ mlx5e_nvmeotcp_post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	struct mlx5e_icosq *sq = &queue->sq;
 	u32 klm_offset = 0, wqes, i;
 
-	wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
+	if (wqe_type == KLM_INV_UMR)
+		wqes = 1;
+	else
+		wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
 
 	spin_lock_bh(&queue->sq_lock);
 
@@ -905,12 +919,44 @@ void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi)
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
+	queue = container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue,
+			     ulp_ddp_ctx);
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
index 4850c19e18c7..67805adc6fdf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -113,6 +113,7 @@ void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv);
 struct mlx5e_nvmeotcp_queue *
 mlx5e_nvmeotcp_get_queue(struct mlx5e_nvmeotcp *nvmeotcp, int id);
 void mlx5e_nvmeotcp_put_queue(struct mlx5e_nvmeotcp_queue *queue);
+void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi);
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi);
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 38c8825d8678..8af51d1886bd 100644
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


