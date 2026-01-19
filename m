Return-Path: <netdev+bounces-250947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E57ED39C48
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 03:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 443AB3007C98
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 02:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038942367B5;
	Mon, 19 Jan 2026 02:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5y/nhA0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="klaga4PV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5979923370F
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768788779; cv=pass; b=b210C2djTan+0JL4Ef2d3TKk390tq1t+xO5CUA2DVx2DAtUYfkoGTkcXr2rnv8MZICuDDChXB1Ml2EAjn4LdWvKt/rCWzPr0Rj7UUzeLqeJKT92uBDtzaGE1I7c3KJpubXdycKDSkpDYr6AAA3IuZ+iRHC2ZkYQYkcTZy5XM1Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768788779; c=relaxed/simple;
	bh=b66rLIBiGJ7BwzeJ7NBVrWX0pCkBrP5xqopu/zP1v50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQWwBwVj7KhVEaqLoE3MoDc7ZriAQodg/jhfXtGI1bikLNeOMN8JD5/2ng8iHBmoVJq3MK4Zisf8Nz9e9xwbSLhPaqoSLFYNjKg3z5gAA61z+VsmOBZzDqTdCXUJNuU+pdDdy39SCo2hSCKdEKs2Bv0Vk8iOYnRULLCgRj+lXLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5y/nhA0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=klaga4PV; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768788777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7DbdTN7pF/npZpXEyk9hZ7zUr+KhydCm72fooIP7+FI=;
	b=V5y/nhA0zN+latSCNmyQQWsRafjD0QgIHaCriIEo0futq3o8BwA5XJzoeLa8PHH2i5X9fy
	nSLYJsgqBfV+7k8YfocNEiM6ZLEUYp2frROSx4u7Gcmz6DhxXf3caW3eJ9ocwVkfOXFSq5
	gvowaPe5XG8Q4JS/4ybDvkc3VDuZ9eI=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-iNB7Y4RtMe-nosodoPEjfQ-1; Sun, 18 Jan 2026 21:12:56 -0500
X-MC-Unique: iNB7Y4RtMe-nosodoPEjfQ-1
X-Mimecast-MFC-AGG-ID: iNB7Y4RtMe-nosodoPEjfQ_1768788775
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-93f57d3a1acso10804971241.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 18:12:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768788775; cv=none;
        d=google.com; s=arc-20240605;
        b=A6yg9S/UzAgXTcAX8TN15AOw25qjxDMFbLOR8tQwtck6LhvlcCRHNAQ5s3M9zQWiDy
         PBGYLW6ilLlmxofLqnmXg0+ZqmWdYG0zpsCMt32bNrliZpB3uiPmDioG48NnDTYR5MbU
         zpLKWd89j58ghZnc+nHj/SCFtF9ZvJ/Ci4FhKq0LNA6Kp6/576HiebwPAVUNZXDUmOua
         LxOiT3macigQXxWQEqIMnR/oQJ/8RZqKM4/2M1QcrXuI3/ucAZxuEP4nNrlXrWYqP8ce
         2gNc5kCW78/i1QuqwsLJ6xz5Loxg6qNGFTGy8FJ2fHNuxSyUi8+KvYnKdvv9MrVULnky
         bwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7DbdTN7pF/npZpXEyk9hZ7zUr+KhydCm72fooIP7+FI=;
        fh=V8IU9F23YBLpFwwy0SevZESWWzWqtq7JxHjLH8Z3ZCA=;
        b=hIjqvR9j/MOXSRqZRrRIAFeJzr5cfYVkx0iit9P4rZSwXym5od3OSt6JhOB6t5e8ri
         auVSf2DoSvKPskLqEaWpB7gtC80no8EgfcSoMuwhIe54PBY6tdVYXvqekGSngOMDEoJH
         bTNpSWzRiTAmXWY3KKAGQeiZRNei99WTmoF3YockOk8mCzZq5wYFWiPs9aU0uwVyYVUX
         k9HeszjuiOmviWPYuDSiAnaViWJOVunHp0tPVL1Je3OdpPlHV69yJJtM76jNc+Jv2sub
         ekDOt9Mup9+D9h3+A48U8ENKwxj+VmR2S+iPK7n4dFI4ncnToR77h23cR3RPe+DnqPXO
         EpZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768788775; x=1769393575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DbdTN7pF/npZpXEyk9hZ7zUr+KhydCm72fooIP7+FI=;
        b=klaga4PVCP4/Kkj+TF9R0iPnH3LyN9pz1qQtlwrIBP+QdgMS/L7pgd8Xa7EgHywmza
         hj0sFZx0dpQr9tvgjYG9FGYBBoqjNPiTffTp+F2vFvPkBS1zbOz0Mf6ipaDOsj0R3Apk
         4jgM+BMMNRE2oJkG8npwBuPhnwMUxE4OCwb/P5ZqUbD03lqhjfqzFESFedYQBbYT/kcu
         4dcgGPHIJRt6UnJ2ZZ/Yb1q7S2h5YbtxqizmNkKppE3J4kG9h7yVc1o7sz7u20Cg3xRN
         ND8ncdammANzh6XKLRxx+zYhCO9QSfLP8Dmq+X34cC6VUKKlNeLusWD3wzJOLuUx7LKe
         3y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768788775; x=1769393575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7DbdTN7pF/npZpXEyk9hZ7zUr+KhydCm72fooIP7+FI=;
        b=bZVZixlr4XFry5ZCe8N+kTlYPGuNSyKvxeeA426EblM1e5mYvQsUrqjXt7/i/TI2d1
         v+RC+1UGSy7vLkQ+i5+qltdIjP0/1bp+d/LipEv9IZ+2GdapIY+7izxVR6agE5MMG3oV
         IJmDtMb7CWhYVE9EDd1/4LDe+3RZhFtI3EMphTcXQAz//CkLFkQ3aNm/9Tk52gYXX3iS
         Wah0SC04oi4K5DxI29mkSVkxgDvrODm4eAmPL7qgI0jvt3f37hafPHkbtLOotvFQa/EV
         wYjMzykUKQf9ymNKBVQNGnYdkTsqYZwjdZOezIKjdq1brj3nksXYUCYPtg6eeYQX/yAJ
         CWFw==
X-Forwarded-Encrypted: i=1; AJvYcCW/OAw7rPlb5lmUSo1EcpICeCvLjo0m0VMQbuaahfz6N+sNeDAMu7Zee0+5tKb8De73pFHX5fY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsyc1qgup4bGGZVjdLRLX48mjyg/gsxc0sp1fBKKSik4oz4ZYk
	F+AGMcU7LR0VoEhrk/9kKsDTHVxmRl+PVkrtqMFzy7uozXbNTT0w/O8eJ/wFymFMJTVFSj4xq8M
	Yzu1roJf4MYGWeqSS3VIkcLlaYMEujBcS8NRpQY64mwoVQllP98AGPhzlAQ7waGYuHA7TzuWGai
	4wwzyi07JDmFC8p7wonMQW+csPqRx5iEz4
X-Gm-Gg: AY/fxX4IBxRRWpPogGvmP1Wfd+FTTFl4zI/UIaTgJ2jHUOT9awRZJQSmnKkYuqyMjKs
	k0U9I9iCNegYbIMnEfTjQGYTB/am1IgKHMJ0glWPUMkUEKJq97XE3ycEKfJrGqFOqv7Spo6Un6s
	hQpA0ZvmGDl3UOr3/N/JGlaSTrEBzXM+ktvZEjfLDRLOPsLXqCcCRdBw2PNNSzeVwI4RQ=
X-Received: by 2002:a05:6102:3f4a:b0:5dd:b0e6:c4cb with SMTP id ada2fe7eead31-5f1a4d8d33amr3253348137.9.1768788775616;
        Sun, 18 Jan 2026 18:12:55 -0800 (PST)
X-Received: by 2002:a05:6102:3f4a:b0:5dd:b0e6:c4cb with SMTP id
 ada2fe7eead31-5f1a4d8d33amr3253337137.9.1768788775314; Sun, 18 Jan 2026
 18:12:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229071614.779621-1-lulu@redhat.com> <09178761-3ff7-4c6d-bdf4-cbf16531d71e@nvidia.com>
In-Reply-To: <09178761-3ff7-4c6d-bdf4-cbf16531d71e@nvidia.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 19 Jan 2026 10:12:16 +0800
X-Gm-Features: AZwV_Qizwj1EMviepQfrW3r56R4fRHe-HzedcvdMLGJBJgU0YPalMF59laPuV2I
Message-ID: <CACLfguWDQ-NqNV6w2BAGQS_fA0+ADhVVOJbzDC+rt4u8Trhu3Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] vdpa/mlx5: update mlx_features with driver state check
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: mst@redhat.com, jasowang@redhat.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026 at 8:09=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
>
> Hi Cindy,
>
> Thanks for your patch!
>
> On 29.12.25 08:16, Cindy Lu wrote:
> > Add logic in mlx5_vdpa_set_attr() to ensure the VIRTIO_NET_F_MAC
> > feature bit is properly set only when the device is not yet in
> > the DRIVER_OK (running) state.
> >
> > This makes the MAC address visible in the output of:
> >
> >  vdpa dev config show -jp
> >
> > when the device is created without an initial MAC address.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> Having a cover letter with the summary, history and links series would
> make the review process easier.
>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index ddaa1366704b..6e42bae7c9a1 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -4049,7 +4049,7 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_de=
v *v_mdev, struct vdpa_device *
> >       struct mlx5_vdpa_dev *mvdev;
> >       struct mlx5_vdpa_net *ndev;
> >       struct mlx5_core_dev *mdev;
> > -     int err =3D -EOPNOTSUPP;
> > +     int err =3D 0;
> >
> >       mvdev =3D to_mvdev(dev);
> >       ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > @@ -4057,13 +4057,22 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_=
dev *v_mdev, struct vdpa_device *
> >       config =3D &ndev->config;
> >
> >       down_write(&ndev->reslock);
> > -     if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +
> > +     if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +             if (!(ndev->mvdev.status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> > +                     ndev->mvdev.mlx_features |=3D BIT_ULL(VIRTIO_NET_=
F_MAC);
> > +             } else {
> > +                     mlx5_vdpa_warn(mvdev, "device running, skip updat=
ing MAC\n");
> > +                     err =3D -EBUSY;
> > +                     goto out;
> > +             }
> >               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> >               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> >               if (!err)
> >                       ether_addr_copy(config->mac, add_config->net.mac)=
;
> >       }
> >
> > +out:
> >       up_write(&ndev->reslock);
> >       return err;
> >  }
> The patch itself makes sense. For it you can add:
>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>
Thanks Dragos, will add this
> Thanks,
> Dragos
>


