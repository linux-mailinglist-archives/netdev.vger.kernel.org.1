Return-Path: <netdev+bounces-41869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A322D7CC13A
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B441C20BCF
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2541B41751;
	Tue, 17 Oct 2023 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y0RMz46z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7C74174D
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 10:56:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E635F1
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 03:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOy/htI47UnNIvGJC1kpG0yk3G+9cyRN81hhz8lg5osM3kFccbEKsqbeoeKh68FIOGu9GckJxn+7FrMl2DeBcXFFAFf1bDXxSLIYPn0RyL8EFQQBGsMZa26PvAZgAK9JaMqmCWtUS+XEqXTZcgiGI7VZSuT4RLTYg2iufkoPy9GVeNnQRroZgwuILITL5q7h4CSdMIK0uQFn7GReMJTRqQwP3BR36smi2+vLTCS45A7XU2S5MSCZ9UKhA+bY7pY+ZTzLg80o5O0vWQSIWxfeSrrlik/MqzqGHOdm9I7XlW6bENyB2ix/fxJPTgsbXC41vk4drlsjiPGaoM7dlAU7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/i4r1ZP/6X3+F5I+fYf+Bxh2wwsoj1c9yFAuwXfykQ=;
 b=FOTn38bkuK3+LxrPyMQ7Jc00PJnDNL5diizFZfNp6BDPKNY8vw2ki9qbmAtPXYr33e4MpsD1HwQ4n1NeDGwV3i2nx07qc3epZgXCUF0nvWliHkTr6x1cq/lIsADP79V9ydZM43G+LcyYBop+k0Z+M+qkMIrMlz4PsJYDk0VWHJ5c0Jxoy4Yc7eec1KndxX1enWFfFvk4RPz3jBos5m3REiH+3hTtW4a36R0ZJWgtErbPjOt/f614CxBQpfONKivKgmwkn/1oIWVAkjL6j+nG/6RpErxUAIOVbgLXtlefhU99NYNGW+uHG9B2pEDCIkWtGtBGgpWs28hvkYfVT+g19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/i4r1ZP/6X3+F5I+fYf+Bxh2wwsoj1c9yFAuwXfykQ=;
 b=Y0RMz46zAbxsw7b5ehoHPgX5/xgLkm7kQqc/A+kTw8aXKoUP9H5pBTKr1pKxrf2qI+ILWtNpG75xeS/92C1H1kZXM86mTWu4F1LtuHP6eYfe0/LfVSP0HD5FV7yydxfjTqNlX6VrZXwXOyst9+y/0UVQhXIbfczzR+4oggEhwSGTrCgRJ5msNUUc4DJHfp+6h7raxakHBbaTOsJXg67HtkcCrzaWb/LsfHnJ1x+qw/l8RYEqbSOYbcj4sbOu+oX0s5lX5OJMltM3UI/mzwvx0LDBIqkwWHYQ3331B1xSCuDfLkrH3w+blsdOWPjYBUbdyPc3JncqG2/lUvqAgItluQ==
Received: from CY5PR16CA0023.namprd16.prod.outlook.com (2603:10b6:930:10::33)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 10:55:58 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::3b) by CY5PR16CA0023.outlook.office365.com
 (2603:10b6:930:10::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 10:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 10:55:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 03:55:50 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 03:55:48 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, <roopa@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH iproute2-next v2 1/8] bridge: fdb: rename some variables to contain 'brport'
Date: Tue, 17 Oct 2023 13:55:25 +0300
Message-ID: <20231017105532.3563683-2-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6c9f43-7784-499a-d796-08dbceffa4aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kWLWzP7qPJnv41HBv6grnLsKpLHTIB+TOTrfrbp4aIKKtfle8it9kh9Qp4oJbKcPIo34kbMTSZfGVHSau6YROknmEkuug9YDtxZR3ofBtEtQQPCCqj1ox9nr/ugVv5Ef45iVWe4jURt6cNQuy9MTu+1RTJPvAuZlSYAc46OJKmpjWWirBc/HivwZvDaIZvhHXVfF57Y2NH/Ww9mASlp5SmmiSPi5iZiUYpi8fCu21Z1sHyYgiQ+mbHMe9v1bGRJV1BjXyLkIRiWbKA3V3iX6LilXeme0Qt5E3TQObegdshYfaS8sUVQ1QrCEOkqBU1nyWRqdrzAmvR3Bqj6co1oWzfgbrqk4l/MsL6Fg2AE031VSoFmzG+5Rblf85fZSFJBVXmOR4zmX/JLblUqioGElhtGIL0iCCjvnsa9oNhgs2YjyKyneNutKV+76DvhO7NDYdrMxBM3g18GiOqupQgfbyQ3wfNBpi4KUE572uVui9tRolrNr5Q1xjurJCcjBNZ5TcoNmoKuysg4Gbk/mJVEAjexDp0jv16yMOGYdJpCZj90gF5GegXf9h5yTSmbloCRxoc5E3b2H5g9KRAK3S36x1IOHYW3dyMtF6BQJ1qTiYPAPBnohjNUfaWgHYhTOUgbusgTDJah9kyZ8HkPyOcK8mLqeIwQpp8kdDyDX9fpoD4jjHZdjMRf7enhRyDrt3n7B0D/MlvRnd6KPC+1YoR2A1OyAiLsXHMobhm+qP1KBWcWDbF/a210/b+oAQfn4Ieb3
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(46966006)(36840700001)(40470700004)(336012)(40480700001)(40460700003)(82740400003)(36756003)(47076005)(83380400001)(36860700001)(7636003)(6666004)(356005)(26005)(16526019)(2906002)(54906003)(6916009)(316002)(70206006)(1076003)(2616005)(70586007)(478600001)(426003)(107886003)(86362001)(41300700001)(8936002)(8676002)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 10:55:57.6136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6c9f43-7784-499a-d796-08dbceffa4aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, the flush command supports the keyword 'brport'. To handle
this argument the variables 'port_ifidx' and 'port' are used.

A following patch will add support for 'port' keyword in flush command,
rename the existing variables to include 'brport' prefix, so then it
will be clear that they are used to parse 'brport' argument.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 bridge/fdb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index d7ef26fd..e01e14f1 100644
--- a/bridge/fdb.c
+++ b/bridge/fdb.c
@@ -696,10 +696,10 @@ static int fdb_flush(int argc, char **argv)
 	};
 	unsigned short ndm_state_mask = 0;
 	unsigned short ndm_flags_mask = 0;
-	short vid = -1, port_ifidx = -1;
+	short vid = -1, brport_ifidx = -1;
+	char *d = NULL, *brport = NULL;
 	unsigned short ndm_flags = 0;
 	unsigned short ndm_state = 0;
-	char *d = NULL, *port = NULL;
 
 	while (argc > 0) {
 		if (strcmp(*argv, "dev") == 0) {
@@ -752,10 +752,10 @@ static int fdb_flush(int argc, char **argv)
 			ndm_flags &= ~NTF_OFFLOADED;
 			ndm_flags_mask |= NTF_OFFLOADED;
 		} else if (strcmp(*argv, "brport") == 0) {
-			if (port)
+			if (brport)
 				duparg2("brport", *argv);
 			NEXT_ARG();
-			port = *argv;
+			brport = *argv;
 		} else if (strcmp(*argv, "vlan") == 0) {
 			if (vid >= 0)
 				duparg2("vlan", *argv);
@@ -783,11 +783,11 @@ static int fdb_flush(int argc, char **argv)
 		return -1;
 	}
 
-	if (port) {
-		port_ifidx = ll_name_to_index(port);
-		if (port_ifidx == 0) {
+	if (brport) {
+		brport_ifidx = ll_name_to_index(brport);
+		if (brport_ifidx == 0) {
 			fprintf(stderr, "Cannot find bridge port device \"%s\"\n",
-				port);
+				brport);
 			return -1;
 		}
 	}
@@ -803,8 +803,8 @@ static int fdb_flush(int argc, char **argv)
 
 	req.ndm.ndm_flags = ndm_flags;
 	req.ndm.ndm_state = ndm_state;
-	if (port_ifidx > -1)
-		addattr32(&req.n, sizeof(req), NDA_IFINDEX, port_ifidx);
+	if (brport_ifidx > -1)
+		addattr32(&req.n, sizeof(req), NDA_IFINDEX, brport_ifidx);
 	if (vid > -1)
 		addattr16(&req.n, sizeof(req), NDA_VLAN, vid);
 	if (ndm_flags_mask)
-- 
2.41.0


