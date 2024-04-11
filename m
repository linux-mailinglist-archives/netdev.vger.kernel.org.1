Return-Path: <netdev+bounces-86854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078018A07B2
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 07:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3809B1C22C11
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 05:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC71513C80B;
	Thu, 11 Apr 2024 05:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RF4SH1wj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1648413B7AA
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 05:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813272; cv=none; b=tStUvgKwvLhkhV7q5PJIW3Nwmo1Ln++QeDXfBlI61W5y8U+aB0q3R5FcztlMvF85SIQwaXRuQgnwg1aCKO/oQYKf2MX1DmB5nBEHBs/JDh42gaITE+q7U4hcXc3kND/h1Fv/h1dqsQXvX+dFMjnMYOjCnuIVYi7Ev1lKG9YnWg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813272; c=relaxed/simple;
	bh=RuYKRmrRJfJpcYNTGdbajQ7fR3l9aRqaDwMeD1aSyno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJ4HwrGeQ8gpnkv9iUV4uzhH0CU+5ZKEIqFmEuPpOtMrpDuWh9i/oHfXQdJKxgc6iPb8nIwfYJGgZrJ1+Lw1bGl/mi1kZ8/efM93i+0QQQGqGbO5flhnfRDIdgelFrNPdclxExarfl+1nVhwuoPn20cs0zph1SU6kulh37+UQT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RF4SH1wj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so5278a12.0
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 22:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712813269; x=1713418069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6o63VP555qin34ITpOtfh+oQBHfK6P7l24/eJcYO10=;
        b=RF4SH1wj737/mmNmwc5YrwqusWpun/zzgLwRjYWS53Iz8fdThr/XTZcvZml3+zGee6
         CLvjIlE4CxHrA7mEbHXGLPe1uqWV7llprUpEyHG3E2SZ0a+R4efUHtLAIMbaLCW/0yCD
         uKluOgv2n9CYpALzKS0x5yoV4Z5tmD2N2JyL6oSXCgdj7SKgQTie7kxYKegl5t1jvYtn
         aah1Oi3OQGOGAifvXA+yBTg7DRY9l/pcyTgZ9uNKBXS8wPrUa9ztOw3xHWW/mdRX/5YN
         ze/p2BhPrP1OHr8UO/gudmIzDQVq/T+97NBzxR/xeohWoxlUPzbSXQBDwcpW7G30PrLY
         M+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712813269; x=1713418069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6o63VP555qin34ITpOtfh+oQBHfK6P7l24/eJcYO10=;
        b=IvO7NdoJq4E3QYN1ozRCLpZcId+azxIpwLPsOaYL+U+m52DCuJWw25vLOnxGHMk4tZ
         kn/4FzVhR84Hnxp1rco9hXMT1NHHiUMg+hhykCEJdSsnyTAYQniVb62GKml0KVflPbf8
         O0tJ5CnSEFK1C4FSIk5DWffvOoqiMVDyi2mhsqxp3dSX2lOehTQL4QLywxBE61FZEoOL
         K3qJwe0uUjLjCjIBKuG56IrZC2ijBcnO27qTAVfOllYCr2BdrMd7U8xZzqX915KbCfIZ
         pxpTqWdssiR8kDD/QZYcPmsHZJqISwJxGkG5yxlwHomQNJGSBY2hbyMus9jJOw20dDsZ
         sHqA==
X-Forwarded-Encrypted: i=1; AJvYcCXCMqEwvkm6pysqG4Kp7vOGJWVbfc5lSh7fxv59YrrSpwzdCMGZI5G26rWJqjxkKj2cIwJoEed9J1iAsQ97ptoNACeAZjJg
X-Gm-Message-State: AOJu0YwzW+K9XFBH/+j3FlPccnve6YGTKyoZvjdrGko+TESHsDrmm8h7
	N/ILobgYWMeOG4cna5BCkrllvqBuhfHhCgJFtE/nqqUYdoZUGQaSLasUJen520Sbj8JF1lc3UVT
	+uaTaXXdp+VV/yUFgzU9HmkbKRe0b0tognChZ
X-Google-Smtp-Source: AGHT+IEV659ajmSGYZEJOWj07ouPFWJccCZ4B5gR02Q5BKJu+ykuGYPBFMBZWab1pgdYW+dLrUAsuuTYQ7d6uZdQ75U=
X-Received: by 2002:a05:6402:292f:b0:56e:85ba:cab0 with SMTP id
 ee47-20020a056402292f00b0056e85bacab0mr53528edb.7.1712813269104; Wed, 10 Apr
 2024 22:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411032450.51649-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240411032450.51649-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Apr 2024 07:27:36 +0200
Message-ID: <CANn89i+2XdNxYHFNwC5LHupT3je1EaZXMxMJG9343ZO9vCzAsg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: save some cycles when doing skb_attempt_defer_free()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: pablo@netfilter.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, horms@kernel.org, aleksander.lobakin@intel.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 5:25=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Normally, we don't face these two exceptions very often meanwhile
> we have some chance to meet the condition where the current cpu id
> is the same as skb->alloc_cpu.
>
> One simple test that can help us see the frequency of this statement
> 'cpu =3D=3D raw_smp_processor_id()':
> 1. running iperf -s and iperf -c [ip] -P [MAX CPU]
> 2. using BPF to capture skb_attempt_defer_free()
>
> I can see around 4% chance that happens to satisfy the statement.
> So moving this statement at the beginning can save some cycles in
> most cases.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/core/skbuff.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index ab970ded8a7b..b4f252dc91fb 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -7002,9 +7002,9 @@ void skb_attempt_defer_free(struct sk_buff *skb)
>         unsigned int defer_max;
>         bool kick;
>
> -       if (WARN_ON_ONCE(cpu >=3D nr_cpu_ids) ||
> +       if (cpu =3D=3D raw_smp_processor_id() ||
>             !cpu_online(cpu) ||
> -           cpu =3D=3D raw_smp_processor_id()) {
> +           WARN_ON_ONCE(cpu >=3D nr_cpu_ids)) {
>  nodefer:       kfree_skb_napi_cache(skb);
>                 return;
>         }

Wrong patch.

cpu_online(X) is undefined and might crash if X is out of bounds on CONFIG_=
SMP=3Dy

