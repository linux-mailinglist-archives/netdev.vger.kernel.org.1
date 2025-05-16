Return-Path: <netdev+bounces-191002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6F9AB9A64
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 12:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54824A067AB
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 10:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D1F230996;
	Fri, 16 May 2025 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OihX4uLk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B67481C4;
	Fri, 16 May 2025 10:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747392206; cv=none; b=rcYpINvM2H4fyAsn9GavzscwLE/fooBs8ND+oMdkzoVbGNpmMr94468P3sD013i8aIqlAjEs9yJxySVC9kMRT0s2L7CpKUCyxQskzNw0VJ/8j62tWqb/QAtn/CzXqbPMLdgtFzziep94ibf+OUGEsMR8DxxK2iTAKmgtQoGqaL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747392206; c=relaxed/simple;
	bh=4XMPDkOHfHxTGAnkDGyqe2QhlNh+p4nDUDWQd8TKv4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SER0CMspHcFbWQBb5OsoK+pZo4pF4uNDcS7pxveYrZBWKbNzibdUr1+BPUVBtrA3IWlKi+oWLg0+zAMZujrP1at9jNEary/S5u3aMjz3iNml673xWYmrUTYSZtHOlf6nFkfLVCpClE2bVhjv0XV79dpnkqOI4ObD06L4BLTXV8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OihX4uLk; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e7b811be6dbso115087276.2;
        Fri, 16 May 2025 03:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747392203; x=1747997003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ucwOIC2+Dn1yWptuhTEy+YE9t5m2Ly1InIqSD1HT56s=;
        b=OihX4uLkpN7Yrjrb0DgkpRS7unoaXjAMar/hnCx/DqpyHRbpMRiRzsFpSYcupHZ28W
         Ft1tU8jFF2+yybamysmeCk6y+ePw3gOQvxYdiucUPGjWVQYx1+W/nI8PtXpbAC+RuesV
         KfuIgV3o8RSc75Z/qUezS5l54NMjivsKM89ecfYwfDtPgnBI1tuZVE0kuZIKCBxrSh8Q
         ywrgBxX/OSfYl1v7buwbEe/09sBF5gOSh9VAPmfd08Kd0nNmEvgMY+qZQI2oMNg+eYQI
         O3DEn5fh+R0aNxdPTCU01f2A+3bPnMaDIx4Sb/O9tjj+YcEVD5vj0LUzFwom2cCbesF9
         b0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747392203; x=1747997003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucwOIC2+Dn1yWptuhTEy+YE9t5m2Ly1InIqSD1HT56s=;
        b=j07ar+ZrKmmL+8h8myQN7E2NZMrcKYbppsvvZKt6zvdw/2ZwOWOYmpmtQYyjfv2Y/G
         w8KNzF0VL/dckRW9tDYFQYJkgxvc7miwBFgm5C3Y3KAhGwb2QLADuW+TlHdnWjwKA4j2
         G5OlXZRqtxK1pGUQiaR3mlKfCY3Ppgi6HiMVFjatq0T6cQrdI0sGRJhqQwy7VnQZojhg
         lXDJuvi2DseUshuA8u4EF5ANSzUubMmCkNCy48B/Cvi9Gmtv+XRxgHCWbh+iaTT8TXxJ
         kpEpld2fOD4LUV3FOYV285GgKfTC5Lpp+Wvg8u1aTlWbf0WtW7c/9pcyXHRHjdQ1S8Fg
         MMww==
X-Forwarded-Encrypted: i=1; AJvYcCXC+XOYa6sMZuskj8CTIoayH++YGHoqs5i0nPy/bNd2mgsg35qdBch0xRS0zNlvZHdX4+3/DdZKKxd8lcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7N+6qFKywx8k1SETAMuTnmoZ2JBUE6hHZn60+fIlaOY+UXIGX
	NQHYivR2A22sJmms0nh5kSEPk6ex+PamniVghwKBreCZ3sphjpir+NxDWemFNbB0N31rn6tiIDz
	TG03Uf2eHjFJ6tFJX46MpOxlRENEFbYM=
X-Gm-Gg: ASbGncseMlRoinu2zt0MEYYpf9xr8NBVsmQSARCnVi9+NodQ+s05aDmIKpcm9QVC+LK
	YIZhlf7D9GkdD3Y/P9fnGy+UaqFNXX/+Skj+o7hDPg433EBbM20axFrSdIhNTwlW78o+SyrWOj+
	Zbzn4k+fC0L6Mou5w3Nu6ajSEmKW16LJkM
X-Google-Smtp-Source: AGHT+IF4a8SiBD6kRuHCyWfESvtavJV+3e8AyekJQZqmMU3uD5RHGHVx54hBPo/KqOMX3HMnQ9BtYpKsBmyJLcds4rc=
X-Received: by 2002:a05:6902:490f:b0:e78:f2e4:bcc3 with SMTP id
 3f1490d57ef6-e7b69d5bc06mr4155104276.9.1747392203174; Fri, 16 May 2025
 03:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515184836.97605-1-stefano.radaelli21@gmail.com> <63727423-9d19-40d1-b8d3-7c292529b16f@lunn.ch>
In-Reply-To: <63727423-9d19-40d1-b8d3-7c292529b16f@lunn.ch>
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
Date: Fri, 16 May 2025 12:43:12 +0200
X-Gm-Features: AX0GCFsG5DxzmYdMgf7cIX9WucEUsQXkZQekTE02IsEY6bDS2Kw7vir3bWlv3Hw
Message-ID: <CAK+owojG1yfUy8rYzP1Q3q1ogq8dwwAK8ekk2AS+ABjH50e7ZQ@mail.gmail.com>
Subject: Re: [PATCH] net: phy: add driver for MaxLinear MxL86110 PHY
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Xu Liang <lxu@maxlinear.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

Thanks for the review and for pointing this out.

> Why are these two special and use the locked variant, when all the
> others don't?
> Please think about locking, when can unlocked versions be used? When
> should they not be used?
> Are you testing this with CONFIG_PROVE_LOCKING enabled?

You're right, the use of the _locked variants was confusing and inconsistent.
After enabling CONFIG_PROVE_LOCKING and testing, I identified where
locking is necessary.
Functions like get_wol, set_wol, config_init, and LED controls can be called
concurrently from userspace or asynchronous contexts, so they require locking
the MDIO bus. Without proper locking, I got warnings like:
WARNING: ... at drivers/net/phy/mdio_bus.c:920 __mdiobus_write
WARNING: ... at drivers/net/phy/mdio_bus.c:891 __mdiobus_read

To clean up, I removed the locked helpers and instead wrapped extended
register accesses with phy_lock_mdio_bus() where needed.
Now, no warnings appear with CONFIG_PROVE_LOCKING enabled
after testing every implemented functionality.

> Please also take a read of:
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> https://docs.kernel.org/process/submitting-patches.html

Thanks, I have reread those documents, updated the code accordingly,
and plan to send my patch today with the [PATCH net-next] tag.

Best Regards,

Stefano

Il giorno gio 15 mag 2025 alle ore 21:03 Andrew Lunn <andrew@lunn.ch>
ha scritto:
>
>         > +static void mxl86110_get_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
> > +{
> > +     int value;
> > +
> > +     wol->supported = WAKE_MAGIC;
> > +     wol->wolopts = 0;
> > +     value = mxl86110_locked_read_extended_reg(phydev, MXL86110_EXT_WOL_CFG_REG);
>
>
> > +static int mxl86110_led_hw_control_set(struct phy_device *phydev, u8 index,
> > +                                    unsigned long rules)
> ..
>
> > +     ret = mxl86110_locked_write_extended_reg(phydev, MXL86110_LED0_CFG_REG + index, val);
>
> Why are these two special and use the _locked_ variant, when all the
> others don't?
>
> Please think about locking, when can unlocked versions be used? When
> should they not be used?
>
> Are you testing this with CONFIG_PROVE_LOCKING enabled?
>
> Please also take a read of:
>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> https://docs.kernel.org/process/submitting-patches.html
>
>     Andrew
>
> ---
> pw-bot: cr
>
>

