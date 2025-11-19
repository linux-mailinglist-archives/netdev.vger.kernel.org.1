Return-Path: <netdev+bounces-240128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0941C70C5C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66FD44E1B3C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E050B371DCD;
	Wed, 19 Nov 2025 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BspKDmMK"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012006.outbound.protection.outlook.com [40.107.209.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3181936B073
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579788; cv=fail; b=u5OSOVQZSrTg7p1PYjC41LLm6RHgbACDASlg1xaFlkoRpp/L7toW9OR/ll9hjQWWfdpAi/PdRW83w3jqfUYi8W0hAuXEyVuerQogt0uXZ4kkLE+iD71y5fbs2+TR5YUbagY5frmNC90MIqFHMMpVYg6xNAVG6n3qIdAQWp2zWrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579788; c=relaxed/simple;
	bh=2CQsq54tImx875ziK9JEKfa1eAXGpkJ/V8kB3WrqocE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nD6/lVR1BU2f5ZTMvv4H54IsAKAvV8XNqRbdIPBiF8cbhU56+tX0bKQXyLPd/+ChbGzhuqiR7SDDhBa2xu5xPROyJ1Kv0mE9MlgLJxHvBXXbv1s5BZ+SJeusH46lmAa7IXlQkhzz6enPRPE5x2mO4M59+8ZME0pBGmOSicQEO/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BspKDmMK; arc=fail smtp.client-ip=40.107.209.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbmizNbTzV926AQVolxvFeyTZvNKm96Tr0P9dZOJK24mJ4+WdSUgNct/hQ1PGhcwcoAvU/l7l1ABSgctq9gMOjluSioVJA9bUYzzEE84/etHyjH11e4NR/VRt7AJV57Ss3TgIDwXoZC8gGEpY+9k3MMq7bFVaQxUtbjD5ZAtpAQuuX2zG6OVjfMQX2eO1bOeTQgc+0yCaaCm48ZO405OAXIGCrb1gSXbVrGKjZt/RCQV1nKXEApYfY45/md2dw4QvqiL6ZpG0aBjGQwQ/bBOBLOrMVhP5nsmYlKnU6Ffb9FE0AFxTFigp89P/qG2cm4w8M2YFnfvooRdsegMpYbhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16gz2F9AOHobsVr1BpgqSCrBqCwPt1WAd+9WJcuarFQ=;
 b=ZkDpK7Y9amFNqraiIhzoQjsleL5+VOqAtj7zo8jMkHFjXOsW/TjeJ/wh0+O7MXIkEMOJCRJLes6ky7l3JoL/uWtATYzXOMJnIDCyjqbB6ZmgYGRMBJDESJbz4G/EoFkaA9PIqqkbR1OZAnU752xzx0UOmEnCzrKnNm7ksUlJITZiHuPmDZnQZFCI7ktLLHYP9i+ZRm5D7OLUizka8zqZHw1g61OgsTrYRdaSI6GN43yBhPKy1LDWEEgsEiSBJ2754IPuWkiQfj+hoQQZIt6a1eTPEMMkEEmD9S/VtBZw6m5lU2ddx4gX7lVDyjFZbyhl6Qwhea7lhcrKt9sG+RevHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16gz2F9AOHobsVr1BpgqSCrBqCwPt1WAd+9WJcuarFQ=;
 b=BspKDmMKm2cKT3axL3DzAkiXD2T9ci0vjN9ncDx1Robw6sVKFFrx9AbzaWSeYOafTyJhDRgRqjFEnlte0rU4lg7XsX6813vhMANfrS5tM/0sptnCAIyC6Ze8a8h+PhGfXAZbvjHtZq5ETnrIe9LXEHsRLbObTRX/y+ObpT921Wat+xt4+PJWP2p9VSoOM7Re58jmGVltsArhwDUUZwjXsuL/k6DZm53W1cZgj0HON5mahjBdcwFrz2rAP/Zzb8yW4y/LVn7lTlM3rHBO0Jq4Z0eNe7aIiM97aBO8CMpRShfx//2z4D2ETn/mJtz1k0OPivc28Dr8CJUE7ZVxUge/mQ==
Received: from PH7PR10CA0006.namprd10.prod.outlook.com (2603:10b6:510:23d::25)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Wed, 19 Nov 2025 19:16:13 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::c3) by PH7PR10CA0006.outlook.office365.com
 (2603:10b6:510:23d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:16:12 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 11:15:48 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 11:15:48 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 11:15:46 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v12 11/12] virtio_net: Add support for TCP and UDP ethtool rules
Date: Wed, 19 Nov 2025 13:15:22 -0600
Message-ID: <20251119191524.4572-12-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251119191524.4572-1-danielj@nvidia.com>
References: <20251119191524.4572-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff78555-f186-4737-2a26-08de27a01aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3LZFAV3TW2kZvgsJsFLBgra/9LIFc2AAZYD7UwgI4l9CROCXWHBAgNdovyy5?=
 =?us-ascii?Q?6XMS1Dcl/XFveGZM8XXMW2BtTvQctvVtfirlK5lwSXcUPwF6ScGDe7riHoVE?=
 =?us-ascii?Q?tZyFE5GLYNpnCudR0uLbsVxdsLhoK/gevu/3w5sgWksFseFkkU0DTzzWY2VD?=
 =?us-ascii?Q?noQouONQi/GHXjUdoRo2Y7r63uM0eAwFTvhPXsovKKkD75yDxcBrvfvRwWcg?=
 =?us-ascii?Q?1wCwGZrTiQ5zeXpj0TGA6VlG9GcTD9siwVuApIrO9KGeTRA4mhtVS2Fz5Su+?=
 =?us-ascii?Q?08qGVzumkgbpPVPnKGg3LO5ZfTCYbmsgxkwSjpWcx38jaIuBSWlXVbzRqxoG?=
 =?us-ascii?Q?Xm4IGDQTDPKuF5Jn4RKck/xcDOwVQGxty3lBikkoDZT9soYdAGtssOGsoZZw?=
 =?us-ascii?Q?1tDaPwF7J7R1QimSRHbqz1izjK0H98F5Flev4LAWJ8A/aDtn0PRWt477Q5+p?=
 =?us-ascii?Q?+qp1+27fBspCLlk/GgF0cVLkcZ7kfak312tTQQTuWHCkj7z9Jq+1wudX0D+u?=
 =?us-ascii?Q?ELSTxH66SIkyuFK3qF3FyiLUdYbgd/GmLpE6f0/uQ/0UrUisY9XyBt0QSBvD?=
 =?us-ascii?Q?wHcxwY/vVtYXqaYPCSN5dKXvSmizYgy34pO4iflHLe71BbgtEc/ApKJkthtN?=
 =?us-ascii?Q?lbJFB46TZjbAm6k2OtQzRQUfCTvF1xnN4xxXMhQ0GneOZLFQbnTC8MbVlHOU?=
 =?us-ascii?Q?PcJn7O3bRtnaGWlUwys9wpTbjQHbexWKYAKO+OqK2vgxaSP9TyXAwCvLCzfe?=
 =?us-ascii?Q?FZrh+VQAJYZDvk/8WyIRoUWQy20/+FBD8Fu22QtJzWCQuP4DCZIBZAMHqPGQ?=
 =?us-ascii?Q?4pA34G2AOQXA+rUiH0tZm/W/QPykUUFVcqZTLZCtq479kAZztsB9g0tTQW3U?=
 =?us-ascii?Q?Q4xEEY/tMmYGakfPRRn8vEM8GKGfIJQMnCCvBuw1JfAqRKLCeoEh+v4bBIEM?=
 =?us-ascii?Q?jQWBwo4G3PqZTaYfhXO3NZpRrMBhiiFyn2Yg3eo/yt0B/DUNNtZWybIKMhSe?=
 =?us-ascii?Q?bziryOhSD37tQEG1I2XJY4g+O4ULB76dgdDKwAcFlYVYWgU9dTg3c7sqYQrT?=
 =?us-ascii?Q?RgQABGR6/3PRbvLom4D4t7990R9CskiTls+FdTDPWW+Hq15sgEFI8v1OP9Gn?=
 =?us-ascii?Q?8qAigg2RVI8dUk3LnpZtcbV8OxMQizRScMhz3OBxW4xA8C2eeyQ/kxfALHME?=
 =?us-ascii?Q?DCMyTPmJsgyf3MJJKXyXSfx+zsx1mJwmlnCWg+nvE7A42LuI5KqkoLqLDb96?=
 =?us-ascii?Q?nzfo6/1ZsBoybO1czdptdBK92vK7MUNyGudKaBxpHcoPKTy2A+YXcbPOQpw/?=
 =?us-ascii?Q?3SBFJlFeUH2IwGisWgtbKXAyUJvBt/N5H2mkblC7BbCzkDTIdF5Dm90NHbct?=
 =?us-ascii?Q?LjiJbh1Z+0WYFlLvB4hugnsFZD3CXh5MRVlM/YvhuUz1cslm2IzdDp2O/rqk?=
 =?us-ascii?Q?FJihDquDqx2E62z235RvWUZNeV7U048k9Uw48Dn0zrzBje4h167kdQXQ9iP1?=
 =?us-ascii?Q?6E0a/4ZHQYg5rgbPgr9fhuk9GW0vJ8xDdKeqY2j5bqINO8viJHTgdduWeW24?=
 =?us-ascii?Q?4iE1W6neCOG4GxgtULE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:16:12.7279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff78555-f186-4737-2a26-08de27a01aa5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392

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

v12:
  - Refactor calculate_flow_sizes. MST
  - Refactor build_and_insert to remove goto validate. MST
  - Move parse_ip4/6 l3_mask check here. MST
---
---
 drivers/net/virtio_net.c | 223 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 212 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index bb8ec4265da5..e6c7e8cd4ab4 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5950,6 +5950,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
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
@@ -5967,11 +6013,45 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
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
@@ -5987,6 +6067,11 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
 		mask->daddr = l3_mask->ip4dst;
 		key->daddr = l3_val->ip4dst;
 	}
+
+	if (l3_mask->proto) {
+		mask->protocol = l3_mask->proto;
+		key->protocol = l3_val->proto;
+	}
 }
 
 static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
@@ -6004,16 +6089,35 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
 		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
 		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
 	}
+
+	if (l3_mask->l4_proto) {
+		mask->nexthdr = l3_mask->l4_proto;
+		key->nexthdr = l3_val->l4_proto;
+	}
 }
 
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
@@ -6153,6 +6257,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
 	case IPV6_USER_FLOW:
+	case TCP_V4_FLOW:
+	case TCP_V6_FLOW:
+	case UDP_V4_FLOW:
+	case UDP_V6_FLOW:
 		return true;
 	}
 
@@ -6194,6 +6302,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 			size += sizeof(struct iphdr);
 		else if (has_ipv6(fs->flow_type))
 			size += sizeof(struct ipv6hdr);
+
+		if (has_tcp(fs->flow_type) || has_udp(fs->flow_type)) {
+			++(*num_hdrs);
+			size += has_tcp(fs->flow_type) ? sizeof(struct tcphdr) :
+							 sizeof(struct udphdr);
+		}
 	}
 
 	BUG_ON(size > 0xff);
@@ -6233,7 +6347,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
 static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 			     u8 *key,
-			     const struct ethtool_rx_flow_spec *fs)
+			     const struct ethtool_rx_flow_spec *fs,
+			     int num_hdrs)
 {
 	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
 	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
@@ -6244,23 +6359,95 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV6;
 		selector->length = sizeof(struct ipv6hdr);
 
-		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
-		    fs->m_u.usr_ip6_spec.l4_4_bytes)
+		if (num_hdrs == 2 && (fs->h_u.usr_ip6_spec.l4_4_bytes ||
+				      fs->m_u.usr_ip6_spec.l4_4_bytes))
 			return -EINVAL;
 
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
-		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
-		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
-		    fs->m_u.usr_ip4_spec.ip_ver ||
-		    fs->m_u.usr_ip4_spec.proto)
+		if (num_hdrs == 2 &&
+		    (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+		     fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
+		     fs->m_u.usr_ip4_spec.l4_4_bytes ||
+		     fs->m_u.usr_ip4_spec.ip_ver ||
+		     fs->m_u.usr_ip4_spec.proto))
 			return -EINVAL;
 
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
@@ -6300,6 +6487,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	struct virtio_net_ff_selector *selector;
 	struct virtnet_classifier *c;
 	size_t classifier_size;
+	size_t key_offset;
 	int num_hdrs;
 	u8 key_size;
 	u8 *key;
@@ -6332,11 +6520,24 @@ static int build_and_insert(struct virtnet_ff *ff,
 	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
 
 	if (num_hdrs != 1) {
+		key_offset = selector->length;
 		selector = next_selector(selector);
 
-		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
+		err = setup_ip_key_mask(selector, key + key_offset,
+					fs, num_hdrs);
 		if (err)
 			goto err_classifier;
+
+		if (num_hdrs >= 2) {
+			key_offset += selector->length;
+			selector = next_selector(selector);
+
+			err = setup_transport_key_mask(selector,
+						       key + key_offset,
+						       fs);
+			if (err)
+				goto err_classifier;
+		}
 	}
 
 	err = validate_classifier_selectors(ff, classifier, num_hdrs);
-- 
2.50.1


