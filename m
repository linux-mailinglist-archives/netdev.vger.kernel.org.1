Return-Path: <netdev+bounces-149412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ED59E58DE
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0E016A4EA
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FD7218EB8;
	Thu,  5 Dec 2024 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EbcaQOak"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF391B0F22;
	Thu,  5 Dec 2024 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410300; cv=none; b=J99AMNO1t3CzZVLnNMXLYM/LKZaPBNjR6BExXXnR5PyCvgokmFTzZMilgUnRHlAmcE2dHVeD3nmEz+n5Zv0gMb3bpUTnwO7PxZwC6xISkngP23xxa6SLiyXqHIiMGrvVdf5MgsJ0DhVpG/nBXuYBAiPhvBtGO4QhtPj+BYbvFFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410300; c=relaxed/simple;
	bh=kbdEyUAHvph5Vcp4GSKxfVMo3s/1jBy/kuu4A1khC2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF/juYNh1z2iTX7N13IfoTlINUXB/wHNJsMf/brVyqK2E6cgyGo5cjYe5eWuGDZ5GeRDIALKIB7GJN+hpwLezhp5SHj3uUxpUYzPbJmnePPrAmDS4ObkffuoP58+JHSRGbk/DdK/kmR14UKuQFt5lfxZjSbZuq9ymd68O+tj1zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EbcaQOak; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PcNg0zGfsk8v4HwpZ/+LMXm50DZZbgPeP1p7JDPlKLM=; b=EbcaQOakQhVCun736UeyU1RNcM
	VYrFzsrZ7j3XcCl9kewBnRaQ66q2IiW6D8qaDlDn3tDY7VE8j/IZa3M1SSG8wak4wovH2NnXHzbQ6
	0vQQD5K4EbXwOhDWcc0pGKan/dy3/kBmom51AJnsfXg98w84odxipfUuZNLFmCXqkyhc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tJDCT-00FKLe-EN; Thu, 05 Dec 2024 15:51:29 +0100
Date: Thu, 5 Dec 2024 15:51:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: usbnet: restore usb%d name exception for local
 mac addresses
Message-ID: <a7b0b637-8ecb-4092-b6a9-162bafb95454@lunn.ch>
References: <20241203130457.904325-1-asmadeus@codewreck.org>
 <5b93b521-4cc8-47d3-844a-33cf6477a016@lunn.ch>
 <Z1Fvg7mJv0elnuPL@codewreck.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1Fvg7mJv0elnuPL@codewreck.org>

> > The point about locally administered MAC addresses is that they are
> > locally administered.
> 
> Honest question here our of curiosity, my reading of a few random pages
> on the internet is that it would be acceptable for the modem to randomly
> generate it?
> (under the assumption that e.g. a reset would clear it and get me a new
> mac)
> 
> Or does it have to be assigned as late as possible, e.g. we'd want linux
> to be generating it in this case?

Honest, answer is, i've never read what IEEE says about locally
administered MAC addresses.

The general pattern in linux is, if there is no alternative, generate
a random MAC address in the locally administered range. The sysadmin
should be able to change it via ip link set address, and more likely
making it 'permanent' by setting it in /etc/network/interfaces or
whatever the distribution uses. I would not be too surprised if some
MAC drivers are broken and that fails.

Since you can change the MAC address at runtime, and you say they do
appear to be somewhat random, i don't see why we cannot live with
this. It can still be locally administrated if need be. But it is no
something we want to see OEMs do, they really should get an OUI.

	Andrew



