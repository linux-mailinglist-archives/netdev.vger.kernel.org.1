Return-Path: <netdev+bounces-19186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E07A759E30
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5131C21166
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 19:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04882516C;
	Wed, 19 Jul 2023 19:00:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4BB26B24
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:00:07 +0000 (UTC)
Received: from mail.svario.it (mail.svario.it [IPv6:2a02:2770:13::112:0:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8091BF7
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 12:00:05 -0700 (PDT)
Received: from localhost.localdomain (dynamic-002-244-020-234.2.244.pool.telefonica.de [2.244.20.234])
	by mail.svario.it (Postfix) with ESMTPSA id 4D035D9018;
	Wed, 19 Jul 2023 20:52:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svario.it; s=201710;
	t=1689792740; bh=+Kpo5a2vJYN3/aEZ2HNGH2+4D7kAmIRcLAbf8xQaYak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FH5+mhG8o3gac/mSTqdiNdcyCG4TsxhoIci+SBhqYFVfovuPwJxrnvvT0UmXX/S0v
	 BLo6yuWEs57RBPODo3ZSCWdO7EEAhR7rWa6pt+C9qh3Z+HW7s9ywebxg0mO7f3tqYq
	 KRpoHsKXURXPdJR2rzlJDZ3p6jtzVNptaGJ8GHAa9u38K0FhvS3LLgLKne/+5IN7wq
	 fKMvhWsQX3QGzkyMnwhj3aVgHJb64eaL19yIzDNETe/C5Fd1co9N1zzdkdNEFGeS0S
	 Zek4oMNBB/8Z2XPzsy6dzCk+D/CnDOlYA8+167XEiAJ+TjA8xaMOL9K/sMWphT12Pb
	 V2FGy/J6yzGPg==
From: Gioele Barabucci <gioele@svario.it>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Gioele Barabucci <gioele@svario.it>
Subject: [iproute2 16/22] lib/rt_names: Read nl_protos from /etc and /usr
Date: Wed, 19 Jul 2023 20:51:00 +0200
Message-Id: <20230719185106.17614-17-gioele@svario.it>
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
index 046a3614..4f38fcbe 100644
--- a/lib/rt_names.c
+++ b/lib/rt_names.c
@@ -728,9 +728,14 @@ static int nl_proto_init;
 
 static void nl_proto_initialize(void)
 {
+	int ret;
+
 	nl_proto_init = 1;
-	rtnl_tab_initialize(CONF_ETC_DIR "/nl_protos",
-			    nl_proto_tab, 256);
+	ret = rtnl_tab_initialize(CONF_ETC_DIR "/nl_protos",
+	                          nl_proto_tab, 256);
+	if (ret == -ENOENT)
+		rtnl_tab_initialize(CONF_USR_DIR "/nl_protos",
+		                    nl_proto_tab, 256);
 }
 
 const char *nl_proto_n2a(int id, char *buf, int len)
-- 
2.39.2


