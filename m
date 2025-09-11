Return-Path: <netdev+bounces-222091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01115B5304A
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3827C1611F9
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 11:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE4032038A;
	Thu, 11 Sep 2025 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QTOeBr6p"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B2A31E117;
	Thu, 11 Sep 2025 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589890; cv=none; b=EIvQXySIlitvyg61u4fDwYAbUzXRpeLRWUTED8Nr2CqDZsdKfxNu9oLyhuH7q9UMCwfgLhMh70Zgk095muAXgMHwQIlweiTrtxVEHqmg/fezFQPMZ4xUABIQvOW9pkaGK+VIHststFywCFJCUgsR+f68ZNVHTZcw73czwkKH5eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589890; c=relaxed/simple;
	bh=PFLCWRhiW5Ei/SHMUi4lKqIQKg4W6fsqYN7nk1OskwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNZRcIvzpMdeM5x2RAQ0+rYBk25bd59Vh7Ka6fUzguxn5pU5/llsAOkFWyTUVaLioc273+s2RpQ+dJiU5nW8FmkwEWFV9yYYAIiEESd1lGe8j+gOX9svWg0HVw0rSlk7MvA0qJPHv8nWowrMI3SgdxIU2LdHmADtDDhmya0RwzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QTOeBr6p; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/iiP702baNdF+7Fw90ZvkFyuCYDheIf65+pVTaTUlsA=; b=QTOeBr6pyNDGlNdDVNt7lCTzyh
	g1dav/hh6qKd22BJ+t2SEZIRquQFlpQViYzZYbhqTZQjhJ3+JI0lthowRf1yqGnFOvyiPCJeEE9s2
	NUrHAOlWBpujYTAb/HWL2D3xz36aozHDGZfh/uP9zT762yC3XDknQ0YrHirjhDR7PSYf+RxxCaDnv
	/XzTZbZrJVC0zzH3A3gcqSeq+/9gI+a4kUxuKyM8iGC5jf0JOCBsH/bTEzQ7zVutN3XsNOc/kIjx7
	rhdSJHA9JD61AmSzXHFZ30OSNpnWUNpBaYTP18egfpoSLwblCRrWKOnUK4dg7doidyHyKrnz+dPah
	KiOedZQg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41542)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uwfPr-000000002xD-2SXY;
	Thu, 11 Sep 2025 12:24:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uwfPn-000000002JV-3y45;
	Thu, 11 Sep 2025 12:24:35 +0100
Date: Thu, 11 Sep 2025 12:24:35 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: rohan.g.thomas@altera.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Rohan G Thomas <rohan.g.thomas@intel.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net 1/2] net: stmmac: est: Fix GCL bounds checks
Message-ID: <aMKxc6AuEiWplhcV@shell.armlinux.org.uk>
References: <20250911-qbv-fixes-v1-0-e81e9597cf1f@altera.com>
 <20250911-qbv-fixes-v1-1-e81e9597cf1f@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-qbv-fixes-v1-1-e81e9597cf1f@altera.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 11, 2025 at 04:22:59PM +0800, Rohan G Thomas via B4 Relay wrote:
> @@ -1012,7 +1012,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  		s64 delta_ns = qopt->entries[i].interval;
>  		u32 gates = qopt->entries[i].gate_mask;
>  
> -		if (delta_ns > GENMASK(wid, 0))
> +		if (delta_ns >= BIT(wid))

While I agree this makes it look better, you don't change the version
below, which makes the code inconsistent. I also don't see anything
wrong with the original comparison.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

