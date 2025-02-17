Return-Path: <netdev+bounces-167010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 715EAA384F0
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E522C7A427D
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F388C21CA0E;
	Mon, 17 Feb 2025 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G/a4jbcZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1D321CFE8
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 13:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799727; cv=fail; b=GMA0OlNw6gw5ZFnMHG7YUnwegXFtOApdfYl+dcAs7fLlupaZF/bZdRbHmEo+yPdMbL9zSV8D6riADMcKsyuSTTHUH+jAfH+tq75guplmYsVGFzLgw0BPaXrXBZ9Btgbt1HuDuVWk+xouz2WHbLA2gGaV7I/zxFI6HtXatUXHZ5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799727; c=relaxed/simple;
	bh=gORVHcfpJkQOcL6xhwCHRywBsNvCdJhvATlmFuXhS2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7m6JH15Sd1dni1gXV+mRGCAzRwgFLLSaTAp/v2PH/B0tJofym/ucFSQkceZ+HcrTgLno+Q0DjPpkV5gJRB9XmWDp9ThARVqY5ui/4xm3JeDwlYafhRTKdiFWjj0/2XlxDIUz9zOzmP0F0Wbd6OcRSzZ5jiK0dQRXjY27M9Tngk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G/a4jbcZ; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+PU/nN2x1yKPQW50osLOr95ftqOnec7vIBjwat0ZhKmq26HVH0M5fqBT8paRhSoc9VVj/I0dkgzg2qm0VsXwpQALFMouiLEkXRbAvTDadHmEc3z3YcWnJ03pedgM70NBJ+4v5e2CwkrAcSEdDg2E6k46kSr8XO+Mk0zS1KTs2w1OuaHl44FHrtSSfEv9TW4Ltdy+TtQriTbg1x+iW/DnxxVnq321aKX525XNpqZymKfFXGoUWPKU3x56SGqzA07ivSmnXlkABFb7zOPHaEC1CEt6g3kBhnDS8yqNCXWdeDyw31HTi3IjoNfhPvMO88QSNlLcWiAHmmWbKU6ruDlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aNCv97DWhKUeBl4WjJ9ek8l1mfHi4NLhN9Pi7jy6I4=;
 b=opBGzyRStdgHxDNvv0saX9kOJLc8/W1iOwgGyJhMa4TrRIK4IHemq/0Hd70my9hT4MuOcgRFevuHxA6DbCmMLW6NxpqZ28TCoM2gpEhrtRB2ixqXfWCWIsfD5bM3QXquEAFwvhKddQrF7fD005u/hzRgz6J9x7DovJBBZ+CY4NixeYM2FVC1jOcx2mB/Hd+tRROkNNYtJF2jqzzqmAHN+pGBleGzk6q9zDGShr6a4KcmSg6e6zV2u7fIn8Uhy5Gifd1rgSTJdrMQ54Aw39Ky9SLaUh7bdgb+tK5Xeu7F/Df9xnAB5xlKUQy/7nkQkKBxTis4j/f4JihWgPCog+f2rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aNCv97DWhKUeBl4WjJ9ek8l1mfHi4NLhN9Pi7jy6I4=;
 b=G/a4jbcZigHbBPNXEdGvDY8QQ2IgjnuHWI6VuMfFnjtxv+1xaeujOi34YU1B3zosabb0jqautiAmQC791O3ofFCHcADHnNJ4ANjSPIpWVT1uAhB7n3XuULN9UEa/IUy1MInC1RYoZ6hdSKiTx1nmQV6/ApxxuxKu1or2BNgsS9Qce21AUzc050qnslxPGfSB9T6KqsiX83cC8rZNt7x1Er2PddZy5ugwwWkP2smPmAgKCDueJ//B/vsyXyiJdgaewtQNvitBJzgGTZS22z94DNBY5fl8lC5h1a8rCTbMhIMGAMg45zHFWAj9SOPKSoQZYzHk/UA2/VjoL3Hw8qI6xg==
Received: from DS2PEPF00004560.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50e) by CY8PR12MB7268.namprd12.prod.outlook.com
 (2603:10b6:930:54::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 13:42:03 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:2c:400:0:1007:0:7) by DS2PEPF00004560.outlook.office365.com
 (2603:10b6:f:fc00::50e) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.12 via Frontend Transport; Mon,
 17 Feb 2025 13:42:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 13:42:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Feb
 2025 05:41:51 -0800
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 05:41:48 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 1/8] net: fib_rules: Add port mask attributes
Date: Mon, 17 Feb 2025 15:41:02 +0200
Message-ID: <20250217134109.311176-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217134109.311176-1-idosch@nvidia.com>
References: <20250217134109.311176-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|CY8PR12MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba81c12-b05d-46c2-78eb-08dd4f58dc91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?joKCy5f9ZiG9XNuLojzTlOiqrTkRJ+Vl1ZKLxltF5X5ogeGLoFU051TBwdxM?=
 =?us-ascii?Q?3geyb6yYwiIO3ZB+R8pIbIgxQ6xjCm/0W34pjIBbILo/9XMwJp9pvZ/vgA8b?=
 =?us-ascii?Q?qAVw/ZsEnDMYXILXdYU8Eu4EfZO4qKhHY/j2iESgXECQWsEJ2U4V3zReIEGH?=
 =?us-ascii?Q?CNbkTGT8/JF0v447lk+fBGhvzRNYlAxLksi3WtBeGW0hO2A4yKBaFf8x1YJd?=
 =?us-ascii?Q?OJtwHtJ3ACxQFSmojhcGjSMWmCCZwzo1IuU44d2luZW4IWq2MNfbdy/uOGxM?=
 =?us-ascii?Q?2zpca5wC01Q/hcZrSKuXgSsgl2gdEwWbOdbP1Ydsz3kmuTMFGoBnGXs+TlbJ?=
 =?us-ascii?Q?0cwDuSAOxaa1GEyIEEYF0j3Di+SEfmS2we0TTakIZaBRRZEZ1xquMiIYDnXu?=
 =?us-ascii?Q?ZPhI2nH+Jq0taCn5lbPtSpnMbfG3jCiF/gST/4GDslAEr6x2SumS5Ft6Ip5M?=
 =?us-ascii?Q?btqp6BHTaUm/oAopJ1XS/HT2EfaqOa0GhH1URLJlaw6yi1dPZQnxvWZYiobY?=
 =?us-ascii?Q?35IJCWPeM7N1XO56xmQL95JerQkecBdPB/4YB1odn4TGkf9VHg6Qc4w69OPa?=
 =?us-ascii?Q?Ik1uj0NxsW+R68AnDUaAw6OeBNnZSFR3oqtmoFuuW7fTsAkgZZqmuLiHfSC9?=
 =?us-ascii?Q?IXuNd2F2vyVTWVp6EItCDTiyecO6BVPvLgKOvyK+iJtPfxHMMk1uRUCnpi2R?=
 =?us-ascii?Q?rNjaDGS8JnpFlhVWHlQCabW7nIlLTpDIxeGkbP8IDQgtYqMCL2RMVl9emxPn?=
 =?us-ascii?Q?qhjUnOuH1M908wD1QvhOp8ypDG3iosISSY2zGW3G7i7N2OjnmMNzCVbUOb9Y?=
 =?us-ascii?Q?E56SUcf034CejoijdlPgoMb7PayF1N0jzCLwrdXrpQHxJOfLgXv8jrhJ++qh?=
 =?us-ascii?Q?g6felRcyZfcJLntxeccOBxT/rKSrW3hLT4q0U5zE5QmgcGNoPqlStjQOpims?=
 =?us-ascii?Q?2HFDloNNsDE5smyE9vd4cktB8S2O5DY81Fj9SSX+yRZRqoDfW/lTuS/4GE1F?=
 =?us-ascii?Q?sfoGGjIxfNKh3bjUE9q7JYy7rElyzNmg+1SwgBfASU54P6IsYngaSf+TASsK?=
 =?us-ascii?Q?qTNKWAG5/bDPKdRb1gTCD5fRIOH81G8lszwAGkfS4fcjwdMMseQCZC5SA0kG?=
 =?us-ascii?Q?eaK69XbAKb+7HZPezVsg12zKs7lSwuumyB20Em/oxiFURv3QAOFalAQhyFff?=
 =?us-ascii?Q?PV+RuA1fC2l5+V3X4/DoklMD9NwgQkXzHkJsR9O9akgvIFowpCCJJvsKs4OK?=
 =?us-ascii?Q?OimMaOQp6EbqN/9yjnOphgFQSa7TbG5qNKTSV5G3EryLdBkYRdklqzFR7jup?=
 =?us-ascii?Q?bsGKG2IMgH62u90m6CM7evPUsw9jJWc/dg7U3YL5tCCxPVHwSn366C96mSyJ?=
 =?us-ascii?Q?CG9FnCUmkl46hh/Omq49SfFxDp7BczZmGydu8WAeSah7oZGieWO4pbx9u09I?=
 =?us-ascii?Q?quQ9NUAJ0BjorMuSsHorRwAbaLl5mSXWRk+l7ypQqEkK+qdhDAcSiKE8mn3g?=
 =?us-ascii?Q?cxp4/vn73El3dTM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:42:03.1153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba81c12-b05d-46c2-78eb-08dd4f58dc91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7268

Add attributes that allow matching on source and destination ports with
a mask. Matching on the source port with a mask is needed in deployments
where users encode path information into certain bits of the UDP source
port.

Temporarily set the type of the attributes to 'NLA_REJECT' while support
is being added.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/uapi/linux/fib_rules.h | 2 ++
 net/core/fib_rules.c           | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/uapi/linux/fib_rules.h b/include/uapi/linux/fib_rules.h
index 00e9890ca3c0..95ec01b15c65 100644
--- a/include/uapi/linux/fib_rules.h
+++ b/include/uapi/linux/fib_rules.h
@@ -70,6 +70,8 @@ enum {
 	FRA_DSCP,	/* dscp */
 	FRA_FLOWLABEL,	/* flowlabel */
 	FRA_FLOWLABEL_MASK,	/* flowlabel mask */
+	FRA_SPORT_MASK,	/* sport mask */
+	FRA_DPORT_MASK,	/* dport mask */
 	__FRA_MAX
 };
 
diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 424b4cd4e9e5..f5b1900770ec 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -784,6 +784,8 @@ static const struct nla_policy fib_rule_policy[FRA_MAX + 1] = {
 	[FRA_DSCP]	= NLA_POLICY_MAX(NLA_U8, INET_DSCP_MASK >> 2),
 	[FRA_FLOWLABEL] = { .type = NLA_BE32 },
 	[FRA_FLOWLABEL_MASK] = { .type = NLA_BE32 },
+	[FRA_SPORT_MASK] = { .type = NLA_REJECT },
+	[FRA_DPORT_MASK] = { .type = NLA_REJECT },
 };
 
 int fib_newrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
-- 
2.48.1


