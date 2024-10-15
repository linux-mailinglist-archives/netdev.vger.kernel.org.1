Return-Path: <netdev+bounces-135546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB69899E3E8
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFAE2B210F5
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C451E9078;
	Tue, 15 Oct 2024 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="D+L0NBTL"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1321E7674
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988225; cv=fail; b=h4AGW1c6i6eT8xUM6bG3KxRDTHggg7aj0HEHuAvkkKhax54+ClsDz7E6BR7WHL/H6yghOs0DD0pIM6bkePaHwA621T6bSafuqoDk7HVo7F5MssT9CpTA6WEy+7mePn8xULvtfmjGYP4gYjvD28LkqxcNWePKJFnlNQ0pfb8HHAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988225; c=relaxed/simple;
	bh=Hj0kpmxspiVLJX8wpFuphNG9SkyVLpob5NDj2PecjNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9WQoq//8bBtngKgCEXnU2yUgxjiEQ6ZkCY2aQFFvsrvxdQ2g+PG/INx5jITwHArgOfaxDNms0t/Yoi8hb+4xc8RV1DN7aQL7Y1tHh7L2WNuYVYxM/AiQbhmJsLHUQXTiEMbf/O2U13m9V/3I66I+5MP3qVzfg3eQhT7yCXsNKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=D+L0NBTL; arc=fail smtp.client-ip=40.107.104.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c70vXfmcIObNEnM3wzPWtM2lxa8QnbfgZMCp7bVdlPcoP9Yf5uEAm19/OI0cqHTXQFG34UOawUNKehjmwbKBfedF2Tplbvecxv5bRKR5RF/tQ8LETsrN0RzGv8vSu4ZIbCTLlbsE4jUB4ZXXaNtWbU+Lw7TczdQ9imFBb0WEDwhPOmWAH2EwC4aaqg6QjrBfB6vaEYynqpAyJaAto9ZYYT+nb64S3n1LUl2ENfFL3uxf/0TnjA0CdmEU0SjIJll1OLYhOUuYPI5xMMPLjoh8UOWfp3EBB+X2tUfhQo+F03HvPu1azRKf8wLv2ylgvUJ2lFMRwPmPVimet1FZe7dDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXl+jkY6ong5Phsy59TTE3OHZvwQGTrSsZW9TS0xUyw=;
 b=KtpjN4fykmTO5KW8M2qK/jfn9GoV82M0SloottZCTbzpN+2nlufOMtmKzS7qXzOGKrBwPd21pkvq2IXE5VBk+TIu1p83ai6Jt2eBUOaOmbITJXgoDlqgIifLjb9Z6/KO8l7/pCzfSeQO0w+Y5eVsnH22AkGH0tGpJd+UFMYc/4BFLVvITm2N0xLl77lXi4xBqwmpyqK4fGuIDFlcqZPxG64ja8OgVAOtSHoZ+Jp8DxpwkDEs3DvrOySgqqmqfgGzUXQH/VQxiwTbrb0QkveuqdQr6E6IUmBlvrW6mJ6suviMlYQuJYU7bCnrcsbf9EdlTZ/Fp+60pTWw57z16CaliA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXl+jkY6ong5Phsy59TTE3OHZvwQGTrSsZW9TS0xUyw=;
 b=D+L0NBTLL7yJL43ew4bgg6gov/n0rBrtygWzwnnXlXzZsdvP4ZvNNj3S0yjByUfy2roxWgQLcDq6WJnY/5HQ8+VhrkuvXbUQOQ7R118G4SFY21de4TtMbejS88AamxsOh0PEcuTIYuPlYabfqqliT6F0JO4Kgw26V595Nn1D1x6JxrPqtaevMiMCocJ8qZqUP2uNBGgdOf/FSc05OYJWYAyf/gFr/tYN8YuB2AQXDMXgCclBVhfNS9nGAXakOClAspmSBJi+OEzdgzs7OENFW8rt/Ai+k/UIyYYGsVvnP8Zsb39WzwvP48KmaDbLl65UIo6NDrVap/DBXSxXiVm1hA==
Received: from AM5PR0101CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::31) by GVXPR07MB9680.eurprd07.prod.outlook.com
 (2603:10a6:150:110::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 10:30:20 +0000
Received: from AMS0EPF0000019E.eurprd05.prod.outlook.com
 (2603:10a6:206:16:cafe::97) by AM5PR0101CA0018.outlook.office365.com
 (2603:10a6:206:16::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF0000019E.mail.protection.outlook.com (10.167.16.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 15 Oct 2024 10:30:20 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnH029578;
	Tue, 15 Oct 2024 10:30:19 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 13/44] tcp: Pass flags to __tcp_send_ack
Date: Tue, 15 Oct 2024 12:29:09 +0200
Message-Id: <20241015102940.26157-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019E:EE_|GVXPR07MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: 839b605a-2b3f-4419-97fa-08dced045e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFpHOXhOaW1rQURPcGFnUk1jckVBSENpUVVYbUlNWmNhUW1EYkpOQzQvaTNS?=
 =?utf-8?B?ZDdFVjB1bjNNSXQ1MVNPLzQyN2hRUElUWXV0YldxN21JUUF3RklSTXQxVnlr?=
 =?utf-8?B?c3R1MXdobVpIRnFaNmd6RlFWVG5PYWFBSEJlNGYzTXExSFZ3M1dCTWt0K1FL?=
 =?utf-8?B?QnpsS210Z2Y2bFJEWUpFanhPRGZNR1ZsWVN2ZkRyZVFEM2RVWmZ6OVZUd2Q0?=
 =?utf-8?B?QVExOFBSOXNHTEhDbTJkZUFldjFRck9maHZjVksrTnl0endhNC92NXFBVk9u?=
 =?utf-8?B?OEM5MG9EQUl2WGI0ci9DbmRUWVJGVExlZ2NFZ3V5RTIweE1KWjF0am81UWZ6?=
 =?utf-8?B?WkErbXBPY3ZXY1lLb2xRbE4rdWhzNWZlVkNwUWd4TDU2RVdtYlZabWZpeVZh?=
 =?utf-8?B?S0p0MnJDcXZSbnFNZFhEdU5ZWmNSbnNidGZUTW4zcHZpc2xFdGVUZnRtWElV?=
 =?utf-8?B?bjB2bjN3MmROWVlCa2dLK3FlTzRHQmwybHBmT1dhTzNWK0ZrQTRyZjl1d2hQ?=
 =?utf-8?B?M2w3RVFlMGlURU9oYStLUXY1b3B2Ym9jbk5obnFqRkVNcElHeDI3M3VoUkt3?=
 =?utf-8?B?K3JSdDZHbWxOckN3MTBILy9OR2ppZnQvSGVkcFdReWx4b2JkRVc3SUJURnN0?=
 =?utf-8?B?bHJhVGo4T2N4RnVjd3lHbkdSUmhMdTZkcWliMGtEdkd3R0p3VHZRb3dYM2lZ?=
 =?utf-8?B?c2ZoNFNDMFdOZjVteFkrN0Q4bGxlYWJlQ1dDSzE2U0ZLMlZDbHhndWxQV0lR?=
 =?utf-8?B?YlJPWURvKzBJLzJ6M2VjTDFwNFF5cG85aUxvSFREUHYxYytLRFRaL1hLRTF4?=
 =?utf-8?B?U2wzSE9ENzVFL2JLaUNySlJ1cEl1SkJDbERsMTk2Z01mUVg5VG1UVkJMT1Zv?=
 =?utf-8?B?MHRhKzR4SVRtSUJVUzFWODBEdzdJVHpsWWhNNlUzdWZlTmc0ZXQ2MnloN0tq?=
 =?utf-8?B?NVRJWTNZTXZNL2VDUXU5bTZ2RExvYUM2Ykh3VXB0N01pZ3FPSngvZnBPMGd1?=
 =?utf-8?B?TGgvZVh4UmJlSHFVNXFtMXRyOVUxbFFmVlJCWmJ0Z09pSmc2L0M4aHZtOFJz?=
 =?utf-8?B?Z1lZbVltNDh0TkJ5Q3lUY3l0RGdJMjVYQ2NUdys2NnIyazROMGNrUkdCY0VQ?=
 =?utf-8?B?ejQwUjQvUzBwTFRONFVoR2xvc0dwUGN6UkxPeXIxNnNnZ2J0V2VsZ1FTYjVa?=
 =?utf-8?B?eEtLaU8weWprTHBZbHJ3M0luak81bFRyQlc0QUFtd05CZ3RlUkdxcERqZURl?=
 =?utf-8?B?TW1yN2pOeHF4bE8vVDg0TUE4TUtBWm5hR0VQVVN0VUJNa0pZNGdBcjNCUTJo?=
 =?utf-8?B?ZWI2dk9aQWRVMlVVODYySmY0TDBrajdFZmxzMmJQbERHejdLTEVrOVV2U09L?=
 =?utf-8?B?YjlvbUJtNVFLdTE1SHNPUWdqYkpvd0Fzbys1TmhyS1ZTaEFkZDZrM0FkMUl1?=
 =?utf-8?B?bXNCNnpReE9ycGhkZ3JTdnRlbXNqMHB4TE93N3Rkanh5ai9MQitjWU5FcTNC?=
 =?utf-8?B?aHphcHUrSXk1MVkycVFJOWx1UDQxWlRXZVJXL0xheE1RRFpnY0dIc2pra2M1?=
 =?utf-8?B?U0lKZ1E3THpnTkx5b2JoZDZzUW1MQ29SQkQ0bUczc2puVTV0RFVvOW9jeFZI?=
 =?utf-8?B?UXd4ZHNWN3oyaVRqMzRvejdQTWtpMm14ekVtV0hzWGxudDQ4Qit3YlVYZk5Z?=
 =?utf-8?B?cndxRG1mZ2RmRVJqdXZrT1BrMHBtY0FTelRYMFltdXRZRjNtVjhGbTVCWXgv?=
 =?utf-8?B?ZjcybDRPYlZXRWwveVorbGZMUkJtVkNZMkpFMTRRNExKT0lrZXBrWlFEaElQ?=
 =?utf-8?B?ZjVGNU9sVEZKQWtqcXpEZFY2RUMzMmRPZ0hjb1lhNGV1bzJkMEFPdkdpb1dU?=
 =?utf-8?Q?Ynfw8cXW+C590?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:20.1712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 839b605a-2b3f-4419-97fa-08dced045e9d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9680

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


