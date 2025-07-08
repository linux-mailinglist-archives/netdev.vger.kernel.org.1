Return-Path: <netdev+bounces-205048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0A3AFCFC7
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F90F4817DA
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256E22E3B0C;
	Tue,  8 Jul 2025 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="ureWF5bO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D92E424A
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989963; cv=none; b=ohDaUFjrnmxh1VWDv7+Hn394N6kIiKfu6+gjuCN+FZMkvnahc9KvFwa+EaE8ItCLxVgZ5/QP5KrV2p6hmIC4SKWWVQr7t15KzDIWix4CJPhiCp/UtG11ifDFp8Av9fZjI4Fkn/DtR4WxcdPmytz7j/xKEutAgOacNuDffYMUiMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989963; c=relaxed/simple;
	bh=2i+Bc8+LcCjq5dIQcgYx3b5vmPB86Q58gD696EWrFpc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MOkKLktUnaGg/EGqgs+09LfcplpGRoxCJ7oVN9zLHY9FEYukoy+BQy7Qi5Cn2Gb0Yp4Dsrj9+ixa4y9+d7ZFew1w35AllWkSJsINFDN1tux2c8Mcuh+AkJCVocWOGxrC+vPXMXm8z9L3c7qp3JcUxullILNauUwOJlUMYLAKf3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=ureWF5bO; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1751989957; x=1752249157;
	bh=QBC9qWVjNofupdgSL+lj4Ag67EoTCx3ki6L0ivqWLp4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ureWF5bOc3Xveu6wql4ECRrGjmLyQXu3D4okZ6Yb/PE65NZy4/0HO+n8OcwJ3Q8iV
	 E2RdcD4hFMc7WKwsTpHCy2eotgHUmBXoIQdIz6m3W+O2nVGV3ApDfcrzRCqhnKnlRP
	 ux1ZLrbFib/13KsdeH4kr5tlvZ9IP26CUV9DvNYKe/Ou2Hus0ZEAlahwR0F2LmA5z/
	 pnYaqPPht7ZZcrhhOXRbtI7ywn4LBXCWq5mjdO++kgQrYgOGeXmIaUaLqvjkrPIZlf
	 gk+7qf5ICJH4IFO2HNIVpDfMB1XY2OEwkNzDjJ7lgl6aM4xdf1HE789Qenj85XZ6nW
	 Z0qDVarXoB9lQ==
Date: Tue, 08 Jul 2025 15:52:31 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: William Liu <will@willsroot.io>
Cc: Savy <savy@syst3mfailure.io>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>
Subject: [BUG] BUG_ON in htb_lookup_leaf
Message-ID: <pF5XOOIim0IuEfhI-SOxTgRvNoDwuux7UHKnE_Y5-zVd4wmGvNk2ceHjKb8ORnzw0cGwfmVu42g9dL7XyJLf1NEzaztboTWcm0Ogxuojoeo=@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 7c16bba0a9f67977fa52f013dbe83f60c9122eec
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

We write to report a way to trigger the BUG_ON condition in htb_lookup_leaf=
 in the dequeue path of the htb qdisc. Using the following reproducer (note=
 that tc is patched to allow sfb to have a 0 value for the max option):

./tc qdisc del dev lo root
./tc qdisc add dev lo root handle 1: htb default 1
./tc class add dev lo parent 1: classid 1:1 htb rate 64bit=20
./tc qdisc add dev lo parent 1:1 handle 2: netem
./tc qdisc add dev lo parent 2:1 handle 3: sfb
ping -I lo -f -c1 -s64 -W0.001 127.0.0.1 2>&1 >/dev/null &

We hit the following kernel panic:
[   84.138902] tc (239) used greatest stack depth: 24520 bytes left
[  157.701864] htb: netem qdisc 2: is non-work-conserving?
[  157.704354] ------------[ cut here ]------------
[  157.706230] kernel BUG at net/sched/sch_htb.c:824!
[  157.708206] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
[  157.710410] CPU: 1 UID: 0 PID: 251 Comm: ping Not tainted 6.16.0-rc4-g1f=
988d0788f5 #145 PREEMPT(voluntary)=20
[  157.714168] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), B=
IOS 1.16.3-debian-1.16.3-2 04/01/2014
[  157.717191] RIP: 0010:htb_lookup_leaf+0x560/0x690
[  157.718445] Code: 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 4c 8b 6c 24 40 e8 =
b4 4b 59 fd 0f 0b 45 31 ff eb 9e 45 31 c0 e9 85 fe ff ff e8 a0 4b 59 fd <0f=
> 0b 4c 8b 6c 24 40 e8 94 4b 59 fd 0f 0b eb de 48 89 ef e8 2f
[  157.723203] RSP: 0018:ffff888103e6f148 EFLAGS: 00010293
[  157.724567] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[  157.726406] RDX: ffff888102ea0000 RSI: ffffffff842e9610 RDI: ffff888103e=
6f270
[  157.728248] RBP: 0000000000000000 R08: 0000000000000005 R09: 00000000000=
00000
[  157.730091] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8881037=
82458
[  157.731927] R13: 1ffff110207cde32 R14: 0000000000000000 R15: ffff8881037=
820e8
[  157.733759] FS:  00007f9c0603f000(0000) GS:ffff88819241c000(0000) knlGS:=
0000000000000000
[  157.735846] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  157.737335] CR2: 00007f9c06279000 CR3: 000000010fb02000 CR4: 00000000000=
006f0
[  157.739173] Call Trace:
[  157.739834]  <TASK>
[  157.740406]  ? vprintk_emit+0x237/0x730
[  157.741433]  ? __pfx_vprintk_emit+0x10/0x10
[  157.742531]  ? lock_release+0xc4/0x290
[  157.743525]  ? __pfx_htb_lookup_leaf+0x10/0x10
[  157.744712]  htb_dequeue+0x1b16/0x22a0
[  157.745717]  ? __pfx_htb_dequeue+0x10/0x10
[  157.746813]  __qdisc_run+0x1bc/0x1a90
[  157.747786]  ? __pfx_htb_enqueue+0x10/0x10
[  157.748872]  __dev_queue_xmit+0x278f/0x4120
[  157.749981]  ? check_path.constprop.0+0x24/0x50
[  157.751173]  ? __pfx___dev_queue_xmit+0x10/0x10
[  157.752372]  ? __lock_acquire+0x16c2/0x2b10
[  157.753473]  ? lock_acquire+0x14c/0x2e0
[  157.754489]  ? find_held_lock+0x2b/0x80
[  157.755508]  ? mark_held_locks+0x40/0x70
[  157.756546]  ip_finish_output2+0x1275/0x1ee0
[  157.757676]  ? __pfx_ip_finish_output2+0x10/0x10
[  157.758906]  ? __pfx_ip_dst_mtu_maybe_forward+0x10/0x10
[  157.760263]  ? ip_output+0x61f/0xe20
[  157.761211]  ? find_held_lock+0x2b/0x80
[  157.762229]  __ip_finish_output.part.0+0x348/0x7e0
[  157.763479]  ip_output+0x298/0xe20
[  157.764386]  ? __pfx_ip_output+0x10/0x10
[  157.765424]  ? __pfx_ip_finish_output+0x10/0x10
[  157.766619]  ? __pfx_ip_output+0x10/0x10
[  157.767652]  ip_push_pending_frames+0x2f8/0x5a0
[  157.768849]  raw_sendmsg+0x12a6/0x3350
[  157.769855]  ? __pfx_raw_sendmsg+0x10/0x10
[  157.770933]  ? mark_held_locks+0x40/0x70
[  157.771959]  ? find_held_lock+0x2b/0x80
[  157.772973]  ? filemap_map_pages+0xd2c/0x13b0
[  157.774117]  ? lock_release+0xc4/0x290
[  157.775109]  ? sock_has_perm+0x2b3/0x360
[  157.776146]  ? find_held_lock+0x2b/0x80
[  157.777163]  ? __might_fault+0xe4/0x190
[  157.778177]  ? __might_fault+0x155/0x190
[  157.779212]  ? __check_object_size+0xa7/0x8a0
[  157.780364]  ? __pfx_raw_sendmsg+0x10/0x10
[  157.781444]  inet_sendmsg+0x11d/0x140
[  157.782417]  __sys_sendto+0x43d/0x520
[  157.783390]  ? __pfx___sys_sendto+0x10/0x10
[  157.784542]  ? count_memcg_events_mm.constprop.0+0xfa/0x300
[  157.786003]  ? lock_release+0xc4/0x290
[  157.787012]  __x64_sys_sendto+0xe1/0x1c0
[  157.788069]  ? trace_irq_enable.constprop.0+0xc2/0x110
[  157.789429]  do_syscall_64+0x64/0x2d0
[  157.790412]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  157.791745] RIP: 0033:0x7f9c062bf046
[  157.792698] Code: 0e 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f =
1f 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 2c 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 72 c3 90 55 48 83 ec 30 44 89 4c 24 2c 49
[  157.797469] RSP: 002b:00007ffcfb72c948 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002c
[  157.799431] RAX: ffffffffffffffda RBX: 00007ffcfb72e0d0 RCX: 00007f9c062=
bf046
[  157.801281] RDX: 0000000000000048 RSI: 000055eb00449950 RDI: 00000000000=
00003
[  157.803134] RBP: 000055eb00449950 R08: 00007ffcfb73034c R09: 00000000000=
00010
[  157.804987] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00048
[  157.806838] R13: 00007ffcfb72e090 R14: 00007ffcfb72c950 R15: 0000001d000=
00001
[  157.808696]  </TASK>
[  157.809300] Modules linked in:
[  157.810181] ---[ end trace 0000000000000000 ]---
[  157.811504] RIP: 0010:htb_lookup_leaf+0x560/0x690
[  157.813126] Code: 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 4c 8b 6c 24 40 e8 =
b4 4b 59 fd 0f 0b 45 31 ff eb 9e 45 31 c0 e9 85 fe ff ff e8 a0 4b 59 fd <0f=
> 0b 4c 8b 6c 24 40 e8 94 4b 59 fd 0f 0b eb de 48 89 ef e8 2f
[  157.818692] RSP: 0018:ffff888103e6f148 EFLAGS: 00010293
[  157.820315] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[  157.822461] RDX: ffff888102ea0000 RSI: ffffffff842e9610 RDI: ffff888103e=
6f270
[  157.824639] RBP: 0000000000000000 R08: 0000000000000005 R09: 00000000000=
00000
[  157.826829] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8881037=
82458
[  157.828915] R13: 1ffff110207cde32 R14: 0000000000000000 R15: ffff8881037=
820e8
[  157.831098] FS:  00007f9c0603f000(0000) GS:ffff88819241c000(0000) knlGS:=
0000000000000000
[  157.833561] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  157.835331] CR2: 00007f9c06279000 CR3: 000000010fb02000 CR4: 00000000000=
006f0
[  157.837536] Kernel panic - not syncing: Fatal exception in interrupt
[  157.840023] Kernel Offset: disabled
[  157.840956] ---[ end Kernel panic - not syncing: Fatal exception in inte=
rrupt ]---


The following is the ftrace function_graph, with the BUG_ON substituted for=
 a call to a placeholder function "htb_marker":

# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
 0)               |  htb_enqueue() {
 0) + 13.635 us   |    netem_enqueue();
 0)   4.719 us    |    htb_activate_prios();
 0) # 2249.199 us |  }
 0)               |  htb_dequeue() {
 0)   2.355 us    |    htb_lookup_leaf();
 0)               |    netem_dequeue() {
 0) + 11.061 us   |      sfb_enqueue();
 0)               |      qdisc_tree_reduce_backlog() {
 0)               |        qdisc_lookup_rcu() {
 0)   1.873 us    |          qdisc_match_from_root();
 0)   6.292 us    |        }
 0)   1.894 us    |        htb_search();
 0)               |        htb_qlen_notify() {
 0)   2.655 us    |          htb_deactivate_prios();
 0)   6.933 us    |        }
 0) + 25.227 us   |      }
 0)   1.983 us    |      sfb_dequeue();
 0) + 86.553 us   |    }
 0) # 2932.761 us |    qdisc_warn_nonwc();
 0)               |    htb_lookup_leaf() {
 0) # 1268.829 us |      htb_marker();
 0) # 1275.412 us |    }
 0) # 6453.144 us |  }
 ------------------------------------------

The root cause is the following:

1. htb_dequeue calls htb_dequeue_tree which calls the dequeue handler on th=
e selected leaf qdisc: https://elixir.bootlin.com/linux/v6.16-rc4/source/ne=
t/sched/sch_htb.c#L909
2. netem_deqeueue calls enqueue on the child qdisc (in this case sfb)
3. Since sfb's max value is 0, it drops the packet and returns a failure va=
lue: https://elixir.bootlin.com/linux/v6.16-rc4/source/net/sched/sch_sfb.c#=
L349
4. Because of this, netem_dequeue calls qdisc_tree_reduce_backlog, and sinc=
e qlen is now 0, it calls htb_qlen_notify -> htb_deactivate -> htb_deactivi=
ate_prios -> htb_remove_class_from_row -> htb_safe_rb_erase
5. As this is the only class in the selected hprio rbtree, __rb_change_chil=
d in __rb_erase_augmented sets the rb_root pointer to null (https://elixir.=
bootlin.com/linux/v6.16-rc4/source/include/linux/rbtree_augmented.h#L242)
6. Because sfb dropped the packet, the original dequeue handler from step 1=
 returns null, which causes htb_dequeue_tree to call htb_lookup_leaf with t=
he same hprio rbtree, and fail the BUG_ON

A potential fix I see is to just replace the BUG_ON with returning NULL. I =
can make a patch if this solution seems satisfactory. Please feel free to l=
et me know of any questions or issues.

On another side note, when triaging this issue, I encountered another WARNI=
NG that can be hit if an htb child is configured with a cake with 1b as the=
 memlimit here: https://elixir.bootlin.com/linux/v6.16-rc4/source/net/sched=
/sch_htb.c#L595. I don't think the `!cl->leaf.q->q.qlen` condition is neede=
d here, as htb_dequeue_tree gracefully handles that case anyways.=20

Best,
Will
Savy

