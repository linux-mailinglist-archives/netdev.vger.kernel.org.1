Return-Path: <netdev+bounces-226186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8300DB9D8B4
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3011A380048
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 06:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057DC2E8B8A;
	Thu, 25 Sep 2025 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INdwuF10"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5841E2E7F3C
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 06:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780814; cv=none; b=DBNAXpCrKyRdSSsAssJR6tcjqIBJlsvBnwcZJehSG52TMMQFNLShrWihbIKndzTlXUICWTcg4QaG6SBwdamiX3KMDt5ZSYXYRgZAdUXdElCxg+OM3WL8hJXzrBRT3MhNQsqSgB7d5a/El246zfrgoFoWjwogeLxZ0gMUNcC/z3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780814; c=relaxed/simple;
	bh=4OBMsQorin7i5YrnkLTLeZBVWNw5NVUTy6o8R3DlhAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSQgZSaagUyb4fCGG+n3y0V95IfuXEZMnGlqrtQ5q3bDQyE+RxbZv+ysSH4nGvQGw1khDMQCdwWTCwvP5WlGDbEikg/KWvTvd1fdHP7hw+oe5r+3GeEpiJUOwHL+V9nfiSnuKnwy7+a0dmiEd1RCBSzYKDdn8ZptnBEpX518cPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INdwuF10; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758780812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=779hgb75Reg08Cvo2KhD/Ld5MMgvSX2Yfj69Y+vZ9iA=;
	b=INdwuF10rxe/XQbwigQJjsok2adlj2phq8B7sOmExwbVftsYl/OixlVWLs29Q9KhdA7/ww
	FUjSlw1jw80zl7iw1m50TlkODVKBvQJrVpcBy3YT070V/b8jlZWuOHgciiBj73HoaOb4w5
	5bxzbvnJN+WL4FfWHykCes7nPRO/yeA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-Nf_KlwwaN324JIRGXYwDnQ-1; Thu, 25 Sep 2025 02:13:30 -0400
X-MC-Unique: Nf_KlwwaN324JIRGXYwDnQ-1
X-Mimecast-MFC-AGG-ID: Nf_KlwwaN324JIRGXYwDnQ_1758780810
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b986a7b8aso2869535e9.0
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 23:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758780809; x=1759385609;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=779hgb75Reg08Cvo2KhD/Ld5MMgvSX2Yfj69Y+vZ9iA=;
        b=a6JV2/M/BJTAfPT/HIEnuFn1ELuHJcqiuhfXwWBtmfFnBFC9f+q5XyZFgOdVdbK1VR
         nVXAmiSgOqMYKVfIqsAywi/HlrYkZYz1lvNAn6CbdX75Az144UrLA/lZE87qW54GukS+
         MOWDtsx33MESmKwTPdcgqS/hoJDuCGh4+r3i3Njn/8DQG5IfwEeyJaVeyE/Iq09vHAnR
         OnMAoZ8qe+Hj9Y+DU4ful6f5DeYx3sS1YcrPgnhKzkfUlJsCOX3NFqi0uNAF8CnnkGSO
         27y8B5O7zCWv5w+1S8Uq8L/JpvjcFjkYDi/66vcjZ/VYIYxHug9Y/1z6Bd9kybDSf3Ly
         K1Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVCCLeH5MqHBbpq6vEU461sqSiRIv7JKLyvgXhJHPkBOpeUKFo02uBm6EOIr0YQei7WcHH1vUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqv7/EVm1Zy98sCqDvbmKLD9qw63wnKId8EGbN0tCza4jmICIU
	AR9vJp+l3OB8H+4u9gDGmOfoMeHtattlT1MnA53O27xe6qj4hKZ9Aw1QDsVAR5PLCeYbazZq4QT
	RMVZOVdQvERIj7zKEZxV2Hh6qij/Rhq6+IxNuNn7IIAGOrkKT48m/qzHNRA==
X-Gm-Gg: ASbGncuY7W7bz31a4+FbhdiMkXEwyaCLc0zkEmalt15BmPxUWKcwnpKDJGqlSL9m8+6
	P4bcLn1o0Kgtb3E2kCrFFR9t3Nit8SFgLCyglSEqe6VCVtGlb6pHo3GNCCuU4/N4NvV8RgIOJUA
	Sqe7YLN1ZwqSjKo7hBTV4P6WQnu/1Qg+c000vqmRQE2RNhTHEFsZR7tg8L/61nx8Jvk/pRygJr2
	phpokqcHbemCLH4qQxU6iLX4iSWdmKd6uC0lH9Lt/TuBnJwAjHEWsCndFTompIcoCgGveZ/NhOY
	0KYtBPD2QBjY8SCnshxs3vnHCsSs8mW8CQ==
X-Received: by 2002:a05:6000:3101:b0:3eb:df84:60f with SMTP id ffacd0b85a97d-40e4cc62f3fmr2096291f8f.48.1758780809399;
        Wed, 24 Sep 2025 23:13:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd3gPUaddOxHhaM4zxRbAKZo3GkMqD8lYJqJHAkZBRMdwuYQbur7YGDLsrI8r4aB8V3WwUaw==
X-Received: by 2002:a05:6000:3101:b0:3eb:df84:60f with SMTP id ffacd0b85a97d-40e4cc62f3fmr2096264f8f.48.1758780808816;
        Wed, 24 Sep 2025 23:13:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fac4a5e41sm1575462f8f.0.2025.09.24.23.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:13:28 -0700 (PDT)
Date: Thu, 25 Sep 2025 02:13:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Daniel Jurgens <danielj@nvidia.com>, virtualization@lists.linux.dev,
	parav@nvidia.com, shshitrit@nvidia.com, yohadt@nvidia.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com, netdev@vger.kernel.org,
	jasowang@redhat.com, alex.williamson@redhat.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v3 03/11] virtio_net: Create virtio_net directory
Message-ID: <20250925020502-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-4-danielj@nvidia.com>
 <1758772569.13948-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1758772569.13948-1-xuanzhuo@linux.alibaba.com>

On Thu, Sep 25, 2025 at 11:56:09AM +0800, Xuan Zhuo wrote:
> On Tue, 23 Sep 2025 09:19:12 -0500, Daniel Jurgens <danielj@nvidia.com> wrote:
> > The flow filter implementaion requires minimal changes to the
> > existing virtio_net implementation. It's cleaner to separate it into
> > another file. In order to do so, move virtio_net.c into the new
> > virtio_net directory, and create a makefile for it. Note the name is
> > changed to virtio_net_main.c, so the module can retain the name
> > virtio_net.
> >
> > Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> 
> To help this work move forward smoothly, I don't recommend splitting the
> directory structure within this patchset. Directory reorganization can be a
> separate effortâ€”I've previously experimented with this myself. I'd really
> like to see this work progress smoothly.
> 
> Thanks.

Indeed.

> 
> > ---
> >  MAINTAINERS                                               | 2 +-
> >  drivers/net/Makefile                                      | 2 +-
> >  drivers/net/virtio_net/Makefile                           | 8 ++++++++
> >  .../net/{virtio_net.c => virtio_net/virtio_net_main.c}    | 0
> >  4 files changed, 10 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/net/virtio_net/Makefile
> >  rename drivers/net/{virtio_net.c => virtio_net/virtio_net_main.c} (100%)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a8a770714101..09d26c4225a9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -26685,7 +26685,7 @@ F:	Documentation/devicetree/bindings/virtio/
> >  F:	Documentation/driver-api/virtio/
> >  F:	drivers/block/virtio_blk.c
> >  F:	drivers/crypto/virtio/
> > -F:	drivers/net/virtio_net.c
> > +F:	drivers/net/virtio_net/
> >  F:	drivers/vdpa/
> >  F:	drivers/virtio/
> >  F:	include/linux/vdpa.h
> > diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> > index 73bc63ecd65f..cf28992658a6 100644
> > --- a/drivers/net/Makefile
> > +++ b/drivers/net/Makefile
> > @@ -33,7 +33,7 @@ obj-$(CONFIG_NET_TEAM) += team/
> >  obj-$(CONFIG_TUN) += tun.o
> >  obj-$(CONFIG_TAP) += tap.o
> >  obj-$(CONFIG_VETH) += veth.o
> > -obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
> > +obj-$(CONFIG_VIRTIO_NET) += virtio_net/
> >  obj-$(CONFIG_VXLAN) += vxlan/
> >  obj-$(CONFIG_GENEVE) += geneve.o
> >  obj-$(CONFIG_BAREUDP) += bareudp.o
> > diff --git a/drivers/net/virtio_net/Makefile b/drivers/net/virtio_net/Makefile
> > new file mode 100644
> > index 000000000000..c0a4725ddd69
> > --- /dev/null
> > +++ b/drivers/net/virtio_net/Makefile
> > @@ -0,0 +1,8 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Makefile for the VirtIO Net driver
> > +#
> > +
> > +obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
> > +
> > +virtio_net-objs := virtio_net_main.o
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net/virtio_net_main.c
> > similarity index 100%
> > rename from drivers/net/virtio_net.c
> > rename to drivers/net/virtio_net/virtio_net_main.c
> > --
> > 2.45.0
> >


