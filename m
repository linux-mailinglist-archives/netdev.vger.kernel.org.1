Return-Path: <netdev+bounces-48914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF817F002B
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 15:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246651C20897
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2514F510;
	Sat, 18 Nov 2023 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WKmuJVew"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6848EC0;
	Sat, 18 Nov 2023 06:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BWif9T1uf7HThDO5AN5Tn13q/oRG7kK3WKpLPyN52rk=; b=WKmuJVew0chv9ZFu5D4yDig157
	GdzZINfc3nPhLcjC9vnRZ2Imq69zX8hLPkaumIdVh4gT/Af4Pc0+bDdUyMSolFYTnMfFtHegFpAeD
	G8uxxxPM1KCrCmXy3DFlK9zkz28c9WXXe2N7SU8o4OseUXX18PbQTeOdOllqGTg6N6ZGfqRVrL7Ql
	1jPL8PC3QrLg4Gfd3NFlEDIA7mpGLBKig8k792jvBI34NwbD/znoRRyIjTezPj2cpPq7Hh9ni1hyC
	BeFmfKPK034Awbfaq8bel4uNvJjqNixec7tkiNBSvH1M/NFNSPBuvY4iLP5R6KDZroLtnsqkjPLUB
	DN2DYQ6Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52758)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r4MVz-0003mj-2L;
	Sat, 18 Nov 2023 14:41:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r4MVz-0001Dw-Ap; Sat, 18 Nov 2023 14:41:43 +0000
Date: Sat, 18 Nov 2023 14:41:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com
Subject: Re: [PATCH net-next 05/15] net: dsa: mt7530: improve code path for
 setting up port 5
Message-ID: <ZVjNJ0nf7Mp0kHzH@shell.armlinux.org.uk>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-6-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231118123205.266819-6-arinc.unal@arinc9.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Nov 18, 2023 at 03:31:55PM +0300, Arınç ÜNAL wrote:
> There're two code paths for setting up port 5:
> 
> mt7530_setup()
> -> mt7530_setup_port5()
> 
> mt753x_phylink_mac_config()
> -> mt753x_mac_config()
>    -> mt7530_mac_config()
>       -> mt7530_setup_port5()
> 
> Currently mt7530_setup_port5() from mt7530_setup() always runs. If port 5
> is used as a CPU, DSA, or user port, mt7530_setup_port5() from
> mt753x_phylink_mac_config() won't run. That is because priv->p5_interface
> set on mt7530_setup_port5() will match state->interface on
> mt753x_phylink_mac_config() which will stop running mt7530_setup_port5()
> again.
> 
> Therefore, mt7530_setup_port5() will never run from
> mt753x_phylink_mac_config().
> 
> Address this by not running mt7530_setup_port5() from mt7530_setup() if
> port 5 is used as a CPU, DSA, or user port. This driver isn't in the
> dsa_switches_apply_workarounds[] array so phylink will always be present.
> 
> For the cases of PHY muxing or the port being disabled, call
> mt7530_setup_port5() from mt7530_setup(). mt7530_setup_port5() from
> mt753x_phylink_mac_config() won't run when port 5 is disabled or used for
> PHY muxing as port 5 won't be defined on the devicetree.

... and this should state why this needs to happen - in other words,
the commit message should state why is it critical that port 5 is
always setup.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

