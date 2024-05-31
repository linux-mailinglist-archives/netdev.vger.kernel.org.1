Return-Path: <netdev+bounces-99816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B9E8D695A
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 21:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C70F2B23002
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 19:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91BE219FD;
	Fri, 31 May 2024 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clO6WlOV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFE47C6C9;
	Fri, 31 May 2024 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182159; cv=none; b=f7f10Rz6J2mVZ050hGuNTabOSJX7GuaqP5rGi898A5mjbVgc2IA3cEnoMOhAQ/jC3PaH0bdhaTaCwPtuqnbx5yYpgHn5Dxm5pkPfnce/beseyw0+KVWoOjsxHKYnPEX9bBe58/JBp3AQxtWvGRURdAShoHySLhA4q+1fuR+XEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182159; c=relaxed/simple;
	bh=pCOmk1nKWaAgFuK1NF4rUoo/cWiU7vuNtYV5z/Eozdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwS1wwS9C43xPK+S4NBH333YYuGk7xxhi1+kGbs14/Z4Ktsxfe2VU3y7JqzgMJiQJc9jEoPXycYoxALjvBMpwO1CiFxvrT2TxxWD0tcl/Ws0FsItokqDATIdxHSKuS4YD1g8s63/8qG9mqn1n9fOmkEU+IK16+VYmqS0/VKA034=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clO6WlOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57582C116B1;
	Fri, 31 May 2024 19:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717182159;
	bh=pCOmk1nKWaAgFuK1NF4rUoo/cWiU7vuNtYV5z/Eozdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clO6WlOVUctdpP66XQRtk2+Sgb6XmJ2r2DY+DUD3cdtpCzCmxRwCP9kRTO7psEfyy
	 oN6OWIpUetQkcxNSLbJKNkk5w1w6tauzOJcBYjCf+VupXtdmA5pnwbu27UbqQ2Jmcs
	 KX0+s3+uDISsK9etAQnBWwvkUOh3vs/+WwVyu84w0j18kvDze4TfJjm22r92vKRJsA
	 6bXhYDs+16wceyJfw+HxY9/jcysSUtulZN/wFLUkH4G+g2LFz+jhOv5PXIwFIZezQe
	 6InCkwC55yVRMfO8FArNcSas1G9bVFBp94NxqjUX9/yswBaVlGDz0Dr6aO8dDkHhza
	 46J/3TxfmXSmQ==
Date: Fri, 31 May 2024 20:02:34 +0100
From: Simon Horman <horms@kernel.org>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: fix initial port flush problem
Message-ID: <20240531190234.GT491852@kernel.org>
References: <1716932145-3486-1-git-send-email-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716932145-3486-1-git-send-email-Tristram.Ha@microchip.com>

On Tue, May 28, 2024 at 02:35:45PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The very first flush in any port will flush all learned addresses in all
> ports.  This can be observed by unplugging a cable from one port while
> additional ports are connected and dumping the fdb entries.
> 
> This problem is caused by the initially wrong value programmed to the
> register.  After the first flush the value is reset back to the normal so
> the next port flush will not cause such problem again.

Hi Tristram,

I think it would be worth spelling out why it is correct to:
1. Not set SW_FLUSH_STP_TABLE or SW_FLUSH_MSTP_TABLE; and
2. Preserve the value of the other bits of REG_SW_LUE_CTRL_1

> 
> Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> ---
>  drivers/net/dsa/microchip/ksz9477.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
> index f8ad7833f5d9..7cc92b90ffea 100644
> --- a/drivers/net/dsa/microchip/ksz9477.c
> +++ b/drivers/net/dsa/microchip/ksz9477.c
> @@ -356,8 +356,7 @@ int ksz9477_reset_switch(struct ksz_device *dev)
>  
>  	/* default configuration */
>  	ksz_read8(dev, REG_SW_LUE_CTRL_1, &data8);
> -	data8 = SW_AGING_ENABLE | SW_LINK_AUTO_AGING |
> -	      SW_SRC_ADDR_FILTER | SW_FLUSH_STP_TABLE | SW_FLUSH_MSTP_TABLE;
> +	data8 |= SW_AGING_ENABLE | SW_LINK_AUTO_AGING | SW_SRC_ADDR_FILTER;
>  	ksz_write8(dev, REG_SW_LUE_CTRL_1, data8);
>  
>  	/* disable interrupts */
> -- 
> 2.34.1
> 
> 

