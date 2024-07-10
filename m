Return-Path: <netdev+bounces-110536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B17A92CE85
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 11:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB241C22842
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 09:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC0918FA37;
	Wed, 10 Jul 2024 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R60JAJMo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F21418FA23
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604807; cv=none; b=QEnIGIDRZp+sLXLNEHM8or7Zx/zklf1CV0p7fsoFJGFjumT9m9/YBbxnwSoUY0VdyOvEjPTjpUHMmWnhLl2ik0Gn85Ek+ZXNEEhSVco5miCKuYM9ttr1DwAjP4uN5q9TySI9ZpShvih28JvfKFy1O5SUNVg3i0CpSEGKX74G8LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604807; c=relaxed/simple;
	bh=LZFnsJhlMMXmLcnLjHwif3Tko8RTPA1FKx72W7VDpJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nhmf0dyLZtqdh+1mryI9tmyN7/p/Hz+rb4eSmgM/n+AzeIwFrCjMl/BTH+zVgrdV2KBp2LwAcv7qHe3agee87SH/YDMX3/FvWq8RmV7/wPQGPFFOe4Vo7R1+CzSgNNYZdIWNnqbI6sN+lQEmHnbm3KT0uIgeK9m4Huq1DTj4BVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R60JAJMo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720604804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wr3Fzy04+IjAcueeHCouhzEQFA2vb2X2x/Lajkzkytk=;
	b=R60JAJMo2QQd1dPxNXSqlBlcWm61//l3pGGI8TsT0iSclZiflT9JVH69mxqhA/emZFZAV8
	rcB4064U61bNWUOBovy6Op+YLlim6N3BCH0RV0Dx+SUvda5cQwoEhj8sOsujvwVHr6grAO
	vqgskAztfOQRh9uQOdQpD3BojAj3Gyc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-X00AjcR_MVe_vSf754HHGQ-1; Wed, 10 Jul 2024 05:46:43 -0400
X-MC-Unique: X00AjcR_MVe_vSf754HHGQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ee9308bc8cso51308141fa.0
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 02:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720604800; x=1721209600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wr3Fzy04+IjAcueeHCouhzEQFA2vb2X2x/Lajkzkytk=;
        b=HB98ci13gJLyQ3eUeM/7+7Hf5shlm0M5t9RjXW4lMD1GluQpJqRsasV2T9m3FC6Mis
         r4oySc0V0tBT4NhcfVIc/f8iRmj77zO4bEVR1S2qk75uEBeeh+eWWq7HMJneILZ2d391
         AjcBoet2NeBYw4XDt9UYmNDV6PnbS54dFKe3NNjUCcTgVhpU4xhWLLaL4b+BoVyBidQ8
         Sg2+TjXLWkzer9THZNshBg4pvo4LCDVsgD1dNY1RIC+UMFrsFm+21tKpacS7XZCynV5i
         wcQwwXTtvfGLWazaRSEAjbyzawnsOdE19AdOtw5ZUIs9MaLgFkntgTZp6oreuAcLBzA4
         7vrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSfwBvxzr/UKpgFc32uPtPDE2Zn6Z6tR7bYpiBgjNW9TId/tXqhLuTUUXGhOiYeACQ9M+hbp69nL6Jfxt33GV4YvZ8Vfyb
X-Gm-Message-State: AOJu0YyHyuaRnM/CTgGD/+HvQaQiofuJIFFQaJDUMWj6uxN379JqPxqg
	ZswGnJLDSTDgbsdp51uVQSwxQFSmi56XHq07vv7q28jSFmMKtkmPJk1s9HQedMDVdzfZFLer5Kc
	bgsQzIL9JxEDvfs8HP3v6XvAtTuvjNVr/l9kZNpApfwzVg61CUQP04nfnSQ53gF0beN+M0Xilbt
	1BJANo8VkYLdv9GFVlpiHnHfsZ+s1gqoxPBqYCVAM=
X-Received: by 2002:a05:651c:97:b0:2ee:8aed:ddcd with SMTP id 38308e7fff4ca-2eeb30ba01bmr30673221fa.2.1720604800507;
        Wed, 10 Jul 2024 02:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0ffFCw3VbNM6Vw/r2MqpTFMKw6bcckSDGxnXr5Oj3vP+HBV03PNXiHpFH5GB2HlKHopl3lyeXuVt4nS1YdPI=
X-Received: by 2002:a05:651c:97:b0:2ee:8aed:ddcd with SMTP id
 38308e7fff4ca-2eeb30ba01bmr30673101fa.2.1720604800176; Wed, 10 Jul 2024
 02:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708064820.88955-1-lulu@redhat.com> <PH0PR12MB5481AE2FD52AEE1C10411F3DDCDB2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACLfguXk4qiw4efRGK4Gw8OZQ_PKw6j+GVQJCVtbyJ+hxOoE0Q@mail.gmail.com>
 <20240709084109-mutt-send-email-mst@kernel.org> <CACGkMEtdFgbgrjNDoYfW1B+4BwG8=i9CP5ePiULm2n3837n29w@mail.gmail.com>
 <20240710020852-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240710020852-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 10 Jul 2024 17:46:02 +0800
Message-ID: <CACLfguW0HxPy7ZF7gg7hNzMqFcf5x87asQKBUqZMOJC_S8kSbw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] vdpa: support set mac address from vdpa tool
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Leonardo Milleri <lmilleri@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jul 2024 at 14:10, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Jul 10, 2024 at 11:05:48AM +0800, Jason Wang wrote:
> > On Tue, Jul 9, 2024 at 8:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Tue, Jul 09, 2024 at 02:19:19PM +0800, Cindy Lu wrote:
> > > > On Tue, 9 Jul 2024 at 11:59, Parav Pandit <parav@nvidia.com> wrote:
> > > > >
> > > > > Hi Cindy,
> > > > >
> > > > > > From: Cindy Lu <lulu@redhat.com>
> > > > > > Sent: Monday, July 8, 2024 12:17 PM
> > > > > >
> > > > > > Add support for setting the MAC address using the VDPA tool.
> > > > > > This feature will allow setting the MAC address using the VDPA =
tool.
> > > > > > For example, in vdpa_sim_net, the implementation sets the MAC a=
ddress to
> > > > > > the config space. However, for other drivers, they can implemen=
t their own
> > > > > > function, not limited to the config space.
> > > > > >
> > > > > > Changelog v2
> > > > > >  - Changed the function name to prevent misunderstanding
> > > > > >  - Added check for blk device
> > > > > >  - Addressed the comments
> > > > > > Changelog v3
> > > > > >  - Split the function of the net device from vdpa_nl_cmd_dev_at=
tr_set_doit
> > > > > >  - Add a lock for the network device's dev_set_attr operation
> > > > > >  - Address the comments
> > > > > >
> > > > > > Cindy Lu (2):
> > > > > >   vdpa: support set mac address from vdpa tool
> > > > > >   vdpa_sim_net: Add the support of set mac address
> > > > > >
> > > > > >  drivers/vdpa/vdpa.c                  | 81 ++++++++++++++++++++=
++++++++
> > > > > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 19 ++++++-
> > > > > >  include/linux/vdpa.h                 |  9 ++++
> > > > > >  include/uapi/linux/vdpa.h            |  1 +
> > > > > >  4 files changed, 109 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > --
> > > > > > 2.45.0
> > > > >
> > > > > Mlx5 device already allows setting the mac and mtu during the vdp=
a device creation time.
> > > > > Once the vdpa device is created, it binds to vdpa bus and other d=
river vhost_vdpa etc bind to it.
> > > > > So there was no good reason in the past to support explicit confi=
g after device add complicate the flow for synchronizing this.
> > > > >
> > > > > The user who wants a device with new attributes, as well destroy =
and recreate the vdpa device with new desired attributes.
> > > > >
> > > > > vdpa_sim_net can also be extended for similar way when adding the=
 vdpa device.
> > > > >
> > > > > Have you considered using the existing tool and kernel in place s=
ince 2021?
> > > > > Such as commit d8ca2fa5be1.
> > > > >
> > > > > An example of it is,
> > > > > $ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55=
 mtu 9000
> > > > >
> > > > Hi Parav
> > > > Really thanks for your comments. The reason for adding this functio=
n
> > > > is to support Kubevirt.
> > > > the problem we meet is that kubevirt chooses one random vdpa device
> > > > from the pool and we don't know which one it going to pick. That me=
ans
> > > > we can't get to know the Mac address before it is created. So we pl=
an
> > > > to have this function to change the mac address after it is created
> > > > Thanks
> > > > cindy
> > >
> > > Well you will need to change kubevirt to teach it to set
> > > mac address, right?
> >
> > That's the plan. Adding Leonardo.
> >
> > Thanks
>
> So given you are going to change kubevirt, can we
> change it to create devices as needed with the
> existing API?
>
Hi Micheal and Parav,
I'm really not familiar with kubevirt, hope Leonardo can help answer
these questions
Hi @Leonardo Milleri
would you help answer these questions?

Thanks
Cindy
> > >
> > > --
> > > MST
> > >
>


