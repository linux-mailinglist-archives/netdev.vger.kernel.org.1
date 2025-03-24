Return-Path: <netdev+bounces-177103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9108FA6DDC3
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2065B188AC72
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE7825FA2B;
	Mon, 24 Mar 2025 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="BiT/byg0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD85925EFA4;
	Mon, 24 Mar 2025 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828789; cv=none; b=LjtQ8kny+DkyQ7070DCLftF/HAsKyNCOXrntZjKiCYT1ZB82uTPbi2v/gRGDaAFPBk+ceMNVyCTv2cWQS0uuMmwplfXYt2RPUERBegDHCwt0lMTHPw89Liqg5W/eyUQUeNMybU6i2Xn0BaX73nukFqFw21asry9QnsAbViggO4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828789; c=relaxed/simple;
	bh=2UyfWKa1A2bwYrJ10f3fMq8znNoxlz7+Gf9TQZYX9No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pW2V6nk5g+FCViWEHSTfSPveIF3ptYIpUg6r/QorZ4jp4I2wRdLYxlE1moAtUUN+8WVEYOKojixaQ3ajLVcaoyoDJbDe4uvdpqcdJyid11dNomMfnyLRS4yBQdsBb924LrOT+u3sGt6e/B6vp7QJ1NGUTHQBDSk8ia93I/lihzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=BiT/byg0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oyNYGh8iDDAgrKD6zIW/UpG4qhZ5QDpo+/PKSwJbzqo=; b=BiT/byg04IMEiIji5AnLNVWDZ+
	O0JDn8GlapzNVFvbp0e0BvS/bHoU4YN/N9lqz820J6wW8mDqwKLkUAy4OnoHWdCVXCdHIvh909i+1
	qTMOGzcrHub8FBkP8uOevLrxwn6bLF2QrBCvQxJSTNX5eey0Ic81XYcEixEDHnxyRfu3czAQ4R7co
	qGCEr4CCdN6sgkzLNisrbJTfX+7h9TBmQizzKWphCfsWrowKXZGMxYWE5BVMdL4k9mTSBXh43U43d
	sw0tdTv+Xf10lQEf32MTqTkaKnhPHmaJLArdh9B0GkxJITO78pcbMhEJ5P0ssYJIXVYRj4+c96KMA
	xUQk5ouQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52790)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1twjNg-0003hd-11;
	Mon, 24 Mar 2025 15:06:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1twjNe-0002KN-1Q;
	Mon, 24 Mar 2025 15:06:22 +0000
Date: Mon, 24 Mar 2025 15:06:22 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net v3 1/2] net: =?utf-8?Q?phy?=
 =?utf-8?Q?=3A_Introduce_PHY=5FID=5FSIZE_?= =?utf-8?B?4oCU?= minimum size for
 PHY ID string
Message-ID: <Z-F07j7tlez_94aK@shell.armlinux.org.uk>
References: <20250324144751.1271761-1-andriy.shevchenko@linux.intel.com>
 <20250324144751.1271761-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324144751.1271761-2-andriy.shevchenko@linux.intel.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 24, 2025 at 04:39:29PM +0200, Andy Shevchenko wrote:
> The PHY_ID_FMT defines the format specifier "%s:%02x" to form
> the PHY ID string, where the maximum of the first part is defined
> in MII_BUS_ID_SIZE, including NUL terminator, and the second part
> is implied to be 3 as the maximum address is limited to 32, meaning
> that 2 hex digits is more than enough, plus ':' (colon) delimiter.
> However, some drivers, which are using PHY_ID_FMT, customise buffer
> size and do that incorrectly. Introduce a new constant PHY_ID_SIZE
> that makes the minimum required size explicit, so drivers are
> encouraged to use it.
> 
> Suggested-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

