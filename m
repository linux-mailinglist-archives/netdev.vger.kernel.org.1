Return-Path: <netdev+bounces-179223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E60A7B29C
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 01:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D793F1797B6
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E101E1C1A;
	Thu,  3 Apr 2025 23:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="F4sdTMJ9";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="gcqzvSr1"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7F21E0083
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 23:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743724533; cv=fail; b=a3PL5z6pw7zqOviFwHbvnJtcmxYvylOzzF3LWgxjEinjNPO5HU9igoeIp/H7hYbwUepjHTKT5AhZ3WOUFs/QgDUKNpqWkDqJys5IcWNpa9tiwhZg5KCppOGmnosIh3Rz12X0murz0J/cHEvag7glh8mCJbDlGqE59gAJnf9Mhms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743724533; c=relaxed/simple;
	bh=s5HeGzX3nxeK6ua2673jriVYoMkSF4oNL3DNryMRH7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dK8s9p328zwg9sDIyIAfwAUOhjhSQyYWYgbkI4PAAe5yWmzQ3yrhaXfbKZ1iTm/ItcYhYsh+KtpwKZm7Mi4ZFX/Dfp81WSlNSc+9LFVmDWu/tnA2GwPRNOiIIEdRYPX086b4huQ84R50BFEJjP2Q03yGA64qx/rZeYsBKVldCNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=F4sdTMJ9; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=gcqzvSr1; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220299.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533NfMcB004746;
	Thu, 3 Apr 2025 18:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=huJSe
	/0k3K4HxOqSJmsUQk2I/wmwvJOqkJz1/8m7JE0=; b=F4sdTMJ9Efr+mF7wdU+LB
	68fmnOb7WecULT9uvzRroXdvciA3bUx5mj6k7ciOeTPMNs+s/Uiq8kK9p0tafD3y
	DKte4kviZ9XN0xrEZoWQJxsyqrRFpWSMB4UyATARIskNpHBlrNrYCiWGJmnA2Eeo
	2kWsLTJerRRiVl94KIm76QteQP71NXk5Y9XcxpuW0ydmQgeSNyu9hwp4IqA7G7pE
	WapG02MmWis+i7T+FI2tnmllqwbZKHN+kYniovCrQIm+r8EBmtG6oZJpRWv+6RFU
	X0v0rfb7x3rupC2ljxwEsLm793qOjCC1O9blNH+/XOsKPFdmgPAYqiKPV2KGJTlL
	w==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45stmn9824-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 18:55:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1pU2yrOOxD9xzHQ2YGR92Rvm0UOL2zYOF0GdntRlCr30NzKsIxZs5qDYHLZhk+o3AFVA4YQboaEEHgP0HGEODZARbajZUVO5bTF+Fonz1UrFWFc5OYyzU6ckTtjpdO2qUHFhqEVfLgY306zJT19J+yW+5Ghs9p0PQ/hCqQWbfC4sHjv7t7DODQ74cz2NPnVnnDgegVf70jIOdlva7JP5ZwaNywrzOAJj5Tz+RFmWemFG8mdXTQbM9JzmZs31NiaJ9msvsqlSljvGtN4cfuWga3y0/X+QvvmiNvwE6MyzFU1vS6jseg3nQDJ+ulFOT7f6KxTV7369RwcRzuHYZuVqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huJSe/0k3K4HxOqSJmsUQk2I/wmwvJOqkJz1/8m7JE0=;
 b=jc9qloHPFkR2lTEkHlnslYn5Ir+jMVO5YPzsfUWH31j0XmOF6Af4G/UhPE3DkMCqcqLOQHl4MVaiNew3NcnxV+zR8SUB5dWZUdQHN2P81Ex31F50X6I19n91lDVbl1NdDT4ENcDGxs8aeJNSgHUA0kGOYkNLEbz8AIjVgYtAZWb1ju8X1vWcxgPK7lDpIAMOhiIpt2h/traPSuaghL4K6him4/XdROsD1bjZ9UwTbWx8sGgp739ZkLxqZK5YzyYlA8BAPF7Rp/3nmAtj+zwQ6TMApBgrVDe1aT+mTNyhapJkASXSgu50a/Qn1dZoBjjVEIBnYXZV6IuTfiuJgs9/4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huJSe/0k3K4HxOqSJmsUQk2I/wmwvJOqkJz1/8m7JE0=;
 b=gcqzvSr1Eu3jT2afXrwizGKQ5v24MsRjes9TKN5uJ42D3m899XV8P17N/G2fosgf1awYW9j6yOK5F3BdAgaCXEsASYk0nNoQzO3eRtMPeQtHWXxLVdwXArtvuIpY6uKAJdQvCbB9ceHL2OfnSY4fJB59oGwV2SlctYRsI11PHO6jpTBq2T26a8V9U+dcJCKrt/opnG2FiV57FtDkVAwIb0vC9Qp1x/snXP4btySI6T4ydXk6L1VyYrCeGyKs5RvvCpfB9+AMfY+GBOMcfr6gesTDRNh+Xua/Im/Blmx8bcJMsTddADmBRBcEWNaP1/Qkbhx04nbHLzsyLzSWjI5RSg==
Received: from PH7P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::18)
 by DS0PR04MB9415.namprd04.prod.outlook.com (2603:10b6:8:1f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Thu, 3 Apr
 2025 23:55:25 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::65) by PH7P221CA0010.outlook.office365.com
 (2603:10b6:510:32a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Thu,
 3 Apr 2025 23:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Thu, 3 Apr 2025 23:55:24 +0000
Received: from kc3wpa-exmb6.ad.garmin.com (10.65.32.86) by cv1wpa-edge3
 (10.60.4.253) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Apr 2025
 18:55:08 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 kc3wpa-exmb6.ad.garmin.com (10.65.32.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 3 Apr 2025 18:55:10 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 CV1WPA-EXMB1.ad.garmin.com (10.5.144.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Apr 2025 18:55:09 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.72) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Apr 2025 18:55:09 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>
Subject: [RFC v2 iproute2-next 2/2] iplink_bridge: Add mdb_offload_fail_notification
Date: Thu, 3 Apr 2025 19:54:52 -0400
Message-ID: <20250403235452.1534269-3-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403235452.1534269-1-Joseph.Huang@garmin.com>
References: <20250403235452.1534269-1-Joseph.Huang@garmin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|DS0PR04MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: b331e605-a3e5-474b-498e-08dd730b009c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gffVuFL9DEzjoW4v/i1OHwwzI7RioErsxHklOxLw/suaRmTdrGZ5BrffKe3p?=
 =?us-ascii?Q?TyzpV2deQj626AmBTBRWeGBE2L1xQGWH6aDcup1AtaOcayUcyV5DxGD714XV?=
 =?us-ascii?Q?C+WpMm8eZVZTbtSjHQw/z/AqH9jshNsVysU6izemGLNdMUX0jCSzpjgTdPUV?=
 =?us-ascii?Q?5s/tPCcnU52IEc4ShIgiKATAPVYJr0RASH59059gjPUGw6jo0xTpZJyWKeQX?=
 =?us-ascii?Q?rIAyIgAgquCDRQ9QZX+lTJzaIzNtGMOUV5OV6CboPNaPHOoW6A4XdRE2+zOT?=
 =?us-ascii?Q?BRGzvjVp5YvVjGSA8rVljpm1W7nqzZDfnmLzehWqOIBZQOO6Ngc/SWTDJjgx?=
 =?us-ascii?Q?Cj/9Q0xcQSFFBWbmYVRzcbbJH7ePqk/Ce/PEpd6bzsHe/+7btrzoVuHJTez0?=
 =?us-ascii?Q?Uh/3a2s92bPwK1cx35ot7OsPfInh3X3PPqP2OLyGZnWndv+aCGYyOCr4Qoy3?=
 =?us-ascii?Q?stSlfFlc8yVxg5/punXSm9UEOBFcJN/AqjZ6rcYFinvuVQecRodUx0I40UGt?=
 =?us-ascii?Q?A+e5kSsFslA6dFRzcOxtnPwqPP829G7Qs6qHkJokfT3ZcYCC2gUaUzETq0hM?=
 =?us-ascii?Q?THrIFTrHdKiDnv1e/y2Oz4FBra6oEcfVUWeU4RgWIKSRHneg6anNO8e4VB4U?=
 =?us-ascii?Q?Wl7pKhUfznTiN4xntJ7XNz4EzCodOMdrgduwznARSRd/x1w/+XgF/oT/X4Js?=
 =?us-ascii?Q?RqdAY39wEmdq4ZPxUp02McJ4QqM7oLv5DOw6Lie+0fF0WDETL3Y0c8eWyRsQ?=
 =?us-ascii?Q?yF8PV8/a9x7GKA88/EhiYb3v1aziOYOCBIavFnp3psThHAeBVBzxB4ZhpxsY?=
 =?us-ascii?Q?ioYOVn6lEJUc+t/mXNwyNoUb9G7Sl/brg/Oje3GDGGO217n6sQHvzR84/m5O?=
 =?us-ascii?Q?akcCAvkvOfqqALAyGVSufDVHRqfNCM0wFoVokDLbP3TDVEHkEeRmRBH0M86z?=
 =?us-ascii?Q?grVioVVwF5cT8SFbHF0hNPVBnBSprK0xHK5fLtg5pq+auqt3bGzByklqeZtS?=
 =?us-ascii?Q?2s5Tp4M4YiNMaC8jzZuLbu1rVZqe/mb9CIJEHMPFHQmWatpsIIhYmRPfFYpI?=
 =?us-ascii?Q?rtrkiEJfnCPExexMOA9R8EKSaCWZXBOY2sWTCrFiOY4EXjybZ0QtWKznEab2?=
 =?us-ascii?Q?/UIQRwrIpygpC2x8ZCy1eCdbEPBglEhfAHn1NXTq/Vtin5yYgPB+TY1QqM3w?=
 =?us-ascii?Q?bJN6BAraKl3WoxalmrSlcZx+voDXOUcU+ILC8NqDlos2LcJX/EB9gjwSFuzF?=
 =?us-ascii?Q?WYuhv5T7GwjQa3rsATCJhX5UIK6Zi8ATEA+31gx9h9BbO2pCE56XkfQWuIA9?=
 =?us-ascii?Q?N7fG7ke+68rpecMq5FhVBXEKEwrFLL3jcN8J1PJoT2XqoxAkyzP+ZxVNBUZH?=
 =?us-ascii?Q?yIsJulpXJ0+yIPUK1BggFFiZIMSufYCAJcjOnDqiFdxVqxRvkJnHHlF++Y5P?=
 =?us-ascii?Q?uKayXN6oacPLe2jL5FqlivNeVpXf04nC6lKXhBxti/SlSmKFekZDCQvE08pW?=
 =?us-ascii?Q?nFqsf9xzhyj0cNIu9J/vIpCtS92uYmHHLw4O?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 23:55:24.6992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b331e605-a3e5-474b-498e-08dd730b009c
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9415
X-Authority-Analysis: v=2.4 cv=a90w9VSF c=1 sm=1 tr=0 ts=67ef1ff1 cx=c_pps a=YmitjTGdGiwdiEq1Q8pHfg==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=Vz2XUcs1E-zsfEpk1-EA:9 cc=ntf
X-Proofpoint-ORIG-GUID: JmpVoORgv6kpjc4JHAtIhNH-thqkrksI
X-Proofpoint-GUID: JmpVoORgv6kpjc4JHAtIhNH-thqkrksI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_11,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=855
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0
 clxscore=1031 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504030127

Add mdb_offload_fail_notification option support.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 ip/iplink_bridge.c    | 19 +++++++++++++++++++
 man/man8/ip-link.8.in |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index 1fe89551..2233e47d 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -62,6 +62,7 @@ static void print_explain(FILE *f)
 		"		  [ nf_call_iptables NF_CALL_IPTABLES ]\n"
 		"		  [ nf_call_ip6tables NF_CALL_IP6TABLES ]\n"
 		"		  [ nf_call_arptables NF_CALL_ARPTABLES ]\n"
+		"		  [ mdb_offload_fail_notification MDB_OFFLOAD_FAIL_NOTIFICATION ]\n"
 		"\n"
 		"Where: VLAN_PROTOCOL := { 802.1Q | 802.1ad }\n"
 	);
@@ -413,6 +414,18 @@ static int bridge_parse_opt(struct link_util *lu, int argc, char **argv,
 
 			addattr8(n, 1024, IFLA_BR_NF_CALL_ARPTABLES,
 				 nf_call_arpt);
+		} else if (matches(*argv, "mdb_offload_fail_notification") == 0) {
+			__u32 mofn_bit = 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
+			__u8 mofn;
+
+			NEXT_ARG();
+			if (get_u8(&mofn, *argv, 0))
+				invarg("invalid mdb_offload_fail_notification", *argv);
+			bm.optmask |= 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
+			if (mofn)
+				bm.optval |= mofn_bit;
+			else
+				bm.optval &= ~mofn_bit;
 		} else if (matches(*argv, "help") == 0) {
 			explain();
 			return -1;
@@ -623,6 +636,7 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		__u32 mcvl_bit = 1 << BR_BOOLOPT_MCAST_VLAN_SNOOPING;
 		__u32 no_ll_learn_bit = 1 << BR_BOOLOPT_NO_LL_LEARN;
 		__u32 mst_bit = 1 << BR_BOOLOPT_MST_ENABLE;
+		__u32 mofn_bit = 1 << BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION;
 		struct br_boolopt_multi *bm;
 
 		bm = RTA_DATA(tb[IFLA_BR_MULTI_BOOLOPT]);
@@ -641,6 +655,11 @@ static void bridge_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 				   "mst_enabled",
 				   "mst_enabled %u ",
 				   !!(bm->optval & mst_bit));
+		if (bm->optmask & mofn_bit)
+			print_uint(PRINT_ANY,
+				   "mdb_offload_fail_notification",
+				   "mdb_offload_fail_notification %u ",
+				   !!(bm->optval & mofn_bit));
 	}
 
 	if (tb[IFLA_BR_MCAST_ROUTER])
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index efb62481..3a7d1045 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1753,6 +1753,8 @@ the following additional arguments are supported:
 .BI nf_call_ip6tables " NF_CALL_IP6TABLES "
 ] [
 .BI nf_call_arptables " NF_CALL_ARPTABLES "
+] [
+.BI mdb_offload_fail_notification " MDB_OFFLOAD_FAIL_NOTIFICATION "
 ]
 
 .in +8
@@ -1977,6 +1979,11 @@ or disable
 .RI ( NF_CALL_ARPTABLES " == 0) "
 arptables hooks on the bridge.
 
+.BI mdb_offload_fail_notification " MDB_OFFLOAD_FAIL_NOTIFICATION "
+- turn mdb offload fail notification on
+.RI ( MDB_OFFLOAD_FAIL_NOTIFICATION " > 0) "
+or off
+.RI ( MDB_OFFLOAD_FAIL_NOTIFICATION " == 0). "
 
 .in -8
 
-- 
2.49.0


