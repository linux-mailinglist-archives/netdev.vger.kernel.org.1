Return-Path: <netdev+bounces-274473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KQILLZPzmmjmgYAu9opvQ
	(envelope-from <netdev+bounces-274473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:15:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A248E3882D3
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D7DE3014A21
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3223AD538;
	Thu,  2 Apr 2026 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GAXq6w07"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5775E2E1746;
	Thu,  2 Apr 2026 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128290; cv=fail; b=aeeT04WCTjAcZ3n3Beme3TqJwYDMUjsXftS8rCOELNthTlQ61vdWYiAbKRow6Yh9aVPt19toJVrYnhIniITiZvfrInZMAjiIBO6+sIocH+shLdqRLCC/T94h90+Bep4KEOYON5ZLIA8LenDAg0/2hFoN5lXipuEhL3TVO6wLFv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128290; c=relaxed/simple;
	bh=1WKwHCsN0wmHZhiRLiy04MSsIqEfUKZdCz0ONI7bN3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRFjlwUMhtnjOJyE09bMWPFECaTEDg59kB4gJGpjnzUtgWXZ92xmZ/c911MhUmGmLq5breUi4jbqi6jwJl3pgPh9GMoB5m/HpQCpExSEhrqTeOTB/2nZhXwIFRxDPFVDdZnA9/eQwOh3whs8eMrxe+zrjqGz7j2WkDt67kreiyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GAXq6w07; arc=fail smtp.client-ip=52.101.57.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCwgMYw/voEJrURh9lUE8C8/Uvit5JiqUwDa96+w6Hm03s1HJYtGbd4J16sztropgLfG8yqH+1hikhnlQeBfnzQ9VwbeqoG86HwfJeCfp6i3eFCMO6OjTZt+TCVNxSFbdRUJKTVjA6232TPSEvqsqW8AGs8Erw+5wiNi4QdX2+VAVYYIVbr5khUYmuc4W88hG8c3hP3Y+TRlscRhcoVmM3m1os4d/SW1a5FzM73TbedXaDqMgv1toZjparuQM/5Gh4LbiCCYEMK8NlxxFBGTmcS7P8FCAxtFd6Vuu0EIpeiOQGSneet5tcOFP7Zcfxn8C1EuLVY3PqXEjEt6hmAl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy8quJrq3c/xMwAeU6PVRAP0gnrlJEGxUvCpMLO9VUY=;
 b=EXQCE/arTUKIDdA/TpZeMqJqKMKau5BpsMohsxXTqka6HRN4r1c8YOlKKxC0hqmNXAs36EsnH1EIdmSdhsWMCTyGWh9G2p7u4WxVIo8LkfqESij+mB1y707ZgdKK3UhmUfoMF30jwn9mvaCClyagpihWJ9eAH6vPzj7GlwX6MQSQWRnj4KLAs+MjYs/ehOmUdDKRRcYyOg/Ebwvh5FvlETpGSbnyvO2kh4bU4mzINzOwc0b4BNaW1c9neZyiFOOfBkUZsSjFtS5UQHgOhibSfsvT3KFqD4WS81xAmOKS8AJajZhnNY0lt2SKYFejQMWOtllXp7tX9mEOuXcELfr6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy8quJrq3c/xMwAeU6PVRAP0gnrlJEGxUvCpMLO9VUY=;
 b=GAXq6w07LpJM4frmpBxLFQwdfzJKtITC7W9cjTfsWxAdd4rjVLn3dfatJRjYb12BZrXAlzqg47X+xy/49YEo1v3ScM87ltd76Z70opvZKM019fVZOpSMyypZWoi/wliIyz2ZJ1HDEctN2LHhudNsFFAebR7+H504VVIqs8lD1Mm0kkN9cxVPgaP9SQHr/nCVgYDeGd+0HbQeWN5tIdcy/i+d+J/Dmf/29T8ulMvk/l+e7TDOkHs8a9RCmYOrJhABrpqKWJxFBELMmW0izZPgOHSssQrqTZdhqjaIaFIz55x4IejLSGbzcEWLig+dmmHPyHEunTvUyh/7qxyFAiJFJA==
Received: from SJ0PR13CA0017.namprd13.prod.outlook.com (2603:10b6:a03:2c0::22)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 11:11:23 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::fa) by SJ0PR13CA0017.outlook.office365.com
 (2603:10b6:a03:2c0::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17 via Frontend Transport; Thu,
 2 Apr 2026 11:11:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 11:11:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 04:11:04 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 2 Apr 2026 04:11:00 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, David Wei
	<dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH net v7 2/4] nsim: Add support for VLAN filters
Date: Thu, 2 Apr 2026 14:10:32 +0300
Message-ID: <20260402111034.1494714-3-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402111034.1494714-1-cratiu@nvidia.com>
References: <20260402111034.1494714-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: 932e4241-745d-4022-4e6a-08de90a89340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	O6kvcIow43nduiBB/UvpDnQHc/MRHIzD5Fryd5r8/abfiG+CXd2uSLq/Fa+mjrEEb39FCJ4IqJz17ad/pvxjCv4EQD9+puYP8pqAHs7hotj0epzOK+dZXCfbtdOMnFeBtW0OW+fv9pXdQyv0Hx6Km3UUdU8T2CkQ/IDnoutXJuNZ45AKChWX0qPCv4KIFhnqEERoMaH2dhXYRUsamNY5v1fVabHfPPvIrhKrUCUA8lKAVA7v9XJp8SZV6Y1ctP1ZpwHWxOaY3aBOZizzx3fr5A3uNELYVOT6cDkUpFOrJ+egGKHhJ33ZeOGz+6Ud7MQg33afSgqbWCd43Pc8en2LRuro3ZiNhPhMq3I/QkazAa6netE4MKmIbCrZ8Douu9KwS+sFBWY7XgOBjaYfFQ9o/xzntdLq9ggksO2mdj/RLSuW8OBxFVK8a0ze+ZUelIOy1DK3ES5+/0cp4gbwXGUy469w1nwQoDcEA39WfPuXSA3dCbJnJ7dtfqo+vrIkLvEIrtfLRBl9+gdvVo14gIJnyYI1XnefkypVABZyt9MI+0G6UZNlNk7C5kwb7VH74rxlBH59ikiv6+02Jsts86z3b4Wfriazl6S4AvVaW9CXjVLCwK+Gtfrxuxb9u3gy0mLh8BOVFGuT18NhkSQIdJfPGvk5y3NY+rxoPWqirZdjaoNk/cHE5YnSuLnMNhlj9X0CENM5QP7tuw6JsQNX8KbhaU2MHEsc9JexRI5RJJO7slFdrZux7YMO+u4o2kKbJ65VMcTFtUvdkXWLpp+zr411Rg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FGVZbR9kmg0QmO/hqVUNhdmrh6wlDXgrEjUZwmfX17K2Fj0DkOCF81qgVStlMrUdk8MU5h9SAuCAlI8GvOoH4WoRl8qeHgo/N38vk5w4o/zwsqQyIg6Em6GFz29/x/+UGytF4XRQYASNqQc/uFVp/Eb0HLusVLlTLU3i3i3SHA5Np+AmsF3KkIb16iTJg2nbFEBlrUiVvL/OKol3t6xVTOQ7wUjuXNzkwJGdbBv0Oz4Vwxlfh9dzyQxDlXadI1a36BqVV3gcrppJ2FUzhMrDwK7RlmVgagC7bcs2zH0s2BJXCc+ZeB0RuHx6KzM56WwE1oco6bl/NSeA+SB4d1diX3EbytqaCGZ49aXGEHWyiTxVGRQ9VB6v5QklXMJs/brWykIec+SwOfDHKDyMcoVZr9Kp6xsvs1STpfJyl3iSxbnhMi2Q4XAyv8aOpk6TGw9t
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 11:11:23.1162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 932e4241-745d-4022-4e6a-08de90a89340
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274473-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A248E3882D3
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


