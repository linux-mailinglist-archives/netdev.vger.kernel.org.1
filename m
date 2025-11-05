Return-Path: <netdev+bounces-236074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43F8C383B6
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5233B95C7
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B9C2D5944;
	Wed,  5 Nov 2025 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pp9CVnBq"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39724221FB6
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382711; cv=fail; b=MLLo+3kbJwhbbc0/gLppYy7LKd0RaV/QDWxV8MQ6u5tgk1G4RzxUEx82He0Sb44aauOLZsrZtOzRh9actU/23opNcJVa/hIydFgW6xo8LBGRedRW4M/LZLsPT/sPQJO7NTVLs1YTl4C/ZLcSVSB9dFo7Nl6Firm4qIsL563IYI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382711; c=relaxed/simple;
	bh=u7RcDNGQndarSdXv5ZwAgwZE/8+JF5/Qd+uM7J3/upo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s56jQCIYQXUGrBcIsSA4Hx0hPTas1lpt5VEvgowwdn5hzzdTvGS6Wes1yGvzlDzjFdDJq0dqaSfvKftbKSF4G8dx0bzNf98isyQgOQpWMtDGd/xVtoj9gbr0O6kJA3T31SSVzGu3EcOYejHhmx3RFk3Cwoa816eK5qWDTcIwU9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pp9CVnBq; arc=fail smtp.client-ip=40.107.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EASn2CX8yTmTHMRi0KWDk/1dYvhnCxrpSp5IQQuvy6FSRHIYuGfHJMcq3A9qpJxV4OPDgIRdJabcmnKNFUWV/7NpQDY4KIUp1Frz99KiEjUZnostY8qcbNaRWX99PQJlSgEJJWekPyJAcQ4qcdQCif9lm4XfCO7dxdae3meR33gufR2NCTHi1SiagAp/kCPJVq+v3C0Ax8o0Ei5yw/ag7Q9DtVXRd5U35tvjkJ2U45xJ2xR8nQbClEvTBgUr6cfmR4QSpt9/x4oPdN7LoI/0GTE/y7I1s0XpMc95RkimUrj7jkY89XAjI8SwHvjo1Gxs9fBk4dJFrsPcQPPuLJ6P6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBW0bhGy5J4q3PBKs8cUEIqs7umGPNOZT9ZLimUPd+8=;
 b=pzvv+y8a9kS0nYek+ZRvipyLEInYKwhCnMrc+Xd/Pgwc8Kjjtrof1S6s5Zcixmf1jshJMg3+GGQoJRuFPSVVrrVo3CyO5/Ku0CA+sGpc+idPG59InYfdlW4hwbVgxQqq20/HyywUeBn9T87oqAq/IqG87eUiYZ6mEBFXMDTYq92gFbc1wLjFCrIxvPOLvMHWgo1BoNlsIsPS7P1NIgau6za7TTiipID4Rd+0I67z4sEGnu5UJVh6qa/AApjN9P7Hhvq1K7h4AiFyBJi8W0kZlRUOBuCm8QRUUQXMA/7h8F8XYQD2ZEu2nehHeRBVhWs+VS1kwXwJmBI9KRrU8Si5ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBW0bhGy5J4q3PBKs8cUEIqs7umGPNOZT9ZLimUPd+8=;
 b=pp9CVnBqIlDnwWiTS/WesKbSGof3TbaG6LSJ7ptegkHu6hBlAvjksJAmUtDwyfKW6/UDGO5MwSQLAjak25lkXtylugSSs35xPuYH7XAJC8kFdsrlRZhlsJdc0jBaNKd6b7D0tRj17eyRikkdgG/lCK+xqsYbSmIS31HU/AS3IUUy42pHCDqT0pzjEL5SIWEhv2lz93igCpomeHxf1WyPvmQSDigJOoyKgaDYxHsqH6hFg9hBWiBWOaFQ3tTPYuqyY2s0gZmFCTdYb+NPZ6iI2R6ONCjw5vrtlIcMV3s6rF+lG0jh5hMMduAR+FyKoVt+GfExs3U/lZkk8R/JfDLSVA==
Received: from MN2PR04CA0029.namprd04.prod.outlook.com (2603:10b6:208:d4::42)
 by IA1PR12MB8335.namprd12.prod.outlook.com (2603:10b6:208:3fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 22:45:00 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::3e) by MN2PR04CA0029.outlook.office365.com
 (2603:10b6:208:d4::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 22:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 22:44:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:39 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:39 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 5 Nov
 2025 14:44:37 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v8 02/12] virtio: Add config_op for admin commands
Date: Wed, 5 Nov 2025 16:43:46 -0600
Message-ID: <20251105224356.4234-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251105224356.4234-1-danielj@nvidia.com>
References: <20251105224356.4234-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|IA1PR12MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de1246c-85c4-4cac-fb61-08de1cbcf34f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D1PDMCkkmht4QSc8xzAp84bqXjN/TAVM+oMFGGs6Y2g+YAoqmKE8i+ilNzS1?=
 =?us-ascii?Q?oAK4ERJKBvMiCoxjVOhuWxK4bySzjjonDuJGTjRFwPVA0Tp+f13bR476pg74?=
 =?us-ascii?Q?p1q0QyvvfU2fnpCOMJxT4puh7L/TVauaW3uIjcd4qTJg9T4RBhf24w9f/sV5?=
 =?us-ascii?Q?1no2Olle3ivlDRKtpK2NYSQ12CG8HOOPp4+dse/u6qSUypZDrhVYWdh0cnR4?=
 =?us-ascii?Q?vUxbxKvVrRymQhVuXyvn8LgzxdR3MnF+T8RPMko2m3q/d9t15PIazIUphDhT?=
 =?us-ascii?Q?fIebYwesSfpKG/xGrS081/UA7bCPhe3S9n9g0R4ZlsScn0bOe2peLQo4gIO/?=
 =?us-ascii?Q?so/lRn9fMRAR4zFvcytmbZbd1tTNWhf4cH8f6Vjljp95MqvoLevT0IybSiJe?=
 =?us-ascii?Q?8520hid119QHLvyXYdrZfc7jmh0ynUxiZ+b2qbB6Buwtld0ap7D/00yMGA29?=
 =?us-ascii?Q?Ty5NSPmAcDTU/mNdAiuM9vMTRxPJZEP/QmJzesh63VThxK+fr7YaahNpu8ZN?=
 =?us-ascii?Q?HLifvi/z7gIChZerfWejbau8wb/toBaORbOL27pSbfw49EYqIDThwC6B4DvQ?=
 =?us-ascii?Q?ZmK6IQOMjmls5iRjp8Q4BleSPpA6eG5H0iQl8cRsDfKzXMzWKIUs09daQby4?=
 =?us-ascii?Q?VdCOH4UqlJ9ZjG12eRLt7WC6rASzijJ/18Aafawu5RQDP3sNVu985EPQR7Nh?=
 =?us-ascii?Q?ChIc5om6KNkIGbKuUC1Aj6Z8QUFC9+Rg4iXkD3OGPeafn45nJmhxhImKowHm?=
 =?us-ascii?Q?+Ns6e++ZXzmc+bAG4SDd3a1zfW/n7kowFhrginBCJuUl9Wvv8sE+3uidMvW9?=
 =?us-ascii?Q?DypgVsTt3tbnmtIl7bm/kQy7IfX3R/UFB7TebcT2JEXlYQ5paZDYBhIsKzoz?=
 =?us-ascii?Q?PB6xPSC5FSV8J53V6SqAdN+RTQtYB8THawjYYt62J6lc83bxdMqIihGZNq3j?=
 =?us-ascii?Q?Dhud0y/col3fBOYh0w6xk6bTawfzvLTmzseKWphmyAKo6VBjc8/TMKy5F1fR?=
 =?us-ascii?Q?3p42aIqZyhHwuBDP24vhLmIZwJU6eq/SDbRNCUSmVb7MMxWhKG06qUGQ0nrB?=
 =?us-ascii?Q?ZhqVvJQK4ulJKl7bwLXBhC+epH8ArPK6jZ5vVF85EWdP32RESu/VfszZPckf?=
 =?us-ascii?Q?vFPZCFbgveDpJODctfddodjE3V1iy/lyG2OT2UM5J/Rb4Jadeh0QrErMEk7S?=
 =?us-ascii?Q?onFLG3zgX4H32+S8XLZCD80eUcQnKtoxQfGqVbga8+6v0GFaGhzL/TutWdLg?=
 =?us-ascii?Q?yRYAhDkp05om/Nho7xXOx64smlDwxTuUUMOFhhc0usMkwvIetNnQE3CGej14?=
 =?us-ascii?Q?GWEWQdu/T61z57xmoOjokWUIDZZjdz5XKLtIhCsWtVAERuSmxMcGGPve2mKY?=
 =?us-ascii?Q?IN5tdWNARQWaV/LUpozT1la79EfnZx0LH/j+4gAb/oBbIs1JOocrQx7yEeoX?=
 =?us-ascii?Q?+ACmrqhn2ZFSPcQQR5anOOqye+0iEVPn8YXUTMHDrtHGJ7LxbbenANyRg8PM?=
 =?us-ascii?Q?h2FF0MJVojv8Tf/j7BltL+Q5k0gBxHMAemc35NlE+Qm0tiuGYjLXePSMwVpo?=
 =?us-ascii?Q?fX37mdvl3Rs4rBVSSwk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 22:44:59.3456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de1246c-85c4-4cac-fb61-08de1cbcf34f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8335

This will allow device drivers to issue administration commands.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: New patch for v4
---
 drivers/virtio/virtio_pci_modern.c | 2 ++
 include/linux/virtio_config.h      | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index ff11de5b3d69..acc3f958f96a 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -1236,6 +1236,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
+	.admin_cmd_exec = vp_modern_admin_cmd_exec,
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -1256,6 +1257,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
+	.admin_cmd_exec = vp_modern_admin_cmd_exec,
 };
 
 /* the PCI probing function */
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 16001e9f9b39..19606609254e 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -108,6 +108,10 @@ struct virtqueue_info {
  *	Returns 0 on success or error status
  *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
  *	set.
+ * @admin_cmd_exec: Execute an admin VQ command.
+ *	vdev: the virtio_device
+ *	cmd: the command to execute
+ *	Returns 0 on success or error status
  */
 struct virtio_config_ops {
 	void (*get)(struct virtio_device *vdev, unsigned offset,
@@ -137,6 +141,8 @@ struct virtio_config_ops {
 			       struct virtio_shm_region *region, u8 id);
 	int (*disable_vq_and_reset)(struct virtqueue *vq);
 	int (*enable_vq_after_reset)(struct virtqueue *vq);
+	int (*admin_cmd_exec)(struct virtio_device *vdev,
+			      struct virtio_admin_cmd *cmd);
 };
 
 /**
-- 
2.50.1


