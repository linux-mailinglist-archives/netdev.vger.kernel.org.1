Return-Path: <netdev+bounces-286580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLN9DmapAWqFhgEAu9opvQ
	(envelope-from <netdev+bounces-286580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:03:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AA350B80C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6C043061E90
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F6A34751B;
	Mon, 11 May 2026 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nt+zIsAM"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8162A31F9BB;
	Mon, 11 May 2026 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778492760; cv=fail; b=RULQgWVayXZqAlYTM78pQKq4Ud68IAIwG2TLzKcGRmkW01e18yBO1HHYMyMTjmO4A4tRIK5XVLMEm4loPyQqh+otNXILVYoLqecOfvZC+DJAXKB9MrKi/fdTSTYFYiLU1FCRFM6mXrWHD4k2VXPaGMXi2g5OS1DpwDXTE1zcOBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778492760; c=relaxed/simple;
	bh=7oSuAU0xkftyD4Vo8X/Zb2Xd5EN957etOevIuGFtEeg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N+bDg3AkbhcKvrkF+5Vn0RJW5VdFE1VroWIcPeeTWFsxWme4p8QvuYDjew4cqp9xw4BhiAMyPpHtMxmTzoUXqS9A5YeKUdCE4cnPbdly6cVu6qfcRFiqUiNzg0QWsdLcl+2ns6oufWvETe0IuHhTFVTcqr7StY3DGjlJAh0jgtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nt+zIsAM; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKmSumm+O1yl9klNgYzjeYz/7FPeGX7MWiDUCQrpmhjogHJfyB9zpCEjBALeznWB9OpWbDxGlSqx4xNzre7u3gTktlo0THD+tWmvAJRxfziV4vuJfRLUSsY9IApJSEdCW5Bv0oZdve0ivZeV5McXI2kQZN2t6MJ73YxTQ06SXIrvECOvEL39E7eA4SZOl2E60Ewf3pujbXtFH5Y2O5Zfy0mjIjLxoXmLPiXsMILiaQglBbArkdFZBsfkdVL3l60LI52yecOBH3CtzIK98QbViAkmkrpN2HI4Cem4Q2Z9Voe1UMli0zPJM1oqbxh4fIcxlxsAHepoBzdYXu+Y3Bhs3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cekWc08cdXy2tU6vDBoKExg3U0YiKx108Li5vIt0enw=;
 b=lO59YUGcljm2MPqx0Y/dCLbA2QspqJU8qaqkOnQZA20EwzCrt304QKB8xE/e/rzM51Jo2yL/ebt2MJvHgO9PlLONjsmLezB+9AovtdGkbByme2z2nHwz/1wUKu47TbjmUw4X3JSCc0JHIu0MRonFMbyYFjbJeilkCeDqNzVDSjZl967RECIKHzCqvOLg7tb9FEwtwRBJcK+Viu5/bPko9YSd9Uzgggpu3khvbgD1j+kn9XNusy2R7v4mL7qAhi/1lfxnQDj0hH6zmzlXZsE/JZS7eXNmsuzsmQa7NfEZV46KUj54SwjSAoG7G1JcUYN2CswxdDAominpMxECw8fFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cekWc08cdXy2tU6vDBoKExg3U0YiKx108Li5vIt0enw=;
 b=Nt+zIsAM28scjsr1MHbYgMvKmC/kFHa61eq58Fp9jPX/LeWd6Z3ohfCGd8JE8UspF+7AgIQOsWZmAB8aEb0tC7z70MZm++QxyNhRsLY64kVpP+ylpZSYRV1gbMRxlChPBrdb16Yr7nFp3LKJNFImP0P79FJ6Jewo1NWE3h3zOgnEtudjiIOhx2+cFwDt/aN2edxkFDYNfpSzl7FPiWpGl/va9vFd6UwgZwDLXSQDKfhoPHiFUVl/73uIGXVJG7l3t8BqPRMX/VKSo2hNa6O6cj4MP4axcwBmSvW0vqaoho0G93TOMrz6UuBqqWCMN9b0J3iKv77T4yqa4CbVB86mQg==
Received: from PH7P221CA0070.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::22)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 09:45:53 +0000
Received: from MW1PEPF0001615A.namprd21.prod.outlook.com
 (2603:10b6:510:328:cafe::e0) by PH7P221CA0070.outlook.office365.com
 (2603:10b6:510:328::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 09:45:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MW1PEPF0001615A.mail.protection.outlook.com (10.167.249.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Mon, 11 May 2026 09:45:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 02:45:33 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 02:45:33 -0700
Received: from f43.com (10.127.8.9) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 11 May
 2026 02:45:30 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <virtualization@lists.linux.dev>, Dragos Tatulea <dtatulea@nvidia.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	"Xuan Zhuo" <xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>
CC: Tariq Toukan <tariqt@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<netdev@vger.kernel.org>
Subject: [PATCH] vhost-vdpa: Expose ASID group change after DRIVER_OK via backend feature
Date: Mon, 11 May 2026 12:45:03 +0300
Message-ID: <20260511094504.1619893-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.54.0
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615A:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: f072defb-dd69-4d05-f5df-08deaf42177a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wWGHtHu8uG85UCNyn5IQ2Mn+xSzmERJt+4vM+6TarUEMA+npUijU6Ty6koGEJ2x5Xc6khP5Zx8RAyH4gIBfs3yuUD7UnxQFOc1tVmsByH9PDnt9vRVfr2YSyQXO0ZV2Egb0KSn+uKPlbHitwRxoi3EqG5Z9OzD5tKeu9nBjY8giAjSdHt4voke6x0o9VoabRNzugbw505SzifmhUBE+PkKI+z8YfJV9aiU1uuyR14Xb5znGq49rXjf2Pd+iacY0G4IMnBqSSWlFjmr8FWRTGiWAJDWKMeKM6+9JWPtdSL499No65JSTA2I6UGW83ATueBdOvELgusBmhbFHoMgVrH5xj6bTBhco9GLVYW7M+1gwAso4dbXz8Zna0HKuigr7vkxdm6AnTB14tjNimvh3e6+ZfuTjefNxSP5aXDt0XF0WNbtLhdQd0MGCDMtBxR4Wzu80yo+/Q38nEeqwLseWRY0EXsukg+lMJI/Cq2cCpbTCGztOTkOVzf/kG5BT7Zz5uMeh/t2F5XHsHNtnGwN13JqdCRuPz9Uh6LGo9TXeDupRtxZTWfrCpkqyMsnWJcFOk5sQ1zU7a+7ywD2pQvt1btU916prm7J6MoQ72jEcojWhtZWNE6levvgMEvrVPxFQLjBOAOblMGn+aKnKmo4sydqt3oqO3i5xVAbWeIfyd6/2kAozqhTYZflVVa9GfVaQFqZRUYZWYx93p/jwlHdq9jyU90D7MzcGgHoAmQS989Jw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ng0Fq4Vck5y6wTRCl6gY7VHf0niA3YEE4BiRVLllc2gjfXKaH8pNdrEyEF4dGNO0Vj27Wp5zubb0PG68vleuqdF53OrRm2b5sa2qUksxSy8NQ37BKG9HgsamWawJUOD6O4WSSPcn7RJUwM0RzwJc6seS0w15o+H8w9apH8rku1mDnVRi+x0BU8zsAhxyHQaERYNeEl9gG0oPH7by0xqUJb0HNZQN3B8tweE4R76hOaHF9rrPVdprPexmGXzYJgjYFHOJ0IS+ZqWnVZl1bEnIxyL4vhwOUeUqH62CkEpswsTIKWEN7V4Kx0sBvAC8aA1V8O/tGYsB99UAdmcBBtmIRTipaq3STMKGJv+2v0usQ5Go2gV9sOqsuhKnWSp1RlVVVESGbpa6PTfpyWvm83DOH/C1r5dpW1pWwudxhACFa9orqyj54vCJo3kg6uad8r9G
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 09:45:52.8879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f072defb-dd69-4d05-f5df-08deaf42177a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
X-Rspamd-Queue-Id: D0AA350B80C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286580-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

The commit in the fixes tag blocked VHOST_VDPA_SET_GROUP_ASID operations
once DRIVER_OK is set. That is too strict for devices which can safely
handle this during live migration flows.

Bring back this behavior under a new vhost backend feature flag. The
feature is supported by mlx5 and vdpa_sim devices.

Fixes: 3543b04a4ea3 ("vhost: forbid change vq groups ASID if DRIVER_OK is set")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c |  3 ++-
 drivers/vdpa/vdpa_sim/vdpa_sim.c  |  3 ++-
 drivers/vhost/vdpa.c              | 13 +++++++++++--
 include/uapi/linux/vhost_types.h  |  4 ++++
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ad0d5fbbbca8..f89177957c76 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2906,7 +2906,8 @@ static void unregister_link_notifier(struct mlx5_vdpa_net *ndev)
 
 static u64 mlx5_vdpa_get_backend_features(const struct vdpa_device *vdpa)
 {
-	return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
+	return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
+	       BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK);
 }
 
 static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 8cb1cc2ea139..253c7fb35ea0 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -428,7 +428,8 @@ static u64 vdpasim_get_device_features(struct vdpa_device *vdpa)
 
 static u64 vdpasim_get_backend_features(const struct vdpa_device *vdpa)
 {
-	return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK);
+	return BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
+	       BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK);
 }
 
 static int vdpasim_set_driver_features(struct vdpa_device *vdpa, u64 features)
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 692564b1bcbb..67b3f49fa709 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -682,7 +682,8 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 			return -EFAULT;
 		if (idx >= vdpa->ngroups || s.num >= vdpa->nas)
 			return -EINVAL;
-		if (ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK)
+		if ((ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK) &&
+		    !vhost_backend_has_feature(vq, VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK))
 			return -EBUSY;
 		if (!ops->set_group_asid)
 			return -EOPNOTSUPP;
@@ -791,7 +792,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 				 BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST) |
 				 BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
 				 BIT_ULL(VHOST_BACKEND_F_RESUME) |
-				 BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK)))
+				 BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) |
+				 BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK)))
 			return -EOPNOTSUPP;
 		if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
 		     !vhost_vdpa_can_suspend(v))
@@ -805,6 +807,13 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 		if ((features & BIT_ULL(VHOST_BACKEND_F_DESC_ASID)) &&
 		     !vhost_vdpa_has_desc_group(v))
 			return -EOPNOTSUPP;
+		if (features & BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK)) {
+			if (!(features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID)))
+				return -EINVAL;
+			if (!(vhost_vdpa_get_backend_features(v) &
+				BIT_ULL(VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK)))
+				return -EOPNOTSUPP;
+		}
 		if ((features & BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST)) &&
 		     !vhost_vdpa_has_persistent_map(v))
 			return -EOPNOTSUPP;
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 1c39cc5f5a31..ec1ff8a2e260 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -197,5 +197,9 @@ struct vhost_vdpa_iova_range {
 #define VHOST_BACKEND_F_DESC_ASID    0x7
 /* IOTLB don't flush memory mapping across device reset */
 #define VHOST_BACKEND_F_IOTLB_PERSIST  0x8
+/* Device supports changing the group ASID after DRIVER_OK.
+ * Requires VHOST_BACKEND_F_IOTLB_ASID.
+ */
+#define VHOST_BACKEND_F_GROUP_ASID_AFTER_DRIVER_OK  0x9
 
 #endif
-- 
2.54.0


