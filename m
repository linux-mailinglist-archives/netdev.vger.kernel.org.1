Return-Path: <netdev+bounces-26169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D227777102
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 09:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C691C20FE8
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 07:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB18F6125;
	Thu, 10 Aug 2023 07:08:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4776122
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 07:08:40 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6063EE40;
	Thu, 10 Aug 2023 00:08:39 -0700 (PDT)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	stable@vger.kernel.org
Subject: [PATCH net 4/5] netfilter: nft_set_hash: mark set element as dead when deleting from packet path
Date: Thu, 10 Aug 2023 09:08:29 +0200
Message-Id: <20230810070830.24064-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230810070830.24064-1-pablo@netfilter.org>
References: <20230810070830.24064-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Set on the NFT_SET_ELEM_DEAD_BIT flag on this element, instead of
performing element removal which might race with an ongoing transaction.
Enable gc when dynamic flag is set on since dynset deletion requires
garbage collection after this patch.

Fixes: d0a8d877da97 ("netfilter: nft_dynset: support for element deletion")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_set_hash.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 2f067e4596b0..cef5df846000 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -249,7 +249,9 @@ static bool nft_rhash_delete(const struct nft_set *set,
 	if (he == NULL)
 		return false;
 
-	return rhashtable_remove_fast(&priv->ht, &he->node, nft_rhash_params) == 0;
+	nft_set_elem_dead(&he->ext);
+
+	return true;
 }
 
 static void nft_rhash_walk(const struct nft_ctx *ctx, struct nft_set *set,
@@ -412,7 +414,7 @@ static int nft_rhash_init(const struct nft_set *set,
 		return err;
 
 	INIT_DEFERRABLE_WORK(&priv->gc_work, nft_rhash_gc);
-	if (set->flags & NFT_SET_TIMEOUT)
+	if (set->flags & (NFT_SET_TIMEOUT | NFT_SET_EVAL))
 		nft_rhash_gc_init(set);
 
 	return 0;
-- 
2.30.2


