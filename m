Return-Path: <netdev+bounces-171216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDE4A4C01A
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C913A3668
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 12:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635AE1F03C2;
	Mon,  3 Mar 2025 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CFfgdtRy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD74C1DE3D6
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 12:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004398; cv=fail; b=DiRUKuZE0tBQGwzNmAz3BMbmZ6qOFqNwTdBtOtFD0ai6xi4wYxU4nKJQfTeyBF+YMTSZB9NAWs/Nq1DIOMTypggpkbKJWz2n84SkR9eejn8HXIvNO74cozk52yOjyNp3JlatzYaiPTPuIq/UI4cntPQf8r8sqHWtkZr2Nv5LdHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004398; c=relaxed/simple;
	bh=tz6ocpolU7EBp2yBxk6jdWqrM7rz49b9cSz0iF15eks=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DkDoPbDh4zwzts+IJz0IFmKHpz2XIOTQnEyhGFZTCEZ8pCVW47qvo1CvOxOuvUIT0pfdCALRPwyk3w2tAN1wW+swprYjkujoV+Gs9rUOlWQ/4vdq1tuoo5c52K/1Uizb+abhlskN4adtAKLbxKvxrF0UA3LYvMkAgaxmemoShYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CFfgdtRy; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkmhlJwNmamSHU5nHlFIwHHslH4i+B30AnxA5We9tV5ID1AVzpS7waFysFP2UCFrTB5UJpYOhikb9Y2NnYvWaMgRNf3WZ8FrGXHx3lL/lV0YaBI6VTxKbWP1Fy+gWAqTOEye5vCbLWkahst1snn+o7nD0Xa4cDXKT9CF/hZhQpY1na4fRZI7JGchQk217+fjfB5oPg4UIncsAKBLJETJfQVu6IsEvF7dCbVUKpO9W194XrV7GUmmFqQcFgKWHw1Iho+rTp1wf08bnkdpu134kaqkl6mPbIJbjP1B5ZFXMSBw9xhvL8yzIG/eUV0oT6ZVuuxXsZm8XAV8e9TLYY0hSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvsbJQJgRYyAo70otZU2WwCMqEFz1JZdb4flo7kvCjE=;
 b=xLWzIrJtQ6Z1WOciCx0aJ2wdFIez62zvTLq9mPxluox+bOmkBobts8VXp3vH6vmJr/ZWHFWxgM7OUyQFyxihoECAMZx05Pm9Yz9nGrao/LZfWWgvaR+ilQnRljH+uIpC1cT/zWMrWrk9ZcqeM4ZBsQ3VpxKhWS2opBodA+o3BQ1GsXdk8EVtfkcWLKrrzEvcOGeT/U40zyDbtDsbMWo26c11ehr9eGRo1Hm2k1NRurnySmmE3rJfN54rmlNbrU2CoWgbHZpt9fdmBNlxj+r/efmjQ1U/xAZaMmZiB62lPq/N7mIPLAstLftdzdFDKARums1B5wnYUwpUM+HK0nT+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvsbJQJgRYyAo70otZU2WwCMqEFz1JZdb4flo7kvCjE=;
 b=CFfgdtRyeV9S3YArxjv3v3TXIUrpAPxfYXsp3xPcKx6Bfs3xfg+yW/lAB0OQuUb9J7o0/yjs9Utl2LJ0fY3tPN4lZaKHRzdNWhBhkFA9pLfnGVtth//3G4vfH0mssY7FyUxryGRICSLkf33CWSdQSzS9UpmvkaZt10WKf8vtT9EEJnH/MgKuSDPgt9ShCSZhjNdBfB2yf40m/trXGtLUzDMTDL6RLoMETpMfSo/ayMnwdl5fuDtWJc01aN2jtuFcRh59DqEm/HI1tWF1Tlx4pGNqGdKVAfUB71dpuDAYz2VW7IHfNqZlgpWuui94jKiQ6O7ZnmYgtOg+A0gPIROvYw==
Received: from SA1P222CA0092.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::12)
 by MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 12:19:53 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::98) by SA1P222CA0092.outlook.office365.com
 (2603:10b6:806:35e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.24 via Frontend Transport; Mon,
 3 Mar 2025 12:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 12:19:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Mar 2025
 04:19:44 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 04:19:43 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Mar
 2025 04:19:42 -0800
From: Gal Pressman <gal@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH ethtool-next 0/6] Symmetric OR-XOR RSS hash
Date: Mon, 3 Mar 2025 14:19:35 +0200
Message-ID: <20250303121941.105747-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|MN2PR12MB4096:EE_
X-MS-Office365-Filtering-Correlation-Id: 08beb093-1ecb-4da7-854f-08dd5a4db3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7S4VqpGQm31eD+8IE8H3qQX5EQ9b057wI1jHgdPv+48J0vStpXjk1+zKZ0xX?=
 =?us-ascii?Q?v3ZpFQZdUN1SbdmBthrxqIblPFRgwmSf9XR8JkfmEoD+FTzgh1CitMAyI871?=
 =?us-ascii?Q?R7iJnE32cOuzY3jIMGh/wZCrBMBjKssmZC3T6AC8SmGImOLWuVY1fGUDDdAi?=
 =?us-ascii?Q?lsl9SwC9aOt+bxbtXSUy0YOqhAJKKxWT7DuuTTp+yFfd0m+rc0PIc/gNBPw7?=
 =?us-ascii?Q?cXUjK5AysQm+l98GMzJNU72rGJbuQPMC9A3m6Mrc2czVuVDolbh4y7tMQb3y?=
 =?us-ascii?Q?FTFBehKcj1u7ioxrCC1C4yelUSJD9P0fC0UtkvbA4t/wlHMU1hbBopGqEAdj?=
 =?us-ascii?Q?36y+ZdsJojoQ5hk0K/LuRXy0DHd6PItjpQ7j4l/E5+R3l18RBGyHA8t96QY3?=
 =?us-ascii?Q?1WJSy1Kpu0oY3HqvzQhHI0DwIPJnV87YCqdNDAnvF+ipO6yFq5xz51dpAhTc?=
 =?us-ascii?Q?afD+VWIH2/LAaj1BbiLmpzpj1k7iYlHFpHYRgrinh73UZaYJJ5DRObvoN6t8?=
 =?us-ascii?Q?B+9DguEdUVgevlONvc/8HoTCB9KyIYKDH+lxKHpyWRbjH0LyUEoJF1RjtL91?=
 =?us-ascii?Q?VLCi+7qW3ruGNgNhRcHikEQ4xlOQa4Lnx2aQmIdYhrQ56jhPqq0EOghlT0uJ?=
 =?us-ascii?Q?JBsAxBxBAA4kUiRXqANtvrouhBMHh1+hnswAyVV1As1iL3FoJHaawrRXqxDo?=
 =?us-ascii?Q?fhvr003TaSKOd5g5FqLbHnkmcNf47l74l8g9F8AaMznuJOPtjDSzVKKnzM18?=
 =?us-ascii?Q?kRxpykVSkNfpk/VvBzGeeao3FGqftmj8UT8JEdj7reOEnOFztxpJPFRLMo1E?=
 =?us-ascii?Q?tt9h2Yg7HVmQNPIWp9taJk/EVmL0zui4UnOOPhi+5kO7+JR86Jcpyom31OGV?=
 =?us-ascii?Q?jwDAHe4Y1DYMCR1wyWZb7U2YL7SD6eGkJOfyC0sYOck/FFzLTMH83CYkDol1?=
 =?us-ascii?Q?RpRg/Lvjj1abBbITRIrWPXz5s9dklOszvtuqqtLLmSeLzLrUkuvL2i7730lw?=
 =?us-ascii?Q?lq95tzcEEitGfP3Cwim7Cab7TVtc94SYiu7hTdZzn7UredzuanP1C5cSyQcZ?=
 =?us-ascii?Q?fwWqFMzaARTAzPSc9g0T+KSoQ2in1VIvVycXg82WlI6x+0jeKpGbz6OOgVzF?=
 =?us-ascii?Q?lUmxqzfqA1pFp6AEwu8w/zIp3DcMXA5ra1QS01RxG3H1Espq+HcUQBCl4+ec?=
 =?us-ascii?Q?sHjxMazFs4CGKBcGZot4QQA4JsThXM1fODNLwGnMd7x1IE0XVdSJoZovpC+o?=
 =?us-ascii?Q?qPdUXNY8iOy/qUAG+Tg8dKiwM8X+GZumt3LWXcbe2L9mPykyg0UqXHLjc9X+?=
 =?us-ascii?Q?4eupKwdIFPzOHup8yncRlP2ZzjpvuH5RVRnun7NlWjOI3oGtm66izyOZQl+g?=
 =?us-ascii?Q?qrtbsC7Mfoe988w8oLlMKvVdKY6Goun2JP4v2lXoG93Wjoan15B8LWjjGc5x?=
 =?us-ascii?Q?pA+OFxnVg+eiwiND0AGxB+xK1zC7soO4JiPbwWGZK5BCGzCdaEwwfucmdY3P?=
 =?us-ascii?Q?OUCOO/PnPQ8IuRU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 12:19:53.2257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08beb093-1ecb-4da7-854f-08dd5a4db3e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096

Add support for a new type of input_xfrm: Symmetric OR-XOR.
Symmetric OR-XOR performs hash as follows:
(SRC_IP | DST_IP, SRC_IP ^ DST_IP, SRC_PORT | DST_PORT, SRC_PORT ^ DST_PORT)

Configuration is done through ethtool -x/X command.
Also performed some misc cleanups for things I've noticed while touching
the area, see individual patches for information.

Kernel submission was merged:
https://lore.kernel.org/netdev/20250224174416.499070-1-gal@nvidia.com/

Thanks,
Gal

Gal Pressman (6):
  update UAPI header copies
  Print unknown RSS hash function value when encountered
  Use RXH_XFRM_NO_CHANGE instead of hard-coded value
  Move input_xfrm outside of hfunc loop
  Print unknown input_xfrm values when encountered
  Symmetric OR-XOR RSS hash

 ethtool.8.in                           |  14 +-
 ethtool.c                              |  20 +-
 netlink/rss.c                          |  30 +-
 uapi/linux/ethtool.h                   |  31 +
 uapi/linux/ethtool_netlink.h           | 899 +------------------------
 uapi/linux/ethtool_netlink_generated.h | 821 ++++++++++++++++++++++
 uapi/linux/if_link.h                   |  20 +
 uapi/linux/net_tstamp.h                |  11 +
 uapi/linux/rtnetlink.h                 |  22 +-
 uapi/linux/stddef.h                    |  13 +-
 uapi/linux/types.h                     |   1 +
 11 files changed, 972 insertions(+), 910 deletions(-)
 create mode 100644 uapi/linux/ethtool_netlink_generated.h

-- 
2.40.1


