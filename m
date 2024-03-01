Return-Path: <netdev+bounces-76380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D120086D88B
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D22283F4B
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 01:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78212AF0D;
	Fri,  1 Mar 2024 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M9Ag9Pyl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5013232
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709255510; cv=fail; b=Xyx4147e3GMswFmBTeiq9cMDevtT10xIOCqCcnXNN7UeQZG0ydn0wGx3Jktcgb5VaR4k0qU4uHpmcmZFlo89VtRqTWFZROzk+K66qhn8rVb0OSxsl87joZYDz2ztMGpwerDFsx0dVweeTLLofZmWfFj1dZQEcZBLTtofGXi0U4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709255510; c=relaxed/simple;
	bh=lTMx/AKhhDT3TDDWiWnfvCr9pbaRHQn7gPxT8GgfRQc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RpcYVXDWC8GX5j+OP/ryPbubNcDDNDgZy6zfduEYedYyLQpxmq63KiKVAX0BbKENvstP9O6GBcZ/GOJx7VPsk1vwLpU+8E1ET+VO0jy/Xv92eSJmRRQvR7dq0lpKxyXfLy1hOmz66Y847mMZjGDZU5k1BZEdx3sIF0Pmyz+mxNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M9Ag9Pyl; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9H5ML33Gs+F3e3ShybD5WmzFjkzE1vULb3rTLI6el0ss/p+F3NShOhgHqfHbOwGiEmLVCSkyva+dbsZ7cvuRBYGXLq1/aDcWLcN4ieN0fp2UmRORparZKwEOZt5Gon66p5WXQoLCiOtHR3dzqrtYGEluSlnV6LEcpIh/x61PuA/HBIQ/ss8uUzZWBQczgbUSpPoVjF4Ct7Uwtxnv3uyoOBmyiicxYGOS7XbgLW37L0J1IpSlU9ndU53FcF4zF8QSe3uvMotbp+QX5WWhpYGVWud1iSlWkDEn5xYjns5LGbSboyKRJakxqsJZwwsOUSteuU+SisG9VBvtcgS/g79GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2I+Wtdu56ZB75Lmx5deDNPWRTtXmPs9/B6btuiE1rw=;
 b=R+bpr6zGrlBqmgdvgg2ZOvioPIbU6M36LYK0iTbnhO6Z2jd/7/C61x2R1kNX7fEb1yurG3atBTeBxHIuJjaKT/zAMESCPRALBDs8RsocYUhSmlY4j9I+AEW3xUA/PsPAXiaelMEv2a0j0lwfDHI1UGGTyNFjiiLmNZFQK7EFYIsHmkZnAApxfWPyM+aztQtbFrsPNQ83jr1tOaIDi8GVUjwWcWuurz01gYHjfWT9LUV3LwMcHg9ICTLteI6OcvTOVmrfYyq2q+vieF184pchIho+9V7PfpMI95cZhaAXwnIUSuDSczXuqZR52fhSQpIDj5xCax34/uAdXBAaPgdpyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2I+Wtdu56ZB75Lmx5deDNPWRTtXmPs9/B6btuiE1rw=;
 b=M9Ag9PylLD4yXkcmOQakbItL7pA3Q/dv+Te5QTzIqGJDNrGApFL0ITkVsgjEMNqglRG42wOEKgYLPpbnoMOfzf/g7B3/ki96urJ6Q5HpdNvDPPwdN4RI4jGZSS4lG1KP8AGBiLhh21Z5h9qnEU7WnT8RDTa7/uiClaoOe4mMBl92CobyTHkvUH6/yhZ6bn2Vfi81bQNIfV0NEstSLq6J+psUwAhkbWQu1XmufGHjbf4cnoumXkjOjf6vQ4BDBH/0x6EfotcELtXjkVzJDnyUbO8yJ0VPqru+PaevFAJrQXJnaHsEV14b4qOyEkGbCyjP3p9/VITZ+slccLnJKBA/Tw==
Received: from BL1P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::23)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 01:11:45 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2c4:cafe::64) by BL1P223CA0018.outlook.office365.com
 (2603:10b6:208:2c4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Fri, 1 Mar 2024 01:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 1 Mar 2024 01:11:45 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 29 Feb
 2024 17:11:28 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 29 Feb
 2024 17:11:27 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Thu, 29
 Feb 2024 17:11:25 -0800
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@nvidia.com>, <bodong@nvidia.com>, <tariqt@nvidia.com>,
	<yossiku@nvidia.com>, <kuba@kernel.org>, <witu@nvidia.com>
Subject: [PATCH RFC v2 net-next 1/2] devlink: Add shared descriptor eswitch attr
Date: Fri, 1 Mar 2024 03:11:18 +0200
Message-ID: <20240301011119.3267-1-witu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f1cee7-5bc8-4e0c-4b05-08dc398c9008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0KOwwzaS7qshNOE5u4b4mTMbQuRqk16GrK6XLnjy3In6Sn/dja39VJn7HuSuVLJ37wZqALAUEmx9isjYnDlIxoQwHnJdLvKHKzYg8FYdn5/ol0kYKwCuhdl2mae6Km6eJJV42t9/tvhye97pccX8vUlI2LLBUWXdWBSE8gMO5oKYGICWBS/1lUNoCc39bjJXuSGu3y8BZqrxWqWxEgwEwmDjR7xbVg9b6t3Z5D2Q3sPBjpIgQadcbp1KFVwx+ks4PvhCIAhk0pRKt6+WE16kv0l4q1kP7vbKY1fKrYrtM+mYVgbhqFcIfI1+Y5tZwZ9BbJjT+qpEy43/0ZzUhXU/4QegMpDIdwG2lx4mN7E41JtgE8HcLm4oAIAlXmC8HeQzUi96DMlQHqD5xtcHUovOVaKYpbXFeYB7Z7OofGKXx390XHguijqzdfiHkD5lNzqOpfHSXEBRsZ7hHjoD/rIAMMQRj8RnPVPUZ2m5Xxyi6WihaceLzFrdFgMROvl9WG9GrIY3FPIZqSd/gEeiXBRS8XJNKtz1osrEy3dBd/QNRQmJ9BLl1IKOxO7Xd2f49YLZtAUReDkpWsBwjGbbmaQDW8kAAYQBpqUmYo5rss+ejc2paZG0jMrMmg0808W14NByDLFQnJWtOrkew+wt/ThU8KoOtfj1xpQqQiBxgzTdRa1k3A1dp9EgH25kWtAmP9dRsFY/aI7u1Z4JON+KkCz+Z/XC1r8qZn0Qk5gC5UyrinHv9eE5kbXF9NIln6O1YNMG
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 01:11:45.2247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f1cee7-5bc8-4e0c-4b05-08dc398c9008
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049

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
v2: feedback from Simon and Jiri
- adding devlink.yaml, generate using ynl-regen.sh

---
 Documentation/netlink/specs/devlink.yaml | 17 ++++++++++
 include/net/devlink.h                    |  8 +++++
 include/uapi/linux/devlink.h             |  7 ++++
 net/devlink/dev.c                        | 43 ++++++++++++++++++++++++
 net/devlink/netlink_gen.c                |  6 ++--
 5 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index cf6eaa0da821..58f31d99b8b3 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -119,6 +119,14 @@ definitions:
         name: none
       -
         name: basic
+  -
+    type: enum
+    name: eswitch-shrdesc-mode
+    entries:
+      -
+        name: none
+      -
+        name: basic
   -
     type: enum
     name: dpipe-header-id
@@ -429,6 +437,13 @@ attribute-sets:
         name: eswitch-encap-mode
         type: u8
         enum: eswitch-encap-mode
+      -
+        name: eswitch-shrdesc-mode
+        type: u8
+        enum: eswitch-shrdesc-mode
+      -
+        name: eswitch-shrdesc-count
+        type: u32
       -
         name: resource-list
         type: nest
@@ -1555,6 +1570,8 @@ operations:
             - eswitch-mode
             - eswitch-inline-mode
             - eswitch-encap-mode
+            - eswitch-shrdesc-mode
+            - eswitch-shrdesc-count
 
     -
       name: eswitch-set
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
index c81cf2dd154f..9346505a03d5 100644
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
+	[DEVLINK_ATTR_ESWITCH_SHRDESC_COUNT] = { .type = NLA_U32, },
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


