Return-Path: <netdev+bounces-231866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6550EBFE0AD
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0F054F1469
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7118B34888F;
	Wed, 22 Oct 2025 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TFWwrRME"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE054341AAE;
	Wed, 22 Oct 2025 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161399; cv=none; b=Ry0CUMt+Wf6inG/BcATpw4NPpSj6sGLvIHUQaGG1MVr8OqVEFT+xuEteSNNgBaOgNp7Fg5JIwFdmIK4D/W/zFFdmVQrJbf6mwpgMaKJNegol7TT0dgC95NwF7Fu8uiSMCr8htgnLZ/werbRhFuErcl06wD0O5lAuOApLrxb0PVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161399; c=relaxed/simple;
	bh=aylRSeW6f7/jZAStZYF+GfxYz7H4XiINynJPpBJAtkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdzVPZvNYwaX66NdYht8ADX8S6vG1B2eSlrqMvQWGtEOPw5h7F1dVt1Uxg1D17fvj83UKVRaa+OdsUFk4Tr8/7iiOo+2aveB+xl8XMKMrZiPwsXRpgiezf55wximqg57go49JlNUUHrS03tKe9ZA92fiCG4XBaKRHT3dUztPjNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TFWwrRME; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=JmGvvyitZtKG5TxQ11zgVGIqKBeTXkzSPyZzHwQEH8E=; b=TF
	WwrRMEOY0aRpB2o/vTdZgKL4mWtBAFHZ9UYduTDc+pcP+l18dPUlAOeyL1Mtn7DFN7Ugpy4i/RJUF
	oQVY7bPiLFPJD9P11N05H/zRksXVM/CbddOSadrLo8mkAgmgmjdaw23kk8ubUUmy829YbApdxx1NJ
	KA5ASufrUxfBsP0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBeWq-00Bo2T-F2; Wed, 22 Oct 2025 21:29:48 +0200
Date: Wed, 22 Oct 2025 21:29:48 +0200
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
Subject: Re: [PATCH net-next v2 4/5] net: macb: rename bp->sgmii_phy field to
 bp->phy
Message-ID: <97534daf-f66d-4fff-b761-5470517021d7@lunn.ch>
References: <20251022-macb-eyeq5-v2-0-7c140abb0581@bootlin.com>
 <20251022-macb-eyeq5-v2-4-7c140abb0581@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022-macb-eyeq5-v2-4-7c140abb0581@bootlin.com>

On Wed, Oct 22, 2025 at 09:38:13AM +0200, Théo Lebrun wrote:
> The bp->sgmii_phy field is initialised at probe by init_reset_optional()
> if bp->phy_interface == PHY_INTERFACE_MODE_SGMII. It gets used by:
>  - zynqmp_config: "cdns,zynqmp-gem" or "xlnx,zynqmp-gem" compatibles.
>  - mpfs_config: "microchip,mpfs-macb" compatible.
>  - versal_config: "xlnx,versal-gem" compatible.
> 
> Make name more generic as EyeQ5 requires the PHY in SGMII & RGMII cases.
> 
> Drop "for ZynqMP SGMII mode" comment that is already a lie, as it gets
> used on Microchip platforms as well. And soon it won't be SGMII-only.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

