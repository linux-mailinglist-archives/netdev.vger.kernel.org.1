Return-Path: <netdev+bounces-230949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B11BF23ED
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 17:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858653BBD4C
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 15:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6688F2798E5;
	Mon, 20 Oct 2025 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="rQtFbdWV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B0B27A442
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975816; cv=none; b=ajMVLUPpcF5RfV74WPBlisTQ390Aki0biKgy4FfxRL0dRYo/jzTUKHNarDiPs7Chtx8ChxyOi2Fh2+ygygk+tOJeItqsmsefdv436OOzj6PBr6HEuA3kKHQvkHC6hg3O1u0fJXIkn7twR8NF8+e4zN/v59tCbGeAT4pKvmHM/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975816; c=relaxed/simple;
	bh=e2llRSe6rBf6kfwlDIh7FJxE1bNsKiQgJihK7id5+48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNzO2x4RRdZ8+nTJ61Lqg6pTI751dQHR2CbMXlA3HtLcKo8zJurC20yddiMFhG29iqH8jIux9sMEuGU1B7bfQelZnLT/1MtTg0GXaGV4BQJgzwFInEnk5OiQFl0MhxntYgrbfZqPLtjZjXKBu3CJAZCaUl/8He9emsRR8kyYZ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=rQtFbdWV; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-88fca7a60cfso820408085a.2
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1760975813; x=1761580613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PS9ppW8BlUDf/OZHMCLmT1BgS/dX4mu/cLIa/oy85v4=;
        b=rQtFbdWVW3jZzkJfTStLkIBqfgWjsVb6rf+BbOR0dp1AMaKxFdfPEAUdIfUW76WXjP
         9CmcdhlW7cV2HPtp9EM8tf2QVdiHA2bMjZYo3mqIo4w4MdYpMt4XmSKqh/gYrZyjLxrR
         WhzshebzMtuFv8tO+N5gMBzRENWX5WL3spubzwAfLrmHFLDVBY7hK4Lw/VmP94UfZeDa
         OexzH2c2vZW/gBasE3Sr1yHoW9eD7Cg56WVHLl/jOKmbPeUrAqxhDqhttlXdIXv/l7ZG
         P9Xh4Cn22irVX5pxe1o9ID8bNyGLghfJ9wh0eHTZZWiFUWLeAxx5Zg/BgHLWgiQO56b8
         K8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760975813; x=1761580613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PS9ppW8BlUDf/OZHMCLmT1BgS/dX4mu/cLIa/oy85v4=;
        b=g99XJUbNxmFRWkV7kn4mDJVeGu3KSljDSg6InWH+uXfQrXtU9SY0wTRGlC4keCAkfA
         6HF2KLPm5y2eIpRprdWP4VoU/RK8X0im7IW8PCgllMqPMMlDOnYEoxoiuy5HnoAuyheK
         6dZBVH4+f1BkaRAcz10clKGYrntnELy3PKgLOmmQKiVwBMDRbj13PBZjBqJ7WZjf2p3p
         wB8iH3FJaDGo1oDzJV277cpNIa1q9RSdrF4nCaHS+/q10/pt23GgcErL2xrHBK5kDQsq
         UKTYfA9EbYPG+7JWB1k0+TBB/4w2ObWbKDm+LocLbhIa37INhAdevqbKWzaoUYpop0Bf
         6woA==
X-Forwarded-Encrypted: i=1; AJvYcCVfxv63PYAc4noXrjbwYzn6zvm4n5/ukR0IFMb4sgvoGl8GhZxdMkHSbArDBYLv4yYL9OL0kbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVVeyigb8lnlgbWoHKkwDsX5PI27IlDLA4g57Q5GIQmgWq27FP
	SMl1shbeh6tZcoL1I2xLivqmRAU397g6QMKlBa9wH+gzZ2fSO1ltjoU5LYMuYLjljg==
X-Gm-Gg: ASbGncvNfzWQ/gqHbV3u36WvF8UZSH9+lh6lvLVdIMPrGw5feQRxqw5VoY8tWDhL7A8
	ehiX9n2oDYOptCLj42UTksvSgscAvNwH8aqvr+4WrQTtkk/ZrqEfbOPJVjVybtCgh8jGJ3i4rDv
	GjJjQd0HyWXU9+3ifUUN137IG/GEZ2kYsNgdcpbEnWPnybuB4/pCN0126H8Y561Yes6BrX5Fla0
	tITh2oiUwtptXc3w1B/dwPimHUUVdEEX2nFluHVAAT2c8vBZnDoIIbkKCxScCnmYVEydYDcZqy3
	EhircmEwkcenPdj2xhSqpbhrKzCCyg6SoJrwGqlhIuc8UHj7fXzQeEUmQypxTtpk/1cYbokXrNv
	tNryTBJ9afc6IYFZNYgUvp9UTLOucX6Xq2k5zxbO2SE0tOR5+GwP9P3dnkuMFNSPJRHoIvEYVWj
	e7fohclYtFP4XoYLSEJLQRnUOT7fLMKdQHMNQ0H7YbNtI+Ulh2sMVs/874qp/HQ4FjW6vrc/IJU
	FHNm/6g
X-Google-Smtp-Source: AGHT+IG/rDU0EjLahTNi6VfthpLTzDexKTzbLVBecb90B5+2WmicLIOJUth/CtS2njAiwWv1qFzLwQ==
X-Received: by 2002:a05:622a:d1b:b0:4e8:a514:2341 with SMTP id d75a77b69052e-4e8a5143538mr121816691cf.61.1760975813506;
        Mon, 20 Oct 2025 08:56:53 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-19.harvard-secure.wrls.harvard.edu. [65.112.8.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028966fasm53806466d6.33.2025.10.20.08.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:56:53 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:56:50 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: yicongsrfy@163.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, oliver@neukum.org, pabeni@redhat.com
Subject: Re: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device driver
 for config selection
Message-ID: <e4ce396c-0047-4bd1-a5d2-aee3b86315b1@rowland.harvard.edu>
References: <20251013110753.0f640774.michal.pecio@gmail.com>
 <20251017024229.1959295-1-yicongsrfy@163.com>
 <db3db4c6-d019-49d0-92ad-96427341589c@rowland.harvard.edu>
 <20251017191511.6dd841e9.michal.pecio@gmail.com>
 <bda50568-a05d-4241-adbe-18efb2251d6e@rowland.harvard.edu>
 <20251018172156.69e93897.michal.pecio@gmail.com>
 <6640b191-d25b-4c4e-ac67-144357eb5cc3@rowland.harvard.edu>
 <20251018175618.148d4e59.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018175618.148d4e59.michal.pecio@gmail.com>

On Sat, Oct 18, 2025 at 05:56:18PM +0200, Michal Pecio wrote:
> On Sat, 18 Oct 2025 11:36:11 -0400, Alan Stern wrote:
> > > @@ -169,6 +175,12 @@ int usb_choose_configuration(struct usb_device *udev)
> > >  #endif
> > >  		}
> > >  
> > > +		/* Check if we have a preferred vendor driver for this config */
> > > +		else if (bus_for_each_drv(&usb_bus_type, NULL, (void *) udev, prefer_vendor)) {
> > > +			best = c;
> > > +			break;
> > > +		}  
> > 
> > How are prefer_vendor() and usb_driver_preferred() supposed to know 
> > which configuration is being considered?
> 
> Currently they don't need to know, but this could be added by passing
> a temporary struct with more stuff in place of udev.
> 
> Really, this whole usb_drv->preferred business could be a simple
> boolean flag, if not for r8152 needing to issue control transfers to
> the chip to find whether it supports at all.
> 
> It seems that ax88179_preferred() could simply always return true.

Instead of all this preferred() stuff, why not have the ax88179 driver's 
probe routine check for a different configuration with a vendor-specific 
interface?  If that other config is present and the chip is the right 
type then you can call usb_driver_set_configuration() -- this is exactly 
what it's meant for.

Especially with that extra requirement for the chip being the right 
kind, this doesn't seem like something the USB core should have to 
handle.  If other USB networking drivers need to do similar things, 
maybe the common part could be put in a library in the usbnet core.

Alan Stern

