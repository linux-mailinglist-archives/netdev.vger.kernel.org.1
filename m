Return-Path: <netdev+bounces-141012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D329B9178
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355D01C20D57
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 13:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8857F19D088;
	Fri,  1 Nov 2024 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VZ06yG1s"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8259815F40B
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466249; cv=none; b=OhEa1rQwtscwAmOtIXJXaYS2cpYoZZqOKMrtdGrHqcu4yJ0oGXiDXuuFVZnXVI6jktz3ZfhQs/0sBeRWyp/hzPPob5Em9wBbS52TdcxhP66p7dLRhAYmT3tqntsxDyOvqwnhwjZebJAcBeDTURlCLDbxKJwpEjmvjk2z2CGkEQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466249; c=relaxed/simple;
	bh=+EnPbfBvxErOKGXveSAOM6tU0hUQ4pFhzoHABU8u5Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzM+zcdy21ER5+tWVcIckJD/+reCw7aNqkU4smD5u5t/8jCtQbmeyRO56tGTPhBPWSstMhmNc1HmsLoLIjlb37Z0RkVE7qlPkTVQbC2/9S4tR8jE7bJkfrHtUu3sl3uyPJL4qaMw8wDRqKL70cygDRHjxkN+fF8t3dKR4havNcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VZ06yG1s; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PT92cP+5fNkkFy9vK7W+ZhnAkLM3lFa+N6+39fr+BaQ=; b=VZ06yG1saCRof3LwULXWAXfySs
	mLU60XMtb8qabHmuH1bxZwAHSJJUWgv5uwTnlbZrQ3DArSkO/gnbomXrUL0Ugwahh8czxyk1h3miV
	eUW2fgTrceZUcaumg9ttvh3oXfddQGRc582HJXQK3nRPXEUYaN/a/swKTc0kCBxf8IEQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6rJm-00Bse4-L5; Fri, 01 Nov 2024 14:03:58 +0100
Date: Fri, 1 Nov 2024 14:03:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "zhangzekun (A)" <zhangzekun11@huawei.com>
Cc: justin.chen@broadcom.com, florian.fainelli@broadcom.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, o.rempel@pengutronix.de,
	kory.maincent@bootlin.com, horms@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	chenjun102@huawei.com
Subject: Re: [PATCH net 1/2] net: bcmasp: Add missing of_node_get() before
 of_find_node_by_name()
Message-ID: <0f417672-f1e0-4404-ba9e-67ddb7f6d3c5@lunn.ch>
References: <20241024015909.58654-1-zhangzekun11@huawei.com>
 <20241024015909.58654-2-zhangzekun11@huawei.com>
 <d3c3c6b5-499a-4890-9829-ae39022fec87@lunn.ch>
 <9ed41df0-7d35-4f64-87d7-e0717d9c172b@huawei.com>
 <0c9ea6c2-535d-4ce8-aea1-7523b5304635@lunn.ch>
 <22c2a6ff-531f-4044-92b7-c9616642c733@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22c2a6ff-531f-4044-92b7-c9616642c733@huawei.com>

> > Do you have a rough idea how many missing gets there are because of
> > this poor design?
> > 
> > A quick back of the envelope analysis, which will be inaccurate...
> > 
> > $ grep -r of_find_node_by_name | wc
> >       68     348    5154
> > 
> > Now, a lot of these pass NULL as the node pointer:
> > 
> > $ grep -r of_find_node_by_name | grep NULL | wc
> >       47     232    3456
> > 
> > so there are only about 20 call sites which are interesting. Have you
> > looked at them all?
> > 
> > What percentage of these are not in a loop and hence don't want the
> > decrement?
> > 
> > What percentage are broken?
> > 
> > We have to assume a similar number of new instances will also be
> > broken, so you have an endless job of fixing these new broken cases as
> > they are added.
> > 
> > If you found that 15 of the 20 are broken, it makes little difference
> > changing the call to one which is not broken by design. If it is only
> > 5 from 20 which are broken, then yes, it might be considered pointless
> > churn changing them all, and you have a little job for life...
> > 
> > 	Andrew
> 
> Hi, Andrew,
> 
> There are about 10/20 call sites might have this problem, spreading in six
> files. May be we can fix these problems instead of adding a new API?

So you are saying 50% of the call sites are wrong! We should fix the
API if so many developers are getting it wrong.

	Andrew

