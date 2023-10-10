Return-Path: <netdev+bounces-39586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8E27BFFBD
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 16:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03451C20BFF
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE6F24C93;
	Tue, 10 Oct 2023 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145AE200DC
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:54:05 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CB899;
	Tue, 10 Oct 2023 07:54:04 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qqE7P-0001O6-Pn; Tue, 10 Oct 2023 16:53:55 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Phil Sutter <phil@nwl.cc>
Subject: [PATCH net-next 2/8] netfilter: nf_tables: Drop pointless memset when dumping rules
Date: Tue, 10 Oct 2023 16:53:32 +0200
Message-ID: <20231010145343.12551-3-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010145343.12551-1-fw@strlen.de>
References: <20231010145343.12551-1-fw@strlen.de>
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

From: Phil Sutter <phil@nwl.cc>

None of the dump callbacks uses netlink_callback::args beyond the first
element, no need to zero the data.

Fixes: 96518518cc41 ("netfilter: add nftables")
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index ea30bee41a6e..cd3c7dd15530 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3465,10 +3465,6 @@ static int __nf_tables_dump_rules(struct sk_buff *skb,
 			goto cont_skip;
 		if (*idx < s_idx)
 			goto cont;
-		if (*idx > s_idx) {
-			memset(&cb->args[1], 0,
-					sizeof(cb->args) - sizeof(cb->args[0]));
-		}
 		if (prule)
 			handle = prule->handle;
 		else
-- 
2.41.0


