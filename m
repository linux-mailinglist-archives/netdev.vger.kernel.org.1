Return-Path: <netdev+bounces-137171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789129A4A04
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 01:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363492840D6
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 23:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EF0192B9D;
	Fri, 18 Oct 2024 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="PxnvI+85"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3901192B81
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293641; cv=fail; b=ihZMQEQPlZZYnKS3wkIpx3WKL0zQSE72lQIKDhEDTQu9m4cJI6aiRHUz+u10fTwZS0tJjVhFzY3UCsxocC5HSXX4bPq3XnSwlxu0okcZLuvgY83K9CfZVFFuYscjwRyfdpSB5tygmPIGFDSnwRCT6rwLdyGJzo5+4ZmRM61RCIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293641; c=relaxed/simple;
	bh=gRq09LiTvCqu77G3UmHFbQ+dx7jyMQRVGfRk6XwUonA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLtyEXXwoeeyrZfHqwVftWH/rjfsvyTvsfssq3isW42V0ItjegofOP9gUVlXUOhcEkmxcCNwyr1EhjGxD3e25UQvHiGBa9qqOH6aFeQaH+4QB8zOSY7Cyc8DRitNjGyJN3CPs+TYAS23424siJ3RQj7GyFM5b5ILD/fC0r+K7WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=PxnvI+85; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQrBr0DG5iCZIUVZtizDGycS5ZsjZXkZK11gFJxCCzyAWcTtLJ4NoHJcq0TXIVSSb3Mv1O/1n0zGvjOE/2NqwjzD3K1to6d8ky7CwRtZziFWE6DHrIvgn4FGD9hQDWfGEfculyF12K1tX/4dX3umCd4a4ZdC+tp6f2EDh3ztwxyjwRuZCfMtYOHHXOU4KLXOYIDvVIrQcq4CxYrVqR4aJOVvSvHGEO1u4q5J4N61XZ8JjvHO91B6iy58aP+ytIPdiZ+OZUA4qc9hYe9vsl1rzCZ+Vx6SaMi2u83/MBDa2dR9Ly3i0ItOw3R+lqMYDX/dAcQbNXMragfLbwxfpopOiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anYE30uqxh8PVEBZAC+XD5FOG2Mh8l8iyfB2oxTXqwk=;
 b=nYmxYZyv0NOsWOJIHePe1rkTP7xOMt2HWjdikEcJ+kAv34/IrJv55nrs+m/9wTIPI0oyKk2NVNRp/sZcbb5AR9ZBGngHB+U4L61WhBuese1uQB04ndhu22Ky5T+vDOLRa7v3artGJfpvTmsWDfjLp5nqMSLNNY986AReRYR8MlavUUuox5nMMjEspZMco3ZMxDPYB7qrFY9a0dBhuLvnHnmrElfXBga1SWFzjbuCpEVxt8cJn4rWOD4OD/aFBxDojbKHv1o/fH/agQ0C3cCFKLVfQL7XQ4zKGgyAk8oVZQyuBIdk7ew4OWwNcTO/4RcmOEI+9d0AaGnH2xS8FQkZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anYE30uqxh8PVEBZAC+XD5FOG2Mh8l8iyfB2oxTXqwk=;
 b=PxnvI+8562+16QCmG04O19wXu5T722l5gEkc2l/D4Zfz6X/yF9kG7dKJz0RorSH0QFs3tcQCzOwaFUuWD0ESlSSKD9TcRYwqcf111DgZqzlWCPmkshujguB8uqJwMIh9ox9jihyMfb8DPeF8cd3FEOx1Jk/JQMRmX6de/yk3fjomF9+mKSGt6OwCvv3v3WpC4DQ68D9Irtra7TrhaeVmu6I0we3vup2fk4a57qHG+FgDGXEcfEU0ws0ZJp6bVXNA6VNRpecRk9J/mpxKm1TZSl0dPNHedpfvqP3XmwP8WZz8/cO7zglPmXMhMP/wqGA/EWc8pK//OJsAi6BcZvshLA==
Received: from AM6PR0502CA0063.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::40) by DU2PR07MB9434.eurprd07.prod.outlook.com
 (2603:10a6:10:495::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 23:20:36 +0000
Received: from AM2PEPF0001C70F.eurprd05.prod.outlook.com
 (2603:10a6:20b:56:cafe::34) by AM6PR0502CA0063.outlook.office365.com
 (2603:10a6:20b:56::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Fri, 18 Oct 2024 23:20:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM2PEPF0001C70F.mail.protection.outlook.com (10.167.16.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 23:20:36 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49INKJJd010239;
	Fri, 18 Oct 2024 23:20:34 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 14/14] net: sysctl: introduce sysctl SYSCTL_FIVE
Date: Sat, 19 Oct 2024 01:20:17 +0200
Message-Id: <20241018232017.46833-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018232017.46833-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241018232017.46833-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70F:EE_|DU2PR07MB9434:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eb5a53f8-288a-479c-91cd-08dcefcb78b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5AC2hR6akY5lkIfUL7LxfOVDil3M5YA9i1oLi5B5+25jGQVjKvLjkbnlztRG?=
 =?us-ascii?Q?NQ9PmiWn1uQ1TrC4o14qjmAY86fX9fagLQksG+K+QzqgtI7wzEO5Mjf9my/A?=
 =?us-ascii?Q?gSAcLRci1Als4lb0ShWHZoDge1Uaoxg9j+f4V38sUg+PBV4VF055aajLTbqz?=
 =?us-ascii?Q?0zIbtfo425j63ly3IQj4ILBn9ofgKG0dh8/NKairh0ND5I+3GvqWBbi0BNyO?=
 =?us-ascii?Q?zOTzQUhiLBoREmoIDOwvTwO5TNdI9k2gLPQX61yOA6semsqnxWx975QqlUxD?=
 =?us-ascii?Q?E4gE27I5GAKR2jNmQnNl+zOePKz0ez0F3bK6kBrfnICiWn5niRD5XUGFdwb9?=
 =?us-ascii?Q?GVg77fwS1WPoU4KYum9B/aPDsIo8J7bT3GTg3qwSIvgwWxzxIv6uaC/Ax83+?=
 =?us-ascii?Q?nsqJBvfFUTnp2EY7Qw8a6E/4j7moPczvd8BPf+Llz/UnT+6X94Ze9iiRZvUx?=
 =?us-ascii?Q?3Yvflqw9G/zRHsW5vqSW97pA3qDSR5zL8h2PSKqFXCU/KuXLZbjBfeI1paN+?=
 =?us-ascii?Q?VSwRu7l0vaDKwrK7vRbMGP1aeXKgLI5FCjItCmovwTn0e9Sc0Dw6hhenmIl6?=
 =?us-ascii?Q?Mtb0rI7XkNzCiRzzn+ZqiIsO/0ncf0vvfT+egGj4InqltKnV9Wm5kmusTMGA?=
 =?us-ascii?Q?Ukwz7Y1MoeLcjRu/CEyk0CKw89ZbP5KyXVr2hBEOaAvMXfRIIng6cwyDV56r?=
 =?us-ascii?Q?MTVwIuAFQENW7bCwHiPckwyRJ3ic2cJRFFWagzdXIN6ekXjKyVXz2LD3pIiw?=
 =?us-ascii?Q?1xjUnAoyUrrZcVo02m5wLRDVOTyZIxUwg3Q8h6OYSYRZGk2ul/naXwTRLe5J?=
 =?us-ascii?Q?38WIo9hwWOK+qvBITkNWWYLGACSFDE5CZa8qRm0pRraDN38ZCFdyyybAeY+G?=
 =?us-ascii?Q?9xYhPG15cuv2Mf52ghVt7qQBYo+Lzui+ukNdv9fMXxr9zQXDQIjKJNJ2/D3D?=
 =?us-ascii?Q?fi9IBk239NKcDMKE6wO1DWpi2FpA30KK7Ta5lyrQ+a0WolcEMYc/IDAFoXat?=
 =?us-ascii?Q?J1blZF6nCCAb82NzRtjXsRJTfqt1OSewznxn1beHEaED28CZjutPpcKYbJVt?=
 =?us-ascii?Q?v35EEC59aslYP6MYUIYFaFFjLPAZNjdo0FNQpJ9If/+n3qTjOD/2BLX90wil?=
 =?us-ascii?Q?pKZIJcEUH1A3/BfGeFlQfUdOtetRdXaUvjomh0vcT2C9paV/wOldJsH6lflI?=
 =?us-ascii?Q?yr6TrHTyCfyD5WHHTZqkM9mC08i68XyOQ470yszD2dJI04zUDAXZrilxlxdw?=
 =?us-ascii?Q?xc72JO+V/EDDcCDGVeTUPWtxMTM9kOZP73Zs5yB3rGc9XArEOyAJE990oSFX?=
 =?us-ascii?Q?RKwCT4ut2YXYxS8h05fFDVEZwzjBMENMM2bu27/GxlXpOn/qzuCxA1KWlTo1?=
 =?us-ascii?Q?JSOILmslzTqChUDiV+J8zKMLnxAC2ql4fnOmBxvIsK6/0lLrvRyyL3XrPaCt?=
 =?us-ascii?Q?h7DqWHKy5zo=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 23:20:36.1032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5a53f8-288a-479c-91cd-08dcefcb78b9
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB9434

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Add SYSCTL_FIVE for new AccECN feedback modes of net.ipv4.tcp_ecn.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/sysctl.h | 17 +++++++++--------
 kernel/sysctl.c        |  2 +-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index aa4c6d44aaa0..37c95a70c10e 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -37,21 +37,22 @@ struct ctl_table_root;
 struct ctl_table_header;
 struct ctl_dir;
 
-/* Keep the same order as in fs/proc/proc_sysctl.c */
+/* Keep the same order as in kernel/sysctl.c */
 #define SYSCTL_ZERO			((void *)&sysctl_vals[0])
 #define SYSCTL_ONE			((void *)&sysctl_vals[1])
 #define SYSCTL_TWO			((void *)&sysctl_vals[2])
 #define SYSCTL_THREE			((void *)&sysctl_vals[3])
 #define SYSCTL_FOUR			((void *)&sysctl_vals[4])
-#define SYSCTL_ONE_HUNDRED		((void *)&sysctl_vals[5])
-#define SYSCTL_TWO_HUNDRED		((void *)&sysctl_vals[6])
-#define SYSCTL_ONE_THOUSAND		((void *)&sysctl_vals[7])
-#define SYSCTL_THREE_THOUSAND		((void *)&sysctl_vals[8])
-#define SYSCTL_INT_MAX			((void *)&sysctl_vals[9])
+#define SYSCTL_FIVE			((void *)&sysctl_vals[5])
+#define SYSCTL_ONE_HUNDRED		((void *)&sysctl_vals[6])
+#define SYSCTL_TWO_HUNDRED		((void *)&sysctl_vals[7])
+#define SYSCTL_ONE_THOUSAND		((void *)&sysctl_vals[8])
+#define SYSCTL_THREE_THOUSAND		((void *)&sysctl_vals[9])
+#define SYSCTL_INT_MAX			((void *)&sysctl_vals[10])
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
-#define SYSCTL_MAXOLDUID		((void *)&sysctl_vals[10])
-#define SYSCTL_NEG_ONE			((void *)&sysctl_vals[11])
+#define SYSCTL_MAXOLDUID		((void *)&sysctl_vals[11])
+#define SYSCTL_NEG_ONE			((void *)&sysctl_vals[12])
 
 extern const int sysctl_vals[];
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 79e6cb1d5c48..a922b44eaddd 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -82,7 +82,7 @@
 #endif
 
 /* shared constants to be used in various sysctls */
-const int sysctl_vals[] = { 0, 1, 2, 3, 4, 100, 200, 1000, 3000, INT_MAX, 65535, -1 };
+const int sysctl_vals[] = { 0, 1, 2, 3, 4, 5, 100, 200, 1000, 3000, INT_MAX, 65535, -1 };
 EXPORT_SYMBOL(sysctl_vals);
 
 const unsigned long sysctl_long_vals[] = { 0, 1, LONG_MAX };
-- 
2.34.1


