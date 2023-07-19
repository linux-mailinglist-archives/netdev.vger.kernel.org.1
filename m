Return-Path: <netdev+bounces-19179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435F3759E24
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2861281A28
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1502515C;
	Wed, 19 Jul 2023 19:00:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE49E25140
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:06 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855551FC8
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:04 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id 1A9DED9008;
	Wed, 19 Jul 2023 20:52:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792738; bh=h+NqQAn3cG7OXy/7rxTDlVqhCyHatGRlhFodOgdXFLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EqjkfzTrrZ+vJj71PTeIElNF4tBNIIm+0psntJo5CpAD1PVT+QEaBnOpxrogINBmD
	 FMvVTzsmuwSbFQSIe3ateZpKRG161VQi1iNzhFg8JP3IZ37flLV3nogsd5aW6tHN/9
	 ZUcEIJCZUUssgBaqZIT6lNp+Mo2VgQPrqR8eLIntkLQFAnh+qrKjMSoU0ryYhKE5PP
	 gs3maQQ+/FKibqof1DWFFPxRa2nsQLDRYm3YYRf/Zi4s19spBHMhYcwqdtk2fSLsD8
	 TyCFJOG4KpIfluw6OWyHWxzqRhz2qQvqVqrieeCumKFVwnunLWbySolscdaGbD0O2S
	 dPQ9hyHGFJITQ==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 08/22] lib/rt_names: rtnl_hash_initialize: Relay returned value
Date: Wed, 19 Jul 2023 20:50:52 +0200
Message-Id: <20230719185106.17614-9-gioele@svario.it>
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
 lib/rt_names.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/rt_names.c b/lib/rt_names.c
index 0407b361..27aca3ec 100644
--- a/lib/rt_names.c
+++ b/lib/rt_names.c
@@ -14,6 +14,7 @@
 #include <sys/socket.h>
 #include <dirent.h>
 #include <limits.h>
+#include <errno.h>
 
 #include <asm/types.h>
 #include <linux/rtnetlink.h>
@@ -56,7 +57,7 @@ static int fread_id_name(FILE *fp, int *id, char *namebuf)
 	return 0;
 }
 
-static void
+static int
 rtnl_hash_initialize(const char *file, struct rtnl_hash_entry **hash, int size)
 {
 	struct rtnl_hash_entry *entry;
@@ -67,14 +68,14 @@ rtnl_hash_initialize(const char *file, struct rtnl_hash_entry **hash, int size)
 
 	fp = fopen(file, "r");
 	if (!fp)
-		return;
+		return -errno;
 
 	while ((ret = fread_id_name(fp, &id, &namebuf[0]))) {
 		if (ret == -1) {
 			fprintf(stderr, "Database %s is corrupted at %s\n",
 					file, namebuf);
 			fclose(fp);
-			return;
+			return -1;
 		}
 
 		if (id < 0)
@@ -91,6 +92,8 @@ rtnl_hash_initialize(const char *file, struct rtnl_hash_entry **hash, int size)
 		hash[id & (size - 1)] = entry;
 	}
 	fclose(fp);
+
+	return 0;
 }
 
 static void rtnl_tab_initialize(const char *file, char **tab, int size)
-- 
2.39.2


