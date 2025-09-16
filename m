Return-Path: <netdev+bounces-223371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E55B5B58E74
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48F23BAEDF
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 06:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95431E7C11;
	Tue, 16 Sep 2025 06:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/GDSS7L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37E72848A8
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758003886; cv=none; b=THrRS7pVX+uGbGOpNmrLQEESDcS+XTqTCtiGdoN8wzTKXJUhpirgG1/5w4UuwnH8LxIbWUOZixbOduOT+PoL0s1bqcVb8V3HNZDfzWKrqL/W4r2JpbTdAUFmrPJaad/OEx1RWqJltBpIzCymWT0bRkaU6CjcEzGkZ1zXRRrINqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758003886; c=relaxed/simple;
	bh=huKYgVyJW4FB240PvQMLWp06kAelPCsGdj3ntdrQhJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hff3jTiXD7k1lbOOW12yzaPzPKkJu/qhJjlmsNYWbUKgpb841iac4fzNZodT+O2bSf22/IBfK0wqHf6FTW5w7qhl69qjT/zUJ6M1uX6erJAGrMDyeKM4jpXptUwnj5ISQQkLQY2Xd34zm4QigXaR+6z0By9aZJtDLhrgz0cvEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/GDSS7L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758003884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dlQN4SQLxZ6U3+89gIilu0VdL6Q8/3iQQAj8V3mQl2E=;
	b=Z/GDSS7L69VQ9bQPLdn4K+ag/70hHwUxbZtl1/MO17GYQkwvAOt9ge9V5TRdyhhWnSQDzh
	CJgWtKkjEzDiNNOWW5Y16oPlGBd0j0+4thJ0+09h08F/c8nPm1ksIXddpHfzU7hbzUB+90
	oJsqI0kyMWNag9+1QP1Rluh4zrXYOUU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-dW1tnKMfN76UdlT2KcoZGA-1; Tue, 16 Sep 2025 02:24:39 -0400
X-MC-Unique: dW1tnKMfN76UdlT2KcoZGA-1
X-Mimecast-MFC-AGG-ID: dW1tnKMfN76UdlT2KcoZGA_1758003874
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32e43b0f038so1575956a91.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 23:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758003874; x=1758608674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlQN4SQLxZ6U3+89gIilu0VdL6Q8/3iQQAj8V3mQl2E=;
        b=h9Dthtj2n37QPmZZtzEC+mtEiiPbJC8296M1d09wFqkT2yVAo8k3dX8x+LBSuGURoI
         Q8D9EAePA1oWahZDk0EU4T/0Jz/aXDCb4H8us19xIiWQbxVewmn8jSp8/JUimT/kCq/i
         4RaEBsgPq2fXMwcMkV6N72s/akma/NrPpx5VXb6BmvxBZfjpi6oP/v2TTr6vrKWUOIQN
         YggTZZGxFw4TTk5M+eU5QwkQKzFgcrc4mn+HLBUSyQNh6L+lUJHYorzsRhYdRSiE6w4Q
         ERZH10PQbMkJcJOB/iIm3JECsLFnmc3ZUS0RzgUM8QQPJpNuL+7SwJ6SrpxlwCqb3IgH
         MthA==
X-Forwarded-Encrypted: i=1; AJvYcCWxL3C+JVSoHmJckqDhmTLSIuVUxyT7jPJqjtq8FjgX7o+pKGjoOFLmGkUT6CYDX0jYAGEiT3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzde1rIG0ChF94u1oU+I8fFkt+5D+O/ZiX8dqVYcJN+JgpR787b
	zN+4271jyKungVnda+jM9kb/KbNpJ6NJz5R0dXYGlIMGw0Z36zKuLJVzmYTUBMWipW1uVw/oGm9
	A1gJLP41JDNpaI46QEfzO65qIYg5R3ulm3ngh2ND+QsLrXl2wxwXn/JddGqKARF+zJbhJSfCg0i
	wb2LqbAL2Ynupm31fSOVw/27dlSW3IZEzDpaJyof++tHzR4w==
X-Gm-Gg: ASbGncsY4BOSeo9o4duaXJnfX/TA7fA43uBwCu4jPg3LtVNE1SB4a1aXDmW0aZm9SyY
	47ttX7Mm83vEiPFgV4pSzmYgG4bHrNWbXyvTMeLfmADrtESpw/KdMgYmDu9sufWtQuORjZh5cxT
	7MJpnT/a+p6906EbUeRQT1ug==
X-Received: by 2002:a17:90b:2648:b0:32d:ea1c:a4e5 with SMTP id 98e67ed59e1d1-32dea1ca751mr15264752a91.1.1758003873960;
        Mon, 15 Sep 2025 23:24:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1pLFeOzviQ4Xy/lHgZpWGGPzFdvtokwot9P7w4EynJ3kpRhRB6zmkC7K48b57/V9M7J8hnwn7YZsltep2S8A=
X-Received: by 2002:a17:90b:2648:b0:32d:ea1c:a4e5 with SMTP id
 98e67ed59e1d1-32dea1ca751mr15264722a91.1.1758003873504; Mon, 15 Sep 2025
 23:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912082658.2262-1-jasowang@redhat.com> <20250912082658.2262-2-jasowang@redhat.com>
 <20250915120210-mutt-send-email-mst@kernel.org> <CACGkMEufUAL1tBrfZVMQCEBmBZ=Z+aPqUtP=RzOQhjtG9jn7UA@mail.gmail.com>
 <20250916011733-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250916011733-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Sep 2025 14:24:22 +0800
X-Gm-Features: AS18NWBEENXnq_7VvTKCq3s046_2Fg4yd7Uf6NSOzQJJ0vEyLQYZEm5uVl98-eY
Message-ID: <CACGkMEu_p-ouLbEq26vMTJmeGs1hw5JHOk1qLt8mLLPOMLDbaQ@mail.gmail.com>
Subject: Re: [PATCH net 2/2] vhost-net: correctly flush batched packet before
 enabling notification
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org, 
	jon@nutanix.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 1:19=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Sep 16, 2025 at 10:37:35AM +0800, Jason Wang wrote:
> > On Tue, Sep 16, 2025 at 12:03=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Fri, Sep 12, 2025 at 04:26:58PM +0800, Jason Wang wrote:
> > > > Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until aft=
er
> > > > sendmsg") tries to defer the notification enabling by moving the lo=
gic
> > > > out of the loop after the vhost_tx_batch() when nothing new is
> > > > spotted. This will bring side effects as the new logic would be reu=
sed
> > > > for several other error conditions.
> > > >
> > > > One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> > > > might return -EAGAIN and exit the loop and see there's still availa=
ble
> > > > buffers, so it will queue the tx work again until userspace feed th=
e
> > > > IOTLB entry correctly. This will slowdown the tx processing and may
> > > > trigger the TX watchdog in the guest.
> > > >
> > > > Fixing this by stick the notificaiton enabling logic inside the loo=
p
> > > > when nothing new is spotted and flush the batched before.
> > > >
> > > > Reported-by: Jon Kohler <jon@nutanix.com>
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until aft=
er sendmsg")
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/vhost/net.c | 33 +++++++++++++--------------------
> > > >  1 file changed, 13 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > > > index 16e39f3ab956..3611b7537932 100644
> > > > --- a/drivers/vhost/net.c
> > > > +++ b/drivers/vhost/net.c
> > > > @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *=
net, struct socket *sock)
> > > >       int err;
> > > >       int sent_pkts =3D 0;
> > > >       bool sock_can_batch =3D (sock->sk->sk_sndbuf =3D=3D INT_MAX);
> > > > -     bool busyloop_intr;
> > > >       bool in_order =3D vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
> > > >
> > > >       do {
> > > > -             busyloop_intr =3D false;
> > > > +             bool busyloop_intr =3D false;
> > > > +
> > > >               if (nvq->done_idx =3D=3D VHOST_NET_BATCH)
> > > >                       vhost_tx_batch(net, nvq, sock, &msg);
> > > >
> > > > @@ -780,10 +780,18 @@ static void handle_tx_copy(struct vhost_net *=
net, struct socket *sock)
> > > >                       break;
> > > >               /* Nothing new?  Wait for eventfd to tell us they ref=
illed. */
> > > >               if (head =3D=3D vq->num) {
> > > > -                     /* Kicks are disabled at this point, break lo=
op and
> > > > -                      * process any remaining batched packets. Que=
ue will
> > > > -                      * be re-enabled afterwards.
> > > > +                     /* Flush batched packets before enabling
> > > > +                      * virqtueue notification to reduce
> > > > +                      * unnecssary virtqueue kicks.
> > > >                        */
> > > > +                     vhost_tx_batch(net, nvq, sock, &msg);
> > >
> > > So why don't we do this in the "else" branch"? If we are busy polling
> > > then we are not enabling kicks, so is there a reason to flush?
> >
> > It should be functional equivalent:
> >
> > do {
> >     if (head =3D=3D vq->num) {
> >         vhost_tx_batch();
> >         if (unlikely(busyloop_intr)) {
> >             vhost_poll_queue()
> >         } else if () {
> >             vhost_disable_notify(&net->dev, vq);
> >             continue;
> >         }
> >         return;
> > }
> >
> > vs
> >
> > do {
> >     if (head =3D=3D vq->num) {
> >         if (unlikely(busyloop_intr)) {
> >             vhost_poll_queue()
> >         } else if () {
> >             vhost_tx_batch();
> >             vhost_disable_notify(&net->dev, vq);
> >             continue;
> >         }
> >         break;
> > }
> >
> > vhost_tx_batch();
> > return;
> >
> > Thanks
> >
>
> But this is not what the code comment says:
>
>                      /* Flush batched packets before enabling
>                       * virqtueue notification to reduce
>                       * unnecssary virtqueue kicks.
>
>
> So I ask - of we queued more polling, why do we need
> to flush batched packets? We might get more in the next
> polling round, this is what polling is designed to do.

The reason is there could be a rx work when busyloop_intr is true, so
we need to flush.

Thanks

>
>
> >
> > >
> > >
> > > > +                     if (unlikely(busyloop_intr)) {
> > > > +                             vhost_poll_queue(&vq->poll);
> > > > +                     } else if (unlikely(vhost_enable_notify(&net-=
>dev,
> > > > +                                                             vq)))=
 {
> > > > +                             vhost_disable_notify(&net->dev, vq);
> > > > +                             continue;
> > > > +                     }
> > > >                       break;
> > > >               }
> > > >
> > > > @@ -839,22 +847,7 @@ static void handle_tx_copy(struct vhost_net *n=
et, struct socket *sock)
> > > >               ++nvq->done_idx;
> > > >       } while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_=
len)));
> > > >
> > > > -     /* Kicks are still disabled, dispatch any remaining batched m=
sgs. */
> > > >       vhost_tx_batch(net, nvq, sock, &msg);
> > > > -
> > > > -     if (unlikely(busyloop_intr))
> > > > -             /* If interrupted while doing busy polling, requeue t=
he
> > > > -              * handler to be fair handle_rx as well as other task=
s
> > > > -              * waiting on cpu.
> > > > -              */
> > > > -             vhost_poll_queue(&vq->poll);
> > > > -     else
> > > > -             /* All of our work has been completed; however, befor=
e
> > > > -              * leaving the TX handler, do one last check for work=
,
> > > > -              * and requeue handler if necessary. If there is no w=
ork,
> > > > -              * queue will be reenabled.
> > > > -              */
> > > > -             vhost_net_busy_poll_try_queue(net, vq);
> > > >  }
> > > >
> > > >  static void handle_tx_zerocopy(struct vhost_net *net, struct socke=
t *sock)
> > > > --
> > > > 2.34.1
> > >
>


