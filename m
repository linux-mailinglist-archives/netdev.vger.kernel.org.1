Return-Path: <netdev+bounces-175929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ADAA68004
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60C717D102
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 22:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204E6211A1E;
	Tue, 18 Mar 2025 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="NxDK6uDe";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="RMWlwQxF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA241EA7C5
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338244; cv=fail; b=mmbknEhbKqBJ4JKFcqqJcGcDOlL9CkcFLUoO2o6TzwhWS7lr447HSKb/i/HFi5JWDdLA/FWijtIlHNSnJcBLNHHE5NtTBMdj/5E0IKKd9qE3IzXEQOUL+g/UpkO2TyHl6xyvQBWINwueYNXDA6dAvhP2IUqsDiNs/9cipKZ5PVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338244; c=relaxed/simple;
	bh=FLKlZDwe/7ttxSyBEVxxkdVGaPf3B060qXTq/YKcKtI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gPpzMbE6Ztwe2TSv+m8GaVLUmfp3p6+Sk192pPgPTxlLuWGilO4QRtlpUASmdVzIjEsb1rMXT33w86Cc78ur6f5ueMc6dyA7znKgvHedCE8FK40TcKM+r9+8S6EeeczHGb9Fl5XtODL16+mMjlF6PQ7M5zH2ljS3ruvFX5CzXws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=NxDK6uDe; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=RMWlwQxF; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220299.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IK51Hr015867;
	Tue, 18 Mar 2025 17:50:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=axOzeThop4pO05/dnUSWvrn5AAe
	10pDhGqZzTKr3z3U=; b=NxDK6uDe3nExWdRAeLdr2EDrAxzzZVveFaVaHS393UT
	WrOwqE3z+BC/RxS6wiHGZR55YoEEaUHFIpCMa9qQAgqPEnIiQa5nh6M38cHYxyY+
	So6EX0a6JeXvHX6bUQObi3B7L/83SUABQJnzBirkQCP0HGbCgd/qn2fR+n7Q2tBZ
	C8FbH+BBgCoaASvuAqHXDYF5J1OXZtQFScTOnzbKPB9ViXhsAXFV5Vz7jDf7yd5S
	lnDYt0NFpZxnCXobLSXZOCQYkzMZkaQWvvLwFG3f2++LWxQlbzti+KPjnJgxnBp/
	81+sEst5WDiQeNYcGR6zHZJiAslohk4L6WiCvbLzY2Q==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 45f6whha5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 17:50:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EETU/rbnw+EAK9hWeu6NKbdB8if+D+HQfPvznth7N8cP725OiiC0qowTzuYWatRaff6xLufsC5kgaPpilNx7Hs4A15XloLhm5X8wBKdH+R1BVbYM69M4fbsURMofraITIgkcgxpGVX5V40FvGIVqPW6Ic9wacQ7NPtQYb+x5u7tgThzdvBLlp4LJqFF7mKGYKl6v7dz8jJHb0Q281NlaMDpnsyT14X1xwHrrPSF6NCVm6NbPCle7KULg+Uq+SX+huVR2d0r6e6bKThW2pKCkfRJrNA8joy+yrpxwEfE+OycnemLqkQoBFl6dd9+KyU5SqMKqi5E/DNXSbE3ElDnGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axOzeThop4pO05/dnUSWvrn5AAe10pDhGqZzTKr3z3U=;
 b=VoozC9yJNVwUkAZUvq+jx7THzSe5TFiYisyCNegeOHCjHfBzneas39bMlqJwz7JcUOsnrHD17XVUcpG7Nq+PbWtK+hEla7/PjcLgzkF4682jvB8EUwQWNR8750yZnfv7s/PH3VtxAPedzVvpitxpRgwnEAtaGeG1xXVt6HNEr4PaT459Hq5X/rQxIWmAyeqC08F0ZJH788REAf5OHy5pCxi8Ok5A+D9nRtp0LLdnJizBF7YUsjVWK44CrgTd3Qnq+gHWBoarLeHfD8M4FTkmKrqkbDWVlT4jWk8d9WDIjciFDKH/1QLmGVqsumIw3alRt3VrhmJanuxi0qKkmnrYTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axOzeThop4pO05/dnUSWvrn5AAe10pDhGqZzTKr3z3U=;
 b=RMWlwQxFOT+P2gerVBw3RkMGYTdOh6kl2T7Ef/R1h4VecEVCqiQTCwuaj+O8yRLJ+lX/IPJy3xQ43b0TAcnvgwr3RW4vpguZ2CoXoRjptn5pzXlctYfR7nOW1eisF4lEcCLzpj1Gz6F534YBrl5KLGf8CNp7Bj6O+y0diQhUMz3vi1sPKZGuM27y7HX0uYdDFJPWfE2tAeP7xQshqV+OH0lovx6CXtjjuMVVjwsrwOpD+wmINNEgWyxjeJRzeOgMp/rGjTOUhvxPLza0NINr/ZtOxjm9/Jzr8XL9KpCsTR6Z91qaDXkEGIhJOIxolcrObuO6f4yAtnaPMMX+3jXM6g==
Received: from PH7P220CA0083.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::19)
 by CH5PR04MB9576.namprd04.prod.outlook.com (2603:10b6:610:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 22:50:37 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:510:32c:cafe::34) by PH7P220CA0083.outlook.office365.com
 (2603:10b6:510:32c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.32 via Frontend Transport; Tue,
 18 Mar 2025 22:50:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 22:50:36 +0000
Received: from cv1wpa-exmb5.ad.garmin.com (10.5.144.75) by cv1wpa-edge1
 (10.60.4.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 17:50:30 -0500
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 cv1wpa-exmb5.ad.garmin.com (10.5.144.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 18 Mar 2025 17:50:32 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 cv1wpa-exmb3.ad.garmin.com (10.5.144.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Mar 2025 17:50:31 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 18 Mar 2025 17:50:31 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>
Subject: [RFC iproute2-next 0/2] Add support mdb offload failure notification
Date: Tue, 18 Mar 2025 18:50:24 -0400
Message-ID: <20250318225026.145501-1-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|CH5PR04MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4119b8-b1fd-479d-4783-08dd666f4cac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qHgjJjrLdUmDkzLfUQH22MrEjSh6DvOFXJsKUmHdUOdEjGnlr6dYgRIOymxU?=
 =?us-ascii?Q?ECI+TTWYJEZWuaDfgDTvNhBki5JoPvwdk6xstvRl5GD8BgG4E/bqQgO7STBj?=
 =?us-ascii?Q?/tD5cAMsEtZqckvDWYf/45hHZtZPHYN+dItbYDKFuZNFMgpjGoA975GBznxH?=
 =?us-ascii?Q?ihKBSBJrJ4MWUHBtC197cl06YEgyT+xDHSRvW8xuFGClrqD3OLDO2RFki98V?=
 =?us-ascii?Q?mSmWNAIGBEdG8IyejO6da8XndqqRgK2PrdYtXbCN8Vqc+voys/pN1R+SN2mS?=
 =?us-ascii?Q?hLasFQDBTWbZ1vY+j+HbvJ1DTWpexh29knMUIn0A7Wh7m1ts8n6/PXDzeDgY?=
 =?us-ascii?Q?cjTxCOlcD5lQ7oK51i3n+EJb2eZSdEQ4Nu4okm7fhJ5I27ZRdWwd6sS5q1oV?=
 =?us-ascii?Q?wlLCw9S3amoNo2VBhVIpbIPGy+YgyUve6A+XM+vuPIdRSgylDsM309l3MY5F?=
 =?us-ascii?Q?GsP4bCO/SOo4LrADZki5VySSXPM11XnJD84zn27t23H3y+zqPOC0i7VBfBpS?=
 =?us-ascii?Q?3j0GDWrRT4b4fmbZ0w+urH20G9gjtxn34EOi4Gccsk9/wYykCrV5ieMriPse?=
 =?us-ascii?Q?8T+5c1z3XfhasAIuYDbKZzhLN6gO4TawO3KYixKzx4ecy/1A9/kz6R4GJzyg?=
 =?us-ascii?Q?9HkVQ+X4OhwMj4dBYLHbtIrt4Fb5PYIqLbb9jv3qO3R3Dou6dWGi2RcIF+cI?=
 =?us-ascii?Q?ZxBY/B4KlqU1HXYaSHi3ZwCHzE/SZImdXk1fsl8OSsVY1b7mtITLH24ZFj68?=
 =?us-ascii?Q?loe3afjVpBqqrIJxOd+UQen1r0NOke4fxxBPzJh0B0zgHlJztUt4qqf4ZAIP?=
 =?us-ascii?Q?m0gs3euUPSM40vLOo+e9jiD0kk9P13YXiAEF+7ieK0Xge2aWtbNEi6Uylkw3?=
 =?us-ascii?Q?fpwrccFB2VntNTwxRap5Eubu54p0mhyIUvXR+V6Exe+RrB+DGCdpq/v+eMx6?=
 =?us-ascii?Q?ZzsKzNCYOoYJHu4XeJIIKaemUsgwn/WoOVm53sHUAoMvhJLPGVmMH1xCGqOQ?=
 =?us-ascii?Q?KRMWCrPKdLB33rGVi8+KxmXCXBILkozj9iACWxCiLi71dejqYerxQhQwxpon?=
 =?us-ascii?Q?2GDhZfRjMLYTKksOqZVziVbn//qPkCnoiaO4z9J8WlyQUsgjESP/q2Ht8Ee/?=
 =?us-ascii?Q?NHOXOR5U4fVrNx759oi7LCPXyAEZ3bvWARvcMgz+dFborGpYHPJ5rffsOrCL?=
 =?us-ascii?Q?DqNTFuKvTQ0562EefHBhL2n3sfZFfYpVfS193uB1yPBtrF8C006QyAFv1roz?=
 =?us-ascii?Q?i+5TlvdI4ngXFLHIFWRTBi2JT15yXJ0k0IsngKEsiP7vrBL2ZhOqCZ4AuKiW?=
 =?us-ascii?Q?w6FheZxQ6wWJmmboppDoZQxbs+pbCJh2Xd7DtLHKNQpu/IUQKkngZZQTqeQ2?=
 =?us-ascii?Q?hxd8Jh9LTvh0RCZeiJhjOEiZMPz41zFPD6a+Ga3UWYdjgFBbAUwTfZrhNkQN?=
 =?us-ascii?Q?c5HwnTPe127sjapJfyU+Nl3k2ZXMN1e3bTxsEpLqtzRUyK1jksV8F7p7aKEM?=
 =?us-ascii?Q?JiqKuBEPd2KSEYk=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 22:50:36.8833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4119b8-b1fd-479d-4783-08dd666f4cac
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR04MB9576
X-Proofpoint-ORIG-GUID: 867d-Ojyb6G4oBoC9_t-ClexafFLnoq5
X-Authority-Analysis: v=2.4 cv=b8iy4sGx c=1 sm=1 tr=0 ts=67d9f8bf cx=c_pps a=ybfeQeV9t1qutTZukg5VSg==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Vs1iUdzkB0EA:10
 a=qm69fr9Wx_0A:10 a=VwQbUJbxAAAA:8 a=NbHB2C0EAAAA:8 a=NBhV9B7xyHUUeEJycgYA:9 cc=ntf
X-Proofpoint-GUID: 867d-Ojyb6G4oBoC9_t-ClexafFLnoq5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_10,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 mlxlogscore=511 suspectscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0 clxscore=1031
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc=notification route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2502280000 definitions=main-2503180165

Add support to handle mdb offload failure notifications.

Also add support to manipulate the new mdb_notify_on_flag_change knob,
which is used to control how the bridge notifies user space based on
offload flag(s) change.

The link to kernel changes:
https://lore.kernel.org/lkml/20250318224255.143683-1-Joseph.Huang@garmin.com/

Joseph Huang (2):
  bridge: mdb: Support offload failed flag
  ip: link: Support mdb_notify_on_flag_change knob

 bridge/mdb.c          |  2 ++
 ip/iplink_bridge.c    | 15 +++++++++++++++
 man/man8/ip-link.8.in | 19 +++++++++++++++++++
 3 files changed, 36 insertions(+)

-- 
2.49.0


