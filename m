Return-Path: <netdev+bounces-195785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C8BAD2366
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 18:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51213B1252
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D56219302;
	Mon,  9 Jun 2025 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mvzt0tpn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BFB2163BD
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485285; cv=fail; b=bMgB1IfZWoK5kAcuiDJUGIKoLaP9PvtbV+cgiF3BKTJ2+W6wVZ69s4H4weNjm5xWoXaG0R+CN2nQYZki9qfs+JgfggCocafR7w/n4boYMuTdLBKTGHWAGdgbTCRYB3h+Nd7+MeHQMZp6BxZdzVqI8wxl67aweKZoqDb4MwPK4M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485285; c=relaxed/simple;
	bh=Nve/WBJ8EbXu93xwie9BN8DpJfT2U5JtRtzzvWUHp9k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+qFVXYOQKrtFMoELXImuulPZUsmO2ZgpWe2zjmJERKGjRTQkFsRa3MNcpn8yvFgixD4sq4FO5ih56UD4bDQ+GYNXpAkw/LqwnlOVicDnR66/W4WQkvXD28LvAH1xwTNrtZM632ZlKBA7r5AYug31+9lVHv/Bc80c4G3AbgroZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mvzt0tpn; arc=fail smtp.client-ip=40.107.212.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+Xp7iDEhg85Lzw4gxOfY0BUygEK/LkrK37zX9nfaNBQx3nurf4erL2kTmPE82WhW+uJlBDZDL/ls01tmxyZ0TOOd5f62n5kmnjnk2dqg+3D/cF2USMn4CKzDPXFHlAwwa259m8gzdxfYaczKm9KPL1ahHvv1OOOPRaQPRxWd06ulMjzUHqvkObf4cm6yTIu+Pfan5BBf8Sn1XnLPI+aTh/vlZl/Q1/4NGDILO+dwCz69vtVd2Q0F0pPkheZzYFo3qpc9d+2t88CeNYoNSxs2ffKW5vxnh8lWJBdzSvBIQoWytbPvd2MLHmdm974O2RgkvUJC7zKN83Nywv2bxUtBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9wzbLAa8sQVa+tCUoL5p71GQ9mPjEnuQ/DJuWbJhKI=;
 b=vM4A2/fcbU8XGboc3OA2tZTwS1ER65RXURPckgMqxJbeS/3dVlROpZltdcbBJ8s+cXdTkPKiDbyOd3+C3JGMfI9W6uVYwdNjqF0EqEQeG1cIQCkQCWTcTkTK6vONdWAJj2Te4q7fxvbTRnuwrRRkAI3d7yNuMOZwk0dK+0rIaVz6aj+a4+ScMXTPPehabFG1Vd1shzxLZ0un365A83+9T6BVD54OgaKbxZeal4CeBso08SAUhWqow5Kyt1RLDHkLwVC/c+7F88vlR29php9JoxSD/310pi2+k8vQ7mqnatfQrHdehPZ5rmd58FAjt1jAITLdIvoLAANUkKgmTEoQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9wzbLAa8sQVa+tCUoL5p71GQ9mPjEnuQ/DJuWbJhKI=;
 b=mvzt0tpnUeVMFVATCDVlBTIwzHy6/9gxZ8YlAjCepl+KRkBMW1dkzzCFar9NlbjYa3yRyWDFDkQWtJ19AWj+73qn0R4T51yjE0GoaDCCQMip43AbCfOhzP5VS04HP9klC3X2BmA3aRcQdIUMxoGDfDhiPSbgyMRnwT13cDEjm7VLjoxeBnm5f9a8Or1cds//4gaawrGsakLYbt2mK6UQGoKiSVjQ/cgWBCun6e0tRsBp6B1hLqXtXUuqOqoHDtbDWczWO3Nm7cTkeDIHjLz/oOmZFQIUNP6G2J8pZvBs9dasPFqb9r7oRP4FyOIpVibMNP208IVoj5Lq2ZagwUCLeQ==
Received: from PH8PR07CA0020.namprd07.prod.outlook.com (2603:10b6:510:2cd::12)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 16:07:58 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::3c) by PH8PR07CA0020.outlook.office365.com
 (2603:10b6:510:2cd::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 16:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 16:07:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 09:07:42 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 09:07:38 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux-foundation.org>, Petr Machata
	<petrm@nvidia.com>
Subject: [PATCH iproute2-next v2 1/4] ip: ipstats: Iterate all xstats attributes
Date: Mon, 9 Jun 2025 18:05:09 +0200
Message-ID: <e8834ec759b3e7f94545fe07a219ca592e84e402.1749484902.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749484902.git.petrm@nvidia.com>
References: <cover.1749484902.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f203dcd-f097-4763-ec76-08dda76fcd6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/HvQY5t0TonJw9aME52lPkgaJQPg0MswoZPSRLDdxVbP1Vh1k6foLaNy5/H0?=
 =?us-ascii?Q?2SHBiz+PU35QuHtkUH10pudbMwKVG7KUvMWPZ8GiBWCM9MElmDV57pntco0Q?=
 =?us-ascii?Q?zG/+ukfK2umhayTuce0fOERtY9cniOI67k9sxBnhOXghvz2Ur/bh6OoH0VjW?=
 =?us-ascii?Q?4ZjXguMSTZVwQgBhI8MDXc4SYBwaDfYNOYALTb/zh3crBVMuflRRW3pqrRWm?=
 =?us-ascii?Q?WQsFObAg86xNMRVmIGtjnvQyIkyypIYBkzS4fZXzsUqHrjwVgYj5jU0SRKc0?=
 =?us-ascii?Q?n9B3v4M/ppBOtP0OwgAn5SdGs4MhbUNan/Xv5S3qyp02CxD0CaekmU+3aDSX?=
 =?us-ascii?Q?yPdSXrXOEGio7vhAWIiQI6QpdS4bGCStk/DqJYYyE/n2vMZbu2uKWHMl4zMy?=
 =?us-ascii?Q?8rEVr3LGWJVjZvr57z2/S29h7osTioV7fHiv8/rrO7ExANHi4oxW5Efk2k9u?=
 =?us-ascii?Q?o39e80SS6sLfEqxeVMqRYwekra11Lsz+McGWas7PrA0TzkpJ5NaYVkDY1nK2?=
 =?us-ascii?Q?PeGFPE+ryo8AFQ2WziAEr+Wk+b0N7htOJJM6Hlt/idIxXCBJbgM2GxyMvwA4?=
 =?us-ascii?Q?p6Ny5ot41HDDkTX3GUXnVPJ6hhLdlGb5UHZwdphp62o4uYEel3DbCHRQqd6q?=
 =?us-ascii?Q?2fu7UTZQCyc9PSbe7PCzxt6X2vb4BdwHt246qMMVEUxeqNjAu6jckM30/wcA?=
 =?us-ascii?Q?sCGNloQq4vuXfgozXtemE7FurJS5NAEK2/rEE1WWLdCnOEelxTd0g4R6yFCa?=
 =?us-ascii?Q?oDr/WqjML69DNBLelbImsftZ3/sfOlKjTbCwDDyNTqTxpXXmRbhxukPemZH3?=
 =?us-ascii?Q?5RzUayiFFou0KThufz+Bd6B1S1ma05zklpsgbU2kNZ4ziNJ+2Rl9zSf3jZBx?=
 =?us-ascii?Q?zk4UBfeuMW4RT8MHxymomd8JjPnReJUsN9cBM60skoZyrH2vwfaE/b7S0X0H?=
 =?us-ascii?Q?tlTWI6GQrjQFwJjs1e1XRGo763tY1jaEdN0thLNPmX6ZyJdoG/0TDvwM4VWf?=
 =?us-ascii?Q?3p5eydoHVTShgyg3UogzGeTkH45dgKtF5l95YvTw0eqSqv4rhWh6GyLiOAwo?=
 =?us-ascii?Q?xUVVO6BhekayhcwMBTcQNak45gfmMTwQkX+dllofjnSLy/RCMJloUThH3UYh?=
 =?us-ascii?Q?d/xGwc+dx1G4MXW9pd+rGbsHfwpHYIvfbt9Y2QG4aMsoMZ2ShSAbhimEx9Fn?=
 =?us-ascii?Q?dFLkH95kVQWZ6lOIwhyaW0/UTh+nx28g6lgfVPccvzdDNGHvBezNMo8/wNtB?=
 =?us-ascii?Q?fcoGmhTHjtdqVQyF6Qa57fB51ioy4pNoZePabkDtYfCU++KpAX6aEvelybVF?=
 =?us-ascii?Q?70cckMjnUcSdNYH5XEAtathik8oDrysTESLSwj2WICoj37r3F+2l8l5H+2nP?=
 =?us-ascii?Q?3487a5T+KX2oiUJj7BIdDYdXgw/shLv4MT9LlYJrlF/FyJe/QgmkP5l2LKUM?=
 =?us-ascii?Q?oLtPF6sobrx2ekCvPFVRiUcxEIDCg4GnfKSD4cBlQ5Rk9zn/hSxhilLtUTeo?=
 =?us-ascii?Q?+G+YAjS6fZCuR6Yl5Y38/lhp/C36XC0PYBaJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:07:58.5227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f203dcd-f097-4763-ec76-08dda76fcd6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317

ipstats_stat_desc_show_xstats() operates by first parsing the attribute
stream into a type-indexed table, and then accessing the right attribute.
But bridge VLAN stats are given as several BRIDGE_XSTATS_VLAN attributes,
one per VLAN. With the above approach to parsing, only one of these
attributes would be shown. Instead, iterate the stream of attributes and
call the show_cb for each one with a matching type.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    - Use rtattr_for_each_nested
    - Drop #include <alloca.h>, it's not used anymore

 ip/ipstats.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/ip/ipstats.c b/ip/ipstats.c
index cb9d9cbb..f0f8dcdc 100644
--- a/ip/ipstats.c
+++ b/ip/ipstats.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-#include <alloca.h>
 #include <assert.h>
 #include <errno.h>
 #include <stdio.h>
@@ -590,7 +589,7 @@ int ipstats_stat_desc_show_xstats(struct ipstats_stat_show_attrs *attrs,
 {
 	struct ipstats_stat_desc_xstats *xdesc;
 	const struct rtattr *at;
-	struct rtattr **tb;
+	const struct rtattr *i;
 	int err;
 
 	xdesc = container_of(desc, struct ipstats_stat_desc_xstats, desc);
@@ -600,15 +599,13 @@ int ipstats_stat_desc_show_xstats(struct ipstats_stat_show_attrs *attrs,
 	if (at == NULL)
 		return err;
 
-	tb = alloca(sizeof(*tb) * (xdesc->inner_max + 1));
-	err = parse_rtattr_nested(tb, xdesc->inner_max, at);
-	if (err != 0)
-		return err;
-
-	if (tb[xdesc->inner_at] != NULL) {
-		print_nl();
-		xdesc->show_cb(tb[xdesc->inner_at]);
+	rtattr_for_each_nested(i, at) {
+		if (i->rta_type == xdesc->inner_at) {
+			print_nl();
+			xdesc->show_cb(i);
+		}
 	}
+
 	return 0;
 }
 
-- 
2.49.0


