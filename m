Return-Path: <netdev+bounces-153374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AC29F7C93
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4425516A9F3
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22162223E7B;
	Thu, 19 Dec 2024 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m2Afe8RR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769A517836B
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734615880; cv=none; b=BZ4K1UyLrMorf48I95qEiT76kVfNpSncawIP+qPfE2gC5ONww49aSBXJ8vZ1L06dminXQw4jaxW2D6rAjGVIrVbwY1bjrFdmBxmBBClHxc9NjrHwWUBWzXc55EU6VPeqWCSpNcQzflZbg2h8aXjBXYtLv8bG/oL/3C1jupZq7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734615880; c=relaxed/simple;
	bh=hPuLvkvCIAwZBGrKGUnnxnNL3yKk+eONPCW+ntPU5R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp/V+/f78MfllWEsqKr76ItExaqUpNx62CRP7cKuRNmcgJN671M5NpH2P8HQGRrBOMthDLv7rC3FDhWAShcFNtLp3+86zoHLAt2jLohrPGic6Lwr71WCsMJYGzldfOGPYfZ00YeA8nObA5GRBPTYXj6cSkDgBg+7UkLn9QRlyFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m2Afe8RR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Kr2kx+b3E+3JDgRhEfPtnXlV+n8e8PH6yZXhd9DgNvE=; b=m2Afe8RRVr2RQLhAjwm5AHz0Sw
	UX1TjoXVWBOzW5upt6b2FBb+TmSUqXligcb/AYp7/v3HvBAJplfrAKBRxNtWMAXeZyr5TuqdyOiUx
	b0DQHCSWjUNjD8sJGicaNNhCdAselw+Nt0awBoo1fiToDzPM6zR7+Doyqh3yEZfvjKTo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOGpL-001dIM-1p; Thu, 19 Dec 2024 14:44:31 +0100
Date: Thu, 19 Dec 2024 14:44:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, f.fainelli@gmail.com,
	olteanv@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz, pabeni@redhat.com
Subject: Re: [PATCH v2 net 4/4] net: dsa: mv88e6xxx: Limit rsvd2cpu policy to
 user ports on 6393X
Message-ID: <02d7f86d-0cd5-417a-9095-ae148b0db29d@lunn.ch>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-5-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219123106.730032-5-tobias@waldekranz.com>

On Thu, Dec 19, 2024 at 01:30:43PM +0100, Tobias Waldekranz wrote:
> For packets with a DA in the IEEE reserved L2 group range, originating
> from a CPU, forward it as normal, rather than classifying it as
> management.
> 
> Example use-case:
> 
>      bridge (group_fwd_mask 0x4000)
>      / |  \
>  swp1 swp2 tap0
>    \   /
> (mv88e6xxx)
> 
> We've created a bridge with a non-zero group_fwd_mask (allowing LLDP
> in this example) containing a set of ports managed by mv88e6xxx and
> some foreign interface (e.g. an L2 VPN tunnel).
> 
> Since an LLDP packet coming in to the bridge from the other side of
> tap0 is eligable for tx forward offloading, a FORWARD frame destined
> for swp1 and swp2 would be send to the conduit interface.
> 
> Before this change, due to rsvd2cpu being enabled on the CPU port, the
> switch would try to trap it back to the CPU. Given that the CPU is
> trusted, instead assume that it indeed meant for the packet to be
> forwarded like any other.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

