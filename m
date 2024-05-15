Return-Path: <netdev+bounces-96582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880138C68B1
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 16:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094191F24001
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 14:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1411113FD7A;
	Wed, 15 May 2024 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgxp+u7O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5561413FD76
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783379; cv=none; b=rhjzS3jKM4UgWUjcBdHkrIkbpn/CE/0m3ZLRPKi/ZIku1ZgqYYWyYfBjtr9t++PcfsvyX73qnTpSQaNHdE9dY1/NWngtmFrgE1JrixzfKJfinKI5goJPXwEYS6QR3oFxG7fXZCT+RkWhFsi9d+HtqckGkhLX3NRXtrEyjgAVJ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783379; c=relaxed/simple;
	bh=n04Cg1/NiEMgx3UWyWEB/xkfSrqrroOSECuHQ72Kagg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lIWbLAN90/SnX5C7xRXQjRl27htVsR767/tWWPGVOh7QoiuEnZSW/e44DM/ra/XejRq8Q2kQjPslWBVytb3/H4r5L5kMCl813+8JxIXSpttILSJ1AGLSPgfv+GDx/TT+RkLsu9jUxbYyvNqdYeiVlQCYr8UVFqPhoRjWlsn63pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dgxp+u7O; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de59e612376so9625836276.3
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 07:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715783376; x=1716388176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=whFDUK5n+u7IuKJSgbLpgO8ild9yHwjFWWXjEEudQVo=;
        b=dgxp+u7OPmoOME5PlcfHjqWEGwWnlBJl2TbAkMLeIt2wwQweD77dpusqUsZZtN5yvr
         A4JZd+5zqzIS47H3dY1PNxCZwOYqJKt4q+FzIyOsrYEOC7isWUiQ0o2f3RoOMtzUvCmW
         BrsryWIszflZhIYVssNxqqchWI7gY6xsdj+fonFa0h8Z6dwGfXZ7kHVc3TSl2+UEfLnp
         upnF6Ov2VDiUqjkudZyeq+21UqzUdjT+REg6I8RIii5PeIO/1Y/MFqzRkiwRc1hCRlAD
         m3e9bgaSIPIWR6Af0QD4rsRigso/luIKu84dRCRaTJCcepZXK6nallaBRe23h4YX/gf/
         ZXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715783376; x=1716388176;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=whFDUK5n+u7IuKJSgbLpgO8ild9yHwjFWWXjEEudQVo=;
        b=apmnYyEnoeH9noZjbBMpyMRwNQr0b4f1tuc0xbFUwvrdwvMq/61MKTeI6qs0L32yS/
         wC1Eko8m92Wf5jaa308ezlc+oC3/qaqLTu0slR6IYDPeF7Zuz1Dw4G74znICNuSyMJcC
         Pm8w62i4hFRFGGjaLqElMZtGHcijPPafqudkArDqPAO8zTHQb/zjvfmWp1OGNRdpas7T
         y/zwkWQUofAlHW86jA2/eIS6iVNe9OYAFrjYQA5SkZs3WnKXsjibbiBGHPSehtFCBdPF
         2Kyk8knGbPfNDIrHlyyNZ3nbi0YxkGB+E35KfoddkcW9UffGe3uGNeQfCqSWqt8T4/wz
         6wzw==
X-Gm-Message-State: AOJu0YxerDkseGZFA7vb+bTUq0hw7lEXxpcSjaK3u5/UJhdcqmv4NUos
	RH/stC99ObgEBhKk+5Oy3zMj+EIajdOb03p9oU8JjLemwWgolrMkN6rbMj36B40HBrxFts7HQuf
	PCuzHKLYLRA==
X-Google-Smtp-Source: AGHT+IFgWdTTaqeXxnVwMWv3NmybGNLDRN8GCJBq7TPlb4j7v2v1KlH1xocy8378if/4CdozCAQEObCG/AzFGg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:aa4a:0:b0:de5:1ea2:fc6f with SMTP id
 3f1490d57ef6-dee4f1962e3mr945227276.6.1715783376042; Wed, 15 May 2024
 07:29:36 -0700 (PDT)
Date: Wed, 15 May 2024 14:29:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240515142934.3708038-1-edumazet@google.com>
Subject: [PATCH net] netrom: fix possible dead-lock in nr_rt_ioctl()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

syzbot loves netrom, and found a possible deadlock in nr_rt_ioctl [1]

Make sure we always acquire nr_node_list_lock before nr_node_lock(nr_node)

[1]
WARNING: possible circular locking dependency detected
6.9.0-rc7-syzkaller-02147-g654de42f3fc6 #0 Not tainted
------------------------------------------------------
syz-executor350/5129 is trying to acquire lock:
 ffff8880186e2070 (&nr_node->node_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 ffff8880186e2070 (&nr_node->node_lock){+...}-{2:2}, at: nr_node_lock include/net/netrom.h:152 [inline]
 ffff8880186e2070 (&nr_node->node_lock){+...}-{2:2}, at: nr_dec_obs net/netrom/nr_route.c:464 [inline]
 ffff8880186e2070 (&nr_node->node_lock){+...}-{2:2}, at: nr_rt_ioctl+0x1bb/0x1090 net/netrom/nr_route.c:697

but task is already holding lock:
 ffffffff8f7053b8 (nr_node_list_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 ffffffff8f7053b8 (nr_node_list_lock){+...}-{2:2}, at: nr_dec_obs net/netrom/nr_route.c:462 [inline]
 ffffffff8f7053b8 (nr_node_list_lock){+...}-{2:2}, at: nr_rt_ioctl+0x10a/0x1090 net/netrom/nr_route.c:697

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (nr_node_list_lock){+...}-{2:2}:
        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
        __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
        _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
        spin_lock_bh include/linux/spinlock.h:356 [inline]
        nr_remove_node net/netrom/nr_route.c:299 [inline]
        nr_del_node+0x4b4/0x820 net/netrom/nr_route.c:355
        nr_rt_ioctl+0xa95/0x1090 net/netrom/nr_route.c:683
        sock_do_ioctl+0x158/0x460 net/socket.c:1222
        sock_ioctl+0x629/0x8e0 net/socket.c:1341
        vfs_ioctl fs/ioctl.c:51 [inline]
        __do_sys_ioctl fs/ioctl.c:904 [inline]
        __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:890
        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&nr_node->node_lock){+...}-{2:2}:
        check_prev_add kernel/locking/lockdep.c:3134 [inline]
        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
        __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
        _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
        spin_lock_bh include/linux/spinlock.h:356 [inline]
        nr_node_lock include/net/netrom.h:152 [inline]
        nr_dec_obs net/netrom/nr_route.c:464 [inline]
        nr_rt_ioctl+0x1bb/0x1090 net/netrom/nr_route.c:697
        sock_do_ioctl+0x158/0x460 net/socket.c:1222
        sock_ioctl+0x629/0x8e0 net/socket.c:1341
        vfs_ioctl fs/ioctl.c:51 [inline]
        __do_sys_ioctl fs/ioctl.c:904 [inline]
        __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:890
        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
        do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(nr_node_list_lock);
                               lock(&nr_node->node_lock);
                               lock(nr_node_list_lock);
  lock(&nr_node->node_lock);

 *** DEADLOCK ***

1 lock held by syz-executor350/5129:
  #0: ffffffff8f7053b8 (nr_node_list_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
  #0: ffffffff8f7053b8 (nr_node_list_lock){+...}-{2:2}, at: nr_dec_obs net/netrom/nr_route.c:462 [inline]
  #0: ffffffff8f7053b8 (nr_node_list_lock){+...}-{2:2}, at: nr_rt_ioctl+0x10a/0x1090 net/netrom/nr_route.c:697

stack backtrace:
CPU: 0 PID: 5129 Comm: syz-executor350 Not tainted 6.9.0-rc7-syzkaller-02147-g654de42f3fc6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
  check_prev_add kernel/locking/lockdep.c:3134 [inline]
  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
  validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
  __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
  _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
  spin_lock_bh include/linux/spinlock.h:356 [inline]
  nr_node_lock include/net/netrom.h:152 [inline]
  nr_dec_obs net/netrom/nr_route.c:464 [inline]
  nr_rt_ioctl+0x1bb/0x1090 net/netrom/nr_route.c:697
  sock_do_ioctl+0x158/0x460 net/socket.c:1222
  sock_ioctl+0x629/0x8e0 net/socket.c:1341
  vfs_ioctl fs/ioctl.c:51 [inline]
  __do_sys_ioctl fs/ioctl.c:904 [inline]
  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:890
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/netrom/nr_route.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 70480869ad1c566a8ab8a28c0d39bdae056ec596..bd2b17b219ae90ae473927bc3b450d3ff207a1c2 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -285,22 +285,14 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 	return 0;
 }
 
-static inline void __nr_remove_node(struct nr_node *nr_node)
+static void nr_remove_node_locked(struct nr_node *nr_node)
 {
+	lockdep_assert_held(&nr_node_list_lock);
+
 	hlist_del_init(&nr_node->node_node);
 	nr_node_put(nr_node);
 }
 
-#define nr_remove_node_locked(__node) \
-	__nr_remove_node(__node)
-
-static void nr_remove_node(struct nr_node *nr_node)
-{
-	spin_lock_bh(&nr_node_list_lock);
-	__nr_remove_node(nr_node);
-	spin_unlock_bh(&nr_node_list_lock);
-}
-
 static inline void __nr_remove_neigh(struct nr_neigh *nr_neigh)
 {
 	hlist_del_init(&nr_neigh->neigh_node);
@@ -339,6 +331,7 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 		return -EINVAL;
 	}
 
+	spin_lock_bh(&nr_node_list_lock);
 	nr_node_lock(nr_node);
 	for (i = 0; i < nr_node->count; i++) {
 		if (nr_node->routes[i].neighbour == nr_neigh) {
@@ -352,7 +345,7 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 			nr_node->count--;
 
 			if (nr_node->count == 0) {
-				nr_remove_node(nr_node);
+				nr_remove_node_locked(nr_node);
 			} else {
 				switch (i) {
 				case 0:
@@ -367,12 +360,14 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 				nr_node_put(nr_node);
 			}
 			nr_node_unlock(nr_node);
+			spin_unlock_bh(&nr_node_list_lock);
 
 			return 0;
 		}
 	}
 	nr_neigh_put(nr_neigh);
 	nr_node_unlock(nr_node);
+	spin_unlock_bh(&nr_node_list_lock);
 	nr_node_put(nr_node);
 
 	return -EINVAL;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


