Return-Path: <netdev+bounces-93950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6035D8BDB63
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 08:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33671F21C04
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 06:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD6F6F525;
	Tue,  7 May 2024 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFaWvWQF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40816F07E
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715063069; cv=none; b=kYh0lLFK2YvAlj1atEakXE9SVLjOoSR8bMdjuIyOWJzei8z6Au3xxMGIrb1Dn/qIfHdB8jK48V00F3OwXoyAE4R8WRiO7tM6mYXqB+ecb+oqtrtnouCTYYhDB1nHpetwFMuXDbo/2DGkEYgEeJdw3sBR+lnCTG3K8z5fg222JCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715063069; c=relaxed/simple;
	bh=vUfM/NkCP8N5v/pvw9FjoT29XEqwm5fGlonlyZC4kpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lf6RM9IgRA1lPqhEvkjZ0ZL+Uacw52cX8EQpt5//f/muJViCJefOOKZELx2d+wUppjQigv7v8h332FYthTm+wxDjDmoVWzwz8NweQtDhSEMvpfAkdYRxesQhlnJaVpyYDzdU7M0L5ts39ykrRNrY2YmYms969e6Ew9iWjMfQi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFaWvWQF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715063066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZ+ETUzNZvss8ggWS16XFwJ2hi3V3nobv2GAVfr5owc=;
	b=RFaWvWQFz70AwDHZNv6uPvD5KlISrjdNh7vBKqEJoJkKiDzpm2rsOmgwvjy4ARmGqjD+wj
	Nu9n6+N1VjNYDQPXnGD6AHeokrgLJunlqnlY93EKozSqGkD4HJ7B2kF13brz1QoLx7+xlD
	urN9BQ5F4pKuG5muBtyj0OqNS5cVxB4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-Kvesfd9mP0meGe_mL3CX4A-1; Tue, 07 May 2024 02:24:25 -0400
X-MC-Unique: Kvesfd9mP0meGe_mL3CX4A-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5cfd6ba1c11so2740806a12.0
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 23:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715063064; x=1715667864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZ+ETUzNZvss8ggWS16XFwJ2hi3V3nobv2GAVfr5owc=;
        b=rcG2w/ERjOzNxLEOjvvULBVhJ3UpNaab4OLaKBSDLjjWXstemJpHssCfDT/D79F1at
         b/cNz47LBDEhlVv3+aTFCPS0qJJw6alS91jTgnEnMTo415L5HDC4NDKOPu3GB4tyPG9I
         DE3YjDOnvoDWfPYd/SrzAWy3Xb+PD6LdSgpCkUNGv1hYf9pgvo89YrAkASXegeELBZw2
         ku9DKaPo7FxNjriRaGGz3/+kYqZEmPcps1xQgZuxoae8qqMjuqPFsOFPxr1eHw48BuDn
         KPS2PoCgwkOHaXNwqT508O3AUvlw5vFO3TGiLDxnNrgM9vvFbKEoHQs/5zwVGXIC6v/3
         V2fw==
X-Gm-Message-State: AOJu0YwhV4F8Ycax9PlOFiYfeQvTZ9wl9Vd4zk/veanliAd31pdwH1wi
	x4Jh4a2fAcgAyZr5iHlXkpgELzml3TRoyXOUUOBWNSWFhYEmW6B5ylGPrikmY8GWUVsseBXXQU6
	HFQd6pf255wwSLh2sPP6pPXbLEjxB8oZkPjkAj+eh7q73IN73kVCS9liNThbdZwToHaG8pHDRFR
	mAZtVcIGp/bJlSvShwwkECfBFYigmY
X-Received: by 2002:a05:6a20:6f0e:b0:1ae:a5bf:341b with SMTP id gt14-20020a056a206f0e00b001aea5bf341bmr11876037pzb.6.1715063064175;
        Mon, 06 May 2024 23:24:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKzr00JmO2nNOhi+vF4ygtl0LFmkgSLokWL69VRVrP0t/pz3CegSzwo6TR9dRXxnkss/lGqXK3XNbsg6ffDW4=
X-Received: by 2002:a05:6a20:6f0e:b0:1ae:a5bf:341b with SMTP id
 gt14-20020a056a206f0e00b001aea5bf341bmr11876027pzb.6.1715063063837; Mon, 06
 May 2024 23:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426065441.120710-1-hengqi@linux.alibaba.com> <20240426065441.120710-3-hengqi@linux.alibaba.com>
In-Reply-To: <20240426065441.120710-3-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 7 May 2024 14:24:12 +0800
Message-ID: <CACGkMEs9nrFTjLa18XN9ZAokgLsw4MtXM3O3kVmQv=ofP49coA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] virtio_net: get init coalesce value when probe
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 2:54=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> Currently, virtio-net lacks a way to obtain the default coalesce
> values of the device during the probe phase. That is, the device
> may have default experience values, but the user uses "ethtool -c"
> to query that the values are still 0.
>
> Therefore, we reuse VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET to complete the goal=
.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 68 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 61 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3bc9b1e621db..fe0c15819dd3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4623,6 +4623,46 @@ static int virtnet_validate(struct virtio_device *=
vdev)
>         return 0;
>  }
>
> +static int virtnet_get_coal_init_value(struct virtnet_info *vi,
> +                                      u16 _vqn, bool is_tx)
> +{
> +       struct virtio_net_ctrl_coal *coal =3D &vi->ctrl->coal_vq.coal;
> +       __le16 *vqn =3D &vi->ctrl->coal_vq.vqn;
> +       struct scatterlist sgs_in, sgs_out;
> +       u32 usecs, pkts, i;
> +       bool ret;
> +
> +       *vqn =3D cpu_to_le16(_vqn);
> +
> +       sg_init_one(&sgs_out, vqn, sizeof(*vqn));
> +       sg_init_one(&sgs_in, coal, sizeof(*coal));
> +       ret =3D virtnet_send_command_reply(vi, VIRTIO_NET_CTRL_NOTF_COAL,
> +                                        VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET=
,
> +                                        &sgs_out, &sgs_in);
> +       if (!ret)
> +               return ret;
> +
> +       usecs =3D le32_to_cpu(coal->max_usecs);
> +       pkts =3D le32_to_cpu(coal->max_packets);
> +       if (is_tx) {
> +               vi->intr_coal_tx.max_usecs =3D usecs;
> +               vi->intr_coal_tx.max_packets =3D pkts;
> +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +                       vi->sq[i].intr_coal.max_usecs =3D usecs;
> +                       vi->sq[i].intr_coal.max_packets =3D pkts;
> +               }
> +       } else {
> +               vi->intr_coal_rx.max_usecs =3D usecs;
> +               vi->intr_coal_rx.max_packets =3D pkts;
> +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +                       vi->rq[i].intr_coal.max_usecs =3D usecs;
> +                       vi->rq[i].intr_coal.max_packets =3D pkts;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static bool virtnet_check_guest_gso(const struct virtnet_info *vi)
>  {
>         return virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> @@ -4885,13 +4925,6 @@ static int virtnet_probe(struct virtio_device *vde=
v)
>                         vi->intr_coal_tx.max_packets =3D 0;
>         }
>
> -       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> -               /* The reason is the same as VIRTIO_NET_F_NOTF_COAL. */
> -               for (i =3D 0; i < vi->max_queue_pairs; i++)
> -                       if (vi->sq[i].napi.weight)
> -                               vi->sq[i].intr_coal.max_packets =3D 1;
> -       }
> -
>  #ifdef CONFIG_SYSFS
>         if (vi->mergeable_rx_bufs)
>                 dev->sysfs_rx_queue_group =3D &virtio_net_mrg_rx_group;
> @@ -4926,6 +4959,27 @@ static int virtnet_probe(struct virtio_device *vde=
v)
>
>         virtio_device_ready(vdev);
>
> +       if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> +               /* The reason is the same as VIRTIO_NET_F_NOTF_COAL. */
> +               for (i =3D 0; i < vi->max_queue_pairs; i++)
> +                       if (vi->sq[i].napi.weight)
> +                               vi->sq[i].intr_coal.max_packets =3D 1;
> +
> +               /* The loop exits if the default value from any
> +                * queue is successfully read.
> +                */

So this assumes the default values are the same. Is this something
required by the spec? If not, we probably need to iterate all the
queues.

Thanks


> +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +                       err =3D virtnet_get_coal_init_value(vi, rxq2vq(i)=
, false);
> +                       if (!err)
> +                               break;
> +               }
> +               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +                       err =3D virtnet_get_coal_init_value(vi, txq2vq(i)=
, true);
> +                       if (!err)
> +                               break;
> +               }
> +       }
> +
>         _virtnet_set_queues(vi, vi->curr_queue_pairs);
>
>         /* a random MAC address has been assigned, notify the device.
> --
> 2.32.0.3.g01195cf9f
>


