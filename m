Return-Path: <netdev+bounces-96542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A608C6670
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 14:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED3828354C
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9820F82860;
	Wed, 15 May 2024 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5snBEyZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D936774E3D
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715777109; cv=none; b=il1O0eXmajMgelvHL3DuUmq6Qyi3DRbtlhwBycRmY3Zm0Q+94VL1RNK3Qcc7cQGvWZ1N9ZDpB84OA60FmsKtiS9VD0ReiIw7kY33zmHHzON6YSOTmOIAkKOOfgw3ShK7vyG2QjHVEWgqCUEnEaHQl3gFoAMPa+dsDUd6gIUv8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715777109; c=relaxed/simple;
	bh=dAiKwswlI9vl7Vz1knSyiBGRXl8sL2zhSzjCe6UvXcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zk6MKZzA7AMGWJ5YsNGtuD02FbCy6yy4S95znYyYeeYkg1giPr+FMnVbHXgwfEz7V5bxpGwYfQd5AICBJOOv1tBh8qIVyHaDno8XfDTah8ttSl+mWrSCGbA1vG5ZtzU/AXJEy+YiicAj8i98ia6a+Z24j0+x4Oj4O4G42BajGb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5snBEyZ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso29838a12.1
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 05:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715777106; x=1716381906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIHDT+07znPLhR2FPshSj/zmhbvnVDWs3oWxP5GgC3U=;
        b=b5snBEyZPPQChIAYCqymIGointIbZx8IDYemlfjBvoJTnle/wjF1sayC897TDA5IpE
         M6J4owqzktPbfd8YdLAk/n2QNoeTVRQj1Hm6CGp2BUmfiGPHTe8D3W18ReDZtT2DkGhG
         cWQUMg6ZbaC1e7tvBnKuw9cveII4lKGIbmOWve+iyPcMWHagw2xilASWhj0vCBAgeH9t
         C9M/XBkzVByoeGZ0euGs+Py2xL6DIW5/H42T+WO3JUJOAqn8D8VhEWmAX0Sp9cKcgrVa
         n4yvqSkhmAclVstATvvJKfyKWCrTNG8QVfOJOaEBPEBNGzaSmh/NC4gNjbgZ+fSzqZGi
         hfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715777106; x=1716381906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIHDT+07znPLhR2FPshSj/zmhbvnVDWs3oWxP5GgC3U=;
        b=fbohWfDMHw1UgnZ+Gy7pMMYuoh84C24r2qJmrQJMuF3JayOm2aoHpgzLFfCn7l3etf
         YXqVXJz5Su9qe/+WGuT4KiKs+F/dJhBW6Sqfvy3SfCFM2O8RlnDQ4FeUL6HVGpAhRfmH
         Aspkz4Z/yahdSfFv79fPX+ChHeRWzctIQ/QzX51SzFRsVyUAQ6qRrlz9RFJh0lMJI32e
         R9LIEyj+qkQiQo52Ru68gn/M3GRgR32P2jHe6xo1t9QXEZmkZfU1QHfrAsI5GWqmPCTD
         X2vcqRo/in+7ElSYCuEH5G02z2XGn7zA2Rt4InK6s8P1A6QwRTdrEY7dUJefwmhkOIhN
         erkw==
X-Gm-Message-State: AOJu0Yx7BQBqdMCsRmGUUEl5Bpqp+/Vmu7KPXQiHy6lk4WfK4JY+zSHj
	hJJPA3V92mJOsoPwlP44uSwHV8160WSA7N4rX7B2hI5hUv/IWsuXZRfahxPXff7P+1ZQgjCcJzs
	xyZDhGPJWqUZTAcFdkZjBtug1rezq4Q+I2/kX
X-Google-Smtp-Source: AGHT+IHvETyQZIEG+Vfa+gII+NQxpoDXXbq8ziKjVJ2GJyUu1Ib6RfG9WuzJxnSyPejOgjdduo9E66L6SQ/gpOSzeAs=
X-Received: by 2002:a50:cac7:0:b0:572:a154:7081 with SMTP id
 4fb4d7f45d1cf-57443d4db9amr718673a12.4.1715777105675; Wed, 15 May 2024
 05:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503202445.1415560-1-danielj@nvidia.com> <20240503202445.1415560-3-danielj@nvidia.com>
In-Reply-To: <20240503202445.1415560-3-danielj@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 May 2024 14:44:54 +0200
Message-ID: <CANn89iLazVaUCvhPm6RPJJ0owra_oFnx7Fhc8d60gV-65ad3WQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/6] virtio_net: Remove command data from control_buf
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 10:25=E2=80=AFPM Daniel Jurgens <danielj@nvidia.com>=
 wrote:
>
> Allocate memory for the data when it's used. Ideally the struct could
> be on the stack, but we can't DMA stack memory. With this change only
> the header and status memory are shared between commands, which will
> allow using a tighter lock than RTNL.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 124 +++++++++++++++++++++++++++------------
>  1 file changed, 85 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9cf93a8a4446..451879d570a8 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -368,15 +368,6 @@ struct virtio_net_ctrl_rss {
>  struct control_buf {
>         struct virtio_net_ctrl_hdr hdr;
>         virtio_net_ctrl_ack status;
> -       struct virtio_net_ctrl_mq mq;
> -       u8 promisc;
> -       u8 allmulti;
> -       __virtio16 vid;
> -       __virtio64 offloads;
> -       struct virtio_net_ctrl_coal_tx coal_tx;
> -       struct virtio_net_ctrl_coal_rx coal_rx;
> -       struct virtio_net_ctrl_coal_vq coal_vq;
> -       struct virtio_net_stats_capabilities stats_cap;
>  };
>
>  struct virtnet_info {
> @@ -2828,14 +2819,19 @@ static void virtnet_ack_link_announce(struct virt=
net_info *vi)
>
>  static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>  {
> +       struct virtio_net_ctrl_mq *mq __free(kfree) =3D NULL;
>         struct scatterlist sg;
>         struct net_device *dev =3D vi->dev;
>
>         if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ=
))
>                 return 0;
>
> -       vi->ctrl->mq.virtqueue_pairs =3D cpu_to_virtio16(vi->vdev, queue_=
pairs);
> -       sg_init_one(&sg, &vi->ctrl->mq, sizeof(vi->ctrl->mq));
> +       mq =3D kzalloc(sizeof(*mq), GFP_KERNEL);
> +       if (!mq)
> +               return -ENOMEM;
> +
> +       mq->virtqueue_pairs =3D cpu_to_virtio16(vi->vdev, queue_pairs);
> +       sg_init_one(&sg, mq, sizeof(*mq));
>
>         if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MQ,
>                                   VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET, &sg)) =
{
> @@ -2864,6 +2860,7 @@ static int virtnet_set_queues(struct virtnet_info *=
vi, u16 queue_pairs)
>
>  static int virtnet_close(struct net_device *dev)
>  {
> +       u8 *promisc_allmulti  __free(kfree) =3D NULL;
>         struct virtnet_info *vi =3D netdev_priv(dev);
>         int i;
>
> @@ -2888,6 +2885,7 @@ static void virtnet_rx_mode_work(struct work_struct=
 *work)
>         struct scatterlist sg[2];
>         struct virtio_net_ctrl_mac *mac_data;
>         struct netdev_hw_addr *ha;
> +       u8 *promisc_allmulti;
>         int uc_count;
>         int mc_count;
>         void *buf;
> @@ -2899,22 +2897,27 @@ static void virtnet_rx_mode_work(struct work_stru=
ct *work)
>
>         rtnl_lock();
>
> -       vi->ctrl->promisc =3D ((dev->flags & IFF_PROMISC) !=3D 0);
> -       vi->ctrl->allmulti =3D ((dev->flags & IFF_ALLMULTI) !=3D 0);
> +       promisc_allmulti =3D kzalloc(sizeof(*promisc_allmulti), GFP_ATOMI=
C);
> +       if (!promisc_allmulti) {

There is a missing rtnl_unlock() here ?

> +               dev_warn(&dev->dev, "Failed to set RX mode, no memory.\n"=
);
> +               return;
> +       }
>
>

