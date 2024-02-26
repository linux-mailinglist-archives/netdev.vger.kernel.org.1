Return-Path: <netdev+bounces-74966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E988679D1
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 16:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475101F3003D
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 15:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF5B12BE92;
	Mon, 26 Feb 2024 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/EgvG4/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5112AAC5
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959920; cv=none; b=iO0r/rw5tmiw6epyUYCT/+JQPl8eEbMWvFeEQLwTsVLzJVikfCMJsEjcgJd6SFNzNOKUc547FNkGxGWi34NSoCtF1hJMeqj4D0UPFLELG+Rw4c5ukTuBuusOBhj1IfQ2ZriWezuiKQ34Eca/20zXpLETc0ojiV3W3HvVDMNFIns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959920; c=relaxed/simple;
	bh=Zol89mfDklBLMH+nBH3vpuEkihDdjcvIc6aPHvqgIHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQ+7twifBHcHQYee/D0P1N5RkKgYYcixgo3uHO6gTteBLKw7+8W43HNa0qZkN7+Lyru2pYd25g/cyH4zHU41aSAlXlc0nEzNZOFyjaSNe1YoB/N4oc3BbTzvKJy+cZmHaszuMcEwvPDMjcSyfgJwXgxJ1sqkYZvtnaLSUwt6/VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/EgvG4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5772CC433C7;
	Mon, 26 Feb 2024 15:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708959919;
	bh=Zol89mfDklBLMH+nBH3vpuEkihDdjcvIc6aPHvqgIHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k/EgvG4/lqQvumb26BHTxy1nXLwUQc/j6hAKhTY0AhN9Z4hWot2lNm5AB+SLhoXY2
	 kEFNnORa4uxdSLC7jJOqqvHqpR80Y9QmztBTXrTa6PZ+eDAFop3CV4Zq6dykxXLrd7
	 r27hC5crP/nzsYdE9BW5wfuaUwoFPRAtAxLHj/CtQhRPn33Bh7kqGq2N4aP8p571o/
	 nIL0aiJzICJdr2Mzp8rtuwIV//q/R1T3wxFFKAwN4BOAE+R18TpdYjXDhx2Aar3yql
	 m63XHdkS2POed6qNjGwIdhPovjF5IlOKLIFxE0hST/VkMLt1tEyS8t5g9rRFG0NEhe
	 dEnhQyH1EEoCg==
Date: Mon, 26 Feb 2024 07:05:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 maciek@machnikowski.net, horms@kernel.org, netdev@vger.kernel.org, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v13 1/4] netdevsim: allow two netdevsim ports
 to be connected
Message-ID: <20240226070518.74898fe7@kernel.org>
In-Reply-To: <c51765ec-b072-4c01-8dce-c2fa51f1941c@davidwei.uk>
References: <20240222050840.362799-1-dw@davidwei.uk>
	<20240222050840.362799-2-dw@davidwei.uk>
	<20240223164423.6b77cf09@kernel.org>
	<c51765ec-b072-4c01-8dce-c2fa51f1941c@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Feb 2024 09:33:02 -0800 David Wei wrote:
> >> +	err = 0;  
> > 
> > Why zero..   
> 
> Sorry left over from a previous iteration.
> 
> >   
> >> +	nsim_a = netdev_priv(dev_a);
> >> +	peer = rtnl_dereference(nsim_a->peer);
> >> +	if (peer) {
> >> +		pr_err("Netdevsim %d:%u is already linked\n", netnsfd_a, ifidx_a);
> >> +		goto out_err;  
> > 
> > I'd think if we hit this we should return -EBUSY?
> > Unless peer == dev_b, but that may be splitting hair.  
> 
> What would returning -EBUSY do?

This is continuation of the previous comment, you set err to zero,
so when device already has a peer user will get 0 (success)
They should get -EBUSY.

