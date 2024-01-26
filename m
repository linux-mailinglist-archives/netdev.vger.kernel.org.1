Return-Path: <netdev+bounces-66080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D83183D294
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 03:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2011928D93B
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 02:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4981C17;
	Fri, 26 Jan 2024 02:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="rlQ+xDLI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E48BE3
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706236596; cv=none; b=QuyQPg9YtFSxcAlglKr9LGTDGlJqw6Q3cunpsrpX/J2GY1ipNEqRXosY/zEu0/SKhNiAj1vjUqTgwPo5yiEhzaRJfu9tV6cZ1tssRRzcaJyrRH+SzOhYJYI/CcJ+sf/5WB1EcQP9r39kEl+qvbwWKy6+HijppYu9105BfsvyFf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706236596; c=relaxed/simple;
	bh=06iOWtBmY1uz/cbk56SyVECHI/J8jgo6lHGM0mSRSdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acjhAkWfVjv+bqTNQD7a4JvS7S81YNl6nZdiuH/bqtsrvB0A6Mx/rHHrd+Xpv72qGz1GH7MiASXvBzy3jv3+CjlQ469BjSM28HwtnhONT8nXGBmIWBajxTG/m8svZr1QPxoHNl+KtsyfA9eWu+zqVzPaxyvNPExhGf0+N0c/AoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=rlQ+xDLI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so286692b3a.0
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 18:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706236595; x=1706841395; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6B1vw/CIwx1Do8klJnuzzBB1TAr7vs5mOYS9VgO2qwk=;
        b=rlQ+xDLIF9YkOxlYbX1Pa/jH709CJKK3pnqW5OqPJkQ5DjkYzTQU84zQp4ledB8xbl
         bVjdi6/SGQSW6ZlmLrZ+vyJe469NiWBLDbnJy0r6bXNi9C/b4Y33WZ7dy1SweMu9vmUx
         z3YTRVZQS79/RiorZzAyARyjAi38iXLtdDPzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706236595; x=1706841395;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6B1vw/CIwx1Do8klJnuzzBB1TAr7vs5mOYS9VgO2qwk=;
        b=VCLSrYGETq80CaoDYHsO4lYhEkKBX8GKHmhisBHxr/7Dm2KxhvK4BuNKvK1eV964C6
         OLdA2/hmys9A4dcKbjOZvZUu1JczY2yAGwV72IaWVDSf74M6kwQpzaD1S56yzMfVMt3y
         BlqOBuF4cDhAIacCAf9GmMvgkY7HwZmnA+EpPkfaGsrpGPPxqctvaCJxbR3PUl5PpMKH
         wYM0cWlaKMWoaBFjs3uOwQeW6Gm9m2CW2nmRkRx7LHXGrDf1zc6bfYd53nKzqXXatAMJ
         82UJaeCYdtiv6jFLJMuTALRyBTxf/bW6P4EIy6T1/Twmsrsamv0mibRsStbfTv+JCJJI
         vmSw==
X-Gm-Message-State: AOJu0Ywjg4He39jsG9pAFXjLYFgdPK3K0yIqV5mp1s6Nb9Wy48H0BHsQ
	zi9fgy1SQY7qnCgXptmtUwsouF7uZSm+WXxp2AJ/sKzpsLWtIrAK5fQjbAzjIwM=
X-Google-Smtp-Source: AGHT+IFZBZg5EPv1XzUPhN040Dpw3PbiPtsmYRCU6w52snmy8gDwXg2o9W7xOOc88roFZeqJ6p5cQQ==
X-Received: by 2002:a05:6a00:4583:b0:6db:d93e:5cdb with SMTP id it3-20020a056a00458300b006dbd93e5cdbmr632741pfb.15.1706236594820;
        Thu, 25 Jan 2024 18:36:34 -0800 (PST)
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id o123-20020a62cd81000000b006ddc133f1d3sm222692pfg.194.2024.01.25.18.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jan 2024 18:36:34 -0800 (PST)
Date: Thu, 25 Jan 2024 18:36:30 -0800
From: Joe Damato <jdamato@fastly.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, edumazet@google.com,
	davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, kuba@kernel.org,
	willemdebruijn.kernel@gmail.com, weiwan@google.com,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Steve French <stfrench@microsoft.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jiri Slaby <jirislaby@kernel.org>,
	Julien Panis <jpanis@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Thomas Huth <thuth@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/3] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <20240126023630.GA1235@fastly.com>
References: <20240125225704.12781-1-jdamato@fastly.com>
 <20240125225704.12781-4-jdamato@fastly.com>
 <2024012551-anyone-demeaning-867b@gregkh>
 <20240126001128.GC1987@fastly.com>
 <2024012525-outdoors-district-2660@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024012525-outdoors-district-2660@gregkh>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Thu, Jan 25, 2024 at 04:23:58PM -0800, Greg Kroah-Hartman wrote:
> On Thu, Jan 25, 2024 at 04:11:28PM -0800, Joe Damato wrote:
> > On Thu, Jan 25, 2024 at 03:21:46PM -0800, Greg Kroah-Hartman wrote:
> > > On Thu, Jan 25, 2024 at 10:56:59PM +0000, Joe Damato wrote:
> > > > +struct epoll_params {
> > > > +	u64 busy_poll_usecs;
> > > > +	u16 busy_poll_budget;
> > > > +
> > > > +	/* for future fields */
> > > > +	u8 data[118];
> > > > +} EPOLL_PACKED;
> > > 
> > > variables that cross the user/kernel boundry need to be __u64, __u16,
> > > and __u8 here.
> > 
> > I'll make that change for the next version, thank you.
> > 
> > > And why 118?
> > 
> > I chose this arbitrarily. I figured that a 128 byte struct would support 16
> > u64s in the event that other fields needed to be added in the future. 118
> > is what was left after the existing fields. There's almost certainly a
> > better way to do this - or perhaps it is unnecessary as per your other
> > message.
> > 
> > I am not sure if leaving extra space in the struct is a recommended
> > practice for ioctls or not - I thought I noticed some code that did and
> > some that didn't in the kernel so I err'd on the side of leaving the space
> > and probably did it in the worst way possible.
> 
> It's not really a good idea unless you know exactly what you are going
> to do with it.  Why not just have a new ioctl if you need new
> information in the future?  That's simpler, right?

Sure, that makes sense to me. I'll remove it in the v4 alongside the other
changes you've requested.

Thanks for your time and patience reviewing my code. I greatly appreciate
your helpful comments and feedback.

Thanks,
Joe

