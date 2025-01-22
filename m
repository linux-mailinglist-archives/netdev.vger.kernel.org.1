Return-Path: <netdev+bounces-160422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EB0A199DE
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 21:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472A018807D6
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 20:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C096215F51;
	Wed, 22 Jan 2025 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atCCS+0t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853E41EB2F
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737577696; cv=none; b=QoQekgRI5xMWMjH5e8Y/VjY/AyChbZIhjfaz56TZqv1swrKHFx2cVg9pk94PUJroZ/aXtM9m0f4RwUF4VHCgBTmcG1huR8XAJS6ICgjppk8NchJRytqJqIEwTDlGEunJ5sMQ4YkJhiG8YOhnM5T+nXpzqT/gZxj4mbLikpwf4AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737577696; c=relaxed/simple;
	bh=/YPZpuPIfJJ/vumEjVWDC+BfBdsnB3LjtZLGaKBkY8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQetVPiCxVon/oete6sNhNRzhVkp0dbqJRGT6zNl6t0k1v6rX8p5CX0haFwbHSehg4gil65QyUNDOj2QPlhqvAqNzETGH1IHO344zMFSruy3gs7aPrOZIx258uQvHjDKWQvuw4E6WEhpGaqJdfnneHUBuyzc7ApiPuPNXTaC7bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atCCS+0t; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so2166a12.0
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 12:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737577693; x=1738182493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ekrRrmZziqbuSCTmhQp5RyticvB3K0bAHQxfD25N8E=;
        b=atCCS+0tcU5A0SPUbgZmDKGDXAz9s48T4hRjaGEqPf1hNxaKKxOfJVQfXvcB9WHAiO
         59bQ9JZ2jrrsalcM0f7J31oJSXo/Zb6tPLbwHpDjlWiRRU78NlRu6iCyZcvrQCGH/F01
         jRejQmUmVGTvJm2SvUdYa7pVE1ql6o8t7oItT8g4HG8RoqJ0vyv7HeB4M2pU/0rfYWyK
         thUWvxpPn8+bCbrhghvFvw3h6zfYYZWuJXrTXwUmkGMp1HzMIhfUNruuRwHZTKLqMprP
         7oonU/cIxsZtTv6MLxfFAEy06J+uy96qpcAyXQyOuPGKkAfw9IudxEOOk0PFLLldeVVP
         DwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737577693; x=1738182493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ekrRrmZziqbuSCTmhQp5RyticvB3K0bAHQxfD25N8E=;
        b=fdnBnfc6DXNuZpX3v9QLHf/7vMZsqf/vY0V6UQwPoGQzyxh22MrWQnrnGafV8zBQSx
         uL2C6QvgHC3+KMM0wbl1Ge0rIPxh8ae6DqMRY9shjv548rrkMS2/Y37oE1vgoY7Tfw1s
         /7IIByoI1bzOlZ/yJMRDzopIyEtqNS5T8iR4hJo6IeUWy6ALyicrBA9qngKcgiL2O1Ka
         RTNIQdlJf00ceyR7nS17rnEpZABJu1uD1HXzqERHX5BGqrCuMAM9KmJLNM4tdhLAb8TZ
         3vyN1+JXetZf+MQZX2UffKz9ZGuIv7W9ps18NtWYW78VmY2mGQ+eruM7GLuBHpXJiuXc
         ahLA==
X-Gm-Message-State: AOJu0YzH/7U1fRfLLIQG1ueBKDIDEvanIgIgPwywqt99y3oL57hJbif+
	qK/Ix41Wc/6XpbtP18coTy3S3V25nuGr9CX8LnX4rIZanIYe/2a0nHXzmFnjl50PIOFjhGRae17
	XU4YFnpcmWYIKw9ohNIN4eDj9yYZ4+AXd9MyW
X-Gm-Gg: ASbGnct6AijA4+9PAFwHTELtluwIh+h44Cci1lzNyJ+/Wl4Pe0/MU1ds2KymYCMsC+C
	i338MOLHMX7Timg8gUFYoR/IjmIi94SqeP2VSRytOozGCP23f4mFpSjYDbv01D8PqaifGUwqFo8
	B0rBxJxw==
X-Google-Smtp-Source: AGHT+IEmW+n0QEnyPDpGXEihELBYJzxmdEhQvWlAcdxutr1W5ZCn5RP9Qk3RvKu9rcljQYt36V08Ykj5wuXFOL7ldsc=
X-Received: by 2002:a50:bb06:0:b0:5db:68bc:eb2d with SMTP id
 4fb4d7f45d1cf-5dc09c7987dmr14150a12.3.1737577692626; Wed, 22 Jan 2025
 12:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122200402.3461154-1-maze@google.com> <CANP3RGe_cspCzYe_scA37Hgr0GNbASmN94RRnPRUT1YiBcn=eg@mail.gmail.com>
In-Reply-To: <CANP3RGe_cspCzYe_scA37Hgr0GNbASmN94RRnPRUT1YiBcn=eg@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Wed, 22 Jan 2025 12:28:00 -0800
X-Gm-Features: AbW1kvZ9JF94tZWFPtIX4bBu9Y5sLhYgQSen7ZPl5uqBc0xo8HLutuU7W0rGX90
Message-ID: <CANP3RGc7-ZkQ2xGtkW00+A+zcWpm4WdMEbSn=UjotBQHzO+f7w@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix classic bpf reads from negative offset
 outside of linear skb portion
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Matt Moeller <moeller.matt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 12:16=E2=80=AFPM Maciej =C5=BBenczykowski
<zenczykowski@gmail.com> wrote:
>
> On Wed, Jan 22, 2025 at 12:04=E2=80=AFPM Maciej =C5=BBenczykowski <maze@g=
oogle.com> wrote:
> >
> > We're received reports of cBPF code failing to accept DHCP packets.
> > "BPF filter for DHCP not working (android14-6.1-lts + android-14.0.0_r7=
4)"
> >
> > The relevant Android code is at:
> >   https://cs.android.com/android/platform/superproject/main/+/main:pack=
ages/modules/NetworkStack/jni/network_stack_utils_jni.cpp;l=3D95;drc=3D9df5=
0aef1fd163215dcba759045706253a5624f5
> > which uses a lot of macros from:
> >   https://cs.android.com/android/platform/superproject/main/+/main:pack=
ages/modules/Connectivity/bpf/headers/include/bpf/BpfClassic.h;drc=3Dc58cfb=
7c7da257010346bd2d6dcca1c0acdc8321
> >
> > This is widely used and does work on the vast majority of drivers,
> > but is exposing a core kernel cBPF bug related to driver skb layout.
> >
> > Root cause is iwlwifi driver, specifically on (at least):
> >   Dell 7212: Intel Dual Band Wireless AC 8265
> >   Dell 7220: Intel Wireless AC 9560
> >   Dell 7230: Intel Wi-Fi 6E AX211
> > delivers frames where the UDP destination port is not in the skb linear
> > portion, while the cBPF code is using SKF_NET_OFF relative addressing.
> >
> > simplified from above, effectively:
> >   BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, SKF_NET_OFF)
> >   BPF_STMT(BPF_LD  | BPF_H | BPF_IND, SKF_NET_OFF + 2)
> >   BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 68, 1, 0)
> >   BPF_STMT(BPF_RET | BPF_K, 0)
> >   BPF_STMT(BPF_RET | BPF_K, 0xFFFFFFFF)
> > fails to match udp dport=3D68 packets.
> >
> > Specifically the 3rd cBPF instruction fails to match the condition:
>
> 2nd of course
>
> >   if (ptr >=3D skb->head && ptr + size <=3D skb_tail_pointer(skb))
> > within bpf_internal_load_pointer_neg_helper() and thus returns NULL,
> > which results in reading -EFAULT.
> >
> > This is because bpf_skb_load_helper_{8,16,32} don't include the
> > "data past headlen do skb_copy_bits()" logic from the non-negative
> > offset branch in the negative offset branch.
> >
> > Note: I don't know sparc assembly, so this doesn't fix sparc...
> > ideally we should just delete bpf_internal_load_pointer_neg_helper()
> > This seems to have always been broken (but not pre-git era, since
> > obviously there was no eBPF helpers back then), but stuff older
> > than 5.4 is no longer LTS supported anyway, so using 5.4 as fixes tag.
> >
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Reported-by: Matt Moeller <moeller.matt@gmail.com>
> > Closes: https://issuetracker.google.com/384636719 [Treble - GKI partner=
 internal]
> > Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> > Fixes: 219d54332a09 ("Linux 5.4")
> > ---
> >  include/linux/filter.h |  2 ++
> >  kernel/bpf/core.c      | 14 +++++++++
> >  net/core/filter.c      | 69 +++++++++++++++++-------------------------
> >  3 files changed, 43 insertions(+), 42 deletions(-)
> >
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index a3ea46281595..c24d8e338ce4 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -1479,6 +1479,8 @@ static inline u16 bpf_anc_helper(const struct soc=
k_filter *ftest)
> >  void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb,
> >                                            int k, unsigned int size);
> >
> > +int bpf_internal_neg_helper(const struct sk_buff *skb, int k);
> > +
> >  static inline int bpf_tell_extensions(void)
> >  {
> >         return SKF_AD_MAX;
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index da729cbbaeb9..994988dabb97 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -89,6 +89,20 @@ void *bpf_internal_load_pointer_neg_helper(const str=
uct sk_buff *skb, int k, uns
> >         return NULL;
> >  }
> >
> > +int bpf_internal_neg_helper(const struct sk_buff *skb, int k)
> > +{
> > +       if (k >=3D 0)
> > +               return k;
> > +       if (k >=3D SKF_NET_OFF)
> > +               return skb->network_header + k - SKF_NET_OFF;
> > +       if (k >=3D SKF_LL_OFF) {
> > +               if (unlikely(!skb_mac_header_was_set(skb)))
> > +                       return -1;
> > +               return skb->mac_header + k - SKF_LL_OFF;
> > +       }
> > +       return -1;
> > +}
> > +
> >  /* tell bpf programs that include vmlinux.h kernel's PAGE_SIZE */
> >  enum page_size_enum {
> >         __PAGE_SIZE =3D PAGE_SIZE
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index e56a0be31678..609ef7df71ce 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -221,21 +221,16 @@ BPF_CALL_3(bpf_skb_get_nlattr_nest, struct sk_buf=
f *, skb, u32, a, u32, x)
> >  BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, const v=
oid *,
> >            data, int, headlen, int, offset)
> >  {
> > -       u8 tmp, *ptr;
> > -       const int len =3D sizeof(tmp);
> > -
> > -       if (offset >=3D 0) {
> > -               if (headlen - offset >=3D len)
> > -                       return *(u8 *)(data + offset);
> > -               if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > -                       return tmp;
> > -       } else {
> > -               ptr =3D bpf_internal_load_pointer_neg_helper(skb, offse=
t, len);
> > -               if (likely(ptr))
> > -                       return *(u8 *)ptr;
> > -       }
> > +       u8 tmp;
> >
> > -       return -EFAULT;
> > +       offset =3D bpf_internal_neg_helper(skb, offset);
> > +       if (unlikely(offset < 0))
> > +               return -EFAULT;
> > +       if (headlen - offset >=3D sizeof(u8))
> > +               return *(u8 *)(data + offset);
> > +       if (skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > +               return -EFAULT;
> > +       return tmp;
> >  }
> >
> >  BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb=
,
> > @@ -248,21 +243,16 @@ BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const =
struct sk_buff *, skb,
> >  BPF_CALL_4(bpf_skb_load_helper_16, const struct sk_buff *, skb, const =
void *,
> >            data, int, headlen, int, offset)
> >  {
> > -       __be16 tmp, *ptr;
> > -       const int len =3D sizeof(tmp);
> > +       __be16 tmp;
> >
> > -       if (offset >=3D 0) {
> > -               if (headlen - offset >=3D len)
> > -                       return get_unaligned_be16(data + offset);
> > -               if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > -                       return be16_to_cpu(tmp);
> > -       } else {
> > -               ptr =3D bpf_internal_load_pointer_neg_helper(skb, offse=
t, len);
> > -               if (likely(ptr))
> > -                       return get_unaligned_be16(ptr);
> > -       }
> > -
> > -       return -EFAULT;
> > +       offset =3D bpf_internal_neg_helper(skb, offset);
> > +       if (unlikely(offset < 0))
> > +               return -EFAULT;
> > +       if (headlen - offset >=3D sizeof(__be16))
> > +               return get_unaligned_be16(data + offset);
> > +       if (skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > +               return -EFAULT;
> > +       return be16_to_cpu(tmp);
> >  }
> >
> >  BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, sk=
b,
> > @@ -275,21 +265,16 @@ BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const=
 struct sk_buff *, skb,
> >  BPF_CALL_4(bpf_skb_load_helper_32, const struct sk_buff *, skb, const =
void *,
> >            data, int, headlen, int, offset)
> >  {
> > -       __be32 tmp, *ptr;
> > -       const int len =3D sizeof(tmp);
> > -
> > -       if (likely(offset >=3D 0)) {
> > -               if (headlen - offset >=3D len)
> > -                       return get_unaligned_be32(data + offset);
> > -               if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > -                       return be32_to_cpu(tmp);
> > -       } else {
> > -               ptr =3D bpf_internal_load_pointer_neg_helper(skb, offse=
t, len);
> > -               if (likely(ptr))
> > -                       return get_unaligned_be32(ptr);
> > -       }
> > +       __be32 tmp;
> >
> > -       return -EFAULT;
> > +       offset =3D bpf_internal_neg_helper(skb, offset);
> > +       if (unlikely(offset < 0))
> > +               return -EFAULT;
> > +       if (headlen - offset >=3D sizeof(__be32))
> > +               return get_unaligned_be32(data + offset);
> > +       if (skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> > +               return -EFAULT;
> > +       return be32_to_cpu(tmp);
> >  }
> >
> >  BPF_CALL_2(bpf_skb_load_helper_32_no_cache, const struct sk_buff *, sk=
b,
> > --
> > 2.48.1.262.g85cc9f2d1e-goog
> >
>
> Note: this is currently only compile and boot tested.
> Which doesn't prove all that much ;-)

Furthermore even after cherrypicking this (or a similar style fix)
into older LTS:
- sparc jit is (presumably, maybe only 32-bit) still broken, as the
assembly uses the old function
- same for mips jit on 5.4/5.10/5.15
- same for powerpc jit on 5.4/5.10

(but I would guess we don't care)

