Return-Path: <netdev+bounces-175489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2169CA6615C
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 23:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD501789E3
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 22:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90206204C0D;
	Mon, 17 Mar 2025 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PyoUI7IL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEC5202C40
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742249620; cv=none; b=ekwlHWwT5MrKlSDGhrIdRf+HxERf4oEOew5MOq3i5Rf7A8qUbIwt/b8BHDlzRqC5Qs90RhQoPv2nQXWbn7hells9dDFIq3jIM532MbLYzfubBbksvCbaKGCl82YZj3hQ1d+mOeqSw3IXC740wjZDuISK1qg6j+9Jz9X4GIflur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742249620; c=relaxed/simple;
	bh=Uh+nmDKbhG1xHYkMpyQDFKNEf98tHwNKGwhikylTkfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCVDfD/zWfjfrbkbkIcjy2CntBPeCaCc3pdQfIHCHiWUV0bXTJh5Sor+FrRvWfaiRblO4QO7XZbZT4b4u4dSMpZkbcV+UkVwHXx3tgYGf20c9o1J9XWIDoLJQiXanUG86IuDawGJGfpFmDN43CeDChO6/uPk0U63MYPcRJZSOes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PyoUI7IL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h795jI0CAMNF+C3Dm1ua7LbpU0qTKbX2Kx6UIxSQgOw=; b=PyoUI7IL9ylAbP+IBiX8U69TtL
	gJfAsdlQij9iQrOW40euE3H3kiRsDRvGrh6Hbcwu3p9+ZGNEXysQnssr61Vr6zvdCxZxExskMsqVN
	UfYwUTuxEkfQoi8kLldHEOBIC9vQWyIDY4W9LGQ8x7b2LcRTbu6Jmu/jacG7PtIFN7pEsu1X21r6e
	Ar/w/2AG1MNuubqgIkGnE+RSgd6PYQkd/SbYZdV13r+I8fdMJTk28sKY7PZJHvO/lxlYvEDgl85Ex
	aMyHlwXrChdwGivljcZR9tJNIvVR7bW2dVEdF5aVJhSoch+QC2mBSGc6xXwuH9dmPkPIO97j5u2n6
	J3tZPuGg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58524)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tuIiC-0004B1-1f;
	Mon, 17 Mar 2025 22:13:32 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tuIi9-0003vo-2y;
	Mon, 17 Mar 2025 22:13:29 +0000
Date: Mon, 17 Mar 2025 22:13:29 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: phy: realtek: disable PHY-mode EEE
Message-ID: <Z9ieiYHUSnBbppe4@shell.armlinux.org.uk>
References: <E1ttnHW-00785s-Uq@rmk-PC.armlinux.org.uk>
 <303bfbde-db51-4826-b36e-030114b2630c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <303bfbde-db51-4826-b36e-030114b2630c@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 17, 2025 at 10:40:38PM +0100, Andrew Lunn wrote:
> On Sun, Mar 16, 2025 at 12:39:54PM +0000, Russell King (Oracle) wrote:
> > Realtek RTL8211F has a "PHY-mode" EEE support which interferes with an
> > IEEE 802.3 compliant implementation. This mode defaults to enabled, and
> > results in the MAC receive path not seeing the link transition to LPI
> > state.
> > 
> > Fix this by disabling PHY-mode EEE.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> > This patch isn't the best approach...
> 
> But i guess a better approach requires we have support for PHY-mode
> EEE? Which at the moment we do not have.

I'm not sure what this "PHY-mode" is - the datasheet for the PHY doesn't
mention the mode in its functional description, it only exists as a
simple description in the register documentation!

What I do know is that with this bit set, a MAC behind it never sees
the LPI signalled from the remote end, but 'scope shows that the
physical link has quietened down except for what I'd call the chirps
to keep both ends synchronised.

With the bit clear, then everything works as expected - as tested with
the stmmac driver on a Tegra platform. The stmmac MAC sees LPI on its
receive side, and all the nice juicy stmmac bugs requiring RXC to be
running can then be reproduced. :)

Not sure whether it would be better to fix stmmac first before this
is merged, but in order to develop and test, it needs to be fixed
first so the bug(s) can be reproduced. Given the netdev backlog, it
is unlikely that I'll get the stmmac patches out before the merge
window opens and net-next closes - so the "regression" that nvidia
reported is not going to get fixed in this cycle.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

