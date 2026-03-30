Return-Path: <netdev+bounces-273172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD2CFSF2ymmB9AUAu9opvQ
	(envelope-from <netdev+bounces-273172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:09:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 615D635BA8A
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 15:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 192113037BCF
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4EE3CFF6E;
	Mon, 30 Mar 2026 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HIlGGEVH"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BADA3D331A;
	Mon, 30 Mar 2026 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875761; cv=fail; b=bONssa5zU2xK1gdod4KLUG5Fl3lh0rju/iQEX5GelVy5cVPpavLnLgITYJpDG4spd4gQKYZY1oO5o3GAGQgQZ0Dhz8s7e9lN2HrN1nqczrfHiotkL0T2MsISHx6MFMmWduDuPD4JWdcpCdIqvt4o99rFNtabVezuORI6SB7mB08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875761; c=relaxed/simple;
	bh=16h8f8tWHACA+ancKxzy6b3jFlKhDUzcKZs4oNJw1oA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qb3m2OM3ACcKZe3I6kY+Kud6/btO+UWYXzXvpdDBO1yoGF5HMeTb7amlT5M7X9iRhqp6ZJ3QjxTAKl29iLVcEoHOLXdLX/zkT3sDKREjiVJX1Tit3mH0ONRRbs1mXxk4yQTW43jm2UIw8QpOtsamE/UPmQAnYFv3Ywgj+7Z1wIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HIlGGEVH; arc=fail smtp.client-ip=52.101.85.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sw5o+FqXLhIewE4xyfIrvxkrPGoQnrsCfqKlcT4UdwDesd9u0qJjTY8o0JgChewQZ4522gNFqUSSB8iEhdL9QXT6VzQvH+ekypgDcayQDA7Y8K++049a4CiZMIIwHm1se8vZHOjowEVi2hhHp3zsRjLQ4w7T+8yTpbqUXAJd2SsmlgOhMYVbC4ke7xqSrHwZPxzL6x5sLjKNA554mhmoJ+lR4TAjAi81ERZo+QImxSnhYBzvennZyy3ZR5GOk2geakkE5MkJhBSrlSj8AZqIfZtm/XGqB4bndot7qKQRt4YwZdMQ3wGatKgRFFlSqVHKe7RKatQiRnmq3p5uit5sug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbnOOYVtanCy4OK7WZiS98f00c1IPoLq5dVjdUSbIPs=;
 b=sFZuAFU6WrKlwiicW56PiPktUxP/bXSLK/lIW/bFRYQ/aItxOeulaFWqVnWSvjoyIBK545YzNUuf3pbaPfFORy2IOHkJ3BZPnr4ZHmJfjNHPXp749fQ35pBJCppP/9nqrPhIQytNWp50coRhuPpEyDezYWdIvl0Jr+uHOpw8eKvr3PVicJjMtWEJmk7UVraC5DoqAX1GEo1DcQ8/0ufdtelQc+vqDT6B8GQ5aQZL4Fa+5yz1RNncWPUgD4jgH2kQUi2p8WZeiDJRik7I+v5/u3GYVJupR8+aTWNILbsFjyRntW++zh4VMJjmDrqRtSTiMUILsEkNyx/C6tamUXQCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbnOOYVtanCy4OK7WZiS98f00c1IPoLq5dVjdUSbIPs=;
 b=HIlGGEVHIrhqcuXvE3WaBLSPykaY88pfd7LJOZDqSPS6E4pEK5F6CkF4+uN995gAwEUJt6l+2Npx5BN+inn7BtzuQRUyRyQV2g+3iJA9ezPcPGUB/imRnzyH4idv3a+mjOWt91RbbcBypjojUUpqqMxrMmDdDECW8FMCQrEKa9+GnwFS8w+lYDSVd+OiU5ojsq0z0/Tv95Ix0xw5V+dnsREDTiDxr2sPhUQkhl2gFQu2dHTvngliDM780T0j3HApQNMnbP7SKUp+WVaBOCC7oZNWJjJW0AaFGTYOWDr6F/LoFVPpAZ8+qGuAJWbiL4tbJC2EsqUVVxchEyM4XuDj6g==
Received: from CH2PR15CA0008.namprd15.prod.outlook.com (2603:10b6:610:51::18)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 13:02:35 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::72) by CH2PR15CA0008.outlook.office365.com
 (2603:10b6:610:51::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 13:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 13:02:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 06:02:10 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 30 Mar 2026 06:02:06 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net v6 4/4] macsec: Support VLAN-filtering lower devices
Date: Mon, 30 Mar 2026 16:01:30 +0300
Message-ID: <20260330130130.989236-5-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: d8941ef9-5294-4b6b-127c-08de8e5c9cfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	R+ZAcQcc+1zX1midtnovAUGPj5P43NV1d0I9eG94Ow8LJJZKFf5hBeyC/KZU5+nHvXc5Vi51/I+hYe5yKaKu7bjOnco5kkUfQO7z0mCcyA8ISyjJxyRJ9FXACGPLw1FqGZfNyWWn6bWJkr8YvV9BYemQUP9WPK7jgogk90T4Mup/ot9Zz6bQFcAXb/mRpUh8SVbMkNPBb0QqQRlTYK7JzLibOZqhzPrzIsjXkn0FVaUiUSGUwWE6AMewjL34hsrZdmHm245W908slY1OTUE+w26vaFQghJ0E5OUOCegLGEhozvAIV3FkEiGDKA+irT/PjGbIyDXlkn3jkC3OAGljIZ1MGUOXXiDEmfMRS+MYoFublsCPcEHcX+xge3iCAIhnW3kJxF2FDYhCzcbJLrkOhprE8MmLQh6C3bHxmwdmrqIsFpbPbix+ex4qk1/b22SfJDW4tzbi8YwiztPSWgXycJl/TEedt1JvqE2gDnbUwFeAGA5D5wZ+ueBK/xQ3qTIxD0GLtE0FPfcYvOuBYdVg/eyBUO3ZNkmTxUlij8pPpqY5IrFdjpQpE7g9zBKeVaJQVHi7wCLGcKwHuysGqpGKnVSt1MzG6Ln2uDU6RN36uAKP7jCHv+osQ73Wz+I9anDq4vEU7LaOD78C7o6ENF7m/Kcn0xnqhA4yCusX6kMUtuYu2HviI6PihdIUbt5x0s6mYaDB7JauOnHMh2WRvUpk6mlPg+OJ2Pjgp6sQ/J9rr5F6k9g0R0CpeKMwpIDVNXYPjp8jS0/O3bYe0flbHv15IA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BsvCmoB0DQ0eHKAVLcUp9JAZhruxTtE5mT8x1BtluMUVVq+IcV6ttuo6b7lsvrDVTrQVGSotLHti3jlP+DLm0bBUQ3XORgJRq0efSaR/skUdaFBlDyTPZTaWhSffkJi54TkVIQZv3uHPgV1AHdiEfU6pKK+z/TmRsiVF+MsPQQByuQOrNLI3zoPV3DChHXqGUpTnrlyZaAQCuRMuxrVoFfdNKefSnb/K3aSQswpz45O+Y6mHKkvUAcHc3/vUy48+g7qjvL0D59bz5MwwW3ok6Y2vQAaYvKA2iivRvTiigAsxwXM+O2IP1T0hIIF5Q0O6uJMM9U0srVqP+Q5ijV12cUO7S0TjB/y3tB5K8tL0oZ5hR9nEgOGhHU//BRaA5APZw3AK1JVo7yBkwABTDjyfbGbktYDuH/PQxucajavpEFBdovZ/StTFYM2iEFUTBVj8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:02:35.3583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8941ef9-5294-4b6b-127c-08de8e5c9cfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273172-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 615D635BA8A
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


