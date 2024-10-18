Return-Path: <netdev+bounces-136885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 629959A37EA
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 10:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22EB0282EB6
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 08:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB840186616;
	Fri, 18 Oct 2024 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7WSpi6i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C7635894
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238425; cv=none; b=Ol9YlFXWJNzshk08CkFrqnBG/DT9OAWJRnXOOjCUsXfuFlKAD21ETDXuuUKPxawrUTIsjB9e86QaEO1F5A3u5kknXldzAQgVq0jq7ozOfmlEh/eRqV4H5O+UAMd4VTLuJYNtkps+v26dmxSp4bohe1SP6TJmkOzKbMHUMUlXukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238425; c=relaxed/simple;
	bh=rjO8GIIwkhih/678HlQ2OKPY5Og1C6jEQudPa0VHX3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHosHXZ5fQapQrd0x2pUzsbScTwReiJI7YuMf/FI5qBy2tj2I0K1ztFm5fni5n14fpYudqoy2+ekEeMYjP4JST5XxSWDeJzwwe+8Qjk22SQEfS+TxFGDBhFWkOTHgFChoF0lW/Rm8kdOzqkQ2A1XeG/u0udvy0+oNZxRSMsPoxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S7WSpi6i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729238421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pbw9XCSn/uvOt/jk45HGvwx44Jtg9UTT347FWrrF3nI=;
	b=S7WSpi6iR/2VZKqVZ9ACjuWpANCy9t3uR85bh2i+K/4mWXGE2/vHxNXRbBNPuokVhSE1NI
	4NswpWBm6Qrg/30dh+aKtiiPaVA1Rv+E9s052z4g1OcD3yJdLL0feHpLQo/nZuqmxwOEyA
	W/E/uzDp8OdCym3paPvJMUJuSEfm8G4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-k1AIu6_MMleRVEVN2ew-nA-1; Fri, 18 Oct 2024 04:00:20 -0400
X-MC-Unique: k1AIu6_MMleRVEVN2ew-nA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7174c6cbdbaso1873915b3a.2
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 01:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729238419; x=1729843219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbw9XCSn/uvOt/jk45HGvwx44Jtg9UTT347FWrrF3nI=;
        b=kH9MGKViixI6xHtybZTmYfj3KzDx/UCWc3l/VslqHgiVdYlMv8o338gCO88JHhWIn2
         z4VfuuR9QFqxzV44b88kouu1PFXIIH5uedVTqkH8mHxYlypFfL2SeDG9DChxzmop09lH
         WrdIjjUOAgeBEzMb/Qv+1M1/+ICzpJP1BLffZDTWYIwtsdTj1BVVLnglocr75VuKpvjO
         eOvVSUde8A/p61ike4QRimMXHFv+uRP6KoTtUnPMkHlAw/+9R4cPY9D16q1eKfZTdgrz
         Ae8PjS92hzWGVT+H6QQ/Hrw8qB6YHfHbKUy3VSotlJvSbcnR6wV3nJzaQu+rwJy7V6dA
         8AzQ==
X-Gm-Message-State: AOJu0YzsH8kULw9FQl7mCIMEYw65RlUqemtEH9caqmhRxD/6Qwk4m5G7
	n7zjXtndAk7luA/rLu5wweugYeXMIF0ZkB30605fkblISAIL6JkY6Z3A2QzJMwJa0LCZKX+M6u4
	LqWuicQWS73UuMbmkNDOxNVA0KkQXLGJ/vBft8cAD+uqBT+fumU2Kpun/AfwR7BDU8bz/dCHzyA
	QZZ1Sp9btnjWqmIlNIZ9qdb8Lgghx6
X-Received: by 2002:a05:6a00:3e0e:b0:71e:589a:7e3e with SMTP id d2e1a72fcca58-71ea31d2f1dmr2093527b3a.3.1729238419321;
        Fri, 18 Oct 2024 01:00:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFspvF+JKhss6j0gqkP9PUHaWw9U3zHuKpBL+KrafAoZsJYCH7PyMCjHq/2g2gJ2StsErnM5tVI5/nYeL3amlY=
X-Received: by 2002:a05:6a00:3e0e:b0:71e:589a:7e3e with SMTP id
 d2e1a72fcca58-71ea31d2f1dmr2093501b3a.3.1729238418886; Fri, 18 Oct 2024
 01:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com> <20241014031234.7659-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241014031234.7659-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Oct 2024 16:00:07 +0800
Message-ID: <CACGkMEvPn2QUOdxhCk=efiGj+wT2yGv4wmUGpbXH-QGGToNMLw@mail.gmail.com>
Subject: Re: [PATCH 4/5] virtio_net: enable premapped mode for merge and small
 by default
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:12=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Currently, the virtio core will perform a dma operation for each
> buffer. Although, the same page may be operated multiple times.
>
> In premapped mod, we can perform only one dma operation for the pages of
> the alloc frag. This is beneficial for the iommu device.
>
> kernel command line: intel_iommu=3Don iommu.passthrough=3D0
>
>        |  strict=3D0  | strict=3D1
> Before |  775496pps | 428614pps
> After  | 1109316pps | 742853pps
>
> In the 6.11, we disabled this feature because a regress [1].
>
> Now, we fix the problem and re-enable it.
>
> [1]: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@orac=
le.com
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index cd90e77881df..8cf24b7b58bd 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6133,6 +6133,21 @@ static int virtnet_alloc_queues(struct virtnet_inf=
o *vi)
>         return -ENOMEM;
>  }
>
> +static void virtnet_rq_set_premapped(struct virtnet_info *vi)
> +{
> +       int i;
> +
> +       /* disable for big mode */
> +       if (vi->mode =3D=3D VIRTNET_MODE_BIG)
> +               return;

Nitpick: I would like such a check to be done at the caller.

But anyhow the patch looks good

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> +
> +       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +               /* error should never happen */
> +               BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
> +               vi->rq[i].do_dma =3D true;
> +       }
> +}
> +
>  static int init_vqs(struct virtnet_info *vi)
>  {
>         int ret;
> @@ -6146,6 +6161,8 @@ static int init_vqs(struct virtnet_info *vi)
>         if (ret)
>                 goto err_free;
>
> +       virtnet_rq_set_premapped(vi);
> +
>         cpus_read_lock();
>         virtnet_set_affinity(vi);
>         cpus_read_unlock();
> --
> 2.32.0.3.g01195cf9f
>


