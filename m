Return-Path: <netdev+bounces-73721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E42E85E033
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C73B6B21940
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECBA69D2A;
	Wed, 21 Feb 2024 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ienegdOT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E377EF03
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526879; cv=none; b=eMSvDAOGyFCET0+/S5Hv3HhFK0286EMMXS+WxAJSt6HhZeF1rkyYR5EttLBKpCSvBehYM5ADBGtjqHXRT+ZknyTAlrJnwvfumgFtdGuxDsT1b2mo7eMGP8sFsPtNl0dMmMoiPDw1kKFtPMT4joffo4yoo9izMNx3islImYigfJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526879; c=relaxed/simple;
	bh=pzXACgRyAUzlhVgt7ThrSY6MG0zqYNaYDrZfioSmr3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/is48bv3aH/6ABuLaLlWPh2+CmJUfqX362HXB8tRJUwwGYjq3jfN2Ek1944oHsA2oeB5sH+US2gvHYALD69DgllTWhWEUaw7kaafJiuZgEX2ft6X1TAvRCadTFo4CFpOmO2lr8stvSWyJnJ58hp12k/tW2nSgNU9Rk98uMDh/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ienegdOT; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5650c27e352so5375a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 06:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708526876; x=1709131676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yB32fRdZI98g9CgKb1o+Sn0CI4uG4zh5W5GSE4QxZgk=;
        b=ienegdOTkcHGwX8D39HIj9+knwIOp5QJCdE33cMiHfs+N1YG0933q2wiCc1z54Y9b7
         n2Qys7/wwAV0AJS4AxAJilTqKwZm8K/ceSanjn9UqDB/JRXBq27IShIEhiJdvp78cG1y
         P4r3SuXm9PzspVwb4gyJKpsFDq3rBcvK7QnU65A8IGG/arPQGJk/QF7P2Xf+a0TrQ2da
         2xmf37sK67iKIcd9Chq1bZ3S+wQwIkecahQG+X78UuQj99YmTc/lSmZQADK6UULCIge2
         yodLHZdm7AcoMka5bnDU585sHokFUdv8VQAblQHDLhnbRz0rQKMVjpChQOHOfASdj01w
         BhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708526876; x=1709131676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yB32fRdZI98g9CgKb1o+Sn0CI4uG4zh5W5GSE4QxZgk=;
        b=HLlIb3u96J5RorpAfBx7fw4RRA6HFOD4UhYDIbSXxdAQi10uzCezlMKwXehvLACA11
         KZOzJLY3enxnsD/GSe0brUm64asqtmAcX5AK610aA8RJDUzzUnql3woh4rsLgpuoNKsF
         p2xy9fNQGK+rJMnbL3zQR+PwL4l9hd03163IYlgaPfLsy3ZHG/SGXZ09Nqbb8TVahtvb
         36E9/URhE7KlwfYDkSJJcLd6NMPPraSlUD1H0bunxTLV8jPb3kR8IRrfNXT39H/eKFyb
         knguf0HyTkgNLHun57GIzGw9enzjQOQpH50/OytoMz14yogvnS3rELidG/cCb2xLosVe
         RZDA==
X-Forwarded-Encrypted: i=1; AJvYcCUJoVT6XGL6K6Es76KlNvb7vJVTv7u/YnykvBOxUp85krFDPLTZPoVwEw75s7sxYCUCvRbXmfJyEACAEh7t9mLBI6rbHFop
X-Gm-Message-State: AOJu0YzSsfPxEjjX0qxTfMTZYwNVVPHonHaAQqvHwLJSzjmHLfhvgOWy
	74Ghnvn80/X5QO1j4CRGVpqvf5BqCK0NNfqGbLimOylHmbC13afRljTqfAY5M3U5mb6SIFMfY/O
	vluVN139X8a721u6C15k8yU7cA4xMw84K5n6A
X-Google-Smtp-Source: AGHT+IGTr1WOsk1WEvsO5PAKMk+6nexpsPX3/q4j+Pyov4NCUGB1mnyaYMfFeBxhu3BgyTbJabPP0ZC82xr32AcCfaQ=
X-Received: by 2002:a50:8706:0:b0:563:adf3:f5f4 with SMTP id
 i6-20020a508706000000b00563adf3f5f4mr157725edb.1.1708526876245; Wed, 21 Feb
 2024 06:47:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221025732.68157-1-kerneljasonxing@gmail.com> <20240221025732.68157-12-kerneljasonxing@gmail.com>
In-Reply-To: <20240221025732.68157-12-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Feb 2024 15:47:45 +0100
Message-ID: <CANn89i+huvL_Zidru_sNHbjwgM7==-q49+mgJq7vZPRgH6DgKg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 11/11] tcp: get rid of NOT_SPECIFIED reason in tcp_v4/6_do_rcv
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 3:58=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Finally we can drop this obscure reason in receive path  because
> we replaced with many other more accurate reasons before.


This is not obscure, but the generic reason.

I don't think we can review this patch easily, I would rather squash
it in prior patches.

>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> --
> v5:
> 1. change the misspelled word in the title
> ---
>  net/ipv4/tcp_ipv4.c | 1 -
>  net/ipv6/tcp_ipv6.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index c886c671fae9..82e63f6af34b 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1907,7 +1907,6 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *=
skb)
>                 return 0;
>         }
>
> -       reason =3D SKB_DROP_REASON_NOT_SPECIFIED;
>         if (tcp_checksum_complete(skb))
>                 goto csum_err;
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index f260c28e5b18..56c3a3bf1323 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1623,7 +1623,6 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *=
skb)
>         if (np->rxopt.all)
>                 opt_skb =3D skb_clone_and_charge_r(skb, sk);
>
> -       reason =3D SKB_DROP_REASON_NOT_SPECIFIED;
>         if (sk->sk_state =3D=3D TCP_ESTABLISHED) { /* Fast path */
>                 struct dst_entry *dst;
>
> --
> 2.37.3
>

