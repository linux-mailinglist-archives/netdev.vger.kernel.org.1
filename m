Return-Path: <netdev+bounces-228738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AF8BD35D5
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 16:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34539189E55E
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E439425A331;
	Mon, 13 Oct 2025 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uSixQ1fc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E092622A7F9;
	Mon, 13 Oct 2025 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364834; cv=none; b=jEZWr6L/oX2y/l406G/ztHmmYOx1cmWCbfedo6ZkjfkjO5kU7F0ZrebxZb196eG1O+7Z8d6+mNiBVOdN3Pl4fYcdyw5mmqMlZc86Egmv8Vwh3RkuTNHfu+zcvhldtQdTcfEWVY73T19N/vEIX1HQLndzywZBEzlvejDcSrLdU8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364834; c=relaxed/simple;
	bh=v8VRn8EZuawL02D4o9kLzS+QsRKGV6h0LrltwTGXFKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iV/wu+eEoFtNmcoWAywkweKh5ygb+D6SxtyU1WA/+bPxB22Eg9JCBph0pm6duko5N8xyhcWEsrU+6iYhygAoG0ARTQ68VKCObTB0tmcutg+zENMoSBYdDktzKaYcF4YvqNooqjGI9eeZak7RmHNzE3E3dZIY402RrK8ASx2P8cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uSixQ1fc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2ic10uGMSy8xUHqDttfA4Vm/W3WMdcf+8Q9jSE+H4pk=; b=uSixQ1fcQkIcWtG5v9C0yVuEpH
	AHxR4Kc8cjJ22l+e/Gp5NlbnR5ntpB4a5C1mpn0jGYAE+tzstVJstSNlILF94EMPcnL9GWDb5mj6N
	WBF+/xerF+Y1qDkpJFUhfWtIxNou7x5j1Prcuu4N4EZWI9YRFSQ4yqsOXidHdnH4v2ls=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8JIw-00An9e-II; Mon, 13 Oct 2025 16:13:38 +0200
Date: Mon, 13 Oct 2025 16:13:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Buday Csaba <buday.csaba@prolan.hu>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: mdio: common handling of phy reset properties
Message-ID: <91eda093-0adc-4fa4-9b36-5c71d71d98b0@lunn.ch>
References: <20251013135557.62949-1-buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013135557.62949-1-buday.csaba@prolan.hu>

> +/**
> + * mdio_device_register_reset - Read and initialize the reset properties of
> + *				an mdio device
> + * @mdiodev: mdio_device structure
> + */
> +int mdio_device_register_reset(struct mdio_device *mdiodev)
> +{
> +	struct reset_control *reset;
> +
> +	/* Read optional firmware properties */
> +	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-assert-us",
> +				 &mdiodev->reset_assert_delay);
> +	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-deassert-us",
> +				 &mdiodev->reset_deassert_delay);
> +

device_property_read_u32() would be better here. But i can see why you
kept fwnode_property_read_u32() it makes it easier to see that there
have not been any code changes. So maybe add a patch 2/3 to convert
this?

> +/**
> + * mdio_device_unregister_reset - uninitialize the reset properties of
> + *				  an mdio device
> + * @mdiodev: mdio_device structure
> + */
> +int mdio_device_unregister_reset(struct mdio_device *mdiodev)
> +{
> +	gpiod_put(mdiodev->reset_gpio);
> +	reset_control_put(mdiodev->reset_ctrl);

Both of these return void, so you should make this function a void as
well.

    Andrew

---
pw-bot: cr

