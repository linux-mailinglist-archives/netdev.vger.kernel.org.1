Return-Path: <netdev+bounces-12305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8852A7370F7
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 17:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679431C20C7B
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC2B174FE;
	Tue, 20 Jun 2023 15:51:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B59ED510
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 15:51:34 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8EEE6E
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IAwNa4d04CaRpIb0GCYZCrBbuTn83G/0o/IfmrFaku4=; b=mphIWJ4y3VFUaHNWqWPAf8myOm
	JEgUbh/g8HTvd0h6Gh4v+V19fkrbdLe/U5FReoSgWCUJ09N75aVa++8cEbahnJySvR25FZAILAQM7
	eToAqnRQ8fMRyKIhGh81o01qMMNaBQIu6PiUiEAVfX8wl0OQ2Cyh1H23N/6WK4jweQZCr632+cwpG
	s7QboqQb4SN4gI9EjhDAICZhThOGJAZXmF0510oZyNFSYsz+PI2Q5HTSJkOFzljGRtHjBsCdEnUnw
	s0UYs6zh9xs97UPiBPx4AiNtfCVeWxO++qp3vAfTWVKMnRfLER0kZ6pMOxQ9eLqCodvlPf7AtB1Tl
	GPkpc+5g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58854)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qBddR-0001JG-7S; Tue, 20 Jun 2023 16:51:13 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qBddN-0006pN-0F; Tue, 20 Jun 2023 16:51:09 +0100
Date: Tue, 20 Jun 2023 16:51:08 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Cc@web.codeaurora.org:Claudiu Beznea <claudiu.beznea@microchip.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michal Simek <michal.simek@amd.com>, netdev@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 01/15] net: phylink: add PCS negotiation mode
Message-ID: <ZJHK7MiZUR4Kr2ZT@shell.armlinux.org.uk>
References: <ZIxQIBfO9dH5xFlg@shell.armlinux.org.uk>
 <E1qA8De-00EaFA-Ht@rmk-PC.armlinux.org.uk>
 <20230620113730.vm2buvcifdcvhujb@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620113730.vm2buvcifdcvhujb@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 20, 2023 at 02:37:30PM +0300, Vladimir Oltean wrote:
> On Fri, Jun 16, 2023 at 01:06:22PM +0100, Russell King (Oracle) wrote:
> > @@ -443,6 +526,7 @@ struct phylink_pcs_ops;
> >   */
> >  struct phylink_pcs {
> >  	const struct phylink_pcs_ops *ops;
> > +	bool neg_mode;
> >  	bool poll;
> >  };
> 
> I deleted one of my own comments while trimming the email... Yay me :)
> 
> Would it be more appropriate to name this "bool pass_neg_mode" to avoid
> a naming collision between "bool neg_mode" and "unsigned int neg_mode"?

I'd entertain "want_neg_mode" but I don't think there's much scope for
confusion between the two - PCS drivers only get to set this flag
during the creation of the PCS.

In any case, I don't want this "neg_mode" to hang around for ages
and I see it as a transitory mechanism that will go away in a max of
a couple of kernel releases, especially as this patch set ensures
that all current users are converted. At the moment, it will catch
the case where some new PCS driver gets merged that doesn't use the
new "neg_mode" (and thus doesn't set this boolean flag.)

I know it's heresy, but it also helps trees like OpenWRT deal with
the interface change - which after all will _not_ generate any
compiler diagnostics between a converted PCS driver and an
unconverted PCS driver.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

