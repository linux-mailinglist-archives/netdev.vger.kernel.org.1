Return-Path: <netdev+bounces-113231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C5093D412
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 15:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA70F1C21C33
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 13:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFE817C201;
	Fri, 26 Jul 2024 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQt4Sj7b"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32FE143889
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722000079; cv=none; b=kPP+UN9TOaNKpc8wk4wbOBC36k95ctgXy97Bg+1GfjfKn6eNJHz+QtVibg3uo2fDRlT5E5N4qoxxfKUQRYy7aAvpgTDbTGi420b05hW0pb1PIghEXk80IAHMBrwe2RL2VJ1torZvU6HHC+WLKe47oHJL6CslWC8C2W0SAoyZvvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722000079; c=relaxed/simple;
	bh=K65IvizrkiF4Iqqucr2Z1Xdr6ozHH4a8FmSnlkgup3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZDQSpyXRD6vdS+i0KKrBCUBU3Fd9zzX0Aow2Y42JPro4ds78AmLwn46wKovgAHEsPVeETWTm/dlKikqL+iHh3evXDYuK5mdDPCsEZ26qMq9NTZlCZ/1MuKV4iqu56KYTCCTsR/8jbuxuX5pke1zodqiKtwNkMh3wX862NAdldpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQt4Sj7b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722000076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xfF8kA8g/5K/XYp2vCMWS52kuH2/f1toD92MP8xAumA=;
	b=KQt4Sj7bQJp8J/SYQd3W6iFnJKZMFr9vacwtJTeapsLMcj6MB/xsdWxShXw8keQUTSQBz+
	GmsS58UorXelCA5WDQXZ8lVzUaUAAbIagm/bdJArhL/heAG72QbSWpkyRRt356viVdES8g
	/Uk4UdVndRICyG01XrXYLjgJ1J8qJ1A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-t2pTFLF8NlOz-xSPViYgzA-1; Fri, 26 Jul 2024 09:21:15 -0400
X-MC-Unique: t2pTFLF8NlOz-xSPViYgzA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a8b0832d9cso1567453a12.0
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 06:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722000074; x=1722604874;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfF8kA8g/5K/XYp2vCMWS52kuH2/f1toD92MP8xAumA=;
        b=hk2FQhuZvWEEMrrZMJ8b/gSuzuGnz0eLL0I2bJ0XIsogunOUXGACOCAeYCU5SDl7+p
         ZxN+bV6QDApJRgs+i8Rr7pvcVVexS8BWFKT6nWkdaoK25YBGiurthd9sbkzsf8ggGcRk
         CydZz428ITYefc2KL6t/Rtb8+S1KQTFaJA0JH4Sbv598KkdIUTd/N5rDXXyzjXBEyH7W
         4GhUR29YAsiAQKpRC8RTzZJv6JiOd2dIVb/QjcKh6oSkJiuk8OkAV8ljWiOfB0C7AuDU
         O0RPyH3ZWmr2d+q1aMGC7tOXtOFgKTJy5ZIMaACaByzNE4fLuzra4LeVYYRbvN7RiMD6
         Ezcg==
X-Forwarded-Encrypted: i=1; AJvYcCVbaI8a9DlHa2Cl7q2OrRnvLsZd00056r2hmiirt7nBWhP2p1a0H2jFWpOY5tUIk46KT02TKCovE/+NcbCA705QQz09K32X
X-Gm-Message-State: AOJu0YyJhXtsKeB3o32pdtI4Yt8FEw1zcrAnE7iAXb/aQ/mjPEXb719w
	qW0WNhf+L8AZ5q9XOhFB58Ex1HG908UHLZfX+dnkC7nQY30ln5NWPBMv0VDMAh+JI3L6YyeWK/w
	fCeSulyRgE2JMNzeCLbepTnTz2rHP39XYQ2Grl//bsXANXB5ZMKuLyM/YuVzgwDawa9ato0ro7l
	HvMIPceZnp1JF6Txus3uQRYRRG0T2W
X-Received: by 2002:a50:c04d:0:b0:5a3:b45:3970 with SMTP id 4fb4d7f45d1cf-5ac27750881mr3155024a12.0.1722000074169;
        Fri, 26 Jul 2024 06:21:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWDnNKpy4OxfBSVuSmYdRoaFihsPhdouxRuwt/96M7BlYl2KRazN2ZOfpWIg1WDgG3Um4QtyroVHGsGBXWCXw=
X-Received: by 2002:a50:c04d:0:b0:5a3:b45:3970 with SMTP id
 4fb4d7f45d1cf-5ac27750881mr3154998a12.0.1722000073790; Fri, 26 Jul 2024
 06:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725013217.1124704-1-lulu@redhat.com> <20240725013217.1124704-4-lulu@redhat.com>
 <ZqKMEoDIZx8XFhlq@LQ3V64L9R2>
In-Reply-To: <ZqKMEoDIZx8XFhlq@LQ3V64L9R2>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 26 Jul 2024 21:20:36 +0800
Message-ID: <CACLfguX7_Nvfy2wZ8WTNPOnBZxi43VKRLdhm-axUdE=m3ZsTVw@mail.gmail.com>
Subject: Re: [PATH v6 3/3] vdpa/mlx5: Add the support of set mac address
To: Joe Damato <jdamato@fastly.com>, Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, 
	mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 01:32, Joe Damato <jdamato@fastly.com> wrote:
>
> On Thu, Jul 25, 2024 at 09:31:04AM +0800, Cindy Lu wrote:
> > Add the function to support setting the MAC address.
> > For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> > to set the mac address
> >
> > Tested in ConnectX-6 Dx device
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index ecfc16151d61..d7e5e30e9ef4 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -3785,10 +3785,38 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
> >       destroy_workqueue(wq);
> >       mgtdev->ndev = NULL;
> >  }
>
> Nit: Other code in this file separates functions with newlines,
> perhaps one is needed here?
>
> > +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> > +                           struct vdpa_device *dev,
> > +                           const struct vdpa_dev_set_config *add_config)
>
> Nit: it appears that the alignment is off on these parameters. Did
> checkpatch.pl --strict pass on this?
>
sure, will check  this
thanks
> > +{
> > +     struct virtio_net_config *config;
> > +     struct mlx5_core_dev *pfmdev;
> > +     struct mlx5_vdpa_dev *mvdev;
> > +     struct mlx5_vdpa_net *ndev;
>
> [...]
>


