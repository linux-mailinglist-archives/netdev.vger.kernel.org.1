Return-Path: <netdev+bounces-139923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EB19B4A0B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20FE1B23D00
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CC02064FD;
	Tue, 29 Oct 2024 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E4qziFBZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97153621;
	Tue, 29 Oct 2024 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205999; cv=none; b=dkiC6jSajmUqKqlLbZwRQJ476vSO4YnWdo5Qafu+eOg2B/zRtxeYZz3Ga+cS93n4nFsmX/fqrsWfA6U8qYCF2bj5sxLph9JRX+CKDdQqq5zbjCZ9IhNEVZbqL3hQfYm2G8wfCzURFamZw3GVvWrcr87o6obfeJ9nia/qECELTIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205999; c=relaxed/simple;
	bh=VkaHfhcl4iLutH67vvLa9iiBPRXNUS1Ic8sKFpBMfwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4PqseOx1gfB4jM0/Yf1TEuH4UiZkq9YHc2icTspACppHL4pL6JA7w2Vg1JX6GnB4a9OEI3Wo15NbJw2NUFgpl91KdWp/7TwOBA/grPk3kRIJJjHAy1/0igqJz/KFfOis3yiDa5n8cZeKxUFNzBRRsuNPKOasHQAscDYBKbUx/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E4qziFBZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LY7Fbz/Fi+xKC3ClkbwZw0JUxpl8Rh5O1YgX5ak65zY=; b=E4qziFBZet6GGyRwtWnnIH8NzW
	tw4gbTG06OaXGpVV3qabxpma9zubRNE+6cX/rT/XpKzBVbMhTwWy4B3A61oyvHCN4HQ5WZv6Z81mT
	mWZahB8nobf7eayLrxzKB4QGvXONabpryX/RkEc5m3izZSge1lq8f7YzQoVNe5HP9bQo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5lc8-00BZiY-Ox; Tue, 29 Oct 2024 13:46:24 +0100
Date: Tue, 29 Oct 2024 13:46:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andy Yan <andyshrk@163.com>
Cc: Johan Jonker <jbx6244@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	david.wu@rock-chips.com, andy.yan@rock-chips.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: Re: [PATCH v1 2/2] net: arc: rockchip: fix emac mdio node support
Message-ID: <9926fc06-7f64-4902-b933-23b68571db5b@lunn.ch>
References: <dcb70a05-2607-47dd-8abd-f6cf1b012c51@gmail.com>
 <f04c2cfd-d2d6-4dc6-91a5-0ed1d1155171@gmail.com>
 <250cdfef.1bfc.192cd6a1f72.Coremail.andyshrk@163.com>
 <0a60a838-42cb-4df8-ab1f-91002dcaaa14@lunn.ch>
 <a7c2431.871a.192d75e5631.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7c2431.871a.192d75e5631.Coremail.andyshrk@163.com>

On Tue, Oct 29, 2024 at 04:22:16PM +0800, Andy Yan wrote:
> 
> Hi Andrew,
> 
> At 2024-10-28 20:59:18, "Andrew Lunn" <andrew@lunn.ch> wrote:
> >> Hello Johan,
> >>     Thanks for your patch.  Maybe we need a Fixes tag here?
> >
> >What is actually broken?
> 
> The emac failed to probe after bellow patch merged.
> 
>  [    2.324583] loop: module loaded
>     [    2.328435] SPI driver spidev has no spi_device_id for rockchip,spidev
>     [    2.338688] tun: Universal TUN/TAP device driver, 1.6
>     [    2.345397] rockchip_emac 10200000.ethernet: no regulator found
>     [    2.351892] rockchip_emac 10200000.ethernet: ARC EMAC detected with id: 0x7fd02
>     [    2.359331] rockchip_emac 10200000.ethernet: IRQ is 43
>     [    2.364719] rockchip_emac 10200000.ethernet: MAC address is now e6:58:d6:ec:d9:7c
>     [    2.396993] mdio_bus Synopsys MII Bus: mdio has invalid PHY address
>     [    2.403306] mdio_bus Synopsys MII Bus: scan phy mdio at address 0
>     [    2.508656] rockchip_emac 10200000.ethernet: of_phy_connect() failed
>     [    2.516334] rockchip_emac 10200000.ethernet: failed to probe arc emac (-19)

So it is failing to find the PHY, and given the 'mdio has invalid PHY
address' it is probably looking in the wrong node.

The commit message should explain this.

	Andrew

