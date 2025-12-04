Return-Path: <netdev+bounces-243550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD9CCA3688
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 12:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16EE6301767E
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 11:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B93E2DC359;
	Thu,  4 Dec 2025 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="niif8Ri3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C8D29D268;
	Thu,  4 Dec 2025 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764847162; cv=none; b=HzgOGgZhKKjV9ztgA7VfEuCsGzhwc155wF50yO3upuFtA3SmvDfrkouQtkov35EdlOKzIBjeSUOknxcuWAJWJPjHkwxAXVJN3wXhG2Q0WljGtG3FHYBaTsPXsghx20GPPGoQXpAnp1w/ziyq3n1pUuGmULCji1hWjFNYIebab6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764847162; c=relaxed/simple;
	bh=U75He73sbdIlwlBnU4OhW9ZqZDbObFsYFNGFGm37Vyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhA0O3gVZ7d/Umrsl/V8GGlep4ypbsEQYmPVgv5hmcKqpzUKXCiewbqCUUkPRMlWRCCFntzQMg0kV9T4JyXxpf+ZSpfVZO+D06AyLWAfHSszCJuYvoTGuKBsZvviDUa/2hv5Z9fpbInC3XU425jPX36iwqStV9Z6vvihDYHHMV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=niif8Ri3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k3+IvcN5Cb0nJ6VY6yDksNa4bwyh6/su6R64NgY1qyg=; b=niif8Ri3Pr6EIrYqqNhb3vmNvQ
	uOhFIpjmURLVVntX8gXkZYAcVnw4wwsFiHVnoGRbXtjLF55vzyiZVBC9YKVq88t+bg+/VC/LJog0+
	YNFUP/WoCBH28h5O4qjhgx8r2eYtnY6+w/EMWRz400ttTS5TXBdXrWTT3+Hixf6mpLunEWCZSWH47
	9nmzvATT2UfIb/JiZUlteOrMSeO8PV4uQGVsFXJA0za0BGOybVbaTVFyAtv1auWpYVs889xt3OKJc
	MMFH2wROwaUTpOr/vt6Pbjppxbrh2MrTgqFg6GIGDJYy0YAACEDPtBbSx1h4u0swldFg9UxItkKBO
	vGv85reg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40064)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vR7MY-000000003Sm-2E0E;
	Thu, 04 Dec 2025 11:19:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vR7MT-000000000yA-3MBl;
	Thu, 04 Dec 2025 11:19:01 +0000
Date: Thu, 4 Dec 2025 11:19:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Rohan G Thomas <rohan.g.thomas@altera.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Fugang Duan <fugang.duan@nxp.com>,
	Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: Fix E2E delay mechanism
Message-ID: <aTFuJUiLMnHrnpW5@shell.armlinux.org.uk>
References: <20251129-ext-ptp-2v-v2-1-d23aca3e694f@altera.com>
 <26656845-d9d6-4fd2-bfff-99996cf03741@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26656845-d9d6-4fd2-bfff-99996cf03741@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Dec 04, 2025 at 10:58:40AM +0100, Paolo Abeni wrote:
> On 11/29/25 4:07 AM, Rohan G Thomas wrote:
> > For E2E delay mechanism, "received DELAY_REQ without timestamp" error
> > messages show up for dwmac v3.70+ and dwxgmac IPs.
> > 
> > This issue affects socfpga platforms, Agilex7 (dwmac 3.70) and
> > Agilex5 (dwxgmac). According to the databook, to enable timestamping
> > for all events, the SNAPTYPSEL bits in the MAC_Timestamp_Control
> > register must be set to 2'b01, and the TSEVNTENA bit must be cleared
> > to 0'b0.
> > 
> > Commit 3cb958027cb8 ("net: stmmac: Fix E2E delay mechanism") already
> > addresses this problem for all dwmacs above version v4.10. However,
> > same holds true for v3.70 and above, as well as for dwxgmac. Updates
> > the check accordingly.
> > 
> > Fixes: 14f347334bf2 ("net: stmmac: Correctly take timestamp for PTPv2")
> > Fixes: f2fb6b6275eb ("net: stmmac: enable timestamp snapshot for required PTP packets in dwmac v5.10a")
> > Fixes: 3cb958027cb8 ("net: stmmac: Fix E2E delay mechanism")
> > Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> > ---
> > v1 -> v2:
> >    - Rebased patch to net tree
> >    - Replace core_type with has_xgmac
> >    - Nit changes in the commit message
> >    - Link: https://lore.kernel.org/all/20251125-ext-ptp-fix-v1-1-83f9f069cb36@altera.com/
> 
> Given there is some uncertain WRT the exact oldest version to be used,
> it would be great to have some 3rd party testing/feedback on this. Let's
> wait a little more.

As I said, in the v3.74 documentation, it is stated that the SNAPTYPSEL
functions changed between v3.50 and v3.60, so I think it would be better
to propose a patch to test for < v3.6.

Alternatively, if someone has the pre-v3.6 databook to check what the
SNAPTYPSEL definition is and compare it with the v3.6+ definition, that
would also be a good thing to do.

From the 3.74:

SNAPTYPSEL
00		?
01		?
10		Sync, Delay_Req
11		Sync, PDelay_Req, PDelay_Resp

TSEVNTENA
0		All messages except Announce, Management and Signalling
1		Sync, Delay_Req, PDelay_Req, PDelay_Resp

No table is provided, so it's difficult to know what all the bit
combinations do for v3.74.

From STM32MP151 documentation (v4.2 according to GMAC4_VERSION
register):

SNAPTYPSEL	TSMSTRENA	TSEVNTENA
00		x		0		Sync, Delay_Req
00		0		1		Delay_Req
00		1		1		Sync
01		x		0		Sync, PDelay_Req, PDelay_Resp
01		0		1		Sync, Delay_Req, PDelay_Req,
						PDelay_Resp
01		1		1		Sync, PDelay_Req, PDelay_Resp
10		x		x		Sync, Delay_Req
11		x		x		Sync, PDelay_Req, PDelay_Resp

For iMX8MP (v5.1) and STM32MP23/25xx (v5.3) documentatiion:

SNAPTYPSEL	TSMSTRENA	TSEVNTENA
00		x		0		Sync, Follow_Up, Delay_Req,
						Delay_Resp
00		0		1		Sync
00		1		1		Delay_Req
01		x		0		Sync, Follow_Up, Delay_Req,
						Delay_Resp, PDelay_Req,
						PDelay_Resp
01		0		1		Sync, PDelay_Req, PDelay_Resp
01		1		1		Delay_Req, PDelay_Req,
						PDelay_Resp
10		x		x		Sync, Delay_Req
11		x		x		PDelay_Req, PDelay_Resp

Differences:
00 x 0 - adds Follow_Up
00 X 1 - TSMSTRENA bit inverted
01 x 0 - adds Follow_Up, Delay_Req, Delay_Resp
01 0 1 - removes Delay_Req
01 1 1 - removes Sync, adds Delay_Req
11 x x - removes Sync

So, it looks like there's another difference between v4.2 and v5.1.

If the STM32MP151 (v4.2) documentation is correct, then from what I see
in the driver, if HWTSTAMP_FILTER_PTP_V1_L4_SYNC is requested, we set
SNAPTYPSEL=00 TSMSTRENA=0 TSEVNTENA=1, which semects Delay_Req messages
only, but on iMX8MP this selects Sync messages.

HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ is the opposite (due to the
inversion of TSMSTRENA) for SNAPTYPSEL=00.

For HWTSTAMP_FILTER_PTP_V2_EVENT, we currently set SNAPTYPSEL=01
TSMSTRENA=0 and TSEVNTENA=1 for cores < v4.1:
- For STM32MP151 (v4.2) we get Sync, PDelay_Req, PDelay_Resp but
  _not_ Delay_Req. Seems broken.
- For iMX8MP (v5.1) and STM32MP23/25xx (v5.3), we get
  Sync, Follow_Up, Delay_Req, Delay_Resp, PDelay_Req, PDelay_Resp

Basically, the conclusion I am coming to is that Synopsys's idea
of "lets tell the hardware what _kind_ of PTP clock we want to be,
whether we're master, etc" is subject to multiple revisions in
terms of which messages each mode selects, and it would have been
_far_ simpler and easier to understand had they just provided a
16-bit bitfield of message types to accept.

So, I'm wary about this change - I think there's more "mess"
here than just that single version check in
HWTSTAMP_FILTER_PTP_V2_EVENT, I think it's a lot more complicated.
I'm not sure what the best solution is right now, because I don't
have the full information, but it looks to me like the current
approach does not result in the expected configuration for each
of the dwmac core versions, and there are multiple issues here.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

