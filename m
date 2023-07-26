Return-Path: <netdev+bounces-21518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DDE763C82
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3671C21395
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94734379A2;
	Wed, 26 Jul 2023 16:29:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87083253BC
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:29:49 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F9E26A1
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OwJO2rYMHSmEa1Cymjihpbf4CVWm2/tebNBXFw4P7Uo=; b=P9H1BFljSrVVXFECl54skx9hT+
	ucrFJ2ZwfjQNVwpiuFUbnKVXa7kpw3956AEIKtml8Il5Ml+YsMvz3Qd7B8aT3/pF7pYeyaibET7+n
	qSRR9tZWZeFHcP3Hq8nZHtaKTAHmJKCIZk7nGES2Pn1lYMItvFMw2y4yLHee5cN+fiHyAAsblhIeE
	yuFEXhtgZxHYa4rTemYyBlR1QroWNScmehJM0dHPtljX1aa0iaS1pAOTZC3HSMixUeyoCFf+nrx6w
	Z/dF+BpRK0TopIsI+7bFDBJJsyFqlDhH7B1HzMHMgdT7ddwghpBk+oZwofLgemSx5SCbrfp9/+x2f
	8VO613LA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50408)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qOhOH-0004i4-1W;
	Wed, 26 Jul 2023 17:29:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qOhOE-00030o-Fp; Wed, 26 Jul 2023 17:29:30 +0100
Date: Wed, 26 Jul 2023 17:29:30 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
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
Message-ID: <ZMFJ6ls0LHrUWahz@shell.armlinux.org.uk>
References: <20230725194931.1989102-1-shenwei.wang@nxp.com>
 <ZMA45XUMM94GTjHx@shell.armlinux.org.uk>
 <PAXPR04MB91857EA7A0CECF71F961DC0B8900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZME3JA9VuHMOzzWo@shell.armlinux.org.uk>
 <PAXPR04MB9185A31E1E3DEBABE03C60F78900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB9185A31E1E3DEBABE03C60F78900A@PAXPR04MB9185.eurprd04.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 04:10:11PM +0000, Shenwei Wang wrote:
> > So, plat->phy_node will never ever be equal to your "dn" above.
> > plat->phylink_node is the same as dwmac->dev->of_node above, and
> > so plat->phylink_node will never be your "dn" above either.
> >
> > Those two together means that imx_dwmac_is_fixed_link() will _always_ return
> > false, and thus most of the code you're adding is rather useless.
> >
> > It also means the code you're submitting probably hasn't been properly tested.
> >
> > Have you confirmed that imx_dwmac_is_fixed_link() will actually return true in
> > your testing? Under what conditions did your testing reveal a true return value
> > from this function?
> >
> 
> We can't make that assumption. In my testing code, I had trace statements in that
> section to indicate the code was actually executed. You may get some clues from the following DTS:
> 
> +&eqos {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_eqos_rgmii>;
> +       phy-mode = "rgmii-rxid";
> +       phy-handle = <&fixed0>;
> +       status = "okay";
> +
> +       fixed0: fixed-link {
> +               speed = <1000>;
> +               full-duplex;
> +       };

This is just totally botched up.

"fixed0" is _not_ a PHY, therefore you should NOT be referencing it
in phy-handle. Please see the DT binding document:

  phy-handle:
    $ref: /schemas/types.yaml#/definitions/phandle
    description:
      Specifies a reference to a node representing a PHY device.

  fixed-link:
    oneOf:
      - $ref: /schemas/types.yaml#/definitions/uint32-array
        deprecated: true
...
      - type: object
        additionalProperties: false
        properties:
          speed:
...

As I said, fixed-link is _not_ a PHY, and thus phy-handle must *not*
be used to point at it.

The mere presence of a node called "fixed-link" will make this "eqos"
device use that fixed-link node, and the phy-handle will be ignored.

So sorry, but as far as your patch goes, it's a hard NAK from me
right now until the DT description is actually correct.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

