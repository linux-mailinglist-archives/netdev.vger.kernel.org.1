Return-Path: <netdev+bounces-162282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E91DA265D9
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F728188185B
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8639C20F094;
	Mon,  3 Feb 2025 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4M5qnJlw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A71E0B9C
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618897; cv=none; b=qvNxjLM2lCFx5/9CbY9oYIzbaB3hduEHVuNouFLgvkE740h9PoyCDrErT1CDCod4+o2QEYmy3oHBhkLU7idtjWVrcAw48nFZfqmejl8fyK97/do8/4b/lebJ/VEOGuR4t4FYLWwgn7XIaYSwwZxaAMSKNKESEM1SmbH9wovqx2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618897; c=relaxed/simple;
	bh=WQhORa5roZI7cB1NQjr5d7KGBF5eTrAc3uX5YoR3Mes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSBGIBq9wYvFhMEvYT2AbrMZHas9h+eBGd9DJbbKd1jLlHCXqitLbbzggpPhgdJQJZ30uywCwKeb3btcPCielaPbdrtwEEf6OiOppnIHmeBwI6sobYdIXDy6QMWcR9v4gOBolTsjR9lH7bEpXrxIDB+LzConk/trbZfVB0Pl7rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4M5qnJlw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vvkzOlNS7lh964h8oC1rtbrSEs+k5W8qEryl93iUFLA=; b=4M5qnJlwfWnxAXxIecG6TUiPvI
	uhPcQ4F2jqM5fk0XBzVi314FyzoHqr0habs3zbceA2C+S/YD0YnZu1Elx4fIERRn6TSAabQ7VAD/0
	8ZbCRZD8Gmdycz+52O+u0UyRlo8ec85uZmhlj6pLWgE/9324VPKojsRBLvlnyE1Zw6z0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tf4C3-00Aecl-Jr; Mon, 03 Feb 2025 22:41:23 +0100
Date: Mon, 3 Feb 2025 22:41:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: don't scan PHY addresses > 0
Message-ID: <c22b2d03-badd-4c9e-9ed2-7fc77e2586b1@lunn.ch>
References: <65a41b61-1122-49cb-805c-cf2cfe636b72@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65a41b61-1122-49cb-805c-cf2cfe636b72@gmail.com>

On Mon, Feb 03, 2025 at 09:48:00PM +0100, Heiner Kallweit wrote:
> The PHY address is a dummy anyway, because r8169 PHY access registers
> don't support a PHY address. Therefore scan address 0 only, this saves
> some cpu cycles and allows to remove two checks.

The IOCTL interface allows you to access any address on the bus. So
you should probably keep the tests. Setting phy_mask however is a good
idea.

	Andrew

