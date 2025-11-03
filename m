Return-Path: <netdev+bounces-235005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A260FC2B21B
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 11:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 512634E4869
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 10:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828F521CC55;
	Mon,  3 Nov 2025 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZD7a9bk8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667F91DE3A4
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166868; cv=none; b=UZpkfUYrFQmm+0VHkXwYk64GOXg/ECtBPFFvDFmnfNrrLLY/tKA78Jv8z/DTZlJLVVMwcIYZ91M22USNgr10mUOEW3GVZRIEnNTKj0zesjhJKHiTnA9BIUcam0DRWo+vEa279XDav110T73MV/4iBGxGFh71Ts0nRUzxuj5LnLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166868; c=relaxed/simple;
	bh=Khk5Yf6QTG63w7rLe9vD8Yv9u7p8ZjUq/GiQigyCUCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmWdrn141Ogtgyx07tDo9zWExuwV9F8DJgXkNpHVT7vB5YtT6LsBiyB13nNwh0CWWudSFY1ieKn7lZhcya+o4KOZP32keSbh7fXuJ7391nXiQAIDlh8ZlmOsm6afYQcW334M/VF/marFF5mWsjmfvN2ySrqxviLF7DNRfd8vex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZD7a9bk8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SfoQUh36QE7h8qt3hF9rnB1Y0l49JXwFNS9QZ6PhD74=; b=ZD7a9bk8YePsQT1gCLHkpemXYH
	jhhr//2fwcanBJEPfFnIzR9Kj5qNOUYwkH/a2hZUUeo9NW1VBzJeZBdCOSQJg1LuxKtAWVpqNl7wU
	aUrLae87cb5hpCzJf7bIRkrKc+vIbuclKrSXn0N4OdXXbNGTDAeg7RjZTptf4kBAyfmHpK22Dwuf6
	SaplTqH3s6g/mBJxCDzqVf5asyAAGEH4ta90oPgzCzczsoOCtn0G9WlKvLC+3cA52CrK9c2KBR9hE
	JNMLsgrK3LBJKihiVC0FBn8OlXBiB36aFp/3i4YCquBgToxfch366UNf5WzynDG+TPyOCB7NTnYvU
	ixOPMqZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42202)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vFs5z-000000000a9-1PlG;
	Mon, 03 Nov 2025 10:47:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vFs5v-000000003jm-0uly;
	Mon, 03 Nov 2025 10:47:27 +0000
Date: Mon, 3 Nov 2025 10:47:27 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Furong Xu <0x1207@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: Re: [PATCH net-next 0/3] net: stmmac: phylink PCS conversion part 3
 (dodgy stuff)
Message-ID: <aQiIP0_sQmdwrzu2@shell.armlinux.org.uk>
References: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
 <aQExx0zXT5SvFxAk@oss.qualcomm.com>
 <aQHc6SowbWsIA1A5@shell.armlinux.org.uk>
 <aQNmM5+cptKllTS8@oss.qualcomm.com>
 <aQOB_yCzCmAVM34V@shell.armlinux.org.uk>
 <aQOCpG_gjJlnm0A1@shell.armlinux.org.uk>
 <aQhusPX0Hw9ZuLNR@oss.qualcomm.com>
 <aQh7Zj10C7QcDoqn@shell.armlinux.org.uk>
 <aQiBjYNtJks2/mrw@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQiBjYNtJks2/mrw@oss.qualcomm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Nov 03, 2025 at 03:48:53PM +0530, Mohd Ayaan Anwar wrote:
> My rate-matching patch was for IQ8 which has the QCA808X PHY. I am
> putting its testing on hold until we sort everything out on QCS9100
> first.
> 
> So, for AQR115C, what should be the way forward? It has support for rate
> matching. For 10M should I remove its .get_rate_matching callback?

Yes, AQR115C has support for rate matching, but it depends how the
firmware is configured. Different firmwares for this PHY default to
different settings for this.

Some operate at a fixed speed on the host interface and do rate
matching. Others don't. The registers in the PHY can be reprogrammed
to change this behaviour and the PHY reset to change the provisioned
firmware's behaviour, but mainline doesn't have that code.

If you enable debugging in drivers/net/phy/aquantia/aquantia_main.c,
then aqr_gen2_read_global_syscfg() will print its configuration for
each speed via:

	"Media speed %d uses host interface %s with %s\n"

messages. Unfortunately, aqr_gen2_get_rate_matching() does not take
account of this configuration, and just assumes they're all the
same (reporting rate adaption for 2500BASE-X and 10GBASE-R interfaces.)

One thing occurs to me is maybe your PHY firmware is provisioned for
rate adaption with the 2500BASE-X interface for 1G and 100M speeds,
but for 10M, it's using SGMII. The above messages will tell us.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

