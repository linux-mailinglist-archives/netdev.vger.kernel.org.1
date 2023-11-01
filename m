Return-Path: <netdev+bounces-45504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7307E7DDAA0
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 02:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3811C20D04
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 01:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF46C7EB;
	Wed,  1 Nov 2023 01:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0890365F
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 01:34:03 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3822F5;
	Tue, 31 Oct 2023 18:33:56 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VvIs3FX_1698802432;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VvIs3FX_1698802432)
          by smtp.aliyun-inc.com;
          Wed, 01 Nov 2023 09:33:53 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	fw@strlen.de,
	kadlec@netfilter.org,
	pablo@netfilter.org
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH net-next] netfilter: nf_tables: Remove unused variable nft_net
Date: Wed,  1 Nov 2023 09:33:51 +0800
Message-Id: <20231101013351.55902-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=n
Content-Transfer-Encoding: 8bit

The code that uses nft_net has been removed, and the nft_pernet function
is merely obtaining a reference to shared data through the net pointer.
The content of the net pointer is not modified or changed, so both of
them should be removed.

silence the warning:
net/netfilter/nft_set_rbtree.c:627:26: warning: variable ‘nft_net’ set but not used

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7103
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 net/netfilter/nft_set_rbtree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 6f1186abd47b..baa3fea4fe65 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -624,14 +624,12 @@ static void nft_rbtree_gc(struct nft_set *set)
 {
 	struct nft_rbtree *priv = nft_set_priv(set);
 	struct nft_rbtree_elem *rbe, *rbe_end = NULL;
-	struct nftables_pernet *nft_net;
 	struct rb_node *node, *next;
 	struct nft_trans_gc *gc;
 	struct net *net;
 
 	set  = nft_set_container_of(priv);
 	net  = read_pnet(&set->net);
-	nft_net = nft_pernet(net);
 
 	gc = nft_trans_gc_alloc(set, 0, GFP_KERNEL);
 	if (!gc)
-- 
2.20.1.7.g153144c


