Return-Path: <netdev+bounces-177255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFDFA6E6BB
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C98E3B318A
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2953D1EDA1F;
	Mon, 24 Mar 2025 22:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3zD9BKP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0357014EC46
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856356; cv=none; b=cOhoBsEVIrhgep4dxqrLfPMOM9e9trvmwBd9+uD30w3Ld7LNhs45XfWmTGxQOqSXxw1whiRvjRJ7LZvc8Z8YTQ31kGbVz8+/hlkvIWw+CfWCWczOHP7O7giJsnMj82MJpVM98isa50vo8RaNsXEXftXpP0u1G23WN86VQBwg8IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856356; c=relaxed/simple;
	bh=z0n8iRZOaeCnjLdNUUGn+3PeRbFnh2IHsSqf/RorZf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTpL5R4sj6vvUAloyOZO7Tty4W/kZVbdqLEN94hAcQiKEDmxyynvjcYk2Qz24CblahdVXalucVEqYZVxr3YEwzLJnh2GW5ckmXAPEXAD5H4UqDjqhWtyYXAnrPsE0Vk55noUVnF3X87X1zZdaCjMOAek4JENjnkF59ZQxihJFyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3zD9BKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF02C4CEEE;
	Mon, 24 Mar 2025 22:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742856353;
	bh=z0n8iRZOaeCnjLdNUUGn+3PeRbFnh2IHsSqf/RorZf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l3zD9BKP6ZCqkSeacbe0czGIen2ruscS07a8Z5JrgwOPWqJbltQk7YqvUibKpLUxH
	 kUfUGNpHTrepc/IMXivB4o3RQrriPoXTEdHqYQjzvoZNFwJki9JXNAVY8u9X0rxZKa
	 pSV3FIS4ld3a4THn7T2AHxaGwB5moyy5Hg0qoUxLboncfN/vWNh0mgowaB8+bNIJcA
	 5O1qG4VtmZ1NSboZDFgbosDoZuV1UlM0Ye3sCngbV3MRrWRZC7iQRzx4aylu2G1qyy
	 YOapkPaUHqjwNg8o6mEj9ITKlZprijRuE8DjNPyV5MU0SR70HpZwQeKDTbRdL2ROfH
	 g4fIAcKEWGzTA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 01/11] net: bubble up taking netdev instance lock to callers of net_devmem_unbind_dmabuf()
Date: Mon, 24 Mar 2025 15:45:27 -0700
Message-ID: <20250324224537.248800-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324224537.248800-1-kuba@kernel.org>
References: <20250324224537.248800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent commit added taking the netdev instance lock
in netdev_nl_bind_rx_doit(), but didn't remove it in
net_devmem_unbind_dmabuf() which it calls from an error path.
Always expect the callers of net_devmem_unbind_dmabuf() to
hold the lock. This is consistent with net_devmem_bind_dmabuf().

(Not so) coincidentally this also protects mp_param with the instance
lock, which the rest of this series needs.

Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - rebase on a70f891e0fa0 ("net: devmem: do not WARN conditionally after netdev_rx_queue_restart()")
v1: https://lore.kernel.org/20250312223507.805719-2-kuba@kernel.org
---
 net/core/devmem.c      | 2 --
 net/core/netdev-genl.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 6802e82a4d03..ee145a2aa41c 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -128,12 +128,10 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		rxq->mp_params.mp_priv = NULL;
 		rxq->mp_params.mp_ops = NULL;
 
-		netdev_lock(binding->dev);
 		rxq_idx = get_netdev_rx_queue_index(rxq);
 
 		err = netdev_rx_queue_restart(binding->dev, rxq_idx);
 		WARN_ON(err && err != -ENETDOWN);
-		netdev_unlock(binding->dev);
 	}
 
 	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index a186fea63c09..9e4882a22407 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -947,7 +947,9 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
 
 	mutex_lock(&priv->lock);
 	list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
+		netdev_lock(binding->dev);
 		net_devmem_unbind_dmabuf(binding);
+		netdev_unlock(binding->dev);
 	}
 	mutex_unlock(&priv->lock);
 }
-- 
2.49.0


