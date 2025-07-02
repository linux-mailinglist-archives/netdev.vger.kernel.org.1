Return-Path: <netdev+bounces-203410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC48DAF5D57
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2035A3B9E65
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC76303DDF;
	Wed,  2 Jul 2025 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSPoU5uz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F7A2FF483
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470420; cv=none; b=DM3lLFRO6Qx0qLrJR2/yd2z5+vfxlADEjQoi2QQ35/h+HHLErDvzmu1maavTJs7s1D+fZTPv1Y/dL270nBsunpsoEi76TokaSwGUJkz7et3IgIR32HYd6bzSbgLcnu/mZpjgsjNDNl9LqKdehJclYvxRJxHT2OhIYBUPf4Arm9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470420; c=relaxed/simple;
	bh=obDyf6FXbOYTWIuD3KSMiI8nmtrN1gR3/HHyGMdPab0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UX7W/8UVC/grJDtHBpYKsvI4CtIWSge2XqL9OTcUyX/ovVm40RvRYv7LPS6hjcnEg8Yp3DGDaSHgD4bpdpXLYJL856H50N87vp0ASNKdnrTUcapFANt3vnbEY2M18L6HBNxEqWgJgaNvs5W73Z12vRZWcXnXbIzop+zI7j9SSWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSPoU5uz; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7490cb9a892so4968786b3a.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 08:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751470418; x=1752075218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XokiYEzaoR1B14/T6j1v6mfh/QyFdt9cJod/XCOiF/Q=;
        b=ZSPoU5uzCwNDNbkjBuWhZaJxDWC6Y7k716STWCYIpF61RBtZleSfVnKazgonDQqveX
         fme4Kgl19Rc7z5Luwduh1/0NqV0xNIMVSUvEY/Jr0Q+HH1Zu3+8PdjxP4or1oNKfS2Rh
         5X6np41J905l7QYdDN4727W6MuHXHikpdHwKyYu09fod4pFQME4VI9hXRjCnYWS0Uwok
         flxedua/rp6RZz2vf3sujEO2wXMIz6/FWX4H9sqUmzDQWeTbi3QsRFVL6zuFSWhqftOe
         AHqh4ILFOpHTzzcIGuS21nLMBpXZO5cSiz0ISDdfeGBEmVzhgEvy/wrQbMusJcSNRcUI
         ZepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751470418; x=1752075218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XokiYEzaoR1B14/T6j1v6mfh/QyFdt9cJod/XCOiF/Q=;
        b=HHXIP4DH9SxWVfV3UbEwYfs7quQCZ3DvhOTWsbrqlOZzbwwa6jQ0DuDzPPHlUZ5xym
         j3JR2sEcNJK2WfI37cP3p0C2mI6KsTqIx9WMIuxTldUBlHOV4ulW+0cPxDNwc03fXl1I
         O5g5Z3YxrTsiN9jQmIoZXfJADtCowQEQqTpL+UMbpEG+N2YuM2dN9JYaQUcgmE3fWYOn
         QdJ4/qQpjbsOzG/D8RkcnMurUwT70MGq7Jude9fqFKacEpymv4WcxPZzNik+VtdZm562
         WCTtLzch57DxS5HDloWNqeSbPovifdKavoW3LCvREqQRoG7txMiOWmHh/v7dPXtojwGV
         YXyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsa/HdxSAfCQ2zhGqmb6C2IZ2GUhWsQX+V/XC994YD4SPS0MbdvAnwE44uI4jmTTeqmLmIxAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Wh105EVo6uvPBsj0jKr+hyFDbDAkSYlf74ZZo0CkzEInkm7b
	iloQY/2RbbcpXw5M7h3oDxlBrbwey4i54TYIp85jv1NLmDhmTroXER8=
X-Gm-Gg: ASbGncviyQ3UQsYScW504bXjmWaMGcL8JzVtqBSyRfwcgyrw76IiNRh2F1R4GedRr/t
	2+6SEOq7sTAKh+qDGDa47l12YLHf6B5+314n8nbT55aYQctsVObXW+W61/WKvZs7LXztdnnK/iK
	QragY9KuEbOpW0QIn3aBg3attLoCm9IbCXFJBH73vEONpJyHiuSCq8Ni8qTZlF5SCpB1FrShMsj
	l6vObWyZat7GgHwmCW16nOcai0Qxb9vTP5LN4w3TAHUfU6EatDd+/zD8+j8nZQF5OwwC+MIHdaQ
	JjZAZB97gL16hiiWM+ZqGpxQpAhPcI0p2J6kq70ogA364eDXI1amR8Xmdn/ixo/iBk/QL5M9vMD
	MStlezt2jGSEFj+SMAKdr8w0=
X-Google-Smtp-Source: AGHT+IGK4tHNVwEemyWXzdZf+tbHSzBbkjEWlOeifCheAQoxdwi0i+7rhIoh5aYtR5BFwTpZ9dV60g==
X-Received: by 2002:a05:6a00:4fc1:b0:748:e4af:9c54 with SMTP id d2e1a72fcca58-74b50e84130mr4786184b3a.6.1751470417717;
        Wed, 02 Jul 2025 08:33:37 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af557b27dsm14722787b3a.84.2025.07.02.08.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 08:33:37 -0700 (PDT)
Date: Wed, 2 Jul 2025 08:33:36 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 3/8] net:
 s/dev_get_mac_address/netif_get_mac_address/
Message-ID: <aGVRUCTYNt_aMkQz@mini-arch>
References: <20250630164222.712558-1-sdf@fomichev.me>
 <20250630164222.712558-4-sdf@fomichev.me>
 <6862fb095090_183f832945b@willemb.c.googlers.com.notmuch>
 <aGMbe0hxH78xQvD8@mini-arch>
 <686430091cc2_20bfeb294fc@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <686430091cc2_20bfeb294fc@willemb.c.googlers.com.notmuch>

On 07/01, Willem de Bruijn wrote:
> Stanislav Fomichev wrote:
> > On 06/30, Willem de Bruijn wrote:
> > > Stanislav Fomichev wrote:
> > > > Commit cc34acd577f1 ("docs: net: document new locking reality")
> > > > introduced netif_ vs dev_ function semantics: the former expects locked
> > > > netdev, the latter takes care of the locking. We don't strictly
> > > > follow this semantics on either side, but there are more dev_xxx handlers
> > > > now that don't fit. Rename them to netif_xxx where appropriate.
> > > > 
> > > > netif_get_mac_address is used only by tun/tap, so move it into
> > > > NETDEV_INTERNAL namespace.
> > > > 
> > > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > > > ---
> > > >  drivers/net/tap.c         | 6 ++++--
> > > >  drivers/net/tun.c         | 4 +++-
> > > >  include/linux/netdevice.h | 2 +-
> > > >  net/core/dev.c            | 4 ++--
> > > >  net/core/dev_ioctl.c      | 3 ++-
> > > >  net/core/net-sysfs.c      | 2 +-
> > > >  6 files changed, 13 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> > > > index bdf0788d8e66..4c85770c809b 100644
> > > > --- a/drivers/net/tap.c
> > > > +++ b/drivers/net/tap.c
> > > > @@ -28,6 +28,8 @@
> > > >  
> > > >  #include "tun_vnet.h"
> > > >  
> > > > +MODULE_IMPORT_NS("NETDEV_INTERNAL");
> > > > +
> > > >  #define TAP_IFFEATURES (IFF_VNET_HDR | IFF_MULTI_QUEUE)
> > > >  
> > > >  static struct proto tap_proto = {
> > > > @@ -1000,8 +1002,8 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
> > > >  			return -ENOLINK;
> > > >  		}
> > > >  		ret = 0;
> > > > -		dev_get_mac_address((struct sockaddr *)&ss, dev_net(tap->dev),
> > > > -				    tap->dev->name);
> > > > +		netif_get_mac_address((struct sockaddr *)&ss, dev_net(tap->dev),
> > > > +				      tap->dev->name);
> > > >  		if (copy_to_user(&ifr->ifr_name, tap->dev->name, IFNAMSIZ) ||
> > > >  		    copy_to_user(&ifr->ifr_hwaddr, &ss, sizeof(ifr->ifr_hwaddr)))
> > > >  			ret = -EFAULT;
> > > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > > index f8c5e2fd04df..4509ae68decf 100644
> > > > --- a/drivers/net/tun.c
> > > > +++ b/drivers/net/tun.c
> > > > @@ -85,6 +85,8 @@
> > > >  
> > > >  #include "tun_vnet.h"
> > > >  
> > > > +MODULE_IMPORT_NS("NETDEV_INTERNAL");
> > > > +
> > > 
> > > Thanks for giving this a go. Now that you've implemented it, does the
> > > risk (of overlooking callers, mainly) indeed seem acceptable?
> > > 
> > > Documentation/core-api/symbol-namespaces.rst says
> > > 
> > >   It is advisable to add the MODULE_IMPORT_NS() statement close to other module
> > >   metadata definitions like MODULE_AUTHOR() or MODULE_LICENSE().
> > > 
> > > No need to respin just for this from me. Something to consider,
> > > especially if anything else comes up.
> > 
> > I put it at the top because it was at the top in bnxt. But it is
> > at the top in bnxt is because the MODULE_LICENSE is there :-(
> > Thanks for pointing it out, I'll definitely address that to be
> > consistent.
> >
> > > Just curious, did you use the modpost and make nsdeps, or was it
> > > sufficient to find the callers with tools like cscope and grep?
> > 
> > Only grep. I'm hoping the build bots will tell me if missed something.
> 
> SG.
> 
> One tradeoff with this series is that renaming and refactoring always
> adds code churn that makes backports (e.g., to stable) more complex.
> I trust that you weighted the pros and cons. We just need to be
> careful to not encourage renaming series in general. Hence calling
> that out right here :)

Yeah, agreed, that why I'm only targeting the core<>driver api boundary.
Which still might be, arguably, too much :-)

> And, it's not trivial to review that the now netif_.. callees indeed
> are holding the netdev locked (or RTNL). Does it make sense to add
> lockdep_rtnl_is_held (or equivalent netdev lock) checks as part of
> this series or follow-up? And the inverse for the dev_.. variants.

Ack, let me double check whether adding more lockdep calls makes sense.
We already have a bunch of them deep down in the call stack,
that might be enough, not sure.

> Aside from this high level points, overall series LGTM, thanks.

Thank you for the review and feedback!

