Return-Path: <netdev+bounces-44364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12007D7A66
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 03:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B3A1C20EC4
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D452749F;
	Thu, 26 Oct 2023 01:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FAA5CB9
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:48:18 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2B112F;
	Wed, 25 Oct 2023 18:48:16 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SG7sh0znnz6K6CJ;
	Thu, 26 Oct 2023 09:45:28 +0800 (CST)
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 26 Oct 2023 02:48:13 +0100
From: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To: <mic@digikod.net>
CC: <willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
	<artem.kuzin@huawei.com>
Subject: [PATCH v14 07/12] landlock: Refactor landlock_add_rule() syscall
Date: Thu, 26 Oct 2023 09:47:46 +0800
Message-ID: <20231026014751.414649-8-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026014751.414649-1-konstantin.meskhidze@huawei.com>
References: <20231026014751.414649-1-konstantin.meskhidze@huawei.com>
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

Change the landlock_add_rule() syscall to support new rule types
with next commits. Add the add_rule_path_beneath() helper
to support current filesystem rules.

Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v13:
* Refactors commit message.

Changes since v12:
* None.

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
 security/landlock/syscalls.c | 89 ++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 44 deletions(-)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index d35cd5d304db..e87f572e0251 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -274,6 +274,44 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
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
+	/* Checks that allowed_access matches the @ruleset constraints. */
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
@@ -306,11 +344,8 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
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
@@ -324,48 +359,14 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);

-	if (rule_type != LANDLOCK_RULE_PATH_BENEATH) {
-		err = -EINVAL;
-		goto out_put_ruleset;
-	}
-
-	/* Copies raw user space buffer, only one type for now. */
-	res = copy_from_user(&path_beneath_attr, rule_attr,
-			     sizeof(path_beneath_attr));
-	if (res) {
-		err = -EFAULT;
-		goto out_put_ruleset;
-	}
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
+	switch (rule_type) {
+	case LANDLOCK_RULE_PATH_BENEATH:
+		err = add_rule_path_beneath(ruleset, rule_attr);
+		break;
+	default:
 		err = -EINVAL;
-		goto out_put_ruleset;
+		break;
 	}
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


