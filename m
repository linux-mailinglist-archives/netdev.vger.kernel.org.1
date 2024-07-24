Return-Path: <netdev+bounces-112750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B2E93AFE7
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 12:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18CF1C2227C
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 10:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE8214EC7F;
	Wed, 24 Jul 2024 10:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rBs1PzO0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6AE1C6A3;
	Wed, 24 Jul 2024 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721817350; cv=none; b=LZ+xaqB/cWJKm78ujXhUrb52hTOMoOeExHxWno6pGDNirqvKZOQCLPLNjW5IY0+FVJxf32tga2+x7sMAeaEVRdVuYcXuk/JfwU6X/CYzZoCWbLXxXf3/8L/sEe8f1dOrtOz3MTDIxz2UhZC3cg/B9yRfTkobTnRNuGR/MjwSvhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721817350; c=relaxed/simple;
	bh=RXO9aHKmQX5tZPYhAyuJieCnPkqC5ElNeQ4zVhrogUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrjzOOWdM7eTtPzoIysjPS6YWC4vlTNU0hGahwyWj6BlnZiUV6dtp0V5eT4AUfo4EoUb57mWJeRPF3g3aW9yX4vwaPzmuK5W3iK9g4TxgyUDfeLz3+C9cQhkVqbI0+8XdEsrJyKzIOBZyIRg2L3AR0q3SHnbF+S1qAkhMoAALE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rBs1PzO0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HnjPxBnYUuMukIvktIRlgusB5luyAOmnqBu5aupwsuc=; b=rBs1PzO0ARggEpWE+O3IKVGIVK
	z1PenjLYmeF7NliQYDtelBfgEUZlZfSGv/G99hsT6gNNR4oo16Oop1oWl9nq+VmT1EJYgeMkZ+yCR
	YA36Btg+SOd5hdf1nAm3rmWzvGqqYDh2bZQAh7Vro5YC0G9v4tWn6zxOanH16XDuMTwg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sWZLM-0037oi-4w; Wed, 24 Jul 2024 12:35:36 +0200
Date: Wed, 24 Jul 2024 12:35:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/4] net-sysfs: check device is present when showing
 testing
Message-ID: <30a2d52a-527b-4cc3-94b6-9ee092859ae0@lunn.ch>
References: <cover.1721784184.git.jamie.bainbridge@gmail.com>
 <2a96f450e4150e9b8c39fb000d82c17987c5bbc5.1721784184.git.jamie.bainbridge@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a96f450e4150e9b8c39fb000d82c17987c5bbc5.1721784184.git.jamie.bainbridge@gmail.com>

On Wed, Jul 24, 2024 at 11:46:52AM +1000, Jamie Bainbridge wrote:
> A sysfs reader can race with a device reset or removal.
> 
> This was fixed for speed_show with commit 4224cfd7fb65 ("net-sysfs: add
> check for netdevice being present to speed_show") so add the same check
> to testing_show.
> 
> Fixes: db30a57779b1 ("net: Add testing sysfs attribute")
> 
> Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
> ---
>  net/core/net-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 3a539a2bd4d11c5f5d7b6f15a23d61439f178c3b..17927832a4fbb56d3e1dfbed29c567d70ab944be 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -291,7 +291,7 @@ static ssize_t testing_show(struct device *dev,
>  {
>  	struct net_device *netdev = to_net_dev(dev);
>  
> -	if (netif_running(netdev))
> +	if (netif_running(netdev) && netif_device_present(netdev))

Maybe a dumb observation, but how can it be running if it is not
present?

And if we are not holding any locks, it might be gone by the time you
call netif_testing()?

>  		return sysfs_emit(buf, fmt_dec, !!netif_testing(netdev));

	Andrew

