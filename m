Return-Path: <netdev+bounces-180466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D847A81639
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 22:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4D7468A51
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1678B254872;
	Tue,  8 Apr 2025 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqTJQ2X3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E664A254845
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744142411; cv=none; b=XJ1falVdj9Fs04CZvsPEy84x9bwmAz5ZwAg+mWMbbEH+lPHImU5WJQKSKyT4Vj34YL5uRPit+gaxyHRIKEjmDqdb1bj4NRCx14Jx7pCS9GFsAYF73zYomlHcJkUPopJsguhLAMCCm8NCBoT65tgrUK9F/J285IoRdQh3jhdb7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744142411; c=relaxed/simple;
	bh=bI98lH6G0wD1RBqGxiGp5G2OYxzCRimyMFf9QAxCaIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPpk0womvEkQX3W0sWmpyFYKJD+sTw2rejY6oPxaGmkNpTgdz9bqoF4YvyA8TOJxpBdaMpwtmdx6XQ1XAuTTqzJkl2n61u5qgqmshjjA/s+0y1QG5Rj6onaxikuvtjK2qp0oJxVdhtLumKfjdBHyjffVOxNpRcy13eXsM85AtZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqTJQ2X3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1E1C4CEE9;
	Tue,  8 Apr 2025 20:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744142409;
	bh=bI98lH6G0wD1RBqGxiGp5G2OYxzCRimyMFf9QAxCaIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rqTJQ2X32CjdaqEjJA3+OKne/jjm969hWm3MMviykgQWzVyh61zxvDIIKPGgY0psc
	 yxFfPulb2wFtMI3/3Y/tdjjmAQGwGlWHhSLBc5c80pGe3J7QwL6kSBA2N00qno1hxV
	 HDFcbw+70Q9eK+UYiOB9HWf9VqLmU5PCmaame1gO7SwEVl2BlGSIbl47cT91/BJwEn
	 DEwIyLI9jGCwzpzZPNyi0pLWG5dGTeXRXNO02wjCw9YKLtVwkKa/p302nNhgcbC0sS
	 7+L9uQe7vNQKclU8Xy529fIzsXIdAEigaHvDp6lxMbMvgWBjaQpoaK79PTok95LlzI
	 F3G5THAY64mDA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	hramamurthy@google.com,
	kuniyu@amazon.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 4/8] netdev: don't hold rtnl_lock over nl queue info get when possible
Date: Tue,  8 Apr 2025 12:59:51 -0700
Message-ID: <20250408195956.412733-5-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408195956.412733-1-kuba@kernel.org>
References: <20250408195956.412733-1-kuba@kernel.org>
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

Reviewed-by: Joe Damato <jdamato@fastly.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/netdev-genl.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 5d7af50fe702..7ef9b0191936 100644
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
2.49.0


