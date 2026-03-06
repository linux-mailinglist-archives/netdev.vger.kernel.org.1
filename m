Return-Path: <netdev+bounces-264840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE2OE3nvqmncYwEAu9opvQ
	(envelope-from <netdev+bounces-264840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:15:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D091D223986
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43494306514E
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABAD1DED40;
	Fri,  6 Mar 2026 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F1BRcx8d"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B533AE1A5
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809861; cv=fail; b=M2zrc5pH+eAl/OY+UCddaQ5EcV5jAmT7GdZW6Cl7N3Qp3aGv9tdnhudB7dw+iFNSOL26n8iuGyyBmuZoTx7g4r0l7um9eSfccKkblKF8NGBWkEehxQjIZg5pPF0APjwb+r7mvnLIUcSj7v2qV7j7DyZQPnFCsiQDDkX1ADbZfLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809861; c=relaxed/simple;
	bh=ocquqVZG9QUKnz6onIVJROG6d2o3llES0InzuffDszY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IkQMbqDSqXDlfbf8JGWtJQxnkJUTwY8vT9pnJ+yR7z+7PsEeqg+nwEMH4uq8P9NG6TaOm05pcUIk72C9HMgL0Dygwd+e66xztpJHEaVXQRJvsQdw92WbIaj1/C1LZecUU7hACjUWPObxd99C8VBRRjclC/oUL5TCOz+z5H5QHn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F1BRcx8d; arc=fail smtp.client-ip=40.93.194.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfc4Gwf0z9JuAxIxElt4ix1jpjw3UZM9an8JanytAOffws95rVVyle4NTZFEHnSQfqN+oyaHRv3p/+9lMPuzABk+5C02J3Xv61+ODbTO9PkCP6Ik4P4Iv9TO9q7lnnsgRz7GNMM43txQa1mq58bBkBfj0VvdR6edSi5hHp0/GPBKeiJw1+7qXzJST5091g2jCYi8SFlkatVNovbZ0r9jShfTGBuQkzULIcnuwQWo1VGCzeR4Vz2sJct5KpETZ6bc3J6xTxzZ3bb9WSkzviHcSMITenTbeYfV7x6+xxgxPqgcDNx8iK8DqbcNL/OwF+zLSv11GDv4hJ86D/cpybyx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfGi+ss6E0jUnRqzx8lSjo7VSnHXIj2XA9K8lUMe5Dk=;
 b=eE2w7kzS+XwyLZfOb5+bi4lDOXkUknVvF9aoddIUJd3l1Tp37IHpQAY37v58yAa67dilYN+ablZm76Rwjjn2l6xHgVml2s58erFFDFg0fwrypz8o8Ib5z+M9C+B801aYw9dLvtbrKDn5+mEyNTrIRtqHOEzGjHnU+LLIiKU6FXdeyDgHfEEruqqWqQ/2VgmLNTI3QhirboAVm3PkFBA65LH8BO1jeYUbZKtNy5u4whK0OGBfxA6uu3TV3hBbSL7btZ7+zgFGIyQRjEGaaRkKSZV9VfXWCUhUYDsNcg7LBSPITlu8UJp+uoquHvT+I+pEWLE4YjAsL9KSuh6JAPu97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfGi+ss6E0jUnRqzx8lSjo7VSnHXIj2XA9K8lUMe5Dk=;
 b=F1BRcx8dWRx3O5vMTYkEGy8q0z1IlZRSgLxMYLHIybvoQqjtFqETwHPD9Dum7GEW+JdCUe+K52lr1FmiKQ4rkSTQwvTwCOEy0S68QfirvHpqnAHHhQ+8CVsXrfpvFpZsgItEaExLoTHSJ+wG0K8FcAp5zqt9S9O4sP4GQPo3xd9fS1+a9qk7bQ4Z5mNkz+ph31jBPV79jlorvVp4aZ+2v6OH7qo+R5nOn9wp8YBZpl1fwn79+S9IH2rqsWeazeZU5fJNYph8lvzoow/jhI0vE4nnrjJdM4HYRHDyXjSQplmPxwmDWqMnHZk5s8a0Bod3+RWq3MkBGfw9xk9BXuXOww==
Received: from SA1P222CA0097.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::24)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 15:10:49 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::96) by SA1P222CA0097.outlook.office365.com
 (2603:10b6:806:35e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 15:10:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:10:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 07:10:25 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 6 Mar 2026 07:10:23 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net v3 1/3] nsim: Add support for VLAN filters
Date: Fri, 6 Mar 2026 17:10:02 +0200
Message-ID: <20260306151004.2862198-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260306151004.2862198-1-cratiu@nvidia.com>
References: <20260306151004.2862198-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa36698-1e92-4928-cd4e-08de7b928bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	Wr8FZKYgQlZsQ1MyRgiyxmjJk7iruvE1l0oMFPY1agZuZHqhfG/fMtVFkF4wNFBpBkbnkQYC7JCnmTI4jEDwABHG7Zhk06NgOklrY6aD70zC/xhBgf5Mu0emwZ9Rhyttly47OTA5yiKE86PRHIkWAMZYXPK5KdcyZUuRBd3pFgP3yAc+omcWYRGbA3v56fW4iNngUlyV5P+Pyp/qMLxoXgontwP+5wxIlJtygTuXnn3CDd1umeSR5Hl0K3hW6S4gcmUgmjzVSLqS1VZlWMkjibNBNWYtf7OWSyGMUpi2EZhlLsva9fb0ne0WkruLK+3azQEP+me5fl1Kjb4C2BBE10QbNAKf5tA+G6OQvKowzGE74AQ/1v8v4KvVUkRGX85SKHFzoED8NjRPfN3gRoq7w1Ny8KTwAJk1p1cj9DbWzUi+KTy71bCt3kLNKB6R+Ncjgs9PskAFGEZd47BREThJ1jgEHRQ9DjAhm/cEZrxEWR2fjp8IwxlY5nMvzsmd3TSwY1fEgKq4aZ0LsS+fz7OAtFV5HfCopJPWyb8PErCZ1afK1hq13bJNlaQKnWT21Op25vA0avvhYMEL123PMjkGfb6u/odCfOTtn9ljSw8ZF2vCSKT38u056dmCFiWp5uN/3tTqQr27XwnFrJsrjbDWwnMoqXzOpVyjf00aZit/Fg33Z+zFFBD4bMoxwrVw3u8pQrUhVH4kOO+Nyiw3QQK9wwHJpXH22vZO+JARSlxcMk7ZcdD6SKc6PFBwAMah27qiyJ4W7bTbwMVA6PcuPGAxHQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FxYV5dNHeql9qacrGS6Qnx85r8kEdXBG328xZE/XQGNmBgzO7TNT1W3u+Ni7tUa0ljNW/JHSYiFJ5l4HlGga0S8r8AkvfnAPEINWugaRs2yaI4ETAa9AnI7+1NLLg3fVpqJVS1flLRmXwGoc6AT+KCfAOneM3feeoamG0oI8h5Mu/h/YZIMor7UEOThVsGqeyOXe+ut65H0Adc6x1zaBWXnAlMNs1HuB0nox9NEMd1hw5VseBF1+yignICJfDlxnooM69XTPa/+po4JY8y2fFR6Cr2g98toesrs0XHfKBa6WumCACbT66jBqPO+hf7Tgove2NTYaj+/j9cnknXkz+963CGvhWBWTRZDQddtNwJnA6cJDaH7LrLzRtlZ3IoSEGq7fUMb2LmPI7UsSz5pc/wWfsKajh0ImH+SmT9aqUNKu98/DyQXZA1poCiF69M5e
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:10:47.3269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa36698-1e92-4928-cd4e-08de7b928bd6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549
X-Rspamd-Queue-Id: D091D223986
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264840-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Add support for storing the list of VLANs in nsim devices, together with
ops for adding/removing them and a debug file to show them.

This will be used in upcoming tests.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/net/netdevsim/netdev.c    | 65 ++++++++++++++++++++++++++++++-
 drivers/net/netdevsim/netdevsim.h |  8 ++++
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 6285fbefe38a..33c6d1719db9 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -602,6 +602,36 @@ static int nsim_stop(struct net_device *dev)
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
+		DEBUG_NET_WARN_ON_ONCE(test_and_set_bit(vid, ns->vlan.ctag));
+	else if (proto == htons(ETH_P_8021AD))
+		DEBUG_NET_WARN_ON_ONCE(test_and_set_bit(vid, ns->vlan.stag));
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
+		DEBUG_NET_WARN_ON_ONCE(!test_and_clear_bit(vid, ns->vlan.ctag));
+	else if (proto == htons(ETH_P_8021AD))
+		DEBUG_NET_WARN_ON_ONCE(!test_and_clear_bit(vid, ns->vlan.stag));
+
+	return 0;
+}
+
 static int nsim_shaper_set(struct net_shaper_binding *binding,
 			   const struct net_shaper *shaper,
 			   struct netlink_ext_ack *extack)
@@ -659,6 +689,8 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_bpf		= nsim_bpf,
 	.ndo_open		= nsim_open,
 	.ndo_stop		= nsim_stop,
+	.ndo_vlan_rx_add_vid	= nsim_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= nsim_vlan_rx_kill_vid,
 	.net_shaper_ops		= &nsim_shaper_ops,
 };
 
@@ -670,6 +702,8 @@ static const struct net_device_ops nsim_vf_netdev_ops = {
 	.ndo_change_mtu		= nsim_change_mtu,
 	.ndo_setup_tc		= nsim_setup_tc,
 	.ndo_set_features	= nsim_set_features,
+	.ndo_vlan_rx_add_vid	= nsim_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= nsim_vlan_rx_kill_vid,
 };
 
 /* We don't have true per-queue stats, yet, so do some random fakery here.
@@ -967,6 +1001,20 @@ static const struct file_operations nsim_pp_hold_fops = {
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
@@ -979,14 +1027,18 @@ static void nsim_setup(struct net_device *dev)
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
@@ -1154,6 +1206,8 @@ struct netdevsim *nsim_create(struct nsim_dev *nsim_dev,
 	ns->qr_dfs = debugfs_create_file("queue_reset", 0200,
 					 nsim_dev_port->ddir, ns,
 					 &nsim_qreset_fops);
+	ns->vlan_dfs = debugfs_create_file("vlan", 0400, nsim_dev_port->ddir,
+					   ns, &nsim_vlan_fops);
 	return ns;
 
 err_free_netdev:
@@ -1165,7 +1219,9 @@ void nsim_destroy(struct netdevsim *ns)
 {
 	struct net_device *dev = ns->netdev;
 	struct netdevsim *peer;
+	u16 vid;
 
+	debugfs_remove(ns->vlan_dfs);
 	debugfs_remove(ns->qr_dfs);
 	debugfs_remove(ns->pp_dfs);
 
@@ -1175,6 +1231,11 @@ void nsim_destroy(struct netdevsim *ns)
 
 	nsim_psp_uninit(ns);
 
+	for_each_set_bit(vid, ns->vlan.ctag, VLAN_N_VID)
+		DEBUG_NET_WARN_ON_ONCE(1);
+	for_each_set_bit(vid, ns->vlan.stag, VLAN_N_VID)
+		DEBUG_NET_WARN_ON_ONCE(1);
+
 	rtnl_lock();
 	peer = rtnl_dereference(ns->peer);
 	if (peer)
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
2.49.0


