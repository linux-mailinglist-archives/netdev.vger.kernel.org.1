Return-Path: <netdev+bounces-193437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD63AC4048
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 15:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908F8174696
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 13:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997181F4C96;
	Mon, 26 May 2025 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tI09oY9s"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2811B4409;
	Mon, 26 May 2025 13:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748265996; cv=none; b=jMZQTf+RaTtbDmeXpr+UVnQ4NMEwe+MMkzAeFRWA9tNEUYxgfPFFyIwO63Acb/mNvBAXlwQw/Mlftt7zxy1gcDG4ecNTrGRtcUOdsYPz+1XRLWI//S9UKOuuiGW+mvpT1/2h8cjP78TPztOF01UniPcHLS2D2Rd/OUALtWL+1gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748265996; c=relaxed/simple;
	bh=/SLFAqxiwV6NX3LLR7zyJeAV4tFkk7mKaF5PqobB750=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nN9z6rq/tQdZGjS6XpHXnIFWlg/QEoZqOB/rMsFFqVSWnfnooaP3A1p8TDbcrc5siTxgGGDW1C4Fr60xaGUECAAHrUSeTN/UlxL8Nx6OQsrQzlcIWDLkeRUbyxin78xpLm7WMXa0gxqmzsEfw9XFT7V0t5P4PnNnV09y3Y/BKSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tI09oY9s; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5fjQ8NH+J7LqXK3CTrDlWPgjbLLt8OQoZe12tENaFA0=; b=tI09oY9s4zR5aC/d4HPeHmagsq
	RCRRe4YBs/Pi0n8hL68SMhuxa0WMzU1HVfNrPJVT18D3hFsYtrMx3kXcAaxTYT7VzOLdL5JOTwYoA
	B7fDFMm85BdnS3Z85wNgZdRlo6+ud8Ccu9vBcDJdIRWs6UfWyFJjSuu62HdYbsjtSMzc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uJXqI-00E0AO-Vy; Mon, 26 May 2025 15:26:14 +0200
Date: Mon, 26 May 2025 15:26:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, kory.maincent@bootlin.com,
	wintera@linux.ibm.com, viro@zeniv.linux.org.uk,
	quentin.schulz@bootlin.com, atenart@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: mscc: Stop clearing the the UDPv4 checksum
 for L2 frames
Message-ID: <e4ae3712-5417-4d90-a83d-e2507a518992@lunn.ch>
References: <20250523082716.2935895-1-horatiu.vultur@microchip.com>
 <13c4a8b2-89a8-428c-baad-a366ff6ab8b0@lunn.ch>
 <20250526065445.o7pchn5tilq7izmx@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526065445.o7pchn5tilq7izmx@DEN-DL-M31836.microchip.com>

On Mon, May 26, 2025 at 08:54:45AM +0200, Horatiu Vultur wrote:
> The 05/23/2025 14:59, Andrew Lunn wrote:
> 
> Hi Andrew,
> 
> > 
> > On Fri, May 23, 2025 at 10:27:16AM +0200, Horatiu Vultur wrote:
> > > We have noticed that when PHY timestamping is enabled, L2 frames seems
> > > to be modified by changing two 2 bytes with a value of 0. The place were
> > > these 2 bytes seems to be random(or I couldn't find a pattern).  In most
> > > of the cases the userspace can ignore these frames but if for example
> > > those 2 bytes are in the correction field there is nothing to do.  This
> > > seems to happen when configuring the HW for IPv4 even that the flow is
> > > not enabled.
> > > These 2 bytes correspond to the UDPv4 checksum and once we don't enable
> > > clearing the checksum when using L2 frames then the frame doesn't seem
> > > to be changed anymore.
> > >
> > > Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
> > > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > > ---
> > >  drivers/net/phy/mscc/mscc_ptp.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
> > > index 6f96f2679f0bf..6b800081eed52 100644
> > > --- a/drivers/net/phy/mscc/mscc_ptp.c
> > > +++ b/drivers/net/phy/mscc/mscc_ptp.c
> > > @@ -946,7 +946,9 @@ static int vsc85xx_ip1_conf(struct phy_device *phydev, enum ts_blk blk,
> > >       /* UDP checksum offset in IPv4 packet
> > >        * according to: https://tools.ietf.org/html/rfc768
> > >        */
> > > -     val |= IP1_NXT_PROT_UDP_CHKSUM_OFF(26) | IP1_NXT_PROT_UDP_CHKSUM_CLEAR;
> > > +     val |= IP1_NXT_PROT_UDP_CHKSUM_OFF(26);
> > > +     if (enable)
> > > +             val |= IP1_NXT_PROT_UDP_CHKSUM_CLEAR;
> > 
> > Is this towards the media, or received from the media?
> 
> It is when the vsc85xx PHY receives frames from the link partner.
> 
> >Have you tried sending packets with deliberately broken UDPv4 checksum?
> >Does the PHYs PTP engine correctly ignore such packets?
> 
> No, I have not done that. What I don't understand is why should I send
> UDPv4 frames when we enable to timestamp only L2 frames.

Ah, O.K. I was just wondering if the UDP checksumming in the hardware
is broken in general. If so, you might want to disable it, and do the
checks in software.

       Andrew

