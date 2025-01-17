Return-Path: <netdev+bounces-159260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE563A14F1C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662F3188960F
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66DD1FDE2A;
	Fri, 17 Jan 2025 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="knUrbu7E"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2511155300
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737116657; cv=none; b=tagTJhPyXZEVHzCinkSL8xOBbSSlbxYk9j9nhpDaF6lFtlM8TDPWS4gON1c3jacjor9k9QghdNHG+yasJKLl/vLHRxepG1JWJ/nJNZusu/sGqSVcSGZIvatMsq+6L7vTh8Gire3MdO2bps6nyL+UJoYPNYa8b1eNNX57MVP29Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737116657; c=relaxed/simple;
	bh=FO9YRI4BTJdU0ms3fw2f/ZssFRegZTK55lbTbukvwzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZId7NOKrbyGLLo5KATQdBSflBefB+o7YsjR6mu74TFihFRIauIiTrf07zuWxMlupBE1KotLriEquB0OfRYMcNM/KSu6haqLSIRulhbjVpw9Qqo+BUoR25/yszic8hXmaWzkIv0UU2YuL2eNMhvGSvUiZl03g8U3a6I/OyaJBVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=knUrbu7E; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OgMlLosfXsyCFfHkGv5D0Rn1NUZBobKjUdTqgKXXGio=; b=knUrbu7E0b5Baxh2gMk5za1r1C
	NUpRTrv2mjlOq3x1/1UTg27s0nHK1C9vUk9kMsQX07YBphpWZxUCCQd1tCY5N3l6y4+02QVavv7gR
	8SYim/nsRlC7qsXa2jicBD8+yy4Pi+ECnh1KWECUjQT+62c9ToKuGkzkMf5+NZYL9TDFtp4NpkaDn
	vfFGft0YLbekf1QqHmHZnB6cNcay5aY0Io/HY74XxBV6f/McISad4NWr1LBzG489dw0GSQZ2J5CPJ
	9qQqbQQWETeTAVc5lYVoByWttoh7NGpNwk1vVBZPAnpxsUrlYaouohiupHn2T/PY778N/G8P9wI5K
	Ty2uXj9Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48914)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tYlOL-0003dd-1E;
	Fri, 17 Jan 2025 12:24:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tYlOG-0008GV-1N;
	Fri, 17 Jan 2025 12:23:56 +0000
Date: Fri, 17 Jan 2025 12:23:56 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: 'Andrew Lunn' <andrew@lunn.ch>,
	'Heiner Kallweit' <hkallweit1@gmail.com>, mengyuanlou@net-swift.com,
	'Alexandre Torgue' <alexandre.torgue@foss.st.com>,
	'Andrew Lunn' <andrew+netdev@lunn.ch>,
	'Bryan Whitehead' <bryan.whitehead@microchip.com>,
	"'David S. Miller'" <davem@davemloft.net>,
	'Eric Dumazet' <edumazet@google.com>,
	'Jakub Kicinski' <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	'Marcin Wojtas' <marcin.s.wojtas@gmail.com>,
	'Maxime Coquelin' <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org, 'Paolo Abeni' <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 0/9] net: add phylink managed EEE support
Message-ID: <Z4pL3Mn6Qe7O45D7@shell.armlinux.org.uk>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
 <06d301db68bd$b59d3c90$20d7b5b0$@trustnetic.com>
 <Z4odUIWmYb8TelZS@shell.armlinux.org.uk>
 <06dc01db68c8$f5853fa0$e08fbee0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06dc01db68c8$f5853fa0$e08fbee0$@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 17, 2025 at 06:17:05PM +0800, Jiawen Wu wrote:
> > > Since merging these patches, phylink_connect_phy() can no longer be
> > > invoked correctly in ngbe_open(). The error is returned from the function
> > > phy_eee_rx_clock_stop(). Since EEE is not supported on our NGBE hardware.
> > 
> > That would mean phy_modify_mmd() is failing, but the question is why
> > that is. Please investigate. Thanks.
> 
> Yes, phy_modify_mmd() returns -EOPNOTSUPP. Since .read/write_mmd are
> implemented in the PHY driver, but it's not supported to read/write the
> register field (devnum=MDIO_MMD_PCS, regnum= MDIO_CTRL1).
> 
> So the error occurs on  __phy_read_mmd():
> 	if (phydev->drv && phydev->drv->read_mmd)
> 		return phydev->drv->read_mmd(phydev, devad, regnum);

Thanks. The patch below should fix it. Please test, meanwhile I'll
prepare a proper patch.

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 66eea3f963d3..56d411bb2547 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2268,7 +2268,11 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	/* Explicitly configure whether the PHY is allowed to stop it's
 	 * receive clock.
 	 */
-	return phy_eee_rx_clock_stop(phy, pl->config->eee_rx_clk_stop_enable);
+	ret = phy_eee_rx_clock_stop(phy, pl->config->eee_rx_clk_stop_enable);
+	if (ret == -EOPNOTSUPP)
+		ret = 0;
+
+	return ret;
 }
 
 static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

