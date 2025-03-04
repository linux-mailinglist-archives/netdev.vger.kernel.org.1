Return-Path: <netdev+bounces-171864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16D6A4F2B0
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A64167FB0
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 00:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE6F17579;
	Wed,  5 Mar 2025 00:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="dakqotYP";
	dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b="LYcWUPUo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E093DC147;
	Wed,  5 Mar 2025 00:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741134466; cv=fail; b=Xp0W2c7sB6Cca/ZETmhGuDWTEib8OisQwQbXPWwynRE5Rk1VRBi0WRmYnxTqyfFQfr4vlZpINeeFV9Hmk/ktZFtMY7k09Iydizh2YDde5Tlv6ICsO5J67f25Zzu1E2JuVHn3/qSlcsn34w3z8VehqjKYiAl4fNz58/X3iTJU9hY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741134466; c=relaxed/simple;
	bh=9LoredqN/yM+api3M4G1jZ7VWtWja6t6OfoNx2acQkk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TLegDhME7eM+TU1uznlZ9j6pvcdJfqVjNvglt6IscGPYRw+lYo485DVdlD720AStr+tLGvJqRyNN8ba2lOLOEVhfHcZxvFCCD9yIkhCBoviegLeTEvZSdLDAQKSXz4MtG935fo4h3ivuYfWQPpso2/RLy4fkW87r1PO8TGNXYas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com; spf=pass smtp.mailfrom=garmin.com; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=dakqotYP; dkim=pass (2048-bit key) header.d=garmin.com header.i=@garmin.com header.b=LYcWUPUo; arc=fail smtp.client-ip=205.220.177.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=garmin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garmin.com
Received: from pps.filterd (m0220298.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524MqtvE029237;
	Tue, 4 Mar 2025 17:54:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=kiZAlbfbYKG3hA3GlO58qzlGzyC
	bIaFeUzO2rTJ3Z4g=; b=dakqotYPCX4DSa1stqWERC1+Ocdt5t69fZUX2SbhcWf
	zOK2DazvscZxBDfJgbuTPq1wIT3iBdILWAp2qReaFrx3uSy/3QRr4v1RJ7hHbzeJ
	YthPM9ngFnqhQQn+1G6oCDNiS0jpWZV8jHL0F7PlD4KVYuCMGcOabBCja2lBxvkZ
	j/XvJZ1xhm6Z0pcYURgETxzwxjpUtNr4RcPbEIbvoASHy/8fmaV2/1GMkaPxbPHv
	gGVyVWnk0nAtIUa51XPhBlcUNfYxe0cnyd/kbG9k1NT2cJ1e49mSAnh2DAN6Gbny
	bX1HLtUV5l3tjQ3QNcr9GyEDwyBuB1AmpGp+CWRQw0A==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 456aq182r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:54:26 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daz0S/PT4iPlbVFqn0tJQ0pV5VT1qt5JO2uh8Q2wLik/Lx1wkMICXUo0l+N3vkU7Rq85XKbxRYfBPR2whJFp8wX2Zs+IzHXyu6APMU6yE6GvW0sqwYxyHZKH+jIjeWmOt2tbkJ6hfT2yNUfkXVZiRc2QCGujca445YFrqqXG/U1C3I1G2gtpdGvcfIf5nl3rYeWNe9FlzFw0kE2R/7GCLVAkO7NEnBtQj1YDriID/Q6Nw9RlPquSrKB3HfNUAiy5lWpTpNhjlGR/MFRysBWwaDLdw0ND3JyvN4h+xPN+P+CCvBKtPtYGE9T/oe0NFxdMzwrzTaXboBUZmhsJU0aMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiZAlbfbYKG3hA3GlO58qzlGzyCbIaFeUzO2rTJ3Z4g=;
 b=LWugrajwHV+X02wS6Lb2M2n9W6HOgouj8fKT3NUU7gZebos49lRrW96WIEJeqhNvh29qM0Z6GGN/MckW+slN/LPIKjUYKW1Ql+218tocJKb9oYk0CldgVR4CF91CSosTZ2XXl04BR93oEBeOHf4IVPN6EoV8vP2pQc8ar3eKC4uoQtEeG9AlpBAFXa84D/2WYYGsFbH+6Qd8Yo51fxESygvcVBj0ne4BevSeLBW+mYm0PNgzPr2Ak7lbkFUmXCyPHN4iwJz9V590LUKyEVJF4mwmjlvzfi8BhgjWACKXHOLQqTrFoHo/zIiGcoz4YhwADKwLqxM3o55ZEMbDVTtsxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=garmin.com;
 dmarc=pass (p=reject sp=quarantine pct=100) action=none
 header.from=garmin.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiZAlbfbYKG3hA3GlO58qzlGzyCbIaFeUzO2rTJ3Z4g=;
 b=LYcWUPUoUMPThe2GTkha5rIz2EPBCgedG+HZfDa6FJZqcEZ7tOvMUFdQyEa6veOkkpZgCG0+BmHLcEFXMbHmYR5JmcXxzfBG/Ltv0PWfCZb0Q9QzsWce5TrEyOP9oWrN71aFVvK3wSbW+eCxpt4xMMptPoamNb7kWaIW6gDuuZ3dPcU+1VuHt9JvVcyHVCXJ9sMCuGNkUG0Rd/bxb42k1jBNMglwG+41c8pyfnesnfAKBvYDq+3vouh3wL8ZqeKRJ59ZGYEJ6tAxwPrHOesmCg6yRdZjprAPPSLlbTS0Susojey6e9QL7qjYcJ6s13KsmrY0Gbf8RCZlOzxOySvaTA==
Received: from BY5PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:1d0::20)
 by DS1PR04MB9582.namprd04.prod.outlook.com (2603:10b6:8:21c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 23:54:23 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::5c) by BY5PR04CA0010.outlook.office365.com
 (2603:10b6:a03:1d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Tue,
 4 Mar 2025 23:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com; pr=C
Received: from edgetransport.garmin.com (204.77.163.244) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 23:54:22 +0000
Received: from OLAWPA-EXMB13.ad.garmin.com (10.5.144.17) by cv1wpa-edge1
 (10.60.4.255) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Mar 2025
 17:54:17 -0600
Received: from cv1wpa-exmb4.ad.garmin.com (10.5.144.74) by
 OLAWPA-EXMB13.ad.garmin.com (10.5.144.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.34; Tue, 4 Mar 2025 17:54:19 -0600
Received: from cv1wpa-exmb3.ad.garmin.com (10.5.144.73) by
 CV1WPA-EXMB4.ad.garmin.com (10.5.144.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Mar 2025 17:54:19 -0600
Received: from CAR-4RCMR33.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.73) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Mar 2025 17:54:18 -0600
From: Joseph Huang <Joseph.Huang@garmin.com>
To: <netdev@vger.kernel.org>
CC: Joseph Huang <Joseph.Huang@garmin.com>,
        Joseph Huang
	<joseph.huang.2024@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
	<olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: dsa: mv88e6xxx: Verify after ATU Load ops
Date: Tue, 4 Mar 2025 18:53:51 -0500
Message-ID: <20250304235352.3259613-1-Joseph.Huang@garmin.com>
X-Mailer: git-send-email 2.48.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DS1PR04MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: 302345e9-81db-4968-c18e-08dd5b77e31d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bBhDcwpt2hNFlyqsvSbAvDkHlQySSUjbiO4CTFOEMIDGL6C0r2nyuzamQQxr?=
 =?us-ascii?Q?aoILsxzRwnYG0qLCyrYG407NPW7ZLLyiK56BXnacG9wbbmrD+8znq+lzPVEA?=
 =?us-ascii?Q?DAGqGUy6TSVJrAQ1YTfhz4Cdw2uUYB9M9PZsjrjl2/2dxQdwNxtx9B5LxMxZ?=
 =?us-ascii?Q?yi3TiXrGG3Ci4sgI6IX2fKut5gepBRUI31TNF6ihoMsHUW4uRdzuZl60zngr?=
 =?us-ascii?Q?amDOFBrNkm10x7jtwSoVi7VTLBgx3TwQN6GwRMcC5379rReDxcQu9oGeiLFS?=
 =?us-ascii?Q?aRG4yVMsbD/3AEJwSuYeE5QYm3wfkSlDu/w7oNkM0fLI5Jf6GqHHfkicceh2?=
 =?us-ascii?Q?AidiI1KksUvjhqfHDe3GTscDaNtnCVcJ6qjKOepGG9Uw/BotSARtK8uKydH+?=
 =?us-ascii?Q?zqYzFIS8QdCDqjGxcVTZKnDN5IAAXYdgLZbo2MKOnxvUUBfKQxArbxcJMygo?=
 =?us-ascii?Q?SjJnoW195hu1bRezDVviN7KdXdVfvEzHW9KRfKHwZSKcK9pliqM+Pz+83Cje?=
 =?us-ascii?Q?DVw0EAcvqiYfVNklyT++92DbZBoVZyELpeBJBH7hd0vh/AO78haXXy8hrTu7?=
 =?us-ascii?Q?blkV6Rx1hrn0rpwC+Zip6RR4aS1pqxifhSTudwNfhL3+2zchyUnYCXANWSU6?=
 =?us-ascii?Q?dyy8yrHGCswgU+CbXybZAZ4RPFs84G9e5kOGz4GkIUFLY2sgmBbOV4kBRLq4?=
 =?us-ascii?Q?XBi/IMdP11cLMWETFXBPO+NJ9+UT+r5qHd2UN5TZNFIqGT8VvACvYXRM4SMD?=
 =?us-ascii?Q?1WgfZi022b3KV3uUZTSRju8psElfsgtEXScnx3us0emHquGeMTdUHUhI8Jsw?=
 =?us-ascii?Q?4jgdMD8pl0ZRzjCjoHHcrma/My9OZ7QI5frQ8/3PxKocE50RMdJFVfdq1j0g?=
 =?us-ascii?Q?s6Ot6xTmuRp+Clm1yRSqWMQp+V6Hs31hn9qHax0qSK3Hw9W+7kMWqhfqPwUd?=
 =?us-ascii?Q?omdAT3dhWN5kj6viClB7e50irpu2zAPnmijENZ2DgiZcL+ccbhRFeWX9spVA?=
 =?us-ascii?Q?vdIKsJdMWY18RArZ3Pt3JbRaQUA+33z1RxGsJ3xr4qr3MKF6SptNUfMNN2PU?=
 =?us-ascii?Q?SXaZdXCjC/mKtnv4tTlAtguROb5gesBeg5QLKJhV3bA21nBIhDlK2ZpSwOCC?=
 =?us-ascii?Q?/NysEFlu3WT++ejVRhoYGioN+O1I2ZhPPLnmsFdcFeFeCBb6Qm9xGYzCBJMz?=
 =?us-ascii?Q?/oQdlG+9nMrA3R7d1D3bFzUAeEjg/xNUymV7z7ahpFq91cioUFTxVasQrhid?=
 =?us-ascii?Q?ljCnSU1cYy3c+mNFQOJO9jPzawVHgtT6LGI9pPHb82E+2uNvrRsnRqhtmPFC?=
 =?us-ascii?Q?O5MvsOSA596b1ctDoXTM9QK486b6Lu6wGxK3N0DfOzD2yXuiga6rEsZ1KMWi?=
 =?us-ascii?Q?ey3KGxzyuVr06of3lkIziQQ1AGPTJJl0otWjukBHQLb6YDsnCZfOWIi6r88h?=
 =?us-ascii?Q?iFqkwOPsgdegAD28HtKy/TcDdbnsknqJVnQ++PhZc/mmtiQhjgBfgTZMlk/D?=
 =?us-ascii?Q?S01FIqQIydo5ALA=3D?=
X-Forefront-Antispam-Report:
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 23:54:22.4373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 302345e9-81db-4968-c18e-08dd5b77e31d
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9582
X-Authority-Analysis: v=2.4 cv=MJqamNZl c=1 sm=1 tr=0 ts=67c792b2 cx=c_pps a=19NZlzvm9lyiwlsJLkNFGw==:117 a=YA0UzX50FYCGjWi3QxTvkg==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Vs1iUdzkB0EA:10
 a=qm69fr9Wx_0A:10 a=NbHB2C0EAAAA:8 a=5W78l-RZOY_RarYDCcQA:9 cc=ntf
X-Proofpoint-GUID: pV_1lCaK_18xifZhuMvebeKVEUNIDxLg
X-Proofpoint-ORIG-GUID: pV_1lCaK_18xifZhuMvebeKVEUNIDxLg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_09,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 mlxlogscore=818 spamscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=notification
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503040191

ATU Load operations could fail silently if there's not enough space
on the device to hold the new entry.

Do a Read-After-Write verification after each fdb/mdb add operation
to make sure that the operation was really successful, and return
-ENOSPC otherwise.

Fixes: defb05b9b9b4 ("net: dsa: mv88e6xxx: Add support for fdb_add, fdb_del, and fdb_getnext")
Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 52 +++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 68d1e891752b..cb3c4ebc5534 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2208,9 +2208,20 @@ mv88e6xxx_port_vlan_prepare(struct dsa_switch *ds, int port,
 	return err;
 }
 
+static int mv88e6xxx_port_db_get(struct mv88e6xxx_chip *chip,
+				 struct mv88e6xxx_atu_entry *entry,
+				 u16 fid, const unsigned char *addr)
+{
+	entry->state = 0;
+	ether_addr_copy(entry->mac, addr);
+	eth_addr_dec(entry->mac);
+
+	return mv88e6xxx_g1_atu_getnext(chip, fid, entry);
+}
+
 static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
 					const unsigned char *addr, u16 vid,
-					u8 state)
+					u8 state, bool verify)
 {
 	struct mv88e6xxx_atu_entry entry;
 	struct mv88e6xxx_vtu_entry vlan;
@@ -2238,11 +2249,7 @@ static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
 		fid = vlan.fid;
 	}
 
-	entry.state = 0;
-	ether_addr_copy(entry.mac, addr);
-	eth_addr_dec(entry.mac);
-
-	err = mv88e6xxx_g1_atu_getnext(chip, fid, &entry);
+	err = mv88e6xxx_port_db_get(chip, &entry, fid, addr);
 	if (err)
 		return err;
 
@@ -2266,7 +2273,20 @@ static int mv88e6xxx_port_db_load_purge(struct mv88e6xxx_chip *chip, int port,
 		entry.state = state;
 	}
 
-	return mv88e6xxx_g1_atu_loadpurge(chip, fid, &entry);
+	err = mv88e6xxx_g1_atu_loadpurge(chip, fid, &entry);
+	if (err)
+		return err;
+
+	if (!!state && verify) {
+		err = mv88e6xxx_port_db_get(chip, &entry, fid, addr);
+		if (err)
+			return err;
+
+		if (!entry.state || !ether_addr_equal(entry.mac, addr))
+			return -ENOSPC;
+	}
+
+	return 0;
 }
 
 static int mv88e6xxx_policy_apply(struct mv88e6xxx_chip *chip, int port,
@@ -2298,7 +2318,7 @@ static int mv88e6xxx_policy_apply(struct mv88e6xxx_chip *chip, int port,
 			return -EOPNOTSUPP;
 
 		err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid,
-						   state);
+						   state, false);
 		if (err)
 			return err;
 		break;
@@ -2487,7 +2507,8 @@ static int mv88e6xxx_port_add_broadcast(struct mv88e6xxx_chip *chip, int port,
 
 	eth_broadcast_addr(broadcast);
 
-	return mv88e6xxx_port_db_load_purge(chip, port, broadcast, vid, state);
+	return mv88e6xxx_port_db_load_purge(chip, port, broadcast, vid, state,
+					    false);
 }
 
 static int mv88e6xxx_broadcast_setup(struct mv88e6xxx_chip *chip, u16 vid)
@@ -2539,7 +2560,7 @@ mv88e6xxx_port_broadcast_sync_vlan(struct mv88e6xxx_chip *chip,
 	eth_broadcast_addr(broadcast);
 
 	return mv88e6xxx_port_db_load_purge(chip, ctx->port, broadcast,
-					    vlan->vid, state);
+					    vlan->vid, state, false);
 }
 
 static int mv88e6xxx_port_broadcast_sync(struct mv88e6xxx_chip *chip, int port,
@@ -2845,7 +2866,8 @@ static int mv88e6xxx_port_fdb_add(struct dsa_switch *ds, int port,
 
 	mv88e6xxx_reg_lock(chip);
 	err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid,
-					   MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC);
+					   MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC,
+					   true);
 	mv88e6xxx_reg_unlock(chip);
 
 	return err;
@@ -2859,7 +2881,7 @@ static int mv88e6xxx_port_fdb_del(struct dsa_switch *ds, int port,
 	int err;
 
 	mv88e6xxx_reg_lock(chip);
-	err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid, 0);
+	err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid, 0, false);
 	mv88e6xxx_reg_unlock(chip);
 
 	return err;
@@ -6613,7 +6635,8 @@ static int mv88e6xxx_port_mdb_add(struct dsa_switch *ds, int port,
 
 	mv88e6xxx_reg_lock(chip);
 	err = mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid,
-					   MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC);
+					   MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC,
+					   true);
 	mv88e6xxx_reg_unlock(chip);
 
 	return err;
@@ -6627,7 +6650,8 @@ static int mv88e6xxx_port_mdb_del(struct dsa_switch *ds, int port,
 	int err;
 
 	mv88e6xxx_reg_lock(chip);
-	err = mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid, 0);
+	err = mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid, 0,
+					   false);
 	mv88e6xxx_reg_unlock(chip);
 
 	return err;
-- 
2.48.1


