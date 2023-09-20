Return-Path: <netdev+bounces-35181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6DD7A777B
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 11:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179EE28216D
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 09:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00365156F1;
	Wed, 20 Sep 2023 09:27:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EE6156D8
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 09:27:05 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D09129;
	Wed, 20 Sep 2023 02:27:02 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RrCjH5gYCz6D983;
	Wed, 20 Sep 2023 17:22:11 +0800 (CST)
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 20 Sep 2023 10:27:00 +0100
From: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To: <mic@digikod.net>
CC: <willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
	<artem.kuzin@huawei.com>
Subject: [PATCH v12 07/12] landlock: Refactor landlock_add_rule() syscall
Date: Wed, 20 Sep 2023 17:26:35 +0800
Message-ID: <20230920092641.832134-8-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230920092641.832134-1-konstantin.meskhidze@huawei.com>
References: <20230920092641.832134-1-konstantin.meskhidze@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.123.66.134]
X-ClientProxiedBy: mscpeml500002.china.huawei.com (7.188.26.138) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Change the landlock_add_rule() syscall to support new rule types
in future Landlock versions. Add the add_rule_path_beneath() helper
to support current filesystem rules.

Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
---

Changes since v11:
* None.

Changes since v10:
* None.

Changes since v9:
* Minor fixes:
	- deletes unnecessary curly braces.
	- deletes unnecessary empty line.

Changes since v8:
* Refactors commit message.
* Minor fixes.

Changes since v7:
* None

Changes since v6:
* None

Changes since v5:
* Refactors syscall landlock_add_rule() and add_rule_path_beneath() helper
to make argument check ordering consistent and get rid of partial revertings
in following patches.
* Rolls back refactoring base_test.c seltest.
* Formats code with clang-format-14.

Changes since v4:
* Refactors add_rule_path_beneath() and landlock_add_rule() functions
to optimize code usage.
* Refactors base_test.c seltest: adds LANDLOCK_RULE_PATH_BENEATH
rule type in landlock_add_rule() call.

Changes since v3:
* Split commit.
* Refactors landlock_add_rule syscall.

---
 security/landlock/syscalls.c | 92 +++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 44 deletions(-)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index d35cd5d304db..8a54e87dbb17 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -274,6 +274,47 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
 	return err;
 }

+static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
+				 const void __user *const rule_attr)
+{
+	struct landlock_path_beneath_attr path_beneath_attr;
+	struct path path;
+	int res, err;
+	access_mask_t mask;
+
+	/* Copies raw user space buffer, only one type for now. */
+	res = copy_from_user(&path_beneath_attr, rule_attr,
+			     sizeof(path_beneath_attr));
+	if (res)
+		return -EFAULT;
+
+	/*
+	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
+	 * are ignored in path walks.
+	 */
+	if (!path_beneath_attr.allowed_access)
+		return -ENOMSG;
+
+	/*
+	 * Checks that allowed_access matches the @ruleset constraints
+	 * (ruleset->access_masks[0] is automatically upgraded to 64-bits).
+	 */
+	mask = landlock_get_raw_fs_access_mask(ruleset, 0);
+	if ((path_beneath_attr.allowed_access | mask) != mask)
+		return -EINVAL;
+
+	/* Gets and checks the new rule. */
+	err = get_path_from_fd(path_beneath_attr.parent_fd, &path);
+	if (err)
+		return err;
+
+	/* Imports the new rule. */
+	err = landlock_append_fs_rule(ruleset, &path,
+				      path_beneath_attr.allowed_access);
+	path_put(&path);
+	return err;
+}
+
 /**
  * sys_landlock_add_rule - Add a new rule to a ruleset
  *
@@ -306,11 +347,8 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 		const enum landlock_rule_type, rule_type,
 		const void __user *const, rule_attr, const __u32, flags)
 {
-	struct landlock_path_beneath_attr path_beneath_attr;
-	struct path path;
 	struct landlock_ruleset *ruleset;
-	int res, err;
-	access_mask_t mask;
+	int err;

 	if (!landlock_initialized)
 		return -EOPNOTSUPP;
@@ -324,48 +362,14 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);

-	if (rule_type != LANDLOCK_RULE_PATH_BENEATH) {
+	switch (rule_type) {
+	case LANDLOCK_RULE_PATH_BENEATH:
+		err = add_rule_path_beneath(ruleset, rule_attr);
+		break;
+	default:
 		err = -EINVAL;
-		goto out_put_ruleset;
-	}
-
-	/* Copies raw user space buffer, only one type for now. */
-	res = copy_from_user(&path_beneath_attr, rule_attr,
-			     sizeof(path_beneath_attr));
-	if (res) {
-		err = -EFAULT;
-		goto out_put_ruleset;
+		break;
 	}
-
-	/*
-	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
-	 * are ignored in path walks.
-	 */
-	if (!path_beneath_attr.allowed_access) {
-		err = -ENOMSG;
-		goto out_put_ruleset;
-	}
-	/*
-	 * Checks that allowed_access matches the @ruleset constraints
-	 * (ruleset->access_masks[0] is automatically upgraded to 64-bits).
-	 */
-	mask = landlock_get_raw_fs_access_mask(ruleset, 0);
-	if ((path_beneath_attr.allowed_access | mask) != mask) {
-		err = -EINVAL;
-		goto out_put_ruleset;
-	}
-
-	/* Gets and checks the new rule. */
-	err = get_path_from_fd(path_beneath_attr.parent_fd, &path);
-	if (err)
-		goto out_put_ruleset;
-
-	/* Imports the new rule. */
-	err = landlock_append_fs_rule(ruleset, &path,
-				      path_beneath_attr.allowed_access);
-	path_put(&path);
-
-out_put_ruleset:
 	landlock_put_ruleset(ruleset);
 	return err;
 }
--
2.25.1


