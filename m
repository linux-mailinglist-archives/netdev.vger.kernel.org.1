Return-Path: <netdev+bounces-157612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA837A0AFFF
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C58E188436E
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F551BD9FF;
	Mon, 13 Jan 2025 07:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZB9QrCG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B0628FD
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736752980; cv=none; b=mOAAXyjgSsQiqjSzMthtm+KNKR510fF7FMT+DR2+0E3TYRd0JQC1neLYZC6ZW+EJ58aI2+8Zf8mUT99pU3MLMUdcjMZOhXD2YmV6RB8bXbHGPwmloLwBvcDPJDc27TviCQL4/+vv/a9VmUbMLsF1UkDFDqmN+JKzRnJH5S09ERY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736752980; c=relaxed/simple;
	bh=E9jpIYWMM+gYObNUmWkWmPqP84q0SgkIZFJS+GUm8yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z55w0AdhiPykti/fYqnp3s2VBNqGIvpv+UDGj/c2/EB8ZioZpCp3YeKaYxTCd4Yl1g6DC34QTmN7YbjhrSRzBzFm71eD+bfQwvaaK9fyWxQSJP6VJ8o09JUr8Q0KGp5BI8INNAW4mTX4xDdOwFlmvmApqIrId61/79kjBG2hsD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZB9QrCG; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a813899384so12118085ab.1
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 23:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736752978; x=1737357778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmSbruqFvBBgQ1KelJd7b54TfWhRNIUaY4Eg8+z2tUU=;
        b=mZB9QrCGDuN1TY8HxnhW3MObhU/uLCyz/rgmrbjNVhjtiQsJ/BH35J4gykB9BGJrKR
         //oXt1hIcDg4FMfv25YjRrD6IyllSd20uB0aU290YSxEY+w36jF6oNUsWme9y9pHOvTu
         u2qwNuzo65Km6dQspvfPpbYPgs+roA+9aHkDSh9WGECHIQikkB/JdmM3JizN2/3EN/m/
         MV/Ki7J7dgrelWaGLCQEqjHT62J2VqvDQPqawP4hZOQBZVQEeKK8pT24bhvqQxU++bCP
         vt296Exle9MWkJTIXt/F2NhRscwLT4D54E02vDqHQrsfcmY1GjUEe9kpubRo2l1IxVn+
         246w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736752978; x=1737357778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmSbruqFvBBgQ1KelJd7b54TfWhRNIUaY4Eg8+z2tUU=;
        b=ESqeF7X/VFnXas3O3REeYjJmIL3tJ2eQ4KYDNHAqHsuK2TZMnWxFdUJcUY1TEJ4v5a
         npGWQ7XtUZrMIZ9M85Y8UKvNeFvSFF8MYdChOAlDmHvDE3egivu4DwzBhgtjHROdcCWb
         5UnPMVNpmt5DhP5UNuhgmk9CR7CV5dImjzkmv7l6p6cQmNC5o4BwUe3XYLLzKFyVrzWH
         ZLsPiKY7OIuw/CZjLJ3PGfSlaavXtLa2pNd1zCh5OkuCdI7ZzlKk1Q4YfS53qyISeahY
         GW0xv+5ClWA109u/qhYCiVqsOdWXsDPki5wCpZwB+ApjndqSKEk2dO3BG72ZwZ4IXgeB
         9XeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBvUm1RYj7Qgwh/HQM3HRgahhQ/0Zh4TdNaFmBLNohmyibrXEsOjwp4LpW75Vlu31ZdEwNtiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkea+/hvedxMEsgJuYGL4576EQb0Zb6uE9LzMpzOb+4RaulV4j
	2UMet2lDG1NNxNt3mg7UAJj3KGkEbEBRVM9nFbYEvfk3Jxm9aiLWFE8yqBV1UR9bnHfuBycN81R
	UZVgR4pUksBp+yZglY3o3uUHN7ic=
X-Gm-Gg: ASbGncugGdalKp7nwdffVt6MxR5Sv2X/YmSc1OGhXgzGbQG4dalZ8J92NMPXjdF86/5
	q8NTaGpuXoZXipTq22GY4zi5ta7f0zZ0WSnF8Fg==
X-Google-Smtp-Source: AGHT+IHfRDbWC4XSu+3Mowc49oS2oD9Fq5uAVCtSE3eIHk5LRL8o4BjK6ZQ3WSVMLI/sI1xX9QfL7qKQMehQAb3A3sk=
X-Received: by 2002:a05:6e02:3891:b0:3bc:be0f:edcd with SMTP id
 e9e14a558f8ab-3ce3a96da56mr121701025ab.11.1736752977657; Sun, 12 Jan 2025
 23:22:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110143315.571872-1-edumazet@google.com> <20250110143315.571872-3-edumazet@google.com>
In-Reply-To: <20250110143315.571872-3-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 13 Jan 2025 15:22:21 +0800
X-Gm-Features: AbW1kvbCd3JIM5drzCcK-M26nZFXnPxuldXVRzlnWvafO6JoXYIHR2U0h3D1mnk
Message-ID: <CAL+tcoDit2HQ9r-keyZjkSJF4esj-tB2rBAtFX7QBPueCaA8NA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: add TCP_RFC7323_PAWS_ACK drop reason
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Fri, Jan 10, 2025 at 10:33=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> XPS can cause reorders because of the relaxed OOO
> conditions for pure ACK packets.
>
> For hosts not using RFS, what can happpen is that ACK
> packets are sent on behalf of the cpu processing NIC
> interrupts, selecting TX queue A for ACK packet P1.
>
> Then a subsequent sendmsg() can run on another cpu.
> TX queue selection uses the socket hash and can choose
> another queue B for packets P2 (with payload).
>
> If queue A is more congested than queue B,
> the ACK packet P1 could be sent on the wire after
> P2.
>
> A linux receiver when processing P2 currently increments
> LINUX_MIB_PAWSESTABREJECTED (TcpExtPAWSEstab)
> and use TCP_RFC7323_PAWS drop reason.
> It might also send a DUPACK if not rate limited.
>
> In order to better understand this pattern, this
> patch adds a new drop_reason : TCP_RFC7323_PAWS_ACK.
>
> For old ACKS like these, we no longer increment
> LINUX_MIB_PAWSESTABREJECTED and no longer sends a DUPACK,

I'm afraid that not all the hosts enable the XPS feature. In this way,
this patch will lead the hosts that don't enable XPS not sending
DUPACK any more if OOO happens.

So I wonder if it would affect those non XPS cases?

Thanks,
Jason

> keeping credit for other more interesting DUPACK.
>
> perf record -e skb:kfree_skb -a
> perf script
> ...
>          swapper       0 [148] 27475.438637: skb:kfree_skb: ... location=
=3Dtcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [208] 27475.438706: skb:kfree_skb: ... location=
=3Dtcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [208] 27475.438908: skb:kfree_skb: ... location=
=3Dtcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [148] 27475.439010: skb:kfree_skb: ... location=
=3Dtcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [148] 27475.439214: skb:kfree_skb: ... location=
=3Dtcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [208] 27475.439286: skb:kfree_skb: ... location=
=3Dtcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
> ...
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/dropreason-core.h |  5 +++++
>  net/ipv4/tcp_input.c          | 10 +++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.=
h
> index 3a6602f379783078388eaaad3a9237b11baad534..28555109f9bdf883af2567f74=
dea86a327beba26 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -36,6 +36,7 @@
>         FN(TCP_OVERWINDOW)              \
>         FN(TCP_OFOMERGE)                \
>         FN(TCP_RFC7323_PAWS)            \
> +       FN(TCP_RFC7323_PAWS_ACK)        \
>         FN(TCP_OLD_SEQUENCE)            \
>         FN(TCP_INVALID_SEQUENCE)        \
>         FN(TCP_INVALID_ACK_SEQUENCE)    \
> @@ -259,6 +260,10 @@ enum skb_drop_reason {
>          * LINUX_MIB_PAWSESTABREJECTED, LINUX_MIB_PAWSACTIVEREJECTED
>          */
>         SKB_DROP_REASON_TCP_RFC7323_PAWS,
> +       /**
> +        * @SKB_DROP_REASON_TCP_RFC7323_PAWS_ACK: PAWS check, old ACK pac=
ket.
> +        */
> +       SKB_DROP_REASON_TCP_RFC7323_PAWS_ACK,
>         /** @SKB_DROP_REASON_TCP_OLD_SEQUENCE: Old SEQ field (duplicate p=
acket) */
>         SKB_DROP_REASON_TCP_OLD_SEQUENCE,
>         /** @SKB_DROP_REASON_TCP_INVALID_SEQUENCE: Not acceptable SEQ fie=
ld */
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 24966dd3e49f698e110f8601e098b65afdf0718a..dc0e88bcc5352dafee3814307=
6f9e4feebdf8be3 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4465,7 +4465,9 @@ static enum skb_drop_reason tcp_disordered_ack_chec=
k(const struct sock *sk,
>
>         /* 2. Is its sequence not the expected one ? */
>         if (seq !=3D tp->rcv_nxt)
> -               return reason;
> +               return before(seq, tp->rcv_nxt) ?
> +                       SKB_DROP_REASON_TCP_RFC7323_PAWS_ACK :
> +                       reason;
>
>         /* 3. Is this not a duplicate ACK ? */
>         if (ack !=3D tp->snd_una)
> @@ -5967,6 +5969,12 @@ static bool tcp_validate_incoming(struct sock *sk,=
 struct sk_buff *skb,
>         if (unlikely(th->syn))
>                 goto syn_challenge;
>
> +       /* Old ACK are common, do not change PAWSESTABREJECTED
> +        * and do not send a dupack.
> +        */
> +       if (reason =3D=3D SKB_DROP_REASON_TCP_RFC7323_PAWS_ACK)
> +               goto discard;
> +
>         NET_INC_STATS(sock_net(sk), LINUX_MIB_PAWSESTABREJECTED);
>         if (!tcp_oow_rate_limited(sock_net(sk), skb,
>                                   LINUX_MIB_TCPACKSKIPPEDPAWS,
> --
> 2.47.1.613.gc27f4b7a9f-goog
>
>

