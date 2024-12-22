Return-Path: <netdev+bounces-153954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D089FA33A
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 02:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE16188AD38
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 01:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2D5646;
	Sun, 22 Dec 2024 01:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TafEfkCp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8D525948C
	for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 01:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734830620; cv=none; b=gFyKmGZL93tKR0YGhf183ZaBzbvZsx7HVDXUb1WE+zufuKCTKNt1aAs4K7FeUQxJDPf2Yt/iO/Y5O+GVmP3xCc/HPUFVKgTawl2dY/2Yv85LY/yySudTVlLMYDvu8WJU6enkgB0gMr1GLFeb0ySp3hBFnItpDm3eA07KmhK05RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734830620; c=relaxed/simple;
	bh=2mQOk3Ule0amGXjlRZK5chQr/0DO/Q966CoijfUichs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kQ6LU8TbmPWGcisJkmIR9pGp0nY3kLXKHzoKfwJG52s5lLpzmziNSMGwNkhMrjJvZXTYMf+eFABv8EiDxUrj3Du4b1aNqiplFy5uHXDxbi7cweuUfz752HFKLRLnzu9Y8BgbQ8GfeaSZgmYQkOdIkmbsCFso4gNX8sTwbMDIuwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TafEfkCp; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-728eda1754eso4247722b3a.2
        for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 17:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734830618; x=1735435418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+l9BoWLrhBAuCzd7c37WzGlNIO0V229/bnZinxzODSM=;
        b=TafEfkCpDTZOK8FiAaHR8Zy7/X1uOriZgSx43o1AfvPnhEmxSSzP5oM9l2leUreVIn
         gJJDphj8dT25+NJEG5fKySX2Xm26yWXSHBOGRpl2c2AneOoYWVLqo886/sHQlOZhnZYI
         s6lKj5zMygo70WYzkCVV3afUmCORKBfR+kFW3BRaDYHcsIITdr4wnn3NuCvXJti+0ZpP
         0+q8nxVjZqDkpKnmPi7G5JWCnK+bAAirWaeuhRZbJfnvEXEDs8PIlv/ziAbQvBJvDsr6
         ocQ+ndhI6ps7AZtdnZ7Gw2u/hM344KRbmwkI6lvBgVc6HKlquhNSMjnUzRW1Fox1ZF9c
         k14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734830618; x=1735435418;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+l9BoWLrhBAuCzd7c37WzGlNIO0V229/bnZinxzODSM=;
        b=mQZR0KLn/qy9QuTutAtE5PU7zhfmgOA31diZxdSs5fnmtHRfWCMgK+lEdRlhDRq1ua
         FMxwLG1fpc9C+DvpuWyz/DhYMtWEHSvLRAaMXZftBZyK5aAE4xrPdb4z7ia0wqUXYKg7
         4Ghuyh0ic02k+lWTQP6mG2qyduO0EJX3hWnp/DL/xXwNdU0DWsmu9a5SU9BxtLbqPJsi
         PQXRk0IyZZmnYdbTgSbda7UY42lqXsHf8TzlEIkPITH9eAWsHtXbsJn6/JnqJf/ZgF7z
         kZ8WalwJZ9csplmOUH86LdctzUpbyP5n2nOi5M27uO+8c4WXhrrZ9R/fhakzl4J4UN7v
         OxEg==
X-Forwarded-Encrypted: i=1; AJvYcCXSXaaUkhyKm1EszHTjzuW/JxPR3eOEsTEyCT1XI70tugCHEDJzAfiuBpooza60i4Nk2CVWWLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhGrL8J72b3kQOVy49Mvu5/60/tye0mizX2dSvHlHhZRSw+cQU
	qEt5uvKRWAlAZsbiHVyKXeos8hXZz99suejVAO7vDJQ9mA1y3wiORlnNvvVifmMEpwF1othLJ75
	voMDOxvqKjRXE2Q==
X-Google-Smtp-Source: AGHT+IF/URYA8sLQnwKaZ9edjm6Q2KfG4LYNW3ai6c/GyaoHer/DWgbznGk7FiVlqeRS3kh/H6wXEOppNdQ+e8Y=
X-Received: from pfbdw23.prod.google.com ([2002:a05:6a00:3697:b0:728:e3af:6ba5])
 (user=jsperbeck job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4c07:b0:72a:9ddf:55ab with SMTP id d2e1a72fcca58-72abdd9c06dmr12517674b3a.10.1734830618070;
 Sat, 21 Dec 2024 17:23:38 -0800 (PST)
Date: Sat, 21 Dec 2024 17:23:34 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241222012334.249021-1-jsperbeck@google.com>
Subject: [PATCH] net: netpoll: ensure skb_pool list is always initialized
From: John Sperbeck <jsperbeck@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Breno Leitao <leitao@debian.org>, 
	John Sperbeck <jsperbeck@google.com>, linux-kernel@vger.kernel.org
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

Move the skb_pool list initialization into __netpoll_setup().  Also,
have netpoll_setup() call this before allocating its initial pool of
packets.

Fixes: 6c59f16f1770 ("net: netpoll: flush skb pool during cleanup")
Signed-off-by: John Sperbeck <jsperbeck@google.com>
---
 net/core/netpoll.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 2e459b9d88eb..61662390414e 100644
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
@@ -681,8 +683,6 @@ int netpoll_setup(struct netpoll *np)
 	struct in_device *in_dev;
 	int err;
 
-	skb_queue_head_init(&np->skb_pool);
-
 	rtnl_lock();
 	if (np->dev_name[0]) {
 		struct net *net = current->nsproxy->net_ns;
@@ -782,17 +782,16 @@ int netpoll_setup(struct netpoll *np)
 		}
 	}
 
+	err = __netpoll_setup(np, ndev);
+	if (err)
+		goto put;
+
 	/* fill up the skb queue */
 	refill_skbs(np);
 
-	err = __netpoll_setup(np, ndev);
-	if (err)
-		goto flush;
 	rtnl_unlock();
 	return 0;
 
-flush:
-	skb_pool_flush(np);
 put:
 	DEBUG_NET_WARN_ON_ONCE(np->dev);
 	if (ip_overwritten)
-- 
2.47.1.613.gc27f4b7a9f-goog


