Return-Path: <netdev+bounces-174176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C1FA5DC07
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 12:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B257F3B2E63
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 11:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0751F23F39C;
	Wed, 12 Mar 2025 11:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2tDYPL9Z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F4C1EB1A9;
	Wed, 12 Mar 2025 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780451; cv=fail; b=eO6ut2lG8wZFxwUeUsMnz0yFrclsAbtNIqhccWEEkv94cHkSGT+7dIo4cY04zBhxe+pZ+a2rnNI+y0CITnxq6sxbgzBk2Tbd0h/BEoXVkHJKE9lXJuSDsPvFwVp8Cz5pCiF8Aspn7soDWtGNrczKgn72zCr5YinG9wcLFAdiXh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780451; c=relaxed/simple;
	bh=C9BTXGa1NMNQWVE45QxXldp7F75GGYI5H3grYil2TY8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qrt03HX835+7yo3gZRjZ4M14dwV8te7LsIwzksuYlbXCkNmBahybeblSXh2Phxyvq1JSBHM91qQwIvcrrs8ek+g+uPtLGYW+qXzkWg/kuGXEIf3m1NnSoYFGpRRpblXvFaivFeMwfglipto1sYf8AQPmFStqJWN4kFh2sd3GJrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2tDYPL9Z; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJkcb5L9ebUyv9ngKqKwZgNm/OmosmJoxL+66NSclU6xJV0jPc3vhJLUOKVT++sJsUhoajoLExfnZjvPQx9ODL1CJEwiqn2Qidb7L3jKY+EyBxmm4542SRDYD6E8TnkUXAD2qJpM6sak6iOqfWGi2EQUmBqkPLKIK4D7tqCPAihD43OW03js10w65JsulhM6qZ5+l21EiTnI7T4Mxnu0lPnKemTd9CMHSsqybTB9zWQYwiEI+4BMpVCbwZFQQJ0zj0Jqi+pfBE4zI/kHrd94LvfNAPrfuXaB+i3jD9Xq4bO+bhE4ywxgw7dUbyRCrcKZX6dpfVnnC3NaNvDv+/Jm0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBU2kpZttIhfDDQV2zzlj/tA1LRVg14m8E1uPEj3PGM=;
 b=pd94s27ycvhj9ZiFvL/adsPuN2ZgswYGvpsMBHE/5H7d6urszPKxHCVfZ+ruscQ3WXyx7WFutS545HIpczARM9kKxNcA95t6L95plHZShEQ6G6GcT8Yi8FkaXKWigvhOmDgJTrz6bRxUWYlrxE5BH2kCZqNSrnDP2CFgZkuJa+/YsNYu9DFAMqVT3h3m6AYJKzu2qzCOx9pF7J5/PW8tt9f0FmU7tDfAIvqdA9/1vvoJwqtLbNnaNfuj8Fd03uhAnkabFeWeP3W0DeZG8hhIZGjWJan/4gWAWpzAPuZeaPQuJHp0/PNlF8kf3bjnkMHbNqOX7IPKft5fnRRquVn4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBU2kpZttIhfDDQV2zzlj/tA1LRVg14m8E1uPEj3PGM=;
 b=2tDYPL9ZaXYUp4N4gI084sdeoIbVPdiJb04Pe/CB9PyfLTN52GFGTctaMiEImrNSmIR0KSECFBBZ9BA4vJEQHzBFu2ImFjI183s5rpY1FfZahdsCI2macHvBG/4k7xBgGEQR62kBT4TcEhsaMm5kO7Ri5KjWZ+eB24ltr6aTrWQ=
Received: from DS7PR05CA0061.namprd05.prod.outlook.com (2603:10b6:8:57::15) by
 DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Wed, 12 Mar 2025 11:54:07 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::c0) by DS7PR05CA0061.outlook.office365.com
 (2603:10b6:8:57::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.23 via Frontend Transport; Wed,
 12 Mar 2025 11:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 11:54:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 06:54:05 -0500
Received: from xhdsneeli41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 12 Mar 2025 06:54:01 -0500
From: Radharapu Rakesh <rakesh.radharapu@amd.com>
To: <git@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<kuniyu@amazon.com>, <bigeasy@linutronix.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rakesh.radharapu@amd.com>, <harini.katakam@amd.com>,
	<radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>
Subject: [RFC PATCH net-next] net: Modify CSUM capability check for USO
Date: Wed, 12 Mar 2025 17:24:00 +0530
Message-ID: <20250312115400.773516-1-rakesh.radharapu@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: rakesh.radharapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|DM6PR12MB4092:EE_
X-MS-Office365-Filtering-Correlation-Id: 19fca9f5-1160-4001-61ee-08dd615c97b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+YGpjUfWt5A8eRf0SwhsoyDYVTuvONHqJ74iCfFByq7rAXJkME1ihwEhYGgQ?=
 =?us-ascii?Q?VtbYFtbVEN0iM+bJOPd7y/O0p0kHizKizIuq8Vphw57SWT0OgidIpdU3Xgiv?=
 =?us-ascii?Q?2bpqijBHEcDtwe4mbbkNKam597Gu/DtAQwpYFwfna6Nx5KwGT391uuPMy4QH?=
 =?us-ascii?Q?I04pRm82d7CAmHismWeD3WX49MYcuz7PYqKHDRXIJInp+DQIE6Hc4lbMJZu+?=
 =?us-ascii?Q?4qhAU7DlzRqthI3KA7hbeN8AtQ7sZ6k8qCUMAbadQsrWQli51lSJqVmVbtIW?=
 =?us-ascii?Q?TZUOZGyd+i23mCA3m55pTyW0Sd3eQkS45rzqxP5cjN3/klX6wsuzWVlsABkP?=
 =?us-ascii?Q?KkMdW6fPuTweB/Yu1DI/w+4bgGIvzzV8WIAK2F0zo2cOxdr9pkRSvsOlNtLM?=
 =?us-ascii?Q?7kRnqxFjOZdmSWMLkNfxivYOcCQyCdOd/fnCh5ri6cBDbdU0tPDQatzzr++q?=
 =?us-ascii?Q?HOcmryJCGEbiC4MNn66lf1Y+CdxB561OAwvcv0SfRy0ozrEDIYkK9dPlABu9?=
 =?us-ascii?Q?yQxPRWwA4KH1nsZs+RSPmtlYrx2M1dW3iYEem0Jq7Igq7aCaLaU8BE/fONHk?=
 =?us-ascii?Q?2G4mFfC6QvtrzhBK5o7+Nqz6YhsxslUYLs7pNlhvFcz+irV91F4YOwqCPx+j?=
 =?us-ascii?Q?vf/QT6FxtjWSTirxQFSTeu7gbhOm0a4g4qCYWV6xl+0jFlcbP6qI9dq7bDuc?=
 =?us-ascii?Q?84QP90VTRftLTiVWh4c1JS53ixjKbw5AFWUizJNaw/1D+Y0w0GH6HJAYJlZI?=
 =?us-ascii?Q?PF10fiv8eBRjYxrdXLCKqbA/Y7mQ6qZB7w6RrMDHVo/M/iDq9SiJuZVqITOi?=
 =?us-ascii?Q?Zh3UiqIaSE52tS3KNTMkAvoXTLngHJjfkFQSzcIhkScKF5Hx1v5bw/mvhVGq?=
 =?us-ascii?Q?wzp2L45h4dQXXetEpu8SpxseOO5+J0ynmEqEYVTwlPfHKFUjaE3a4mfd7TjL?=
 =?us-ascii?Q?JZpwA3q5BnkAehjDcv7sHsFNZX3Nlf23Il+fDRVVN5wmHX+fnr5n/Qjokyvx?=
 =?us-ascii?Q?CKiKR+11ervJZ+nnv1iOoLyZiucWv5zlFRo+X29GtQWojUXMs2xxvvk+qQlo?=
 =?us-ascii?Q?KLO7TxMFwfPATVD/F71an9RwqXr0XVO4rOXgWSE9IFPoq63hVldUOkHEO5YC?=
 =?us-ascii?Q?w+7GfZGNlOxvwr4w6HE/b1EYlLAGCWQM4/qO4ktSWC21f5U1M6b13Tl1RpDr?=
 =?us-ascii?Q?xDtQpaqt+PHmIuOGjb85k4hTa0hFPTgVDR+zI30C8tyV7XS+uVBLWen2qWCy?=
 =?us-ascii?Q?sppssc0X4jnHaT5VxwMdud5g/qeVh0esfa5OPu28Ku3Dw6S+Semp0h1GCGd9?=
 =?us-ascii?Q?0Wt4qw6L2CDxUTQB224begF/aAl3KVI679j0YCPskcQlYaM0BNavILQlrG2C?=
 =?us-ascii?Q?Pe/A+xf4IgfUZaX7cL64U2EDlfsOm3Rsg/8mMd41XyKgMWOgfRa6Rya+3PPD?=
 =?us-ascii?Q?V9buk8zI8ywvE6fvERxxoupsWm5bS0Z15xU1xMSout6zBY+OG0MSvDJBEv0p?=
 =?us-ascii?Q?3FBCYsJJGQTs41k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:54:06.5672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fca9f5-1160-4001-61ee-08dd615c97b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092

Some devices supporting USO have only ipv4 checksum enabled,
but USO gets disabled because both ipv4 and ipv6 functionality is checked.

IPv4 or IPv6 or both checksums, can be utilized with UDP segmentation
offload. Separate checks for both IPv4 and IPv6 checksums.

Fixes: 2b2bc3bab158 ("net: Make USO depend on CSUM offload")
Signed-off-by: Radharapu Rakesh <rakesh.radharapu@amd.com>
---
 net/core/dev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1cb134ff7327..a22f8f6e2ed1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10465,11 +10465,13 @@ static void netdev_sync_lower_features(struct net_device *upper,
 
 static bool netdev_has_ip_or_hw_csum(netdev_features_t features)
 {
-	netdev_features_t ip_csum_mask = NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
-	bool ip_csum = (features & ip_csum_mask) == ip_csum_mask;
+	netdev_features_t ipv4_csum_mask = NETIF_F_IP_CSUM;
+	netdev_features_t ipv6_csum_mask = NETIF_F_IPV6_CSUM;
+	bool ipv4_csum = (features & ipv4_csum_mask) == ipv4_csum_mask;
+	bool ipv6_csum = (features & ipv6_csum_mask) == ipv6_csum_mask;
 	bool hw_csum = features & NETIF_F_HW_CSUM;
 
-	return ip_csum || hw_csum;
+	return ipv4_csum || ipv6_csum || hw_csum;
 }
 
 static netdev_features_t netdev_fix_features(struct net_device *dev,
-- 
2.34.1


