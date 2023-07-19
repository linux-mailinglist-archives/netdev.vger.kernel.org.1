Return-Path: <netdev+bounces-19189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39E6759E34
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3019C1C2119A
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEF026B67;
	Wed, 19 Jul 2023 19:00:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3058F26B77
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:08 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894F2171E
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:06 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id 49078D9021;
	Wed, 19 Jul 2023 20:52:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792741; bh=dldb3Ai/bPoVaXpX6IQyy8kQL4q95D54mVYFBGhUToc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3BNC50RpEW7qpdt1V5NKt9ZhAfXKsw9h2wReXStKvWnD3u7erXNh87S6uXv/hcrd
	 jNjO//lf6g7WboXoOs212xwTqiBr7cVSTQH4GME6a9A4alYSyLX2wVOdeog22pRKgo
	 7Qsl45uRUEtrdnzYdrviH0dzjmQj/fxCg0gRupqSyzKlStliNXPK+/6BsWhd3MvXxh
	 tqD3cdTpN6+/qy+R1m8DzpgR+tFWbqQzCbKKGncjNU8YAu3lFr55Ru9ClVQeqU/CvK
	 EVZZVZZtvcY6h7sPysCczYg/xuVQDBHvAgxn2QVKf1Ch2P0jTBAPNbb0Lzh5R5fC30
	 t3/sNOnAoZSRA==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 20/22] lib/rt_names: Read rt_tables.d/* using rtnl_hash_initialize_dir
Date: Wed, 19 Jul 2023 20:51:04 +0200
Message-Id: <20230719185106.17614-21-gioele@svario.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230719185106.17614-1-gioele@svario.it>
References: <20230719185106.17614-1-gioele@svario.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Gioele Barabucci <gioele@svario.it>
---
 lib/rt_names.c | 50 ++++++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/lib/rt_names.c b/lib/rt_names.c
index 090fc883..eca8b4fa 100644
--- a/lib/rt_names.c
+++ b/lib/rt_names.c
@@ -152,7 +152,8 @@ static char *rtnl_rtprot_tab[256] = {
 
 
 static void
-rtnl_tab_initialize_dir(const char *ddir, char **tab, const int size)
+rtnl_tabhash_initialize_dir(const char *ddir, void *tabhash, const int size,
+                            const bool is_tab)
 {
 	char dirpath_usr[PATH_MAX], dirpath_etc[PATH_MAX];
 	struct dirent *de;
@@ -185,7 +186,10 @@ rtnl_tab_initialize_dir(const char *ddir, char **tab, const int size)
 
 		/* load the conf file in /usr */
 		snprintf(path, sizeof(path), "%s/%s", dirpath_usr, de->d_name);
-		rtnl_tab_initialize(path, tab, size);
+		if (is_tab)
+			rtnl_tab_initialize(path, (char**)tabhash, size);
+		else
+			rtnl_hash_initialize(path, (struct rtnl_hash_entry**)tabhash, size);
 	}
 	if (d)
 		closedir(d);
@@ -208,12 +212,26 @@ rtnl_tab_initialize_dir(const char *ddir, char **tab, const int size)
 
 		/* load the conf file in /etc */
 		snprintf(path, sizeof(path), "%s/%s", dirpath_etc, de->d_name);
-		rtnl_tab_initialize(path, tab, size);
+		if (is_tab)
+			rtnl_tab_initialize(path, (char**)tabhash, size);
+		else
+			rtnl_hash_initialize(path, (struct rtnl_hash_entry**)tabhash, size);
 	}
 	if (d)
 		closedir(d);
 }
 
+static void
+rtnl_tab_initialize_dir(const char *ddir, char **tab, const int size) {
+	rtnl_tabhash_initialize_dir(ddir, (void*)tab, size, true);
+}
+
+static void
+rtnl_hash_initialize_dir(const char *ddir, struct rtnl_hash_entry **tab,
+                         const int size) {
+	rtnl_tabhash_initialize_dir(ddir, (void*)tab, size, false);
+}
+
 static int rtnl_rtprot_init;
 
 static void rtnl_rtprot_initialize(void)
@@ -489,8 +507,6 @@ static int rtnl_rttable_init;
 
 static void rtnl_rttable_initialize(void)
 {
-	struct dirent *de;
-	DIR *d;
 	int i;
 	int ret;
 
@@ -505,29 +521,7 @@ static void rtnl_rttable_initialize(void)
 		rtnl_hash_initialize(CONF_USR_DIR "/rt_tables",
 		                     rtnl_rttable_hash, 256);
 
-	d = opendir(CONF_ETC_DIR "/rt_tables.d");
-	if (!d)
-		return;
-
-	while ((de = readdir(d)) != NULL) {
-		char path[PATH_MAX];
-		size_t len;
-
-		if (*de->d_name == '.')
-			continue;
-
-		/* only consider filenames ending in '.conf' */
-		len = strlen(de->d_name);
-		if (len <= 5)
-			continue;
-		if (strcmp(de->d_name + len - 5, ".conf"))
-			continue;
-
-		snprintf(path, sizeof(path),
-			 CONF_ETC_DIR "/rt_tables.d/%s", de->d_name);
-		rtnl_hash_initialize(path, rtnl_rttable_hash, 256);
-	}
-	closedir(d);
+	rtnl_hash_initialize_dir("rt_tables.d", rtnl_rttable_hash, 256);
 }
 
 const char *rtnl_rttable_n2a(__u32 id, char *buf, int len)
-- 
2.39.2


