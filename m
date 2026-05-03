Return-Path: <netdev+bounces-283560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JgLCV379mmlawIAu9opvQ
	(envelope-from <netdev+bounces-283560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:38:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7CE4B4C45
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 949B73020A97
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 07:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD333A9628;
	Sun,  3 May 2026 07:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nd0BBP5q"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8581346AD3;
	Sun,  3 May 2026 07:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777793800; cv=fail; b=XULxiyQdsEspEo08FnY71dYU9JEwDn1lpk+nHi2cK1ksrng7NDyT85J1D0AKQQoSuV2M6BgVGYcsWDAhYmSv17kUTBzXEdn26vFTBgvJPVdhvXWwjZg2sEz7kRwSMbeWbrMdbpmXslTSUZtbX/G+7N23FBx2aoDBAYWLhh6/TU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777793800; c=relaxed/simple;
	bh=7Ea4YC/XfIWk2yomo87QxykNlk5pG3iNXNkuxokJG5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KO5YVLpeGRw6kR6RB4tqXy6BOQScO1U2Se2Y/vPkMP7m1XbBQHuenEELZWxUEbPuw65qXKPleMCZM8hox+E93FNxz4AUga2kPHRapIrEI+/FfAt9PD8cAGEMv30t4bTOxaBXY70uh1JEVI5Ap2RfqdiSti4D7ZfdR8dmuHnKeWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nd0BBP5q; arc=fail smtp.client-ip=52.101.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNzWGVX/gxRVbkBHTZkjjy6gLF87G8Dch0gT8W0ktLFpFcYbDcpo2Fc/U8AGo2UbSMRui6P4n3/L9+PeeQiXBUrwHaz8H19d5RpTAv/ZsnYm5TNx4BbNtU53ChvG+RpcbnoY78Tzr7z1YgyhDeeR2BoiqPljU3X834XtOIVwB/eSQkWbFA38A24jM2Y3tUBUHKMvUKvamtn9cB/eOBh/IOJhBMamP6fZWnBznbFlEthsHc7tt35uERtvt/k7bJ5ccLbkVYd1CVbUFJWlhgMLvtL+oJgxzGAtBNkXvnraK6V+3aVwl6bKtWw006ZXc9BhNTk6JnksjHKbydccPeYgbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9i7ZLcebWWXdoxwmuU0xOjIHKYW8+2MP/jPDMzU/6Q=;
 b=iiw3akiHpgzRRYoj/gFh8pS+EESSjVvU3s8lBausZDvjQBXr0SdPzKH4yTLnT6vmikF83sTfyJvsE7YWhTWAKvj50V0CbErufc22MVxnrY1yPXf8UYkxqmV5meULjTtvUU/KuNU6PFlkpQqE76y75eJrtVEgZnRzsa3yf6OPH2v+RYvgNA37cPDr9BbnAOfvBVq/fgcGCkIt+isrAYyoHcwGhch4xM/bea1NmAAjQQTkeQpxWbPFml5/aPJPOw3hiZmlt7bicst2MVp31X+RwzVQNQKBnF34QOV1PCH2zvgJ3HYAfFWh5xF/e839laIG6ttXXRUWobtViRKWKRSKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9i7ZLcebWWXdoxwmuU0xOjIHKYW8+2MP/jPDMzU/6Q=;
 b=Nd0BBP5qVRvv6nQZC3FPHt75FiJWF6aCKgM9FMbVY0ZA7vUA/FlsCE9zM1gwBKiYUswB0bWuSzSoHPVUjGiq86wpsLGp7QM4D1RW03ccxltqpEBhGsatxcJR5cWrXYrio42Bhh3tEfK2S9L1nLuH/GI1Mh/wzZpbUbexp0qQSZoyN4/HfODe05ZMSOfTWTUBug0h/yCzphXmmhgIHdH4NnVyE1QdXMjOPpl7HqjuBVLJr1iVqJ2Y7fGeqgE5dckCNCo8GjkZwdpefULkHA4yRmxBCeV2Fom7bGCH7bt+Q3uyhDSInTD9v0XQH037W+xD8o7YokyA1ky7Vvf/uzBTkA==
Received: from PH7P221CA0076.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::32)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 07:36:33 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:510:328:cafe::ad) by PH7P221CA0076.outlook.office365.com
 (2603:10b6:510:328::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Sun,
 3 May 2026 07:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.1 via Frontend Transport; Sun, 3 May 2026 07:36:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 3 May
 2026 00:36:19 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 3 May 2026 00:36:12 -0700
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
Subject: [PATCH net-next 3/6] bridge: Add selective forwarding of gratuitous neighbor announcements
Date: Sun, 3 May 2026 10:35:29 +0300
Message-ID: <20260503073532.2138165-4-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|BY5PR12MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b248815-31a7-4c67-6529-08dea8e6b2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	dbp8Y/eSnT8KPrRTt/OcoK/WxotCKCVApMrAvEfCglCyqE+uwMyzJfIN7jafCTtb6QbqbTHZTBbeYFaFZtzhdZ8VPqyEghOIyY3aPKMaXvQb88gdnwIkNfFt/3gaImByVN85NVSQwKuNxr7CS9QWJHEKlZBikbxm8A2LJvmMU3C6qdLKnNEmfrgfsG7ZXYtAdLfOb/FPVtLBoXXR2I3Rzbhgd+r+y/FngP8uuu9v9vNq5HViVgrjnPHodpi/CyqS+SnSAeGoP+PwIvC+lsykKw8Cc3seiAxid14xo7hI+TmEEEIMaycXRgdI9+RAc+laCxt/j9uFpiDWb/2Fn6ZFeCmcQE+BXGNtxmJSlIA7SmuIM1TjjWxOAj+URpO7umTGShTK45pBzVxfBlnnELDu6uPeaTQs7MHW/egUf5nASq6ZCWj0v1TG5kfuuZfel1WEM9oPdqL2sr1pzjK3BXulI3AET6xtl+2u4tCTUXsPEkzy7BkEvIXySWQ3DEzSMbB6wfzB/tTw3FkXnYcO87/eA2youQ1cEQ6lherv+exChZKrAIJuNJoz/zwR3mL0coHOE7ImvlM5BQfdsGB6J+QnelBY7BTE+EB49VCn8sHp8dBR8JrPVaiMtMSI3AIAglLae+1IoeZ1C7yytbb1QTX/ILAw3plDEi+/IygUUSlt3SsLo/WTz8DcpIzBn5wDklPn77BoTeBS0QNQoMmM1g/xyr1pi61CVvCUQb8GBFTbanQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OeBCM+uGdvzGcx4QtKnwnfMIUHyNqGAzfklM71jyP4KGrNFRMuPwZnO6euDvpUjs/TPjLIonWzHL5baLd1hwomHLJDIVHSGtVmaWDYI3manCtpp7gTZfrh1xMc2CF6/ptnHBLE8LlmxMLilbdNnAP9sM//989mi+lp8yeZLOXf9HFQ9Ckp+msusYefJFAbwK0+oBUQf/Bj8uitVHbNfTKYsp8YxRT0rnSwWWbjZh3FPQMoELCD4BE8eiiPbgxkp88QTJ0j9lglNzrsTh9yi8OIX8qjDLyDP79lGmEP91yhXkAkLdNWRWLsQjzzWeT1WsDnGzQrqZ/nhFMydHcorVMvHDKlilQtc0vcDyKUMz4AbwzPcn9IWy8ygXuz9xVvN8ohahK5wNijAJQ1QYTwU2qrwLt/OmXINfCgrGoo39ET+mYCW9NcGRxDiviRTmZp9L
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 07:36:33.0267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b248815-31a7-4c67-6529-08dea8e6b2f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
X-Rspamd-Queue-Id: BB7CE4B4C45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,blackwall.org,nvidia.com,lunn.ch,fiberby.net,iogearbox.net,queasysnail.net,mcwilliam.dev,aisec.fraunhofer.de,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283560-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

The existing neighbor suppression unconditionally suppresses gratuitous
ARPs and unsolicited Neighbor Advertisements, which prevents fast
mobility of hosts between VTEPs.

Add the neigh_forward_grat option to allow selective control of gratuitous
neighbor announcements. When neigh_suppress is enabled but
neigh_forward_grat is disabled (default), gratuitous announcements are
suppressed. When neigh_forward_grat is enabled, gratuitous announcements
are forwarded while regular neighbor discovery remains suppressed.

The implementation provides per-output-port control by:
1. Adding a 'grat_arp' flag to BR_INPUT_SKB_CB to mark gratuitous ARPs and
   unsolicited NAs.
2. Setting both grat_arp and proxyarp_replied flags in
   br_do_proxy_suppress_arp() and br_do_suppress_nd() when gratuitous
   packets are detected.
3. Checking neigh_forward_grat per output port during flooding:
   - For gratuitous ARPs/NAs: suppress unless the output port has
     neigh_forward_grat enabled.
   - For regular ARPs/NDs: maintain existing behavior.

This allows gratuitous announcements from any input port to be selectively
forwarded based on each output port's individual neigh_forward_grat
setting, enabling gratuitous neighbor announcements to be flooded to the
VXLAN fabric.

Regular neighbor discovery (ARP requests, NS queries, solicited replies)
remains controlled by neigh_suppress and is unaffected.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 net/bridge/br_arp_nd_proxy.c | 22 ++++++++++++++++++++++
 net/bridge/br_forward.c      | 15 +++++++++++----
 net/bridge/br_private.h      |  2 ++
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 3205346f298c..5263232278b4 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -132,6 +132,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 	__be32 sip, tip;
 
 	BR_INPUT_SKB_CB(skb)->proxyarp_replied = 0;
+	BR_INPUT_SKB_CB(skb)->grat_arp = 0;
 
 	if ((dev->flags & IFF_NOARP) ||
 	    !pskb_may_pull(skb, arp_hdr_len(dev)))
@@ -167,6 +168,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 		    sip == tip) {
 			/* prevent flooding to neigh suppress ports */
 			BR_INPUT_SKB_CB(skb)->proxyarp_replied = 1;
+			BR_INPUT_SKB_CB(skb)->grat_arp = 1;
 			return;
 		}
 	}
@@ -419,6 +421,7 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 	struct neighbour *n;
 
 	BR_INPUT_SKB_CB(skb)->proxyarp_replied = 0;
+	BR_INPUT_SKB_CB(skb)->grat_arp = 0;
 
 	if (br_is_neigh_suppress_enabled(p, vid))
 		return;
@@ -431,6 +434,7 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 	    !msg->icmph.icmp6_solicited) {
 		/* prevent flooding to neigh suppress ports */
 		BR_INPUT_SKB_CB(skb)->proxyarp_replied = 1;
+		BR_INPUT_SKB_CB(skb)->grat_arp = 1;
 		return;
 	}
 
@@ -522,3 +526,21 @@ bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid)
 		return !!(p->flags & BR_NEIGH_SUPPRESS);
 	}
 }
+
+bool br_is_neigh_forward_grat_enabled(const struct net_bridge_port *p, u16 vid)
+{
+	if (!vid)
+		return !!(p->flags & BR_NEIGH_FORWARD_GRAT);
+
+	if (p->flags & BR_NEIGH_VLAN_SUPPRESS) {
+		struct net_bridge_vlan_group *vg = nbp_vlan_group_rcu(p);
+		struct net_bridge_vlan *v;
+
+		v = br_vlan_find(vg, vid);
+		if (!v)
+			return false;
+		return !!(v->priv_flags & BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED);
+	} else {
+		return !!(p->flags & BR_NEIGH_FORWARD_GRAT);
+	}
+}
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index dea09096ad0f..4a77d0743374 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -230,10 +230,17 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 		/* Do not flood to ports that enable proxy ARP */
 		if (p->flags & BR_PROXYARP)
 			continue;
-		if (BR_INPUT_SKB_CB(skb)->proxyarp_replied &&
-		    ((p->flags & BR_PROXYARP_WIFI) ||
-		     br_is_neigh_suppress_enabled(p, vid)))
-			continue;
+		if (BR_INPUT_SKB_CB(skb)->proxyarp_replied) {
+			if (p->flags & BR_PROXYARP_WIFI)
+				continue;
+			/* For gratuitous ARPs/NAs, check neigh_forward_grat.
+			 * For regular ARPs/NDs, check only neigh_suppress.
+			 */
+			if (br_is_neigh_suppress_enabled(p, vid) &&
+			    (!BR_INPUT_SKB_CB(skb)->grat_arp ||
+			     !br_is_neigh_forward_grat_enabled(p, vid)))
+				continue;
+		}
 
 		prev = maybe_deliver(prev, p, skb, local_orig);
 		if (IS_ERR(prev)) {
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 677cd5d68dc7..377fd0933409 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -605,6 +605,7 @@ struct br_input_skb_cb {
 	u8 proxyarp_replied:1;
 	u8 src_port_isolated:1;
 	u8 promisc:1;
+	u8 grat_arp:1;
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
 	u8 vlan_filtered:1;
 #endif
@@ -2366,4 +2367,5 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 		       u16 vid, struct net_bridge_port *p, struct nd_msg *msg);
 struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *m);
 bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid);
+bool br_is_neigh_forward_grat_enabled(const struct net_bridge_port *p, u16 vid);
 #endif
-- 
2.51.0


