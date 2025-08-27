Return-Path: <netdev+bounces-217408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DA5B389B5
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 20:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875F41B22A3B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18522ECEA6;
	Wed, 27 Aug 2025 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tACSdbkz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857C32E2657
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756319966; cv=fail; b=Jnrqmi7GDwiz/VFGA3LaUqDnkUpotRmp3SVz1mRfiy9rGwip2z7ANgn5p+YKn7u++9WxJ6SO48vBViy3MP/UYapZgHKSdqN2wpcsFvIxXumhsdVPmq2jSSIkl6Ntv4NSWUU9MBpnRnO0+nviZWzcaI+dQ0jJqfQAFT+0fU2RhLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756319966; c=relaxed/simple;
	bh=wvWdsmkmKF5gNfgdFJD3LNXNyIbv0VZMW1loUYUpAKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxn3XO0CncZNxNhSErEYsRgkfbrmUYoasgw/B9NqHlPf3YmjLQ+h3hq1iX8ervEOl4UBjiXtTrlKBURcvOo1ZPJPG7UJQFE6deyy+4i2qkqxrNQYp0WFjKihQmYM9ybTnHvtr1b5x9aeHTfbYO6I1KY1Ks0u8Al9mgBtBvp+kqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tACSdbkz; arc=fail smtp.client-ip=40.107.100.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmhbbEllBlh33AoqIGLRc9BBGvoF8UIFMNUMOqsM587I3bHzDMqhp1gnTRAQ/50koVKjQyXbkFa8glaLVUQMBalkqEvvODx3l5VcENj8JSeXKIJbqUR7XxHWObBz2pb1yMLyERMg+QdcLltSeA/A8+VpdM7dvxsj2h6TayBxRuSHcg4hDjbyFZAzd4afXybxgd5DWBX0jd0lAxVGWN0we8RaRlBEeN+fjVSFzyzS0N+OVIDxg2s/HoFup+CEhhcblo+pplKqN+dOpKMNaEq04wt7/BUbYLMN/Nbe1adigMCQQeppZ9CnpvQI/VAA44SlmoGk26LVgpH55iUfIcRsRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2uOEXzb7yY+J0EhJBNLE+93gUM5e+B1x9qvzcTZo3Y=;
 b=RLnHAshkYILE+NXv0MWX5URWzBv22LUo489j5Oot382+wruSgMq3upzPbN1IOSPL7fTHuPLka4Pqmhfmh7Vqu/U5TeSqK/oOzAxT3sxKwZzkJzJW9obsdPdOhxLMgnvPTk1Df5AkwejnBZ9NXRtX4RyBQuDdDKzneOgZzVVsM6mWNU9ppg1hjXjzKVajQpOAIMW8KBCI//eaGIFmx9q0qJQ0ysydkHGsHijXT1xXjuvvLKHWuckcgcw2+8fClCdTACHy429rwwTlOHH2gR0yOgx1BqELnL7TFGlTjsl78ciLOMHzFmUuwxXD5cMqkUuXqRyQ2sKAYSEL5IauaJGwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2uOEXzb7yY+J0EhJBNLE+93gUM5e+B1x9qvzcTZo3Y=;
 b=tACSdbkzBJIMZv3nUXSX77CzWpExtmB+bYG/M1bCrS0vYPGnLjBaBW4RPmRclaqM4+89Kj6evXA6YGz7sYImolzb5T5D+Sb1mjW+xizHfgMS0bPPD+KpA1Z0bPfXItWzbmkf3v7OKk+AD8YpoUs9pzm2eG1KxFCaXvfsAt3ziYT3TCGEOF4iPw+Ki7zqRl3UPJGDMw5cjNvcAb65A9V3LmQlAjiw3PsCsDtUkETxbLb5gbaxD5e/GdHIAZVZBndM9sMj4h7RLZWBur/EfgB1b1XhHI8RazaE/qz086OcCFo40MxxqOxVS/n+5V86mT9Y+rCfOQ9Oan8WOFAa2YPwfg==
Received: from CH2PR07CA0062.namprd07.prod.outlook.com (2603:10b6:610:5b::36)
 by BN5PR12MB9540.namprd12.prod.outlook.com (2603:10b6:408:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Wed, 27 Aug
 2025 18:39:20 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::41) by CH2PR07CA0062.outlook.office365.com
 (2603:10b6:610:5b::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.14 via Frontend Transport; Wed,
 27 Aug 2025 18:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 27 Aug 2025 18:39:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 11:39:08 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 27 Aug 2025 11:39:08 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 27 Aug 2025 11:39:07 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next 06/11] virtio_net: Implement layer 2 ethtool flow rules
Date: Wed, 27 Aug 2025 13:38:47 -0500
Message-ID: <20250827183852.2471-7-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|BN5PR12MB9540:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b69a20-275a-4ea6-27e5-08dde59908d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ad43AlXPwwOeHgv2evklVnJS6M7HP8zJWWW1xicJIQoxCz3viEITOSk47JUB?=
 =?us-ascii?Q?r8kJHJL3vfm8zG4IRY+N+KeYFA0bnTa/OEjuJ+PQ4UbphxqshVCVWYZvWoId?=
 =?us-ascii?Q?zUh+80dAoGysKq9ReiE87jn8zXxnW2jnWjQYDaBW1WtXnWxPLXHCxPaKnS5/?=
 =?us-ascii?Q?rE5IDVPZzorDn3to9Jq2O4xgjesXO1ruQyXoNVIaM+cKuGdxlyfykugxPFq8?=
 =?us-ascii?Q?8/UdfyoEgiOWTy+Nj5ZjtsydrdN/CYh3vVmLWX9JxmE7FxQkzXhKNivN9aLc?=
 =?us-ascii?Q?SK7UAlcqBgvIdNXC6NZFGrFYlkKm4LjndFh2L7QSS8nOgLK7BbhCpSMtpiMM?=
 =?us-ascii?Q?DKBMtjgyYDiWHPLeF5uRU9qxdWOyYHaFA3YGgucKgV7p8J1hrLcz50hvsoPn?=
 =?us-ascii?Q?Qx2VB+t4uYMqLYHH/anhQvoh8enLPgV9yd2khda0IO6g6jjirFU0lgA7B0f+?=
 =?us-ascii?Q?sJgcWYoRrCGcEHnJ0Qvo0b5UiG5dAUB61Wr9Fg1676g8mK2Er85+RuK++RiC?=
 =?us-ascii?Q?NYsXnXBxLtnbRDgY6p7PHoFjCcOUVc0aW8SS9GZqC7BIMBWGtE0f7JdurHR4?=
 =?us-ascii?Q?+VGOwbImUQWqekHThRC0RqGVODgAvi81IgeCjE/Rkm8X+lUx/Oxi27hK0Kpp?=
 =?us-ascii?Q?bK8yzpYP7mTFExlEI0nVvfb38Tpmf2Du919W/xGXDjcSZqMm6+SVn7pcEbez?=
 =?us-ascii?Q?D3o5H1uh9mnrbGj2t6SkJ4BoddQE7wGRABbwuP1fylyY5R0jzi0rffQmh5lr?=
 =?us-ascii?Q?9+QNAJQX866MqHdM6ABs24F2dfj3ggsIxAquCLdkZjUafUH2IG6oQx4vhWmC?=
 =?us-ascii?Q?lNZq7jF/CXncpqlOwibWwc7R3LlBGfs6n1BkPs2iceXhcDnP/qNNZ7rPVZ+z?=
 =?us-ascii?Q?9uzEqi28V0mHkVxGOBLqYiDKIY56JDYE8IWSj2kRQKwTHXb4nOeX0/HqZ4nR?=
 =?us-ascii?Q?A0K1kOXL/N9ixVd5LC5GydwjrnGsITVIStpYJOD2MYGD5islWNmCjctwhDix?=
 =?us-ascii?Q?PYvpGbJ4ha0BmckoG6Dbz001e3/nct9BGSOtYs/Yoq8BSOc5z+16OH9xfk5Q?=
 =?us-ascii?Q?62rkppBoTmkCDe2hvF2mWkwBbKfDJxZzu4NMP/2vMjViTTtZVEF4JVa0/x1u?=
 =?us-ascii?Q?MhS6ipwdxLMAIPhSfeUsse6WgsgyhCFL4w3DemIqiewYGDN5bHLeQeY+XI8m?=
 =?us-ascii?Q?Jjp4O7lFj9heRgt0jRCpnJKWj7DNiPtLzSQkv8LHsdP+U1QwVEZAaIiByKEH?=
 =?us-ascii?Q?b5TXotjlG0Sp7iKnRhMwp5jnBH+TnICV9fkL1HLilW2JgQEdaJOJvZZG0wme?=
 =?us-ascii?Q?j50p4QOUVM6VzjOOQBoYSiKn0+Xn3GsnJp9v2zbH3CLpxcdbqdv/DYyxmpAs?=
 =?us-ascii?Q?KE7RPZtgLHSo8n3/83O1IDKtpe2348vwJ2Jq7Vaoa2AjE8QhReJcWCFz9QK8?=
 =?us-ascii?Q?LlV9cLuA3Hqg/Y2UsxahNfquzLoLBtQYKS/zidNhQx+GiAe+orjbzd+QJmwc?=
 =?us-ascii?Q?OtfxngGIIo77XvP6Uu6xstUTiqXH1omk09J0?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 18:39:19.6036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b69a20-275a-4ea6-27e5-08dde59908d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9540

Filtering a flow requires a classifier to match the packets, and a rule
to filter on the matches.

A classifier consists of one or more selectors. There is one selector
per header type. A selector must only use fields set in the selector
capabality. If partial matching is supported, the classifier mask for a
particular field can be a subset of the mask for that field in the
capability.

The rule consists of a priority, an action and a key. The key is a byte
array containing headers corresponding to the selectors in the
classifier.

This patch implements ethtool rules for ethernet headers.

Example:
$ ethtool -U ens9 flow-type ether dst 08:11:22:33:44:54 action 30
Added rule with ID 1

The rule in the example directs received packets with the specified
destination MAC address to rq 30.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net/virtio_net_ff.c   | 421 +++++++++++++++++++++++
 drivers/net/virtio_net/virtio_net_ff.h   |  14 +
 drivers/net/virtio_net/virtio_net_main.c |  16 +
 include/uapi/linux/virtio_net_ff.h       |  20 ++
 4 files changed, 471 insertions(+)

diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
index 8ce7995e6622..473c2f169cfa 100644
--- a/drivers/net/virtio_net/virtio_net_ff.c
+++ b/drivers/net/virtio_net/virtio_net_ff.c
@@ -9,6 +9,416 @@
 #define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
 #define VIRTNET_FF_MAX_GROUPS 1
 
+struct virtnet_ethtool_rule {
+	struct ethtool_rx_flow_spec flow_spec;
+	u32 classifier_id;
+};
+
+/* New fields must be added before the classifier struct */
+struct virtnet_classifier {
+	size_t size;
+	u32 id;
+	struct virtio_net_resource_obj_ff_classifier classifier;
+};
+
+static bool check_mask_vs_cap(const void *m, const void *c,
+			      u16 len, bool partial)
+{
+	const u8 *mask = m;
+	const u8 *cap = c;
+	int i;
+
+	for (i = 0; i < len; i++) {
+		if (partial && ((mask[i] & cap[i]) != mask[i]))
+			return false;
+		if (!partial && mask[i] != cap[i])
+			return false;
+	}
+
+	return true;
+}
+
+static
+struct virtio_net_ff_selector *get_selector_cap(const struct virtnet_ff *ff,
+						u8 selector_type)
+{
+	struct virtio_net_ff_selector *sel;
+	u8 *buf;
+	int i;
+
+	buf = (u8 *)&ff->ff_mask->selectors;
+	sel = (struct virtio_net_ff_selector *)buf;
+
+	for (i = 0; i < ff->ff_mask->count; i++) {
+		if (sel->type == selector_type)
+			return sel;
+
+		buf += sizeof(struct virtio_net_ff_selector) + sel->length;
+		sel = (struct virtio_net_ff_selector *)buf;
+	}
+
+	return NULL;
+}
+
+static bool validate_eth_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct ethhdr *cap, *mask;
+	struct ethhdr zeros = {0};
+
+	cap = (struct ethhdr *)&sel_cap->mask;
+	mask = (struct ethhdr *)&sel->mask;
+
+	if (memcmp(&zeros.h_dest, mask->h_dest, sizeof(zeros.h_dest)) &&
+	    !check_mask_vs_cap(mask->h_dest, cap->h_dest,
+			       sizeof(mask->h_dest), partial_mask))
+		return false;
+
+	if (memcmp(&zeros.h_source, mask->h_source, sizeof(zeros.h_source)) &&
+	    !check_mask_vs_cap(mask->h_source, cap->h_source,
+			       sizeof(mask->h_source), partial_mask))
+		return false;
+
+	if (mask->h_proto &&
+	    !check_mask_vs_cap(&mask->h_proto, &cap->h_proto,
+			       sizeof(__be16), partial_mask))
+		return false;
+
+	return true;
+}
+
+static bool validate_mask(const struct virtnet_ff *ff,
+			  const struct virtio_net_ff_selector *sel)
+{
+	struct virtio_net_ff_selector *sel_cap = get_selector_cap(ff, sel->type);
+
+	if (!sel_cap)
+		return false;
+
+	switch (sel->type) {
+	case VIRTIO_NET_FF_MASK_TYPE_ETH:
+		return validate_eth_mask(ff, sel, sel_cap);
+	}
+
+	return false;
+}
+
+static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
+{
+	int err;
+
+	err = xa_alloc(&ff->classifiers, &c->id, c,
+		       XA_LIMIT(0, ff->ff_caps->classifiers_limit - 1),
+		       GFP_KERNEL);
+	if (err)
+		return err;
+
+	err = virtio_device_object_create(ff->vdev,
+					  VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
+					  c->id,
+					  &c->classifier,
+					  c->size);
+	if (err)
+		goto err_xarray;
+
+	return 0;
+
+err_xarray:
+	xa_erase(&ff->classifiers, c->id);
+
+	return err;
+}
+
+static void destroy_classifier(struct virtnet_ff *ff,
+			       u32 classifier_id)
+{
+	struct virtnet_classifier *c;
+
+	c = xa_load(&ff->classifiers, classifier_id);
+	if (c) {
+		virtio_device_object_destroy(ff->vdev,
+					     VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
+					     c->id);
+
+		xa_erase(&ff->classifiers, c->id);
+		kfree(c);
+	}
+}
+
+static void destroy_ethtool_rule(struct virtnet_ff *ff,
+				 struct virtnet_ethtool_rule *eth_rule)
+{
+	ff->ethtool.num_rules--;
+
+	virtio_device_object_destroy(ff->vdev,
+				     VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
+				     eth_rule->flow_spec.location);
+
+	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
+	destroy_classifier(ff, eth_rule->classifier_id);
+	kfree(eth_rule);
+}
+
+static int insert_rule(struct virtnet_ff *ff,
+		       struct virtnet_ethtool_rule *eth_rule,
+		       u32 classifier_id,
+		       const u8 *key,
+		       size_t key_size)
+{
+	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
+	struct virtio_net_resource_obj_ff_rule *ff_rule;
+	int err;
+
+	ff_rule = kzalloc(sizeof(*ff_rule) + key_size, GFP_KERNEL);
+	if (!ff_rule) {
+		err = -ENOMEM;
+		goto err_eth_rule;
+	}
+	/*
+	 * Intentionally leave the priority as 0. All rules have the same
+	 * priority.
+	 */
+	ff_rule->group_id = cpu_to_le32(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
+	ff_rule->classifier_id = cpu_to_le32(classifier_id);
+	ff_rule->key_length = (u8)key_size;
+	ff_rule->action = fs->ring_cookie == RX_CLS_FLOW_DISC ?
+					     VIRTIO_NET_FF_ACTION_DROP :
+					     VIRTIO_NET_FF_ACTION_RX_VQ;
+	ff_rule->vq_index = fs->ring_cookie != RX_CLS_FLOW_DISC ?
+					       fs->ring_cookie : 0;
+	memcpy(&ff_rule->keys, key, key_size);
+
+	err = virtio_device_object_create(ff->vdev,
+					  VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
+					  fs->location,
+					  ff_rule,
+					  sizeof(*ff_rule) + key_size);
+	if (err)
+		goto err_ff_rule;
+
+	eth_rule->classifier_id = classifier_id;
+	ff->ethtool.num_rules++;
+	kfree(ff_rule);
+
+	return 0;
+
+err_ff_rule:
+	kfree(ff_rule);
+err_eth_rule:
+	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
+	kfree(eth_rule);
+
+	return err;
+}
+
+static u32 flow_type_mask(u32 flow_type)
+{
+	return flow_type & ~(FLOW_EXT | FLOW_MAC_EXT | FLOW_RSS);
+}
+
+static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
+{
+	switch (fs->flow_type) {
+	case ETHER_FLOW:
+		return true;
+	}
+
+	return false;
+}
+
+static int validate_flow_input(struct virtnet_ff *ff,
+			       const struct ethtool_rx_flow_spec *fs,
+			       u16 curr_queue_pairs)
+{
+	/* Force users to use RX_CLS_LOC_ANY - don't allow specific locations */
+	if (fs->location != RX_CLS_LOC_ANY)
+		return -EOPNOTSUPP;
+
+	if (fs->ring_cookie != RX_CLS_FLOW_DISC &&
+	    fs->ring_cookie >= curr_queue_pairs)
+		return -EINVAL;
+
+	if (fs->flow_type != flow_type_mask(fs->flow_type))
+		return -EOPNOTSUPP;
+
+	if (!supported_flow_type(fs))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
+				 size_t *key_size, size_t *classifier_size,
+				 int *num_hdrs)
+{
+	*num_hdrs = 1;
+	*key_size = sizeof(struct ethhdr);
+	/*
+	 * The classifier size is the size of the classifier header, a selector
+	 * header for each type of header in the match critea, and each header
+	 * providing the mask for matching against.
+	 */
+	*classifier_size = *key_size +
+			   sizeof(struct virtio_net_resource_obj_ff_classifier) +
+			   sizeof(struct virtio_net_ff_selector) * (*num_hdrs);
+}
+
+static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
+				   u8 *key,
+				   const struct ethtool_rx_flow_spec *fs)
+{
+	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
+	struct ethhdr *eth_k = (struct ethhdr *)key;
+
+	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
+	selector->length = sizeof(struct ethhdr);
+
+	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
+	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+}
+
+static int
+validate_classifier_selectors(struct virtnet_ff *ff,
+			      struct virtio_net_resource_obj_ff_classifier *classifier,
+			      int num_hdrs)
+{
+	struct virtio_net_ff_selector *selector = classifier->selectors;
+
+	for (int i = 0; i < num_hdrs; i++) {
+		if (!validate_mask(ff, selector))
+			return -EINVAL;
+
+		selector = (struct virtio_net_ff_selector *)(((u8 *)selector) +
+			    sizeof(*selector) + selector->length);
+	}
+
+	return 0;
+}
+
+static int build_and_insert(struct virtnet_ff *ff,
+			    struct virtnet_ethtool_rule *eth_rule)
+{
+	struct virtio_net_resource_obj_ff_classifier *classifier;
+	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
+	struct virtio_net_ff_selector *selector;
+	struct virtnet_classifier *c;
+	size_t classifier_size;
+	size_t key_size;
+	int num_hdrs;
+	u8 *key;
+	int err;
+
+	calculate_flow_sizes(fs, &key_size, &classifier_size, &num_hdrs);
+
+	key = kzalloc(key_size, GFP_KERNEL);
+	if (!key)
+		return -ENOMEM;
+
+	/*
+	 * virio_net_ff_obj_ff_classifier is already included in the
+	 * classifier_size.
+	 */
+	c = kzalloc(classifier_size +
+		    sizeof(struct virtnet_classifier) -
+		    sizeof(struct virtio_net_resource_obj_ff_classifier),
+		    GFP_KERNEL);
+	if (!c)
+		return -ENOMEM;
+
+	c->size = classifier_size;
+	classifier = &c->classifier;
+	classifier->count = num_hdrs;
+	selector = &classifier->selectors[0];
+
+	setup_eth_hdr_key_mask(selector, key, fs);
+
+	err = validate_classifier_selectors(ff, classifier, num_hdrs);
+	if (err)
+		goto err_key;
+
+	err = setup_classifier(ff, c);
+	if (err)
+		goto err_classifier;
+
+	err = insert_rule(ff, eth_rule, c->id, key, key_size);
+	if (err) {
+		destroy_classifier(ff, c->id);
+		goto err_key;
+	}
+
+	return 0;
+
+err_classifier:
+	kfree(c);
+err_key:
+	kfree(key);
+
+	return err;
+}
+
+int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
+				struct ethtool_rx_flow_spec *fs,
+				u16 curr_queue_pairs)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	int err;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	err = validate_flow_input(ff, fs, curr_queue_pairs);
+	if (err)
+		return err;
+
+	eth_rule = kzalloc(sizeof(*eth_rule), GFP_KERNEL);
+	if (!eth_rule)
+		return -ENOMEM;
+
+	err = xa_alloc(&ff->ethtool.rules, &fs->location, eth_rule,
+		       XA_LIMIT(0, ff->ff_caps->rules_limit - 1),
+		       GFP_KERNEL);
+	if (err)
+		goto err_rule;
+
+	eth_rule->flow_spec = *fs;
+
+	err = build_and_insert(ff, eth_rule);
+	if (err)
+		goto err_xa;
+
+	return err;
+
+err_xa:
+	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
+
+err_rule:
+	fs->location = RX_CLS_LOC_ANY;
+	kfree(eth_rule);
+
+	return err;
+}
+
+int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	int err = 0;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	eth_rule = xa_load(&ff->ethtool.rules, location);
+	if (!eth_rule) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	destroy_ethtool_rule(ff, eth_rule);
+out:
+	return err;
+}
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
@@ -142,6 +552,8 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	xa_init_flags(&ff->classifiers, XA_FLAGS_ALLOC);
+	xa_init_flags(&ff->ethtool.rules, XA_FLAGS_ALLOC);
 	ff->vdev = vdev;
 	ff->ff_supported = true;
 
@@ -157,9 +569,18 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 
 void virtnet_ff_cleanup(struct virtnet_ff *ff)
 {
+	struct virtnet_ethtool_rule *eth_rule;
+	unsigned long i;
+
 	if (!ff->ff_supported)
 		return;
 
+	xa_for_each(&ff->ethtool.rules, i, eth_rule)
+		destroy_ethtool_rule(ff, eth_rule);
+
+	xa_destroy(&ff->ethtool.rules);
+	xa_destroy(&ff->classifiers);
+
 	virtio_device_object_destroy(ff->vdev,
 				     VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
 				     VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
diff --git a/drivers/net/virtio_net/virtio_net_ff.h b/drivers/net/virtio_net/virtio_net_ff.h
index 4aac0bd08b63..94b575fbd9ed 100644
--- a/drivers/net/virtio_net/virtio_net_ff.h
+++ b/drivers/net/virtio_net/virtio_net_ff.h
@@ -3,20 +3,34 @@
  * Header file for virtio_net flow filters
  */
 #include <linux/virtio_admin.h>
+#include <uapi/linux/ethtool.h>
 
 #ifndef _VIRTIO_NET_FF_H
 #define _VIRTIO_NET_FF_H
 
+struct virtnet_ethtool_ff {
+	struct xarray rules;
+	int    num_rules;
+};
+
 struct virtnet_ff {
 	struct virtio_device *vdev;
 	bool ff_supported;
 	struct virtio_net_ff_cap_data *ff_caps;
 	struct virtio_net_ff_cap_mask_data *ff_mask;
 	struct virtio_net_ff_actions *ff_actions;
+	struct xarray classifiers;
+	int num_classifiers;
+	struct virtnet_ethtool_ff ethtool;
 };
 
 void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev);
 
 void virtnet_ff_cleanup(struct virtnet_ff *ff);
 
+int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
+				struct ethtool_rx_flow_spec *fs,
+				u16 curr_queue_pairs);
+int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
+
 #endif /* _VIRTIO_NET_FF_H */
diff --git a/drivers/net/virtio_net/virtio_net_main.c b/drivers/net/virtio_net/virtio_net_main.c
index 1ede55da6190..14ee26fc9ef3 100644
--- a/drivers/net/virtio_net/virtio_net_main.c
+++ b/drivers/net/virtio_net/virtio_net_main.c
@@ -5629,6 +5629,21 @@ static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 	return rc;
 }
 
+static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	switch (info->cmd) {
+	case ETHTOOL_SRXCLSRLINS:
+		return virtnet_ethtool_flow_insert(&vi->ff, &info->fs,
+						   vi->curr_queue_pairs);
+	case ETHTOOL_SRXCLSRLDEL:
+		return virtnet_ethtool_flow_remove(&vi->ff, info->fs.location);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static const struct ethtool_ops virtnet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
 		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
@@ -5655,6 +5670,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rxnfc = virtnet_get_rxnfc,
+	.set_rxnfc = virtnet_set_rxnfc,
 };
 
 static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
index bc1bed486db9..4a10a162d99e 100644
--- a/include/uapi/linux/virtio_net_ff.h
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -13,6 +13,8 @@
 #define VIRTIO_NET_FF_ACTION_CAP 0x802
 
 #define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
+#define VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER 0x0201
+#define VIRTIO_NET_RESOURCE_OBJ_FF_RULE 0x0202
 
 struct virtio_net_ff_cap_data {
 	__le32 groups_limit;
@@ -59,4 +61,22 @@ struct virtio_net_resource_obj_ff_group {
 	__le16 group_priority;
 };
 
+struct virtio_net_resource_obj_ff_classifier {
+	__u8 count;
+	__u8 reserved[7];
+	struct virtio_net_ff_selector selectors[];
+};
+
+struct virtio_net_resource_obj_ff_rule {
+	__le32 group_id;
+	__le32 classifier_id;
+	__u8 rule_priority;
+	__u8 key_length; /* length of key in bytes */
+	__u8 action;
+	__u8 reserved;
+	__le16 vq_index;
+	__u8 reserved1[2];
+	__u8 keys[];
+};
+
 #endif
-- 
2.50.1


