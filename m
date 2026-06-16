Return-Path: <netdev+bounces-299931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Nj6LBvuOMWqqmgUAu9opvQ
	(envelope-from <netdev+bounces-299931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 19:59:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EBB693AFF
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 19:59:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=JoZcshxJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299931-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299931-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 227FE3030962
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 17:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB6447A0C4;
	Tue, 16 Jun 2026 17:59:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45C44779AA
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 17:59:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632759; cv=none; b=fM/g+6+OKwF+YQUcamfbHYU5KdMIaQ8NhZupXkRZrQIKNLRIFxUxwMAOX4/NWIvkD9RTfujZKbu4RjioqCsFulfGNHj1oyKRQM6U8PYOGQ8soi/fbteeyMf03XpkrjahUovO2Xjmkoi2ilIGHbOxOGnFwn2SIQYU2iqiDm/KpbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632759; c=relaxed/simple;
	bh=KzRrTrWfTznNEaxI8Mr1+8eJYNUD6Mz+FnGlsYp1Oe8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e/By/Mc+4jICd8vnWy5021IZsZNd/yy2cv1FYgbocbs6qcrlBO4CstrDQA3ACKdu3/r9tpPFjkk9cxjAQmNQDnzSuz1m82eWplqRIO2/L4meFVRR7RLlc3U3Ov0Wpx7H7GB5lrz/qRP3L0d8ejfpOtiPNWBAF/0nIVIsTTWmuCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JoZcshxJ; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8425a9979e1so3187965b3a.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781632757; x=1782237557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEd/N8+5banGxYzaUdADIptEAjItyvoOqFJKAYY3Gsk=;
        b=JoZcshxJT0Vd5s7bSdRA7iL6aryGXzxSURsNBFkWRZ7tiOqu0/clNOb1zjabHKL3ki
         MGI2iwCse1nDzEKQ1IGMbapJ62FGvdNU/XKdNuyy5SPPnqgucYf4iuMnzKgFb0KJpHg/
         SkxZNxq18KYkbCWqg1Jwr+GrAk8njuO1rtTYCr1DhJgjBkQKpeasi/9/IzwE+v7EoKGN
         +Jrh3p6DeLG6qwHD8iu7MmGlKSACTeqOXWd1UYG/6loR7ChBcmrxXj3m2+6B2qlw0Sh1
         LE80mkQ8MzL+KLbyDYwoMrBeWi//KliZA1FDUfZf903J/Up9IHZpi41onjgfDksjj24k
         qQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781632757; x=1782237557;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wEd/N8+5banGxYzaUdADIptEAjItyvoOqFJKAYY3Gsk=;
        b=mL9Tv7vmQP9DIc+PSrp7DK+gDjfk85X3EipkUAcIAcL84Fmc0A1kKHbaE4Z46wpQ3U
         dUFom2Jl+x0tsO2PU1WcIEtvN2kPeaUlM6Yo/7KStt3ip8+aViUlYQtUWpEtX4v7IOdb
         IHKeSO6HSFqdljI4uyWKwpsZZ+ITW2OH7+mDyFCR7ZxdPcCxT943uhfmGD68BqpeL7xr
         CnGhUem7gZaWoEe9PfTbz3Nax/h77ddTE9DWa5PF3uC0FJYttsZmR27z6+Gs21rjnozq
         Ujkx2LSEcGgER4S/1t/P+V+QjeoDLi4GcpDpGq1dIpCfiz/fMZ+mw8BV3W0IVrnXxJJd
         U1Lw==
X-Forwarded-Encrypted: i=1; AFNElJ/kuqkMN4IEfsCPDuIM3LRHy2IUZBvPrT8Y4TtNMDaWtMP8gGTUujm8cjuhY1t+QYPwF7OEhEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcSPwnfSdDYqMrp4ONfQUwqbTmXX3DKJtyZQSL+8q3WWOBZD7G
	rNtm00NMlZLdL7Z1Rovgi7ObQ03aLrfKL5VL4BA5bwAbPBH3AhVFc7wf+n7vUT05VTsXqDOpPWF
	IM9H7vw==
X-Received: from pfbbm3.prod.google.com ([2002:a05:6a00:3203:b0:842:4fef:4fc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ace:b0:842:80c5:c420
 with SMTP id d2e1a72fcca58-845245a814bmr170013b3a.40.1781632756690; Tue, 16
 Jun 2026 10:59:16 -0700 (PDT)
Date: Tue, 16 Jun 2026 17:59:06 +0000
In-Reply-To: <CAAVpQUB8W6nXOq-OQfSArKC_xzFbQ=dg62Ee3R=0nuX0sW0fMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAAVpQUB8W6nXOq-OQfSArKC_xzFbQ=dg62Ee3R=0nuX0sW0fMg@mail.gmail.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616175916.3701082-1-kuniyu@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in fib_rules_lookup
From: Kuniyuki Iwashima <kuniyu@google.com>
To: kuniyu@google.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a0842261b62cdea8];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:idosch@nvidia.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com,m:syzkaller-bugs@googlegroups.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299931-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,syzkaller.appspot.com:url,appspotmail.com:email,storage.googleapis.com:url,goo.gl:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,googlegroups.com:email,nvidia.com:email];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[netdev,965506b59a2de0b6905c];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7EBB693AFF

From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 16 Jun 2026 10:06:55 -0700
> On Tue, Jun 16, 2026 at 8:55=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Tue, Jun 16, 2026 at 8:31=E2=80=AFAM Ido Schimmel <idosch@nvidia.com=
> wrote:
> > >
> > > On Tue, Jun 16, 2026 at 07:05:24AM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    72dfa4700f78 net: dsa: sja1105: fix lastused timest=
amp in ..
> > >
> > > This includes commit 759923cf03b0 ("ipv4: fib: Convert
> > > fib_net_exit_batch() to ->exit_rtnl().") that moved ip_fib_net_exit()
> > > (and therefore fib4_rules_exit()) earlier in the netns dismantle path=
.
> > >
> > > Kuniyuki, can you please take a look?
> > >
> > > You can use this to reproduce:
> > >
> > > #!/bin/bash
> > >
> > > while true; do
> > >         ip netns add ns1
> > >         ip -n ns1 link set dev lo up
> > >         ip -n ns1 address add 192.0.2.1/24 dev lo
> > >         ip -n ns1 link add name dummy1 up type dummy
> > >         ip -n ns1 address add 198.51.100.1/24 dev dummy1
> > >         ip -n ns1 rule add ipproto tcp sport 12345 table 12345
> > >         ip -n ns1 fou add port 5555 ipproto 47 local 192.0.2.1 peer 1=
98.51.100.2 peer_port 54321
> > >         ip netns del ns1
> > > done
> > >
> >
> > Oh right.
> >
> > While looking at this syzbot report I also found an old issue.
> >
> > https://lore.kernel.org/netdev/20260616141317.407791-1-edumazet@google.=
com/T/#u
> >
> > I guess adding some delays in enqueue_to_backlog() could trigger a
> > similar bug even if we revert Kuniyuki's patch.
>=20
> I'll look into it, thank you both !

I'll move fib4_rules_exit() to ->exit().

fib_unmerge() requires RTNL, but it is not needed in ->delete()
in the first place since it's already called in ->configure().

---8<---
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index c7d1f31650d7..42212970d735 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1612,10 +1612,6 @@ static void ip_fib_net_exit(struct net *net)
 			fib_free_table(tb);
 		}
 	}
-
-#ifdef CONFIG_IP_MULTIPLE_TABLES
-	fib4_rules_exit(net);
-#endif
 }
=20
 static int __net_init fib_net_init(struct net *net)
@@ -1652,6 +1648,9 @@ static int __net_init fib_net_init(struct net *net)
 	ip_fib_net_exit(net);
 	rtnl_net_unlock(net);
=20
+#ifdef CONFIG_IP_MULTIPLE_TABLES
+	fib4_rules_exit(net);
+#endif
 	kfree(net->ipv4.fib_table_hash);
 	fib4_notifier_exit(net);
 	goto out;
@@ -1671,6 +1670,9 @@ static void __net_exit fib_net_exit_rtnl(struct net *=
net,
=20
 static void __net_exit fib_net_exit(struct net *net)
 {
+#ifdef CONFIG_IP_MULTIPLE_TABLES
+	fib4_rules_exit(net);
+#endif
 	kfree(net->ipv4.fib_table_hash);
 	fib4_notifier_exit(net);
 	fib4_semantics_exit(net);
diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index 51f0193092f0..0bf6204468c5 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -352,12 +352,6 @@ static int fib4_rule_configure(struct fib_rule *rule, =
struct sk_buff *skb,
 static int fib4_rule_delete(struct fib_rule *rule)
 {
 	struct net *net =3D rule->fr_net;
-	int err;
-
-	/* split local/main if they are not already split */
-	err =3D fib_unmerge(net);
-	if (err)
-		goto errout;
=20
 #ifdef CONFIG_IP_ROUTE_CLASSID
 	if (((struct fib4_rule *)rule)->tclassid)
@@ -368,8 +362,8 @@ static int fib4_rule_delete(struct fib_rule *rule)
 	if (net->ipv4.fib_rules_require_fldissect &&
 	    fib_rule_requires_fldissect(rule))
 		net->ipv4.fib_rules_require_fldissect--;
-errout:
-	return err;
+
+	return 0;
 }
=20
 static int fib4_rule_compare(struct fib_rule *rule, struct fib_rule_hdr *f=
rh,
---8<---



>=20
> >
> >
> >
> >
> > > Thanks
> > >
> > > > git tree:       net-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15794bd=
2580000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da084226=
1b62cdea8
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D965506b59=
a2de0b6905c
> > > > compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aa=
d7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/d4e16f50a9=
7c/disk-72dfa470.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/6cd4a736e796/=
vmlinux-72dfa470.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/548b0011=
c8e8/bzImage-72dfa470.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com
> > > >
> > > > bond0 (unregistering): Released all slaves
> > > > bond1 (unregistering): Released all slaves
> > > > bond2 (unregistering): (slave dummy0): Releasing active interface
> > > > bond2 (unregistering): Released all slaves
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > BUG: KASAN: slab-use-after-free in fib_rules_lookup+0x15e/0xeb0 net=
/core/fib_rules.c:321
> > > > Read of size 8 at addr ffff88804ec4c680 by task kworker/u8:21/12641
> > > >
> > > > CPU: 0 UID: 0 PID: 12641 Comm: kworker/u8:21 Not tainted syzkaller =
#0 PREEMPT(full)
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 05/09/2026
> > > > Workqueue: netns cleanup_net
> > > > Call Trace:
> > > >  <TASK>
> > > >  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
> > > >  print_address_description+0x55/0x1e0 mm/kasan/report.c:378
> > > >  print_report+0x58/0x70 mm/kasan/report.c:482
> > > >  kasan_report+0x117/0x150 mm/kasan/report.c:595
> > > >  fib_rules_lookup+0x15e/0xeb0 net/core/fib_rules.c:321
> > > >  __fib_lookup+0x106/0x210 net/ipv4/fib_rules.c:96
> > > >  ip_route_output_key_hash_rcu+0x294/0x2720 net/ipv4/route.c:2811
> > > >  ip_route_output_key_hash+0x18d/0x2a0 net/ipv4/route.c:2702
> > > >  __ip_route_output_key include/net/route.h:169 [inline]
> > > >  ip_route_output_flow+0x2a/0x150 net/ipv4/route.c:2929
> > > >  ip4_datagram_release_cb+0x89d/0xbe0 net/ipv4/datagram.c:118
> > > >  release_sock+0x206/0x260 net/core/sock.c:3861
> > > >  inet_shutdown+0x2b1/0x390 net/ipv4/af_inet.c:950
> > > >  udp_tunnel_sock_release+0x6d/0x80 net/ipv4/udp_tunnel_core.c:197
> > > >  fou_release net/ipv4/fou_core.c:562 [inline]
> > > >  fou_exit_net+0x17d/0x1f0 net/ipv4/fou_core.c:1230
> > > >  ops_exit_list net/core/net_namespace.c:199 [inline]
> > > >  ops_undo_list+0x43d/0x8d0 net/core/net_namespace.c:252
> > > >  cleanup_net+0x572/0x810 net/core/net_namespace.c:702
> > > >  process_one_work kernel/workqueue.c:3314 [inline]
> > > >  process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3397
> > > >  worker_thread+0xa47/0xfb0 kernel/workqueue.c:3478
> > > >  kthread+0x389/0x470 kernel/kthread.c:436
> > > >  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
> > > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > >  </TASK>
> > > >
> > > > Allocated by task 19121:
> > > >  kasan_save_stack mm/kasan/common.c:57 [inline]
> > > >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
> > > >  poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
> > > >  __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
> > > >  kasan_kmalloc include/linux/kasan.h:263 [inline]
> > > >  __do_kmalloc_node mm/slub.c:5296 [inline]
> > > >  __kmalloc_node_track_caller_noprof+0x4d7/0x7b0 mm/slub.c:5408
> > > >  kmemdup_noprof+0x2b/0x70 mm/util.c:138
> > > >  kmemdup_noprof include/linux/fortify-string.h:763 [inline]
> > > >  fib_rules_register+0x2f/0x400 net/core/fib_rules.c:170
> > > >  fib4_rules_init+0x21/0x160 net/ipv4/fib_rules.c:508
> > > >  ip_fib_net_init net/ipv4/fib_frontend.c:1578 [inline]
> > > >  fib_net_init+0x17a/0x3e0 net/ipv4/fib_frontend.c:1628
> > > >  ops_init+0x35d/0x5d0 net/core/net_namespace.c:137
> > > >  setup_net+0x118/0x350 net/core/net_namespace.c:446
> > > >  copy_net_ns+0x4f9/0x720 net/core/net_namespace.c:579
> > > >  create_new_namespaces+0x3f0/0x6b0 kernel/nsproxy.c:132
> > > >  unshare_nsproxy_namespaces+0x149/0x190 kernel/nsproxy.c:234
> > > >  ksys_unshare+0x57d/0xa00 kernel/fork.c:3242
> > > >  __do_sys_unshare kernel/fork.c:3316 [inline]
> > > >  __se_sys_unshare kernel/fork.c:3314 [inline]
> > > >  __x64_sys_unshare+0x38/0x50 kernel/fork.c:3314
> > > >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> > > >  do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
> > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > >
> > > > Freed by task 12641:
> > > >  kasan_save_stack mm/kasan/common.c:57 [inline]
> > > >  kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
> > > >  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
> > > >  poison_slab_object mm/kasan/common.c:253 [inline]
> > > >  __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
> > > >  kasan_slab_free include/linux/kasan.h:235 [inline]
> > > >  slab_free_hook mm/slub.c:2689 [inline]
> > > >  __rcu_free_sheaf_prepare+0x12d/0x2a0 mm/slub.c:2940
> > > >  rcu_free_sheaf+0x31/0x200 mm/slub.c:5850
> > > >  rcu_do_batch kernel/rcu/tree.c:2617 [inline]
> > > >  rcu_core+0x78b/0x10a0 kernel/rcu/tree.c:2869
> > > >  handle_softirqs+0x225/0x840 kernel/softirq.c:622
> > > >  do_softirq+0x76/0xd0 kernel/softirq.c:523
> > > >  __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
> > > >  unregister_netdevice_many_notify+0x1874/0x2150 net/core/dev.c:1244=
5
> > > >  ops_exit_rtnl_list net/core/net_namespace.c:187 [inline]
> > > >  ops_undo_list+0x391/0x8d0 net/core/net_namespace.c:248
> > > >  cleanup_net+0x572/0x810 net/core/net_namespace.c:702
> > > >  process_one_work kernel/workqueue.c:3314 [inline]
> > > >  process_scheduled_works+0xa8e/0x14e0 kernel/workqueue.c:3397
> > > >  worker_thread+0xa47/0xfb0 kernel/workqueue.c:3478
> > > >  kthread+0x389/0x470 kernel/kthread.c:436
> > > >  ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
> > > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > >
> > > > The buggy address belongs to the object at ffff88804ec4c600
> > > >  which belongs to the cache kmalloc-192 of size 192
> > > > The buggy address is located 128 bytes inside of
> > > >  freed 192-byte region [ffff88804ec4c600, ffff88804ec4c6c0)
> > > >
> > > > The buggy address belongs to the physical page:
> > > > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:=
0x4ec4c
> > > > flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> > > > page_type: f5(slab)
> > > > raw: 00fff00000000000 ffff88813fe163c0 dead000000000100 dead0000000=
00122
> > > > raw: 0000000000000000 0000000800100010 00000000f5000000 00000000000=
00000
> > > > page dumped because: kasan: bad access detected
> > > > page_owner tracks the page as allocated
> > > > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x=
d2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), p=
id 13856, tgid 13853 (syz.3.2144), ts 351172300879, free_ts 351133053454
> > > >  set_page_owner include/linux/page_owner.h:32 [inline]
> > > >  post_alloc_hook+0x22d/0x280 mm/page_alloc.c:1853
> > > >  prep_new_page mm/page_alloc.c:1861 [inline]
> > > >  get_page_from_freelist+0x24ae/0x2530 mm/page_alloc.c:3941
> > > >  __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5221
> > > >  alloc_slab_page mm/slub.c:3278 [inline]
> > > >  allocate_slab+0x77/0x660 mm/slub.c:3467
> > > >  new_slab mm/slub.c:3525 [inline]
> > > >  refill_objects+0x336/0x3d0 mm/slub.c:7272
> > > >  refill_sheaf mm/slub.c:2816 [inline]
> > > >  __pcs_replace_empty_main+0x320/0x720 mm/slub.c:4652
> > > >  alloc_from_pcs mm/slub.c:4750 [inline]
> > > >  slab_alloc_node mm/slub.c:4884 [inline]
> > > >  __do_kmalloc_node mm/slub.c:5295 [inline]
> > > >  __kmalloc_noprof+0x464/0x750 mm/slub.c:5308
> > > >  kmalloc_noprof include/linux/slab.h:954 [inline]
> > > >  kzalloc_noprof include/linux/slab.h:1188 [inline]
> > > >  new_dir fs/proc/proc_sysctl.c:966 [inline]
> > > >  get_subdir fs/proc/proc_sysctl.c:1010 [inline]
> > > >  sysctl_mkdir_p fs/proc/proc_sysctl.c:1320 [inline]
> > > >  __register_sysctl_table+0xc02/0x1370 fs/proc/proc_sysctl.c:1395
> > > >  neigh_sysctl_register+0x9b1/0xa90 net/core/neighbour.c:3915
> > > >  addrconf_sysctl_register+0xb3/0x1c0 net/ipv6/addrconf.c:7396
> > > >  ipv6_add_dev+0xd26/0x13a0 net/ipv6/addrconf.c:460
> > > >  addrconf_notify+0x771/0x1050 net/ipv6/addrconf.c:3679
> > > >  notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
> > > >  call_netdevice_notifiers_extack net/core/dev.c:2288 [inline]
> > > >  call_netdevice_notifiers net/core/dev.c:2302 [inline]
> > > >  register_netdevice+0x18db/0x1f00 net/core/dev.c:11474
> > > >  macsec_newlink+0x706/0x1200 drivers/net/macsec.c:4218
> > > >  rtnl_newlink_create+0x310/0xb00 net/core/rtnetlink.c:3905
> > > > page last free pid 12657 tgid 12657 stack trace:
> > > >  reset_page_owner include/linux/page_owner.h:25 [inline]
> > > >  __free_pages_prepare mm/page_alloc.c:1397 [inline]
> > > >  __free_frozen_pages+0xc0d/0xd20 mm/page_alloc.c:2938
> > > >  __tlb_remove_table_free mm/mmu_gather.c:228 [inline]
> > > >  tlb_remove_table_rcu+0x85/0x100 mm/mmu_gather.c:291
> > > >  rcu_do_batch kernel/rcu/tree.c:2617 [inline]
> > > >  rcu_core+0x78b/0x10a0 kernel/rcu/tree.c:2869
> > > >  handle_softirqs+0x225/0x840 kernel/softirq.c:622
> > > >  __do_softirq kernel/softirq.c:656 [inline]
> > > >  invoke_softirq kernel/softirq.c:496 [inline]
> > > >  __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
> > > >  irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
> > > >  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061=
 [inline]
> > > >  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:=
1061
> > > >  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idt=
entry.h:697
> > > >
> > > > Memory state around the buggy address:
> > > >  ffff88804ec4c580: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > >  ffff88804ec4c600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > >ffff88804ec4c680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> > > >                    ^
> > > >  ffff88804ec4c700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > >  ffff88804ec4c780: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > >
> > > > ---
> > > > This report is generated by a bot. It may contain errors.
> > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > >
> > > > syzbot will keep track of this issue. See:
> > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > >
> > > > If the report is already addressed, let syzbot know by replying wit=
h:
> > > > #syz fix: exact-commit-title
> > > >
> > > > If you want to overwrite report's subsystems, reply with:
> > > > #syz set subsystems: new-subsystem
> > > > (See the list of subsystem names on the web dashboard)
> > > >
> > > > If the report is a duplicate of another one, reply with:
> > > > #syz dup: exact-subject-of-another-report
> > > >
> > > > If you want to undo deduplication, reply with:
> > > > #syz undup
>=20

