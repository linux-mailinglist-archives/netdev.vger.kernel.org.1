Return-Path: <netdev+bounces-109739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C673929CC4
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 09:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B0D1F21029
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 07:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8551F94D;
	Mon,  8 Jul 2024 07:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuBmq2G/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393C11CF90
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 07:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720422389; cv=none; b=FrtXi/v58k9wodtYWeAZR3uh2DgxeXFhBR1mTkW3dB0lFWRLjYL6khWtXMOKjO03a+VoeSpjhgZz4mzsmD7CCoSxEIa1yJOzDnvg3rpQ3QscLLJgNKcy0m6+B9gqSfuR0NrfCHmL1OZX7gdNxJMGDNisq0I51vG5xVPe43+dc+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720422389; c=relaxed/simple;
	bh=THNdkBV6zSeKbGJ+rU746rP1p4hHLxTftUqiTNAVfmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1vY8W2Lm7v5sRaw7zCSXI/5AIrda6tVnmJuXoOU8zTydkhlpPeTr+wx3wkqtLijMc0t9BRveNUZEivchiuFw470/ahzIs+Xm4Y1RXNgB3/+LXC3i56K//xkxf0GdBEr6IKINOUqaGmnxOZJEBAGO/NCZeTBwMpGAhw3r8VpI8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IuBmq2G/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720422387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zyIJppIdQ0nDVMjomTHHFokVZU/AX+NHjK5GMHRTEbg=;
	b=IuBmq2G/gkyqqlEtKbjR7JOAVrHqRXiQAoeKOe+if0Nwed1I8sJZKHh4tpD+2bEUFkEo8m
	zlFnvY0oNy/IqS6fnl6Xkcn2xM6L1eak5s9OO1JjnpMQmVYomcAAkNNSghTyb7M0v/qHkX
	1o2Cx4JSOeRa4EYUelk2EMuY0BoCEdw=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-o7mb5QYhMIaQhZw-v6qwxw-1; Mon, 08 Jul 2024 03:06:26 -0400
X-MC-Unique: o7mb5QYhMIaQhZw-v6qwxw-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-81032cef053so1201919241.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 00:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720422382; x=1721027182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyIJppIdQ0nDVMjomTHHFokVZU/AX+NHjK5GMHRTEbg=;
        b=qd0Kdwh6vZsyzd8rFeGqW7bHTE1jPLfVho+qA7EBL2r/js0tcKZnyrAQsvvPzNVrnC
         Hay8imONC+IReAvKooBMk5C/mc7aFSqZex8rsenGefzMYSTQv1EFnUilaEU6cdehM3kt
         b39yOX78ZP63NyK7XTQRR0kuUzG5lHuknGwxJ0S5mjKDg5612SEqwsC9D90TG6I8fIFS
         k8jqLrm7nNCbjjJmnXt0IBR6e5Dh1E3xkjcpTlnlRdLkIEfn27bhGAgmrTumdc8LG26I
         SPl9e1nBzhaowv+L2acklvP8vH2kk7UyP2Tu8ZRY/NL1gD4I5AeWj0OSaozgzItwiTGn
         k1VA==
X-Forwarded-Encrypted: i=1; AJvYcCUAkaj/zSrWaroUWb+plwb17/mPoz3IdtUCmu4K/BLjOIz+Y56hsHSIk6BTxAGntJluQa5qmrg3T2YA2ACYQRpAUI27mKrY
X-Gm-Message-State: AOJu0YwljP00RdLfskBbI0kj8LTP7Yze7ElnJbD1mTv1KS7R6dA/qO72
	zBC6ACSFt4QRqz6lk6Dsp1deRmDsi+CTxfpkr1sBXCoUlsHrnm/JjaCUa+SEx6qJob/PdWD6xjk
	bh7iYNIMY6asdrRqJOtg1YNTXrWuTs81rkWhzPdhXliu4eV/PTUK4qlE8jQLOamWq9W/AVdXtyH
	9x38pDRuDGatOYmZBjgBzN0+S366IXg1PShIetPZc=
X-Received: by 2002:a67:fc49:0:b0:48f:95c4:d534 with SMTP id ada2fe7eead31-48fee85607dmr10714725137.3.1720422381812;
        Mon, 08 Jul 2024 00:06:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO1uc/RoshDkfTco0M6SeXuaFTZdF5eVYjCvZPJyHOCO2f2BCvZGt1Bk00xuZa9uB5eVL5bqHsQrA5BAFqNEk=
X-Received: by 2002:a67:fc49:0:b0:48f:95c4:d534 with SMTP id
 ada2fe7eead31-48fee85607dmr10714708137.3.1720422381475; Mon, 08 Jul 2024
 00:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708064820.88955-1-lulu@redhat.com> <20240708064820.88955-3-lulu@redhat.com>
In-Reply-To: <20240708064820.88955-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 15:06:05 +0800
Message-ID: <CACGkMEum7Ufgkez9p4-o9tfYBqfvPUA+BPrxZD8gF7PmWVhE2g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vdpa_sim_net: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 2:48=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa_sim_net, the driver will write the MAC address
> to the config space, and other devices can implement
> their own functions to support this.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_net.c
> index cfe962911804..a472c3c43bfd 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -414,6 +414,22 @@ static void vdpasim_net_get_config(struct vdpasim *v=
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
> +
> +       struct virtio_net_config *vio_config =3D vdpasim->config;
> +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> +               if (!is_zero_ether_addr(config->net.mac)) {
> +                       memcpy(vio_config->mac, config->net.mac, ETH_ALEN=
);
> +                       return 0;
> +               }
> +       }
> +       return -EINVAL;

I think in the previous version, we agreed to have a lock to
synchronize the writing here?

Thanks

> +}
> +
>  static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
>                                      const struct vdpa_dev_set_config *co=
nfig)
>  {
> @@ -510,7 +526,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_dev =
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


