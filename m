Return-Path: <netdev+bounces-103407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3449D907E80
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 00:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558941C20FD3
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 22:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C996A139597;
	Thu, 13 Jun 2024 22:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z1ZtUrKD"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5F11369A1;
	Thu, 13 Jun 2024 22:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718316143; cv=none; b=lhP5jvm0kx3XUIAZCY7e//En64kI+Sz7sjZ4+h98R9c7J46Ip0iMP/fALPyBCZkaKl6hKDaKHHE+HQ/t7ERot4lVgSKFZxKxQQ+HGV7fOSZ6Uw4bxwEtrPYQy5dr2WH1k590GUXWS5IIhWuOEVSmQH8ykxQ9sVE5sgiMbxsHb7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718316143; c=relaxed/simple;
	bh=mvhZ7fg02QLWDHOt4fSSAy0v3cjUxDyrkpKSDETExpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mM8XwRZXDmueFCxP+mM/08wexPQ5XvcTW7W+hMX5V0Hh8dYenVwfuqkOBk7c/ABSTGDp/TqC6urSZRiIzGylkL5RdHf8RIC7+8tqu1U+5p7QyXR5lXjAcBG3o7+Ca5C93z+qHk/sIeYe9wOugYGhzcbaMm47RSqHjJufey05m/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=z1ZtUrKD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j7zmwo2RU6Du49DJYBT9DPZ+SSoMA3yEsZqcq2HtOms=; b=z1ZtUrKDjEIC/fl/3dnk+8K7Rd
	AtuWAhrv9Bk+AZ53kimQy5z3UvwmTX9axysgmJptRQfYtmdCBlAAEHJErHPi8dBeEIFYHSO217/JZ
	ZJtcGWQBE5Eg2jSmQKkISAjoDzd10sL+MD88UPZSquC0NoPrt869YJvnhZHdUapbb8mA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sHsWK-0000bs-Ce; Fri, 14 Jun 2024 00:02:12 +0200
Date: Fri, 14 Jun 2024 00:02:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Geurts <paul.geurts@prodrive-technologies.com>
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fec_main: Register net device before initializing the
 MDIO bus
Message-ID: <51faeed2-6a6b-439b-80e6-8cf2b5ce401a@lunn.ch>
References: <20240613144112.349707-1-paul.geurts@prodrive-technologies.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613144112.349707-1-paul.geurts@prodrive-technologies.com>

On Thu, Jun 13, 2024 at 04:41:11PM +0200, Paul Geurts wrote:
> Registration of the FEC MDIO bus triggers a probe of all devices
> connected to that bus. DSA based Ethernet switch devices connect to the
> uplink Ethernet port during probe. When a DSA based, MDIO controlled
> Ethernet switch is connected to FEC, it cannot connect the uplink port,
> as the FEC MDIO port is registered before the net device is being
> registered. This causes an unnecessary defer of the Ethernet switch
> driver probe.
> 
> Register the net device before initializing and registering the MDIO
> bus.

The problem with this is, as soon as you call register_netdev(), the
device is alive and sending packets. It can be sending packets even
before register_netdev() returns, e.g. in the case of NFS root. So
fec_enet_open() gets called, and tried to find its PHY. But the MDIO
bus is not registered yet....

So yes, DSA ends up doing an EPROBE_DEFER cycle. Not much we can do
about that. We can try to keep the DSA probe functions as cheap as
possible, and put all the expensive stuff in setup(), which will only
be called once we have all the needed resources.

    Andrew

---
pw-bot: cr

