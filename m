Return-Path: <netdev+bounces-217414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C93B389C2
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 20:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA4A5E059E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F7D3002BB;
	Wed, 27 Aug 2025 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PGAFqRWk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2342F60B4
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756319974; cv=fail; b=HpyYFp5/BzIUqPHqkThV6tEgaLYU9tCupMz9t02RNIBrGlM1mDwfLB6Yi0iuzsMrP4JxomdU9KxzCG8NlioGMcdGf26ndfi8f0VaNh4FzUGUgcAGkkktYO+UroIMDtzchYZZHMK1hZ8RtfOWZh0h4Kg4ETN9BIBcqXbpW5YA7qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756319974; c=relaxed/simple;
	bh=rDpNUr806PAGkUf9bWFLQ1zCa140M48kWZHuHvlIFwE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZtLWLBfdSxlcrKKBL/vLvLuCo4JtPfmGdxGS1Z+GS0M5EnPynDa+37g9qvqMBD/t89DjLEUSgQZKJg5/0+dwgpCNhGI/tY3XT1DUCPWuVX7LNn3SWFK2VnJBab1i/mmN/UkYVyblkkzWv3f++iUIOsLvr2ehnGZBPycN6n+Lyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PGAFqRWk; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMOZ0dbuTs8aJfTD6e8CkT767ZuQ4suq85RAwKkU+Nl76aVA38rpDHxI49mTC32M037pAeaZMaYnMj0oNYIJGU7zE4Jz+2a71rzqoX9HsIbCWBUunzkh19b6YHqQEVeW9mU9EDM1VIyPn4BCCyjrhMtVlAs3YmnPODp8ZLNSshioXAg2wNBVKzQMvhpO5x/Q59wiHvyLixJvOWF21NEfLkI6pBe4Xq08AHi6KD0sUbdU00mPYlSrf70D1RVwevGnedukJ0EulxNbCRAZPUIO7Ae7Lf00i+OPUozpZD5l4UrkDuoCkf5jRo+PmDmTo1Vdj0TKoVlvglsOf7YNx6Hc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1k9dfpD/VHkU2P3YIPR88yo6BtlveIW7tURtlUTrYU=;
 b=g5BCeEJGsgwVy00aXJIVYFqaor3OjDZDC9wZio9dtVVfOCpF6Z1Y85HcpoxFbL3s/GxSJUAjLDTjj9/vgbY8zeU1AYG5aJbJ7KY4f1PqSuJ54cyQPq/rgSJldmC4my2ystQnjWaCzvFRbmAVlYmWaYVkhUWkin8WXtdObFDkmCGI7OvLMpYoMpEeT+gScH5aBkc01MpJ2T7/WpyjyCC7S6RMlRUvb+Yjj08x7+e5DauAZsZr4UQD5ccPkUufnwOTTglvAR/BHNAgeJISsEP+ZlJ+tnvO6CSI0LYYzifzAaNmCE7nNiGndndry9KP2LAhYhzfhvJ9r5YVWsOO8QDHXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1k9dfpD/VHkU2P3YIPR88yo6BtlveIW7tURtlUTrYU=;
 b=PGAFqRWkp+M3dtUvI58BvRWvb5w4xxgLMGdMQKq4VPnVEjCZE8p4ON/dMhM97T+T7UYE0Xc3ZY1ZeQ+WrFn4dVQOiwR69Qrzlxa5/wI66WgeFcZr85Tyj2zYiCGWEW/pNTTLE4TynJb3aqEu5ETQ1KkECzxXzTrCG3+SU6BcQBe9U1Y+DgR2lnK5SzQ35ZtU0nEJSfCS7bj1IH04BtYdzs8oqMa3eu8WxjLhHWgMKKFZTSkQaQJZVDNEIJMo9SCW2NJLnib3wNfAKxCO7AfKqX7tdX6sXCqQWuS4zNpeE0aE5XlPMFQmmo+Uhm2mHDoYhn5AhcVm/AhYJ4vANU2lZg==
Received: from BL6PEPF00013E03.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:1b) by PH7PR12MB8154.namprd12.prod.outlook.com
 (2603:10b6:510:2b9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 18:39:30 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2a01:111:f403:c803::3) by BL6PEPF00013E03.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Wed,
 27 Aug 2025 18:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 18:39:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 11:39:12 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 27 Aug 2025 11:39:11 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 27 Aug 2025 11:39:11 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next 09/11] virtio_net: Add support for IPv6 ethtool steering
Date: Wed, 27 Aug 2025 13:38:50 -0500
Message-ID: <20250827183852.2471-10-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|PH7PR12MB8154:EE_
X-MS-Office365-Filtering-Correlation-Id: cef5af25-2140-49c0-af72-08dde5990f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wGHfsCnhQ9cHVm8O0+d0GKjDMfYd2BI1+7LpvHi3/X848WXxfzzh9wXacc1o?=
 =?us-ascii?Q?//u1AjThsZL/ZBOQpzuLcbNKjs9AzTJcGWJ57zSgIbo30GI/cFIQZaHzfsBN?=
 =?us-ascii?Q?2lvRqjx5D0OqaSRvHFzOmRH6PvfaRKmFC21Ew4xHgKQiV7SN9eCGMnLVhH4K?=
 =?us-ascii?Q?29aKSm+IWL49UURwE6fdsUZuN6a2opCfbMnOezexwc4JZiphJ1YUzFMoFB0B?=
 =?us-ascii?Q?lAwZEl3vBvNX5g6Gme0FMT2NAre97CiIS0ve1zj8pA013hEp1G6tad7MQaYH?=
 =?us-ascii?Q?mkMKGeoTBM36dJDchgeHBURGTLYvpEiucTHj0u4Avb4kvR/ExJhXq9FtnWum?=
 =?us-ascii?Q?a2XDpPN+FqRG3FgIJb4cnX6PoNn6aKye/ZP9hiPUk5Z5Ru67rQ8juRYdgEYp?=
 =?us-ascii?Q?6V20It47zRbroXGWaXDJLDNwznqMRUMPuQGAJrVoH90Dj1cwXxwdfQjDlr/L?=
 =?us-ascii?Q?vJ7uthlqrtPZfAzLyUKK/rsKF6cIFwhr8TZtNWj3WhE51N0ctuqnhf0dFTaJ?=
 =?us-ascii?Q?d0hGQRrGCEVcQhe3uWPGoTWNuXVjKOY0lYDN0fqNnvysQ8cgkMDNcHVP2lUU?=
 =?us-ascii?Q?mrc/9HzhzCKLMw5eCmDL2YlbvPBEMxlqBmTSlN1zwQf0rXZ0TzdrkFLygNOo?=
 =?us-ascii?Q?Hs7m8AXBv0fSozNV1SDhgmMsVjl2MlcVLxMhURQBKUJpkGvjKlr2cvMMVElx?=
 =?us-ascii?Q?eHX62klLkPkOwKoUmC8v/GY0CR9VLAn0mTWCWuw+zP7a+T/BI/pOoY0oiu8R?=
 =?us-ascii?Q?gIIp+hn3J7idTLMqx53hPT4/+kR/S1QJcI9Dz6OYppMhO2WZlhlo9nVYGiMH?=
 =?us-ascii?Q?MXaumHD3lBl76UDhgVXA1ci+eA62S6T2APowWPg5FXnm4z2ODCPtsSHPdukv?=
 =?us-ascii?Q?iM9Z/Ws+Y7QeqGQsN0Rh8GkGtWXmILH2Y8SJI8YOurnykj1nTN5UIqTQOB0g?=
 =?us-ascii?Q?6JLeafiVS+mwdtgWSaCkjbUDvW4wMQ2pRiNccdbaRuQrr5THfAiN8csk9WqE?=
 =?us-ascii?Q?uNiGpu7XrgUaWnNW00ED0p/PN9udfpxmqVEzcZ/HaaUxZMnhrzIj2YHJ9tRr?=
 =?us-ascii?Q?0uLoya4YfSfmJjYaW19svgZsjdcrxZgY6Pq7uSXgA5MCurtuEyWxRLTkBero?=
 =?us-ascii?Q?YbQxcG+9H1xNCiaOkR7GMMvqXQyuoPtam4ZFTcEg23+Pg82owZITWHP4v8/J?=
 =?us-ascii?Q?HBlg2mCrJ5Bof5cq4/9AYnxGDFUdr6SSctvXzdKc7b9uffCzacQtkW85cKGC?=
 =?us-ascii?Q?WTY+YIxG+932xKVCJsFUq3KvePgKsbmKFShLwj2MSP9q5PkLlhJpcTiq56yz?=
 =?us-ascii?Q?GSarFfq1+5Rcd4JLU1bPfzccRPr4sDSkHzRB3Z5IqnVNS08nMyc3oXBg9Tve?=
 =?us-ascii?Q?AvZw7pg6MhXsKXlhAkWhxNkOl3Ci0QDfAgtVRaiiXM9Kc98/3KTYWCdUAqeq?=
 =?us-ascii?Q?wQp3+WOyKrNV2oXgaIWITKxDjuWxBCoSYO/HRLXsea5SqKX4//IWb1PbVdqb?=
 =?us-ascii?Q?LXdcm/h/a1+uYp0V5XAoqxAjxG6tcXUQ9YDt?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 18:39:29.9514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cef5af25-2140-49c0-af72-08dde5990f05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8154

Implement support for IPV6_USER_FLOW type rules.

Example:
$ ethtool -U ens9 flow-type ip6 src-ip fe80::2 dst-ip fe80::4 action 3
Added rule with ID 0

The example rule will forward packets with the specified soure and
destination IP addresses to RX ring 3.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net/virtio_net_ff.c | 89 +++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 8 deletions(-)

diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
index 60ce54611509..9b237a80df39 100644
--- a/drivers/net/virtio_net/virtio_net_ff.c
+++ b/drivers/net/virtio_net/virtio_net_ff.c
@@ -118,6 +118,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
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
@@ -132,6 +160,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -154,11 +185,38 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
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
@@ -291,6 +349,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -332,7 +391,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 	(*num_hdrs)++;
 	if (has_ipv4(fs->flow_type))
 		size += sizeof(struct iphdr);
-
+	else if (has_ipv6(fs->flow_type))
+		size += sizeof(struct ipv6hdr);
 done:
 	*key_size = size;
 	/*
@@ -369,18 +429,31 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
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


