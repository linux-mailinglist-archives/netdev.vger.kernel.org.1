Return-Path: <netdev+bounces-246964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DA4CF2E6F
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 11:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D27B3011FA9
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 10:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6FD27990A;
	Mon,  5 Jan 2026 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nzev9RXC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3EC2749D9
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767607414; cv=none; b=fAyw++LtJCK3ctriZz5bvIREXJZ2ofzsSbWj8JEP3hI2THhW8p1Eytr7Bzua+0gWALfLaWhLzGA6aJLQvgOnpmVni8TOIhMaFkCVTP/j7gQCPuexcZayX+NiK4OotPZVFZxTVi/Imuvt3DVUBsfkg9nFz71U03EfB6HTI7XMlF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767607414; c=relaxed/simple;
	bh=UkMJsyPxu5wZC2gSP2BTBPTJenzrzaC7Ljt/tugsW/I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZvorQ+RvHwcY3a2xdTDmbydPDcCzw+aNwNS3DwPMHCSQOBfPM8X4QjE12tJMCnOYa4fpKBDcoK6a8oAzTvgrNnVHznMEc/GD+w0o6s2nRMIsMo0kFgHdKiaVVKFxSPF9ARL8ok2WfoGouSq4hR3gBY75MUnk3EbSMpECl8fXaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nzev9RXC; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8804b991a54so547191326d6.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 02:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767607411; x=1768212211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O3sEY+alX9xOajG9RPr79z5+lV9tvG12puxk9oFKx/E=;
        b=nzev9RXCzglXxfbcjRPv6jqtve0CZBEkSih0CP7MvXsGfLS1ETqdxiZwdug+f7H3l/
         pWwBkRpTReblr8uYf7mdRcOnBb1dMo3vEY2BAa2eLjO4DLUtAsxamLA3RTvwcjD57OxF
         MmDil6LrlmiwkGvkzOdoX3CoYybOjLzjGAzqzzoXldb5pBXk4RJ0YnHSpMK8z+hNK+EM
         bBMIX+NPqbg0aIRrhOFhYHRd2i5J63iip5LSqu1fY6JqbS12Z8XOZUPLQHU7MZUQKAt2
         KiPyjJVQUyaOt8ACM5QyfawxWH/rVoR/H9v1hZjOXclzRBUePGKicEP8QeXxFwW2J3xL
         HE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767607411; x=1768212211;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O3sEY+alX9xOajG9RPr79z5+lV9tvG12puxk9oFKx/E=;
        b=RlMeVDxsB4obd7F9CiRfmAkujSaCrX970JdyskdiW/oXbt9Kivu9meSioNZpR9n3E8
         1GcNMQz8XA1TQ9j89AzuefbVaVR+QmTrEpPNrAZcBmfJ2cMvKRId9KU2sv2JJhJsriYs
         2Duc/GElf+yaEITO5CdkdI2UQaifRMEVlBdrOuo4gNb4AA0lL7mi5PvQ2ZQGLUhmVQd8
         fuvicGzD7RPM8IXrbVzungKe7EnzgHnitX7rYHJ+c4jKEEVur6Fck4/R4/A2WvHlN6ta
         WL4ixZ7VnI9Tm46Ec4cOPWs0HNEU9j/Px/ndn1FN0YjAkutPEMgYjU6ghmUvrzpTKjJ1
         wxBA==
X-Forwarded-Encrypted: i=1; AJvYcCUUmFjMOz2wyKMtVNujsBGWbS7+z1O5tPBZrToAktVDN7oth6I+aezEX0MSqauFfw1G3AFqC44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX+aLugU9perIiS3op4oKetASmnvNi6MtrhCLq3jPFLArP6i23
	Y8QZtKQOojbhxHfm2EZEYzW+HJUcZLFbYLuYMBhQ03mnGFm0crpwzWSEVysGzbc61/R7Abg2mBm
	Yo/Gsq5onkpfGqA==
X-Google-Smtp-Source: AGHT+IFu6hglbEcHmT9+jMgkGNEG4hgITaIsnM9n+cKCxvX5RlrOvnvh9XOukoJtzuoMKXfwS+/f7QpLEwA89w==
X-Received: from qvlh5.prod.google.com ([2002:a0c:f405:0:b0:88f:cdfb:3c2c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:108:b0:4ee:c1a:f11f with SMTP id d75a77b69052e-4f4abdd30demr711584511cf.84.1767607411525;
 Mon, 05 Jan 2026 02:03:31 -0800 (PST)
Date: Mon,  5 Jan 2026 10:03:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260105100330.2258612-1-edumazet@google.com>
Subject: [PATCH net] ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()
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
 net/ipv6/ip6_gre.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index d19d86ed4376..8b06ba058bde 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -881,7 +881,7 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 	__be16 payload_protocol;
 	int ret;
 
-	if (!pskb_inet_may_pull(skb))
+	if (!skb_vlan_inet_prepare(skb, false))
 		goto tx_err;
 
 	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
@@ -929,7 +929,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	__u32 mtu;
 	int nhoff;
 
-	if (!pskb_inet_may_pull(skb))
+	if (!skb_vlan_inet_prepare(skb, false))
 		goto tx_err;
 
 	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
-- 
2.52.0.351.gbe84eed79e-goog


