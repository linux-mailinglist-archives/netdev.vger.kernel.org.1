Return-Path: <netdev+bounces-236164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EF3C39108
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 05:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC31D34E7B9
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 04:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CC82586E8;
	Thu,  6 Nov 2025 04:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTqyIBC+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7KtaXVV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093FB2BEFFD
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 04:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762402265; cv=none; b=R4cvInZUBmbXK5FGwNYboOY+RXyNk4YSqAdXrK/kRviZe9u6zxsSuxRE9ggX9tefGt/2VMaHWYsjCJw6m5NjGS3UNG5K6cwME4g46sITW3OKnhmCdF4RDepd6TqWzhMj3mHccj5hToYMsWq8Kth3KoeWJB53FUjmLi1wM/nwfDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762402265; c=relaxed/simple;
	bh=Vypx43P0Hs2X8jRuOllJ3i2T4fUJdBHpZ49sS5pkgLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/8g7Cr4n2MH9ZXRzxzacfV1LeaFM2AwlzkcSX9JDLbSoZ9V8B6W6XEX7qW0VfAAMW2D/I+TaCZMDNUQ5wrwP9bJrwu0w/UvXCjBcJrWXYkTuZGk7xaNmz2jsku7glc1BXfgAgMHoFdERGP4EtMrd7qG/HTb4p2C/DnpCc0PWLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTqyIBC+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7KtaXVV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762402263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=diXDixvU+ces4HrvG9aMeLf62bJbIofBXJ4g7RwEDSg=;
	b=XTqyIBC+bDw3ZefUX6WaZyHi14K6yu4iSHnjVDgDGBFeCLtH5zVi869SPj3vTgwXtUa9Xp
	0FX4aNjUsKQPxiR+F7ow6HwcOh5hnMGGFm9EYn/OvEbX8tz0GkSzR/MAKZ66x+k5Pxgzxb
	saNbf5U7njt5CFhyaNTE4f8SAG5QRCk=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-eymnb18BPTa301MiD8-Czw-1; Wed, 05 Nov 2025 23:11:01 -0500
X-MC-Unique: eymnb18BPTa301MiD8-Czw-1
X-Mimecast-MFC-AGG-ID: eymnb18BPTa301MiD8-Czw_1762402261
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-935241906c8so959596241.3
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 20:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762402261; x=1763007061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diXDixvU+ces4HrvG9aMeLf62bJbIofBXJ4g7RwEDSg=;
        b=I7KtaXVVvvOaJp4IlYfMpq+zt4mgYqDb5p+FKj3yeEWt3AzQZ5tAYPWugReUdAtbvx
         3/hgGdxUs3VL8piNiKzQpXK1U4cx3ghAuivvzOgrV6BCabvlWvMbHq6dVX+/20/BbVSE
         FvgzbPIqAqwghMgvb9/TxzY/yjkpzlXgOSkl2KDKHtsoYfSfvhne9UKkPj6bwqDQcm34
         /O5IfT9LE8DtEeC+ZwnE5IpIMSTUidW6RW+Bxukm8j+1YABK/U587IO0rN0yAL3o07Gx
         9FxvoB8yEuf53w+FNjQrsxIjdJfQN5St/dbnH8XZqPESWit/Xn6gcKsGIyLLtdGWcwaT
         VSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762402261; x=1763007061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diXDixvU+ces4HrvG9aMeLf62bJbIofBXJ4g7RwEDSg=;
        b=P4KUg6b/woE6wwSIpMeQ4zQzCswFBqZaOsSPq353D74WaoVHoTTZ7FTihMO/9siK1L
         hdU74ZSr+GiwHb1A9Z7yQvsBg6d6ze7TOv67XHBgrJ6C+UILRXb78JTQiUbrm8iKRX+G
         xa7fmur4dB/pOjJ0nVzuEkMMsC8FkUk/RNm22DvaMbdUe0bEmpgBTtLPiNeqDLnFwf0g
         2jVtqHNSgetEV+ZOzdMNMRZ4IzeDr3CV0UB2sC0APutYJUqUaDqNULBNHWbzb2WUpSoM
         uw5zqcjxr4LnjyrRQU2DHoynzeNDWpKHSldaDkNjaFjThb1VTRnbiNonZheqC7HnZle/
         NcTA==
X-Forwarded-Encrypted: i=1; AJvYcCWBnHL7AlobcXWNRZACiWWIuttutwVv7H/Pfui65tAHAAk4a87wbFxopZKoEakdHM8wGgMovTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZedEWHyTe6FdsdYD7TiUctGn1+mQwON1385ofUx09jTiTuqD
	uaqGefwkdWlys3QGdSO1mafTsqOgwkokpuN1pmWgOOlDgOX27/4EhP9fWgmk9ez7GGhV2W8jdST
	dNaJu+kjQJ5wmfsiHZk8qImBlPK9wppWXGQoemKnmZmpB/W4gVox/wzXZF2YXZSFIR/bR5BqFtW
	U85v9gs2hU/7B4jo+/iDSYhvCykzbSeeRc
X-Gm-Gg: ASbGncslqy0AU9jKkic2L5TB72esHQ81QVPoDszwfIJ/3gzsVb4iLsQSYmYqbcAi98n
	8eg5V6xG0JsoqUc8Hdj4Ky4AnC32Wj6ltJ3EqMn2wlHqagiTFqNUFkbmbYFKhBfxzotrw0fKjdL
	ov8ZMrTUj/m1QS61cLDn2p4KcJkVnBojuEp5MxLJf/jsVNpTXJ+uUalNUq
X-Received: by 2002:a05:6102:6c7:b0:5db:2301:aa07 with SMTP id ada2fe7eead31-5dd8935c8c6mr2308388137.37.1762402261111;
        Wed, 05 Nov 2025 20:11:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrwdvRqPKYLxxY9dCQgrgztT3XItWP4mQU5xFiAH7wQRKQxGe/OvDiFkd/9kbSM8GD1fLrClO7b/gMzIHJdKw=
X-Received: by 2002:a05:6102:6c7:b0:5db:2301:aa07 with SMTP id
 ada2fe7eead31-5dd8935c8c6mr2308380137.37.1762402260712; Wed, 05 Nov 2025
 20:11:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105080151.1115698-1-lulu@redhat.com> <20251105080151.1115698-2-lulu@redhat.com>
In-Reply-To: <20251105080151.1115698-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 6 Nov 2025 12:10:47 +0800
X-Gm-Features: AWmQ_bkDYKYme3pzt7xT2cmZpaqdFv46kMxg33LWsi20ecbBTbXuPdgNz1-3zz8
Message-ID: <CACGkMEvdjE+bYxS5_XPEnKWR1sQBuq=6CAqjioto6enryKm8kw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vdpa/mlx5: update MAC address handling in mlx5_vdpa_set_attr()
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:02=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> Improve MAC address handling in mlx5_vdpa_set_attr() to ensure
> that old MAC entries are properly removed from the MPFS table
> before adding a new one. The new MAC address is then added to
> both the MPFS and VLAN tables.
>
> Warnings are issued if deleting or adding a MAC entry fails, but
> the function continues to execute in order to keep the configuration
> as consistent as possible with the hardware state.
>
> This change fixes an issue where the updated MAC address would not
> take effect until the qemu was rebooted
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index e38aa3a335fc..4bc39cb76268 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -4067,10 +4067,26 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_de=
v *v_mdev, struct vdpa_device *
>         down_write(&ndev->reslock);
>         if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
>                 pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> -               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> -               if (!err)
> +               if (!is_zero_ether_addr(ndev->config.mac)) {
> +                       if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) =
{
> +                               mlx5_vdpa_warn(mvdev,"failed to delete ol=
d MAC %pM from MPFS table\n",
> +                                       ndev->config.mac);

Any reason we need to keep trying when we fail here?

> +                       }
> +               }
> +               err =3D mlx5_mpfs_add_mac(pfmdev, (u8 *)add_config->net.m=
ac);
> +               if (!err) {
> +                       mac_vlan_del(ndev, config->mac, 0, false);
>                         ether_addr_copy(config->mac, add_config->net.mac)=
;
> +               } else {
> +                       mlx5_vdpa_warn(mvdev,"failed to add new MAC %pM t=
o MPFS table\n",
> +                               (u8 *)add_config->net.mac);
> +                       up_write(&ndev->reslock);
> +                       return err;
> +               }
>         }
> +       if (mac_vlan_add(ndev, ndev->config.mac, 0, false))
> +               mlx5_vdpa_warn(mvdev,"failed to add new MAC %pM to vlan t=
able\n",
> +                              (u8 *)add_config->net.mac);
>
>         up_write(&ndev->reslock);
>         return err;
> --
> 2.45.0
>

Thanks


