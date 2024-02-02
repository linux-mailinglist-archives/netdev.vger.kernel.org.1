Return-Path: <netdev+bounces-68623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5060E84765F
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D28D4B24A27
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5B614D458;
	Fri,  2 Feb 2024 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRibvTQM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF6D14D447
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895624; cv=none; b=WKxopz575J9xwAJYU/eEWmuuGu2YhdVMzMkvzlY+8ILBEtX4zN/EI755Kx1S8SAnZCaQutHABKJzVE5mxZcyk6ZwYMrwA0Bd6Mkw2YBXqbCxlsMKK23GqyqnuzqQponPkGGNfi7B44ueBigHxQ1sqdY1qrM+ByuEGp+FJTold2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895624; c=relaxed/simple;
	bh=JHINC854ia98PUJGcuLobWS/goCDxB+drerbt4+vUfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nc5fuRx9s+JtUR5qHyolO4sSdoiH6V+ezKb8iE9E+3WzV8gebAhK6PPzWOOF6ahyxV580P310NB0SJh/Ccg682FgMklGvyy4TDiUWniMJfmmtR+TtYktTwsJ8S1Ghz57mC99RPoQmYjJ5UqpQhKqFsB96ahDLMqb8qzGPDsEMy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hRibvTQM; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ba5fdf1aso3154129276.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706895622; x=1707500422; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ5+OvkCx7q7sa2Wuj/YvUBwdeuOFa3Bfx0+2rdMfyo=;
        b=hRibvTQMEigwO9ttIfIiE/w9BZ3t1Lthc4LuQbY+hm9iMhs8PLc6ZmFAd2FV2V39sH
         Q+8T2F0m1y9TVeg322XxWBmUccn3ivQrKboufGIeARy9zqo9J+DMLJSYOZVvci6XDIcg
         ByBH4UdTVZZbOCzU+KBN+BG0XUTaoN2g0exnKRp4s/K2XpXmLxNBYDsBza5H2i+wds/D
         FJHr3IlA32k3zVCS0QuspdYV2duWRL+qZKYNK6QORUwMvTKtt2BG79Pw7wSv0vjt9Dkj
         411HlRJOY5ZxAf2MTT0VZrabw1wo8vqIxVcg3eSDMWn3vkEvyEvzexrwzaVGT1IQwqWg
         D3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895622; x=1707500422;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ5+OvkCx7q7sa2Wuj/YvUBwdeuOFa3Bfx0+2rdMfyo=;
        b=s42qse4UlzccK4FIwFd7CfhtER60seeczVhoRWRvb71P3ZJdEbAxX6bJSIQ3kxegpH
         uT/CARJITloruXswTSH73u/rfge0uX0iNlnUMnKeGU2AP9GVwzyU82afl2GvaLu5JoWi
         F0ZOr947TX3x/3xhEBHjWFhBGJVHCexLqu93ANJ5as/ItIGZTyMFlbKCyTZlUSQGlwW2
         h4Wvf6iUCkdHYLgzf2zYSU54pmesKoK5tG9B6EwTydc0dqwAnqWfk/qdTIlOt8kdLV80
         J3HLr28f3h0bW1nLKQry8m9qkiMr/aG+C8jIfzR6i7u2L08YJEvAL+WeI/iOT5pE5+q/
         uSiQ==
X-Gm-Message-State: AOJu0Yy83FbeodQM6b0r8+7d0eXD3FioBHZWbQkORn6WzjtDjUuduYz1
	oFpxQQTk3PxosiUBiw8OYPGgW6Ubfjql/QJvBBxllGt344SklSUZc+FTZA8vVU3HjdMH44xh7Xn
	Bx67jJA1xxA==
X-Google-Smtp-Source: AGHT+IElsLyOiOViVDVH0ipFSeasfsFzKEtnvd+gysDq/vJwuTwMW7/tWE/KO4KgAE4cnn29L4A5PtLmMJkr7w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1604:b0:dbe:a0c2:df25 with SMTP
 id bw4-20020a056902160400b00dbea0c2df25mr144087ybb.8.1706895621914; Fri, 02
 Feb 2024 09:40:21 -0800 (PST)
Date: Fri,  2 Feb 2024 17:39:55 +0000
In-Reply-To: <20240202174001.3328528-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202174001.3328528-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202174001.3328528-11-edumazet@google.com>
Subject: [PATCH v2 net-next 10/16] ip6_gre: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_gre.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 070d87abf7c0284aa23043391aab080534e144a7..428f03e9da45ac323aa357b5a9d299fb7f3d3a5b 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1632,21 +1632,19 @@ static int __net_init ip6gre_init_net(struct net *net)
 	return err;
 }
 
-static void __net_exit ip6gre_exit_batch_net(struct list_head *net_list)
+static void __net_exit ip6gre_exit_batch_rtnl(struct list_head *net_list,
+					      struct list_head *dev_to_kill)
 {
 	struct net *net;
-	LIST_HEAD(list);
 
-	rtnl_lock();
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list)
-		ip6gre_destroy_tunnels(net, &list);
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		ip6gre_destroy_tunnels(net, dev_to_kill);
 }
 
 static struct pernet_operations ip6gre_net_ops = {
 	.init = ip6gre_init_net,
-	.exit_batch = ip6gre_exit_batch_net,
+	.exit_batch_rtnl = ip6gre_exit_batch_rtnl,
 	.id   = &ip6gre_net_id,
 	.size = sizeof(struct ip6gre_net),
 };
-- 
2.43.0.594.gd9cf4e227d-goog


