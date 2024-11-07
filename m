Return-Path: <netdev+bounces-143093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02A99C11EE
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 23:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B00F01C22B48
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92478218954;
	Thu,  7 Nov 2024 22:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PVc2/FJb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347C221832F;
	Thu,  7 Nov 2024 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731019196; cv=none; b=BAq++jO3GkKimgpQTh3djNvIEAKPBLta8SzkvH5VGiXd21YUGENtCm8ACEDVZ+hyUCAldpDG5dxeA7VqKlhrA9S2D3wsPUl8CyQh7h79BfolhHndJs5CJCqES9eaACC9rjdWkX3njC4bsf9IVgpuooWf8M8+uzj5s36WFubU1KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731019196; c=relaxed/simple;
	bh=sxgbMkBFKUNy1t8BMonudBDXJ+VD40bSfbUqSSPTBbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgAboZMC0qJa05ZRVkt2tt24RZuxgBR883Qx0PaGurNX1O3nwC0B6mUWVa/BTX/8E1tFSlbDqZCdkDzE+ZjqROTiNme8AjC2XwxXy5dwvD/pCwme6tcG14F3lRlJwvP0pj3VP50kqKxxtbrz79jDkfyjgR9nBekUcCpPTFOrp5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PVc2/FJb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/ttKD2JDCoDptxDdNvZxe09sisTs9kAndANsW/SPTeA=; b=PVc2/FJbnnIVZfzKiosEU+z98F
	gktCgfnYSPaIom6AWSVBBcCmjffJWd3ApVDOfBVRL2IY686q0nApdagicSKh1qXmYtJYCKe3DHB8V
	pvdsNO5lTO5Jihdx7iKSaSvDC9wShIzWb999eAbq4UwpvV5r6997wO8OwlxeSzIcSgIc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t9BAC-00CWEw-Ll; Thu, 07 Nov 2024 23:39:40 +0100
Date: Thu, 7 Nov 2024 23:39:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Russell King <linux@armlinux.org.uk>, jacob.e.keller@intel.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 3/7] net: sparx5: use is_port_rgmii() throughout
Message-ID: <4748d3a9-55e8-48f9-b281-60ec619bf304@lunn.ch>
References: <20241106-sparx5-lan969x-switch-driver-4-v1-0-f7f7316436bd@microchip.com>
 <20241106-sparx5-lan969x-switch-driver-4-v1-3-f7f7316436bd@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106-sparx5-lan969x-switch-driver-4-v1-3-f7f7316436bd@microchip.com>

> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
> @@ -1087,6 +1087,9 @@ int sparx5_port_init(struct sparx5 *sparx5,
>  		 ANA_CL_FILTER_CTRL_FILTER_SMAC_MC_DIS,
>  		 sparx5, ANA_CL_FILTER_CTRL(port->portno));
>  
> +	if (ops->is_port_rgmii(port->portno))
> +		return 0;
> +
>  	/* Configure MAC vlan awareness */
>  	err = sparx5_port_max_tags_set(sparx5, port);
>  	if (err)

That looks odd. What has RGMII to do with MAC VLAN awareness?
Maybe it just needs a comment?

	Andrew

