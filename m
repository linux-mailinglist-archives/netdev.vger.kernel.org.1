Return-Path: <netdev+bounces-157107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163FCA08EF6
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54D9188AA2C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1751FF602;
	Fri, 10 Jan 2025 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uBSSQKxa"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3764F1ACEB2
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736507730; cv=none; b=cRsmv9Ck/8p6s280tSj3+oPriMnUhLO/tCZJfaDf3tPiWH/3edbvIR5JpcJrRKIpD4Pcb4HlWFZJwUIJbjA7oggTFBpVkoXTvmR4gfkCDeeiuVhSYRy3lAwiRimH5vIJ4lNwZvX1rV3YEYq0LsWNTI+pJ133mUpz8TscWFA5MIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736507730; c=relaxed/simple;
	bh=BEIFnDwnp5Y5hyvtL7OvREDrSWrlW04QGtYovJRHHDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RibS92bZ2ZBP/rsd0E0tP9hxuECFdr/7gcvP8M3+OmuoONkFp7M81Tpjhr7qaTL8t1wla9bXTitaOg9ziZ/MLaN/llb5A/Z9R2S3/RpcpDrZBD6LlMXl3crANq42eVTT0LS0f04FkCffDfR8UtrgHFTLJRpJMQh+2r+n5MiNwuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uBSSQKxa; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VXQQFvf77bchSnkndxN19Cawx7kLut+C4n4JPrH4k6I=; b=uBSSQKxaiw7OaZ+6k41YG14Ir1
	2KhCMN6MxDj0MStEYBLj7ZGmGw5OS7eKVr+0Ak9MQU867of5ryWX8nbkILrZ0fCbt8BJntZGSj++K
	b2Vhk0hVqoYT9Dmr3SUMdB3JyVFGvHV7tqU/jeekAi8HkOJZZPXUj9IqSfQHoyUTVD8HtXwP255MK
	QRoYynNJ2ba3Sx8PtjpAfejiB9Yk2JCYTJMF7RadrNl/koJXiifcvnBkzIV8OS0BQpSM9CoBo7Pwj
	XnomMeXTy56j5sFGK/jpTGmJ/C3FV9144VSYnhqzKnkT+7sk6H6A0CXqRdDJoWbj4wLbYuISGM8Qe
	EmBOA15A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53686)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tWCyg-0003KH-2L;
	Fri, 10 Jan 2025 11:14:58 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tWCyY-0008HW-1b;
	Fri, 10 Jan 2025 11:14:50 +0000
Date: Fri, 10 Jan 2025 11:14:50 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ar__n__ __NAL <arinc.unal@arinc9.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Golle <daniel@makrotopia.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>, kernel-team@meta.com,
	Lars Povlsen <lars.povlsen@microchip.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michal Simek <michal.simek@amd.com>, netdev@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH net-next 5/5] net: phylink: provide fixed state for
 1000base-X and 2500base-X
Message-ID: <Z4EBKhGVwlVhxAxw@shell.armlinux.org.uk>
References: <Z3_n_5BXkxQR4zEG@shell.armlinux.org.uk>
 <E1tVuG1-000BXo-S7@rmk-PC.armlinux.org.uk>
 <a54b564b-4f88-4783-9e8a-72289ce11c04@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a54b564b-4f88-4783-9e8a-72289ce11c04@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 10, 2025 at 09:04:56AM +0100, Eric Woudstra wrote:
> 
> On 1/9/25 4:15 PM, Russell King (Oracle) wrote:
> > When decoding clause 22 state, if in-band is disabled and using either
> > 1000base-X or 2500base-X, rather than reporting link-down, we know the
> > speed, and we only support full duplex. Pause modes taken from XPCS.
> > 
> > This fixes a problem reported by Eric Woudstra.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/net/phy/phylink.c | 29 +++++++++++++++++++----------
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> 
> After changing 'if (pcs->neg_mode)' to 'if (pcs && pcs->neg_mode)' in
> patch 1/5, I have tested this patch-set and I get link up.
> 
> Tested-by: Eric Woudstra <ericwouds@gmail.com>

Thanks Eric. Much appreciate your patience with this tangent to the
issue you have - your report highlighted that there was this other
bug that needed fixing in addition to the problem you were experiencing.
I've fixed that slightly differently (as below) and I'll post a v2
shortly.

+       if (!pcs || pcs->neg_mode)
+               autoneg = pl->pcs_neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED;
+       else
+               autoneg = linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+                                           state->advertising);

there, since the "else" clause is the legacy case. I doubt that makes
any difference to your testing scenario, but please let me know if
you want to re-test with that before I add your t-b.

Next, we need to address your problem properly... I'll be looking at
that today.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

