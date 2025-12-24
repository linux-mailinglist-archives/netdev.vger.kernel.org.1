Return-Path: <netdev+bounces-246027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F51CDCEE7
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 18:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 031A7302D38D
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFF02C0F6F;
	Wed, 24 Dec 2025 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ildueq/B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE5A239E65
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766597401; cv=none; b=orDxcl/p6Q2oR8CpTyQRS4/qetY03NvZNcMv/75ILtwQByBk1XDFb5T+Q5ae+FzXULY7aiv5efUElSvL73CVjSAPBVjADDyHfJBJlov5f7r5vmIVCVL9HkrmxCOKqdW9LJRnFnJfp4EvgLeCkcVcFYfpmIZRnls0t3i6LDW72Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766597401; c=relaxed/simple;
	bh=LoZqE7u5aBpdhmb4MeI+l+qt4otgrofBxxw/teKS9bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWdjk3xI4y71BDJvOMxXKQkeyO0unR96ihlExRTKBSbSO/KXwGYyxyHzkZGh+zPGbzkwe/Z5LXOkuTHO6AJoY6KYyVB8ZCJdUx+HXrRBqu6B2SqBWJMOdQboSKPP6Wv59zG2gbc28kAT0GaaL/1JsvNlgagGAsDUZo6CyUzCZ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ildueq/B; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7ade456b6abso5100117b3a.3
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 09:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766597399; x=1767202199; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jsjeRNtyMZNxTqBCZZQHNG0tbOqaUHsh6LXIYvXiP04=;
        b=ildueq/BV1AvCCvBGs5gVjS4BjdQJ9yDhq9dLUSQeXlppgh8acREnafic6QW1fWKph
         X88zLu3Q6H0qyqgtZePy4RoAjZjIlpEyBkoAC7ofEweOLRA3MdzDAsFYfVpEzxx6VyMZ
         HpTBBfuQfCOBAAvFxNfDJ8UnhKpaxSGVc8w4F/SdTlfwhsk7AylWmk6uVYzAkH4XLoMq
         OiRtAY2FzeA6IFIExzw8jkDw5oxLSy+uGIBUfGc2H3EGzRZkzqY/2AZYad+yUK8HNBp2
         8XTlDu4AWG/fbWYDeNCb3WTRNS8t6zrA9mO3aFSj/LuGJrzqjqpfVpy4zPlCZrTO2Uyz
         te2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766597399; x=1767202199;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsjeRNtyMZNxTqBCZZQHNG0tbOqaUHsh6LXIYvXiP04=;
        b=r8OlUwZq57wOIj4IrLqsnwwBTM/owghSFAo8r1/ywa76Rd+dvgsJhxtfkExWz9u/HQ
         JhqnPxHdBe9cphA1B+iAOA3hS9E5sP1YU6xZnZpfnK4bBOdEap7L34jVnSwUVWhNfv4A
         k78MJMnReG4dptqy3MXkLqGD3lRqW5VN/hoZkRYKfbK5H+mqzh62ODsxJgYP58b5wz4o
         wTVYWSlpvRKT1WI4nzg7JVVKNBAOYR5IAGWsRH522pU8hhXZ2bdEn+1IErf2oL8/F/Tk
         UULbFJSt9CKI+RjE1i2LtKQqHdwVZxiPrBPs9QIapvNh27HoBRIsmeADAM3WFXcEFn64
         kq/A==
X-Forwarded-Encrypted: i=1; AJvYcCWRN/xjkoOZjtVC7Oqdxx5CoH1owy74TO3BTp5deVPcjJ0UnnYl6QzA2H6AJPjEvDAKfK24hhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylfanhSMW9RhXHRv0NJ445SOcQV8xqi619/94ArGdeKr0j5vWI
	AJhvsjmNWWd4qfU+SBcd/d98/lkAPT82RyPiU6RxB3beTs7oGlRPlrd4
X-Gm-Gg: AY/fxX63hxHTZdOYAD7mc8rXGJYbQ7znEUJC+Gja1Z4dDdMGq3OH6NAEfBbsawr2PdN
	bAZOdnO+C+5/1BbjwH5cuu0vIdzYBykKLPBmR9VzfqEvhC6Gm/DtayUAGy7Y5tr9v3aLoIeFCIz
	qMdmGfgYHPA0o+fE5NiT4txYUnQGbDOFUYK8KwE6VAwp1c0LzlsxwuNgnrDqrrgbg2a6eUPYni9
	yZGAc6qslVpxnvHJR2OedhVhv77/kzlwpfy8ji18g7Mpirz75ukFPVtV5IVtZ5E0f5watZOqRIB
	AAW/uMnvp1uY5eVsJQ0o8RThibbT0Zy+kr/4r0TGirQnfHS2fqY/w9OixqZkFJaGaoy4gSiRx6H
	zefXFIt8dW8Ws4DsxtLa9Mg/iaVqe0+uPsy9qv7VOqxF/E8nTFnO5oc0+vKC7o+MHMXqyJnk9p2
	NcSyeuOOoD
X-Google-Smtp-Source: AGHT+IFjFX//4ixGyykoiuzl18S6UFN+jgJkT3GDZ6w2fclvSzNAzJwCHzhbDSAB3/GANNuFdndN0Q==
X-Received: by 2002:a05:7022:248a:b0:11b:9152:b3ad with SMTP id a92af1059eb24-121722dff70mr19702723c88.31.1766597399031;
        Wed, 24 Dec 2025 09:29:59 -0800 (PST)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c0c6sm78519697c88.12.2025.12.24.09.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 09:29:58 -0800 (PST)
Date: Thu, 25 Dec 2025 01:29:53 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xmei5@asu.edu
Subject: Re: [PATCH net v5] net: sock: fix hardened usercopy panic in
 sock_recv_errqueue
Message-ID: <aUwOoEaZKvrU0IjP@Air.local>
References: <20251223203534.1392218-2-bestswngs@gmail.com>
 <CANn89iKpH0MO36JHbM=vS9ga=9UzgdtFahNR4+dvNr2oUtNLuA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKpH0MO36JHbM=vS9ga=9UzgdtFahNR4+dvNr2oUtNLuA@mail.gmail.com>

On 25-12-24 09:52, Eric Dumazet wrote:
> On Tue, Dec 23, 2025 at 9:36 PM <bestswngs@gmail.com> wrote:
> >
> > From: Weiming Shi <bestswngs@gmail.com>
> >
> > skbuff_fclone_cache was created without defining a usercopy region,
> > [1] unlike skbuff_head_cache which properly whitelists the cb[] field.
> > [2] This causes a usercopy BUG() when CONFIG_HARDENED_USERCOPY is
> > enabled and the kernel attempts to copy sk_buff.cb data to userspace
> > via sock_recv_errqueue() -> put_cmsg().
> >
> > The crash occurs when: 1. TCP allocates an skb using alloc_skb_fclone()
> >    (from skbuff_fclone_cache) [1]
> > 2. The skb is cloned via skb_clone() using the pre-allocated fclone
> > [3] 3. The cloned skb is queued to sk_error_queue for timestamp
> > reporting 4. Userspace reads the error queue via recvmsg(MSG_ERRQUEUE)
> > 5. sock_recv_errqueue() calls put_cmsg() to copy serr->ee from skb->cb
> > [4] 6. __check_heap_object() fails because skbuff_fclone_cache has no
> >    usercopy whitelist [5]
> >
> > When cloned skbs allocated from skbuff_fclone_cache are used in the
> > socket error queue, accessing the sock_exterr_skb structure in skb->cb
> > via put_cmsg() triggers a usercopy hardening violation:
> >
> > [    5.379589] usercopy: Kernel memory exposure attempt detected from SLUB object 'skbuff_fclone_cache' (offset 296, size 16)!
> > [    5.382796] kernel BUG at mm/usercopy.c:102!
> > [    5.383923] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> > [    5.384903] CPU: 1 UID: 0 PID: 138 Comm: poc_put_cmsg Not tainted 6.12.57 #7
> > [    5.384903] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > [    5.384903] RIP: 0010:usercopy_abort+0x6c/0x80
> > [    5.384903] Code: 1a 86 51 48 c7 c2 40 15 1a 86 41 52 48 c7 c7 c0 15 1a 86 48 0f 45 d6 48 c7 c6 80 15 1a 86 48 89 c1 49 0f 45 f3 e8 84 27 88 ff <0f> 0b 490
> > [    5.384903] RSP: 0018:ffffc900006f77a8 EFLAGS: 00010246
> > [    5.384903] RAX: 000000000000006f RBX: ffff88800f0ad2a8 RCX: 1ffffffff0f72e74
> > [    5.384903] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff87b973a0
> > [    5.384903] RBP: 0000000000000010 R08: 0000000000000000 R09: fffffbfff0f72e74
> > [    5.384903] R10: 0000000000000003 R11: 79706f6372657375 R12: 0000000000000001
> > [    5.384903] R13: ffff88800f0ad2b8 R14: ffffea00003c2b40 R15: ffffea00003c2b00
> > [    5.384903] FS:  0000000011bc4380(0000) GS:ffff8880bf100000(0000) knlGS:0000000000000000
> > [    5.384903] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    5.384903] CR2: 000056aa3b8e5fe4 CR3: 000000000ea26004 CR4: 0000000000770ef0
> > [    5.384903] PKRU: 55555554
> > [    5.384903] Call Trace:
> > [    5.384903]  <TASK>
> > [    5.384903]  __check_heap_object+0x9a/0xd0
> > [    5.384903]  __check_object_size+0x46c/0x690
> > [    5.384903]  put_cmsg+0x129/0x5e0
> > [    5.384903]  sock_recv_errqueue+0x22f/0x380
> > [    5.384903]  tls_sw_recvmsg+0x7ed/0x1960
> > [    5.384903]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    5.384903]  ? schedule+0x6d/0x270
> > [    5.384903]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    5.384903]  ? mutex_unlock+0x81/0xd0
> > [    5.384903]  ? __pfx_mutex_unlock+0x10/0x10
> > [    5.384903]  ? __pfx_tls_sw_recvmsg+0x10/0x10
> > [    5.384903]  ? _raw_spin_lock_irqsave+0x8f/0xf0
> > [    5.384903]  ? _raw_read_unlock_irqrestore+0x20/0x40
> > [    5.384903]  ? srso_alias_return_thunk+0x5/0xfbef5
> >
> 
> Nit : Next time you send a stack trace, please run it though
> scripts/decode_stacktrace.sh
> to get meaningful symbols.
> 
> > The crash offset 296 corresponds to skb2->cb within skbuff_fclones:
> >   - sizeof(struct sk_buff) = 232 - offsetof(struct sk_buff, cb) = 40 -
> >   offset of skb2.cb in fclones = 232 + 40 = 272 - crash offset 296 =
> >   272 + 24 (inside sock_exterr_skb.ee)
> >
> > This patch uses a local stack variable as a bounce buffer to avoid the hardened usercopy check failure.
> >
> > [1] https://elixir.bootlin.com/linux/v6.12.62/source/net/ipv4/tcp.c#L885
> > [2] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5104
> > [3] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5566
> > [4] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5491
> > [5] https://elixir.bootlin.com/linux/v6.12.62/source/mm/slub.c#L5719
> >
> > Fixes: 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> Also please next time do not CC security@kernel.org if you made the
> bug public (say on netdev@kernel.org),
> because security@kernel.org will be of no help.
> 
> Congratulations on your first linux contribution !

Hi Eric,

Thank you very much for your quick review and encouragement.
I will take note of your suggestions next time.

Best regards,
Weiming




