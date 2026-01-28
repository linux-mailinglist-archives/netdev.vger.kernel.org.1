Return-Path: <netdev+bounces-254209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCP+LRLweWnT1AEAu9opvQ
	(envelope-from <netdev+bounces-254209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:16:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2604CA027B
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3AF83004CBE
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7CF2FE591;
	Wed, 28 Jan 2026 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="z+NB5rwR";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="z+NB5rwR"
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE78227CB04;
	Wed, 28 Jan 2026 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769598983; cv=none; b=pU5OAtQCk6pt1RHrdWenrX3nYj537+2cKCmY2/B4Y2Zj8+Y8yFf6cOTpOAgg09w/WJeMOfdt1YUZ09fiDZe2YEWgy37QTAF83CSr2H8xT3lXFroABzYbb+zzFSeABgLsuiZrZHb7qQHUadA4UINDkMRWzdGoeGJApqfx3sRLPio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769598983; c=relaxed/simple;
	bh=zmT41P/PEUmTJaTpMuvIsgHatzDSDnhYuLokfcqBJh4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jTPzbTBLFCfEIWt5XzR0c1YTmi6XRtA7OtwgBW6JFyinyKWKtbkLj/xnhPKyHS1CEmtGZ765Kmy27FpqWnlAWrc99I4rXSq8zaX0ZY4NKc9XZc0sD/1g28efZo0dVjv5JVK8v/+J+xFxTeZr4v0Ds/rFFWEHvW7YY7aAB95flIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=z+NB5rwR; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=z+NB5rwR; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VPCF7oe3aSRZOrTu6fR7Jfgi4D8KmzGxI2cvCpAp8Do=;
	b=z+NB5rwRt3Z7QKn8wj3ZEvYzDPP7tVfxoXHeBXmFDjHYmeyrkj90ccIHS/tOxjMlhK32oLOEz
	k6HbUtRtE1gq8UgIZc2mFJhucMJfot9BEdjCExvwWVdL1uCZDnCh6z73D2aVc5g9QlNEKp6DH0t
	gfI/tOsjG7eOb0N6DYuPHIA=
Received: from canpmsgout11.his.huawei.com (unknown [172.19.92.148])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4f1KSw0xvQz1BFnl;
	Wed, 28 Jan 2026 19:15:44 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VPCF7oe3aSRZOrTu6fR7Jfgi4D8KmzGxI2cvCpAp8Do=;
	b=z+NB5rwRt3Z7QKn8wj3ZEvYzDPP7tVfxoXHeBXmFDjHYmeyrkj90ccIHS/tOxjMlhK32oLOEz
	k6HbUtRtE1gq8UgIZc2mFJhucMJfot9BEdjCExvwWVdL1uCZDnCh6z73D2aVc5g9QlNEKp6DH0t
	gfI/tOsjG7eOb0N6DYuPHIA=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f1KPR6WZLzKm4b;
	Wed, 28 Jan 2026 19:12:43 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9EE8440562;
	Wed, 28 Jan 2026 19:16:12 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 28 Jan 2026 19:16:12 +0800
Received: from localhost.localdomain (10.50.85.175) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 28 Jan 2026 19:16:11 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <andrew+netdev@lunn.ch>,
	<sdf@fomichev.me>, <kuniyu@google.com>, <skhawaja@google.com>,
	<ahmed.zaki@intel.com>, <willemb@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhangchangzhong@huawei.com>, Dong Chenchen <dongchenchen2@huawei.com>
Subject: [BUG Report] BUG: soft lockup in ptype seq_file traversal
Date: Wed, 28 Jan 2026 19:23:48 +0800
Message-ID: <20260128112348.3950437-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200002.china.huawei.com (7.202.195.90)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254209-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongchenchen2@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 2604CA027B
X-Rspamd-Action: no action

Hello,

syzkaller found a data race during concurrent traversal and modification
of packet_type list that can lead to soft lockups.

call trace as below:

watchdog: BUG: soft lockup - CPU#3 stuck for 35819s! [test:611]
Modules linked in:
CPU: 3 UID: 0 PID: 611 Comm: test Tainted: G -
L      6.19.0-rc4-00013-g7f98ab9da046 #2 NONE
Tainted: [L]=SOFTLOCKUP
Hardware name: linux,dummy-virt (DT)
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __asan_load8+0x4c/0xc0
lr : ptype_seq_next+0x3c/0x280
Call trace:
 __asan_load8+0x4c/0xc0 (P)
 ptype_seq_next+0x3c/0x280
 traverse.part.0+0xe8/0x250
 seq_read_iter+0x49c/0x780
 seq_read+0x190/0x210
 proc_reg_read+0x110/0x180
 do_loop_readv_writev.part.0+0x184/0x208
 vfs_readv+0x290/0x300
 __arm64_sys_preadv+0x15c/0x1c8
 invoke_syscall+0x68/0x190
 el0_svc_common.constprop.0+0x11c/0x150
 do_el0_svc+0x3c/0x58
 el0_svc+0x40/0xf8
 el0t_64_sync_handler+0xa0/0xe8
 el0t_64_sync+0x1ac/0x1b0

Root cause analysis:
The ptype_head maintains two lists: net->ptype_all and dev->ptype_all.
It determines whether the current pt belongs to the net->ptype_all or
dev->ptype_all list by examining the value of pt->dev. When pt->dev does
not correspond to the list that pt is currently in, the list head detection
will no longer work correctly.

The race condition occurs when ptype_seq_next() is traversing the list
while another thread concurrently modifies the list by removing/readding
packet_type entries.

CPU1				CPU2
ptype_seq_next
    nxt = pt->list.next;
    //nxt = ptype_head(pt) = dev->ptype_all
				packet_release/packet_notifier
				    unregister_prot_hook(sk, false);
				    //no sync wait, pt->list.next not change
				    po->prot_hook.dev = NULL;
    if (pt->dev) //check fail 
        if (nxt != &pt->dev->ptype_all)
            goto found;
    if (nxt != &ptype_all) //check success
        goto found;
found:
    return list_entry(nxt, struct packet_type, list);
    //return list head to seq traversal

reproduce flow:
fd=socket(AF_PACKET)
packet_bind(fd, dev)
			cat /proc/net/ptype //can add delay to ptype_seq_next
close(fd)

I have a preliminary fix as bellow[1], but the ptype file traversal may
block the psock release and dev unregister.
Does anyone have a good idea to solve this problem?

-----
Best Regards,
Dong Chenchen

[1] 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5870a9e514a5..ff92b8e8fc46 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2947,6 +2947,8 @@ struct packet_type {
        struct list_head        list;
 };
 
+extern rwlock_t ptype_lock;
+
 struct offload_callbacks {
        struct sk_buff          *(*gso_segment)(struct sk_buff *skb,
                                                netdev_features_t features);
diff --git a/net/core/dev.c b/net/core/dev.c
index 36dc5199037e..240702ac247e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -168,7 +168,9 @@
 #include "devmem.h"
 #include "net-sysfs.h"
 
-static DEFINE_SPINLOCK(ptype_lock);
+DEFINE_RWLOCK(ptype_lock);
+EXPORT_SYMBOL(ptype_lock);
+
 struct list_head ptype_base[PTYPE_HASH_SIZE] __read_mostly;
 
 static int netif_rx_internal(struct sk_buff *skb);
@@ -609,9 +611,9 @@ void dev_add_pack(struct packet_type *pt)
        if (WARN_ON_ONCE(!head))
                return;
 
-       spin_lock(&ptype_lock);
+       write_lock(&ptype_lock);
        list_add_rcu(&pt->list, head);
-       spin_unlock(&ptype_lock);
+       write_unlock(&ptype_lock);
 }
 EXPORT_SYMBOL(dev_add_pack);
 
@@ -636,7 +638,7 @@ void __dev_remove_pack(struct packet_type *pt)
        if (!head)
                return;
 
-       spin_lock(&ptype_lock);
+       write_lock(&ptype_lock);
 
        list_for_each_entry(pt1, head, list) {
                if (pt == pt1) {
@@ -647,7 +649,7 @@ void __dev_remove_pack(struct packet_type *pt)
 
        pr_warn("dev_remove_pack: %p not found\n", pt);
 out:
-       spin_unlock(&ptype_lock);
+       write_unlock(&ptype_lock);
 }
 EXPORT_SYMBOL(__dev_remove_pack);
 
diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
index 70e0e9a3b650..e6234f8e243f 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -213,6 +213,7 @@ static void *ptype_seq_start(struct seq_file *seq, loff_t *pos)
        __acquires(RCU)
 {
        rcu_read_lock();
+       read_lock(&ptype_lock);
        return *pos ? ptype_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
 }
 
@@ -274,6 +275,7 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 static void ptype_seq_stop(struct seq_file *seq, void *v)
        __releases(RCU)
 {
+       read_unlock(&ptype_lock);
        rcu_read_unlock();
 }

