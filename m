Return-Path: <netdev+bounces-161516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 007CAA21F1B
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 15:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FEA6188246A
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB40319CD1D;
	Wed, 29 Jan 2025 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U69TWF6Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436C21ACED2
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738160850; cv=none; b=NPRYQdxjH9kNHcTJHfQr5sh/jTLNHX1hlyG+b8fKTDgQwqOJClTUYJwU1TzlScaPhJ69Tv8qmn7rLTEyuOenzqs9NUug2RjvvNfXBGKg6nmqR3Fj/pv4uNOBmYni3D/q8NdSIWy2XWig68NUgsg+3doFTTWdEorvduq1EcMiF0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738160850; c=relaxed/simple;
	bh=MUyb6y5v8/o0kgaj9A25952HIxzkZWefYVcRZBF7soI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tu/zoOfZsznXjTeu0k45C0CaSAdwj8vHKGOytXBCq3cmlvJxiqdPQzgndHABQrrYcZ6Y+GlV7hNtt5XVz8ScuqrDsQiKNsHbPVhbLWlvvFR09kS/yiFJKKDiFa/1L1DyVYkUyMMGaZ1Zr3Nm5DAAGWZ550RC93dVVZE5A/Tru7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U69TWF6Q; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4679becb47eso161263651cf.3
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 06:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738160848; x=1738765648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tw37yL/oKf+UW2FGnjwCxM+DTQzrS+CeSsyFdQEWVc4=;
        b=U69TWF6QXe1TXUxNVRMbZeQCJg7HVcJ7mXOAWlMyIYiZSyiQmKGKfV4RUI3h0cI7+b
         nS0FDsFCNf8X+uF3hleldV7B4voxvO9SMbeMJR/5PxVbkhUbK3gCiVtfUdmKgkPHZ6/t
         JGPaHXVYZj8dNlGQQtF26aPfLU7nuoL7FJ5mvgs+/Dz6HKMtbUHq7Czp0SN1hmHytwHG
         iSQ7/+CnOXmWMX2N3zjOXgwAPM9ogw0xWAElicSroCO2ISwUWc2TWBu8JJ3+xYSZYd4c
         B8gXlaFjPd3N2uEAbGW0+oBsiTliiOX6yWMYCbV+YoXj/qPOGNcWl2MgciFzm/jBNAdm
         LY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738160848; x=1738765648;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tw37yL/oKf+UW2FGnjwCxM+DTQzrS+CeSsyFdQEWVc4=;
        b=bxEUVwqs7KB+nZIQucp2/VPfD8/NCAqfIdJQck9GCQP5XEf2lDlQax6kYo+LxZmffx
         Fw8LfRRwWiE5tZiJKAAtfQGSDJv1f/weg5Rzpa3e6AWLe/RnOTEDmtjbPV3GIbexuTM8
         Hddmoxow+Mk8r1/98FjV/hLV4OgBKVj2ukSQIZ8lhiFAy/XrjkCKnTWvrBImAT9YIh+e
         Epn8ynUDug/kuxrw3Z0JHidEqIwSgqfgz+XqoujnJac5R5Dal//JwKXVenDm7kHUr9Vn
         6MuNigpg91+L8dksLUs3NfUnm4kbl5MEWkjIkqc6Z25WIhXoGkU73euAPMzyAc4FSgnR
         sByA==
X-Gm-Message-State: AOJu0YwY+kPK6kwLkCeKkTQqqR9Bmu0JBai1P4mi/MEF0KcwEgWLcKjy
	k6R6Vlf5Q4msIBAgfvGhdiso91G574a4D5XhfnYQJJ6I+aAb2iykjh3DSUw8kc25+9ta66H3c+U
	uf/cjZU24sQ==
X-Google-Smtp-Source: AGHT+IFzmAd+CRaYAnzbWRNlZAcMwdMylM62wfrSTkoEqdm2PbGuTGm2tNRHq/fT0PT+9mfKY3Du0OGyUcQfhQ==
X-Received: from qtbbs8.prod.google.com ([2002:ac8:6f08:0:b0:467:2027:233b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:446:b0:467:85b1:402b with SMTP id d75a77b69052e-46fd0bd1a10mr60642161cf.47.1738160848033;
 Wed, 29 Jan 2025 06:27:28 -0800 (PST)
Date: Wed, 29 Jan 2025 14:27:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250129142726.747726-1-edumazet@google.com>
Subject: [PATCH net] net: revert RTNL changes in unregister_netdevice_many_notify()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+5b9196ecf74447172a9a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

This patch reverts following changes:

83419b61d187 net: reduce RTNL hold duration in unregister_netdevice_many_notify() (part 2)
ae646f1a0bb9 net: reduce RTNL hold duration in unregister_netdevice_many_notify() (part 1)
cfa579f66656 net: no longer hold RTNL while calling flush_all_backlogs()

This caused issues in layers holding a private mutex:

cleanup_net()
  rtnl_lock();
	mutex_lock(subsystem_mutex);

	unregister_netdevice();

	   rtnl_unlock();		// LOCKDEP violation
	   rtnl_lock();

I will revisit this in next cycle, opt-in for the new behavior
from safe contexts only.

Fixes: cfa579f66656 ("net: no longer hold RTNL while calling flush_all_backlogs()")
Fixes: ae646f1a0bb9 ("net: reduce RTNL hold duration in unregister_netdevice_many_notify() (part 1)")
Fixes: 83419b61d187 ("net: reduce RTNL hold duration in unregister_netdevice_many_notify() (part 2)")
Reported-by: syzbot+5b9196ecf74447172a9a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6789d55f.050a0220.20d369.004e.GAE@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 33 +++------------------------------
 1 file changed, 3 insertions(+), 30 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 07b2bb1ce64f..63e5dc75d58b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10260,37 +10260,14 @@ static bool from_cleanup_net(void)
 #endif
 }
 
-static void rtnl_drop_if_cleanup_net(void)
-{
-	if (from_cleanup_net())
-		__rtnl_unlock();
-}
-
-static void rtnl_acquire_if_cleanup_net(void)
-{
-	if (from_cleanup_net())
-		rtnl_lock();
-}
-
 /* Delayed registration/unregisteration */
 LIST_HEAD(net_todo_list);
-static LIST_HEAD(net_todo_list_for_cleanup_net);
-
-/* TODO: net_todo_list/net_todo_list_for_cleanup_net should probably
- * be provided by callers, instead of being static, rtnl protected.
- */
-static struct list_head *todo_list(void)
-{
-	return from_cleanup_net() ? &net_todo_list_for_cleanup_net :
-				    &net_todo_list;
-}
-
 DECLARE_WAIT_QUEUE_HEAD(netdev_unregistering_wq);
 atomic_t dev_unreg_count = ATOMIC_INIT(0);
 
 static void net_set_todo(struct net_device *dev)
 {
-	list_add_tail(&dev->todo_list, todo_list());
+	list_add_tail(&dev->todo_list, &net_todo_list);
 }
 
 static netdev_features_t netdev_sync_upper_features(struct net_device *lower,
@@ -11140,7 +11117,7 @@ void netdev_run_todo(void)
 #endif
 
 	/* Snapshot list, allow later requests */
-	list_replace_init(todo_list(), &list);
+	list_replace_init(&net_todo_list, &list);
 
 	__rtnl_unlock();
 
@@ -11785,11 +11762,9 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERING);
 		netdev_unlock(dev);
 	}
-
-	rtnl_drop_if_cleanup_net();
 	flush_all_backlogs();
+
 	synchronize_net();
-	rtnl_acquire_if_cleanup_net();
 
 	list_for_each_entry(dev, head, unreg_list) {
 		struct sk_buff *skb = NULL;
@@ -11849,9 +11824,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 #endif
 	}
 
-	rtnl_drop_if_cleanup_net();
 	synchronize_net();
-	rtnl_acquire_if_cleanup_net();
 
 	list_for_each_entry(dev, head, unreg_list) {
 		netdev_put(dev, &dev->dev_registered_tracker);
-- 
2.48.1.262.g85cc9f2d1e-goog


