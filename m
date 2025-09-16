Return-Path: <netdev+bounces-223379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5ABB58EC7
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7569C1B255A9
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 07:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A882E3B11;
	Tue, 16 Sep 2025 07:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGsWqvTQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298C02E3AEA
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758006484; cv=none; b=g/lRGb60imxFSx830Di8zNdH0dOrWhrJD66KPthzydtI0gKwylIcN/7s/2wMiZrA3wcF9MG3tFOgG6st66a4cRcJTJoHTX1r9Nz796Btht8G0ID88DBTAjz6IyJIBnAVilSqsjxrT72fxgJ6Uh1lhRtDfYVh1s5JmcJ+JYKUhLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758006484; c=relaxed/simple;
	bh=yQKLpG7rL3c3VSnaKMz320BDbIw/zC1Hrox8B/emiEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4ZWgAcG6b8KuxO+q/ZOPiRgCneVr34ajtEUzHSjlN/7xQhnFGZDXPcb81c80wDbAbnXQd0Mw2wlB2nUVJkN629dEOW+H+rAx7luyWl/aJzUgTkGQA4NFFI1cyEcX3didfKxNwBqKzo0waUPEmnqyUmV+SupYBywdpC40FfQUC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KGsWqvTQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758006482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHDgI0DNgcZtkaITzjCOU1skgj0FzLZyOLaS/H3q/YM=;
	b=KGsWqvTQfGV3F/ynLysEAnAjdv1ogw1rljOtmTeg4YmLFNDQ1ZLIOArQ+zpRKqz8txqlLO
	m/hor7LRqBYKCnOxQ2wZ/JIInrUTC0m0zi6xkTmXpcahvtE6N697GDAvijJdFPld5+uVpk
	n35kVygI3MtRHPe846aNhTtaLiyOuNA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-Gn2o7phvNVuiIre7NskHOQ-1; Tue, 16 Sep 2025 03:08:00 -0400
X-MC-Unique: Gn2o7phvNVuiIre7NskHOQ-1
X-Mimecast-MFC-AGG-ID: Gn2o7phvNVuiIre7NskHOQ_1758006479
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b07c9056963so554534066b.2
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 00:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758006479; x=1758611279;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHDgI0DNgcZtkaITzjCOU1skgj0FzLZyOLaS/H3q/YM=;
        b=UJB5PS26L6k5Wa6Yx3m9zNZrOd4Wxdjjh3GXQNpJUgvNUuDqoNQpZa2juINxcgZNAV
         WVfeK8BzGDwWhlkP+0uINMpgCfmqRSxc7m+smA672xS6PguF2l4AoPhUHSStQva6SwRj
         xBPIRuIgU2QdPFgLyjOn/QABMBZKc7Pv5qUBUVR3xQ+93UAnN0Ea9HiCjvh06I/J07cI
         oQPbtsYh+xVpiL5LTdAtfkkArGU69dxuVwk5PuBG/arow0Ys/tilQmy5qidQxhAMpNMr
         FG+YjdgIkwaNy+/S3U4sMOggXUO+oDHEEy0poiMyPSCEgwHDjwJ1u8bQ62qkVgFOfLfc
         yLKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqgPa0Iu5m2hb3hJdb+jhlNmvZBOQjLnZ8b8tYaCQoQoxkz/BkE7KIp81+9D5CRNftYeqx894=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoePUtQzdG56zoNnK4QwZJGy1+AINVpJn0aW3khOmPMVKAOl8L
	+Vf3AeBaUHhg6n9KEno/T5LtxiOMdyyKLzh8Gwa53/nIciaXXOIPi9mYSK5d/bFihD8VxqqI7nb
	1fF5VfO0BOgSkPOE39nWKf0HYp5tk4EcCLA/hDXgFkEs8jwMaeItiDtx+eQ==
X-Gm-Gg: ASbGncshO1tAzqeNbx0fQIqmCprV2pY0ypgumqdc922n+a7/GPdqg+i4CQ5s/JLQ1Vw
	HvzInJI8l13/et2zB1IyRGYZoCfMO9QdjCtCW6jg7YDPgy2/YhbOJd6O1p6rnKk7RDKHX8E/zlD
	uCj+jCKcDP4D16zKpCP5lFswfjsRTPTYdxU1nOVtoOPRMSXsLKXIS9rp9GymF3mdC6m3YZ9m3L4
	SJO9wziPdtDnV7+/zJPgdTZz5Js4pJHj9d+UyKIvgr5d4u5KVpcJZ+XAx+ADCfglAdaNKJRysmO
	c5I02PkJA3oik0VFNrhtnnO/YXtI
X-Received: by 2002:a17:906:478c:b0:b04:2533:e8dd with SMTP id a640c23a62f3a-b07c3a8c7a9mr1512270866b.60.1758006479207;
        Tue, 16 Sep 2025 00:07:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgIdN7vt4rVLkFQKCbA4fzr7ooEwlspblCquvU3nA4jyYYJdxii6DXBn74W0DSzmPxUER9Fg==
X-Received: by 2002:a17:906:478c:b0:b04:2533:e8dd with SMTP id a640c23a62f3a-b07c3a8c7a9mr1512266566b.60.1758006478595;
        Tue, 16 Sep 2025 00:07:58 -0700 (PDT)
Received: from redhat.com ([31.187.78.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f22b1sm1106591366b.86.2025.09.16.00.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 00:07:57 -0700 (PDT)
Date: Tue, 16 Sep 2025 03:07:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] vhost-net: correctly flush batched packet before
 enabling notification
Message-ID: <20250916030549-mutt-send-email-mst@kernel.org>
References: <20250912082658.2262-1-jasowang@redhat.com>
 <20250912082658.2262-2-jasowang@redhat.com>
 <20250915120210-mutt-send-email-mst@kernel.org>
 <CACGkMEufUAL1tBrfZVMQCEBmBZ=Z+aPqUtP=RzOQhjtG9jn7UA@mail.gmail.com>
 <20250916011733-mutt-send-email-mst@kernel.org>
 <CACGkMEu_p-ouLbEq26vMTJmeGs1hw5JHOk1qLt8mLLPOMLDbaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEu_p-ouLbEq26vMTJmeGs1hw5JHOk1qLt8mLLPOMLDbaQ@mail.gmail.com>

On Tue, Sep 16, 2025 at 02:24:22PM +0800, Jason Wang wrote:
> On Tue, Sep 16, 2025 at 1:19 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Sep 16, 2025 at 10:37:35AM +0800, Jason Wang wrote:
> > > On Tue, Sep 16, 2025 at 12:03 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Fri, Sep 12, 2025 at 04:26:58PM +0800, Jason Wang wrote:
> > > > > Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> > > > > sendmsg") tries to defer the notification enabling by moving the logic
> > > > > out of the loop after the vhost_tx_batch() when nothing new is
> > > > > spotted. This will bring side effects as the new logic would be reused
> > > > > for several other error conditions.
> > > > >
> > > > > One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> > > > > might return -EAGAIN and exit the loop and see there's still available
> > > > > buffers, so it will queue the tx work again until userspace feed the
> > > > > IOTLB entry correctly. This will slowdown the tx processing and may
> > > > > trigger the TX watchdog in the guest.
> > > > >
> > > > > Fixing this by stick the notificaiton enabling logic inside the loop
> > > > > when nothing new is spotted and flush the batched before.
> > > > >
> > > > > Reported-by: Jon Kohler <jon@nutanix.com>
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > >  drivers/vhost/net.c | 33 +++++++++++++--------------------
> > > > >  1 file changed, 13 insertions(+), 20 deletions(-)
> > > > >
> > > > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > > > index 16e39f3ab956..3611b7537932 100644
> > > > > --- a/drivers/vhost/net.c
> > > > > +++ b/drivers/vhost/net.c
> > > > > @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > > > >       int err;
> > > > >       int sent_pkts = 0;
> > > > >       bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
> > > > > -     bool busyloop_intr;
> > > > >       bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
> > > > >
> > > > >       do {
> > > > > -             busyloop_intr = false;
> > > > > +             bool busyloop_intr = false;
> > > > > +
> > > > >               if (nvq->done_idx == VHOST_NET_BATCH)
> > > > >                       vhost_tx_batch(net, nvq, sock, &msg);
> > > > >
> > > > > @@ -780,10 +780,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > > > >                       break;
> > > > >               /* Nothing new?  Wait for eventfd to tell us they refilled. */
> > > > >               if (head == vq->num) {
> > > > > -                     /* Kicks are disabled at this point, break loop and
> > > > > -                      * process any remaining batched packets. Queue will
> > > > > -                      * be re-enabled afterwards.
> > > > > +                     /* Flush batched packets before enabling
> > > > > +                      * virqtueue notification to reduce
> > > > > +                      * unnecssary virtqueue kicks.
> > > > >                        */
> > > > > +                     vhost_tx_batch(net, nvq, sock, &msg);
> > > >
> > > > So why don't we do this in the "else" branch"? If we are busy polling
> > > > then we are not enabling kicks, so is there a reason to flush?
> > >
> > > It should be functional equivalent:
> > >
> > > do {
> > >     if (head == vq->num) {
> > >         vhost_tx_batch();
> > >         if (unlikely(busyloop_intr)) {
> > >             vhost_poll_queue()
> > >         } else if () {
> > >             vhost_disable_notify(&net->dev, vq);
> > >             continue;
> > >         }
> > >         return;
> > > }
> > >
> > > vs
> > >
> > > do {
> > >     if (head == vq->num) {
> > >         if (unlikely(busyloop_intr)) {
> > >             vhost_poll_queue()
> > >         } else if () {
> > >             vhost_tx_batch();
> > >             vhost_disable_notify(&net->dev, vq);
> > >             continue;
> > >         }
> > >         break;
> > > }
> > >
> > > vhost_tx_batch();
> > > return;
> > >
> > > Thanks
> > >
> >
> > But this is not what the code comment says:
> >
> >                      /* Flush batched packets before enabling
> >                       * virqtueue notification to reduce
> >                       * unnecssary virtqueue kicks.
> >
> >
> > So I ask - of we queued more polling, why do we need
> > to flush batched packets? We might get more in the next
> > polling round, this is what polling is designed to do.
> 
> The reason is there could be a rx work when busyloop_intr is true, so
> we need to flush.
> 
> Thanks

Then you need to update the comment to explain.
Want to post your version of this patchset?


> >
> >
> > >
> > > >
> > > >
> > > > > +                     if (unlikely(busyloop_intr)) {
> > > > > +                             vhost_poll_queue(&vq->poll);
> > > > > +                     } else if (unlikely(vhost_enable_notify(&net->dev,
> > > > > +                                                             vq))) {
> > > > > +                             vhost_disable_notify(&net->dev, vq);
> > > > > +                             continue;
> > > > > +                     }
> > > > >                       break;
> > > > >               }
> > > > >
> > > > > @@ -839,22 +847,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
> > > > >               ++nvq->done_idx;
> > > > >       } while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
> > > > >
> > > > > -     /* Kicks are still disabled, dispatch any remaining batched msgs. */
> > > > >       vhost_tx_batch(net, nvq, sock, &msg);
> > > > > -
> > > > > -     if (unlikely(busyloop_intr))
> > > > > -             /* If interrupted while doing busy polling, requeue the
> > > > > -              * handler to be fair handle_rx as well as other tasks
> > > > > -              * waiting on cpu.
> > > > > -              */
> > > > > -             vhost_poll_queue(&vq->poll);
> > > > > -     else
> > > > > -             /* All of our work has been completed; however, before
> > > > > -              * leaving the TX handler, do one last check for work,
> > > > > -              * and requeue handler if necessary. If there is no work,
> > > > > -              * queue will be reenabled.
> > > > > -              */
> > > > > -             vhost_net_busy_poll_try_queue(net, vq);
> > > > >  }
> > > > >
> > > > >  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> > > > > --
> > > > > 2.34.1
> > > >
> >


