Return-Path: <netdev+bounces-29919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2759C7853EB
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 11:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109FF1C20C91
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 09:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D71A946;
	Wed, 23 Aug 2023 09:29:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64320947B
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 09:29:12 +0000 (UTC)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8FB4C10;
	Wed, 23 Aug 2023 02:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1692782935;
	bh=+EpxE9f72o1TR6FpVddFLvSnxpHvOjNBp+8sV5oCN6o=;
	h=From:Date:Subject:To:Cc:From;
	b=NuD7fV65b9ikivJJnA4/FIwyOaJfm62E7ofQxsw4xK4iZElWFXh8ozOrcoxBqWwtx
	 NAryLJu+dMPAdx63mPw0qBKglJM9g59+ONO7wkMqvXFIzqddq1F5vapGZcCXIkUaTo
	 yHTdkc9lm+c7su+COK+VQIscET5M1p2P608tv7AY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 23 Aug 2023 11:28:38 +0200
Subject: [PATCH net-next v2] net: generalize calculation of skb extensions
 length
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230823-skb_ext-simplify-v2-1-66e26cd66860@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAEXR5WQC/3WNwQ6CMBBEf4Xs2TWlBRVP/ochBuhiN0ohXUQI4
 d9tuHucvJk3KwgFJoFrskKgiYV7H4M+JNC4yj8J2cYMWmmjLlqjvOoHzSMKd8Ob2wWNLUxDdZG
 3Jw1xNgRqed6Vd/A0oo91KCNxLGMflv1rSnf+XzulmGJhrcrOJlNVnd++xCLSuI87Ri2U27b9A
 Ln0SO2/AAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Robert Marko <robimarko@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692782934; l=2136;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=+EpxE9f72o1TR6FpVddFLvSnxpHvOjNBp+8sV5oCN6o=;
 b=VUpYiDsMZc0Xwf0zpF1EGQfMWn/RD85WHBJH7J0AenY+sRUCY/XQBt5VCDgxjW/44pjXoC1Gq
 DKgsTmM0PNRBdxFNEkJxjAMsWB3hP6IwOkK17yueGBRgqHv32BA/sl7
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove the necessity to modify skb_ext_total_length() when new extension
types are added.
Also reduces the line count a bit.

With optimizations enabled the function is folded down to the same
constant value as before during compilation.
This has been validated on x86 with GCC 6.5.0 and 13.2.1.
Also a similar construct has been validated on godbolt.org with GCC 5.1.
In any case the compiler has to be able to evaluate the construct at
compile-time for the BUILD_BUG_ON() in skb_extensions_init().

Even if not evaluated at compile-time this function would only ever
be executed once at run-time, so the overhead would be very minuscule.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Add more proof for identical behavior to the commit log
- Link to v1: https://lore.kernel.org/r/20230822-skb_ext-simplify-v1-1-9dd047340ab5@weissschuh.net
---
 net/core/skbuff.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index faa6c86da2a5..45707059082f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4785,23 +4785,13 @@ static const u8 skb_ext_type_len[] = {
 
 static __always_inline unsigned int skb_ext_total_length(void)
 {
-	return SKB_EXT_CHUNKSIZEOF(struct skb_ext) +
-#if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
-		skb_ext_type_len[SKB_EXT_BRIDGE_NF] +
-#endif
-#ifdef CONFIG_XFRM
-		skb_ext_type_len[SKB_EXT_SEC_PATH] +
-#endif
-#if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
-		skb_ext_type_len[TC_SKB_EXT] +
-#endif
-#if IS_ENABLED(CONFIG_MPTCP)
-		skb_ext_type_len[SKB_EXT_MPTCP] +
-#endif
-#if IS_ENABLED(CONFIG_MCTP_FLOWS)
-		skb_ext_type_len[SKB_EXT_MCTP] +
-#endif
-		0;
+	unsigned int l = SKB_EXT_CHUNKSIZEOF(struct skb_ext);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(skb_ext_type_len); i++)
+		l += skb_ext_type_len[i];
+
+	return l;
 }
 
 static void skb_extensions_init(void)

---
base-commit: 90308679c297ffcbb317c715ef434e9fb3c881dc
change-id: 20230822-skb_ext-simplify-3d93ceb95f62

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


