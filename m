Return-Path: <netdev+bounces-41871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A417CC13C
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419D11C20D9F
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E81241226;
	Tue, 17 Oct 2023 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sMADj67E"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E9B41765
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 10:56:14 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04250D54
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 03:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0MDyu1TkMM0OBbSEDKYL9uBo9sqyy/IDwQVpjHxkAPp09EKUaJIGraHzKLnhEAqQcU2mLAX9BnCL2eZvDvR6ZgThVuOoITH+lQHwQKRlMufyR0NeRqIQw9bNz+9LMqcFq5nvG0bH+ZqJSrmkl9XMXanO3gV6emVTYdPjsgGJqETorxOtd296kiBKpV3C0iQPpoNv4A7Rrcl6NOcLsiiPt+Fqh+g6PHdSQQGdUNd/SOKSw4IiGdNWZYjR0TW9SQwSpDi63sdMbchf4sxCWdFaKjGPAYPrS8KF9iFmmZqxF5rLRHHbf5cqq+c0BUm5s+ujUXYonDd1rG9LFsGWMw2Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOjn5iVSkDltjjHQa3vjh9w6ll0VWjCI+UFftX2szMU=;
 b=XzbCp3HuxEjfZMS/zTIjHobIsCSzb3D/+bYdFcGlp4gVf4PtS+w7A0sCbVutIpW62OrunaSY8lWe3my9SzDZLCqPmIrN87hI2Z0+hCDVWV+JOXS474sLJNRm35TVNZhHJTf+ld8L4f2+fARpK/0Zv9iSXLb9j14AzGX9fJVKJDEGY7J4ZoH+XjxFKOHbvwdds10ep+oGLKieSPSclJdKBpgBfEAhT9J/dVxv5mFJKLW3IDVUwIy+8UQ8pj8SjH4WbaOfHVE99qKpbcMxrLPFZD7AIAjshfrC6M6o+9sMD8O8N5Z5Q/rl4lQlBIPOYnSNHJByIP6LAm/IAme2nsoZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOjn5iVSkDltjjHQa3vjh9w6ll0VWjCI+UFftX2szMU=;
 b=sMADj67EEThvMqdyGfY+N4oymBIZLKZ8ZWY38t6sX623ciw2L6pJWHoyprSxxg5SDr6W1RV15YLw1hpw1jlNSWuJ325yjppx+A797NKLLjq5eva+MXQms0m+njp1UHDEDaFXfjkY9v9mQl9gv944WIdboOK0Wj5Vd/qbpFWwLdTBK0i2a5JmhNE8ZeZICGqIbvCnv5HeqnpT8GyfKpkAwUQeKbgfJZ3YD3e62pN0y23WcHYWH2KSnaVXcivXwM36igpf1S8EExpZxcuwAs4Mo3JuSvgyfykcvspmzMXf6n0cAbhK8lqZLMjjBM3c05UPV3lz4DOY1StGXPJpi5fjhA==
Received: from DM6PR01CA0002.prod.exchangelabs.com (2603:10b6:5:296::7) by
 CH0PR12MB5299.namprd12.prod.outlook.com (2603:10b6:610:d6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.35; Tue, 17 Oct 2023 10:56:02 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::6b) by DM6PR01CA0002.outlook.office365.com
 (2603:10b6:5:296::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 10:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 10:56:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 03:55:57 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 03:55:55 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, <roopa@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH iproute2-next v2 4/8] bridge: fdb: support match on destination VNI in flush command
Date: Tue, 17 Oct 2023 13:55:28 +0300
Message-ID: <20231017105532.3563683-5-amcohen@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017105532.3563683-1-amcohen@nvidia.com>
References: <20231017105532.3563683-1-amcohen@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|CH0PR12MB5299:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e7db44-aafe-4931-2ffb-08dbceffa791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PfSbkZDzdviwn2lQRZX/JEiadMOEq8lUxha9il7rQxkDiMFxKMnFL2Lp41JA6Bprxaki5OiwTkE1s/BafrumkoxeLlsi/R5i5QifepIZt/1GxoYuQZGLjkic+9fC/yOqx7s6tEjyCloz7/LjHBsVh4kqRu2po21+RfPPJAB2eenpAZMX11qOV7amV8Iw31HMdE1fvuHgse5m3CzzaIHRjV4yF7yWa76G1/0sWA+/aL6AvioCJl49ZceG8kR6gliH9GfUggCJdevzOsu0JDBGodew9/EiMrs6D6V27Hw4iGYxgsyNaIspR7JNhWwGfqiHivNFKGQQgv6xISGF2r3ilx58SyfcgqscKWaHg68Hw5jF8uOPBaQm1sbIMIMy4+l6NP3aRH1/k4zWk84ZyPdWqH2+A0Wcr47a/hwMu3czeyREphDWbjLBOythy2Ghn77dGePedr024JWCnjsL5x0Qw0NKZVR23738kjarxh8UiMfIOuF899piXmyo8v6f8oADsiaiWb6T6ZeRgqKDRBVnZ4HBrtK/JZx8+wbZIjoujCnZzLvn2us9z04lfLJehW9DQkTacoNO+rPaBqttDTsrK1FbvE/GgC/3ylctK/G0P6seB7zCooWNNUN99mq5KwSuCPM2ToBYYpK3LbOLFOLZIytMeVcGfml4iIlGFWfc/lCkoD6iNTHlSdg3uGtjpQV0NHSL4oa7ysSuoDs0Ly+V3fugu43Vf6wEbTwkEmOv9Y651LiteCG6onlvpjIZxCZe
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(1800799009)(64100799003)(82310400011)(451199024)(186009)(36840700001)(40470700004)(46966006)(83380400001)(336012)(426003)(16526019)(26005)(1076003)(41300700001)(5660300002)(8936002)(4326008)(8676002)(107886003)(2616005)(40460700003)(36756003)(86362001)(7636003)(356005)(40480700001)(82740400003)(36860700001)(47076005)(2906002)(478600001)(316002)(70586007)(54906003)(6916009)(6666004)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 10:56:02.5255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e7db44-aafe-4931-2ffb-08dbceffa791
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5299
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend "fdb flush" command to match fdb entries with a specific destination
VNI.

Example:
$ bridge fdb flush dev vx10 vni 1000
This will flush all fdb entries pointing to vx10 with destination VNI 1000.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 bridge/fdb.c      | 11 ++++++++++-
 man/man8/bridge.8 |  8 ++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index 22a86922..16cd7660 100644
--- a/bridge/fdb.c
+++ b/bridge/fdb.c
@@ -46,7 +46,7 @@ static void usage(void)
 		"       bridge fdb get [ to ] LLADDR [ br BRDEV ] { brport | dev } DEV\n"
 		"              [ vlan VID ] [ vni VNI ] [ self ] [ master ] [ dynamic ]\n"
 		"       bridge fdb flush dev DEV [ brport DEV ] [ vlan VID ] [ src_vni VNI ]\n"
-		"              [ nhid NHID ] [ self ] [ master ]\n"
+		"              [ nhid NHID ] [ vni VNI ] [ self ] [ master ]\n"
 		"	       [ [no]permanent | [no]static | [no]dynamic ]\n"
 		"              [ [no]added_by_user ] [ [no]extern_learn ] [ [no]sticky ]\n"
 		"              [ [no]offloaded ]\n");
@@ -702,6 +702,7 @@ static int fdb_flush(int argc, char **argv)
 	unsigned short ndm_flags = 0;
 	unsigned short ndm_state = 0;
 	unsigned long src_vni = ~0;
+	unsigned long vni = ~0;
 	__u32 nhid = 0;
 	char *endptr;
 
@@ -775,6 +776,12 @@ static int fdb_flush(int argc, char **argv)
 			NEXT_ARG();
 			if (get_u32(&nhid, *argv, 0))
 				invarg("\"nid\" value is invalid\n", *argv);
+		} else if (strcmp(*argv, "vni") == 0) {
+			NEXT_ARG();
+			vni = strtoul(*argv, &endptr, 0);
+			if ((endptr && *endptr) ||
+			    (vni >> 24) || vni == ULONG_MAX)
+				invarg("invalid VNI\n", *argv);
 		} else if (strcmp(*argv, "help") == 0) {
 			NEXT_ARG();
 		} else {
@@ -825,6 +832,8 @@ static int fdb_flush(int argc, char **argv)
 		addattr32(&req.n, sizeof(req), NDA_SRC_VNI, src_vni);
 	if (nhid > 0)
 		addattr32(&req.n, sizeof(req), NDA_NH_ID, nhid);
+	if (vni != ~0)
+		addattr32(&req.n, sizeof(req), NDA_VNI, vni);
 	if (ndm_flags_mask)
 		addattr8(&req.n, sizeof(req), NDA_NDM_FLAGS_MASK,
 			 ndm_flags_mask);
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index 254b2fe9..9341c77b 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -132,6 +132,8 @@ bridge \- show / manipulate bridge addresses and devices
 .IR VNI " ] [ "
 .B nhid
 .IR NHID " ] ["
+.B vni
+.IR VNI " ] [ "
 .BR self " ] [ " master " ] [ "
 .BR [no]permanent " | " [no]static " | " [no]dynamic " ] [ "
 .BR [no]added_by_user " ] [ " [no]extern_learn " ] [ "
@@ -907,6 +909,12 @@ device is a VXLAN type device.
 the ECMP nexthop group for the operation. Match forwarding table entries only
 with the specified NHID. Valid if the referenced device is a VXLAN type device.
 
+.TP
+.BI vni " VNI"
+the VXLAN VNI Network Identifier (or VXLAN Segment ID) for the operation. Match
+forwarding table entries only with the specified VNI. Valid if the referenced
+device is a VXLAN type device.
+
 .TP
 .B self
 the operation is fulfilled directly by the driver for the specified network
-- 
2.41.0


