Return-Path: <netdev+bounces-135564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D5F99E3FB
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7261B1F23DD6
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2161F4705;
	Tue, 15 Oct 2024 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="PwGZpwkI"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E4F1EF09F
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988235; cv=fail; b=cjKF1ammy4LsS24CggdzTeUDZjYG+2RuxfEgF0qbPwXCpryVnzodVrgNNC4QTXGjZj3ywIB03qd+IWSM1bIhBZjAQdiuVVn3uqcLsPQYXUCuBpxdvbi2CRWuPMMTjYjM3mNCA2djWNieGVk52jCmmSFH+Wel9BCb8Y8MIeL3Kts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988235; c=relaxed/simple;
	bh=/E5X7eKpxyZ2u6t5vXDxj0fCZgeRWOkIJKQTxIIqZ4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2TluomBrmQyH5+fDGGWSod/OyhFdZT7yR3aeHAqeXTbC79lLBACKDnh6fEc88ihYgXMPw7UCJR10iQLUVUxCyDaLhvNl+JdJksjmySULsNYPNQfKJv86rtHDICZj+D8OWDb6Ut9uzCBcfutmoCP8Q6b8O0hCcb0TraHfqA+CLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=PwGZpwkI; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxJmA4e6tmchPmKqDAKSkI+IrVjuhq3pKP8H41ZoqFzDPnU0lBvwHQX8s4DkU4c+gmDHh+coV3UqEaCXBpevWAaXNWFuExrRaVO3fii78wgP1KKToJ+Z4ePR2ZwIRRYs1vecv7a5ESrqnbcA72djBRXtV8etEAnJkQQzAmOonLwmiBE96rG23nqxgJxaOnhQ+5g5CyVUd+xSXlsZaXQ/Y0KbdCK7JMPq+LNG8NNxbYpuo7lhtPaJFSPq0PuedZI81agf3LreMbu/ynCd2Rz8kw/fCcauSq1h2DYptmEC+sV8bOhYV24Q38ErlSj9UmUHVVgjyGBiyU7Ix1aAaiB5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbCYkkENBRLWyMQxpaW+oCGGmi3pleFCFalw1IPu0N0=;
 b=ea8x58eVhlgr17RfvlySHbLXhYQvLy0e9T9HzDOdB8+mpFDCYQ5SVGr4yiYu5Sm5aCf3gTuokUFrcgEeGcAk/e+K0M9FBt4jlWn9wDy7HXi+8+ideDT5Gq/X368RpY1vMbVgYz39u2RFLlVOShi5dSyVaVMe5DTbVZ6vqTm4eU3k6zTbWR0m+fCDvB2IN+Rj5C1gvwY/3AFHyxQD96e2q7RMAWKd5kbHbuKyJC+CsJVZ+T8JoFVfkkRxNHMnMD8wfVrqCTgKXAVmbhfsvMX+nsxwpKUX15zWkLY7i8AlAUfzl2XRRTIWibTC0bDhtzXwM1a9yraUshY7GO2uS5nA8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbCYkkENBRLWyMQxpaW+oCGGmi3pleFCFalw1IPu0N0=;
 b=PwGZpwkIxhqzcA9yBUHFiWZKw2bb4LZ/DCZ7oEP1UhPkpneajzaF3ty/v+R1qhUchYNMhwIvWMerNq1Fpn62PlG+EJTjJv38EHi/taFz58gNWA8uxuKFiaWEFb01iVfPuqZ8gU3s34o+LCQCcy64PwmoeufZlNGKxEL+eTSFUmU2hLH69PGeFvQOyHVH1EhoDdGajLptlEIKHxZBUjhLUAAt8Ur+I4DeFZKF75rZfI1BdV7R2p+/gLd3GX2JCoaLD3q/HFW7pKUx+7rALNbFVjfMGUnf/vzBau3jgrbCGSf6OeyB0TnoJuzRjXkCvsREnvmaAeDbH/a+yXVmpD7isQ==
Received: from DUZPR01CA0292.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::14) by AM7PR07MB6439.eurprd07.prod.outlook.com
 (2603:10a6:20b:13d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 10:30:25 +0000
Received: from DU2PEPF0001E9C5.eurprd03.prod.outlook.com
 (2603:10a6:10:4b7:cafe::c) by DUZPR01CA0292.outlook.office365.com
 (2603:10a6:10:4b7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF0001E9C5.mail.protection.outlook.com (10.167.8.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:25 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnQ029578;
	Tue, 15 Oct 2024 10:30:24 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 22/44] tcp: accecn: AccECN option
Date: Tue, 15 Oct 2024 12:29:18 +0200
Message-Id: <20241015102940.26157-23-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C5:EE_|AM7PR07MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: c4308f58-52a0-49d0-4a08-08dced0461d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3JSLzd3YklHV2hITEczenY3WVFPbUtNSmJnNlhVZHVuaVNteldJRXgvVDVF?=
 =?utf-8?B?OUFTbDBXU1kycElXcDNIVHV6TkJLRjEyUG9rRGVCRGExLy9ia3B1TDE5K0JJ?=
 =?utf-8?B?QllLeXN4YWE1cWJqQklsTFJ6QlZYWTBHbGJuamFWUk02NGt4cTczeklMd0RY?=
 =?utf-8?B?VElEMGFWTlNacWZYNWp0ME94ZFpOTW1aVjU2eHhFMnBISjE5ck1YMjFnOWdQ?=
 =?utf-8?B?U0pzSFY3NFRKYmZpblpTWmhEeU5VSlo2YklDaHlXd0JTeC93Yms2MTJtcGpx?=
 =?utf-8?B?MUJxVmgyQXBCMGxOVTA2VXNMRVJHYXdPWFF5OVduaXd2eWVkQTl1aWY4NVcx?=
 =?utf-8?B?YStVeUwzRG0wWHNWajFVbWhnQ2NiYzlIb29JYlI1ZUpaVG5Kd1ZTWEhmNHVW?=
 =?utf-8?B?eXc5VzU2ZmY2aUZxQ0cwcEt0S2NValIyQkE2cFJqM3hmUWhMOFNpOUF0T1Fm?=
 =?utf-8?B?WlgzTjRlK1JJUFdlcHo4bERVT0pCMDZza0FOb3ltcGVmczVOVTdocisvaWJt?=
 =?utf-8?B?V0xyVDR6Yk56dEtuMFlDY1ladVlCVU9NdGFCVHpjUFllcCswcTlrT3dFeUU2?=
 =?utf-8?B?RTlWOFg4elNVVlZFRUhSNTJRTWdWbWJRclNHTkpjeDdVSG40OXFQSXJWU0ZO?=
 =?utf-8?B?Zm83OFVTYkhMZEhzQnRFY2RKZ04vRGozL2R3Q05wSTBtTkV1VTBrRmE0bEN3?=
 =?utf-8?B?UDVOUGs1L1Q0VGNBdEdlOXRKcm5GamRZSktxamw2UXZJWFlCaVZMdHkwaFBB?=
 =?utf-8?B?eE5TdWc5dXBxM0pQL0lWckpoNlhvb2pkcmI5SUp3QlBaZXdYVGpjV2FIVllP?=
 =?utf-8?B?WmRMNzIyVWlvNmRKRXZrQ0c4M0xDc0JIWjhlazQ2OTR0RXQwY3piV3c5OFBB?=
 =?utf-8?B?SkpqMEtzK0ZDYjFsOW5rMzR5R01SVll1OWNyVi9ZYTB2bkFqK1U0K0xqcVVK?=
 =?utf-8?B?RVFZZUljTlcvNlRDVUlWQVQzbnBzV0tqMHlrVGVleXJnQ1czRk5Kc3JMakRT?=
 =?utf-8?B?MVVlQTZ6dmYveGo5L0V5NU1IRUNyZXN3d0dQMWZzeEhUUmRLY1kwWEFidnls?=
 =?utf-8?B?TnpVZDdBMlU3aGFocWdhejlkUFcwVEZUbENqNlE5Mit0SCtjOWRwRDUxZ1kz?=
 =?utf-8?B?RnFtTGVUajg5SHVyeEs5U0lkNzRsU2ZlbXlzT0NQd1h4cE9EaUJtTXBqMVp3?=
 =?utf-8?B?VE5kYWU2b3VPYVBkT0xhTDE2ZDcranJhcXdzN3B3Mk1uSXd3MHJabW5PNDlv?=
 =?utf-8?B?aC92NnFYWE85YlQ5T1dSUmtXUC94WUFnVHlsekdGOW0rVTA3TlB2TDMrV2NV?=
 =?utf-8?B?UXNTTW5DZzRtcmJQK1VXV0VWV2VTK0xGdTlQc3dZK2VyczVvcko4UGxCNmRp?=
 =?utf-8?B?ZklwNUhCbEIwVXFPc3Q5R1pGTTBqYVRxODdTVVZXWWNtNmk5N3lGaEVCdmpo?=
 =?utf-8?B?MzNuWEdPWmZmMkxGejFiU3FSZE1icVZvdUZmeitnbVNvaEVxb21qS0NVNm9B?=
 =?utf-8?B?RlNrUmhSSm03QlVITHJoMTh0a2MvcE1DQ3FkaENWV2RNaEgvU2Rnby9wQnZk?=
 =?utf-8?B?L0hRZkU5bHMvcjBBVTNHZlVCSzZUWGVadHVXSEFEY09tdVpWcUh1NW5QT2FI?=
 =?utf-8?B?MFRMUzNKTHpja3pua2F0OHZ6RmJmYUkwcmdKL3Z4eE5ycng5SWZxMmpjYUFl?=
 =?utf-8?B?a3R6Nk5tOEhIeDJIMEJNV3NXQUw4ajEvcGoxc1Y0amdRTytSQnVlY2h2OFUz?=
 =?utf-8?B?YlNNWkF6WlU3cW5pcXZWWTErRmtBSUZFZ2FkeXhpTGcvRUgrRVlvaXFGNU5C?=
 =?utf-8?B?UVZnSTlKeDNWcDd3cUw0R3lYTDRZV3ZQUFo1bEhVZ1VTMUJvb1c1dVNQYkVY?=
 =?utf-8?Q?n9RT5IPt40Si5?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:25.5422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4308f58-52a0-49d0-4a08-08dced0461d8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6439

From: Ilpo Järvinen <ij@kernel.org>

The Accurate ECN allows echoing back the sum of bytes for
each IP ECN field value in the received packets using
AccECN option. This change implements AccECN option tx & rx
side processing without option send control related features
that are added by a later change.

Based on specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
(Some features of the spec will be added in the later changes
rather than in this one).

A full-length AccECN option is always attempted but if it does
not fit, the minimum length is selected based on the counters
that have changed since the last update. The AccECN option
(with 24-bit fields) often ends in odd sizes so the option
write code tries to take advantage of some nop used to pad
the other TCP options.

The delivered_ecn_bytes pairs with received_ecn_bytes similar
to how delivered_ce pairs with received_ce. In contrast to
ACE field, however, the option is not always available to update
delivered_ecn_bytes. For ACK w/o AccECN option, the delivered
bytes calculated based on the cumulative ACK+SACK information
are assigned to one of the counters using an estimation
heuristic to select the most likely ECN byte counter. Any
estimation error is corrected when the next AccECN option
arrives. It may occur that the heuristic gets too confused
when there are enough different byte counter deltas between
ACKs with the AccECN option in which case the heuristic just
gives up on updating the counters for a while.

tcp_ecn_option sysctl can be used to select option sending
mode for AccECN.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h        |   8 +-
 include/net/netns/ipv4.h   |   1 +
 include/net/tcp.h          |  13 +++
 include/uapi/linux/tcp.h   |   7 ++
 net/ipv4/sysctl_net_ipv4.c |   9 ++
 net/ipv4/tcp.c             |  12 ++-
 net/ipv4/tcp_input.c       | 164 +++++++++++++++++++++++++++++++++++--
 net/ipv4/tcp_ipv4.c        |   1 +
 net/ipv4/tcp_output.c      | 116 ++++++++++++++++++++++++++
 9 files changed, 321 insertions(+), 10 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index aaf84044e127..1d53b184e05e 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -122,8 +122,9 @@ struct tcp_options_received {
 		smc_ok : 1,	/* SMC seen on SYN packet		*/
 		snd_wscale : 4,	/* Window scaling received from sender	*/
 		rcv_wscale : 4;	/* Window scaling to send to receiver	*/
-	u8	saw_unknown:1,	/* Received unknown option		*/
-		unused:7;
+	u8	accecn:6,       /* AccECN index in header, 0=no options */
+		saw_unknown:1,  /* Received unknown option              */
+		unused:1;
 	u8	num_sacks;	/* Number of SACK blocks		*/
 	u16	user_mss;	/* mss requested by user in ioctl	*/
 	u16	mss_clamp;	/* Maximal mss, negotiated at connection setup */
@@ -298,10 +299,13 @@ struct tcp_sock {
 	u32	snd_up;		/* Urgent pointer		*/
 	u32	delivered;	/* Total data packets delivered incl. rexmits */
 	u32	delivered_ce;	/* Like the above but only ECE marked packets */
+	u32	delivered_ecn_bytes[3];
 	u32	received_ce;	/* Like the above but for received CE marked packets */
 	u32	received_ecn_bytes[3];
 	u8	received_ce_pending:4, /* Not yet transmitted cnt of received_ce */
 		unused2:4;
+	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
+		estimate_ecnfield:2;/* ECN field for AccECN delivered estimates */
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
 /*
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 3c014170e001..8a186e99917b 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -135,6 +135,7 @@ struct netns_ipv4 {
 	struct local_ports ip_local_ports;
 
 	u8 sysctl_tcp_ecn;
+	u8 sysctl_tcp_ecn_option;
 	u8 sysctl_tcp_ecn_fallback;
 
 	u8 sysctl_ip_default_ttl;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 56d009723c91..adc520b6eeca 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -202,6 +202,8 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCPOPT_AO		29	/* Authentication Option (RFC5925) */
 #define TCPOPT_MPTCP		30	/* Multipath TCP (RFC6824) */
 #define TCPOPT_FASTOPEN		34	/* Fast open (RFC7413) */
+#define TCPOPT_ACCECN0		172	/* 0xAC: Accurate ECN Order 0 */
+#define TCPOPT_ACCECN1		174	/* 0xAE: Accurate ECN Order 1 */
 #define TCPOPT_EXP		254	/* Experimental */
 /* Magic number to be after the option value for sharing TCP
  * experimental options. See draft-ietf-tcpm-experimental-options-00.txt
@@ -219,6 +221,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCPOLEN_TIMESTAMP      10
 #define TCPOLEN_MD5SIG         18
 #define TCPOLEN_FASTOPEN_BASE  2
+#define TCPOLEN_ACCECN_BASE    2
 #define TCPOLEN_EXP_FASTOPEN_BASE  4
 #define TCPOLEN_EXP_SMC_BASE   6
 
@@ -232,6 +235,13 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCPOLEN_MD5SIG_ALIGNED		20
 #define TCPOLEN_MSS_ALIGNED		4
 #define TCPOLEN_EXP_SMC_BASE_ALIGNED	8
+#define TCPOLEN_ACCECN_PERFIELD		3
+
+/* Maximum number of byte counters in AccECN option + size */
+#define TCP_ACCECN_NUMFIELDS		3
+#define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
+					 TCPOLEN_ACCECN_PERFIELD * \
+					 TCP_ACCECN_NUMFIELDS)
 
 /* tp->accecn_fail_mode */
 #define TCP_ACCECN_ACE_FAIL_SEND       BIT(0)
@@ -1030,6 +1040,9 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	tp->received_ce = 0;
 	tp->received_ce_pending = 0;
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
+	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
+	tp->accecn_minlen = 0;
+	tp->estimate_ecnfield = 0;
 }
 
 /* State flags for sacked in struct tcp_skb_cb */
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 3fe08d7dddaf..8c21fa0463e9 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -295,6 +295,13 @@ struct tcp_info {
 	__u32	tcpi_snd_wnd;	     /* peer's advertised receive window after
 				      * scaling (bytes)
 				      */
+	__u32	tcpi_received_ce;    /* # of CE marks received */
+	__u32	tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters */
+	__u32	tcpi_delivered_e0_bytes;
+	__u32	tcpi_delivered_ce_bytes;
+	__u32	tcpi_received_e1_bytes;
+	__u32	tcpi_received_e0_bytes;
+	__u32	tcpi_received_ce_bytes;
 	__u32	tcpi_rcv_wnd;	     /* local advertised receive window after
 				      * scaling (bytes)
 				      */
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 01fcc6b2045b..0d7c0fea150b 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -728,6 +728,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_FIVE,
 	},
+	{
+		.procname	= "tcp_ecn_option",
+		.data		= &init_net.ipv4.sysctl_tcp_ecn_option,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO,
+	},
 	{
 		.procname	= "tcp_ecn_fallback",
 		.data		= &init_net.ipv4.sysctl_tcp_ecn_fallback,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 39b20901ac6f..ea1fbafd4fd9 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -270,6 +270,7 @@
 
 #include <net/icmp.h>
 #include <net/inet_common.h>
+#include <net/inet_ecn.h>
 #include <net/tcp.h>
 #include <net/mptcp.h>
 #include <net/proto_memory.h>
@@ -4178,6 +4179,14 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 	info->tcpi_rehash = tp->plb_rehash + tp->timeout_rehash;
 	info->tcpi_fastopen_client_fail = tp->fastopen_client_fail;
 
+	info->tcpi_received_ce = tp->received_ce;
+	info->tcpi_delivered_e1_bytes = tp->delivered_ecn_bytes[INET_ECN_ECT_1 - 1];
+	info->tcpi_delivered_e0_bytes = tp->delivered_ecn_bytes[INET_ECN_ECT_0 - 1];
+	info->tcpi_delivered_ce_bytes = tp->delivered_ecn_bytes[INET_ECN_CE - 1];
+	info->tcpi_received_e1_bytes = tp->received_ecn_bytes[INET_ECN_ECT_1 - 1];
+	info->tcpi_received_e0_bytes = tp->received_ecn_bytes[INET_ECN_ECT_0 - 1];
+	info->tcpi_received_ce_bytes = tp->received_ecn_bytes[INET_ECN_CE - 1];
+
 	info->tcpi_total_rto = tp->total_rto;
 	info->tcpi_total_rto_recoveries = tp->total_rto_recoveries;
 	info->tcpi_total_rto_time = tp->total_rto_time;
@@ -5028,6 +5037,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, snd_up);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
@@ -5037,7 +5047,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 109 + 3);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 122 + 6);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f70b65034e45..6daeced890f7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -70,6 +70,7 @@
 #include <linux/sysctl.h>
 #include <linux/kernel.h>
 #include <linux/prefetch.h>
+#include <linux/bitops.h>
 #include <net/dst.h>
 #include <net/tcp.h>
 #include <net/proto_memory.h>
@@ -490,6 +491,136 @@ static bool tcp_ecn_rcv_ecn_echo(const struct tcp_sock *tp, const struct tcphdr
 	return false;
 }
 
+/* Maps IP ECN field ECT/CE code point to AccECN option field number, given
+ * we are sending fields with Accurate ECN Order 1: ECT(1), CE, ECT(0).
+ */
+static u8 tcp_ecnfield_to_accecn_optfield(u8 ecnfield)
+{
+	switch (ecnfield) {
+	case INET_ECN_NOT_ECT:
+		return 0;	/* AccECN does not send counts of NOT_ECT */
+	case INET_ECN_ECT_1:
+		return 1;
+	case INET_ECN_CE:
+		return 2;
+	case INET_ECN_ECT_0:
+		return 3;
+	default:
+		WARN_ONCE(1, "bad ECN code point: %d\n", ecnfield);
+	}
+	return 0;
+}
+
+/* Maps IP ECN field ECT/CE code point to AccECN option field value offset.
+ * Some fields do not start from zero, to detect zeroing by middleboxes.
+ */
+static u32 tcp_accecn_field_init_offset(u8 ecnfield)
+{
+	switch (ecnfield) {
+	case INET_ECN_NOT_ECT:
+		return 0;	/* AccECN does not send counts of NOT_ECT */
+	case INET_ECN_ECT_1:
+		return TCP_ACCECN_E1B_INIT_OFFSET;
+	case INET_ECN_CE:
+		return TCP_ACCECN_CEB_INIT_OFFSET;
+	case INET_ECN_ECT_0:
+		return TCP_ACCECN_E0B_INIT_OFFSET;
+	default:
+		WARN_ONCE(1, "bad ECN code point: %d\n", ecnfield);
+	}
+	return 0;
+}
+
+/* Maps AccECN option field #nr to IP ECN field ECT/CE bits */
+static unsigned int tcp_accecn_optfield_to_ecnfield(unsigned int optfield, bool order)
+{
+	u8 tmp;
+
+	optfield = order ? 2 - optfield : optfield;
+	tmp = optfield + 2;
+
+	return (tmp + (tmp >> 2)) & INET_ECN_MASK;
+}
+
+/* Handles AccECN option ECT and CE 24-bit byte counters update into
+ * the u32 value in tcp_sock. As we're processing TCP options, it is
+ * safe to access from - 1.
+ */
+static s32 tcp_update_ecn_bytes(u32 *cnt, const char *from, u32 init_offset)
+{
+	u32 truncated = (get_unaligned_be32(from - 1) - init_offset) & 0xFFFFFFU;
+	u32 delta = (truncated - *cnt) & 0xFFFFFFU;
+
+	/* If delta has the highest bit set (24th bit) indicating negative,
+	 * sign extend to correct an estimation using sign_extend32(delta, 24 - 1)
+	 */
+	delta = sign_extend32(delta, 23);
+	*cnt += delta;
+	return (s32)delta;
+}
+
+/* Returns true if the byte counters can be used */
+static bool tcp_accecn_process_option(struct tcp_sock *tp,
+				      const struct sk_buff *skb,
+				      u32 delivered_bytes, int flag)
+{
+	u8 estimate_ecnfield = tp->estimate_ecnfield;
+	bool ambiguous_ecn_bytes_incr = false;
+	bool first_changed = false;
+	unsigned int optlen;
+	unsigned char *ptr;
+	bool order1, res;
+	unsigned int i;
+
+	if (!(flag & FLAG_SLOWPATH) || !tp->rx_opt.accecn) {
+		if (estimate_ecnfield) {
+			tp->delivered_ecn_bytes[estimate_ecnfield - 1] += delivered_bytes;
+			return true;
+		}
+		return false;
+	}
+
+	ptr = skb_transport_header(skb) + tp->rx_opt.accecn;
+	optlen = ptr[1] - 2;
+	WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1);
+	order1 = (ptr[0] == TCPOPT_ACCECN1);
+	ptr += 2;
+
+	res = !!estimate_ecnfield;
+	for (i = 0; i < 3; i++) {
+		if (optlen >= TCPOLEN_ACCECN_PERFIELD) {
+			u8 ecnfield = tcp_accecn_optfield_to_ecnfield(i, order1);
+			u32 init_offset = tcp_accecn_field_init_offset(ecnfield);
+			s32 delta;
+
+			delta = tcp_update_ecn_bytes(&tp->delivered_ecn_bytes[ecnfield - 1],
+						     ptr, init_offset);
+			if (delta) {
+				if (delta < 0) {
+					res = false;
+					ambiguous_ecn_bytes_incr = true;
+				}
+				if (ecnfield != estimate_ecnfield) {
+					if (!first_changed) {
+						tp->estimate_ecnfield = ecnfield;
+						first_changed = true;
+					} else {
+						res = false;
+						ambiguous_ecn_bytes_incr = true;
+					}
+				}
+			}
+
+			optlen -= TCPOLEN_ACCECN_PERFIELD;
+			ptr += TCPOLEN_ACCECN_PERFIELD;
+		}
+	}
+	if (ambiguous_ecn_bytes_incr)
+		tp->estimate_ecnfield = 0;
+
+	return res;
+}
+
 static void tcp_count_delivered_ce(struct tcp_sock *tp, u32 ecn_count)
 {
 	tp->delivered_ce += ecn_count;
@@ -506,7 +637,7 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
-				u32 delivered_pkts, int flag)
+				u32 delivered_pkts, u32 delivered_bytes, int flag)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 delta, safe_delta;
@@ -516,6 +647,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
 		return 0;
 
+	tcp_accecn_process_option(tp, skb, delivered_bytes, flag);
+
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
 		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
@@ -540,12 +673,13 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 }
 
 static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
-			      u32 delivered_pkts, int *flag)
+			      u32 delivered_pkts, u32 delivered_bytes, int *flag)
 {
 	u32 delta;
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	delta = __tcp_accecn_process(sk, skb, delivered_pkts, *flag);
+	delta = __tcp_accecn_process(sk, skb, delivered_pkts,
+				     delivered_bytes, *flag);
 	if (delta > 0) {
 		tcp_count_delivered_ce(tp, delta);
 		*flag |= FLAG_ECE;
@@ -4198,7 +4332,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	tcp_rack_update_reo_wnd(sk, &rs);
 
 	if (tcp_ecn_mode_accecn(tp))
-		ecn_count = tcp_accecn_process(sk, skb, tp->delivered - delivered, &flag);
+		ecn_count = tcp_accecn_process(sk, skb, tp->delivered - delivered,
+					       sack_state.delivered_bytes, &flag);
 
 	tcp_in_ack_event(sk, flag);
 
@@ -4235,7 +4370,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 no_queue:
 	if (tcp_ecn_mode_accecn(tp))
-		ecn_count = tcp_accecn_process(sk, skb, tp->delivered - delivered, &flag);
+		ecn_count = tcp_accecn_process(sk, skb, tp->delivered - delivered,
+					       sack_state.delivered_bytes, &flag);
 	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
@@ -4363,6 +4499,7 @@ void tcp_parse_options(const struct net *net,
 
 	ptr = (const unsigned char *)(th + 1);
 	opt_rx->saw_tstamp = 0;
+	opt_rx->accecn = 0;
 	opt_rx->saw_unknown = 0;
 
 	while (length > 0) {
@@ -4454,6 +4591,12 @@ void tcp_parse_options(const struct net *net,
 					ptr, th->syn, foc, false);
 				break;
 
+			case TCPOPT_ACCECN0:
+			case TCPOPT_ACCECN1:
+				/* Save offset of AccECN option in TCP header */
+				opt_rx->accecn = (ptr - 2) - (__u8 *)th;
+				break;
+
 			case TCPOPT_EXP:
 				/* Fast Open option shares code 254 using a
 				 * 16 bits magic number.
@@ -4514,11 +4657,14 @@ static bool tcp_fast_parse_options(const struct net *net,
 	 */
 	if (th->doff == (sizeof(*th) / 4)) {
 		tp->rx_opt.saw_tstamp = 0;
+		tp->rx_opt.accecn = 0;
 		return false;
 	} else if (tp->rx_opt.tstamp_ok &&
 		   th->doff == ((sizeof(*th) + TCPOLEN_TSTAMP_ALIGNED) / 4)) {
-		if (tcp_parse_aligned_timestamp(tp, th))
+		if (tcp_parse_aligned_timestamp(tp, th)) {
+			tp->rx_opt.accecn = 0;
 			return true;
+		}
 	}
 
 	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL);
@@ -6111,8 +6257,11 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 		tp->received_ce += pcount;
 		tp->received_ce_pending = min(tp->received_ce_pending + pcount, 0xfU);
 
-		if (payload_len > 0)
+		if (payload_len > 0) {
+			u8 minlen = tcp_ecnfield_to_accecn_optfield(ecnfield);
 			tp->received_ecn_bytes[ecnfield - 1] += payload_len;
+			tp->accecn_minlen = max_t(u8, tp->accecn_minlen, minlen);
+		}
 	}
 }
 
@@ -6322,6 +6471,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 	 */
 
 	tp->rx_opt.saw_tstamp = 0;
+	tp->rx_opt.accecn = 0;
 
 	/*	pred_flags is 0xS?10 << 16 + snd_wnd
 	 *	if header_prediction is to be made
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 97df9f36714c..e632327f19f8 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3447,6 +3447,7 @@ static void __net_init tcp_set_hashinfo(struct net *net)
 static int __net_init tcp_sk_init(struct net *net)
 {
 	net->ipv4.sysctl_tcp_ecn = 2;
+	net->ipv4.sysctl_tcp_ecn_option = 2;
 	net->ipv4.sysctl_tcp_ecn_fallback = 1;
 
 	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d6f16c82eb1b..bddd0b309443 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -487,6 +487,7 @@ static inline bool tcp_urg_mode(const struct tcp_sock *tp)
 #define OPTION_SMC		BIT(9)
 #define OPTION_MPTCP		BIT(10)
 #define OPTION_AO		BIT(11)
+#define OPTION_ACCECN		BIT(12)
 
 static void smc_options_write(__be32 *ptr, u16 *options)
 {
@@ -508,12 +509,14 @@ struct tcp_out_options {
 	u16 mss;		/* 0 to disable */
 	u8 ws;			/* window scale, 0 to disable */
 	u8 num_sack_blocks;	/* number of SACK blocks to include */
+	u8 num_accecn_fields;	/* number of AccECN fields needed */
 	u8 hash_size;		/* bytes in hash_location */
 	u8 bpf_opt_len;		/* length of BPF hdr option */
 	__u8 *hash_location;	/* temporary pointer, overloaded */
 	__u32 tsval, tsecr;	/* need to include OPTION_TS */
 	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
 	struct mptcp_out_options mptcp;
+	u32 *ecn_bytes;		/* AccECN ECT/CE byte counters */
 };
 
 static void mptcp_options_write(struct tcphdr *th, __be32 *ptr,
@@ -760,6 +763,39 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		*ptr++ = htonl(opts->tsecr);
 	}
 
+	if (OPTION_ACCECN & options) {
+		u32 e0b = opts->ecn_bytes[INET_ECN_ECT_0 - 1] + TCP_ACCECN_E0B_INIT_OFFSET;
+		u32 e1b = opts->ecn_bytes[INET_ECN_ECT_1 - 1] + TCP_ACCECN_E1B_INIT_OFFSET;
+		u32 ceb = opts->ecn_bytes[INET_ECN_CE - 1] + TCP_ACCECN_CEB_INIT_OFFSET;
+		u8 len = TCPOLEN_ACCECN_BASE +
+			 opts->num_accecn_fields * TCPOLEN_ACCECN_PERFIELD;
+
+		if (opts->num_accecn_fields == 2) {
+			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
+				       ((e1b >> 8) & 0xffff));
+			*ptr++ = htonl(((e1b & 0xff) << 24) |
+				       (ceb & 0xffffff));
+		} else if (opts->num_accecn_fields == 1) {
+			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
+				       ((e1b >> 8) & 0xffff));
+			leftover_bytes = ((e1b & 0xff) << 8) |
+					 TCPOPT_NOP;
+			leftover_size = 1;
+		} else if (opts->num_accecn_fields == 0) {
+			leftover_bytes = (TCPOPT_ACCECN1 << 8) | len;
+			leftover_size = 2;
+		} else if (opts->num_accecn_fields == 3) {
+			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
+				       ((e1b >> 8) & 0xffff));
+			*ptr++ = htonl(((e1b & 0xff) << 24) |
+				       (ceb & 0xffffff));
+			*ptr++ = htonl(((e0b & 0xffffff) << 8) |
+				       TCPOPT_NOP);
+		}
+		if (tp)
+			tp->accecn_minlen = 0;
+	}
+
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
 		*ptr++ = htonl((leftover_bytes << 16) |
 			       (TCPOPT_SACK_PERM << 8) |
@@ -880,6 +916,60 @@ static void mptcp_set_option_cond(const struct request_sock *req,
 	}
 }
 
+/* Initial values for AccECN option, ordered is based on ECN field bits
+ * similar to received_ecn_bytes. Used for SYN/ACK AccECN option.
+ */
+u32 synack_ecn_bytes[3] = { 0, 0, 0 };
+
+static u32 tcp_synack_options_combine_saving(struct tcp_out_options *opts)
+{
+	/* How much there's room for combining with the alignment padding? */
+	if ((opts->options & (OPTION_SACK_ADVERTISE | OPTION_TS)) ==
+	    OPTION_SACK_ADVERTISE)
+		return 2;
+	else if (opts->options & OPTION_WSCALE)
+		return 1;
+	return 0;
+}
+
+/* Calculates how long AccECN option will fit to @remaining option space.
+ *
+ * AccECN option can sometimes replace NOPs used for alignment of other
+ * TCP options (up to @max_combine_saving available).
+ *
+ * Only solutions with at least @required AccECN fields are accepted.
+ *
+ * Returns: The size of the AccECN option excluding space repurposed from
+ * the alignment of the other options.
+ */
+static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
+				  int remaining, int max_combine_saving)
+{
+	int size = TCP_ACCECN_MAXSIZE;
+
+	opts->num_accecn_fields = TCP_ACCECN_NUMFIELDS;
+
+	while (opts->num_accecn_fields >= required) {
+		int leftover_size = size & 0x3;
+		/* Pad to dword if cannot combine */
+		if (leftover_size > max_combine_saving)
+			leftover_size = -((4 - leftover_size) & 0x3);
+
+		if (remaining >= size - leftover_size) {
+			size -= leftover_size;
+			break;
+		}
+
+		opts->num_accecn_fields--;
+		size -= TCPOLEN_ACCECN_PERFIELD;
+	}
+	if (opts->num_accecn_fields < required)
+		return 0;
+
+	opts->options |= OPTION_ACCECN;
+	return size;
+}
+
 /* Compute TCP options for SYN packets. This is not the final
  * network wire format yet.
  */
@@ -960,6 +1050,16 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 		}
 	}
 
+	/* Simultaneous open SYN/ACK needs AccECN option but not SYN */
+	if (unlikely((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) &&
+		     tcp_ecn_mode_accecn(tp) &&
+		     sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
+		     remaining >= TCPOLEN_ACCECN_BASE)) {
+		opts->ecn_bytes = synack_ecn_bytes;
+		remaining -= tcp_options_fit_accecn(opts, 0, remaining,
+						    tcp_synack_options_combine_saving(opts));
+	}
+
 	bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts, &remaining);
 
 	return MAX_TCP_OPTION_SPACE - remaining;
@@ -977,6 +1077,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 {
 	struct inet_request_sock *ireq = inet_rsk(req);
 	unsigned int remaining = MAX_TCP_OPTION_SPACE;
+	struct tcp_request_sock *treq = tcp_rsk(req);
 
 	if (tcp_key_is_md5(key)) {
 		opts->options |= OPTION_MD5;
@@ -1033,6 +1134,13 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
 
+	if (treq->accecn_ok && sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
+	    remaining >= TCPOLEN_ACCECN_BASE) {
+		opts->ecn_bytes = synack_ecn_bytes;
+		remaining -= tcp_options_fit_accecn(opts, 0, remaining,
+						    tcp_synack_options_combine_saving(opts));
+	}
+
 	bpf_skops_hdr_opt_len((struct sock *)sk, skb, req, syn_skb,
 			      synack_type, opts, &remaining);
 
@@ -1103,6 +1211,14 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 		opts->num_sack_blocks = 0;
 	}
 
+	if (tcp_ecn_mode_accecn(tp) &&
+	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
+		opts->ecn_bytes = tp->received_ecn_bytes;
+		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
+					       MAX_TCP_OPTION_SPACE - size,
+					       opts->num_sack_blocks > 0 ? 2 : 0);
+	}
+
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
 					    BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG))) {
 		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
-- 
2.34.1


