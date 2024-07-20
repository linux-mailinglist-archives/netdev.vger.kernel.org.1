Return-Path: <netdev+bounces-112297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EBA9381C4
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 17:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C09D1C20C28
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 15:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABA212CDBE;
	Sat, 20 Jul 2024 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEd1UByx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB7B14294
	for <netdev@vger.kernel.org>; Sat, 20 Jul 2024 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721488002; cv=none; b=XpeNkI2Q0M2onp6qdp/hicK8rNm1j/gv5xfkhExixAvPszagp1OG8cWYePd4iQ4cIYyTQOTf3qwolzE/SqVCkEnTbL4vHC0r1yjX/ybiF+XsRkArd2a3G+EuGGQVefD4W6/JQG0TL/2LiGHLlkOKdjQ7IH6ml87VGg5G6lRRuuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721488002; c=relaxed/simple;
	bh=hQYRSIQfYXedSv44PaqnMPMgH1Ckv0BjAYSaEKIFwfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggrBb6PMPiBE/NYVXKYA1DwRMTp4tO5wEpMyuye3AXjF62fhYH74L1D3ldQpsaaMbfYk+mZxpddxBttc8bH8j4vGIPhQttDbizzaLPyR83Y+kidPTPavZOuGKHagt0ENB39BKMc1j5nWADkLxAf4yehcEm0sZIQV/9Jd6PhlvoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEd1UByx; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eede876fccso35334121fa.1
        for <netdev@vger.kernel.org>; Sat, 20 Jul 2024 08:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721487999; x=1722092799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+RNAnpMtMJ6n/o9ByYXve4qKgPeHmZptCll5sHCKFc=;
        b=KEd1UByxuItrXC0M676fnKXI4oGGmc7GBAyAkM0a/qmO3bpu38pCl3m/DGIfJOWeL7
         INMjhgzgwIqeT8BwKkphFvvmP6Cs10Klu5aj2hhWjSr+SB5RqkLUgU9P3HKfN3SbnOcy
         S2NKPPGvQZZC0D+RAuAokYKkjj5nNWjQvjMgPHZl1jRBOs3on5wS2VLy8gVVdcWARTGz
         pP7Gm0x852543a53d6DdxY7Diu+ZMQJyq9VM7Lmpi6D2ENtx/krPG8b+34FURmSs6uvP
         MnksKgtSn10vITLePg5TnPEXiRAMKiph5BKkhXoaVx+g0D3ZORDTn3lRYhaYZrCjp2O8
         dZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721487999; x=1722092799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+RNAnpMtMJ6n/o9ByYXve4qKgPeHmZptCll5sHCKFc=;
        b=e7wsVap1hSqeJDLf0E9pDheBJPAacZT8+DHm7qGLEJjawLZhB4UOCOWztKfQS95ihP
         0nR+oURsE4Lv2OROOletOiGeLkEtBmXtOeXbNXhi/oYeQfwXxqVQv9uy/EwmLR2WZwA2
         RxfVNZsS+sRJFQ9pvhClv0RvPdrL3jvjAIwJKsi0ZwnrzO33/z+PrS/jKFuedLaOMpdA
         Ef11z0wJTpWZh6phpsSNP8v9iZcWBrCcHE9WoYl/ZsvCmgGE+/4e16cxQoOTol9uCgWQ
         v99U080Abqq40VcRpl1Yuc9EEy91uvGJRRb1oxKw27/VQ+feO1NH9vTJWcudiqivOqqz
         u+yg==
X-Forwarded-Encrypted: i=1; AJvYcCX5RSOUQ/gwtFc869VBsAQUB0hmWJ3W8+pbeTTo/2GbzsG5otM+RjP9xFsCIpiAGS7NkbRTwStA246bh6uTaaPdCaMo162F
X-Gm-Message-State: AOJu0YyfqMEAq+trMWpYTkzObVSc9okWDIBvdgromJ+i8sSmGKIp4mDg
	ru/nvr3q9Lv+qoTPe7GX1/MGKLtPGcif2w4cei2eg8PQ2MaN+3rfresQQVBSgDu+JxWzFZ6kosf
	6bal3sJwgWlkG3YktG6m40wBNrOg=
X-Google-Smtp-Source: AGHT+IH44rv0j7Tt8ez23D7oIFPxE0bffTyn4KWtfGgGKYsDIRhW8wWEzpk2H45Y1MvcAdmr1eWdnx2WPyo6paKYPTA=
X-Received: by 2002:a2e:9ccb:0:b0:2ee:7a54:3b08 with SMTP id
 38308e7fff4ca-2ef16738372mr18559881fa.3.1721487998712; Sat, 20 Jul 2024
 08:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719041911.533320-1-ap420073@gmail.com> <74fcb647-0226-4aa4-bf99-06fee8d510d0@davidwei.uk>
In-Reply-To: <74fcb647-0226-4aa4-bf99-06fee8d510d0@davidwei.uk>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sun, 21 Jul 2024 00:06:27 +0900
Message-ID: <CAMArcTXm=4sfJ3oLf7-ZxobNyoeHWrg+-_Yirm4QszoaVnSbfA@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: update xdp_rxq_info in queue restart logic
To: David Wei <dw@davidwei.uk>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, michael.chan@broadcom.com, netdev@vger.kernel.org, 
	somnath.kotur@broadcom.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2024 at 2:13=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>

Hi David,
Thanks a lot for the review!

> On 2024-07-18 21:19, Taehee Yoo wrote:
> > When the netdev_rx_queue_restart() restarts queues, the bnxt_en driver
> > updates(creates and deletes) a page_pool.
> > But it doesn't update xdp_rxq_info, so the xdp_rxq_info is still
> > connected to an old page_pool.
> > So, bnxt_rx_ring_info->page_pool indicates a new page_pool, but
> > bnxt_rx_ring_info->xdp_rxq is still connected to an old page_pool.
> >
> > An old page_pool is no longer used so it is supposed to be
> > deleted by page_pool_destroy() but it isn't.
> > Because the xdp_rxq_info is holding the reference count for it and the
> > xdp_rxq_info is not updated, an old page_pool will not be deleted in
> > the queue restart logic.
> >
> > Before restarting 1 queue:
> > ./tools/net/ynl/samples/page-pool
> > enp10s0f1np1[6] page pools: 4 (zombies: 0)
> >       refs: 8192 bytes: 33554432 (refs: 0 bytes: 0)
> >       recycling: 0.0% (alloc: 128:8048 recycle: 0:0)
> >
> > After restarting 1 queue:
> > ./tools/net/ynl/samples/page-pool
> > enp10s0f1np1[6] page pools: 5 (zombies: 0)
> >       refs: 10240 bytes: 41943040 (refs: 0 bytes: 0)
> >       recycling: 20.0% (alloc: 160:10080 recycle: 1920:128)
>
> Thanks, didn't know this existed! As a follow up once Mina lands his
> devmem TCP series with netdev_rx_queue_restart(), a netdev netlink
> selftest using would be great.
>

Yes, that would be great!

> >
> > Before restarting queues, an interface has 4 page_pools.
> > After restarting one queue, an interface has 5 page_pools, but it
> > should be 4, not 5.
> > The reason is that queue restarting logic creates a new page_pool and
> > an old page_pool is not deleted due to the absence of an update of
> > xdp_rxq_info logic.
> >
> > Fixes: 2d694c27d32e ("bnxt_en: implement netdev_queue_mgmt_ops")
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index bb3be33c1bbd..11d8459376a9 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> [...]
> > @@ -15065,6 +15079,8 @@ static void bnxt_queue_mem_free(struct net_devi=
ce *dev, void *qmem)
> >       page_pool_destroy(rxr->page_pool);
> >       rxr->page_pool =3D NULL;
> >
> > +     xdp_rxq_info_unreg(&rxr->xdp_rxq);
> > +
>
> IMO this should go before page_pool_destroy() for symmetry with
> bnxt_free_rx_rings(). I know there's already a call deep inside of
> xdp_rxq_info_unreg().
>

I agree about symmetry. So I will change it.

> >       ring =3D &rxr->rx_ring_struct;
> >       bnxt_free_ring(bp, &ring->ring_mem);
> >
> > @@ -15145,6 +15161,7 @@ static int bnxt_queue_start(struct net_device *=
dev, void *qmem, int idx)
> >       rxr->rx_sw_agg_prod =3D clone->rx_sw_agg_prod;
> >       rxr->rx_next_cons =3D clone->rx_next_cons;
> >       rxr->page_pool =3D clone->page_pool;
> > +     memcpy(&rxr->xdp_rxq, &clone->xdp_rxq, sizeof(struct xdp_rxq_info=
));
>
> Assignment is fine here.

Okay, I will use the assignment instead of the memcpy.

I will send a v2 patch after some tests.

Thanks a lot!
Taehee Yoo

