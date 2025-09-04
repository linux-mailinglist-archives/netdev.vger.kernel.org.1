Return-Path: <netdev+bounces-220070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532FFB445DC
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1686C5A19CC
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC992609D9;
	Thu,  4 Sep 2025 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EkWvIr9n"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FF925FA34
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012081; cv=none; b=LyjtMp//+cIi0PWCNMeH1Qxqkjs2f1AwnKsS9IHpi9HahvlYfm7mJwBZA37myM5N6pNHHgxqJmJ8IUvCqPp3gzMzol09NIl2Opub/za96PrE3UQVuvgJjk3UYtskguBPyUbVDgeE3cZDf/Es1HwgJeW3t6iQSZynPwH8K4JGu/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012081; c=relaxed/simple;
	bh=1FUcl7/PpTZoVIm7sEGwzVrUhHpEZL9YziBkHxXa2GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ii4/ygQz+7rYNeO9NRZXJFzidUHOX5VoZzs4RbVOp3C+scv/bxzpLne+MsbCGAekSuovIcQpJTlw8jAArdcCMqIzxq4QuHsfL2TlXXDVCS6hddSwnzpY3vHcR8HnRAy6S8YfwlstIp5TfoOX2oD7Tlqy5SgG161T9U8useEzQLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EkWvIr9n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5e5hJGQyrhNuo2SWWS8Py1wsFI3NoFRlCCQq89mkTjA=; b=EkWvIr9nGn3Kz7gwSY5ADKrEkw
	0neeqVgsBJMb/JDWWl2vtOqqY99TMQC95VolnbIW5O/Eojo0ITAZQAC7GRpvG9nXkzaovfIgVfBPy
	hacXZ9leS3WITTtuUqLLmyogrtciL0jHpCB/oXGPF6v1vPXz6x/5y3HQ7Qtx8i27rGgQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uuF6N-007Fz8-Ln; Thu, 04 Sep 2025 20:54:31 +0200
Date: Thu, 4 Sep 2025 20:54:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC 2/2 next] microchip: lan865x: Allow to fetch MAC from
 NVMEM
Message-ID: <60547e0f-f1ef-46e1-a7ce-ea302ab08584@lunn.ch>
References: <20250904100916.126571-1-wahrenst@gmx.net>
 <20250904100916.126571-3-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904100916.126571-3-wahrenst@gmx.net>

On Thu, Sep 04, 2025 at 12:09:16PM +0200, Stefan Wahren wrote:
> A lot of modern SoC have the ability to store MAC addresses in
> their NVMEM. The generic function device_get_ethdev_address()
> doesn't provide this feature. So try to fetch the MAC from
> NVMEM if the generic function fails.

I notice this is RFC. What comments would you like?

> -	if (device_get_ethdev_address(&spi->dev, netdev))
> -		eth_hw_addr_random(netdev);
> +	if (device_get_ethdev_address(&spi->dev, netdev)) {
> +		/* Get the MAC address from NVMEM */
> +		if (of_get_ethdev_address(spi->dev.of_node, netdev))
> +			eth_hw_addr_random(netdev);
> +	}

Maybe chain this onto the end of device_get_ethdev_address() ? Looking
at the current users of device_get_ethdev_address(), bcmgenet,
enc28j60, and emac are all likely to be DT systems which could benefit
from this. You just need to make sure ACPI don't dereference a NULL
pointer.

	Andrew

