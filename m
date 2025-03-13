Return-Path: <netdev+bounces-174501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E253AA5F03D
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 11:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E88B16B3A2
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BD324EF69;
	Thu, 13 Mar 2025 10:07:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838451BC5C;
	Thu, 13 Mar 2025 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860421; cv=none; b=nROh+aCkgMFw1zGqZSkk9xm7Lpti1x6pl/m6nCyueJFA3OAcNZbJOcGFbLcVb2HLeBLO3uTn8obgj53BNp9EGhvbPvjlbqI9tepw73cQJHWZkYnvxZ5WdRhIAgf/htJZJaLPMrDeb0XmKg1Sorxz0yHFBpKFPCp1i5/W1kTRaEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860421; c=relaxed/simple;
	bh=65gBC8vVsR7qor0JuxGG+QI1XCDxJ2tQG+ydTJTf4z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QqCkHvRirZvvVAxCc/OlV/hJESo/4lU8Qf3WrSQ0TO/7OnrlOJahvfeH5zbzJ4QBh5GzL9g7e61I3SDaXGCpyVmHkTEV/sb0I3DUV/2e/iz9a25AI46Z5aG6lJD7uDmwhhjVoD5MXv6SPO4o11ukAoZ4KzymPe1MxKW1FcB5tZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223959039f4so13813405ad.3;
        Thu, 13 Mar 2025 03:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741860418; x=1742465218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMBvlXRT1Oo/H4YKVe6JB8JizDFwNkTh0Z35MmnnpUc=;
        b=Ux8mwMQcAZXsT/5Z5XYlrrStWP/bt4Mvj8EuLg3JZdd54qFcHNTc+rbh7r+L+t3Xcs
         B0Np6I67vil+rT+WtO6B+ygB2ouCtPl9g9PVtGzATaZhTunm7atY9sNKmFJmz0cuHakw
         TZaztgAG8QoJtKWehU3UBLtFljdUfI82qONsVWP9sChau8Bd+vRqNKyghleG8E5xlrhp
         RoRlFum4+lrQoikC6w9cq2m/oQ4U9GDKA5rsWupu06Oa6xTp6mXu3iF3MGxL/kYg7xrh
         nelUpzuYftUk24a8QirEIRyj5QlmeCPkd+NWd3Gg3omzTKDuaPje9HF7wl/cxSfE0zir
         /Huw==
X-Forwarded-Encrypted: i=1; AJvYcCVbwngz+FyYany83fsHxTeXra26SKf1kNHd3FFTOBi//px0y5PB61cPTKosIhcM3ZU4BPmFU9vbSG1SJnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN4Fmeec7tlQ+qbVQ+FSLlhe2XaKQWS+IxumyU17st6GAihgE8
	v7KEj2dbLrOzsLdFFFq71zlJcMz9Ej8NA4k4M+U+UIt2lNHoR6Yd69NkgNWmjA==
X-Gm-Gg: ASbGncsN7wnv4cfXZJ46i94dLA/1kdQjfRCrstrVQeHpEvzg49YUzugSHMCMhWW1sZ/
	vTePkXRQrp4rDRUtGks2YED9KQOuVIUFPE/zdBrJgXk3MIq5dOxkIdn+8bABdy/CEL6X03ZxUQh
	PHLRXtd+iq3TubEu+2i0ss9A0K8246MznMGRlg7a+6GrTOtF4V2mjLD431MhDgOyqP9bi0DLAqa
	tThGGuwKZ8p8ALr1u3YIhIR93BYTurLpPHrNi9lo+l8KgIZgeS9nR0GOzv8AtSSLhI8w+bXH+/g
	RW3Qubz520lJ4MDkU++bk7vxv2jLt85AYY3H05CRuEnB
X-Google-Smtp-Source: AGHT+IGwsJBF2/gXtYew93eBcbsKnhL0lvSZAwInngLo3nUQoo0Ij243GewaPLjKmCxycgqHABl/Lw==
X-Received: by 2002:a17:902:f68a:b0:216:7926:8d69 with SMTP id d9443c01a7336-22428bf1731mr287204785ad.47.1741860418347;
        Thu, 13 Mar 2025 03:06:58 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bbfb5asm9635835ad.209.2025.03.13.03.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 03:06:57 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	syzbot+b0c03d76056ef6cd12a6@syzkaller.appspotmail.com
Subject: [PATCH net-next] net: vlan: don't propagate flags on open
Date: Thu, 13 Mar 2025 03:06:57 -0700
Message-ID: <20250313100657.2287455-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the device instance lock, there is now a possibility of a deadlock:

[    1.211455] ============================================
[    1.211571] WARNING: possible recursive locking detected
[    1.211687] 6.14.0-rc5-01215-g032756b4ca7a-dirty #5 Not tainted
[    1.211823] --------------------------------------------
[    1.211936] ip/184 is trying to acquire lock:
[    1.212032] ffff8881024a4c30 (&dev->lock){+.+.}-{4:4}, at: dev_set_allmulti+0x4e/0xb0
[    1.212207]
[    1.212207] but task is already holding lock:
[    1.212332] ffff8881024a4c30 (&dev->lock){+.+.}-{4:4}, at: dev_open+0x50/0xb0
[    1.212487]
[    1.212487] other info that might help us debug this:
[    1.212626]  Possible unsafe locking scenario:
[    1.212626]
[    1.212751]        CPU0
[    1.212815]        ----
[    1.212871]   lock(&dev->lock);
[    1.212944]   lock(&dev->lock);
[    1.213016]
[    1.213016]  *** DEADLOCK ***
[    1.213016]
[    1.213143]  May be due to missing lock nesting notation
[    1.213143]
[    1.213294] 3 locks held by ip/184:
[    1.213371]  #0: ffffffff838b53e0 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock+0x1b/0xa0
[    1.213543]  #1: ffffffff84e5fc70 (&net->rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock+0x37/0xa0
[    1.213727]  #2: ffff8881024a4c30 (&dev->lock){+.+.}-{4:4}, at: dev_open+0x50/0xb0
[    1.213895]
[    1.213895] stack backtrace:
[    1.213991] CPU: 0 UID: 0 PID: 184 Comm: ip Not tainted 6.14.0-rc5-01215-g032756b4ca7a-dirty #5
[    1.213993] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[    1.213994] Call Trace:
[    1.213995]  <TASK>
[    1.213996]  dump_stack_lvl+0x8e/0xd0
[    1.214000]  print_deadlock_bug+0x28b/0x2a0
[    1.214020]  lock_acquire+0xea/0x2a0
[    1.214027]  __mutex_lock+0xbf/0xd40
[    1.214038]  dev_set_allmulti+0x4e/0xb0 # real_dev->flags & IFF_ALLMULTI
[    1.214040]  vlan_dev_open+0xa5/0x170 # ndo_open on vlandev
[    1.214042]  __dev_open+0x145/0x270
[    1.214046]  __dev_change_flags+0xb0/0x1e0
[    1.214051]  netif_change_flags+0x22/0x60 # IFF_UP vlandev
[    1.214053]  dev_change_flags+0x61/0xb0 # for each device in group from dev->vlan_info
[    1.214055]  vlan_device_event+0x766/0x7c0 # on netdevsim0
[    1.214058]  notifier_call_chain+0x78/0x120
[    1.214062]  netif_open+0x6d/0x90
[    1.214064]  dev_open+0x5b/0xb0 # locks netdevsim0
[    1.214066]  bond_enslave+0x64c/0x1230
[    1.214075]  do_set_master+0x175/0x1e0 # on netdevsim0
[    1.214077]  do_setlink+0x516/0x13b0
[    1.214094]  rtnl_newlink+0xaba/0xb80
[    1.214132]  rtnetlink_rcv_msg+0x440/0x490
[    1.214144]  netlink_rcv_skb+0xeb/0x120
[    1.214150]  netlink_unicast+0x1f9/0x320
[    1.214153]  netlink_sendmsg+0x346/0x3f0
[    1.214157]  __sock_sendmsg+0x86/0xb0
[    1.214160]  ____sys_sendmsg+0x1c8/0x220
[    1.214164]  ___sys_sendmsg+0x28f/0x2d0
[    1.214179]  __x64_sys_sendmsg+0xef/0x140
[    1.214184]  do_syscall_64+0xec/0x1d0
[    1.214190]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    1.214191] RIP: 0033:0x7f2d1b4a7e56

Device setup:

     netdevsim0 (down)
     ^        ^
  bond        netdevsim1.100@netdevsim1 allmulticast=on (down)

When we enslave the lower device (netdevsim0) which has a vlan, we
propagate vlan's allmuti/promisc flags during ndo_open. This causes
(re)locking on of the real_dev.

Propagate allmulti/promisc on flags change, not on the open. There
is a slight semantics change that vlans that are down now propagate
the flags, but this seems unlikely to result in the real issues.

Reproducer:

  echo 0 1 > /sys/bus/netdevsim/new_device

  dev_path=$(ls -d /sys/bus/netdevsim/devices/netdevsim0/net/*)
  dev=$(echo $dev_path | rev | cut -d/ -f1 | rev)

  ip link set dev $dev name netdevsim0
  ip link set dev netdevsim0 up

  ip link add link netdevsim0 name netdevsim0.100 type vlan id 100
  ip link set dev netdevsim0.100 allmulticast on down
  ip link add name bond1 type bond mode 802.3ad
  ip link set dev netdevsim0 down
  ip link set dev netdevsim0 master bond1
  ip link set dev bond1 up
  ip link show

Reported-by: syzbot+b0c03d76056ef6cd12a6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/Z9CfXjLMKn6VLG5d@mini-arch/T/#m15ba130f53227c883e79fb969687d69d670337a0
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/8021q/vlan_dev.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 770a4dcf7f63..fbf296137b09 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -274,17 +274,6 @@ static int vlan_dev_open(struct net_device *dev)
 			goto out;
 	}
 
-	if (dev->flags & IFF_ALLMULTI) {
-		err = dev_set_allmulti(real_dev, 1);
-		if (err < 0)
-			goto del_unicast;
-	}
-	if (dev->flags & IFF_PROMISC) {
-		err = dev_set_promiscuity(real_dev, 1);
-		if (err < 0)
-			goto clear_allmulti;
-	}
-
 	ether_addr_copy(vlan->real_dev_addr, real_dev->dev_addr);
 
 	if (vlan->flags & VLAN_FLAG_GVRP)
@@ -298,12 +287,6 @@ static int vlan_dev_open(struct net_device *dev)
 		netif_carrier_on(dev);
 	return 0;
 
-clear_allmulti:
-	if (dev->flags & IFF_ALLMULTI)
-		dev_set_allmulti(real_dev, -1);
-del_unicast:
-	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
-		dev_uc_del(real_dev, dev->dev_addr);
 out:
 	netif_carrier_off(dev);
 	return err;
@@ -316,10 +299,6 @@ static int vlan_dev_stop(struct net_device *dev)
 
 	dev_mc_unsync(real_dev, dev);
 	dev_uc_unsync(real_dev, dev);
-	if (dev->flags & IFF_ALLMULTI)
-		dev_set_allmulti(real_dev, -1);
-	if (dev->flags & IFF_PROMISC)
-		dev_set_promiscuity(real_dev, -1);
 
 	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
 		dev_uc_del(real_dev, dev->dev_addr);
@@ -489,12 +468,10 @@ static void vlan_dev_change_rx_flags(struct net_device *dev, int change)
 {
 	struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
 
-	if (dev->flags & IFF_UP) {
-		if (change & IFF_ALLMULTI)
-			dev_set_allmulti(real_dev, dev->flags & IFF_ALLMULTI ? 1 : -1);
-		if (change & IFF_PROMISC)
-			dev_set_promiscuity(real_dev, dev->flags & IFF_PROMISC ? 1 : -1);
-	}
+	if (change & IFF_ALLMULTI)
+		dev_set_allmulti(real_dev, dev->flags & IFF_ALLMULTI ? 1 : -1);
+	if (change & IFF_PROMISC)
+		dev_set_promiscuity(real_dev, dev->flags & IFF_PROMISC ? 1 : -1);
 }
 
 static void vlan_dev_set_rx_mode(struct net_device *vlan_dev)
-- 
2.48.1


