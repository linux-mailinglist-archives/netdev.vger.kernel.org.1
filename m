Return-Path: <netdev+bounces-181919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D5AA86EC1
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 20:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F13457B1981
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 18:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E511F8BD6;
	Sat, 12 Apr 2025 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwfd9vXs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2658F14AD20;
	Sat, 12 Apr 2025 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744482657; cv=none; b=pMoQhL/LP0+iTqHb8Y2y2vCUdY94TPtkab176sXggHPmabiovYc45+oivCVwyECFP9rGN3nA0KbAzy6JpxzErIo+B97d6x1k+SLIMtXSECHH9OUmbze5cl0mUSOGglMI/ytxwiOjRgwXbvj/y9ZMPNAYjs1a+2712UYVS+i1T4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744482657; c=relaxed/simple;
	bh=RW0z1C49PCxVJBw7xcIdXUKGnyC3SVpPoZLg2Z1sipQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNHkBnwk6TptsgVWwQorQRQyMGPK0hhQ6yOd4CpNM4mp5Zq6CiK7map7YtVfJmPBytXKpoy4ST7ALdWYkX8L5K4H/n0pELX7BfzEdMy4+AFOtAchGf11Xy9NIjiTNNDUl8q6k4AUjHB5BP1jD8TdVciN+ruIWlVUAlQiRqLfk5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwfd9vXs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so24076665e9.1;
        Sat, 12 Apr 2025 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744482652; x=1745087452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9I1yayD3cf1v7RYAxVVYTY6w58aLvRc+jXpIiCDAY18=;
        b=cwfd9vXszu/PfoXbxXLmHPRgJ5b+ZcztuQJqtq3cBTtcHpcsDnLuWVlaMQlD+rDQ/P
         e829a/768+uG+K7G4cvltDS2+LN631RC/kqwp60UNYarLatbH1pdDqje2diYcyejpVxQ
         woFlHg6YcC95gbpQluy8nTYv8620X4n0ckp7aJmbzFW/hJfK9zRKTD+LsSHY4sRuEzal
         oQXmXrPkE8V/+2zz1uSMGGjggCgbd1A83Ji0bqP50cl8RsYHgXIeV7KvEAsuEY64EySE
         tQXEnmmmiPjFZaibfcdmZ8Z9wgcNASuA9wWwgtleUdLmAVeUmdMqksdg73FrYEWjFcbn
         3CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744482652; x=1745087452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9I1yayD3cf1v7RYAxVVYTY6w58aLvRc+jXpIiCDAY18=;
        b=MurJ8ws2GCTkZFZn8nbPx4rfqe321rhHb+EyYAtn/jmCGmpmOeU8jstHMSF/FPC63Q
         qg8VP8phf33yQfCW/iJMxGig4Z6Gywx2UySTmGixPfl791YKuAXTve7fLMj1AbgvnifW
         ZIJAu2IwC8L4bQtILsbuEI8V/wPcc++XT/e1rAXYJvwNke0WGw+3SheqtPzTxgKLEphe
         fwPqdyJH5DaK9BhZKMsTfnps4mBHzYmzbP+rN/3eJwdyIt0rkXZxMts7IOxRbxGxmvnY
         N9SuRAb4Le7DHnpjQInH9msROJVbZDNeIclCoOwdC4DW2AixaEJj+/6+z41TOpFC57RQ
         L6Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVKEB5Jw2qdootgfMTh2yEPtrYkFUP7JA1CZs78Q6XhQxq4gyzAKt0vz2DNT9QPQBzs5jNDguArcSzYQRA=@vger.kernel.org, AJvYcCXHT0nGfJIEKC6rzOPSdTCz2oJ9cWf4LUl1bqNSnrTDFLpl+pXBgZj4CZApiF90Ndj5XWJdClEI@vger.kernel.org, AJvYcCXdr5GnjHq2kDQVUa5t4RKZ3XLzmYZnh03LRAW1mWVQAjdxDRy+N74Tzb68GigD5Ks1AWIlx6Ur6lCL@vger.kernel.org
X-Gm-Message-State: AOJu0YyWpzTUi3vGjyphmfSQC3+DcRBI6cUKdkrMVZHwIjuniS1xxMg4
	gevIk/OO52jVAxQyiUx1MkG7ncd1U4ViHb33Nts7m6JVZtgL9rOR
X-Gm-Gg: ASbGncuBzpgk8v91SDFzLNDSN6GDHfI94/GIGbsTEXIeF3jUKiCwpvqgO+PFhOA/drk
	Be8SZzyWgme6ol4vKY/la9+Im3YQ5Ak3CTWGcKNub3PxbAZe5QwSvusl32DxOrvDXVZC5G8bNrF
	zoiooib6w/ft8i3SYTQ8jN4qgH+As3Lt4XSx/SWqWgXWK8x8zJpZcqV0ElnbnOjKZPc2Nq+aQA4
	83e1oZBS0INmrpW4OVHwE5YYX6maESuIouQOC1fHikBPP7an37IlVxdb/rYQCMNHMd0D6bDXsAW
	DeYfCMmxyYfUaofGfACUxW+rcrjJ8M+toHiKbRBtp8YA
X-Google-Smtp-Source: AGHT+IGnll0hR3wPHlESkLrYLAgonyfJaX6StTTM1pbJ2ipqv900Tg6e/VoeEcs2wFQpnA/CzW2vSg==
X-Received: by 2002:a05:600c:1550:b0:43c:eea9:f438 with SMTP id 5b1f17b1804b1-43f3a95b76bmr59786675e9.15.1744482652068;
        Sat, 12 Apr 2025 11:30:52 -0700 (PDT)
Received: from qasdev.system ([2a02:c7c:6696:8300:f069:f1cb:5bbc:db26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf445315sm5699769f8f.82.2025.04.12.11.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 11:30:51 -0700 (PDT)
Date: Sat, 12 Apr 2025 19:30:36 +0100
From: Qasim Ijaz <qasdev00@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
Subject: Re: [PATCH 1/4] net: fix uninitialised access in mii_nway_restart()
Message-ID: <Z_qxTN9_xJuEd2op@qasdev.system>
References: <20250319112156.48312-1-qasdev00@gmail.com>
 <20250319112156.48312-2-qasdev00@gmail.com>
 <20250325063307.15336182@kernel.org>
 <Z_hC-9C7Bc2lPrig@qasdev.system>
 <c8ebd8a1-cfdd-4a27-8cb6-114ea60ba294@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8ebd8a1-cfdd-4a27-8cb6-114ea60ba294@lunn.ch>

On Fri, Apr 11, 2025 at 03:12:06AM +0200, Andrew Lunn wrote:
> On Thu, Apr 10, 2025 at 11:15:23PM +0100, Qasim Ijaz wrote:
> > On Tue, Mar 25, 2025 at 06:33:07AM -0700, Jakub Kicinski wrote:
> > > On Wed, 19 Mar 2025 11:21:53 +0000 Qasim Ijaz wrote:
> > > > --- a/drivers/net/mii.c
> > > > +++ b/drivers/net/mii.c
> > > > @@ -464,6 +464,8 @@ int mii_nway_restart (struct mii_if_info *mii)
> > > >  
> > > >  	/* if autoneg is off, it's an error */
> > > >  	bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);
> > > > +	if (bmcr < 0)
> > > > +		return bmcr;
> > > >  
> > > >  	if (bmcr & BMCR_ANENABLE) {
> > > >  		bmcr |= BMCR_ANRESTART;
> > > 
> > > We error check just one mdio_read() but there's a whole bunch of them
> > > in this file. What's the expected behavior then? Are all of them buggy?
> > >
> >  
> > Hi Jakub
> >     
> > Apologies for my delayed response, I had another look at this and I
> > think my patch may be off a bit. You are correct that there are multiple
> > mdio_read() calls and looking at the mii.c file we can see that calls to
> > functions like mdio_read (and a lot of others) dont check return values.
> >   
> > So in light of this I think a better patch would be to not edit the 
> > mii.c file at all and just make ch9200_mdio_read return 0 on     
> > error.
> 
> Do you actually have one of these devices? If you do have, an even
> better change would be to throwaway the mii code and swap to phylib
> and an MDIO bus. You can probably follow smsc95xx.c.
> 

Hi Andrew,

Thanks for the suggestion. I don't have one of these devices at the moment.
If in the future if I do I will definitely explore the suggestion more.

Regards,
Qasim

> 	Andrew

