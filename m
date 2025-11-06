Return-Path: <netdev+bounces-236181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03377C39723
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 08:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 002774EEB30
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 07:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080CE2BF006;
	Thu,  6 Nov 2025 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlvNuIkR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgoTFtWX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5189E274B48
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415299; cv=none; b=B5LWh8IMt38a3mY7yxYr+xN3uhXNe9pnT+lEv6DpQtwAhZTnklRRgwRF/K3/RgCjocF3NN7y+qlGel8dGuZkKBYGw1J4HKYricUfG8uHjhtwse7y4xswIPMwGulgS8aqzpWRAxDKinTcL0uLNW8svq6Y9zRX/mUMow3XGWgiYQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415299; c=relaxed/simple;
	bh=utxQjgvi47PYdkifSJDqv0O9qHP5x/EM/RYN8U0WxeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RviF3J+3A6tmUC7RGGyUgR73+qIfTItiKlWkCP6CyoZ0+5TKweRuwdaqnIfaKGeWKE6/XbyMEqKXCBLYyxYPAlqqcFYv3C5cjjeo9s996jYJm/Iqv77WD2lBOLdEB3yGD47F5Z3pVRLbuQEZ/rqAEq7BLkEWLG1NRCFQNEVCY1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZlvNuIkR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GgoTFtWX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762415297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CnJC3i9GUtLtZtx9qzqc96Wn1X4xgc/30U+djyUk6hY=;
	b=ZlvNuIkR47RfxAWDaXHDj8RBUg/mkAy2wdLiC/OqdbGzBb5ltL3lFySJnmjlJQ+Kb8hOrO
	VEURZj32NrJghfJOv8fN5xNiReMUhclqxleONA7hjVzIuRPlfJxLRWagZokJbEveaqUVdH
	T/vAAd9CDZBkaBAZuZhuqmLcWl8Qs40=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-EyQLqO4ZOES0nX8f5QTC8Q-1; Thu, 06 Nov 2025 02:48:15 -0500
X-MC-Unique: EyQLqO4ZOES0nX8f5QTC8Q-1
X-Mimecast-MFC-AGG-ID: EyQLqO4ZOES0nX8f5QTC8Q_1762415294
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5db20a27ee9so349672137.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 23:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762415294; x=1763020094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnJC3i9GUtLtZtx9qzqc96Wn1X4xgc/30U+djyUk6hY=;
        b=GgoTFtWXTd7gZRPNZNZ8FAK9eVXKRlvwqpIOrNVHrDRt3h+H5dz4BayckHaJp86FXf
         5NUlVZ2Rg3LntYBQZd+Z1RFcQf3YjvcAGi6bDxwcuXIEw2wNl3xD+lTKI+7rCVkm4Bm2
         rBAs9hP01foan93ws7k295gTWklRsp9/VKi+JDnX4SkGElHmzc/EMx3MrfWJfGqP/96z
         02tVhBaXGo/Nxf8pUubvFCyj47DfHnXcjqbfm9X7YcVC4yAyavuT4Z62TQj5rScWPkvy
         eGnd1QR1ZvJKHsyrHo6Glq3Ixe0JvFXHKyXsrgqeJyfqyPqjbzcBfOzCHE2basCSLLH+
         NIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762415294; x=1763020094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnJC3i9GUtLtZtx9qzqc96Wn1X4xgc/30U+djyUk6hY=;
        b=w6hnfq8MzhvSbxkOPgaZOAXxQnWoYSey8NptKz2IKYNPdDMZ8U/HRU5IcCiiHMmQRj
         P5L7TWigmL+uoLESCzuPgg5VRohtk0WPsOW9vh3Zpn5fniq8Xb+SEZzGrNObdhc7NKw6
         UZo27tQNQlx9hzzaAVLkjoWtrKea4n5bNIK5pBjr8vt322HXiMgLPK8PhH6Vr1UfbZRG
         uzGa7UvQUlmJMRtBEigVPL6Fo1tnZyoIm0TNEwZ8vA7tcdjU4LlHqWyjiGt+EoUOoLvL
         pHGcB228i5SNrPeGjSzcBQ7mV8rAKMOTENqXrwgHiS1YZcRg+o2jHIpGHXIWL6mPFi4Y
         4ObQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqsZAR/gTt2WiqRz/fKqmWQDMWGC7JOocNZLE7MG9LmP0OxYRWmkdiLgsLjCF2hxvV2LL0uLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/xmf8i8gVRn4ZE9pe5DKQ41wovbiR769368GhnGbtAN2dEl0i
	zN7q7fa4+wmBVGPiS4iC/ulgdQxYl/7PMmL4c8EIGBS6BLNKtyw7H1XXiBp/qrtRM6RACdt3oZF
	81WzBJ/uQ+LS0SFeLx1qcpLB2zWX1Xj1UbwPT38uLjQ8MUGe073UxDvzaZu9CGPx7JJ7AoD5R8b
	m7wBclPrBZ9c7H+FjO6tBWhd+nEet/9I1S
X-Gm-Gg: ASbGncuqbnKFov6A67CAssMJ/Eza23Y9ZOfX9iVWrRNh9UFaFVOFy9yfDpwdWvGjY+z
	6aca/xVP6wz/MKFIldFPjMGCVPx3p5IxEf8jzXgzv85koV4QZkZiYMp0eKBmOPpQpWnLOgbOAtn
	EQukMheTV/MJHdWu5Ccgl8xVN2UzmhFvV9S73wumZX/j+sjBKU0nTIjszE
X-Received: by 2002:a05:6102:5490:b0:5dc:51c5:e3c7 with SMTP id ada2fe7eead31-5dd894c35ffmr2105512137.26.1762415294398;
        Wed, 05 Nov 2025 23:48:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaHvOwp3yRcJdiplcZBh+ZekqeMFt4UrhXQvHFpGLbTZPXBEUYvgOe0WgV7DfP1t9bX9QOMxsHfqFGlqrS6Ds=
X-Received: by 2002:a05:6102:5490:b0:5dc:51c5:e3c7 with SMTP id
 ada2fe7eead31-5dd894c35ffmr2105504137.26.1762415294061; Wed, 05 Nov 2025
 23:48:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105080151.1115698-1-lulu@redhat.com> <20251105080151.1115698-2-lulu@redhat.com>
 <qfswutrrnmk6cksyamjx4ywv4kkxcb76vfqqszodzo7ltze5r6@c2dsseiez4ik>
In-Reply-To: <qfswutrrnmk6cksyamjx4ywv4kkxcb76vfqqszodzo7ltze5r6@c2dsseiez4ik>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 6 Nov 2025 15:47:31 +0800
X-Gm-Features: AWmQ_bmq49ZgsPINEs5Pimr0WRd1izcH6HyxicuyWqewO5LqB7r_2LjC3IeC1oE
Message-ID: <CACLfguUL39gt7zoUzsT_vypJYSAqcRBkFX-w_wtWrrFrx1aLNw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vdpa/mlx5: update MAC address handling in mlx5_vdpa_set_attr()
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: mst@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 6:13=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> On Wed, Nov 05, 2025 at 04:01:42PM +0800, Cindy Lu wrote:
> > Improve MAC address handling in mlx5_vdpa_set_attr() to ensure
> > that old MAC entries are properly removed from the MPFS table
> > before adding a new one. The new MAC address is then added to
> > both the MPFS and VLAN tables.
> >
> > Warnings are issued if deleting or adding a MAC entry fails, but
> > the function continues to execute in order to keep the configuration
> > as consistent as possible with the hardware state.
> >
> > This change fixes an issue where the updated MAC address would not
> > take effect until the qemu was rebooted
> >
> Can you remind me how you provision the MAC address throug .set_attr()
> instead ofa the CVQ route?
>
this mac address is set from vdpa tool,such as
vdpa dev set name vdpa0 mac 00:11:22:33:44:01

> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/=
mlx5_vnet.c
> > index e38aa3a335fc..4bc39cb76268 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -4067,10 +4067,26 @@ static int mlx5_vdpa_set_attr(struct vdpa_mgmt_=
dev *v_mdev, struct vdpa_device *
> >       down_write(&ndev->reslock);
> >       if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> >               pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > -             err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > -             if (!err)
> > +             if (!is_zero_ether_addr(ndev->config.mac)) {
> > +                     if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)) =
{
> > +                             mlx5_vdpa_warn(mvdev,"failed to delete ol=
d MAC %pM from MPFS table\n",
> > +                                     ndev->config.mac);
> > +                     }
> > +             }
> > +             err =3D mlx5_mpfs_add_mac(pfmdev, (u8 *)add_config->net.m=
ac);
> > +             if (!err) {
> > +                     mac_vlan_del(ndev, config->mac, 0, false);
> >                       ether_addr_copy(config->mac, add_config->net.mac)=
;
> > +             } else {
> > +                     mlx5_vdpa_warn(mvdev,"failed to add new MAC %pM t=
o MPFS table\n",
> > +                             (u8 *)add_config->net.mac);
> > +                     up_write(&ndev->reslock);
> > +                     return err;
> > +             }
> Code reorg suggestion for this block:
> err =3D mlx5_mpfs_add_mac();
> if (err) {
>         warn();
>         return err;
> }
>
> mac_vlan_del();
> ether_addr_copy();
>
> >       }
> > +     if (mac_vlan_add(ndev, ndev->config.mac, 0, false))
> > +             mlx5_vdpa_warn(mvdev,"failed to add new MAC %pM to vlan t=
able\n",
> > +                            (u8 *)add_config->net.mac);
> >
> Have you considered factoring out the MAC changing code from
> hanle_ctrl_mac() into a function and using it here? Most of the
> operations are the same.
>
>
Thanks, that=E2=80=99s a good point. I=E2=80=99ll update the code.
> Thanks,
> Dragos
>


