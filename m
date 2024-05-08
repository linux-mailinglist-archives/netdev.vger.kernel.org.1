Return-Path: <netdev+bounces-94361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A9A8BF465
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4BC2848E7
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F906944D;
	Wed,  8 May 2024 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FM+64Zwf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984EF8F6A
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 02:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715134822; cv=none; b=URzR+8hkNGzJG18oEo5IW/h9UwJxdqncrrxe6hhGYasZXtBkvvW7VvgZE0RaCcarr3BQ3VPHlzZ3pGsvAvSRLxiylr1ctF2pPdmo77yUVO+lE9uUsl7furtYz4oLmDZJwy5ygo7jbeD6jaLadPknoKQW1G47jC5/zCJxvCx1l+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715134822; c=relaxed/simple;
	bh=To48W6gHUNYXb3bRuXaPMRqay8anRjSoz6uMYJy9qcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLw7MEWDQVh1bmHmlb3AYFecBUak4GfIq8yWcPnYVPiS+VSnqYDUqf/hCdIJtC3nF4kEWErK+XKFqfFbE5VuI7jT3KKSemlUzXHOF5GtFAn6N0gDAlFBotXAhStsjBQ/JnNIbL7qGbR48DNj3jkts1TfZreG4h0CD7kAc7UcTck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FM+64Zwf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715134819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1EMMCLnKM7Cf1E2LbokRIGtBgxEkk3Z+5jGNuEeHVw=;
	b=FM+64ZwfWKaj84dkMU4HEk7kbwfhDP0xUWR2r83ZLZjh+ISPcZOeHek2Fa1cwzZgv7VecX
	Zfhvw621D59WFAbUJKAxiviUtGK+T3p7FrCCFkkjD9+nYByhoMsNmMQhQ0y7PrBZx+q2sF
	42ahBxP/ypf+KEtrLdmSbyr4iHSFdAQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-7cxwSCWtNmm6dT13ZmZckA-1; Tue, 07 May 2024 22:20:18 -0400
X-MC-Unique: 7cxwSCWtNmm6dT13ZmZckA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6292562bac4so3001723a12.1
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 19:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715134817; x=1715739617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1EMMCLnKM7Cf1E2LbokRIGtBgxEkk3Z+5jGNuEeHVw=;
        b=F9ADgexv+rVRq11372vlMjV511beUkuDP+StEkoQf06SBn2M/49iXbFwqjqC46caAz
         dtjDSEnwyXw5Io4hTs7dxcGR6MGbSY6egbY4zbd+9Y2EOVWAy4pOW8H40fvoo5hKtKfv
         fG4Go66jgpE0xn8x2VbL1kqsvywlyefIgIKSdjtMXGtwyCuACJ3qwwIi0D2vxeEZZtz1
         P4jFDjz8NG8YVAkf0s/m5yxz0LCZJtWv73seJq3YX2PLiSABpKVO5IitS0NhxnomxRMk
         /dK4HjoVpEsBFhvOffZkNRfxE2rhOo+QclZ/neQ996As4ZtkvnitGmE2xJ2MqnxFDx3j
         8xTg==
X-Gm-Message-State: AOJu0YwApMJTfbXrMp0CRplss1ejAFT+y2G2BZ0HFs9gDrKALIQ4pzU+
	gV0TgEqtznqbzbZObBP8bNB0jA4Vxx1UbNHIJnBmYcI3sPUEkYD4Ogj4UpfdP/vrv9FGKK9Zqt5
	hNJvRgcKC0rT8NA8+OOF7yyX/L6f/ZNU9fbkmZuX+gIRVM6hR4bbMPfUPMR5Rg9aW/3NasZMvKJ
	IgnuiQ7qM6+WeyNiqBxPb0wdFms3B2
X-Received: by 2002:a17:902:c10c:b0:1ec:71f0:4009 with SMTP id d9443c01a7336-1eeb078ff34mr16722085ad.53.1715134816992;
        Tue, 07 May 2024 19:20:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWGBbUy7QqDhlPL8ZopBBTJeNKNw21Wp6a93ZqpKsHy4u4FCtuZt1zn63NHEcmGwBuKEM6aCkZ5sX+2desa0Y=
X-Received: by 2002:a17:902:c10c:b0:1ec:71f0:4009 with SMTP id
 d9443c01a7336-1eeb078ff34mr16721845ad.53.1715134816614; Tue, 07 May 2024
 19:20:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426065441.120710-1-hengqi@linux.alibaba.com>
 <20240426065441.120710-2-hengqi@linux.alibaba.com> <CACGkMEvUT_uyLaqi533BUOqCYW1dYZTqdW_CC3-LgQXhhdJYFw@mail.gmail.com>
 <1715064795.2147572-1-hengqi@linux.alibaba.com>
In-Reply-To: <1715064795.2147572-1-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 May 2024 10:20:05 +0800
Message-ID: <CACGkMEtdk8L9jAh+9YAE0Nwwsd2_XXULU68mFn5Rje6f-MHWAw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] virtio_net: introduce ability to get
 reply info from device
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 2:56=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
> On Tue, 7 May 2024 14:24:19 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Fri, Apr 26, 2024 at 2:54=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> > >
> > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > >
> > > As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f389989=
823039724f95bbbd243291ab0064f82
> > >
> > > Based on the description provided in the above specification, we have
> > > enabled the virtio-net driver to support acquiring some response
> > > information from the device via the CVQ (Control Virtqueue).
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >
> > I wonder if we need to tweak the spec as it has:
> >
> > """
> > Upon disabling and re-enabling a transmit virtqueue, the device MUST
> > set the coalescing parameters of the virtqueue
> > to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
> > command, or, if the driver did not set any TX coalescing parameters,
> > to 0.
> > """
> >
> > So for reset, this patch tells us the device would have a non-zero
> > default value.
> >
> > But spec tolds us after vq reset, it has a zero default value ...
>
> Maybe we add a bool or flag for driver to mark whether the user has activ=
ely
> configured interrupt coalescing parameters. Then we can take actions when
> vq reset occurs?

I basically mean we probably need to tweak the spec. For example say
the device may have a default value for coalescing so driver need to
read them.

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
> >
> > > ---
> > >  drivers/net/virtio_net.c | 24 +++++++++++++++++-------
> > >  1 file changed, 17 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 7176b956460b..3bc9b1e621db 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2527,11 +2527,12 @@ static int virtnet_tx_resize(struct virtnet_i=
nfo *vi,
> > >   * supported by the hypervisor, as indicated by feature bits, should
> > >   * never fail unless improperly formatted.
> > >   */
> > > -static bool virtnet_send_command(struct virtnet_info *vi, u8 class, =
u8 cmd,
> > > -                                struct scatterlist *out)
> > > +static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 c=
lass, u8 cmd,
> > > +                                      struct scatterlist *out,
> > > +                                      struct scatterlist *in)
> > >  {
> > > -       struct scatterlist *sgs[4], hdr, stat;
> > > -       unsigned out_num =3D 0, tmp;
> > > +       struct scatterlist *sgs[5], hdr, stat;
> > > +       u32 out_num =3D 0, tmp, in_num =3D 0;
> > >         int ret;
> > >
> > >         /* Caller should know better */
> > > @@ -2549,10 +2550,13 @@ static bool virtnet_send_command(struct virtn=
et_info *vi, u8 class, u8 cmd,
> > >
> > >         /* Add return status. */
> > >         sg_init_one(&stat, &vi->ctrl->status, sizeof(vi->ctrl->status=
));
> > > -       sgs[out_num] =3D &stat;
> > > +       sgs[out_num + in_num++] =3D &stat;
> > >
> > > -       BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
> > > -       ret =3D virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, vi, GFP_A=
TOMIC);
> > > +       if (in)
> > > +               sgs[out_num + in_num++] =3D in;
> > > +
> > > +       BUG_ON(out_num + in_num > ARRAY_SIZE(sgs));
> > > +       ret =3D virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi, =
GFP_ATOMIC);
> > >         if (ret < 0) {
> > >                 dev_warn(&vi->vdev->dev,
> > >                          "Failed to add sgs for command vq: %d\n.", r=
et);
> > > @@ -2574,6 +2578,12 @@ static bool virtnet_send_command(struct virtne=
t_info *vi, u8 class, u8 cmd,
> > >         return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> > >  }
> > >
> > > +static bool virtnet_send_command(struct virtnet_info *vi, u8 class, =
u8 cmd,
> > > +                                struct scatterlist *out)
> > > +{
> > > +       return virtnet_send_command_reply(vi, class, cmd, out, NULL);
> > > +}
> > > +
> > >  static int virtnet_set_mac_address(struct net_device *dev, void *p)
> > >  {
> > >         struct virtnet_info *vi =3D netdev_priv(dev);
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>


