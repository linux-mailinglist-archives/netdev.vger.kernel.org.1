Return-Path: <netdev+bounces-68526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2B584715B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDEF81C226A6
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F7A1FCA;
	Fri,  2 Feb 2024 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ml2LZsqY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF6446B9B
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706881568; cv=none; b=EFksiXp4BHD0HtSONCaJzlQ8MBcRcJZNRvUEcdD5vJ/UCwtPH31xDaCrwx1RUhbPigtW+6Kz6jD/YlPOoS0hZ6x0ZmxYwdBS7WvgSLdGSM46RhGM/G8iUfV9guQ2y+mGHd0hfE+y031TbvroMVoJKbdk0LgBcPSpiNTf5q+hedw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706881568; c=relaxed/simple;
	bh=QAYb6vsRnOnThDVh38Ak4sBRMhLsPFggVSP2wvyWDho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+5F9m1a3db8mEBfJrvIHD1WYvduDZP7sHyPsDDCk5BFVQjAtRT8GItAq/b86ovrefJkDJfqKXeGHpjN0Eqcth9GndF/R2UCl6EzKbSl8oK7hcyoXWYhlxoeFpw8GlVVQh5yAOZNJbddvkuL1cc8+UybZMa2Dk0bvE9Fe+ajyk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ml2LZsqY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7hFvlERHieFAUVwlSVD673jXkZUakpcgcmrI0kwzE+Q=; b=ml2LZsqYjytchOT37m3ldtskih
	8BlyHKRB07xDljmVdrFSERYHH1plpteURpODM5Vq/d+IPZO+LHZlRaRUVf67OJmbhjdIiE37e+vva
	37DG9vtOcfZBmVswhST+mNnSSti+wB6eTDKAfzSbfXC7cMnpgvHtwxjCSBiGt1pk4+yc/W3JZMB4t
	TwaNeLJgUyssyER2l37LnXGrSydladNs3goAm41WVV2d50ZUmscFAzZFxE7Gq6nQFct3FRJNYIjRx
	3OxUAy2ECxEmaq1Xh3FTZI6YBJoVPUuD2b34+q4Vcsy/FYrL7N98JiP5neHHFcKpJDBcGY6Y37G50
	swML5u6g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59704)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rVtrW-00063T-0c;
	Fri, 02 Feb 2024 13:45:46 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rVtrP-0008Mp-Lz; Fri, 02 Feb 2024 13:45:39 +0000
Date: Fri, 2 Feb 2024 13:45:39 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: g@lunn.ch, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Byungho An <bh74.an@samsung.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Doug Berger <opendmb@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>, Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH net-next 3/6] net: fec: remove eee_enabled/eee_active in
 fec_enet_get_eee()
Message-ID: <ZbzyAy7Nc7vf+BD9@shell.armlinux.org.uk>
References: <Zby24IKSgzpvRDNF@shell.armlinux.org.uk>
 <E1rVpvm-002Pe0-TV@rmk-PC.armlinux.org.uk>
 <011cb523-0561-436a-9f64-4479648b4770@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011cb523-0561-436a-9f64-4479648b4770@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 02, 2024 at 02:22:02PM +0100, Andrew Lunn wrote:
> On Fri, Feb 02, 2024 at 09:33:54AM +0000, Russell King (Oracle) wrote:
> > fec_enet_get_eee() sets edata->eee_active and edata->eee_enabled from
> > its own copy, and then calls phy_ethtool_get_eee() which in turn will
> > call genphy_c45_ethtool_get_eee().
> > 
> > genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
> > with its own interpretation from the PHYs settings and negotiation
> > result.
> > 
> > Therefore, setting these members in fec_enet_get_eee() is redundant.
> > Remove this, and remove the setting of fep->eee.eee_active member which
> > becomes a write-only variable.
> 
> I _think_ p->eee_enabled becomes write only as well?

Thanks for spotting, I'll remove it in v2!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

