Return-Path: <netdev+bounces-244126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76719CB0044
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 14:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FD0A30194FF
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 13:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4BD330B29;
	Tue,  9 Dec 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dg8D7Ezl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D26E330305;
	Tue,  9 Dec 2025 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765285293; cv=none; b=C9XlyvSF0JSQ6b/LmnlWJzLLEVuCN3BtFpoveUj7FBBBKUIK6KNJp9uFR/ZdYOmd7xWDdBg/4VCaleV35fdUHffg0RclmiprCDiTf1ZKfGVCTQ+h0KlM0TfA9DDbaXagjuKEktOOYcRNHNpcw3HyH+EG9/iHEp4mYVh15RkC7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765285293; c=relaxed/simple;
	bh=c1eM2Wsp4MhIdh7qrSTtweVLvneANpZKadzkbh/8vqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOJWGhEP6TTOdGFhLr4C+o/AivKTlo4xtLvjWpMTqeNTfOIJiQUXo8ESAiz3pGPmupeHrdTydvIvQF9wmmcuutOZWOEwxmnCGRp4otj184B3J+ewOxw+I+Kl8ofuLopVE29QYqBVot3ExYIEzox5pBZa4UgkmAmE18kd+/xlhdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dg8D7Ezl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sNF4oF6tZY/gCkRoXoRliKrYOLDoPNsc6ELPW7Fexlw=; b=dg8D7Ezl56lz7o0YcwxLF/Bmeg
	CcIFUL2XuKHcnirSqdiMQfi1VEwVG2fcRFuuqkmrYMPEWXKozdGNJEyuqGfym/Pd/wazbbPyv10eF
	y2yfSQoSrwLvqXfFmq9RtdW0SEXpqVvIhbPLY4Z4CZ8qfobhMqlqmPvS0qNUv0nJH2ffDb7P08fdp
	koL5meuoOnDJDT5KsosqJJAfDWZL/8erH347C8mGM5dQGFs/O0cdKDEme9Ymkh0PF1nnRGtK8kNww
	O2R5UXMy7B2vPWp6tqgYOtVs8j6LsMz/S99GkiPF9B+1nlwdBEZC4UOXW0fHIoiOUTXXFzyGTcVl7
	q+JeZ6yg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49898)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vSxLA-000000000UH-3V0J;
	Tue, 09 Dec 2025 13:01:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vSxL5-0000000061g-329i;
	Tue, 09 Dec 2025 13:01:11 +0000
Date: Tue, 9 Dec 2025 13:01:11 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
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
Message-ID: <aTgdlykiar3SlNox@shell.armlinux.org.uk>
References: <20251129-ext-ptp-2v-v2-1-d23aca3e694f@altera.com>
 <26656845-d9d6-4fd2-bfff-99996cf03741@redhat.com>
 <aTFuJUiLMnHrnpW5@shell.armlinux.org.uk>
 <9f0da5db-e92a-42e2-b788-2b07b8d28cfa@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f0da5db-e92a-42e2-b788-2b07b8d28cfa@altera.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 09, 2025 at 06:01:05PM +0530, G Thomas, Rohan wrote:
> Hi Russell,
> 
> Thanks for reviewing the patch.
> 
> On 12/4/2025 4:49 PM, Russell King (Oracle) wrote:
> > On Thu, Dec 04, 2025 at 10:58:40AM +0100, Paolo Abeni wrote:
> > > On 11/29/25 4:07 AM, Rohan G Thomas wrote:
> > > > For E2E delay mechanism, "received DELAY_REQ without timestamp" error
> > > > messages show up for dwmac v3.70+ and dwxgmac IPs.
> > > > 
> > > > This issue affects socfpga platforms, Agilex7 (dwmac 3.70) and
> > > > Agilex5 (dwxgmac). According to the databook, to enable timestamping
> > > > for all events, the SNAPTYPSEL bits in the MAC_Timestamp_Control
> > > > register must be set to 2'b01, and the TSEVNTENA bit must be cleared
> > > > to 0'b0.
> > > > 
> > > > Commit 3cb958027cb8 ("net: stmmac: Fix E2E delay mechanism") already
> > > > addresses this problem for all dwmacs above version v4.10. However,
> > > > same holds true for v3.70 and above, as well as for dwxgmac. Updates
> > > > the check accordingly.
> > > > 
> > > > Fixes: 14f347334bf2 ("net: stmmac: Correctly take timestamp for PTPv2")
> > > > Fixes: f2fb6b6275eb ("net: stmmac: enable timestamp snapshot for required PTP packets in dwmac v5.10a")
> > > > Fixes: 3cb958027cb8 ("net: stmmac: Fix E2E delay mechanism")
> > > > Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
> > > > ---
> > > > v1 -> v2:
> > > >     - Rebased patch to net tree
> > > >     - Replace core_type with has_xgmac
> > > >     - Nit changes in the commit message
> > > >     - Link: https://lore.kernel.org/all/20251125-ext-ptp-fix-v1-1-83f9f069cb36@altera.com/
> > > 
> > > Given there is some uncertain WRT the exact oldest version to be used,
> > > it would be great to have some 3rd party testing/feedback on this. Let's
> > > wait a little more.
> > 
> > As I said, in the v3.74 documentation, it is stated that the SNAPTYPSEL
> > functions changed between v3.50 and v3.60, so I think it would be better
> > to propose a patch to test for < v3.6.
> > 
> 
> I tested this on socfpga platforms like Agilex7 which are using
> 3.7x, but don't have any platforms with dwmac <= v3.6.
> 
> > Alternatively, if someone has the pre-v3.6 databook to check what the
> > SNAPTYPSEL definition is and compare it with the v3.6+ definition, that
> > would also be a good thing to do.
> > 
> >  From the 3.74:
> > 
> > SNAPTYPSEL
> > 00		?
> > 01		?
> > 10		Sync, Delay_Req
> > 11		Sync, PDelay_Req, PDelay_Resp
> > 
> > TSEVNTENA
> > 0		All messages except Announce, Management and Signalling
> > 1		Sync, Delay_Req, PDelay_Req, PDelay_Resp
> > 
> > No table is provided, so it's difficult to know what all the bit
> > combinations do for v3.74.
> 
> In 3.73a databook, Table 6-70 has the following information and this is
> similar to v5.1 and v5.3. But don't have 3.74 databook.
> 
> SNAPTYPSEL	TSMSTRENA	TSEVNTENA	PTP Messages
> 00		X 		0 		SYNC, Follow_Up,
> 						Delay_Req, Delay_Resp
> 00 		0 		1 		SYNC
> 00 		1 		1 		Delay_Req
> 01 		X 		0 		SYNC, Follow_Up,
> 						Delay_Req, Delay_Resp,
> 						Pdelay_Req, Pdelay_Resp,
> 						Pdelay_Resp_Follow_Up
> 01 		0 		1 		SYNC, Pdelay_Req,
> 						Pdelay_Resp
> 01 		1 		1 		Delay_Req, Pdelay_Req,
> 						Pdelay_Resp
> 10 		X 		X 		SYNC, Delay_Req
> 11 		X 		X 		Pdelay_Req, Pdelay_Resp

I can't fathom why they would use this table in v3.73a, then put
something different in v4.2, and then go back to this table in
v5.1, so I'm wondering whether any of these tables can be relied
upon. This seems to be a complete mess.

I think the only way out of this is to test this - and I wonder
whether stmmac_selftests.c could have tests added to check which
PTP messages and in which direction get timestamped in each of
these modes.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

