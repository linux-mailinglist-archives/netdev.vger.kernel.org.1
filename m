Return-Path: <netdev+bounces-245229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8727CCC9488
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 19:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F41743019929
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 18:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5382C2882B7;
	Wed, 17 Dec 2025 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Hp97ADq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863B1243387
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765995862; cv=none; b=Su9D6Wpu3ZzzxU7rYRQ69tg1TMnoaFIppfcp6iAy/MZw3P1XmM2jQgtbtbOqqW7J6FrWBPWDSD28YHKQPl8BAS02A3plMJUlVLKWFLx1Zgb7x+X77dvA4u1PD1EVl+/NaW2ZWTnJakoNErDPwN37vc947/5TN5UrWDiwsW1C0UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765995862; c=relaxed/simple;
	bh=qcXZ0hk1/PO+IelGZjqrEiKJ7rQypJXdilcXm8MVHPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jeqQLRfrx9N81DQk9HYjF+RvGPIIVOzXOtSDllh27I6U0ywRNssU0fN0BhZibxoYXsnlUrqcO/V23+1r9HAYAe/a58NMvhK2VXOrFLrpDR1l0YW1k7G77TAma7UHVqqDtqsvj99f7vUgYxi8cS2JMXS2lp3AVxVthNfbDMY0gVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Hp97ADq; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78d60c6cc17so48395277b3.0
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 10:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765995859; x=1766600659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03S7kQdI2rRNTHXQ3ixebAM2mub6exjbtPxT+HlrxWU=;
        b=0Hp97ADq1JXWHPCmkLVRIg2IcxRdw9J0HZtZ2vXuGtMIUdOcmlko5U3tk7hQZLArKo
         DTtG8gUwNy9GFKKfdVBIY2n8Y296Bca0q0hnodyXkmimte+bRrBDOmp3NuQTQv9n9V5V
         jBySoV6Kc3nJWweHZZTMNhQO+IPGVmg0QJdQXzKvi59VPwnSuuxni8VBHgrn7MhCKsxW
         MDtrHRgOQ9HwTidmx5qrmBONNSk4fTGdaN9XF8pUFGBvwgJgCDy1qf7t/qV6+iYAQvYt
         fF6ObuoIugPR7qf2YrNiIHkhoJTAj5h9Mftes1I9wHi6gV8Ko8KVPSvGbmmFMU0QFhb/
         Zl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765995859; x=1766600659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=03S7kQdI2rRNTHXQ3ixebAM2mub6exjbtPxT+HlrxWU=;
        b=jPlj/nreRio1ManQyN2pJ3zxS2xYUA0PbsMiUkdCpQe5cWK7H1NaehB0jVy1v7R94V
         LbsPPxzMPs/TBzgCCj/fBSolSIFR2w4tnc5c4t4FcSZ/TONHlGo+IwBSXi6YM2nb/J0F
         KveLF9ZyjDt5LOwxqIhY5L5q4NBIgeGd2z8YO0+QtG4ikpWQQ1xXNcvE2xYIXw6e0Npv
         VobcBHgDHULMj9LThke0pbfQTY8JwGCehpc+2FjRT63qdU8MxwsPUPxXVKIOyMGiuTBg
         nwiNtggFfQWd107SHZIORZRxteqm24Lr06pxp0CWuSWSzLdjaHs2y/yhdJmRECnymY7P
         F+yw==
X-Forwarded-Encrypted: i=1; AJvYcCWOlHDYHbwlZoQFv6NchECkRQRMQlSac02ubTXEVOfjWJaCZURrxd1WPDBKKEyROeb9QGcLiFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdG8Y1bduTdHO+XUusaGVv8Ce7US3WrbVzhZRnuqpMv9TshvE3
	VO38gCxbSy8FTuZLpnIB81H1pbc8JvkknHUBuzaAEeLZoFij+lhhyMU5rPNOMpkI879BO8O4T/U
	WmMFUncXyVd1TIQevAVNLqUKmB59Q/kxFD4qGH5cF
X-Gm-Gg: AY/fxX5RH7ZnP2D6pYiYw3g31OcTJZSs54B+X5BZLb6bhjyxrQXAnZGz/aLHnCG1IuE
	uj6gvrkan6dXKgIVL1LfrZUZGL9tFo39CzQIlG2XwJGEqjnsaeP4qYcl2eHXYlmpejONCtA7yUg
	oiaClxPDLLmKd0NFxUiJR5AfIEuMQvKMgOgrFiOF0YQspPPQSujYRnam1CkNPT8R155NvTRbP0O
	FmpsKH0Clb2VALh1YOI7XP19E7TRkqt1NhoN/JSR8i7l9XGbSjdOUKZBJ6I2uCVzN6S+cJE
X-Google-Smtp-Source: AGHT+IGP09ewCJTFq4JRhfps5g/cEFQ/bWvBIY9bZD73ElmBc+kpnqOaicd/He02zydro4CtwuvCdhY6rVLDzKZMNNk=
X-Received: by 2002:a05:690c:6807:b0:78e:62ee:3d4d with SMTP id
 00721157ae682-78e66c2174cmr174031427b3.40.1765995858980; Wed, 17 Dec 2025
 10:24:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216084449.973244-5-bestswngs@gmail.com>
In-Reply-To: <20251216084449.973244-5-bestswngs@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Dec 2025 19:24:07 +0100
X-Gm-Features: AQt7F2ojlQRe9Zr5hR52F4cr7K3YOYsJZG1WFDJZoWQyxwfbApMOVsuNZAlgtJc
Message-ID: <CANn89iK=vK4FCgXP_NMTdAw+QAGNMbpqNubjY5e+XvtNshELUw@mail.gmail.com>
Subject: Re: [PATCH net v4] net: skbuff: add usercopy region to skbuff_fclone_cache
To: bestswngs@gmail.com
Cc: security@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xmei5@asu.edu, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 9:51=E2=80=AFAM <bestswngs@gmail.com> wrote:
>
> From: Weiming Shi <bestswngs@gmail.com>
>
> skbuff_fclone_cache was created without defining a usercopy region, [1]
> unlike skbuff_head_cache which properly whitelists the cb[] field.  [2]
> This causes a usercopy BUG() when CONFIG_HARDENED_USERCOPY is enabled
> and the kernel attempts to copy sk_buff.cb data to userspace via
> sock_recv_errqueue() -> put_cmsg().
>
> The crash occurs when:
> 1. TCP allocates an skb using alloc_skb_fclone()
>    (from skbuff_fclone_cache) [1]
> 2. The skb is cloned via skb_clone() using the pre-allocated fclone [3]
> 3. The cloned skb is queued to sk_error_queue for timestamp reporting
> 4. Userspace reads the error queue via recvmsg(MSG_ERRQUEUE)
> 5. sock_recv_errqueue() calls put_cmsg() to copy serr->ee from skb->cb [4=
]
> 6. __check_heap_object() fails because skbuff_fclone_cache has no
>    usercopy whitelist [5]
>
> When cloned skbs allocated from skbuff_fclone_cache are used in the
> socket error queue, accessing the sock_exterr_skb structure in skb->cb
> via put_cmsg() triggers a usercopy hardening violation:
>
> [    5.379589] usercopy: Kernel memory exposure attempt detected from SLU=
B object 'skbuff_fclone_cache' (offset 296, size 16)!
> [    5.382796] kernel BUG at mm/usercopy.c:102!
> [    5.383923] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> [    5.384903] CPU: 1 UID: 0 PID: 138 Comm: poc_put_cmsg Not tainted 6.12=
.57 #7
> [    5.384903] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [    5.384903] RIP: 0010:usercopy_abort+0x6c/0x80
> [    5.384903] Code: 1a 86 51 48 c7 c2 40 15 1a 86 41 52 48 c7 c7 c0 15 1=
a 86 48 0f 45 d6 48 c7 c6 80 15 1a 86 48 89 c1 49 0f 45 f3 e8 84 27 88 ff <=
0f> 0b 490
> [    5.384903] RSP: 0018:ffffc900006f77a8 EFLAGS: 00010246
> [    5.384903] RAX: 000000000000006f RBX: ffff88800f0ad2a8 RCX: 1ffffffff=
0f72e74
> [    5.384903] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffff8=
7b973a0
> [    5.384903] RBP: 0000000000000010 R08: 0000000000000000 R09: fffffbfff=
0f72e74
> [    5.384903] R10: 0000000000000003 R11: 79706f6372657375 R12: 000000000=
0000001
> [    5.384903] R13: ffff88800f0ad2b8 R14: ffffea00003c2b40 R15: ffffea000=
03c2b00
> [    5.384903] FS:  0000000011bc4380(0000) GS:ffff8880bf100000(0000) knlG=
S:0000000000000000
> [    5.384903] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.384903] CR2: 000056aa3b8e5fe4 CR3: 000000000ea26004 CR4: 000000000=
0770ef0
> [    5.384903] PKRU: 55555554
> [    5.384903] Call Trace:
> [    5.384903]  <TASK>
> [    5.384903]  __check_heap_object+0x9a/0xd0
> [    5.384903]  __check_object_size+0x46c/0x690
> [    5.384903]  put_cmsg+0x129/0x5e0
> [    5.384903]  sock_recv_errqueue+0x22f/0x380
> [    5.384903]  tls_sw_recvmsg+0x7ed/0x1960
> [    5.384903]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    5.384903]  ? schedule+0x6d/0x270
> [    5.384903]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    5.384903]  ? mutex_unlock+0x81/0xd0
> [    5.384903]  ? __pfx_mutex_unlock+0x10/0x10
> [    5.384903]  ? __pfx_tls_sw_recvmsg+0x10/0x10
> [    5.384903]  ? _raw_spin_lock_irqsave+0x8f/0xf0
> [    5.384903]  ? _raw_read_unlock_irqrestore+0x20/0x40
> [    5.384903]  ? srso_alias_return_thunk+0x5/0xfbef5
>
> The crash offset 296 corresponds to skb2->cb within skbuff_fclones:
>   - sizeof(struct sk_buff) =3D 232
>   - offsetof(struct sk_buff, cb) =3D 40
>   - offset of skb2.cb in fclones =3D 232 + 40 =3D 272
>   - crash offset 296 =3D 272 + 24 (inside sock_exterr_skb.ee)
>
> Fix this by using kmem_cache_create_usercopy() for skbuff_fclone_cache
> and whitelisting the cb regions.
> In our patch, we referenced
>     net: Whitelist the `skb_head_cache` "cb" field. [6]
>
> Fix by using kmem_cache_create_usercopy() with the same cb[] region
> whitelist as skbuff_head_cache.
>
> [1] https://elixir.bootlin.com/linux/v6.12.62/source/net/ipv4/tcp.c#L885
> [2] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5=
104
> [3] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5=
566
> [4] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5=
491
> [5] https://elixir.bootlin.com/linux/v6.12.62/source/mm/slub.c#L5719
> [6] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/comm=
it/?id=3D79a8a642bf05c
>
> Fixes: 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> v2: Fix the Commit Message
> v3: Add "From" email address, Fix "CC" and "TO" email address
> v4: Fix The Patch Code
>
>  net/core/skbuff.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index a00808f7be6a..89c98ce6106a 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5157,10 +5157,12 @@ void __init skb_init(void)
>                                               NULL);
>         skbuff_cache_size =3D kmem_cache_size(net_hotdata.skbuff_cache);
>
> -       net_hotdata.skbuff_fclone_cache =3D kmem_cache_create("skbuff_fcl=
one_cache",
> +       net_hotdata.skbuff_fclone_cache =3D kmem_cache_create_usercopy("s=
kbuff_fclone_cache",
>                                                 sizeof(struct sk_buff_fcl=
ones),
>                                                 0,
>                                                 SLAB_HWCACHE_ALIGN|SLAB_P=
ANIC,
> +                                               offsetof(struct sk_buff, =
cb),
> +                                               sizeof(struct sk_buff) + =
sizeof_field(struct sk_buff, cb),
>                                                 NULL);

I have a bad feeling about this patch.

Really we should not put a fast clone skb back in error queue in the
first place, because we can not control how long the (possibly large)
skb will stay there.

Things like skb_fclone_busy() would need a fix otherwise.

