Return-Path: <netdev+bounces-144571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 177E79C7CF8
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8911F22E60
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8074E206506;
	Wed, 13 Nov 2024 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W0DOXi43"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3A206040
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530050; cv=fail; b=YaRYFB/RUPQD1gwe8yCyMYs1AxeAZ4B8VHN6iH3adD4WICRAUG7fxGb2TpzIClFAYsF8f4TtWvC4D5AE+3NPmyj5jBsle+krXoCrAOuhCWzOozYKAByF9gsUIOZbCj75I7XGHE8AfZ523Pu0t61Bzg5EPwp9zqv0jAgYWu0ehKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530050; c=relaxed/simple;
	bh=nHb4XnqNgYugP17RoRyi2pQQ2wRBpveDSqFo56/2CjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BKiwgJh5XbMeeT63Au//LDBLoYuvzrV65LWpL2TW5M96Qw023rTSnPJUCJuQ8pvaWIi0gZ3xs1oQAP2nqBCVAtlewqf8X51RxLAm6U9nCxn8f4vFLC3oEbT6V3Z0Iv8Fcv83mseJoRPEDP2pNv2GI9z0f4J1/sCvZ8RYQ5B1h3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W0DOXi43; arc=fail smtp.client-ip=40.107.95.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPjqPwHsWXNyIDDAFZEJrG4c/CzSLgzrPJch/L60CAC+CkGKXBKejadYpIgi1q15IOtAN0HQzNmq07UPD7Mkc1yIyeCMRqTfllfda4bQA1bEM2+fpLXnbHEsPaYHLzDpd949UONqbxEzLEfHm+RhfozGCHcanQ3oYFC1FwCs+Sjk1OanPo84o0XTp3PpDkko0UjNHwXUwID8e4U5QsD/nJzqCOebvNQhJjF6dVArz9kFUEiWroWSYIu40z1a+G6MpAN1YP0t//nzeai025Elt8BjZY1WQ24/aESrHgZ2xbBV/4oxfS6oBWpRSvhrOn2hftTaFqbR1DjWN+utTDQnWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/z2qlRDWUoYl5+kwUhBhx/M8XPGlo4NSN+1eT2H/2RU=;
 b=TwcNez6SDa+dt1ibOo1GskkED4Q3hrrykK5QlniqclAOEDPkNRUEq8ENZrVMxsGX9wcbd4eDEyviLRGWqcoEZUpfQDnnAtFAASobXsYOJc2s7SSe9Lc4GilP69hOE7JJ2C5jRwsIT8CDfs43tGkwZlpjA16X5QHp1k0e/6q8LNuJI1JZyG0lW93zahHJ140FgWIoPqdxWuPqqHIWZoeZhwgNeDSadwnIrxYuzaQIBchZBoR9376knb9fKuKQY8umrHJQ5GjvG8ifcb2Z58EgTl2XgXGVDEFb95/2L+H7337XcvxnznNFYMHQ6vzJ0EuolEP7nAsgKYElwXX1bvQw8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/z2qlRDWUoYl5+kwUhBhx/M8XPGlo4NSN+1eT2H/2RU=;
 b=W0DOXi43dxa0dMXrGpjE1OZFQ0s+j3ni07e83/D3ABUgRQCvNteenm2GCjRUWbXos7JbZii87uNmbnHMhDQXXX+EkV/rjzDM4+3tkTbycmo3ytXtT6Mehnrb5I6l+VL8FC4XUCvcg1dYMT84rqIu+hc2L8KqHqrGEm27JTIhZoFI8accmrYlg7Skq87OYR6SwniyErWC8luYIWGyjuL4fNThETMtqd9AMAMgWycSx59665AtQnW85g3ppxgEUzGx1M5b2OUJhA/0H/sMl3EApQloSIH6CmOpzJTNWbWQDR3WRQyaJBq0sVoomWNSz16T9f5BUoXOMS33blA7buOEmg==
Received: from DM6PR01CA0016.prod.exchangelabs.com (2603:10b6:5:296::21) by
 PH7PR12MB7985.namprd12.prod.outlook.com (2603:10b6:510:27b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.27; Wed, 13 Nov 2024 20:34:03 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::ae) by DM6PR01CA0016.outlook.office365.com
 (2603:10b6:5:296::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Wed, 13 Nov 2024 20:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 20:34:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:33:48 -0800
Received: from nexus.mtl.labs.mlnx (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:33:46 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@resnulli.us>, <tariqt@nvidia.com>, <kuba@kernel.org>,
	<saeedm@nvidia.com>, <cratiu@nvidia.com>
Subject: [PATCH 04/10] devlink: Serialize access to rate domains
Date: Wed, 13 Nov 2024 22:30:41 +0200
Message-ID: <20241113203317.2507537-5-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|PH7PR12MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a20795-e743-4893-04e5-08dd04228328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BRNoLKFrkSNIcGi5MPwcuS8uXNpU1w4TBxeGgj+4B+J3TdO/tvA2PvMXGpCc?=
 =?us-ascii?Q?/ECfPYcetE5uEvPuPRve/oiMNWQPY7rlyK0dGntYYrjlnQs2RUbTwlHOyP4I?=
 =?us-ascii?Q?Zu3/YwPBAR/fONjxaJlRwOuBFig4BuKxn1i1CNb0cz9nlT5UaU6IsaZsbFq5?=
 =?us-ascii?Q?WNzc+NYF1BqbUutvvQECpIvWq1BJJGjvrsU56OG6Euvg3YItDhYLxMevXtGE?=
 =?us-ascii?Q?gLtDfjiGxs6rua5Yjb9DrD0ct6i/Swyy41s25p21gZhb/QInmNZR2qYnLnqE?=
 =?us-ascii?Q?EAv7uqC3xA207NA0VbpInLmdQ2hvM/yizV0AhIg3fKTKUJ4cTiKAgU8G8Dim?=
 =?us-ascii?Q?B1G6amQcYt8cJpiYg1GwDg9wQ3asMhn1ely35aNfh/9usIoHpk9k2LyRYPO/?=
 =?us-ascii?Q?2OqT9x5ldJLOow2oPNcW2N++Wb5Fu8LkVdk4TYZDWhEbX7zUrv68vPF/Cnib?=
 =?us-ascii?Q?6M6w8oxr/VQLT2jMngVAsAejj2jWR2UC0txVp9xaR1su+Y2uskoVQLDj3xSD?=
 =?us-ascii?Q?1PamwCoNTIRPjtRHRksC6fKCRR3e0L4HQcRKdq92zAkqdyZYiJIZl6gQmmVb?=
 =?us-ascii?Q?LFGnNXcsaa+ZuzvcT2rHistWZQOKmMyqKjVPCFaj9W6XKKkUSJ+fNs6WVIM4?=
 =?us-ascii?Q?c3DoauEGRlzcqlQyEjfxPxWHQ5ZBsD1xTp8NnoKU1seupdtDafH+sirNjl5l?=
 =?us-ascii?Q?XYJM5MymN+PFyp79eLqx8wj/7lR3+WpCtkjW+8GgYBf2nss1dIkk3CqjcGzg?=
 =?us-ascii?Q?9XVEmmURjw1XJ6A1OWShCMfR8oUq+jMcYYCb5Vba1bQOp/dY5gTuhfBi2Uw7?=
 =?us-ascii?Q?xyH6IZrN/ufYKOtHa0SPGiJJKgE0c8TlbuX7BFlEuxD1tkgkTvCaaWvkHbZD?=
 =?us-ascii?Q?Gvb8wRNzbRrGqkQwxJPrjHFNJEliaxR1zYBBmohqlOFOTOVp5g5wzWwYe5xQ?=
 =?us-ascii?Q?ArqRgMfVyGwk2qaVIBu9RSYGzsWus82EBx/Hz3tTLVnplzGf0sfSEnrBCyAQ?=
 =?us-ascii?Q?hl+fwUHHJLBpm4hqel1KqpYK3DYvVwcqW4VfMLoi+Gd7Q7AAua4vmUipS8oH?=
 =?us-ascii?Q?jTbIaibZSYtmlkvOV6+V+iDqABHuXX8fYPSPejihSB7FOVrY1EYLYRFvsWFs?=
 =?us-ascii?Q?J4VF+1j25kALJdx7WPfG1cwKrViLhZ210/PVgEVtKuHdObnfXhHzDApmGTus?=
 =?us-ascii?Q?+kmbrfukc3QXvO3SGlpwQialEXE13O/xQSVl3bq//FN/L6YkkbKxJj1PzHTp?=
 =?us-ascii?Q?UtJ/NevRPV7la1Y9v+n4sTTZjFGg4VOxE7gBfFiWb0xmYJ56jZUvPnvty6VH?=
 =?us-ascii?Q?7cD2nruJ9wuxEEkZtfyRbJEAWMF9SsJ28MZYxIR0A+wD8YbpIya4tGgpWKJU?=
 =?us-ascii?Q?PG1mhvHXNbidH0sG/w9rx+MhPMzZ+RMeGh7UIUlSGCkrA/xNkg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 20:34:03.1221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a20795-e743-4893-04e5-08dd04228328
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7985

Access to rates in a rate domain should be serialized.

This commit introduces two new functions, devl_rate_domain_lock and
devl_rate_domain_unlock, and uses them whenever serial access to a rate
domain is needed. For now, they are no-ops since access to a rate domain
is protected by the devlink lock.

Issue: 3645895
Change-Id: Ic1649ae928fdc0d30e45c615bf545e3b1745181f
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/devlink/devl_internal.h |   4 ++
 net/devlink/rate.c          | 114 +++++++++++++++++++++++++++---------
 2 files changed, 89 insertions(+), 29 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 209b4a4c7070..fae81dd6953f 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -121,6 +121,10 @@ static inline void devl_dev_unlock(struct devlink *devlink, bool dev_lock)
 		device_unlock(devlink->dev);
 }
 
+static inline void devl_rate_domain_lock(struct devlink *devlink) { }
+
+static inline void devl_rate_domain_unlock(struct devlink *devlink) { }
+
 typedef void devlink_rel_notify_cb_t(struct devlink *devlink, u32 obj_index);
 typedef void devlink_rel_cleanup_cb_t(struct devlink *devlink, u32 obj_index,
 				      u32 rel_index);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 58108567b352..b888a6ecdf96 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -178,18 +178,22 @@ void devlink_rates_notify_register(struct devlink *devlink)
 {
 	struct devlink_rate *rate_node;
 
+	devl_rate_domain_lock(devlink);
 	list_for_each_entry(rate_node, &devlink->rate_domain->rate_list, list)
 		if (rate_node->devlink == devlink)
 			devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+	devl_rate_domain_unlock(devlink);
 }
 
 void devlink_rates_notify_unregister(struct devlink *devlink)
 {
 	struct devlink_rate *rate_node;
 
+	devl_rate_domain_lock(devlink);
 	list_for_each_entry_reverse(rate_node, &devlink->rate_domain->rate_list, list)
 		if (rate_node->devlink == devlink)
 			devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
+	devl_rate_domain_unlock(devlink);
 }
 
 static int
@@ -201,6 +205,7 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 	int idx = 0;
 	int err = 0;
 
+	devl_rate_domain_lock(devlink);
 	list_for_each_entry(devlink_rate, &devlink->rate_domain->rate_list, list) {
 		enum devlink_command cmd = DEVLINK_CMD_RATE_NEW;
 		u32 id = NETLINK_CB(cb->skb).portid;
@@ -220,6 +225,7 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 		}
 		idx++;
 	}
+	devl_rate_domain_unlock(devlink);
 
 	return err;
 }
@@ -236,23 +242,33 @@ int devlink_nl_rate_get_doit(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *msg;
 	int err;
 
+	devl_rate_domain_lock(devlink);
 	devlink_rate = devlink_rate_get_from_info(devlink, info);
-	if (IS_ERR(devlink_rate))
-		return PTR_ERR(devlink_rate);
+	if (IS_ERR(devlink_rate)) {
+		err = PTR_ERR(devlink_rate);
+		goto unlock;
+	}
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
+	if (!msg) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 
 	err = devlink_nl_rate_fill(msg, devlink_rate, DEVLINK_CMD_RATE_NEW,
 				   info->snd_portid, info->snd_seq, 0,
 				   info->extack);
-	if (err) {
-		nlmsg_free(msg);
-		return err;
-	}
+	if (err)
+		goto err_fill;
 
+	devl_rate_domain_unlock(devlink);
 	return genlmsg_reply(msg, info);
+
+err_fill:
+	nlmsg_free(msg);
+unlock:
+	devl_rate_domain_unlock(devlink);
+	return err;
 }
 
 static bool
@@ -524,18 +540,24 @@ int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 	const struct devlink_ops *ops;
 	int err;
 
+	devl_rate_domain_lock(devlink);
 	devlink_rate = devlink_rate_get_from_info(devlink, info);
-	if (IS_ERR(devlink_rate))
-		return PTR_ERR(devlink_rate);
+	if (IS_ERR(devlink_rate)) {
+		err = PTR_ERR(devlink_rate);
+		goto unlock;
+	}
 
 	ops = devlink->ops;
-	if (!ops || !devlink_rate_set_ops_supported(ops, info, devlink_rate->type))
-		return -EOPNOTSUPP;
+	if (!ops || !devlink_rate_set_ops_supported(ops, info, devlink_rate->type)) {
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
 
 	err = devlink_nl_rate_set(devlink_rate, ops, info);
-
 	if (!err)
 		devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
+unlock:
+	devl_rate_domain_unlock(devlink);
 	return err;
 }
 
@@ -555,15 +577,21 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!devlink_rate_set_ops_supported(ops, info, DEVLINK_RATE_TYPE_NODE))
 		return -EOPNOTSUPP;
 
+	devl_rate_domain_lock(devlink);
 	rate_node = devlink_rate_node_get_from_attrs(devlink, info->attrs);
-	if (!IS_ERR(rate_node))
-		return -EEXIST;
-	else if (rate_node == ERR_PTR(-EINVAL))
-		return -EINVAL;
+	if (!IS_ERR(rate_node)) {
+		err = -EEXIST;
+		goto unlock;
+	} else if (rate_node == ERR_PTR(-EINVAL)) {
+		err = -EINVAL;
+		goto unlock;
+	}
 
 	rate_node = kzalloc(sizeof(*rate_node), GFP_KERNEL);
-	if (!rate_node)
-		return -ENOMEM;
+	if (!rate_node) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 
 	rate_node->devlink = devlink;
 	rate_node->type = DEVLINK_RATE_TYPE_NODE;
@@ -584,6 +612,7 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	refcount_set(&rate_node->refcnt, 1);
 	list_add(&rate_node->list, &devlink->rate_domain->rate_list);
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+	devl_rate_domain_unlock(devlink);
 	return 0;
 
 err_rate_set:
@@ -592,6 +621,8 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	kfree(rate_node->name);
 err_strdup:
 	kfree(rate_node);
+unlock:
+	devl_rate_domain_unlock(devlink);
 	return err;
 }
 
@@ -601,13 +632,17 @@ int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 	struct devlink_rate *rate_node;
 	int err;
 
+	devl_rate_domain_lock(devlink);
 	rate_node = devlink_rate_node_get_from_info(devlink, info);
-	if (IS_ERR(rate_node))
-		return PTR_ERR(rate_node);
+	if (IS_ERR(rate_node)) {
+		err = PTR_ERR(rate_node);
+		goto unlock;
+	}
 
 	if (refcount_read(&rate_node->refcnt) > 1) {
 		NL_SET_ERR_MSG(info->extack, "Node has children. Cannot delete node.");
-		return -EBUSY;
+		err = -EBUSY;
+		goto unlock;
 	}
 
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
@@ -618,20 +653,26 @@ int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 	list_del(&rate_node->list);
 	kfree(rate_node->name);
 	kfree(rate_node);
+unlock:
+	devl_rate_domain_unlock(devlink);
 	return err;
 }
 
 int devlink_rate_nodes_check(struct devlink *devlink, struct netlink_ext_ack *extack)
 {
 	struct devlink_rate *devlink_rate;
+	int err = 0;
 
+	devl_rate_domain_lock(devlink);
 	list_for_each_entry(devlink_rate, &devlink->rate_domain->rate_list, list)
 		if (devlink_rate->devlink == devlink &&
 		    devlink_rate_is_node(devlink_rate)) {
 			NL_SET_ERR_MSG(extack, "Rate node(s) exists.");
-			return -EBUSY;
+			err = -EBUSY;
+			break;
 		}
-	return 0;
+	devl_rate_domain_unlock(devlink);
+	return err;
 }
 
 /**
@@ -649,13 +690,19 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 {
 	struct devlink_rate *rate_node;
 
+	devl_rate_domain_lock(devlink);
+
 	rate_node = devlink_rate_node_get_by_name(devlink, node_name);
-	if (!IS_ERR(rate_node))
-		return ERR_PTR(-EEXIST);
+	if (!IS_ERR(rate_node)) {
+		rate_node = ERR_PTR(-EEXIST);
+		goto unlock;
+	}
 
 	rate_node = kzalloc(sizeof(*rate_node), GFP_KERNEL);
-	if (!rate_node)
-		return ERR_PTR(-ENOMEM);
+	if (!rate_node) {
+		rate_node = ERR_PTR(-ENOMEM);
+		goto unlock;
+	}
 
 	if (parent) {
 		rate_node->parent = parent;
@@ -669,12 +716,15 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 	rate_node->name = kstrdup(node_name, GFP_KERNEL);
 	if (!rate_node->name) {
 		kfree(rate_node);
-		return ERR_PTR(-ENOMEM);
+		rate_node = ERR_PTR(-ENOMEM);
+		goto unlock;
 	}
 
 	refcount_set(&rate_node->refcnt, 1);
 	list_add(&rate_node->list, &devlink->rate_domain->rate_list);
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+unlock:
+	devl_rate_domain_unlock(devlink);
 	return rate_node;
 }
 EXPORT_SYMBOL_GPL(devl_rate_node_create);
@@ -702,6 +752,7 @@ int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
 	if (!devlink_rate)
 		return -ENOMEM;
 
+	devl_rate_domain_lock(devlink);
 	if (parent) {
 		devlink_rate->parent = parent;
 		refcount_inc(&devlink_rate->parent->refcnt);
@@ -714,6 +765,7 @@ int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
 	list_add_tail(&devlink_rate->list, &devlink->rate_domain->rate_list);
 	devlink_port->devlink_rate = devlink_rate;
 	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
+	devl_rate_domain_unlock(devlink);
 
 	return 0;
 }
@@ -734,11 +786,13 @@ void devl_rate_leaf_destroy(struct devlink_port *devlink_port)
 	if (!devlink_rate)
 		return;
 
+	devl_rate_domain_lock(devlink_port->devlink);
 	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_DEL);
 	if (devlink_rate->parent)
 		refcount_dec(&devlink_rate->parent->refcnt);
 	list_del(&devlink_rate->list);
 	devlink_port->devlink_rate = NULL;
+	devl_rate_domain_unlock(devlink_port->devlink);
 	kfree(devlink_rate);
 }
 EXPORT_SYMBOL_GPL(devl_rate_leaf_destroy);
@@ -756,6 +810,7 @@ void devl_rate_nodes_destroy(struct devlink *devlink)
 	const struct devlink_ops *ops = devlink->ops;
 
 	devl_assert_locked(devlink);
+	devl_rate_domain_lock(devlink);
 
 	list_for_each_entry(devlink_rate, &devlink->rate_domain->rate_list, list) {
 		if (!devlink_rate->parent || devlink_rate->devlink != devlink)
@@ -777,5 +832,6 @@ void devl_rate_nodes_destroy(struct devlink *devlink)
 			kfree(devlink_rate);
 		}
 	}
+	devl_rate_domain_unlock(devlink);
 }
 EXPORT_SYMBOL_GPL(devl_rate_nodes_destroy);
-- 
2.43.2


