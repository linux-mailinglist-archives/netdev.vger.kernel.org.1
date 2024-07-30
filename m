Return-Path: <netdev+bounces-113877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDB09403AD
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 03:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE83E282215
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 01:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6598F6E;
	Tue, 30 Jul 2024 01:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmwseddq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914509454
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302915; cv=none; b=aB39anFk3OrO2H5tPCYhFyuiSXuYD7mFJyDDn+ubg7fdJtFHVNxYggdnzKjPdTGjTUuKQ7dGQMeQeUsdUoF4CXiYqSiy1YFGIhbHI3B/y37iriCZmzVcbxhbnuxueeYTeVhjSf4TlunCMvRZQlZmj0om/YO2FuxrSciag1XnnCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302915; c=relaxed/simple;
	bh=bHLggzBkR32ABTBuDeD5m8BceYVfT11ujqxOCYp94L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USVjcSmHZ4gb2H25cZGFyI0rn6tDQF/WQssEwOWk7Qf0BSaAhdyokz/DipffksGq46O3BKgmx43Uq/85OIRkgaCD5t0/0rnAi1qSFzeR7FVTQfvAyBFzVzE1QU8VS4Bha5qPYAmBN0B5psrY/EZIvq9De+dFJ9zzv8kkqdizfi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmwseddq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722302912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xktMOVoHugI0lTfnvlwNQ+Q7ARYmOA7NCAixOdxBTU=;
	b=fmwseddqxtKSkH6UFIlGlq3AWkMSotFnu/wVfZIFX75yxpSu4ieQBfBkZw6E+CDQAbKZAW
	d9FM0ZSUtaouS63hlbwtH2br0hJapk74SelNhT/Byc8ukNRk3VQ/lrtpi/zYyvz4OieiNP
	0GJRoZqDLPedVNotaFyXeI0zxqYD1SU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-011uKUP4P3CFwwRNCIWhxQ-1; Mon, 29 Jul 2024 21:28:28 -0400
X-MC-Unique: 011uKUP4P3CFwwRNCIWhxQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a745917ef7so1838682a12.2
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 18:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722302907; x=1722907707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xktMOVoHugI0lTfnvlwNQ+Q7ARYmOA7NCAixOdxBTU=;
        b=PXgRMbMO4HL29Lmo12mFrz3pFocn167YAFrlcdguzL+OVoKQA9l2N1GdYYk2g6oSav
         PH5pgLm6rDOpUbmxc9AZbU2To5SwPdWyC6T21Vg9F+GnSkpoI9yyicqkAQa1oQMENUqS
         EZmrPMRfGdpNVYeMuL+lNoE2B94F6QP/7viikKTvcT0c/s9qKNcZhTz0A4yemdm72ISl
         P4Q7DnoLmpfTqdZTS7pS206bVtvKj56uqY74yUrbcNK1JmIMoARcFUoBDJni/8rBRhMO
         n5BGFwov0PpeDOWiLmFsU/JvqNaoTNLLPGV5ny8YxtRR9Re31zljsOIprdDS+E64U6xD
         RqtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvESfZN3rz52RLDhQkg8L8e+cZMORnoJlKRIoZElHcKnTPjX8FwefLjOWG5zunHnOcz0A3nSsD6PV/X96XIhvcSXNrKUE9
X-Gm-Message-State: AOJu0YyAnK66v9dpubVtIOzo/2pMwlPwvt51cPaRwhPqjp0YjCnnrbY2
	APV4qWyzvDZpMeF+TrWaXh/EJsRuaZhIu30LZI+M0z+atR8DRLhKimZG675t3PetNN8rEg+REvO
	dZssTPnhQ7ZxQXmeak4Tmj+tbu3+5PQzlfv4+avreDckXwq0VtWdKn2yRn3GftXF2oIjaOfVzik
	Q7H9m4zXFgSOeM4Wu0DM67djoRJDcP
X-Received: by 2002:a05:6402:3481:b0:5a0:d004:60c6 with SMTP id 4fb4d7f45d1cf-5b021d22ba2mr8115641a12.18.1722302907434;
        Mon, 29 Jul 2024 18:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdPTNCvh6T69SK0IJXobLvCIllL/ErzFAg0dOuyEmshyYj0yciGy5k79zWO9SA5PSF4d+cis7D29a6K9GM9s8=
X-Received: by 2002:a05:6402:3481:b0:5a0:d004:60c6 with SMTP id
 4fb4d7f45d1cf-5b021d22ba2mr8115635a12.18.1722302906995; Mon, 29 Jul 2024
 18:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729052146.621924-1-lulu@redhat.com> <20240729052146.621924-2-lulu@redhat.com>
 <52af9b4f-aa8f-4c6f-9ced-c6fa9b396343@lunn.ch>
In-Reply-To: <52af9b4f-aa8f-4c6f-9ced-c6fa9b396343@lunn.ch>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 30 Jul 2024 09:27:50 +0800
Message-ID: <CACLfguVHKw-ppXeA8DDH0CtvYZ9m8rkk+Jr7ZF9pFfbLr1VRGQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] vdpa: support set mac address from vdpa tool
To: Andrew Lunn <andrew@lunn.ch>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, 
	sgarzare@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jul 2024 at 03:13, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static int vdpa_dev_net_device_attr_set(struct vdpa_device *vdev,
> > +                                     struct genl_info *info)
> > +{
> > +     struct vdpa_dev_set_config set_config =3D {};
> > +     struct vdpa_mgmt_dev *mdev =3D vdev->mdev;
> > +     struct nlattr **nl_attrs =3D info->attrs;
> > +     const u8 *macaddr;
> > +     int err =3D -EINVAL;
> > +
> > +     down_write(&vdev->cf_lock);
> > +     if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> > +             set_config.mask |=3D BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADD=
R);
> > +             macaddr =3D nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACAD=
DR]);
> > +
> > +             if (is_valid_ether_addr(macaddr)) {
> > +                     ether_addr_copy(set_config.net.mac, macaddr);
> > +                     memcpy(set_config.net.mac, macaddr, ETH_ALEN);
>
> ether_addr_copy() and memcpy()?
>
> > +                     if (mdev->ops->dev_set_attr) {
> > +                             err =3D mdev->ops->dev_set_attr(mdev, vde=
v,
> > +                                                           &set_config=
);
> > +                     } else {
> > +                             NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > +                                                    "device does not s=
upport changing the MAC address");
>
> You would generally return EOPNOTSUPP in this case, not EINVAL.
>
> Also, the device does not support setting attributes. Given the
> generic name, i assume you plan to set other attributes in the future,
> at which point this error message will be wrong.
>
sure=EF=BC=8C will fix this
Thanks
cindy
>         Andrew
>


