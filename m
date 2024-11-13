Return-Path: <netdev+bounces-144570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668AB9C7CF7
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257C7281CDD
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CC720401E;
	Wed, 13 Nov 2024 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NWIUQ9vG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2EC15AAC1
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 20:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530047; cv=fail; b=fvIQw6W5AuUEVJ6KxtIMg3nfQfi9vk8Q3NbkhREqePKsHxI+Lw3pErPJhY172HgEpxjvttXq1wGkn80z6tYmz+/DQjuLTImtInHSmHFUK9wuH30+wNLBTSUfBvvPTTWPVWF7u7ckq8KslpmSuw9i/JbtNTnPaOtQqUF8yUWBOz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530047; c=relaxed/simple;
	bh=WaYjU+/chHKVDe/Gd5NE5wSzK+eMz84WJi4+wdjql5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCf5ZfkST/Ws+Ofhr0qH9mIB+z20gi6vZPYPNMS1wpvfZkYwvCzyDe3q25uMI2+ipS5GevnSKHpPQJo7JLT8u1ECeHvRgC0XPLyej7Y5/9ZrcwkzcyP3HEQez6ObLlchhxemCUVj+gATiamJxN2b2UYIYang9m/eckK5u7iux88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NWIUQ9vG; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnc0GRQkyw5adxgUaLQofaqT9HkvRyiVwGiCUamlFJLIB35SS+6WaeSruGDAc9jfrrYnpPqkrBTaA+XPOELgSHEoa3VeknTcsr0UA4qCPNXu5l7lX7k0+H4jg78jptDjcOJrQOjDkODAVCIfVTFP5o0nqaQSybViEtanYg/hlvqvNe6YOY8mbFRhhPBfTjo2qaV9gAP+9xeMVwtjRjcNKqxvLdTtSraGEm6I8hbagyvOm5FjZiYWZE27GAknmtsDjkIapSde/tn3YVAGdaBDXxWcQBQQwLPCsCdTk0dRLyhGTvntejghTUBmvbmn1VTXv7Mt8bBnQYn9azbxtw3R2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3gheygQIItbY1gTunBELYYJMjosAw7hlwnmwkjej/Q=;
 b=vVFjbrGSxXmTzfEsC2A4R35gk8xWIhPVOovML80zI+BJPXSQvCw6qnVOiPM6v4CtS0qHQNJBEmS3mSYVF4Rn3J/xLD2zWbz9tykwcvL0FCTnvcpqRWAHh3uO15gpw+dc4XJPeza6J6rW7N+dJf9yUy/kJhA5bBFGA8K6Ehkqn8zJP/TuMmFgtKQkNJUw6Lyi3qRa46NZ6eAoCwqzQ6AQDCUn1CsuhUN0umpdGTQxg1SPkMJ5TaP424aCmSIofdki2MSKOlHKVJWH67llEOm9478sfUnEKnqt/rNpoNSOvGtWxkrW/UWNkBXv08oNFEhtbz3EODBt4n5vsW0QXdvxhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3gheygQIItbY1gTunBELYYJMjosAw7hlwnmwkjej/Q=;
 b=NWIUQ9vGtuI+DEwnwb0vE8J2edOy2/Kgm1DdRiCmhVF9OB9tS1eglQ/xYetX3EDPpYTwVisg6wwLUcjYFPDfmmngKUwHeNElP8LffgDmnUEA7+AHGP87dZDBSTkB+VVbCw+AoCA4P1VZJnCxQiCdVNapwaLoAc1Y/4wojYXnV0mnS1GGjtbR7w1RV7UYw9e6yOlpW3o4PEMotTaZI7qG2jdOEp6Db/WkgB3UtK7EfvYkQP/hXff1JovOB35ooftCeBuh5jZifJ9FCc8b6Uyu80c2OjADKtNJpz+V6OzZYYedthZ8w9YujmmaLU8vTZlUQHgppDZbUul8wUIcAc1B8A==
Received: from DM6PR01CA0021.prod.exchangelabs.com (2603:10b6:5:296::26) by
 MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 20:33:57 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::91) by DM6PR01CA0021.outlook.office365.com
 (2603:10b6:5:296::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Wed, 13 Nov 2024 20:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 20:33:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:33:44 -0800
Received: from nexus.mtl.labs.mlnx (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 12:33:42 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <jiri@resnulli.us>, <tariqt@nvidia.com>, <kuba@kernel.org>,
	<saeedm@nvidia.com>, <cratiu@nvidia.com>
Subject: [PATCH 02/10] devlink: Remove unused param of devlink_rate_nodes_check
Date: Wed, 13 Nov 2024 22:30:39 +0200
Message-ID: <20241113203317.2507537-3-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|MN2PR12MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: 6784e266-5fef-49d3-ccde-08dd04227f83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QIZoDSPC0gdPaoKJOMfcr8SoUaMy8GzBmUSRwkPpTnhT/dMHxE1uptmtJdCD?=
 =?us-ascii?Q?fsTTKZQLVOhW+1uibF/88zWB+MAXaWfzdGkb9lSB441Djun61Z6/uqvNnpA7?=
 =?us-ascii?Q?W4aUt/tff7UWzOtIFdEBSKxJM6bNW+8a/h6W4m0Fle9pUSwJXlfeDJxJPGzY?=
 =?us-ascii?Q?wcQ0LC+FIbtzkxopQ0XeUbXmRN1FGMUMgW67JfllVYitQKuohxUu9um4UbBk?=
 =?us-ascii?Q?JDJsYbPbV9I+SAzBUt/9b1yUqrRE3PuO/6HHMjDPQkjToYYkj6+VZup0k8vn?=
 =?us-ascii?Q?sgNB8QvrxoDEzxkPS1bTzJWOIB27ZP45iZJ/nXpzkmiCGQhFgEa6R25oHzUQ?=
 =?us-ascii?Q?hHRSvDJNR4Rp6Ygdi1kThxFK+QPcHNRRHwkbDXcqMP5fk6pytq8luJyxTtad?=
 =?us-ascii?Q?f8Vao9nXzu/0Dnvwetny/6tjR+hWn8Ahzwmia3WkO5fXRVFwuZ/7rv3PxbAJ?=
 =?us-ascii?Q?4DLMMoCyIcioGZxDbNeW9zY0XA51N7D6no6iDPw0IiJ9e41xWCYqvweqq/dw?=
 =?us-ascii?Q?02UT73URVd7zEeq691lTVzIltPywpY0MFCCzN9o+vVfvwv7IUOECJW9zL5l3?=
 =?us-ascii?Q?mRSukwqNCxNwjkHhafjeU1SFZ51PViS7dTRe+zDIS7yrcARyZWmUJMJcp0Sc?=
 =?us-ascii?Q?bn9PYnQzXfg4y+8vlGSeFwrmH4p+r2EvcxUqWXoGD9y07mZccM/DUb7b3oM2?=
 =?us-ascii?Q?WUOu6nNtb/3RUUR53RNqJ6gBLdziEu75qszDzzvgt5+Js/M3GbC59XO0czPt?=
 =?us-ascii?Q?utxkzXoBLU3NSLBBuVKh28ja1c+iBzPZmTMrQ5iCbjssViaB2XG3xUK4cpCi?=
 =?us-ascii?Q?BtTUH61g1XYIj3pM9VxVNFdHqOuGyN8K/W5XYoHFnTxwMlBTAkIO0otgwJDO?=
 =?us-ascii?Q?qKrkUUepBOh0WinGWO/BwCbHsxCOS+ipSjT9Q3gig7a/qS0+0F+/qlf4DbW/?=
 =?us-ascii?Q?6WfRp1U9Cu16wOFO1eLCE3XGATtabbdmh+2EJkCp+omlbLnKo9eeFSU3aOtQ?=
 =?us-ascii?Q?XA+PyHSdMPi3tmsLefF4bM3vRRoHfoBzT2mMzoTJvQo22oep38sUJCFTTKba?=
 =?us-ascii?Q?Zm7Ut4Vtsnd7akaP0Di1jSJxEgCPJ95VxXpPoxGTwajeG3ZBYhA8WkBNYBng?=
 =?us-ascii?Q?gsoR5Asw4KGT+QhNi555GWEY1/uC/RfzbyAy2gwFJSCYxwfROBxCFk5nD1FG?=
 =?us-ascii?Q?c/5QmD4yeklQGHsMmh7qGRYantrXdvraYxFkKvo8pFfn8bDnKWeWGHF1jLmg?=
 =?us-ascii?Q?F/eQY5pFnDrW9QMyq8ZEzibU3BJcxdwP4uUhptu9P9iMkLwf4yQ+OUxzFQPd?=
 =?us-ascii?Q?xaovuQjL42aqN+OnHhSt65mxdqBY+pPHk4VAteJoJUshvew4f8lrCNl9WuVa?=
 =?us-ascii?Q?eNMsIbjoPrPSrhNFzkN22iZq11ts7eXMGjHRL2kHO9gQQV77uA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 20:33:56.9346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6784e266-5fef-49d3-ccde-08dd04227f83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157

The 'mode' param is unused so remove it.

Issue: 3645895
Change-Id: I89175a3693e399044f7761b03d93b6feeef653ec
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/devlink/dev.c           | 4 ++--
 net/devlink/devl_internal.h | 3 +--
 net/devlink/rate.c          | 3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index d6e3db300acb..5ff5d9055a8d 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -713,10 +713,10 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[DEVLINK_ATTR_ESWITCH_MODE]) {
 		if (!ops->eswitch_mode_set)
 			return -EOPNOTSUPP;
-		mode = nla_get_u16(info->attrs[DEVLINK_ATTR_ESWITCH_MODE]);
-		err = devlink_rate_nodes_check(devlink, mode, info->extack);
+		err = devlink_rate_nodes_check(devlink, info->extack);
 		if (err)
 			return err;
+		mode = nla_get_u16(info->attrs[DEVLINK_ATTR_ESWITCH_MODE]);
 		err = ops->eswitch_mode_set(devlink, mode, info->extack);
 		if (err)
 			return err;
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 14eaad9cfe35..9cc7a5f4a19f 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -297,8 +297,7 @@ int devlink_resources_validate(struct devlink *devlink,
 			       struct genl_info *info);
 
 /* Rates */
-int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
-			     struct netlink_ext_ack *extack);
+int devlink_rate_nodes_check(struct devlink *devlink, struct netlink_ext_ack *extack);
 
 /* Linecards */
 unsigned int devlink_linecard_index(struct devlink_linecard *linecard);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 9bffda6783f9..c9e471b9734e 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -615,8 +615,7 @@ int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
-			     struct netlink_ext_ack *extack)
+int devlink_rate_nodes_check(struct devlink *devlink, struct netlink_ext_ack *extack)
 {
 	struct devlink_rate *devlink_rate;
 
-- 
2.43.2


