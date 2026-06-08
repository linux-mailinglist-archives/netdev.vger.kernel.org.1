Return-Path: <netdev+bounces-296537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3ESLNFi4JmosbwIAu9opvQ
	(envelope-from <netdev+bounces-296537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:40:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32013656467
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 14:40:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=uFhXIwIF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296537-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296537-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B8F5300B9DB
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 12:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8EB3803F9;
	Mon,  8 Jun 2026 12:39:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2055D33E351
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 12:39:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922383; cv=none; b=hLMqWdp3xNuw1rXrGR9hvBX7q317di8t+VOwo5dgx1IR/5+l6SNIs11f8Ck+e21ba1Ud2BsuDhfvr769u+TLVQefOvwo4xZpKT1s6Mvue3gnSZd4Cu2jT7jSUCXl/xzOs1HPoJmFPWr1P7X1GjrVWuh/iVAapyd9GhfZm58kKv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922383; c=relaxed/simple;
	bh=S2VNrsafL2F2AzonUPwRHoCnEvegR3A8g8i65hRU9gU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qe8bLcI3aIm4YCgOo2JDdrcUCTx4jpiiBbW1oSr1WwpI1lXv2BvpzhGHSFlkTZqMm0+lKQQOSY23gfGjI2298qxAOdwQEkIq/SVqe/qpmPq825yMf1B3v5rwnPLjaJxZF8QXbLIPvxgnk63FGhzSbHjLhPZifgMt3/jp7vKyAn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uFhXIwIF; arc=none smtp.client-ip=209.85.219.73
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8ccd83d58d9so68778516d6.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 05:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780922377; x=1781527177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zkgaCBda6Y877+CjKRt/sYD9RBoNVDRYmRHljB0GIc8=;
        b=uFhXIwIFCwvYiM82CWY1bzQu1JmcSpm1OabwqoXOwofIPVFZrpsJhBlKACA9E91/Hl
         /OTYWa9621SuLVvH2y2ZLzT2MKR1gQasml14YpwIGLRLgSpXHQwflcIyZ4e/G/oEX397
         S+Ipf37aGYJOm3878qrN/eYFpjHeGY3XdELQr+sF4nWsEXjni1QQGKxJRvdnfbkwHsKS
         YjnVg7jEhpx8FvleUqL2gHVxP7BSzZL9Bf4dZBCLvGPScDJ+moTR1riPVXadbYIwjaDO
         ZGNjjSyPuD6/5MmrJK/D0WOvmddNtRxu/vCQN79Rizh4yWQJssRw7810l+F236Q/ZWwl
         b2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780922377; x=1781527177;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zkgaCBda6Y877+CjKRt/sYD9RBoNVDRYmRHljB0GIc8=;
        b=ggl7/x+/knZiT0bPRDdNqOqTPahqRosaZJGpwxmG7OuI+GsEkVfJmZiS9YcJbtbqCY
         0jmewALAZxhCmefGTk0wTkz+x4gVDhRfL8q+Y1GCPnP9VxXsWyyHgqp7vw7syLJScR4E
         /hak8Wfe2mZoOTqkgwtlKKOzag0DlRckcDjHfz8ochvCy7v0PYlfuR98/+118ZmdLj4x
         Wv8jI+VECXJhF23ZWbzZ6qMbxqnYdKGJhvUz3FSdZQxUHVJBwrDFtXU/Ue0QrrQqyZ2c
         Kq3seCbi36W/dYEsUtKqS7eslVZTlioZCdDocUBynvwZZcBPG4Bet9Y8Lb5bSycfbhNw
         tkCg==
X-Forwarded-Encrypted: i=1; AFNElJ/Koy3hGHJH96q2qpF+WCIvv/U5dg3VOvqm0QQAES8hs2GJKVZvHdunQMTwIQqac/o4a/a9YwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4IdBmThMB1wnco3MaLknTD881aDBeCti6XMpQbHD59Skbf3Kq
	TafPeZIRai5UmKDVP8pdmmc5LMybVPs3mwnTaWUplpyp1NBXDWosguZ5kP4x8D1S+MQzZSu/yyV
	qhUjzfTvH0redXQ==
X-Received: from qtpn13.prod.google.com ([2002:ac8:674d:0:b0:517:608c:4c62])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:a15:b0:517:7cd7:271a with SMTP id d75a77b69052e-51795c5a354mr184954231cf.52.1780922376439;
 Mon, 08 Jun 2026 05:39:36 -0700 (PDT)
Date: Mon,  8 Jun 2026 12:39:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260608123935.524879-1-edumazet@google.com>
Subject: [PATCH net] net: watchdog: fix refcount tracking races
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296537-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com,m:syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,381d82bbf0253710b35d,3479efbc2821cb2a79f2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32013656467

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
 include/linux/netdevice.h |  7 ++++++-
 net/sched/sch_generic.c   | 26 +++++++++++++++-----------
 2 files changed, 21 insertions(+), 12 deletions(-)

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
index a93321db8fd75d30c61e146c290bbc139c37c913..6ca7cec17b3164a481e72368376315d9b9d289cd 100644
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
@@ -586,10 +588,14 @@ void netdev_watchdog_up(struct net_device *dev)
 		return;
 	if (dev->watchdog_timeo <= 0)
 		dev->watchdog_timeo = 5*HZ;
+	spin_lock_bh(&dev->tx_global_lock);
 	if (!mod_timer(&dev->watchdog_timer,
-		       round_jiffies(jiffies + dev->watchdog_timeo)))
-		netdev_hold(dev, &dev->watchdog_dev_tracker,
-			    GFP_ATOMIC);
+		       round_jiffies(jiffies + dev->watchdog_timeo))) {
+		if (IS_ERR_OR_NULL(dev->watchdog_dev_tracker))
+			netdev_hold(dev, &dev->watchdog_dev_tracker,
+				    GFP_ATOMIC);
+	}
+	spin_unlock_bh(&dev->tx_global_lock);
 }
 EXPORT_SYMBOL_GPL(netdev_watchdog_up);
 
@@ -614,8 +620,6 @@ void netif_carrier_on(struct net_device *dev)
 			return;
 		atomic_inc(&dev->carrier_up_count);
 		linkwatch_fire_event(dev);
-		if (netif_running(dev))
-			netdev_watchdog_up(dev);
 	}
 }
 EXPORT_SYMBOL(netif_carrier_on);
-- 
2.54.0.1032.g2f8565e1d1-goog


