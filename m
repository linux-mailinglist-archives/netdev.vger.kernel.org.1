Return-Path: <netdev+bounces-41122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DEC7C9D2F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 03:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF852816DF
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 01:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046E21FCE;
	Mon, 16 Oct 2023 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09141842
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 01:50:58 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE1210B;
	Sun, 15 Oct 2023 18:50:57 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S80Ns06t4z67GCQ;
	Mon, 16 Oct 2023 09:47:40 +0800 (CST)
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 16 Oct 2023 02:50:55 +0100
From: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To: <mic@digikod.net>
CC: <willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
	<artem.kuzin@huawei.com>
Subject: [PATCH v13 09/12] selftests/landlock: Share enforce_ruleset()
Date: Mon, 16 Oct 2023 09:50:27 +0800
Message-ID: <20231016015030.1684504-10-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016015030.1684504-1-konstantin.meskhidze@huawei.com>
References: <20231016015030.1684504-1-konstantin.meskhidze@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.66.134]
X-ClientProxiedBy: mscpeml500002.china.huawei.com (7.188.26.138) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This commit moves enforce_ruleset() helper function to common.h so that
it can be used both by filesystem tests and network ones.

Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Link: https://lore.kernel.org/r/20230920092641.832134-10-konstantin.meskhidze@huawei.com
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v12:
* Fixes a bug TEST_F_FORK(layout1) -> TEST_F_FORK(layout0) in fs_test.c.

Changes since v11:
* None.

Changes since v10:
* Refactors commit message.

Changes since v9:
* None.

Changes since v8:
* Adds __maybe_unused attribute for enforce_ruleset() helper.

Changes since v7:
* Refactors commit message.

Changes since v6:
* None.

Changes since v5:
* Splits commit.
* Moves enforce_ruleset helper into common.h
* Formats code with clang-format-14.

---
 tools/testing/selftests/landlock/common.h  | 10 ++++++++++
 tools/testing/selftests/landlock/fs_test.c | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index d7987ae8d7fc..0fd6c4cf5e6f 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -256,3 +256,13 @@ static int __maybe_unused send_fd(int usock, int fd_tx)
 		return -errno;
 	return 0;
 }
+
+static void __maybe_unused
+enforce_ruleset(struct __test_metadata *const _metadata, const int ruleset_fd)
+{
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0))
+	{
+		TH_LOG("Failed to enforce ruleset: %s", strerror(errno));
+	}
+}
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 251594306d40..68b7a89cf65b 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -677,16 +677,6 @@ static int create_ruleset(struct __test_metadata *const _metadata,
 	return ruleset_fd;
 }

-static void enforce_ruleset(struct __test_metadata *const _metadata,
-			    const int ruleset_fd)
-{
-	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
-	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0))
-	{
-		TH_LOG("Failed to enforce ruleset: %s", strerror(errno));
-	}
-}
-
 TEST_F_FORK(layout0, proc_nsfs)
 {
 	const struct rule rules[] = {
--
2.25.1


