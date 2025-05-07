Return-Path: <netdev+bounces-188684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA908AAE332
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 16:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7959461C4B
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0980280A57;
	Wed,  7 May 2025 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="H9We1YYi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1642820A6
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628455; cv=none; b=pzYNFScIgTzFE1ZSBHNfcQyStpyXxvN2S33c1yaJgjzK9vmDgwcNXU5B3UlStdjHzZB8XP7k6Bsy7InQdbK7INTXwIrCno3zhZc7ycP0Gavq1lJZXDBvPTs+M+wje49CsG4hOGjoW93tPB7p9yQP697t75DNIAC7DTduuDtB/yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628455; c=relaxed/simple;
	bh=UhbC5hchFXdc+ZI6cDoRYjtqWd6QUeNLpt7k1Bmevo4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qz48RYvEaBwgK3YXVeW3CxHkHT+J/izgg/rEUg+IXhvCUAtErChRzFt0JNbHpa++OyAuhQYa/muQrZ+zeCo/ruL2xeUSga9NvPTDWEFnoV1g0LqeDkAN6c5ds4PHigJpWhzzIG0/RIJtEvbWWEb1rFzy/d13bebks9ZqLJZCE6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=H9We1YYi; arc=none smtp.client-ip=79.135.106.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1746628447; x=1746887647;
	bh=8s/OMk2iWLQtEEmkhc3F3dBuPDTjP1KSKEE+R6giHhs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=H9We1YYiF+nKlR0/gkMKbERn+pxcULGDk2ky90ulz/d+vsEpmAT7PuqnopcBrP4c8
	 wbvrUMuUKJDvrYTBfIeALn8AOeLaIxmhOKCi9prxwkgeV2uiteySNrTglyTIkOuzD6
	 VjEvzNxW73aVsE6sBEX0F36g4RTkJ4UryJbBIurL0E9JDrf9/ALUYh2z9dHOD14Te5
	 vm9iYnv6v9PUcjR9qOSjFkrN/dozynxzI5mr68lmWGAJx6L0IeIps4d6Xq5Qx4f5aw
	 rUa04bYdv3/vqt1qutaKaBfboT55sS/jdOvEUJ2vZ97D6vqaIaYo8PsJvOWUOMg5Ut
	 mbvUYAEuPZ+Vw==
Date: Wed, 07 May 2025 14:34:03 +0000
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: William Liu <will@willsroot.io>
Cc: Savy <savy@syst3mfailure.io>
Subject: Re: [BUG] net/sched: Soft Lockup/Task Hang and OOM Loop in netem_dequeue
Message-ID: <ozCLTfvSrpDG8cTUEFFXkgVy0HAHYPswyFXCXCa3pXZDM2uD7IiyaMVpz_RcAKAzbt73Q3FBCLP6Ij6ruY79E796PyN1lrEGd7Y5tnBIUx4=@willsroot.io>
In-Reply-To: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io>
References: <8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: c809410728ec932e2bd8f746c124d0d032da6bc0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, May 6th, 2025 at 4:08 PM, William Liu <will@willsroot.io> wrote=
:

>=20
>=20
> Hi all,
>=20
> We've encountered and triaged the following bug in sch_netem.c. It came u=
p on a modified version of Syzkaller we're working on for a research projec=
t. It works on upstream (02ddfb981de88a2c15621115dd7be2431252c568), the 6.6=
 LTS branch, and the 6.1 LTS branch. This commit (https://git.kernel.org/pu=
b/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3Df8d4bc455047cf3903cd=
6f85f49978987dbb3027) enabled the erroneous behavior, despite making the ql=
en behavior according to those of a classful qdisc. The root cause though, =
has existed since 2005 with the strange duplication handling behavior from =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D0afb51e72855971dba83b3c6b70c547c2d1161fd.
>=20
> Here is the setup for a PoC. All VMs are booted with the following parame=
ters:
>=20
> qemu-system-x86_64 \
> -m 4G \
> -smp 2 \
> -kernel $KERNEL/arch/x86/boot/bzImage \
> -append "console=3DttyS0 root=3D/dev/sda earlyprintk=3Dserial net.ifnames=
=3D0" \
> -drive file=3D$IMAGE/bullseye.img,format=3Draw \
> -snapshot \
> -net user,host=3D10.0.2.10,hostfwd=3Dtcp:127.0.0.1:10021-:22 \
> -net nic,model=3De1000 \
> -enable-kvm \
> -nographic
>=20
> Now, run:
>=20
> tc qdisc add dev lo root handle 1: netem limit 1 duplicate 100%
> tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 duplicate 100=
% delay 1us reorder 100%
> ping -I lo -f -c1 -s48 -W0.001 127.0.0.1
>=20
> We can achieve the following soft lockup:
>=20
> [ 48.636305] watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [ping:224]
> [ 48.636322] Modules linked in:
> [ 48.636328] irq event stamp: 85238283
> [ 48.636332] hardirqs last enabled at (85238282): [<ffffffff8140f3a7>] kt=
ime_get+0x187/0x210
>=20
> [ 48.636369] hardirqs last disabled at (85238283): [<ffffffff82c5475e>] s=
ysvec_apic_timer_interrupt+0xe/0x80
>=20
> [ 48.636386] softirqs last enabled at (5206): [<ffffffff825cc028>] neigh_=
resolve_output+0x2b8/0x340
>=20
> [ 48.636405] softirqs last disabled at (5210): [<ffffffff825ad1aa>] __dev=
_queue_xmit+0x8a/0x2110
>=20
> [ 48.636430] CPU: 1 UID: 0 PID: 224 Comm: ping Not tainted 6.15.0-rc3-000=
94-g02ddfb981de8-dirty #18 PREEMPT(voluntary)
> [ 48.636447] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), B=
IOS 1.16.3-debian-1.16.3-2 04/01/2014
> [ 48.636454] RIP: 0010:netem_enqueue+0x6/0x15f0
> [ 48.636470] Code: 89 d8 5b 5d 41 5c c3 cc cc cc cc bb ea ff ff ff eb c8 =
66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 57 <41=
> 56 41 55 49 89 d5 41 54 49 89 fc 55 53 48 89 f3 48 83 ec 5
>=20
> [ 48.636482] RSP: 0018:ffffc90000f5f8f0 EFLAGS: 00000293
> [ 48.636491] RAX: ffffffff8268e400 RBX: ffff888108b38800 RCX: ffffffff826=
8c996
> [ 48.636500] RDX: ffffc90000f5f900 RSI: ffff888108b39000 RDI: ffff888092b=
de400
> [ 48.636508] RBP: ffff888092bde400 R08: 0000000000000007 R09: 00000000000=
00000
> [ 48.636516] R10: 0000000000000000 R11: 0000000000000001 R12: ffff888108b=
38ac0
> [ 48.636523] R13: 000000000000005a R14: ffff888108b39000 R15: 00000000000=
00000
> [ 48.636536] FS: 00007f4774777000(0000) GS:ffff8881b755a000(0000) knlGS:0=
000000000000000
> [ 48.636546] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 48.636554] CR2: 0000563899d4b794 CR3: 0000000102242000 CR4: 00000000000=
006f0
> [ 48.636563] Call Trace:
> [ 48.636567] <TASK>
>=20
> [ 48.636573] netem_dequeue+0x2c5/0x480
> [ 48.636590] __qdisc_run+0xdb/0x9e0
> [ 48.636613] __dev_queue_xmit+0xec2/0x2110
> [ 48.636638] ? lock_acquire+0xbb/0x2d0
> [ 48.636657] ? ip_finish_output2+0x2cc/0xd40
> [ 48.636671] ? find_held_lock+0x2b/0x80
> [ 48.636683] ? skb_push+0x39/0x70
> [ 48.636701] ? eth_header+0xe3/0x140
> [ 48.636716] neigh_resolve_output+0x211/0x340
> [ 48.636734] ip_finish_output2+0x2cc/0xd40
> [ 48.636752] __ip_finish_output.part.0+0xda/0x1c0
> [ 48.636770] ip_output+0x17b/0x6f0
> [ 48.636785] ? __pfx_ip_finish_output+0x10/0x10
> [ 48.636799] ? __pfx_ip_output+0x10/0x10
> [ 48.636816] ip_push_pending_frames+0x1ed/0x310
> [ 48.636836] raw_sendmsg+0xbfa/0x1cb0
> [ 48.636862] ? lock_acquire+0xbb/0x2d0
> [ 48.636892] ? __might_fault+0x6f/0xb0
> [ 48.636914] ? __pfx_raw_sendmsg+0x10/0x10
> [ 48.636932] inet_sendmsg+0xc0/0xd0
> [ 48.636949] __sys_sendto+0x29a/0x2e0
> [ 48.636987] __x64_sys_sendto+0x28/0x30
> [ 48.636998] do_syscall_64+0xbb/0x1d0
> [ 48.637015] entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [ 48.637029] RIP: 0033:0x7f47749f7046
> [ 48.637040] Code: 0e 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f =
1f 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 2c 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 72 c3 90 55 48 83 ec 30 44 89 4c 24 2c 9
>=20
> [ 48.637052] RSP: 002b:00007ffe5bd1ed28 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002c
> [ 48.637062] RAX: ffffffffffffffda RBX: 00007ffe5bd204b0 RCX: 00007f47749=
f7046
> [ 48.637070] RDX: 0000000000000038 RSI: 00005638a58d0950 RDI: 00000000000=
00003
> [ 48.637078] RBP: 00005638a58d0950 R08: 00007ffe5bd2272c R09: 00000000000=
00010
> [ 48.637085] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00038
> [ 48.637091] R13: 00007ffe5bd20470 R14: 00007ffe5bd1ed30 R15: 0000001d000=
00001
> [ 48.637107] </TASK>
>=20
> [ 54.939688] ping: page allocation failure: order:0, mode:0x40820(GFP_ATO=
MIC|__GFP_COMP), nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
> [ 54.943358] CPU: 1 UID: 0 PID: 224 Comm: ping Tainted: G L 6.15.0-rc3-00=
094-g02ddfb981de8-dirty #18 PREEMPT(voluntary)
> [ 54.943377] Tainted: [L]=3DSOFTLOCKUP
> [ 54.943381] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), B=
IOS 1.16.3-debian-1.16.3-2 04/01/2014
> [ 54.943390] Call Trace:
> [ 54.943395] <TASK>
>=20
> [ 54.943401] dump_stack_lvl+0xf4/0x120
> [ 54.943422] warn_alloc+0x15d/0x1e0
> [ 54.943449] __alloc_frozen_pages_noprof+0x7ca/0x10f0
> [ 54.943488] ? __sanitizer_cov_trace_switch+0x54/0x90
> [ 54.943509] alloc_pages_mpol+0x6b/0x190
> [ 54.943527] new_slab+0x2b3/0x360
> [ 54.943545] ___slab_alloc+0x941/0xfd0
> [ 54.943561] ? find_held_lock+0x2b/0x80
> [ 54.943575] ? skb_clone+0xae/0x2b0
> [ 54.943595] ? ___slab_alloc+0x442/0xfd0
> [ 54.943613] ? skb_clone+0xae/0x2b0
> [ 54.943626] ? kmem_cache_alloc_noprof+0x1bd/0x3e0
> [ 54.943644] kmem_cache_alloc_noprof+0x1bd/0x3e0
> [ 54.943666] skb_clone+0xae/0x2b0
> [ 54.943681] netem_enqueue+0xc1a/0x15f0
> [ 54.943701] netem_enqueue+0x19a/0x15f0
> [ 54.943717] ? kvm_clock_get_cycles+0x40/0x70
> [ 54.943734] netem_dequeue+0x2c5/0x480
> [ 54.943751] __qdisc_run+0xdb/0x9e0
> [ 54.943773] __dev_queue_xmit+0xec2/0x2110
> [ 54.943797] ? lock_acquire+0xbb/0x2d0
> [ 54.943816] ? ip_finish_output2+0x2cc/0xd40
> [ 54.943830] ? find_held_lock+0x2b/0x80
> [ 54.943844] ? skb_push+0x39/0x70
> [ 54.943862] ? eth_header+0xe3/0x140
> [ 54.943878] neigh_resolve_output+0x211/0x340
> [ 54.943897] ip_finish_output2+0x2cc/0xd40
> [ 54.943915] __ip_finish_output.part.0+0xda/0x1c0
> [ 54.943933] ip_output+0x17b/0x6f0
> [ 54.943949] ? __pfx_ip_finish_output+0x10/0x10
> [ 54.943963] ? __pfx_ip_output+0x10/0x10
> [ 54.943978] ip_push_pending_frames+0x1ed/0x310
> [ 54.943996] raw_sendmsg+0xbfa/0x1cb0
> [ 54.944021] ? lock_acquire+0xbb/0x2d0
> [ 54.944039] ? __might_fault+0x6f/0xb0
> [ 54.944060] ? __pfx_raw_sendmsg+0x10/0x10
> [ 54.944078] inet_sendmsg+0xc0/0xd0
> [ 54.944094] __sys_sendto+0x29a/0x2e0
> [ 54.944133] __x64_sys_sendto+0x28/0x30
> [ 54.944144] do_syscall_64+0xbb/0x1d0
> [ 54.944161] entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [ 54.944176] RIP: 0033:0x7f47749f7046
> [ 54.944195] Code: Unable to access opcode bytes at 0x7f47749f701c.
> [ 54.944200] RSP: 002b:00007ffe5bd1ed28 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002c
> [ 54.944213] RAX: ffffffffffffffda RBX: 00007ffe5bd204b0 RCX: 00007f47749=
f7046
> [ 54.944221] RDX: 0000000000000038 RSI: 00005638a58d0950 RDI: 00000000000=
00003
> [ 54.944229] RBP: 00005638a58d0950 R08: 00007ffe5bd2272c R09: 00000000000=
00010
> [ 54.944238] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00038
> [ 54.944245] R13: 00007ffe5bd20470 R14: 00007ffe5bd1ed30 R15: 0000001d000=
00001
>=20
> Afterwards, the OOM killer runs in a loop. This can be triggered from any=
 user with CAP_NET, so unprivileged users can access this through namespace=
s.
>=20
> The root cause for this is complex. Because of the way we setup the paren=
t qdisc, all enqueued packets to the parent will end up in the netem tfifo =
queue, as the gap is 0: https://elixir.bootlin.com/linux/v6.15-rc4/source/n=
et/sched/sch_netem.c#L552. The child qdisc will have all enqueued packets e=
nd up in sch->q instead because gap is 1 (which means that reorder is 100%,=
 so the previous conditional will never pass).
>=20
>=20
> Note that both qdiscs have duplication set to 100%. If duplication is pos=
sible, a clone of the packet will re-enqueue again at the root qdisc: https=
://elixir.bootlin.com/linux/v6.15-rc4/source/net/sched/sch_netem.c#L539. Th=
e placement of this duplication is problematic though for a root netem qdis=
c with limit of 1. If t_len is 0, then we would end up with a t_len of 2 si=
nce the sch->limit check happens before the current packet is added to the =
tfifo queue and the duplicated packet is re-enqueued: https://elixir.bootli=
n.com/linux/v6.15-rc4/source/net/sched/sch_netem.c#L525.
>=20
>=20
> Once the parent's netem_dequeue starts, there is never anything from sch-=
>q, so it will always pull from the tfifo: https://elixir.bootlin.com/linux=
/v6.15-rc4/source/net/sched/sch_netem.c#L714. It then enqueues the skb to t=
he child qdisc (https://elixir.bootlin.com/linux/v6.15-rc4/source/net/sched=
/sch_netem.c#L747), but since the duplicate flag is set in the child netem =
qdisc too, it duplicates the packet back to the parent netem qdisc.
>=20
>=20
> In netem_dequeue, the parent netem qdisc's t_len is decremented before th=
e child enqueue call: https://elixir.bootlin.com/linux/v6.15-rc4/source/net=
/sched/sch_netem.c#L726. On the first child enqueue, the parent qdisc t_len=
 is 1, so the skb will not be re-enqueued in the parent qdisc, and only get=
 added to the child sch->q. However, when the parent's netem_dequeue return=
s back to dequeuing from the tfifo queue (https://elixir.bootlin.com/linux/=
v6.15-rc4/source/net/sched/sch_netem.c#L756), t_len becomes 0. With the pro=
blematic duplication logic, the parent enqueues the same packet twice again=
, has a t_len of 2, and the packet is added to the child sch->q. This tfifo=
_dequeue loop will never end, and cause infinite memory allocations.
>=20
>=20
> We are unsure what the best approach to fix this bug is. Originally, we c=
onsidered factoring in a qlen to the limit check, but https://git.kernel.or=
g/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3Df8d4bc455047cf39=
03cd6f85f49978987dbb3027 shows this idea is an incorrect approach. Perhaps =
moving the duplication call after the internal enqueue in netem_enqueue can=
 fix the limit issue. However, none of this address the strange duplication=
 logic that attempts to prevent the duplication of duplicated packets. Note=
 that before re-enqueing a cloned packet, it disables duplication in the cu=
rrent qdisc and then re-enables the original duplication setting afterwards=
. This only works if the duplicator is the root qdisc. If the duplicator is=
 not the root qdisc, then a packet will forever be duplicated. We considere=
d tracking packet duplication state in skb->cb, but this wouldn't hold up e=
ither as there are no guarantees to what the previous qdisc is.
>=20
>=20
> Feel free to let us know your thoughts and any other help we can provide.
>=20
> Best,
> Will(will@willsroot.io)
> Savy (savy@syst3mfailure.io)

Just as a follow up, the duplication logic also causes a soft lockup/hang w=
ith the HFSC qdisc using rtsc as the parent, reproducible on the same versi=
ons listed in the previous email.

In hfsc_enqueue, the boolean first is set here https://elixir.bootlin.com/l=
inux/v6.15-rc5/source/net/sched/sch_hfsc.c#L1562. Then the enqueue handler =
from the selected class's qdisc is called. If this qdisc is netem with dupl=
ication enabled, then it will call hfsc_enqueue again. Since the qlen from =
hfsc perspective is still 0 (as the previous call is still waiting for the =
child enqueue to finish), both will have first set to true and reach this i=
nit_ed call (https://elixir.bootlin.com/linux/v6.15-rc5/source/net/sched/sc=
h_hfsc.c#L1574), which will both reach eltree_insert (https://elixir.bootli=
n.com/linux/v6.15-rc5/source/net/sched/sch_hfsc.c#L634).=20

This becomes a serious problem because this will create a cycle in the rbtr=
ee. So when hfsc_dequeue calls eltree_get_mindl (https://elixir.bootlin.com=
/linux/v6.15-rc5/source/net/sched/sch_hfsc.c#L1613), the task hangs in an i=
nfinite loop.

Should netem_enqueue really insert duplicated packets from the root qdisc? =
If so, then there should be additional corner case checking for a qdisc act=
ing as the root handler for cases where it calls a child enqueue handler th=
at may subsequently trigger the root handler again before the original root=
 call finishes.

Below is a repro for the hfsc case:

tc qdisc add dev lo root handle fff1: hfsc default 10
tc class add dev lo parent fff1: classid fff1:10 hfsc rt m1 1kbit d 1ms m2 =
1kbit
tc qdisc add dev lo parent fff1:10 handle 8001: netem limit 1 delay 1us dup=
licate 100%
ping -I lo -f -c1 -s48 -W0.001 127.0.0.1

[   52.583589] watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [ping:226]
[   52.583602] Modules linked in:
[   52.583606] irq event stamp: 54379
[   52.583609] hardirqs last  enabled at (54378): [<ffffffff82c55aeb>] irqe=
ntry_exit+0x3b/0x90
[   52.583642] hardirqs last disabled at (54379): [<ffffffff82c5475e>] sysv=
ec_apic_timer_interrupt+0xe/0x80
[   52.583653] softirqs last  enabled at (5070): [<ffffffff825cc928>] neigh=
_resolve_output+0x2b8/0x340
[   52.583668] softirqs last disabled at (5074): [<ffffffff825adaaa>] __dev=
_queue_xmit+0x8a/0x2110
[   52.583685] CPU: 1 UID: 0 PID: 226 Comm: ping Not tainted 6.15.0-rc3-000=
94-g02ddfb981de8 #28 PREEMPT(voluntary)=20
[   52.583696] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), B=
IOS 1.16.3-debian-1.16.3-2 04/01/2014
[   52.583702] RIP: 0010:rb_first+0x13/0x30
[   52.583713] Code: cc cc 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 =
90 90 90 90 90 f3 0f 1e fa 48 8b 07 48 85 c0 74 14 48 89 c2 48 8b 40 10 <48=
> 85 c0 75 f4 48 89 d0 c3 cc cc cc cc 31 d2 eb f4 66 66 2e f
[   52.583722] RSP: 0018:ffffc90000edf8f8 EFLAGS: 00000286
[   52.583729] RAX: ffff8881029008a0 RBX: 0000000000000002 RCX: ffffffff814=
0f346
[   52.583735] RDX: ffff8881029008a0 RSI: ffffffff8140f354 RDI: ffff888106e=
cc5d8
[   52.583741] RBP: 0000000000000000 R08: 0000000000000004 R09: 00000000000=
02eca
[   52.583747] R10: 0000000000002eca R11: 0000000000000001 R12: 0000000019f=
e24dd
[   52.583753] R13: ffff888106ecc000 R14: 0000000000000000 R15: 00000000000=
00010
[   52.583762] FS:  00007fddb2296000(0000) GS:ffff8881b755a000(0000) knlGS:=
0000000000000000
[   52.583768] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   52.583774] CR2: 0000562b67773794 CR3: 00000001028fc000 CR4: 00000000000=
006f0
[   52.583779] Call Trace:
[   52.583783]  <TASK>
[   52.583797]  hfsc_dequeue+0x59/0x610
[   52.583815]  ? init_ed+0x185/0x1e0
[   52.583835]  __qdisc_run+0xdb/0x9e0
[   52.583854]  __dev_queue_xmit+0xec2/0x2110
[   52.583870]  ? lock_acquire+0xbb/0x2d0
[   52.583883]  ? ip_finish_output2+0x2cc/0xd40
[   52.583893]  ? find_held_lock+0x2b/0x80
[   52.583903]  ? skb_push+0x39/0x70
[   52.583915]  ? eth_header+0xe3/0x140
[   52.583925]  neigh_resolve_output+0x211/0x340
[   52.583937]  ip_finish_output2+0x2cc/0xd40
[   52.583949]  __ip_finish_output.part.0+0xda/0x1c0
[   52.583961]  ip_output+0x17b/0x6f0
[   52.583972]  ? __pfx_ip_finish_output+0x10/0x10
[   52.583981]  ? __pfx_ip_output+0x10/0x10
[   52.583991]  ip_push_pending_frames+0x1ed/0x310
[   52.584003]  raw_sendmsg+0xbfa/0x1cb0
[   52.584019]  ? lock_acquire+0xbb/0x2d0
[   52.584030]  ? __might_fault+0x6f/0xb0
[   52.584044]  ? __pfx_raw_sendmsg+0x10/0x10
[   52.584056]  inet_sendmsg+0xc0/0xd0
[   52.584067]  __sys_sendto+0x29a/0x2e0
[   52.584086]  __x64_sys_sendto+0x28/0x30
[   52.584094]  do_syscall_64+0xbb/0x1d0
[   52.584106]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   52.584115] RIP: 0033:0x7fddb2516046
[   52.584123] Code: 0e 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f =
1f 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 2c 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 72 c3 90 55 48 83 ec 30 44 89 4c 24 2c 9
[   52.584131] RSP: 002b:00007ffdd1da0e88 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002c
[   52.584138] RAX: ffffffffffffffda RBX: 00007ffdd1da2610 RCX: 00007fddb25=
16046
[   52.584144] RDX: 0000000000000038 RSI: 0000562b9fc5a950 RDI: 00000000000=
00003
[   52.584149] RBP: 0000562b9fc5a950 R08: 00007ffdd1da488c R09: 00000000000=
00010
[   52.584154] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00038
[   52.584158] R13: 00007ffdd1da25d0 R14: 00007ffdd1da0e90 R15: 0000001d000=
00001
[   52.584170]  </TASK>


Best,
Will
Savy

