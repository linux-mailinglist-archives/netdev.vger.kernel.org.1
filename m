Return-Path: <netdev+bounces-45916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 544057E055C
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 16:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84AD91C20944
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 15:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5AF1A5B3;
	Fri,  3 Nov 2023 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p/+azi5A"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C2D1A5A5
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 15:15:16 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF64D5F
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 08:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXqo6y6QWxTArZt8VUwQW4z9IbcKK+qt/ATZAJR8h1LkUYob1rXux8CU4jFoS4ExLYdZm24KAT7EeP6bwm82wb1qE0HZhl37+DNJWQwGJn43oZUgAdtQQbV3DCtTk4STmO54fYWJfSddCbKG4hmj/6S/UB/5kbW9S4xdFH2LgQy6wFqDXgwoSLmrt9YxtioQUxIE2QdPusTxwCWJLNLTdeP5nKzEgehEykrK1BaNIiqAwvW21TA3h4YPSkr+CfckNtNOyI+1kUmPdYFQqdMv8gI95+/4e8RKYFA7btPVyIMEDtJGWFpCUlEpDH4dVkyfKlVBRWKEXBcJ8jcDkJnXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmzjC1u5NEJ2AFmKxwZk2pw4ouK4EVEV7rkipcZjSHM=;
 b=EII93AbiJax1kT1nyIkW4+WEAZ0qn+YndCbelL4hFtQc8HN+7XqVXKdLIuOYOiQdmU4Y1txO+JDo3bDGWdtFzFSAEbCkt0F3rvD2DPRr0RjPNHCoEg7ix/CluBAA1/vPilqFmIIwlRUFjovf949uSb2sjtrgAt2pp689W/9LBUmboQlkWRr/n3hs1jSXn1NwFc9MNyHfuyv3dcJx++t5x+8psmdtfWxq9biLlam+ciBhp2AjRTnBWkQsFPXQhJ8j933RsQW867RInyvIExRQbpdlOSq8K2teBGCovu9WadXPNg2MTCdIjVaG6m0nfMWcEW8peMAJYXhBp55ZbuHbfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmzjC1u5NEJ2AFmKxwZk2pw4ouK4EVEV7rkipcZjSHM=;
 b=p/+azi5AE5NZHjyH7tS3aO5dqbMISKZmxU7bPhjwR7V83PRG82Qvf2v5BqQDYyDy+sPQuH3uL7KIb+nxE+baFlbvTAHPSf2/J9tHOkytHei223czDyJjzw69bzsrghSL1FKGHsJLwL/y6RP4e6KYQYUCnp0QyQSu0HWvSKIMqUbjuT5dueLjRdeTXXu/fzw69pI6YXSDO9EghWUfHF+CxObcWHYV9jUB48xd8++cTu/YG4yLV4v8U6AHavQNS9vBiDYCIyploYGxsQFEPZVVi/Dw9pRY3ZXJZYo3MWm/F3mlIx8Aw67Byi/WgfPKGRx/NAI1ZqwDT7l3ikzUxNs0SQ==
Received: from DS7P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::31) by
 DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Fri, 3 Nov 2023 15:15:09 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::25) by DS7P222CA0025.outlook.office365.com
 (2603:10b6:8:2e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 15:15:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 15:15:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 3 Nov 2023
 08:14:59 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 3 Nov 2023
 08:14:59 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Fri, 3 Nov
 2023 08:14:56 -0700
From: Vlad Buslov <vladbu@nvidia.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>,
	<jiri@resnulli.us>, <pablo@netfilter.org>, Vlad Buslov <vladbu@nvidia.com>,
	Paul Blakey <paulb@nvidia.com>
Subject: [PATCH net] net/sched: act_ct: Always fill offloading tuple iifidx
Date: Fri, 3 Nov 2023 16:14:10 +0100
Message-ID: <20231103151410.764271-1-vladbu@nvidia.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 11837c41-2a1d-44e8-7998-08dbdc7faaf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aCnC1PM4zN6k6IAWoSABARW3kHExtT7O2J3uxXwU6zhRjxFWiYSLqWsGj50X2vo1BbJZkkQSzH1Z4h4fjrDDQnV8oZlLGnDJUy3k8e1J9VVVziooXGtcqhvh7uQ6GYyABVn54xWv6u+FqjxZyaNvjOU86zKLEt2rI4pZ61S9NqhOUC7Ab09ESWscU9+0Ixa+RBm28hSKm9Sp1DhD3HBYKEYB9I7eMKiwwYhKiREFHjohJwIo5s2of8FC3Be5r+qsTxv1Hm6uJoOuWeRhHmO6d2yCAcpmpku8RbM7SbhGoKkTJJugj9U56aK93RCfumbNwzUlly3BRGMSTe43nvHPpdB9cFVKHhr97UopodO2uED2VCgJymvM3W3tTYhf9wTC7F5o+l5FNXzSj68yQXruqTXaBQfm7yX6Ot6emP0k+/gS2gE6LK0k7m7vpHbNvhxddyBs6z6rkSm2GoUOMI737TX7Slto41d351t5ROuAH9NOciPbw3LdanAp0oj+l31p7TQugB+j5rVlnpGhDsMis0GP4rx7vqgy6aucxlz6TdkEhtYvpCPPCCNVCUmKycYsWKBln+9i887AHIVAQ1Cx2acPl86dHbKjSag6HP4TDFusHPkW/yk8CzR5Zq6ucyD/tQDEkBaGhQsMSTRvgqJb8e8C4oocMEidK/Gr1xKP/WVRRiE0SOABtM3BvRoo5EhcFOn6/t3/hQZ1t+SQ4HNUy93Ya4WPvLAyU7nrKeN38LXOgTaw7ikWWUFVkn8/fQMS
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(26005)(41300700001)(7696005)(2616005)(107886003)(40460700003)(1076003)(47076005)(356005)(7636003)(82740400003)(36756003)(86362001)(36860700001)(83380400001)(426003)(336012)(8676002)(5660300002)(110136005)(316002)(8936002)(54906003)(70206006)(70586007)(4326008)(2906002)(40480700001)(6666004)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 15:15:08.8706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11837c41-2a1d-44e8-7998-08dbdc7faaf8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449

Referenced commit doesn't always set iifidx when offloading the flow to
hardware. Fix the following cases:

- nf_conn_act_ct_ext_fill() is called before extension is created with
nf_conn_act_ct_ext_add() in tcf_ct_act(). This can cause rule offload with
unspecified iifidx when connection is offloaded after only single
original-direction packet has been processed by tc data path. Always fill
the new nf_conn_act_ct_ext instance after creating it in
nf_conn_act_ct_ext_add().

- Offloading of unidirectional UDP NEW connections is now supported, but ct
flow iifidx field is not updated when connection is promoted to
bidirectional which can result reply-direction iifidx to be zero when
refreshing the connection. Fill in the extension and update flow iifidx
before calling flow_offload_refresh().

Fixes: 9795ded7f924 ("net/sched: act_ct: Fill offloading tuple iifidx")
Reviewed-by: Paul Blakey <paulb@nvidia.com>
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
---
 include/net/netfilter/nf_conntrack_act_ct.h | 34 ++++++++++++---------
 net/openvswitch/conntrack.c                 |  2 +-
 net/sched/act_ct.c                          | 15 ++++++++-
 3 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_act_ct.h b/include/net/netfilter/nf_conntrack_act_ct.h
index 078d3c52c03f..e5f2f0b73a9a 100644
--- a/include/net/netfilter/nf_conntrack_act_ct.h
+++ b/include/net/netfilter/nf_conntrack_act_ct.h
@@ -20,21 +20,6 @@ static inline struct nf_conn_act_ct_ext *nf_conn_act_ct_ext_find(const struct nf
 #endif
 }
 
-static inline struct nf_conn_act_ct_ext *nf_conn_act_ct_ext_add(struct nf_conn *ct)
-{
-#if IS_ENABLED(CONFIG_NET_ACT_CT)
-	struct nf_conn_act_ct_ext *act_ct = nf_ct_ext_find(ct, NF_CT_EXT_ACT_CT);
-
-	if (act_ct)
-		return act_ct;
-
-	act_ct = nf_ct_ext_add(ct, NF_CT_EXT_ACT_CT, GFP_ATOMIC);
-	return act_ct;
-#else
-	return NULL;
-#endif
-}
-
 static inline void nf_conn_act_ct_ext_fill(struct sk_buff *skb, struct nf_conn *ct,
 					   enum ip_conntrack_info ctinfo)
 {
@@ -47,4 +32,23 @@ static inline void nf_conn_act_ct_ext_fill(struct sk_buff *skb, struct nf_conn *
 #endif
 }
 
+static inline struct
+nf_conn_act_ct_ext *nf_conn_act_ct_ext_add(struct sk_buff *skb,
+					   struct nf_conn *ct,
+					   enum ip_conntrack_info ctinfo)
+{
+#if IS_ENABLED(CONFIG_NET_ACT_CT)
+	struct nf_conn_act_ct_ext *act_ct = nf_ct_ext_find(ct, NF_CT_EXT_ACT_CT);
+
+	if (act_ct)
+		return act_ct;
+
+	act_ct = nf_ct_ext_add(ct, NF_CT_EXT_ACT_CT, GFP_ATOMIC);
+	nf_conn_act_ct_ext_fill(skb, ct, ctinfo);
+	return act_ct;
+#else
+	return NULL;
+#endif
+}
+
 #endif /* _NF_CONNTRACK_ACT_CT_H */
diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 0b9a785dea45..3019a4406ca4 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -985,7 +985,7 @@ static int ovs_ct_commit(struct net *net, struct sw_flow_key *key,
 		if (err)
 			return err;
 
-		nf_conn_act_ct_ext_add(ct);
+		nf_conn_act_ct_ext_add(skb, ct, ctinfo);
 	} else if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
 		   labels_nonzero(&info->labels.mask)) {
 		err = ovs_ct_set_labels(ct, key, &info->labels.value,
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 9583645e86c2..0db0ecf1d110 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -376,6 +376,17 @@ static void tcf_ct_flow_tc_ifidx(struct flow_offload *entry,
 	entry->tuplehash[dir].tuple.tc.iifidx = act_ct_ext->ifindex[dir];
 }
 
+static void tcf_ct_flow_ct_ext_ifidx_update(struct flow_offload *entry)
+{
+	struct nf_conn_act_ct_ext *act_ct_ext;
+
+	act_ct_ext = nf_conn_act_ct_ext_find(entry->ct);
+	if (act_ct_ext) {
+		tcf_ct_flow_tc_ifidx(entry, act_ct_ext, FLOW_OFFLOAD_DIR_ORIGINAL);
+		tcf_ct_flow_tc_ifidx(entry, act_ct_ext, FLOW_OFFLOAD_DIR_REPLY);
+	}
+}
+
 static void tcf_ct_flow_table_add(struct tcf_ct_flow_table *ct_ft,
 				  struct nf_conn *ct,
 				  bool tcp, bool bidirectional)
@@ -671,6 +682,8 @@ static bool tcf_ct_flow_table_lookup(struct tcf_ct_params *p,
 	else
 		ctinfo = IP_CT_ESTABLISHED_REPLY;
 
+	nf_conn_act_ct_ext_fill(skb, ct, ctinfo);
+	tcf_ct_flow_ct_ext_ifidx_update(flow);
 	flow_offload_refresh(nf_ft, flow, force_refresh);
 	if (!test_bit(IPS_ASSURED_BIT, &ct->status)) {
 		/* Process this flow in SW to allow promoting to ASSURED */
@@ -1034,7 +1047,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		tcf_ct_act_set_labels(ct, p->labels, p->labels_mask);
 
 		if (!nf_ct_is_confirmed(ct))
-			nf_conn_act_ct_ext_add(ct);
+			nf_conn_act_ct_ext_add(skb, ct, ctinfo);
 
 		/* This will take care of sending queued events
 		 * even if the connection is already confirmed.
-- 
2.39.2


