Return-Path: <netdev+bounces-268114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJBeLergt2mcWAEAu9opvQ
	(envelope-from <netdev+bounces-268114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:52:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13908298412
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 272833046ABE
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7527B3909B1;
	Mon, 16 Mar 2026 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L6ospCvs"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCB6372ED7;
	Mon, 16 Mar 2026 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658175; cv=fail; b=tWs59a49UX42U9ArrQ0rGcalhBX34IowG1KdJ8SMPyV3V7wXTLocYZ3Bz9xl4SY3wJAC/4tPj+K7NW0OVCo6EiqrNS0FwhyFgYLgNR4sq0rSmdTG9cKQlLebgRJiizIM5FA5yDH9csoJCGU55rlPoMdjAnO7Fh9tZqERGtPKuQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658175; c=relaxed/simple;
	bh=xScQocWwUTo3g856MgeOWXj0yNnZyDhGzwFSpj/jxXA=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KSwV0XyaOgty/lKrinNECxpjwzMiB4EneBshEFBr5GxVoDwW2f5IxKBa9pLY2rp0+5N2H0xMiSvdwnwuCC+2UvfOR/cvavUX+KyIwFgVmw4/i/EvSpCpEFVLaRbpkQUg8hBG2T09ZQKe70C0I0x50XIqDYnTRIMKo69ef7IR7lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L6ospCvs; arc=fail smtp.client-ip=52.101.61.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bktd/B+1q0hyGYOOYgRNlv4hbcjtxpH0TzIognORrLL0vz9iZOpb53Yq8KyI/gUNLgsnqQnvFbvlFXtdArWmRuhqNAJ29RcgRN/6uvEr5mekXGxkg6ZNPNsYztSpn9pnsK7nfu3wlA5dlxdLfpaw+bv/ERVgextROn2q2ECu0IUfK2CpiTHuCb/IBiXykKBXfyc+Gv+xWHn8UGjX9BKRiu1xQ9U6QpYxwF2GlWpiwmnZxl2Qdu0+/fW2yLFOykJJfAamzFz39ZDjK24UxfNEXkI7Mfm4kwnDfuqoBS5OIv4B0Kt1Nz5v3vYegxA8wkKOi8v9LLceiIoXbJSr3Qhsug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdPrAva5GtBuiPJl36ysVe8bqHTx8pJ8OLDVhca3+p0=;
 b=vTXutYN5DpQ0to01mPduCr0ebFXZ52QLCJ0HwFcQly4YQmH4DgxS3+0XLJpyiWLXS3KZ6IPcXwc1gwqR5V6KT/Xi48d0IpeZXXldPRwNOHeuZ0yIzSKozSvOx6/FHl5wcQvkIagGIWD9Rjwx3xLuv48Mi4ZYOtpvlO9MBxkTbjmLPY37F3nEMBtMg0ZZouRH+AiAdpBlrMZBbdtj0YlzcYdpB2OC+4FpmIt3SrEUjXkvCJub0GGV/ckUxDVTdKIjNIdq6ckM9BUEa8o9PrJq3A4Lf/FALwXh5SCIQtIjFxp83yNQT9kHMB5PNo+AzjD46C7JzJkuKNYmnxpSIEAIjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdPrAva5GtBuiPJl36ysVe8bqHTx8pJ8OLDVhca3+p0=;
 b=L6ospCvsRK3Cgv8IUCLmyyBQFYHJBpAakOyC8kNMGlpJd/0MmuLC+7W9c5BMxxMuyzQ3lSjqXIjBdJI9CoSPV6oAJ7kwT6IPlJMnd2s7Ch4BUtab4jfDJhPGxAhkve/Y2DhLsIiGsOVXhxQ4arbCkeTskTe02SNSWgHutCsSK/3e973kE2Lc7WVFcgX7Ctx3jm5ujHRpQqd/QDSy1+yQ3FOMRZSbeDiej0Cd+TX6H4rexFzfi7NMfD5s/p/penldtOAaqVlMXWOaunquI4FriDqMJua/6koTjKcVA4IM2ih+X4W35d+lFNjt2R1X7iRodmfdAUQ6aEnV97yP4pXvow==
Received: from PH7P220CA0049.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::16)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Mon, 16 Mar
 2026 10:49:29 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::70) by PH7P220CA0049.outlook.office365.com
 (2603:10b6:510:32b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.22 via Frontend Transport; Mon,
 16 Mar 2026 10:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 10:49:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 03:49:02 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 03:48:57 -0700
References: <20260315160038.3187730-1-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <petrm@nvidia.com>, <leitao@debian.org>,
	<noren@nvidia.com>, <gal@nvidia.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: py: give bpftrace more time to
 start
Date: Mon, 16 Mar 2026 10:33:02 +0100
In-Reply-To: <20260315160038.3187730-1-kuba@kernel.org>
Message-ID: <87eclkcane.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: c61ef5ee-a680-47d2-c207-08de8349b2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lA0htUrEu05rBrgGk207jykuq5NrseKgeTbBHNgiN9Rl5jPv58LV8/TB6Gku/OS34qNjSmkmlmaNQUim6g2jcC90kLUe0XWoAAQGMiIJAFTHtcUPtfJprtSAIeFpPBx7EeAkJ9iZ1gW1rsfPKnbGqOvexKnZ0/tmrJuQXro5DOaVmTj+2nHJdcIHX/kVsoll9Ad92HC6FzM2aSgvw7omxpvekT7EwkOKDAP8ynln4sWEfZtqTfo7X8EeMb8mfXmXI9MfYL8WytEdoSW0PCP6vuN3CXLv8Vf5oEsKdPbax7yH6iNkVc47VK/HVk5lDA3fMlZQPZSKGooiXw5mR3KUkY4X4gTP3upCNZHoGM96kl5wAcpD8z6Ky7d9Ph6NBBO6AR2bhkXOm704bmvA+j649eAC95YSYElu8KOsSsUFlC5sdUpaaZUQF3hXBk4rfmu1zPZUhE/UkXutsZvpcY0KUYIUmqOjSBiZTVwVjsXMvPCVxMafUg0DCYq83PcVRJjTITwnAF4yCqQQk0pK05f+91d+2HgV+Z/ncKMfzNtw44sPA0L3Ukf4jNHBPnNTC+iOW3c+c5cPWEpz5Gpt3pD2ANsZswTcl78MjfA6CMMnfUSD4PdxzBHjVIHfxxgmgVIRko36mILNGM6dQ30Q86nFGcGkjxTHavuqYVAr3g07pA5uuU4Eyyhi7zTVQGtSRCMmSBOAy2MwHcCoe77MGEcXqa0ejVeMBSvbeTL/774ZcTNZ/j8/jx61MfUaiItEl53fVvLUsbwfExWhQXk8bqakvQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JeGCHpijCjjz/gdRDcHb6TeDucFYLYzi3kTklcQDnva8ZvgYLSOT0kvjE3peURTgRc6Fe2ESqQgu43scU31FDXmeTqgSqz3wSH5TRJt3Wf3JP732QW/x1zYbwO5hoyVDdAYxxttm//H0Us9/YzF/T3uOa5YfNU9bO/Is0fnw0Zqx7fQ9EigBAeKXq6vS9iSb3+RJLjd185Ft3aOZ9LB5Rc3kHGBY4xWyMbarPrj7U4FE0dOdI9FBbJi6vubxy9jOg3Bc8+FUv1tvOeXejuDe7Xfs+L36hCUzivkuRAN4GX33T+4f9fbxI6uJ9rPM/1+4z/Rl7RiDaOz0XQ67oA7fWv0o8e4q3x5r+ZJdnNVcL3CAKPYXuzS2ue1IwiKcjutsqz8/G/o1/F9oeMLBjp6GWaDP1fLoTzRXlIac1sYLLI+IddsFdTyRcqCaDk8Kr+yX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 10:49:28.4336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c61ef5ee-a680-47d2-c207-08de8349b2a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268114-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,netpoll_basic.py:url,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 13908298412
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Jakub Kicinski <kuba@kernel.org> writes:

> After commit under Fixes debug runners in the CI hit the following:
>
>   # subprocess.TimeoutExpired: Command '['bpftrace', '-f', 'json', '-q', '-e', 'kprobe:netpoll_poll_dev { @hits = count(); } interval:s:10 { exit(); }']' timed out after 15 seconds
>   # # Exception| net.lib.py.ksft.KsftFailEx: bpftrace failed to run!?: {}
>
> in netpoll_basic.py >10% of the time. Let's give bpftool more time
> to start, it can take a while on a debug kernel.
>
> Fixes: 82562972b854 ("selftests: net: pass bpftrace timeout to cmd()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

