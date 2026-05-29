Return-Path: <netdev+bounces-293131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI9jK/ybGWrFxwgAu9opvQ
	(envelope-from <netdev+bounces-293131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:00:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D47603315
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 567B730E14E7
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3770036A36D;
	Fri, 29 May 2026 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsV9YZYr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A4E25B099
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063047; cv=none; b=aFk7bMCPEMi2FVAfIHwTvkDWyJtBlIa8ePP5h665FvI0u1BbQERvcAOz/pnxjPD3JtzBcuvCz44yQac3LtANfe7d9+hX/1f69iWSEljLceaqNYiHBxUMW+nWL+QKDzrzGFOcNb82kPEdckXIjqtUePZgHbvDI3ZVYUOsclZaLHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063047; c=relaxed/simple;
	bh=nr2yEUeu+wdMFSGkEuwAJ5Y9vDrh44/c8NxARKkw9SI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DB5B/MxGC6L/2XpWDDlYNPhvdE3WOelgMzgROsqQTRXV6DsOtgVDXy87zbK5Mhk/VTlZjw3fiqq+iWSuwO59O0B4UeP2ZokJRtf3cDQX4L0VmeOyK+7IhEdAip//Tqh+7/M/BV8+99/1V/RRkL8BSwi5wGNViDwQ1dtnYxp3XNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsV9YZYr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891cd5927dso13033825e9.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 06:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780063044; x=1780667844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EMthejGR78ZJGkEJ2tL7EJhpIAJ7NXzJ38LmsR6Bv2Y=;
        b=QsV9YZYr262x2VT4GZwVO3+E47TCZqnuflFUQfPhpZ1rTYPFSK+x+WQcwSmhTNS/F8
         CyqejlN7SaOg94IIrxP/+5642sPRrVepya/wWA0CVD6caXfdLCgULDPrPvgc9ohmMHT+
         jTSTFJW0G07hjMLvUOnZ5dcgIqLZZcErCVWicnxZqQjizPHR2PrROltAN1jVyqKi7tyK
         R3atIC0EbkVTnF3KnWdctR5T5AQ/yUg8WfHRu31rofp18cUTtVaEfWcZ07d9ipU7WSd+
         OXaxsDN8C6ki8/MAurcKtHKhEmj87wWqO+kA1gdv30uLmZwvBE5/JY3BQqMy3ZGk/exY
         5HqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780063044; x=1780667844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMthejGR78ZJGkEJ2tL7EJhpIAJ7NXzJ38LmsR6Bv2Y=;
        b=L+KSoQ7p2ra15xVRZ6VqmIURd6KcKUrUCiDzP83ztgMG0pc1Qk5OvI4tGHnEloMwJ7
         m7jxFbBzOln9MpzaFLQZXbwSZDakl1mVnudwCUswgvHldD+C/PO6pVSvcyPbkFdtocKe
         +/sNM4S/KRuU40mvPLRugVbf76EnpurylNtLBtWuJfUR6ynEdmt5orFk0KKBN5Gm4n9U
         r1/ZjA51I0+hTfME1dyX5fX1E0x+jlDaRd/qhZW0O8KnSQS5TtkgDgErOaWu7W/z4QKd
         4P44q7L/Se1+C7vU010pS11mFcF5nmwvUkd6E+Hs5pcTh609TiHhznq/IYVxyU7ayWU2
         JLxg==
X-Gm-Message-State: AOJu0YwsNFOxadCgA5ghSmdy7o1XbjG/9ihysIchxmqUEWIHoQxcV/Gl
	lO8eOeK9BSqbylknlP5mHdyEyjAJQShy1JLGcWggSLtj3LIel8T7pPuN
X-Gm-Gg: Acq92OHYgF86/K43rGvJpu/5HK4vK0orOjR9zSzJSOGm5uDLLwFHpLgQmqo7zsX9ee/
	+nu4vXmFXgdDaFSS7zoz0uVZcl5Q624X7Bk34O5ayca2liQ6kVnW6Ca4WeyMu2/pGen52OaYizF
	pKnpIcMKyU4ktKtRoKi/sGC4JsJdVuxB9utuGW8hhiw1snkWK/dnNydHH3ZHb4HajPG5x3WvigC
	5VYwQPTjBNdy3TevTxKQuutPfkMBaUUgksqqim8tzCjaIoOyTyAeBxOZOG80lgOXqR1MyX7rjJz
	H1byfpeqXvdPYykpcJFP5qSzEM4+tf5369VVYz86/iKAMr12D+RVfLIIqg7dKRFjOA/IsudgE9j
	+Tnu0+V1VjPytKP4U8mSQmKqKeIBy2vXakJB/zarFLK+NGAiT6GNKCxT38YYYFpPdInyzwAatPD
	yzAylF7OS0O6IM80HL4tPjH6eL6JogJyuFErphPpHDupSDE4VzuyolCw52OYRcYtbCExPjSd/rq
	Ns8PL5POWnLuEbVYg==
X-Received: by 2002:a05:600c:1d0d:b0:48a:5546:619e with SMTP id 5b1f17b1804b1-4909c09edfdmr21423515e9.4.1780063043662;
        Fri, 29 May 2026 06:57:23 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc4.inf.ethz.ch. [129.132.161.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c09be7fsm15302455e9.7.2026.05.29.06.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:57:23 -0700 (PDT)
From: Zijing Yin <yzjaurora@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zijing Yin <yzjaurora@gmail.com>
Subject: [PATCH net v2] netdevsim: fib: fix use-after-free of FIB data via debugfs
Date: Fri, 29 May 2026 06:57:17 -0700
Message-ID: <20260529135718.1804031-1-yzjaurora@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293131-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yzjaurora@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 37D47603315
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netdevsim: fib: fix use-after-free of FIB data via debugfs

Writing to the netdevsim debugfs file
"netdevsim/netdevsimN/fib/nexthop_bucket_activity" enters
nsim_nexthop_bucket_activity_write(), which looks up a nexthop in
data->nexthop_ht under rtnl_lock(). If a network namespace teardown,
devlink reload or device deletion runs concurrently, nsim_fib_destroy()
frees that rhashtable (and the surrounding nsim_fib_data) while the
write is still in flight, leading to a slab-use-after-free:

  BUG: KASAN: slab-use-after-free in nsim_nexthop_bucket_activity_write+0xb9e/0xdf0
  Read of size 4 at addr ff1100001a379808 by task syz.0.11967/27894

  CPU: 0 UID: 0 PID: 27894 Comm: syz.0.11967 Not tainted 7.1.0-rc4-gf6f1bfc1980a #4
  Call Trace:
   nsim_nexthop_bucket_activity_write+0xb9e/0xdf0
   full_proxy_write+0x135/0x1a0
   vfs_write+0x2e2/0x1040
   ksys_write+0x146/0x270
   __x64_sys_write+0x76/0xb0
   do_syscall_64+0xb9/0x5b0
   entry_SYSCALL_64_after_hwframe+0x74/0x7c

  Allocated by task 15957:
   rhashtable_init_noprof+0x3ec/0x860
   nsim_fib_create+0x371/0xca0
   nsim_drv_probe+0xd60/0x15c0
   ...
   new_device_store+0x425/0x7f0

  Freed by task 24:
   rhashtable_free_and_destroy+0x10d/0x620
   nsim_fib_destroy+0xc9/0x1c0
   nsim_dev_reload_destroy+0x1e7/0x530
   nsim_dev_reload_down+0x6b/0xd0
   devlink_reload+0x1b5/0x770
   devlink_pernet_pre_exit+0x25d/0x3a0
   ops_undo_list+0x1b7/0xb90
   cleanup_net+0x47f/0x8a0

  The buggy address belongs to the object at ff1100001a379800
   which belongs to the cache kmalloc-1k of size 1024

The freed 1k object is the bucket table of data->nexthop_ht. Shortly
after, the dangling table is dereferenced again and the machine also
takes a GPF in __rht_bucket_nested() from the same call site.

The root cause is a lifetime mismatch: the debugfs files reference
nsim_fib_data (the writer dereferences data->nexthop_ht), but the
interface is not bracketed around the lifetime of that data.
nsim_fib_destroy() freed both rhashtables and only removed the debugfs
directory afterwards, and nsim_fib_create() created the debugfs files
before the rhashtables were initialized and, on the error path, freed
them before removing the files. debugfs keeps the file itself alive
across a ->write() via debugfs_file_get()/debugfs_file_put()
(fs/debugfs/file.c), but it does not keep data->nexthop_ht alive, so the
in-flight writer dereferenced freed memory. rtnl_lock() in the writer
does not help, because the teardown path does not take rtnl around
rhashtable_free_and_destroy().

Fix it by bracketing the debugfs interface around the data it exposes,
keeping nsim_fib_create() and nsim_fib_destroy() symmetric:

 - In nsim_fib_destroy(), tear down the debugfs files before the data
   structures they reference. debugfs_remove_recursive() drops the
   initial active-user reference and then waits for every in-flight
   ->write() to drop its reference before returning, and rejects new
   opens (__debugfs_file_removed(), fs/debugfs/inode.c). Once it returns,
   no debugfs accessor can reach the FIB data, so the rhashtables and
   nsim_fib_data can be destroyed safely. This also covers the bool knobs
   in the same directory, which store pointers into the same
   nsim_fib_data, and the final kfree(data).

 - In nsim_fib_create(), create the debugfs files after the rhashtables
   and notifiers are set up. This closes the same race on the
   error-unwind path, where a concurrent writer could otherwise observe a
   half-constructed instance or a table that the unwind has already
   freed. (With only the destroy-side change, a writer racing the create
   window instead dereferences an uninitialized data->nexthop_ht.)

This is reproducible by racing, in a loop, writes to
/sys/kernel/debug/netdevsim/netdevsimN/fib/nexthop_bucket_activity
against a teardown of the same netdevsim instance -- a devlink reload
("devlink dev reload netdevsim/netdevsimN"), destroying the network
namespace it lives in, or "echo N > /sys/bus/netdevsim/del_device". It
was found with syzkaller; a syzkaller reproducer is available. A
standalone C reproducer does not trigger it reliably because the race
needs the netns-teardown/reload path.

Fixes: c6385c0b67c5 ("netdevsim: Allow reporting activity on nexthop buckets")
Cc: stable@vger.kernel.org
Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
---
v2:
 - Move nsim_fib_debugfs_exit() to just before unregister_fib_notifier()
   in nsim_fib_destroy(), so it mirrors nsim_fib_debugfs_init()'s position
   in nsim_fib_create() (Ido Schimmel).
 - Drop the explanatory comments.

Link to v1: https://lore.kernel.org/all/20260526160910.1614609-1-yzjaurora@gmail.com/

 drivers/net/netdevsim/fib.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/netdevsim/fib.c b/drivers/net/netdevsim/fib.c
index 1a42bdbfa..55bcdefad 100644
--- a/drivers/net/netdevsim/fib.c
+++ b/drivers/net/netdevsim/fib.c
@@ -1562,14 +1562,11 @@ struct nsim_fib_data *nsim_fib_create(struct devlink *devlink,
 	data->devlink = devlink;
 
 	nsim_dev = devlink_priv(devlink);
-	err = nsim_fib_debugfs_init(data, nsim_dev);
-	if (err)
-		goto err_data_free;
 
 	mutex_init(&data->nh_lock);
 	err = rhashtable_init(&data->nexthop_ht, &nsim_nexthop_ht_params);
 	if (err)
-		goto err_debugfs_exit;
+		goto err_nh_lock_destroy;
 
 	mutex_init(&data->fib_lock);
 	INIT_LIST_HEAD(&data->fib_rt_list);
@@ -1600,6 +1597,10 @@ struct nsim_fib_data *nsim_fib_create(struct devlink *devlink,
 		goto err_nexthop_nb_unregister;
 	}
 
+	err = nsim_fib_debugfs_init(data, nsim_dev);
+	if (err)
+		goto err_fib_notifier_unregister;
+
 	devl_resource_occ_get_register(devlink,
 				       NSIM_RESOURCE_IPV4_FIB,
 				       nsim_fib_ipv4_resource_occ_get,
@@ -1622,6 +1623,8 @@ struct nsim_fib_data *nsim_fib_create(struct devlink *devlink,
 				       data);
 	return data;
 
+err_fib_notifier_unregister:
+	unregister_fib_notifier(devlink_net(devlink), &data->fib_nb);
 err_nexthop_nb_unregister:
 	unregister_nexthop_notifier(devlink_net(devlink), &data->nexthop_nb);
 err_rhashtable_fib_destroy:
@@ -1633,10 +1636,8 @@ struct nsim_fib_data *nsim_fib_create(struct devlink *devlink,
 	rhashtable_free_and_destroy(&data->nexthop_ht, nsim_nexthop_free,
 				    data);
 	mutex_destroy(&data->fib_lock);
-err_debugfs_exit:
+err_nh_lock_destroy:
 	mutex_destroy(&data->nh_lock);
-	nsim_fib_debugfs_exit(data);
-err_data_free:
 	kfree(data);
 	return ERR_PTR(err);
 }
@@ -1653,6 +1654,7 @@ void nsim_fib_destroy(struct devlink *devlink, struct nsim_fib_data *data)
 					 NSIM_RESOURCE_IPV4_FIB_RULES);
 	devl_resource_occ_get_unregister(devlink,
 					 NSIM_RESOURCE_IPV4_FIB);
+	nsim_fib_debugfs_exit(data);
 	unregister_fib_notifier(devlink_net(devlink), &data->fib_nb);
 	unregister_nexthop_notifier(devlink_net(devlink), &data->nexthop_nb);
 	cancel_work_sync(&data->fib_flush_work);
@@ -1665,6 +1667,5 @@ void nsim_fib_destroy(struct devlink *devlink, struct nsim_fib_data *data)
 	WARN_ON_ONCE(!list_empty(&data->fib_rt_list));
 	mutex_destroy(&data->fib_lock);
 	mutex_destroy(&data->nh_lock);
-	nsim_fib_debugfs_exit(data);
 	kfree(data);
 }
-- 
2.43.0

