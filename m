Return-Path: <netdev+bounces-223333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FACB58BE5
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 04:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D027E320714
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 02:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA646233145;
	Tue, 16 Sep 2025 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2EvQvMw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C7D1E00B4
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 02:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757990272; cv=none; b=IB9PtjCHf33xXqnaGbmYSiTjP7nnL6bC0jV3We54Wh70J3JpdCT46ZNMj0Ehq0prTVODjILrxLowBzixpjpvZtTtaGsQCizUAfUY+qw7feEktlGmJpDcwoN/VtUd1g7zvSa8WWQpyBV5xTk+YWnCzpKLPMD5lqUbIM9t7G7sLqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757990272; c=relaxed/simple;
	bh=gUKy4HbgYm51Znbh/ltm0uWLek9Y6A3xzbjPKF8AM7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iP6So9fVFsq7esPcyWMhAJSEAsAwaa6ePwPWw6lfyeymUspvbWOvSbGUQOd1MA1J3sD9mFk2MFENNeGPUw6/n4o14q/brk01rtoMEs95v5+uK/jzcOeKna9GxCGStCPekM6I2c/aNDWWbzW/CFrCDtXIIM8hReMDvgMPmwsMKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2EvQvMw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757990269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAf0tQ+0pz0qPoEfmgoNOjCObM8zSLJwkzhy+q5XJZY=;
	b=A2EvQvMwo/ySmV8/iYGrUO3unZCZo4uDZndS4TvrIxgTl5FftOnB3O9tO3OYA3D2QH6hwP
	Sv/ScBw+sxIzi/XC1lt/zIdH9EtljWXCBa9FO4sH69xjdkyTVJihU9BN+n/7cKoztoZICD
	G9K6E9MzLeXQjgC9aYQbinKdujKwHts=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-Bv5TsfF5MHanmAtNPwjDig-1; Mon, 15 Sep 2025 22:37:47 -0400
X-MC-Unique: Bv5TsfF5MHanmAtNPwjDig-1
X-Mimecast-MFC-AGG-ID: Bv5TsfF5MHanmAtNPwjDig_1757990267
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32e8c800a79so1328503a91.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 19:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757990267; x=1758595067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAf0tQ+0pz0qPoEfmgoNOjCObM8zSLJwkzhy+q5XJZY=;
        b=BdQjK0LaWDbzP4fOFem0UuTDtEMuja7dKgV1H4i6qHF98vyIOhYrtVD9JoxZlMRfVX
         fU0ZieU5/BH81++rxxKaP73x2gKXZl7hH8D8As16GxzNYtFswhe95PadqHDjVb676cB/
         uN+YXy0Q6hWRMth54Ufp6PAW9DdFfFtoJzMu5tqhQUbuKx5P3O5I42hvpzdbMWtmq6Aj
         LKonUG986dxzh+FKUaSxWEQi5rf5I52NB3d1xnBlXPcxLdjje1YilRqoaZqZBYZ/ibPW
         g+juVoFyGgVwTpC6J269Ir9L8KL3alb14wR8++o/wRhsOPRiB0pU6z8bTMQaUXWUtisL
         En1A==
X-Forwarded-Encrypted: i=1; AJvYcCWAd+gIpzvK/seDxWOqtvRh7RhBnak/3eOXi5Pm1AyyJ+noG9eAv5jUHn1yD7PSleI/kqVwBDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDweZRqhjk7fZl2591hspWrPmQR7S1exWxRC0Wgvi/FFeqn2yR
	rfwhX7ICFsDDs9oekJ6EU+iNwJCkTdSVWoYd2FzhtrTUVH4VxqCqVvaLsnGflpc1OT69yokoW5p
	2LD2OcVEPOh9d1YfZ5BPmmxxmarjSf6mt+q3oGacBGdS8ncyM/OfiF20U20n+4/aW00UiCOZfn3
	wg+An9WigpQVB6VNNlMwBV2w7dc1rgfFDu
X-Gm-Gg: ASbGnctozdqOuBR3fLHMXaawYqGkUvN/8j3QcKGlCEGjSu1iTgjlXGy5ZoR6YsKdjIc
	bZmYm1y4APO+58OMQ8o7nzjYJM9XvTWjhINWd6GKBDDEc737CyzXDE6lFn2dvN8pLMxlAh8oTdq
	IuPjmTZjLnnBubZxECc5Ra
X-Received: by 2002:a17:90b:4c4b:b0:32e:7512:b680 with SMTP id 98e67ed59e1d1-32e7512b733mr5143745a91.1.1757990266767;
        Mon, 15 Sep 2025 19:37:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb6D27rOwIabYHDbTeq8O+XXMbNT5JV4s9eACQ1ml/K4xuBJXeSZM1vgjCkw2luMUbq+jomkccwDcI0a/C/DI=
X-Received: by 2002:a17:90b:4c4b:b0:32e:7512:b680 with SMTP id
 98e67ed59e1d1-32e7512b733mr5143719a91.1.1757990266274; Mon, 15 Sep 2025
 19:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912082658.2262-1-jasowang@redhat.com> <20250912082658.2262-2-jasowang@redhat.com>
 <20250915120210-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250915120210-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Sep 2025 10:37:35 +0800
X-Gm-Features: Ac12FXwy79u1dZC54rdy_dwlxjFnrMd4oYnP7Kn26CXew35l54L3830n5p1rHL0
Message-ID: <CACGkMEufUAL1tBrfZVMQCEBmBZ=Z+aPqUtP=RzOQhjtG9jn7UA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] vhost-net: correctly flush batched packet before
 enabling notification
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org, 
	jon@nutanix.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 12:03=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Fri, Sep 12, 2025 at 04:26:58PM +0800, Jason Wang wrote:
> > Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> > sendmsg") tries to defer the notification enabling by moving the logic
> > out of the loop after the vhost_tx_batch() when nothing new is
> > spotted. This will bring side effects as the new logic would be reused
> > for several other error conditions.
> >
> > One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> > might return -EAGAIN and exit the loop and see there's still available
> > buffers, so it will queue the tx work again until userspace feed the
> > IOTLB entry correctly. This will slowdown the tx processing and may
> > trigger the TX watchdog in the guest.
> >
> > Fixing this by stick the notificaiton enabling logic inside the loop
> > when nothing new is spotted and flush the batched before.
> >
> > Reported-by: Jon Kohler <jon@nutanix.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after s=
endmsg")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vhost/net.c | 33 +++++++++++++--------------------
> >  1 file changed, 13 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index 16e39f3ab956..3611b7537932 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net,=
 struct socket *sock)
> >       int err;
> >       int sent_pkts =3D 0;
> >       bool sock_can_batch =3D (sock->sk->sk_sndbuf =3D=3D INT_MAX);
> > -     bool busyloop_intr;
> >       bool in_order =3D vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
> >
> >       do {
> > -             busyloop_intr =3D false;
> > +             bool busyloop_intr =3D false;
> > +
> >               if (nvq->done_idx =3D=3D VHOST_NET_BATCH)
> >                       vhost_tx_batch(net, nvq, sock, &msg);
> >
> > @@ -780,10 +780,18 @@ static void handle_tx_copy(struct vhost_net *net,=
 struct socket *sock)
> >                       break;
> >               /* Nothing new?  Wait for eventfd to tell us they refille=
d. */
> >               if (head =3D=3D vq->num) {
> > -                     /* Kicks are disabled at this point, break loop a=
nd
> > -                      * process any remaining batched packets. Queue w=
ill
> > -                      * be re-enabled afterwards.
> > +                     /* Flush batched packets before enabling
> > +                      * virqtueue notification to reduce
> > +                      * unnecssary virtqueue kicks.
> >                        */
> > +                     vhost_tx_batch(net, nvq, sock, &msg);
>
> So why don't we do this in the "else" branch"? If we are busy polling
> then we are not enabling kicks, so is there a reason to flush?

It should be functional equivalent:

do {
    if (head =3D=3D vq->num) {
        vhost_tx_batch();
        if (unlikely(busyloop_intr)) {
            vhost_poll_queue()
        } else if () {
            vhost_disable_notify(&net->dev, vq);
            continue;
        }
        return;
}

vs

do {
    if (head =3D=3D vq->num) {
        if (unlikely(busyloop_intr)) {
            vhost_poll_queue()
        } else if () {
            vhost_tx_batch();
            vhost_disable_notify(&net->dev, vq);
            continue;
        }
        break;
}

vhost_tx_batch();
return;

Thanks


>
>
> > +                     if (unlikely(busyloop_intr)) {
> > +                             vhost_poll_queue(&vq->poll);
> > +                     } else if (unlikely(vhost_enable_notify(&net->dev=
,
> > +                                                             vq))) {
> > +                             vhost_disable_notify(&net->dev, vq);
> > +                             continue;
> > +                     }
> >                       break;
> >               }
> >
> > @@ -839,22 +847,7 @@ static void handle_tx_copy(struct vhost_net *net, =
struct socket *sock)
> >               ++nvq->done_idx;
> >       } while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)=
));
> >
> > -     /* Kicks are still disabled, dispatch any remaining batched msgs.=
 */
> >       vhost_tx_batch(net, nvq, sock, &msg);
> > -
> > -     if (unlikely(busyloop_intr))
> > -             /* If interrupted while doing busy polling, requeue the
> > -              * handler to be fair handle_rx as well as other tasks
> > -              * waiting on cpu.
> > -              */
> > -             vhost_poll_queue(&vq->poll);
> > -     else
> > -             /* All of our work has been completed; however, before
> > -              * leaving the TX handler, do one last check for work,
> > -              * and requeue handler if necessary. If there is no work,
> > -              * queue will be reenabled.
> > -              */
> > -             vhost_net_busy_poll_try_queue(net, vq);
> >  }
> >
> >  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *s=
ock)
> > --
> > 2.34.1
>


