Return-Path: <netdev+bounces-114205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9976F941565
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 17:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C69F3B22271
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA691A2C29;
	Tue, 30 Jul 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+4dR+sW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103C829A2;
	Tue, 30 Jul 2024 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722353004; cv=none; b=He3jbRQQXdK0ERFA17BzgyU0/VRYOOCWhnX4ysRcYQi76bVI5DWoqJddt6da2DZxlj2JS8IBXQqZJjSkvZct5oLWGpIm75i7F3JDRQMfNFHM5j9YNSnud4L4dXxw6wLiuYMRnmL9ynXRjYO8WKhfpTkZbnSPA7By9I+HnYw+f88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722353004; c=relaxed/simple;
	bh=864nHVVRqWlFox1rNDD/5Fp3rh8bfEudn31vCUNbV8g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HUDpuSfgKEBj55BvDCjpQVkTQuph5Lg5KM39b6ij1xDLnIbqnWpkLPZHL223sjC0nB20Y+hcnxyIo3ov6i9YFlLsIh7lLc7MjoB6MgNzRm2T4jQhLJKE4CwfXIy0RYsz2Wf9rpwxAQwg4yavnxNiImhsZjUE7H5s+9l+ERn5qIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+4dR+sW; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7669d62b5bfso2847593a12.1;
        Tue, 30 Jul 2024 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722353002; x=1722957802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o86PbfiWNjxwnBHZXbIFiiSZ4WNL1lp7elfQvMtdViU=;
        b=c+4dR+sWRHr3oSTsBdoK1HiGM1EUg+si5Oyqm8XsQ05qaaBxCmyRHFmtcLEOJ9xrWH
         SSmWNZhh9W8ban4RWsMFj2QjoBHkp9DaCj0IOch/AlsXDZIG0MfVfu+bLwMhYG2PpE4i
         jKGFHBFkiDK3gKyENkvotdqWWQp/Fks1LvIqpdKU+ulrQQ8MtHhAuIBEhcIDWi35D+YP
         2d0Ha5P8/ebUd0RKS98KygYyGMgtLyaRSiioC9Md1SNuN5pPJb+U8t7rkyzDQxfVibRP
         eMDZ0prB9zyeE2AQmJAprKWcO6gjEwnaAA/+Cvv6m8RZWWPTtXZIAMMclHz22u1xNEBP
         oG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722353002; x=1722957802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o86PbfiWNjxwnBHZXbIFiiSZ4WNL1lp7elfQvMtdViU=;
        b=SG7PDrD7cbbv44Z9hgktqB+d9B/w2QNGSM06SKtss2grcD8av9nK48IXodal1Eew28
         T7mBMBfjf7IS85fd/Xyiiux41ezKltBCUGZPDDyjrKQI7qMNXG+6JxTYeUZ9Qei3Llih
         j6bYSzP8PjoAVOVYPtw7zEZ+fSiZtlRhA7po4umDlUaEaNeNnjrf9rsck5W5Tk2GAE+z
         i6bhjDUJM98z/18fp3hWVFeJoKRFde8u7iXYYGd4MH7mGfJ1h342tkfSV+lCEJqmImDW
         wz45XZq8fnxwK5XCVGb0OSx9m/fV1mBJ0z9zyXlWFK5jMjKAfpF/8KHZQLXkvsSsMOJb
         Whnw==
X-Forwarded-Encrypted: i=1; AJvYcCVwKTDcCiaf8/kt7HkjQ4nic91MuLogZjziV4r20f2UkI7arvCkM9Qq13kN/1QvhioiTqtEuICUC9159eBnY64+MHZYYO1hjU6Ht0LLTfFsHarec8rNRzSMD7x4oRTpgswL5M1w
X-Gm-Message-State: AOJu0Yx4XNz2EyCrEtffZGmN1JDsFexcIDRl3+ETSknB12EU668YzlMP
	asuV/UnTuQLsHeHN+i3E3XsrlNJHGiY91GIdzZ8CP/Euwh52zQVM
X-Google-Smtp-Source: AGHT+IE2tlSy8RnNB+VlKa7GaFvaKOYKuQ9IQxZUZVFhC4OaGaYY5u8ATy0JeEJkaOsiX268b6vI/g==
X-Received: by 2002:a17:90a:4b04:b0:2c8:538d:95b7 with SMTP id 98e67ed59e1d1-2cf7e606ca1mr9596549a91.32.1722353002268;
        Tue, 30 Jul 2024 08:23:22 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb739114bsm13005593a91.2.2024.07.30.08.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:23:21 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: idosch@nvidia.com,
	jiri@resnulli.us,
	amcohen@nvidia.com,
	liuhangbin@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net] rtnetlink: fix possible deadlock in team_port_change_check
Date: Wed, 31 Jul 2024 00:22:10 +0900
Message-Id: <20240730152210.25153-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_setlink() changes the flag of the device and then enslaves it. However,
in this case, if the IFF_UP flag is set, the enslavement process calls
team_add_slave() to acquire 'team->lock', but when dev_open() opens the
newly enslaved device, the NETDEV_UP event occurs, and as a result,
a deadlock occurs when team_port_change_check() tries to acquire 
'team->lock' again.

To solve this, you need to enslave it before changing the flag of the
device.

============================================
WARNING: possible recursive locking detected
6.10.0-syzkaller-12562-g1722389b0d86 #0 Not tainted
--------------------------------------------
syz-executor122/5360 is trying to acquire lock:
ffff88802c258d40 (team->team_lock_key){+.+.}-{3:3}, at: team_port_change_check drivers/net/team/team_core.c:2950 [inline]
ffff88802c258d40 (team->team_lock_key){+.+.}-{3:3}, at: team_device_event+0x2c7/0x770 drivers/net/team/team_core.c:2973

but task is already holding lock:
ffff88802c258d40 (team->team_lock_key){+.+.}-{3:3}, at: team_add_slave+0x9c/0x20e0 drivers/net/team/team_core.c:1975

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(team->team_lock_key);
  lock(team->team_lock_key);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz-executor122/5360:
 #0: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa1e9a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
 #1: ffff88802c258d40 (team->team_lock_key){+.+.}-{3:3}, at: team_add_slave+0x9c/0x20e0 drivers/net/team/team_core.c:1975

stack backtrace:
CPU: 0 UID: 0 PID: 5360 Comm: syz-executor122 Not tainted 6.10.0-syzkaller-12562-g1722389b0d86 #0
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
 do_setlink+0xcaf/0x3ff0 net/core/rtnetlink.c:2907
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
RIP: 0033:0x7f424ca7e7b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd8c496978 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f424ca7e7b9
RDX: 0000000000000000 RSI: 0000000020000600 RDI: 0000000000000012
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffd8c4969a0

Reported-by: syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Fixes: ec4ffd100ffb ("Revert "net: rtnetlink: Enslave device before bringing it up"")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 net/core/rtnetlink.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 87e67194f240..178f5b85fd87 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2896,13 +2896,6 @@ static int do_setlink(const struct sk_buff *skb,
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
 	}
 
-	if (ifm->ifi_flags || ifm->ifi_change) {
-		err = dev_change_flags(dev, rtnl_dev_combine_flags(dev, ifm),
-				       extack);
-		if (err < 0)
-			goto errout;
-	}
-
 	if (tb[IFLA_MASTER]) {
 		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
 		if (err)
@@ -2910,6 +2903,13 @@ static int do_setlink(const struct sk_buff *skb,
 		status |= DO_SETLINK_MODIFIED;
 	}
 
+	if (ifm->ifi_flags || ifm->ifi_change) {
+		err = dev_change_flags(dev, rtnl_dev_combine_flags(dev, ifm),
+				       extack);
+		if (err < 0)
+			goto errout;
+	}
+
 	if (tb[IFLA_CARRIER]) {
 		err = dev_change_carrier(dev, nla_get_u8(tb[IFLA_CARRIER]));
 		if (err)
--

