Return-Path: <netdev+bounces-68841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4526E8487C2
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 18:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D611C22291
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 17:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF3E5F546;
	Sat,  3 Feb 2024 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSunQajl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081495F85A
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706979862; cv=none; b=ZZqqRJZkKMMBj9E+ZKGEsm0KjkQGT1WFSvOCQWWZ8AUOyzPkqpOEoSi5jFU4PDuaLI0pU+3CkkqkMo+N/ZQFqno48wgjGmDf9FTME3dHpl2z7HtBYFzqTH5zYCG+h66MX3w+4ooWJsNUP8c3DmIS6DNJ3MHYi092HMkbI39XLLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706979862; c=relaxed/simple;
	bh=JS50oKo5z8wqVAqJflt8wvdypBalGYMeyi7so4j9LWo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mq0Y+K+w8gDw8VfawC09s+EpUrvXOPJ9dteP9rgr96EtuqgOhlSq3gNwmsBepyGwSL0DANF8pTLfuXuRfAL7bCQyUyOmEySYBKkKRkYZPf+GVkA496uMobCeu+92MuvNXSDA2rAKxh+QjDpCyqgtqfRQm7mjOFzzoIunB1Pc0T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSunQajl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso25253215e9.0
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 09:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706979859; x=1707584659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TBi/Nc1i2t/W1SgnYyQ4Q7g6GmRkbvT5WO516nweNOI=;
        b=XSunQajlzM0fAxLWV8xrMXnV+8+Ut+wrMe8Bx1+4595hgZBtVXvnuPAC0xjKBbnQpn
         bfoEt3RfjaRHWApMnH11ECe29GXvsf2TLTU82INnN2+iHRiVUPO+sFRIaxOAYW/gKVxq
         Fl0k7R4l5iZjoVxsv2LWFoN6P0G5zPgYCsMsXIPfwNibJttszA3be9fpROlxvFC6rzKS
         xrMHmWZ20JifTaZ2TENtGN2Ugs92f3QFSZ6p3zncZT3SDaVESi4QdHeSOM6jTxoaPwt4
         GAMemf3WmJRhG6eTcxIT8L669aQ9QoK+lCBen08KFCf4Nvmx23/l3FAdv6f4lkqRkJJz
         muaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706979859; x=1707584659;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBi/Nc1i2t/W1SgnYyQ4Q7g6GmRkbvT5WO516nweNOI=;
        b=TXeoTLMBNj3U6QzV4GCuoHan78F87p4GmU9bV5OFg7LAHMJwpuRApgqOl+dWNMYo1f
         Ttw5jQspCK+mf0leYZZ8Fw9SugdYLVLCaWeiUZT/8xpj6pztk/uUSN4v4TgxT6VPIBBE
         EKcL9SmrnvFkTcNl2vhyoP7Nuxlv8DnOtrnFsWJzbd/nl2hMHMBqYJtFPiCV1av0L4XA
         I9xZzp9txiVn3eBVNBHEAwJ7+GekQVSp61dbnZQE6czRLXWvgcOQiBWWbVQjQ0X1iElM
         KeVSDcUYPh1FwiuLleGPG65w0S3uHEeWMYNqSjPlHvyxfzerM2DiZtdARjnFqTfIooIG
         60JQ==
X-Gm-Message-State: AOJu0Yxi24GoddF1N5+sOukMks5g/xZz82R1QqhjufOsXRMy90J75jqp
	YmRSMMnLbOupL7DfmcZxzNuuCQ86QRs9H/0rS/1hm/ueD93P4ltW
X-Google-Smtp-Source: AGHT+IE2sRCo9aMUzcE2BowU+Tg9+phzkpzCtpC1KXuZjX5RRJvtWkA1jPMnVFLoMJV9aMaBH3SvtQ==
X-Received: by 2002:a5d:60ce:0:b0:33a:e838:7184 with SMTP id x14-20020a5d60ce000000b0033ae8387184mr6084806wrt.2.1706979858843;
        Sat, 03 Feb 2024 09:04:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVGozpBKo6LgmM9JZVgj2YEAGMNedxJBZwlTNFYAhUPsG0n+6pq8aoJapjkw7R3BhlcyLCsX212Kd9uL0dS6DvvjmuAs25FceMbBLR9AdHeZn031MgX9AoAxNA3ZTCXvAh2Z0APxJRXFPWCK4A9mUd1MHNQkCC10RKEZDtIs+1jO8HoCd+ZxAqZsMaMw7xeXQXd2XTRdpirPhIlKlTsZPHabuTJw4Ty8+5Wgrm66THEK9pxodQEA81OVs364lFchl/sfpW9JgNEXy0S2pZ5TkRQZT2SGV+P8WJm2GiT+BxPWtajWMl4aA==
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c260d00b0040fb0bf6abesm3380368wma.29.2024.02.03.09.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 09:04:18 -0800 (PST)
Message-ID: <65be7212.050a0220.d2de9.e25c@mx.google.com>
X-Google-Original-Message-ID: <Zb5yDmEVrXv71c7_@Ansuel-xps.>
Date: Sat, 3 Feb 2024 18:04:14 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next] net: phy: constify phydev->drv
References: <E1rVxXt-002YqY-9G@rmk-PC.armlinux.org.uk>
 <7f4f7fc2-6bf3-4ecb-9c13-763e2d4f176f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f4f7fc2-6bf3-4ecb-9c13-763e2d4f176f@lunn.ch>

On Sat, Feb 03, 2024 at 05:56:19PM +0100, Andrew Lunn wrote:
> On Fri, Feb 02, 2024 at 05:41:45PM +0000, Russell King (Oracle) wrote:
> > Device driver structures are shared between all devices that they
> > match, and thus nothing should never write to the device driver
> 
> nothing should never ???
> 
> I guess the never should be ever?
> 
> > diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
> > index 7fd9fe6a602b..7b1bc5fcef9b 100644
> > --- a/drivers/net/phy/xilinx_gmii2rgmii.c
> > +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
> > @@ -22,7 +22,7 @@
> >  
> >  struct gmii2rgmii {
> >  	struct phy_device *phy_dev;
> > -	struct phy_driver *phy_drv;
> > +	const struct phy_driver *phy_drv;
> >  	struct phy_driver conv_phy_drv;
> >  	struct mdio_device *mdio;
> >  };
> 
> Did you build testing include xilinx_gmii2rgmii.c ? It does funky
> things with phy_driver structures.
>

Looking at the probe function it seems they only swap phy_drv with
conv_phy_drv but it doesn't seems they touch stuff in the phy_dev
struct. Looks like the thing while hackish, seems clean enough to follow
the rule of not touching the OPs and causing side effects.

-- 
	Ansuel

