Return-Path: <netdev+bounces-71439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8361A853483
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 16:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410A22832CE
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F079D5B672;
	Tue, 13 Feb 2024 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ScGBcjpZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB8D43AC7
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837850; cv=none; b=Es29JO1L6XEMAwCXqIKZ3w6lwBhhDqSEkrNLBTSmFeyQmvFaC+GzTPZnddNNH7JbebnJ3KY5TuVradB+Iefsuq0alSvv6V11nR1WjON58dSkPXQZePZj7TEEl2ytF/71+2c2R4FqA9kRwhe+WvgMvsIM22/ZdaIiDxYzGGuzS1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837850; c=relaxed/simple;
	bh=ONwpmHR6+gxMJzkHqwX0Frsnxs5ZIrTy8QiQhHb1nXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8BLsz6h0xqZK3VNVn8C19EP/vw9svtV8Huy59tN1M79dUB8JoSYMTcHHRC5bIiUoEiKNWaqo9FjAtJ7xaW6namN+0VChFjgILLGRUhSkTmFEje/Nf87+7GWvr1vDQjAWzv/dQqwd31X1NHe4pbjRi5RxioMEfp9aVN43uncOy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ScGBcjpZ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso10671a12.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707837847; x=1708442647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxZ7wzZSQYNuh/hc/vyFuDQdpGaH4/Zr0ZsQMiC2xNM=;
        b=ScGBcjpZhUixX1h/U1zGmVk6HDdVRPFf6XkfSKvZ77igMzD+QW536EWygGTD0GAFJ4
         H1uOBu5ubXnbi925SND9DfKWFt3d7n9qlnVD0J8Qk/eZfxIZ0B2m15m29HCVOgVIObeK
         u26jun0vUe6DrZCRq7O+mtBK99/iVcpW0znrx3ZYAIttuTfpy1IQv+FvYeI7aLHe9MNo
         1IHkYYqJYWfilP59N/RNCLmve3h866AjnYCiDrYZfB84Z1njc8B+N2gpwJ9g/2WawPch
         3kJcrCiyxYtOD6vDwuWv6CN7ce/J2XKI1ld/qO+7GyAYRMZqTJeZ575TrfNOGNozOnjo
         Seag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707837847; x=1708442647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxZ7wzZSQYNuh/hc/vyFuDQdpGaH4/Zr0ZsQMiC2xNM=;
        b=ceXbG5/dJ4IfFO/nOJ8Pj105Mrp8GkURrbteC95tTGL0nAS6GcV5SLTrkYEmCN2+6b
         DQgOOJEkGeT+Ege18zEg+JUZu0NEEXPyzKSni/xphDM4fX2SkHfM/BMXmtBZ0DObaLRy
         3BezWSdVx73KUly7gDXDyALjxISGguoUvgsBkXFBS8BI5RapynPoL6gTHgbNpZmHLJI9
         O2pgbGf5uuuNWuyy2OFvo4GCGPm115sI5bJL6XGnZV04eph+NyenJ4+AGvvusgCm1kay
         aoXeV1oaNTuD3JmyEetr9zIw/nft1WVbky3Js6YZOLSPwtXmZfvt3W2lGWVmREjNgztE
         ho1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3BDSVH98FGQts0lIl5q2iJXm1/tYETiq8M2ZO16bPwnpIU62biohd73U2BJlEHQfz8VGQaqlTFNj+FuhpLD9SZ1q5JH88
X-Gm-Message-State: AOJu0YxfF4kSJJ89TB3cRYeUdwJarUpg6PpmscgdvjBP7AgexGlnCD/k
	cy3CgUPmDmqz3ZXNFAC1DDiG7nTH1FDs/X+fx9Z6F7w0e+F4R4YOtDKI4zXRwo+v2TalrzStbxS
	qfh5nz+IprHmvNVmJyoN7AcPfr3Iu6uyRtRfl
X-Google-Smtp-Source: AGHT+IH1WDq84v2EN4yAPmsbXZFreYoRIktU7ryvR4ENOJwg+lWWUAgDnRCJwK4hkUrfuFLggZG483NmhLWpzp1VKPg=
X-Received: by 2002:a50:cd59:0:b0:560:e82e:2cc4 with SMTP id
 d25-20020a50cd59000000b00560e82e2cc4mr127803edj.3.1707837847148; Tue, 13 Feb
 2024 07:24:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213134205.8705-1-kerneljasonxing@gmail.com> <20240213134205.8705-2-kerneljasonxing@gmail.com>
In-Reply-To: <20240213134205.8705-2-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Feb 2024 16:23:53 +0100
Message-ID: <CANn89i+iELpsoea6+C-08m6+=JkneEEM=nAj-28eNtcOCkwQjw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/5] tcp: add dropreasons definitions and
 prepare for cookie check
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 2:42=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Only add five drop reasons to detect the condition of skb dropped
> in cookie check for later use.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> --
> v2
> Link: https://lore.kernel.org/netdev/20240212172302.3f95e454@kernel.org/
> 1. fix misspelled name in kdoc as Jakub said
> ---
>  include/net/dropreason-core.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.=
h
> index 6d3a20163260..065caba42b0b 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -6,6 +6,7 @@
>  #define DEFINE_DROP_REASON(FN, FNe)    \
>         FN(NOT_SPECIFIED)               \
>         FN(NO_SOCKET)                   \
> +       FN(NO_REQSK_ALLOC)              \
>         FN(PKT_TOO_SMALL)               \
>         FN(TCP_CSUM)                    \
>         FN(SOCKET_FILTER)               \
> @@ -43,10 +44,12 @@
>         FN(TCP_FASTOPEN)                \
>         FN(TCP_OLD_ACK)                 \
>         FN(TCP_TOO_OLD_ACK)             \
> +       FN(COOKIE_NOCHILD)              \
>         FN(TCP_ACK_UNSENT_DATA)         \
>         FN(TCP_OFO_QUEUE_PRUNE)         \
>         FN(TCP_OFO_DROP)                \
>         FN(IP_OUTNOROUTES)              \
> +       FN(IP_ROUTEOUTPUTKEY)           \
>         FN(BPF_CGROUP_EGRESS)           \
>         FN(IPV6DISABLED)                \
>         FN(NEIGH_CREATEFAIL)            \
> @@ -54,6 +57,7 @@
>         FN(NEIGH_QUEUEFULL)             \
>         FN(NEIGH_DEAD)                  \
>         FN(TC_EGRESS)                   \
> +       FN(SECURITY_HOOK)               \
>         FN(QDISC_DROP)                  \
>         FN(CPU_BACKLOG)                 \
>         FN(XDP)                         \
> @@ -71,6 +75,7 @@
>         FN(TAP_TXFILTER)                \
>         FN(ICMP_CSUM)                   \
>         FN(INVALID_PROTO)               \
> +       FN(INVALID_DST)                 \

We already have  SKB_DROP_REASON_IP_OUTNOROUTES ?

>         FN(IP_INADDRERRORS)             \
>         FN(IP_INNOROUTES)               \
>         FN(PKT_TOO_BIG)                 \
> @@ -107,6 +112,11 @@ enum skb_drop_reason {
>         SKB_DROP_REASON_NOT_SPECIFIED,
>         /** @SKB_DROP_REASON_NO_SOCKET: socket not found */
>         SKB_DROP_REASON_NO_SOCKET,
> +       /**
> +        * @SKB_DROP_REASON_NO_REQSK_ALLOC: request socket allocation fai=
led
> +        * probably because of no available memory for now
> +        */

We have SKB_DROP_REASON_NOMEM, I do not think we need to be very precise.
REQSK are implementation details.

> +       SKB_DROP_REASON_NO_REQSK_ALLOC,
>         /** @SKB_DROP_REASON_PKT_TOO_SMALL: packet size is too small */
>         SKB_DROP_REASON_PKT_TOO_SMALL,
>         /** @SKB_DROP_REASON_TCP_CSUM: TCP checksum error */
> @@ -243,6 +253,11 @@ enum skb_drop_reason {
>         SKB_DROP_REASON_TCP_OLD_ACK,
>         /** @SKB_DROP_REASON_TCP_TOO_OLD_ACK: TCP ACK is too old */
>         SKB_DROP_REASON_TCP_TOO_OLD_ACK,
> +       /**
> +        * @SKB_DROP_REASON_COOKIE_NOCHILD: no child socket in cookie mod=
e
> +        * reason could be the failure of child socket allocation

This makes no sense to me. There are many reasons for this.

Either the reason is deterministic, or just reuse a generic and
existing drop_reason that can be augmented later.

You are adding weak or duplicate drop_reasons, we already have them.

