Return-Path: <netdev+bounces-286467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA3TNRB/AWqkbQEAu9opvQ
	(envelope-from <netdev+bounces-286467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:02:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59934508CB2
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A86EE3011A65
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA6930E85C;
	Mon, 11 May 2026 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BHEcwgvA"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010013.outbound.protection.outlook.com [52.101.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E15285061;
	Mon, 11 May 2026 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482861; cv=fail; b=ZqZjj5pgYBX4t/x59wWN5D5vP9l44BNWx9KxoGFpe3s9zsrlCBr0aFscYElr1CpPIZOKKf20qtzPVqvOo8OztMECO/LthekLu7H4EmstbOK7g/VxdOn5E88EMTvjXtnteCLf9Lp5rnsqcJCT5wfx7gnIXFDn/TpvRle6yOqGl6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482861; c=relaxed/simple;
	bh=XrJ6DMMWBb6ebXvfJpweaOiXqsZKpS0E3+uDH0jrWyM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHtzNrCiWh9jJwOyn6cx0SgCH208P9TG+qEsIC6wYR/S65/+/TwQ5GoRm2bmDjDUx+2T1oRKjCxYNO6btlyohV/zubck89zjRAuM2jScNtuQ+1FaNfHVi8LdaGv8WOhQutbbUT39UdJnof3MBDtLDGd/DMDXQyRoHhzYijfF5u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BHEcwgvA; arc=fail smtp.client-ip=52.101.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bej3g6qg0vr93AfC8jAivbnV6bo+xphuwijbuVxheXHs7bJ0oIy41rBg3oBBL4XMTZNt3nIVmNB9a6zmc1NRq2tqGpfmy+gCH2spbiWdgpSdKr9iGCT5phqSqOVg9U1+Yyz9JZJITdUqTyk5cx/g7GKgP3rqVBtbTXUKKRoN3Oa4q+QzmryMN3Snozes+6IvsalAWg2Ns7oQQaaQdfWlYVwhi7DYIGoT1QufGPmOR2+dYEyi6eCk4voxCzHhB1pstGZL7z6Y4Qm0mWjoK7nItCy6R8n1MiejGHijtg7yQWEaLBJVH80JuvfzUZ339X7uH1WKoLDiXrRoojCu0iBqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYYl9AQUkhnbP1gc8J0d1hAIQxaDEnJXfB0Oa/yJPcA=;
 b=dUoJRinZ3Kpt0QjoYaeB9Ap8sn4jejjE9yhZNl706vcpghgoa2dy0aupqP9u7lVD4NVQ7Zng5FWbWroPnZCwpyckY1qvbgzhEWGJZeOMW1hMQU11033WQcl9gFkLJzdUs1NYW9I9/gORkjz6W+ArE2sKYPH25rKPXhwG9HPJo+6Ro50augho5pMdTj0JwqZT+fYfGENkMhkWxt72JFSMzaWVzjFXDLgALOUhltQ2r3yyxCkBrJZtGNK9BpGoT+7Q943JWuEpd01brdboHPJEVUyqps0l3xs8/XkfyoIkThm0RfkZnKN/yeEpLwF7oZGNlGp8ONdGZpwGS8FsxlWBqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYYl9AQUkhnbP1gc8J0d1hAIQxaDEnJXfB0Oa/yJPcA=;
 b=BHEcwgvA2r4i6caKB2CQF37jWV5PViU2BqVCaJijRB6oex3JCwN+YcJliusQ8Q3jRCa8qqbX9v5/RabwncYndLpzUYCHpkYs5MHNjDIaqZ6QweyH/kmQRQcn650X38ObpQofRn047R2utzsmS3EDJnvdwSttdiAJoWzDqMXbYlgfA4GE7bxtfUkpNxyay4+xpt7ufZ4ivGbtbaq4b9VJs0ZRWe6XAmMW9Sr9l9TfLSXV7XWrYeojkJNxEMn74Q/vDD6Qi91GVhZcevdMKQO0dp140hCWL6tMM+3iMHL1mPcxYxQT4PlPwR49cGtKxW7HpWU9vz+wWFwYTl/jsafzRQ==
Received: from MW4PR04CA0096.namprd04.prod.outlook.com (2603:10b6:303:83::11)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 07:00:48 +0000
Received: from MW1PEPF0001615C.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::f6) by MW4PR04CA0096.outlook.office365.com
 (2603:10b6:303:83::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 07:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW1PEPF0001615C.mail.protection.outlook.com (10.167.249.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Mon, 11 May 2026 07:00:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 00:00:24 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 11 May 2026 00:00:17 -0700
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
Subject: [PATCH net-next v2 3/6] bridge: Add selective forwarding of gratuitous neighbor announcements
Date: Mon, 11 May 2026 09:59:33 +0300
Message-ID: <20260511065936.4173106-4-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615C:EE_|CH2PR12MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: f72dc890-ef1a-4179-d140-08deaf2b07db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|56012099003|22082099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	5FaRi1lLnyTEpB5AGU+kuDKE621MN0hKqs9D+k1Ljb9r9ZZPZhok6u+p1z8J8HkHa/m3T0wXiLkwtdpVl61/Qm9xDTqQOzj4CsZ0X8z1KlsS3XCwjWHDs550MCDA7hPVZyfNjTn+7vlPNqVsrrJxuVqc42mf/kpas5pFpRIUzFKwG4jVCqX5gFHje+yHSSvfSxn14HXenifgGbIL2gvV1AzkhGOu/SsBaim5CgYtBX2vQOwV9NVUSzgcnZSPH9kh4GBsH7O7vKy2NnagkiaefIZ/QF9nNGVkGm1JYbHxuZHpMVC4YGrhgDJYdrTnHaSsfJjBddNlPVMcWYTqjy4r/E/pirddU+ZQ/x7HKud0asATROI8vaqf7do68gAKXDOm2Uwp+62DQOXP4+hEsrmuEBnbYjYA/PjmLQFIHhzCvp98qlPctfTwbsf83gHpO1OpGiVlscgqw1U/e+hen9qSTvx3yYvo3WnazA7sxfmXeVQ193++2wDqebIHtzyRT8gFok6oUBy8h6tSFg6eNgV9XTZ+qxR2zy5sLwsw/NKRUq3KMqWEUstDLsSutqz09W4l1d2c7srC13WLa2A8VntBVPutXwpJ/deAS6r77LxkgQQcrcTaAevYf4tOFL7XzzEdjIwudeRyiXMmyPRxTzSb/t+OHMAoFFpysAtc9bJ8Mk5dfHuwLeFc+fW5n+qf2hBkUMFeCxxfVCeMMhwN8DCN/gxNa2xECTSZiGGoeZUe2gk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	19+2Xhvze2O85NgqeHoc75Tem2ldTsd1e3YvFU7bRYikTvVZTLz9d8uvRYckZSpyro4ncxCrX93owJvBR1KSkG/V+3HO9FLWYRzYO9vEUormnWYr/AB3Z6pHomx1Eba8GsJsp2y9DpT2MjZWvb7GfvGG7CBnLxMK2Vu3uMk6hQrnYIQpgmztQRWq3z6l7HiXcyGNeNsIFUpeEGJ/hjZ1+s6UA5T2b2T3kW9J9oA9RVlRO0ZomGtsa6M/n7MDDxJdTtP0qe0R40p5dCDZRm+C7WKGVRV+dP25oPdSHNTX7jwRwKiUigACTvvoLUbL2IYKozeEhIKxwe+Vx8aF/7zuZkJvwkqDY+3xRxRH4B/veZOmitJCrfKEFE2GC2qc6w2teaO+ISnJKzmwXYH/Wcy8fXhjeztzSsCMALsY228K3yYdFYwPwl4r0nzQIkgAwGgv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:00:48.2054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f72dc890-ef1a-4179-d140-08deaf2b07db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200
X-Rspamd-Queue-Id: 59934508CB2
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
	TAGGED_FROM(0.00)[bounces-286467-lists,netdev=lfdr.de];
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

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
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
index 3bc15978a8df..02671e648dac 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -601,6 +601,7 @@ struct br_input_skb_cb {
 	u8 proxyarp_replied:1;
 	u8 src_port_isolated:1;
 	u8 promisc:1;
+	u8 grat_arp:1;
 #ifdef CONFIG_BRIDGE_VLAN_FILTERING
 	u8 vlan_filtered:1;
 #endif
@@ -2362,4 +2363,5 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 		       u16 vid, struct net_bridge_port *p, struct nd_msg *msg);
 struct nd_msg *br_is_nd_neigh_msg(const struct sk_buff *skb, struct nd_msg *m);
 bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid);
+bool br_is_neigh_forward_grat_enabled(const struct net_bridge_port *p, u16 vid);
 #endif
-- 
2.51.0


