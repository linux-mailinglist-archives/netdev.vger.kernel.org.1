Return-Path: <netdev+bounces-112647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C3E93A50E
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 19:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5761284B68
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAAF13BC18;
	Tue, 23 Jul 2024 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gkx7x2p3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F57158205
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721756271; cv=none; b=jPfTa5Z5lZAU9y/ixo3rdyamiEsF/6eUkWUVHLX1G9PJzhVUy0ksj91smOXQCXrvEnX7paUF390DxT1iPa1Y91BmtxCKw4YiNy7qNn98P+I9g4DCG7xp+wjJKM2TDNePtZzl0+lDbLxUm1PcdNwW+ikZ9dyltJ1qfSEHQotujrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721756271; c=relaxed/simple;
	bh=1d6bcrj54tr+nvppIN+9izIxELVF42VSjccFu7CntNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaHFBEK+Og1XeiKH/skhmUk57z6ZrlzMt+2uBhunOusyrL7V0Ffm7pJN/zAdMDWNbAiMwDW2lFy2bM47wMCl4agZ+Mkt8tpMwk8fxuBfP73uiO4zhn1VABM86DoKu7fshagNzi1HdGVso/yDitKg9B3Ehx6fb8g9Kj/qW1G9kws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gkx7x2p3; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eefe705510so64826501fa.1
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 10:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721756267; x=1722361067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKeQA+A0UlQLZ1mtE7JuZrTFkG71lLRyFRKBZecnEOo=;
        b=Gkx7x2p31lzWtHn4jjqtU3tcaVy4rmoFxzhkZuIoO/OYEEykKJSUAtFXm2PVnKi0Mq
         oBQKCFCgJKTBCFKDhUf0vlbUx9huKKmTQYsTS61cmxE7ypNDap4NT3Tbbp6rrEpgIc8z
         IEfNTOHGULlPzi+OrW1EIfzE10VuDYN5AbFSqevwbpn433LcKC2l2uUbkx0TCxp2Jysn
         RKEZuvegqUWYrHb2Dmac0Og+H1SGGdCJJV0wCeJ6ihlE7ypQOAyL0XIReVOeuRs7GTG5
         bpUPx6lPsIjoOHbSk4XxFkUnmQyU+vTxfAHXJnZuWKt5Ejh5jc8yRcOMTGrq2hdiDTw4
         uGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721756267; x=1722361067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKeQA+A0UlQLZ1mtE7JuZrTFkG71lLRyFRKBZecnEOo=;
        b=HlDh3x6OZp7I3etgWF6REpLMCKI/RMFkKs3OTcPySGSHjyiQYbIO6rnPc1aDUg3rdJ
         r59GIDvejKr/iNpq357vmQ+jMeW/2ELG/LpUDLop8M45bpU7gDy/w2wrQ3NT8FX9R2vC
         60MVDfCcux07+5BmUSV+KMdnTx6vYXlV72Ve4yBysRbChs2rtSBvaJUbdAe4KDmE6NrE
         YQH++WKXi0GkK4rzI46vCaASfC4f+8eUFmL3L/t4e92KHlgBIB+lwJkRjFvoTRjKwJlS
         Mk0zuXrpVagXnvmciYgEG/l8oBiHA1tikbw+izMSS9arwBKpWgOwpoMTIy8kC0uxbp9+
         T3EA==
X-Forwarded-Encrypted: i=1; AJvYcCVQP6t3oneCn6wkjjSteMLiqzjtBylUkEvetDHTlS7iak4YHPMo+hSEgHpkwipkMamZF8v764tL0lCw02GNOvyV9ywfLc7F
X-Gm-Message-State: AOJu0YxeOcGQsduXu1GQhVJv++q44atJRN8kqNA2ok0xdNdBoUMDk8T7
	HGOmeu3ALZ9E2afFZcm0mVgZDrXTl1zVZY+aZ7k8IBu2tNeU8Yk0n0usX+rhh4x+p7y6WUKTkq+
	Y4L5g7HqeO9a2tMwApTMyfxjKm20=
X-Google-Smtp-Source: AGHT+IGgTfkX+UeRiEyFZqoXeE3d/Pmu9hhEHr+K59gi19pq3hRNqauzDEOkxIymSn+HuvaVahcPRDoveg1vjfOEaoc=
X-Received: by 2002:a05:651c:1201:b0:2ef:26f2:d3e2 with SMTP id
 38308e7fff4ca-2f02b6fb5ebmr4365691fa.2.1721756267109; Tue, 23 Jul 2024
 10:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240721053554.1233549-1-ap420073@gmail.com> <7657b8ca-ce93-46a5-93bf-f5572ba7806b@redhat.com>
In-Reply-To: <7657b8ca-ce93-46a5-93bf-f5572ba7806b@redhat.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 24 Jul 2024 02:37:35 +0900
Message-ID: <CAMArcTUyvwTL15MtT5rPugfJL2JrgJvUibWwXF6TAuPPXHd2yg@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: update xdp_rxq_info in queue restart logic
To: Paolo Abeni <pabeni@redhat.com>
Cc: michael.chan@broadcom.com, somnath.kotur@broadcom.com, kuba@kernel.org, 
	dw@davidwei.uk, netdev@vger.kernel.org, horms@kernel.org, edumazet@google.com, 
	davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 7:59=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>

Hi Paolo,
Thanks a lot for the review!

> On 7/21/24 07:35, Taehee Yoo wrote:
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
>
> @Michael: looks good?
>
> > @@ -15018,6 +15019,16 @@ static int bnxt_queue_mem_alloc(struct net_dev=
ice *dev, void *qmem, int idx)
> >       if (rc)
> >               return rc;
> >
> > +     rc =3D xdp_rxq_info_reg(&clone->xdp_rxq, bp->dev, idx, 0);
> > +     if (rc < 0)
> > +             goto err_page_pool_destroy;
> > +
> > +     rc =3D xdp_rxq_info_reg_mem_model(&clone->xdp_rxq,
> > +                                     MEM_TYPE_PAGE_POOL,
> > +                                     clone->page_pool);
> > +     if (rc)
> > +             goto err_rxq_info_unreg;
> > +
> >       ring =3D &clone->rx_ring_struct;
> >       rc =3D bnxt_alloc_ring(bp, &ring->ring_mem);
> >       if (rc)
>
> Side note for a possible 'net-next' follow-up: there is quite a bit of
> duplicated code shared by both bnxt_queue_mem_alloc() and
> bnxt_alloc_rx_rings(), that is likely worth a common helper.
>

Yes, I agree with you.
I will try to refactor it after the merge window.

Thanks a lot!
Taehee Yoo


> Thanks,
>
> Paolo
>

