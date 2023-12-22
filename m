Return-Path: <netdev+bounces-59926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AC481CB0D
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 15:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B981C2233E
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 14:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC2D1CFB7;
	Fri, 22 Dec 2023 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iMVmY8uh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3690C200BC
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtGfIsc0vDRtEmaZHKKVATacvEn/T2jKB504vNIJwlri22FqwvJ+GM3vSe6X8ttkWpC5t9rpWLVHmyKAgiEbhAzP7jOLo6WzAwsD7BVydaMAweNjM7Vffq1cBTY+gSe26/mBD+qP8R20MEhwpIrordB4X8WImwUdetmlRUa7Ip0tdIJToI8nwry4572NbcRZFG11ut/orrBgEo21UELyep+PHYLPh1/iAtW63Przqd1jcQUyCi+J/IpG0gcsCVGrS6pSrtFJVgB6m6xDUl0WfNe08n9bntVDwxOmkK9Wi6P142SLxi8DYztqUQXQuUjM0w82tczy/2XCA/HDHOwHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1piugxe9wcOxwRBzSTMx7EV1K7qKn1+nhdaCinw7v3k=;
 b=YHLeUqpji2fzdlFf3MoZQhvyJwMzyAIW2pS8CmVIPDz+q7tXVNSr7Q80QeEIlFbo7q/Xqy84HKCfIYj0Mx4i7NzVzhYRv/XVL41j5QuoiehTtC62X6YG3nutSlE/9YlIIn+FBGiSof2nITXl20DNDRKxy11y12C2PpcnPCyRMDWVnYRDYa2RmOfNqj66eoBoJYcaEzY+iDi1gU+xONL3331od///P8+qE9+l5p/8QtGpz81zwsZ9Txd163WhaHs9bYEl11Dtk4BOHeAFPuIkDr/sZIoqTCE9C9bZZKvQiAsnqc/SFaS7S3YiBHZw1oRo/4G/lG4tmatNFTnAA3MQng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1piugxe9wcOxwRBzSTMx7EV1K7qKn1+nhdaCinw7v3k=;
 b=iMVmY8uhBuAKDZdhj7zTxtb0DaOQuV7ZY/LEfVmAVu94aDBdzDJvDzWOYq6zhK4tz6CMx2AVaHdSBr1HM+A2h1gcGqPpcCQy3B+EZOfaI+SaTCXz65umYS/JQKntwUehoOvmY7NfjwyFi+m0iCqhAmHuzJMz3HO0v6vdM87b/uFrXfktPPam7v5q2mwj3eAmWQV5jx2zp2lAjAsnbY6veuBnZy3shYxrshfYfIEDC4z77oPnpLyGxLRKVL8fACSu/xXQJw0zXrBUulxi/13A/Y3Tu5Hs88TuS93iyGGwPifKE7E+Ulsa04Vzvu1UsOKfXIBVhFHYcyqBph8ynq8dEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 14:00:07 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 14:00:07 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [RFC PATCH net-next 05/10] selftests: Introduce Makefile variable to list shared bash scripts
Date: Fri, 22 Dec 2023 08:58:31 -0500
Message-ID: <20231222135836.992841-6-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222135836.992841-1-bpoirier@nvidia.com>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::12) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 56414ccb-7f42-4156-6f01-08dc02f64de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jIYEVdtArCcga++GIPjGSB11o4YbSd+JoRdFRpTOFa48A29rKz38lkJ/5Nk+fGCGj+lB35aPdQAA+gmwWI+HzK1i1/0X9AX51hsAFktzVFWWoHDrVxEYfkXhftD/TXlsbO+2w1b40Q9cTVScmhhxSAxgFgl46zrwI00Uz1BDRDG+YpyZ2lynZcvp1NH2vMQEG9RBH0Uwa0I71VVlQEf8G83Naybq0Z1kULoR2WP5d/G54OJfMOu9+djeILj3KrVpJg3I14JwKplODR9+2BSZFPcXqb9NJybvgcCPX3IVZal7OWaxZfAYUql9yAknnqTE/hKaqWUzAstTTbgn1+4FLreDYyPU/h8KYkC5cMZVVclqH2NiFvJTPq50tX/y/HC0qAp1/ICilc96F7W0blXxAywaZrxpOhjEhmcBRBhZhBYwIiekrHx4CbNHuvqTZQy5+/2JjKWMtneUUoAsnLGzzhwZwdA6acfn0ExdchJODZKI0Osu3PKWkOoCVH612YBnlnHRTKa9GozRWtatmzr2BjMBpxFXWicj6kIW0gKdPIbMgWlTf8bq4QxlSUsoCu3e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(478600001)(6486002)(38100700002)(4326008)(5660300002)(6916009)(54906003)(8676002)(316002)(66476007)(66556008)(66946007)(8936002)(1076003)(26005)(83380400001)(2616005)(6666004)(6506007)(6512007)(36756003)(41300700001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7+ssfkBi4+EyqDBuK5h4EpHK5HB3waJrrOQikoeU45KEOcL4+/ieWGLZAI2r?=
 =?us-ascii?Q?C6zs3MB2Tpuv7n2KAQaewTW/mskCKhD0x8jis/aVI6fKQjygPqrd3/E0hUCr?=
 =?us-ascii?Q?wqz6tgclXkDznRKhlKZTSnqxtSWfeUfloXHohXiBlLDw9DU04ZpJCtcOjA64?=
 =?us-ascii?Q?T48DQ3HJEikF6UJsygy+H/X5hkSYHw+PcFd6aYtJ4RdNDnND/ty0OeJZb9Nb?=
 =?us-ascii?Q?OTHBgzn0UUoj2T6ih2SLWb1hYlI6bwuNvPgt1TitQvuVJ93tG/bXLyWCz7iN?=
 =?us-ascii?Q?KJaTpbUenWFQ9m8VH2KCfLthB57otnLIHlRMZmv3KH+6Ao2N5OKqVZRa+MGe?=
 =?us-ascii?Q?aaWGy9XFnN0uqYTCE67P/7JmuXnnEN/l+VPqFFot70VL5MmiLdV7A9ZriL6q?=
 =?us-ascii?Q?Q/tGV6vgcXpTO0zMF9SFsdv5KjBNpdS+7kbYpdi3PoKaq+po5hDXIDGo0crt?=
 =?us-ascii?Q?8lw+KUct5u3lsW90aSucOC3cKB8e1u0Ll1PhA6Hs/WOChVib54lyWjo0XrOI?=
 =?us-ascii?Q?AnFJ4tbGg0SUS4E4vlulHmzXXiMbOCCnQEfRexiElldPsEbpQaDPjE1o6Qkt?=
 =?us-ascii?Q?1eKQseXg3Lb4+f2b3SzqiHi0v2Bla9h5ozj4Mv5On/Wp3vN3lI40IRU9MwNu?=
 =?us-ascii?Q?oR+tRFrun8evf5Ah/T2VJclugvhWvImZZCuku+SQ6vWRze8rGFLU2zo/J+ir?=
 =?us-ascii?Q?mj/okxfGl3oBn9B73CTayPNAwMuMhkjKn/4ziGem///vyPshiahOemmFfEw1?=
 =?us-ascii?Q?KGvmb4q/WQO0ApyarvtR2UNPUpjte8MyxnwxYl4cGYNS8WisVmk4hcQHHQEC?=
 =?us-ascii?Q?ZIqAteUyljUNCl2cZL41vOtkeBm3l8Gg3YK9ykV1r3bme8spfGkTrlTERClk?=
 =?us-ascii?Q?3ZmDn0L8ArjS+fLN/tm8rdFljW/FVyX65yehSLRT61IEeu5K0AJbqMyUm8c5?=
 =?us-ascii?Q?2CFaPCjkVIgtl5NHbH3Czayn/sf1rpmNvIgROVcmE4rg0m/gLpFhHg+Qt+FG?=
 =?us-ascii?Q?ctAwxXWMAC1EAapSjevsk2iMVkrVcYiq2cWhXFIoSfR6byoBX3OZexBXXTe4?=
 =?us-ascii?Q?BPLwTJDpl/4xaDUM25A4A6Smn37iPJyuYz0h9B/WgLlTv4v4SNilq9H0azAc?=
 =?us-ascii?Q?ge6REgPjnZXEzXj4pacq9bWv2oBRfsn2jY9hq7Zd6Pe0QADL+2QwglquQd1H?=
 =?us-ascii?Q?4XiuBoRVMQHlFSqBiDH9rOWTe+MDrhjisO8kYwOGPWFeMQcanVXLT6DHgLfP?=
 =?us-ascii?Q?079H087+KYPJ7ZAfBUb8skUOsc70WEzl65M+Xp8MbyswwEjqHwY/MzcMoj3s?=
 =?us-ascii?Q?F/PMR1cAkjw/FOxRxvGMdjoys7w56CT1ww8oHAkZ+Ax0+QEBxP2qxXjPMHwd?=
 =?us-ascii?Q?D6y/ifyglZFq8yaZrFyA5zAx+4iEzLXqBazJgFYVqdYnswMP8fDtj1MfDBrE?=
 =?us-ascii?Q?pqMZ9SADJVDAsMm7NwovhP0r9SzVzPpD7HFItE6oEJsjmsM2V0pgQsim3aIx?=
 =?us-ascii?Q?JVVfx7zt3cfars9p+IgHmYSnCVtBNtfB3c/fJbwl1N6aDpCOdz8aeXK1GA87?=
 =?us-ascii?Q?BBMhIIUHGbgpi9D1EjroSxf3r8kdAUUPoVUEFu2P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56414ccb-7f42-4156-6f01-08dc02f64de2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 14:00:07.3188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A38VMOcKbmXGFnmJT6SiJZREpRgcwFVskk3bttx20H7Uj6G+jV63HXArskguhIOXyCw9TuW/MRVkTFx7n8bAbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955

Some tests written in bash source other files in a parent directory. For
example, drivers/net/bonding/dev_addr_lists.sh sources
net/forwarding/lib.sh. If a subset of tests is exported and run outside the
source tree (for example by using `make -C tools/testing/selftests gen_tar
TARGETS="drivers/net/bonding"`), these other files must be made available
as well.

Commit ae108c48b5d2 ("selftests: net: Fix cross-tree inclusion of scripts")
addressed this problem by symlinking and copying the sourced files but this
only works for direct dependencies. Commit 25ae948b4478 ("selftests/net:
add lib.sh") changed net/forwarding/lib.sh to source net/lib.sh. As a
result, that latter file must be included as well when the former is
exported. This is not handled currently. Therefore, add a mechanism to list
dependent files in a new Makefile variable and export them. This allows
sourcing those files using the same expression whether tests are run
in-tree or exported.

Dependencies are not resolved recursively so transitive dependencies must
be listed in TEST_INCLUDES. For example, net/forwarding/lib.sh sources
net/lib.sh; so a script that sources net/forwarding/lib.sh from a parent
directory must list:
TEST_INCLUDES := \
	net/forwarding/lib.sh \
	net/lib.sh

Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 Documentation/dev-tools/kselftest.rst | 6 ++++++
 tools/testing/selftests/Makefile      | 7 ++++++-
 tools/testing/selftests/lib.mk        | 6 ++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index ab376b316c36..8b79843ca514 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -255,9 +255,15 @@ Contributing new tests (details)
 
    TEST_PROGS_EXTENDED, TEST_GEN_PROGS_EXTENDED mean it is the
    executable which is not tested by default.
+
    TEST_FILES, TEST_GEN_FILES mean it is the file which is used by
    test.
 
+   TEST_INCLUDES lists files which are not in the current directory or one of
+   its descendants but which should be included when exporting or installing
+   the tests. The files are listed with a path relative to
+   tools/testing/selftests/.
+
  * First use the headers inside the kernel source and/or git repo, and then the
    system headers.  Headers for the kernel release as opposed to headers
    installed by the distro on the system should be the primary focus to be able
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 81f094e7f0f7..3f494a31b479 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -188,6 +188,8 @@ run_tests: all
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests \
+				SRC_PATH=$(shell pwd)               \
+				OBJ_PATH=$(BUILD)                   \
 				O=$(abs_objtree);		    \
 	done;
 
@@ -238,7 +240,10 @@ ifdef INSTALL_PATH
 	@ret=1;	\
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install \
+		$(MAKE) install OUTPUT=$$BUILD_TARGET -C $$TARGET \
+				INSTALL_PATH=$(INSTALL_PATH)/$$TARGET \
+				SRC_PATH=$(shell pwd) \
+				OBJ_PATH=$(INSTALL_PATH) \
 				O=$(abs_objtree)		\
 				$(if $(FORCE_TARGETS),|| exit);	\
 		ret=$$((ret * $$?));		\
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index aa646e0661f3..2b6c2be4f356 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -74,6 +74,9 @@ ifdef building_out_of_srctree
 	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)" != "X" ]; then \
 		rsync -aq --copy-unsafe-links $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
 	fi
+	$(if $(TEST_INCLUDES), \
+		cd $(SRC_PATH) && rsync -aR $(TEST_INCLUDES) $(OBJ_PATH)/ \
+	)
 	@if [ "X$(TEST_PROGS)" != "X" ]; then \
 		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) \
 				  $(addprefix $(OUTPUT)/,$(TEST_PROGS))) ; \
@@ -103,6 +106,9 @@ endef
 install: all
 ifdef INSTALL_PATH
 	$(INSTALL_RULE)
+	$(if $(TEST_INCLUDES), \
+		cd $(SRC_PATH) && rsync -aR $(TEST_INCLUDES) $(OBJ_PATH)/ \
+	)
 else
 	$(error Error: set INSTALL_PATH to use install)
 endif
-- 
2.43.0


