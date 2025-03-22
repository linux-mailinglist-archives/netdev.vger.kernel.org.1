Return-Path: <netdev+bounces-176884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB58A6CABA
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7151B80BC4
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE7322F150;
	Sat, 22 Mar 2025 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="pTFNzhVR"
X-Original-To: netdev@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B712F22B8BF;
	Sat, 22 Mar 2025 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654423; cv=none; b=ElR7DFy1N9tH5IcI8IuL+6H36hT2B+ENW4UEQ1qnkqQ/oRl3ILh/0ED4h6kJc3SvEEKWqSrJPtTVuuyUJyqGfYsS/bWGQ8ufvKwKK7mxVDM8ChkYtYk2moZfWIdAWXr31aSzyiu6ofn/kJBnTAtXNCYE+l3h48rHqC26G0dVPxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654423; c=relaxed/simple;
	bh=nHGJlEQdH8+nFQ4glKV5f5AgfedIHEAiUpdohiEc7yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tcl+m9S000cuSR8iixyAx29ScSCKU+04Jl1w38AdrrHmY3M6Y7KN87P0nArOymDe7JTTNbPrXwdXQ6PO4Trk8RrzwxxhgBgFUNyXuz5dHNuGMrSa+4dF/iIOJ1PdkZqOYRm2sxdiw4tOPdDRTXcTqYH7RYM6/UYioQR4wUFB/6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=pTFNzhVR; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:1984:0:640:94c0:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id C6A5660D6F;
	Sat, 22 Mar 2025 17:40:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id HeN1ilXLiSw0-jKRi7hpq;
	Sat, 22 Mar 2025 17:40:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654419; bh=ejvf7QLPyUV70Z5tPiTQwx4iyU8DNz6lXofSDZvxYu0=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=pTFNzhVRNlZUoqEdzW3JYIrd3Vd4yEWA0mZnKBOaRYYo/DrK1DFWm+mMquXqedkuU
	 qyftPfEZXNv5leZ54ce/3E4rh/I+ixYwCPAytARwRDdXJsH7v45Jfe2JfoBotv8H0/
	 XQC+NpzJvJ1FKrtltixEoF0IgtgEnYBUG9X0WbNA=
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 19/51] bpqether: Provide determined context in __register_netdevice()
Date: Sat, 22 Mar 2025 17:40:17 +0300
Message-ID: <174265441736.356712.5536182528670424751.stgit@pro.pro>
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
 drivers/net/hamradio/bpqether.c |   33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/hamradio/bpqether.c b/drivers/net/hamradio/bpqether.c
index 83a16d10eedb..bf2792f98afe 100644
--- a/drivers/net/hamradio/bpqether.c
+++ b/drivers/net/hamradio/bpqether.c
@@ -480,6 +480,7 @@ static int bpq_new_device(struct net_device *edev)
 {
 	int err;
 	struct net_device *ndev;
+	struct nd_lock *nd_lock;
 	struct bpqdev *bpq;
 
 	ndev = alloc_netdev(sizeof(struct bpqdev), "bpq%d", NET_NAME_UNKNOWN,
@@ -487,7 +488,23 @@ static int bpq_new_device(struct net_device *edev)
 	if (!ndev)
 		return -ENOMEM;
 
-		
+	err = -ENOMEM;
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
 	bpq = netdev_priv(ndev);
 	dev_hold(edev);
 	bpq->ethdev = edev;
@@ -496,19 +513,23 @@ static int bpq_new_device(struct net_device *edev)
 	eth_broadcast_addr(bpq->dest_addr);
 	eth_broadcast_addr(bpq->acpt_addr);
 
-	err = register_netdevice(ndev);
+	err = __register_netdevice(ndev);
 	if (err)
-		goto error;
+		goto err_detach;
 	bpq_set_lockdep_class(ndev);
 
 	/* List protected by RTNL */
 	list_add_rcu(&bpq->bpq_list, &bpq_devices);
-	return 0;
+unlock:
+	unlock_netdev(nd_lock);
+	return err;
 
- error:
+err_detach:
+	detach_nd_lock(ndev);
 	dev_put(edev);
+err_free:
 	free_netdev(ndev);
-	return err;
+	goto unlock;
 	
 }
 


