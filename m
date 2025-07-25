Return-Path: <netdev+bounces-210110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 827D5B121C6
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C7147B69BC
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4C62EE97B;
	Fri, 25 Jul 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DI5eTNcC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F91AD2C
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460286; cv=none; b=lpKd/vSwAfsPq/gfWz0bffBmLFtong2Ptoyla1U5QKzKbkxohBp/LmTAl5IYV+tniEZH8/j0nHKzeSIL1Xz8XiRLK3Lwlw+M9XAYTeK+NIevKmlJ/QdMfeL93z1okgAoLwWzo8Yi26JbMqt1IzutmZsWyZupAgYraATI6k/w+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460286; c=relaxed/simple;
	bh=zYjCSsa+Ezh+SgDewraU0bM30KhoHakLN8etj/s4aVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdYmlk/DX4gt6GHzZR0vAQPJFlVppTOlwui3Q34JkWDAcukE0ufmrRtXmCDoZ+dKpP0Rke0LiIQmnAKnkle99YLJiSECTd/tAJ1EYr37nuKWYRodfcXHSJznvLgnjx0J9GbB8GMJvHN1yVAEan2fnlTfKNeydLGYN8vwsHgZHDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DI5eTNcC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eMhIO3rhQ0D36Fp2dd6jHJKnxOsNjrzjENQBWucfevU=; b=DI5eTNcCi0ZPmgpopQ++WGPUks
	kKG83ayxzk3wwnjPHCk4W8wYAskJciSonML0mZVYJN1Z7LsPyGp5IFH4m5jaNXhEdkX2g0+3npH58
	AWyZ1gNOtEu3aVZrlipFph9kgtTg/tz1J3ePDTeDG9SQWlf9bYHHmc0qUwWBfx1Typ2k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ufL7P-002sx0-Gw; Fri, 25 Jul 2025 18:17:59 +0200
Date: Fri, 25 Jul 2025 18:17:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v1] eea: Add basic driver framework for Alibaba
 Elastic Ethernet Adaptor
Message-ID: <18980367-e2d0-43b8-8643-45b800eb34c9@lunn.ch>
References: <20250724110645.88734-1-xuanzhuo@linux.alibaba.com>
 <29028773-1996-4905-bf9f-4ed0fa916d58@lunn.ch>
 <1753414106.2053263-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1753414106.2053263-1-xuanzhuo@linux.alibaba.com>

> > > +static int eea_netdev_stop(struct net_device *netdev)
> > > +{
> > > +	struct eea_net *enet = netdev_priv(netdev);
> > > +
> > > +	if (!enet->started) {
> > > +		netdev_warn(netdev, "eea netdev stop: but dev is not started.\n");
> > > +		return 0;
> > > +	}
> >
> > How does this happen?
> 
> This function can be called from other contexts.
> 
> When we receive an HA interrupt, it may indicate that there is an error inside
> the device, and this function may be called as a result.

So maybe a comment would be good.

But if this is intended behaviour, why the netdev_warn()?

The fact there is a HA interrupt and the device is broken should be
reported at a higher level, in the HA interrupt handler.

> > > +static int eea_netdev_open(struct net_device *netdev)
> > > +{
> > > +	struct eea_net *enet = netdev_priv(netdev);
> > > +	struct eea_net_tmp tmp = {};
> > > +	int err;
> > > +
> > > +	if (enet->link_err) {
> > > +		netdev_err(netdev, "netdev open err, because link error: %d\n",
> > > +			   enet->link_err);
> >
> > What is a link error? You should be able to admin an interface up if
> > the cable is not plugged in.
> 
> 
> The device may send an interrupt to the driver, and then the driver can query
> the device. If there is an error inside the device, the driver will stop
> the device. If the user tries to bring up the network device, we will
> attempt to prevent that operation.

So maybe enet->link_err is a bad name? enet->device_crashed? It makes
it clear it has nothing to do with the link, but the device.

> > > +static int __eea_pci_probe(struct pci_dev *pci_dev,
> > > +			   struct eea_pci_device *ep_dev);
> > > +static void __eea_pci_remove(struct pci_dev *pci_dev, bool flush_ha_work);
> >
> > No forward declarations. Put the code in the correct order so they are
> > not needed.
> 
> Here A calls B, B calls C, and C calls A. Please believe me, I don't like this
> approach either, but this is the simplest way and allows us to keep the related
> code together.

If you need to do something which breaks the usual conventions, add a
comment why it is needed. You are then less likely to be asked to
change it/explain it.

	Andrew

