Return-Path: <netdev+bounces-286469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CD/N1N/AWqkbQEAu9opvQ
	(envelope-from <netdev+bounces-286469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:03:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 615B5508D03
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C35B3011790
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301B4378D94;
	Mon, 11 May 2026 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ct7IwxBu"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010004.outbound.protection.outlook.com [40.93.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B531C3101B2;
	Mon, 11 May 2026 07:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482869; cv=fail; b=htygCwEHueAM85VhVKy1n1uiV5YGxUQ+5UrNoh1Ste2XULwnNi9llWZUIX4OvT429SgjyAfZFp0jh6nxYSb9gAmo8+mO4RWb1I0iqyfQRXuYndUCvKogp5xBsUyukycSgDUmqkgCewU+4d/NGwR3jx39Wg+A0mkju643GC2I1hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482869; c=relaxed/simple;
	bh=vGNU0JevTnTDrC9MWva6R2uLVamxu1dnEw8iWmauQhY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaY7WpLQuE2Q8K9sX10eHs+3mq/QUr2vbboBj4F4r6uBA3MJlbVcvDZyCHQj3mrbFBjzrXdE83U1IVqva2ajm4YhdqDsqlJ5gSelLqM/gGOV2sBISnKUy3lvxvm0VpUgUiNaD3I9cqUoo9uwr0OWF71XJ8ZmlUvlPvs+NjXwu7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ct7IwxBu; arc=fail smtp.client-ip=40.93.198.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWHptCYJQGiaVuCn3vLMhOeod1NbaepLs+n2hctute9LljuEZ9PsuqWK5R3KCwl0RZoFN2ybX43tKKcatdmgqOCmDexLevzWo3KRJWYjVfc2E2aytC6DZ212yedGcwTKEihv8UN9JA02qJwbIgZVCffHsHe0cJN5Z+kh1iBacUAjj0QxG7zqyFDOAjQ/63rslNRdsplGLmbXjUjL/rV1pDLX/Yy8SytmjwFXiTewDEaT3ZjLUh7F8lojZavIr21hyJGb1E93yN3rTptY6xjM4JwWz676Yjokopd3DJWgX68Ne2Ox9FXukbMcrdX4TuxOSs0kyjOcg323DCGMAjeWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIDIiLmqJFLi2pHi2Ltz4ijW8P6I5BzUajVLt7N56xs=;
 b=jUOyIV8TVpQTBVbM8lLL8TcVkxttdhhenFeZO4JdnrNqJLuwl8QRSdt6O0EjMkGG3mV3yn4JK6nQIiZ+F++SGdDrM/WOKQu3UC+OzuMu5Yrf+aR0Yij2CwLD4k21ZSRxXzjcKtrKvI2qkBUy8lfW3tvj3UyuLKPiIQh4qsPka4Th0SCEagCBUi68MNNP2wWsMvF7hwj+bBZ47irz5zIblZdFCd+u7fdhmiLqomX7HKnBQTViAp8tnKG3eROg5tXqGtZjr2CJ9VPk9FNeY9uC7DYCVoO+BKU2x40ufdrxriewYRTisi6CVV+o9f6LdGT7fRTavKYpXDTBK5lOmGngJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIDIiLmqJFLi2pHi2Ltz4ijW8P6I5BzUajVLt7N56xs=;
 b=ct7IwxBunCN2JlxmYDKfbGdYxm8e1MZwHRnYeS6XEewZ+5iCVDlEMa67acNGSKdq2RNTCPe9lw/46fvYJ8vF8WETf7D0BuEO3+Ebyl0MNXT1jeyQJknHBtuDP+Xy01XZ/uv1uTNtFVC7ThmrA+GblMtMX+9QaYPN4+xwsWj2U3sv7V3obdWm+t5Qdjjc95/oXKD9uU0Txz2BCET5XU+5P0NWfoggDSFEwmKQef5K/gC3d+VMxDeBcp/VMs/CNQ9oMltuxuiMtacjep69KYMVvr4bcTlBLVGKVcD2KndXXfNTVtFdNiMg6FTHvpHfDK02tFzZkkftckmYboCjgkZmLA==
Received: from CY8PR11CA0044.namprd11.prod.outlook.com (2603:10b6:930:4a::9)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 07:01:00 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:930:4a:cafe::d9) by CY8PR11CA0044.outlook.office365.com
 (2603:10b6:930:4a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 07:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 07:00:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 00:00:39 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 11 May 2026 00:00:32 -0700
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
Subject: [PATCH net-next v2 5/6] bridge: Add per-VLAN netlink handling for neigh_forward_grat
Date: Mon, 11 May 2026 09:59:35 +0300
Message-ID: <20260511065936.4173106-6-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|DM6PR12MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: 0828fe78-3309-44dd-90b1-08deaf2b0eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|376014|82310400026|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3lv02rYopf5LtAiHr5yTT25ulUDdJtOzNq56d5Mq+liXqlczDMz8fEA2of6iEGpcXLFLrNdE1w6SdGIn0OLzptiu0iRRxq0At5W/dfdQPSEToucH0kCgdNo5G2a4jR9GD9Vu+jbLzqFvJzx0idYpGopQEdv5TkGuK4Mqc+EwLVhiGTeEC456c8kOMVFuXnzW2AHjZXkhasyJC3LqXSwU7p8oF1VW5AEgi+JbzcNQFDZ4eFSHLnIIWZ6T9k3qiwUpMjssEDh+cCJzvQa46bbzAE0SWWwATkV4Tfn+wlshLXK/gFIqOWrobPtTbYXWdiaxtClsxSfvgIVmRhy/7/IJTJ/AEgPplPv5MXvNu8suMJ3tYMvd9XvtPVD+UeKfMn823OK1w8orcJN1hH7DrdMTafwdVKsQQiOGh3VBuy27mN03EkPJEuLMbssEYJjc3GObJ+mO3lnzIR1fmIfyg9zf8HauwIV/twwLmzIApCg8XC6eW98a/s0yhXJx8BTXPRLryKYzi9zdXMo/YJMfmoqzGMcjjalU0OrLvI4rqY0GSPqohVlstJaeQfsYctj/02HC+PFPtcQHMowKUEkq9ufMsfztNr89sD0Ic9jQ8m7RM0hKSM/ojaFYeJ01C/dGphgn9XTslU6EQ4O6RNjsCl6q+aGk68E7O9+BfaCxS0QrJHGWvE+mI0u1ndRALBW551lwo1mgE26gb1ZbbtViEl9CHLkF3cAYmRUOkeKUar0kVVc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(376014)(82310400026)(3023799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2Db0bYST6UMKcI5xn9mSpL2YMxvj15PiO+HJwx6KGxmQ2qWxZospbwr50F71DpCc3j/IeZgOfHuPrJdN6+AJBC3kMVflzLwSluim9wW7I1p5QFC7V3GTGi/dv0Avkmfv553Rim1oIEN22NQiecT5pLN4LJuToL58P/xAf0wBcPhx48wom87A5XQNqZt1pPXp0gS1glvssYErg8SGgjHI4IULAixWQFD36SakTez0UpXLp4v2e/+eegLcOxNJ0V/tat48iNJ0y3WRF2ACTJ5QmSSFIwFtXmKKiKyZ2el7lq9x93oSi0/IpKyy70zsICOQEB7RoyZjzfJB0kGtbUH0Oyitz6lveCy/JNfJfhIzEOK8aqAgkabDwTCDWRSWIRzevOLTn+xmMbB/2bAn9JkLDk6hrOYn90VIT707IoDAitYDZtjsdIwH7X8PyZAIj8mK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:00:59.6312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0828fe78-3309-44dd-90b1-08deaf2b0eae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
X-Rspamd-Queue-Id: 615B5508D03
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,blackwall.org,nvidia.com,lunn.ch,fiberby.net,iogearbox.net,queasysnail.net,mcwilliam.dev,aisec.fraunhofer.de,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286469-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:email,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Add netlink handlers for the per-VLAN neigh_forward_grat option via
BRIDGE_VLANDB_ENTRY_NEIGH_FORWARD_GRAT attribute.

The per-VLAN option provides fine-grained control, allowing different
VLANs on the same port to have different gratuitous ARP/unsolicited NA
forwarding behavior.

This enables control via 'bridge' commands:
 # bridge vlan set dev eth0 vid 10 neigh_suppress on
 # bridge vlan set dev eth0 vid 10 neigh_forward_grat on

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
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


