Return-Path: <netdev+bounces-256467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCwREOp2gmm+UwMAu9opvQ
	(envelope-from <netdev+bounces-256467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:30:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AABE7DF43B
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18A9B30AEF9A
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 22:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF16374723;
	Tue,  3 Feb 2026 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oYTzvOkz"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66514374179
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157774; cv=fail; b=EBGlzqTMXfO0dcSH5M6MpgQj9CM+OYxyNQgnWVA0+Q3gzio9/dAViBwdoEUDa/EBNS+lck8nNOAIkGaTwsZMHVZhA5t/pMOq9Kq1lbsaNx85zfw9FanFnnYxsv713PcwCK1KZ0bVUFyN8IGpFAEo5vG6VOT1XiRu4XFBV+ruS1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157774; c=relaxed/simple;
	bh=rV+BYBScHZrwQo5VCoLAB9GLWd98W0R5QYE8DpXG300=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2zeV4YplrvEndd3NLPP0DkpBESESXQMro4owka6rsNMsrZQCUijjKGiBE25G4B0obW3A9Qa6/1O0FH1CTWyN/eFMVK1Psp/fWZ3mhvEo+sW77YgvvzdUYSHvexS+zg8OyJ0oURMX/744b0hLJX8Co106sXi0awAzWpSw1nmb9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oYTzvOkz; arc=fail smtp.client-ip=52.101.48.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNnkkMtNdaNHh9AshMoh5H+3Kr6UV3TtKBFkBE0ZcRYKN5Ga75XInKt7fC9yZTihd0+5CouD8U46Jzaq7FDWXYfmAH+hsy6Y7o8+TA1XJpmG0fhbdMFUIw8MNheAjPJ2O2WDFGx4V9IXSjwUsJ8YuML7aG1UaiBnZNL29D6S4vMJkLuT/Cw2Id1GIQ1MuLJ8N1zsFgTljmPaSDoGMnUnSNkKYjt22tUV9lwlpdUYRfgcYIrN2/gVA0+NG4MA7RBXRFg0heuoCYjnAUgOPX3BP0miJ3AWLqErObmTN0jBF5jL+QRFlFFGgo0josptYRSHRVxuigGGIlxakJlRsh7SLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R38e6nZvYGCaJHSLMq/L6GLkbMDDeQI+wiK3nJXoLUI=;
 b=CZl0McInMBCDNCL+GSc2wbsJ8j7u5i+jIEwxyKUsmxKJK1aF1CcIPXq3L18bGO8l+2P6pNlAYmGEwAgJHTifhmcgj9H3mXMxDq+5XhU52P4++3TQS+XmSxu6CV/+BVfzd1BNynIjNiW4jL1uFb2JIWJLRKfsHoVelr1hwM53TUYh/sLkkzzI/4dXtRXvwoc4/avxpwsvGpbBSbHq/MVdWqW6Sc81SWuQNWfAKuh2TNombQ1sLg4VtaUTyiJL0ceIKlnjQbnRJvz0+CkyLeTgqeSUx/P+YuPqnt+g26xborrmoCShOf99QML9UbuO/0mB8OYVsH+TW+K8Rb+KAmT5yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R38e6nZvYGCaJHSLMq/L6GLkbMDDeQI+wiK3nJXoLUI=;
 b=oYTzvOkzqvC2uRkfZKFYLKH+k2tKdWHNh8pIp2woXn+KQpQql98ZOzhUCP3Iqr/m/37LWTwclOeYe8BVenJ7CIlkGT/f5YQIj3HJ+v0Zs3X1IeF4qKOgM8lEbWVPX9MfBoKV0F62Ur4v02mYSUUsxFA833OdHHF9NTFCKsQzbxpBp3TFlb+hRoPZItZwp/nWkO1m7EbYn5UKVGViXs82QQK9VJpUdpXpy9M9cUF9ysiYRSg0f6L0ZfMuykJuChQkh2u/yzz3PUj3heVuj5gmet8576hej/4ZxTtmVC0nxI62oAVUZ7JKV4Z+IfoyaY3dX2Fvt8vuqmTxgcfM0d1uhQ==
Received: from BN9PR03CA0243.namprd03.prod.outlook.com (2603:10b6:408:ff::8)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 22:29:26 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:ff:cafe::77) by BN9PR03CA0243.outlook.office365.com
 (2603:10b6:408:ff::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 22:29:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 22:29:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 14:29:07 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 3 Feb 2026 14:29:06 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 14:29:05 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v18 02/12] virtio: Add config_op for admin commands
Date: Tue, 3 Feb 2026 16:28:49 -0600
Message-ID: <20260203222859.4219-3-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: c929284c-03d0-47be-408b-08de6373b040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3JdBb8iLK6BHYHtcnXQ/+CEcDkYuKExmqr6Bn/PVi1MIUCCgciOKU9iPbPa/?=
 =?us-ascii?Q?20KrTVKY5OCpTZmPuKS1XEYz6sXMCo8JurJC72/KKEKnewqu0MTpAEHa4r4C?=
 =?us-ascii?Q?1ju1R6+rA8Z+gZk7I9ZQwTEU/poXefnoQwE61oZRVDU+NBsBuQrZqjPA82ME?=
 =?us-ascii?Q?+oe7I8pM1Z64Ls/XbKbbYHk7oRoJv1+J544h5E8IFbKjRZfnseAga8ITgEWN?=
 =?us-ascii?Q?6HBmx9hf0YfBMRpfGPhokax9CVuPEeGOeRcB7mJqCn3TKvZIvV81gRZ+6klb?=
 =?us-ascii?Q?Nhshqw17duYEAQELPR4hmPXjveK0dSS3zrP6mo/4vrW3YA28tARWeu3gl0Oc?=
 =?us-ascii?Q?2XvWjTrrkCEs4PVUwaEMqok7NzwXVLphS76Uu1uYJ9toRMcpUWWJQb54TjuM?=
 =?us-ascii?Q?/ZuJhoxjcV5PMOp5QG3qDA16SK7JOjP+8k5rq/qw/bDrnjDHVcYvGunqB/gJ?=
 =?us-ascii?Q?yRH4y855+sOt6jHCdZB/nmOtSv66oiUCuyOOcQbpgEhyZI80x0JjffYNOXyM?=
 =?us-ascii?Q?39fjSpQkkR9ezw/WBmYSg/sDe46phAsVvswucQ+7zRK5chiaPaZahN5tttkW?=
 =?us-ascii?Q?ueENZ1PuIG8lqyhIv2eUdlzw6FhdXQiJSrjQ4YIIIDAAKJShVoPn7BaeTrfk?=
 =?us-ascii?Q?BLkur0yilu0pZNAJOcBEVzEtH6QPWkNDJi+vMdhWfrxzno/Qja+4z+RcA8Cn?=
 =?us-ascii?Q?QZfh6S0XOREXQA2zYNcIh1phBei8gQ0M2/sAMraRX/MDkJn+lEgME/uePue3?=
 =?us-ascii?Q?w76g6xXuZqhBHteTpx2AFQlgVVEzvXnbP+Rg7K10geAgjLJkD/U6ZCUxiYAX?=
 =?us-ascii?Q?gPmx8flUw+WzIPmShrgx9bmpe3byNU20Txd0cqvYIYpsr6w0wvftxRG4BQqX?=
 =?us-ascii?Q?YVwCM9rLQHEhmn4YqSJGCqwgQLrgi0L6IfIqKBa0Dfz65kRdecc3TpjePOCu?=
 =?us-ascii?Q?6FjQEnwGzMRxe/RXzqcsnAJF8BTEeNDoKTvIfYVbT/pSDJ7GTKbxTaQ8maz0?=
 =?us-ascii?Q?z1NG7YnOEeRW+hjjGHysEUogd9cWCOdvJOy0pAEoDYWQbDqDec0YK1Krc00I?=
 =?us-ascii?Q?RraQbrWdjB2dtlQFLujZi1o/4IxgDageCd8ZyLT5DPOyyNWmKXvh7Pz58w57?=
 =?us-ascii?Q?atutiDjC8HjUe3HlANVwbZAHqkiAGMC1PbOGFZq8VG5R8CQ02EwYzTwJpMY3?=
 =?us-ascii?Q?6fPHBPz+WZs6sxOn8JsDy7+5+BQP1rU4iG+rVNpl6YkZXwl2TAsc5fACBotl?=
 =?us-ascii?Q?WOPDWP6E1Qb3uHq+46GAWjJIeLCFjeObRVmawrO8k8LYkeVDPHI62tGUP+ge?=
 =?us-ascii?Q?HJt0gAqcwq1+MowxqV8T4qsZTTlNhnn8gASbApVgSa+DqnQA5QQjqPnF4ri/?=
 =?us-ascii?Q?Uhpu1tWPSM8ILTbh2DuL2g7rCMc4WR/U8HRyNWp5DWNvSzJqSRkJPCHx3NpO?=
 =?us-ascii?Q?8xNafM10aFmWzCA7OLQ2E3tq4VSeTvi8UjflADepIfSDRZ1jx+Xg8pL/oTtB?=
 =?us-ascii?Q?B6oQXvKrYGhSy1S985wlK0MdYNi906cUohSe3piAKp7qwjbIMFk8On5JwOR7?=
 =?us-ascii?Q?HMTDkeJuG+5CujOVUDN82mHyW10MKbDpbhRwOXy89p+KuJaYy1d7UWJcWGMN?=
 =?us-ascii?Q?RKX8QyH3w8wutAC1gY951jiBy70DGMAnwgRiGm0cH3kiJeEYOcF5s55EsUN+?=
 =?us-ascii?Q?CmNNWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E3rcCn+cZxvRQP79o9MOs0Jvct+yA69ZfzPGmjGTiznOYYBWTw+DthUIQaFmDvyOpQRmd4yH3P6baGzAn2SxE9ugWoLdURqm0BYDck5NUu+O5s31EFJh0g+wureFNJBrWoO16h4GecWi4MUdrEF3cyD+Cn56rwbaO0zoFRdtpmzBYRfgefDaPQmmb76BeLv2Qg90k9Z/U2CAkwg5xVXvn21vNoNgViQWwLWU8ruuDyoL7mAK+h5xUPBKLe4IRLE1xMYRIw7kiSZFE5VgEK3YHkSZP91zoUpcF5gxagFWUU+SHm7NhrrO2k0Bl7UkgFmEWB4E6T//FusqIzJeott9bDREmk2nlv/vBhBKWCFrzCYJVHPid3eWFWG+T+ETY8aK7F/ZJpUqKFBpchkG1jSGBezSqKcw62F7OLEqEu+HkgvMkk3cpXCayM4KYbwdIQ+e
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 22:29:26.0748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c929284c-03d0-47be-408b-08de6373b040
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256467-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: AABE7DF43B
X-Rspamd-Action: no action

This will allow device drivers to issue administration commands.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: New patch for v4

v12: Add (optional) to admin_cmd_exec field. MST
---
 drivers/virtio/virtio_pci_modern.c | 2 ++
 include/linux/virtio_config.h      | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 1675d6cda416..e2a813b3b3fd 100644
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
index 69f84ea85d71..e36a32e0a20c 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -108,6 +108,10 @@ struct virtqueue_info {
  *	Returns 0 on success or error status
  *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
  *	set.
+ * @admin_cmd_exec: Execute an admin VQ command (optional).
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


