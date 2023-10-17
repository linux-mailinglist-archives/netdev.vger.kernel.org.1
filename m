Return-Path: <netdev+bounces-41711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 764EB7CBBE6
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ADD7B210DA
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509F91642C;
	Tue, 17 Oct 2023 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qh8o76O1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465F9182DC
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:03:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C203AB
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:03:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXdm2zUL5dtlAPz5DcXAis02egsD3G7C0vhLpb57Ow2unBX8kso/pvldjVK61/25hkulPM4Un6CGVK7SlzOih1lTj4qLQ0IAnxuA/rp88M677aL9UoBM12em6T4eJXuDxrm9LbMUE5JEem/sAtnmCTmwS/F+5hjdFI/sV6TRV0v6vBg+ZP05NdD4ylo9KiKFylA2HrjyQ1B3nhCNUv/dHPkAps1GvJb+aRzFWKebK99O/iYA+eoZ5/VbzqGid/AZLfNWiL4E0e0BPANcmWHXVLvQzeMWR6iN8reniaYbdoNCkOhgfKfHTcsPPDPAQ5E64c9GaSaelvltrNz3nETSwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpGv+CP7ih4+MvNZAQ8CtQOcujNTjqOQzTfoVu2SXNU=;
 b=YZ4Xr7l3janlKxPnIWEW3DdbZlg1+A2aKD9awgX2v8WrvxjZ2bJE1eIDZy1TFj/imqqq3CTAI5tfBU9txnRYTPZsFxAfhA5fmrnx3hk0V0idefDxQF55xud2yNeERrGGfej/Vtk7i6DSHc5Bb7wobfWv94xHxTRSap1VbG/FjEUVDfczM4Hnzk6YN7EAxSJcc9uKSLBskrB7XCYhHUDRv3KXdGtAgBiGgQvF21pnPCupBWT2qSdDjWXqEpagVPCHfG2ddXiBtn7jenQ8w0Vzm+HI/cMKf1gxKOVnEOWIXQgEKrhnKlU8GME+tKYiV7H5t9pbdgmX3/u2FhefbAIdLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpGv+CP7ih4+MvNZAQ8CtQOcujNTjqOQzTfoVu2SXNU=;
 b=Qh8o76O1ED1TLiVqcM2sKKk6PBYH5COjqLFh8NR/8ZGP1AVgHV6bpFYSHn1mGgjcMLD7i0J/Hkj+AePo0wK2mmUe4cE5tET8Sv1Yn1DYO06RCiHfVAkRm5nnhP9W6cR0r4TZnIHZWch3/Dyio2VZxVrq/wcNHr+QYGlXJtc5abXrwar3/4eED8FYP1c8EBX74Jl1Uk5MW+p4Sh/0sSFihsAaT2dhMCO28mRg95p14bF5sAeWycAfJFWTpG4DmcU/IoJU6JEZuuT7rtzKIRX2dLvXpIsPWWmQ97pHTFHTM4KTYCRE+XXKDRk9YKqmeS3k4jMQXr5ZTsRmzDoZy4pLSQ==
Received: from CYXPR03CA0073.namprd03.prod.outlook.com (2603:10b6:930:d3::23)
 by PH7PR12MB5830.namprd12.prod.outlook.com (2603:10b6:510:1d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 07:03:09 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:d3:cafe::95) by CYXPR03CA0073.outlook.office365.com
 (2603:10b6:930:d3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 07:03:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 07:03:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:02:56 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:02:53 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, <roopa@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH iproute2-next 5/8] bridge: fdb: support match on destination port in flush command
Date: Tue, 17 Oct 2023 10:02:24 +0300
Message-ID: <20231017070227.3560105-6-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|PH7PR12MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 84789046-e54c-43ad-a92e-08dbcedf1e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q/NhF7W+THjxRqGGPp2MA23sxK5joNruI3KtSMORqXODx+AJKQkzZ9z+j2Stm1P6omLVmHduWIBEpE8FfOqymGeMlCa5eNzdpP5yP5Am+276v7S3k+2w5tPHaT55omDkOZvW/vS39eccLY0uHCXD2mbuiYOBYhGh2PWYsvQR/44YoKTq8m/fl50GnF9KPCM7LMkcCZ62PBr69P2aPce74omXuX3nxIVzTMgnikQsZJlpzYYVwiLTlNu8I3HCINezaCj7Unr6Rip7H/hIFbONEvojAXDLQ/iaPBAboSd6420x9CImxcsziTP8fwpIQ93y4vp/dcgRmJY/Nq32Van3u6MTPzeJmty2JTUmxTUujDvY9VVGSwVDLvfvw/TVEb9L6OQCZQ7Y68FYzd198THtTGlKL/jMgYaCwHXSk9tlHAwdZeMwrjP6wOIOf2lFlsCPxdy+oxP3EY81fvMisKCN0vOzdx7gq9cEFo35CXAlaEvEzgATHAwxXNvaAJ9k8lmFF/xjlE358Wlys5Llp8frUrW4zJ0HQaiZnUw156Ki3Ov5AVBi3AtTn+0KOlRCijIyQzVRbupIGl6UXGqNQs9ZRZ69yKSaVk/qhd5m39CKf9i/Q6uwfDvrZInbo1Ghwy4eKhtBSLSVMm/z+jHLZCCd7h5ns4QLoZKx/XqHd8Z8BJetK4ivXo030JeNm7itT2t+ZuO8LWAW0xBRGqAOnp3M68/mgucBfVRaB+BTBqp+tAA=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(82310400011)(1800799009)(64100799003)(451199024)(186009)(36840700001)(40470700004)(46966006)(36860700001)(47076005)(40480700001)(7636003)(356005)(82740400003)(478600001)(2906002)(54906003)(70586007)(316002)(70206006)(6666004)(6916009)(8936002)(5660300002)(41300700001)(4326008)(8676002)(2616005)(107886003)(83380400001)(336012)(426003)(1076003)(26005)(16526019)(40460700003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:03:08.7723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84789046-e54c-43ad-a92e-08dbcedf1e8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5830
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend "fdb flush" command to match fdb entries with a specific destination
port.

Example:
$ bridge fdb flush dev vx10 port 1111
This will flush all fdb entries pointing to vx10 with destination port
1111.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
---
 bridge/fdb.c      | 21 ++++++++++++++++++++-
 man/man8/bridge.8 |  8 ++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index 69f0d9e4..d9665bd5 100644
--- a/bridge/fdb.c
+++ b/bridge/fdb.c
@@ -46,7 +46,7 @@ static void usage(void)
 		"       bridge fdb get [ to ] LLADDR [ br BRDEV ] { brport | dev } DEV\n"
 		"              [ vlan VID ] [ vni VNI ] [ self ] [ master ] [ dynamic ]\n"
 		"       bridge fdb flush dev DEV [ brport DEV ] [ vlan VID ] [ src_vni VNI ]\n"
-		"              [ nhid NHID ] [ vni VNI ] [ self ] [ master ]\n"
+		"              [ nhid NHID ] [ vni VNI ] [ port PORT ] [ self ] [ master ]\n"
 		"	       [ [no]permanent | [no]static | [no]dynamic ]\n"
 		"              [ [no]added_by_user ] [ [no]extern_learn ] [ [no]sticky ]\n"
 		"              [ [no]offloaded ]\n");
@@ -703,6 +703,7 @@ static int fdb_flush(int argc, char **argv)
 	unsigned short ndm_state = 0;
 	unsigned long src_vni = ~0;
 	unsigned long vni = ~0;
+	unsigned long port = 0;
 	__u32 nhid = 0;
 	char *endptr;
 
@@ -782,6 +783,18 @@ static int fdb_flush(int argc, char **argv)
 			if ((endptr && *endptr) ||
 			    (vni >> 24) || vni == ULONG_MAX)
 				invarg("invalid VNI\n", *argv);
+		} else if (strcmp(*argv, "port") == 0) {
+			NEXT_ARG();
+			port = strtoul(*argv, &endptr, 0);
+			if (endptr && *endptr) {
+				struct servent *pse;
+
+				pse = getservbyname(*argv, "udp");
+				if (!pse)
+					invarg("invalid port\n", *argv);
+				port = ntohs(pse->s_port);
+			} else if (port > 0xffff)
+				invarg("invalid port\n", *argv);
 		} else if (strcmp(*argv, "help") == 0) {
 			NEXT_ARG();
 		} else {
@@ -834,6 +847,12 @@ static int fdb_flush(int argc, char **argv)
 		addattr32(&req.n, sizeof(req), NDA_NH_ID, nhid);
 	if (vni != ~0)
 		addattr32(&req.n, sizeof(req), NDA_VNI, vni);
+	if (port) {
+		unsigned short dport;
+
+		dport = htons((unsigned short)port);
+		addattr16(&req.n, sizeof(req), NDA_PORT, dport);
+	}
 	if (ndm_flags_mask)
 		addattr8(&req.n, sizeof(req), NDA_NDM_FLAGS_MASK,
 			 ndm_flags_mask);
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index b21d9b25..4255364d 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -134,6 +134,8 @@ bridge \- show / manipulate bridge addresses and devices
 .IR NHID " ] ["
 .B vni
 .IR VNI " ] [ "
+.B port
+.IR PORT " ] ["
 .BR self " ] [ " master " ] [ "
 .BR [no]permanent " | " [no]static " | " [no]dynamic " ] [ "
 .BR [no]added_by_user " ] [ " [no]extern_learn " ] [ "
@@ -915,6 +917,12 @@ the VXLAN VNI Network Identifier (or VXLAN Segment ID) for the operation. Match
 forwarding table entries only with the specified VNI. Valid if the referenced
 device is a VXLAN type device.
 
+.TP
+.BI port " PORT"
+the UDP destination PORT number for the operation. Match forwarding table
+entries only with the specified PORT. Valid if the referenced device is a VXLAN
+type device.
+
 .TP
 .B self
 the operation is fulfilled directly by the driver for the specified network
-- 
2.41.0


