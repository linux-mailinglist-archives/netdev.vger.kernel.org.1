Return-Path: <netdev+bounces-124548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6D9969F7A
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11EFF282A77
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152F93EA64;
	Tue,  3 Sep 2024 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HhSBQwbU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC723BB48
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371664; cv=fail; b=g2VUBspO5jydZqTuFbH/SHXxPB3qXMZhQhZGYrflDU2p07BmuL2nD1c0kqFXzPaMKV/9niKTh1h3rWCssQbohb+c63/wkw6Eo/E3zdz6ncysVdBFJjwAmC9ShERP2932WDFIYqcBh/c/LL6kIBsLf3gEMaOxO6aaSs8bH3U0BSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371664; c=relaxed/simple;
	bh=Lrd0XVNW0xwUwugxStcswTYXp2AX4hFYH+oKfr5KNek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ckegx34KjBWqQyp3odchZmB48umU+bpUSUScZQ69lmZPv9H53bJs7+OBPZAjdd/2zG8cSUCe2kLkao9VELO1e71Q4Ukj7w3f4gKNbR9RA9TG86/DzJJezOSUt47eWDk0JQCJgojiENCffkksQIf17105UizY1Iq42nR5/0dPbp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HhSBQwbU; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwnkDXE3N+LdrpuKO8I986rsr84GA2cayjfM6fMDozmgmAjlYDedjaHTDOcbplWtWFq1Uiy5/xcDAtW5sZ/9thiaS/rnIVa8TXG5YRK6wL3HN6fjrGLy1MFIgT06S2d+NHtZOi3f31XGu272u3lK1MIEtavkpAdm1Ii3lUDKtgfuOq+VPk7rceXVy2nleHGOZJZwlmOyj6MhmHQyVLx4DnWQ6hf1FVg56P5mKYgXsoDtotYDN4BgdDrej730hjGgkjv3bDaLTpPRMpaabW1kYETcSgk/17RraqPq+7lZz2tep231VLQefsg3GPy2zZlIW+I0lNWy0S04bTUV7zhMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdYPercBaT7Qf2hnTkUnssGOH2P/FlCXYneRnIIagVs=;
 b=kcI2SO0bKYqkN8emGH3SM9LDeUTz8X0S9h5+p3ftBQrWeswRt24kYogYLw+nHpd9KLtipJy+sHsFayIPNpzZx9qS9TwMTRygstlh3NcclW12P2vHbcXGkrWgsu8aQxwAxp0KqI9AFKhS3HobJQqzJNV/GFQWGGVv4rpTEfxKvZh/Ix+QcYvIEkd2b1j3hUQTildT36WnNZqGKkxlgJwTlF2in1dmhzwOA+Ln8tHSzXGb0cZs17o84YeKP7UJ/tz7t0o1W6P9j59/y29rgonwmD0RRFxFunlSQPta/VlHR2gDgYsj5CJK3acZpHq/+oH4JYmBNzpXbj1zP+qEXWpZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdYPercBaT7Qf2hnTkUnssGOH2P/FlCXYneRnIIagVs=;
 b=HhSBQwbUPPOLCSQCpRTTPv6h0TQ/0aahLo1e829FNMSnNSacxM4aWMNiyWbPqLTuUQfUuY6cGFyXBFQXybizePFWdBWjdLSWdh+D8Kw2M65IBRT3RZ/19b/BDrgLmXdyI1RRrGxj7vp9/oZ6MF+271yAVfgsO6n76PgE5uRtsVwDptOsG0emXiMnQRRmENH5svdzCtPRtJgwjjisgeUlqJ7+qj3qBFe+ZxTRnxH2ccNxQZMMcH+gH3itU9bo4AyYpuRY0l60QTmLNSFjkXcGuXsQeT98foTeW39B2Qe+y8Rwr6tIq6HHCgaM4rzLbeJHIAuzyTYUieF3rHTt2kXTcQ==
Received: from PH7P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::15)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 13:54:18 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::4e) by PH7P223CA0030.outlook.office365.com
 (2603:10b6:510:338::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Tue, 3 Sep 2024 13:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 13:54:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Sep 2024
 06:54:04 -0700
Received: from shredder.lan (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Sep 2024
 06:53:59 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 0/4] Unmask upper DSCP bits - part 3
Date: Tue, 3 Sep 2024 16:53:23 +0300
Message-ID: <20240903135327.2810535-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad06c92-d6cc-45cc-f923-08dccc1fe776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?erJm32GX15JjkbUA6cZkVc8fD/owhJePxSwvz9P7FcBs8gtakRd5OVoGHaAN?=
 =?us-ascii?Q?08xL98DYDThBAIx6+GcCUlUMZNcfrst3gfdURANoKhX+Xl3sYprrf86e4r9P?=
 =?us-ascii?Q?vg+Re5o4cUQKNXwPEj0Fn5w5uqywJ1A9A6wlTjnXvq3uQpjg18AOaQ54NWI1?=
 =?us-ascii?Q?NMTs4SigRN8N2/M0NJaGPwBdqXecSsJpYEiRL51z5O4YZdFmqdnyXvYyiCTo?=
 =?us-ascii?Q?lIRcBuZiG+bsm2QT4XNkKaydcIgzWwr/EkKtT5VvRymZ6/qeetZPF+/4PsUd?=
 =?us-ascii?Q?/FT3T5jJ4tGXLdtpwbgekWzg/T2hdudRavczSwyUYM1m6qf5NQ93cLNbuwLK?=
 =?us-ascii?Q?92pzraKJlNC1fHoJfeTJj6eS/agcOKT9p0s9Rn6mUXPhzcWsmC2bsr6p4NsY?=
 =?us-ascii?Q?0nNjArqm1OKaCABrW/pvLvVGIIS9zenkwQhfCD/FFaCyLFPMmbR31CLlUdxp?=
 =?us-ascii?Q?a+zFz8Z0DVAQey9+bUajmnHTKAj2D41WsnP5PKkfqTrAcbMdtbEOVOEsUonC?=
 =?us-ascii?Q?9lQyfmmEFS6QBOg9l3hLvyLNjICLGzV7mhE92mKIlfowM8iXl07gdg1LYq+1?=
 =?us-ascii?Q?NzhpWf+mJMtK0L+8sYUPmyfGx1O2pBEt4kD3e7nCOBZAtczKm9a6k53N98K+?=
 =?us-ascii?Q?92zWLJ4cAZHICav8EhERfJTxNmGzgWDVh7kyqSbelhJ/+sHnPhucF3Dvuw+7?=
 =?us-ascii?Q?v89VbvgesmQIVV+V0nKJv0lrN0gLEmP2scugxMUxjYDOM7IfiE0NjS7ZxGY7?=
 =?us-ascii?Q?QQHu6xRT7isDFtiLmo9oFBCC6R6Kfbur6CKKeDeizGjbTjKKT+ZT125acbNu?=
 =?us-ascii?Q?IilS0fq3SleaauXEWdYF7nnuZWajT67cGt0QSOCBb22RMjzMjiHHve0lLjBK?=
 =?us-ascii?Q?cuClXQJPRmQYGlYjFNUjw/0r2jwO0CBUYvznmAQwdhSFO+BGVBrcv2DaIElX?=
 =?us-ascii?Q?CTom+3SvgQFYfB6otMPPu9BfhegDO5hnT+FaegCX+JIvofxMryvy0z4NuSUg?=
 =?us-ascii?Q?dCuFJL7eVA7Btwbx56nUaalV02DPsVqOctCB196tTNXIewFT1bxoTe5uFEuH?=
 =?us-ascii?Q?DBtjKVfYJppqH5O2heu1C2BB3N51o2IfcDyeV/FakJYQfaeCY5Oaws7zhd3T?=
 =?us-ascii?Q?nnTrafkdpI0FcunpUKw0VJ2Yw1wXVpCipvb2e65lWfggWAwVjNKkqehzDlW0?=
 =?us-ascii?Q?6sj2YsQmiiqXKQSgADZ364I0BD+jZwZmQF8+epVfUP4ixesro368n88uhzvm?=
 =?us-ascii?Q?ttqHHkpYVFpzIkQrJ3L0SIsBfFGqzzUN/+6bnjm8BX3ObHOFvJzIiETL6p7y?=
 =?us-ascii?Q?BSTieQ1aNDt2KWTh4p4YywOv9Gm7/09cgvsUktN2AoybGSL98aABUpYI7iFs?=
 =?us-ascii?Q?/mCCcQAsm1gTxzupPRd+JmUPGhcWQAB6ohbWVy1kRvbvtoqi1tRWYiozVJSg?=
 =?us-ascii?Q?mFX0DA3wUiI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 13:54:17.8216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad06c92-d6cc-45cc-f923-08dccc1fe776
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416

tl;dr - This patchset continues to unmask the upper DSCP bits in the
IPv4 flow key in preparation for allowing IPv4 FIB rules to match on
DSCP. No functional changes are expected.

The TOS field in the IPv4 flow key ('flowi4_tos') is used during FIB
lookup to match against the TOS selector in FIB rules and routes.

It is currently impossible for user space to configure FIB rules that
match on the DSCP value as the upper DSCP bits are either masked in the
various call sites that initialize the IPv4 flow key or along the path
to the FIB core.

In preparation for adding a DSCP selector to IPv4 and IPv6 FIB rules, we
need to make sure the entire DSCP value is present in the IPv4 flow key.
This patchset continues to unmask the upper DSCP bits, but this time in
the output route path, specifically in the callers of
ip_route_output_ports().

The next patchset (last) will handle the callers of
ip_route_output_key(). Split from this patchset to avoid going over the
15 patches limit.

No functional changes are expected as commit 1fa3314c14c6 ("ipv4:
Centralize TOS matching") moved the masking of the upper DSCP bits to
the core where 'flowi4_tos' is matched against the TOS selector.

Ido Schimmel (4):
  ipv4: Unmask upper DSCP bits in __ip_queue_xmit()
  ipv4: ipmr: Unmask upper DSCP bits in ipmr_queue_xmit()
  ip6_tunnel: Unmask upper DSCP bits in ip4ip6_err()
  ipv6: sit: Unmask upper DSCP bits in ipip6_tunnel_bind_dev()

 net/ipv4/ip_output.c  | 2 +-
 net/ipv4/ipmr.c       | 4 ++--
 net/ipv6/ip6_tunnel.c | 7 +++++--
 net/ipv6/sit.c        | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.46.0


