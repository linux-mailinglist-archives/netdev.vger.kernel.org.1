Return-Path: <netdev+bounces-171148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ABBA4BB3B
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A9D3B27B2
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F611F0E3E;
	Mon,  3 Mar 2025 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e5+ECubp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CC51E3DEB
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995627; cv=fail; b=B1F+pfQoBvj0xKEPsufsiYmWVGybaCqzDhEDEmZJrBDApehB60wncEj0nmAIp7Vc4xXS91csyXQ9VGjOvZ5nW6t5iDPL6pTUKnizWlAzHYnQ0lVouJntLhVGTzWu/IwjdiyzXjO6YHXiLsu7RgrqQjNnHYhYNrR5YZgg4qVmo3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995627; c=relaxed/simple;
	bh=vryMXtYNmniknXC5JbviteUJ1FUDdLE/wTXkkBAFbwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pGJym1q0saAQ/COKUujumtKMpBQdLFlyVq80XapxUIC2Tr+BaMseK3xynSv3NS02Z+PSv+rRYYMBJC+0Q+acGaPf9WtRo1gBkhW2QHebtC3x4ZIyEcZ7vj55Vd6XsIVL5wpyRgnM6n4i1s6Icb0+9/0YMPFgTqDftrGhvqseupw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e5+ECubp; arc=fail smtp.client-ip=40.107.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bquMsbI7jgG4c8/KBZJwIq4T8vedWyAKa4PdEsbrCiBP2wXTNhpPVPEqsnzZbTmyU/QRer9fxuKtC1sAmqKZ4xJc6eKeSUzsrgQEwHWC7SuDUYjC1a7IqoT5jrSl4zBxk26mzlTJcaG/xbLSOmv/cLffTIm7iYZghW248DZIemeVAnhqvrgr4t8Hpa7YGW565/4c9s4PNpCozS7lZYxuFpyFWUpBI7/1R2QBixoOhc4XiwLJoD+8qUJ9JY8Ud1ZXNFvWvAfVQ+9HLGx7FuPu7nTQv/Q5AwB2nL5x1y6hYYOQ0RS/b/VEKN8EVkJUoveNk+i1RqKtzhTOFLq+aVUfKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkkrs9cJK/zCEOpCw3x4ByGOriSUmgqVaiZulHJZlUw=;
 b=iWqCX9cJQJOudWDYFPLGSPBeQX5F3BlmgvQljdNHZKULVmdluzRHiFr7L34FZkoiLkN30wAybD3Yx5e7rG2M/yCwhKqe/RlfiEXLZZsV+XLTmYniQXHcqzswQXcHtszkGAjyDbM6A+hEUN3ZYqcg6EJrga1nxVyEh/7QFtAh7RizoPL+kG6BJoWSs6oh5xzg/tQT+cpFRTZ9kZHOu7xe+KQqAOnMfVF/u2StWFJjPoL9tZytUPwZrijrFR6xknC9i1Ph6hIT4KK6imb1Q8A+qSu3Xt00Wy+OHuDnXTIKvR87wB6nT52Z3rwGWii0vYtcwBhhehb0YBxo6AxiSDJe/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkkrs9cJK/zCEOpCw3x4ByGOriSUmgqVaiZulHJZlUw=;
 b=e5+ECubpwguL65RrEVpDtnJSy7tkzGMQqCJYaeJFcllbhWExG6Y00SCIt9jchy1EmVwWYI4Tm4HiZ5npvHmD1w1JFxpl9/rhaPrAFbChiMCTSFJixJrDiQcQr0NPzds5E5VOzNc7lks/f9V/ZEAHMZs07+PMjywxuowCgBfBMQnPTbTFlrThrvBXaHZxiY9TAShBngwDvnXsQFWdFx4tdjKfyGJ/wXkec2BCu6S7S3XheDrPD45em4MUYvizVifEOEacBHoxqRSCB4ggFzWilZnqe1m/oizOqrvXwapXzY1pqLvrBQ4SHDnpnPTXNQWCCpCrKZMyG33b1im5Cyq0Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.25; Mon, 3 Mar
 2025 09:53:40 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
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
Cc: Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	brauner@kernel.org
Subject: [PATCH v27 05/20] nvme-tcp: Add DDP offload control path
Date: Mon,  3 Mar 2025 09:52:49 +0000
Message-Id: <20250303095304.1534-6-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303095304.1534-1-aaptel@nvidia.com>
References: <20250303095304.1534-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::17) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9400f1-ba44-4928-cff3-08dd5a3946dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LO5aUrHpyMAHCoAflIrh1QN5V3D5rb9IDh3aESGfeZSOGkHyVmt4BzDONeFr?=
 =?us-ascii?Q?6hbAN/bJ/Wth72qsY8zzJjnGaWuE3E+bOVSkZUc22uOz3teP5K/GooZdSwTx?=
 =?us-ascii?Q?keA2xCHWj4oAJDgRF8BzSXaFv62fEg2sid6NeJmnAQHrMIFwn6StyAv1OhVd?=
 =?us-ascii?Q?j1Rc/dVO3TcAvceiw2PzK0ZrEWNmkfi7KLAP84qw8UlB231K2fReyZbs3wti?=
 =?us-ascii?Q?1G+ud7z7qEunuGHKLHmnBD6HJkKgbv8Iz8Z1KKQa+weYdRbS1oymic6FFwwD?=
 =?us-ascii?Q?c6d9x/hFXjvtdhiPMTmEJjI/hoDOqFcAGkQAIg2Zzp3WzWNdCo9f8Z2pat+D?=
 =?us-ascii?Q?VXcr655cXr1sJjGLd622raaz/MS/JnvlhicArYcUOAzbgh/gN7zKarQ4/A9R?=
 =?us-ascii?Q?zpwtGzDSkB31R9nQtr2++F0abwQxF0LLNVuqTRwMDMyHrbzMi7XFdnJ1hiOC?=
 =?us-ascii?Q?WQtTPOLXun2tS5eA/B+ixP7LVDK6Vl9trZlxdounbZkyuBuosHZJnyfjlr4g?=
 =?us-ascii?Q?1W3wcfuTGMWg+PDmPlMDzzoI6vfKRfWFqlPIIXe7Hne16Z/2MWc3jwhjhLrf?=
 =?us-ascii?Q?bv5milhjcrfTbtVakUNgu7BKmj6OGO0TWiHMJ3j67mtMUEk3kYfASo+93Ix6?=
 =?us-ascii?Q?nWfWoOqrK1S4lB7uWZUp2VFFpsNko5/4UAxndnfii3IAcDUAF7tT6uPU2OGo?=
 =?us-ascii?Q?PnTDD3C6SdmumSjxyspi60wNBCfirwXu9PNm6R6FmR7yBpmbCJauQ7aXbEeU?=
 =?us-ascii?Q?ppDHwLpCbiKJfJ5s45ECCmqzcTwOCZEyA87IDlnEndrpt0OEfg0htlKYVObZ?=
 =?us-ascii?Q?/4QbVN6bNt4LMsyJWsYnI6Uf5HMIyLDC1ZfZXRyzROKWsl1yELEReJ6fj8Jr?=
 =?us-ascii?Q?YzObKBydwBHxmQxPgiC/cbg9amHb98YQmJCsP/W9uner+BK61Dn7tBEMaWf9?=
 =?us-ascii?Q?SHXzmzFKBAbYuuQ6WR2lylPCa+rzGBM0z+ywLFLzeE0lRIyI1PygKrAbkXB1?=
 =?us-ascii?Q?i1RPGVymCt0FSyFr4/1Kcr+6XJpJJ4WanDZjdPxqD/wO5vM2+dVRbyolVFU2?=
 =?us-ascii?Q?ao8UiGnM0Rs9jpA+C9GJQSNcMGZHezLQtiOCMhZ93WifT2p1A3pSVFeFo+sN?=
 =?us-ascii?Q?hLDoNAUWGXt0EraTXazgxRUD7pFWZ8LPXsxeUEN0JVmVedwV8o33OGi99kjT?=
 =?us-ascii?Q?x8edK70u6zoVWDVfWZt1aEio9Z7BSlI5liy7ohNA2d0cBM/vflv7q3cleyyD?=
 =?us-ascii?Q?pgN/+qTqlGsHV4fwWXzVT1n+cauX30vDWW5ziUa6CBrt1paJN/HqWxbAX6Uu?=
 =?us-ascii?Q?CoYLGNNbu1uioC7D6PJrmHA+ueIk+gWU4XMlERIh4KUaNS3E++ue6Q20BF06?=
 =?us-ascii?Q?tVN4TxsBAVmGXnG7AvMBJR5KFhYu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sGYUDXXerLNUPw2uEBdjZd29hB2+u7AlYmJ029cZR8rsR8PzIfOie6YwGh8M?=
 =?us-ascii?Q?VvUKEw/80mNUIFKBFJQx4QBz3Qn6lRQhE9RRsNLR59yQ1FMuxTRIpxtA6CN8?=
 =?us-ascii?Q?ncgRGYqSzJyqayaddFs3qGzRr0a6MsObOAUpeZnfFdr2EiILMbnWN5UAf6l5?=
 =?us-ascii?Q?iL1GnraiyD1F26yYZkCW7XqTWADMAhkh/DWxLo8BdXjfjZYfWNdGjrFLBevC?=
 =?us-ascii?Q?hESoEOAr8xtvemNR9qOrp47hsOc//XeOid/4UsU2+Kqsnx+2Hl2I7Qr3xtC+?=
 =?us-ascii?Q?kB5Y0dLJ1NmENsOK8rM2R/TWuA9/Tad4MmrJaXS445e6Uf4BcV146EgsnkMf?=
 =?us-ascii?Q?E4bX+98K4ZKtX47hprm4Ms2kP1IdLfWGVGlg1cKTQTpyvoyNY4uM+ELxagcK?=
 =?us-ascii?Q?7em0XLHsOcQ9pR9Ye3lh9yfAxIivz9aeR9KNn5ctcab5GD2fBYTOM4Oj8cFb?=
 =?us-ascii?Q?cJc5EdjnLudyr9yL7fgalh+KmSkS+GSeawA5tYwIkKkZcZN+6LQrc0YeIVrO?=
 =?us-ascii?Q?yuBo9+MsdOyvgzfdxo5H4GfJm4uudEnyb+G+lc9+ZAhb2QGPwIzLBBSRSH96?=
 =?us-ascii?Q?1Ena86uBkvyR4nEa/aEm66IjupAVOvnQR3VzXN2uDli3bII3/fK+7a9hdWum?=
 =?us-ascii?Q?PeX69mWBr4pX0cX1XnoAJD53VlXWHf2DmpUCWfzIdSETc1whrFkFVXzjBpn8?=
 =?us-ascii?Q?93Wn7gf5FUfxg+++covIfiIZ2D8OvXgFZdImJF2UMs5uaDN8v3EhXZHFs59t?=
 =?us-ascii?Q?YQRWMq7uMFBX+qMdz8x3MfRqx4eBlnDli2tAxjZJZdmfLU/UzSnhpUp0egFM?=
 =?us-ascii?Q?3dMRp+Kk7Dkt4uXS1omd/pqTZ9RC6gSRgfWB2cHHhILyjZ3E+GFsb9sDGPaI?=
 =?us-ascii?Q?RlRnXEtdHhmTtN3o2NZO15YOF//hREjZOrFbB0Nyw0TO2djqzDFpVts6gcgr?=
 =?us-ascii?Q?ZuQEIpS1g7Th3E3qXhTeShg17Y/6ef/3V/W0mWQydKzQ24FVqBYuYwMPD17k?=
 =?us-ascii?Q?U3WwK/l2uYJlwa+ctROiadtpMjXksWrP+JpJPVa7vh/VxS3E2Isvw18BIPoW?=
 =?us-ascii?Q?03y2tR3I7KTzPyZhPZ/odTszHObgJV2aIVMA2w09JA10IgeqsBX9q81+vwsC?=
 =?us-ascii?Q?7FprvdQXkTouXcndjpKLQz6nT69kfUgHM2yAQ8J0Id5NlcCiuo9bP9F+wx0D?=
 =?us-ascii?Q?X/arkD2Kmfha7ksORJCc+eIFNotK+M4Qvw8S9psIaNccwk3yxNbrwF0GuPne?=
 =?us-ascii?Q?ek2OTNTDF8Fak4WMhiP1bYcLMTZBq/FYdqmzkhMXmPkwTtRbS7y10W3+JcXa?=
 =?us-ascii?Q?dWAQT6QvDuIQO/Xe6mtqXdwa5SjKJrWBX4+U0NJDPbTyoRL6vg3XGzI4pjWm?=
 =?us-ascii?Q?uEkiAitG9zfFp8CI69gK9bcQiFDWZk/g8YrUuyX0k4MtXLD/owwMRWJ+H0/H?=
 =?us-ascii?Q?0HdEjZubLExnpHbsVDJb2dfNHGMg5FMDoL2T6NG4wFpqKVlUPcA+0xx0hXiA?=
 =?us-ascii?Q?7PfqlVNou29i7+ncrHPTgnvtWEAtnIESyqq1aakk8se3P+aImeEGBtbwvXwD?=
 =?us-ascii?Q?vIq/aA1y2hze/mSbSEZHJsp3N9w5E/QKq7IQZlKq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9400f1-ba44-4928-cff3-08dd5a3946dc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:53:40.7132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwcpUhIqguR5vEd+oXKayE+Cg1+qD9jFwMSoFryuYlbMJj3EMV89DYN/OIpZDUN5IsKpGpiDQtGlrj5ibXteQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

From: Boris Pismenny <borisp@nvidia.com>

This commit introduces direct data placement offload to NVME
TCP. There is a context per queue, which is established after the
handshake using the sk_add/del NDOs.

Additionally, a resynchronization routine is used to assist
hardware recovery from TCP OOO, and continue the offload.
Resynchronization operates as follows:

1. TCP OOO causes the NIC HW to stop the offload

2. NIC HW identifies a PDU header at some TCP sequence number,
and asks NVMe-TCP to confirm it.
This request is delivered from the NIC driver to NVMe-TCP by first
finding the socket for the packet that triggered the request, and
then finding the nvme_tcp_queue that is used by this routine.
Finally, the request is recorded in the nvme_tcp_queue.

3. When NVMe-TCP observes the requested TCP sequence, it will compare
it with the PDU header TCP sequence, and report the result to the
NIC driver (resync), which will update the HW, and resume offload
when all is successful.

Some HW implementation such as ConnectX-7 assume linear CCID (0...N-1
for queue of size N) where the linux nvme driver uses part of the 16
bit CCID for generation counter. To address that, we use the existing
quirk in the nvme layer when the HW driver advertises if the device is
not supports the full 16 bit CCID range.

Furthermore, we let the offloading driver advertise what is the max hw
sectors/segments via ulp_ddp_limits.

A follow-up patch introduces the data-path changes required for this
offload.

Socket operations need a netdev reference. This reference is
dropped on NETDEV_GOING_DOWN events to allow the device to go down in
a follow-up patch.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 269 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 258 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 841238f38fdd..795e2dae3c11 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -21,6 +21,10 @@
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
 
+#ifdef CONFIG_ULP_DDP
+#include <net/ulp_ddp.h>
+#endif
+
 #include "nvme.h"
 #include "fabrics.h"
 
@@ -56,6 +60,16 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 
 static atomic_t nvme_tcp_cpu_queues[NR_CPUS];
 
+#ifdef CONFIG_ULP_DDP
+/* NVMeTCP direct data placement and data digest offload will not
+ * happen if this parameter false (default), regardless of what the
+ * underlying netdev capabilities are.
+ */
+static bool ddp_offload;
+module_param(ddp_offload, bool, 0644);
+MODULE_PARM_DESC(ddp_offload, "Enable or disable NVMeTCP direct data placement support");
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /* lockdep can detect a circular dependency of the form
  *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
@@ -130,6 +144,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
 	NVME_TCP_Q_IO_CPU_SET	= 3,
+	NVME_TCP_Q_OFF_DDP	= 4,
 };
 
 enum nvme_tcp_recv_state {
@@ -157,6 +172,18 @@ struct nvme_tcp_queue {
 	size_t			ddgst_remaining;
 	unsigned int		nr_cqe;
 
+#ifdef CONFIG_ULP_DDP
+	/*
+	 * resync_tcp_seq is a speculative PDU header tcp seq number (with
+	 * an additional flag in the lower 32 bits) that the HW send to
+	 * the SW, for the SW to verify.
+	 * - The 32 high bits store the seq number
+	 * - The 32 low bits are used as a flag to know if a request
+	 *   is pending (ULP_DDP_RESYNC_PENDING).
+	 */
+	atomic64_t		resync_tcp_seq;
+#endif
+
 	/* send state */
 	struct nvme_tcp_request *request;
 
@@ -198,6 +225,14 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+
+	struct net_device	*ddp_netdev;
+	netdevice_tracker	netdev_tracker;
+	netdevice_tracker	netdev_ddp_tracker;
+	u32			ddp_threshold;
+#ifdef CONFIG_ULP_DDP
+	struct ulp_ddp_limits	ddp_limits;
+#endif
 };
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
@@ -323,6 +358,178 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 	return nvme_tcp_pdu_data_left(req) <= len;
 }
 
+#ifdef CONFIG_ULP_DDP
+
+static struct net_device *
+nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	struct net_device *netdev;
+	int ret;
+
+	if (!ddp_offload)
+		return NULL;
+
+	rtnl_lock();
+	/* netdev ref is put in nvme_tcp_stop_admin_queue() */
+	netdev = get_netdev_for_sock(ctrl->queues[0].sock->sk, &ctrl->netdev_tracker, GFP_KERNEL);
+	rtnl_unlock();
+	if (!netdev) {
+		dev_dbg(ctrl->ctrl.device, "netdev not found\n");
+		return NULL;
+	}
+
+	if (!ulp_ddp_is_cap_active(netdev, ULP_DDP_CAP_NVME_TCP))
+		goto err;
+
+	ret = ulp_ddp_get_limits(netdev, &ctrl->ddp_limits, ULP_DDP_NVME);
+	if (ret)
+		goto err;
+
+	if (nvme_tcp_tls_configured(&ctrl->ctrl) && !ctrl->ddp_limits.tls)
+		goto err;
+
+	return netdev;
+err:
+	netdev_put(netdev, &ctrl->netdev_tracker);
+	return NULL;
+}
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
+static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
+	.resync_request		= nvme_tcp_resync_request,
+};
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
+	int ret;
+
+	config.affinity_hint = queue->io_cpu == WORK_CPU_UNBOUND ?
+		queue->sock->sk->sk_incoming_cpu : queue->io_cpu;
+	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
+	config.nvmeotcp.cpda = 0;
+	config.nvmeotcp.dgst =
+		queue->hdr_digest ? NVME_TCP_HDR_DIGEST_ENABLE : 0;
+	config.nvmeotcp.dgst |=
+		queue->data_digest ? NVME_TCP_DATA_DIGEST_ENABLE : 0;
+	config.nvmeotcp.queue_size = queue->ctrl->ctrl.sqsize + 1;
+
+	ret = ulp_ddp_sk_add(queue->ctrl->ddp_netdev,
+			     &queue->ctrl->netdev_ddp_tracker,
+			     GFP_KERNEL,
+			     queue->sock->sk,
+			     &config,
+			     &nvme_tcp_ddp_ulp_ops);
+	if (ret)
+		return ret;
+
+	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+
+	return 0;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{
+	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
+	ulp_ddp_sk_del(queue->ctrl->ddp_netdev,
+		       &queue->ctrl->netdev_ddp_tracker,
+		       queue->sock->sk);
+}
+
+static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	ctrl->ctrl.max_segments = ctrl->ddp_limits.max_ddp_sgl_len;
+	ctrl->ctrl.max_hw_sectors =
+		ctrl->ddp_limits.max_ddp_sgl_len << (NVME_CTRL_PAGE_SHIFT - SECTOR_SHIFT);
+	ctrl->ddp_threshold = ctrl->ddp_limits.io_threshold;
+
+	/* offloading HW doesn't support full ccid range, apply the quirk */
+	ctrl->ctrl.quirks |=
+		ctrl->ddp_limits.nvmeotcp.full_ccid_range ? 0 : NVME_QUIRK_SKIP_CID_GEN;
+}
+
+/* In presence of packet drops or network packet reordering, the device may lose
+ * synchronization between the TCP stream and the L5P framing, and require a
+ * resync with the kernel's TCP stack.
+ *
+ * - NIC HW identifies a PDU header at some TCP sequence number,
+ *   and asks NVMe-TCP to confirm it.
+ * - When NVMe-TCP observes the requested TCP sequence, it will compare
+ *   it with the PDU header TCP sequence, and report the result to the
+ *   NIC driver
+ */
+static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+				     struct sk_buff *skb, unsigned int offset)
+{
+	u64 pdu_seq = TCP_SKB_CB(skb)->seq + offset - queue->pdu_offset;
+	struct net_device *netdev = queue->ctrl->ddp_netdev;
+	u64 pdu_val = (pdu_seq << 32) | ULP_DDP_RESYNC_PENDING;
+	u64 resync_val;
+	u32 resync_seq;
+
+	resync_val = atomic64_read(&queue->resync_tcp_seq);
+	/* Lower 32 bit flags. Check validity of the request */
+	if ((resync_val & ULP_DDP_RESYNC_PENDING) == 0)
+		return;
+
+	/*
+	 * Obtain and check requested sequence number: is this PDU header
+	 * before the request?
+	 */
+	resync_seq = resync_val >> 32;
+	if (before(pdu_seq, resync_seq))
+		return;
+
+	/*
+	 * The atomic operation guarantees that we don't miss any NIC driver
+	 * resync requests submitted after the above checks.
+	 */
+	if (atomic64_cmpxchg(&queue->resync_tcp_seq, pdu_val,
+			     pdu_val & ~ULP_DDP_RESYNC_PENDING) !=
+			     atomic64_read(&queue->resync_tcp_seq))
+		ulp_ddp_resync(netdev, queue->sock->sk, pdu_seq);
+}
+
+static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
+{
+	struct nvme_tcp_queue *queue = sk->sk_user_data;
+
+	/*
+	 * "seq" (TCP seq number) is what the HW assumes is the
+	 * beginning of a PDU.  The nvme-tcp layer needs to store the
+	 * number along with the "flags" (ULP_DDP_RESYNC_PENDING) to
+	 * indicate that a request is pending.
+	 */
+	atomic64_set(&queue->resync_tcp_seq, (((uint64_t)seq << 32) | flags));
+
+	return true;
+}
+
+#else
+
+static struct net_device *
+nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
+{
+	return NULL;
+}
+
+static void nvme_tcp_ddp_apply_limits(struct nvme_tcp_ctrl *ctrl)
+{}
+
+static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
+{
+	return 0;
+}
+
+static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
+{}
+
+static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
+				     struct sk_buff *skb, unsigned int offset)
+{}
+
+#endif
+
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
 		unsigned int dir)
 {
@@ -771,6 +978,9 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
 	int ret;
 
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_resync_response(queue, skb, *offset);
+
 	ret = skb_copy_bits(skb, *offset,
 		&pdu[queue->pdu_offset], rcv_len);
 	if (unlikely(ret))
@@ -1870,6 +2080,8 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	nvme_tcp_restore_sock_ops(queue);
 	cancel_work_sync(&queue->io_work);
+	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
+		nvme_tcp_unoffload_socket(queue);
 }
 
 static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
@@ -1891,6 +2103,20 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_unlock(&queue->queue_lock);
 }
 
+static void nvme_tcp_stop_admin_queue(struct nvme_ctrl *nctrl)
+{
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+
+	nvme_tcp_stop_queue(nctrl, 0);
+
+	/*
+	 * We are called twice by nvme_tcp_teardown_admin_queue()
+	 * Set ddp_netdev to NULL to avoid putting it twice
+	 */
+	netdev_put(ctrl->ddp_netdev, &ctrl->netdev_tracker);
+	ctrl->ddp_netdev = NULL;
+}
+
 static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
 {
 	write_lock_bh(&queue->sock->sk->sk_callback_lock);
@@ -1920,17 +2146,35 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	if (idx) {
 		nvme_tcp_set_queue_io_cpu(queue);
 		ret = nvmf_connect_io_queue(nctrl, idx);
-	} else
+		if (ret)
+			goto err;
+
+		if (ctrl->ddp_netdev) {
+			ret = nvme_tcp_offload_socket(queue);
+			if (ret) {
+				dev_info(nctrl->device,
+					 "failed to setup offload on queue %d ret=%d\n",
+					 idx, ret);
+			}
+		}
+	} else {
 		ret = nvmf_connect_admin_queue(nctrl);
+		if (ret)
+			goto err;
+
+		ctrl->ddp_netdev = nvme_tcp_get_ddp_netdev_with_limits(ctrl);
+		if (ctrl->ddp_netdev)
+			nvme_tcp_ddp_apply_limits(ctrl);
 
-	if (!ret) {
-		set_bit(NVME_TCP_Q_LIVE, &queue->flags);
-	} else {
-		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
-			__nvme_tcp_stop_queue(queue);
-		dev_err(nctrl->device,
-			"failed to connect queue: %d ret=%d\n", idx, ret);
 	}
+
+	set_bit(NVME_TCP_Q_LIVE, &queue->flags);
+	return 0;
+err:
+	if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+		__nvme_tcp_stop_queue(queue);
+	dev_err(nctrl->device,
+		"failed to connect queue: %d ret=%d\n", idx, ret);
 	return ret;
 }
 
@@ -2170,7 +2414,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 out_stop_queue:
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 out_cleanup_tagset:
 	if (new)
@@ -2185,7 +2429,7 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 {
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
-	nvme_tcp_stop_queue(ctrl, 0);
+	nvme_tcp_stop_admin_queue(ctrl);
 	nvme_cancel_admin_tagset(ctrl);
 	if (remove) {
 		nvme_unquiesce_admin_queue(ctrl);
@@ -2493,7 +2737,10 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 
-	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
+	if (nvme_tcp_admin_queue(req->queue))
+		nvme_tcp_stop_admin_queue(ctrl);
+	else
+		nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
 	nvmf_complete_timed_out_request(rq);
 }
 
-- 
2.34.1


