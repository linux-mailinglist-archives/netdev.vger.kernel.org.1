Return-Path: <netdev+bounces-261771-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLylIkVeoWmksQQAu9opvQ
	(envelope-from <netdev+bounces-261771-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:05:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CD21B4E60
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2D1F30F322F
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E1538F924;
	Fri, 27 Feb 2026 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TqQtjvlE"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C236BCFA
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182993; cv=fail; b=ejZmiQfUTAXePOjc+1LiAXOLvjAORkUZCNq56KwxuMeRaA6v9UtziJGpe8wPCEn/Le/V98ynkONk+3omA/KxENoSx3eQzjPTkhpGIJ4Imd/VXGrscD/zs5hiyvaWGoGrpdrnlCxZmFOF/BBcch5ak+ZlWEJ7t1cksrFzX0smBYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182993; c=relaxed/simple;
	bh=AogaK5luZg8SQKo+0siKlas6OU2ELJmby5XQWLgDBd4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUbpiXDVOjYpSP5JsBfy3DgrVBcjgk/tclzxQNPvBx6KM6d/7lfm/YycIMHMjmtGU49X43NKJxoY+QpdBt9qonx6TsuyD22j6QELk2zb+rWVIHC39rFj6SkY+wqwy84Krb+3UuwJWckFdE3JPgwgYm7FIyVExPLTaaCqqwnHsYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TqQtjvlE; arc=fail smtp.client-ip=52.101.43.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMZJLfSetDtulCMH8EbTWGtFb2iGEWO2q9P23iog+M6ThxbfKRENdtRZpS40Vmgald4NL3hla7CQc7qhMTkaUx4IbayXealPkqBCIfBNnofmMxuwxVmqJdnBNjhSl6Ad2iEzH91ei65kGjPZBuS8mcdegvxpHyCKuUp2k158eOESL7D92LdYcVpb42dhKlcWgzfBJRBRACYKIkDKGrvjkRd8EBpOS0ckUrCZCb56TdDrgJjLIIcfD9WbRxrG+JqMMc/84ZiD7L/+9lSEUk4wRFVuvqsh3xNwKFHFmI2fciJj6HkkR3OPsgA6dnpioL119KloTfL4SxqA3G9mtnd/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzzBDSjyZP+QKVivhJ4o7zq1sCMnrqulYTWxtn/NHc0=;
 b=yPl+WPfJvu95a6fjzIJewkG1dfiQMbmVy+XreFz0rm1gl/H4kHs2X+MyUzaaLt2Lx9muaW36ah6cUEGE6vQszy1oAX9fdQzXEGpkiwBafrVj9Zn5irI0jUzbxoUiFslZ+PUJJNHFAx6jbSi4mlEo3LQtXib66jJfUcaFBLxIZ2i166lNjfv3aJ8U68phlyt5zF1qBLxTile52H9nXWbFMxcBWWIFnh8zhvCOboewYAYz6Mr87sL1pl8W4kOPzO+3RvBm/iYDhvaufBggFozHxGdOiQPQEFDBN11Y/bfrwwkDdAv/lpkHa9ZnJq5kTcFSFSYOXJfxcEXjBpthQfPGkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzzBDSjyZP+QKVivhJ4o7zq1sCMnrqulYTWxtn/NHc0=;
 b=TqQtjvlE88t1BuDqTH7TNc6UpyGWAwWQRQGpQP+woMcSlMoF38FK3zs5jlZwmBY8wkbNBY7eKz1F/G9Wi66FYirl5I1U335ff4D5hAUUL3u42OiF2fJ/jIA7VjilZ9nn5DMy4wqhvvx8QWa6o1nOrFM4H4+97fwbek1T5mlKExkWxTjHjeazm2qVd6s11t6UcPmrSIphsVRor7Yb6nDXLkKN5TLOC/fTAk8B9zLADbdIzbXtj45LQJqNXI3+5ghvfAI3xU5doTbaURZbXbAtGLVAJJr8jwUae8qdoZYM8cbF8UnuUeJRI3LNa9bhL67uvjWyBgH7VD3GeRT6cT0q0g==
Received: from MN2PR05CA0057.namprd05.prod.outlook.com (2603:10b6:208:236::26)
 by IA0PPF6E99B1BC1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Fri, 27 Feb
 2026 09:03:06 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::fa) by MN2PR05CA0057.outlook.office365.com
 (2603:10b6:208:236::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.0 via Frontend Transport; Fri,
 27 Feb 2026 09:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 09:03:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 01:02:51 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 27 Feb 2026 01:02:48 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next v2 1/3] nsim: Add support for VLAN filters
Date: Fri, 27 Feb 2026 11:02:25 +0200
Message-ID: <20260227090227.1552512-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260227090227.1552512-1-cratiu@nvidia.com>
References: <20260227090227.1552512-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|IA0PPF6E99B1BC1:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be5c21b-8dce-4fb5-4703-08de75df0543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	6lUu3xeffuJTEwVcIqrzXd3qFLQpeOz72wyEJBNBc6ZhHpcZu1irKmNRuIf4nDlEc+AG57kJ78hLFx1HeakByMEQDquXmcJCU/WEOIv9PUKazZ+OT1wjgjKe8mx27V971r8P15Qc8aG9QEo3m+y6H2+W8ng1CP62s9q5EjxmtJJ2xeEdr6sGLjQ5LOZn+f7FQ9AzEsAGC3SvbXi9hamUxxdbT6+vwTncWROjG+R8q5EkpBpjqM+Vj0gvAvlfp+dhn61ueR8O1JlhqjpGjSjmKjQJpvnNfCQTAI/mu6LFYoUwhJysUrRtpreB/Ch6TuoJtVXNujTDXfKXN72HiM+2IR3asTUmhzIISFGXqhs8ZEWZtT+TstFezsb1OY97VvA8k3JwqjR9QUkOQIFHRdi0/PfXFDID00G/ogVSPrttVrj+WqpLUiAQhyPOL66xBi3QSPsDiWz0FveAOPJqp9b7Gjufwtx6BK5OHCF4c0gghEG33rJ5zNNPdCegu52qZITG7OMVZRvmrhwL6HcLirKt7TU0RHtlf7RifgAPZIdEmTXjPXh4LdZ8MiUyqTZEDxU2QrGuUkz7yJQR5m0MiP5acQUNYx6l7PHayWHNTLlpbUiIQf9qLlZ8AoGuKD7TPPac442OAHidN+1yKcfuSXXmhgsifGjnCCVgupYI+N0N0JHVcQuCt1J94/4FG0iJdc3tqGbH9j9qKZMcMRtj5i5sNlckgLcMu8gFfmcKq5QcyCtlXTpwEGZe3flAKO+Rdv/RDnHPdT7B4Oc0vKW4YbsxaO6KNfXVEGIjQtmqgVF44qNtTBf3GsYEBfy5mKTh5x1LjYb/jHgDXSW8chpShhKDNw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0/QAMIx/Sl5gUWjiv5Kcr8+OIP7XlO5qWdkwOD597cosZ6eDmrTBV6Uhg09EJza5cpi7zIxobeBlHn1F+s0SyyJXuO0M1ShDHnsF9nrFZimjAMfJ1E8iN9ia0x8KDQvEdYqhNBXDpeiZmwgma8dKgGkbRIsdL2RJ5RVPOrrJa5DZFXzX5PLlm2Px10RT1Qtqy+BzNm7KaBOCF2uvHN0CUTw9YMO2Kjnlu5s60g5CoJG4X2LnbV5EaCttAr2wrRT9Ny8nsPxSKvhPI0oTzyiHy10prVNQjXIvuWnoeJUWCBMBjDrfVbLlXiNp/HShtdiFwtOfiM6fw6nDGuoFDqRklpOmfeCz5cYq7i1mB/die9j6x/1EdlWzVTKNr7DdgVrQHwfH7A3/PaBfOM979wmGrkm9A0FuElkqU4YC8wHlE8/UP8X8vVKPHEu1NKLfpsF3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 09:03:05.7727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be5c21b-8dce-4fb5-4703-08de75df0543
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6E99B1BC1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261771-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D7CD21B4E60
X-Rspamd-Action: no action

Add support for storing the list of VLANs in nsim devices, together with
ops for adding/removing them and a debug file to show them.

This will be used in upcoming tests.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/net/netdevsim/netdev.c    | 59 +++++++++++++++++++++++++++++--
 drivers/net/netdevsim/netdevsim.h |  8 +++++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 6285fbefe38a..7177711cf9fc 100644
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
+		set_bit(vid, ns->vlan.ctag);
+	else if (proto == htons(ETH_P_8021AD))
+		set_bit(vid, ns->vlan.stag);
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
+		clear_bit(vid, ns->vlan.ctag);
+	else if (proto == htons(ETH_P_8021AD))
+		clear_bit(vid, ns->vlan.stag);
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
@@ -1166,6 +1220,7 @@ void nsim_destroy(struct netdevsim *ns)
 	struct net_device *dev = ns->netdev;
 	struct netdevsim *peer;
 
+	debugfs_remove(ns->vlan_dfs);
 	debugfs_remove(ns->qr_dfs);
 	debugfs_remove(ns->pp_dfs);
 
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


