Return-Path: <netdev+bounces-137393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B02B49A5FD8
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2832820A6
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 09:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA401E25EC;
	Mon, 21 Oct 2024 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="A5c9JpQg"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C753194A54
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502447; cv=none; b=lFttZvjwqsYrDGJoZCX3YuBz3LAeV4aqavmzt2qrNugrnMjpcc9DvwKTBZ2FzttviSdLr9QP3kFxXyMNJhUngDxh1h2/gPzCJHcIRsImRbblm+sLzeuS1MiBIbcwHI3EOe9GMDc9PAxXA0H5iikfqH9mTDFgXz2v4LbKfGYN/b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502447; c=relaxed/simple;
	bh=hyHsuLMfw92Hr+xUde2x2tu2e6PgGrP9m3SxsiMwqq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYkuKI+XChBY6McJxDttI91XJ8xv/zKgcN9tsqgrSNWOc8sehS0zaVXOD8MS9GzwEBNdt8csPGaBecTk0CcdvgHct4+QChTKpHmHDdn3fJmGtnA/OqTifkmBbZ/dDh1UoqL/4LuCwo9cBOy0KM/teqtDL4noKDyMwQac1/pJf6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=A5c9JpQg; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qqjoCgvG5CCB6J/vMfx+zCiOUsVg3KVV8Hr8F4GQT38=; b=A5c9JpQgO4zzYKGKMeXHuxCord
	k3nZiSRM1eEz9U74AgcejarJlEJaa+W03r9U+vtw217OPrydOc9zTTWE1IOuJQPnj1rFO33hCJgj+
	8isEA7lVWI++f8/UQX7GA9xH4xjx/91HpFkd3jx3mlPeA7P/hb6gTdLQudyutGUOmkbEAzcXU/QOm
	niAcdnIXbFZz3uSo/1c6QQKS7uXc5CF9P5n85VBxzm87f5LiJ/CuD1xRRylwiqxmlAvusiOcMVyr3
	c7bKY8BbgopPIuazalh/ZURXHHQKodZfDgCO21p1DlXWpz07YTu3BjpVSW+SL3Yu5tNXjhzSTxHXw
	3UhN2kWQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54450)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1t2oaU-000352-2T;
	Mon, 21 Oct 2024 10:20:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1t2oaP-0001cT-0A;
	Mon, 21 Oct 2024 10:20:25 +0100
Date: Mon, 21 Oct 2024 10:20:24 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Andrew Halaney <ahalaney@redhat.com>,
	Simon Horman <horms@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	kernel@quicinc.com
Subject: Re: [PATCH net v1] net: stmmac: Disable PCS Link and AN interrupt
 when PCS AN is disabled
Message-ID: <ZxYc2I9vgVL8i4Dz@shell.armlinux.org.uk>
References: <20241018222407.1139697-1-quic_abchauha@quicinc.com>
 <60119fa1-e7b1-4074-94ee-7e6100390444@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60119fa1-e7b1-4074-94ee-7e6100390444@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Oct 19, 2024 at 04:45:16AM +0200, Andrew Lunn wrote:
> On Fri, Oct 18, 2024 at 03:24:07PM -0700, Abhishek Chauhan wrote:
> > Currently we disable PCS ANE when the link speed is 2.5Gbps.
> > mac_link_up callback internally calls the fix_mac_speed which internally
> > calls stmmac_pcs_ctrl_ane to disable the ANE for 2.5Gbps.
> > 
> > We observed that the CPU utilization is pretty high. That is because
> > we saw that the PCS interrupt status line for Link and AN always remain
> > asserted. Since we are disabling the PCS ANE for 2.5Gbps it makes sense
> > to also disable the PCS link status and AN complete in the interrupt
> > enable register.
> > 
> > Interrupt storm Issue:-
> > [   25.465754][    C2] stmmac_pcs: Link Down
> > [   25.469888][    C2] stmmac_pcs: Link Down
> > [   25.474030][    C2] stmmac_pcs: Link Down
> > [   25.478164][    C2] stmmac_pcs: Link Down
> > [   25.482305][    C2] stmmac_pcs: Link Down
> 
> I don't know this code, so i cannot really comment if not enabling the
> interrupt is the correct fix or not. But generally an interrupt storm
> like this is cause because you are not acknowledging the interrupt
> correctly to clear its status. So rather than not enabling it, maybe
> you should check what is the correct way to clear the interrupt once
> it happens?

stmmac PCS support is total crap and shouldn't be used, or stmmac
should not be using phylink. It's one or the other. Blame Serge for
this mess.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

