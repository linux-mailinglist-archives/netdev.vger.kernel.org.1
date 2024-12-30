Return-Path: <netdev+bounces-154568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8439B9FEAB9
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43BD7188263E
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 20:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C545319C540;
	Mon, 30 Dec 2024 20:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCkHCIx9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309F319ABA3
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735592212; cv=none; b=Se/LGltE5+U0YPq6TFoUVB/ps7TuQLVCchCwShEg5PG5rih21EKMi08hcdFd8TNOMqAmRWxfqSM0pTD4OArFvZb+HUPztB0N3Far5xC6E4Sr1NxFKQ5Y/+UeLSbtcDp1Qbv3Viq6Yq4tOxHUWsfgimkM/IxTnka6B/1aesd6uLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735592212; c=relaxed/simple;
	bh=j2D52kuKVc8PdXh5iBwWE6iH872br4xYjeDlPKjkWlo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hI3FrnwdRwqpXR+LYrBfv9qgTbGtCD/OHewRXcKTvxD2vcfW9uFCSuplDFR0+RjLv2pqQWX40Nvnbmz9vySaAjEsvqodWmDbqNhxNnfOL7mWeONurCszhlogyuRpcSjVL4Jh3lcq8ZcEbJE67Sjyd7aOegAb9+AAbA6Pa9vHFhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jCkHCIx9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef80d30df1so12474776a91.1
        for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 12:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735592210; x=1736197010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/IJ3/vDz1j4Lld4GkSUwDYnIdXaW9w4G+aljgcCdr/s=;
        b=jCkHCIx96l2pJpUQM026lA00A4d7m/82smzmro4OO3rEBGy1G7tPd5BXu0SDKs928r
         ll/SBLBkEZb/AF5eDHnS8PxU9ELQm5qrqQU/6+Bv03/S3nNSVa6CffD3ut7e+w3QSllH
         8V4xXlO7TuDXX1UoM4yVbFW6aC1+dMza3TLIoN7Po9xv01/37VGM82Vmt68UdSSZe++u
         xkhG1HqW/w5rnDJ415lBHyQD5kccLHETmH5+xAKKSoz/J29vd7UOKO0CVtMs4AvKMs5H
         OcYf8GoAG/TrViDkOhD7Tnu+0JAr0Fuc/u5ZGkvW81xpBKH+EeI7kfgH7bS3XYMxltLD
         YZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735592210; x=1736197010;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/IJ3/vDz1j4Lld4GkSUwDYnIdXaW9w4G+aljgcCdr/s=;
        b=F8a/m/aVHT+XMYI/h6Y0tRFa1IJEJK4y+WTuN33OM3bYw4aECcTM6LwDWcD9d+Nm6p
         I0IsbBSszn1WaHy+BS6vDQAklmpHZ2uVH9CPf9/YkO+467+ajl/qFY5sFwEhHqexWshL
         GxSFYNB41Bx0eLZtqzajull5m91wbgnabddjHFSpRhC2hq8GnChdUGbwEI4PixbC+FZ4
         O70YYwms2F1YlUQkK/30wHAjnhYsNT4v9o6Obx862FyymelTZkfmY41LgkG9Q1dm2Ocm
         mQwwLBW8PKNJ+NwQhC1Me8eAUFsHTm13Vt0XMsbn+HaV6kA4aregxhAcRsuNYI+FLB7B
         OrUw==
X-Forwarded-Encrypted: i=1; AJvYcCWqCeKGiQ84RtVkF9tJbOmJkq9ZLqfMwxHc0FnPVdoz7ES+VZ7ONMKRz64cazqX09+FWm7uIb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtWgxdI2Pf8Pwo/nUx6Icda3IWEmdCW7bY3a2X01ocyMfb2mzu
	29sns1YrWscYUrXHuLmZX2kD6Vd2nznmuIuibzM67zKChui3M2w5LZnWik8q28tqJyhoBBgBmw=
	=
X-Google-Smtp-Source: AGHT+IF5HVePXx7H1XYt5kF2mZaNS4QrN6LbuVQU7CzeAeke4kol4AbvvUXUDS62JGg0lGG5PwhM+TL1NA==
X-Received: from pjbse14.prod.google.com ([2002:a17:90b:518e:b0:2e5:8726:a956])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:538b:b0:2ee:5bc9:75b5
 with SMTP id 98e67ed59e1d1-2f452dfccf6mr54068211a91.4.1735592210415; Mon, 30
 Dec 2024 12:56:50 -0800 (PST)
Date: Mon, 30 Dec 2024 12:56:47 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241230205647.1338900-1-tavip@google.com>
Subject: [PATCH net-next] team: prevent adding a device which is already a
 team device lower
From: Octavian Purdila <tavip@google.com>
To: jiri@resnulli.us, andrew+netdev@lunn.ch
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, Octavian Purdila <tavip@google.com>, 
	syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Prevent adding a device which is already a team device lower,
e.g. adding veth0 if vlan1 was already added and veth0 is a lower of
vlan1.

This is not useful in practice and can lead to recursive locking:

$ ip link add veth0 type veth peer name veth1
$ ip link set veth0 up
$ ip link set veth1 up
$ ip link add link veth0 name veth0.1 type vlan protocol 802.1Q id 1
$ ip link add team0 type team
$ ip link set veth0.1 down
$ ip link set veth0.1 master team0
team0: Port device veth0.1 added
$ ip link set veth0 down
$ ip link set veth0 master team0

============================================
WARNING: possible recursive locking detected
6.13.0-rc2-virtme-00441-ga14a429069bb #46 Not tainted
--------------------------------------------
ip/7684 is trying to acquire lock:
ffff888016848e00 (team->team_lock_key){+.+.}-{4:4}, at: team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)

but task is already holding lock:
ffff888016848e00 (team->team_lock_key){+.+.}-{4:4}, at: team_add_slave (drivers/net/team/team_core.c:1147 drivers/net/team/team_core.c:1977)

other info that might help us debug this:
Possible unsafe locking scenario:

CPU0
----
lock(team->team_lock_key);
lock(team->team_lock_key);

*** DEADLOCK ***

May be due to missing lock nesting notation

2 locks held by ip/7684:

stack backtrace:
CPU: 3 UID: 0 PID: 7684 Comm: ip Not tainted 6.13.0-rc2-virtme-00441-ga14a429069bb #46
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:122)
print_deadlock_bug.cold (kernel/locking/lockdep.c:3040)
__lock_acquire (kernel/locking/lockdep.c:3893 kernel/locking/lockdep.c:5226)
? netlink_broadcast_filtered (net/netlink/af_netlink.c:1548)
lock_acquire.part.0 (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5851)
? team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
? trace_lock_acquire (./include/trace/events/lock.h:24 (discriminator 2))
? team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
? lock_acquire (kernel/locking/lockdep.c:5822)
? team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
__mutex_lock (kernel/locking/mutex.c:587 kernel/locking/mutex.c:735)
? team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
? team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
? fib_sync_up (net/ipv4/fib_semantics.c:2167)
? team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
team_device_event (drivers/net/team/team_core.c:2928 drivers/net/team/team_core.c:2951 drivers/net/team/team_core.c:2973)
notifier_call_chain (kernel/notifier.c:85)
call_netdevice_notifiers_info (net/core/dev.c:1996)
__dev_notify_flags (net/core/dev.c:8993)
? __dev_change_flags (net/core/dev.c:8975)
dev_change_flags (net/core/dev.c:9027)
vlan_device_event (net/8021q/vlan.c:85 net/8021q/vlan.c:470)
? br_device_event (net/bridge/br.c:143)
notifier_call_chain (kernel/notifier.c:85)
call_netdevice_notifiers_info (net/core/dev.c:1996)
dev_open (net/core/dev.c:1519 net/core/dev.c:1505)
team_add_slave (drivers/net/team/team_core.c:1219 drivers/net/team/team_core.c:1977)
? __pfx_team_add_slave (drivers/net/team/team_core.c:1972)
do_set_master (net/core/rtnetlink.c:2917)
do_setlink.isra.0 (net/core/rtnetlink.c:3117)

Reported-by: syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3c47b5843403a45aef57
Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 drivers/net/team/team_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index c7690adec8db..dc7cbd6a9798 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1175,6 +1175,13 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		return -EBUSY;
 	}
 
+	if (netdev_has_upper_dev(port_dev, dev)) {
+		NL_SET_ERR_MSG(extack, "Device is already a lower device of the team interface");
+		netdev_err(dev, "Device %s is already a lower device of the team interface\n",
+			   portname);
+		return -EBUSY;
+	}
+
 	if (port_dev->features & NETIF_F_VLAN_CHALLENGED &&
 	    vlan_uses_dev(dev)) {
 		NL_SET_ERR_MSG(extack, "Device is VLAN challenged and team device has VLAN set up");
-- 
2.47.1.613.gc27f4b7a9f-goog


