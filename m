Return-Path: <netdev+bounces-19170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EB6759E12
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2005A1C21120
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B4A1BB51;
	Wed, 19 Jul 2023 19:00:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A471BB4C
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:03 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08C01FC8
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id C522AD901C;
	Wed, 19 Jul 2023 20:52:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792740; bh=nS+pjeGJ53pDPrPp5LK42aEv/gFPemMfVAd37gGukKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K5znCII804CyGBK+eyZ92nI7DLbKZ05xtbXKObgP9ipYNXQAZ09ONVGr858S+N3C2
	 sXweEG9n8aW5OpwTw1Gj21zzF+FdZ5dpFr7lWIt+l36qmvwkvgyR21bQJYZoy3lU77
	 2wTMsY4YNozWU0OwgOmUus2thf+1FRXercpekfvGXCINh2zzNLSpuJ69Y2aemLgECT
	 SkOugN9cim7Ye61CudtCTQLzn6Sb6W3GLF1rBUHM0pxPgO4WnTkYANBC1pFZLLHhg/
	 Rpt2Pub0X5AJyDnlcW7L/E9cExSt7ReB8jWqY6ChPZS48AJsH2qyM93vgxscjBjjSo
	 iulMh1jDXD+Lg==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 18/22] lib/rt_names: Read rt_protos.d/* using rtnl_tab_initialize_dir
Date: Wed, 19 Jul 2023 20:51:02 +0200
Message-Id: <20230719185106.17614-19-gioele@svario.it>
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
 lib/rt_names.c | 52 +++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/lib/rt_names.c b/lib/rt_names.c
index d9c48813..3b69d05d 100644
--- a/lib/rt_names.c
+++ b/lib/rt_names.c
@@ -151,23 +151,18 @@ static char *rtnl_rtprot_tab[256] = {
 };
 
 
-static int rtnl_rtprot_init;
-
-static void rtnl_rtprot_initialize(void)
+static void
+rtnl_tab_initialize_dir(const char *ddir, char **tab, const int size)
 {
+	char dirpath_usr[PATH_MAX], dirpath_etc[PATH_MAX];
 	struct dirent *de;
 	DIR *d;
-	int ret;
 
-	rtnl_rtprot_init = 1;
-	ret = rtnl_tab_initialize(CONF_ETC_DIR "/rt_protos",
-	                          rtnl_rtprot_tab, 256);
-	if (ret == -ENOENT)
-		rtnl_tab_initialize(CONF_USR_DIR "/rt_protos",
-		                    rtnl_rtprot_tab, 256);
+	snprintf(dirpath_usr, sizeof(dirpath_usr), "%s/%s", CONF_USR_DIR, ddir);
+	snprintf(dirpath_etc, sizeof(dirpath_etc), "%s/%s", CONF_ETC_DIR, ddir);
 
-	/* load /usr/lib/iproute2/foo.d/X, unless /etc/iproute2/foo.d/X exists */
-	d = opendir(CONF_USR_DIR "/rt_protos.d");
+	/* load /usr/lib/iproute2/foo.d/X conf files, unless /etc/iproute2/foo.d/X exists */
+	d = opendir(dirpath_usr);
 	while (d && (de = readdir(d)) != NULL) {
 		char path[PATH_MAX];
 		size_t len;
@@ -184,21 +179,19 @@ static void rtnl_rtprot_initialize(void)
 			continue;
 
 		/* only consider filenames not present in /etc */
-		snprintf(path, sizeof(path), CONF_USR_DIR "/rt_protos.d/%s",
-		         de->d_name);
+		snprintf(path, sizeof(path), "%s/%s", dirpath_etc, de->d_name);
 		if (lstat(path, &sb) == 0)
 			continue;
 
 		/* load the conf file in /usr */
-		snprintf(path, sizeof(path), CONF_ETC_DIR "/rt_protos.d/%s",
-			 de->d_name);
-		rtnl_tab_initialize(path, rtnl_rtprot_tab, 256);
+		snprintf(path, sizeof(path), "%s/%s", dirpath_usr, de->d_name);
+		rtnl_tab_initialize(path, tab, size);
 	}
 	if (d)
 		closedir(d);
 
-	/* load /etc/iproute2/foo.d/X */
-	d = opendir(CONF_ETC_DIR "/rt_protos.d");
+	/* load /etc/iproute2/foo.d/X conf files */
+	d = opendir(dirpath_etc);
 	while (d && (de = readdir(d)) != NULL) {
 		char path[PATH_MAX];
 		size_t len;
@@ -214,14 +207,29 @@ static void rtnl_rtprot_initialize(void)
 			continue;
 
 		/* load the conf file in /etc */
-		snprintf(path, sizeof(path), CONF_USR_DIR "/rt_protos.d/%s",
-			 de->d_name);
-		rtnl_tab_initialize(path, rtnl_rtprot_tab, 256);
+		snprintf(path, sizeof(path), "%s/%s", dirpath_etc, de->d_name);
+		rtnl_tab_initialize(path, tab, size);
 	}
 	if (d)
 		closedir(d);
 }
 
+static int rtnl_rtprot_init;
+
+static void rtnl_rtprot_initialize(void)
+{
+	int ret;
+
+	rtnl_rtprot_init = 1;
+	ret = rtnl_tab_initialize(CONF_ETC_DIR "/rt_protos",
+	                          rtnl_rtprot_tab, 256);
+	if (ret == -ENOENT)
+		rtnl_tab_initialize(CONF_USR_DIR "/rt_protos",
+		                    rtnl_rtprot_tab, 256);
+
+	rtnl_tab_initialize_dir("rt_protos.d", rtnl_rtprot_tab, 256);
+}
+
 const char *rtnl_rtprot_n2a(int id, char *buf, int len)
 {
 	if (id < 0 || id >= 256 || numeric) {
-- 
2.39.2


