Return-Path: <netdev+bounces-104554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD9890D3AB
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113202850D3
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9A913EFEF;
	Tue, 18 Jun 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A/sdLFbO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB98213A3E8;
	Tue, 18 Jun 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718764; cv=none; b=hbpEaIbNBvi4bDyB1A56hnGJg1RcYyIJ28n9EwxobPcjUzdKGExaEd2G/v9BcKDrsC4iO63/y/PnzH6I2jd0DR4VeSXcvY7ImnCP11j9t81G1zwnQfmGTSwinvsI2IQe4QSNkBYdFHVlQ0h4fjLh6w+hMPPJkkE3kweS/x2By0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718764; c=relaxed/simple;
	bh=xYdrR/KSOs12fHaqHZhaujw9+mvajS1oF6bZk+ghOjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIjeL184pSgyqqepsyhkqsEl2hy6egpfrQaN/RR3UYAlJ+62WUHiz0c8dGDSLpNg3qIWXVjKBcLkW6lTs9deMuWYGPkjkMcvqqO87YWGesCTwPL2wII7nXxCowswebiI/xgInxlA0HUHca6HsIGM231I8Vxf+LcLhAdgnFC2gZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A/sdLFbO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=c7JQRSaWyKo0Vgf0uX979PMUFDsx4HFXUf75q/8yk4U=; b=A/sdLFbOdUBOO/7WJfkCg3yfMK
	Qumfoe2B4njA48PFZpV5mHSlHi4S71eFqevkwhjse6WcuQ05M+JI0m6GahwY41jlZZf6J4L/Am0n0
	9HCq44Yv5CWsa6Jrr+I9YDpRrH7Y6GcyFuH7guDN5dxYvXljlajvuMRo7TPxnlaUnmag=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sJZG3-000Njy-I7; Tue, 18 Jun 2024 15:52:23 +0200
Date: Tue, 18 Jun 2024 15:52:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Vladimir Oltean <olteanv@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v1 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Message-ID: <24b69bf0-03c9-414a-ac5d-ef82c2eed8f6@lunn.ch>
References: <20240618130433.1111485-1-lukma@denx.de>
 <339031f6-e732-43b4-9e83-0e2098df65ef@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <339031f6-e732-43b4-9e83-0e2098df65ef@moroto.mountain>

> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 2818e24e2a51..181e81af3a78 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -3906,6 +3906,11 @@ static int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	if (hweight8(dev->hsr_ports) > 1) {
> +		NL_SET_ERR_MSG_MOD(extack, "Cannot offload more than two ports (in use=0x%x)", dev->hsr_ports);
> +		return -EOPNOTSUPP;
> +	}

Hi Dan

I don't know HSR to well, but this is offloading to hardware, to
accelerate what Linux is already doing in software. It should be, if
the hardware says it cannot do it, software will continue to do the
job. So the extack message should never be seen.

     Andrew

