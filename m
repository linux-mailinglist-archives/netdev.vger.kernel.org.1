Return-Path: <netdev+bounces-228832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAE1BD50B0
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B1B2561C02
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9806A31A569;
	Mon, 13 Oct 2025 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e/oq8bqI"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C026031A542
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369316; cv=fail; b=HS66IultFrQQHk02XO9KdNaSiEqOeH5StB4M5ZCszKyJZkwZc4KOYvCwkIBWpDipUHa3DmNie7Xs3t8hOMCNgkSI20HwAVX+VWIs80RRSdCtJFrH+n+oyufr2RBYotYXXPWxj0VkchmkoKpOnyfYAFisgEApeHO2/yNtOvhnshM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369316; c=relaxed/simple;
	bh=FU35D58cae/VSoWqVU+C0EZ0Ocn0azyAYjEuL1ASWWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ho59ilfiK+hi65AVLWi3+I/FFKQ6wnkp75NkgijA16X1Hc6KIhCae+DIkyKtlVmVS5GwLNmy4yqysTIg3IdtGnrLyWLYbCRunSCA3GIQWJu1yaYFUYzKfL/d5cpje/N0j4AkxWhIntQANXsm0SXIAP2tGGIAe5TE4gpSGG9eFhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e/oq8bqI; arc=fail smtp.client-ip=52.101.61.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoYmOC8AEItjd/c0+T71JBLRsG4wiS825F2AHeYB99orNgGRDTbKn1V3T2a2JQlgcm+SURteGR4chn7sxHHa48g1rPfjxVxIhJ3xOsVbiOr7ynrL4BfQwfLWmWatf6bmMR400QSWE7hNi0qCGXzly8mKXtSbbsty52E88K6UY0nB1aKHn4owJszsyF0zLFPAkynDWooWHJwoV3kLaA3l8/Me1b5+x1AVnm7cp9T0FkduRW1CCfZOECTZoDKwD7nzfVIvKOuPiqfKcmOPMFm0DiZ/wcSpVuohs61tf3kr/C0XorQ2WryhzegiqF+qSO29pbXl4x2xODtToQGWn5gDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6chwrtpC6b1VYiRaJhoImuROJlsxHHojaKSCg8YvDdw=;
 b=hjB75V0slEe5OBjo8EwIHsasXhj1Z6BweojU3DWcTHmKO+NEpPXYljFJYpn8D7FET+7l/RGMWk//1KIjndbfg6Hk/g7q/TVFzMz1GyBWPj19iHgdoPihDfV1KGAAouJx2vElVySE04ekUcY+Mac2WwNEnP/T7uBIBOGGBCSCEJZsRSZSNzMjB0uAXY86IdhHMAaTCi+lMAitUAjIAYaW3TDI3YE1k20bW/Ql6KSRlbd6I7xpPUYfV2AEfZzR/8gXCwMM/cudX7FOObP6cPR5ZNZpD5Ocgoa8QNCEcs9D+qTgqisZ8vP1M29eb2e9SPaQbedBx29H4v5Owip4gOwpQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6chwrtpC6b1VYiRaJhoImuROJlsxHHojaKSCg8YvDdw=;
 b=e/oq8bqI93pwn/NdzLZ7VcfnKmI/zoSHm8EuQ8oDPRciUZCN63si8bcoadHoPI7yzEoOXhiF8NYRUEGyGcbsXkpoxxVyFS449exUGJTbMJ+WQVmmCP+AfBTrUfMZkwKr+Rv+oHvNq7CnNemTtcz5n0efW5+0hbE7ptxqDiqozEMmOZCWsArr3Aj5Zgj86SGvK6qxu5kSVJ7WWVCsc+88l04FG5uAaIzXJv1ZQXavdZnwrdRSMBeLY8y8AgI9OSVksh8yccP0g//5EH0rRB/gOgWOXZiLzaf7v8TVjlPY4H2VYQqQ21rNS7NhfyfzpyghdcGU6/geiZT1VWwUKMa91w==
Received: from DS7PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:3bb::28)
 by DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 15:28:25 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::7f) by DS7PR03CA0083.outlook.office365.com
 (2603:10b6:5:3bb::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Mon,
 13 Oct 2025 15:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 15:28:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 13 Oct
 2025 08:28:18 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Oct 2025 08:28:18 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Oct 2025 08:28:16 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v4 09/12] virtio_net: Implement IPv4 ethtool flow rules
Date: Mon, 13 Oct 2025 10:27:39 -0500
Message-ID: <20251013152742.619423-10-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|DS7PR12MB9501:EE_
X-MS-Office365-Filtering-Correlation-Id: a90abd85-9e83-40a1-014e-08de0a6d26bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WePZXTNnii6zu7f+jgXBvg0v0S2rq/TwJ1vgZgpThweQfWAEBEg6GriAPeIz?=
 =?us-ascii?Q?wNOrh0JsbxAPlCWLwX4dDuH/g6hU5TEOzdKknGGU9n8BF4p771vEQkUTm+b8?=
 =?us-ascii?Q?d3KQ4GaOrEAkrJqcvezN+/4nmsrgWE17/gI4Nk5A8+XofpneNTz2/FexBJXT?=
 =?us-ascii?Q?EsUM5UTNt0bvK5M0ES1w0DiEOKOU25HhWKogE3MkiwQeYC1djgIoLEcSPct6?=
 =?us-ascii?Q?iTxUaKBoltpFTEmFiC0Sb3dUy0o9UWWb8KFWKXjYLdioaoEJdVS36nyGT2nB?=
 =?us-ascii?Q?TwI6Ef1F5htHRL8nwNiEYvAyIHE75VY69xca+2j7iPtCsWNI6Les4xzz540n?=
 =?us-ascii?Q?rtZt3ozFn9rMQAZmTgNgSnqlsMLEI58HvNRgQUGBLqDWgThuIcSOe3EkK8yz?=
 =?us-ascii?Q?hBM1mg+qBzLrhYtsWXiXbjmGk8AVuXgKnwx0zCpH0PvyDIqvZrsm3jF+sdVo?=
 =?us-ascii?Q?SodZ/eWHnlusnFFjuv8deE6oPgEA6vE/xNdaiu/zQzXXOZ+PYcrCST171mc8?=
 =?us-ascii?Q?1PwL3/3FaG7tOxfbo/z8YN466AQZe5IojTy9f7mE/7LOfWAYHzfCns6itEb/?=
 =?us-ascii?Q?54aneh1fCcQhyu4Dg53NggiApHot5/vuHoJSPgHUNPqNksUtOLZylaNyKScH?=
 =?us-ascii?Q?/GQW0aEOHpGOvl509Ae66nn7GimsuLjxqg9/32/8uGW7zrhJwjzE3irivciA?=
 =?us-ascii?Q?QEmJ9qDxj8zIU9sEriZKmgmwtrRRgfo6iBcG9PfZcCdAXud/ULJcdOSJRSbD?=
 =?us-ascii?Q?NzS33i7G5Rq0wPOin9fYu82w3rSawJS1I8pd6hZb/yhWY428TvVozpxIr7Zd?=
 =?us-ascii?Q?zKK85TI1jq5O9dp6ZBNmgifkVINteRcVXGj2LqFtHr7YxKNntmhADnWgQ4jj?=
 =?us-ascii?Q?45X12MqIx8T8Y49rruN+j/xqO7tzxzAM10kdPB1eLDonCvQirXAc9znKPB44?=
 =?us-ascii?Q?MUQkTPujk5BEYPda7yB+zR374VByIBbfA+/TS+tCKQUN8MzA6WqDB1IYPh2m?=
 =?us-ascii?Q?gCfG+647obtYVf/4mgnglK/BncPjoaDUGhQ1GgvJIokZNLWMUiXnteTzBgmg?=
 =?us-ascii?Q?YU5O6x8ncCP3hL0H+XsMKqBcseD/RyhvpYcgl/H7MtKpQSgbJbpfRhlY1rUc?=
 =?us-ascii?Q?K44RBg/LNXD4Pe7Cg7dovU9LDTQrHYxLLRmYjLzns+oD/9Hvoeash1sNedBw?=
 =?us-ascii?Q?hKUS1RMxVd7TEyE03Jnan9UHEvTh4uQT9YxFW7iP2zbRJ507fs8V8j1zHPVq?=
 =?us-ascii?Q?lQz72r6+K9sfblfa9zFmyUJKcZXG5+Sqk1djReVk0SV3rmaHRw4ddoTGg52F?=
 =?us-ascii?Q?PGFdGKKb9XedzbPICONPW4ppDkKO4+2TTAHZHTn1vcmmJAQBXi3tiDgvukVN?=
 =?us-ascii?Q?BqOU5F8oa6bKkic+a3EoFOkyebZWNbhcYD77e44t/95C8CnVZcXHdiMHwtOt?=
 =?us-ascii?Q?Z3QXxw+jy1GuvLNqA4psxhpKhQcOSGM9Mge3EJuMYZ6j9rIJWiFTjChxaBqH?=
 =?us-ascii?Q?DKFDahv56lfA64dbxrOYTIJBZcQy7waMbFq6/dRx3M6j7PjU0UdRdRHUp5zH?=
 =?us-ascii?Q?1HoT7TZA3YjUNwkPX6E=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 15:28:24.9368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a90abd85-9e83-40a1-014e-08de0a6d26bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9501

Add support for IP_USER type rules from ethtool.

Example:
$ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
Added rule with ID 1

The example rule will drop packets with the source IP specified.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
v4:
    - Fixed bug in protocol check of parse_ip4
    - (u8 *) to (void *) casting.
    - Alignment issues.
---
 drivers/net/virtio_net.c | 122 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 115 insertions(+), 7 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e0f0be40c238..5f6e8f0a0121 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6884,6 +6884,34 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
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
@@ -6895,11 +6923,36 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
@@ -7034,6 +7087,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -7062,11 +7116,23 @@ static int validate_flow_input(struct virtnet_ff *ff,
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
@@ -7078,8 +7144,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -7087,8 +7154,33 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
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
@@ -7110,6 +7202,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
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
@@ -7147,8 +7246,17 @@ static int build_and_insert(struct virtnet_ff *ff,
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


