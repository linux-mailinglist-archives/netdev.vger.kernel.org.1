Return-Path: <netdev+bounces-135551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DFE99E3EF
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE9CB21457
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042A91E412E;
	Tue, 15 Oct 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="XwLwSoWz"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2076.outbound.protection.outlook.com [40.107.104.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B051EBA1E
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988229; cv=fail; b=bpYl0i/umkZV1/sjL01j/gUfQUnqeCvR8drt4mWD8EfGyqTS7qmhFZrg2ip9tIzY2Gp2g5iSML/IwPjf5O2e0ipZ7QQ6yDYcbq2cTjmsxvvpmxYXSIxHhAGCmkrD6FRfzngZMtV8tgUZrc/X8jEMJ/tmETTqz46rYsnaoQfvnnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988229; c=relaxed/simple;
	bh=wq+YACL4M79rnOB2U9WCUMBS/YrWskt7T1pjReeYWVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+bKpO3woLYGWPWi4hV0ta2H5Jx1W6FaMh81Dw+K0pOz9daReeuQhHLryq0qqAmzErHUmjeR9qD3tckgY5wiIgBaEyILPoSkp5LMyb44541I4rnSAJEF73IDR6hNli1qOhdOqDwSdO8bcnzYpBNkmEZrmGg95JLQmo6HKPKDCXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=XwLwSoWz; arc=fail smtp.client-ip=40.107.104.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhDBbrJaOrmImhTxrSaHklycxB8pxFVRTLcELjvl6QZFmKJTtcBD1O1V2+YIZEJNaYEf8PczZ+jNwhVGo4r09n+fVu6kEnEcDNyQjdp9JFrPm8WeGesKGBdVLXprDClueT5mpPGgAjhtXK5QzuVf+gEwgKy/XaZkRQ/bTkOG9lF5oVwBnMLDDogA432pSQwJijtVVbN4MiS8Z5FTGen/PgbhjQtZRbiDzZdsHR6bvPzBauWmoJ0+i1xUEhMC4pmC3i5jOiCd8kZRjihSATuSmCoqR4VPz/XR5XhsUQY0aq37Nkq2UPAGGJqMWh2ifGuC7ZpF1U+PuDGrbLOqwKcOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54krDeb5Wtqm1Iwnx+98ZHOwIvVbXQwTIw8FVm+uiJk=;
 b=qmbxH9dMcg4JosQVVhsq4+iKK5KxWshfdQziWwpqm+J6+KyV0BzPdtn9Nz1noHvESI1l7emZNX7dCX7xIeN3qUC5s9QZWTFZJ0APRaVblCtGUiqQu77LBldvLIGu3PnVkiAWsghj32DtgpNgEy4WB/edL/Cgu0iOgMAmcAu7shFbl6Z7uqEY1Rf1wuXVfE9Bevc+bCd1jcX/oq3RefdsMPMWSzeC5gnr3YVzY+IinY7wTQpkpMRVkW6oLxBp+tj6FYaRF4SqbrmnS/4UsdD73zbLaHhGNaMnPp+zsnqOXoXNaxTsBvfxmhtPGq81Ee/BTwXMkJGjM5Wl8gUCjIDJgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54krDeb5Wtqm1Iwnx+98ZHOwIvVbXQwTIw8FVm+uiJk=;
 b=XwLwSoWzXjroKlQ+Kn5ys8Vb6eKnTPsdMI9qc5guh6jybVgJ9/wEzihGKf+Tsy8OlYri5xo+ycUz4rQzR4PzHxZW2FQ/xPxhR3SWcZOm7dk7lM5br1e7M/riBaIwDx2HlZojc92Z7ENrBuMKf/grkCmnkKstA7LhEu90vQgqt2vpkCS/KXW7xD3iQZfcrcYwXd9MLyQ9Yd1ahWNpasy2aP2vdRC/zC0/LGqDnGqpdHOlgNp1nQn72IrIKgNimSzY0T9+IxA7PxWZNMXu2sJbZYy9yjnWz9PNjdJTA1PiZR4T6xaNX4aXhU+CJ/BcAncXmmTXq+q4M2hU60s6J51Fyw==
Received: from DBBPR09CA0021.eurprd09.prod.outlook.com (2603:10a6:10:c0::33)
 by AS1PR07MB8710.eurprd07.prod.outlook.com (2603:10a6:20b:479::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 10:30:23 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:c0:cafe::93) by DBBPR09CA0021.outlook.office365.com
 (2603:10a6:10:c0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:23 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnM029578;
	Tue, 15 Oct 2024 10:30:22 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 18/44] tcp: accecn: add AccECN rx byte counters
Date: Tue, 15 Oct 2024 12:29:14 +0200
Message-Id: <20241015102940.26157-19-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0D:EE_|AS1PR07MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: 9783073e-1fb5-41f6-ff1e-08dced046078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2ZMRnZ6THk1QlBlUllCVDJJMXJ0NU9DTVI0K3dyZWpqdWZ4UnRvUklEbms5?=
 =?utf-8?B?SjlLbTdGRGhuL1NVT1VwTVdERzR4WXd3dENyZzk2UjVRbXRZU0F0NlBDL2o0?=
 =?utf-8?B?b0FUTFpGVVFnN1ZzTEQwRGJhY3VNMWphL0pCMXdzMXd1SXUwVEFYTlk0NFlT?=
 =?utf-8?B?NHJRZitJZDh3T1hUa3hmK1IvWW5MZ2p3akt6a1A4ay93THdHTnRTYWNUZW0z?=
 =?utf-8?B?VFQvOG5xOW5TeDdEbGVJTW1icEZwUHZlTHBtYnR5aCtuM1dVeFMramVydDJX?=
 =?utf-8?B?bXQxTXRKejFOTEp6R1lIbkdlWU9Bb0l4WjZsRWFLTzlBSUdSSUtzNERTempE?=
 =?utf-8?B?MUt6dnlRNzVpemowZVJhNTVUbXFNUjVNOXN5ZE00ZlFqQW9Wa2xMZ0t6dzky?=
 =?utf-8?B?dWJ5SE9nOFhEM2tZMUgvMXlMaHc0OFdpODhOVmZCWEtIYU9hRFRWdUlXaytT?=
 =?utf-8?B?cGwzVkFoK1BmUEo5ZWYxWGFFNmxOU3c5N3pzLzR1bFp1Q3JKdTc4NXAzNTNJ?=
 =?utf-8?B?MGRPY1FJZWNZNy8wMlBpMUhaTERsdVI1VzJib29TLy95WlVEV0dUSG9NUlBV?=
 =?utf-8?B?MnE0YS9QT0NTYU1MLzZWMWp5dG43bUFkb1ZRVzdNbXBvb21jVDJqMEp4MGdy?=
 =?utf-8?B?OW1yTmJmZm5FWVVHYWRCNGJVbVN4M1BBRjNMSUNXbGRVckYxVThraE0vR3hP?=
 =?utf-8?B?SXdzaVAwMForVFl0QUxpbDBueng5TTZ1YTBFbFZ5blpZd2dmRjBkZ3BZRFZZ?=
 =?utf-8?B?QWQ1VHgzZjdvOTBhT1V5b1JZZnlYSFlOWnFjYjJ1ajdwS3FFb29qenV5Vmpt?=
 =?utf-8?B?azNDQ04vL2RVS3pJUzF5Q1I0c0Z4VmtscU1QUVJ0UWtxVmNtVzRVMDQ0VFVM?=
 =?utf-8?B?NVcxZStCY25ZR0lHSEdhMlBuRTdseFVrcXBWR0FQR0VldkRRcWl3RlBFVDBp?=
 =?utf-8?B?cTAwUENKc2FTcW92THZnNG5BR0RCNHAzWGVkVXErRzcyRVd6NFduT3E0bklY?=
 =?utf-8?B?eS93aXpubG53WlBTOXA2RDdFZTA5KzZVR1IrTHpDdjAwMEhlZGcyRHVBdk9l?=
 =?utf-8?B?OEYxTzZNeHQvUWtabHV3cWZoY2RwWjdKMjR1S01ERUhhUEl4YTRoM2lFa0ww?=
 =?utf-8?B?NUhjbm1XcW5YYjZvd1loRkljUi9EK20yMWY3ejE4dlBNWjVZeHFDV2t4NFlj?=
 =?utf-8?B?MG5sQnJGMWdkb2E0d0ZYb2JhN3k3YWkxczUybG1VVGhjeDlJa2JGWUNvWGZw?=
 =?utf-8?B?SURSRlpKVktmYVpyUjltUDFXc3lvUmxXUFBSeEtuY2h2Sm9BT203czhxcS82?=
 =?utf-8?B?TGJkZmNhcjV6TzVXWkN3b0F5VVNmblVMZUd0Z3N4aG9NdmJlUk05bG8zazNk?=
 =?utf-8?B?VzE4TjFlN3hXNzlXZlhJYlpjTWx6aytJRkxPazVvT3Y4ck1DL2dZbjJCMzd0?=
 =?utf-8?B?enpxUWFER0JselZFUk8vZml6RjJCeUVMeFM4dmVuSndjdlN2a0xYTHZ6NUZw?=
 =?utf-8?B?SHFnU3gyY0tTekhCc295V1dGdTRCbTdYVERxZzhkZDcxc29Ualh4ejFTalM3?=
 =?utf-8?B?QkdTeGI1cU1GYVlzOTBGWUsrUjNUdTdhb1NkVnVpS3BJQkhScThGM1ZleVRi?=
 =?utf-8?B?b3NXRlAvcDRSWGZjaUIvNE5zcU4rV2NJMGh1dy8vbmtXa3o0OXU3cGJNcXgx?=
 =?utf-8?B?V3lKQjJKbFhLMXJQNDdGRGdvUVJGa25GTmZUQWVsYzZiNDBucjdldHp4ZVIx?=
 =?utf-8?B?emJMMnZxazUrS1JYM3pCWFBhZEFTdkN1ZlA5N2ZRY2FsOWVKVUI2ZlFKcE9h?=
 =?utf-8?B?L0ZyWkRLVkE2Y3F5YVFLOW1vUGlpTnlEVk1HV09BVGJ5RXZvbzVaTHZNL1lS?=
 =?utf-8?Q?HlW9VcCkzy/cQ?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:23.2399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9783073e-1fb5-41f6-ff1e-08dced046078
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8710

From: Ilpo Järvinen <ij@kernel.org>

These counters track IP ECN field payload byte sums for all
arriving (acceptable) packets. The AccECN option (added by
a later patch in the series) echoes these counters back to
sender side.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h      |  1 +
 include/net/tcp.h        | 18 +++++++++++++++++-
 net/ipv4/tcp.c           |  3 ++-
 net/ipv4/tcp_input.c     | 12 ++++++++----
 net/ipv4/tcp_minisocks.c |  3 ++-
 5 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 4970ce3ee864..aaf84044e127 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -299,6 +299,7 @@ struct tcp_sock {
 	u32	delivered;	/* Total data packets delivered incl. rexmits */
 	u32	delivered_ce;	/* Like the above but only ECE marked packets */
 	u32	received_ce;	/* Like the above but for received CE marked packets */
+	u32	received_ecn_bytes[3];
 	u8	received_ce_pending:4, /* Not yet transmitted cnt of received_ce */
 		unused2:4;
 	u32	app_limited;	/* limited until "delivered" reaches this val */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6a387d4b2fa1..56d009723c91 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -465,7 +465,8 @@ static inline int tcp_accecn_extract_syn_ect(u8 ace)
 bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect);
 void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
 			  u8 syn_ect_snt);
-void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb);
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
+			       u32 payload_len);
 
 enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
@@ -1009,11 +1010,26 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
  * See draft-ietf-tcpm-accurate-ecn for the latest values.
  */
 #define TCP_ACCECN_CEP_INIT_OFFSET 5
+#define TCP_ACCECN_E1B_INIT_OFFSET 1
+#define TCP_ACCECN_E0B_INIT_OFFSET 1
+#define TCP_ACCECN_CEB_INIT_OFFSET 0
+
+static inline void __tcp_accecn_init_bytes_counters(int *counter_array)
+{
+	BUILD_BUG_ON(INET_ECN_ECT_1 != 0x1);
+	BUILD_BUG_ON(INET_ECN_ECT_0 != 0x2);
+	BUILD_BUG_ON(INET_ECN_CE != 0x3);
+
+	counter_array[INET_ECN_ECT_1 - 1] = 0;
+	counter_array[INET_ECN_ECT_0 - 1] = 0;
+	counter_array[INET_ECN_CE - 1] = 0;
+}
 
 static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 {
 	tp->received_ce = 0;
 	tp->received_ce_pending = 0;
+	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 }
 
 /* State flags for sacked in struct tcp_skb_cb */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f5ceadb43efb..39b20901ac6f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5029,6 +5029,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5036,7 +5037,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 97 + 7);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 109 + 3);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0591c605b57a..c6b1324caab4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6085,7 +6085,8 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
 }
 
 /* Updates Accurate ECN received counters from the received IP ECN field */
-void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
+			       u32 payload_len)
 {
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
@@ -6099,6 +6100,9 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
 		/* ACE counter tracks *all* segments including pure ACKs */
 		tp->received_ce += pcount;
 		tp->received_ce_pending = min(tp->received_ce_pending + pcount, 0xfU);
+
+		if (payload_len > 0)
+			tp->received_ecn_bytes[ecnfield - 1] += payload_len;
 	}
 }
 
@@ -6360,7 +6364,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 				    tp->rcv_nxt == tp->rcv_wup)
 					flag |= __tcp_replace_ts_recent(tp, tstamp_delta);
 
-				tcp_ecn_received_counters(sk, skb);
+				tcp_ecn_received_counters(sk, skb, 0);
 
 				/* We know that such packets are checksummed
 				 * on entry.
@@ -6405,7 +6409,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			skb_dst_drop(skb);
 			__skb_pull(skb, tcp_header_len);
-			tcp_ecn_received_counters(sk, skb);
+			tcp_ecn_received_counters(sk, skb, len - tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6453,7 +6457,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
 		tcp_fast_path_on(tp);
 	}
-	tcp_ecn_received_counters(sk, skb);
+	tcp_ecn_received_counters(sk, skb, len - th->doff * 4);
 
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 81d42942c335..ad9ac8e2bfd4 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -486,10 +486,11 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	if (treq->accecn_ok) {
+		const struct tcphdr *th = (const struct tcphdr *)skb->data;
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
-		tcp_ecn_received_counters(sk, skb);
+		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
 				     TCP_ECN_MODE_RFC3168 :
-- 
2.34.1


