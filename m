Return-Path: <netdev+bounces-256472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBtNEVB3gmm+UwMAu9opvQ
	(envelope-from <netdev+bounces-256472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:31:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A6940DF49C
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C215C30DC307
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 22:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FAA36F41F;
	Tue,  3 Feb 2026 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n5M2LcF8"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B29E37756E
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157784; cv=fail; b=nFqQwu7azShp7liMtxhkg3qUm25E280uF7fOJhtJW+1v7Pla23Ul7bO5GDwItGUrsqcBZSg+8rdusNCymJt17dmRynhhKkuv4sh6TBpRqmPkOkvECflXDTlROP/kzbaFVyS3laPyOaWDj9w63T3OrrZCeka2KcHboxxezOcVIwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157784; c=relaxed/simple;
	bh=nF5h3A/tw2Gys17FU/X8MrCGdO2+RXgLyajwOTdOJbs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5tThvzxvWP0fLlLm+ARjE8rDg+Kj8Kgw5jFxddzNLvqEioSL3T3Z6DXevNew7EDFeieDXTYDOVm48XwwjYy+UgIPpanueeZRoATZfSA3j6+SBp112HQsD9K/zdioxYQCFOKXcMa7NEnZ2HKzCszAu0AadX4s4oCvgrHE9Xjtss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n5M2LcF8; arc=fail smtp.client-ip=52.101.56.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrqVLsiv5vbbOYJYVKSMwCAERAGVFkHl0Xb/KkPMAb5Bwv1nMyTzs6hfAE2KE13xp0Vp8Yu2paCNu1i5BQvxIAPbqetdFUMtBnUgrk++G3vMD1wUuUS1SiVfoMlkDsHwECf3AE8D55C5J37uE4yd6EFu+OCYyAkQTHwD/d+dvqBjPR5jsDqRPIPRR7g28kCow8acwGZlkdOjoFfsFDdWndy4nxcO0KDgpJ9NsY+WN5mF8jN5pIgbjwW0bz0UneyBPgKEaTEBHs4dn3KpHvZliLStPFOnoq6FzJtOhJNpwmU/ym8Xd0nLLxM/66ycNLBlCgteIQmtXEwPAm+M/WfiuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9NOWlc0PkNWSwELG8BO4lW447QfDSQN/QKqIRn8mKQ=;
 b=V8+7dq4XEWLr8gU17EFRx09yeY4OfrG0VeGgaWPD2R8IYs7y/hgkLO9RuhxzS4u1dARg+EA/uYbZq6quHGhFKY71SEe/bytG5IvmjRQ4P1kEeSDTD4BfJF2hfo0fp1Niw30j/iU/4AgM8JJQEilzU1TIYP8A3uPOGE14qBhIB4x8tY759RhKrjThoHYpygQWCW7lXJTw/yKleGA7R9tyfp4sQW9xu75tXsNaAfvCEDB6tIC0+52jFQttfLTSVmZQ6g+MaVdG42trJJOMJ4Nyc8XWtVfY7EoteaX3Ls42QardKaGmaktcJ+uBwqhhIX/UgKHJ4puukbKeawhH9eoESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9NOWlc0PkNWSwELG8BO4lW447QfDSQN/QKqIRn8mKQ=;
 b=n5M2LcF8qMJ90Da5Ro23o2FiZO8eo5WwIplMd7SUpTUn8lrJvh+Z1yc9SyCph5xDA0SbsIKtTbUYEG8EFQP3S7KbN4XQFwJHnLBII8J++EYFHIaQDr0SlhGbBac5O2/OdOjRJ6YNbMDoAD7mA8w29CKBX9ps658W5yRcjkPWjchwESGtrTOZatpCTRACJLKTKs6FuoTY+STKwX8xjCMnYIt0GnwduaC15VmwYhh4UuMv/ychQGZlx3edNNYf9HavG2x9vHJLMdHogF67N9LEwJ9HKtp1MBzc5igv6LiaQkZpd5gFx7h/DImq/0Xc+3HfV//fOYVs+tYRRSA9O+XxPw==
Received: from CH2PR15CA0023.namprd15.prod.outlook.com (2603:10b6:610:51::33)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.12; Tue, 3 Feb 2026 22:29:32 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::f3) by CH2PR15CA0023.outlook.office365.com
 (2603:10b6:610:51::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend
 Transport; Tue, 3 Feb 2026 22:29:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 22:29:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 14:29:14 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 3 Feb 2026 14:29:14 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 14:29:12 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v18 06/12] virtio_net: Create a FF group for ethtool steering
Date: Tue, 3 Feb 2026 16:28:53 -0600
Message-ID: <20260203222859.4219-7-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd98106-4a3d-420a-7584-08de6373b3e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2HUR0tqzcx8ugiFSVyK4auftrFpn4kAbidDVqmBGuIYa4Vi7Bq0N55jP7gxO?=
 =?us-ascii?Q?r85+el5/CvFI+VKnaJArpzgBxXeIdVTkM3/pxkPgoN9oNoRRHtYbXlX2WZKD?=
 =?us-ascii?Q?U5FU8yWxooOOtjtHPP0wuMhF97XsqGjL19KeKS58/GNow9d3BTzz4WyhXWjZ?=
 =?us-ascii?Q?ibUV5ooH4x0am7o4BI1mK5nDUvCy2BoiXs4wnM4vQnvafCdPBu4ctSrzS51G?=
 =?us-ascii?Q?NoqT3QNJqPSpOOI3cL7lQgDHD76VzhNbsMJkUmkVBQd8sWl6aegR/1LKUNse?=
 =?us-ascii?Q?gKmWuzUepSQOclS/94KPIddC8Vz3hVEeZLvw99UaXK48zUBxMsA99VtGx898?=
 =?us-ascii?Q?yqhjcVntWC6YPKeH0olnWLzTKLEtxbUpfDMInmxAziMr1IBpJ1AXiMQaCRk1?=
 =?us-ascii?Q?6RnqgUKm0TjStQujIAkutXiQ5bscVf+jfPtNQ7pJk6l3MC+vYJtgXGCv1FWk?=
 =?us-ascii?Q?zuhN8A/df1re0f5Oe2x1tQuBjY11OZtRF1pZ2qMSZ2yBA2p+JIr8LEXpCaFw?=
 =?us-ascii?Q?cJtTsJ5sfAZMrLsjWkajBUQQuL4S+4foxt8ESCPWwJd8xN4H5wZACyQ96e0K?=
 =?us-ascii?Q?6bjMikMvsjoNBvEZH2pGHde8kqSvSN6FFItIRalEQBeLEoUzg5hIfpTKC+tm?=
 =?us-ascii?Q?Gwvvg6FUMWNLmP4050k9N1OZRGEclRmIbhbo4yYap3pWGt5o+H3ebyjODhz7?=
 =?us-ascii?Q?3bYdoi9amG+vcPKE12cmArpV7FmFGihrGanzUu9Ny9c3XcNkHVyH+BV7pEu8?=
 =?us-ascii?Q?ayJpWijGrG5H24/NHpo0A47eoeJbuua9TtU3vTDkNkA4WPmtBAeL3VyNSGKq?=
 =?us-ascii?Q?080BNt2NED96GKffBrsb8xAt6URb1/W+dEC3k9QeyF7dqkEfdxU5ksXWmDtU?=
 =?us-ascii?Q?r6LAxNsZwelL95VlmoGQnxe/xJ1kNQMzbNrFPYdHMnEklya0P4pIKBrdD8LS?=
 =?us-ascii?Q?P4nk5PxesDbQLz7+3EClQL0lXhjAr557ae0RhpwW5bwy9Fmc//E8C1UZeME/?=
 =?us-ascii?Q?RTk/F53Ub4zvuSx3rfP2Sa7pBg6PPJbn6BeWH3F1PvuLsj93WjOFCkjz59nw?=
 =?us-ascii?Q?oRHF7JlD48tnH99n6VrLKrRRCwH+B0Mww4dRkAjKjZ+/vMZwcLxvI9ZPQflu?=
 =?us-ascii?Q?qYZoGC9ScaeujO1TXBBq1ZbHoUnoiNYhlhaQJ6T/KvbglB47Ax3Q+JgE0AqU?=
 =?us-ascii?Q?UqUeXJ2ZG/QeaSd+fsds0PkyybtRKxww95jArNwGgPBYjPdXkoN7a6NIB0y7?=
 =?us-ascii?Q?107g7DLI2gkri7vJu26uUXjHoBPEN+GIPVC1rVfVjI2gK17UmKKJj36Asjuw?=
 =?us-ascii?Q?2W1EFPps9qlZVVzW9qhhgHji3KGLt+ZfYidFbigOfhnKiSg+6/gzq4Aeuz9q?=
 =?us-ascii?Q?kMTxiDs1SSIgeSZ5yI5XV8a3QeV8cvscIl/ZzUlsf5hEZIfqRtrk+zgZ0K+Q?=
 =?us-ascii?Q?gWndiq89etiyADVXKYBmACuOMhZd+iGQ/YsrRclJvhEx6mYEcahq4sgA8PZk?=
 =?us-ascii?Q?KKIz7vldA5V54w/ahdd5QynY68It35hr0NZRqwHWp7F0s0q9etyLnzMlXAcU?=
 =?us-ascii?Q?R7C6CK2dpWMUHxoskycU490IFHiF7MtdEwe+FNLSDhZxQvpAIad0rgrya446?=
 =?us-ascii?Q?6FjPtG0/KVI0sreik/0U+uVQEurAYcVh8cHV83/5mvxYBgU0Rf5AoAtcebrY?=
 =?us-ascii?Q?zxU73w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E78b6BT1GRZ9lZEyX/sUJdDvPT0YuZoYEguuvQOlKtsP6N8ZaqaNX4ufM2FnJzuFU0px2R8+R162bnx+d5gqoceRG+IOe1nqTupLu9EOIlEO34SRQfZQa+6oGtUMGqF5IApmh9XVoXiB2Gb6/3YbTdY066S3ngBAtLjLBR6e/mWs7NWbNVUdtNMpoaliJGXhYWtj7dquCloA3vlsDlIQisfR0Ah+QMsTcziSlj4Ls98nCVj5rw3XG8yUIah3Y/CKyvbY/HlBpyeEViZk8WJ1p3DsnaE4mdjTqdUWwrpDxSEFQnu95RdYBNB02Hz1I6pINzEtpN2FlNeYW6g25CitxMBZj3YAJBcZpVpxbpUkNqmg+Ow34fTk7LBkalWBy6HB36EILLPRKIDNl8ibv16XR0VKCAT2MpdNhDDpmRFu2dNRb6tyxlKgVx6OBvQx8I7y
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 22:29:32.2906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd98106-4a3d-420a-7584-08de6373b3e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
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
	TAGGED_FROM(0.00)[bounces-256472-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A6940DF49C
X-Rspamd-Action: no action

All ethtool steering rules will go in one group, create it during
initialization.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: Documented UAPI
---
---
 drivers/net/virtio_net.c           | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h | 15 +++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2cfa37e2f83f..340104b22a59 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -286,6 +286,9 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
 };
 
+#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
+#define VIRTNET_FF_MAX_GROUPS 1
+
 struct virtnet_ff {
 	struct virtio_device *vdev;
 	bool ff_supported;
@@ -5722,6 +5725,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
 	struct virtio_net_ff_selector *sel;
 	unsigned long sel_types = 0;
@@ -5806,6 +5810,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	if (le32_to_cpu(ff->ff_caps->groups_limit) < VIRTNET_FF_MAX_GROUPS) {
+		err = -ENOSPC;
+		goto err_ff_action;
+	}
+	ff->ff_caps->groups_limit = cpu_to_le32(VIRTNET_FF_MAX_GROUPS);
+
 	err = virtio_admin_cap_set(vdev,
 				   VIRTIO_NET_FF_RESOURCE_CAP,
 				   ff->ff_caps,
@@ -5852,6 +5862,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
+
+	/* Use priority for the object ID. */
+	err = virtio_admin_obj_create(vdev,
+				      VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
+				      VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
+				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				      0,
+				      &ethtool_group,
+				      sizeof(ethtool_group));
+	if (err)
+		goto err_ff_action;
+
 	ff->vdev = vdev;
 	ff->ff_supported = true;
 
@@ -5879,6 +5902,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
 	if (!ff->ff_supported)
 		return;
 
+	virtio_admin_obj_destroy(ff->vdev,
+				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
+				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
+				 VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				 0);
+
 	kfree(ff->ff_actions);
 	kfree(ff->ff_mask);
 	kfree(ff->ff_caps);
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
index 48e14afac195..1714a2c3d8b1 100644
--- a/include/uapi/linux/virtio_net_ff.h
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -11,6 +11,8 @@
 #define VIRTIO_NET_FF_SELECTOR_CAP 0x801
 #define VIRTIO_NET_FF_ACTION_CAP 0x802
 
+#define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
+
 /**
  * struct virtio_net_ff_cap_data - Flow filter resource capability limits
  * @groups_limit: maximum number of flow filter groups supported by the device
@@ -87,4 +89,17 @@ struct virtio_net_ff_actions {
 	__u8 reserved[7];
 	__u8 actions[] __counted_by(count);;
 };
+
+/**
+ * struct virtio_net_resource_obj_ff_group - Flow filter group object
+ * @group_priority: priority of the group used to order evaluation
+ *
+ * This structure is the payload for the VIRTIO_NET_RESOURCE_OBJ_FF_GROUP
+ * administrative object. Devices use @group_priority to order flow filter
+ * groups. Multi-byte fields are little-endian.
+ */
+struct virtio_net_resource_obj_ff_group {
+	__le16 group_priority;
+};
+
 #endif
-- 
2.50.1


