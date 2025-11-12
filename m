Return-Path: <netdev+bounces-238115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E16C544D1
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AC6E4EE342
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 19:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FCF35294A;
	Wed, 12 Nov 2025 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J9UsFEod"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA879351FB6
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976131; cv=fail; b=VI+fnofCyUsooJdL2JBRpZUo2HTV+BDb/zSeFiNKTHIRtRC0wODdm6STqJYa8X9SmqRMegOLCLNvFYKYBIjpGoscywtV9Qp7k+km0dzVUCvEP9GivDbPYp2d92tAQ0j7Ak91LmyQNHS81X5IAfi0y7MrgQ9OpWs8tsU7rH8yCgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976131; c=relaxed/simple;
	bh=jE2WmfbnSHBEo0/ser8lQ1Hyrh5keOd98nSgXdlDHKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujm4lgSrO2/tBQMbuIODtwEcF31NWUAKpjmRImNpbT5ukYBfOKeEDDlmGuAAVkYB7Hi4BZ7py8+D+CjQy/hsvcH9aoyW2Kv1ctIq5BYzcF0UjxCN4SiyL81ZPt46bJ165pNmlGEgQbpFQb+ImivY74UgwSoQhnAe50QXadKs2UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J9UsFEod; arc=fail smtp.client-ip=52.101.53.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiyQIvK46AIUeMLF3RszA/l+joh2V7sBi5duLXV2omZDxU6PcYK//QeCcvY6+/gjL+vSBo7iQxZ+dM61Ms+FoOQn6/8VcWBZv101ZInP1lZv/B+KYp6P1FgnfVILvj5L4AJIvHRmMNXAtTwLloLBNg7CRnSzlalO0Ud1CP18HIOBgTX5whUYbVl+DtIKq3wbtVqbq3pR8eZjbiTugonqa1q9cWzPFKaw3m+ThYy0KgluLmVps4OTw92N5jd2FOsBwdhuYRVxTjJuChv+wCcwObZSrMVR0L9byBhKq6Hhv9eBpUVij/fOG6jUI0N218DwnfeAsuur7ouU2vkgdNUIlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1ULFMjomNZBiKXPSqHyJM1JW7/aF1MJDuPAxZtTKxQ=;
 b=aNWfM58hoXzoxM+CO32n25aMHJw6IXPyg+gRH9uJbYJnP6lLhh9xOw2JxedkqYHu3JtejVGjD3TnX0z843xcy/ig3vz4eIjtSC/Xwu7XpsBQ0R2ZAWjcn9ZmUwggrxxzI86dXVCq19KGc+D2/RRzh5f7m613p5cpyDNvhCavvuJ5O9Kr5/TdhbGUOCWIiPkSrXPesw+Qhu4+OCbaWM6+RJim47LugrnKYsEkbH/0AxUVLs1+qY/SrhyLqztiM2gk4+H+QL7NqEKvozAx0XulIsew7OBnnyyEP/idkNgfC43Ya6gBQUsWjJP2ffG0uSK/zrMgFE6szPrHcWFHIPdK7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1ULFMjomNZBiKXPSqHyJM1JW7/aF1MJDuPAxZtTKxQ=;
 b=J9UsFEodKeLjGDOocztlhAg7kBfZ379ClJexV/j2S6WV47I8s0W60dPF6/nJ8bQRdi6gUnsQ3AF8gRurCyN/e7y7JcEFUaP9y298IgeQ4x1P+xU+b0vs0F/rChE0SauA0r7tQnShEnSO3A0+BEs1Zqb6wyFl9FPPTR2e2eg1SruTvm59DkZFoM+xMe+Y0L+IdZ3+pA1y0nhKn8qLc9urDenSVNohhLVTyqMFYSoFipdFJlxHEx3VMhbYeM5g/n+iYRHFYiaCjfd/Kxd04CApVZsGYlNXaZ5+JmjVqFHEBsRvQsU6U1hFbfbprCigWpJl6cnwgpO9fuFJGqwLd133bQ==
Received: from BLAPR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:36e::15)
 by MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 19:35:23 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::c) by BLAPR05CA0015.outlook.office365.com
 (2603:10b6:208:36e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.6 via Frontend Transport; Wed,
 12 Nov 2025 19:35:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 19:35:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 11:35:05 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 12 Nov 2025 11:35:05 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 11:35:03 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v10 09/12] virtio_net: Implement IPv4 ethtool flow rules
Date: Wed, 12 Nov 2025 13:34:32 -0600
Message-ID: <20251112193435.2096-10-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251112193435.2096-2-danielj@nvidia.com>
References: <20251112193435.2096-2-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 615473da-9fac-429d-6a63-08de22229ed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9OG+Kbu3R9YcyrGOwc9LGhTN/Kc2Ib/aY661R+pWqJPApJiqB1/90/edwd3i?=
 =?us-ascii?Q?bl4ztfxu6JJlXSt4Dj2AdCGrS31Dk81iTzdgKLE++GGA2LSjKttBe86eNpbd?=
 =?us-ascii?Q?osPCSG/986FMkOS1U59wem/a4WPm5HCeUovU8ELFn4Z1LgS6Ih4bG6dloTJb?=
 =?us-ascii?Q?WEmci1b2rJsnu8pcmWhVJP9BYQQcSKv6w2mzoFeDPOhqWHacMVPago4u+yKn?=
 =?us-ascii?Q?BoMJvVF7xnSNPVZmJ/iNGlij0joEX3Nleqm4OrgxMYzleQ4h9TDxhc7lR6Sf?=
 =?us-ascii?Q?ib4GPa2cTrE82BQL0+0q0YPt/OmaJ17QfDK2A5e+MFUZPwfLakQImvBkfAzQ?=
 =?us-ascii?Q?HLC3jldvKk7Bv/GPyWRhMDhXgLz+ns3eG76otIfQwH7oioRMaD0i0ZenhLrp?=
 =?us-ascii?Q?j2Q82sJZG7tW6QoCEVOXEsvem/KSRbkTvcfb1sBQsTe77SSHbduz+vzXzRvt?=
 =?us-ascii?Q?hnNiytVslxr2h9NsqBSvD/VLRzxrIiDP6/+xRx2x4cGOSzGITaPR/Uj29jAx?=
 =?us-ascii?Q?VszgBs3spo+7RsFpffAsQ9jjnb9u+qfPcwiOrwGRcLYQVLlFt9WLRQNJ+CIc?=
 =?us-ascii?Q?dORQXQYH9iIF/OnvDCQw3p0+v3JGL1jCAK9idmPApfI4e/iBBFoN7Pp34OSY?=
 =?us-ascii?Q?IqxA4AZYhFjtE3FASG3EMucfQV36rc4dLjM7kRBB0uOw4AwwudDoOjM0E84i?=
 =?us-ascii?Q?mxSXEZafrxdBbK5G0otTsoTE5v+zKN471kvSyJCd7tNOeuHfTmjCoYWE42FK?=
 =?us-ascii?Q?Y/GlgsggHbkB4FW9xk5pwYzIrHG84uu6gEX9JiwdvWgzkGG2PJRi+9N7/Z87?=
 =?us-ascii?Q?zh/CRzLnUCzc0zKJjiTZM8onPjqRSge9yHu4z9OD5czkiR/4Mo4a+VOCpnlj?=
 =?us-ascii?Q?YQ1tYeRVwklgl6rPQTAzJSaA/2dvMS4faB4UbWBetIlerPycT7PA5Fw1su7j?=
 =?us-ascii?Q?xnYrXumfucViIgPJcIimVNApfOLUrcZGICjRkXj0dbvOi04P3+BRtJetqqor?=
 =?us-ascii?Q?sMsAidhrBoqsnB9ATzoJbrtcVKMnwivc226ydWJTvthwE3j3wZrqq6R9jCTx?=
 =?us-ascii?Q?wfmjCKHpFjdd76/W6g4427cC0QcxrVEwHT1m+gNySAio9rJSlf37vajrdojB?=
 =?us-ascii?Q?Z2fUvEL1t5MieOVnyae1CVX4lmZDPSMOCZug+kKOBCMGmCbiiki/x5KQKtet?=
 =?us-ascii?Q?nl0MiBQ3/OIr5axSnK7ukCcuGjPKcq2PfU+LJ5rO6rpwlr6QuNALIS0HnkiE?=
 =?us-ascii?Q?cDHzwx06bclDWDunM4nNb1NXau/dDQD3FFQSDK0ksfJ2MIUamINQ3Ua2mU04?=
 =?us-ascii?Q?aB6B+4+/Mj8dRA42gtQtyZ7YuGZxrLpBCRFdoJqN/EJqIbgh5eXr40BbP+te?=
 =?us-ascii?Q?Xj0kWr1ypSisyGVb2/ziNdCKbt6qkD1e0YKk6/VyMXcpTKrNDqM2Lqt7L5Qt?=
 =?us-ascii?Q?9mWvYiAGfr/iYHy1pQ6X0AvwUCXUUNpc8fYKCqLxQE6IoDkBhIpbF1swBuu3?=
 =?us-ascii?Q?Ph9VwhqQjGWBfNZOB/74hNtefUqi6PNVikoeapnssitV7vvhHSmjuCaE5CLA?=
 =?us-ascii?Q?UuNshq74MnUj93zms1U=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 19:35:22.0604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 615473da-9fac-429d-6a63-08de22229ed6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031

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
index e09fea6d08cb..5e51a9371582 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6898,6 +6898,34 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
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
@@ -6909,11 +6937,36 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
@@ -7048,6 +7101,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -7076,11 +7130,23 @@ static int validate_flow_input(struct virtnet_ff *ff,
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
@@ -7092,8 +7158,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -7101,8 +7168,33 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
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
@@ -7124,6 +7216,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
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
@@ -7161,8 +7260,17 @@ static int build_and_insert(struct virtnet_ff *ff,
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


