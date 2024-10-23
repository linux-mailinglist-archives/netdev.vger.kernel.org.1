Return-Path: <netdev+bounces-138233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284929ACAA7
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4CB1C204F9
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596FA1ABEC2;
	Wed, 23 Oct 2024 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Acl7PTL4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A919B19F128;
	Wed, 23 Oct 2024 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729688385; cv=none; b=p0/MPyI5ggQpQZxZf5MlDxz26JB6geNPNezcxAgEG1sHVrmmT192tvSL7IUHkdwozwC3XICBLKtDUUw8pY/xJisSyImJim1fSAO9cjeT5w16XPll8EG2vHr5Hvj+FFR10Anua9DrL/1t5CNVapHGgkBv9jr0SRAoUqw9i2J1rFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729688385; c=relaxed/simple;
	bh=3oa8Leei3NJJNtKIKDDThyy6c+pB58h2gSEuVKYNfB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEfrxIPBnPpwp/Xrv7EytVkBDtBvBBZvhTnnsUsIr0Mc0biGVbSd0KCCRqXyFaivNB1ttiDhzbHdImIBqoimB8ECD/X/oiDSaRxOwSPi/eihZ7Sal7IhgY9NZrtrFlU2pok+UPltTf0r/nGLmaLBzuTYmTKCIbHFgURW/thGrKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Acl7PTL4; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-6e38ebcc0abso75632357b3.2;
        Wed, 23 Oct 2024 05:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729688383; x=1730293183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4DJT8BxkVRQ/cAmVHD8/GaR9GRwN8z9DhbG7As1RPA=;
        b=Acl7PTL4wQWQ2iOSt7Y7ZZ0mYyPIZs7eXxTeMmmOlmorOMXHJMiP7o0uVY5Q4dzEmJ
         yfDjzZ9EL4YID0pIDkmhznZbv28ywf5kLuT4z8U+roaXEd+KwsmhbMTtvd1r6ohf6A87
         sbaBwKsUlGjgj7KdoNweubp6pDKhmTjcJnxmeiC2Yxwcni99IIfwnWz3M5DLNY5M9k/7
         BJMvj7qjsHlAOGnu3wDTVGxBkmKnNXo6nr7QXvQapZCpA3/3BO8EBN6JReOYDGqGZ4Ne
         V5Nosj3iUkoQnBBzgULTaILoFrQvFVywFl9MFGz4/TbqSAx1kh5bXYiEILPc5hUVDs+v
         p3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729688383; x=1730293183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4DJT8BxkVRQ/cAmVHD8/GaR9GRwN8z9DhbG7As1RPA=;
        b=aemutgyH1N5CRxgpYEef3LvLb958RrJ/K1Ulc6h/HyKdh/SH+7lt2Et6XkWt5wD8aj
         ymu1jFS0zUa70a1+KLre8nXOKC3jkGHAQvzXPiPsrzJFrs+bqgDjAWI4rUX4fGKd2H/H
         YmlOOdCGHX7k4DFIA0lstgJ3edgwkemQuVVqPJkqVCt1B2kqYOonxR7FDm6laep7lrRG
         mK+waovq/4NIRirK5iNdYafPKYXcsIeYDYxSfxS94I25xcFJlSzzSwG0XmLnZTfpZYjP
         GF+/ecBvcjTfJ8Yxxi3mwL1b/N5m7A+N/Q7A6bK5ywYpwGlF7v9+sKFxRQq9Q3DJGM53
         vzVw==
X-Forwarded-Encrypted: i=1; AJvYcCV4NdgwQJvO6PtP7ug3I3w/o5DkvfDLESVa1jq4rdk4qiHmczqRwbB8BJzLuaUoAtwSNvvz/I4Nohhd+ykEvXl+Ehg=@vger.kernel.org, AJvYcCWsX20Zca1UiD9VWxHXffw2jO8RV14SLcLs1OAfMRXXt6KY9HQhgUHAZkW5WPwBVBHU17RPpO4E@vger.kernel.org
X-Gm-Message-State: AOJu0YwHa1RKl46ejwFfNmoEddRPb8/zDrfU6VrhKoGiE+Z+8FPiLM8H
	5ghtd3j7gBA9H6VO7hUkIy+2o4VjCKGbi85nil/mheMM5B/ASLVSOm+4y4aI+kAxZ/Q6Sf/+Tnq
	/+dPONsGJdB5TUlqoLtcWqmAtGSo=
X-Google-Smtp-Source: AGHT+IGM3gfm8ZAnmDOBp/u4OR1D4E742kNwplG3h23ACX//IvRsTs2YkNZpypTMWx8bNFp6lc2mrlYY+wozSKYCPFo=
X-Received: by 2002:a05:690c:2a8b:b0:6e2:43ea:552 with SMTP id
 00721157ae682-6e7f0e11519mr20019767b3.16.1729688382711; Wed, 23 Oct 2024
 05:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023123212.15908-1-laoar.shao@gmail.com>
In-Reply-To: <20241023123212.15908-1-laoar.shao@gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 23 Oct 2024 21:00:38 +0800
Message-ID: <CADxym3YB4ywpSp92Zctmh_k1K5OL7vTUAadFOsFuV=RdEvvwgA@mail.gmail.com>
Subject: Re: [PATCH] net: Add tcp_drop_reason tracepoint
To: Yafang Shao <laoar.shao@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 8:33=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> We previously hooked the tcp_drop_reason() function using BPF to monitor
> TCP drop reasons. However, after upgrading our compiler from GCC 9 to GCC
> 11, tcp_drop_reason() is now inlined, preventing us from hooking into it.
> To address this, it would be beneficial to introduce a dedicated tracepoi=
nt
> for monitoring.

Hello,

Can the existing tracepoint kfree_skb do this work? AFAIK, you
can attach you BPF to the kfree_skb tracepoint and do some filter
according to the "protocol" field, or the information "sk" field. And
this works fine in my tool.

I hope I'm not missing something :/

BTW, I do such filter in probe_parse_skb_sk() in
https://github.com/OpenCloudOS/nettrace/blob/master/shared/bpf/skb_parse.h

Thanks!
Menglong Dong
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Menglong Dong <menglong8.dong@gmail.com>
> ---
>  include/trace/events/tcp.h | 53 ++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp_input.c       |  1 +
>  2 files changed, 54 insertions(+)
>
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index a27c4b619dff..056f7026224c 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -12,6 +12,7 @@
>  #include <net/tcp.h>
>  #include <linux/sock_diag.h>
>  #include <net/rstreason.h>
> +#include <net/dropreason-core.h>
>
>  /*
>   * tcp event with arguments sk and skb
> @@ -728,6 +729,58 @@ DEFINE_EVENT(tcp_ao_event_sne, tcp_ao_rcv_sne_update=
,
>         TP_ARGS(sk, new_sne)
>  );
>
> +#undef FN
> +#undef FNe
> +#define FN(reason)     { SKB_DROP_REASON_##reason, #reason },
> +#define FNe(reason)    { SKB_DROP_REASON_##reason, #reason }
> +
> +TRACE_EVENT(tcp_drop_reason,
> +
> +       TP_PROTO(const struct sock *sk, const struct sk_buff *skb,
> +                const enum skb_drop_reason reason),
> +
> +       TP_ARGS(sk, skb, reason),
> +
> +       TP_STRUCT__entry(
> +               __field(const void *, skbaddr)
> +               __field(const void *, skaddr)
> +               __field(int, state)
> +               __field(enum skb_drop_reason, reason)
> +               __array(__u8, saddr, sizeof(struct sockaddr_in6))
> +               __array(__u8, daddr, sizeof(struct sockaddr_in6))
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->skbaddr =3D skb;
> +               __entry->skaddr =3D sk;
> +               /* Zero means unknown state. */
> +               __entry->state =3D sk ? sk->sk_state : 0;
> +
> +               memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
> +               memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
> +
> +               if (sk && sk_fullsock(sk)) {
> +                       const struct inet_sock *inet =3D inet_sk(sk);
> +
> +                       TP_STORE_ADDR_PORTS(__entry, inet, sk);
> +               } else {
> +                       const struct tcphdr *th =3D (const struct tcphdr =
*)skb->data;
> +
> +                       TP_STORE_ADDR_PORTS_SKB(skb, th, entry->saddr, en=
try->daddr);
> +               }
> +               __entry->reason =3D reason;
> +       ),
> +
> +       TP_printk("skbaddr=3D%p skaddr=3D%p src=3D%pISpc dest=3D%pISpc st=
ate=3D%s reason=3D%s",
> +                 __entry->skbaddr, __entry->skaddr,
> +                 __entry->saddr, __entry->daddr,
> +                 __entry->state ? show_tcp_state_name(__entry->state) : =
"UNKNOWN",
> +                 __print_symbolic(__entry->reason, DEFINE_DROP_REASON(FN=
, FNe)))
> +);
> +
> +#undef FN
> +#undef FNe
> +
>  #endif /* _TRACE_TCP_H */
>
>  /* This part must be outside protection */
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index cc05ec1faac8..44795555596a 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4897,6 +4897,7 @@ static bool tcp_ooo_try_coalesce(struct sock *sk,
>  static void tcp_drop_reason(struct sock *sk, struct sk_buff *skb,
>                             enum skb_drop_reason reason)
>  {
> +       trace_tcp_drop_reason(sk, skb, reason);
>         sk_drops_add(sk, skb);
>         sk_skb_reason_drop(sk, skb, reason);
>  }
> --
> 2.43.5
>

