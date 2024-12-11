Return-Path: <netdev+bounces-151078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6BC9ECBC0
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 13:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE8D168266
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 12:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A12209660;
	Wed, 11 Dec 2024 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JaOmhEAE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AB01EC4E3
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733918835; cv=none; b=UT9MHQtL3j1iWajLqdRSIu+tW11qWWp4IDCp6DHgdDZmb7Jhzl9WbG45SJKCEULZo5YjiKMZuqdWkjXKeP3fTLLvU3x/eP8yLz1yDtqhKukRyK7hRCNBXFmGemamezypvp/ffhmH8/XI4o2YU/xs04Gq96HcWky4P+cbUHKO0Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733918835; c=relaxed/simple;
	bh=pVJaVmRt4SzlX3IrLA9MiKuupa8Y1Eh/WKc2QGlwmkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FF5W45OY7nKFyFTkG054w5PjvQC1ABXFtbjpp8o+YUuIVCIHrh5qgBmzjAiVzlv3WE3YAUlwRiuXnm+pwmlAOq2SH19+K98zZ+ZqwNcJoIOqqXrsBKhS98xGw42DOTF3q5FQsfbnVNg553Z56g19eYDXODDaY3CIgrqTXKid/b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JaOmhEAE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PZKND/MtgKHZw4p0hyCfhA/eiJnJOUSz44vVu0CttBQ=; b=JaOmhEAE5aKeMnUl3PFbBt1Pt3
	KvjdO0JB54KDi0P7HRxTuWNf1sZ3C3uQFqg21bNGCPYBZ8zl1nwfv7SLnQG1oCszYCV1b5dio4W6z
	fTQwAk/+EZwkeYgQY0nilOVXrjJ6Y9cYBboq/8uoJKWh3VuLerRDrLgPt+yECNAvBKvcLE3jVVU0Z
	0bmJRjcmoXPiiEVA6LxG2YfO1KOF5e+03dkPnFyONwu8iInaNQIZa/N9gk18Rm7C7J3yqAipewgX8
	98Qo7WmS0wxsLIgfXgeh639+VxGWqgUu4ABRd15083xm8EbGre7GHkZroRfdSbKTQqG1zWup7TWXK
	+DR99MRA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48886)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tLLUg-0003qu-0E;
	Wed, 11 Dec 2024 12:07:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tLLUe-0003v2-0a;
	Wed, 11 Dec 2024 12:07:04 +0000
Date: Wed, 11 Dec 2024 12:07:04 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 00/10] net: add phylink managed EEE support
Message-ID: <Z1mAaBCSGClMeHjp@shell.armlinux.org.uk>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 09, 2024 at 02:22:31PM +0000, Russell King (Oracle) wrote:
> Patch 5 adds phylink managed EEE support. Two new MAC APIs are added,
> to enable and disable LPI. The enable method is passed the LPI timer
> setting which it is expected to program into the hardware, and also a
> flag ehther the transmit clock should be stopped.
> 
>  *** There are open questions here. Eagle eyed reviewers will notice
>    pl->config->lpi_interfaces. There are MACs out there which only
>    support LPI signalling on a subset of their interface types. Phylib
>    doesn't understand this. I'm handling this at the moment by simply
>    not activating LPI at the MAC, but that leads to ethtool --show-eee
>    suggesting that EEE is active when it isn't.
>  *** Should we pass the phy_interface_t to these functions?
>  *** Should mac_enable_tx_lpi() be allowed to fail if the MAC doesn't
>    support the interface mode?
> 
> The above questions remain unanswered from the RFC posting of this
> series.

Given the open questions that still remain and the lack of engagement,
I don't think we're at the point of being able to apply this patch set
(I don't want to rework the method functions in lots of drivers.) So,
I suggest we put this on the back burner until there's a clear way
forward.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

