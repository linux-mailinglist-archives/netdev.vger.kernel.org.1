Return-Path: <netdev+bounces-110133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D9392B12E
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 09:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D231C21874
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 07:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038471474C8;
	Tue,  9 Jul 2024 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1CEYsHP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEBA14374C
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 07:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510448; cv=none; b=iuDX4DxGohYYbSMKc11Ph/r+ZQW23H5Wmzq4B9SwvMdtNDQVKW9rptZlF2B2YtVZEvOXdBikWs1WisQj+YH5pFcrNCFOs1jrZ5sJmIsJ1kXd5qDrcpQyx9iw2deDXr4Zut81t6usiCdJrDu8lpyKeDyNrbs8fBJJNX0AdvWBOCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510448; c=relaxed/simple;
	bh=LvqwmV+mNj/O+PlzBMrEoMU+zBOGk4FC9h2Eald0y+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anDCnqeI8iNVHA44nLZozEx0iVEc7Co2QD1OYC9ciJC+xM7qCCPtU+NbrCmRIFIiut7ALaV5TN24MWSlfDIs5FnJHq+VgIWO1b/Wfz5IHhxPcA9uE58aouMcctAgfKKRfak/cFoCm45wH90AbBwwErhtBvahteuUwutiq1rqkSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L1CEYsHP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720510445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyffXFQ4XqEgnJu8KLX3RdgOxyAi68j9TS2gHHyn3kA=;
	b=L1CEYsHPe2ZF9HEb+uPu4Ksq9aMzbmKXPe4h+p1Mn7Nr88wAYR4um2r2Otio5A6Pp6E4o4
	CDQJj21CKH1IvC16+Wz1TmEHZ8/FRFL0ADVxQIbdU5HOrFy0qPdeBSCRPGIO+LxS/URTnS
	MFPzaEIiQDTXVIQ+bzmO0cWRqV0QIKg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-uG25rSI7P6Ce0I5i0LI9Xg-1; Tue, 09 Jul 2024 03:34:03 -0400
X-MC-Unique: uG25rSI7P6Ce0I5i0LI9Xg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-58c4f94b57cso3541916a12.0
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 00:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720510442; x=1721115242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyffXFQ4XqEgnJu8KLX3RdgOxyAi68j9TS2gHHyn3kA=;
        b=e9f+5sdTTWNFNrfgTCfFt3lU44PIpiTpWH0t3rp2yRNnbJGlGIJFVvC+hql3DR8PZ5
         vi65t2ekCIT2SXPzwalxR2BL1VCbKMuwde4zuTZXRKc1irCI87o1RXPMNU01QJYrBMh9
         1dlcmX35x07BO4fqy8oIqtGQQqyTaMyKRMGm090xd1+xKNuVGRoEi80ymcMoHPcEB+fJ
         yc0OuaQDQtgs6fMlp+CKf2B4Y8eJtfbj4g7dqcgm96HmPHP5k6GsFg9Ie8VFkwQ98oaw
         bY0WC/boy/VyzDUgRWkNFPRdTdL5afbTJMGipdwkj55hyBo2fEFdIibj1gO0yvHlhzlX
         BKQw==
X-Forwarded-Encrypted: i=1; AJvYcCUOTCajN5Y2qPTu8tF8MkxqdktSv7PO8MZvzqlI8qDBbi3gEygyEi54UIyE4PBhhJlZ9+KxuVd9LcBkSPY0tOMXqL1DoPdf
X-Gm-Message-State: AOJu0YwE+EF3Vbnz9hsUU9y/waRiypJ8JrH0nHOPu6hvztuwpm15YE7D
	WdDrj/LKsrrmBGrbPKsJycB/CxkKqru6Cz5Mp6S4bV7WIiKvyD/ybzPHNTWpFtOCnqRlL1+gcqL
	5LS+sxJTfIpUScgAbNEEJuMvg9/sOTJtqu5zyIdOfc1Qu8OxPblC7WrwiV5v4yEeu+hoUjcLvr9
	jEhnqgld8SRoF1WG/zvY2sGA8T5Epi
X-Received: by 2002:a05:6402:651:b0:585:4048:129a with SMTP id 4fb4d7f45d1cf-594bc7c81camr942124a12.31.1720510442198;
        Tue, 09 Jul 2024 00:34:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjoc+fuN4z3jm6ivmOtDkLQnowZY0KxQCfvPi77uB0E9RhW33K2f9f+5Byd3P6tUmj0kBE7NSAeCnMjiI2G34=
X-Received: by 2002:a05:6402:651:b0:585:4048:129a with SMTP id
 4fb4d7f45d1cf-594bc7c81camr942110a12.31.1720510441792; Tue, 09 Jul 2024
 00:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708065549.89422-1-lulu@redhat.com> <CACGkMEtOP_Hz=SO+r5WQfWow3Pb-Sz552xnt0BqTgyGSuvJz_A@mail.gmail.com>
In-Reply-To: <CACGkMEtOP_Hz=SO+r5WQfWow3Pb-Sz552xnt0BqTgyGSuvJz_A@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 9 Jul 2024 15:33:23 +0800
Message-ID: <CACLfguWqut4mf1=ad58Eb=HZCMnbgxzDk5DbFge-JU0beB1aFg@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Add the support of set mac address
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jul 2024 at 15:03, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Jul 8, 2024 at 2:56=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Add the function to support setting the MAC address.
> > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > to set the mac address
> >
> > Tested in ConnectX-6 Dx device
>
> Great.
>
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> I guess this should be part of the series "vdpa: support set mac
> address from vdpa tool" ?
>
yes, Will add this in next version
Thanks
cindy
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index 26ba7da6b410..f78701386690 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3616,10 +3616,33 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_=
dev *v_mdev, struct vdpa_device *
> >         destroy_workqueue(wq);
> >         mgtdev->ndev =3D NULL;
> >  }
> > +static int mlx5_vdpa_set_attr_mac(struct vdpa_mgmt_dev *v_mdev,
> > +                                 struct vdpa_device *dev,
> > +                                 const struct vdpa_dev_set_config *add=
_config)
> > +{
> > +       struct mlx5_vdpa_dev *mvdev =3D to_mvdev(dev);
> > +       struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > +       struct mlx5_core_dev *mdev =3D mvdev->mdev;
> > +       struct virtio_net_config *config =3D &ndev->config;
> > +       int err;
> > +       struct mlx5_core_dev *pfmdev;
> > +
> > +       if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> > +               if (!is_zero_ether_addr(add_config->net.mac)) {
> > +                       memcpy(config->mac, add_config->net.mac, ETH_AL=
EN);
> > +                       pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pde=
v));
> > +                       err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > +                       if (err)
> > +                               return -1;
> > +               }
> > +       }
> > +       return 0;
> > +}
> >
> >  static const struct vdpa_mgmtdev_ops mdev_ops =3D {
> >         .dev_add =3D mlx5_vdpa_dev_add,
> >         .dev_del =3D mlx5_vdpa_dev_del,
> > +       .dev_set_attr =3D mlx5_vdpa_set_attr_mac,
>
> Let's rename this as we will add the support for mtu as well or not?
>
sure ,will change this
Thanks
cindy
> Thanks
>
> >  };
> >
> >  static struct virtio_device_id id_table[] =3D {
> > --
> > 2.45.0
> >
>


