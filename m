Return-Path: <netdev+bounces-217412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCD9B389BA
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 20:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E13820795A
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785032F659F;
	Wed, 27 Aug 2025 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lafvAV2A"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3252D8398
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756319972; cv=fail; b=JNf5jNJDreM+8fBf+Y/SoMtTWikr1P2d0HF1ssPakxEdAlIuRcFpbnqxTG9T6LLP4qFS8R9xt4eiSsAqWBBtf6834XDRyK8my8mKljzHiC+4TmdODSuvolrfLYRkGP0uca2W/w6DxTCxyMMeIoqrVG2x5ZU1qqmW5El57LSd9yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756319972; c=relaxed/simple;
	bh=3ccj4dwahVHPbpWlDjkLP+gtEN2TuhJHi+6g89gmx/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0WEIYGU1YyamiGTHh8zwYDzlt4vSiwKQy16MuXAbWgfIDPvExc6OV7rGSHO9FspVINVy+ze+7offawFM9cdwEOu9WeIpzHDsP37ie3UeqPEF3FfdU/U0xIT/T+UagaOKgzq2OfJX9vr3UiJEOZtT1xaTnHJTVODVSLK9TS4ouQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lafvAV2A; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGCGFxR9YbQITlexalISnvsPcGgsq+3Nle16nNuE/AHr3MEqxslo9pJOKPrNBywKpFVc+pShz7uyTHrj4rUh1YlRcQPvEFdseLZnBY27YTcgEvSty/v0dNZtvmx5yE5ZVIkG3I2yaRTSzR1u5wN8ItYGyKBHyH9kf5yYakWc2XuEkOZ4+1Rt9hWLHJiB7vnUJRmtg54vzAm90Q8TGm2vT3onSd/iBqk30Z4s946iUY7/5QAKjzp3BBKsOzXLYioAOWB7PM3p/CBc63vBwNr9AIyhXLkyeF8IFcekJrYdns/j4O6iC+SMMF98QRo7UASrYV/4iwW3gvUWnmcQlk7RJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wy20lPKxuXYb7Sdb8APmDaYPksCmrBUB1xxv51+sUY=;
 b=LJUaSBUHib+NySAbzXE2U8iiilZfAK7KmI1POWHexVIyLUqZZFxut4zgl2djc/UnfuMcBs24cV4i9w9lsBo55vp3gjXRHvEfmNafdi6PvR3RS80bF19jwfqwSR/exW7e3447Fw+d3dbS8CsMIay2G0mSJhN1J9HjeDB9VIgszUhLTrNAkjKtE4i5SOkxkQ/QZtBF/aRyy0ZAb/Pg2Y8lEYySdx0d99qPY2u3Tx1S4bwrSP2znIRRNugQbexN6pyJJOLSll/asOUeV7qzETzXyQw0rqk97AqMV18SQ4CZ0SFXcCT9pWYGo/xr0s1Rbdrd7/9n+dIOJ6EQ9LO6wpruFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wy20lPKxuXYb7Sdb8APmDaYPksCmrBUB1xxv51+sUY=;
 b=lafvAV2AsJ7y3Zcp6h5686z3gU/SnMQLYb9kbEGOONtgzC/jyOaf3d8u42BKhS8exzfSqdViC/OmldemAZYZ5B3J9TYxGtPeMHmoSk6rKCbGg8zdIc2IGZPOQ+TPckx2Veu7C/BQOkTWdCJEmD43BK6gWwjeBuZJb+1WN8BAia8AiOre0T9oiusbQ9+OZ4/5nlabDaYVQdKHOL6CB57lFHcZUYHx3dzdMf4sX32ZQCYCzx6XMAggsXR6WPdcn/YZ4ytnfdGi7MEkGwOCS/y2osreeId2rb5qaBxPVi/koRvqEbo71ZB/cMucKD0PGscZmr8iAvrzRhbHWv9LLi8AsQ==
Received: from CH0PR13CA0049.namprd13.prod.outlook.com (2603:10b6:610:b2::24)
 by BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Wed, 27 Aug
 2025 18:39:24 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::2d) by CH0PR13CA0049.outlook.office365.com
 (2603:10b6:610:b2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11 via Frontend Transport; Wed,
 27 Aug 2025 18:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 27 Aug 2025 18:39:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 11:39:11 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 27 Aug 2025 11:39:10 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 27 Aug 2025 11:39:09 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next 08/11] virtio_net: Implement IPv4 ethtool flow rules
Date: Wed, 27 Aug 2025 13:38:49 -0500
Message-ID: <20250827183852.2471-9-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827183852.2471-1-danielj@nvidia.com>
References: <20250827183852.2471-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|BY5PR12MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: bd58dbba-cc19-4f49-2014-08dde5990bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v1e9chmJE+YEdLANbxAQr3TgoaW5ZG7b61Z/qx15j9tckY8neXAboGyit/6s?=
 =?us-ascii?Q?WKxaccD/P7haTLFgEUoDoBPXKuzSjIJZFrn15g/gkvl+X8kRhh/HJx/nc8IW?=
 =?us-ascii?Q?iiib0XIu4Gp0+UxdlC6GV/SMj8AjrCGGZwTDdLgJ0SMAHxHy8wUA31IJwGSA?=
 =?us-ascii?Q?aTeah4I4+qcoyryfh3ojp7QxApB7WZuBMkLSr6RDWcJvdAwzO9wUN+s2i23H?=
 =?us-ascii?Q?sANzwDFLgs3MFXm7+l9pIntkAm+0R8POZQ/1/cdSgFHhSPzmfZgqfz65oGHi?=
 =?us-ascii?Q?t4tz431QH+OQmGRZHejue5m3/gTlILNpsQShYDtt03uA/e7tVSm1thtLIzeD?=
 =?us-ascii?Q?CzpCpOXBGgsGw+jo5FMzuvXUQReptAOWIAVGJsoLnCTLkt+9rQIaejU5x7X/?=
 =?us-ascii?Q?Ta2sKmWgw1C2KN1er7vL5v0Kd0rpxohPyGoUlyOEvh/Q8ULzJHvD9ILFEtJo?=
 =?us-ascii?Q?isO19kry/xCHRL3MmqhcNHxufWsuNgIeloyKZD6jxh8JDNkYrQjBvCIW2rM3?=
 =?us-ascii?Q?hMVvYGa3Xe8jf1LOxFk7G9BkZBhgUM/7gzgr9Zkn3ub1TGS3kUvZrZbxofKj?=
 =?us-ascii?Q?jXJWC2oxZrlvHIo20hH+O/ouePjjFpphYy/kQQGBCSI/W8FRBLwPtXiEoc5U?=
 =?us-ascii?Q?Xj+XIrDm+SZ5mpA4e0sp7koZB9e1ZMkUZycayh0/oRLicqmTU9Ae1lKyYEBI?=
 =?us-ascii?Q?sFJH8VcX73pawbPIwcqTKORq7R4LtiQrNG3xqgSVRUVSIHzcY4M+dtzAiJjj?=
 =?us-ascii?Q?nj32Hgj12MRThW0ej6yl9wfVqlVaQv4+KnbMpGaEo/LI2wYrgtSv1I9rKuah?=
 =?us-ascii?Q?GVy1uIBJMjvK7KHxsbByc9cD9KOvyHSzWjOGJL2NrimEF+WGG+ccOmxcF3e6?=
 =?us-ascii?Q?CsSx3b+NmMNgHykweEPZPo8KdOX2vVm4c1wjpKmb/ZPw4TaT4U1escZvS9Ij?=
 =?us-ascii?Q?/0zMgGyKGaW+mMysdKKavmioRXQnpldEBQ8TptQRjK2kiLobbhzGM8TOAAix?=
 =?us-ascii?Q?7tfOUouMvyuTjz4OaQGgKpRczty7EQEwcu4UpBu/fs5FBQY8jhQsz6QRlDMs?=
 =?us-ascii?Q?xsIRo3TD4qL/wX71T5Fn6BZoyz6bfWYBcKZCZMgq+zVCm+90M8t5CF9NIpPN?=
 =?us-ascii?Q?1QuTD0k3qnO0I9mZyyn0/o4ix/mj64HQZm7bzuXrQiB2r18KqLYRNe4PG8sa?=
 =?us-ascii?Q?+8avQrpTOMtJT9K8Q7oyQK6sUv79J4habAeAeuxE6skrJQ1tje08E4Sfw7OA?=
 =?us-ascii?Q?w6zCHPHDSU1MgjBVLsetZC5rqB/l5gbo0zLADMJjFBZSxnrNqC5NkYRdrKEr?=
 =?us-ascii?Q?hjo8YM2hljZ03OzhCw6EoRm9BKeRijupNjc6td4TIot7wKR5pxgO32ZAIrDF?=
 =?us-ascii?Q?eVElwDm4wJrE97GAUGCYtG9UEy/eRNk7NzpwF4aTS7wLs0KVb6llJtui5K6Q?=
 =?us-ascii?Q?IUvZOpCNZ8X8vUKLazQQmbJz7KX9tkx5sX9akU3U9DoRKC36PLTzRWiMAGac?=
 =?us-ascii?Q?75gaiFrrkstgEHErTlu3KH4XqrBfnxSi93Qi?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 18:39:24.6829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd58dbba-cc19-4f49-2014-08dde5990bde
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129

Add support for IP_USER type rules from ethtool.

Example:
$ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action -1
Added rule with ID 1

The example rule will drop packets with the source IP specified.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net/virtio_net_ff.c | 127 +++++++++++++++++++++++--
 1 file changed, 119 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
index ebdac1fb49dd..60ce54611509 100644
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
 	 * header for each type of header in the match critea, and each header
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
+		eth_k->h_proto = ETH_P_IP;
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
@@ -347,8 +449,17 @@ static int build_and_insert(struct virtnet_ff *ff,
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


