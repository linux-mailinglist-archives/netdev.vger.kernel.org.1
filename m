Return-Path: <netdev+bounces-158536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 118C3A12666
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F66D3A6966
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2BD86351;
	Wed, 15 Jan 2025 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bIiPRNPo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077478289;
	Wed, 15 Jan 2025 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952299; cv=none; b=GCSqi5gBlAvWPsryRjRjUBGlJzHAct5OBxeBMAmpNB4sfxepEM6DU4SldJPHFiQykZWOJHYRqaeCIC8OgMdVmofMDpRWitpLETxvlvOadL+UCgPRdig9BjN6yjcJlr5GS9FL/YH/DhCtvpWOkgQi/+D27AjaLWfVBe4hljSjFNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952299; c=relaxed/simple;
	bh=8mhYDJUZD/5t1PmtZKZnFyYSxY3mpFsGMki+Fdtrd3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=im/uMYy2qjQjuwbUimyFwP1kFviMUFCUS9vySN5xYlOXc4moAlTb7r27bGXubWWbj/CeB6qPCZQvdqynAiP5cmTO3cz3jLPzGg07/qPw/dqZSKUJfJemVo9hIUsXYlykn2Qi6VGdI4/Zhuvb0LaDH8hMPQ8QFASYoOMvec+qVZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bIiPRNPo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=158vAtH+h4mrgDSH25GOcKJSriDIgbKeWhTbU2pm9l4=; b=bIiPRNPosQYugRO4WIWPiGkNJT
	KjevovGDnnAtZ1+zUxyT/+mqtQeAMyWlk7gvkma7AJP9Hri4rVjbl6b4D+1yQ3NqpdDcuMjvCiFOn
	XZqXo2eFf8xQZxaG8RAYBOjfQppx+9cf/Fd+3MtEgZUbkNUO+KJkn7ZTvzbj8msoy7Tn/6GywCQg0
	JmLstI/SoNXBgQUu53s58B1iVg6e5LNR63GN2hgGsCAM8yjq7GEUOTzqFsVh4Kv5VCMVV2wrdh1Lm
	40XmhWYCR4bRWtlQSvqXQT+wo2D22fzRsbPSj0Jsx3jyIPQBIxH6d1M28NF7BW7dpRIY5lwOAG3hR
	YzmSbzbA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46456)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tY4da-0001Id-2X;
	Wed, 15 Jan 2025 14:44:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tY4dY-0006Ek-1s;
	Wed, 15 Jan 2025 14:44:52 +0000
Date: Wed, 15 Jan 2025 14:44:52 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Voon Weifeng <weifeng.voon@intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: pcs: xpcs: actively unset
 DW_VR_MII_DIG_CTRL1_2G5_EN for 1G SGMII
Message-ID: <Z4fJ5FIuotHMZ8fN@shell.armlinux.org.uk>
References: <20250114164721.2879380-1-vladimir.oltean@nxp.com>
 <20250114164721.2879380-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114164721.2879380-2-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 14, 2025 at 06:47:21PM +0200, Vladimir Oltean wrote:
> xpcs_config_2500basex() sets DW_VR_MII_DIG_CTRL1_2G5_EN, but
> xpcs_config_aneg_c37_sgmii() never unsets it. So, on a protocol change
> from 2500base-x to sgmii, the DW_VR_MII_DIG_CTRL1_2G5_EN bit will remain
> set.
> 
> Fixes: f27abde3042a ("net: pcs: add 2500BASEX support for Intel mGbE controller")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

I wonder whether, now that we have in-band capabilities, and thus
phylink knows whether AN should be enabled or not, whether we can
simplify all these different config functions and rely on the
neg_mode from phylink to configure in-band appropriately.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

