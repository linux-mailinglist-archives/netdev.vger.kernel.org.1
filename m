Return-Path: <netdev+bounces-270517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALQ7Bio0wWm7RQQAu9opvQ
	(envelope-from <netdev+bounces-270517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:38:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FBC2F204C
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 13:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1839F3010917
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D0E3A63E1;
	Mon, 23 Mar 2026 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JiJL+1s1"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EE93A381D;
	Mon, 23 Mar 2026 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269449; cv=fail; b=I0ai/3i6HqswvQ+aWlGLWxcADzhtYjiQsCzDde0FdKVGswBOau2oQ39wRjyaN2ym+VO8IPB/XXtyF1vZLCMN2Ij8TI09h5di0tJt9eGdy1iv4P9SCuhWuFWW1tn93Jzu2WfNlUX2UEbaZhGFx/KY50tPj32pGcF/KiW8py6NnYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269449; c=relaxed/simple;
	bh=0+w+mKfppGDv6ipd1BREBrf0ZmulJyz5Cv2IVo0TFbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7AWtfBDOUBKe4eb4/ZMh/EiJ+kWQThXAPDt/1JGyJvvdHto3YmOi1NK8iBMup5x2cWKuhDD4d3Mdbxz66x0EgumVK7Vjml+mOqZ0aewSGDFq0UCAkywvM5QHNvAf0PGFTbGsvOxR90F7GUFn0bNDQUO38N0h+vhY8vhSYWMrX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JiJL+1s1; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EA3lv688l4mbflGW7AaYnXILjMKARheqSSGQZFkJyBOz4FvCPSswTTrH8wYMTEkCgYLt2T0VqidtG1WE+JKFvfxtSEQCuo1670bTMUym+46QVN6WohNIbDTwB5NZgI4slh0knNILjeMQv35MCYFztyb7+FTzT1OvVL4s93eQiZmgvjeU2Zf04XN8/2WybwpFLRa2inln8tv0KuYg4PBu2JJHBnwhvAPpCc6MS47ZJqkq7z0A1FvSga1jDmP64BYT//7/uleDSdHK5Lmzdv3L7ULByvhjMahm1WlTYGacCWcu3GXwVStqI4odhq91CoLgfBMWdTRd904Nl7458A6CMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OWmlrf1TGJftWtmZd98DPJjWAHnMnlG7DeSY6L/Zyo=;
 b=VITeSSi2HkJqiSB6m+xttbyAua6JVe3Mk22rH36XuaJ1KSa84l/R3KUoBCKB/BFTOKM9MsP/iujo1Ybk/271cXWjYYdHe7MmnC5U2UWE1uvVOzQk6D8UxgBcigpYpJKY1HdnBlcEq12LLIgLl0Jga8G5Dei2uxbC9mJoKvrJDV2sqoI4b4bjG7PPEf4lCjZMrcMgIlEbHdeUXazbgyrYCs3d05iNupclYVPpYDUJTcMt8wCgNVk0/9/5kpS9JHDb9D0i3ws53+Re2F0xvusW4tX+OeqILRfUEyySZYt/Uwn6eM/YIDq6SfrQ+7A3E5AM3GjuDnekc8UINm69SStHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OWmlrf1TGJftWtmZd98DPJjWAHnMnlG7DeSY6L/Zyo=;
 b=JiJL+1s1u/wXU1ZE7+hEQHEj+9jAg+4xdr7WEzz2xDAK5rxQUOpRqxu4ehZqby5s9nBxem/+xMrlOdDqmoBZHwWqx58eF9XtOYvhd6uUJEmNSm/T/ROXU0aPBDvgJOfjsiHJ8d9BDQKul2xgDKMqeirxeYLgXsS5T2+dZQm+R50ustO8FPZq2gKWvLGi2ownoYKNJRznYXcOpSapx8PMeJbxXKsBAZWFo9+itmv0pWkkJlKXdufgM9FXEWyBRWJOZRkfoJEzyudAhLkapZQ7SHtW1Mkodf1PR+1ew4V/4VsuCSoVpzDR5VyuwafcpRBBfZ/MeHuiYGBdGR0Ob7ZJ0w==
Received: from SJ0PR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:33b::31)
 by DS0PR12MB8343.namprd12.prod.outlook.com (2603:10b6:8:fd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.9; Mon, 23 Mar 2026 12:37:23 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::e0) by SJ0PR05CA0026.outlook.office365.com
 (2603:10b6:a03:33b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 12:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 12:37:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 05:37:06 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 23 Mar 2026 05:37:02 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net v5 3/3] macsec: Support VLAN-filtering lower devices
Date: Mon, 23 Mar 2026 14:36:33 +0200
Message-ID: <20260323123633.756163-4-cratiu@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323123633.756163-1-cratiu@nvidia.com>
References: <20260323123633.756163-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|DS0PR12MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: 341d9324-ffab-40ec-097d-08de88d8ee5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8V/y1nb0W6sZ5cV5G7C48PRe2DXtlcAdKDzHIiBdVVwToIosBKhXaIZBAoQd1pR79m9YULsri9fu/iV+3rJN+FiLv3RZn5/cLNctgAUpawLIrMVrC3LesYzz6oEEcB15IBCqeynaeGC5vVa7aM/YAO/Twqw6fXIcW4OWKTGqIxptosU8Q1Cp7qzalM/AxZcly6x6RKOyPa0/lCCFFsJyuFk3B+IMCsskQ2jajHVvT0omUpX58jpCQiQyT7nPFF8OOi5vho0TwG1MTE/5ynA/1Z7x3t5QSGWi0i+4I02/wMuRc3wclYO+Zepd2gkj9aa2837CA+hwMTzsDcA11Hn2d97Z3AhuQe2cchk+iJBVtOj5A/BdgD7287O8i/P+AL0WfKR2G6OKcqB8Bbt8i7LnLe4l0g0JYSwHQ1bNi+lj0rQc0ihgDMNZnGo8Zw6lTOOOaywU0GWdySpB7Cid9eUaJ6DX2/PEf7/rUq1fFQXij4Qgm92cuYAd8mfE7sfnBQTuCX8L3vzxFc1tEfVSXr0VOilJCo7+9TvaB5Q4IDG2xu3eLOTMGA9v71vXrmX7tUmHPJvE0Nk/TXXkSeMiNe0eIHLy+keIid6BNCfw5PBXKT1Q9B2MmvNLs9F+mm9Jtcy8FQwF/0XS+cSE6My/2+1ZCw+FEFvzIzt8mvcROuuXj3PA3vsLLy6b11/M4Flz7lAg9N7A4J5nJubrYfSccDYNjltjiEOShxo07/Ug1pvQIbRMp13eVwBpSgFt6JMQsSLwqhJ8549McsyIV/oUb9X2jg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7LJXZAZWNree7ka3vlJ2XPKRr8EcsukNOvEjjhAvxDnmeRd7C22kga1P/kDSMEFTf7JfVyBQqD2q5sCnE4QL+64Cv19Yfh2OB3ZYxAtO9eKqkQdY9IYCHNyBwrXsvaxDot3Vw4x4sV6crbxxGBrILycKjKLk33a5xvxUom3ARy6hnzJ4uL7CH3KPTStsV3S0jawRy7wN0vm5he2L3+QhoWUG9x1t9m7eyBKZHQbMVPg5a8pMR7d91Kr2Z5RfTcIrwx0WChX2EdaDIzJFHmsyIhyaFyigXIOvH1vlaaW/8I4vaGUSGFW3abS5RMBq0XtWiQIfwi45CtFeXJ+bZyeqfdIPr6zFvtlFl9M3WdGGgCExPns/Bgxwve8rt1cRZmeeQvQJJc6ZGsSJvlXJIGPjGEqgU5x4Ag6q/QmvKed03xL/X8OljTuudu+b3HnV6ha1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 12:37:22.4104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 341d9324-ffab-40ec-097d-08de88d8ee5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8343
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270517-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 32FBC2F204C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

VLAN-filtering is done through two netdev features
(NETIF_F_HW_VLAN_CTAG_FILTER and NETIF_F_HW_VLAN_STAG_FILTER) and two
netdev ops (ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid).

Implement these and advertise the features if the lower device supports
them. This allows proper VLAN filtering to work on top of macsec
devices, when the lower device is capable of VLAN filtering.
As a concrete example, having this chain of interfaces now works:
vlan_filtering_capable_dev(1) -> macsec_dev(2) -> macsec_vlan_dev(3)

Before the mentioned commit this used to accidentally work because the
macsec device (and thus the lower device) was put in promiscuous mode
and the VLAN filter was not used. But after commit [1] correctly made
the macsec driver expose the IFF_UNICAST_FLT flag, promiscuous mode was
no longer used and VLAN filters on dev 1 kicked in. Without support in
dev 2 for propagating VLAN filters down, the register_vlan_dev ->
vlan_vid_add -> __vlan_vid_add -> vlan_add_rx_filter_info call from dev
3 is silently eaten (because vlan_hw_filter_capable returns false and
vlan_add_rx_filter_info silently succeeds).

For macsec, VLAN filters are only relevant for offload, otherwise
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


