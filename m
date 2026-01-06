Return-Path: <netdev+bounces-247395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C04CF973B
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 17:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D01D3004E21
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFFA30FF30;
	Tue,  6 Jan 2026 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qZwFLVFZ"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D26A2DEA86
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718270; cv=fail; b=Je8Rsl1IgjDzfYrOjbdmmKGWynT/UW55mxRE667cgtLz81WqaKYNxwTr/0AoQBr/RLKGh+9QQ9P7HIwYlUWClIrjmkZPM3ksC+7GJiPCsWBu9jGpyXUYRlBrOIRSjLmmwrUO1GiQ45LiMMyIZM8pFwOm/83cLScf29hs4w5ie28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718270; c=relaxed/simple;
	bh=WddeZocBJYhHmoLIXO3IeqVJ779usXn4H5lIvc0WpWY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eUCRbaI/cQ7SRKaXRxNTy5zDvXZ8ADd3I6KcZM6Eetef4AQDGWXrpdWNfKmhn5TX4t2YMassadXdtWy1E54Hx8xZsJZvgd4NCRw9nIDWRHdnxx79o8LmmEMz5Tr/2WR/RAd+VtgC9WIMESSFOq5m4s3fGteT0u0DgCBQDnth8b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qZwFLVFZ; arc=fail smtp.client-ip=52.101.193.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsmWibpyAsScRcfL/FINwCm8AMmWKyVZLOR0LloZbTtNZpLk11X9E25zRbX/NQgZqLfrQhlbCeoF7eqxLqYHql8Z6kfjRlev+VUwlBpmTnqjf4bQPgBuq1RFYPnUU/lytwDhH7SDj3sEXHZiy5TbpQqFkNZMNmmyYhYMgljCtoX9nMNNH/PADfrfDs25EBre9mMzkDR6p4ZQd9Mt7SkTlkch8Leu25Gafta5bRD+C+oRuzyYLQL7/64RBD2QyvDBNc2SUfoQ2cq8YfcPaLjkzbFufr0F4wJ5Xk0PAl9hW5MLynUoXH6rm+NRoTHm0HG6oV4rO4YoLTJGWWepys/akA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CXiHCGFRDnDMX+gqtJXFNCvaVXgmYLcEuuicValy74=;
 b=pzh45Sphe9KR2n5O3eAQY07qSqB7K3UBQ1N6zE0hRD4kb/dHBgqwjbP0IDwvuuxMCewK+K0Qv3Y+hWI8mdsrfuK6KucVDw3lL4Eay8SFAJEhj5cBWogmUYsQU6TnJZOuULrR4eCL8A+IWwlqHxXzRAHHuaMusoX8fA6mN1Pky7kAJiPKQrdKCdLoCFI2jH/a0nUIUgN0GOi2x7nnnl/Lfmo9LWZGAXd8NfuG5COIc9+pRjcxJfBcDKPDg1RcWQUAvtS6Myu4XMBNfmmcM4pcH7ikO+4ojxWe0TSw84sLkw13gtw3iFLObLH2fHQrIoG8ggkzkwk12JYgR6QprEYvKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CXiHCGFRDnDMX+gqtJXFNCvaVXgmYLcEuuicValy74=;
 b=qZwFLVFZj+Afh/1lw6s+aXMZhYY4b5UVB/ruIaJ1wFCe0qCHqfzsUr5crMq13sVPHo2RvP2lpIJBj4T99XN96VveEz1XxmrIK9F0F6W1Oux/pDLgKYRCir2Z3sKDw/gejHLhH9FhOco7Hc1qrtxosV9h+ltFaA/zDZh+Tbe/1cCT6r8Wc9S5zs6F1+GyT+y/bvPnyqL6Kh8eCFrbS+sh1ImHvKx9wgeB5xRNGdJxh9n3dZxts+sU41ld3QFZgBtGJ5hfnpENXynBAEdfRHSdWZSZg6ZBTcB5lUhQALE2E4mWuvrQ6L8+pGVaZFy/3/o+wQckSE2PVa8tsymW+AjQow==
Received: from BLAPR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:36e::25)
 by BN7PPFB3F5C406F.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 16:51:00 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::d3) by BLAPR05CA0023.outlook.office365.com
 (2603:10b6:208:36e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Tue, 6
 Jan 2026 16:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 16:51:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:50:40 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:50:39 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 6 Jan
 2026 08:50:38 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v14 00/12] virtio_net: Add ethtool flow rules support
Date: Tue, 6 Jan 2026 10:50:18 -0600
Message-ID: <20260106165030.45726-1-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|BN7PPFB3F5C406F:EE_
X-MS-Office365-Filtering-Correlation-Id: 214f4103-560e-4fa3-d9c4-08de4d43c57b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HY/5h2XigqIx7nn1AoDE/JwZH82CkKj7QcajI8MbFblYBoyM+IF7itbwcqvd?=
 =?us-ascii?Q?p9xc5UqMdQFLXT6kEb0gDHkStnRjJFcqKTSWqkP2i646uXjJz8xXodlZU5Go?=
 =?us-ascii?Q?N+wpLwyeWTPSYGVWw/IjXnsgIVrQS/g9HkMK8dSANn7w50/cWXXvv1TXde+r?=
 =?us-ascii?Q?d8C8AmMB8vt9yUn3VK/9WF1FfvnqNjGHzTO1QFClzbZjfGhM1i2q9Zv4J4rB?=
 =?us-ascii?Q?tLzaf2Ermhu/UQEghi6j7U+Ec+jOew5bV5WUSereufxhZ0BwKScY4gAXdwkf?=
 =?us-ascii?Q?jzTToemxGUn6+dVsMIsoeNfuMdnK3n7FpuH3sbFMtlh6BMeDyIZzMPfebKRp?=
 =?us-ascii?Q?Iyki7AIJdJiNeiEdi+SakdSAYFu4keaXYYTNrnnPgZCoHh57+SPBof0VSWtK?=
 =?us-ascii?Q?ZoU+50ikBCQ51GXVxABxlmpyLEfOvHlsYrqXz0yLLaokvHuXfAvBIRjSuRwN?=
 =?us-ascii?Q?yxRAtTcNBZCOPYuFYK5ogyqcwViKupyItseuPVOr76YkMn6JXJvD2sVfqAkV?=
 =?us-ascii?Q?sFpHrfog51OsZ3bl5QPi5BArohAKL0fhnDm3rz1zxc5CLqYg/KMH0aDrrhU3?=
 =?us-ascii?Q?K+BdIOFQrg9lfyO7yugMtCL0Z1pCZd4uJ7mn9Gh/bmWWhqblSLQM9gXxOkKV?=
 =?us-ascii?Q?SsjglgKD6p7NZ02tYuaYzMPWdDGCuT5IAGcy0jvVVvn4/mUcuBdMvTlfXX0g?=
 =?us-ascii?Q?2UZ3f23gzAsh2/tmkWsdwtEPe1BFkSuNi38fWHYjg3hHnXywbWH92dIW6mjW?=
 =?us-ascii?Q?g5pMUuX8qfu/R4DmqiFgHuXgcSBxPqq3dnQVCCH8QufSyEZrimpIq6AwvelE?=
 =?us-ascii?Q?BLsREnMQTpR4mb4qD6fC5EulQgIAx8qlgjunm2NN3Vz8RMLAhGYG7Uriyp/M?=
 =?us-ascii?Q?Ve6HwFZyWLCoaXNNak6p2gl/euEkRx9cNojXYEUVp50LDpH/pMNCSS9IIj2N?=
 =?us-ascii?Q?d5PunVxqaeJVyhXJ5ZpMb/I6ZuPl6MS7lxnham6QTdRYs9Ja4Emc1D6y5Cz9?=
 =?us-ascii?Q?uqtWuUCUuLBjKVUXqi/JD8rZ9WxMYQEkVPSW00KtYLV3XwLSO7WLMdpwRkMC?=
 =?us-ascii?Q?cAoFdVvE51yIhkgPG0MnbD6LxfeaMB9W1A4UsNqgwKb6xFoJUVqNyMBZC1lm?=
 =?us-ascii?Q?iI2gxx0W7czNYfzSc/RRBDUhtJp4Tm2VnlKi0Oejv3itnWZZQWQRpEA0r4mt?=
 =?us-ascii?Q?ZWTnb+9/7hv46ZGtYcNe27OG/IYdbxWlQ/qsncG9yOGcyBRgdpeM1Q9J+4cs?=
 =?us-ascii?Q?03h33dAP9c8D4QWfZK5O7MnX0Qaicwf+4KhxA2DqCUt91I+Dqu/3yOJpX/Mx?=
 =?us-ascii?Q?y/zXVyw3OhbQ2VywD9SAbQSzJQ8Lc9J3qsxdLU3cwv0120zNHK2P7iKpqW9N?=
 =?us-ascii?Q?ZlF8lyOw35xru8VArZlFXX1x7eq2NLWHp/LrPhpN8Qba+5O6nmLJBAocKcFW?=
 =?us-ascii?Q?aHaC1Y/spA0/Wktj/x9e5duKM3S7c9MOKmwosLRBFAzdeMyS/kk7O3GtzF7F?=
 =?us-ascii?Q?MEObCuQIRWEQlvDImgcsgwGcx0OUhU8ALGhylH9THBHHCcslnAcqQwJ3Fufl?=
 =?us-ascii?Q?vC0QVhaSgTt8e1z3dTo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 16:51:00.2837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 214f4103-560e-4fa3-d9c4-08de4d43c57b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFB3F5C406F

This series implements ethtool flow rules support for virtio_net using the
virtio flow filter (FF) specification. The implementation allows users to
configure packet filtering rules through ethtool commands, directing
packets to specific receive queues, or dropping them based on various
header fields.

The series starts with infrastructure changes to expose virtio PCI admin
capabilities and object management APIs. It then creates the virtio_net
directory structure and implements the flow filter functionality with support
for:

- Layer 2 (Ethernet) flow rules
- IPv4 and IPv6 flow rules  
- TCP and UDP flow rules (both IPv4 and IPv6)
- Rule querying and management operations

Setting, deleting and viewing flow filters, -1 action is drop, positive
integers steer to that RQ:

$ ethtool -u ens9
4 RX rings available
Total 0 rules

$ ethtool -U ens9 flow-type ether src 1c:34:da:4a:33:dd action 0
Added rule with ID 0
$ ethtool -U ens9 flow-type udp4 dst-port 5001 action 3
Added rule with ID 1
$ ethtool -U ens9 flow-type tcp6 src-ip fc00::2 dst-port 5001 action 2
Added rule with ID 2
$ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action 1
Added rule with ID 3
$ ethtool -U ens9 flow-type ip6 dst-ip fc00::1 action -1
Added rule with ID 4
$ ethtool -U ens9 flow-type ip6 src-ip fc00::2 action -1
Added rule with ID 5
$ ethtool -U ens9 delete 4
$ ethtool -u ens9
4 RX rings available
Total 5 rules

Filter: 0
        Flow Type: Raw Ethernet
        Src MAC addr: 1C:34:DA:4A:33:DD mask: 00:00:00:00:00:00
        Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
        Ethertype: 0x0 mask: 0xFFFF
        Action: Direct to queue 0

Filter: 1
        Rule Type: UDP over IPv4
        Src IP addr: 0.0.0.0 mask: 255.255.255.255
        Dest IP addr: 0.0.0.0 mask: 255.255.255.255
        TOS: 0x0 mask: 0xff
        Src port: 0 mask: 0xffff
        Dest port: 5001 mask: 0x0
        Action: Direct to queue 3

Filter: 2
        Rule Type: TCP over IPv6
        Src IP addr: fc00::2 mask: ::
        Dest IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
        Traffic Class: 0x0 mask: 0xff
        Src port: 0 mask: 0xffff
        Dest port: 5001 mask: 0x0
        Action: Direct to queue 2

Filter: 3
        Rule Type: Raw IPv4
        Src IP addr: 192.168.51.101 mask: 0.0.0.0
        Dest IP addr: 0.0.0.0 mask: 255.255.255.255
        TOS: 0x0 mask: 0xff
        Protocol: 0 mask: 0xff
        L4 bytes: 0x0 mask: 0xffffffff
        Action: Direct to queue 1

Filter: 5
        Rule Type: Raw IPv6
        Src IP addr: fc00::2 mask: ::
        Dest IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
        Traffic Class: 0x0 mask: 0xff
        Protocol: 0 mask: 0xff
        L4 bytes: 0x0 mask: 0xffffffff
        Action: Drop

---
v2: https://lore.kernel.org/netdev/20250908164046.25051-1-danielj@nvidia.com/
  - Fix sparse warnings
  - Fix memory leak on subsequent failure to allocate
  - Fix some Typos

v3: https://lore.kernel.org/netdev/20250923141920.283862-1-danielj@nvidia.com/
  - Added admin_ops to virtio_device kdoc.

v4:
  - Fixed double free bug inserting flows
  - Fixed incorrect protocol field check parsing ip4 headers.
  - (u8 *) changed to (void *)
  - Added kdoc comments to UAPI changes.
  - No longer split up virtio_net.c
  - Added config op to execute admin commands.
      - virtio_pci assigns vp_modern_admin_cmd_exec to this callback.
  - Moved admin command API to new core file virtio_admin_commands.c

v5: 
  - Fixed compile error
  - Fixed static analysis warning on () after macro
  - Added missing fields to kdoc comments
  - Aligned parameter name between prototype and kdoc

v6:
  - Fix sparse warning "array of flexible structures" Jakub K/Simon H
  - Use new variable and validate ff_mask_size before set_cap. MST

v7:
  - Change virtnet_ff_init to return a value. Allow -EOPNOTSUPP. Xuan
  - Set ff->ff_{caps, mask, actions} NULL in error path. Paolo Abini
  - Move for (int i removal hung back a patch. Paolo Abini

v8
  - Removed unused num_classifiers. Jason Wang
  - Use real_ff_mask_size when setting the selector caps. Jason Wang

v9:
  - Set err to -ENOMEM after alloc failures in virtnet_ff_init. Simon H

v10:
  - Return -EOPNOTSUPP in virnet_ff_init before allocing any memory.
    Jason Wang/Paolo Abeni

v11:
  - Return -EINVAL if any resource limit is 0. Simon Horman
  - Ensure we don't overrun alloced space of ff->ff_mask by moving the
    real_ff_mask_size > ff_mask_size check into the loop. Simon Horman

v12: Many comments by MST, thanks Michael. Only the most significant
     listed here:
  - Fixed leak of key in build_and_insert.
  - Fixed setting ethhdr proto for IPv6.
  - Added 2 byte pad to struct virtio_net_ff_cap_data.
  - Use and set rule_cnt when querying all flows.
  - Cleanup and reinit in freeze/restore path.

v13:
  - Add private comment for reserved field in kdoc. Jakub
  - Serveral comments from MST details in patches. Most significant:
	- Fixed bug in ip4, check l3_mask vs mask when setting addrs.
	- Changed ff_mask cap checking to not break on expanded
	  selector types
	- Changed virtio_admin_obj_destroy to return void.
	- Check tos field for ip4.
	- Don't accept tclass field for ip6.
	- If ip6 only flow check that l4_proto isn't set.

v14:
  - Handle virtio_ff_init errors in freeze/restore. MST
  - Don't set proto in parse_ip4/6. The casted struct may not have that
    field, and the proto field was set explicitly anyway. Simon H/AI.

Daniel Jurgens (12):
  virtio_pci: Remove supported_cap size build assert
  virtio: Add config_op for admin commands
  virtio: Expose generic device capability operations
  virtio: Expose object create and destroy API
  virtio_net: Query and set flow filter caps
  virtio_net: Create a FF group for ethtool steering
  virtio_net: Implement layer 2 ethtool flow rules
  virtio_net: Use existing classifier if possible
  virtio_net: Implement IPv4 ethtool flow rules
  virtio_net: Add support for IPv6 ethtool steering
  virtio_net: Add support for TCP and UDP ethtool rules
  virtio_net: Add get ethtool flow rules ops

 drivers/net/virtio_net.c               | 1219 ++++++++++++++++++++++++
 drivers/virtio/Makefile                |    2 +-
 drivers/virtio/virtio_admin_commands.c |  171 ++++
 drivers/virtio/virtio_pci_common.h     |    1 -
 drivers/virtio/virtio_pci_modern.c     |   10 +-
 include/linux/virtio_admin.h           |  121 +++
 include/linux/virtio_config.h          |    6 +
 include/uapi/linux/virtio_net_ff.h     |  154 +++
 include/uapi/linux/virtio_pci.h        |    6 +-
 9 files changed, 1679 insertions(+), 11 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h
 create mode 100644 include/uapi/linux/virtio_net_ff.h

-- 
2.50.1


