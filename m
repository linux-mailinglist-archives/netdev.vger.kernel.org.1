Return-Path: <netdev+bounces-70643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE85A84FDB5
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C4A1F2998D
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B479B611E;
	Fri,  9 Feb 2024 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xdz7meRw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D73610D
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510917; cv=none; b=aPUGf9Crqunv/vRoJkgeY1YzheNkYb+CkIxH1JfGrziC/7HUniAxDUyaHB6hY7P6nXwRweKlvKr1D7FbKT8yrzXiPmPsWZ3kyuhf2+o16zYdKEvrx8aGcb1W08q51DG/jYaFlIt3IVrpqQGjyCmcO5jkbt8LqPej0p6soWBIoEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510917; c=relaxed/simple;
	bh=GTbkbCA5bdwhJciFRe6AaAz0OxCe0Kt6owl98OPMuxM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fuwhgw1XfB4RLCbEIm2WOaTDLP0hSDN8A3F15pHDAaOwwE7YKz8rjB8d+nrU5cKiZ9F7yRwGVZsg3tZK5N6zrehEYPa/2640sQ37aSTo+q4MRc3EzukyN0m3x2pRO7rRgTP1s5Pt471A+9Rod4E/M4Y48lCyOJWakULtfq6Vua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xdz7meRw; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc7441509bdso1773013276.3
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 12:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707510915; x=1708115715; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=to+/9xcAr+X14yJQKJlLGBRFNzvqzZuEv3ILo1LuoXw=;
        b=xdz7meRwJ0FcU919qf7h1bk5I6t7Ow9+Q83Re6wk30D98W9E8DF2zlMc94AaZutrue
         07RdID3CHZ5htlgnpTSWCHh8dCebIDodWwNaYB6CtYl3o9HsOrxkFFODQQ6XWyhJY2w/
         l69S6FRz3cYDvcgMciTCT63/u2I5tRRvMcKEKA0TAihG04Err4acygOgVFqCTH9qe42m
         ACJP4P77vYGV9vKtIDdQ0Djy2g6w4dnL9K3fjRuuW0k45ypb1Sz4RvuAzKhB/t85Ai0K
         yC3KgaQibOmmRokRZLsKWwTfsjgMCQ/S6gd3bGKebf9KreVxEyq2BqcaMWcCpHwnbwer
         0cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510915; x=1708115715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=to+/9xcAr+X14yJQKJlLGBRFNzvqzZuEv3ILo1LuoXw=;
        b=Hq6NY1FqprkJeqgo8/CSWtTRfTFZdPs40WFbzkE1jsOz/Av2vYeGzcE72XSwZE5RGi
         Rn/JIBEQpZDeXJtYrN/5KDl5ExFJvkFvxx5//Jhs7h1qTXkv9XeQKAix48yx0g7em6UC
         y2lz0MOjQWFykDjekTgCzPReYAReZYbC8wDITHGX++lCNDP9/IgcJi26aKrFSjKknkyi
         Pbr0ooAtqQLp0jMQ0XuX/YSWZgcF1xO4E+D3XjJqiipr0CSnc4fhSTMRAo5saCoJMnrt
         gV5P9JyRjmrumUdpXilPJR/dl7tG6DBzEMkwdgBykFWP9MTO/w3ME3URpyKPxTC5h6Vj
         rVfg==
X-Gm-Message-State: AOJu0YwlZugxgGdzOmPRhZHPpA8gKF9KMFL3+Yyfji2kvGFAbkfonw4E
	pO2/Hc8d4ggAfxDJXn193MKxuB3O9BsT8Ni6Ms3v+PFC1JncS7MuTsDJD8A7oqjZO5mnH/p8HMH
	8vLuL+raStg==
X-Google-Smtp-Source: AGHT+IHJJBrEN5PSgmzBQDGuw2gM2QADo/cLEL1FoYTufWqGdcZA7cmvbVuKzoVb0hiyOk/938tNWCqLoi2lOQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1547:b0:dbe:32b0:9250 with SMTP
 id r7-20020a056902154700b00dbe32b09250mr9163ybu.0.1707510915181; Fri, 09 Feb
 2024 12:35:15 -0800 (PST)
Date: Fri,  9 Feb 2024 20:34:27 +0000
In-Reply-To: <20240209203428.307351-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209203428.307351-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209203428.307351-13-edumazet@google.com>
Subject: [PATCH v3 net-next 12/13] net: remove dev_base_lock from
 register_netdevice() and friends.
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

RTNL already protects writes to dev->reg_state, we no longer need to hold
dev_base_lock to protect the readers.

unlist_netdevice() second argument can be removed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0c158dd534f80c46e66c890628be9a876e85068a..a1cb7d3cab2c521fc28bd5f522c147bffca8d15e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -412,7 +412,7 @@ static void list_netdevice(struct net_device *dev)
 /* Device list removal
  * caller must respect a RCU grace period before freeing/reusing dev
  */
-static void unlist_netdevice(struct net_device *dev, bool lock)
+static void unlist_netdevice(struct net_device *dev)
 {
 	struct netdev_name_node *name_node;
 	struct net *net = dev_net(dev);
@@ -425,13 +425,11 @@ static void unlist_netdevice(struct net_device *dev, bool lock)
 		netdev_name_node_del(name_node);
 
 	/* Unlink dev from the device chain */
-	if (lock)
-		write_lock(&dev_base_lock);
+	write_lock(&dev_base_lock);
 	list_del_rcu(&dev->dev_list);
 	netdev_name_node_del(dev->name_node);
 	hlist_del_rcu(&dev->index_hlist);
-	if (lock)
-		write_unlock(&dev_base_lock);
+	write_unlock(&dev_base_lock);
 
 	dev_base_seq_inc(dev_net(dev));
 }
@@ -10296,9 +10294,9 @@ int register_netdevice(struct net_device *dev)
 		goto err_ifindex_release;
 
 	ret = netdev_register_kobject(dev);
-	write_lock(&dev_base_lock);
+
 	WRITE_ONCE(dev->reg_state, ret ? NETREG_UNREGISTERED : NETREG_REGISTERED);
-	write_unlock(&dev_base_lock);
+
 	if (ret)
 		goto err_uninit_notify;
 
@@ -10587,9 +10585,7 @@ void netdev_run_todo(void)
 			continue;
 		}
 
-		write_lock(&dev_base_lock);
 		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
-		write_unlock(&dev_base_lock);
 		linkwatch_sync_dev(dev);
 	}
 
@@ -11096,10 +11092,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
 
 	list_for_each_entry(dev, head, unreg_list) {
 		/* And unlink it from device chain. */
-		write_lock(&dev_base_lock);
-		unlist_netdevice(dev, false);
+		unlist_netdevice(dev);
 		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERING);
-		write_unlock(&dev_base_lock);
 	}
 	flush_all_backlogs();
 
@@ -11281,7 +11275,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	dev_close(dev);
 
 	/* And unlink it from device chain */
-	unlist_netdevice(dev, true);
+	unlist_netdevice(dev);
 
 	synchronize_net();
 
-- 
2.43.0.687.g38aa6559b0-goog


