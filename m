Return-Path: <netdev+bounces-215719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90917B2FFFA
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7487EAC1AEF
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA78E2DCBFB;
	Thu, 21 Aug 2025 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EEDvRMYs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DB5274FF5;
	Thu, 21 Aug 2025 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793308; cv=none; b=JM674fgOBSqkU4gTxKzpf+gkOATaAUoJAGDypLUviCnt28h0Nq7OQzE5FabyvBk55igA+gTjBfD/2e6awnbTaJpSo+SQ1WZznLvVafIej/vA+S+Pykk57jdy4Li5ntH6TlPUPBe1w/4xZD5nhJKQNUrN7MqlL/ml7RXAbyCAz24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793308; c=relaxed/simple;
	bh=UlGrfSohYvmCsiBDTKP3ye8vAh0tUIfx4LHIKObHZ+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ck50RZ5eBUuNXWiMZkqOXN0Z26BKN42VgcoUe84p/+hWhLuB/sv+rurF7z6qYDSdobZTLPyx9SZZKgXsifDPTvTHricutUIwPsVAjP0vFG5ZNa1gcy4w8PF6IyhmVSGlRRnX9EvsYjhtJ40c7apQlVzDXIFU2Zg/ATzWiijAB94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EEDvRMYs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Cv1lV7YR8+jcAn23Ws2PaQq6LK7+5rl7Y8lkLzr7ZDw=; b=EEDvRMYsUhFBFv32t/XHXw0AJR
	Bl5kzSahjSdA1UFO/MAo1lU+smosAb44vyJW+zor4f4GPRu3FerbRBITKB/tq0nvL/wjhSenxKauK
	kntcp2V5VIK+2B4ZA3ljEsKW7jgjli9srjuf67RkC8Gv+wVrBS3Ua3sTfxqi2uVLYW0o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1up82l-005TVm-HI; Thu, 21 Aug 2025 18:21:39 +0200
Date: Thu, 21 Aug 2025 18:21:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>, linux-kernel@vger.kernel.org,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Robert Marko <robimarko@gmail.com>,
	=?utf-8?B?UGF3ZcWC?= Owoc <frut3k7@gmail.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH net-next 03/15] net: phy: aquantia: reorder AQR113C PMD
 Global Transmit Disable bit clearing with supported_interfaces
Message-ID: <0087f090-4ef0-41d5-a3ab-10c1eb2756f4@lunn.ch>
References: <20250821152022.1065237-1-vladimir.oltean@nxp.com>
 <20250821152022.1065237-4-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821152022.1065237-4-vladimir.oltean@nxp.com>

On Thu, Aug 21, 2025 at 06:20:10PM +0300, Vladimir Oltean wrote:
> Introduced in commit bed90b06b681 ("net: phy: aquantia: clear PMD Global
> Transmit Disable bit during init"), the clearing of MDIO_PMA_TXDIS plus
> the call to aqr107_wait_processor_intensive_op() are only by chance
> placed between aqr107_config_init() and aqr107_fill_interface_modes().
> In other words, aqr107_fill_interface_modes() does not depend in any way
> on these 2 operations.
> 
> I am only 90% sure of that, and I intend to move aqr107_fill_interface_modes()
> to be a part of aqr107_config_init() in the future. So to isolate the
> issue for blame attribution purposes, make these 2 functions adjacent to
> each other again.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

