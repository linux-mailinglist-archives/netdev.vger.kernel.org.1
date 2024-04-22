Return-Path: <netdev+bounces-90251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E288AD522
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 21:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0528281B82
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 19:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BD7155310;
	Mon, 22 Apr 2024 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f9YBwcky"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FEE153BFB
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815308; cv=none; b=VA+E4SIpgZ9XjK+NKwzfKEDUT5SuocegF8Wg2p5cPpSDHrG/IswsJdyJHp+c9nvAmsrwqOpKi8BnRiPjVtj4luRdxTOE89ZAM68OZUSQRo09wHJY1YlXlXajtlN4DC3qxAx+vL0pHHBdP5bzlVut8GNZCpCnhmdQ0G679eef+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815308; c=relaxed/simple;
	bh=R78MlYs4AF3fdGtIptm5BHZUxtljckel7zX4absWlb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4/akO8PFynNsoNBaVIEq9Tb5zvIoMSFkhGesMZBPax/Mg823mHb4nNi+krchJ20oRBslbvv83AohRO/pyAaA1paanEq4mNerkV5QsY4pZFAFEDGeLAPDylh40hXmhUENbDzS7nXzFtq8uRmi4oE8XODFS+JbY1c3O7DhRVGzE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f9YBwcky; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Apr 2024 12:48:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713815304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=divPes6DLKoexVgiHNnXzGNQm0LHcQj4J+oeESfqCXE=;
	b=f9YBwcky+dbjO/atZrL+bN+QPnHR0xGIq7FZN25DULvKJ1A9lHi+91Ekc2hAFJ6mkc8bet
	ZL3t3z2Ye/bDIiQMfBgZ41LWLdCk6M9p1/9z1jOwoZIr5QINAuN3mRg8JJCcBZPK4B4NAF
	E8GqkzKeLlznKkl9MSvCMdDDejwfEv8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Jonathan Heathcote <jonathan.heathcote@bbc.co.uk>, Soheil Hassas Yeganeh <soheil@google.com>
Subject: Re: [PATCH net] net: fix sk_memory_allocated_{add|sub} vs softirqs
Message-ID: <rq4kfr3ze5thlcqs3peuj4qktel4hv5svqwqdh7ywuvrex7xiu@vf45lxvtj4kr>
References: <20240421175248.1692552-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421175248.1692552-1-edumazet@google.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Apr 21, 2024 at 05:52:48PM +0000, Eric Dumazet wrote:
> Jonathan Heathcote reported a regression caused by blamed commit
> on aarch64 architecture.
> 
> x86 happens to have irq-safe __this_cpu_add_return()
> and __this_cpu_sub(), but this is not generic.
> 
> I think my confusion came from "struct sock" argument,
> because these helpers are called with a locked socket.
> But the memory accounting is per-proto (and per-cpu after
> the blamed commit). We might cleanup these helpers later
> to directly accept a "struct proto *proto" argument.
> 
> Switch to this_cpu_add_return() and this_cpu_xchg()
> operations, and get rid of preempt_disable()/preempt_enable() pairs.
> 
> Fast path becomes a bit faster as a result :)
> 
> Many thanks to Jonathan Heathcote for his awesome report and
> investigations.
> 
> Fixes: 3cd3399dd7a8 ("net: implement per-cpu reserves for memory_allocated")
> Reported-by: Jonathan Heathcote <jonathan.heathcote@bbc.co.uk>
> Closes: https://lore.kernel.org/netdev/VI1PR01MB42407D7947B2EA448F1E04EFD10D2@VI1PR01MB4240.eurprd01.prod.exchangelabs.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Soheil Hassas Yeganeh <soheil@google.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

