Return-Path: <netdev+bounces-44163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FFE7D6B9C
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54BEA1C20E0E
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 12:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2489028696;
	Wed, 25 Oct 2023 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LMwt2IuL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25FD262A7
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:31:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C941E8F
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRiuwFA02XucUkLzjU3kbgVuab57YM6gED0VJSqpn3cfpiUBa048e5acrbPCSeqTX+g+Q0o6hIFTFJg4t+rWuno0psUB/jMZxddrDyX+0KDJjkZz7VE0TqadHqop99v3dfq979jvAFlFUz/25zFSQBhcWO0OafVaiuIeJwfcdNQHEnNGbeypUGOcAlDfhV9Cr3X0gqCa4bvYbi+tsJczPm01amAYnKwVXGV08g4unveRJOyrNzur+y7qUE87Cer1nBkqrKmJ5v6CxGEAfGpv1yUtRN8hQVpF0yGLDluvYNszcpSionYn/RKO9larf43tpfV7GtSOyepNZdRvoOoS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ST6XvMHDUX5gEy83qhweQonEuelrlfH/8Szru5VMm4=;
 b=Za67QWoJz3WPtdEdFjcYFpdiNaEe/kf4ygboQZGNz6y3lG/KWjw8Nd5jaai9pj7e9N+37UkysDsawZRyUlEHStDXi4r3hNEoVGT0ziZe/BZ8N2RjPkxDpnLGqnf/twta3h9dlzRehV4qMTaQuHnBh/6yxPwraKuMD3RcCIDF/0IUrUXtHm7kDzCQTXF7dCtodTKMzYicpdDVc5chXi0XBHMS3tekVDNQCcaoEXDjaC7B7/CVk1xASHC2+UfFQgcZrKuCxzY25VjHv9EQYWSpk1E+x9fNDu/MgcV8/fmXm2Q7lpvMPboMwImSy1wq9D3QY3qEtYgsLzdwtMNe00UHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ST6XvMHDUX5gEy83qhweQonEuelrlfH/8Szru5VMm4=;
 b=LMwt2IuLzXMrdC3b5LxxRpl6wvCA930eDs2+1nqeRT9NYoyKTFE6szs/uRHMhwvKq6CJU2l5QEdElu+Bp4Wzbqamb0RCv9R6lWv7vKNWotnOfFZrS4KIaWmAPRqU0BWlS6f49zJ2M35aoetTbx+yPz7RCWjVJbiApQBtnWrp8V+1+ybbRxYMxXyoZZt2gr+ij0k+Pqo4QdgMk5IMlV3wi3LkPplJQMdvK1vw0Vk01xCA+flHmDawhXuP6UuYSGE+Js5DioCp7BeaOPfPuhR4lnzAvD/snM2p4oaGUTBGutob46nO9Q+amEoG+QhRsAAOro2jaSEjVz+fVUYcKO+sNw==
Received: from DM6PR08CA0004.namprd08.prod.outlook.com (2603:10b6:5:80::17) by
 MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 12:31:19 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::2a) by DM6PR08CA0004.outlook.office365.com
 (2603:10b6:5:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 12:31:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 12:31:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 05:31:08 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 25 Oct 2023 05:31:05 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 04/13] bridge: mcast: Rename MDB entry get function
Date: Wed, 25 Oct 2023 15:30:11 +0300
Message-ID: <20231025123020.788710-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231025123020.788710-1-idosch@nvidia.com>
References: <20231025123020.788710-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9c318f-41ad-467f-8e38-08dbd5564a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	70H3m2AB2hINumRYclnrCwp6KzEC8f5qmX/iWqPcN8nHP1PTxTDU5tvF30YKmDbFamehisT4ce/AjEI29Br+bDKkP4fAPAAMY1BDx04FpVypUVAxSrKvz85HdCOpP0WYez7NA34RMO7NTbYTpqcSr3VLQj0P0l3ySePks/7SnhSIezOMGuTbLqkW69+98Z90YnL1ST8jyE9TwL8+ttl2ME7zN6GrPVpxITsB6nTXY+ktetx3D223Y5o+IMPoZL/tH8Cfr1ctLiiBYOlwasQRvFhjDIMvyFLXQnc/yzC6Gnr8bnt0/n7C6WwczhkciysQnR3zdHFEDY6hgCgWktrfewukB8bxsAYO0b7BK7uckHg6uQmInHoxwFW4kn5ek9+nQzhAFls0BFQxXMpMaloELJn4SEEV/CiqtKDDH4SE2WccNjNTwGVHcKIBAhAzclzwaBVllU1cbCZkH5zkOntNERk6t8o3TjLDN35VSIVVGaLNXk/g+InfVebvsG/yTJa8IITKKUhRd1ieFd813epDan967HvVVpBtPDYDkmYldLMZ7XNyQ/jdZaa9svdXHe0xpH1+FF+q/U6CPAr2oj2L8MFaAXFU3g5FaFPUV8yA+NssrxDzebseZKWviUtbppUray16Q1wyu+tULF0meQzbnQqdkkE757nSJq5ZWzcliLM91Z+d9oULso3VDnO6n/LFMPCFXfRMVacPVXsr4sHd+GXoLo4t92IetPy0YQW4wEnV6gmx1OoB7HhFD3srOuK+
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(82310400011)(186009)(36840700001)(40470700004)(46966006)(36756003)(2906002)(82740400003)(2616005)(110136005)(356005)(316002)(70586007)(6666004)(1076003)(478600001)(40460700003)(54906003)(70206006)(7636003)(426003)(40480700001)(47076005)(83380400001)(336012)(5660300002)(86362001)(4326008)(107886003)(8676002)(41300700001)(36860700001)(8936002)(16526019)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 12:31:19.5271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9c318f-41ad-467f-8e38-08dbd5564a7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786

The current name is going to conflict with the upcoming net device
operation for the MDB get operation.

Rename the function to br_mdb_entry_skb_get(). No functional changes
intended.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_device.c    |  2 +-
 net/bridge/br_input.c     |  2 +-
 net/bridge/br_multicast.c |  5 +++--
 net/bridge/br_private.h   | 10 ++++++----
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 9a5ea06236bd..d624710b384a 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -92,7 +92,7 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 			goto out;
 		}
 
-		mdst = br_mdb_get(brmctx, skb, vid);
+		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
 		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
 		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst))
 			br_multicast_flood(mdst, skb, brmctx, false, true);
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index c729528b5e85..f21097e73482 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -175,7 +175,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 
 	switch (pkt_type) {
 	case BR_PKT_MULTICAST:
-		mdst = br_mdb_get(brmctx, skb, vid);
+		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
 		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
 		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) {
 			if ((mdst && mdst->host_joined) ||
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 96d1fc78dd39..d7d021af1029 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -145,8 +145,9 @@ static struct net_bridge_mdb_entry *br_mdb_ip6_get(struct net_bridge *br,
 }
 #endif
 
-struct net_bridge_mdb_entry *br_mdb_get(struct net_bridge_mcast *brmctx,
-					struct sk_buff *skb, u16 vid)
+struct net_bridge_mdb_entry *
+br_mdb_entry_skb_get(struct net_bridge_mcast *brmctx, struct sk_buff *skb,
+		     u16 vid)
 {
 	struct net_bridge *br = brmctx->br;
 	struct br_ip ip;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 27a7a06660f3..40bbcd9f63b5 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -955,8 +955,9 @@ int br_multicast_rcv(struct net_bridge_mcast **brmctx,
 		     struct net_bridge_mcast_port **pmctx,
 		     struct net_bridge_vlan *vlan,
 		     struct sk_buff *skb, u16 vid);
-struct net_bridge_mdb_entry *br_mdb_get(struct net_bridge_mcast *brmctx,
-					struct sk_buff *skb, u16 vid);
+struct net_bridge_mdb_entry *
+br_mdb_entry_skb_get(struct net_bridge_mcast *brmctx, struct sk_buff *skb,
+		     u16 vid);
 int br_multicast_add_port(struct net_bridge_port *port);
 void br_multicast_del_port(struct net_bridge_port *port);
 void br_multicast_enable_port(struct net_bridge_port *port);
@@ -1345,8 +1346,9 @@ static inline int br_multicast_rcv(struct net_bridge_mcast **brmctx,
 	return 0;
 }
 
-static inline struct net_bridge_mdb_entry *br_mdb_get(struct net_bridge_mcast *brmctx,
-						      struct sk_buff *skb, u16 vid)
+static inline struct net_bridge_mdb_entry *
+br_mdb_entry_skb_get(struct net_bridge_mcast *brmctx, struct sk_buff *skb,
+		     u16 vid)
 {
 	return NULL;
 }
-- 
2.40.1


