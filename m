Return-Path: <netdev+bounces-245952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FDFCDBB47
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 09:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DC993015176
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 08:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A762A2DAFBD;
	Wed, 24 Dec 2025 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qHDnKRvo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD8E30E0ED
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766566338; cv=none; b=p8ZIZerGGnAumfgfotWix57ZblqKyxL/FamNIVyFbWOkF8ADkXkPr06qz5R8vqAN8bc61MZEnnM5kRqH1BBbB4dkoQwpd/eVtu0ofVdjbHsuBFSkyk6ThGWEst1bb29MxoYhj30br2S5ClAG4nLQmuwyP0ryz6QfyQpKxTwwKoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766566338; c=relaxed/simple;
	bh=cRTAkTSkJ0kUkqvKqxRIfL74IB8jZh4q+w+gv4yzhTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHqYjcZbnbklqnprR+WWMxkmA44WfzkPci2b4Qs8I4vwdMcPEWc+PG7E8fQpNOelbaF6OpYfR4qc7kEIlV19swhqkOAEGi2JBe44ns7UD500kHcR/F9HWeq8yfGq1EEsiMyhRRH0r/IXuf/dp6SQdMSRKbxfREYIMYWn5YweZw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qHDnKRvo; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4eda6c385c0so44388991cf.3
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 00:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766566336; x=1767171136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2s5WoFk/75sEHcHIya1H+VZ8teHuyXpvYW0UorztRo=;
        b=qHDnKRvoifcqr7QebpIojKRC/4nIYwczLBVKFHrpnfDwb6XHqDwMHPBHH84Sl55DUj
         cUhUjOoLKjj2N3c3iX79e0G7D7KKQ9rRJDUu7o3holaRtlJa8QyuHIRyfrLUsmWbJ87N
         0mcynHteh+9aj/qPXXlt8kc6Vm6Iq4cC3W9q70kI+i3jcDbu3WIoxBpbFnCatPd9RftN
         nB2XtwTHl7NXrSeyRAchcpx5tytvxoA4zwl7dWj+6SdsGtJtiYpaDvNWFlecoNP3oFir
         xD+qkkP6oL+BGcKJTsYmLJ3akpLUD8iRLuFKAbIWqAsY5JyJh1lJ4LzO4yfeec3zbh5t
         PXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766566336; x=1767171136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u2s5WoFk/75sEHcHIya1H+VZ8teHuyXpvYW0UorztRo=;
        b=dXmSaAAysw2AFD5o96/LKAyOghZTCiEIoA7S7iNc6UqN/h4rlgqaiv0fK+5j7KrMvJ
         etwxHa1tTDf6OLKNi4AYSkxrWQ1t1Lv/HZNCZf/3AMxIcRjqmMrZ0pIQV8D9XSG7izO4
         p1a3V6iWx4ShZqkD05+IXu8QS2ixoZpDxfF18NFf/EfvsPc/sGekICqSrrsgJ3F6jpvh
         qtm+wVLXHqxDUocDQBs1XSvl7JQv8XwiZqlYJ3JdvIWT5miTz3vXiIqlLvYmQ4sfGO8o
         irNcmKrKsCp7H6zhp0QytWunmjb/YiNH/7x4aCla/mDT6qS4ieQjxy7QijQT8a/wuFWk
         rmmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7E5t5mnYPcvoBqTXRcJykAeuOK73VWAxney6OspGrNb6MRuX94rlQ3e2XQN08ujJ6kM87ykE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIvAOV7Iw3co0Eobv5ooDvia74yi5EUXz5hFQ5wK6PP1d4TMDD
	yAr3CxIF7rR+I2DXWcIOUKFVC0YC8eF4PADATTY2nepybeKnrXheqjQ+RFukJE+svp7sMP+mrRW
	4jlAXMVwcyHGk1g/f0ZOL8eXjpPuoZ1Egsi6WfVbp9Cl1g+g1e8/ggz+h1fk=
X-Gm-Gg: AY/fxX7iCirNZ2ZzIbfoDXrU/AddkAp/n+mO1kDkQoJAbV381C+2lYv8k+5JbuXcr9R
	zOWqAVf8ev7ZNjsFAL2GvFqM66WGvDT2V8/1+J5YRGcD8RRhVf2jU76kcTN5LOpt59e4tZR6ZkH
	1D13Cbn/rZ9trg9GzrHLUR1UniqphEPZYufXb86jcaJAYLc+iUNU7Tt/7lkcy/w69tWtxE6GI2W
	8TUcy6NL88AIdsIKmW3qogVtn8N7VgtmoP1LOk9JoEuwQM9Qj6KnS4nr3fcLPe5vrAFgZ9ROj5R
	mhsSbg==
X-Google-Smtp-Source: AGHT+IFAOEXSKsQF77KPLT1Jc8ZBpbsS+KclaSawplctPso95w0PgnFVtp+wfVXsiVuUEmG/qLyzqcSempwElAcIqHI=
X-Received: by 2002:a05:622a:2443:b0:4ed:b7d6:7c6d with SMTP id
 d75a77b69052e-4f4abd27209mr254471961cf.34.1766566335515; Wed, 24 Dec 2025
 00:52:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223203534.1392218-2-bestswngs@gmail.com>
In-Reply-To: <20251223203534.1392218-2-bestswngs@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Dec 2025 09:52:04 +0100
X-Gm-Features: AQt7F2pL9ZxzX5oM1FVmR7FzWxKcyJ9Siw57qr-nPTlAIVNDpQGYHlXEubv67mo
Message-ID: <CANn89iKpH0MO36JHbM=vS9ga=9UzgdtFahNR4+dvNr2oUtNLuA@mail.gmail.com>
Subject: Re: [PATCH net v5] net: sock: fix hardened usercopy panic in sock_recv_errqueue
To: bestswngs@gmail.com
Cc: security@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xmei5@asu.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 9:36=E2=80=AFPM <bestswngs@gmail.com> wrote:
>
> From: Weiming Shi <bestswngs@gmail.com>
>
> skbuff_fclone_cache was created without defining a usercopy region,
> [1] unlike skbuff_head_cache which properly whitelists the cb[] field.
> [2] This causes a usercopy BUG() when CONFIG_HARDENED_USERCOPY is
> enabled and the kernel attempts to copy sk_buff.cb data to userspace
> via sock_recv_errqueue() -> put_cmsg().
>
> The crash occurs when: 1. TCP allocates an skb using alloc_skb_fclone()
>    (from skbuff_fclone_cache) [1]
> 2. The skb is cloned via skb_clone() using the pre-allocated fclone
> [3] 3. The cloned skb is queued to sk_error_queue for timestamp
> reporting 4. Userspace reads the error queue via recvmsg(MSG_ERRQUEUE)
> 5. sock_recv_errqueue() calls put_cmsg() to copy serr->ee from skb->cb
> [4] 6. __check_heap_object() fails because skbuff_fclone_cache has no
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

Nit : Next time you send a stack trace, please run it though
scripts/decode_stacktrace.sh
to get meaningful symbols.

> The crash offset 296 corresponds to skb2->cb within skbuff_fclones:
>   - sizeof(struct sk_buff) =3D 232 - offsetof(struct sk_buff, cb) =3D 40 =
-
>   offset of skb2.cb in fclones =3D 232 + 40 =3D 272 - crash offset 296 =
=3D
>   272 + 24 (inside sock_exterr_skb.ee)
>
> This patch uses a local stack variable as a bounce buffer to avoid the ha=
rdened usercopy check failure.
>
> [1] https://elixir.bootlin.com/linux/v6.12.62/source/net/ipv4/tcp.c#L885
> [2] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5=
104
> [3] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5=
566
> [4] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#L5=
491
> [5] https://elixir.bootlin.com/linux/v6.12.62/source/mm/slub.c#L5719
>
> Fixes: 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Also please next time do not CC security@kernel.org if you made the
bug public (say on netdev@kernel.org),
because security@kernel.org will be of no help.

Congratulations on your first linux contribution !

