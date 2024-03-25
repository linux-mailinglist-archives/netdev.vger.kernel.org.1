Return-Path: <netdev+bounces-81580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A6588B1F2
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB033CC4935
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 15:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BBE128821;
	Mon, 25 Mar 2024 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Lo7pH32E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10314127B71
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369871; cv=none; b=N7ZGJN+5wUTiXneyQxJWgcTdCct99fdMiWNs+fo+Glh3muiMA/5bCgu7OtBkT9M6UM6+G6dHZ5BQYnxk227k74nqCcgzIR/GYlzYOs9+lI84dExakSfJqFhZc8DaW6UKkQ/eq9u6PguS173tDcp8hyrPzkYddhQti+25Qk7Ge7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369871; c=relaxed/simple;
	bh=aVlbCxffNsImE8sHfAMIWvGJXmWurPG4VbYMHdhQLEE=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=FnhX6fWPtIqbEjG4Q4QEQdrWVC0cYfoML2hblIm19mSUPTmAwT5IPMwdiUUaSr1tw4t8Yx+S8cOdwywaPAPp/u3uefRJMnKrKoEpzljRSIj25zIYUeuoWrT0lGqDh3OWOOiSxrG4UGjjLn23CTVCy/20wx6ePcsz5Byzej3tqu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Lo7pH32E; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4751063318so156783866b.0
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 05:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1711369867; x=1711974667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcU8rzfT1XiiKbhTkgktGjNuFns7iqoHulhoe5/hqUA=;
        b=Lo7pH32EDvtGcPXVKvcXC+oWlGIjaAtwHInzgo+vICN0fCBF5+04BkcBeaOvTmQxcl
         hPflHKv1GW3bKNd07k+pu5qQjP1/Vm2r9IEbXIw06l+1buF/Xkw9u+HKtiRoN5wHc3J9
         Unhhk5DOtoIHgg1bWFAev59Tr8LiHsFUQAs729DIWEVRWznHomIAXdHppKm3bUfSLyAm
         cV/UgI3t88mz0sFUnyhjw3DvZrF2h+ulC047pqZ4gijZPgENHmjOyfD9ld3XnX+Of5IV
         4ofFS4167n0xFNx6QiDDtsftGtxgN/3rsUbHbvjm2FNMvVtzk/Ra+Et7il5Z6u77QIC5
         CTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711369867; x=1711974667;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jcU8rzfT1XiiKbhTkgktGjNuFns7iqoHulhoe5/hqUA=;
        b=kOOn6Rn657T1nUVDUgRJi3GJY9lVm+Tm9ldJ9osu3w+hcNZZ+IKACWXJroVt0YM613
         1HTST788DsxDpO9qHlhzB+cQz973n6/QIQx3gKRTPzNklXe3YRUPLjfsL9t1UQ2RdcG1
         el1LoQSaNL7VfrBTT0cQCfnv6fBYdzA7MGIGK63okLYsdS7wjx1tlCQ3vSgp5+a4BUlJ
         q1q8v2MqFoebTs1+nG+/z6rDjQ4cv4/KsIRgfGNduel+YcmLjIlyXv6qwPR0X+zPb+IX
         r6dGQJ6RZZlVDwV95dmmWfWZBJoTdcAYZocmi3wGbsnwErnw/uMX0hPsRpzS00JX2wUc
         zO7g==
X-Forwarded-Encrypted: i=1; AJvYcCXWlHjTqoJLlKc4P6i/ATgbMM16H2pyRpKvfznbushCsyP5fRzqK7hRafDlzZ4jPdBLMmVLUPkv/YMnAfFKEQyG4r2TUvO+
X-Gm-Message-State: AOJu0YwCIAuJUc8E1BTU/jCeRfIGF0BRNy+MVQ0P7tUV5pULSQoJlzS4
	oHn7RiRxVY7Nb5PXDjA5LUXIzN3D4xdjROuNuaVxzXarEqrCobWOoXv4wWEGJ1w=
X-Google-Smtp-Source: AGHT+IGsrHcYCvS/Zb86Okam1T7FEifHPpoDZSR+RYzLLEafipL8a0Eaa2hp5duWV+Ok7DmwELZZtA==
X-Received: by 2002:a17:906:d0d7:b0:a47:5265:9aac with SMTP id bq23-20020a170906d0d700b00a4752659aacmr2438772ejb.55.1711369867358;
        Mon, 25 Mar 2024 05:31:07 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1a6])
        by smtp.gmail.com with ESMTPSA id w17-20020a170906385100b00a46d8e5a031sm2988980ejc.209.2024.03.25.05.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 05:31:06 -0700 (PDT)
References: <000000000000dc9aca0613ec855c@google.com>
 <tencent_F436364A347489774B677A3D13367E968E09@qq.com>
 <CAADnVQJQvcZOA_BbFxPqNyRbMdKTBSMnf=cKvW7NJ8LxxP54sA@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Edward Adam Davis
 <eadavis@qq.com>, John Fastabend <john.fastabend@gmail.com>
Cc: syzbot+c4f4d25859c2e5859988@syzkaller.appspotmail.com,
 42.hyeyoo@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, namhyung@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, peterz@infradead.org, songliubraving@fb.com,
 syzkaller-bugs@googlegroups.com, yhs@fb.com
Subject: Re: [PATCH] bpf, sockmap: fix deadlock in rcu_report_exp_cpu_mult
Date: Mon, 25 Mar 2024 13:23:07 +0100
In-reply-to: <CAADnVQJQvcZOA_BbFxPqNyRbMdKTBSMnf=cKvW7NJ8LxxP54sA@mail.gmail.com>
Message-ID: <87y1a6biie.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 12:08 AM -07, Alexei Starovoitov wrote:
> John,
> please review.
> It seems this bug was causing multiple syzbot reports.

Any chance we could disallow mutating sockhash from interrupt context?

If that is not an option, then this looks like a good start of a fix.
But we also need to cover sock_map_unref->sock_sock_map_del_link called
from sock_hash_delete_elem. It also grabs a spin lock.

Also, sockhash is not the only affected map type. I see we're grabbing a
spin lock in ->map_delete_elem without disabling interrupts as well in:

- sock_map_delete_elem
- reuseport_array_delete_elem
- xsk_map_delete_elem

> On Fri, Mar 22, 2024 at 10:42=E2=80=AFPM Edward Adam Davis <eadavis@qq.co=
m> wrote:
>>
>> [Syzbot reported]
>> WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
>> 6.8.0-syzkaller-05221-gea80e3ed09ab #0 Not tainted
>> -----------------------------------------------------
>> rcu_exp_gp_kthr/18 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
>> ffff88802b5ab020 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh =
include/linux/spinlock.h:356 [inline]
>> ffff88802b5ab020 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_del=
ete_elem+0xb0/0x300 net/core/sock_map.c:939
>>
>> and this task is already holding:
>> ffffffff8e136558 (rcu_node_0){-.-.}-{2:2}, at: sync_rcu_exp_done_unlocke=
d+0xe/0x140 kernel/rcu/tree_exp.h:169
>> which would create a new lock dependency:
>>  (rcu_node_0){-.-.}-{2:2} -> (&htab->buckets[i].lock){+...}-{2:2}
>>
>> but this new dependency connects a HARDIRQ-irq-safe lock:
>>  (rcu_node_0){-.-.}-{2:2}
>>
>> ... which became HARDIRQ-irq-safe at:
>>   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>>   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>>   _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
>>   rcu_report_exp_cpu_mult+0x27/0x2f0 kernel/rcu/tree_exp.h:238
>>   csd_do_func kernel/smp.c:133 [inline]
>>   __flush_smp_call_function_queue+0xb2e/0x15b0 kernel/smp.c:542
>>   __sysvec_call_function_single+0xa8/0x3e0 arch/x86/kernel/smp.c:271
>>   instr_sysvec_call_function_single arch/x86/kernel/smp.c:266 [inline]
>>   sysvec_call_function_single+0x9e/0xc0 arch/x86/kernel/smp.c:266
>>   asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentr=
y.h:709
>>   __sanitizer_cov_trace_switch+0x90/0x120
>>   update_event_printk kernel/trace/trace_events.c:2750 [inline]
>>   trace_event_eval_update+0x311/0xf90 kernel/trace/trace_events.c:2922
>>   process_one_work kernel/workqueue.c:3254 [inline]
>>   process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
>>   worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>>   kthread+0x2f0/0x390 kernel/kthread.c:388
>>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>>
>> to a HARDIRQ-irq-unsafe lock:
>>  (&htab->buckets[i].lock){+...}-{2:2}
>>
>> ... which became HARDIRQ-irq-unsafe at:
>> ...
>>   lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>>   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
>>   _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
>>   spin_lock_bh include/linux/spinlock.h:356 [inline]
>>   sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
>>   0xffffffffa0001b0e
>>   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
>>   __bpf_prog_run include/linux/filter.h:657 [inline]
>>   bpf_prog_run include/linux/filter.h:664 [inline]
>>   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
>>   bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
>>   trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
>>   __mutex_lock_common kernel/locking/mutex.c:617 [inline]
>>   __mutex_lock+0x2e5/0xd70 kernel/locking/mutex.c:752
>>   futex_cleanup_begin kernel/futex/core.c:1091 [inline]
>>   futex_exit_release+0x34/0x1f0 kernel/futex/core.c:1143
>>   exit_mm_release+0x1a/0x30 kernel/fork.c:1652
>>   exit_mm+0xb0/0x310 kernel/exit.c:542
>>   do_exit+0x99e/0x27e0 kernel/exit.c:865
>>   do_group_exit+0x207/0x2c0 kernel/exit.c:1027
>>   __do_sys_exit_group kernel/exit.c:1038 [inline]
>>   __se_sys_exit_group kernel/exit.c:1036 [inline]
>>   __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
>>   do_syscall_64+0xfb/0x240
>>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
>>
>> other info that might help us debug this:
>>
>>  Possible interrupt unsafe locking scenario:
>>
>>        CPU0                    CPU1
>>        ----                    ----
>>   lock(&htab->buckets[i].lock);
>>                                local_irq_disable();
>>                                lock(rcu_node_0);
>>                                lock(&htab->buckets[i].lock);
>>   <Interrupt>
>>     lock(rcu_node_0);
>>
>>  *** DEADLOCK ***
>> [Fix]
>> Ensure that the context interrupt state is the same before and after usi=
ng the
>> bucket->lock.
>>
>> Reported-and-tested-by: syzbot+c4f4d25859c2e5859988@syzkaller.appspotmai=
l.com
>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>> ---
>>  net/core/sock_map.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>> index 27d733c0f65e..ae8f81b26e16 100644
>> --- a/net/core/sock_map.c
>> +++ b/net/core/sock_map.c
>> @@ -932,11 +932,12 @@ static long sock_hash_delete_elem(struct bpf_map *=
map, void *key)
>>         struct bpf_shtab_bucket *bucket;
>>         struct bpf_shtab_elem *elem;
>>         int ret =3D -ENOENT;
>> +       unsigned long flags;
>>
>>         hash =3D sock_hash_bucket_hash(key, key_size);
>>         bucket =3D sock_hash_select_bucket(htab, hash);
>>
>> -       spin_lock_bh(&bucket->lock);
>> +       spin_lock_irqsave(&bucket->lock, flags);
>>         elem =3D sock_hash_lookup_elem_raw(&bucket->head, hash, key, key=
_size);
>>         if (elem) {
>>                 hlist_del_rcu(&elem->node);
>> @@ -944,7 +945,7 @@ static long sock_hash_delete_elem(struct bpf_map *ma=
p, void *key)
>>                 sock_hash_free_elem(htab, elem);
>>                 ret =3D 0;
>>         }
>> -       spin_unlock_bh(&bucket->lock);
>> +       spin_unlock_irqrestore(&bucket->lock, flags);
>>         return ret;
>>  }
>>
>> @@ -1136,6 +1137,7 @@ static void sock_hash_free(struct bpf_map *map)
>>         struct bpf_shtab_elem *elem;
>>         struct hlist_node *node;
>>         int i;
>> +       unsigned long flags;
>>
>>         /* After the sync no updates or deletes will be in-flight so it
>>          * is safe to walk map and remove entries without risking a race
>> @@ -1151,11 +1153,11 @@ static void sock_hash_free(struct bpf_map *map)
>>                  * exists, psock exists and holds a ref to socket. That
>>                  * lets us to grab a socket ref too.
>>                  */
>> -               spin_lock_bh(&bucket->lock);
>> +               spin_lock_irqsave(&bucket->lock, flags);
>>                 hlist_for_each_entry(elem, &bucket->head, node)
>>                         sock_hold(elem->sk);
>>                 hlist_move_list(&bucket->head, &unlink_list);
>> -               spin_unlock_bh(&bucket->lock);
>> +               spin_unlock_irqrestore(&bucket->lock, flags);
>>
>>                 /* Process removed entries out of atomic context to
>>                  * block for socket lock before deleting the psock's
>> --
>> 2.43.0
>>


