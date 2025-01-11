Return-Path: <netdev+bounces-157325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDBCA09F85
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 01:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B03C188F2BA
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE2F1DDF5;
	Sat, 11 Jan 2025 00:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BnJvqBt3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D91171CD
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 00:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736555565; cv=none; b=UsNJxDg80QHPhz2yEGrDcmn6nevDMFW1GF8AcVJ0ZlVRH1LqmizRpXuXn93ht3213nqNVm3f2b/ThNaNTnS5n+7S5x3vkDcHaUg5sWQPtIPUVqWtgZ3/BB23OUDy1VKgFkh+imTwZdoGhuJ4j5Tamj26qTqBYxhU31wCz6O84GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736555565; c=relaxed/simple;
	bh=DGi0rKgB7DG2bkLrv9jz4E08p86wxkjC2IMrGQoH3dE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OfGx1QW8Iu5PwdVFA6i8exXZtrXxFqO4SaBQaTYcQeEa909A+mDviBKJw+/GGJbp0Wk15yxBjhg7YYbKSD1T+JR6jZWHiHa2xNesVvOZyhRjp+F2OMBmyAUQ5QJW74MaUlmuKIOd67UYjd+GOYokro4u0ebcSIIlFwlkmYWSq/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BnJvqBt3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef728e36d5so4800079a91.3
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 16:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736555564; x=1737160364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L0ccI2zo+APIVeQ/eCX8t3sD4HMDr7ZQ98Pm9MsBru4=;
        b=BnJvqBt3qH7lNLgVZzp+Ye1Lg0C3IEnWrXbyDHEgLr73gnwirkC+M8VNKcbUmLvT3U
         sim4AxJdRZaK9ARpp4xEM2WLjZ4NzCTCAYsUDaL0hfhj/6II0CPNx6sRXFGGR3cTl+5e
         Hd5CLMwKASb9JZa9I3N91G9mk+0EKCh8fk83k4aBgX5k21VcQdOgTbIHPgvKZJjgqaSB
         YD57VxDw3bEOt5l06Ro3+GrSNlRTQ9kW+8ZU+kh1G8NJzHRVyTc8G+lCs2nEwRpDrz77
         ZLh0+mkGzNNiRmJJuagn8Ya5CoEuiLmXpMJGRrtNdhN09XKx38gyd/1fT+QG743u8dAp
         nwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736555564; x=1737160364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0ccI2zo+APIVeQ/eCX8t3sD4HMDr7ZQ98Pm9MsBru4=;
        b=alFRKNdlZFTHg9WT3n+Etlh4tZJdd+HuYA+owwrtzEdmOzmQjahPhiU/pP/6BgXm0D
         CB3tDRoQFt1NGS3CtXQAynFiov+7GwZEN8zRperQlItadNcUMyFZ0nIpczpWbzsF51Oz
         qXvZnQSB4QeTV7OP+7CJDvwPaBqH2izDps72VGeqydGqOcJHX1ZgT1eCSkCoHpGZN6IQ
         p+NvLiPJ4UHIptnrzOIQVKytrTJtRz8W5drdNI5DkAGfHBCjBjSROld8EoPrBL1kcrx1
         6pTGx9wKFwdJAMSy5mEjdc6A1a9i84kcHlPYycS9/UkBfERXKZRnoAxOG+24lUzCYFlO
         n6gw==
X-Forwarded-Encrypted: i=1; AJvYcCVK920batwhbpHVtnzHqUF2bUt51zr3JFBndeWTO8zxK1HMT+4p2/C6r2p+bNFjbhEQjBrvgyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgI9wvhd8AmMVkA28PYiN80DqvJA6hbh+tKvYp9FyQhBV22Vol
	57XiGHyPtT8QVaFTIbXgPGNTI/WLxx3YoQaCY8qztexQMG24jWXstVFhg/8pYj1/ucZTyjMDfPU
	8u+5vbS0S2EVJXw==
X-Google-Smtp-Source: AGHT+IGBJUuz4cLHmBPMbT9IP/ci24ipV/UzhpNwl/X0DuSKrbCqNkm+OWr6ossZVsJNH0iUQ6Gs3HRq/HW8/gk=
X-Received: from pjboh12.prod.google.com ([2002:a17:90b:3a4c:b0:2da:5868:311c])
 (user=jsperbeck job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:520e:b0:2f2:ab09:c256 with SMTP id 98e67ed59e1d1-2f548f424b1mr19646846a91.33.1736555563687;
 Fri, 10 Jan 2025 16:32:43 -0800 (PST)
Date: Fri, 10 Jan 2025 16:32:38 -0800
In-Reply-To: <20250110-wildebeest-of-optimal-unity-06c308@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110-wildebeest-of-optimal-unity-06c308@leitao>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250111003238.2669538-1-jsperbeck@google.com>
Subject: [PATCH v2] net: netpoll: ensure skb_pool list is always initialized
From: John Sperbeck <jsperbeck@google.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, kuba@kernel.org, jsperbeck@google.com
Content-Type: text/plain; charset="UTF-8"

When __netpoll_setup() is called directly, instead of through
netpoll_setup(), the np->skb_pool list head isn't initialized.
If skb_pool_flush() is later called, then we hit a NULL pointer
in skb_queue_purge_reason().  This can be seen with this repro,
when CONFIG_NETCONSOLE is enabled as a module:

    ip tuntap add mode tap tap0
    ip link add name br0 type bridge
    ip link set dev tap0 master br0
    modprobe netconsole netconsole=4444@10.0.0.1/br0,9353@10.0.0.2/
    rmmod netconsole

The backtrace is:

    BUG: kernel NULL pointer dereference, address: 0000000000000008
    #PF: supervisor write access in kernel mode
    #PF: error_code(0x0002) - not-present page
    ... ... ...
    Call Trace:
     <TASK>
     __netpoll_free+0xa5/0xf0
     br_netpoll_cleanup+0x43/0x50 [bridge]
     do_netpoll_cleanup+0x43/0xc0
     netconsole_netdev_event+0x1e3/0x300 [netconsole]
     unregister_netdevice_notifier+0xd9/0x150
     cleanup_module+0x45/0x920 [netconsole]
     __se_sys_delete_module+0x205/0x290
     do_syscall_64+0x70/0x150
     entry_SYSCALL_64_after_hwframe+0x76/0x7e

Move the skb_pool list setup and initial skb fill into __netpoll_setup().

Fixes: 221a9c1df790 ("net: netpoll: Individualize the skb pool")
Signed-off-by: John Sperbeck <jsperbeck@google.com>
---
 net/core/netpoll.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 2e459b9d88eb..96a6ed37d4cc 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -627,6 +627,8 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 	const struct net_device_ops *ops;
 	int err;
 
+	skb_queue_head_init(&np->skb_pool);
+
 	if (ndev->priv_flags & IFF_DISABLE_NETPOLL) {
 		np_err(np, "%s doesn't support polling, aborting\n",
 		       ndev->name);
@@ -662,6 +664,9 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
 	npinfo->netpoll = np;
 
+	/* fill up the skb queue */
+	refill_skbs(np);
+
 	/* last thing to do is link it to the net device structure */
 	rcu_assign_pointer(ndev->npinfo, npinfo);
 
@@ -681,8 +686,6 @@ int netpoll_setup(struct netpoll *np)
 	struct in_device *in_dev;
 	int err;
 
-	skb_queue_head_init(&np->skb_pool);
-
 	rtnl_lock();
 	if (np->dev_name[0]) {
 		struct net *net = current->nsproxy->net_ns;
@@ -782,9 +785,6 @@ int netpoll_setup(struct netpoll *np)
 		}
 	}
 
-	/* fill up the skb queue */
-	refill_skbs(np);
-
 	err = __netpoll_setup(np, ndev);
 	if (err)
 		goto flush;
-- 
2.47.1.613.gc27f4b7a9f-goog


