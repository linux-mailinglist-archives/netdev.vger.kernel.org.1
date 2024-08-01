Return-Path: <netdev+bounces-114903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB3E944A3B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87CC282E6F
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C331898E4;
	Thu,  1 Aug 2024 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8Z+qnN8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF47170A14;
	Thu,  1 Aug 2024 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511209; cv=none; b=K3Xq8aKhubV0BtFnxryGmDiURLQ/ePBckd0mdZ+jmJ40bTJQRo+X6mzKnqaopJYuQXOwryCH5jBx6GzROVnSCXdZRtIl9q6isOUzj/KfE7W9rKjgsr6QWgcxI5fDmzu1wNQhKptCWjFz9H01eZe9dugrVx/etDTdOJGp4zFaALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511209; c=relaxed/simple;
	bh=H75Gd55t5dSpOM07iQzfr2rSjZFvec2rujGmbrqv24I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g1LeK33b4OBbWnW+nXiIUWcpPA67QBMyv++0F0HcHTkEYLQwZ0fXYtEIcniLv07V2zLQcGBTI3O45gurEOQjds3gDASnP/vehlyB8u/bQuZ2BIzeG6aqgegpVxWi7BF61IUAVH/KbsEk+1v6dGLFVkspbiKBZNiGcZTNYXNX4J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8Z+qnN8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fd78c165eeso59581845ad.2;
        Thu, 01 Aug 2024 04:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722511206; x=1723116006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QF9E215igExM0Zrrh5mF1HmIwfBoXfOQkWOF/xjHtnk=;
        b=j8Z+qnN81B5DRQEdTfCBOCCbAEumT0NpDv+WxT2Ai/wVKX3OlFzlDQ8KRvlXwJAaBm
         Hl8A31gHyp8YqTEqs6roCjjGb1Kpm/qUVhZpAx+tcFQ4uK+SWhB5o3EhNQ6wAmkFQMuY
         J+SfWLlh2yFGWvyE6sbkyA8cTBxN0dphWaKeKSR51Nh3vDvvkVbznviB6YfudgrvQoZ0
         32JVGBUnSeiRsFEd9qkuaELq7QcRZCoJs7aeYdQ1FGMoJpD5/b6NjlR12DgFrx1jb3vR
         +Cm8fKos9tL84AT+pGLXIKLdd8Jti8eA1fK67hc8nWfnGPX12pJTOTlprVaYmjOVVfwc
         w4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722511206; x=1723116006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QF9E215igExM0Zrrh5mF1HmIwfBoXfOQkWOF/xjHtnk=;
        b=gTNsgSWZgkI1LLL8ksac6ngARJAwvpM+xcObddPl9JofIIzvR5ebIJUmCBD1iVL+lH
         MC5USNWhaPYBHLpHfIg0hXTexEde/kFyaqnNlfy6vTzo3IC8tHkpOL/u2fpHl9fjln+o
         g8OnwU0YlFjIMZKge+XrLZpkh9mzNVmkd4vx87YU58Tnuf+dSEvC7TuDf7Yywno6gDjM
         0OjGRZLm7LxMZKqU93kYqhNyNoAU46oTCmKVGiIc7E9+PUjkE1iz7pQXdUwRCebSDUJA
         KfAY/aGbacYgBVN8dVZlTAEwJrzzBs2VDsX6IvDB9qURlYvABwTkbQaahJeLbO6AkkbD
         jhsw==
X-Forwarded-Encrypted: i=1; AJvYcCXXxYHQiuTEeeaTjWa5xNDbTEeFmmlPbQB2TLmuC4lAX6YUU+BZl46FY6VWqeczfkTFZ9NUGsqKLZeru7DD7jlcGg3khOzRyF+dV6PzvUywQY7eEnAiKaoxs4F7gmNz6KHmorrc
X-Gm-Message-State: AOJu0YxUYPR31O5FGR+mx9aLPJed5iIbPJ/2PUtOAcM6q1PfiyduX/HX
	GMAQ2+Usz2TpwNu5y4plaunhGiGMQX/qEWO/YwQDiWmWZsGzC2fm
X-Google-Smtp-Source: AGHT+IF6xT3FI3bebFLEnOvocp5XiY5B2l4beedOXxR908Wy1uD5Wrvv8oeUIsuok46ApnCMMFUXdw==
X-Received: by 2002:a17:902:cf07:b0:1ff:458e:8dfc with SMTP id d9443c01a7336-1ff4ce75217mr33126595ad.16.1722511206000;
        Thu, 01 Aug 2024 04:20:06 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fcd252sm136215785ad.285.2024.08.01.04.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 04:20:05 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: jiri@resnulli.us
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net] team: fix possible deadlock in team_port_change_check
Date: Thu,  1 Aug 2024 20:18:42 +0900
Message-Id: <20240801111842.50031-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In do_setlink() , do_set_master() is called when dev->flags does not have
the IFF_UP flag set, so 'team->lock' is acquired and dev_open() is called,
which generates the NETDEV_UP event. This causes a deadlock as it tries to
acquire 'team->lock' again.

To solve this, I modified team_port_change_check to check if 'team->lock' 
has already been acquired and not acquire the lock again if it has been 
acquired in the upper function.

============================================
WARNING: possible recursive locking detected
6.11.0-rc1-syzkaller-ge4fc196f5ba3-dirty #0 Not tainted
--------------------------------------------
syz.0.15/5889 is trying to acquire lock:
ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_port_change_check drivers/net/team/team_core.c:2950 [inline]
ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_device_event+0x2c7/0x770 drivers/net/team/team_core.c:2973

but task is already holding lock:
ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_add_slave+0x9c/0x20e0 drivers/net/team/team_core.c:1975

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(team->team_lock_key#2);
  lock(team->team_lock_key#2);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz.0.15/5889:
 #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
 #1: ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_add_slave+0x9c/0x20e0 drivers/net/team/team_core.c:1975

stack backtrace:
CPU: 1 UID: 0 PID: 5889 Comm: syz.0.15 Not tainted 6.11.0-rc1-syzkaller-ge4fc196f5ba3-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 check_deadlock kernel/locking/lockdep.c:3061 [inline]
 validate_chain kernel/locking/lockdep.c:3855 [inline]
 __lock_acquire+0x2167/0x3cb0 kernel/locking/lockdep.c:5142
 lock_acquire kernel/locking/lockdep.c:5759 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 team_port_change_check drivers/net/team/team_core.c:2950 [inline]
 team_device_event+0x2c7/0x770 drivers/net/team/team_core.c:2973
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1994
 call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
 call_netdevice_notifiers net/core/dev.c:2046 [inline]
 __dev_notify_flags+0x12d/0x2e0 net/core/dev.c:8876
 dev_change_flags+0x10c/0x160 net/core/dev.c:8914
 vlan_device_event+0xdfc/0x2120 net/8021q/vlan.c:468
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1994
 call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
 call_netdevice_notifiers net/core/dev.c:2046 [inline]
 dev_open net/core/dev.c:1515 [inline]
 dev_open+0x144/0x160 net/core/dev.c:1503
 team_port_add drivers/net/team/team_core.c:1216 [inline]
 team_add_slave+0xacd/0x20e0 drivers/net/team/team_core.c:1976
 do_set_master+0x1bc/0x230 net/core/rtnetlink.c:2701
 do_setlink+0x306d/0x4060 net/core/rtnetlink.c:2907
 __rtnl_newlink+0xc35/0x1960 net/core/rtnetlink.c:3696
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6647
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x544/0x830 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab5/0xc90 net/socket.c:2597
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc07ed77299
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc07fb7f048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fc07ef05f80 RCX: 00007fc07ed77299
RDX: 0000000000000000 RSI: 0000000020000600 RDI: 0000000000000012
RBP: 00007fc07ede48e6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fc07ef05f80 R15: 00007ffeb5c0d528

Reported-by: syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/net/team/team_core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..4ac6e55998ec 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2946,10 +2946,22 @@ static void __team_port_change_port_removed(struct team_port *port)
 static void team_port_change_check(struct team_port *port, bool linkup)
 {
 	struct team *team = port->team;
+	bool flag = true;
 
-	mutex_lock(&team->lock);
+	if (mutex_is_locked(&team->lock)){
+		unsigned long owner, curr = (unsigned long)current;
+		owner = atomic_long_read(&team->lock.owner);
+		if (owner != curr)
+			mutex_lock(&team->lock);
+		else
+			flag = false;
+	}
+	else{
+		mutex_lock(&team->lock);
+	}
 	__team_port_change_check(port, linkup);
-	mutex_unlock(&team->lock);
+	if (flag)
+		mutex_unlock(&team->lock);
 }
 
 
--

