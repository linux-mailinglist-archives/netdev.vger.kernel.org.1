Return-Path: <netdev+bounces-112908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0722293BBEE
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 07:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AC11F21707
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 05:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D6917BAA;
	Thu, 25 Jul 2024 05:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je7TRYS8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912A718E2A
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 05:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721883632; cv=none; b=SePi+fnVTxwg2e61bMFP+IoFuVy/OSFJznFjcKnyFkhB+pP1IggSY5UyRyaAzbJYN1rbiNTASiXAo7Wt+wmEn+eWKaev1l4Y5JMgT0VnIBtfkK7OQU0vPd+dqoiltNI/C9Tqh+tCM8VHjVJKXxRMt1Jzov2byfMUPbhYlfrSsJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721883632; c=relaxed/simple;
	bh=jjPH5QNfJQ2e7irgEkS+MOYOPVhkMSytecqKhrOjSlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6Rbc0igXUiEeoe3bTdm0iLcz8mPCEIZcoCreacsR0WIMWxu9JlOuMJBLzMFhxyPQz8C0sRAEBGaL32Qaz9w/mFkKVPZgr/pJ1FNFAiGsE87Ik29TCsv3lBtUs3VriQHFCWaaSTcKvVg+XpfeUDF2KBLkvh8AUViXvOO88gxI8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je7TRYS8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so662059a12.3
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 22:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721883629; x=1722488429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlO/7FXAwgveqXaD1HEe3OlTI1Uc341bn28uA/Z8Dlw=;
        b=Je7TRYS8Au5LLHbuzyYVTjdzmFt1Uo1EtuPWjA0jknU3F7ZjsNCTiUkINndvxrVdEW
         hUOKrsEcXhqSTsgIT3KHoFDW355m670Y9fJIh6BsXOlogaEVgDHhA994xaP0teN60X02
         8kTdu98LdwrgXiYq2BwtI+EPqZXt3oDwnFlXzCBL6lcGatBcBIflzV3/uI6VzGoyjktu
         rekf5wk1Avtpu3eAuh+uVhMrtgeetLLVcVDPQwdCkiI/EkgwR700+oG7JFo6BImH5g5n
         x0eA6IBLLasIrlSQSfKoAViexRAeQwirOJcVk12aB3Wqp5YwyS3wo6ywIaXGvl+BgU/T
         mlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721883629; x=1722488429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlO/7FXAwgveqXaD1HEe3OlTI1Uc341bn28uA/Z8Dlw=;
        b=tL+/ffmoN4RRj15lpETROvhx7pD1Th42mMOcIjy3bfQ+CYLxB2b6GqK5t8xXw3mPH9
         yBeMSl5xQKOE6aYvSWqKcnAH2heK+BUGJNB1G+GwWM5SfonJ9hm6vPtAAUVt5+kM7BI8
         qeOCPW3vVY4PfP+5uWJMfOwWEHSxoohGk9j8w/KIFoQQ0pwK0xy0y/TkUlQn1IPipVaY
         XFvC/VsuoDorrNTIfrofwFDMwvlkYsHTYVDcm4nu1nA0z/O8s+KPTDXlVtu8jFqirkNi
         ib3HarhN8bzKuZbGZUE5T9ov4vG/kMNSAbt9h91ChXs5rTNh1uBrT1Q2O5hJZO8Cn4oO
         nnUw==
X-Forwarded-Encrypted: i=1; AJvYcCVLdagkLRYf8nPueXPQQzRImVp2jlYDzkXKJGy+PbKYUYa4gPpqKVysKTqZdc856ydfcG55cEcKYeGp/WRZ7Yspkp/Pqykt
X-Gm-Message-State: AOJu0Yzk0SdQ3b8YKLEYCzNTMu6mu7gq0+FOhP+yvnPHDHP9TW7NYXLN
	FFmwYgKQ0lIXUuPmgr1UViZAMg2OcGHawUuMNuS92BK5tPnzyaeI0NL8R9vqF/+13HlbLPtlPaw
	iNSwBKMXJjBaGRAq3cpbogxOmsGE=
X-Google-Smtp-Source: AGHT+IEjTTBBSB4fo4X7vXEvQfDMxV9pykLUOjUsCINpOCtrDbUT0mP4eRpfL4kt1FEc0JvRsco6SyRVSLS9YowTIF4=
X-Received: by 2002:a50:cc8b:0:b0:59e:a1a6:134d with SMTP id
 4fb4d7f45d1cf-5ac64128a04mr550788a12.32.1721883628532; Wed, 24 Jul 2024
 22:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240721053554.1233549-1-ap420073@gmail.com>
In-Reply-To: <20240721053554.1233549-1-ap420073@gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Thu, 25 Jul 2024 14:00:17 +0900
Message-ID: <CAMArcTW6kMrBsLtJs96vg-KCNEUM7jficOuLL12M4+2=2SbJaQ@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: update xdp_rxq_info in queue restart logic
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, michael.chan@broadcom.com, netdev@vger.kernel.org
Cc: somnath.kotur@broadcom.com, dw@davidwei.uk, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 21, 2024 at 2:36=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> When the netdev_rx_queue_restart() restarts queues, the bnxt_en driver
> updates(creates and deletes) a page_pool.
> But it doesn't update xdp_rxq_info, so the xdp_rxq_info is still
> connected to an old page_pool.
> So, bnxt_rx_ring_info->page_pool indicates a new page_pool, but
> bnxt_rx_ring_info->xdp_rxq is still connected to an old page_pool.
>
> An old page_pool is no longer used so it is supposed to be
> deleted by page_pool_destroy() but it isn't.
> Because the xdp_rxq_info is holding the reference count for it and the
> xdp_rxq_info is not updated, an old page_pool will not be deleted in
> the queue restart logic.
>
> Before restarting 1 queue:
> ./tools/net/ynl/samples/page-pool
> enp10s0f1np1[6] page pools: 4 (zombies: 0)
>         refs: 8192 bytes: 33554432 (refs: 0 bytes: 0)
>         recycling: 0.0% (alloc: 128:8048 recycle: 0:0)
>
> After restarting 1 queue:
> ./tools/net/ynl/samples/page-pool
> enp10s0f1np1[6] page pools: 5 (zombies: 0)
>         refs: 10240 bytes: 41943040 (refs: 0 bytes: 0)
>         recycling: 20.0% (alloc: 160:10080 recycle: 1920:128)
>
> Before restarting queues, an interface has 4 page_pools.
> After restarting one queue, an interface has 5 page_pools, but it
> should be 4, not 5.
> The reason is that queue restarting logic creates a new page_pool and
> an old page_pool is not deleted due to the absence of an update of
> xdp_rxq_info logic.
>
> Fixes: 2d694c27d32e ("bnxt_en: implement netdev_queue_mgmt_ops")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>
> v2:
>  - Do not use memcpy in the bnxt_queue_start
>  - Call xdp_rxq_info_unreg() before page_pool_destroy() in the
>    bnxt_queue_mem_free().
>
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index bb3be33c1bbd..ffa74c26ee53 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -4052,6 +4052,7 @@ static void bnxt_reset_rx_ring_struct(struct bnxt *=
bp,
>
>         rxr->page_pool->p.napi =3D NULL;
>         rxr->page_pool =3D NULL;
> +       memset(&rxr->xdp_rxq, 0, sizeof(struct xdp_rxq_info));
>
>         ring =3D &rxr->rx_ring_struct;
>         rmem =3D &ring->ring_mem;
> @@ -15018,6 +15019,16 @@ static int bnxt_queue_mem_alloc(struct net_devic=
e *dev, void *qmem, int idx)
>         if (rc)
>                 return rc;
>
> +       rc =3D xdp_rxq_info_reg(&clone->xdp_rxq, bp->dev, idx, 0);
> +       if (rc < 0)
> +               goto err_page_pool_destroy;
> +
> +       rc =3D xdp_rxq_info_reg_mem_model(&clone->xdp_rxq,
> +                                       MEM_TYPE_PAGE_POOL,
> +                                       clone->page_pool);
> +       if (rc)
> +               goto err_rxq_info_unreg;
> +
>         ring =3D &clone->rx_ring_struct;
>         rc =3D bnxt_alloc_ring(bp, &ring->ring_mem);
>         if (rc)
> @@ -15047,6 +15058,9 @@ static int bnxt_queue_mem_alloc(struct net_device=
 *dev, void *qmem, int idx)
>         bnxt_free_ring(bp, &clone->rx_agg_ring_struct.ring_mem);
>  err_free_rx_ring:
>         bnxt_free_ring(bp, &clone->rx_ring_struct.ring_mem);
> +err_rxq_info_unreg:
> +       xdp_rxq_info_unreg(&clone->xdp_rxq);
> +err_page_pool_destroy:
>         clone->page_pool->p.napi =3D NULL;
>         page_pool_destroy(clone->page_pool);
>         clone->page_pool =3D NULL;
> @@ -15062,6 +15076,8 @@ static void bnxt_queue_mem_free(struct net_device=
 *dev, void *qmem)
>         bnxt_free_one_rx_ring(bp, rxr);
>         bnxt_free_one_rx_agg_ring(bp, rxr);
>
> +       xdp_rxq_info_unreg(&rxr->xdp_rxq);
> +
>         page_pool_destroy(rxr->page_pool);
>         rxr->page_pool =3D NULL;
>
> @@ -15145,6 +15161,7 @@ static int bnxt_queue_start(struct net_device *de=
v, void *qmem, int idx)
>         rxr->rx_sw_agg_prod =3D clone->rx_sw_agg_prod;
>         rxr->rx_next_cons =3D clone->rx_next_cons;
>         rxr->page_pool =3D clone->page_pool;
> +       rxr->xdp_rxq =3D clone->xdp_rxq;
>
>         bnxt_copy_rx_ring(bp, rxr, clone);
>
> --
> 2.34.1
>

Hi Netdev maintainers,
I found the state of this patch is "change requested" from the patchwork.
I think there's no need for additional changes.
Could you please let me know what I'm missing?

Thanks a lot!
Taehee Yoo

