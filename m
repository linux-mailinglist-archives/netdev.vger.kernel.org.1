Return-Path: <netdev+bounces-193963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C251AC6A3E
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 15:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D3C3A4FF5
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 13:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B27286436;
	Wed, 28 May 2025 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpevJkS+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB0723CB
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438495; cv=none; b=FwDsTR6v9JPelEa0Pqh4EaGnAjKa1SeST+1xldlQWnzMAUPV7ZfLHAUG4gcpJ3miV4q5+lQnYAmm5bB7nQlZJEtgGh8AuSt3CrTCg/SJFkbWb0ethJCWTI1OM1+kR3s6gbtHZ+VKQH0Q3YbsYv/kB682ka7E1zJdc5rXWIEWsnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438495; c=relaxed/simple;
	bh=w4V16qKfiT/pfb33VeL2Ot8WRygh5P0v+koJl1kpkpw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=b7FUh4ETZCsZ5i9vSeD3ttCY/6epvHCR51jyvtAbQWlPvDxQN+Xxh6mF6yoSobmKSjtCPc9C58zaWppBp7qMk9uPluJu+l7No7MlciV2BKBUwQDhfkTVuPzDNsbQFEndIxM+ZsFuS6B3Uqk+9ijxmubk3eSup0yo/c9O+Sachsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TpevJkS+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748438490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9IilaNKUDVQzShrd4qulsnfBXBNE4mTtv8Dgcg+HKl0=;
	b=TpevJkS+aB2orSG3WuEJ3WCNuTMJyqUTgRXujZ2OTt0j7A6lEjYBBqsL4UEi/a5Xl4WmS6
	nRZypRfqRCbczVNWRkCKGgLqRNYD5gZ/75XjPtr5ny/qDGQQW2Nx2YIiTZGcjB/4EMB20N
	htUpaZ5TEfp/G/XVWQU3C3Ie08tN+0o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-G8kFhOmrNLS7yXql3xOgcA-1; Wed, 28 May 2025 09:21:24 -0400
X-MC-Unique: G8kFhOmrNLS7yXql3xOgcA-1
X-Mimecast-MFC-AGG-ID: G8kFhOmrNLS7yXql3xOgcA_1748438478
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-441d438a9b7so4482625e9.1
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 06:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748438477; x=1749043277;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IilaNKUDVQzShrd4qulsnfBXBNE4mTtv8Dgcg+HKl0=;
        b=pqlsgosGcnzK5geNBoT7oBdJR+Cr9I2RdFQgJssbQU044lSv7Q+4GSGegDQtEm17n1
         ffggkMyJzICPajqrTj/5jrT1ktzC84e47ljka332AXVlt3230FpXhgC7Srf+Ggc50N6e
         rBbDT4MWq7p/xbtj12NpRklpLyTBB1wkKd4zdFpo7nJwSkGl2TsvlBHnvkZxxpMWlE79
         m4IuiHVO2DI8Zth+Z2vjJWmMCKBwHQMzfA+ENUh+3Z4WSPQOmFzdPLfv/Jcxku+2VTlU
         T49s3W3zcT7aAxtw0gGlU/3IuBLTM71mObB/5Y0Op5JcPFCvPnQsQClhYXMsOW6elS/J
         eEVw==
X-Forwarded-Encrypted: i=1; AJvYcCXaqJLs03PnBlzCuxOSVQXpfX/gIT3TUMTCvyI3t5+rIrBaRhneMI5f8ijyjLUScwawmrxwAbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqiwvte/rFJEgvN6Jrt3YUQm0UyvjGCZwBhAkiIEu/Hit0M68Y
	UbGIBt06rRj+rwZtC/6ji5e6c4drFxUsfP8dSaz0RiwMoIWqqz5md/j1XAL5sRFYBWxnx//S27b
	1d6KFXw7iy5FmA+jnJeBBIn7z+eZxCTBBr7XbMl0MxfwGZ8/dt0O4yicyho2ZSm0xtg==
X-Gm-Gg: ASbGncvyipPBWU1hdA7CIHh9cUpKNo9MfsmwjCK3dgHJmYYUUCA4tPqydmM+i2xxUJT
	2WMErZjBAOrVRwfeobLkYwFq7Xl9XJqiEfXc1czOejNGMrWnvqEUN7fMkVpbCO8ym7cKErsLctW
	e9v91AKEz6C980RNSKLEpaR0r1Tm94bVmvS0FSlj0hrVm9W/Pi3lP/6tzj1gmlbKwBU6/sS6mR6
	9PQc9kg6vPoZQzFJxv5VwHHQoi7Py43HeOq/8bKBMkSwlBuu0cpkN4DSdPz4lZjIBH9hPNaFvRY
	s0YoFdljDVA4t2CG0Yk=
X-Received: by 2002:a05:600c:6818:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-44fd1a01b05mr41249585e9.3.1748438476984;
        Wed, 28 May 2025 06:21:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNRqeJWxAYb4d/uP6uNJJA29WOzwYZ3SbWOY1VF25DkwMvL9KL3RxLrQ5SgGHYKIKphAgv3Q==
X-Received: by 2002:a05:600c:6818:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-44fd1a01b05mr41249195e9.3.1748438476475;
        Wed, 28 May 2025 06:21:16 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eac7e919sm1512120f8f.33.2025.05.28.06.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 06:21:15 -0700 (PDT)
Message-ID: <03fa2753-a120-4be0-adfe-8a41d0794f64@redhat.com>
Date: Wed, 28 May 2025 15:21:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 0/9] af_unix: Introduce SO_PASSRIGHTS.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20250519205820.66184-1-kuniyu@amazon.com>
 <f99f4631-f58b-425d-b671-717b63bb45f3@redhat.com>
Content-Language: en-US
In-Reply-To: <f99f4631-f58b-425d-b671-717b63bb45f3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/25 1:40 PM, Paolo Abeni wrote:
> On 5/19/25 10:57 PM, Kuniyuki Iwashima wrote:
>> As long as recvmsg() or recvmmsg() is used with cmsg, it is not
>> possible to avoid receiving file descriptors via SCM_RIGHTS.
>>
>> This series introduces a new socket option, SO_PASSRIGHTS, to allow
>> disabling SCM_RIGHTS.  The option is enabled by default.
>>
>> See patch 8 for background/context.
>>
>> This series is related to [0], but is split into a separate series,
>> as most of the patches are specific to af_unix.
>>
>> The v2 of the BPF LSM extension part will be posted later, once
>> this series is merged into net-next and has landed in bpf-next.
>>
>> [0]: https://lore.kernel.org/bpf/20250505215802.48449-1-kuniyu@amazon.com/
> 
> While booting a debug linus's tree with current net-next merged in, I
> see a few splat at boot time:
> 
> [    4.556951] refcount_t: underflow; use-after-free.
> [    4.557466] WARNING: CPU: 0 PID: 1 at lib/refcount.c:28
> refcount_warn_saturate+0xae/0x150
> [    4.558351] Modules linked in:
> [    4.558692] CPU: 0 UID: 0 PID: 1 Comm: systemd Tainted: G    B
>        6.15.0.net-next-6.16_0b31b995f034+ #3 PREEMPT(voluntary)
> [    4.559887] Tainted: [B]=BAD_PAGE
> [    4.560246] Hardware name: Red Hat KVM/RHEL, BIOS 1.16.3-2.el9 04/01/2014
> [    4.560913] RIP: 0010:refcount_warn_saturate+0xae/0x150
> [    4.561443] Code: c3 22 a3 03 01 e8 62 de df fe 0f 0b eb d1 80 3d b1
> 22 a3 03 00 75 c8 48 c7 c7 a0 77 73 b4 c6 05 a1 22 a3 03 01 e8 42 de df
> fe <0f> 0b eb b1 80 3d 8f 22 a3 03 00 75 a8 48 c7 c7 60 78 73 b4 c6 05
> [    4.563167] RSP: 0018:ffa000000001fac0 EFLAGS: 00010286
> [    4.563708] RAX: 0000000000000000 RBX: ff11000129544680 RCX:
> 0000000000000000
> [    4.564401] RDX: 0000000000000002 RSI: 0000000000000004 RDI:
> 0000000000000001
> [    4.565110] RBP: 0000000000000003 R08: 0000000000000001 R09:
> ffe21c002b27d8b1
> [    4.565817] R10: ff110001593ec58b R11: 0000000000000000 R12:
> ff11000129544600
> [    4.566511] R13: ff11000129542bc0 R14: 0000000000000001 R15:
> ff11000129542c40
> [    4.567216] FS:  00007f2c798deb40(0000) GS:ff110001a1bb3000(0000)
> knlGS:0000000000000000
> [    4.568005] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.568579] CR2: 000055c3cefb01d8 CR3: 0000000120b4c003 CR4:
> 0000000000771ef0
> [    4.569287] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [    4.569991] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7:
> 0000000000000400
> [    4.570688] PKRU: 55555554
> [    4.571005] Call Trace:
> [    4.571285]  <TASK>
> [    4.571538]  unix_release_sock+0x9ee/0x1040
> [    4.571984]  ? rcu_is_watching+0x11/0xb0
> [    4.572398]  ? __pfx_unix_release_sock+0x10/0x10
> [    4.572881]  ? down_write+0xb4/0x220
> [    4.573268]  ? __pfx_down_write+0x10/0x10
> [    4.573687]  unix_release+0x88/0xe0
> [    4.574074]  __sock_release+0xa3/0x260
> [    4.574474]  sock_close+0x14/0x20
> [    4.574842]  __fput+0x365/0xa80
> [    4.575197]  fput_close_sync+0xd9/0x190
> [    4.575599]  ? __pfx_fput_close_sync+0x10/0x10
> [    4.576072]  __x64_sys_close+0x79/0xd0
> [    4.576469]  do_syscall_64+0x8c/0x3d0
> [    4.576873]  ? __pfx___handle_mm_fault+0x10/0x10
> [    4.577354]  ? lock_release+0x121/0x190
> [    4.577774]  ? rcu_is_watching+0x11/0xb0
> [    4.578188]  ? __count_memcg_events+0x45c/0x5c0
> [    4.578654]  ? count_memcg_events_mm.constprop.0+0xd4/0x200
> [    4.579275]  ? rcu_is_watching+0x11/0xb0
> [    4.579683]  ? lock_release+0x121/0x190
> [    4.580100]  ? count_memcg_events_mm.constprop.0+0xd9/0x200
> [    4.580658]  ? handle_mm_fault+0x3cf/0x670
> [    4.581099]  ? exc_page_fault+0x58/0xc0
> [    4.581505]  ? rcu_is_watching+0x11/0xb0
> [    4.581925]  ? lock_release+0x121/0x190
> [    4.582345]  ? do_user_addr_fault+0x489/0xb10
> [    4.582806]  ? rcu_is_watching+0x11/0xb0
> [    4.583221]  ? trace_irq_enable.constprop.0+0x14a/0x1b0
>     4.583758]  ? clear_bhb_loop+0x60/0xb0
> [    4.584165]  ? clear_bhb_loop+0x60/0xb0
> [    4.584574]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    4.585095] RIP: 0033:0x7f2c7a638417
> [    4.585471] Code: ff e8 2d f6 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f
> 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f
> 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 a3 7e f8 ff
> [    4.587182] RSP: 002b:00007ffc7c624c58 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000003
> [    4.587921] RAX: ffffffffffffffda RBX: 00007f2c798de9d0 RCX:
> 00007f2c7a638417
> [    4.588611] RDX: 000055c3cefcfeb0 RSI: 000055c3cef580c0 RDI:
> 0000000000000026
> [    4.589318] RBP: 0000000000000026 R08: 00000000ffffffff R09:
> 0000000000000000
> [    4.590019] R10: 0000000000000010 R11: 0000000000000246 R12:
> 000055c3cef54a10
> [    4.590715] R13: 0000000000000000 R14: 00007ffc7c624db0 R15:
> 000055c3cef57cc0
> [    4.591408]  </TASK>
> [    4.591665] irq event stamp: 25199
> [    4.592044] hardirqs last  enabled at (25199): [<ffffffffb1600e06>]
> asm_sysvec_apic_timer_interrupt+0x16/0x20
> [    4.592986] hardirqs last disabled at (25198): [<ffffffffb1a1df63>]
> handle_softirqs+0x733/0x920
> [    4.593824] softirqs last  enabled at (24848): [<ffffffffb1a1de28>]
> handle_softirqs+0x5f8/0x920
> [    4.594651] softirqs last disabled at (24843): [<ffffffffb1a1e2fb>]
> __irq_exit_rcu+0x11b/0x270
> 
> I'm going to blindly test a local revert of this series and/or
> a9194f88782afa1386641451a6c76beaa60485a0 and will report back.

The root cause was bad conflicts resolution on my side :/
Just ignore the above, I'm sorry for the noise.

Paolo


