Return-Path: <netdev+bounces-286468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BlNBSx/AWqkbQEAu9opvQ
	(envelope-from <netdev+bounces-286468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:03:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9744508CCF
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E866F302DE29
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE67351C06;
	Mon, 11 May 2026 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NJRkG6tX"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013044.outbound.protection.outlook.com [40.107.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F33311946;
	Mon, 11 May 2026 07:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482864; cv=fail; b=En4F13zIEgiyUlaABeINqWVw7it6n6sZQNPca8wbqxoEDx5n6uoWrJvUB8aKLx7WCfQ2MnIlPOx6VW330CAufYmHAcrjFS/eibBZMprRmL4znWCBJEryLkuHQ0KG5hfpE7eldVx3dlgkdrUBxX3bYc/1z6mDQzPOUU2S/xdqOuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482864; c=relaxed/simple;
	bh=WUz1yxT4ykNCKbRqCfnLXVJLLAqXHksJYqT8asqnUgs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ar7KksswiDJclGYQ5u2yOH10s8SFiVjp0Lud0JceQM84cjkPKy4ZkkoyDk4dHUWPUFK1CiC13D+NTpaj89WveT21cw9M66RgG2o8OREXeCc7QqcwVnlUMFqrS1X3GUzlYdhAwEt6+JoBv9+fUGM7BJDH9YhXNMJQsrQzRX+xc8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NJRkG6tX; arc=fail smtp.client-ip=40.107.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxRXsAC1xtmpnrN2BWPjlubcXlQgVvTDE4wLO5h3ooEqjSTqtoMhhlw6FyAouEKMs5HMZeoHD2kqj0d6SzFH22djfLoNOAUiZqYCizUb8cG7jEEUpQBBeVzgmUyaJgC1zUbC5lYrCvPeIbQEkhovKuK8I8vFqLb4Q0HzVD4zMr1nWYPBBjeIKSx+QcMFfkXm+VUoINpWSFL+sxbKX0Cdfl/2xFHWzVKQt5urPDP1npFhj70+6I7nol891LkaMflNf5l/M3u5zti/LVgjjoJVhXm3dGvqs95qrfYGeQy3zz4pyVzNdzmMOICCdgB0PDqq76VmIdDDfIIYWkt62zS77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABJUWCkBmDYfInBmOB1eEFsBEGCLH7RWJq0lHzaZsrs=;
 b=xoYc6HFvZHmGUr+TsTlfaaG5YisCPFMMXCsH2tg9MaUQoFfz/zNc58i3sJGrXIM2szNeSisqWV8ZyKqsBjgNkp5TsWLhf7sbVN0C1PIjdZXiHkf1MCu0cqcNiCjdaT86DaBHRdQFe20U7O73yiXdt3tG9jfJF2bfCMGMWJAI2nkZb4UbLhe1NsvwNpsbPMoGSc1ETtiYMBnU/Z0pl+/x852/aTnSzlh1siZxnT9duH4G8DK96CAuGJunY252xNOcy9dcCZ2yA95U4/60nk64T82NYRP3uX2NeyZ1uEx7wv0ukn+HB75/WJ6QIRAkOVOwyfjDvRHE7AVJ4v/GNc0JEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABJUWCkBmDYfInBmOB1eEFsBEGCLH7RWJq0lHzaZsrs=;
 b=NJRkG6tXnrgql3QV45xCP9iJSG1VE32ol6j5XdC1SXajzbVyDDh2D1eb7NkT7zqaGZvlY002keSNP11Da+DZKrXDY1PAkBoL2e1m3Ll9a2ZF6eFb1FRAlAWztQAJ6NiXccIg+Q/yw1xEKDqefcrL1aPuQMhcw/2Xq0qle55zLbi6pbWyK+CkHEbInlKVQQ2BCYnQQCz5WjStrYqaLRbndLSQBeV2SV9NrIwG+WaVobXVM0EjC6FrSish3n8J8AlewlwM5Fvw0nU9fbKZIqqmY7HSUhQ9T/4upqu0ajpBIWAYy3Fq46qNc+Lj1GEZyjdOfz2PExclW2O4QuxuGocdxg==
Received: from MW4PR04CA0102.namprd04.prod.outlook.com (2603:10b6:303:83::17)
 by CY8PR12MB8244.namprd12.prod.outlook.com (2603:10b6:930:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 07:00:56 +0000
Received: from MW1PEPF0001615C.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::5c) by MW4PR04CA0102.outlook.office365.com
 (2603:10b6:303:83::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.22 via Frontend Transport; Mon,
 11 May 2026 07:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW1PEPF0001615C.mail.protection.outlook.com (10.167.249.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Mon, 11 May 2026 07:00:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 11 May
 2026 00:00:33 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 11 May 2026 00:00:24 -0700
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
Subject: [PATCH net-next v2 4/6] bridge: Add port-level netlink handling for neigh_forward_grat
Date: Mon, 11 May 2026 09:59:34 +0300
Message-ID: <20260511065936.4173106-5-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615C:EE_|CY8PR12MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5c5e77-8400-4e04-fc60-08deaf2b0cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	JwXCUZHOoW4p69JmjAWkePhLKY4UM4hLV4BV58A6b42d1BmPSec4eEOMGkh7yUjPd2cajEUGFRBHtc7qtzfHmn/J0Z/oryLhYfmydNz244pVL0yQKuptgvizDSv+7Qw6hsdzcaUgLgCnz9DpXim2PagTCVw/aSCM1iZ5wBrSKBotC9pKjTwv9U53heFYM8pR5X/NmXCroK/2z2EUFLO8zAqzqILPdEmGggpeHSrmEL91r1EQsVihxu/fjrqfohno6UNBt2f0CifGk7IhaFac8SnMkjp7xknn0GOxCvSxndqpzHPrv2iGRIJRgdETyVzHfh+wIi02yJU/nZl5ROcdpPUyLJCHgSEi74gwUl1ppy4uuQ0zmjhnlDxpvblS0ldgkd4H5rCb/cO5Uh2b/BF6GX87Cgqvlg2QIjhOw9pe5MHXNU9brPR1R6hkxUVEmoDCeGNIRsHe9ZsajtQ3dxRaydkazrg/h5FmKx7t7T060OLkLp3uQhEw1u9CLCSr1i0680wFrtFj03Jym7+EQ/YacRUzzvs09nZ3VjDHAiuQ/+GkLxLAyXFi2zSV2kaIrwzerac5A8HnCm0WrLB1s0nZWm5Mh+WHybPHqERXI/geevnCBW1KpxYqE6XT+NRAcQVJYenPhO/KnifS8AYWdKJWI31cLNMuZ+sxloB0VRdgCbouzP3v+dMI8qfUNYsU+rFbOgVCNCjIECuZgXnu3WGJXdEcX65+CMmvUgoqwmNqOjE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c6X/A0kPE4dyhPzUxMYJSGcROM8+HPpryE0ck6HRF2ju5LNiAlQxH5UG9/FfbQkuv6JdPMw7lFfK5fZUS9tvUQJaJ7xCRqyP4QR3jqm3pSJRq/EAYzjeay5D6bGA2LvGIF3a8niUVbf0lU9PKGiW3GzUfvf4V+4jRCEV7ldOmgV8ibPq+Auyi3PJCyqYm3oznhuHGnFMpxV/Oyg6qS4Xjm/sHwwCDemLii1QHGC/+cdqbUF5cg0mLhoZU4C2F6yK80fItyLheA6e1Ehfiyn0f4Y0s/ZEwFT6X90ZSea/g8Z8Xzx5JZBFG4yIVZK2r3e/Aq1oQwc463MVZaYXKbyufjnDypy3bI2ct5nlrjng5PwKJ3/NLMPDh0Iygtpl+79GES3+wlRHze3e/SdhJEwxPmbYrwK54GNZVjBP9FatHRzqONvXS7xHOD0A5FOInKMH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:00:56.1402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5c5e77-8400-4e04-fc60-08deaf2b0cd5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8244
X-Rspamd-Queue-Id: C9744508CCF
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
	TAGGED_FROM(0.00)[bounces-286468-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Add netlink handlers for the port-level neigh_forward_grat option via
IFLA_BRPORT_NEIGH_FORWARD_GRAT attribute.

The default value of OFF preserves existing behavior, i.e. gratuitous ARP
and unsolicited NA are suppressed when neigh_suppress is enabled. Users can
explicitly set it to ON to allow these packets through.

Example for enabling control via 'bridge link' command:
 # bridge link set dev eth0 neigh_suppress on
 # bridge link set dev eth0 neigh_forward_grat on

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_netlink.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 6fd5386a1d64..898326c201ef 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -190,6 +190,7 @@ static inline size_t br_port_info_size(void)
 		+ nla_total_size(1)	/* IFLA_BRPORT_LOCKED */
 		+ nla_total_size(1)	/* IFLA_BRPORT_MAB */
 		+ nla_total_size(1)	/* IFLA_BRPORT_NEIGH_VLAN_SUPPRESS */
+		+ nla_total_size(1)	/* IFLA_BRPORT_NEIGH_FORWARD_GRAT */
 		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_ROOT_ID */
 		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_BRIDGE_ID */
 		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_DESIGNATED_PORT */
@@ -282,7 +283,9 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 	    nla_put_u8(skb, IFLA_BRPORT_LOCKED, !!(p->flags & BR_PORT_LOCKED)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_MAB, !!(p->flags & BR_PORT_MAB)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
-		       !!(p->flags & BR_NEIGH_VLAN_SUPPRESS)))
+		       !!(p->flags & BR_NEIGH_VLAN_SUPPRESS)) ||
+	    nla_put_u8(skb, IFLA_BRPORT_NEIGH_FORWARD_GRAT,
+		       !!(p->flags & BR_NEIGH_FORWARD_GRAT)))
 		return -EMSGSIZE;
 
 	timerval = br_timer_value(&p->message_age_timer);
@@ -902,6 +905,7 @@ static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
 	[IFLA_BRPORT_MCAST_MAX_GROUPS] = { .type = NLA_U32 },
 	[IFLA_BRPORT_NEIGH_VLAN_SUPPRESS] = NLA_POLICY_MAX(NLA_U8, 1),
 	[IFLA_BRPORT_BACKUP_NHID] = { .type = NLA_U32 },
+	[IFLA_BRPORT_NEIGH_FORWARD_GRAT] = NLA_POLICY_MAX(NLA_U8, 1),
 };
 
 /* Change the state of the port and notify spanning tree */
@@ -970,6 +974,8 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 	br_set_port_flag(p, tb, IFLA_BRPORT_MAB, BR_PORT_MAB);
 	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
 			 BR_NEIGH_VLAN_SUPPRESS);
+	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_FORWARD_GRAT,
+			 BR_NEIGH_FORWARD_GRAT);
 
 	if ((p->flags & BR_PORT_MAB) &&
 	    (!(p->flags & BR_PORT_LOCKED) || !(p->flags & BR_LEARNING))) {
-- 
2.51.0


