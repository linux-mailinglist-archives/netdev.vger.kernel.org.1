Return-Path: <netdev+bounces-146486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E399D39A4
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 12:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C184281668
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD7819E7E2;
	Wed, 20 Nov 2024 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pIyXcthe"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A3B19F13F;
	Wed, 20 Nov 2024 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732102898; cv=none; b=h3iVcjyRFwYsbz2wje2ll476+NXHGoxL9T73XQHDhZPplhDZa6zNYoE8EzAX4S2AB9DFwIwASTFEKPxIW0dNIQnzPcQOy3AsumkIy3zk/jQgp8T933LxAietys3RV9tzv9zgBXShdNbQt3q5uvgXf9YXOI65fE+lt/uzpMHyd78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732102898; c=relaxed/simple;
	bh=vILuFizisww0o60BEmPF3+25yS8w/Yg/Fr0GNNJrfUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4g9IF40+LvofwrTORs2DcmJ3KTD4rGkxlinx+zPGW9tAWv3geVIiZS1a1PgeeJSrt3B/CLaSFaJFlB1aoZSeo/Hqbnepc34VVgwU7Mj7Xcdu2gNYnnRKMSmritruKivHeoUE44/fY5djQaB7v2v+LYt5/4+PL+R2q/b1Swzuak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pIyXcthe; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Pj3fkjxRBBRbKsik6UaWTJe/SP1ioAOvTFAZ8+3xNBI=; b=pIyXcthefqtcgadsqRc7qaaHRG
	hi6v7ChfC1RQB61X13RRO558mhfiV7ABPoiP+LbCJC5ykYHJp9gMouduUCMqwKwlSu9s+69cS+z8o
	Fcaxl3IrTM8U+lK75izHvfmo6U0tfHz1btxRHGekSWzD5d5UpI+RX4E8XO5C48sc0Lr8BBC8fENdJ
	9KnW8TS+sR5ecuJqMbFwRi24lKmbCsdaGT+hxPk4CAz7fGFwDF9ppHmRb5dRomHG0HYCHBW82Kde8
	lo8NIIH2JAQghOEBjMH1v5ssYwuHvFzxJgRwJK15sDP52FiGqKN47Uo+1MiEjoXL0H2lJYzf5483y
	akhr1DCQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44762)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tDj5F-0005PY-1e;
	Wed, 20 Nov 2024 11:41:22 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tDj5A-00073k-2J;
	Wed, 20 Nov 2024 11:41:16 +0000
Date: Wed, 20 Nov 2024 11:41:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v2 1/2] net: phy: replace phydev->eee_enabled with
 eee_cfg.eee_enabled
Message-ID: <Zz3K3DnAkDgeNP7R@shell.armlinux.org.uk>
References: <20241115111151.183108-1-yong.liang.choong@linux.intel.com>
 <20241115111151.183108-2-yong.liang.choong@linux.intel.com>
 <ZzdOkE0lqpl6wx2d@shell.armlinux.org.uk>
 <c1bb831c-fd88-4b03-bda6-d8f4ec4a1681@linux.intel.com>
 <ZzxerMEiUYUhdDIy@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzxerMEiUYUhdDIy@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 19, 2024 at 10:47:24AM +0100, Oleksij Rempel wrote:
> On Tue, Nov 19, 2024 at 05:06:33PM +0800, Choong Yong Liang wrote:
> > Sorry for the late reply; I just got back from my sick leave. I wasn't aware
> > that you had already submitted a patch. I thought I should include it in my
> > patch series. However, I think I messed up the "Signed-off" part. Sorry
> > about that.
> > 
> > The testing part actually took quite some time to complete, and I was
> > already sick last Friday. I was only able to complete the patch series and
> > resubmit the patch, and I thought we could discuss the test results from the
> > patch series. The issue was initially found with EEE on GPY PHY working
> > together with ptp4l, and it did not meet the expected results. There are
> > many things that need to be tested, as it is not only Marvell PHY that has
> > the issue.
> 
> Hm, the PTP issue with EEE is usually related to PHYs implementing the
> EEE without MAC/LPI support.

I think you are referring to PHYs that implement EEE on their own,
without requiring support at the MAC, such as Atheros SmartEEE.

It wasn't clear that you aren't referring to a situation where the
PHY has EEE support, requiring the MAC to generate LPI but the MAC
does have that ability.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

