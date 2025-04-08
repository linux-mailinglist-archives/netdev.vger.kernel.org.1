Return-Path: <netdev+bounces-180468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3577EA81637
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 22:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A9C1B6478D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F270254AFB;
	Tue,  8 Apr 2025 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ee8VsmxT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0442248B8
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744142411; cv=none; b=tm6NCZhs2jS0QaKngZc1zMeYxKnTUi0O1a/PAcPoZj0ruHYgoff38FFH2rqHgN/BzCGdBibr3H6tR4KYtIjd7N+TmyJqSFZQGt+bUAddPc9BdwVRM4KRL/QZmZ4k3lqgTx/+Bd01+O+VfmserVas8ZOtXfj+8CDGBdPw5Lqe7gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744142411; c=relaxed/simple;
	bh=Sug8dyIolpfe1jOcS2JBf9BP/HtpHhM+fhUNcwNVJcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1/iXklWw9o/E/6xpKvwOaHR4UchNhHXeQF+NaoCz197bWTc0P5oHJ0J2VGKtgCR4jqtFwfGdgbhrHjxBO0zYnBjMX7MZ1FqSftmAS/dQCRxpq60Eqyg30onntp3jvqGc0rl+J/+LCXrv1g4XRrNmSYO9NJ7+Zli47apwOJ1tfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ee8VsmxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C97C4CEF1;
	Tue,  8 Apr 2025 20:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744142410;
	bh=Sug8dyIolpfe1jOcS2JBf9BP/HtpHhM+fhUNcwNVJcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ee8VsmxTUd8FANIo+6EQFnW5PhpTHAataOvC+1mnid6UzIFYAAVMq/TGlvwa9XTe6
	 LL/n3NFRWadS7lK9ukv9k79oOgi0rHspt0+zn+5aWBkD2ddQdpj19c9ct5paprEczY
	 aT36jPdCg2eWSW/j5XOU4jeSTsiYigFmzVseDee68FM+FBMS9qAALD+sZhtzEAoXxa
	 oFpK0+gJ1161mkTnqKJ5Dv00TJDo2bwozv+QaL/1ZMuF6tsFbAspmENKcaTSSt2+Lt
	 KDpdYfYVxIvUHyBAtWq5glYAsfmkLxe4/mLACKZmKSlxn857YFvCJQI9MUrLB48kJY
	 plsg4Eqe6aUJg==
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
Subject: [PATCH net-next v2 6/8] netdev: depend on netdev->lock for xdp features
Date: Tue,  8 Apr 2025 12:59:53 -0700
Message-ID: <20250408195956.412733-7-kuba@kernel.org>
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

Writes to XDP features are now protected by netdev->lock.
Other things we report are based on ops which don't change
once device has been registered. It is safe to stop taking
rtnl_lock, and depend on netdev->lock instead.

Reviewed-by: Joe Damato <jdamato@fastly.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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


