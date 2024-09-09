Return-Path: <netdev+bounces-126506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF53971A0A
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 14:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574E01F23877
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 12:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7A51B81DD;
	Mon,  9 Sep 2024 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ROJBAAHn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1A81B4C4F;
	Mon,  9 Sep 2024 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886471; cv=none; b=bjFYKBkK3QpmjYV/rgq/2vSQsvomwyuot7hoh30xb59vOd3ZLyR+TRfv9WghIXZ90Nm/8mxptqsUQvD+dPe6GxpiwO7jaod8gGPTb8zEjRlEgQfnX0gnJFlKnWnzy/JUEPH03tKkaN482pHX6/XAwhQXWJr67ZeKL36YmLrfdWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886471; c=relaxed/simple;
	bh=CU5Gijyy9SeMr8QbvquxivfFb2hzLLScCNZeZXgXiPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8AnXbf0R8sF7WBzrvSnECSi/jFHZ8h+5tBj6SHx//ywemhgbBIVmiWeFV7A3yeS92NylV7mXru/wZ6cZog6+eNKrbry1y58rmnL4EwYjVkJdgNNlmhOKBvbtVwk0D4yyxf4li3856sPCuE0TL5LtvCdTPM4LS7J5pMr/0NPh40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ROJBAAHn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PKyLSZDe8JiVc1Q0LEh+EYs5+ax6iv61GuSgcN9/Iak=; b=ROJBAAHnhi1iHmJStmbGtAJGIm
	iALpL9t6gsDGqBYFceoDSxJA9nKMX/mkmzw3IgwKo8z3Pith1S9BrviEE0tyj/rz7RG7P7TIS0FTP
	TFRYKHr7wfenpcmS918anCU/XoeIM4NkFT0wbSHg24a2AYVGoDdhDaAi3hVpaHOYBzw8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1snduJ-0070NI-DJ; Mon, 09 Sep 2024 14:54:15 +0200
Date: Mon, 9 Sep 2024 14:54:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: vz@mleia.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alexandre.belloni@bootlin.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: nxp: Fix a possible memory leak in
 lpc_mii_probe()
Message-ID: <0a53ab3c-2643-419d-9b5d-71561c3b50b9@lunn.ch>
References: <20240909092948.1118381-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909092948.1118381-1-ruanjinjie@huawei.com>

On Mon, Sep 09, 2024 at 05:29:48PM +0800, Jinjie Ruan wrote:
> of_phy_find_device() calls bus_find_device(), which calls get_device()
> on the returned struct device * to increment the refcount. The current
> implementation does not decrement the refcount, which causes memory leak.
> 
> So add the missing phy_device_free() call to decrement the
> refcount via put_device() to balance the refcount.

Why is a device reference counted?

To stop is disappearing.

> @@ -768,6 +768,9 @@ static int lpc_mii_probe(struct net_device *ndev)
>  		return -ENODEV;
>  	}
>  
> +	if (pldat->phy_node)
> +		phy_device_free(phydev);
> +
>  	phydev = phy_connect(ndev, phydev_name(phydev),
>  			     &lpc_handle_link_change,
>  			     lpc_phy_interface_mode(&pldat->pdev->dev));

Think about this code. We use of_phy_find_device to get the device,
taking a reference on it. While we hold that reference, we know it
cannot disappear and we passed it to phy_connect(), passing it into
the phylib layer. Deep down, phy_attach_direct() is called which does
a get_device() taking a reference on the device. That is the phylib
layer saying it is using it, it does not want it to disappear.

Now think about your change. As soon as you new phy_device_free() is
called, the device can disappear. phylib is then going to use
something which has gone. Bad things will happen.

So with changes like this, you need to think about lifetimes of things
being protected by a reference count. When has lpc_mii_probe(), or the
lpc driver as a whole finished with phydev? There are two obvious
alternatives i can think of.

1) It wants to keep hold of the reference until the driver remove() is
called, so you should be releasing the reference in
lpc_eth_drv_remove().

2) Once the phydev is passed to the phylib layer for it to manage,
this driver does not need to care about it any more. So it just needs
to hold the reference until after phy_connect() returns.

Memory leaks are an annoyance, but generally have little effect,
especially in probe/remove code which gets called once. Accessing
something which has gone is going to cause an Opps.

So, you need to think about the lifetime of objects you are
manipulating the reference counts on. You want to state in the commit
message your understanding of these lifetimes so the reviewer can
sanity check them.

FYI: Ignore anything you have learned while fixing device tree
reference counting bugs. Lifetimes of OF objects is probably very
broken.

	Andrew

---
pw-bot: cr

