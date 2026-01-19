Return-Path: <netdev+bounces-251053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13357D3A6D1
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 12:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0917830111B3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 11:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A445A3002DF;
	Mon, 19 Jan 2026 11:25:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6572874FB
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821926; cv=none; b=O8xZ3YRp3tEzblMqxGaZbLrhCBwhHHs2x3UCSS43HqHAxtGs5JmdrVgaPh3SKrUIwjAyFT5LVceccMiY4fPW5j2RtlpWEJB6yLHfGk1Yt8OthNByZNoUqBj7r4h3cNvi+CE96Ajrue7k2l3h0fpdSwW8KgmYmfD3h6WzyF9QAEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821926; c=relaxed/simple;
	bh=aXXiH49T2A1CqqiQCLM0VkMEdzY/vVX7tPqXm5+0lg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lWgUdA1h9LSTlOsc5U/LobGF46DmeVyY5Nf6lcH4xre/NDpayLfXSYPCr5teeDL6qbyjfvvAQherHpQ8LQniTi4UVoh4MqU1QXMuPVu0FlaYSxvGdpH0GFaBofVsYvyioEcrb+qT6LS2ten2l3j9Qzh9/ZZvo/laWv++1cVnlk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id CE339603A1; Mon, 19 Jan 2026 12:25:22 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: pabeni@redhat.com,
	syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Mazin Al Haddad <mazin@getstate.dev>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH net v3] ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()
Date: Mon, 19 Jan 2026 12:24:57 +0100
Message-ID: <20260119112512.28196-1-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

I added skb_vlan_inet_prepare() helper in the cited commit, hinting
that we would need to use it more broadly.

syzbot confirmed this was the case in ip6_gre.

uninit-value in ip6table_mangle_hook+0x97d/0x9c0 net/ipv6/netfilter/ip6table_mangle.c:72
 ip6t_mangle_out net/ipv6/netfilter/ip6table_mangle.c:56 [inline]
 ip6table_mangle_hook+0x97d/0x9c0 net/ipv6/netfilter/ip6table_mangle.c:72
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xf4/0x400 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 __ip6_local_out+0x5ac/0x640 net/ipv6/output_core.c:143
 ip6_local_out+0x4c/0x210 net/ipv6/output_core.c:153
 ip6tunnel_xmit+0x129/0x460 include/net/ip6_tunnel.h:161
 ip6_tnl_xmit+0x341a/0x3860 net/ipv6/ip6_tunnel.c:1281

Uninit was stored to memory at:
 ip6_tnl_xmit+0x34f7/0x3860 net/ipv6/ip6_tunnel.c:1277
 __gre6_xmit+0x14b9/0x1550 net/ipv6/ip6_gre.c:815
 ip6gre_xmit_ipv4 net/ipv6/ip6_gre.c:839 [inline]
 ip6gre_tunnel_xmit+0x18f7/0x2030 net/ipv6/ip6_gre.c:922

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4091 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_node_track_caller_noprof+0x6c7/0xf90 mm/slub.c:4283
 kmalloc_reserve+0x23e/0x4a0 net/core/skbuff.c:609
 pskb_expand_head+0x226/0x1a60 net/core/skbuff.c:2275
 skb_realloc_headroom+0x140/0x2b0 net/core/skbuff.c:2355
 ip6_tnl_xmit+0x2106/0x3860 net/ipv6/ip6_tunnel.c:1227
 __gre6_xmit+0x14b9/0x1550 net/ipv6/ip6_gre.c:815
 ip6gre_xmit_ipv4 net/ipv6/ip6_gre.c:839 [inline]
 ip6gre_tunnel_xmit+0x18f7/0x2030 net/ipv6/ip6_gre.c:922

Fixes: d8a6213d70ac ("geneve: fix header validation in geneve[6]_xmit_skb")
Reported-by: syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mazin Al Haddad <mazin@getstate.dev>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v3: pass 'true' argument to skb_vlan_inet_prepare to not change network
 header offset.

 net/ipv6/ip6_gre.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index d19d86ed4376..9e214c355e6c 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -881,7 +881,7 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 	__be16 payload_protocol;
 	int ret;
 
-	if (!pskb_inet_may_pull(skb))
+	if (skb_vlan_inet_prepare(skb, true))
 		goto tx_err;
 
 	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
@@ -929,7 +929,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	__u32 mtu;
 	int nhoff;
 
-	if (!pskb_inet_may_pull(skb))
+	if (skb_vlan_inet_prepare(skb, true))
 		goto tx_err;
 
 	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
-- 
2.52.0


