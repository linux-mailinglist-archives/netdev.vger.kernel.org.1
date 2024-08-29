Return-Path: <netdev+bounces-123302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3395D964796
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04B81B23903
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 13:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129A918A6BA;
	Thu, 29 Aug 2024 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l0CaeKBa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1982BD19
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939701; cv=none; b=TvAla3Ln29yoDRRR0n0wBnVt2dFjQUsK/LOhrwan53cHvgV3XZtnYXwK6robB/NyH2TACDkhyMWts8//8JrJSQ+SRkFLgzskAx4/4E1ZSQqHxoL1V0ZK9R+4hoLaMzToQyXljvRe7cyiMerntMWQQ1XWtmlYqokhmEJfHfLVpL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939701; c=relaxed/simple;
	bh=C8DIwDouuCvMX6UvnHH4DS0Zl8j6Av5AcScnhcC//H4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwlU6zud46LW4A39dhEEz/rn3FAHTRe/qeTVr58sGAy9rmCobDLRqmL5yeDvO6OmG78ysPqHJpcrT2hi+70r+1MddUnHn9G2N+8R8L7reBUifOzH+BGhQRmDIhSFRwMiHrlgW6ogPynowLNPx8bLWKXTzdPo/kUkILwco32uw6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l0CaeKBa; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86fa3dea99so39113666b.2
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 06:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724939697; x=1725544497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkI9fdWpEL7A3tGI7JWmp2jng/59IU09cFxLcVH1cws=;
        b=l0CaeKBaxujuGy0ELxLDnlhmGvGtcdDP30JZC5fU1DeEgkLUwbnzxO6HNMxUdkWSGV
         EUCgVGG3KzVxM31LwRNxOm8boKVQjyuP0f6cgaGx/Zyt9B4sdQG/1U1KJc4SAvUBZ+NS
         XOQSpldFTJ9mACW431L0p5vhy8vaqGcSzw8p/HJbhttfcPNmL9dNSY3CaAsCh7saPXyK
         GhmsKm59nlvKvTEAHdF4SLOyAXrjCdHR4HcFhOyYRPhsQ5hDu+ITIfFPIdlU97j+7qWr
         6fuhHZKIreev2gT98NQU2rKwgoPUDX1ZyN6Tp1USE8/OwhJs3Qh8nKVdojJZ7PZyVke6
         cMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724939697; x=1725544497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkI9fdWpEL7A3tGI7JWmp2jng/59IU09cFxLcVH1cws=;
        b=nXeTCFNF8/v+0R8+3gKMeb1sBqPUzuB0d3j4WDaEGc/fG80m3ZNa5BgBAfxEtY4s8e
         3YCL3EOt2/iYwwMtYXtRdIFHZArlBWFNQkitZPAp7jktuEas2I0nZqK7WDMr4Q6qWOCj
         IXzVYBWT5ZKA2tno84pQOW7hTs19LUFRkmRjx7zT/gCGrpZlTVeAFIaBhWdSUuQMQu0Z
         FT+TxzrKfv/rXRyc+nqDc4r8wlRmq2YUN8s9ulUkk6N/v/wtnIXQlVcu/W1/qZsF50K9
         ydNL1CjXuS7KMY8uUoOoOawVBOZd8yvvLy4xMWjAMaCrpzTJlLjzFpwHMUf5YhGgxW+8
         mNGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcJspVdSn0y2e6lU1et/0Cr1oqT3RExxa9bAkfp5XClwlvvV7Pkj/Ts5dGRqlBRw93dyB5t4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAs19meFwU/tTFb5GZgJjVKW4rzV8MzKDX4ozcpckes2gwt40D
	wJihv4BgJEXVO9QBEU+pTMqXK5Sh7mXJUX5XSN+Si9MZfO2BBCQDfEfS/0ROOt6MiI9jpq7Cj1n
	m4nfVTB+moOPE3y6R8YnhKEMfA3/B06GnpPoO
X-Google-Smtp-Source: AGHT+IEf2QxNlbZqCgPr+Cwhb+i5sKCGoPMMoMNmXgVw6yVhO8M/ydvGcPSz30pCs6xie1495XJA0WVoOzz5JcP8R5A=
X-Received: by 2002:a05:6402:354d:b0:5be:dab8:1bb3 with SMTP id
 4fb4d7f45d1cf-5c21ed3e9efmr3059815a12.13.1724939695726; Thu, 29 Aug 2024
 06:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828193948.2692476-1-edumazet@google.com> <20240828193948.2692476-3-edumazet@google.com>
 <20240829133356.GU1368797@kernel.org>
In-Reply-To: <20240829133356.GU1368797@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Aug 2024 15:54:43 +0200
Message-ID: <CANn89i+e7rfu=jpmqd09Qto-oaAgNUpG44CABBQVQNj4zEEGTQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] icmp: move icmp_global.credit and
 icmp_global.stamp to per netns storage
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Willy Tarreau <w@1wt.eu>, 
	Keyu Man <keyu.man@email.ucr.edu>, Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 3:34=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Wed, Aug 28, 2024 at 07:39:47PM +0000, Eric Dumazet wrote:
> > Host wide ICMP ratelimiter should be per netns, to provide better isola=
tion.
> >
> > Following patch in this series makes the sysctl per netns.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> ...
>
> > diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
>
> ...
>
> > @@ -235,7 +230,7 @@ static struct {
> >   * Returns false if we reached the limit and can not send another pack=
et.
> >   * Works in tandem with icmp_global_consume().
> >   */
>
> Hi Eric,
>
> nit: This could be handled in a follow-up, and I'm happy to prepare it
>      myself, but net should be added to the Kernel doc above.

Thanks, good point, let me send a V2 real quick.

