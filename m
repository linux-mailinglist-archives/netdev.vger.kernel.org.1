Return-Path: <netdev+bounces-306864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kngmFNZbUmrqOgMAu9opvQ
	(envelope-from <netdev+bounces-306864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:05:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74958741DCB
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:05:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=WK876bkU;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306864-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306864-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B789300FFBE
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD33280CE5;
	Sat, 11 Jul 2026 15:05:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B404C6D
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 15:05:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782353; cv=none; b=hdoBJAWNJni8cb0xvJPL1Jbav/BPlQfVLj2xwH1OVWXUaOsV2WE/UWxy4h9NDiPxoMxZId4+NBnvT2f+QpdGRLl3rKB0w4dQUBLiQjnngJ5wITRm+Ir/NjtJZDrA+qFuddUv3ctfZXFhjSG6glXv8B956ggLu1Mo8vMAXpSIt1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782353; c=relaxed/simple;
	bh=5ovWWGxhadO13kzswk8VuEOX38SLoVztVYwJh9hb83M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ebud9LYADDTnt1SXF/fDukR7QlxBn+58vVIr755leNNBxHbfHruRZcApNvWV0Pf5Lx1+va584ttWC6c/afWa7yAuEtRHmQxTBWjdx0hvm58ZYdzxmI7wbeQVVAx4io+GgrXNtip3HD4yWZllLu6asZ92PwcWR/HbDgrEo8dANlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=WK876bkU; arc=none smtp.client-ip=74.125.224.43
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-667923d86a7so3088862d50.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 08:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1783782351; x=1784387151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BeG0RbeeBWvbhTxaa/FtUKyUuykiziE2rzZwd7i2ZAI=;
        b=WK876bkU8lwXUbtKcYUcf7jgFoSOsCA1LypqJWHh5xBLHYES2ALsoWPKxNQU0KfJBk
         p2xnM7tg+WjtNrCrzrkewShBFm3dP+xMY94wcTlIFGustTrr5GVUTan4OCU6BzSQB1n3
         oDNYKwb/ekiPGzAKOV3J8EvvbkJzxjoHm+W3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782351; x=1784387151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BeG0RbeeBWvbhTxaa/FtUKyUuykiziE2rzZwd7i2ZAI=;
        b=YSSln3mqCOHACPATV5tIFWtf+fsrpLbfaAMwvhT3g7hsyLdxsnjvZRWO+zZuzFuzOe
         hC53vmVaq0puiuubX7arafa/iarwJ25EFrlUSaIN7cO1NQN09aplF4BP/b1/88B9x5aN
         xjb1dSMkwIAYDM/q71efO90peqQ/EM46ymGtT0KSAteBDZoolLNJcLyU9E5iF/jVRd7d
         t9Fn0FSI4P3alj0Mp94HlY71QQmIdC9U71Eyrtx+mIs8Kq5eTSPav4ucZjrhV57Zp3Fx
         S+dXDrX/DtAkvZxnau4S2cKjlKbaX6966AGmhGTigHrMDacmPlwUiy4aYSWxiT1o5dFi
         ZWlw==
X-Gm-Message-State: AOJu0Yw1aSZ/hVn2L/qcgSMikaA3rmyNx+O7EgWKF4G0qPJsjrDkrBJv
	l9zO6Qq941iypsq5yuFpRaojnJ/mzlruvIynK/T+/Zrv4G8PpshXoi529dh4s/2SZhH7dKIT3FE
	MJJI=
X-Gm-Gg: AfdE7ck4zQ8UR8pR7H433049x55YjKUxaYpyy52PMz93zIihZ1uYOeD2DMKHKYDSof3
	lJDP7GGbahnWRgIqM4UlDxtJs2+LMkaxjeK0xmZD4djOnaNDjWvJf3bNxbSDqxvbxMDDnV3HJEP
	CbDxWnnyP7oiFAq5EO/xQnkhfK5pORGv+H2MfkmMuAb9bd6pi/tNfnckwqwTg83XWhMx3zWb2It
	O5xS0d3xttJDBZPWQi2g33XytpTxqu74zxtsOhsu4q0FFhKHxIgc9Pa8njiUChE15NGmgI/GNYJ
	wFtDjlHhyTUD3kDf3YDy6XRezBCYwuFyRpOPHw6/NgNKEqZO7zOkrzjN+RzWDHjtvkyl4czRuRd
	m4gcHm7L9qq2agWzPu4tsU9sHTI1o5fDuHCTzGQGb8x9zPDGnrKq4G2WJVBWQYuYG1duZkgSUI8
	phvGcbGsUwLT7V7OzApd0nr3x/MfrN
X-Received: by 2002:a05:690e:134c:b0:667:e605:4829 with SMTP id 956f58d0204a3-667e6055994mr39906d50.12.1783782350955;
        Sat, 11 Jul 2026 08:05:50 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-667877a8fbasm9385494d50.8.2026.07.11.08.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:05:48 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dcaratti@redhat.com,
	zdi-disclosures@trendmicro.com,
	security@kernel.org,
	victor@mojatatu.com,
	jiri@resnulli.us,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH] net/sched: act_tunnel_key: Defer dst_release to RCU callback
Date: Sat, 11 Jul 2026 11:05:37 -0400
Message-Id: <20260711150537.7946-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306864-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dcaratti@redhat.com,m:zdi-disclosures@trendmicro.com,m:security@kernel.org,m:victor@mojatatu.com,m:jiri@resnulli.us,m:jhs@mojatatu.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mojatatu.com:from_mime,mojatatu.com:email,mojatatu.com:mid,mojatatu.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74958741DCB

Fix a race-condition use-after-free in tunnel_key_release_params().

The function releases the metadata_dst of the old params synchronously
via dst_release() while deferring the params struct free with
kfree_rcu(). A concurrent tunnel_key_act() reader on the datapath may
still hold the old params pointer (under rcu_read_lock_bh) and proceed
to call dst_clone(&params->tcft_enc_metadata->dst) after the writer's
dst_release has already pushed the dst's rcuref to RCUREF_DEAD.

zdi-disclosures@trendmicro.com produced a poc which i (and Victor) verified
that KASAN reports:

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:112
BUG: KASAN: slab-use-after-free in atomic_sub_return_release include/linux/atomic/atomic-instrumented.h:326
BUG: KASAN: slab-use-after-free in __rcuref_put include/linux/rcuref.h:109
BUG: KASAN: slab-use-after-free in rcuref_put include/linux/rcuref.h:173
BUG: KASAN: slab-use-after-free in dst_release+0x5b/0x370 net/core/dst.c:168
Write of size 4 at addr ffff88806158de40 by task poc/9388

CPU: 0 UID: 0 PID: 9388 Comm: poc Tainted: G        W           7.1.0-rc7 #7 PREEMPT(lazy)
Tainted: [W]=WARN
Hardware name: QEMU Ubuntu 25.10 PC v2 (i440FX + PIIX, + 10.1 machine, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378
 print_report+0x139/0x4ad mm/kasan/report.c:482
 kasan_report+0xe4/0x1d0 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:186
 kasan_check_range+0x125/0x200 mm/kasan/generic.c:200
 instrument_atomic_read_write include/linux/instrumented.h:112
 atomic_sub_return_release include/linux/atomic/atomic-instrumented.h:326
 __rcuref_put include/linux/rcuref.h:109
 rcuref_put include/linux/rcuref.h:173
 dst_release+0x5b/0x370 net/core/dst.c:168
 refdst_drop include/net/dst.h:272
 skb_dst_drop include/net/dst.h:284
 skb_release_head_state+0x293/0x400 net/core/skbuff.c:1163
 skb_release_all net/core/skbuff.c:1187
[..]
Allocated by task 9391:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398
 __kasan_kmalloc+0x9a/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263
 __do_kmalloc_node mm/slub.c:5296
 __kmalloc_noprof+0x2f1/0x830 mm/slub.c:5308
 kmalloc_noprof include/linux/slab.h:954
 kzalloc_noprof include/linux/slab.h:1188
 offload_action_alloc+0x2f/0x130 net/core/flow_offload.c:35
 tcf_action_offload_add_ex+0x1ba/0x880 net/sched/act_api.c:258
 tcf_action_offload_add net/sched/act_api.c:293
 tcf_action_init+0x66e/0xa20 net/sched/act_api.c:1547
 tcf_action_add+0xf6/0x5d0 net/sched/act_api.c:2101
[..]
Freed by task 9391:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253
 __kasan_slab_free+0x6b/0x90 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235
 slab_free_hook mm/slub.c:2689
 slab_free mm/slub.c:6251
 kfree+0x21f/0x6b0 mm/slub.c:6566
 tcf_action_offload_add_ex+0x4ad/0x880 net/sched/act_api.c:284
 tcf_action_offload_add net/sched/act_api.c:293
 tcf_action_init+0x66e/0xa20 net/sched/act_api.c:1547
 tcf_action_add+0xf6/0x5d0 net/sched/act_api.c:2101

The buggy address belongs to the object at ffff88806158de00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 64 bytes inside of
 freed 256-byte region [ffff88806158de00, ffff88806158df00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88806158d600 pfn:0x6158c
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4fff00000000240(workingset|head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000240 ffff88801c841b40 ffffea0001856290 ffffea0001856190
raw: ffff88806158d600 0000000800100009 00000000f5000000 0000000000000000
head: 04fff00000000240 ffff88801c841b40 ffffea0001856290 ffffea0001856190
head: ffff88806158d600 0000000800100009 00000000f5000000 0000000000000000
head: 04fff00000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 9391, tgid 9378 (poc), ts 123227323196, free_ts 0
 set_page_owner include/linux/page_owner.h:32
 post_alloc_hook+0xfe/0x140 mm/page_alloc.c:1853
 prep_new_page mm/page_alloc.c:1861
 get_page_from_freelist+0x110c/0x2fc0 mm/page_alloc.c:3941
 __alloc_frozen_pages_noprof+0x263/0x2bc0 mm/page_alloc.c:5221
 alloc_slab_page mm/slub.c:3278
 allocate_slab mm/slub.c:3467
 new_slab+0xa6/0x690 mm/slub.c:3525
 refill_objects+0x271/0x420 mm/slub.c:7272
 refill_sheaf mm/slub.c:2816
 __pcs_replace_empty_main+0x373/0x630 mm/slub.c:4652
 alloc_from_pcs mm/slub.c:4750
 slab_alloc_node mm/slub.c:4884
 __do_kmalloc_node mm/slub.c:5295
 __kmalloc_noprof+0x66d/0x830 mm/slub.c:5308
 kmalloc_noprof include/linux/slab.h:954
 metadata_dst_alloc+0x26/0x90 net/core/dst.c:298
 tun_rx_dst include/net/dst_metadata.h:144
 __ip_tun_set_dst include/net/dst_metadata.h:208
 tunnel_key_init+0xb01/0x1b90 net/sched/act_tunnel_key.c:451
 tcf_action_init_1+0x46b/0x6c0 net/sched/act_api.c:1428
 tcf_action_init+0x448/0xa20 net/sched/act_api.c:1503
 tcf_action_add+0xf6/0x5d0 net/sched/act_api.c:2101
[..]
==================================================================

Fix by moving dst_release() into a custom RCU callback that runs
after the grace period, matching the lifetime of the containing
params struct.  Readers in the datapath therefore always find a live
rcuref when calling dst_clone().

Fixes: 9174c3df1cd18 ("net/sched: act_tunnel_key: fix memory leak in case of action replace")
Reported-by: zdi-disclosures@trendmicro.com
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_tunnel_key.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index 876b30c5709e..b14807761d82 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -342,14 +342,20 @@ static const struct nla_policy tunnel_key_policy[TCA_TUNNEL_KEY_MAX + 1] = {
 	[TCA_TUNNEL_KEY_ENC_TTL]      = { .type = NLA_U8 },
 };
 
-static void tunnel_key_release_params(struct tcf_tunnel_key_params *p)
+static void tunnel_key_release_params_rcu(struct rcu_head *head)
 {
-	if (!p)
-		return;
+	struct tcf_tunnel_key_params *p = container_of(head, typeof(*p), rcu);
+
 	if (p->tcft_action == TCA_TUNNEL_KEY_ACT_SET)
 		dst_release(&p->tcft_enc_metadata->dst);
+	kfree(p);
+}
 
-	kfree_rcu(p, rcu);
+static void tunnel_key_release_params(struct tcf_tunnel_key_params *p)
+{
+	if (!p)
+		return;
+	call_rcu(&p->rcu, tunnel_key_release_params_rcu);
 }
 
 static int tunnel_key_init(struct net *net, struct nlattr *nla,
-- 
2.43.0

