Return-Path: <netdev+bounces-225637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB3CB9631B
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43CE19C461F
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87C424A063;
	Tue, 23 Sep 2025 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cUOLam+f"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013013.outbound.protection.outlook.com [40.93.196.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A118231C91
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637206; cv=fail; b=GdNFRgS+yBK2etG/RxnA/dcW24ZPnfaxeRRLbbBDZgPFzQ+8q81JsK+YoCM4nSm3zNuTtu6bLbYs0DBp86LXn9uE3DWcYbng78zHTEhdkflqbV7YDTU9ax0ctLqaY00lvO4iwfghVdRJr5OUxMgTpFDJRhAbTd2Mi1rPgTQYNNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637206; c=relaxed/simple;
	bh=VGIKPutOk9Yg7L1UvI9w+yL8Hqmzzyb/rDMHnYZJdMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRDDgFeVG0OALxXwx07p/gPOiH5tmLDWgwljiiTjHs5/ZRkYeVOWWZf24ELNAanIurmP5rjbMgeztgMW9DcEJ5B9YUmTqygU4/GhdGIz8dkoRN7MMclwoWz1fc8Ce+jpX8BLHzBbhGzb/l9YdX6V1sDDytA2TQg6lkDZFdw0Oco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cUOLam+f; arc=fail smtp.client-ip=40.93.196.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vg4txML20HBBbuASzaRQ08DcIndczdrTWKUx6GO0qQQ4mWZZCfPXgk4286bKXLVwM2XAV6q/fBL0wJVrA0YLf2wr98rfyN+5EsgvBYc63gQUI5CzmzaZ+jDKJ+g20Caqh03IxUsM7XVki1Fvjat/4JdOLLoZH4ZGM0MzLqOgWKpHCh8itxGbyIsjTVTt0JcthPtxaqNsYePUbU0wlvZchjSY9/2tgGuiIwYlu3jkZE2iYL3cbIITOQz1CRyO8pvWvz0FBkbIZyzmwqtSqdSgt4hFPkCZKVIK3TLW2iAvcVry7JsgBxiyEALf8wmC7hI0jUvPSGrGCZcCXQYkJHx6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zf1/0r0Uj0R34d8ERVjjsuwL0iJ1uHDLosY1RVIakXQ=;
 b=gr+sbBaaeJwEaEJLI1ocNP/Spm3+3FR2o6s76EarBoIUt8OlTPh/9Y9bQA9D1fK3M+L253jYLb4OUX5GO7Zjp6SPZs+CHZryb9Lx9BRQZklCJj/bZS4ST+eVw15sYfCMW+/LF/2wnH6Te8qd/FxUIaEZnAqILIhtDtGMYkdRrARjVCvoIzKHMrlLmuWcljg0UjpClsuq68K8ecHwjbEH4H1RGZUDLXCLCmNk2lLtk016hG+aHdlURXZ3NK5vervtnUTgh8edW6wn+8+hZQAdifh69vsb5m4icmA1WZXlqQp3kDZfE/fJv1nxUfdAImuuEh3O2YN9sj7NZzCnBqqTSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zf1/0r0Uj0R34d8ERVjjsuwL0iJ1uHDLosY1RVIakXQ=;
 b=cUOLam+filEYVGbgrrw0xlmi/5ZycLhPwZ8rSDob7OLvW9vvtyt62umIuZonU/9WmjZJw1oiEGfKtYtJuP0PUUx4EL9bgo9V1NBgB390MVViPBNJbJgd5aSV0TaAEQcnLvzbzSQ1gXl4vd1zApXl9cSrtCHluN8b+FQJmGreNKW/SA/EwP3yK/G2OGSgVWzMUs/CBr4KijtQ0jJIsGvQ97CvjOqBhxS2d5G8BLaAQoVwItuvsOAV1UFRvrFypLUzXk3E4bEPammhvBenO7vdmOyeJC7/1+FySP0nGuGtR6hhkoFzwqbitg8Nb4EzKi0PavfkJWT7lOuAjUdjENMR/w==
Received: from BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::11)
 by DS0PR12MB9725.namprd12.prod.outlook.com (2603:10b6:8:226::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Tue, 23 Sep
 2025 14:20:01 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::97) by BY1P220CA0011.outlook.office365.com
 (2603:10b6:a03:59d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Tue,
 23 Sep 2025 14:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 14:20:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 07:19:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 23 Sep 2025 07:19:45 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 07:19:43 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v3 08/11] virtio_net: Implement IPv4 ethtool flow rules
Date: Tue, 23 Sep 2025 09:19:17 -0500
Message-ID: <20250923141920.283862-9-danielj@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250923141920.283862-1-danielj@nvidia.com>
References: <20250923141920.283862-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|DS0PR12MB9725:EE_
X-MS-Office365-Filtering-Correlation-Id: 07631f45-b35a-42fa-1c0b-08ddfaac48ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mLCCnZFW175MO+w5RvJOc0+ZdgLh0xrpOMv1o1FWO7Ig1IvrrPMH07AeszG3?=
 =?us-ascii?Q?N5qNIy8D2iicXKAQAaz2P/mHcb03m+rJh48LwhLT/pMH1RP4tq9fhO8EOlfI?=
 =?us-ascii?Q?TXRzPv1XkLqRuQ33JvckFF0ENESpyD45FG9PzBD2iiKYu8bS66b08CZFzJtQ?=
 =?us-ascii?Q?rX0Oyg0R/A9Q/V7LUrwLL+J3W1T/W/KLo7nToUt7wB1ty1N1xOLGp2vD4CjH?=
 =?us-ascii?Q?6zz6nIXr+45n/KR+NoG6QvxEKyR8oJwtOBZZFtqmYH5p2x8jRA4EgKO6bdBK?=
 =?us-ascii?Q?N52Xp0a3MI3QA2vCVA1W4yfCa33mqYkmKK5e+V8tzM2ADNvQfeXSa/7VAOr/?=
 =?us-ascii?Q?B3aq/5VNXvxrPa5A4MwGz9n7yftk2yv17R+MXwfRKOuc1ftiYjbebdQUZt1O?=
 =?us-ascii?Q?YjO+ZbLS5/Y2rsCEf4DO+aYT6D1yCdTogzRWP+2kYDoeZ/JDo+3xBG3YrV75?=
 =?us-ascii?Q?kyjdQehKKJKyYqihteGSA2CD+wjvMqXLxLiKnYDvqgn7nj0uhpxgmAcr+9W7?=
 =?us-ascii?Q?4yeL9sBOLYa4udfwa0NWFcmPm7pB2LWJc+y70Wo8TcRd44ohDArj+qisp4G7?=
 =?us-ascii?Q?6XHr0nDflI4B1wTbKXEB9gDIg4T3901ZPX+pnVJwuYY03N8P1+XxIwDotjZj?=
 =?us-ascii?Q?YdZ2jP/PB6vUsWgoC7h5CgrBwmdr3rh5zhX8WHoanF+jriz0Vt1Bkj8YxY2O?=
 =?us-ascii?Q?y3c8YHc/jLg3vMEjdMAHUdZAy7HPS1ndaU2onkbRGuTlJrdo6kG3NM6b5Dtd?=
 =?us-ascii?Q?gSC2iPtYn5NKdnGJilP7/AFZOPfJIXi5bjX9I0pn5ZcXvpYj6kE/5XI6EAaH?=
 =?us-ascii?Q?gRvkZ2HHTOkGDcMNqCJS9myJ45ODz3qSsUQqOCw9CgdIENVcyA2MRObCJXHu?=
 =?us-ascii?Q?YBxM07qcaaa/Gk3Z8cJ317zso5+eZTA45+Dvwn5QWaW0RNW6bYMwG7jKFSEh?=
 =?us-ascii?Q?Cc1Jn47gq1XvZDch9Pxq66U84d+WrZpASPfhQspDOCNWdvVh/rK1Qca5lU4W?=
 =?us-ascii?Q?jQyiX7I8vFY1y2O44zmlr7Rb9QLlGlQMDA4k794N4jTO4zOPyY1yHS2rp6xt?=
 =?us-ascii?Q?ZApbtqe2B3ovoJ65yuFNCyXle2nBgjmMqx78lqRGn9OdKVg1O4tO0eo0OMni?=
 =?us-ascii?Q?2WW2Ds5qfS9WkmxDfBC1gkuBP/EKbAbSB5kMZbk3hxxBtdjVvj+vo5FjJ5CA?=
 =?us-ascii?Q?+7ed0IcivsgSEqDguK5LrU4q8Y6l0rl62k1qXDadxNaw6NDxC5knB6+/Bon5?=
 =?us-ascii?Q?Sv9uKkhpRd1wyNHPu71LpjFjFUC7eHDmMcps82cJcmSzqxztZH9MPdiCQEsE?=
 =?us-ascii?Q?7xdZ3rVfPa2X3uj3vaFESsYm/0sVfdtCJ2SRwlOTeeNNWQ3Xs7Mft6mNfost?=
 =?us-ascii?Q?avB0WZoyW8UNS8NRUAqY2eZ/rx93385PEVi4bj6MbRpLDH5GBsoXazvIJXsu?=
 =?us-ascii?Q?Uc89BB1euP77sRkzMddQj59G7iPpSzK9gjICu7nMpgrIUMz4FIyoz+MKV/qH?=
 =?us-ascii?Q?97OZfVVGxv0gILm4cgufvo02kT/OhfJlsRQd?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 14:20:01.6834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07631f45-b35a-42fa-1c0b-08ddfaac48ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9725

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
2.45.0


