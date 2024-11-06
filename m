Return-Path: <netdev+bounces-142290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC1F9BE222
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCD51C20F04
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917051D61B9;
	Wed,  6 Nov 2024 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDisDVqY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACD71D88D7
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884577; cv=none; b=QZOApF2f/9kk4V0bYYhq9EYGpGnzypV1ZZ/XLCvqPCHnHvA3CCSmXG9MkDm9l2Ol4QGD75VUaZII72DhykIPUoQYP8d3/TOsYpral4qLgQ5x9aVdaViwlln3m0itndMu6EwhpOx7dlrCLsw6dbJM2GqvWoiLoXkIQ/TwT9ocD+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884577; c=relaxed/simple;
	bh=LiWfgtP3ccuFSeeihkum3Zsw2j+Q/tBTiOLrwo9T6sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O93r9t6VIbYD407zojpYPq0Mj9GFqtmXP/F3hSK0AM+8Y8dn3mrPNhwEOBBT5kwFS3XVc4HMJYMnYSuGQqBaxY8kLEbkzJt2xrIqXX4itrQJURuxr4HUUNGXZnGLFan4NuZn2Rg6Dr3mINnQp1b7biWLaQiZB9Tl43hqXcKfEUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dDisDVqY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730884574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hpGds3rrLDrDyMfb6nHlArwXd7ub7kAc2WQ+kRP5Q+E=;
	b=dDisDVqY4QlJ5QW4nhmmxaroLl4MTzN6F8FMCuFfAHe8bGIza5VvYAfVihlPzbHgP/gx2s
	dAKkrTDfsavaO02Y9igr1+FX7do/BnAQFm9ighlotFToZgm9ga/mItEJ1JVXEWmroRVLja
	N0afElM2KQmHeF2V5ftMo/Xmv8rHmDM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-6rS7le-INSOcWpa2olwKEA-1; Wed, 06 Nov 2024 04:16:12 -0500
X-MC-Unique: 6rS7le-INSOcWpa2olwKEA-1
X-Mimecast-MFC-AGG-ID: 6rS7le-INSOcWpa2olwKEA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5ca5bfc8so3199920f8f.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 01:16:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730884571; x=1731489371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpGds3rrLDrDyMfb6nHlArwXd7ub7kAc2WQ+kRP5Q+E=;
        b=vb8f6qJTx0S511lX34yOF4iBGKszrYDYGLcAl3K4E2OM7YuOn3DV1jLeYzuUnqloUu
         bVVJ7BIe6vgrTnyaMxMwtP3O/5fZKoDKpW3rI1ZzzRAwvQ/It1dRUIbQPycWKNEBWy9t
         9cMfgqueDjNSbK9/WMg+F0qrMdyn7E32NN+8aS9XPlQqM6H+xafjNZCYExqGnKEVR9Sn
         i15RclhLczNR4CN+Xb5O0nvQaHS9oOopwIdv6S/b0fLLbib5v3iqtpwe2nWiaAhPuLCP
         8R7BHZ27eSh2E1ebFFdVfKZT872UhqXLeMBOWbBaVhyYj6BMunjZ9air9bCQ+vJLxHDm
         MBKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuYKNVVMeKdgT1LVv5bwS4lZj1T9KG1ElvXzYsGBv2uJTutQHaomO23h+kBglFe+pr6OO1rME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ysa0naovRgedPbB2XEoe1xfBzSvM13AWsHJGUSAQPQarmNcY
	JE4sZRe2iaNU3Bei29y+BYELPcnHKm8nlKbgAh2EdJd0Hn12CQFlX193DfVGGqc8/iJ1gPRMMic
	mT9ev12BzLK3jOpAIP+7KamcRIE7oM3UMR//3kFA0d+6dYOT9J6Ceig==
X-Received: by 2002:a05:6000:178a:b0:37c:d227:d193 with SMTP id ffacd0b85a97d-381be7654bbmr19918780f8f.10.1730884571477;
        Wed, 06 Nov 2024 01:16:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzRwU2TOM2eQPF5E6Rf2mNxBpWaMzmZbkkznCCrfo7GyAOnLbimkewh0GmBs2JIyl8mHd0hQ==
X-Received: by 2002:a05:6000:178a:b0:37c:d227:d193 with SMTP id ffacd0b85a97d-381be7654bbmr19918753f8f.10.1730884571022;
        Wed, 06 Nov 2024 01:16:11 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5e56sm15522815e9.2.2024.11.06.01.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:16:10 -0800 (PST)
Date: Wed, 6 Nov 2024 04:16:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v1 0/4] virtio_net: enable premapped mode by
 default
Message-ID: <20241106041545-mutt-send-email-mst@kernel.org>
References: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com>
 <20241104184641.525f8cdf@kernel.org>
 <20241106023803-mutt-send-email-mst@kernel.org>
 <1730882783.399233-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1730882783.399233-1-xuanzhuo@linux.alibaba.com>

On Wed, Nov 06, 2024 at 04:46:23PM +0800, Xuan Zhuo wrote:
> On Wed, 6 Nov 2024 02:38:40 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Nov 04, 2024 at 06:46:41PM -0800, Jakub Kicinski wrote:
> > > On Tue, 29 Oct 2024 16:46:11 +0800 Xuan Zhuo wrote:
> > > > In the last linux version, we disabled this feature to fix the
> > > > regress[1].
> > > >
> > > > The patch set is try to fix the problem and re-enable it.
> > > >
> > > > More info: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> > >
> > > Sorry to ping, Michael, Jason we're waiting to hear from you on
> > > this one.
> >
> > Can patch 1 be applied on net as well? Or I can take it through
> > my tree. It's a bugfix, just for an uncommon configuration.
> 
> 
> Why? That can not be triggered in net branch.
> 
> Thanks

I thought it can but can't remember why now. OK, nm then, thanks!


