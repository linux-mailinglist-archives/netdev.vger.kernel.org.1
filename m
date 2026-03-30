Return-Path: <netdev+bounces-273169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFQEHX10ymmB9AUAu9opvQ
	(envelope-from <netdev+bounces-273169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:02:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0B235B92E
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6EC53012E6A
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7AC3D16FD;
	Mon, 30 Mar 2026 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ew+RgDf0"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204753D092A;
	Mon, 30 Mar 2026 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875749; cv=fail; b=uJBQqs1DMTz5k02F5CLY7BnZDTEKpPeEeAAvtaJP0D9/P6sjURaO73WQi+t64j5TJi/a5ed/y5sCC/VtBdtwlUSbaXaH9ieNrrwdspYdaFRs244+gWJxrxN9mXgO9NVGBVjF9/mLPS0gFHCQaktRwZIZ6LmwDuzmxvZ/uy3IoJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875749; c=relaxed/simple;
	bh=1WKwHCsN0wmHZhiRLiy04MSsIqEfUKZdCz0ONI7bN3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMZTDTuEPXg3SmBfTKNIwbsAZJwi99QLKDwSEAWW5H5LEFNnDm6vPNerq9gGPNIgRa5fKlPygJG3xqgj9FNm/K7j35XiV5baeN5c0Cej6JhrKWCwx5o38gB4vuew1JieyYQtFFoQAFloI/i/lRt8wlPrxnIfSzCVmKJ0N9MMp90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ew+RgDf0; arc=fail smtp.client-ip=52.101.52.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U41yIKaQVO54+gqahnSPq2w5f8OUcVAOSmFpCgL4YmAPI9M0PJqpHTl7pXjvjtICzMHZt2cRpB0ijwL/1NMlRk7BpbzCw2c9JSNdC1Mf76BQkiRgPJn9xbKpHOPHo4BwihEQVuQqU/R8MM8SkuMiiuSOtSMaYiNN1i5usQTGwfRxPnVkziae1rQlOGWvaHfY0uBHsRCM7SPO5S+mmXl7o+0kuxcGb0hOsxA+2lG4Qz/AIzQCIIWcJkU2RLF6g7ZOrPHbVRWHSKZ+FN1S/IfbY0uf8K55O+YPCJLagAXi7ct56b3Agp/187oZ0STUDvOG/L+ju1zniAEAR0qJox3LFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy8quJrq3c/xMwAeU6PVRAP0gnrlJEGxUvCpMLO9VUY=;
 b=A2X3DftQcYGT6E0aAmFMjY9W7oyBfkui3MGTnHAaYookPu68dhW/RFmhRz0ihgR2+Kcn35karO9tacs3KI6eNTlSM6VeBvScK7RLWewKsHj6IpY2wsimZEveDbKOqbig95N3o8aSwbLV4enLVmWaDQw1MZQF4PwKfGIHbzBL6cuzgrKVF2HCUALVR96XQKdgE7zGmCZa+OvNIpEyWIzBoS4QPUZmotI7qY3qBPbj2FEeFzf19waS0sie59QjsCIsQk8yADowb0tvjb3zb1a0C56gxKgvsCERcOuC1YDJ48cvcmMnMdcAkSlgBuPrYROPP2VEeX0JmZx5W/EdNjLx6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy8quJrq3c/xMwAeU6PVRAP0gnrlJEGxUvCpMLO9VUY=;
 b=Ew+RgDf0bQ+PwXFt9SQsi1SWDQ+XJBBIkQ8SRxFRNr7xoYt4gjNt8IsxOlha9Mty1/qrigL5hqqelpanZgTl1CdfDkSJtrj/qh2xTLSzxBZWvytLc2Gq9C0Qy6D3r1xkWtkqMVSTDwifYkWiz4sfsTn/GOHizOt6/Yg8mXGnHi7NivT0SQBt1TSbjeyA6GhKmVwauHhoFeb3p1edA4/xZSXMAtcu4aFOZE9DU8LeoojwR9MgAlI3uQF+tiG7fuzpNgKOQmmfojv2vMyN9Hq+xd6lA9WgRsDgXtUp15sPKV7/LfLGpYdGoBCwCnBIQJDQ80O0sBiRziptzAf9FAR/uA==
Received: from SJ0PR03CA0201.namprd03.prod.outlook.com (2603:10b6:a03:2ef::26)
 by IA1PR12MB6161.namprd12.prod.outlook.com (2603:10b6:208:3eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Mon, 30 Mar
 2026 13:02:21 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::67) by SJ0PR03CA0201.outlook.office365.com
 (2603:10b6:a03:2ef::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 13:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 13:02:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 06:02:03 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 30 Mar 2026 06:01:59 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net v6 2/4] nsim: Add support for VLAN filters
Date: Mon, 30 Mar 2026 16:01:28 +0300
Message-ID: <20260330130130.989236-3-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330130130.989236-1-cratiu@nvidia.com>
References: <20260330130130.989236-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|IA1PR12MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: 3627dadb-11b4-4aca-7236-08de8e5c946d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	LtOX3/qWbnY2TZ3StP6IH4qaZm1zJ5rRqPmJ17Z3CLMwGmaT8kmI5d31UKZrnBF5pkptcK3m/WkvOYnj6zudNjZk30jTMvniEs09kF7MVqS+XJIIj1tueq7/LZ4plsQN8lUFZbuU3a8zQ1bpvgLfR9EGNhrxLZItzdOPMx9dH4Zm9sNn5zQArx9VE0wpepFqrLbZhJ8Qze7RV5RkpS4iy+n8tORN49FQK+BlT8iZMM2xA2xfQcobIcBhlN6k5Byj8P2B+EbYHfVetwoogsNixPpYs/MRllA6nD+p42oiJQe3+vzinrLLjYB2231jpWlN0Wca3bYBikHM5rKoNbIKA/JW2BLBcVncei/p7yMWYqg1G8eaAgMKM5Uozx69ijaTJ5RjnW+Ua3PZspiugnCETHsd+GXtpD9PHzb9efzR3CylzsFEqPbC9iCT5G/87aA7l2O3EcgBncecDEX9KpIc6VlkV0OCkKYSQdHhIJgHWcnQEKmdgyoaMWSF0kK5wNpkJxpATgZaIs2aE6lePicU+PcIXgLbXquAHg7caf5Hg4Obji6DqA5r7LiwrktF5evspGQB0VqtHwAVq8uatoLA36pF1DXnvfpm5Gz3V+JNjhA5b2jhIxJ+4Dgl6NARmykn6tXZXIecEW3qKCvVlP9hqStNGk81MN74X5bwPuLE6HUrBbKxUwQH4QAHJsyVGFzn86vb5YMQDaTgnWbHCGEjsTGLhaP+4iOLfCmmDFrsLzAG0YY4TGTSsRoyLt0aLK3Ww/KJIYNAvM95rNFICShQ6A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nM8GJx6HmBFCseV55s7XAjnaMvATUWxVaH41j6+1Rg8CHcdMgvSYN24ziZJOV7eWPRwS9skSTeXl3n4a+DQcvtTsJml2tfw255s46VoefqebJ5lyI2WVxDgYvtgBPGWLY/ZjoUC99fBCKqt/7JEFuCaYzktRJaAf6Xzio86Jj2iiLb0h7ZHluE4osFd7omRJCGB3O1U1GeZczo6BOrOucO0m19jqHOqs40OH5X7/p9u4DFUYtZbLE8z8QugoU57b9l7mB0JxDcGWtnsp/IkHWsuLfN3Qtsn8upmqwUIBf0WP7qhMRS8JJYL7Fei9O4y4kSiiQtGc2jV+63BssFSmF1R8hjGN17Remjrxfn4WajoX9bZl3Tf18RkvFERLipNsgpy31m09xNkUPsqfEFWt4ydMABkiCPR1p4fakkx3OBmNx9KGenVXbkAtcwOzPPnp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:02:21.1230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3627dadb-11b4-4aca-7236-08de8e5c946d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6161
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273169-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 9C0B235B92E
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


