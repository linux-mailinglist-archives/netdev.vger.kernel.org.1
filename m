Return-Path: <netdev+bounces-283561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9DPcFxr79mmlawIAu9opvQ
	(envelope-from <netdev+bounces-283561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:36:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 620BA4B4BE0
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 09:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 823C33001FA7
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 07:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C26346AD3;
	Sun,  3 May 2026 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bpjcl2pq"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C81F39C637;
	Sun,  3 May 2026 07:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777793813; cv=fail; b=lNA6JfB1kTPJWe2OLZQY/L1s6yjLmd6C3pc92mrJPi2RwTK8Wz/l9uRu6vxgabvEKiuhZxiZ8AUu4WOPl6uX2aMXkZpk6/BV16+fqmeoKPPMxh7ojMnG4DWbvWvUbkbOZRZ+koA1iyLpzZfG9a5ijqsTL/ROZv7EUpXZbZqgtjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777793813; c=relaxed/simple;
	bh=VeQh0DMuZN47nKFIXhW1qAyXZnuAVvzdSQQXHZ3u3zI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgcicqNZS/r11ZqFbRhSKG7w0IITJrOXDhI/awV+mIGfWTd72KVbN9sQRkp7p/ace4V8G5+ynKfAwPiUU3UNfssG1vqC/kON/ubPcob680Z/hdD15PQwZWYLW98gc885k0SqVzwVcqcdqzuZERLCrvHHnBiVmBvXeS/fJ5YinzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bpjcl2pq; arc=fail smtp.client-ip=52.101.56.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lp9wXtrkr00RTh2eGor3nRs7gDNftIkWfCL495jlcqoXnCtVoTD3vs4RS7rhPYkidsT5aS+6ZsXsB3+UrIfBNDAxKJ2mMexdGDxIaR4gK21Q4bAdkyc3KS4cTExD5LqvKZScD+YZar4rTVb/MlHAozvO/yVQMR4c68JKwQBESOFsX1xJxt/xZOlz+dID16IGW3reMO0na9LHcujlf4oSGvQR41cm2HZn4NKBDfpKIMdUtPXnfncmKaHBGhofQmt97ODahAUUiKszwSxLKtxQlIGxYQ8Q4lEE6m+tOvwqfmiAK7eYaG3YM/RO8NibWPfRDUj5KgHiFCgGaRtxAcBhDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dw49qPSgmu0x5WXX0KIs2tqpUeJisfZtuMbMOCrgQEc=;
 b=YriOZYn3R4NaO2h9dJ6jzoKolNDtwNUVW9ye9e8CfEW7pMo7TJBuqXw5z4DESP30sIp7ly2LSXIGa0qHKhzsZA9HSNE7Oxzgkc5XFoPQvyWy24/25LCEOZ1ssjpEmJHhMskyEAEOu3wMvqDKZyWz3fZyARNLRbGiSS+DEDvGe82ycDl9EJF2hGijjUS6PJc4cmZaqtHUa4oWHdDymR/q/OEznHgam/Y3dqIgRitarxhWxCUurgQPo9OpJtN55H4VwIb5DTT11lEtBtQhxGjyyMfPy9ALrvPzqYqbA/3kQYfCezYiJMVOJjLAIWfx0gmdJzmAGG4jZ+DBL+chL1kYyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dw49qPSgmu0x5WXX0KIs2tqpUeJisfZtuMbMOCrgQEc=;
 b=Bpjcl2pqew6GFlNs+luhJdd2znlnFg5ssgaBOGIUe2F1lPg1jWzf/SMnRm+m4xNAX9b2P78AM2JGUSP33dn4odRVDIoYuiNx6ao0BbWCUpdcflOpKMp3PILHKN706rKfJH0BgIstq2HzIgzFJnrYnt/cMhGjj80FeAcJoF0avDrv1Fe3e6Nshm4MsOsV4CNDeK7PHhVZxnDpU751aMDvCJqHkC+2fQeXyhUikRhOpA4g3t4Gaou6uzDfgjv9BeYOvcXrfWWOhHMgIz1sTcaoqIRKXjeQ6FZhPxyKVVZYrn94h1eXaHVPQc4V+lKhIApeUx77dfm6SlkIJ4I29yBZ1Q==
Received: from SJ0PR03CA0108.namprd03.prod.outlook.com (2603:10b6:a03:333::23)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.24; Sun, 3 May
 2026 07:36:46 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::4f) by SJ0PR03CA0108.outlook.office365.com
 (2603:10b6:a03:333::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Sun,
 3 May 2026 07:36:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sun, 3 May 2026 07:36:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 3 May
 2026 00:36:26 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 3 May 2026 00:36:19 -0700
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
Subject: [PATCH net-next 4/6] bridge: Add port-level netlink handling for neigh_forward_grat
Date: Sun, 3 May 2026 10:35:30 +0300
Message-ID: <20260503073532.2138165-5-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa4f58b-dcec-45a0-2255-08dea8e6ba63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iM2JDKmT/OgAIFHU5dYtgsQHrv//LuqwwCuZKMhIQ6peOBZTmvBpyixybWg9v3zCti1qJXlZTbGAulPaUGd7OmfONouARSVL8kV01wvzTZXmwqbRGhuk+i3qVS+zJf7Ro8UG5FJ3YHTp5evKNiJNG4qjccZSyM5lNhxUJ54C1XQTy5XioyphqhzE7sep0UU9hHpGn85Yzrjrh/Iza91ZjkZflvcdHcEnt3iPZyVT8bEF8ALNRldsNXz8/p1taQEqpIFnzbwjXYKwEpXcxDb9IIWq0JtrAC4QvOvuMbDgFHhyRG341MsTE2eAKvuyghFu/aS7wsJV9+OvABesYvEstDy+CLBFpEhYbCEGz3vmL95A6dtjgXRfhnltR1mavYN192Z7i61sCQaEoq3DkK8h1kKB17PWOmlwdl1GhEgHZGAf/E2hwp1SlX4qgVavPrGMNw/z6SFOUAjwE1bZAZIaJjCheTP6CS8A/17f/JCSeB6H4w5XkmNVJ81Y2vTbIoan0kP+nYBivH7f9Ri/aO3DsnRwbGkqrmgnaln7bMoabisUK6oUZbov0xS90P7EK8W4TFOojvNgDHQ5XlFDIbtXEjyXpihg/CicxdbDFqnADmD02VKIMNqGvhtBMIHH2qTCsMoNFBKgTuLhPpEHJa7bULehz7RpYFnweWGA4nvtwNkQN0wJkctHptDqErryHWIk8yB3A7Ukz+13oHu7DE8Ddbnua8Cs/myAxA1dC76ZuzQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L0bg4Q1nS4K0ocsHNW+1EM3CzFKM11W9a0MSP+yomurgjOi5RBxad6QO11gq5pDmkAt85LBscVxa9xSAS7T1p3jX12U3pUInYT7gQSIoRSEvG0QOxQmP7IRQJgT7kSBSLTbECMOtnARLFMhwHKn4/JeHfHi3aED1QZMFolBNOplIw62gTX4UtLAElZoQL7obax4MtPcgg+iENmNszz/mHMsLwx+NZPmWA0td3J+wE6nxMA5ldhgX/Oa+XTmP87Vq/Jaegy963+ybXULUxNEpSTdi75oRG+bGzQAufEMPMyWSwbpTFwPvpMC/KtURiJrT6NpDQSf8ggGkBT1kJ4CKLNZl2Vnx29t1v828rf9quJAhpNOWDjUmNfRn6wYasJsc19C3Sb0QN7jZ9r9qpBs0AnFMH9cpv5Yfy+MJMTAo470KBnJAzBYv8lwlTNh6dt0A
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 07:36:45.5009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa4f58b-dcec-45a0-2255-08dea8e6ba63
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751
X-Rspamd-Queue-Id: 620BA4B4BE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,blackwall.org,nvidia.com,lunn.ch,fiberby.net,iogearbox.net,queasysnail.net,mcwilliam.dev,aisec.fraunhofer.de,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283561-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]

Add netlink handlers for the port-level neigh_forward_grat option via
IFLA_BRPORT_NEIGH_FORWARD_GRAT attribute.

The default value of OFF preserves existing behavior, i.e. gratuitous ARP
and unsolicited NA are suppressed when neigh_suppress is enabled. Users can
explicitly set it to ON to allow these packets through.

Example for enabling control via 'bridge link' command:
 # bridge link set dev eth0 neigh_suppress on
 # bridge link set dev eth0 neigh_forward_grat on

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
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


