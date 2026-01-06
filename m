Return-Path: <netdev+bounces-247403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58814CF97F6
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 18:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F21463007FF7
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAF533859C;
	Tue,  6 Jan 2026 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dkb0QHRH"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF42326D5D
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718326; cv=fail; b=rUXrTuW9prdiDI3dW/0v4Zw32ReBMT6sgIAh1a7RKjIlwRqRc1M8yt8U1Bj0IXt6VsIS1QeFT8WnjRkhkuJ1dHX41qXygicBgfNx2Eok+XjQxO/bDmefhaSIyEhzbY7TOtXd/UhflJgOGLKi7hNRoW+f44sJB/p/w3lHUiC7rz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718326; c=relaxed/simple;
	bh=b/U+HiGLgQIJ3nw/2/o0A0iHk5WhrmKXhq253pqRyV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLxVgqQNkaoytv4gXGLmRicT4CMxF5dRGVGKwa5HsLm5vTA+rqpo2yeUEsjzpj4aGmzsWWCVaK69ROVU+FHWvqc+r7Y924mxM1yW1Kw+AeK365Zb0fvAP8Ur6+h91WynsR8bW7ivlY4H/kt0kfFtp7RLsT2rSMZ09TOjbco8gvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dkb0QHRH; arc=fail smtp.client-ip=52.101.85.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEFAIVDBQR/YYH80N1qBilwMaINEhvGbM3MGjPF97ZkVr0wVdkkRFdQ4HejpHDTi+8XUeKOXePOTslukTGT7qHgRyFLSSG2WXDcIB/V67ZJdJIJm5GMSSy9/p3A9sCXLFyu9kiFyP1+142o+8HBdTSeb5k2eS6hund235RtPWEJPQJ2SHvs2CKC2tS86tI8fLTPcj/KmIGPCgZmzQppGxQpcYHgUp2of8wEEVs/Idu8W1OMFugWI1GTAnOBDg5yhrJem2SqSkJ1k5k4aLQbaLD5SEwKJuCrhmqTofLkHI2vLoGn+PVOftfHAF1W7CpwpopBWl3DAV+yTouXrIm5pJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unL35k2ncuD1K/GI352QNigkzbG7gsR0fhYdXmlIXxQ=;
 b=N+JtmWRnI1VhEm8El8F1cLEctHuJZblUPaOWkQY0U6Rt7fDdg1iDvP6VcE+/jQWP/p2GDAdO6HwcyeGgjsfvk0OgbSUT35Tcd77nNCC+caSVdr+sQR2fmW1pfcSMbMzjHr0W/Ttwipjkp/UYvk+GQDB33Rxt0/dGmcJh8exfcTkN3G5TQ/D5sKLA7qTzfb/ovDYKUhu+ZAFnRRNZQ5l2/03qKlLpi9MdUlZ5vHj2qfhvhrklKMq4Mmf6E0vbQZpjUe1TmOeUbCMwZFnV5M6NKg1M1znj7IGaBrshZTcuwCrwCDu9oxywNb7l0ow5JPKFFwHS+Bk8a2bUI8TPtpsA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unL35k2ncuD1K/GI352QNigkzbG7gsR0fhYdXmlIXxQ=;
 b=dkb0QHRH8yLMDgmUz7LDhbyGL5dM9wmjzthTd87w7nfhH4kMQ9968lx2LfrFjzWy2toIsVTlNtZ+AJl6UmVdzqK05MGC/h47FOxpzRDST0lNwG7RigBarAQO3WMr1D46nP3Rw8sIQQ0CJC2j7wvmTuv3pu8GbZXm2zfY8olW5c2TB8B0fxbj4gZDlxU2wlNabntBC2cE12STgNm74OZu0IGy3c2vXaWJaIXQE5nsKtsiM0/5bxwjHgZYM8Ky3ANO80/ZeslF2cgqAsPXj2usdaS3SK9doRmBBGXhpxUnmMiM/fiLHoS7TnyAW09kgFmSpYlyieS7E5hUzUkIAJlUGA==
Received: from CH2PR18CA0050.namprd18.prod.outlook.com (2603:10b6:610:55::30)
 by IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 16:51:59 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:55:cafe::21) by CH2PR18CA0050.outlook.office365.com
 (2603:10b6:610:55::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 16:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Tue, 6 Jan 2026 16:51:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:41 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:40 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 6 Jan
 2026 08:51:39 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v14 09/12] virtio_net: Implement IPv4 ethtool flow rules
Date: Tue, 6 Jan 2026 10:50:27 -0600
Message-ID: <20260106165030.45726-10-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|IA1PR12MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: c7944cb4-eb27-49de-f6e3-08de4d43e8cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+5JvsxuvEPGdh92rUIYSFwqOC3Ov+LnS1l7SHgn8Q2oHlEPOyoVHeJf/cKpZ?=
 =?us-ascii?Q?U2PWnQJHN6Ny4OXmF2mzOWLp1gP+DhtqXSHvXXskjMH92PlqbF4JYevAT/jM?=
 =?us-ascii?Q?mw/pK8OmKrpMyJV+om2wr34H1qHL6pnuEVbJRb0m2K8AQJ7uk6hSQHo3RkwA?=
 =?us-ascii?Q?eqw01AK300rZNSU7zIXL2WjKRKZOOKvqnmUjGlkvGncSk0ZyzdoAjot+/uPg?=
 =?us-ascii?Q?7YBdBOaA+41HzCLNK81VQmphAS2/KH6jmQBKXnE/cbfVwD/ngMDrzsbHFshB?=
 =?us-ascii?Q?l4m29OtUKjTMLibUVXTY9ADPrOkcqMyIYrziThdgGsfLeV6AXgGO1DABQNK3?=
 =?us-ascii?Q?33+lAtWVgSUelqFqqxL8K2s3GJzAJOtJTRPHBHFsC7t8LgjhnOR6ecyzxzhg?=
 =?us-ascii?Q?1YTbM/EsAOrCS8veVr/EwLL/SsJRFccqVJII8QWZgobQAgXUB+GrXKesYG6M?=
 =?us-ascii?Q?uybz+V5CxAB040n+gb3O9lv4tGkY0D0b/L5l1e1FoTU7sdpEdvbuu13JaoPX?=
 =?us-ascii?Q?OqW0lPyacCNan6rYOFprFEXajhLfkEfBIUThPAaAUJG9XHvSLZelyffAbnUk?=
 =?us-ascii?Q?eCarcHzKzkewpMVknrlTYUiWe4qrbCxKjb1y6l6cryZiHf12bueieN2o3njy?=
 =?us-ascii?Q?W7WR2xaWTtmbvk0e57XndcYdPAbW8lTZemwiPlubyaJxiM4vM6dGWBGM/102?=
 =?us-ascii?Q?4FBHN1qhwxKLhFEN/2rjhWAQi03d9xMuYdNRY8+T8hzKYKBnWfaQd7opboVM?=
 =?us-ascii?Q?80dcNlvnUggddhrFvWqDy/aKfPnKfNmUS1Ghg8a5M+HkjHaqIFNdZJv9i6ZB?=
 =?us-ascii?Q?NB2/Mr3ljt40sr2OUC9zsiB0Yo928e181EtjJwDIs+8fEqG0PPU0f9dBvGMO?=
 =?us-ascii?Q?iJmgQ+Vv3/IttSqZTR0wcsXp6pom+xc6rbRHlyWhdkdT+5LZmtfDomoyL1bo?=
 =?us-ascii?Q?z3T4YcBBIyZbY7pyTvcDFH1yCJhuderxTVbyzyVHYHQxdhzyel9OuG2aRE97?=
 =?us-ascii?Q?y75KZHqbQX7ngA6cduryt7YRLWCYJ7TVGMhOncfWc192wdA6LZ+4qm4HpRkN?=
 =?us-ascii?Q?SNMF0xmaEMn3uU0ItTTB1uIrNcDn75wtFD/UtaYpyG67gEmH1AuRVk4X/h3G?=
 =?us-ascii?Q?wxdow0aCxsx5BWDpGYDFoy/RF4qoCb8NNoYPZ6scxESkyllcutPQdx6h7s/J?=
 =?us-ascii?Q?2GFP4LDzn0m9P4ZmR6TbJZShujxLqfDFQvop7CrGYeM4KdnK12scxj09NUnO?=
 =?us-ascii?Q?POd84n25dL6dt4jDXpdnOdBnxjD4goDcBL8GrA0P+Z2baNyqyuSL0opSxH1e?=
 =?us-ascii?Q?+ICRfUep1w0QAKqxAS5hFMEtcHLrrVa+SUtcktsxqVLE6q0Z/Y7jbd7SZFMo?=
 =?us-ascii?Q?bNcT/Lh471vj4sa2ywnRKd5Vw8P2mE1gkkJRRSKZAj0y5/vmXqm8En3YoH5h?=
 =?us-ascii?Q?LOXOFWvzrd1H3POXxLTliJzlYLnI7XS9hBFwgGeQ6Zwf+UGhWpqPIUFHUQJ5?=
 =?us-ascii?Q?lOadHwQDUJfn1z8xeMRASaqnRCEKHEr+sKiKF3YFhjYaNsgzz7w2ni5iUrUx?=
 =?us-ascii?Q?s0eGRP5YdsudcULL4Zo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 16:51:59.5628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7944cb4-eb27-49de-f6e3-08de4d43e8cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190

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
index 8bb90de377d2..f9525b59150b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5903,6 +5903,39 @@ static bool validate_eth_mask(const struct virtnet_ff *ff,
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
@@ -5914,11 +5947,41 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
@@ -6054,6 +6117,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 {
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
+	case IP_USER_FLOW:
 		return true;
 	}
 
@@ -6085,8 +6149,18 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -6098,8 +6172,9 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
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
@@ -6107,8 +6182,35 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
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
@@ -6130,6 +6232,13 @@ validate_classifier_selectors(struct virtnet_ff *ff,
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
@@ -6167,7 +6276,15 @@ static int build_and_insert(struct virtnet_ff *ff,
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


