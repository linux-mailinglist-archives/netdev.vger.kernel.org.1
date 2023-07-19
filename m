Return-Path: <netdev+bounces-19175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252A0759E1A
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537701C21120
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAD122F08;
	Wed, 19 Jul 2023 19:00:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317B22F06
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:05 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [IPv6:2a02:2770:13::112:0:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151DE199A
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:03 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id 1D9E7D9002;
	Wed, 19 Jul 2023 20:52:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792737; bh=FoCLbZ5XzGzufylNAbHcJKDTCwLmF/uZuWXTNhmmDCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c8y1S+il6WajX97QGEaxASjpTJ1ULrHhAQq5WDtwacm0CSlq4gLbUeWp/jY5so2Ch
	 1+barhGr7vxDCNMg19mgBkzwQSSVlsSCxtxUftso2pWeTFWHisKTisC3XAzJsunKnb
	 kf+WmZhqemkZX3CLUuhpK+jc1ejM+ORfbotxVxYxlN98ao6+Il4OdU7eBofkxbwaVJ
	 LvIvxjFCS+gKHG1mWwW1awgLlMCV53kkR2zrFHPPz/J51zDGR+Z02wLj7ySWjfuojd
	 H4MD3ENIIUn0omAWwd8tzXu4+EKZlW3M1iYXEE3FHTkjUO6BIyvAbr4sttIRyWa537
	 caxHTzv+8z0Yg==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 05/22] tc/m_ematch: Read ematch from /etc and /usr
Date: Wed, 19 Jul 2023 20:50:49 +0200
Message-Id: <20230719185106.17614-6-gioele@svario.it>
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
 tc/m_ematch.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tc/m_ematch.c b/tc/m_ematch.c
index e30ee205..1d0a208f 100644
--- a/tc/m_ematch.c
+++ b/tc/m_ematch.c
@@ -21,7 +21,8 @@
 #include "tc_util.h"
 #include "m_ematch.h"
 
-#define EMATCH_MAP "/etc/iproute2/ematch_map"
+#define EMATCH_MAP_USR	"/usr/lib/iproute2/ematch_map"
+#define EMATCH_MAP_ETC	"/etc/iproute2/ematch_map"
 
 static struct ematch_util *ematch_list;
 
@@ -39,11 +40,11 @@ static void bstr_print(FILE *fd, const struct bstr *b, int ascii);
 static inline void map_warning(int num, char *kind)
 {
 	fprintf(stderr,
-	    "Error: Unable to find ematch \"%s\" in %s\n" \
+	    "Error: Unable to find ematch \"%s\" in %s or %s\n" \
 	    "Please assign a unique ID to the ematch kind the suggested " \
 	    "entry is:\n" \
 	    "\t%d\t%s\n",
-	    kind, EMATCH_MAP, num, kind);
+	    kind, EMATCH_MAP_ETC, EMATCH_MAP_USR, num, kind);
 }
 
 static int lookup_map(__u16 num, char *dst, int len, const char *file)
@@ -160,8 +161,12 @@ static struct ematch_util *get_ematch_kind(char *kind)
 static struct ematch_util *get_ematch_kind_num(__u16 kind)
 {
 	char name[513];
+	int ret;
 
-	if (lookup_map(kind, name, sizeof(name), EMATCH_MAP) < 0)
+	ret = lookup_map(kind, name, sizeof(name), EMATCH_MAP_ETC);
+	if (ret == -ENOENT)
+		ret = lookup_map(kind, name, sizeof(name), EMATCH_MAP_USR);
+	if (ret < 0)
 		return NULL;
 
 	return get_ematch_kind(name);
@@ -227,7 +232,9 @@ static int parse_tree(struct nlmsghdr *n, struct ematch *tree)
 				return -1;
 			}
 
-			err = lookup_map_id(buf, &num, EMATCH_MAP);
+			err = lookup_map_id(buf, &num, EMATCH_MAP_ETC);
+			if (err == -ENOENT)
+				err = lookup_map_id(buf, &num, EMATCH_MAP_USR);
 			if (err < 0) {
 				if (err == -ENOENT)
 					map_warning(e->kind_num, buf);
-- 
2.39.2


