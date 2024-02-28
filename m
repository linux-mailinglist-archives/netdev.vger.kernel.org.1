Return-Path: <netdev+bounces-75520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A3886A63F
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 03:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2021F2EB61
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 02:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2333C2D;
	Wed, 28 Feb 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tiqDzvqp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A33C23C2
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 02:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709085625; cv=fail; b=MIhtbMEWzIUTSwpFi7wrSBWmUyV2f3dHUkyBL6rI9q0ibND26IU1ROQacNUpNAZPy4+/ZxCK2V6OlsDRhXBZ/PtW7oci/1waL2hsoiUGU2S82tCKye3+ylwe6ZoaKvDib1vaRy1EZ64bd+VipD8xgCycIdOMfTRnvbxcn1ryIlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709085625; c=relaxed/simple;
	bh=KRDwHbzqQc4i7YrgIvLJKbWAyaMTbJZcxURsnBi6Y9U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IxA9EayyzvpL0RCoqZ3o4YjW/TCSupjpWh3MKo7R3HiG0Kn4flugEUcxZzX3nC2Kh7TWJjWME+/s6T9Lt6SAP7IV6y8GwI3/oBaKEHUUqyAsT79fCu7LyFn3JQJyiK17cbe2FZcjFWR7vwa17w+EwjH0frhQuNJ008aNzIdFmMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tiqDzvqp; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9qtvcD+fbiP/tMAgHvDpGzQaJv6r/BLXhyNcBNdHc4bP4COJh62sFWNsr+KGXUlZqxz+8dgmX/pW8SXDQYx5g+R8qBLlGL22bFpE9Y3d+nm+JSpwBhhbLNhYbu+Uz+d7kGjbDyk5ay6P6xNahEy1wHuWuveegkO6oAO3DiLwfLksCnUDwJMkyJ52Y2gtGvWiDHqmGhTBzL3nQ1YHXeo+X+ZyaydY7dYxNyeY5frnD2lo8IAX9BaCwN9tNuo3doUGQ8U8hwiOF7rnn9d6hDSeRyaDyC389guZREsEfJTumxJQ8wIYfudIAvti6reqshJgiGfsLGXB0Tbc0DDirwObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxpWRnAcFJ4rycCvdcnBReBlbfCMn/VE5VsRXTSTGeo=;
 b=L6Sh81GyUVqQWP155RDszh5Iwap7UsemM+T747Gh7J8pCTnlLnu/ooSn3rFOcYOwevsk60Mni5YxsbZmG8aitram8403APg84E6mMZHUjQlgcRa99PPblnvBjdTU2SK0RqTU3bLClTB9bN2I3SyIM7/EVJc27QFIOg2Drt9qN4ty4/WbbMjXeaPE9werBqfS/NM2jV3UlaaVxhrnwceXZYLcPdL16nPrkUyAel7gGNx79nIpOaZZjLLlltYz++aa+rurH7AKc8kCbUEcLyiCLCMI6+s0rm07ceXoReBmTdWwj6IWM2fNhLGrJ8cbHs7gzq9HPLn6v0axw7VtIHA8JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxpWRnAcFJ4rycCvdcnBReBlbfCMn/VE5VsRXTSTGeo=;
 b=tiqDzvqpHnLnuUkwtPlkJG/HIcmSgON9B6ne6l+wmxCwoQozI0viiu0EaAVT7JGyTq6zlvbjnOYNlFTFx/qUFy9fE4i96+W51OMHIsvCHMvjlggIwsmT8zZih4cNxltZ9s8Bl4JAMKGCtJobTp+Zn/QmI7568aWHoyol4r5QTbG8jijg7K8QIGx2WtrJgtUEDcOjYRAx57Y+2B8d4+DUNwSOwrlbYi8OLVqjBbDbSkC1g/YVSqgytE+oyopXYZLVZF1joMuVGBRqQS7ZftXJeMibKH92O7Mn0dbwqZUTCBW/6tVDc14DSelzwW8hSY0P4PY49qEzFUpgtMfUojh5Qg==
Received: from BN9PR03CA0686.namprd03.prod.outlook.com (2603:10b6:408:10e::31)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 02:00:17 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::33) by BN9PR03CA0686.outlook.office365.com
 (2603:10b6:408:10e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Wed, 28 Feb 2024 02:00:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 02:00:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 27 Feb
 2024 18:00:01 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 27 Feb
 2024 18:00:00 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 27
 Feb 2024 17:59:58 -0800
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@nvidia.com>, <bodong@nvidia.com>, <tariqt@nvidia.com>,
	<yossiku@nvidia.com>, <kuba@kernel.org>, <witu@nvidia.com>
Subject: [PATCH net-next RFC 1/2] devlink: Add shared descriptor eswitch attr
Date: Wed, 28 Feb 2024 03:59:53 +0200
Message-ID: <20240228015954.11981-1-witu@nvidia.com>
X-Mailer: git-send-email 2.38.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: b1348506-a2f0-4891-45ad-08dc380102b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3BuqOtB4XuEShVPtzagVP5F+ENTPiVoq9ikhPBGsgVfSGhWdaTM0HPeLHhBoVv9g81j2KgOpaOtaDyNGwbjaOJHgDjpSELbL/ec/U6Vc2ym0co3tiBUmBh7DETwNmMdnuS+GbB8iby0IlCGoeHXbVCURezuaDcU4sJ/95rJN7Ky6rHp9XvgAmWocheKmpn3r3tbvm5kjBuA13ch0ETL0xRBLld6wIB4KXXP+ZM6PNHhPGpOrtUfxpw6+kdNjvMNinraVOcsnFDRAn0MV5qLs1bmF1J4NzXoOsYX8i2kWUrml2olg+D/6G8IqHf3Zd4e0UVDPmv2Xe98z5eZLBs96GhIpFWelX/89S4hiSdiejLHaQQANB9g9oY6pZe3lhwqC1wC4HZahoNP6pvy64zItF6mojizKmvvmUMB1N/Sq1kOxqR8QJlztZ4BcqpQwPxGw2KRD39BW63DQUBYRFkeaTTszzju+yBxTSfi/TwM4DDsJJwkiXzx60Es6fz9gNigYxGKdeTMoxP3hHO1fwJ63mXaT8pAbOzkJhnbq/0yo5uQjhAFkx5iTGxxQIvMG8E7fXsVkbB5UwtlMsxVPiFJhWUUpXX7IWe3g7BYHDgg2/Yq9QjcH9sWYq4JleqeKYezIgstnGccA0MjONXULXtLxYknXEExkKKhdylTQxytRraBJzxBzrtHwNt/ABr9/sJdxdTH8OA9iEAOFK4SsX/YKBOjBuZGc3mMcQ24s/MSrnPe4Wkf8Tq3ICq6i2p7x4dfdGKnYjVpNH3F+6oi1dnKlGVJcoAaX5WMN6tmqw9BeBFw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 02:00:16.9428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1348506-a2f0-4891-45ad-08dc380102b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252

Add two eswitch attrs: shrdesc_mode and shrdesc_count.

1. shrdesc_mode: to enable a sharing memory buffer for
representor's rx buffer, and 2. shrdesc_count: to control the
number of buffers in this shared memory pool.

When using switchdev mode, the representor ports handles the slow path
traffic, the traffic that can't be offloaded will be redirected to the
representor port for processing. Memory consumption of the representor
port's rx buffer can grow to several GB when scaling to 1k VFs reps.
For example, in mlx5 driver, each RQ, with a typical 1K descriptors,
consumes 3MB of DMA memory for packet buffer in WQEs, and with four
channels, it consumes 4 * 3MB * 1024 = 12GB of memory. And since rep
ports are for slow path traffic, most of these rx DMA memory are idle.

Add shrdesc_mode configuration, allowing multiple representors
to share a rx memory buffer pool. When enabled, individual representor
doesn't need to allocate its dedicated rx buffer, but just pointing
its rq to the memory pool. This could make the memory being better
utilized. The shrdesc_count represents the number of rx ring
entries, e.g., same meaning as ethtool -g, that's shared across other
representors. Users adjust it based on how many reps, total system
memory, or performance expectation.

The two params are also useful for other vendors such as Intel ICE
drivers and Broadcom's driver, which also have representor ports for
slow path traffic.

An example use case:
$ devlink dev eswitch show pci/0000:08:00.0
  pci/0000:08:00.0: mode legacy inline-mode none encap-mode basic \
  shrdesc-mode none shrdesc-count 0
$ devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
  shrdesc-mode basic shrdesc-count 1024
$ devlink dev eswitch show pci/0000:08:00.0
  pci/0000:08:00.0: mode switchdev inline-mode none encap-mode basic \
  shrdesc-mode basic shrdesc-count 1024

Note that new configurations are set at legacy mode, and enabled at
switchdev mode.

Signed-off-by: William Tu <witu@nvidia.com>
---
previous devlink-sd discussion
https://lore.kernel.org/netdev/20240220141709.42a9c640@kernel.org/
---
 include/net/devlink.h        |  8 +++++++
 include/uapi/linux/devlink.h |  7 ++++++
 net/devlink/dev.c            | 43 ++++++++++++++++++++++++++++++++++++
 net/devlink/netlink_gen.c    |  6 +++--
 4 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 9ac394bdfbe4..aca25183e72a 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1327,6 +1327,14 @@ struct devlink_ops {
 	int (*eswitch_encap_mode_set)(struct devlink *devlink,
 				      enum devlink_eswitch_encap_mode encap_mode,
 				      struct netlink_ext_ack *extack);
+	int (*eswitch_shrdesc_mode_get)(struct devlink *devlink,
+				        enum devlink_eswitch_shrdesc_mode *p_shrdesc_mode);
+	int (*eswitch_shrdesc_mode_set)(struct devlink *devlink,
+				        enum devlink_eswitch_shrdesc_mode shrdesc_mode,
+				        struct netlink_ext_ack *extack);
+	int (*eswitch_shrdesc_count_get)(struct devlink *devlink, int *count);
+	int (*eswitch_shrdesc_count_set)(struct devlink *devlink, int count,
+				        struct netlink_ext_ack *extack);
 	int (*info_get)(struct devlink *devlink, struct devlink_info_req *req,
 			struct netlink_ext_ack *extack);
 	/**
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 130cae0d3e20..31323c481614 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -195,6 +195,11 @@ enum devlink_eswitch_encap_mode {
 	DEVLINK_ESWITCH_ENCAP_MODE_BASIC,
 };
 
+enum devlink_eswitch_shrdesc_mode {
+	DEVLINK_ESWITCH_SHRDESC_MODE_NONE,
+	DEVLINK_ESWITCH_SHRDESC_MODE_BASIC,
+};
+
 enum devlink_port_flavour {
 	DEVLINK_PORT_FLAVOUR_PHYSICAL, /* Any kind of a port physically
 					* facing the user.
@@ -614,6 +619,8 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
+	DEVLINK_ATTR_ESWITCH_SHRDESC_MODE,	/* u8 */
+	DEVLINK_ATTR_ESWITCH_SHRDESC_COUNT,	/* u32 */
 	/* add new attributes above here, update the policy in devlink.c */
 
 	__DEVLINK_ATTR_MAX,
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 19dbf540748a..90b279c3c1e6 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -631,8 +631,10 @@ static int devlink_nl_eswitch_fill(struct sk_buff *msg, struct devlink *devlink,
 				   enum devlink_command cmd, u32 portid,
 				   u32 seq, int flags)
 {
+	enum devlink_eswitch_shrdesc_mode shrdesc_mode;
 	const struct devlink_ops *ops = devlink->ops;
 	enum devlink_eswitch_encap_mode encap_mode;
+	u32 shrdesc_count;
 	u8 inline_mode;
 	void *hdr;
 	int err = 0;
@@ -674,6 +676,25 @@ static int devlink_nl_eswitch_fill(struct sk_buff *msg, struct devlink *devlink,
 			goto nla_put_failure;
 	}
 
+	if (ops->eswitch_shrdesc_mode_get) {
+		err = ops->eswitch_shrdesc_mode_get(devlink, &shrdesc_mode);
+		if (err)
+			goto nla_put_failure;
+		err = nla_put_u8(msg, DEVLINK_ATTR_ESWITCH_SHRDESC_MODE, shrdesc_mode);
+		if (err)
+			goto nla_put_failure;
+
+	}
+
+	if (ops->eswitch_shrdesc_count_get) {
+		err = ops->eswitch_shrdesc_count_get(devlink, &shrdesc_count);
+		if (err)
+			goto nla_put_failure;
+		err = nla_put_u32(msg, DEVLINK_ATTR_ESWITCH_SHRDESC_COUNT, shrdesc_count);
+		if (err)
+			goto nla_put_failure;
+	}
+
 	genlmsg_end(msg, hdr);
 	return 0;
 
@@ -705,9 +726,11 @@ int devlink_nl_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
+	enum devlink_eswitch_shrdesc_mode shrdesc_mode;
 	struct devlink *devlink = info->user_ptr[0];
 	const struct devlink_ops *ops = devlink->ops;
 	enum devlink_eswitch_encap_mode encap_mode;
+	u32 shrdesc_count;
 	u8 inline_mode;
 	int err = 0;
 	u16 mode;
@@ -744,6 +767,26 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 			return err;
 	}
 
+	if (info->attrs[DEVLINK_ATTR_ESWITCH_SHRDESC_MODE]) {
+		if (!ops->eswitch_shrdesc_mode_set)
+			return -EOPNOTSUPP;
+		shrdesc_mode = nla_get_u8(info->attrs[DEVLINK_ATTR_ESWITCH_SHRDESC_MODE]);
+		err = ops->eswitch_shrdesc_mode_set(devlink, shrdesc_mode,
+						    info->extack);
+		if (err)
+			return err;
+	}
+
+	if (info->attrs[DEVLINK_ATTR_ESWITCH_SHRDESC_COUNT]) {
+		if (!ops->eswitch_shrdesc_count_set)
+			return -EOPNOTSUPP;
+		shrdesc_count = nla_get_u32(info->attrs[DEVLINK_ATTR_ESWITCH_SHRDESC_COUNT]);
+		err = ops->eswitch_shrdesc_count_set(devlink, shrdesc_count,
+						     info->extack);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index c81cf2dd154f..ac8b0c7105dd 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -194,12 +194,14 @@ static const struct nla_policy devlink_eswitch_get_nl_policy[DEVLINK_ATTR_DEV_NA
 };
 
 /* DEVLINK_CMD_ESWITCH_SET - do */
-static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITCH_ENCAP_MODE + 1] = {
+static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITCH_SHRDESC_COUNT + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_ESWITCH_MODE] = NLA_POLICY_MAX(NLA_U16, 1),
 	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = NLA_POLICY_MAX(NLA_U16, 3),
 	[DEVLINK_ATTR_ESWITCH_ENCAP_MODE] = NLA_POLICY_MAX(NLA_U8, 1),
+	[DEVLINK_ATTR_ESWITCH_SHRDESC_MODE] = NLA_POLICY_MAX(NLA_U8, 1),
+	[DEVLINK_ATTR_ESWITCH_SHRDESC_COUNT] = NLA_POLICY_MAX(NLA_U32, 65535),
 };
 
 /* DEVLINK_CMD_DPIPE_TABLE_GET - do */
@@ -787,7 +789,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_eswitch_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_eswitch_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_ESWITCH_ENCAP_MODE,
+		.maxattr	= DEVLINK_ATTR_ESWITCH_SHRDESC_COUNT,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
-- 
2.38.1


