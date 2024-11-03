Return-Path: <netdev+bounces-141295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9D09BA65E
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 16:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 277A9B20FAA
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 15:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D73B16FF5F;
	Sun,  3 Nov 2024 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="flb3kUVK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66423774;
	Sun,  3 Nov 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730647246; cv=none; b=uX1l4RpgMc83mvaPYYjKrBjajGwcAJqvfJmCctHnYy04hV+ey/kTJX7Km57OUZ+7ie/yvmrby35V3ngj0D9kdxVqJt25nndMBAqLUJWqX1wIfjFHGpIIvx1JFGRZ9IoNOPYhGWbfMkhqlmCyDhuk9tzAyxb/r1ntJ1kteR+pI+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730647246; c=relaxed/simple;
	bh=zVuaYgLRsZYa1XUybwHktQ2q0GlPerZ3CIB6sz8W8ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MW6SuK9umTKgSymdE4wr3e7X8ipXoddxRltGZts4tR41001sap13mfKiDnunIYv0k4n60/peBTaGeCphQHU+xfD0mkLlcbIUwfy8vlE37J3ubjTQOtNGvaEjs5Y8AnGPplpyVyBXw/Drr9R1brYXNu3H/K4jS+zJWgOrFl3c61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=flb3kUVK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EcTJqEHOtmy9IglxtzxFtYhDHa1so+bTTn9DvV6/mbw=; b=flb3kUVKt+wvset/BhIkj4qv2z
	og3ChRn29r3w+tpG7W0e01u6Eb7S1IgpvDGG/18J1p1wYdlxkS/4Fipp+MxnJoZ1Om/HUoS2hlTB+
	8HUjn7ib/45Winnoln6fzT/APcNAkM80jkklStHgZkXEG4kYbQIXP6Zl0BVSSdk4SmPM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t7cP3-00C1VJ-Cf; Sun, 03 Nov 2024 16:20:33 +0100
Date: Sun, 3 Nov 2024 16:20:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Diogo Silva <diogompaissilva@gmail.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, marex@denx.de,
	tolvupostur@gmail.com
Subject: Re: [PATCH] net: phy: ti: add PHY_RST_AFTER_CLK_EN flag
Message-ID: <6e5298c0-eded-4fd2-8ce6-52d4239da53c@lunn.ch>
References: <20241102151504.811306-1-paissilva@ld-100007.ds1.internal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102151504.811306-1-paissilva@ld-100007.ds1.internal>

On Sat, Nov 02, 2024 at 04:15:05PM +0100, Diogo Silva wrote:
> From: Diogo Silva <diogompaissilva@gmail.com>
> 
> DP83848	datasheet (section 4.7.2) indicates that the reset pin should be
> toggled after the clocks are running. Add the PHY_RST_AFTER_CLK_EN to
> make sure that this indication is respected.
> 
> In my experience not having this flag enabled would lead to, on some
> boots, the wrong MII mode being selected if the PHY was initialized on
> the bootloader and was receiving data during Linux boot.
> 
> Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>

This should be merged to net.

Fixes: 34e45ad9378c ("net: phy: dp83848: Add TI DP83848 Ethernet PHY")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

