Return-Path: <netdev+bounces-128716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BADF97B275
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 17:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D122728896A
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 15:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BCE170A0B;
	Tue, 17 Sep 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sHPH5Pj/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251D41607BD;
	Tue, 17 Sep 2024 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726588758; cv=none; b=qgKJPKB/5e0VZwGQXKmmn/9MmS99frYJPQ5xGwQCocWvKHvyKq1rGgnZP5SdVY6yMl7pktMX6B0tLIMnK9XQstZqKmfhjX47FuuQWjFeEZF5gXLAzWFzAOPdqyWqfBe1i17FSixJCbBvFsbdy1e3n5PLyX9MzSdv3xvTJjJcLio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726588758; c=relaxed/simple;
	bh=vVe1DsfC752Y7/CCfeP5jLWQ9L1GBOX1daAtayOPRMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iM33vUlzcMmtLI77SHTnPLe6bw0H6vEz4KunWVNI5wk3muZXvc5z4UX78l3+IKsyk9qfZpe3max/sd+D0CogXzSb/GkzgcWrh6fhk68aDV9eHzJKQJ5xyqJ4+1/HIlSc6VTqqL4wCpLxFBIBAxHhZ9Cy8wni3x5Dc/dRm9/iMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sHPH5Pj/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+76ZtTTIrevT3SE9ibJTcm4S3lTOZCUnPzEaiQSo0V4=; b=sHPH5Pj/c40k83t4U98O4PTvEN
	fTTM6pOhAZ6yWFbKOiLmWPGi0JH1KI8hBW2fnr+/8dksebCopR/EA33XAZTfXghk7S3PA9UsK5YfD
	GyvMcFjBg/s3MFVSrd/T38glmpMQ3QrYpegHWe0zHQ4CoHjphiHv0Juh1NH9TABgDRfPzvLfnKyQ9
	qhBi+nIvBnWWBOHuS1diQj88G9kHOhaAaSr35irZy6JlOYgvKorNqIJlvReOUaPzgpUQRsFqY79Gx
	r1FVWCPQH7X2ud6VlHV7yOVFTtEtjTOQga72aToPLWcAJNhhHHanjA2st1+7+lGGoEU/PHbyC8OqR
	0xvygMiA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39366)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sqabc-00075A-2W;
	Tue, 17 Sep 2024 16:59:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sqabW-00086R-2w;
	Tue, 17 Sep 2024 16:59:02 +0100
Date: Tue, 17 Sep 2024 16:59:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	andrew@lunn.ch, hkallweit1@gmail.com, richardcochran@gmail.com,
	rdunlap@infradead.org, bryan.whitehead@microchip.com,
	edumazet@google.com, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, linux-kernel@vger.kernel.org,
	horms@kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V6 4/5] net: lan743x: Migrate phylib to phylink
Message-ID: <ZumnRtZYBLIyI/Gm@shell.armlinux.org.uk>
References: <20240906103511.28416-1-Raju.Lakkaraju@microchip.com>
 <20240906103511.28416-5-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906103511.28416-5-Raju.Lakkaraju@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

A couple of niggles. I know that the patches have already been merged
while I wasn't able to review, but maybe you can address these points.

On Fri, Sep 06, 2024 at 04:05:10PM +0530, Raju Lakkaraju wrote:
> +static void lan743x_phylink_mac_link_up(struct phylink_config *config,
> +					struct phy_device *phydev,
> +					unsigned int link_an_mode,
> +					phy_interface_t interface,
> +					int speed, int duplex,
> +					bool tx_pause, bool rx_pause)
> +{
> +	struct net_device *netdev = to_net_dev(config->dev);
> +	struct lan743x_adapter *adapter = netdev_priv(netdev);
> +	int mac_cr;
> +	u8 cap;
> +
> +	mac_cr = lan743x_csr_read(adapter, MAC_CR);
> +	/* Pre-initialize register bits.
> +	 * Resulting value corresponds to SPEED_10
> +	 */
> +	mac_cr &= ~(MAC_CR_CFG_H_ | MAC_CR_CFG_L_);
> +	if (speed == SPEED_2500)
> +		mac_cr |= MAC_CR_CFG_H_ | MAC_CR_CFG_L_;
> +	else if (speed == SPEED_1000)
> +		mac_cr |= MAC_CR_CFG_H_;
> +	else if (speed == SPEED_100)
> +		mac_cr |= MAC_CR_CFG_L_;
> +
> +	lan743x_csr_write(adapter, MAC_CR, mac_cr);
> +
> +	lan743x_ptp_update_latency(adapter, speed);
> +
> +	/* Flow Control operation */
> +	cap = 0;
> +	if (tx_pause)
> +		cap |= FLOW_CTRL_TX;
> +	if (rx_pause)
> +		cap |= FLOW_CTRL_RX;
> +
> +	lan743x_mac_flow_ctrl_set_enables(adapter,
> +					  cap & FLOW_CTRL_TX,
> +					  cap & FLOW_CTRL_RX);

I'm wondeing about this, which looks to me to be over-complex code.

void lan743x_mac_flow_ctrl_set_enables(struct lan743x_adapter *adapter,
                                       bool tx_enable, bool rx_enable)

This function takes two booleans. You're passing cap & FLOW_CTRL_TX
and cap & FLOW_CTRL_RX to this function for these. However, you are
setting these bits in "cap" immediately above from a pair of booleans
and nowhere else. So why not:

	lan743x_mac_flow_ctrl_set_enables(adapter, tx_pause, rx_pause);

?

> @@ -3115,13 +3217,13 @@ static int lan743x_netdev_open(struct net_device *netdev)
>  	if (ret)
>  		goto close_intr;
>  
> -	ret = lan743x_phy_open(adapter);
> +	ret = lan743x_phylink_connect(adapter);
>  	if (ret)
>  		goto close_mac;
>  
>  	ret = lan743x_ptp_open(adapter);
>  	if (ret)
> -		goto close_phy;
> +		goto close_mac;
>  
>  	lan743x_rfe_open(adapter);
>  
> @@ -3161,9 +3263,8 @@ static int lan743x_netdev_open(struct net_device *netdev)
>  			lan743x_rx_close(&adapter->rx[index]);
>  	}
>  	lan743x_ptp_close(adapter);
> -
> -close_phy:
> -	lan743x_phy_close(adapter);
> +	if (adapter->phylink)
> +		lan743x_phylink_disconnect(adapter);

I'm not sure why this is conditional on adapter->phylink. Surely this
test will always be true?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

