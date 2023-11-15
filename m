Return-Path: <netdev+bounces-48078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FD97EC759
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 16:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86EB1C20BAB
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C96839FD7;
	Wed, 15 Nov 2023 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SCmKSzDk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5CB39FD3
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 15:33:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E17101
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 07:32:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoJaLTGtjJVsmubkwmpoWGYHoVpt2edlFjCLBQy9GcpxWu26+Ev1CpX3VQjY1n0lE6IBGeOagqJwaeoNUsh9rLpNF82HzJ2YVxR1aet6jXV9sSVtecPnNsVLl/JSMQtnx8BSirni8gDP/esBrbxYy6xOb2bCq8aTgfgxvovPLCM10NIPh5paSvqIHOAJ/dsUNDIjVPleTR3fXDlPgQtShTh2qss233dF6MT6Sgr2EsL7dI3KpHdLAlQNG2mJMmpV5S5BwmEkhI4h0ygzLYxBRNf0nPKM2J7CYYU8fjld7mhhEObulFKFIaWRNY3mVPQEKUFACdJnU0bCiO8sggrU1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I53FrI5scooQFI/R/44vlL7va4Nlb2hJXNNIVjy92g8=;
 b=kGd/xaX1oVrcmVZeNeEHvU2zwKLm1iIF+lzHE3za4Ok8ceqQYOwbZiPf1dJK+HTdPajFKN7VNaS5kR/0+8YfqXLffvr/mS2I3QfB+v2KHJ+6ENZrcnWSXVj0qxWofaQFZTR79LoxNL4XD69XWW3QuY/ljHrR6uhoh3009jAAIHGwjOS0klNRyBwa3sOUgwdAnMJV9pq4A9nx0u6kWR40CWGNAjJTyR5QEcDPWLg9Vq5IIlFfQ9MFlGnQ/zsixnMGtspamJSZrsj8uTk5AI0+wk9cHUOqvcnu0Noy4edY8j73V8PZ9fSizxNr0OF94lRYJT7hnpFkVHm1qVG5ayT2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I53FrI5scooQFI/R/44vlL7va4Nlb2hJXNNIVjy92g8=;
 b=SCmKSzDkkMCODMqPqIpFOCuM9R6E5/gDxFOPQ4/+NzHZb+whLMoj6SHjG6eThubitR5IpOHizzb2zRXbJEmJ6ZzZyXHVD4cZ7XnC5ZmXMGvZPGFVkXf7uVbomKvTamMNpWEf4aErIZmkh/Yeflp3JpPhCgs/cFY9rC0BGNwIz9A4drlywASs2taz+UG0sxo3XDsPrANpGNRKxXypXTvcvthtUdKv/6J9ys2A2QoWLYIujv5PAE8ZjqcaKohVq9eQfl3TU8qAsP6F8cAKt24oukVVqkSK5Uzq0MRYV0j4PgE9g2IWeCE++zT1APpb558eywe0J9e2IzPQM/rXo4P33Q==
Received: from SA9PR11CA0028.namprd11.prod.outlook.com (2603:10b6:806:6e::33)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 15:32:56 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:6e:cafe::75) by SA9PR11CA0028.outlook.office365.com
 (2603:10b6:806:6e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Wed, 15 Nov 2023 15:32:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 15:32:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 07:32:32 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 07:32:30 -0800
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, Stephen Hemminger
	<stephen@networkplumber.org>, <netdev@vger.kernel.org>
CC: Patrisious Haddad <phaddad@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH iproute2-next 3/3] lib: utils: Add parse_one_of_deprecated(), parse_on_off_deprecated()
Date: Wed, 15 Nov 2023 16:31:59 +0100
Message-ID: <8ca3747c14bacccf87408280663c0598d0dc824e.1700061513.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700061513.git.petrm@nvidia.com>
References: <cover.1700061513.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e516c4-34e5-443f-9c9e-08dbe5f0241b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MojuZoHvm2sIMLd2wR2B0xSyqycb0HSx+q78yFbVvZkwiIUZtk+yhbIeMnirWU1D//3pP58REjh4PqPttGVeMBKMY2iw9gIBEleV8R2o9K0wQcfbzK8cEovRV/+3Vwzl7tNRO2GMeUZ4sOUAdgFXNmx4Orx13yAPIk9Z9EzDB49QyMhSAaAkOQzaLq7o0QM8Et9/Md++kJiU6XIT1Reicogvgnkvd3+fOxPOAKWss0rgg9IB60D656zQbqt9SuibkAnvweJfSDel+hvBgFQmEI7qNs8GQE1mPNTBWKrhv10U0kCTvkzZ3scw4ghAcduvU8WBcUVZxKPF+SDjtCkzHb0wBu9GTU+qpHFptFOljFBErNjU17ZOu9NBK0+f6XEZG5NeVSe1xFLgDEgaV0ze5vlEnuyUSecNGob8gnjQ5cwr/QWnpUKt8vvUcT7BUyjNHkUZVYFeZcJWoreUyMmyZTCbw6hkKjYvFRCEBubWsBtOKbxh5e15rorJQ4+GvlxrjqXYFevWDKUpl8kzzbQqcOMLXAc0W9iFAk+1o1TfxkX+BlXHJYcnZDbSreAccifSyaeFUeNaDZWyAXbQ1ZJaJYlksGMmIlXt+wax/QJxTBkV7PM4q/iHLLu1AjUSMYDBNEfficYShnyet/OqZ7FL0Bx4ndN/dGv/9LY+hF0WfYEKZvwf6KDYVjhKU01VlrIaUJltcRgurEEox2srQd75DKN/7Zyt2w1kURvz0yO1iLGlTDJrAnTs3yXo/DWieUjhtKVBE7TjTKlZjRPdv51+Mg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(4326008)(66899024)(40460700003)(36756003)(426003)(336012)(26005)(2906002)(66574015)(16526019)(30864003)(83380400001)(356005)(82740400003)(47076005)(86362001)(41300700001)(36860700001)(7636003)(2616005)(5660300002)(107886003)(478600001)(40480700001)(316002)(70586007)(54906003)(70206006)(110136005)(6666004)(8676002)(8936002)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 15:32:56.2352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e516c4-34e5-443f-9c9e-08dbe5f0241b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136

The functions parse_on_off() and parse_one_of() currently use matches() for
string comparison under the hood. This has some odd consequences. In
particular, "o" can be used as a shorthand for "off", which is not obvious,
because "o" is the prefix of both. By sheer luck, the end result actually
makes some sense: "on" means on, anything else means off (or errors out).
Similar issues are in principle also possible for parse_one_of() uses,
though currently this does not come up.

Ideally parse_on_off() would accept the strings "on" and "off" and no
others, likewise for parse_one_of().

Therefore in this patch, rename the old matches()-based parsers to
parse_one_of_deprecated() and parse_on_off_deprecated(). Introduce
new strcmp()-based parsers, parse_one_of() and parse_on_off(), for
future users.

All existing users have been converted to the _deprecated() variants,
with one exception for RDMA's sys_set_privileged_qkey_args(), which was
introduced recently enough that it is unlikely to have users relying
on the broken behavior.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 bridge/link.c            | 48 ++++++++++++++++++++++++++--------------
 bridge/vlan.c            |  4 ++--
 dcb/dcb_ets.c            |  6 +++--
 dcb/dcb_pfc.c            |  5 +++--
 include/utils.h          |  4 ++++
 ip/iplink.c              | 15 ++++++++-----
 ip/iplink_bridge_slave.c |  2 +-
 ip/ipmacsec.c            | 27 +++++++++++++---------
 ip/ipstats.c             |  3 ++-
 lib/utils.c              | 11 +++++++++
 10 files changed, 84 insertions(+), 41 deletions(-)

diff --git a/bridge/link.c b/bridge/link.c
index 1c8faa85..2a83c914 100644
--- a/bridge/link.c
+++ b/bridge/link.c
@@ -374,37 +374,44 @@ static int brlink_modify(int argc, char **argv)
 			d = *argv;
 		} else if (strcmp(*argv, "guard") == 0) {
 			NEXT_ARG();
-			bpdu_guard = parse_on_off("guard", *argv, &ret);
+			bpdu_guard = parse_on_off_deprecated("guard",
+							     *argv, &ret);
 			if (ret)
 				return ret;
 		} else if (strcmp(*argv, "hairpin") == 0) {
 			NEXT_ARG();
-			hairpin = parse_on_off("hairpin", *argv, &ret);
+			hairpin = parse_on_off_deprecated("hairpin",
+							  *argv, &ret);
 			if (ret)
 				return ret;
 		} else if (strcmp(*argv, "fastleave") == 0) {
 			NEXT_ARG();
-			fast_leave = parse_on_off("fastleave", *argv, &ret);
+			fast_leave = parse_on_off_deprecated("fastleave",
+							     *argv, &ret);
 			if (ret)
 				return ret;
 		} else if (strcmp(*argv, "root_block") == 0) {
 			NEXT_ARG();
-			root_block = parse_on_off("root_block", *argv, &ret);
+			root_block = parse_on_off_deprecated("root_block",
+							     *argv, &ret);
 			if (ret)
 				return ret;
 		} else if (strcmp(*argv, "learning") == 0) {
 			NEXT_ARG();
-			learning = parse_on_off("learning", *argv, &ret);
+			learning = parse_on_off_deprecated("learning",
+							   *argv, &ret);
 			if (ret)
 				return ret;
 		} else if (strcmp(*argv, "learning_sync") == 0) {
 			NEXT_ARG();
-			learning_sync = parse_on_off("learning_sync", *argv, &ret);
+			learning_sync = parse_on_off_deprecated("learning_sync",
+								*argv, &ret);
 			if (ret)
 				return ret;
 		} else if (strcmp(*argv, "flood") == 0) {
 			NEXT_ARG();
-			flood = parse_on_off("flood", *argv, &ret);
+			flood = parse_on_off_deprecated("flood",
+							*argv, &ret);
 			if (ret)
 				return ret;
 		} else if (strcmp(*argv, "mcast_router") == 0) {
@@ -412,17 +419,20 @@ static int brlink_modify(int argc, char **argv)
 			mcast_router = atoi(*argv);
 		} else if (strcmp(*argv, "mcast_flood") == 0) {
 			NEXT_ARG();
-			mcast_flood = parse_on_off("mcast_flood", *argv, &ret);
+			mcast_flood = parse_on_off_deprecated("mcast_flood",
+							      *argv, &ret);
 			if (ret)
 				return ret;
 		} else if (strcmp(*argv, "bcast_flood") == 0) {
 			NEXT_ARG();
-			bcast_flood = parse_on_off("bcast_flood", *argv, &ret);
+			bcast_flood = parse_on_off_deprecated("bcast_flood",
+							      *argv, &ret);
 			if (ret)
 				return ret;
 		} else if (strcmp(*argv, "mcast_to_unicast") == 0) {
 			NEXT_ARG();
-			mcast_to_unicast = parse_on_off("mcast_to_unicast", *argv, &ret);
+			mcast_to_unicast = parse_on_off_deprecated("mcast_to_unicast",
+								   *argv, &ret);
 			if (ret)
 				return ret;
 		} else if (strcmp(*argv, "mcast_max_groups") == 0) {
@@ -466,33 +476,37 @@ static int brlink_modify(int argc, char **argv)
 			flags |= BRIDGE_FLAGS_MASTER;
 		} else if (strcmp(*argv, "neigh_suppress") == 0) {
 			NEXT_ARG();
-			neigh_suppress = parse_on_off("neigh_suppress", *argv, &ret);
+			neigh_suppress = parse_on_off_deprecated("neigh_suppress",
+								 *argv, &ret);
 			if (ret)
 				return ret;
 		} else if (strcmp(*argv, "neigh_vlan_suppress") == 0) {
 			NEXT_ARG();
-			neigh_vlan_suppress = parse_on_off("neigh_vlan_suppress",
-							   *argv, &ret);
+			neigh_vlan_suppress =
+				parse_on_off_deprecated("neigh_vlan_suppress",
+							*argv, &ret);
 			if (ret)
 				return ret;
 		} else if (strcmp(*argv, "vlan_tunnel") == 0) {
 			NEXT_ARG();
-			vlan_tunnel = parse_on_off("vlan_tunnel", *argv, &ret);
+			vlan_tunnel = parse_on_off_deprecated("vlan_tunnel",
+							      *argv, &ret);
 			if (ret)
 				return ret;
 		} else if (strcmp(*argv, "isolated") == 0) {
 			NEXT_ARG();
-			isolated = parse_on_off("isolated", *argv, &ret);
+			isolated = parse_on_off_deprecated("isolated",
+							   *argv, &ret);
 			if (ret)
 				return ret;
 		} else if (strcmp(*argv, "locked") == 0) {
 			NEXT_ARG();
-			locked = parse_on_off("locked", *argv, &ret);
+			locked = parse_on_off_deprecated("locked", *argv, &ret);
 			if (ret)
 				return ret;
 		} else if (strcmp(*argv, "mab") == 0) {
 			NEXT_ARG();
-			macauth = parse_on_off("mab", *argv, &ret);
+			macauth = parse_on_off_deprecated("mab", *argv, &ret);
 			if (ret)
 				return ret;
 		} else if (strcmp(*argv, "backup_port") == 0) {
diff --git a/bridge/vlan.c b/bridge/vlan.c
index dfc62f83..338b9b0c 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -361,8 +361,8 @@ static int vlan_option_set(int argc, char **argv)
 			int ret;
 
 			NEXT_ARG();
-			neigh_suppress = parse_on_off("neigh_suppress", *argv,
-						      &ret);
+			neigh_suppress = parse_on_off_deprecated("neigh_suppress",
+								 *argv, &ret);
 			if (ret)
 				return ret;
 			addattr8(&req.n, sizeof(req),
diff --git a/dcb/dcb_ets.c b/dcb/dcb_ets.c
index c2088105..ea8786ff 100644
--- a/dcb/dcb_ets.c
+++ b/dcb/dcb_ets.c
@@ -61,7 +61,8 @@ static int dcb_ets_parse_mapping_tc_tsa(__u32 key, char *value, void *data)
 	__u8 tsa;
 	int ret;
 
-	tsa = parse_one_of("TSA", value, tsa_names, ARRAY_SIZE(tsa_names), &ret);
+	tsa = parse_one_of_deprecated("TSA", value, tsa_names,
+				      ARRAY_SIZE(tsa_names), &ret);
 	if (ret)
 		return ret;
 
@@ -274,7 +275,8 @@ static int dcb_cmd_ets_set(struct dcb *dcb, const char *dev, int argc, char **ar
 			return 0;
 		} else if (matches(*argv, "willing") == 0) {
 			NEXT_ARG();
-			ets.willing = parse_on_off("willing", *argv, &ret);
+			ets.willing = parse_on_off_deprecated("willing",
+							      *argv, &ret);
 			if (ret)
 				return ret;
 		} else if (matches(*argv, "tc-tsa") == 0) {
diff --git a/dcb/dcb_pfc.c b/dcb/dcb_pfc.c
index aaa09022..a89c274f 100644
--- a/dcb/dcb_pfc.c
+++ b/dcb/dcb_pfc.c
@@ -73,7 +73,7 @@ static int dcb_pfc_parse_mapping_prio_pfc(__u32 key, char *value, void *data)
 
 	dcb_pfc_to_array(pfc_en, pfc->pfc_en);
 
-	enabled = parse_on_off("PFC", value, &ret);
+	enabled = parse_on_off_deprecated("PFC", value, &ret);
 	if (ret)
 		return ret;
 
@@ -185,7 +185,8 @@ static int dcb_cmd_pfc_set(struct dcb *dcb, const char *dev, int argc, char **ar
 			continue;
 		} else if (matches(*argv, "macsec-bypass") == 0) {
 			NEXT_ARG();
-			pfc.mbc = parse_on_off("macsec-bypass", *argv, &ret);
+			pfc.mbc = parse_on_off_deprecated("macsec-bypass",
+							  *argv, &ret);
 			if (ret)
 				return ret;
 		} else if (matches(*argv, "delay") == 0) {
diff --git a/include/utils.h b/include/utils.h
index add55bfa..c9318c20 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -342,7 +342,11 @@ int do_batch(const char *name, bool force,
 
 int parse_one_of(const char *msg, const char *realval, const char * const *list,
 		 size_t len, int *p_err);
+int parse_one_of_deprecated(const char *msg, const char *realval,
+			    const char * const *list, size_t len, int *p_err);
+
 bool parse_on_off(const char *msg, const char *realval, int *p_err);
+bool parse_on_off_deprecated(const char *msg, const char *realval, int *p_err);
 
 int parse_mapping_num_all(__u32 *keyp, const char *key);
 int parse_mapping_gen(int *argcp, char ***argvp,
diff --git a/ip/iplink.c b/ip/iplink.c
index 9a548dd3..e868bc66 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -470,7 +470,8 @@ static int iplink_parse_vf(int vf, int *argcp, char ***argvp,
 			struct ifla_vf_spoofchk ivs;
 
 			NEXT_ARG();
-			ivs.setting = parse_on_off("spoofchk", *argv, &ret);
+			ivs.setting = parse_on_off_deprecated("spoofchk",
+							      *argv, &ret);
 			if (ret)
 				return ret;
 			ivs.vf = vf;
@@ -481,7 +482,8 @@ static int iplink_parse_vf(int vf, int *argcp, char ***argvp,
 			struct ifla_vf_rss_query_en ivs;
 
 			NEXT_ARG();
-			ivs.setting = parse_on_off("query_rss", *argv, &ret);
+			ivs.setting = parse_on_off_deprecated("query_rss",
+							      *argv, &ret);
 			if (ret)
 				return ret;
 			ivs.vf = vf;
@@ -492,7 +494,8 @@ static int iplink_parse_vf(int vf, int *argcp, char ***argvp,
 			struct ifla_vf_trust ivt;
 
 			NEXT_ARG();
-			ivt.setting = parse_on_off("trust", *argv, &ret);
+			ivt.setting = parse_on_off_deprecated("trust",
+							      *argv, &ret);
 			if (ret)
 				return ret;
 			ivt.vf = vf;
@@ -738,7 +741,8 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
 			int carrier;
 
 			NEXT_ARG();
-			carrier = parse_on_off("carrier", *argv, &err);
+			carrier = parse_on_off_deprecated("carrier",
+							  *argv, &err);
 			if (err)
 				return err;
 
@@ -893,7 +897,8 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
 			unsigned int proto_down;
 
 			NEXT_ARG();
-			proto_down = parse_on_off("protodown", *argv, &err);
+			proto_down = parse_on_off_deprecated("protodown",
+							     *argv, &err);
 			if (err)
 				return err;
 			addattr8(&req->n, sizeof(*req), IFLA_PROTO_DOWN,
diff --git a/ip/iplink_bridge_slave.c b/ip/iplink_bridge_slave.c
index 3821923b..361d5880 100644
--- a/ip/iplink_bridge_slave.c
+++ b/ip/iplink_bridge_slave.c
@@ -319,7 +319,7 @@ static void bridge_slave_parse_on_off(char *arg_name, char *arg_val,
 				      struct nlmsghdr *n, int type)
 {
 	int ret;
-	__u8 val = parse_on_off(arg_name, arg_val, &ret);
+	__u8 val = parse_on_off_deprecated(arg_name, arg_val, &ret);
 
 	if (ret)
 		exit(1);
diff --git a/ip/ipmacsec.c b/ip/ipmacsec.c
index 476a6d1d..e958a37b 100644
--- a/ip/ipmacsec.c
+++ b/ip/ipmacsec.c
@@ -593,7 +593,8 @@ static int do_offload(enum cmd c, int argc, char **argv)
 	if (argc == 0)
 		ipmacsec_usage();
 
-	offload = parse_one_of("offload", *argv, offload_str, ARRAY_SIZE(offload_str), &ret);
+	offload = parse_one_of_deprecated("offload", *argv, offload_str,
+					  ARRAY_SIZE(offload_str), &ret);
 	if (ret)
 		ipmacsec_usage();
 
@@ -1402,7 +1403,7 @@ static int macsec_parse_opt(struct link_util *lu, int argc, char **argv,
 			NEXT_ARG();
 			int i;
 
-			i = parse_on_off("encrypt", *argv, &ret);
+			i = parse_on_off_deprecated("encrypt", *argv, &ret);
 			if (ret != 0)
 				return ret;
 			addattr8(n, MACSEC_BUFLEN, IFLA_MACSEC_ENCRYPT, i);
@@ -1410,7 +1411,7 @@ static int macsec_parse_opt(struct link_util *lu, int argc, char **argv,
 			NEXT_ARG();
 			int i;
 
-			i = parse_on_off("send_sci", *argv, &ret);
+			i = parse_on_off_deprecated("send_sci", *argv, &ret);
 			if (ret != 0)
 				return ret;
 			send_sci = i;
@@ -1420,7 +1421,7 @@ static int macsec_parse_opt(struct link_util *lu, int argc, char **argv,
 			NEXT_ARG();
 			int i;
 
-			i = parse_on_off("end_station", *argv, &ret);
+			i = parse_on_off_deprecated("end_station", *argv, &ret);
 			if (ret != 0)
 				return ret;
 			es = i;
@@ -1429,7 +1430,7 @@ static int macsec_parse_opt(struct link_util *lu, int argc, char **argv,
 			NEXT_ARG();
 			int i;
 
-			i = parse_on_off("scb", *argv, &ret);
+			i = parse_on_off_deprecated("scb", *argv, &ret);
 			if (ret != 0)
 				return ret;
 			scb = i;
@@ -1438,7 +1439,7 @@ static int macsec_parse_opt(struct link_util *lu, int argc, char **argv,
 			NEXT_ARG();
 			int i;
 
-			i = parse_on_off("protect", *argv, &ret);
+			i = parse_on_off_deprecated("protect", *argv, &ret);
 			if (ret != 0)
 				return ret;
 			addattr8(n, MACSEC_BUFLEN, IFLA_MACSEC_PROTECT, i);
@@ -1446,7 +1447,7 @@ static int macsec_parse_opt(struct link_util *lu, int argc, char **argv,
 			NEXT_ARG();
 			int i;
 
-			i = parse_on_off("replay", *argv, &ret);
+			i = parse_on_off_deprecated("replay", *argv, &ret);
 			if (ret != 0)
 				return ret;
 			replay_protect = !!i;
@@ -1457,8 +1458,10 @@ static int macsec_parse_opt(struct link_util *lu, int argc, char **argv,
 				invarg("expected replay window size", *argv);
 		} else if (strcmp(*argv, "validate") == 0) {
 			NEXT_ARG();
-			validate = parse_one_of("validate", *argv, validate_str,
-						ARRAY_SIZE(validate_str), &ret);
+			validate = parse_one_of_deprecated("validate",
+							   *argv, validate_str,
+							   ARRAY_SIZE(validate_str),
+							   &ret);
 			if (ret != 0)
 				return ret;
 			addattr8(n, MACSEC_BUFLEN,
@@ -1472,8 +1475,10 @@ static int macsec_parse_opt(struct link_util *lu, int argc, char **argv,
 				invarg("expected an { 0..3 }", *argv);
 		} else if (strcmp(*argv, "offload") == 0) {
 			NEXT_ARG();
-			offload = parse_one_of("offload", *argv, offload_str,
-					       ARRAY_SIZE(offload_str), &ret);
+			offload = parse_one_of_deprecated("offload", *argv,
+							  offload_str,
+							  ARRAY_SIZE(offload_str),
+							  &ret);
 			if (ret != 0)
 				return ret;
 			addattr8(n, MACSEC_BUFLEN,
diff --git a/ip/ipstats.c b/ip/ipstats.c
index 3f94ff1e..ce6c8a0e 100644
--- a/ip/ipstats.c
+++ b/ip/ipstats.c
@@ -1282,7 +1282,8 @@ static int ipstats_set(int argc, char **argv)
 				return -EINVAL;
 			}
 			at = IFLA_STATS_SET_OFFLOAD_XSTATS_L3_STATS;
-			enable = parse_on_off("l3_stats", *argv, &err);
+			enable = parse_on_off_deprecated("l3_stats",
+							 *argv, &err);
 			if (err)
 				return err;
 		} else if (strcmp(*argv, "help") == 0) {
diff --git a/lib/utils.c b/lib/utils.c
index 7aa3409f..19a2b63d 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1754,6 +1754,12 @@ __parse_one_of(const char *msg, const char *realval,
 
 int parse_one_of(const char *msg, const char *realval, const char * const *list,
 		 size_t len, int *p_err)
+{
+	return __parse_one_of(msg, realval, list, len, p_err, strcmp);
+}
+
+int parse_one_of_deprecated(const char *msg, const char *realval,
+			    const char * const *list, size_t len, int *p_err)
 {
 	return __parse_one_of(msg, realval, list, len, p_err, matches);
 }
@@ -1768,6 +1774,11 @@ static bool __parse_on_off(const char *msg, const char *realval, int *p_err,
 }
 
 bool parse_on_off(const char *msg, const char *realval, int *p_err)
+{
+	return __parse_on_off(msg, realval, p_err, strcmp);
+}
+
+bool parse_on_off_deprecated(const char *msg, const char *realval, int *p_err)
 {
 	return __parse_on_off(msg, realval, p_err, matches);
 }
-- 
2.41.0


