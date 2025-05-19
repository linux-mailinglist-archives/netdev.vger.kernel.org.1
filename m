Return-Path: <netdev+bounces-191539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D54CABBE21
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 14:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04A987AD1E8
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB703278E79;
	Mon, 19 May 2025 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mSNtfKkr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0F222339;
	Mon, 19 May 2025 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658567; cv=none; b=Dxx8lBnFmr9umfRjc2Ve1RpduXWc8WyuBUATdzYRljJbsKpAwUtpnNHn2KvgsjViSx4qbv/Tve0Z2C+7kpl2/PZ3J1iyUfFycs18NJ69YwiFmpDbB/2NbbAJToQZBlNY1ba7nwJmhtEFLIuconTihDxQdf55c/GIgdIS/i/3raY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658567; c=relaxed/simple;
	bh=hH1Zhxyae+uYUwaXvNwzZCA39MatBPiXi0KkGdMyCak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+kP/5RzK9kz0LrRqTxDJ+QzV+jQFGrRmGhebTBK0R6jSE85binz6oSyQLNMuf+k09LXwDz695f+pGJkBsd1NxMm+DGpS/Y+iqrvIvxRPwH2c+ct8CutdiFtB3hOv4GwigM8v9sahbPKd9K8LwlyhljN6JMJAjY/0vLKHfdyXEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mSNtfKkr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ti4HtWUOIVxKwphe2juMo13t1mG8jKogyW/68qm1dDE=; b=mSNtfKkrVtPbae5pdS/VmQp+e3
	w8sThfGNyQuXGesjU/WnCvIRhki285u1PTaFa2vX60d+YIYVIZAybgXdLuWnmX8fV0mxYuH7vbuQw
	K4ltrhJAdbEwrRW6s7x/QqwETKA4mJEBZ/b3smOAbkjkhlGdRjwFbxLdFVkhcwUlz+oY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uGzpG-00D1Kl-Fc; Mon, 19 May 2025 14:42:38 +0200
Date: Mon, 19 May 2025 14:42:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: chalianis1@gmail.com
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: dp83869: fix interrupts issue, not correctly
 handled when operate with an optical fiber sfp.
Message-ID: <b62d0d20-6ba2-46ff-b581-7fea1e810300@lunn.ch>
References: <20250519022417.338302-1-chalianis1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519022417.338302-1-chalianis1@gmail.com>

On Sun, May 18, 2025 at 10:24:17PM -0400, chalianis1@gmail.com wrote:
> From: Anis Chali <chalianis1@gmail.com>
> 
> to correctly clear the interrupts both status registers must be read.
> 
> from datasheet: http://ti.com/lit/ds/symlink/dp83869hm.pdf
> 7.3.6 Interrupt
> The DP83869HM can be configured to generate an interrupt when changes of internal status occur. The interrupt
> allows a MAC to act upon the status in the PHY without polling the PHY registers. The interrupt source can be
> selected through the interrupt registers, MICR (12h) and FIBER_INT_EN (C18h). The interrupt status can be
> read from ISR (13h) and FIBER_INT_STTS (C19h) registers. Some interrupts are enabled by default and can
> be disabled through register access. Both the interrupt status registers must be read in order to clear pending
> interrupts. Until the pending interrupts are cleared, new interrupts may not be routed to the interrupt pin.
> 
> Signed-off-by: Anis Chali <chalianis1@gmail.com>

This seems like something for stable?

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Please include a Fixes: tag.

Please base this patch on the net tree:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

> ---
>  drivers/net/phy/dp83869.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
> index a62cd838a9ea..98d773175462 100644
> --- a/drivers/net/phy/dp83869.c
> +++ b/drivers/net/phy/dp83869.c
> @@ -25,6 +25,7 @@
>  #define DP83869_CFG2		0x14
>  #define DP83869_CTRL		0x1f
>  #define DP83869_CFG4		0x1e
> +#define DP83869_FX_INT_STS	0xc19

It appears that this is an Extended register, so it belong after
DP83869_FX_CTRL?

    Andrew

---
pw-bot: cr

