Return-Path: <netdev+bounces-236078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 596A0C383CB
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B3E3B9523
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBC82F4A10;
	Wed,  5 Nov 2025 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cXCZcahQ"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010002.outbound.protection.outlook.com [52.101.193.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB002F068F
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382716; cv=fail; b=u1YX0Vk0ftiF5m6C0+AmWJU73hb4zutLDJDuW11z+Db+ikee4dhIAsALGLPwY12z0xN6Ny5iZQ6vLji4GD2uO2+rMpxMaIcI6zIM8RvuTCxL2AgwUGCdb5gKsGcFaP/IhMjFeA0zkp85LDK8xj13IxyGIjkkM8EHYLZpmjGHrmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382716; c=relaxed/simple;
	bh=/VuihrutPKNvd4A8LHTfejaDA4cGMxQP8zfkJezt/C8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Th1vveNbFdrMttyz35l3HcoLX3MFd+Oox9ytVs14CR7nT1fV5eIrhAGP9xgKX3BsWIncLOkliVvgJ5yUlHjb+UD+HrfvlYYzDeUMz73koWM3egM9o5TOngMczR0CMqrjB6IiXsUenKAi20niqA8F8GJSP9PMISgLzs8u0PKsM3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cXCZcahQ; arc=fail smtp.client-ip=52.101.193.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkb3/ry9G1Bt+BqgRN7bB8PPHT6QRuU/be1Woj1i7pkzrElNJyMY5UGEcgrjGXHaabjypq5bWIsgBbS610DoQk5aO5K6YGQNO6G1/RBzSeBeNa//5dn6Eswo7quuV5XY2t2+pErwzhu6Q7UNXhEAcJMWe8Ybdbrout78Dn168FiaXNtZN+axPvObN4H29Qjd8n5j8p8PrrBLq52masrX8bzSCRATrBhShNeiE584HhRTZUWBLwQlm4eNoG+loD0KT9DKUTFLo6AKlqmfSJduvdMpc0NYpGJsgehf7ofrjacWuFGqjmVH2yvf4iS4jxI01eFzfGbfp9Vk7pSZQY38gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elt2esaSU9D7VU8BrwLc85IIArd0LEU4WrQ/SBOmFUk=;
 b=n3cL0K0JEem0BYIjrbCsx5l0OLN0SGjHib1oGd5CORKtK8MjbB8pxZeEaWqtUDCIi1EGGWuemGqZQicaIOptUna1m1g4iYuoxwEWaD7JeFPra7wMdDjFdwy6XMl4rYxPTtQNFjGf17aTlWTCRrYevoSCDXuLqJAnNeZPRKrsIvLpl4DGK6745JfOB+xt+uwVfMeXSnRzFJ56rgTKowHMKttdbNnqOTfuBJh572Ut6KvZbgwcRnsDBCpVmEFU698C0CF94YHJJ98LKsl62/Kf5qf9VRHLrAN1KOjKyE9xc7xWf/lkh7QRUJmY0cQgWX49jG9KXekTizxTeJlftIjyMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elt2esaSU9D7VU8BrwLc85IIArd0LEU4WrQ/SBOmFUk=;
 b=cXCZcahQaYsCpyrjwZsUfYpGfB3GdcWQ0CXYTlTL/zRvtVYul2ovPqAfs91HKBq7Te2gJBTyCd1h19rlwC7ltlLRChK4JKUkFfKqyDGo7bXgzjZn8AaFaOUx9ue9sI1kTm3uXxqhy5VZT5JypInc0yTWPMLOf3hlNOugWgfdz+KSmbWNLsdDxmZ2S2IEHWtmQ0wVTKocVzqq7cKR76l5QhSbPgSzedmUVI7qrM1QuUozgbAw3LpuUDw6C4VAr39fePIatxQ6bqzO0qcaTgnAJ4JzTRipOTRSb3bKocFgQlnzZmQhsrJbw8VLT8ag4jIj4CSHbkRN2G69XUbpjbjalg==
Received: from BN0PR04CA0001.namprd04.prod.outlook.com (2603:10b6:408:ee::6)
 by BN7PPF915F74166.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 22:45:05 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::78) by BN0PR04CA0001.outlook.office365.com
 (2603:10b6:408:ee::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Wed, 5
 Nov 2025 22:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 22:45:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:53 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:53 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 5 Nov
 2025 14:44:51 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v8 09/12] virtio_net: Implement IPv4 ethtool flow rules
Date: Wed, 5 Nov 2025 16:43:53 -0600
Message-ID: <20251105224356.4234-10-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|BN7PPF915F74166:EE_
X-MS-Office365-Filtering-Correlation-Id: 97db39e8-eeed-44f0-a43c-08de1cbcf6bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bRsTddzXpcBvSqfG0e40wYSPRDebj1BWgJNEj3K4/me3hLml0bVxVdEmYuNd?=
 =?us-ascii?Q?Bz4aR9xIr1Cydj3ncrUS7ium84ExCBw7Q4hpdCaG2wjvOj0CwcO0R0FiO77l?=
 =?us-ascii?Q?T5xe/BhqU5s7f4yMKf+CoExwaNaREV/1ZiYfEqbdPY4sOz31u3hJ4K4vnCZk?=
 =?us-ascii?Q?EEqc0Jrm/efTPnmV7jtfRkigFA4x3T7gzwtnB8bglbOWocyUKY/9gf81nDm3?=
 =?us-ascii?Q?gwjPT//xI/gkrrBhDZKU7ulEFuOnLMss/2FN0uQCgeMAnTxlMpxsYbgp2r9g?=
 =?us-ascii?Q?4KBRBquHL3WybDjzxOPTtJL5DxZMbq2IiDsDD2Gc3z/3PNSEOwkdOAHyHh7q?=
 =?us-ascii?Q?WDFwsk1YjAZEfvBsj1SioefriUOWw3EOsCyQkqxTDkVs387Za0170CNBqJrE?=
 =?us-ascii?Q?SSUINhT6rIfxFmg2hLffgsScPSk0oig5LR2hMKyzoNWNvROn3M6N/Wd4or+q?=
 =?us-ascii?Q?1oOQHshkIaWi9JmAwbbxuYBZlf5eTHQo2loX9cVGqHJL+tuXXyZDT8DFrY1t?=
 =?us-ascii?Q?M85ZodpLbTCblho/VajGjz29erNYGs9V8+Z6Bs7kyewIgCYoKafC5slvjUn1?=
 =?us-ascii?Q?Uq8a14A13eQaB+PANCym1bIk0jHWP4wKhQyLC3sllQ9ub2T2rEuNh9shJ5o9?=
 =?us-ascii?Q?JLkxhWm+i0bm8sFU0jDyTj1VUzfI0/zeQ4c+3Eb6x61jEp/1in4epgm1oblQ?=
 =?us-ascii?Q?6joj2+LxmcuNwdxCRtSJ8Qheh6Dkc13oXKEOBWYf7qlYytW/1Zrsi0JJf3vq?=
 =?us-ascii?Q?OKBpSC23lqbsXM4ISMnV4RgByZr62qiwxN2XY+EkMiIzwUT//CXbPOAtHHRn?=
 =?us-ascii?Q?hFRbH+Z0uF6QsRV4KkvjB+9LQe9FfQpi59fi5WJRZs/EPiQlgNmGO90QsbeC?=
 =?us-ascii?Q?Y+ZEEf0wptkGDvwd7cZ0vo+vQvUaq1Ad/RPKuWBOFmXGKjb2y39afXdG2rUv?=
 =?us-ascii?Q?FHT+JoHeZO/WcIzZ6V3E174vqfDqBWdJnVjE4GKzze36VQEpsjm2F5V+kOje?=
 =?us-ascii?Q?9eJWHuFpGHCYuKODAuih5NCGRLLMjN9F4kCeFNgCe41ZcpK8qzktsuE/pbwW?=
 =?us-ascii?Q?7I31X7zTMajT9D0wFZzlaShb5f40Flfmi1yXqYmf4oC0jkuzlVxUIt2BhRyP?=
 =?us-ascii?Q?MSWuGzFzEQFkRhoVjnHPFzfy/1K9vh2XfK4k24HIFNYrld5NMkiI0jGBiG3Z?=
 =?us-ascii?Q?w+75GQe6Jdd3vdRj13vqoaQHhyGPN6oAKrPEW8CkNZO2zPmVpULG28p9PMxg?=
 =?us-ascii?Q?nVnQHvj2IUhVmy8AEOeM/gDwK1udvvQY6Pd+TrJMb0f5wk/VR2HOZ259jWz0?=
 =?us-ascii?Q?exuAMbCBAEarnHzbUZ7buVTgh+PwNEZh1GpgKCUdlzBcBqX+iDNtzsOEF4/l?=
 =?us-ascii?Q?/85C6CiV8+KxO002xd0Lz/6UoPZLumPfbNL2ZY21JgmirM32cj2C0EcG8nYB?=
 =?us-ascii?Q?NR6PFubh/h52m9EqY7n44DvVZTT31hdJQhp5xGlGKXgWbbIX63nnB71tRtsf?=
 =?us-ascii?Q?ssjC7KxNscOy7PXmkRjAfPK1J4zmondcM0V4Q/jdRPgzZwbLNqWuRL4lJvAZ?=
 =?us-ascii?Q?puNnbNrb3Z4EDCwal28=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 22:45:05.0403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97db39e8-eeed-44f0-a43c-08de1cbcf6bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF915F74166

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
index a9b3e5da3ccb..a023d8936273 100644
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


