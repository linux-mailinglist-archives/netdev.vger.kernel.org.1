Return-Path: <netdev+bounces-96005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4858C3F72
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF4B1F217A2
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7322514AD29;
	Mon, 13 May 2024 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="AStfg2cn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0B9149E16
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715598440; cv=none; b=Byqa0g3L63wPCgtlUVB13hWUCqR5KjTn2u1d8JYYdR3iDD43ZTmTYvrROsRTwUjFfbQ8YiPYt83fvTt+DUmh8Q+cu9QEJMoeIl0iJC2wh3GxzTDb6It6CwfFJh86KPb9yvxcoxcGsOHQyzkvycHi2jlHBFoQMEpz2b4GZ/imzgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715598440; c=relaxed/simple;
	bh=sQ22MnC/GqGA15bb6lplBaFv5MtUbe+DNgEvgg1mt74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILr32ruu6Gp0YnMF5KPiBJGJPAIfjLW+hy1qsJXyxLtoJr3Vm0iJXT1ZZm9QRJwNNFmzHTAw9gexNelm118EynyLzNXS8kzqZMufiqmtbjpkwmmn+pu5xVJ9dhy/57uX/2gvgoXrQXWJHhamBKjo2JU0V1/OJhRTqdE7QaWMMzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=AStfg2cn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42016c8daa7so4755455e9.2
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 04:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1715598437; x=1716203237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fpyRZoJrK21uu/CPd7IvcdbbP6QpYeHMyHtxNFb1d68=;
        b=AStfg2cnle+mgX0LadSF7grHx3P54aNtAxzPQvPX+XqyhLzPFWv0C1jbz1E9GO6+3K
         d9FpfzTZ/r8nMhldKH1rUxAroXmKAPuFPaK60aofDSvfVECz8UkguqcEXRwn5+k+5o8w
         6PtnR+SQI25Kcd7zsns9j9nm/iBkWNh7pEmcMRxbSmjnQ6u3vCQPuoydJKCrQJmNpOdj
         cJOt+7fQsqVusbYYxKwZ1J1u3xbSj8LCSz31popWSNYciMr3eDqVaZPCH41a4AK6pTzj
         Ma3KzgEJ6RCXS0YeKtGmWSeW3cATKUU49dZLQS/5AjrW2wDcb2GS/36ZGoXTbe3lANu4
         o/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715598437; x=1716203237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpyRZoJrK21uu/CPd7IvcdbbP6QpYeHMyHtxNFb1d68=;
        b=D/2SIw+n/NyTLexUw7TxT15IXwOqHPejT3MJzwyxrt+iEfHOexyQO8OqFlzyM8heIt
         QSohiagD7WHOF8kx55gfQAjKoSnVny72J42pq5S8yfnrS3tTphwxNqRt1Eg9rkXFafg3
         QxVbbrg7lfro724+HLXqODvO/nfL6EWqQD0IBEeXgbeOH0s9ZoDbk5u3tc3PJeqTUkkY
         Ep044RGV+FeSKPwMnwU4nye6oV/NMNkX/P4rjS95pDXjFXg73f6kUaoq5QL4mzvIsky9
         SDhKP7GGIuqDmjBLc00j6VRQg/F5zc6IPTZwiF2dtxK3TMIz+7EXCLydd1u92Jb/YSJp
         5UVA==
X-Gm-Message-State: AOJu0YwTLfy/8cMFPG2OrbEPi3NJj7RBhHW5AidgUqAqFQbUn+cQdUWB
	7ZF414fskYQBXB6S7vjFZEo1HTaJlsvcoTEYU6hJhMnIvEvjipdJuiu4qVuEYKD1FpAGlREc6IS
	XsFY=
X-Google-Smtp-Source: AGHT+IHjhwTATWIQVciRypeABc4AmOlaOxDuxujYNXR8MpLWnxmnZRvSynFV04LPjnhhFCI59QlqLA==
X-Received: by 2002:a05:600c:314e:b0:41a:bdaf:8d6b with SMTP id 5b1f17b1804b1-41fead6adf9mr64529655e9.34.1715598436582;
        Mon, 13 May 2024 04:07:16 -0700 (PDT)
Received: from debil.. ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420113d808bsm66801865e9.12.2024.05.13.04.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 04:07:16 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com,
	kuba@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	edumazet@google.com,
	pabeni@redhat.com,
	Nikolay Aleksandrov <razor@blackwall.org>,
	syzbot+fa04eb8a56fd923fc5d8@syzkaller.appspotmail.com
Subject: [PATCH net] net: bridge: mst: fix vlan use-after-free
Date: Mon, 13 May 2024 14:06:27 +0300
Message-ID: <20240513110627.770389-1-razor@blackwall.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a suspicious rcu usage[1] in bridge's mst code. While
fixing it I noticed that nothing prevents a vlan to be freed while
walking the list from the same path (br forward delay timer). Fix the rcu
usage and also make sure we are not accessing freed memory by making
br_mst_vlan_set_state use rcu read lock.

[1]
 WARNING: suspicious RCU usage
 6.9.0-rc6-syzkaller #0 Not tainted
 -----------------------------
 net/bridge/br_private.h:1599 suspicious rcu_dereference_protected() usage!
 ...
 stack backtrace:
 CPU: 1 PID: 8017 Comm: syz-executor.1 Not tainted 6.9.0-rc6-syzkaller #0
 Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
 Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
  lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
  nbp_vlan_group net/bridge/br_private.h:1599 [inline]
  br_mst_set_state+0x1ea/0x650 net/bridge/br_mst.c:105
  br_set_state+0x28a/0x7b0 net/bridge/br_stp.c:47
  br_forward_delay_timer_expired+0x176/0x440 net/bridge/br_stp_timer.c:88
  call_timer_fn+0x18e/0x650 kernel/time/timer.c:1793
  expire_timers kernel/time/timer.c:1844 [inline]
  __run_timers kernel/time/timer.c:2418 [inline]
  __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2429
  run_timer_base kernel/time/timer.c:2438 [inline]
  run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2448
  __do_softirq+0x2c6/0x980 kernel/softirq.c:554
  invoke_softirq kernel/softirq.c:428 [inline]
  __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
  </IRQ>
  <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
 RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5758
 Code: 2b 00 74 08 4c 89 f7 e8 ba d1 84 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
 RSP: 0018:ffffc90013657100 EFLAGS: 00000206
 RAX: 0000000000000001 RBX: 1ffff920026cae2c RCX: 0000000000000001
 RDX: dffffc0000000000 RSI: ffffffff8bcaca00 RDI: ffffffff8c1eaa60
 RBP: ffffc90013657260 R08: ffffffff92efe507 R09: 1ffffffff25dfca0
 R10: dffffc0000000000 R11: fffffbfff25dfca1 R12: 1ffff920026cae28
 R13: dffffc0000000000 R14: ffffc90013657160 R15: 0000000000000246

Fixes: ec7328b59176 ("net: bridge: mst: Multiple Spanning Tree (MST) mode")
Reported-by: syzbot+fa04eb8a56fd923fc5d8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa04eb8a56fd923fc5d8
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_mst.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index ee680adcee17..3c66141d34d6 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -78,7 +78,7 @@ static void br_mst_vlan_set_state(struct net_bridge_port *p, struct net_bridge_v
 {
 	struct net_bridge_vlan_group *vg = nbp_vlan_group(p);
 
-	if (v->state == state)
+	if (br_vlan_get_state(v) == state)
 		return;
 
 	br_vlan_set_state(v, state);
@@ -100,11 +100,12 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 	};
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_vlan *v;
-	int err;
+	int err = 0;
 
+	rcu_read_lock();
 	vg = nbp_vlan_group(p);
 	if (!vg)
-		return 0;
+		goto out;
 
 	/* MSTI 0 (CST) state changes are notified via the regular
 	 * SWITCHDEV_ATTR_ID_PORT_STP_STATE.
@@ -112,17 +113,20 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 	if (msti) {
 		err = switchdev_port_attr_set(p->dev, &attr, extack);
 		if (err && err != -EOPNOTSUPP)
-			return err;
+			goto out;
 	}
 
-	list_for_each_entry(v, &vg->vlan_list, vlist) {
+	err = 0;
+	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
 		if (v->brvlan->msti != msti)
 			continue;
 
 		br_mst_vlan_set_state(p, v, state);
 	}
 
-	return 0;
+out:
+	rcu_read_unlock();
+	return err;
 }
 
 static void br_mst_vlan_sync_state(struct net_bridge_vlan *pv, u16 msti)
-- 
2.44.0


