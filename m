Return-Path: <netdev+bounces-91767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0598B3CEA
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6F01F23FFA
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 16:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B6C6BFB1;
	Fri, 26 Apr 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x3p+K496"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A70D2B9AF
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149238; cv=none; b=IbrCKbSG52BWILjK/PhZQjAN4A/IxdWtWTr0xEQMrEQVdpOoQnF1GAx3rcNxTX9wjFeVPPXRpsqA4lC4HSrs8tHH/4IHCXT6Zfrc8Ew3khqazXvwaFrilYVImyLfprtwZgcHKjJcv/BUfGdMgWaqijT0LtswoUHzvwGrLFo36S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149238; c=relaxed/simple;
	bh=ov7OGyMfaJ13DF3qZ5yyuD/qL5HOJCsmTl1VP2uWg3A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NszQ4mbKQT1tyfPAw01PQa3+/vAvUhMWhlCesgjNEiVv1SxcN4ZBvu7aIpcc0VJ8FKq8Bw3ivVGxAwafxCizXiNF8LReQlaj9KDWpV7lURPEGrRXdalI1nJXj7SpJxoyLSl+Gft1tkFsKjOfgY0oFYah7j8CgNT5L5SOVbYe7J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x3p+K496; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de549a4ea65so3884554276.0
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714149236; x=1714754036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PMnLrKYN6NMJYttA+23stt34LzesvaPOUB1dqM3kHQ4=;
        b=x3p+K496tYJxg3WBh030WsONh/qbOFaHCs+rG2pd0ODQvseGuvU4cTMTM8JUQe+ErL
         QgR47AEpsBpcppDOkQcKzAUZ/JDi3mLJjJPi0O86RNSB+EIJ77tg8mcauIn0HTpBk6/Z
         QDM8S93NmZmPjQXPaqeKTd+O74zgapFcAXrf4Yf3WQaOSWiCVXdFjnup+nFaUZDdMvMd
         3wZMUYNhyhqyzS12FgowdjvbVjh7r+V3y999RrMts+TSeE2dhjY+5y5ihu+S+AfawWK3
         Y6kZC5KuMfdws1nFEyB7JNNw2EcGQJhHFZ2hH+loZygFk1FxKZRGwO/duefM76KZUHwv
         HviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714149236; x=1714754036;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PMnLrKYN6NMJYttA+23stt34LzesvaPOUB1dqM3kHQ4=;
        b=lvFltS31LZ9PBUGrlsRDCpcIyEMEEFkTtoz+zFuh5WlHeAVuOh//MDZExVHwFW2Wwu
         HEpdJ8ofb0coDiRKPICElXOf7skr7BVvnwGGNQ4FU9kIrFiWvKZaAlDZ5PHbuBgOcNVj
         /rM2ZN7OIZANUQIPgc7qk43D7NC3PhXimE5/ChmVJWGSThol3gUASzskwZhzx9tm8oMY
         CWMTe96LIIumS4pVTH1yWBmFlKO9n8y/17ywz6+KhG4OFjKiayOrXjR9iZWWZusnWYiG
         j2+vxUesYDBvmBLzrtwsJjXDq3RCa83FTtO5y41gvJxl3WisBQMWAaYV1XyvpDRPkGrw
         /SPQ==
X-Gm-Message-State: AOJu0Yyj5nyg5aZ5/UxKF5u8R3MTwJBGShGRUk5cOu+oUyshKwYXOIXO
	r83YSrRWcynP1TLIaBeJh/4nR9acBzNbk7FQw13LXzw574YFIMAZFDHrCGgh1ZYrqbtgShYh6hg
	Ay5KIDZH05Q==
X-Google-Smtp-Source: AGHT+IH3E5x7kp+aLfk+CLj/9nVe5csEdnff+WYe01pfsxCKHpxLcgtoHuYEW48VKL/olcHb46Gi4kKF1M816Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:c12:b0:dc6:cd85:bcd7 with SMTP
 id fs18-20020a0569020c1200b00dc6cd85bcd7mr996374ybb.3.1714149236282; Fri, 26
 Apr 2024 09:33:56 -0700 (PDT)
Date: Fri, 26 Apr 2024 16:33:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240426163355.2613767-1-edumazet@google.com>
Subject: [PATCH net-next] net: hsr: init prune_proxy_timer sooner
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Lukasz Majewski <lukma@denx.de>
Content-Type: text/plain; charset="UTF-8"

We must initialize prune_proxy_timer before we attempt
a del_timer_sync() on it.

syzbot reported the following splat:

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 PID: 11 Comm: kworker/u8:1 Not tainted 6.9.0-rc5-syzkaller-01199-gfc48de77d69d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
  assign_lock_key+0x238/0x270 kernel/locking/lockdep.c:976
  register_lock_class+0x1cf/0x980 kernel/locking/lockdep.c:1289
  __lock_acquire+0xda/0x1fd0 kernel/locking/lockdep.c:5014
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
  __timer_delete_sync+0x148/0x310 kernel/time/timer.c:1648
  del_timer_sync include/linux/timer.h:185 [inline]
  hsr_dellink+0x33/0x80 net/hsr/hsr_netlink.c:132
  default_device_exit_batch+0x956/0xa90 net/core/dev.c:11737
  ops_exit_list net/core/net_namespace.c:175 [inline]
  cleanup_net+0x89d/0xcc0 net/core/net_namespace.c:637
  process_one_work kernel/workqueue.c:3254 [inline]
  process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
  kthread+0x2f0/0x390 kernel/kthread.c:388
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
ODEBUG: assert_init not available (active state 0) object: ffff88806d3fcd88 object type: timer_list hint: 0x0
 WARNING: CPU: 1 PID: 11 at lib/debugobjects.c:517 debug_print_object+0x17a/0x1f0 lib/debugobjects.c:514

Fixes: 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Lukasz Majewski <lukma@denx.de>
---
 net/hsr/hsr_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index cd1e7c6d2fc03af0498dc2ce302069699a75cca7..86127300b102fe06eaced32a979e1c8da99339a7 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -592,6 +592,7 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 
 	timer_setup(&hsr->announce_timer, hsr_announce, 0);
 	timer_setup(&hsr->prune_timer, hsr_prune_nodes, 0);
+	timer_setup(&hsr->prune_proxy_timer, hsr_prune_proxy_nodes, 0);
 
 	ether_addr_copy(hsr->sup_multicast_addr, def_multicast_addr);
 	hsr->sup_multicast_addr[ETH_ALEN - 1] = multicast_spec;
@@ -631,7 +632,6 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
 
 		hsr->redbox = true;
 		ether_addr_copy(hsr->macaddress_redbox, interlink->dev_addr);
-		timer_setup(&hsr->prune_proxy_timer, hsr_prune_proxy_nodes, 0);
 		mod_timer(&hsr->prune_proxy_timer,
 			  jiffies + msecs_to_jiffies(PRUNE_PROXY_PERIOD));
 	}
-- 
2.44.0.769.g3c40516874-goog


