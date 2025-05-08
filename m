Return-Path: <netdev+bounces-188957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5762AAF94B
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2A01BA4215
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 12:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4362248B9;
	Thu,  8 May 2025 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SxEa5FWn"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4101CD2C;
	Thu,  8 May 2025 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746705707; cv=none; b=G7Zl1AFIpeQKkANmRXeT52EHWaOC6rDNNg88YjQcJ/XJwH2glIhglKKaM7FgSlbrynnRJNfuUsJX8kVYfXSItSytMLZg9NY2LrcFJobX7SEc6VBJp3ERZq1k7GJS6WsRA78vwzzfNEV45x+NHyWyyzLC0ZZRHGE8lxzrDjrIhRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746705707; c=relaxed/simple;
	bh=6Pv89zy/ECYdGKpYRMVsdSJDIUGOPGEbWIiLxQyC9uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSL65NAT2VT73a4YB46rt9NeEQm/n3c0SAYj4VIGj4ZiXN7s34EC0aIRGoeaNu2YFvUlzfs8Dd4DaQs1IoUp+uzcc5Hem71b1Yxr0wy+sakFGzELKDa8uvMbp/urIZHaMnVPShn6tvIVv2npPQ3uyqPSo8qoHW9za+RfNBliB0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SxEa5FWn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NTP/u+VdSTL7aex9zvh002fhrwf1MR3E9MgYv8ZBK7U=; b=SxEa5FWnFj7mFU2BgSDBS4ssYM
	oOyZFiFoRSYIyhE4SF/ZdcvrzAX1/mjo3nFzrQFOg3gbHHpKoeBEdd/YMbVGVdVvqzoUiAe8/JlbG
	huRRecMkNJ+V6J3rrzdY/TWzL1oXkCmYa7Ie+mK3mF7WqWsRpEa3stwtP4nlwKsD1fK0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uCzwO-00Bzok-W8; Thu, 08 May 2025 14:01:28 +0200
Date: Thu, 8 May 2025 14:01:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ozgur Kara <ozgur@goosey.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ethernet: Fixe issue in nvmem_get_mac_address()
 where invalid mac addresses
Message-ID: <c18ef0d0-d716-4d04-9a01-59defc8bb56e@lunn.ch>
References: <01100196adabd0d2-24bf9783-b3d5-4566-9f98-9eda0c1f4833-000000@eu-north-1.amazonses.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01100196adabd0d2-24bf9783-b3d5-4566-9f98-9eda0c1f4833-000000@eu-north-1.amazonses.com>

On Thu, May 08, 2025 at 02:14:00AM +0000, Ozgur Kara wrote:
> From: Ozgur Karatas <ozgur@goosey.org>
> 
> it's necessary to log error returned from
> fwnode_property_read_u8_array because there is no detailed information
> when addr returns an invalid mac address.
> 
> kfree(mac) should actually be marked as kfree((void *)mac) because mac
> pointer is of type const void * and type conversion is required so
> data returned from nvmem_cell_read() is of same type.

What warning do you see from the compiler?

> @@ -565,11 +565,16 @@ static int fwnode_get_mac_addr(struct
> fwnode_handle *fwnode,
>         int ret;
> 
>         ret = fwnode_property_read_u8_array(fwnode, name, addr, ETH_ALEN);
> -       if (ret)
> +       if (ret) {
> +               pr_err("Failed to read MAC address property %s\n", name);
>                 return ret;
> +        }
> 
> -       if (!is_valid_ether_addr(addr))
> +       if (!is_valid_ether_addr(addr)) {
> +               pr_err("Invalid MAC address read for %s\n", name);
>                 return -EINVAL;
> +        }
> +
>         return 0;
>  }

Look at how it is used:

int of_get_mac_address(struct device_node *np, u8 *addr)
{
	int ret;

	if (!np)
		return -ENODEV;

	ret = of_get_mac_addr(np, "mac-address", addr);
	if (!ret)
		return 0;

	ret = of_get_mac_addr(np, "local-mac-address", addr);
	if (!ret)
		return 0;

	ret = of_get_mac_addr(np, "address", addr);
	if (!ret)
		return 0;

	return of_get_mac_address_nvmem(np, addr);
}

We keep trying until we find a MAC address. It is not an error if a
source does not have a MAC address, we just keep going and try the
next.

So you should not print an message if the property does not
exist. Other errors, EIO, EINVAL, etc, are O.K. to print a warning.

    Andrew

---
pw-bot: cr

