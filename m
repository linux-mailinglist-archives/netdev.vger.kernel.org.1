Return-Path: <netdev+bounces-69840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6E084CCAA
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D0C2874D4
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE8F7CF3F;
	Wed,  7 Feb 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CIX4Ep6g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5EE7CF14
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316000; cv=none; b=jmoKHFRt0mvAKfCs/sK91K+7g4549aj+VQRj+d59S7t038x8IdCwHeHeuD25wvZgdE5dXq9D53mL6rEQ8knJFA0DAaJLubp4yGgPT92FmMrPODCVCGPb0jmz5A5FWIxiZHPxVS0vI8N+tNIwFPX9ffINo0YJFVtLuLyuaJiMe/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316000; c=relaxed/simple;
	bh=MWtTgsxhutPcqcXre+qqC5H0nTEtGjJi7lOZLnMu+Is=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FgE0xhaCUm0Fjb+yV/HUbNz+q1Pahy6RUyhyyrpwWZfvem/DKp6gD08TMflD/fIhOgKBeTAQSQUUPRj8149JzWDWfatNhWo8YH/LPf4gtXPE4ratJweDd7UqmZJz8YVSROK481Oi3HQy/IP6XFwxbjiVw00JTEAhqNUuR+B5YBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CIX4Ep6g; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047fed0132so10963397b3.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 06:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707315997; x=1707920797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QH7GbxV9un5ZUeFNIDqMG4Bfo0qY582NX2C+vc8PuS0=;
        b=CIX4Ep6gKOjEeAEC4DcTof6ed+YwoSeohhPgscf6Y8I7GwREe30lEmwuE8/hDg4O2s
         v2/EkXkukj41Gj1WrMVOSczB6yO0xpCIWWOviuuT4BGsXphk71+nNLNKEdmVfhFToGS8
         xLF8sspT0FY3vbuNWgPgmbgYMkI8ZXNda9ttV86tkuN9P4vLkac2mlPuerqeEX6xWv80
         R4UtSINooHS5HafObdznhBwHcWkDO5ksfO7FCSJAa+T5ycb/i8o3w7e6m/7Ayvl1LHM3
         eMDrT7oRlB7vZcDia6S8b1OIymN6P8FJO7TzI/ZL6XL+h3a/EbdCBLoWJoRPd8AhGPJ6
         j/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315997; x=1707920797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QH7GbxV9un5ZUeFNIDqMG4Bfo0qY582NX2C+vc8PuS0=;
        b=phslTfvTY80UShozP1myQJQvD/djRhcJh+047fmbeRTkuV+SO2Kztra7e9axUyu7np
         jrC7dhyqeIqA6RHafMquTBaIyf6RgeDGmGgMdGC5QWOFpF79IVT33mrfCrAz7joEz+yT
         2K9ZSRFAib3EhQBbK2NS/tF6aItuQF50kgHpx0v7KWwoc5w1EzhbEW61DswI6i14y/aX
         tVLdhXutJRTr0XauzjLHT+MF3nJimNYC3kWFZvSNGFvK+c9N6pRLlk4a5uquM9my+77e
         KA10KIp2DF5KTyW51hHRrkKa/T1sO6Sj/twNb6TRfpgasLvJ/iD6DbG/sP8KjYPD+Po5
         U8og==
X-Gm-Message-State: AOJu0YwTJVh+aeXHUDi5WpbuhhbZx6E+v06I18owkyHbo2R2dLqtEMzQ
	lNXuSo+wBKUp4qbTBmZv0JN9YyqmiOHCtwKVUVX3DxyunN40QAnI94NmimkBa08dJ29ubM7UmKg
	Xq/uk1o9q1A==
X-Google-Smtp-Source: AGHT+IE5MvGb0Mkm31b+qS7ca64gZa6kMazlz3zQJKt4HiGp6uKIM2pMFf4SUo/tsIdMaSyQh2LH56PRNUM5Vw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:9bc4:0:b0:5f8:e803:4b0d with SMTP id
 s187-20020a819bc4000000b005f8e8034b0dmr884801ywg.2.1707315997601; Wed, 07 Feb
 2024 06:26:37 -0800 (PST)
Date: Wed,  7 Feb 2024 14:26:18 +0000
In-Reply-To: <20240207142629.3456570-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207142629.3456570-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207142629.3456570-3-edumazet@google.com>
Subject: [PATCH net-next 02/13] ip_tunnel: annotate data-races around t->parms.link
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

t->parms.link is read locklessly, annotate these reads
and opposite writes accordingly.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_tunnel.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index beeae624c412d752bd5ee5d459a88f57640445e9..b8e846b2863741903528a41126cf29419ed63324 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -102,10 +102,9 @@ struct ip_tunnel *ip_tunnel_lookup(struct ip_tunnel_net *itn,
 		if (!ip_tunnel_key_match(&t->parms, flags, key))
 			continue;
 
-		if (t->parms.link == link)
+		if (READ_ONCE(t->parms.link) == link)
 			return t;
-		else
-			cand = t;
+		cand = t;
 	}
 
 	hlist_for_each_entry_rcu(t, head, hash_node) {
@@ -117,9 +116,9 @@ struct ip_tunnel *ip_tunnel_lookup(struct ip_tunnel_net *itn,
 		if (!ip_tunnel_key_match(&t->parms, flags, key))
 			continue;
 
-		if (t->parms.link == link)
+		if (READ_ONCE(t->parms.link) == link)
 			return t;
-		else if (!cand)
+		if (!cand)
 			cand = t;
 	}
 
@@ -137,9 +136,9 @@ struct ip_tunnel *ip_tunnel_lookup(struct ip_tunnel_net *itn,
 		if (!ip_tunnel_key_match(&t->parms, flags, key))
 			continue;
 
-		if (t->parms.link == link)
+		if (READ_ONCE(t->parms.link) == link)
 			return t;
-		else if (!cand)
+		if (!cand)
 			cand = t;
 	}
 
@@ -150,9 +149,9 @@ struct ip_tunnel *ip_tunnel_lookup(struct ip_tunnel_net *itn,
 		    !(t->dev->flags & IFF_UP))
 			continue;
 
-		if (t->parms.link == link)
+		if (READ_ONCE(t->parms.link) == link)
 			return t;
-		else if (!cand)
+		if (!cand)
 			cand = t;
 	}
 
@@ -221,7 +220,7 @@ static struct ip_tunnel *ip_tunnel_find(struct ip_tunnel_net *itn,
 	hlist_for_each_entry_rcu(t, head, hash_node) {
 		if (local == t->parms.iph.saddr &&
 		    remote == t->parms.iph.daddr &&
-		    link == t->parms.link &&
+		    link == READ_ONCE(t->parms.link) &&
 		    type == t->dev->type &&
 		    ip_tunnel_key_match(&t->parms, flags, key))
 			break;
@@ -747,7 +746,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	ip_tunnel_init_flow(&fl4, protocol, dst, tnl_params->saddr,
 			    tunnel->parms.o_key, RT_TOS(tos),
-			    dev_net(dev), tunnel->parms.link,
+			    dev_net(dev), READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
 	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
@@ -867,7 +866,7 @@ static void ip_tunnel_update(struct ip_tunnel_net *itn,
 	if (t->parms.link != p->link || t->fwmark != fwmark) {
 		int mtu;
 
-		t->parms.link = p->link;
+		WRITE_ONCE(t->parms.link, p->link);
 		t->fwmark = fwmark;
 		mtu = ip_tunnel_bind_dev(dev);
 		if (set_mtu)
@@ -1057,9 +1056,9 @@ EXPORT_SYMBOL(ip_tunnel_get_link_net);
 
 int ip_tunnel_get_iflink(const struct net_device *dev)
 {
-	struct ip_tunnel *tunnel = netdev_priv(dev);
+	const struct ip_tunnel *tunnel = netdev_priv(dev);
 
-	return tunnel->parms.link;
+	return READ_ONCE(tunnel->parms.link);
 }
 EXPORT_SYMBOL(ip_tunnel_get_iflink);
 
-- 
2.43.0.594.gd9cf4e227d-goog


