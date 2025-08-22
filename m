Return-Path: <netdev+bounces-216167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7D8B3253E
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 00:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D42626CA6
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 22:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FABA288C20;
	Fri, 22 Aug 2025 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9Y6iPZ0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C9C393DD1;
	Fri, 22 Aug 2025 22:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755903516; cv=none; b=EreGq721jZsblpHJ3D//7g9RAeBfXNfVkkrmQQdGsk0aZuigYz+IOl6XHfSbKjk7vqscqlpqRI5RhTu0lysMoVPvsO+4sMMoQKFQvFLWO4nF0/DCVT1NyyvEnlf8jQb+/VSmSgfM+s7TEiUnrmDgctiWwvCsD7kBR7XpMQ2+Nm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755903516; c=relaxed/simple;
	bh=770nLDaQZj/nPYavfvaD+GjJTqTjAELskpt6D+OTHm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StKoD+zkShAKnfMdx6j0FvK83W0leLD1Ka2QBEx2o1Ue6aJ0l/A2NGVZRHm5xFIQOZEelAfST95rejMvcmbbj08gujXrD1c1Trre8BfluLSaoB9C8VEfydnadMmnw03XojrAEPvbmDBxnah+PBsF/0v34uFqJW4As5rUCWlJjFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9Y6iPZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E69FC4CEED;
	Fri, 22 Aug 2025 22:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755903515;
	bh=770nLDaQZj/nPYavfvaD+GjJTqTjAELskpt6D+OTHm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U9Y6iPZ0vslDKvLTpOkT+05kPj2ra8TWul+KMooo5LIFvxZGGWsi3Uh2+M4HIaUw1
	 ljKJhj8ppZNbHi/XJHE8BexeJyW/pAO3Q646yGu25tUOmkoVqbtb6krT9N+r3DaTCg
	 PMiQj7npKXy3GsRyYUHqTfwl149DP6d/QRF2dUu+z9A4Vl3XQ4oubNxZAhhH3FDKjZ
	 hkE+B7C9tdsWCpEaRqc/wZyaS9C4ctI7DYxRuJNWfp2CjE7vEcm42D8V7hqrDEMjS+
	 q3BAKV5w6ddHpU5tIIY3glgU0I7be/KlG71/9EQUSoinWxQzLSA+VNvMFGiPxv8yMX
	 vG0Z6rV+QmnnQ==
Date: Fri, 22 Aug 2025 15:58:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>,
 <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
 <vladimir.oltean@nxp.com>, <rmk+kernel@armlinux.org.uk>,
 <rosenp@gmail.com>, <christophe.jaillet@wanadoo.fr>,
 <viro@zeniv.linux.org.uk>, <atenart@kernel.org>,
 <quentin.schulz@bootlin.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] phy: mscc: Fix when PTP clock is register and
 unregister
Message-ID: <20250822155834.57c7438d@kernel.org>
In-Reply-To: <20250822062726.cv7bdoorf6c4wkvt@DEN-DL-M31836.microchip.com>
References: <20250821104628.2329569-1-horatiu.vultur@microchip.com>
	<3f8cef10-fbfd-42b7-8ab7-f15d46938eb3@linux.dev>
	<20250822062726.cv7bdoorf6c4wkvt@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 08:27:26 +0200 Horatiu Vultur wrote:
> > > +void vsc8584_ptp_deinit(struct phy_device *phydev)
> > > +{
> > > +     switch (phydev->phy_id & phydev->drv->phy_id_mask) {
> > > +     case PHY_ID_VSC8572:
> > > +     case PHY_ID_VSC8574:
> > > +     case PHY_ID_VSC8575:
> > > +     case PHY_ID_VSC8582:
> > > +     case PHY_ID_VSC8584:
> > > +             return __vsc8584_deinit_ptp(phydev);  
> > 
> > void function has no return value. as well as it shouldn't return
> > anything. I'm not quite sure why do you need __vsc8584_deinit_ptp()
> > at all, I think everything can be coded inside vsc8584_ptp_deinit()  
> 
> I understand, I can update not to return anything.

It does look a little unnecessary.

> Regarding __vsc8584_deinit_ptp, I have created that function just to be
> similar with the __vsc8584_init_ptp.

Alternatively you could only deinit if the clock pointer is valid,
regardless of chip id. Unclear which one is the cleanest form, TBH.

