Return-Path: <netdev+bounces-78157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA460874396
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41DCAB21ED3
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578361B81F;
	Wed,  6 Mar 2024 23:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mQoAjaPf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CCE1C2A1
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766793; cv=fail; b=UKJF+TiLYfINKxYM/1aQE6w6I0pAeBJJni+4rhM+zoNAFd1XfQDJimzLE31BCJmL1Srxdh/O+rdvqQ/k6xxEy/oJ+yYswVmIKFMzzWKd1ARudauCYnQ77e4ydxS4ykvQ4zj98EwfZ8RE8pP0dHH+NHCho6rt6PuanljTyd7zJNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766793; c=relaxed/simple;
	bh=Kh2tQKXWAKz0T6kuEoHGu3xabbZRJpY2+8710PEFJ0U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gnCy2AbBlwWeo1EYTr9cgPtQo0e1eX/Njdhb4yopI3cs8BTyL1MZf6mY6UL+ZSqhWNH7HMNtd0LcmNVYAvjLmPb+UlPc2wiYn2KvpBLBv118xGl88yDNVL5X6YkJ+bLL7peocBs78a4hYmFQWwn/flMMVsQTUIPH3KlTeFaodxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mQoAjaPf; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AS+BibJII8Z5VvoDq7sbny+lxknpqubGSPsw4AlU/GRw0b+3xf5pak/cgBimCAy3mpFf4gNtcHP11J/06RXYgHqBlzKv0QW7iqRwAokiFdqfSyDG1X/x7fam1qjtp8XWoyewhXatQjPf7y2V4AlLK8MzLum2vNv8zZIYmx7KbJbKc6hxgnzA485X46KZyDUC3yy37nT81VnyIRPgElLKXsAFBOBWkna9f12YnLiYtp62bCbfwYGCGQQZ9v3VFxFCSTcS9dhd+2CYJbBNSYx6SP/UybXnHjkz6/UjwhCYmnzByI37IqUrC7TX+VBKK+4TGpVVq+q5BiWJ42DcF7W1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4n4I/eF9UvZiN7p81ZVolockSQPnexY7gWt2OiUm8zs=;
 b=IiTCfoYGVGRycLKIN1fCIDMFWVk3eghIH7Fr61jSUQ3FVOjsbGQpGjJntHfAmbBhSwCh9iAkv4cBUKJWeUOm/38NiE2gqCh4YdawhatAIVb/eIb6fjsfo6OXLQIWHQvuPThxfjIw2/06BK2MKbbighcQ+j9cCkG9ol0XtRpR9Y+pA4xbWGb4XdSfZFEcUXaf3pB2KJmsc3OhUqwuKI6556QmFPMsHL01ybq9KgS+Z47gmfaUDlHA31iNY8z1RudGLHi+JEyV513dW5fayuwOPwkHqNUjzQRDD/K5fGGRUI9upT1xvjQzOnaBe0x7ucCdiQa8KolN+t7PgNTEVVUIwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n4I/eF9UvZiN7p81ZVolockSQPnexY7gWt2OiUm8zs=;
 b=mQoAjaPflJaiTCFom8cR7YGWAy2MKPoasLbhxNNLxOR9FAtb3pNKDQBGY4V93IZh4h2pZ1+Ngl6n8KITtsYKPWB738MPeUyoSxKymhUiUlagqMtAxqi6/0pgPdwrpPx5wpd8NOlvodxw017BgRmKwulsDiGsfi7gr05skxEOVOVhLFlFApwp5Su2YYu3Mm0ZsY7ktOPSBX1G+JmXXLgjieuJl3LQqQCUohu7nz2kQfDRs/5bjcuQn0ouJpypylxoKiFopiDH5MVHL3oRCdSYdcd6OBuoSYa5AYE9vIYFi28MRCmsi8fMsgDIYtdh59s+t1hEJTuMSfRrLKtEeMBwEA==
Received: from CY5P221CA0075.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::18) by
 MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.24; Wed, 6 Mar 2024 23:13:08 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:9:cafe::8f) by CY5P221CA0075.outlook.office365.com
 (2603:10b6:930:9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Wed, 6 Mar 2024 23:13:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 23:13:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Mar 2024
 15:12:57 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 6 Mar 2024 15:12:57 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 6 Mar 2024 15:12:55 -0800
From: William Tu <witu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@nvidia.com>, <bodong@nvidia.com>, <tariqt@nvidia.com>,
	<yossiku@nvidia.com>, <kuba@kernel.org>, <witu@nvidia.com>
Subject: [PATCH RFC v3 net-next 1/2] devlink: Add shared memory pool eswitch attribute
Date: Thu, 7 Mar 2024 01:12:52 +0200
Message-ID: <20240306231253.8100-1-witu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca6d049-81e4-4c40-f585-08dc3e32fc23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l4oegY5j+yCSEkIuzUbRhrLWxK6rZaDWiomvKLsXCTByBvUKfc9qMYcqrujktCvlHMd6ODattDGNfIMkE7ehPHPTWcQk3681aaWV0QqQNlvLhvnX5a27C/5mg7IBMPODm07kKz8G85ALsPXA76U6azU7XyHfBb/A9NLWLUCN9UL+YDMw1JIr6JWZov+R/gre5uGoZKZPRDbbHIarYb0XojnRp1YZz1lLvyHs2bc8Uq9TgnR5/5NUsQQDps3VxvuBFCja0pJn6PePK3NDfGxP1l+mxf7sb9dXTZA3mGy2UjW97BHreNn51p58xxW2Im8cQBL28BBTBd8YXDRmRi86S1lu7LBPIjI7y9dnCMiQEHedRLq1Krqz/nqYmj8FpoLR9mG7X/JiFlHXG7AhsmLhKTzam0UotBFdPlfO0S51szQ+aGzdZYG5GlCtU4XR8VJWixBylH9DI+p5k/pVPNUMEsn9ydkAb+Q35XxkNLOp4kak6qzeTHF3Xvw+s9VaaobKzoZXP8rbF/2UTxILXhY0O2Sx7OsQYqtA4jwVHc4/CKcrmUiWwWWU78sejMGbDRiyYDt/ovbDzFm45Wq3n3nj54D1wem9m5JktEMoQwDLUdBUPwLfsp5z1O1mR4RusGFlfT7o3vP2z3BTWm2JQIr8ZOmfPRpxg8kuIhhtSrlc608E1dOe2SfHVMon6aU/13jC2kbFLkGUf1eXWF3Pxy8tovWKGpwKFBrCeVCSH23Ubhvi+jSii5OhUFJiq3YLiLN6
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:13:07.8142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca6d049-81e4-4c40-f585-08dc3e32fc23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730

Add eswitch attribute spool_size for shared memory pool size.

When using switchdev mode, the representor ports handles the slow path
traffic, the traffic that can't be offloaded will be redirected to the
representor port for processing. Memory consumption of the representor
port's rx buffer can grow to several GB when scaling to 1k VFs reps.
For example, in mlx5 driver, each RQ, with a typical 1K descriptors,
consumes 3MB of DMA memory for packet buffer in WQEs, and with four
channels, it consumes 4 * 3MB * 1024 = 12GB of memory. And since rep
ports are for slow path traffic, most of these rx DMA memory are idle.

Add spool_size configuration, allowing multiple representor ports
to share a rx memory buffer pool. When enabled, individual representor
doesn't need to allocate its dedicated rx buffer, but just pointing
its rq to the memory pool. This could make the memory being better
utilized. The spool_size represents the number of bytes of the memory
pool. Users can adjust it based on how many reps, total system
memory, or performance expectation.

An example use case:
$ devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
  spool-size 4096000
$ devlink dev eswitch show pci/0000:08:00.0
  pci/0000:08:00.0: mode legacy inline-mode none encap-mode basic \
  spool-size 4096000

Disable the shared memory pool by setting spool_size to 0.

Signed-off-by: William Tu <witu@nvidia.com>
---
v3: feedback from Jakub
- introduce 1 attribute instead of 2
- use spool_size == 0 to disable
- spool_size as byte unit, not counts

Question about ENODOCS:
where to add this? the only document about devlink attr is at iproute2
Do I add a new file Documentation/networking/devlink/devlink-eswitch-attr.rst?
---
 Documentation/netlink/specs/devlink.yaml |  4 ++++
 include/net/devlink.h                    |  3 +++
 include/uapi/linux/devlink.h             |  1 +
 net/devlink/dev.c                        | 21 +++++++++++++++++++++
 net/devlink/netlink_gen.c                |  5 +++--
 5 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index cf6eaa0da821..cb46fa9d6664 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -429,6 +429,9 @@ attribute-sets:
         name: eswitch-encap-mode
         type: u8
         enum: eswitch-encap-mode
+      -
+        name: eswitch-spool-size
+        type: u32
       -
         name: resource-list
         type: nest
@@ -1555,6 +1558,7 @@ operations:
             - eswitch-mode
             - eswitch-inline-mode
             - eswitch-encap-mode
+            - eswitch-spool-size
 
     -
       name: eswitch-set
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 9ac394bdfbe4..164c543dd7ca 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1327,6 +1327,9 @@ struct devlink_ops {
 	int (*eswitch_encap_mode_set)(struct devlink *devlink,
 				      enum devlink_eswitch_encap_mode encap_mode,
 				      struct netlink_ext_ack *extack);
+	int (*eswitch_spool_size_get)(struct devlink *devlink, u32 *p_size);
+	int (*eswitch_spool_size_set)(struct devlink *devlink, u32 size,
+				      struct netlink_ext_ack *extack);
 	int (*info_get)(struct devlink *devlink, struct devlink_info_req *req,
 			struct netlink_ext_ack *extack);
 	/**
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 130cae0d3e20..cbe51be7a08a 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -614,6 +614,7 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
+	DEVLINK_ATTR_ESWITCH_SPOOL_SIZE,	/* u32 */
 	/* add new attributes above here, update the policy in devlink.c */
 
 	__DEVLINK_ATTR_MAX,
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 19dbf540748a..561874424db7 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -633,6 +633,7 @@ static int devlink_nl_eswitch_fill(struct sk_buff *msg, struct devlink *devlink,
 {
 	const struct devlink_ops *ops = devlink->ops;
 	enum devlink_eswitch_encap_mode encap_mode;
+	u32 spool_size;
 	u8 inline_mode;
 	void *hdr;
 	int err = 0;
@@ -674,6 +675,15 @@ static int devlink_nl_eswitch_fill(struct sk_buff *msg, struct devlink *devlink,
 			goto nla_put_failure;
 	}
 
+	if (ops->eswitch_spool_size_get) {
+		err = ops->eswitch_spool_size_get(devlink, &spool_size);
+		if (err)
+			goto nla_put_failure;
+		err = nla_put_u32(msg, DEVLINK_ATTR_ESWITCH_SPOOL_SIZE, spool_size);
+		if (err)
+			goto nla_put_failure;
+	}
+
 	genlmsg_end(msg, hdr);
 	return 0;
 
@@ -708,10 +718,21 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 	struct devlink *devlink = info->user_ptr[0];
 	const struct devlink_ops *ops = devlink->ops;
 	enum devlink_eswitch_encap_mode encap_mode;
+	u32 spool_size;
 	u8 inline_mode;
 	int err = 0;
 	u16 mode;
 
+	if (info->attrs[DEVLINK_ATTR_ESWITCH_SPOOL_SIZE]) {
+		if (!ops->eswitch_spool_size_set)
+			return -EOPNOTSUPP;
+		spool_size = nla_get_u32(info->attrs[DEVLINK_ATTR_ESWITCH_SPOOL_SIZE]);
+		err = ops->eswitch_spool_size_set(devlink, spool_size,
+						  info->extack);
+		if (err)
+			return err;
+	}
+
 	if (info->attrs[DEVLINK_ATTR_ESWITCH_MODE]) {
 		if (!ops->eswitch_mode_set)
 			return -EOPNOTSUPP;
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index c81cf2dd154f..acbf484b28a2 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -194,12 +194,13 @@ static const struct nla_policy devlink_eswitch_get_nl_policy[DEVLINK_ATTR_DEV_NA
 };
 
 /* DEVLINK_CMD_ESWITCH_SET - do */
-static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITCH_ENCAP_MODE + 1] = {
+static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITCH_SPOOL_SIZE + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_ESWITCH_MODE] = NLA_POLICY_MAX(NLA_U16, 1),
 	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = NLA_POLICY_MAX(NLA_U16, 3),
 	[DEVLINK_ATTR_ESWITCH_ENCAP_MODE] = NLA_POLICY_MAX(NLA_U8, 1),
+	[DEVLINK_ATTR_ESWITCH_SPOOL_SIZE] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_DPIPE_TABLE_GET - do */
@@ -787,7 +788,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_eswitch_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_eswitch_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_ESWITCH_ENCAP_MODE,
+		.maxattr	= DEVLINK_ATTR_ESWITCH_SPOOL_SIZE,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
-- 
2.38.1


