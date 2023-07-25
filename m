Return-Path: <netdev+bounces-21078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DA47624BB
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D561C2087E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB51C26B9B;
	Tue, 25 Jul 2023 21:46:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF8226B83
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 21:46:50 +0000 (UTC)
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B81FDD;
	Tue, 25 Jul 2023 14:46:49 -0700 (PDT)
Received: from localhost.localdomain (unknown [46.242.14.200])
	by mail.ispras.ru (Postfix) with ESMTPSA id 3EF0A40737C9;
	Tue, 25 Jul 2023 21:46:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3EF0A40737C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1690321607;
	bh=wQZ+lrRE3oQnyK31lwk/xK6Rt/iFePrIWTkSITlap1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IapLk/WzMzB0LeUX1/U399YIXAH67f1o/o+ul/kZh3sDQszDWnGpRnvWqMQitoDL6
	 rj47I66xhQJk/BzORiThu7kwqOF2Hp1ocIhjFxYqINMdRypPVgFMQ8mZHN+u8TQ3c1
	 T15pDjqUfi8l/5xtFokIbvL0i7JzGS8LmNwODVRk=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jon Maloy <jmaloy@redhat.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] tipc: stop tipc crypto on failure in tipc_node_create
Date: Wed, 26 Jul 2023 00:46:25 +0300
Message-ID: <20230725214628.25246-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cyninzffkwhc7mqbxpwhhpm7bav67tp7a7rqkpeu5bh3kafbyo@wx3q2x5nm3he>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If tipc_link_bc_create() fails inside tipc_node_create() for a newly
allocated tipc node then we should stop its tipc crypto and free the
resources allocated with a call to tipc_crypto_start().

As the node ref is initialized to one to that point, just put the ref on
tipc_link_bc_create() error case that would lead to tipc_node_free() be
eventually executed and properly clean the node and its crypto resources.

Found by Linux Verification Center (linuxtesting.org).

Fixes: cb8092d70a6f ("tipc: move bc link creation back to tipc_node_create")
Suggested-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
v1->v2: simplify the patch per Xin Long's advice: putting the ref on error
case would solve the problem more conveniently; update the patch
description accordingly.

 net/tipc/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 5e000fde8067..a9c5b6594889 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -583,7 +583,7 @@ struct tipc_node *tipc_node_create(struct net *net, u32 addr, u8 *peer_id,
 				 n->capabilities, &n->bc_entry.inputq1,
 				 &n->bc_entry.namedq, snd_l, &n->bc_entry.link)) {
 		pr_warn("Broadcast rcv link creation failed, no memory\n");
-		kfree(n);
+		tipc_node_put(n);
 		n = NULL;
 		goto exit;
 	}
-- 
2.41.0


