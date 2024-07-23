Return-Path: <netdev+bounces-112653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4779B93A534
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 19:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8432A28296C
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79938158211;
	Tue, 23 Jul 2024 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7zR0Ub/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0704156C5F
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721757536; cv=none; b=VPrcR0VRg/4d+1g6hkpq2NUjSKBgzi04q4eM7WFSgGa8ngNp752hh67PL+VaujJJfis3Zgo1Xs29VV9Va9n6LIryHeZvh+UK6SrqvWX9Ij4ZtCP5bBhRnKYXxBrHfguMiU1DBTXJGPQFRx8hysU+SuN7mm9WDeDsN4tarKxANXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721757536; c=relaxed/simple;
	bh=QAFEw8auFi9UumLl2RBo6tL9aOds6/xwHX2unrWLgDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEaDMILr0ojVqSi7pvyFHxTIiAgromiragV9vTaJLU/bZ/PF4go5+JJ8o1cSvjjT4DBcqxyDN1nHxc6DKe12IGji8JU5fG2aVu6UT+w57T99B4GZ889AU3lzreyUUVXv7IpyTWm1YTtp2LQZ4xYS/lAH3+s3IVcSTdZPnzqxA1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7zR0Ub/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc34677so4884272a12.2
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721757533; x=1722362333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HarFZ2y7M06ORFjFQVm6D25MQj8us1WC0TR2iEf/XNQ=;
        b=b7zR0Ub/Vj2T2Tb4sOWRs+giiS5bbpHpwwAUB9YIwRKZ8x0j7vaHzXUgEHv04oXF24
         687/mBkfWMSqj5lqzZTylU/fpRH95rfoMec+2hzG5v4syJdOUHvM5tf3V9Y80On0mw95
         SCSzBleVGUXC+yafunXLuyZU799cbHUlPMDQtM28/1TFJVhxEOfaAyGjaM/Sh3a+YbTm
         3l+kAOiOzuyRzn4pYJeo+pIX6wPwMAuCAV1iI2/q+w55vig1UP6bHTsim0gRERV917I3
         eKjkXz8aQvdImAiZpSHclWH8q0sVgq4gz/vgtya5G9nadHlGcGh0BPsfzA1V/24p4vVR
         FwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721757533; x=1722362333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HarFZ2y7M06ORFjFQVm6D25MQj8us1WC0TR2iEf/XNQ=;
        b=szaeo1ineX+mgIToedptRA+EjhBP5nsrdaRaFhHWn5JmF7dAx809leywhSwcFdQNeg
         1W/Qtlwt3DUVzYC+9PXrqzM+iR8zKnMhhQbpmoQAGCIOkIiyMKPEvw/GfrTg2QeoFA7b
         0zo9iEgtDfHYLfrQC+F12AvnqOre8Ryx5DNKxWLrvavtz8gy34TTJJzROoA1v3rz4PkY
         u1B/6SMsTMgqgCJcAZ6RJP2D9fFN1w/0pPtAFow6OuRzfNaFaDKiy4zh65HPyNvPahCf
         qlTJxNKfB0Q46g9bMzXipq1R+hJfLisce3ldNEUUEhfocrGWeuUggRNdddKApCA2wWdK
         cTeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvLcq4b0EicHFn+1lSd834oEZCGTJGb3Fe4sQu3nAmt9Pl1VJVPrrrHkqtHFXYiimkQLeC1mNSMQvPt6eXPKrQ78F8FofG
X-Gm-Message-State: AOJu0YyrYBgKiV3sn4ZgUfnQu78IFt4kjh1rkrNNATv3IHrYyFXXwJSO
	KTuR6li9HXUEcftd4rc1jBX6PHND5JuytRo0FJ4f6F1rFv6D1/tsNlHGBQfXuRFlg7jSbM9/koR
	K3NLNpNxYb9Xrs7wMvPtDXXRE5EY=
X-Google-Smtp-Source: AGHT+IGI7QTKJNLmnZq80QjBEMIaOCnaQg3QJD5gLoVZp1EVKOi8GqUMEQAsfB3StQ0QNL/jWqn1tBgnXZbzT5WjKZ4=
X-Received: by 2002:a50:ccc2:0:b0:5a2:1f7b:dfff with SMTP id
 4fb4d7f45d1cf-5a478b79a8fmr6326319a12.6.1721757532619; Tue, 23 Jul 2024
 10:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240721053554.1233549-1-ap420073@gmail.com> <dcdf039f-4040-4a31-9738-367eda59fd04@amd.com>
In-Reply-To: <dcdf039f-4040-4a31-9738-367eda59fd04@amd.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 24 Jul 2024 02:58:41 +0900
Message-ID: <CAMArcTUA9a7Jndk8aNK6cxth=B4UqgPhpJKk1++KXrQrzJXMzA@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: update xdp_rxq_info in queue restart logic
To: Brett Creeley <bcreeley@amd.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, michael.chan@broadcom.com, netdev@vger.kernel.org, 
	somnath.kotur@broadcom.com, dw@davidwei.uk, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 12:42=E2=80=AFAM Brett Creeley <bcreeley@amd.com> w=
rote:
>

Hi Brett,
Thanks a lot for the review!

>
>
> On 7/20/2024 10:35 PM, Taehee Yoo wrote:
> > Caution: This message originated from an External Source. Use proper ca=
ution when opening attachments, clicking links, or responding.
> >
> >
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
> >          refs: 8192 bytes: 33554432 (refs: 0 bytes: 0)
> >          recycling: 0.0% (alloc: 128:8048 recycle: 0:0)
> >
> > After restarting 1 queue:
> > ./tools/net/ynl/samples/page-pool
> > enp10s0f1np1[6] page pools: 5 (zombies: 0)
> >          refs: 10240 bytes: 41943040 (refs: 0 bytes: 0)
> >          recycling: 20.0% (alloc: 160:10080 recycle: 1920:128)
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
> >
> > v2:
> >   - Do not use memcpy in the bnxt_queue_start
> >   - Call xdp_rxq_info_unreg() before page_pool_destroy() in the
> >     bnxt_queue_mem_free().
> >
> >   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.c
> > index bb3be33c1bbd..ffa74c26ee53 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -4052,6 +4052,7 @@ static void bnxt_reset_rx_ring_struct(struct bnxt=
 *bp,
> >
> >          rxr->page_pool->p.napi =3D NULL;
> >          rxr->page_pool =3D NULL;
> > +       memset(&rxr->xdp_rxq, 0, sizeof(struct xdp_rxq_info));
> >
> >          ring =3D &rxr->rx_ring_struct;
> >          rmem =3D &ring->ring_mem;
> > @@ -15018,6 +15019,16 @@ static int bnxt_queue_mem_alloc(struct net_dev=
ice *dev, void *qmem, int idx)
> >          if (rc)
> >                  return rc;
> >
> > +       rc =3D xdp_rxq_info_reg(&clone->xdp_rxq, bp->dev, idx, 0);
> > +       if (rc < 0)
> > +               goto err_page_pool_destroy;
> > +
> > +       rc =3D xdp_rxq_info_reg_mem_model(&clone->xdp_rxq,
> > +                                       MEM_TYPE_PAGE_POOL,
> > +                                       clone->page_pool);
> > +       if (rc)
> > +               goto err_rxq_info_unreg;
> > +
> >          ring =3D &clone->rx_ring_struct;
> >          rc =3D bnxt_alloc_ring(bp, &ring->ring_mem);
> >          if (rc)
> > @@ -15047,6 +15058,9 @@ static int bnxt_queue_mem_alloc(struct net_devi=
ce *dev, void *qmem, int idx)
> >          bnxt_free_ring(bp, &clone->rx_agg_ring_struct.ring_mem);
> >   err_free_rx_ring:
> >          bnxt_free_ring(bp, &clone->rx_ring_struct.ring_mem);
> > +err_rxq_info_unreg:
> > +       xdp_rxq_info_unreg(&clone->xdp_rxq);
>
> I think care needs to be taken calling xdp_rxq_info_unreg() here and
> then page_pool_destroy() below due to the xdp_rxq_info_unreg() call flow
> eventually calling page_pool_destroy(). Similar comment below.
>
> > +err_page_pool_destroy:
> >          clone->page_pool->p.napi =3D NULL;
> >          page_pool_destroy(clone->page_pool);
> >          clone->page_pool =3D NULL;
> > @@ -15062,6 +15076,8 @@ static void bnxt_queue_mem_free(struct net_devi=
ce *dev, void *qmem)
> >          bnxt_free_one_rx_ring(bp, rxr);
> >          bnxt_free_one_rx_agg_ring(bp, rxr);
> >
> > +       xdp_rxq_info_unreg(&rxr->xdp_rxq);
> > +
>
> If the memory type is MEM_TYPE_PAGE_POOL, xdp_rxq_info_unreg() will
> eventually call page_pool_destroy(). Unless I am missing something I
> think you want to remove the call below to page_pool_destroy()?
>

I think both page_pool_destroy() and xdp_rxq_info_unreg() are needed here.
Because the page_pools are managed by reference count.

When a page_pool is created by page_pool_create(), its count is 1 and it
will be destroyed if the count reaches 0. The page_pool_destroy()
decreases a reference count so that page_pool will be destroyed.
The xdp_rxq_info_reg() also holds a reference count for page_pool if
the memory type is page_pool.

As you mentioned xdp_rxq_info_unreg() internally calls page_pool_destroy()
if the memory type is page pool.
So, to destroy page_pool if xdp_rxq_info was registered,
both xdp_rxq_info_unreg() and page_pool_destroy() should be called.

Thanks a lot!
Tahee Yoo

> Thanks,
>
> Brett
>
> >          page_pool_destroy(rxr->page_pool);
> >          rxr->page_pool =3D NULL;
> >
> > @@ -15145,6 +15161,7 @@ static int bnxt_queue_start(struct net_device *=
dev, void *qmem, int idx)
> >          rxr->rx_sw_agg_prod =3D clone->rx_sw_agg_prod;
> >          rxr->rx_next_cons =3D clone->rx_next_cons;
> >          rxr->page_pool =3D clone->page_pool;
> > +       rxr->xdp_rxq =3D clone->xdp_rxq;
> >
> >          bnxt_copy_rx_ring(bp, rxr, clone);
> >
> > --
> > 2.34.1
> >
> >

