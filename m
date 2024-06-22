Return-Path: <netdev+bounces-105885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368FA9135D4
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 21:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0451284AC2
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 19:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E793A29F;
	Sat, 22 Jun 2024 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ij1osO61"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6101199BC;
	Sat, 22 Jun 2024 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719083893; cv=none; b=l86EHvqXL8wbsRGYLPPqTuqSuZZ2XnLPosF316Poi687+resKWkuqSpjW9VEJeqxmp3speJ66VoV2UsO9g86S6bM2cY6Z6L2IQZODpKMMqijFvE8McrjL0IrGEUyGM2pffxMlHV27mUtGhBuiPV1zMyQyVxkrq0u8WZQE1HYzFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719083893; c=relaxed/simple;
	bh=pXPBT/S6G+6/TjFGRwVE2GxR2xWBeslThIEl97d3IK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2wkDpHxLEmFuys0z4e0HreCwZJOA4OtJw+9Gcb0KLC/bBPsqR/CS2WpyBBBV1alhwqsuM2Z1UFY24bBrWfQFGAM8UULqXxNdD5M22PyBi1VFge39lKhm+y/57fZYiBwRDExhDCDWm/T1A3O2s3BDw2mT8YSrdthf7P95fI/wdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ij1osO61; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EszZyqiXJ4XQZ+flbruOHXM6khxq1TBaQspAvF7UKT0=; b=Ij1osO61Nctta30bsdgMnAckv5
	Pv8HeLy+lFBSvAgunF+U7PFHePVTn/d1cpRyVp7aas/qu0H8WRwbBLaSN7evT143lUWMazwSPI7OT
	eXtQRv3e1YzwvsVb9KJiqm6MyU8dB1a2J1quhlK6cU/tT84IyAjhE8rer0FD36oK95q4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL6FN-000kPf-6m; Sat, 22 Jun 2024 21:18:01 +0200
Date: Sat, 22 Jun 2024 21:18:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@armlinux.org.uk, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH net-next v7 3/4] net: macb: Add ARP support to WOL
Message-ID: <8252d2d2-933c-4666-8f48-038d85a75725@lunn.ch>
References: <20240621045735.3031357-1-vineeth.karumanchi@amd.com>
 <20240621045735.3031357-4-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621045735.3031357-4-vineeth.karumanchi@amd.com>

On Fri, Jun 21, 2024 at 10:27:34AM +0530, Vineeth Karumanchi wrote:
> Extend wake-on LAN support with an ARP packet.
> 
> Currently, if PHY supports WOL, ethtool ignores the modes supported
> by MACB. This change extends the WOL modes with MACB supported modes.
> 
> Advertise wake-on LAN supported modes by default without relying on
> dt node. By default, wake-on LAN will be in disabled state.
> Using ethtool, users can enable/disable or choose packet types.
> 
> For wake-on LAN via ARP, ensure the IP address is assigned and
> report an error otherwise.
> 
> Co-developed-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

