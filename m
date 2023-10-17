Return-Path: <netdev+bounces-41870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC207CC13B
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0EF1C20C75
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBE241754;
	Tue, 17 Oct 2023 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s9NO9PLj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D76941212
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 10:56:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB3B1BD
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 03:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHa37DZCZ4Kq0RAmsVmFCoLrqR7nAq1WgHCV03eL78ugsYh0MG5JJZMbfCyoDbgRXtJ/6Nv0b+6AscNJcekJChO0MtcHe1+Y59w4QDjGoUcSxmFA36Z7dvquGAoBOtSoSgrTu7WvKhUXeVpfbM9xHSrZsHROymwGM3QbYn5EWgTvPtPM+jJR2BdiGMyuirlSu7hLYTYvH+pETY/N27OxyNhNGW0VLHXoRUjpGod4Qjo5lWXmf4nKH7y22u0BJQ/cuI9sQ8r01hOzEA8+JMEwU9ASpLyRkqmICp1IbMOqm4++beNfhFDb12uS3k6v8wA8sTxsW+kzgN15ONV74/c42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3amDYLM0hkVyxS2DCGU0TvBovMJYkDMGscZKhVJdQ+Y=;
 b=Lrba46N6BXQww8imUIqqpcLFtjTt/dToQYaLMvUqdU3NQSh1ByP4wRqjBu7k4+GtLRSc1QU+BKLSLWyz0eFXJoTO4yfTSldgCSf7oiTnqa1TcZ5DGqn+Q9yjc9tLZonQR5V7pUom2AA0HIlsJsb5hE/RDeO8ba0NWAV1kd44DvbGsp9k51xDsHVGfFs+6m3+9jYzCnM/jBhdXZ5wrQjYMpCcv7x3Iqwd37CekVhMAhjeL4WmqhiA1Ep6YcRB4ArP6j4wSLfmoR0pCe89gSstg6PC0y7ZY8FpSs0wqg4IjSi3XpFkvwFyTaUjVUrkRpzZSWEHyY4xgDxdlQznsxBBnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3amDYLM0hkVyxS2DCGU0TvBovMJYkDMGscZKhVJdQ+Y=;
 b=s9NO9PLjtIdCfUD9r48aiBOOYaV51WwVEerOo51P6lF/Nu8J7WEePhLkptpldo/hoKjdsQ9C3JRBw0gwrX+25bN4bcT3yEa7hS5oYTs1ObkZ/y9HKI+R+OQ6fThVz2c10UeRdpy5My/CPrveQhO/KTCmaL6la5Vg/sKHJtq3LMJcgPE9PBj8wqTnW0AUhzKBqB39hRmtO66jmTlbvWKgyspKJsVDweTxRK2PNl8H2uqsh3/gr35I/V/ULeqrU5WD75P7sQftd2sZ/FFQA9O26ojoznKFMqFSLlAtfOV/iQs1Ihm0qlqH6ExPVROWab6pOIgv2OB4QskoVcB9ZqXwQw==
Received: from CYZPR20CA0014.namprd20.prod.outlook.com (2603:10b6:930:a2::8)
 by PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 10:55:59 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:a2:cafe::9d) by CYZPR20CA0014.outlook.office365.com
 (2603:10b6:930:a2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 10:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 10:55:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 03:55:55 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 03:55:53 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, <roopa@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH iproute2-next v2 3/8] bridge: fdb: support match on nexthop ID in flush command
Date: Tue, 17 Oct 2023 13:55:27 +0300
Message-ID: <20231017105532.3563683-4-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|PH8PR12MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: a4fbf751-ccc3-49e4-69f7-08dbceffa5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N265DOM59ZrWpSeFbAQIg9Z7VTmB6U7BQsEnaBh7CIg45s+8dWue28maU21o+xbn61mrljIN0ndDmPSRY5Ff7qTjO/phzDka2WB7d6s+HheZC2pUWadmle0+ggzMFzd1hR7HTAe1NJv7C5u8c9FTbvkA/JQCav3Y8AnYxzxvN0OfgPQrr+38e184SpSelxcCkOJ162G5SmuP635sjL+aracw8Ohcszws1w6RD8HAmBRbTJmrS1u2e20fMse+ZJZikyJT/OH6BouukBW5so+ZTOnAdXaFNhyRJWp2i7RBtT8+Hsi50YGSCBf3FvHP6TswZP63WpXJSixt4FJYuFuY2NAvDWIzMWNtvhPfJoJ6QmvCjmIf65sQDFpHKn+x0sVr2XDzTo3hp3Th7mAxE/mwWxjbXIdX2BQHbZUHVpexwb7bBs5J9kwfv61+hCKfrAv6iMMEkcBSzfwAiw7gW55ArBqZmcw1cBeq2m5J22882GZqU03SLg8rXJM+gsrdf1xGDQIvzbBjC38atV2naXQGYlIg81DG5IVNoWE5mqj372rR9hOqaKhCmUA149JrKklFSuXqJtpoHNpKTDLLqtIdf2oMMb6jhBRN9yw51lG9pKFowwoOwsP3jbToAKzmajHb9vrAaa9By8ICMQMw4jvsn1sVzy5gnxcF6iFank2QkyHHtVl4B5eGVyUzLdo3bkNTyigIBjda30SdchrEfwAcKXbBZhjTi3vgMOTh9nLDdd7MqkL3MsVLeTjjHI2o1qhE
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(40470700004)(36840700001)(46966006)(36860700001)(40480700001)(478600001)(6666004)(47076005)(40460700003)(70206006)(70586007)(54906003)(6916009)(316002)(7636003)(356005)(86362001)(82740400003)(36756003)(41300700001)(5660300002)(8936002)(4326008)(8676002)(2906002)(336012)(426003)(1076003)(107886003)(2616005)(16526019)(83380400001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 10:55:59.3117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4fbf751-ccc3-49e4-69f7-08dbceffa5a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7110
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

Notes:
    v2:
    	* Print 'nhid' instead of 'id' in the error
    	* Use capital letters for 'ECMP' in man page

 bridge/fdb.c      | 10 +++++++++-
 man/man8/bridge.8 |  7 +++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index 12d19f08..22a86922 100644
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
+				invarg("\"nid\" value is invalid\n", *argv);
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
index b1e96327..254b2fe9 100644
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
+the ECMP nexthop group for the operation. Match forwarding table entries only
+with the specified NHID. Valid if the referenced device is a VXLAN type device.
+
 .TP
 .B self
 the operation is fulfilled directly by the driver for the specified network
-- 
2.41.0


