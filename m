Return-Path: <netdev+bounces-113879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C7B9403B6
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 03:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD6C1C222BA
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 01:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240198827;
	Tue, 30 Jul 2024 01:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjbpV/ti"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643B68C0B
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302959; cv=none; b=umJGXbi5R2SI3zBEd0LK9xz+3TUS/ON9MGh7P1ClRNkIpwP8WCZI/GBXvPe7ZUpUBl9PjqmQj1gYdr0du4Zwqyn+3zyLg8LvuIOV/D5KzY0i2UyLfIbphGlOwVFJ0V7Y9axWY0hR4CRfa6hqwLi25QAhPBQDp24ZSIOsFV2hD4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302959; c=relaxed/simple;
	bh=6V2Eg0+AV6C5wE2oxMFjIOKPbugqLyq7K0dfTJQYrkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdDbQlNTynChddQ6GcVPDwmEnoWJPdh8sXbRrnfl9xbG/PNYpz/KW4sRtlWGZmrvQFPMOqMqt30BnA1Lff6/VItLwjo+J/F81+kzyoQbmSJRaFD5/5qQxEre9LeEyHSErzy99hh+S31Wo7nKFLsncP5wgkQyYenxH2S71SXC1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cjbpV/ti; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722302956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7worZc1WoS5CXw2Mg6pRcBJ9Od3yKPnwBVoMm0OgZU=;
	b=cjbpV/tiZGvODTayr3j4CoXyfisOtLhAP72sMGUo6+kGpIwVwOc9SQ1TnPi28SaWdqh6qP
	RKLg4V4YKyOG9CDt8v4sIG5mbwQQ64bdVrlhBpdTXjjqU/u4CKj3xQjzvtJI8ZVJGytuLB
	CiudeAMWH9FwWwp3SR8vec/kj17foRY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-eAoZaaQjOKir9ma00WPmGg-1; Mon, 29 Jul 2024 21:29:14 -0400
X-MC-Unique: eAoZaaQjOKir9ma00WPmGg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5af786d643aso2570368a12.3
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 18:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722302954; x=1722907754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7worZc1WoS5CXw2Mg6pRcBJ9Od3yKPnwBVoMm0OgZU=;
        b=e+Fb7ztBTNVhdpfsiJgMm4AkQXw5tTz95Id/cDfuLx+l/g5mzDkmibEmgJ7O49TU/h
         URaAUOldB99YHBtuOhgzkZHPxCmSRxU7oJy+kRO2X1G7zBdky5tOYH3W9RcJOLScQOgy
         /8GURXe7gBJdTSg2903llkWV/hyIEou6MH0dIFFBU4rUjXW8a3OpQ57h5GGdgwbxIXJ9
         wU0djG/H2gBSLMHfl/qA5lkobDycg2U69DhvFl3rKe9avOxuL18NyS96SV1TJgqJ3cvc
         hW5i5fcbKSehXX6THtjSHxYRAzlyCTa/2+FaH54+tGWM+o2iexrnKpneKeunPseO0rMz
         Wnmw==
X-Forwarded-Encrypted: i=1; AJvYcCVko27I+PzHy9aSDauM3hDzT2M5TcFZczT1AhX6kOTeuZoOJik7HgIojE0LWlAV2mnJ+6Bvy+CKKk8lEFz+1ur4zOevlYP5
X-Gm-Message-State: AOJu0YwDZjVrKw4Yg+rDpsCuLjBEn9EavPL4hAm1B1Q5XeNcnPbVK+m7
	tEiqUd/rE4CZ6MBZ9g+SVHGThPUY0e2fBYrqa9ON3N/H/4g2YcosTFP5aBTRllQ9ruSTWVeDFW8
	scni07tcmwciKZfO5/ZPcLnuLWrOwVWysDjt2UQzj4OnloFK1Bo59rQ7qnARduCLcsiEHCkj5+O
	zW0ILwqERQDJ0V8RDBmv9gRXYcKjg1
X-Received: by 2002:a50:aadb:0:b0:5a3:3b44:ae00 with SMTP id 4fb4d7f45d1cf-5b020ea8945mr5859946a12.20.1722302953773;
        Mon, 29 Jul 2024 18:29:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLuOO7m5Qr5P8MSrVRUXIug1lSaQ0AKlobOKhsrzfg5Qpeu0JjwO/i2NWbI/Rn9Tgkhkq9CAnEijp0eyxafS0=
X-Received: by 2002:a50:aadb:0:b0:5a3:3b44:ae00 with SMTP id
 4fb4d7f45d1cf-5b020ea8945mr5859930a12.20.1722302953410; Mon, 29 Jul 2024
 18:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729052146.621924-1-lulu@redhat.com> <20240729052146.621924-4-lulu@redhat.com>
 <aa0ffd28-bfb8-4b25-8730-a522861bca98@lunn.ch>
In-Reply-To: <aa0ffd28-bfb8-4b25-8730-a522861bca98@lunn.ch>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 30 Jul 2024 09:28:36 +0800
Message-ID: <CACLfguWt1Uw=tpKCViz9+Hv-s3EvuAc6YeHP3yWYtg6tnuC9Hg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] vdpa/mlx5: Add the support of set mac address
To: Andrew Lunn <andrew@lunn.ch>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jul 2024 at 03:16, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev, struct vdp=
a_device *dev,
> > +                           const struct vdpa_dev_set_config *add_confi=
g)
> > +{
> > +     struct virtio_net_config *config;
> > +     struct mlx5_core_dev *pfmdev;
> > +     struct mlx5_vdpa_dev *mvdev;
> > +     struct mlx5_vdpa_net *ndev;
> > +     struct mlx5_core_dev *mdev;
> > +     int err =3D -EINVAL;
>
> I would say this should also be EOPNOTSUPP.
>
sure=EF=BC=8C will change this
Thanks
cindy
> > +
> > +     mvdev =3D to_mvdev(dev);
> > +     ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > +     mdev =3D mvdev->mdev;
> > +     config =3D &ndev->config;
> > +
> > +     down_write(&ndev->reslock);
> > +     if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +             pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > +             err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > +             if (!err)
> > +                     ether_addr_copy(config->mac, add_config->net.mac)=
;
> > +     }
> > +
> > +     up_write(&ndev->reslock);
> > +     return err;
>
>
>     Andrew
>
> ---
> pw-bot: cr
>


