Return-Path: <netdev+bounces-136568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A399A21B0
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 14:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69671288C7E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91061DBB31;
	Thu, 17 Oct 2024 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="okWrHSBC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3491DC07D
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166410; cv=none; b=aJHMt8QNdzcseCk6bVja1xNHVyzMLEDkI9EKbtp69F/0ClXDYz9bB+DXA+n411ptPPPAZ8mFpOqA5b9PGTAkrmOhtZD3geJ+S+cf6kUANLjL/OpMwAYykOM46GFYAwdQ+28XajAs1vK/kPN7RNTj3wDo/QNDF8gVPhyOUvgHslo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166410; c=relaxed/simple;
	bh=9jSppMsc1gxJrlPdeVzLA7vJLPqKWj0TOOzA0Z9FyYc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A6B5vzNm/I3kCmmfvBEbx/YCXOV+fk8vtff0fnCUu+w5wMi44NT2eexhYyFktDdEZoFQpUiE9LXZW5z/MMWT74dsviVXPLBbIloY8aCBch9rqAmK+NcOTs7FC4Nczc8xlI/bUvXQSdeMCAl422L+o7TIms+d5OM9VlEmzHF01aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=okWrHSBC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4duQscGOGvrU8W49nKqvw1qF0zI8jUQNj0rwZnnVGAQ=; b=okWrHSBC5bCau/vcAKAx6jfY+b
	hes6e9Zj3KHHWweR5WJSI2DC0866Gkig8o7/ytXN2plRJasmeJ/06mphh3tZ5B6ejGwkcuoDtMsmt
	O5UoPZdHjqvtid7mcHFa+8NdWIf2QF7rYxXBn1uUIZbcM5rettVgVJ5hoqLTzR22c+eihYDYaFl20
	AG1nw9bBWTxvUoJqYwvqFbKPYIWMaKAnDIbxP8IoDAlUjEE2euzzeylXV9LNwYv8dol7Vl8CvRh+K
	UJzyFuecc9/9XSKhy81YQr9fUY3ZlmWRiKjjbUufw5nyhXiiTclwSTqO6P9CKN40U3hTccShrHWjW
	ehHiQgBw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40554)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t1P3F-0006UI-0H;
	Thu, 17 Oct 2024 12:52:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t1P3C-0006Ds-0M;
	Thu, 17 Oct 2024 12:52:18 +0100
Date: Thu, 17 Oct 2024 12:52:17 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/7] net: pcs: xpcs: yet more cleanups
Message-ID: <ZxD6cVFajwBlC9eN@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

I've found yet more potential for cleanups in the XPCS driver.

The first patch switches to using generic register definitions.

Next, there's an overly complex bit of code in xpcs_link_up_1000basex()
which can be simplified down to a simple if() statement.

Then, rearrange xpcs_link_up_1000basex() to separate out the warnings
from the functional bit.

Next, realising that the functional bit is just the helper function we
already have and are using in the SGMII version of this function,
switch over to that.

We can now see that xpcs_link_up_1000basex() and xpcs_link_up_sgmii()
are basically functionally identical except for the warnings, so merge
the two functions.

Next, xpcs_config_usxgmii() seems misnamed, so rename it to follow the
established pattern.

Lastly, "return foo();" where foo is a void function and the function
being returned from is also void is a weird programming pattern.
Replace this with something more conventional.

With these changes, we see yet another reduction in the amount of
code in this driver.

 drivers/net/pcs/pcs-xpcs.c | 134 ++++++++++++++++++++++-----------------------
 drivers/net/pcs/pcs-xpcs.h |  12 ----
 2 files changed, 65 insertions(+), 81 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

