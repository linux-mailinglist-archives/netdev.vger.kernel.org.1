Return-Path: <netdev+bounces-68615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A44CF847656
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75FA1C211AB
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2192214C5A4;
	Fri,  2 Feb 2024 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WIb0tvDJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A4614AD3A
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895613; cv=none; b=FEfP80LcF42Yyy1FgbijcP0rYALJI+Cqb63rs9Mkfkpj0UwGfy8yw0a3pMyuJzlo+cvVI5Hsl+m1FJqoza4SJ/bhSzhD682XVB+xBWzdc685DnYGlDYs4MsRqlM87X1gxfxSVBI/rnMfyE5qcD2j6RY3zGkxm93DL0GWDwiUHVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895613; c=relaxed/simple;
	bh=vPm6pRfPkizcwo9J6YgQaA07StlJsDdt+GI12hUd+jg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s17ZFHF21DbXmsSPQgmWy+8ulaDxQWfDmzv1+CymbzEgr6RdRzuGPRpXfdjjHRJbn7J9fGI2vcAni3SO1i56rK06Ii+8nVybuST2cG07+03KrCIi2YEABbqUFGz6uh0ZmL2y+bW/rA/VswxzUj+4vXAgNAwU8KeDclsIaP7eej8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WIb0tvDJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6041bb56dbfso34443967b3.2
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706895610; x=1707500410; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Fia+sb8RWUNVXU3q1v1Z4jGJuuRjbjpwW2R8X5o5BY=;
        b=WIb0tvDJKWLg+LbTfR3lyckYnbPaEAlUjvyDmPkW80CokmzI0m65ZUnVCWkdvg452z
         50KjZ+IkwZrK3247Z2KLsOTnxx4Le5PytKBtJrYyGMwdrhb4zyEiJqJ1eygWINfrcpO7
         i8I06VtcZ00kxL0Z9yMnKLD4V/8md/KVuPhSqVq87+nPscI7yDr1E2PAb1+ZEliEJdNr
         UzqBZMfUFqQQkIqvhKb9KqalAxzuwCnUCufT+pYKDqq3U+lSrxRwQpOTac2BW2c91apx
         ZnxCUxK2pzH8FanahaZZl/H87jrPBkkk855xzr2u+3/GKyDjYtUYTMST1xBvmO5Uti1y
         nPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895610; x=1707500410;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Fia+sb8RWUNVXU3q1v1Z4jGJuuRjbjpwW2R8X5o5BY=;
        b=aRzRPqXW3O1lGi735N1g7oYIPnW/Hj/eqFdnWaAhraBm90Gx1KvAPnkGbNUBB7KxpX
         Nnd0m5s2xmKYNJ4hH6zxptl5SKmELDcYBF8XqV3YpEJzWAQN6oZJb03kgcCk/dl9TO5Q
         hwoZose9u7MC1NR5ERiu5hRaOv/8hyqe+yO3PnWez/oCG4F6P8vU7i1cHxBo/BlFWX2Y
         aAdOaOmrHNO730npHQN6Gjn5u2aOWKwa5eFnxI6kOWjMtnX/FBIf4zGtNJkVrJtAqJqF
         dvF9yGiRJeT1kSTLRugz2w7km6EisIT9gfbcmkoZFsgev2mqVUI0GzOuXs7LaM2J1LnD
         RpRQ==
X-Gm-Message-State: AOJu0Yx97lOZ7g8thxcyq4n12okrscdQMwIbcBA9YR5T3Qs7oDmvMZii
	eLKn5o794nNLyrCYtNXL0mAivOXr5aE0spFEoP0OIR7GsXJIPTym/uB1y+FJss0TXYnC6Ce861O
	4cXEYPJzwCQ==
X-Google-Smtp-Source: AGHT+IEu5M8Nvw/5dvkpFGExttdmk5doFuBwvHAp28q/8vkhhkjcu4kzVovLdsmD+uQofTQg0Zphx58Lcvdvtg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2612:b0:dbe:30cd:8fcb with SMTP
 id dw18-20020a056902261200b00dbe30cd8fcbmr209748ybb.0.1706895610639; Fri, 02
 Feb 2024 09:40:10 -0800 (PST)
Date: Fri,  2 Feb 2024 17:39:47 +0000
In-Reply-To: <20240202174001.3328528-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202174001.3328528-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202174001.3328528-3-edumazet@google.com>
Subject: [PATCH v2 net-next 02/16] nexthop: convert nexthop_net_exit_batch to
 exit_batch_rtnl method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held.

This saves one rtnl_lock()/rtnl_unlock() pair.

We also need to create nexthop_net_exit()
to make sure net->nexthop.devhash is not freed too soon,
otherwise we will not be able to unregister netdev
from exit_batch_rtnl() methods.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/nexthop.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index bbff68b5b5d4a1d835c9785fbe84f4cab32a1db0..7270a8631406c508eebf85c42eb29a5268d7d7cf 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3737,16 +3737,20 @@ void nexthop_res_grp_activity_update(struct net *net, u32 id, u16 num_buckets,
 }
 EXPORT_SYMBOL(nexthop_res_grp_activity_update);
 
-static void __net_exit nexthop_net_exit_batch(struct list_head *net_list)
+static void __net_exit nexthop_net_exit_batch_rtnl(struct list_head *net_list,
+						   struct list_head *dev_to_kill)
 {
 	struct net *net;
 
-	rtnl_lock();
-	list_for_each_entry(net, net_list, exit_list) {
+	ASSERT_RTNL();
+	list_for_each_entry(net, net_list, exit_list)
 		flush_all_nexthops(net);
-		kfree(net->nexthop.devhash);
-	}
-	rtnl_unlock();
+}
+
+static void __net_exit nexthop_net_exit(struct net *net)
+{
+	kfree(net->nexthop.devhash);
+	net->nexthop.devhash = NULL;
 }
 
 static int __net_init nexthop_net_init(struct net *net)
@@ -3764,7 +3768,8 @@ static int __net_init nexthop_net_init(struct net *net)
 
 static struct pernet_operations nexthop_net_ops = {
 	.init = nexthop_net_init,
-	.exit_batch = nexthop_net_exit_batch,
+	.exit = nexthop_net_exit,
+	.exit_batch_rtnl = nexthop_net_exit_batch_rtnl,
 };
 
 static int __init nexthop_init(void)
-- 
2.43.0.594.gd9cf4e227d-goog


