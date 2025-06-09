Return-Path: <netdev+bounces-195834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07652AD26C0
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85C43A9C1A
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 19:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FF621CFF7;
	Mon,  9 Jun 2025 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Elrd7aCT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAC838DF9
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497460; cv=none; b=tKw/gQi2pJx2DdUMjb/C/3r/S+SQVXwgRfqeejzw6rMVviHE+3fc9jyXozZzm//LIQkc3WT4PNNDvpHCEXjxWKRE8SNDrqt9LVNUX+BcK9Ey4+yMTjbxAOm12N6TJWQfiquA0alIocRApSezk//TRfpusoQrIgwp8F+le08Msow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497460; c=relaxed/simple;
	bh=oJQOgpdcw0ILzHCT1Y9ne5NS/LpKs2QU4rppnimOelI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYzNxIXJSgmAviMTuZ2oB055G2rRyqNrrLSHsi/k6b8giZE55QomcBosBMKCsLNhY4Xk79RlxECg6PwVMsbxVtVrdBoR+alxWTr398G9+nRdQ4xmu3+EnbXqD3CjmxHlj1tQG8d5P3TCdFDDNlHjjZ9DBfBQXSXv5tdD5ZM2HyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Elrd7aCT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/PFs9suinqZYXflObgA5q24ozzGWJM2AgweEhRhsfEY=; b=Elrd7aCTVVT84Rg0H+d2iWqugg
	Hxzuhnru5DOUlY7dDF+2ULbUM8Dv45YdVNKiUVrj1wml3j2Wdd+qzS9WP7Qyhqc4gJEkx0UEJE2mj
	6VW8ENmjQ1M7pH3iXzrZQEHTyTK9tGAYXaniGEznjxQYUB8aIUMrfryzCCQeCAhXBZBk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uOiCr-00FBfh-Ip; Mon, 09 Jun 2025 21:30:53 +0200
Date: Mon, 9 Jun 2025 21:30:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [RFC net-next 0/6] net: ethtool: support including Flow Label in
 the flow hash for RSS
Message-ID: <c7f7a711-cbe0-4003-bdbe-f4db041e90d0@lunn.ch>
References: <20250609173442.1745856-1-kuba@kernel.org>
 <1eca3a2d-aad2-4aac-854e-1370aba5b225@lunn.ch>
 <20250609115825.19deb467@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609115825.19deb467@kernel.org>

On Mon, Jun 09, 2025 at 11:58:25AM -0700, Jakub Kicinski wrote:
> On Mon, 9 Jun 2025 20:26:14 +0200 Andrew Lunn wrote:
> > On Mon, Jun 09, 2025 at 10:34:36AM -0700, Jakub Kicinski wrote:
> > > Add support for using IPv6 Flow Label in Rx hash computation
> > > and therefore RSS queue selection.  
> > 
> > It took me a while to get there, i wondered why you are extending the
> > IOCTL code, rather than netlink. But netlink ethtool does not appear
> > to support ops->set_rxnfc() calls.
> > 
> > Rather than extend the deprecated ioctl i think the first patch in the
> > series should add set_rxnfc() to netlink ethtool.
> 
> I suppose the fact we added at least 2 features to this API since 
> the netlink conversion will not convince you otherwise? (input_xfrm
> with all of its options, and GTP flow types and hashing)

Not really. We should of asked that the first patch in those series
added the netlink code. Why did we bother adding netlink, if we are
going to keep extending the IOCTL interface?

	Andrew

