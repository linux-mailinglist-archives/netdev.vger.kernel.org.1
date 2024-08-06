Return-Path: <netdev+bounces-116093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8A794913B
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D7F1C23623
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE60E1D1F46;
	Tue,  6 Aug 2024 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atmaUxUE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7171D1734
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950701; cv=none; b=Rp6HQdQxzExeu77quIltDc+OCTRU8OA+0wxQMOMC8qYmjRDZoo9bPZbYymdGDP9w8IGg+GsMNj4QbMtKaAqWz3zQeOrbgTfERBiF/h3gM2TSS+5Yy+YXGEM5Tm4i2vokDdM07rFqf2f392l9pbv6T07TMvfBKzGl8qFdJ4YNIdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950701; c=relaxed/simple;
	bh=obls5/IgJLkBnpI0rNRP8IYmmKd6T44gBryyeBO291c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ir85WY0XjoJYVk8tq3TBpCDLLbbFqoljLB48cAj+y+q7yS4kZKmLuQIn6k7OqnLCrMlqUqvXRTW1RerWtm6gLpJOT88O3j3hwylalQhuj2f1Ogig49AOUx6cmkjNH386Zv6UEN1w1W4R88U/fQG5KEYYMPD7LxwbJZFq1/PUyiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=atmaUxUE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722950699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=agmgz/g9lzLW/r/AK60PBJWPhqm4LcY7bcQWWV6msjw=;
	b=atmaUxUEIIJuvbBhKECQIgU37u0VxLCKYxYFzSK/0hSRGS8kyLZrjnMBzh0wql0FKXmd3x
	kxsSfvMjxOr4RNJi3AlhF0vsCgUf6ljzi3jQ+bA8OCxH0MA3rX2NaNFUSDqjsEHoZu8xoq
	XnUKLIYL3Jm2H+V4R2sVnYSrdjdg9pY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-XLT0r1Z_OoyD21ymdCW5-A-1; Tue, 06 Aug 2024 09:24:57 -0400
X-MC-Unique: XLT0r1Z_OoyD21ymdCW5-A-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef23b417bcso7484871fa.0
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 06:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950695; x=1723555495;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=agmgz/g9lzLW/r/AK60PBJWPhqm4LcY7bcQWWV6msjw=;
        b=S4PVsZdyrDZzliW5lN4QdD3j96MR8H8uAEm1wiTfSMkcV7FP2yPb48vqkV3hDzQa2H
         nP7ZgwYKGE5XPEsBcxFbM5f64+qJTc8D2PcT8lCmOl6ek9EtJIug03/kx2GJrnS4GWe+
         B81ldOmrwWO9DSCwEhHQcgQDSsdn5dtziOnzsJ7bMe9g2bq6a3cDpMI5kyX7HKJX6zO6
         PBP7jQ0FhglwtC0hHFCecVNrmwgy5bj7vEpkBVvZdSfX/GZyK1NamUQjvp+ujE0rULbf
         cdv5mMoQqVFm2X3MO3mjUaq9zoe6/YC/6pBXHUEcwxHWNWB2kGn3KEh6kw3x33yCqFTR
         jhKA==
X-Forwarded-Encrypted: i=1; AJvYcCUO697jKox8g3BZKG0qgM1tVMhGT0t9AQacj3zLrNz+1pPBn+/TSb5UhIJH1yhqJ2heZGRKKJ4iK4mqsyqdyi9Yd+gljOH9
X-Gm-Message-State: AOJu0YwlRFzFO25aQtZC4xtsSjXvLlEteqH2SbPVtGb5Ifkm+KWyZKjR
	1HKTBAG/jhSI7d7EKI03Ik/WHYPDjU6vVX92aFhxRoCCPoRtkGvb1RaJWrqZu7w6dRCF8Tf+xn5
	7uORQXbRzC215litmnQS8ppVW31YDxKCxqlECqxlUYwu+UVC03TqWfw==
X-Received: by 2002:a2e:8515:0:b0:2ef:2cdb:5053 with SMTP id 38308e7fff4ca-2f15aafdb02mr99183071fa.37.1722950695466;
        Tue, 06 Aug 2024 06:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0K+acf4m4pFDrvN4mHJ+0yCLE9V9JfbfpalO3TIOCh61979EdH8ikEP6MLMjXlMuiamw1uA==
X-Received: by 2002:a2e:8515:0:b0:2ef:2cdb:5053 with SMTP id 38308e7fff4ca-2f15aafdb02mr99182711fa.37.1722950694440;
        Tue, 06 Aug 2024 06:24:54 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:c9eb:d9d4:606a:87dc:59c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb98109sm240561445e9.39.2024.08.06.06.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:24:53 -0700 (PDT)
Date: Tue, 6 Aug 2024 09:24:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] virtio_net: Prevent misidentified spurious
 interrupts from killing the irq
Message-ID: <20240806091923-mutt-send-email-mst@kernel.org>
References: <20240801135639.11400-1-hengqi@linux.alibaba.com>
 <CACGkMEtBeUnDeD0zYBvpwjhQ4Lv0dz8mBDQ_C-yP1VEaQdv-0A@mail.gmail.com>
 <20240802090822-mutt-send-email-mst@kernel.org>
 <CACGkMEvPdiKS7+S5Btk+uMwtwRnPfTd6Brwz2acgBfNAnTXMFA@mail.gmail.com>
 <20240805015308-mutt-send-email-mst@kernel.org>
 <CACGkMEsL6fyf9ecY8_LpT5_=hHKFzW7==4DBer_w9xEpGUkRtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsL6fyf9ecY8_LpT5_=hHKFzW7==4DBer_w9xEpGUkRtw@mail.gmail.com>

On Tue, Aug 06, 2024 at 11:18:14AM +0800, Jason Wang wrote:
> On Mon, Aug 5, 2024 at 2:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Aug 05, 2024 at 11:26:56AM +0800, Jason Wang wrote:
> > > On Fri, Aug 2, 2024 at 9:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Fri, Aug 02, 2024 at 11:41:57AM +0800, Jason Wang wrote:
> > > > > On Thu, Aug 1, 2024 at 9:56 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > > > > >
> > > > > > Michael has effectively reduced the number of spurious interrupts in
> > > > > > commit a7766ef18b33 ("virtio_net: disable cb aggressively") by disabling
> > > > > > irq callbacks before cleaning old buffers.
> > > > > >
> > > > > > But it is still possible that the irq is killed by mistake:
> > > > > >
> > > > > >   When a delayed tx interrupt arrives, old buffers has been cleaned in
> > > > > >   other paths (start_xmit and virtnet_poll_cleantx), then the interrupt is
> > > > > >   mistakenly identified as a spurious interrupt in vring_interrupt.
> > > > > >
> > > > > >   We should refrain from labeling it as a spurious interrupt; otherwise,
> > > > > >   note_interrupt may inadvertently kill the legitimate irq.
> > > > >
> > > > > I think the evil came from where we do free_old_xmit() in
> > > > > start_xmit(). I know it is for performance, but we may need to make
> > > > > the code work correctly instead of adding endless hacks. Personally, I
> > > > > think the virtio-net TX path is over-complicated. We probably pay too
> > > > > much (e.g there's netif_tx_lock in TX NAPI path) to try to "optimize"
> > > > > the performance.
> > > > >
> > > > > How about just don't do free_old_xmit and do that solely in the TX NAPI?
> > > >
> > > > Not getting interrupts is always better than getting interrupts.
> > >
> > > Not sure. For example letting 1 cpu to do the transmission without the
> > > dealing of xmit skbs should give us better performance.
> >
> > Hmm. It's a subtle thing. I suspect until certain limit
> > (e.g. ping pong test) free_old_xmit will win anyway.
> 
> Not sure I understand here.

If you transmit 1 packet and then wait for another one anyway,
you are better off just handling the tx interrupt.


> >
> > > > This is not new code, there are no plans to erase it all and start
> > > > anew "to make it work correctly" - it's widely deployed,
> > > > you will cause performance regressions and they are hard
> > > > to debug.
> > >
> > > I actually meant the TX NAPI mode, we tried to hold the TX lock in the
> > > TX NAPI, which turns out to slow down both the transmission and the
> > > NAPI itself.
> > >
> > > Thanks
> >
> > We do need to synchronize anyway though, virtio expects drivers to do
> > their own serialization of vq operations.
> 
> Right, but currently add and get needs to be serialized which is a
> bottleneck. I don't see any issue to parallelize that.

Do you see this in traces?

> > You could try to instead move
> > skbs to some kind of array under the tx lock, then free them all up
> > later after unlocking tx.
> >
> > Can be helpful for batching as well?
> 
> It's worth a try and see.

Why not.

> >
> >
> > I also always wondered whether it is an issue that free_old_xmit
> > just polls vq until it is empty, without a limit.
> 
> Did you mean schedule a NAPI if free_old_xmit() exceeds the NAPI quota?

yes

> > napi is supposed to poll until a limit is reached.
> > I guess not many people have very deep vqs.
> 
> Current NAPI weight is 64, so I think we can meet it in stressful workload.
> 
> Thanks

yes, but it's just a random number.  since we hold the tx lock,
we get at most vq size bufs, so it's limited.

> >
> > --
> > MST
> >


