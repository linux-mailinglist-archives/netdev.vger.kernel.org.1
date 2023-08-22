Return-Path: <netdev+bounces-29524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CB7783A2C
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 08:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD973280FE2
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 06:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF416ABD;
	Tue, 22 Aug 2023 06:52:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F8B63BF
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 06:52:27 +0000 (UTC)
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901C719A;
	Mon, 21 Aug 2023 23:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1692687134;
	bh=tQ1co5z99/X+ABfdWW4NyqVShxtMELNEwRz5sOubfpE=;
	h=From:Date:Subject:To:Cc:From;
	b=KlBG6EdUBmsV/rWVVIeJjOIz9NOO973JsdBNQefk05l4BzHNBLfxCr8ood2D2iK5Y
	 Pat+o6CTq+1i+TT8SgeOHpF7lWuPgarmXyVzKnlTQVzFdI7ccB3Zf/IIAsyStooVhH
	 Kxvbnf1/zLgk46MugFfRsUFo/zJvXU/CwuFA7ilA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 22 Aug 2023 08:51:57 +0200
Subject: [PATCH net-next] net: generalize calculation of skb extensions
 length
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230822-skb_ext-simplify-v1-1-9dd047340ab5@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAxb5GQC/x2M0QqDMAwAf0XybMClOKy/MmSsNdWg66SR4ZD+u
 2WPB3d3gnISVuirExJ/ReUTC9zqCvz8ihOjjIWBGjJNR4S6uCcfO6q8t1XCD81ojWdn23AnKNm
 WOMjxXz4g8o6x6DDkfAHh7YlnbAAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Robert Marko <robimarko@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692687132; l=1521;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=tQ1co5z99/X+ABfdWW4NyqVShxtMELNEwRz5sOubfpE=;
 b=nB1JA227gd9D7EIQ1Y4lAJ8e2tHkBI33b9Aqdnm3VtiTRNmmo0Qas2OWUuzXM8hPBYtIamIWa
 V750Wfu0R+sBsZYNOaGf2ry/6DkUIRlF1OqNiKUUDFPD7esPizdVYcc
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
	T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove the necessity to modify skb_ext_total_length() when new extension
types are added.
Also reduces the line count a bit.

With optimizations enabled the function is folded down to a constant
value as before.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
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


