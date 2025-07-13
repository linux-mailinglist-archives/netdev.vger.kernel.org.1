Return-Path: <netdev+bounces-206456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CAFB03313
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 23:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62533AAEFC
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 21:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133CF18D656;
	Sun, 13 Jul 2025 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="oXZFE8+8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486EA6EB79
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752442479; cv=none; b=Rp/iXISBJM1YX9NVWuFAJIpOZEI1pcWLNUVueF0eSdXAa5YGc9xKmApwEbrOHfVZPmSmEFF3kcHyrYgj+5sqgocGQssC5Rerfx7Y5zqOU5oxRE29fwdmg8hqgdYI2u850P2DRIPLT6QTjy11y/Sv5n7QBmbAb8vPHcSYNl+C+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752442479; c=relaxed/simple;
	bh=f5XyIDCZAs6EohRnDe2Ex1XUvs+M8A+eDurwEfw6hZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKJzMdvEgGP7+ZERB7ScZ1rr59EyztZ497UA0NEsQW5cO5axCOmexyBz61x7H0ulDf+EoF9/VVk+IcxcxJap3II56F3V/S92Ae6HX2KxlGaKrRRMxWGHFSyPhjUrHZxUiLqYvw2pEE4grfnxJ9OhLzAGq8mUaXJuLNIyZ0obqd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=oXZFE8+8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74b52bf417cso2321821b3a.0
        for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 14:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1752442476; x=1753047276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+ieVun8Ej4ELyATFaGEbVVlUqZR3Z09GjdwfP5GVsI=;
        b=oXZFE8+8AkxoznHojEXITmoIuXvbsh04sfV3r1EAIxzc1Ib9QCmPVIo1ydS6JrJJx8
         8xD/AbgEUpaqNf0q3hHBqe3P12pWmSELnnpPBIxiCO1HT9JLePM2lE1vr6veMR2Syf/z
         DLJNRx2z2BE5E27/y6xI75IcHPG2cgrkBUy0n52qGx2qXejD56ksTT15VQ8VcoYwmDzS
         915Hylx0C7Wt97Tza1ahKf9CxQmaszi++OuQsppIxvJD5357aYXdUQ95iG+V/rjzpoVk
         jIBdc0jLpGKTpDcxUwmAn2LbHAUnWpCb+Nlo19uQ2bzGAgG/wchKel6VgbJWIQpaLO/I
         1p5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752442476; x=1753047276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+ieVun8Ej4ELyATFaGEbVVlUqZR3Z09GjdwfP5GVsI=;
        b=PFE2nDn2SC9SYeqakbHQ/Lx+rgzdEtZaqORch0wxc6Aw6AFprNkc205yvV/wlTdfMo
         9PD20jrmWIdNtm/I9kgp7foo/2JRDXQwmgXfsaTcKzi1nnFGJ6sRoc7VFGVKSsZ1Qsl8
         +4q6dV7PkWW+VK7v0a0pllzt4MP5g6btyhwSXkLafJ6wDEbahKx/az9HL6rSA9Yyw32n
         X9/rXVp+GEbLlA5xvAnP/FYpkF5j79VRlx7FgG6sI36dTkma42sfRRt3egWkK3t3lcr7
         ZTfwlhkdDM8bV3zw0G72SM5+9XB4CjeMtZClDQHAzoV3vsYBAfGH+pIz33jfQkYn2MoT
         Y6jg==
X-Gm-Message-State: AOJu0YwKTT61NfnQ9u5OhObu44bEHoDIfk/ytIcOjrRUYj5ZKiDWP/6x
	DstEgeZ3F6eTv7XbMoyFJ+ahkp/k4UX61g1pMgvZ29ufF8V+0HBBX82BL7GeZeDIRWGTXaXGa5+
	462g=
X-Gm-Gg: ASbGnctMAs2kp8U+820q9rSLNIiUHfWvIxezYMj5kDcAM7XJwX6hzYiVmJ/lKlvKBLi
	mENsuLWBRn5iiLYLEGkALIb7aGoVcYwl4yY2slGHaiXpVYyZse9oLxyPHe6z6GAIwi1HWTriG5x
	ZwL8Y2zfFK7i9d6m2IbUGlv6o91M8q8IMqBUI7VgIlYbYsvfW5w8Ii8BRGgBASrN+UKZLuklNmZ
	fBXLzUXMpyehJMG/uWvpfQamaXu2K7PbqykVI25PjKn7h93x7aG1vrY8UqZKJ7E4t496HvxsRlv
	/hC2rrEsIacduoVNMhlrixiOfjbJA2urhogB0g4pkfqrn9Anj6Ejx2/aL1s6/1YwTtUQmnEvze4
	sNhQFyUAGnt+we19T71trh8jtWQeC9dxQ
X-Google-Smtp-Source: AGHT+IGevlDALFHgLTr1ojtCs9ibgL9eqAEkLT7xSxXqeUGWEAYsCOQw2j11ki3I0z/j9G53fcde0A==
X-Received: by 2002:a05:6a21:6d89:b0:234:dd8d:cc7f with SMTP id adf61e73a8af0-234dd8dcd38mr2369651637.22.1752442476612;
        Sun, 13 Jul 2025 14:34:36 -0700 (PDT)
Received: from xps (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f64c73sm9321320b3a.141.2025.07.13.14.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 14:34:36 -0700 (PDT)
Date: Sun, 13 Jul 2025 14:34:34 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, gregkh@linuxfoundation.org, jhs@mojatatu.com,
	jiri@resnulli.us, security@kernel.org
Subject: Re: [PATCH v3] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <aHQmajPF7eAZw3qi@xps>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Thanks for the information to reproduce. Working on tracing it.
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

