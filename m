Return-Path: <netdev+bounces-176908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EACB0A6CAE7
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53C91B854EE
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F4522E00A;
	Sat, 22 Mar 2025 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="Rnn5OZa3"
X-Original-To: netdev@vger.kernel.org
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F1F22DFAC;
	Sat, 22 Mar 2025 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654605; cv=none; b=nJ9m9XMJKj/+ugI9lCAfR/XggjB9CrBjVm/BEDx8vJERsOIodemb7aieMZgv1eauaE8WrFz35Jml+az2ahhqtHe+WuzzEVhkzjI5xlU6dsXw8bom9DAiX9iaoruizZeHasv/X55LqC9a0f1vVxolOu/szHMq6ehn8cf9mwc2GdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654605; c=relaxed/simple;
	bh=ceJ+ld8GK2hTE4R0da3ga13CnqqvABPLLEWJMVTvGwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcD99lUleO6co4CnekG6gnJiXmFmijfbBSXPRyOE+mg5tEKVOg+nzKoalmh2+TTGY8Gdu/39SChNYrFxJljl/Fx1vM+ondErgn3U1NNYKtnOTTh8380b1+fk63AtT9DzAK7dq/BAvdlijdMo1Kt+HFhjJWwNI4QpRQ6FFDIpbbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=Rnn5OZa3; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:3b21:0:640:4c47:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 5D373608DE;
	Sat, 22 Mar 2025 17:43:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JhNg5bKLgiE0-bcIXSRaH;
	Sat, 22 Mar 2025 17:43:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654601; bh=SoAWeIw1GgzB+kiMucC6Uk1pCyq9gpNjBI/GW/fyMx4=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=Rnn5OZa3Dlmo3hSKWToOM3n21GBxRyuGpgwqv+WgQyBlbj2BABA/7vimnfrHEeBK0
	 vNKbz7i69Mr2LY8OnPla6+4gfTeNfZbVNIbhwtllfP0yimqlUUoU/UCV/6lgzdThfk
	 PePNwi5A5zawn+1QPKJCEu9djb4/wgB/BT7G6PnM=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 44/51] net: Call dellink with nd_lock is held
Date: Sat, 22 Mar 2025 17:43:19 +0300
Message-ID: <174265459943.356712.7940535357040025086.stgit@pro.pro>
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

After previous patches all linked devices share the same lock.
Here we add nd_lock around dellink to start making calls of
unregister_netdevice() under nd_lock is locked.

One more good thing is many netdev_upper_dev_unlink() becomes
called under nd_lock is held, but not all yet.

Note, that ->dellink called from netdevice notifiers are not
braced yet.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/core/dev.c       |    3 +++
 net/core/rtnetlink.c |   10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 55df8157bca9..f0f93b5a2819 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12399,6 +12399,7 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
 	 * Do this across as many network namespaces as possible to
 	 * improve batching efficiency.
 	 */
+	struct nd_lock *nd_lock;
 	struct net_device *dev;
 	struct net *net;
 	LIST_HEAD(dev_kill_list);
@@ -12411,10 +12412,12 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
 
 	list_for_each_entry(net, net_list, exit_list) {
 		for_each_netdev_reverse(net, dev) {
+			lock_netdev(dev, &nd_lock);
 			if (dev->rtnl_link_ops && dev->rtnl_link_ops->dellink)
 				dev->rtnl_link_ops->dellink(dev, &dev_kill_list);
 			else
 				unregister_netdevice_queue(dev, &dev_kill_list);
+			unlock_netdev(nd_lock);
 		}
 	}
 	unregister_netdevice_many(&dev_kill_list);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 67b4b0610d14..fdc06f0ecf31 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -449,12 +449,15 @@ EXPORT_SYMBOL_GPL(rtnl_link_register);
 
 static void __rtnl_kill_links(struct net *net, struct rtnl_link_ops *ops)
 {
+	struct nd_lock *nd_lock;
 	struct net_device *dev;
 	LIST_HEAD(list_kill);
 
 	for_each_netdev(net, dev) {
+		lock_netdev(dev, &nd_lock);
 		if (dev->rtnl_link_ops == ops)
 			ops->dellink(dev, &list_kill);
+		unlock_netdev(nd_lock);
 	}
 	unregister_netdevice_many(&list_kill);
 }
@@ -3260,9 +3263,12 @@ static int rtnl_group_dellink(const struct net *net, int group)
 	for_each_netdev_safe(net, dev, aux) {
 		if (dev->group == group) {
 			const struct rtnl_link_ops *ops;
+			struct nd_lock *nd_lock;
 
 			ops = dev->rtnl_link_ops;
+			lock_netdev(dev, &nd_lock);
 			ops->dellink(dev, &list_kill);
+			unlock_netdev(nd_lock);
 		}
 	}
 	unregister_netdevice_many(&list_kill);
@@ -3273,13 +3279,17 @@ static int rtnl_group_dellink(const struct net *net, int group)
 int rtnl_delete_link(struct net_device *dev, u32 portid, const struct nlmsghdr *nlh)
 {
 	const struct rtnl_link_ops *ops;
+	struct nd_lock *nd_lock;
 	LIST_HEAD(list_kill);
 
 	ops = dev->rtnl_link_ops;
 	if (!ops || !ops->dellink)
 		return -EOPNOTSUPP;
 
+	lock_netdev(dev, &nd_lock);
 	ops->dellink(dev, &list_kill);
+	unlock_netdev(nd_lock);
+
 	unregister_netdevice_many_notify(&list_kill, portid, nlh);
 
 	return 0;


