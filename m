Return-Path: <netdev+bounces-273149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPKuHwxqymnG8gUAu9opvQ
	(envelope-from <netdev+bounces-273149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:18:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F23C435AEA5
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 876E830073E4
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A1F3CA49E;
	Mon, 30 Mar 2026 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K5haupm7"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C226158B;
	Mon, 30 Mar 2026 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872724; cv=fail; b=JEOa9OKkRrTa9YrGbe/MNR7sRgmFvqc57hlgiiwKHerEhvwim/Ff2sHszMag86vrTSCv29gGdjQ5WAGfbj/kJLnz63z17zTmy6MX6TYuKdx++8ZMkJwiTqnB531tNvfejMacs1+HvAtCIbHx81lwKYrw8nboPi7qnpkTo4vFvZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872724; c=relaxed/simple;
	bh=Tj5XRuEXRP3Ptle2HfUzKCvGnKIgODEAxqzwi3fl/tQ=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=nbAeF1RnXbJG0ijtyWRZxMZmSWx0Tw8h3RApQmpuCrPMufh5AijjNPvn+/YhZCPr0HsJQNKoXaEulbhVFyqwkTHyHa3tu/0bMV2SxWjDs47b7YMq0GuoCZWJIbMTLzf7ur14CHBFecHueF6yR1fdrAmqLF91jco8yx1oKcGMqhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K5haupm7; arc=fail smtp.client-ip=40.107.209.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVeBft6CQelcksWm81ChhbaJloRl7Lb6nXJcFuCyo9A+Tmra6xdStZ11NHyiiRoePHfo1/DxsoD/4Ax45EJEl0oomVJk0HLI5OJMRdI4ufXUQ+qANE3FB/P6TUIRulpqtmeuK1Qu3om5/VkKrNPARQpSKW57+QTlDxpTmX1a9E4OOZGN0vd3HsabOjd7iS//4nwOSlwnipwGJtBFdiIe48SYwvbCvBcpfVgwWTcw6XgN0AW3Nr+pEUJVVG0sLIwVykkooghVY3k12RyIuXM2lKj1xLDwFossss/DuPq4lF/fEL/GjFBM4nwmkB4OLfnVSwMNr3KHa/KhWQcbUzbDqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+Y6sQwXwlhS8xhnLt4GK8QARazoSTbQ1gBM8PYsIZQ=;
 b=bSiD+X9282pnctbc0tAbTuN5jUUiRl7N9+5kKIxmPU8h9T7bUgdzKfDG3FkkghH2OtJ+6EZy4ZC/ETkVZ2SeSqUQZUnd4kDOmQVGHsG3888yEhapFgRtYT9sELXBe//MSm1qbtcSsXoZoYou/i0ZLXhCnRXYMv3qJDg93nJUvg3IgUS7Ygzd6bQBMByw78s6tZbVoWjYADbu9by3mBz/Vkf02z/3Aij/RVC6S2xeDbwU1/UL9avKkXopbojJaFq2wOayHZskY30Bzn0DqtylXsszRJ/JY9i4J4wa3CaPPcjkitHok692HIwXt4fMlCJKcimqAgWHZmEs4Od0KVbIng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+Y6sQwXwlhS8xhnLt4GK8QARazoSTbQ1gBM8PYsIZQ=;
 b=K5haupm7gZlqtt10gFATeBZ4NPGcONo+IXk0hso97ymFaYN/wa/U5UQ03Pwzn1Kc1s4XPvIP99AWuNyAvpXwJ8EmXiWHIOpGCw9Q3EKY41/eI4gectNIJIMqvCl1KtR37LMFSwcyq8dEb7hkOdnZkKWmcWKhmjVp2vUn3vxkzN0b3B2yMR38Ln1A+2hILnx+8kpLDpRN7shhBKNiH2E5w/DOFkLY8Te8DlcgUWZ3a7ahcpO5fb01beWiTv/IE1kFbr451gPlKBOCUzoCVylWnUI2DZzql5214nzjPylPIdH+7bR50fo67GnA3av6MX4q3AeDUbCpnTXsz5zcJ9QtuA==
Received: from BY3PR10CA0004.namprd10.prod.outlook.com (2603:10b6:a03:255::9)
 by CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 12:11:57 +0000
Received: from CO1PEPF00012E7E.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::8) by BY3PR10CA0004.outlook.office365.com
 (2603:10b6:a03:255::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 12:11:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E7E.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 12:11:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 05:11:41 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 05:11:35 -0700
References: <20260326132828.805703-1-ioana.ciornei@nxp.com>
 <20260326132828.805703-11-ioana.ciornei@nxp.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>,
	<willemb@google.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v4 10/10] selftests: drivers: hw: add test for
 the ethtool standard counters
Date: Mon, 30 Mar 2026 14:03:35 +0200
In-Reply-To: <20260326132828.805703-11-ioana.ciornei@nxp.com>
Message-ID: <87bjg54ivh.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7E:EE_|CY5PR12MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: 89368ff2-f862-42bf-1354-08de8e5589b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	trUewd3m6K1At0VV4U2THDU0xgpqy3xd7+9oVXt7Ms7Mvx1PscN7S9yZ3CCvIVqsNEzacIBQx4w1GhmtJNcOaunZgy+Ps+mfAJFtVsvfb4SU7Pi8fbku1AM67IDbX1xKqkefXJ4B+vACMXpXBDuRoXulw+0dshG/AGLtkcyPx0HjqEpVdP8QHt/Sw97Zyt1M0yC8Iu3wCzhcrgDWcr4YfytxsmXMDSLDkeYYxtYpxpJtt9yQUC83l8Y4z/GNQP5T5csyTmSig8SU8s1cckpEMjWiluan/bKt1T/Z34NqL4iKBwwRDYQQ2YbRwz1LPxLvX86f4shHo9IZcFiaazYm/yHLjfUlrI4zveW/FKv40cGn+vnlEb62k3q2JCRrxD5StECbEGsJPWmBkfKdfyrCAJXH5hS3eRHMw7oxtzRPL1zRJdsJChQPeA/jt28a276YLxP5liPNaTrbXS4ULbyq8AcyLCuWTMyqsmc+FGLN9En5j4vkKfNAP3K9HJsyX6OE/vyfY4JbdNElo2rix32kfbOIJjDycEL3EyhKCQ2Z3CGtnb2lmZwoMHL1O34yseZpHf8IykFBJti8V9vL9kML0uUjrzxIXNlpY9F6wzZh32yqnTOZWEUDk1CqI0mBb+XOWLPwCwrtOYN4Y17kDe8AOt9mk+vA/WhORrRBBTHsPRdBDR/Cg7C0A7C0Da0iP7+60RRMfMHYvHhq8WbG2YSb9DvZ39SryjvpPTvafuLFS1dQJWA0zqDN7QopqcA+xNK3ZtPVRqiYcCh89cXe+tU+1Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fMLRqMVC5qPYb2u14dxUKqJeYcgkW8QsBLHjoVwwwihrG5s/VlVhX5kJgO8HP5iXzw6XeMU/PzTrkp/rA/+qEeEM8sUsCC4IGudMIRHyP8ZJ0uhmz4T9LCTg0mNf7vm/D4srwLgHdAkcCT02euLseJvINBx9B7HuF2EBpcPotoSCMVM6A4L7dxOHu2I0k4/6HIZBOJI+i2B9KJGkuFkIPzkXyZcwxDe7KJMOG5tJd2vAINYeyMOpaNcVUB5VS4wUKLttu0+drj2uSAaWvmx2HHyA2UR4O9XYL1R2fTv1AO32Daf3J3PO2xKCHn99eZx09ckVvmogJAKJyg20Lv7C8tBMFnniq5uFfK873ITUdqR4lN/Rb6CFvpRrVQOSRT9DtQ/4ft+T0mHIyfB4mVfsUlYYTM4r1nulvcH7kMl1txXhyn6shh6SLpUdVNdxvaJR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:11:56.5996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89368ff2-f862-42bf-1354-08de8e5589b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6549
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273149-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ethtool_std_stats.sh:url];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: F23C435AEA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Ioana Ciornei <ioana.ciornei@nxp.com> writes:

> Add a new selftest - ethtool_std_stats.sh - which validates the
> eth-ctrl, eth-mac and pause standard statistics exported by an
> interface. Collision related eth-mac counters as well as the error ones
> will be checked against zero since that is the most likely correct
> scenario.
>
> The central part of this patch is the traffic_test() function which
> gathers the 'before' counter values, sends a batch of traffic and then
> interrogates again the same counters in order to determine if the delta
> is on target. The function receives an array through which the caller
> can request what counters to be interrogated and, for each of them, what
> is their target delta value.
>
> The output from this selftest looks as follows on a LX2160ARDB board:
>
>  $ ./run_kselftest.sh -t drivers/net/hw:ethtool_std_stats.sh
>  TAP version 13
>  1..1
>  # timeout set to 0
>  # selftests: drivers/net/hw: ethtool_std_stats.sh
>  # TAP version 13
>  # 1..26
>  # ok 1 ethtool_std_stats.eth-ctrl-MACControlFramesTransmitted
>  # ok 2 ethtool_std_stats.eth-ctrl-MACControlFramesReceived
>  # ok 3 ethtool_std_stats.eth-mac-FrameCheckSequenceErrors
>  # ok 4 ethtool_std_stats.eth-mac-AlignmentErrors
>  # ok 5 ethtool_std_stats.eth-mac-FramesLostDueToIntMACXmitError
>  # ok 6 ethtool_std_stats.eth-mac-CarrierSenseErrors # SKIP
>  # ok 7 ethtool_std_stats.eth-mac-FramesLostDueToIntMACRcvError
>  # ok 8 ethtool_std_stats.eth-mac-InRangeLengthErrors # SKIP
>  # ok 9 ethtool_std_stats.eth-mac-OutOfRangeLengthField # SKIP
>  # ok 10 ethtool_std_stats.eth-mac-FrameTooLongErrors # SKIP
>  # ok 11 ethtool_std_stats.eth-mac-FramesAbortedDueToXSColls # SKIP
>  # ok 12 ethtool_std_stats.eth-mac-SingleCollisionFrames # SKIP
>  # ok 13 ethtool_std_stats.eth-mac-MultipleCollisionFrames # SKIP
>  # ok 14 ethtool_std_stats.eth-mac-FramesWithDeferredXmissions # SKIP
>  # ok 15 ethtool_std_stats.eth-mac-LateCollisions # SKIP
>  # ok 16 ethtool_std_stats.eth-mac-FramesWithExcessiveDeferral # SKIP
>  # ok 17 ethtool_std_stats.eth-mac-BroadcastFramesXmittedOK
>  # ok 18 ethtool_std_stats.eth-mac-OctetsTransmittedOK
>  # ok 19 ethtool_std_stats.eth-mac-BroadcastFramesReceivedOK
>  # ok 20 ethtool_std_stats.eth-mac-OctetsReceivedOK
>  # ok 21 ethtool_std_stats.eth-mac-FramesTransmittedOK
>  # ok 22 ethtool_std_stats.eth-mac-MulticastFramesXmittedOK
>  # ok 23 ethtool_std_stats.eth-mac-FramesReceivedOK
>  # ok 24 ethtool_std_stats.eth-mac-MulticastFramesReceivedOK
>  # ok 25 ethtool_std_stats.pause-tx_pause_frames
>  # ok 26 ethtool_std_stats.pause-rx_pause_frames
>  # # 10 skipped test(s) detected.  Consider enabling relevant config options to improve coverage.
>  # # Totals: pass:16 fail:0 xfail:0 xpass:0 skip:10 error:0
>  ok 1 selftests: drivers/net/hw: ethtool_std_stats.sh
>
> Please note that not all MACs are counting the software injected pause
> frames as real Tx pause. For example, on a LS1028ARDB the selftest
> output will reflect the fact that neither the ENETC MAC, nor the Felix
> switch MAC are able to detect Tx pause frames injected by software.
>
>  $ ./run_kselftest.sh -t drivers/net/hw:ethtool_std_stats.sh
>  (...)
>  # # software sent pause frames not detected
>  # ok 25 ethtool_std_stats.pause-tx_pause_frames # XFAIL
>  # ok 26 ethtool_std_stats.pause-rx_pause_frames
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

I didn't go into details much, but the code looks broadly correct.

Acked-by: Petr Machata <petrm@nvidia.com>

