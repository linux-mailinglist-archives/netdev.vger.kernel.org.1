Return-Path: <netdev+bounces-41710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 192957CBBE5
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8F22818F8
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F48718B02;
	Tue, 17 Oct 2023 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HkbmImJW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC262179A1
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:03:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA09B6
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNJb3LzbeWKRdjd2GcN/umH+19NdqeKApma2CYyFQUQxaREqXvo+nnv+qWDyPem0MgQSUOymI+ij37T9/lwN4eHDWrrJtl4h//XiY6DOxf9KNU+GMlxsA0bWpAh4LomBvCVH6conHvsryysJfc/nHwcoFE3PFYgRtNwUe1dijTJkBpE1A+LF+Kzh7FredRPK1rMohxCu/TzFiPuPRptsUS15AJx+lHIPzWUy/hcBw0XpseHJmOjkIvhNCn0eMskoqNkzDM6knaIZFSr5Ux+8ritfDmRx1e77Riq6tWuKj40w8pf9uMfiojb7qFeHJW9/Use/TQO/bX7xhe1Jk6z80A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW4+QHLQvpx9uMZjKglP83W0EYpNN6YlBVoSFK7AbGY=;
 b=LSo/p81R2ZRuD8XJszpvq1dhkt7mgIMPNUDajcTfqA3QBNlz1Mg68iT9qZ3MDgh9azXrYhftL3dBw5p8RM/9dSdwEMw9oXCRLcI0julUhDyA9VEpc4365L4xizY43XRTkBYfa0BXCQ+VyeLxWpf/k9NwOaCZ5A/alnX6o0mJ1WfwqBjFTsRYGW0CpKg5swTRhtjY7A/KPAkZfaqZCOhvStMcAAbOXG+in7bldmKLmg7JBmxM16V6X6n/jGssEa3WV6MuCaKaNjjcwhNj4fdkKsYLpxxNUNM7WTK8eBrq+OD3UAPdxg4WweJGU6ZzgVPAQH6NjVAYiAmqGixtlcsl2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW4+QHLQvpx9uMZjKglP83W0EYpNN6YlBVoSFK7AbGY=;
 b=HkbmImJWZ/Kha/N3vJyh55bwSyJ2i/Y5YLkiZ2mZY2gmYD3a6+vC2TSzpOlOrtcGmDUNBo5z9jHIwxuB8NBo7SSUq2eXzgKnmvibBGmW6sldvKacOmR3+BOiK0FdDwqatprNdIlqw8f21lU2Jqw/R7lFCWHVFAz5NKI0DxL0YWoZX989yjI7OxzRySZ25vtlKYPWVYaf2wb3jFKSiRLjkMpGvfBVueo9M+EatD2E5mWJSzTccsfgdp6dGerVtJtC3j97dZvIG6y0PIrdUkFepoFMXwma+IYqStT7pSWFRUzCALUJ6NqtE0q3sN+s/xSvry40x9ZtO+2NaHn+YV5IaA==
Received: from CY5PR19CA0040.namprd19.prod.outlook.com (2603:10b6:930:1a::31)
 by SA1PR12MB8860.namprd12.prod.outlook.com (2603:10b6:806:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 07:03:07 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:1a:cafe::20) by CY5PR19CA0040.outlook.office365.com
 (2603:10b6:930:1a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 07:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 07:03:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:02:53 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:02:51 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, <roopa@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH iproute2-next 4/8] bridge: fdb: support match on destination VNI in flush command
Date: Tue, 17 Oct 2023 10:02:23 +0300
Message-ID: <20231017070227.3560105-5-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|SA1PR12MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: 9298a177-99cf-4120-d62b-08dbcedf1d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bX9QHuV2quowQnRNgfPqtzilT1TT2aGQPtJtKkys5kq/+2SUwYxaa88AYG2fNv5HVdNNuu5Dm3cvhcVHLdwMdNwJJvA9MW0RvUccIu+WmpYJ8+RkyIo8DUoYC7vbKUH1xJt4mHAy1XUI6u2/LoXYi0uxze3lMwnYKnmAzLABmTy8bUpMzA90asQu7V5J4FteJwOB//VUuxOscCimYy/t0rCQAreNy6z1xDTeLZ1rCO/wNCtA/EMZJaxcAUYpw2xZQO0O1bAWACEWc/DN8fCjGe4+hD3iaZ9vxFEzhKWUZgPSk5BLahdiDwAegTG3drvWz6n/g3vwQ96gKXgePJSu9z//saQhy4SLWNZYyFdshKgVhQ/XYRlyOpmfKihrxLnagqtbUb9P2QnPaZsirDt2icsnDuYGSfYQkI8pn2KxskZSbuj36FruZPfkglrPTX/Ub0TuGyoQ5AJlhxMzVvvGhWau2xlZAlB14pYrm/3KwASmwmIVAqtB+BfaO+09qhxwPUnoQA+VPDifEj4dgsvOP4+dEcYw0hjg6FqTwB3GIcJDATYmnSoLqgiLi4SMMGFPHqPx4KXp2hP6Hov1fjFmpBYHIlNKlLb/RFRN71w5UzHbRkfaaRfKngHH0khXD/GG9slUYLy+7ShLChMa6s4FPr2ykKDFMmI6NZu6jAhZEN1HG3B/CvLLFECARlLOQGWGWsP8VXNK1Ao1UtFv+zXK8rzi/djIY1CnNdcDls85u8bBTndaKm++ZIl8F5rFhOj6
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(83380400001)(336012)(26005)(426003)(16526019)(1076003)(8676002)(5660300002)(4326008)(8936002)(107886003)(2616005)(36756003)(40460700003)(86362001)(356005)(7636003)(40480700001)(82740400003)(41300700001)(47076005)(2906002)(316002)(70586007)(54906003)(70206006)(6916009)(6666004)(478600001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:03:07.0958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9298a177-99cf-4120-d62b-08dbcedf1d8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8860
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend "fdb flush" command to match fdb entries with a specific destination
VNI.

Example:
$ bridge fdb flush dev vx10 vni 1000
This will flush all fdb entries pointing to vx10 with destination VNI 1000.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
---
 bridge/fdb.c      | 11 ++++++++++-
 man/man8/bridge.8 |  8 ++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index 6ae1011a..69f0d9e4 100644
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
 				invarg("\"id\" value is invalid\n", *argv);
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
index eaeee81b..b21d9b25 100644
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
 the ecmp nexthop group for the operation. Match forwarding table entries only
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


