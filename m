Return-Path: <netdev+bounces-206475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B04FB0338D
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 02:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D10174E8F
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 00:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AF4184;
	Mon, 14 Jul 2025 00:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="lCGhPuyo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01242E36E7
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 00:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752451469; cv=none; b=qXKxiMJcER86hlWfbLqyAJbLWNvpDVReAJ4f5XB8lRFLFoQeiVkZ+mIODF72FFBuUX1ArdSz8t2TzDmDnXvuUysV8Ax+TjLkE8OJB5Awj8oOZ7p2xdtOsH/SlKZK2yxp8J0PgEEVMHGuur28i57dHEy3VY7oo1iWkPLnDWsAZ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752451469; c=relaxed/simple;
	bh=FSwMxlbo/QGpTFuOPjphnVAsursGgYapqYaDrKTezPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmeSc3IeYxULQBgvgD6ucT+0DWNljIk95QY4lbnMlLf2+JGwbJNoaceg3Is1FZn3vDStu/kTfOouqoTg77mpIHulpKDD91S/biPHxe9r+YXq0VfQ2465QBkZCppQq6yBOmxF+D0kTlS1nZeLiVIL2SuTz8HP5Y2LW/DnMYCTUMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=lCGhPuyo; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313cde344d4so3919278a91.0
        for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 17:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1752451467; x=1753056267; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zSSDOQqFXpLzQoxgAyul5cFWj8aPdAcD36HygUzikz4=;
        b=lCGhPuyoymft1OsHB+bya3jcMb+qsJa3SVKbrFHrHTgb+V2glnfsOWH4IcBpD/hB0J
         gqyqBi2uLqwlQ3BK1J56eX74HL7BD6KBtOM3O+9tV37TjzMYYMbsv0WliPyx5cjlbS35
         7crUCy2FOm9P2tINLJSMgWe5IyqfjWWq7xnvbeN1GaBgltjrjx7blw50GhKQXWN5LiGD
         CqGixIbeQsX6OJzzRhn6/tkuao4iOdu/WFhmFN2YVwnD4bntNUtdJ3/ooK18WC4lfjuE
         yPADGPtUsEkeeR9m6hS2lVqMtp3P52oseeO5JallHzLvTHH14qlWLLxQA11IzqmYOgTj
         KiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752451467; x=1753056267;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSSDOQqFXpLzQoxgAyul5cFWj8aPdAcD36HygUzikz4=;
        b=RLzSe/9iPmTREvArm1OjNJU5mcQbg6+yZjLBsaU36wE4KyD+JxkTu0bKK8IukNZYiZ
         kWMoT/zX0EHnb3sjwGUGigJyUM6khRJgPVjVRi+CPyiFy6e6JZ7RJ6hBAnicGXjk8szy
         i2sQGvl5nKNt1oDZ5l7MnOTHd9Xdkt7L39CBqwMXWWv1ZTVU3SJDn316iYGCNCmUvLpC
         kg1ZB0FBi/TeIwwynhO0K/XRNC7ZmKHvYfZTKcBeDxibQc/lcUx4RkA9CiFL2E/C+N21
         op2gDAkBX5pzT5UrZyQEbG9Cy3ALbUT0XSuKmHgwLqkBAQ2MHDTj3vD5pdOSMLGA5H+X
         6Zdw==
X-Gm-Message-State: AOJu0YzhMgqqu1PrskFoqDmFMDChVlc+QS5I45+/C5Mv2R7NNzirAkJ5
	rLGqMtfiRenGUprcStZUtVsPhgx1266gczKV0MzhM4CRguidXUxGBiHfVi493pCp8g==
X-Gm-Gg: ASbGnctQYSfw/nJBWA9FUaLubez4PTkvO2ZtRFrUZKfpLlaOoErlFWT348EJ9oUzfKZ
	fJzVLTlizk3GUS30nxrOWFWI/YJ4N2WZN7fSPfRQfExdnI6zCGySjHxVavpNXeBn3CYUYKvyjgT
	T6l/fmLXJ+vsg+8ZOuRL8jzgwbBOgF7JrEF/i9l+ih5cUAUdy4qi76HfB/iKCImAgsGCptYZvPt
	Qogk4JTylT+sru0XvRZi5tvV2EN0322+7E739nqGaVxAtuD4csmn01HVfS3843vwbr8O3qAxkue
	INxfvKTZ/f2U67Iu75f4th0zkDFvW6pESZ/CVutNjSdIF5zKnTc7sMvjhezJwwRxFwiPZ4+uUIn
	E0Npn7OSM+PBWCo3SDHS48OxnHf8V6Lcj
X-Google-Smtp-Source: AGHT+IHr+FStFFcgRvUqUcq9XqAFtK/fspDbcRzMs+kXI+FK7/6MoNFhX7ZvB9tjOrtUwLH7iXa/CQ==
X-Received: by 2002:a17:90b:52cd:b0:313:62ee:45a with SMTP id 98e67ed59e1d1-31c4f4cc411mr14460537a91.13.1752451466807;
        Sun, 13 Jul 2025 17:04:26 -0700 (PDT)
Received: from xps (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4350bb0sm88539515ad.205.2025.07.13.17.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:04:26 -0700 (PDT)
Date: Sun, 13 Jul 2025 17:04:24 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, gregkh@linuxfoundation.org, jhs@mojatatu.com,
	jiri@resnulli.us, security@kernel.org
Subject: Re: [PATCH v3] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <aHRJiGLQkLKfaEc8@xps>
References: <20250710100942.1274194-1-xmei5@asu.edu>
 <aHAwoPHQQJvxSiNB@pop-os.localdomain>
 <aHBA6kAmizjIL1B5@xps>
 <aHQltvH5c6+z7DpF@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHQltvH5c6+z7DpF@pop-os.localdomain>

On Sun, Jul 13, 2025 at 02:31:34PM -0700, Cong Wang wrote:
> Hi Xiang,
> 
> It looks like your patch caused the following NULL-ptr-deref. I
> triggered it when running command `./tdc.py -f tc-tests/infra/qdiscs.json`
> 
> Could you take a look? I don't have much time now, since I am still
> finalizing my netem duplicate patches.
> 
> Thanks!
Hi Cong,

I failed to reproduce the attached crash.

Please let me know if I made any mistake while testing:
1) Apply the patch to an lts version ( I used 6.6.97)
2) Enable the KASAN/qfq related configs and compile the kernel
2) `python ./tdc.py -f ./qdiscs.json` to test but I deleted some tests on
the qdisc I didn't compile.


Can you help me with the following three questions?
1) Can we consistently trigger the vulnerability? 
2) What's the instruction that "qfq_dequeue+0x1e4" points to?
3) Is my patch the only applied patch on sch_qfq.c for the crashed kernel?

Thanks,
Xiang

Here is my test result for your ref:
---
(scapyenv) root@pwn:~# python ./tdc.py -f ./qdiscs.json        
 -- ns/SubPlugin.__init__
 -- scapy/SubPlugin.__init__
Test ca5e: Check class delete notification for ffff:
Test e4b7: Check class delete notification for root ffff:
Test 33a9: Check ingress is not searchable on backlog update
Test a4b9: Test class qlen notification
Test a4bb: Test FQ_CODEL with HTB parent - force packet drop with empty queue
Test a4be: Test FQ_CODEL with QFQ parent - force packet drop with empty queue
Test a4bf: Test FQ_CODEL with HFSC parent - force packet drop with empty queue
Test a4c0: Test FQ_CODEL with DRR parent - force packet drop with empty queue
Test a4c3: Test HFSC with netem/blackhole - queue emptying during peek operation
Test 90ec: Test DRR's enqueue reentrant behaviour with netem
Test 5e6d: Test QFQ's enqueue reentrant behaviour with netem
Test bf1d: Test HFSC's enqueue reentrant behaviour with netem
Test 7c3b: Test nested DRR's enqueue reentrant behaviour with netem
Test 62c4: Test HTB with FQ_CODEL - basic functionality
.
Sent 1 packets.
.
Sent 1 packets.
.
Sent 1 packets.
.
Sent 1 packets.
.
Sent 1 packets.
Test 831d: Test HFSC qlen accounting with DRR/NETEM/BLACKHOLE chain
...
> 
> ------------------------------------>
> 
> Test 5e6d: Test QFQ's enqueue reentrant behaviour with netem
> [ 1066.410119] ==================================================================
> [ 1066.411114] BUG: KASAN: null-ptr-deref in qfq_dequeue+0x1e4/0x5a1
> [ 1066.412305] Read of size 8 at addr 0000000000000048 by task ping/945
> [ 1066.413136]
> [ 1066.413426] CPU: 0 UID: 0 PID: 945 Comm: ping Tainted: G        W           6.16.0-rc5+ #542 PREEMPT(voluntary)
> [ 1066.413459] Tainted: [W]=WARN
> [ 1066.413468] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
> [ 1066.413476] Call Trace:
> [ 1066.413499]  <TASK>
> [ 1066.413502]  dump_stack_lvl+0x65/0x90
> [ 1066.413502]  kasan_report+0x85/0xab
> [ 1066.413502]  ? qfq_dequeue+0x1e4/0x5a1
> [ 1066.413502]  qfq_dequeue+0x1e4/0x5a1
> [ 1066.413502]  ? __pfx_qfq_dequeue+0x10/0x10
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? lock_acquired+0xde/0x10b
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? sch_direct_xmit+0x1a7/0x390
> [ 1066.413502]  ? __pfx_sch_direct_xmit+0x10/0x10
> [ 1066.413502]  dequeue_skb+0x411/0x7a8
> [ 1066.413502]  __qdisc_run+0x94/0x193
> [ 1066.413502]  ? __pfx___qdisc_run+0x10/0x10
> [ 1066.413502]  ? find_held_lock+0x2b/0x71
> [ 1066.413502]  ? __dev_xmit_skb+0x27c/0x45e
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? rcu_is_watching+0x1c/0x3c
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? dev_qdisc_enqueue+0x117/0x14c
> [ 1066.413502]  __dev_xmit_skb+0x3b9/0x45e
> [ 1066.413502]  ? __pfx___dev_xmit_skb+0x10/0x10
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? __pfx_rcu_read_lock_bh_held+0x10/0x10
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  __dev_queue_xmit+0xa14/0xbe2
> [ 1066.413502]  ? look_up_lock_class+0xb0/0x10d
> [ 1066.413502]  ? __pfx___dev_queue_xmit+0x10/0x10
> [ 1066.413502]  ? validate_chain+0x4b/0x261
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? __lock_acquire+0x71d/0x7b1
> [ 1066.413502]  ? neigh_resolve_output+0x13b/0x1d7
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? lock_acquire.part.0+0xb0/0x1c6
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? find_held_lock+0x2b/0x71
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? local_clock_noinstr+0x32/0x9c
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? mark_lock+0x6d/0x14d
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? __asan_memcpy+0x38/0x59
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? eth_header+0x92/0xd1
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? neigh_resolve_output+0x188/0x1d7
> [ 1066.413502]  ip_finish_output2+0x58b/0x5c3
> [ 1066.413502]  ip_send_skb+0x25/0x5f
> [ 1066.413502]  raw_sendmsg+0x9dc/0xb60
> [ 1066.413502]  ? __pfx_raw_sendmsg+0x10/0x10
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? stack_trace_save+0x8b/0xbb
> [ 1066.413502]  ? kasan_save_stack+0x1c/0x38
> [ 1066.413502]  ? kasan_record_aux_stack+0x87/0x91
> [ 1066.413502]  ? __might_fault+0x72/0xbe
> [ 1066.413502]  ? __ww_mutex_die.part.0+0xe/0x88
> [ 1066.413502]  ? __might_fault+0x72/0xbe
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? find_held_lock+0x2b/0x71
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? local_clock_noinstr+0x32/0x9c
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? __lock_release.isra.0+0xdb/0x197
> [ 1066.413502]  ? __might_fault+0x72/0xbe
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? inet_send_prepare+0x18/0x5d
> [ 1066.413502]  sock_sendmsg_nosec+0x82/0xe2
> [ 1066.413502]  __sys_sendto+0x175/0x1cc
> [ 1066.413502]  ? __pfx___sys_sendto+0x10/0x10
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? __might_fault+0x72/0xbe
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? local_clock_noinstr+0x32/0x9c
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? __lock_release.isra.0+0xdb/0x197
> [ 1066.413502]  ? __might_fault+0x72/0xbe
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? lock_release+0xde/0x10b
> [ 1066.413502]  ? srso_return_thunk+0x5/0x5f
> [ 1066.413502]  ? __do_sys_gettimeofday+0xb3/0x112
> [ 1066.413502]  __x64_sys_sendto+0x76/0x86
> [ 1066.413502]  do_syscall_64+0x94/0x209
> [ 1066.413502]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 1066.413502] RIP: 0033:0x7fb9f917ce27
> [ 1066.413502] Code: c7 c0 ff ff ff ff eb be 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 80 3d 45 85 0c 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 69 c3 55 48 89 e5 53 48 83 ec 38 44 89 4d d0
> [ 1066.413502] RSP: 002b:00007ffeb9932798 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
> [ 1066.413502] RAX: ffffffffffffffda RBX: 000056476e3550a0 RCX: 00007fb9f917ce27
> [ 1066.413502] RDX: 0000000000000040 RSI: 000056476ea11320 RDI: 0000000000000003
> [ 1066.413502] RBP: 00007ffeb99327e0 R08: 000056476e357320 R09: 0000000000000010
> [ 1066.413502] R10: 0000000000000000 R11: 0000000000000202 R12: 000056476ea11320
> [ 1066.413502] R13: 0000000000000040 R14: 00007ffeb9933e98 R15: 00007ffeb9933e98
> [ 1066.413502]  </TASK>
> [ 1066.413502] ==================================================================
> 

