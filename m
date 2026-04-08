Return-Path: <netdev+bounces-276465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD1iCKVD1mkFCwgAu9opvQ
	(envelope-from <netdev+bounces-276465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:01:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B613BBA31
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFD4930E8B3E
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 11:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867EF3BE652;
	Wed,  8 Apr 2026 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EE8YKRd4"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B083C1985;
	Wed,  8 Apr 2026 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649271; cv=fail; b=MxI7cVKishA5i/3bzpNCgPf9QR12HTvWBHWGpR9D775H6uPHiIJp+wiPVuY+x40rLDT8oWqHvfVZldTzZFYvzgAFV1tCHEPJrAooSB2fQidNV2VOGLviOqoj5m1O2qfQGfJ2AXIJo/rI1XO1uDEgGQfEDY8cD97pPjYE0u2uyLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649271; c=relaxed/simple;
	bh=l6holG35lLzwMBGpadb42uQbyU1PnDXvgLslf+Bz5nA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFz5RuFRMB71R8jHRbMccHx6BNKqKVzfm7IPLvyKuPU+RvhnsQyKTWcM5D8ZDG4oBhvqj4imRwSv8CiJpMbE6YXeaoLvFQ7knjDscByTywPNRB3Kht5HcirFaWOylzMWeyrfYH4sAhU2dJXCSV0zBnYzINWRL7elwnhYy1QiHiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EE8YKRd4; arc=fail smtp.client-ip=52.101.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEIrHEdT/vv9QLCC3eYcfkeYI0NADHenlVjq77TYRZ9fgGKcTkAEIPbu8JDxtDiulD4C29tKXdAI9ydcX+l6YiNtGhQEIiT1pOrdQa8sHfeio/GOj1bpTC/shnDDLSmwi3LdOnz3aTT84qV6Jb39tkajkUbsjG2fN+nWXeMxXDciUcNrtAdEszKoUhWyXlGZdw36HnvrfUqJ3Bkq+oRKssQVaRTqDLOVu3dwff1gOba0b9EjqiUzuFdPNv3Am0qRCICSEa5A8qhV2Nz0/oEAiSr5qE1IWslgXdu6+AHTa7cF/DkdJueD9PeOwwdYBVOEEb3Lcxu5YIkqPDqV1xz0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hm4iDAqURPgqjiCfqGTJd2fcHeCEmJNXzSzxILc+2DQ=;
 b=ZzheBLLHiBQbf5fWErx3MnT9476basLb6r26VznEwSMgTN5fStf71Zs/L6U+7u3kdj1k5v2o+/cM7owMQfA0f+CEd1X8WmowRXayzX2qk5vvhnJ9Ns6tqAWbnvXQM6pHx6nt8XUK/kZfmb7LkEFBWdZsxeBHQEH3MxJSkWzUuKxswnW3ounq6WwQH+yI+OI7l2NUU51184sY5j9PmjE8BZT/yiUbSNhPE6/nx1FG4i+Vi3KHCfo8vaCku07N5/r3rhDpWGIY6GcMBYU5uLxHQEiqWsEehfLYiQs66GLHSuN1D23qJnZ4GFEQga2e4bBp0rdxRxYEPRN64cG/nTiPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm4iDAqURPgqjiCfqGTJd2fcHeCEmJNXzSzxILc+2DQ=;
 b=EE8YKRd4mSfGUO0WStVCKPs4uGW+sF51FueGWks3ctjVu2VLWRCf/oFkwzuqE48xDDvm8oyonHRCcCfzWx8/oLPwywCz/3vK/OaYlHfyhBWcYCxoRL9FCn0kkDfQAhidwz3OkB65ct6mqtqTnarpa1RN/RfAFlefkuqzkfLtxK1P5CHjHNSctjZWsjX8yjRhaGHROOCUr4GzudEreDpVKLzKYPKjyj89pLPc02Bk3pP5aQPV/0R8eFEfjNJOCPSO5xKUaxRxelX23TZCNftZj/RP6xVjFvs9Be6cu6mqSrQk2IoPFzHs7arQ0xplENjPXd11FcHi15slu/iOYKBitA==
Received: from DS7PR03CA0184.namprd03.prod.outlook.com (2603:10b6:5:3b6::9) by
 PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Wed, 8 Apr 2026 11:54:21 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::f4) by DS7PR03CA0184.outlook.office365.com
 (2603:10b6:5:3b6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 11:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 11:54:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Apr
 2026 04:54:07 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Apr 2026 04:54:03 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, David Wei
	<dw@davidwei.uk>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>
Subject: [PATCH net v8 4/4] macsec: Support VLAN-filtering lower devices
Date: Wed, 8 Apr 2026 14:52:40 +0300
Message-ID: <20260408115240.1636047-5-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 1375d444-d305-4006-ad67-08de95659293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KYakjKwA//2PU/XH6BLpO85pCxchro7h5sEk1Aa+kscIb7vBzXnPxgmHnpKqnZ4JM2VTni4EzsTAnNeuxuGm3o5w8XmSZpWS7FLhLAIP5xk6iDledRZOWluWXBlRK2DCAUtzkoVo5Jg4qy4crVh1nNk+YHiLvWIAc7Gn3L3gGJ87rQK2DtsNsR0E0WBu/9qTODqi/xCaMe8uJkyO/UGhk/EaM3vsM9NNH/ESuTKMXfFJCOUdR/heMVvF0iSdD2DjTNfKd0DTf8cZ+5tGgb7ezyw2+FoYOsKUaKDtB0bsYte0vr8pYnbHEjI3dxnLD37T6ch4KwiMBdyzlgcvxPNl6Q9Ysbjkqk1hzhY1CG7CLifUSJMpnauvEAHfXWfnHycx15cgNwnNo4jHvH27tuhu/NkV2scGc1nz8oC028B3IUotavMnw7NJ+IqSnzNxD1uNlv+eucqCmFXE4Xem1g1/eQGcmtCQ98QKvMPtiFvyP/xHrk3MRfRb9JyfH0CDA9cqB5xf+OIxrNEL2YFArcWU7qg8AMX4NvlIe2mybLPI0sVBIDVssLL6ZHdPTnzZ+EFbwE3eJbTVEoogTTcfIiUCsrBZo+k8+NM33cQ0tlR28nBJ053x1xy6lQn4cAN0r0aEJ4lpyH5vBWpxqFVEz+2EAHdS7viYFm7zKxu0MnpKpK7UOGCoRhEdoWPIpQZnNSfDrKq0QIA1LVzeE4oqVf1mRpUw7RZHyiD9kDbS3EDe+C+PHNi4x+SGIx1TIre0HR5wIs/P+/wsqp0a8VkbSodr+g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dsg931w6nONK8qSeT7QmmiHfMBP8+FsoDSlfu+xQ3IO2b/oNBu4F2fU5us17N3cUonegQIIyC6RgVh5uN/FNQIe+st8errsAoDECAKhy3LkpdTpbtmUYDiMU+xsOPIb6u81+1eG3dPhdG9aXa5nc/fB4gmlqLgsNCQhZAPWuCJnQtH4YHChcvHTclBUnK2uv1i4KdYX8a2Io8KPRG33Q3Ir8aIzvm1pjTtwjg1DlgBoNvw70w2mGf1b2ydBXiR5LqXy2o0FxUpoecOkEEW61RVHnkZg4pHpuQEAWCj5L0z1Wt3RQGroZIyoCeeUQKXQG4Ndv38PLyPh8vQzwLqbhzdwpuO+HuwHWjbKhhgxOK7r3LAUXvAd9N1ynaGLqXSlXBTyhS+zBa1el8Y18lNjl9SU0vyVnl0IKVy7moONIHlLMCpOjdmxhftz6mAnPkrmk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 11:54:21.5084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1375d444-d305-4006-ad67-08de95659293
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276465-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B1B613BBA31
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

In case adding the filters fails, the added ones are rolled back and an
error is returned to the operation toggling the offload state.

Fixes: 0349659fd72f ("macsec: set IFF_UNICAST_FLT priv flag")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/net/macsec.c | 71 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 63 insertions(+), 8 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index f6cad0746a02..6147ee8b1d78 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2584,7 +2584,9 @@ static void macsec_inherit_tso_max(struct net_device *dev)
 		netif_inherit_tso_max(dev, macsec->real_dev);
 }
 
-static int macsec_update_offload(struct net_device *dev, enum macsec_offload offload)
+static int macsec_update_offload(struct net_device *dev,
+				 enum macsec_offload offload,
+				 struct netlink_ext_ack *extack)
 {
 	enum macsec_offload prev_offload;
 	const struct macsec_ops *ops;
@@ -2616,14 +2618,35 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
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
+		ret = vlan_get_rx_ctag_filter_info(dev);
+		if (ret) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "adding ctag VLAN filters failed, err %d",
+					   ret);
+			goto rollback_offload;
+		}
+		ret = vlan_get_rx_stag_filter_info(dev);
+		if (ret) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "adding stag VLAN filters failed, err %d",
+					   ret);
+			vlan_drop_rx_ctag_filter_info(dev);
+			goto rollback_offload;
+		}
 	}
 
 	macsec_set_head_tail_room(dev);
@@ -2633,6 +2656,12 @@ static int macsec_update_offload(struct net_device *dev, enum macsec_offload off
 
 	netdev_update_features(dev);
 
+	return 0;
+
+rollback_offload:
+	macsec->offload = prev_offload;
+	macsec_offload(ops->mdo_del_secy, &ctx);
+
 	return ret;
 }
 
@@ -2673,7 +2702,7 @@ static int macsec_upd_offload(struct sk_buff *skb, struct genl_info *info)
 	offload = nla_get_u8(tb_offload[MACSEC_OFFLOAD_ATTR_TYPE]);
 
 	if (macsec->offload != offload)
-		ret = macsec_update_offload(dev, offload);
+		ret = macsec_update_offload(dev, offload, info->extack);
 out:
 	rtnl_unlock();
 	return ret;
@@ -3486,7 +3515,8 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 }
 
 #define MACSEC_FEATURES \
-	(NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST)
+	(NETIF_F_SG | NETIF_F_HIGHDMA | NETIF_F_FRAGLIST | \
+	 NETIF_F_HW_VLAN_STAG_FILTER | NETIF_F_HW_VLAN_CTAG_FILTER)
 
 #define MACSEC_OFFLOAD_FEATURES \
 	(MACSEC_FEATURES | NETIF_F_GSO_SOFTWARE | NETIF_F_SOFT_FEATURES | \
@@ -3707,6 +3737,29 @@ static int macsec_set_mac_address(struct net_device *dev, void *p)
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
@@ -3748,6 +3801,8 @@ static const struct net_device_ops macsec_netdev_ops = {
 	.ndo_set_rx_mode	= macsec_dev_set_rx_mode,
 	.ndo_change_rx_flags	= macsec_dev_change_rx_flags,
 	.ndo_set_mac_address	= macsec_set_mac_address,
+	.ndo_vlan_rx_add_vid	= macsec_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= macsec_vlan_rx_kill_vid,
 	.ndo_start_xmit		= macsec_start_xmit,
 	.ndo_get_stats64	= macsec_get_stats64,
 	.ndo_get_iflink		= macsec_get_iflink,
@@ -3912,7 +3967,7 @@ static int macsec_changelink(struct net_device *dev, struct nlattr *tb[],
 		offload = nla_get_u8(data[IFLA_MACSEC_OFFLOAD]);
 		if (macsec->offload != offload) {
 			macsec_offload_state_change = true;
-			ret = macsec_update_offload(dev, offload);
+			ret = macsec_update_offload(dev, offload, extack);
 			if (ret)
 				goto cleanup;
 		}
-- 
2.53.0


