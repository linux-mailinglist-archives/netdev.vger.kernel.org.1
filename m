Return-Path: <netdev+bounces-41118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D787C9D26
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 03:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 123B7B20CE7
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 01:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5494F442C;
	Mon, 16 Oct 2023 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2461840
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 01:50:51 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01C1C1;
	Sun, 15 Oct 2023 18:50:48 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S80Ng3v3jz67GCQ;
	Mon, 16 Oct 2023 09:47:31 +0800 (CST)
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 16 Oct 2023 02:50:45 +0100
From: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To: <mic@digikod.net>
CC: <willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
	<artem.kuzin@huawei.com>
Subject: [PATCH v13 04/12] landlock: Refactor merge/inherit_ruleset functions
Date: Mon, 16 Oct 2023 09:50:22 +0800
Message-ID: <20231016015030.1684504-5-konstantin.meskhidze@huawei.com>
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

Refactor merge_ruleset() and inherit_ruleset() functions to support
new rule types. This patch adds merge_tree() and inherit_tree()
helpers. They use a specific ruleset's red-black tree according to
a key type argument.

Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Link: https://lore.kernel.org/r/20230920092641.832134-5-konstantin.meskhidze@huawei.com
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v12:
* None

Changes since v11:
* Fixes comment in inherit_ruleset().
https://lore.kernel.org/netdev/3b52ba0c-d013-b7a9-0f08-2e6d677a1df0@digikod.net/

Changes since v10:
* Refactors merge_tree() function.

Changes since v9:
* None

Changes since v8:
* Refactors commit message.
* Minor fixes.

Changes since v7:
* Adds missed lockdep_assert_held it inherit_tree() and merge_tree().
* Fixes comment.

Changes since v6:
* Refactors merge_ruleset() and inherit_ruleset() functions to support
  new rule types.
* Renames tree_merge() to merge_tree() (and reorder arguments), and
  tree_copy() to inherit_tree().

Changes since v5:
* Refactors some logic errors.
* Formats code with clang-format-14.

Changes since v4:
* None

---
 security/landlock/ruleset.c | 116 +++++++++++++++++++++++-------------
 1 file changed, 74 insertions(+), 42 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index d5993e6254e4..958d57654b8e 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -299,36 +299,22 @@ static void put_hierarchy(struct landlock_hierarchy *hierarchy)
 	}
 }

-static int merge_ruleset(struct landlock_ruleset *const dst,
-			 struct landlock_ruleset *const src)
+static int merge_tree(struct landlock_ruleset *const dst,
+		      struct landlock_ruleset *const src,
+		      const enum landlock_key_type key_type)
 {
 	struct landlock_rule *walker_rule, *next_rule;
 	struct rb_root *src_root;
 	int err = 0;

 	might_sleep();
-	/* Should already be checked by landlock_merge_ruleset() */
-	if (WARN_ON_ONCE(!src))
-		return 0;
-	/* Only merge into a domain. */
-	if (WARN_ON_ONCE(!dst || !dst->hierarchy))
-		return -EINVAL;
+	lockdep_assert_held(&dst->lock);
+	lockdep_assert_held(&src->lock);

-	src_root = get_root(src, LANDLOCK_KEY_INODE);
+	src_root = get_root(src, key_type);
 	if (IS_ERR(src_root))
 		return PTR_ERR(src_root);

-	/* Locks @dst first because we are its only owner. */
-	mutex_lock(&dst->lock);
-	mutex_lock_nested(&src->lock, SINGLE_DEPTH_NESTING);
-
-	/* Stacks the new layer. */
-	if (WARN_ON_ONCE(src->num_layers != 1 || dst->num_layers < 1)) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
-	dst->access_masks[dst->num_layers - 1] = src->access_masks[0];
-
 	/* Merges the @src tree. */
 	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule, src_root,
 					     node) {
@@ -337,23 +323,52 @@ static int merge_ruleset(struct landlock_ruleset *const dst,
 		} };
 		const struct landlock_id id = {
 			.key = walker_rule->key,
-			.type = LANDLOCK_KEY_INODE,
+			.type = key_type,
 		};

-		if (WARN_ON_ONCE(walker_rule->num_layers != 1)) {
-			err = -EINVAL;
-			goto out_unlock;
-		}
-		if (WARN_ON_ONCE(walker_rule->layers[0].level != 0)) {
-			err = -EINVAL;
-			goto out_unlock;
-		}
+		if (WARN_ON_ONCE(walker_rule->num_layers != 1))
+			return -EINVAL;
+
+		if (WARN_ON_ONCE(walker_rule->layers[0].level != 0))
+			return -EINVAL;
+
 		layers[0].access = walker_rule->layers[0].access;

 		err = insert_rule(dst, id, &layers, ARRAY_SIZE(layers));
 		if (err)
-			goto out_unlock;
+			return err;
 	}
+	return err;
+}
+
+static int merge_ruleset(struct landlock_ruleset *const dst,
+			 struct landlock_ruleset *const src)
+{
+	int err = 0;
+
+	might_sleep();
+	/* Should already be checked by landlock_merge_ruleset() */
+	if (WARN_ON_ONCE(!src))
+		return 0;
+	/* Only merge into a domain. */
+	if (WARN_ON_ONCE(!dst || !dst->hierarchy))
+		return -EINVAL;
+
+	/* Locks @dst first because we are its only owner. */
+	mutex_lock(&dst->lock);
+	mutex_lock_nested(&src->lock, SINGLE_DEPTH_NESTING);
+
+	/* Stacks the new layer. */
+	if (WARN_ON_ONCE(src->num_layers != 1 || dst->num_layers < 1)) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
+	dst->access_masks[dst->num_layers - 1] = src->access_masks[0];
+
+	/* Merges the @src inode tree. */
+	err = merge_tree(dst, src, LANDLOCK_KEY_INODE);
+	if (err)
+		goto out_unlock;

 out_unlock:
 	mutex_unlock(&src->lock);
@@ -361,38 +376,55 @@ static int merge_ruleset(struct landlock_ruleset *const dst,
 	return err;
 }

-static int inherit_ruleset(struct landlock_ruleset *const parent,
-			   struct landlock_ruleset *const child)
+static int inherit_tree(struct landlock_ruleset *const parent,
+			struct landlock_ruleset *const child,
+			const enum landlock_key_type key_type)
 {
 	struct landlock_rule *walker_rule, *next_rule;
 	struct rb_root *parent_root;
 	int err = 0;

 	might_sleep();
-	if (!parent)
-		return 0;
+	lockdep_assert_held(&parent->lock);
+	lockdep_assert_held(&child->lock);

-	parent_root = get_root(parent, LANDLOCK_KEY_INODE);
+	parent_root = get_root(parent, key_type);
 	if (IS_ERR(parent_root))
 		return PTR_ERR(parent_root);

-	/* Locks @child first because we are its only owner. */
-	mutex_lock(&child->lock);
-	mutex_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
-
-	/* Copies the @parent tree. */
+	/* Copies the @parent inode or network tree. */
 	rbtree_postorder_for_each_entry_safe(walker_rule, next_rule,
 					     parent_root, node) {
 		const struct landlock_id id = {
 			.key = walker_rule->key,
-			.type = LANDLOCK_KEY_INODE,
+			.type = key_type,
 		};

 		err = insert_rule(child, id, &walker_rule->layers,
 				  walker_rule->num_layers);
 		if (err)
-			goto out_unlock;
+			return err;
 	}
+	return err;
+}
+
+static int inherit_ruleset(struct landlock_ruleset *const parent,
+			   struct landlock_ruleset *const child)
+{
+	int err = 0;
+
+	might_sleep();
+	if (!parent)
+		return 0;
+
+	/* Locks @child first because we are its only owner. */
+	mutex_lock(&child->lock);
+	mutex_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
+
+	/* Copies the @parent inode tree. */
+	err = inherit_tree(parent, child, LANDLOCK_KEY_INODE);
+	if (err)
+		goto out_unlock;

 	if (WARN_ON_ONCE(child->num_layers <= parent->num_layers)) {
 		err = -EINVAL;
--
2.25.1


