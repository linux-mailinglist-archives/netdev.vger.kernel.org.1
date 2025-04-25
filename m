Return-Path: <netdev+bounces-185886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F98AA9BFE1
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F604A7EE2
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 07:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3625222F147;
	Fri, 25 Apr 2025 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Q/JwLOu4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FD922F14C
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566721; cv=none; b=PQ59FKoc3FADGMuHlbrWF6wyK51oQqtXqivBCn7wsTUTmaLcAAzHIYZCur9+IOA+aqZB4pq+kOMiUxDqn/qlGeKjzz/fUejt4D++H4IXX6QJcPmJDz0BU4MyZoiwoQq5ebYmA0ekqm61p6hBo/ZXVct1+cxhSuhNFcBVzetRhc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566721; c=relaxed/simple;
	bh=yA0sJhCwU1Fo3Rydf9UbrESbZdQixsOIUV4z9O2yYnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8YOWSn0x3IO6H3a31zVg6WoeujgeGoNOzgaBs1oPuKD5fM5sFPoULhJjrFycbmm1+5UluQRz97JqmOe6mgn3RCKHO15y+/1U0F+mhlsE2wDi0PYwLTn3wIOkEWWTYzu95zV48qCKBCDrK9D0Pw4tx7cerx+wo7P0oM//syBS6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Q/JwLOu4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=96HrW++5XZF+Xjd00m6CIyxaVsJKpJPNoWDLaZ5v6Js=; b=Q/JwLOu4OLcaWwuyXaJkQ/li/I
	Gp6Zhbtv3q5FZ0iqPlokbRpHcTBAMKR1bREbJtb60cQ1VrOs0HgkfIUatsB0VyF3dolkFTxU+tImT
	fFhZVJlykV9hJGjtz7vo4qT8uwf4nd6Gx0gy93bNSQmfNgTyJGPc5/hznBlCfO3B8GBvQEN2veb8R
	eEUWy/SmzihPhKogWBIurCGxRqhONIB+xp0t7cG4tPBbWLzRmg4CqL5/mzD7KLxXjjLTOTv0tWvAe
	408pakIFSp3oXzuvgIxF0cqRsDtPqepdFqtzQtuL1sz3hEAdR32PPPDIm8PW5fB/GVya6b5a5kbUw
	ANc/rjVA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33358)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u8Ddo-0008Q7-32;
	Fri, 25 Apr 2025 08:38:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u8Ddl-0001wu-2W;
	Fri, 25 Apr 2025 08:38:29 +0100
Date: Fri, 25 Apr 2025 08:38:29 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net] net: libwx: fix to set pause param
Message-ID: <aAs79UDnd0sAyVAp@shell.armlinux.org.uk>
References: <6A2C0EF528DE9E00+20250425070942.4505-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6A2C0EF528DE9E00+20250425070942.4505-1-jiawenwu@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 25, 2025 at 03:09:42PM +0800, Jiawen Wu wrote:
> @@ -266,11 +266,20 @@ int wx_set_pauseparam(struct net_device *netdev,
>  		      struct ethtool_pauseparam *pause)
>  {
>  	struct wx *wx = netdev_priv(netdev);
> +	int err;
>  
>  	if (wx->mac.type == wx_mac_aml)
>  		return -EOPNOTSUPP;
>  
> -	return phylink_ethtool_set_pauseparam(wx->phylink, pause);
> +	err = phylink_ethtool_set_pauseparam(wx->phylink, pause);
> +	if (err)
> +		return err;
> +
> +	if (wx->fc.rx_pause != pause->rx_pause ||
> +	    wx->fc.tx_pause != pause->tx_pause)
> +		return wx_fc_enable(wx, pause->tx_pause, pause->rx_pause);

Why? phylink_ethtool_set_pauseparam() will cause mac_link_down() +
mac_link_up() to be called with the new parameters.

One of the points of phylink is to stop drivers implementing stuff
buggily - which is exactly what the above is.

->rx_pause and ->tx_pause do not set the pause enables unconditionally.
Please read the documentation in include/uapi/linux/ethtool.h which
states how these two flags are interpreted, specifically the last
paragraph of the struct's documentation.

I'm guessing your change comes from a misunderstanding how the
interface is supposed to work and you believe that phylink isn't
implementing it correctly.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

