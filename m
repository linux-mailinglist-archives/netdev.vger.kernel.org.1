Return-Path: <netdev+bounces-176889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880C6A6CABB
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0564D7A3D52
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DB9233733;
	Sat, 22 Mar 2025 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="QaExM0DA"
X-Original-To: netdev@vger.kernel.org
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A65F22CBF4;
	Sat, 22 Mar 2025 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654460; cv=none; b=uU8O0xgaC8CqLAGDh5ptJYIOMAQLX+e1bnMwPwOpKJ06lrpagi8UwrP08SBjvmrQV6mWVm7pndiOftr0LgXWIrZhwfCi+0xN6/pRjo0LP1viBD9IjT5XnuR62mgAfwo8lM6HPBPXmaoDTxfo4Lq8bVfgeC/4YjrTHnDl1H6/vJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654460; c=relaxed/simple;
	bh=xfcE0oEemgxzLnRT89qKbw4/jsPMERcK2pa4Ej0bzuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6ekGnJuo4opFCSabamcygaeCrAEIrPk3Hh3olO5hq7qvpX0ic6uVD5vah1zFIusslJe04dUmL4PHT4tl3vXm8YU+lsK8FqpUr+TVKoZ+3lik8psr0fXUGN+LzTN4y7K8lvgBVaP1I5ndjSw1GiPCernfg4UA667HLDa6pGLA8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=QaExM0DA; arc=none smtp.client-ip=178.154.239.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:4d95:0:640:af03:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id 38CED60D88;
	Sat, 22 Mar 2025 17:40:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id seNh1lXLnGk0-6AWHxyIH;
	Sat, 22 Mar 2025 17:40:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654455; bh=zr79NYPm7UH1yKBmdHj6hbTkPhABeijb9QoXbUFqw9M=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=QaExM0DAH16qy2+gWm5Oapg8hQAyVJU/MEl1kOVpLfJJ0uY6WCficvtK7miGtDfIv
	 MkhHBtKWHqfAaxlzsrQqGDrScPzNg9hqirGoMpJpIoVndFcD6+vCs0WAGnU/58QgGh
	 ORhFEVD9nI7lty7fI9nYcldRprj8oo3qULQpF1pg=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 24/51] lapbeth: Provide determined context in __register_netdevice()
Date: Sat, 22 Mar 2025 17:40:54 +0300
Message-ID: <174265445402.356712.9364160514313425614.stgit@pro.pro>
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

In case of caller already owns nd_lock, there is
nesting without underlying that to lockdep.

So we use trylock and __register_netdevice() here.

XXX: after callers of netdevice notifyiers are converted,
we will inherit @edev nd_lock instead.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 drivers/net/wan/lapbether.c |   28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index 56326f38fe8a..793a2ed424c0 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -380,6 +380,7 @@ static int lapbeth_new_device(struct net_device *dev)
 {
 	struct net_device *ndev;
 	struct lapbethdev *lapbeth;
+	struct nd_lock *nd_lock;
 	int rc = -ENOMEM;
 
 	ASSERT_RTNL();
@@ -392,6 +393,23 @@ static int lapbeth_new_device(struct net_device *dev)
 	if (!ndev)
 		goto out;
 
+	rc = -ENOMEM;
+	nd_lock = alloc_nd_lock();
+	if (!nd_lock)
+		goto err_free;
+
+	/* This is called from netdevice notifier, which is not converted yet.
+	 * The context is unknown: either some nd_lock is locked or not. Since
+	 * @ndev is undependent of @edev (on this stage of convertation we don't
+	 * require that, we will require when we convert unregister_netdev()).
+	 * So, a new nd_lock is used for @ndev for now.
+	 * Q: Why is trylock, despite it can't fail?
+	 * A: Caller may own some other nd_lock, so lockdep will unhappy seeing
+	 * there is nested lock without mutex_lock_nested() prefix.
+	 */
+	BUG_ON(!mutex_trylock(&nd_lock->mutex));
+	attach_nd_lock(ndev, nd_lock);
+
 	/* When transmitting data:
 	 * first this driver removes a pseudo header of 1 byte,
 	 * then the lapb module prepends an LAPB header of at most 3 bytes,
@@ -415,15 +433,19 @@ static int lapbeth_new_device(struct net_device *dev)
 	netif_napi_add_weight(ndev, &lapbeth->napi, lapbeth_napi_poll, 16);
 
 	rc = -EIO;
-	if (register_netdevice(ndev))
-		goto fail;
+	if (__register_netdevice(ndev))
+		goto err_put;
+	unlock_netdev(nd_lock);
 
 	list_add_rcu(&lapbeth->node, &lapbeth_devices);
 	rc = 0;
 out:
 	return rc;
-fail:
+err_put:
 	dev_put(dev);
+	detach_nd_lock(ndev);
+	unlock_netdev(nd_lock);
+err_free:
 	free_netdev(ndev);
 	goto out;
 }


