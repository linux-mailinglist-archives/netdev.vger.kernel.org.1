Return-Path: <netdev+bounces-235259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D20C2E565
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 23:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E1D4340F68
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 22:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374A4313E03;
	Mon,  3 Nov 2025 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QVwM3rWF"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D2C2FD671
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 22:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210585; cv=fail; b=U/UXrFPdymeD1enpzHbdJwcMaYEJlTGwvHG9G46uwQEvnKZeP/XKWUyUa3NC5vsSnCCoiG7ffIsIJjzihkJYXyxa67I9+e/UEaahcdkYk810JE8vVboySshHzA9Zib6fa4Q6iZ//BH9iNjyYhAfd5D53Jvm8RkVBphM3+xB2hgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210585; c=relaxed/simple;
	bh=xWYgfyQ1+F6DFEu22zT2rnoicNHDMpGz1eX9dbLpD0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6GFoZIQCfQIWeld6G9T88tpfimMWWMzS4TUAaG6lhF1rIwg6GXalV5cJTFMHj3g2G9jUV7+Fs3Odnur54IMRAzSPa9MdGatcB/V7quOTsPoEuo7CEB+wEbZVSd/+vqYpyP94ilZI6yeVs6wSr000EjMU3KlEY287UA/Dy9Lv6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QVwM3rWF; arc=fail smtp.client-ip=40.107.209.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTZP22//DZtk+y/uOI6CtLO2siriGxuSTZj9jiWuNDvNEjgNaNvcp3mC+729jes5uafhxtBw/pIiEThXts+ogFTQeWY5/68svEYUV8XrZ97DkKMR3zYpjIiVDlCBDScFtjABEHOflGs+XVGqRkBaXH0v8MjARdq2RwPSl5bvJxB2dZadmWt2l6MVZV7HeE0GSi6blJxOlUcf9DgHRcNBYxnZI1J9jLHD8oJXW4TTYdTbOum1MNGgo/dbVupQGpk+FBdf1FmpLu7ALK/NDC4k1aThfxWmHhbEv4dChhMsHNxChgDhbOw18u+xUL2bXKSCBl3DSIrGs+4ZT4/AgQIQfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHskPPi5qJEYCC6o/ooZxU6igI0NgRqFrEtbw9ZN5I4=;
 b=fNN3GC7ONiZ9I4hxdz/DEUKtpNoMJZNzSIm3gHLLDfQlcW1ch20Zap1X29o1tYl2v0QyN8CHCy3aKmLIEG4ew70VG/SnW72QCGCfBu9tLLqnTnntTeeM9AKkObdCnT1+2KKeFSbhhIanK44djNW5uzOdqmAttm+iJuOeKGurMY8oM+1XmR3/mxUk/5mFRZBrfVQLvIy9dcimeNXI7PYtE9Yv85ckVVrbwm3XiztUakdpYJTgEQCdjKqsbzjCmY4U4k87a8oiwSeflx7NrUpvXE+Jx5jOkx3/CXG1EvDTy5MdwlnTLmawlCUJ8VOYpPZpN9R+VoiSqEuUELrmZ4pL/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHskPPi5qJEYCC6o/ooZxU6igI0NgRqFrEtbw9ZN5I4=;
 b=QVwM3rWFkfBz5MQ4kPqFD0lGJBT8gbS6U61ku63I6SXv5EyIxvbRZo1FiH4RprwDBKP7P0DE3B84YCoKiQ4FEThvO5VSxsSP1pQ/I7riHrLN2Rby6Mc6GTWXrAZRsq+IoyQbr1sfOIDGJeW2x7KaOjNo1EWzicmAO4zrnrvsOwvYK1Jm8D2nctvBMeI7+pV39xILX2ibcaU1M4y1cmhSRnrLViRCukBqI1tEKUK/rTU4mG3ycFoABeg4+GaJFCqEn3Fwz2aimjGYIHuc3INu42b7cd2BkLJuNkPbpQiUAv2oSTSmuwRbJwPYQcrElt+hXlzPQ6Fzi5loheaWjxFgAw==
Received: from SA9PR03CA0019.namprd03.prod.outlook.com (2603:10b6:806:20::24)
 by SA1PR12MB9472.namprd12.prod.outlook.com (2603:10b6:806:45b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 22:56:16 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::c9) by SA9PR03CA0019.outlook.office365.com
 (2603:10b6:806:20::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 22:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 22:56:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:58 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:57 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 3 Nov
 2025 14:55:55 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v7 11/12] virtio_net: Add support for TCP and UDP ethtool rules
Date: Mon, 3 Nov 2025 16:55:13 -0600
Message-ID: <20251103225514.2185-12-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103225514.2185-1-danielj@nvidia.com>
References: <20251103225514.2185-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SA1PR12MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: 76057e9c-8a9c-409f-5288-08de1b2c31d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G4PrhqPEaHozC+TWpRuw1yrtjzYQJYclCi2dcEbsKtyWfsnRuY4CpyMc92f/?=
 =?us-ascii?Q?+tqcuaxInoiw6ofvVe5RtAHzrN2TOfuuZ0TDbWwLM2rV/BfjkGQIls+PplFf?=
 =?us-ascii?Q?XOAb41Twip2COnVxrAImfzt0fHe3wS7mpNnNmjNxSrzqroo/+BOzrF8VA1xm?=
 =?us-ascii?Q?c3GMhWp1qWpoeQivsh9oGedBqWzoepudYrF2VICzjV+HEhCQ6VW9Ypnqxwe0?=
 =?us-ascii?Q?KrPfiQAsyUOpOK3v4+i8wsw0DJczNsnMS5kg6CmhRV03dw34fSsIkoOwqxlp?=
 =?us-ascii?Q?/Scqw12Gc5f0y8jzLhDl6Trx/qW8H5uDX9T2oGmgvOhsLEan4/m4FKFG5+x5?=
 =?us-ascii?Q?hFOeZYt+omhGBlDRltl9X8irggQ8Gq0lUqJ7qB6gXS6W7kcAJ9tTazC7eGvh?=
 =?us-ascii?Q?Cij/DpGqWudgrYsmtlWFDxkuGfjMft5yLvQY1G30i04kX+FROTQh6YNfxF8h?=
 =?us-ascii?Q?8HrJBKpDGLo07oTvtplXlstFy35rb4YB+1bNch/kmkYOKu1bL3CFKnleBiw3?=
 =?us-ascii?Q?P4o51ISBB0O/+ACMAjXS5ByN0SLMpWY5PyhJU9YuDP+zo3G20CfkTE0g50qH?=
 =?us-ascii?Q?dWMqeYvDz9j+KCxozAPTUWbJH8OBzg3BSG+cOAXU5DC97MXd/CSMjBoT3dPf?=
 =?us-ascii?Q?XUgpW26MbmrwU5DVJKXn/j7j5D+gHKtCU/PhVl1Cg9zmOsp7LkV2+5zmaU+w?=
 =?us-ascii?Q?U/AX2Cxp9ehXh41BsH9NUBIExd5K9FYhs54P+/RE74FUFXwa4jl6ZupnssHj?=
 =?us-ascii?Q?rxYnYz8CxjDdcDchaWpHGBErK4a9f9HUgsQfid+kAVQ3n12+DN0vfdG4pU/Q?=
 =?us-ascii?Q?tUwmQgpCHCi2A6fKjmA2Z51vjtquvkTnDpHOlVQMqkZFlszwq7SXpp82k0F4?=
 =?us-ascii?Q?S4R4bKBV21UymZVxc2J9UdI1yHrzhvnTMAdlUHmyYaJ57kHR+5ugJ+6v3PgP?=
 =?us-ascii?Q?oC8QQPh4VMv4zI6B94SDeLmzMChafrqBrXhiuYfT7nx8qLdUJqt6NNYE5n1b?=
 =?us-ascii?Q?yRG0uXEovSS8RRiUcEYFCRCIE+LTSVVd4t9W306btxzaagdSoV2vRV9q3UOE?=
 =?us-ascii?Q?5SMmsyujlxlfTpNmY97NgqTRwmAvpTLhNDjC5tASXEaA6AY+OvDruy4PKO1F?=
 =?us-ascii?Q?c4McXFBlceiRjSQMqAPBNC6OhXWQPd+cBbm/WJVdw8R9a3yHNkwALJivF7bu?=
 =?us-ascii?Q?WTEyslq4ldpgdqkvvz7WcRjJwK6kSTLOf6uxIljnatLPFMHdt8RGMTL1DNA4?=
 =?us-ascii?Q?xD3h6l0BETguPhnEh8rJz2/Z2NyUaICKlj/P3ZjOhYHx3n8BXaqZL/ZkaZ7J?=
 =?us-ascii?Q?Mt4CD8LC1xcuAqwWzMedZxjNcQ51PiH/g7kfryP5R1eJpTRtkSTH22kuowsn?=
 =?us-ascii?Q?saXQSY50yNOvAs9txUPiKcRBf1zfvZTD3rBwNr2Og/kVVA0Mav3Bbzo1Ap7S?=
 =?us-ascii?Q?n6wHMLJD2XfmTLNb3WRGLSbNCwawatXQmcZ5bOLRzngW8HKayBkgp5DNBA62?=
 =?us-ascii?Q?VmlZjuR0Qjcr9ZsKK/N1L6KVMmjfUyQETMEcbDKjRl6cmieWnQlShXe8FBcM?=
 =?us-ascii?Q?lfVcAu4hC0yGxV6i974=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 22:56:16.0974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76057e9c-8a9c-409f-5288-08de1b2c31d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9472

Implement TCP and UDP V4/V6 ethtool flow types.

Examples:
$ ethtool -U ens9 flow-type udp4 dst-ip 192.168.5.2 dst-port\
4321 action 20
Added rule with ID 4

This example directs IPv4 UDP traffic with the specified address and
port to queue 20.

$ ethtool -U ens9 flow-type tcp6 src-ip 2001:db8::1 src-port 1234 dst-ip\
2001:db8::2 dst-port 4321 action 12
Added rule with ID 5

This example directs IPv6 TCP traffic with the specified address and
port to queue 12.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: (*num_hdrs)++ to ++(*num_hdrs)
---
 drivers/net/virtio_net.c | 207 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 198 insertions(+), 9 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b1f4a5808b5b..2e39d2c0004f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6945,6 +6945,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_tcp_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct tcphdr *cap, *mask;
+
+	cap = (struct tcphdr *)&sel_cap->mask;
+	mask = (struct tcphdr *)&sel->mask;
+
+	if (mask->source &&
+	    !check_mask_vs_cap(&mask->source, &cap->source,
+	    sizeof(cap->source), partial_mask))
+		return false;
+
+	if (mask->dest &&
+	    !check_mask_vs_cap(&mask->dest, &cap->dest,
+	    sizeof(cap->dest), partial_mask))
+		return false;
+
+	return true;
+}
+
+static bool validate_udp_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct udphdr *cap, *mask;
+
+	cap = (struct udphdr *)&sel_cap->mask;
+	mask = (struct udphdr *)&sel->mask;
+
+	if (mask->source &&
+	    !check_mask_vs_cap(&mask->source, &cap->source,
+	    sizeof(cap->source), partial_mask))
+		return false;
+
+	if (mask->dest &&
+	    !check_mask_vs_cap(&mask->dest, &cap->dest,
+	    sizeof(cap->dest), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -6962,11 +7008,45 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
 		return validate_ip6_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_TCP:
+		return validate_tcp_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_UDP:
+		return validate_udp_mask(ff, sel, sel_cap);
 	}
 
 	return false;
 }
 
+static void set_tcp(struct tcphdr *mask, struct tcphdr *key,
+		    __be16 psrc_m, __be16 psrc_k,
+		    __be16 pdst_m, __be16 pdst_k)
+{
+	if (psrc_m) {
+		mask->source = psrc_m;
+		key->source = psrc_k;
+	}
+	if (pdst_m) {
+		mask->dest = pdst_m;
+		key->dest = pdst_k;
+	}
+}
+
+static void set_udp(struct udphdr *mask, struct udphdr *key,
+		    __be16 psrc_m, __be16 psrc_k,
+		    __be16 pdst_m, __be16 pdst_k)
+{
+	if (psrc_m) {
+		mask->source = psrc_m;
+		key->source = psrc_k;
+	}
+	if (pdst_m) {
+		mask->dest = pdst_m;
+		key->dest = pdst_k;
+	}
+}
+
 static void parse_ip4(struct iphdr *mask, struct iphdr *key,
 		      const struct ethtool_rx_flow_spec *fs)
 {
@@ -7008,12 +7088,26 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
 
 static bool has_ipv4(u32 flow_type)
 {
-	return flow_type == IP_USER_FLOW;
+	return flow_type == TCP_V4_FLOW ||
+	       flow_type == UDP_V4_FLOW ||
+	       flow_type == IP_USER_FLOW;
 }
 
 static bool has_ipv6(u32 flow_type)
 {
-	return flow_type == IPV6_USER_FLOW;
+	return flow_type == TCP_V6_FLOW ||
+	       flow_type == UDP_V6_FLOW ||
+	       flow_type == IPV6_USER_FLOW;
+}
+
+static bool has_tcp(u32 flow_type)
+{
+	return flow_type == TCP_V4_FLOW || flow_type == TCP_V6_FLOW;
+}
+
+static bool has_udp(u32 flow_type)
+{
+	return flow_type == UDP_V4_FLOW || flow_type == UDP_V6_FLOW;
 }
 
 static int setup_classifier(struct virtnet_ff *ff,
@@ -7152,6 +7246,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
 	case IPV6_USER_FLOW:
+	case TCP_V4_FLOW:
+	case TCP_V6_FLOW:
+	case UDP_V4_FLOW:
+	case UDP_V6_FLOW:
 		return true;
 	}
 
@@ -7196,6 +7294,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 		size += sizeof(struct iphdr);
 	else if (has_ipv6(fs->flow_type))
 		size += sizeof(struct ipv6hdr);
+
+	if (has_tcp(fs->flow_type) || has_udp(fs->flow_type)) {
+		++(*num_hdrs);
+		size += has_tcp(fs->flow_type) ? sizeof(struct tcphdr) :
+						 sizeof(struct udphdr);
+	}
 done:
 	*key_size = size;
 	/*
@@ -7230,7 +7334,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
 static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 			     u8 *key,
-			     const struct ethtool_rx_flow_spec *fs)
+			     const struct ethtool_rx_flow_spec *fs,
+			     int num_hdrs)
 {
 	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
 	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
@@ -7241,21 +7346,93 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV6;
 		selector->length = sizeof(struct ipv6hdr);
 
-		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
-		    fs->h_u.usr_ip6_spec.tclass)
+		if (num_hdrs == 2 && (fs->h_u.usr_ip6_spec.l4_4_bytes ||
+				      fs->h_u.usr_ip6_spec.tclass))
 			return -EOPNOTSUPP;
 
 		parse_ip6(v6_m, v6_k, fs);
+
+		if (num_hdrs > 2) {
+			v6_m->nexthdr = 0xff;
+			if (has_tcp(fs->flow_type))
+				v6_k->nexthdr = IPPROTO_TCP;
+			else
+				v6_k->nexthdr = IPPROTO_UDP;
+		}
 	} else {
 		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
 		selector->length = sizeof(struct iphdr);
 
-		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
-		    fs->h_u.usr_ip4_spec.tos ||
-		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4)
+		if (num_hdrs == 2 &&
+		    (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+		     fs->h_u.usr_ip4_spec.tos ||
+		     fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4))
 			return -EOPNOTSUPP;
 
 		parse_ip4(v4_m, v4_k, fs);
+
+		if (num_hdrs > 2) {
+			v4_m->protocol = 0xff;
+			if (has_tcp(fs->flow_type))
+				v4_k->protocol = IPPROTO_TCP;
+			else
+				v4_k->protocol = IPPROTO_UDP;
+		}
+	}
+
+	return 0;
+}
+
+static int setup_transport_key_mask(struct virtio_net_ff_selector *selector,
+				    u8 *key,
+				    struct ethtool_rx_flow_spec *fs)
+{
+	struct tcphdr *tcp_m = (struct tcphdr *)&selector->mask;
+	struct udphdr *udp_m = (struct udphdr *)&selector->mask;
+	const struct ethtool_tcpip6_spec *v6_l4_mask;
+	const struct ethtool_tcpip4_spec *v4_l4_mask;
+	const struct ethtool_tcpip6_spec *v6_l4_key;
+	const struct ethtool_tcpip4_spec *v4_l4_key;
+	struct tcphdr *tcp_k = (struct tcphdr *)key;
+	struct udphdr *udp_k = (struct udphdr *)key;
+
+	if (has_tcp(fs->flow_type)) {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_TCP;
+		selector->length = sizeof(struct tcphdr);
+
+		if (has_ipv6(fs->flow_type)) {
+			v6_l4_mask = &fs->m_u.tcp_ip6_spec;
+			v6_l4_key = &fs->h_u.tcp_ip6_spec;
+
+			set_tcp(tcp_m, tcp_k, v6_l4_mask->psrc, v6_l4_key->psrc,
+				v6_l4_mask->pdst, v6_l4_key->pdst);
+		} else {
+			v4_l4_mask = &fs->m_u.tcp_ip4_spec;
+			v4_l4_key = &fs->h_u.tcp_ip4_spec;
+
+			set_tcp(tcp_m, tcp_k, v4_l4_mask->psrc, v4_l4_key->psrc,
+				v4_l4_mask->pdst, v4_l4_key->pdst);
+		}
+
+	} else if (has_udp(fs->flow_type)) {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_UDP;
+		selector->length = sizeof(struct udphdr);
+
+		if (has_ipv6(fs->flow_type)) {
+			v6_l4_mask = &fs->m_u.udp_ip6_spec;
+			v6_l4_key = &fs->h_u.udp_ip6_spec;
+
+			set_udp(udp_m, udp_k, v6_l4_mask->psrc, v6_l4_key->psrc,
+				v6_l4_mask->pdst, v6_l4_key->pdst);
+		} else {
+			v4_l4_mask = &fs->m_u.udp_ip4_spec;
+			v4_l4_key = &fs->h_u.udp_ip4_spec;
+
+			set_udp(udp_m, udp_k, v4_l4_mask->psrc, v4_l4_key->psrc,
+				v4_l4_mask->pdst, v4_l4_key->pdst);
+		}
+	} else {
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -7295,6 +7472,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	struct virtio_net_ff_selector *selector;
 	struct virtnet_classifier *c;
 	size_t classifier_size;
+	size_t key_offset;
 	size_t key_size;
 	int num_hdrs;
 	u8 *key;
@@ -7328,9 +7506,20 @@ static int build_and_insert(struct virtnet_ff *ff,
 	if (num_hdrs == 1)
 		goto validate;
 
+	key_offset = selector->length;
+	selector = next_selector(selector);
+
+	err = setup_ip_key_mask(selector, key + key_offset, fs, num_hdrs);
+	if (err)
+		goto err_classifier;
+
+	if (num_hdrs == 2)
+		goto validate;
+
+	key_offset += selector->length;
 	selector = next_selector(selector);
 
-	err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
+	err = setup_transport_key_mask(selector, key + key_offset, fs);
 	if (err)
 		goto err_classifier;
 
-- 
2.50.1


