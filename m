Return-Path: <netdev+bounces-114559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B12C942E66
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C401C20EE3
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97671AB53D;
	Wed, 31 Jul 2024 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h3tudPy/"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4E18CC1C
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428875; cv=none; b=Nag2m/ZX/fuQO6w7O16Za33T3r8wMZ4VfxP9vhOT/fYtiGlXKqqDNvYwgiDqeqJGBfPX+CuNXi+5o0OHGP5j/0+C4NCRYMV7IfumwFSzwKSC1kk8+3PRIK6Mmt5bSyICSkPkenr7TqpCAgMqLmTNa7rCQIg4NNR8vRuNSHjf3pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428875; c=relaxed/simple;
	bh=fajAfikRY1y2xE+kOjO4/iMBkjjseJ3cIk/5GvGz/Xo=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=Mo5DZUi/j1Leqb4lL8wHfq+ywHWOXZQLk0h7DO3YbEcGkl1aS5rFr+1L0BQ0l6fuQ0Ozd0xKzVcXNvQ1ESbXE8iWiSc6CLDGZwnFgIrdIr4q2Hbc69hpO6HSDRXI1nEX5M7vpTqauCf/ibzMpMdbIUicGuRsaMPsVrOYLd9SWx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h3tudPy/; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722428871; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=KQwUHS49W8FGAMhB3LMyYCt7byoJBo8piZ3zIL1qnY8=;
	b=h3tudPy/65MdgTmMzbNF0ZipXvapnhNtVyIE4nZOnF/gTy4u0VLLPn6pnoB7ABdrlVIWRBegVtU8+rmRtVfuakF+HhQmngQ17Gc5unOVfOtyY/4IwXc3a09TQYfzlE+C02nyVI4U036ODfZgaC3N7/tmy3sF/ygmroNWONNavdI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBjMdTA_1722428869;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBjMdTA_1722428869)
          by smtp.aliyun-inc.com;
          Wed, 31 Jul 2024 20:27:50 +0800
Message-ID: <1722428723.505313-1-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net v2] virtio-net: unbreak vq resizing when coalescing is not negotiated
Date: Wed, 31 Jul 2024 20:25:23 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 =?utf-8?q?EugenioP=C3=A9rez?= <eperezma@redhat.com>
References: <20240731120717.49955-1-hengqi@linux.alibaba.com>
 <20240731081409-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240731081409-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 31 Jul 2024 08:14:43 -0400, "Michael S. Tsirkin" <mst@redhat.com> w=
rote:
> On Wed, Jul 31, 2024 at 08:07:17PM +0800, Heng Qi wrote:
> > >From the virtio spec:
> >=20
> > 	The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
> > 	feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> > 	and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
> >=20
> > The driver must not send vq notification coalescing commands if
> > VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated. This limitation of course
> > applies to vq resize.
> >=20
> > Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq =
resize")
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Acked-by: Eugenio P=C3=A9 rez <eperezma@redhat.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > ---
> > v1->v2:
> >  - Rephrase the subject.
> >  - Put the feature check inside the virtnet_send_{r,t}x_ctrl_coal_vq_cm=
d().
> >=20
> >  drivers/net/virtio_net.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 0383a3e136d6..2b566d893ea3 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3658,6 +3658,9 @@ static int virtnet_send_rx_ctrl_coal_vq_cmd(struc=
t virtnet_info *vi,
> >  {
> >  	int err;
> > =20
> > +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> > +		return -EOPNOTSUPP;
> > +
> >  	err =3D virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
> >  					    max_usecs, max_packets);
> >  	if (err)
> > @@ -3675,6 +3678,9 @@ static int virtnet_send_tx_ctrl_coal_vq_cmd(struc=
t virtnet_info *vi,
> >  {
> >  	int err;
> > =20
> > +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> > +		return -EOPNOTSUPP;
> > +
> >  	err =3D virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
> >  					    max_usecs, max_packets);
> >  	if (err)
> > @@ -3743,7 +3749,7 @@ static int virtnet_set_ringparam(struct net_devic=
e *dev,
> >  			err =3D virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
> >  							       vi->intr_coal_tx.max_usecs,
> >  							       vi->intr_coal_tx.max_packets);
> > -			if (err)
> > +			if (err && err !=3D -EOPNOTSUPP)
> >  				return err;
> >  		}
> >
>=20
>=20
> So far so good.
>  =20
> > @@ -3758,7 +3764,7 @@ static int virtnet_set_ringparam(struct net_devic=
e *dev,
> >  							       vi->intr_coal_rx.max_usecs,
> >  							       vi->intr_coal_rx.max_packets);
> >  			mutex_unlock(&vi->rq[i].dim_lock);
> > -			if (err)
> > +			if (err && err !=3D -EOPNOTSUPP)
> >  				return err;
> >  		}
> >  	}
>=20
> I don't get this one. If resize is not supported,

Here means that the *dim feature* is not supported, not the *resize* featur=
e.

> we pretend it was successful? Why?

During a resize, if the dim feature is not supported, the driver does not
need to try to recover any coalescing values, since the device does not have
these parameters.
Therefore, the resize should continue without interruption.

Thanks.

>=20
> > --=20
> > 2.32.0.3.g01195cf9f
>=20

