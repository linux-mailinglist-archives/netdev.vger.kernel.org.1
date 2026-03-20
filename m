Return-Path: <netdev+bounces-269901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE0QOrQyvWmI7QIAu9opvQ
	(envelope-from <netdev+bounces-269901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:42:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D962D9BDC
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 12:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E74F3300F129
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 11:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F475377004;
	Fri, 20 Mar 2026 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mvT+oVnu"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AED35DA6B;
	Fri, 20 Mar 2026 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006962; cv=fail; b=ZvnzRj3W90l4Agg5QwuEqqnZ/FdTd+8laFoBeWuOXmTTiUkhRLHGWUdCU6t3FUC01DdO55xe7uyhF6bJdxFBNo0HpSRGLPn4gvrbAgyCtGDu4CFvBO2li/VEoFv8D8z3Xd2BDSl/Wzw+OdMVuS4zYXgz9F4qq0RTW0h0E7Viau8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006962; c=relaxed/simple;
	bh=Z+/CuEexggr1VTj8P3I090I8kCDDLFvleFOGIEiI8Xg=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=BaEae9lPTJOBtD+xFSTkPAXd6ctxkCErrxkdpNMsjOvgR2rIJsQjvIdi9nEmZXbTQ3/Fs40lAd1vN8Z2OMRBb+kBIyLXYmJARqETVw0uEB/hLaRl2m89omcuyUWtGKmeQmseAMD5rwkHJ2zihyKixJNUAPQCoIaqriuLp5pqwAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mvT+oVnu; arc=fail smtp.client-ip=52.101.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVgxVIUNhZJ8BaRPEdRl43uYmTBpffk6xD0L83iO66Xw14TYY9ajDsodz+KyhUbgjBzbAF5LgfadGtY+2pkjLoK4nP5dJxqCw96kL803Z6RnAQqzLpeDv+2jnn7NXoGf2VCYHoMMGTwO2uNK2gIcHPLHBhzcklsk0XijWYvEyCcFxyAGqU0dqHdTmOyMnNNEqZoj4oMJB8btPlMS17yRarTLMOSVSJzLTIC7avSx7+pmQeKkswVf5Mviz+b+tkwynw/x2sNmJN4rA66BFsa/R/UQfBaZa5kExa8f8ZSqqavGCCksNQKZ0EePZND/IKNjVmjV410tV/7W/9MPdtitLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5neJfHpQGT5tsEvBci58aE9dvKCwP3M+VkTfnHTYEMo=;
 b=ucU5Xfnowrr6xuazgI+yuaMQ3G7M5fd30LUD+hKcm1+SWCGLilvzV5kI3dX6VIdQElubuLXIZd8GpDpNq9IQydacmTIV5k5gRt2BObwQHodQL9vHyCLL/qmdJ31UR01OYKqVt62W+fGLoEaRo0A7r1svjjf2FBniNRZY+yWzPM2qda/Jv1L1FajMPGNss3xJuVF6+K7SiKNLGlJJDTlcdtGhhvvLc8Ch2V+AVPNzcJBxcPlmQexhPK7BTYrDNYsk/d6GN770QqiduwaGaJLi7fS6eJGkvlPP3YR40TsN9WSTOrgahbQHgerGgKWuCfaX3p4FariPwhvwoDi0yZ9TuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5neJfHpQGT5tsEvBci58aE9dvKCwP3M+VkTfnHTYEMo=;
 b=mvT+oVnuXT/XFO0zJEvG6i2XxxKMcEwqj/7NYMbYVjlEcT3e6KtX3plxDkwZWDHfJzpM0SavLS9a5/DuEz0E5b6Y/8l0Wl+AJSMGZLmT3hpeaBWqoDzDqDlZJxbmrk+Ho/1ZURbDLv9404C+lqdfy3J5Ff1Ue7bhpCAI6D/qhKWnISv5YDY/W5nTIAvhvSFivvdKfrbo7ld6B4/sZRZKY984tnAd0nlzdciX8Le64Y7Rq+nPbbQLiZyx9+zCEEYBdYWnC/r6bQfpZF0xPP5NQ6+ePsncJQKrx7doIkMDRc3Qpjpg0sS+zj/yiCUqyiIctFgNKIbpwgq4UZqZt9svAA==
Received: from SJ0PR05CA0146.namprd05.prod.outlook.com (2603:10b6:a03:33d::31)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.15; Fri, 20 Mar 2026 11:42:32 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::1d) by SJ0PR05CA0146.outlook.office365.com
 (2603:10b6:a03:33d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.21 via Frontend Transport; Fri,
 20 Mar 2026 11:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 11:42:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:42:17 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 04:42:12 -0700
References: <20260319160410.2515105-1-ioana.ciornei@nxp.com>
 <20260319160410.2515105-10-ioana.ciornei@nxp.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <petrm@nvidia.com>,
	<willemb@google.com>
Subject: Re: [PATCH net-next v3 9/9] selftests: drivers: hw: add test for
 the ethtool standard counters
Date: Fri, 20 Mar 2026 12:41:23 +0100
In-Reply-To: <20260319160410.2515105-10-ioana.ciornei@nxp.com>
Message-ID: <87zf427mnl.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: acf4f9a3-8161-4356-f53a-08de8675c5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lPdGa61aqwY88Dp7YFBTad4mVV+TitAG2lb1MM9ZmTiiOLoHcJlbED1wHwFGDU+aBgjqYX8st+ux6qGIY+IQTYdvlefDD5tXmnB+lXxWxkmkIWyT74ZmxsOede2pR3qD4nOqItkXSa1mBsAWsCM9tzmlhYjnetkKT1+HRg34+r+b5jzZZgmu5lCIFO0XB9n/umxTsXIoyTtMK+pPoFJVHC4y7HeFwvdF/xpFTuyYkvk84eQPFk4UkNLixhEf9h4uXaDcjrILZroxpV7eJneUmfTdnB2O/bidpO/mIt5n2tmm0nNp6/TnIHZ/vzKKOfNKMf/I357rW8uFPQbjRR/zKJBEjMBzT8tyXCkdg7ji/o5a9k2KlyaFFxqvW5mtXdrG/VNtwr0LYR4DEp2hZPNjsQsR/dNhIGiyDUJpXMWqX3nknJi40STQ10rrWD5WsMX96wMrOmLXSdkM4ErXGVE6UW1OtHKqszDbW6CxhwFHBbtiier9jFfnEt/SeCzPtxF75Ir9dQSkRuTAHXdGiV5vZwsht+o8ZqqdfMv/A9VDU1eYVSsr+NhNLyDIKhC7OIaVGqDxIPIGtjziIgHEjkrGXteH05soCF7nym70F5cR+v750peFpwxPMTEllPPDNcxBnzlojJH7GEh/X/Tgq0siJckj3+FSKxIaT5KsbsVvEpJBgTXD7subI72znsiBfcFAvBn5qEh2anhbcYHoNPsDelnBdMsJj1fbkSFmkVMxIqKwUw224gSwwicTje75Rjz/9UK/mEJzVxZG3RkNMnc/OQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kyTZjUs224tltXtcG6qD92xcR8eJneEXPQeVKRj9toHfiBY1o227j0IjDVPx0QRSALiyTa1XgaWsV1wHAuP1ipt+iVVPBxegoZ3VOIzPGOyFkCNmXgcDwqsYwCyu5rzCaQUOkBlYUH24BWCDIa1B91Rp/c0+itos57T/NMR2Ju4y0WzNawW2zsXane8WpAZCXi4Pz4zmwDzv/2i5SydEn+8BAoo9n6e9SqZEHx8zj9oCq8Arq08AEsRn33WFFYtgGTKjFGmKIgkHC/llgcS2T59aCm/RoOH2b39OcUC/suKwe4tOqCsb7aVflnjmsSNQmticbJnVeAXc3dBYixsf4gCcqgZxJEhS/cB//a/nmL/6z4aKmNgixz7HoE6JulU8OoG0EY0TE4XUHDFgsbzbyd4m2aqZG/GLsOGqzmJlQpp4L9TLVPlLqC0toiAMLHHP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 11:42:31.7729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acf4f9a3-8161-4356-f53a-08de8675c5ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269901-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.938];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 88D962D9BDC
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
>  # TEST: eth-ctrl-MACControlFramesTransmitted on endpmac17             [ OK ]
>  # TEST: eth-ctrl-MACControlFramesReceived on endpmac17                [ OK ]
>  # TEST: eth-mac-FrameCheckSequenceErrors on endpmac17                 [ OK ]
>  # TEST: eth-mac-AlignmentErrors on endpmac17                          [ OK ]
>  # TEST: eth-mac-FramesLostDueToIntMACXmitError on endpmac17           [ OK ]
>  # TEST: eth-mac-CarrierSenseErrors on endpmac17 (not supported)       [SKIP]
>  # TEST: eth-mac-FramesLostDueToIntMACRcvError on endpmac17            [ OK ]
>  # TEST: eth-mac-InRangeLengthErrors on endpmac17 (not supported)      [SKIP]
>  # TEST: eth-mac-OutOfRangeLengthField on endpmac17 (not supported)    [SKIP]
>  # TEST: eth-mac-FrameTooLongErrors on endpmac17 (not supported)       [SKIP]
>  # TEST: eth-mac-FramesAbortedDueToXSColls on endpmac17 (not supported)  [SKIP]
>  # TEST: eth-mac-SingleCollisionFrames on endpmac17 (not supported)    [SKIP]
>  # TEST: eth-mac-MultipleCollisionFrames on endpmac17 (not supported)  [SKIP]
>  # TEST: eth-mac-FramesWithDeferredXmissions on endpmac17 (not supported)  [SKIP]
>  # TEST: eth-mac-LateCollisions on endpmac17 (not supported)           [SKIP]
>  # TEST: eth-mac-FramesWithExcessiveDeferral on endpmac17 (not supported)  [SKIP]
>  # TEST: eth-mac-BroadcastFramesXmittedOK on endpmac17                 [ OK ]
>  # TEST: eth-mac-OctetsTransmittedOK on endpmac17                      [ OK ]
>  # TEST: eth-mac-BroadcastFramesReceivedOK on endpmac17                [ OK ]
>  # TEST: eth-mac-OctetsReceivedOK on endpmac17                         [ OK ]
>  # TEST: eth-mac-FramesTransmittedOK on endpmac17                      [ OK ]
>  # TEST: eth-mac-MulticastFramesXmittedOK on endpmac17                 [ OK ]
>  # TEST: eth-mac-FramesReceivedOK on endpmac17                         [ OK ]
>  # TEST: eth-mac-MulticastFramesReceivedOK on endpmac17                [ OK ]
>  # TEST: pause-tx_pause_frames on endpmac17                            [ OK ]
>  # TEST: pause-rx_pause_frames on endpmac17                            [ OK ]
>  ok 1 selftests: drivers/net/hw: ethtool_std_stats.sh # SKIP
>
> Please note that not all MACs are counting the software injected pause
> frames as real Tx pause. For example, on a LS1028ARDB the selftest
> output will reflect the fact that neither the ENETC MAC, nor the Felix
> switch MAC are able to detect Tx pause frames injected by software.
>
>  $ ./run_kselftest.sh -t drivers/net/hw:ethtool_std_stats.sh
>  (...)
>  # TEST: pause-tx_pause_frames on eno0 (software sent pause frames not detected)  [XFAIL]
>  # TEST: pause-rx_pause_frames on eno0                                 [ OK ]
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Acked-by: Petr Machata <petrm@nvidia.com>

