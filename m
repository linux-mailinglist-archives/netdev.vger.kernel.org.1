Return-Path: <netdev+bounces-19176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE20759E1B
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2C91C20FAF
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D51722F09;
	Wed, 19 Jul 2023 19:00:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7314722EF9
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:05 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EBB1734
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:03 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id 89DBED901A;
	Wed, 19 Jul 2023 20:52:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792740; bh=jFAkA5hdXRLAqmxm1BvtErvT9MQakkFnYPS3uvUvgj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m4G9YN5vHpYbni3zUrY5ayK4iZ1/2hFEQWGxwT+K0HwxYRGZ0vaj1sP5iHCRKF9tu
	 zvplo3GqjjGC4BCz6uCi2s0ScxT2/EeHNbdrudB8vRpFlibg5xO8X9hTxJivcFKsRa
	 qTjWjleDiaOszIbIIURZEzfYnLmGW3KCIPFfUWdtKrNObDxZipTl33LsnAfoqibhZc
	 i2/ynhUfLJHcoZdCVS6qqtTuEexTrHUfpQqgvDGn22C0lz9RoMk4SijN1dLAI19dCx
	 EXMY8LAfTq/OrZJ/zQ+bpNufFPNEIHnGQxb1wt2FxNJka+NRSQXuXf0bXDMwDKfU6E
	 j1tUEwmhSsT6Q==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 17/22] lib/rt_names: Read rt_protos.d/* from /etc and /usr
Date: Wed, 19 Jul 2023 20:51:01 +0200
Message-Id: <20230719185106.17614-18-gioele@svario.it>
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
 lib/rt_names.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/lib/rt_names.c b/lib/rt_names.c
index 4f38fcbe..d9c48813 100644
--- a/lib/rt_names.c
+++ b/lib/rt_names.c
@@ -12,6 +12,7 @@
 #include <string.h>
 #include <sys/time.h>
 #include <sys/socket.h>
+#include <sys/stat.h>
 #include <dirent.h>
 #include <limits.h>
 #include <errno.h>
@@ -165,13 +166,12 @@ static void rtnl_rtprot_initialize(void)
 		rtnl_tab_initialize(CONF_USR_DIR "/rt_protos",
 		                    rtnl_rtprot_tab, 256);
 
-	d = opendir(CONF_ETC_DIR "/rt_protos.d");
-	if (!d)
-		return;
-
-	while ((de = readdir(d)) != NULL) {
+	/* load /usr/lib/iproute2/foo.d/X, unless /etc/iproute2/foo.d/X exists */
+	d = opendir(CONF_USR_DIR "/rt_protos.d");
+	while (d && (de = readdir(d)) != NULL) {
 		char path[PATH_MAX];
 		size_t len;
+		struct stat sb;
 
 		if (*de->d_name == '.')
 			continue;
@@ -183,11 +183,43 @@ static void rtnl_rtprot_initialize(void)
 		if (strcmp(de->d_name + len - 5, ".conf"))
 			continue;
 
+		/* only consider filenames not present in /etc */
+		snprintf(path, sizeof(path), CONF_USR_DIR "/rt_protos.d/%s",
+		         de->d_name);
+		if (lstat(path, &sb) == 0)
+			continue;
+
+		/* load the conf file in /usr */
 		snprintf(path, sizeof(path), CONF_ETC_DIR "/rt_protos.d/%s",
 			 de->d_name);
 		rtnl_tab_initialize(path, rtnl_rtprot_tab, 256);
 	}
-	closedir(d);
+	if (d)
+		closedir(d);
+
+	/* load /etc/iproute2/foo.d/X */
+	d = opendir(CONF_ETC_DIR "/rt_protos.d");
+	while (d && (de = readdir(d)) != NULL) {
+		char path[PATH_MAX];
+		size_t len;
+
+		if (*de->d_name == '.')
+			continue;
+
+		/* only consider filenames ending in '.conf' */
+		len = strlen(de->d_name);
+		if (len <= 5)
+			continue;
+		if (strcmp(de->d_name + len - 5, ".conf"))
+			continue;
+
+		/* load the conf file in /etc */
+		snprintf(path, sizeof(path), CONF_USR_DIR "/rt_protos.d/%s",
+			 de->d_name);
+		rtnl_tab_initialize(path, rtnl_rtprot_tab, 256);
+	}
+	if (d)
+		closedir(d);
 }
 
 const char *rtnl_rtprot_n2a(int id, char *buf, int len)
-- 
2.39.2


