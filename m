Return-Path: <netdev+bounces-84629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D94B897A4A
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6FD1F22AE6
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EA7156649;
	Wed,  3 Apr 2024 20:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6CmP4sAg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6788C3B1A2
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712177922; cv=none; b=V1dSTTMAY4J67qWlJyEv4L73RBljfJe2yccu2SAaEMeSMlu9zGaUAcEHke767uaYZLQxNmqqH1QtznXOP1chfo8xjR8rXsfPSG5+dMK3dYJs7NPX8L3hPCN5zp70Vui8dTOqPesBUIhJ30Ic7AsIFBNFaFF+TFOjb5YYZZv3Vfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712177922; c=relaxed/simple;
	bh=kBgiSCO5waY9X/lJfPI/a6sPQGjXHVYKnBW963/r4Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nte4nItxWr9tPleh46p4K+S+EkGpmAJEkzxZKgHm6KTVfB1ujDznxYVzXu94xoTT73s1zhRydKQowK5TRjl9UBTlLvG8kHE0oky8WCuFj6ToPIysZx0tbdqbPhz3r1hhfdetbPhEintpoBBTW/PnBPCJnBgTl0JsPuwsQJqeOJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6CmP4sAg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WjkMl0dWfEY0V+5u5TEDo8ELP62Y51LdebPiPccKjUI=; b=6CmP4sAgQU2NjmBQetne8V5QLK
	SQghVQWg9SIlL71/tfytuHktZ+9WxLUfRUZ4JfyQfSU2+8UcX74DdCK7utwCpTrIPdQgPpmfCf9fy
	wiWJcMZYyP1hHuFicIV4FE/YRfG5d3zvKr6ovr3c+xyeZv3CANWQ3KUAMFHgSoZ9hNbE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rs7gr-00C7CP-73; Wed, 03 Apr 2024 22:58:37 +0200
Date: Wed, 3 Apr 2024 22:58:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 07/15] eth: fbnic: allocate a netdevice and napi
 vectors with queues
Message-ID: <8b16d2b4-ef5c-4906-b094-840150980dc1@lunn.ch>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217493453.1598374.2269514228508217276.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171217493453.1598374.2269514228508217276.stgit@ahduyck-xeon-server.home.arpa>

> +static int fbnic_dsn_to_mac_addr(u64 dsn, char *addr)
> +{
> +	addr[0] = (dsn >> 56) & 0xFF;
> +	addr[1] = (dsn >> 48) & 0xFF;
> +	addr[2] = (dsn >> 40) & 0xFF;
> +	addr[3] = (dsn >> 16) & 0xFF;
> +	addr[4] = (dsn >> 8) & 0xFF;
> +	addr[5] = dsn & 0xFF;

u64_to_ether_addr() might work here.

> +
> +	return is_valid_ether_addr(addr) ? 0 : -EINVAL;
> +}
> +
> +/**
> + * fbnic_netdev_register - Initialize general software structures
> + * @netdev: Netdev containing structure to initialize and register
> + *
> + * Initialize the MAC address for the netdev and register it.
> + **/
> +int fbnic_netdev_register(struct net_device *netdev)
> +{
> +	struct fbnic_net *fbn = netdev_priv(netdev);
> +	struct fbnic_dev *fbd = fbn->fbd;
> +	u64 dsn = fbd->dsn;
> +	u8 addr[ETH_ALEN];
> +	int err;
> +
> +	err = fbnic_dsn_to_mac_addr(dsn, addr);
> +	if (!err) {
> +		ether_addr_copy(netdev->perm_addr, addr);
> +		eth_hw_addr_set(netdev, addr);
> +	} else {
> +		dev_err(fbd->dev, "MAC addr %pM invalid\n", addr);

Rather than fail, it is more normal to allocate a random MAC address.

> @@ -192,7 +266,6 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	fbnic_devlink_unregister(fbd);
>  	fbnic_devlink_free(fbd);
> -
>  	return err;
>  }

That hunk should be somewhere else.

     Andrew

