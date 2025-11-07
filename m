Return-Path: <netdev+bounces-236625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F13C3E6EA
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 05:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6113AE612
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 04:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DD82DC32C;
	Fri,  7 Nov 2025 04:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V9KiTfBk"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B429B200
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 04:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762489009; cv=fail; b=vCLa1IuQcQyi7y1Ks7u3tvsBdxPWaNzJJZCw6x07d6iIiSAjfswlLRYlbtSi1pT2b8PdfNFQvagyZg/UO0cTRqY3t/LIwN2lPYGUhv3EqafhA+EQmktzpEJRUl80KALRUylrp2+4eoYp4v/GoLgvNPE562ChyrQ2RjoIuBMZzaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762489009; c=relaxed/simple;
	bh=Sd5gZA6kR6GM1mpiiOvNG6i1gVMFyiWoN8/8pJmlbH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+1w/gkWT+q8Pdc0g3YN4mgbUX8PoTdLufnKqfG4rRm4Z4HdjiQc2U+Rqa2GFi8R8OA+x8MXYjfLvFSoQPif4J6YKQhdyqCDKLCz/Fv1yAOxocOOQUj4ELK1J3bugDhwYJRE2Za8+IBPPUOjy+RbM7NYQysrEP3x9Rynewi51io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V9KiTfBk; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSahGLphmXZ6Hx2CZqZl7WLSut8CCOveo3934qRR60S7qPGI+bDSLT6NApVYod/9ZHlqDhWzt/vXk3yiBrZkh55BhToZWIxCb2jnmFMPdrlhUEWoBa0LpKI+/TwrWTMRAb60IOWRa+9VTVuNzwyZlT2O7rKwlpOLVZK5zdhaom/lx1VmrRo1ZKffBIJ2jFW5iqB5DXqeTLf8/tdGOyymW2X1hXIojuV6Bw1sXC2H2gSV40L55969Mdohi2Uu/94EyC8am1xjbs5bgr21vd0AmFBupvnwvM4KiOYuSNN8rDoTBZj9FsXHkNNaxyy2xPbwIilZbzqerUg/Rufm+Bv1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxXqYE8Vh0k2VNTa2kfsACweSJz1Gbstar2OTirUW+o=;
 b=yJ706J0m1tUxjuxLvrVF6sdfae54ACgBs6BXCmAadlYyympTqCWPJV0iwhcRXft2ZtDhiUkQs5hj6yQgjdWtPv/PEciq0tRJGfirNOQ1N2R2xtDnxbNy3nqGVH0nA40F8pyMNEcXiolmlG/wFvrRbijF76kE/JCKYfXmGrI5x773GqV0aARkgqfuFuwsdhkUT0QmsQFZd1/vR2MRkntTxKual++sXnGJL32Fex4UvUzZErC25QYa9pjlUxdWGb9o4ylSWwvoygv+LnHo2nVMoQWMdD9ZijZ6fRSRMn519azXjHszYqgaDBo1aFnBjnEY9pVgyB3kIKlTtzNB//I+eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxXqYE8Vh0k2VNTa2kfsACweSJz1Gbstar2OTirUW+o=;
 b=V9KiTfBkadt7lh5kiSnK/4bFBuu7JhLU/TOdaH+dpa78dbj152srLCIyyAdzCu5O9Kyyt26QRJf6CD4Ld75uVdI91o1ui/lQQ0pmF72SXReZC46wClcCMipXSmFYmKX8KJLKq1ZDNgewFgtpysZxz1wvgU7SLY55mXnOFPeb2TJgmklLnMCoosimZaduJDtg/0SOL4hJNEdoSLul2IXm8JBFBbMlJB3zS6gqwTj6LTz8bohu7xiewqFFhdIiZV3fFJh2nantNLFJyfWcdZRGzPiC4R0pve9/bUsVZPLGVhXeWaYMi390ad/eglVkxuIlL074ucXTaH1KVxJIJcTQSw==
Received: from DS7PR05CA0108.namprd05.prod.outlook.com (2603:10b6:8:56::27) by
 CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.12; Fri, 7 Nov 2025 04:16:41 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::8b) by DS7PR05CA0108.outlook.office365.com
 (2603:10b6:8:56::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Fri, 7
 Nov 2025 04:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 04:16:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:29 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:29 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 20:16:27 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v9 09/12] virtio_net: Implement IPv4 ethtool flow rules
Date: Thu, 6 Nov 2025 22:15:19 -0600
Message-ID: <20251107041523.1928-10-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251107041523.1928-1-danielj@nvidia.com>
References: <20251107041523.1928-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f96e1c-698d-434d-e431-08de1db4742b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0I+gTwnN+Tu83ikOU3ZUuznaX/IkAtvKzkK+sgov12XlBw4pMTYtnR+PI8eS?=
 =?us-ascii?Q?JfVALm9R0RGoec7w83N5Oz+BCv7Fy1KFHWtSfIwc/tNPb6A7AQcNVspAT02+?=
 =?us-ascii?Q?nn9Pn5lFuIGRqLIx0ujCqyk2w7kDjBAOmolcu077a/DBAp9IEWJefH4LVIGw?=
 =?us-ascii?Q?JERk011qHtDqkJ1SX8BtKR3twjvt2VjLTo1/dPv4uSacuAsMwWzOqQ345fjO?=
 =?us-ascii?Q?U0chMg6dwuYltrU0AUmanki2aXFKJX8/syWvFwra9pyLanPdOIArl01jOBg/?=
 =?us-ascii?Q?ozaA4qE1qmG9AcgbtMINJKSY84vXiYDHuD4gN0uxc+mgnEur6ITVGPDCTnag?=
 =?us-ascii?Q?PV0x0FqD8/3sUwpVzDAwFM+BxWwSDympQDNc+ML1Rtx+43Q1SVJiIAGQg8X9?=
 =?us-ascii?Q?4zoIx4Q0AoTRLxXSRRi8IxDofqDraxclngIoc6I8kNvuse8xzkZqDjtjz4xM?=
 =?us-ascii?Q?JsUERLPMdvtgJCRAVPmLmI4UCpdGD25bd43vwnAujnf1Wowa4sjAQM9LsYz1?=
 =?us-ascii?Q?yFlqwVjlqj3Fp039+qT4jajOvcKF1SvBpHyp3j8MP1JmNOJbFGKTKimpk11N?=
 =?us-ascii?Q?HVER4xjAauriJPAaHz/G3eJuc2Noy+JLW8EWrvmeLQk7fz4JxRM7vA738V6v?=
 =?us-ascii?Q?HyvoYlIGNznOynphX0zwgLJIy7l9KO2eqUcg6oB+gTfJvmcyP+ZImb+cXj0m?=
 =?us-ascii?Q?tlg9wUONfqzwMQc6i3RXKxV9OAsA0XWLXY9I2pAGDtyj/CdUQgEnA6wMAGzs?=
 =?us-ascii?Q?4Jk51CmJvs5X59WIHlZIiZxvdMt5mAjnNfNI04xtWb9Kp32Mp0Op/xwnP643?=
 =?us-ascii?Q?uJeG5jIlqX8tefSItlHgMrHWvmm68LmN6hSgPoFA6DuRPrC4CAG0n89l1BQg?=
 =?us-ascii?Q?aov0dSOaetxR6Q6NdOBP91dO4RA3o6zxRaQi+8T8jFN2ee2yj9Buku6/XR7E?=
 =?us-ascii?Q?sNtze/OAPdACIZaKA3Ws9m0ZntoQrLkVWsg7pSjQ8QlZWjOGxbp3ZUzn9cSg?=
 =?us-ascii?Q?4P5eERYsjZDJnqI4duCqPlG5UA32t2JHEAqFNzyPf9LtUQsNQg6xeVAYAfzF?=
 =?us-ascii?Q?Q1gxZmB22n7AKHH3YDmG5TXnxSGE8k/jLRPs32BrNYatwAwyYKByekswYc0g?=
 =?us-ascii?Q?SlWIbJocrCd9T3Hk7BfQqhy/F/7PYkhF8lY2RMlnIIh1elifXhnu8IpmxY4C?=
 =?us-ascii?Q?ch5KrllRLDoy2TmljiSJMbHrveZTSqNY81pGb7tKai65GQSXqBG1xzoot8jQ?=
 =?us-ascii?Q?4DkbhAVGL93FihhFIyyZ550+kiXEH22Dudvt2G1lMaMGVYqldDbKr/e9GGxU?=
 =?us-ascii?Q?UpprJBNXf/wu5FpXGnCgHEsAvR+N0QXJbzc+V0q2A4WpDo89EjhO2mZcb9wN?=
 =?us-ascii?Q?LCJCap+e9C9E79WdwOXmYCgQ+uS05LisMl/kfAmHwtfCeu+7Ufic5oYQD6Mh?=
 =?us-ascii?Q?gaKV04hon4f8Hcl+nz3vMY/xnGa6bJIuJOpk1bwzF9Ij3l7++Y8nIt5cwE1d?=
 =?us-ascii?Q?5KvNkulqDXCqhfxa+44cuQZCqZVHk2ai/jEORsqFt1F6sR2evtwuSVCu3n9w?=
 =?us-ascii?Q?JB6MoyOpfQH2UFbM6nM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 04:16:41.2053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f96e1c-698d-434d-e431-08de1db4742b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571

Add support for IP_USER type rules from ethtool.

Example:
$ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
Added rule with ID 1

The example rule will drop packets with the source IP specified.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4:
    - Fixed bug in protocol check of parse_ip4
    - (u8 *) to (void *) casting.
    - Alignment issues.
---
 drivers/net/virtio_net.c | 122 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 115 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7c29fb41a668..14bacefba899 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6888,6 +6888,34 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_ip4_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct iphdr *cap, *mask;
+
+	cap = (struct iphdr *)&sel_cap->mask;
+	mask = (struct iphdr *)&sel->mask;
+
+	if (mask->saddr &&
+	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
+			       sizeof(__be32), partial_mask))
+		return false;
+
+	if (mask->daddr &&
+	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
+			       sizeof(__be32), partial_mask))
+		return false;
+
+	if (mask->protocol &&
+	    !check_mask_vs_cap(&mask->protocol, &cap->protocol,
+			       sizeof(u8), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -6899,11 +6927,36 @@ static bool validate_mask(const struct virtnet_ff *ff,
 	switch (sel->type) {
 	case VIRTIO_NET_FF_MASK_TYPE_ETH:
 		return validate_eth_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
+		return validate_ip4_mask(ff, sel, sel_cap);
 	}
 
 	return false;
 }
 
+static void parse_ip4(struct iphdr *mask, struct iphdr *key,
+		      const struct ethtool_rx_flow_spec *fs)
+{
+	const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
+	const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
+
+	mask->saddr = l3_mask->ip4src;
+	mask->daddr = l3_mask->ip4dst;
+	key->saddr = l3_val->ip4src;
+	key->daddr = l3_val->ip4dst;
+
+	if (l3_mask->proto) {
+		mask->protocol = l3_mask->proto;
+		key->protocol = l3_val->proto;
+	}
+}
+
+static bool has_ipv4(u32 flow_type)
+{
+	return flow_type == IP_USER_FLOW;
+}
+
 static int setup_classifier(struct virtnet_ff *ff,
 			    struct virtnet_classifier **c)
 {
@@ -7038,6 +7091,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -7066,11 +7120,23 @@ static int validate_flow_input(struct virtnet_ff *ff,
 }
 
 static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
-				 size_t *key_size, size_t *classifier_size,
-				 int *num_hdrs)
+				size_t *key_size, size_t *classifier_size,
+				int *num_hdrs)
 {
+	size_t size = sizeof(struct ethhdr);
+
 	*num_hdrs = 1;
 	*key_size = sizeof(struct ethhdr);
+
+	if (fs->flow_type == ETHER_FLOW)
+		goto done;
+
+	++(*num_hdrs);
+	if (has_ipv4(fs->flow_type))
+		size += sizeof(struct iphdr);
+
+done:
+	*key_size = size;
 	/*
 	 * The classifier size is the size of the classifier header, a selector
 	 * header for each type of header in the match criteria, and each header
@@ -7082,8 +7148,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 }
 
 static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
-				   u8 *key,
-				   const struct ethtool_rx_flow_spec *fs)
+				  u8 *key,
+				  const struct ethtool_rx_flow_spec *fs,
+				  int num_hdrs)
 {
 	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
 	struct ethhdr *eth_k = (struct ethhdr *)key;
@@ -7091,8 +7158,33 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
 	selector->length = sizeof(struct ethhdr);
 
-	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
-	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+	if (num_hdrs > 1) {
+		eth_m->h_proto = cpu_to_be16(0xffff);
+		eth_k->h_proto = cpu_to_be16(ETH_P_IP);
+	} else {
+		memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
+		memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+	}
+}
+
+static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
+			     u8 *key,
+			     const struct ethtool_rx_flow_spec *fs)
+{
+	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
+	struct iphdr *v4_k = (struct iphdr *)key;
+
+	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
+	selector->length = sizeof(struct iphdr);
+
+	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+	    fs->h_u.usr_ip4_spec.tos ||
+	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
+		return -EOPNOTSUPP;
+
+	parse_ip4(v4_m, v4_k, fs);
+
+	return 0;
 }
 
 static int
@@ -7114,6 +7206,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
 	return 0;
 }
 
+static
+struct virtio_net_ff_selector *next_selector(struct virtio_net_ff_selector *sel)
+{
+	return (void *)sel + sizeof(struct virtio_net_ff_selector) +
+		sel->length;
+}
+
 static int build_and_insert(struct virtnet_ff *ff,
 			    struct virtnet_ethtool_rule *eth_rule)
 {
@@ -7151,8 +7250,17 @@ static int build_and_insert(struct virtnet_ff *ff,
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
-	setup_eth_hdr_key_mask(selector, key, fs);
+	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
+	if (num_hdrs == 1)
+		goto validate;
+
+	selector = next_selector(selector);
+
+	err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
+	if (err)
+		goto err_classifier;
 
+validate:
 	err = validate_classifier_selectors(ff, classifier, num_hdrs);
 	if (err)
 		goto err_key;
-- 
2.50.1


