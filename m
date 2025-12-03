Return-Path: <netdev+bounces-243369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7FAC9E21E
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 09:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA2AE34909C
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 08:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D87D2BD035;
	Wed,  3 Dec 2025 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5sFDz9h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF9929B775
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764749171; cv=none; b=s1nKbAomy+SRfuqZ7vXSBCxF0Fu+y6Ee4FKeZUJ/rjoM3f2TA8RaB29mfIMNB4JndKUgkihlKsc6ozkF6B4SltLR9BPUfk5N0kBMn+5xxqGeaIiHXet2YQFLojPo7+ShexSsjfWCs/62JOCyc4374Nu9eqP7roiI1vZ4J7SiXks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764749171; c=relaxed/simple;
	bh=GJCOcBqnznEpjxRnY0/csopsuS0VUj5Gd23Jfm9UVsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzjR05S3OX4OYuH3K/QI0ZqUmdSUtoZ/7o+pRvXMZhYIqSLfWcHnV4Ao8a9GesnA8RhbbBg4deLiEnjCaspVJG2l+N/hwycjkXxwwhPH8ylh8Vv2zCewejPdI4u3A6it601xUuXpcAxMv5x3Vk5jj9iPQvYx5TTqJKDOBtvxQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V5sFDz9h; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ee1e18fb37so61910681cf.0
        for <netdev@vger.kernel.org>; Wed, 03 Dec 2025 00:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764749167; x=1765353967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjtVuwooiU7yrSeE2cgk61p7o/RWn1Wgwxj9lGkFYIA=;
        b=V5sFDz9hzCPB0YuyCo/p6XNDk7cPcW+XJf1FpVuG+BaEuy8y7nEDf7g7h6PYHiu+/R
         ArpfmG6jSowRilMpS4Hl8wNs7OYKtNNp5W8ENIf0dtj9NI7PJp4TohazcO4+1llyL8Tf
         U9eDtV7cIQIu90IkpgMq+wlFvoYvILSl949JuNKmDe0pQdBL/MDjsWUJ1OrF/UN1KBs7
         hglF9PporABKQP3NBJUxBs/v4GStYEcaqX750J+4756x0/+X0V2VXR/2VRV6HfkMY91D
         S5ES+/EkdyWZzn12lFdXdh/AJpN3GskzmW3FxHLwjOgK9D6TCTUUtawz1bV4MpPP9fu2
         uA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764749167; x=1765353967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VjtVuwooiU7yrSeE2cgk61p7o/RWn1Wgwxj9lGkFYIA=;
        b=qbEVhwFOr67x60fT61k0KqqukAn7oW6GM1LImm7zPDzOmxmSZMTmi5znaqNkyiuP+a
         4wu6GsKcVZFF5OZBPN6mwQcmshkDw7oSsQaHr2vkoiWeNv8ShTQSmT39w6s4HRuUJv6C
         yjGG15Rn3pVU1rIGAUcNDjMLOQu/ii5djOcINDZdjmdlv0hDPAtu57uV0UGAb2XQdWBp
         kHUA77fd31LBGqoR873DlQL58b7y00FnsafRwl1byEo5CSKrH+kRmKjWRxXbFO9PFWW2
         I8bB8NN/uUfgQrb+79QMFAyv2+fcs2nlpEI67603GLeYjrg1trEDkCHEIjH+gOPp1Slt
         pfyA==
X-Forwarded-Encrypted: i=1; AJvYcCWmcV0RojSANO9VJZeHrGUGSoliNhM+OERkmIk8KjdrenRfqdlCWOPgCOPC2Qaomp8jFSeAxI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM0gCfjZBtNeGBjaVq8WFy4ydFdk2nt8Be9GrzTS5E9naLZyWf
	+nDs3Da2MegQAeqwAExqIUYRn39uierev0wzftmxUOMFVLd83MKY9tulQB3uCSnOFdH5yRuUL75
	kr29SjoCYD3G5DvmDtgOYdPOIflBGX/2rq5rXje7z
X-Gm-Gg: ASbGncscrf4KZ5WLeIVnByjo+FbIZs4NneuqCbSleslLG9rjIPju5ERin6EkORyNB/g
	BurGJypTfAueZz4iOpOgBvSPA7Wv7qfrUuwg4iUY/rE4z5HLdLKdmJWFzkAdkAeJH+5yQUisUsy
	V4fFUGwke0udMmURiMpg/jaR4RTqfWZDBS8UHpKXkQa+BlEO4Q41XAxCMxK74hU1K0luwfDiMUv
	ml8Rhe+vStRqxtQ8VZJJYI0IYOLFhVzWGU4Dp9tJrgtAYernDH0XzCfIhfjr9PTvk4MYCI=
X-Google-Smtp-Source: AGHT+IFqvQFy+l2JRZRncQChdQQuu5SSLTOlPpWGqsE5/QOQod9WJdWnGjmBQCQVeZLfryrdszN3b+CN4zSXUnR10Fs=
X-Received: by 2002:ac8:5d4b:0:b0:4ee:146f:2503 with SMTP id
 d75a77b69052e-4f01757f56cmr19694751cf.3.1764749167056; Wed, 03 Dec 2025
 00:06:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKrymDR2qmwucFerf48tid6zJK5-RE7G+ncV+Viqz-VwvwTNjA@mail.gmail.com>
In-Reply-To: <CAKrymDR2qmwucFerf48tid6zJK5-RE7G+ncV+Viqz-VwvwTNjA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 3 Dec 2025 00:05:55 -0800
X-Gm-Features: AWmQ_bnogGYf-DiBOnz3hloQA8C4mgJfH4WKaWZuXfOFJueGqqwfS0NOXeP790Y
Message-ID: <CANn89i+3_50FX1RWutvipTMROD3FnK-nBeG4L+br86W85fzRdQ@mail.gmail.com>
Subject: Re: [SECURITY] Use-After-Free in /proc/net/atm/mpc QoS list
 (qos_head) due to missing locking
To: Minseong Kim <ii4gsp@gmail.com>
Cc: security@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 11:37=E2=80=AFPM Minseong Kim <ii4gsp@gmail.com> wro=
te:
>
> Hello Linux kernel security team and ATM/Networking maintainers,
>

Hello Minseong

Please do not involve security@kernel.org on something you make public.
There is nothing left for us to do, as security officers.
Please read https://www.kernel.org/doc/Documentation/process/security-bugs.=
rst
for details.

As for the bugs, do you already have fixes for them ?

If so, please send formal patches to netdev@ mailing list.

Thank you.

> I would like to report a reproducible use-after-free issue in the ATM MPO=
A
> procfs interface.
>
> Subsystem / Files:
>   - net/atm/mpoa_proc.c  (procfs interface that exposes /proc/net/atm/mpc=
)
>   - net/atm/mpc.c        (qos_head list and QoS management logic)
>
> Vulnerable functions / paths:
>   - Read side:  mpc_show() -> atm_mpoa_disp_qos()
>   - Write side: proc_mpc_write() -> parse_qos() -> atm_mpoa_delete_qos()
>
> Issue summary:
>   atm_mpoa_disp_qos() walks the global QoS list (qos_head) without any
>   locking or refcounting. Concurrently, proc_mpc_write() can delete QoS
>   entries via atm_mpoa_delete_qos(), which unlinks and kfree()s entries
>   immediately. This creates a race where the show path continues to read =
a
>   freed QoS entry, leading to UAF.
>
>   The code already acknowledges this risk:
>     /* this is buggered - we need locking for qos_head */
>
> Race window / execution flow:
>   Reader (procfs):
>     proc_reg_read -> seq_read_iter -> mpc_show
>       -> atm_mpoa_disp_qos() walks qos_head without lock
>
>   Writer (procfs):
>     proc_reg_write -> proc_mpc_write -> parse_qos("del ...")
>       -> atm_mpoa_delete_qos() deletes entry and kfree()s it immediately
>
>   If deletion happens while atm_mpoa_disp_qos() is printing the same entr=
y,
>   mpc_show continues accessing freed memory =3D> UAF.
>
> Affected versions / prerequisites:
>   - Confirmed on Linux 6.17.8 with CONFIG_ATM + CONFIG_ATM_MPOA enabled.
>   - Requires MPOA being active and QoS entries to exist (qos_head non-NUL=
L).
>   - The qos_head locking model appears unchanged for a long time, so olde=
r
>     kernels with MPOA enabled are likely affected as well.
>
> Reproduction:
>   Reproduced reliably with KASAN using a PoC that:
>     (1) continuously reads /proc/net/atm/mpc (triggering atm_mpoa_disp_qo=
s),
>     (2) concurrently adds/deletes QoS entries via proc writes to induce c=
hurn.
>   PoC and full logs are available upon request.
>
> KASAN evidence:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 15.911538] BUG: KASAN: slab-use-after-free in atm_mpoa_disp_qos+0x202/0=
x380
> [ 15.911988] Read of size 8 at addr ffff888007517380 by task mpoa_uaf_poc=
/89
> [ 15.912123]
> [ 15.912717] CPU: 0 UID: 0 PID: 89 Comm: mpoa_uaf_poc Not tainted
> 6.17.8 #1 PREEMPT(voluntary)
> [ 15.912950] Hardware name: QEMU Ubuntu 25.04 PC (i440FX + PIIX,
> 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [ 15.913110] Call Trace:
> [ 15.913167] <TASK>
> [ 15.913247] dump_stack_lvl+0x4e/0x70
> [ 15.913343] ? atm_mpoa_disp_qos+0x202/0x380
> [ 15.913364] print_report+0x174/0x4f6
> [ 15.913386] ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [ 15.913412] ? atm_mpoa_disp_qos+0x202/0x380
> [ 15.913430] kasan_report+0xce/0x100
> [ 15.913453] ? atm_mpoa_disp_qos+0x202/0x380
> [ 15.913475] atm_mpoa_disp_qos+0x202/0x380
> [ 15.913496] mpc_show+0x575/0x700
> [ 15.913515] ? kasan_save_track+0x14/0x30
> [ 15.913532] ? __pfx_mpc_show+0x10/0x10
> [ 15.913550] ? __pfx_mutex_lock+0x10/0x10
> [ 15.913565] ? seq_read_iter+0x697/0x1110
> [ 15.913584] seq_read_iter+0x2bc/0x1110
> [ 15.913607] seq_read+0x267/0x3d0
> [ 15.913623] ? __pfx_seq_read+0x10/0x10
> [ 15.913650] proc_reg_read+0x1ab/0x270
> [ 15.913669] vfs_read+0x175/0xa10
> [ 15.913687] ? do_sys_openat2+0x103/0x170
> [ 15.913701] ? kmem_cache_free+0xc4/0x360
> [ 15.913718] ? getname_flags.part.0+0xf3/0x470
> [ 15.913734] ? __pfx_vfs_read+0x10/0x10
> [ 15.913751] ? mutex_lock+0x81/0xe0
> [ 15.913766] ? __pfx_mutex_lock+0x10/0x10
> [ 15.913782] ? __rseq_handle_notify_resume+0x4c4/0xac0
> [ 15.913802] ? fdget_pos+0x24d/0x4b0
> [ 15.913829] ksys_read+0xf7/0x1c0
> [ 15.913850] ? __pfx_ksys_read+0x10/0x10
> [ 15.913877] do_syscall_64+0xa4/0x290
> [ 15.913917] entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [ 15.913981] RIP: 0033:0x45c982
> [ 15.914171] Code: 08 0f 85 71 ea ff ff 49 89 fb 48 89 f0 48 89 d7 48
> 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08
> 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 55 48 89
> e5
> [ 15.914239] RSP: 002b:00007f4b2b2cb0d8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000000
> [ 15.914315] RAX: ffffffffffffffda RBX: 00007f4b2b2cc6c0 RCX: 00000000004=
5c982
> [ 15.914352] RDX: 0000000000000fff RSI: 00007f4b2b2cb220 RDI: 00000000000=
00014
> [ 15.914382] RBP: 00007f4b2b2cb100 R08: 0000000000000000 R09: 00000000000=
00000
> [ 15.914413] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
0000a
> [ 15.914445] R13: ffffffffffffffd0 R14: 0000000000000000 R15: 00007ffd386=
450c0
> [ 15.914483] </TASK>
> [ 15.914533]
> [ 15.916812] Allocated by task 78:
> [ 15.916975] kasan_save_stack+0x30/0x50
> [ 15.917047] kasan_save_track+0x14/0x30
> [ 15.917105] __kasan_kmalloc+0x8f/0xa0
> [ 15.917162] atm_mpoa_add_qos+0x1bb/0x3c0
> [ 15.917220] parse_qos.cold+0x73/0x7d
> [ 15.917276] proc_mpc_write+0xf4/0x150
> [ 15.917331] proc_reg_write+0x1ab/0x270
> [ 15.917379] vfs_write+0x1ce/0xd30
> [ 15.917431] ksys_write+0xf7/0x1c0
> [ 15.917476] do_syscall_64+0xa4/0x290
> [ 15.917523] entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [ 15.917586]
> [ 15.917628] Freed by task 78:
> [ 15.917665] kasan_save_stack+0x30/0x50
> [ 15.917714] kasan_save_track+0x14/0x30
> [ 15.917762] kasan_save_free_info+0x3b/0x70
> [ 15.917811] __kasan_slab_free+0x3e/0x50
> [ 15.918058] kfree+0x121/0x340
> [ 15.918135] atm_mpoa_delete_qos+0xad/0xd0
> [ 15.918196] parse_qos+0x1e5/0x1f0
> [ 15.918339] proc_mpc_write+0xf4/0x150
> [ 15.918438] proc_reg_write+0x1ab/0x270
> [ 15.918494] vfs_write+0x1ce/0xd30
> [ 15.918538] ksys_write+0xf7/0x1c0
> [ 15.918589] do_syscall_64+0xa4/0x290
> [ 15.918634] entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [ 15.918694]
> [ 15.918751] The buggy address belongs to the object at ffff888007517380
> [ 15.918751] which belongs to the cache kmalloc-96 of size 96
> [ 15.918911] The buggy address is located 0 bytes inside of
> [ 15.918911] freed 96-byte region [ffff888007517380, ffff8880075173e0)
> [ 15.919027]
> [ 15.919101] The buggy address belongs to the physical page:
> [ 15.919416] page: refcount:0 mapcount:0 mapping:0000000000000000
> index:0xffff888007517300 pfn:0x7517
> [ 15.919679] anon flags: 0x100000000000000(node=3D0|zone=3D1)
> [ 15.920064] page_type: f5(slab)
> [ 15.920361] raw: 0100000000000000 ffff888006c41280 0000000000000000
> dead000000000001
> [ 15.920460] raw: ffff888007517300 0000000080200007 00000000f5000000
> 0000000000000000
> [ 15.920577] page dumped because: kasan: bad access detected
> [ 15.920634]
> [ 15.920663] Memory state around the buggy address:
> [ 15.920860] ffff888007517280: fa fb fb fb fb fb fb fb fb fb fb fb fc fc =
fc fc
> [ 15.920944] ffff888007517300: fa fb fb fb fb fb fb fb fb fb fb fb fc fc =
fc fc
> [ 15.921017] >ffff888007517380: fa fb fb fb fb fb fb fb fb fb fb fb fc fc=
 fc fc
> [ 15.921088] ^
> [ 15.921163] ffff888007517400: fa fb fb fb fb fb fb fb fb fb fb fb fc fc =
fc fc
> [ 15.921222] ffff888007517480: fa fb fb fb fb fb fb fb fb fb fb fb fc fc =
fc fc
> [ 15.921313] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Note on reproduction setup:
>   For easier reproduction in a VM without full MPOA/ATM traffic, I applie=
d a
>   local debug-only seeding change in net/atm/mpc.c to create one test
> mpoa_client
>   and a few cache/QoS entries at init time. This seeding patch does NOT c=
hange
>   locking or list logic; it only creates the runtime state required to hi=
t the
>   existing race. The underlying UAF is present in upstream code and can b=
e
>   triggered on unmodified kernels whenever MPOA is active and qos entries=
 exist.
>   I can provide the seeding patch separately if helpful.
>
> Impact:
>   - UAF read in procfs show path; can lead to kernel crash (DoS) and
>     potentially info leak.
>   - In my current PoC, concurrent procfs writes were used (root/CAP_NET_A=
DMIN);
>     I have not confirmed a fully unprivileged trigger path yet.
>
> Proposed fix direction:
>   The minimal fix is to introduce proper synchronization for qos_head:
>     (A) add a dedicated lock to protect qos_head traversal in
> atm_mpoa_disp_qos()
>         (read-side) and add/delete paths (write-side), or
>     (B) convert qos_head/QoS entries to an RCU-protected list and free vi=
a
>         kfree_rcu().
>
>   I am happy to prepare and submit a patch if you prefer; please advise w=
hich
>   approach fits best for this legacy ATM code.
>
> If this is considered a security issue, I would appreciate guidance on
> CVE assignment.
>
> Thank you,
> Minseong Kim
> ii4gsp@gmail.com

