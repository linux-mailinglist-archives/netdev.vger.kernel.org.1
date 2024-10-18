Return-Path: <netdev+bounces-136823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB589A32AA
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAE51C2094B
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0398F176AB5;
	Fri, 18 Oct 2024 02:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Ly8sp8P5"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F174174EE4
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218137; cv=fail; b=lJe366BPqRQ/3OHtDmhb9/kSmbhotvnDyIZd5kQrlS0OU2HmIbz3TPEBPj2kGx9TnIjLsHd5171LoKzS2RaPFroBvuVUMmE8wr/sWDmFfJa9HnS03Lnm2QG+jponBo95PcS774r5Il2lBfVl0PdgjvxzdtXBln4l/ALk4JZMpbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218137; c=relaxed/simple;
	bh=Hj0kpmxspiVLJX8wpFuphNG9SkyVLpob5NDj2PecjNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trvPjyRGDVr6mLU2RpGdyyiENMPvIZdKNiDEy2k8GzmYZlV0XWTEsXIzf1ZMtd7+hsNQ8QNv92NTgNRIJ2+NecUY+KHYsbkhi2r7TrNa1PzXVhG2fXd4+WPAlQL89yMTXZKNY+tEx+FmUfRDfnGQpG7ipqi2a4n2rUxMGUJm/HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Ly8sp8P5; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyAyzzkI1t7FpLkk1+mKY94Nu+ZsO2hYVsi/iE6QUTF9CEIrfj42vzmsGkpqGjs5kyS2QEGv6YC/xqi6jl331SNOCUGrjp9Nio1rhk6YR3MDSinJw2Lmuiz2/eK4hnC3FwhkQyw085stzf0WufisVs+Qo9ZsXa6HHlK5C7Ut/1gwRXNqkb74CAiHoOMlDRSueacGJHVVYcq1TIYPohYfywP6bSInkpJUy3MtcOf/yWo9sgOssM8XPFPnK9QIJBqo5xCPOGK01UCYVderaV0stbID+d7fDs8hAYYcfTS0Q3RsmYOl29xj+3rIARVLr96eG5PMIgAGS1jh4dMZS7kW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXl+jkY6ong5Phsy59TTE3OHZvwQGTrSsZW9TS0xUyw=;
 b=PF5ZUMG4cdsbSnFB/jFQ8rTf0xzbsBJBAsASvZEyFHsM3jdljyy2y23nk/GmLFnmMgxrAkQBRvQhyWxxYf6X58TuwC6qysOWbrZv9f4otrQ2DfZhWjloBSCz8ebbA0qEXejrLfIrj1ewXJZ2D4nHw9Zu4fRGuUKd67MYye6qQdleqwvJzQyDoRmV22lqh1YI5oPur9OH1FMGnEvwb77Ev+oPejDmnj5iawX0Y6WXPOhLXwEc6I5WqU1r5QXYbXrguX2RzNBX57Sxzn38HEpsfsh0dtT7JTRFBTeXitZgwTOjPSqfDNPfHvlWVlNyIh5hNzGc2SxUemQcBYk7H2jMYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXl+jkY6ong5Phsy59TTE3OHZvwQGTrSsZW9TS0xUyw=;
 b=Ly8sp8P53icA7smTsUFT5w7Oaimoz3l+dbUnnhm3E2zNKJl95L4fTKzIjPlsz25eeojsjshfRgyBbqQ1kUHQBU3FQHtnuLVO+2Hcs5N43GieOT/mSXAVMTaCfhQIeN7zcrhs3eYQnSwUsIVu7xz1BgxyZliFxnakxjig35Sy6qKVAxsrkcnuhiuFSliqA7BPp+0/zrTP36ihcXZzEAjTtuf/4eDGR7TvzzCNp1DvKNF7iMlB+Oez7yKmHjVBxR6V2nAz8JIqcNnGG+PTk1YcMKrvXa16geoecNQk13z741ONQ9brxpdxI8E7HCmFseMSgBHotxfnkFUMO+FnrLNSgQ==
Received: from AS4P190CA0052.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::24)
 by AS8PR07MB7224.eurprd07.prod.outlook.com (2603:10a6:20b:256::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 02:22:12 +0000
Received: from AM2PEPF0001C710.eurprd05.prod.outlook.com
 (2603:10a6:20b:656:cafe::fe) by AS4P190CA0052.outlook.office365.com
 (2603:10a6:20b:656::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Fri, 18 Oct 2024 02:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM2PEPF0001C710.mail.protection.outlook.com (10.167.16.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 02:22:12 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49I2L0Mg023685;
	Fri, 18 Oct 2024 02:22:11 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 12/14] tcp: Pass flags to __tcp_send_ack
Date: Fri, 18 Oct 2024 04:20:49 +0200
Message-Id: <20241018022051.39966-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018022051.39966-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241018022051.39966-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C710:EE_|AS8PR07MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7961cc-f2e3-409b-b802-08dcef1bad23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YndKQk9QWmRsZ0dSdzl0WVQvaTA5WTVhdVdMRzl4Q0VLR29OOG81SmtBTThj?=
 =?utf-8?B?WHpQemFhQlVKVklFbGx6SlNNR3lGMkEyeUlaZVJuREJESHZlUnErWkNSZFpN?=
 =?utf-8?B?bU54eEtvSW56cVlNKytURjB4YU5jeVhhZUppOWF2Y0psRndjOTh3aHBVUFhw?=
 =?utf-8?B?emd0WGgyRHkyT082RlNFL3FpOGdTMTJZTmpZVEdGNG95T2VPNFNuZmxSZzIv?=
 =?utf-8?B?V1E1MzlBV2pmV0l0M05kRjE2YWp5amNhcXppdERJdmtWU25PSjhORTJ3a25t?=
 =?utf-8?B?aG9LeWRjbjVneEM4d2pSd2RKMVlicG5Kdm10WFJIWDAyREhzS29Ub25iNzZP?=
 =?utf-8?B?bU1MUDI1Z3dHT3huL1NGZHJQalI4RUNrRC8xWkFHRFQzMERhcEh4cmxXK2VF?=
 =?utf-8?B?YVNmVXdxVkF3RFoyWnUzNk56ZTY4YjBydlFjVEhDNmNudnpBUUlGeXFkTC9j?=
 =?utf-8?B?ZmF5VjVkbjBRSnl0d3hiWTFGeXBrNCt4MnBZbmQyL0JaMVVEUElhQjlmVXZl?=
 =?utf-8?B?a0lDSE1HTTJta24zcy9LRFBPNzhUU0pIMzZFcHhpZjhaSG1wMTBSeVltMzMv?=
 =?utf-8?B?N2QzZ3BDdTVLY044NkJTTlFXeFBSZk9YTkJncGxveDg4c1JtclBVNXBuOUp1?=
 =?utf-8?B?dHZ1cGV0bWpsc3I1SEVBRmVzcXhKUUUwejVaQkFpcHZ0S2dGUEtuOEw0SG9x?=
 =?utf-8?B?L01iZmlzbGMwVDVITlI1S3MyNG9xOUtZQXVqWUJjZnBVS2gwUmhWM0ZTMXFP?=
 =?utf-8?B?TlA1NkdDSlpkOVk5K0M1ZFU1b1FjQkVvZWxVc3lMdlNoakRwVStTYm5RZDlE?=
 =?utf-8?B?V2o5WUpiRUVjVjVmMW0zV0pyekZaZFNlaThWa3dqZTdlWHVlT0tNSS9EOHRJ?=
 =?utf-8?B?c29iV0VCSTBoSnJFQ3h4Y2ZHN2tuZEFIeTJJNGJXbWVoWXdtSFlKbXNFWXVj?=
 =?utf-8?B?TEVJK0k5aDZIM09xT0tjQm92d0R1eUh0ODcyMVU5cDNrVnMvRGtNanVKUXJU?=
 =?utf-8?B?bzlHejEwV29OZEp1Y0ZvV2VsNHFwZWFJeG9lbU82UFcyUEU2RmJiMUY0L0Iw?=
 =?utf-8?B?Qi9oMlRXaHNNNVNxblRJUURnbTZ5WWlYanhWZERObjQ5VFhwK1Nrd3hhYS9r?=
 =?utf-8?B?S2dmd3U3SkM3ZFNsdTczYzVENkUxazRPOEw3dklYNVIvS3ZmRGNIOWdXaXU4?=
 =?utf-8?B?MUhjZ1loMUptTS9vbkY5RTVWeDU3b3lqMUpDOEk0WGpIdGwzbW9xNjJmNXZ0?=
 =?utf-8?B?RzVVbFVRaVd6SlZGSGRTeDFGQlU0eW1zT1VsMU1nQ0hDbFRtMDhuOVQ2c2hP?=
 =?utf-8?B?eGh1Z0JBOGVmU3JxNzZ0LzVDcGRjaWRsK2VQdk9kTlUrKzlncVBGWVNWeXZo?=
 =?utf-8?B?Y0puS2V1cVhZSEdPdWZqRXlTRWxDVU5OUFZaTGovb1lDc3Jma2wyTjlMc1Bj?=
 =?utf-8?B?NzdwUHZOang4VGlscmJjVEZDR0JaSTdOemtVUVI3THhpV3NWOUxtcmxieFV3?=
 =?utf-8?B?N3lSTGJqVUpKM3lrQTN0MXFydG11Y09NaHpHWWJYYWhTQUpoY1JZbWtCM1dq?=
 =?utf-8?B?elRlS3RPaGYxUngxQXhyZjlTdFhpSlZuYUF4QUJQUGVhMFVwVHdhNjFlR0Zw?=
 =?utf-8?B?eGpIbVdhZ1dGUGxpMHNrRjJvVk4rbmxYQ3NSd01aaWhRa1p3ajVRNUJRVHp3?=
 =?utf-8?B?L2N1NWMwSjA4aGU0dDZqT3MzOUZ1VXk1d3loejZhSFZEUE1YdTRZVXczOEJN?=
 =?utf-8?B?UVRBTnNMd2ZaM1dzUldvTVYrNWt0ZHJzdVVQaEVFLytZcGlXaHdndnY5TUF6?=
 =?utf-8?B?Sm82ZWc1SWxEcy9EY0xSMmxOdVFtYTk4YkhjalZMUk1Md2tHbmxnT1Era2RL?=
 =?utf-8?B?VVZKSVlnZUJ5Y0dHdjE0VzRUVklRa0VZUi81NmtZcFFCQk4xR0tNeXR1SFFZ?=
 =?utf-8?Q?8JMKLbIoPSY=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 02:22:12.6472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7961cc-f2e3-409b-b802-08dcef1bad23
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7224

From: Ilpo Järvinen <ij@kernel.org>

Accurate ECN needs to send custom flags to handle IP-ECN
field reflection during handshake.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h     | 2 +-
 net/ipv4/bpf_tcp_ca.c | 2 +-
 net/ipv4/tcp_dctcp.h  | 2 +-
 net/ipv4/tcp_output.c | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index fe8ecaa4f71c..4d4fce389b20 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -704,7 +704,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t priority,
 			   enum sk_rst_reason reason);
 int tcp_send_synack(struct sock *);
 void tcp_push_one(struct sock *, unsigned int mss_now);
-void __tcp_send_ack(struct sock *sk, u32 rcv_nxt);
+void __tcp_send_ack(struct sock *sk, u32 rcv_nxt, u16 flags);
 void tcp_send_ack(struct sock *sk);
 void tcp_send_delayed_ack(struct sock *sk);
 void tcp_send_loss_probe(struct sock *sk);
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 554804774628..e01492234b0b 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -121,7 +121,7 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
 BPF_CALL_2(bpf_tcp_send_ack, struct tcp_sock *, tp, u32, rcv_nxt)
 {
 	/* bpf_tcp_ca prog cannot have NULL tp */
-	__tcp_send_ack((struct sock *)tp, rcv_nxt);
+	__tcp_send_ack((struct sock *)tp, rcv_nxt, 0);
 	return 0;
 }
 
diff --git a/net/ipv4/tcp_dctcp.h b/net/ipv4/tcp_dctcp.h
index d69a77cbd0c7..4b0259111d81 100644
--- a/net/ipv4/tcp_dctcp.h
+++ b/net/ipv4/tcp_dctcp.h
@@ -28,7 +28,7 @@ static inline void dctcp_ece_ack_update(struct sock *sk, enum tcp_ca_event evt,
 		 */
 		if (inet_csk(sk)->icsk_ack.pending & ICSK_ACK_TIMER) {
 			dctcp_ece_ack_cwr(sk, *ce_state);
-			__tcp_send_ack(sk, *prior_rcv_nxt);
+			__tcp_send_ack(sk, *prior_rcv_nxt, 0);
 		}
 		inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
 	}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index bb83ad43a4e2..556c2da2bc77 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4232,7 +4232,7 @@ void tcp_send_delayed_ack(struct sock *sk)
 }
 
 /* This routine sends an ack and also updates the window. */
-void __tcp_send_ack(struct sock *sk, u32 rcv_nxt)
+void __tcp_send_ack(struct sock *sk, u32 rcv_nxt, u16 flags)
 {
 	struct sk_buff *buff;
 
@@ -4261,7 +4261,7 @@ void __tcp_send_ack(struct sock *sk, u32 rcv_nxt)
 
 	/* Reserve space for headers and prepare control bits. */
 	skb_reserve(buff, MAX_TCP_HEADER);
-	tcp_init_nondata_skb(buff, tcp_acceptable_seq(sk), TCPHDR_ACK);
+	tcp_init_nondata_skb(buff, tcp_acceptable_seq(sk), TCPHDR_ACK | flags);
 
 	/* We do not want pure acks influencing TCP Small Queues or fq/pacing
 	 * too much.
@@ -4276,7 +4276,7 @@ EXPORT_SYMBOL_GPL(__tcp_send_ack);
 
 void tcp_send_ack(struct sock *sk)
 {
-	__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt);
+	__tcp_send_ack(sk, tcp_sk(sk)->rcv_nxt, 0);
 }
 
 /* This routine sends a packet with an out of date sequence
-- 
2.34.1


