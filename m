Return-Path: <netdev+bounces-65204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3168399FE
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 21:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D6D1F231FB
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 20:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAF382D88;
	Tue, 23 Jan 2024 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="m+UMwDvC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAAA81207
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706040484; cv=none; b=Db3sYeDGEyvJXBfDkhbjJJKLr09lLQNbGmmTMGGOYg6ji0jIkxu2kEy1NL4a08QrTifqx1t/HEGhjJdrxxLql9jbbYVOt2WzzYvmuhA6HlDVhY3icFWEgFP4OeP772rwrtM7WmvcmiUJFGcQOvyF0TFY4vR1WDxYc28IZ04Ds1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706040484; c=relaxed/simple;
	bh=9I/UsS8y9mGIMpG+pdPW0Jhzyh9UOzbZXYsmZioHbIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gA9UdbNWaI40rnZQYwX4w1ikYasNYYK76Hf9VjmqC/oCmbx0CCqbdHmjz8dvxuLkWB58wGBwXGrJdEAmmHdAEK2fZYw4qofHxcrC/Ge1mLmQdts7zrcGipaFUmuATA/bILcg80Nl7eKxNtRwEC5v3YUdvsh9y5ZOBpAuq8uYWWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=m+UMwDvC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/K+NKUpNvuWFdvNqRH7z18FAACuRlVImuRGe1xvHS08=; b=m+UMwDvCAx9RXnWkGffmkb13Mq
	gvAcm/JJcDX+/sH+P1uXjviNELKu+Kpzh9pR9WCP0YhjMPPrLyIygSRxkOU6de2lAq5UHxkkZNsws
	o386r0pOIN50Z5R0L/jEvLcglJo1D54FmiZzs9iQ8W2NWKTaDMviT4/WwaxrhMvj8z8b7hBs23gSk
	Ke5hBSU+IoA7EHTwyr2cc7pWNebZhowOSAK8PSrhh8+egmH1R/e+2YPbDqPSlQox6Fzr812onfsoi
	xtNmvydKPoJI0F7ci262ZxmruhRmnG7HzUB3dPDIjtQ8iHPj0bN7Xk7y5758m6aPH01q99KLFIZP4
	SKSGPhJQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46540)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rSN3f-00031R-1S;
	Tue, 23 Jan 2024 20:07:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rSN3X-0002Ct-RA; Tue, 23 Jan 2024 20:07:35 +0000
Date: Tue, 23 Jan 2024 20:07:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sean Anderson <sean.anderson@seco.com>
Cc: Landen.Chao@mediatek.com, UNGLinuxDriver@microchip.com,
	alexandre.belloni@bootlin.com, andrew@lunn.ch,
	angelogioacchino.delregno@collabora.com, arinc.unal@arinc9.com,
	claudiu.manoil@nxp.com, daniel@makrotopia.org, davem@davemloft.net,
	dqfext@gmail.com, edumazet@google.com, f.fainelli@gmail.com,
	hkallweit1@gmail.com, kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
	netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com,
	sean.wang@mediatek.com
Subject: Re: [PATCH RFC net-next 03/14] net: phylink: add support for PCS
 link change notifications
Message-ID: <ZbAch9ZlbDrZqzpw@shell.armlinux.org.uk>
References: <E1qChay-00Fmrf-9Y@rmk-PC.armlinux.org.uk>
 <75773076-39a2-49dd-9eb2-15a10955a60d@seco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75773076-39a2-49dd-9eb2-15a10955a60d@seco.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 23, 2024 at 02:46:15PM -0500, Sean Anderson wrote:
> Hi Russell,
> 
> Does there need to be any locking when calling phylink_pcs_change? I
> noticed that you call it from threaded IRQ context in [1]. Can that race
> with phylink_major_config?

What kind of scenario are you thinking may require locking?

I guess the possibility would be if pcs->phylink changes and the
compiler reads it multiple times - READ_ONCE() should solve that.

However, in terms of the mechanics, there's no race.

During the initial bringup, the resolve worker isn't started until
after phylink_major_config() has completed (it's started at
phylink_enable_and_run_resolve().) So, if phylink_pcs_change()
gets called while in phylink_major_config() there, it'll see
that pl->phylink_disable_state is non-zero, and won't queue the
work.

The next one is within the worker itself - and there can only
be one instance of the worker running in totality. So, if
phylink_pcs_change() gets called while phylink_major_config() is
running from this path, the only thing it'll do is re-schedule
the resolve worker to run another iteration which is harmless
(whether or not the PCS is still current.)

The last case is phylink_ethtool_ksettings_set(). This runs under
the state_mutex, which locks out the resolve worker (since it also
takes that mutex).

So calling phylink_pcs_change() should be pretty harmless _unless_
the compiler re-reads pcs->phylink multiple times inside
phylink_pcs_change(), which I suppose with modern compilers is
possible. Hence my suggestion above about READ_ONCE() for that.

Have you encountered an OOPS because pcs->phylink has become NULL?
Or have you spotted another issue?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

