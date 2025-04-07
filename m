Return-Path: <netdev+bounces-179880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C57A7ECB8
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FBF71891256
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6331325C713;
	Mon,  7 Apr 2025 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMDA3c1s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5F825C707
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052481; cv=none; b=rFb6svkjmy9oz+xiIRW9MTe9RCSXxf0zuPbh6VLgfYCAWwK1EWQezlIvvpwirbbghmXGwn+0O0MqLNN4PP9Lb0QBpXdTt5Iamb/KdX6WEIWy02xE9hwvHpnGbX3iMUfFUJv+lzX9mJBQ7uip5Yx0R3Z3c2mKU6eQKJixF5h9KCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052481; c=relaxed/simple;
	bh=qiAXd6WD0xlqHELYEUPJ5EuGfHhfjKNjrbmuHVbXn/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+UiZKDTd9qA/oZECLOoQIi7a96Gp77dEHXSgypoKxSDEfo1bOQL17hLA/XqEgdm+GAJ4IZUs9gqBRDhRh5YhrYi+fWG91Ot58FaL9PXrrvk0dg/kM/a8ELpgZvJQhoPHf6N3x+bP7NynBI2Mv2A6hEIixdrl1aYV3mmGOTepH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMDA3c1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A662C4CEE9;
	Mon,  7 Apr 2025 19:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744052480;
	bh=qiAXd6WD0xlqHELYEUPJ5EuGfHhfjKNjrbmuHVbXn/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PMDA3c1sC1rdLPc9UXG33scv9fIh45xRJSIdP42AeYlgp1it5MUTv0j66tsbl7tXU
	 qt+07lokTxb2Ltdx4rXQ+9tu80EZJrtLT9dZG17hCmVlHtvY2yFyAQ5xqmwtKsWqsf
	 JspYRvKNBeCRCC+JHNp8ojauNS+pKgAvSFaUqX2y748R9Y2oHKgGpbhVk4DoWvI5Wr
	 Jue7RhF+twrZ3UIYyBvogsenB+werKNybYGguxvIjhc/6D/cMxhPjRjpKTkghUlgUk
	 WM5cXnYvvC2xAD1JOzd/0j8rZr2+7cSfmlRXtuA96eHqZZkkSmri+aql2GrZu25i6d
	 kyVXvqF17ONBQ==
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
	jdamato@fastly.com
Subject: [PATCH net-next 6/8] netdev: depend on netdev->lock for xdp features
Date: Mon,  7 Apr 2025 12:01:15 -0700
Message-ID: <20250407190117.16528-7-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407190117.16528-1-kuba@kernel.org>
References: <20250407190117.16528-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writes to XDP features are now protected by netdev->lock.
Other things we report are based on ops which don't change
once device has been registered. It is safe to stop taking
rtnl_lock, and depend on netdev->lock instead.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/netdev-genl.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 7ef9b0191936..8c58261de969 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -38,6 +38,8 @@ netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
 	u64 xdp_rx_meta = 0;
 	void *hdr;
 
+	netdev_assert_locked(netdev); /* note: rtnl_lock may not be held! */
+
 	hdr = genlmsg_iput(rsp, info);
 	if (!hdr)
 		return -EMSGSIZE;
@@ -122,15 +124,14 @@ int netdev_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!rsp)
 		return -ENOMEM;
 
-	rtnl_lock();
-
-	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
-	if (netdev)
-		err = netdev_nl_dev_fill(netdev, rsp, info);
-	else
+	netdev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
+	if (!netdev) {
 		err = -ENODEV;
+		goto err_free_msg;
+	}
 
-	rtnl_unlock();
+	err = netdev_nl_dev_fill(netdev, rsp, info);
+	netdev_unlock(netdev);
 
 	if (err)
 		goto err_free_msg;
@@ -146,18 +147,15 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
 	struct net *net = sock_net(skb->sk);
-	struct net_device *netdev;
-	int err = 0;
+	int err;
 
-	rtnl_lock();
-	for_each_netdev_dump(net, netdev, ctx->ifindex) {
+	for_each_netdev_lock_scoped(net, netdev, ctx->ifindex) {
 		err = netdev_nl_dev_fill(netdev, skb, genl_info_dump(cb));
 		if (err < 0)
-			break;
+			return err;
 	}
-	rtnl_unlock();
 
-	return err;
+	return 0;
 }
 
 static int
-- 
2.49.0


