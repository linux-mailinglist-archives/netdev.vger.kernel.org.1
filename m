Return-Path: <netdev+bounces-64186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27959831AA7
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 14:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B8B282769
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 13:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB63625549;
	Thu, 18 Jan 2024 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4LwQs114"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615E225541
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705584828; cv=none; b=UBZzITXNDwekKWxgZ1d8EYRWN7Ry8eZXm2enR9nQ92nvIpS/gS0v60cwX7CNv4ZsKEyZ0UEXxKuY35GppwdMFNyS5zGaXky2ybeYFKxuQanvhCiPg0tYNeGeI7jqkfq+Msy4c3XJ0OxjoR4gOBvuapip5scQZJxms9BAVhxvL0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705584828; c=relaxed/simple;
	bh=CogXoTv0IvybcZYX2x10JoQmnt/61yOUsib1+I000dY=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=Y+n2qX9MFpZRuoI+SqbkpapOau1WwGHHfUbxpW2svpfiCZ4byKeYdZcEDZDs8spybchJmybpTwvJA8RRAT5H5+DHn5F7QMdqg8Em4G/aPHuYJ2JODt6m8aICxHVPy6FX0Gq6d+WCeTWIoWo93dj299B1v+5sFgipFrHvCv2xhfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4LwQs114; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DfBmKwYUOWkzsqoQ5DX8I13FdirQQp7Cz7GLpJbgL4w=; b=4LwQs114g6wpVun70rYE5+AQnl
	kdCnMaL8SGAWFxa0v0A2Vwbe1u4E3IzUrbHeNAOBraKtW7Xhdel0EZm7Jh/O7pLczKB0e2YFQdhrU
	6+sXA9dwYtD/A2Ws8my9ovdvBsCoC9gJANca7taVIAEqnnV0AEYxVIfrljYtlQXSTGXw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQSWP-005TpV-Gw; Thu, 18 Jan 2024 14:33:29 +0100
Date: Thu, 18 Jan 2024 14:33:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, horms@kernel.org,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [RFC PATCH net-next v2 2/2] net: txgbe: use irq_domain for
 interrupt controller
Message-ID: <373c3c22-3fac-4ae7-9bdf-27ecfcc4a9f6@lunn.ch>
References: <20240118074029.23564-1-jiawenwu@trustnetic.com>
 <20240118074029.23564-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118074029.23564-3-jiawenwu@trustnetic.com>

On Thu, Jan 18, 2024 at 03:40:29PM +0800, Jiawen Wu wrote:
> In the current interrupt controller, the MAC interrupt acts as the
> parent interrupt in the GPIO IRQ chip. But when the number of Rx/Tx
> ring changes, the PCI IRQ vector needs to be reallocated. Then this
> interrupt controller would be corrupted. So use irq_domain structure
> to avoid the above problem.

Thanks for expanding the commit message.

> +static int txgbe_request_gpio_irq(struct txgbe *txgbe)
> +{
> +	txgbe->gpio_irq = irq_find_mapping(txgbe->misc.domain, 0);
> +	return request_threaded_irq(txgbe->gpio_irq, NULL,
> +				    txgbe_gpio_irq_handler,
> +				    IRQF_ONESHOT, "txgbe-gpio-irq", txgbe);
> +}
> +
> +static int txgbe_request_link_irq(struct txgbe *txgbe)
> +{
> +	txgbe->link_irq = irq_find_mapping(txgbe->misc.domain, 1);

It would be good to replace 0 and 1 with a #define making it clear
what they mean.

> +				     unsigned int irq,
> +				     irq_hw_number_t hwirq)
> +{
> +	struct txgbe *txgbe = d->host_data;
> +
> +	irq_set_chip_data(irq, txgbe);
> +	irq_set_chip(irq, &txgbe->misc.chip);
> +	irq_set_nested_thread(irq, 1);

irq_set_nested_thread() takes a bool, so its better to pass TRUE than
1.

> +static irqreturn_t txgbe_misc_irq_handle(int irq, void *data)
> +{
> +	struct txgbe *txgbe = data;
> +	struct wx *wx = txgbe->wx;
> +	unsigned int nhandled = 0;
> +	unsigned int sub_irq;
> +	u32 eicr;
> +
> +	eicr = wx_misc_isb(wx, WX_ISB_MISC);
> +	if (eicr & TXGBE_PX_MISC_GPIO) {
> +		sub_irq = irq_find_mapping(txgbe->misc.domain, 0);
> +		handle_nested_irq(sub_irq);
> +		nhandled++;
> +	}
> +	if (eicr & (TXGBE_PX_MISC_ETH_LK | TXGBE_PX_MISC_ETH_LKDN |
> +		    TXGBE_PX_MISC_ETH_AN)) {
> +		sub_irq = irq_find_mapping(txgbe->misc.domain, 1);

You can reuse the #defines you add above here.

    Andrew

