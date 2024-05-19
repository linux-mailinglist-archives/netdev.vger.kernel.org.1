Return-Path: <netdev+bounces-97133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6158C94D0
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 15:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA831F212C1
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C1C45945;
	Sun, 19 May 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dNc6QUYm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A46C45014
	for <netdev@vger.kernel.org>; Sun, 19 May 2024 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716126190; cv=none; b=IzMaiyG0yB7HMaASGuOPar65HoHEC6dWKhx72NOIbfwpdqetpy5jawd1Uuum9VdLSw4dF2tnCtVyeqbbeTvLeUqan0e9ZU3JLsjWVszRnNZHCeaSSnmrE+G9JLGzJRRfaohxcLHWq7LoGngURbrdFkHt9P9MeCxcjhN9wc+MR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716126190; c=relaxed/simple;
	bh=wlQqnNLNgSW1FhnTk1YRcM8CJ5iID4KmLyR6yyN2yL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVq+3hvM05PQYeDsO2F1ljimC3H3GsV8jNaP2NAo0wqzcW4OpcKh4O5WKe+o4Q8c1+jEyKOe6Fd6tEgbR479izuAy724Cb8wXcUJm0WVayqo753x+2n/d451uirp1S2ZsQkp7Xbei1xDoip/EJszQwThOCuy85zThTqT7ToQFf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dNc6QUYm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MdmFsCqw3oSOOvWhRLwjAzsW40V7wP5vGS0b0czYY3E=; b=dNc6QUYmmOCeOtxaiX0J2fS/Nr
	6N+EKoBMvAI2uOKK9XE5QKJF2xmwFjU98stkQ83MtIooCE4WYqzZd/28hhgFUqvo5gLMUcjvKlqry
	F8JYe5xAOPlkYiNvHe2FlQ+1YB9JzzCmJOOy8x2I+5kvOXI3WZ1vzLQ4HW4Ktget08rw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s8goL-00Feo9-7T; Sun, 19 May 2024 15:42:49 +0200
Date: Sun, 19 May 2024 15:42:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: set struct net_device::name earlier
Message-ID: <a075e64d-1297-4dc9-81b4-8b67f3db3cae@lunn.ch>
References: <d116cbdb-4dc5-484a-b53b-fec50f8ef2bf@p183>
 <1c1dd2da-9541-4d9c-a302-0a961862cedd@lunn.ch>
 <bd68daa3-b8bd-4124-8a0c-dcc3c14bba24@p183>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd68daa3-b8bd-4124-8a0c-dcc3c14bba24@p183>

On Sun, May 19, 2024 at 08:41:40AM +0300, Alexey Dobriyan wrote:
> On Sun, May 19, 2024 at 12:04:05AM +0200, Andrew Lunn wrote:
> > On Sat, May 18, 2024 at 11:24:57PM +0300, Alexey Dobriyan wrote:
> > > I've tried debugging networking allocations with bpftrace and doing
> > > 
> > > 	$dev = (struct net_device*)arg0;
> > > 	printf("dev %s\n", $dev->name);
> > > 
> > > doesn't print anything useful in functions called right after netdevice
> > > allocation. The reason is very simple: dev->name has not been set yet.
> > > 
> > > Make name copying much earlier for smoother debugging experience.
> > 
> > Does this really help?
> 
> Yes and no. One could infer names from stacktraces and overall ordering
> of the allocations but it isn't convenient.
> 
> The snippet works everywhere except small number of functions
> but it doesn't cost anything to make it work everywhere.
> 
> > Instead of "" don't you get "eth%d"? The expansion of the %d to eth42
> > does not happen until you register the netdev.
> 
> Expansion happens later, yes. %d is fine. It is immediately obvious
> which type of device allocates what.

We are in the merge window at the moment, so patches are not being
accepted at the moment. You will need to repost in a weeks time. When
you do, please expand the commit message. The "which type of device"
is what is important here, not the true device name.

Also, please take a look at:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

