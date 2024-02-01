Return-Path: <netdev+bounces-68124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D13845E27
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07121F278AF
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1222315DBCF;
	Thu,  1 Feb 2024 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v7Ra3Uhk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723BA1292C4
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807386; cv=none; b=rkS+cExyoaE7g8MvUj9w1QjiWVbPHFWfYhe3hHxyvvO3hTlDwazo4WoPzk5JXloX4u792eiT9xTwLW5ltWKZtEslW9uai4TsFWsIO82wmLCifL79PCCWuwjpgCiEedTg7NIEzKzPKl6TutJ/DBJx9wR3EYqCDMb4u0xalldXdNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807386; c=relaxed/simple;
	bh=T+99pQGkXBrKdiTr1khPrGndHdX5hT0wcxaOc5AKFNQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WNdD31StbVxTxGBa1bDCkdEYPkUPDcmdJTI+v6DQVhQscxXce2Mu/PTNxsTSYskZQC+NehELAPaqaAbd4EYaav+ZCJdeII0P2yTEGfLT0ZKpS4ci5Hq1E4Qw10B4I20UMR3Lmg9jJaNK5aC1gTZJa6USLnfA+uMC4UBPqc3I4oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v7Ra3Uhk; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so1849586276.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706807383; x=1707412183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2D5E9Gu3MpPPnV5CXWo8iDsBmuAoodNd9wVAuyaVMs=;
        b=v7Ra3UhkWP9Ynhzu34YnehVmKJlY0y+muVg+QGWxy57ESFb0eku/+d23M/4wfX4m/6
         DtZzbX+u5FsvKOHmHEKAvCEUDasbZ/BNBBpNFj26MpaurdPJGjVx+mlS84tJzS4NDRGg
         wSYs0fDyCSZfC4htehnIashZ5zoklNJvuW3mG/KmSveBEiwVnw4cV6yb1BclRPHzG5TU
         1PQTx/NNMQkQSSPW6Ohw7E3mPDIaCCgussgEqnuJ8UBkv/7ZPcnL1MYzF5lx89/rQEvO
         uVZYiY+kxevCtM5pU2LC/FFmPGQUaNe1APe7mMhzq5kt+It7TXYMtRz4DtjXNAdcG74p
         dHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807383; x=1707412183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2D5E9Gu3MpPPnV5CXWo8iDsBmuAoodNd9wVAuyaVMs=;
        b=ECA3Eh/N7SUQJOfhEWoi01iAp+Co/hPn8sbx1wV+tlN4QFzxjvulXzsfMumnDxM1kj
         jpxWonz85fzAVqscQE+UgHbRBSK+1bRkChAHBxFxZsVmROcvJkHPhKYtO/0TTgWQrLxB
         KVd+Ypbvvw3yrScrl0guyLtv2JexLc6tZkSax90+9Ky9IRjT2uxLB4K7nbzGFrUKHGc/
         xqsd8bWNFeWqhWb5+zHIrtSf6pSz8XmK1C9e9FZ+3qu6VbGoQ9QxA+zZiNcbNiz8m5/N
         MTnrRZVg4MnboXkCr0HLW7770iaLnjwhJowyPpF36tadUF1yeUV9VoxUzhfCtwx/7Yku
         MBzg==
X-Gm-Message-State: AOJu0Yy99LGsA2OkkeGR175jZ0fLBBz8crpybsIrAR/pR2dXYYG+b0jZ
	SVVvQfosl/5mzOh0LuKzjDRSmaeIGu9nSXBOFj24iMneui4bxVOHzZH4ZZz3WMKqH1Mk8bqCHS4
	/cK5BdtJFFA==
X-Google-Smtp-Source: AGHT+IGgmi6ajeLoG0v9xgL8hWEyB7pET/NlKiHziS/ygcFE7H9bkiWxJ9drA3vaPn3bHDNIkBWAGKf8q7QBZw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:11c3:b0:dc2:398d:a671 with SMTP
 id n3-20020a05690211c300b00dc2398da671mr1393727ybu.10.1706807383425; Thu, 01
 Feb 2024 09:09:43 -0800 (PST)
Date: Thu,  1 Feb 2024 17:09:24 +0000
In-Reply-To: <20240201170937.3549878-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201170937.3549878-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201170937.3549878-4-edumazet@google.com>
Subject: [PATCH net-next 03/16] net: convert default_device_exit_batch() to
 exit_batch_rtnl method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair,
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index b53b9c94de4008aa7e808d58618675425aff0f4c..86107a9c9dd09d5590578923018be56065fbd58c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11596,7 +11596,8 @@ static void __net_exit default_device_exit_net(struct net *net)
 	}
 }
 
-static void __net_exit default_device_exit_batch(struct list_head *net_list)
+static void __net_exit default_device_exit_batch_rtnl(struct list_head *net_list,
+						      struct list_head *dev_kill_list)
 {
 	/* At exit all network devices most be removed from a network
 	 * namespace.  Do this in the reverse order of registration.
@@ -11605,9 +11606,7 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
 	 */
 	struct net_device *dev;
 	struct net *net;
-	LIST_HEAD(dev_kill_list);
 
-	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list) {
 		default_device_exit_net(net);
 		cond_resched();
@@ -11616,17 +11615,15 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
 	list_for_each_entry(net, net_list, exit_list) {
 		for_each_netdev_reverse(net, dev) {
 			if (dev->rtnl_link_ops && dev->rtnl_link_ops->dellink)
-				dev->rtnl_link_ops->dellink(dev, &dev_kill_list);
+				dev->rtnl_link_ops->dellink(dev, dev_kill_list);
 			else
-				unregister_netdevice_queue(dev, &dev_kill_list);
+				unregister_netdevice_queue(dev, dev_kill_list);
 		}
 	}
-	unregister_netdevice_many(&dev_kill_list);
-	rtnl_unlock();
 }
 
 static struct pernet_operations __net_initdata default_device_ops = {
-	.exit_batch = default_device_exit_batch,
+	.exit_batch_rtnl = default_device_exit_batch_rtnl,
 };
 
 static void __init net_dev_struct_check(void)
-- 
2.43.0.429.g432eaa2c6b-goog


