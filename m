Return-Path: <netdev+bounces-112358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD2B9387CC
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 05:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6141A1C20C9F
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 03:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D3710979;
	Mon, 22 Jul 2024 03:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFz57Zro"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8719D3D6D
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 03:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721620203; cv=none; b=TCB1X2S7mP3MA7T8JNAMumB1HCb027qu3INzXxlGwM8ebhEWhMLYl11TWbWTQiv6QztoaAl7V/mYEkVDnCMmEZXW0MbFd6Kbm7l0FwEP4pEtvK0k/8xe4TfC3K0ki5YOd2LClAiVYlTaiFhOGYVAg4yX6sLP/PMjyVEia9+hpAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721620203; c=relaxed/simple;
	bh=Ti6oPYb6RXLj68Vd1eFnNpPSMAmsFyazrUgBiUSTB5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGmIEQRqi1k6fDuwVXUkzjDj/bMJDXIZYvHnI4VpaHALuG9lqrSszz9vwioC9eDcTli1hVrHb7ikZHGY5qmNOW/CPpb+XukGO7RAuIXbSshxR9iqxxqGVAmfARb4oSBYKRRqbzladZcBkmlAb8YCr/7R5V4Y2QOYLBqenFIfrOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFz57Zro; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-708adad61f8so2086054a34.1
        for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 20:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721620200; x=1722225000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Or0aQJivQ/iXmh5SXBMEdUOhV67b9P9yrWwq40hNVmQ=;
        b=hFz57ZroG67mcyN7IHkjyBOHD94H+Lf/R0DoL82zTro41eS28aljg5MMVz6ZK8qs/C
         MJQ/0NnJbmnTZgKFxdlLLxxnkoXUGUOW+LzaZm71p/WDTlKk63z2isOsDR1A56zSY8dK
         6hpsTdb7Rb2qRpwOBwcOXEeejrvLmymoqpfrO13WkDxbSyJ/f9wOCEXTg/A8s+6GbAUv
         6LIPWq5zLGxG6rl+0GRVcsTOL50zz6rcVWLebOgJ+O2QVzRYV3dgdVYksRLByhAcjj02
         Ba5hupDpFayx3QShHOfDJADPL4Yw8pVux0VbmNnGINNuEtFbFQS+xdHUH7nT0GErwMR5
         iFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721620200; x=1722225000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or0aQJivQ/iXmh5SXBMEdUOhV67b9P9yrWwq40hNVmQ=;
        b=uSzXoFHnAefLWjh4TlkUkwZoBSu+eWqavjkTaWyPQbtWzhVyEDgtYoEePjvK1K36MQ
         35+ztz0AzDOJu4x2QrMcSznj6SnFYkWinpzcesbi5oC8YItvpS9RTB6d6Px0d0FoDLtr
         CR7Dl4YV3PriAdlwOe+ocORENWRuPpBbK5olk7/UB6YcXPXu0sns0HQ6SnoOdoXntBiW
         AyEIiNge7uJSjQvJVua4RQdFLYddoKamTOSCJbh+B7HbEyGbmBqbrQDcG7BgBvfZ9XO3
         Mmy35jUgnu1YY8rgscnHt0YaLLkW6HdHhO+zojbzluG5NSGpq/o1eGGW11sS2LwMer2z
         XtUw==
X-Gm-Message-State: AOJu0YwnSUuyDXqyry0UXTqO4Oehw0poeO1IhwDJJQCs2O0aVSj+SQRT
	y2hZ4dR5unvC48FQprpNqtA7auywDYG5zHNE4+veKSPKDFoqwvSw
X-Google-Smtp-Source: AGHT+IE18FSblRimlbe29Vk0PNCOdi7Rxkly1iV8GN2AhHczCDiELHzwQKItWGuHJO3NLWUUpVylIw==
X-Received: by 2002:a05:6830:2a0e:b0:703:61ea:f289 with SMTP id 46e09a7af769-708fdbb4afdmr9338246a34.28.1721620200586;
        Sun, 21 Jul 2024 20:50:00 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:7827:1770:9c43:581a:1588:e579])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d10b80ed4sm2637466b3a.59.2024.07.21.20.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 20:50:00 -0700 (PDT)
Date: Mon, 22 Jul 2024 11:49:50 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH RFC net-next] bonding: Remove support for use_carrier
Message-ID: <Zp3W3vZeGui-4Nxg@Laptop-X1>
References: <2730097.1721581672@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2730097.1721581672@famine>

On Sun, Jul 21, 2024 at 10:07:52AM -0700, Jay Vosburgh wrote:
> 	Remove the implementation of use_carrier, the link monitoring
> method that utilizes ethtool or ioctl to determine the link state of an
> interface in a bond.  The ability to set or query the use_carrier option
> remains, but bonding now always behaves as if use_carrier=1, which
> relies on netif_carrier_ok() to determine the link state of interfaces.
> 
> 	To avoid acquiring RTNL many times per second, bonding inspects
> link state under RCU, but not under RTNL.  However, ethtool
> implementations in drivers may sleep, and therefore this strategy is
> unsuitable for use with calls into driver ethtool functions.
> 
> 	The use_carrier option was introduced in 2003, to provide
> backwards compatibility for network device drivers that did not support
> the then-new netif_carrier_ok/on/off system.  Device drivers are now
> expected to support netif_carrier_*, and the use_carrier backwards
> compatibility logic is no longer necessary.
> 
> Link: https://lore.kernel.org/lkml/000000000000eb54bf061cfd666a@google.com/
> Link: https://lore.kernel.org/netdev/20240718122017.d2e33aaac43a.I10ab9c9ded97163aef4e4de10985cd8f7de60d28@changeid/
> Signed-off-by: Jay Vosburgh <jv@jvosburgh.net>
> 
> ---
> 
> 	I've done some sniff testing and this seems to behave as
> expected, except that writing 0 to the sysfs use_carrier fails.  Netlink
> permits setting use_carrier to any value but always returns 1; sysfs and
> netlink should behave consistently.
> 
>  drivers/net/bonding/bond_main.c    | 107 +----------------------------
>  drivers/net/bonding/bond_netlink.c |  11 +--
>  drivers/net/bonding/bond_options.c |  13 +---
>  drivers/net/bonding/bond_sysfs.c   |   6 +-
>  include/net/bonding.h              |   1 -
>  5 files changed, 7 insertions(+), 131 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> index 2a6a424806aa..e35433cd76b1 100644
> --- a/drivers/net/bonding/bond_netlink.c
> +++ b/drivers/net/bonding/bond_netlink.c
> @@ -257,15 +257,6 @@ static int bond_changelink(struct net_device *bond_dev, struct nlattr *tb[],
>  		if (err)
>  			return err;
>  	}
> -	if (data[IFLA_BOND_USE_CARRIER]) {
> -		int use_carrier = nla_get_u8(data[IFLA_BOND_USE_CARRIER]);
> -
> -		bond_opt_initval(&newval, use_carrier);
> -		err = __bond_opt_set(bond, BOND_OPT_USE_CARRIER, &newval,
> -				     data[IFLA_BOND_USE_CARRIER], extack);
> -		if (err)
> -			return err;
> -	}

I'm not sure if we should return a warn/error if user want to set this.

BTW, the document also need update.

Others looks good to me.

Thanks
Hangbin

