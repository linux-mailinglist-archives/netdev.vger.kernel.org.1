Return-Path: <netdev+bounces-135545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6524299E3E7
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890231C22459
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148F11E9073;
	Tue, 15 Oct 2024 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="r29DWLfc"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318941E766B
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988225; cv=fail; b=bPJc2C+vXqyrjLBhc799G59hx+AlucKFptDv/7uVJNqkXIZpiFgcx0UsEH7rG+iM3tFgq5nX//h5TxGSfZ3cMMrUS1L0JJ5jm/Y12RzeRye5R2mYL7COCJPo6rlrNSGN6GyOx5GEGuwHsiVvrXX0VMnADJhchA3xZfO0B9ZnEzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988225; c=relaxed/simple;
	bh=jdXed6V/Yh0NaH+TDgmUGtmxQ71q3BvRQy9Z+lTQNLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aIDReQx07a4tD4I6RmBudh0/Wg58Agzp5Ox9/KDrFMXCrJE6S1IkOvr9mGN+GTuw+LshcsB2it68uVJbrkh25wMQrW07mYJ9ysjJRFye9HJMnha3tRr4KN7zpc0j+xNEbk0+RVaHLEYqON3Wbtl1aT8pE39M2149g/t3i3NS+Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=r29DWLfc; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcPVpn0HKm1wU/rJvkRFv1jKeKHJT7H/rMp2ReEZPLZNtHnWozb5Hz5r/Pe/jWVuIvnGG4OKms1OVaikL7GgR0mxFAn7pp83eb4ae4IaoYJO+Z69uNr1e55hhcuMzAZPfMdwxe4aW+97WkB6MZTktx200H3B9V6SBFdkTqbaQBPqRGjcVufUuiC4yiLePSSfSjCSrveqEAUUJEUm587RPlNOWOHa5Q9ufF6gTxOOQPNC3+LWGokknWed6JY5LwSYZBYlJA4VqxBJ5zcX4CJQviRbH73N2mdOmocgh0EMMWQZeIHQ+NmegrMJx+LtthasMLRV8wE5Qjvf6mmEFPa4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULMd+A5h7VJxRvwiM7CWeriIZLgKm/nirYpOmNuOV6E=;
 b=DQvQQEr7GA8tXWshw17+3rAZbGIhLhjeDCz6T39Gj7/gnI6+rrSm6DTb6/fm3BXYFFxazT3PAMujAqQ680uPNQOHph6N1lIP/1Ho4S4L9QGWpJYXP059x9j0YSzKreCz3j2WQlVpNzaDQoGMuwejaIy35+obzGL6KwHOHn4F3IrMlDHo0KVEYXkwoyOegTC8ABGqnCjBqStet1CHZJSB0uz3qrCUieDueoFm+pkwQdZbTeK1yxKrAkuq45BafUnvdOvdGBGMMlFoTpjD2Z4OFdExCxn//yGd9VvGGIpwMQaAnBK9XXflpDLR+MSyk8cv4HjObhQ3J0+SlUDK60lo2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULMd+A5h7VJxRvwiM7CWeriIZLgKm/nirYpOmNuOV6E=;
 b=r29DWLfcZvhsO0ORUZ+z6i/Fs48eWHZ7cszsgeZ5MKjcKbYe2Uk2R6uVUfPxmlgdtAmh9o3zrMHK5YmYTWmwG6/3y8xTOTVpIrv0SLuLePxst+vL9AMJLw7/1Op4wdG2HXk8xCOwxgoMb2kIDd+xH1nffjZmbR+gPPnNog25slWinfzZzV/eT2oISA+XzkaLmVeBKPF6Hf1CNrMY6uLCHpHgqF9vC4HBm/JJ9ihFl+R6GUVO5N3+znAUPm6HNyYmTUe3uLkHvbqqi7betRPLL4PuJ8CC6cutS/tGNvpligoIHvBmf6V4I0uh2Dx2qBr86N8lTPVLObR8Ta1pyLFcnQ==
Received: from AM5PR0601CA0065.eurprd06.prod.outlook.com (2603:10a6:206::30)
 by VI1PR0701MB6799.eurprd07.prod.outlook.com (2603:10a6:800:190::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 10:30:17 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:206:0:cafe::19) by AM5PR0601CA0065.outlook.office365.com
 (2603:10a6:206::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 15 Oct 2024 10:30:17 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnC029578;
	Tue, 15 Oct 2024 10:30:16 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 08/44] tcp: helpers for ECN mode handling
Date: Tue, 15 Oct 2024 12:29:04 +0200
Message-Id: <20241015102940.26157-9-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019C:EE_|VI1PR0701MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: b7138d3a-f4a2-424f-84f8-08dced045cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWZvNkRiUFZXRzg3LzhmVGZPQWwwak44ekNaUUIwSUUrTjR0bFZjSXVENms2?=
 =?utf-8?B?NkM3RXJxVXlMR0l1Sy9CVlBGekQyd3VPTUhGVVc2ZEllbXI1NFFhSDZhN1F0?=
 =?utf-8?B?RTI4OXg1RkdYOVFjRVYyZ1VQRkluWG9IQjFVdWJZWUVML1ZPdEdIMmV0Smhk?=
 =?utf-8?B?RUhiUmNUVDVzUWtjMFdKSFpSbnh1bkx2NmJFNUNaYnNLbVBiV1dCaDlXNHhn?=
 =?utf-8?B?N3cyckN4TFJtL085czlnbklaaFNKeFlkOWZBUEp4azMxWXZ2VTMrVzhKODM5?=
 =?utf-8?B?Mk5ITWF1S1VKTiszR0JTd1RMQlBVUXlaZVM1SE1heWFPRDV3bFZPVVNaRlAx?=
 =?utf-8?B?MjhDb0pqYXE2Ukk5U2pPajRNSWRsays2UkZNSWovNXVzNzdOTzhBL1V5ME0y?=
 =?utf-8?B?Nmg4dkNZeU9xS2d0YzlsVVJSMUFaeGNqYTFTOVd0TEJianZncldzVUtXMnhi?=
 =?utf-8?B?S1VuOUszSFNqUDQ1dWg3YktvQUVvM0RTV0ZJWEg3WTMxMWJTS29iNzdYRzQ0?=
 =?utf-8?B?blN6SEtnWDc5dVYyR2NrSXc1Mk5vYVUxdU5aazI1WkhDbnhwNDdvQmVqWVdV?=
 =?utf-8?B?NFBkYUdweWhNc0YzVkduSmVobmN3SGZJWXF0ekRPd3FIUVBWL0d0Ni9TVEJo?=
 =?utf-8?B?OWZXWkxlWGhOdi9HMnZ1ckl0SThtN2tCSEZUM29iNkZwdXB6L3ZHZm9oT0xH?=
 =?utf-8?B?cGRUZlRjWEl6cjI3RXRmL1lJL0xhK1pHbGxDOURaRVA4WFIwd2U1VHFkZmQz?=
 =?utf-8?B?eXl4YkhwQVR6enJIZ3NnZUtmbDNiUEdMNDFIYnhlUDRiN3lLZjRSSFZMNG5E?=
 =?utf-8?B?Y1lzSkVldDVybjNVOHVkNURiSGpnY3A4cmhTRDBFSVRURzVocVBxOEFzU0oz?=
 =?utf-8?B?UFkvRkpPSlhtdFB0ajAydTRMRTh1bHR5YjlUTXh3UEhUbGovSTludVBSMnBs?=
 =?utf-8?B?b2s2YytoV1kzOFpla0czQWhFUzk0NXJ5UGprVGZWaVYrMXlWZWNIK2JBZUY3?=
 =?utf-8?B?K1ozV2lLKy96a1JNM09lMUNrLzd3MDR6TmhuU2ZYeXZtQzNYY3FqQzBSQ0FV?=
 =?utf-8?B?VmwxbVdLZVJuNHZXY1B2cGs3ekRTZFRuVzdjMC9zZVl5TFVSd3Z3MjJNWFBu?=
 =?utf-8?B?bGxzVHJuMzUvMjVhV2tWSkxEbzRkZFBWdWVxeitsTVNjZU5aOG5uWGdCT2xj?=
 =?utf-8?B?VytmU3NrT3BXanEzSjVtUXpnaitVRTJ1Z2FTc2wwWVp1aGhaMWtkZ05VQ1Bo?=
 =?utf-8?B?OWNmb3RxbHhlczZkU2M1ZTJqUi9tZkRtUnlzQ3VsMzdneXVuZzJDQ08vcE0x?=
 =?utf-8?B?RGc1aHRrclZiR0ZxT2tRMFAramlaRUFBcmkvcUhTei8wUXQ0Snl5RTY3dG85?=
 =?utf-8?B?UVAydDR2QXJvRmpRQkxaaFZRbVNNbDQ2c2tiVWM1Zll0NXNXZDlwNVNaTmlo?=
 =?utf-8?B?YVBFVGk3aFg0VlRXU1E2ZnJCc25tTHpDTWowVURwTGl2Wi9TUXM4UVpWTkVC?=
 =?utf-8?B?U21kbWd6eDdhaCszUzB5d0FUMFFZQXVhdTFmUkRxaWF5MUI4UmZscVBZRjZk?=
 =?utf-8?B?dk44OS9BY0pJcHc1OHFFbTl2a2hQVWtkZTkzeVlFREhiRXVzc2tqUmlLandV?=
 =?utf-8?B?R25janFrcjFWemZzVXFQaVdQbktrZ2JyQ3JBSi9KMjhCa1ZDSnNqZzFFdVZr?=
 =?utf-8?B?SzdQN0w3U0MvM0tNTmhBRFZjVjlnendJbFFHRkw1aUZvSDg4SVlSeFBMY1JS?=
 =?utf-8?B?M3A3NC9NZndkOHpKaDNPZWIwaWtWMHlBS3NHcG5TdUJNTVEzanFuRVJQZjFT?=
 =?utf-8?B?RGwzNzluQ2QxNlpScUZsK05yRlFnL3Izbmx0RS9jb2w2eGZhSlFraER1RTRZ?=
 =?utf-8?Q?G3b6M/dgn3x7U?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:17.3370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7138d3a-f4a2-424f-84f8-08dced045cef
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6799

From: Ilpo Järvinen <ij@kernel.org>

Create helpers for TCP ECN modes. No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h        | 44 ++++++++++++++++++++++++++++++++++++----
 net/ipv4/tcp.c           |  2 +-
 net/ipv4/tcp_dctcp.c     |  2 +-
 net/ipv4/tcp_input.c     | 14 ++++++-------
 net/ipv4/tcp_minisocks.c |  4 +++-
 net/ipv4/tcp_output.c    |  6 +++---
 6 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 549fec6681d0..ae3f900f17c1 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -372,10 +372,46 @@ static inline void tcp_dec_quickack_mode(struct sock *sk)
 	}
 }
 
-#define	TCP_ECN_OK		1
-#define	TCP_ECN_QUEUE_CWR	2
-#define	TCP_ECN_DEMAND_CWR	4
-#define	TCP_ECN_SEEN		8
+#define	TCP_ECN_MODE_RFC3168	BIT(0)
+#define	TCP_ECN_QUEUE_CWR	BIT(1)
+#define	TCP_ECN_DEMAND_CWR	BIT(2)
+#define	TCP_ECN_SEEN		BIT(3)
+#define	TCP_ECN_MODE_ACCECN	BIT(4)
+
+#define	TCP_ECN_DISABLED	0
+#define	TCP_ECN_MODE_PENDING	(TCP_ECN_MODE_RFC3168|TCP_ECN_MODE_ACCECN)
+#define	TCP_ECN_MODE_ANY	(TCP_ECN_MODE_RFC3168|TCP_ECN_MODE_ACCECN)
+
+static inline bool tcp_ecn_mode_any(const struct tcp_sock *tp)
+{
+	return tp->ecn_flags & TCP_ECN_MODE_ANY;
+}
+
+static inline bool tcp_ecn_mode_rfc3168(const struct tcp_sock *tp)
+{
+	return (tp->ecn_flags & TCP_ECN_MODE_ANY) == TCP_ECN_MODE_RFC3168;
+}
+
+static inline bool tcp_ecn_mode_accecn(const struct tcp_sock *tp)
+{
+	return (tp->ecn_flags & TCP_ECN_MODE_ANY) == TCP_ECN_MODE_ACCECN;
+}
+
+static inline bool tcp_ecn_disabled(const struct tcp_sock *tp)
+{
+	return !tcp_ecn_mode_any(tp);
+}
+
+static inline bool tcp_ecn_mode_pending(const struct tcp_sock *tp)
+{
+	return (tp->ecn_flags & TCP_ECN_MODE_PENDING) == TCP_ECN_MODE_PENDING;
+}
+
+static inline void tcp_ecn_mode_set(struct tcp_sock *tp, u8 mode)
+{
+	tp->ecn_flags &= ~TCP_ECN_MODE_ANY;
+	tp->ecn_flags |= mode;
+}
 
 enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 82cc4a5633ce..94546f55385a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4107,7 +4107,7 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 		info->tcpi_rcv_wscale = tp->rx_opt.rcv_wscale;
 	}
 
-	if (tp->ecn_flags & TCP_ECN_OK)
+	if (tcp_ecn_mode_any(tp))
 		info->tcpi_options |= TCPI_OPT_ECN;
 	if (tp->ecn_flags & TCP_ECN_SEEN)
 		info->tcpi_options |= TCPI_OPT_ECN_SEEN;
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index 8a45a4aea933..03abe0848420 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -90,7 +90,7 @@ __bpf_kfunc static void dctcp_init(struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 
-	if ((tp->ecn_flags & TCP_ECN_OK) ||
+	if (tcp_ecn_mode_any(tp) ||
 	    (sk->sk_state == TCP_LISTEN ||
 	     sk->sk_state == TCP_CLOSE)) {
 		struct dctcp *ca = inet_csk_ca(sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7b4e7ed8cc52..e8d32a231a9e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -334,7 +334,7 @@ static bool tcp_in_quickack_mode(struct sock *sk)
 
 static void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
-	if (tp->ecn_flags & TCP_ECN_OK)
+	if (tcp_ecn_mode_rfc3168(tp))
 		tp->ecn_flags |= TCP_ECN_QUEUE_CWR;
 }
 
@@ -361,7 +361,7 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (!(tcp_sk(sk)->ecn_flags & TCP_ECN_OK))
+	if (tcp_ecn_disabled(tp))
 		return;
 
 	switch (TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK) {
@@ -394,19 +394,19 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 
 static void tcp_ecn_rcv_synack(struct tcp_sock *tp, const struct tcphdr *th)
 {
-	if ((tp->ecn_flags & TCP_ECN_OK) && (!th->ece || th->cwr))
-		tp->ecn_flags &= ~TCP_ECN_OK;
+	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || th->cwr))
+		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
 
 static void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th)
 {
-	if ((tp->ecn_flags & TCP_ECN_OK) && (!th->ece || !th->cwr))
-		tp->ecn_flags &= ~TCP_ECN_OK;
+	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || !th->cwr))
+		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
 
 static bool tcp_ecn_rcv_ecn_echo(const struct tcp_sock *tp, const struct tcphdr *th)
 {
-	if (th->ece && !th->syn && (tp->ecn_flags & TCP_ECN_OK))
+	if (th->ece && !th->syn && tcp_ecn_mode_rfc3168(tp))
 		return true;
 	return false;
 }
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index bb1fe1ba867a..bd6515ab660f 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -453,7 +453,9 @@ EXPORT_SYMBOL(tcp_openreq_init_rwin);
 static void tcp_ecn_openreq_child(struct tcp_sock *tp,
 				  const struct request_sock *req)
 {
-	tp->ecn_flags = inet_rsk(req)->ecn_ok ? TCP_ECN_OK : 0;
+	tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
+			     TCP_ECN_MODE_RFC3168 :
+			     TCP_ECN_DISABLED);
 }
 
 void tcp_ca_openreq_child(struct sock *sk, const struct dst_entry *dst)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 64d47c18255f..bb83ad43a4e2 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -322,7 +322,7 @@ static void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 	const struct tcp_sock *tp = tcp_sk(sk);
 
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_CWR;
-	if (!(tp->ecn_flags & TCP_ECN_OK))
+	if (tcp_ecn_disabled(tp))
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ECE;
 	else if (tcp_ca_needs_ecn(sk) ||
 		 tcp_bpf_ca_needs_ecn(sk))
@@ -351,7 +351,7 @@ static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 			INET_ECN_xmit(sk);
 
 		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
-		tp->ecn_flags = TCP_ECN_OK;
+		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 	}
 }
 
@@ -379,7 +379,7 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (tp->ecn_flags & TCP_ECN_OK) {
+	if (tcp_ecn_mode_rfc3168(tp)) {
 		/* Not-retransmitted data segment: set ECT and inject CWR. */
 		if (skb->len != tcp_header_len &&
 		    !before(TCP_SKB_CB(skb)->seq, tp->snd_nxt)) {
-- 
2.34.1


