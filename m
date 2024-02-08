Return-Path: <netdev+bounces-70252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EE684E2D5
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43360285871
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7845878B51;
	Thu,  8 Feb 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y06kIv9n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FC777F33
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401537; cv=none; b=RMqdlR9SmaNYoH0YrHXOXvJKf1OAHisk1XmiYQiGEX72SZ3ut9UiLZgGdQFhCpjL2wI/qWAeir0S9PFeBmbbsluEtVWjhn6/FAcgXrzVQtuKjgbETd/1wbt3ejtgDOL1OaZRjVs63axfdiu4lIdRb75YVVd+dvjODSskAs07XGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401537; c=relaxed/simple;
	bh=gYx64TtFNjg0NgMf84vKuF0tmVyGVNffRKiRScpxPA8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=stvIO5KC8uQT37ksSZLBo145Km8kxr/u10XWq5XwQOVwDBBg4iq3L5qHZg6W7MP6LNavvVSp0SS9gm5+KeZDhWAHAecrLNuxrYnvFcfiillq+pdbw88RAq4orDZd184RE/PYIpbkOgOJPawd+G0SGYEF73V7DxlFqrl+2Xwc/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y06kIv9n; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b2682870so3210873276.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 06:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707401535; x=1708006335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+fAQG5Ja0UNWE7ZhBr8j5EMvlnKd6H2k2w5rwIFGf6Q=;
        b=y06kIv9nljWObfKZrUHq4ap/tbLPF9mzrBJB0GJa4BUxrvEPcjulqpd8ce/BmzL6Jn
         iVSZA/hIU0cLXt1B5hSjGj6kr9qgXk6PavQ5j2Z0RYQzOQuhGhhlsr8GpQF+RFMXuTFh
         WZ1j9UAmFgp1BkBGddyp/MZ0YWCxzkEC4ceBs6nQGYj26XGdKKig2Md1XpOl5yfh1bkP
         +H8iceae/On70Jw4+dvTsxxgHJ63sThTYYisyCWiOv4IJytix9SzaVIzWOD+pdK+U7Jw
         v8oQTSzaW39wqdPf8hNzn8Z4f0bZ4MlQw6BqeEesylOWgn03o7z96MR8hxSUnMMpg70u
         t00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401535; x=1708006335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fAQG5Ja0UNWE7ZhBr8j5EMvlnKd6H2k2w5rwIFGf6Q=;
        b=vq7571lxr9D/JhF3bRoBjNfRdQQOQgl0Wk1H95bWc4M1UzzH/jf4imO/usGoO1N36T
         YzpHF2ZpzilZ8ZBPmM+JFAcNxTO+BXGG4/j7zj9tQzwlX64Xz1G/t6zLUdpWbaAYV1Yh
         e1BmSXkWyRaVox+Wq+LEodbBkOiIXdKimrzRkG8ji06xGJRaHpjKAHk4n5tAUkSx8j02
         /0qaOP751zy2Ls7FsSUqMgbx2KQoEslLEbY8MVrekn4r/0ThZ4NhSJnmkg+Du8LPsSzl
         hsfFms1Wvh6l/ECLeVIYfQ+jCSDiRfjTAUQR9pUI6gv9LVYIOsdUaQGTAHju8T0mO0c9
         SvmQ==
X-Gm-Message-State: AOJu0Yx3aQ9Azy/CfF+TI0wt2TAxkxTgrQITh6Eg4PH3AsGpuxM+78iR
	Kipq0H+65v/SClUNzayuPUOYeM/NClleuKFJi3VeJNgIiNxRrEJPQh5wbzX1jgs88E5ZvWwDDk/
	ubG6SBtrrJQ==
X-Google-Smtp-Source: AGHT+IF/B63ApapA089euvnoHe7zHQYSEIQuEYhtywAXy5jQ9Pt7kmHFERfkOFnsfNxlCZw1B5M5ojEmtELqYg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:250c:b0:dc6:fec4:1c26 with SMTP
 id dt12-20020a056902250c00b00dc6fec41c26mr1970513ybb.1.1707401534831; Thu, 08
 Feb 2024 06:12:14 -0800 (PST)
Date: Thu,  8 Feb 2024 14:11:43 +0000
In-Reply-To: <20240208141154.1131622-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208141154.1131622-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208141154.1131622-3-edumazet@google.com>
Subject: [PATCH v2 net-next 02/13] ip_tunnel: annotate data-races around t->parms.link
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
index 00da0b80320fb514bca58de7cd13894ab49a2ca6..248eb2d9829b31f89b7700460e317bf88bf325d9 100644
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


