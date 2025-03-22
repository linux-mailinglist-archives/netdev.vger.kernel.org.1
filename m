Return-Path: <netdev+bounces-176900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC66A6CAC9
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8D9A7AFFC7
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C3D2356AD;
	Sat, 22 Mar 2025 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="aQh6bBBd"
X-Original-To: netdev@vger.kernel.org
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6322356A6;
	Sat, 22 Mar 2025 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654547; cv=none; b=bS/IoFPrAWSSZsils9J/jYJqmCubOYnSSbgYbtPhD490XXX7xmxMAWrrLNsFXcq+28UF9G3No9u7QJ3PeQkxVaOuqRBY2hv//eMGCM6xB0AWneCPdHJSQgcCrQ97hPzdasJJ67h/VyTlMTWMwvJnYL3RhguoNx07DK3FR3FDQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654547; c=relaxed/simple;
	bh=SbSgeHC0tHhAIUVNniRQ+qqBDehGCZI0a26x+rLjI5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJQecDOi8zczqXnyttzCyGPZcXqfhy0UeVEZm9Vn976KIi1IKS2sOvt4oZtgp791yKeXOs3OTIpWS5K2KcmoYcq4osm9buoTSGm7/YTlW0JJyxbdUbLbLlZeBZ5HJf/lIwGKT+P1sW1r7h7rQS7JlZvqxB0iZPZLHpyv9pheNdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=aQh6bBBd; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c28:7d5:0:640:285a:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 38C9C6090A;
	Sat, 22 Mar 2025 17:42:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id LgNTNTXLhW20-WKjY32Dq;
	Sat, 22 Mar 2025 17:42:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654543; bh=QBUbqmvAsCghIK5yhHj+3sWNqcEXo4zIpzyn7DenPeI=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=aQh6bBBdyN/f5pSmgGVm886935yTkvvEKOzgO7NdLRi5b0D/wNP0Vt7Xw7JISw8J/
	 IoS8AcsKvcXl/qsWhTg9u0qqXv++UVtgb33MoWX30cG3hTSOzpHGxTTMQsCSL5DjVC
	 97qBHIoXjb8a9HMHQi/Dm4/fMusytW//NhwM63g8=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 36/51] ieee802154: Use fallback_nd_lock for registered devices
Date: Sat, 22 Mar 2025 17:42:21 +0300
Message-ID: <174265454113.356712.15920821128646833231.stgit@pro.pro>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174265415457.356712.10472727127735290090.stgit@pro.pro>
References: <174265415457.356712.10472727127735290090.stgit@pro.pro>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

For now we use fallback_nd_lock for all drivers registering
via ieee802154_if_add().

One of the reasons is that they are used as a bunch
in cfg802154_switch_netns(), while we want to call
dev_change_net_namespace() under nd_lock in one of
next patches.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/ieee802154/nl802154.c |    7 +++++++
 net/mac802154/cfg.c       |    2 ++
 net/mac802154/iface.c     |   10 ++++++++--
 net/mac802154/main.c      |    2 ++
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 7eb37de3add2..a512f2a647e8 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -2691,6 +2691,7 @@ static int nl802154_del_llsec_seclevel(struct sk_buff *skb,
 #define NL802154_FLAG_NEED_RTNL		0x04
 #define NL802154_FLAG_CHECK_NETDEV_UP	0x08
 #define NL802154_FLAG_NEED_WPAN_DEV	0x10
+#define NL802154_FLAG_NEED_FALLBACK_ND_LOCK	0x20
 
 static int nl802154_pre_doit(const struct genl_split_ops *ops,
 			     struct sk_buff *skb,
@@ -2700,9 +2701,12 @@ static int nl802154_pre_doit(const struct genl_split_ops *ops,
 	struct wpan_dev *wpan_dev;
 	struct net_device *dev;
 	bool rtnl = ops->internal_flags & NL802154_FLAG_NEED_RTNL;
+	bool nd = ops->internal_flags & NL802154_FLAG_NEED_FALLBACK_ND_LOCK;
 
 	if (rtnl)
 		rtnl_lock();
+	if (nd)
+		mutex_lock(&fallback_nd_lock.mutex);
 
 	if (ops->internal_flags & NL802154_FLAG_NEED_WPAN_PHY) {
 		rdev = cfg802154_get_dev_from_info(genl_info_net(info), info);
@@ -2769,6 +2773,8 @@ static void nl802154_post_doit(const struct genl_split_ops *ops,
 		}
 	}
 
+	if (ops->internal_flags & NL802154_FLAG_NEED_FALLBACK_ND_LOCK)
+		mutex_unlock(&fallback_nd_lock.mutex);
 	if (ops->internal_flags & NL802154_FLAG_NEED_RTNL)
 		rtnl_unlock();
 }
@@ -2800,6 +2806,7 @@ static const struct genl_ops nl802154_ops[] = {
 		.doit = nl802154_new_interface,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = NL802154_FLAG_NEED_WPAN_PHY |
+				  NL802154_FLAG_NEED_FALLBACK_ND_LOCK |
 				  NL802154_FLAG_NEED_RTNL,
 	},
 	{
diff --git a/net/mac802154/cfg.c b/net/mac802154/cfg.c
index ef7f23af043f..405183d258b6 100644
--- a/net/mac802154/cfg.c
+++ b/net/mac802154/cfg.c
@@ -23,8 +23,10 @@ ieee802154_add_iface_deprecated(struct wpan_phy *wpan_phy,
 	struct net_device *dev;
 
 	rtnl_lock();
+	mutex_lock(&fallback_nd_lock.mutex);
 	dev = ieee802154_if_add(local, name, name_assign_type, type,
 				cpu_to_le64(0x0000000000000000ULL));
+	mutex_unlock(&fallback_nd_lock.mutex);
 	rtnl_unlock();
 
 	return dev;
diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index c0e2da5072be..7ec23e8268de 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -664,9 +664,15 @@ ieee802154_if_add(struct ieee802154_local *local, const char *name,
 	if (ret)
 		goto err;
 
-	ret = register_netdevice(ndev);
-	if (ret < 0)
+	ret = -EXDEV;
+	if (!mutex_is_locked(&fallback_nd_lock.mutex))
+		goto err;
+	attach_nd_lock(ndev, &fallback_nd_lock);
+	ret = __register_netdevice(ndev);
+	if (ret < 0) {
+		detach_nd_lock(ndev);
 		goto err;
+	}
 
 	mutex_lock(&local->iflist_mtx);
 	list_add_tail_rcu(&sdata->list, &local->interfaces);
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 21b7c3b280b4..14bcad399dae 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -246,9 +246,11 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
 
 	rtnl_lock();
 
+	mutex_lock(&fallback_nd_lock.mutex);
 	dev = ieee802154_if_add(local, "wpan%d", NET_NAME_ENUM,
 				NL802154_IFTYPE_NODE,
 				cpu_to_le64(0x0000000000000000ULL));
+	mutex_unlock(&fallback_nd_lock.mutex);
 	if (IS_ERR(dev)) {
 		rtnl_unlock();
 		rc = PTR_ERR(dev);


