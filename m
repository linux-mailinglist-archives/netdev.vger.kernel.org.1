Return-Path: <netdev+bounces-19171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E19759E13
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE29281B79
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F211BB43;
	Wed, 19 Jul 2023 19:00:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB591BB4C
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:03 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [IPv6:2a02:2770:13::112:0:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08870199A
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:02 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id 6DABDD900A;
	Wed, 19 Jul 2023 20:52:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792738; bh=5zmj3yGJ1jlr9vWtjGZXSea2E2fNG4zSD5Rm8wAJ9Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zHDaa033+t8eat7P5uYcTNA0InObKBEesIb/6I6eI+2wTjr/JUXWIa8LnRVfW1idu
	 w9XZPlo/97uSjRpZND9DqH7/kUsGmozTTzOasi8B78PxnGxLfXEn0oJTH3H7n04OjX
	 J49ejjrBCOjYBqKm3/nubFPwRM7wyDwRQg5mJd1AQAH+RGDxKnQhSK4MKDl+v/xuuq
	 1kCU3BWtPOO6H6DaOhWzCgMjPv2zSRUcl/XdmEGlm+FQsEdVeyJE2ARLjX1CUfc6eg
	 mqudBPyMsxvGsxYSY4nRqYtAgpWXuFHnzh4IC3rjrPsmzXe4AjMGxRS1x01UpLKaGS
	 y2Y6gtSdhSbDw==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 09/22] lib/rt_names: rtnl_tab_initialize: Relay returned value
Date: Wed, 19 Jul 2023 20:50:53 +0200
Message-Id: <20230719185106.17614-10-gioele@svario.it>
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
 lib/rt_names.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/rt_names.c b/lib/rt_names.c
index 27aca3ec..f64602b5 100644
--- a/lib/rt_names.c
+++ b/lib/rt_names.c
@@ -96,7 +96,7 @@ rtnl_hash_initialize(const char *file, struct rtnl_hash_entry **hash, int size)
 	return 0;
 }
 
-static void rtnl_tab_initialize(const char *file, char **tab, int size)
+static int rtnl_tab_initialize(const char *file, char **tab, int size)
 {
 	FILE *fp;
 	int id;
@@ -105,14 +105,14 @@ static void rtnl_tab_initialize(const char *file, char **tab, int size)
 
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
 		if (id < 0 || id > size)
 			continue;
@@ -120,6 +120,8 @@ static void rtnl_tab_initialize(const char *file, char **tab, int size)
 		tab[id] = strdup(namebuf);
 	}
 	fclose(fp);
+
+	return 0;
 }
 
 static char *rtnl_rtprot_tab[256] = {
-- 
2.39.2


