Return-Path: <netdev+bounces-157705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E25A0B448
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 11:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7B93A18CB
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151D62045A6;
	Mon, 13 Jan 2025 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="b4BzYaEH"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A7C235C0E
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736763293; cv=none; b=ZfxzWCrqoiCVa+1OQz/4X6LBQIYWwxCK3UG7k2+J258jKj3rG28P2F7nCfExMCvj3pu0DxkbhmbRiuYT9Ms/lm1VL43Zl1IXKCSApK1ExmeXAhjxjATx5rKtWmH7Gm+QR4ZfwVLNFVvCHAfzb1G22PdixHb4gP0Se6Hp1y/LXNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736763293; c=relaxed/simple;
	bh=ZljlfWnq30CcCKDu70+kn5cZW4SMgGjyzCNBuRB1IZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8/q2dMmbn7MdfHDrCS7bEs++m/p+iIUNH7G7w1EFTDUnMLOKX3WUpF6EVY6SDZZN46Dn0N8Wp1MPnRIP8xukA5Y7S6pcDiB42EaD5immMm00kAJklIw+1P6P+cII30FGO9q9FHh5g/1QdO/1E7dh2CRepUa/bCNPRHPcRicXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=b4BzYaEH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cCZ13Q6Ps/k8xOdF/odDZLda0aQKMXcXkaSZRSrL3fw=; b=b4BzYaEHHpCOmQMUefEgXATgxQ
	Po9pUxTmh8FxJ/pBNluaF+w+7jV+1NXXpb7e6jJGnYMM3gqRWyyXqJzVay8K05EMyxYn2BTx09e7e
	8pLrgTU73naTOM3HSI50njWqU2x+g9AkWC2cZvfrlFFK9T6hlkhmoYBRNn8UhEmxM4D/7pFrofQIt
	07/eoOdPsr1aP8F0ZuYEcnK43eZMJ4clPLqeO7gSMlQAEdJ3W/XeyIMAIZge9c/tgMxZZn56gBdQg
	FyRzL1Nvz4YLv6mz0enHVF0Wm0GzviudD58/SDtkvAovzVPWks3yls9xcFxzdqt7sNHRbr0AB43JO
	Amntf9YQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52946)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tXHSl-0006OL-2F;
	Mon, 13 Jan 2025 10:14:27 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tXHSf-0003z6-2Q;
	Mon, 13 Jan 2025 10:14:21 +0000
Date: Mon, 13 Jan 2025 10:14:21 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Golle <daniel@makrotopia.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Eric Woudstra <ericwouds@gmail.com>,
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
Subject: Re: [PATCH net-next v2 0/5] net: phylink: fix PCS without autoneg
Message-ID: <Z4TnfQVIU5QPUeLi@shell.armlinux.org.uk>
References: <Z3_n_5BXkxQR4zEG@shell.armlinux.org.uk>
 <Z4TbDnXtG8f3SRmC@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4TbDnXtG8f3SRmC@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 13, 2025 at 09:21:18AM +0000, Russell King (Oracle) wrote:
> Hi,
> 
> Eric Woudstra reported that a PCS attached using 2500base-X does not
> see link when phylink is using in-band mode, but autoneg is disabled,
> despite there being a valid 2500base-X signal being received. We have
> these settings:

Please ignore this inappropriately threaded cover message. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

