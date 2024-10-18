Return-Path: <netdev+bounces-136825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D51F9A32AC
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49CB1F25182
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4D517AE1C;
	Fri, 18 Oct 2024 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="E17RSkZV"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1842417AE1D
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218144; cv=fail; b=K3ihyj6k2Zd9RWBDQkB9eesxiU4I0BSxRJp+YbY4yoc+X107gjCL80JvB8gXP/paa1SYMYBAhviUEDim/Pa0msx9MuKrLmTTXljJlb21LCO03AUn4DCzNlsKWnpFvYjVRS0LM9B5n1wmBbHg/4hvz+DGYTTLmnwvDqMUaVRQD6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218144; c=relaxed/simple;
	bh=gRq09LiTvCqu77G3UmHFbQ+dx7jyMQRVGfRk6XwUonA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=btO2tThSCsRqAzgnen+f32y0PJIV4w4myc3JJD1m5EBzad1N6mNXkiZFalehNHg8ltCPPALTLU9FzyC3wwOPpltGN+B6KuU6xhMHuL8OjPOQihYCPvgzFlHCOyhRAaRiimsh78tjvoYZpNqFv81vt76FfAL33HQtGwkkkuvu0Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=E17RSkZV; arc=fail smtp.client-ip=40.107.22.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+r4x57Rvv9E2w35f6H81XmYqOGNJ9JQrLaCSN3FleqqwGIS/DQlsWIoJFmmHSXDJpDqKAmI1aPKS5kfwbvKYOXV96nDFv8i0gAdtkpSYtogb56NIriK53DTE5UYwlEfXJm6Tk/XhV9D5TogFrRqSJ53z7vXP4FAOOk9mM4EL7sRgyVPRgUS5UAX3Ue324hlTpMZIILBEugBirroTs5xW0Rtj8cXUyPhqqO22jV6h8SKf0k3HQcB6nmskzfUL4UhKk9Pr9Qv8sm0szG5nZf/uBXjkBG9C2f/qu8TWj9DNndwAe9XML9YDpK/USU9Kx68W4Gk4VgCQlkPjs7N+g8CTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anYE30uqxh8PVEBZAC+XD5FOG2Mh8l8iyfB2oxTXqwk=;
 b=rd9bpYQl+KmJ6MG3hQVm0+eFBDwkEFUA0FcVM0Rf71AjMMluN2JVyAh+Y8m+k83JDCcxxS9MHy8HDLQUBhGLtBwx591Jm/YHGcI52XPgXvcdLrkpPMN4dvIkGBm5dvDWcP4wwGS8A+EBIrgW0DBx6BFUzlqzFrCHRTQjPtQCN+j7SE3Pj4MqAcYdCm9+gEr10HpCCtVdNOjY/1nAHRRtW50HOdzK9U/F/or7clBVi7GLn1GSWOqI5tOcrQVA5JzGzZCPJ2agfihjU0eAQHN+wNAwdcAO7s2mqB6QmIUEIYg98vbi7SF0PkfPhgjsT4fGisrM07ShsSISzBm80eXkTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anYE30uqxh8PVEBZAC+XD5FOG2Mh8l8iyfB2oxTXqwk=;
 b=E17RSkZVDOefPO0BL/WMkqj/e8KvBjblpDW/461USW+XAEOTzQ/nFShabIs946I4SxDOb7wNpd5kHIW1ZcbXwCHpu1r96TM//zcPdc+T7NllweRpNaYSLxoBY27OIgkLzrpJiaetfg/o+ba/kfTUZAioHGZ5K/C+kd+Z8w0FhUKYdY8Py5Yg2ycPxVUwqKJX8sbFGomDZXSKqPuyFukttzdE314BmGvMzXgUtsoYaM3yLk4FJtaGw/4G43PVcTc18OgV/4FcApbLRTwponmyHw5SlAegVhqJpF4Bc8YgKPu+sh+Y92dVmtinr5CMcQNuRx75K6CeBeWIkfd+9lldFQ==
Received: from DU2PR04CA0231.eurprd04.prod.outlook.com (2603:10a6:10:2b1::26)
 by DU0PR07MB9589.eurprd07.prod.outlook.com (2603:10a6:10:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Fri, 18 Oct
 2024 02:22:18 +0000
Received: from DB1PEPF00039230.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::ae) by DU2PR04CA0231.outlook.office365.com
 (2603:10a6:10:2b1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21 via Frontend
 Transport; Fri, 18 Oct 2024 02:22:18 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.100) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF00039230.mail.protection.outlook.com (10.167.8.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 02:22:17 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 49I2L0Mi023685;
	Fri, 18 Oct 2024 02:22:15 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@CableLabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next 14/14] net: sysctl: introduce sysctl SYSCTL_FIVE
Date: Fri, 18 Oct 2024 04:20:51 +0200
Message-Id: <20241018022051.39966-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018022051.39966-1-chia-yu.chang@nokia-bell-labs.com>
References: <20241018022051.39966-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00039230:EE_|DU0PR07MB9589:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a1ea3b62-9bc2-4901-fd87-08dcef1bafd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9GlpooJ0g1cN7NNODCStR8dOZMm+hmEsdp2yazDmRG4MX622zfM5UNmhyTb2?=
 =?us-ascii?Q?jFaBVQ2T+z72NCbIJJVq0o3jHCvU99SvY/3I0CGss47byyMFQyCx6G1wYDei?=
 =?us-ascii?Q?kq0E79KxyYW4gHkOlFywUD1uA9jzBczFNIb4AV/jnrmXhytAff/O4N9uwG4x?=
 =?us-ascii?Q?+rVURR1TJqXebpJvDBib1tMi+kFCFTD3A1l1CvePDmQ6APXF0dnadaZ8SBfy?=
 =?us-ascii?Q?Rn2zNa6HwQuWplLDbtbh5oe8DtkjPQgJPMhLMWZYE04Fkmef++LDxHLc3oTY?=
 =?us-ascii?Q?ts5Jx0FpORxFujKhyMhyv3aYlHZjGfyjwWqZtvJ5mf6wAyciAUaMJuQ3UvX5?=
 =?us-ascii?Q?6+C3LeC64jvTNGvA4WqvVKAIsN7EbjXBCvVes+mqDb5zjA0bwq495sIqt/Pv?=
 =?us-ascii?Q?B7T3pibRMBrpfHDiNtAPb2TX86Sy8BvKp28UymMUHHmBNNHgOtyHjPuotRn4?=
 =?us-ascii?Q?yHI8hB1chnDuR5YUZkqj8g6anMf5VpTPLLOHrtNp9Vx5AOXcnnQ/FfhhA9KW?=
 =?us-ascii?Q?AlY/UESMU3dq8U0aFD37c6nbKYv98i9IFId/EUPOusK+4N+Wrgvipsrycn3J?=
 =?us-ascii?Q?DA0aIgxvhW/KtwtQRXvRbK2JDqrt5ldaOmOuMYLtiKEEVrWZbrJfiiE8P2hh?=
 =?us-ascii?Q?2xA9EDbDQ81jLrrHoRLWk386z+V1n9pXOTjTZe3ftTACcjUFd8jgCrJxvAJ2?=
 =?us-ascii?Q?smw0gx5FJusYFXyTaAG639kGF/wPEf6heJwRZUZ/lPQyDNxjpnHP102yGUoJ?=
 =?us-ascii?Q?SwVjZZE1M9vE8gf9qCNHuGeuAcEXu9S5EH/l/QbrtX72M9FQTyjdoaLs/9bP?=
 =?us-ascii?Q?JtARgQIsIfduznoF2qoZFXZaUwBk5r+RONvSVP05qG/ykXsrI/LrNq4rGcyt?=
 =?us-ascii?Q?E8h8/B9FCafbDERjjEtAlvheZe+uOAIjbRta1dMWKdWpRN29sCQP98eBcYEn?=
 =?us-ascii?Q?fm91aLx/BDOhgPFf3IzdVKSrurQ8OtS+fkeheP10d89O43y1Gus9T7ykOW2G?=
 =?us-ascii?Q?1c7qB1Mt1meda2dK3yn48GJ03vUhqXprRQMqG71VF6VFXag4yNnhO5hCADmV?=
 =?us-ascii?Q?wZ09/jJiPG9MMG5Z8XjOiMcu9tJKJgGvcYPTTpaXpQgmpMd3naUHvtxwLE7l?=
 =?us-ascii?Q?4F+BCTUWhroNr9WU3urY1GlGm+iXMbx5l/yS8QhT8r6FNxmXWnAHj3r9SomX?=
 =?us-ascii?Q?rgFw45ckcbiRrk8cCnnAKes43M2+sP7EdBydh2m5Jc+hZnjxeElxkUE5VT96?=
 =?us-ascii?Q?UUa1L66rDTW+vCD0vL4YXH9WkxUkr0VXd0cjCQjhxts4Evi610LkBhWB/TF3?=
 =?us-ascii?Q?akBfn2aVAUAjiv4sh43mbvJZehdSZVPLyyKfI/JYsnGJ6hZwsYTkIgarMbQV?=
 =?us-ascii?Q?DcPNfvPLAx46Y1SzmiiYEYiPuFLkhqqaOqgU8ixmZkeKEw9MMsRySwwtWXGW?=
 =?us-ascii?Q?dYWTZTblkNs=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 02:22:17.1069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ea3b62-9bc2-4901-fd87-08dcef1bafd0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039230.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9589

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


