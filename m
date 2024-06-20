Return-Path: <netdev+bounces-105343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B2F910873
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D58A1F21F05
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197411AED36;
	Thu, 20 Jun 2024 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD4BqIAp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638681ACE9C;
	Thu, 20 Jun 2024 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893993; cv=none; b=mQag5yUQV6bgarS0VW/iNGj3NVhlLC67fMTLhnHslG7gfyL1cWr85VTfRIAshZZSrwtMXn2+uJXVLLJjQnYVgyCVCD9mBz6u5VtbreMjJHOJ8OJSHMvRNfL7eZZC28YiTWEf/Eqot5HgJY07lq6gFVBCv+ljlVvWwPHI1NM7EUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893993; c=relaxed/simple;
	bh=3S1rGHeeDr5BE1B1Lz4Z3IJPaEAlMpvnN7Y0me36Jh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZkdezhKcBMXQWyBOns7YFI36Iy4xSnmMe5+ubX8gdyN8kz628H1pb9vNKyI7bQQMy6D7KMadoD0DssLNbnsc73gctR4t9m5xRfUgIv7CTzZZHuUGGI/1VZECoEKvHfWvht5CNqBS8AUsHuK/L3gw+V44DsSTGXFEB8ZB6KH/X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iD4BqIAp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f11a2d18aso108943866b.2;
        Thu, 20 Jun 2024 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718893990; x=1719498790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p5JUxf1dRJZ2nkIoYDpwtiaH12dkjhTgvPAQMnYCvqE=;
        b=iD4BqIApCrqqUeCCwVcFj67rzB6IRXU46jWtbUD/X2Vrx3n5wpaN5zjVARyEjrRMrL
         d5h/JPrgp4t48C+w+hcCy/uRSNVPvPKU9eV6+HjFZzkl9deusC/zzXPVxqC4YZN0WGSF
         HwSj36vSTxYrbqT5Ygzi0PNxqZuQFoFB7akN/2i8u0nNrx6PjrQbo6aRvP79+e/rc5h2
         eLNDoqWRFJjNo8VrWNcKhjU6G4BwkT/Y0gcexX/etrNzM5s8D0hN2q8BYikFSfMA5lj6
         A/7HM2MzRTm8Lgy6OHwpOk5trE80PZEvkm5K5EU8S7zWkCWP5+EUz0hc2mMazioD6bwT
         bPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718893990; x=1719498790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5JUxf1dRJZ2nkIoYDpwtiaH12dkjhTgvPAQMnYCvqE=;
        b=ZM7TFgCl1TXT0zSMJ66Kqofa/QLq9tn6AqPElVilnXLIZVR/7N4gtq2+8H0fzXFI7n
         dIMhkOcXTFgNnYmYM0Opa4idPjoQgVzGbL7CBvnf98LuElRB22fdTXwrhRDp0dLstjub
         rIrgQ3EORgeEs6fnNx+Tw2DgxxxebwDtnG0AOLJKbGUzfEGXhBJ6S6RPqDTeTPmXn7lI
         DRtnAQqkANJ7XYXHSLrPkJ+nde9nz4OWIG75SJTWhmfdd7q4vZ/6RvIsf6cNX9NP7oZj
         pINhFdZwjE0lmVqdmao2MKZ9C0vMUuRAgXx+SNCSxBMrb3LDvDk9NI1SkfGrBAzlvirF
         zPwA==
X-Forwarded-Encrypted: i=1; AJvYcCV99uSLrRVtLn1ChxoNXW+WvITNaqbiRZ8Izfp3Nb2UOX/jaM5u0oG+F1LTkb7tLOkI8uF0PiE6YOFbKHhLqK3l+WL2PRnCQfEVAZCx5zfFXCcJtswL6EcaFa8LpPyAb+U7KA4U
X-Gm-Message-State: AOJu0Ywpy44AJ27qwtcJorogv7XMxWJJLtwPE/vcEXP0z4K7zziK0iDZ
	1go5SUQ0CIy/k7vMqJteBrt8tBdSusChEBFVLfJ+mB/9ZX33ikg4
X-Google-Smtp-Source: AGHT+IGwPM+MslC/IvL8O/QFgjff3jPsnubAaQxGFKfIqZQf+HnEieuGG2haWaisL19k9sdLazIapw==
X-Received: by 2002:a17:907:a684:b0:a6f:b284:4279 with SMTP id a640c23a62f3a-a6fb28442b4mr325445766b.36.1718893989469;
        Thu, 20 Jun 2024 07:33:09 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f41700sm774485266b.152.2024.06.20.07.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:33:08 -0700 (PDT)
Date: Thu, 20 Jun 2024 17:33:06 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Message-ID: <20240620143306.f6x25tqksatccqwf@skbuf>
References: <20240619134248.1228443-1-lukma@denx.de>
 <20240619144243.cp6ceembrxs27tfc@skbuf>
 <20240619171057.766c657b@wsk>
 <20240619154814.dvjcry7ahvtznfxb@skbuf>
 <20240619155928.wmivi4lckjq54t3w@skbuf>
 <20240620095920.6035022d@wsk>
 <20240620090210.drop6jwh7e5qw556@skbuf>
 <20240620140044.07191e24@wsk>
 <20240620120641.jr2m4zpnzzjqeycq@skbuf>
 <20240620152819.74a865ae@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620152819.74a865ae@wsk>

On Thu, Jun 20, 2024 at 03:28:19PM +0200, Lukasz Majewski wrote:
> I don't have xrs700x to test. Shall I spend time on fixing some
> perceived issue for IC which I don't have?
> 
> Maybe somebody (like manufacturer or _real_ user) with xrc700x shall
> test the code and provide feedback?

One of the basic premises when you introduce a new core feature with
offload potential is that you consider how the existing drivers will
handle it. Either they do something reasonable already (great but rarely
happens), or they refuse offloading the new feature until, as you say,
the developer or real user has a look at what would be needed. Once you
get things to that stage, that would be, in my mind, the cutoff point
between the responsibility of who's adding the core feature and who's
interested in it on random other hardware.

Sometimes, the burden of checking/modifying all existing offloading
drivers before adding a new feature is so high, that some offloading API
is developed with an opt-in rather than opt-out model. AKA, rather than
the configuration being directly given to you and you rejecting what you
don't support, the core first assumed you can't offload anything, and
you have to set a bit from the driver to announce the core that you can.
qdisc_offload_query_caps() is an implementation of this model, though
I'm pretty sure the NETDEV_CHANGEUPPER notifier doesn't have anything
similar currently.

That being said, I think the responsibility falls on your side here,
given that you introduced a new HSR port type and offload drivers still
implicitly think it's a ring port, because there's no API to tell them
otherwise.

This is not to take away from the good things you _have_ done already.

