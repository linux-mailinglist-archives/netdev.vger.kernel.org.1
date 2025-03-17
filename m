Return-Path: <netdev+bounces-175480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44296A660D8
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 22:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B813AB3B7
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3792036E9;
	Mon, 17 Mar 2025 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ky6dfPkK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CDCAD4B
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247765; cv=none; b=AqMllA+/5ur0HQSeITtmATRBbnksVOp8qQfoSu/nkJylOZBwLfDE2OR1f8Mwi8g3bYi5sjVBP4jyqYzsUZm7VcsvjJdqvlRWJyRK+P1hwtiYbPBvIzldj62bcM759QRGVYkkhpv5qbGcgziks0XohpZLO4MqNlUmFEGoumffW6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247765; c=relaxed/simple;
	bh=T+cTjKfcsmhOs9Cb/vuJZYo9/SF+Hvz6vv7PzDPga6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrdNaEfGxjDp+XWADT912GU/3a0qPjn9le7AzLci8/pclikI5TIdMyVDpsikEUzQ6gb2aCEDIj5/Tff6dCIXMke6SciIJFhpDvtv8AzTDw4DNEHhUVTPp45fHotx6Kqigc7Ojmy0b9YlICPX8zO7aqAvYRM+CL57tMonAEd0qxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ky6dfPkK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=SFz3CYSwoEqNAoSkBrWh8ClylHZfGOzuT3A9Vk9gwf8=; b=Ky
	6dfPkKHL8lMM6/PHF+7TMEcmHUc+2mqnGdmWkzGEdyoQbN3YqwCQNRUo1soyU9WTzS8f0H47byTMp
	LVZWgC/OquJvxv6f5S5rlVT0tedezoNiF7eS4HLN71bQqYVqDZ/e2W+IqIDcHkyosW5+Mnej0ZWKE
	FHILTPrp+Tk1np4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuIEJ-006BUw-8B; Mon, 17 Mar 2025 22:42:39 +0100
Date: Mon, 17 Mar 2025 22:42:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>, netdev@vger.kernel.org,
	Lev Olshvang <lev_o@rad.com>
Subject: Re: [PATCH net v2 2/7] net: dsa: mv88e6xxx: fix atu_move_port_mask
 for 6341 family
Message-ID: <a961a5fa-8323-430f-a42f-1a5eb2c6de24@lunn.ch>
References: <20250317173250.28780-1-kabel@kernel.org>
 <20250317173250.28780-3-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317173250.28780-3-kabel@kernel.org>

On Mon, Mar 17, 2025 at 06:32:45PM +0100, Marek Behún wrote:
> The atu_move_port_mask for 6341 family (Topaz) is 0xf, not 0x1f. The
> PortVec field is 8 bits wide, not 11 as in 6390 family. Fix this.
> 
> Fixes: e606ca36bbf2 ("net: dsa: mv88e6xxx: rework ATU Remove")
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

