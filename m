Return-Path: <netdev+bounces-41873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54E57CC13E
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 12:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1131C20D94
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED5941A83;
	Tue, 17 Oct 2023 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CpgzaXUu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D5641758
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 10:56:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D40F109
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 03:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leEqPx0MPQiVrL9Lf289SvlrSkpX6VtvhrH/HVV+91GMrddClJVZqS7UQcIcjJpgiLo08ARH39y2zff6h7YPHdllKQ2l3bOYvgckWACkMi8CEG+BLMjjwnHPyWBpi546Gi+LO/2vXw6s1trc+RoK1roUNl6aO8k1FsFjQuZKKiYyc0RowRBCLdWWOX3xeSlPK/nUMJT5AKfoJxmOpCvnR1B7DKJsLlueO7ziy1/fo0cXnriizvXyvU/NC026B+6Ww58gqs0rYbu6twBEKnrFlH38lh/ouFrq1k2hZibsEigzZ3XGzEHA2KQIfXtXQvpxuWHEvpGNiPAyYzr525uQOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qhe95pSa4U89mp8W5+defLHtXZd0gZxBcnzyGrOyQXQ=;
 b=iHrgboK7PnKbOLB62pueB3YoKKYUfndGSEP8EysWWBnhbM9zEx+FybSug0tIvs3ftcWtmoM/EUcQG77pyt/hVEs1wJtMDoSQmHG2UdVGa+c8rqQ+mAHJnWJ+f0aO/dppkPG5VIzHxUPSGxTcLk36bmGQ8dUmVrgowz0TNtJDiUmCQ48B8IwPIZsTQDw4/cXBvziYfXSXmJqc7L/pXFNETSoXwSK2QZtXBD1hWZxJUCHwUraX322bAoBmpwQKBCJMbtR70YS7KLQfLzM1LPdHn12HbqPrW1TAL8aF000Lvu/Rnoj3pqYEoXXz4UZ7+1R6WsKm/h9F7z97y7xjFICzVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qhe95pSa4U89mp8W5+defLHtXZd0gZxBcnzyGrOyQXQ=;
 b=CpgzaXUuN8vgK4TyzY9pg+PXKrt/FWPSrLBndS3Qj3W39zm8VO5dr9KqHX0mDWg71xMheUbh9yWVXzZLoJ4CvHijL3EAQelByxc9CEEhN9ErZccrMn749HJfd2U72QSn9lzrqOltt9Pj46y33lGs8aENEW0h4Lkr2QU8H6soL06wsBuHzW2y17O4TpSTvJvZhGXDYhfaSC2kMCEx0r1vccQQyvy7D+afj4JQDfEUHrodr68tyQKWAJlSIxQVgPxI60vewrX7aVj030+TQRJJy6RP6dqgnisr92HWf3h2v2qkho3JLKw5IIL4907daEcxA+EmL3CUv6tvO0Ce7eVdzw==
Received: from MN2PR05CA0054.namprd05.prod.outlook.com (2603:10b6:208:236::23)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 10:56:13 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:236:cafe::3e) by MN2PR05CA0054.outlook.office365.com
 (2603:10b6:208:236::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Tue, 17 Oct 2023 10:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 10:56:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 03:56:00 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 03:55:57 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, <roopa@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH iproute2-next v2 5/8] bridge: fdb: support match on destination port in flush command
Date: Tue, 17 Oct 2023 13:55:29 +0300
Message-ID: <20231017105532.3563683-6-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e383146-867e-4455-a105-08dbceffad80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NRpK/TI/bXUGYKq253ZWya1Bf+86hA32z4tU3WZEoRF/0oBysp53d+l8BY0/d8dahwkFd9svL9KRaOukG2suSH3nO/6L6glJa+xSQnlXnOtxptpKIC7Cshu6n0nPzZmZX/lfnEr9zO/OIoGVZs+WPKsW8sPq4//X/2N9svBJmsQA+3Zf0QzExwnZ2H2uedMnrdTnUfb45cLxpTy+03axP8R/Q+lqgohT1jdoYu9drlWuD4WTOFuSqIo8K39kHeZiHTzi8GLz7XJmW7dTdDzlqEE16nwDf6DEpPt1sbAR2YRmSNEzVvMv2OlB3NEoVpxKF9kG40sBB5LZK0m781w5PaxC6MwNr/Zw3JE9gCJDaxk71wKU403i/1mBNdzXHGQIx7HLfI2iLQ13BzsKn7WWBfJVdm/uclmmZAAKJM3eiDiz0aqlqGas12oGRRLpw8dO+UU1bSPkrvFOWBsr5dIFNRdxByiLwb5qJnmdZeUK1lhbZBe9ExV+RbUrv8+xitugugnhk8nKuJjfniWsUxOCJUftiX5zVmSQB4v2NzUAW7+5Ml2rpPLma7mS0BTPJPsPj0hlKLH/PaWg6shOKo1MZ/02rEALm/jmNNltv0m+GXt14Q+ECGyyH1SbdPKD4x30Ja4cKfAvdTaHC2XzkkecTe0lyM8fKWph+/NGc3coagwVfZuIpkK6fEe4DNs+jRCbFe4y8lYMGglrxg8DqHqG1bDElIH+QvCuyKWde8mkCCCEK/untVYt1oMnL600i8mE
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(83380400001)(336012)(426003)(16526019)(26005)(1076003)(5660300002)(41300700001)(8936002)(4326008)(8676002)(107886003)(2616005)(40460700003)(36756003)(86362001)(7636003)(356005)(40480700001)(82740400003)(36860700001)(47076005)(2906002)(478600001)(316002)(70586007)(54906003)(6916009)(6666004)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 10:56:12.3740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e383146-867e-4455-a105-08dbceffad80
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866
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
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 bridge/fdb.c      | 21 ++++++++++++++++++++-
 man/man8/bridge.8 |  8 ++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index 16cd7660..f2d882ed 100644
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
index 9341c77b..cf23094c 100644
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


