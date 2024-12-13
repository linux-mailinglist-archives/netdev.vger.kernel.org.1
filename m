Return-Path: <netdev+bounces-151729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1069F0BDC
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000CA188AFAF
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFC51DF754;
	Fri, 13 Dec 2024 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RU0YTdJO"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072911DF73E
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091499; cv=none; b=KtUtF/wiLyzuyRrQUWZbrKV6jT4KeHmELs726V+L8YWbA7qZcyDTZzLH0nylGfIdJ5gX0d1u32uIPppeysBxiDXSgM7y697HeSs/USmcMPqM6uLRIM/k7TlqhDMzIR0bFpc9ZKIEW+An8AUNNOdVNWQtkTP8ekXgeWM4fwAr6pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091499; c=relaxed/simple;
	bh=6AE6oYp/0/+GMcVQeEYhrvVKrU8ZqC5gRKSeSZI2lHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idmlfERmxTiAa2l5XF876i/ByKeu+IbmrjEK+JT7JRnQtP253aI3bXt3dW9Zvo7bGOFA/8Zf5IDQ6x1Xj7erISuorRNFJFZrg6ECBPMh3e+emlMy+Dxs7pB5qoBc9l3zyk4Yeafi1sQ+MmZ1gnzq5XtZT3XLZZdNXfUU54LOyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RU0YTdJO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4/T56wAwkuPEeZe098bHluFtg46xChNVte1qutf7RXE=; b=RU0YTdJO25M79ARC2CayxMIU4Z
	C7hEaTVqfpitafArMxYnjw9jGvlatx1jt9SaV0b56Qty16hcrSlHEzA7Rut61vo6EXDxkg1GFUJOZ
	xZZkQoFDSP4rZgSyleeDfPaPplkDxdZPo98qU53WdVDGO7BMaTQA2mmi6iEXWLeP3bIA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tM4PS-000KrO-Pn; Fri, 13 Dec 2024 13:04:42 +0100
Date: Fri, 13 Dec 2024 13:04:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, rafal@milecki.pl,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: bgmac-platform: fix an OF node reference
 leak
Message-ID: <b8604925-d3fb-4994-893c-d34e6185e950@lunn.ch>
References: <20241212023256.3453396-1-joe@pf.is.s.u-tokyo.ac.jp>
 <20241213105508.GL2110@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213105508.GL2110@kernel.org>

> Hi Joe,
> 
> I agree this is a problem and that it was introduced by the
> cited commit. But I wonder if we can consider a different approach.
> 
> I would suggest that rather than using __free the node is explicitly
> released. Something like this (untested):
> 
> 	struct device_node *phy_node;
> 
> 	...
> 
> 	phy_node = of_parse_phandle(np, "phy-handle", 0);
> 	if (phy_node) {
> 		of_node_put(phy_node);
> 		bgmac->phy_connect = platform_phy_connect;
> 	} ...
> 
> That is, assuming that it is safe to release phy_node so early.
> If not, some adjustment should be made to when of_node_put()
> is called.
> 
> This is for several reasons;
> 
> 1. I could be wrong, but I believe your patch kfree's phy_node,
>    but my understanding is that correct operation is to call
>    of_node_put().

Hi Simon

I _think_ that is wrong. More of the magic which i don't really
like. The cleanup subsystem has to be taught all the types, and what
operation to perform for each type. Despite the name __free(), i think
it does actually call of_node_put(). The magic would be more readable
if it was actually __put(), not __free().

> 2. More importantly, there is a preference in Newkorking code
>    not to use __free and similar constructs.
> 
>      "Low level cleanup constructs (such as __free()) can be used when
>       building APIs and helpers, especially scoped iterators. However,
>       direct use of __free() within networking core and drivers is
>       discouraged. Similar guidance applies to declaring variables
>       mid-function.

And this is a good example of why.

	Andrew

