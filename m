Return-Path: <netdev+bounces-256845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG5KL9LKg2m6uQMAu9opvQ
	(envelope-from <netdev+bounces-256845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:40:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 736E3ED060
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 23:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D710D3014853
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 22:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF9F37A486;
	Wed,  4 Feb 2026 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VL+npz8L"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229F83806B5
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770244814; cv=fail; b=mu9km90v7yddz1WCZkaSzfIVptqBjcL1FfEX4nY4qEQ2wy3mqiFlDCbVR5UHb5IUtZq7AJb8yxyVmFIlMzPO4eb4y7FBpfoaCY8Hf6nBiJSv5FnQNkAJ9p4gvC4ZTxU6Css3gcI8SAjwocpnzu1S2IcnJ0u+KSXhsT+U7ZtjvCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770244814; c=relaxed/simple;
	bh=Q7jwogH4HAzXhwKXwOSVgPWx+XlBKLc8CMjdy0U5OTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0jptuE2XYH5/oMKsi+w4TMZbEfs94SJUd1cdZz5xF2RC0QW44l27c//qtQWL6agjTTGRpWlMbw1nXmoPdZ3RmkbvTfYnisbVECwnM+7vuA9zfMgKzWS4Rplyope5D/4lQKnAGfchzKJff/fjbXsfSRyifCnGSR6JwujVk4KakQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VL+npz8L; arc=fail smtp.client-ip=40.107.209.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onddqv8WBFyylbGSucMi3cgbErgD11plUmMyyVoQWxcaaaWJIdqUCbUqiUVCMcM8/a5kQJmreekEjExVHea0zPq8IgQNFMBKzP9yAP2/QYW0uJ7d9906PW3MGtTCL5fSZvNoQWFD9gzeNKr7bnG7ljMmMGwrGuFwvYED8ta4Whzrqv9rlfaouvIKOg+OUd5aX2lC0HH1AJCtECkLu+PA6Fe7tytzvf2tOMDbBqQ/l/4Ul3Mi+nQRn0PGRK95+ixW3KUi2/W3zREPFL4Lb/evP5MI6VLRu1FZJpfn4hJDYskAtHHQdhGKWQ3ussU4uSZYVN1ukl8wklkHr0nS0wC+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlbW643wCuvJ/L7F36TTH8biSEXn73nfPLD5W/3ThCA=;
 b=Wadf7gwQRSfMqr8Th0UGL+h2wlXYJ+nKGoCUA/Jwbz+nl6IoTgjY8Qt0doe7pD+BjbqFG/IT6sCVBakUMXMkgDyubkfIpZDaUqyCrW+UvmZneR+Vj68scvX5p+gpk6n1RadUIiIv2OSE5/DaCDF5MQ1XHSFRAcweX87c753sWHsxLROD2LI4Fh4KwkjSGDQef88nHaETP+avC/wQfp6CW02gpMeDLw3mqtr9PGwLeC8pRSYM93zH1hSu6mLT6howsIhquBNlj3dxPwUVlifOH5mkfSBn5erPLKlYAr23Y26GdO1OrnF/2mpJGcXZYouQ7B4JF7idNDss4POuYzzvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlbW643wCuvJ/L7F36TTH8biSEXn73nfPLD5W/3ThCA=;
 b=VL+npz8Ly1E+XtmZFPkrsFefC0bxpofhoWhCNrcfbkmQWQKYbGruZsPOJvSZC7CzU7tkr7Pvtmk5LIQ4hUzOzBR9Uzj9MuBMhpBQjxVC5uAfE2yGCTzQ9gaqW0nguOiHV01/ru4N5RgRDvuzGKAkl05/sc5DFgzTJR0to9WG52iOj6rIBCY83/Mh4bfQ+fPE9lZyHo/Bna+zjD3xUmy7y3vcUejT9il1fb6Yc67/ZHGNTzDlcykUMpgrR8FLn9BMBUEvpBNwHIbCGPwEnvSdeExzKI+xcCDz8eMJSK584hYtWjRLJlb1gjLjJSRBwk1YvwFk+oVaXe4LR/9uo7UPBg==
Received: from SJ0PR13CA0118.namprd13.prod.outlook.com (2603:10b6:a03:2c5::33)
 by CY1PR12MB9626.namprd12.prod.outlook.com (2603:10b6:930:106::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 22:40:08 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::1a) by SJ0PR13CA0118.outlook.office365.com
 (2603:10b6:a03:2c5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 22:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 22:40:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 14:39:52 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 4 Feb 2026 14:39:51 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 4 Feb 2026 14:39:50 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v19 04/12] virtio: Expose object create and destroy API
Date: Wed, 4 Feb 2026 16:39:32 -0600
Message-ID: <20260204223940.39581-5-danielj@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260204223940.39581-1-danielj@nvidia.com>
References: <20260204223940.39581-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|CY1PR12MB9626:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea5c9f3-2963-41c3-91cd-08de643e594f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DjV29ulTpXZ73zwy2tgPOdaMraUjufdT5eBCnlphKzSev9+Z6FHmHfskCjzW?=
 =?us-ascii?Q?M27/Hd0PH8bI8cv+8ttRNTGeX1mn5pZKBcbDUBmiFJebFlgnqzhtXdOQE4y8?=
 =?us-ascii?Q?NfP6zhqZkRu0DTovyXrYQSYhhBv/NA2Uzv7ZSaetlT+A1nOsypipM/NIOIPY?=
 =?us-ascii?Q?39bgGLdRZ7Tf0wg6sHhgF1dcZmHbxCLP8GI+G2QsIfy9g/Z8RxcrGqz1YrKn?=
 =?us-ascii?Q?ljKm3k2QeLJ4zelHQLt32rj22vhvmZ9DIY9+mf6qHhKbqvH9l1hTv5Yb7jPI?=
 =?us-ascii?Q?oV1B5L1sjYrcg7/JNB9V3YjqgJWPy4eYK2/QFTPI9aFijNFxZzZqlFI91sij?=
 =?us-ascii?Q?a3l15gySx+ZVgmeLR9/v2G+Y3gr/YDtqYwwULqqdaF+zBYDxtv9Zdh90wVMO?=
 =?us-ascii?Q?Bd5SrKAkgK6cytovP6grHEjSBl6KEGtGbXzvU2/HHQ4z9ld5SK/Z7DYTCLUk?=
 =?us-ascii?Q?lgiNgTA3xwnXp6dRMIMf1JQa4viFUVCLyowSqmXtmWIhtV8skX1ymVsOyiSb?=
 =?us-ascii?Q?ntW9o0cQE7m8VXJNOF63XHD47OHKmbnXfDmi1lXxBpwuC0iSd1DYLFpAT5Y3?=
 =?us-ascii?Q?l12r+LL9k0ZnTsQ/weYPROe6PkMKENxshKvmnE2nUJZm+A9/RznP5aF7R9cO?=
 =?us-ascii?Q?+gChnR72NOEFFDLsdo9WaGld1NpeRJBBSYjjQIPjL5coxVsz6+fasN7WPzYq?=
 =?us-ascii?Q?1JdfpA1l6sThkSkSywMSpfIWu2tGMEJMcLEh49Wm1Ain3RpcwfIWT0ZOnHxE?=
 =?us-ascii?Q?NGEB3HIpnvGCnMbaejWLtpsIiiFQEhhztEdlHwagMlCJs6Ex6QURe5sfC8RI?=
 =?us-ascii?Q?ZMBJIV5+PqaRsRwpfac2kawwM10R52nfgtr+HKHb0BtxxR9ve87j1GpMkDEY?=
 =?us-ascii?Q?j9AOBfwUMKVB47lTK7LPiUNIZNvuyjk19eaXQC0zSszssu/+6aASsFPQcpYd?=
 =?us-ascii?Q?tmX0CuLqNtxlg2OatreGo1cFn4UMK9KWG8fJ+jtGOg+D/SrRGXsjdcVoaT4z?=
 =?us-ascii?Q?bm07LvW+l5q5gaxI30CCua3ihtmEhIXcRDAnOE14G+DAwLqIP4SfE780czIf?=
 =?us-ascii?Q?rRB5/0D0XIkCYSzPqVvSMKDRMbIdFW9lrp/MN/yorkgFhCEC9cecd+2nT5Oz?=
 =?us-ascii?Q?w2OpquA6V1IX4jAuuYTUHoBdjv/Wv45Ryg2D18YueYlF5cr5e1YCbdlTOE+k?=
 =?us-ascii?Q?bnsAdrxJASg4CvV5GX/3VkV+FD6gXOJyM6Sxc+a2N6FgH80RE4Pq/VHHdykc?=
 =?us-ascii?Q?l5A3fi8ZUSjEK5zFeKlK4FRjmPHQTg4pXxPC8YlslrHX/nWc7Y0e5d5CXFhP?=
 =?us-ascii?Q?zDIkBFqDw+yJLWJSqD0kwsTzf3+jL4Z/q6f95qqYyhZN+W4Dctf76LdrKv6P?=
 =?us-ascii?Q?9MPKjW1o37f8An/1vfInCzh2N+popqSEK5VCEgXSTM/JhIs88R7AREdSJnP1?=
 =?us-ascii?Q?iULuZWmdokmyuK8khRlhFExrFa06XAH0y3RSKuleory/3CbMCe4+NN3UecIL?=
 =?us-ascii?Q?QuFYRx0dXWlduUDPko8tkYF6AEcncdurF80pROA5ToA/Dc1RoP9Pomj1wwwN?=
 =?us-ascii?Q?Q+dIVa1sB6alYk0Jy2hR/BHT8sUFmRmg8GBHdF9r2OwOEkDpu1OwlIEFZ9W6?=
 =?us-ascii?Q?65Fq2+muQA+q52pDHj3ZphMVZEZXtp3zcDaF+cArFDVFN3Pu5yjtr3O8ZBjR?=
 =?us-ascii?Q?o2RbWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fBkGe3VSE0wc3UlKwOETJmzS0gRUWlEPbpw6bV1/KPb6EMuEVT0dJxHzrnyJYm00jqUuKD4vl721ttEBv6G3RdiHnjPFXQq9hme2nbytaUjlu6aOv4bdo4Y34tm3mxFVLtKPVsscRiXiTcWSQ3OFJc0210ZUVSDErytwVsF5AmZ1iu7fkRmuJt1URBvqecSzTybvjfOJ6Ajyo5+0WGxZdHu9LN6q01Q5cogOhtPu12figI28+CBk4PtaaUvXn1v0M9jmGcjmBzaJb7HJqS5LKQfb435cE5CC5Knvk0onGJNbT1cl1GwXWZ02MIClyRi2CqlPLmu82hdKlJpiUGYZKxeAfyDuFh+kFwqTCfrU9x3a1zY8xKVLhPVY4+pK945aXztiDw28SQtit9ownfxIlSKGN1s+/Bh8bock2JyJpuyp+SO+gOA/0qgYFZZE7Mvy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 22:40:08.1427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea5c9f3-2963-41c3-91cd-08de643e594f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9626
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
	TAGGED_FROM(0.00)[bounces-256845-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 736E3ED060
X-Rspamd-Action: no action

Object create and destroy were implemented specifically for dev parts
device objects. Create general purpose APIs for use by upper layer
drivers.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: Moved this logic from virtio_pci_modern to new file
    virtio_admin_commands.
v5: Added missing params, and synced names in comments (Alok Tiwari)

v13
  - Makek obj_destroy return void. MST
  - Move WARN_ON_ONCE in obj_destroy here, from next patch.
  - check_add_overflow in obj_create MST
---
 drivers/virtio/virtio_admin_commands.c | 77 ++++++++++++++++++++++++++
 include/linux/virtio_admin.h           | 41 ++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
index be9144b25d84..d9b65be2d09b 100644
--- a/drivers/virtio/virtio_admin_commands.c
+++ b/drivers/virtio/virtio_admin_commands.c
@@ -94,3 +94,80 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
 	return err;
 }
 EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
+
+int virtio_admin_obj_create(struct virtio_device *vdev,
+			    u16 obj_type,
+			    u32 obj_id,
+			    u16 group_type,
+			    u64 group_member_id,
+			    const void *obj_specific_data,
+			    size_t obj_specific_data_size)
+{
+	size_t data_size = sizeof(struct virtio_admin_cmd_resource_obj_create_data);
+	struct virtio_admin_cmd_resource_obj_create_data *obj_create_data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	void *data;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	if (check_add_overflow(data_size, obj_specific_data_size, &data_size))
+		return -EOVERFLOW;
+
+	data = kzalloc(data_size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	obj_create_data = data;
+	obj_create_data->hdr.type = cpu_to_le16(obj_type);
+	obj_create_data->hdr.id = cpu_to_le32(obj_id);
+	memcpy(obj_create_data->resource_obj_specific_data, obj_specific_data,
+	       obj_specific_data_size);
+	sg_init_one(&data_sg, data, data_size);
+
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_CREATE);
+	cmd.group_type = cpu_to_le16(group_type);
+	cmd.group_member_id = cpu_to_le64(group_member_id);
+	cmd.data_sg = &data_sg;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_obj_create);
+
+void virtio_admin_obj_destroy(struct virtio_device *vdev,
+			      u16 obj_type,
+			      u32 obj_id,
+			      u16 group_type,
+			      u64 group_member_id)
+{
+	struct virtio_admin_cmd_resource_obj_cmd_hdr *data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return;
+
+	data->type = cpu_to_le16(obj_type);
+	data->id = cpu_to_le32(obj_id);
+	sg_init_one(&data_sg, data, sizeof(*data));
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_DESTROY);
+	cmd.group_type = cpu_to_le16(group_type);
+	cmd.group_member_id = cpu_to_le64(group_member_id);
+	cmd.data_sg = &data_sg;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	WARN_ON_ONCE(err);
+}
+EXPORT_SYMBOL_GPL(virtio_admin_obj_destroy);
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
index 4ab84d53c924..1ccdd36299d0 100644
--- a/include/linux/virtio_admin.h
+++ b/include/linux/virtio_admin.h
@@ -77,4 +77,45 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
 			 const void *caps,
 			 size_t cap_size);
 
+/**
+ * virtio_admin_obj_create - Create an object on a virtio device
+ * @vdev: the virtio device
+ * @obj_type: type of object to create
+ * @obj_id: ID for the new object
+ * @group_type: administrative group type for the operation
+ * @group_member_id: member identifier within the administrative group
+ * @obj_specific_data: object-specific data for creation
+ * @obj_specific_data_size: size of the object-specific data in bytes
+ *
+ * Creates a new object on the virtio device with the specified type and ID.
+ * The object may require object-specific data for proper initialization.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or object creation, or a negative error code on other failures.
+ */
+int virtio_admin_obj_create(struct virtio_device *vdev,
+			    u16 obj_type,
+			    u32 obj_id,
+			    u16 group_type,
+			    u64 group_member_id,
+			    const void *obj_specific_data,
+			    size_t obj_specific_data_size);
+
+/**
+ * virtio_admin_obj_destroy - Destroy an object on a virtio device
+ * @vdev: the virtio device
+ * @obj_type: type of object to destroy
+ * @obj_id: ID of the object to destroy
+ * @group_type: administrative group type for the operation
+ * @group_member_id: member identifier within the administrative group
+ *
+ * Destroys an existing object on the virtio device with the specified type
+ * and ID.
+ */
+void virtio_admin_obj_destroy(struct virtio_device *vdev,
+			      u16 obj_type,
+			      u32 obj_id,
+			      u16 group_type,
+			      u64 group_member_id);
+
 #endif /* _LINUX_VIRTIO_ADMIN_H */
-- 
2.50.1


