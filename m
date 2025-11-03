Return-Path: <netdev+bounces-234911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 002B0C29B26
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 01:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667AB188D840
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 00:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A418578F2F;
	Mon,  3 Nov 2025 00:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCSLA5DQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC42DC2E0
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 00:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762128842; cv=none; b=Z+sJ9a0KAsuHrgwrj+nA8DMVf3IpNpGrFavU3qmqweUjvW4D9U2y2Nj7Rj8VvCGn6VeOLQL5xz70jYCYNV1LPd8xiCwRW7NhCPokkQPpAadUo0EpiJCj2j5o/lMKkGo4rZqfRhIQJEhuc0i8GBAxKKbd0QOLXQ8TeI63hr9XyEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762128842; c=relaxed/simple;
	bh=JYT+3SCCSW7APX/nzmrkGCFn9ZnpSTuD750/ahKCHNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYczC63vUvipILRPIB0MqHPiEw9AIozvPX01kkR4eNBrhG8j1Zv25CvoiXM2DuS3CMjPFRyJm3pCIL54mUMpsmLdP84jJEReu0nxQHD2tyhz8Np0eegR4J/ux34PAXocVWmTx0nHOLxuqLQ8uyDmHBGNSzOF1SF2LHPqynOPIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCSLA5DQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-427007b1fe5so2925232f8f.1
        for <netdev@vger.kernel.org>; Sun, 02 Nov 2025 16:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762128839; x=1762733639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOuxHtzwdquHH9zolJdaO3A5NeSZtF+uXB30TvnegU0=;
        b=mCSLA5DQ/mvpPoYYNhsgyqgHztywzlx9cjWemItGSE6ekpl8dNFRwj4ggxPAdrFABd
         LqRLhFfWQ6jqZecZgM/HLh7TOHi7WSwOXn1C0H+t1VZ4nvRYFSGTBMcqqZDMKX3+KPTV
         X97pRDRm6E4LgvhShI4ljPWS2CzVW/1TEKpoYMOOSzF862rvy6WNS05VhxZx7Nd6pTMm
         UI/EitlL79tAQqsMypbbNvXvZjjQTtl6uMUgwln9HDORlCk9JumN3ShgmuvIEEijwozM
         L/5d4oyygt0bQPQUp1DSZF5vbH6kRrnIxaYkkj7uf8wh7WFuFNyyMkhok/ffVfxPgStl
         0k4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762128839; x=1762733639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOuxHtzwdquHH9zolJdaO3A5NeSZtF+uXB30TvnegU0=;
        b=CZU411ekNv1rcvvSoZesK6IeGCWutgiiuKVgR6nvAdFu+sITfXpUJqqLjhpAIgigX+
         MLwKEnR7YkZTGra2E0YUCaa57Mo/KgD2LDr5Mk6vB3wGLGya/t7UbXaItrXSiGZIq/d6
         ItD/LTRYwqTQsuAPLgRGobK9YMEmiR7mGJdyulMxrLZhPlTpksSiedSVsgfGAySgxr5j
         gFMpKeXVBQ2wPLO1XqmOw0WrWUbpQ179IAapZ4bCS3gkGvfRIYt9fT/O2Kw1UZLGSA72
         I3ruoJAWESOwQ6YHle+1wtFFG6+HqkcpYHhvaK+v298BIQxJjeTQfO2UqNatFYh4hu1G
         AlPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXybfW6BUHzVSMHtD5M/R6njWAOUd0vPLTYc+Wg0oil9/UHi93y27araM843bGV1IYGFJK9uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyWvu/PkvdOVMdwE6STOklTyjXTrosLYg+SBTAy5yAYqrDekVQ
	zkl3nOMiHssCITSzW+HOuQ0m7o6OGvrXmRL8hC1bGF7mG7XSrMLIx06LIIEQ3YnqlDWf1D17mpx
	bVHydvPXoGxfAWsWkAJl+eKlI/O+CnZ4=
X-Gm-Gg: ASbGncu33vVjfbF1O27/aIgDQv4nq8f9udjzXBGfLfhyCRpTQ3/kcZMk+m5OBlWzI1D
	wbMobfksMtOg8Kn4UzjaMmlicsPuM5T+Rsw1aFwEe5AEXaSgFNE2OVan0Ulg+cUy3nvNqm7N7FH
	Op22TNSYT+kCCrO7JVq5vMZcALcL6jzlb45SqSSUXfX6AYdVuPQPaVY/8xhyUNBj1Q65GCMGAJa
	nhToLRhXRHhMwj86YndHtkF7avC2Lk6LAtOGJVJj9kKZedd3DS/xF24hPs=
X-Google-Smtp-Source: AGHT+IEJLQ9Qs32c4nN4EYf3P0K455T/jgyLiOI6t2M6S3QTJJmpHPhDMlkGruBVv2YgvNSGluJX4xfHZYspk9MAKUY=
X-Received: by 2002:a05:6000:2887:b0:3d1:61f0:d26c with SMTP id
 ffacd0b85a97d-429bd6d56bfmr9839588f8f.54.1762128838913; Sun, 02 Nov 2025
 16:13:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031231038.1092673-1-zijianzhang@bytedance.com> <44f69955-b566-4fb1-904d-f551046ff2d4@gmail.com>
In-Reply-To: <44f69955-b566-4fb1-904d-f551046ff2d4@gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 2 Nov 2025 16:13:22 -0800
X-Gm-Features: AWmQ_bkRTtW2JpA4vpZMQmE9-PhX0xqmo8RxUIzacHIYTEmSLz2E347_nMeBRDM
Message-ID: <CAKgT0UdJX3T6UcmtbeYLRCNLtnF_=1Dx3RGwHSc_-Awk+cHwow@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/mlx5e: Modify mlx5e_xdp_xmit sq selection
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Zijian Zhang <zijianzhang@bytedance.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, 
	andrew+netdev@lunn.ch, saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, parav@nvidia.com, tariqt@nvidia.com, hkelam@marvell.com, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
	Salil Mehta <salil.mehta@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 5:02=E2=80=AFAM Tariq Toukan <ttoukan.linux@gmail.co=
m> wrote:
> On 01/11/2025 1:10, Zijian Zhang wrote:

...

> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers=
/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > index 5d51600935a6..6225734b256a 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> > @@ -855,13 +855,10 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n,=
 struct xdp_frame **frames,
> >       if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
> >               return -EINVAL;
> >
> > -     sq_num =3D smp_processor_id();
> > -
> > -     if (unlikely(sq_num >=3D priv->channels.num))
> > -             return -ENXIO;
> > -
> > +     sq_num =3D smp_processor_id() % priv->channels.num;
>
> Modulo is a costly operation.
> A while loop with subtraction would likely converge faster.

I agree. The modulo is optimizing for the worst exception case, and
heavily penalizing the case where it does nothing. A while loop in
most cases will likely just be a test and short jump which would be
two or three cycles whereas this would cost you somewhere in the 10s
of cycles for most processors as I recall.

