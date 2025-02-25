Return-Path: <netdev+bounces-169328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04058A437A0
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC1727A313E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 08:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDACF1A9B58;
	Tue, 25 Feb 2025 08:28:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE820152196
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472119; cv=none; b=eJNbt5Tj/qqFxjc6/mmt3sYNFuqkOddjNUnlYU3u5lS/hY/ezWuJYdym9wl0h3KRO2BDdH5cY2rsA+22WiuJrlreqTBU0955+U+Qmek2vcXvGuiSJTN0KGj0l1HhxuvhsFPZMN9duuDqd2ZPTWVfHZp2fxJrw/LDtXvOY8bAyqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472119; c=relaxed/simple;
	bh=0k0+ATbCt0rbyk3lbL5feLNf2G/YTvdfRtZKf4LhTWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6xmbmVVYfAy2W+CTDeObNX9ZUeGw7WNeI/y3ewwhZaUJVGQ6L5JTBZmVDjN9I/E3Z6Kxtwis2uQk0AIYObDug7SclfHIC1KYZ2y5CHDVxIl65JIMcpYl9uaWUTaMUnx3NnBTSURTd5uupqkghaVqd0anugeKuhhnKT+8c3brzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1tmqIq-0001to-56; Tue, 25 Feb 2025 09:28:32 +0100
Date: Tue, 25 Feb 2025 09:28:32 +0100
From: Florian Westphal <fw@strlen.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au
Subject: Re: [PATCH ipsec-next] xfrm: remove hash table alloc/free helpers
Message-ID: <20250225082832.GA6982@breakpoint.cc>
References: <20250224171055.15951-1-fw@strlen.de>
 <20250225080440.GE53094@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225080440.GE53094@unreal>
User-Agent: Mutt/1.10.1 (2018-07-13)

Leon Romanovsky <leon@kernel.org> wrote:
> > xfrm_hash_free() is kept around because of 'struct hlist_head *' arg type
> > instead of 'void *'.
> 
> <...>
> 
> > -struct hlist_head *xfrm_hash_alloc(unsigned int sz);
> > -void xfrm_hash_free(struct hlist_head *n, unsigned int sz);
> > +static inline struct hlist_head *xfrm_hash_alloc(unsigned int sz)
> > +{
> > +	return kvzalloc(sz, GFP_KERNEL);
> > +}
> >  
> > +static inline void xfrm_hash_free(struct hlist_head *n)
> > +{
> > +	kvfree(n);
> > +}
> 
> Sorry, what does this wrapper give us?
> You are passing pointer as is and there is no any pointer type check
> that this construction will give us.

Compiler will warn when the argument is something other than a pointer
to a hlist_head.

I can send a v2 with this wrapper removed if you don't think its worth it.

Thanks for reviewing.

