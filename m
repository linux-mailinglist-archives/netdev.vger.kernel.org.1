Return-Path: <netdev+bounces-41714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77987CBBE8
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1582B1C20BCF
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 07:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F281802E;
	Tue, 17 Oct 2023 07:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NU1jbXLo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE3C171DF
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 07:03:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A48BAB
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:03:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkYwDrWSjJJzO031jEgVPrvy3MW6sVqLNxLQU49uUtdal0tpWsVZir8guX7lsn2oQDMRQeqi3JG2dsfJ1jz9WOrjT5J8nT7FqOLYu6WBY1yp5PttN+zr5Pg+EslcXcMhGQsGH3CMg0PET+R8xA5LNwO+vI9duYuQWTjCkxHj5XB0uzSQSWX4Qq+OEYRvY3o7imckBdybCNAJw3/pny3DumphmdVHVbPvMFAwXrcfKyneF6XUtnga+h+ADujKAJtRAeXnlucZJoEY17QMV034+0TFo0ug/TElZ19AiuV/5LuwKQkzM9pZNQIhjUCk278mG5Azb3PwkyZsOXb2g98YEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcJ9kSJh+m37dCtSP1rGJg7Eroof9V7Zyxb7KdFcOLM=;
 b=GOCCyfrSMYNaU70FhPpdpme/4+LmILJslznVLQLCukCuhMfdOfTSsA2iwHLDtiKThtHwzDMwV5afAl2oMSimWy1LJXF9QXGvddG2PDufMEAc+PYKdvTtssu+e8lP1rMwFCYLEtFmMJUJkz9HoffTvgCE709Eo8o0UnKyDso5sY1vBJh0ePPUlWH6s14SqHgZI4X0V77RYj4NjwFd27Q1R7e/b3krOaFJmBq+uK+ltm7jr1tJGRTyLcLC83h7irY/RHle89Pcy/qkbaXcE/YUynRz42Wec9FSoQSSQKAOkLdGYpe0BmGJgCqO9rvt33M726G9vVocH/yEtlTHIjAAHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcJ9kSJh+m37dCtSP1rGJg7Eroof9V7Zyxb7KdFcOLM=;
 b=NU1jbXLoMLQBaucSQoSFD1KSYQGIa2sA+IhUfcbkPkGnmCbs5/tVKT5DtRDOWHzh5x8MeTsMPo10VENzwOa2klsb2u7mfNcRouQnrcaj0SbJ60ovY8nAiwqnH1HnWeQemHm7ejERre8AQS5yB9+6liavDxloV6FpxCV1v2GDJ8uNyDxOWZbtD9QlE+ciCJxu2f3R2f/Zk6MkEbhKzncf1v88vsWKvQPlv4NWLE4PO92fxLqKCtw/OoODgcKdK2Dd2Dlqwsm56f9tXpk3kGmmTxVpkxm7ma7jaJWz3wIS2qPWskC7zrOPFtOtvhtqzWGkVfn7OI9tkYy5RoEOK+k5MQ==
Received: from MW4PR04CA0314.namprd04.prod.outlook.com (2603:10b6:303:82::19)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 07:03:15 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::14) by MW4PR04CA0314.outlook.office365.com
 (2603:10b6:303:82::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 07:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21 via Frontend Transport; Tue, 17 Oct 2023 07:03:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 00:03:01 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 00:02:59 -0700
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <dsahern@gmail.com>, <stephen@networkplumber.org>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, <roopa@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH iproute2-next 7/8] bridge: fdb: support match on [no]router flag in flush command
Date: Tue, 17 Oct 2023 10:02:26 +0300
Message-ID: <20231017070227.3560105-8-amcohen@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: fbaaad15-74e1-4f31-8b79-08dbcedf223f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vRadEQp6tpTNr4wnnVVO+Dwo2mrK8xjgxumFtPA/0RqEy1M5IhwKBHeFmYxVGz4jenkHqmVIViDnVNQBhLYuBOOrQz0kp2BhQSH/aS+Ja1YbkpkbCSUd12qyR/7iawSBGL7PEj9p27GZIAugvbBITVPYc1mVjSOFMyUO4GwYVk3n9ncBFl6AGcOq6n9iMIjL9KURpUC4P8vigc9JbyIBlAqCd8idncLZ5rWWQkWGe0cEGNmfhT5TRUA5E2yG1gTTaYmNNW6xcsTr7j4AO3D9SJjkfU1iZ9NqBgjlu3TEYs1T05BWxg/dO4suFy2rdj/NglmTBVYOS4GQFxBDIeBoNPGlZENjLrwF6qi7JdlxvzlgSfMp/szxmPT9Olnx0k5Y6IAlx1+OJkF8mLVrUBfb/X4JFjsAL82JZk/IXf6KOqSnjUVSeWCax+73HznpHROP4EzWEpol5q46eOsrTdOP4oNKSHunR5r4+0pNYJfKsVm/T6ZL9D3f0IO9TXJ6IJWymZ7bsA2+/0DV8Kxaav/zNCtgZf8NoMRoCMG8IslGYRq84Xgca+Gg8JmAUdeebzxC2chxH34ptRkLyGh2Q6K2Uvd2bvkm5EUaQYEwU91Utx1lpMxAb5cqAIvZkrrDbdmMeqKbpd3To5rKt3hXBTYy6+EsIYN5Z1DU506hSEFLd6cAYA6MnfRlE5NrjOwR8SelKMq3MU9n6Y+uDSrqjE+LbT3vBls87jGdnWBWn/DXBcY=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(1800799009)(64100799003)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(6666004)(478600001)(107886003)(83380400001)(66574015)(2616005)(1076003)(26005)(336012)(426003)(16526019)(2906002)(5660300002)(54906003)(70206006)(70586007)(6916009)(316002)(8676002)(41300700001)(8936002)(4326008)(47076005)(36860700001)(86362001)(36756003)(82740400003)(356005)(7636003)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:03:14.9113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbaaad15-74e1-4f31-8b79-08dbcedf223f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend "fdb flush" command to match entries with or without (if "no" is
prepended) router flag.

Examples:
$ bridge fdb flush dev vx10 router
This will delete all fdb entries pointing to vx10 with router flag.

$ bridge fdb flush dev vx10 norouter
This will delete all fdb entries pointing to vx10, except the ones with
router flag.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
---
 bridge/fdb.c      | 8 +++++++-
 man/man8/bridge.8 | 9 ++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index 35100e68..ef0b3290 100644
--- a/bridge/fdb.c
+++ b/bridge/fdb.c
@@ -49,7 +49,7 @@ static void usage(void)
 		"              [ nhid NHID ] [ vni VNI ] [ port PORT ] [ dst IPADDR ] [ self ]\n"
 		"	       [ master ] [ [no]permanent | [no]static | [no]dynamic ]\n"
 		"              [ [no]added_by_user ] [ [no]extern_learn ] [ [no]sticky ]\n"
-		"              [ [no]offloaded ]\n");
+		"              [ [no]offloaded ] [ [no]router ]\n");
 	exit(-1);
 }
 
@@ -759,6 +759,12 @@ static int fdb_flush(int argc, char **argv)
 		} else if (strcmp(*argv, "nooffloaded") == 0) {
 			ndm_flags &= ~NTF_OFFLOADED;
 			ndm_flags_mask |= NTF_OFFLOADED;
+		} else if (strcmp(*argv, "router") == 0) {
+			ndm_flags |= NTF_ROUTER;
+			ndm_flags_mask |= NTF_ROUTER;
+		} else if (strcmp(*argv, "norouter") == 0) {
+			ndm_flags &= ~NTF_ROUTER;
+			ndm_flags_mask |= NTF_ROUTER;
 		} else if (strcmp(*argv, "brport") == 0) {
 			if (brport)
 				duparg2("brport", *argv);
diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index df440c33..f76bf96b 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -141,7 +141,7 @@ bridge \- show / manipulate bridge addresses and devices
 .BR self " ] [ " master " ] [ "
 .BR [no]permanent " | " [no]static " | " [no]dynamic " ] [ "
 .BR [no]added_by_user " ] [ " [no]extern_learn " ] [ "
-.BR [no]sticky " ] [ " [no]offloaded " ]"
+.BR [no]sticky " ] [ " [no]offloaded " ] [ " [no]router " ]"
 
 .ti -8
 .BR "bridge mdb" " { " add " | " del " | " replace " } "
@@ -980,6 +980,13 @@ if specified then only entries with offloaded flag will be deleted or respective
 if "no" is prepended then only entries without offloaded flag will be deleted.
 .sp
 
+.TP
+.B [no]router
+if specified then only entries with router flag will be deleted or respectively
+if "no" is prepended then only entries without router flag will be deleted. Valid
+if the referenced device is a VXLAN type device.
+.sp
+
 .SH bridge mdb - multicast group database management
 
 .B mdb
-- 
2.41.0


