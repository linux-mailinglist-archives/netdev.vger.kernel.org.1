Return-Path: <netdev+bounces-202692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A52AEEADD
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141393BD8F6
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 23:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7D22571B3;
	Mon, 30 Jun 2025 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1u/p5l0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F95242D8B
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751325567; cv=none; b=sNZ8lHDj4GHlYHhWVFXYgR57Bg+X6KQ5fyNecHwsPT4WiO515x2rQCxi6zHOGW1KCa6ab4fwd0VHFZozAlzT5jwBYqcfjhxLKw6mcO6LLm34rVHyPLb8ZqNwWn2QDL6P3robaNFijV7Ivqfx5jXWEghuQOSi9hhoU/hUzURndGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751325567; c=relaxed/simple;
	bh=ZOWwMkPugCqYb4okP6m2GQK0+ZqfJg4uuM3P81LTZA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8PgJjFaBSKdTE68CKIHtzgmQAi4SFLKA3U91i1NWWAvbdELMLayfHoaemdGN+e3FiCTIis6VbGtQA5knhg+JQCpzttTLpyP3xAZEhrt/UCC3ew7AncxXoZ5IgpdJfWhpTfx7Qm9Zu5VXnL54nE/wTDkipKojV8ZuYQ7iJQ9K1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1u/p5l0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2366e5e4dbaso50602215ad.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751325565; x=1751930365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FKYycyQNJc2kuyAEeFDjHNHU1XJSG9fuKpxnG6NwmAQ=;
        b=U1u/p5l0JjJb3x7obp1hJVnUGjw2U6sXpp77oxwquv8RQFf1H3cc04ujwRKJSpcJNA
         hwpeeZcluHqJsO82O835RZTVuV9nweao56o7TMQwaLS+5VgBxmdOn/vALX8u7AkwEMoh
         qvOVFtHQoS1W0PrQatlVUnMTdbb+VTGtaoGqBfhodTT9R6kekRW4aXn8vj7d3fqfBdjL
         vmfKhbk5+KiugEek4WexIVlmaYTUEAkVKgu/5cfXIPgKORvjit8VtYy4M6jwiZuCbwbr
         7QBbOcfoSbP/J71Ey4YNqDc2DPiDsfmutSUIYYCjccQxDjz7QJNdjGbXrDLfz9m68UKv
         M69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751325565; x=1751930365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKYycyQNJc2kuyAEeFDjHNHU1XJSG9fuKpxnG6NwmAQ=;
        b=ILzDltLsVBhoEaxnl3M/wjESnILuDTtM5gfWIbzqNQ/bVOBwBxOyvxRKJn+QFj1lU3
         g5OBcKqu46NjYFtjFQh0+GSo3cDQNQHL+dJ1UR3puGTJ7d9fXbeQ7NiU45cRx9Z2OH1q
         cleEh43Kfx9KGebp/iRYKF1X19Fu8Nbsa8f+4vKABeTUdrycXJLo8CpP0dNGlCkAakgm
         b/rvP/HfU3A+FrYLSfYzu72oTc17JvVEet6Vm8QfOY8l71+UyOt78uMHZmthUCXTCU6X
         8xDOHANTtCZWEfpJwa2Zg6sgdQyofPLohNS+w/HFkIIEilHm3/5D/NTDOofz/UlW7gDP
         ijQg==
X-Forwarded-Encrypted: i=1; AJvYcCUWhPhI+AlNb+TbzHI97V+5GS8nqM+XHwiv1umZbFzQohS2ravdo37BqbN/JL0BVAPPWm+hh8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygwx/baY+23jwAbpH5KVqiBwKQ1yNm6BoVWDkrT6dUKCvcG9L3
	9Mwdcywl6X++ViFd2m9tnbvoRaBMa4kX3O6GWDIHSsJSPjTiBzdlD5w=
X-Gm-Gg: ASbGncu0czSmfvEeo9GiuJ36intP4I2TZ3iKXTU+G8YCphp7mVqwU3iif60vdMFwvW5
	Pd4VTc/ScZqXyhfnkili/pcUk+6KFgwvtxbFtOEHQKNlXUaKvaHCIaqn1JjWS2aH9VB23AoA5ko
	xIETZLuU23AqiR8HsQQfCUqulNJpUx0axCqdD+3WlVU9xiq3tljSmUXIfCvAqMtKqUkHuAhnAFT
	So5WVbmXakgHRdvo6NsNnluMIElrqeKpPLVOsNCvDiJuMC8IcZ79qBi+pri8RAqc1XoYYetEVnr
	2P7LP0BC8lL3BaWsWSS9k945IlfRk/gq3pb8Th02PE3c3ToOwQGhqQrwyYkU00IwcysHdLCVEFt
	9i74Fjchqgc7tue77+L9fMuY=
X-Google-Smtp-Source: AGHT+IHiJjKJX94x+EVwBcooR5SIpxszLcIvPYZHKiBFwZZ0JNHQfqNzlYCeBwzBe+5CPAG05IStHg==
X-Received: by 2002:a17:902:ea0d:b0:22e:457d:3989 with SMTP id d9443c01a7336-23b35389dfemr21812585ad.0.1751325565197;
        Mon, 30 Jun 2025 16:19:25 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3b7abdsm94158585ad.169.2025.06.30.16.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 16:19:24 -0700 (PDT)
Date: Mon, 30 Jun 2025 16:19:23 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 3/8] net:
 s/dev_get_mac_address/netif_get_mac_address/
Message-ID: <aGMbe0hxH78xQvD8@mini-arch>
References: <20250630164222.712558-1-sdf@fomichev.me>
 <20250630164222.712558-4-sdf@fomichev.me>
 <6862fb095090_183f832945b@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6862fb095090_183f832945b@willemb.c.googlers.com.notmuch>

On 06/30, Willem de Bruijn wrote:
> Stanislav Fomichev wrote:
> > Commit cc34acd577f1 ("docs: net: document new locking reality")
> > introduced netif_ vs dev_ function semantics: the former expects locked
> > netdev, the latter takes care of the locking. We don't strictly
> > follow this semantics on either side, but there are more dev_xxx handlers
> > now that don't fit. Rename them to netif_xxx where appropriate.
> > 
> > netif_get_mac_address is used only by tun/tap, so move it into
> > NETDEV_INTERNAL namespace.
> > 
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  drivers/net/tap.c         | 6 ++++--
> >  drivers/net/tun.c         | 4 +++-
> >  include/linux/netdevice.h | 2 +-
> >  net/core/dev.c            | 4 ++--
> >  net/core/dev_ioctl.c      | 3 ++-
> >  net/core/net-sysfs.c      | 2 +-
> >  6 files changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> > index bdf0788d8e66..4c85770c809b 100644
> > --- a/drivers/net/tap.c
> > +++ b/drivers/net/tap.c
> > @@ -28,6 +28,8 @@
> >  
> >  #include "tun_vnet.h"
> >  
> > +MODULE_IMPORT_NS("NETDEV_INTERNAL");
> > +
> >  #define TAP_IFFEATURES (IFF_VNET_HDR | IFF_MULTI_QUEUE)
> >  
> >  static struct proto tap_proto = {
> > @@ -1000,8 +1002,8 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
> >  			return -ENOLINK;
> >  		}
> >  		ret = 0;
> > -		dev_get_mac_address((struct sockaddr *)&ss, dev_net(tap->dev),
> > -				    tap->dev->name);
> > +		netif_get_mac_address((struct sockaddr *)&ss, dev_net(tap->dev),
> > +				      tap->dev->name);
> >  		if (copy_to_user(&ifr->ifr_name, tap->dev->name, IFNAMSIZ) ||
> >  		    copy_to_user(&ifr->ifr_hwaddr, &ss, sizeof(ifr->ifr_hwaddr)))
> >  			ret = -EFAULT;
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index f8c5e2fd04df..4509ae68decf 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -85,6 +85,8 @@
> >  
> >  #include "tun_vnet.h"
> >  
> > +MODULE_IMPORT_NS("NETDEV_INTERNAL");
> > +
> 
> Thanks for giving this a go. Now that you've implemented it, does the
> risk (of overlooking callers, mainly) indeed seem acceptable?
> 
> Documentation/core-api/symbol-namespaces.rst says
> 
>   It is advisable to add the MODULE_IMPORT_NS() statement close to other module
>   metadata definitions like MODULE_AUTHOR() or MODULE_LICENSE().
> 
> No need to respin just for this from me. Something to consider,
> especially if anything else comes up.

I put it at the top because it was at the top in bnxt. But it is
at the top in bnxt is because the MODULE_LICENSE is there :-(
Thanks for pointing it out, I'll definitely address that to be
consistent.

> Just curious, did you use the modpost and make nsdeps, or was it
> sufficient to find the callers with tools like cscope and grep?

Only grep. I'm hoping the build bots will tell me if missed something.

