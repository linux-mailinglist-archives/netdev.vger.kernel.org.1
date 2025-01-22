Return-Path: <netdev+bounces-160420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 424A3A19997
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 21:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741873A6C77
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 20:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCE7216389;
	Wed, 22 Jan 2025 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX+djGcC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99ED1BD9CB
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737576994; cv=none; b=llpfTRDEktWT8WXdorvgJVTtvlp/5XsWaRicYud1vK8DGwglacEmqtED/CgTyGH0hNbl3Jkq2KRuYEb5iB4+pd8Q6mTZsje4/fciL7HJyolc9tCKxVH67zbnnHtouwU90XOgAoqchNO6cIYq+dU7jc/NeAxHM3wJqQ6gj+UvkgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737576994; c=relaxed/simple;
	bh=bnkBHh+kO30cOMXIe0nolkYQ45UWkwHK9jdcmEBYXTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L296FU4gnc4s5ow/uXKkex8lr4CpIuWUaSwgPBZrpN0qJKFTR0n6B+ULpfTg9QZd0MQrsBzm5LmimT8F+WI1oucrcNxPccD0twnIavxiUVcE61Rsm0VrrmFmv9ohLYxAdWoSAa0SBpGU1+MzcfEe2WUWgTzfVo+XbEBBErI5xL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX+djGcC; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d442f9d285so2173a12.1
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 12:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737576991; x=1738181791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvxFF+MedKDsyhwM9hj2df8p6SGEPGDWsgIBwWa1tvw=;
        b=YX+djGcCxevSVC3IWQl1P3c8jT4uEN9I49sEmcTU5wLAcoKqzZ43JmUsmcuRCgygrE
         ydaKqY/nS09ptrEYNLm3waVle5cCxKOGW3WuxCVLsKtRTo6KjilEv09KatCA2mISWOA4
         HUCvvKdxaU7l8qjVp8j+HH3p8XniZ8jEersN8H6Jr/4xTGfZ/+gNRb2CCHsDt+kj3UKb
         HE8I6ebZ/UGdGXbRMVWmD9ybM54Ss/Sn3OmVqYz5/GJuDDdfNUDgixJhLoY5mtEoA9PU
         Hj1m2Jo/0T56ranT/uvvec4lZ0/97pQZotTBu36WVX+dzQzVeMDOGCOgBRBCRHbnVIwK
         tz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737576991; x=1738181791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvxFF+MedKDsyhwM9hj2df8p6SGEPGDWsgIBwWa1tvw=;
        b=wr2UBI2GfjLSyCj9piH0uoYmpDomwpepIn0jRIfeo3qAIYbO17etuEjufkvtmFt9Nd
         rv6oGRIbdsbjs+9UjLxMOZqkL+beXIE1rKyl+vnncHAh22+ZSaCNkElr3w9QdL2avxKH
         gBbnCE3yyxugFJVrtIalqGyrRNv1SnokNL6JkBqLrxUaa+ofo1NTah40V+/NG3yFabn5
         NE0TnqEhT0Nwg13OAwpkPv9p7N7lRvWWZDxkmQTBNQiRzMHzQfPgvq5+S9EQmqh+E/+y
         6x0KC+q5d40BjJ0ZwlgiTN8P2UT91wNxkINqRGiltvJ3ZO7ayrlxsc9+xZWxgZqGfZQe
         xXYw==
X-Gm-Message-State: AOJu0YwQmYY1TChUDPF4omxpOEy6E0F+aAroNfA8Mp3ITgZpXOTVelSe
	JV88x1HvCylW/l/FnayMVw71WLC3BLjz9W3jlnY7DXzbCaik/CrQiEgVBPgGdEu3A8+J30GetRG
	zdKUufwc0kPwm4VKUSOI+QN7ItMgA6oZzKVTN
X-Gm-Gg: ASbGncsRQNJtfAPFiwzevkhPy/I2nuD4xzjJn3qyR2HDMRb5ZLH6hOw/R64rPsEYlMz
	LNw9VfykiL/TGjESKTrUgJS+ssiUPE6DeDPdSIsxYjVs74r8hgVVsjLlxUjoB76oCmhu6wY2Y4m
	Iqu1J4ew==
X-Google-Smtp-Source: AGHT+IGVDsAtx/TPGRcoBM08miFjYJ8oR5PzQoPlW04ZbmYgBQKofpP5ecWUbZageftdllMed4+Z+gmrNNYYaHW1I2c=
X-Received: by 2002:a50:9f4c:0:b0:5db:e644:93fb with SMTP id
 4fb4d7f45d1cf-5dc089b5e99mr12414a12.2.1737576990846; Wed, 22 Jan 2025
 12:16:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122200402.3461154-1-maze@google.com>
In-Reply-To: <20250122200402.3461154-1-maze@google.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Wed, 22 Jan 2025 12:16:18 -0800
X-Gm-Features: AbW1kvbobbQB0gtz8LgAnVdiredSnpmy4T5bDYVyCpJq9eh5W80p2mqe2sU5QDw
Message-ID: <CANP3RGe_cspCzYe_scA37Hgr0GNbASmN94RRnPRUT1YiBcn=eg@mail.gmail.com>
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

On Wed, Jan 22, 2025 at 12:04=E2=80=AFPM Maciej =C5=BBenczykowski <maze@goo=
gle.com> wrote:
>
> We're received reports of cBPF code failing to accept DHCP packets.
> "BPF filter for DHCP not working (android14-6.1-lts + android-14.0.0_r74)=
"
>
> The relevant Android code is at:
>   https://cs.android.com/android/platform/superproject/main/+/main:packag=
es/modules/NetworkStack/jni/network_stack_utils_jni.cpp;l=3D95;drc=3D9df50a=
ef1fd163215dcba759045706253a5624f5
> which uses a lot of macros from:
>   https://cs.android.com/android/platform/superproject/main/+/main:packag=
es/modules/Connectivity/bpf/headers/include/bpf/BpfClassic.h;drc=3Dc58cfb7c=
7da257010346bd2d6dcca1c0acdc8321
>
> This is widely used and does work on the vast majority of drivers,
> but is exposing a core kernel cBPF bug related to driver skb layout.
>
> Root cause is iwlwifi driver, specifically on (at least):
>   Dell 7212: Intel Dual Band Wireless AC 8265
>   Dell 7220: Intel Wireless AC 9560
>   Dell 7230: Intel Wi-Fi 6E AX211
> delivers frames where the UDP destination port is not in the skb linear
> portion, while the cBPF code is using SKF_NET_OFF relative addressing.
>
> simplified from above, effectively:
>   BPF_STMT(BPF_LDX | BPF_B | BPF_MSH, SKF_NET_OFF)
>   BPF_STMT(BPF_LD  | BPF_H | BPF_IND, SKF_NET_OFF + 2)
>   BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, 68, 1, 0)
>   BPF_STMT(BPF_RET | BPF_K, 0)
>   BPF_STMT(BPF_RET | BPF_K, 0xFFFFFFFF)
> fails to match udp dport=3D68 packets.
>
> Specifically the 3rd cBPF instruction fails to match the condition:

2nd of course

>   if (ptr >=3D skb->head && ptr + size <=3D skb_tail_pointer(skb))
> within bpf_internal_load_pointer_neg_helper() and thus returns NULL,
> which results in reading -EFAULT.
>
> This is because bpf_skb_load_helper_{8,16,32} don't include the
> "data past headlen do skb_copy_bits()" logic from the non-negative
> offset branch in the negative offset branch.
>
> Note: I don't know sparc assembly, so this doesn't fix sparc...
> ideally we should just delete bpf_internal_load_pointer_neg_helper()
> This seems to have always been broken (but not pre-git era, since
> obviously there was no eBPF helpers back then), but stuff older
> than 5.4 is no longer LTS supported anyway, so using 5.4 as fixes tag.
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Willem de Bruijn <willemb@google.com>
> Reported-by: Matt Moeller <moeller.matt@gmail.com>
> Closes: https://issuetracker.google.com/384636719 [Treble - GKI partner i=
nternal]
> Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> Fixes: 219d54332a09 ("Linux 5.4")
> ---
>  include/linux/filter.h |  2 ++
>  kernel/bpf/core.c      | 14 +++++++++
>  net/core/filter.c      | 69 +++++++++++++++++-------------------------
>  3 files changed, 43 insertions(+), 42 deletions(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index a3ea46281595..c24d8e338ce4 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1479,6 +1479,8 @@ static inline u16 bpf_anc_helper(const struct sock_=
filter *ftest)
>  void *bpf_internal_load_pointer_neg_helper(const struct sk_buff *skb,
>                                            int k, unsigned int size);
>
> +int bpf_internal_neg_helper(const struct sk_buff *skb, int k);
> +
>  static inline int bpf_tell_extensions(void)
>  {
>         return SKF_AD_MAX;
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index da729cbbaeb9..994988dabb97 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -89,6 +89,20 @@ void *bpf_internal_load_pointer_neg_helper(const struc=
t sk_buff *skb, int k, uns
>         return NULL;
>  }
>
> +int bpf_internal_neg_helper(const struct sk_buff *skb, int k)
> +{
> +       if (k >=3D 0)
> +               return k;
> +       if (k >=3D SKF_NET_OFF)
> +               return skb->network_header + k - SKF_NET_OFF;
> +       if (k >=3D SKF_LL_OFF) {
> +               if (unlikely(!skb_mac_header_was_set(skb)))
> +                       return -1;
> +               return skb->mac_header + k - SKF_LL_OFF;
> +       }
> +       return -1;
> +}
> +
>  /* tell bpf programs that include vmlinux.h kernel's PAGE_SIZE */
>  enum page_size_enum {
>         __PAGE_SIZE =3D PAGE_SIZE
> diff --git a/net/core/filter.c b/net/core/filter.c
> index e56a0be31678..609ef7df71ce 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -221,21 +221,16 @@ BPF_CALL_3(bpf_skb_get_nlattr_nest, struct sk_buff =
*, skb, u32, a, u32, x)
>  BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, const voi=
d *,
>            data, int, headlen, int, offset)
>  {
> -       u8 tmp, *ptr;
> -       const int len =3D sizeof(tmp);
> -
> -       if (offset >=3D 0) {
> -               if (headlen - offset >=3D len)
> -                       return *(u8 *)(data + offset);
> -               if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> -                       return tmp;
> -       } else {
> -               ptr =3D bpf_internal_load_pointer_neg_helper(skb, offset,=
 len);
> -               if (likely(ptr))
> -                       return *(u8 *)ptr;
> -       }
> +       u8 tmp;
>
> -       return -EFAULT;
> +       offset =3D bpf_internal_neg_helper(skb, offset);
> +       if (unlikely(offset < 0))
> +               return -EFAULT;
> +       if (headlen - offset >=3D sizeof(u8))
> +               return *(u8 *)(data + offset);
> +       if (skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> +               return -EFAULT;
> +       return tmp;
>  }
>
>  BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
> @@ -248,21 +243,16 @@ BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const st=
ruct sk_buff *, skb,
>  BPF_CALL_4(bpf_skb_load_helper_16, const struct sk_buff *, skb, const vo=
id *,
>            data, int, headlen, int, offset)
>  {
> -       __be16 tmp, *ptr;
> -       const int len =3D sizeof(tmp);
> +       __be16 tmp;
>
> -       if (offset >=3D 0) {
> -               if (headlen - offset >=3D len)
> -                       return get_unaligned_be16(data + offset);
> -               if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> -                       return be16_to_cpu(tmp);
> -       } else {
> -               ptr =3D bpf_internal_load_pointer_neg_helper(skb, offset,=
 len);
> -               if (likely(ptr))
> -                       return get_unaligned_be16(ptr);
> -       }
> -
> -       return -EFAULT;
> +       offset =3D bpf_internal_neg_helper(skb, offset);
> +       if (unlikely(offset < 0))
> +               return -EFAULT;
> +       if (headlen - offset >=3D sizeof(__be16))
> +               return get_unaligned_be16(data + offset);
> +       if (skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> +               return -EFAULT;
> +       return be16_to_cpu(tmp);
>  }
>
>  BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, skb,
> @@ -275,21 +265,16 @@ BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const s=
truct sk_buff *, skb,
>  BPF_CALL_4(bpf_skb_load_helper_32, const struct sk_buff *, skb, const vo=
id *,
>            data, int, headlen, int, offset)
>  {
> -       __be32 tmp, *ptr;
> -       const int len =3D sizeof(tmp);
> -
> -       if (likely(offset >=3D 0)) {
> -               if (headlen - offset >=3D len)
> -                       return get_unaligned_be32(data + offset);
> -               if (!skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> -                       return be32_to_cpu(tmp);
> -       } else {
> -               ptr =3D bpf_internal_load_pointer_neg_helper(skb, offset,=
 len);
> -               if (likely(ptr))
> -                       return get_unaligned_be32(ptr);
> -       }
> +       __be32 tmp;
>
> -       return -EFAULT;
> +       offset =3D bpf_internal_neg_helper(skb, offset);
> +       if (unlikely(offset < 0))
> +               return -EFAULT;
> +       if (headlen - offset >=3D sizeof(__be32))
> +               return get_unaligned_be32(data + offset);
> +       if (skb_copy_bits(skb, offset, &tmp, sizeof(tmp)))
> +               return -EFAULT;
> +       return be32_to_cpu(tmp);
>  }
>
>  BPF_CALL_2(bpf_skb_load_helper_32_no_cache, const struct sk_buff *, skb,
> --
> 2.48.1.262.g85cc9f2d1e-goog
>

Note: this is currently only compile and boot tested.
Which doesn't prove all that much ;-)

- Maciej

