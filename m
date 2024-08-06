Return-Path: <netdev+bounces-115943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 647759487E2
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 05:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F12B20D88
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 03:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0320A2576F;
	Tue,  6 Aug 2024 03:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHl6MAwN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10602184D
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 03:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722914313; cv=none; b=MxHipatEAf/Ob5xYa6JjGKtfynqsQPh9A1aoSxzjDENwPtRUD9N2DUR6X4xnngN3uQvRRqlIaia5gnjcd4ylsD9+C6r3FQR6B3oFl+xjG6lZdPVcYMsFF+a/H2Z5SlH4ciRi7HWnBoejXCUwXsOzAw5zJjldEkna0OeGe8wzycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722914313; c=relaxed/simple;
	bh=OJhXkbjIVo9gnghOqEyHvPNaWkBh+mAR9MR8PaaHR+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agxNiVo0PXWYASa4862sISKiwBsEdzM3x6ja5MXXN5gGUoNeo4y/9Ok5vRX6SFxQIzJ6tU2+7jZblzjdwJX3ZNykXGV94dyli86bYGowKSvEm4in8IZknXtz0O3fz4UIuBP6eoBX4J7uf7gzxY4alZJvEXIrIQnm8plJjAkRCOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHl6MAwN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722914310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPEuUkAIfVQ7D9dTGeehHJAFhX16fWVMKU1oov6YUFg=;
	b=bHl6MAwNtntC/sISZxTzFlVcD28niGkFmDDPgHYlqGn+dMhP9ramApvlUzQzvHd/kOR8X9
	1Jl68x4QsjeYqrR6cDTiXD2/Gt0jC1K0fu+mm5X1JbwMRzuRyUpIWFesf/d+v8ypTYlLc4
	vkCQUWmSrZDAb/atLeVu8OoUzkAF/XI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-CfCh2WYoMqyZmlKJqbkQmw-1; Mon, 05 Aug 2024 23:18:29 -0400
X-MC-Unique: CfCh2WYoMqyZmlKJqbkQmw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb63abe6f7so211533a91.0
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 20:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722914308; x=1723519108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPEuUkAIfVQ7D9dTGeehHJAFhX16fWVMKU1oov6YUFg=;
        b=U7Hd5+keJ40fe/us0ReLsSkYdcVlij9Kwc3UslePlYfDaUzv310OuNJTJEi5pEZfPU
         27KIXwQyJPnSHjg12k1BIyDAW2PdgxP3aRazVX4aWXnQer0CLAyiGJUgvuHgDf2THM4B
         +flT2Gu2kNJ6EKAkmV8tbwJVPp01RDAdhaD7O9W5VzuPioTAWHIx6YQ6TmycwKNckBlW
         kz1v4dHI9ubPkRqcEWY5lBv+mNTqdCDkKOE10+VRIN0b+VAdW+iq6vSpxrGtFdAHHROR
         9oDbTuegeHUfcjcIPeuOx6g1E1WFKBNwBHLnzIy/MRrQ2z6hOaL8joIbpTmP1CmafZc7
         /OJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtw1upAvbzDgekOVXDy/gmPmXGMaiRvBP8y0P4HIEMzx9mU//Zhv0H5PQapRB17klq+RObfkIKcltuZ1SfhABjOlFT2KVI
X-Gm-Message-State: AOJu0Yy7MVzIAA8E3ld+0FEND0Dn/5BlsNG6I3RcTj8ly+k0QAMULJ33
	QRj049GjVl3C1vg/mdgZgt2AxgkBNPR0Ao7uuR9n64bjLnRwulnhhoFI5c1juO8wLtUQW2s+HNi
	c1CgJhkQD4jffZKi1R3r0cFUvJRIip2Ksc3dGGid7yIF9FkhNTx9zfiC4nludL/t8oUH4fG9qwk
	6rCfKo406lQivXGZdGNGcUBwNSKZQE
X-Received: by 2002:a17:90b:3ec3:b0:2cb:4bed:ed35 with SMTP id 98e67ed59e1d1-2cff955cbf6mr15080751a91.41.1722914308219;
        Mon, 05 Aug 2024 20:18:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQHYxJ2Ckl5ZzFyXOIbqu5/PhV5Y9dilRO7UtPLeoygThbaNEEZB0wEz9iF8NjmUwSr+GZBoYNvqI7tVMH5XA=
X-Received: by 2002:a17:90b:3ec3:b0:2cb:4bed:ed35 with SMTP id
 98e67ed59e1d1-2cff955cbf6mr15080730a91.41.1722914307714; Mon, 05 Aug 2024
 20:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801135639.11400-1-hengqi@linux.alibaba.com>
 <CACGkMEtBeUnDeD0zYBvpwjhQ4Lv0dz8mBDQ_C-yP1VEaQdv-0A@mail.gmail.com>
 <20240802090822-mutt-send-email-mst@kernel.org> <CACGkMEvPdiKS7+S5Btk+uMwtwRnPfTd6Brwz2acgBfNAnTXMFA@mail.gmail.com>
 <20240805015308-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240805015308-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Aug 2024 11:18:14 +0800
Message-ID: <CACGkMEsL6fyf9ecY8_LpT5_=hHKFzW7==4DBer_w9xEpGUkRtw@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Prevent misidentified spurious
 interrupts from killing the irq
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 2:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Aug 05, 2024 at 11:26:56AM +0800, Jason Wang wrote:
> > On Fri, Aug 2, 2024 at 9:11=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Fri, Aug 02, 2024 at 11:41:57AM +0800, Jason Wang wrote:
> > > > On Thu, Aug 1, 2024 at 9:56=E2=80=AFPM Heng Qi <hengqi@linux.alibab=
a.com> wrote:
> > > > >
> > > > > Michael has effectively reduced the number of spurious interrupts=
 in
> > > > > commit a7766ef18b33 ("virtio_net: disable cb aggressively") by di=
sabling
> > > > > irq callbacks before cleaning old buffers.
> > > > >
> > > > > But it is still possible that the irq is killed by mistake:
> > > > >
> > > > >   When a delayed tx interrupt arrives, old buffers has been clean=
ed in
> > > > >   other paths (start_xmit and virtnet_poll_cleantx), then the int=
errupt is
> > > > >   mistakenly identified as a spurious interrupt in vring_interrup=
t.
> > > > >
> > > > >   We should refrain from labeling it as a spurious interrupt; oth=
erwise,
> > > > >   note_interrupt may inadvertently kill the legitimate irq.
> > > >
> > > > I think the evil came from where we do free_old_xmit() in
> > > > start_xmit(). I know it is for performance, but we may need to make
> > > > the code work correctly instead of adding endless hacks. Personally=
, I
> > > > think the virtio-net TX path is over-complicated. We probably pay t=
oo
> > > > much (e.g there's netif_tx_lock in TX NAPI path) to try to "optimiz=
e"
> > > > the performance.
> > > >
> > > > How about just don't do free_old_xmit and do that solely in the TX =
NAPI?
> > >
> > > Not getting interrupts is always better than getting interrupts.
> >
> > Not sure. For example letting 1 cpu to do the transmission without the
> > dealing of xmit skbs should give us better performance.
>
> Hmm. It's a subtle thing. I suspect until certain limit
> (e.g. ping pong test) free_old_xmit will win anyway.

Not sure I understand here.

>
> > > This is not new code, there are no plans to erase it all and start
> > > anew "to make it work correctly" - it's widely deployed,
> > > you will cause performance regressions and they are hard
> > > to debug.
> >
> > I actually meant the TX NAPI mode, we tried to hold the TX lock in the
> > TX NAPI, which turns out to slow down both the transmission and the
> > NAPI itself.
> >
> > Thanks
>
> We do need to synchronize anyway though, virtio expects drivers to do
> their own serialization of vq operations.

Right, but currently add and get needs to be serialized which is a
bottleneck. I don't see any issue to parallelize that.

> You could try to instead move
> skbs to some kind of array under the tx lock, then free them all up
> later after unlocking tx.
>
> Can be helpful for batching as well?

It's worth a try and see.

>
>
> I also always wondered whether it is an issue that free_old_xmit
> just polls vq until it is empty, without a limit.

Did you mean schedule a NAPI if free_old_xmit() exceeds the NAPI quota?

> napi is supposed to poll until a limit is reached.
> I guess not many people have very deep vqs.

Current NAPI weight is 64, so I think we can meet it in stressful workload.

Thanks

>
> --
> MST
>


