Return-Path: <netdev+bounces-267406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fxFkNq3ss2m4dQAAu9opvQ
	(envelope-from <netdev+bounces-267406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:53:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BED281C7B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DB71300B8D7
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C821038A716;
	Fri, 13 Mar 2026 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sgbtREzk"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6624C3328FD
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399204; cv=fail; b=L/H3ZTLco0woIOTcKzpuqNp4bKrPG8HkHj1/skW8U+AfIzz6Zme2RTZNrHcXKs3EKz61gfBC56OkWRku+Rg6hlpfNA3L1HFhdo+jl0b6pBkriiVRMrJp/BiuRObLygGccQaKEQwu0Y/iGlzD/HvYLpbbEsUDfd61GUyBFpkk6d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399204; c=relaxed/simple;
	bh=FWRWuT6eItKDJ1a38ERiOBTmgRdUMGNXv8mSbpgtNtk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8GPNPlhbhzJ48NCmHMJC9UTVKz9I8TqeKmoyxwn6Z5MJdff5XcnljX/cn7thsR+7+3WLUSfmFHW12QJxYBSwcDM116wmiABQDI5ma3jDsvKTOsvLFC6IdXEFsHtD0TQ3c7TIBEEONbWue0QQ4BYpAa75pXdEUlKq308EAAl1QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sgbtREzk; arc=fail smtp.client-ip=52.101.48.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQtH1Xc0/8mHgSSB9/OQRFfvFeRA24ABHOc2RxLxuq3cmoC1iklRVTQ2gYYmaohb80MLwLJwSdtmauFeEwrpgcfQe8e0PxMmJovdetKkLwB5qpetALZOpAne7n9/MCDBOynrAk+BCsOeXZCP/aBXH0YzUctQbg8gRPUyBNFCASicoQ8x4SEwCH8HZTeJwtXN6//bOLS4WsVrtcxIrkMNjKXGdAH1gnB3bKeskqU59qM4fyWZibAwPnAc2ntFDxyIzW0cHt/Pwn/eAGElpBsNu8foxzcDIGPmPHC6wbwFn9ilMJ1qI1DU8bJ5z58acUunO1cpzZ8H4oNXIypKGwdX4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcUIG3dPrKhiE/fCiDO9oI65FWj2c1TUBL8NXOvbPxk=;
 b=MZZ3hBATLU+A7MYtPoaV0/CIynC28umajDYT56V9FGkqiF3pm7nE7vefOg3m5Ql141xBEp14CfaGZW182MTsjBX1owxGGmzuJIZdjTzMmq6JTUZ2wIwa/OxJdhiV34eF1FMV+NsTAl1tJBX4ijJaHNqmLKIzeCdOnCM/mO5lc72csJ2xCo05mcobjQy3A80Y5a+2DFa+opRwC3dkxjGYDoYGfTVwCnwjOHtt8FJ56zq8SD/YFxtpFBKBzYt45/bonIPtGN7VbtJvK9XIXFjjZ1N9j4rt3PB3EeHjc0Vw5Cz0zSzvfNlTk9MbmAamwft3xzc/m3WbgHq+YvYtwia0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcUIG3dPrKhiE/fCiDO9oI65FWj2c1TUBL8NXOvbPxk=;
 b=sgbtREzksHpH/XVP0T9abb0V9+7KaF8GHijREhbt2W83HdZjIGM57c00Slnpo52CMKg1iFUmyLUDpi+ooyRvALDfZWCK2mw35W4/Wl1kf84ZPuccqDZzPJMuM/0lSgFw6ZwuF4KWUfkAvFXXWTWEbaz5osbeJ4sNjhrybJAXSaH3w209zyJMFCZu1ZM8/g61YjrBtkNnvE9mRP5fbCTVQvoIIK6xvJC+PJWNS77x5T2dEFq/9XAU5+7Ub5TAc/jz2PMwqTWgl1vO45rU4UJNgaW9JscXw+k0oqvPe7AMc94no7IyCTQWoAYp8s6BeN/olKK7xegtCe0QKmb5GL72zQ==
Received: from SJ0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:a03:2c0::14)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 10:53:18 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::b5) by SJ0PR13CA0009.outlook.office365.com
 (2603:10b6:a03:2c0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.14 via Frontend Transport; Fri,
 13 Mar 2026 10:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 10:53:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 03:53:02 -0700
Received: from pylon.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 13 Mar 2026 03:52:58 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH 3/3] macsec: Support VLAN-filtering lower devices
Date: Fri, 13 Mar 2026 11:52:26 +0100
Message-ID: <20260313105227.1884391-4-cratiu@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313105227.1884391-1-cratiu@nvidia.com>
References: <20260313105227.1884391-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: 7989698c-d1dd-4f7e-4c12-08de80eebc1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BrnqEVtJxX/Ek2bSAGbK68n7O9Yd8zNuWUMXD+0T0F3OSW1gS3w4TYYHawfBWeIUBVkuUmxySaYHzof4U8SbxbSUpKvaRp5ya3u0MMLa/jZqdv8Nx4bflYWHVYjMstVAZdHbVso7t2Y2RVdIUqfP81jk2uLi5z5sR+1avsNJefDzYeR1ZNa5/V4f4Wk1SY+gYv4DzAEOvA5TKsb8W/Bl6vjWsHUky8YWxxqmSge6Ouy2UZ0bCQMVzp3htB+qqCQPU6vxDlk+dpQZylUUcmrEW8woJNMGxdLB79rFYr+Ta/pZHpRAG6vntphTJCjj7XxeN1mU9ql7z3nzcDp8jmERr5BF4lJnTRoovHof69gpLC6UdU+Ueby9l2BhayKkrCCirFXEJ5EMwOURSG/iMyJEXezkdCBu8xBwYOMNPAtc2QEFErqfna37U496TBJy8eHLXS8xy1L3ZQ/UaK3RXCNhNdMVfjWhPceKE4RRw+GR2DTeQt5CHiTJ5EvTj2+hpnK8vejH5QT4l1V9/zMiYwb+1Rq5PYLNo+sIooiSR5wTHaOTsGdlkrumciyr1NDqLbjMasJV138KKxdC4m5J5MKYvcFL8gdnoOBsHaZTdCMbNZQfMZzE09XO+wP0EKy1LUA7HfgIyCiXryLzA3bScxkMnB5BkFC54DKRb59Ct1Zgk3AxrNpCgx4LHczUG3u6P9iaUHpCtsu9TfNoP/iVA4Oo+4/uTVwIeWH97x98BQMyIUMsVggfQEN8Xpo5bLK+2Bww/74BIIsWAQ+XdqvXgg14EQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GJPO1yYb+ypYUF9hfWAnR0LtR7w371GC2pi5y1m36ah3zSiCvGwoMEHtyVmUF8zgs4YSeId5eY5V7welADfh4zntg3RGyf7YWMNfj//ePdzExiczeqfH+Lo1Md1iwj5V52Yaxbe9C09VeX/zFaGTClOCy0zh++Lj/aTrOoWGlwqA+B0PD/upQlZtjWYHPZoWSidHYRVUmBdlQ4AZFgkBqH0XKapEm+9wBv4H5PnNCuocU27rmMQzJWrNAi3+SqjKQ0FwvhtCa74Bs7w4VpLst9JRBxJS9aJrmL/RZgG5FWB7M7SyPLIVv5Qef1zv9IwkOflIbNgMUSHexCYEB2qwxInFW2HPy1Qgs2EedIj4kN25av236iyKkUwBTa9wVjUpEm2KZzFUaURyTB7U0bpIlEUpbjJRJ1WIc2oafgsr26S1cMOL8r5bQ4jT7a14TFif
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 10:53:17.8503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7989698c-d1dd-4f7e-4c12-08de80eebc1d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267406-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D5BED281C7B
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

To avoid the back-and-forth filter updating during rollback, the setting
of macsec->offload is moved after the add/del secy ops. This is safe
since none of the code called from those requires macsec->offload.

[1] commit 0349659fd72f ("macsec: set IFF_UNICAST_FLT priv flag")
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
2.43.0


