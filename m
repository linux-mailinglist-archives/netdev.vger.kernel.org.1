Return-Path: <netdev+bounces-135538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EF399E3E0
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D7DB21611
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E5F1E379C;
	Tue, 15 Oct 2024 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="H7MqK/eM"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2072.outbound.protection.outlook.com [40.107.105.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE57D4683
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988220; cv=fail; b=cKdNT8bj3iprq48R95eCH3FYqUejxpa9sxsgWcrGJJRA9skcOChrTmTDeKfMVLHAfQtWJRMgr75HNWSMtBH7Dke+yOETCUZ9jAms5vrtS9iroqsm/tyEifiKfAAly7npaFh7JuS9s1YBrNKBd+fXppxTaGEu4dlQCWEsZcKu9og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988220; c=relaxed/simple;
	bh=VWfBnNyWjEH3XDaLA3UuMW35easf2rQkez0Pfq+GLhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GG1Tm9/2DWtHxkynIMffDxHbE7eWYMh2IT8lcfVapItFdlXkjHc0vjN//J/GqU7ip05Y3VZFZmDCmlfR9iUOlQLqNrCYtJGh3WyqwvfSLfU9c1+SWiXenVK4DWeJBCVugg0A+rQTAvlSadobwhMaAJVVC1oRrlhZF9yaUJigW54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=H7MqK/eM; arc=fail smtp.client-ip=40.107.105.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tioMl8G5R8I2BOoZnIR8JZPuOaQnZEgfj9pwLYcjakZICkzVKL4TAg67ZJ2EBqtjoB4/HBiXsi2k1ISLBMv8mVPg+rin6jncMus4gpB00lSs1Jj8s75Ds319m7b/S7CEHB4hOpFGCM1m/U49xJKGUPWT7r0vaDGhvtFB//Ed8eWtCv5PmKYOgWbVyhAHpuvcNzRZFKfoHvavJIWVEnmJlvoaOsGY6Ldi5bdfxx7nkrqNd9kqObYyihwt/S+mkZeYhf/iJI5VuWl3HSdH/n61JFm+50PyDubhSmHZZ7Oq85+cQjf4fTIfOeL2Yc96R1f8XIuvS026MFFCOkh+gupaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMx3u4H44x+CVsqgJMWoc4rn9lSzlzPywoG4I9GWyRA=;
 b=Y7c/Bs6nPks2yyMIvGEI66nga+dE0UvO/2v62O7FPYOXmIACjtD8HYyAIm1oWLyRO5N1GieuUI6ebb9yjpnKgNAb+bnsYdKycNrP4bUVCUaO5bpX+KqxwVXyWbx168hZb7Bw6IW0LG2FnKnD7o/M5gtdD5mGLZbbZrFzOOErFazd/xxvY2D05r+2R5RRCxp5Hi17o5SAPURPw88b/lTHDi9s+84Jt5n/T0hHZF+/TkKnau6z+4bv5ewvWRzSBSI7q1NirbqhVHiIPa+2yNAIh77tKZkrHcCpFFzCqtxi0FK/8jY38bLKh3EzSwgGEKKeNXb6qIbmAueHGmqKPbNy5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMx3u4H44x+CVsqgJMWoc4rn9lSzlzPywoG4I9GWyRA=;
 b=H7MqK/eMRuSVCwH04zrbO8PUNka/r2PE1bPEDM9rSHM8keJY5s3/DeoWY62VWYCFB5QMor+4gi2qquSFRGiTBkhkncQpSLZfE+5R3zkkMfAHCYgDzo0bMXSgLPft1kjDWoAQ81q0JJJxzeGRcYPJ+f2S9Z1HPhgwotwvmXUPlKeJgH32nHuhWmXCovt4gfDNCW5MX3gZGE7LgBnH41LEPTP13C2qt3l12bq3KfDmCrLGK2XROBw2y4RFIRHzm2y40MtBKcREu/3ZkBg/wI1XN1KxIQQg/VaRLo6jhVxNOE2PoSfekDYXda7GS9ZGnyM5qYbufHLBz4fucp0OH7pCUQ==
Received: from AM6P194CA0080.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::21)
 by AS8PR07MB8054.eurprd07.prod.outlook.com (2603:10a6:20b:359::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 10:30:16 +0000
Received: from AMS0EPF0000019F.eurprd05.prod.outlook.com
 (2603:10a6:209:8f:cafe::e1) by AM6P194CA0080.outlook.office365.com
 (2603:10a6:209:8f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF0000019F.mail.protection.outlook.com (10.167.16.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 15 Oct 2024 10:30:14 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtn8029578;
	Tue, 15 Oct 2024 10:30:14 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 04/44] tcp: use BIT() macro in include/net/tcp.h
Date: Tue, 15 Oct 2024 12:29:00 +0200
Message-Id: <20241015102940.26157-5-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019F:EE_|AS8PR07MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c649344-a8e7-4aed-7d74-08dced045b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXROVHRodTZaV0hIQ2tYa21hTDhnYkdWQ0I0SHpOS2xnSHdsNkFMeTBjYXdC?=
 =?utf-8?B?b2JzOTJaMnFjTk9qRWRQd2cwdDIvRnBSdS94T3FON1lrY3B0dnFpMFNVZXNs?=
 =?utf-8?B?c3A3SWRqdTIyRFpiMEoxcHFuZFRPZjZkZ3pQby9xVHhQbmFrUDlrVE5kUlpJ?=
 =?utf-8?B?M2VOU3NXMTZ3ZXlSOFVVV1I5V1FEa2krZWthSXRrUEZaVkc3eW5iVzBkT2t0?=
 =?utf-8?B?L3pTSDNJRHdBc29kdW0weWZzUHhUYmxzTWppWDY5VGR4RHdHYlkwY1pGZGZI?=
 =?utf-8?B?SmNoZHF2TUQrOEpreTRsamFHUGpUOSt3emNiRTdWSDUyc3BWdFFMaHhuckhW?=
 =?utf-8?B?WnpGd01PYWFZQ2c1MTZoVkNISVoya21pazJZV21qZTAxM3VHMWYvTDV2ZjBC?=
 =?utf-8?B?bUo4YXJFU0pTTGYvYUJkODVUaG5zN3NJd0tIbi9YYytPS2I2WU5GN2pkMHIr?=
 =?utf-8?B?b1M5UE01TXh6TSsxTXRacy85QU8xMHFES3VhWUY1YzJscXJSU1ByWmtiaGg5?=
 =?utf-8?B?a3pJd2NOZ1M4NVlXOCtBSjMxRHZBSkFwcFhjYVQ5R2dnUFlkSFlTSjdVdVIv?=
 =?utf-8?B?R3V0V2xBdWYrZURRY1NBNUR3d2FoWWhIWEVUcUdlRkE2MzhySWJzL0xadnBi?=
 =?utf-8?B?Vkl1cUhKWkJId3NmYzlqelJkZlVGb3F3OUs2TVQwaCtrOWdqNVdVN0tJVXJU?=
 =?utf-8?B?SElrbFZ6aUxOeTRPQ3c0OHltYTcvTTN4ZHd5emxMdGRZbVNOOXRZSCtESFZN?=
 =?utf-8?B?TDRhOXd4LzVxWGxRVzFsazNueThSWjVpMEh2b1huMk94YVkyZzdFRHpMRi9h?=
 =?utf-8?B?V0JSTEY5OU9HZDhCSkR6N24wZmkvcU1jMGZ6ZVM3bUZHMzdkYjF4Znpmc3dI?=
 =?utf-8?B?b3ZvNHZTbWgyUWxTMks4OTFkU0RwVGtFMmV3MjRIaUJnc3YrKzB3Yjk2T0JD?=
 =?utf-8?B?VzJ3MFVVM0xMYk4rYU9NVDF0S25hMmorWXRHMnY5MW0wOHpnT0I2RlAxM0tH?=
 =?utf-8?B?QXhxcHhpWkNxdjJkTytmaG5qTlBNWCs0OXJ4aEtoMHFuRG13c2ltbStmSkxW?=
 =?utf-8?B?WUpidnFIVkxtaTBvTEFPb2pUdHlKRW5rYVppK1RybUsyeDZPUFYzeFJxeDE1?=
 =?utf-8?B?YkF3eWthYXVaTW1wekMraUlwZnR1bUxjSEFMQzlRQjRGTXRSZzFvRVNTeUhw?=
 =?utf-8?B?ZUdMMUxFUG1BNnQ4WnFXMHlJMFJvWVhLMDU1bFlybUk0UUdmbHhrMjEzaVhq?=
 =?utf-8?B?dkJTazNyaWFoVE9JNGhQVFF6RW9sVDdZUDRoYnRhWSs3WjdIWGwvd09LUDhn?=
 =?utf-8?B?WFhTSDlsRXQyT01DSE9jWXBPb2ZPYUFScjh5c2QwdE53cnhwa0c2RjlEajlR?=
 =?utf-8?B?MWJ5K2FUcFU1NkJ5dktseFUxbUhHZm42TEh3ME5IcnZjWmtUYWZUWkRBNGJW?=
 =?utf-8?B?UVJGa09hNjhGK1ZlSlJ6RkhERndYUEUrKzBhU1dsZHA2S2lTZkp4K1RWQ20z?=
 =?utf-8?B?dG5pSTMwa2FBYkhSRFYvK2NRYzdiZ1RETUJhQW9lY05zMjJ5bXh0d0MxaVRn?=
 =?utf-8?B?cC9udHM2TkV2RnNvd3JqeDJzdWhZNUliZHpSQTNEQy9HdzVtSEx3czUxS2Q0?=
 =?utf-8?B?a204SE10c3dseGp6M0NzTjhQeitwUWhxcmMyWkhjdTUranJEaHAzMXUwU05h?=
 =?utf-8?B?cHZBS1VsZEIvSnh6RnFYOWE3TmwveTdPVUFWdzRWK0lBRjlxMWUyRzBabTAw?=
 =?utf-8?B?MzNPMmpTaUVkM1A2NGJUUnVKd1MxRWpDL2ZFaEN3aVdnOEFxVEgxMnJpazlJ?=
 =?utf-8?B?dzRxZGFEZ3NtaGtUQXIwTHJZQW9oSFpZMjV1dFRRTGtaTjFjTGxjN0Nyc1dJ?=
 =?utf-8?Q?Nj5b+33bg3jXp?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:14.9539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c649344-a8e7-4aed-7d74-08dced045b81
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8054

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Use BIT() macro for TCP flags field and TCP congestion control
flags that will be used by the congestion control algorithm.

No functional changes.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Ilpo Järvinen <ij@kernel.org>
---
 include/net/tcp.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 739a9fb83d0c..bc34b450929c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -26,6 +26,7 @@
 #include <linux/kref.h>
 #include <linux/ktime.h>
 #include <linux/indirect_call_wrapper.h>
+#include <linux/bits.h>
 
 #include <net/inet_connection_sock.h>
 #include <net/inet_timewait_sock.h>
@@ -911,14 +912,14 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
 
 #define tcp_flag_byte(th) (((u_int8_t *)th)[13])
 
-#define TCPHDR_FIN 0x01
-#define TCPHDR_SYN 0x02
-#define TCPHDR_RST 0x04
-#define TCPHDR_PSH 0x08
-#define TCPHDR_ACK 0x10
-#define TCPHDR_URG 0x20
-#define TCPHDR_ECE 0x40
-#define TCPHDR_CWR 0x80
+#define TCPHDR_FIN	BIT(0)
+#define TCPHDR_SYN	BIT(1)
+#define TCPHDR_RST	BIT(2)
+#define TCPHDR_PSH	BIT(3)
+#define TCPHDR_ACK	BIT(4)
+#define TCPHDR_URG	BIT(5)
+#define TCPHDR_ECE	BIT(6)
+#define TCPHDR_CWR	BIT(7)
 
 #define TCPHDR_SYN_ECN	(TCPHDR_SYN | TCPHDR_ECE | TCPHDR_CWR)
 
@@ -1107,9 +1108,9 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CA_UNSPEC	0
 
 /* Algorithm can be set on socket without CAP_NET_ADMIN privileges */
-#define TCP_CONG_NON_RESTRICTED 0x1
+#define TCP_CONG_NON_RESTRICTED		BIT(0)
 /* Requires ECN/ECT set on all packets */
-#define TCP_CONG_NEEDS_ECN	0x2
+#define TCP_CONG_NEEDS_ECN		BIT(1)
 #define TCP_CONG_MASK	(TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN)
 
 union tcp_cc_info;
-- 
2.34.1


