Return-Path: <netdev+bounces-236182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E654C397A1
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 08:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFAE034E859
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 07:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDC22FAC0A;
	Thu,  6 Nov 2025 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7n9jRdD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="geYYbVLY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FF72FA0F6
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415977; cv=none; b=OETphXdUf+eUwuZg3jok7v3cEg/4/b3T7k1K2YonU6rCg95d7JGAMAhR73OM7x9mfPJrdQxtEXgNa3wy/WFL+HnPc8h8UkESop/QlFet80IgCOagMLMgUxq4fv3HkSoK9QLffIUutLsgqochUx0GPd7/mMyUt7ViI9fXAT++zwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415977; c=relaxed/simple;
	bh=+HFp5teyxBDg8jC+Iw/Ud9wGGwCABYXLJqBhAplJgPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hf17FjixO7EtWpzjBaoeTxs7DAin41BKfKpwR8ZPsGPQvmrmF3MOSKAT4oEgDMTdGsWlDCBNCcitJ7ucP2H7r56P88aFgD7qDQr+dajqJmivnYQnviQVCYFVYmEG3LzlSbuhmOE8YCwsoNjF2WuEW9P2Ws6BCZLgnNFXLtuQ2nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7n9jRdD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=geYYbVLY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762415975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9OQ1T7JKFRO66U5Rzh5RNwPuFMaB1j+5Hb1k3YmuMzw=;
	b=h7n9jRdDRJLTAjUkIF772ZH7P1QC170GJsO60rxy/wBQsN9lnXK1zhENEydI8sGtaFAvCM
	1pLOI2KHwfRDe8HllCGs20kxfF+OkjxmI979eidf1XTt1IgExHCU1C6oSvTZL0eKVFgw4s
	49CD2au71CybevIA34CQz2yWHYLUbCc=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-99Elr0EsMumjX5wzwbf7lw-1; Thu, 06 Nov 2025 02:59:33 -0500
X-MC-Unique: 99Elr0EsMumjX5wzwbf7lw-1
X-Mimecast-MFC-AGG-ID: 99Elr0EsMumjX5wzwbf7lw_1762415972
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-930dc545b31so56171241.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 23:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762415972; x=1763020772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OQ1T7JKFRO66U5Rzh5RNwPuFMaB1j+5Hb1k3YmuMzw=;
        b=geYYbVLYnNISL1H4MuRXTIjg9Js4zGAiA26yT6QPT1sYteaGQy69ZzvwklOkruozRL
         UbEcre0X/4wuzpqU0QwhtAvyQBjCZuXSfJBMrCu58cM9CdAdFqSCxMKe688NNbvVN9j2
         T2iwYS/pD9fQUsEwm3uB9lVSJDzkB2bCXZ+z/BAB13qwricfWifBowW55bSb0+sKfR4c
         5G5fWSGiD0Mv4pTgXwH550txfosWWHctlG0y1A1UzjHwmNP5IDpg+c//NMOLovF7CGOO
         KTya+AbbAtJv/idZRw+pU7nipij1KFqhMdMPhKDivzB0TFhzInp+vDo7j0BqeimRpeOn
         /XVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762415972; x=1763020772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OQ1T7JKFRO66U5Rzh5RNwPuFMaB1j+5Hb1k3YmuMzw=;
        b=OtBwDtOfXTaf4uZ0yaC9zvfJbJh/YrkZ7BTokEc91p5HWeyOvDoefRo7d1pWzOkbQD
         lM82xFgcE7oZA0U+RuRZjgJmmYwMD8rUPMK4NDhruXRtebm/g7nrJxI9NWadYE36lYAn
         MTwG2yhXiywGzXiw7n3M63RJsnAk30UIkrxar6nFK/7vKY7ZGTRHZZ//T70anKKtoRS/
         QWmdK70wbkZbAX1/1fIwEwgpp85Cwwn9YEKC87nxVMIb07JqnDO080GN+4lhglMGc3yD
         GzYQpFPJexoQW7ZKShkRG/Qb78dy+o8ODqKiTk1CzDdxTI80komjoayjFumuvglQhhMO
         hpYA==
X-Forwarded-Encrypted: i=1; AJvYcCXXLvkjSxNF12/Gb57trI2fGHZ3r3zngWOAejp1RlTOnaZ8mgnCfk88+56NQRzp+1IZjT/KcvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIYM6P5JClIRb2h+wan8T02EHDHtgEJbd6dFuVldj7rNF1+91K
	ntuLWklmx8uJkRWcfOn2yXRXEQwHARMgx229Wf+t7y6vYdgY0OzitLy4d51OT1v055ZjBiklMnQ
	n7IGu186SCpGv3ngzg7y2met7XwR6yEcqG62jcd1jmxLl6DR3ikldi32MLn5f0gBJAv2GGwTKyn
	aq68z9AAVQoC/Ybp1INvz4+4m5dGPFC/qx+RiaWEnbVgM=
X-Gm-Gg: ASbGncuIyu/FS65ejpsUCipFKqTrEMwdjOq0PN2gAhvJhJK/iODEVQqQYCHE3sy9xC0
	Iprl10v01oAwbEEFKTAaSNhl5oQ60RxzVPWvo15Ti3h2BAqJpMfk9pDxwUSkJzYpVfrfg/injxu
	VzEKNr1yJAWjcrIS+zFx054z6Yl2T9RLW/cKSZhMhL+lonnfrRBOWIbEN0
X-Received: by 2002:a05:6102:2929:b0:5db:f9df:34de with SMTP id ada2fe7eead31-5dd8920ba8fmr1896820137.23.1762415972366;
        Wed, 05 Nov 2025 23:59:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3y+j0Qkz+bU++xXKWMhgu+xZDmAkoz+uj4iKjUkfpaG45KgV6Bd99eebvGDTo7Wl7cf1YQ7k40zBEV9g3T04=
X-Received: by 2002:a05:6102:2929:b0:5db:f9df:34de with SMTP id
 ada2fe7eead31-5dd8920ba8fmr1896812137.23.1762415972015; Wed, 05 Nov 2025
 23:59:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105080151.1115698-1-lulu@redhat.com> <20251105080151.1115698-2-lulu@redhat.com>
 <CACGkMEvdjE+bYxS5_XPEnKWR1sQBuq=6CAqjioto6enryKm8kw@mail.gmail.com>
In-Reply-To: <CACGkMEvdjE+bYxS5_XPEnKWR1sQBuq=6CAqjioto6enryKm8kw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 6 Nov 2025 15:58:52 +0800
X-Gm-Features: AWmQ_bn7aRMESoWH1MH-rtiOYr4zIjpmOWnGluH1naEda3Sb2UdEGholcLuo-pc
Message-ID: <CACLfguW7=HEETEcpYgb66V0+Frn8LYgvDkWo3-RfA7+e273Rxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vdpa/mlx5: update MAC address handling in mlx5_vdpa_set_attr()
To: Jason Wang <jasowang@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 12:11=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Nov 5, 2025 at 4:02=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
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
> >         down_write(&ndev->reslock);
> >         if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
> >                 pfmdev =3D pci_get_drvdata(pci_physfn(mdev->pdev));
> > -               err =3D mlx5_mpfs_add_mac(pfmdev, config->mac);
> > -               if (!err)
> > +               if (!is_zero_ether_addr(ndev->config.mac)) {
> > +                       if (mlx5_mpfs_del_mac(pfmdev, ndev->config.mac)=
) {
> > +                               mlx5_vdpa_warn(mvdev,"failed to delete =
old MAC %pM from MPFS table\n",
> > +                                       ndev->config.mac);
>
> Any reason we need to keep trying when we fail here?
>
sure will change this. i will reuse the code in hanle_ctrl_mac
> > +                       }
> > +               }
> > +               err =3D mlx5_mpfs_add_mac(pfmdev, (u8 *)add_config->net=
.mac);
> > +               if (!err) {
> > +                       mac_vlan_del(ndev, config->mac, 0, false);
> >                         ether_addr_copy(config->mac, add_config->net.ma=
c);
> > +               } else {
> > +                       mlx5_vdpa_warn(mvdev,"failed to add new MAC %pM=
 to MPFS table\n",
> > +                               (u8 *)add_config->net.mac);
> > +                       up_write(&ndev->reslock);
> > +                       return err;
> > +               }
> >         }
> > +       if (mac_vlan_add(ndev, ndev->config.mac, 0, false))
> > +               mlx5_vdpa_warn(mvdev,"failed to add new MAC %pM to vlan=
 table\n",
> > +                              (u8 *)add_config->net.mac);
> >
> >         up_write(&ndev->reslock);
> >         return err;
> > --
> > 2.45.0
> >
>
> Thanks
>


