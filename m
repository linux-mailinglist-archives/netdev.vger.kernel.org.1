Return-Path: <netdev+bounces-283558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK/FNSn79mmlawIAu9opvQ
	(envelope-from <netdev+bounces-283558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:37:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC304B4BF5
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58016300A13A
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 07:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B963815F1;
	Sun,  3 May 2026 07:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RB+bEmgC"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F84530E83A;
	Sun,  3 May 2026 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777793792; cv=fail; b=DRV8zMq2YWsvGnln+iDKKDozQek2lxQ8JM75xPa720nzm+fUQpfa9hkGfhOiXO9DxC0rAuzOGe2fs1/ii9FoNd9Bm8U86bWG0uS7PeiCzbQR2upLkSRY6BP0Vvq0so4ip8a7h9oRuHo6fp7vMlzQkmUgLvZNWtRDvfwj5S9kXZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777793792; c=relaxed/simple;
	bh=o6B3dSRr/00CuaT5uIeY5PuT+k7rogU1H10L0PNO8pw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMrRHYyFMAHBDL9PoF1b2QvdDjkispSWs2kXfbbQzBvyeEX2wZZezsGTj/mSo9urMDJ4zkcpwuQmMRXvNzRbidINUSs2AFcf7ZdcN40SvLFNfpNuMYrRy9xuB55RqUu56ow6dBRtCFvORyNxDXQEa18EYJrgqLvGiuDVk2o9c7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RB+bEmgC; arc=fail smtp.client-ip=40.107.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZovPVnpS4vEYYgXiwffby9m6W3CrNI1ADfW4/Tdt3evLiJ6k29VZeovIy3GuqnEiCd/xRWb4vRachFlZIkVl17IAYn+bvdC7apbVpvGq5SYIpJsxlxteRflBIYaZKgPZCme12bxGBsleYy7nB3g+9QWhlfVKdb52M3C0unTmUK9SshmMzdWB4ko6PdAQUhRy3AhhEtTldXVQBgHH0SIr9pnnVBKymARzyITRxOPjOqF3JLM2jvMU/m0/xVotorQsErzmlyTmlBCsQxe6/NUJJNBzE/mSEce8WJ1zGIHkkdvIMVbxflHszFcOvTiGXgyktQAU9iAzHvcHdA7N5bOv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGs9RmyNLU6Na+LQbeM5tin1fBe5XXjZ7piHdRbMUWc=;
 b=rogPxau5rILhIbvLqhgR/xgzc+AX9isnBO0SlLpPQ12xzdU4QCRWuBHnNgJPFU3TieViEMpQ1ZiwrW402d5EHp2C1CMiRScpxiBWZ2zGMDz80rNiSC4VoFgUiLB0E6T7AFoWUt7PxCgB8vLGkwm09oZ5x+QX5T8NiqwMix2Im3dIyAjJtWr7jTRTSoJtGf+OaskRzycUl+js2uGNKdlZbDZm6KqzYzEc9InI5qMPsnqSekbfe34h3EBsr91JSR7OofLhHuT+t8Bxz9Hc1eRFPQrjeAn683MTA3GG+LKdvMlk9L5ooNaZV9H8Pwouhc7uP0SYwVhRbF8cHmB4r///pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGs9RmyNLU6Na+LQbeM5tin1fBe5XXjZ7piHdRbMUWc=;
 b=RB+bEmgCOuvNrRx/kg+q2tgNp52oYom2Xbp5KtHp1mc0+hNb++PKpdqFhSRUSLlMDuFLVH30VCE7igSeq7Ji9sAKw/pdSteeIGd1P4rnMXUqmHxl9GdYMc/dXO+PwdhOvQ+7jDBgiMVnTWXsH0fEU15PnSveRdDYi+rkLDg1OqittFy3isGrZVzcfji+QWqaPuZDnlSSJU29JWCaa6ZzwVO79Jes8OOW0mthme7EX44o7kAXxDiHec9LUZJlJhzM4enKXmYuS2foUYTSo4lC3NAr2E9O9auXOc/mSw1FlLzKfensT4AgkloJL/QRs31F1Lh4MTGcxouz6uElj/MaKA==
Received: from BYAPR21CA0005.namprd21.prod.outlook.com (2603:10b6:a03:114::15)
 by DS0PR12MB6631.namprd12.prod.outlook.com (2603:10b6:8:d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sun, 3 May
 2026 07:36:23 +0000
Received: from CO1PEPF00012E84.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::fa) by BYAPR21CA0005.outlook.office365.com
 (2603:10b6:a03:114::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.11 via Frontend Transport; Sun,
 3 May 2026 07:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E84.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sun, 3 May 2026 07:36:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 3 May
 2026 00:36:05 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 3 May 2026 00:35:58 -0700
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
Subject: [PATCH net-next 1/6] bridge: uapi: Add neigh_forward_grat netlink attributes
Date: Sun, 3 May 2026 10:35:27 +0300
Message-ID: <20260503073532.2138165-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260503073532.2138165-1-danieller@nvidia.com>
References: <20260503073532.2138165-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E84:EE_|DS0PR12MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: 340928cf-4048-4170-f67b-08dea8e6acf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	hA4XfHD8RPJtx226pDGTkjHQqV2qLFPO3F2gOYJb3JFbptsaIRWDQbzQUlSnZtt9VcAPebzRhi2kKAavTBYSOuVP0Oea4uedJGMXSX73gzgTxhPxDQA3OKlGfYhBExgMwMI/a9u9B6D2dyMvU7Z2sH0ionN0qxNT741Rx4+J2CyAkABptn2i2dTBt70UCR0HpOXXExSELoG0HaxEguiNXRSvFsTWd16VhDO8mLGXTeIu628Plpa0feW2QlyCTJZnGCgFuoGSDmwmN7GTb6XH6oOsS1dzTGfXjB1o2jT7zyfKBdy2fo+jpHXXl57A1WZTL32d8k/0lE6PLSxl1zwHX7PVEocQg9D9axiIItaSW3Nu9XGqeNE9mdAxmVb7ir/ZiLC6te8vc6/q+dxyt7l2oHVYNhGSUAtatbMKVwrbFVQz+OWkMFnF6Ze1Lp6yp26F2fUQXR7WMXUWAApHml6r2zX+3wh+IJ5H5OgtSLfAT1dGuEqp1+B0zxiOqslS7gqy+iSPAK844WakMS4DZPs3v58mZzO8GH4cEvcKepWX6SadtI+0VSigPOY9FxAWDTMT3kJZit/3W3AGiBPJm6ZeiHyfSxBeHDKiiaCpLGlELpBr8mbkiLAHl/AyG3cj+DKDdqMnZSZSdBIIq8L8OewACICuLcy+PY0LjafbajO3yhGfgLTd4UI4MMOle+UUleCpuexfwYBAohqx4906AbsZq2opNRNQblYpqtsw3nu0FAQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q9RK3nSaCEIULR2Yc/wRCTzrqpGDctLpudT7b7XxrYx2ttzico0kB484FVvNk22CScdt7D46vF+tAft16Lmi5iXEngqL5fu3sG5aIGxTHDGhbk6QLmMO7gupXkyInw43l2jfkJkjspj05sMUECGM4vezH8butAHnuVs1NrLCWInCyrI0BMF9150SVklXa6y5iOAsGf1SXdwlYRS0jsoEBxL5dVY9tIcS8kG1FZAmMK/5Y8jITTQewAGUqIOmdw6xVtb22tNf0O8F9a/FgQy0yWgK9PqALrYIaC5JkInsQ4pfsrMAeOszxrlWPdzooOO1xfYNkf8+JLmQ+k1aqvknpTlnRpOO5MMPlUmDE/rwKVmUJl1OwlTDeLi1zNlLvCeP9BMckfr5O2TKxZme4QzpOrfmvBq7KxLmDdMM9fLv0/0SLngvUnZRRjKryWCcud6V
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 07:36:23.0045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 340928cf-4048-4170-f67b-08dea8e6acf8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E84.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6631
X-Rspamd-Queue-Id: 5BC304B4BF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,blackwall.org,nvidia.com,lunn.ch,fiberby.net,iogearbox.net,queasysnail.net,mcwilliam.dev,aisec.fraunhofer.de,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283558-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

Add netlink attributes for controlling gratuitous ARP and unsolicited NA
forwarding when neighbor suppression is enabled.

Add IFLA_BRPORT_NEIGH_FORWARD_GRAT for port-level control and
BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT for per-VLAN control.

The new attributes provide independent control of gratuitous ARP and
unsolicited NA packets. Operators can enable forwarding for those packets
for fast mobility across VTEPs while keeping general neighbor suppression
active.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 Documentation/netlink/specs/rt-link.yaml |  3 +++
 include/uapi/linux/if_bridge.h           |  1 +
 include/uapi/linux/if_link.h             | 17 +++++++++++++++++
 net/core/rtnetlink.c                     |  2 +-
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index f23aa5f229c5..8d61e9485402 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1700,6 +1700,9 @@ attribute-sets:
       -
         name: backup-nhid
         type: u32
+      -
+        name: neigh-forward-grat
+        type: flag
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
index 30951e5a9555..02ffe79a7e6d 100644
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


