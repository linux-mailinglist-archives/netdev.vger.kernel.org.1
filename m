Return-Path: <netdev+bounces-156201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4B9A0579B
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 11:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04873A5933
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 10:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B491ACEA2;
	Wed,  8 Jan 2025 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PtfGjMV6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A0C1F0E33
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736330881; cv=none; b=gieOPL37ueT9jss4QwCuTOB2juDpjn/Jz7eem5hFpQKZo1V09wya/HWcDQjivFuGZ/lTWg7Xj+t09sSSvItEH/wzkteP6ne4YZP8/O6m09P4Pat5BKJ6HFyC8vw1w/7m4ia54n7kMk2yz6D1XvFNGxs5OVNA74pLVnDm6GCF/5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736330881; c=relaxed/simple;
	bh=kk5f8gTS4BAqtR8GRVUopIZlRTyMZM6FgpS5frXvTQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwCCVPlxsibvRo60oBkfXB2g+kLmqk0s22eDXKpT0MIB1FwD7pxcmhd99tILIKt3nJFcjv4LEicuVI6CdADtEAZHHU+rnjrRY0xgg4SEdtSl71ubuo5dxw9zghcStDClLrvnJjQPnCnut0poFKNilKJlQ1blC/imCkUifVXZTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PtfGjMV6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IM18OvxnC2Fka89jFAwkpiq2it51EwQpNq/r7/+W1qM=; b=PtfGjMV6PHxFkPsIypAGiLRCK7
	iqSLKC1OGaVkSIc8VVHCRlTTXaizu2k7rcfRIJjTlqFwILbKNa+VgN5x8UW1RNQQToDvD3IKqKYqQ
	UdTuwFuXYn3RncFb9zrzkwGJLE31h4YZKzdi6nDvgJYFZrld1MxZAJe2nDd4rOIxGaCcXK7RINXmc
	I+/+RybMotW6qFPVCbjkW/6c27C9Xj6uo+IxXx7ZHQGOhM69/3PTT+6fJA0oflXXNC0PcM3lVH/h7
	yl4bYMAx9fq62wORkA5tZU8aezNa97S0XYoA4XIByJsA4JNMAwosQooWALZ8SlU9DLvTzM/mgUM/U
	gziQYczw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60424)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tVSyU-0000Lv-2r;
	Wed, 08 Jan 2025 10:07:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tVSyP-0006Bv-0q;
	Wed, 08 Jan 2025 10:07:37 +0000
Date: Wed, 8 Jan 2025 10:07:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 02/18] net: stmmac: move tx_lpi_timer
 tracking to phylib
Message-ID: <Z35OaQDLS_i2uL_b@shell.armlinux.org.uk>
References: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
 <E1tVCRZ-007Y35-9N@rmk-PC.armlinux.org.uk>
 <66b95153-cb12-494d-851c-093a0006547f@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b95153-cb12-494d-851c-093a0006547f@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

On Wed, Jan 08, 2025 at 03:36:57PM +0800, Choong Yong Liang wrote:
> I have completed the sanity test on the EEE changes to the stmmac driver.
> 
> It seems that most of the changes are acceptable with respect to EEE behavior.
> 
> However, I noticed that this part of the code requires a minor change to fix
> the logic:
> 
> 	/* Configure phylib's copy of the LPI timer */
> 	if (phylink_ethtool_get_eee(priv->phylink, &eee) == 0) {
> 		eee.tx_lpi_timer = priv->tx_lpi_timer;
> 		phylink_ethtool_set_eee(priv->phylink, &eee);
> 	}
> 
> Otherwise, the "tx_lpi_timer" will not be set correctly during the initial
> state.
> 
> Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>

Thanks for testing. I can't update the series as there has been a power
failure at home, hence the machine that has my git trees on is
inaccessible at the moment.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

