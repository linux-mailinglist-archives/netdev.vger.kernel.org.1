Return-Path: <netdev+bounces-159486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B2BA15998
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4C7167BB9
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2644B1AAA05;
	Fri, 17 Jan 2025 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yT5cu3Ep"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761AA19CC27
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737153993; cv=none; b=VwBcwgRereeJzK6O7Q3OICADenMPXNSf7RHXQ2C61jP5M8jYw6ciWyNBAW8Tuw9qhGfV+vOqGX9CTRbhIEsCqtWXqh0RQseZDvG0HtPsYCPYjM83Peuwj0y+Mw+P5CX2rARzKbYhcr3T4+pcOqhhOvns8WMPYiKdLMVXQj9qX8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737153993; c=relaxed/simple;
	bh=ch38mf1Qz7Z72+aGvUnL888/TSFBMPBaOjq4BJoLKE4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qEoHZ5Zj7HSHnWCNsowKbRawjFB68WfR/EX12AvKrByctg6Kr2t0xgxCMj6UQyqSzy8GwPC/7K+N3+KtEKw7ClRhmO2/V2xg5S0jUctz/6VQdXdIBkU7rvq4hlXOpFii2LHKsvM41G6NrP/0p3wypXrtIhkm2vGNyip4dRdt2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yT5cu3Ep; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-467bbc77b05so52293871cf.0
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 14:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737153990; x=1737758790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xiTVIM/Up2yguvYK1VANNbiM+BrKRFHmzOrkHLuKgaQ=;
        b=yT5cu3EpMG7hm7SDlH8kslTpNteZ5qdEHCBTkkO4d1y3nq3yufBriPwNYmviJ0DpdU
         XMBPvkDju0PUUbnpYHj4Msj7QQdXxxbYh0ekAYFNp/ldiZtWEPtUrqR0YGLG3BZsH8O8
         JuwyvTyybGL+7h8DurNOdOZjtsHhLuUMwkGoQPiFINHs6mViA6JdwuM+hwfc/2EkFRvB
         aYxgOzNUUf2e9HEye2fznUD7sISsCXHV1aT/ZGAPjlwADQyV5d3WqqJCylJu57K4zFQy
         wCd0D6t6mu2saXiB+TTFPp/N2GmoLjU3cVIzSvTGZwl6LZnJswVxpJ0FR4Eg3mxCygka
         7GIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737153990; x=1737758790;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xiTVIM/Up2yguvYK1VANNbiM+BrKRFHmzOrkHLuKgaQ=;
        b=s4vGhL4hKQErvdw4ztR8pGjVI1avy3W/pmrg3j7VOIqf8QuQLXW0CpaQDwgiZDVi0X
         QLTrzn1huCYBZhv1Cb6Gw2/8UhcfLMzoJSVoMxUu2gj4tuwBw4CbUj5ZDwNZsQNsbnN8
         8G0ABbj/zBHO9MrlA1CQAFhgWYrYO9O6fU/d/nmxrQ1yzFgpHg4Dmkf2GQdrXs8xEqAN
         rUS0S1qiS94ApFg/gkngO5DlbgVO8g5Gg8ZxhKpWTbtI5nc4yG34OurVk0Ux3N1gKT0D
         GDo9/8iSm3nVvW/y8FVO4hu90t8+8PwWYUFiAvcMgKjMpZsL7bWlgZlER67tLx4bhqq1
         QVoQ==
X-Gm-Message-State: AOJu0YxgbrDIru88NaYxdBNqJOT5Yzgyvzl54OfgEHUpM8G37n6e7Aa2
	0rqvhPYZjDqdu64zO+vEE6WZt4LgMiJRFDxOkk8eXTlmdXAZjxHG7GY1fbOkgP+wsNSamgwJZYF
	k5sihUcO7HQ==
X-Google-Smtp-Source: AGHT+IFGZ4pZ6xH3G22QawKdZ+h4iTeJAu7RprRcDjTj2pVsvjBxq1sdAzNX67QH0x8Rq0eCEPXp422fVncomw==
X-Received: from qtct4.prod.google.com ([2002:a05:622a:1804:b0:46b:19df:3299])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5949:0:b0:463:5eb4:6f with SMTP id d75a77b69052e-46e12b96b2emr80763611cf.47.1737153990409;
 Fri, 17 Jan 2025 14:46:30 -0800 (PST)
Date: Fri, 17 Jan 2025 22:46:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250117224626.1427577-1-edumazet@google.com>
Subject: [PATCH net-next] net: destroy dev->lock later in free_netdev()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+85ff1051228a04613a32@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot complained that free_netdev() was calling netif_napi_del()
after dev->lock mutex has been destroyed.

This fires a warning for CONFIG_DEBUG_MUTEXES=y builds.

Move mutex_destroy(&dev->lock) near the end of free_netdev().

[1]
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
 WARNING: CPU: 0 PID: 5971 at kernel/locking/mutex.c:564 __mutex_lock_common kernel/locking/mutex.c:564 [inline]
 WARNING: CPU: 0 PID: 5971 at kernel/locking/mutex.c:564 __mutex_lock+0xdac/0xee0 kernel/locking/mutex.c:735
Modules linked in:
CPU: 0 UID: 0 PID: 5971 Comm: syz-executor Not tainted 6.13.0-rc7-syzkaller-01131-g8d20dcda404d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
 RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:564 [inline]
 RIP: 0010:__mutex_lock+0xdac/0xee0 kernel/locking/mutex.c:735
Code: 0f b6 04 38 84 c0 0f 85 1a 01 00 00 83 3d 6f 40 4c 04 00 75 19 90 48 c7 c7 60 84 0a 8c 48 c7 c6 00 85 0a 8c e8 f5 dc 91 f5 90 <0f> 0b 90 90 90 e9 c7 f3 ff ff 90 0f 0b 90 e9 29 f8 ff ff 90 0f 0b
RSP: 0018:ffffc90003317580 EFLAGS: 00010246
RAX: ee0f97edaf7b7d00 RBX: ffff8880299f8cb0 RCX: ffff8880323c9e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90003317710 R08: ffffffff81602ac2 R09: 1ffff110170c519a
R10: dffffc0000000000 R11: ffffed10170c519b R12: 0000000000000000
R13: 0000000000000000 R14: 1ffff92000662ec4 R15: dffffc0000000000
FS:  000055557a046500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd581d46ff8 CR3: 000000006f870000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  netdev_lock include/linux/netdevice.h:2691 [inline]
  __netif_napi_del include/linux/netdevice.h:2829 [inline]
  netif_napi_del include/linux/netdevice.h:2848 [inline]
  free_netdev+0x2d9/0x610 net/core/dev.c:11621
  netdev_run_todo+0xf21/0x10d0 net/core/dev.c:11189
  nsim_destroy+0x3c3/0x620 drivers/net/netdevsim/netdev.c:1028
  __nsim_dev_port_del+0x14b/0x1b0 drivers/net/netdevsim/dev.c:1428
  nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1440 [inline]
  nsim_dev_reload_destroy+0x28a/0x490 drivers/net/netdevsim/dev.c:1661
  nsim_drv_remove+0x58/0x160 drivers/net/netdevsim/dev.c:1676
  device_remove drivers/base/dd.c:567 [inline]

Fixes: 1b23cdbd2bbc ("net: protect netdev->napi_list with netdev_lock()")
Reported-by: syzbot+85ff1051228a04613a32@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/678add43.050a0220.303755.0016.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index fe5f5855593db34cb4bc31e6a637b59b9041bb73..fab4899b83f745a3c13c982775e287b1ff2f547d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11593,8 +11593,6 @@ void free_netdev(struct net_device *dev)
 		return;
 	}
 
-	mutex_destroy(&dev->lock);
-
 	kfree(dev->ethtool);
 	netif_free_tx_queues(dev);
 	netif_free_rx_queues(dev);
@@ -11621,6 +11619,8 @@ void free_netdev(struct net_device *dev)
 
 	netdev_free_phy_link_topology(dev);
 
+	mutex_destroy(&dev->lock);
+
 	/*  Compatibility with error handling in drivers */
 	if (dev->reg_state == NETREG_UNINITIALIZED ||
 	    dev->reg_state == NETREG_DUMMY) {
-- 
2.48.0.rc2.279.g1de40edade-goog


