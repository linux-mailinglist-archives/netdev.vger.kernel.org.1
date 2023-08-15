Return-Path: <netdev+bounces-27647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C3977CAC6
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 11:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6061C20C7C
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F144101FC;
	Tue, 15 Aug 2023 09:53:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C13101E8
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 09:53:21 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31364E3
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:53:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id EABA12080B;
	Tue, 15 Aug 2023 11:53:17 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e6hj2-gBrjbM; Tue, 15 Aug 2023 11:53:15 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 23DEE207A4;
	Tue, 15 Aug 2023 11:53:15 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 1D3D780004A;
	Tue, 15 Aug 2023 11:53:15 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 11:53:14 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 11:53:14 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 4F1513182B5E; Tue, 15 Aug 2023 11:53:14 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 03/11] net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure
Date: Tue, 15 Aug 2023 11:53:02 +0200
Message-ID: <20230815095310.3310160-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815095310.3310160-1-steffen.klassert@secunet.com>
References: <20230815095310.3310160-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Lin Ma <linma@zju.edu.cn>

According to all consumers code of attrs[XFRMA_SEC_CTX], like

* verify_sec_ctx_len(), convert to xfrm_user_sec_ctx*
* xfrm_state_construct(), call security_xfrm_state_alloc whose prototype
is int security_xfrm_state_alloc(.., struct xfrm_user_sec_ctx *sec_ctx);
* copy_from_user_sec_ctx(), convert to xfrm_user_sec_ctx *
...

It seems that the expected parsing result for XFRMA_SEC_CTX should be
structure xfrm_user_sec_ctx, and the current xfrm_sec_ctx is confusing
and misleading (Luckily, they happen to have same size 8 bytes).

This commit amend the policy structure to xfrm_user_sec_ctx to avoid
ambiguity.

Fixes: cf5cb79f6946 ("[XFRM] netlink: Establish an attribute policy")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_compat.c | 2 +-
 net/xfrm/xfrm_user.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_compat.c b/net/xfrm/xfrm_compat.c
index 8cbf45a8bcdc..655fe4ff8621 100644
--- a/net/xfrm/xfrm_compat.c
+++ b/net/xfrm/xfrm_compat.c
@@ -108,7 +108,7 @@ static const struct nla_policy compat_policy[XFRMA_MAX+1] = {
 	[XFRMA_ALG_COMP]	= { .len = sizeof(struct xfrm_algo) },
 	[XFRMA_ENCAP]		= { .len = sizeof(struct xfrm_encap_tmpl) },
 	[XFRMA_TMPL]		= { .len = sizeof(struct xfrm_user_tmpl) },
-	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_sec_ctx) },
+	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_user_sec_ctx) },
 	[XFRMA_LTIME_VAL]	= { .len = sizeof(struct xfrm_lifetime_cur) },
 	[XFRMA_REPLAY_VAL]	= { .len = sizeof(struct xfrm_replay_state) },
 	[XFRMA_REPLAY_THRESH]	= { .type = NLA_U32 },
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 7c91deadc36e..fdc0c17122b6 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3024,7 +3024,7 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] = {
 	[XFRMA_ALG_COMP]	= { .len = sizeof(struct xfrm_algo) },
 	[XFRMA_ENCAP]		= { .len = sizeof(struct xfrm_encap_tmpl) },
 	[XFRMA_TMPL]		= { .len = sizeof(struct xfrm_user_tmpl) },
-	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_sec_ctx) },
+	[XFRMA_SEC_CTX]		= { .len = sizeof(struct xfrm_user_sec_ctx) },
 	[XFRMA_LTIME_VAL]	= { .len = sizeof(struct xfrm_lifetime_cur) },
 	[XFRMA_REPLAY_VAL]	= { .len = sizeof(struct xfrm_replay_state) },
 	[XFRMA_REPLAY_THRESH]	= { .type = NLA_U32 },
-- 
2.34.1


