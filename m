Return-Path: <netdev+bounces-40288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0961F7C68B5
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 10:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D221C21104
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A915208D7;
	Thu, 12 Oct 2023 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094EB2033F
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 08:58:03 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF08C9;
	Thu, 12 Oct 2023 01:58:01 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qqrW1-00078l-9h; Thu, 12 Oct 2023 10:57:57 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	=?UTF-8?q?Bla=C5=BEej=20Kraj=C5=88=C3=A1k?= <krajnak@levonet.sk>
Subject: [PATCH net 7/7] netfilter: nft_payload: fix wrong mac header matching
Date: Thu, 12 Oct 2023 10:57:10 +0200
Message-ID: <20231012085724.15155-8-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012085724.15155-1-fw@strlen.de>
References: <20231012085724.15155-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

mcast packets get looped back to the local machine.
Such packets have a 0-length mac header, we should treat
this like "mac header not set" and abort rule evaluation.

As-is, we just copy data from the network header instead.

Fixes: 96518518cc41 ("netfilter: add nftables")
Reported-by: Blažej Krajňák <krajnak@levonet.sk>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_payload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 120f6d395b98..0a689c8e0295 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -179,7 +179,7 @@ void nft_payload_eval(const struct nft_expr *expr,
 
 	switch (priv->base) {
 	case NFT_PAYLOAD_LL_HEADER:
-		if (!skb_mac_header_was_set(skb))
+		if (!skb_mac_header_was_set(skb) || skb_mac_header_len(skb) == 0)
 			goto err;
 
 		if (skb_vlan_tag_present(skb) &&
-- 
2.41.0


