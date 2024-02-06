Return-Path: <netdev+bounces-69515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6404A84B83D
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3188FB2D7AA
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E609133402;
	Tue,  6 Feb 2024 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="26iPtr/P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49FB1332BD
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230615; cv=none; b=nS+LFI2uEDl8tDx5x0vAPU9fSlXhcWlGiommWeRufoTJlmxtKYj1oYneTnXRl2pfeFDLuJa7UV0MDCcH39NmI2tp1YGSEGuWeGc2zggVGMFpVscNUoLsWPDHB5qxdlM20RP6Kl0Hig+mGyoZY+7CCKb1G3LT/zy/fTf1T9EYflg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230615; c=relaxed/simple;
	bh=6n9gdaY0JENPgIo8oGFslsH+VbHEMvGjQze+JywtgPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sVMNDFKE7+aBvqnu0aG9Tmb6n/riAuYAOvzEOlOWaFcaEFSfgNIRHVPpKlBGd2ZO2bU7N67hbt+cY47KZlIO9gL80K5+w3Nu2wWcDTbUSJlhfBSBQ9aKIhKY/FNizexcPKxMDM/h/prbkQ5DWrWhmhNQKJl04KvX+qqIKY6vuuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=26iPtr/P; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-603c0e020a6so72868307b3.0
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707230612; x=1707835412; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JUsyewKeOm1iP/Rrb+VKWW8m6kBjDn3VkleFYn6PXNc=;
        b=26iPtr/PnyGJT+CUEqR3E3sYta/kLpSnZU8Dpe5tO94iyUyLOV7Btzpuh12lEq/w6V
         GxlDzOt2e3trJoJbkrFCI7rG421IfK9ceXpgFiC3QkT67oXW88JHPjnlERxvaO5M+eVi
         xCcpvAOeTdUQ3Jg0Nje1bQxrwRn5pqsPr7oKw9o8DIfpjXKJycv58M3wh9ZH0Eqgwu0b
         fKpYpgLmVmy7gB2SA5gLdtIqZxn8tTgpRfM8DYtGVtKuVPbLV9l8jnOHPIOzbZJ/VIQn
         emGUzFhkir5hjzMB760rOX++LmWrx+bxcxG8eIw62oYh76uKCYbXNA+a9EbaeDJbAS0b
         Kj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230612; x=1707835412;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUsyewKeOm1iP/Rrb+VKWW8m6kBjDn3VkleFYn6PXNc=;
        b=Rv+rmGRHvKSp7v4Q2a4UpIp6297D9eVBf9gZuQ/6NHJa9xbO9wrgMwd3FfeavYLL26
         pjCO3r852CFcsnP1lMcxr17bi1J3u+89yyUny2Sov8jncS3jfUZrk2IIvnqVwIcXk0XW
         YFd5kRRj+IlZ+DsdbrQCXCMXEzA8bo5kOUL8jilcX8V3zS+SutQDp9Nq+jZ2ohdSxH/X
         3P2nYjD2VltEuEoP7VhyIHJPXh7wGa0n2E29P69TCfDof2gaZPKvertnJj/LAfG+n9F8
         eUW+aCm/jRmY+hjFAYMEeS2GjtGI5mvey9yH0ISRjSAsaEwiM+aCzWpOQCUFJ+RIWARB
         /EDg==
X-Gm-Message-State: AOJu0Yx6FBkc5PMXpzNMJEDNi7T6dJgcJTb8rG5yvkAoS3+656PX37O7
	0r5WnmCz1aozZX/3I6ExTL+zSdBJ00uKTdhQDU68GVy2YDy2xxHVnj2TSGTr65cxuG4IYBE6ITF
	LTlFhhNttHg==
X-Google-Smtp-Source: AGHT+IFzA86TcVPkTKlc+H5iF2zowqMaom9bLNjaTAoY69L3eBW6r3BmNFp+AtZX5hYbWfIFzXzWkzXIftdI3Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2005:b0:dc6:a6e3:ca93 with SMTP
 id dh5-20020a056902200500b00dc6a6e3ca93mr47874ybb.10.1707230612798; Tue, 06
 Feb 2024 06:43:32 -0800 (PST)
Date: Tue,  6 Feb 2024 14:43:05 +0000
In-Reply-To: <20240206144313.2050392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206144313.2050392-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206144313.2050392-10-edumazet@google.com>
Subject: [PATCH v4 net-next 08/15] vxlan: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair per netns
and one unregister_netdevice_many() call.

v4: (Paolo feedback : https://netdev-3.bots.linux.dev/vmksft-net/results/453141/17-udpgro-fwd-sh/stdout )
  - Changed vxlan_destroy_tunnels() to use vxlan_dellink()
    instead of unregister_netdevice_queue to propely remove
    devices from vn->vxlan_list.
  - vxlan_destroy_tunnels() can simply iterate one list (vn->vxlan_list)
    to find all devices in the most efficient way.
  - Moved sanity checks in a separate vxlan_exit_net() method.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 50 +++++++++++++---------------------
 1 file changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 16106e088c6301d3aaa47dd73985107945735b6e..11707647afb9831ee430cdc13e705431b66af6c2 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4826,55 +4826,43 @@ static __net_init int vxlan_init_net(struct net *net)
 					 NULL);
 }
 
-static void vxlan_destroy_tunnels(struct net *net, struct list_head *head)
+static void __net_exit vxlan_destroy_tunnels(struct vxlan_net *vn,
+					     struct list_head *dev_to_kill)
 {
-	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 	struct vxlan_dev *vxlan, *next;
-	struct net_device *dev, *aux;
-
-	for_each_netdev_safe(net, dev, aux)
-		if (dev->rtnl_link_ops == &vxlan_link_ops)
-			unregister_netdevice_queue(dev, head);
-
-	list_for_each_entry_safe(vxlan, next, &vn->vxlan_list, next) {
-		/* If vxlan->dev is in the same netns, it has already been added
-		 * to the list by the previous loop.
-		 */
-		if (!net_eq(dev_net(vxlan->dev), net))
-			unregister_netdevice_queue(vxlan->dev, head);
-	}
 
+	list_for_each_entry_safe(vxlan, next, &vn->vxlan_list, next)
+		vxlan_dellink(vxlan->dev, dev_to_kill);
 }
 
-static void __net_exit vxlan_exit_batch_net(struct list_head *net_list)
+static void __net_exit vxlan_exit_batch_rtnl(struct list_head *net_list,
+					     struct list_head *dev_to_kill)
 {
 	struct net *net;
-	LIST_HEAD(list);
-	unsigned int h;
 
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list) {
 		struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 
-		unregister_nexthop_notifier(net, &vn->nexthop_notifier_block);
-	}
-	rtnl_lock();
-	list_for_each_entry(net, net_list, exit_list)
-		vxlan_destroy_tunnels(net, &list);
+		__unregister_nexthop_notifier(net, &vn->nexthop_notifier_block);
 
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		vxlan_destroy_tunnels(vn, dev_to_kill);
+	}
+}
 
-	list_for_each_entry(net, net_list, exit_list) {
-		struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+static void __net_exit vxlan_exit_net(struct net *net)
+{
+	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+	unsigned int h;
 
-		for (h = 0; h < PORT_HASH_SIZE; ++h)
-			WARN_ON_ONCE(!hlist_empty(&vn->sock_list[h]));
-	}
+	for (h = 0; h < PORT_HASH_SIZE; ++h)
+		WARN_ON_ONCE(!hlist_empty(&vn->sock_list[h]));
 }
 
 static struct pernet_operations vxlan_net_ops = {
 	.init = vxlan_init_net,
-	.exit_batch = vxlan_exit_batch_net,
+	.exit_batch_rtnl = vxlan_exit_batch_rtnl,
+	.exit = vxlan_exit_net,
 	.id   = &vxlan_net_id,
 	.size = sizeof(struct vxlan_net),
 };
-- 
2.43.0.594.gd9cf4e227d-goog


