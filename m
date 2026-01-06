Return-Path: <netdev+bounces-247406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19083CF976B
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 17:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FD1C3016BAB
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B49433A717;
	Tue,  6 Jan 2026 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uq0+R6AG"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012067.outbound.protection.outlook.com [40.107.200.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD9D339859
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718334; cv=fail; b=c+lrcCFiQHN2JRcOmUNgNy3CBVwNs/7Bsh692AmeIhNLaL5YJuNR+5kpQkQt449Qc1lKQ+onvMJaHfoP+kLgqs+g3jk2Mja8gZQ4I2f6562ziK4sJ86DmX4SYWIsDMXOwxV7tkSBdd3ZYuLEWQevaU/175EfU4qCWhkO7PkQGBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718334; c=relaxed/simple;
	bh=t8UR2x88y/KTyi28POwdIlOIP+CZ1fbSYIJQ3fJzVI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOaE7Yqr1gcbeqYouZTeytN6nnpZEwYaLpbVouv+q3RnoGM3cB501p5BItUkuc9md8g2wgoUKpM8TsBTiBSX8aWPazgrb2P5yGXBJg1eIvlMP1q08E+P7wNXwmaHA9sWDL2ksytTC2C9eLRKDWPP7Rxtg4Dvg/+0eGj8yMEwU+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uq0+R6AG; arc=fail smtp.client-ip=40.107.200.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUcEpFhO3WI/Tp9daIDxd+Y35RXYm33iZuCKuIBcMb/dlarXtbHtFgzAgTMYOAnENd3StBtdMKqQDCar7G4HhQ4I+w1i48kQepRN7CKNaNF4o4FFyi5gJY/NdvIgiIzuQIxZS8/uTcacWxkwWx7MV1V6ItkqunWcMHvsg8JAJpdX+WcGv2gTAvt05hP2ZtX6bC7YgLPAcoWnvsLWHefaosyK6jfGxJxAi2KV2fwxmKytjBHUQRWuBv9H66xgq3aWIyjOEEILqVEIWWHfXc9OfZl80+RjW4Umbw35lOIIWL3pr6XToGGTtaX1gZlzs+7ZBdjtW6JVTw8aaovy/zJ2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nq3n3/ppmZwMwY4ZUy1eL6rgmZCoEhjqCvUx/4oIOI=;
 b=kA1wvK3KI6yCQAghCnC5+uOWGGzyp1SNM21NJSlLYCK3zPJnJ5P6AxMlFF9Ue+KJr5p7WLuTbxpK91j90OjZ7wX3Sqz0MJpMVLICE5hkXM4ADMYM8PXmCLumjt5/d445g3jZOxIfcOx9oP4ZymoHQfUPu9Nj7c+KD+I1oWMe9BLSaZlMCKeKUj9IEZQCHv7gm/9JR2FyU1LviyfuQHpilRgXVHpqVvh4iEGsMcel6teMZf16Vyru0Di+oNbnLd25niHFTF54IQM83tAqNIx9EDjinF+Oii8nzaII3NaIHnEFJaNYMbVFPShgoPxlQ6bMx6WFASrlJ2/f1CcKaHthZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nq3n3/ppmZwMwY4ZUy1eL6rgmZCoEhjqCvUx/4oIOI=;
 b=uq0+R6AGPje5kfrzYT3ReY9CfwDCp/FtRLZdiHbzdxsKEtDjTIQYupnQ1ingIBUN3eToO2PiG6FZcWfGM4cnpEK4qJEJMtUagd4/sL1R5xMXZMmIEvRwxTku+ZasSK29PXadqVxD0Ocn1Cfui9V5fTiwQJLtxoIwpLDt3n0gAR1GX39rm7hQorblWQiZZe9jkNXuk0bTpaqSOkBKM8m3AyUZQEezju25Qpt/zw6tVugqjabguoGe+8Id+uG1Uay4B9k+4xaqAyC/mKLgDS2UikMo+VsC8YL5WkzOZ/DF4RwM/0thm1n6wFhxQt5iVzYV4rvsKRmjTFl3tBJtLviWMQ==
Received: from BY3PR10CA0002.namprd10.prod.outlook.com (2603:10b6:a03:255::7)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 16:52:01 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::2a) by BY3PR10CA0002.outlook.office365.com
 (2603:10b6:a03:255::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Tue, 6
 Jan 2026 16:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 16:52:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:45 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:44 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 6 Jan
 2026 08:51:42 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v14 11/12] virtio_net: Add support for TCP and UDP ethtool rules
Date: Tue, 6 Jan 2026 10:50:29 -0600
Message-ID: <20260106165030.45726-12-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260106165030.45726-1-danielj@nvidia.com>
References: <20260106165030.45726-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|MW4PR12MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 78fcfd3c-011e-41ef-9f5d-08de4d43e975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yd2yA7x9jhaVDRSK+ksmg4eZqxyrrpDLoaiHVmNl1OZzvd2vrZMHAhsdpP2J?=
 =?us-ascii?Q?r4Cp8jzIlb+QL2wVk8tJOVyCrTisvHsHZ+YehZGuTvYA3nNigoV6cfkhKuN5?=
 =?us-ascii?Q?ErfM7peB13PWsJQRE809qU4XnbLfTdK3K9g0cnkPPNa8RB+gBV48VK2Ki9jf?=
 =?us-ascii?Q?U8QYGx93fkFDaTJlOLQ7XI8RO23PuyVDMicNEZ7m1h4sRcVAGWYB4u2CdeZN?=
 =?us-ascii?Q?0k9gKVvwqY3HSsRbCffmB2cZcQXV+s6pRfoSBcmHMqBIY2tFrNWWuWzhUOGH?=
 =?us-ascii?Q?DqCu1OWeHxz4wHi+soMem5o3ZRkfBySuxnAohPzlSQxhaJVV7CVkMgvDoIg7?=
 =?us-ascii?Q?IhR1TwjF36sM2qu9PBu39tVR12rGiFtbVbd+UGbL2np4Eirwdn1GNkhdZh7d?=
 =?us-ascii?Q?z2Q3zyNH/YWXyXcFy2+s9P+b3C0roEXmHtT5KEms8S8xRw52kIdwo5e+NCS4?=
 =?us-ascii?Q?fmTMI5FOBfCa+BR/V1SI0w/E9CC/jnPwezV8IGxc+/bHvXeyjYQGC6Qgg++B?=
 =?us-ascii?Q?Ycb2G9J8QpAi5qJ+cp1NvmsUd3QEXxCCxK46pSWb4rOIihpDXtldLoXzvEzL?=
 =?us-ascii?Q?oDk7Fd8YuvcchG1Gg5tAboVg7dSxqnwebfVKQ29cJ9XF3lnXWc8wjlOsfl58?=
 =?us-ascii?Q?JqNCB6XL2TVttyAb7VAILKDS8n+rX1BoT9TW7c7808Ek6Aj31pD6wqoU/xzS?=
 =?us-ascii?Q?6ibvDcyQ8UOYOztUNgNZQ3dmAHMjKWoyjz6jnwZGXT805VKmvTSVbfrpjE/4?=
 =?us-ascii?Q?8K+tTfs5WK2GQ8gWDT1xDKKweij809kVTiVwW7GFbEHlCBRWcPTCAfQ11qpF?=
 =?us-ascii?Q?syJiPKZ6pA+hdqZC+9epW0mjm13v+V7FTHDQ6K7eKNQfWCqEY2Ad/P86Etuz?=
 =?us-ascii?Q?SQ34sSSM8qcibB4iP/lsAibzkte+U7PjVJfemN7QQkjqdaAdfxy9a3jYbGnn?=
 =?us-ascii?Q?0epdS44qcSATVvFh2stXwnm2yUBbZAeVcEshHtD9AQ4fUhalSRBmNYHU9jbQ?=
 =?us-ascii?Q?qTK2Dg+R20hYFEnee0E/tNHGNNzEXQ1Af9SBbv1CrOEgW8LTbZJ+0JAE9K4H?=
 =?us-ascii?Q?0MyCIfZwT56zqPWsZ1o+YzQF9jQIYYcqUONdZUZi07dxV2tkM7sZNpyoIZjq?=
 =?us-ascii?Q?ZEnY5+BpxFoSkMFOGrwc/yjPDaC2w4Y2z8TfNn3EJpFAUvbQwmVWp8e/JweP?=
 =?us-ascii?Q?QMPi8jv+Fv0AVoEJK5gTKVZXxJm3FLwAzk5X2dt6AYLdSpP4b9RhjJUJJnIX?=
 =?us-ascii?Q?o2J9tvXZeUUKXR73VF20qvq2NaBqBWSUaIW7nSoXAFc5yInopj71gjRmmO9c?=
 =?us-ascii?Q?9yvfoG3jQQZc6GXy6Fn5oUKvHIvpcLvu5zVpxB8+4OA76K6XzH975TTW1uy4?=
 =?us-ascii?Q?bd5SU66sJLICmgIzMXsmK4HJq6BKeA/BVHXimyGEUdRKyvf8djOnidWYUQSX?=
 =?us-ascii?Q?VOaifhpc91qVKeRhsP1Cm1oAM+jGGaTmJq4t4CpK+eZcX/axchIut/p6V045?=
 =?us-ascii?Q?5qxhM5QwKnPA9XyYSL1AkShreGBfM0YUF17TvrfMtSwYlW/gx4zSHshMZHtp?=
 =?us-ascii?Q?pm1710F9OYP63/wAyPg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 16:52:00.6755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fcfd3c-011e-41ef-9f5d-08de4d43e975
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705

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

v14:
  - Add tcp and udp includes. MST
  - Don't set l3_mask in parse_ipv?. The field isn't in the tcpip?_spec
    structures. It's fine to remove since it is set explicitly in
    setup_ip_key_mask.  Simon Hormon/Claude Code
---
---
 drivers/net/virtio_net.c | 221 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 207 insertions(+), 14 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 15678a408554..1b2e23716476 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -31,6 +31,8 @@
 #include <net/ip.h>
 #include <uapi/linux/virtio_pci.h>
 #include <uapi/linux/virtio_net_ff.h>
+#include <uapi/linux/tcp.h>
+#include <uapi/linux/udp.h>
 #include <linux/xarray.h>
 #include <linux/refcount.h>
 
@@ -5964,6 +5966,52 @@ static bool validate_ip6_mask(const struct virtnet_ff *ff,
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
@@ -5981,11 +6029,45 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
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
@@ -6027,12 +6109,26 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
 
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
@@ -6172,6 +6268,10 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
 	case IPV6_USER_FLOW:
+	case TCP_V4_FLOW:
+	case TCP_V6_FLOW:
+	case UDP_V4_FLOW:
+	case UDP_V6_FLOW:
 		return true;
 	}
 
@@ -6213,6 +6313,12 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -6252,7 +6358,8 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
 static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 			     u8 *key,
-			     const struct ethtool_rx_flow_spec *fs)
+			     const struct ethtool_rx_flow_spec *fs,
+			     int num_hdrs)
 {
 	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
 	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
@@ -6264,27 +6371,99 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 		selector->length = sizeof(struct ipv6hdr);
 
 		/* exclude tclass, it's not exposed properly struct ip6hdr */
-		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
-		    fs->m_u.usr_ip6_spec.l4_4_bytes ||
-		    fs->h_u.usr_ip6_spec.tclass ||
+		if (fs->h_u.usr_ip6_spec.tclass ||
 		    fs->m_u.usr_ip6_spec.tclass ||
-		    fs->h_u.usr_ip6_spec.l4_proto ||
-		    fs->m_u.usr_ip6_spec.l4_proto)
+		    (num_hdrs == 2 && (fs->h_u.usr_ip6_spec.l4_4_bytes ||
+				      fs->m_u.usr_ip6_spec.l4_4_bytes ||
+				      fs->h_u.usr_ip6_spec.l4_proto ||
+				      fs->m_u.usr_ip6_spec.l4_proto)))
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
@@ -6324,6 +6503,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	struct virtio_net_ff_selector *selector;
 	struct virtnet_classifier *c;
 	size_t classifier_size;
+	size_t key_offset;
 	int num_hdrs;
 	u8 key_size;
 	u8 *key;
@@ -6356,11 +6536,24 @@ static int build_and_insert(struct virtnet_ff *ff,
 	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
 
 	if (has_ipv4(fs->flow_type) || has_ipv6(fs->flow_type)) {
+		key_offset = selector->length;
 		selector = next_selector(selector);
 
-		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
+		err = setup_ip_key_mask(selector, key + key_offset,
+					fs, num_hdrs);
 		if (err)
 			goto err_classifier;
+
+		if (has_udp(fs->flow_type) || has_tcp(fs->flow_type)) {
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


