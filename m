Return-Path: <netdev+bounces-125147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8606096C105
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5D31C22DB5
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E841DB551;
	Wed,  4 Sep 2024 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="diE4ugiH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773B61DC19C
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461066; cv=none; b=tmzQO17HyF95rcWoBFUr+Lfscj0HuwNuwFOmlGuNSdymDxycbFtegDYiDPjpUv/bIjY2vEirhYo7VYsX+t8k2oQTRWICfq+RmrNPBoFekkrq9sPJwL7Rak+d4J8NGVJ9x7B5X/kOLVBJWRFcyjENSAC6K7dJ6Em82lNeYfaH6k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461066; c=relaxed/simple;
	bh=DSSqP5N2KEnG5iU+hwEoaJ8yaVRmdjxOZwv4QktfbTQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=akb6KcgkGq3EpXBHC2ivkyBRXFxahxwDUCFIDw64oxn8zx/BL5DZlISmmTUMY1OfCgqU/CqwOiw3TOKKbuGcBCsGz9mIRAkNpV2+9hWblZqAKV2COtjW6ZgcibuKS93X+8bbYQuEBFyUdEOBXwaZisgkq7h2agyebqyBSXZz7JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=diE4ugiH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d3aa5a6715so115511857b3.2
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 07:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725461063; x=1726065863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p1I2lpzWPiVPAAzbWoLCKyOpcLz6Y5dGjfLYdYAlfmY=;
        b=diE4ugiH3lhJ8VtQX995ZTMwsiU3iA6ZjWR12tmyrQWJd24bIdEJReLyaVJCf/BbPy
         Wat8Wl8AZVTRzhFCrxOJDRi4ZhOg32F8O9lH0LDGgKD2OPi22TurKMJYZDv0gevRyuPa
         m25D2o4R2wqJhkSfZscdom9H8OJCqKH2Li+Vrc/I/+tpT9iu9grkVb0OdIzovFoAighw
         +YI6JspahSlWkP8tVZmHmOv81E7N15Eed23BkzuZAcqbu4kqOJH8iGuIVBPpk7IfLnkP
         k/wImulz66J+FxdluKf5LEZoZW2/5ZX6c/KBlDnpcfy/9baAm8v6agQXSi09poQ7iMNo
         2rzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725461063; x=1726065863;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p1I2lpzWPiVPAAzbWoLCKyOpcLz6Y5dGjfLYdYAlfmY=;
        b=I5ZPFGwkgZe0TDoNJ4I+63QQQWoXphGCJne26Q4iUCpD9d6wC5aQNx/8jbzJyvHqnQ
         uOAfBdvA/LDKECz6FEwoBbUHtRu9fb+FrWG2dLf3CFAGrZLZIB3llgSbWfHxXwLj+/CF
         Sr4PkN6bvIYvyHovVsn21d/actcqD4fAhkHyMSh+u26YFArPUXDqw/RfeWjCuDzL3AzM
         G5QPZ9GlOxdNvxqNBmuWYfk48H0A8yG9IMFuNO2+PDzJyV2tbYlGWqdBbCCxHAwC2kjX
         cLiJbcULbYSRrmhGhOQG7saEIsLcL+X5gXzPMck9EwfBLSWbp6BefddxG5/NrWyVeEh3
         jGdA==
X-Gm-Message-State: AOJu0YxHssPYu7mC5Zw30k1Unjve5E6JL+HG7rmzOJC6yDlqIympkDdv
	8xTIVGl6AKg86yo1+gDUbUhvTygL7wU90eC9UtaiGfwk/HCEvKp2Sojl2U4NPle9od8d9OYKo2j
	9GWObHF4E7Q==
X-Google-Smtp-Source: AGHT+IEcHCM9E30Pqc17EFiwvs4MvRI2Qspz/F7+Jb2wEyuOri6S2R7RUv7d09hjMmvDTr3SR1Fayp4MGlbbdQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:6309:b0:68d:52a1:bf4 with SMTP
 id 00721157ae682-6d40d78aa4amr8287197b3.2.1725461063141; Wed, 04 Sep 2024
 07:44:23 -0700 (PDT)
Date: Wed,  4 Sep 2024 14:44:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240904144418.1162839-1-edumazet@google.com>
Subject: [PATCH net] ila: call nf_unregister_net_hooks() sooner
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Tom Herbert <tom@herbertland.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"

syzbot found an use-after-free Read in ila_nf_input [1]

Issue here is that ila_xlat_exit_net() frees the rhashtable,
then call nf_unregister_net_hooks().

It should be done in the reverse way, with a synchronize_rcu().

This is a good match for a pre_exit() method.

[1]
 BUG: KASAN: use-after-free in rht_key_hashfn include/linux/rhashtable.h:159 [inline]
 BUG: KASAN: use-after-free in __rhashtable_lookup include/linux/rhashtable.h:604 [inline]
 BUG: KASAN: use-after-free in rhashtable_lookup include/linux/rhashtable.h:646 [inline]
 BUG: KASAN: use-after-free in rhashtable_lookup_fast+0x77a/0x9b0 include/linux/rhashtable.h:672
Read of size 4 at addr ffff888064620008 by task ksoftirqd/0/16

CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.11.0-rc4-syzkaller-00238-g2ad6d23f465a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:93 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
  print_address_description mm/kasan/report.c:377 [inline]
  print_report+0x169/0x550 mm/kasan/report.c:488
  kasan_report+0x143/0x180 mm/kasan/report.c:601
  rht_key_hashfn include/linux/rhashtable.h:159 [inline]
  __rhashtable_lookup include/linux/rhashtable.h:604 [inline]
  rhashtable_lookup include/linux/rhashtable.h:646 [inline]
  rhashtable_lookup_fast+0x77a/0x9b0 include/linux/rhashtable.h:672
  ila_lookup_wildcards net/ipv6/ila/ila_xlat.c:132 [inline]
  ila_xlat_addr net/ipv6/ila/ila_xlat.c:652 [inline]
  ila_nf_input+0x1fe/0x3c0 net/ipv6/ila/ila_xlat.c:190
  nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
  nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
  nf_hook include/linux/netfilter.h:269 [inline]
  NF_HOOK+0x29e/0x450 include/linux/netfilter.h:312
  __netif_receive_skb_one_core net/core/dev.c:5661 [inline]
  __netif_receive_skb+0x1ea/0x650 net/core/dev.c:5775
  process_backlog+0x662/0x15b0 net/core/dev.c:6108
  __napi_poll+0xcb/0x490 net/core/dev.c:6772
  napi_poll net/core/dev.c:6841 [inline]
  net_rx_action+0x89b/0x1240 net/core/dev.c:6963
  handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
  run_ksoftirqd+0xca/0x130 kernel/softirq.c:928
  smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
  kthread+0x2f0/0x390 kernel/kthread.c:389
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x64620
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xbfffffff(buddy)
raw: 00fff00000000000 ffffea0000959608 ffffea00019d9408 0000000000000000
raw: 0000000000000000 0000000000000003 00000000bfffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x52dc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_ZERO), pid 5242, tgid 5242 (syz-executor), ts 73611328570, free_ts 618981657187
  set_page_owner include/linux/page_owner.h:32 [inline]
  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
  prep_new_page mm/page_alloc.c:1501 [inline]
  get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3439
  __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4695
  __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
  alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
  ___kmalloc_large_node+0x8b/0x1d0 mm/slub.c:4103
  __kmalloc_large_node_noprof+0x1a/0x80 mm/slub.c:4130
  __do_kmalloc_node mm/slub.c:4146 [inline]
  __kmalloc_node_noprof+0x2d2/0x440 mm/slub.c:4164
  __kvmalloc_node_noprof+0x72/0x190 mm/util.c:650
  bucket_table_alloc lib/rhashtable.c:186 [inline]
  rhashtable_init_noprof+0x534/0xa60 lib/rhashtable.c:1071
  ila_xlat_init_net+0xa0/0x110 net/ipv6/ila/ila_xlat.c:613
  ops_init+0x359/0x610 net/core/net_namespace.c:139
  setup_net+0x515/0xca0 net/core/net_namespace.c:343
  copy_net_ns+0x4e2/0x7b0 net/core/net_namespace.c:508
  create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
  unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
  ksys_unshare+0x619/0xc10 kernel/fork.c:3328
  __do_sys_unshare kernel/fork.c:3399 [inline]
  __se_sys_unshare kernel/fork.c:3397 [inline]
  __x64_sys_unshare+0x38/0x40 kernel/fork.c:3397
page last free pid 11846 tgid 11846 stack trace:
  reset_page_owner include/linux/page_owner.h:25 [inline]
  free_pages_prepare mm/page_alloc.c:1094 [inline]
  free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
  __folio_put+0x2c8/0x440 mm/swap.c:128
  folio_put include/linux/mm.h:1486 [inline]
  free_large_kmalloc+0x105/0x1c0 mm/slub.c:4565
  kfree+0x1c4/0x360 mm/slub.c:4588
  rhashtable_free_and_destroy+0x7c6/0x920 lib/rhashtable.c:1169
  ila_xlat_exit_net+0x55/0x110 net/ipv6/ila/ila_xlat.c:626
  ops_exit_list net/core/net_namespace.c:173 [inline]
  cleanup_net+0x802/0xcc0 net/core/net_namespace.c:640
  process_one_work kernel/workqueue.c:3231 [inline]
  process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
  worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
  kthread+0x2f0/0x390 kernel/kthread.c:389
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88806461ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88806461ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888064620000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                      ^
 ffff888064620080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888064620100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Fixes: 7f00feaf1076 ("ila: Add generic ILA translation facility")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Tom Herbert <tom@herbertland.com>
Cc: Florian Westphal <fw@strlen.de>
---
 net/ipv6/ila/ila.h      |  1 +
 net/ipv6/ila/ila_main.c |  6 ++++++
 net/ipv6/ila/ila_xlat.c | 13 +++++++++----
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/ila/ila.h b/net/ipv6/ila/ila.h
index ad5f6f6ba333027497b0c593521524ac6738b3ca..85b92917849bff2735c49007f24e017742cc53de 100644
--- a/net/ipv6/ila/ila.h
+++ b/net/ipv6/ila/ila.h
@@ -108,6 +108,7 @@ int ila_lwt_init(void);
 void ila_lwt_fini(void);
 
 int ila_xlat_init_net(struct net *net);
+void ila_xlat_pre_exit_net(struct net *net);
 void ila_xlat_exit_net(struct net *net);
 
 int ila_xlat_nl_cmd_add_mapping(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/ipv6/ila/ila_main.c b/net/ipv6/ila/ila_main.c
index 69caed07315f0c8bdb105de57b2baf758028f1aa..976c78efbae17021b709e138b42cd1a76db6828b 100644
--- a/net/ipv6/ila/ila_main.c
+++ b/net/ipv6/ila/ila_main.c
@@ -71,6 +71,11 @@ static __net_init int ila_init_net(struct net *net)
 	return err;
 }
 
+static __net_exit void ila_pre_exit_net(struct net *net)
+{
+	ila_xlat_pre_exit_net(net);
+}
+
 static __net_exit void ila_exit_net(struct net *net)
 {
 	ila_xlat_exit_net(net);
@@ -78,6 +83,7 @@ static __net_exit void ila_exit_net(struct net *net)
 
 static struct pernet_operations ila_net_ops = {
 	.init = ila_init_net,
+	.pre_exit = ila_pre_exit_net,
 	.exit = ila_exit_net,
 	.id   = &ila_net_id,
 	.size = sizeof(struct ila_net),
diff --git a/net/ipv6/ila/ila_xlat.c b/net/ipv6/ila/ila_xlat.c
index 67e8c9440977a40206f4e0544d28fa787922757d..534a4498e280d7603d95dd500f04158d5ad889a4 100644
--- a/net/ipv6/ila/ila_xlat.c
+++ b/net/ipv6/ila/ila_xlat.c
@@ -619,6 +619,15 @@ int ila_xlat_init_net(struct net *net)
 	return 0;
 }
 
+void ila_xlat_pre_exit_net(struct net *net)
+{
+	struct ila_net *ilan = net_generic(net, ila_net_id);
+
+	if (ilan->xlat.hooks_registered)
+		nf_unregister_net_hooks(net, ila_nf_hook_ops,
+					ARRAY_SIZE(ila_nf_hook_ops));
+}
+
 void ila_xlat_exit_net(struct net *net)
 {
 	struct ila_net *ilan = net_generic(net, ila_net_id);
@@ -626,10 +635,6 @@ void ila_xlat_exit_net(struct net *net)
 	rhashtable_free_and_destroy(&ilan->xlat.rhash_table, ila_free_cb, NULL);
 
 	free_bucket_spinlocks(ilan->xlat.locks);
-
-	if (ilan->xlat.hooks_registered)
-		nf_unregister_net_hooks(net, ila_nf_hook_ops,
-					ARRAY_SIZE(ila_nf_hook_ops));
 }
 
 static int ila_xlat_addr(struct sk_buff *skb, bool sir2ila)
-- 
2.46.0.469.g59c65b2a67-goog


