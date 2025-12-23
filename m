Return-Path: <netdev+bounces-245838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D09BCD8FF6
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E1B73009873
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 10:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FBC33D509;
	Tue, 23 Dec 2025 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJ+1KJxe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E4E1AAE17
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 10:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487578; cv=none; b=MtrLG+lEeO9s24fHVs9dE8JBe1y192mgKolm7ILbU4828lW0Zagy4Ycv5LQ7hsJgj9I1waZqNXbqU/r1giy+FDTXy3+L4zBQ5wQaavfVKC396IpEPA1aX8Kb4B5QPR/AdrDBLv38OtJWPh0xG7PqfPzrG+opK4duSoYVqh2SCeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487578; c=relaxed/simple;
	bh=yb3lv89dBsT+K2m2AAbBnbM3ANJA32SNekzkC5Sz5z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jg98cFROE22QpYY2S11O5Lck5b+8yQsMKlkCDtPjBy4Iko2oy7B98usej4GMlBVCCvHAbcOS8fXnilgRStIRVBRJVsu+0M/dp0VDxlagM8DTKtDRx6RBBNXv+t1s3N2depqNHVhV4rtMLJsnqOl2AM/a2fIFxwYPgJNrUHoSidw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mJ+1KJxe; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b5c81bd953so588531685a.1
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 02:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766487575; x=1767092375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72hnEfRSEAkoO/n5JvhNNrAsCjlUGLUS/9NdecNTndY=;
        b=mJ+1KJxelBIgNIIJTPz194YC6vDL4XEjQlxF4//fZ80+hHnnIFP+ndKl9eWufHzz7I
         1+IV1Gdxp9zlZubLp+YHl3Uzkpdgf+jX2ASsg+XUf90fyXT5Jbzm+TrvtPg7HEt5s8+F
         RUgrbH4bjpBTZqpc9L+9Jf3KKjU2IPIKlyJwjaaSq9ypLsNbrtlKI8f0MQPifqKWUdjy
         aILNyj1GiDV/SWavV7NaIAWtFkVg0prMvemj7dlUx3HDs+a+FqghPMIleWv8jxRCc47k
         XkH29JZQfmHcvMLdcyJqREw0WIoOkOs5o4+Ohwl5W39BLyHO7yNuvBpkGFxD5Gq8G0IL
         6wmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766487575; x=1767092375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=72hnEfRSEAkoO/n5JvhNNrAsCjlUGLUS/9NdecNTndY=;
        b=OfOB1rQkRB48jt11wxf2bd79tNDBilZbyc8pPvKRVg030pKkHys3esJ6IMOGE3HQUb
         Zq3rLzdT96ec6PnwJOpxQPGFjjIM+uRClOCE9hjuqzoGWTH6Z2jBTazHoDcEtZkY30v1
         p47R+ySVbQjcqDb2LwcWt2GDZQsjvERJ60oy5oXbyIjNSiDUTEioKTnkUzfz8xM6wlYW
         zh6uaqcXr61J3+eqZWY712B488fOGyTImSJf3EH2nD8Yl9CC9nJx4ohVinOWPyq72alL
         /ev7bLdu0LQVIol8LqwPrdY5Dq58hEEvLs74k0NJJzvSY9i/rOUTqK7PXVr5ZqkR91G+
         LYFA==
X-Forwarded-Encrypted: i=1; AJvYcCV0JMzyXmhV3litOZ3iFtEoKc/MJClt/oWtrnQI/U1DlLDJG2pzujBsda+fy2SoWOylRGXLgag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhKLT6cH02xDJePp8rfE4SzzLIfcjML8rtihYShcqzA8c5ehwU
	BqO/RRUvF8vv3nG/qj7i2IZO0ymNxHst+jMjCeXDao0QiiQdH3d71IpMzhmbqhufIQGX0eWBMbA
	BycJr/Ch3pr9jJHdJ6YtxVEak9qo+Sisz3qGXHUAQ
X-Gm-Gg: AY/fxX70GozRQUHn1xc206R0y/mln5PGMxHrWBq5ehwD+lCk9N6ShbQGX5y+0xQ9Dq4
	Itpzh0/8nNOxsLWP/sEwZyNzKrpv+sCbR5haPURKnTPMYqElPY6UqdTyr7ZVfgp7bhVjKh6Rs3d
	0gz+JhadBOMBHJfCkW7MYP4uJIZgBFnjSaWDKD/caFbc+dGsxFfSyHwalFhrLbM02rxbg2oIyKu
	8qCQs1cj4rZLYhMdEkrSVXYBbO8/7l9sOcUEfn9DBMmmeb8rj+yth1uCogJit9C1zBrmg==
X-Google-Smtp-Source: AGHT+IGH4PhEeySNYaGv4iD0lt5jMj/ApM2nKk8sph10vDnL95Sc8qgz0qd6deNdEwVMeLlhCcrPxF/PpIx+IZ4T2rw=
X-Received: by 2002:a05:622a:2443:b0:4ed:b7d6:7c6d with SMTP id
 d75a77b69052e-4f4abd27209mr206881431cf.34.1766487575262; Tue, 23 Dec 2025
 02:59:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216084449.973244-5-bestswngs@gmail.com> <d7ea6222-607f-433e-a70d-b3632a80b4b9@redhat.com>
In-Reply-To: <d7ea6222-607f-433e-a70d-b3632a80b4b9@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Dec 2025 11:59:23 +0100
X-Gm-Features: AQt7F2o7E-1QX1jduXvxLUj4LeJO-WJKiphyesR-PtLgaj55h4VFz-kWAqoS1F4
Message-ID: <CANn89iLfPmEW6-sSgZXXFn5H72xc_5H4w+qvA5dMjcARBB7v9A@mail.gmail.com>
Subject: Re: [PATCH net v4] net: skbuff: add usercopy region to skbuff_fclone_cache
To: Paolo Abeni <pabeni@redhat.com>
Cc: bestswngs@gmail.com, security@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xmei5@asu.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 11:34=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 12/16/25 9:44 AM, bestswngs@gmail.com wrote:
> > From: Weiming Shi <bestswngs@gmail.com>
> >
> > skbuff_fclone_cache was created without defining a usercopy region, [1]
> > unlike skbuff_head_cache which properly whitelists the cb[] field.  [2]
> > This causes a usercopy BUG() when CONFIG_HARDENED_USERCOPY is enabled
> > and the kernel attempts to copy sk_buff.cb data to userspace via
> > sock_recv_errqueue() -> put_cmsg().
> >
> > The crash occurs when:
> > 1. TCP allocates an skb using alloc_skb_fclone()
> >    (from skbuff_fclone_cache) [1]
> > 2. The skb is cloned via skb_clone() using the pre-allocated fclone [3]
> > 3. The cloned skb is queued to sk_error_queue for timestamp reporting
> > 4. Userspace reads the error queue via recvmsg(MSG_ERRQUEUE)
> > 5. sock_recv_errqueue() calls put_cmsg() to copy serr->ee from skb->cb =
[4]
> > 6. __check_heap_object() fails because skbuff_fclone_cache has no
> >    usercopy whitelist [5]
> >
> > When cloned skbs allocated from skbuff_fclone_cache are used in the
> > socket error queue, accessing the sock_exterr_skb structure in skb->cb
> > via put_cmsg() triggers a usercopy hardening violation:
> >
> > [    5.379589] usercopy: Kernel memory exposure attempt detected from S=
LUB object 'skbuff_fclone_cache' (offset 296, size 16)!
> > [    5.382796] kernel BUG at mm/usercopy.c:102!
> > [    5.383923] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> > [    5.384903] CPU: 1 UID: 0 PID: 138 Comm: poc_put_cmsg Not tainted 6.=
12.57 #7
> > [    5.384903] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > [    5.384903] RIP: 0010:usercopy_abort+0x6c/0x80
> > [    5.384903] Code: 1a 86 51 48 c7 c2 40 15 1a 86 41 52 48 c7 c7 c0 15=
 1a 86 48 0f 45 d6 48 c7 c6 80 15 1a 86 48 89 c1 49 0f 45 f3 e8 84 27 88 ff=
 <0f> 0b 490
> > [    5.384903] RSP: 0018:ffffc900006f77a8 EFLAGS: 00010246
> > [    5.384903] RAX: 000000000000006f RBX: ffff88800f0ad2a8 RCX: 1ffffff=
ff0f72e74
> > [    5.384903] RDX: 0000000000000000 RSI: 0000000000000004 RDI: fffffff=
f87b973a0
> > [    5.384903] RBP: 0000000000000010 R08: 0000000000000000 R09: fffffbf=
ff0f72e74
> > [    5.384903] R10: 0000000000000003 R11: 79706f6372657375 R12: 0000000=
000000001
> > [    5.384903] R13: ffff88800f0ad2b8 R14: ffffea00003c2b40 R15: ffffea0=
0003c2b00
> > [    5.384903] FS:  0000000011bc4380(0000) GS:ffff8880bf100000(0000) kn=
lGS:0000000000000000
> > [    5.384903] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    5.384903] CR2: 000056aa3b8e5fe4 CR3: 000000000ea26004 CR4: 0000000=
000770ef0
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
> > The crash offset 296 corresponds to skb2->cb within skbuff_fclones:
> >   - sizeof(struct sk_buff) =3D 232
> >   - offsetof(struct sk_buff, cb) =3D 40
> >   - offset of skb2.cb in fclones =3D 232 + 40 =3D 272
> >   - crash offset 296 =3D 272 + 24 (inside sock_exterr_skb.ee)
> >
> > Fix this by using kmem_cache_create_usercopy() for skbuff_fclone_cache
> > and whitelisting the cb regions.
> > In our patch, we referenced
> >     net: Whitelist the `skb_head_cache` "cb" field. [6]
> >
> > Fix by using kmem_cache_create_usercopy() with the same cb[] region
> > whitelist as skbuff_head_cache.
> >
> > [1] https://elixir.bootlin.com/linux/v6.12.62/source/net/ipv4/tcp.c#L88=
5
> > [2] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#=
L5104
> > [3] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#=
L5566
> > [4] https://elixir.bootlin.com/linux/v6.12.62/source/net/core/skbuff.c#=
L5491
> > [5] https://elixir.bootlin.com/linux/v6.12.62/source/mm/slub.c#L5719
> > [6] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/co=
mmit/?id=3D79a8a642bf05c
> >
> > Fixes: 6d07d1cd300f ("usercopy: Restrict non-usercopy caches to size 0"=
)
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>
> Rephrasing Eric's comment (and hoping to have not misread it), you
> should fix the issue differently, catching and fclones before adding
> them to the error queue and try to unclone them.

Instead of opening/weakening skbuff_clone to wide user copies, I would rath=
er
use what we did in:

commit 2558b8039d059342197610498c8749ad294adee5
Author: Eric Dumazet <edumazet@google.com>
Date:   Mon Feb 13 16:00:59 2023 +0000

    net: use a bounce buffer for copying skb->mark

ie :

diff --git a/net/core/sock.c b/net/core/sock.c
index 45c98bf524b2..a1c8b47b0d56 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3896,7 +3896,7 @@ void sock_enable_timestamp(struct sock *sk, enum
sock_flags flag)
 int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len,
                       int level, int type)
 {
-       struct sock_exterr_skb *serr;
+       struct sock_extended_err ee;
        struct sk_buff *skb;
        int copied, err;

@@ -3916,8 +3916,9 @@ int sock_recv_errqueue(struct sock *sk, struct
msghdr *msg, int len,

        sock_recv_timestamp(msg, sk, skb);

-       serr =3D SKB_EXT_ERR(skb);
-       put_cmsg(msg, level, type, sizeof(serr->ee), &serr->ee);
+       /* We must use a bounce buffer for CONFIG_HARDENED_USERCOPY=3Dy */
+       ee =3D SKB_EXT_ERR(skb)->ee;
+       put_cmsg(msg, level, type, sizeof(ee), &ee);

        msg->msg_flags |=3D MSG_ERRQUEUE;
        err =3D copied;

