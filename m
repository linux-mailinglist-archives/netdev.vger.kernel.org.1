Return-Path: <netdev+bounces-146047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7D79D1D64
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EF61F21FFA
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 01:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531D9839F4;
	Tue, 19 Nov 2024 01:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zsrEApgB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E984087C;
	Tue, 19 Nov 2024 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731980163; cv=none; b=QmNMKhoUWTAfRNoDwjIDQUFV6rCLSwIpM8YvUdPYMpCUuXTu3h+eyI/gKteZyThadVcguuZbTspfeDFrfznvxTlu7+6FrgelsUQ/307481kTWNM7OlTQkbeqmyEUue4q0huA6zxxgxUSN7dasbUeU3kJLRaYFIS/j+WtWg8f80s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731980163; c=relaxed/simple;
	bh=6j+MFm7ekGRTDTif1KPYV8o2JJAR6CpXEcRYE5/KaWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy+8VmS5IJ5Ca++z2IbfBQ7FE/EfPdbxu5qAU9XRh4nPPHbrHpfmQtg9LBi37SjvyRxhODaEc/qGL90prJpGxbpjTaNg692BALDJj+7XLG3WcWnOA4ZR5HBj0E12Bdy7yEFjdAcyzIlOiB3U3QoY/lT3t+I3serAKarYGV5R310=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zsrEApgB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vhqwq7tcm/27fuNPEhxvLaIj0zcTCyFQj9NCsNSuOng=; b=zsrEApgB1Yzs0IM2FGZIAy2rO9
	0scyimONNmLRwI3Ofm3tscl5i2utIyG+0WI7BVLQvV+2Hi892nb5usgejZG/ADbJ0ByPdV2TjF0GE
	hJlwOQZCWRSaRF/k+GwWqy3ogrdgaWhnM73XAAODxSH9C4knzD/gI2H9RFbw9SA8JlIQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tDD9g-00DjPP-NG; Tue, 19 Nov 2024 02:35:48 +0100
Date: Tue, 19 Nov 2024 02:35:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Suraj Gupta <suraj.gupta2@amd.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, michal.simek@amd.com,
	radhey.shyam.pandey@amd.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, git@amd.com, harini.katakam@amd.com
Subject: Re: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G MAC
Message-ID: <9d26a588-d9ac-43c5-bedc-22cb1f0923dd@lunn.ch>
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
 <20241118081822.19383-3-suraj.gupta2@amd.com>
 <ZztjvkxbCiLER-PJ@shell.armlinux.org.uk>
 <657764fd-68a1-4826-b832-3bda91a0c13b@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657764fd-68a1-4826-b832-3bda91a0c13b@linux.dev>

On Mon, Nov 18, 2024 at 11:00:22AM -0500, Sean Anderson wrote:
> On 11/18/24 10:56, Russell King (Oracle) wrote:
> > On Mon, Nov 18, 2024 at 01:48:22PM +0530, Suraj Gupta wrote:
> >> Add AXI 2.5G MAC support, which is an incremental speed upgrade
> >> of AXI 1G MAC and supports 2.5G speed only. "max-speed" DT property
> >> is used in driver to distinguish 1G and 2.5G MACs of AXI 1G/2.5G IP.
> >> If max-speed property is missing, 1G is assumed to support backward
> >> compatibility.
> >> 
> >> Co-developed-by: Harini Katakam <harini.katakam@amd.com>
> >> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> >> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> >> ---
> > 
> > ...
> > 
> >> -	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
> >> -		MAC_10FD | MAC_100FD | MAC_1000FD;
> >> +	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
> >> +
> >> +	/* Set MAC capabilities based on MAC type */
> >> +	if (lp->max_speed == SPEED_1000)
> >> +		lp->phylink_config.mac_capabilities |= MAC_10FD | MAC_100FD | MAC_1000FD;
> >> +	else
> >> +		lp->phylink_config.mac_capabilities |= MAC_2500FD;
> > 
> > The MAC can only operate at (10M, 100M, 1G) _or_ 2.5G ?
> 
> It's a PCS limitation. It either does (1000Base-X and/or SGMII) OR
> (2500Base-X). The MAC itself doesn't have this limitation AFAIK.


And can the PCS change between these modes? It is pretty typical to
use SGMII for 10/100/1G and then swap to 2500BaseX for 2.5G.

	Andrew

