Return-Path: <netdev+bounces-93959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5AE8BDBED
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 08:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7648E1C214E7
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 06:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9404B78C89;
	Tue,  7 May 2024 06:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xh4ZtMzO"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7129878C74
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715064980; cv=none; b=GWLWFprwLNqUqKzMnx+Uvf+GI8FFyoeSP6pKkvLzD1o0NdA2ecL5cv55dYIMJNuZ5XaC2+dFChPgsioV/LmF0w3R6uHXcIz/sLa7iR53dhn8DoqgEpzmRNLKoNvjVk0yujRnGbVBHRFiGdArKF9j4SWiZBWmIGSvv9q8hskgN68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715064980; c=relaxed/simple;
	bh=KH6ACOTgTjSB1d1+lm9Rz8k7+kG6Gz3KQydCW5OErMY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=LInigQcPZ0s8he2plgrqoX6PJVlcqlXQckoRqZawHxClyELgIWO6CabvDugpGoqbaIZ4GG/8ozNZP9anyAn4iaYeekBI4t2ldhwwep1uMu8s6e6X3016fJeIiy0nroTVXjiAgkK5aU3vB09wbxR2eWH37pq7S7V8GPZZdyfM4SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xh4ZtMzO; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715064974; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=YW16j1lwlf/HRa23fUoHKr1EAS+k2nsG9B0DwUSB+qk=;
	b=xh4ZtMzOv3elVjYV9A4xIJwW/nQkC5Hywh8rkgIyhv832ovgoYQPANj+UP5rkMcwlU3MBLkLljZ5eS/iXETig3DBafXfVlOhTbZGeoIbHwexpoAAgSbaxZb4rrgQIHZEryKB4sb/xv8X4eB7qEHuFUdzktPDXHiYXE3sp13Savc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W6.Am9D_1715064972;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W6.Am9D_1715064972)
          by smtp.aliyun-inc.com;
          Tue, 07 May 2024 14:56:14 +0800
Message-ID: <1715064795.2147572-1-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 1/2] virtio_net: introduce ability to get reply info from device
Date: Tue, 7 May 2024 14:53:15 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240426065441.120710-1-hengqi@linux.alibaba.com>
 <20240426065441.120710-2-hengqi@linux.alibaba.com>
 <CACGkMEvUT_uyLaqi533BUOqCYW1dYZTqdW_CC3-LgQXhhdJYFw@mail.gmail.com>
In-Reply-To: <CACGkMEvUT_uyLaqi533BUOqCYW1dYZTqdW_CC3-LgQXhhdJYFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 7 May 2024 14:24:19 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Fri, Apr 26, 2024 at 2:54=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com=
> wrote:
> >
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >
> > As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f38998982=
3039724f95bbbd243291ab0064f82
> >
> > Based on the description provided in the above specification, we have
> > enabled the virtio-net driver to support acquiring some response
> > information from the device via the CVQ (Control Virtqueue).
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>=20
> I wonder if we need to tweak the spec as it has:
>=20
> """
> Upon disabling and re-enabling a transmit virtqueue, the device MUST
> set the coalescing parameters of the virtqueue
> to those configured through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET
> command, or, if the driver did not set any TX coalescing parameters,
> to 0.
> """
>=20
> So for reset, this patch tells us the device would have a non-zero
> default value.
>=20
> But spec tolds us after vq reset, it has a zero default value ...

Maybe we add a bool or flag for driver to mark whether the user has actively
configured interrupt coalescing parameters. Then we can take actions when
vq reset occurs?

Thanks.

>=20
> Thanks
>=20
>=20
> > ---
> >  drivers/net/virtio_net.c | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 7176b956460b..3bc9b1e621db 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2527,11 +2527,12 @@ static int virtnet_tx_resize(struct virtnet_inf=
o *vi,
> >   * supported by the hypervisor, as indicated by feature bits, should
> >   * never fail unless improperly formatted.
> >   */
> > -static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8=
 cmd,
> > -                                struct scatterlist *out)
> > +static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 cla=
ss, u8 cmd,
> > +                                      struct scatterlist *out,
> > +                                      struct scatterlist *in)
> >  {
> > -       struct scatterlist *sgs[4], hdr, stat;
> > -       unsigned out_num =3D 0, tmp;
> > +       struct scatterlist *sgs[5], hdr, stat;
> > +       u32 out_num =3D 0, tmp, in_num =3D 0;
> >         int ret;
> >
> >         /* Caller should know better */
> > @@ -2549,10 +2550,13 @@ static bool virtnet_send_command(struct virtnet=
_info *vi, u8 class, u8 cmd,
> >
> >         /* Add return status. */
> >         sg_init_one(&stat, &vi->ctrl->status, sizeof(vi->ctrl->status));
> > -       sgs[out_num] =3D &stat;
> > +       sgs[out_num + in_num++] =3D &stat;
> >
> > -       BUG_ON(out_num + 1 > ARRAY_SIZE(sgs));
> > -       ret =3D virtqueue_add_sgs(vi->cvq, sgs, out_num, 1, vi, GFP_ATO=
MIC);
> > +       if (in)
> > +               sgs[out_num + in_num++] =3D in;
> > +
> > +       BUG_ON(out_num + in_num > ARRAY_SIZE(sgs));
> > +       ret =3D virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi, GF=
P_ATOMIC);
> >         if (ret < 0) {
> >                 dev_warn(&vi->vdev->dev,
> >                          "Failed to add sgs for command vq: %d\n.", ret=
);
> > @@ -2574,6 +2578,12 @@ static bool virtnet_send_command(struct virtnet_=
info *vi, u8 class, u8 cmd,
> >         return vi->ctrl->status =3D=3D VIRTIO_NET_OK;
> >  }
> >
> > +static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8=
 cmd,
> > +                                struct scatterlist *out)
> > +{
> > +       return virtnet_send_command_reply(vi, class, cmd, out, NULL);
> > +}
> > +
> >  static int virtnet_set_mac_address(struct net_device *dev, void *p)
> >  {
> >         struct virtnet_info *vi =3D netdev_priv(dev);
> > --
> > 2.32.0.3.g01195cf9f
> >
>=20

