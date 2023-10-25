Return-Path: <netdev+bounces-44174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 142017D6BB2
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D501C20E3C
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 12:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D253128690;
	Wed, 25 Oct 2023 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wo61Knas"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E2262A7
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:32:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002E91B4
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBiPhd9f5yK7wHeahJtFbCJC7b51s0OANak962IHtEF0n66NZQ3FoGgWluANdW2idXjDMTrbjayAQ0Q1kA0hxtI2nqMyM0+vKGYxsFCtA7ChjEKkuCzl3TFSJxWsFuysklhpeG2gAQQzOdy+aVLNXAm0aqbh7l/CdDRJEVLKMaAGbHRTy8GIv6SylAMGfD4fCmrGw0zuAbBYMkqScECcw+Al1Pd9kkl3tCyMrHRTjcIJbxBM8eZestQNy9iyycr6PuDQ3Og8YRjHVThjZtB4fAwU4CgOcIZJ8z+Uu/dhGfLMsNpSYaqm8jzR1yHZW5pu+VEb1dc7JidS066ljFo7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLQbTMw2tdNIYtb3mm2w2to95OCN2Oc71ES5U3SPV4w=;
 b=CQW8LlT2ftIKaKYFaRBSavMG5tafdY84KXuXPOd/I0JLc2MVDHz4KcS/aPreJS6TjxJnlvmkZds98C/C8V0ZKSXq8h3gVZJ9uR74PDpoEAXHV0VhapelAQOiFuklW3wK7cKSrw7dV9hzPyRP1DDpypJJbe2RO6rBu64TtmSHYfUQ5+Z0TGDgRnoj4ozeQGXQq2FAMEzr0fDX8tVArol2hrsNKi33W5L5MenATcE4rzFb1DfMhdOfXNl20YaAHu0GWxxv5DqDjOjs+Gqi7mqmA6xJmXOMPFmRYbQQNmeyzIZ2nsNi4FIsFxPqHsKIknCbzdC4z1fwyQHC8z8DuQPhqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLQbTMw2tdNIYtb3mm2w2to95OCN2Oc71ES5U3SPV4w=;
 b=Wo61KnasSfvbsIdWor+eJbV1kNdkrIXfP+SFxutBHKsvleh+bj4bLVhOs7wf2qKfw/9PysagHD9MzJmUv2BOPTwAMCMwicN2UabZ5klVgk3HLLlo8BfPD1wz3x2yPSBGZdGw3NeFxdWfdGiet9eQxFjWkbXx0IEDL3XGQ6DsWDFw4hOfkyb0yVBm5TdpGpHZ/QrAcDDC+uxhGFeFu/Q0AMG6rqudb/3FwE4ptlV6iD4mbNezzrOfapueQZheeAThsTECl017PB2udbsd9EIO01ZSW2Tg0wP7qvVxeI7JCFm64ckvqeN25R/r1w+zEAFu5YPgVuJsoz6ZPLRG0H3KuQ==
Received: from MN2PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:23a::21)
 by IA0PR12MB7723.namprd12.prod.outlook.com (2603:10b6:208:431::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 12:31:50 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::49) by MN2PR03CA0016.outlook.office365.com
 (2603:10b6:208:23a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.39 via Frontend
 Transport; Wed, 25 Oct 2023 12:31:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 12:31:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 05:31:33 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 25 Oct 2023 05:31:30 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 12/13] selftests: bridge_mdb: Use MDB get instead of dump
Date: Wed, 25 Oct 2023 15:30:19 +0300
Message-ID: <20231025123020.788710-13-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231025123020.788710-1-idosch@nvidia.com>
References: <20231025123020.788710-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|IA0PR12MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c26a348-dd8a-452d-9316-08dbd5565c9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jBYKwROK/cg/u6ocmydRxf+YvvdlXiWdtrlBBqktzZ3goWNEeP+vHGYuY9Q5opZkXz3QJdhfn7s5KGKxuOhh1/n+gj7lSGkG3eeiE5attIaVTtjQjlzjKvLmYXVAAh/iNhizhqPKc8WAwD2y+1v4lk6QLuC5GZb/s/CiDeJ2pjJ4PyVaaNi6QjFOz/CeS6+6QNoy1T0VjTt+GCsTdmhpvGsVwwnRfQElqO9++yFucDqhTHtZ2Rfx2Qi7mJfa5qKM5Rrf8ujFFqC+HaeMVhqUd0wkGtdJYg7DxC0CEzrWyHMt2QMx2eJNTIo21zIHOHUO69pgIDIvPB1sK/wtC5MUzbOZDPyhRUxioi5NAWR7yE+Xu6Bk844q+uYd40MWx/AbpvbbY5BDIO40G0b7FyatzKp1K+QxBwJGvcvzyDGSdRia7wDrCuPht41lS1EyyxqXvz/To31alF4V/jILK6o8l+neZ0FHeznlrXuCdsJAoWpiUhPc3vUlDT+VGLeTHRh4m1A3/Wl48Y3pjFTIMHcHgtZ+ZpvebwvDaXI82gGGjdiYk3O8zWTf5jhTmcL6om69Uqbgtmf8hBCMtwK0lbtklh8tb5FGanFSgbVDWI6g4wLbo668ineJEICWyOnDUvu3kWnZ+faCDxa7wKkNhp/JPfzqpFUPKCDgGFIKZDC4WcxIou0I90ktA3uiQ316dsowJyj90UOxU93G8D+Tz6pIQ/U9vqvC8eLxAQ8RXG8mQ8ZQbFzxms0+k+Piqapsaeil
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(1800799009)(82310400011)(64100799003)(451199024)(186009)(40470700004)(46966006)(36840700001)(83380400001)(40460700003)(40480700001)(30864003)(8936002)(5660300002)(70586007)(110136005)(70206006)(41300700001)(86362001)(478600001)(54906003)(6666004)(316002)(36756003)(8676002)(4326008)(2906002)(426003)(356005)(7636003)(16526019)(2616005)(1076003)(26005)(336012)(82740400003)(36860700001)(107886003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 12:31:49.8891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c26a348-dd8a-452d-9316-08dbd5565c9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7723

Test the new MDB get functionality by converting dump and grep to MDB
get.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 .../selftests/net/forwarding/bridge_mdb.sh    | 184 +++++++-----------
 1 file changed, 71 insertions(+), 113 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index d0c6c499d5da..e4e3e9405056 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -145,14 +145,14 @@ cfg_test_host_common()
 
 	# Check basic add, replace and delete behavior.
 	bridge mdb add dev br0 port br0 grp $grp $state vid 10
-	bridge mdb show dev br0 vid 10 | grep -q "$grp"
+	bridge mdb get dev br0 grp $grp vid 10 &> /dev/null
 	check_err $? "Failed to add $name host entry"
 
 	bridge mdb replace dev br0 port br0 grp $grp $state vid 10 &> /dev/null
 	check_fail $? "Managed to replace $name host entry"
 
 	bridge mdb del dev br0 port br0 grp $grp $state vid 10
-	bridge mdb show dev br0 vid 10 | grep -q "$grp"
+	bridge mdb get dev br0 grp $grp vid 10 &> /dev/null
 	check_fail $? "Failed to delete $name host entry"
 
 	# Check error cases.
@@ -200,7 +200,7 @@ cfg_test_port_common()
 
 	# Check basic add, replace and delete behavior.
 	bridge mdb add dev br0 port $swp1 $grp_key permanent vid 10
-	bridge mdb show dev br0 vid 10 | grep -q "$grp_key"
+	bridge mdb get dev br0 $grp_key vid 10 &> /dev/null
 	check_err $? "Failed to add $name entry"
 
 	bridge mdb replace dev br0 port $swp1 $grp_key permanent vid 10 \
@@ -208,31 +208,31 @@ cfg_test_port_common()
 	check_err $? "Failed to replace $name entry"
 
 	bridge mdb del dev br0 port $swp1 $grp_key permanent vid 10
-	bridge mdb show dev br0 vid 10 | grep -q "$grp_key"
+	bridge mdb get dev br0 $grp_key vid 10 &> /dev/null
 	check_fail $? "Failed to delete $name entry"
 
 	# Check default protocol and replacement.
 	bridge mdb add dev br0 port $swp1 $grp_key permanent vid 10
-	bridge -d mdb show dev br0 vid 10 | grep "$grp_key" | grep -q "static"
+	bridge -d mdb get dev br0 $grp_key vid 10 | grep -q "static"
 	check_err $? "$name entry not added with default \"static\" protocol"
 
 	bridge mdb replace dev br0 port $swp1 $grp_key permanent vid 10 \
 		proto 123
-	bridge -d mdb show dev br0 vid 10 | grep "$grp_key" | grep -q "123"
+	bridge -d mdb get dev br0 $grp_key vid 10 | grep -q "123"
 	check_err $? "Failed to replace protocol of $name entry"
 	bridge mdb del dev br0 port $swp1 $grp_key permanent vid 10
 
 	# Check behavior when VLAN is not specified.
 	bridge mdb add dev br0 port $swp1 $grp_key permanent
-	bridge mdb show dev br0 vid 10 | grep -q "$grp_key"
+	bridge mdb get dev br0 $grp_key vid 10 &> /dev/null
 	check_err $? "$name entry with VLAN 10 not added when VLAN was not specified"
-	bridge mdb show dev br0 vid 20 | grep -q "$grp_key"
+	bridge mdb get dev br0 $grp_key vid 20 &> /dev/null
 	check_err $? "$name entry with VLAN 20 not added when VLAN was not specified"
 
 	bridge mdb del dev br0 port $swp1 $grp_key permanent
-	bridge mdb show dev br0 vid 10 | grep -q "$grp_key"
+	bridge mdb get dev br0 $grp_key vid 10 &> /dev/null
 	check_fail $? "$name entry with VLAN 10 not deleted when VLAN was not specified"
-	bridge mdb show dev br0 vid 20 | grep -q "$grp_key"
+	bridge mdb get dev br0 $grp_key vid 20 &> /dev/null
 	check_fail $? "$name entry with VLAN 20 not deleted when VLAN was not specified"
 
 	# Check behavior when bridge port is down.
@@ -298,21 +298,21 @@ __cfg_test_port_ip_star_g()
 	RET=0
 
 	bridge mdb add dev br0 port $swp1 grp $grp vid 10
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -q "exclude"
+	bridge -d mdb get dev br0 grp $grp vid 10 | grep -q "exclude"
 	check_err $? "Default filter mode is not \"exclude\""
 	bridge mdb del dev br0 port $swp1 grp $grp vid 10
 
 	# Check basic add and delete behavior.
 	bridge mdb add dev br0 port $swp1 grp $grp vid 10 filter_mode exclude \
 		source_list $src1
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -q -v "src"
+	bridge -d mdb get dev br0 grp $grp vid 10 &> /dev/null
 	check_err $? "(*, G) entry not created"
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -q "src $src1"
+	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 &> /dev/null
 	check_err $? "(S, G) entry not created"
 	bridge mdb del dev br0 port $swp1 grp $grp vid 10
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -q -v "src"
+	bridge -d mdb get dev br0 grp $grp vid 10 &> /dev/null
 	check_fail $? "(*, G) entry not deleted"
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -q "src $src1"
+	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 &> /dev/null
 	check_fail $? "(S, G) entry not deleted"
 
 	## State (permanent / temp) tests.
@@ -321,18 +321,15 @@ __cfg_test_port_ip_star_g()
 	bridge mdb add dev br0 port $swp1 grp $grp permanent vid 10 \
 		filter_mode exclude source_list $src1
 
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -v "src" | \
-		grep -q "permanent"
+	bridge -d mdb get dev br0 grp $grp vid 10 | grep -q "permanent"
 	check_err $? "(*, G) entry not added as \"permanent\" when should"
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep "src" | \
+	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 | \
 		grep -q "permanent"
 	check_err $? "(S, G) entry not added as \"permanent\" when should"
 
-	bridge -d -s mdb show dev br0 vid 10 | grep "$grp" | grep -v "src" | \
-		grep -q " 0.00"
+	bridge -d -s mdb get dev br0 grp $grp vid 10 | grep -q " 0.00"
 	check_err $? "(*, G) \"permanent\" entry has a pending group timer"
-	bridge -d -s mdb show dev br0 vid 10 | grep "$grp" | grep -v "src" | \
-		grep -q "\/0.00"
+	bridge -d -s mdb get dev br0 grp $grp vid 10 | grep -q "\/0.00"
 	check_err $? "\"permanent\" source entry has a pending source timer"
 
 	bridge mdb del dev br0 port $swp1 grp $grp vid 10
@@ -342,18 +339,14 @@ __cfg_test_port_ip_star_g()
 	bridge mdb add dev br0 port $swp1 grp $grp temp vid 10 \
 		filter_mode exclude source_list $src1
 
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -v "src" | \
-		grep -q "temp"
+	bridge -d mdb get dev br0 grp $grp vid 10 | grep -q "temp"
 	check_err $? "(*, G) EXCLUDE entry not added as \"temp\" when should"
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep "src" | \
-		grep -q "temp"
+	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 | grep -q "temp"
 	check_err $? "(S, G) \"blocked\" entry not added as \"temp\" when should"
 
-	bridge -d -s mdb show dev br0 vid 10 | grep "$grp" | grep -v "src" | \
-		grep -q " 0.00"
+	bridge -d -s mdb get dev br0 grp $grp vid 10 | grep -q " 0.00"
 	check_fail $? "(*, G) EXCLUDE entry does not have a pending group timer"
-	bridge -d -s mdb show dev br0 vid 10 | grep "$grp" | grep -v "src" | \
-		grep -q "\/0.00"
+	bridge -d -s mdb get dev br0 grp $grp vid 10 | grep -q "\/0.00"
 	check_err $? "\"blocked\" source entry has a pending source timer"
 
 	bridge mdb del dev br0 port $swp1 grp $grp vid 10
@@ -363,18 +356,14 @@ __cfg_test_port_ip_star_g()
 	bridge mdb add dev br0 port $swp1 grp $grp temp vid 10 \
 		filter_mode include source_list $src1
 
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -v "src" | \
-		grep -q "temp"
+	bridge -d mdb get dev br0 grp $grp vid 10 | grep -q "temp"
 	check_err $? "(*, G) INCLUDE entry not added as \"temp\" when should"
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep "src" | \
-		grep -q "temp"
+	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 | grep -q "temp"
 	check_err $? "(S, G) entry not added as \"temp\" when should"
 
-	bridge -d -s mdb show dev br0 vid 10 | grep "$grp" | grep -v "src" | \
-		grep -q " 0.00"
+	bridge -d -s mdb get dev br0 grp $grp vid 10 | grep -q " 0.00"
 	check_err $? "(*, G) INCLUDE entry has a pending group timer"
-	bridge -d -s mdb show dev br0 vid 10 | grep "$grp" | grep -v "src" | \
-		grep -q "\/0.00"
+	bridge -d -s mdb get dev br0 grp $grp vid 10 | grep -q "\/0.00"
 	check_fail $? "Source entry does not have a pending source timer"
 
 	bridge mdb del dev br0 port $swp1 grp $grp vid 10
@@ -383,8 +372,7 @@ __cfg_test_port_ip_star_g()
 	bridge mdb add dev br0 port $swp1 grp $grp temp vid 10 \
 		filter_mode include source_list $src1
 
-	bridge -d -s mdb show dev br0 vid 10 | grep "$grp" | grep "src" | \
-		grep -q " 0.00"
+	bridge -d -s mdb get dev br0 grp $grp src $src1 vid 10 | grep -q " 0.00"
 	check_err $? "(S, G) entry has a pending group timer"
 
 	bridge mdb del dev br0 port $swp1 grp $grp vid 10
@@ -396,11 +384,9 @@ __cfg_test_port_ip_star_g()
 	bridge mdb add dev br0 port $swp1 grp $grp vid 10 \
 		filter_mode include source_list $src1
 
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -v "src" | \
-		grep -q "include"
+	bridge -d mdb get dev br0 grp $grp vid 10 | grep -q "include"
 	check_err $? "(*, G) INCLUDE not added with \"include\" filter mode"
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep "src" | \
-		grep -q "blocked"
+	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 | grep -q "blocked"
 	check_fail $? "(S, G) entry marked as \"blocked\" when should not"
 
 	bridge mdb del dev br0 port $swp1 grp $grp vid 10
@@ -410,11 +396,9 @@ __cfg_test_port_ip_star_g()
 	bridge mdb add dev br0 port $swp1 grp $grp vid 10 \
 		filter_mode exclude source_list $src1
 
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -v "src" | \
-		grep -q "exclude"
+	bridge -d mdb get dev br0 grp $grp vid 10 | grep -q "exclude"
 	check_err $? "(*, G) EXCLUDE not added with \"exclude\" filter mode"
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep "src" | \
-		grep -q "blocked"
+	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 | grep -q "blocked"
 	check_err $? "(S, G) entry not marked as \"blocked\" when should"
 
 	bridge mdb del dev br0 port $swp1 grp $grp vid 10
@@ -426,11 +410,9 @@ __cfg_test_port_ip_star_g()
 	bridge mdb add dev br0 port $swp1 grp $grp vid 10 \
 		filter_mode exclude source_list $src1 proto zebra
 
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -v "src" | \
-		grep -q "zebra"
+	bridge -d mdb get dev br0 grp $grp vid 10 | grep -q "zebra"
 	check_err $? "(*, G) entry not added with \"zebra\" protocol"
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep "src" | \
-		grep -q "zebra"
+	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 | grep -q "zebra"
 	check_err $? "(S, G) entry not marked added with \"zebra\" protocol"
 
 	bridge mdb del dev br0 port $swp1 grp $grp vid 10
@@ -443,20 +425,16 @@ __cfg_test_port_ip_star_g()
 
 	bridge mdb replace dev br0 port $swp1 grp $grp permanent vid 10 \
 		filter_mode exclude source_list $src1
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -v "src" | \
-		grep -q "permanent"
+	bridge -d mdb get dev br0 grp $grp vid 10 | grep -q "permanent"
 	check_err $? "(*, G) entry not marked as \"permanent\" after replace"
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep "src" | \
-		grep -q "permanent"
+	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 | grep -q "permanent"
 	check_err $? "(S, G) entry not marked as \"permanent\" after replace"
 
 	bridge mdb replace dev br0 port $swp1 grp $grp temp vid 10 \
 		filter_mode exclude source_list $src1
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -v "src" | \
-		grep -q "temp"
+	bridge -d mdb get dev br0 grp $grp vid 10 | grep -q "temp"
 	check_err $? "(*, G) entry not marked as \"temp\" after replace"
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep "src" | \
-		grep -q "temp"
+	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 | grep -q "temp"
 	check_err $? "(S, G) entry not marked as \"temp\" after replace"
 
 	bridge mdb del dev br0 port $swp1 grp $grp vid 10
@@ -467,20 +445,16 @@ __cfg_test_port_ip_star_g()
 
 	bridge mdb replace dev br0 port $swp1 grp $grp temp vid 10 \
 		filter_mode include source_list $src1
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -v "src" | \
-		grep -q "include"
+	bridge -d mdb get dev br0 grp $grp vid 10 | grep -q "include"
 	check_err $? "(*, G) not marked with \"include\" filter mode after replace"
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep "src" | \
-		grep -q "blocked"
+	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 | grep -q "blocked"
 	check_fail $? "(S, G) marked as \"blocked\" after replace"
 
 	bridge mdb replace dev br0 port $swp1 grp $grp temp vid 10 \
 		filter_mode exclude source_list $src1
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -v "src" | \
-		grep -q "exclude"
+	bridge -d mdb get dev br0 grp $grp vid 10 | grep -q "exclude"
 	check_err $? "(*, G) not marked with \"exclude\" filter mode after replace"
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep "src" | \
-		grep -q "blocked"
+	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 | grep -q "blocked"
 	check_err $? "(S, G) not marked as \"blocked\" after replace"
 
 	bridge mdb del dev br0 port $swp1 grp $grp vid 10
@@ -491,20 +465,20 @@ __cfg_test_port_ip_star_g()
 
 	bridge mdb replace dev br0 port $swp1 grp $grp temp vid 10 \
 		filter_mode exclude source_list $src1,$src2,$src3
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -q "src $src1"
+	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 &> /dev/null
 	check_err $? "(S, G) entry for source $src1 not created after replace"
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -q "src $src2"
+	bridge -d mdb get dev br0 grp $grp src $src2 vid 10 &> /dev/null
 	check_err $? "(S, G) entry for source $src2 not created after replace"
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -q "src $src3"
+	bridge -d mdb get dev br0 grp $grp src $src3 vid 10 &> /dev/null
 	check_err $? "(S, G) entry for source $src3 not created after replace"
 
 	bridge mdb replace dev br0 port $swp1 grp $grp temp vid 10 \
 		filter_mode exclude source_list $src1,$src3
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -q "src $src1"
+	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 &> /dev/null
 	check_err $? "(S, G) entry for source $src1 not created after second replace"
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -q "src $src2"
+	bridge -d mdb get dev br0 grp $grp src $src2 vid 10 &> /dev/null
 	check_fail $? "(S, G) entry for source $src2 created after second replace"
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -q "src $src3"
+	bridge -d mdb get dev br0 grp $grp src $src3 vid 10 &> /dev/null
 	check_err $? "(S, G) entry for source $src3 not created after second replace"
 
 	bridge mdb del dev br0 port $swp1 grp $grp vid 10
@@ -515,11 +489,9 @@ __cfg_test_port_ip_star_g()
 
 	bridge mdb replace dev br0 port $swp1 grp $grp temp vid 10 \
 		filter_mode exclude source_list $src1 proto bgp
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep -v "src" | \
-		grep -q "bgp"
+	bridge -d mdb get dev br0 grp $grp vid 10 | grep -q "bgp"
 	check_err $? "(*, G) protocol not changed to \"bgp\" after replace"
-	bridge -d mdb show dev br0 vid 10 | grep "$grp" | grep "src" | \
-		grep -q "bgp"
+	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 | grep -q "bgp"
 	check_err $? "(S, G) protocol not changed to \"bgp\" after replace"
 
 	bridge mdb del dev br0 port $swp1 grp $grp vid 10
@@ -532,8 +504,8 @@ __cfg_test_port_ip_star_g()
 	bridge mdb add dev br0 port $swp2 grp $grp vid 10 \
 		filter_mode include source_list $src1
 	bridge mdb add dev br0 port $swp1 grp $grp vid 10
-	bridge -d mdb show dev br0 vid 10 | grep "$swp1" | grep "$grp" | \
-		grep "$src1" | grep -q "added_by_star_ex"
+	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 | grep "$swp1" | \
+		grep -q "added_by_star_ex"
 	check_err $? "\"added_by_star_ex\" entry not created after adding (*, G) entry"
 	bridge mdb del dev br0 port $swp1 grp $grp vid 10
 	bridge mdb del dev br0 port $swp2 grp $grp src $src1 vid 10
@@ -606,27 +578,23 @@ __cfg_test_port_ip_sg()
 	RET=0
 
 	bridge mdb add dev br0 port $swp1 $grp_key vid 10
-	bridge -d mdb show dev br0 vid 10 | grep "$grp_key" | grep -q "include"
+	bridge -d mdb get dev br0 $grp_key vid 10 | grep -q "include"
 	check_err $? "Default filter mode is not \"include\""
 	bridge mdb del dev br0 port $swp1 $grp_key vid 10
 
 	# Check that entries can be added as both permanent and temp and that
 	# group timer is set correctly.
 	bridge mdb add dev br0 port $swp1 $grp_key permanent vid 10
-	bridge -d mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q "permanent"
+	bridge -d mdb get dev br0 $grp_key vid 10 | grep -q "permanent"
 	check_err $? "Entry not added as \"permanent\" when should"
-	bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q " 0.00"
+	bridge -d -s mdb get dev br0 $grp_key vid 10 | grep -q " 0.00"
 	check_err $? "\"permanent\" entry has a pending group timer"
 	bridge mdb del dev br0 port $swp1 $grp_key vid 10
 
 	bridge mdb add dev br0 port $swp1 $grp_key temp vid 10
-	bridge -d mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q "temp"
+	bridge -d mdb get dev br0 $grp_key vid 10 | grep -q "temp"
 	check_err $? "Entry not added as \"temp\" when should"
-	bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q " 0.00"
+	bridge -d -s mdb get dev br0 $grp_key vid 10 | grep -q " 0.00"
 	check_fail $? "\"temp\" entry has an unpending group timer"
 	bridge mdb del dev br0 port $swp1 $grp_key vid 10
 
@@ -650,24 +618,19 @@ __cfg_test_port_ip_sg()
 	# Check that we can replace available attributes.
 	bridge mdb add dev br0 port $swp1 $grp_key vid 10 proto 123
 	bridge mdb replace dev br0 port $swp1 $grp_key vid 10 proto 111
-	bridge -d mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q "111"
+	bridge -d mdb get dev br0 $grp_key vid 10 | grep -q "111"
 	check_err $? "Failed to replace protocol"
 
 	bridge mdb replace dev br0 port $swp1 $grp_key vid 10 permanent
-	bridge -d mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q "permanent"
+	bridge -d mdb get dev br0 $grp_key vid 10 | grep -q "permanent"
 	check_err $? "Entry not marked as \"permanent\" after replace"
-	bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q " 0.00"
+	bridge -d -s mdb get dev br0 $grp_key vid 10 | grep -q " 0.00"
 	check_err $? "Entry has a pending group timer after replace"
 
 	bridge mdb replace dev br0 port $swp1 $grp_key vid 10 temp
-	bridge -d mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q "temp"
+	bridge -d mdb get dev br0 $grp_key vid 10 | grep -q "temp"
 	check_err $? "Entry not marked as \"temp\" after replace"
-	bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q " 0.00"
+	bridge -d -s mdb get dev br0 $grp_key vid 10 | grep -q " 0.00"
 	check_fail $? "Entry has an unpending group timer after replace"
 	bridge mdb del dev br0 port $swp1 $grp_key vid 10
 
@@ -675,7 +638,7 @@ __cfg_test_port_ip_sg()
 	# (*, G) ports need to be added to it.
 	bridge mdb add dev br0 port $swp2 grp $grp vid 10
 	bridge mdb add dev br0 port $swp1 $grp_key vid 10
-	bridge mdb show dev br0 vid 10 | grep "$grp_key" | grep $swp2 | \
+	bridge mdb get dev br0 $grp_key vid 10 | grep $swp2 | \
 		grep -q "added_by_star_ex"
 	check_err $? "\"added_by_star_ex\" entry not created after adding (S, G) entry"
 	bridge mdb del dev br0 port $swp1 $grp_key vid 10
@@ -1132,7 +1095,7 @@ ctrl_igmpv3_is_in_test()
 	$MZ $h1.10 -c 1 -a own -b 01:00:5e:01:01:01 -A 192.0.2.1 -B 239.1.1.1 \
 		-t ip proto=2,p=$(igmpv3_is_in_get 239.1.1.1 192.0.2.2) -q
 
-	bridge -d mdb show dev br0 vid 10 | grep 239.1.1.1 | grep -q 192.0.2.2
+	bridge mdb get dev br0 grp 239.1.1.1 src 192.0.2.2 vid 10 &> /dev/null
 	check_fail $? "Permanent entry affected by IGMP packet"
 
 	# Replace the permanent entry with a temporary one and check that after
@@ -1145,12 +1108,10 @@ ctrl_igmpv3_is_in_test()
 	$MZ $h1.10 -a own -b 01:00:5e:01:01:01 -c 1 -A 192.0.2.1 -B 239.1.1.1 \
 		-t ip proto=2,p=$(igmpv3_is_in_get 239.1.1.1 192.0.2.2) -q
 
-	bridge -d mdb show dev br0 vid 10 | grep 239.1.1.1 | grep -v "src" | \
-		grep -q 192.0.2.2
+	bridge -d mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q 192.0.2.2
 	check_err $? "Source not add to source list"
 
-	bridge -d mdb show dev br0 vid 10 | grep 239.1.1.1 | \
-		grep -q "src 192.0.2.2"
+	bridge mdb get dev br0 grp 239.1.1.1 src 192.0.2.2 vid 10 &> /dev/null
 	check_err $? "(S, G) entry not created for new source"
 
 	bridge mdb del dev br0 port $swp1 grp 239.1.1.1 vid 10
@@ -1172,8 +1133,7 @@ ctrl_mldv2_is_in_test()
 	$MZ -6 $h1.10 -a own -b 33:33:00:00:00:01 -c 1 -A fe80::1 -B ff0e::1 \
 		-t ip hop=1,next=0,p="$p" -q
 
-	bridge -d mdb show dev br0 vid 10 | grep ff0e::1 | \
-		grep -q 2001:db8:1::2
+	bridge mdb get dev br0 grp ff0e::1 src 2001:db8:1::2 vid 10 &> /dev/null
 	check_fail $? "Permanent entry affected by MLD packet"
 
 	# Replace the permanent entry with a temporary one and check that after
@@ -1186,12 +1146,10 @@ ctrl_mldv2_is_in_test()
 	$MZ -6 $h1.10 -a own -b 33:33:00:00:00:01 -c 1 -A fe80::1 -B ff0e::1 \
 		-t ip hop=1,next=0,p="$p" -q
 
-	bridge -d mdb show dev br0 vid 10 | grep ff0e::1 | grep -v "src" | \
-		grep -q 2001:db8:1::2
+	bridge -d mdb get dev br0 grp ff0e::1 vid 10 | grep -q 2001:db8:1::2
 	check_err $? "Source not add to source list"
 
-	bridge -d mdb show dev br0 vid 10 | grep ff0e::1 | \
-		grep -q "src 2001:db8:1::2"
+	bridge mdb get dev br0 grp ff0e::1 src 2001:db8:1::2 vid 10 &> /dev/null
 	check_err $? "(S, G) entry not created for new source"
 
 	bridge mdb del dev br0 port $swp1 grp ff0e::1 vid 10
@@ -1208,8 +1166,8 @@ ctrl_test()
 	ctrl_mldv2_is_in_test
 }
 
-if ! bridge mdb help 2>&1 | grep -q "replace"; then
-	echo "SKIP: iproute2 too old, missing bridge mdb replace support"
+if ! bridge mdb help 2>&1 | grep -q "get"; then
+	echo "SKIP: iproute2 too old, missing bridge mdb get support"
 	exit $ksft_skip
 fi
 
-- 
2.40.1


