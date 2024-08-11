Return-Path: <netdev+bounces-117496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03EC94E1FC
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 17:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717661F21458
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B0814B96D;
	Sun, 11 Aug 2024 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iIhp/jbc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116D514B940;
	Sun, 11 Aug 2024 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723391321; cv=none; b=tblzEraMB9Yag/tfHDH9ffSx9WIzHWNsSDrAf7EYGn7GfS516zypAYmkgCeJgnX/kzqOxMbMb7gUPZrgXVLrG9Nxk1F4YrZVaOP/upKOJ204fs2u2XeCGCyCrUZwz+BYX13STRnQbDXTfVTUW4XnTq7WSbq5/qoL/157rkEIP7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723391321; c=relaxed/simple;
	bh=f43QfyOUX/gXe6JjTPuHVIjHnlhBCoIJAQ9ZAfOUr7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dA7jIOox4Ja1Mr2vjKT3tFBly5yI2kPk9JrovXUu8zzGugXHcSDS2hImp08+Vr25Gd3bYWgoFV0Kze9DmvNbkFZ7GPLLUlU1+djpEwIW/Us0HBfoo+hI3QpLt2vbbWE910gxWkBnKGLvZz8zkZtp9V4v2Hv7ncX7LKeaCjKSAJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iIhp/jbc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4zc8D1uVEP2Yeb140sPrV2CXJerxAyIX5yPeMGS2YbM=; b=iIhp/jbcTYxSmTOyyvvDGEqUEV
	zhg5fxLQ6qN0ji7WAh8GKmAXG/JnjcbMo+b55gePoiHWlFkxyHUDTFTU7G7BJ3qO8zFC0dHeXVoz0
	6nUcG/ZS43oK748k0xHwyMI/QdQDHgb6l8x5RNu97ZBkUhHae0nsnD3WCLEIPzlUTM50=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdAo2-004VTK-6g; Sun, 11 Aug 2024 17:48:30 +0200
Date: Sun, 11 Aug 2024 17:48:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, masahiroy@kernel.org,
	alexanderduyck@fb.com, krzk+dt@kernel.org, robh@kernel.org,
	rdunlap@infradead.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
	Pier.Beruto@onsemi.com, Selvamani.Rajagopal@onsemi.com,
	Nicolas.Ferre@microchip.com, benjamin.bigler@bernformulastudent.ch,
	linux@bigler.io
Subject: Re: [PATCH net-next v5 07/14] net: phy: microchip_t1s: add c45
 direct access in LAN865x internal PHY
Message-ID: <c8ec015b-2e25-49c9-a404-820545992909@lunn.ch>
References: <20240730040906.53779-1-Parthiban.Veerasooran@microchip.com>
 <20240730040906.53779-8-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730040906.53779-8-Parthiban.Veerasooran@microchip.com>

On Tue, Jul 30, 2024 at 09:38:59AM +0530, Parthiban Veerasooran wrote:
> This patch adds c45 registers direct access support in Microchip's
> LAN865x internal PHY.
> 
> OPEN Alliance 10BASE-T1x compliance MAC-PHYs will have both C22 and C45
> registers space. If the PHY is discovered via C22 bus protocol it assumes
> it uses C22 protocol and always uses C22 registers indirect access to
> access C45 registers. This is because, we don't have a clean separation
> between C22/C45 register space and C22/C45 MDIO bus protocols. Resulting,
> PHY C45 registers direct access can't be used which can save multiple SPI
> bus access. To support this feature, set .read_mmd/.write_mmd in the PHY
> driver to call .read_c45/.write_c45 in the OPEN Alliance framework
> drivers/net/ethernet/oa_tc6.c
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

