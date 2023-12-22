Return-Path: <netdev+bounces-59898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C405381C980
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 12:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F1E1F2459C
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 11:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A22517753;
	Fri, 22 Dec 2023 11:57:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB80182BB;
	Fri, 22 Dec 2023 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 5/8] netfilter: flowtable: reorder nf_flowtable struct members
Date: Fri, 22 Dec 2023 12:57:11 +0100
Message-Id: <20231222115714.364393-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231222115714.364393-1-pablo@netfilter.org>
References: <20231222115714.364393-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

Place the read-mostly parts accessed by the datapath first.

In particular, we do access ->flags member (to see if HW offload
is enabled) for every single packet, but this is placed in the 5th
cacheline.

priority could stay where it is, but move it too to cover a hole.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_flow_table.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 692d5955911c..956c752ceb31 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -74,12 +74,13 @@ enum nf_flowtable_flags {
 };
 
 struct nf_flowtable {
-	struct list_head		list;
-	struct rhashtable		rhashtable;
-	int				priority;
+	unsigned int			flags;		/* readonly in datapath */
+	int				priority;	/* control path (padding hole) */
+	struct rhashtable		rhashtable;	/* datapath, read-mostly members come first */
+
+	struct list_head		list;		/* slowpath parts */
 	const struct nf_flowtable_type	*type;
 	struct delayed_work		gc_work;
-	unsigned int			flags;
 	struct flow_block		flow_block;
 	struct rw_semaphore		flow_block_lock; /* Guards flow_block */
 	possible_net_t			net;
-- 
2.30.2


