Return-Path: <netdev+bounces-146255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 871B79D2771
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D01F283A7E
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61B41CCEC6;
	Tue, 19 Nov 2024 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Omq3yR3i"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF211CCB49;
	Tue, 19 Nov 2024 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024572; cv=none; b=RCq+MkoCVYdsCYNlWPgWEy79cROhhasq2Gg5a2TlBDYuZj+j7g0t6L3fNq5GqoBw6hPrXTPH8euMjTdTy/d3r0s6vsdgPpd2vrNjniI0d/WvCwWG8fTkVc/akDh9ECtDiEwQXijWJ4PHWj6Sq3yu/l16hzL4ELFGjGss9IXoQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024572; c=relaxed/simple;
	bh=dUr1ksQjD6QtL3/P9QDx5wpmFKIc2GdtHZbukytewiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpNc1cVXAAATdKzVjW258rJIbpxkip1pdFz6caWnXntNm1yT5oF9J/zaSBAMcocTUp3/sCUFEiLpN8gJf3GAyK5bmOHgqa4iLCfM0TO9D9shDEi8OmO2oZkiutLim1GfYEeKhR/HQ8406Witm+elIK6Zze3Xzvm6+PVowUj2tIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Omq3yR3i; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8phBlKnPGyquZpUR4CtoI5JKyG39N4jtaX8T9/dhoVE=; b=Omq3yR3iFFtSeRX03YohOOeDTb
	Gvg7+hksVB7P1htaGtkk6FzzVzmP3tupywqmcA63m9N43s5GhqyReBJQnh+N+x8nqk6ke8y8ERILN
	argxdK/h76qHrS1QPe1K5JU3+NV5pjuvjo9SR+lXP9m3Hg667DTYA97EPvWt2iA9tWFc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tDOhu-00DoDg-Nf; Tue, 19 Nov 2024 14:55:54 +0100
Date: Tue, 19 Nov 2024 14:55:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	joel@jms.id.au, andrew@codeconstruct.com.au, f.fainelli@gmail.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: mdio: aspeed: Add dummy read for fire control
Message-ID: <27a39b05-3029-4b31-ada7-542e23e4de8b@lunn.ch>
References: <20241119095141.1236414-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119095141.1236414-1-jacky_chou@aspeedtech.com>

On Tue, Nov 19, 2024 at 05:51:41PM +0800, Jacky Chou wrote:
> When the command bus is sometimes busy, it may cause the command is not
> arrived to MDIO controller immediately. On software, the driver issues a
> write command to the command bus does not wait for command complete and
> it returned back to code immediately. But a read command will wait for
> the data back, once a read command was back indicates the previous write
> command had arrived to controller.
> Add a dummy read to ensure triggering mdio controller before starting
> polling the status of mdio controller to avoid polling unexpected timeout.

Please have another attempt at writing the commit message.

> Fixes: a9770eac511a ("net: mdio: Move MDIO drivers into a new subdirectory")
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  drivers/net/mdio/mdio-aspeed.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
> index c2170650415c..373902d33b96 100644
> --- a/drivers/net/mdio/mdio-aspeed.c
> +++ b/drivers/net/mdio/mdio-aspeed.c
> @@ -62,6 +62,8 @@ static int aspeed_mdio_op(struct mii_bus *bus, u8 st, u8 op, u8 phyad, u8 regad,
>  		| FIELD_PREP(ASPEED_MDIO_DATA_MIIRDATA, data);
>  
>  	iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
> +	/* Add dummy read to ensure triggering mdio controller */
> +	(void)ioread32(ctx->base + ASPEED_MDIO_CTRL);

Maybe: /* Dummy read to flush previous write to controller */


    Andrew

---
pw-bot: cr

