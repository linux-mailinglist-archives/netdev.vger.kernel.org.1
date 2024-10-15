Return-Path: <netdev+bounces-135572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBEF99E404
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D72B2265B
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48EE1F891E;
	Tue, 15 Oct 2024 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="YfGkmBRB"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1800C1F708E
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988239; cv=fail; b=G4iHJXd+Jfqs9tGEBQM2b1KKKKWSL5u6YceE75PU9Qj+PU5+nplvnpf0bOd6DG1tY3UhrTBTTIXyFfUgshFjNs8+4NZAZjiUvDTYaq18y44pO2iw1m0qgIkrMFLBffDCZXxMkP2H7ccP3M4IIak7Fw4gdWBXpfRwA05H7YH8ifM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988239; c=relaxed/simple;
	bh=It0nLWJ5ERsv2/nBf30x/Bie0ZlrrWrfaTha/tDSkvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPm5UZ1CM9206sjvFgrgv06goRvdB+0OiaGUa1ZUAEFhY+Qux9S8T9D7yp+43etAPewBAz3c1SaY5gNZuIDm+ZRWaQX+yukN2tXca9p0gdcHLBRjih7fRnojz2O7qamRxKAuUMy1ODWtHRFOHokymRvNwzu7KsNzYVEz6btbFI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=YfGkmBRB; arc=fail smtp.client-ip=40.107.22.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkjffl+zIL5OKmJrIYJzMUyFnlEJq+elLAyRCWMxsp/mj85grmx/dsjhUaSpxV7GFZ4zDQ8n7d3yQW9c+FIFf3XAmcwi8mTshbLAIyig5M6jGqemRN9iocfMMPSN2ZXPSuHPcvZdQY/3xpf8urZKPEpLkGamQYb75E02wUrGw24PjhLMo/X8vqbpkU4R5aArGkI9dIdU3mMyPeFHMg5m+IFnRGFwDtNV/CDpBuLE9vX7TBInPRZzX/vb3dmtpE3N3QBASWm82CD1SmyKN1gDPnCStNBpQmlN902vJTEClfdAodvE8DkTT2auiY+cs7eCoo0PWO8GH7omeYiicKdrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7/tU67ILY1WUosfmpl0JbHoGFvKVAyGKnyOpbsQfBg=;
 b=AgoqVYPwnBug7enDywIarqEmkVw60qfHz3Pypr/8y/o3lxFEt89UrLhZ/2n47qVQpNl0qgVC/nvHMZ+vzSVjgcGEM3cLsZlQA6HMLow3LacHH1Evb0ZHPy8wBb9Y2v060V4jjD1KDAMQnMA7ZQYpuie5VSfpj/UVIxduVX3S/F+cfqTWPPsL74UETZ9wy/XgNOzbeMU7QK60Uk88QVhWoSBwo67pWRScGghqXPcGd5wBhIwaeQi++U582+x3UWlkvJQSJtcWNj3hcSsaDQK3ddPFXmRxROKtrJR31o2cffGToFjOGrZTvxDoMORIMmJu25q54dwXocOkR1zQbPJL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7/tU67ILY1WUosfmpl0JbHoGFvKVAyGKnyOpbsQfBg=;
 b=YfGkmBRBPQdHYA4N5nKzOe4SRdVJ5xj1IPKysZCwpA0GWgYw4rD2b16Sg56QQABE6Y0/JMOYkN8Yzj5ShCz2ljEMyklawda3sWd2XUN9w+nESNfBwN5qoUxsm6OZ45P50WiPhtCU74u3pbn466Wl6QWB7t9+lZDIbd9aMM6BbH+kbpFe4PPdBRtkZuJmTxYyojY2HKXPcfFWlmg7ulLtcvPmr38rXV8XHY+/eVjdNeIKvvOCBXP8TOFxXCNYZGrHiqJKGN8c502qTpV3wpRXPbnb6DiRu3Vm1IYvxIAHKN5dnKhscoG5u0KIOA6N4LDgMTT1P8l6QelQ1FgzM72Amg==
Received: from DUZPR01CA0259.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::7) by VI1PR0701MB6765.eurprd07.prod.outlook.com
 (2603:10a6:800:192::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 10:30:33 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::33) by DUZPR01CA0259.outlook.office365.com
 (2603:10a6:10:4b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:32 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnZ029578;
	Tue, 15 Oct 2024 10:30:29 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
        Olivier Tilmans <olivier.tilmans@nokia.com>
Subject: [PATCH net-next 31/44] tcp: L4S ECT(1) identifier for CC modules
Date: Tue, 15 Oct 2024 12:29:27 +0200
Message-Id: <20241015102940.26157-32-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|VI1PR0701MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: c14ece64-1532-4215-5253-08dced046639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkczaDFJNDV4MlJwbStOaGpna0NGQ0RYQ0pXU01zRXEzZGlPWWJJcXAvcFR3?=
 =?utf-8?B?SE85OFhLeVNBMDNRK2x0bEwwR2lEVklmeFkrMCtROUJ5UXFrTEUra2M5c2hH?=
 =?utf-8?B?c1ZUTFoxSksxUHJ6QW9EZE1tNjFmekY2emxEMmZnTkc3bTE2TlhTNWI0UTVX?=
 =?utf-8?B?dzJsNERnamJEVVM1UVBoT0tLdEs4TjBkSVNsb0s2VGVpR2hibkZ6dmY0RCtz?=
 =?utf-8?B?WGFNM0xmc29Rd1RCOHUwQ1RPZjl1cGxHZTFOWnNVOWFhdnFlbU1zeVRIeGtT?=
 =?utf-8?B?aVhTRWhSUHloM3Blc1MrTlBxdXJqTmNvaEs1eGgwSVVDOXdnb2VYb0h6bDd4?=
 =?utf-8?B?eVhlOE5kZE5Ta2NCNkd0M3loNTB6YVZBcVFFRFF6VlY0MTJqVlJIc25wMVpU?=
 =?utf-8?B?RTAxS3MxZlpxdmpOSjhldC90bUVSd1VSYm83M3JYZ2I0QlU4cXVzYUNxa3lo?=
 =?utf-8?B?OWJDY0VkMmlyTHQ5SEVES0pkNTV1UVZnWFhzQ1pvVllndkFvTGM1OTdRemx6?=
 =?utf-8?B?TGVNdTBqUHByUUNRMEMxcXVxTVpGdldtbUN0VGdJenhSUVJZRnRkN0d3UjY1?=
 =?utf-8?B?cHRyWGRZUEFDQjZucmhMSjJYTkIxK2ZmNDJLRDQ1aDlsTEU3eHdQSDlxY0Vz?=
 =?utf-8?B?MTAwQmFGejFiNVM2b1BjZ2FwOGhZZ1NMemd4ZjZKekV4ZU85NWZ4RWYvVkZQ?=
 =?utf-8?B?dCtQL3d1dzZYMC9HK0FMQkpObjRGT01FWUdIQWNvVW90NWdKV2k4dUNiK2Zx?=
 =?utf-8?B?SkRLWjRUWEhTTitNUkt5OGdkNlhTaHlycmI3Qkxud0lCVjdpSjVsckxuZk12?=
 =?utf-8?B?Z3ZockJjRmcwMmNiMGxpYWd5aE5NV1pUL1o3SVhQazdjWHVZSWxtUThrdUFh?=
 =?utf-8?B?cGo3aFZySXVOR01EZ0hEbEhwNjVRcUxiQVhKa1BXZEVCTFZXYlNPSWV3OU9k?=
 =?utf-8?B?SldKZnBtdDJlaW45VklNMHRzUDM1TkZKSlE1aFFqOVkzUjdUaEdEN3p2NFlP?=
 =?utf-8?B?T1F3QS9JMjFuVEppVFB1NEtWbmNJQys1a3VLTUo2d2xkZ2Z4TmoxOWdRaEFE?=
 =?utf-8?B?TUtkdEdkU3VWQUtuTG1CYWFZSHpDckhXak8zaFBQUW5QK1RKa3RnVzlQdnZw?=
 =?utf-8?B?bFBxNjNnUG84T2pManB5SjhCZkUzY2hjUnVXTklFRlZjbFpvcWNEWGRrTTZF?=
 =?utf-8?B?d2FCc1BNZDQ4dldQcjVlc2FJNjh2NFBUMWc4d0FDWkxha3VjMUg3VGRtRTAz?=
 =?utf-8?B?aDBMM0l5VStpeTNXQm4rVnZBVTRrUGZCTlNaVHFETk1FV1Z5YmkxN3ljcmZn?=
 =?utf-8?B?QWllRXdMZVd0aG9ERTlwQWtkUW5LbG01RWkvbWN5eDZsL3JBK1UyVy8reEhw?=
 =?utf-8?B?ZE9xT2krY1BPbmVTQ01WWWJ4TFcvVS9COXJWY1RTa0p5ZHA0aVFYN20yVVFP?=
 =?utf-8?B?NWU0RUVJQkNtbU1lUjVZUWtLeEd3dW9pR0lvdUFCa1BBRHhoYVUwdGxjKzV3?=
 =?utf-8?B?SlVsbU9XYkZ4eTlFK09YNG84UUI1STNzU1BYdFZCeFZaRHhuK1gzNG9lWEJ3?=
 =?utf-8?B?R1NjTElHOWkyMXBCb1V6N1JCdjF2Z1NFelRndkhZVDBwbVlVVTlOckJuTVZv?=
 =?utf-8?B?RlovS0JiVEVjaXhFZm9sL0JUNzdRbUJHeFFWRnVXNG1GV21sK25XdUIwbE9s?=
 =?utf-8?B?NE9EL1NUQU9KNDZtSXJvRStKNS9OTHBPSlQzZlJoaUN1c1ZTaHE0VVMvcnVM?=
 =?utf-8?B?YmlUMlZ5WGRhbnpWbXN3SEdzclJ3ZDZQcHVpeHpSaEpabCtNY25wY1gzYjNa?=
 =?utf-8?B?cEtQR3Q2bDdnWTJTZVlFUExrdlVpdEJBazZqMW5ZcXJ4M0IySGpPdXFwbmNt?=
 =?utf-8?Q?CfZHuNXQzVzwA?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:32.8890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c14ece64-1532-4215-5253-08dced046639
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6765

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

When ECN is successfully negociated for a TCP flow, it defaults to
always use ECT(0) in the IP header. L4S service, however, needs to
use ECT(1).

This patch enables congestion control algorithms to control whether
ECT(0) or ECT(1) should be used on a per-segment basis. A new
CA module flag (TCP_CONG_WANTS_ECT_1) defines the behavior
expected by the CA when not-yet initialized for the connection.
As such, it implicitely assumes that the CA also has the
TCP_CONG_NEEDS_ECN set.

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/inet_ecn.h | 20 +++++++++++++++++---
 include/net/tcp.h      |  8 ++++++++
 net/ipv4/tcp_cong.c    |  9 ++++++---
 net/ipv4/tcp_output.c  |  7 ++++---
 4 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/include/net/inet_ecn.h b/include/net/inet_ecn.h
index ea32393464a2..3c64d32a32b0 100644
--- a/include/net/inet_ecn.h
+++ b/include/net/inet_ecn.h
@@ -51,11 +51,25 @@ static inline __u8 INET_ECN_encapsulate(__u8 outer, __u8 inner)
 	return outer;
 }
 
+/* Apply either ECT(0) or ECT(1) */
+static inline void __INET_ECN_xmit(struct sock *sk, bool use_ect_1)
+{
+	__u8 ect = use_ect_1 ? INET_ECN_ECT_1 : INET_ECN_ECT_0;
+
+	/* Mask the complete byte in case the connection alternates between
+	 * ECT(0) and ECT(1).
+	 */
+	inet_sk(sk)->tos &= ~INET_ECN_MASK;
+	inet_sk(sk)->tos |= ect;
+	if (inet6_sk(sk) != NULL) {
+		inet6_sk(sk)->tclass &= ~INET_ECN_MASK;
+		inet6_sk(sk)->tclass |= ect;
+	}
+}
+
 static inline void INET_ECN_xmit(struct sock *sk)
 {
-	inet_sk(sk)->tos |= INET_ECN_ECT_0;
-	if (inet6_sk(sk) != NULL)
-		inet6_sk(sk)->tclass |= INET_ECN_ECT_0;
+	__INET_ECN_xmit(sk, false);
 }
 
 static inline void INET_ECN_dontxmit(struct sock *sk)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 822ae5ceb235..cecbec887508 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -426,6 +426,7 @@ static inline void tcp_dec_quickack_mode(struct sock *sk)
 #define	TCP_ECN_DEMAND_CWR	BIT(2)
 #define	TCP_ECN_SEEN		BIT(3)
 #define	TCP_ECN_MODE_ACCECN	BIT(4)
+#define	TCP_ECN_ECT_1		BIT(5)
 
 #define	TCP_ECN_DISABLED	0
 #define	TCP_ECN_MODE_PENDING	(TCP_ECN_MODE_RFC3168|TCP_ECN_MODE_ACCECN)
@@ -1253,6 +1254,8 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NEEDS_ECN		BIT(1)
 /* Require successfully negotiated AccECN capability */
 #define TCP_CONG_NEEDS_ACCECN		BIT(2)
+/* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
+#define TCP_CONG_WANTS_ECT_1 (TCP_CONG_NEEDS_ECN | TCP_CONG_NEEDS_ACCECN)
 #define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
 			TCP_CONG_NEEDS_ACCECN)
 
@@ -1394,6 +1397,11 @@ static inline bool tcp_ca_needs_accecn(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
 }
 
+static inline bool tcp_ca_wants_ect_1(const struct sock *sk)
+{
+	return inet_csk(sk)->icsk_ca_ops->flags & TCP_CONG_WANTS_ECT_1;
+}
+
 static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 0306d257fa64..7be5fb14428b 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -227,7 +227,7 @@ void tcp_assign_congestion_control(struct sock *sk)
 
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		__INET_ECN_xmit(sk, tcp_ca_wants_ect_1(sk));
 	else
 		INET_ECN_dontxmit(sk);
 }
@@ -240,7 +240,10 @@ void tcp_init_congestion_control(struct sock *sk)
 	if (icsk->icsk_ca_ops->init)
 		icsk->icsk_ca_ops->init(sk);
 	if (tcp_ca_needs_ecn(sk))
-		INET_ECN_xmit(sk);
+		/* The CA is already initialized, expect it to set the
+		 * appropriate flag to select ECT(1).
+		 */
+		__INET_ECN_xmit(sk, tcp_sk(sk)->ecn_flags & TCP_ECN_ECT_1);
 	else
 		INET_ECN_dontxmit(sk);
 	icsk->icsk_ca_initialized = 1;
@@ -257,7 +260,7 @@ static void tcp_reinit_congestion_control(struct sock *sk,
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		__INET_ECN_xmit(sk, tcp_ca_wants_ect_1(sk));
 	else
 		INET_ECN_dontxmit(sk);
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 663cdea1b87b..ec10785f6d00 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -326,7 +326,7 @@ static void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ECE;
 	else if (tcp_ca_needs_ecn(sk) ||
 		 tcp_bpf_ca_needs_ecn(sk))
-		INET_ECN_xmit(sk);
+		__INET_ECN_xmit(sk, tcp_ca_wants_ect_1(sk));
 
 	if (tp->ecn_flags & TCP_ECN_MODE_ACCECN) {
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ACE;
@@ -366,7 +366,7 @@ static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 
 	if (use_ecn) {
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
-			INET_ECN_xmit(sk);
+			__INET_ECN_xmit(sk, tcp_ca_wants_ect_1(sk));
 
 		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
 		if (use_accecn) {
@@ -435,7 +435,8 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 		return;
 
 	if (!tcp_accecn_ace_fail_recv(tp))
-		INET_ECN_xmit(sk);
+		/* The CCA could change the ECT codepoint on the fly, reset it*/
+		__INET_ECN_xmit(sk, tp->ecn_flags & TCP_ECN_ECT_1);
 	if (tcp_ecn_mode_accecn(tp)) {
 		tcp_accecn_set_ace(tp, skb, th);
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
-- 
2.34.1


