Return-Path: <netdev+bounces-182855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEC9A8A296
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC943A9E3B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C863149659;
	Tue, 15 Apr 2025 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IINH8G3/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A032DFA29
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744730155; cv=none; b=t7K6Rd7Qh3XCJdnXVA6RMl+D08vP0YJ2fP5033RRF9R0omicQiqBG+wq1+t2sGkyhAAtKFThk6+aL1jtezArYZSO+rvX3DzBUMbPTvG8+i7QkVniSFbKX0S154IvHjYOyIFfGh4rhFs+UAHn1PHQmdmEVAd97dLKKiG+W9Iancw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744730155; c=relaxed/simple;
	bh=WodU4GOELVP+iaKVHqKuf6yNIusD0gRistMcBTFBnKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ggfTxZe3pE/y3yPA91ueEzufX+HdasJMpLSiWVqCuRGM1lSZhwr89txMYnca+aKmgBVuLz8rtOInTzi9zimUKpFJSU9Q+Edaa+GVcSznth0sAwEEYMIPKbnqiMP3qoGgLFpD2dxN/zYYaNzBe6jeErH5jHr2FaBQQnYUNULoruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IINH8G3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C809C4CEEB;
	Tue, 15 Apr 2025 15:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744730155;
	bh=WodU4GOELVP+iaKVHqKuf6yNIusD0gRistMcBTFBnKk=;
	h=From:To:Cc:Subject:Date:From;
	b=IINH8G3/K9fdxmlmCSgqGc91/XqeDBESmF0jlsk6cDbWqJ2x21MpWGd2TcXBTKZCo
	 XkTygSFaaar6nIzZwiVlMLnqX9lw0jY4srovKtwvt4hXGje0t3TOY+X+e9yjMHGBwc
	 Iwx6DX1qoeppr5PpFZ72Vx+I2ic7Ff0uJ17kUPDWO72NToG51Od7MXgkaSTlsXZS/P
	 DbBVMrZuR3aYJsRWaqdvithoUWzP727eQ2+c9/qxb+Xlpvi4XEd0EeNhpVc5S6gDTE
	 unuiTXOEX8MQ3UTlD+f3ZUoVahFta4lHrsK6Wm4qNGIAKpg1oA3b4igElLEvSSho0r
	 T27U9sm8I5EyQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+de1c7d68a10e3f123bdd@syzkaller.appspotmail.com,
	sdf@fomichev.me,
	kuniyu@amazon.com
Subject: [PATCH net] net: don't try to ops lock uninitialized devs
Date: Tue, 15 Apr 2025 08:15:52 -0700
Message-ID: <20250415151552.768373-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to be careful when operating on dev while in rtnl_create_link().
Some devices (vxlan) initialize netdev_ops in ->newlink, so later on.
Avoid using netdev_lock_ops(), the device isn't registered so we
cannot legally call its ops or generate any notifications for it.

netdev_ops_assert_locked_or_invisible() is safe to use, it checks
registration status first.

Reported-by: syzbot+de1c7d68a10e3f123bdd@syzkaller.appspotmail.com
Fixes: 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: sdf@fomichev.me
CC: kuniyu@amazon.com

I wasn't sure whether Kuniyuki is going to send this or he's waiting
for me to send.. so let me send and get this off my tracking list :)
---
 net/core/dev.c       | 2 ++
 net/core/rtnetlink.c | 5 +----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 03d20a98f8b7..c5e15701cfb3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1572,6 +1572,8 @@ EXPORT_SYMBOL(netdev_features_change);
 
 void netif_state_change(struct net_device *dev)
 {
+	netdev_ops_assert_locked_or_invisible(dev);
+
 	if (dev->flags & IFF_UP) {
 		struct netdev_notifier_change_info change_info = {
 			.info.dev = dev,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 38526210b8fd..bb624fc6ca8a 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3677,11 +3677,8 @@ struct net_device *rtnl_create_link(struct net *net, const char *ifname,
 				nla_len(tb[IFLA_BROADCAST]));
 	if (tb[IFLA_TXQLEN])
 		dev->tx_queue_len = nla_get_u32(tb[IFLA_TXQLEN]);
-	if (tb[IFLA_OPERSTATE]) {
-		netdev_lock_ops(dev);
+	if (tb[IFLA_OPERSTATE])
 		set_operstate(dev, nla_get_u8(tb[IFLA_OPERSTATE]));
-		netdev_unlock_ops(dev);
-	}
 	if (tb[IFLA_LINKMODE])
 		dev->link_mode = nla_get_u8(tb[IFLA_LINKMODE]);
 	if (tb[IFLA_GROUP])
-- 
2.49.0


