Return-Path: <netdev+bounces-135570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A2399E402
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12883281E2F
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9590D1F8906;
	Tue, 15 Oct 2024 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="F+jYNMzZ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74B31F7086
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988239; cv=fail; b=Qk9jg1647RLmcFSsV6reM1lJVtEcVd/DOgcgvb83rQst+hYriDvR+AUCerkB+RMNqfbxK8c5Bym3FMQwIChfRbLR6YnBMHaF10CmrjUusQII8utfFPp7GsdMGAAd8NvEpbZAR2kOGHZhuGFSjNvTVot85P0WnoznNove7eg+SKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988239; c=relaxed/simple;
	bh=h4AijBRfbvWP2YriG1Dda0W6XmWIL+m53S8c8oqYtyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f74LPPjnnt5edtpdctYRbhKSGeiNWoEBnhOAq/BYNGIaQ9Cfk85yMWJnx/Jg/lpTaA334rG74sFsYXltiVuwu07eFs2pLGrsZQ7wpF44afGtoCIEUQcY9KezHiNY9calR3JwQgRPC/vcsyW0AbeF6yyPXb7rxyo+1jnL1bTDMsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=F+jYNMzZ; arc=fail smtp.client-ip=40.107.105.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpPXaeor9yo/A2wGaLwlxZRx7CUqphEjLowNY9FPFRAX5IDqhsz/outLGe5YGzqPKY/ehgYCmBIB0hN/eXjq9IXlZ4U8SdqKRc6HZ1bV0/XcjiImu6d0XD7EeoriY0q2fMyu+UHI6CB5MstT4WBCCG4lMkwewxOwYn/L3HHqNMy7MkeuPljK6609MTW06MBUv2Z3DipA7uHpeE948K+4zkmkY8jzeRaYsOsC7LSQAa9x0sRKc3F8OVljZXHOpe6n+lAAdQlcl9adlU4kS1sR8d0zNPwr3gr9GTEj14SO6hz7kEzwIieI0ZFxD96gDpDQ6HQz66nPHbgj32uQU7LO6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVOtQzFDCnH+X3DMDc0GT4uh+a544OCpy+2Xxfq7LI4=;
 b=uvF4Uv5aBG6LXhUB/3ujQvWWRwJjttwLN1Bm/qxFyVU8tBk9hmfVkVA2zYN36HgM9HGdx4jsGFwSTCA3Sc1kHEr/7dlZDSYrLedfoMXSPh+pRbfjTmijJSjoa7PGp2mk0GXZ7gVOuwFUhhxP1Ve/SMe43lISbJblsdKy7Erx4P7xb8/2XM/oewDXd3bU89UWiLufjJmHSqzZ9+DBRYOG4Ptd87lUB7n8tEbGbTkQoWTWrhRQyAUVDYi+sF1lalYrRHW17Fpvpkz41wkWVMn5ap4F5M3NcYQSXwXEpxg4CjOp4Puwctt0BvMmKOzeCwVCfc8AFt7WXHlBgW7bo3A3oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVOtQzFDCnH+X3DMDc0GT4uh+a544OCpy+2Xxfq7LI4=;
 b=F+jYNMzZjw3Ep9gQ/iQxXjo5IgN2YAcC94jRZPHdl7tamocwkVnAJ3GfW7Sx3r9FTLutcngSgPvmy5U7awo/X5zpL9JSOlluWCsdq/AkLXZTINqKcc66+b2CUeWEP/dHCwXBAwEeCF6oFGf+h6PKJrdXpoXIXBnDTaj/VThkaDEGVpiI800M8P4UpcZKZSb8Wp5+LTu0kGhOVRLOKNU+eVjb6vfK9beSgmCZINSSVl9YPYalzQVfI3oU3yvVmN3h2LU+R8tpoliyFgkZ0rkCfJadTD78gPWJ868ca9WT0wcRrAGi1LerD72o5RGQs9S5h5iUIja2AwFMH5w6MvRTcw==
Received: from DU6P191CA0041.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::21)
 by AM8PR07MB8121.eurprd07.prod.outlook.com (2603:10a6:20b:36c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 10:30:35 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::49) by DU6P191CA0041.outlook.office365.com
 (2603:10a6:10:53f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:33 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtne029578;
	Tue, 15 Oct 2024 10:30:32 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 36/44] tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN SYN/ACK
Date: Tue, 15 Oct 2024 12:29:32 +0200
Message-Id: <20241015102940.26157-37-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0B:EE_|AM8PR07MB8121:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5899cafa-701d-4656-a8e9-08dced046678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GksP0r639g7xPuXFPpO9VuSpRdpai871uA5uFCtlSEiddpBBlPCX/O9fmJvV?=
 =?us-ascii?Q?4MmTvNzcwnBXnV15Ai6AODbIGRscUBqm4cBLDsMk2xZIjk4fsTb4k45BMYpq?=
 =?us-ascii?Q?Qhs055zkVtqrqduqqbjnG1GqM1dzOhofXKu7pwoLKYY3d1in2Wtczdc80I0E?=
 =?us-ascii?Q?Zo86j/vAddJOE/ghWw5GF3kQ7E1FJ2MRbfk3QxI+VQwQsUWxd91MBXKaoSsI?=
 =?us-ascii?Q?+KEajTGI5WdCDZXxbVyhAfxq3HskMp3j/Js3lzqfdDjPRz25xkPE0BylGXdt?=
 =?us-ascii?Q?c7/ZPJ5TXwKC8YNa9yNQEv/X77rxo45PjjifZcjWe9A4bzqaUyjp9RJw89qg?=
 =?us-ascii?Q?zfVqp1JRudTa6Eb6zflyMV2FDxKTAK4lKyEi6yJHptvhXh6EER+15ycwJxq7?=
 =?us-ascii?Q?YXTtUz9B9cSgC6b5CZZNGGYl/P4sXFOVqddT51lKuCt5WQW17yDvoj1r3T8Q?=
 =?us-ascii?Q?AfhxqFZ8xlaQAzODCzhZOspL7Lftrnzsb5862plMWKhI9iz9nL7O8sL7Ndji?=
 =?us-ascii?Q?QVgHI7LlTsWSBhbygne9lHzwEeUa9IWgYQRF4K5oTL5taklcWcAfZsCsa2Mj?=
 =?us-ascii?Q?3y4YEvg5R1gE8wX8buH29sItkegfsXw2jTaiHJfldabDdBYpxFH8OruWbjZa?=
 =?us-ascii?Q?4TTTUulDMpZjJiC0dZvxoimwETRlYLRV/Ud0jgFtopjoZq2EbdyHrol3o4oN?=
 =?us-ascii?Q?zwEn3Pk8nBkhdh54115BuF8g/j9K3XtHiT3kApZile+nVcUvs0lNCio0Ap5X?=
 =?us-ascii?Q?N6CsPYJN5s+Bmt6LMaZ0jCRV1rKCoXRnF89bCj1yfdjLKoVzZ25sMyI/zYjT?=
 =?us-ascii?Q?gBHNuhRLbHf/QEI447YO6o9d/Ba3rRXURQbRs02oj4RxZeRwdfFWsJ2eYodq?=
 =?us-ascii?Q?Or8PEBUWSqVOl8exqKTPHtiGbo6RgULWgFzjGs6ZOiA1b3C/TurShu3Af4vf?=
 =?us-ascii?Q?qNe5x8RPrASgpQnSZuApKpGztVmpIKg7lrjFfyydC7s3viX+y4Iu6FrPFue3?=
 =?us-ascii?Q?xJA/xMcDa2ciovF4WZBMe1J8ZuVUUP6V1LWeZADyPNxOohNSkXlXUNKiuVpO?=
 =?us-ascii?Q?7eQCvE/RUSXV3TNkQ0jscJ9BbKQbUFbhft7TY7xsUD/yFX7i8qzx3jx2SuT4?=
 =?us-ascii?Q?yXLHOoTUz5dyFiUGB9/bW3nQFRvJPqpS8+vVQosSzn47wrur485vATXxzS12?=
 =?us-ascii?Q?zP6HWTRmQib5WQB726kCLV+oDW7WyHUwodysWHiZjFAUfyMLaokGiCXJxsfh?=
 =?us-ascii?Q?S+48yXLSyVIL3LztA9i55ZcNR4pEeED5PcSHwyM2ipkg75YjHuqM3fpcZ95k?=
 =?us-ascii?Q?rJhpfjnFsN0ky6irRj8yO5wuvS/rRMcMZeAwdq1hKLXQvBN0V/NGHqHNL+eL?=
 =?us-ascii?Q?O5Yw2EMTVatHh8oJhmnzqO+rJEKWKQWFVQHEuBiiCjah9LcHBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:33.3040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5899cafa-701d-4656-a8e9-08dced046678
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8121

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Based on specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

3.2.3.2.2. Testing for Loss of Packets Carrying the AccECN Option -
If the TCP Server has not received an ACK to acknowledge its SYN/ACK
after the normal TCP timeout or it receives a second SYN with a
request for AccECN support, then either the SYN/ACK might just have
been lost, e.g. due to congestion, or a middlebox might be blocking
AccECN Options. To expedite connection setup in deployment scenarios
where AccECN path traversal might be problematic, the TCP Server
SHOULD retransmit the SYN/ACK, but with no AccECN Option. If this
retransmission times out, to expedite connection setup, the TCP
Server SHOULD retransmit the SYN/ACK with (AE,CWR,ECE) = (0,0,0)
and no AccECN Option, but it remains in AccECN feedback mode

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ae78ff6784d3..e5c361788a17 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -399,10 +399,16 @@ static void tcp_accecn_echo_syn_ect(struct tcphdr *th, u8 ect)
 static void
 tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 {
-	if (tcp_rsk(req)->accecn_ok)
-		tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
-	else if (inet_rsk(req)->ecn_ok)
-		th->ece = 1;
+	if (req->num_retrans < 1 || req->num_timeout < 1) {
+		if (tcp_rsk(req)->accecn_ok)
+			tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
+		else if (inet_rsk(req)->ecn_ok)
+			th->ece = 1;
+	} else if (tcp_rsk(req)->accecn_ok) {
+		th->ae  = 0;
+		th->cwr = 0;
+		th->ece = 0;
+	}
 }
 
 static void tcp_accecn_set_ace(struct tcp_sock *tp, struct sk_buff *skb,
@@ -1165,7 +1171,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
 
 	if (treq->accecn_ok && sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
-	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
+	    req->num_retrans < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
 		opts->ecn_bytes = synack_ecn_bytes;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining,
 						    tcp_synack_options_combine_saving(opts));
-- 
2.34.1


