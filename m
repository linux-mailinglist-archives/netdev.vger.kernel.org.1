Return-Path: <netdev+bounces-231867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE1EBFE0D4
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6999A4F5B49
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E692F49ED;
	Wed, 22 Oct 2025 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1V+LIdKI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386DA2F0671;
	Wed, 22 Oct 2025 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161636; cv=none; b=Rv90Kf/sAiHZIbSB2+zrP7Gi+jg7/16SqYsHkie8WA1nEJRz7l+mzjvIp+mv0YcW7Rkv+nD4UugpiE37hkIg90lWDTN4Ua2WU7DvIBDntKXKXctsxAshgYBM0/rOdC8LWghQih1xnpXrcrcIMgHj9zOtgKs8wHuZ/2DKpdYbeRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161636; c=relaxed/simple;
	bh=EhmrM/rrZkqdkcIvkN3sA3FlTAW1QyALgArWs2KuzpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUGj5vaqdbfpgUXA7IiW5tIMjySxPMgOFfc5GW/Q5+nIDVJEk6l4JtsQj5fG2/7yhBJ4eCqKU9QLX7AiGQH+9MjPp2rybnwosyv7hN0azZZkj1EjPBTaGsEDIHpIlcJiW08EZarZ0pNQQcr0X74bRn4eZvSrZL+MrOdEwdgfhOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1V+LIdKI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=B0MoY2AgpEB5vSiVMVo5RoknNJN0kCXnUeivnHXYIXs=; b=1V
	+LIdKI4P+Icu/8ukHThqV1tbQgarFsVugvL5WRk0IRB8NJDX0TH+kApHCwP1cdGzgbIvRCnOheSIR
	cuTGsJXE2FC5JdvywAS7Zim7m0qZqc2BtETLen57s1NSGOCUiNCU2E5sedkDQ5rFPexMsebbwJZ0S
	U06ymByNQI5yog0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBeae-00Bo3f-Q2; Wed, 22 Oct 2025 21:33:44 +0200
Date: Wed, 22 Oct 2025 21:33:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: Re: [PATCH net-next v2 5/5] net: macb: Add "mobileye,eyeq5-gem"
 compatible
Message-ID: <51833ec4-e417-4ba3-a6d1-c383ee9ea839@lunn.ch>
References: <20251022-macb-eyeq5-v2-0-7c140abb0581@bootlin.com>
 <20251022-macb-eyeq5-v2-5-7c140abb0581@bootlin.com>
 <ef92f3be-176d-4e83-8c96-7bd7f5af365f@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef92f3be-176d-4e83-8c96-7bd7f5af365f@bootlin.com>

On Wed, Oct 22, 2025 at 10:09:49AM +0200, Maxime Chevallier wrote:
> Hi,
> 
> On 22/10/2025 09:38, Théo Lebrun wrote:
> > Add support for the two GEM instances inside Mobileye EyeQ5 SoCs, using
> > compatible "mobileye,eyeq5-gem". With it, add a custom init sequence
> > that must grab a generic PHY and initialise it.
> > 
> > We use bp->phy in both RGMII and SGMII cases. Tell our mode by adding a
> > phy_set_mode_ext() during macb_open(), before phy_power_on(). We are
> > the first users of bp->phy that use it in non-SGMII cases.
> > 
> > Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> 
> This seems good to me. I was worried that introducing the unconditionnal
> call to phy_set_mode_ext() could trigger spurious errors should the
> generic PHY driver not support the requested interface, but AFAICT
> there's only the zynqmp in-tree that use the 'phys' property with macb,
> and the associated generic PHY driver (drivers/phy/phy-zynqmp.c) doesn't
> implement a .set_mode, so that looks safe.

I was thinking along the same lines, is this actually safe? It would
be good to add something like this to the commit message to indicate
this change is safe, the needed code analysis has been performed.

	Andrew

