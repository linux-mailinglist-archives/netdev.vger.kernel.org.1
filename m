Return-Path: <netdev+bounces-193572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E57C5AC4906
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 09:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C60A3B8A11
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 07:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00C01F473C;
	Tue, 27 May 2025 07:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vZtNggNM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBED72614;
	Tue, 27 May 2025 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748329759; cv=none; b=jip/EsnpDHdGCiD6tiWZe3siw16LJhUMpZcPMd4p9L/a+1WgdVpcM3Q4dLkLMCaNxuUhYDho8uMHypep+4HvWQjNSWyhL0KldvE+t5zFYD3Ksvbq0ahfmBL2uWakvnqXY1kzw3NZVVY/yQawulF358tW8DyGfKacTUFGeIx3Lyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748329759; c=relaxed/simple;
	bh=mwUc9fpakFITf3u5u5B+KtIIJZ8HBMz/j48CCZchD1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPpA3jtcA0SJ3osy6nTqGCupYRlPUsjwoMlylwtlpmhpWeFgqOfKS3Ja6swDTZhbUyd+uw+3UcQmmmdnvaM8Hx6q/T0Pp0lj8krom+zHc4qQWwiLccDZPJPvdtuYHBsKu87LyFMOKh9XNbxxNIlRrEsFbBGJVaelrhEfKMf3jyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vZtNggNM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TM1ZXgxDnV1AOy6fTMiX6DNJTsvGab4tXjhYp/X1Q60=; b=vZtNggNM5ysO3ta5geJEq9GbkG
	nUv8Y619M35gIcy/eoOftwMaKcbe/fXPe6mPy/LggdXEV46mrqRiGEGN3fHO0hdf7GNdhGAI7P7mv
	eOpzwG8lEsgkEyLFehAQCrJ67L/jhiCJ56CiILCGG0VYv1H/uOAqPw9v5jBMfxt1cNasxsnaXqLev
	MDL8q+jMYR8mOwsrID1rvveW8gQgjVdU1+vdiZJ37fMCfJoCcBhs1AqB2oNx+rZL8PyFLHc2PaRDw
	KtH5eWNsQ8ga2fxU5liydXvM/pF8rD38xJnbYCN1u+LdgCikEcGZMZ8z22bBoOKt2Jt/mTeHg/5jA
	+P0qZMyw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45038)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uJoQv-0007LH-2O;
	Tue, 27 May 2025 08:09:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uJoQr-0001EZ-0x;
	Tue, 27 May 2025 08:09:05 +0100
Date: Tue, 27 May 2025 08:09:05 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] dt-bindings: net: sun8i-emac: Add AC300 EMAC1
 nvmem phy selection
Message-ID: <aDVlEWZlprYpN3FE@shell.armlinux.org.uk>
References: <20250526182939.2593553-1-james.hilliard1@gmail.com>
 <20250526182939.2593553-3-james.hilliard1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526182939.2593553-3-james.hilliard1@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, May 26, 2025 at 12:29:36PM -0600, James Hilliard wrote:
> The Allwinner H616 EMAC1 can be connected to an on-die AC200 or AC300
> PHY depending upon the silicon variant.
> 
> Add a new allwinner,sun50i-h616-emac1 compatible and example, support
> for the allwinner,sun50i-h616-emac1 will be added later on.
> 
> Add nvmem-cells and nvmem-cell-names properties for the ac300 efuse
> based phy selection.

You also need to mention the non-standard usage of phys and phy-names,
which is the whole reason I suggested you need to patch the binding.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

