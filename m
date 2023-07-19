Return-Path: <netdev+bounces-19183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 560E5759E29
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868BB1C2110D
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377CB26B03;
	Wed, 19 Jul 2023 19:00:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214EB25176
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:07 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [IPv6:2a02:2770:13::112:0:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9431FDD
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:05 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id B0A86D900C;
	Wed, 19 Jul 2023 20:52:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792738; bh=CUBdYfOyTGBIYpTCeYGXgxbbcATIOGwqgEv3CVC+rrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivwVmfRt5LwW1kVr9hIsgad5SpVcxJ7PVGc+0Xc4pZKfLN2s7URsE89s0XIF5xle6
	 r6RbYJRr7RpHZbvGjY2X4NhttzyvzVvgyh7FoePgIksXWls+pwGc9xrFGnkaA++jKq
	 FL8ez879ZGdAE+I24caCa71BW0kKqVqPYT+5WcOvkzRwHOeOnY01OemgSBZtH8itDC
	 OV7K5ivXH7r7Lft52iMczkJlhifXc54R+F/NX6J5w7obY93yyFcJYRa9BY2YN9AcYl
	 KRI9d6kSbu2kze7f3Pk8B1dTL9PSGi8VI1lmGKt4zWzw+6+LaRllb0g2PYSWjoRbn4
	 ST39gLbRHAdqg==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 10/22] lib/rt_names: Read rt_protos from /etc and /usr
Date: Wed, 19 Jul 2023 20:50:54 +0200
Message-Id: <20230719185106.17614-11-gioele@svario.it>
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
 lib/rt_names.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/rt_names.c b/lib/rt_names.c
index f64602b5..142954cd 100644
--- a/lib/rt_names.c
+++ b/lib/rt_names.c
@@ -156,10 +156,14 @@ static void rtnl_rtprot_initialize(void)
 {
 	struct dirent *de;
 	DIR *d;
+	int ret;
 
 	rtnl_rtprot_init = 1;
-	rtnl_tab_initialize(CONF_ETC_DIR "/rt_protos",
-			    rtnl_rtprot_tab, 256);
+	ret = rtnl_tab_initialize(CONF_ETC_DIR "/rt_protos",
+	                          rtnl_rtprot_tab, 256);
+	if (ret == -ENOENT)
+		rtnl_tab_initialize(CONF_USR_DIR "/rt_protos",
+		                    rtnl_rtprot_tab, 256);
 
 	d = opendir(CONF_ETC_DIR "/rt_protos.d");
 	if (!d)
-- 
2.39.2


