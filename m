Return-Path: <netdev+bounces-146089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8DE9D1ED6
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC5FB20FCA
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E39145348;
	Tue, 19 Nov 2024 03:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Tl/mqQSV"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F92130E58;
	Tue, 19 Nov 2024 03:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731986948; cv=none; b=QL6by83IwPSKWdBMcOCx5R/01HfKiPFQKLEBKa/bM3onrJ9T+sHWNU5mgTI0T5owhlJiyhfhKlcO+BQne+NX9oVjJWxcEAaCOeK2gsDTLQvnDwh9WSHAIUS93LJEvHfhwCOdqWMdqOdFvPhahIt0SijmqS4TXZ849SDsUjB6Kr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731986948; c=relaxed/simple;
	bh=QhOPYXHuylfKCFT8U3rPMevT0XG7el/tUqoCECRTpPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cq1S7DcDCDRQE8WLpCmJ5ekvt0utWt89EXBlvv+9X/S87gfWk+BJEoTt2j+mkSNFO+CYSWnU4w9TP3ueQPfs5KgAe8oOHxb0xnOjitSWe/LIBvkfOq2Ty9RhrIfBe94lQyQJt7BiGsc3p2ja7JOof2cuvNNyV8SWxrdFoqm/bWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Tl/mqQSV; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=q9W3U24TXVWbYXGHn3zuZlcOT4JnAb/iSajlkff0QQA=; b=Tl/mqQSVs63KdLpZWe7/V/xd5T
	FxfwEIrWuGukBARqGS+cQM0Vy7/ED28o4RwXpHg37oOaTTx1DA9S/d79H5lwMjd+UtgC4F8x4q4sp
	4wqx3nHopEZXnD/0duvx7Y53g4jO/UKBpApIu1WSCw6Ir1HmJZs6cjTWpL8aRFig5cWXbTlzxt+hT
	lHKRROfampjCgkrD+qHfQDNlbDfAFDZThbVYW3VgOdU7rC1OWsK4yxZABFDeJWAlMEiNdzjpfDGGK
	WIuIoJMcWBc4zBAUxNJQTqfNJM8eyTT5pv2jxzlx5m1Hf7RAy8m27NXg5XP/x4eLnVIHTJJmbf9tK
	N3lNP2kg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tDEun-000Au3-0n;
	Tue, 19 Nov 2024 11:28:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 19 Nov 2024 11:28:33 +0800
Date: Tue, 19 Nov 2024 11:28:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH net 1/2] netpoll: Use rcu_access_pointer() in
 __netpoll_setup
Message-ID: <ZzwF4QdNch_UzMlV@gondor.apana.org.au>
References: <20241118-netpoll_rcu-v1-0-a1888dcb4a02@debian.org>
 <20241118-netpoll_rcu-v1-1-a1888dcb4a02@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118-netpoll_rcu-v1-1-a1888dcb4a02@debian.org>

On Mon, Nov 18, 2024 at 03:15:17AM -0800, Breno Leitao wrote:
> The ndev->npinfo pointer in __netpoll_setup() is RCU-protected but is being
> accessed directly for a NULL check. While no RCU read lock is held in this
> context, we should still use proper RCU primitives for consistency and
> correctness.
> 
> Replace the direct NULL check with rcu_access_pointer(), which is the
> appropriate primitive when only checking for NULL without dereferencing
> the pointer. This function provides the necessary ordering guarantees
> without requiring RCU read-side protection.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: 8fdd95ec162a ("netpoll: Allow netpoll_setup/cleanup recursion")
> ---
>  net/core/netpoll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index aa49b92e9194babab17b2e039daf092a524c5b88..45fb60bc4803958eb07d4038028269fc0c19622e 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -626,7 +626,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
>  		goto out;
>  	}
>  
> -	if (!ndev->npinfo) {
> +	if (!rcu_access_pointer(ndev->npinfo)) {
>  		npinfo = kmalloc(sizeof(*npinfo), GFP_KERNEL);
>  		if (!npinfo) {
>  			err = -ENOMEM;

This is completely bogus.  Think about it, we are setting ndev->npinfo,
meaning that we must have some form of synchronisation over this that
guarantees us to be the only writer.

So why does it need RCU protection for reading?

Assuming that this code isn't completely bonkers, then the correct
primitive to use should be rcu_dereference_protected.  Also the
Fixes header should be set to the commit that introduced the broken
RCU marking:

commit 5fbee843c32e5de2d8af68ba0bdd113bb0af9d86
Author: Cong Wang <amwang@redhat.com>
Date:   Tue Jan 22 21:29:39 2013 +0000

    netpoll: add RCU annotation to npinfo field

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

