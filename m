Return-Path: <netdev+bounces-59929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD5481CB11
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 15:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D092861DB
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 14:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B661C693;
	Fri, 22 Dec 2023 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OzbqP/s0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007281B271
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLKvEQw23Hw1NIzQmQ4QkB+sI4LBT+BS0SJ0AggEI2HVpJR+vdKD9Zxsd+E2y2PT8FtMav9Inq8hLbcH8DsmO4YBUd8tex1neL5BPppdZK0f+vAStN5NdU6JD7n7yHmZA9vlSlQOh1D06U0YMo8vv5yx69Od3Ya87/LXWlbiYjjLmhz2+aae1QUrNF3ciSOWuQ2r93l0ZIC7cRw8amlcDDRzQ0AiE0aa95syzpiltmtw0qpkVx2GimLXZNecBkPgetn+kKxAeskjFf5wjptW1QVe5//UcsR3hL4vlbNrgHdynjkM/rQWpBTAs24+otnyd+kH3zAgaJ5sgl+TGLmC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+62msIBJqE5kARCTjcNURfn7oWX2jJ7B0KpKQ2XVrY=;
 b=SlrnHTmWujIOQvwZKShRcTyCz3ULHZtWIWbuaSU6jDpVj/MI7Rk48zFEswuyYAyRaYdIw/vYJ+LkCYDRyYWeQXRNC26hP701nKqPaC5dY6F+tx+bVWTiK+KrkfZcSNGrg1fg7pfV7Fq17HdP0Im88fIYLNkvy1N3kKaHo8CBrjh23yAvM5+5KQm6KpNyDLqZlRq0Ld36gyDFzb/pGQgT+kQEe5OU5PUr3+KRT3GGVfAZlwumSi5V9h15L69iSPLlxO3LSVJxYZHDmIu/eNIrdVTrMh82h/pu4yObOKnby5MZFd0vA4S8xGGDRPBCxSNesiTofTxFmZERpB+iZ7CsHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+62msIBJqE5kARCTjcNURfn7oWX2jJ7B0KpKQ2XVrY=;
 b=OzbqP/s0A69NPMBipoNCyldLT6iGZZrI1mSwmQD3WEEsfo0Jb3IwGpSjMZ6bo0tGOf4vQBs+8XX/dX5P4K7TqOo5is6ed0xx76NMARYSsk+dULXrmfvrecvYm6jo3v394q7GQYIM2xJL1bWOHhKDem4L7q+9MO4BXHLXLzTBUO6lrzvm3Cl6238cXobA8r6w4hFvL1BPhHdmkYtZQckv6aF1ncudbbRyPx9642kjBCcDLoK2SeQ5gqEzDnfbG8TSPnMBICvt1Zd/AbEfm2ZcpN7ekNO0w272fcSogBTg8LoDllN1vSfNeJRTcY8nOgCrd65cFsL2FDZ52PX87DMjRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 14:00:11 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 14:00:10 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [RFC PATCH net-next 07/10] selftests: bonding: Add lib.sh scripts to TEST_INCLUDES
Date: Fri, 22 Dec 2023 08:58:33 -0500
Message-ID: <20231222135836.992841-8-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222135836.992841-1-bpoirier@nvidia.com>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0273.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::22) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BL0PR12MB4849:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1d9af8-9c0d-45b8-caf2-08dc02f65006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3+l1PaM+rtsREh7rF9/qGNvaqSd5ee7TImZ74TZdmTiK+T3dEXG90tQLHs2uxBq359Y+jQcIFjCWXUk+9+ML0UiWH7iiFpOTjLdKelEH7zMWEV4cTbGCytrxvxfIVsH+p5xVl1Fd6urWyaZePKMgGoO0Xrq95zGxbYTIrOoErtIsr8cHJv0EH8qQVF/X4h43supY9Z+kZcsbKVkQiY8RiTdrMMGpK7Hb+7yRjDu5NTS2/CKuhY6Cw2qLisrfZ5LlPFGEuOtMb2A3RoeoPdfWI7wiVK4Vo6KkPJ8q1cyzjH9IL0QEn1beCRkZhxK2N/eOm9EstQpuas/9XAj+H860pHpzSZnLQMyDIn+by6obQhTnx3z5HFhgWMo9fjhjzzJtLnI8mzrR0MbOeOs9c7EhUweKWugJqp9t+/2SiHEVeO+PE0+CG7bhBUikmdHUBKCAqOpa8P2WRprkEJzXtU3xMNO+4Cko+AX0lDdIyoJvpyy7eOZq0V98tWQhsqpD/taIicu+0sxmixwbfJsnla1CIXYM4OgjzB57ThtpFshHq1INaApIIjvEwa9Ufh+5TzLg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39850400004)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(8936002)(8676002)(4326008)(2906002)(5660300002)(478600001)(6506007)(6666004)(6512007)(316002)(66946007)(6916009)(54906003)(66476007)(66556008)(6486002)(41300700001)(38100700002)(83380400001)(36756003)(26005)(2616005)(1076003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PvGWO3h71iyCBa0nzELXlpzpcbD+Gqpg+ZIDdeP9NSHjrR7Nub/a9llFeehC?=
 =?us-ascii?Q?72Jcfic8xO1RTRHQ1Fva6g6fAs1zA87eqD8B9enQofUloO5XCl3fyKCj/hei?=
 =?us-ascii?Q?Sa1TP3jfNTNPzj7cH0cV9ohk4meS+hYgFuo2o661hX3QrjvdR+cTBZzr2CzB?=
 =?us-ascii?Q?0oerHeEyAtsY3HS/TeBimW02N/bRBxyEQOH29jhVLZaKCbMty77OLC9tKFST?=
 =?us-ascii?Q?M79qiT8KFmjYWAfXz8PYILnhDlXt0F33wvJpWfbxvyxWGPTz06HlF5cHoae1?=
 =?us-ascii?Q?/lzI5tF0M3U3rBrrZRFYzUSwy48u1SLowDlPvBih5I5yMTd8iGxSjh4eMmfG?=
 =?us-ascii?Q?XvJ/1gQN2L1aueXsi2opxKhwi/CG/QVhiPG2QhlIJtCO6FLY+p3dkWMt1dqZ?=
 =?us-ascii?Q?8S2HikX3USAZncPjTzKIAgV8V9hWiWnvlJsdlBvF2Y7KcOxkTSoN5txcmkN9?=
 =?us-ascii?Q?4NbHeUPUIfMsmkbskXYQeoUez0yA+/2OT5D/dti6QAGyTBl1g/aJ5/Yl2RNr?=
 =?us-ascii?Q?hfIWm1WI6yqBVo0/6rcQzrIj6A5xYWDZpUYt1Kg/Ce0vTpDUa4UeLdDGj0x9?=
 =?us-ascii?Q?uCAkP0eyN5Q5JEu990SjI95Bvc6wcZgnhCAfaUbiGtabbtXPMhsEJ5BnGKGR?=
 =?us-ascii?Q?ve3hc9TEL1EYjm+2aMKlSNuurl7aARBRuseqY/r4vDK8PYhAl3JBxbtvUwDS?=
 =?us-ascii?Q?QWw5szNRtZYWnUGGAzCowXpLl+rELw+fBczo1bERDDJL3eZ93/dCPVQKkOw9?=
 =?us-ascii?Q?FKU40pSWlXtZeVC8MM7Bjg0vWmsFrpAb0yxrgEeAGZH4wnbmp1oj+pv09XNY?=
 =?us-ascii?Q?aLyJl/FB3Lj9AeXVCjQtNpyRs+ZiG4uo/yB6V2RhiT9gCmsmKFqKLzNqepk6?=
 =?us-ascii?Q?weTa0elBql+EZE/GLzQHRo0wOWI7HzLAbH8Mef4h4ptG4SFOKE9VG8rHMnwk?=
 =?us-ascii?Q?/vUdoxLaSBwdPD//t8J6R/UXyFsIBRQiMvpFak/fRejLlLdnW7Z440EdbQ2k?=
 =?us-ascii?Q?+yt5VlfBJ5K3G1GPHfWmKTw9sKj+AvDw3gg8aY9NhpdIQ93Udkjc4uSOIktH?=
 =?us-ascii?Q?QXaOp/O60AESBuVRl91IWnNV3ZUMJnmPR5nDwJd1LBLMkYTTUq4FHkheBaU8?=
 =?us-ascii?Q?ECRCenDiYnZ3UNeRimdGEJ9JG4uYoG7H2P9UAe3yQvNRktHvI4NfBSZPoex8?=
 =?us-ascii?Q?mzLik02k+6SilhOHYnEu+gYQxM+8HML0FUDsodHNkd+YPyRgaR+zgUynRfkO?=
 =?us-ascii?Q?wy6l6Wmrj7D3fa1jrQh3dGs+Bv7wXJ/WLzDE/ASJxaDvnI0AAzG7l/vR0b1H?=
 =?us-ascii?Q?2t8gqUEAMD+ajeBVfaK+LMmY+cj54dlHZdjQs8vAH0oaUOYTEG6LCUHHn1rm?=
 =?us-ascii?Q?TK3YxOzHbVHP9c8hib+Efa5SFooIoBZFRGQ1KnWkTsm/A8f2kEenOQYFNWma?=
 =?us-ascii?Q?nPBOmZDbPLpU8MBTqO8MEOyhiTrIY+WI5tLyWlYbbWRS5O5xMbiIcy4XIE0r?=
 =?us-ascii?Q?L48rrMUl8Zc7/3wYd/g4BZtOePqQOtKRmToU0Kkx6hbcjYz6COoH2pCgVV12?=
 =?us-ascii?Q?sqaW9H93YmE8nY8+o7Lrz7ayNXkQlltbx5a/OIP4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1d9af8-9c0d-45b8-caf2-08dc02f65006
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 14:00:10.8951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CUEmrA7gnAiFCJNvdqCZHw4WGQq1AGPKHMInDD2nAFYKbFEWEX4fZBDoUa06R9BSQNEW973K8dNILFDKwk5PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4849

Since commit 25ae948b4478 ("selftests/net: add lib.sh"), when exporting the
bonding tests and running them, the tests that import net/forwarding/lib.sh
fail to import net/lib.sh. This prints an error message but since the
bonding tests do not use functions from net/lib.sh, this does not affect
the test results.

Example:
	kselftest_install# ./run_kselftest.sh -t drivers/net/bonding:dev_addr_lists.sh
	TAP version 13
	1..1
	# timeout set to 120
	# selftests: drivers/net/bonding: dev_addr_lists.sh
	# ./net_forwarding_lib.sh: line 38: /src/linux/tools/testing/selftests/kselftest_install/drivers/net/bonding/../lib.sh: No such file or directory
	# TEST: bonding cleanup mode active-backup                            [ OK ]
	# TEST: bonding cleanup mode 802.3ad                                  [ OK ]
	# TEST: bonding LACPDU multicast address to slave (from bond down)    [ OK ]
	# TEST: bonding LACPDU multicast address to slave (from bond up)      [ OK ]
	ok 1 selftests: drivers/net/bonding: dev_addr_lists.sh

In order to avoid the error message, net/forwarding/lib.sh is exported and
included via its relative path and net/lib.sh is also exported.

Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/drivers/net/bonding/Makefile       | 7 +++++--
 .../selftests/drivers/net/bonding/bond-eth-type-change.sh  | 2 +-
 .../selftests/drivers/net/bonding/bond_topo_2d1c.sh        | 2 +-
 .../selftests/drivers/net/bonding/dev_addr_lists.sh        | 2 +-
 .../drivers/net/bonding/mode-1-recovery-updelay.sh         | 2 +-
 .../drivers/net/bonding/mode-2-recovery-updelay.sh         | 2 +-
 .../selftests/drivers/net/bonding/net_forwarding_lib.sh    | 1 -
 7 files changed, 10 insertions(+), 8 deletions(-)
 delete mode 120000 tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 8a72bb7de70f..a61fe339b9be 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -15,7 +15,10 @@ TEST_PROGS := \
 TEST_FILES := \
 	lag_lib.sh \
 	bond_topo_2d1c.sh \
-	bond_topo_3d1c.sh \
-	net_forwarding_lib.sh
+	bond_topo_3d1c.sh
+
+TEST_INCLUDES := \
+	net/forwarding/lib.sh \
+	net/lib.sh
 
 include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/net/bonding/bond-eth-type-change.sh b/tools/testing/selftests/drivers/net/bonding/bond-eth-type-change.sh
index 862e947e17c7..8293dbc7c18f 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond-eth-type-change.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond-eth-type-change.sh
@@ -11,7 +11,7 @@ ALL_TESTS="
 REQUIRE_MZ=no
 NUM_NETIFS=0
 lib_dir=$(dirname "$0")
-source "$lib_dir"/net_forwarding_lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
 bond_check_flags()
 {
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh b/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
index a509ef949dcf..0eb7edfb584c 100644
--- a/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh
@@ -28,7 +28,7 @@
 REQUIRE_MZ=no
 NUM_NETIFS=0
 lib_dir=$(dirname "$0")
-source ${lib_dir}/net_forwarding_lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
 s_ns="s-$(mktemp -u XXXXXX)"
 c_ns="c-$(mktemp -u XXXXXX)"
diff --git a/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.sh b/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.sh
index 5cfe7d8ebc25..e6fa24eded5b 100755
--- a/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.sh
+++ b/tools/testing/selftests/drivers/net/bonding/dev_addr_lists.sh
@@ -14,7 +14,7 @@ ALL_TESTS="
 REQUIRE_MZ=no
 NUM_NETIFS=0
 lib_dir=$(dirname "$0")
-source "$lib_dir"/net_forwarding_lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
 source "$lib_dir"/lag_lib.sh
 
diff --git a/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh b/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh
index b76bf5030952..9d26ab4cad0b 100755
--- a/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh
+++ b/tools/testing/selftests/drivers/net/bonding/mode-1-recovery-updelay.sh
@@ -23,7 +23,7 @@ REQUIRE_MZ=no
 REQUIRE_JQ=no
 NUM_NETIFS=0
 lib_dir=$(dirname "$0")
-source "$lib_dir"/net_forwarding_lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 source "$lib_dir"/lag_lib.sh
 
 cleanup()
diff --git a/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh b/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh
index 8c2619002147..2d275b3e47dd 100755
--- a/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh
+++ b/tools/testing/selftests/drivers/net/bonding/mode-2-recovery-updelay.sh
@@ -23,7 +23,7 @@ REQUIRE_MZ=no
 REQUIRE_JQ=no
 NUM_NETIFS=0
 lib_dir=$(dirname "$0")
-source "$lib_dir"/net_forwarding_lib.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 source "$lib_dir"/lag_lib.sh
 
 cleanup()
diff --git a/tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh b/tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh
deleted file mode 120000
index 39c96828c5ef..000000000000
--- a/tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh
+++ /dev/null
@@ -1 +0,0 @@
-../../../net/forwarding/lib.sh
\ No newline at end of file
-- 
2.43.0


