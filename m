Return-Path: <netdev+bounces-19168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D747F759E0E
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D751C21120
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD95A1BB25;
	Wed, 19 Jul 2023 19:00:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33C815486
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:02 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [IPv6:2a02:2770:13::112:0:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07001BF7
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id CAB79D9000;
	Wed, 19 Jul 2023 20:52:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792737; bh=qpgJcY68jyT9va8CZDsa5x3HuiN4+7DQRKIakVXmZfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lhMZ3DFpwQjW6sgFkRoTohxhRA5l7Ib5zQ3daznoUcmE07j71zV70Zxa9JIx7YlFj
	 JRuG5fyAUQrwLxNgb1hsK0JsgQvqI+1iy5YATwSpe8ohUHCGzfsrhjf/JHPeSmlyzH
	 kqmsvh9jCR7WlCornxt8GsBPN16gAimV7ud/uaKFIlbCxsFrhPesfT6JmnrmFSlhO+
	 NyITXIbjWmgvOUJduFsJqEbmWccJ5YcHGh3teF1OJiaaOVZE76Vd/s8Ak26jUWCwRD
	 +AQ2oBIrGJBgVQoIAEfOYK3MTmt2G6lZ+8Yvg+OgH3w5WVQxGPYGBB1+ei5+uvlhXi
	 3m7qKe5xpUmYg==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 04/22] tc/tc_util: Read class names from provided path, /etc/, /usr
Date: Wed, 19 Jul 2023 20:50:48 +0200
Message-Id: <20230719185106.17614-5-gioele@svario.it>
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
 tc/tc_util.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tc/tc_util.c b/tc/tc_util.c
index ed9efa70..e6235291 100644
--- a/tc/tc_util.c
+++ b/tc/tc_util.c
@@ -28,7 +28,8 @@
 
 static struct db_names *cls_names;
 
-#define NAMES_DB "/etc/iproute2/tc_cls"
+#define NAMES_DB_USR "/usr/lib/iproute2/tc_cls"
+#define NAMES_DB_ETC "/etc/iproute2/tc_cls"
 
 int cls_names_init(char *path)
 {
@@ -38,11 +39,18 @@ int cls_names_init(char *path)
 	if (!cls_names)
 		return -1;
 
-	ret = db_names_load(cls_names, path ?: NAMES_DB);
-	if (ret == -ENOENT && path) {
-		fprintf(stderr, "Can't open class names file: %s\n", path);
-		return -1;
+	if (path) {
+		ret = db_names_load(cls_names, path);
+		if (ret == -ENOENT) {
+			fprintf(stderr, "Can't open class names file: %s\n", path);
+			return -1;
+		}
 	}
+
+	ret = db_names_load(cls_names, NAMES_DB_ETC);
+	if (ret == -ENOENT)
+		ret = db_names_load(cls_names, NAMES_DB_USR);
+
 	if (ret) {
 		db_names_free(cls_names);
 		cls_names = NULL;
-- 
2.39.2


