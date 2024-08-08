Return-Path: <netdev+bounces-116758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1915594B9C8
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41481F22424
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42111494A6;
	Thu,  8 Aug 2024 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP8Kxm60"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF7742042;
	Thu,  8 Aug 2024 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723109866; cv=none; b=gsCol8FPd0eixx90YDvrXZ86v5H/RTjwLgRhU1UuznXhZqHSHXHbOiLNVbGfgc5yHU1tsSvdb+mNxzWEeoxbGe3ay0g2rxYpZCvPA8AHS05ybC6lf2t4eDnz1SoLYVRJ+UErE+i0Mk7LywZc8c8iA7tdXs/X7GGJ7rt9PThFs/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723109866; c=relaxed/simple;
	bh=S8NqB5edpUzquDamEYQKbeP3NbfzNxNHCg1WSoHn5Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwDR31mQ9ds4MpGOnPyd1xHFIwgekCL/q1cRAV6qXHqfigJHS4Wd0qMG6RpiZxdbN5GBUBkk6cXdNrx2eO21xzsQyTEMq1mCpn3ivJYVI3v1Qr4qPhiI+lgPY7FfHhEYStGWLsbiJjpvIZFX8SUjNR6B1mxGUco3pE0Uup+mYDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HP8Kxm60; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db19caec60so524702b6e.1;
        Thu, 08 Aug 2024 02:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723109864; x=1723714664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8CoJAdfolSHrKUuk8Pizjh2lfVY8QKV5cVkq2MObhqU=;
        b=HP8Kxm60boCpbusNGCr4ZpZ6tSkBd8kFX7tWgwCO2AFc5R/bJXIQMl37CHT/weXIhV
         6jheOJ2tHg+d87udvl4jHa5UnbcyJso8aRO59mtyo4qLMXFFyxIyrTKegSZ0NWYmBGMR
         muO/k4iUOcccsROGE7dqU3RsL17BYHOzWAh1HLWyE1UR01L87O6VGZhIhRWhfi+ybIZl
         tBOD4qXsZUbPNLHQNhk0a57i8jOhl1t6bAGOzgMlEWBqUdA4boAw91ldx3mDkGjUjYt7
         dA7FmveRvW21mjwLarjOsVWSoPj0acG8i6U44yrV2LKapf+AHqEkZto24qE+0MJDK2Wp
         YyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723109864; x=1723714664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8CoJAdfolSHrKUuk8Pizjh2lfVY8QKV5cVkq2MObhqU=;
        b=BW6WBBKbSd+/ki3qYxGUpP+JmFF38mvJ1jrIcM5VtrqaGV/vQbkElk9bq20sNX+5XL
         XnRzpNMWnT2f3smzwjnQN49+76zoredRLckZH5B7gdsY7m/d6Dsd04fGWsCre7EdZHMd
         e+c8sfWwPuEzyRGa2SMYMUUC4jKBtXyIam94+OLWpMbNsGuzjGZ9byL6OF2v+i9Wfack
         5BB3SHjLcmLvWk61vams2lRC0pPnmDEy7qY2uvjBJnxTLZJKpZ8H+72k4NzismKLYBsX
         WrV3Gef+bwA3eeicfPNiokn8AeCrxfo3h1CH5PygQWlfdTn2HZkbMWysvMqdWhuMjETR
         q5Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWWuPGQ1OYK0UEVaS+8X2Dc/n64On7g/cKRrmGSWeQvEUjJzC+Bpokxs2pzPisyLf+wbSssHLpkxuoGNjEl@vger.kernel.org, AJvYcCX0n1nQ08u+/PuoEjQiEymkxtiOgFWpgJ+lVOWsj1HYNNNfmEsQtWi/CflvJREp7IVpADLub2Z4/6yH@vger.kernel.org, AJvYcCXe16x9cH5IUVNQ/vQyPQrZqQR3QD1VtNnw4ubaOD2PasbCPd0QxGQcLc0fC1+mWfcXsA/DjQYS@vger.kernel.org
X-Gm-Message-State: AOJu0YyC+BATZHna4tKI6Zk9KwajkblXY7bGQo/oWbF9BWI1E8ejCYIs
	WlJkwUOhL5DDGP2aLTkq9ndLbotIZqPJJ6EC2JkDK1l75rY6ARBvzmLB0B/QwFwT2y1zC/RBb9N
	j4rUGnjID1NZ2I959pkiF6ObjerI=
X-Google-Smtp-Source: AGHT+IGdkqjz0I7UQhYkeyj7wADwjGseQQpqsea+Rs79ImylNKFsV+YqnLZMBL6QBGdQQmyhzJKDWWmw7wlM/Dyl8f0=
X-Received: by 2002:a05:6808:bd3:b0:3dc:299d:c4f9 with SMTP id
 5614622812f47-3dc3b47869fmr1491407b6e.42.1723109864464; Thu, 08 Aug 2024
 02:37:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806132606.1438953-1-vtpieter@gmail.com> <20240806132606.1438953-5-vtpieter@gmail.com>
 <adf5cdde46c829519c07cfe466923ecac1033451.camel@microchip.com>
In-Reply-To: <adf5cdde46c829519c07cfe466923ecac1033451.camel@microchip.com>
From: Pieter <vtpieter@gmail.com>
Date: Thu, 8 Aug 2024 11:37:33 +0200
Message-ID: <CAHvy4Aoo6ej11vYMG2jwe8VO6ZmWbO49zBHOLYmHvxmr2nF3PQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/5] net: dsa: microchip: add WoL support for
 KSZ87xx family
To: Arun.Ramadoss@microchip.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	linux@armlinux.org.uk, conor+dt@kernel.org, Woojung.Huh@microchip.com, 
	robh@kernel.org, krzk+dt@kernel.org, f.fainelli@gmail.com, kuba@kernel.org, 
	UNGLinuxDriver@microchip.com, marex@denx.de, edumazet@google.com, 
	pabeni@redhat.com, pieter.van.trappen@cern.ch, devicetree@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed 7 Aug 2024 at 05:56, <Arun.Ramadoss@microchip.com> wrote:
>
> Hi Pieter,
>
>
> >
> > +               if (ksz_is_ksz87xx(dev))
> > +                       ksz_write8(dev, KSZ8795_REG_INT_EN,
> > KSZ8795_INT_PME_MASK);
>
> nitpick:
> Do we need to rename register like KSZ87xx_REG_INT_EN since it is
> common to other switches as well?

Hi Arun, well it's all a bit confusing already I have to admit. There is a
filename ksz8795.c that contains code for ksz88x3 and ksz87xx devices.
Also the tag protocol is named DSA_TAG_PROTO_KSZ8795.

Now it seems from function prefixes and ksz_common.h `is_ksz8`
that in many places `ksz8795` should be replaced by `ksz8` instead.
I don't it's up to me to make this kind of decisions so I went along with
the existing naming convention as much as I could but indeed, this
specific register I will rename to KSZ87xx_REG_INT_EN.

Thanks, Pieter

