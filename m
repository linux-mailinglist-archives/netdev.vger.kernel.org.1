Return-Path: <netdev+bounces-121749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2A495E5B5
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 01:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB002812A8
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 23:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAC16BFC7;
	Sun, 25 Aug 2024 23:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="isy9xSiw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD203987D;
	Sun, 25 Aug 2024 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724628555; cv=none; b=W2vBzdlLn1KldltdoCNJ6zJyZVdVCNynETFiATdABMCCTo6qnA+7hDikVK1zTWGRJ7OFP2ftuf17pEaX6EQ/lun+yHdvj9B6rQ6H0CmOo6tFnRpPN0bcmNBjE6LWUiUVLU7xaySrHnp/MlItbOrM3JPnCtuN7hlVfzfCu0BpYMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724628555; c=relaxed/simple;
	bh=/0kV2KvRQj7gYmrQ25xC5+gQ1yI8WEI2KA7WLBk2tcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Is+vx/TZksaUTww4MnFb4gSU5/3H0dTZKuI+nmb7omyVx9Twv7ktagTqgvE6YK/GKBe5nH/q6fyIZpWDIEXPBhjpcuDq04DCLJix8R/tg78n7DTSqc5pSfSQCBTO4XzR8bkjZJexE8aZPcCE9DXVPj20UoQAQg4wPsG4Pb72fCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=isy9xSiw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/VNzMLPggM5KWfh9zESfXylqyB6nhMdOi1C2TagrgtU=; b=isy9xSiwcOu8VCkugyBCT0BL0n
	wnd844Nd2la+kYnglinmGQlG+JlKtFxGwrrLxJJLb97SWRcYkQsYMcGJaj77XWvNkkxM6BeAanVN8
	00BR3p+KMYErj4BRmvfv8UqEb4/QYnqs9+8Y93U5+ZYFCCSAmoS9DnlkiH311LY3Sim8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1siMf8-005evj-U6; Mon, 26 Aug 2024 01:28:46 +0200
Date: Mon, 26 Aug 2024 01:28:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: Jakub Kicinski <kuba@kernel.org>, f.fainelli@gmail.com,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] net: dsa: Simplify with scoped for each OF child
 loop
Message-ID: <af8c128a-ff6c-4441-9ab5-c0401900db76@lunn.ch>
References: <20240820065804.560603-1-ruanjinjie@huawei.com>
 <20240821171817.3b935a9d@kernel.org>
 <2d67e112-75a0-3111-3f3a-91e6a982652f@huawei.com>
 <20240822075123.55da5a5a@kernel.org>
 <0d2ac86a-dc01-362a-e444-e72359d1f0b7@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d2ac86a-dc01-362a-e444-e72359d1f0b7@huawei.com>

On Fri, Aug 23, 2024 at 02:35:04PM +0800, Jinjie Ruan wrote:
> 
> 
> On 2024/8/22 22:51, Jakub Kicinski wrote:
> > On Thu, 22 Aug 2024 10:07:25 +0800 Jinjie Ruan wrote:
> >> On 2024/8/22 8:18, Jakub Kicinski wrote:
> >>> On Tue, 20 Aug 2024 14:58:04 +0800 Jinjie Ruan wrote:  
> >>>> Use scoped for_each_available_child_of_node_scoped() when iterating over
> >>>> device nodes to make code a bit simpler.  
> >>>
> >>> Could you add more info here that confirms this works with gotos?
> >>> I don't recall the details but I thought sometimes the scoped
> >>> constructs don't do well with gotos. I checked 5 random uses
> >>> of this loop and 4 of them didn't have gotos.  
> >>
> >> Hi, Jakub
> >>
> >> From what I understand, for_each_available_child_of_node_scoped() is not
> >> related to gotos, it only let the iterating child node self-declared and
> >> automatic release, so the of_node_put(iterating_child_node) can be removed.
> > 
> > Could you either test it or disasm the code to double check, please?
> 
> Hi, Jakub, I test it with a fake device node on QEMU with a simple
> example using for_each_available_child_of_node_scoped() and goto out of
> the scope of for_each_available_child_of_node_scoped(), the
> of_node_put(child) has been called successfully.

What compiler version?

Please test with 5.1

https://www.kernel.org/doc/html/next/process/changes.html

	Andrew

