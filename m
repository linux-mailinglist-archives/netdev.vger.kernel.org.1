Return-Path: <netdev+bounces-95745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E90618C33D3
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 23:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879541F21413
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 21:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179BA21A02;
	Sat, 11 May 2024 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="ikJSxJzI"
X-Original-To: netdev@vger.kernel.org
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202DFC8F3
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715462341; cv=none; b=Kx4YgpBqc3wRO3kNAE2+iD/K4ouufvoKPvRZiD2Lwr8I63yTnw4+o8O8epLvsZyPTGhsFJglA9Q6P8dMPfwUIBejTYRJWpnZgUZQCizVD3FjQ5y0hSZSeX0x+Kvpy6xs9uIerbM4plxljy4CxoJq6F06BNVCPhUzw4hLQPKORRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715462341; c=relaxed/simple;
	bh=BUwxbwRU5wr3b1KUtNYtYxMyBtLKcLKZyBKFWnxexlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=od6to/tL9oFRqVgUvEB0wTKpjWSupvNlfolEy9S1tN9zLGJUQLBJ/MIAPsd+XkCgluqNXSWnqeLyRhsNA08jUDoBViQv2i0ynOY1zt0YY0xHivkcn59uB10BiSuUMthHZhxOCwn8/tCdg20QWmZHD9Rcfnj6qfiz/Wl5bWCfByw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=ikJSxJzI; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1715461891; bh=BUwxbwRU5wr3b1KUtNYtYxMyBtLKcLKZyBKFWnxexlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikJSxJzICA+sNGnFOhMDLFLqtlcYehEjSPATEKJG3TVpZrESPCBfw1WxVhbzlS0Qd
	 ygXtLAXm/R963NRdgyP/L38H4myYZWfArrSjZs53Rddb0I0zRLec68at9BpLFoKlIP
	 8Vy4REcz5YWZIN2sayYa5a7qoxjKCPFk0n+xRJgmZcIL8SPiTjeegqPCqoR21EI682
	 kygKxzj+scMml746UKct/APdbcT3IcFpNB3qumUS+tRsNXXQkIna0gIZGgTdOtjujn
	 9Uw+XMAvy72jZOItG+ZnTbhFAAFtpUsebzHRqvAyBxuHfVXu8QGH8u8FzfwzI9zv0K
	 KfoIa0zqLj67w==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4VcJMl0wK9z9m;
	Sat, 11 May 2024 23:11:31 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.5 at mail
Date: Sat, 11 May 2024 23:11:29 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: cortina: Locking fixes
Message-ID: <Zj_fAddoi7wqHufL@qmqm.qmqm.pl>
References: <20240509-gemini-ethernet-locking-v1-1-afd00a528b95@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240509-gemini-ethernet-locking-v1-1-afd00a528b95@linaro.org>

On Thu, May 09, 2024 at 09:44:54AM +0200, Linus Walleij wrote:
> This fixes a probably long standing problem in the Cortina
> Gemini ethernet driver: there are some paths in the code
> where the IRQ registers are written without taking the proper
> locks.
> 
> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/net/ethernet/cortina/gemini.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 705c3eb19cd3..d1fbadbf86d4 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -1107,10 +1107,13 @@ static void gmac_tx_irq_enable(struct net_device *netdev,
>  {
>  	struct gemini_ethernet_port *port = netdev_priv(netdev);
>  	struct gemini_ethernet *geth = port->geth;
> +	unsigned long flags;
>  	u32 val, mask;
>  
>  	netdev_dbg(netdev, "%s device %d\n", __func__, netdev->dev_id);
>  
> +	spin_lock_irqsave(&geth->irq_lock, flags);
> +
>  	mask = GMAC0_IRQ0_TXQ0_INTS << (6 * netdev->dev_id + txq);
>  
>  	if (en)
> @@ -1119,6 +1122,8 @@ static void gmac_tx_irq_enable(struct net_device *netdev,
>  	val = readl(geth->base + GLOBAL_INTERRUPT_ENABLE_0_REG);
>  	val = en ? val | mask : val & ~mask;
>  	writel(val, geth->base + GLOBAL_INTERRUPT_ENABLE_0_REG);
> +
> +	spin_unlock_irqrestore(&geth->irq_lock, flags);
>  }
>  

Looks good, though spinlock looks necessary only around the ENABLE0
rmw, as the 'if (en)' part is resetting the "triggered" flag of the
interrupt (acking earlier-ignored interrupts).

>  static void gmac_tx_irq(struct net_device *netdev, unsigned int txq_num)
> @@ -1415,15 +1420,19 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
>  	union gmac_rxdesc_3 word3;
>  	struct page *page = NULL;
>  	unsigned int page_offs;
> +	unsigned long flags;
>  	unsigned short r, w;
>  	union dma_rwptr rw;
>  	dma_addr_t mapping;
>  	int frag_nr = 0;
>  
> +	spin_lock_irqsave(&geth->irq_lock, flags);
>  	rw.bits32 = readl(ptr_reg);
>  	/* Reset interrupt as all packages until here are taken into account */
>  	writel(DEFAULT_Q0_INT_BIT << netdev->dev_id,
>  	       geth->base + GLOBAL_INTERRUPT_STATUS_1_REG);
> +	spin_unlock_irqrestore(&geth->irq_lock, flags);
> +

This doesn't look right: one, those are different registers, two it is
an IRQ-acking write.  In this case it is important that readl() is ordered
before writel(), but the spinlock doesn't guarantee that.

> @@ -1726,10 +1735,9 @@ static irqreturn_t gmac_irq(int irq, void *data)
>  		gmac_update_hw_stats(netdev);
>  
>  	if (val & (GMAC0_RX_OVERRUN_INT_BIT << (netdev->dev_id * 8))) {
> +		spin_lock(&geth->irq_lock);
>  		writel(GMAC0_RXDERR_INT_BIT << (netdev->dev_id * 8),
>  		       geth->base + GLOBAL_INTERRUPT_STATUS_4_REG);
> -
> -		spin_lock(&geth->irq_lock);
>  		u64_stats_update_begin(&port->ir_stats_syncp);
>  		++port->stats.rx_fifo_errors;
>  		u64_stats_update_end(&port->ir_stats_syncp);

This, too, is a IRQ-acking write that doesn't seem to gain much by
running inside the spin-locked section.

Best Regards
Micha³ Miros³aw

