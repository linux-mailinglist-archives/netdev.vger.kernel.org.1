Return-Path: <netdev+bounces-220888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140F5B495DD
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436A134147F
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5F43126BB;
	Mon,  8 Sep 2025 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QO+9igoS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32043126B9
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349798; cv=fail; b=FRbtnJ21hrteMcxAeqqFoT/PAfS8+nBHxGaDTw92Lxm0tNvBFqX0aO3d+pkzfk3inkmvFW+OPXd1eoVku/LAcSRYO/nZbFuZvJr7UwQZYgwx4HuXzXDnWJVIpBBfMYx2P7c3UTfz9gaycgtrquJSwCxWG2K1QK9Nrjpaw8p7cOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349798; c=relaxed/simple;
	bh=k+vBwF6xZ5YmCrGRZypImyhYWTXIKdjZSMlWff6PgRI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JBogBXgzWb+UciRH4yiZayVvOQgDjoyuoxJ9KrWCr5ZtsSe0i+iZsFktSRj6JEbZbPbvFhFQ5wR+aVZ0Zb0WGrcApkcfexd8ifK7DwtLfAKEDxF4w23MhivEB/ul1KTmwmH7C2OcOxXqjnAoBya0yr2lvOCSR0tyweKB+P+V2vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QO+9igoS; arc=fail smtp.client-ip=40.107.95.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=en5zIpfR3Om3M+MMrIbRa5CAxJQwaBNGYTZMYf5uTBg9Z3O47PJDPcLkPPYGWY22lXrEDvx/HigcLQ7oBKxgKyaFdeDGiBtyYxvRgtMrar9OfSaB/5gnQToQaOEqSfgKyDDxAX8gjDowVMy7EVoOMmYRFpZD0nv6AMxKmuKTpHIswT/64hL2CqNbVXJOpKFgyxteWaA3/dybL6SZdhW1M6Ffvl0TFDmgMsSqVAE4Kw1+YN3Sk/ShMNhrUtve8TE0PWlp02YnU5soL5upoRKIaNfh3Yv9y9dxxVlzwzq79VCH1nxZR44E27RuLLDmNh3tCX7mnfh/6nHag+pWJtfFyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ue1wOvGPuLkNz9Dji9RVjCDoMYLQvVIKXBHcKDrxph8=;
 b=RM6nTiPSuP80IGAdbLgUCay8ej/zTYj0gUbz1dXim1MlJY6us6F6AZgvQX1LiIOLJppb6H1ImdgrBLbx5HqpT3aSYw4+2Rhk/QSzQ/NdRju10TmuUMyrvg6/1Nz0uJp/tDmcWC26AQda3kQf37+D91DvmsBfWvft61glb45Es5I5WEj0yFZV8cctow2u6K6/w5l0u+CUiJDFcLHtIkmCpAecJf/Y1qtcHXQhT5bnR1nCt5FaYrRL8ycfuipjtDL/Kt3aQWsGmdVfAxQDLf0moCCLXgNORbv6KkP+9Mle37N8w0MoY3g2Lx1pWDicOtf9BFk5XJ70TlWkC1tpEMvtvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ue1wOvGPuLkNz9Dji9RVjCDoMYLQvVIKXBHcKDrxph8=;
 b=QO+9igoSnrN8GO9+6eelNi0x8NGoGvlw4twMd5mCvHueW6o4irSluAuLfRLRK58NETKxexXDU7Gu3mKvzDRgKQtXt52kmBxbtQFVGDt4Dx/h+9LWfeON+vlArQ1FViDAPqO3oWJjBl6AIkDa52HcNQNNr7nXh26D6j3zx3ULZgZqK2yySSG4ep6jsGSEAReLb6pGZMB1Z2e17JL89qq60hTmwiWUCYHU/eLjzOjikLN8LV8a3CiJwiKFh6cGTpitZUQNIcanhCBgWemrXuvfgYkOEw9fX9dicueZVA6KGbDzlQHiI+DHXHIyLwB1FWWUWYfuAM97HeNXzp6tztqndw==
Received: from BYAPR03CA0004.namprd03.prod.outlook.com (2603:10b6:a02:a8::17)
 by MN0PR12MB5857.namprd12.prod.outlook.com (2603:10b6:208:378::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 16:43:12 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::e5) by BYAPR03CA0004.outlook.office365.com
 (2603:10b6:a02:a8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 16:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 16:43:12 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 09:42:43 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 8 Sep 2025 09:42:43 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 8 Sep 2025 09:42:42 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v2 08/11] virtio_net: Implement IPv4 ethtool flow rules
Date: Mon, 8 Sep 2025 11:40:43 -0500
Message-ID: <20250908164046.25051-9-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250908164046.25051-1-danielj@nvidia.com>
References: <20250908164046.25051-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|MN0PR12MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe50f9d-b2ce-4767-86e0-08ddeef6ccce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SDtLuUQ5H5nNSkNHdjy9ZWhr2bJjgG3aNQ6qQ0s1UMXLMh0wKBheFv0/DGak?=
 =?us-ascii?Q?OxFw3oZWYK4K3jt9voYXKt3stPvNL0w9n0hR6gpzo6NJkQO5iWqbLeCy3LYq?=
 =?us-ascii?Q?pkvfNrZj+uhsJ1lUVicqxWFZDYH7Jgvq3fK7SSWn3M1WmWFEhczx941IjCwF?=
 =?us-ascii?Q?1Pkj/69DeGi8agOpWOGfbIWyfxuPBQLpo+tnK9sa4UDyxjOpLzlBvNhus85k?=
 =?us-ascii?Q?ZyQW2xKPtDlSjo4vn836uve/w4NLb5C9T9mvuFr6cFZpvj1znYWFYJvj26f0?=
 =?us-ascii?Q?Yi35aS8YXXRpiQGWhjLPHG5gcBe4SI34V/AFoR1rsuTx8rpvuhSvWayROaAG?=
 =?us-ascii?Q?4j0c/wC1Vti7AdonhnsivYI6WXJTu0FM8PTwjQ9+mxekdnHTI4PB/jr57f51?=
 =?us-ascii?Q?O/ckCKK8CgT8e7Jfv16tAt9pOrOfQCHPaU1mY2pjh3lm6JK25VAq7UmSapJP?=
 =?us-ascii?Q?rkloRfruoIlVnLPPd4fFCE5pwSr7YcRMfvL+nsuge4Ntn/ubFwJ4FyHOvSMA?=
 =?us-ascii?Q?DKhi/kEJ6wRwAjz2PrsSNuG1KGlaWrT4Tu+6C42l0WDuHU76emzwuoh30cSd?=
 =?us-ascii?Q?P96zOW2BgWvHbqdbxg1f8XeS88rdZJtlA38YOx0f92YovQ24hvNgnCMrb5e8?=
 =?us-ascii?Q?uifbAM2GdULM0Gk5iGWtNFk9gukgVoL+lm82Gpk91U2BlkaGSc/ZwomwAaox?=
 =?us-ascii?Q?Ow1yS9OEejLjP18cMhoStsPLkrWAyrrIBaSJySqJapA8HkVebw11VBYUYVAe?=
 =?us-ascii?Q?hzzG4joUx8rzh8VqJaWjGrSWrNGoBeUDj91B5gO34dLRKmm2dNaGtw+jZTal?=
 =?us-ascii?Q?npcQgaY+D/fRt4V3TLpzYK8QukZgX+e8UoT2KGbB87LMa/QiQ2XdyHOxepfR?=
 =?us-ascii?Q?esX1qkdSVW66qv5ib0/o0brIwjPc+2KNE18zw8ECUkJ4V9qfEeEZi1zQfY/2?=
 =?us-ascii?Q?EKJp6OAaMkpINO2/519DUsH5CCq8pZlXGelN6x98VFY2r6LAGiSNLxwapNQC?=
 =?us-ascii?Q?IYRd4zIAp8epygP2kIGTpRglbiOyYSIAG3VHcIIk5drvUHQAnmATvQ5zqzjV?=
 =?us-ascii?Q?O09X4wGvMJz1yiJfu9Ck83Q1EHrpcDhjjIkTXHz9I9+O+u157m2md5Q/Y6c1?=
 =?us-ascii?Q?uQFJzwqjTp4IibzcFuap0gW1m5NH7UcNoaIF0oL1tF4hIkgkhT5raLfxXShX?=
 =?us-ascii?Q?UtJl0lqJsgXwORZJAuVd7nRWE/nZqcAe651qrmcMMTkV84UZ9GQUnWfzr46+?=
 =?us-ascii?Q?bm2iqQBsta4lFcofx7LHXgoJeXXRpoWBzQ2D7cATeeyitVt/Uab1dHKJaESa?=
 =?us-ascii?Q?GtnmZ7xI/QqNV3raIWZSvzWul/Wk6A/zDqpCuQUwt+JUjr/YG6/eYTz329SR?=
 =?us-ascii?Q?BaUKUuw4ZOayQgR0iJ3yDU7tGpW8gQaI0UtEDMuxcY/N+5TD9LGQUvpxfUFz?=
 =?us-ascii?Q?Cbu2jGLE9RyMB6z/4G/NCwiBAJmOjmQdsf9SfAvNatfbHvIOihs8s1hwFzSY?=
 =?us-ascii?Q?KZiIUO2AU8jpy2Sq8zSeJEdSSvLKOHTzRh41?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:43:12.0983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe50f9d-b2ce-4767-86e0-08ddeef6ccce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5857

Add support for IP_USER type rules from ethtool.

Example:
$ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
Added rule with ID 1

The example rule will drop packets with the source IP specified.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>

---
v2: Fix sparse warnings
---
 drivers/net/virtio_net/virtio_net_ff.c | 127 +++++++++++++++++++++++--
 1 file changed, 119 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
index 30c5ded57ab5..0374676d1342 100644
--- a/drivers/net/virtio_net/virtio_net_ff.c
+++ b/drivers/net/virtio_net/virtio_net_ff.c
@@ -90,6 +90,34 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
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
+	    sizeof(__be32), partial_mask))
+		return false;
+
+	if (mask->daddr &&
+	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
+	    sizeof(__be32), partial_mask))
+		return false;
+
+	if (mask->protocol &&
+	    !check_mask_vs_cap(&mask->protocol, &cap->protocol,
+	    sizeof(u8), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -101,11 +129,36 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
+	if (mask->protocol) {
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
@@ -237,6 +290,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -260,16 +314,27 @@ static int validate_flow_input(struct virtnet_ff *ff,
 
 	if (!supported_flow_type(fs))
 		return -EOPNOTSUPP;
-
 	return 0;
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
+	(*num_hdrs)++;
+	if (has_ipv4(fs->flow_type))
+		size += sizeof(struct iphdr);
+
+done:
+	*key_size = size;
 	/*
 	 * The classifier size is the size of the classifier header, a selector
 	 * header for each type of header in the match criteria, and each header
@@ -281,8 +346,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -290,8 +356,33 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
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
@@ -312,6 +403,17 @@ validate_classifier_selectors(struct virtnet_ff *ff,
 	return 0;
 }
 
+static
+struct virtio_net_ff_selector *next_selector(struct virtio_net_ff_selector *sel)
+{
+	void *nextsel;
+
+	nextsel = (u8 *)sel + sizeof(struct virtio_net_ff_selector) +
+		  sel->length;
+
+	return nextsel;
+}
+
 static int build_and_insert(struct virtnet_ff *ff,
 			    struct virtnet_ethtool_rule *eth_rule)
 {
@@ -349,8 +451,17 @@ static int build_and_insert(struct virtnet_ff *ff,
 	classifier->count = num_hdrs;
 	selector = &classifier->selectors[0];
 
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


