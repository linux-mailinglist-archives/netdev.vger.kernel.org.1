Return-Path: <netdev+bounces-158229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452E4A1128F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94127163D83
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A29E20E6EA;
	Tue, 14 Jan 2025 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KshQJXnl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78020D4F7
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736888140; cv=none; b=UhKSl19Oi14yo9UZTPz5nsHG+odSq6zt2psjJYWczS7p5FKppUblS7rUum0eD2l/OiWMNBha5noRwACk3mxtwOaIta7w5irgZ0EzhndPy3QOEiM3RV4+N+pthQd4q0evhJIUkBsJ6HOZ1f8p5BirmpdeGA+Ft0NlprP4iIorT1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736888140; c=relaxed/simple;
	bh=5QT1SwStzSyi+YNhhlTqVLWEfrv2zApNwOucVt1F6Yw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L0495AgiF+5F9Q1p6RcyZnZ7pRxwYhFu1exqY3ogmrUyLDPVgdJThWdiglwNCUV67xM//zk+vIDtbDtjnaBt8JbGwz8d5NXdGfq3mZ3yQ2UFw0l8+2Pz0IN6SdDxfGryF+VcwCz3WllguImvL5VVFLTjAeWUSg71O2jWOgw1ixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KshQJXnl; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b9e433351dso847687185a.3
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 12:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736888137; x=1737492937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9dKCl1aYvxo7o5A/HIHfWMpJChOiFK8BNQYQtUV/oww=;
        b=KshQJXnlp5XImBZ/9U1CVsWf1SBZrvAxOwZCjhjtVtTROPylrJOxeeXS77t26ZMFHf
         plc5I+aLCmJ/Q+p9XP2x48/rltwKsCutsgniwDh84FyXszMbPxVPynE42+2sNHL0IkaN
         JmrFM8eF2qYzLp21hn/Xr8nj0DQ8TK2aUBLXXpElfm/axhL4IekL74AdqGQpFxsmB0/Z
         id7uCjoWcMgx48amvaFHpYaOuOIxX/UsSUprK/eKwgt1HS1KXXBqqjv04qg1VFkHG8R5
         Xc7e/2fQUxm2olAxb1TGpvg3foSgh1MjaH06U2WbCjYTQ0lMfjJWpDKbJqW/lDw/fylq
         aLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736888137; x=1737492937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9dKCl1aYvxo7o5A/HIHfWMpJChOiFK8BNQYQtUV/oww=;
        b=VrAJ6MTW5hZSgs7mcObfo9AMuDGNrzRVJEKG+ljFNtvtNt/sTf/gsQN+NWI9ndhAYr
         /z1Zf/Y0ugbo8P7wse9EDuUmllyi+ojgjtudLDO/wHBJRnQ5FZ473FHbjXHcIthCB7hW
         52PLhq3lc/u/5mr1D8q5HMkIaeEnLihxPWWPJyKW+dgn9ppId0BFbzHiuAN3hRWU+vG+
         AtnqUbWwetxijhRoVZR9qMmg/ef8WcPz20TlHeo76d41jw+rPYddgZe/1886+e9R8PAt
         4BKLBqDP7X1N1Sg1yEDGpi11emY0cqbf9OkEuwVQ+Ry8PsRyAQT1MO0+P7tqKot97pcG
         +2aA==
X-Gm-Message-State: AOJu0Yy3sxuLp1q/GcJEi+/4yZSQGxK4B7lm15esXXZhvKPdoXoVcrW/
	z5v0FDYZGq0mvH1e+FHskT7H0puOhDb9NHNDdhlKQrfl9T9m6PfrXewKuWscOXURpxsUwY8AVkB
	K+CmX63BkpA==
X-Google-Smtp-Source: AGHT+IGzXMrVgkYfLQ9kC2i05J6xA0Cc2RmVMuXE4QQT8TkUyprXdr6XKWZiP+iiXxEa/mD/p7LjWD/JLtV52A==
X-Received: from qknrb5.prod.google.com ([2002:a05:620a:8d05:b0:7b6:e209:1c29])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:841:b0:7be:3f22:2d99 with SMTP id af79cd13be357-7be3f222e8dmr1076319085a.31.1736888137491;
 Tue, 14 Jan 2025 12:55:37 -0800 (PST)
Date: Tue, 14 Jan 2025 20:55:29 +0000
In-Reply-To: <20250114205531.967841-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250114205531.967841-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250114205531.967841-4-edumazet@google.com>
Subject: [PATCH v3 net-next 3/5] net: no longer hold RTNL while calling flush_all_backlogs()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

flush_all_backlogs() is called from unregister_netdevice_many_notify()
as part of netdevice dismantles.

This is currently called under RTNL, and can last up to 50 ms
on busy hosts.

There is no reason to hold RTNL at this stage, if our caller
is cleanup_net() : netns are no more visible, devices
are in NETREG_UNREGISTERING state and no other thread
could mess our state while RTNL is temporarily released.

In order to provide isolation, this patch provides a separate
'net_todo_list' for cleanup_net().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index b0e05e44d771bee2721d054ddbd03166cc676680..f4dd92bed2223269053b6576e4954fcce218a2e5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10097,14 +10097,37 @@ static bool from_cleanup_net(void)
 #endif
 }
 
+static void rtnl_drop_if_cleanup_net(void)
+{
+	if (from_cleanup_net())
+		__rtnl_unlock();
+}
+
+static void rtnl_acquire_if_cleanup_net(void)
+{
+	if (from_cleanup_net())
+		rtnl_lock();
+}
+
 /* Delayed registration/unregisteration */
 LIST_HEAD(net_todo_list);
+static LIST_HEAD(net_todo_list_for_cleanup_net);
+
+/* TODO: net_todo_list/net_todo_list_for_cleanup_net should probably
+ * be provided by callers, instead of being static, rtnl protected.
+ */
+static struct list_head *todo_list(void)
+{
+	return from_cleanup_net() ? &net_todo_list_for_cleanup_net :
+				    &net_todo_list;
+}
+
 DECLARE_WAIT_QUEUE_HEAD(netdev_unregistering_wq);
 atomic_t dev_unreg_count = ATOMIC_INIT(0);
 
 static void net_set_todo(struct net_device *dev)
 {
-	list_add_tail(&dev->todo_list, &net_todo_list);
+	list_add_tail(&dev->todo_list, todo_list());
 }
 
 static netdev_features_t netdev_sync_upper_features(struct net_device *lower,
@@ -10952,7 +10975,7 @@ void netdev_run_todo(void)
 #endif
 
 	/* Snapshot list, allow later requests */
-	list_replace_init(&net_todo_list, &list);
+	list_replace_init(todo_list(), &list);
 
 	__rtnl_unlock();
 
@@ -11575,8 +11598,10 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		unlist_netdevice(dev);
 		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERING);
 	}
-	flush_all_backlogs();
 
+	rtnl_drop_if_cleanup_net();
+	flush_all_backlogs();
+	rtnl_acquire_if_cleanup_net();
 	synchronize_net();
 
 	list_for_each_entry(dev, head, unreg_list) {
-- 
2.48.0.rc2.279.g1de40edade-goog


