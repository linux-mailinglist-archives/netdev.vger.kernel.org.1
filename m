Return-Path: <netdev+bounces-213452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FB5B2505D
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 18:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4941488397D
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EE023D7D9;
	Wed, 13 Aug 2025 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bzvHx2ls"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B9C280CD3
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104134; cv=none; b=u7ej4qVPu7XQln2Ql1tzeoWnjGhiHm3HuA6mkF1JmlUjoBAY3/RyNZ5JpFHNW5xkYGo4+MLuM6EJEOZG6qlC1IdR3e/DNPBMW0KDSU0Foq70pbxvXyPjmjnTtuF/vz9fsrXZCUFyFH+8KE4Ydk2HtUTs6toB9OtxBa/s8TIedBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104134; c=relaxed/simple;
	bh=R78X1eugxynKC0lTYo4txkS1kInPjqxZU1IWXlVlUfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8rr+ywEN6Da3gURg+gsTnlpIFv4HnZSo+0nT6XN0CaTgx2tgbYxxJ7nVL5wGkt9aZfjsSvRbkGBW7bzeSw7aQOURebXgQvV+tb7nx7d59MuNhmGDXIWYmeeVYBLFiYX5Ejp81nQpW7G0Pi4xkz97/6Mf5g0KA03rzBD/1v5N6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bzvHx2ls; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55cd07a28e0so416e87.0
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 09:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755104131; x=1755708931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ts9gasw9dkYPDd99xp0aER506LHY63IZ37c/vRLflJE=;
        b=bzvHx2lsOaW1kTsmtYyHVGY9v7MF5vhDfClMg4UCbH+L96XRxrHNwDxo8iy5Qgz4oC
         cEtO3TgoNuzIcQgs1DPCpmVpXeBR/zyO0IAdxjmEq9JhUfewEvCcWdQGp0/N4svllFl5
         OcO4igSq6ekqy6Ih3H2yIySBKLV/o47+qi/qVWJUyS6lCCa2CHA6mt6e97K62A9JqAOf
         iuDgntFwCsW378xjskri34bjhV79QTk503ZHrteXi+mIQUScPqL5+ARvRrNuna3qNDmz
         UW/raVbYfnetQtJvWRPiMaGxqTDFFuVJSfnoJfozjEHoEzkZhd9InZ9QxUtk4I9G0wCO
         FUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755104131; x=1755708931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ts9gasw9dkYPDd99xp0aER506LHY63IZ37c/vRLflJE=;
        b=NVuRFgghi+5TiJFOjiBYDEhMvjOhDMXfL1wYt+TvvwNcFd0xYmMGt4b8LSJyEZ7Op4
         znTjL6/Wep3zt+kIBqpqvHELik2y1CmUugJHBrENkG/NUBYirufEh36XrQYDFkEk2YiH
         waUHGY+qL/5pnWfFhq+OLchYt89V1jBLgOPoZEhr9PMJnZ9Yj2SqmDBNGZL4IpDfczVP
         SbU0S2VytmmH/VaNPIDH6GR0XYr40QzRw0toe0hFtRpI15t8Img7p0Un+pxcqfuK98rj
         5FLXCJLOwmz9U2ENamu+86HkDiIaHSwZtW9CuF7YWpprLDHPgICy6Lm+L8us6JkX56nP
         oybA==
X-Gm-Message-State: AOJu0YzgonkX8AwEepv4uUjKdKJ5C2TA+6l5ETUd+PWGqtEQND9VW8Sp
	+BvCBp27NuQ988GB8yaYxRMf8O/vngIpW0jruLXnReEqeC5R7P47jW8aGJ9GmuDBIJfJ6BI+PRo
	Yptqtvl9HsfcyMAtBSeCUKTprKxY9yJLbdp/zSUS+
X-Gm-Gg: ASbGncvkMlDdmVdEvsqwpfsMNJbcw56GFsqBM+lPr+x9lNS+l62WZZSlPBRiUUsxZAX
	4Xpve8jIciv9zp+lnpM233TDHgd5Me/+qxzL9WdsN4nsycNuGXTMk7Z8SKrnpUMljhZcy/4VNCb
	HS7yQdiB3r5DtRHvFHOO2eUuuHzXOL2KFB0NpxzPvUDsTZ8uotdkjuy7eZQg3zY6UShtQuU8vNQ
	YfdfdKSJSrdrEQTLH9+c6CJA4KmWnx2A+QTXQ==
X-Google-Smtp-Source: AGHT+IH905ve9bM5Fx+wWK8lUVKvEPKcxVkA5zHi8MtUl1d/b8Cj6+pxan403EijeU57px3CAWtaNhxVqdsIouq9Rxs=
X-Received: by 2002:ac2:494c:0:b0:557:e3bc:4950 with SMTP id
 2adb3069b0e04-55ce126a661mr250202e87.7.1755104131003; Wed, 13 Aug 2025
 09:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754929026.git.asml.silence@gmail.com> <7be7a705b9bac445e40c35cd227a4d5486d95dc9.1754929026.git.asml.silence@gmail.com>
 <CAHS8izOMhPLOGgxxWdQgx-FgAmbsUj=j7fEAZBRo1=Z4W=zYFg@mail.gmail.com> <35ca9ed2-8cce-4dc8-bd15-2cda0b2d2ec5@gmail.com>
In-Reply-To: <35ca9ed2-8cce-4dc8-bd15-2cda0b2d2ec5@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 13 Aug 2025 09:55:18 -0700
X-Gm-Features: Ac12FXzeFEzFZET_muTXpJX1QrWWbv6tKTmR_Oiy3eFKe2tDH4mwKzPdlN-WpRE
Message-ID: <CAHS8izMfqgzA75Wo9fkeLkHdCa512vqr+5iQ0u1zHKZX9uGoNQ@mail.gmail.com>
Subject: Re: [RFC net-next v1 5/6] net: page_pool: convert refcounting helpers
 to nmdesc
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, 
	sdf@fomichev.me, dw@davidwei.uk, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Byungchul Park <byungchul@sk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 2:10=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 8/13/25 01:14, Mina Almasry wrote:
> > On Mon, Aug 11, 2025 at 9:28=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> ...>> -static inline long page_pool_unref_netmem(netmem_ref netmem, long =
nr)
> >> +static inline long page_pool_unref_nmdesc(struct netmem_desc *desc, l=
ong nr)
> >>   {
> >> -       atomic_long_t *pp_ref_count =3D netmem_get_pp_ref_count_ref(ne=
tmem);
> >> +       atomic_long_t *pp_ref_count =3D &desc->pp_ref_count;
> >
> > nit: I think we can also kill the pp_ref_count local var and use
> > desc->pp_ref_count directly.
>
> I stopped there to save the churn, I'd rather have it on top and outside
> of cross tree branches. But I agree in general, and there is more that
> we can do as well.
>
> ...>>   static inline bool page_pool_unref_and_test(netmem_ref netmem)
> >> diff --git a/net/core/devmem.c b/net/core/devmem.c
> >> index 24c591ab38ae..e084dad11506 100644
> >> --- a/net/core/devmem.c
> >> +++ b/net/core/devmem.c
> >> @@ -440,14 +440,9 @@ void mp_dmabuf_devmem_destroy(struct page_pool *p=
ool)
> >>
> >>   bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_re=
f netmem)
> >>   {
> >> -       long refcount =3D atomic_long_read(netmem_get_pp_ref_count_ref=
(netmem));
> >> -
> >>          if (WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
> >>                  return false;
> >>
> >> -       if (WARN_ON_ONCE(refcount !=3D 1))
> >> -               return false;
> >> -
> >
> > Rest of the patch looks good to me, but this comes across as a
> > completely unrelated clean up/change or something? Lets keep the
> > WARN_ON_ONCE?
> I was killing netmem_get_pp_ref_count_ref(), which is why it's here.
> It checks an assumption that's guaranteed by page pools and shared
> with non-mp pools, so not like devmem needs it, and it'd not catch
> any recycling problems either. Regardless, I can leave the warning.
>

Ack. I also agree the WARN_ON_ONCE is not necessary, even the one
above it for the net_iov check is not necessary.

But since devmem was the first memory provider I'm paranoid that I got
something wrong in the general memory provider infra or in the devmem
implementation specifically; I think some paranoid WARN_ON_ONCEs are
justified, maybe. I'd rather debug the warning firing rather than a
very subtle refcounting issue or provider mixup or something at a
later point. I'm still surprised there aren't many bug reports about
any memory providers. They probably aren't used much in production
yet.

I think after 2025 or 2026 LTS it's probably time to clean up these
unnecessary WARN_ONs, but until then, let's keep them in if you don't
mind.

--=20
Thanks,
Mina

