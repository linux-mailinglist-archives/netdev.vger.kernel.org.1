Return-Path: <netdev+bounces-179222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7F7A7B29B
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 01:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93DE43B5C8A
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471651DE8A3;
	Thu,  3 Apr 2025 23:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="VpHj5yDi";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="l+DGPS0j"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DABE1FC3
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 23:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743724529; cv=fail; b=VWVWzTL7PXZgRnwGGqxdO8ih5Pg3Efi0L/ZEkD0zAuccdA0EQivtAnbdOt9NrZX67SsGWu0O11lO/ssfAYiZk5DHQLpLV32nfe8fNf+PL+1hrRonStwd5Pdie4HP3T6vcgJhyVK5tsV9ynSPDgRhV6BmW3QtLSLqSP2B08m86fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743724529; c=relaxed/simple;
	bh=CD/e7h2rqx5kgzB52I3gdDNbV0WwZ6Gp89v7jmXcSWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+OS0vjHUi07CjyHM6ExYu4nojt6PRAV3TDQprExWTYXe97l2+Wm5Cj4fUkh4NONeTHLj0uVxnZp+8seUU3lY58ZjL38E2rju7aSMjqnGLQ3Wo2LSWu6yqTUBTZurzHmEzD9/pVgcIPyxhL9aXw/q/xC6/y1+lb7YedjjaSM9zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=VpHj5yDi; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=l+DGPS0j; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220296.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533I2Anc006335;
	Thu, 3 Apr 2025 18:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=OLRbU
	KynRyY3wxzhlOrEFaZQbS6XH3EzrFIWWdgqsQ8=; b=VpHj5yDimTB4YJAivfKJx
	fC+RomVVzpXt9EZZ9sWOU5fQKsjhRuisFJ4QAvg6GlKCrMFQB/S6BLYGyPF0D2DB
	fhp4t8prM5GuV3vRk04Drn9R4KtqDXvvu2DxgTsr80WVSxbWqH7d96FPPJHEVDlw
	xB3nOlQhH8biXroOQVpVVydSV856ruy6f5CmZYp76d1vUfRrzdz02tchXZGBwPOX
	sfadngFV96r7RSfur+aMRarLj66ykQuJRlnarJOgcLQmEVVO5rPt8uEooUNYR3Qh
	7WI+oDB5rnm8fFLfemfc57gngVm1SFzogIlYrveNhyZr0Gv4avg/MgD9BAWnKNgF
	A==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011029.outbound.protection.outlook.com [40.93.12.29])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45ssgwhc6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 18:55:25 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRwvpwwur8WXuE454htCl4zjqMTEZLuwLWBQzB/zEIqgH1k65G05ij+d3jBcdxtFAwYDb0+DcynaymqbIY3ER/CJfnody/13PBo+aMAwE5BEOmjIMTq39f2V0NB8dJ9jTPEjwnEnOaPttHLJ/584oadrwhpb5o6OrNi6Xt3xBwe4oTFrJSauDm8sFKhGElWzERKuGQRBC7BKKXI+zq0gZnVTqbr7rjB2rgIBi0ArFYooRdcmlkB5JsgwHSSVCrjZ5QkVZgCmcJubRB1vLHJh5lkbdz+So6RFenxiTXSNEMbOR1AryJBj5Vp/tdwjUi7JlfGdwvTytRowUG3dASBGrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLRbUKynRyY3wxzhlOrEFaZQbS6XH3EzrFIWWdgqsQ8=;
 b=dez93fiplgsEJp8WXEO8gtkV9q9bYk4DQcUsfrEd1gYHNuyo/eBN+ABTTr6o1JuvlgTTwaeMot8kjE4aSCRFOq/KAzc5FEmndonyYPScXYFWKt3PfoQetUd8/mDfq/do5oxXFQaBlprG3j6lmbY2hkwSLpF5Ri4aq5Jm6Akby/XKcOwhZQZksiy8o6dm3Hhf4LPhtII6oIGxIIfY5ETW3MIymLde2b20soGk7XCxlptzbhuvwCRxZ0RrbZV/VecQoRSyy0mS0ewqDf56RjP6yTAwdfMu99nXJJ5Ln41+p3dEg0FCBH9pLBjss7SxOvTLK2un0JocRYl70uRD6ARAig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLRbUKynRyY3wxzhlOrEFaZQbS6XH3EzrFIWWdgqsQ8=;
 b=l+DGPS0j156H31EzlZC7TV00Ft/CacV0/DlSLgS4mbEtJOHFS7ARLWeq6yO9hx1aFUNVj3ZwMAv2mFiixdtdY1q2xB0OyeA4kJkXIzrayi+b3f9YxSVhkE1lwJC+CBbykbsmkTMUpCi13c8WcAD8jvFQHpKmEFO9b34MkgSkQy5o3RQu8rDFFrf576y6UO81CzRRrZfiYifE7GHFr3GfLIjHNPiQxrS3Waz4adOw9R3BnBd5K+lmH9CDjZTEYAGH2H2akrlB+w5KKTWACvkgeFkTwKjo9WAwAy558FbOaHftmQpHaNcH2FGNNxJXDcw+teFdMVrmGzLf6ZTgXnDBUA==
Received: from PH7P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::12)
 by CH0PR04MB8017.namprd04.prod.outlook.com (2603:10b6:610:fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Thu, 3 Apr
 2025 23:55:21 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::b) by PH7P221CA0029.outlook.office365.com
 (2603:10b6:510:32a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Thu,
 3 Apr 2025 23:55:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Thu, 3 Apr 2025 23:55:21 +0000
Received: from kc3wpa-exmb6.ad.garmin.com (10.65.32.86) by cv1wpa-edge3
 (10.60.4.253) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Apr 2025
 18:55:07 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 kc3wpa-exmb6.ad.garmin.com (10.65.32.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 3 Apr 2025 18:55:08 -0500
Received: from cv1wpa-exmb2.ad.garmin.com (10.5.144.72) by
 CV1WPA-EXMB1.ad.garmin.com (10.5.144.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Apr 2025 18:55:07 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.72) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Apr 2025 18:55:07 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>
Subject: [RFC v2 iproute2-next 1/2] bridge: mdb: Support offload failed flag
Date: Thu, 3 Apr 2025 19:54:51 -0400
Message-ID: <20250403235452.1534269-2-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|CH0PR04MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc22b7e-ba63-4ae7-9f53-08dd730afe69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sP37uDJ+qWFZNtnUM4apltPtrIzB9tSywCapPcOqXJkQNdsKggmFeZIWZ0+5?=
 =?us-ascii?Q?9skwkcUCPfrTru+R8R6/Zes+NxqevbnTkK44VmuJ1dqL+o3oUYPApBv6XPhC?=
 =?us-ascii?Q?OeodbpAHbsJ4Z3tP14KKbZ3jSeXwxB2grrF7V1pNWhOn9vkKjkfmIk36goo0?=
 =?us-ascii?Q?wFtZo7mzd16uwptDk+E5nXnMXP6d5lSgRfSUa+SkPCl61jabhiLrVQURM+Ur?=
 =?us-ascii?Q?KKA89xmzVQFIblTg5Z8tOsjvjFBGVgYEUp7umv1TG0p+e7w3+9DhYcm7rJBk?=
 =?us-ascii?Q?1JZq4ayAxlaKVLaYJ0KBDL9fpBX8bZm55Myqw/8m8QvKn3EcKVf51C95F5VC?=
 =?us-ascii?Q?P9AdAZBVyJo82LIpUw/Iz+fhXIPGZLIYYhYv3QjCMOEt42/NT5ri3xaHpyld?=
 =?us-ascii?Q?S9125WTxdcZqPnKntl+QFGqdu88cGr+KECKWalaeVUYoCLy1EkjderaMvwK4?=
 =?us-ascii?Q?0r4DElJPRDjznjThWJtDLgojT6G/mV+Gg0NfzqMtM4C86pHzM0QruQFc4F7M?=
 =?us-ascii?Q?z/VUs6WA7NlzvHTiDGQWBeQ+6Ddla1pevm0pIu8A4BsKr4niNsBy3mwDLnQe?=
 =?us-ascii?Q?iUbBu7XRkt/bcvMPj2EoxsQ7zQkUwVtEZTkBeQ8DmxwXhy9J9o6EXDQij9gJ?=
 =?us-ascii?Q?KK8IPRWPiacWieRtXvhlOdezCaSbA/rLbno/vcIYKEwG0+lrKWdZefYWU26y?=
 =?us-ascii?Q?wSUl3QMqVYSZRDyEIlGq8Fvpmoyw3GVTUbAa277c2OzrVV5Nt+xu4l6V0bCd?=
 =?us-ascii?Q?VMGrgFY0DL4Z71ohcHYpOSCY/fYJmpzCGyGhPuLc3voTt1baK+oAggfJa0YH?=
 =?us-ascii?Q?Mlv/E060u1X8ijdh++NsG+/SBOnoS4+/3PRe0+KzcojGNam+C5CifSpDRudN?=
 =?us-ascii?Q?LgfEJa8sFOWLxus6Nsu+Udslu2i4FxFYGG8nhp3WP6wVsKwYDsxnqFBiynAP?=
 =?us-ascii?Q?uaCmd0nydye0XjdwDsGgSTi8RYVBHtGdX4PWqLAR4ydQN0skz+SE4te07LBA?=
 =?us-ascii?Q?ippP6ZfapI/iPysmWqZlD5JPPVPpZGEDp6BqYg850avBAZsaPIm0Gz1pPTYq?=
 =?us-ascii?Q?iXGinkg3Go6Sj/C2UNWcYd6jvqTbTxmB7ly3K4rRtcCp93OeusbYhDYML45u?=
 =?us-ascii?Q?RFLN2iAB7AxGVPwJPcrEu/pxy0tYJ3U7eqaR3dbos8rX6dVMC0FdmFEqRVLF?=
 =?us-ascii?Q?1S6OWDx8jw+LAS9Gb40Be6KDs9byVWNJ4xUJ2yBF6krf1Ytiwcp+Ov0pfZth?=
 =?us-ascii?Q?KEeIbSeXP776XNOUbEZ3ZRVUb8JD+THO+z4wXKkz6Xd+3NkxBJKsZrPf9RF/?=
 =?us-ascii?Q?M+fZpIIqDGZRMEv04rjcjKybbCgQhOUUbJ38lQYqBv/bW6x7B999ykhsnm9C?=
 =?us-ascii?Q?fNK74xQkGeJ6cTmhYbuSDRVq2s7DcvR9DmxZTosjn9k6ygg93xtb2KXUMzXQ?=
 =?us-ascii?Q?x10P3TnQyUmScdkJvJef3h0ccEnnyFPjVlGK0B3QS4307c71XTGe+F7g3/fL?=
 =?us-ascii?Q?QXNubBdR5/oAdI4=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 23:55:21.0274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc22b7e-ba63-4ae7-9f53-08dd730afe69
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8017
X-Authority-Analysis: v=2.4 cv=OcqYDgTY c=1 sm=1 tr=0 ts=67ef1fed cx=c_pps a=djVjp5eVWc/OO4qUaLGr8w==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=vJ3Si-Bo0Wz43vYLVJQA:9 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 cc=ntf
X-Proofpoint-GUID: 2aWC1To5IJ6OzAkOJdY0w4_t610JWVNq
X-Proofpoint-ORIG-GUID: 2aWC1To5IJ6OzAkOJdY0w4_t610JWVNq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_11,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=937 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1031 spamscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504030127

Add support for the MDB_FLAGS_OFFLOAD_FAILED flag to indicate that
an attempt to offload an mdb entry to switchdev has failed.

Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 bridge/mdb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bridge/mdb.c b/bridge/mdb.c
index 196363a5..72490971 100644
--- a/bridge/mdb.c
+++ b/bridge/mdb.c
@@ -256,6 +256,8 @@ static void print_mdb_entry(FILE *f, int ifindex, const struct br_mdb_entry *e,
 		print_string(PRINT_ANY, NULL, " %s", "added_by_star_ex");
 	if (e->flags & MDB_FLAGS_BLOCKED)
 		print_string(PRINT_ANY, NULL, " %s", "blocked");
+	if (e->flags & MDB_FLAGS_OFFLOAD_FAILED)
+		print_string(PRINT_ANY, NULL, " %s", "offload_failed");
 	close_json_array(PRINT_JSON, NULL);
 
 	if (e->vid)
-- 
2.49.0


