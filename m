Return-Path: <netdev+bounces-201515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FC9AE9A53
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E473A5B26
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 09:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBA52BD01A;
	Thu, 26 Jun 2025 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a83gXHvo"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E87A15539A;
	Thu, 26 Jun 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750930883; cv=none; b=PrnVDjmw58HToYXkx8ZiJ0UqwfCf/cmEQe5Jrl/q7Y+o3CTPgEtT3Rwo6orrn3o2Ulueke2sH4c7p2fkAw+WSOGJaKexsHkSlE6ZNp8yoLxglMkiqmNzPMMuMwNakOJFxZYwEsyaHz5hYJw9Exq1jk+dP+xOrrsNp2HmjIyGew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750930883; c=relaxed/simple;
	bh=zhRAEAp6CfRUkELZ88WpIQpghW2g7vON8T0ZWoFnEh0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNlmhu3Z5U6qxKPD27Tgo8KwEkcqos87dXi6RlSKG3udu41KiWQIsiZJDfAGM8Zt26yMyMqaR7XWUZDQdWORN74PALo3rZh8oHUKl+kU2yK4zHrufSG7+E66SbLVfYoByiA2HDdB5eqjSKRqq4b6AD5iziRvra8cNQ/o+unb0/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a83gXHvo; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55Q9eqhl2115910;
	Thu, 26 Jun 2025 04:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750930852;
	bh=iA/8SO2mGfVZC7bo0ZFuR79S7HLwYm6xuSgZaGNdeiM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=a83gXHvo1EAsgKkMTTOdCfZ7FG+dcLW6lnsxqrO3vv6KzDFjYYavD3BmGgdHuOFQ7
	 T7dABv2Yn0kS8PgiswWFN+rRYN+cBZ2+ksB+v5dAJYKmZhdYNnf95CDeMXDOxQ9i+S
	 gaiFno2pnCTsW33QChz7rI/BRsEsaS79G1cGgIM4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55Q9eqxZ2128746
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 26 Jun 2025 04:40:52 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 26
 Jun 2025 04:40:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 26 Jun 2025 04:40:51 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.169])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55Q9eodS789152;
	Thu, 26 Jun 2025 04:40:51 -0500
Date: Thu, 26 Jun 2025 15:10:50 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray
	<dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe
 Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
        Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Roger Quadros <rogerq@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux@ew.tq-group.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 2/3] net: ethernet: ti: am65-cpsw: fixup PHY
 mode for fixed RGMII TX delay
Message-ID: <54d6cd05-65ef-4e1d-8041-3e4a2c50b443@ti.com>
References: <cover.1750756583.git.matthias.schiffer@ew.tq-group.com>
 <9b3fb1fbf719bef30702192155c6413cd5de5dcf.1750756583.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9b3fb1fbf719bef30702192155c6413cd5de5dcf.1750756583.git.matthias.schiffer@ew.tq-group.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Jun 24, 2025 at 12:53:33PM +0200, Matthias Schiffer wrote:

Hello Matthias,

> All am65-cpsw controllers have a fixed TX delay, so the PHY interface
> mode must be fixed up to account for this.
> 
> Modes that claim to a delay on the PCB can't actually work. Warn people
> to update their Device Trees if one of the unsupported modes is specified.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 27 ++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index f20d1ff192efe..519757e618ad0 100644
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
>  		port->slave.port_np = of_node_get(port_np);
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

Existing users designed boards and enabled Ethernet functionality using
"rgmii-rxid" in the device-tree and implementing the PCB traces in a
way that they interpret "rgmii-rxid". So their (mis)interpretation of
it is being challenged by the series. While it is true that we are updating
the bindings and driver to move towards the correct definition, I believe that
the above message would cause confusion. Would it be alright to update it to
something similar to:

"Interpretation of RGMII delays has been corrected; no functional impact; please fix your Device Tree"

Regards,
Siddharth.

