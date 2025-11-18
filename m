Return-Path: <netdev+bounces-239600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FEEC6A20D
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A9AF4F6E49
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7926C3A1C9;
	Tue, 18 Nov 2025 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="seL2NQye"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013058.outbound.protection.outlook.com [40.107.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5472C35CB99
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476789; cv=fail; b=CNCbDXDoA8D8ZUYQLANIAz7y0aeZ+OVXlN2lH04nAPvq9ULqYd9XwWEbUtvYmcDB/Dmb2+dUdrqi+JKXBi6HrJhIBfxhQw+rRyXXgBmSiO+gRJJ/LhDJ2HiQqa8SAFL/6GT42ZZ3ZkCbqRGz7yoxUD/8zgWbr04/qwnD7QmpVSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476789; c=relaxed/simple;
	bh=xfc4PERDOgTn2+iTLqAAU2E6SMY1DlornEp/tEn8sis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uforJGjydOoF6t8Jnz3axn/zyvW90XEXj/XKG7JN3QCvs/Ou9uVOI8s1BK7IGIiyzMDQXtprqWlKnKVNal9d46FXzLoJ0+avXV2FKlBjtgnqXjctHhIR03vm9cUP+V1o75xPjGoWSq4LjNn5hiLqgT8PNjPwa3A913fC+Sr+lus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=seL2NQye; arc=fail smtp.client-ip=40.107.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgKFK2TiKQdwR3NCFC2T7pX30Fdxn/fnb9esDmMXmqjpmCRelJ/+pEDrJf3piPmUo4oVS+DArdy8fVyme1gdZtSlNEjj9CNSUbl/OlYS17fbK/Sw4GjRk1zhfl2SvPBjkYzXkynfuMTV68z6/S3Q4LLgPfGQHeG0VDPWcwwlFICk4vGT1YveIcUFj0iurdeqQ+FKYr34C2GOZKMjG5SYJCdQvddH1mOD/6ctzKCpNcumzmr2/5Xmy7LB+UAQW6RgAOwd/xhT7RNa/PlYaYzqfl+AgUcXy6Y/dx4+mno1RjEufUs52M7Lr3wpRNLtb0oDxq4h+q51Myp4q3xWrYKVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNOY+uizMoHynJr7amkUPUGEic0LRdytZw0ANdYaiu8=;
 b=PIKQJ+wNi2d1l2dMVgMX3iCOIA17Ktpcr08LxFs5X9JvEGJ7KlkYYov3DV0KpSO2VDiTVQjdjQJAPGjNUhU/W1ZiGSK9dNdnAW3wsE6Q3GsbO6Yb08e326op/JYnEN+kSyGzspEadpfn6L4uFvVmt2P2KkbM3th7zuh0rm7jdp3KlfI7aYYJHHlTISnQYHyvAuh0gpGKpCqCQbAFyN4pON6LT/N9wH9Jdb3sN3YBgNTq87gkHIfhvDaUSdtFxZ3UOltHXY8aeK3q8w117CrCPHsxzkwWa8++PKs+rDvAZDfICWNMv7kuGLJj4ypBCVYqaJM+Xd86PrSCKGUdeJZT7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNOY+uizMoHynJr7amkUPUGEic0LRdytZw0ANdYaiu8=;
 b=seL2NQyeIM/UhX2GqiRftfVUqVtIq5MkVd5nzoRTyfZ7Sa7UO6gYsG33bsl5iwuVdj41ATwBqy6Z+jaJpa2JIgOLCPN8Q9Z2JofHqaRhT1HiFFvQU7eaor+wqN4WsKdeOVd5qGdQHya77GgEAIHO9ZeeBaV6crNBhYWSFLkcL+pK0P8Ufi+phCch2dwU8xQLf2ZmEwYYREDEE/FOImEC8f1s2o7uY3Fs0kXB6TKb2gAaWF7hqSt1QdvQjPUigNzYaKRFrmJYXdKspKP3RTLslWRpJHJiCSBGiwGioJNfNbqgqSabrVE/UsRch4yGGlzWdwmdPS74eYV+2dSQbaMxjg==
Received: from BN0PR10CA0007.namprd10.prod.outlook.com (2603:10b6:408:143::25)
 by MN6PR12MB8469.namprd12.prod.outlook.com (2603:10b6:208:46e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Tue, 18 Nov
 2025 14:39:39 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::ff) by BN0PR10CA0007.outlook.office365.com
 (2603:10b6:408:143::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 14:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 14:39:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:39:22 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 18 Nov 2025 06:39:21 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 18 Nov 2025 06:39:20 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v11 09/12] virtio_net: Implement IPv4 ethtool flow rules
Date: Tue, 18 Nov 2025 08:38:59 -0600
Message-ID: <20251118143903.958844-10-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251118143903.958844-1-danielj@nvidia.com>
References: <20251118143903.958844-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|MN6PR12MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 40abc3e6-b91d-4be6-6140-08de26b04dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lHHHmCxwdCQz8WKjsYpXXeuVn3j8Bqcz7aHTEiGYwfLUN8DqoJyWWB41AOPZ?=
 =?us-ascii?Q?5uTn7Sma6Ki5NH5dCC1uZIkL6lKpwhZJGWVdYpBOHhBHHt+FAPzci2KCChsn?=
 =?us-ascii?Q?jp1wIIzzKFxB9SRZ2/gHrXwMe8e79Qr48msmfGU39kLBSERHOq3y4P0P4JHc?=
 =?us-ascii?Q?8IbmEgJUdInxwt4uoeUNhY8oSEq3E/eOG6IlsJSovCT9qAvBJR+fNrCVM5AW?=
 =?us-ascii?Q?RxgQR5hCm8c2BN2t39BVu79JV9TLQqAyc6nF6Ti7c8BWkes7rVhB9Cq6zb1t?=
 =?us-ascii?Q?OwQbD1x5zUT3WnqgWdMAj+wcxmX6Vz0eaSfALYtY5RKiTf78VWm8JgcwHTxd?=
 =?us-ascii?Q?E70CgLrTvW9jAH+OqDx9N5zbuqEpfoNCJpupvIrkNub99MFMw+kqx2s9tKAz?=
 =?us-ascii?Q?pGqcBHfC/pLgpP3R09zg2SWIwr7s6jUSFNBeRA+V4x7YU5AW3wQcCkxe1R05?=
 =?us-ascii?Q?qBETrPtC1TNxUIIjaERu9u6nUYSqCtg8Sqgl+srRkB2hV94qNz43SsPhd79w?=
 =?us-ascii?Q?zTmnsAKjeqExRVufrqrO2zbfn6yH0f5GMiLl38FAodTo2diUlxdzAUXgGzEr?=
 =?us-ascii?Q?F4d3w7LhKKZmICT860o/MvQNpxCXPadgtkSZMixnIQxxkF7Ji06wRr+YJm++?=
 =?us-ascii?Q?emRfgLYSWFxh3zzUuwXvNtYUTz16dY1Evs2EWj2zBrBIV+lamOVz63MwSijr?=
 =?us-ascii?Q?b0ivwMK8lRyeoMsbnK76ImYnx442njglXRogzG1jSBQM7fsMfgax2nSJk6Ez?=
 =?us-ascii?Q?PJxdKegYTa3zKYpKsTMCUnA1wWG8kEO2UU3TAc0vN9k+CgZIudG0vkOCcq4s?=
 =?us-ascii?Q?Owd5ccUI13DyLtVDU3pfJkBXIXA+s+FMhKPeLb+hchn7yUTLrywUNEVWV7S9?=
 =?us-ascii?Q?A/OnFKxc6jI1AhxOJ0eNWwDrda9IRiP665IQablLKucB94BK/fToILchulhe?=
 =?us-ascii?Q?HATSpMVIuVRm94OW2+D65lTaIPlKg18Fb2PylbcOiNKuiClcfQA4Iy8FIA8c?=
 =?us-ascii?Q?WsJ31+YlwzO+E473/5/umO+LNUvcCy1F3pZLwJXzuW7c2Q78otqHmvMMeACy?=
 =?us-ascii?Q?6OD5A4H9X2J2DS/SA5CbncedtSPnmLO9AkDreOe/XjZeT2OrKnRaCPfdotm0?=
 =?us-ascii?Q?oOzEe8JXs53uK2G0LrlTPdU3sLKmWzWv6YdkMlOgGL8Tw61alpCFD6CpWnz3?=
 =?us-ascii?Q?RLBXSasB3+BLpA59koM2tGLLswzYIa9jyfbI6sdZwnT+/JGreeb/GBaoxTKm?=
 =?us-ascii?Q?k25nyIuMpDS1DwnhteOofIKc+vGWGlQ1rOt9shUo4N8RcesOp7HYnb/COJuE?=
 =?us-ascii?Q?FoT6zqA/ayXBHqMObA/VnHI1MO2wCxCo90s9bvKCGBFPQkDp9l9a1HIuN+pv?=
 =?us-ascii?Q?uaggYoDHVJjRIwRa+/J/9Go85pRawE04E6gMW6EBPGim0n9NhsXF2S3lyBFd?=
 =?us-ascii?Q?Xn2ZBRIRltzjNWbFmDyNObWHN7LyvTqUG0JiAOdrhQAPvTf4v3SsUOm+FxtN?=
 =?us-ascii?Q?xo2XWRQviVegmowXKsg4UWbCBPcs1VpVwsYXwSHsqbj0B/Kzga/YqQ5O1c4F?=
 =?us-ascii?Q?w++lmA3UX58Bg29sbzk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:39:39.0652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40abc3e6-b91d-4be6-6140-08de26b04dac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8469

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
index f392ea30f2c7..c1adba60b6a8 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6904,6 +6904,34 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
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
@@ -6915,11 +6943,36 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
@@ -7054,6 +7107,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -7082,11 +7136,23 @@ static int validate_flow_input(struct virtnet_ff *ff,
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
@@ -7098,8 +7164,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -7107,8 +7174,33 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
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
@@ -7130,6 +7222,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
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
@@ -7167,8 +7266,17 @@ static int build_and_insert(struct virtnet_ff *ff,
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


