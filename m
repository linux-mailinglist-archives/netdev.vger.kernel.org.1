Return-Path: <netdev+bounces-68511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080B88470EF
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC38A1C2441F
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D434405FB;
	Fri,  2 Feb 2024 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4G+wLnOP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468E15253
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879740; cv=none; b=I4X9BtGy61++T6tnTkxCZx8SXvk1knhhuRoLw+HEtvmIfATNNLTni184lnTgW1+p2XMpMpVwzt8zAjjv13SohyjueoG3AT4AEXG4S+08lMDT+n7Hxj4N+jU+0gb2hqs6jKyjiaAWyaNR1DuKvne2O8M2bNY3+VtTT72sP9IZO+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879740; c=relaxed/simple;
	bh=zzf3tM/xDIOJvG9PGYTwS7XHrp/VKHuDTa3fIVJ/QWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLe9wSKsZ8ARO7ET7IEEL5Ld7NyRCTDFIbz8QKYCAPvoMk4TIe9IAgyg5ZIRulK0KEDuutO4PnLcrTPkyx39o8P8upjoAGBaO48JZgV78dA+VGzpEcjusSjDiH2ZIz+2nuCazVl87ukdamtSQ4kUVRnX7OiH3mJaAyWt7i2N/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4G+wLnOP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lQeA3UTklFdDK4RrPIoIAKXAcItj4j8BpWSP86uUtS4=; b=4G+wLnOP7DT3xwElHJVU29jBRj
	M+1aSjQEj0dy3r9E3fd31Lq5ev4fqX6G43hUFWedgVmX5blwyzx/TR4vGuqL9ZstYHR6mBjlHMPFb
	TZeTXR70WmsztUdbwBR17RBF/Mf9z0DWMjBMEIa1IcH03x09gp3AN3TC/lGGfi+RRUMg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVtO5-006mgK-7N; Fri, 02 Feb 2024 14:15:21 +0100
Date: Fri, 2 Feb 2024 14:15:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Byungho An <bh74.an@samsung.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Doug Berger <opendmb@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>, Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH net-next 1/6] net: stmmac: remove eee_enabled/eee_active
 in stmmac_ethtool_op_get_eee()
Message-ID: <2399ecee-5f5d-46f7-8bb3-bea95cac4dcf@lunn.ch>
References: <Zby24IKSgzpvRDNF@shell.armlinux.org.uk>
 <E1rVpvc-002Pdp-Jj@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rVpvc-002Pdp-Jj@rmk-PC.armlinux.org.uk>

On Fri, Feb 02, 2024 at 09:33:44AM +0000, Russell King (Oracle) wrote:
> stmmac_ethtool_op_get_eee() sets both eee_enabled and eee_active, and
> then goes on to call phylink_ethtool_get_eee().
> 
> phylink_ethtool_get_eee() will return -EOPNOTSUPP if there is no PHY
> present, otherwise calling phy_ethtool_get_eee() which in turn will call
> genphy_c45_ethtool_get_eee().
> 
> genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
> with its own interpretation from the PHYs settings and negotiation
> result.
> 
> Thus, when there is no PHY, stmmac_ethtool_op_get_eee() will fail with
> -EOPNOTSUPP, meaning eee_enabled and eee_active will not be returned to
> userspace. When there is a PHY, eee_enabled and eee_active will be
> overwritten by phylib, making the setting of these members in
> stmmac_ethtool_op_get_eee() entirely unnecessary.
> 
> Remove this code, thus simplifying stmmac_ethtool_op_get_eee().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

