Return-Path: <netdev+bounces-41709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3977D7CBBE4
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C74AB211A3
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB531863B;
	Tue, 17 Oct 2023 07:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R4N1BQLw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62006171D8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:03:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5129F
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+pTRweAquAdkshWxJczn9uozu0ruS4cawlx68BT6ysoRZqxS08zmPD5e9a7k6poR9QIsfjO2Jxy+QEjTeSF40Iw0OgAewMCqu5tigNloG378Sd36/qWBOzzte8RRpruoBS7jLNpuiTUWTTyVX2VI+lvmfP6HqZAfHCCvfssOZe9orW1RuHktNmcTlx07H/AbZTZVkwRugkL5xcPJzNupmALXqWIwhgPYi1tT1Px+Ce29NOD5CW85Fk4aIcTMKn+uGEEWqAKuMSLE8alzFF0QQJEC7PNNiSYBjnuc8AEBb+NSXEzw0KigQ+GAvdrw6ayXRhT5wL6tuH7COcDb682Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGGtTjVK0HroQQ7REw9R4Cm1hHoPV9/JA9udfoyH+FM=;
 b=C1RBrmqyZhk6//CHqlkIUOqvc5kdcldEulDHy+yuDoaxxaXumEyI+dJvMwK0rqA2HX9Twl41I0ST4XSjtVFQOxdoy4eKNMP0lY51tWY9TGMiNGsi28JlyI4CspmGdlVe/AjX8HCMr80dzKEn1CGO0wineerufagzaAFoMyIZ06dCyX+c7ZeKE5f0/Luh1q3ScD3GWGMBBgnkdTLiEoBfHHvuquV3jA6d+f1VMXcfrOstjIJj6EnwuAhzk5b0722iiq/kjNDnrLinYf+PAXhBS20zcsW7EdNLCj3QGXUS8HdaNGUvfWYMSY3+hdrZv9/a2njn474YGJZB7lVDN8HqXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGGtTjVK0HroQQ7REw9R4Cm1hHoPV9/JA9udfoyH+FM=;
 b=R4N1BQLw0vO+wS92xPrPC9cSv8xEmQtwNHUsBBaeVHuyVAsdy34QrXRPCuDnfoplz4T9OZv0A7cA3MEzyzGHlHOOFsRYsGOC62XqFJ9oHU5UQB0xgLCBwkEMbY4LRAWkUnv4O0Qylp3Afte5hcfEm7FikChq+T4SAhiQuQNPUGL1B4hkWAmG2mgGTlZhBXaGf1KLFMa3UmM7B/SpbUUuIf4FQfVBFrLSunBiNdFx8KdcsA0K5Epg52LDv+eO17cOOUtX79THbJz2BcRbwxeHim0Wa1tQrWkeNAeJsjYYz8lsCG95C88gkLD6r0rVQywbE+6PLrq9IaWiRnw65FtXDw==
Received: from MW3PR06CA0005.namprd06.prod.outlook.com (2603:10b6:303:2a::10)
 by SA1PR12MB6727.namprd12.prod.outlook.com (2603:10b6:806:256::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 07:03:06 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:2a:cafe::63) by MW3PR06CA0005.outlook.office365.com
 (2603:10b6:303:2a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34 via Frontend
 Transport; Tue, 17 Oct 2023 07:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21 via Frontend Transport; Tue, 17 Oct 2023 07:03:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:02:48 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:02:46 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, <roopa@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH iproute2-next 2/8] bridge: fdb: support match on source VNI in flush command
Date: Tue, 17 Oct 2023 10:02:21 +0300
Message-ID: <20231017070227.3560105-3-amcohen@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017070227.3560105-1-amcohen@nvidia.com>
References: <20231017070227.3560105-1-amcohen@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|SA1PR12MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ceb8eb-4331-4462-181c-08dbcedf1d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TyG7ITKhWrj88tNGxcruOQEYjsnTieEQeqqS7v31VcAH5fK0qksmCQMJnpWg7d/O+lz/JX++AU09GMwpwxlAqcmwo7gZWLNUvLVvarh7ZMieZRRcRe55Tml6TV7E0FFNgoTlZDW7SVtjXx/NDKmGbZies2aeJIzTuwPe9pLFSpShjKxmm9qbW79T+/4RZ8ZReeHIV4dZNlp05Des0VuhONzHM0qAZTQ4MPuDlVerJBrUWDVPMN2LIBEV+h1nQkYlxUdEESyuIplrgf0LdoGrAEC/gsMAyE5KLrl1RcC1V2tYIHqOhdych0BRfhGDRmdBXDS+V+Hi5c5ag1N5hDoTtHg57X3mQ2Rsq6n7V8ccx0WZNmtiunXr7bItflLvyAQ1KqIiOPQ7GKqaKQtiiLTGxOG5J49ag/EeDQGstS/rzZUSmTAQ5EtvX+TCD1hOIEJL8KMzpoLBEOP/vII6fxx+CWkA15zkDVGg01UUsl9mVJ/85if2VlNwjs+Kw5DsPi+6nPfErL0/PXZj7US280ru/KsOjCz/exl5oWauJ1fBaTJgGiZ1zE2rIZ0FAW0mz/+E/Eb5Qkg74Fks9/vDVKVa8RIz0uLlcf2dcZjfZnk+rgqAh5AjAf9tB9ygrb7ln8klXgCilvDzdesdXC1DJ3xUy+a0VO1u/DOC4zpQmgzoTTkThld0N9ilMDldjYLPEDsYMzkTsBnpLvpznATd4YsA3LdOEC5T4Od+MmMj8bsT4xM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(186009)(64100799003)(82310400011)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(70586007)(6916009)(316002)(70206006)(1076003)(54906003)(16526019)(40480700001)(36756003)(426003)(83380400001)(356005)(82740400003)(7636003)(47076005)(86362001)(36860700001)(2616005)(107886003)(478600001)(6666004)(336012)(41300700001)(5660300002)(26005)(2906002)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:03:06.2707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ceb8eb-4331-4462-181c-08dbcedf1d19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6727
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend "fdb flush" command to match fdb entries with a specific source VNI.

Example:
$ bridge fdb flush dev vx10 src_vni 1000
This will flush all fdb entries pointing to vx10 with source VNI 1000.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
---
 bridge/fdb.c      | 12 +++++++++++-
 man/man8/bridge.8 |  8 ++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index e01e14f1..12d19f08 100644
--- a/bridge/fdb.c
+++ b/bridge/fdb.c
@@ -45,7 +45,7 @@ static void usage(void)
 		"              [ state STATE ] [ dynamic ] ]\n"
 		"       bridge fdb get [ to ] LLADDR [ br BRDEV ] { brport | dev } DEV\n"
 		"              [ vlan VID ] [ vni VNI ] [ self ] [ master ] [ dynamic ]\n"
-		"       bridge fdb flush dev DEV [ brport DEV ] [ vlan VID ]\n"
+		"       bridge fdb flush dev DEV [ brport DEV ] [ vlan VID ] [ src_vni VNI ]\n"
 		"              [ self ] [ master ] [ [no]permanent | [no]static | [no]dynamic ]\n"
 		"              [ [no]added_by_user ] [ [no]extern_learn ] [ [no]sticky ]\n"
 		"              [ [no]offloaded ]\n");
@@ -700,6 +700,8 @@ static int fdb_flush(int argc, char **argv)
 	char *d = NULL, *brport = NULL;
 	unsigned short ndm_flags = 0;
 	unsigned short ndm_state = 0;
+	unsigned long src_vni = ~0;
+	char *endptr;
 
 	while (argc > 0) {
 		if (strcmp(*argv, "dev") == 0) {
@@ -761,6 +763,12 @@ static int fdb_flush(int argc, char **argv)
 				duparg2("vlan", *argv);
 			NEXT_ARG();
 			vid = atoi(*argv);
+		} else if (strcmp(*argv, "src_vni") == 0) {
+			NEXT_ARG();
+			src_vni = strtoul(*argv, &endptr, 0);
+			if ((endptr && *endptr) ||
+			    (src_vni >> 24) || src_vni == ULONG_MAX)
+				invarg("invalid src VNI\n", *argv);
 		} else if (strcmp(*argv, "help") == 0) {
 			NEXT_ARG();
 		} else {
@@ -807,6 +815,8 @@ static int fdb_flush(int argc, char **argv)
 		addattr32(&req.n, sizeof(req), NDA_IFINDEX, brport_ifidx);
 	if (vid > -1)
 		addattr16(&req.n, sizeof(req), NDA_VLAN, vid);
+	if (src_vni != ~0)
+		addattr32(&req.n, sizeof(req), NDA_SRC_VNI, src_vni);
 	if (ndm_flags_mask)
 		addattr8(&req.n, sizeof(req), NDA_NDM_FLAGS_MASK,
 			 ndm_flags_mask);
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index c52c9331..b1e96327 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -128,6 +128,8 @@ bridge \- show / manipulate bridge addresses and devices
 .IR DEV " ] [ "
 .B vlan
 .IR VID " ] [ "
+.B src_vni
+.IR VNI " ] [ "
 .BR self " ] [ " master " ] [ "
 .BR [no]permanent " | " [no]static " | " [no]dynamic " ] [ "
 .BR [no]added_by_user " ] [ " [no]extern_learn " ] [ "
@@ -892,6 +894,12 @@ specified by this option will override the one specified by dev above.
 the target VLAN ID for the operation. Match forwarding table entries only with the
 specified VLAN ID.
 
+.TP
+.BI src_vni " VNI"
+the src VNI Network Identifier (or VXLAN Segment ID) for the operation. Match
+forwarding table entries only with the specified VNI. Valid if the referenced
+device is a VXLAN type device.
+
 .TP
 .B self
 the operation is fulfilled directly by the driver for the specified network
-- 
2.41.0


