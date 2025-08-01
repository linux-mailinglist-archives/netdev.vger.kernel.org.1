Return-Path: <netdev+bounces-211363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E632BB18405
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 16:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4913F1C2718F
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 14:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F6A256C83;
	Fri,  1 Aug 2025 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb1ziA0A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE5021ABAD;
	Fri,  1 Aug 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059075; cv=none; b=j1vX4sxDBy/9V6dZTwFcqXEynBHVvZlW6gWZLLnMVjOpSW1T5tIjTZH4DNJPH663swVCbGq09emFMBJei59mi3kRaxS5dw3mAviL+SgIWAnHZt1J6cCGxk0ktxsizTFhc2oSUH4G6DY4j2LJHazFCsTphZkxl6hHe5FLu+ql0bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059075; c=relaxed/simple;
	bh=+XF6yjXcxLQIbrAsZMYEVZBgCBcPV2NMJeR7aT3pBPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlMbXhRCZJbhnymOifc8QMNWxVqC3zqskYEoiuEl7YejtdoEzg6u81bLwkYUmMiW9Sh3w5KWPHq90wbb1YvOiVQz95BPsPzJeR7FO+tFh9+joQFP0VbdsnYCGozbbLsgJ0IJZLanoriM8lNMzD7S8gwW6WwsncJxLXnW3HG/RMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jb1ziA0A; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-455f151fe61so1881775e9.0;
        Fri, 01 Aug 2025 07:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754059072; x=1754663872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eaWMGQT2XZF0zuRN1qxbhYwli8Qn/DH5XeR8hdE3Zpo=;
        b=jb1ziA0AQga8n+erlP+LQVYugEGdxdJ9+owfSpqMvJHnmcLK6H+TNU2n6e1l78IxE7
         oU2xs1JNun30GJ6e+gaEpNweym5vP2A/OOHKoTW0D79tMphhw65fd8rKLBS2pSOKMWq8
         ktx5Biq6DD/UrSblgBZwTTz6G0/2QpSHBhnN4WNlRY1GJx1No50bj3MulVUpn863prhc
         KjLjfEeTU4D39Q+KRYufwIfKwl1jCikKQIeR/GSuvvemAWH/9am40nHtzGzoK66BEZ8e
         rROGG2N7KM7W5Noof8jXyjIPs88Rmh+jO/N8dkskA5xJPj0uE482oT6mwiwbnxwThnm+
         8VWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754059072; x=1754663872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaWMGQT2XZF0zuRN1qxbhYwli8Qn/DH5XeR8hdE3Zpo=;
        b=pEf5TZo5hJURLIXK8ZKxMSW+F1dW9ko6QORXcygwp8IDJ6/TLJq3k8dJs/sdMQNilA
         uSgEScKeG+d89zJbCDhtuc3S6kNRJBzfWO6MaDAxt3LHRuZOLki8/krP7cxROPHWMSyF
         JMlA+sabkP8hsx0B1VxSLsBaoqIR1BL6EDQIO/znTqv1CxNj1dh6Hyo6czdl0uAy9jMG
         iADvy4C0BFMqfBVtbIcOWzlVSSV/XqWuJ5KQ20kgAdSI9fbAICpmKKAVJHaA47G1KQhn
         1XalAjCsNqoxptXRtmT+BXtWQmEumv2VZTBIITzre/y/la12WCH/WriidoCSmB6BRcZ2
         Dbzw==
X-Forwarded-Encrypted: i=1; AJvYcCV6T/P0xvkrmm0IJiBdPyCTJgYJTFlMMDWjjToz1N3zkpkyLaqA/rGiPB4aNIMLKfgxg83qO36j@vger.kernel.org, AJvYcCXFfkWanysNblFdxk9+lFO3te54VzqigI9aJhUfI7iRueJV+W2B616CuKC1b56eQexzYd/X16MIo4TZJyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXsutqzPrQtrkTNL+nwkd81OWTD1x5isB29yaFgxFNXTiPq91N
	TJ0PIGNXn10+X85vw5mrZ+Kmn3iFXQC6293YnKUq1u3LvsyYMEK+cnAZ
X-Gm-Gg: ASbGncsS3jHRCGyOWy3I3waCMrQAPQ+dY1I7Zp6+y9g250k7P91F085dFvfVrdHWJgn
	7klTvJrTzG6Dg/cozuFd5IuSvRmT/5FsbHGJKUJnYbCLhYC1bKH8b0+CeQNyvyPRHT4hgawpeBx
	lGpR7lkw5xRQ7iskBa3KjE1q0nCDZZHgagHzMfBgbB7HGBdM6OtNintk/MHwe0U0FhNSQjwcAIh
	nRGsGmrO3X9hjtZQvsn7tx6C59jXqwelo5MzL+R5lWPhsZR/1dDFL7vu22YUcibytVBAnCBV0na
	Y1UwyfbkLh/MSzpBf62NrbK169NUr12IRxdhZc2W/n+QuL8EHJNBMJZUU/ncGOHNgwPelJIs7+T
	9w4BG6aPNzSth4H/JP5e3HD9udg==
X-Google-Smtp-Source: AGHT+IFQSGujFLymtt+7W9RElumjhKkLpu+6d1wLH4LW3Puhu+kn+azvFhuphDGxKATMhZp9flLTHg==
X-Received: by 2002:a05:600c:19cc:b0:456:c48:4907 with SMTP id 5b1f17b1804b1-458b0c21eacmr7758165e9.0.1754059071849;
        Fri, 01 Aug 2025 07:37:51 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d30d:7300:b5a7:e112:cd90:eb82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abedesm6209527f8f.3.2025.08.01.07.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 07:37:51 -0700 (PDT)
Date: Fri, 1 Aug 2025 17:37:48 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <20250801143748.q2bchvxkci7in6cj@skbuf>
References: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
 <20250731171642.2jxmhvrlb554mejz@skbuf>
 <aIvDcxeBPhHADDik@shell.armlinux.org.uk>
 <20250801110106.ig5n2t5wvzqrsoyj@skbuf>
 <aIyq9Vg8Tqr5z0Zs@FUE-ALEWI-WINX>
 <aIyr33e7BUAep2MI@shell.armlinux.org.uk>
 <aIytuIUN+BSy2Xug@FUE-ALEWI-WINX>
 <aIyx0OLWGw5zKarX@shell.armlinux.org.uk>
 <20250801130420.m3fbqlvtzbdo5e5d@skbuf>
 <aIzI5roBAaRgzXxH@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIzI5roBAaRgzXxH@shell.armlinux.org.uk>

On Fri, Aug 01, 2025 at 03:02:14PM +0100, Russell King (Oracle) wrote:
> It looks like the SerDes driver is managed by the MAC (it validates
> each mode against the serdes PHY driver's validate function - serdes
> being mac_dev->fman_mac->serdes. If this SerDes doesn't exist, then
> only mac_dev->phy_if is supported.
> 
> So, I don't think there's any need for the Lynx to reach out to the
> SerDes in mainline as it currently stands.
> 
> As the SerDes also dictates which modes and is managed by fman, I'd
> suggest for mainline that the code needs to implement the following
> pseudocode:
> 
> 	config->supported_interfaces = mac_support |
> 				(pcs->supported_interfaces &
> 				serdes_supported_interfaces);
> 
> rather than the simple "or pcs->supported_interfaces into the
> supported bitmap" that we can do in other drivers.

The PCS needs to reach out to the SerDes lane in the more developed
downstream code due to the need to manage the lane (software-driven link
training according to 802.3 clause 72) for backplane link modes. The
AN/LT block is grouped together with the PCS, not with the MAC.

This design decision also makes it so that the other non-critical lane
management tasks (initialization, power management, figure out supported
interface modes, reconfiguration upon major reconfig) are done only once
in a central place (the PCS driver) rather than replicated at the
following PCS consumer sites (MAC drivers), which all need these features,
preferably with a unified behavior:
- drivers/net/dsa/ocelot/seville_vsc9953.c
- drivers/net/dsa/ocelot/felix_vsc9959.c
- drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
- drivers/net/ethernet/freescale/fman/fman_memac.c
- drivers/net/ethernet/freescale/enetc/enetc_pf.c

So, in downstream, yes, the MAC acquires the SerDes lane using
devm_of_phy_optional_get(), but it just passes it to the PCS and lets it
do the above.

