Return-Path: <netdev+bounces-246539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 36471CED97C
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 02:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B457030006C2
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 01:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AB21E5B68;
	Fri,  2 Jan 2026 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="K9ZztDyf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575E21A2C11
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 01:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767317711; cv=none; b=kIG1slnmxpysWmx5/sCQn93bNnrKgtdkWQdAcdcf7UjNMyzF2tAw9hazBgzXk1UQrDKj2ZHThsSr3bpJ4sL+ON/ATUmws4sPrMmcbKhPmAiKCY2DSzTwhkSZW0zFPUqCmB9TH307etoOWBK7zYKpffj/X1b85g5Q23WJjx3NwDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767317711; c=relaxed/simple;
	bh=9nNIM9F1XXM7932VsRbmLczecpbBd6ol5c2MFsFBzys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1iq334q/mdw+bSOKq8G5Othh6cwCIgRR6zheSOCnfINUPttbmOCID2xZUaQzRRceOf0Zcg0OgXnoEYctPssePU4SyUEwNESLc4O+iu6RqzIE0hRXHk6imIe5X4//G+lE47bW8jFstT4TEr3zYM3KEUruS4UgrHC5CYOVRoHSDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=K9ZztDyf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0d06ffa2aso144815205ad.3
        for <netdev@vger.kernel.org>; Thu, 01 Jan 2026 17:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1767317708; x=1767922508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IkzvQVEJ8PAKkvu0ccUwRPk23ExIWvEwnMgvYt9WHpw=;
        b=K9ZztDyf1Utq5QPPp4KMdD6vQY1myibPldQVQIHnB6zwvIlFHZgybKVR8mqUgMu+h8
         x08QVTa/CRoIngVJF1rdxV56+ZeR9xdlJmMb+EXIwevbnp7syCoF1eU//W5negxG3HZ5
         Sy0LvbdDK4QIlC6H2QY5k5Q8WlEon8DSXheohjxr1b8/rdq8EVORdD6DnsIZSPl2WL76
         jc5YmmsRUZ+mHg0hvimmj+zrZz1ICCu9Zgr/+8H+qqSlFuqXvMVuk33SqmSoskcekFvR
         w8F22AUH3HndLPMRq3u2T3Kurt+neOY6KXIdoZew9eWgFH0SpeIS1fBwGn799twJuEbp
         9qyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767317708; x=1767922508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkzvQVEJ8PAKkvu0ccUwRPk23ExIWvEwnMgvYt9WHpw=;
        b=co5pTHl6XsD0/duM4up0E/XdLgV+fR0KA7N6B9Q+dK6m7aVvLV/djyBZLSdWJFo38Y
         n75jt7urOZ2SFJ3qqvZ+x1uy39OSsljcLNvO8zzVAX7n2myjdOCjvfXEYZajEM9fwq3n
         2hsMgk8QP67+cXOWZpZzeR+mJUNU0ZtpyJf1RIAbUg9LD9DwgZ4CzJfOrLY1TtnyWz/J
         dLVmEqx2W4FEEPOUT7u6tVz5+jBjFBMvOp5WxVgE1yr8uIZdKrMYegUUzfQZewZY1Rkp
         x7INlUGBO79EkKhGKTl99Y8YOFrMZgx7Mf0tPbyatY7QbliwEcrm3N5D6jHAARP9cNV9
         07Gg==
X-Gm-Message-State: AOJu0YzGYdMMWNzZ3vAtiRHKYzEThUNZQl6UFOhlnYUGZe8L7B1HuZxh
	p0QYjojZhewXmUooQ+V3gaK8pH65WyxJQfnDfeTRU8LHKtQ5Ji92zRQBQ2ukBxBy/Q==
X-Gm-Gg: AY/fxX44+yDiNNHKNnp++O8fWtXTOs6JGzMl5QRtgW20eLtgF+HcJJb/hUPUfE99dKy
	WDzmi8YrTduIG7n+ZBtF+OcOEui9j2HmPPO6MAYUowgO4SZWbRPxc7dDhocejvMf251Wzo+WZyf
	tBuDcOnxE2lmwpTznfya7hJvOgbO4x0FWj238BxVdoX8Uz0pK8oubb7NVIQ5vqrakmo68vTMVOz
	fdCz4p/f3DUvlnOR2AgG0cW9bcJeoEl3ASeMHFRm3hN3z08W4bw58rWq9B9Sh1YAPcqpXTuGTut
	6uyEdM2oas13/luk1DSP7NaBlB92d04g1dcvlAhwzeB4GOstzs0EOIqW9bYTbKHnjLdCHC0ados
	58l2r7qktXYlcaLDbrHzmWc0heZkyl9NdnIucMwP23SR400fN98yKne++rcUllcdqq1wwpEI5fo
	LoxijbzNPaLeWB+hp2
X-Google-Smtp-Source: AGHT+IG1m1QBlTS5MevJrw+s918/4Xe/Bw3MaHTHQYNpegHTUEsV1YyQvFvVUJEtJr4Ul4CrkKC4pw==
X-Received: by 2002:a05:7022:2520:b0:119:e56b:c753 with SMTP id a92af1059eb24-121722e30e3mr50795935c88.24.1767317708423;
        Thu, 01 Jan 2026 17:35:08 -0800 (PST)
Received: from p1 (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c23csm147728097c88.9.2026.01.01.17.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 17:35:08 -0800 (PST)
Date: Thu, 1 Jan 2026 18:35:06 -0700
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us
Subject: Re: [PATCH net v2] net/sched: sch_qfq: Fix NULL deref when
 deactivating inactive aggregate in qfq_reset
Message-ID: <hvgvn5n45dla46vehvoi63frvkzk7s2wnpbi6l3mrbfl5njk2y@ttfv2gestxf2>
References: <20260102013148.1611988-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102013148.1611988-1-xmei5@asu.edu>

On Thu, Jan 01, 2026 at 06:31:47PM -0700, Xiang Mei wrote:
> `qfq_class->leaf_qdisc->q.qlen > 0` does not imply that the class
> itself is active.
> 
> Two qfq_class objects may point to the same leaf_qdisc. This happens
> when:
> 
> 1. one QFQ qdisc is attached to the dev as the root qdisc, and
> 
> 2. another QFQ qdisc is temporarily referenced (e.g., via qdisc_get()
> / qdisc_put()) and is pending to be destroyed, as in function
> tc_new_tfilter.
> 
> When packets are enqueued through the root QFQ qdisc, the shared
> leaf_qdisc->q.qlen increases. At the same time, the second QFQ
> qdisc triggers qdisc_put and qdisc_destroy: the qdisc enters
> qfq_reset() with its own q->q.qlen == 0, but its class's leaf
> qdisc->q.qlen > 0. Therefore, the qfq_reset would wrongly deactivate
> an inactive aggregate and trigger a null-deref in qfq_deactivate_agg:
> 
> [    0.977749] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KAI
> [    0.978440] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> [    0.978875] CPU: 0 UID: 0 PID: 135 Comm: exploit Not tainted 6.12.57 #3
> [    0.979270] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.or4
> [    0.979913] RIP: qfq_deactivate_agg+0x187/0xca0
> [    0.980200] Code: 00 fc ff df 48 89 fe 48 c1 ee 03 80 3c 16 00 0f 85 1d 09 00 00 48 be 00 00 00 00 00 fc ff df 48 80
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	00 fc                	add    %bh,%ah
>    2:	ff                   	lcall  (bad)
>    3:	df 48 89             	fisttps -0x77(%rax)
>    6:	fe 48 c1             	decb   -0x3f(%rax)
>    9:	ee                   	out    %al,(%dx)
>    a:	03 80 3c 16 00 0f    	add    0xf00163c(%rax),%eax
>   10:	85 1d 09 00 00 48    	test   %ebx,0x48000009(%rip)        # 0x4800001f
>   16:	be 00 00 00 00       	mov    $0x0,%esi
>   1b:	00 fc                	add    %bh,%ah
>   1d:	ff                   	lcall  (bad)
>   1e:	df 48 80             	fisttps -0x80(%rax)
> [    0.981234] RSP: 0018:ffff8880106d73f8 EFLAGS: 00010246
> [    0.981517] RAX: 0000000000000000 RBX: ffff88800c518000 RCX: ffff888010bc1358
> [    0.981943] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000000
> [    0.982336] RBP: ffff888010bc1340 R08: ffff88800c518158 R09: ffff88800c518158
> [    0.982734] R10: 1ffff110018a302c R11: ffffffff89689156 R12: 0000000000000000
> [    0.983140] R13: ffff888010bc0180 R14: 0000000000000000 R15: ffff888010bc1350
> [    0.983521] FS:  0000000009737380(0000) GS:ffff8880bf000000(0000) knlGS:0000000000000000
> [    0.983955] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.984270] CR2: 00000000097c1000 CR3: 000000000ee7c004 CR4: 0000000000772ef0
> [    0.984654] PKRU: 55555554
> [    0.984804] Call Trace:
> [    0.984957]  <TASK>
> [    0.985084]  qfq_reset_qdisc+0x27c/0x3e0
> [    0.985316]  ? __pfx_mutex_lock+0x10/0x10
> [    0.985541]  qdisc_reset+0x9d/0x590
> [    0.985736]  ? __tcf_block_put+0x2e/0x2b0
> [    0.985980]  ? __pfx_mutex_unlock+0x10/0x10
> [    0.986237]  ? __tcf_chain_put+0x4a/0x880
> [    0.986465]  __qdisc_destroy+0xb2/0x280
> [    0.986686]  tc_new_tfilter+0x9af/0x2180
> [    0.986932]  ? __pfx_stack_trace_consume_entry+0x10/0x10
> [    0.987216]  ? __pfx_stack_trace_consume_entry+0x10/0x10
> [    0.987505]  ? __pfx_tc_new_tfilter+0x10/0x10
> [    0.987755]  ? unwind_get_return_address+0x5e/0xa0
> [    0.988025]  ? arch_stack_walk+0xac/0x100
> [    0.988241]  ? stack_depot_save_flags+0x29/0x7e0
> [    0.988506]  ? stack_trace_save+0x94/0xd0
> [    0.988722]  ? security_capable+0xda/0x160
> [    0.988970]  rtnetlink_rcv_msg+0x543/0xc50
> [    0.989204]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> [    0.989458]  netlink_rcv_skb+0x134/0x370
> [    0.989676]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> [    0.989951]  ? __pfx_netlink_rcv_skb+0x10/0x10
> [    0.990190]  ? __pfx___netlink_lookup+0x10/0x10
> [    0.990440]  ? kasan_save_track+0x14/0x30
> [    0.990659]  ? _copy_from_iter+0x214/0x1100
> [    0.990886]  netlink_unicast+0x6db/0xa20
> [    0.991116]  ? __pfx_netlink_unicast+0x10/0x10
> [    0.991355]  ? unwind_get_return_address+0x5e/0xa0
> [    0.991616]  ? arch_stack_walk+0xac/0x100
> [    0.991854]  ? __check_object_size+0x46c/0x690
> [    0.992091]  netlink_sendmsg+0x72b/0xbd0
> [    0.992301]  ? __pfx_netlink_sendmsg+0x10/0x10
> [    0.992545]  ? __pfx_aa_file_perm+0x10/0x10
> [    0.992793]  sock_write_iter+0x489/0x560
> [    0.993043]  ? kmem_cache_free+0x249/0x4b0
> [    0.993282]  ? __pfx_sock_write_iter+0x10/0x10
> [    0.993565]  ? security_file_permission+0x7e/0xe0
> [    0.993922]  ? rw_verify_area+0x70/0x4d0
> [    0.994192]  vfs_write+0x930/0xea0
> [    0.994439]  ? __pfx_vfs_write+0x10/0x10
> [    0.994642]  ? fdget_pos+0x57/0x4f0
> [    0.994810]  ? __call_rcu_common.constprop.0+0x247/0x7a0
> [    0.995105]  ksys_write+0x17c/0x1d0
> [    0.995290]  ? __pfx_ksys_write+0x10/0x10
> [    0.995511]  ? __x64_sys_close+0x7c/0xd0
> [    0.995732]  do_syscall_64+0x58/0x120
> [    0.995959]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    0.996233] RIP: 0033:0x424c34
> [    0.996397] Code: 89 02 48 c7 c0 ff ff ff ff eb bd 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 80 3d 2d 44 09 00 09
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	89 02                	mov    %eax,(%rdx)
>    2:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
>    9:	eb bd                	jmp    0xffffffffffffffc8
>    b:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
>   12:	00 00 00
>   15:	90                   	nop
>   16:	f3 0f 1e fa          	endbr64
>   1a:	80 3d 2d 44 09 00 09 	cmpb   $0x9,0x9442d(%rip)        # 0x9444e
> [    0.997360] RSP: 002b:00007ffea27af418 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> [    0.997746] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000424c34
> [    0.998123] RDX: 000000000000003c RSI: 00000000097bf5d0 RDI: 0000000000000003
> [    0.998495] RBP: 00007ffea27af460 R08: 0000000000000000 R09: 0000000000000000
> [    0.998862] R10: 0000000000000001 R11: 0000000000000202 R12: 00007ffea27af5c8
> [    0.999224] R13: 00007ffea27af5d8 R14: 00000000004b3828 R15: 0000000000000001
> [    0.999592]  </TASK>
> [    0.999711] Modules linked in:
> [    0.999899] ---[ end trace 0000000000000000 ]---
> [    1.000143] RIP: qfq_deactivate_agg+0x187/0xca0
> [    1.000396] Code: 00 fc ff df 48 89 fe 48 c1 ee 03 80 3c 16 00 0f 85 1d 09 00 00 48 be 00 00 00 00 00 fc ff df 48 80
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	00 fc                	add    %bh,%ah
>    2:	ff                   	lcall  (bad)
>    3:	df 48 89             	fisttps -0x77(%rax)
>    6:	fe 48 c1             	decb   -0x3f(%rax)
>    9:	ee                   	out    %al,(%dx)
>    a:	03 80 3c 16 00 0f    	add    0xf00163c(%rax),%eax
>   10:	85 1d 09 00 00 48    	test   %ebx,0x48000009(%rip)        # 0x4800001f
>   16:	be 00 00 00 00       	mov    $0x0,%esi
>   1b:	00 fc                	add    %bh,%ah
>   1d:	ff                   	lcall  (bad)
>   1e:	df 48 80             	fisttps -0x80(%rax)
> [    1.001456] RSP: 0018:ffff8880106d73f8 EFLAGS: 00010246
> [    1.001735] RAX: 0000000000000000 RBX: ffff88800c518000 RCX: ffff888010bc1358
> [    1.002107] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: 0000000000000000
> [    1.002478] RBP: ffff888010bc1340 R08: ffff88800c518158 R09: ffff88800c518158
> [    1.002853] R10: 1ffff110018a302c R11: ffffffff89689156 R12: 0000000000000000
> [    1.003204] R13: ffff888010bc0180 R14: 0000000000000000 R15: ffff888010bc1350
> [    1.003559] FS:  0000000009737380(0000) GS:ffff8880bf000000(0000) knlGS:0000000000000000
> [    1.003962] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.004243] CR2: 00000000097c1000 CR3: 000000000ee7c004 CR4: 0000000000772ef0
> [    1.004599] PKRU: 55555554
> [    1.004740] Kernel panic - not syncing: Fatal exception
> [    1.005071] Kernel Offset: disabled
> 
> Fixes: 0545a3037773 ("pkt_sched: QFQ - quick fair queue scheduler")
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v2: attach the crash information to the commit message
> 
>  net/sched/sch_qfq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index d920f57dc6d7..f4013b547438 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -1481,7 +1481,7 @@ static void qfq_reset_qdisc(struct Qdisc *sch)
>  
>  	for (i = 0; i < q->clhash.hashsize; i++) {
>  		hlist_for_each_entry(cl, &q->clhash.hash[i], common.hnode) {
> -			if (cl->qdisc->q.qlen > 0)
> +			if (cl_is_active(cl))
>  				qfq_deactivate_class(q, cl);
>  
>  			qdisc_reset(cl->qdisc);
> -- 
> 2.43.0
>

Sorry for the delay of update.

For the new version of patch, I attached the crash infomation decoded from
scripts/decode_stacktrace.sh.

Thanks,
Xiang

