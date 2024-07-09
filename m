Return-Path: <netdev+bounces-110253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B854892B9B9
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B6E1C20B2E
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D435315B552;
	Tue,  9 Jul 2024 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UV3VCRS1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0BF15AD96
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528928; cv=none; b=BXLXRwwetipxcHqy/XPPqt9hNf0b4GUkRj20l26S7yAYKt95OEkJLBBBjBOQse5QV/Un5yiKub4kknfWlk+dii1xh3nm8fyInpIMw/NQ6vcbr+ZLaRfXUEhWmUSIajIL8nwqKbYWNggkdVD+6Whbb+rHEVeLJ5oYDwOR+PM2HaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528928; c=relaxed/simple;
	bh=WMRXeklNAFCXPxZX0QKDYEufIJKcpHVBpPvLr8GdPXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNKWP9Y5U7+5EAOw/CBGq2PEOE5Wdi5ah8Kv/ftpZ/loP13L7R5fQS0xkr0MPeV2xic7/ByYuh0HOtk+ID3aeRW0Jqz24L7Fkhxvib5ShM9/Mnkhsnx/SnJvybwZW7RF9z9WgfWmOi/fftzwl5ckpR6/7eJo/PIEpwwwsR7Jjgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UV3VCRS1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720528925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dtU0JGN0EJmcocAYFfRCYWD9D/xkCDMAfPhd/SDuPwo=;
	b=UV3VCRS1ohyfUSMmo4QL/yin382P0EvXjKqCHD6lJyzdy0atcmv0VIPkcdesm5Tt9s8vAl
	uugWnbe9OcjywdmgldlRPhT8xv9s8aY9CjHp4p6/I/6XvxNcwJbYLLtt0miePgHlQJimvT
	ja7s5L/gFTXTzZksJ4V/eshFJk7Lefs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-MAwhaG9LPZqAO45FHaX-Dw-1; Tue, 09 Jul 2024 08:42:02 -0400
X-MC-Unique: MAwhaG9LPZqAO45FHaX-Dw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ee9308bc8cso43035521fa.0
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 05:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720528921; x=1721133721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtU0JGN0EJmcocAYFfRCYWD9D/xkCDMAfPhd/SDuPwo=;
        b=slfQg0K8UFr3BHuzsDLmtCFAi0LEEsJwykeAEMeUyYWvBX9n71F3j1uq6QL6cE5cAj
         Swy8PknhG2TQdORB7RnRAZUBvD2h8gMC3pURveQxxPpXy607/S9KXdYu5eCtVpliZEpq
         8MB17naqJNjjuMch9Yl7Ir0BJHICi3PgDjLNFZkRDU3VRmbWc26OSdMy8uv9dnhhV0vw
         0nwx18frw8WU2L35fdH/Vhh1Hanl8VIvCg2nyfw/8jQ+NvUHwl8xPTDOxc8QiGHVdnLo
         r3+Rcs2HDER2eF91kVNrttsEf8l8vUze9CJ5SlT9kH99CkPwquRAEoSs3ZWiLys3sOc/
         Qkfg==
X-Forwarded-Encrypted: i=1; AJvYcCV1e7qiiv3Ybmrl4BMh5xvJOV0VpfHPvwetT13ELy/4vqNwnB49rSgf6+HcVDa/83MPYVB9aqqt8mbgwXYwl/pZiOHy9mBf
X-Gm-Message-State: AOJu0Yx/5ky6pF3uXjAsuKHSWAZL1EukGNAZqfccEta7KaYC+hWpDG4j
	h5Q4FVHy51pGtmmy4rJoxvskK5KwQZQ1zVPRsdGzo9K65Bb8vg9zDXh+G21Lwub5El+CsE42QlO
	eaB6qoKO95iittwa01i91XnSbBSSillHHaM3zh7r7OOW34LcdW1MC5w==
X-Received: by 2002:a2e:8952:0:b0:2ec:5547:c59e with SMTP id 38308e7fff4ca-2eeb3198ac3mr15824011fa.50.1720528921182;
        Tue, 09 Jul 2024 05:42:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJQ/3+1cvJIxlRdKB/u4MEHHTb/Kxc0reqE+YePLpyvQDvI/rkVgTUeLmn/vgIWjxO/a5kxQ==
X-Received: by 2002:a2e:8952:0:b0:2ec:5547:c59e with SMTP id 38308e7fff4ca-2eeb3198ac3mr15823541fa.50.1720528918592;
        Tue, 09 Jul 2024 05:41:58 -0700 (PDT)
Received: from redhat.com ([2.52.29.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa06b6sm2454398f8f.86.2024.07.09.05.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:41:58 -0700 (PDT)
Date: Tue, 9 Jul 2024 08:41:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240709084109-mutt-send-email-mst@kernel.org>
References: <20240708064820.88955-1-lulu@redhat.com>
 <PH0PR12MB5481AE2FD52AEE1C10411F3DDCDB2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACLfguXk4qiw4efRGK4Gw8OZQ_PKw6j+GVQJCVtbyJ+hxOoE0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACLfguXk4qiw4efRGK4Gw8OZQ_PKw6j+GVQJCVtbyJ+hxOoE0Q@mail.gmail.com>

On Tue, Jul 09, 2024 at 02:19:19PM +0800, Cindy Lu wrote:
> On Tue, 9 Jul 2024 at 11:59, Parav Pandit <parav@nvidia.com> wrote:
> >
> > Hi Cindy,
> >
> > > From: Cindy Lu <lulu@redhat.com>
> > > Sent: Monday, July 8, 2024 12:17 PM
> > >
> > > Add support for setting the MAC address using the VDPA tool.
> > > This feature will allow setting the MAC address using the VDPA tool.
> > > For example, in vdpa_sim_net, the implementation sets the MAC address to
> > > the config space. However, for other drivers, they can implement their own
> > > function, not limited to the config space.
> > >
> > > Changelog v2
> > >  - Changed the function name to prevent misunderstanding
> > >  - Added check for blk device
> > >  - Addressed the comments
> > > Changelog v3
> > >  - Split the function of the net device from vdpa_nl_cmd_dev_attr_set_doit
> > >  - Add a lock for the network device's dev_set_attr operation
> > >  - Address the comments
> > >
> > > Cindy Lu (2):
> > >   vdpa: support set mac address from vdpa tool
> > >   vdpa_sim_net: Add the support of set mac address
> > >
> > >  drivers/vdpa/vdpa.c                  | 81 ++++++++++++++++++++++++++++
> > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 19 ++++++-
> > >  include/linux/vdpa.h                 |  9 ++++
> > >  include/uapi/linux/vdpa.h            |  1 +
> > >  4 files changed, 109 insertions(+), 1 deletion(-)
> > >
> > > --
> > > 2.45.0
> >
> > Mlx5 device already allows setting the mac and mtu during the vdpa device creation time.
> > Once the vdpa device is created, it binds to vdpa bus and other driver vhost_vdpa etc bind to it.
> > So there was no good reason in the past to support explicit config after device add complicate the flow for synchronizing this.
> >
> > The user who wants a device with new attributes, as well destroy and recreate the vdpa device with new desired attributes.
> >
> > vdpa_sim_net can also be extended for similar way when adding the vdpa device.
> >
> > Have you considered using the existing tool and kernel in place since 2021?
> > Such as commit d8ca2fa5be1.
> >
> > An example of it is,
> > $ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55 mtu 9000
> >
> Hi Parav
> Really thanks for your comments. The reason for adding this function
> is to support Kubevirt.
> the problem we meet is that kubevirt chooses one random vdpa device
> from the pool and we don't know which one it going to pick. That means
> we can't get to know the Mac address before it is created. So we plan
> to have this function to change the mac address after it is created
> Thanks
> cindy

Well you will need to change kubevirt to teach it to set
mac address, right?

-- 
MST


