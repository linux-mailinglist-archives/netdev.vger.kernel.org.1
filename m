Return-Path: <netdev+bounces-19169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFD2759E0F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E791C21145
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8E41BB45;
	Wed, 19 Jul 2023 19:00:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117871BB44
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:02 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E078B1BFD
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id C0D04D9014;
	Wed, 19 Jul 2023 20:52:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792739; bh=kIzvIS/TEBf1LaVjVvFUSCfipJ3rJxi5+DoVDYC0xyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brqWqKdFXgN7tQgfUPs+zgCFZuU2/7ydzsmj/7zHwFc4BC8OYZmrFkqWEwNcCJ3GZ
	 umuQ3ie5BfUicwRsvOUEG/aJZLl7hSWEl6LjefdYC23de/VOgepVYvWK0X+cleYI0r
	 juC29CzBgGgXBsFjpwSHxYSLR+G7fJzD2WHK77oxEezlGv0d1QIk9V9sUpxvy4n5KG
	 a/9G9i9g44uvV+VDpvgySSn9e/aOqe5jn3koNePeGLeccbgQ5pvk3NCLf++Q/Roh23
	 6VM2LcTHq2reFxoQtU+eSDDxjC4m6ic8peucOBAuDB9jPacktkG9Gfmnrv7Zo+SLHj
	 uAysvqkKojBLw==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 14/22] lib/rt_names: Read rt_dsfield from /etc and /usr
Date: Wed, 19 Jul 2023 20:50:58 +0200
Message-Id: <20230719185106.17614-15-gioele@svario.it>
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
 lib/rt_names.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/rt_names.c b/lib/rt_names.c
index e0659250..a96ae540 100644
--- a/lib/rt_names.c
+++ b/lib/rt_names.c
@@ -549,9 +549,14 @@ static int rtnl_rtdsfield_init;
 
 static void rtnl_rtdsfield_initialize(void)
 {
+	int ret;
+
 	rtnl_rtdsfield_init = 1;
-	rtnl_tab_initialize(CONF_ETC_DIR "/rt_dsfield",
-			    rtnl_rtdsfield_tab, 256);
+	ret = rtnl_tab_initialize(CONF_ETC_DIR "/rt_dsfield",
+	                          rtnl_rtdsfield_tab, 256);
+	if (ret == -ENOENT)
+		rtnl_tab_initialize(CONF_USR_DIR "/rt_dsfield",
+		                    rtnl_rtdsfield_tab, 256);
 }
 
 const char *rtnl_dsfield_n2a(int id, char *buf, int len)
-- 
2.39.2


