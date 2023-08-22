Return-Path: <netdev+bounces-29700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EC3784608
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D601C203BC
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E931DDDF;
	Tue, 22 Aug 2023 15:44:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748731DA2E
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:44:13 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8580CE4;
	Tue, 22 Aug 2023 08:44:11 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qYTY5-0003Gk-CX; Tue, 22 Aug 2023 17:44:05 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Justin Stitt <justinstitt@google.com>
Subject: [PATCH net-next 06/10] netfilter: nft_osf: refactor deprecated strncpy
Date: Tue, 22 Aug 2023 17:43:27 +0200
Message-ID: <20230822154336.12888-7-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822154336.12888-1-fw@strlen.de>
References: <20230822154336.12888-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Justin Stitt <justinstitt@google.com>

Use `strscpy_pad` over `strncpy` for NUL-terminated strings.

We can also drop the + 1 from `NFT_OSF_MAXGENRELEN + 1` since `strscpy`
will guarantee NUL-termination.

Signed-off-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_osf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_osf.c b/net/netfilter/nft_osf.c
index 70820c66b591..7f61506e5b44 100644
--- a/net/netfilter/nft_osf.c
+++ b/net/netfilter/nft_osf.c
@@ -23,7 +23,7 @@ static void nft_osf_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	struct nft_osf *priv = nft_expr_priv(expr);
 	u32 *dest = &regs->data[priv->dreg];
 	struct sk_buff *skb = pkt->skb;
-	char os_match[NFT_OSF_MAXGENRELEN + 1];
+	char os_match[NFT_OSF_MAXGENRELEN];
 	const struct tcphdr *tcp;
 	struct nf_osf_data data;
 	struct tcphdr _tcph;
@@ -45,7 +45,7 @@ static void nft_osf_eval(const struct nft_expr *expr, struct nft_regs *regs,
 	}
 
 	if (!nf_osf_find(skb, nf_osf_fingers, priv->ttl, &data)) {
-		strncpy((char *)dest, "unknown", NFT_OSF_MAXGENRELEN);
+		strscpy_pad((char *)dest, "unknown", NFT_OSF_MAXGENRELEN);
 	} else {
 		if (priv->flags & NFT_OSF_F_VERSION)
 			snprintf(os_match, NFT_OSF_MAXGENRELEN, "%s:%s",
@@ -53,7 +53,7 @@ static void nft_osf_eval(const struct nft_expr *expr, struct nft_regs *regs,
 		else
 			strscpy(os_match, data.genre, NFT_OSF_MAXGENRELEN);
 
-		strncpy((char *)dest, os_match, NFT_OSF_MAXGENRELEN);
+		strscpy_pad((char *)dest, os_match, NFT_OSF_MAXGENRELEN);
 	}
 }
 
-- 
2.41.0


