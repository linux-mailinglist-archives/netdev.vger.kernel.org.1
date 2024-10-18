Return-Path: <netdev+bounces-137165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED699A49FE
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 01:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 963841C213E0
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 23:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F4D1925A6;
	Fri, 18 Oct 2024 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="KQ2oGKye"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1BC1922F0
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293636; cv=fail; b=aS/UUlyQouoim1KQjwiKgWkv56iC9yrHY9EU+pljqGLtX7mtN61AlDrUVE7lewj7uoev+kfnd524/QtEZwCFkZX/th2Jl0CosMtWUSwe+dLzzQxBBXGT8b70w72wz8yMXvhPEHtgX+ieY5OcLZ5QqT9ivhhK2P1WXIN950u18c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293636; c=relaxed/simple;
	bh=jdXed6V/Yh0NaH+TDgmUGtmxQ71q3BvRQy9Z+lTQNLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ni3mGk6TKzQsZ8Xo7sULEmBjWZUooRHPE59MlY0KI2Fzq+KJ5+/ykGInVLlhRZfNcx+6gcnyIP6dVNxT1iNkvOWN/VD7PjRtKH4dtNQ3sqHMAMq+mQ19PV1N5uAN0dWXAoVxOxxKtWUHOpS7mCNYq86EQJKKlwxqzKouOvm+OyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=KQ2oGKye; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5HtbD2jLVXyZ7PKW1EzoV6CIftfPmb07n05Z2c/a9xiwVaR+nncdLkKh4fRTH+n9q4E26d9rIjcuCsUDxKGpI2ciaHLSlgnLnNvs5NgM4E71g0lAtJyFiJG6QIChvRZXxii6bi7q2FY7hRk/uUEo0eSOB7zoLOP1V9rbnmhq8h6XJBwWng4rrTPOzHNRjK4gEY5bjZMRpq/zxzIncIu7AE18kF8Q+8XBv25iLMRzpELyGjjOrSRI7A5E3gt5wBJVfwlV1eNVaxNHt3S3iI4f/heDwMiPuHcrqKeBops1Kwt0ytY2BfcGLIekhNqY19SIyWUoZz+KQBFkwqolt4glQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULMd+A5h7VJxRvwiM7CWeriIZLgKm/nirYpOmNuOV6E=;
 b=l5bnThfjpKnbNHBd2dX4dpMLPk30zLfjSG0BR59xrp6oLhPAjAV4QC2HkQnyvkjZXm3BtgZVTOgEOknMr/tLvW/gLIwySJ2VU9mFWMIphrs4Sy5S5fcCkK137VFLOuxVD0Zg/pLeZWAaaTSg/7qzcl7IdQFHA/JpQSLO90bMKsWBzCvbrzOdaXmTJm/rxgeuATpFVqnOUzLCs5m2zyhJx7WshC+jMxT9WO6fcQHxrPtq/CYTbp1+WyU3xiETTG0vvOLhKDx8PfO2qhATEifs2k5qXTcBFjeWLj8XXts9bqenR+w+iX7YQ/EqYDYWHmESXNnuIXQbEFx3IQlODM0btQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULMd+A5h7VJxRvwiM7CWeriIZLgKm/nirYpOmNuOV6E=;
 b=KQ2oGKye9hOtNvEharYp5ds946r0pQSX7hO5fVlRiYNCn4iqQLKxJhhtxvcje90wpxxh3k5RoviArumXJl5PEzWnV2ebl+DkjiNk7T/HWRzW0IW15Lq0ZDxRFN4kjZW/REM4zRw6/lvqjy7Eay79Vv4OEy1CikkMUXe81CJrA8drI8OYkLRWicGTEQRpKCMERdFQshnHnVVs2ZH+1TnmDolgeUCqIASdyLbZ3XBJ8mmGaGjgn/CuPvwGcvxp2suVo1bfDTuNmQzNWi5Qt6FjQxCUaYQCUDzs8U07AZ4v+46MMqku7uCvlYQxZ12ixiEI1WLnpLXueI8kFvMNeUQWdw==
Received: from PA7P264CA0253.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:371::9)
 by PAWPR07MB9323.eurprd07.prod.outlook.com (2603:10a6:102:2f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 23:20:30 +0000
Received: from AM4PEPF00025F97.EURPRD83.prod.outlook.com
 (2603:10a6:102:371:cafe::c6) by PA7P264CA0253.outlook.office365.com
 (2603:10a6:102:371::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24 via Frontend
 Transport; Fri, 18 Oct 2024 23:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM4PEPF00025F97.mail.protection.outlook.com (10.167.16.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.1 via Frontend Transport; Fri, 18 Oct 2024 23:20:29 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49INKJJW010239;
	Fri, 18 Oct 2024 23:20:28 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 07/14] tcp: helpers for ECN mode handling
Date: Sat, 19 Oct 2024 01:20:10 +0200
Message-Id: <20241018232017.46833-8-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F97:EE_|PAWPR07MB9323:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f61cfd-8647-4015-b805-08dcefcb74e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3h0RXBnUGJKVnZXM1ZRWFJldU85YkFNM0I4Y2owWjBVK2twZkZzNlBHUTZh?=
 =?utf-8?B?bHVxU1BYQVJzbFE4NytjYkJjK1J2VXFtVVRtUHNRL0NmRjFmL3ZXWFdGQ0ZS?=
 =?utf-8?B?bVJqRWtkdDRtd092YktmNDlrWjdCL1MzdWVOalJMMjR4Q0xKRnF3Yjg5NUpP?=
 =?utf-8?B?UGZhakdMNWpvUWFNTGRQa3huOERDT1FxbENQOEc5MXhXSVRodkgvZWtubVNp?=
 =?utf-8?B?ZXFVQnYrL3A4b29KMjZQenBQMXhBWTBWTGdtTEorUmpMeElmTUJ1OGg1N2I4?=
 =?utf-8?B?K2htcmNkbXY1N1AxMzB5TG5iU2Y4S24wN0lMRWhkekdKUkFROE5TS1ZhZmty?=
 =?utf-8?B?aTR6QUFZdW40dFdvaVk4TnBVN012T1NNVXN0MlFkWFRNcjB4bDdVa2pLWlc3?=
 =?utf-8?B?bmh0Y1lYN3ZGSFhpQzU1V2x2c0RldkF6VFVFZEQrL1FJNDR5QWttZWRNb3pU?=
 =?utf-8?B?dGVGMXNScGJscmFlS0lRUlRvR1RlTEIrZnkvbGJhT0l6ZnpUayttZzdCSlZ4?=
 =?utf-8?B?YXpFQnN1L21mN2RZOG5TOW53RDlSamVzcGVGSWNUb3paQzAzWW94YzBQMzk3?=
 =?utf-8?B?QXJJWG5PeE4vM1BSUU9oenpTbGxWcjZ3RWQ2ZWs1MDNmOUpndWVnRkxISngy?=
 =?utf-8?B?L0d3VVVhRE5GdUJnbWxSSkdERktWaFBjODhCMUI3MFJFWEFVQ1ZpOGZGSE9K?=
 =?utf-8?B?ck1sVElMeHlGbEkyeUp6V3dWRlFmM1J0UFI5bFhiSU1hS1dNeDZaZ1VOcURl?=
 =?utf-8?B?aFNrWENnVm9JZHRRRlJRYWtGeEcyVEsvZk83Z2E0b0U1MHg5MllRME10cm14?=
 =?utf-8?B?ZUhHNjZMN2hwbmlLd0hUZUJQaTZvdXZ3YXRsZVJLY0wvczlrWlpYUkg0QjdS?=
 =?utf-8?B?M1ZqQitFdmNtdWUxQWVEY2NGaWswTms2WDkxUmZFbi94a0tTUHZ0MzVtQXBP?=
 =?utf-8?B?aVN6K2phKzhRQnpnc1BHeTBtSUF6UUI5ZEk0VVYvczJtOWRIbEV1UzlBUmZ3?=
 =?utf-8?B?dXd5MUo5VmgrYUFFQmFvZWtwWlZHWW90TnNKamlhamVCYWUzOWwwTXk3YlVl?=
 =?utf-8?B?WlJkeUhvYVR6czJRR2hOb3dPQlNYc2s2ek5LbUdyWnNIU3VlMFo1anBsMkdD?=
 =?utf-8?B?Q3RlM0ptUVRkMkpKRDJIck1ZTDRmeWdFUUVFZDlxR0sxWjFJNzBOQy9qME9h?=
 =?utf-8?B?Z3RLdUIvcEJLK1dwRUtnOEZYOVlDcjBHWEhyclFLa3VzMVl4eWR1OFlBMURT?=
 =?utf-8?B?WGdTYnJCL1BqOStCTXprbVRVb0lZbU43UnAybThyd1FtS29DUmdaMVNqODFq?=
 =?utf-8?B?cks3eTd0b05BeW1WcWRnSzNBdVljdWdXK1hPQm5yYTY0MWs3K21GcWQySTNQ?=
 =?utf-8?B?eWUzVnVoNDA5RHFqYmpJM0Q2bWVYeER1WkZWamZjYTMxYzh5NnNmR2E3Zks3?=
 =?utf-8?B?RFJHNThiVENJZ2FEaUQ4amVPeXMrRE0xLzdvamRZVUo0VmJCUnFJcExpNHNT?=
 =?utf-8?B?TmtQeFA3UEdZSklBaFloWWJaejV6WGRqLzRFb3h4b293SVVnek94U29zZlox?=
 =?utf-8?B?S3ZmL1pMbXN5czgrVXZscUZRY2lLdWhaOExmOVBYci8vaGJacUNVS2E4YXFz?=
 =?utf-8?B?aGg4Y1JvcE1UV3BZUHp3Rnk2L2MzSzJLdGRDS2FhNXI1OTF5QjN5elQ3OWho?=
 =?utf-8?B?aUNCaXpTWjJ1SDBCckFEd05iZGw0VnJ4SGY5QUxLQ0s0bEJMdUJLNTErZ3NS?=
 =?utf-8?B?Y0wwdGc5Mk9OTVV1MjdWbGhuZWNYa2RQS2E5SlhrcjBwSGM5M2NFVjBJMGJ5?=
 =?utf-8?B?OTdiQjdicTNSZkswems0Rzlra3h1cm1rR2ljWUpEQUFqYzU5SGwyQ2NWMFlh?=
 =?utf-8?B?Ti9GdkZabnhvb2wvSGNqTlBicW0xNXR4UUJucmNQbjdHTURKNEI3WTBlUFpW?=
 =?utf-8?Q?Q2OWalMLeIc=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 23:20:29.7351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f61cfd-8647-4015-b805-08dcefcb74e6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F97.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9323

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


