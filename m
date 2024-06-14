Return-Path: <netdev+bounces-103697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C26269091F3
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 19:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D223C1C235D2
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 17:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5CE482DB;
	Fri, 14 Jun 2024 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RyFScOOv"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2065519D89C;
	Fri, 14 Jun 2024 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718387203; cv=none; b=N7uOnnq6SBOYRvbaKkXxblMlO0A1csuA2xA82qlMfMlM7G8Zb9MWvYsqAU44aYrpMbMh1jM1JJVWaSo5DSevl5j/sgx2NPe9iKql9WcQZwupRjuFTVeqy2WGV8A5Gw9HnHcrGhBiM2ffSUd/pumavvGxtrS2gT0OHNR9CaWsctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718387203; c=relaxed/simple;
	bh=FUhw5QSPT52a+n51aUGW5MWySfTN62An4zO5LFmLXlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmNLvPD69xIC7OUX4yqWTShiFnQuTT32QrmcKiUUyiwAnjyyYO/T7WwFnHZEy+2SizAc6CYKnpPSliMlnnw7hKU6cUmqWqLHHGnWsQjwBwniiAc1wnqSqt1ILwbKFoSY/5Z0Nhiwg/XC6WDoIAue2pRKIxfZE9lyu6NmG8IIMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RyFScOOv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VLp0XKh59OcMtWOpegZjhoT2Uyd2kf1eZygBpGw1rsc=; b=RyFScOOv02S+cmpl/z+zry8jWZ
	4Ql+RZ9Ko1bSpLGTcwpEN7SHVwBt3hfQp5iAPTG88/4v6NGFkMHHVmI69NYq6tDmIlb+5W08BsY/q
	XrhqmI6yU6sapMPi4VwjK9ViJDsz7BeG+/vSo/acrDoAb2MeqJObWoT4PMD0j82D/M/VFi0s4chHR
	DURdpOET2UoxjeoYxfgMp9gCNWoPxARX9i4TxvfPw9i75IOVWSnPgw6TElfepHCPCQZ11xVkvjhWR
	UYVXOeOKjb+rngRSVfsZzjwzWtpgGnwJZaYlMAMGNlksAy4DDi+JbLmcN8mRTx9uAJ1ko/qBek0bX
	NyW8uHrg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59072)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sIB0C-000280-0u;
	Fri, 14 Jun 2024 18:46:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sIB09-0002Jc-8R; Fri, 14 Jun 2024 18:46:13 +0100
Date: Fri, 14 Jun 2024 18:46:13 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net-next v15 07/14] net: Add struct kernel_ethtool_ts_info
Message-ID: <ZmyB5cUz6zWcw4nr@shell.armlinux.org.uk>
References: <20240612-feature_ptp_netnext-v15-0-b2a086257b63@bootlin.com>
 <20240612-feature_ptp_netnext-v15-7-b2a086257b63@bootlin.com>
 <19d5b8f250979c7c244e7b5b08d12783667576ee.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19d5b8f250979c7c244e7b5b08d12783667576ee.camel@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jun 14, 2024 at 04:02:04PM +0200, Paolo Abeni wrote:
> On Wed, 2024-06-12 at 17:04 +0200, Kory Maincent wrote:
> > In prevision to add new UAPI for hwtstamp we will be limited to the struct
> > ethtool_ts_info that is currently passed in fixed binary format through the
> > ETHTOOL_GET_TS_INFO ethtool ioctl. It would be good if new kernel code
> > already started operating on an extensible kernel variant of that
> > structure, similar in concept to struct kernel_hwtstamp_config vs struct
> > hwtstamp_config.
> > 
> > Since struct ethtool_ts_info is in include/uapi/linux/ethtool.h, here
> > we introduce the kernel-only structure in include/linux/ethtool.h.
> > The manual copy is then made in the function called by ETHTOOL_GET_TS_INFO.
> > 
> > Acked-by: Shannon Nelson <shannon.nelson@amd.com>
> > Acked-by: Alexandra Winter <wintera@linux.ibm.com>
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> I think it would be nice if a few more vendors could actually step-in
> and test/ack the driver specific bits.

Well, in part this series was triggered because of an issue having
PTP support in Marvell's PP2 driver, and then the issue that if we
add it to the Marvell PHY driver, the platforms that are currently
using the PP2 based PTP support were forced into the weird situation
that some of the PTP calls hit the PP2 driver and others hit the
PHY driver.

I had sent Kory an email a couple of weeks ago saying that I'm
unlikely to be able to test this out in that setup any time soon,
I've had high work pressure for the last seven-ish weeks, and I
would need to be in front of the hardware, which is fairly rare
at the moment, and I'm not going to be in front of the hardware
until August. So I'm just not going to be able to test it in a
reasonable time scale.

There's not a lot I can do about that, sorry.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

