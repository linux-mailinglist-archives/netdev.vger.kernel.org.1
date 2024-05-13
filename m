Return-Path: <netdev+bounces-95871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A8D8C3B80
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530221F2156B
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 06:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF23626CB;
	Mon, 13 May 2024 06:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="IzfbNO1f"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9A9145FEB
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715582452; cv=none; b=qFh5nUFvAMG8EoPLwqeQfkSKkDLsQb8sGrCEZR8N7nurr47O2SMCGF4utIdfzvTjNeeBWPm+PlLGhd/PDyl7UscyXSDwKNeY51GcISFZJg2G8O2WTuSMNYQymw9Ssf7xU6mmmimBsRsN/Wk4bo2407uZ9imkm3N9iCv1alB9p4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715582452; c=relaxed/simple;
	bh=dgk3FveaLEZ4qbAhZK/LUxX+03pFLoSmpQir+R01ik4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAU6TMK92wfDdTL10CIGF1KZVALJUyBdpHfzcH8fV6DcYJwC+1szmygyn6UC4GLaY1NFZqNjDxKEuHD9CR98+wnViN+1gzx82qDOpYnkwe7rYUG2pbDbLza3FVp6AknIigp9NZfz5hs7xr+GuAAYfMvzatt28swKIIPMG+XZq1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=IzfbNO1f; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s6PMU-00BJuJ-KG; Mon, 13 May 2024 08:40:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=o8FoIHqHyz8ToVZ84VuMJ7sOuL5D0UtxTsaoYm4v+fo=; b=IzfbNO1fZSNKgCDUuz8fXODTA3
	9wwmA+mN0oGxD7JXYtYyMExfp8AV3kYguTJgeMeP/bttIRV37L/x+YKqR6tXiOBaO4NGab4hOPXFq
	xPrK08CHa8soXZMm3SwUsb0GbHB7ypZLHJ8Fv5qwlvvwKXJ8OqTkyHsjogKXCwfzTmfKXW1qHZbi/
	DlU5MZmcvFoYqepmHCPARWs154sg82OdRAy+AZYXo5F8rwk6r7DR5FgJQnmA5gvHYmHnyL+dzjxTb
	zHR3XhjCOBksvvbZgl+shuh13q1747p/e5fMaqLhCk8PUS85whkbaY1O7zlebVoXuW/sNx+3QzLn+
	kQjNT0Dg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s6PMT-00080F-RV; Mon, 13 May 2024 08:40:38 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s6PMR-005oMP-I3; Mon, 13 May 2024 08:40:35 +0200
Message-ID: <a00d3993-c461-43f2-be6d-07259c98509a@rbox.co>
Date: Mon, 13 May 2024 08:40:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] af_unix: Update unix_sk(sk)->oob_skb under
 sk_receive_queue lock.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: billy@starlabs.sg, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <5670c1c4-985d-4e87-9732-ad1cc59bc8db@rbox.co>
 <20240513061244.12229-1-kuniyu@amazon.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20240513061244.12229-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/24 08:12, Kuniyuki Iwashima wrote:
> From: Michal Luczaj <mhal@rbox.co>
> Date: Sun, 12 May 2024 16:47:11 +0200
>> On 5/10/24 11:39, Kuniyuki Iwashima wrote:
>>> @@ -2655,6 +2661,8 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
>>>  		consume_skb(skb);
>>>  		skb = NULL;
>>>  	} else {
>>> +		spin_lock(&sk->sk_receive_queue.lock);
>>> +
>>>  		if (skb == u->oob_skb) {
>>>  			if (copied) {
>>>  				skb = NULL;
>>> @@ -2666,13 +2674,15 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
>>>  			} else if (flags & MSG_PEEK) {
>>>  				skb = NULL;
>>>  			} else {
>>> -				skb_unlink(skb, &sk->sk_receive_queue);
>>> +				__skb_unlink(skb, &sk->sk_receive_queue);
>>>  				WRITE_ONCE(u->oob_skb, NULL);
>>>  				if (!WARN_ON_ONCE(skb_unref(skb)))
>>>  					kfree_skb(skb);
>>>  				skb = skb_peek(&sk->sk_receive_queue);
>>>  			}
>>>  		}
>>> +
>>> +		spin_unlock(&sk->sk_receive_queue.lock);
>>>  	}
>>>  	return skb;
>>>  }
>>
>> Now it is
>>   
>>   spin_lock(&sk->sk_receive_queue.lock)
>>   kfree_skb
> 
> This does not free skb actually and just drops a refcount by skb_get()
> in queue_oob().

I suspect you refer to change in __unix_gc()

 	if (u->oob_skb) {
-		kfree_skb(u->oob_skb);
+		WARN_ON_ONCE(skb_unref(u->oob_skb));
 	}

What I'm talking about is the quoted above (unchanged) part in manage_oob():

	if (!WARN_ON_ONCE(skb_unref(skb)))
  		kfree_skb(skb);

I might be missing something, but

from array import array
from socket import *
a, b = socketpair(AF_UNIX, SOCK_STREAM)
scm = (SOL_SOCKET, SCM_RIGHTS, array("i", [b.fileno()]))
b.sendmsg([b'x'], [scm], MSG_OOB)
b.close()
a.recv(MSG_DONTWAIT)

[   72.513125] ======================================================
[   72.513148] WARNING: possible circular locking dependency detected
[   72.513170] 6.9.0-rc7nokasan+ #25 Not tainted
[   72.513193] ------------------------------------------------------
[   72.513215] python/1054 is trying to acquire lock:
[   72.513237] ffffffff83563898 (unix_gc_lock){+.+.}-{2:2}, at: unix_notinflight+0x23/0x100
[   72.513266]
               but task is already holding lock:
[   72.513288] ffff88811eb10898 (rlock-AF_UNIX){+.+.}-{2:2}, at: unix_stream_read_generic+0x178/0xbc0
[   72.513313]
               which lock already depends on the new lock.

[   72.513336]
               the existing dependency chain (in reverse order) is:
[   72.513358]
               -> #1 (rlock-AF_UNIX){+.+.}-{2:2}:
[   72.513381]        _raw_spin_lock+0x2f/0x40
[   72.513404]        scan_inflight+0x36/0x1e0
[   72.513428]        __unix_gc+0x17c/0x4b0
[   72.513450]        process_one_work+0x217/0x700
[   72.513474]        worker_thread+0x1ca/0x3b0
[   72.513497]        kthread+0xdd/0x110
[   72.513519]        ret_from_fork+0x2d/0x50
[   72.513543]        ret_from_fork_asm+0x1a/0x30
[   72.513565]
               -> #0 (unix_gc_lock){+.+.}-{2:2}:
[   72.513589]        __lock_acquire+0x137b/0x20e0
[   72.513612]        lock_acquire+0xc5/0x2c0
[   72.513635]        _raw_spin_lock+0x2f/0x40
[   72.513657]        unix_notinflight+0x23/0x100
[   72.513680]        unix_destruct_scm+0x95/0xa0
[   72.513702]        skb_release_head_state+0x20/0x60
[   72.513726]        kfree_skb_reason+0x53/0x1e0
[   72.513748]        unix_stream_read_generic+0xb69/0xbc0
[   72.513771]        unix_stream_recvmsg+0x68/0x80
[   72.513794]        sock_recvmsg+0xb9/0xc0
[   72.513817]        __sys_recvfrom+0xa1/0x110
[   72.513840]        __x64_sys_recvfrom+0x20/0x30
[   72.513862]        do_syscall_64+0x93/0x190
[   72.513886]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   72.513909]
               other info that might help us debug this:

[   72.513932]  Possible unsafe locking scenario:

[   72.513954]        CPU0                    CPU1
[   72.513976]        ----                    ----
[   72.513998]   lock(rlock-AF_UNIX);
[   72.514020]                                lock(unix_gc_lock);
[   72.514043]                                lock(rlock-AF_UNIX);
[   72.514066]   lock(unix_gc_lock);
[   72.514088]
                *** DEADLOCK ***

[   72.514110] 3 locks held by python/1054:
[   72.514133]  #0: ffff88811eb10cf0 (&u->iolock){+.+.}-{3:3}, at: unix_stream_read_generic+0xd4/0xbc0
[   72.514158]  #1: ffff88811eb10de0 (&u->lock){+.+.}-{2:2}, at: unix_stream_read_generic+0x110/0xbc0
[   72.514184]  #2: ffff88811eb10898 (rlock-AF_UNIX){+.+.}-{2:2}, at: unix_stream_read_generic+0x178/0xbc0
[   72.514209]
               stack backtrace:
[   72.514231] CPU: 4 PID: 1054 Comm: python Not tainted 6.9.0-rc7nokasan+ #25
[   72.514254] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[   72.514278] Call Trace:
[   72.514300]  <TASK>
[   72.514321]  dump_stack_lvl+0x73/0xb0
[   72.514345]  check_noncircular+0x108/0x120
[   72.514369]  __lock_acquire+0x137b/0x20e0
[   72.514392]  lock_acquire+0xc5/0x2c0
[   72.514415]  ? unix_notinflight+0x23/0x100
[   72.514439]  _raw_spin_lock+0x2f/0x40
[   72.514461]  ? unix_notinflight+0x23/0x100
[   72.514484]  unix_notinflight+0x23/0x100
[   72.514507]  unix_destruct_scm+0x95/0xa0
[   72.514530]  skb_release_head_state+0x20/0x60
[   72.514553]  kfree_skb_reason+0x53/0x1e0
[   72.514575]  unix_stream_read_generic+0xb69/0xbc0
[   72.514600]  unix_stream_recvmsg+0x68/0x80
[   72.514623]  ? __pfx_unix_stream_read_actor+0x10/0x10
[   72.514646]  sock_recvmsg+0xb9/0xc0
[   72.514669]  __sys_recvfrom+0xa1/0x110
[   72.514692]  ? lock_release+0x133/0x290
[   72.514715]  ? syscall_exit_to_user_mode+0x11/0x280
[   72.514739]  ? do_syscall_64+0xa0/0x190
[   72.514762]  __x64_sys_recvfrom+0x20/0x30
[   72.514784]  do_syscall_64+0x93/0x190
[   72.514807]  ? clear_bhb_loop+0x45/0xa0
[   72.514829]  ? clear_bhb_loop+0x45/0xa0
[   72.514852]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   72.514875] RIP: 0033:0x7fc16bb3594d
[   72.514899] Code: 02 02 00 00 00 5d c3 66 0f 1f 44 00 00 f3 0f 1e fa 80 3d 25 8a 0c 00 00 41 89 ca 74 20 45 31 c9 45 31 c0 b8 2d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 6b c3 66 2e 0f 1f 84 00 00 00 00 00 55 48 89
[   72.514925] RSP: 002b:00007fffae4ab2f8 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
[   72.514949] RAX: ffffffffffffffda RBX: 00007fffae4ab3c8 RCX: 00007fc16bb3594d
[   72.514972] RDX: 0000000000000040 RSI: 00007fc15e298f30 RDI: 0000000000000003
[   72.514994] RBP: 00007fffae4ab310 R08: 0000000000000000 R09: 0000000000000000
[   72.515017] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc15e34af90
[   72.515040] R13: 0000000000000000 R14: ffffffffc4653600 R15: 0000000000000000
[   72.515064]  </TASK>

>>     unix_destruct_scm
> 
> So, here we don't reach unix_destruct_scm().
> 
> That's why I changed kfree_skb() to skb_unref() in __unix_gc().
> 
> Thanks!
> 
> 
>>       unix_notinflight
>>         spin_lock(&unix_gc_lock)
>>
>> I.e. sk_receive_queue.lock -> unix_gc_lock, inversion of what unix_gc() does.
>> But that's benign, right?


