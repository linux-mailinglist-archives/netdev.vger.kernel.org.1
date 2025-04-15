Return-Path: <netdev+bounces-182843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEA5A8A170
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C42E1900E37
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDE72973A0;
	Tue, 15 Apr 2025 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="vlSvvuhl";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="WXL48mhU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-000eb902.pphosted.com (mx0a-000eb902.pphosted.com [205.220.165.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8453C296D0A
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728219; cv=fail; b=LN7yhfbn3uja565DGyfilf3xjyaZyHUGgnZxEmml+zDEqeXx/4OypEzppHIUXC6z0rasq6iq17KJbElZ7jL7UzZLxtJYNMiQDXxDyVcYgFr+IikUUsCHNFRJGWqHGQvItz35waio80mHXa07LJvLk8h71dNoybUuDdSPgX49y1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728219; c=relaxed/simple;
	bh=S6GsHNYiezLW3H9u4W2GlIveq9nAoBVwBaj1kgUYISk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IWYaJSOKk/eAxbSbRQCJBrFp1Nhs2lSyjDpWlFmfOPpTcFxRIDD+KBzAZh35xWFawYt5aG00qunlplklsMEuJz6twULtwNIkaiv+FoquX8zh6c/u6hEmJk6hG05Sn2VU7VA+T0W699a2p70VDE1VF8np+JJuBgbnJ1jLjMrXX2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=vlSvvuhl; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=WXL48mhU; arc=fail smtp.client-ip=205.220.165.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220295.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FCMoH5030236;
	Tue, 15 Apr 2025 09:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=tZIr0YUKNLN5eb8luhG+SbOMqtv
	fsxMnTdgwXtDqP+4=; b=vlSvvuhlkDIg4iklapAy8To1khgxUPdjuGzUB8hVL86
	bSO7qFSgINKvnTDdYaUOAkhLzgmcuLLeEQYUPtXoj09LQbIZSxqAA54Qb0wjveWW
	tETOXzYnaKGtfR0XXUSW0/DyGiuD20eK32/47pr5yS2eFljdckVSmZSmkYA5ZrQ1
	AJAtsvlvf6GFK47Hzpx7oibGWQOSWm4qV+POaN9AWJaFbkp0fW6hmslBvtBC6udd
	WwQPTAVSLjOrqNdxyrzsGFu+w4ueAT++Hw/wVOX/ErrPjtUC3839erXlLFqlL8eP
	tPFuuRBFvcYcAsuIIEzDCk7iqOZrPEGlCJtI2nUcHYA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011024.outbound.protection.outlook.com [40.93.13.24])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 461qdn8bp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 09:43:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqOzPRpuJopYGR+R3GnZe1OZGPlsbvSOyvu1Yj0soW0B9m2RD3heKEbTmA9bswY5M22yf1EhMHL+2afYG596F2Et5fORe8WQk6/tguqC61LhNaYyc6J16zmWCtSi2Cl5YgIuCbM2+FWI99g5SPRpMhPk+OqNmLLur+ZW5FTIgMcJlGMuK/GsODD4eXUUGolcVaJasaAAa/qFmQTZY4MAANZGkmkDTal+0hka6I3Iey/Z6mbM/Y8W6jRyNoY4cJhv2s/UGJJtyo5tHskOimvi41z3pySczWHLhrWHSsJqFxt4aEUuCqBhgUI32NwXfto6KaIwyZGH02zzPqskl/0p7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZIr0YUKNLN5eb8luhG+SbOMqtvfsxMnTdgwXtDqP+4=;
 b=xqEF3gEtCX5DoA4iD/VzukyXaQ3sPJ3aupz1AkdpeYK4uWpYfp9hTwfYcZT9MlZx8Ul4sh2tkHMt9UjQm/THB8fknhTXqelz9hkemYRZkFVCGx7YsAhIPX/QPJgdJtnJR0ULZqOkkw8y0d4sk/T9+9F3xL7fe77blPL2r01qq/rO6StWwLOuEzV7ENouDk7NRzGlpYPHAat/O86CTrM7x4p7WK44AEelBOAkEcXresZYLoG+Vj015JRVy0HBLzLLPUf0/jjDVCPXhjLNqVxOB/H4nGkSEUCtypez4dimwsCBB44baJ1C3Vd4m4PYs3A3JwUbHijGjI3rugpWk5C4FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZIr0YUKNLN5eb8luhG+SbOMqtvfsxMnTdgwXtDqP+4=;
 b=WXL48mhUowtQ5LTgSxMECmKodzT/kII64UhT79ZzVTN4lOqTx6SP6i2/n1xcVY7RM0nEx8slETXk3XSoDk1Hxg7Nmj39D2D0QJBZmrwkavQGntiMD4r0bwDX21npEogE5dvVBrJ5F13+2FFdIQrAkOOsY8n0M84rmSKldPjvbdnP5z0r1JouZwGSBZdqUdtgrCRzj17ID12ptSoT17RUNU9gB3ohge6bYdTrdjdKJ1DTHdrogabvF2DjVgdxfFE+qtHRyxkJF2kKzPwh/vyJGY1ynjP258Ihes18MV5LCFnPupo8Exut2UVJHKhnqVhqzUX+xg4VFNnZ0KCl2jMjmw==
Received: from SJ0PR13CA0172.namprd13.prod.outlook.com (2603:10b6:a03:2c7::27)
 by DM8PR04MB8133.namprd04.prod.outlook.com (2603:10b6:8:c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.35; Tue, 15 Apr 2025 14:43:21 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::36) by SJ0PR13CA0172.outlook.office365.com
 (2603:10b6:a03:2c7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.13 via Frontend Transport; Tue,
 15 Apr 2025 14:43:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:43:21 +0000
Received: from OLAWPA-EXMB13.ad.garmin.com (10.5.144.17) by cv1wpa-edge1
 (10.60.4.254) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 09:43:19 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 OLAWPA-EXMB13.ad.garmin.com (10.5.144.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.34; Tue, 15 Apr 2025 09:43:20 -0500
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 CV1WPA-EXMB1.ad.garmin.com (10.5.144.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Apr 2025 09:43:20 -0500
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Apr 2025 09:43:19 -0500
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel
	<idosch@nvidia.com>, <bridge@lists.linux-foundation.org>,
        Joseph Huang
	<Joseph.Huang@garmin.com>,
        Joseph Huang <joseph.huang.2024@gmail.com>
Subject: [Patch v4 iproute2-next 0/2] Add mdb offload failure notification
Date: Tue, 15 Apr 2025 10:43:04 -0400
Message-ID: <20250415144306.908154-1-Joseph.Huang@garmin.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DM8PR04MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 60980881-baf0-49e9-fd33-08dd7c2bde74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RLKmW2AG7cY7VAk47HLDJb1kEXHdq2elzYhqVqfy9NqiNCcR1qGAWJ9UQmAJ?=
 =?us-ascii?Q?4I8xUC7WekeQjMK/AMGdA15nvlgO6VA8NhZ/Tl84MDAD8p27h1uFzTrHunDO?=
 =?us-ascii?Q?I1oHjbHMuC+puHSTos3cH9ZxxNJ2VTD4IdaajNJoSl0fhtvBZCFVg4lAKUPB?=
 =?us-ascii?Q?Yu5YBWE3w9uaehaJ6pEYhlql5XVDqxxsb9UfZGM6qJWA6T8xDHnsL86lJeG+?=
 =?us-ascii?Q?Pme9BXFiJeQ87qIJnV+AowFZUZLVUhLy7DhzptrIcVUCn4lq8wRqf8Pduq2a?=
 =?us-ascii?Q?r/44FpOHCsj4VmmYJNyUcJ+Hexk97ZC4R6F6gm6qTLjCyLEWtwf621u4CGMt?=
 =?us-ascii?Q?NU/H4jRQhkfRk7etGq0Q+s8PE+JpYBIjvELJIk+bnpbfHAK2bErxjkCvsZwk?=
 =?us-ascii?Q?pxTmYWvgXEKqlRQWc6Fn20tyT6HexsCcwYpUJL7HbyCBLelOo39VYAvjq/J0?=
 =?us-ascii?Q?znc4TcSUmpnQrO9b+UE2sy4uYxYHc+abKOJwoKZxNyhxVXcYsY9mEA1Mt6wl?=
 =?us-ascii?Q?g7TclGObkS+mCY7Y58Z/6TkHIdMAlK//SFIHB/xkzR5KLGYn4beJNInlxOqW?=
 =?us-ascii?Q?CwMEStAGkisjujCtlHdn2uO9KtSlJTMrbBjV8FIQFPjCOnCGSF6WfLbvhfJp?=
 =?us-ascii?Q?Dp73WHuXbIrpdnxYS+yVkd9urgkS8huq95FHUSRA/7IJI+gUMCjT3daqWuEz?=
 =?us-ascii?Q?DGjB1x0jGLRSQEBqUQrwwlnmcQH40r7JFOmuV3H24gT741nQSbA0Q9ZZOc90?=
 =?us-ascii?Q?c8pCWS7kSHDBlOQTb0y+r75zXQ9I5Jy5jLzsiZv8nnh2mxExH4nMrU/WFE/9?=
 =?us-ascii?Q?/5jIHZbIJadfllFk/c0spDx8ijoq+24oKEM69uZkuOPk11hVGj7OHCj/vvwt?=
 =?us-ascii?Q?qYWmbKhbQ4xU8H7TtQ3csafN6STXn2uBNHLW+tDJJe2CFC+5cZrtOOmz4ENJ?=
 =?us-ascii?Q?ig41f69O2Ldrv33wZR+UmgJ7eGrA9p2sYvGkL2NkHFcC+vYa6yuRQ6RAiUt1?=
 =?us-ascii?Q?/XtVXlngM4sXvv0iqlCcnrHDjSgMVtkgwjIQdMo36jdxDUDop1Z/a35e+uSb?=
 =?us-ascii?Q?pe+jGI8q8I59fQZLP4DLxRPK5M7b5v/onpswyKZk5nNMZVl/eVnIkdmWTtvE?=
 =?us-ascii?Q?xdP8FRU0uWYPW4zSkK1uviin+ecfA7EK/aVArYw/hpFrNvP2Hji7EB1ZFBZR?=
 =?us-ascii?Q?K5/U+YSZyMAQd4Ga/cuCjYUcemxjzqKKGMxnoz6ONb19fEGNAqWtddvd+H25?=
 =?us-ascii?Q?YChl95gipyTq8wVtYvEavJkZvT7fc33VqsSnPN59v7noxdg/lTDZG4smrQMX?=
 =?us-ascii?Q?m4tx2ZijLxxet2BxMTPjesdtABz6ZR+VKj/C0TsNVdM6Wap7KNnu9a61RcJx?=
 =?us-ascii?Q?s4UyR1M9idj9K7HEWpvl3toIX86EhTwcoUytQ73IgrDAOFZVu9dF0c4Xz+uA?=
 =?us-ascii?Q?oO5xysLqGgvNLFPRuhRfA9kGfhGf02D+pSaaqdOVzxUB0uijK8tL5CL2Vk8M?=
 =?us-ascii?Q?rel9g/+Oay0JWxNmP1/c0JU/V49XugJdP+BHE/pqEqZTHV/WsgjayL+Hfg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:43:21.2719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60980881-baf0-49e9-fd33-08dd7c2bde74
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8133
X-Authority-Analysis: v=2.4 cv=Qo1e3Uyd c=1 sm=1 tr=0 ts=67fe708d cx=c_pps a=pibkrh05mLzxjy7FsoIMmA==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=XR8D0OoHHMoA:10
 a=qm69fr9Wx_0A:10 a=VwQbUJbxAAAA:8 a=NbHB2C0EAAAA:8 a=UPSVwTS7QtnOhxq7XrYA:9 cc=ntf
X-Proofpoint-GUID: D7yL-MflgaCVOml2wPCSGXHpE0dOImDh
X-Proofpoint-ORIG-GUID: D7yL-MflgaCVOml2wPCSGXHpE0dOImDh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=939
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504150104

Add support to handle mdb offload failure notifications.

Kernel commits:
e846fb5e7c52 ("net: bridge: mcast: Add offload failed mdb flag")
9fbe1e3e61c2 ("net: bridge: Add offload_fail_notification bopt")

The link to kernel changes:
https://lore.kernel.org/netdev/20250411150323.1117797-1-Joseph.Huang@garmin.com/

Joseph Huang (2):
  bridge: mdb: Support offload failed flag
  iplink_bridge: Add mdb_offload_fail_notification

 bridge/mdb.c          |  2 ++
 ip/iplink_bridge.c    | 19 +++++++++++++++++++
 man/man8/ip-link.8.in |  9 +++++++++
 3 files changed, 30 insertions(+)

---
v1: https://lore.kernel.org/netdev/20250318225026.145501-1-Joseph.Huang@garmin.com/
v2: https://lore.kernel.org/netdev/20250403235452.1534269-1-Joseph.Huang@garmin.com/
    Change multi-valued option mdb_notify_on_flag_change to bool option
    mdb_offload_fail_notification
v3: https://lore.kernel.org/netdev/20250404215328.1843239-1-Joseph.Huang@garmin.com/
    Patch 2/2 Use strcmp instead of matches
v4: Drop RFC status
    Patch 2/2 Change to reverse christmas tree declaration
    Patch 2/2 Add mdb_offload_fail_notification default

-- 
2.49.0


