Return-Path: <netdev+bounces-228833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 500EDBD51CD
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA61C561D91
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC7E31A7E2;
	Mon, 13 Oct 2025 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kaOBgo8R"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5338D31A573
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369319; cv=fail; b=TWX2V/kKCNS4bOwC4W0z1WBQ1BpU+Z2u3fjZsAEGE+KVS0QY3ZqyScnP0wk/VHqGMS8ETVH7itsRNEO7JUOnXlaUSD9XGfJ0i5F33BcyZhpR2HlU1xNAyvN27KFqTjUQXBq3BTqvW9yWCt4z3iiKqWlN1dxWXvz41tJn1qn84P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369319; c=relaxed/simple;
	bh=ydrHUPjq2+FwU6GvZidOjp3bxIONid1KsA8vNnC066Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbf3UfXlaFFqGZ6GyfTnKB4mgoydaJqGoVAptFtiNepiRm1NNkZwWjbrXqCfC5RyXtsijewsSbC3b/oEbkXPfVhPOJaF7lq8UVsMpQkzNlZb5WhIC0VsmmNb8McA2o0AasBqacUID3RHy2m08iBxKkJfMZNa7mFWxKYTYFJ8n8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kaOBgo8R; arc=fail smtp.client-ip=52.101.52.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDB8m1Y9+raU9RwWV8D4xcuCq0eVe4PZPgso5nnIsGujyjYUztHQatstPReFhEtYuksVIXHrqEs0Tv1NAaul9TdhrJBV4rN9Zf5P1LNv0iQO/Bmen4rD7htLtUDoUgAwdm67HRyDT6bGU6mvo24QOl8VIxA0Fk3jj8bvODE8RrN8ibMLHvkjdstF9JIPk9D3q7M598UOiPr3jAn5eybf9OSpvJ92xQC+JXLw4BtMUZPs+1LTQ6ljEEuHjsVqMx3OvZnRoO1ElmtAXaj+0txHl2RmPM/kTgw1wvaaiuCg8crQtNomhsbcKBRpwWAC1Zz8zy7zf0ZjMwNiNhDwHdNKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vx5S0sDv6HwmW4muU3TG/8O+AvoQED+Tbo8xpa1Wc1U=;
 b=Exyybwe9GPhe3cibLe5sO/CUnr6b8ECFbTn0k29cvGFXi3F0JsfKPJdRhD3IePpJsae1+uYoO67efJeYJ3DbjLvVGdI7BEkFhhmB/z7qRujvIIIjr4gs2z7zk5xLte+jTQ2qabyITx3hR1kRT7SMuexc4fMjT6Tr96UvT+m1vftXv8yEACIyhk/rtVz6JUWrF0GjKKwD/VIC7Px97SK0jrB9LzuDz4KogXJTTvp/yG1B+eX1Q8Q10lVsBaBuSYj0hyFJclQJOZBob/d0fluovPxQMeCwbyzeP1otiLn/RGTVOrOL7OKUQ4wR1TfiJnpsXzTaRHu4KgRQmGOvk4NZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx5S0sDv6HwmW4muU3TG/8O+AvoQED+Tbo8xpa1Wc1U=;
 b=kaOBgo8R03IQTvxwrv42834DJnecEX+iDO6KuHY4ym7fx1mg4qYCvrWAQbXSfmvQrWgLPtHIn1lSZnKfN847xBY9u86LnioGvTKr98aqfYSR4INQOe8iTF/OTJX0/ttKr52L1F98YnJRXWVWwR+gTLy7wFcSRCSbcBXTRR7VWqnULDcc01TpU7EocIbEe7p6JemiuOqYfYtzW0xo+xJcm2qsUnf65LUEGzsayRPzjLTxxTnOAOrsD9kv5K7PrfRuePBUcIeXtvxgFLJS08hVoRJ8EUtzGEaUNfwX21izl9dVUP6ooZeJM77IPUdwdK3ybMAwVW9kmJiviBFQLBqm0Q==
Received: from SJ0PR03CA0280.namprd03.prod.outlook.com (2603:10b6:a03:39e::15)
 by DS4PR12MB9564.namprd12.prod.outlook.com (2603:10b6:8:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 15:28:34 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:39e:cafe::72) by SJ0PR03CA0280.outlook.office365.com
 (2603:10b6:a03:39e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 15:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Mon, 13 Oct 2025 15:28:33 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 13 Oct
 2025 08:28:21 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Oct 2025 08:28:20 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Oct 2025 08:28:19 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v4 10/12] virtio_net: Add support for IPv6 ethtool steering
Date: Mon, 13 Oct 2025 10:27:40 -0500
Message-ID: <20251013152742.619423-11-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251013152742.619423-1-danielj@nvidia.com>
References: <20251013152742.619423-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|DS4PR12MB9564:EE_
X-MS-Office365-Filtering-Correlation-Id: d2314715-40b9-4374-78cf-08de0a6d2c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WmK7Q8F/QmfLJVMA8bHvk6l6tQDnKBDIc3Gz/1fJv9K+r5NfkZHl2o74mxgr?=
 =?us-ascii?Q?Y3zCFXQ47HwiW29Nn/HQgAbVD3DuD5bFcHcfTXqQwbfJB9fcYKhg+5hQVKfp?=
 =?us-ascii?Q?Bwk8zbVIlYV1g0w6BvTbOHE6zluhWpf+L89ARYxSodSWmVSpVLPZ5+9nprIf?=
 =?us-ascii?Q?hOBRtoEJos3jbqW7hOH3ob9Uywaxq+9QQU8tfZ/tGWj0sg7PVs7ZK0VoMyVV?=
 =?us-ascii?Q?/oFUhGGtxYvdo2i1MHqlnU9/o1Y/RFmP9KULQy/ZR84ckMi8ACdNz9qQG/2A?=
 =?us-ascii?Q?bRcAJl0PTrOzM1sFJ1YYzDF+kqoYuMFAmv+80sMfa0yWjcS1j3SZ+QBDgoAH?=
 =?us-ascii?Q?cXlAZlQPv6YPi/O0CXqTxHvli+dQyMi02a2JaywIcJDfL22FeTqEmNBG6Xfy?=
 =?us-ascii?Q?t8ZiGoARQAXFR9/cCCqlbT37Mvl4W7D2i1Wp7+YPjQW4oixAcTY1dr1HZonp?=
 =?us-ascii?Q?yc/UFH2AQcDiwGHyMmm+6Yby0Odv8Dql4tabZIIeH89hSfBzchfA+RSCcTr+?=
 =?us-ascii?Q?gkKYEN9e8j7gXPUy7clUnFWdNdR0C19mkuq2DDzO7HUKIR1TESUeKjI+I27g?=
 =?us-ascii?Q?k/u0KbKwtrf4h2iKsth73KBtHi+Lfl0zKOo4J3JG1j/C6ecpd6rsSH863I/P?=
 =?us-ascii?Q?Vg/mOrnlcv4MhYFaTj1mZdFx4i9pO4UCPo2n2BYCgZB1MQyATINUZ69G8zBk?=
 =?us-ascii?Q?ZbMQNimuASvvqAOLDxo9smG6GXtn5V2NY3Y9JW7WbDTZTOZx6s4BUcEJ/ZDq?=
 =?us-ascii?Q?1mmTXa/Q8csQ+c0mHvL8D8x0hPwrcTKUEjF+n2iGhLLeQ6p+XjDIVU9EsiaX?=
 =?us-ascii?Q?IDI0Z0QgQbsftmv2sXenUadkRv0Wt2eB0Rf0qQGDOOA+Umv7dD2bTNCZKdkN?=
 =?us-ascii?Q?7Qo3D6ry6ovBPR+PibBeoZTc8lBvyx5FfnFNnjXbSTt1EFB+dfBUH1tuWmUz?=
 =?us-ascii?Q?ewhwKJR7c8uymKeAK0LBRfOuMUXfsLRLB9sp+UKUlv8r/YO3hHN7lTOu0Yre?=
 =?us-ascii?Q?7CycGd/xXnk8wC7u+xhSh5gfrzx74dBx3MMIujq/AVlddMgc9/MlhkSH5iXv?=
 =?us-ascii?Q?T/dcPfFfJsqiEu8zueAm7p3RUIc6JTmQFpNHkr1zoDnTBlcnrON3sumoaAgP?=
 =?us-ascii?Q?eOwfYaAAwhbl11eODfwz/5AliAvgSXessnONcOVsmoumH6+gSsScZuMdScEK?=
 =?us-ascii?Q?ZFx1c62eXHu125/zjdm0roN2Ys2JIvrn2bBSHNR4RXG1g38Zg2pMIpovJSGe?=
 =?us-ascii?Q?2u+57ku8b9APb3NnVN7VgDh2EqE3dsQxf/ytPJ64v5WS0tWlchMWPP2y0jEB?=
 =?us-ascii?Q?Xg2TjMbPbwbYBX3b4XYdsOzZA+guvRlNxSwWz9HHRm13otIPidZhSFSiy/g3?=
 =?us-ascii?Q?H6IqP8b9lmYaV4M8qoAmY0DYQZmmI6vuZIDtn1cQtJ6rY0OaFknkk1xYwjn7?=
 =?us-ascii?Q?ipQKsmHQdM0f7bwi+Nv+bVy4NEEW5QN9YJKKVtO2jWOYa1rdIO4xCE5tjClY?=
 =?us-ascii?Q?yWR7OGT94GtTxCMSSA2ddbK1L3+hDFwkqKu/vy7hbjMUiBfNRz2biUiF9h8c?=
 =?us-ascii?Q?DplrBDiVyb5RI997C7g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 15:28:33.9963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2314715-40b9-4374-78cf-08de0a6d2c16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9564

Implement support for IPV6_USER_FLOW type rules.

Example:
$ ethtool -U ens9 flow-type ip6 src-ip fe80::2 dst-ip fe80::4 action 3
Added rule with ID 0

The example rule will forward packets with the specified source and
destination IP addresses to RX ring 3.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
v4: commit message typo
---
 drivers/net/virtio_net.c | 89 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 81 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 5f6e8f0a0121..591bdbe77b99 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6912,6 +6912,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_ip6_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct ipv6hdr *cap, *mask;
+
+	cap = (struct ipv6hdr *)&sel_cap->mask;
+	mask = (struct ipv6hdr *)&sel->mask;
+
+	if (!ipv6_addr_any(&mask->saddr) &&
+	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
+			       sizeof(cap->saddr), partial_mask))
+		return false;
+
+	if (!ipv6_addr_any(&mask->daddr) &&
+	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
+			       sizeof(cap->daddr), partial_mask))
+		return false;
+
+	if (mask->nexthdr &&
+	    !check_mask_vs_cap(&mask->nexthdr, &cap->nexthdr,
+	    sizeof(cap->nexthdr), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -6926,6 +6954,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -6948,11 +6979,38 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
 	}
 }
 
+static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
+		      const struct ethtool_rx_flow_spec *fs)
+{
+	const struct ethtool_usrip6_spec *l3_mask = &fs->m_u.usr_ip6_spec;
+	const struct ethtool_usrip6_spec *l3_val  = &fs->h_u.usr_ip6_spec;
+
+	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6src)) {
+		memcpy(&mask->saddr, l3_mask->ip6src, sizeof(mask->saddr));
+		memcpy(&key->saddr, l3_val->ip6src, sizeof(key->saddr));
+	}
+
+	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6dst)) {
+		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
+		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
+	}
+
+	if (l3_mask->l4_proto) {
+		mask->nexthdr = l3_mask->l4_proto;
+		key->nexthdr = l3_val->l4_proto;
+	}
+}
+
 static bool has_ipv4(u32 flow_type)
 {
 	return flow_type == IP_USER_FLOW;
 }
 
+static bool has_ipv6(u32 flow_type)
+{
+	return flow_type == IPV6_USER_FLOW;
+}
+
 static int setup_classifier(struct virtnet_ff *ff,
 			    struct virtnet_classifier **c)
 {
@@ -7088,6 +7146,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -7130,7 +7189,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 	++(*num_hdrs);
 	if (has_ipv4(fs->flow_type))
 		size += sizeof(struct iphdr);
-
+	else if (has_ipv6(fs->flow_type))
+		size += sizeof(struct ipv6hdr);
 done:
 	*key_size = size;
 	/*
@@ -7167,18 +7227,31 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 			     u8 *key,
 			     const struct ethtool_rx_flow_spec *fs)
 {
+	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
 	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
+	struct ipv6hdr *v6_k = (struct ipv6hdr *)key;
 	struct iphdr *v4_k = (struct iphdr *)key;
 
-	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
-	selector->length = sizeof(struct iphdr);
+	if (has_ipv6(fs->flow_type)) {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV6;
+		selector->length = sizeof(struct ipv6hdr);
 
-	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
-	    fs->h_u.usr_ip4_spec.tos ||
-	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
-		return -EOPNOTSUPP;
+		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
+		    fs->h_u.usr_ip6_spec.tclass)
+			return -EOPNOTSUPP;
 
-	parse_ip4(v4_m, v4_k, fs);
+		parse_ip6(v6_m, v6_k, fs);
+	} else {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
+		selector->length = sizeof(struct iphdr);
+
+		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+		    fs->h_u.usr_ip4_spec.tos ||
+		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
+			return -EOPNOTSUPP;
+
+		parse_ip4(v4_m, v4_k, fs);
+	}
 
 	return 0;
 }
-- 
2.50.1


