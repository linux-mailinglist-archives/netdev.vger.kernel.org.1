Return-Path: <netdev+bounces-44024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151C67D5D93
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 23:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 887C7B20C37
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 21:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B592D621;
	Tue, 24 Oct 2023 21:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="bfAt2zU/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C149E2D61C
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 21:58:30 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A52910C6
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:58:28 -0700 (PDT)
Received: from localhost.localdomain ([141.170.221.62])
	by smtp.orange.fr with ESMTPA
	id vPPuqJHBw1FecvPPuqURbW; Tue, 24 Oct 2023 23:58:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1698184707;
	bh=CxvDITTYWkbVF3erY431KvtkoAIB2u79w80t/0Puphk=;
	h=From:To:Cc:Subject:Date;
	b=bfAt2zU/U5AFUmH1D1n1lI5TdIRFOhOYxVQrrCy1n21xgIA8oAbl0E7GEcV0J31t4
	 2dNamly3ACkpzHZXMY6i3Jj/BeZ9W8lJaVTUr1GQ9A4JoIM5A9y2EPgkfKQhOnhjAT
	 cVXQVj18euEh+SGpRScXfLE4CTLDjSe1mUZkqHYTWenzHCawJsNdSDRfg5opbWDif3
	 Ee3nNVaQxzyzu+5oThrra2CV6NJOh86HGhTeHlklONpAx/+Hxu8T0Vt0frpX6Q2OQ7
	 mklUw9VRu+ePWscJ1QhuyME3BGWJ2JjNaYHHIGG9+INTE0QTHHovEoEqlPdOLSOqoT
	 r8V4jRMmwu9Lg==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 24 Oct 2023 23:58:27 +0200
X-ME-IP: 141.170.221.62
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trond.myklebust@hammerspace.com,
	anna@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net v2] net: sunrpc: Fix an off by one in rpc_sockaddr2uaddr()
Date: Tue, 24 Oct 2023 23:58:20 +0200
Message-Id: <31b27c8e54f131b7eabcbd78573f0b5bfe380d8c.1698184674.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intent is to check if the strings' are truncated or not. So, >= should
be used instead of >, because strlcat() and snprintf() return the length of
the output, excluding the trailing NULL.

Fixes: a02d69261134 ("SUNRPC: Provide functions for managing universal addresses")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: Fix cut'n'paste typo in subject
    Add net in [PATCH...]
---
 net/sunrpc/addr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
index d435bffc6199..97ff11973c49 100644
--- a/net/sunrpc/addr.c
+++ b/net/sunrpc/addr.c
@@ -284,10 +284,10 @@ char *rpc_sockaddr2uaddr(const struct sockaddr *sap, gfp_t gfp_flags)
 	}
 
 	if (snprintf(portbuf, sizeof(portbuf),
-		     ".%u.%u", port >> 8, port & 0xff) > (int)sizeof(portbuf))
+		     ".%u.%u", port >> 8, port & 0xff) >= (int)sizeof(portbuf))
 		return NULL;
 
-	if (strlcat(addrbuf, portbuf, sizeof(addrbuf)) > sizeof(addrbuf))
+	if (strlcat(addrbuf, portbuf, sizeof(addrbuf)) >= sizeof(addrbuf))
 		return NULL;
 
 	return kstrdup(addrbuf, gfp_flags);
-- 
2.32.0


