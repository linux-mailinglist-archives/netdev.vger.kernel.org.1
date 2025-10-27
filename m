Return-Path: <netdev+bounces-233275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1F7C0FB9B
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9058C46026D
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F298D3176E6;
	Mon, 27 Oct 2025 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q+d4xROp"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105AC31961E
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586854; cv=fail; b=g3AAOHN9DfciAa82FMcW5Wmua2pYvZfejBVRhpldnXnidZ4MaLkqoK5gOTMG7FR9wyr3qLp+jJ5Nhtl2/J1IgMtJBC62ry1dw5fe5AmgsX6QowKodXAcmGIwmu/xbHgyTrOYjIhGR6yUgjAHKV6mlQhcfS7MLvVJ6aZctAcOpew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586854; c=relaxed/simple;
	bh=DKsM2qbCMDF04KxF+oYpMh+fIXhh1rRuVgR9udUax6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkpPUaoKR+vOsV/l+JWmKzIJe2YBYgRXLHbbII2pBjmntF0ywkLqj87ChCBzpFhQyTyZl2tqiElKdX20PnJ/0gJBWK6ezsiccqW7n35rpLi1ndrnTcmSUEenvVCTSznsZ3zrZMUzcqlgptgsFNPefai/+EJx8KhJD/aFJA9VksU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q+d4xROp; arc=fail smtp.client-ip=52.101.53.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MF4EOysniv9fXdPhpRiaKuhTLM/CmwxCRJzTJNcwYK/FpYJjNCr5u+98rIeFLCGA4bhk9iG/H7d3zO16ynYyDoT1dFdBehYnyoFPTBPWeewvmvxPUkSZIyGohZ3ucZvcP+Q+VjvZOoi8uFNuIT0ovNKJEUJFscGljebX+h9PBjmv6+UjgkwlXoahsIhe1t840noYinSbpUuILGXGUO2YLb2WKz2Mn2EbLBZwM5kcr9osY716VX6PN1oHCD0eMY2F/PIn4Bp0hMF4tU7tBAtVGbTJp4wMNspYggu+BShmh9ihfWDAuJHUW8FicWyhm11CnZkvRWDtRTPgjbeDXdILcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=truxtnnF96J7nqd32a4eVdAk353rS1XNx+gHUbQhZbw=;
 b=uNJkzS0Rb39yOUNiJ2dt523KHFKLiLYPFbwSquYaF08XUxG0OqN5TyKXXqT478pQwzxjxFz4Vl8HRt0FbQail6wb95F07cSvFPX++5sydkBtJSk37n8oEX+djiHGUAbtF0eQKw39b5DVGbXfkdXh3iOhRAw7NiBeXaw/Ed3X24kTtJJgwTZg5kuoE3ay0mlkfAzF0umCo76r8jGID7rTBOSWyTouEvxmiQWTxs8cxkAeAACE//P0vtpePckCgSRf7m6UAI5ltdXtExkjTW5bmAnMdCvYoA5VO4rMBtgDiwsj7UA66srVGpYvM6HBRP12vKPoQbmHQ92ojPrTCI/zcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=truxtnnF96J7nqd32a4eVdAk353rS1XNx+gHUbQhZbw=;
 b=q+d4xROpQXou6XOy6L6KZWClP3To12ZsmQ9QogbFYQpzmQC/18WY3zMsOkE1WVTMQLe5jjtDfWW8pg55uIaZp5xQtEYbL/kj8OxYiCnV165ywCTkdCPxgkG/tX8gaJrVz9EFwz22rIvVAj90NpzhilOLJdCY/i/DRyndQ6VODjkdoAD3snSfjqaqdyISmRv4fiUvOMgqPg3v3pa05LsBzFWNwS7o5S8+mawKOXnqIxyZrs58rZZ3fojj3gKiJ6vGyljv8KzGvJmfqv7ThE42uQaxFGxr6B153b/MVTFE2tGFxDfMGgg1RwEBSokcw2RXSKkaQ7vaodp16juMAnbRqA==
Received: from DM6PR14CA0060.namprd14.prod.outlook.com (2603:10b6:5:18f::37)
 by BL1PR12MB5803.namprd12.prod.outlook.com (2603:10b6:208:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:40:49 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::58) by DM6PR14CA0060.outlook.office365.com
 (2603:10b6:5:18f::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 17:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 17:40:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 27 Oct
 2025 10:40:28 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 10:40:27 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Oct 2025 10:40:26 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v6 09/12] virtio_net: Implement IPv4 ethtool flow rules
Date: Mon, 27 Oct 2025 12:39:54 -0500
Message-ID: <20251027173957.2334-10-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027173957.2334-1-danielj@nvidia.com>
References: <20251027173957.2334-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|BL1PR12MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: 795dd0e9-c4c8-4a32-9a2d-08de157ff751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/5Lifw7K2nawWLR6Rf1W0aHzeGua03/egtdihSSdi0aMVNoyTW/hJFEIzcDo?=
 =?us-ascii?Q?iuSzIdPlIIKNOManmkbxfi//00IQRQIHrBNnIRSaDDYE+ryYW5diPPHFRhia?=
 =?us-ascii?Q?vhzCwibHMAEF41CF/TVSsWD1FOcy/nqAKVWjfU120uGYTxEYr3NgWHQKaCAP?=
 =?us-ascii?Q?hIyyl0FZ/F9g91y1WBObH7EJ542S2NJ1VEQ5kS9qo9JMaXo0UOdZA1tplyvT?=
 =?us-ascii?Q?HarCR6jq8aE9p4EwkJ6EG4ggnDnaU+U80k19VBqJpJtNCx3RzIAyZGDAHaFH?=
 =?us-ascii?Q?5YihMYgOvIg/PB7IGv6yciNu80KY6RRTPp3NaJT/JP5TgHFDRyprbQ6qRqUO?=
 =?us-ascii?Q?yk/DIKJss6laYj0E5znH5HJtxbTypfbxE0J/Z6D8IUBxvEnC/aGC5hC2HlR7?=
 =?us-ascii?Q?5wWDSfDgdldo3wGhmigXbKo2PNsVdyTnY44HZATzHC9cmpCg7Ph9l4mST/TO?=
 =?us-ascii?Q?Bp2+4fq9OlvjUsmKrkp7GPI5lcCTV5q227RSlinzp4526Mmn4hSnyWXMZHCy?=
 =?us-ascii?Q?8mNCBQ9noKE47l+3qHJDe8W3ImRGQ8gYncMFNeYCahKaTzCe7JOh2h9ya8K9?=
 =?us-ascii?Q?Ko1SU8W96vOc70nzFpCjBymd6JwevgDHg23Iq0iq9eC34MaFjz4Mn+L7qzKL?=
 =?us-ascii?Q?Ch2Dl6dk30eq5Nx+hVp9be4R86oj6dVaCBsp6OfR66VNnW50KtVE6wws0TKL?=
 =?us-ascii?Q?Y1wYVXnIFJQAVuAHC2R56j09E4BLxdGmotb9GKZ/zBmBLQ9KSdFkzT6PUEf/?=
 =?us-ascii?Q?KwcxtQOeIjT6NlCie7VihN+5lSdsHIlKSgazZR5KRD3WCWfJgggiDZ51Ik5K?=
 =?us-ascii?Q?nJjPemgndwuh6DdLFZr+x58M7tqf7KJEo5BY9oHHYzSyu05yN22IVT3Km8tv?=
 =?us-ascii?Q?QuczOFDU3o70HBP1W3sfJVZWtug9JgusUL3KNBpNsVNhKVk6wDwP8kqaQvs4?=
 =?us-ascii?Q?IoDrBvXMkrjalOpOBvzcuR2vyDJ7nQ4wSfnLblng6Nv+U5n/Yc8rVQmGUe/F?=
 =?us-ascii?Q?OFV4FcYaetIND9i3UmvTkzWog0Rq1pbItMFxwZ3MxuTaL7iAfhjfmFxntpPC?=
 =?us-ascii?Q?PsJNDoThxDeBX9SlIFKza4czpeN3fmUQSlU7qvbE2cXyO1BuEH7lEwyiH5wV?=
 =?us-ascii?Q?0HfCyqsfZyrs2AsFraWXscgUHT+pPaqBm/3QrfuD6d8Qt18HhFzIbPlBTwt6?=
 =?us-ascii?Q?7rw6kw4m/+Ocm1nLfOcCw+MxDmdAOKCkCISrZ6+5S1KiB1a8X80kAH8GIxme?=
 =?us-ascii?Q?Gn4TgZ8V3a4c4790Zx/CvQCCuqilu4oV8tLsHrmcVZNQ9IxdqAgIKH+eUAP5?=
 =?us-ascii?Q?+U1ZwoWwAl2mIbBSzSiMhRuBw+xLjZpoxYM/tmc/SC+MKCAr4yVqugqhfyTf?=
 =?us-ascii?Q?iTwYGuJkfZEr+xaDRmWCIfWifb3XUHY4vdCZd3+ps86fEYTL/XgaqSVLbFN4?=
 =?us-ascii?Q?SPNAtsBgn2jySsyE8ANpeE0sfy5w5Bt6lTAfd6fPn/o2TyKoXLGchwtV7DpN?=
 =?us-ascii?Q?+k/KMepQuC/kUaImBU9Pld5HlavnIKQ3YBKqSV8USsvccCfmYMag8YjVDyC+?=
 =?us-ascii?Q?nh+1WLCbNZw9x02b+cA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:40:48.6059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 795dd0e9-c4c8-4a32-9a2d-08de157ff751
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5803

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
index d94ac72fc02c..79313627e1a5 100644
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


