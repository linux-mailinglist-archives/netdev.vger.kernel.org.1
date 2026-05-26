Return-Path: <netdev+bounces-291802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOxxCWLHFWqMbAcAu9opvQ
	(envelope-from <netdev+bounces-291802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:16:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 916135D97EC
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A0DC304FFF2
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874A73AEF50;
	Tue, 26 May 2026 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lut5B/Eg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE90214204
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811764; cv=none; b=mJjz/7zTLpLibHPorGcYeGbbwWnyd5eCTFRq3QxCvlaRl1jOnzCO1f7c04Q4bh6pg2YHpyE45GaIH5d8Lvo8/Qb6m5UKYdwTrae5Or9VHmPxeL6pwq5EysnAhUIEs5DpvQkOy3hLzD0KBIDRiBZFzIuvrTbvhVjLOYOo21djn5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811764; c=relaxed/simple;
	bh=IIaRnAq8fwSe5ZI2L4/8ugVgGPoNJJgdd0Nookr0qiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dfKV/DuFE8/1lAJzzmyAeL6hfonBOCx/F7lXMcUqkK05AKcE5QZUwBxVE+gtjEYsn68dcklbPZDW1cb57zmabSc7GHJc/Qi3VBK4b3GZTGculBzaIS8L4aZfntbnYolvJLdUeOg+WMz9ZCSXVxg/Ava8KiZ8idi2kTB7lktW2xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lut5B/Eg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891c569cb1so10635235e9.2
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 09:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779811761; x=1780416561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wbGMrs6mKP7/McxLRtMloxtaAKJE748FB1PFBoDVPOs=;
        b=lut5B/Eg0+VsrMYrDS1vYC8C7bzJl03RItaoSBaP7e5k8utt6X90NtdlQSux4CKd8Y
         2gn+TuTptGDLzrGgJl7HDhuXU/wLxjozVgPq1kG+pGq/WuJFoZpESUhPkhT5EpGbPtp4
         ur2LoPTEJBu2R0ff62nBR1dHGiehQoQLmmeypO3sw0staOxN5wf2TEbNUgqiPX3g7+bz
         Y5+6RVp6Ei7BIAokOSaTUIspSyAW1X5fB5j0QMNnbgJuHO3u7ZuY1yXmZcjumBDDfy9C
         wBsk4o/8aoh92K44Ic1fdZHcsKZ0trxIUa0fRzpT3GE59ZsFR/VUjDxQkH0eOZfH/mt/
         1bFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779811761; x=1780416561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbGMrs6mKP7/McxLRtMloxtaAKJE748FB1PFBoDVPOs=;
        b=iKwOjNr4adlQBOKh/BERsJlb92rTCAwWW/iiUVWOS6WbUe3SvVR+CDpu/WgWqwBkue
         5dIg8BxKxVcjXS58Dk44fWBOUqseUIKSj01aSvmJijRtIV0iTxXW2i6tmZbjpasnbdQB
         lnJF0gBafGnarMLXPc6ZbeYVUDIYK2QDJQfCIFRsOaTqfmdQd7Be78I5oadlg88kwreY
         Xhtg7R1cb2BJ0ZGflDz4mdWTutWSW3sPm1ozHdtFjR60zhUVDHI0PudUosEwOWtEw2ei
         3c7ISiNrmkk4RyJMlK2gJabZnnGrMtuHLHLR+Zerq6nm25bW6GCaRPWcd1HTdpjBbJ9v
         7V/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9LNRzyXwBWqjx7KwccKgxUsz5xu5+9y5YZVXYsfwjsvuUzni+K+OuJAzMTPUZ1Hz2eqachBOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxco7m1i/1HXuM0eAeSimoGVh18Knb6y9HFAe+PdiRtvwdLsBtB
	hrmujOoc9m2Uf7IpMT3a0+n1k5efQOy+2XNiD4He+myQbJ7X7t925O3C
X-Gm-Gg: Acq92OFGpCFRKzbz1fXb/UjKEiJEBsKXDM3SDnUBFzCzlqx7dybrmyI98M/L2fFRjIl
	iile+dd/9jLgg208rbrB13wylY7OlBIim/DJbUdaFDuESmeyppI6ugmyhNB/TDWBRImwU+Z4Apc
	pLEtFsZQy6zCFOihkV6iQi/pxIXYkV2gO88KJ/22NZUy2X+PM9lCuROy3ccabM9WkLrb8BRdzAE
	fh5zBAXR+MLtUS9zz1DWw02KsgNQkCawGlTMkMhypyA6PFxrkg6Lo1hJ4R6+yapcwGKSqwenuYN
	u8NEY8FIT18ugXe+NmQrwtES2cbZA0HxGd78herMLtmdbzfxGBfaftE+NZ6ej36knTuQoSo151A
	BjItktSG/lF5MPnScsBaouixjdtcAo/erPtTGNoUY/bOsrYNgtaVUs2CuAntTF1G43+PpbWPguG
	Y7Y2NwcIcKuVOlKwnIzc60b8RTGweDetLDqPq1LtVPv2mgcXJOE8NrnzEoX7Datuwnla8BAJHS4
	xepbWc=
X-Received: by 2002:a05:600c:b96:b0:490:4923:aa3e with SMTP id 5b1f17b1804b1-4904923ab35mr134408535e9.7.1779811760718;
        Tue, 26 May 2026 09:09:20 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc4.inf.ethz.ch. [129.132.161.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb9asm39715116f8f.27.2026.05.26.09.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:09:20 -0700 (PDT)
From: Zijing Yin <yzjaurora@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>
Cc: Zijing Yin <yzjaurora@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] netdevsim: fib: fix use-after-free of FIB data via debugfs
Date: Tue, 26 May 2026 09:09:08 -0700
Message-ID: <20260526160910.1614609-1-yzjaurora@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291802-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 916135D97EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

This is reproducible by racing, in a loop, writes to
/sys/kernel/debug/netdevsim/netdevsimN/fib/nexthop_bucket_activity
against a teardown of the same netdevsim instance -- a devlink reload
("devlink dev reload netdevsim/netdevsimN"), destroying the network
namespace it lives in, or "echo N > /sys/bus/netdevsim/del_device". It
was found with my customized syzkaller; a reproducer is available. A
standalone C reproducer does not trigger it reliably because the race
needs the netns-teardown/reload path.

Reproducer: https://pastebin.com/raw/Q0ZGxBTu

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

Fix it by bracketing the debugfs interface around the data it exposes:

 - In nsim_fib_destroy(), remove the debugfs files first.
   debugfs_remove_recursive() drops the initial active-user reference and
   then waits for every in-flight ->write() to drop its reference before
   returning, and rejects new opens (__debugfs_file_removed(),
   fs/debugfs/inode.c). Once it returns, no debugfs accessor can reach
   the FIB data, so the rhashtables and nsim_fib_data can be destroyed
   safely. This also covers the bool knobs in the same directory, which
   store pointers into the same nsim_fib_data, and the final kfree(data).

 - In nsim_fib_create(), create the debugfs files last, after the
   rhashtables and notifiers are set up. This closes the same race on the
   error-unwind path, where a concurrent writer could otherwise observe a
   half-constructed instance or a table that the unwind has already
   freed. (With only the destroy-side change, a writer racing the create
   window instead dereferences an uninitialized data->nexthop_ht.)


Fixes: c6385c0b67c5 ("netdevsim: Allow reporting activity on nexthop buckets")
Cc: stable@vger.kernel.org
Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
---
 drivers/net/netdevsim/fib.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/netdevsim/fib.c b/drivers/net/netdevsim/fib.c
index 1a42bdbfa..b1aacb0ee 100644
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
@@ -1600,6 +1597,16 @@ struct nsim_fib_data *nsim_fib_create(struct devlink *devlink,
 		goto err_nexthop_nb_unregister;
 	}
 
+	/* Publish the debugfs interface only after every data structure it
+	 * operates on has been initialized. The files reference this
+	 * nsim_fib_data (e.g. "nexthop_bucket_activity" looks up
+	 * data->nexthop_ht), so a concurrent debugfs access must never be able
+	 * to observe a half-constructed instance.
+	 */
+	err = nsim_fib_debugfs_init(data, nsim_dev);
+	if (err)
+		goto err_fib_notifier_unregister;
+
 	devl_resource_occ_get_register(devlink,
 				       NSIM_RESOURCE_IPV4_FIB,
 				       nsim_fib_ipv4_resource_occ_get,
@@ -1622,6 +1629,8 @@ struct nsim_fib_data *nsim_fib_create(struct devlink *devlink,
 				       data);
 	return data;
 
+err_fib_notifier_unregister:
+	unregister_fib_notifier(devlink_net(devlink), &data->fib_nb);
 err_nexthop_nb_unregister:
 	unregister_nexthop_notifier(devlink_net(devlink), &data->nexthop_nb);
 err_rhashtable_fib_destroy:
@@ -1633,16 +1642,23 @@ struct nsim_fib_data *nsim_fib_create(struct devlink *devlink,
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
 
 void nsim_fib_destroy(struct devlink *devlink, struct nsim_fib_data *data)
 {
+	/* Tear down the debugfs files before freeing the data structures they
+	 * operate on. debugfs_remove_recursive() waits for any in-flight file
+	 * operation (e.g. a write to "fib/nexthop_bucket_activity", which looks
+	 * up data->nexthop_ht) to finish and prevents new ones from starting,
+	 * so the rhashtables are not freed while a concurrent accessor still
+	 * dereferences them.
+	 */
+	nsim_fib_debugfs_exit(data);
+
 	devl_resource_occ_get_unregister(devlink,
 					 NSIM_RESOURCE_NEXTHOPS);
 	devl_resource_occ_get_unregister(devlink,
@@ -1665,6 +1681,5 @@ void nsim_fib_destroy(struct devlink *devlink, struct nsim_fib_data *data)
 	WARN_ON_ONCE(!list_empty(&data->fib_rt_list));
 	mutex_destroy(&data->fib_lock);
 	mutex_destroy(&data->nh_lock);
-	nsim_fib_debugfs_exit(data);
 	kfree(data);
 }
-- 
2.43.0


