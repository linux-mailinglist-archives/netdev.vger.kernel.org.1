Return-Path: <netdev+bounces-41708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741557CBBE3
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289372816F6
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF521802E;
	Tue, 17 Oct 2023 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rVE/w7jk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847FA168B3
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:03:09 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06DF93
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:03:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jfaqim0zeDjnvf1zI6oJkD9ug/69d5j/5KSoYN246f7gCbdTWZgRIvYcCori9jlvlH3R7d/4auHByRZxFMaEVKQ3Cdh0K9d8e1+4wZXsLa1jvw/5g3Gt09up2yVfX1/jLoyOtZlsbUuwEftlL5Df8DH+dTC0odqAIxI3i/GckoSc1BHQwWVUVcIDvXWfSVlgnzuL84SRDdRJ+OyIzS0AIbqQjLi1VFA1vwV4z2TLx18BQWnwCeSv8UXmGfr0yBqcT4wn22jt8Cn1NJ0lR0EctY8+wduoWV833eL2vsWgWurHlDF8DNTWczhPvZ0MyUn3ggXAn8o4GWhpZ9P1mvMqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqSCRspfjOPG4gm2hXILvLYYcEZc3Gbi/mY54Wut7NI=;
 b=kw60+xJ+QNb7jRWWimuXH67XgAMHkLAriY9CdL86rAgzCz+B2Avl2Ci54MMNjtnhWhHozZg3cZ+pW+P1eyl2Fbv8ZavRmWDiYE6TM3QgQ0/VDWB5CaOTGpL4HiuO7FNXCbjDUYQsTe57fRJQV5gwJAQSxwq9Bf+sXBPug9MwZHeIajAKGVedZUAhT/iMt+lhBdGCqeHQ2RF6YfLx+dVdr9bMk1utFB9y2xiqDSkxcULwTavtnxp1rCa9U5TShIQpswzcpnQjijKpbn/7nL+xM94azwBUL64Y5UoyJTZes/V3IsnY6scd5TuLbcm/LvTr27iGXIDV7CaW8H/CIw6OaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqSCRspfjOPG4gm2hXILvLYYcEZc3Gbi/mY54Wut7NI=;
 b=rVE/w7jk9f2AhQh3SskgotLgGuXH+knPBrr4yFGZmsK41p9/x+rJiI6sQx7TWtSTgvwfpS4pcaU8AQmR0M3AarNz4IYpm4GITM+lJ5CwtN+p907pqWR1FK+Pukwwd1KFSvTpMly6B/jJKwxu2+XywwSoGv0Jxt/ByLlY3TvpAg/roAOBX1zQSc+2MaVjPZpKs3slbJ1cKPphLqlBdRCkPlGnVRaPu4qfetAz0NIz9W59FE4pftKjjw4J+TMEmerB8M8c1ADfrRDBdtxpUzV1BikFmyHBQL7Or1kze/H5RANKd+vrNKCllcFKzh7qTTDcG6PHo2EMYR6R7txfuo3vcA==
Received: from CY5PR19CA0055.namprd19.prod.outlook.com (2603:10b6:930:1a::32)
 by CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 07:03:06 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:1a:cafe::e8) by CY5PR19CA0055.outlook.office365.com
 (2603:10b6:930:1a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 07:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 07:03:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:02:51 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:02:48 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, <roopa@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH iproute2-next 3/8] bridge: fdb: support match on nexthop ID in flush command
Date: Tue, 17 Oct 2023 10:02:22 +0300
Message-ID: <20231017070227.3560105-4-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|CY5PR12MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: ad015f13-fb02-41f4-53e1-08dbcedf1ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pErAbVaod6klHuJlWY/haK+4WDvniJgH9qrtrxhTfsGovvsWUNP2SIRiWiHlVbyaEfQuKwmgvfVk7mbtkElfg3tRXGre4Ep8hlKacYuC3q8Ibca8X72lZts3hNLgAAzTTjmwBKRX148iflIybI0NElGx4mCTFBb1wnjawrLx7tDIBGuaUL807Vaa20M/RJsHedTQlmIi0ajglRdC1eFBZ3y3RCBQHEzexEXe0R2/fKGzspQ/ddy6BB9y0AqbtGM6/9/HKxwTDKw9djdFFRyp6j6s+nMemZ3yxI3vcRWozRDGHVdlUIa2wNP2+kJejcKjWDuK7DHrY36/ZCmSqYWLhDmJDuqxhr1cUa6OHu3oj8DcnvUXNzzXMqAVo3e3aM8FilpvrY3jjjczA01b4GClaytZ1YRguaGzCZMIRM65wvPTagHzcvQ4sU4JBEjNGLLT9gNMttls5xcKXx11n3u7dIziMSLPD1mChZiVfyWypYQ+h87X2GL0XoOA/tGVa4CaLNlSeAqQFq7xwGeRqfay/Z+CazbtBv0VmVxUQQ3GiMEXYFPk1UaLubDzG9YoI6V6bbjbNnW/XH4bE4HlTXA542Qol6Hd7pkvZ4oKlUtyAstWjLfYW5z7QxrivVIouublXkHs+pPGxG8QaYtla9clPuV5RBTIrRAJCyqnm05ylFEh65akR988HoNR2NY/Nsb8aTtJejXz1vs1QJNuoDI99dycQqmAtq8Y16VVhOuRjfdAByAaAvqc5KiG9zgqztGS
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799009)(451199024)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(40480700001)(5660300002)(6666004)(40460700003)(2906002)(26005)(36756003)(36860700001)(2616005)(426003)(107886003)(336012)(16526019)(83380400001)(7636003)(86362001)(47076005)(356005)(82740400003)(478600001)(1076003)(41300700001)(6916009)(316002)(54906003)(70586007)(70206006)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:03:06.0176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad015f13-fb02-41f4-53e1-08dbcedf1ceb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend "fdb flush" command to match fdb entries with a specific nexthop ID.

Example:
$ bridge fdb flush dev vx10 nhid 2
This will flush all fdb entries pointing to vx10 with nexthop ID 2.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
---
 bridge/fdb.c      | 10 +++++++++-
 man/man8/bridge.8 |  7 +++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index 12d19f08..6ae1011a 100644
--- a/bridge/fdb.c
+++ b/bridge/fdb.c
@@ -46,7 +46,8 @@ static void usage(void)
 		"       bridge fdb get [ to ] LLADDR [ br BRDEV ] { brport | dev } DEV\n"
 		"              [ vlan VID ] [ vni VNI ] [ self ] [ master ] [ dynamic ]\n"
 		"       bridge fdb flush dev DEV [ brport DEV ] [ vlan VID ] [ src_vni VNI ]\n"
-		"              [ self ] [ master ] [ [no]permanent | [no]static | [no]dynamic ]\n"
+		"              [ nhid NHID ] [ self ] [ master ]\n"
+		"	       [ [no]permanent | [no]static | [no]dynamic ]\n"
 		"              [ [no]added_by_user ] [ [no]extern_learn ] [ [no]sticky ]\n"
 		"              [ [no]offloaded ]\n");
 	exit(-1);
@@ -701,6 +702,7 @@ static int fdb_flush(int argc, char **argv)
 	unsigned short ndm_flags = 0;
 	unsigned short ndm_state = 0;
 	unsigned long src_vni = ~0;
+	__u32 nhid = 0;
 	char *endptr;
 
 	while (argc > 0) {
@@ -769,6 +771,10 @@ static int fdb_flush(int argc, char **argv)
 			if ((endptr && *endptr) ||
 			    (src_vni >> 24) || src_vni == ULONG_MAX)
 				invarg("invalid src VNI\n", *argv);
+		} else if (strcmp(*argv, "nhid") == 0) {
+			NEXT_ARG();
+			if (get_u32(&nhid, *argv, 0))
+				invarg("\"id\" value is invalid\n", *argv);
 		} else if (strcmp(*argv, "help") == 0) {
 			NEXT_ARG();
 		} else {
@@ -817,6 +823,8 @@ static int fdb_flush(int argc, char **argv)
 		addattr16(&req.n, sizeof(req), NDA_VLAN, vid);
 	if (src_vni != ~0)
 		addattr32(&req.n, sizeof(req), NDA_SRC_VNI, src_vni);
+	if (nhid > 0)
+		addattr32(&req.n, sizeof(req), NDA_NH_ID, nhid);
 	if (ndm_flags_mask)
 		addattr8(&req.n, sizeof(req), NDA_NDM_FLAGS_MASK,
 			 ndm_flags_mask);
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index b1e96327..eaeee81b 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -130,6 +130,8 @@ bridge \- show / manipulate bridge addresses and devices
 .IR VID " ] [ "
 .B src_vni
 .IR VNI " ] [ "
+.B nhid
+.IR NHID " ] ["
 .BR self " ] [ " master " ] [ "
 .BR [no]permanent " | " [no]static " | " [no]dynamic " ] [ "
 .BR [no]added_by_user " ] [ " [no]extern_learn " ] [ "
@@ -900,6 +902,11 @@ the src VNI Network Identifier (or VXLAN Segment ID) for the operation. Match
 forwarding table entries only with the specified VNI. Valid if the referenced
 device is a VXLAN type device.
 
+.TP
+.BI nhid " NHID"
+the ecmp nexthop group for the operation. Match forwarding table entries only
+with the specified NHID. Valid if the referenced device is a VXLAN type device.
+
 .TP
 .B self
 the operation is fulfilled directly by the driver for the specified network
-- 
2.41.0


