Return-Path: <netdev+bounces-245891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 964D4CDA461
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 19:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7809D301A01C
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 18:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A8F2F691B;
	Tue, 23 Dec 2025 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ujft+hz5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA8121CFFA
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766514734; cv=none; b=E5ShgCQUBqHhk1KKJ32y9DITjwtr5/zIXHGwZuT+S6JxzMbWUP+DZYnY4V9FOkX3MVtAUtG104pKoKqUNz5OuFo2pk0SIVXG6DS4+ngimu6eBl1lRYnOZp65wOABYklNZ28qolGxNPn1i1sNuvUFRaa5+E7WZgT2hhVIOgUnqKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766514734; c=relaxed/simple;
	bh=ENgBC+fsb+4b08HzsqOSzXBHZAstUdSVozZCuisOhdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8s3cE6zPMU9d9zL8EDOzg1Nlk3opm2/Shuk+lF78tSXHhyrc89LMsVuXnqyaytMbJateUb9QVtXAPBr8OpFc4HrYfAPvkSNAg0GwUrHoYY85kWhpRHi1ZkNzCi+xHOpCmqj1KQy4GXElSfJgTvndiYPxlt4npw0cByCe43tcOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ujft+hz5; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so4202961b3a.1
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 10:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766514732; x=1767119532; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7oF3WX5Xhy5IBgytRhgW3an7vFSwK1HRVAZyiLtpih8=;
        b=Ujft+hz54qs2VYtZIFK5j6l78GOZ+OlhkwW/vXtTg8Qyn7+umD8eRNk7CeFX7/Syzy
         Oq//eyoq8tj9rYR67DfFWj88tLYRd/5k4eAzRlWr8Uh3BNd5h/UlSZiMBnJklYx8cuDl
         khZXqrXSONrsB+s0Rl0uWWRrGWU4dHcPEqPrglrK5efsYf0/o3wt6RebTsbJeDeBk8n+
         sDaDpJ7llLmrKpsh32WfhRxsKeThZGFBhiODUjnxurkmg84QnIkkEJHPBskFRmrs1FGa
         IGwAfLZGyKf4YVhHXxz5bP1pFaV9DofCXCyXafb6K7wO9ooB0fe6j+e92zBp6igxGl5B
         G4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766514732; x=1767119532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7oF3WX5Xhy5IBgytRhgW3an7vFSwK1HRVAZyiLtpih8=;
        b=fRWscfu28ETnK6NVU3ZBaCUjPYuE6h1R3fuRF2Zfvxpw0dQ26eBcuF6RNwHvtSHU3G
         DJ2X7QK7UVMTNOrV3r9yWbGu2+nq3McambJVB2pZA5iPsbhVk2JRyeeg9bEPjAuguCj3
         tJZnxdO3yIu0WZujtw16QPHVPtg58SPh0UBhA1lyR9lmKs00h64DGpdUSzUK+J7RrfGw
         Y44ETRwmPiI4pGkgAEz7tFs/jGLqXjrJGHA+aO+zZD0ju2m3NTIFTCz+0PqVb0+xKZHt
         Im/Hgmz8A7sVkzvMk8Fa7sHNgJ9JPfV9lGE5JmovuwcCZBRC6NyGZg5kPrd1fQffy0C8
         jWPg==
X-Forwarded-Encrypted: i=1; AJvYcCWIzDMBcK6dK1SloWQLAu4hGBfqkuUaomUZ1YVd8CaepF5s0lOTB/w6IBdnYmNKicDZaboPOyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9DGY+GsUqs7SBi6WPf7TPT8hQ5i2Q7IKn6wewbqkBQw0Wm5Ai
	0yD/fChDWyPh+CiSDaCfUs0qifru4NwxHYDy1EGGAPump+K2udVlgOE2
X-Gm-Gg: AY/fxX4HRu86YC50+hh7IU6NYN/lEDQstJ6wCooXQ1f2T8QN+KpzD9OkXFWRwP4exL2
	AHqujKwNFZNfxE4kp+bNBwNL56d97JycCfbnutCrPuqh0oQtjfb/wxtclrI3zRlT8kYy9e5i8X0
	u4zA27bhxOjcLKrMABtCK7oC0TdkiYN9HQNZ0J0OEd/kbTmivgvQRpm63QStGa4p2frK0s1ulp3
	c2mmINz9gsWB9yxcVm3jkH5wK9WdWhSgTZTtHqQRXDsyTQN38StRfoJV0ze8i9zfOu/8CuHjqcE
	wGlAiVDoLs/Y161f74S9OLCuJgitMdf077khO8XEJx2I7PZ+kLV06YWZJPOS4muUy+TIU7i+F1t
	6lMI1kjSsXNRMGxYPLSL2oboAWpb0Rae32dO38utOQhObhi08iF/ZjnzIaNiIZI0DVaR3WIJEj6
	Vh70pBRjOim4idFbCKaRI=
X-Google-Smtp-Source: AGHT+IGp3culeOz94ACmq5V/gqnMA0yQ89cSUVtAQ4kBV/N8UgMhyKdK6aM7+HjgBc7pJPMY0DyUVA==
X-Received: by 2002:a05:7022:6988:b0:119:e56b:98a4 with SMTP id a92af1059eb24-121722b71f2mr19364460c88.11.1766514731530;
        Tue, 23 Dec 2025 10:32:11 -0800 (PST)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121725548b5sm61465720c88.17.2025.12.23.10.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 10:32:10 -0800 (PST)
Date: Wed, 24 Dec 2025 02:31:50 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	xmei5@asu.edu, kuba@kernel.org, davem@davemloft.net, security@kernel.org, 
	horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v4] net: skbuff: add usercopy region to
 skbuff_fclone_cache
Message-ID: <aUrgC9RPUuX-6C4y@Air.local>
References: <20251216084449.973244-5-bestswngs@gmail.com>
 <d7ea6222-607f-433e-a70d-b3632a80b4b9@redhat.com>
 <CANn89iLfPmEW6-sSgZXXFn5H72xc_5H4w+qvA5dMjcARBB7v9A@mail.gmail.com>
 <ea0174b4-dd9d-40a9-8206-5ae3845a5cab@Canary>
 <CANn89iK-N9davqJg-BdF9K25T3+oHoabcnyAyrE+8sq1qe-7pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iK-N9davqJg-BdF9K25T3+oHoabcnyAyrE+8sq1qe-7pQ@mail.gmail.com>

On 25-12-23 18:22, Eric Dumazet wrote:
> On Tue, Dec 23, 2025 at 6:08 PM swing <bestswngs@gmail.com> wrote:
> 
> > I tested this on Linux 6.12.57. Running the PoC that previously caused the
> > issue no longer triggers the crash/panic with this patch applied.
> >
> >
> >
> >
> Great, please send a V2 with it, you can be the author, I will then add my
> 'Reviewed-by:' tag.
> 
> Thanks !
Thank you for your suggestion. I am currently preparing a v5 version
patch and will need some time to conduct more comprehensive testing.

Best,
Weiming
> 
> 
> > On 星期二, 12月 23, 2025 at 6:59 下午, Eric Dumazet <edumazet@google.com> wrote:
> > On Tue, Dec 23, 2025 at 11:34 AM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> >
> > On 12/16/25 9:44 AM, bestswngs@gmail.com wrote:
> >
> > From: Weiming Shi <bestswngs@gmail.com>
> >
> > skbuff_fclone_cache was created without defining a usercopy region, [1]
> > unlike skbuff_head_cache which properly whitelists the cb[] field. [2]
> > This causes a usercopy BUG() when CONFIG_HARDENED_USERCOPY is enabled
> > and the kernel attempts to copy sk_buff.cb data to userspace via
> > sock_recv_errqueue() -> put_cmsg().
> >
> > The crash occurs when:
> > 1. TCP allocates an skb using alloc_skb_fclone()
> > (from skbuff_fclone_cache) [1]
> > 2. The skb is cloned via skb_clone() using the pre-allocated fclone [3]
> > 3. The cloned skb is queued to sk_error_queue for timestamp reporting
> > 4. Userspace reads the error queue via recvmsg(MSG_ERRQUEUE)
> > 5. sock_recv_errqueue() calls put_cmsg() to copy serr->ee from skb->cb [4]
> > 6. __check_heap_object() fails because skbuff_fclone_cache has no
> > usercopy whitelist [5]
> >
> > When cloned skbs allocated from skbuff_fclone_cache are used in the
> > socket error queue, accessing the sock_exterr_skb structure in skb->cb
> > via put_cmsg() triggers a usercopy hardening violation:
> >
> > [ 5.379589] usercopy: Kernel memory exposure attempt detected from SLUB
> > object 'skbuff_fclone_cache' (offset 296, size 16)!
> > [ 5.382796] kernel BUG at mm/usercopy.c:102!
> > [ 5.383923] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> > [ 5.384903] CPU: 1 UID: 0 PID: 138 Comm: poc_put_cmsg Not tainted 6.12.57
> > #7
> > [ 5.384903] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > [ 5.384903] RIP: 0010:usercopy_abort+0x6c/0x80
> > [ 5.384903] Code: 1a 86 51 48 c7 c2 40 15 1a 86 41 52 48 c7 c7 c0 15 1a 86
> > 48 0f 45 d6 48 c7 c6 80 15 1a 86 48 89 c1 49 0f 45 f3 e8 84 27 88 ff <0f>
> > 0b 490
> > [ 5.384903] RSP: 0018:ffffc900006f77a8 EFLAGS: 00010246
> > [ 5.384903] RAX: 000000000000006f RBX: ffff88800f0ad2a8 RCX:
> > 1ffffffff0f72e74
> > [ 5.384903] RDX: 0000000000000000 RSI: 0000000000000004 RDI:
> > ffffffff87b973a0
> > [ 5.384903] RBP: 0000000000000010 R08: 0000000000000000 R09:
> > fffffbfff0f72e74
> > [ 5.384903] R10: 0000000000000003 R11: 79706f6372657375 R12:
> > 0000000000000001
> > [ 5.384903] R13: ffff88800f0ad2b8 R14: ffffea00003c2b40 R15:
> > ffffea00003c2b00
> > [ 5.384903] FS: 0000000011bc4380(0000) GS:ffff8880bf100000(0000)
> > knlGS:0000000000000000
> > [ 5.384903] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 5.384903] CR2: 000056aa3b8e5fe4 CR3: 000000000ea26004 CR4:
> > 0000000000770ef0
> > [ 5.384903] PKRU: 55555554
> > [ 5.384903] Call Trace:
> > [ 5.384903] <TASK>
> > [ 5.384903] __check_heap_object+0x9a/0xd0
> > [ 5.384903] __check_object_size+0x46c/0x690
> > [ 5.384903] put_cmsg+0x129/0x5e0
> > [ 5.384903] sock_recv_errqueue+0x22f/0x380
> > [ 5.384903] tls_sw_recvmsg+0x7ed/0x1960
> > [ 5.384903] ? srso_alias_return_thunk+0x5/0xfbef5
> > [ 5.384903] ? schedule+0x6d/0x270
> > [ 5.384903] ? srso_alias_return_thunk+0x5/0xfbef5
> > [ 5.384903] ? mutex_unlock+0x81/0xd0
> > [ 5.384903] ? __pfx_mutex_unlock+0x10/0x10
> > [ 5.384903] ? __pfx_tls_sw_recvmsg+0x10/0x10
> > [ 5.384903] ? _raw_spin_lock_irqsave+0x8f/0xf0
> > [ 5.384903] ? _raw_read_unlock_irqrestore+0x20/0x40
> > [ 5.384903] ? srso_alias_return_thunk+0x5/0xfbef5
> >
> > The crash offset 296 corresponds to skb2->cb within skbuff_fclones:
> > - sizeof(struct sk_buff) = 232
> > - offsetof(struct sk_buff, cb) = 40
> > - offset of skb2.cb in fclones = 232 + 40 = 272
> > - crash offset 296 = 272 + 24 (inside sock_exterr_skb.ee)
> >
> > Fix this by using kmem_cache_create_usercopy() for skbuff_fclone_cache
> > and whitelisting the cb regions.
> > In our patch, we referenced
> > net: Whitelist the `skb_head_cache` "cb" field. [6]
> >
> > Fix by using kmem_cache_create_usercopy() with the same cb[] region
> > whitelist as skbuff_head_cache.
> >
> > [1] https://elixir.bootlin.com/linux/v6.12.62/source/net/ipv4/tcp.c#L885
> > [2]
> > https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5104
> > [3]
> > https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5566
> > [4]
> > https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5491
> > [5] https://elixir.bootlin.com/linux/v6.12.62/source/mm/slub.c#L5719
> > [6]
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=79a8a642bf05c
> >
> > Fixes: 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> >
> >
> > Rephrasing Eric's comment (and hoping to have not misread it), you
> > should fix the issue differently, catching and fclones before adding
> > them to the error queue and try to unclone them.
> >
> >
> > Instead of opening/weakening skbuff_clone to wide user copies, I would
> > rather
> > use what we did in:
> >
> > commit 2558b8039d059342197610498c8749ad294adee5
> > Author: Eric Dumazet <edumazet@google.com>
> > Date: Mon Feb 13 16:00:59 2023 +0000
> >
> > net: use a bounce buffer for copying skb->mark
> >
> > ie :
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 45c98bf524b2..a1c8b47b0d56 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -3896,7 +3896,7 @@ void sock_enable_timestamp(struct sock *sk, enum
> > sock_flags flag)
> > int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len,
> > int level, int type)
> > {
> > - struct sock_exterr_skb *serr;
> > + struct sock_extended_err ee;
> > struct sk_buff *skb;
> > int copied, err;
> >
> > @@ -3916,8 +3916,9 @@ int sock_recv_errqueue(struct sock *sk, struct
> > msghdr *msg, int len,
> >
> > sock_recv_timestamp(msg, sk, skb);
> >
> > - serr = SKB_EXT_ERR(skb);
> > - put_cmsg(msg, level, type, sizeof(serr->ee), &serr->ee);
> > + /* We must use a bounce buffer for CONFIG_HARDENED_USERCOPY=y */
> > + ee = SKB_EXT_ERR(skb)->ee;
> > + put_cmsg(msg, level, type, sizeof(ee), &ee);
> >
> > msg->msg_flags |= MSG_ERRQUEUE;
> > err = copied;
> >
> >

