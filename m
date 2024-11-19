Return-Path: <netdev+bounces-146340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B099D2F48
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 21:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D6C1F2438B
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 20:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1601D1E65;
	Tue, 19 Nov 2024 20:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="f+e0gTq0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BA21D0B8A;
	Tue, 19 Nov 2024 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732046925; cv=none; b=NRP95SWKminuJx7+aBLWxo7q+V/jqzDT1vBo79Vmn57GAZYOGJEZ46UtJ0jCTwwiYa36f5KJ/nFfK5qqt6P08L+98ct2B3qBcYUa2pJTdR/Cn762OtGUkZxNs45FUKr6mAaBVp9G/w3tQ/bd8BCdH7UAqF/gcFxxHnpi4kWOnRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732046925; c=relaxed/simple;
	bh=lLzg9+6eTjOhVoncCX1Vabji7fScA+C+fCESNgIGa+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmRfRXmJRtzkWbXkMK9+bAyBafX5hpYTH3Jp1/dqcQouvrXJnkp02CoRk8xPJ54irC0n939TCPySWRyDng1sQpQptYltHC3QJ2rqeEjkrPhIjfdKyoJw9AHIB1TdmRKjQQrPAqGH+0fa0mMfgSMsuOWoVH17qCpLN+ljPUaUbqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=f+e0gTq0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=M75wr+RtGR69btb4zt6e59/ZF6kWZbGMj4HSvNiWvzU=; b=f+e0gTq0vLIOgdCVVAy5MBA56G
	+oGx3wA072dSyK4Tp5LcqUgRzQqPHkpyv2Ma2mhVdCMwwmodTIXnF+NmETti+7WSnr40jH2PQ/NlJ
	2QscEibO6cdC85nZidaoFHBUUCGrULKLM/81tcA2qEFsUdEtQchnrISF6aXgfZLGIR6PB9eEm8Gmr
	wHiGc1xZv4/K4nCGZbdxRLpfegEGXYrRDGuILdFwJkJpTKRsjop4b/NxfGf4iBAuJTTHDKxp/gei9
	dl/PXC4Q0FJfSZkgY/3FgqF8XF2X5KkyiHcz1ng9VcDwHEljCqW5wjdVWANPgcWIHx4l7vTqoH9qS
	IXAhD9zQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38454)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tDUWO-0004Ky-2Z;
	Tue, 19 Nov 2024 20:08:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tDUWM-0006KU-05;
	Tue, 19 Nov 2024 20:08:22 +0000
Date: Tue, 19 Nov 2024 20:08:21 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	jacob.e.keller@intel.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 4/8] net: sparx5: use
 phy_interface_mode_is_rgmii()
Message-ID: <ZzzwNci1cHqsfHm4@shell.armlinux.org.uk>
References: <20241118-sparx5-lan969x-switch-driver-4-v3-0-3cefee5e7e3a@microchip.com>
 <20241118-sparx5-lan969x-switch-driver-4-v3-4-3cefee5e7e3a@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118-sparx5-lan969x-switch-driver-4-v3-4-3cefee5e7e3a@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

On Mon, Nov 18, 2024 at 02:00:50PM +0100, Daniel Machon wrote:
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c b/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c
> index f8562c1a894d..cb55e05e5611 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_phylink.c
> @@ -32,6 +32,9 @@ sparx5_phylink_mac_select_pcs(struct phylink_config *config,
>  {
>  	struct sparx5_port *port = netdev_priv(to_net_dev(config->dev));
>  
> +	if (phy_interface_mode_is_rgmii(interface))
> +		return NULL;
> +
>  	return &port->phylink_pcs;

Maybe turn this into positive logic - return the PCS only when the
interface mode requires the PCS?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

