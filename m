Return-Path: <netdev+bounces-68618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C66884765A
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ECF728D2B2
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8853314D420;
	Fri,  2 Feb 2024 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1LJJyJBm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88E814C5A7
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895617; cv=none; b=Q+HFwdwWf1oe9NAEFAq3sHsMlt+C9380r8yCN7j+3JGM2Bztx6kOmb1CrebxV0DtIve3HW3VOzKm0ZcWjcWxyMRtTDjeMhnqaRY4XZxDj2sPhqCPJdxXwtPYPknD1k/ZDcm532ci55140y81ASUqjUAMnWiOKg42sNiS6V45cdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895617; c=relaxed/simple;
	bh=ql5nrmunbPMsXwmjq0RrnAxCnN3daxWleNT7WyRil7o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gtb3kbqJkPL5RVF+SeDsINQg1FMyP2BDl5M4CCp7b5XgymNJP5HuHsntiRWPYgbqtoefBBIKohfhV600HeWBeuh1jJYpbZRLkLjgplnw4/c1dMoM6g6EGOymrZT80TnRU+qwayPBj9pxGkiQJ3QeeZL6ikB06S80r23ngimkKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1LJJyJBm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6041c45ce1cso33777077b3.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706895615; x=1707500415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/LfEygaNfn8wYTUAVlKoyLmED1pTJ30JERjOTuPXEa8=;
        b=1LJJyJBmIDslUe0Zfi054+oxIPQlaBcKBxAr/rvn5E+As/MOVKUIUsVaWBkQNUFLSy
         GFnL/XBCtmYUH9dm9uySLcJ15Wo2/7W6hqaUN9dl8TzaS6qt19K3HxeapeWuv1X9pc3c
         xiMu4XYxZw2yN/nX+kBbuxROHeTk37AVv+dYtJXyhTN2ZOiVT+vsuJH1olXx9TOBC7XU
         FiOTPCkAdZtQfZyngzNkr9zQpK1Y5WdN5TSQr03YIy961kkVFLJjkYiM0tyggA9Tj6rQ
         uH5FY+seN78NGRFrHCr1njGfgJkKVQV24RLGrS1sOMV6tkBRzXMnseydiGjah+DG8RbT
         Vtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895615; x=1707500415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LfEygaNfn8wYTUAVlKoyLmED1pTJ30JERjOTuPXEa8=;
        b=GvL/wWm+VIG0u7bJjUE9SrOqhGCGQnEmnanwdJgnu56P5FdDZ1dSi6uhjDUf4iFLSO
         o6W88OWXsUyqC1ERSReABorPMOZVnJZKSWmIapBrEFFWO9c2rew8do6CM9YYNLeA2UZl
         U98PpBDEC0ZIDzmbMxFa4PU+Qy9B5AT8H4ab8S7DJ0gwm8iSk2EYQ6XHnLYXF/GG4V50
         wGHzsyBnlPfFkVgQFFFK0yp6dTnKuxKVa3t0L6tasBWoAQPEvKpGuo0i7WQUge+3Da6X
         Zslo/M+7A5S8xDHjvzlZmKLrhg1eKC9aTVEw4Nq/1YCKVL9aUa6oP1Nx5AfTX2tvpbJR
         vujg==
X-Gm-Message-State: AOJu0YxbQyUJjMnpPKGu69tatWSMpr3sUA/U+HN3UOLJekcV57cQaF0J
	E+dBxhkn4ZT+8QLwlJQ6As5fXhd3fba0LWisp3DTjkeCW72+a24MUXkxnWVO/1Kl7ZY7ABJ7iEl
	ayN0Zuel4cg==
X-Google-Smtp-Source: AGHT+IHVopAu8fYLFqrHEN9nnu2et6dWdVuwxOXef02MAVfRu0PduX1t9Knt+/e1WGbjJJaGcID+B+1QPu5cxw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2206:b0:dc2:4921:cc0 with SMTP
 id dm6-20020a056902220600b00dc249210cc0mr208908ybb.5.1706895614897; Fri, 02
 Feb 2024 09:40:14 -0800 (PST)
Date: Fri,  2 Feb 2024 17:39:50 +0000
In-Reply-To: <20240202174001.3328528-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202174001.3328528-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202174001.3328528-6-edumazet@google.com>
Subject: [PATCH v2 net-next 05/16] bonding: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jay Vosburgh <j.vosburgh@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair,
and one unregister_netdevice_many() call.

v2: Added bond_net_pre_exit() method to make sure bond_destroy_sysfs()
    is called before we unregister the devices in bond_net_exit_batch_rtnl

Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/netdev/170688415193.5216.10499830272732622816@kwain/
Cc: Antoine Tenart <atenart@kernel.org>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>
Cc: Andy Gospodarek <andy@greyhouse.net>
---
 drivers/net/bonding/bond_main.c | 37 +++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4e0600c7b050f21c82a8862e224bb055e95d5039..a5e3d000ebd85c09beba379a2e6a7f69a0fd4c88 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -6415,28 +6415,41 @@ static int __net_init bond_net_init(struct net *net)
 	return 0;
 }
 
-static void __net_exit bond_net_exit_batch(struct list_head *net_list)
+/* According to commit 69b0216ac255 ("bonding: fix bonding_masters
+ * race condition in bond unloading") we need to remove sysfs files
+ * before we remove our devices (done later in bond_net_exit_batch_rtnl())
+ */
+static void __net_exit bond_net_pre_exit(struct net *net)
+{
+	struct bond_net *bn = net_generic(net, bond_net_id);
+
+	bond_destroy_sysfs(bn);
+}
+
+static void __net_exit bond_net_exit_batch_rtnl(struct list_head *net_list,
+						struct list_head *dev_kill_list)
 {
 	struct bond_net *bn;
 	struct net *net;
-	LIST_HEAD(list);
-
-	list_for_each_entry(net, net_list, exit_list) {
-		bn = net_generic(net, bond_net_id);
-		bond_destroy_sysfs(bn);
-	}
 
 	/* Kill off any bonds created after unregistering bond rtnl ops */
-	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list) {
 		struct bonding *bond, *tmp_bond;
 
 		bn = net_generic(net, bond_net_id);
 		list_for_each_entry_safe(bond, tmp_bond, &bn->dev_list, bond_list)
-			unregister_netdevice_queue(bond->dev, &list);
+			unregister_netdevice_queue(bond->dev, dev_kill_list);
 	}
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+}
+
+/* According to commit 23fa5c2caae0 ("bonding: destroy proc directory
+ * only after all bonds are gone") bond_destroy_proc_dir() is called
+ * after bond_net_exit_batch_rtnl() has completed.
+ */
+static void __net_exit bond_net_exit_batch(struct list_head *net_list)
+{
+	struct bond_net *bn;
+	struct net *net;
 
 	list_for_each_entry(net, net_list, exit_list) {
 		bn = net_generic(net, bond_net_id);
@@ -6446,6 +6459,8 @@ static void __net_exit bond_net_exit_batch(struct list_head *net_list)
 
 static struct pernet_operations bond_net_ops = {
 	.init = bond_net_init,
+	.pre_exit = bond_net_pre_exit,
+	.exit_batch_rtnl = bond_net_exit_batch_rtnl,
 	.exit_batch = bond_net_exit_batch,
 	.id   = &bond_net_id,
 	.size = sizeof(struct bond_net),
-- 
2.43.0.594.gd9cf4e227d-goog


