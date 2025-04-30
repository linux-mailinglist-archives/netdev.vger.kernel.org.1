Return-Path: <netdev+bounces-187100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4646AA4F31
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4953A593C
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD971A254E;
	Wed, 30 Apr 2025 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4v+Q51D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FBCA921;
	Wed, 30 Apr 2025 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024997; cv=none; b=EklnKBAb89Vbvqxq3kCpRWmzGcJbdrZYPC/44tzdx351W6sXd4Va84q50Lekq05MatYokqQtWQiB3IBl5BD0dLzNSku7yg1FaqWCXdE0uZm2a97OUnRDkg+sBYU/RYFIB/OoItcfLnaoIzbKJ3p4ycvDpR3r+1NRWDXrPS6IJgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024997; c=relaxed/simple;
	bh=ZDhemFI3wk7+oKmCQPnnKPrmu3o0K0L437vtWpHD45Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5rAIOX4LN/bGzpwk9e1s0Vuc0RFGvTvG2uY0mXkKubHPbxoeLCECzbcH5uBwPGC+Z1r8oY0AACZdNyhTlGL0IkK0HrbQcC4iPJwAEYv0sqxMooJbsUF7j/GriNHTZV2zC/Dp6K5cXH/di34rmVmsnz+a5WWcCAXoCHidKYKe7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4v+Q51D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4615C4CEE7;
	Wed, 30 Apr 2025 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746024997;
	bh=ZDhemFI3wk7+oKmCQPnnKPrmu3o0K0L437vtWpHD45Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p4v+Q51DBosLKEYDP1xu8v1LSCpHW5tdNhk2McmtomzvDiGE0HFITW6RZ67nIetwg
	 nmhpIr8KxlRevmrSr7667phfz509ORcM73+MOb129oRrA3qM1WOvNmgTcFTSWMEkgu
	 SXLZnm5BAogrX/djef6MbfVMBjwIr4JjdxRNPCefxfqFZ3Lz+eJ6a92t1s3x/2+rt+
	 tUbyC/ZbXqJjDbqfX5VeeP2E/Sc7C+hWSfpmN3mlFMBnlJetbFLrWQo2Ae6OBOLsE0
	 00E1RG6nZNE07A8OWeejsGyGj7EW7KWj/jUkKJE8LubYQoOCVmC8exxzgel61ZpGdD
	 yF7WVZypse4zA==
Message-ID: <07c540a2-c645-460c-bfad-c9229d5d5ad0@kernel.org>
Date: Wed, 30 Apr 2025 17:56:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] net: ethernet: ti: am65-cpsw: fixup PHY mode
 for fixed RGMII TX delay
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>,
 Jonathan Corbet <corbet@lwn.net>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tero Kristo <kristo@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <32e0dffa7ea139e7912607a08e391809d7383677.1744710099.git.matthias.schiffer@ew.tq-group.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <32e0dffa7ea139e7912607a08e391809d7383677.1744710099.git.matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Matthias,

On 15/04/2025 13:18, Matthias Schiffer wrote:
> All am65-cpsw controllers have a fixed TX delay, so the PHY interface
> mode must be fixed up to account for this.
> 
> Modes that claim to a delay on the PCB can't actually work. Warn people
Could you please help me understand this statement? Which delay? TX or RX?

Isn't this patch forcing the device tree to have TX delay mentioned in it?

> to update their Device Trees if one of the unsupported modes is specified.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 27 ++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index c9fd34787c998..a1d32735c7512 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -2602,6 +2602,7 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
>  		return -ENOENT;
>  
>  	for_each_child_of_node(node, port_np) {
> +		phy_interface_t phy_if;
>  		struct am65_cpsw_port *port;
>  		u32 port_id;
>  
> @@ -2667,14 +2668,36 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
>  
>  		/* get phy/link info */
>  		port->slave.port_np = port_np;
> -		ret = of_get_phy_mode(port_np, &port->slave.phy_if);
> +		ret = of_get_phy_mode(port_np, &phy_if);
>  		if (ret) {
>  			dev_err(dev, "%pOF read phy-mode err %d\n",
>  				port_np, ret);
>  			goto of_node_put;
>  		}
>  
> -		ret = phy_set_mode_ext(port->slave.ifphy, PHY_MODE_ETHERNET, port->slave.phy_if);
> +		/* CPSW controllers supported by this driver have a fixed
> +		 * internal TX delay in RGMII mode. Fix up PHY mode to account
> +		 * for this and warn about Device Trees that claim to have a TX
> +		 * delay on the PCB.
> +		 */
> +		switch (phy_if) {
> +		case PHY_INTERFACE_MODE_RGMII_ID:
> +			phy_if = PHY_INTERFACE_MODE_RGMII_RXID;
> +			break;
> +		case PHY_INTERFACE_MODE_RGMII_TXID:
> +			phy_if = PHY_INTERFACE_MODE_RGMII;
> +			break;
> +		case PHY_INTERFACE_MODE_RGMII:
> +		case PHY_INTERFACE_MODE_RGMII_RXID:
> +			dev_warn(dev,
> +				 "RGMII mode without internal TX delay unsupported; please fix your Device Tree\n");
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		port->slave.phy_if = phy_if;
> +		ret = phy_set_mode_ext(port->slave.ifphy, PHY_MODE_ETHERNET, phy_if);
>  		if (ret)
>  			goto of_node_put;
>  

-- 
cheers,
-roger


