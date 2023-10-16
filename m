Return-Path: <netdev+bounces-41327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35217CA925
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4EA1C20DD0
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D632773D;
	Mon, 16 Oct 2023 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y9m2CAiJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773A027739
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:14:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AB5116
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Irex3bh8NjU+LWQRM8HUJzDskvXid+d5CSdQel3p3g1RwakcVLCghdYAFZfi6e43B/H6W/9MIWexOrYw4vgdewT1/qSelf/sa3gRFuRe75ceklpHxR5K+iXqBzXSd5vTq9vicxlAFUdEyF2tGiXm3bbTapVKNSjpQc7j1VzVnP/l4uX7/bFbIHxBtIglUlRfmf9RK40RyJFQxDqg51gCpZS7+Wnl/kGxQw734/LHmcShO732LWK6ppMgOM4IamRPyDcs+YP8rcjieGB0zLzd83RBKzpRyCqkyttW0kiiDG6i5a1aA+MBkHK/0VS/2SjuVge6H2JdTWhM0Z7b8nqy0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmxpLyIqP7Rsru/cXevrGDE3e/66SDRvoqRLeQk0CxI=;
 b=Rz5ZFEW8sFegr/EwMzajocJsNfGhB+qr4GUifnAB//RTSxGZfv6M2vRY30Ox6C8lFvHw2XqU3pgSunTsBDl5OpyrvFiyzWc2808IMPHzAaozlWtdtlRs+D26xfRMcE2XB4eVRe+eM46aKCE6yYTge3bhJve9kEAF6eGqLJQAMy1GbhShL9b7+/onfFDLjO4UGnBRgiOjGdaS1jOy09/uTWzv4ZOJWFNVLcZvnw3+d7kROG4zyuhhoDCbmaUT2C7fO2Ifs4fn6FkJGnr5L2n0WT6rPm8CEYGM1ElMdlEsRca8cF+KugM9V3kVhJToKZR5Hixq7ZHrZ4bzutrGp1tPsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmxpLyIqP7Rsru/cXevrGDE3e/66SDRvoqRLeQk0CxI=;
 b=Y9m2CAiJe4LPMj1CZcFUfc4YEiNJKvtETOU5N0wUyli9GCutJLtOD/0mEMF9D3gv7tm2jnUqNjQNj8jDqvjBdiIEal1BZzbfCZSACSvInZkd4tCGWRl9hzI9z1AbUkZHi0qarnW8IGHl6jGnlccXsHuJRXNQ/FB+Zw4sfIXaP4kw8+YqMg4rXjVuAXbOOGui6EQZ5/rBrjxXRrIQPKt7IE/uLJPZNpwLoO4wcJV2xMf6o4MxfZQDWEvqPHnqlnpGCtG8vC8J9BR1i1j3JJPJPncbspiNOTMOZNE+nSquIjvwVqmumWsw04OvHuk2vO0OISG4VLlfJEpZiSmQCAh6eg==
Received: from MW4PR03CA0004.namprd03.prod.outlook.com (2603:10b6:303:8f::9)
 by DM4PR12MB5151.namprd12.prod.outlook.com (2603:10b6:5:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 13:14:27 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::1f) by MW4PR03CA0004.outlook.office365.com
 (2603:10b6:303:8f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 13:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 13:14:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 16 Oct
 2023 06:14:14 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 16 Oct 2023 06:14:11 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 13/13] selftests: vxlan_mdb: Use MDB get instead of dump
Date: Mon, 16 Oct 2023 16:12:59 +0300
Message-ID: <20231016131259.3302298-14-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231016131259.3302298-1-idosch@nvidia.com>
References: <20231016131259.3302298-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|DM4PR12MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 32eb1dab-31fd-458c-04b4-08dbce49d345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tAMqDKoMipVRhV4JyjPKgepB489D9GV33612PQTRT2I3rXL4hPSsaSnqDSJDn/T3/sHT+P9teSidADYfoUQ9YoMZUE/P9PphkFoVXErS0pd9Z/+AolFOlVaTTCXWEhE0CTIO4V/7FB5Z6Iu6LyWN1dWYwroM+SLzsjI4e7MKiC9Y0tfu7QcjUwuIK/N1T6NrKw5sRKOEck2yKXU7jP1t2KVaWX1f4xrf5yZpmA95s3UGafrySb2xglDQ87jWR9FGNZcTeY/2NIQw0Mz6giqwfoDBsB8IMEzfEGfUFzGIbt2i2mHnmETZNa0F1Guitjwoox+xII9DQM749GsVQqCZc0uctS6hlnC994G5LFSOmrApI8poHB+lF1mk0/xZn7oh8E1W8ZYFmhsCOxdm2kocXb5hEyJIU21uU43gqBNWJLunuG6/PiC07f0QLYURJZoTD2iwjSA/EWaZx3k2n2LgTsNn0tV77WHdnrPEh+q/PG8+2ol7X9oAZzoglSHAYnKighz3if2z1skUheyCB5hhZto+Wz/pSQZxjN4C4naayBzqGp5VD4/ODeJBFKF4H3wEbgFoIzoOWeKTvc0QPiC386uW/QV93xBbFIDePYDaAg3ISawG0V1SUdgVU4iEZksv+161tqEc5HEOby3M0kVqbGWy/+eWz93GTRKSHkZNT7QY7zBGjBr3DQQQa47ed/F54NQNK2t6dHtiatqiPoqtFfzYWXMy2RgmcJF+3zik6dTQeHBAODguPsfX+uNskyRN
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(64100799003)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(478600001)(110136005)(54906003)(70206006)(70586007)(6666004)(47076005)(16526019)(107886003)(26005)(1076003)(41300700001)(336012)(2616005)(316002)(426003)(30864003)(8676002)(8936002)(4326008)(2906002)(5660300002)(36756003)(86362001)(7636003)(36860700001)(83380400001)(82740400003)(356005)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 13:14:27.3944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32eb1dab-31fd-458c-04b4-08dbce49d345
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5151
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Test the new MDB get functionality by converting dump and grep to MDB
get.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/test_vxlan_mdb.sh | 108 +++++++++---------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/tools/testing/selftests/net/test_vxlan_mdb.sh b/tools/testing/selftests/net/test_vxlan_mdb.sh
index 31e5f0f8859d..6e996f8063cd 100755
--- a/tools/testing/selftests/net/test_vxlan_mdb.sh
+++ b/tools/testing/selftests/net/test_vxlan_mdb.sh
@@ -337,62 +337,62 @@ basic_common()
 	# Basic add, replace and delete behavior.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 $grp_key permanent dst $vtep_ip src_vni 10010"
 	log_test $? 0 "MDB entry addition"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010"
 	log_test $? 0 "MDB entry presence after addition"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 $grp_key permanent dst $vtep_ip src_vni 10010"
 	log_test $? 0 "MDB entry replacement"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010"
 	log_test $? 0 "MDB entry presence after replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 $grp_key dst $vtep_ip src_vni 10010"
 	log_test $? 0 "MDB entry deletion"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\""
-	log_test $? 1 "MDB entry presence after deletion"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010"
+	log_test $? 254 "MDB entry presence after deletion"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 $grp_key dst $vtep_ip src_vni 10010"
 	log_test $? 255 "Non-existent MDB entry deletion"
 
 	# Default protocol and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 $grp_key permanent dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\" | grep \"proto static\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010 | grep \"proto static\""
 	log_test $? 0 "MDB entry default protocol"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 $grp_key permanent proto 123 dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\" | grep \"proto 123\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010 | grep \"proto 123\""
 	log_test $? 0 "MDB entry protocol replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 $grp_key dst $vtep_ip src_vni 10010"
 
 	# Default destination port and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 $grp_key permanent dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\" | grep \" dst_port \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010 | grep \" dst_port \""
 	log_test $? 1 "MDB entry default destination port"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 $grp_key permanent dst $vtep_ip dst_port 1234 src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\" | grep \"dst_port 1234\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010 | grep \"dst_port 1234\""
 	log_test $? 0 "MDB entry destination port replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 $grp_key dst $vtep_ip src_vni 10010"
 
 	# Default destination VNI and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 $grp_key permanent dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\" | grep \" vni \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010 | grep \" vni \""
 	log_test $? 1 "MDB entry default destination VNI"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 $grp_key permanent dst $vtep_ip vni 1234 src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\" | grep \"vni 1234\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010 | grep \"vni 1234\""
 	log_test $? 0 "MDB entry destination VNI replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 $grp_key dst $vtep_ip src_vni 10010"
 
 	# Default outgoing interface and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 $grp_key permanent dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\" | grep \" via \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010 | grep \" via \""
 	log_test $? 1 "MDB entry default outgoing interface"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 $grp_key permanent dst $vtep_ip src_vni 10010 via veth0"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep \"$grp_key\" | grep \"via veth0\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 $grp_key src_vni 10010 | grep \"via veth0\""
 	log_test $? 0 "MDB entry outgoing interface replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 $grp_key dst $vtep_ip src_vni 10010"
@@ -550,127 +550,127 @@ star_g_common()
 	# Basic add, replace and delete behavior.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip src_vni 10010"
 	log_test $? 0 "(*, G) MDB entry addition with source list"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010"
 	log_test $? 0 "(*, G) MDB entry presence after addition"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src1\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010"
 	log_test $? 0 "(S, G) MDB entry presence after addition"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip src_vni 10010"
 	log_test $? 0 "(*, G) MDB entry replacement with source list"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010"
 	log_test $? 0 "(*, G) MDB entry presence after replacement"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src1\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010"
 	log_test $? 0 "(S, G) MDB entry presence after replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 grp $grp dst $vtep_ip src_vni 10010"
 	log_test $? 0 "(*, G) MDB entry deletion"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \""
-	log_test $? 1 "(*, G) MDB entry presence after deletion"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src1\""
-	log_test $? 1 "(S, G) MDB entry presence after deletion"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010"
+	log_test $? 254 "(*, G) MDB entry presence after deletion"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010"
+	log_test $? 254 "(S, G) MDB entry presence after deletion"
 
 	# Default filter mode and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 grp $grp permanent dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep exclude"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep exclude"
 	log_test $? 0 "(*, G) MDB entry default filter mode"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode include source_list $src1 dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep include"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep include"
 	log_test $? 0 "(*, G) MDB entry after replacing filter mode to \"include\""
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src1\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010"
 	log_test $? 0 "(S, G) MDB entry after replacing filter mode to \"include\""
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src1\" | grep blocked"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep blocked"
 	log_test $? 1 "\"blocked\" flag after replacing filter mode to \"include\""
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep exclude"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep exclude"
 	log_test $? 0 "(*, G) MDB entry after replacing filter mode to \"exclude\""
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src1\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grep grp $grp src $src1 src_vni 10010"
 	log_test $? 0 "(S, G) MDB entry after replacing filter mode to \"exclude\""
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src1\" | grep blocked"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep blocked"
 	log_test $? 0 "\"blocked\" flag after replacing filter mode to \"exclude\""
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 grp $grp dst $vtep_ip src_vni 10010"
 
 	# Default source list and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 grp $grp permanent dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep source_list"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep source_list"
 	log_test $? 1 "(*, G) MDB entry default source list"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1,$src2,$src3 dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src1\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010"
 	log_test $? 0 "(S, G) MDB entry of 1st source after replacing source list"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src2\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src2 src_vni 10010"
 	log_test $? 0 "(S, G) MDB entry of 2nd source after replacing source list"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src3\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src3 src_vni 10010"
 	log_test $? 0 "(S, G) MDB entry of 3rd source after replacing source list"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1,$src3 dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src1\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010"
 	log_test $? 0 "(S, G) MDB entry of 1st source after removing source"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src2\""
-	log_test $? 1 "(S, G) MDB entry of 2nd source after removing source"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \"src $src3\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src2 src_vni 10010"
+	log_test $? 254 "(S, G) MDB entry of 2nd source after removing source"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src3 src_vni 10010"
 	log_test $? 0 "(S, G) MDB entry of 3rd source after removing source"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 grp $grp dst $vtep_ip src_vni 10010"
 
 	# Default protocol and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \" | grep \"proto static\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep \"proto static\""
 	log_test $? 0 "(*, G) MDB entry default protocol"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \" src \" | grep \"proto static\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep \"proto static\""
 	log_test $? 0 "(S, G) MDB entry default protocol"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 proto bgp dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \" | grep \"proto bgp\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep \"proto bgp\""
 	log_test $? 0 "(*, G) MDB entry protocol after replacement"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \" src \" | grep \"proto bgp\""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep \"proto bgp\""
 	log_test $? 0 "(S, G) MDB entry protocol after replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 grp $grp dst $vtep_ip src_vni 10010"
 
 	# Default destination port and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \" | grep \" dst_port \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep \" dst_port \""
 	log_test $? 1 "(*, G) MDB entry default destination port"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \" src \" | grep \" dst_port \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep \" dst_port \""
 	log_test $? 1 "(S, G) MDB entry default destination port"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip dst_port 1234 src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \" | grep \" dst_port 1234 \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep \" dst_port 1234 \""
 	log_test $? 0 "(*, G) MDB entry destination port after replacement"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \" src \" | grep \" dst_port 1234 \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep \" dst_port 1234 \""
 	log_test $? 0 "(S, G) MDB entry destination port after replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 grp $grp dst $vtep_ip src_vni 10010"
 
 	# Default destination VNI and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \" | grep \" vni \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep \" vni \""
 	log_test $? 1 "(*, G) MDB entry default destination VNI"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \" src \" | grep \" vni \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep \" vni \""
 	log_test $? 1 "(S, G) MDB entry default destination VNI"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip vni 1234 src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \" | grep \" vni 1234 \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep \" vni 1234 \""
 	log_test $? 0 "(*, G) MDB entry destination VNI after replacement"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \" src \" | grep \" vni 1234 \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep \" vni 1234 \""
 	log_test $? 0 "(S, G) MDB entry destination VNI after replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 grp $grp dst $vtep_ip src_vni 10010"
 
 	# Default outgoing interface and replacement.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \" | grep \" via \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep \" via \""
 	log_test $? 1 "(*, G) MDB entry default outgoing interface"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \" src \" | grep \" via \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep \" via \""
 	log_test $? 1 "(S, G) MDB entry default outgoing interface"
 
 	run_cmd "bridge -n $ns1 mdb replace dev vx0 port vx0 grp $grp permanent filter_mode exclude source_list $src1 dst $vtep_ip src_vni 10010 via veth0"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep -v \" src \" | grep \" via veth0 \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src_vni 10010 | grep \" via veth0 \""
 	log_test $? 0 "(*, G) MDB entry outgoing interface after replacement"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep \" src \" | grep \" via veth0 \""
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src1 src_vni 10010 | grep \" via veth0 \""
 	log_test $? 0 "(S, G) MDB entry outgoing interface after replacement"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 grp $grp dst $vtep_ip src_vni 10010"
@@ -772,7 +772,7 @@ sg_common()
 
 	# Default filter mode.
 	run_cmd "bridge -n $ns1 mdb add dev vx0 port vx0 grp $grp src $src permanent dst $vtep_ip src_vni 10010"
-	run_cmd "bridge -n $ns1 -d -s mdb show dev vx0 | grep $grp | grep include"
+	run_cmd "bridge -n $ns1 -d -s mdb get dev vx0 grp $grp src $src src_vni 10010 | grep include"
 	log_test $? 0 "(S, G) MDB entry default filter mode"
 
 	run_cmd "bridge -n $ns1 mdb del dev vx0 port vx0 grp $grp src $src permanent dst $vtep_ip src_vni 10010"
@@ -2296,9 +2296,9 @@ if [ ! -x "$(command -v jq)" ]; then
 	exit $ksft_skip
 fi
 
-bridge mdb help 2>&1 | grep -q "src_vni"
+bridge mdb help 2>&1 | grep -q "get"
 if [ $? -ne 0 ]; then
-   echo "SKIP: iproute2 bridge too old, missing VXLAN MDB support"
+   echo "SKIP: iproute2 bridge too old, missing VXLAN MDB get support"
    exit $ksft_skip
 fi
 
-- 
2.40.1


