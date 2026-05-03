Return-Path: <netdev+bounces-283562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oO52Ns379mnBawIAu9opvQ
	(envelope-from <netdev+bounces-283562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:39:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CEA4B4CB9
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFDCF30356DC
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 07:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4313A875A;
	Sun,  3 May 2026 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qSlnJkN3"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B639C637;
	Sun,  3 May 2026 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777793819; cv=fail; b=Wx2LHzjesQYwvMape6JEvUUkOHD4eTij0mHFUwYUnVoxXNlrdI9kzIQ+jwm6g8XwagL8GdgI/V3jvApF4V8sD3Ni5v/DzHoonvQKZEkFfj2ipN+nM1XxnLd79YfTg9+OieK4SkWrvLsCdXChfxndk8Br/rZ75W92iuMTewSpd+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777793819; c=relaxed/simple;
	bh=ULKFWBz2jMBEB1m2HlskHSNmrypOLQjxmuyaxsdThCU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sigicS5CJXBktFJQg+tAFhjed1tJF0WoPO1+Pt1E3glVnIXSvGN2jxv8VTP2uMmU2DmNqWNZePCJ/Pyt777bQ9eJLpNf1ofSEuu0xhbDfvzTrBDLSNo3LEAbcPeRe6E4jPetzcViIeo0S2ZArZZO2lm4NqRJYua3cNa1BrQvWEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qSlnJkN3; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RztC99qdfyey0WrXvLr/zqqaLBwAzydf+t+OYgxdQIAsy+C5rmOosxhEO45pp48Djv/YYGSzMieauLT4Ndhlb7az1Sd3nGBVTSuD2D51kRs6i8PQoE4cQMWsfU8zyNT+PU6AWbUzHvbvilqNQ1muEDnFEMk4PpxxwW7QjB3AOboWOGqXCtimdgDEY4Rqv00QV4QxgNaax9D1/0musCTk8N1K2AZBnnpIQQ+2XdJYIAN+/XQ961dotQaRaV7MrFsT1ASSTCx5aSHSWQ8J8cbq8arjkatrjpVtXuM6DxbAw/A08wWjBz0zU+mFILJVoM4SUzsEvGi9Z3eX13Q4mQ7KBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbyWS0WFzKPIHYCFttbBc6Nw5CBuh7twq5Iax0s2tmo=;
 b=ngbqMDGcSQCSGBpmOJ/2hzHHZaPU0SCZ3sYCmdajoAJTpXBLvgW+GG500gbL5xr8t4w/LE9953/bu1WKVQgOiAXy0eKd41Eh3q2cc4dEN7hDl5W8iqsCIKRb8pvUejzN8Cq43j6H3bq8HeN/ldYy9ZywHB3O1WYZnUcFpbLRhnlG11uvtjgp8scGLoKR6D6uSQY8cpyuj/kY6yTHHSJ9KI2s0Ayg5i28ahWGjpywrpqU/4xVpoIdShHvCehNdbYU2c9Alu923TMhBu0LZOEynGIgIFu7xSeqxsD/ekg9LpQGAbeOhE11FpnPhla9U8zMhFEGJX0xkG1Xt4st7R6vNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbyWS0WFzKPIHYCFttbBc6Nw5CBuh7twq5Iax0s2tmo=;
 b=qSlnJkN32438tgCA1OX1zVNHBC9tk7FbHyIeIPYnnLNU4tpryONe0z4Xbvab1BdHEIuZYx9PVj5HxYI5Sh4fNjKaLIwcSfmF3gqIXSJKRQRz3xMe3QDZDLbfM/mhCZR5N8iLujy3qGXtaqXFVkq0CDwM9Rhc+6LwNpKapf9xXWLO8e0Eb/xqjL9dD8QPdkv6bOjDdjwtcwizlqQNSwZdUfRP23V4Kye3Id2QaSg3xHmC9yItcv8BlMDurWX+daCb+6NFkfMwMxsA62phk9W3FBHw+sEyEBDI/7drtTNgx7lpOW0MhXJYcq+qxJXVwy3gGXxoG7Z2lb4WUT7sLs2wtQ==
Received: from SJ0PR13CA0165.namprd13.prod.outlook.com (2603:10b6:a03:2c7::20)
 by MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sun, 3 May
 2026 07:36:51 +0000
Received: from CO1PEPF00012E7D.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::f1) by SJ0PR13CA0165.outlook.office365.com
 (2603:10b6:a03:2c7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.11 via Frontend Transport; Sun,
 3 May 2026 07:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E7D.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sun, 3 May 2026 07:36:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 3 May
 2026 00:36:33 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 3 May 2026 00:36:26 -0700
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
Subject: [PATCH net-next 5/6] bridge: Add per-VLAN netlink handling for neigh_forward_grat
Date: Sun, 3 May 2026 10:35:31 +0300
Message-ID: <20260503073532.2138165-6-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7D:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 084194a5-c0ac-4526-8956-08dea8e6bd7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zL+U/hxFlfjAqJRi4XYCTuq9cmp0EX6PrV1NU1a01SkwhVasqVhBhY6yyfk0vkjAZP6G8IkKkYRzRcYU8z4whhz2fR29K+kLT6hzOuJswowj+cW4oPAfbaHJuqxT3EvceMyBY1Ddjxqz+o4a+A9KoYq1fHI21nWXUusQC6BVn2K8Brd1TzYiEztGfyp+qMxbHwTfBzvJ1cK+HEc/Wo6DzmE9UhM7s8RTcTI2RUIV1BsC4JSNlkhT/8BkjQ0yBZv12XzKYSP1mSRAQ1Wd+IxGlJGn9wMXBf61+YJ9DlgugWQKjJOK3/5Uty7twTye9i7LV4L5669RPYBfBhxzc6M1JbaGFfsoQlIuc8m4VGGWL6ZM0jIq/esoDcggkogiSDFUhJwH2XSuJePcBxeybixJPWgm3QV9O0hJJ0eMmIIJsVnCp8o2tpB5dY1BC7ZziWV9i8xMcTP0pml2juMgvt3wUI3OPcPy+3k/3vujzM2a5TZG6jYendgc2aGxdsMiDJZ3tV9rZGdHuWCYCSHLelgkn2JkMcvpOOZBCs4/DwfERcY+QNvYlKoeXsaCJ1J60cm8fR0J6jW0bd6M6+ez7A4JnGg/dAFWI+Lx9WET/9W0btiRaVj2LG268RNcfisC9xtBUHgo1CCwz3ZJFMKRP9EIrcM1Wd8YNvwLGsZ1WsAM5Uxu9ketWzNaFmGDkGgZgkDWCYAX6ry9oymn9aLXoshWr5EvtyxzM7NO/R6/vqFmaSs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R77SAoUEI0GST2Mj/7qLI1EJPp9xQ/XoMEKHeL4JatJN7pqUu6Vs/u3wOD4UkmG0I4yLj75zxXmEtU8vWoekeg9yQWoiej+ETr1O9p/qbgliLX7PTh9dl1gnCjf2MYB1mky1CTKk8poKfCOc+0puDPwgp/3tddur8AuIjsWGjZGycUBWv8bGz8vTv2of8dItOMln8z93KqeUOeotE3bAdjxBgloT0vUkw7gp9gQhJPv6TCTsykWN9+kaOgPQhY+RmBH6wUUITmJqWCv2rW3RgVfOWFhtPDJdMOCDdGHkFYEzpQTrjsPqt4zc8GTc4FUrqm2twrpT8NQ7DDlTYZLnMDI5C8CyZ7gif+AtwdQvc7hPCsE7eMqn5svQSYIXlzCh0xa6zouOUqVGkeMf/XG46RiUDnI8utntX6tcXURlpqPdrnS/srmA/Ju2dcwg6qNL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 07:36:50.7402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 084194a5-c0ac-4526-8956-08dea8e6bd7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152
X-Rspamd-Queue-Id: 47CEA4B4CB9
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
	TAGGED_FROM(0.00)[bounces-283562-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

Add netlink handlers for the per-VLAN neigh_forward_grat option via
BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT attribute.

The per-VLAN option provides fine-grained control, allowing different
VLANs on the same port to have different gratuitous ARP/unsolicited NA
forwarding behavior.

This enables control via 'bridge' commands:
 # bridge vlan set dev eth0 vid 10 neigh_suppress on
 # bridge vlan set dev eth0 vid 10 neigh_forward_grat on

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 net/bridge/br_vlan.c         |  1 +
 net/bridge/br_vlan_options.c | 24 ++++++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 84a180927eb7..5560afcaaca3 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -2176,6 +2176,7 @@ static const struct nla_policy br_vlan_db_policy[BRIDGE_VLANDB_ENTRY_MAX + 1] =
 	[BRIDGE_VLANDB_ENTRY_MCAST_N_GROUPS]	= { .type = NLA_REJECT },
 	[BRIDGE_VLANDB_ENTRY_MCAST_MAX_GROUPS]	= { .type = NLA_U32 },
 	[BRIDGE_VLANDB_ENTRY_NEIGH_SUPPRESS]	= NLA_POLICY_MAX(NLA_U8, 1),
+	[BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT] = NLA_POLICY_MAX(NLA_U8, 1),
 };
 
 static int br_vlan_rtm_process_one(struct net_device *dev,
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index 5514e1fc8d1f..92af1e558fda 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -54,7 +54,8 @@ bool br_vlan_opts_eq_range(const struct net_bridge_vlan *v_curr,
 
 	/* Check user-visible priv_flags that affect output */
 	if ((v_curr->priv_flags ^ range_end->priv_flags) &
-	    (BR_VLFLAG_NEIGH_SUPPRESS_ENABLED | BR_VLFLAG_MCAST_ENABLED))
+	    (BR_VLFLAG_NEIGH_SUPPRESS_ENABLED | BR_VLFLAG_MCAST_ENABLED |
+	     BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED))
 		return false;
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
@@ -74,7 +75,9 @@ bool br_vlan_opts_fill(struct sk_buff *skb, const struct net_bridge_vlan *v,
 	if (nla_put_u8(skb, BRIDGE_VLANDB_ENTRY_STATE, br_vlan_get_state(v)) ||
 	    !__vlan_tun_put(skb, v) ||
 	    nla_put_u8(skb, BRIDGE_VLANDB_ENTRY_NEIGH_SUPPRESS,
-		       !!(v->priv_flags & BR_VLFLAG_NEIGH_SUPPRESS_ENABLED)))
+		       !!(v->priv_flags & BR_VLFLAG_NEIGH_SUPPRESS_ENABLED)) ||
+	    nla_put_u8(skb, BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT,
+		       !!(v->priv_flags & BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED)))
 		return false;
 
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
@@ -103,6 +106,7 @@ size_t br_vlan_opts_nl_size(void)
 	       + nla_total_size(sizeof(u32)) /* BRIDGE_VLANDB_ENTRY_MCAST_MAX_GROUPS */
 #endif
 	       + nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_ENTRY_NEIGH_SUPPRESS */
+	       + nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT */
 	       + 0;
 }
 
@@ -277,6 +281,22 @@ static int br_vlan_process_one_opts(const struct net_bridge *br,
 		}
 	}
 
+	if (tb[BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT]) {
+		bool enabled = v->priv_flags & BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED;
+		bool val = nla_get_u8(tb[BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT]);
+
+		if (!p) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Can't set neigh_forward_grat for non-port vlans");
+			return -EINVAL;
+		}
+
+		if (val != enabled) {
+			v->priv_flags ^= BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED;
+			*changed = true;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.51.0


