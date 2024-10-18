Return-Path: <netdev+bounces-137170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C869A4A03
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 01:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000A328406E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 23:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AC7192B90;
	Fri, 18 Oct 2024 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="LZyIYUA9"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70289192B75
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293641; cv=fail; b=p1MhYLdVFkKxY34OVbUJuHl6L377PRtZatZtjlW6JSlU7guaBqnm09ByEc2MKWv/JcQM1IqVeDluZ8JSCH2FGJiQJFl4BVBRJ3QgxvwEo/55IfH/rP7s0WH6ch3YkysNOhM1Uil0lUwhX7M7GEg0FR8Qcs0Z5rxsyXmXrajRsKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293641; c=relaxed/simple;
	bh=Hj0kpmxspiVLJX8wpFuphNG9SkyVLpob5NDj2PecjNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5ojd20ssSD6INxD9lbD0E6CYi5ayvwJfn1AMT7eibLs/jxEC5nEZPIPZuf5Fky9NLeam/2fKTh5r/ukP9VADKP3JvNZ4a/94vRefd3K/H5M3X8E6EA3vH8rqNNRnMXiPaOBnKceLJN2NsO0xFFI/ZrRGUL4bA2fY2zDrtCKvis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=LZyIYUA9; arc=fail smtp.client-ip=40.107.21.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzLFMP8Sr21yLgcfGbgVD204ILXGPjmhbiBp9xFpRuXYebzr41E2dckDdAQPhKUtyPrxG+TTMn50hAsiKNj/YYgQGZdHwYpEleTi1lgOH5zwTFvlu8FzBe2B+4QI2Yt7QmGzHBr8Pn3YHGHQVPY5W2gaSjkE3znCN8bVcIuXUtU76z7jvfbYHy9pyd1zZsNhMACZ9qeUOOEYJC5JDcIqK5qBJP3dWFgjyVQFvXbEW3oge8OntmwajwSMi6P3oH5/TlGO53fXpzDr+BCOKfXJOjDxlfXYO9gaXSj9cHjaT3KMFtt5R1/MgoRa9i4GZuiOg7bpOUnhhXYqlCpJf1KE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXl+jkY6ong5Phsy59TTE3OHZvwQGTrSsZW9TS0xUyw=;
 b=rCqXZgcVxEPh9IHFf2QtfPO7QyYHVQhvrr8fzI5X6LwfGgMOXmk83G0UNSogcU1UIHqr6uoV4oZFVaWFrxemxsmFP9fuCe0ePfaA8fRrxSsfYb9LDdGLT8Lxi0KkZnLEgfA/DUIzmjhFuAH2GxfNb+kcZC1hEuASUrFt1gKirh5t4Nc+OLWSw0LoGEOQLD19VEf19d2/quAQiXvCUioD2ANKCz8mMkWpEmhc91cIM7wsHd38GsR6M1tSso2tZZ1d8eW/zxna53elaZCdQFvrSGfFfTzjq2EIVpMVdzOTqXq1GMYUV3j6NpL/E96DxpFV4zBHXLBPTLWVGvtbO137oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXl+jkY6ong5Phsy59TTE3OHZvwQGTrSsZW9TS0xUyw=;
 b=LZyIYUA9ZeY17RlbMjQY4urH1TUgZl4Am+MDmc0o3A560zIWshuvHhGChg7McDtL2IvLqi5MTx4DqCBQVuI6wgpxraLnMwrEai1a1SG7byrb1ctchfygL9siruWheZhncbpYru/6oJZhdwfC9UuphdjpNC2YpJW9ydompGaN+rOBK9NWccK25HC6iss3YPXcIbi8RpIXbZyaf13Iw/zWMV7cpNpjcy2ysXJ79wkwurVrGp+gTQVfwfTqeMQAG18dx/8k9osIZ18k2XxdqiGt7gPpGZLK06qc+3EvyF/Cb2vqTCeV2/n8RQIyKYJGdH9dBC4uIZ6pDGI2igIuLzfFSg==
Received: from AS9PR06CA0640.eurprd06.prod.outlook.com (2603:10a6:20b:46f::8)
 by DB9PR07MB10073.eurprd07.prod.outlook.com (2603:10a6:10:4c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Fri, 18 Oct
 2024 23:20:34 +0000
Received: from AM1PEPF000252DB.eurprd07.prod.outlook.com
 (2603:10a6:20b:46f:cafe::d8) by AS9PR06CA0640.outlook.office365.com
 (2603:10a6:20b:46f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Fri, 18 Oct 2024 23:20:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM1PEPF000252DB.mail.protection.outlook.com (10.167.16.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 23:20:34 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49INKJJb010239;
	Fri, 18 Oct 2024 23:20:33 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 12/14] tcp: Pass flags to __tcp_send_ack
Date: Sat, 19 Oct 2024 01:20:15 +0200
Message-Id: <20241018232017.46833-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018232017.46833-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241018232017.46833-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DB:EE_|DB9PR07MB10073:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b677275-6329-4b1d-e1fd-08dcefcb77af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emFGOTRXUnJvLzJXR2hHc3R2a1RlTmpLUm92aTcvVVVKZ3NkMENFQXo3QzF3?=
 =?utf-8?B?bXIwMlBhQ2xWNWcvSzdsSUFrN1RyVGtNcmJsbFptRlE5UjI5SXJSNzRVVWpv?=
 =?utf-8?B?MVpVdW9UbVkzL2lpNkh0MXBnaTNhaFVCTnV1bC92RjFMekJ3TURKK2xQdTg0?=
 =?utf-8?B?SU03N1NzVWpZMzNzZzV3amVwWDRESS8rT2RSSHdHa3gvMVgrNmxQT3VlS283?=
 =?utf-8?B?SFBha0dIbDIxOXRacTJZVW9xTnVTR0pnR3NTOXEyaEVCUE9oL2p3QzFmaTBW?=
 =?utf-8?B?ZnQ1RmxwMER2K0huT0g5L2hNdXlubjA0WnFCRnpuU25Da1F4UndHV29KOWF0?=
 =?utf-8?B?aUYrRk1KWWtsU0c5bUNDT0h0ZEkxYjJUYURDL2VLSWM4VllxUVRYUTBUQ2ox?=
 =?utf-8?B?TDl3NjlxVVNob3dhckdDQlZ4RmRrOEpvN1BiRXRURStUM2dPUHlWSVhzN3NC?=
 =?utf-8?B?Yzd4RlFIQlNVcCtoK1FWbU5VNGUrNTM4R0hTZ1hQV1JLTkthMm1yVUtyVGE4?=
 =?utf-8?B?OFRnTEpvUEU0c1hHS0JaRzJSZXNXcWpSVnZOQURoVHMzRmZMb3RtTXl5aVdD?=
 =?utf-8?B?a0d3WHlESkhGR2o2Q3FZSkxCdW1RVjFsSGZvQUpvMEYzNVB1YUZRUG9YeEtn?=
 =?utf-8?B?Mm1ra1NVMCthb1k3NVhHZXFFSW9qUTkvbko5b3UrY01kdGNIV1JQckw3bzY3?=
 =?utf-8?B?WEJtejNLNFYxdEp1dHpnOG92MHJydVRZRzVSbjZBcEZDT1U5TkJaQ3lCZFEx?=
 =?utf-8?B?NCtQUERiSDlvSlNjWGpZNW8xeHFGS1RyK3gxU2NpT085VzZpRDF2Q3ZHbXVk?=
 =?utf-8?B?VUExbkJ3dVRTMFA1Nk5zYzJXKzl2M1kzWDFKS21NVXpGL25JaXBpNlNjRllk?=
 =?utf-8?B?OFJzaWd5bkNBbzdKS0M5QzIwQ3ZZdGNjSE80NnZCRGl0K3oyVkN3bWpRREda?=
 =?utf-8?B?Tm95amZSYnNWbXkwclZNZTdFa3hpd1lTckM5NHJrd0Vid3kzaTNrVDJZK2lI?=
 =?utf-8?B?NEZQNkJUNWJQYmUvSFYyckVMVmpqbU43YTQ1NENPMXYrL2VjNTFaNnR6bDhz?=
 =?utf-8?B?aFNDTkFOWHVMdXhmTjUxRVZGOUFEYUc5WmM1WFhJcEFmdEF3bldUWmFXQmZt?=
 =?utf-8?B?blg1SEVHcUNkNTJtV0ZldlQ3Tzd5Y1ZkQStwb2wrbGdlMHN2NTcwTzROS0xR?=
 =?utf-8?B?cXVZYXdMcjVkQjNSVWZlL0NLVXdLM2E0dEI2NTlhbjB6d29pQWxDZHRCUFZr?=
 =?utf-8?B?ZVhPWUgwOGNwM3VMNWExWDYycmVGK0s0SmFqL0tJc3VZeE5NdFRYb1dJQkp5?=
 =?utf-8?B?Q1M1TnFZOTZoR0doR2t2a2VicHNSL3F6dzVqRjQ0R0o0b1l6akUvdlU4ZFl5?=
 =?utf-8?B?N29CNS9wZVRMWE1ZczZweTQxMHRlMVJyZDM1c3QyV203U1pqeXd2UjhmZWps?=
 =?utf-8?B?dW5aNmljeGVoM2pEMGEvR0M2Wkg4TWlGemhVZ3p6dE9NWlBPYUFCRGNHVHpT?=
 =?utf-8?B?M0xUY1RnY1dySmVRZDRoNEt5eFZmV2NrdEpndWlLOU80Y2l3VU12N0hJZFVO?=
 =?utf-8?B?MTFCRENXRDdRRVczOVd6dXBIL0l2YUNrSzFxeEk4SVl2a2R0MXVPaFlzbTd3?=
 =?utf-8?B?UWtGRXVaQ2JsUkQ5M2lob2JRSEtRckVrSlZkcGZIMzRMRVBWMXJCdE5lUDdw?=
 =?utf-8?B?N05QNHdHZG10NmxtcTJpRzA0dGRxTklMMW9IZDREWVRKL0w0b0g2K2FRNFJD?=
 =?utf-8?B?SlpYbDZVQjZYNVV6T0pvSzR0OTFlOTBOdU91OVZUSVprSnVYSXBZQ09VYVVw?=
 =?utf-8?B?MkF6KzJEUzJwVEVLdXJlSEExK3AveUp6TkwyaWlJOVdFRlUrWGx5UzdkMzNQ?=
 =?utf-8?B?eE05Z0ZHYko3bHBEeGk2U3lGdzlBeDlaKzJyUVY4TFo2RC9ySlNwc1Y2S2pz?=
 =?utf-8?Q?GldZ98J8ShM=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 23:20:34.3463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b677275-6329-4b1d-e1fd-08dcefcb77af
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB10073

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


