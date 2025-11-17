Return-Path: <netdev+bounces-239168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F44C64D8E
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 16:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE69A346B3C
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 15:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEE8334697;
	Mon, 17 Nov 2025 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="RGH5vJur"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3604A332EAB;
	Mon, 17 Nov 2025 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392658; cv=none; b=YTdFnbnYMUkr2fXRn+ky0F694jtSr/Lrpabmmiij1tn11b88vQODDpvBsuZQIkcLcoWjfkUoLmnwLDKs6L3RDUoohapgWy0hKAPrtIem9EkKPI/hJ83+8F6ZjTW+yBEsegk1EOiW8c3grXVq+6Hemp6SQbQzluRNS0+zwhq21oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392658; c=relaxed/simple;
	bh=kDGyyd8Er/yb517j7UsDdklFoTkfzigvta3V0wORQKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/PLbe0zNlImn3jPE2xW0vBR0EcOd7SQmm3iI8gfBAvtf3LGnBedq55soGVaCRIAEikv30pjOdmrLn1HHw7nbgv8peGuGa2hRnIG0gv5QbyIdK5U7ylTMvuxTvMUN88u9kRo3l27gfUTqrPJZoyrCfHFZNrFZeKqcRA1bf2yJQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=RGH5vJur; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nzvzRJlLUC8pZrf+NlP+OfBgD+MtzcdLwyPjZghTrJA=; b=RGH5vJurGySe2u3t0dXxK9dyJk
	HLEnGO/qJppfVBzuU1PQ20LB5ZBkV3IKxz+U7W+TAjZRbvbjUoyrDftH7RFdOwJYlWlSd6fTW2VzW
	sM5lyOFDRjNhFqRHVsX79AWtF2gtV9hYxpkKfd2J6JfFWkmOiFWeb/GBPZayCWRgjDh0e5CxhhTVQ
	yICOIckDw4Z3FmtVAgcyZrQjAvVB7ZBNlbqCzdf0Gkbs7RBn8UFldwW3csvqHicBOQTPBZBoplscG
	OvSibN5pGDwr9pvuyLtz99WYAX1hKcNqARE4E62bwXw4/x71inPntzhNeRfmC3t9YiFfhbPGiFvxF
	ugIhpYYQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34848)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vL0yp-00000000209-40oZ;
	Mon, 17 Nov 2025 15:17:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vL0ym-000000001Zb-3zCC;
	Mon, 17 Nov 2025 15:17:20 +0000
Date: Mon, 17 Nov 2025 15:17:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Wei Fang <wei.fang@nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	eric@nelint.com, maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: phylink: add missing supported link modes for
 the fixed-link
Message-ID: <aRs8gMOyC9ZbqMfe@shell.armlinux.org.uk>
References: <20251116023823.1445099-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116023823.1445099-1-wei.fang@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Nov 16, 2025 at 10:38:23AM +0800, Wei Fang wrote:
> Pause, Asym_Pause and Autoneg bits are not set when pl->supported is
> initialized, so these link modes will not work for the fixed-link. This
> leads to a TCP performance degradation issue observed on the i.MX943
> platform.
> 
> The switch CPU port of i.MX943 is connected to an ENETC MAC, this link
> is a fixed link and the link speed is 2.5Gbps. And one of the switch
> user ports is the RGMII interface, and its link speed is 1Gbps. If the
> flow-control of the fixed link is not enabled, we can easily observe
> the iperf performance of TCP packets is very low. Because the inbound
> rate on the CPU port is greater than the outbound rate on the user port,
> the switch is prone to congestion, leading to the loss of some TCP
> packets and requiring multiple retransmissions.
> 
> Solving this problem should be as simple as setting the Asym_Pause and
> Pause bits. The reason why the Autoneg bit needs to be set is because
> it was already set before the blame commit. Moreover, Russell provides
> a very good explanation of why it needs to be set in the thread [1].
> 
> [1] https://lore.kernel.org/all/aRjqLN8eQDIQfBjS@shell.armlinux.org.uk/
> 
> Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link configuration")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Even though discussion is still going on, we do need to fix this
regression. So:

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

