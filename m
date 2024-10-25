Return-Path: <netdev+bounces-138939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6A49AF7B5
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 04:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC17FB21ECD
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 02:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317C43D97A;
	Fri, 25 Oct 2024 02:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CbsE8j7w"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B369F1E492
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 02:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729824812; cv=none; b=Mp44rgvEpwLbp4Vh3CQlyQp8cP5gfjHpmXLkgby6kTt4D/kujNuPioiJY1dUKttSMWmcyxdkClQtoM4ea1KXNxwsXoldXu4qco3quK98qRrGeT2YBIIRMxOcDUgucedIezZGcwqLUOLxAizq1d6cRCz59NDZMI59hlGemHLtUrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729824812; c=relaxed/simple;
	bh=01ja3VxmKAoxjUC0k6Rh3DSiApD+tqj/Wdidko8XOL4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=hY+Mai6HrelE/GmDZv69CkzzdwKoT8ROaiNs+9SoDVTTyTQUP9QqK+zC+LB2FbzXMuj9h7aE9NSc7TWlpViSbbhdeChlhKk/o9vPGGpfaHBbRUAYhB/OuZasLxtyaVlP+ZDK9eDhYZFkX5qA+OywQdgOaYTVlQFnqwDnrC9pAvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CbsE8j7w; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729824800; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=wBjxChu0evej7N1IPnz96lN6iBGaYIPef7wMuoMoiyQ=;
	b=CbsE8j7wOOxJJpEzIjRsW4vIU34cW4uJwkoRDiflRoF5sEV050HteRyAKbMa/tS50d+olXqhcBx0XK25zVwU0ycoCT1jwBeyxFCfDAwx/5ddIWTNzl1cKAnBrEk++iFcOscttz4WHBaMmicrrcpGfDYgCbeVFinIlJCuTuuMipA=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WHqqBOb_1729824799 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Oct 2024 10:53:20 +0800
Message-ID: <1729824783.098598-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 4/5] virtio_net: enable premapped mode for merge and small by default
Date: Fri, 25 Oct 2024 10:53:03 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com>
 <20241014031234.7659-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEvPn2QUOdxhCk=efiGj+wT2yGv4wmUGpbXH-QGGToNMLw@mail.gmail.com>
In-Reply-To: <CACGkMEvPn2QUOdxhCk=efiGj+wT2yGv4wmUGpbXH-QGGToNMLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 18 Oct 2024 16:00:07 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Oct 14, 2024 at 11:12=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > Currently, the virtio core will perform a dma operation for each
> > buffer. Although, the same page may be operated multiple times.
> >
> > In premapped mod, we can perform only one dma operation for the pages of
> > the alloc frag. This is beneficial for the iommu device.
> >
> > kernel command line: intel_iommu=3Don iommu.passthrough=3D0
> >
> >        |  strict=3D0  | strict=3D1
> > Before |  775496pps | 428614pps
> > After  | 1109316pps | 742853pps
> >
> > In the 6.11, we disabled this feature because a regress [1].
> >
> > Now, we fix the problem and re-enable it.
> >
> > [1]: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@or=
acle.com
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index cd90e77881df..8cf24b7b58bd 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -6133,6 +6133,21 @@ static int virtnet_alloc_queues(struct virtnet_i=
nfo *vi)
> >         return -ENOMEM;
> >  }
> >
> > +static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> > +{
> > +       int i;
> > +
> > +       /* disable for big mode */
> > +       if (vi->mode =3D=3D VIRTNET_MODE_BIG)
> > +               return;
>
> Nitpick: I would like such a check to be done at the caller.

I am ok, if you like.

Thanks.


>
> But anyhow the patch looks good
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
> > +
> > +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > +               /* error should never happen */
> > +               BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
> > +               vi->rq[i].do_dma =3D true;
> > +       }
> > +}
> > +
> >  static int init_vqs(struct virtnet_info *vi)
> >  {
> >         int ret;
> > @@ -6146,6 +6161,8 @@ static int init_vqs(struct virtnet_info *vi)
> >         if (ret)
> >                 goto err_free;
> >
> > +       virtnet_rq_set_premapped(vi);
> > +
> >         cpus_read_lock();
> >         virtnet_set_affinity(vi);
> >         cpus_read_unlock();
> > --
> > 2.32.0.3.g01195cf9f
> >
>

