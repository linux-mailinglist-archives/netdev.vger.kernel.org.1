Return-Path: <netdev+bounces-130247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 773349896A6
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 19:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E01F281C03
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 17:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1D03B1B5;
	Sun, 29 Sep 2024 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKd+HW3T"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985B125A9
	for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727632097; cv=none; b=Yi06qtBokxpow0a6lofL3CZgDr4yoZS2C0GGEr/ph8wTtQyLE8AO1DVx0U7e98Dd1t9MD16D8y9tbPIiJz8bLO8Yu5+BnFZ6CiHUAb6XvsJNMePI0XJLH+FuMwjTozkh02WrFuY9BkPMn+A4nvSL7YgD2YK8yAtMdsj314of4R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727632097; c=relaxed/simple;
	bh=AvobsG1jhuHDFE/RNGfVUQyDfh3hzzI1idLKQDaPtl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhAiU1IM5lAs8jPZItw5XYPmW6ivsQvraKPgwxWuH6N/6qPw4sEtqcx/rAQ3+ab1y4tbwF7qCspd0bTmJFYzIGKi8KhOnMtdYAKimruhSjO3eKd8fPd+0sK1DtaSwYpL+1RpxAr3EvDGTXlNcOFDhsJUDEnHrtiwhZqSkHv9EEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FKd+HW3T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727632095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2SJ25HQ+fRHsgbGXM+/9uz/n92kl540u3O+51RIevY=;
	b=FKd+HW3ThDYaNv7b4TY2kl2g/lAUyO0aTmWNUJtEo6iJhl2WSLV4qPpXwhKV4FuubGvyXq
	+A+/keq0ByBoaqyAfi4f3AgMuKemya9sByaY5FYpvogqPmVQbpR6JpkdBF4Zn8qORuU8Jn
	kxS9NMitGOKz4Kuik/Iq9LQYO2R9krA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-NaoDXvjlN1i0XYuYidBBiQ-1; Sun, 29 Sep 2024 13:48:13 -0400
X-MC-Unique: NaoDXvjlN1i0XYuYidBBiQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a90f263c646so295406666b.1
        for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 10:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727632092; x=1728236892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2SJ25HQ+fRHsgbGXM+/9uz/n92kl540u3O+51RIevY=;
        b=GDCnPahZtoAkKJSh6oJ+W0a1u8OFAVnq+19mxyoaHRIGfJMk9VezmKNkcML2V/eSWk
         NF+4JLqdI+dVpJ3VAPkmpCxxDhpp+2vZ9fnuMifiKQZcYRIZDyDvRXnhgdzwZVGpaqKg
         DdTiGhqHbG+kMfPHrENdfSki9w7WMkLHQoTVIB0RBqE8VXt/vRJiMv6Jpbpkf4MJhgkB
         GDCEjuSGZNna9QmyiGLkd1KhZgCgoAyX7ZwryeZ9c+1SusRxXy9JDqxZ2n7JPdL4qh5G
         FqmQzrZXAUFtgywjZWtMvwsEmf4iLVbPHN8QJ9XYO8ZdObCnSaOxnwHmRGoJbpyzixz4
         5gjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3Iy0Bp/b2QVgJFT/9/ldpWcxLk9Pn9fZN4I/EPH0lmHv8mP03+voMl2kYjlBEUtawFnkk3Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfxyFGTwBH1hzPd6BPEfFjKz0syOI/fmXxCvVAAz3XLleIsF1w
	/fo9mxnxwwPMRqNrMmYoBJM3ZxrudwgMj/T07W6G1wXa8xiKeQrzdBWb+o9c1radegoFR1XMUti
	4YmTbjXYnJ8ScJ1sC03iK79XPpNoKUj3icQ63xDumGH6vUFigiTtyUg==
X-Received: by 2002:a17:907:5083:b0:a93:d5d3:be4 with SMTP id a640c23a62f3a-a93d5d30c76mr524244266b.13.1727632092392;
        Sun, 29 Sep 2024 10:48:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjqTNCryWEzIqqf/1Btme4Xway6eGbeCP9wgNBqt//k4KeV1eDqkHhHROUxGnKGL7CROE+tg==
X-Received: by 2002:a17:907:5083:b0:a93:d5d3:be4 with SMTP id a640c23a62f3a-a93d5d30c76mr524242566b.13.1727632091972;
        Sun, 29 Sep 2024 10:48:11 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:822e:847c:4023:a734:1389])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297a4d2sm403334966b.155.2024.09.29.10.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 10:48:11 -0700 (PDT)
Date: Sun, 29 Sep 2024 13:48:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: specify module version
Message-ID: <20240929134716-mutt-send-email-mst@kernel.org>
References: <20240926161641.189193-1-aleksandr.mikhalitsyn@canonical.com>
 <20240929125245-mutt-send-email-mst@kernel.org>
 <CAEivzxdiEu3Tzg7rK=TqDg4Ats-H+=JiPjvZRAnmqO7-jZv2Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEivzxdiEu3Tzg7rK=TqDg4Ats-H+=JiPjvZRAnmqO7-jZv2Zw@mail.gmail.com>

On Sun, Sep 29, 2024 at 07:35:35PM +0200, Aleksandr Mikhalitsyn wrote:
> On Sun, Sep 29, 2024 at 6:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Sep 26, 2024 at 06:16:40PM +0200, Alexander Mikhalitsyn wrote:
> > > Add an explicit MODULE_VERSION("0.0.1") specification
> > > for a vhost_vsock module. It is useful because it allows
> > > userspace to check if vhost_vsock is there when it is
> > > configured as a built-in.
> > >
> > > Without this change, there is no /sys/module/vhost_vsock directory.
> > >
> > > With this change:
> > > $ ls -la /sys/module/vhost_vsock/
> > > total 0
> > > drwxr-xr-x   2 root root    0 Sep 26 15:59 .
> > > drwxr-xr-x 100 root root    0 Sep 26 15:59 ..
> > > --w-------   1 root root 4096 Sep 26 15:59 uevent
> > > -r--r--r--   1 root root 4096 Sep 26 15:59 version
> > >
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> >
> >
> 
> Dear Michael,
> 
> > Why not check that the misc device is registered?
> 
> It is possible to read /proc/misc and check if "241 vhost-vsock" is
> there, but it means that userspace
> needs to have a specific logic for vsock. At the same time, it's quite
> convenient to do something like:
>     if [ ! -d /sys/modules/vhost_vsock ]; then
>         modprobe vhost_vsock
>     fi
> 
> > I'd rather not add a new UAPI until actually necessary.
> 
> I don't insist. I decided to send this patch because, while I was
> debugging a non-related kernel issue
> on my local dev environment I accidentally discovered that LXD
> (containers and VM manager)
> fails to run VMs because it fails to load the vhost_vsock module (but
> it was built-in in my debug kernel
> and the module file didn't exist). Then I discovered that before
> trying to load a module we
> check if /sys/module/<module name> exists. And found that, for some
> reason /sys/module/vhost_vsock
> does not exist when vhost_vsock is configured as a built-in, and
> /sys/module/vhost_vsock *does* exist when
> vhost_vsock is loaded as a module. It looks like an inconsistency and
> I also checked that other modules in
> drivers/vhost have MODULE_VERSION specified and version is 0.0.1. I
> thought that this change looks legitimate
> and convenient for userspace consumers.
> 
> Kind regards,
> Alex

Aha, that's a different matter.
Given userspace already depends on this UAPI, it's easier
to fix it in the kernel.


> >
> > > ---
> > >  drivers/vhost/vsock.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > > index 802153e23073..287ea8e480b5 100644
> > > --- a/drivers/vhost/vsock.c
> > > +++ b/drivers/vhost/vsock.c
> > > @@ -956,6 +956,7 @@ static void __exit vhost_vsock_exit(void)
> > >
> > >  module_init(vhost_vsock_init);
> > >  module_exit(vhost_vsock_exit);
> > > +MODULE_VERSION("0.0.1");
> > >  MODULE_LICENSE("GPL v2");
> > >  MODULE_AUTHOR("Asias He");
> > >  MODULE_DESCRIPTION("vhost transport for vsock ");
> > > --
> > > 2.34.1
> >


