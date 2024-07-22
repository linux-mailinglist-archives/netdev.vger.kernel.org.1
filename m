Return-Path: <netdev+bounces-112372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1472B938A5F
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 09:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F772818E6
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 07:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333E31607AF;
	Mon, 22 Jul 2024 07:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gE7qVl0j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B70715FCFB
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634541; cv=none; b=N842ZcsUk5gvexITod3NGZTQ1rw3uZ5Vq+osn8zJ7T5bsuHGvLalMgqJywkZ5cqbJgvhngOeYs7Ft35rWypSUE8R5dbhQKI/6dypXEhndj7kSH3BUuROy5ikzznwjZaJ8TeJmw/lBi5ZdHcMsr1uTZ98J4S8FsmyH5aAZCrdcF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634541; c=relaxed/simple;
	bh=f+fV8aZHLjNJDmqj0f9UlS/89ETfJ+867t5eBxYZL68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ae0P9XphWvl2t63BZ9QQwElyt8LIYBugO6RPzwDD5+WvxbezVWFaihP81tQy7ucX5z6kxlacOUZ2UGR6lCrwlYXaMdPLoOHpR+iovVthyZnLdZZrTdKKqeQnCXcpXFZnFC0/FO6PhWxYT6+Y5tlWLnO7ckJJg9ce/BSMJlBMmTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gE7qVl0j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721634538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k9Wijau/U3n0K7Jlrn8r30G3DxAJjcM6+ifaqnBRTZQ=;
	b=gE7qVl0j0tirf63JdaCAimgciov1V9jp4LZWXn+IEQO8cttqw4rXvyq7YjG8kuufT59Nvy
	nTbEYaFWt4tydLrR4CvCeqAGVyFGCr3NOSm4rHOSeIFz4L9FnIg02wlIKnCuMAvcE89Xui
	KEeB/IlX3PVAAZTVl8/OEkTj+nmzqTs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391--7L11ehUOK6Po2btdcgl5g-1; Mon, 22 Jul 2024 03:48:56 -0400
X-MC-Unique: -7L11ehUOK6Po2btdcgl5g-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb51290896so3601671a91.0
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 00:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721634536; x=1722239336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9Wijau/U3n0K7Jlrn8r30G3DxAJjcM6+ifaqnBRTZQ=;
        b=UDQD0OG2jIWgFbtglyR9Hb0I+edxBwxMPxY7bBaNL2F79qxmHeuUGQMqaY+a+NtrMy
         qBZKxr6HgYyfC+4kByalkox7Vd2D9WyJc5F8t+itlNHJ8JR4+F5rRUuCi8Umh1hI9np6
         a68hj9cjtj08j2aBsKT2D9BoBVRQYX7C+WkBmGvdf9zAdtjVxf4+t3ZMraK/FgKRlc80
         N+x0jO6xgSXTWVaEs7p+O4gjfzLHymE2/XyCKZ0SQBucxYsii55l0g2kRVRooElbWngo
         EUhEb1rgWjKkNohmcOg8IX6lw7WC9ebnpiGsWuQOouFNhD3dGabU5NRwLI05CM1Hcunc
         riVg==
X-Forwarded-Encrypted: i=1; AJvYcCVujdThK8VGs8XHWjpDFwI0rx2/ExspSRe3hEu52y8FH23PrNLdWt8Lo+VQX8kFmTb+6CGVf/Q9zqMIOcUXMmI5Vl6AtXem
X-Gm-Message-State: AOJu0YwjcwsfQ//sYIvCaQcmYgUFfqG3RdW0zgFvITdlrnxb1gN6WPCK
	7BmpSKqxNvAF4fuVLREsCKsfa5e0ye4+UKAGyY0GSkd3QMOzq7GCBBEGv6+KYrVGV616fyjNFqy
	Z6A0L94EdsZGnX6COFrv7dZLO8iPlwwmeiv5lupf8SZong6tXoCiU6/5ReEw4eIxsBbxzFATh0J
	9HOJ4jxkeTOwkULctUlj7YsoHkg5p9
X-Received: by 2002:a17:90b:1997:b0:2c9:8020:1b51 with SMTP id 98e67ed59e1d1-2cd273f776dmr2791079a91.3.1721634535898;
        Mon, 22 Jul 2024 00:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXRzsCMJv/6tknO7a6u+ZBcL+U7UQuyw2cdT0yYEkm2DsQ1rWAMN0KuDM6A4GO1xcfnMyjBEi8/MfpUnx4Ou0=
X-Received: by 2002:a17:90b:1997:b0:2c9:8020:1b51 with SMTP id
 98e67ed59e1d1-2cd273f776dmr2791063a91.3.1721634535409; Mon, 22 Jul 2024
 00:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722010625.1016854-1-lulu@redhat.com> <20240722010625.1016854-4-lulu@redhat.com>
In-Reply-To: <20240722010625.1016854-4-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jul 2024 15:48:44 +0800
Message-ID: <CACGkMEvXk8_sXRtugePAMv8PM0qGU-su0eFUsFZ=-=_TjcGZNg@mail.gmail.com>
Subject: Re: [PATH v4 3/3] vdpa/mlx5: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 9:06=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> to set the mac address
>
> Tested in ConnectX-6 Dx device
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index ecfc16151d61..415b527a9c72 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3785,10 +3785,35 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_de=
v *v_mdev, struct vdpa_device *
>         destroy_workqueue(wq);
>         mgtdev->ndev =3D NULL;
>  }
> +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> +                             struct vdpa_device *dev,
> +                             const struct vdpa_dev_set_config *add_confi=
g)
> +{
> +       struct mlx5_vdpa_dev *mvdev;
> +       struct mlx5_vdpa_net *ndev;
> +       struct mlx5_core_dev *mdev;
> +       struct virtio_net_config *config;
> +       struct mlx5_core_dev *pfmdev;
> +       int err =3D -EOPNOTSUPP;
> +
> +       mvdev =3D to_mvdev(dev);
> +       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +       mdev =3D mvdev->mdev;
> +       config =3D &ndev->config;
> +
> +       if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> +               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> +               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> +               if (!err)
> +                       memcpy(config->mac, add_config->net.mac, ETH_ALEN=
);
> +       }
> +       return err;

Similar to net simulator, how could be serialize the modification to
mac address:

1) from vdpa tool
2) via control virtqueue

Thanks

> +}
>
>  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
>         .dev_add =3D mlx5_vdpa_dev_add,
>         .dev_del =3D mlx5_vdpa_dev_del,
> +       .dev_set_attr =3D mlx5_vdpa_set_attr,
>  };
>
>  static struct virtio_device_id id_table[] =3D {
> --
> 2.45.0
>


