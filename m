Return-Path: <netdev+bounces-54400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9FD806F84
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 13:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20CC281964
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 12:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0542535F09;
	Wed,  6 Dec 2023 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cskeBUUo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FF59A
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 04:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9x2SLU29rQEMfu8pqDWi89Hi3pvx5ygfkmNfxxCTGg0=; b=cskeBUUoqkuP8iJs14gCsCSz6C
	9O3P6wq73rqdCmWegiDX3/6rIYrtFWTpRGKx2Vm1cuRXLqKZkWtXaApeaLwVuqOPQ9twt7sJTtiY5
	ds9mn/SwpMV79J9kOZWAoAveAg3A1E0048fVHehMMhAGhCejJZmjGG010kTX0XTPNt9NenExBYWcl
	NcQOl4fqI8OIEM1Vll1k1eWpJsXtQmkEH1SvIp0oRdxRQqShiAF2yIWHiKEEsNfa87y8asy2zSuma
	YjIQ2fhhHce7wVC7XpaDBpab7VrHUU3nWACScaBkVWY8xuonydf6D4tN/mHyQJOE77eAdNL8UOH7p
	bS2lvDFQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52288)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rAqoZ-0008Ed-0m;
	Wed, 06 Dec 2023 12:15:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rAqob-0002iN-C6; Wed, 06 Dec 2023 12:15:45 +0000
Date: Wed, 6 Dec 2023 12:15:45 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew@lunn.ch, netdev@vger.kernel.org,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 2/7] net: wangxun: unified phylink
 implementation in libwx
Message-ID: <ZXBl8VCncGJSpkad@shell.armlinux.org.uk>
References: <20231206095355.1220086-1-jiawenwu@trustnetic.com>
 <20231206095355.1220086-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206095355.1220086-3-jiawenwu@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 06, 2023 at 05:53:50PM +0800, Jiawen Wu wrote:
> Use wx->phylink instead of txgbe->phylink, and move the same ethtool
> functions to libwx because them can be implemented with phylink in
> ngbe driver.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

I would probably do the first two patches of your series differently:

Patch 1: add struct phylink + phylink_config to the wx structure, and
  add the helper functions for ksettings and nway reset.

Patch 2: convert txgbe to use the bits added in patch 1.

Patch 3: convert ngbe to phylink using the wx bits added in the first
  patch as a pure phylink conversion.

Patch 4: change how the PHY is attached/detached (as mentioned in the
  review of your existing first patch.)

which probably would have been easier to review.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

