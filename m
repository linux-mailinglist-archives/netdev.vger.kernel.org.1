Return-Path: <netdev+bounces-137159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B44CA9A49F8
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 01:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C511F238E6
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 23:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAF319067C;
	Fri, 18 Oct 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="P4wCUGkG"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2042.outbound.protection.outlook.com [40.107.247.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01731917E6
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 23:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293631; cv=fail; b=BhHs9IBZPhn7splAX6LyaI5tDtBPR1puzRD+KUTks8x5NmY5mQ1qhZokpB778KBrIcKvZYf1sTGR3gUlYKSzQuop9JnewB5nusx/pdKp/tZfleOMaY8CTVBewtf4GoDA5zEuW+9MXPMAXzPL8qwCQ6kH2OrT1YY3sWkMSxuCFI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293631; c=relaxed/simple;
	bh=VWfBnNyWjEH3XDaLA3UuMW35easf2rQkez0Pfq+GLhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqyh5dWyRDBilncNJgy7mQooJJyJtQqr7T38ANFcSx16UIGlgKfGUbh3E/tgQRckfwNcJ0d8K96FUHtWY77nurT85ed082KlKYnZ5Q+vbmmBYpcFPdJY9yKni2alfouuk3PghxrFrbfrTwh4s4E5tdYb/hf8Kf1rYI5sIjspudM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=P4wCUGkG; arc=fail smtp.client-ip=40.107.247.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfWENAFU+4zaujOsqFIOZ54pQx7xxbFAbCE8q8ompQFaJVES5ZHGqJJk8nAl9cueiAwufI7amtM3x4+wEFK+hRU6TmOdt8hqSgkHDMNwVKFc2fS/M1j+wOGffEGmKcW16OzBXum3+LcMb4YddApBXefWwjORRvVOt/EAHfV64KAw1f0Ip09QoDkQRDIPKcAaXCpfWBbr7YFmOoDI8z/cYqOpRZOPWmkmJAO6BET46kWvy5wQP71xgzqP2cQaQ+eI0S63KNIhfS+iCaau0xD8wkEdoeeHtsUfN3z+EBzVjTVvv6NQUo0ZsLdE52DdMEBN0vBrfF9PypTCj3cUS/XYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMx3u4H44x+CVsqgJMWoc4rn9lSzlzPywoG4I9GWyRA=;
 b=h6BP2DRoGg8neBEpSXHtOYbDwuYcPs8fOTyU/up/H/KzSilZTj2OGVYikDhTM/lCOwms8e3KRIHtMrNt30+nrk904juJqSUJLGt8+92CTdzwBq+zicLmgMYqWfwhcaUe49Kdn7M4RZvOHS5wMHdnoEczkKPDazm3SLerLwKeoQIrPJXsNZ93E97S7TzThIFXmKfZjQR50ERzMV3rcoYsQ3DCGGaYIHYl/G3ZSMZ5PJzM6U5I+AiYKGqHQutMDZxKg4Yu3jqP4rOmjY93Y+Vc3k1XpIilnk7sUh/iEsvRdCj6agh6EOGHyfPrJH5769S73rOEPd2zqOzVKdleMDZ7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMx3u4H44x+CVsqgJMWoc4rn9lSzlzPywoG4I9GWyRA=;
 b=P4wCUGkGOcTzcdjPleHECwq6fZDtZ8YqdJ2EJCFd7wjrMwMVcl9tY63adOcwWz7aLrwiEam6KhkmsSmV0HNKfkRnQMaUjUg3oidbKFzkeVpVD8CSv/nj5caftOAbeKYH6hdjo5HTi1OxAxgCOyULpD1Bayk/XbcGqLAkSeukwKUZcqwzmZHm8q5yVqB/p+woXE56pe7TGRJua5eNwHmIINwkJWZmzEdaEt3aSAU6M7P2tffe7c4WMVBvKuV+BJOpS9rY/UL/0QLqAe8oKVGrnkJWFOFGLH9JRmFf4VDqoh6Qdw2Sm8AFUwaC2jqP7rMhmI5LCH/JBuEFJ+Far/tkFw==
Received: from AM0PR02CA0217.eurprd02.prod.outlook.com (2603:10a6:20b:28f::24)
 by DU0PR07MB9316.eurprd07.prod.outlook.com (2603:10a6:10:44b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 23:20:26 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:20b:28f:cafe::b9) by AM0PR02CA0217.outlook.office365.com
 (2603:10a6:20b:28f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Fri, 18 Oct 2024 23:20:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.2 via Frontend Transport; Fri, 18 Oct 2024 23:20:26 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49INKJJS010239;
	Fri, 18 Oct 2024 23:20:24 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 03/14] tcp: use BIT() macro in include/net/tcp.h
Date: Sat, 19 Oct 2024 01:20:06 +0200
Message-Id: <20241018232017.46833-4-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F99:EE_|DU0PR07MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: 08833ebe-b08e-4971-8124-08dcefcb72b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEY5UnhuTHcvZXljNG90RDV1cEJMU0JVS1BHcWpJb3QrZTJ1b1k5QWF3WUx2?=
 =?utf-8?B?bzVvZ1owOWVIRys5YnA2NnY1QTgya0xwd25SU0x6TkZKbVd5UmE0Rktzb3Q1?=
 =?utf-8?B?cmpDdkVScS9vZ2xxUVAvYjhoSE9LdmIvY0RZQnpXQ1dXM0VYY3h6NnRLZ0lI?=
 =?utf-8?B?Z1JpeUJsQlVWelI1bS9saEhseTJEWkg3SjBSck80UlZqSGJnazdMSmw0dmZO?=
 =?utf-8?B?dWVhYzJ2OEYvdVdPNVlPdW4rcDM5QTdLR2ppYllzd0xFdGozcEpIOUNrY2tQ?=
 =?utf-8?B?T2M2WkUybllSRlpjWG9tVlEyODNTemlwMHhUd0thYms2L0wrMzJnWE9ZT0k5?=
 =?utf-8?B?WERDS1dxVVlkZnI2Q3lyYk51eXZteS9EM0NHQ01xcEVPa3ZuWkM1QWFZUUhl?=
 =?utf-8?B?cTJ5Vzdib1d0UXQ2UktyOHI4S0dKMy9zOFQxdDhtV0lQWUlJQmZFUTRpanV3?=
 =?utf-8?B?YUN5eVpYTlhIUlVWNVV2VXFsUlE2dFNzL3VwT1JFSmI2U29tS0xRbUtsUlF0?=
 =?utf-8?B?YytlMUtqSTVrcVZZZ2xhSGVkOGxVMkU1WmM0V3BJK0Q4U1QrcnVjdGtEMXlk?=
 =?utf-8?B?YUEwMmVzbWRhZENTNmRaTVl4S0wrV1EzL3hjQkdvZjJwQ2h3cCtkcmhINUF0?=
 =?utf-8?B?RzlySmg5TDVhUWlra2dCK2UvSGhaVmh2MlNwT3krZDZVZHdwelRnNTBRaEFo?=
 =?utf-8?B?TUFLZHcxMG0xelNqa0gyRDBOWEs2MkZhRHd6aGhjOE9naENwc2kxSDErYkdj?=
 =?utf-8?B?d0JHSWE0WnRtNHorQ0J3Z3VPZ1B6aGNuNEU5ME5EMlRwU0t4NU1GWWFCWmgy?=
 =?utf-8?B?WDRzL1ZLV1FZdS9QMm92SWRzaGlmcmlQcitMVTJkUGpRbWpSbU5jQkErUUJz?=
 =?utf-8?B?M2hKejNUNkdnZWQxZ2dQYUR5Yld4STJXdkJ0SGU2NURhdHcvVXVkMEYvN3Ju?=
 =?utf-8?B?NDBkU2ZlOVhqY2dHVUdaRkQ5NndQdVhtenZrVkZ1bU9mN0RWSk0xdzFtR0lL?=
 =?utf-8?B?dDM3UDZDdk00OWlSNEFFZzNMREpoazJmY0ZUSHBoSFJlOU5aYXlyUG83cnk3?=
 =?utf-8?B?LzhNdDNDc09kakppWmhoRDEzR0ppL3FsbEJwVXdGT3FXbC9LV0FHdnlNS2ln?=
 =?utf-8?B?YmZ6UDBkMVdYQkRmUGJFWm1CVlREcnFwb3diVHYzbktqTmFNa0QrdmxIT0kz?=
 =?utf-8?B?WkdIR0ZsOFRXekFNb3RIN2kxQnFHNEdQVkFib0ZtYmFhYzRjRjVYdlpvQ2Vn?=
 =?utf-8?B?Wi9oQkdDN1ZGbDhTTkVXSkNRcUM0ZTZHQUM0bTFNN2tJbU94cmNJNDN1S2N3?=
 =?utf-8?B?UGd6d1NJdURFNDFVN1ZHa0hwQ3VwVTA3V3B5bkVjVDlSdldkUG91eVgvVnlJ?=
 =?utf-8?B?YzR3QVVkZnRXMzdhN05vSHUySDUwUWlibjhzUmVsbXRYeHNZcjcyQlJLaWh0?=
 =?utf-8?B?MGh4Vi9UaENxSE12SDRsdDFJckxNa0J4YmNZbzA4MjhRWUMvMkQ1SEhudUcx?=
 =?utf-8?B?NUVkcDdPMURMUUlGVXpoVy9KTk1JaWM1YU8vTGxCZ3FaQlZXN2RyWE82OTll?=
 =?utf-8?B?ZElIUGFqMnY5RlJ4ZVQ4RVRLNEh4TVByK3I0SmtCaTk0OGVsMDU3NEpnQ1R5?=
 =?utf-8?B?WUl4TW1YNEo1NzZVdzNKamZsWURheVJIQlFmclF1MWM1TTl5eUlVQVdkTmc5?=
 =?utf-8?B?R1ZwVjlaelpDLzduOWo0b0JlaHZTUFZ1VnFhNWRJbTM2N0FTZHZJUThPYURp?=
 =?utf-8?B?NFZRT0MzZHBYNS9hY3FCV3V0eDEvc0NnK1NXNENxZU5qR2lVR1haZldadjdW?=
 =?utf-8?B?bzlQdjFlb0VGUXNVdEpWSWxoLzdkVGNocytqc0V6NXpoVW5JNnkrWmRNUVln?=
 =?utf-8?Q?Xfxl1+odLhujI?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 23:20:26.0702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08833ebe-b08e-4971-8124-08dcefcb72b7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9316

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


