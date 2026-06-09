Return-Path: <netdev+bounces-297154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YbP4M0c9KGpPAwMAu9opvQ
	(envelope-from <netdev+bounces-297154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:20:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7565B66249C
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:20:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Q5OiaR2v;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297154-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297154-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5F8F30C1093
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F36379C47;
	Tue,  9 Jun 2026 16:13:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B535436D50D
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 16:13:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021590; cv=none; b=L6z/42f+6UhhbPAKt5IQanVhov0/Ce2b5zgVj+rca8TQJpNec9vWO6AhQRB5JCvm5jvB2ANdrcnpS6ZJcYSyCEgxtfpr1NHho9RX4K3udj7W+aLHornB5s3OYF9ZimQBNS6doNhGVNzGg60TFaZozgK3mYVty2Pdo2HPHctGyzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021590; c=relaxed/simple;
	bh=yOUFwU6jGqwKgoWV8t5gJ5vJTjesKPNgL57U36ItkqQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=luQe7yvNCoJ935FkvuSQRgFQH9wqs+Q0cJ0Z84I2vWTMNI3zaaT/LwqJ59m7u01/sgLcSLm/7iaMiEVNLnkhZo4v+ddQ9KIWoSIHfCeulD8NMi2qn1KK8zVcoeG0VIkXaP2ie97dvIANyt3lUXfQBrbmBkUdfuDUUk0I1+i3Okw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q5OiaR2v; arc=none smtp.client-ip=74.125.224.74
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-660555be5a0so8946620d50.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 09:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781021588; x=1781626388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cfs5PoZPmvtaZiUzkuEyf2bguIKUg1RpeUpLUfcea4s=;
        b=Q5OiaR2v+tw+llRwXcdKOn/W1H3BaAYThJbAHxh73clopwEs+0J3Cy5CT5w1+97xcW
         nyVx/2sSQykmJY+NYW+eGU6BKyvnRiFf1yYwyD6eWv4OS+HO5wiJ1DLkyKBMTtln258I
         zQuLXm8xDrtnDv/JobKCWAPwHFxVybnTmgeuLIWY5N/kjea9puaXRo6a4MzVCCHnooIj
         g+UJWv0aHL7WagelFoERf39mout/eKQ3f9opk9oqCrYEGSwpsyo18AdisjvOpxYfNKp5
         ZUHXw/vQcDE+lQ3l+jlP7dnGOU0ALXASQz3zky1Mn1jfSj7242nYR/wRlCJinyRqro0L
         jLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781021588; x=1781626388;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfs5PoZPmvtaZiUzkuEyf2bguIKUg1RpeUpLUfcea4s=;
        b=TiqEqbuc02BXjxuU6C9UuY/X5n29qS5aJNhFNcibFrqB4S4ZKomHLSQO/i361HxzRK
         PYf9GylUYUrNGi9Z1mZJ792H4Q+f8hKP6bjaM1noEAGVvm930v9l9FVvCupPC8C4mUj4
         Dv4JJ6A0GUf/lAaICVsyofwodUYDgm+Qe2M3BLTJ3KpWc2lqwBByqCCfzPT5UZV6WLO1
         fFXFMy7o3hoZsO22eutY1ccYtZIh/uXkeFkW4L3GKwS/2zKHtw1k/KiSX5s4M023zt4M
         YMwDg/e0UGE/FD7QJjbA2lcZbcBrAIPnXOeOoeovmxqxEt384Xds4zCBfl/i+C1C/H0s
         qTEg==
X-Forwarded-Encrypted: i=1; AFNElJ/UFvlHCPMbNsZod5cEgkLC+ICBDSZTWLz/xYnXTcx1Mi5Pr3vpcn1SGLZmunsXzT8skqqswYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3EtQpSwpBHM7mVlvDbvinMrszGEFll7dEViBX7qudJOaWMev6
	/dy3Bqe+fHSdEJJ7mn+DyGqvafidSZGTfFMy3StGR/mBR8eUGf/NZdqQwiJh/vxuXUWX8XFchnI
	ekR8jQNUqJ15C6A==
X-Received: from qvlh12.prod.google.com ([2002:a0c:f40c:0:b0:8ce:c42e:f14a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:120a:b0:661:37ed:647b with SMTP id 956f58d0204a3-66137ed65famr9013922d50.14.1781021587493;
 Tue, 09 Jun 2026 09:13:07 -0700 (PDT)
Date: Tue,  9 Jun 2026 16:13:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609161305.3186102-1-edumazet@google.com>
Subject: [PATCH v2 net] net: watchdog: fix refcount tracking races
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com, 
	syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297154-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com,m:syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,381d82bbf0253710b35d,3479efbc2821cb2a79f2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7565B66249C

Blamed commit converted the untracked dev_hold()/dev_put() calls
in the watchdog code to use the tracked dev_hold_track()/dev_put_track()
(which were later renamed/interfaced to netdev_hold() and netdev_put()).

By introducing dev->watchdog_dev_tracker to store the
reference tracking information without adding synchronization
between netdev_watchdog_up() and dev_watchdog(), it enabled the
race condition where this pointer could be overwritten or freed
concurrently, leading to the list corruption crash syzbot reported:

list_del corruption, ffff888114a18c00->next is NULL
 kernel BUG at lib/list_debug.c:52 !
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 91 Comm: kworker/u8:5 Not tainted syzkaller #0 PREEMPT(lazy)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Workqueue: events_unbound linkwatch_event
 RIP: 0010:__list_del_entry_valid_or_report.cold+0x22/0x2a lib/list_debug.c:52
Call Trace:
 <TASK>
  __list_del_entry_valid include/linux/list.h:132 [inline]
  __list_del_entry include/linux/list.h:246 [inline]
  list_move_tail include/linux/list.h:341 [inline]
  ref_tracker_free+0x1a7/0x6c0 lib/ref_tracker.c:329
  netdev_tracker_free include/linux/netdevice.h:4491 [inline]
  netdev_put include/linux/netdevice.h:4508 [inline]
  netdev_put include/linux/netdevice.h:4504 [inline]
  netdev_watchdog_down net/sched/sch_generic.c:600 [inline]
  dev_deactivate_many+0x28c/0xfe0 net/sched/sch_generic.c:1363
  dev_deactivate+0x109/0x1d0 net/sched/sch_generic.c:1397
  linkwatch_do_dev net/core/link_watch.c:184 [inline]
  linkwatch_do_dev+0xd3/0x120 net/core/link_watch.c:166
  __linkwatch_run_queue+0x3a5/0x810 net/core/link_watch.c:240
  linkwatch_event+0x8f/0xc0 net/core/link_watch.c:314
  process_one_work+0xa0e/0x1980 kernel/workqueue.c:3314
  process_scheduled_works kernel/workqueue.c:3397 [inline]
  worker_thread+0x5ef/0xe50 kernel/workqueue.c:3478
  kthread+0x370/0x450 kernel/kthread.c:436
  ret_from_fork+0x69a/0xc80 arch/x86/kernel/process.c:158
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

This patch has three coordinated parts:

1) Zero tracker on free:
   Modify netdev_tracker_free() to poison the tracker pointer after freeing.
   This helps detect and avoid double frees.

2) Remove netdev_watchdog_up() call from netif_carrier_on():
   This ensures netdev_watchdog_up() is only called from process/BH context
   (via linkwatch workqueue dev_activate()), allowing us to use
   spin_lock_bh() for synchronization.

3) Synchronize watchdog up and watchdog timer:
   Protect netdev_watchdog_up with tx_global_lock.
   Only allocate a new tracker in netdev_watchdog_up() if one is
   not already present.
   In dev_watchdog(), keep the lock held while calling netdev_put()
   to avoid races with concurrent netdev_watchdog_up().
   In dev_watchdog(), ensure we don't release the tracker if the
   timer was rescheduled either by dev_watchdog() itself or concurrently
   by netdev_watchdog_up().

Fixes: f12bf6f3f942 ("net: watchdog: add net device refcount tracker")
Reported-by: syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a26b751.c25708ab.1b19ef.0013.GAE@google.com/T/#u
Tested-by: syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: fix compile error when CONFIG_NET_DEV_REFCNT_TRACKER is not set (Jakub and build bots)

 include/linux/netdevice.h |  7 ++++++-
 net/sched/sch_generic.c   | 28 +++++++++++++++++-----------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0e1e581efc5ac264259b2f0fdfe41c50a6f47239..fb9f7cee1d29de5367ea902d352296f952525c57 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4488,7 +4488,12 @@ static inline void netdev_tracker_free(struct net_device *dev,
 				       netdevice_tracker *tracker)
 {
 #ifdef CONFIG_NET_DEV_REFCNT_TRACKER
-	ref_tracker_free(&dev->refcnt_tracker, tracker);
+	if (!tracker) {
+		ref_tracker_free(&dev->refcnt_tracker, NULL);
+	} else if (!IS_ERR(*tracker)) {
+		ref_tracker_free(&dev->refcnt_tracker, tracker);
+		*tracker = ERR_PTR(-EEXIST);
+	}
 #endif
 }
 
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index a93321db8fd75d30c61e146c290bbc139c37c913..55327448dccf6b2ed2b892043360c2f98178bd87 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -568,16 +568,18 @@ static void dev_watchdog(struct timer_list *t)
 				dev->netdev_ops->ndo_tx_timeout(dev, i);
 				netif_unfreeze_queues(dev);
 			}
-			if (!mod_timer(&dev->watchdog_timer,
-				       round_jiffies(oldest_start +
-						     dev->watchdog_timeo)))
-				release = false;
+			mod_timer(&dev->watchdog_timer,
+				  round_jiffies(oldest_start +
+						dev->watchdog_timeo));
+			release = false;
 		}
 	}
-	spin_unlock(&dev->tx_global_lock);
-
+	if (timer_pending(&dev->watchdog_timer))
+		release = false;
 	if (release)
 		netdev_put(dev, &dev->watchdog_dev_tracker);
+
+	spin_unlock(&dev->tx_global_lock);
 }
 
 void netdev_watchdog_up(struct net_device *dev)
@@ -586,10 +588,16 @@ void netdev_watchdog_up(struct net_device *dev)
 		return;
 	if (dev->watchdog_timeo <= 0)
 		dev->watchdog_timeo = 5*HZ;
+	spin_lock_bh(&dev->tx_global_lock);
 	if (!mod_timer(&dev->watchdog_timer,
-		       round_jiffies(jiffies + dev->watchdog_timeo)))
-		netdev_hold(dev, &dev->watchdog_dev_tracker,
-			    GFP_ATOMIC);
+		       round_jiffies(jiffies + dev->watchdog_timeo))) {
+#ifdef CONFIG_NET_DEV_REFCNT_TRACKER
+		if (IS_ERR_OR_NULL(dev->watchdog_dev_tracker))
+#endif
+			netdev_hold(dev, &dev->watchdog_dev_tracker,
+				    GFP_ATOMIC);
+	}
+	spin_unlock_bh(&dev->tx_global_lock);
 }
 EXPORT_SYMBOL_GPL(netdev_watchdog_up);
 
@@ -614,8 +622,6 @@ void netif_carrier_on(struct net_device *dev)
 			return;
 		atomic_inc(&dev->carrier_up_count);
 		linkwatch_fire_event(dev);
-		if (netif_running(dev))
-			netdev_watchdog_up(dev);
 	}
 }
 EXPORT_SYMBOL(netif_carrier_on);
-- 
2.54.0.1064.gd145956f57-goog


