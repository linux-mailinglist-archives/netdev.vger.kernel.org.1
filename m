Return-Path: <netdev+bounces-144574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4050A9C7CFB
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE2EB23354
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A8020401E;
	Wed, 13 Nov 2024 20:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sWEJpZBK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8562071F2
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530053; cv=fail; b=MMnSYW1PiteYoeYuzcStakfKJPFgdbonDZ7GKku7+bjCVqHnV4ARHIFCtEzPsfV+3PzKV5gialj9xynaVLw0P43809+oIdoBvhFOHLCUpkfbdG6eFqlP62pkg6pkOlnZEpCcrqHRB7DT6iBe+i1LTkvjfb9rVyfaNAZVzPNJOmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530053; c=relaxed/simple;
	bh=NMq4drQ4kgUcIPMlIvlgp+3Wz4FXoCM7/pgrfR7FBMw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gy8HezpatndAzMBKzcMSB4Rkvv61nrLvj4OD1GTimnMY2/8SEJNcGv7+mrwFPC4509Sb5iLTF6dFT+WxnMEelzCASaEoNIytoJ3xFxcO0qrsqebE0vLMNEEuJslFNzn5uNO5bgxPWYijBiJZMHq1TnW0fXpAHWqzFlx7+D1mz7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sWEJpZBK; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxLvTopPc9sF/vkiJ8DIlWlwvs59IWWgBu9g3DSDc3iKa6t4aIQN34k1OQ5StSeqnaEH/qN+L25VMqrySTTo75TzFCc0Dsd2KoEzSeMdV+cz2riSW1weVeBV9Y2IK93C3/OgVohK6JaHOLaMsw1v+UpQ18mCx90YTz+Ni0yDNEkFx+8VF6nZAssWumYIzMq8amEnTP6J9pg7VMC08371aYB282o7SJsuJ2W+pNna5dF1uwmbI6g/N3OH8Ot6kK82NgumXZI4JDP9oUDoNHgm6BGSULEp1D5JFJV/JikzVqcFG92aJmmjpj3UQOXz2WKvbznTjxfwFd8did7HzC9Qxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbDWxGxLHF44rMtHEgBJ756Vs9Sk0g+dgIEzV4ObtEc=;
 b=kLknJaC7zCcb5a19qbOFRtceasARSmwPEp6bNOfbpLQZjVjq9R62Zu6wfsC1dG1LBSKx8Hv8bh9qh2BBmC//TX49jnprR9/9KAx4nufNPNxPYKsaI4EE0IuHo15EK9Hg/UJSDVvZ4m+NDgNDMoFJC5Fopnb+u2XFbPBa4TKfWiDnijqZzGLj6+NmBoCP0l7TbZ/EbYfdDrGp0po5FiOfttXYBN2NgcFMKtfDmcBuVIbAZiYtOQ8Tj8fa/XWD9HAym5N/OAYtaLkeVZdignXXlJ6gZEV6eJgKEJ2Vw4rsyiZn4OCcc7m37qxsHZJN7B1cqfkXQbhZrZgSpgu0UJAq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbDWxGxLHF44rMtHEgBJ756Vs9Sk0g+dgIEzV4ObtEc=;
 b=sWEJpZBK/GW3Unwdqh7vMmIcHTFvLFCPVxE/FNfiiX1O7mBkwkw7ZA0E7Q+XhNf7nEbJQJ4TSnYDH32F8H4p1XGi7ajcZ5OuOa8zlHzS9/7iw4fFLudIglD+vY7yZROYNHD/lw3j98cwmoBGSXqa6DibPOfS7LfbCIvOaCi1Ol5XhvuUSPMowXn/PVR4z168y/WbdUlXIBazOwN+YkbGiQ/m6lYCP0xYYaoMqWHgnbMsIU1LzPWC7L125mgx2CRRK08Knx1qjTAZ00UAFF3D/DxrQJMBwItRqcuYN/d7LhjGBvve960dpS6CzosB/vaq7ntjLZ3CNDiP40zoxF41+w==
Received: from DS7PR03CA0279.namprd03.prod.outlook.com (2603:10b6:5:3ad::14)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Wed, 13 Nov
 2024 20:34:09 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::6a) by DS7PR03CA0279.outlook.office365.com
 (2603:10b6:5:3ad::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Wed, 13 Nov 2024 20:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 20:34:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:33:53 -0800
Received: from nexus.mtl.labs.mlnx (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:33:51 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@resnulli.us>, <tariqt@nvidia.com>, <kuba@kernel.org>,
	<saeedm@nvidia.com>, <cratiu@nvidia.com>
Subject: [PATCH 06/10] devlink: Allow specifying parent device for rate commands
Date: Wed, 13 Nov 2024 22:30:43 +0200
Message-ID: <20241113203317.2507537-7-cratiu@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241113203317.2507537-1-cratiu@nvidia.com>
References: <20241113203317.2507537-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: 128b43fe-121b-4269-cfb4-08dd042286b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ix7Y6lo85SP6o8XpT66ILQSVKbBVlug1QCoaZVeNgMJwREWY/yt7NSWyKcyA?=
 =?us-ascii?Q?MYc9FSo36FD1H94xqeohNaUYePEv3q60/C67qbvYUiMYxPjZkTZsZGT/7WN+?=
 =?us-ascii?Q?PpeUMAt69bxMgKlvWxTjpEAfvlmRFtz5e+dZ1XLQvcyeX3CG92gAMzUZobro?=
 =?us-ascii?Q?DT38N83FQn8waBA8hMJCi5z2j+xehzOo47PgiSoq8XHz0chwlyYc2AsWRQYQ?=
 =?us-ascii?Q?2eGdCvyOxCFOo5h5kfScIErEpeKx1Rf67KWbTmWNlct6nn6cbPdHLJ+vHN26?=
 =?us-ascii?Q?6sc66jNucSph9MW81Kbl3Om6pr1NpwN9Zb1DZ8kAVaiCbb9DAUR7HcXDBo8D?=
 =?us-ascii?Q?s/LhiMckFxMmmhxZr4iR0d9HUH9HxIif5BLcihVc1X0z5YGpuNKO9AX5PkqL?=
 =?us-ascii?Q?cXt2yDSqNF/yuOmaHXaCN2/Rscqagv79x4oi3nmoPyGgYlb52m9jRz4kng+Z?=
 =?us-ascii?Q?HZ/ulrzpOi8IqhEmWhsEgd7XC17LaUmH+JSza2BKf3VrhfxFvPDB72AjCsJQ?=
 =?us-ascii?Q?WWfMPs5ufcR/Swqxq28vDEwQ1DtLzxJ+EBqtrSpWQAp/R9ZIrDyT1mND2VoM?=
 =?us-ascii?Q?F2TvDMA5EJBpExswF80YK47Qjp2jW43QzaGvrdCC/wEfT9H7OogTZtR5+IR5?=
 =?us-ascii?Q?27QcE+DuJbrGtspz6IcjUrZkqZ+eaCqYUBy9NqYkPuzu7BHEUmT9R6t+Qfhn?=
 =?us-ascii?Q?spMcY1Iqckm460caG4hF5W7/kOsfhJmeRyqn+vYSwj5nkPOInUINjzcQ0k/k?=
 =?us-ascii?Q?qZ1sTkurMAdIkqQdX94vfU76GKfjVaBpT9w77WfXTe92ru5D97+r2OwolN5B?=
 =?us-ascii?Q?9ASr7vzOrxIUB9sT/GWWiWLXR/uV9K4yZxxOet/zU6OBDOnGZlViMuj54ecG?=
 =?us-ascii?Q?DwgZmiwXbwkwNapGodbvKQylS2iAR3V1bn3GQmsX6PD3bdXJTqBXi+6q8vpH?=
 =?us-ascii?Q?10elyvN/NSP2ZBgFVzmhJsV0DMA48xKBzqe5YyUcm2rKfiLgi2z8/oTeGHA5?=
 =?us-ascii?Q?yyBioiy00x21YboLTVSgUZEsgqwieZmJg3Pr+fSRltKgHaSUFcOc8jXnSlL8?=
 =?us-ascii?Q?JgR0CJvwDRFFZ9hAsryYKkqf3YDEFENm1EaWhWWXzPWimLIogVJaEdI/fX/B?=
 =?us-ascii?Q?59jenzjFsuhBzVkCUfUZ5Q4H2dje6hZw0wN+sKBSfRI3tW4IwJ2QQWfpDlRs?=
 =?us-ascii?Q?U5kQ6/1Zu5O6YxHg4wUUoy3HLCX5XAJdic/JB1cMHj8cif4KmSXPrGpZRveG?=
 =?us-ascii?Q?SHbMePH6p888S9+dZupbA/usfOby9Mtts4UKClO02icn1d4KWr7hNr+HbJjp?=
 =?us-ascii?Q?/TK1n63cQUzICjEWYK17QaDJzw/GcLPbkkFF/QKWVuACaT45/rpbyac8zJ99?=
 =?us-ascii?Q?EQBe5KKdGGtmZGJqBX52wdf3OCsNxV0hXkfvSXiDpu2lkst5/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 20:34:09.0336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 128b43fe-121b-4269-cfb4-08dd042286b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336

Previously, the parent device was assumed to be the same one as one
owning the rate node being manipulated.

This patch expands that by allowing rate commands to accept two
additional arguments, the parent bus name and the parent dev name.
Besides introducing these two attributes in the uapi, this patch:
- adds plumbing in the 'rate-new' and 'rate-set' commands to access
  these attributes.
- extends devlink-nl-pre-doit with getting and saving a reference to the
  parent dev in info->user_ptr[1].
  The parent dev needs to exist and be registered and is then unlocked
  but not put. This ensures that it will stay alive until the end of the
  request.
- changes devlink-nl-post-doit with putting the parent reference, if
  obtained.

Issue: 3645895
Change-Id: Ibbb7b632be2b2779d36f7de8320aeb58fcc20748
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 18 ++++--
 include/uapi/linux/devlink.h             |  3 +
 net/devlink/netlink.c                    | 73 +++++++++++++++++++-----
 net/devlink/netlink_gen.c                | 20 ++++---
 net/devlink/netlink_gen.h                |  6 ++
 5 files changed, 93 insertions(+), 27 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 41fdc2514f69..033c17da4fc0 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -849,6 +849,12 @@ attribute-sets:
         name: region-direct
         type: flag
 
+      - name: parent-dev-bus-name
+        type: string
+
+      - name: parent-dev-name
+        type: string
+
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -2185,8 +2191,8 @@ operations:
       dont-validate: [ strict ]
       flags: [ admin-perm ]
       do:
-        pre: devlink-nl-pre-doit
-        post: devlink-nl-post-doit
+        pre: devlink-nl-pre-doit-parent-dev-optional
+        post: devlink-nl-post-doit-parent-dev-optional
         request:
           attributes:
             - bus-name
@@ -2198,6 +2204,8 @@ operations:
             - rate-tx-weight
             - rate-tc-bw
             - rate-parent-node-name
+            - parent-dev-bus-name
+            - parent-dev-name
 
     -
       name: rate-new
@@ -2206,8 +2214,8 @@ operations:
       dont-validate: [ strict ]
       flags: [ admin-perm ]
       do:
-        pre: devlink-nl-pre-doit
-        post: devlink-nl-post-doit
+        pre: devlink-nl-pre-doit-parent-dev-optional
+        post: devlink-nl-post-doit-parent-dev-optional
         request:
           attributes:
             - bus-name
@@ -2219,6 +2227,8 @@ operations:
             - rate-tx-weight
             - rate-tc-bw
             - rate-parent-node-name
+            - parent-dev-bus-name
+            - parent-dev-name
 
     -
       name: rate-del
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index c369726a262a..8dc710b9ab8e 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -624,6 +624,9 @@ enum devlink_attr {
 	DEVLINK_ATTR_RATE_TC_7_BW,		/* u32 */
 	DEVLINK_ATTR_RATE_TC_BW,		/* nested */
 
+	DEVLINK_ATTR_PARENT_DEV_BUS_NAME,	/* string */
+	DEVLINK_ATTR_PARENT_DEV_NAME,		/* string */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 593605c1b1ef..1d31d8a76465 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -12,6 +12,7 @@
 #define DEVLINK_NL_FLAG_NEED_PORT		BIT(0)
 #define DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT	BIT(1)
 #define DEVLINK_NL_FLAG_NEED_DEV_LOCK		BIT(2)
+#define DEVLINK_NL_FLAG_NEED_PARENT_DEV		BIT(3)
 
 static const struct genl_multicast_group devlink_nl_mcgrps[] = {
 	[DEVLINK_MCGRP_CONFIG] = { .name = DEVLINK_GENL_MCGRP_CONFIG_NAME },
@@ -177,20 +178,15 @@ int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_info *info)
 	return 0;
 }
 
-struct devlink *
-devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
-			    bool dev_lock)
+static struct devlink *
+devlink_get_lock(struct net *net, struct nlattr *bus_attr, struct nlattr *dev_attr, bool dev_lock)
 {
+	char *busname, *devname;
 	struct devlink *devlink;
 	unsigned long index;
-	char *busname;
-	char *devname;
-
-	if (!attrs[DEVLINK_ATTR_BUS_NAME] || !attrs[DEVLINK_ATTR_DEV_NAME])
-		return ERR_PTR(-EINVAL);
 
-	busname = nla_data(attrs[DEVLINK_ATTR_BUS_NAME]);
-	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
+	busname = nla_data(bus_attr);
+	devname = nla_data(dev_attr);
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
 		if (strcmp(devlink->dev->bus->name, busname) == 0 &&
@@ -206,19 +202,45 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	return ERR_PTR(-ENODEV);
 }
 
+struct devlink *
+devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs, bool dev_lock)
+{
+	if (!attrs[DEVLINK_ATTR_BUS_NAME] || !attrs[DEVLINK_ATTR_DEV_NAME])
+		return ERR_PTR(-EINVAL);
+
+	return devlink_get_lock(net, attrs[DEVLINK_ATTR_BUS_NAME],
+				attrs[DEVLINK_ATTR_DEV_NAME], dev_lock);
+}
+
 static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
 				 u8 flags)
 {
+	bool parent_dev = flags & DEVLINK_NL_FLAG_NEED_PARENT_DEV;
 	bool dev_lock = flags & DEVLINK_NL_FLAG_NEED_DEV_LOCK;
+	struct devlink *devlink, *parent_devlink = NULL;
+	struct nlattr **attrs = info->attrs;
 	struct devlink_port *devlink_port;
-	struct devlink *devlink;
 	int err;
 
-	devlink = devlink_get_from_attrs_lock(genl_info_net(info), info->attrs,
-					      dev_lock);
-	if (IS_ERR(devlink))
-		return PTR_ERR(devlink);
+	if (parent_dev && attrs[DEVLINK_ATTR_PARENT_DEV_BUS_NAME] &&
+	    attrs[DEVLINK_ATTR_PARENT_DEV_NAME]) {
+		parent_devlink = devlink_get_lock(genl_info_net(info),
+						  attrs[DEVLINK_ATTR_PARENT_DEV_BUS_NAME],
+						  attrs[DEVLINK_ATTR_PARENT_DEV_NAME], dev_lock);
+		if (IS_ERR(parent_devlink))
+			return PTR_ERR(parent_devlink);
+		info->user_ptr[1] = parent_devlink;
+		/* Drop the parent devlink lock, but don't put it just yet.
+		 * This will keep it alive until the end of the request.
+		 */
+		devl_dev_unlock(parent_devlink, dev_lock);
+	}
 
+	devlink = devlink_get_from_attrs_lock(genl_info_net(info), attrs, dev_lock);
+	if (IS_ERR(devlink)) {
+		err = PTR_ERR(devlink);
+		goto parent_put;
+	}
 	info->user_ptr[0] = devlink;
 	if (flags & DEVLINK_NL_FLAG_NEED_PORT) {
 		devlink_port = devlink_port_get_from_info(devlink, info);
@@ -237,6 +259,9 @@ static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
 unlock:
 	devl_dev_unlock(devlink, dev_lock);
 	devlink_put(devlink);
+parent_put:
+	if (parent_dev && parent_devlink)
+		devlink_put(parent_devlink);
 	return err;
 }
 
@@ -265,6 +290,13 @@ int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
 	return __devlink_nl_pre_doit(skb, info, DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT);
 }
 
+int devlink_nl_pre_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					    struct sk_buff *skb,
+					    struct genl_info *info)
+{
+	return __devlink_nl_pre_doit(skb, info, DEVLINK_NL_FLAG_NEED_PARENT_DEV);
+}
+
 static void __devlink_nl_post_doit(struct sk_buff *skb, struct genl_info *info,
 				   u8 flags)
 {
@@ -274,6 +306,10 @@ static void __devlink_nl_post_doit(struct sk_buff *skb, struct genl_info *info,
 	devlink = info->user_ptr[0];
 	devl_dev_unlock(devlink, dev_lock);
 	devlink_put(devlink);
+	if ((flags & DEVLINK_NL_FLAG_NEED_PARENT_DEV) && info->user_ptr[1]) {
+		devlink = info->user_ptr[1];
+		devlink_put(devlink);
+	}
 }
 
 void devlink_nl_post_doit(const struct genl_split_ops *ops,
@@ -289,6 +325,13 @@ devlink_nl_post_doit_dev_lock(const struct genl_split_ops *ops,
 	__devlink_nl_post_doit(skb, info, DEVLINK_NL_FLAG_NEED_DEV_LOCK);
 }
 
+void
+devlink_nl_post_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					 struct sk_buff *skb, struct genl_info *info)
+{
+	__devlink_nl_post_doit(skb, info, DEVLINK_NL_FLAG_NEED_PARENT_DEV);
+}
+
 static int devlink_nl_inst_single_dumpit(struct sk_buff *msg,
 					 struct netlink_callback *cb, int flags,
 					 devlink_nl_dump_one_func_t *dump_one,
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 546766bdd836..6e669e57d44d 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -507,7 +507,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_PARENT_DEV_NAME + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -517,10 +517,12 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_B
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TC_BW] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bw_nl_policy),
+	[DEVLINK_ATTR_PARENT_DEV_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_PARENT_DEV_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_RATE_NEW - do */
-static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1] = {
+static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_PARENT_DEV_NAME + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -530,6 +532,8 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_B
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TC_BW] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bw_nl_policy),
+	[DEVLINK_ATTR_PARENT_DEV_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_PARENT_DEV_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_RATE_DEL - do */
@@ -1173,21 +1177,21 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 	{
 		.cmd		= DEVLINK_CMD_RATE_SET,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.pre_doit	= devlink_nl_pre_doit,
+		.pre_doit	= devlink_nl_pre_doit_parent_dev_optional,
 		.doit		= devlink_nl_rate_set_doit,
-		.post_doit	= devlink_nl_post_doit,
+		.post_doit	= devlink_nl_post_doit_parent_dev_optional,
 		.policy		= devlink_rate_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TC_BW,
+		.maxattr	= DEVLINK_ATTR_PARENT_DEV_NAME,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_RATE_NEW,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.pre_doit	= devlink_nl_pre_doit,
+		.pre_doit	= devlink_nl_pre_doit_parent_dev_optional,
 		.doit		= devlink_nl_rate_new_doit,
-		.post_doit	= devlink_nl_post_doit,
+		.post_doit	= devlink_nl_post_doit_parent_dev_optional,
 		.policy		= devlink_rate_new_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TC_BW,
+		.maxattr	= DEVLINK_ATTR_PARENT_DEV_NAME,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 084ad5026d4f..9d41bbaed05b 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -28,10 +28,16 @@ int devlink_nl_pre_doit_dev_lock(const struct genl_split_ops *ops,
 int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
 				      struct sk_buff *skb,
 				      struct genl_info *info);
+int devlink_nl_pre_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					    struct sk_buff *skb,
+					    struct genl_info *info);
 void
 devlink_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		     struct genl_info *info);
 void
+devlink_nl_post_doit_parent_dev_optional(const struct genl_split_ops *ops, struct sk_buff *skb,
+					 struct genl_info *info);
+void
 devlink_nl_post_doit_dev_lock(const struct genl_split_ops *ops,
 			      struct sk_buff *skb, struct genl_info *info);
 
-- 
2.43.2


