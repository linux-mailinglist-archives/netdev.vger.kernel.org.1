Return-Path: <netdev+bounces-250949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C0BD39C51
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 03:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB42A300102D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 02:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A92238C0A;
	Mon, 19 Jan 2026 02:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kpr4VBYz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVcO4l0z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01723717F
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 02:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768788859; cv=none; b=PWH7foWXtOmH/vrXOS811gNr+NALMP5Vq9vL+IOyB36qjB1T+ltQvB/MkBVZry1JrDzjisTmQ6Sr0hicCRjxcmvMyes9gnxWK7N6g6uv06oEk231ZORc5rAvKdeT/W+Ycib6jOyjw6y+EO5AaXSE08yaWQqs3VgE1yCBKYk/yVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768788859; c=relaxed/simple;
	bh=4o+ytm+NwAqT+t1h0w8n2FMlwVkwhJ1u77717IS2+8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuVAPRRXuWsXVzcPx0ZxY5zgJzeXD/hxGRCWFxjjfykbywARx9wqFMqPzIEv2DoeT3O2Q0mW4ae8en3Rdl10BOGw2p6J98X8kE6gtx3qQ3ZVTJFXL+yCq6A8pLC165o8+HQaWczE9HnPwpplWcmb+RG/N4bGi5pkoAZNIQ9V7io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kpr4VBYz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TVcO4l0z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768788856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PjfoSgBxYJjHbPNyjU0OdP1JPk3R3MOJGd5edMGnFbs=;
	b=Kpr4VBYz7JRap1vDbDDhTKJ1bI3t9JktAo7UmvdsiZG3OAZYvNk/EgWZuqdZBORqopjSAF
	y8dxwTHsbgetBkRZ1Pvdzz33JjDTJdgKfDiZzDo9fFv+Kzmt3H03dukOr8M3mmTx/98v3I
	Aaw+PEmJdIEZkmHpZPID17qEEyGR1ME=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-2kCwtkRTP1a1teh0jyCJNg-1; Sun, 18 Jan 2026 21:14:15 -0500
X-MC-Unique: 2kCwtkRTP1a1teh0jyCJNg-1
X-Mimecast-MFC-AGG-ID: 2kCwtkRTP1a1teh0jyCJNg_1768788855
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-93f550cdb2dso5017052241.1
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 18:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768788855; x=1769393655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjfoSgBxYJjHbPNyjU0OdP1JPk3R3MOJGd5edMGnFbs=;
        b=TVcO4l0zbmGCqB/T3goOZBzKKIImd/M86xmjUpQOq1UT46W5krLZTizufgsSTta2lo
         T64gmCNkTcH0c49t2ZdOdNkC4cZ8tP5jDVNYwf9XgjzvPPM1nH/uUtEu4USXcLecDifp
         dzs45M6EAlI6tebKIvMMw1GyAjpd4Y4zxMEdQ4lzEzuzh/XPthjyyvHwkRiP8zVWW1vI
         38pOi1G5eeyFXMJdQl8mvgjifWnknd5X+gEqZyDVZMva3xqM/guQ9etammDcdkoZYfbV
         tJ6UlEEmdlBbyX1IPQopLrIXwIWzNHDgkYa8wIGBleKk9nZx35YLPi2+2ObCHtmXSQFL
         ZWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768788855; x=1769393655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PjfoSgBxYJjHbPNyjU0OdP1JPk3R3MOJGd5edMGnFbs=;
        b=mmRkMI6sGmUaETwHIOLfJ38VnbYK8lpQ/cjiKr4EIEPRwH3+w1wWVxb/hdPp96SbBj
         ALP3e8FhNTjRJGyfWoOqyOj2AXREMaej8w1XY/ny2uFfYGzyI64gA5yU5yWgOwjaKjnB
         vlDngDcHlzwjioVKQNoaFBaUlDSckN4U3aSbxnwyIY6MfZHWYsZcaubcvQ+csaBYaMXx
         38Sh/xAwPg+6xmM0/9K1IOXULBlK3JazOKb6WMCBmRYRreUt3NPLeWfFTkpJqy6j8fOt
         hV3I7bMZn9LvLgfGeSk3gtZNqY6HJcpPZ37DhholSUxkEOhAloFHGGRHIE3fUkyF6bgA
         8UVg==
X-Forwarded-Encrypted: i=1; AJvYcCWQc7nHU5GMl4Lb8hC0kXVZ+bizZQ97bmG7FKNQ9UW1bVoloHY/4Lhi2yZwgyZBkbiqrocxpNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrnOc9L2LuX7xfwE7rzgHwsa17vmI8dA73lYD94Z/kUWipHbyI
	MW4USgKSx0z4R7gxsX2/Ls2/RD485PquKKRifAWG5Dw7VvLLWo5v72epnqFhOqBbrEf7MexyZYP
	gnckuR5SWF+Gn3Glka3a9h4L9dQuTcJ85l+M8pIrY+3KyquFwCH24lmg8dcreGyOA4Q00s2ZEIA
	jDMkCJvxRIifrOip3A0NjSOTRMBNAEO7us
X-Gm-Gg: AY/fxX6cddqmfx5v1Ljwg5o0/1Q0iUdxZCpbP1ChcfD0RMKbGZvZmCH+0TIcGIixB41
	V526a7aVDzn8pkw9HcxtvwftxbqNnZdMVVMfL/ruy39Bgp7GBrzbX2HN0rhhL9sIydskHynIhpn
	u/LqQ7EhhFuE07y12R8S/7oIUFfFyFE6bmixO75RN6d2F78Ipk7b0C65vYpvvlgkVNWvs=
X-Received: by 2002:a05:6102:950:b0:5db:2b4d:f1ee with SMTP id ada2fe7eead31-5f1a53b1e88mr2915432137.17.1768788854978;
        Sun, 18 Jan 2026 18:14:14 -0800 (PST)
X-Received: by 2002:a05:6102:950:b0:5db:2b4d:f1ee with SMTP id
 ada2fe7eead31-5f1a53b1e88mr2915424137.17.1768788854629; Sun, 18 Jan 2026
 18:14:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229071614.779621-1-lulu@redhat.com> <20251229071614.779621-3-lulu@redhat.com>
 <3fa838af-4eec-441c-8739-020990d1826d@nvidia.com>
In-Reply-To: <3fa838af-4eec-441c-8739-020990d1826d@nvidia.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 19 Jan 2026 10:13:36 +0800
X-Gm-Features: AZwV_Qi7JTwzpifTzUsT3WZaxjMIWG7XKyTKlEHP1wda51mvxBoFRj7TX0oSS3w
Message-ID: <CACLfguUNRhc1nttaJOAdp-QGxbrySTT-yDRMCuyntEbj0Dpjzw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] vdpa/mlx5: update MAC address handling in mlx5_vdpa_set_attr()
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: mst@redhat.com, jasowang@redhat.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 8:14=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
>
>
> On 29.12.25 08:16, Cindy Lu wrote:
> > Improve MAC address handling in mlx5_vdpa_set_attr() to ensure that
> > old MAC entries are properly removed from the MPFS table before
> > adding a new one. The new MAC address is then added to both the MPFS
> > and VLAN tables.
> >
> > This change fixes an issue where the updated MAC address would not
> > take effect until QEMU was rebooted.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index c87e6395b060..a75788ace401 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -4055,7 +4055,6 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_de=
v *v_mdev, struct vdpa_device *
> >  static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev, struct vdp=
a_device *dev,
> >                             const struct vdpa_dev_set_config *add_confi=
g)
> >  {
> > -     struct virtio_net_config *config;
> >       struct mlx5_core_dev *pfmdev;
> >       struct mlx5_vdpa_dev *mvdev;
> >       struct mlx5_vdpa_net *ndev;
> > @@ -4065,7 +4064,6 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_de=
v *v_mdev, struct vdpa_device *
> >       mvdev =3D to_mvdev(dev);
> >       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> >       mdev =3D mvdev->mdev;
> > -     config =3D &ndev->config;
> >
> >       down_write(&ndev->reslock);
> >
> > @@ -4078,9 +4076,7 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_de=
v *v_mdev, struct vdpa_device *
> >                       goto out;
> >               }
> >               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > -             err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > -             if (!err)
> > -                     ether_addr_copy(config->mac, add_config->net.mac)=
;
> > +             err =3D mlx5_vdpa_change_new_mac(ndev, pfmdev, (u8 *)add_=
config->net.mac);
> >       }
> >
> >  out:
>
> Thanks for your patch. It looks much better like this.
>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>
Thanks Dragos
> Thanks,
> Dragos
>


