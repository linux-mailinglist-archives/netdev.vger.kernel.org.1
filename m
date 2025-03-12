Return-Path: <netdev+bounces-174404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E61A5E78E
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 23:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004673BDA7C
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 22:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB90A1F151C;
	Wed, 12 Mar 2025 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgU5c496"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BDD1EF08D
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818945; cv=none; b=aGdFmMCztnvc/wApx6sX4eRx2fqcleF8hbZdrM1mjqYp7Hrvm6REc1+P0+EicI99iihrrSYV947ZcQs3PKrAMUmyeCFfgChSO/qtqW6wvKqirfaitmsaXTvYwe4rm3dCLI8HJDx3sK6IFtdLtUT4a7eY+aG0N+TI+ORQdCshWEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818945; c=relaxed/simple;
	bh=2S2WwdPjGT5zN3uPH471LFBIxVSY2S0i+aOU5q/QtTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDsaGbvqbNBqWEmTwvLvJHWS7dVmYT5V5AJ6dQkGz0JBT03mkSwLmgPiNRcNR1j3RJq0wsh9D6uJXpYrSAantzwlZaae8jgiifGaZjDXNt/VJ8YTC/BgZ3Q/7dYvqifCSyDxl4Qq8mKrGrqnd1XzKlCHp/lXa6rX1yYXR7ZzTgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgU5c496; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A71AC4CEDD;
	Wed, 12 Mar 2025 22:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741818945;
	bh=2S2WwdPjGT5zN3uPH471LFBIxVSY2S0i+aOU5q/QtTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FgU5c496ttFBT3N167Vayygu+h/p3HkTFEeaDoAX9JcQpq344bZ+U7QsS8ADNgdxU
	 vtkadDo5g+Zl4X9tJsZneCpohkELZnrqXjg3MK7bogd6LrXE0lEvZfCcUMba1oiTjU
	 H7Km1XKGmTbxV8zaWuHBxYE9rlPt74CtRTpaIQI4+evaCmQOt55d18c9RY49FJQMv4
	 081gcpqgkpLso0MPmrmeqF6+kv3Fc+iwWcXz/s4QPLrv+I2RzGsiWbLak+1d+vW03o
	 pSaVgo0L9gg3qTOuLnCumchS8OpSeJBjgnU0qW88RYPPruY0oim8iJp83B4G5/gHQa
	 fRnVig6qTKlpA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 11/11] netdev: don't hold rtnl_lock over nl queue info get when possible
Date: Wed, 12 Mar 2025 23:35:07 +0100
Message-ID: <20250312223507.805719-12-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312223507.805719-1-kuba@kernel.org>
References: <20250312223507.805719-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Netdev queue dump accesses: NAPI, memory providers, XSk pointers.
All three are "ops protected" now, switch to the op compat locking.
rtnl lock does not have to be taken for "ops locked" devices.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/netdev-genl.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index fd1cfa9707dc..39f52a311f07 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -481,18 +481,15 @@ int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!rsp)
 		return -ENOMEM;
 
-	rtnl_lock();
-
-	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
+	netdev = netdev_get_by_index_lock_ops_compat(genl_info_net(info),
+						     ifindex);
 	if (netdev) {
 		err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
-		netdev_unlock(netdev);
+		netdev_unlock_ops_compat(netdev);
 	} else {
 		err = -ENODEV;
 	}
 
-	rtnl_unlock();
-
 	if (err)
 		goto err_free_msg;
 
@@ -541,17 +538,17 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	if (info->attrs[NETDEV_A_QUEUE_IFINDEX])
 		ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
 
-	rtnl_lock();
 	if (ifindex) {
-		netdev = netdev_get_by_index_lock(net, ifindex);
+		netdev = netdev_get_by_index_lock_ops_compat(net, ifindex);
 		if (netdev) {
 			err = netdev_nl_queue_dump_one(netdev, skb, info, ctx);
-			netdev_unlock(netdev);
+			netdev_unlock_ops_compat(netdev);
 		} else {
 			err = -ENODEV;
 		}
 	} else {
-		for_each_netdev_lock_scoped(net, netdev, ctx->ifindex) {
+		for_each_netdev_lock_ops_compat_scoped(net, netdev,
+						       ctx->ifindex) {
 			err = netdev_nl_queue_dump_one(netdev, skb, info, ctx);
 			if (err < 0)
 				break;
@@ -559,7 +556,6 @@ int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 			ctx->txq_idx = 0;
 		}
 	}
-	rtnl_unlock();
 
 	return err;
 }
-- 
2.48.1


