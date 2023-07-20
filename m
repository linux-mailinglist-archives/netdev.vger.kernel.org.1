Return-Path: <netdev+bounces-19589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 220F075B4FE
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 18:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21C6280A64
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 16:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD642FA3A;
	Thu, 20 Jul 2023 16:51:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC891773D
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 16:51:56 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E413C1715;
	Thu, 20 Jul 2023 09:51:55 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qMWsZ-0001Lf-Vc; Thu, 20 Jul 2023 18:51:51 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>
Subject: [PATCH net 1/5] netfilter: nf_tables: fix spurious set element insertion failure
Date: Thu, 20 Jul 2023 18:51:33 +0200
Message-ID: <20230720165143.30208-2-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720165143.30208-1-fw@strlen.de>
References: <20230720165143.30208-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On some platforms there is a padding hole in the nft_verdict
structure, between the verdict code and the chain pointer.

On element insertion, if the new element clashes with an existing one and
NLM_F_EXCL flag isn't set, we want to ignore the -EEXIST error as long as
the data associated with duplicated element is the same as the existing
one.  The data equality check uses memcmp.

For normal data (NFT_DATA_VALUE) this works fine, but for NFT_DATA_VERDICT
padding area leads to spurious failure even if the verdict data is the
same.

This then makes the insertion fail with 'already exists' error, even
though the new "key : data" matches an existing entry and userspace
told the kernel that it doesn't want to receive an error indication.

Fixes: c016c7e45ddf ("netfilter: nf_tables: honor NLM_F_EXCL flag in set element insertion")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 237f739da3ca..79c7eee33dcd 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -10517,6 +10517,9 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 
 	if (!tb[NFTA_VERDICT_CODE])
 		return -EINVAL;
+
+	/* zero padding hole for memcmp */
+	memset(data, 0, sizeof(*data));
 	data->verdict.code = ntohl(nla_get_be32(tb[NFTA_VERDICT_CODE]));
 
 	switch (data->verdict.code) {
-- 
2.41.0


