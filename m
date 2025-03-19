Return-Path: <netdev+bounces-176222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02427A69672
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5921F19C3835
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD051F09B0;
	Wed, 19 Mar 2025 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cmM8z85B"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5819518DF93;
	Wed, 19 Mar 2025 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405394; cv=none; b=Pna0/tzkNJaVUQADO8iPx0NcP7aYcZb+t/zuf+KvYHy8ZHDkpn0eELERkK+fKkMBO2azv3hthv8QqArWe4Wj0YYvx5OsJ+l1+bjqqB2oQmUjjyYwLpWvmwVaM+BMYxhSacjlX6np3mM1iuyD161EpdlgmaApikr+BWHBI2IL7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405394; c=relaxed/simple;
	bh=cJdNszfi8jKyO7HEhBYy4WL9G/cRmATBwdqs6YNMLnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJf93TrsZaPT1pkVm6OJAs7VZelzVx+WZHVPovFpe2qDzj7Q/AIy84Roo6XrbYktBLOe+f9U7rndMh+LJWPY8PIuobLzwdoCImBDQXg12uxEVs1fzcL9uAtpvVpesO9gXRTUJq/HaG3k/sm5dLiHXiM19HgS95EO4s0FJxY2Bt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cmM8z85B; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yInekPkxEUZsGfvDOWG71rvNP9uywGTAsEy8aGf6gdQ=; b=cmM8z85B4knh1pafVsU4rkB+VE
	Q3GjgAv1mc4VqTd70IwPntzRiy/krdOToksZGwtBKN0eni/PRMa5AsXbBONc2wk2mvY5u2ne2eHcb
	WpreaSOKVUIyB0SSW4dS6VYkZ8TkEm5wEZL8U/k1+T/375W1pbXthB7M19S+WIE/WJZRAGLDzjdye
	fy3KwaLYPqUtWexETxKWPatIj8uXxKdXt/s8CBxDKO+ShmNGrqxuCeYiAkgI4s97Yt775o5S+dO3A
	kdiuvRtCDZzGIf8TuEwBX7NqhHLVdkLSRrcbzKOydnErm3ynSkqdiggryfxX3p2gQrfcZkZchM1SU
	3+wmdCBA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54242)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tuxEZ-0006jZ-24;
	Wed, 19 Mar 2025 17:29:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tuxEU-0005nV-2N;
	Wed, 19 Mar 2025 17:29:34 +0000
Date: Wed, 19 Mar 2025 17:29:34 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH 0/6] net: pcs: Introduce support for PCS OF
Message-ID: <Z9r-_joQ13YdJeyZ@shell.armlinux.org.uk>
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318235850.6411-1-ansuelsmth@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 19, 2025 at 12:58:36AM +0100, Christian Marangi wrote:
> A PCS provider have to implement and call of_pcs_add_provider() in
> probe function and define an xlate function to define how the PCS
> should be provided based on the requested interface and phandle spec
> defined in DT (based on the #pcs-cells)
> 
> of_pcs_get() is provided to provide a specific PCS declared in DT
> an index.
> 
> A simple xlate function is provided for simple single PCS
> implementation, of_pcs_simple_get.
> 
> A PCS provider on driver removal should first call
> phylink_pcs_release() to release the PCS from phylink and then
> delete itself as a provider with of_pcs_del_provider() helper.

This is inherently racy.

phylink_pcs_release() may release the PCS from phylink, but there is a
window between calling this and of_pcs_del_provider() where it could
still be "got".

The sequence always has to be:

First, unpublish to prevent new uses.
Then remove from current uses.
Then disable hardware/remove resources.

It makes me exceedingly sad that we make keep implementing the same
mistakes time and time again - it was brought up at one of the OLS
conferences back in the 2000s, probably around the time that the
driver model was just becoming "a thing". At least I can pass on
this knowledge when I spot it and help others to improve!

Note that networking's unregister_netdev() recognises this pattern,
and unregister_netdev() will first unpublish the interface thereby
making it inaccessible to be brought up, then take the interface down
if it were up before returning - thus guaranteeing that when the
function returns, it is safe to dispose of any and all resources that
the driver was using.

Sorry as I seem to be labouring this point.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

