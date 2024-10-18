Return-Path: <netdev+bounces-136815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ACF9A329F
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060B71F24717
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50188153BD9;
	Fri, 18 Oct 2024 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="oQjRFb1f"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2071.outbound.protection.outlook.com [40.107.103.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E06F149C7D
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218096; cv=fail; b=VwjOgqMftIPQBTv5B2SSj1gx+E7JQVjAa8p18UAORjHUYcFMXSyC+9KNyz+JCU8+TWbG+fLNgHxQW9IgvkBp3p/RdH5KO2hDWrVKKOoiGwIs5uWjrjfpkVeJFIfonsrTOu6NQzot07mN4jl1dYOzVOvfTq6k5N2GDkI1h1/GYaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218096; c=relaxed/simple;
	bh=VWfBnNyWjEH3XDaLA3UuMW35easf2rQkez0Pfq+GLhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyvM3wz41tuAsMJ5cjWnRUL79jfMzSaSCXf22DfjlYy6klTL1Zmlr7hdVbmUPbb34qD+xoLce9CKw2ZHe8TWTKw+47NG39K/KMXtdtOcRaLhE7aHtGCrLJZzqiFuJytyQAJBIqdi3blk3Ro2Ct3anNg5wUWJaaSRyRe8/EJk30U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=oQjRFb1f; arc=fail smtp.client-ip=40.107.103.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Su+IV+QqkoFau4eCvAKbdb2Nc84n//PjxDO5C6Z9xrDlBKE2HxKBzwJ4K/DhV6AilTzJKJ+xI86zsHLrYSkkLR6O7Ckg4+qOi2CwHNJk+BpT8qfG0ajzU/1TCIjff/ZLOXhOEEpH81YiSQ57SHxCtR2w8KIEPS7j3empysD9VjtW1lq3O60l0tcQbk8O8jF9+IKUWrxNYzDVgIYzUwGhPLFYhlKN3xQx7mLDbsi8UZV0Wep2x8cQpQ5YWlpsytEpDyXVxFaxLb14XKfGBTPNBWOA73mUK8XKPEfHsxCLfqTjxadQR6UQR7j6uP7ncozrN7b9K34SZ5Zf4SkWRLnBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMx3u4H44x+CVsqgJMWoc4rn9lSzlzPywoG4I9GWyRA=;
 b=BUWOVL5B3lIY3c3/hGjE0I66iAGe9HciDTRNM/Bbqfh5Mc+C1lQ30Tduah0V9C8fsAFTDFtFvVyr68q05c+Oou4D2m2dRk5oHiZKMs62gj3Nvj2erBhDsFpLgCp8tT1hrECTBh4DFjSkIjHhHBMYcs+gOvLpDDdHvxmiL54G7qX8IEhKZOGTak00DjpWtofIiX5iyTjF1f2Mwy43f3Nwa7d7bp3M70JKh13baEY50TpooBOC2fd66rHb4DUax6WM1k/1W711+5m3aZVz20bsQmkWiXa9uentbiJ5v3hZTkO8V1jzPF1fevjpelytfKBebCyUdjRLI74ezOgsutnOyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMx3u4H44x+CVsqgJMWoc4rn9lSzlzPywoG4I9GWyRA=;
 b=oQjRFb1fvUTLC74L0A06R6K6CrF1p5yucwSfQ7CLoVaJejUtBIc3dT8vOrTl6cYpBY3FEOUCNuVR5pWq35n05zeUzZwZFgd1nNBo9nQEBiE0TfNmjBj6/s3m36SQ4VKC/TzUZpPL9251eCGVRHBluvfHfiUapGi0qSxM3J722ZqnN816GaT3UAtJUGM6u36XDqN1d0Ln4T7Jyd1Ad5I9xwiPAfx84k5cj/0bORQeOBdhzZXMZHL5O67eGgOFaw6zsrHR2P9+LAYoX5DIBQ5zr+I+M+L7tYVNpiGZpWi6e7GMSAcUykAh+XNgxDy/jxLRCboDi21JMvSZbrlpD9mENQ==
Received: from AS9PR06CA0521.eurprd06.prod.outlook.com (2603:10a6:20b:49d::12)
 by GV1PR07MB9168.eurprd07.prod.outlook.com (2603:10a6:150:81::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 02:21:30 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:20b:49d:cafe::c0) by AS9PR06CA0521.outlook.office365.com
 (2603:10a6:20b:49d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Fri, 18 Oct 2024 02:21:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM3PEPF0000A791.mail.protection.outlook.com (10.167.16.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 02:21:30 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49I2L0MX023685;
	Fri, 18 Oct 2024 02:21:28 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 03/14] tcp: use BIT() macro in include/net/tcp.h
Date: Fri, 18 Oct 2024 04:20:40 +0200
Message-Id: <20241018022051.39966-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018022051.39966-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241018022051.39966-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A791:EE_|GV1PR07MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d17e83d-d08c-43b8-b75e-08dcef1b93dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzA4SVM2NzBHYkY3YXF2RGxSNGZkMUtEM3RLbWFwUUdnUUZ1NXhhUTRqcTRD?=
 =?utf-8?B?SlhlR0c5MC93L0lmWGFQQWhITC9ESGVrdHZoQmF0UkcrZkhtdElkVTRzV0tC?=
 =?utf-8?B?N1lBaiszak14eGpxN0Q2anNLSnZSRENhcmFVeHBHNm5NYUJhQXVOa0dsazZH?=
 =?utf-8?B?ZlZRZEE2RENlWVUyeDlQay90ZlY3ZUFobjB2VCtLNTF5QkxJejk3ZndHL2ZG?=
 =?utf-8?B?Zk1HcGM5Uk5zU0hKN1JSTlJvR0ZTbzFhTTI4cGxyRjh3K3J2Ylk2LzBhR0wr?=
 =?utf-8?B?ZWNVMmkvR0dGSmdlWm9WS2U5cVdPV2pCd2tHVk8xYkI2TDBMcllNemRMQWxh?=
 =?utf-8?B?THc1TG9pYUlJS1JFYUxpR3plZGNSckI0elZmYkRmTmFNd0JnY2I5czY2aFhQ?=
 =?utf-8?B?a0ZjK0dQWW9YK1cvSWlNVytJa0ZIanZUbk56L1Y0NTEzSUNsMVA1ano1R0dC?=
 =?utf-8?B?bHhpWjU2MFFhM0J5aEtCb0kvTzREcjd3U2p4YVhmL0pEaktKMDdxM2dBanZG?=
 =?utf-8?B?eHJaUEVnL2lwbDVoZ3pXYng2ZTFpaGxic2lsVjI1YkJhUmMvSVJIdm9MYzFF?=
 =?utf-8?B?VHJIRkh5dXlad3JXWHJaUXNuZUw0SGlQaGdUQ0Y5TlVwRDVocWdrTzIyMFlJ?=
 =?utf-8?B?NFd1bWp1aGZXTmk3TmlIUEhWTjUrL3pjVzBleGxyYzVKQ3MrUmJpelVrWGFh?=
 =?utf-8?B?WGxNY3NOcmlFbGVFQjJ0djJicktrNHBZTWNDQVZUa3N2ZTZ4UzEwbkFUTTc4?=
 =?utf-8?B?SmhHZHcvU1kramJTMmRmK1B6OVJzM1R6Q01CcWp4WjJmc0pPelI0NHRmWHZL?=
 =?utf-8?B?MHhaN0tRSWFCWTdaU1hmbDVnOXZzZ201VDI5U3YyWU8vem9GVE1ETm5mOThT?=
 =?utf-8?B?ZTUrekZCUzRJUHcyKzUxU21ITTZ2clJvV08zWXBGVGJMYkdoam5GTDkySTZR?=
 =?utf-8?B?R3Zzb3hFbktUN0pwUittYnd5endrY2FRNU03MWVXTXlnL2U3VnBndWtIalA4?=
 =?utf-8?B?ZkZHaTB1TjFBb1lwdW50dlIrQkZGZ3IyQjNtelJCNmc5T2tzbEdQbzB1SVor?=
 =?utf-8?B?bHNBaXpXNVlBSXN5UnduRXFoR1NHQklNQmIzb0NwSjJsR1VqQ2lKU0FBMi9Q?=
 =?utf-8?B?bjRjbGNnbWVVeU5YRVlpL3FDcmNZb090SUZsRzlha0l1QTd1WGFmeHd0L1BX?=
 =?utf-8?B?cjJSNVNEcGtuZng5eU1HWnFNdFNPL1Jya2lrcG1UejE2QUxCbUNGWGI2OGgw?=
 =?utf-8?B?Yi82Y2lpQzcrY1A1V0Vmc0EweVp6U3lSRTQrYVJhMXNEOW5qUi9LZG5OUWd0?=
 =?utf-8?B?QzRpN095Y01Deks2M0NhbkhteDFPQ2ZOUm95MDh5MFQ0SVRtRVM3RUtzVEI4?=
 =?utf-8?B?bExEcFRhMFpNR3gyNGxnTS84ZXh2WHVjbzRZb2Q4RnJyTHF6VHczNVdaSUFE?=
 =?utf-8?B?dzRwQ0l1SEQ4bkRCQjF3ejRjT3YrRkdGMUd6WmhvejMza1lnYVZlQmwvYWk0?=
 =?utf-8?B?aHdua2xxVmhvZS9zT2FBYldHOVFSTCszaWx5dDZ3UDIwZEdlcUFwbnlhdm9U?=
 =?utf-8?B?WGFPQU56ZUVkcDNIdGgzL0w0RE41NzVFQUJBWTVoemZMLzhGaGhheit1NkZr?=
 =?utf-8?B?akdHZmQ4NGJBb3k3TWZucGVlendUVHo2M0FVaThEOElMd3lkek9SNUg3V1I3?=
 =?utf-8?B?bGpHOEpydWk0aVRKbHFOdUg5NTBKWkRYc3hCaWtsT3MvTjVld2FzT2FtakVx?=
 =?utf-8?B?YmtjRjh1UGcyUThyMC9MQ0pBTnFXUUZVVE1LY0ZVd29lV2Z4L05oQnIvYjM1?=
 =?utf-8?B?VUZ3SkQrUGF0LzArMllISkJNbmRBTU9XNThSbTRhVjN4elZKSzBDQnlBU2RS?=
 =?utf-8?B?Y1ErZFdIU1ZkMzkvNVV1UGpkd0tNZVd4YTZqZFgrc3hMM3JrbzhTUkVnbVl6?=
 =?utf-8?Q?CQYlOTP8HYc=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 02:21:30.2545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d17e83d-d08c-43b8-b75e-08dcef1b93dc
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB9168

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


