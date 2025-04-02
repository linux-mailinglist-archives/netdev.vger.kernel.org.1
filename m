Return-Path: <netdev+bounces-178796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12205A78F0A
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C505B7A372C
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB2324167B;
	Wed,  2 Apr 2025 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UFpZgsLj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E923D23BCE7;
	Wed,  2 Apr 2025 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743598089; cv=none; b=YGunlsKyuW2pcWK1R7xfMUUVtjF0fYrM1wy0eIjLU0kfykUbZDIdmrxYbrEqXRINUaZrnIDlwmvGdmetA/oG48A4DWa1Rd18V/d7DrugGSe4ymtKtCarIKVzsgFDI3aDjmgleVelwwX6sOx1tGa9hV9fOXzxMk05VXJNKp6o47E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743598089; c=relaxed/simple;
	bh=ZbrgI1QMiyPzXZtbXyqIrXqGXB55hdcp4jkmMe1pbUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1YUHZApkZTIiTdq2laLdCyq7lWgB+YZ4xPWEI22oPUJl3Cyvkv7KJn3E8Ux0n5UKa6EVPx+NySoQueOG6NM2dYNjaPPaCqAn9jSUkNKPSN1QunFIGs88pzfwSnzliRqMGbOQBBNsXb40sfRLomW5jbIPusbrs/dDR7IiQYQLwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UFpZgsLj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yibjlCzMj7db36Ncl+n+k08WtHR8TCTohVRGWqYmZg0=; b=UFpZgsLjYa47uMUX+kbAWXcqXj
	EAXRsVbFGjyOEQDht4LLsjdX2i6zX1P/detZLCGKl4B2bZqBP3vuGsDj76g6F2j2Je6VWPDl7nVYP
	UatDa/505MPVEy3wGGZrB+COxlRk+tMXa/YhSgMarkAYW4y/gXTQkgS/PzfN31YyzEdo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tzxVc-007n1N-8p; Wed, 02 Apr 2025 14:47:56 +0200
Date: Wed, 2 Apr 2025 14:47:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lukasz Majewski <lukma@denx.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] net: mtip: The L2 switch driver for imx287
Message-ID: <8f431197-474e-4cd5-9c3e-d573c3f3e6b5@lunn.ch>
References: <20250331103116.2223899-1-lukma@denx.de>
 <20250331103116.2223899-5-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331103116.2223899-5-lukma@denx.de>

> +static void read_atable(struct switch_enet_private *fep, int index,
> +			unsigned long *read_lo, unsigned long *read_hi)
> +{
> +	unsigned long atable_base = (unsigned long)fep->hwentry;
> +
> +	*read_lo = readl((const void *)atable_base + (index << 3));
> +	*read_hi = readl((const void *)atable_base + (index << 3) + 4);
> +}
> +
> +static void write_atable(struct switch_enet_private *fep, int index,
> +			 unsigned long write_lo, unsigned long write_hi)
> +{
> +	unsigned long atable_base = (unsigned long)fep->hwentry;
> +
> +	writel(write_lo, (void *)atable_base + (index << 3));
> +	writel(write_hi, (void *)atable_base + (index << 3) + 4);
> +}

It would be nice to have the mtip_ prefix on all functions.

> +static int mtip_open(struct net_device *dev)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	int ret, port_idx = priv->portnum - 1;
> +
> +	if (fep->usage_count == 0) {
> +		clk_enable(fep->clk_ipg);
> +		netif_napi_add(dev, &fep->napi, mtip_rx_napi);
> +
> +		ret = mtip_alloc_buffers(dev);
> +		if (ret)
> +			return ret;

nitpick: You might want to turn the clock off before returning the
error.

> +	}
> +
> +	fep->link[port_idx] = 0;
> +
> +	/* Probe and connect to PHY when open the interface, if already
> +	 * NOT done in the switch driver probe (or when the device is
> +	 * re-opened).
> +	 */
> +	ret = mtip_mii_probe(dev);
> +	if (ret) {
> +		mtip_free_buffers(dev);

I've not checked. Does this do the opposite of netif_napi_add()?

> +static void mtip_set_multicast_list(struct net_device *dev)
> +{
> +	unsigned int i, bit, data, crc;
> +
> +	if (dev->flags & IFF_PROMISC) {
> +		dev_info(&dev->dev, "%s: IFF_PROMISC\n", __func__);

You can save one level of indentation with a return here.

> +	} else {
> +		if (dev->flags & IFF_ALLMULTI) {
> +			dev_info(&dev->dev, "%s: IFF_ALLMULTI\n", __func__);

and other level here.

> +		} else {
> +			struct netdev_hw_addr *ha;
> +			u_char *addrs;
> +
> +			netdev_for_each_mc_addr(ha, dev) {
> +				addrs = ha->addr;
> +				/* Only support group multicast for now */
> +				if (!(*addrs & 1))
> +					continue;

You could pull there CRC caluclation out into a helper. You might also
want to search the tree and see if it exists somewhere else.

> +
> +				/* calculate crc32 value of mac address */
> +				crc = 0xffffffff;
> +
> +				for (i = 0; i < 6; i++) {

Is 6 the lengh of a MAC address? There is a #define for that.

> +					data = addrs[i];
> +					for (bit = 0; bit < 8;
> +					     bit++, data >>= 1) {
> +						crc = (crc >> 1) ^
> +						(((crc ^ data) & 1) ?
> +						CRC32_POLY : 0);
> +					}
> +				}
> +			}
> +		}
> +	}
> +}
> +

> +struct switch_enet_private *mtip_netdev_get_priv(const struct net_device *ndev)
> +{
> +	if (ndev->netdev_ops == &mtip_netdev_ops)
> +		return netdev_priv(ndev);
> +
> +	return NULL;
> +}
> +

> +static int __init mtip_switch_dma_init(struct switch_enet_private *fep)
> +{
> +	struct cbd_t *bdp, *cbd_base;
> +	int ret, i;
> +
> +	/* Check mask of the streaming and coherent API */
> +	ret = dma_set_mask_and_coherent(&fep->pdev->dev, DMA_BIT_MASK(32));
> +	if (ret < 0) {
> +		dev_warn(&fep->pdev->dev, "No suitable DMA available\n");

Can you recover from this? Or should it be dev_err()?

More later...

	Andrew

