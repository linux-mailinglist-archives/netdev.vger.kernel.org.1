Return-Path: <netdev+bounces-232154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ACDC01E12
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7AA1A629CD
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F3133033F;
	Thu, 23 Oct 2025 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b7KnGeiV"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0421432ED40
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230841; cv=fail; b=lixqTSIkqTta9s+EvUYT7WpxTCIE1dPoagMXhvFtJou9PgNk7xMgOkI3JWIwawkx1TtvCIBF6BMGSxmYMTTGzH4MWEs7vcc7wBkp7g8NGRW79hTc0VHW+tBBu1ULlIOrH04E1FEsQZV1nSGYpsb5jZ/Tpjx392qgedav5n/l6Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230841; c=relaxed/simple;
	bh=5A19wqUTTQdZ+SgbWoL7IOHZys+MEmuqcfzcN8dbQMs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fOqow5izEiQRLuPpPCMzFe4h62z2DWm1lVcWXvTe/1qQnZhjHZsE6otCymPxWY5b3mmO12ciFo4FqkdKRVPx1UJFQccgBL3ZmXnj6c7gdMDhOXmLehcdPiKOI+9r9xXj0hICj5zWJ6E/ucWXV9MAFysFad3sIvsBgCwlprxCZFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b7KnGeiV; arc=fail smtp.client-ip=40.93.195.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJ7eJvRCFTsHQU3pOFjXSlxc5sY0shUfdH46j40ovNWNFBY8fapvWTeq8MAyNmVTkJ3q9iGzWfiMT0H1Jhph4BOoLAuCpnFlOcbmyj7RnX6yYU3xoTsBBn+dieeIE15CPPf3+VLpgfUdfXt63kRSDQvH6UlicBtGFQPDd/mTST2hec4ODwIG3IXRcZvuOeelXSnuNf9eNGlBJq1EGzeLcMqTyez4NY298xwQOouTSlj+hSJdO3C4r3V6aT7sFgakkzhkEka6R/PhpT2obpM7g8JTe3rdEa4r7nJUFhZDta1nUohaJ6qwsAU955u7RtCjB3VQHx1u+6fhdhqHqOYpRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65tDy8DncG6XQ27CfJmf3d0k+wUG0/PWdAIactjQCLw=;
 b=uCCrEO/cr7aS+neo66+gyNP4g3d/2+iRp0OqIOn848wXfSPdW7ck8GHFwtr/kA7+6GrG1ojuJiEhSxS4EIYUIMhrEF7g/BzWFLtPZgnquGypIM+id1lqnw9ZyR3B4PdOAi7cL/b/rB72vLzD6eF3f5agJZ6YK4t752TRman+k3QtkXZmS1ko3exDK9Lzfrl/+hgj5RFXKhdoaL3mJNdYaDMUGKLJtQbp8U488nN7an6884esDtzAJlZnur6YLlXwCpb4RcGiEGdCG/8di9xvTmtcegDHX8snmMIFonYIVufLqEFSUpUqU3eqb2EZ3D5JrE/fA3g0q4NbfPNS7AmiWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65tDy8DncG6XQ27CfJmf3d0k+wUG0/PWdAIactjQCLw=;
 b=b7KnGeiVq6RA2/g0H4ymz84TQ1SSsMFthiC4Vl+Xyx3Q2tPstOGBh1dklfC5ywk68IqgqO7HqoHeZtXH5WLvPnqg1nfVdO4dH88Cx0vSqThN1kkWQ+MLWPFov3ZL5tgB8qfDpk+q4ZN0xvetE9rP2TNkGqm1I0KYhzwOeS4QqAmPhsyH9FqCon6JfOOs/fuCtvvmve879G0JsAZPgPgP423S9a3X01LvqpqQT7hgXqoyce3e6Knf7L+a3GQ9BZf3fSDX2a32U7nyyhS1boXYAnQMc7dGwsu6Hl9IBtJ+3VjQXeCvXI9boePPpUc7+bWu1uAPBZ36FrXxNTb144hyUA==
Received: from BN9PR03CA0295.namprd03.prod.outlook.com (2603:10b6:408:f5::30)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 14:47:16 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:f5:cafe::ef) by BN9PR03CA0295.outlook.office365.com
 (2603:10b6:408:f5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 14:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Thu, 23 Oct 2025 14:47:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 23 Oct
 2025 07:46:57 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 07:46:52 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, <bridge@lists.linux.dev>, Petr
 Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/2] net: bridge: Flush multicast groups when snooping is disabled
Date: Thu, 23 Oct 2025 16:45:37 +0200
Message-ID: <5e992df1bb93b88e19c0ea5819e23b669e3dde5d.1761228273.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a979fdd-555f-4ef3-f162-08de12430ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dNPA7bWp9d4bBONN4bJiV2FvdymPXkoS873nYBDsH/An3LqUwNY/zFjDnlbw?=
 =?us-ascii?Q?qvUWDwJ+CJm2joXOhD6YBtWTgRD/qQclmZx+iaSfG+0rzX5YVzafp2sDZR8I?=
 =?us-ascii?Q?bT1uNZGAkyBFYg8GH9tX89GI97XVxp1hBivh8jdTFbb2+Bn3fpBUIoEAKGf7?=
 =?us-ascii?Q?QlV994xVZUs7Dos5bkBVRkdoRQ4loyMb1jRlaOZOwvdTs62l/YIMT3jdtqNy?=
 =?us-ascii?Q?hnfgeGNG5hia1XS65OChUSEMloUAGVjeSA/QTsurTqKeZle8X3vGgSnwf41v?=
 =?us-ascii?Q?QMuNJ2/+PfYHOoM6akuroTpOSf9tTWJqye4Gu91e14ua78xL89gMCsggcwU4?=
 =?us-ascii?Q?FRoJMilKRharL1sKcKgLZ5WTGMxp6FXVXMo0noPp9R+/L3o6eSeY+gv/2lFb?=
 =?us-ascii?Q?6WUwQCJW5naA3RD/r7TDj8J1cr1MqUMcjvspomO8d9KK1Pswiiya9AstpmtX?=
 =?us-ascii?Q?yhMac1ZJT5stI0/ZU02g4ask4S2kK6+7RI4WHYBAOi2r+5g8eXhRPAY4Y1mt?=
 =?us-ascii?Q?Ym8+S3l23VVX/S7pwmPPkHHYglK3u8Lwy+s8WrwnuhgldvYu91Sx+ewDXAfG?=
 =?us-ascii?Q?3lkB0OdoQSShtBkE6WwPe97aDgrzorvtuADg5G3OspTGPWNE0znmxtZEsGwh?=
 =?us-ascii?Q?qqabVy/4Zab02FN77Tcf8WIDuliFNxmyssuxAI5HLQY/ZKOpXXRC78u5EnTi?=
 =?us-ascii?Q?EdfmfeRJXoIXQCa23C7zH5YWvJAlQlB6pdlD0C7S+H3UESvkBlfDdwrolovK?=
 =?us-ascii?Q?Wh55MyaU4B8H3vU46KCFk2GsYrbgSo0Dj7pOOatLvDhg+uR73PcDPmIfPu1G?=
 =?us-ascii?Q?h2/v58A2bfy8nSPUwz+YlspYbGxbAqNrwxP28KwZsqkJgTSFu+rsYvjkKH/3?=
 =?us-ascii?Q?y3+mV+AiIGfMJ/pcNoTAFLWqY1ExrscnEKYNCHsl6+3YszD7QfVz0KJdDzhn?=
 =?us-ascii?Q?isZ6coG3AJKX1DYLoQx7UcKf0JP8pQJla2KvqbEZuY1sHcO4jTfJBApmeNQM?=
 =?us-ascii?Q?frP7E0JUsRI2vpOBPfibCpBwict3Nw7exZhfoGOJ9VllU7QpYl9IqzZEKMBz?=
 =?us-ascii?Q?FRfYO9+Sxs/CQgkPUB6tbkEKiVItrRCaH+LnnpdEPWMid3bhAtb4MKPU7q30?=
 =?us-ascii?Q?0hJzVfhZYoM29/SsrlznWVuipt5f7fOtM1PE3WQxQ81JFAcTqImME0n0vqlX?=
 =?us-ascii?Q?wr0JrzBULZe8JGiL6luTW7wW9d5yU2g8ymOcEycGKif4qgpQkA0oevlmQe+2?=
 =?us-ascii?Q?PsAzO7Cj1JuzJiw5gVwoyv3GUAYL37+rRhBKTSHFJWOQj82Yt9kwCnL2xfXF?=
 =?us-ascii?Q?DDbAoV82AVN/D9IDSJVwAtfB5cx8ckLtRnarlUBEKPM9e9MmESULelwops9U?=
 =?us-ascii?Q?CumcpU7txG1h5+mNLYNJUy6Dj16i6epYYOSBYr8oepvKI8GzgR6Cw5epftr3?=
 =?us-ascii?Q?vkK4raT78rpv1XrA5UJvMRPfHz12KwcJn+jWASV0b5DokuAKH0qTHbYu7FSz?=
 =?us-ascii?Q?m633gy8+pp8ZxPOf8i7CF7qC4d2b37vs6DqzBeWI2M4OXIPlqAICinhWXQN0?=
 =?us-ascii?Q?wAk19Yls8/5rF38STFs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 14:47:15.2418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a979fdd-555f-4ef3-f162-08de12430ed7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551

When forwarding multicast packets, the bridge takes MDB into account when
IGMP / MLD snooping is enabled. Currently, when snooping is disabled, the
MDB is retained, even though it is not used anymore.

At the same time, during the time that snooping is disabled, the IGMP / MLD
control packets are obviously ignored, and after the snooping is reenabled,
the administrator has to assume it is out of sync. In particular, missed
join and leave messages would lead to traffic being forwarded to wrong
interfaces.

Keeping the MDB entries around thus serves no purpose, and just takes
memory. Note also that disabling per-VLAN snooping does actually flush the
relevant MDB entries.

This patch flushes non-permanent MDB entries as global snooping is
disabled.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/bridge/br_multicast.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 22d12e545966..d55a4ab87837 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4649,6 +4649,14 @@ static void br_multicast_start_querier(struct net_bridge_mcast *brmctx,
 	rcu_read_unlock();
 }
 
+static void br_multicast_del_grps(struct net_bridge *br)
+{
+	struct net_bridge_port *port;
+
+	list_for_each_entry(port, &br->port_list, list)
+		__br_multicast_disable_port_ctx(&port->multicast_ctx);
+}
+
 int br_multicast_toggle(struct net_bridge *br, unsigned long val,
 			struct netlink_ext_ack *extack)
 {
@@ -4669,6 +4677,7 @@ int br_multicast_toggle(struct net_bridge *br, unsigned long val,
 	br_opt_toggle(br, BROPT_MULTICAST_ENABLED, !!val);
 	if (!br_opt_get(br, BROPT_MULTICAST_ENABLED)) {
 		change_snoopers = true;
+		br_multicast_del_grps(br);
 		goto unlock;
 	}
 
-- 
2.49.0


