Return-Path: <netdev+bounces-276462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFcwLjRD1mkFCwgAu9opvQ
	(envelope-from <netdev+bounces-276462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:59:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB133BB9B8
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 13:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1448310587C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 11:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4453BB9FC;
	Wed,  8 Apr 2026 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="faIb8cf4"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550E93BB9F2;
	Wed,  8 Apr 2026 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649259; cv=fail; b=dIJ+AOe6dZSIxhO4979M3Ef6XJFGEWxPSaKkWeabB9IoGlWvZojeMxBcJ2loIHny176RLIT+IoKWKWM0FPT8xAjmiR6qD1OxaeBQaIEtWgVYE55r5QLqIh6YRX4XUsOwBUnQ8wkQrZjIg5sDahtBxtdTe9rnkFLkbvldOr10Rhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649259; c=relaxed/simple;
	bh=1WKwHCsN0wmHZhiRLiy04MSsIqEfUKZdCz0ONI7bN3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wf9baJUwZNP+9pLDN3gXm7D0+mi3ym4gN6ubj9/0EOkLO9xsndAGXFDfZZmXl6vOneqMTisQ7kPvtAzUyy6eepp1qXt2ryi0AfWhvcQuseV4Ie2WOM0un2QcjYNcb+Ft0Zz6PwoZgqzYrikt1pt5ejJvzZWLZg5+XI+7C9Cc5PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=faIb8cf4; arc=fail smtp.client-ip=52.101.85.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7rvufv3D4kpmygqxlWOyRbX7S22zE8sJ8CWJxfbOUpnlROLLOSs493saXn0ByN7e/LGOJ5xiPehWLQHgP7IWlbhguHQuC4Pt8Xh7d/WEQLvURbARQn+HvlzhN58TlHGonBGS3F4iVpGiEAZ4wryMZLItdXagzJtga176K8Z2rBH1WcD2zLLo/r/0USVHfu2vQ09JDp/aPkZbwRwgHrkmXf+m+Ff1Da4eiuPLIw7w2TdEHXAhbe/K37Y0QEt9K1JAMzNK3aOMah+XfUjEmzZ4jOBQS3KV/+5w5GfflMF2+/Gg/PbvmraWE6Zf8U/xvmezlb6dc1lzcBndg3BpXvz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy8quJrq3c/xMwAeU6PVRAP0gnrlJEGxUvCpMLO9VUY=;
 b=dkcY4qqrTYPc5tDy0MvYpebYKdsq6q2at8rZucXjkRd7CN0cJ6y75McmZm//dh9RkueuZ2q5qRAhC4yLU719zkOzyPU7ueoZONmyVYdONtoNkvPlQx0NRnVBUtp7YojXwTeEcC/Md72ZokB+ilkbSUtnm4/YK/5GLJYN/jQukXj8rpAYh463aUGxrUWr6Tnt59U8BJKKXaE9tfr3qLZf3NBSnx2wyZwC1WFonUEwnpgcyud5PyDkGLEJ6bwG+GK4eZKLd3irogjFPbmZ40CNCxc/r+YCnq153nBQ57QnaBhFpTbVwEq0kvGrLrYHquqZ5Lbqyg3JvOwyp3WAPGJbiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy8quJrq3c/xMwAeU6PVRAP0gnrlJEGxUvCpMLO9VUY=;
 b=faIb8cf4CM5CSajSUkCr5tR4YrGIMZDPxxZyeOZVjjylxyvPTHuXnU8Kh628LOE8U8sonPpJ5WedzCbdARaT60Jy7UL3kxqd/cQ24Leqybel4luVRHiSFt9UC04c2nD+v5AmybvoGIxCPUW0REX8iCb4HC7KJ5noq3fP/zzPFIpXJqv+DELLDzyk8CXpfdl88wqGPSZWhK3Uw1PA3AfHJQ3PARqJnhGXPP9I5umHc3Q+pYVwiJHOyAas96wZcJdRwNGwF19+2Nub8gfR9B7XMV8rTwWeJWwFkb6dFgghouT2qaiJdVqHogPPwQ9bupHktbTvIr4GmXCln+sES6dU0g==
Received: from DM6PR03CA0005.namprd03.prod.outlook.com (2603:10b6:5:40::18) by
 CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.16; Wed, 8 Apr 2026 11:54:13 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::97) by DM6PR03CA0005.outlook.office365.com
 (2603:10b6:5:40::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Wed,
 8 Apr 2026 11:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 11:54:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Apr
 2026 04:53:59 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Apr 2026 04:53:55 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, David Wei
	<dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH net v8 2/4] nsim: Add support for VLAN filters
Date: Wed, 8 Apr 2026 14:52:38 +0300
Message-ID: <20260408115240.1636047-3-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408115240.1636047-1-cratiu@nvidia.com>
References: <20260408115240.1636047-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b2f8e3-55b9-4dbb-ae47-08de95658d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	V9d7W8y9GizFs6fpRp/B4zUdqXTFcsMFG3V1rOdzw3hfA1VhnQYu8dIOuRrDJu1wWBIiFFKigCZIMSUHTskGnKTbC/GTy4e/vdRkIPdTmQ4ilCvhMGOaF7jg2zhJyJmv5xJY9AuYszuttjJcQn/kYgBq6/jXoTE0Y7UHJn0LCTSbqm3WoTF7hi9NyIQ2dCFvFMYJ4HsdUtKX73qImfMWdXy1wa4OMEBjMM/yQ0IGsM7D5P0infq3CU7Tku3e/eOtlvgm/lP90RGxHnqV8qVwH3r2RuwlJUzevXK1Odr6vH0iGL/N8Zo6yIYruaUy6bbUNXI+PMapACz7nKqwV3JoFKEM2GDPnBEU7kIDxgZy3tS1k0HkM0ziqDpQoFfWqxnJlKWkHIX0hhFYTv45eKQFvA9M89HCNILpswELbFAS3AZY/MEY/E4zC9BZjThNO/QqRMMUq/ZdcU/0l+5TbNGA6UEIKjxt+CvhO4RjDHk3nJ/K/7xkyW/vDvT6Wr6wU49VPjKqpbQ7DCEFHK17nxJD90iB2d6Mukv+ZI+2jMhKgNJnUR83wj/4hHnXfwVAL9fmpz1Gr0TIfjxnm5cOQavnYRXi2UZPCwAFp39psFS8JrDIfCgUvVEbtGM6a22TJ7V/32OUBdoQ5ghNqKGC8pc0iJZWTKx+RGjUXszfmRTA6F+KoYfBG1xzMu1CpA7qnns/oWevfKKIjl2hKL0Qc3LlkyUBzP1iLZRdbIVUToYlBNmuWj/Jb6FgnY/2GzE6voj9+i7bhopWy3+LlN6d9q4xqg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DXn5exFMfYd8J8kziBoL0ccieSG4o49xBg99msUpMb+UpuMQ2QY6yIXzvWH8k09at0qXt5he4n6pZ0xcy4JBZ0odLqOTCUmgZ3IlivK9ICKeLUkH10pq7fsWfPgwoUykjPV3RpXvxlrStscG5ujUr4eZBsIkKTr2pj6LphwgcOkYLvWpm9SeCpM3HehyS1V4fhz7bvPZBHd83z5VpfsU6+AfFA3wSPeWaW9lRVLk10bmJ6aksDTsrAlQg0HDto0vpv4jnagIylq3s2sQuXtoRv7HDoxYO1xsAA6EyeMA+A4CnQGmTh0+6Xq0YcFMu2lV89BouZg8snJTj4AxblCWu3w+Yie8sqz3v5mKx4YIZ43ZWoqwI2PyiTeimCSOqSg3EoIpKZ0NLTgsLtl94HCbHgdfJ4OVddLA5X45fCYskOAT+gUaDA1zUOvdeab/WZnN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 11:54:12.7697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b2f8e3-55b9-4dbb-ae47-08de95658d5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276462-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 2CB133BB9B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for storing the list of VLANs in nsim devices, together with
ops for adding/removing them and a debug file to show them.

This will be used in upcoming tests.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/net/netdevsim/netdev.c    | 65 ++++++++++++++++++++++++++++++-
 drivers/net/netdevsim/netdevsim.h |  8 ++++
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 3645ebde049a..19b0ff183c45 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -605,6 +605,36 @@ static int nsim_stop(struct net_device *dev)
 	return 0;
 }
 
+static int nsim_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+
+	if (vid >= VLAN_N_VID)
+		return -EINVAL;
+
+	if (proto == htons(ETH_P_8021Q))
+		WARN_ON_ONCE(test_and_set_bit(vid, ns->vlan.ctag));
+	else if (proto == htons(ETH_P_8021AD))
+		WARN_ON_ONCE(test_and_set_bit(vid, ns->vlan.stag));
+
+	return 0;
+}
+
+static int nsim_vlan_rx_kill_vid(struct net_device *dev, __be16 proto, u16 vid)
+{
+	struct netdevsim *ns = netdev_priv(dev);
+
+	if (vid >= VLAN_N_VID)
+		return -EINVAL;
+
+	if (proto == htons(ETH_P_8021Q))
+		WARN_ON_ONCE(!test_and_clear_bit(vid, ns->vlan.ctag));
+	else if (proto == htons(ETH_P_8021AD))
+		WARN_ON_ONCE(!test_and_clear_bit(vid, ns->vlan.stag));
+
+	return 0;
+}
+
 static int nsim_shaper_set(struct net_shaper_binding *binding,
 			   const struct net_shaper *shaper,
 			   struct netlink_ext_ack *extack)
@@ -662,6 +692,8 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_bpf		= nsim_bpf,
 	.ndo_open		= nsim_open,
 	.ndo_stop		= nsim_stop,
+	.ndo_vlan_rx_add_vid	= nsim_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= nsim_vlan_rx_kill_vid,
 	.net_shaper_ops		= &nsim_shaper_ops,
 };
 
@@ -673,6 +705,8 @@ static const struct net_device_ops nsim_vf_netdev_ops = {
 	.ndo_change_mtu		= nsim_change_mtu,
 	.ndo_setup_tc		= nsim_setup_tc,
 	.ndo_set_features	= nsim_set_features,
+	.ndo_vlan_rx_add_vid	= nsim_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= nsim_vlan_rx_kill_vid,
 };
 
 /* We don't have true per-queue stats, yet, so do some random fakery here.
@@ -970,6 +1004,20 @@ static const struct file_operations nsim_pp_hold_fops = {
 	.owner = THIS_MODULE,
 };
 
+static int nsim_vlan_show(struct seq_file *s, void *data)
+{
+	struct netdevsim *ns = s->private;
+	int vid;
+
+	for_each_set_bit(vid, ns->vlan.ctag, VLAN_N_VID)
+		seq_printf(s, "ctag %d\n", vid);
+	for_each_set_bit(vid, ns->vlan.stag, VLAN_N_VID)
+		seq_printf(s, "stag %d\n", vid);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(nsim_vlan);
+
 static void nsim_setup(struct net_device *dev)
 {
 	ether_setup(dev);
@@ -982,14 +1030,18 @@ static void nsim_setup(struct net_device *dev)
 			 NETIF_F_FRAGLIST |
 			 NETIF_F_HW_CSUM |
 			 NETIF_F_LRO |
-			 NETIF_F_TSO;
+			 NETIF_F_TSO |
+			 NETIF_F_HW_VLAN_CTAG_FILTER |
+			 NETIF_F_HW_VLAN_STAG_FILTER;
 	dev->hw_features |= NETIF_F_HW_TC |
 			    NETIF_F_SG |
 			    NETIF_F_FRAGLIST |
 			    NETIF_F_HW_CSUM |
 			    NETIF_F_LRO |
 			    NETIF_F_TSO |
-			    NETIF_F_LOOPBACK;
+			    NETIF_F_LOOPBACK |
+			    NETIF_F_HW_VLAN_CTAG_FILTER |
+			    NETIF_F_HW_VLAN_STAG_FILTER;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
 	dev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_HW_OFFLOAD;
@@ -1156,6 +1208,8 @@ struct netdevsim *nsim_create(struct nsim_dev *nsim_dev,
 	ns->qr_dfs = debugfs_create_file("queue_reset", 0200,
 					 nsim_dev_port->ddir, ns,
 					 &nsim_qreset_fops);
+	ns->vlan_dfs = debugfs_create_file("vlan", 0400, nsim_dev_port->ddir,
+					   ns, &nsim_vlan_fops);
 	return ns;
 
 err_free_netdev:
@@ -1167,7 +1221,9 @@ void nsim_destroy(struct netdevsim *ns)
 {
 	struct net_device *dev = ns->netdev;
 	struct netdevsim *peer;
+	u16 vid;
 
+	debugfs_remove(ns->vlan_dfs);
 	debugfs_remove(ns->qr_dfs);
 	debugfs_remove(ns->pp_dfs);
 
@@ -1193,6 +1249,11 @@ void nsim_destroy(struct netdevsim *ns)
 	if (nsim_dev_port_is_pf(ns->nsim_dev_port))
 		nsim_exit_netdevsim(ns);
 
+	for_each_set_bit(vid, ns->vlan.ctag, VLAN_N_VID)
+		WARN_ON_ONCE(1);
+	for_each_set_bit(vid, ns->vlan.stag, VLAN_N_VID)
+		WARN_ON_ONCE(1);
+
 	/* Put this intentionally late to exercise the orphaning path */
 	if (ns->page) {
 		page_pool_put_full_page(pp_page_to_nmdesc(ns->page)->pp,
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index f767fc8a7505..f844c27ca78b 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -18,6 +18,7 @@
 #include <linux/ethtool.h>
 #include <linux/ethtool_netlink.h>
 #include <linux/kernel.h>
+#include <linux/if_vlan.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/ptp_mock.h>
@@ -75,6 +76,11 @@ struct nsim_macsec {
 	u8 nsim_secy_count;
 };
 
+struct nsim_vlan {
+	DECLARE_BITMAP(ctag, VLAN_N_VID);
+	DECLARE_BITMAP(stag, VLAN_N_VID);
+};
+
 struct nsim_ethtool_pauseparam {
 	bool rx;
 	bool tx;
@@ -135,6 +141,7 @@ struct netdevsim {
 	bool bpf_map_accept;
 	struct nsim_ipsec ipsec;
 	struct nsim_macsec macsec;
+	struct nsim_vlan vlan;
 	struct {
 		u32 inject_error;
 		u32 __ports[2][NSIM_UDP_TUNNEL_N_PORTS];
@@ -146,6 +153,7 @@ struct netdevsim {
 	struct page *page;
 	struct dentry *pp_dfs;
 	struct dentry *qr_dfs;
+	struct dentry *vlan_dfs;
 
 	struct nsim_ethtool ethtool;
 	struct netdevsim __rcu *peer;
-- 
2.53.0


