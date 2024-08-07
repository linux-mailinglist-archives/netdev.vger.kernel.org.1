Return-Path: <netdev+bounces-116417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0549294A5B4
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 12:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D511F214B8
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 10:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFF11DD3B2;
	Wed,  7 Aug 2024 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAfqDgKD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3151D1735
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 10:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027059; cv=none; b=TTH3DM3grCPZk15mp3PGtHIetLWeC73bqnUh89cMMS+qQr2AcrAnZEMzEVd71RlJKDoKwGnShAjttZYogFJ6DNWA2u/jMy/eBhyN758bCQqsaU/B2sA7cgjo4VGBGots4yWPWeywoPEQ0vdEyqZD9GIs+x6UQi/svds5q+ixyQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027059; c=relaxed/simple;
	bh=tHIdKJ9/2g6eLi0PbsowF+c9HQrSKeYZc5eZtWagxoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqlNesj1z1QAG0P8DBK1uOws67NwdjT/J5m7nGw5T5BBfcxwMktwsgRx3aDbvdQGo/9m1Iwzl+WB7X7v70o0bbVCwNLZZE0CmmG/VZaoyavLC5egNcWfvsJYFKxjw4xH1ruRrkzrLtb4yyUDo6ZlMDZCLAnumiomSOi0uMFvsh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAfqDgKD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723027056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8CWmQQ3yosgUrgcvdLHqihMq2yPNE+VPpMUfRPidMc=;
	b=FAfqDgKDHx6zGbG1QpXbudWkRASC85bZi75uGgYBD2aiGdeG3KoxtmZ0iyMLnoD5mZhXva
	zSrBcj3u3KlG6oge+mesi6yQOZXSgYRO7RJXTfmfVhQxFyu+I0CdJl18f0/grVu/GonMDK
	BDt1og5baE5udK1f5s+HJMrMxAnXjmQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-98s09mkFN4GTg26YmVNckA-1; Wed, 07 Aug 2024 06:37:35 -0400
X-MC-Unique: 98s09mkFN4GTg26YmVNckA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6886cd07673so40228737b3.3
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 03:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723027054; x=1723631854;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H8CWmQQ3yosgUrgcvdLHqihMq2yPNE+VPpMUfRPidMc=;
        b=ZsY+zVRdDo/lK81xeXWgokThDD4DslYYCDBoAsI89bX2iHui3SBDIYB1TfV2t0m3ob
         IBFqjrwXI7cxaQJ4DUwoQx8lulXt9mXP3c4xUIuMxCWAMZnjWmgCA4r3uyj3XGkJBDSa
         c3ukKloqoSWwKvBSexf8HxWA/MoXYuYWz5jD49uQVh8Ydi4mvTLXNJD9iAqVslJJVOZ9
         V4NsAurJMhGHbUBr+cZYtykZv40C3fhcOpJ2Wd/HRyLCtr5fjdxLrX4t3xhBUcdQvDXY
         x0VJ2NHofGwSqa7H4gvWArSMB7o8vxOJRSaNxM7M7Ymnyhy0MV+hsPxELjNQVM9pHeKw
         Mcow==
X-Forwarded-Encrypted: i=1; AJvYcCUDqboklFkGoaOHqUNdaAjcD9OTjQccb/yEx8IoxDwTWYBhzLzExmxYM5ASGVCulXZSU78eeT0XbgkzcAcl/eqrzlXJScm0
X-Gm-Message-State: AOJu0Yze2KUvAV0+uVleE9HD7HP2/EpKxr3iUnO6vBCRQvet++wRCHYp
	pSTsT+jV+HUjuSgKYzSJrp131UhwhLY2Akm0XQk2P9KgYZQz5ufILSzXxvZPaPGDE7Gm7gkmRht
	n5tRFg/RcSB1xy2yI8W8GBclU7UomrOfSFadeMKBwxlHzVEQUqFLHkg==
X-Received: by 2002:a05:6902:c0c:b0:e0b:c402:b03c with SMTP id 3f1490d57ef6-e0bde420b3fmr23576596276.40.1723027054400;
        Wed, 07 Aug 2024 03:37:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUADZGRyzfb4vcKdcX6Brahh39/+6ykSHtS/Kj1zvry7N8FCLYc+awqg2ckZkAIy/nBQS7bg==
X-Received: by 2002:a05:6902:c0c:b0:e0b:c402:b03c with SMTP id 3f1490d57ef6-e0bde420b3fmr23576557276.40.1723027053847;
        Wed, 07 Aug 2024 03:37:33 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:efe1:812e:e83a:2c34:ce60])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c87f70ccsm3740631cf.93.2024.08.07.03.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 03:37:33 -0700 (PDT)
Date: Wed, 7 Aug 2024 06:37:26 -0400
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
Message-ID: <20240807063041-mutt-send-email-mst@kernel.org>
References: <20240801135639.11400-1-hengqi@linux.alibaba.com>
 <CACGkMEtBeUnDeD0zYBvpwjhQ4Lv0dz8mBDQ_C-yP1VEaQdv-0A@mail.gmail.com>
 <20240802090822-mutt-send-email-mst@kernel.org>
 <CACGkMEvPdiKS7+S5Btk+uMwtwRnPfTd6Brwz2acgBfNAnTXMFA@mail.gmail.com>
 <20240805015308-mutt-send-email-mst@kernel.org>
 <CACGkMEsL6fyf9ecY8_LpT5_=hHKFzW7==4DBer_w9xEpGUkRtw@mail.gmail.com>
 <20240806091923-mutt-send-email-mst@kernel.org>
 <CACGkMEtqozm3mr_ZhsfAY5mzTm9gT0arNs-6Avov5kX48uXsrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtqozm3mr_ZhsfAY5mzTm9gT0arNs-6Avov5kX48uXsrg@mail.gmail.com>

On Wed, Aug 07, 2024 at 12:06:16PM +0800, Jason Wang wrote:
> On Tue, Aug 6, 2024 at 9:25 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Aug 06, 2024 at 11:18:14AM +0800, Jason Wang wrote:
> > > On Mon, Aug 5, 2024 at 2:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Mon, Aug 05, 2024 at 11:26:56AM +0800, Jason Wang wrote:
> > > > > On Fri, Aug 2, 2024 at 9:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Aug 02, 2024 at 11:41:57AM +0800, Jason Wang wrote:
> > > > > > > On Thu, Aug 1, 2024 at 9:56 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > Michael has effectively reduced the number of spurious interrupts in
> > > > > > > > commit a7766ef18b33 ("virtio_net: disable cb aggressively") by disabling
> > > > > > > > irq callbacks before cleaning old buffers.
> > > > > > > >
> > > > > > > > But it is still possible that the irq is killed by mistake:
> > > > > > > >
> > > > > > > >   When a delayed tx interrupt arrives, old buffers has been cleaned in
> > > > > > > >   other paths (start_xmit and virtnet_poll_cleantx), then the interrupt is
> > > > > > > >   mistakenly identified as a spurious interrupt in vring_interrupt.
> > > > > > > >
> > > > > > > >   We should refrain from labeling it as a spurious interrupt; otherwise,
> > > > > > > >   note_interrupt may inadvertently kill the legitimate irq.
> > > > > > >
> > > > > > > I think the evil came from where we do free_old_xmit() in
> > > > > > > start_xmit(). I know it is for performance, but we may need to make
> > > > > > > the code work correctly instead of adding endless hacks. Personally, I
> > > > > > > think the virtio-net TX path is over-complicated. We probably pay too
> > > > > > > much (e.g there's netif_tx_lock in TX NAPI path) to try to "optimize"
> > > > > > > the performance.
> > > > > > >
> > > > > > > How about just don't do free_old_xmit and do that solely in the TX NAPI?
> > > > > >
> > > > > > Not getting interrupts is always better than getting interrupts.
> > > > >
> > > > > Not sure. For example letting 1 cpu to do the transmission without the
> > > > > dealing of xmit skbs should give us better performance.
> > > >
> > > > Hmm. It's a subtle thing. I suspect until certain limit
> > > > (e.g. ping pong test) free_old_xmit will win anyway.
> > >
> > > Not sure I understand here.
> >
> > If you transmit 1 packet and then wait for another one anyway,
> > you are better off just handling the tx interrupt.
> 
> Yes for light load but not for heavy load like pktgen and others probably.

If you are extermely busy sending packets, and you don't really care
when they are freed, and the vq is deep
and you have another, idle CPU, and sending interrupt does not need
a vmexit - moving work out at the cost of an interrupt will be a win.


> >
> >
> > > >
> > > > > > This is not new code, there are no plans to erase it all and start
> > > > > > anew "to make it work correctly" - it's widely deployed,
> > > > > > you will cause performance regressions and they are hard
> > > > > > to debug.
> > > > >
> > > > > I actually meant the TX NAPI mode, we tried to hold the TX lock in the
> > > > > TX NAPI, which turns out to slow down both the transmission and the
> > > > > NAPI itself.
> > > > >
> > > > > Thanks
> > > >
> > > > We do need to synchronize anyway though, virtio expects drivers to do
> > > > their own serialization of vq operations.
> > >
> > > Right, but currently add and get needs to be serialized which is a
> > > bottleneck. I don't see any issue to parallelize that.
> >
> > Do you see this in traces?
> 
> I mean current virtio_core requires the caller to serialize add/get:
> 
> virtqueue_add() {
> START_USE()
> END_USE()
> }
> 
> virtqueue_get() {
> START_USE()
> END_USE()
> }
> 
> It seems to be a limitation of the current driver not the spec itself
> which means we can find some way to allow those to be executed in
> parallel.
> 
> One example is to use ptr_ring to maintain a free id list or it is not
> even needed in the case of in order.

All quite tricky.

But again - do you have traces showing contention on tx lock?

Until we do, it's pointless to try and optimize: make changes to
code, see if performance changes - is not a good way to do this,
the system is too chaotic for that.


> >
> > > > You could try to instead move
> > > > skbs to some kind of array under the tx lock, then free them all up
> > > > later after unlocking tx.
> > > >
> > > > Can be helpful for batching as well?
> > >
> > > It's worth a try and see.
> >
> > Why not.
> >
> > > >
> > > >
> > > > I also always wondered whether it is an issue that free_old_xmit
> > > > just polls vq until it is empty, without a limit.
> > >
> > > Did you mean schedule a NAPI if free_old_xmit() exceeds the NAPI quota?
> >
> > yes
> >
> > > > napi is supposed to poll until a limit is reached.
> > > > I guess not many people have very deep vqs.
> > >
> > > Current NAPI weight is 64, so I think we can meet it in stressful workload.
> > >
> > > Thanks
> >
> > yes, but it's just a random number.  since we hold the tx lock,
> > we get at most vq size bufs, so it's limited.
> 
> Ok.
> 
> Thanks
> 
> >
> > > >
> > > > --
> > > > MST
> > > >
> >


