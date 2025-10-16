Return-Path: <netdev+bounces-230209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61816BE5581
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0CCB3359CB0
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 20:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EE22DF3CC;
	Thu, 16 Oct 2025 20:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FcdARd/q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E892DF718
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645621; cv=none; b=MrvcQzH5uaZPa+er8XwBO//iwrGXrzVXUqf2XYBkQCFm9ZSUpYzqnO8IU2HOEKmLmLODawHQQmbfkJMK+zBZNfNCPD4n7GIBHR0sJSkfhUqD+qMr/KzA3sGzLOsmEXoLcZGfHnk1E7ls5lIuaTWxXT63i0lfUVTuFmnqRmXWJTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645621; c=relaxed/simple;
	bh=yyVXUjSKousEWfXgiNH6TQvb8GTz46lD+gq6KXOHxwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXAxxVpmAtaMB3/sUTA9mfQjTWAt+3q9puQgdkUhNW2jI0YZA3zjaoLZlX3VO0VyvJhJ+JI3Te3NnDQTXf2ievAmRGdkFUcjCpdkLR4inNP78T0kiL9B8KVTTzJ6Dji9aAMGUsfVuafm2HHkwEAPuDtk7+58fygXaYxGcv3OCUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FcdARd/q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jQY0mCXvtYTrJxEuQoUAjjjSvUJckp3Y//KHMiRxipg=; b=FcdARd/qcEg5Md7LoKhVTRTkVR
	TwgC4AbMC+jNXUbgMQTU2LM+CXYbk2aigYixI2hfe6VsO7lo1Q3V70T8OTuyLhhjNBOWUljV4V6G5
	Ulwz1sDZMBtH6dedyA4uyPNMlEoXIQBCEBB54gmOXFLSxJ/Vkhmo75zBFObsD82F83B8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v9ULo-00BCdX-G1; Thu, 16 Oct 2025 22:13:28 +0200
Date: Thu, 16 Oct 2025 22:13:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/5] net: stmmac: dwc-qos-eth: move MDIO bus
 locking into stmmac_mdio
Message-ID: <186fe8ba-9dfe-4509-970f-f7e51bc33db8@lunn.ch>
References: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
 <E1v945J-0000000AmeJ-1GOb@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1v945J-0000000AmeJ-1GOb@rmk-PC.armlinux.org.uk>

On Wed, Oct 15, 2025 at 05:10:41PM +0100, Russell King (Oracle) wrote:
> Rather than dwc-qos-eth manipulating the MDIO bus lock directly, add
> helpers to the stmmac MDIO layer and use them in dwc-qos-eth. This
> improves my commit 87f43e6f06a2 ("net: stmmac: dwc-qos: calibrate tegra
> with mdio bus idle").
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

