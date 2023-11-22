Return-Path: <netdev+bounces-49968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2477F4195
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4470A281790
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D605B3D3B9;
	Wed, 22 Nov 2023 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="y0oud7Yh"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B969E
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rZQMVcwXhSMxXCcgHFUjo2OSzskPmqMqh3DSW1b4eeQ=; b=y0oud7YhjEhlf2K1qIz+/9gHVP
	FIFZZ2KJv329C0XPFn0CcIaSou2YKlx1VAqs2qTnv3OuXaXLC4Z51Nbi3/my10Ujz44n/a2ZN4W69
	nnfmfr8S5c1jH/E5k/OMzFPCL1gYNVZxzqdFHYRDslCIPLMmA1LvwIvlVb1kv2jdP/5Ng7rxcqpvg
	qlIlaCqeM1nUMCiINpIuVSdvIQf/ENBpgeqHYc6PuMlEclVZIMTesfrRpCDJqW8SoVV+f0+lswk8A
	O//R9URgjI5gYBZXASSpQDsZsh3+j09AOYjpW1liJHCNGHSfEf2q+hN+4X//xWj02//TY+bWdb5+5
	buj6yvGA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47254)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r5jVo-0008Em-0c;
	Wed, 22 Nov 2023 09:27:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r5jVo-00054L-Vh; Wed, 22 Nov 2023 09:27:12 +0000
Date: Wed, 22 Nov 2023 09:27:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Greg Ungerer <gerg@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phylink: require supported_interfaces to
 be filled
Message-ID: <ZV3JcCx8uyM5J691@shell.armlinux.org.uk>
References: <E1q0K1u-006EIP-ET@rmk-PC.armlinux.org.uk>
 <13087238-6a57-439e-b7cb-b465b9e27cd6@kernel.org>
 <650f3c6d-dcdb-4f7e-a3d4-130a52dd3ce9@lunn.ch>
 <c7c8b15d-cb4e-4c5f-8466-293b437f04e6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7c8b15d-cb4e-4c5f-8466-293b437f04e6@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 22, 2023 at 02:12:44PM +1000, Greg Ungerer wrote:
> So I am thinking that something like this actually makes more sense now:
> 
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -577,6 +577,18 @@ static void mv88e6250_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
>         config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100;
>  }
> +static void mv88e6350_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
> +                                      struct phylink_config *config)
> +{
> +       unsigned long *supported = config->supported_interfaces;
> +
> +       /* Translate the default cmode */
> +       mv88e6xxx_translate_cmode(chip->ports[port].cmode, supported);
> +
> +       config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 |
> +                                  MAC_1000FD;
> +}
> +

Looks sensible to me - but I do notice that a black line has been lost
between mv88e6250_phylink_get_caps() and your new function - probably
down to your email client being stupid with whitespace because it's
broken the patch context. Just be aware of that when you come to send
the patch for real.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

