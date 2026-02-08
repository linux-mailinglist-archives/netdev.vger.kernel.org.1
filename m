Return-Path: <netdev+bounces-257817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMZAGw5tiGmbpQQAu9opvQ
	(envelope-from <netdev+bounces-257817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 12:01:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C37041086F6
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 12:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C0E0300B10E
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 11:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E250D3090EE;
	Sun,  8 Feb 2026 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdrN81RQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YndmM42O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D11327AC21
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770548491; cv=none; b=MUwjdwNoIzHum6nJMGOUx4/oEtOo+rVh6E263XqtFEBhWTGu15i2MWBtVVzr6GR9u565Dv67K7uBTBIVMUmjGoc2rGqjpdWV/ElAoXV3HrkJZRCNgBJuuZ+ejPxOJQa0ZyMA4s1oem+RKd3amMvaLtueml2DYyzmOMlq9Fb74hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770548491; c=relaxed/simple;
	bh=OUr0/EjBwKUIq9wjaQQSTfUmconlBsUbiqw3HhthXB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QSUhBsbP61ZAaSVfo2BMK9auQQdEygWZ28HJGZQU81sYbygzMKbGwbccjp26h33slMa8w36pe704POrgM8EVjIxGAhu+PDebgacgJ3yViKEWAbEOA1G2fyekg6mqBG8t+1iQdv4FIRPu6qO5TN8zjLWxh1HANOXiPSqrbTvd4O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdrN81RQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YndmM42O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770548490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2399lSML0+N3Gvm8VDP9m3yONrvPxPlMoYg9untbM60=;
	b=UdrN81RQkobdUHyEi3Y0N97y1Y+ix3di0YYY0W9Uh5QFe7GpJ/wvTpHUUC9O0ucsKD2gnQ
	JvAlTMgPSl4j5zPGJtMj+NA0GFFVat6TTrJdjC3KDHmjDqxsTI0ntfA4ytxSD+QzFnK3BC
	GOP60DHie4DFvtgQ01BZI8nB+fevgfQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-65-svmZHOJeuEoYgeKXPbQ-1; Sun, 08 Feb 2026 06:01:29 -0500
X-MC-Unique: 65-svmZHOJeuEoYgeKXPbQ-1
X-Mimecast-MFC-AGG-ID: 65-svmZHOJeuEoYgeKXPbQ_1770548488
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a9638b0422so6138185ad.3
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 03:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770548486; x=1771153286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2399lSML0+N3Gvm8VDP9m3yONrvPxPlMoYg9untbM60=;
        b=YndmM42ONeEvHU4fMdkFa/H0cDz2uLPFLfs8yDIEIRcWL9Y8G6CiEoGPg0pX/pGJoe
         B9n6RQVhSHjcaE9Vb/Phu/A3vke5bCMIQYIrGnE1GLZTdVUo2Ejf3RMuN/wy+XIvEQ9H
         EZ9xI6KOrmI+7qlOxPIBzTO8cT+GFT4bPt47cI0EUjkxLLFc+61u+cZLF0+NDyJRWjTC
         chT2HGAcnDNtMImdoODhdc5ZoarYgCV+q0f4bWVI6rykAdKeuzSUHyvoM9SujnAhlV08
         K1/J4z5J9WJP8Ae8QOizsfulp8jFTM9FIkIUYIE0kC+nVQESHdzK/w+8pt4SzrB33LhD
         yXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770548486; x=1771153286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2399lSML0+N3Gvm8VDP9m3yONrvPxPlMoYg9untbM60=;
        b=tDNdKSnbz0mTGZUgFDral9okX98ozqBNrmtG6hPR04RJHYmlUGT6lnd/BR1MiJ8KLl
         3FW4EyAXEc39rkCY2h67oHJEoaEdwZzlRfzPpQX8szrqnv4c1jCzs8xq3t2crxaaVp+S
         Ci7plvv4aHwdlV7KeAHcN7pO0UtHAdR0atQzPtrhaAvJbZnqcfD93WBefoofAomnSth+
         S+NnL9KA6dDxdcrDQDiJ94o7Q0swYsSfCQXvJ3pbjDSnqS1QU8/gSNja7LOZeBElU8ta
         ToCy18jhtZV67nEeFDtAazbv4pZNqhFH/p5sDBBgYi5sPBepu75BKwOk+K3FJP6kwenU
         96Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWKkFvM0IPDCJ70LFiwW4tZT+dmjTINp3fY3v8jWCiBAHFFVrGZJm8UEELIUEIdstykfqcXGj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxor1VDsT1DSVM9C78iVqatsvSP+GwF9uB1X+2I5PQqFG0lzKC/
	jM4TzXZuj5i80ebE2hQOweIMUkerZ8ubOtNdxEfeF0G7GQD2vMQU/00zRf7FR2AEhqZYMl5zVDw
	c5kfrUhpJ2iiml6YGePOHtlWSSkl/u/QuVovhKv+2yPq4aRcVblcXElYpJw==
X-Gm-Gg: AZuq6aLByfRxhjQMthPWx+DiLNvj9jz9H6g8gD2GZezTKmOH7hXjZz8NsLDuxcYv0dJ
	s3acQr8weg7d1f0Pf6TFq0OnNblv4URxG7lEbUKEsnY6cnl+pBFPEl2n1jQFAV4p2xzh090tG2R
	xH84mVc3BjznT7cDY9zopndZtDUMU8YPfoiePVTlOGLB8wrJ6PxUtoI6HzfU1li3tyYVo4tplBK
	qVDBp9tP5DRWxHl9/QcN8ZI4CkKs9d9F+WLLP2Q2AGbXnWvy+JWTo55op3ZKdRV0AV2PurGZxsm
	Nz/36y5PcU5tjm+beN51wZfpV3zsQGPimJWQrJsHLGusaUDaNuHFeGAPCT66r453ZKV4upDv171
	iMxt+XOVh+JyKARtx272U+edBKaKJr7qPJg==
X-Received: by 2002:a17:902:cf0a:b0:2a8:ff32:5f96 with SMTP id d9443c01a7336-2a95165a927mr76312285ad.13.1770548486259;
        Sun, 08 Feb 2026 03:01:26 -0800 (PST)
X-Received: by 2002:a17:902:cf0a:b0:2a8:ff32:5f96 with SMTP id d9443c01a7336-2a95165a927mr76312055ad.13.1770548485801;
        Sun, 08 Feb 2026 03:01:25 -0800 (PST)
Received: from kernel-devel.tail62cea.ts.net ([240d:1a:c0d:9f00:be24:11ff:fe35:71b3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951a638b5sm92796505ad.11.2026.02.08.03.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 03:01:25 -0800 (PST)
From: Shigeru Yoshida <syoshida@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Shigeru Yoshida <syoshida@redhat.com>
Cc: syzbot+5a66db916cdde0dbcc1c@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: [PATCH net] net: flow_offload: protect driver_block_list in flow_block_cb_setup_simple()
Date: Sun,  8 Feb 2026 20:00:50 +0900
Message-ID: <20260208110054.2525262-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257817-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syoshida@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,5a66db916cdde0dbcc1c];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: C37041086F6
X-Rspamd-Action: no action

syzbot reported a list_del corruption in flow_block_cb_setup_simple(). [0]

flow_block_cb_setup_simple() accesses the driver_block_list (e.g.,
netdevsim's nsim_block_cb_list) without any synchronization. The
nftables offload path calls into this function via ndo_setup_tc while
holding the per-netns commit_mutex, but this mutex does not prevent
concurrent access from tasks in different network namespaces that
share the same driver_block_list, leading to list corruption:

- Task A (FLOW_BLOCK_BIND) calls list_add_tail() to insert a new
  flow_block_cb into driver_block_list.

- Task B (FLOW_BLOCK_UNBIND) concurrently calls list_del() on another
  flow_block_cb from the same list.

- The concurrent modifications corrupt the list pointers.

Fix this by adding a static mutex (flow_block_cb_list_lock) that
protects all driver_block_list operations within
flow_block_cb_setup_simple(). Also add a flow_block_cb_remove_driver()
helper for external callers that need to remove a block_cb from the
driver list under the same lock, and convert nft_indr_block_cleanup()
to use it.

[0]:
list_del corruption. prev->next should be ffff888028878200, but was ffffffff8e940fc0. (prev=ffffffff8e940fc0)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:64!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6308 Comm: syz.3.231 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:__list_del_entry_valid_or_report+0x15a/0x190 lib/list_debug.c:62
[...]
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 flow_block_cb_setup_simple+0x62d/0x740 net/core/flow_offload.c:369
 nft_block_offload_cmd net/netfilter/nf_tables_offload.c:397 [inline]
 nft_chain_offload_cmd+0x293/0x660 net/netfilter/nf_tables_offload.c:451
 nft_flow_block_chain net/netfilter/nf_tables_offload.c:471 [inline]
 nft_flow_offload_chain net/netfilter/nf_tables_offload.c:513 [inline]
 nft_flow_rule_offload_commit+0x40d/0x1b60 net/netfilter/nf_tables_offload.c:592
 nf_tables_commit+0x675/0x8710 net/netfilter/nf_tables_api.c:10925
 nfnetlink_rcv_batch net/netfilter/nfnetlink.c:576 [inline]
 nfnetlink_rcv_skb_batch net/netfilter/nfnetlink.c:649 [inline]
 nfnetlink_rcv+0x1ac9/0x2590 net/netfilter/nfnetlink.c:667
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:742
 ____sys_sendmsg+0x505/0x830 net/socket.c:2630
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2719
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 955bcb6ea0df ("drivers: net: use flow block API")
Reported-by: syzbot+5a66db916cdde0dbcc1c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5a66db916cdde0dbcc1c
Tested-by: syzbot+5a66db916cdde0dbcc1c@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 include/net/flow_offload.h        |  2 ++
 net/core/flow_offload.c           | 41 ++++++++++++++++++++++++-------
 net/netfilter/nf_tables_offload.c |  2 +-
 3 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 596ab9791e4d..ff6d2bcb2cca 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -673,6 +673,8 @@ int flow_block_cb_setup_simple(struct flow_block_offload *f,
 			       flow_setup_cb_t *cb,
 			       void *cb_ident, void *cb_priv, bool ingress_only);
 
+void flow_block_cb_remove_driver(struct flow_block_cb *block_cb);
+
 enum flow_cls_command {
 	FLOW_CLS_REPLACE,
 	FLOW_CLS_DESTROY,
diff --git a/net/core/flow_offload.c b/net/core/flow_offload.c
index bc5169482710..137a44af5e1c 100644
--- a/net/core/flow_offload.c
+++ b/net/core/flow_offload.c
@@ -334,6 +334,8 @@ bool flow_block_cb_is_busy(flow_setup_cb_t *cb, void *cb_ident,
 }
 EXPORT_SYMBOL(flow_block_cb_is_busy);
 
+static DEFINE_MUTEX(flow_block_cb_list_lock);
+
 int flow_block_cb_setup_simple(struct flow_block_offload *f,
 			       struct list_head *driver_block_list,
 			       flow_setup_cb_t *cb,
@@ -341,6 +343,7 @@ int flow_block_cb_setup_simple(struct flow_block_offload *f,
 			       bool ingress_only)
 {
 	struct flow_block_cb *block_cb;
+	int err = 0;
 
 	if (ingress_only &&
 	    f->binder_type != FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS)
@@ -348,32 +351,52 @@ int flow_block_cb_setup_simple(struct flow_block_offload *f,
 
 	f->driver_block_list = driver_block_list;
 
+	mutex_lock(&flow_block_cb_list_lock);
+
 	switch (f->command) {
 	case FLOW_BLOCK_BIND:
-		if (flow_block_cb_is_busy(cb, cb_ident, driver_block_list))
-			return -EBUSY;
+		if (flow_block_cb_is_busy(cb, cb_ident, driver_block_list)) {
+			err = -EBUSY;
+			break;
+		}
 
 		block_cb = flow_block_cb_alloc(cb, cb_ident, cb_priv, NULL);
-		if (IS_ERR(block_cb))
-			return PTR_ERR(block_cb);
+		if (IS_ERR(block_cb)) {
+			err = PTR_ERR(block_cb);
+			break;
+		}
 
 		flow_block_cb_add(block_cb, f);
 		list_add_tail(&block_cb->driver_list, driver_block_list);
-		return 0;
+		break;
 	case FLOW_BLOCK_UNBIND:
 		block_cb = flow_block_cb_lookup(f->block, cb, cb_ident);
-		if (!block_cb)
-			return -ENOENT;
+		if (!block_cb) {
+			err = -ENOENT;
+			break;
+		}
 
 		flow_block_cb_remove(block_cb, f);
 		list_del(&block_cb->driver_list);
-		return 0;
+		break;
 	default:
-		return -EOPNOTSUPP;
+		err = -EOPNOTSUPP;
+		break;
 	}
+
+	mutex_unlock(&flow_block_cb_list_lock);
+	return err;
 }
 EXPORT_SYMBOL(flow_block_cb_setup_simple);
 
+void flow_block_cb_remove_driver(struct flow_block_cb *block_cb)
+{
+	mutex_lock(&flow_block_cb_list_lock);
+	list_del(&block_cb->driver_list);
+	mutex_unlock(&flow_block_cb_list_lock);
+}
+EXPORT_SYMBOL(flow_block_cb_remove_driver);
+
 static DEFINE_MUTEX(flow_indr_block_lock);
 static LIST_HEAD(flow_block_indr_list);
 static LIST_HEAD(flow_block_indr_dev_list);
diff --git a/net/netfilter/nf_tables_offload.c b/net/netfilter/nf_tables_offload.c
index fd30e205de84..d60838bceafb 100644
--- a/net/netfilter/nf_tables_offload.c
+++ b/net/netfilter/nf_tables_offload.c
@@ -414,7 +414,7 @@ static void nft_indr_block_cleanup(struct flow_block_cb *block_cb)
 				    basechain, &extack);
 	nft_net = nft_pernet(net);
 	mutex_lock(&nft_net->commit_mutex);
-	list_del(&block_cb->driver_list);
+	flow_block_cb_remove_driver(block_cb);
 	list_move(&block_cb->list, &bo.cb_list);
 	nft_flow_offload_unbind(&bo, basechain);
 	mutex_unlock(&nft_net->commit_mutex);
-- 
2.52.0


