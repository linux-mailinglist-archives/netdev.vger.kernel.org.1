Return-Path: <netdev+bounces-224992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24655B8C99F
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 15:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96FB1B241C0
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 13:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DFD1F5437;
	Sat, 20 Sep 2025 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="qtBesZHB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5D14C5B0
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758376399; cv=none; b=hU/DkHyzt6jWui2eFFrBqDsrAS2344qRBx/50zP0HyFJ0CgMzqftM+4Lmp9aJOqoAyTwLnlW5qlhhqesZVFp9MY0sGQtfb/WmHVHEhjzu+bh4Jz8+sxmTXf0NYYq6KlbgKSCT+E7of28dFVvK/ULI+Rx3q2fptwuDTCJ0kIQ2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758376399; c=relaxed/simple;
	bh=IQb0eCPdG86z1gnNvh+Sy3ldt/rjhl6tn3LlY7T6yT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFjVE9F3i+iwgm1kqHiH6h2vtkdyXdRw1B3xIhm0iJNiDql/9/Es+O3wdIeZ5NRF1lt16pYA70/uQ7q0FtaCo//YWyzg9A2nwFx/QRPeMS+dhJsIOms9BfZrGSU2KuhuDWGL4uRreLW+/FgOFb4uw6dzDk6uS8VuTuqWleE9j1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=qtBesZHB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=arY5XeOi24cwNMORuXgpgmuYDtDttdo/JJskh5liCCI=; b=qtBesZHBAUdtGjs303BkSzzRN9
	08rR66RNn4RLjGJlydb2fkWKyn/RLug/XqjWQA3jkv6pQIaIFexsJi/obOPVsl6uUWq6/7NQUoaoU
	9B4T08DY03D4tG4FnftSivy7BvOqktIgEoASYzjDrkNtjUdFk6QcivKagRHuw5A8yg2drwrDXWD0H
	nbROvhpKZRJPR/SRI0Yq4JxF/AVtBbsQXYHndY+IvYCjcMpNFh6bLA45miANy9BCrXbfbs0Z/UALr
	1uqriGEM19ToGAkSnnz8Sp7RDDeI2MN+wXQcHKEJCuQvNYlFYeqvpcK3PcDcpryTCnUpmNhHQTcf4
	GIByD0KA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36770)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uzy1W-000000000V0-0tnx;
	Sat, 20 Sep 2025 14:53:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uzy1T-000000003Ax-0wXd;
	Sat, 20 Sep 2025 14:53:07 +0100
Date: Sat, 20 Sep 2025 14:53:06 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC] increase MDIO i2c poll timeout gradually (including patch)
Message-ID: <aM6xwq6Ns_LGxl4o@shell.armlinux.org.uk>
References: <971aaa4c-ee1d-4ca1-ba38-d65db776d869@kabelmail.de>
 <cbc4a620-36d3-409b-a248-a2b4add0016a@lunn.ch>
 <f86737b0-a0fe-49a6-aeca-9e51fbdf0f0d@kabelmail.de>
 <aM6Ng7tnEYdWmI1F@shell.armlinux.org.uk>
 <6d444507-1c97-4904-8edb-e8cc1aa4399e@kabelmail.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d444507-1c97-4904-8edb-e8cc1aa4399e@kabelmail.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Sep 20, 2025 at 02:09:47PM +0200, Janpieter Sollie wrote:
> I tested a SFP module where the i2c bus is "unstable" at best.
> different i2c timeouts occured, resulting in a "phy not detected" error message.

If the I2C bus is so unstable that attempting to read a register from
the PHY, which should take no more than 70ms, takes in excess of 200ms
(which is what it takes for the loop to time out) for just one
register, it seems to me that you're chasing a dead horse.

However, looking at the rest of your message, I don't think you have
a problem with the I2C bus at all.

> I noticed a few hard-coded numbers in i2c_rollball_mii_pol(), which is always suspicious.

Sorry, but I don't follow the same reasoning. If they aren't hard-coded,
but are "knobs" in e.g. sysfs, then how do we teach people how to "tune"
them? When should they "tune" them? No, the less knobs there are, the
better for the user, provided timeouts are sensible - and I think
waiting 200ms for a register to be read is already an excessively long
timeout.

In any case, if we have a module that takes longer, that's new, and the
timeouts need to be adjusted - not on a per-module basis, and not by
users having to tinker with stuff in sysfs.

> In order to lower the stress on the i2c bus, I made the following patch.
> is it the best way to "not-stress-sensitive-devices"?
> Will it cause a performance regression on some other SFP cages?
> 
> Eric Woudstra told me another option was to add a few tries, increasing i = 10,
> If the issue isn't the device itself, but the stress on the i2c bus is too
> high, it may not be a real solution.

Why are you concerned about "stress" on the I2C bus? What kind of
stress? The bus is 5V or 3.3V signalling, running at 100kHz (so slow)
with resistive pull-ups. Apart from the bus transitions (which cause
CMOS to take a pulse of power) the energy from that will be nothing
compared to the energy required to run the CPU, which is operating
much faster with many more CMOS transistors switching.

> A good question may be: is this approach sufficient to close the gap between
> "high performance" equipment having a stable i2c bus and they do not want to wait,

None of this has been written for "high performance" equipment. It was
developed on a SolidRun clearfog platform (Armada 388 based) which is
hardly "high performance". It's been used with bit-banged I2C as well
on Macchiatobin platforms.

I'm guessing that the problem is not an I2C bus problem (which would
cause i2c_transfer_rollball() to return an error, and the loop to quit),
but yet another cheap and nasty SFP module that takes much longer
than 70ms to respond under the "Rollball" protocol.

So, what we need you to do is to work out how long it takes this module
to respond, and whether it always takes a long time to respond. Please
add some debugging to i2c_rollball_mii_poll() to measure the amount of
time it takes for the module to respond - and please measure it for
several transactions.

You can use jiffies, and convert to msecs using jiffies_to_msecs(),
or you could use ktime_get_ns().

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

