Return-Path: <netdev+bounces-29698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D52784606
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0093F28103A
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DE31DA37;
	Tue, 22 Aug 2023 15:44:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85121DA2E
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:44:05 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DACCE6;
	Tue, 22 Aug 2023 08:44:03 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qYTXx-0003Fn-6o; Tue, 22 Aug 2023 17:43:57 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Justin Stitt <justinstitt@google.com>
Subject: [PATCH net-next 04/10] netfilter: nf_tables: refactor deprecated strncpy
Date: Tue, 22 Aug 2023 17:43:25 +0200
Message-ID: <20230822154336.12888-5-fw@strlen.de>
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

Prefer `strscpy_pad` over `strncpy`.

Signed-off-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nft_ct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index e87fd4314c68..86bb9d7797d9 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -108,7 +108,7 @@ static void nft_ct_get_eval(const struct nft_expr *expr,
 		helper = rcu_dereference(help->helper);
 		if (helper == NULL)
 			goto err;
-		strncpy((char *)dest, helper->name, NF_CT_HELPER_NAME_LEN);
+		strscpy_pad((char *)dest, helper->name, NF_CT_HELPER_NAME_LEN);
 		return;
 #ifdef CONFIG_NF_CONNTRACK_LABELS
 	case NFT_CT_LABELS: {
-- 
2.41.0


