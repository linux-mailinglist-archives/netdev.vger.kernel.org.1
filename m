Return-Path: <netdev+bounces-44175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 108BF7D6BB3
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC19F281AAC
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 12:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2873C286B3;
	Wed, 25 Oct 2023 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rX5VeudG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8F1286A7
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:32:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755B81B2
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:31:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlG6GYxzG6bKbhBhowwijGzdzGhLm7kaeVsbKpLznjDTz5JNZjTaTh+RYPqN/2ShkdeVOZBZu84y/onUfG35SOqkxb5bUPwDkii/qjT6qVE8RE1yTD/x5/GX/VJmViJ7tqEH4dvtHkOT6/rKJkkjmg0lksBmwz+3UzuUFQi4j5nTnd6VGPU1nM5Yzc1P7dw6veKExrBVD3j1ghf2SyohTBcwxRkXlS2QX9BukUQBOPlBfLPg4mbr8ZsD+ihawlMrFWft5spBK6uEnX19cPVrURRsoXoXNERoKIfcjPeQ129VtvdhazqRHeCHG9erwYn0vO1zDhSHyX1pm8gNghHZTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+zh9gRdw8UrafnO5YqJh1AgtyFjEhsxv9FcaQ82aGs=;
 b=DlT+hf4P3Uo72ozKiylDvDa5cyqMYcm+P//etAwyT3y0JofMNU8ELAkS1rqEMzsgrKcieVJ7nfJddxGsKDP1U/Jj1hhx0SzTCDRog2jUbLRkFQfe6J5TWldsMk1swtSNIJmJgWKL9ydvNHhb7hu9UqTV17Sntri8pWC9KrnkH3urvncickPqzA2vMl+tidsKDUsX0vJCue1K7jotp/TS2wVrfHhT9EfJHyv+BYgawSXqCO8O8wLroHkdbAOVse/bPz69PV0exyzZew7pavZJyJJpiUYjDZ5Bew4ofzhQftrVQEFoBZxRHtnlKG0o5cZGJF1uF5g26WP0weioWpx2Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+zh9gRdw8UrafnO5YqJh1AgtyFjEhsxv9FcaQ82aGs=;
 b=rX5VeudG1X6XF6XQV3Opt8uI10RI1zU10houS1g5/kwWt1CuQyN68TdklHx7Rv9gYG1yx4VUBkvm1yhJHpiGgZ5+ubzPYClq4zGXm8KaNI5w18VsOzGHuflHGNvZhljQbiMgoFqZFMJvnCDk4Tgyk8LvtfMT96eNm/Kfiyps0sciK+71vLann4ubi6k2CCIE+p0EcPid96f4JLCVmKfsjUC80/Z2xKr/Jvd6DJ+HibTLmMxkq17DyM+I65KdPXdMhaNNXMEN7/G8OFjsP9Sxr0RsJbdBoxPwdBHceIeJp9SoM/vzlv0E9FxNQ/S28feAv9rrZjSxUPJ4hd0SWyptDg==
Received: from DM6PR02CA0100.namprd02.prod.outlook.com (2603:10b6:5:1f4::41)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 12:31:51 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:1f4:cafe::eb) by DM6PR02CA0100.outlook.office365.com
 (2603:10b6:5:1f4::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 12:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.18 via Frontend Transport; Wed, 25 Oct 2023 12:31:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 05:31:36 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 25 Oct 2023 05:31:33 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <bridge@lists.linux-foundation.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <roopa@nvidia.com>, <razor@blackwall.org>,
	<mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next v2 13/13] selftests: vxlan_mdb: Use MDB get instead of dump
Date: Wed, 25 Oct 2023 15:30:20 +0300
Message-ID: <20231025123020.788710-14-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 069cc0b0-57fe-4028-20c0-08dbd5565d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TzQjTVD44UxQxXGce1NjyFbzniYrb7IuFoFsoSywflc4F10VACfSZn2c4dv5gI+MgMBymTpTKb6/uR71qc06MWdMhQtT589DuNECNuxUOtII/q1zDRircylfc3pdC0Brye4hx9J7gvIi7wXSKw7MKJ2KRJr2DzsI5sJYxjOVlfuI+f1zMb8o85GoxUZeAkkV2Df8xi5Tvf2HtH8iMXpf/K78ELfva0bayQZeKFXC5qzOq+zSe6ak15ONYn4m4duISaQYU40uCDWpbRHvV3xNZcev8+NYgtXZexBUTnJnU3Or8ExlS8kgHf6nsex7koefxSXUFYcQF0vPcsC2StV1vNydqa9vPyikfIlEarNc3YPBbtXIT8AqNCfLHnuSvQdBD0MpISPxQ43nx/zVF46kaSOpZ9WqOH8i1RZyGwvr7HfPrWp4TzdA+ya0gzfi8PeLkXUZcNYwpgEt3LTOQ7s+R77n2P2z5oXPieGGmppE8AQcadEnbqYZhU6lgBtONN9J+XT1hOLBW8s6BvwtizKkuyd5Q6YyG0ha5T9CL1t6hfqkUbkn4VO727GsWu7rQdctn7xTee5hxAkXfCVNq1Q6Gbh5NXszWFANgqG5Z2UQ+mSGDo8QlcZceLTuwLp6NaAToJQzGhg7FB+hNek3ly/yu6Xl50lBUVk6d0bq3UgxLv+Z17Q8/eQBLasiQGYxOR+fV1lyFDC7QDtZKDViT/a3Zs30uiKecMsnF/IoOLO7T7X0IZy2ma7rDltPyCntIq0b
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(82310400011)(451199024)(1800799009)(64100799003)(186009)(46966006)(36840700001)(40470700004)(30864003)(41300700001)(40460700003)(2906002)(70206006)(6666004)(54906003)(82740400003)(478600001)(16526019)(356005)(7636003)(47076005)(40480700001)(336012)(426003)(83380400001)(110136005)(86362001)(36756003)(5660300002)(2616005)(107886003)(36860700001)(1076003)(8676002)(8936002)(4326008)(70586007)(26005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 12:31:50.8793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 069cc0b0-57fe-4028-20c0-08dbd5565d2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565

Test the new MDB get functionality by converting dump and grep to MDB
get.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
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


