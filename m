Return-Path: <netdev+bounces-32312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E8A79416C
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 18:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ABDC281399
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BB11096D;
	Wed,  6 Sep 2023 16:25:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D945010951
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 16:25:42 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4407199A;
	Wed,  6 Sep 2023 09:25:40 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1qdvLV-0007uu-8U; Wed, 06 Sep 2023 18:25:37 +0200
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	Wander Lairson Costa <wander@redhat.com>,
	Lucas Leong <wmliang@infosec.exchange>
Subject: [PATCH net 2/6] netfilter: nfnetlink_osf: avoid OOB read
Date: Wed,  6 Sep 2023 18:25:08 +0200
Message-ID: <20230906162525.11079-3-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906162525.11079-1-fw@strlen.de>
References: <20230906162525.11079-1-fw@strlen.de>
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

From: Wander Lairson Costa <wander@redhat.com>

The opt_num field is controlled by user mode and is not currently
validated inside the kernel. An attacker can take advantage of this to
trigger an OOB read and potentially leak information.

BUG: KASAN: slab-out-of-bounds in nf_osf_match_one+0xbed/0xd10 net/netfilter/nfnetlink_osf.c:88
Read of size 2 at addr ffff88804bc64272 by task poc/6431

CPU: 1 PID: 6431 Comm: poc Not tainted 6.0.0-rc4 #1
Call Trace:
 nf_osf_match_one+0xbed/0xd10 net/netfilter/nfnetlink_osf.c:88
 nf_osf_find+0x186/0x2f0 net/netfilter/nfnetlink_osf.c:281
 nft_osf_eval+0x37f/0x590 net/netfilter/nft_osf.c:47
 expr_call_ops_eval net/netfilter/nf_tables_core.c:214
 nft_do_chain+0x2b0/0x1490 net/netfilter/nf_tables_core.c:264
 nft_do_chain_ipv4+0x17c/0x1f0 net/netfilter/nft_chain_filter.c:23
 [..]

Also add validation to genre, subtype and version fields.

Fixes: 11eeef41d5f6 ("netfilter: passive OS fingerprint xtables match")
Reported-by: Lucas Leong <wmliang@infosec.exchange>
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nfnetlink_osf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index 8f1bfa6ccc2d..50723ba08289 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -315,6 +315,14 @@ static int nfnl_osf_add_callback(struct sk_buff *skb,
 
 	f = nla_data(osf_attrs[OSF_ATTR_FINGER]);
 
+	if (f->opt_num > ARRAY_SIZE(f->opt))
+		return -EINVAL;
+
+	if (!memchr(f->genre, 0, MAXGENRELEN) ||
+	    !memchr(f->subtype, 0, MAXGENRELEN) ||
+	    !memchr(f->version, 0, MAXGENRELEN))
+		return -EINVAL;
+
 	kf = kmalloc(sizeof(struct nf_osf_finger), GFP_KERNEL);
 	if (!kf)
 		return -ENOMEM;
-- 
2.41.0


