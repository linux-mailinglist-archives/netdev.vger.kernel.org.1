Return-Path: <netdev+bounces-249989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A233AD220C2
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 02:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98FCA301B672
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 01:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8DE24A04A;
	Thu, 15 Jan 2026 01:41:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F27B23815B;
	Thu, 15 Jan 2026 01:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768441264; cv=none; b=lSfR6OpJ56tIE8sUQAXf+XVJqF9Fq7MfWP/KBRfOXptbM54f+0/sxUEyp5YIoHU9boF0+VVmmDbqE2BJTRphmN/YfBp6EIv6V/nY6Ay/yf2NRKw6nA2Hb48oSKBFRXmkQCp6lhjUtOAtcDgtBNMzQj9gWV02xpSrbmi1L10MqZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768441264; c=relaxed/simple;
	bh=otwVYL7nOtrDHHkGJjmQ15xUyz53dvMV7ILy5SSUP2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H38uJGRNCdgF55gOdjUPtsdp5soPHED7997y0XViC4FmijQMGcvMRxZnhbEPLhU43EwSNBgiL48L9/Xw0JfaTR10Pj3ho8JMiAWjmOqOnnybQJbPshcgxwKh1i3zN9He1afhfQ9rdThMReSK3c2YegpLF5YB2116z1GzE6gqyP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vgCM1-000000002A3-223U;
	Thu, 15 Jan 2026 01:40:53 +0000
Date: Thu, 15 Jan 2026 01:40:50 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chen Minqiang <ptpt52@gmail.com>, Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: Re: [PATCH net-next v2 3/6] net: dsa: lantiq: allow arbitrary MII
 registers
Message-ID: <aWhFohyjEnaIeHSS@makrotopia.org>
References: <cover.1768438019.git.daniel@makrotopia.org>
 <572c7d91f8eb97bd72584018f9b5941dbfb2e46e.1768438019.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572c7d91f8eb97bd72584018f9b5941dbfb2e46e.1768438019.git.daniel@makrotopia.org>

On Thu, Jan 15, 2026 at 12:57:07AM +0000, Daniel Golle wrote:
> The Lantiq GSWIP and MaxLinear GSW1xx drivers are currently relying on a
> hard-coded mapping of MII ports to their respective MII_CFG and MII_PCDU
> registers and only allow applying an offset to the port index.
> 
> While this is sufficient for the currently supported hardware, the very
> similar Intel GSW150 (aka. Lantiq PEB7084) cannot be described using
> this arrangement.
> 
> Introduce two arrays to specify the MII_CFG and MII_PCDU registers for
> each port, replacing the current bitmap used to safeguard MII ports as
> well as the port index offset.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2:
>  * introduce GSWIP_MAX_PORTS macro
> 
>  drivers/net/dsa/lantiq/lantiq_gswip.c        | 30 ++++++++++++++++----
>  drivers/net/dsa/lantiq/lantiq_gswip.h        |  6 ++--
>  drivers/net/dsa/lantiq/lantiq_gswip_common.c | 27 +++---------------
>  drivers/net/dsa/lantiq/mxl-gsw1xx.c          | 30 ++++++++++++++++----
>  4 files changed, 56 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.c b/drivers/net/dsa/lantiq/lantiq_gswip.c
> index b094001a7c805..4a1be6a1df6fe 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip.c
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip.c
> @@ -463,10 +463,20 @@ static void gswip_shutdown(struct platform_device *pdev)
>  }
>  
>  static const struct gswip_hw_info gswip_xrx200 = {
> -	.max_ports = 7,
> +	.max_ports = GSWIP_MAX_PORTS,
>  	.allowed_cpu_ports = BIT(6),
> -	.mii_ports = BIT(0) | BIT(1) | BIT(5),
> -	.mii_port_reg_offset = 0,
> +	.mii_cfg = {
> +		[0 ... GSWIP_MAX_PORTS - 1] = -1,
> +		[0] = GSWIP_MII_CFGp(0),
> +		[1] = GSWIP_MII_CFGp(1),
> +		[5] = GSWIP_MII_CFGp(5),
> +	},

Kernel CI trips with
warning: initialized field overwritten [-Woverride-init]

Would it be ok to enclose the gswip_hw_info initializers with
__diag_push();
__diag_ignore_all("-Woverride-init",
		  "logic to initialize all and then override some is OK");

like it is done in drivers/net/ethernet/renesas/sh_eth.c?

Or should I rather keep the .mii_ports bitmap in addition to the array
to indicate the indexes with valid values?

