Return-Path: <netdev+bounces-29702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F0B78460B
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089091C20A5E
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD5A1DDEB;
	Tue, 22 Aug 2023 15:44:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB6F1DDE5
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:44:17 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73F1CDD;
	Tue, 22 Aug 2023 08:44:16 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qYTYD-0003Hj-Gx; Tue, 22 Aug 2023 17:44:13 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Justin Stitt <justinstitt@google.com>
Subject: [PATCH net-next 08/10] netfilter: x_tables: refactor deprecated strncpy
Date: Tue, 22 Aug 2023 17:43:29 +0200
Message-ID: <20230822154336.12888-9-fw@strlen.de>
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

Prefer `strscpy_pad` to `strncpy`.

Signed-off-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/x_tables.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 470282cf3fae..21624d68314f 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -768,7 +768,7 @@ void xt_compat_match_from_user(struct xt_entry_match *m, void **dstptr,
 	m->u.user.match_size = msize;
 	strscpy(name, match->name, sizeof(name));
 	module_put(match->me);
-	strncpy(m->u.user.name, name, sizeof(m->u.user.name));
+	strscpy_pad(m->u.user.name, name, sizeof(m->u.user.name));
 
 	*size += off;
 	*dstptr += msize;
@@ -1148,7 +1148,7 @@ void xt_compat_target_from_user(struct xt_entry_target *t, void **dstptr,
 	t->u.user.target_size = tsize;
 	strscpy(name, target->name, sizeof(name));
 	module_put(target->me);
-	strncpy(t->u.user.name, name, sizeof(t->u.user.name));
+	strscpy_pad(t->u.user.name, name, sizeof(t->u.user.name));
 
 	*size += off;
 	*dstptr += tsize;
@@ -2014,4 +2014,3 @@ static void __exit xt_fini(void)
 
 module_init(xt_init);
 module_exit(xt_fini);
-
-- 
2.41.0


