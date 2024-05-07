Return-Path: <netdev+bounces-94152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 896BA8BE663
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165571F2546E
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B90160862;
	Tue,  7 May 2024 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORxLav67"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD5814F9E7
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093321; cv=none; b=Rmth4akyxqdRCjk47ON2qYi/NoNxWrCrQW80NlkLq8g6m3MXapk7FtquPoIBV3btwtA38OLVraOHqD1Ecro242qeiDs1owCkkch/U8vHNpQLTk1/vcpBLeEhh4iShaKKqkT3qKjUkblevYckuLGwsypyOwPOvPdQQoRtbXpVY9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093321; c=relaxed/simple;
	bh=I06cK2vAYPdgqkwrUehfSpbUrypwMSIUfL2EgGKqmKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksWqethFb2YDznrOrRlNN5trzuMmNfxnhstjRtg6STIdeW/OrYQJfJd1R8/0Nup+6n8Rs4gx7FOFrcXv+oYWpM9S6tBy+qRcE2hx3fQoiZmQKdso+yq4Jm7ef32sucEwkUyrDVfJ5gG+3BY341M7mi/+HnfPqI4gryB7JZcJa+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORxLav67; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715093318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTLDRJ+Y2C9qtVA6GvAyqMW7FNLo8bVgJpqdecb1Xoc=;
	b=ORxLav67ARZ8ClvuqLHNSArkssm9vkb+BDUflObLqPmdlZCH9BhQrquTvWi0c85PwQXVFq
	1ACXFxmKrL7jnKDTic6OAH02tUIigNU+ABcp9wFxHOdGADCYp9tDDX2mfXZ31IB++nxgbg
	9Vi+fv9bJt5PyarF4gDP5zgtIT1JJNQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-k3vUShdLMNyA-yHI7USXxQ-1; Tue, 07 May 2024 10:48:37 -0400
X-MC-Unique: k3vUShdLMNyA-yHI7USXxQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5d396a57ea5so2576663a12.2
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 07:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715093316; x=1715698116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTLDRJ+Y2C9qtVA6GvAyqMW7FNLo8bVgJpqdecb1Xoc=;
        b=r+AbKH/3ZhKeyKotGZzmskmL582/lbwSBVWuL+ggNpcSX+8Z1JBA3CGL+NCVwRZ6bF
         US1gHODikoVRe0juKQDQKZWGX88fG/rk2o4SB8+kGt5OLWDmrsTYSUkKfdln5eDXiTvN
         eLxxg8iA4ifADtZTsmASRDJ9srTmxbbEoNyJiDZN7xWu4OqZ/fdfT8VxB/aMtOtediPb
         Za6/QFX2+hkCqiPAs9pZXc8Y21q/0nzdbS/mpH1eYVf/MPIaVxmxwvXjPzTGbo6z8rDO
         5BOURDHRjrPHrdJ0mBghWFc7dlBuBH16Jq5+UHAGX517tMGtjKEgg2K1Mcij4mRUjb3M
         4wag==
X-Forwarded-Encrypted: i=1; AJvYcCWk0l836++A8J5HQyEQz17N0h/q90i9AhRtX9CYnQgboMctlI5JolchdAqCAHNng88+8PLhYW9j6HPd9ATihqqBwWlStUT2
X-Gm-Message-State: AOJu0YyAr0qknKIiwbJYO51pxnwgkjXQlog9XOWjswup391iuU7jgD0F
	fs27AIV5ePSBO5tydmrV64a5C9ABsMikCO5LFCp03CIOJiQwsIoqOesre6uXHp1DgpQipORhTTu
	rA/HbsyEyFiOno6n6HnK4EVvRgm2qaEBxssNz+9/8XbWR2gG7Y7tYtA==
X-Received: by 2002:a05:6a20:2d0a:b0:1ad:31e2:56c with SMTP id g10-20020a056a202d0a00b001ad31e2056cmr16115657pzl.8.1715093315937;
        Tue, 07 May 2024 07:48:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrgeM1ZE9m7PX87R+n+J5zEki5ltNJcbMD3VGwx4A43X3ZXKh0YMm+VM4cmVfuWg9cJpbq9A==
X-Received: by 2002:a05:6a20:2d0a:b0:1ad:31e2:56c with SMTP id g10-20020a056a202d0a00b001ad31e2056cmr16115613pzl.8.1715093315306;
        Tue, 07 May 2024 07:48:35 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id w22-20020a056a0014d600b006f43c013f66sm4429038pfu.173.2024.05.07.07.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:48:34 -0700 (PDT)
Date: Tue, 7 May 2024 09:48:30 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, 
	hkallweit1@gmail.com
Subject: Re: racing ndo_open()/phylink*connect() with phy_probe()
Message-ID: <i3w534hh4o2klrehag7cwjshwiqxergidzo4h7zz7oa3prra2k@v6xor5k4dv5x>
References: <uz66kbjbxieof6vkliuwgpzhlrbcmeb2f5aeuourw2vqcoc4hv@2adpvba3zszx>
 <ZjFl4rql0UgsHp97@shell.armlinux.org.uk>
 <ykdqxnky7shebbhtucoiokbews2be5bml6raqafsfn4x6bp6h3@nqsn6akpajvp>
 <7723d4l2kqgrez3yfauvp2ueu6awbizkrq4otqpsqpytzp45q2@rju2nxmqu4ew>
 <25d1164e-0ac2-4311-ad27-aa536dca3882@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25d1164e-0ac2-4311-ad27-aa536dca3882@lunn.ch>

On Fri, May 03, 2024 at 03:25:19AM GMT, Andrew Lunn wrote:
> > AFAICS the problem is in the race between the end0 and end1 device
> > probes. Right?
> > If so then can't the order be fixed by adding the links between the
> > OF-devices?  As it's already done for various phandle-based references
> > like "clocks", "gpios", "phys", etc?

Thanks for the pointer here Serge, I had no idea (still don't have much of an
idea) on how this works. I think this makes sense to explore some more.
Hopefully sometime this week I'll poke at this more.

> 
> It gets tricky because an MDIO bus master device is often a sub device
> of an Ethernet MAC driver. Typically how it works is that a MAC driver
> probes. Part way through the probe it creates an MDIO bus driver,
> which enumerates the MDIO bus and creates the PHYs. Later in the MAC
> driver probe, or maybe when the MAC driver is opened, it follows the
> phy-handle to a PHY on its own MDIO bus.
> 
> If you were to say it cannot probe the MAC driver until the MDIO bus
> driver is created and the PHYs created, you never get anywhere,
> because it is the act of probing the MAC driver which creates the PHYs
> which fulfils the phandle.
> 
> You would need to differentiate between a phandle pointing deeper into
> the same branch of a DT tree, or pointing to a different branch of a
> DT tree. If it is deeper within the same branch, you need to probe in
> order to make progress. If it points to a different branch you need to
> defer until that sub-branch has successfully probed. And if you get
> two branches which are mutually dependent on each other, probe and
> hope EPROBE_DEFER solves it.

I'll keep this relationship in mind. IIUC the fw_devlink stuff sort of handles
cycles, but I need to look into how all that works further. At least in
my example device, end0 is in this situation, whereas end1 is in the
other situation, so I have a decent test setup for that.


