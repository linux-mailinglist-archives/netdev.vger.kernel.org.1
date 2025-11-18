Return-Path: <netdev+bounces-239597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D20FFC6A1FB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AD554F9169
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE1B35CB7D;
	Tue, 18 Nov 2025 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LjdXoUCS"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013059.outbound.protection.outlook.com [40.93.196.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3D134B410
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476781; cv=fail; b=lIOWKxvNDa7B2yrSWHKqU2BfD7lfDVyDX/lOOEbdtZe8OBDKxTnJJpu3TunkAeJ9SzA9ob4A5zCycLQV/V01tY+zTBF4ywvzFcmmd/8VW0f3h4d0IyuXKq2MMG6WNOP5pqUHO3b8NvICjwdofsLuZV4cQ5AJApx26j6yaekiEj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476781; c=relaxed/simple;
	bh=Dc8533Aff9TqwV9HN1L7Ofat7h1bz9pH7F7w87LDzMY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQ/ww9ve4Rzp6t08kqU0exiNtmlHYcxmm4miI4DlA7+Yhs2qR3xrnxYt+jgMU1/Grs7sovjq+J3rapm5Yg5ri14ilLNlduXLPdKvB62rzkgUaqoy7/sYnzm+uesZdtUx0SV+IAAlTapKOMH461eiHkDIyXWEEG/BRrQVHWK50JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LjdXoUCS; arc=fail smtp.client-ip=40.93.196.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icG0vCV91f82twPgZFLPifSJWbTxjvuJiilkwHoyMQ/MdW54WrkNYdCTk5pw0XAiEwucNkEApq+rZfu378PC3IE2wHXtYd/vwJvG0tI60B+Jz+R/yi2Nk5BwgIQ6xx+W5hPNXJk3eHcvSzSDH5VCOSOHUkcJNES7kZk/hQwnt2Q4X4hPKHUsXyyFZOZ+xcQ1nezrDD4f0G9XWNQtqUJ6snupt4vJ0z4szpNts5ZcQMau+PC0v25q7SfU5tUWfWRXM6orJpltBsAW/Tu40RqmlkxgaroXV3eWSEJp4uFBqm74uE7CSkOV73L4IClYqHJJtjOO93hIeLIKN+uHWhRnXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QShZgmG69hS4sP+fAVJj23dd5ogqqm/4ha+EoA8MOnA=;
 b=TEJKbgXvPoqN72cDaKu/JfzOim/j4Oi9zV6Z0lB98YLLowX0r8TR9ptPG2tTTppytSuyMPADM56Gud6nGkycJSYK59v7iFYN9rv2sa/+IezstWWpLKw5C6Pb/CDIYni/iaqjU5dVDH9gayl6xRjpduOEa9qWof6C8A+boihCZZrwIkeKp6zJTs18siXd7zaotkTyd2ER7BxA5Q9EkfSOrjgwu0zyJiVKUwkDY8aXEbWxT/e3yyY0j01kAijZr0Vft1LMbDcC9SR2RIXs9S22qor9YuMXK+ziVYgK4gYHiy8Mcwg/v0JhRf0k//beCHXoAeotA9mDTDuOlA11RYb/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QShZgmG69hS4sP+fAVJj23dd5ogqqm/4ha+EoA8MOnA=;
 b=LjdXoUCSX+fgo/uV4gB3O7507PEFPjn5e98WzM6B9oW4nSnmfGVxTmT3MyDkY+uzZP1k+x+RSmBMlMR/GPdyF3DpB6inwtRN7Tmb/0wctdc5ysFAKY1juQ7SsyYlfQ4qJ0hJwVCH5i+oUsVdd8MUU9GFSlTaEFjqsNMIHDawA3jUsA7e1KhFJoW+7b7Kt54i8XAP8W1g6OlyrdygLAZZwObtymXTOtRkjIePW7z+1JQxzRQsvw0q9UCH9j61+b0avgaOcFojplBWZb7s4vouhG7gPfVhF+lxC/69OjpefwtVCIhWjSoN9wmSH1vjYKFec+wPlxB3HDgj3rQxHv0LsQ==
Received: from BN0PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:143::14)
 by SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 14:39:32 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::30) by BN0PR10CA0010.outlook.office365.com
 (2603:10b6:408:143::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 14:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 14:39:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:39:08 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 18 Nov 2025 06:39:08 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 18 Nov 2025 06:39:06 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v11 01/12] virtio_pci: Remove supported_cap size build assert
Date: Tue, 18 Nov 2025 08:38:51 -0600
Message-ID: <20251118143903.958844-2-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251118143903.958844-1-danielj@nvidia.com>
References: <20251118143903.958844-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|SN7PR12MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c3962b-0774-4fa1-9a66-08de26b0499c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NP5DvJ9IWBFd8S4JFzAjpo/XfIFGqRbBkRTeXtdb9CW1ykdkwgi6lRjfhrPC?=
 =?us-ascii?Q?nXcx1ksLdY6uz1NIfHyUDTblHVkicUXqE00W+IuV3XjjI5/IOgZHoI40H7L3?=
 =?us-ascii?Q?Udx0KBtI0KvjH8d8Fa8KNpSmE5nMdKSkHBGQw9Ea9cx58OQxdKvdyYQ0uKBr?=
 =?us-ascii?Q?maMeqsJmB8CDikf3AgEQjO3hMHB7UIyWeM7+Vl3lX3AZeHnCm9nb9QBPLbo2?=
 =?us-ascii?Q?+XEg/Lnk11ZUubcHLxQvTzGQsrikbHd0TNUparwJiVCMNEc6K5GV132VGU4W?=
 =?us-ascii?Q?SZauoxGUDx5D5wU7NBMnIPw+m6aOHku6Tvf7B+78sEPzXuhN4XIzAyUcehXS?=
 =?us-ascii?Q?Tj1ufNQUVNY+7muqMtErv8Gx8j7iDRkY0IvBKM/3/LutcdQF44hJJnhdVsqR?=
 =?us-ascii?Q?TYIxQo8Zu6RImM/slWjDDGYi5T5AlFxt/RnwbVuQa+MsYc9PlqlFuJvnSFRC?=
 =?us-ascii?Q?+BZIfV/KVjFbdD3APVYenTEqeNrjcdL2Po6d6D6qaKELnugxN/H1aN1ZNsPW?=
 =?us-ascii?Q?eJIVBX7/MjTMzQF2seOSnwbvKnffAlharXN5tG3IOgjqT+DlGIPUfH4/KDcY?=
 =?us-ascii?Q?v29poX0ehTsa6Wp/TtBlH4dF8geTmp+sIllbQb62CacskIyr7pB91hY2wKHw?=
 =?us-ascii?Q?mruRg+Wi2LDHf4Y4pWXLqsbCipCRb41CVV+DmMeaJSdXhV3pqB+aL/vBwx42?=
 =?us-ascii?Q?HiF8q26Io2DNmc/fhxKUMLinBOwBKtlbZ/DR5Ip37Jl553kKtTEeYwyQ4QEY?=
 =?us-ascii?Q?SKuUmnuMs2kRsUmhb7sOK870fOg4c5a0vK2KqeT0MTjvhl3rCWBkfK2ZWD2U?=
 =?us-ascii?Q?1ouSF8QPp2j7MBMtJZx6tr6gtnH1bSigdluo76yRULwsqYBPUVHAnBMUbelk?=
 =?us-ascii?Q?HVrvZI8TMXgyREVXO8hIsTE8hM/HeACB9fgNtcbgTJkw3lKpOCIt6zR3tlmn?=
 =?us-ascii?Q?etblVUFxMZxxmrR+9qtjUmE2FIxdx9MKw01oxaI0g5mSlKRgPIByfFpDh9aN?=
 =?us-ascii?Q?rbWFsFRsbO8uDbn3lhslGBc5XNJynvhU2n0os+Zt9XqWC+HaJC/iC7FjmsdR?=
 =?us-ascii?Q?0Ltv4CZpDVYKIZFIipNfCY9KYQ7Md/dOvAHx3pujgiNeMVK2Try80bchVxaN?=
 =?us-ascii?Q?RxzPi/vpl+uX5TAfF9JBIyHdOmtQ3fiTXgJ+hFpa2as8gpudCNO4fIaNcBSE?=
 =?us-ascii?Q?fulxP+mlL9Y9vPl7RfuPQGaacwbENAikGY/MiYquvWWsdo1Ec614/S0XO8DW?=
 =?us-ascii?Q?/wYoNI2F37W+UOBNR69oVGphoLS0If4qGwoQafFgqNKkhOBIb8VEYVbJXTa/?=
 =?us-ascii?Q?XfvX53yYIXi+jM/bVJ8Eutj+gTZTrsF6nmU3Utr1RAJnxzAJTngx2tfJjJty?=
 =?us-ascii?Q?1Y+G/IDzdkux/8xOC/Dr31XTkDwuNEGReSujTd8BL5Zyp5LafYpSqRNWpCS3?=
 =?us-ascii?Q?6bXj3hAsMKkKVHT25mcbteNqh7aOpByiTOkA22aiGKkfu9qlIqcCEpSHu1wG?=
 =?us-ascii?Q?QQBUGE0/TxaiIWzjnQY49nqrUW2DareCPndubfkGK9tRmgzYzNt5CYaArK/g?=
 =?us-ascii?Q?xVh6W6JBfR/7R0nHCOg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:39:32.2541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c3962b-0774-4fa1-9a66-08de26b0499c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7833

The cap ID list can be more than 64 bits. Remove the build assert. Also
remove caching of the supported caps, it wasn't used.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: New patch for V4
v5:
   - support_caps -> supported_caps (Alok Tiwari)
   - removed unused variable (test robot)
---
 drivers/virtio/virtio_pci_common.h | 1 -
 drivers/virtio/virtio_pci_modern.c | 8 +-------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 8cd01de27baf..fc26e035e7a6 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -48,7 +48,6 @@ struct virtio_pci_admin_vq {
 	/* Protects virtqueue access. */
 	spinlock_t lock;
 	u64 supported_cmds;
-	u64 supported_caps;
 	u8 max_dev_parts_objects;
 	struct ida dev_parts_ida;
 	/* Name of the admin queue: avq.$vq_index. */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index dd0e65f71d41..ff11de5b3d69 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -304,7 +304,6 @@ virtio_pci_admin_cmd_dev_parts_objects_enable(struct virtio_device *virtio_dev)
 
 static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
 	struct virtio_admin_cmd_query_cap_id_result *data;
 	struct virtio_admin_cmd cmd = {};
 	struct scatterlist result_sg;
@@ -323,12 +322,7 @@ static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
 	if (ret)
 		goto end;
 
-	/* Max number of caps fits into a single u64 */
-	BUILD_BUG_ON(sizeof(data->supported_caps) > sizeof(u64));
-
-	vp_dev->admin_vq.supported_caps = le64_to_cpu(data->supported_caps[0]);
-
-	if (!(vp_dev->admin_vq.supported_caps & (1 << VIRTIO_DEV_PARTS_CAP)))
+	if (!(le64_to_cpu(data->supported_caps[0]) & (1 << VIRTIO_DEV_PARTS_CAP)))
 		goto end;
 
 	virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);
-- 
2.50.1


