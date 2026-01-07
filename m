Return-Path: <netdev+bounces-247837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EA7CFF174
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 18:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4391030049C7
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 17:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2A835FF66;
	Wed,  7 Jan 2026 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hbDPORHP"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45056331235
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805515; cv=fail; b=E8VCTHe6uU/JqVYL4uGEXtHstdj8QT2DK+U9kYBkRxxXVJFgzU5/5qLfGUJDWoPI5E4BdVCTBaR8qgJp+95gzUunBM6TLdu4oJy5bg61hAsoPrzoGohadI7HzQcpPQE0qH8oU6Ugmbo/uYtpQyyF0K2htsigrVY2Vq3cs79GZ6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805515; c=relaxed/simple;
	bh=jkphN7s8KF2I6lWVYKNJyK8oO9LIFuwBxsK002hIOEY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=abIp5qr8vbs7N3snEGSLyLIKjAlfBlfi0m5/hzW2uJbo39Z3sbBArIhhkkrfC2do+DbC4Brnb64vzyIIIjo9+FZZEQvAfC0tDlieLRihdl4JR/J+fCOHYI6gKcTv75Qm5pGyMMekDMipqHqmpeFKeN5i/YORqgy7PHi0S6am6rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hbDPORHP; arc=fail smtp.client-ip=52.101.85.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yM0ThjFdUN68S+llYNls4/uxoOijWTOPN2xP76XHM8yDUdzEUxVzxLuaHUTp6DyF56NabELhJ8XwOplKWY2OUV0EEpjZbnEJF1ONT3D8I+BbXBz5Fimf+P75mGkwGukMWNTB3noMXr/KO+qMcVXyMpVwSKnFcMznpvJRIbBkIClL23dxVWiZGkZ2vHn7z0kazN6dsVRuAeil7ckM7popze1QRV63qTSjdQ8f2lL5XdH4+gclmHBXFEdWE2iYcqJhnnmo3+1UO+7l3JS5biqwdsE76MiXBzjiX9zLbPGegJi0Nn1/gMUNC4znrMAc2BF+yURfle2VTWEyDVN97GXCrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Crvi+F0wjDihtijZhLF8AvhGh49xnLIamNJbgCaNFJI=;
 b=ISUhT7clPJT4l5T1g1sGFWDkPZIntCNyUkb8I+SQjFzPJjw0LmK/Vi+T3IR4K5Agrgx3xgDLUdskSWmw1PGGoN/C3kqqdJXi6JUa8hJK70YmbOVVf+MSMXb0hUQ75f00owPByd+/ngrhallyfeU/lpV2nE9vT+BGzk3Kbus7yqHc9cD5av0G3SM69opZLu7P6CnrNkLAFkhMfX7mqZWwrw5kgPlBuy3e18GZtZre4UQu8OEt93pbNJnAWN2yNzc5+X274y7C0AmsSbZz0oAVSAzKMkLFpJhA7gPbNht5DQciUMMS/gvTkxfblIxm8Q8CkN75S1uHUUXQLRAvyDxm3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Crvi+F0wjDihtijZhLF8AvhGh49xnLIamNJbgCaNFJI=;
 b=hbDPORHPEC/1/EGMTJTGDxPQ5T3VyfLeVEvMJMwg6ciBWxnIM/tFiI/DJS6jUH+5XAZor/nipoQIANFJpqojmNWipmUbpFuPr7YopQXVimdZ3QHOGWqHMaGhOF7ySFVs3sbjh+qYbZRioFN/TeLaA/oFKQhcRBkOs3QGaSc3MtktrGCJdVtZxCX2VGnfMQNeBtsDqp6TAOcLs4hAZCwhKvzj386hPHdG4O4RJ4NtIuRsxFlnkSb44sD0bnAGbQT3YsBR8mq7hDn0OtG+QoIzUWsK+rT2cQqxhaZhK4Adq+0zPNPJKtuTgmAs2jydQrqktwy2Wou5+YAOUdXSkJQFzg==
Received: from BL1PR13CA0293.namprd13.prod.outlook.com (2603:10b6:208:2bc::28)
 by BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:05:05 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::a0) by BL1PR13CA0293.outlook.office365.com
 (2603:10b6:208:2bc::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 17:05:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 17:05:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 09:04:42 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 7 Jan 2026 09:04:42 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 7 Jan 2026 09:04:40 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v15 09/12] virtio_net: Implement IPv4 ethtool flow rules
Date: Wed, 7 Jan 2026 11:04:19 -0600
Message-ID: <20260107170422.407591-10-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107170422.407591-1-danielj@nvidia.com>
References: <20260107170422.407591-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: beb0637c-d909-4c86-f73b-08de4e0ee718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LEEoLgeLqvBsp2zrnxirOEteiGN7n5bUoeiN4oS2aexhCtHZW17mBUJOs5zM?=
 =?us-ascii?Q?8tJrrdVgQWsxVAf7x8Pd9rNCgQXHPWZlKiVd5mDRvkrLgt2bN1Cm4UlG0tyB?=
 =?us-ascii?Q?RX+k2dSCiQzPYLAaGRSkALzLxOysrFTb6qd2efZJfaigEbr2CrExyQHX0sQy?=
 =?us-ascii?Q?Y3rnTZxy0vPh02pWLv/1l+oFeuvUQIC+He567TdCAux2ystTWnyokewdrBsn?=
 =?us-ascii?Q?oOJ0lORZDdDAohESEf2lP/nbHzne87ouXYgoBe8eJAm1FL7uTkIwsCA/eTHF?=
 =?us-ascii?Q?2us9swg5dcFe9BhnvmmGfqEJoREvdPkwOHK7rsSDrOHV/qcIzRc3j6UVKkkf?=
 =?us-ascii?Q?Z+xjJzdx25e3DZiPBvsPoPlaEBJrCAz0lEogCH8gW/qpGd8OLEFy+cREvTyW?=
 =?us-ascii?Q?IKzhbgCn4tTKVw3bIhdcJJ/e/IhG4p2TunhLlU5GI+XaU8zxEZTwFakXdkct?=
 =?us-ascii?Q?P2nG58mZkYkvDqVnanl4uqZ3Asmx16Qe4530NvbS3vqV10lf7nJEZCQd6DRY?=
 =?us-ascii?Q?8B3y0VmvMEy3IwMm2NfNqpWjTrzRZyQhdVV3DweBRNhv+9q1eP4BGUeORYMG?=
 =?us-ascii?Q?tBcB+sC7SEztQpPt9f0KzZDic44U3umlTROg5KbhbC5bW1N5ZMWp6PV1hLeA?=
 =?us-ascii?Q?xQIqTwQfhRuONX64KR585WQIYSeVp1A5Uz06LGIwmKneCq8yWnyAPbUp1Yxn?=
 =?us-ascii?Q?R6UjL7QNyx+TtOX+KaQo9exIAi32vLpSvMFRt/0cRQ+exeD0QKOO42hCloDZ?=
 =?us-ascii?Q?JuOgBjSb2D7NBpabAUvD5fPRt4o+N8a8y7Xwyjz61r6XT9rK0/3ie6OqRRJc?=
 =?us-ascii?Q?cghMJMPocTCatLCvGXrbs6fIKKIJIkuZxDkCeV8Mm9vF7CbYO5aT/v25vdWS?=
 =?us-ascii?Q?kxsH1mgDLjJR38+CWrkLoWaz1nGbh02jOv6vBVEaN1evsaJNIXphHECX9Ub1?=
 =?us-ascii?Q?+LpLFMqDmczur1WNQRpi1rK/GlLFN/ebAm5eMR/EEEY3vU2vqZqpUFekpuFe?=
 =?us-ascii?Q?Qp1tz+t+WaJ3pHZ8JGkfMeuiBpNO1Wdb26bOzi2ZLAp4dwrETDx9YKf1mcJ1?=
 =?us-ascii?Q?qq2g7zAcQJFakDc5gh7hpl9daPyxCPO0CIdQx6xdnwZe0LBwVib2Zp+ePdfB?=
 =?us-ascii?Q?FLu17W7sw8752RISeNnP6PiwMUO69+uvegxhDYMD+TW1yWXMLORcE1dH7xN3?=
 =?us-ascii?Q?UkZ9JEYKg/tAqy2boDSEj5JxedRlYdVIAqQdUVKBvDZw16gaF+82LRmcslCy?=
 =?us-ascii?Q?KV/ZK/pJoBm+g1/zWK1oioEtEKMJXEIB7h+mhKbGF5gfZmQrzRbSwMmvP+mV?=
 =?us-ascii?Q?B+ecCiOkWfSjBiTtaX3ktVjqIeA4qzHEbCrGJuJ7mcBSfGv/iNMpMbl/37g0?=
 =?us-ascii?Q?rim95IHau4BW/++aQR25VdA+sZAHCdQ77QngwzmQLS9akT4xOwmz3UBjdavy?=
 =?us-ascii?Q?fQdCweNzvrgvT3B4SHBMullslmOr7Ezf07jb3nfaxAcCaJB5UIvHCdtQpD4A?=
 =?us-ascii?Q?Spp02tRJhw2Mn1JHAjfKtCLABbAYJSO4kty2H3fsNnAU21LEjaA57bisOLqh?=
 =?us-ascii?Q?HpJqtKh4fK+20Ym9rsQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 17:05:04.5646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beb0637c-d909-4c86-f73b-08de4e0ee718
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226

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

v12
    - refactor calculate_flow_sizes to remove goto. MST
    - refactor build_and_insert to remove goto validate. MST
    - Move parse_ip4 l3_mask check to TCP/UDP patch. MST
    - Check saddr/daddr mask before copying in parse_ip4. MST
    - Remove tos check in setup_ip_key_mask.
    - check l4_4_bytes mask is 0 in setup_ip_key_mask. MST
    - changed return of setup_ip_key_mask to -EINVAL.
    - BUG_ON if key overflows u8 size in calculate_flow_sizes. MST

v13:
    - Set tos field if applicable in parse_ip4. MST
    - Check tos in validate_ip4_mask. MST
    - check l3_mask before setting addr and mask in parse_ip4. MST
    - use has_ipv4 vs numhdrs for branching in build_and_insert. MST
---
---
 drivers/net/virtio_net.c | 129 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cc7de2a3989f..93be689e0ecb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5904,6 +5904,39 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
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
+	if (mask->tos &&
+	    !check_mask_vs_cap(&mask->tos, &cap->tos,
+			       sizeof(u8), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -5915,11 +5948,41 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
+	if (l3_mask->ip4src) {
+		mask->saddr = l3_mask->ip4src;
+		key->saddr = l3_val->ip4src;
+	}
+
+	if (l3_mask->ip4dst) {
+		mask->daddr = l3_mask->ip4dst;
+		key->daddr = l3_val->ip4dst;
+	}
+
+	if (l3_mask->tos) {
+		mask->tos = l3_mask->tos;
+		key->tos = l3_val->tos;
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
@@ -6055,6 +6118,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -6086,8 +6150,18 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 				 u8 *key_size, size_t *classifier_size,
 				 int *num_hdrs)
 {
+	size_t size = sizeof(struct ethhdr);
+
 	*num_hdrs = 1;
-	*key_size = sizeof(struct ethhdr);
+
+	if (fs->flow_type != ETHER_FLOW) {
+		++(*num_hdrs);
+		if (has_ipv4(fs->flow_type))
+			size += sizeof(struct iphdr);
+	}
+
+	BUG_ON(size > 0xff);
+	*key_size = size;
 	/*
 	 * The classifier size is the size of the classifier header, a selector
 	 * header for each type of header in the match criteria, and each header
@@ -6099,8 +6173,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -6108,8 +6183,35 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
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
+	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
+	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
+	    fs->m_u.usr_ip4_spec.ip_ver ||
+	    fs->m_u.usr_ip4_spec.proto)
+		return -EINVAL;
+
+	parse_ip4(v4_m, v4_k, fs);
+
+	return 0;
 }
 
 static int
@@ -6131,6 +6233,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
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
@@ -6168,7 +6277,15 @@ static int build_and_insert(struct virtnet_ff *ff,
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
-	setup_eth_hdr_key_mask(selector, key, fs);
+	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
+
+	if (has_ipv4(fs->flow_type)) {
+		selector = next_selector(selector);
+
+		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
+		if (err)
+			goto err_classifier;
+	}
 
 	err = validate_classifier_selectors(ff, classifier, num_hdrs);
 	if (err)
-- 
2.50.1


