Return-Path: <netdev+bounces-226703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B123BA4365
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A3857BCCAF
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 14:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DF21E5B60;
	Fri, 26 Sep 2025 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2MvHb/I"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68C71A3A80
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896809; cv=none; b=liekfDJmCOBgyw2HKSeG1X9Ksu86j3ONGpfyQcFYTqffTYrn4Lb9XfqHe3mmP4bgTLu1ep7GA4qdTlk0Wp+B3yILPjyPCTLuuvLXH9MovovGDc0zFHHPoApPzHQEcLhpwrhADYqof88ow2h5z0Wq6U3hPkUgyl3fh5cokV9jRv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896809; c=relaxed/simple;
	bh=d6I6D4UoA2fdvHaowOZB0/hBshkYl4/Hv4eNcR8VvOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eari7LJG3n5gttJPPnZtmaXkm8kKpXOqugpQ4ze2pMbFxmtR4oEJUBqdTR09KTQPXFXwNTxm0BGxNA4NMFwMTa5LJdvgb5o+96cNu1YnUsROLzSUq1MUkUoNdQsaMjJdjC/bcXJE7qw13H2kwRownS2TB7gbFBgWbCHSRAV1tNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2MvHb/I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758896805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iatcngeh1af6TFJNiZJ9BJOYb6Kr+OAIH3TZvj018HE=;
	b=A2MvHb/Izj5Z2XpxEv4DOPPHKKrTGByq13jUz3qDImUZCjDEi2MSXyS6FSpEVXZsObs4hu
	Pz7wRhxGJ4I57A+vVqMYU4wAdS2MrK3SlvwcQI/tltF2XVpWyObuq2jX4kUC4jOmG6k1AY
	y3ImwkrIc/Wez2dqWrOxpOMaKsuUs+w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-N6I4HquvN4iaYM1ixRuvoA-1; Fri, 26 Sep 2025 10:26:43 -0400
X-MC-Unique: N6I4HquvN4iaYM1ixRuvoA-1
X-Mimecast-MFC-AGG-ID: N6I4HquvN4iaYM1ixRuvoA_1758896802
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso1615388f8f.1
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 07:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758896802; x=1759501602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iatcngeh1af6TFJNiZJ9BJOYb6Kr+OAIH3TZvj018HE=;
        b=NMxyyJVhAKJmktnzWuPPHavN9J8epNG/sRRlqC/Wu43IEe+VbgOKI2spDN0wXIyi9l
         coEajEOOADWc6xO2SrMEEUmYMpVwX1ABQo/SRKmeymmL68/eILwtmArftE7mugQqdfKO
         g/ykmcLMcM/r3E9YoC/U7OwoVuizIhsW/rMmTGDotx1Kx40Fr6M7E97TbW5cF5VsPMEp
         TkbOOSS8/l+RXWbBkjIEcf3FU4t4YbzdAmfxa1ZgKVrZwgS4V85alrUf0ODxlrdES07w
         0ii+nBbYYEaxTqsAxpqV0VJbLG5YZm1XeK90PGouZPDdA9NDOk2DihZLBHIkKkD0+4+H
         l4Og==
X-Forwarded-Encrypted: i=1; AJvYcCX3zpArLrNYNVsFWU9WUTODHV4fL3vWaJDU0xY8CZIb4ty4P+4M3AYnsa9Kzj9y4ACCDSAMnL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMltv2CjZ3qrW/rAgY3ZMrLcxN2o5J3GvFWHgmP2KGbfy1hSfe
	LAPesYNwEFqugW7Gsg2rJBcH1b/a3dzROkG0VOFBYcFfDoPyyPmBW1DUKxc/JqeONntGS19lrE6
	hA2jYr6ECE/uOOQ6NZXgeI06GkRYZCnJCC6L6u80tdSSvlP2aramot3qnoQ==
X-Gm-Gg: ASbGncsz63jNqSdFl+7Lzc0lkBxvHONITf/YT/e5Ze1POr+k+JBmY3lJ3R+IOQOHjl7
	hJwXZ5RkIpX6VR3SakDiayk0K4gnBbXAA7zZW7s3gfZ/sB4KHfjPfGDW4rfk/vWIhUSrawyFGlN
	PuevsYo2a6YduurcHefZamZUwedEIjIOnRGSxR65Mcqxe7+dd9f5Z+cD7gMI/S0f3sy27j5ENIU
	vksB5weTgmrW2hz1KOXlxqybEd5KvWebHVcryKtt6fBTaNWJ1608XOv1h3EEX6tgs1wEiUBrPqJ
	hfinudi6mZLjei8zB40Fl44kjO7A20RsB6E=
X-Received: by 2002:a05:6000:22c7:b0:3ec:e276:f3d5 with SMTP id ffacd0b85a97d-40e48a56cddmr7464909f8f.42.1758896801802;
        Fri, 26 Sep 2025 07:26:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWQlwY9F5xZyQ8nyaSheZAwSNVELpvaScMCCct/EGl6ilha7T/oo9BNopzjhdDydTGuXSdgQ==
X-Received: by 2002:a05:6000:22c7:b0:3ec:e276:f3d5 with SMTP id ffacd0b85a97d-40e48a56cddmr7464874f8f.42.1758896801163;
        Fri, 26 Sep 2025 07:26:41 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602efdsm7576564f8f.34.2025.09.26.07.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:26:40 -0700 (PDT)
Date: Fri, 26 Sep 2025 10:26:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	alex.williamson@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
Message-ID: <20250926023237-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-2-danielj@nvidia.com>
 <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com>
 <20250924021637-mutt-send-email-mst@kernel.org>
 <CACGkMEuWRUANBCkeE5r+7+wob3nr-Mrnce_kLRHbpeF0OT_45Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuWRUANBCkeE5r+7+wob3nr-Mrnce_kLRHbpeF0OT_45Q@mail.gmail.com>

On Fri, Sep 26, 2025 at 12:55:11PM +0800, Jason Wang wrote:
> > > Looking at this, it's nothing admin virtqueue specific, I wonder why
> > > it is not part of virtio_config_ops.
> > >
> > > Thanks
> >
> > cap things are admin commands. But what I do not get is why they
> > need to be callbacks.
> >
> > The only thing about admin commands that is pci specific is finding
> > the admin vq.
> 
> I think we had a discussion to decide to separate admin commands from
> the admin vq.
> 
> Thanks

If what you are saying is that core should expose APIs to
submit admin commands, not to access admin vq, I think I agree.

-- 
MST


