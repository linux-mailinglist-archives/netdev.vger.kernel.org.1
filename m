Return-Path: <netdev+bounces-111922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5082293424C
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 20:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0691D1F225D7
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 18:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B10B1836EC;
	Wed, 17 Jul 2024 18:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cB08LptQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB79718308C;
	Wed, 17 Jul 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721241012; cv=none; b=u3cpXRQxID5s6i0FX2YPgCNjE6idSg8wCFSjgP3NahaG7xgeIwQtsjXRJEyAVb23mKVxtdAc88hvTit7ox6Lp7zyXP/dwlVLobRMYo4Qz2TpIgTiYSKkUuES4WmGT0QX9gBHiTE4aTV1ZU3tiUh+6lncKouYLCyBAxux4PzUyBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721241012; c=relaxed/simple;
	bh=kkxQ7HDQIBOgCghWNEpPvkhCFxintxaexdFHp3ES4eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bT9ehE3zqTLQ8OrGWvikTxsZ14CXWJNK2uzzV8VbeiNiBkr7K7TeBOQLDYDbTwvzaSikScm746m6dYvi6DZTigkfK8nc/fROwrMjXVgNB7/cAZMeQAiaPwtDYyQsc5Sax1qg8TXuz5izPfqKrKiFpg81S5cuCvPAOHIFS/MJdjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cB08LptQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vyvpoyFR7feJO8PWlN6/naOB1Ri9E4IGyTVFrGgGsFc=; b=cB08LptQXHk682+unCwuzeszXL
	CslVP2oFXj7StRYdbdtKLAcfx6EzJR4avnbJMJ7dDjzuGHZdPVIyZs4Mgh9W2OCApVkSyPWl4FCp/
	Y3pyV1xjNf78dg8pokCT/45umktGqU+J2Oiwp0dbKDILiHR43ZYFqdDIPunlAin1oyZ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sU9Pd-002jG8-2l; Wed, 17 Jul 2024 20:30:01 +0200
Date: Wed, 17 Jul 2024 20:30:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: dsa: vsc73xx: make RGMII delays
 configurable
Message-ID: <97827b19-a747-4f4d-99e7-8c2bec3d5f0a@lunn.ch>
References: <20240716183735.1169323-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716183735.1169323-1-paweldembicki@gmail.com>

On Tue, Jul 16, 2024 at 08:37:34PM +0200, Pawel Dembicki wrote:
> This patch switches hardcoded RGMII transmit/receive delay to
> a configurable value. Delay values are taken from the properties of
> the CPU port: 'tx-internal-delay-ps' and 'rx-internal-delay-ps'.
> 
> The default value is configured to 2.0 ns to maintain backward
> compatibility with existing code.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
>  drivers/net/dsa/vitesse-vsc73xx-core.c | 68 ++++++++++++++++++++++++--
>  1 file changed, 64 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
> index d9d3e30fd47a..7d3c8176dff7 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> @@ -684,6 +684,67 @@ vsc73xx_update_vlan_table(struct vsc73xx *vsc, int port, u16 vid, bool set)
>  	return vsc73xx_write_vlan_table_entry(vsc, vid, portmap);
>  }
>  
> +static void vsc73xx_configure_rgmii_port_delay(struct dsa_switch *ds)
> +{
> +	/* Keep 2.0 ns delay for backward complatibility */
> +	u32 tx_delay = VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS;
> +	u32 rx_delay = VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS;
> +	struct dsa_port *dp = dsa_to_port(ds, CPU_PORT);
> +	struct device_node *port_dn = dp->dn;
> +	struct vsc73xx *vsc = ds->priv;
> +	u32 delay;
> +
> +	if (!of_property_read_u32(port_dn, "tx-internal-delay-ps", &delay)) {
> +		switch (delay) {
> +		case 0:
> +			tx_delay = VSC73XX_GMIIDELAY_GMII0_GTXDELAY_NONE;
> +			break;
> +		case 1400:
> +			tx_delay = VSC73XX_GMIIDELAY_GMII0_GTXDELAY_1_4_NS;
> +			break;
> +		case 1700:
> +			tx_delay = VSC73XX_GMIIDELAY_GMII0_GTXDELAY_1_7_NS;
> +			break;
> +		case 2000:
> +			break;
> +		default:
> +			dev_warn(vsc->dev,
> +				 "Unsupported RGMII Transmit Clock Delay, set to 2.0 ns\n");

I would suggest you make this dev_err() and return -EINVAL. The DT has
a real error in it which should be fixed.

> +			break;
> +		}
> +	} else {
> +		dev_info(vsc->dev,
> +			 "RGMII Transmit Clock Delay isn't configured, set to 2.0 ns\n");

This is for backwards compatibility. Do we need to spam the log? I
would say dev_dbg().

Same for RX please.

	Andrew

