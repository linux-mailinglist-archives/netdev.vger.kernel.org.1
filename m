Return-Path: <netdev+bounces-210395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC92EB1311A
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 20:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3758A3ACAE6
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 18:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A173D221D92;
	Sun, 27 Jul 2025 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyiNhTRZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD617080D;
	Sun, 27 Jul 2025 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753639777; cv=none; b=QlIByU/ildih3YgV9aznZaVVK1m6A6NTYadeMIl9/dxixFgR1sY/nKIRNRSggK5elu9y1c9f2ZUJfEKbb+W3bZFvuHdikVDGE/4yJsGZS2CSe/t1zFVtKVYjd58dYmXU2WwLQy6M3EaqJIE+KjeapB7iA6L0drp66sNWffjZFCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753639777; c=relaxed/simple;
	bh=O+BpqwEczXWMhEXZm6ykkpN4lufTBE8sZIGAn34h9rU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TvlHwiMbyU33H3XIjwekG866Z6bKyubng97VGucsiM0G9x5pLOmCGTNhouAcuuwLBnKHj06+TD8S06gTHgf5IYD2feo3qSmrwsUO66MS/QWDwiznpnSNtZS5dClYZvo4QD1ilvLU5g7dDHN8aX6dGXH6fJAsE5LFQvXMECjOzsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyiNhTRZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74264d1832eso4131976b3a.0;
        Sun, 27 Jul 2025 11:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753639775; x=1754244575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ciu+q/Bj1WiuHIrfWpXzED10TyzycVbw98Jx3XFVwsA=;
        b=CyiNhTRZ3I4EmtJrVEQOIG8Bkf4W46N3Dgk5ivs+mQFp3/ccopN6KXUYDhalGU3YUg
         6wcbI9k/W1DmviO1ajLkn7JRDOXBfPYJWgIUbSJNoQb2enQDPkQbbPj2KimzgooeR6ZW
         rGstUfwCkhTX2uo6CS/Yy4IEUW1t3qAbHgRxnBGJcJOqrat6mUYNcb5FPOdl1VLmnew7
         dVRGHoAMw8k6v7xd4U39kBtSEdjU73Ac5crj3NqNalnBCl8fGF9VGATZpVfJvrtHCFyK
         lZdj3x9IySnqNUg5xTfRiU00xEokgR1mVTLiXeED4vx8ijGFk841W9Be5jsqbIHdY8I5
         xdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753639775; x=1754244575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ciu+q/Bj1WiuHIrfWpXzED10TyzycVbw98Jx3XFVwsA=;
        b=XcvIyBmlREfv2Lvl0/mobytXn/jbqhhU6jsanGQOY27SxVJq9oLpc2gswlXdcu8W3L
         bpYje7cQoXp86TgsmLlE/CDN5ZBu3H5Flp/f3bc6bW0uAjDC0pCA7fcbx5dIEZgkXOmi
         sLDBJD1ZBb2k3fy7SEQfcrzRTQ04N2vMH28dxaTxb3+1vrQedM8kksDoeP/o9rQdpJXF
         YCQrCqOCttGWb9wWCwhDBMDZVvQK4BX0hmCj7otRVVMdeSsVfvwQLN5RCOzilrl+FIE0
         yjjL0yWp0TAo1f0085TfRakKL0+ccJmumymez1jqb6A2K08tgTCjy1b9QQzm8pwFY4py
         A5YA==
X-Forwarded-Encrypted: i=1; AJvYcCU52ERlKt+D6FDd1MIdsijj6XQWgCQsgnIWKo1HdaLmpgwVuZJdapxN3nwZuUgaUuRaywA5d9ka@vger.kernel.org, AJvYcCWl2Vt3KjYw8o4np7psQUHQA1N20YMWJFEr0Ugo5ENlPhSXxTMT+9VDdB5UiAGuqtuchjSgZTGeSCEd5/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1X9/bJZKf2mtTTW/THl976f3SMSYogCas37E97vqNroQWEBZs
	9SLAcrbpn2T0Y5UaewxuGDKVI6zloBmXzPqjECHW4enM4vDaayX76AA=
X-Gm-Gg: ASbGncvkHwznNvajbfVwo/P/phS1GItbCeV2bcoDiIZHz/6NF7ROiUf8r5NWkFoXyup
	0CoKjfEcjOCnjQQo1QkArIU742TmAxfhttHcPUzWltanAi9/OSozsITqwiKhd21AksX18tSjY5m
	dguK2sZEuGettYSwlCHkSMxSUd3JMQAFOSzvXgGQZC45iVTG6AWQbCHdqF92IUB7r4miE/Y3A1H
	GuadlieaHonlVEcK8REW3Ns0ggSGjS0PLGPqRw/3OaRuFJTneAdYOaCN3OW1eePr7kHLtxPji/G
	X9T+OaOHOdrp8rr+1RmmebQjuZZHFzysmOPg4ggXvtMhKviddKj36joGesIuTyYLfnQI3wbULip
	OMr3MoWa+k8gBGt4jyQ/aPKPL0vSojNpOfQ==
X-Google-Smtp-Source: AGHT+IEK0ZGdojIczy+SlE4GBAY1zuVft6Agkj3s2A6CtvVOIIbJuZ9Bqi/gYumUp1Ie+iguuYJPzQ==
X-Received: by 2002:a05:6a00:10cb:b0:748:f750:14c6 with SMTP id d2e1a72fcca58-76336f1bcb7mr13734718b3a.14.1753639775116;
        Sun, 27 Jul 2025 11:09:35 -0700 (PDT)
Received: from debian.ujwal.com ([223.185.134.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b2de4dbsm3823868b3a.114.2025.07.27.11.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 11:09:34 -0700 (PDT)
From: Ujwal Kundur <ujwal.kundur@gmail.com>
To: syzbot+8182574047912f805d59@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	jiri@resnulli.us,
	andrew+netdev@lunn.ch,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: [RFC PATCH] net: team: switch to spinlock in team_change_rx_flags
Date: Sun, 27 Jul 2025 23:39:21 +0530
Message-Id: <20250727180921.360-1-ujwal.kundur@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <68712acf.a00a0220.26a83e.0051.GAE@google.com>
References: <68712acf.a00a0220.26a83e.0051.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller reports the following issue:
BUG: sleeping function called from invalid context in
team_change_rx_flags

3 locks held by syz.1.1814/12326:
 #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8fa21eb8 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
 #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff8f51c5c8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x8db/0x1c70 net/core/rtnetlink.c:4054
 #2: ffff8880635e8368 (&macsec_netdev_addr_lock_key#2/2){+...}-{3:3}, at: netif_addr_lock_bh include/linux/netdevice.h:4805 [inline]
 #2: ffff8880635e8368 (&macsec_netdev_addr_lock_key#2/2){+...}-{3:3}, at: dev_uc_add+0x67/0x120 net/core/dev_addr_lists.c:689
Preemption disabled at:
[<ffffffff895a7d26>] local_bh_disable include/linux/bottom_half.h:20 [inline]
^^^^
[<ffffffff895a7d26>] netif_addr_lock_bh include/linux/netdevice.h:4804 [inline]
[<ffffffff895a7d26>] dev_uc_add+0x56/0x120 net/core/dev_addr_lists.c:689
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4833 [inline]
 check_wait_context kernel/locking/lockdep.c:4905 [inline]
 __lock_acquire+0xbcb/0xd20 kernel/locking/lockdep.c:5190
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 __mutex_lock_common kernel/locking/mutex.c:602 [inline]
 __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
 team_change_rx_flags+0x38/0x220 drivers/net/team/team_core.c:1781
 dev_change_rx_flags net/core/dev.c:9241 [inline]
 __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
 netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9305
 dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:287
 dev_change_rx_flags net/core/dev.c:9241 [inline]
 __dev_set_promiscuity+0x534/0x740 net/core/dev.c:9285
 __dev_set_rx_mode+0x17c/0x260 net/core/dev.c:-1
 dev_uc_add+0xc8/0x120 net/core/dev_addr_lists.c:693
 macsec_dev_open+0xd9/0x530 drivers/net/macsec.c:3634
 __dev_open+0x470/0x880 net/core/dev.c:1683
 __dev_change_flags+0x1ea/0x6d0 net/core/dev.c:9458
 rtnl_configure_link net/core/rtnetlink.c:3577 [inline]
 rtnl_newlink_create+0x555/0xb00 net/core/rtnetlink.c:3833

mutex_lock/mutex_unlock are called from team_change_rx_flags with
BH disabled (caused by netif_addr_lock_bh). Switch to spinlock instead
to avoid sleeping with BH disabled.

Reported-by: syzbot+8182574047912f805d59@syzkaller.appspotmail.com
Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
---
 drivers/net/team/team_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 8bc56186b2a3..4568075fea6e 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1778,7 +1778,7 @@ static void team_change_rx_flags(struct net_device *dev, int change)
 	struct team_port *port;
 	int inc;
 
-	mutex_lock(&team->lock);
+	spin_lock(&team->lock);
 	list_for_each_entry(port, &team->port_list, list) {
 		if (change & IFF_PROMISC) {
 			inc = dev->flags & IFF_PROMISC ? 1 : -1;
@@ -1789,7 +1789,7 @@ static void team_change_rx_flags(struct net_device *dev, int change)
 			dev_set_allmulti(port->dev, inc);
 		}
 	}
-	mutex_unlock(&team->lock);
+	spin_unlock(&team->lock);
 }
 
 static void team_set_rx_mode(struct net_device *dev)
-- 
2.30.2


