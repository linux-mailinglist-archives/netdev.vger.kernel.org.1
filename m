Return-Path: <netdev+bounces-19187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCED759E31
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE1B1C2118B
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF1F26B06;
	Wed, 19 Jul 2023 19:00:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB37E25176
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:07 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [84.22.98.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340171FE6
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:05 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id 406D1D9010;
	Wed, 19 Jul 2023 20:52:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792739; bh=S6i3drzMgFVr+j9+q/n4zKpqI5Aa+IPqFw1OAIwVAPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kkdemKwu/mGQxSfzIzGRIQaINVoxphjBonPbf2dFtLOgJ3dWhg4YOrIL8hBNLy9Mj
	 W8K/FWYY+/dVRm18jxWUQOiCJnqtuSeFDoSW1KlFgwYIacSMx9h3+mHeEK6yGdCRcR
	 mFo+h34Psrr6582+d9Sajp31SgDbWG1lKkIoW3xmJHzrOJDZQq/k6X4zj6ZsDuZfPr
	 OkU8ZaxLR2A7+KZXZ4v7xvIlHWpckZ7qgVZftzHI0mgBHx9lMITxKr4t+OaPjSm6dJ
	 gEzkS/8nSxZ1Vdt68HVdh6EPK1l60xnepVpDz5f9zG9a9Qd0I0FLKpTI843wIleBv2
	 NK/6BDVLcZNRg==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 12/22] lib/rt_names: Read rt_names from /etc and /usr
Date: Wed, 19 Jul 2023 20:50:56 +0200
Message-Id: <20230719185106.17614-13-gioele@svario.it>
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
index 37f85ded..5b911753 100644
--- a/lib/rt_names.c
+++ b/lib/rt_names.c
@@ -375,9 +375,14 @@ static int rtnl_rtrealm_init;
 
 static void rtnl_rtrealm_initialize(void)
 {
+	int ret;
+
 	rtnl_rtrealm_init = 1;
-	rtnl_tab_initialize(CONF_ETC_DIR "/rt_realms",
-			    rtnl_rtrealm_tab, 256);
+	ret = rtnl_tab_initialize(CONF_ETC_DIR "/rt_realms",
+	                          rtnl_rtrealm_tab, 256);
+	if (ret == -ENOENT)
+		rtnl_tab_initialize(CONF_USR_DIR "/rt_realms",
+		                    rtnl_rtrealm_tab, 256);
 }
 
 const char *rtnl_rtrealm_n2a(int id, char *buf, int len)
-- 
2.39.2


