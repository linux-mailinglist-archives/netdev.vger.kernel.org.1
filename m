Return-Path: <netdev+bounces-41874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4617CC13F
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5170A281AC6
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C4A4176D;
	Tue, 17 Oct 2023 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tikGF7d6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F45C41777
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 10:56:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5156B0
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 03:56:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEiWT79Uu5odcJcsNwFyIt1iAXFj75pF3BZYDJ6PgjpviDWF8KBy0DXbfKm/54C76hY00n3cdtJbq8cELjjy9LluG+AMnHx7QUpR/2RBDleSX5Hu77lJyeJaItF0fIR32dqVteqcVdfOn4bFOOqfpdX07vifR6LtkN/GcA6obmwx7VuCyVi3XvTkhYpRpwVybT3dT5eFECBPnX6G/reKYp56ErCY3XObNvtuVsAKvRaurcv0WzzMjPqc+dKwgK0LcthyjTOSEsJfPF9xS18/AKOvogMKqKAUSXYVe8RDDyReLBh8zTNfzfn9Uu3Gwu+sIBEw2fJCjDBDyOZ9kzw2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9p5xXOc7reC1U4JJ5P5FIWyfIzontEcRyzZBHMDshs=;
 b=Yy58vPdIT8DAroojM+BsfXk8fsET2HPJ8ED1c4llj9X2q9tq60z/7XJL6aEx88INr1njNs7mVHkxBNNefuagOd7kajpyKtImAys/aFj9GU8NW6vk48o8cA8dEENix3EhGdy01CZ5an7jV8B0rKg32jaxOVyrBl4forCoP6C6eTBHddiM00uYWLPpq4wLsJ93pqE7F0WnxzRKAT54qoCR1nRCBorLdvOmF7BivRvR//TJ1H6kq0dOFWfjyhplCaiksGbmHWKylVgH+glbct7ZSBdjHrCc9XgGRjI7NB798gkiHZd4U+SNlIoDCcwg478dsw1DZu7Xta3iXnIdPtsWYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9p5xXOc7reC1U4JJ5P5FIWyfIzontEcRyzZBHMDshs=;
 b=tikGF7d6DpkM8m8lvmHuvdxzRh9YpTc9aenQsRJKAXzfcschDC/M+NUYM5IIzplKwvV06O+S0U42BZ4E8W3K/QMQQLaA8U4e9fIoBd/Z50Nw5/OQnPkMXNUN/y36Wboz1pdYbgUjbfSkhJ3wtjR0vsgKTz4cqkmYeOIKMEe7YkUkrI5ZrQPAGnNJ6eMNNxa5VJBfAy2OoCusKbGmclrV3WPy25ivQeKkNqNSztCExOCWa+6pUkuxDJP1jan+r54g2/xZOESouuHuKlAk4ceJm4BcKraSYlFPwWJxKmjlTXG7ymKzMOo9Z+cWM7z7BAfPINY86GD1771MPV5RCPE6Dw==
Received: from BL0PR0102CA0034.prod.exchangelabs.com (2603:10b6:207:18::47) by
 DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Tue, 17 Oct 2023 10:56:08 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:207:18:cafe::10) by BL0PR0102CA0034.outlook.office365.com
 (2603:10b6:207:18::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 10:56:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 10:56:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 03:55:53 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 03:55:50 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, <roopa@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH iproute2-next v2 2/8] bridge: fdb: support match on source VNI in flush command
Date: Tue, 17 Oct 2023 13:55:26 +0300
Message-ID: <20231017105532.3563683-3-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e44d752-f87e-43f9-9b2b-08dbceffaacb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TzLIdPYFdSoSkvqQU1NMAVr2ABXvvp9pX581/KZfkHxadDSNW56ZeqINfj4trZM+h+Cz+/d23GGShija0j4YQY3PT2leBo/7CNd+QpE8Gqfay1+p8cNNQuehymjh9kKehhFBrSgoTC+XkmNLgJ3RI+ZlYd9VrwMNa64QRsJLBhyg2ZJMZE46liNAg0gG3gboxE0vwtYzdXLwGSE9xKN2AR9LtJ25bE4yikM/2q10D3zYr5ks09d2/mjFkd8dcon4EfKrFDUOlbseHQex7AXlF8mP2PSbycTZ9hTga6zZ3u7iUnfeShSSea8aeDWg4M7sHkkOgRlAi9/7ElvTz54wucE7lCNieVWPTq+ITTRt4VG/q41ARfkdN+QzPi/XwPI9tWeK/tCs4FQs/pajwvJVUNrpcD9jYQkCceWL2j3jdjXIz9p6emRe0VgJGsFSQo8gfhl2lVuC2JJ2BKYvGSNSnUCfUliFhHvJO6mFeKIqH1X1YgV9Ypob3kovKn/7sX/ml4MI2Q6Wm0XBSAUgDMYboiDRZhykBK5e9vB3jmNky828UPYQZnWZRSP+2d6wPvTWTMAqjff+WyuSmi5Pdwjv9WgKNrS/UbZWyjn8TIMoUiu8+jskRGiNhpsaI1excJ0x0ewhHAAVkbWVLoZpusNs87f0A/Hkos8s1AhWwCfE5WF6Rm7I0b250ExArSF9I9AAZGDNCfrITVOk60r/xbe/IRLJnn3+kZ5omMT3CCin26Y13KN3KF7U0j8Ak5lYVa6Z
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(336012)(40480700001)(40460700003)(478600001)(6666004)(36860700001)(47076005)(82740400003)(86362001)(36756003)(7636003)(356005)(6916009)(2906002)(1076003)(107886003)(2616005)(26005)(16526019)(426003)(83380400001)(316002)(41300700001)(5660300002)(70206006)(70586007)(4326008)(8936002)(8676002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 10:56:07.8322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e44d752-f87e-43f9-9b2b-08dbceffaacb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885
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
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
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


