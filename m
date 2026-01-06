Return-Path: <netdev+bounces-247396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E79CF97BF
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 17:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0AD93013EAF
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB6F30EF75;
	Tue,  6 Jan 2026 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nTW0COH1"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96248288C25
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718311; cv=fail; b=DcmlviAnQd5OnrGqFgQ6BBqU0xmf7xKlICUQgHRhQcd5nX0vNopSOwF64MMYV0dtD8iJT8JWOH1aOQ8aVmTx9yfSSpV0pQshl+GAK3l6qCpLVxOECPiHNJjLReYVPz1O8N3FUv0XosiEWAAFDs8rxttdfn1QtRbAA3txaD0G7lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718311; c=relaxed/simple;
	bh=wsGUHq5OPVhfOEtt/rMv3q+JFLZAeVhlUX16tLUzxUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lykVpZOdrwIEnjW3nYZoEaefTj1AVSfaTLsFxtWwiwCFV3m2Za59l9vOXrA2ze+qhg4jlOwI2ZoN/ilE+LTqVu0bLamyibCaMk8A8ZA/MQpMBp3Qgt5lLVDFhC9myH8cHb+UYfQF0I9POq1Cyj+8aAbF975Pe3zlO5FOVErM27Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nTW0COH1; arc=fail smtp.client-ip=40.107.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVTpDCAPL3Iz6sY78FWjKEFKrJre/II5czNaFKzUz3rH4LmW2oYPSuz89mlXtoYLvBEZgbmAt2SgA9fpryGx5Gxp8LokXnDgrpxX+lJpkWlLzgF2PLjsByxyclfO1c4UQJoJvxfq5G5EVJbLqDycG4/+g9krQfpmZHr91+VzEBKEPLdDS8VnKTxltZMlDTiJ8hEIhJkNoz61uVuvhUq8BGh1VdvV23lKJWwsa8u35qYCJCZyzAmtbykJ2PBCuiXkpRBKjTynpvzQLFoly643P53SInQncqaiWH1Jc59a+Gpv4NRaNqK4ryOmjY50TqOvLItrpnJ3LYTKFOoV0ML8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlJi7cDaXABF4XlI/hECzIo+dxPjFTo6en3eJYwHZIE=;
 b=LPo0OUyOK3X8HeQYTzG64IizaGzdVIHB83aJ6tpj1hBT9K7LO4IwrHeZtGUo+eLgKekqSzbCI5QxoTK38B4f1m3Z2vnb1oeVL6vfcQegO2DSVGF9WaABMG1/GEPjizCy5+X1ZQygFYU7q9rWK7bU0xY9oE8uy89pD3zJ0omaHiiiX/10dLOZXOuHwghYpadZ4Yr46HxRXfpRpuRjWHIWfIm3O9oOl0IpGim4llFriXzGEex9FgRZhu1rjJojPn3F82pAWZ4ia4BRhBUzrP1yyqVFQVX+xwQi9FZKPmC91HDzS+5OMVVNgto8UJzJ4sWyz9aSwCoL95LLUtmnJtsSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlJi7cDaXABF4XlI/hECzIo+dxPjFTo6en3eJYwHZIE=;
 b=nTW0COH1OOIpGeMQDphEkXg0l3UC86/+qhWYQ4DwEbD8ewvu2URWSibBEizl/Z+nV+x+tnRXlOBG/m1AJvICLUSx5eV7enPJAtdOFDS06AIRSQFFH/Joa1Esh7yZ5JxCitTtq4Yv5zCRZySF2T35WVGLNIv/7v4mziyz0PsVFvoVTK/aoDYLgx0VhwvMz4b79ZLkQeRRqX5ab8avD1Foyvf+1mOagulhXcxQsma9CiTuu8KTsz8NFKGN3IBbCv2F4KrFiUsTqyPo8gcCP2scVJlH+X8unUplCQwtrpiOgPyAXl9tXQvDLlDRpJu/ns0wWJhWMDITN7EgLctfbjaogA==
Received: from SJ0PR03CA0147.namprd03.prod.outlook.com (2603:10b6:a03:33c::32)
 by SA3PR12MB9130.namprd12.prod.outlook.com (2603:10b6:806:37f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 16:51:45 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::c) by SJ0PR03CA0147.outlook.office365.com
 (2603:10b6:a03:33c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 16:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 16:51:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:25 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:24 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 6 Jan
 2026 08:51:23 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v14 01/12] virtio_pci: Remove supported_cap size build assert
Date: Tue, 6 Jan 2026 10:50:19 -0600
Message-ID: <20260106165030.45726-2-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260106165030.45726-1-danielj@nvidia.com>
References: <20260106165030.45726-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|SA3PR12MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: 579b394e-5bb7-47d1-4f6e-08de4d43e01a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PGeRpNHGxV5TIxWQ1BTyTVHqAJYs2a6j5YM84ezliw3U3UkY+L7FDSDDBQcg?=
 =?us-ascii?Q?Tt54tNqqaeNQfdL84G3AKHPYMAV3AhJHIRdvlgwMuWnJXwOc6RA+6hyjLpLr?=
 =?us-ascii?Q?L/DCiDoEsU4Fdt9ayoB/xwjYtDzz09x3VccW4wuncSXsw8+mCqUflZif0/cA?=
 =?us-ascii?Q?Uqe29RlBkS25tnxn+faCGix/ucCQ1qlrzPEo9p8D5eQDtPdET4rKFKEvgK3E?=
 =?us-ascii?Q?jUgFMrBUqom9j2jYr9VbC37DbpNu2uiJ47AeMV9mHsEFXUUnT4XMMZ6qFvRm?=
 =?us-ascii?Q?hSBNF54Q+ERAHMT3YvXLrnKIb2Bbhc+f0lLPVwx4qh5TdL5lEPzW41NClBCP?=
 =?us-ascii?Q?UJL+kBuXetDG6NDXD+44wU7VA607b8AP3jNu74Yz/AhLEjmU5iKgCQf869Tr?=
 =?us-ascii?Q?a7sYYlWugECdInNIs3NSJbQON9NFHydBR9aNN3Cw0cGTDeUAGIWHPFPy/b+c?=
 =?us-ascii?Q?2jZNHe4fcilt4+cpiymK07ZfWDn7k6roDlQvPHKztpd+/59n34VgzMsJBjii?=
 =?us-ascii?Q?TfIuX32Z8Xq4iwaZVKMr3x5s3y8jgWqHzmkeNxUAhd9xV1DFROpVJTe1hvTi?=
 =?us-ascii?Q?NR4ErKXe8XyqdaXq57R60/FUddqSn5MxmEuuL2hFUD1R0ira7aKvyGNgblqY?=
 =?us-ascii?Q?18yb7EHAFQLkeJxj98CTG1DHn8BocRCzrLPdbKy6Vo7gF/kTPpdkxxvSQsSI?=
 =?us-ascii?Q?nGd8QAJsZPyLhf90JvIFa27Y/yG7SfvzA4nyk44zzpSmwXWOq7kKnJ30pqUH?=
 =?us-ascii?Q?XprsdaLnBsiTAqnRvJIGCQITJ2Qgaiw3Px/KojhoxOlTKIewYgjXxiBdoBUr?=
 =?us-ascii?Q?7UNJ1IrFKHs4Fz3ueSUD3FgyYSti1oXqqViZbsePt7Lrw5QBl7OBy2/gBrFu?=
 =?us-ascii?Q?m6GLSEie/LCQNNPs+JpKHmqsinPCShcCrWLAJY4Q61dadep/9KGC5x3Qr278?=
 =?us-ascii?Q?Fwad5zRNtWqA9zJqr/EVAs7quYksCez3mwkpS1Pi6Im8sSO1opHZ/lCgku6o?=
 =?us-ascii?Q?T8tu58gafT61ZAF/d/jQ2KEERKRkBRJzT6OSKvwvHYuFuwpLwW5gPWtOygvl?=
 =?us-ascii?Q?Z3Ee01qQtOmgg1mzsAP2chyJhejL0DaLQU95rR3pLwAUotjGruV3d88lR5q8?=
 =?us-ascii?Q?9QM8JloZMZVItTm1zuWSnA2Y5IsP0F85NyuNxhls+c7WjcqVyBjWjY3OZr4i?=
 =?us-ascii?Q?jbjS8YOohWKljDYAIEdjh32kJYzYqtPiMiEA9GOUo7MIzNsGORWWGM0z9Ogp?=
 =?us-ascii?Q?KIu1joFpq+SJFjEOX8kKJK3oZpT1Q0z8AQHGG0NRaCX/gLSgMaQR8GEA4Jwr?=
 =?us-ascii?Q?IZJMA6ONQgUCHxUQceWFQuRxY2nOpyalC9Cl/3Gwf6N6rU+LJ5dkDBM39Q6F?=
 =?us-ascii?Q?HC9E8amD85OtBtPF4X3X1EEf63FzbvA4d+uKLnId7acfwTatNU3OrHOXCVGD?=
 =?us-ascii?Q?aCQHJn0YH9VMJY7J2bDSc6Nl2s6qDPpSlI+TLorIxzXyZtN9LmcTdS30IdQG?=
 =?us-ascii?Q?sSk7Jem8PawC0hmnuGs/II8wEJFJ124R0He3Fbwb0w+bo+3oyqZdvUV+86B2?=
 =?us-ascii?Q?caI4S9BaLLiKAzU+9YQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 16:51:44.9773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 579b394e-5bb7-47d1-4f6e-08de4d43e01a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9130

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

v12
   - Change supported_caps check to byte swap the constant. MST
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
index dd0e65f71d41..1675d6cda416 100644
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
+	if (!(data->supported_caps[0] & cpu_to_le64(1 << VIRTIO_DEV_PARTS_CAP)))
 		goto end;
 
 	virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);
-- 
2.50.1


