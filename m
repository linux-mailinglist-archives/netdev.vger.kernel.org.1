Return-Path: <netdev+bounces-164937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2292FA2FC1B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 22:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A0A166D11
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 21:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B2724BCFD;
	Mon, 10 Feb 2025 21:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GMQaWcjK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6046E18C008
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739223228; cv=none; b=oPuZLbHHie9LEa75BbM/aGyFxrEBVJBwzXnbb7qaL6qMomqBzsUULlFaY2sjocGJwNNwKCrxUIYACVbCPmOfh7NzmEqp/sWS9iNMPjP/4Xjf6WsywilPPCzrsKnHh4tC7h3pF15d1C+hir4EouA6fimC2FK//zzgva3s6gImPdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739223228; c=relaxed/simple;
	bh=JXProqW+gAaOrRoCcOgEdP2MLcBBP4XVJQfyBNAfBB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksrvD7JCxLFKvlBTdQNWj/6/rd+p0WGoBc28wHsLc7PfsbNfc4yG2yMquQED16zayR1VvW+52/KpLBAta8+2uIqRNh+m4CS8hbjm6vFgNhQZSlemzCp0Y6rXe6FVoRKkynUZJWlzXlS0BFmOyLtvwHXR35TKevuVpVIBCGun1YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GMQaWcjK; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5de5a853090so5440920a12.3
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 13:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739223223; x=1739828023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqizW0kPx4GPya2yrCqX6Q098V259vc7c1BUTaAaDM0=;
        b=GMQaWcjKnLBOGxnLa9z+aLt0cdcGz7FbXiWuYaB3KEkTOY3rPSpenxp24XvfTgw2kT
         CPsH5pU9mCOz7i/2FePa1PTuQ4hyfN4OxadKGyhYUmtQHy3L2oULqGMYSXRhMsqKskqQ
         9lLSxaHyTVPiDQs8W9/hmsrp/4jRaicqDJGbfYCK+qY2Z1jFteJO5AT5YWopXk32opzb
         rasExfdNSTHGplMqcvkeVa5fDuwVI72ycBC6vkDtcsY3T8Qh+QoqOMcmJ+o+GPWEuCBH
         fyCbt++0cfbzjNvNkUzx1TpQCPH1QCumdcAuj5jDKWvy8FexgTAGyt033gbhbv2FDitA
         nyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739223223; x=1739828023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqizW0kPx4GPya2yrCqX6Q098V259vc7c1BUTaAaDM0=;
        b=tXuMOcr4BkifaJOADVFIWsuB2ddhHJLxQlk2oLg3RdpzHdBQLo/luoGsB2V4nJCYVC
         JlgLS50AaKTQ042x+U7HM7aZj5z74rWzgjyLnd+jEL7bqTKFlzPr9UTPhdRcBIteMYmM
         bchDIDxUAf1yRJeBTk8pkRrEeAuuwx+fEXFq/qfqEabSlWaYctwli9EPYoiHMNHHT4k7
         rhZndWpTCW01jfQj2fkfEku9wmiEVUk1PB91jBgZR+4kGdwWZjv5CsJePJVYUg6JPnni
         Rc8tnJq65RSSIYo3TgGD7ZEeXzIQ9crdqbf+zAv2ZBgLuzeGFNP5X8J6a9VD9bEpXXjk
         LRdA==
X-Forwarded-Encrypted: i=1; AJvYcCUXh8WAQhRWgWnaC7LnrGs8NadvxFKZd5gE/AU4W8rylC5/Dkj/BH4uUDvGSIB1b3bnUMAbQr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1PGlB6/uDVWxKKcl0N1Eg0NVP2QcuMlIvdI/rsQpH2gp/cmsn
	3pbmgK/A//earYm0bwq0+jeQKzpDX8iuA7uzI2Lra3WMX8Fs/rfhO7JWqWP/jf/x5skWnT99xXb
	d6rysyVTnh1YEccjZX2a+gxlfstA0/C9gWR7l
X-Gm-Gg: ASbGnctHDH3P1BjHDP6JZsnVVGD5Ewby/r5vA7CF+mf8Utpz/YiHCLxKpqmtlCWYUvU
	Dmrdz5Z0QR334B+hmf7jvjIfZUbP+i1WCasEaLx3kRDs5Vd1W/SGU8heFZpw7RVYy+h2QjIAS
X-Google-Smtp-Source: AGHT+IHHW/I3OnE+vWP3hyYYKzNTziGPIGPj8RvKJjXBsWbd9wxUeIFcJk8dRjub4s9K5QMGPBN4zh5yQj5+yq65xJE=
X-Received: by 2002:a05:6402:2392:b0:5de:4b81:d3ff with SMTP id
 4fb4d7f45d1cf-5de4b81d53dmr12063590a12.13.1739223223507; Mon, 10 Feb 2025
 13:33:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738940816.git.pabeni@redhat.com> <67a979c156cbe_14761294f6@willemb.c.googlers.com.notmuch>
 <CANn89i+G_Zeqhjp24DMNXj32Z4_vCt8dTRiZ12ChNjFaYKvGDA@mail.gmail.com>
 <1d8801d4-73a9-4822-adf9-20e6c5a6a25c@redhat.com> <0a7773a4-596d-4c14-9fbe-290faa1f8d01@redhat.com>
In-Reply-To: <0a7773a4-596d-4c14-9fbe-290faa1f8d01@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 10 Feb 2025 22:33:32 +0100
X-Gm-Features: AWEUYZn0mtmBAJjj18FMy9W8twt__PDpFPZ6GXQmyL-CcqM1Z-hA3K89h4uk1HE
Message-ID: <CANn89iLHQ3PYumqzR3awv=bSZsCU8qJoPyj36YdCpUAL9n50hQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] udp: avoid false sharing on sk_tsflags
To: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 10:24=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 2/10/25 5:16 PM, Paolo Abeni wrote:
> > I expect the change you propose would perform alike the RFC patches, bu=
t
> > I'll try to do an explicit test later (and report here the results).
>
> I ran my test on the sock layout change, and it gave the same (good)
> results as the RFC. Note that such test uses a single socket receiver,
> so it's not affected in any way by the eventual increase of touched
> 'struct sock' cachelines.
>
> BTW it just occurred to me that if we could use another bit from
> sk_flags, something alike the following (completely untested!!!) would
> do, without changing the struct sock layout and without adding other
> sock proto ops:
>
> ---
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 8036b3b79cd8..a526db7f5c60 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -954,6 +954,7 @@ enum sock_flags {
>         SOCK_TSTAMP_NEW, /* Indicates 64 bit timestamps always */
>         SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
>         SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with pack=
et */
> +       SOCK_TIMESTAMPING_ANY, /* sk_tsflags & TSFLAGS_ANY */
>  };
>
>  #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL <<
> SOCK_TIMESTAMPING_RX_SOFTWARE))
> @@ -2665,12 +2666,12 @@ static inline void sock_recv_cmsgs(struct msghdr
> *msg, struct sock *sk,
>  #define FLAGS_RECV_CMSGS ((1UL << SOCK_RXQ_OVFL)                       |=
 \
>                            (1UL << SOCK_RCVTSTAMP)                      |=
 \
>                            (1UL << SOCK_RCVMARK)                        |=
\
> -                          (1UL << SOCK_RCVPRIORITY))
> +                          (1UL << SOCK_RCVPRIORITY)                    |=
\
> +                          (1UL << SOCK_TIMESTAMPING_ANY))
>  #define TSFLAGS_ANY      (SOF_TIMESTAMPING_SOFTWARE                    |=
 \
>                            SOF_TIMESTAMPING_RAW_HARDWARE)
>
> -       if (sk->sk_flags & FLAGS_RECV_CMSGS ||
> -           READ_ONCE(sk->sk_tsflags) & TSFLAGS_ANY)
> +       if (sk->sk_flags & FLAGS_RECV_CMSGS)

BTW we should READ_ONCE(sk->sk_flags) ...

