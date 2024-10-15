Return-Path: <netdev+bounces-135555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFCA99E3F3
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19D8AB21333
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35681EF0A5;
	Tue, 15 Oct 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="WhgbBMSt"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2077.outbound.protection.outlook.com [40.107.103.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273811E47DB
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988232; cv=fail; b=abmrDv6tNS9Te/J+9APxniU4shHbBDrud9q975IkkUzsG5qXt/MJo1esA6CCBWZRXcwaQdZid2yh9fZ850EpHHVUQUPBM0e+Cr96q/Z0uurSHhOCp4G95+ub2GcRHM0k7srNGwjnpqKGYM6jmvZn8Wzf6WdWgFcymPemYbZX1Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988232; c=relaxed/simple;
	bh=gRq09LiTvCqu77G3UmHFbQ+dx7jyMQRVGfRk6XwUonA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbUcVUuwDjI4DeZqYPFwnk9V6t9Y91bhFWHI2X6dQNthG8B6lnaJztJrxp6/QVuHLi6Y4egc9AFV8vIsmxpUo959i+CK7APOl1xIcrHmxhw2YeJoP8alO/J/5vED0OR40yYwHySX/nkKLDHUZWfnB8MLgsWI+FRj3qWOwaknkvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=WhgbBMSt; arc=fail smtp.client-ip=40.107.103.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkGOkDa1tDwohMsKGVvVTF0kPoRvVe0FVqPQZ0bydIS+tSAEI9b6weOJPfgYAFkNyRYzfKZQ2VsrdERaFoYURlAlQSPwBh/LYIp++RxL/EdeS1hhCYodfr1cNn8EZXH+ORXY4LpWbmB/w9vxMFYTTgi6Suo5lGNavg7hKevESI7bAj51daaAEZcIwAPwqWqG0M3IRIJj/jYurlm37STQh01xThDMGKine1irke97lXBOWMnexOSSll0bTrhcfuTsF/HJ3Ff/Fx2qUSs/WWgCJ9iro/euamub87OMMDnaUx/op7q0y2BZ0JXLTzA8afQEI+fIiI4OzDUrOImQUaoXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anYE30uqxh8PVEBZAC+XD5FOG2Mh8l8iyfB2oxTXqwk=;
 b=ftVVmuw0b9vwk2mjXlxykYO8t6OKdqznV0KLFiwOivBItHW6mX5mXzxT32YpmlRCY25gSQB4b36s4/wlKF0Mw711j5bjrMLhfdX+O5Kv8n2AFObz7477x24KV3Nnroued0yzbtBpYSuyXiuH3ocvrS1zcLRco58ulwR79nxn0mP1HA3p/exCsN93TOHKRsLe6kdtKR8YZMfzM0Yswxxp2p8fbrhbr+yGxIeWCWvqIyx9jXRSQNrqeDZCH+jupagU5UFHenQ63htETHhd5uZcJR5N7fAdsmJOS6B0hobqfE8HSkuXch8vTIRofjnTfw5bIIjv0hi1IBgWVAsd0H/3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anYE30uqxh8PVEBZAC+XD5FOG2Mh8l8iyfB2oxTXqwk=;
 b=WhgbBMStipQtBQsaebEu96weGiVsjLsoIfq9OPXaMZ7gzAU9kcVdBiziJ3LG3EQvEYfb0p9mTYuJpH/sBjDU0FXR1XNH3u0ZyiKtyqNi8508PpytG/mcW3rtbEOmR2cj6n7wZ4xX2Zx/NUyk8W8QskUa/Mp9gAcmVgasdIA9W0H3KI7LO44yDHueypAMIyC9Q2Hhq2Z+jXSldi+wC1tnUUHpxHsH/2XAbSDXdu2QNyIgNkRuKT/QsuZMSRj0wc5OfWs+CljyMip4aGZQ11Yu+D0ZTrgH7GEPMXtx4Lr6+FyrjTSjTMTOLVbqYHduSCNJxveUBl/DFUbF3rqCUJbzhw==
Received: from DU7P250CA0011.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::26)
 by AS8PR07MB7944.eurprd07.prod.outlook.com (2603:10a6:20b:393::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 10:30:23 +0000
Received: from DB5PEPF00014B95.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::31) by DU7P250CA0011.outlook.office365.com
 (2603:10a6:10:54f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Tue, 15 Oct 2024 10:30:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B95.mail.protection.outlook.com (10.167.8.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 10:30:21 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 49FATtnK029578;
	Tue, 15 Oct 2024 10:30:20 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
        koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
        ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
        cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
        vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 16/44] net: sysctl: introduce sysctl SYSCTL_FIVE
Date: Tue, 15 Oct 2024 12:29:12 +0200
Message-Id: <20241015102940.26157-17-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B95:EE_|AS8PR07MB7944:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 905ea862-4789-4f96-1003-08dced045fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QWtYJiHEOCfETGkBWLY+R9klQX44TMYzuOxyQ0V42itmWBT6WAIuAvStl9Os?=
 =?us-ascii?Q?Z8Rhp8ctoVCurEimwqdRlgLq04h89Al1qJU8S9IaVu3ml7sgfo7SC+ue68OT?=
 =?us-ascii?Q?fVrdsi430FfakRFqHwuTZHbkUDXnaaEJoVnpvyEm1/3uHiOctbzI42t5msGm?=
 =?us-ascii?Q?mkCfCM7efYSfM85rwrWuHJQU07DbzjxhAVxgXKa9ryzvPczG3fgvmOMp8QXB?=
 =?us-ascii?Q?YHviiWmqCPEs8PjCsHGMav89WbKDT3R37s6P+4plNJdu0bHEbBSetDVCYtW2?=
 =?us-ascii?Q?BlhwRxsNE5jzhnev5BlSm+zmVopxv+cYObJeAffizloBztpRcW7DNFKKPXl9?=
 =?us-ascii?Q?2q0gNPgX6QaVJ00YV9pcEtytWg8rM5KQOfrgJdfKCXaB63BY6eHMDgAq7Q5u?=
 =?us-ascii?Q?SqcPMBaJEY/zZ0qGPTU6r8LO87H27SSuDwNKIObwvMm5OidrBGydGEm4Tfie?=
 =?us-ascii?Q?jHzFYebNNnSwyfoX4kIMq8KpF6uFS1LWTFdj7U6gG57KMdUMgG7AmNhPBWmz?=
 =?us-ascii?Q?1rORs/GZ+rAdTSpVAHD4ZKUUSuCBk3eEkIaamhWY1Rc3hhigENOiRGzsdUoU?=
 =?us-ascii?Q?6QS0i8/+oUvt8fIoZ5Mtr+y5a3Z1KihZWS30v/EmO4vO8tvpo+vt1H4hLcDW?=
 =?us-ascii?Q?7/pRs81UbgoNqEI/lajY6Dx+WQ/tMrVLmWby5iInYJyO3MiDDj3dQAwEqOeB?=
 =?us-ascii?Q?L2JKJOgHXQ5/xRHETN72gSs0RvP+7h1oSGg4pYyquA9lVq+pwdbPv6V0kfaW?=
 =?us-ascii?Q?Ro+Ov/9EbJveiRUuE688zZGZZlckLJtxGEJwIoyZMjlzj0qur42FcQM8+I5n?=
 =?us-ascii?Q?12iPQWXlw+QmW4H5yzb3NlPmytqQBh5aDnPgrkbXevy0tdSLO2Xxaf9LQKhX?=
 =?us-ascii?Q?5Fcz8YrqD99ndEtYSYD/m/coYuXNfPc/VwwT0DC+vhUpFHzLQMIcc1rWmI+w?=
 =?us-ascii?Q?f1BnYnSZ4bV3tJw48yLWG9XRqWGzaSgr3G3GwNR677HuCZgzDIE1d4fxuLXi?=
 =?us-ascii?Q?xc02UhQHol2KVENgUynYL+PT2IngS7Tfueqha5HzorZpvQKeJRpy7CkODvU2?=
 =?us-ascii?Q?SctNfbTCGgyl7qfnYNN26F9+LWRrnipPVdAaGd+z7gJKN5h21qcN2YkPBxz6?=
 =?us-ascii?Q?DGR3QLngrkAJPlvmhAiHvnQiv6iULW/kYh0d2+5AtZde5ycow/sL0Q9MEXto?=
 =?us-ascii?Q?frlcTFec4G7x0osHhvMG6/GNLvnr3OAot/DhMvCbLwlhlCWAQoVCzRZN86iy?=
 =?us-ascii?Q?IKlHkMdjTinLdjJj7Wv8wthYZ518F4a4LJo677Ul3PoL0jjZEyZJgWVRHSS3?=
 =?us-ascii?Q?zX/+fA+KoKnIPdXsbusY/xUeMCfJa3rgBwbe8RDrqldGsEKGn0iyp0+youH5?=
 =?us-ascii?Q?8Z9/z1rM7EUzgOfAIUaOwBfyPptT?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 10:30:21.9730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 905ea862-4789-4f96-1003-08dced045fba
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7944

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


