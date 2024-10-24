Return-Path: <netdev+bounces-138794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1559AEEF6
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 19:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3F51C22659
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E931FC7D7;
	Thu, 24 Oct 2024 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y/HaK+Jg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F31C1EC01B
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792746; cv=none; b=KKm7kVrknJXycHy+C3OvNg+p+JpwojsGOarZLVcLYbcc+qQzE7KchESh07wuD9F7ZvIII6znsRKwjliPt24z13q3H5WSOB8jnnZIVvV/6Gjz8PLUCFjx167NI/V6t24Vg9iCIGI9b6AdOzdXMafWfz1iobPxAX8+YBhJ6iXdHSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792746; c=relaxed/simple;
	bh=pQjFAvvn6bVK7BM32ZPVGDi2RnMjfz1p2iYtoEn+KJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9ZueQ05BCKS8DV5thmG4ZTue2/yvb6vF22/JmuakytbaweDnZaeEfnsyJYjMNK2QY0O2gtpW8GdVjFysg7KqhiNoGFqWPgPvCEAoAGhqvTyOyNAa0WiNxdFFIlWenUZZQx1r8IUOopv0Y8OJvB0wRyZQFrJbktkt/amB5q1OtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y/HaK+Jg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315ee633dcso25935e9.1
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 10:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729792742; x=1730397542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQjFAvvn6bVK7BM32ZPVGDi2RnMjfz1p2iYtoEn+KJo=;
        b=y/HaK+JgPgrxlp5SC7jMRp+0lzoVTEPnyE4oK5P9hyUGWgqGyA3GRNFKQ5YcTNAtmZ
         ot6s7tMSBPxhcH0PoSUOTyNXoaECLbljPASvrMi4okzN6QNVDilYArh90HtnKkaQCNo6
         2lPZNboEY5E99dmoz665CAJU2ecC2zkxfEdRPNOKK2kXny1+qUuifpldAW6Yv+twmWLs
         NZnVKycyt8K/eX+R4LXWPmTzh3TyWdA5lJ0l7fQTJ84zGooot77B3LQ8/K1bfoMJsKL9
         5Z6fPC01macRpYEuIT/r44X+JpUbPTtTJzR0dhgi8ztwMWW1bjCnCAdLuUmp2AtUq7oc
         EFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729792742; x=1730397542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQjFAvvn6bVK7BM32ZPVGDi2RnMjfz1p2iYtoEn+KJo=;
        b=vNwgXaokWpgqc7SGVevk6f3gsxWGefooU1jGHaqttZBIbYh3OY+SDxsZDeZaFdeOl9
         UaB8SMU7rSsR0mSF7x3nfHBhnnNWHuMw5I/HNd4FrEqqlBZVJW2AgFDvbJ4N0K2RCz4V
         qgKkbJrFi+EF0sX6WzgC9ubQTapcxNrEDAMGGim6sHklZKTRekM4PnH2Ixxv4O9JvJqB
         v6St8sGoFj6yLROl4b+VOeh5qE1adQhQm8UZGmEvAofVfHHhaS2g1xrolfXYZgolu8DW
         KylIsb8k8VvHk9AHn43GD3p1OWmhI1/di7mZhs2HEWjqVFkzOfl/fgpZUP18deLwTaBM
         hGmg==
X-Forwarded-Encrypted: i=1; AJvYcCUPTSkkFVCfNRuZ7/bqo6TT+wap+ZTO/BWYJCkkIQI35Rjbk9LIeb+yWQr/gKsDWJHhDUGnFPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFQpS7AGd+mQ5nRBOeLEIUalBBI9hUHxdxT5rJtAiyKlmopw1V
	i1ZIBWrSUtknBwMY1nYFKS18ne7IovvVreF0CbHCuVoEKO8SELyN5js2WCbw6KQJ0mHNe4ezEgZ
	L4gFd4wV1rLsZTLw7bu52mX7nazFaL+zLh6S4
X-Google-Smtp-Source: AGHT+IFtv5WcFgY9fz9cRZmRt9GgBS1262FRdBJjUhN7Bf6Ml5TYlnA/SYfZCKi91dZ4Vtcr/YyL4NnwesIPozQ/iyg=
X-Received: by 2002:a05:600c:1e0b:b0:431:43a1:4cac with SMTP id
 5b1f17b1804b1-43192393867mr89915e9.3.1729792742276; Thu, 24 Oct 2024 10:59:02
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023221141.3008011-1-pkaligineedi@google.com>
 <cf13ffde-2a5f-4845-a27d-d4789a384891@huawei.com> <20241024154503.GB1202098@kernel.org>
In-Reply-To: <20241024154503.GB1202098@kernel.org>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Thu, 24 Oct 2024 10:58:47 -0700
Message-ID: <CAEAWyHewCMmWmA16jdPiT6pQvwFX88JOtAyzKJHXzRBFogdyPg@mail.gmail.com>
Subject: Re: [PATCH net-next] gve: change to use page_pool_put_full_page when
 recycling pages
To: Simon Horman <horms@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, willemb@google.com, 
	jeroendb@google.com, shailend@google.com, ziweixiao@google.com, 
	jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 8:45=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Thu, Oct 24, 2024 at 10:36:02AM +0800, Yunsheng Lin wrote:
> > On 2024/10/24 6:11, Praveen Kaligineedi wrote:
> > > From: Harshitha Ramamurthy <hramamurthy@google.com>
> > >
> > > The driver currently uses page_pool_put_page() to recycle
> > > page pool pages. Since gve uses split pages, if the fragment
> > > being recycled is not the last fragment in the page, there
> > > is no dma sync operation. When the last fragment is recycled,
> > > dma sync is performed by page pool infra according to the
> > > value passed as dma_sync_size which right now is set to the
> > > size of fragment.
> > >
> > > But the correct thing to do is to dma sync the entire page when
> > > the last fragment is recycled. Hence change to using
> > > page_pool_put_full_page().
> >
> > I am not sure if Fixes tag is needed if the blamed commit is only
> > in the net-next tree. Otherwise, LGTM.
>
> I think it would be best to provide a fixes tag in this case.
> It can be done by supplying it in a response to this email thread.
> (I think it needs to start at the beginning of a line.)

Thanks Yunsheng and Simon. I wasn't sure since this patch was targeted
for net-next. I have provided a Fixes tag below.
>
> > Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> >
> > >
> > > Link: https://lore.kernel.org/netdev/89d7ce83-cc1d-4791-87b5-6f7af29a=
031d@huawei.com/
> > >
Fixes: ebdfae0d377b ("gve: adopt page pool for DQ RDA mode")
> > > Suggested-by: Yunsheng Lin <linyunsheng@huawei.com>
> > > Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
>
> ...

