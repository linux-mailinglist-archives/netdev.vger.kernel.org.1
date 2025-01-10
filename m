Return-Path: <netdev+bounces-157251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC723A09BA0
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 20:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F69E3A3D53
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 19:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC8924B237;
	Fri, 10 Jan 2025 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TlFyztOW"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EAE24B231
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736536337; cv=none; b=EApsHtCnBDHSgjKjaruA99/OaEB2RLF6vlpGZGC5fEvT2lv3AljxqLqQ5ycZPffnGAiNNWReMXlkv9AxxbvuN54x4C+k5lHpMIHk5IEfGqb5YiFi0y43xOMQ172wimd9LTgIWDicv15futXGWKb0g12bKAzDASEKjoKj9Oq2uX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736536337; c=relaxed/simple;
	bh=LMfLiI1UN36Bx2JhsGNmpDQqVMedWBEwypdHBoYeiiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DkkJYfLNBukmCW6ktt3C2CHYCTuwid+89CfVK47J5r0RSl5z3gpad5rtO/0rfD2Moy38/pxlMv4E7S08LccKHahRcltzUzb0FaaiewipXimUhaP2Iy4aIbNMP5vP/zJYhhAUUoGyZD5kTAP3sa+CQgjzidEbIGiPukKILyD8ha4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TlFyztOW; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a80d4260-08ed-48fe-8c0b-54abf0d99b1f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736536327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JiJVR7aTiRa8hYyQn14NuuvOHpXnBseoVU9+jvHAO7U=;
	b=TlFyztOWe0GuIGszJ6ur16GR76nyXOitulT/sGI2aROgEvnJgLvGKi//22eunPrbXDujuw
	nBz0zdYTXC6OSe7mC4BMv30P1wTrzRYwpU6WSyh73ps1BYW1wI44jKuZG93R5v4DUqG12v
	uDY4GCZGBzJzPb8M0c5JBNc53kSBM1M=
Date: Fri, 10 Jan 2025 11:11:57 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 net] net: restrict SO_REUSEPORT to inet sockets
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com,
 syzbot+b3e02953598f447d4d2a@syzkaller.appspotmail.com,
 Martin KaFai Lau <kafai@fb.com>
References: <20241231160527.3994168-1-edumazet@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241231160527.3994168-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/31/24 8:05 AM, Eric Dumazet wrote:
> After blamed commit, crypto sockets could accidentally be destroyed
> from RCU call back, as spotted by zyzbot [1].
> 
> Trying to acquire a mutex in RCU callback is not allowed.
> 
> Restrict SO_REUSEPORT socket option to inet sockets.
> 
> v1 of this patch supported TCP, UDP and SCTP sockets,
> but fcnal-test.sh test needed RAW and ICMP support.
> 
> [1]
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:562
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 24, name: ksoftirqd/1
> preempt_count: 100, expected: 0
> RCU nest depth: 0, expected: 0
> 1 lock held by ksoftirqd/1/24:
>    #0: ffffffff8e937ba0 (rcu_callback){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
>    #0: ffffffff8e937ba0 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2561 [inline]
>    #0: ffffffff8e937ba0 (rcu_callback){....}-{0:0}, at: rcu_core+0xa37/0x17a0 kernel/rcu/tree.c:2823
> Preemption disabled at:
>   [<ffffffff8161c8c8>] softirq_handle_begin kernel/softirq.c:402 [inline]
>   [<ffffffff8161c8c8>] handle_softirqs+0x128/0x9b0 kernel/softirq.c:537
> CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted 6.13.0-rc3-syzkaller-00174-ga024e377efed #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>   <TASK>
>    __dump_stack lib/dump_stack.c:94 [inline]
>    dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>    __might_resched+0x5d4/0x780 kernel/sched/core.c:8758
>    __mutex_lock_common kernel/locking/mutex.c:562 [inline]
>    __mutex_lock+0x131/0xee0 kernel/locking/mutex.c:735
>    crypto_put_default_null_skcipher+0x18/0x70 crypto/crypto_null.c:179
>    aead_release+0x3d/0x50 crypto/algif_aead.c:489
>    alg_do_release crypto/af_alg.c:118 [inline]
>    alg_sock_destruct+0x86/0xc0 crypto/af_alg.c:502
>    __sk_destruct+0x58/0x5f0 net/core/sock.c:2260
>    rcu_do_batch kernel/rcu/tree.c:2567 [inline]
>    rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
>    handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
>    run_ksoftirqd+0xca/0x130 kernel/softirq.c:950
>    smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
>    kthread+0x2f0/0x390 kernel/kthread.c:389
>    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>   </TASK>
> 
> Fixes: 8c7138b33e5c ("net: Unpublish sk from sk_reuseport_cb before call_rcu")
> Reported-by: syzbot+b3e02953598f447d4d2a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6772f2f4.050a0220.2f3838.04cb.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Martin KaFai Lau <kafai@fb.com>
> ---
>   net/core/sock.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 74729d20cd0099e748f4c4fe0be42a2d2d47e77a..be84885f9290a6ada1e0a3f987273a017a524ece 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1295,7 +1295,10 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>   		sk->sk_reuse = (valbool ? SK_CAN_REUSE : SK_NO_REUSE);
>   		break;
>   	case SO_REUSEPORT:
> -		sk->sk_reuseport = valbool;
> +		if (valbool && !sk_is_inet(sk))
> +			ret = -EOPNOTSUPP;
> +		else
> +			sk->sk_reuseport = valbool;

Thanks for the fix. fwiw,

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>


