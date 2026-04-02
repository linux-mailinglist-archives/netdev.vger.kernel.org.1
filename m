Return-Path: <netdev+bounces-274474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIlmKq5QzmmjmgYAu9opvQ
	(envelope-from <netdev+bounces-274474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:19:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A99A388376
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 13:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52883305ED08
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 11:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E283B8BD4;
	Thu,  2 Apr 2026 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PTK8rvwD"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012062.outbound.protection.outlook.com [40.93.195.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B2E33F5B6;
	Thu,  2 Apr 2026 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775128295; cv=fail; b=eCHmJvrf2XtKXxwAXBCjn4B5PWJEeqbaXY6RF5z4lH4jBcwgkTag8X1XM9MzYCULCx0BICRKGJrvGKA4DUrHMePefTMBU6LgxDDH2vqDXvLGS1h4ljzn8rPs+J5JDRIZ3qaSBsnbwmu0htvhGbKzFG7FXc0YXn/+zWmr1a0+JB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775128295; c=relaxed/simple;
	bh=16h8f8tWHACA+ancKxzy6b3jFlKhDUzcKZs4oNJw1oA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGndOwMd5/zFEjaF9ZLBESzQGgJk9+hlHQqss/6StHUzcZaMXJi5uckKXY67axktzPJk3V0krhR2G31HHOHSm3by5OnBfNomGDbcaaK6LeGEVDCfrllT90nru4mCpup1av2mUzSg1NRJXmPnfoRoD3mQZlvw8dDRG7LJ0uJ7h9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PTK8rvwD; arc=fail smtp.client-ip=40.93.195.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjbF9DrqLbwPKkjvrPuy3kO9L4/2u1VEYzdBmLogl/FeIA8Mh823Hr+pYapUpt1rG9ZfJSelRLV/2BT6MYh7m/I9zPBAxtjPTUxgH2+8IMLcFIlnOsPIsy09BjR63TFuAhO6Mft+Uaz6a9Z1BagqO/iVaAlrh63mFyMMF0FwmAoHSWEvo9qn1NqMkiEnFMW065b1mxdkitFTIwLOqSFg8ifgFPMTuS3CdDAAIf7bdo4rnOGvgTMzwt/khi/7HMH25w8nU9hj5ognKvMnRG0/fnqz4ZmmFiFk6ZwGXmT/Gm1Ab+a6W7nn1hbyJM7UEN0YYugBEKGc7yGn8KvMWMqKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbnOOYVtanCy4OK7WZiS98f00c1IPoLq5dVjdUSbIPs=;
 b=yQYwt+RuTib340R1BflieqaOtvYuWEpEYAxLhfp1VP1Ea2wX9v7nILpLvIuYfCsJMigRITctKUcmR4l06PplaiINYNm6OWQ5qJ48vmXqxuh+r8MwYh+2+jBXGfR8AKT5NJ002GxyryT7vegIU1UcwZk6bdWICFI5+TatGXvFQqnD6bdFOtn2a7BtozX5i1m04fFDdWCNtMm0dqxpWcxXx+aVXtRHzpAW9jQcAoj0bSpOLH2wQtli1pfwb4Q1cBPmbknSz5mpg8x00dmlLzCXDub5Baxaeb5KvwACoaUdPxXwDwePcdmO5q7NjsDG2tN7RlpXUYMrx7+agYiTYluSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbnOOYVtanCy4OK7WZiS98f00c1IPoLq5dVjdUSbIPs=;
 b=PTK8rvwDj8kN4AQ13FeOTlW8gffgyxNTTHm9tBeBPdwa/ocJ29O5abYaQ0fQ7Y+OP/R+zIAlvTFP4QB224DyODLAzwP6K1qb4w+tpzVWOe8bOJl4t+WfprN4lvupVNVwwUlMPy8LUhDMkaToiMa4V91FzYtWGXD6jjU7+MPOLtl97BBMJXcDuhP54Dp4rTJPo7aUQz/3mrPCrozAnslL9LOYvgAkRSojIIYcpBn2J8DmL84ovyjj1MUsYpBHPgzwxdNj8olvf3yV2Kj0WvMwGqc6Y9Es5EAQ4O/1POMCWzDc855AVAtogYIf/hOhJRkt/kcyLOznB0t6ohGzaTMEXg==
Received: from BL1P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::22)
 by DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 11:11:27 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::af) by BL1P222CA0017.outlook.office365.com
 (2603:10b6:208:2c7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Thu,
 2 Apr 2026 11:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 11:11:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Apr
 2026 04:11:12 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 2 Apr 2026 04:11:08 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, David Wei
	<dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH net v7 4/4] macsec: Support VLAN-filtering lower devices
Date: Thu, 2 Apr 2026 14:10:34 +0300
Message-ID: <20260402111034.1494714-5-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: adb0a6f0-1101-4140-296f-08de90a89583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2rMx+4+BFEaFvI4N8AE2eVXkCexdBpPXeSfDd8NcnCaWrQdfTozC/ZUAV0IWlBWrIUZF6cQYnG9ck1EBLwFy1MlWN5q+xdQn/BwRtIEJqbJ5Z9id6scmy6sDuC27tsRveDZCDUw+lxrWCDpPNabzeUuDO3Md3G/arNRLTWcsyU1e0kTACKHlWh9LOayxb/dJVzaZc9KsfE+xmO/srrVs1KtyUHNp41wHkAp1A6qDncunZaPRw5GKUnNFrDtCvpRm3Wyurzz3KXXTodFqjihjkSjUokmioAQjpKkhHmNUjMrvhk3LEa5yti+BGhitHajKvxQzmsSqQPTQpTgzJtno7gpwef6O4bCk8e9w2sbEQuVnPUcEiOM73bPSDnVzREBuidtM/CZux4bb/KlBXxhoTLHS8yVqW4Ibt1SFVfqqcgrLUGSvaqUQBfgxwz8+CTABI2RLT9fJW54KNzbTdM9l4WcHvtcT1htiSzZx5F2W5Ft8xsWt93TqZmojxiI4SV+sEophdLE0xjllcxchgljW4WF0IW6E9Ei8QEqln51W1BgvANqx0XifyXcNCul35e8jRHkWiRLfgrwkWM1/sEEAEl10YTULNUK4s8RqkMHYNQlNQjELYWPg6vWZQGzRxE0eRlso1kqDSwZqu+VFXylwNTM7cI67r0fdqIFbmO17waFDcSoGCIMPrsII9lfFttdlR3D5ic0mdJKhr5kn2/MvhE2ei8sTYl/akphDyIl/mBt26OhiZYMTuPug04sAOjMplB4oQ83YIEZiIvvp/hKphQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BdldeGBIkBhvv2acTAdW/wMFqxVT62gR9G7hgq4SaBCDJusdGcdNz2WwwaL1wvT3bIzJQwVKRkRoNjF+AZw/9qmF1d+PA3f8Hrp8F8cH5dGB9o8rfdj0hXzBNZgHs41ftSgwNy4sDPjQEpyZAR9uCAJf5bk8j3zgASXr/Tss78op96gF4g5AdIMPRJXY+Whg8GAjDPU9ipNL6e2xeBNIEoW/n3bxeWEM4HE8VU8+ezX1vu3G2qxUK0qVU1WyGEK8rv0gBij4GkgW0Nm2r5Mj6bOY51wBigC3Kj0o5yE/+OYk3AT225nrD0jFvNeVYPZwFFUzWbMh4vKfl21nwzY0kck8/xPilUzvxaFn+dwpKKqpWzWoPNa7rJTzY7hq0ivX8Vr0Jy45M2GzbvzCqMChItuoi08zfaZYxNfQqWoy3oHq72cUdd4xFgEwFa93pl0K
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 11:11:26.8603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adb0a6f0-1101-4140-296f-08de90a89583
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274474-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0A99A388376
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

VLAN-filtering is done through two netdev features
(NETIF_F_HW_VLAN_CTAG_FILTER and NETIF_F_HW_VLAN_STAG_FILTER) and two
netdev ops (ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid).

Implement these and advertise the features if the lower device supports
them. This allows proper VLAN filtering to work on top of MACsec
devices, when the lower device is capable of VLAN filtering.
As a concrete example, having this chain of interfaces now works:
vlan_filtering_capable_dev(1) -> macsec_dev(2) -> macsec_vlan_dev(3)

Before the mentioned commit this used to accidentally work because the
MACsec device (and thus the lower device) was put in promiscuous mode
and the VLAN filter was not used. But after commit [1] correctly made
the macsec driver expose the IFF_UNICAST_FLT flag, promiscuous mode was
no longer used and VLAN filters on dev 1 kicked in. Without support in
dev 2 for propagating VLAN filters down, the register_vlan_dev ->
vlan_vid_add -> __vlan_vid_add -> vlan_add_rx_filter_info call from dev
3 is silently eaten (because vlan_hw_filter_capable returns false and
vlan_add_rx_filter_info silently succeeds).

For MACsec, VLAN filters are only relevant for offload, otherwise
the VLANs are encrypted and the lower devices don't care about them. So
VLAN filters are only passed on to lower devices in offload mode.
Flipping between offload modes now needs to offload/unoffload the
filters with vlan_{get,drop}_rx_*_filter_info().

To avoid the back-and-forth filter updating during rollback, the setting
of macsec->offload is moved after the add/del secy ops. This is safe
since none of the code called from those requires macsec->offload.

Fixes: 0349659fd72f ("macsec: set IFF_UNICAST_FLT priv flag")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/net/macsec.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index f6cad0746a02..3bdb6f3fae8e 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2616,14 +2616,22 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
 	if (!ops)
 		return -EOPNOTSUPP;
 
-	macsec->offload = offload;
-
 	ctx.secy = &macsec->secy;
 	ret = offload == MACSEC_OFFLOAD_OFF ? macsec_offload(ops->mdo_del_secy, &ctx)
 					    : macsec_offload(ops->mdo_add_secy, &ctx);
-	if (ret) {
-		macsec->offload = prev_offload;
+	if (ret)
 		return ret;
+
+	/* Remove VLAN filters when disabling offload. */
+	if (offload == MACSEC_OFFLOAD_OFF) {
+		vlan_drop_rx_ctag_filter_info(dev);
+		vlan_drop_rx_stag_filter_info(dev);
+	}
+	macsec->offload = offload;
+	/* Add VLAN filters when enabling offload. */
+	if (prev_offload == MACSEC_OFFLOAD_OFF) {
+		vlan_get_rx_ctag_filter_info(dev);
+		vlan_get_rx_stag_filter_info(dev);
 	}
 
 	macsec_set_head_tail_room(dev);
@@ -3486,7 +3494,8 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 }
 
 #define MACSEC_FEATURES \
-	(NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST)
+	(NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST | \
+	 NETIF_F_HW_VLAN_STAG_FILTER | NETIF_F_HW_VLAN_CTAG_FILTER)
 
 #define MACSEC_OFFLOAD_FEATURES \
 	(MACSEC_FEATURES | NETIF_F_GSO_SOFTWARE | NETIF_F_SOFT_FEATURES | \
@@ -3707,6 +3716,29 @@ static int macsec_set_mac_address(struct net_device *dev, void *p)
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
@@ -3748,6 +3780,8 @@ static const struct net_device_ops macsec_netdev_ops = {
 	.ndo_set_rx_mode	= macsec_dev_set_rx_mode,
 	.ndo_change_rx_flags	= macsec_dev_change_rx_flags,
 	.ndo_set_mac_address	= macsec_set_mac_address,
+	.ndo_vlan_rx_add_vid	= macsec_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= macsec_vlan_rx_kill_vid,
 	.ndo_start_xmit		= macsec_start_xmit,
 	.ndo_get_stats64	= macsec_get_stats64,
 	.ndo_get_iflink		= macsec_get_iflink,
-- 
2.53.0


