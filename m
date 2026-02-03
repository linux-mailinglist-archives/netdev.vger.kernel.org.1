Return-Path: <netdev+bounces-256468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJOGLOx2gmm+UwMAu9opvQ
	(envelope-from <netdev+bounces-256468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:30:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6949DDF443
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7859330B051A
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 22:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380C3372B24;
	Tue,  3 Feb 2026 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QDC3hliX"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC83371070
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157774; cv=fail; b=Bg2iI8UOs/W3WC101fP+Y360RZKSBiKsg4A0Jt6b6/3tCV+IYsqPfGGPbZIO0MwHgPF5XRBmQ5BDt3p7E0ayzxeZFjrdDSnjEZtnlMH4oggYcTezdKG025yr0Ych9Fn+5FGCAr3+6oCAmrVzHQMKr7eczNf41eEluiTOTJoU11c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157774; c=relaxed/simple;
	bh=wsGUHq5OPVhfOEtt/rMv3q+JFLZAeVhlUX16tLUzxUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQrLWoi7sMoxYw8j0+CK2XzuX770YYLldKXOxGCA1d1powHnDb8YCUUtPqe3AxZ7AsWSSYPMO7TI+qNCObS1OiwKsMvbNtXSYW9OrpSHEa7yf0N6fVIGKQG2JsDLS4m2ykvdX9Wc2ZPqGVzuOC/ofcn0Q46x32SPgZgMY/dE/bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QDC3hliX; arc=fail smtp.client-ip=52.101.61.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWo7pBNnf5nKeDNFxtqqUrI9DrWIpwilSmmPCkbgPeJPbfcKwoi6QeW1HT49vCZxNT9ILnxNS9TW/yLOiYIU4uc692mUeLTi/FNKXBMN3PL6d5biy8fG+K2vCbQMsmOhJpF1rFcgNWdxJmqUiD6N3Z94vC7VO4RvKFXJJwWQ+4DT2tieWZidutPGhdfXmwcNpwgM4PUVJk/A3IikNZzqPPQT7GVto4LGPMlFk814uVNgHXP2HvA0ZgL++wutYzM34DMjuv+uO4GvG6wb2kzuPiWpTDefjIftz79MRO/3BdEK5zBvdI8sryeQfjgwyTQTpB81EjNDOpx2EL8K7gh3Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlJi7cDaXABF4XlI/hECzIo+dxPjFTo6en3eJYwHZIE=;
 b=t88bfO/viaaQ/qXkLLUh6bJM/1VHHcyvtToZS8aQCuf/XCwOE9qL7Qm9BSbn0j3/6+x/HDb/IPy4NffkUWbHPxFpJBylmnha5Hphdfv3B2X7VREj+ibnZSXaR0YQDZzSroscWIA758ks9/9r4K9f5TcT11Mzj+IfGtFAmK16MZf2usOcTiKfGkts6eK+eh1ZhRo6IfIoGqHzZQL9u9YLny7djepU9S1MLVlVxurVeYsPw+1uXIqr8goKkM8LOv/+Aj60e6wNt0AA4YwF49x/iapwctQm0FonpwGaYY52qWYjB6wT3CRuGKklqlh/oWeDER49MSw31FDEf6yFibAwPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlJi7cDaXABF4XlI/hECzIo+dxPjFTo6en3eJYwHZIE=;
 b=QDC3hliXnuBX/1T2jm9hR4Gq9tABvgDJyEVX7rXfmFBw3LKyi8UG9i7YCDvGip5+/mNLk2HJcCC4svNkDSJJ7SClAqel/vrVPbsrvl+GUhTNZcWl72QenB/yfLfSC2YqIeyN1CZx+UAGx3f0ffeBl+r/5TsB231O1tb0gUY2YtFIkym9R2cDaY4NvcBYK0R2MUnZ5EXVsT0aFtXzCUv5630IZjPbDXQju2SY6IgrC+SbxKzzk0hfklGWVXNeqjyTTrcHrfPoA4Zj9ct3OXtLf/OBo/kksG3Xh+MORyUSCa3rahy+sm2L9yvVf2JHtO571UPoZoFaEU7KA4HHxVsZPA==
Received: from BN8PR04CA0040.namprd04.prod.outlook.com (2603:10b6:408:d4::14)
 by SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 22:29:25 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::80) by BN8PR04CA0040.outlook.office365.com
 (2603:10b6:408:d4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 22:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 22:29:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 14:29:05 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 3 Feb 2026 14:29:04 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 14:29:03 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v18 01/12] virtio_pci: Remove supported_cap size build assert
Date: Tue, 3 Feb 2026 16:28:48 -0600
Message-ID: <20260203222859.4219-2-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b0f9317-d6dd-452c-360c-08de6373af5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sAPv0s8Fu408dbfwxk3zFRvlmNW7qraCH3OaGuVW/NoTrsKS3PfxbaPl9ZAn?=
 =?us-ascii?Q?EUPiYPoNnFG9yWJzAw6xUWhSWAyIEud2k9LhYFdCJMbwN8qevqYGdKv7RmFN?=
 =?us-ascii?Q?V9LQEzz2C01wn+FLzhOQwH/ZSev+08LfkCGJDamfFnFeRO2CQH+/Vv3ta2ww?=
 =?us-ascii?Q?yS9877woy7Le17WuGUJ9RV5qZZtbug0/b8yVyhegFx0lm8lg+mvfz8LAIWI4?=
 =?us-ascii?Q?dOLQPFFjEkUaag4Bc6LBghweLgcqtJG/5rPOhEE61bGEhzf+xMZEsPj58G3O?=
 =?us-ascii?Q?CNtALeLbHvi77vagA0PeWVrI19ZZ5zNhLIPedwGih7Xu9PJ6Z5Z4JvV0Zb6p?=
 =?us-ascii?Q?+yAbis7wNPeTS4bPjvjwObat1UAMWTDzb/KyP0VPaQOO/KLdMXXyIFwln9wK?=
 =?us-ascii?Q?P8G1yQfFmMEFfxB2R4Qag9wg81akeShPtNy+K4ik7kkhndgEKX3hDZI6rA64?=
 =?us-ascii?Q?vPetz3XwGp7hYlD8sykPXpoeKNntW/DU1uGJJU1MGAK5nGqjVmfiG5ZjJqdY?=
 =?us-ascii?Q?kUbrK0HfqFJ2zP1fOt+ryksLRyFBUPYP04LykCFuBZSfW9m5ZVJIgYNQhaO7?=
 =?us-ascii?Q?qIb0UYGCUps686u2w3d+RYKbdX4EWf5leX/Q/y3je62UcKISm2z59I2O66Bl?=
 =?us-ascii?Q?kpAQOzxHT4b0i/p8i8E3PA8FQxkohpUCy+8h6Rq33DsVeTsz85bkMNXXX9NX?=
 =?us-ascii?Q?+2NbA7oXs3UfjHHYMKPCRXuEGYTvYW/dCqpTlBSQ3vkVvw0hdNbVkFBg1Pbs?=
 =?us-ascii?Q?eq+sV1pk/N6TVn4l5xHwbqiS0tBEnK/tygcEveaXAQlYTi4PCoSpv518L5sK?=
 =?us-ascii?Q?XpfIBqLMo50nvqoEJGqRC+OvDrq6W0u69pdSHfNSQaqzpIyJIXFA7/jEoqe+?=
 =?us-ascii?Q?nF4E35VyTVzMBhs7QFSk/ADk6ltSGvNWJlT1KZTRHl5G06QrrEvw+nhH2lig?=
 =?us-ascii?Q?9PdV4trFP0FenB+56Ke7ca9FUKXa6r3REizsTxH3y5oz9wb8f/zebACfEmJt?=
 =?us-ascii?Q?hh/aRAZGmr+pYzvfO1j/5hkZrsnzJODjltX4QgK/pp+krPfpoPF04jwVBIu9?=
 =?us-ascii?Q?Mz3+Sd5PPo7vPOoNuqSGaUXVQM9Qb+N2uLMHE/PfW2TfSQ2IJ8U4FwtHXXKi?=
 =?us-ascii?Q?k0tTowc/X/w0lvI2taKAEqV7iTiXefqj8Mf0prAJdNjvcUDuz0+f2vlcb2gA?=
 =?us-ascii?Q?8Txr+M1Ct4xwAbI+L2fuLRWY7EA/h89+4b9oYWL5hyCQi0k5ra1kgbr0L1mn?=
 =?us-ascii?Q?DX+3pePG4pUK2465UXSrIjS5tXkiNvtz0U3q3vGJNL6yhkzLfkx1x0xuRWvm?=
 =?us-ascii?Q?hc1vGWJAcona0KHqoOTXCC0QRUqzv6xqOX7G6rmctmvOrWdJRcPqDOJr4xey?=
 =?us-ascii?Q?u+Xx+XcAUKD+6R15POVlaK6ZXAIk1PY221SxUAHDK03IjEVrvecsdEimCBOa?=
 =?us-ascii?Q?PqX0arrtqFu3Uq1oFcpY0xyWB9oUNqh6QNhOpzVQdaGXy0UbI81RQK/hWO0B?=
 =?us-ascii?Q?DmkCPWWXlUybgRm6lwr7vs8FXnlq8Dm+LVmdiPnxWWhH7+psGO4FQnhEaDmb?=
 =?us-ascii?Q?R/YyugIozAsnO1c8V4i8wWoGr53PgbM1GRdOxLrV4hl5HAwsWcF+WhjZ/Ib4?=
 =?us-ascii?Q?5wNW4kUNyLBgdhP4jLiJS1DghVrIlrJEePJuMcc5cK01LEoPSKALH/PjVkBJ?=
 =?us-ascii?Q?F7FLag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FS1G64JQdpIZB53gXBzi1MsTdzvYmf1k1mTbeWWFEFhJnXqkThMAJjsKV0AjPKc/l6BV5A/NogSuwxyQTRvVUsSq5DWe/kTkZcAVYSfIeE4a0OHTISYT3ka1agWRW4zTZuEQhVcZ1dw/4JGvLKu/hTAXUl3EOBdJd/6FQEv1e3it0W0JOCKVbNYRvVhr1somNvOITox5kpJfUKFPnTFfoSS/HZFRIs4Iebtb9ssaAM+JodIukISPsQwqqMYLUsWJgu9kHinwVBYaazfsjmSc7ZILBRpQpyJOzNxFypS9QpLmdhF1TmcZLJc7w0IgdEuVrgdIXAKyzt8iFOBnD2XvB/xh4e5839HhMpWAhoc9j3G6Si8pDxYF/9nZFy+SBexv3NxsPeDSP8/OIkxKU6nvp4yNRuYzlVZXetBPcLbEJmHsG2PxYaqcdlnDGXiHbuLC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 22:29:24.6022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0f9317-d6dd-452c-360c-08de6373af5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895
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
	TAGGED_FROM(0.00)[bounces-256468-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6949DDF443
X-Rspamd-Action: no action

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


