Return-Path: <netdev+bounces-97733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F6E8CCF18
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 11:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46E11C22504
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 09:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E2313D26E;
	Thu, 23 May 2024 09:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Pse96kh6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B2613D272
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456043; cv=none; b=E+Uqhfy3HWf5Pe9R8C/3K3mEWt7WCJbTPeT7uJNWbKS1P5xGizexXawc+hPvcZWIV/bi3zbj0pxmjPhvbeA/+UJT9yPkRv05xyiwj5s5zxLHYRSfWwj7Z5cgvI7zjTHAgmnBYqUJXV+OChZXdIZE2kJBk5gNK9We63lSIDSEEZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456043; c=relaxed/simple;
	bh=94d5/oSqTkvjD/KY6c2YVR9F9k2BN2fRmDjJ39wq5Sg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jt5FxAetBErJZQRIPDt66upnzvgDVDg6lQy887/YBs0dHlA5af46yYNXpy3fG+TZoDsNL/gbTox7Tolz13NTSm9TucFVawawx0SBrXY5mVfKAPQ9CDecSTAL7OnUigF7H6ihFGAoGxQDueEzNq9GFWNRvkT9QqdbFpYucJU3WJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Pse96kh6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5a7d28555bso1153554266b.1
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 02:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716456038; x=1717060838; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QK9RuoYhlxelHJ6udsAT+Znd+osUJmMprr3f23XbBpA=;
        b=Pse96kh6N/z56o6vuy6CmaVa4OeReakHJywIP+v1CTMcOcxnX4M9VyPh6o5OKZJCSY
         /RbhmBn/1VhF7uomYnhfpOhFE9Fiw+z7AeNxeuBV1JbHDHb6GP053eSvlwBfCcWRKiWL
         CzngLQ+twF9pCgOHrIs2XHhNKgwI7nqf2vZmB2a6JpGZXy/kp+E6WdCNXIaO9snu3phk
         Tj15LMg88p1l3iK3UZSNXNib0oyDHBkqGG6+u+GrJt7j2luPPLdXD6ivb/viTzDH9vMl
         37GoiPK3WRE+AybMN644C9Bns766RxuAxxKGqUL+BaHdL8rrD7ssz7WucznuVP2+yNnL
         GeSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716456038; x=1717060838;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QK9RuoYhlxelHJ6udsAT+Znd+osUJmMprr3f23XbBpA=;
        b=pPUwgqrBLw40vd7Yw5SxK9kkXYSfdf+Ls68WWQldZB8Ke6Xq1athai6aI7LnffnjBS
         hGzcUvFhOPUNsB84NmBbOdhNA9/ykMG4b+1figxsUjxnWmR6ABZo9h6w4gHKGXS9ARd0
         q1yWdVGtUYl26nwDrrlBiAe284El/OElGAtbCr3ZUfVv3tfPo3TiCURYR5uU2FbtmV9s
         3+fOuwnTv1QIf7WEzaquXRHnkhXqivoAMtmUXqt9bRG81j2VCZ3H2cbE1iluZ7SMrhP4
         AXKycNCJYvhyDZ3dVwD0TaO04Pjuz8/Z1mMPSvgg7LHpk8+TXmx5dQqABVMWrRM2bom7
         sM4g==
X-Forwarded-Encrypted: i=1; AJvYcCVpxK0Hk1UnjImHefHRycQlXxigzBQYzNUyvVu9mwRheN501rz2r8fsejWAjfsnNX5+f/IwDNMO7qsP9OOYZRB6Lj9HE9nN
X-Gm-Message-State: AOJu0Yxh/6dGN6QcQInrKowMzzpaDAzW3TLNPK6dBEp/uZ45TmAzmTkL
	CcBuAbQ15Hwrf+ZBVta+ZObyJfj+zNVJYA78FvhzpefIqUrfzBx6CAGsH3kRE6I=
X-Google-Smtp-Source: AGHT+IHaRRUmk9/ojesCZSw0pu6t7iLCgemv1oVsaVm6FEiJHVFVYXktX1PcNEw1MSrfPMXMUW+h/w==
X-Received: by 2002:a17:906:c795:b0:a59:9ef3:f6df with SMTP id a640c23a62f3a-a6228095499mr299640666b.22.1716456038411;
        Thu, 23 May 2024 02:20:38 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179263d9sm1919803366b.95.2024.05.23.02.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 02:20:36 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
  netdev@vger.kernel.org,  Cong Wang <cong.wang@bytedance.com>,  Eric
 Dumazet <edumazet@google.com>,  Daniel Borkmann <daniel@iogearbox.net>,
  John Fastabend <john.fastabend@gmail.com>,  "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  bpf@vger.kernel.org,
  kernel-dev@igalia.com,
  syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com,
  stable@vger.kernel.org
Subject: Re: [PATCH net] sock_map: avoid race between sock_map_close and
 sk_psock_put
In-Reply-To: <58032b8049696566704e1941f909159a2f6c9af8.camel@redhat.com>
	(Paolo Abeni's message of "Thu, 23 May 2024 09:52:45 +0200")
References: <20240520214153.847619-1-cascardo@igalia.com>
	<13b77d180c2bad74d6749a6c34190a10134bd6fa.camel@redhat.com>
	<58032b8049696566704e1941f909159a2f6c9af8.camel@redhat.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Thu, 23 May 2024 11:20:34 +0200
Message-ID: <87h6eox4t9.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 23, 2024 at 09:52 AM +02, Paolo Abeni wrote:
> On Wed, 2024-05-22 at 14:08 +0200, Paolo Abeni wrote:
>> On Mon, 2024-05-20 at 18:41 -0300, Thadeu Lima de Souza Cascardo wrote:
>> > sk_psock_get will return NULL if the refcount of psock has gone to 0, which
>> > will happen when the last call of sk_psock_put is done. However,
>> > sk_psock_drop may not have finished yet, so the close callback will still
>> > point to sock_map_close despite psock being NULL.
>> > 
>> > This can be reproduced with a thread deleting an element from the sock map,
>> > while the second one creates a socket, adds it to the map and closes it.
>> > 
>> > That will trigger the WARN_ON_ONCE:
>> > 
>> > ------------[ cut here ]------------
>> > WARNING: CPU: 1 PID: 7220 at net/core/sock_map.c:1701 sock_map_close+0x2a2/0x2d0 net/core/sock_map.c:1701
>> > Modules linked in:
>> > CPU: 1 PID: 7220 Comm: syz-executor380 Not tainted 6.9.0-syzkaller-07726-g3c999d1ae3c7 #0
>> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
>> > RIP: 0010:sock_map_close+0x2a2/0x2d0 net/core/sock_map.c:1701
>> > Code: df e8 92 29 88 f8 48 8b 1b 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 79 29 88 f8 4c 8b 23 eb 89 e8 4f 15 23 f8 90 <0f> 0b 90 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d e9 13 26 3d 02
>> > RSP: 0018:ffffc9000441fda8 EFLAGS: 00010293
>> > RAX: ffffffff89731ae1 RBX: ffffffff94b87540 RCX: ffff888029470000
>> > RDX: 0000000000000000 RSI: ffffffff8bcab5c0 RDI: ffffffff8c1faba0
>> > RBP: 0000000000000000 R08: ffffffff92f9b61f R09: 1ffffffff25f36c3
>> > R10: dffffc0000000000 R11: fffffbfff25f36c4 R12: ffffffff89731840
>> > R13: ffff88804b587000 R14: ffff88804b587000 R15: ffffffff89731870
>> > FS:  000055555e080380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
>> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > CR2: 0000000000000000 CR3: 00000000207d4000 CR4: 0000000000350ef0
>> > Call Trace:
>> >  <TASK>
>> >  unix_release+0x87/0xc0 net/unix/af_unix.c:1048
>> >  __sock_release net/socket.c:659 [inline]
>> >  sock_close+0xbe/0x240 net/socket.c:1421
>> >  __fput+0x42b/0x8a0 fs/file_table.c:422
>> >  __do_sys_close fs/open.c:1556 [inline]
>> >  __se_sys_close fs/open.c:1541 [inline]
>> >  __x64_sys_close+0x7f/0x110 fs/open.c:1541
>> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>> >  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> > RIP: 0033:0x7fb37d618070
>> > Code: 00 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d4 e8 10 2c 00 00 80 3d 31 f0 07 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
>> > RSP: 002b:00007ffcd4a525d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
>> > RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fb37d618070
>> > RDX: 0000000000000010 RSI: 00000000200001c0 RDI: 0000000000000004
>> > RBP: 0000000000000000 R08: 0000000100000000 R09: 0000000100000000
>> > R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
>> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>> >  </TASK>
>> > 
>> > Use sk_psock, which will only check that the pointer is not been set to
>> > NULL yet, which should only happen after the callbacks are restored. If,
>> > then, a reference can still be gotten, we may call sk_psock_stop and cancel
>> > psock->work.
>> > 
>> > After that change, the reproducer does not trigger the WARN_ON_ONCE
>> > anymore.
>> > 
>> > Reported-by: syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com
>> > Closes: https://syzkaller.appspot.com/bug?extid=07a2e4a1a57118ef7355
>> > Fixes: aadb2bb83ff7 ("sock_map: Fix a potential use-after-free in sock_map_close()")
>> > Fixes: 5b4a79ba65a1 ("bpf, sockmap: Don't let sock_map_{close,destroy,unhash} call itself")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>> > ---
>> >  net/core/sock_map.c | 14 +++++++++-----
>> >  1 file changed, 9 insertions(+), 5 deletions(-)
>> > 
>> > diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>> > index 9402889840bf..13267e667a4c 100644
>> > --- a/net/core/sock_map.c
>> > +++ b/net/core/sock_map.c
>> > @@ -1680,19 +1680,23 @@ void sock_map_close(struct sock *sk, long timeout)
>> >  
>> >  	lock_sock(sk);
>> >  	rcu_read_lock();
>> > -	psock = sk_psock_get(sk);
>> > +	psock = sk_psock(sk);
>> >  	if (unlikely(!psock)) {
>> > +		saved_close = READ_ONCE(sk->sk_prot)->close;
>> >  		rcu_read_unlock();
>> >  		release_sock(sk);
>> > -		saved_close = READ_ONCE(sk->sk_prot)->close;
>> >  	} else {
>> >  		saved_close = psock->saved_close;
>> >  		sock_map_remove_links(sk, psock);
>> > +		psock = sk_psock_get(sk);
>> >  		rcu_read_unlock();
>> > -		sk_psock_stop(psock);
>> > +		if (psock)
>> > +			sk_psock_stop(psock);
>> >  		release_sock(sk);
>> > -		cancel_delayed_work_sync(&psock->work);
>> > -		sk_psock_put(sk, psock);
>> > +		if (psock) {
>> > +			cancel_delayed_work_sync(&psock->work);
>> > +			sk_psock_put(sk, psock);
>> > +		}
>> >  	}
>> >  
>> >  	/* Make sure we do not recurse. This is a bug.
>> 
>> As a personal opinion I think the code will become simple reordering
>> the condition, something alike:
>> 
>> 	if (psock) {
>> 		saved_close = psock->saved_close;
>>  		sock_map_remove_links(sk, psock);
>> 		psock = sk_psock_get(sk);
>> 		if (!psock)
>> 			goto no_psock;
>>  		rcu_read_unlock();
>> 		sk_psock_stop(psock);
>>  		release_sock(sk);
>> 		cancel_delayed_work_sync(&psock->work);
>> 		sk_psock_put(sk, psock);
>> 	} else {
>> no_psock:
>> 		saved_close = READ_ONCE(sk->sk_prot)->close;
>
> FTR, the above is wrong, should be:
>
> 		saved_close = READ_ONCE(sk->sk_prot)->close;
> no_psock:
>
>>  		rcu_read_unlock();
>>  		release_sock(sk);
>> 	}
>
> /P

Paolo's version does read better to me as well.

