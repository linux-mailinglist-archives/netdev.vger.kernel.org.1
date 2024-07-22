Return-Path: <netdev+bounces-112371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CB6938A58
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 09:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB454B214D3
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 07:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8C215FA7A;
	Mon, 22 Jul 2024 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfPQWuGH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695481BDCF
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 07:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634504; cv=none; b=W+dAHA8Rc/BijkYEKzQIJ6UAGzxOvT3xN9aS5/UrkoO2fqFgiA1aQ2eoazN1gPAtzeG0gWA83HPGRoRxGl6OoJPvooyEw2f4eueAjXZeBZfS2CpRkCQX53hzWXKGPZIYBOrE9YLT5EOW4GxgA55YFey80P7N6eUBjyDouPf3AaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634504; c=relaxed/simple;
	bh=qwelGQSOHsBlu5/R+Td9lnRymixbgCg1HZ+vhkQvB5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rt6Lv5GluWwT3nvarIgQKf7RlzvFtb9gqE94I7SLZDBdUCSF/LhdH8BfHtnOxRe5hz5HdKrE03AcP2HYdRB+ukvzS7VBdx7FF2ce4X0KP06wCBkNywcn2dK2efoIkEP0S54tiUgMLjD0Ay+dg8CR/zQ6J+atOwvYW9DB0lxmi14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfPQWuGH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721634501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/mcqTp3y3xN2oxPQLtpcs5nTeZV7vOd20nAM2VvMok=;
	b=AfPQWuGHC0NzBGdZbLNIGLFBK+O+JoMN6opkt9im910OZ3mdD9eKf3Zeo5rVl/ij5f8jhz
	LHXWri+wp0LgfNrpQnK9o8d3mqGwieoVtaKjVI6BwbrawO/dLvspRSelBp85CygudIkEKv
	5hNZo9ULi6lNTikzF8zcu3cyFu3ahc0=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-1IWJJtINOa-EG6cbGN03xw-1; Mon, 22 Jul 2024 03:48:19 -0400
X-MC-Unique: 1IWJJtINOa-EG6cbGN03xw-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-81ff8a9ba5aso1289784241.3
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 00:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721634499; x=1722239299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/mcqTp3y3xN2oxPQLtpcs5nTeZV7vOd20nAM2VvMok=;
        b=boTAjJzmQs2k18Gjegu1jmFdDq1qkdbumj5pvLIQTLcNW56MyXBVKZXKiC7iD3k22S
         UUOpUokSmJL9nNNoOz3fyh/6WltIlPeooSrzwy3WdOKQ1E0nME1XJOMzRQnO6Lc3H6zF
         nqn/EIUEBYQwuefz3nEL1mXF1IqfxBPQ4ZQv9Wr29S7STYT6rdFU4xEsDCIgKpwEUpII
         Zodptt9cAr1QtWFXrbXLJ2yi2KsZ7Zd2FVu1wsE/hJ/q5qiK7/o26RRxcWPwoCH+MYb8
         PSCVUqY4eZX3sKxFD0bE75NWdJWT+2ZI0x/AwiCyRZqRatI/4eAfq1QEAdYLWGb//oYB
         +Yog==
X-Forwarded-Encrypted: i=1; AJvYcCXPBYYpqORTkWaFzNtG5P5H3PtOApeM9uQbP9jr/ddjNYhnOnHUdGEwnNrOXlViLdcfKE6zk5uyjHJoCuTAcxPgQmvMvdbA
X-Gm-Message-State: AOJu0YwT5xtNSslYCdXG98Q/GsqDWg8BLoE03dORdxfiheF2kWbfkZPP
	dma5UHBkC2kLbGvj9EF4TDDD2rcaqjQfVgmgx6ULLPRd3lXyBjByfQN2Mnhf2Uyf/lPh8nIBhnn
	3AxRVoVmMu0JgHdflIIGGtVeliG4ZRh2H4aZ6gKyJr0n8/Dm89lcmRD8w8slX7CjMLn1oboAPmT
	6vC0ItTQqXUrLPcXVOAs4kBKvgqsOB
X-Received: by 2002:a05:6102:5e96:b0:48d:a5ff:2f5f with SMTP id ada2fe7eead31-49283e2b004mr4468189137.12.1721634498692;
        Mon, 22 Jul 2024 00:48:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAp5cOsjJMIxSSgdrU2NI/bo+MBLdUDPozloHXQyx7N7sL3/bEoMgtqLF7ISAqIr6HhTEILPOLPhO3xtGIBgs=
X-Received: by 2002:a05:6102:5e96:b0:48d:a5ff:2f5f with SMTP id
 ada2fe7eead31-49283e2b004mr4468168137.12.1721634498275; Mon, 22 Jul 2024
 00:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-3-lulu@redhat.com>
In-Reply-To: <20240722010625.1016854-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jul 2024 15:48:02 +0800
Message-ID: <CACGkMEtq=2yO=4te+qQxwSzi4G-4E_kdq=tCQq_N94Pk8Ro3Zw@mail.gmail.com>
Subject: Re: [PATH v4 2/3] vdpa_sim_net: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa_sim_net, the driver will write the MAC address
> to the config space, and other devices can implement
> their own functions to support this.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_net.c
> index cfe962911804..936e33e5021a 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -414,6 +414,25 @@ static void vdpasim_net_get_config(struct vdpasim *v=
dpasim, void *config)
>         net_config->status =3D cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LIN=
K_UP);
>  }
>
> +static int vdpasim_net_set_attr(struct vdpa_mgmt_dev *mdev,
> +                               struct vdpa_device *dev,
> +                               const struct vdpa_dev_set_config *config)
> +{
> +       struct vdpasim *vdpasim =3D container_of(dev, struct vdpasim, vdp=
a);
> +       struct virtio_net_config *vio_config =3D vdpasim->config;
> +
> +       mutex_lock(&vdpasim->mutex);
> +
> +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> +               memcpy(vio_config->mac, config->net.mac, ETH_ALEN);
> +               mutex_unlock(&vdpasim->mutex);
> +               return 0;
> +       }
> +
> +       mutex_unlock(&vdpasim->mutex);

Do we need to protect:

        case VIRTIO_NET_CTRL_MAC_ADDR_SET:
read =3D vringh_iov_pull_iotlb(&cvq->vring, &cvq->in_iov,
                                             vio_config->mac, ETH_ALEN);
                if (read =3D=3D ETH_ALEN)
                        status =3D VIRTIO_NET_OK;
                break;

As both are modifying vio_config?

Thanks

> +       return -EINVAL;
> +}
> +
>  static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
>                                      const struct vdpa_dev_set_config *co=
nfig)
>  {
> @@ -510,7 +529,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_dev =
*mdev,
>
>  static const struct vdpa_mgmtdev_ops vdpasim_net_mgmtdev_ops =3D {
>         .dev_add =3D vdpasim_net_dev_add,
> -       .dev_del =3D vdpasim_net_dev_del
> +       .dev_del =3D vdpasim_net_dev_del,
> +       .dev_set_attr =3D vdpasim_net_set_attr
>  };
>
>  static struct virtio_device_id id_table[] =3D {
> --
> 2.45.0
>


