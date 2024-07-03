Return-Path: <netdev+bounces-108970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C81926682
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462801C212D7
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15C918306E;
	Wed,  3 Jul 2024 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q94C+NFQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E854017E907
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025798; cv=none; b=mwUcNy3HwD5a6PYXDjn/LYQY+qXUEVcH5QBLk3adWLNtHPvhkeUzDIahpOWiElxsvW6gqvuDeII68dJMZwdrpNkMH12JrCs3zat84ztHAh1uao9dskERyQyhdUVedG8kqOXtHuqm2azWhh+s1ql/ho5QxKkUvxw598yR8PPRt1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025798; c=relaxed/simple;
	bh=oGSdXQKug1/zIgpGOUZsP9kdyjFRk6t6QDLttROybR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB0B1jq9ZHuzqF5o7rT9RBFxc7vxqGvoGyKgNn0IyT/F8b1Ouhr/EH+ayKAXJXWWJZ2RbywMTfNKE2GlIgguiQ8EBXEJq0R8TkRLF70jzxO4DbrqRrx2ZjnjBHQk//8Sd/HLJDSjaJPEAhBd1DHm3wifmhMhVL56uCu1Q1xOM7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q94C+NFQ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52e8037f8a5so5665500e87.1
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720025795; x=1720630595; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ngap8fJeo6dsdjjRZOV8MsEeMGoevn03oWPA9lJwg5w=;
        b=Q94C+NFQvI1hFx/5vy6lg94Hqf8gF0Qpbu4t4OVQMvLVIpFX3mnurJs7Yp2kDS5X7b
         MZoBKV1mgKuU0jFs8fvJaJK4v9UKQGtUHsSHdU0H7bIxuM4U3kO14/3sDqFviLDVlA/b
         57qhft5YvIjcIQj8CUR+jVS5YSB3+lrL+tx6MRwy/KFlZpV2LHzYo9QlcDjdB9BWY0q8
         oPtc8vaPEh20Kn3ave09w4+rc/HJDY2BqBckXoyI8SveC/haeXyAQHp+UL3L3JS1+UWz
         mFl+Ui9MkI+FVm8nX4qkAH6YNnvR1NSELYu413ks8qYCAMWfivtHfxuvYVamwcHH6RDX
         JhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720025795; x=1720630595;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ngap8fJeo6dsdjjRZOV8MsEeMGoevn03oWPA9lJwg5w=;
        b=FlFyCguRjmAZPTaNkvzyIEVzJZP00bsujzXkwjCXNtJBAHzQDbiLkqX82cwHCLQl2p
         Wfu/cTseYJeQh9K6IhGffcoSoKwvNE9FGcwU5Bxb9ZTUytiW5XC3PUppn1Knbsr6FUB3
         0FI4/VV5QFIruIxmI2QqCS4LzHOXgtOeks8nLYCw1Gr3duRGJx+XT6v1SzKT4xKSx9Lj
         84I7aBH83R+DdOpC0ZCZ8wv7BvH5Svjdq+7AV3v9+VzYwLiBkCE9e2cUkl7PaW50YOCN
         2q6heVk04OB4AfMbEcsrD68bMgwhTZBS3VdIvFsfDhhvTQHDEGBtokewZjq7V8Wz1NvR
         UQ3w==
X-Forwarded-Encrypted: i=1; AJvYcCUJumdBFPjrjBOG+s+UC42ouLImRkb4yPS+s+iXPmYFKxpb+pfmRfgEluow027EItABXc2Al7thT9CwbojVF2qukCT8c3qu
X-Gm-Message-State: AOJu0YyRgoDan0aHnkcxgcKRg05yMspgx3WmIGxpAVBYkkYFZWOK89H+
	bPIGCPRAJR0pjt4/bjaXBFglmouTYBqX3isPfHk8q3zfnCGZKjwS
X-Google-Smtp-Source: AGHT+IGmnJJylBRLQAj9UKgfMIg1Jry6JTu11vH51Gnh5KbcyznOLpmCIs2SJpDTHhgS5RlM41J9+A==
X-Received: by 2002:a19:f806:0:b0:52c:f555:8266 with SMTP id 2adb3069b0e04-52e8274a95fmr6561309e87.69.1720025794611;
        Wed, 03 Jul 2024 09:56:34 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab41d0asm2219240e87.307.2024.07.03.09.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 09:56:34 -0700 (PDT)
Date: Wed, 3 Jul 2024 19:56:31 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, andrew@lunn.ch
Cc: si.yanteng@linux.dev, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v13 12/15] net: stmmac: Fixed failure to set
 network speed to 1000.
Message-ID: <hdqpsuq7n4aalav7jtzttfksw5ct36alowsc65e72armjt2h67@shph7z32rbc6>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <e7ae2409f68a2f953ba7c823e248de7d67dfd4e9.1716973237.git.siyanteng@loongson.cn>
 <CAAhV-H6ZJwWQOhAPmoaH4KYr66LCurKq94f87FQ05yEX6XYoNg@mail.gmail.com>
 <ZlgpLm3L6EdFO60f@shell.armlinux.org.uk>
 <6ba14d835ff12f479eeced585b9336c1e6219d54@linux.dev>
 <gndedhwq6q6ou56nxnld6irkv4curb7mql4sy2i4wx5qnqksoh@6kpyuozs656l>
 <ZoQX1bqtJI2Zd9qH@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZoQX1bqtJI2Zd9qH@shell.armlinux.org.uk>

On Tue, Jul 02, 2024 at 04:08:05PM +0100, Russell King (Oracle) wrote:
> On Tue, Jul 02, 2024 at 01:31:44PM +0300, Serge Semin wrote:
> > On Tue, Jun 04, 2024 at 11:29:43AM +0000, si.yanteng@linux.dev wrote:
> > > 2024年5月30日 15:22, "Russell King (Oracle)" <linux@armlinux.org.uk> 写到:
> > > 
> > > Hi, Russell, Serge,
> > > 
> > > > I would like this patch to be held off until more thought can be put
> > > > 
> > > > into how to handle this without having a hack in the driver (stmmac
> > > > 
> > > > has too many hacks and we're going to have to start saying no to
> > > > 
> > > > these.)
> > > Yeah, you have a point there, but I would also like to hear Serge's opinion.
> > 
> > I would be really glad not to have so many hacks in the STMMAC driver.
> > It would have been awesome if we are able to find a solution without
> > introducing one more quirk in the common driver code.
> > 
> > I started digging into this sometime ago, but failed to come up with
> > any decent hypothesis about the problem nature. One of the glimpse
> > idea was that the loongson_gnet_fix_speed() method code might be somehow
> > connected with the problem. But I didn't have much time to go further
> > than that.
> > 
> > Anyway I guess we'll need to have at least two more patchset
> > re-spins to settle all the found issues. Until then we can keep
> > discussing the problem Yanteng experience on his device. Russell, do
> > you have any suggestion of what info Yanteng should provide to better
> > understand the problem and get closer to it' cause?
> 
> First question: is auto-negotiation required by 802.3 for 1000base-T?
> By "required" I mean "required to be used" not "required to be
> implemented". This is an important distinction, and 802.3 tends to be
> a bit wooly about the exact meaning. However, I think on balance the
> conclusion is that AN is mandatory _to be used_ for 1000base-T links.

One another statement in IEEE 802.3 C40 that implies the AN being
mandatory is that 1000BASE-T PHYs determine their MASTER or SLAVE part
during the Auto-Negotiation process. The part determines the clock
source utilized by the PHYs: "The MASTER PHY uses a local clock to
determine the timing of transmitter operations. The SLAVE PHY recovers
the clock from the received signal and uses it to determine the timing
of transmitter operations, i.e.," (40.1.3 Operation of 1000BASE-T)

So I guess that without Auto-negotiation the link just won't be
established due to the clocks missconfiguration.

> 
> Annex 40C's state diagrams seems to imply that mr_autoneg_enable
> (BMCR AN ENABLE) doesn't affect whether or not the AN state machines
> work for 1000base-T, and some PHY datasheets (e.g. Marvell Alaska)
> state that disabling mr_autoneg_enable leaves AN enabled but forced
> to 1G full duplex.
> 
> So, I'm thinking is that the ethtool interface should reject any
> request where we have a PHY supporting *only* base-T for gigabit
> speeds, where the user is requesting !AN && SPEED_1000 on the basis
> that AN is part of the link setup of 1000base-T links.
> 
> Maybe this should be a property of the struct phy_device so we can
> transition phylib and phylink to return an appropriate error to
> userspace?
> 

> Alternatively, maybe just implement the Marvell Alaska solution
> to this problem (if the user attempts to disable AN on a PHY
> supporting only base-T at gigabit speeds, then we silently force
> AN with SPEED_1000 and DUPLEX_FULL.

I am not that much knowledgable about the PHY-lib and PHY-link
internals, but if we get to establish that the standard indeed
implies the AN being mandatory, then this sounds like the least
harmful solution from the user-space point of view.

-SergeY

> 
> Andrew - seems to be an IEEE 802.3 requirement that's been missed
> in phylib, any thoughts?
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

