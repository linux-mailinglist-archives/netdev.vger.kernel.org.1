Return-Path: <netdev+bounces-21055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181DF76241B
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D1F1C20FDE
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 21:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C97626B73;
	Tue, 25 Jul 2023 21:04:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED3426B3A
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 21:04:57 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1189D1BF8
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gjPsbkJgGKQCEAaIw+4CvOGfIWuqL8tQPEgzB7IKUFw=; b=jOCoIzIOQW+7dDTWROzc94ArUv
	ZHvd1xaiiFNCH6SfYuM5RlpgQLocgjGfbaCgw8/Sg49lcAo4AfQl5vmyoMvsEvE4gTncp1DQVS8RI
	sLjp6qTDeNNKr0u6JjmUFqiY61GPZThQI2GzifaacuOBY8ggIFghr8bWtKfOqVk8d89bK+suLfyF5
	RjEEsZa/XmX8ydXzOUrrlB8o4I9eBk0+AzeFGjSPUtwBZAwSm4zHm9gpw2wIXbT3gwyoQ/x7ULoJe
	V5AjG2SKBJLDqQ97flH283laIj1Tvf0THaHw+RiUL65J6WCS8qcWp5tXz05vnVKcArPS+NMroNP99
	FgmNeJyw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49862)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qOPCz-0002fG-3B;
	Tue, 25 Jul 2023 22:04:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qOPCv-0002AG-HH; Tue, 25 Jul 2023 22:04:37 +0100
Date: Tue, 25 Jul 2023 22:04:37 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Frank Li <frank.li@nxp.com>
Subject: Re: [PATCH] net: stmmac: dwmac-imx: pause the TXC clock in fixed-link
Message-ID: <ZMA45XUMM94GTjHx@shell.armlinux.org.uk>
References: <20230725194931.1989102-1-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725194931.1989102-1-shenwei.wang@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 02:49:31PM -0500, Shenwei Wang wrote:
> +static bool imx_dwmac_is_fixed_link(struct imx_priv_data *dwmac)
> +{
> +	struct plat_stmmacenet_data *plat_dat;
> +	struct device_node *dn;
> +
> +	if (!dwmac || !dwmac->plat_dat)
> +		return false;
> +
> +	plat_dat = dwmac->plat_dat;
> +	dn = of_get_child_by_name(dwmac->dev->of_node, "fixed-link");
> +	if (!dn)
> +		return false;
> +
> +	if (plat_dat->phy_node == dn || plat_dat->phylink_node == dn)
> +		return true;

Why would the phy_node or the phylink_node ever be pointing at the
fixed-link node?

For one, phylink expects the fwnode being passed to it to be pointing
at the _parent_ node of the fixed-link node, since it looks up from
the parent for "fixed-link" node.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

