Return-Path: <netdev+bounces-116320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB97D949EBE
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 06:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7E42887C6
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 04:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635A915B987;
	Wed,  7 Aug 2024 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mqmje13i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541911C14
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 04:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723003595; cv=none; b=niWUpQ6RXCXaBvBtWFwmVhlWv71acqg2nbiz9bbgC5WmLJjGmBrIn/Is0W2E3sEdFJ7iAnKjZq3JaYBxSoKsmMoUwYCSMQiQaFGEGIODYikaNYDBZi0M7OGlkL+46EvDtmf66m86KI/SjL5pWnnXR1CBJLd8jAP4ySRgShAR0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723003595; c=relaxed/simple;
	bh=5BHWmE7LC8uikIIVqnsoGB5hTckvR2ffTVuMqwKqKxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5B438FaM6Y0M47OsBSl/Xu4Hc8L5fzOnSrdEJGLBhMzP/Cpzjk2N9cf27rKypirMwToYfKBv/FvOzjL5t6Lfw4cvBDMTFrtv9pXgyEp8mq3fvsXzIYZIsjdpjhtdIc+QfHzOfiLUf5PuHqJtM8AD8SOJY/cFAeTA8t2GRHwEgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mqmje13i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723003592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=td4F4gjXfaORibLzd0M5YM3+PUcRUcS2ctCirggREe0=;
	b=Mqmje13iFBRZAY8YLSgbf4zNMC+wGft9s4knEwouhpjRoKBbu5DMR7V7Hk1114V5NcXyya
	JRVUtHTTf5DxMFLOZ81ohpIDcTT8jSyXpUocd8QL8KMp19TvOgYaobuzj51DHTbcmisIbx
	iVX19ttAN+GvPHRi6GoDQ9EZQOm9HnU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-grP78MPgOHKoRF6UA5KMgg-1; Wed, 07 Aug 2024 00:06:29 -0400
X-MC-Unique: grP78MPgOHKoRF6UA5KMgg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb4bcd9671so1567398a91.1
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 21:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723003588; x=1723608388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=td4F4gjXfaORibLzd0M5YM3+PUcRUcS2ctCirggREe0=;
        b=ebuqMpZMQZsWxc179uenVgBwum/WF5c+E/d0d8P7fLZxDe9jgZqW8Voaicw5SDZK58
         Hk1uETUNn+eyJ/iGol/5cRTxczYxi2CsYU1mhYozO5AfXBCHpcoewEX1qwmR6CR0oQZV
         zD4mK/qS2+z58EbuElJ7klbKjoi4p2+vXfAv7pQlb0XuLQBpk9UyFtQKWJj+asxazz+P
         RHPaSDzLACUABRZRcg10pMz8lQ3ce1XzoPeHiHZKsAvEK8P6F0QagX3EjRfSeAVKUtrW
         a3RHREy5+HQPBSz0IOyvu47mLvDpSWdnQbHmw6+Umvma/k8rzVbXwfIS9UaFpj4gL/2/
         NONg==
X-Forwarded-Encrypted: i=1; AJvYcCWx2reGzJ9V2idZmZmWqtlcY/97toqjpWVUUjTCvWG4GgduZ5Nyj2fYhIE22GOkEPm34Tg7qlPiq9nXfIfXPZmcf2D5s4vk
X-Gm-Message-State: AOJu0Yytr54WoxG5nPDUSmGzXXG/1iQw+Ly4x6ANe12ByQA9m+5XqJRS
	0JLF5vjoUkUUN3s5qzK8xF/d2+jxOvKSIQhJBaAaulWv9/b45yoR3eVD34u/Mml86JKNEI5/tGA
	MOHVTLg/a6T0LmJWGsVMaKgD3HvZOsMqoS9qn70uxDqFOyvT5O6n+WYX58kMxiXuD1H3p7JEsaP
	FGcXXbVjdpqVFmPNHRKk4u/L6HUJX5
X-Received: by 2002:a17:90a:2e17:b0:2c9:81fd:4c27 with SMTP id 98e67ed59e1d1-2cff9449532mr21148416a91.14.1723003588408;
        Tue, 06 Aug 2024 21:06:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLsJLl+4r3slml/LP0NHn/iPDaMGehzge1tbFN3pKnqrI1Yl5mF96LqA5qC6PYvLnARq8qdtrwcILlUHvdIMQ=
X-Received: by 2002:a17:90a:2e17:b0:2c9:81fd:4c27 with SMTP id
 98e67ed59e1d1-2cff9449532mr21148401a91.14.1723003587944; Tue, 06 Aug 2024
 21:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801135639.11400-1-hengqi@linux.alibaba.com>
 <CACGkMEtBeUnDeD0zYBvpwjhQ4Lv0dz8mBDQ_C-yP1VEaQdv-0A@mail.gmail.com>
 <20240802090822-mutt-send-email-mst@kernel.org> <CACGkMEvPdiKS7+S5Btk+uMwtwRnPfTd6Brwz2acgBfNAnTXMFA@mail.gmail.com>
 <20240805015308-mutt-send-email-mst@kernel.org> <CACGkMEsL6fyf9ecY8_LpT5_=hHKFzW7==4DBer_w9xEpGUkRtw@mail.gmail.com>
 <20240806091923-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240806091923-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 7 Aug 2024 12:06:16 +0800
Message-ID: <CACGkMEtqozm3mr_ZhsfAY5mzTm9gT0arNs-6Avov5kX48uXsrg@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Prevent misidentified spurious
 interrupts from killing the irq
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 9:25=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Aug 06, 2024 at 11:18:14AM +0800, Jason Wang wrote:
> > On Mon, Aug 5, 2024 at 2:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Mon, Aug 05, 2024 at 11:26:56AM +0800, Jason Wang wrote:
> > > > On Fri, Aug 2, 2024 at 9:11=E2=80=AFPM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > > > >
> > > > > On Fri, Aug 02, 2024 at 11:41:57AM +0800, Jason Wang wrote:
> > > > > > On Thu, Aug 1, 2024 at 9:56=E2=80=AFPM Heng Qi <hengqi@linux.al=
ibaba.com> wrote:
> > > > > > >
> > > > > > > Michael has effectively reduced the number of spurious interr=
upts in
> > > > > > > commit a7766ef18b33 ("virtio_net: disable cb aggressively") b=
y disabling
> > > > > > > irq callbacks before cleaning old buffers.
> > > > > > >
> > > > > > > But it is still possible that the irq is killed by mistake:
> > > > > > >
> > > > > > >   When a delayed tx interrupt arrives, old buffers has been c=
leaned in
> > > > > > >   other paths (start_xmit and virtnet_poll_cleantx), then the=
 interrupt is
> > > > > > >   mistakenly identified as a spurious interrupt in vring_inte=
rrupt.
> > > > > > >
> > > > > > >   We should refrain from labeling it as a spurious interrupt;=
 otherwise,
> > > > > > >   note_interrupt may inadvertently kill the legitimate irq.
> > > > > >
> > > > > > I think the evil came from where we do free_old_xmit() in
> > > > > > start_xmit(). I know it is for performance, but we may need to =
make
> > > > > > the code work correctly instead of adding endless hacks. Person=
ally, I
> > > > > > think the virtio-net TX path is over-complicated. We probably p=
ay too
> > > > > > much (e.g there's netif_tx_lock in TX NAPI path) to try to "opt=
imize"
> > > > > > the performance.
> > > > > >
> > > > > > How about just don't do free_old_xmit and do that solely in the=
 TX NAPI?
> > > > >
> > > > > Not getting interrupts is always better than getting interrupts.
> > > >
> > > > Not sure. For example letting 1 cpu to do the transmission without =
the
> > > > dealing of xmit skbs should give us better performance.
> > >
> > > Hmm. It's a subtle thing. I suspect until certain limit
> > > (e.g. ping pong test) free_old_xmit will win anyway.
> >
> > Not sure I understand here.
>
> If you transmit 1 packet and then wait for another one anyway,
> you are better off just handling the tx interrupt.

Yes for light load but not for heavy load like pktgen and others probably.

>
>
> > >
> > > > > This is not new code, there are no plans to erase it all and star=
t
> > > > > anew "to make it work correctly" - it's widely deployed,
> > > > > you will cause performance regressions and they are hard
> > > > > to debug.
> > > >
> > > > I actually meant the TX NAPI mode, we tried to hold the TX lock in =
the
> > > > TX NAPI, which turns out to slow down both the transmission and the
> > > > NAPI itself.
> > > >
> > > > Thanks
> > >
> > > We do need to synchronize anyway though, virtio expects drivers to do
> > > their own serialization of vq operations.
> >
> > Right, but currently add and get needs to be serialized which is a
> > bottleneck. I don't see any issue to parallelize that.
>
> Do you see this in traces?

I mean current virtio_core requires the caller to serialize add/get:

virtqueue_add() {
START_USE()
END_USE()
}

virtqueue_get() {
START_USE()
END_USE()
}

It seems to be a limitation of the current driver not the spec itself
which means we can find some way to allow those to be executed in
parallel.

One example is to use ptr_ring to maintain a free id list or it is not
even needed in the case of in order.

>
> > > You could try to instead move
> > > skbs to some kind of array under the tx lock, then free them all up
> > > later after unlocking tx.
> > >
> > > Can be helpful for batching as well?
> >
> > It's worth a try and see.
>
> Why not.
>
> > >
> > >
> > > I also always wondered whether it is an issue that free_old_xmit
> > > just polls vq until it is empty, without a limit.
> >
> > Did you mean schedule a NAPI if free_old_xmit() exceeds the NAPI quota?
>
> yes
>
> > > napi is supposed to poll until a limit is reached.
> > > I guess not many people have very deep vqs.
> >
> > Current NAPI weight is 64, so I think we can meet it in stressful workl=
oad.
> >
> > Thanks
>
> yes, but it's just a random number.  since we hold the tx lock,
> we get at most vq size bufs, so it's limited.

Ok.

Thanks

>
> > >
> > > --
> > > MST
> > >
>


