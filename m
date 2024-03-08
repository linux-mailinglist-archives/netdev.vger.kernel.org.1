Return-Path: <netdev+bounces-78740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 806298764AA
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D72B1F226FC
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AFE32C89;
	Fri,  8 Mar 2024 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YwhudCvY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D9CEEA9
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902997; cv=fail; b=pZkF+rclRrDhhGSyEoUH13tXBrffQcGHpKU4ZwvVuTruoAGDViOFR5zrJxe2FW67M4BRBkIRL3q5uf7CxaT3MzJ9ItYxiTAOVxv5neRUfgAQdMPVMswD7uxKWhPCUM23A1wtpvqM11aFQyQGH9V8YSVaWJtc4lU4K05zGHmLBoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902997; c=relaxed/simple;
	bh=o0HQpejV6Ud33l8KxdW3qqcnd81FoKqPLOpz7GcXyIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ec0rqgBp38f7zotk5svZ6+X9Ww+UtHxYkifWJaoa4uFBojQZFzTbvTjEnBWl2wBJnMv6Y3zt4lHWH89OkKQurB+HKNr2O6bXQG7iZnPxwKkRbaDqoOVMQJj9ClYHB0yAF8usXuoQin6CGDix9/oekfCQoPXz6GNmNyRZ9ij6FEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YwhudCvY; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyvFlDzCZ1ni1EIQ2U7iXVum6t4p0BpRUGx/Xb+LT6nfofbJPBPpQOdSswJG2IQzua1Vn23RfoIIuqRvEX69H7/zuiQZXWgwtX5W7+3+K64IXG/pUH+FrtWTQ9OO1GePKsqO/S3rPxEEqkfCMDSrxCyI+H8gCCOwzTGIg2jH7mQFVxxXUqRSHoPI6eBQyhWGIa7CH0PDWjh2JFAQQLx7kHFv54iP8IVj2VO/Us5Ec5YK/nv7INNbuTVgKEZZJeLBqTVqT8tTtog/eUep5jH5Nox6BZo0xxynVkPoBRUGMLFBJibXC3op4e9jSjR6haxhZ/aAsocucbqEDpNQC58Udg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32HlKym3Vt7mqKQp0qasWHD1Qz0h7xDlXB7CKvRnRjc=;
 b=aDohMusss7lDVNne7mDQ+qQLcOzjCRKDv6b5apzC6vJiiYEY+i8ToZArN4py7nyxngVJ1WdKopnl/Y86F7StGNlyLNSXuZJ7MVhgChSoB43x6hvaq8+/SKC4Kz/8NEEZiSpRhv4vC2mkL0E4oX4Tq5f75iE6kzuTQpatGQnZiLkDW/X+PHvfBHLzr0Hk9LRY2/8Gsz5Empwu7KkQ5h5tBXwl8aad8DXQKt+I2oUmylA8RAYfi34OHPn1eAfeKCHcGSzl008Hv6kY6pXiNmUh1nkfRecdNxLqhCPLVZxu94eaTRgaMtRGYQoEzNVxXqx+LqUcTYwETAFajkrRPQJ84w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32HlKym3Vt7mqKQp0qasWHD1Qz0h7xDlXB7CKvRnRjc=;
 b=YwhudCvYkSTzjR8xSiomfdMzEmRmjHMuLNlvJIhZE84m5XkGvy9nO1Bha6fejiNu8+R0tNX+0lgObnBCwOL/uCmfFFfYqJ1oDdWaWbX/pWXpG5sJWcygSTPE5Zg+K4Y9hS1Xp4n3kcovtMa4QfUeWL0+xb+eNI8PMrRDNEp/43q3sJCLoN5JT8XKA7q4vFxsz6tiJgaPzIm+PYV/foOs44gxznCSLgR6p+K+2gBRJdtKqGj+xwiaWRvnyfznRjcQ3U93JTVLPCDKIDpbRfof3oU/6x+Fba4awCANkR3khqEFrMoM9gIqtrY/Nk8U3gpGSE/wMdA8uxDKLZVtYmKAPQ==
Received: from DM6PR07CA0063.namprd07.prod.outlook.com (2603:10b6:5:74::40) by
 MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28; Fri, 8 Mar
 2024 13:03:10 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:74:cafe::8b) by DM6PR07CA0063.outlook.office365.com
 (2603:10b6:5:74::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Fri, 8 Mar 2024 13:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 13:03:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 05:02:55 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 8 Mar
 2024 05:02:51 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 08/11] mlxsw: spectrum_router: Track NH ID's of group members
Date: Fri, 8 Mar 2024 13:59:52 +0100
Message-ID: <184ceb6b154e08f5bcf116a705b0fcb01c31895c.1709901020.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709901020.git.petrm@nvidia.com>
References: <cover.1709901020.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: ec251411-b011-4e7f-00ca-08dc3f701b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DV3eng/NtUa33E4QGaaWyAa81s4zDKz2FdkqigQ1mT+QBmtz7JuXlZbqzDjJ7U+eFfyFitNYJRd6eVqNyIjYl0QEZrMaRW7lutgsvlr91+mYvRGLMICyJtIZE0LH5IKhK9Q7JomxOo8h1JATQicqczCCc+/TkwDirfn+bivXr3K40/DC+EsQp5QSlDS9IvhZY0AS7RS+0kS6wes+YnvDKfDKmwkBdaGPqVGWQLJbBbORmEqmka9aWuZIEiJ6lzcHa7JGfl+rhJqiLHXjxa+SKu6jPW0+FPNlb8VUqo4sqi1fyW9SdOmfTpfEZxYpuE+5+XrM1EEyIDWNy9KsPNCzyGugLEFTX/yfZEkhtpO9NakxB7Of6KtJNmg/jr9mWeRRtbMidqoYr/gtu8QBwAS9me0KVYvYDtij3PHLVZWKV5IGE+a3p6JNXHsUh81eJ3SQ/5wqOVfo7TEoHxpxjkvPxuS2tEu1Bstk57t7oGFOOEDll0ZxSwdFKEGlYEMgSHTxZXi5DKeFF+Cfn359wIog9aF71PVeURUYcU1QfJtxsXRx83/C6MRPHlxE6qCmkTmj0Y8k5KySwtDzL3xXC78zTDvYIDo8hlzSbx0Eq5IRcmoIQBfoDET6aPxGUgLW6P8ZdTAX4ZavFXB7IqUaZCeJBo9xnxJl/Rd5ip+5PmX2hziSAaqdHCbagd/haI4FAmENGD8O7hXQUF4v1ZYz6HojMxxP29c3/e08dpTZ8BwFRf3fwFqjacEwT6JII7ZyDT66
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:03:10.3878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec251411-b011-4e7f-00ca-08dc3f701b3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359

The core interfaces for collecting per-NH statistics are built around
nexthops even for resilient groups. Because mlxsw models each bucket as a
nexthop, the core next hop that a given bucket contributes to needs to be
looked up. In order to be able to match the two up, we need to track
nexthop ID for members of group nexthop objects. For simplicity, do it for
all nexthop objects, not just group members.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 73a16c328252..922dcd9c0b5a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -3083,6 +3083,7 @@ struct mlxsw_sp_nexthop {
 		struct mlxsw_sp_ipip_entry *ipip_entry;
 	};
 	struct mlxsw_sp_nexthop_counter *counter;
+	u32 id;		/* NH ID for members of a NH object group. */
 };
 
 static struct net_device *
@@ -5054,6 +5055,7 @@ mlxsw_sp_nexthop_obj_init(struct mlxsw_sp *mlxsw_sp,
 	mlxsw_sp_nexthop_counter_enable(mlxsw_sp, nh);
 	list_add_tail(&nh->router_list_node, &mlxsw_sp->router->nexthop_list);
 	nh->ifindex = dev->ifindex;
+	nh->id = nh_obj->id;
 
 	err = mlxsw_sp_nexthop_type_init(mlxsw_sp, nh, dev);
 	if (err)
-- 
2.43.0


