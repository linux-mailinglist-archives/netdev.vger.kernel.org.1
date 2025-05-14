Return-Path: <netdev+bounces-190556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E94ABAB7887
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 00:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942BA8C45E1
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 22:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDE621CC5C;
	Wed, 14 May 2025 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzZ/674l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CA217FAC2;
	Wed, 14 May 2025 22:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747260203; cv=none; b=Ht80e+KkcBwp1KGSy3OZHg5qU/e0xjswc3JokT9zwxSpwa/T2IkKpN3Rvj2jDvZoXxreG4KapIXwsmTnlRmAo4yDzf7d0ZRSkGP85JqbLi28OVI/jU6j99gQ58BWGSJeKyKNdAL628/8TfcQ0KFRRzUNScsA5aN9VMiZAKdJ2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747260203; c=relaxed/simple;
	bh=kaNNhjlqBWlhjnTEjKrOPEorvdkg7SWI8a7aaWiQqYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EeWXucK3ZqYLRInngl4kLUC+r8q++fE0L3LWlL7bwpym57sS/p00PkYSSjrDi8kDvmnWMbZeh0SgkZzd9YcT9xxZqVxazOYjlhrWNtO3hpa+iLrTeeFLTwp1R85HZr1/UJsI7Kzkb94Cl0+2QCdZx1NP6cBzSffWXSAOurpqrko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzZ/674l; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22fa47d6578so2408215ad.2;
        Wed, 14 May 2025 15:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747260200; x=1747865000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IE1liUZqr/LSNp3VH85d2ETFGrpwenzQKAoZ9w7VDRI=;
        b=GzZ/674l6/bi8l5ow758aPwCv+rp3rMYmLMjGfRloLtw/kFKc7ul5TxwveobAH3o49
         3VROzY+kxY/OsAPIcSwsLY9xadmc4SlUdos/qnZW7/M8zNMEFQYVG8XaPsLySXbzgoo/
         if+LusxbI7m+uRCKjfNVCAiRADBZJRCQzoEWeHPwAPWtDBLAECdv+LASylOSmNljo5um
         WlAmElLJlBTSlFa/F/IMimGzMNV3F039nOAwQLGcYfHTCMLkxRGWzttqpeVxmASs5S4C
         wJm0g1F4kIyytr/OMstDI+HO3Zf0F7XJ+AtgGhQqgai2fSmkL93uGtwzaE4z2dPRMbEc
         D69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747260200; x=1747865000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IE1liUZqr/LSNp3VH85d2ETFGrpwenzQKAoZ9w7VDRI=;
        b=UMGTmbe4ircjREO3vRvRV6Ab+JTptYtiRlaMy/U8udPcDgEOQC9EMR9SPDIwUo0wk1
         kkLGNLDPWl1SG8WC+abhtG0XAckb/XY8Awg5y61XwGKOvOsKs5HptH0Jra6opFqaEUQz
         NGhZNSC57RTe0H9q88KiG4rlQg8i1vQcsX1PIqVA8VHnEYt93rTuRL6F76PpduyxtBJM
         BEZNFDL7svATXXWzXTF2Fj4YrPGd879vFED7g7iwt00kWFXYcaaOT1FT0g1EcWRFJvwD
         gPIEwaVD2OkkUme395EHxPzD+CrO4p2prqrMVZ1BDSoJBENaUBC2DZonU4kAA+tgv1Zs
         KfNg==
X-Forwarded-Encrypted: i=1; AJvYcCX/MMXy2pRrCevEFsIJcPoNbWvHmXXgMkFUZLkZ0blFXnWTJUFbkY6z3IVb48lX2RaRMBI+qcq5wLGT83A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyahVA8Kw7Zlucw8JTkMI3Sn/9lcdLFLoLTTzLqL+fcVn3EoX1x
	wcaRqyNmj6LSee10IMzI9nAITuZh7g+IP6KCeZ87mBICgDdtealKsI88
X-Gm-Gg: ASbGncsp+pL7xqri7beKQg4QrwfWmKT+4+bhGtnRF4AApD5L+UGzRM8iezgg++6bGba
	vgUDL/UbypgQovv7Tx9yuE6bBS5NspR9/wb69+kyQQbvWGlE50NtgiW+R+oOR7T3b5eorqR2evy
	KuA0b52QOC/f46UIUPmTGkGvSNIawvGXaeowihhqm4CbfSpLYZ0GUN9gJ/wmIuxky2lcTAOo3fD
	ZX7TUBwATRFEEmyVYC4RcdmlT4nsAMcHyyfEMGW7t+5Rvf5n5Zoes67GnzvpBbkrxODTetzTs/4
	UPGKTpaUBysXozrU/iurny+2gqFkD+KJA4g1JpiMkLSfraqT0rSZax1L6Q8kvwqXArr4ubVX31v
	ml49UHL6uNZFq
X-Google-Smtp-Source: AGHT+IGvjYtjawPKbLF6RgRa2nHy04RrNDIZteQmnxnjiNfwrcirA7m/dWWU5cIR87hKZTsbpuDWRg==
X-Received: by 2002:a17:903:2349:b0:21f:136a:a374 with SMTP id d9443c01a7336-231981d01ebmr76652765ad.43.1747260200423;
        Wed, 14 May 2025 15:03:20 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc829d818sm103906015ad.207.2025.05.14.15.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 15:03:20 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	andrew+netdev@lunn.ch,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org,
	syzbot+53485086a41dbb43270a@syzkaller.appspotmail.com
Subject: [PATCH net] team: grab team lock during team_change_rx_flags
Date: Wed, 14 May 2025 15:03:19 -0700
Message-ID: <20250514220319.3505158-1-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller reports the following issue:
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:578

 netdev_lock include/linux/netdevice.h:2751 [inline]
 netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 dev_set_promiscuity+0x10e/0x260 net/core/dev_api.c:285
 bond_set_promiscuity drivers/net/bonding/bond_main.c:922 [inline]
 bond_change_rx_flags+0x219/0x690 drivers/net/bonding/bond_main.c:4732
 dev_change_rx_flags net/core/dev.c:9145 [inline]
 __dev_set_promiscuity+0x3f5/0x590 net/core/dev.c:9189
 netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9201
 dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:286
 ^^ all of the above is under rcu lock
 team_change_rx_flags+0x1b3/0x330 drivers/net/team/team_core.c:1785
 dev_change_rx_flags net/core/dev.c:9145 [inline]
 __dev_set_promiscuity+0x3f5/0x590 net/core/dev.c:9189
 netif_set_promiscuity+0x50/0xe0 net/core/dev.c:9201
 dev_set_promiscuity+0x126/0x260 net/core/dev_api.c:286
 hsr_del_port+0x25e/0x2d0 net/hsr/hsr_slave.c:233
 hsr_netdev_notify+0x827/0xb60 net/hsr/hsr_main.c:104
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 unregister_netdevice_many_notify+0x15d8/0x2330 net/core/dev.c:11970
 rtnl_delete_link net/core/rtnetlink.c:3522 [inline]
 rtnl_dellink+0x488/0x710 net/core/rtnetlink.c:3564
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x219/0x490 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883

team_change_rx_flags runs under rcu lock which means we can't grab
instance lock for the lower devices. Switch to team->lock, similar
to what we already do for team_set_mac_address and team_change_mtu.

Fixes: 78cd408356fe ("net: add missing instance lock to dev_set_promiscuity")
Reported-by: syzbot+53485086a41dbb43270a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=53485086a41dbb43270a
Link: https://lore.kernel.org/netdev/6822cc81.050a0220.f2294.00e8.GAE@google.com
Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 drivers/net/team/team_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index d8fc0c79745d..b75ceb90359f 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1778,8 +1778,8 @@ static void team_change_rx_flags(struct net_device *dev, int change)
 	struct team_port *port;
 	int inc;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(port, &team->port_list, list) {
+	mutex_lock(&team->lock);
+	list_for_each_entry(port, &team->port_list, list) {
 		if (change & IFF_PROMISC) {
 			inc = dev->flags & IFF_PROMISC ? 1 : -1;
 			dev_set_promiscuity(port->dev, inc);
@@ -1789,7 +1789,7 @@ static void team_change_rx_flags(struct net_device *dev, int change)
 			dev_set_allmulti(port->dev, inc);
 		}
 	}
-	rcu_read_unlock();
+	mutex_unlock(&team->lock);
 }
 
 static void team_set_rx_mode(struct net_device *dev)
-- 
2.49.0


