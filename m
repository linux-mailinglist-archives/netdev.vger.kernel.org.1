Return-Path: <netdev+bounces-102890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29CA90554A
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 16:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ED03B21919
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 14:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3944217F387;
	Wed, 12 Jun 2024 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="relz/AJZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9438A17F372;
	Wed, 12 Jun 2024 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203024; cv=none; b=GG1/hGHi7DE9eCi04QYUfaMtpimv8XsztsUot8JBnsLpPofrTFZL3g/Es2yhDEsAQWzDfa/9cT1yCF/hm4i5ETNHN0K2y0Fg0TdnGuJ+5ItcLrsWtIJh7pleDmWynjHCl0+O8GkIMvemtPRNrpHkLgkYFEYbfCDnfG3zGrEsBa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203024; c=relaxed/simple;
	bh=/GOyvyNQXNdNU82UwWzJ6YR0BSG8PucB1SMnlHjVSTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfY/9p7/Jmw5rB4BTvo+yB9Uj6S7wK+Dl+tjBwJ1TsvEDVNjp8APikABUgjRS6sPXcwFe47v5h9k2TvHhXNNMWSPdlWnHYCZ/eYSMNQaVKAvFtHsEjJl6R431EpnwPQWReerURYS9sugcZXzqhMz3jLXtXlF/R8aNlnKqxAKkMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=relz/AJZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YVsYJ12ebR82p9Eejxa6cR6b5LianMTSMrKus+1LFng=; b=relz/AJZ0Y1VO7eBEkGBIsMdfE
	iQA1NfDxGwFlvEIRxoMOIHLfMrvz/2wvJKnRUIXpVPf3ZTHSY2oaWIeRXcB9FNff5UxVrgqMNnim1
	TaF/2E9Csn+h2Mw705pdDHu2LPN7rzTZXHfL1jc9kwHjuLS6VVCtk3Ytszk7IHDPhaMo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sHP5X-00HToA-Lw; Wed, 12 Jun 2024 16:36:35 +0200
Date: Wed, 12 Jun 2024 16:36:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yojana Mallik <y-mallik@ti.com>
Cc: schnelle@linux.ibm.com, wsa+renesas@sang-engineering.com,
	diogo.ivo@siemens.com, rdunlap@infradead.org, horms@kernel.org,
	vigneshr@ti.com, rogerq@ti.com, danishanwar@ti.com,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, rogerq@kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH net-next v2 2/3] net: ethernet: ti: Register the RPMsg
 driver as network device
Message-ID: <8567cb7e-5398-4315-9574-0e8ff142d061@lunn.ch>
References: <20240531064006.1223417-1-y-mallik@ti.com>
 <20240531064006.1223417-3-y-mallik@ti.com>
 <4416ada7-399b-4ea0-88b0-32ca432d777b@lunn.ch>
 <2d65aa06-cadd-4462-b8b9-50c9127e6a30@ti.com>
 <bad12a9c-533e-47c3-9aa7-1a4d71eb6d87@lunn.ch>
 <ebbd1bcc-ecc4-4bbe-aefb-39256abeed21@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebbd1bcc-ecc4-4bbe-aefb-39256abeed21@ti.com>

> No, RTOS the peer is not telling the Linux machine what MAC address to use. The
> user can add a unicast mac address to the virtual network interface using the
> following steps:
> 
> Steps to add MAC Address
> # Bring down the virtual port interface
> $ ifconfig eth1 down
> # Set MAC address for the virtual port interface, ex 01:02:03:04:05:06
> $ ifconfig eth1 hw ether 01:02:03:04:05:06
> # Bring the interface up
> $ ifconfig eth1 up

ifconfig is long deprecated, replaced by iproute2. Please don't use it
for anything modern.

> While adidng the mac address, ndo ops will call set_mac_address which will call
> create_send_request which will create a request with command add mac address
> and send a rpmsg to R5 core.

The protocol documentation should be at a level that your can give it
to somebody else and they can implement it, e.g. for a different
OS. So please make the documentation clearer, what direction are these
messages flowing. And make the protocol description OS agnostic.

	Andrew

