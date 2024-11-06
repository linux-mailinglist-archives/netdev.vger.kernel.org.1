Return-Path: <netdev+bounces-142287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 641A49BE1FE
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0302845D7
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1FB1DE3C2;
	Wed,  6 Nov 2024 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CL3maVck"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9451DE2DF
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884075; cv=none; b=YmJXF7umPoaKZwdBk5DPBukn4g/u4RT3S3a7ZqJDNvWWbj0qAzbIiVgUu8w3JmeGbO1wlIpVsU8bx+Pk6Qb2rjZC3xVN5poDPRAJw6XBdCdYjFBIEdityCJRqtX7mvwG2zM+1BBZbhlNsWFcZdAHB/GIuX7zpvBRglFTv5twYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884075; c=relaxed/simple;
	bh=iRDvP6Fds9e6sAJFt7TFL1RE85f61k0qNzCwm6EI0ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUEqHxIIOnSSpnlk+xHKry1Z0OR3owxZ7ylXLNPzvYalpc8aS/JByDnti7MlHbUBonnk05jYqDnD2xffwHS/PxSnSVUZxUEHKt2Wj+6mG7o4nIFICMg215tf1EjW/Xej7sIOfEWytTovzIa61u89TaL/xaj0pliAzYd030WdhE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CL3maVck; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730884073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=stsh36U7LL9w1fGvl92BzQf3qg6o4uyL96zdePlIQ+M=;
	b=CL3maVckSf1xgnX6jk3OjnzCSnANFFaUFaE8hiAwPIwv62wW7pyrN9r52U7hnhI3X5wu0j
	dzaif0s6u7tVLCj+qXanP6jbyBAIelzOqhLpwMAX4DKTYuzEQ5o5ukCgveQex8UV2Svd+l
	+1HE4/4TH31rpzc7BduCABxmbc608S8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-liunK__lNQqBZ3LL9-ZeFA-1; Wed, 06 Nov 2024 04:07:49 -0500
X-MC-Unique: liunK__lNQqBZ3LL9-ZeFA-1
X-Mimecast-MFC-AGG-ID: liunK__lNQqBZ3LL9-ZeFA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315c1b5befso40812595e9.1
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 01:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730884069; x=1731488869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stsh36U7LL9w1fGvl92BzQf3qg6o4uyL96zdePlIQ+M=;
        b=IJ2cvS0cVxrp81lU/gspBu/BwMeLri8lmxkYtByOX0lPxy0xu4pde282kFeVWFt1ZH
         CVkbO/QgQodCWn6FgpuWDy2+vb8DI/N44b4apANYFrsdGuiZX7iEzj+XN9pKEy+XBIaT
         Qj4HHHJINvbtHY+F0/r1LI5psahdv1i2pLduWDLWFU3I/Knra7oFcu5CwJeYVbaa/sA7
         PLy27XKeoe4E7FMzqpV7zerZQg28peBBPgiQzR6JvYFfXMF7/rGEKTC3nwsVCI/HzOnI
         DkZJ3DSGLqZ07n35nezCk+YmFhAytTaV5e+XzSQ2+qUqUS9DmOLXkF6WCiybVLEjrU68
         qYcg==
X-Forwarded-Encrypted: i=1; AJvYcCVCJjuJKK7hyr1uT2/BjfMwmrUaOBL3tHgW3i/wEfbGFHB2vT74hs/Y9aVZV+IgdSgK8k1C9mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuzKXWD9cZw2PKn4gKMbKboo9qrg9l1p2dkli0qFdAkmw38ilA
	sVg/Kzw1Xr/ajPZds7Do2j4KNJAJdFyHq2nOXfTt82durZxhQKv1WGRn5J7wlIPHm4ET/ReQc48
	qt6ScbCcR8Xn/bseKfnYybTInXUuiZMkRi2/pa/yBPyx0rgkHb0/hnw==
X-Received: by 2002:a5d:6902:0:b0:37d:4ebe:164f with SMTP id ffacd0b85a97d-38061200d23mr24637617f8f.46.1730884068795;
        Wed, 06 Nov 2024 01:07:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4QdCH0opectVmr8dgwxLSrIB+qc8WNu2CPVa8NB18xSiYf7L6K01+/errC2pGSWF3kucn/A==
X-Received: by 2002:a5d:6902:0:b0:37d:4ebe:164f with SMTP id ffacd0b85a97d-38061200d23mr24637597f8f.46.1730884068451;
        Wed, 06 Nov 2024 01:07:48 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7e1bsm18681481f8f.1.2024.11.06.01.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:07:47 -0800 (PST)
Date: Wed, 6 Nov 2024 04:07:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Stefano Garzarella <sgarzare@redhat.com>, stefanha@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	mcgrof@kernel.org
Subject: Re: [PATCH v2] vhost/vsock: specify module version
Message-ID: <20241106040705-mutt-send-email-mst@kernel.org>
References: <20240929182103.21882-1-aleksandr.mikhalitsyn@canonical.com>
 <w3fc6fwdwaakygtoktjzavm4vsqq2ks3lnznyfcouesuu7cqog@uiq3y4gjj5m3>
 <CAEivzxe6MJWMPCYy1TEkp9fsvVMuoUu-k5XOt+hWg4rKR57qTw@mail.gmail.com>
 <ib52jo3gqsdmr23lpmsipytbxhecwvmjbjlgiw5ygwlbwletlu@rvuyibtxezwl>
 <CAEivzxdP+7q9vDk-0V8tPuCo1mFw92jVx0u3B8jkyYKv8sLcdA@mail.gmail.com>
 <20241002071602.793d3e2d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002071602.793d3e2d@kernel.org>

On Wed, Oct 02, 2024 at 07:16:02AM -0700, Jakub Kicinski wrote:
> On Mon, 30 Sep 2024 19:03:52 +0200 Aleksandr Mikhalitsyn wrote:
> > > At this point my question is, should we solve the problem higher and
> > > show all the modules in /sys/modules, either way?  
> > 
> > Probably, yes. We can ask Luis Chamberlain's opinion on this one.
> > 
> > +cc Luis Chamberlain <mcgrof@kernel.org>
> > 
> > >
> > > Your use case makes sense to me, so that we could try something like
> > > that, but obviously it requires more work I think.  
> > 
> > I personally am pretty happy to do more work on the generic side if
> > it's really valuable
> > for other use cases and folks support the idea.
> 
> IMHO a generic solution would be much better. I can't help but feel
> like exposing an arbitrary version to get the module to show up in 
> sysfs is a hack.
> 
> IIUC the list of built in modules is available in
> /lib/modules/*/modules.builtin, the user space can't read that?


So what are we doing about this? Aleksandr?

-- 
MST


