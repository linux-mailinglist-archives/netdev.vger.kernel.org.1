Return-Path: <netdev+bounces-261773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHU0Ct1doWmksQQAu9opvQ
	(envelope-from <netdev+bounces-261773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:03:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BC31B4E1A
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08AE23049721
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6289B38BF64;
	Fri, 27 Feb 2026 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k7mveyzd"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020713AE703
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182996; cv=fail; b=VmAu3ydRiUBkUH2hWybXRldRW20o2vb1eGDXL5ibbs85ckB+I0ss6uyXlo5TKB0WIxZJHvMWaxrocu1lKJ2/WRroU5bL6gaLcwhRr5abt5+2PFD5ux2Xha8r3XYYl8XEiBS9NkRcY0Lqd6Ha5lGexODqcwQxXue8fUcQJBx9Zuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182996; c=relaxed/simple;
	bh=xXVMAVM23CqXzhLS4dm3DREbsiNWqviVHt0YFNxRlSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z27yQk9SVv8RES+Bchi8yLjgRBXhZ86272Iu3vq2T/I0dfuqM+XPCvSfEw7wIyY1fsk/JHMZczfk4+HX+B5LXV/FdRBMKoG5aPna+FnjFCmfKb/k56xxX0h7d8zJ96sjmucIj3xPaGnjttFT49Q0gcnGk3ztE+sLMHmoR5yssAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k7mveyzd; arc=fail smtp.client-ip=40.107.200.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ax8akvrUIgfq7SPZZFbZNKpJxfhV1G9w0FGCQWLtu2aI7wXu/blgv69J0Us6DrkcnE0RkJu1RWLQldna/mUqBga6eZKJiaQ0D8xQ/3j+71V5PG6Kiib3usiugttH0zn7JSis9vUhh/e1AmufF1mZmArx09uCyfNbwXswBkYRxLLyjC/ZwoUK2JPboUaohjUmqv8YWVI6O3JMqOLG4XwQ7o0gX5IL5oVq61phMJQkKNldhX4cqPa6uoBmnYo7hmbI1Zcq+xcDtVNT5PFxbjYGPgmY+P4BbodzbRBjIx/ufPOHX3rld8etjFLwyDD1ilI9Sx9nY4t8QiqvZ2yOnlGmUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5XiEUw6gEFrev3JVsMdSpuDdE/VmoNcdpRhbeDl8Vk=;
 b=YkgVfexrOXkCKaZpTWFn8yfGF/3JmlBwB1dxNC8E+c8wbKw91rhC4+JWBHtLjy+y0XbhvCJoNSOkukaJDxQW+SkjgmPxEdnEAwXRZhT7baywzGDQYjKCSxDrMGp+AtQjWzS3SHSpNBY2EE+f8PEFMakWaUJ8A7jKXpTKpUdabSK1DeN1F7QxQkALe7gBISzZ4AR4Q2ojxunRKCuuwsaqUFfLfVRlSGk/Vi1WPL68w0fHygBCDZQBJ64Ko9SMpmS9AvhMgpDdlBtaKhtml3+wnJkAKZn08YTQDKN+3O2XBT+3XHidlRiWGmfKj18U9a5auv8Pm/ohJ8o4pbdIlVB8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5XiEUw6gEFrev3JVsMdSpuDdE/VmoNcdpRhbeDl8Vk=;
 b=k7mveyzdFr1qDZHu7+x9PLzknAlfYdzIR/Q6vj7R09sytWH2Sf2qkmCb0k8lE6/jGjFsIjK71s4yKqmS+mn1tdstm4ob85R4xVfd0l+FJxK7CTwtFFMEPclywQXg6dOyn0k+nvxP4lZ8KUAf7ovBRqIhqRhwJnQDTdf8aSd5K5jEIut9KBCTOyPHqZQ08oj2s6LVhWXDY6rZSJ2c2miTZnu6i9P8IqgZBJjBi1RtKa/Fb5rTrXwF8NIRQ2jQTn/huFlPbab8ZfYgygOkoSrHywCsYHoODpN4X8z/TEFHd5+wYgGMGeanmBVef52VaVqhybVVdFUUY8ud6Vru3k0gXg==
Received: from BL0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:207:3c::14)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 09:03:10 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:207:3c:cafe::e7) by BL0PR02CA0001.outlook.office365.com
 (2603:10b6:207:3c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.27 via Frontend Transport; Fri,
 27 Feb 2026 09:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Fri, 27 Feb 2026 09:03:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 01:02:57 -0800
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 27 Feb 2026 01:02:54 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next v2 3/3] macsec: Support VLAN-filtering lower devices
Date: Fri, 27 Feb 2026 11:02:27 +0200
Message-ID: <20260227090227.1552512-4-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: c4899ab4-15d3-4fc8-6247-08de75df07ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	nUSA7Kj2a06cUjc15QMTyzqRHQgmdCmj5g7sqBN4jBobQGZMZ1+gU4vav4j+1Ht3s1jejjuR0vFhmBgy7YQbT107eOAyTJBrPPTbewEWXSMF4alKSY/r/Mh1dAiZDEQpOUrQwrlLb3Md90v5wKi2SwsFiSHUnyvl9fXHgJ6vBUZTA0hlKtV6BesTPv9KUfmAzHjYLxmR+ElkYqlLDOwcS8S1lwcUvKTSsjKOb6h4fXtXNUuARXsFwV1DvK8I68spmeBFJ3fRpxtgjQX26hJtiLV8LtQcZiz31ZINMYuYrAGZBV/ZF5jFC3sZD5bdL9LJMblNr/EiUwXDWFDrFYNm6FEJg4j81mg5cTA9+3Yn7dFLHswfsQJz7/EX311OZbpjtZBIaLMcGn2BSolInC4FrTZMSVtc1+DyjHAu3UcK+Gvw3/eE4hKobacobmvEk3ED/1/cOzNeLU6BrqGT15JWhAVXJNubp69wDqn4i3n9Qty0cz6G+eNV+VgMfru9pmljTjHFCjJ+mlncORw4Jtjff6TO6mX4kGGmBpnmEqXoFxFQgtS+EBXHycwLZKIzDrQ21NkDJQgT8fQYDZOVakyj1IiZjiO7cYwbhMziSecRex1dPxDk2n1+aFjSKHFGw3PCUhOXODFAZGQPc495B8BmwlX4+0am+rlAFtgDT5JipPIc0j49k8rkt59ks58m9YmzZo+dLK4T80bk6GE0L+WR2ChgzstkeSkP+UTxk4Z1WtXFnoIDgab75V6+6/aYI0USyOO9EX63mnlxLFr1qa+264XRgJsryC3OorX/pw97QqOVgHLjVShE2niys9H0nIa6n0zsHNKqJv1RtMnovGCg6A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Nts2ZdmSRcwcffuJWR9rVSeRTYrsjq/BVbGvOYKMR3wS+j6hSahVnbj2+rAE4raL/5oTgP4cLCWebSexFiehXcN9BLR7QeV/VSDWDOkOwGmzpIU2J6iExGq1F3Wxx36XnXMZ7SE91l4gPE6LuiOU0FKcppxkBfvoJQbFx6thJTABDEMY6ijJCjaOylxXQO/cSqw8gPYKTP0qWec4JuQaigdbhXFHeVwt6JsuqwnwxiGBH97ha33CNc6EuqbJ78LVU11jAot2wQr8yIahH2xvknTdz9jijrulLQBODsSFWcy+k5o+LQEP8cZcb99dcIwCA01FiprCGqVy7n71HU6438mK8qbNU63vgB3lEMALCF0Rru+eeuKWLEhd9ks2Tf7FDUuW9+BW00Zj1Dxak5IbzGxiLwg0fYDMcu9q899UF1xVnGqQuAzl5yuv2Y4C8hGK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 09:03:09.8376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4899ab4-15d3-4fc8-6247-08de75df07ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261773-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 68BC31B4E1A
X-Rspamd-Action: no action

VLAN-filtering is done through two netdev features
(NETIF_F_HW_VLAN_CTAG_FILTER and NETIF_F_HW_VLAN_STAG_FILTER) and two
netdev ops (ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid).

Implement these and advertise the features if the lower device supports
them. This allows proper VLAN filtering to work on top of macsec
devices, when the lower device is capable of VLAN filtering.
As a concrete example, having this chain of interfaces now works:
vlan_filtering_capable_dev(1) -> macsec_dev(2) -> macsec_vlan_dev(3)

Before commit [1] this used to accidentally work because the macsec
device (and thus the lower device) was put in promiscuous mode and the
VLAN filter was not used. But after commit [1] correctly made the macsec
driver expose the IFF_UNICAST_FLT flag, promiscuous mode was no longer
used and VLAN filters on dev 1 kicked in. Without support in dev 2 for
propagating VLAN filters down, the register_vlan_dev -> vlan_vid_add ->
__vlan_vid_add -> vlan_add_rx_filter_info call from dev 3 is silently
eaten (because vlan_hw_filter_capable returns false and
vlan_add_rx_filter_info silently succeeds).

For macsec, VLAN filters are only relevant for offload, otherwise
the VLANs are encrypted and the lower devices don't care about them. So
VLAN filters are only passed on to lower devices in offload mode.
Flipping between offload modes now needs to offload/unoffload the
filters with vlan_{get,drop}_rx_*_filter_info().

[1] commit 0349659fd72f ("macsec: set IFF_UNICAST_FLT priv flag")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/net/macsec.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index c2cb2d20976b..27b36288c5e5 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2616,7 +2616,17 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
 	if (!ops)
 		return -EOPNOTSUPP;
 
+	/* Remove VLAN filters when disabling offload. */
+	if (offload == MACSEC_OFFLOAD_OFF) {
+		vlan_drop_rx_ctag_filter_info(dev);
+		vlan_drop_rx_stag_filter_info(dev);
+	}
 	macsec->offload = offload;
+	/* Add VLAN filters when enabling offload. */
+	if (prev_offload == MACSEC_OFFLOAD_OFF) {
+		vlan_get_rx_ctag_filter_info(dev);
+		vlan_get_rx_stag_filter_info(dev);
+	}
 
 	ctx.secy = &macsec->secy;
 	ret = offload == MACSEC_OFFLOAD_OFF ? macsec_offload(ops->mdo_del_secy, &ctx)
@@ -3486,7 +3496,8 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 }
 
 #define MACSEC_FEATURES \
-	(NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST)
+	(NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST | \
+	 NETIF_F_HW_VLAN_STAG_FILTER | NETIF_F_HW_VLAN_CTAG_FILTER)
 
 #define MACSEC_OFFLOAD_FEATURES \
 	(MACSEC_FEATURES | NETIF_F_GSO_SOFTWARE | NETIF_F_SOFT_FEATURES | \
@@ -3707,6 +3718,29 @@ static int macsec_set_mac_address(struct net_device *dev, void *p)
 	return err;
 }
 
+static int macsec_vlan_rx_add_vid(struct net_device *dev,
+				  __be16 proto, u16 vid)
+{
+	struct macsec_dev *macsec = netdev_priv(dev);
+
+	if (!macsec_is_offloaded(macsec))
+		return 0;
+
+	return vlan_vid_add(macsec->real_dev, proto, vid);
+}
+
+static int macsec_vlan_rx_kill_vid(struct net_device *dev,
+				   __be16 proto, u16 vid)
+{
+	struct macsec_dev *macsec = netdev_priv(dev);
+
+	if (!macsec_is_offloaded(macsec))
+		return 0;
+
+	vlan_vid_del(macsec->real_dev, proto, vid);
+	return 0;
+}
+
 static int macsec_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct macsec_dev *macsec = macsec_priv(dev);
@@ -3748,6 +3782,8 @@ static const struct net_device_ops macsec_netdev_ops = {
 	.ndo_set_rx_mode	= macsec_dev_set_rx_mode,
 	.ndo_change_rx_flags	= macsec_dev_change_rx_flags,
 	.ndo_set_mac_address	= macsec_set_mac_address,
+	.ndo_vlan_rx_add_vid	= macsec_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= macsec_vlan_rx_kill_vid,
 	.ndo_start_xmit		= macsec_start_xmit,
 	.ndo_get_stats64	= macsec_get_stats64,
 	.ndo_get_iflink		= macsec_get_iflink,
-- 
2.49.0


