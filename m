Return-Path: <netdev+bounces-101240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EFF8FDD00
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 04:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71AB1285BE0
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA8A1C68E;
	Thu,  6 Jun 2024 02:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+JGGctL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4243C17C68;
	Thu,  6 Jun 2024 02:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717642462; cv=none; b=Pzdb5ULef1n1b9xuN1O5/HaLwIZBkufyRf7zb3mrsW1D3scP9Et2SandgbiOyZ2ccdVd2zLdm0kfZqnHb75w6fH1g263aUW2BVeEvaP/aspXYRkY9+cs2zrA76X3UHg1pmcxrSR4pep1zPPp1oFS6qedLtGt59mNroOauNmNw8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717642462; c=relaxed/simple;
	bh=MLnYIwDqlSKmUDFexu1Pj6yxjoOLhnj27TEZzHCziG0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4ERvVwgL3MIGSUqhYByNz3nKihn2z2lh05TEFlC9UCsrT73pjuYH3BKCfk+pileyKrVDEe+hTOZepvViFwo15TkCCuOcL7KJC1P7GeAk8IH+SpVD3qxpa5+TAYSA0U0dsTMw+jbtiAjhXrDG+Iizz5GSpTdtZbu153i1fB9wYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+JGGctL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A7BC2BD11;
	Thu,  6 Jun 2024 02:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717642461;
	bh=MLnYIwDqlSKmUDFexu1Pj6yxjoOLhnj27TEZzHCziG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E+JGGctLP2NJ0SejSz2cPdqAsZgktmDM1pdGZD5f5f2rtJWaojPzdH2YzE6+fiOlk
	 +n61hg6Jf+iVhzhIYLpQjRZs4K/fflz2AUduPW1poxad1izqh9vgMqGsFix2Hlver6
	 fahkr0lBiYJ9xM67lmFok+caorwwLwPin+71HhDRWE6VNpbn+bVe8cJLwGMqNy/J6z
	 RRyxj2FBBSivBs1m8QSmVlqVpznSNcUQpiBnowcNzdc7s5LnXzzl73IDM1ImNZjh8o
	 D6N2CQCXcxc9OTpWgntMTAk+lrhUHXC7CTy5j7oyAq4dIPL+FBYW1coPIBknDOFY+2
	 /2cAu+FbIRmEg==
Date: Wed, 5 Jun 2024 19:54:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andrew Lunn
 <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Daniel Bristot de Oliveira <bristot@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Eric Dumazet <edumazet@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Paolo Abeni
 <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will Deacon
 <will@kernel.org>
Subject: Re: [PATCH v4 net-next 03/14] net: Use nested-BH locking for
 napi_alloc_cache.
Message-ID: <20240605195420.2f47e6a1@kernel.org>
In-Reply-To: <20240604154425.878636-4-bigeasy@linutronix.de>
References: <20240604154425.878636-1-bigeasy@linutronix.de>
	<20240604154425.878636-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Jun 2024 17:24:10 +0200 Sebastian Andrzej Siewior wrote:
> @@ -308,6 +311,7 @@ void *__napi_alloc_frag_align(unsigned int fragsz, unsigned int align_mask)
>  	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
>  
>  	fragsz = SKB_DATA_ALIGN(fragsz);
> +	guard(local_lock_nested_bh)(&napi_alloc_cache.bh_lock);
>  
>  	return __page_frag_alloc_align(&nc->page, fragsz, GFP_ATOMIC,
>  				       align_mask);

We have decided to advise against the use of guard() in networking, 
at least for now.

Andrew, wasn't it on your TODO list to send the update to the docs? :)

