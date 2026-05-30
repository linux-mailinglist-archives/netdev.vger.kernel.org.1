Return-Path: <netdev+bounces-293323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OnGM/q3Gmpn7wgAu9opvQ
	(envelope-from <netdev+bounces-293323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 12:12:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FE560C095
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 12:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0450030387A9
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 10:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9138936895D;
	Sat, 30 May 2026 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="az2nvJFl"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D11399036
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780135926; cv=none; b=NYF3opdshQIf6iAkvZrp+moibRJpcT3IJ9PLNk6zK6hDxvhlCDKF6uAHwQu4mY757DCIr41MsH0fOr+U/55IlxYqIyUecrcoDTOLAm/qq1kQIQoMpNt+HzfooXrzvo4uMlp020RCfhBcB9eLGKslNpuMYoVqGN1+3TF7AjDJVH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780135926; c=relaxed/simple;
	bh=ZVpw9b7iySBIlBvNdq3UByr/PyhAr7hc2TVJArzH5MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hraPxy+LV7tinxd9rFSGlb572ehqkB/BJ6jZRdolGREWDpmZgx7ZQF36YERAGT30AvOVFTYPj24SG741E9U/xFVdetkyxiubUzTLWFAVw7w8VFYTko1WnLv5+VvVzWiViYOu2w5YUmzUq/gz4buT9g8nFNE8qgxaUGLsO5zywpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=az2nvJFl; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2e23fe05-6152-41c1-9a37-afae35bc0d6c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780135921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cg3WMgctz68U2WVhip1+prh7ZcPQYzZ+5kUxfiB4kgA=;
	b=az2nvJFlzkFdwDc4/jcOliG2hgOiTT19Xvy+uusovUgFOyV5ySBnIlva94hvwEgd/oSEKt
	eSc67/KUNNuKOdWyWc9aT13uciNmDKo/GvGq7F3B5+P55qgscGXv6FpblNyJVRRbEUSEnS
	Yz8cqeoa21k+20Nbtw3zzWwO+ajFEAk=
Date: Sat, 30 May 2026 18:11:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 net] tcp: Add preempt_{disable,enable}_nested() in
 reqsk_queue_hash_req().
To: Kuniyuki Iwashima <kuniyu@google.com>, Eric Dumazet
 <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 syzbot+e809069bc15f26300526@syzkaller.appspotmail.com
References: <20260530055907.280160-1-kuniyu@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260530055907.280160-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linutronix.de,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-293323-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e809069bc15f26300526];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 09FE560C095
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/30/26 1:59 PM, Kuniyuki Iwashima wrote:
> syzbot reported a weird reqsk->rsk_refcnt underflow in
> __inet_csk_reqsk_queue_drop().
>
> The captured reqsk_put() in __inet_csk_reqsk_queue_drop()
> is called only when it successfully removes reqsk from ehash.
>
> Moreover, reqsk_timer_handler() calls another reqsk_put()
> after that.
>
> This indicates that the reqsk was missing both refcnts for
> ehash and the timer itself.
>
> Since all the syzbot reports had PREEMPT_RT enabled, the only
> possible scenario is that reqsk_queue_hash_req() is preempted
> after mod_timer() and before refcount_set(), and then the timer
> triggered after 1s aborts the reqsk due to its listener's close().
>
> Let's wrap mod_timer() and refcount_set() with
> preempt_disable_nested() and preempt_enable_nested().
>
> Note that inet_ehash_insert() holds the normal spin_lock()
> (mutex in PREEMPT_RT), so it must be called outside of
> preempt_disable_nested(), but this is fine.
>
> The lookup path just ignores 0 sk_refcnt entries in ehash
> and tries to create another reqsk, but this will fail at
> inet_ehash_insert().
>
> [0]:
> refcount_t: underflow; use-after-free.
> WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xb2/0x110 lib/refcount.c:28, CPU#0: ktimers/0/16
> Modules linked in:
> CPU: 0 UID: 0 PID: 16 Comm: ktimers/0 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)}
> Tainted: [L]=SOFTLOCKUP
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
> RIP: 0010:refcount_warn_saturate+0xb2/0x110 lib/refcount.c:28
> Code: e4 7d d1 0a 67 48 0f b9 3a eb 4a e8 38 3d 23 fd 48 8d 3d e1 7d d1 0a 67 48 0f b9 3a eb 37 e8 25 3d 23 fd 48 8d 3d de 7d d1 0a <67> 48 0f b9 3a eb 24 e8 12 3d 23 fd 48 8d 3d db 7d d1 0a 67 48 0f
> RSP: 0000:ffffc90000157948 EFLAGS: 00010246
> RAX: ffffffff84a1301b RBX: 0000000000000003 RCX: ffff88801ca98000
> RDX: 0000000000000100 RSI: 0000000000000000 RDI: ffffffff8f72ae00
> RBP: ffffffff99ae3b01 R08: ffff88801ca98000 R09: 0000000000000005
> R10: 0000000000000100 R11: 0000000000000004 R12: ffff8880425ef568
> R13: ffff8880425ef4f8 R14: ffff8880425ef578 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff888126386000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7b46710e9c CR3: 000000000dbb6000 CR4: 00000000003526f0
> Call Trace:
>   <TASK>
>   __refcount_sub_and_test include/linux/refcount.h:400 [inline]
>   __refcount_dec_and_test include/linux/refcount.h:432 [inline]
>   refcount_dec_and_test include/linux/refcount.h:450 [inline]
>   reqsk_put include/net/request_sock.h:136 [inline]
>   __inet_csk_reqsk_queue_drop+0x3ce/0x440 net/ipv4/inet_connection_sock.c:1007
>   reqsk_timer_handler+0x651/0xdf0 net/ipv4/inet_connection_sock.c:1137
>   call_timer_fn+0x192/0x5e0 kernel/time/timer.c:1748
>   expire_timers kernel/time/timer.c:1799 [inline]
>   __run_timers kernel/time/timer.c:2374 [inline]
>   __run_timer_base+0x6a3/0x9f0 kernel/time/timer.c:2386
>   run_timer_base kernel/time/timer.c:2395 [inline]
>   run_timer_softirq+0x67/0x170 kernel/time/timer.c:2403
>   handle_softirqs+0x1de/0x6d0 kernel/softirq.c:622
>   __do_softirq kernel/softirq.c:656 [inline]
>   run_ktimerd+0x69/0x100 kernel/softirq.c:1151
>   smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
>   kthread+0x388/0x470 kernel/kthread.c:436
>   ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>   </TASK>
>
> Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
> Reported-by: syzbot+e809069bc15f26300526@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a1a7bcf.0a9e871e.332604.000b.GAE@google.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

> ---
>   net/ipv4/inet_connection_sock.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index dbcd37dfdc15..b546ce15ee03 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1145,6 +1145,8 @@ static bool reqsk_queue_hash_req(struct request_sock *req)
>   	if (!inet_ehash_insert(req_to_sk(req), NULL, &found_dup_sk))
>   		return false;
>   
> +	preempt_disable_nested();
> +
>   	/* The timer needs to be setup after a successful insertion. */
>   	req->timeout = tcp_timeout_init((struct sock *)req);
>   	timer_setup(&req->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
> @@ -1155,6 +1157,9 @@ static bool reqsk_queue_hash_req(struct request_sock *req)
>   	 */
>   	smp_wmb();
>   	refcount_set(&req->rsk_refcnt, 2 + 1);
> +
> +	preempt_enable_nested();
> +
>   	return true;
>   }
>   

