Return-Path: <netdev+bounces-213385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2507B24D1A
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147E63A3E98
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B942F83B4;
	Wed, 13 Aug 2025 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="L6UQnLWY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCEB2E54C3;
	Wed, 13 Aug 2025 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097901; cv=none; b=hPwNnqX9FpZAnDhQGvRrFVFhhkQjj6jzjII4ND59hcU+T+pftr0bnkENYlAqqq8wSDjLgyUGuwgDePtceuwQrsk9IHsydZgJdiDCxCo4HBgMkjcF8trrSH+QEUtKr/kcTbxoLP59ed5nNIADMUNQTH33A9VSyXG72VHaAFYJ1mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097901; c=relaxed/simple;
	bh=2yskElXrJjNSFbolXxtSWkQFTJIr/Kri1xcUA4o5Qzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2xFYX9a/nrxCeNwi5eC31PAEpcjGnNrzOjFn/4TtgLwoH839U/tAZYX3yj9VQS/YEzUGtlLZPZ7dK6/Hm7APmdEScf+dffns2vHGetDe12CEJnBQKVbtHUueDTNHG6MILTH9bRX1/TLoh0dwl33fZ+f9yrecvywY4YnmDmKuts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=L6UQnLWY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LMlJoJUN3z4TOoymhV2DtpiX1kn0KKwfF8qPS2pcmHU=; b=L6UQnLWYrMlrHVT3n8xXDG3ugN
	clQ5In+uwWVsNFgc44r3T6JBSoeithf5pdO5bYJGi1SNHXSa859qL48xo4P+WGC8oTKTZ+S1cKZsx
	R0s06h2ClWJrEkADXDVw+O2g2EWybz1HUf/XWR0qkCz4qX1VsC0OJw6rYh1bZqibWYazJDjG+7yYu
	WUm0nDmFWiDSLyB8XwL7NoKWhfKQ9yCfF9H9BFhfQDjb3A3kwqrChLNB6gvVDaTmQeVqzk4B1VoG/
	WVnrLBoGPUthcPiu19DKeUP9pZZmkJr71epoNgBMUw/1Rax1GMKOjyp5W5wnNFG/Kj5vZkAaJeMs5
	z2SpHfyA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35072)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1umD8L-0006tD-0T;
	Wed, 13 Aug 2025 16:11:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1umD8C-0005rA-2x;
	Wed, 13 Aug 2025 16:11:12 +0100
Date: Wed, 13 Aug 2025 16:11:12 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH net-next v2 02/10] net: stmmac: Add support for Allwinner
 A523 GMAC200
Message-ID: <aJyrECCOPTZP81Sx@shell.armlinux.org.uk>
References: <20250813145540.2577789-1-wens@kernel.org>
 <20250813145540.2577789-3-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813145540.2577789-3-wens@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

A few comments on this...

On Wed, Aug 13, 2025 at 10:55:32PM +0800, Chen-Yu Tsai wrote:
> +#include "stmmac.h"
> +#include "stmmac_platform.h"
> +
> +#define SYSCON_REG		0x34
> +
> +/* RMII specific bits */
> +#define SYSCON_RMII_EN		BIT(13) /* 1: enable RMII (overrides EPIT) */
> +/* Generic system control EMAC_CLK bits */
> +#define SYSCON_ETXDC_MASK		GENMASK(12, 10)
> +#define SYSCON_ERXDC_MASK		GENMASK(9, 5)
> +/* EMAC PHY Interface Type */
> +#define SYSCON_EPIT			BIT(2) /* 1: RGMII, 0: MII */
> +#define SYSCON_ETCS_MASK		GENMASK(1, 0)
> +#define SYSCON_ETCS_MII		0x0
> +#define SYSCON_ETCS_EXT_GMII	0x1
> +#define SYSCON_ETCS_INT_GMII	0x2
> +
> +#define MASK_TO_VAL(mask)   ((mask) >> (__builtin_ffsll(mask) - 1))

Is FIELD_GET() not sufficient?

> +
> +static int sun55i_gmac200_set_syscon(struct device *dev,
> +				     struct plat_stmmacenet_data *plat)
> +{
> +	struct device_node *node = dev->of_node;
> +	struct regmap *regmap;
> +	u32 val, reg = 0;
> +	int ret;
> +
> +	regmap = syscon_regmap_lookup_by_phandle(node, "syscon");
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "Unable to map syscon\n");
> +
> +	if (!of_property_read_u32(node, "tx-internal-delay-ps", &val)) {
> +		if (val % 100)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "tx-delay must be a multiple of 100\n");

	"tx-delay must be a multiple of 100ps\n"

would be a bit better.

> +		val /= 100;
> +		dev_dbg(dev, "set tx-delay to %x\n", val);
> +		if (val > MASK_TO_VAL(SYSCON_ETXDC_MASK))
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid TX clock delay: %d\n",
> +					     val);

		if (!FIELD_FIT(SYSCON_ETXDC_MASK, val))
			return dev_err_probe(dev, -EINVAL,
					    "TX clock delay exceeds maximum (%d00ps > %d00ps)\n",
					    val, FIELD_MAX(SYSCON_ETXDC_MASK));

> +
> +		reg |= FIELD_PREP(SYSCON_ETXDC_MASK, val);
> +	}
> +
> +	if (!of_property_read_u32(node, "rx-internal-delay-ps", &val)) {
> +		if (val % 100)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "rx-delay must be a multiple of 100\n");
> +		val /= 100;
> +		dev_dbg(dev, "set rx-delay to %x\n", val);
> +		if (val > MASK_TO_VAL(SYSCON_ERXDC_MASK))
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid RX clock delay: %d\n",
> +					     val);

all the same points in this block.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

