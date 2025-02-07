Return-Path: <netdev+bounces-164114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86BDA2CA3F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C563416875F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F20194AD1;
	Fri,  7 Feb 2025 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="biHvAj/l"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6271719AD8C
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949714; cv=fail; b=dgr+S+ic7VirrOcqAL8UB2I0nYJJRjGQPXqrPUF8zwRFiRsQ/KBXQgcPLcu9Ycxx1kTQ8+ZElfJ9oHiHXFPYOiRMPl0jpePTIt+fo1r0XH0ytLuPrnOAUa42SZOPqPIZEkYH30ujL8I1A6WwEWQLT+SVVLq5OSBQl3kGK7cxTvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949714; c=relaxed/simple;
	bh=8T7tIM0FdzTxCw0KympdSMdWhRWqxMHKpX8f3qiUnls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sd2lGyrC/srmRDy/rzZzJE2XNeOSVXcORWxD5li59yngVMgTpbg8kRCCiqIJPZl2LWK3Z5yElRIK7wbJJMrtS+CGSPsFGrGvzlvwP+IVFfG6OhNwmT/43MjTtcSPfwTCXWEOeYUdHekR14LjPMrVWdBBVMCdNWhIkVMYDU2CQLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=biHvAj/l; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnvi0XThJCX3n9KTbuv3Gdp1sVMpGwQLKnE0VtMElHDE5qOXUxO6HDKzaLExpZaqiS3JNje+lKtO44cwjzpTfRR05mousSw/m+iOuncDMcxFSeqWu3fLazqXfK+3AVabwAxZN6LHPgsfVsf0z9lo4emhhRZBfYk+RW0lMlUVoEzNL+WkBLJPp3MCD5U65R324pMVPftTPvie+55apvw9OHjYOTTN1FSMxhoX6eNk+p7hNdLzaYs0uk/Y7M4fDgLivbX82dFrFz7iNHVrF7GXugiGWcB3bZAr9hDF45s+CnziS1Et31khHRRUmHxZ2JksmFhJkgjD7eENMDvWmF7iuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7aFihIGa4jgh63AtL+EfS+O67CaR3opC5lrSA+RvaA=;
 b=kKz4CxyBDyD6ZKWpOuDFDr/VYHKacRQ5Lh0Ew6oyAMfvFGckaxBJX2jZleAOioeHZgQNYS0NJbszQ/hhFCsmS3lvlRBSioxnfPrTrjpUtKlxlnaFakxpLnN74xpUazBYPeZHT0mS5C08B2b4jmuDPYJk7loRBQ1XAUGRaS9Xo1p153xVjhnFKj2vsH8PJ/gJMHS6bMVameghq5UPqrFnQ+jRpykGUw+Vv+SKEpAus6z6LZOQb936QA+cEfE6wuocDOzLQOSdlgW+KP2XxTV9aO2jcUtsIhZA1Q4yUeB4lz+S7vJ3AP43WRB9UOyKKsLz9RqVqonCSFuLv89+Ycd5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7aFihIGa4jgh63AtL+EfS+O67CaR3opC5lrSA+RvaA=;
 b=biHvAj/lELZRNnsOpulW2rP+xq3LyeHEqpEVBUwMGpJmfbv4o1/zt1wLsfMVVex3phv8YYm8JNuhYWCO0DmS4z+rZ3aF54UuxG6g4XO7nscAJ6oeTQmhrtppf/O2KtIQOJmTpjuKv4n/RwW/x2z7oMsF62jMiAJvoEaU9QH4mcbhhTDkpml3y7vRwadPtwDBvRxBHMch22SlK+S/VOtNwsY1oSOQvnyR29G5E2iahoR7aWzFpC50YxhvPUTQzc91apNlACWGQQa9+IbsSK7HT4MIxZ3sNhX+eDaS33C+3kNECmGVgDszPLx/jeoW8yGlhYs54x3R/yxNnFkUn8VRgw==
Received: from CH2PR20CA0025.namprd20.prod.outlook.com (2603:10b6:610:58::35)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 17:35:07 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::c6) by CH2PR20CA0025.outlook.office365.com
 (2603:10b6:610:58::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Fri,
 7 Feb 2025 17:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 17:35:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Feb 2025
 09:34:50 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 7 Feb
 2025 09:34:46 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
	<razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, Menglong Dong
	<menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>
Subject: [PATCH net-next 1/4] vxlan: Join / leave MC group after remote changes
Date: Fri, 7 Feb 2025 18:34:21 +0100
Message-ID: <6986ccd18ece80d1c1adb028972a2bca603b9c11.1738949252.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738949252.git.petrm@nvidia.com>
References: <cover.1738949252.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|CH2PR12MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: f0eaa4cd-c7b8-4681-654c-08dd479dc3b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MayA7kBLtVJ+b+WyINUSNdfPopGknnl5NwE6isDA/bR0QwJXnlCvdB7o5ecV?=
 =?us-ascii?Q?EVFE9oE7aKjgVU92EMoPVZu3/Vou52He6h4CmO/XtEvmLwWk+xCbPAiieNFF?=
 =?us-ascii?Q?aKeXaQmKjZYHbuvgUIMhKXZ2NcXVeGi52tb8YcJXL/iDpLPTww0sUoC55Olf?=
 =?us-ascii?Q?IqQMTgdvz2vTXGRnWNVed2cbqnUQv2z7qI4a9qcuD2qw4+yZ2nQs/R5z91DO?=
 =?us-ascii?Q?OlBYeU9U9JrxtGxgOqrfGpIGlXtbqMNJ0rB5ITm6TdXUiyCQXLvFdN9Dq9E/?=
 =?us-ascii?Q?hZ6d9nnkZ0XYbBRxkyLBiK86KknRnogm/3b0lSclXXc5iWgKL7pAXgtQaYqJ?=
 =?us-ascii?Q?qRAHc8U/Hj4bpUV2mEpoqhQ7xC2ytcbO/diq1DDKeyMYsl1JLCiHogU1NLHr?=
 =?us-ascii?Q?8GTtrsdC2VMf5kUPzctXF2Lp5f7/zo1eYdJQcRFqjgQZRBQunS1/rho6uls7?=
 =?us-ascii?Q?p9I/emVPtf2aTpuiQQsCTK55YA3/1iAZ9Qy44HtHrI8Nwbt5cfBqsiquS0ul?=
 =?us-ascii?Q?fRF+jxJjssLUsiLgHbpb+Odn8oj+nWWig5GVSjn/UMJa7yfc0BuPBVvQ4nk3?=
 =?us-ascii?Q?xFDmWSa6VjaGlMg+lK9ewmKVEn12U6nHTp8WjFsQft5HU1ysgnBjKzgbnXAq?=
 =?us-ascii?Q?F61VsZY5GGLmiOHGE/iB0K8R4vzt9vXvwSugTBGWee7u+bU8xiMhiawNKAXK?=
 =?us-ascii?Q?HzRSrf3ddpTK16atBjzdVaFxIV2ntI70SskUxvLeiAJpsXTqINBOXSFqivvV?=
 =?us-ascii?Q?HbFjPbMOTDLVvOyd3lvOvrKfT8eNhH/aCXDbXHugfGZ3o54LxrWfWpf1P3zD?=
 =?us-ascii?Q?KkgAXIq3Eu4C1/0wPQXCE8dxwJZdK7e9G62Kes3v7SCOJKCySElY3z6GZE0d?=
 =?us-ascii?Q?1TuwlwNwlsm0JhmXPo7nLwEH06skXaDB8bzl2cQKJi/8HR+PfXktFObCzvrR?=
 =?us-ascii?Q?GTryQFdBovAPzUcPEMnCelFGWNBxSLH8fClGc6vKrsD88WhYYguIDpisjLQ3?=
 =?us-ascii?Q?pNkZZCStbeH8CC4wQElog+I60w+6xeGQncXz0jvrGbDfHRiOwrTCzprqXR91?=
 =?us-ascii?Q?jHilChwt27M/LT30L+l3c2Kgmb27fKztuKmNHIpdA+gRbxcYOmB1TVuw/j74?=
 =?us-ascii?Q?89Qck7FufRBpKW4OG5Gl7S39u/KjMDlw9CrJAiYcvLd+H9hH3t/YYIP2gh2j?=
 =?us-ascii?Q?hPPWTvAwseXOREMu0muCUtOjfNFzxJ7wWlDDStAYRlMccho0KcWHGwjs76D2?=
 =?us-ascii?Q?ebTh2kByjqua8y4r3LBtWqDMeZDqoeBnLRfxfzLroWxRMFFDws9wOT7ru7us?=
 =?us-ascii?Q?+pukmiQFp8wYn4AXc4U31+/NaJwIyl+80DlSvT48sryoJFdk7v1s5rBO49GL?=
 =?us-ascii?Q?Qx4XQsS6jaPpQ+eUgrE45H/EEjOCYBcR7YHPAZwG/uz+W5KAh/vhkL41h/ON?=
 =?us-ascii?Q?fi3iMg9m8rmTnfBwXc5PUmeWIfDnAYZuTUasK3xEfSpvwuZOVKcNnKlyED2G?=
 =?us-ascii?Q?dm3aKcPsSnfjvXg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 17:35:07.3667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0eaa4cd-c7b8-4681-654c-08dd479dc3b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199

When a vxlan netdevice is brought up, if its default remote is a multicast
address, the device joins the indicated group.

Therefore when the multicast remote address changes, the device should
leave the current group and subscribe to the new one. Similarly when the
interface used for endpoint communication is changed in a situation when
multicast remote is configured. This is currently not done.

Both vxlan_igmp_join() and vxlan_igmp_leave() can however fail. So it is
possible that with such fix, the netdevice will end up in an inconsistent
situation where the old group is not joined anymore, but joining the
new group fails. Should we join the new group first, and leave the old one
second, we might end up in the opposite situation, where both groups are
joined. Undoing any of this during rollback is going to be similarly
problematic.

One solution would be to just forbid the change when the netdevice is up.
However in vnifilter mode, changing the group address is allowed, and these
problems are simply ignored (see vxlan_vni_update_group()):

 # ip link add name br up type bridge vlan_filtering 1
 # ip link add vx1 up master br type vxlan external vnifilter local 192.0.2.1 dev lo dstport 4789
 # bridge vni add dev vx1 vni 200 group 224.0.0.1
 # tcpdump -i lo &
 # bridge vni add dev vx1 vni 200 group 224.0.0.2
 18:55:46.523438 IP 0.0.0.0 > 224.0.0.22: igmp v3 report, 1 group record(s)
 18:55:46.943447 IP 0.0.0.0 > 224.0.0.22: igmp v3 report, 1 group record(s)
 # bridge vni
 dev               vni                group/remote
 vx1               200                224.0.0.2

Having two different modes of operation for conceptually the same interface
is silly, so in this patch, just do what the vnifilter code does and deal
with the errors by crossing fingers real hard.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Nikolay Aleksandrov <razor@blackwall.org>
CC: Roopa Prabhu <roopa@nvidia.com>
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>

 drivers/net/vxlan/vxlan_core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 69579425107f..7eba0ee7f602 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3888,6 +3888,11 @@ static void vxlan_config_apply(struct net_device *dev,
 	unsigned short needed_headroom = ETH_HLEN;
 	int max_mtu = ETH_MAX_MTU;
 	u32 flags = conf->flags;
+	bool rem_changed;
+
+	rem_changed = !vxlan_addr_equal(&vxlan->default_dst.remote_ip,
+					&conf->remote_ip) ||
+		      vxlan->default_dst.remote_ifindex != conf->remote_ifindex;
 
 	if (!changelink) {
 		if (flags & VXLAN_F_GPE)
@@ -3899,6 +3904,11 @@ static void vxlan_config_apply(struct net_device *dev,
 			dev->mtu = conf->mtu;
 
 		vxlan->net = src_net;
+
+	} else if (vxlan->dev->flags & IFF_UP) {
+		if (vxlan_addr_multicast(&vxlan->default_dst.remote_ip) &&
+		    rem_changed)
+			vxlan_multicast_leave(vxlan);
 	}
 
 	dst->remote_vni = conf->vni;
@@ -3932,6 +3942,11 @@ static void vxlan_config_apply(struct net_device *dev,
 	dev->needed_headroom = needed_headroom;
 
 	memcpy(&vxlan->cfg, conf, sizeof(*conf));
+
+	if (changelink && vxlan->dev->flags & IFF_UP &&
+	    vxlan_addr_multicast(&vxlan->default_dst.remote_ip) &&
+	    rem_changed)
+		vxlan_multicast_join(vxlan);
 }
 
 static int vxlan_dev_configure(struct net *src_net, struct net_device *dev,
-- 
2.47.0


