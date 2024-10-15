Return-Path: <netdev+bounces-135577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0231899E40A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776B71F23A6C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7DD1F941A;
	Tue, 15 Oct 2024 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="fxN5Fh/n"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF4C1F8EFE
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988243; cv=fail; b=qHZVwKE0NfxysiG/SCpZdc9siob+RDVItG1OXbTvRUeLKBAq2dNQASqyRtqLEnDhikD1AR6pje6rxVlxkOxXC4oGX9JEEY8sntX2Wz/7MfYzFbEeFdKtlqC4I5xkV3F9oDczoM3kfFZfzAl8r+g51gn4XGXgDLgWRYhLw/CpLew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988243; c=relaxed/simple;
	bh=buziG2E0HjaEak+PtwFVhEJGklX0FQ65JKrQxi/7SPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8+WLyv3qtYNpvPY6s9WWDKoUl4SI8xCOj6nW9MLDv+dE08nubSKynd0D3oJdcG89TeqvSDw7cVzgxoFysHMFVBLgLMxq1u3j1fAuovFBWTraA6b9MgmWqLra9+hhQZh7+AP9JIGukTdzQy14BB7JjAkx9HH9GU0eJJO7Kcgpf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=fxN5Fh/n; arc=fail smtp.client-ip=40.107.20.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCWySYgDdzDwOTz6uwsugKly+PHTeFN4/cuYhX4AE9rU3dOfbBm1qn9nKUtJqRRdgYGvhVNCnCutbXccyAP+0/+sOkshribVjAS8Y375EPO6xpPzkZIo0wEtKnu9TMSulVy58Qkgrn/cturW18bAHUXHk4iq4/t+92GVakbqj7K4s31T20PFwN4Bo+V6klnY1k3Nuld9cm+DJ23N0Y92qVyezxnvJ1lOksZbMsSCXHykhY0YcpQh0nU1Eu56VgGtPKyj6nr29VdEk7rvzoS4i0QCUAMCZLX2rOSXL8HPHVcQmH8357l3GTIuON2brcWwMs419zi+zf2BJ8o046qJRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg6Tyz4T9SA9zigKqHYAXbwNGLtzApIb5Xyf5Mbx9zc=;
 b=F2sWGPIzmjjvulKQSKVNfusn8YvnzyGzThRZMDtZosywgyqjdJl3P23deTf3UtxQ6Z0D54HZoUM2LTFRYiG2orLDPQamywKSTo3gHQV6gg/TwHwvNFVnzCZ7Osna72sPeYl7fW5waYPFos0oDJbIidBN/T5jofxklYyTVv/3FmRjzWdhoT4PnkcgedKYnehh1FTa0H1BGGnBltaoPx1IRY3zeanr51A4elDlUjUk/ICI6cU6+khD8jIsc2ys/DjEXrq/38je9MsAs5UDw8AIXlb6g3fzzD4eUrmt93ZePUR/Hg3A/kdwzD04z4RYYqzGl5AnCHHqQRI44rv/T5Bbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg6Tyz4T9SA9zigKqHYAXbwNGLtzApIb5Xyf5Mbx9zc=;
 b=fxN5Fh/n7b1Ubolf3+sQVJ+9JjIy5W9ZNhDXGmaVrw51lQ/CO8rgc4/cGfT1NMTn6Ap00aK7knLDPxl7z0Tpmnni3qAmOA1kTduudzNQFv3ZF3GMCae6J6zMkm++2FkclSdDSLTmeMQcZrEJByC/mhDuCH/E/so0Uf8z9UNpJWcD5DaYFTnczTHn648DFwuTjIevVUM9sxW6K1Zy0wKm9kGQr2jOSgnzaW25WKCIrOumX73TssdFuB/tRwnuiDGwL6vXrsXRKBtG19+ej5KwRxCcaQdffHShg47zoJvegDBZU9WsJK48kqsxOSm3fdlRruzhG9hNTWct65KLmIn3tg==
Received: from AS4P191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::14)
 by GVXPR07MB10134.eurprd07.prod.outlook.com (2603:10a6:150:11f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 15 Oct
 2024 10:30:37 +0000
Received: from AMS0EPF00000195.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::e4) by AS4P191CA0001.outlook.office365.com
 (2603:10a6:20b:5d5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF00000195.mail.protection.outlook.com (10.167.16.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 15 Oct 2024 10:30:37 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnl029578;
	Tue, 15 Oct 2024 10:30:36 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 43/44] tcp: Add mss_cache_set_by_ca for CC algorithm to set MSS
Date: Tue, 15 Oct 2024 12:29:39 +0200
Message-Id: <20241015102940.26157-44-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000195:EE_|GVXPR07MB10134:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9dcae411-490b-45ba-818f-08dced0468d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A2skQ4lD2G72+z74UUcjMo5T4YpV73MyBqblZNE+U9DhRuHFfPf9QYi5qwde?=
 =?us-ascii?Q?PxW+2utQZBEybREeSvaysAMM2PDVqeJiF8TZWsCUMgkBcT50194zVlKUC5Vv?=
 =?us-ascii?Q?SvWIaCnxoYG4aDuY9aXTRwB+dOJQif+loGg1ZBJe6ed7ArHgCU6L8yiCgYyt?=
 =?us-ascii?Q?3P829AcTy6LiHNR1PZHawHxjHnhJ0yxbum3012nK4fjGk+yIpt84fDIkzs7F?=
 =?us-ascii?Q?jPj+nv8T+I4kUzowkoppXtL8DgvzKthphX1ZyWxHI6smSI0oGz2MR5/F8oV4?=
 =?us-ascii?Q?dWz2LZZEAGxvtlDVvSFRWBYglRQBxcCv6pgveBLGiIB2lAYg4sQ7NqFMGxkL?=
 =?us-ascii?Q?FGIDkvhMBUXonn0dZQ/BqMS7Q/Hj5WxH2/zXwCs1EsodMSzzX/phu2oeMpFn?=
 =?us-ascii?Q?8k6FucZCnBv9Yhj3AHIUYSd2nY0GXGfHMGesKRQ2s5CDgpTTdgyunq7+BRX9?=
 =?us-ascii?Q?r3zqQOoymbLM294Wn+ATqkIrUw8txMh92InPRm4e0I6UuTlusbK3xt4TkNYF?=
 =?us-ascii?Q?yoBNwyTRow1EBQM4HqQhdkz3EQfaqAlZoobOe7zxSZ0USaxr9z0eNUrWqudY?=
 =?us-ascii?Q?jzaecXsbuxfMOXZENfwmOdP9bPFej6XXzgOUx657YOF+bXS338NpGRElFH2s?=
 =?us-ascii?Q?mjm8ltK0VzPQpS8WIbYRbtDWyzye3LRPE49ROdBoeE8H0GzTtEWUar4Tgfe1?=
 =?us-ascii?Q?4rgXWmCjxFwtfR93ZRktygzyt0VswH4jxlI/s3ATzsMBdP1MCv/lTBI6Ye2F?=
 =?us-ascii?Q?UwzODpe/8yyckdlMYIS1G7M0NjQD2PwiQAHjf8ctWRr6mEyHbS1PFfFwFAsg?=
 =?us-ascii?Q?RGSgBMMClkMslhxS5LoveL9M3xVKsScuZe0v75gjgVq5zsCFc19EX2lAY5uP?=
 =?us-ascii?Q?TDq1IInRGHAwGEHDW9U44++GE0g1k2BNgbs6DAfoDHxZd4qC8y88JEp6YZ5p?=
 =?us-ascii?Q?tS7BzXkVeVERhvVhpgAk2d+wiqLAF3FXtOyOjWm9dl4DWy6TbeKX1a4S+0jb?=
 =?us-ascii?Q?oWBtzvZTvUjXjrgQhlaMKQw6TlnnnZDfaXY4LgKAd5i4eIwTB9Vz2BgAqzef?=
 =?us-ascii?Q?5L/OM2bQM1NvomVMBPB8vXcMU1GsXQOcl7IuwZVyNxm5WfjhpIqv6m8OJ/xu?=
 =?us-ascii?Q?ySyulMkPwYgMtC3CHzBue8Xqngnyq9hVMsYMvDScd/YUVeGmb/z3Zf5a+3XB?=
 =?us-ascii?Q?Lo+4uzcb8SI8XrCxNtL4K6YYdnrZ8vfMssRQvvCSscPyhq2JkRfIjOaKEVpO?=
 =?us-ascii?Q?G79qco7Nu2eN2AfVaZ/l0qt9A37rkzM7242N1l+j2uCzxiAh+WcAgf6HiOLh?=
 =?us-ascii?Q?mj7tCc4WohxRWSbqitB//p+tOQGmm/AXBTNfycTpLL9knaZ7ArbsdDYak3X2?=
 =?us-ascii?Q?VEFuOGorA5Y7E6cbLk+JjXBeV6+M?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:37.2952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dcae411-490b-45ba-818f-08dced0468d2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000195.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB10134

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Make the CC module set the mss_cache smaller than path mtu. This is useful
for a CC module that maintains an internal fractional cwnd less than 2 at
very low speed (<100kbps) and very low RTT (<1ms). In this case, the
minimum snd_cwnd for the stack remains at 2, but the CC module will limit
the pacing rate to ensure that its internal fractional cwnd takes effect.
Therefore, the CC algorithm can enable fine-grained control without
causing big rate saw-tooth and delay jitter.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h   | 3 ++-
 net/ipv4/tcp.c        | 1 +
 net/ipv4/tcp_output.c | 4 ++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index ecc9cfa7210f..add0da4dbedc 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -232,7 +232,8 @@ struct tcp_sock {
 		repair      : 1,
 		tcp_usec_ts : 1, /* TSval values in usec */
 		is_sack_reneg:1,    /* in recovery from loss with SACK reneg? */
-		is_cwnd_limited:1;/* forward progress limited by snd_cwnd? */
+		is_cwnd_limited:1,/* forward progress limited by snd_cwnd? */
+		mss_cache_set_by_ca:1;/* mss_cache set by CA */
 	__cacheline_group_end(tcp_sock_read_txrx);
 
 	/* RX read-mostly hotpath cache lines */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 16bf550a619b..13db4db1be55 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -456,6 +456,7 @@ void tcp_init_sock(struct sock *sk)
 	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	tp->snd_cwnd_clamp = ~0;
 	tp->mss_cache = TCP_MSS_DEFAULT;
+	tp->mss_cache_set_by_ca = false;
 
 	tp->reordering = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_reordering);
 	tcp_assign_congestion_control(sk);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0f0e79b42941..d84c3897e932 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2074,7 +2074,7 @@ unsigned int tcp_sync_mss(struct sock *sk, u32 pmtu)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	int mss_now;
 
-	if (icsk->icsk_mtup.search_high > pmtu)
+	if (icsk->icsk_mtup.search_high > pmtu && !tp->mss_cache_set_by_ca)
 		icsk->icsk_mtup.search_high = pmtu;
 
 	mss_now = tcp_mtu_to_mss(sk, pmtu);
@@ -2104,7 +2104,7 @@ unsigned int tcp_current_mss(struct sock *sk)
 
 	mss_now = tp->mss_cache;
 
-	if (dst) {
+	if (dst && !tp->mss_cache_set_by_ca) {
 		u32 mtu = dst_mtu(dst);
 		if (mtu != inet_csk(sk)->icsk_pmtu_cookie)
 			mss_now = tcp_sync_mss(sk, mtu);
-- 
2.34.1


