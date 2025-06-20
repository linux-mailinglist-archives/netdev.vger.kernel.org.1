Return-Path: <netdev+bounces-199737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E113AE19DF
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619D03A24EA
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 11:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC3625E479;
	Fri, 20 Jun 2025 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBl3KgI+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0A21401B;
	Fri, 20 Jun 2025 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750418351; cv=none; b=FfXa97Qho9tqbUE7c71Lk2NW585aCr6kex3+dulJyE5rMdQcgDU0vWQ72ct0tyzxtnsPARJ5IE8RqDZoJ7T1rDbP0KVDS7rACAtjmKVNGI76Zbrd/FzwK+5FAwPvyKKqMKKvH1ue3KJJDyN4m0RssfJUNc2dQAbmEmt6SCbvh7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750418351; c=relaxed/simple;
	bh=HCi3L5oYzZ4C1LKFJ08vKgxl9GTxpSyrU6Ns4txdrog=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DmYTapwL+3xdzfod4OdLm3ajyljOFD35WyAY26hBrPP62xV+gefGOy6GXxQYx2krYUQv1fDdpWpN4I0Y14DmYfimSUh7CxytS7dkZPGvVst+BvL+ve6Lte3HUkuxJDyIDrTBKyCp1eJU+3HoSoQxVBOFx9Iq0GKlXThlQeP3A1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBl3KgI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010F7C4CEE3;
	Fri, 20 Jun 2025 11:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750418351;
	bh=HCi3L5oYzZ4C1LKFJ08vKgxl9GTxpSyrU6Ns4txdrog=;
	h=From:To:Cc:Subject:Date:From;
	b=iBl3KgI+KjED+iAe372S5+ro0Tqhpe9CzrPWkruf3mM9YO3Q6wI42an95qUMrdnKA
	 dozCkNIaqWg5oVKMsH8oNMOyzXYcD+9OyGbTA5p9WFVmprUV3F/mqrn+zYM3P83dUn
	 tLL6Mpy/Nn7noz8zI5y8roVMJFGK5agM861A4sGuMYDdJXtnBgEdRqfWP18PFhN9j0
	 ejxCd+FjZ+E0of6UHQpTRmdDmvnQXBCrHjoIMaVl6T6kyGX8v9RBXx5Q9JsnCgt7Sh
	 B2Ejb4CgDAoa7SiJ5VjTjjhssYnuKmvE4nGyKs4xCVSIXevj1hdAdl3jfG3Cv32yLD
	 RMZGKtfaTCqMQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] lib: test_objagg: split test_hints_case() into two functions
Date: Fri, 20 Jun 2025 13:19:04 +0200
Message-Id: <20250620111907.3395296-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

With sanitizers enabled, this function uses a lot of stack, causing
a harmless warning:

lib/test_objagg.c: In function 'test_hints_case.constprop':
lib/test_objagg.c:994:1: error: the frame size of 1440 bytes is larger than 1408 bytes [-Werror=frame-larger-than=]

Most of this is from the two 'struct world' structures. Since most of
the work in this function is duplicated for the two, split it up into
separate functions that each use one of them.

The combined stack usage is still the same here, but there is no warning
any more, and the code is still safe because of the known call chain.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/test_objagg.c | 77 +++++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 32 deletions(-)

diff --git a/lib/test_objagg.c b/lib/test_objagg.c
index d34df4306b87..a67b8ef5c5be 100644
--- a/lib/test_objagg.c
+++ b/lib/test_objagg.c
@@ -906,50 +906,22 @@ static int check_expect_hints_stats(struct objagg_hints *objagg_hints,
 	return err;
 }
 
-static int test_hints_case(const struct hints_case *hints_case)
+static int test_hints_case2(const struct hints_case *hints_case,
+			    struct objagg_hints *hints, struct objagg *objagg)
 {
 	struct objagg_obj *objagg_obj;
-	struct objagg_hints *hints;
 	struct world world2 = {};
-	struct world world = {};
 	struct objagg *objagg2;
-	struct objagg *objagg;
 	const char *errmsg;
 	int i;
 	int err;
 
-	objagg = objagg_create(&delta_ops, NULL, &world);
-	if (IS_ERR(objagg))
-		return PTR_ERR(objagg);
-
-	for (i = 0; i < hints_case->key_ids_count; i++) {
-		objagg_obj = world_obj_get(&world, objagg,
-					   hints_case->key_ids[i]);
-		if (IS_ERR(objagg_obj)) {
-			err = PTR_ERR(objagg_obj);
-			goto err_world_obj_get;
-		}
-	}
-
-	pr_debug_stats(objagg);
-	err = check_expect_stats(objagg, &hints_case->expect_stats, &errmsg);
-	if (err) {
-		pr_err("Stats: %s\n", errmsg);
-		goto err_check_expect_stats;
-	}
-
-	hints = objagg_hints_get(objagg, OBJAGG_OPT_ALGO_SIMPLE_GREEDY);
-	if (IS_ERR(hints)) {
-		err = PTR_ERR(hints);
-		goto err_hints_get;
-	}
-
 	pr_debug_hints_stats(hints);
 	err = check_expect_hints_stats(hints, &hints_case->expect_stats_hints,
 				       &errmsg);
 	if (err) {
 		pr_err("Hints stats: %s\n", errmsg);
-		goto err_check_expect_hints_stats;
+		return err;
 	}
 
 	objagg2 = objagg_create(&delta_ops, hints, &world2);
@@ -981,7 +953,48 @@ static int test_hints_case(const struct hints_case *hints_case)
 		world_obj_put(&world2, objagg, hints_case->key_ids[i]);
 	i = hints_case->key_ids_count;
 	objagg_destroy(objagg2);
-err_check_expect_hints_stats:
+
+	return err;
+}
+
+static int test_hints_case(const struct hints_case *hints_case)
+{
+	struct objagg_obj *objagg_obj;
+	struct objagg_hints *hints;
+	struct world world = {};
+	struct objagg *objagg;
+	const char *errmsg;
+	int i;
+	int err;
+
+	objagg = objagg_create(&delta_ops, NULL, &world);
+	if (IS_ERR(objagg))
+		return PTR_ERR(objagg);
+
+	for (i = 0; i < hints_case->key_ids_count; i++) {
+		objagg_obj = world_obj_get(&world, objagg,
+					   hints_case->key_ids[i]);
+		if (IS_ERR(objagg_obj)) {
+			err = PTR_ERR(objagg_obj);
+			goto err_world_obj_get;
+		}
+	}
+
+	pr_debug_stats(objagg);
+	err = check_expect_stats(objagg, &hints_case->expect_stats, &errmsg);
+	if (err) {
+		pr_err("Stats: %s\n", errmsg);
+		goto err_check_expect_stats;
+	}
+
+	hints = objagg_hints_get(objagg, OBJAGG_OPT_ALGO_SIMPLE_GREEDY);
+	if (IS_ERR(hints)) {
+		err = PTR_ERR(hints);
+		goto err_hints_get;
+	}
+
+	err = test_hints_case2(hints_case, hints, objagg);
+
 	objagg_hints_put(hints);
 err_hints_get:
 err_check_expect_stats:
-- 
2.39.5


