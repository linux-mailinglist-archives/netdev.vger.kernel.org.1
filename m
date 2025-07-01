Return-Path: <netdev+bounces-203028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 046D8AF0340
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 20:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41314168912
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575F127E075;
	Tue,  1 Jul 2025 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgwbwwEN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1F226A0E0
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751396365; cv=none; b=rJ2j07yljj4t4/00d7ZqNAx828oa58w2XFB+UcwvyD3TZ82NjPnEyxUcb7R8pfEXyyW6h9Z8ITmyUDrwz31BDPVUMoOGq97Y7Egj3eQL4Ga8ukzjcDNTk1WcCZL/6ELvHRtX/4ejlcD4ee0i79uFyw9l3MF8QOswAiVwbPZrUXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751396365; c=relaxed/simple;
	bh=zgYeSF5dGDxtYfe8jBmRl0b05biGFBNlbuVBrzStqtE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eXxJkD3M7qYcKLnXf7UV9qO1GSeI+sawi9uMPX9g0T9R3R23oMudfJtS+MwqTHTBPUroLNuJNM3Eat7h4CaimhdjLaD7o593YYvfIW7u1PMZ976ECN91QXeG2L7Cm/2Vp5DWBUxCYsSIKPepQzRImtFeQ+W6KuYvW60Al+9uKsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgwbwwEN; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-711a3dda147so65712337b3.2
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751396362; x=1752001162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFWG/HS9+KrSBtcNMXCL1/vQp/1CG9WSbumFTI/Gyw0=;
        b=JgwbwwENvTWZLqREThAQxGT0XtrlNcKSE3bXHFod5aTD72WXV4m1K4ICYPy1uJgmWR
         BzhM1uhI9sk1+kBOUPlgjoAGxvsigYQu+aVSf1JQTEatDpgdQgo3xIu88c4Mg6FiO455
         xZaN3FOjBYwi2xhv3nNE7gZtKAphmX4a1Bj0uNqEbDMT5LQlmBmFkTypRzVLqaDZcMHP
         dOQUMo0GEbDnT3m0nHV0t15MYv1Teff/BoIrfUXS7zmQq66kAMDeh5NVf9ObfdUO4xY1
         Hv7WdO796W2Hsaeh9XnqaOAvfyW5wk9Zh7L8RYxKS+O7tKWKOXPLYCpa/WGNsA3n1sfX
         1HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751396362; x=1752001162;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zFWG/HS9+KrSBtcNMXCL1/vQp/1CG9WSbumFTI/Gyw0=;
        b=YPg091JvnYnL9qwG7a8+j3VHY7mfQpq7CRleqPluVDSXckZsYWWGvoKIMDO1YvzieZ
         3SzMTsoQktP8YQOr2FPbBN1b7da3NXb2+1ak7p7iObZmz1kDR6NYZerBPabqpr/QLMVS
         XOwKZRLS67mC9L+9niR20gp2y7Zv9reKnhHVxoKSzZWJJFD4TJHfBZ94SgDtFj43zgPy
         jgvTrHqNiYUR8vbBhNWlBeSdpWTCTKMvzFbzQVashrbEsCSYkGDbtinjlagh1j2rCzIq
         y/86/cypZLowSrUi12Kn3HQne2vuBxnLYp+eRRx/MX25OMJUEREKeQkk/bKDeeIegPSU
         vkUw==
X-Forwarded-Encrypted: i=1; AJvYcCU0l3xzSSd5+Tdazyqzx+9/JtYfOvni9Q/1r+2o9AKNTJFI8Maje7nF3MMsNfMXOyswZ+Zoeeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwv//5aMxvGhu3mnKXNl9us6obYLM4CADua924IGxVzu6Bx7Kx
	N8QKq/5hXHgU+zzzBCfWPnNtH6DowlETIsg/XbhvUdMuq66tgxulwgvy
X-Gm-Gg: ASbGnctd6aZEp6huxoeVRvFjmt3LemlhfNmZN95hsT123OshyD6VPwt+Q/ylqV/31em
	7lZRZX6Dtvq2TDX4vbw3dB82kae6h4NuMToCDgbzTyQwIJ0FSNJYc8lyT4Sm++8IWjVWSWrXyHG
	xDoJnbabotNYn3+1vchy7urVH3MshYMvDOZSyMGo0uzffIpppmBR0qRa7OwdRrEYmaTh5DNoDzT
	Z4FEzXTlpFkhl3lYKt18526t7qV6epfSs/imyg35+8ZoYj01+0rd28tzakfjPTPQ6H+VhQe3F9C
	QXmKuq3PspFMddQ7SEOYSP7JZAz0Yp0XRb+Cl0y2sDzW5c/4A2unldD4Q7/eVFYyaktJmB8LvM9
	HLRPY6JuFH2ozzDLi3vpxVGYrIKqpMDXBo5bXTe8=
X-Google-Smtp-Source: AGHT+IFQV3umX+3OhrCTAllZt7XS2olxkoZiS/E8nGV1/I8jUX8vRwy5nqg0dnUfxgAhV9ZroCCayg==
X-Received: by 2002:a05:690c:60ca:b0:70e:70de:6512 with SMTP id 00721157ae682-715170c83b0mr264126827b3.0.1751396362481;
        Tue, 01 Jul 2025 11:59:22 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71515c90280sm21367047b3.76.2025.07.01.11.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 11:59:21 -0700 (PDT)
Date: Tue, 01 Jul 2025 14:59:21 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Message-ID: <686430091cc2_20bfeb294fc@willemb.c.googlers.com.notmuch>
In-Reply-To: <aGMbe0hxH78xQvD8@mini-arch>
References: <20250630164222.712558-1-sdf@fomichev.me>
 <20250630164222.712558-4-sdf@fomichev.me>
 <6862fb095090_183f832945b@willemb.c.googlers.com.notmuch>
 <aGMbe0hxH78xQvD8@mini-arch>
Subject: Re: [PATCH net-next v2 3/8] net:
 s/dev_get_mac_address/netif_get_mac_address/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stanislav Fomichev wrote:
> On 06/30, Willem de Bruijn wrote:
> > Stanislav Fomichev wrote:
> > > Commit cc34acd577f1 ("docs: net: document new locking reality")
> > > introduced netif_ vs dev_ function semantics: the former expects locked
> > > netdev, the latter takes care of the locking. We don't strictly
> > > follow this semantics on either side, but there are more dev_xxx handlers
> > > now that don't fit. Rename them to netif_xxx where appropriate.
> > > 
> > > netif_get_mac_address is used only by tun/tap, so move it into
> > > NETDEV_INTERNAL namespace.
> > > 
> > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > > ---
> > >  drivers/net/tap.c         | 6 ++++--
> > >  drivers/net/tun.c         | 4 +++-
> > >  include/linux/netdevice.h | 2 +-
> > >  net/core/dev.c            | 4 ++--
> > >  net/core/dev_ioctl.c      | 3 ++-
> > >  net/core/net-sysfs.c      | 2 +-
> > >  6 files changed, 13 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> > > index bdf0788d8e66..4c85770c809b 100644
> > > --- a/drivers/net/tap.c
> > > +++ b/drivers/net/tap.c
> > > @@ -28,6 +28,8 @@
> > >  
> > >  #include "tun_vnet.h"
> > >  
> > > +MODULE_IMPORT_NS("NETDEV_INTERNAL");
> > > +
> > >  #define TAP_IFFEATURES (IFF_VNET_HDR | IFF_MULTI_QUEUE)
> > >  
> > >  static struct proto tap_proto = {
> > > @@ -1000,8 +1002,8 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
> > >  			return -ENOLINK;
> > >  		}
> > >  		ret = 0;
> > > -		dev_get_mac_address((struct sockaddr *)&ss, dev_net(tap->dev),
> > > -				    tap->dev->name);
> > > +		netif_get_mac_address((struct sockaddr *)&ss, dev_net(tap->dev),
> > > +				      tap->dev->name);
> > >  		if (copy_to_user(&ifr->ifr_name, tap->dev->name, IFNAMSIZ) ||
> > >  		    copy_to_user(&ifr->ifr_hwaddr, &ss, sizeof(ifr->ifr_hwaddr)))
> > >  			ret = -EFAULT;
> > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > index f8c5e2fd04df..4509ae68decf 100644
> > > --- a/drivers/net/tun.c
> > > +++ b/drivers/net/tun.c
> > > @@ -85,6 +85,8 @@
> > >  
> > >  #include "tun_vnet.h"
> > >  
> > > +MODULE_IMPORT_NS("NETDEV_INTERNAL");
> > > +
> > 
> > Thanks for giving this a go. Now that you've implemented it, does the
> > risk (of overlooking callers, mainly) indeed seem acceptable?
> > 
> > Documentation/core-api/symbol-namespaces.rst says
> > 
> >   It is advisable to add the MODULE_IMPORT_NS() statement close to other module
> >   metadata definitions like MODULE_AUTHOR() or MODULE_LICENSE().
> > 
> > No need to respin just for this from me. Something to consider,
> > especially if anything else comes up.
> 
> I put it at the top because it was at the top in bnxt. But it is
> at the top in bnxt is because the MODULE_LICENSE is there :-(
> Thanks for pointing it out, I'll definitely address that to be
> consistent.
>
> > Just curious, did you use the modpost and make nsdeps, or was it
> > sufficient to find the callers with tools like cscope and grep?
> 
> Only grep. I'm hoping the build bots will tell me if missed something.

SG.

One tradeoff with this series is that renaming and refactoring always
adds code churn that makes backports (e.g., to stable) more complex.
I trust that you weighted the pros and cons. We just need to be
careful to not encourage renaming series in general. Hence calling
that out right here :)

And, it's not trivial to review that the now netif_.. callees indeed
are holding the netdev locked (or RTNL). Does it make sense to add
lockdep_rtnl_is_held (or equivalent netdev lock) checks as part of
this series or follow-up? And the inverse for the dev_.. variants.

Aside from this high level points, overall series LGTM, thanks.

