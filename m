Return-Path: <netdev+bounces-232247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CFEC0323E
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 21:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAABE4F3C51
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 19:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5E534BA51;
	Thu, 23 Oct 2025 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Tm1Zrbur"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E1C34B433;
	Thu, 23 Oct 2025 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761246504; cv=none; b=PBAKYxBXN6wBQzoviDanOrgEXbnwYQmXix7bbHrz++yXhGu8MyTXJJsNrBr/ZplU3XkAlY7Yz4yBCCppa8gq0x38Hyb8olyAJ5NmkycHoDGl7y+vOTsm2mxXHjH4+cCxtUD6wJRPqwvLO52V+LocHIRxVwFDp+l+tsyOpzoEoTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761246504; c=relaxed/simple;
	bh=S3Dg+nUTg8JCuATR8lD9tK3QqbksSXmt4GVjY8UM3v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWJKD9ESBRsbfFOuHcxHxs+E1DQMgqPMA7xSNk7P7iUhXWBLhNOoBZ+zZRI+lcZS80nIIzaVU5V95qIGjrAauE4m54o4qn7Llf9YvHbR+VEMtiUQexA76BOR/ai5G8iWoS4U+mjLY8zk8fC8Mlzv0XcH/1CCbFusATReaqdZzSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Tm1Zrbur; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Lhn5bzMlAShhFSJmAR4GsBUbfsKVR0B5+J/foljot0Y=; b=Tm
	1Zrbur6hxz6p84Dz+kBFPPxxgHVjhFp0tl0w6oMEu4qAnhK/JQDpRQzdjTd/nKWtaFIIbKn91SpUU
	kCBjM3SQ/bRp4FiP8WhX+f9pSgI/IB+r22K6ntAIawn70Cz/S0m2eJ0rYC4ey0RVq70jHWDtjAcpP
	/7sZRPyhveeKEdw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vC0fW-00Bulo-91; Thu, 23 Oct 2025 21:08:14 +0200
Date: Thu, 23 Oct 2025 21:08:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: Re: [PATCH net-next v3 5/5] net: macb: Add "mobileye,eyeq5-gem"
 compatible
Message-ID: <e688fa9d-7f3c-4b0f-882d-1cc681eaded7@lunn.ch>
References: <20251023-macb-eyeq5-v3-0-af509422c204@bootlin.com>
 <20251023-macb-eyeq5-v3-5-af509422c204@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251023-macb-eyeq5-v3-5-af509422c204@bootlin.com>

On Thu, Oct 23, 2025 at 06:22:55PM +0200, Théo Lebrun wrote:
> Add support for the two GEM instances inside Mobileye EyeQ5 SoCs, using
> compatible "mobileye,eyeq5-gem". With it, add a custom init sequence
> that must grab a generic PHY and initialise it.
> 
> We use bp->phy in both RGMII and SGMII cases. Tell our mode by adding a
> phy_set_mode_ext() during macb_open(), before phy_power_on(). We are
> the first users of bp->phy that use it in non-SGMII cases.
> 
> The phy_set_mode_ext() call is made unconditionally. It cannot cause
> issues on platforms where !bp->phy or !bp->phy->ops->set_mode as, in
> those cases, the call is a no-op (returning zero). From reading
> upstream DTS, we can figure out that no platform has a bp->phy and a
> PHY driver that has a .set_mode() implementation:
>  - cdns,zynqmp-gem: no DTS upstream.
>  - microchip,mpfs-macb: microchip/mpfs.dtsi, &mac0..1, no PHY attached.
>  - xlnx,versal-gem: xilinx/versal-net.dtsi, &gem0..1, no PHY attached.
>  - xlnx,zynqmp-gem: xilinx/zynqmp.dtsi, &gem0..3, PHY attached to
>    drivers/phy/xilinx/phy-zynqmp.c which has no .set_mode().
> 
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

