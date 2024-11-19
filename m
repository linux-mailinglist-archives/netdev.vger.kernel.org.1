Return-Path: <netdev+bounces-146097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EAD9D1EFA
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60741F22434
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B454E146A71;
	Tue, 19 Nov 2024 03:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="fp4bjXgX"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E798D1863F;
	Tue, 19 Nov 2024 03:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731988445; cv=none; b=Z+x8uidHGwnUyhYRHMSyoEdM44BU+l+E0+9I7VTP0d+lI5njSjbME8M4ZqdIQpnIEFyJ5kvYWLTM2BRHZe2EbErfAdHmx7zneWtwjTgGq+aKnhenN6+t+1uoqD5huS5AxGhRMgbViVqkBhN4oT55l9KG5duxYyGOJg9ex4xoW/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731988445; c=relaxed/simple;
	bh=jJG3L4gmdF2yJCH6WtyfpSNOswFK8CKuR0vc4IfhodQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7+0Yv2eZyFaII3kovzGXac4XTe1mtd25Xo72tHTUGiefnDA2iC+C1MQWe6wQm+g48yIhfvaLGXJfIou6wISeqBRozigHEKeJ1WbeosJIrUPB51eTnAVLKF76F78xSnMtilIfdL0OUnXRblEJCSOXIKEqVAaG4nKzw4wG3cNRJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=fp4bjXgX; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NOANPQBDcF3Z4dheQl98tZSiqC0YAS9KqHokuoZAeZM=; b=fp4bjXgXJNDG253v6A4DPhBYhb
	JYy1rMbpp0VeN7NIorCJNJL5tlUiyCdkGojMAcL6ffKCCfzlWTr5yEr11d5y/0zYLgypzDt5GIcoh
	mzSsmeOetX9UgQew7LRH/0QN93ZjqzZ7uPzG0F3buX8B8T6/YnrKzkMfQWOH35XwYTG21GvUtmJU+
	X8Km8P1HOMf6LVhfWBb/X0BLNsoeHr9aDW4vWiBBH3KHb5/uzfegBcPEwNLUWZqHY6Ob8q/549H54
	/+KGsux5SZYvRQoC3EEDkQ/FNUZbLz5edPbeMjlVfeJaU7a5V2h0mu0+INYle5jQ8fKTQk0SKRhOV
	pGy8vb1w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tDFJF-000B78-12;
	Tue, 19 Nov 2024 11:53:50 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 19 Nov 2024 11:53:49 +0800
Date: Tue, 19 Nov 2024 11:53:49 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Breno Leitao <leitao@debian.org>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, stephen@networkplumber.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH net 0/2] netpoll: Use RCU primitives for npinfo pointer
 access
Message-ID: <ZzwLzfzjGgG28VYW@gondor.apana.org.au>
References: <20241118-netpoll_rcu-v1-0-a1888dcb4a02@debian.org>
 <173198763100.93658.15150293129668090015.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173198763100.93658.15150293129668090015.git-patchwork-notify@kernel.org>

On Tue, Nov 19, 2024 at 03:40:31AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Mon, 18 Nov 2024 03:15:16 -0800 you wrote:
> > The net_device->npinfo pointer is marked with __rcu, indicating it requires
> > proper RCU access primitives:
> > 
> >   struct net_device {
> > 	...
> > 	struct netpoll_info __rcu *npinfo;
> > 	...
> >   };
> > 
> > [...]
> 
> Here is the summary with links:
>   - [net,1/2] netpoll: Use rcu_access_pointer() in __netpoll_setup
>     https://git.kernel.org/netdev/net/c/c69c5e10adb9
>   - [net,2/2] netpoll: Use rcu_access_pointer() in netpoll_poll_lock
>     https://git.kernel.org/netdev/net/c/a57d5a72f8de

These are not bug fixes.  They should not be going through during
a merge window, especially with such a short period of review.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

