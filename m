Return-Path: <netdev+bounces-193016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 441E7AC2346
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 14:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1FF616981D
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 12:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2D97404E;
	Fri, 23 May 2025 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B/0z2ALO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70F926ADD;
	Fri, 23 May 2025 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748005173; cv=none; b=CJ3PBwkhornJ/VsjkxxPfQNgJUBVbGtR9v1NS2MoudslpSsQ+WbMDZ10fztT1i7Pp1xyc1TOudekjzeA0H4hoUOCnowntZ4avXcsFcJk0w0HtehFCMMnnMX+bouHa67xVJpA3ASCUcJ8v5hkqGP06OWDJOg02BSErg1CLNeJ40A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748005173; c=relaxed/simple;
	bh=Eb1XMmvAoG3b/bdCa7Clb4107Xzu4WiZEuKO2Dd96po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0I2kqSrY/1ADVD+KPjI26VyPnAqeRMVvmnZi+JIMoJqU9Q6jjapEPqhMS7z8bEhIRVXwuS1/KzefSmsoAPs2jPkYmwrSUYRlf5okvPHexzpVTBFGZ9xz/X/sXLu4iI0+2VUMeS8zqeSD6dF9wGjSVebtQWgAiW0CCmxbz0L2oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B/0z2ALO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yjr54PMpftT4r6okJF9EMmmcVc8lugHm+Sz5gKXMrJ0=; b=B/0z2ALOhvbIUwBk0RPFsBZJC7
	QWOV+vuQElNZrp0rGSADf5QmCAZxps0jcFG2O/JwdRLWS/gkek5D7GEtWNjM81hO6oHuxa9YE+hha
	iaMhqEHpOASEy2tLcvluIiuQYv/rzTqOKfovrwn+ZgqqK++6h8OEnm4VIsjft7GOam1Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uIRzN-00Dbsd-I8; Fri, 23 May 2025 14:59:05 +0200
Date: Fri, 23 May 2025 14:59:05 +0200
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
Message-ID: <13c4a8b2-89a8-428c-baad-a366ff6ab8b0@lunn.ch>
References: <20250523082716.2935895-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523082716.2935895-1-horatiu.vultur@microchip.com>

On Fri, May 23, 2025 at 10:27:16AM +0200, Horatiu Vultur wrote:
> We have noticed that when PHY timestamping is enabled, L2 frames seems
> to be modified by changing two 2 bytes with a value of 0. The place were
> these 2 bytes seems to be random(or I couldn't find a pattern).  In most
> of the cases the userspace can ignore these frames but if for example
> those 2 bytes are in the correction field there is nothing to do.  This
> seems to happen when configuring the HW for IPv4 even that the flow is
> not enabled.
> These 2 bytes correspond to the UDPv4 checksum and once we don't enable
> clearing the checksum when using L2 frames then the frame doesn't seem
> to be changed anymore.
> 
> Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  drivers/net/phy/mscc/mscc_ptp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
> index 6f96f2679f0bf..6b800081eed52 100644
> --- a/drivers/net/phy/mscc/mscc_ptp.c
> +++ b/drivers/net/phy/mscc/mscc_ptp.c
> @@ -946,7 +946,9 @@ static int vsc85xx_ip1_conf(struct phy_device *phydev, enum ts_blk blk,
>  	/* UDP checksum offset in IPv4 packet
>  	 * according to: https://tools.ietf.org/html/rfc768
>  	 */
> -	val |= IP1_NXT_PROT_UDP_CHKSUM_OFF(26) | IP1_NXT_PROT_UDP_CHKSUM_CLEAR;
> +	val |= IP1_NXT_PROT_UDP_CHKSUM_OFF(26);
> +	if (enable)
> +		val |= IP1_NXT_PROT_UDP_CHKSUM_CLEAR;

Is this towards the media, or received from the media?  Have you tried
sending packets with deliberately broken UDPv4 checksum? Does the PHYs
PTP engine correctly ignore such packets?

I suppose the opposite could also be true. Do you see it ignoring
frames which are actually O.K? It could be looking in the wrong place
for the checksum, so the checksum fails.

	Andrew

