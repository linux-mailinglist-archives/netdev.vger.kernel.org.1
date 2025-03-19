Return-Path: <netdev+bounces-176346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB55A69CA8
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 00:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EAF642159F
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 23:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0180B2236E3;
	Wed, 19 Mar 2025 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qCsS93QN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DB31D514B;
	Wed, 19 Mar 2025 23:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742426570; cv=none; b=u9BTRD1+WRnjHY9feT6PzjAE1FsAhugs8l6Fo1E1yEN+eHUHPJ08OlYWhyVF2davcH/eE+g/aqNlin+ewTw/4HfvSP48slIYz6IoXYpNSkLbZoFVVagaNQuHsgulC6gmc79sTta3aEHMQtusDMmIBOr/P9iE1wFjb9eMctmToq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742426570; c=relaxed/simple;
	bh=4RgJAq4hJhHstm/ehzKevP6ZWeReZAqhuDKIoiRLOY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/XU7SPpVRZVsBaN7wHX8wIOBVFmQzC2vwBpcmu5a3Rm0vivAuE/0dUvjG3rp3cdpYR0ZlCLOkXEM05Pdv8VHb94tcD5vVAcAz4wlkSXypIfKV8l8VvYlTcNUkmJgWWimnvTI/LfURwiMq/zeaVveho6bHiOG58MkF5EIop3thM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qCsS93QN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5tW/qXnvYgM00U8Ba3VQcPQjfpnDlU9t847cUdAiY8I=; b=qCsS93QNEKnq1solw/D+LZAi+f
	G32S6DpBxTTYEroBH3pDG6Os2stVchMaRoa/g9Irhbqkk4cQDjyqRUmPyafRR1LT38Mf1xxC8+uvx
	PYxkbEC8dwRIIszZ+vW35mQWANSFGRLqQfDI+NddQKRajnZibp8ANjmzYK1faMKYULv8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tv2jz-006QKR-El; Thu, 20 Mar 2025 00:22:27 +0100
Date: Thu, 20 Mar 2025 00:22:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Wu <david.wu@rock-chips.com>, Yao Zi <ziyao@disroot.org>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v3 3/5] net: stmmac: dwmac-rk: Move
 integrated_phy_powerup/down functions
Message-ID: <f6a6e6e6-c00d-4920-a3a3-8699e9a88b6e@lunn.ch>
References: <20250319214415.3086027-1-jonas@kwiboo.se>
 <20250319214415.3086027-4-jonas@kwiboo.se>
 <d7b3ec5c-2d74-4409-9894-8f2cb3e055f6@lunn.ch>
 <e766eb6d-618a-43a0-b1e1-954c2c3fbf0e@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e766eb6d-618a-43a0-b1e1-954c2c3fbf0e@kwiboo.se>

> > Do you know what these MACPHY_ID are? I hope it is not what you get
> > when you read PHY registers 2 and 3?
> 
> I think it may be:
> 
>   GRF_MACPHY_CON2
>   15:0   macphy_id / PHY ID Number, macphy_cfg_phy_id[15:0]
> 
>   GRF_MACPHY_CON3
>   15:12  macphy_cfg_rev_nr / Manufacturer's Revision Number
>   11:6   macphy_model_nr / Manufacturer's Model Number
>   5:0    macphy_id / PHY ID Number, macphy_cfg_phy_id[21:16]
> 
> and
> 
>   MACPHY_PHY_IDENTIFIER1 - Address: 02
>   15:0   PHY ID number / default:cfg_phy_id[15:0]
> 
>   MACPHY_PHY_IDENTIFIER2 - Address: 03
>   15:10  PHY ID number / default:cfg_phy_id[21:16]
>   9:4    Model number / default:cfg_model_nr[5:0]
>   3:0    Revision number / default:cfg_rev_nr[3:0]
> 
> So likely what you get when you read PHY registers 2 and 3.

Ah:

drivers/net/phy/rockchip.c

#define INTERNAL_EPHY_ID                        0x1234d400

However, it is not clear where the d4 come from.

The problem here is the upper part should be an OUI from the vendor.
I doubt rockchip actually own this OUI. They do actually have the MAC
OUI: 10:DC:B6:90:00:00/28. I don't know if you can use a MAC OUI with
a PHY ID?

	Andrew

