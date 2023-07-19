Return-Path: <netdev+bounces-19180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A639E759E25
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C9C1C21153
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE18025165;
	Wed, 19 Jul 2023 19:00:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8B2515E
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:06 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [IPv6:2a02:2770:13::112:0:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019391FD8
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:04 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id 0D243D901E;
	Wed, 19 Jul 2023 20:52:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792741; bh=OYCtesCTUNXXvySvRfs+zvO5AlGgeH2pDtInIr8fTDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iVA8hjApdHBTriOvnIcFsYwXUci/Lg/9PXZDffTRGWxTnLmeYKggU22AGMwgnXCCL
	 d2lDANepKbb6rYETqEA6GRkpc6Qt28FeukTCKXP4rjroedEArhx2MQtlJiiyrpwbWO
	 dy99IBMCa6ybgFHNgks9CA3s8YxzW85wA+vLYbKNFnNOQ0EPH3ReyjvehAaeiP3tDq
	 94fQRLbKnYqea2JIK23FOiGT7K0E8gU6SnKTAgnoIXGVoIYrA6mQXTKficp8UqgHQP
	 +QpPEnR/GM0Qwf3uevXFPya81fktpBjUDI+l8WBTQaJxL8IAyo8KuvRvkaw2ujdB2T
	 Qp09VryMGt5AQ==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 19/22] lib/rt_names: Read protodown_reasons.d/* using rtnl_tab_initialize_dir
Date: Wed, 19 Jul 2023 20:51:03 +0200
Message-Id: <20230719185106.17614-20-gioele@svario.it>
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
 lib/rt_names.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/lib/rt_names.c b/lib/rt_names.c
index 3b69d05d..090fc883 100644
--- a/lib/rt_names.c
+++ b/lib/rt_names.c
@@ -835,35 +835,10 @@ static int protodown_reason_init;
 
 static void protodown_reason_initialize(void)
 {
-	struct dirent *de;
-	DIR *d;
-
 	protodown_reason_init = 1;
 
-	d = opendir(CONF_ETC_DIR "/protodown_reasons.d");
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
-		snprintf(path, sizeof(path), CONF_ETC_DIR "/protodown_reasons.d/%s",
-			 de->d_name);
-		rtnl_tab_initialize(path, protodown_reason_tab,
-				    PROTODOWN_REASON_NUM_BITS);
-	}
-	closedir(d);
+	rtnl_tab_initialize_dir("protodown_reasons.d", protodown_reason_tab,
+                                PROTODOWN_REASON_NUM_BITS);
 }
 
 int protodown_reason_n2a(int id, char *buf, int len)
-- 
2.39.2


