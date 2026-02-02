Return-Path: <netdev+bounces-255951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UARADPHbgGnMBwMAu9opvQ
	(envelope-from <netdev+bounces-255951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:16:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6D2CF745
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FFED306ECA8
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 17:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633A5385537;
	Mon,  2 Feb 2026 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oc1jW3QD"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E593859E2
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051988; cv=fail; b=aUZV/+ujA9iMhxcraGEwPJkhnbdaEgpyPoATPp6lCgfmQMjILGWWP/Ixld0jhqV70SfPkGj5Gz2pRXqQQuXPw/Yirk62b93XnZDPvvviVDHaaSbTYWfqZ4klu++tTs1C1na3ii8bJBwkJJzMzpc8KaabKiQk9BzPCGg26FcptF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051988; c=relaxed/simple;
	bh=RXSxojy9591tTJMk15aqparsr+k9FoKY44lhxI2dthc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzXwSGmZVdmu4U4twVCziA/cZoZLLuIleIEIXXBU5OvEwYEeprZAx4MduFzPGhFdjpOYXrJuCpoG+Ng7/4mulLO4LeuPZVTUDsiBjFgna1KiI3DVtuyzbitWiDCXGysyZZP6wuYRgNdKZc3wFW7m2m861OjDdUTCh0Qe62DadTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oc1jW3QD; arc=fail smtp.client-ip=52.101.62.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TH5bBLY8EH3zaUpKFSKFXQuLF7AsxxtVtk1KQhTZWuWbZrMdw8Davrx1jLGD8xrDObZKzqMUdzWj6bxQT038kTxcpB6ef6k9sV5GEL6uGdR/q+z3jhw0YwITxqVDPBH8WW8nsMhR77QtDEnfTZnkPvzgbLv6l7IQkPr9dNCwqUwWnqJlehiua4eMli5L/KeMR7dFe0ZgzZIC4VgluW85Iy8ucEIQlyiTpoKDAKMGGvomNwXln8x2ftpsnUGCbbbKCPufRpdTGChGXYn91rny2YcfXHH/hvJGWOs0bH5pNWKdsU6XvFwqWb2Cb9oDnM560x5AOXSWP2C4N0mEBoDa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNaynzk0CkiMetJNy2+Qg7qd9BnWA9Ow7IS/3xdRt2o=;
 b=mYN5ZZzaHnczvvUVL+JYgN4li7Ey+nBng0qdpzbHN31uKCvSy9Nlqmw+pnQGg252/M9gnfrkGjn4geag5IBFGvV71mKEy05Qkz5jOrd/iYl/Cnst6j7xPK0alzI67UlJD2julwPIDoQ5E5yIbo+DIeWoS64Et13ac6oZ+Si1rJ98hAAG2Xiq5krSKf27eQbTKn0y8Yok7qZOvZJmAkm4HBDyIDblVDUr/TIAdnRTJquQzl+ub2nYr+Grd6jZS3kkBZc80R6dkth+cAYqfRhSvAfH2siqlVbiPLbcumTGeoAZRoJ0ScqaqDLcp9tr9UN2KdJ2Tq+W6WI2NLaFj+/ZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNaynzk0CkiMetJNy2+Qg7qd9BnWA9Ow7IS/3xdRt2o=;
 b=Oc1jW3QDViAsN+gxSe4eBJLxk2JgkRLZdVOYAgxz1a3ehwhe51xDJC/zIVR8Fv6MtMp0Yb8EKMcUrCDIGaesSJLeR2vtH8RH9SJChWNAaVgVKW2eSpeHiCAxCvihOIScyJA2fHiIzkSYU1ruWWr5cUPewXYE5M8qMxNtqa6nUcXpPaDIqK5W5v8M9im5h3bj8fLSUE+xtTB3B/cRklAJHaAfKfX9Hfh44oOjtulYxg9ia896khixUEaKtH9QzV9frDaVuGyMmNOY7hoNIvJxu5hUBo7AOPkbLyOhKhYVzRGWvn8uFk1hwVt8PYGbRcA6IOVCU1o3bNHkxJCQpECaCw==
Received: from BY3PR04CA0005.namprd04.prod.outlook.com (2603:10b6:a03:217::10)
 by DS0PR12MB8269.namprd12.prod.outlook.com (2603:10b6:8:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:06:18 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::d4) by BY3PR04CA0005.outlook.office365.com
 (2603:10b6:a03:217::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 17:06:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 17:06:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 09:05:56 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Feb 2026 09:05:36 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 09:05:34 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v17 06/12] virtio_net: Create a FF group for ethtool steering
Date: Mon, 2 Feb 2026 11:05:12 -0600
Message-ID: <20260202170518.9076-7-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260202170518.9076-1-danielj@nvidia.com>
References: <20260202170518.9076-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|DS0PR12MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a094775-e6ea-4180-140c-08de627d6087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+K5mJTD4q6RIvqP0Aqk7RjMmRtqaDOJQPbw9iM+GFSuEflFZwQM/MSPpJQbI?=
 =?us-ascii?Q?2MDbti2h+p5c2L/nTdOAXbzrTAr955Cf4gFQT39VJx2q5XsX4+o3fi9Gm3NZ?=
 =?us-ascii?Q?Gal59jg5KSsPOKzJ6I4bzLsqABUZIr1nOJoQcElszevcRg8mrJi9bmNIhkTq?=
 =?us-ascii?Q?hsEe53Gg4wGwTaPr0/8/exJzYtwEeN1rctHWSeNvp6SMbc00CObkVwqNheYe?=
 =?us-ascii?Q?B39NAnGKPIA0KIZCxAUQCuigiRDL+rfyj6OhevAQ6jLZ7gtHDiwFSsoQ0aOh?=
 =?us-ascii?Q?L+bu1zOmuMjZGm5Oq64uo3QdylS/pWE2fHPevohIlTJZC4JIaaH5gA8Gq6qS?=
 =?us-ascii?Q?aaiSn6oqikkI3bTWmmUonJ0K+CF0a9rzsIGDIrovzInAG4341KDAHVAzvznd?=
 =?us-ascii?Q?/R77qxUJLmaKmIDi9IJe1SYdf5H0FOhRaFx55vy0ED6q1NIBTJ2zuuEfB2zC?=
 =?us-ascii?Q?2LOZtcAKnvnGwONe1bk8Gt3FPyeKrLHiHKXJ3hF8jpEUr1NJOAk5oRj6zMJy?=
 =?us-ascii?Q?3550yFixQgHc7RI6G4JcL4JptcWhiDl9v7Va2Vsv8jMIpmAiO3N3g55CU5LG?=
 =?us-ascii?Q?mPjJdlX4hWc9EiKSuCHCXhfhA5v7djYTfc10+WKLN3GrHzdwqVBxrrLd1/ix?=
 =?us-ascii?Q?9gw/grADF9fWGy2dtBOp+/PzN0JgSXNUBcW3ONH1z2AHh9Q85/lyGDa0eg/Q?=
 =?us-ascii?Q?VwSs0kZ1WLfBbia9wHV0bIjcubB69CE1J3+G92Y88CyuQKs04zkjofAc1llR?=
 =?us-ascii?Q?cKtUc10p1SHmPEbQncBaYtuLq7ZvS7cvcqp+184AGbzO7sDnuPWGP4KsdsIe?=
 =?us-ascii?Q?+q5DvU1i9p21SU1CTwyUBxw0+XTLB5P1vJ2B/SHAOfqNJme2xC/cYKUwV0E5?=
 =?us-ascii?Q?JXKs3vOj4zAabCZHGryb4xgUwuTV37fKOqtO/rliV3kG1INXqlBDsDnX+KYY?=
 =?us-ascii?Q?l7ulogfv2FrYFlKCV7mVXqLEsPkzNNm5mjb3HFrAiSQl3reeWJxWOjY8ORC2?=
 =?us-ascii?Q?loUuqPHQmov7S3G7bSBAIW5VFSw8NsVhf4Zljw9uioyNTeQrDrSMs5vZ/mly?=
 =?us-ascii?Q?0k1NHzkIOV560DBr3+n3NpgTdyz4UzWVGJUVGcL71LPHxs0yqLX817G+ovtl?=
 =?us-ascii?Q?cShQPtsDkK6LMC6IwaFO2oU71boQFFLKu4Eoai2nPkZpEiw2S4E3e0VHdanZ?=
 =?us-ascii?Q?O+Q0qF2VwqF8BUHh3gn7NoTQhTfwrUzCgwTMdUHDwSg3ESvW3UrCE8Hzt3re?=
 =?us-ascii?Q?wxHsIDnMGS2Ud6S7m7Id0y0yz3jqqawWGvmomBxACB4pseWk7WyZrgy+haiA?=
 =?us-ascii?Q?h3IMSXQ9ciKdbvXt1vwBqJt07b9k82XFA5AAbp6AmLCRjY9G8kJ21pvwRq/h?=
 =?us-ascii?Q?U1NndlcGR3YmZUSawllua40oy0hqipYxlych+hUdWygfmPUmc1Nv03a2racz?=
 =?us-ascii?Q?ex1PWBuOw2QwtaWVP/9LFGVgY0g4CQwL64JFaMyD620+UORjzZHWtabXMOSz?=
 =?us-ascii?Q?pDSINtjHnVk9ofGn0erJIm63WE9NbEu4lQNkLXA1U7IFuTmmro4HH/vL2esV?=
 =?us-ascii?Q?OWNRSW7zo+vfbBSSvodSRHX5JpfmHa853kQ7j6bZA1NjwChd/haK6S0xrey1?=
 =?us-ascii?Q?VLWHvTypk0/sZY7Wrb6bZvcUSiMg087NBFpck2jpTvMVFcIZPA/7zZZ3ta1x?=
 =?us-ascii?Q?9+d7Ug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XJKXsCTNF1YZ/FI4o+yKW/6SpPnqwZjt90X4DwFN6t1IZfRkgh2RZ4UpPGyPVK9VvpWYSHu34xMsHRyybObCV3XEbkmkN/UhPK4BvBMvob4fGMjzjrmIf2NbGkolFunulyDVKtyrs97V1TVyeexuH+vkhLr56YlPvHA527WtWGl0PHjLmffFvhkuwskZKSmB99sQl/vlFlsIFfhN7CZHez1v9I56yfCgwFK7xC5kl01T2M85sGwQlbQ3ZgsQygL/NHFDrGNb7U3ZReyJSPGUSj49/ZUAbPciV4n0EjjdOY7+mB2/V56M6jW3rA/LKjXtKnHR6l0u50NtpBsGum9Rxc42yQCpJ+dYXZrljTNSjNZIrDog5zbpSQE9onhkY9ylnvjQBOh3p7k8qw+rvLHIIj12Al6yTqHr0gJyFrhJSMeyEt3riq6kyxFTpZHLr/Kx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:06:16.2455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a094775-e6ea-4180-140c-08de627d6087
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8269
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
	TAGGED_FROM(0.00)[bounces-255951-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,alibaba.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9D6D2CF745
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
index e884073eba5d..62d16899e8e9 100644
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
@@ -5724,6 +5727,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
 	struct virtio_net_ff_selector *sel;
 	unsigned long sel_types = 0;
@@ -5808,6 +5812,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
@@ -5854,6 +5864,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
 
@@ -5881,6 +5904,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
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
index d025e252ee26..66af9ecdb674 100644
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
 	__u8 actions[];
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


