Return-Path: <netdev+bounces-286465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oApnKsl+AWoMbQEAu9opvQ
	(envelope-from <netdev+bounces-286465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:01:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3565C508C51
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B14283015858
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3217930E0D6;
	Mon, 11 May 2026 07:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LIsQ3igq"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011042.outbound.protection.outlook.com [52.101.57.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B552730C354;
	Mon, 11 May 2026 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482840; cv=fail; b=F3mJWW2X86yeoK3kjYWsZGcCimTx9QWOXwOe102cSFo7P1U4pXElukUd9uC0HkX10xm5kWqRrbN4VHo453O0f4IXfu1IPb434/cXynIifavQMiAzfg18l129/Ga7Mq1P7bvzZkP4bw2MBv+ThRQhazuOcKpX7G76OnB/2tgkF/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482840; c=relaxed/simple;
	bh=U/aZNqfyGo7l5MfM65uWIetKH1Lo3Pw7DQN5uE9faIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0m1NbuLgeQDhfC5WMMj9T7Xn7oMZxaflsgDbPPTuWH2Haqq1H7UKfk3Q/l6e2skzHqFFlsKrET+fhxBo18PM2ivNChKJLblOto7xtE44VBuzmAyTJC13isSG1PGORoxfxxfxh0wqlbN3wZhB7P1R2C3bbuVdLzk846Qytqn3U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LIsQ3igq; arc=fail smtp.client-ip=52.101.57.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFeqmoLbPVbMTkmemtfuXjAbPfrru1Dgy9Un2uRUREGNXzV0QPWUFeqJinL2oZr/4jCSfhqZt28EaBCQDUp2o35FH4ucQzsmd/GIiT0dzlJcyh/lxPdoOxYCiBBmhouMYrUXnRFWwXaWTO5SH4jwhCj6bn8oogMCYOMPBBpIG2RkYuTtF+N61YAUBubAgwmz7tFMlvm2FDwa7z1eghVT5UYwtt+MqJ6WA49eN0tA19a2Dzv+QZ2HTbHB9uyps4vIvvoIVfD1iulW5ypzm7diT7SHcYqy6X9N1L9gyKd5mOFd22gxLQW+a+It3muIH+pMRfdgxvOcwpD6DNtqMMBM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aqFaXl3eKuEerAN8nld07HYL35q8GFA3XUb+A6d1fY=;
 b=xb9NxrgA4WczS3C9rTh1kDZVzt8HDG2tyDSwOXv1McKQdM5tRgJhnInhmEOt29jFNXj4fEw1U+n026Lo9yHAYwHwr1/BhaM9RzCVuqkrMri7B8bica3ODhNy8uQbItfOfrenGqedmgwEDWlQRUvsnbdtCyoFvEehRjF5O4LRZeFHXljHHgbLpql4t8D5A7nH95XDjlcLyi2lQPa0F8CvDfP836ejsuOHwuz+5i9O7NWzMa5Dg7m9sG9RnL776BXbIxYtIPppIkUFTVGX3tKBSFw1dA6954sWHo84+G0vNZf9xRPvTPaD8bQ6qqpYxMCHnmjlT9PGha2CFPgWVJzfJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aqFaXl3eKuEerAN8nld07HYL35q8GFA3XUb+A6d1fY=;
 b=LIsQ3igq31khImnb529WmSeYXFfuaQZvQCyOvsxMQU5XSGwfH9VnoPMS9jwXZ1EQVCn1Q2fFRXtLvjX65IinxFgviHvMpTfHfYag/tFIOoyLS9yByMR5XQRVvRlhTvn6kSRAbjl9Sp58/0o8VinyqNyyn3DFKRURlISm/XEThUuAyEoalYqkyNilsZxXFHg+yqSOxO3LX/RM2J6/iNRMDLhW/GFkUn5bhawZ+awSjKv40Cuyq6EFeKyLRpS/tP1zBOGL0kNaMC7wrhM+iefxHlLpHQTDaZ+C7aI/7pGbGweLDmjgtQPoCKd2kJ9M4bFHld8O6UIqQn/Ro+hrUvINVw==
Received: from PH7PR17CA0046.namprd17.prod.outlook.com (2603:10b6:510:323::6)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 07:00:31 +0000
Received: from MW1PEPF0001615A.namprd21.prod.outlook.com
 (2603:10b6:510:323:cafe::b0) by PH7PR17CA0046.outlook.office365.com
 (2603:10b6:510:323::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 07:00:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW1PEPF0001615A.mail.protection.outlook.com (10.167.249.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Mon, 11 May 2026 07:00:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 00:00:11 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 11 May 2026 00:00:02 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <donald.hunter@gmail.com>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<razor@blackwall.org>, <idosch@nvidia.com>, <andrew+netdev@lunn.ch>,
	<shuah@kernel.org>, <ast@fiberby.net>, <liuhangbin@gmail.com>,
	<daniel@iogearbox.net>, <aroulin@nvidia.com>, <fmaurer@redhat.com>,
	<sdf.kernel@gmail.com>, <sd@queasysnail.net>, <kees@kernel.org>,
	<nickgarlis@gmail.com>, <amorenoz@redhat.com>, <alasdair@mcwilliam.dev>,
	<johannes.wiesboeck@aisec.fraunhofer.de>, <petrm@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <bridge@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next v2 1/6] bridge: uapi: Add neigh_forward_grat netlink attributes
Date: Mon, 11 May 2026 09:59:31 +0300
Message-ID: <20260511065936.4173106-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260511065936.4173106-1-danieller@nvidia.com>
References: <20260511065936.4173106-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615A:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e45288b-6891-4356-b8a7-08deaf2afdbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|376014|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yIRiWfqs0s6foTn4VoFu2R6Dyt5OPSlRidnJS3Euw70ccCcZqQETUCV/Y6yuHzHJehYnnem1JXkd0qP8syRkNHk9KIk51xZ0A+g4PqyGioWYd3DnZI9FsYu+GZ++cxwDAZ7CL1jQSPJv4NkDnh8S7kN9dGjz4iMwmn2s8Os7kmyFsOryI/zgPf+9lslbnXDhFebj+XQL9dz3I8Duf38SFM+e2TZLT2RmxuX5GNlUbjEmQqIThbYxhpzI+d7HuOOb0hSqFHpC+n0BGIwIUBmmZa+PgZAllxJHg4LKqeWrBRUmfoHNzZ6eXYljgTObGhdLoiBy2UUjNG+XKUjLOpl4sNfipmj1VE4aAJY7/vopfhfyjgJQaNF9Gcmhqvz5MejgpjLIiMUQUcefx95QDegQQQz6uW6CPx+oh/JR26YysKJANi68RpnJmyBUnvctJ8IHJHnaZbw0AaR9k2JiTBXGh68jYP1CiHU26aeDYiym5vChZr3DLb4ZzyMGZbqIam+T/2TtSOwyWQzC8u8tboqvgKFSdsixIOwm5xHQ217zAmHyq3Qu/vOAFYJdkqFqVk0wT/famkrI+2YCjAZIzoupvh9A99JqV9tocAZJ1sNPy6xYpou3b4r+O+zROYOi6f6CCHtZ6oS6pXaPhI8PJVdPLhzZGFOdeCBUlefVqfrdnKex6M+3uUtqVmEkkyM50fxzCXehfHDyeJOcwQUEHmjbgViaAaO3IBUl32aABJlsxFU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(376014)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nnfLGv8B3xGS65p/83XmSatPD0JosDehf+iM1333U1kFALWGTSYAQ3hbWYznD9mXDs3iJxXo17G9e1RnpkpGXMFK6eO5LiKaw0ZUfR/FSD2FHBQJd/+S5KGftaNg/Oh2zw3QAmP7FbSppcetQX8E5TsigN0hznO5rRbjvqb+9JjrD6F2HhbLp6+5AkxokYDNnD/wSPY/sQGyES+vvw3Rd4pue2USNA0QGDGjGJS8RHkfbLKj/bE2DVxinaSppi2GA2PjxHJIxgCQ3qf3BmZjsuT47gQFNoWFhVH8Ld98gVRVkwxFbFlH9bxuhGcNgKsZBua9D6gOsUNDa5lbH+kXD1N4Bn8leFM2QgG5z7kKhnfrzudjkbC9ENM37y1VswoUCQEnd7Fafbh1FcAKkCJTexA1eKHHn6PeJ3lqacMqas+rgq+JcqoRkkAk+oqup58W
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:00:31.2248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e45288b-6891-4356-b8a7-08deaf2afdbd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
X-Rspamd-Queue-Id: 3565C508C51
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,blackwall.org,nvidia.com,lunn.ch,fiberby.net,iogearbox.net,queasysnail.net,mcwilliam.dev,aisec.fraunhofer.de,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286465-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Add netlink attributes for controlling gratuitous ARP and unsolicited NA
forwarding when neighbor suppression is enabled.

Add IFLA_BRPORT_NEIGH_FORWARD_GRAT for port-level control and
BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT for per-VLAN control.

The new attributes provide independent control of gratuitous ARP and
unsolicited NA packets. Operators can enable forwarding for those packets
for fast mobility across VTEPs while keeping general neighbor suppression
active.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v2:
    	*  Convert neigh_forward_grat from flag to u8 in .yaml file.

 Documentation/netlink/specs/rt-link.yaml |  3 +++
 include/uapi/linux/if_bridge.h           |  1 +
 include/uapi/linux/if_link.h             | 17 +++++++++++++++++
 net/core/rtnetlink.c                     |  2 +-
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index f23aa5f229c5..79c89f204415 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1700,6 +1700,9 @@ attribute-sets:
       -
         name: backup-nhid
         type: u32
+      -
+        name: neigh-forward-grat
+        type: u8
   -
     name: linkinfo-gre-attrs
     name-prefix: ifla-gre-
diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index e52f8207ab27..21a700c02ef7 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -526,6 +526,7 @@ enum {
 	BRIDGE_VLANDB_ENTRY_MCAST_N_GROUPS,
 	BRIDGE_VLANDB_ENTRY_MCAST_MAX_GROUPS,
 	BRIDGE_VLANDB_ENTRY_NEIGH_SUPPRESS,
+	BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT,
 	__BRIDGE_VLANDB_ENTRY_MAX,
 };
 #define BRIDGE_VLANDB_ENTRY_MAX (__BRIDGE_VLANDB_ENTRY_MAX - 1)
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 79ce4bc24cba..46413392b402 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1085,6 +1085,22 @@ enum {
  *   Note that this option only takes effect when *IFLA_BRPORT_NEIGH_SUPPRESS*
  *   is enabled for a given port.
  *
+ * @IFLA_BRPORT_NEIGH_FORWARD_GRAT
+ *   Controls whether gratuitous ARP packets and unsolicited Neighbor
+ *   Advertisement packets are forwarded on a given port even when neighbor
+ *   suppression is enabled.
+ *   By default this flag is off, meaning gratuitous ARP and unsolicited NA
+ *   packets will be suppressed when neighbor suppression is enabled.
+ *   Setting this flag to on allows these packets to be forwarded even
+ *   when *IFLA_BRPORT_NEIGH_SUPPRESS* or *IFLA_BRPORT_NEIGH_VLAN_SUPPRESS*
+ *   is enabled.
+ *
+ *   Note that this option only takes effect when *IFLA_BRPORT_NEIGH_SUPPRESS*
+ *   or *IFLA_BRPORT_NEIGH_VLAN_SUPPRESS* is enabled for a given port.
+ *   When *IFLA_BRPORT_NEIGH_VLAN_SUPPRESS* is set, this port-level flag is
+ *   ignored and per-VLAN control is available via
+ *   *BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT*.
+ *
  * @IFLA_BRPORT_BACKUP_NHID
  *   The FDB nexthop object ID to attach to packets being redirected to a
  *   backup port that has VLAN tunnel mapping enabled (via the
@@ -1137,6 +1153,7 @@ enum {
 	IFLA_BRPORT_MCAST_MAX_GROUPS,
 	IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
 	IFLA_BRPORT_BACKUP_NHID,
+	IFLA_BRPORT_NEIGH_FORWARD_GRAT,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index b613bb6e07df..c3b92b291f9e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -63,7 +63,7 @@
 #include "dev.h"
 
 #define RTNL_MAX_TYPE		50
-#define RTNL_SLAVE_MAX_TYPE	44
+#define RTNL_SLAVE_MAX_TYPE	45
 
 struct rtnl_link {
 	rtnl_doit_func		doit;
-- 
2.51.0


