Return-Path: <netdev+bounces-247370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CF825CF8D6A
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 15:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D7E030069A9
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 14:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AE7322A2E;
	Tue,  6 Jan 2026 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1sq18a39"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4893148A5
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767710738; cv=none; b=Ea+hjALTAQwc2KeFXD56kt0L8ou0VMA4yeNawjNeV/OA4m8f2EP3+RgvPiKJvIYm4jUMI11XRhlKA0kkskB38UJi1oXIvg9lcaVH98ofE3N66G0CYlwvPHmLtyWOvQlOajpZ8Nj5OgBe+iNbe96QLJZ5GeoiGq8Qqzq6p6xLfS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767710738; c=relaxed/simple;
	bh=MXcN/pOAJwy4BtUAHs4dbprNtk0vHttBJQ8z8whRQR0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ptswQgua7tVVESQeYHF4ogiX4Xn6fmruStbjwhwHyJxQfnrSRjJULduRB+CPDQNl7CSOOIiRcdsjA6u4OmCiOEHhuLr7fIvuGm6UN8fXsldlfbCFOnnHtw+KSqRrKHrD95VkoeK42uIh5hWtk4lHRQVd3rOclqd3UVk9hJdAetw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1sq18a39; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-890805821c0so10462396d6.3
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 06:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767710733; x=1768315533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pPpBsNk/345S502djG+Ob/2775ms1T1oODTL8+aqf1U=;
        b=1sq18a39OXIr8fETWwjfI7f7pYHDlt/nQghLwLryNS33rkAjS9FFO6zMKScdGdFKoR
         MarIIukAN3vivKxT5IDYSG8SpSHZ04VrXYMylOCsB/tuIP9H6G+5K92+fJ9Vj15NMb2I
         6Um6z+gqC3Itjt0BNUoRNZNYBdX1QjNwWlLvqECKY5BcuH44aGR6KNb4SaAZWnUrvaiL
         i9gLXErpt+O5//VJwwPDQiq5wMAu2yl1cmLx80koEiekmo1e+Vte6y3xrOPmofuFI1Hh
         GO1u9wAyiAvBPTaD55bF4zsdp+S1WYOyX6ngCLtz6ddxx+y+0Jzt5lJUgGiQNuBYCpwv
         YiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767710733; x=1768315533;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pPpBsNk/345S502djG+Ob/2775ms1T1oODTL8+aqf1U=;
        b=PRgp4Hk3ZNTKDgmaESS6GoSNdcRQnOMfE+Uf0rg9Dxf80ww+F0X+NrqeTb2SWyZVMj
         PQt7s9PNeToce1ReRcVPdhQKBOsTXTnqEEL/wC2Vm8Xnn3udMpDoDxZGdYxCD3iJSTss
         sQzc7+iC8hXsQSbsCJXwLh14BDMxiPuR+jj574s+dQ2QQAmJAzu4OkQ3oeTrhhMNchkJ
         6MvubuNIJ3rZDxArv8qcqkINfpe83nyuB1+Yt0JenF0LSWuONL4ikekEp2RTdhPGgxs4
         OPbacMfKmLvbNtHfSL7PFofuCrSK06p0yZtRMQGRXQb229ZW39hifZ2AnaM6Npsx7hoH
         lp/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyhy1wALpkz1KerARRGPX7r3m5RHnypfnfXL314C6LYc2JbCslVRoP2CkZpKjoYRGSWz8SiWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBaSAQPC30CEgtfQNJXnmIcpUnYxole4ZDnVvDTMGgninCd9Cu
	/DSVOENCdlFxSOApWIpIUkvKhxoMkoPTcAW0ylf4SQ2/WZizWevKxs6GOLy2n9DuAnUBuV8yByy
	eHB0WIc3jyAhgjg==
X-Google-Smtp-Source: AGHT+IG+oKscXdo2XOFHEg5/gkpepE7H+30uzh6nWF4MDtrAjGCrH1N8gJzT3QD8Kr79qFwdABvBH6vuFhntZA==
X-Received: from qvbof4.prod.google.com ([2002:a05:6214:4344:b0:888:3b63:e0cb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:29ec:b0:880:47e0:19e8 with SMTP id 6a1803df08f44-89075ea5cbbmr47222816d6.42.1767710733442;
 Tue, 06 Jan 2026 06:45:33 -0800 (PST)
Date: Tue,  6 Jan 2026 14:45:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260106144529.1424886-1-edumazet@google.com>
Subject: [PATCH v2 net] ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com, 
	Mazin Al Haddad <mazin@getstate.dev>
Content-Type: text/plain; charset="UTF-8"

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
---
v2: invert the conditions (Jakub)
v1: https://lore.kernel.org/netdev/CANn89iK6uqJ8YEvzcz-EsS1piyay7hTdbC=S_z-Feho9YBeN_g@mail.gmail.com/T/#t

 net/ipv6/ip6_gre.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index d19d86ed43766bbc8ec052113be02ab231a5272c..ca1571c63f40f90dd4fd53b526b6c481087f8320 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -881,7 +881,7 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 	__be16 payload_protocol;
 	int ret;
 
-	if (!pskb_inet_may_pull(skb))
+	if (skb_vlan_inet_prepare(skb, false))
 		goto tx_err;
 
 	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
@@ -929,7 +929,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	__u32 mtu;
 	int nhoff;
 
-	if (!pskb_inet_may_pull(skb))
+	if (skb_vlan_inet_prepare(skb, false))
 		goto tx_err;
 
 	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
-- 
2.52.0.351.gbe84eed79e-goog


