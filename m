Return-Path: <netdev+bounces-256469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A3BJRZ3gmm+UwMAu9opvQ
	(envelope-from <netdev+bounces-256469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:30:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 169FCDF466
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AEAA30BA48E
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 22:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4441374187;
	Tue,  3 Feb 2026 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oqrraPX9"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E606376BD5
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157776; cv=fail; b=Ho3zRjylxH/4KoAIAZiPtoXyQvocfcq4e0N32vk/IpmW37NgDi+lozuWilr3hLLNCJgYTWuXttWKfqTdNnp5ysusZnfYcSEP3EKl27HYMvXXAJcLGB6zkdeNGiJme4AE+OuYmIKTUGL/NCijQE7hxVJarGgbEiyxr59cPyJd3Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157776; c=relaxed/simple;
	bh=t2FrcKiaN++GEbf6PPdtMeEU3iJH+lARm9vGC8IeWSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvruJNVetxe8w21I47mAvMXc13pyXx0IDVzLOxCu+C2E/muv+D8zStGJdQOKI11Nj2NAvJmdLVFhfplr+osdC2vHAAyPPrdx48Of0dgkwIfPT6392T+gRYb8/AXsxoYGcso+rSdOaFhzBNQu4FBSr4POTpKf8brpLFAvlhAoyUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oqrraPX9; arc=fail smtp.client-ip=52.101.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGRWb8MKo55JNvRHnLtoqOQYOg13WDCoA+WYJy4TQhS3pqx9R9nHz4KNhOd9orZshrursJMAvmXJciB6wnfxBvjVJNmW49weBoA3cfddFtPSzKPTfVQT+1beBvEM4+ia5JdA8M8bmJz00xY8pV0D038S9fdl6YUWYWPsHA2oCXDHO+BwBshBcg7CnmpmqjB4e5VonO6kBEFcS15eKOOslHeAgFcMwqYyYksrJF64t10Qvzm8kXM4zI983V569/6wwFf509f2ojCG7897vpHif7mlXxt5kBfmFd5kyJkSo7KqscIT1rCt3jhpb1HfHo8wfQr7OMt2LpyBpWxhdi35nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZ6edECz8/dpTF0Eojo0yum0MLTBqqVtUjhW1lhrxUA=;
 b=aNH9qE47id6iP2++hjN/yklA98p353mu2omI9/83ntqXhxbWZ4LpdcwA/51nYC3bB2W4jcyXi3937PyOKDO44yVbvWhcHafRyT4yT+eoKZhTS0KQeHhuhY32B13/pqfcjLpVh6Iw7CeACSJC7YTuwzebCS/ur8oq9qhFSFT4N9I/l2pY//higHwcW0bvRwO3dLJ7u4GnzcOC/170BE+9ZACJZ+1nxXXa1RNf//8xvu53mJsbwtugmiqYE3yX2jVB4pHQ6+2/kiVDnMrvUBQEvhk4B/0KDU2EwddWr0lAWBrRYdcvrZzuaStmrx7/KFFGGeEWL9xalgsWnyZPSt9myQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZ6edECz8/dpTF0Eojo0yum0MLTBqqVtUjhW1lhrxUA=;
 b=oqrraPX9opSV8kc0IZ7Qg8IFRiLmql5wZz9nesR7HYoG3fWAvv8/jEdmh9n0c8rosCEa8WMxS/qs5ojkRk/hvuux2G+Akt6LnqPk6x7qt62SF7HS+N4pYfnTNrRUbNUIj8oRcdXl/ebzDquQUOzDzbFQ8Kb/idlHOHmQUhUyOiJnysiLRiuvEXdESZFeK5JCIo+JoSjlRRshN1Ib1F/khVfe2kReHGk3d+I3tCgfkSINNevCBMOJr743+f1h8kgtSwo9sPO4NSpR3zgj2EfAyx9Dy5Im0giXAQx/Ki1IU6AFENi1/9ujfcLeBSh4ADKgCFujlwaYF3G3NDCbO9JbIw==
Received: from CH2PR08CA0022.namprd08.prod.outlook.com (2603:10b6:610:5a::32)
 by DS4PR12MB9586.namprd12.prod.outlook.com (2603:10b6:8:27e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Tue, 3 Feb
 2026 22:29:28 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::ae) by CH2PR08CA0022.outlook.office365.com
 (2603:10b6:610:5a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 22:29:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 22:29:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 14:29:09 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 3 Feb 2026 14:29:08 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 14:29:07 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v18 03/12] virtio: Expose generic device capability operations
Date: Tue, 3 Feb 2026 16:28:50 -0600
Message-ID: <20260203222859.4219-4-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260203222859.4219-1-danielj@nvidia.com>
References: <20260203222859.4219-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|DS4PR12MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: 0056238a-24e5-4868-e718-08de6373b158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pei7y9YO5VJHKPeQCcwvGHIjbv6G1Nm3xdFoVq/ds/JNeiE28rblUIqoCrzu?=
 =?us-ascii?Q?9vQXWTmKECvjGSdWVm7QAHvhVMR9/xursf8WBrDRqjFPYMU4ejTYTVqMa+uy?=
 =?us-ascii?Q?ttIccJX4WQjhjKSPz4zKe/4bgzqOskrZrNZVkB45QAHM0Uv1rUIygPmpiXwA?=
 =?us-ascii?Q?wHfYhoA8lYt+g4H2VvDzZG0eHk1HkknON3DWRf04L2I8w5P4E9aulNOk2hkr?=
 =?us-ascii?Q?qvwYib8dfMXTCsUXg7mIFawN4YtebsqJu9zlwnwBQASPqFeWoPvBDLG3okew?=
 =?us-ascii?Q?4OVQTXYN+4w4/3MWB6LE3/mGWvSD0w8q2UWIPsAYU9/seVKCjevVgVzPIFy+?=
 =?us-ascii?Q?FHKqd5qXr5tunuq1hNVkgZK9G+EvLMzBx/33glbngOJ+GlqnE0t6u+wKrECU?=
 =?us-ascii?Q?53wskEnt8dojFm1rJddC1Y7wTAxe0vXNtf+srYrvd3oFen7gSy8lvY7cKJoY?=
 =?us-ascii?Q?EzdnEPyc7kK92tWvO0xTta3bqIfoHHz61kZmu5kHWgVtZWv2hyxzz3yy8aDO?=
 =?us-ascii?Q?qU/XW6tbp8ltBnostJKYRljqFGfgoyI1cpT0+Uag3aQuSqNXWudqn3lRFbru?=
 =?us-ascii?Q?Q/z47RxFz1tYqIeypvW8i3JQDwO2g7F5TXgCEccqnCTzwASCWwcNhWuJgPbX?=
 =?us-ascii?Q?qD6m/zHb+BQBjrJ9asJ4gUKHDXp87u+6H7ixH5vJiEQhGW2DdoP/UQSRdPnB?=
 =?us-ascii?Q?ek+1KeD52KMbtyB87ZSNAK/kYJea4SeFd7sodX2aaohRwPqecYirlAfi7mOF?=
 =?us-ascii?Q?NXhR9yROmkeELx0Oq+/R7BgXXrMMpR6nD+SEZYLBhk8vJPrbRnYqNCmiEX9C?=
 =?us-ascii?Q?zlSH+Om8jv+50Uk/5v/D9Q5vSlkW69oNYbWo08b19WUOS+/QP72SrajzbibM?=
 =?us-ascii?Q?A1EmgZG6Gl/+d6bk8sBurfusGddVVEPMz7mCJ+aWhyNW9LvXzzrEAb3V9QRl?=
 =?us-ascii?Q?7BldGLylMK5PIhYIU1QjtejG8uuel55SpJj9AmYrcy/RAl1AsfyI6znl4d7u?=
 =?us-ascii?Q?faZk/VI7Wy0t14soch4qShDlhx3P8IwU88sHY8p3805WDdpl4YJcejAg00Wk?=
 =?us-ascii?Q?WMugQboGzeiEv1HJi9XPJVOH9CCc+o3Kckn6tiLV2w/igJvqT8FIdkdcL6Gd?=
 =?us-ascii?Q?6XBeX5Z/lpLFTBxCyXf847lwJfcegZQ3cfY8nYXHnFkxagAnU+KUB0Pwh16T?=
 =?us-ascii?Q?NSr2o8iz1fZnqEQK0fOxTYZYKMsawXS2+UDBmrUV3Xw0C3t2qPjI6sAYOkRv?=
 =?us-ascii?Q?R1k9RdMY4pCgN9iB/mCtealzCipKaxzA6avazkLpTaycP3EXj15Um3sb3sFS?=
 =?us-ascii?Q?8qlOCaTriT3IjhIIjjVHgJW5qmUBhj1NCwqRhSG/+nSXwQI8E2PJ0qiklGF+?=
 =?us-ascii?Q?y4fhtInzMsj1QpGjQQSRl2M7NjglaAaxgMRoyAsBrnsm3inOnnGOc0ugF8gN?=
 =?us-ascii?Q?a9FkPZ83uc8fLeRgjFEIt+6dE4SZppnXivYvhLTgBpKu5rBL1PUTKrDY2Tgq?=
 =?us-ascii?Q?z9feTX7RbNi3wSvu1NDkz76OTgzhWLOfftLiK96OzfQELwDx3Xvp4qVdaMc6?=
 =?us-ascii?Q?duoC1ypFvaIVFkMSGlXUCaMt71XuIixk0gujVn3Z8GuKLkpD/lcZTVEZUFRA?=
 =?us-ascii?Q?lS4viHUWdX5goMYwhnrPrIJZKRJn7zFWHJ3Op6FflG2Gp32u0rp00aYNVlja?=
 =?us-ascii?Q?11tbvA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vriTEPwI3nr9mr02Uq60HXyGLJPJj8lEuBqf2Onr4j6Euq5ifPNhKgz5V6JL6B52pyXwNcEi5XsG4FHlsPMoUIaDi6LHKou1XzKm4rOavjXJG3Ta4qYv/qwKHgLy2YX/5DxDIhmy7Ez2GREm1lkMcwOSDHYuGKdoVU3f+lu3qoSrW8BHR9lGT14ijlQcnJcuzDD2ADJmQuUUYHYhVXyYDxdr+N1CEIvlyNT3biwNN+gJei3fPOCdnGsYOB+lVtjZviRuzQWRNlRTBrO3tM7z6DQAQZPbn3aRiyfQD6Y1sWR1/EByHTzF5TB/sUCJ3bTz624Cm4CBN2KQzhFfXhdcnMLbHjrbnL4CRgsLNaABa8ZoYWs5nT6Yft6GPxNkGhIUJLHHGDEXkv9OXiXkrsmb4B9ko7XizKIk/0tHpSeVqJkICoS07mdFLYuzcgeeh1Fk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 22:29:27.9519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0056238a-24e5-4868-e718-08de6373b158
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9586
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256469-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 169FCDF466
X-Rspamd-Action: no action

Currently querying and setting capabilities is restricted to a single
capability and contained within the virtio PCI driver. However, each
device type has generic and device specific capabilities, that may be
queried and set. In subsequent patches virtio_net will query and set
flow filter capabilities.

This changes the size of virtio_admin_cmd_query_cap_id_result. It's safe
to do because this data is written by DMA, so a newer controller can't
overrun the size on an older kernel.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: Moved this logic from virtio_pci_modern to new file
    virtio_admin_commands.

v12:
  - Removed uapi virtio_pci include in virtio_admin.h. MST
  - Added virtio_pci uapi include to virtio_admin_commands.c
  - Put () around cap in macro. MST
  - Removed nonsense comment above VIRTIO_ADMIN_MAX_CAP. MST
  - +1 VIRTIO_ADMIN_MAX_CAP when calculating array size. MST
  - Updated commit message

v13:
  - Include linux/slab.h MST
  - Check for overflow when adding inputs. MST

v17:
  - Added missing includes. MST
---
 drivers/virtio/Makefile                |  2 +-
 drivers/virtio/virtio_admin_commands.c | 96 ++++++++++++++++++++++++++
 include/linux/virtio_admin.h           | 80 +++++++++++++++++++++
 include/uapi/linux/virtio_pci.h        |  6 +-
 4 files changed, 181 insertions(+), 3 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h

diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index eefcfe90d6b8..2b4a204dde33 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
+obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o virtio_admin_commands.o
 obj-$(CONFIG_VIRTIO_ANCHOR) += virtio_anchor.o
 obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
 obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
new file mode 100644
index 000000000000..be9144b25d84
--- /dev/null
+++ b/drivers/virtio/virtio_admin_commands.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_admin.h>
+#include <linux/overflow.h>
+#include <uapi/linux/virtio_pci.h>
+
+int virtio_admin_cap_id_list_query(struct virtio_device *vdev,
+				   struct virtio_admin_cmd_query_cap_id_result *data)
+{
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist result_sg;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	sg_init_one(&result_sg, data, sizeof(*data));
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_CAP_ID_LIST_QUERY);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
+	cmd.result_sg = &result_sg;
+
+	return vdev->config->admin_cmd_exec(vdev, &cmd);
+}
+EXPORT_SYMBOL_GPL(virtio_admin_cap_id_list_query);
+
+int virtio_admin_cap_get(struct virtio_device *vdev,
+			 u16 id,
+			 void *caps,
+			 size_t cap_size)
+{
+	struct virtio_admin_cmd_cap_get_data *data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist result_sg;
+	struct scatterlist data_sg;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->id = cpu_to_le16(id);
+	sg_init_one(&data_sg, data, sizeof(*data));
+	sg_init_one(&result_sg, caps, cap_size);
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DEVICE_CAP_GET);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
+	cmd.data_sg = &data_sg;
+	cmd.result_sg = &result_sg;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_cap_get);
+
+int virtio_admin_cap_set(struct virtio_device *vdev,
+			 u16 id,
+			 const void *caps,
+			 size_t cap_size)
+{
+	struct virtio_admin_cmd_cap_set_data *data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	size_t data_size;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	if (check_add_overflow(sizeof(*data), cap_size, &data_size))
+		return -EOVERFLOW;
+
+	data = kzalloc(data_size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->id = cpu_to_le16(id);
+	memcpy(data->cap_specific_data, caps, cap_size);
+	sg_init_one(&data_sg, data, data_size);
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DRIVER_CAP_SET);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
+	cmd.data_sg = &data_sg;
+	cmd.result_sg = NULL;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
new file mode 100644
index 000000000000..4ab84d53c924
--- /dev/null
+++ b/include/linux/virtio_admin.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Header file for virtio admin operations
+ */
+
+#ifndef _LINUX_VIRTIO_ADMIN_H
+#define _LINUX_VIRTIO_ADMIN_H
+
+struct virtio_device;
+struct virtio_admin_cmd_query_cap_id_result;
+
+/**
+ * VIRTIO_CAP_IN_LIST - Check if a capability is supported in the capability list
+ * @cap_list: Pointer to capability list structure containing supported_caps array
+ * @cap: Capability ID to check
+ *
+ * The cap_list contains a supported_caps array of little-endian 64-bit integers
+ * where each bit represents a capability. Bit 0 of the first element represents
+ * capability ID 0, bit 1 represents capability ID 1, and so on.
+ *
+ * Return: 1 if capability is supported, 0 otherwise
+ */
+#define VIRTIO_CAP_IN_LIST(cap_list, cap) \
+	(!!(1 & (le64_to_cpu(cap_list->supported_caps[(cap) / 64]) >> (cap) % 64)))
+
+/**
+ * virtio_admin_cap_id_list_query - Query the list of available capability IDs
+ * @vdev: The virtio device to query
+ * @data: Pointer to result structure (must be heap allocated)
+ *
+ * This function queries the virtio device for the list of available capability
+ * IDs that can be used with virtio_admin_cap_get() and virtio_admin_cap_set().
+ * The result is stored in the provided data structure.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability queries, or a negative error code on other failures.
+ */
+int virtio_admin_cap_id_list_query(struct virtio_device *vdev,
+				   struct virtio_admin_cmd_query_cap_id_result *data);
+
+/**
+ * virtio_admin_cap_get - Get capability data for a specific capability ID
+ * @vdev: The virtio device
+ * @id: Capability ID to retrieve
+ * @caps: Pointer to capability data structure (must be heap allocated)
+ * @cap_size: Size of the capability data structure
+ *
+ * This function retrieves a specific capability from the virtio device.
+ * The capability data is stored in the provided buffer. The caller must
+ * ensure the buffer is large enough to hold the capability data.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability retrieval, or a negative error code on other failures.
+ */
+int virtio_admin_cap_get(struct virtio_device *vdev,
+			 u16 id,
+			 void *caps,
+			 size_t cap_size);
+
+/**
+ * virtio_admin_cap_set - Set capability data for a specific capability ID
+ * @vdev: The virtio device
+ * @id: Capability ID to set
+ * @caps: Pointer to capability data structure (must be heap allocated)
+ * @cap_size: Size of the capability data structure
+ *
+ * This function sets a specific capability on the virtio device.
+ * The capability data is read from the provided buffer and applied
+ * to the device. The device may validate the capability data before
+ * applying it.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability setting, or a negative error code on other failures.
+ */
+int virtio_admin_cap_set(struct virtio_device *vdev,
+			 u16 id,
+			 const void *caps,
+			 size_t cap_size);
+
+#endif /* _LINUX_VIRTIO_ADMIN_H */
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index e732e3456e27..96d097d3757e 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -315,15 +315,17 @@ struct virtio_admin_cmd_notify_info_result {
 
 #define VIRTIO_DEV_PARTS_CAP 0x0000
 
+#define VIRTIO_ADMIN_MAX_CAP 0x0fff
+
 struct virtio_dev_parts_cap {
 	__u8 get_parts_resource_objects_limit;
 	__u8 set_parts_resource_objects_limit;
 };
 
-#define MAX_CAP_ID __KERNEL_DIV_ROUND_UP(VIRTIO_DEV_PARTS_CAP + 1, 64)
+#define VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE __KERNEL_DIV_ROUND_UP(VIRTIO_ADMIN_MAX_CAP + 1, 64)
 
 struct virtio_admin_cmd_query_cap_id_result {
-	__le64 supported_caps[MAX_CAP_ID];
+	__le64 supported_caps[VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE];
 };
 
 struct virtio_admin_cmd_cap_get_data {
-- 
2.50.1


