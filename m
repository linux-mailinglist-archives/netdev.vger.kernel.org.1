Return-Path: <netdev+bounces-146258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 303C29D2853
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 15:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C909FB2C5D8
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C4B1CDFC3;
	Tue, 19 Nov 2024 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EALHvNM2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5601CC161;
	Tue, 19 Nov 2024 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026892; cv=none; b=c8HrWyGL+zHdqq1k1awwVj4utym6tfhgxQwjWCf3efERCFU5WUZNO+ta88U2WP4Y88c/7Ibr1Cm24DBlx0d1n6KL+OBCBLADrDKctEbGYbr0fp+VuBWfGq1I1VikS3CSwNmtuB9F6pCc4q0FTNdqGhNM4e2hglbDhS3WDAdBG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026892; c=relaxed/simple;
	bh=hUPceyRco7mTX28A1oLuweXbIuyBu+LmQ378is49cno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJmGmg1fa6dLI8Nvi+bD7N/I+rNEqkglzw46aGnkUsZvdTwaQNTgYVsqJplvVKaZo7AWx5RQ14b+w48gubCIFajSF4VRD+3Twp3yP7yriQN8Hk1xlvCQ+yENsaDtJYiXVgDxBoVCBnuGDjuiTzB4XTVf+gi/UlRfdZCgCYjomuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EALHvNM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E27C4CECF;
	Tue, 19 Nov 2024 14:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732026892;
	bh=hUPceyRco7mTX28A1oLuweXbIuyBu+LmQ378is49cno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EALHvNM2YufmkzCZKVvzaVYrtb917OnyQOTIyISjyz6NuxavzwlNi/WYB2TT5dpQp
	 78t+/n207maJUSjWwB6fzvxfN+rm/11sl/jgCImKW3/I1qXi3KT7L2mwIx147ELiVO
	 6Bpj9BmH9tBgQU7SqoY7htf9QVWyiXShrFgBLqS8k527MoNRUmNgAOwE7DOuZSiAKT
	 fFGGqvntG9HlOZitKXjbV9+BUJygnog7CNMdeKg1CemzRQ/Knb/RIhsrUDlqdBM9fP
	 ldDdLWVZ6pT0VXTDIsyg5htY+JiLMYqk+Fx9p1xNpO443JpeqALH1dixlo12Js/2pN
	 tWp0J9mUbvOMQ==
Date: Tue, 19 Nov 2024 06:34:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: patchwork-bot+netdevbpf@kernel.org, Breno Leitao <leitao@debian.org>,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, stephen@networkplumber.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, paulmck@kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH net 0/2] netpoll: Use RCU primitives for npinfo pointer
 access
Message-ID: <20241119063450.45a3c7c1@kernel.org>
In-Reply-To: <ZzwLzfzjGgG28VYW@gondor.apana.org.au>
References: <20241118-netpoll_rcu-v1-0-a1888dcb4a02@debian.org>
	<173198763100.93658.15150293129668090015.git-patchwork-notify@kernel.org>
	<ZzwLzfzjGgG28VYW@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 11:53:49 +0800 Herbert Xu wrote:
> > Here is the summary with links:
> >   - [net,1/2] netpoll: Use rcu_access_pointer() in __netpoll_setup
> >     https://git.kernel.org/netdev/net/c/c69c5e10adb9
> >   - [net,2/2] netpoll: Use rcu_access_pointer() in netpoll_poll_lock
> >     https://git.kernel.org/netdev/net/c/a57d5a72f8de  
> 
> These are not bug fixes.  They should not be going through during
> a merge window, especially with such a short period of review.

Sorry, I do agree with your assessment, especially on patch 1.
But it's good to silence the false positive, so I applied and
stripped the Fixes tag.

