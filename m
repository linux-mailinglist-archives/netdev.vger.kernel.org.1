Return-Path: <netdev+bounces-228056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC0CBC02ED
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 07:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D68B3B512E
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 05:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE8C13B293;
	Tue,  7 Oct 2025 05:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V9F7JW/9"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4441433BC
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 05:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759814149; cv=none; b=k2Mb31A8+EhUi2pfvXpVPXUPMDZEv86z3WP+iGSEd3Q3J90hcdEu2Cj5aSALZR20uYA1GR3ibIvAgjCe2zeSZreB36xHX7QjfMtKYGhAzD4nj+xvBMaDjZNGLd31dsoqdj2MaOcPCDzw7OSWHX6NDUxhBzA+X6tNB6iM7aDzRSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759814149; c=relaxed/simple;
	bh=zEZpnSahfHQaFMqyz/cmHcQ67OUZ0Tx6WNe/JIQ48Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Op8C9tx1S80+SKt8rRKhwoJCT3S1yFKlUf3V8aYU0Uf7qfwK0D2VA1sd4CPEKAYBCagBQsM058DVmRX0hmyhakfWpHGxEcQoKP+3D7d/EX0+yFOxGqpk+iGPY4Ffm/gizKYOG4h5ujqZgAgHSEenZK+M985/pBxcfp2170Wrgfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V9F7JW/9; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d0fdced7-a9a5-473e-991f-4f5e4c13f616@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759814135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eu/oOb8mV7TM8FhJRzPVcInZwZOHE2eRxatws5DaWjg=;
	b=V9F7JW/9SEqeC9Qs5+iCPnrdmR0IolZ2Fc6IExA/nFK7Hb+oItcaUGbJT/6oKzio6+hQ45
	nA1OWA7dXtrIdmM6uJY7sOE24+o5P0x8+kMeAPfJOk+zBglThhL9ml6UxAZN7h/R12EUkP
	K9D37xU6Y61zHMZ7R30f1VXg6qQW4ag=
Date: Mon, 6 Oct 2025 22:15:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: test_run: Fix timer mode initialization to
 NO_MIGRATE mode
Content-Language: en-GB
To: Sahil Chandna <chandna.linuxkernel@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, john.fastabend@gmail.com, haoluo@google.com,
 jolsa@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
 khalid@kernel.org, syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
References: <20251006054320.159321-1-chandna.linuxkernel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251006054320.159321-1-chandna.linuxkernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/5/25 10:43 PM, Sahil Chandna wrote:
> By default, the timer mode is being initialized to `NO_PREEMPT`.
> This disables preemption and forces execution in atomic context.
> This can cause issue with PREEMPT_RT when calling spin_lock_bh() due
> to sleeping nature of the lock.
> ...
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6107, name: syz.0.17
> preempt_count: 1, expected: 0
> RCU nest depth: 1, expected: 1
> Preemption disabled at:
> [<ffffffff891fce58>] bpf_test_timer_enter+0xf8/0x140 net/bpf/test_run.c:42
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>   __might_resched+0x44b/0x5d0 kernel/sched/core.c:8957
>   __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
>   rt_spin_lock+0xc7/0x2c0 kernel/locking/spinlock_rt.c:57
>   spin_lock_bh include/linux/spinlock_rt.h:88 [inline]
>   __sock_map_delete net/core/sock_map.c:421 [inline]
>   sock_map_delete_elem+0xb7/0x170 net/core/sock_map.c:452
>   bpf_prog_2c29ac5cdc6b1842+0x43/0x4b
>   bpf_dispatcher_nop_func include/linux/bpf.h:1332 [inline]
> ...
> Change initialization to NO_MIGRATE mode to prevent this.
>
> Reported-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
> Tested-by: syzbot+1f1fbecb9413cdbfbef8@syzkaller.appspotmail.com
> Signed-off-by: Sahil Chandna <chandna.linuxkernel@gmail.com>
> ---
>   net/bpf/test_run.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 4a862d605386..daf966dfed69 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1368,7 +1368,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
>   				     const union bpf_attr *kattr,
>   				     union bpf_attr __user *uattr)
>   {
> -	struct bpf_test_timer t = { NO_PREEMPT };
> +	struct bpf_test_timer t = { NO_MIGRATE };

I checked the original reproducer. And changing from
NO_PREEMPT to NO_MIGRATE is needed only with
CONFIG_PREEMPT_RT enabled.

>   	u32 size = kattr->test.data_size_in;
>   	struct bpf_flow_dissector ctx = {};
>   	u32 repeat = kattr->test.repeat;
> @@ -1436,7 +1436,7 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
>   int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kattr,
>   				union bpf_attr __user *uattr)
>   {
> -	struct bpf_test_timer t = { NO_PREEMPT };
> +	struct bpf_test_timer t = { NO_MIGRATE };

This change is not needed for the above particular BUG.

>   	struct bpf_prog_array *progs = NULL;
>   	struct bpf_sk_lookup_kern ctx = {};
>   	u32 repeat = kattr->test.repeat;

Checking the git history. I found the earliest NO_PREEMPT usage can be traced
back to this commit:

commit a439184d515fbf4805f57d11fa5dfd4524d2c0eb
Author: Stanislav Fomichev <sdf@google.com>
Date:   Tue Feb 19 10:54:17 2019 -0800

     bpf/test_run: fix unkillable BPF_PROG_TEST_RUN for flow dissector

At that time, migrate_disable/enable() are not used yet.

So I suspect that we can remove NO_PREEMPT/NO_MIGRATE in test_run.c
and use migrate_disable()/migrate_enable() universally.


