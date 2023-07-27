Return-Path: <netdev+bounces-21823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E356B764E63
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0F21C2156F
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64A7F9C8;
	Thu, 27 Jul 2023 08:59:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC8FDDD9
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 08:59:10 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA21272E
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 01:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F+54Rr5uw29T2tRPmyJTl5sfmrbuhWUP5cKAQggrocA=; b=DjL9WdDG/0kgbuSaoTwV3yFdg9
	lSYhKbHVF4mzAxHnzGtW7K0PpANxjHbPQX8xSwFMD7iiigOS2/Sn9d82Rd4J/KxSIXjJFycKTPqiS
	rfv2p4ErUBAEjfWH6ywhrR4miNIngrpxJ9NRGTKkS94qkUvbjVYj8U6uQb17tbu81UfsK28y7CBBs
	VowBZP/L3wJFUGqzBSbQJ21yG5sXlNFU1uxvB3yEm0/v5bGJg78kNXY8ZPcpgddllL7/1tRsgT+KY
	vAYbkpe41pBa2KZLp11+eLB9UgkBgdJfnp7gSEArhxTuNN5U/hZV/4P1Aa862Fpzxoi6Q6JdriOOD
	HjfnW+sA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46140)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qOwpe-0005Z8-2m;
	Thu, 27 Jul 2023 09:58:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qOwpb-0003la-Il; Thu, 27 Jul 2023 09:58:47 +0100
Date: Thu, 27 Jul 2023 09:58:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	Frank Li <frank.li@nxp.com>
Subject: Re: [EXT] Re: [PATCH] net: stmmac: dwmac-imx: pause the TXC clock in
 fixed-link
Message-ID: <ZMIxx2TkW2Ry4AoR@shell.armlinux.org.uk>
References: <20230725194931.1989102-1-shenwei.wang@nxp.com>
 <20230726004338.6i354ue576hb35of@skbuf>
 <PAXPR04MB9185C1A95E101AC2E08639B78900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZME71epmSHYIB4DZ@shell.armlinux.org.uk>
 <PAXPR04MB91856018959FE0752F1A27888900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZMFRVtg5WQyGlBJ1@shell.armlinux.org.uk>
 <PAXPR04MB9185108CB4A04C4CD5AE29FC8900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZMFtw0LNozhNjRGF@shell.armlinux.org.uk>
 <PAXPR04MB91855E5990464A1B31058B508900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB91855E5990464A1B31058B508900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 07:17:59PM +0000, Shenwei Wang wrote:
> > Because of_phy_is_fixed_link() has to chase various pointers, walk the child
> > nodes and do a string compare on each, whereas you could just be testing an
> > integer!
> >
> 
> I don't think It's worth the effort to change the definition of fix_mac_speed across all platforms,
> because the function is only called once when the interface is up.

If you look at Feiyang Chen's patch set, then his first patch of his
set adds a pointer to struct stmmac_priv to a whole bunch of callbacks
used between the stmmac core and the various implementations.

If you're not willing to do it, then I will send a patch instead.

I don't see what the problem is.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

