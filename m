Return-Path: <netdev+bounces-256339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCo3H74YgmmZPAMAu9opvQ
	(envelope-from <netdev+bounces-256339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:48:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DB3DB811
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19BA93050D5F
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 15:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7B03B95FC;
	Tue,  3 Feb 2026 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+KiAvpD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B74340A57
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133334; cv=none; b=Yppi6l50owkZprAonS5Iw0Dh6zUXQ/vx0wjZcH3MebXX7Zu+vqM12ficev9RJ1hWTjcYROLKXKTayxc28gyhy5OtVOSyksVXQr7Q4C7SzBxDTNFuE4XpiB3yHHKdd8O2Bs8at0D2JSNF03xMEvdTF0QGsA4+3BSPilAHNnjfmvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133334; c=relaxed/simple;
	bh=Qzc6XlD+IcLE+qx7WW74mIng+TY9esDEoy6PaE14NPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvTXkVVj0XgoLWd1TSCGO/euQ66YtNhXwsKMDJczKVz1aqkSyhjTncARf47y6LgADcEwhMes1hS/he6PCnyS8DiBBG9ZXsvQCcIzS0vyUztVnGVd2J9+PZK+KPmpki7cYIHTZ+IQ8xj02rZtg2qtWbQF1CbMe8wdi5RIyjPCXRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+KiAvpD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4358fb60802so613964f8f.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 07:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770133331; x=1770738131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8mRvLOCNLqjVmjiKjh0H9exGu/p/pcpVAXu1Cdl+14Q=;
        b=H+KiAvpDPOLx8mqfEYbo7O6nqTeXEv46WcWDVUvrWPs4455vMENkYEUFy7D7wTNyZn
         /igwWoYUADhVnsp7XGIQbusaV5ywZ/spoak2Bnl2n0qKGiYgthv0+/z/385TLDJEugMO
         tAZwy5Mb75Fi4ZZdpWp7HcfTRZH91vgCJSA03Ryv07273+Q/TSD2xv2Xicv+gJV95ZQ1
         R726ynnOvNevbbuLCGpcvlpluf/Zp/iQ6NdMc0H7UTJcsPrTpN4aAFdv1FNFs3VtXY9P
         /A7AIMvfZH6n0br6AvFboV8N+cSc0y/gujkJjjgsK9UownSX7O0+fnJCTB98bnaLGnEO
         crLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770133331; x=1770738131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mRvLOCNLqjVmjiKjh0H9exGu/p/pcpVAXu1Cdl+14Q=;
        b=v7nB8vl1QKUQjHqkEtQbQC6ff+Lpuu8kfq3QEOPYgr+hGqmi4Vkxg/5oyp3gMgJnJ2
         hIqWCUgj1nW/5EfA9fYPwOcPZt1JLWWA7H8WcUTcfi7BYcpqc4/djr5whmXjvff+Qk1h
         cFBRrmOHXdKTEPA+2ZhQVRkyWFq2wQMjwrJvaANpO2gcKWtXE2xCG7DAM1YrLbrUXcHF
         CKXDfhJ9v2pamLtp1QhVFqj4Y8EeryubtU2oEEMX9/r2QPn71PrEc3WffPFAR6aEfumI
         YIOrO3sSh3D67Af0iiJqgKS8E3jyTXC/QJCE1M6lAJfWpIz6Q5AFHJjS+3eDMZ70cZih
         i/4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRh7uoTNzZRk+9BUEkdnIh1L6T7wBjbCjkV21VJRbOnyiToiYxmFMUJSihAGGiMH6Ldo2uG04=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBfbg4uCOdjm8uWvCfNCWRQNDBDBfhi72xcDLV9HrhClzvdm1o
	0DHkmgFSVJ1+3hbqJd49BSr5wwQEGeSB8cxK1zp55v0F/+Hc6Beh4VmG
X-Gm-Gg: AZuq6aJgRY8amDDlHOfGthdSuVFm7k1eZ5BOqEcY7bXE5dz01KIn1LYgUwJJy18fxYW
	BEcqnbF/E8Xsd+fDSvfQm/WJN6A30M9xB6D+ddJPhMxY9qQJFu5+nlz5KTRhM2fehRFHC16qKwU
	O/BQCQq9aolnSz7H79YsNbgJ9DD8qMvZ6fVSvVk1JK5+MoIcGByABmKBRxp8vvc6Itbgc9dQowi
	OqDXLqKJY0+GuGSlTYLYtP7eOEsIIRz1iR7XO2oeo6SN1VqYFyih0hNby+lsffmL7CM4oZvvAZe
	1Qlw5ZcuiuNph7YlO+pIusAezJnKJBYuc0CKmZrFUEX0qm08jAMavQYHCkeoFIVG9FQxkUVh9FU
	hhh1l/XzUJmkBoK+jsStteh3Uo0/uYmKCcY231T/KTVTbTfFdvQM2LmPI361PhQwQTBTKj8a9f4
	jOjnlxHHiiGL0WTYtgrVXZLDE1
X-Received: by 2002:a05:6000:2dc5:b0:435:bcbd:cb29 with SMTP id ffacd0b85a97d-436113099b6mr5919152f8f.2.1770133330387;
        Tue, 03 Feb 2026 07:42:10 -0800 (PST)
Received: from [192.168.0.7] ([86.124.200.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4757sm54954039f8f.5.2026.02.03.07.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 07:42:10 -0800 (PST)
Message-ID: <ea2434e6-d1db-4ea2-90f4-0a77961b7918@gmail.com>
Date: Tue, 3 Feb 2026 17:42:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: stmmac: provide flag to disable EEE
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Clark Wang <xiaoning.wang@nxp.com>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 "David S. Miller" <davem@davemloft.net>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, imx@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Oleksij Rempel <o.rempel@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Stefan Klug <stefan.klug@ideasonboard.com>,
 Wei Fang <wei.fang@nxp.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <E1vNUjC-0000000FhjR-0h6P@rmk-PC.armlinux.org.uk>
 <f95f73b9-d024-4697-bca1-02fb8bc044af@gmail.com>
 <aYEj8VM5AfvcDHrl@shell.armlinux.org.uk>
Content-Language: en-US
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
In-Reply-To: <aYEj8VM5AfvcDHrl@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256339-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,nxp.com,ideasonboard.com,davemloft.net,gmail.com,google.com,lists.linux.dev,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,pengutronix.de,redhat.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ovidiupanaitoss@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2DB3DB811
X-Rspamd-Action: no action


Hi Russell,

On 2/3/26 12:23 AM, Russell King (Oracle) wrote:
> On Mon, Feb 02, 2026 at 08:54:52PM +0200, Ovidiu Panait wrote:
>>
>> Hi Russell,
>>
>> On 11/24/25 1:27 PM, Russell King (Oracle) wrote:
>>> Some platforms have problems when EEE is enabled, and thus need a way
>>> to disable stmmac EEE support. Add a flag before the other LPI related
>>> flags which tells stmmac to avoid populating the phylink LPI
>>> capabilities, which causes phylink to call phy_disable_eee() for any
>>> PHY that is attached to the affected phylink instance.
>>>
>>> iMX8MP is an example - the lpi_intr_o signal is wired to an OR gate
>>> along with the main dwmac interrupts. Since lpi_intr_o is synchronous
>>> to the receive clock domain, and takes four clock cycles to clear, this
>>> leads to interrupt storms as the interrupt remains asserted for some
>>> time after the LPI control and status register is read.
>>>
>>> This problem becomes worse when the receive clock from the PHY stops
>>> when the receive path enters LPI state - which means that lpi_intr_o
>>> can not deassert until the clock restarts. Since the LPI state of the
>>> receive path depends on the link partner, this is out of our control.
>>> We could disable RX clock stop at the PHY, but that doesn't get around
>>> the slow-to-deassert lpi_intr_o mentioned in the above paragraph.
>>>
>>> Previously, iMX8MP worked around this by disabling gigabit EEE, but
>>> this is insufficient - the problem is also visible at 100M speeds,
>>> where the receive clock is slower.
>>>
>>> There is extensive discussion and investigation in the thread linked
>>> below, the result of which is summarised in this commit message.
>>>
>>
>> We are seeing the same lpi_intr_o interrupt storm on the Renesas RZ/V2H
>> EVK (dwmac-renesas-gbeth.c). On this platform, lpi_intr_o is routed as a
>> separate, dedicated interrupt line to the CPU rather than being OR'd
>> with the main DWMAC interrupt as on iMX8MP. This corresponds to the
>> "eth_lpi" interrupt in the stmmac bindings:
>> """
>> - description: The interrupt that occurs when Rx exits the LPI state
>> const: eth_lpi
>> """
>>
>> Looking through the other glue drivers/device-trees, it looks to me that
>> every platform that defines a separate "eth_lpi" irq might have the
>> interrupt storm problem.
> 
> That is highly likely.
> 
>> To fix this issue on these platforms, rather than disabling EEE
>> altogether, would it be possible to just not request the eth_lpi
>> interrupt and let EEE continue to work? Perhaps a new flag could let
>> each platform decide.
> 
> Yes, because lpi_intr_o serves no purpose from a software point of
> view - see the commit message below for the details. I do like
> removing code from stmmac :)
> 
>> If not, maybe this patch could be merged to add the flag that disables
>> EEE and I will just send a patch to disable EEE on our platforms as well.
> 
> We still need the flag to disable EEE for platforms where lpi_intr_o is
> logically OR'd with the other interrupts, so there's no way to ignore
> its persistent assertion.
> 
> 8<===
> From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> Subject: [PATCH net-next] net: stmmac: remove support for lpi_intr_o
> 
> The dwmac databook for v3.74a states that lpi_intr_o is a sideband
> signal which should be used to ungate the application clock, and this
> signal is synchronous to the receive clock. The receive clock can run
> at 2.5, 25 or 125MHz depending on the media speed, and can stop under
> the control of the link partner. This means that the time it takes to
> clear is dependent on the negotiated media speed, and thus can be 8,
> 40, or 400ns after reading the LPI control and status register.
> 
> It has been observed with some aggressive link partners, this clock
> can stop while lpi_intr_o is still asserted, meaning that the signal
> remains asserted for an indefinite period that the local system has
> no direct control over.
> 
> The LPI interrupts will still be signalled through the main interrupt
> path in any case, and this path is not dependent on the receive clock.
> 
> This, since we do not gate the application clock, and the chances of
> adding clock gating in the future are slim due to the clocks being
> ill-defined, lpi_intr_o serves no useful purpose. Remove the code which
> requests the interrupt, and all associated code.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks for fixing this. I did some testing on the Renesas RZ/V2H board
with this patch and didn't see any issues:

Tested-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Ovidiu

> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h  |  1 -
>  .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 ---
>  .../ethernet/stmicro/stmmac/dwmac-loongson.c  |  7 ----
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 --
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 36 -------------------
>  .../ethernet/stmicro/stmmac/stmmac_platform.c |  8 -----
>  include/linux/stmmac.h                        |  1 -
>  7 files changed, 59 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> index 1c5a4af85b58..d26e8a063022 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -394,7 +394,6 @@ enum request_irq_err {
>  	REQ_IRQ_ERR_SFTY,
>  	REQ_IRQ_ERR_SFTY_UE,
>  	REQ_IRQ_ERR_SFTY_CE,
> -	REQ_IRQ_ERR_LPI,
>  	REQ_IRQ_ERR_WOL,
>  	REQ_IRQ_ERR_MAC,
>  	REQ_IRQ_ERR_NO,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> index aad1be1ec4c1..92d77b0c2f54 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> @@ -719,7 +719,6 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
>  
>  	/* Setup MSI vector offset specific to Intel mGbE controller */
>  	plat->msi_mac_vec = 29;
> -	plat->msi_lpi_vec = 28;
>  	plat->msi_sfty_ce_vec = 27;
>  	plat->msi_sfty_ue_vec = 26;
>  	plat->msi_rx_base_vec = 0;
> @@ -1177,8 +1176,6 @@ static int stmmac_config_multi_msi(struct pci_dev *pdev,
>  		res->irq = pci_irq_vector(pdev, plat->msi_mac_vec);
>  	if (plat->msi_wol_vec < STMMAC_MSI_VEC_MAX)
>  		res->wol_irq = pci_irq_vector(pdev, plat->msi_wol_vec);
> -	if (plat->msi_lpi_vec < STMMAC_MSI_VEC_MAX)
> -		res->lpi_irq = pci_irq_vector(pdev, plat->msi_lpi_vec);
>  	if (plat->msi_sfty_ce_vec < STMMAC_MSI_VEC_MAX)
>  		res->sfty_ce_irq = pci_irq_vector(pdev, plat->msi_sfty_ce_vec);
>  	if (plat->msi_sfty_ue_vec < STMMAC_MSI_VEC_MAX)
> @@ -1294,7 +1291,6 @@ static int intel_eth_pci_probe(struct pci_dev *pdev,
>  	 */
>  	plat->msi_mac_vec = STMMAC_MSI_VEC_MAX;
>  	plat->msi_wol_vec = STMMAC_MSI_VEC_MAX;
> -	plat->msi_lpi_vec = STMMAC_MSI_VEC_MAX;
>  	plat->msi_sfty_ce_vec = STMMAC_MSI_VEC_MAX;
>  	plat->msi_sfty_ue_vec = STMMAC_MSI_VEC_MAX;
>  	plat->msi_rx_base_vec = STMMAC_MSI_VEC_MAX;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index ed0b534d8d7b..d66ae6ea4df5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -442,13 +442,6 @@ static int loongson_dwmac_dt_config(struct pci_dev *pdev,
>  		res->wol_irq = res->irq;
>  	}
>  
> -	res->lpi_irq = of_irq_get_byname(np, "eth_lpi");
> -	if (res->lpi_irq < 0) {
> -		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
> -		ret = -ENODEV;
> -		goto err_put_node;
> -	}
> -
>  	ret = device_get_phy_mode(&pdev->dev);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "phy_mode not found\n");
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 012b0a477255..aafd8c39be63 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -31,7 +31,6 @@ struct stmmac_resources {
>  	void __iomem *addr;
>  	u8 mac[ETH_ALEN];
>  	int wol_irq;
> -	int lpi_irq;
>  	int irq;
>  	int sfty_irq;
>  	int sfty_ce_irq;
> @@ -297,7 +296,6 @@ struct stmmac_priv {
>  	int wol_irq;
>  	u32 gmii_address_bus_config;
>  	struct timer_list eee_ctrl_timer;
> -	int lpi_irq;
>  	u32 tx_lpi_timer;
>  	bool tx_lpi_clk_stop;
>  	bool eee_enabled;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7a451ae19f50..7925575fb348 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3734,10 +3734,6 @@ static void stmmac_free_irq(struct net_device *dev,
>  			free_irq(priv->sfty_ce_irq, dev);
>  		fallthrough;
>  	case REQ_IRQ_ERR_SFTY_CE:
> -		if (priv->lpi_irq > 0 && priv->lpi_irq != dev->irq)
> -			free_irq(priv->lpi_irq, dev);
> -		fallthrough;
> -	case REQ_IRQ_ERR_LPI:
>  		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
>  			free_irq(priv->wol_irq, dev);
>  		fallthrough;
> @@ -3795,24 +3791,6 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>  		}
>  	}
>  
> -	/* Request the LPI IRQ in case of another line
> -	 * is used for LPI
> -	 */
> -	if (priv->lpi_irq > 0 && priv->lpi_irq != dev->irq) {
> -		int_name = priv->int_name_lpi;
> -		sprintf(int_name, "%s:%s", dev->name, "lpi");
> -		ret = request_irq(priv->lpi_irq,
> -				  stmmac_mac_interrupt,
> -				  0, int_name, dev);
> -		if (unlikely(ret < 0)) {
> -			netdev_err(priv->dev,
> -				   "%s: alloc lpi MSI %d (error: %d)\n",
> -				   __func__, priv->lpi_irq, ret);
> -			irq_err = REQ_IRQ_ERR_LPI;
> -			goto irq_error;
> -		}
> -	}
> -
>  	/* Request the common Safety Feature Correctible/Uncorrectible
>  	 * Error line in case of another line is used
>  	 */
> @@ -3952,19 +3930,6 @@ static int stmmac_request_irq_single(struct net_device *dev)
>  		}
>  	}
>  
> -	/* Request the IRQ lines */
> -	if (priv->lpi_irq > 0 && priv->lpi_irq != dev->irq) {
> -		ret = request_irq(priv->lpi_irq, stmmac_interrupt,
> -				  IRQF_SHARED, dev->name, dev);
> -		if (unlikely(ret < 0)) {
> -			netdev_err(priv->dev,
> -				   "%s: ERROR: allocating the LPI IRQ %d (%d)\n",
> -				   __func__, priv->lpi_irq, ret);
> -			irq_err = REQ_IRQ_ERR_LPI;
> -			goto irq_error;
> -		}
> -	}
> -
>  	/* Request the common Safety Feature Correctible/Uncorrectible
>  	 * Error line in case of another line is used
>  	 */
> @@ -7752,7 +7717,6 @@ static int __stmmac_dvr_probe(struct device *device,
>  
>  	priv->dev->irq = res->irq;
>  	priv->wol_irq = res->wol_irq;
> -	priv->lpi_irq = res->lpi_irq;
>  	priv->sfty_irq = res->sfty_irq;
>  	priv->sfty_ce_irq = res->sfty_ce_irq;
>  	priv->sfty_ue_irq = res->sfty_ue_irq;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 8979a50b5507..5c9fd91a1db9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -725,14 +725,6 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
>  		stmmac_res->wol_irq = stmmac_res->irq;
>  	}
>  
> -	stmmac_res->lpi_irq =
> -		platform_get_irq_byname_optional(pdev, "eth_lpi");
> -	if (stmmac_res->lpi_irq < 0) {
> -		if (stmmac_res->lpi_irq == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> -		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
> -	}
> -
>  	stmmac_res->sfty_irq =
>  		platform_get_irq_byname_optional(pdev, "sfty");
>  	if (stmmac_res->sfty_irq < 0) {
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 5199451dd0bc..2620f0217f88 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -300,7 +300,6 @@ struct plat_stmmacenet_data {
>  	int int_snapshot_num;
>  	int msi_mac_vec;
>  	int msi_wol_vec;
> -	int msi_lpi_vec;
>  	int msi_sfty_ce_vec;
>  	int msi_sfty_ue_vec;
>  	int msi_rx_base_vec;


