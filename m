Return-Path: <netdev+bounces-146373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7BD9D3256
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 04:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E393283918
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 03:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E56B2BD11;
	Wed, 20 Nov 2024 03:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="f9K4M1x5"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838E73C3C;
	Wed, 20 Nov 2024 03:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732071713; cv=none; b=iWsiBmTainSfZV/NCZ5o37RzcD/hxjdnXrF5R16z44YmQptgoqlF3G/v2vE47lZABIw8V4kvTfznPQehbqF4mUD3Karry393SBmNRLBF3LONNn8yiMZ8vDEsVzN+pEJLfz6WsbfJnOTbuXoURSc8Vdcd6/jMCNhkuWcgLCtqzsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732071713; c=relaxed/simple;
	bh=Vfsrf6Yb0Mlj84T3QFclVGgHS8qm2HBNnNREGwGCi28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xx2VOon08MapkfSl82cEm6kKIrGyXV6iiOEH0ZFSWYrjcO1DEcWMQkjtsmY1PuR59Dsw4d3wGvuFI7lBdM5wYeCCY1PIvuwmkEBujcuqp0wlsLx03TRzSmnP8/DvEHFLSonduEoFWZwPm8AZNKmuxTufVWQWbQPXdtdErLIc7S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=f9K4M1x5; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=SQambRT+eqU+XyR92PsS1euMdksf3+gQcD6V+DPXmVc=; b=f9K4M1x5fYPgFYc781683KXvI9
	mf1XpMlHQ3inqaK7nCQnk6mpk1ylfi7/3PHvdX5TZCZWlr5v+5RvQbDYaqnoKqMTZfbxF4dWKkTBa
	7GxAnIOWLZnJJY+j4StKeyJZJoB5LQcgwrj6uMUgpeZ0fdxMZ5sJ2vnntI/bWUgg531ApSbK7JYmf
	UD5O1R76gChXZXfQmkJTbtLMxkzziC/E/AM7dcIYNYKDKkdPgx0/zuLb12ZXbm5ZejoISMcgUN4bV
	/q1YMxRA6r4Lqv5pfoA1DiC4PN6xEEGV5+KNPjgOnmZwHNae61p152IQloIo7EKQO9lFCOxa9zvZT
	S06AYCgw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tDay8-000PN0-1h;
	Wed, 20 Nov 2024 11:01:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 20 Nov 2024 11:01:28 +0800
Date: Wed, 20 Nov 2024 11:01:28 +0800
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
Message-ID: <Zz1RCAT9Ao5PsAAK@gondor.apana.org.au>
References: <20241118-netpoll_rcu-v1-0-a1888dcb4a02@debian.org>
 <20241118-netpoll_rcu-v1-1-a1888dcb4a02@debian.org>
 <ZzwF4QdNch_UzMlV@gondor.apana.org.au>
 <20241119-magnetic-striped-pig-bcffa9@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119-magnetic-striped-pig-bcffa9@leitao>

On Tue, Nov 19, 2024 at 02:22:06AM -0800, Breno Leitao wrote:
>
> I looked about rcu_dereference_protected() as well, and I though it is
> used when you are de-referencing the pointer, which is a more expensive
> approach.  In the code above, the code basically need to check if the
> pointer is assigned or not. Looking at the code, it seems that having
> rcu_access_pointer() inside the update lock seems a common pattern, than
> that is what I chose.

No, rcu_dereference_protected is actually cheaper than rcu_access_pointer:

#define __rcu_access_pointer(p, local, space) \
({ \
        typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
        rcu_check_sparse(p, space); \
        ((typeof(*p) __force __kernel *)(local)); \
})

#define __rcu_dereference_protected(p, local, c, space) \
({ \
        RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
        rcu_check_sparse(p, space); \
        ((typeof(*p) __force __kernel *)(p)); \
})

> On the other side, I understand we want to call an RCU primitive with
> the _protected() context, so, I looked for a possible
> `rcu_access_pointer_protected()`, but this best does not exist. Anyway,
> I am happy to change it, if it is the correct API.

There is no need for rcu_access_pointer_protected because the
rcu_dereference_protected helper is already the cheapest.

> When 8fdd95ec162a was created, npinfo was an RCU pointer, although
> without the RCU annotation that came later (5fbee843c).  That is
> reason I chose to fix 8fdd95ec162a.

The code was correct as is without RCU markings.  The only reason
we need the RCU markings is because an __rcu tag was added to the
variable later, without also making the necessary changes in the
existing code using that variable.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

