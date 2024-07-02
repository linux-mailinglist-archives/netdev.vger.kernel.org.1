Return-Path: <netdev+bounces-108349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CF291EFFE
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 865BFB24ECE
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 07:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180E1133987;
	Tue,  2 Jul 2024 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBX5KNcQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAFC537E7
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719905174; cv=none; b=JbxBgVeFNdgLCvJ1ZYVl/p7hqtmCTU0694F1lw0AKN2L1koNjEI+e1CyhmG/fkeDqJlUWWxdSgHa66H1zcAUKCUDPoLyJA7PHbxqTLT5lCmldRxDVaEzYZgforBf3Ur5my4VlowzVDDcuoBonsVO/PgS12cfdg9aV+1ETTiDoRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719905174; c=relaxed/simple;
	bh=86QKiImJ2ZbJn1OYq6bQgT0Vsu8GZD9rCR4e68lURqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INsBM0a9KVd1ZcXFZSAeX7YYqC5hVrJV0Gizzg5CyB5b4z0s7vNRV35+q6UrHknOVpZ84vOsIqQq6yVLVPTYloPicGvRFhxMZ7Hvv7/g/Ez1pIN0zTxqjdf2p0ZgiPnzIMK6veFnZLmp7Kbv3dIOA0o0ird6jezg/R7hVdKpIFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBX5KNcQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719905171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uZQ8RjLdsuPVOaNmM8IF0teK2cL8lpcz3amBeqN4jl4=;
	b=ZBX5KNcQB5dMCn/iMhusttCdJIUQC3bgbsDmmJvQfvmJR6n9HBg+mW3VC6u7fYXCv2cezH
	kEdDhZ4b+i1PLhJkedlGBYCwSnRDgTwheKJrgLmNebdoXBiKcrWizv0SQVSr/9rgkeiEba
	RAL8dtgqstGbdi7QnvldpL1b05twItU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-PCUvCJtNNNa-gGWQ_brKAg-1; Tue, 02 Jul 2024 03:26:09 -0400
X-MC-Unique: PCUvCJtNNNa-gGWQ_brKAg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70664c17112so2672530b3a.1
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 00:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719905169; x=1720509969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZQ8RjLdsuPVOaNmM8IF0teK2cL8lpcz3amBeqN4jl4=;
        b=eLvIpMFhiol/7hZxXoHNJZW1PBGxWD8HgJSGoAUmvuDxVEZ/u11P4gFfxq/dXYJ4JJ
         VZ69Sl7L99PB5YW/SalElTvDcgJAFajc7trULbahV5/EBj8vMg+XB6CPrZaEeyd58Eq9
         tswYa1YFAyJ8iI9BNkvJ6X2osJA3qP4YaKPv5tt156UOqz78CY9LXpydbaxrDLNDpAZZ
         ZOaunhni3QKfW99iTd7vp5a6XyhOxGFDrvXrbWepYocuZ7E/07IaDaE2NEqKwk5WEM5L
         b/pjDWN9NXcPXwrRaY/06fLymPGxj7TWSu8r7sUqkuOoBo1O8mVC7cZu0ezwalK6ChfF
         jt2w==
X-Forwarded-Encrypted: i=1; AJvYcCUofppYJr434Jz3zpqw6lMbEyOrOedZT2lUezWkMmkZj6Egosu5KZkoZXbfPhNoqB3O/zPbmu5DRwBKyBoUMnLYTWxQyG98
X-Gm-Message-State: AOJu0YyRvzffJpV0ASB4y9bOIvPrjtJMfF4Wy6q6reyW3UHP9E5IM2UW
	L8FE5ILwShayXQABNrNvLwClE6ca0hdD7FA0by3yHZmLFlyqkqjBk21UI37zFEqpronjCf+iIu6
	6s3G4KNoW7Xf1ZweuKlRClY5RmAT28ebRkZOHw17M+78gksagto08+Wi7oXJNsodjul0JqIYw03
	q6OeO64CiOYzO9I+/BeCt/gRzdQKP3
X-Received: by 2002:a05:6a00:8d6:b0:704:2bdd:82fe with SMTP id d2e1a72fcca58-70aaad5ca44mr7607229b3a.15.1719905168792;
        Tue, 02 Jul 2024 00:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwnIHQiDnriEcJ4WAIzj50hA2HXgTN9b5g/vPj2Zcf4saGhY00WKnTF4bPg1k/OgFGGQ9DAYd89e6JJH9O7uk=
X-Received: by 2002:a05:6a00:8d6:b0:704:2bdd:82fe with SMTP id
 d2e1a72fcca58-70aaad5ca44mr7607207b3a.15.1719905168409; Tue, 02 Jul 2024
 00:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701051239.112447-1-lulu@redhat.com> <20240701051239.112447-3-lulu@redhat.com>
In-Reply-To: <20240701051239.112447-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 2 Jul 2024 15:25:57 +0800
Message-ID: <CACGkMEu4dxQ=KUJUwMt6WN31Y9hCZSYTPLabZghruzuJWdpGQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vdpa_sim_net: Add the support of set mac address
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 1:13=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Add the function to support setting the MAC address.
> For vdpa_sim_net, the driver will write the MAC address
> to the config space, and other devices can implement
> their own functions to support this.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim=
/vdpa_sim_net.c
> index cfe962911804..e1e545d6490e 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -414,6 +414,21 @@ static void vdpasim_net_get_config(struct vdpasim *v=
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
> +
> +       if (config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> +               memcpy(vio_config->mac, config->net.mac, ETH_ALEN);
> +               return 0;
> +       }

We should synchronize this with the mac set from the guest.

Thanks

> +       return -EINVAL;
> +}
> +
>  static void vdpasim_net_setup_config(struct vdpasim *vdpasim,
>                                      const struct vdpa_dev_set_config *co=
nfig)
>  {
> @@ -510,7 +525,8 @@ static void vdpasim_net_dev_del(struct vdpa_mgmt_dev =
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


